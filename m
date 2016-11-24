From: Jochen Rollwagen <joro-2013-zqRNUXuvxA0b1SvskN2V4Q@public.gmane.org>
Subject: [PATCH] xf86-video-ati: Fix build for xserver < 1.13
Date: Thu, 24 Nov 2016 19:00:58 +0100
Message-ID: <58372ADA.8040009@t-online.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------040009000409020300090101"
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
--------------040009000409020300090101
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit

Subject: [PATCH] fix build for xserver < 1.13

same procedure every few patches.....
---
  src/radeon_kms.c |    6 +++++-
  1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/src/radeon_kms.c b/src/radeon_kms.c
index a5943d1..ec099c9 100644
--- a/src/radeon_kms.c
+++ b/src/radeon_kms.c
@@ -360,7 +360,11 @@ static Bool 
RADEONCreateScreenResources_KMS(ScreenPtr pScre
en)
      radeon_glamor_create_screen_resources(pScreen);

      info->callback_event_type = -1;
-    if (!pScreen->isGPU && (damage_ext = CheckExtension("DAMAGE"))) {
+    if (
+#ifdef RADEON_PIXMAP_SHARING
+        !pScreen->isGPU &&
+#endif
+        (damage_ext = CheckExtension("DAMAGE"))) {
      info->callback_event_type = damage_ext->eventBase + XDamageNotify;

      if (!AddCallback(&FlushCallback, radeon_flush_callback, pScrn))
-- 
1.7.9.5


--------------040009000409020300090101
Content-Type: text/x-patch;
 name="0001-fix-build-for-xserver-1.13.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="0001-fix-build-for-xserver-1.13.patch"

>From d3bf43ba5ca62dc2409b58cb4f79efe387bf891f Mon Sep 17 00:00:00 2001
From: Jochen Rollwagen <joro-2013-zqRNUXuvxA0b1SvskN2V4Q@public.gmane.org>
Date: Thu, 24 Nov 2016 18:44:01 +0100
Subject: [PATCH] fix build for xserver < 1.13

same procedure every few patches.....
---
 src/radeon_kms.c |    6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/src/radeon_kms.c b/src/radeon_kms.c
index a5943d1..ec099c9 100644
--- a/src/radeon_kms.c
+++ b/src/radeon_kms.c
@@ -360,7 +360,11 @@ static Bool RADEONCreateScreenResources_KMS(ScreenPtr pScreen)
 	radeon_glamor_create_screen_resources(pScreen);
 
     info->callback_event_type = -1;
-    if (!pScreen->isGPU && (damage_ext = CheckExtension("DAMAGE"))) {
+    if (
+#ifdef RADEON_PIXMAP_SHARING
+	    !pScreen->isGPU &&
+#endif    
+    	(damage_ext = CheckExtension("DAMAGE"))) {
 	info->callback_event_type = damage_ext->eventBase + XDamageNotify;
 
 	if (!AddCallback(&FlushCallback, radeon_flush_callback, pScrn))
-- 
1.7.9.5


--------------040009000409020300090101
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--------------040009000409020300090101--
