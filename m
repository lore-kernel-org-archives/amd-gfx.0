From: Jochen Rollwagen <joro-2013-zqRNUXuvxA0b1SvskN2V4Q@public.gmane.org>
Subject: [PATCH] Fix RadeonCopyData bpp=2 case for big-endian
Date: Fri, 4 Nov 2016 09:21:40 +0100
Message-ID: <581C4514.2040806@t-online.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------080403050005090306000905"
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/amd-gfx>,
 <mailto:amd-gfx-request-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
List-Help: <mailto:amd-gfx-request-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org?subject=subscribe>
Errors-To: amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Sender: "amd-gfx" <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
To: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org

This is a multi-part message in MIME format.
--------------080403050005090306000905
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit

 From 66b8b1513464aa3258ae6a024fcaea7a02e2def0 Mon Sep 17 00:00:00 2001
From: Jochen Rollwagen <joro-2013-zqRNUXuvxA0b1SvskN2V4Q@public.gmane.org>
Date: Fri, 4 Nov 2016 09:11:38 +0100
Subject: [PATCH] Fix RadeonCopyData bpp=2 case for big-endian

The current code in RadeonCopyData blocks the bpp=2 case setting 
swappiness to RADEON_HOST_DATA_SWAP_16BIT.
This patch fixes this.
---
  src/radeon_video.c |   10 ++--------
  1 file changed, 2 insertions(+), 8 deletions(-)

diff --git a/src/radeon_video.c b/src/radeon_video.c
index d058986..2de0b48 100644
--- a/src/radeon_video.c
+++ b/src/radeon_video.c
@@ -198,15 +198,10 @@ RADEONCopyData(
    unsigned int w,
    unsigned int bpp
  ){
-    /* Get the byte-swapping right for big endian systems */
-    if ( bpp == 2 ) {
-    w *= 2;
-    bpp = 1;
-    }
-
-    {
      int swap = RADEON_HOST_DATA_SWAP_NONE;

+    /* Get the byte-swapping right for big endian systems */
+
  #if X_BYTE_ORDER == X_BIG_ENDIAN
      switch(bpp) {
      case 2:
@@ -229,7 +224,6 @@ RADEONCopyData(
          dst += dstPitch;
          }
      }
-    }
  }


-- 
1.7.9.5


--------------080403050005090306000905
Content-Type: text/x-patch;
 name="0001-Fix-RadeonCopyData-bpp-2-case-for-big-endian.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="0001-Fix-RadeonCopyData-bpp-2-case-for-big-endian.patch"

>From 66b8b1513464aa3258ae6a024fcaea7a02e2def0 Mon Sep 17 00:00:00 2001
From: Jochen Rollwagen <joro-2013-zqRNUXuvxA0b1SvskN2V4Q@public.gmane.org>
Date: Fri, 4 Nov 2016 09:11:38 +0100
Subject: [PATCH] Fix RadeonCopyData bpp=2 case for big-endian

The current code in RadeonCopyData blocks the bpp=2 case setting swappiness to RADEON_HOST_DATA_SWAP_16BIT.
This patch fixes this.
---
 src/radeon_video.c |   10 ++--------
 1 file changed, 2 insertions(+), 8 deletions(-)

diff --git a/src/radeon_video.c b/src/radeon_video.c
index d058986..2de0b48 100644
--- a/src/radeon_video.c
+++ b/src/radeon_video.c
@@ -198,15 +198,10 @@ RADEONCopyData(
   unsigned int w,
   unsigned int bpp
 ){
-    /* Get the byte-swapping right for big endian systems */
-    if ( bpp == 2 ) {
-	w *= 2;
-	bpp = 1;
-    }
-
-    {
 	int swap = RADEON_HOST_DATA_SWAP_NONE;
 
+    /* Get the byte-swapping right for big endian systems */
+    
 #if X_BYTE_ORDER == X_BIG_ENDIAN
 	switch(bpp) {
 	case 2:
@@ -229,7 +224,6 @@ RADEONCopyData(
 		dst += dstPitch;
 	    }
 	}
-    }
 }
 
 
-- 
1.7.9.5


--------------080403050005090306000905
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--------------080403050005090306000905--
