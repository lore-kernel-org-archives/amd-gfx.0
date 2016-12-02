From: Jochen Rollwagen <joro-2013-zqRNUXuvxA0b1SvskN2V4Q@public.gmane.org>
Subject: [PATCH xf86-video-ati] Calculate log base 2 in radeon.h based on clz
 for all platforms
Date: Fri, 2 Dec 2016 11:07:02 +0100
Message-ID: <584147C6.8000004@t-online.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------060606080109020805020002"
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
--------------060606080109020805020002
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit

This commit replaces the inline assembler code (for x86 platforms) and 
loop (for non-x86 platforms) in RADEONLog2 with a one-liner version 
based on clz (count leading zeroes).
---
  src/radeon.h |   13 +------------
  1 file changed, 1 insertion(+), 12 deletions(-)

diff --git a/src/radeon.h b/src/radeon.h
index 5797bed..23ecfeb 100644
--- a/src/radeon.h
+++ b/src/radeon.h
@@ -935,18 +935,7 @@ enum {
  static __inline__ int
  RADEONLog2(int val)
  {
-    int bits;
-#if (defined __i386__ || defined __x86_64__) && (defined __GNUC__)
-    __asm volatile("bsrl    %1, %0"
-        : "=r" (bits)
-        : "c" (val)
-    );
-    return bits;
-#else
-    for (bits = 0; val != 0; val >>= 1, ++bits)
-        ;
-    return bits - 1;
-#endif
+    return (31 - __builtin_clz(val));
  }

  #define RADEON_TILING_MASK                0xff
-- 
1.7.9.5


--------------060606080109020805020002
Content-Type: text/x-patch;
 name="0001-Calculate-log-base-2-in-radeon.h-based-on-clz-for-al.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename*0="0001-Calculate-log-base-2-in-radeon.h-based-on-clz-for-al.pa";
 filename*1="tch"

>From 350d663a5ce85d51632a6fa56d28afa2447c6558 Mon Sep 17 00:00:00 2001
From: Jochen Rollwagen <joro-2013-zqRNUXuvxA0b1SvskN2V4Q@public.gmane.org>
Date: Fri, 2 Dec 2016 10:56:39 +0100
Subject: [PATCH] Calculate log base 2 in radeon.h based on clz for all
 platforms

This commit replaces the inline assembler code (for x86 platforms) and loop (for non-x86 platforms) in RADEONLog2 with a one-liner version based on clz (count leading zeroes).
---
 src/radeon.h |   13 +------------
 1 file changed, 1 insertion(+), 12 deletions(-)

diff --git a/src/radeon.h b/src/radeon.h
index 5797bed..23ecfeb 100644
--- a/src/radeon.h
+++ b/src/radeon.h
@@ -935,18 +935,7 @@ enum {
 static __inline__ int
 RADEONLog2(int val)
 {
-	int bits;
-#if (defined __i386__ || defined __x86_64__) && (defined __GNUC__)
-	__asm volatile("bsrl	%1, %0"
-		: "=r" (bits)
-		: "c" (val)
-	);
-	return bits;
-#else
-	for (bits = 0; val != 0; val >>= 1, ++bits)
-		;
-	return bits - 1;
-#endif
+	return (31 - __builtin_clz(val));
 }
 
 #define RADEON_TILING_MASK				0xff
-- 
1.7.9.5


--------------060606080109020805020002
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--------------060606080109020805020002--
