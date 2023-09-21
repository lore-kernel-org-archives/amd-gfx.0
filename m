Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 736A2E7107F
	for <amd-gfx@archiver.kernel.org>; Thu, 21 Sep 2023 14:34:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2CEEF10E5E5;
	Thu, 21 Sep 2023 14:34:50 +0000 (UTC)
X-Greylist: delayed 583 seconds by postgrey-1.36 at gabe;
 Thu, 21 Sep 2023 14:25:10 UTC
Received: from galois.linutronix.de (Galois.linutronix.de
 [IPv6:2a0a:51c0:0:12e:550::1])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E2C2D10E5C9
 for <amd-gfx@lists.freedesktop.org>; Thu, 21 Sep 2023 14:25:10 +0000 (UTC)
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
 s=2020; t=1695305725;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=sVGBlAnrz6UmtRjv0t+ZHRq3KiWMNmFKvIlfE1mXOc0=;
 b=NBrV6T0NWs4HKzSdAAji57rmWnzTpkb3H4ynAlflPDBpnoJVaYCFOCJR7JAtYs7xCKlw1O
 aHOiVXEJIRgQlJDHIj9X63fyESExpsAqAphAq8JZBF7fM4dvSNrq9dfj68R3UTg7Pj4gHS
 dYecNrlPSYLk5WHvLGCKx7+THlfL9SA1jFN1PcCBnBXY/7TD43OPOkNJ27jJhY3uElIOwD
 sAJZLCMeiX84HlySp39rlzMx+oS3HmNbqAyBKKXD2Cyz5VmVcYjRX5gIQXN24M+LAvFBRx
 DGPpvETrFskDDAQ/l21MKpZiMXwbkmK6dzoDzKJkND5mqSeiYQu/APfhpIgNcw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
 s=2020e; t=1695305725;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=sVGBlAnrz6UmtRjv0t+ZHRq3KiWMNmFKvIlfE1mXOc0=;
 b=F0m9BVTlImsDc20k/SwfKtjeER2Q8iQ551xbjpO/Bc45kt7ZLyR0obyRHla6Qcv/v8WqR4
 vhKrQAG6v4348rCA==
To: dri-devel@lists.freedesktop.org,
	amd-gfx@lists.freedesktop.org
Subject: [PATCH 2/5] drm/amd/display: Simplify the per-CPU usage.
Date: Thu, 21 Sep 2023 16:15:13 +0200
Message-Id: <20230921141516.520471-3-bigeasy@linutronix.de>
In-Reply-To: <20230921141516.520471-1-bigeasy@linutronix.de>
References: <20230921141516.520471-1-bigeasy@linutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Thu, 21 Sep 2023 14:34:42 +0000
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Cc: Leo Li <sunpeng.li@amd.com>, David Airlie <airlied@gmail.com>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>, "Pan,
 Xinhui" <Xinhui.Pan@amd.com>, Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
 Peter Zijlstra <peterz@infradead.org>, Daniel Vetter <daniel@ffwll.ch>,
 Alex Deucher <alexander.deucher@amd.com>, Thomas Gleixner <tglx@linutronix.de>,
 Harry Wentland <harry.wentland@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

The fpu_recursion_depth counter is used to ensure that dc_fpu_begin()
can be invoked multiple times while the FPU-disable function itself is
only invoked once. Also the counter part (dc_fpu_end()) is ballanced
properly.

Instead of using the get_cpu_ptr() dance around the inc it is simpler to
increment the per-CPU variable directly. Also the per-CPU variable has
to be incremented and decremented on the same CPU. This is ensured by
the inner-part which disables preemption. This is kind of not obvious,
works and the preempt-counter is touched a few times for no reason.

Disable preemption before incrementing fpu_recursion_depth for the first
time. Keep preemption disabled until dc_fpu_end() where the counter is
decremented making it obvious that the preemption has to stay disabled
while the counter is non-zero.
Use simple inc/dec functions.
Remove the nested preempt_disable/enable functions which are now not
needed.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 .../gpu/drm/amd/display/amdgpu_dm/dc_fpu.c    | 50 ++++++++-----------
 1 file changed, 20 insertions(+), 30 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/dc_fpu.c b/drivers/gpu/d=
rm/amd/display/amdgpu_dm/dc_fpu.c
index 86f4c0e046548..8bd5926b47e06 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/dc_fpu.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/dc_fpu.c
@@ -60,11 +60,9 @@ static DEFINE_PER_CPU(int, fpu_recursion_depth);
  */
 inline void dc_assert_fp_enabled(void)
 {
-	int *pcpu, depth =3D 0;
+	int depth;
=20
-	pcpu =3D get_cpu_ptr(&fpu_recursion_depth);
-	depth =3D *pcpu;
-	put_cpu_ptr(&fpu_recursion_depth);
+	depth =3D __this_cpu_read(fpu_recursion_depth);
=20
 	ASSERT(depth >=3D 1);
 }
@@ -84,32 +82,27 @@ inline void dc_assert_fp_enabled(void)
  */
 void dc_fpu_begin(const char *function_name, const int line)
 {
-	int *pcpu;
+	int depth;
=20
-	pcpu =3D get_cpu_ptr(&fpu_recursion_depth);
-	*pcpu +=3D 1;
+	preempt_disable();
+	depth =3D __this_cpu_inc_return(fpu_recursion_depth);
=20
-	if (*pcpu =3D=3D 1) {
+	if (depth =3D=3D 1) {
 #if defined(CONFIG_X86) || defined(CONFIG_LOONGARCH)
 		kernel_fpu_begin();
 #elif defined(CONFIG_PPC64)
-		if (cpu_has_feature(CPU_FTR_VSX_COMP)) {
-			preempt_disable();
+		if (cpu_has_feature(CPU_FTR_VSX_COMP))
 			enable_kernel_vsx();
-		} else if (cpu_has_feature(CPU_FTR_ALTIVEC_COMP)) {
-			preempt_disable();
+		else if (cpu_has_feature(CPU_FTR_ALTIVEC_COMP))
 			enable_kernel_altivec();
-		} else if (!cpu_has_feature(CPU_FTR_FPU_UNAVAILABLE)) {
-			preempt_disable();
+		else if (!cpu_has_feature(CPU_FTR_FPU_UNAVAILABLE))
 			enable_kernel_fp();
-		}
 #elif defined(CONFIG_ARM64)
 		kernel_neon_begin();
 #endif
 	}
=20
-	TRACE_DCN_FPU(true, function_name, line, *pcpu);
-	put_cpu_ptr(&fpu_recursion_depth);
+	TRACE_DCN_FPU(true, function_name, line, depth);
 }
=20
 /**
@@ -124,29 +117,26 @@ void dc_fpu_begin(const char *function_name, const in=
t line)
  */
 void dc_fpu_end(const char *function_name, const int line)
 {
-	int *pcpu;
+	int depth;
=20
-	pcpu =3D get_cpu_ptr(&fpu_recursion_depth);
-	*pcpu -=3D 1;
-	if (*pcpu <=3D 0) {
+	depth =3D __this_cpu_dec_return(fpu_recursion_depth);
+	if (depth =3D=3D 0) {
 #if defined(CONFIG_X86) || defined(CONFIG_LOONGARCH)
 		kernel_fpu_end();
 #elif defined(CONFIG_PPC64)
-		if (cpu_has_feature(CPU_FTR_VSX_COMP)) {
+		if (cpu_has_feature(CPU_FTR_VSX_COMP))
 			disable_kernel_vsx();
-			preempt_enable();
-		} else if (cpu_has_feature(CPU_FTR_ALTIVEC_COMP)) {
+		else if (cpu_has_feature(CPU_FTR_ALTIVEC_COMP))
 			disable_kernel_altivec();
-			preempt_enable();
-		} else if (!cpu_has_feature(CPU_FTR_FPU_UNAVAILABLE)) {
+		else if (!cpu_has_feature(CPU_FTR_FPU_UNAVAILABLE))
 			disable_kernel_fp();
-			preempt_enable();
-		}
 #elif defined(CONFIG_ARM64)
 		kernel_neon_end();
 #endif
+	} else {
+		WARN_ON_ONCE(depth < 0);
 	}
=20
-	TRACE_DCN_FPU(false, function_name, line, *pcpu);
-	put_cpu_ptr(&fpu_recursion_depth);
+	TRACE_DCN_FPU(false, function_name, line, depth);
+	preempt_enable();
 }
--=20
2.40.1

