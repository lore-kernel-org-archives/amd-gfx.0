From: Jochen Rollwagen <joro-2013-zqRNUXuvxA0b1SvskN2V4Q@public.gmane.org>
Subject: [PATCH xf86-video-ati] Fix build for XServer 1.13
Date: Sun, 5 Mar 2017 11:38:47 +0100
Message-ID: <58BBEAB7.60606@t-online.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------020907070908080208080007"
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
--------------020907070908080208080007
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit

Latest git build stops with the error message

radeon_kms.c: In function 'RADEONWindowExposures_oneshot':
radeon_kms.c:1644:45: error: expected expression before 'RegionPtr'
      pScreen->WindowExposures(pWin, pRegion, RegionPtr pBSRegion);

This patch fixes the build.
---
  src/radeon_kms.c |    2 +-
  1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/src/radeon_kms.c b/src/radeon_kms.c
index 572dfcc..7a561fa 100644
--- a/src/radeon_kms.c
+++ b/src/radeon_kms.c
@@ -1641,7 +1641,7 @@ static void 
RADEONWindowExposures_oneshot(WindowPtr pWin, RegionPtr pRegion

      pScreen->WindowExposures = info->WindowExposures;
  #if XORG_VERSION_CURRENT < XORG_VERSION_NUMERIC(1,16,99,901,0)
-    pScreen->WindowExposures(pWin, pRegion, RegionPtr pBSRegion);
+    pScreen->WindowExposures(pWin, pRegion, pBSRegion);
  #else
      pScreen->WindowExposures(pWin, pRegion);
  #endif
-- 
1.7.9.5


--------------020907070908080208080007
Content-Type: text/x-patch;
 name="0001-Fix-build-for-XServer-1.13.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="0001-Fix-build-for-XServer-1.13.patch"

>From 8246f1af42cd174501c95c0ba5c00908ace41de9 Mon Sep 17 00:00:00 2001
From: Jochen Rollwagen <joro-2013-zqRNUXuvxA0b1SvskN2V4Q@public.gmane.org>
Date: Sun, 5 Mar 2017 11:32:38 +0100
Subject: [PATCH xf86-video-ati] Fix build for XServer 1.13

Latest git build stops with the error message

radeon_kms.c: In function 'RADEONWindowExposures_oneshot':
radeon_kms.c:1644:45: error: expected expression before 'RegionPtr'
     pScreen->WindowExposures(pWin, pRegion, RegionPtr pBSRegion);

This patch fixes the build.
---
 src/radeon_kms.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/src/radeon_kms.c b/src/radeon_kms.c
index 572dfcc..7a561fa 100644
--- a/src/radeon_kms.c
+++ b/src/radeon_kms.c
@@ -1641,7 +1641,7 @@ static void RADEONWindowExposures_oneshot(WindowPtr pWin, RegionPtr pRegion
 
     pScreen->WindowExposures = info->WindowExposures;
 #if XORG_VERSION_CURRENT < XORG_VERSION_NUMERIC(1,16,99,901,0)
-    pScreen->WindowExposures(pWin, pRegion, RegionPtr pBSRegion);
+    pScreen->WindowExposures(pWin, pRegion, pBSRegion);
 #else
     pScreen->WindowExposures(pWin, pRegion);
 #endif
-- 
1.7.9.5


--------------020907070908080208080007
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--------------020907070908080208080007--
