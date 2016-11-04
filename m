From: Jochen Rollwagen <joro-2013-zqRNUXuvxA0b1SvskN2V4Q@public.gmane.org>
Subject: [PATCH] Remove RADEON_HOST_DATA_SWAP_HDW case from RadeonCopySwap
Date: Fri, 4 Nov 2016 09:23:09 +0100
Message-ID: <581C456D.7010707@t-online.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------060503030806010704020805"
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
--------------060503030806010704020805
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit

 From ba45efaafc3cf790c44b905d2f6272ef7830b403 Mon Sep 17 00:00:00 2001
From: Jochen Rollwagen <joro-2013-zqRNUXuvxA0b1SvskN2V4Q@public.gmane.org>
Date: Fri, 4 Nov 2016 08:39:30 +0100
Subject: [PATCH] Remove RADEON_HOST_DATA_SWAP_HDW case from RadeonCopySwap

RadeonCopySwap is never called with swap=RADEON_HOST_DATA_SWAP_HDW. 
Remove the case from the switch for clarity.
---
  src/radeon_accel.c |   10 ----------
  1 file changed, 10 deletions(-)

diff --git a/src/radeon_accel.c b/src/radeon_accel.c
index 1def2a3..af2fc99 100644
--- a/src/radeon_accel.c
+++ b/src/radeon_accel.c
@@ -131,16 +131,6 @@ int radeon_cs_space_remaining(ScrnInfoPtr pScrn)
  void RADEONCopySwap(uint8_t *dst, uint8_t *src, unsigned int size, int 
swap)
  {
      switch(swap) {
-    case RADEON_HOST_DATA_SWAP_HDW:
-        {
-        unsigned int *d = (unsigned int *)dst;
-        unsigned int *s = (unsigned int *)src;
-        unsigned int nwords = size >> 2;
-
-        for (; nwords > 0; --nwords, ++d, ++s)
-        *d = ((*s & 0xffff) << 16) | ((*s >> 16) & 0xffff);
-        return;
-        }
      case RADEON_HOST_DATA_SWAP_32BIT:
          {
          unsigned int *d = (unsigned int *)dst;
-- 
1.7.9.5



--------------060503030806010704020805
Content-Type: text/x-patch;
 name="0001-Remove-RADEON_HOST_DATA_SWAP_HDW-case-from-RadeonCop.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename*0="0001-Remove-RADEON_HOST_DATA_SWAP_HDW-case-from-RadeonCop.pa";
 filename*1="tch"

>From ba45efaafc3cf790c44b905d2f6272ef7830b403 Mon Sep 17 00:00:00 2001
From: Jochen Rollwagen <joro-2013-zqRNUXuvxA0b1SvskN2V4Q@public.gmane.org>
Date: Fri, 4 Nov 2016 08:39:30 +0100
Subject: [PATCH] Remove RADEON_HOST_DATA_SWAP_HDW case from RadeonCopySwap

RadeonCopySwap is never called with swap=RADEON_HOST_DATA_SWAP_HDW. Remove the case from the switch for clarity.
---
 src/radeon_accel.c |   10 ----------
 1 file changed, 10 deletions(-)

diff --git a/src/radeon_accel.c b/src/radeon_accel.c
index 1def2a3..af2fc99 100644
--- a/src/radeon_accel.c
+++ b/src/radeon_accel.c
@@ -131,16 +131,6 @@ int radeon_cs_space_remaining(ScrnInfoPtr pScrn)
 void RADEONCopySwap(uint8_t *dst, uint8_t *src, unsigned int size, int swap)
 {
     switch(swap) {
-    case RADEON_HOST_DATA_SWAP_HDW:
-        {
-	    unsigned int *d = (unsigned int *)dst;
-	    unsigned int *s = (unsigned int *)src;
-	    unsigned int nwords = size >> 2;
-
-	    for (; nwords > 0; --nwords, ++d, ++s)
-		*d = ((*s & 0xffff) << 16) | ((*s >> 16) & 0xffff);
-	    return;
-        }
     case RADEON_HOST_DATA_SWAP_32BIT:
         {
 	    unsigned int *d = (unsigned int *)dst;
-- 
1.7.9.5


--------------060503030806010704020805
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--------------060503030806010704020805--
