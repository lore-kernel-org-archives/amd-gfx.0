Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D36B3FF885A
	for <amd-gfx@archiver.kernel.org>; Mon,  4 May 2026 20:19:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5F8ED10E85C;
	Mon,  4 May 2026 20:19:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="ZiMzlx8S";
	dkim-atps=neutral
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com
 [209.85.208.171])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E3AC610E00A
 for <amd-gfx@lists.freedesktop.org>; Mon,  4 May 2026 20:19:12 +0000 (UTC)
Received: by mail-lj1-f171.google.com with SMTP id
 38308e7fff4ca-39393c1b5aaso17710351fa.3
 for <amd-gfx@lists.freedesktop.org>; Mon, 04 May 2026 13:19:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1777925951; x=1778530751; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=0tOD8/6djJ4pMyTuanqYIEyAgeWg4xBI8A3+BKBgiYE=;
 b=ZiMzlx8SAeCj7wNk8aXTUAlS7tOcVnIs0fd15/6bFm4JaXAcat04BkO73yYYkCbFT1
 nDhy3sP0kUn0adHU2fZVh14Ucd5iQrdFbC5Fv6OJZZ6pIIvHGd0jPhzAQePx/kR0iVsZ
 2RcEqz/9yss/8CNMgcNWZ9EAqybd4ExrqmmDiLv7bdTRYkO9qbuFcAcEWIxBDOd+is48
 c7enJdrSOaZXc/Rq41ZKlgsqVr97tknb13YzV2PXLh0UAvQW7tdrrYrQfzOYYo7xa3Zr
 lQT1yuKI5DSVt0UT3JAFM8PnhC76IUkDZ6RF2WRl+lvzQ8zFgxVyostAj44fC2IHwYhU
 lw5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777925951; x=1778530751;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0tOD8/6djJ4pMyTuanqYIEyAgeWg4xBI8A3+BKBgiYE=;
 b=nDNcIHYtJAbJVsmVJ7WgEd/pgxqPwhIct/DIuaOw6Xt77K1RFDMHShBtvLyfnSa5Oy
 zHUR6I3YX3JM+TczrjwETFpuHifWu5pC/igLhJGEB5Bmu8nE1Gm+8MOkanNeENfpu9Bl
 OrWes7LiVJJDaPYl/yyczyybx1Tavk+WkwVbZ0tLOubIvlcbnfJ2WMFZiiYm0aeb4rrs
 sZfCDNXSvlQr3qVacD0PYhXKFsi5BqeZHlxKCPdp3Pa+eyFKarEmfkx/qeyrJ3V8tUbu
 w7Pkc0r58O6OFZ0iGNmTHJAHEViPiaovCba3KWnl9Sw3ofhynv3qnhff9tGY3ruIKJua
 M8QQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ+yuRbRIuCftPHtkAMYNuTz9eq680mTMDwjvHmbx2yYPseRxdkilduFouWbLYG7rNgFZ5SgLYKw@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwqqoU2/KZ7O9s7PjUMg128lHTS+/hRR/aHY2wZJMx9sE89MIxd
 SXdnCNqkyQppwHFSyLP+evJYWdb/gEeh6s/8iIZ5+zicp5sByH9LlBue
X-Gm-Gg: AeBDietnoOLg9pvfGHecLCePVpbWm0f1gi3QtlSscChOMG60PPPnc1+q+gufT5TEbko
 itRchr4FnpXTQt14GqhB9gI4yxfgORJGrFbO3+6DlYqZbhoaHoe7WmsthnuLUDMVgzHYiXJnUFQ
 Wt/w+p5UWXL/X/ZDQfXRFYfvWj6hHEI/ian+nUvJQ8LYvFLRXLuCnnvMPyfG4PnKBDAXhzH7pzO
 oHT1RScarz2MTjoOWFptp0SGoighoCP+X8zHLUmSJZpACT6JKKoS755UluLNZ1ih8LKH9wJEiVH
 w0g552LzyIMuZK47f2M5kIlV+UehVhoICF29U6yEV4Im0VYk4LFt6jiBigQnCijrp6IlMVW8q12
 Nii3BNKLDDM4+YtFJybK+sceMnm7gf9OfifeD972y5t6Ko1Jz9N0TNlvis8mpxn/L6VpJQ17KSw
 jrDva8KfXUl5CmNYZRASAeplXEhrNk7w+d9xkrpL5s5CZl
X-Received: by 2002:a05:6512:3f02:b0:5a4:175d:21a with SMTP id
 2adb3069b0e04-5a862ec2566mr3851306e87.2.1777925950756; 
 Mon, 04 May 2026 13:19:10 -0700 (PDT)
Received: from localhost ([188.234.148.119]) by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5a85c230c68sm3245638e87.19.2026.05.04.13.19.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 May 2026 13:19:10 -0700 (PDT)
From: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
To: harry.wentland@amd.com, sunpeng.li@amd.com, alexander.deucher@amd.com,
 christian.koenig@amd.com
Cc: siqueira@igalia.com, airlied@gmail.com, simona@ffwll.ch, ardb@kernel.org,
 hamza.mahfooz@amd.com, aurabindo.pillai@amd.com, Roman.Li@amd.com,
 amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org,
 Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
Subject: [PATCH] drm/amd/display: Wrap DCN32 phantom-plane allocation in
 DC_RUN_WITH_PREEMPTION_ENABLED
Date: Tue,  5 May 2026 01:19:05 +0500
Message-ID: <20260504201905.90667-1-mikhail.v.gavrilov@gmail.com>
X-Mailer: git-send-email 2.54.0
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

dcn32_validate_bandwidth() wraps dcn32_internal_validate_bw() with
DC_FP_START()/DC_FP_END(). On x86 non-RT, DC_FP_START expands into
kernel_fpu_begin() which takes fpregs_lock(), i.e. local_bh_disable().
Allocations done inside this region must therefore not sleep.

The legacy DML1 path through dcn32_full_validate_bw_helper() ->
dcn32_add_phantom_pipes() -> dcn32_enable_phantom_plane() unconditionally
calls dc_state_create_phantom_plane() -> dc_create_plane_state(), which
performs kvzalloc(sizeof(struct dc_plane_state)). On a recent kernel
sizeof(struct dc_plane_state) is 343736 bytes (335 KiB), well above the
PAGE_ALLOC_COSTLY_ORDER threshold, so __kvmalloc_node() takes the vmalloc
path. __get_vm_area_node() then trips its BUG_ON(in_interrupt()) because
SOFTIRQ_DISABLE_OFFSET is set in preempt_count:

  kernel BUG at mm/vmalloc.c:3206!
  RIP: __get_vm_area_node+0x257/0x2d0
  Workqueue: events_unbound commit_work
  Call Trace:
   __vmalloc_node_range_noprof+0x22b/0x570
   __kvmalloc_node_noprof+0x3d0/0xb40
   dc_create_plane_state+0x35/0x290 [amdgpu]
   dc_state_create_phantom_plane+0x1a/0x120 [amdgpu]
   dcn32_enable_phantom_plane+0x101/0x780 [amdgpu]
   dcn32_add_phantom_pipes+0x47/0x460 [amdgpu]
   dcn32_full_validate_bw_helper.constprop.0+0xa46/0x1d70 [amdgpu]
   dcn32_internal_validate_bw+0x49c/0x1600 [amdgpu]
   dml1_validate+0x20f/0x800 [amdgpu]
   dcn32_validate_bandwidth+0x317/0x540 [amdgpu]
   dc_validate_with_context+0xd34/0x1d30 [amdgpu]
   dc_commit_streams+0x7ca/0x1810 [amdgpu]
   amdgpu_dm_commit_streams+0xfd4/0x1e60 [amdgpu]
   amdgpu_dm_atomic_commit_tail+0x29e/0x3520 [amdgpu]
   commit_tail+0x204/0x4b0
   process_one_work+0x8fd/0x16a0

Per-CPU __preempt_count on the crashing CPU at panic time was 0x202:
SOFTIRQ_DISABLE_OFFSET (0x200) from fpregs_lock() plus two preempt holds
from dc_fpu_begin() and kernel_fpu_begin().

The DML2 paths already wrap their large vzalloc()s in
DC_RUN_WITH_PREEMPTION_ENABLED() to handle this case (see
drivers/gpu/drm/amd/display/dc/dml2_0/dml21/dml21_wrapper.c:26 and
drivers/gpu/drm/amd/display/dc/dml2_0/dml2_wrapper.c:24). Apply the same
guard to the DML1 phantom-plane allocation in dcn32_enable_phantom_plane().

This is a separate class of issue from "drm/amd/display: Fix unsafe uses
of kernel mode FPU" by Ard Biesheuvel, which addressed callers entering
DC FP compilation units without DC_FP_START. The bug fixed here is the
inverse: a sleeping allocator invoked from within an active DC_FP_START
region.

Reproducer (RX 7900 XTX, single 4K HDMI display, DCN 3.2): launch any
workload that produces rapid atomic modeset commits. The most reliable
trigger observed is launching Rise of the Tomb Raider via Proton and
repeatedly pressing the Super key during the level loading screen;
crash occurs within ~4 minutes uptime. Random crashes are also observed
during routine fullscreen toggles (image viewers, chat applications).

Hardware verified clean: memtest86+ 4 passes, stressapptest -W -m 32
4 hours, both pass with 0 errors. KASAN active, no reports under load.

Fixes: 235c67634230 ("drm/amd/display: add DCN32/321 specific files for Display Core")
Cc: stable@vger.kernel.org # v6.0+
Signed-off-by: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
---
 .../drm/amd/display/dc/resource/dcn32/dcn32_resource.c    | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn32/dcn32_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dcn32/dcn32_resource.c
index 82f81b586986..3751f7a94a05 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dcn32/dcn32_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn32/dcn32_resource.c
@@ -92,9 +92,14 @@
 #include "dml/dcn32/dcn32_fpu.h"
 
 #include "dc_state_priv.h"
+#include "dc_fpu.h"
 
 #include "dml2_0/dml2_wrapper.h"
 
+#if !defined(DC_RUN_WITH_PREEMPTION_ENABLED)
+#define DC_RUN_WITH_PREEMPTION_ENABLED(code) code
+#endif
+
 #define DC_LOGGER_INIT(logger)
 
 enum dcn32_clk_src_array_id {
@@ -1684,7 +1689,8 @@ static void dcn32_enable_phantom_plane(struct dc *dc,
 		if (curr_pipe->top_pipe && curr_pipe->top_pipe->plane_state == curr_pipe->plane_state)
 			phantom_plane = prev_phantom_plane;
 		else
-			phantom_plane = dc_state_create_phantom_plane(dc, context, curr_pipe->plane_state);
+			DC_RUN_WITH_PREEMPTION_ENABLED(phantom_plane =
+				dc_state_create_phantom_plane(dc, context, curr_pipe->plane_state));
 
 		if (!phantom_plane)
 			continue;
-- 
2.54.0

