Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0DD43C54FD2
	for <amd-gfx@archiver.kernel.org>; Thu, 30 Jul 2026 06:53:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9D13C10EDC8;
	Thu, 30 Jul 2026 06:53:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="RAJ54dwM";
	dkim-atps=neutral
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com
 [209.85.167.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1C33E10EDC8
 for <amd-gfx@lists.freedesktop.org>; Thu, 30 Jul 2026 06:53:11 +0000 (UTC)
Received: by mail-lf1-f52.google.com with SMTP id
 2adb3069b0e04-5b0148201fbso1650133e87.3
 for <amd-gfx@lists.freedesktop.org>; Wed, 29 Jul 2026 23:53:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1785394389; x=1785999189; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=XRuFZ6h1uhegR6Sr4/10z/GSPpr/uGFR1omQDwMWmUQ=;
 b=RAJ54dwMr/ctZM1g7PDNY4IyzqeWSToKZKsyHRIqg8CtNmiA5zzv/4kC0halMFH+VH
 gkw4rYhqewiYlVRKxp9/6H6ZXOtFYxCSAJPmZ/pyTScH+8T0O4DJ/1V7VVQGfK74RAZY
 y+nVGgxzrQOuZEXO0Y+bTQOOnWStAAG29Tyq05++0ShN5kEZVEfeHBGvJo51mp8fBIW8
 6PbDCTw0vsTgr+Tp2gfNVK+dtj8vORnDgBpMyBtuATNCzUf9wgT/LWuORpjXulX0ftqz
 tNhmyRurR+IU37SvgvyNqxukh4/KDdN+G2Fll0Ggqf0eu5Jttf1DdW+Wr8zk5+nVlBAZ
 gq8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785394389; x=1785999189;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=XRuFZ6h1uhegR6Sr4/10z/GSPpr/uGFR1omQDwMWmUQ=;
 b=nwlXdtb7baAljMANoOlU8Zs8VVjc8Mmsb+wp064FwovP7EWlplb8lBAzDYf08YfI9p
 ZL1S40mNjh+qI71gxz76S+r7wD/nzQDnh1OiW/P7Kqkrr4CguVcv3IRuQnsCALtDx4NN
 0UFzhw6p4xCf8J9bh+7Y1oggXvqJ/D4ar4JZeoAEgq7UaoygJmr5mVKfGipCsoTSudVu
 XrtY1XXh9ZQUYQxG/gcM52/D9VhUWmewtoLPkZttlxNLHjJzP1aWHyPFfjTp4gLXKY1F
 pQjFls5hA+Km/f1fXHgVeLyMDHjOMgeeParRbVb5ubsjedROszNLZZ+m6RSGBfViLor1
 Ti3g==
X-Gm-Message-State: AOJu0YwrNiU159dREwdKScQ5Df/PgoDmDNtFa3MLlhAZb2FTB0u+ZWV2
 ETBJ8nWNPJnmLwSexuLITM+9SVohiO2IKphlGzjLt2EhXV/svl9qftdk09Bg6XHofwu1ag==
X-Gm-Gg: AR+sD12XgZpjJP5xRF1a0SRULFNy68U9gY2pH/FHO4U2dsojfvkz5jY9B7LP7IcROtp
 o2qC0cy50lB+sInimXPGeksHkNENdqPlJ63DSqx0m6xNIJqPAGzWo7sJI9f+QfjAh2QJ5VcsVjU
 uEavzbwtZqxlZnavDam9+avk0Xg57kKH5OqE0g0YF2kOqKOmRqljfnDrB/+T3jvMFrUsAYvSGUH
 I7veEtfP07sqm0yBU8FhWi+0KlB6uMEJgz+/vL3MoWHGV9R6+YTebVBwNogjRGUq/fp8Bz7xVi7
 I+oEh/ateotERsYk/npyPZGPF0WEqpF5CaOoox7m+09ArSTtSd6N8DTtwHKBg9vJjiVz8As7ct8
 yxFxiqSmLEJgUkukJChhen7c6CQ2ybtRm3eFmaHSahj7xCatLTBFIMV7tevObYOv4GTEiJjhCPW
 SZlh5ZqqoiFBospGsbo57+0uNNyQgbhKYjbnIlkwSf8AFnx0Tp2GEq7RZUh1cqNKKQR7ypR7flv
 M4JgUoV2qI=
X-Received: by 2002:a05:6512:2245:b0:5ae:c239:6a2c with SMTP id
 2adb3069b0e04-5b2db380b43mr251021e87.53.1785394388845; 
 Wed, 29 Jul 2026 23:53:08 -0700 (PDT)
Received: from localhost ([188.234.148.119]) by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-39f6ac5ea80sm1635701fa.26.2026.07.29.23.53.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 Jul 2026 23:53:07 -0700 (PDT)
From: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
To: amd-gfx@lists.freedesktop.org
Cc: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Rodrigo Siqueira <siqueira@igalia.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Alex Hung <alex.hung@amd.com>, Rafal Ostrowski <rafal.ostrowski@amd.com>,
 Dillon Varone <dillon.varone@amd.com>, Bert Karwatzki <spasswolf@web.de>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Clark Williams <clrkwllms@kernel.org>,
 Steven Rostedt <rostedt@goodmis.org>, linux-rt-devel@lists.linux.dev,
 linux-kernel@vger.kernel.org,
 Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
Subject: [PATCH] drm/amd/display: make DC_RUN_WITH_PREEMPTION_ENABLED misuse a
 build error
Date: Thu, 30 Jul 2026 11:53:00 +0500
Message-ID: <20260730065300.2056809-1-mikhail.v.gavrilov@gmail.com>
X-Mailer: git-send-email 2.55.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Inside an FPU compilation unit DC_FP_START() and DC_FP_END() are defined
as BUILD_BUG(), so using them there fails the build.  That was done on
purpose by
commit a574f53ed52e ("drm/amd/display: Permit DC_FP_START/END only in non-FP compilation units").

DC_RUN_WITH_PREEMPTION_ENABLED() was added later by
commit 3539437f354b ("drm/amd/display: Move FPU Guards From DML To DC - Part 1")
and defined as a plain pass-through in that same branch instead.  A wrap
placed inside an FPU compilation unit therefore compiles cleanly, reads
as correct during review, and does nothing at all.

This is not hypothetical.  While chasing a "scheduling while atomic"
splat in dc_create_plane_state() on PREEMPT_RT, an attempt to place the
guard further up the call chain, in dml21_add_phantom_plane() in
dc/dml2_0/dml21/dml21_utils.c, had no effect for exactly this reason:
dc/dml2_0/Makefile applies CC_FLAGS_FPU to every object under that
directory, and the top level Makefile adds -D_LINUX_FPU_COMPILATION_UNIT
to CC_FLAGS_FPU.

Define the macro as BUILD_BUG() there as well, so that the mistake is a
compile error rather than a guard that silently does nothing.  The code
argument is kept in the expansion so the BUILD_BUG() failure is not
accompanied by set-but-unused diagnostics for variables assigned inside
it.

No current user is affected.  dc/core/dc_stream.c and
dc/resource/dcn32/dcn32_resource.c are outside the dml directories, and
dc/dml2_0/dml2_wrapper.c and dc/dml2_0/dml21/dml21_wrapper.c are built
without the FPU flags because dc/dml2_0/Makefile replaces their CFLAGS
with CC_FLAGS_NO_FPU and removes CC_FLAGS_FPU.

Link: https://lore.kernel.org/all/1ead313022bc62dce1f42af9f855727eb9074443.camel@web.de/
Signed-off-by: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
---

This is a build-time change, so there is nothing to reproduce at
runtime.  Verified in both directions on x86_64 with
CONFIG_DRM_AMD_DC_FP=y, by adding
 
	DC_RUN_WITH_PREEMPTION_ENABLED((void)0);
 
to dcn10_resource_construct_fp() in dc/dml/dcn10/dcn10_fpu.c, which is
compiled with CC_FLAGS_FPU and already includes dc_fpu.h.
 
Without the patch 'make drivers/gpu/drm/amd/amdgpu/' compiles that file
and the whole module links, so the guard is silently ineffective.  With
the patch the build stops there:
 
  dcn10_fpu.c: In function 'dcn10_resource_construct_fp':
  include/linux/compiler_types.h:702:45: error: call to
    '__compiletime_assert_524' declared with attribute error: BUILD_BUG failed
  dc_fpu.h:56:17: note: in expansion of macro 'BUILD_BUG'
  dcn10_fpu.c:129:9: note: in expansion of macro 'DC_RUN_WITH_PREEMPTION_ENABLED'
 
No set-but-unused diagnostics accompany it.  Removing the added line
builds cleanly again.

 drivers/gpu/drm/amd/display/amdgpu_dm/dc_fpu.h | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/dc_fpu.h b/drivers/gpu/drm/amd/display/amdgpu_dm/dc_fpu.h
index 5e95419d3798..e89b39a4aa83 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/dc_fpu.h
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/dc_fpu.h
@@ -51,7 +51,11 @@ void dc_fpu_end(const char *function_name, const int line);
 #else
 #define DC_FP_START()	BUILD_BUG()
 #define DC_FP_END()	BUILD_BUG()
-#define DC_RUN_WITH_PREEMPTION_ENABLED(code) code
+#define DC_RUN_WITH_PREEMPTION_ENABLED(code) \
+	do { \
+		BUILD_BUG(); \
+		code; \
+	} while (0)
 #endif // !_LINUX_FPU_COMPILATION_UNIT
 
 #endif /* __DC_FPU_H__ */
-- 
2.55.0

