From: Jochen Rollwagen <joro-2013-zqRNUXuvxA0b1SvskN2V4Q@public.gmane.org>
Subject: [PATCH xf86-video-ati] Replace loop with clz to calculate log base 2
 on non-x86 platforms in radeon.h
Date: Mon, 28 Nov 2016 19:18:02 +0100
Message-ID: <583C74DA.2070701@t-online.de>
References: <58372ADA.8040009@t-online.de>
 <dd911a26-9976-6570-f5ac-5efe67e27928@daenzer.net>
 <58380BA2.3060006@t-online.de>
 <f3c04cd0-06b0-85c4-48d0-1bfbdd98dfdf@daenzer.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------050703080302010506090609"
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <f3c04cd0-06b0-85c4-48d0-1bfbdd98dfdf-otUistvHUpPR7s880joybQ@public.gmane.org>
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
--------------050703080302010506090609
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit

This commit replaces the loop for calculating log base 2 for 
non-x86-platforms in radeon.h with a clz (count leading zeroes)-based 
version to simplify the code and, well, eliminate the loop.
Note: There’s no check for val=0 case, since x86-bsr is undefined for 
that case too, that should be okay.
---
  src/radeon.h |    7 +++----
  1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/src/radeon.h b/src/radeon.h
index cbc7866..b1a1ce0 100644
--- a/src/radeon.h
+++ b/src/radeon.h
@@ -933,17 +933,16 @@ enum {
  static __inline__ int
  RADEONLog2(int val)
  {
-    int bits;
  #if (defined __i386__ || defined __x86_64__) && (defined __GNUC__)
+    int bits;
+
      __asm volatile("bsrl    %1, %0"
          : "=r" (bits)
          : "c" (val)
      );
      return bits;
  #else
-    for (bits = 0; val != 0; val >>= 1, ++bits)
-        ;
-    return bits - 1;
+    return (31 - __builtin_clz(val));
  #endif
  }

-- 
1.7.9.5


--------------050703080302010506090609
Content-Type: text/x-patch;
 name="0001-Replace-loop-with-clz-to-calculate-log-base-2-on-non.patch"
Content-Transfer-Encoding: 8bit
Content-Disposition: attachment;
 filename*0="0001-Replace-loop-with-clz-to-calculate-log-base-2-on-non.pa";
 filename*1="tch"

>From d39f7a0d42fcc423030cd73bff8afe6d39d13e80 Mon Sep 17 00:00:00 2001
From: Jochen Rollwagen <joro-2013-zqRNUXuvxA0b1SvskN2V4Q@public.gmane.org>
Date: Mon, 28 Nov 2016 19:02:13 +0100
Subject: [PATCH] Replace loop with clz to calculate log base 2 on non-x86
 platforms in radeon.h
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

This commit replaces the loop for calculating log base 2 for non-x86-platforms in radeon.h with a clz (count leading zeroes)-based version to simplify the code and, well, eliminate the loop.
Note: There’s no check for val=0 case, since x86-bsr is undefined for that case too, that should be okay.
---
 src/radeon.h |    7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/src/radeon.h b/src/radeon.h
index cbc7866..b1a1ce0 100644
--- a/src/radeon.h
+++ b/src/radeon.h
@@ -933,17 +933,16 @@ enum {
 static __inline__ int
 RADEONLog2(int val)
 {
-	int bits;
 #if (defined __i386__ || defined __x86_64__) && (defined __GNUC__)
+	int bits;
+	
 	__asm volatile("bsrl	%1, %0"
 		: "=r" (bits)
 		: "c" (val)
 	);
 	return bits;
 #else
-	for (bits = 0; val != 0; val >>= 1, ++bits)
-		;
-	return bits - 1;
+	return (31 - __builtin_clz(val));
 #endif
 }
 
-- 
1.7.9.5


--------------050703080302010506090609
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--------------050703080302010506090609--
