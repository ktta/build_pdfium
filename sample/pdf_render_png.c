#include <fpdfview.h>
#include <stdlib.h>
#include <unistd.h>
#include <stdio.h>
#include "lodepng.h"

void pdf_print_error(char *msg, int quit)
{
  long err;
  fprintf(stderr,"%s:", msg);
  switch ((err=FPDF_GetLastError())) {
    case FPDF_ERR_SUCCESS:
      fprintf(stderr, "Success");
      break;
    case FPDF_ERR_UNKNOWN:
      fprintf(stderr, "Unknown error");
      break;
    case FPDF_ERR_FILE:
      fprintf(stderr, "File not found or could not be opened");
      break;
    case FPDF_ERR_FORMAT:
      fprintf(stderr, "File not in PDF format or corrupted");
      break;
    case FPDF_ERR_PASSWORD:
      fprintf(stderr, "Password required or incorrect password");
      break;
    case FPDF_ERR_SECURITY:
      fprintf(stderr, "Unsupported security scheme");
      break;
    case FPDF_ERR_PAGE:
      fprintf(stderr, "Page not found or content error");
      break;
    default:
      fprintf(stderr, "Unknown error %ld", err);
  }
  fprintf(stderr,".\n");
  if (quit) exit(1);
}


int main(int argc, char **argv)
{
  FPDF_LIBRARY_CONFIG config;
  FPDF_DOCUMENT doc;
  FPDF_PAGE page;
  FPDF_BITMAP bmp;

  int reqpage, pagecount, rv, pe;
  float w_points, h_points, resolution;
  int w_pixels, h_pixels;
  unsigned char *data;

  rv= 1;

  if (argc!=5)
  {
    fprintf(stderr,"usage: %s input.pdf page_number resolution output.png\n",
                    argv[0]);
    goto close_prg;
  }

  config.version = 2;
  config.m_pUserFontPaths = NULL;
  config.m_pIsolate = NULL;
  config.m_v8EmbedderSlot = 0;
  FPDF_InitLibraryWithConfig(&config);

  doc = FPDF_LoadDocument(argv[1], NULL);
  if (!doc) 
  {
    pdf_print_error("Error loading document", 0);
    goto close_lib;
  }

  reqpage= atoi(argv[2]);
  pagecount= FPDF_GetPageCount(doc);
  if (reqpage<0 || reqpage>=pagecount)
  {
    fprintf(stderr,"bad requested page= %d, number of pages= %d\n",
                    reqpage, pagecount);
    goto close_doc;
  }

  page= FPDF_LoadPage(doc, reqpage);
  if (!page)
  {
    pdf_print_error("Error loading page",0);
    goto close_doc;
  }

  w_points= FPDF_GetPageWidthF(page);
  h_points= FPDF_GetPageHeightF(page);

  resolution= strtof(argv[3], NULL);

  w_pixels= w_points/72.0 * resolution;
  h_pixels= h_points/72.0 * resolution;

  bmp= FPDFBitmap_CreateEx(w_pixels, h_pixels, FPDFBitmap_BGRx, NULL, 0);
  if (!bmp)
  {
    pdf_print_error("Error creating bitmap",0);
    goto close_page;
  }

  FPDFBitmap_FillRect(bmp, 0, 0, w_pixels, h_pixels, 0xFFffFFff);
  FPDF_RenderPageBitmap(bmp, page, 0,0, w_pixels, h_pixels, 0, 0);
  data= FPDFBitmap_GetBuffer(bmp);
  if (!data) 
  {
    pdf_print_error("Error getting buffer",0);
    goto close_bitmap;
  }

  // fill in all the alpha values, and also swap B and R
  for(int i=0, npix=w_pixels*h_pixels;i<npix;i++) 
  {
    unsigned char t;
    t= data[i*4];
    data[i*4]= data[i*4+2];
    data[i*4+2]= t;
    data[i*4+3]= 0xff;
  }
  pe= lodepng_encode32_file(argv[4], data, w_pixels, h_pixels);
  if (pe)
  {
    fprintf(stderr,"PNG encoding error: %s.\n", lodepng_error_text(pe));
    goto close_bitmap;
  }
  rv= 0;
close_bitmap:
  FPDFBitmap_Destroy(bmp);
close_page:
  FPDF_ClosePage(page); 
close_doc:
  FPDF_CloseDocument(doc);
close_lib:
  FPDF_DestroyLibrary();
close_prg:
  return rv;
}
