Return-Path: <SRS0=+jgF=7O=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B995C433E3
	for <amd-gfx@archiver.kernel.org>; Mon,  1 Jun 2020 18:30:19 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D3F7F2074B
	for <amd-gfx@archiver.kernel.org>; Mon,  1 Jun 2020 18:30:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ej4ciTuv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D3F7F2074B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D96886E9EA;
	Mon,  1 Jun 2020 18:30:17 +0000 (UTC)
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com
 [IPv6:2607:f8b0:4864:20::742])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F1CA46E9E9
 for <amd-gfx@lists.freedesktop.org>; Mon,  1 Jun 2020 18:30:15 +0000 (UTC)
Received: by mail-qk1-x742.google.com with SMTP id c12so9989204qkk.13
 for <amd-gfx@lists.freedesktop.org>; Mon, 01 Jun 2020 11:30:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=TZsDRdRmvRq4xBsGrMbCVs0LClXXgaM98dkZmKhhLDc=;
 b=ej4ciTuvIKrbaz1TTtj4OUB9pL/ApR0blOgtoRp9yRdh9KHo6adxjIAUybDLCtKYED
 uVayhTyuBHOKu3mh1kr2ltds7fdeH/OGd/aEU1BTJ5+UIB5te6E+eyRC60w0CxzKc86c
 MJQbCEVffXOO/eJMVNFR6jspLglN8xmrLSR8lJIqT6xf3DgNkuZaO7UYWbtdXF4LoADy
 jKXuVeEOIJx/mPokuOK/hQnOFitTg31h69oNNR9W0lRmHO6trwkJFGA3O9mls2jKXUvT
 uNo8rAuDeGiUXv6wPOi50NmWbMLaKQS+OBbfDB/FjWXfOJ75pMf14U2KTboetjHou4/5
 1T6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=TZsDRdRmvRq4xBsGrMbCVs0LClXXgaM98dkZmKhhLDc=;
 b=oH2xIgcVW73CcuGFV3svOYRPtfUtbFMctuyC6OXYj9kZ5cDCeuKk+ijglTFrL4ZuWy
 Ml4hhCaDMLokVzGgyzBu4TygT+dBZ0ccwX8tli1d0auykSHsWZRpC/JUpzcumM+fDV3J
 fIYUbebqVTgjPXoWoqyYuVObV0aKMqn0DXSbcALyftfJR6s+AEKb0krR5YD6b8fTYE6P
 Ml9tW3NehrCEKhLoW9OP+yAeSO94Kztt/1GiPrjXMPckHz6JtQ2MEfEX2CCdb76gMaYd
 rFGXfs3gwP1FLYd5c/vP6tuPPBOu/uYnkqCvK/6pFWrSQrDVQH9v2ujx8lOZtsTFixXb
 4srg==
X-Gm-Message-State: AOAM533fJ8ybtZlswTqvPXfKJpaLiuX0+Kobqg62tc/6L0blPz9z/JDo
 MnwtoGFu9tXsqVVEquoY+J3UxohI
X-Google-Smtp-Source: ABdhPJxWhdFCeJd1l8R4HsaQGseLbMytvbRngWrhTDX/Ea2sWpzhpd3iV9Sdp+J751UFbzpYChyLFg==
X-Received: by 2002:a37:a648:: with SMTP id p69mr21566522qke.190.1591036214726; 
 Mon, 01 Jun 2020 11:30:14 -0700 (PDT)
Received: from tr4.amd.com (atlvpn.amd.com. [165.204.84.11])
 by smtp.gmail.com with ESMTPSA id z194sm8592qkb.73.2020.06.01.11.30.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 01 Jun 2020 11:30:13 -0700 (PDT)
From: Alex Deucher <alexdeucher@gmail.com>
X-Google-Original-From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 201/207] drm/amd/display: Init function tables for DCN3
Date: Mon,  1 Jun 2020 14:29:20 -0400
Message-Id: <20200601182926.1267958-23-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20200601182926.1267958-1-alexander.deucher@amd.com>
References: <20200601182926.1267958-1-alexander.deucher@amd.com>
MIME-Version: 1.0
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
Cc: Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>

Initilize function tables for hw programing

Signed-off-by: Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>
---
 .../gpu/drm/amd/display/dc/dcn30/dcn30_init.c | 148 ++++++++++++++++++
 .../gpu/drm/amd/display/dc/dcn30/dcn30_init.h |  33 ++++
 2 files changed, 181 insertions(+)
 create mode 100644 drivers/gpu/drm/amd/display/dc/dcn30/dcn30_init.c
 create mode 100644 drivers/gpu/drm/amd/display/dc/dcn30/dcn30_init.h

diff --git a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_init.c b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_init.c
new file mode 100644
index 000000000000..5ba7b5354de8
--- /dev/null
+++ b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_init.c
@@ -0,0 +1,148 @@
+/*
+ * Copyright 2020 Advanced Micro Devices, Inc.
+ *
+ * Permission is hereby granted, free of charge, to any person obtaining a
+ * copy of this software and associated documentation files (the "Software"),
+ * to deal in the Software without restriction, including without limitation
+ * the rights to use, copy, modify, merge, publish, distribute, sublicense,
+ * and/or sell copies of the Software, and to permit persons to whom the
+ * Software is furnished to do so, subject to the following conditions:
+ *
+ * The above copyright notice and this permission notice shall be included in
+ * all copies or substantial portions of the Software.
+ *
+ * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
+ * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
+ * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL
+ * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM, DAMAGES OR
+ * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
+ * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
+ * OTHER DEALINGS IN THE SOFTWARE.
+ *
+ * Authors: AMD
+ *
+ */
+
+#include "dce110/dce110_hw_sequencer.h"
+#include "dcn10/dcn10_hw_sequencer.h"
+#include "dcn20/dcn20_hwseq.h"
+#include "dcn30_hwseq.h"
+
+static const struct hw_sequencer_funcs dcn30_funcs = {
+	.program_gamut_remap = dcn10_program_gamut_remap,
+	.init_hw = dcn10_init_hw,
+	.apply_ctx_to_hw = dce110_apply_ctx_to_hw,
+	.apply_ctx_for_surface = NULL,
+	.program_front_end_for_ctx = dcn20_program_front_end_for_ctx,
+	.post_unlock_program_front_end = dcn20_post_unlock_program_front_end,
+	.update_plane_addr = dcn20_update_plane_addr,
+	.update_dchub = dcn10_update_dchub,
+	.update_pending_status = dcn10_update_pending_status,
+	.program_output_csc = dcn20_program_output_csc,
+	.enable_accelerated_mode = dce110_enable_accelerated_mode,
+	.enable_timing_synchronization = dcn10_enable_timing_synchronization,
+	.enable_per_frame_crtc_position_reset = dcn10_enable_per_frame_crtc_position_reset,
+	.update_info_frame = dcn30_update_info_frame,
+	.send_immediate_sdp_message = dcn10_send_immediate_sdp_message,
+	.enable_stream = dcn20_enable_stream,
+	.disable_stream = dce110_disable_stream,
+	.unblank_stream = dcn20_unblank_stream,
+	.blank_stream = dce110_blank_stream,
+	.enable_audio_stream = dce110_enable_audio_stream,
+	.disable_audio_stream = dce110_disable_audio_stream,
+	.disable_plane = dcn20_disable_plane,
+	.pipe_control_lock = dcn20_pipe_control_lock,
+	.interdependent_update_lock = dcn10_lock_all_pipes,
+	.cursor_lock = dcn10_cursor_lock,
+	.prepare_bandwidth = dcn20_prepare_bandwidth,
+	.optimize_bandwidth = dcn20_optimize_bandwidth,
+	.update_bandwidth = dcn20_update_bandwidth,
+	.set_drr = dcn10_set_drr,
+	.get_position = dcn10_get_position,
+	.set_static_screen_control = dcn10_set_static_screen_control,
+	.setup_stereo = dcn10_setup_stereo,
+	.set_avmute = dcn30_set_avmute,
+	.log_hw_state = dcn10_log_hw_state,
+	.get_hw_state = dcn10_get_hw_state,
+	.clear_status_bits = dcn10_clear_status_bits,
+	.wait_for_mpcc_disconnect = dcn10_wait_for_mpcc_disconnect,
+	.edp_power_control = dce110_edp_power_control,
+	.edp_wait_for_hpd_ready = dce110_edp_wait_for_hpd_ready,
+	.set_cursor_position = dcn10_set_cursor_position,
+	.set_cursor_attribute = dcn10_set_cursor_attribute,
+	.set_cursor_sdr_white_level = dcn10_set_cursor_sdr_white_level,
+	.setup_periodic_interrupt = dcn10_setup_periodic_interrupt,
+	.set_clock = dcn10_set_clock,
+	.get_clock = dcn10_get_clock,
+	.program_triplebuffer = dcn20_program_triple_buffer,
+	.enable_writeback = dcn30_enable_writeback,
+	.disable_writeback = dcn30_disable_writeback,
+	.update_writeback = dcn30_update_writeback,
+	.mmhubbub_warmup = dcn30_mmhubbub_warmup,
+	.dmdata_status_done = dcn20_dmdata_status_done,
+	.program_dmdata_engine = dcn30_program_dmdata_engine,
+	.set_dmdata_attributes = dcn20_set_dmdata_attributes,
+	.init_sys_ctx = dcn20_init_sys_ctx,
+	.init_vm_ctx = dcn20_init_vm_ctx,
+	.set_flip_control_gsl = dcn20_set_flip_control_gsl,
+	.get_vupdate_offset_from_vsync = dcn10_get_vupdate_offset_from_vsync,
+	.apply_idle_power_optimizations = dcn30_apply_idle_power_optimizations,
+	.set_backlight_level = dce110_set_backlight_level,
+	.set_abm_immediate_disable = dce110_set_abm_immediate_disable,
+};
+
+static const struct hwseq_private_funcs dcn30_private_funcs = {
+	.init_pipes = dcn10_init_pipes,
+	.update_plane_addr = dcn20_update_plane_addr,
+	.plane_atomic_disconnect = dcn10_plane_atomic_disconnect,
+	.update_mpcc = dcn20_update_mpcc,
+	.set_input_transfer_func = dcn30_set_input_transfer_func,
+	.set_output_transfer_func = dcn30_set_output_transfer_func,
+	.power_down = dce110_power_down,
+	.enable_display_power_gating = dcn10_dummy_display_power_gating,
+	.blank_pixel_data = dcn20_blank_pixel_data,
+	.reset_hw_ctx_wrap = dcn20_reset_hw_ctx_wrap,
+	.enable_stream_timing = dcn20_enable_stream_timing,
+	.edp_backlight_control = dce110_edp_backlight_control,
+	.disable_stream_gating = dcn20_disable_stream_gating,
+	.enable_stream_gating = dcn20_enable_stream_gating,
+	.setup_vupdate_interrupt = dcn20_setup_vupdate_interrupt,
+	.did_underflow_occur = dcn10_did_underflow_occur,
+	.init_blank = dcn20_init_blank,
+	.disable_vga = dcn20_disable_vga,
+	.bios_golden_init = dcn10_bios_golden_init,
+	.plane_atomic_disable = dcn20_plane_atomic_disable,
+	.plane_atomic_power_down = dcn10_plane_atomic_power_down,
+	.enable_power_gating_plane = dcn20_enable_power_gating_plane,
+	.dpp_pg_control = dcn20_dpp_pg_control,
+	.hubp_pg_control = dcn20_hubp_pg_control,
+	.dsc_pg_control = NULL,
+	.program_all_writeback_pipes_in_tree = dcn30_program_all_writeback_pipes_in_tree,
+	.update_odm = dcn20_update_odm,
+	.dsc_pg_control = dcn20_dsc_pg_control,
+	.get_surface_visual_confirm_color = dcn10_get_surface_visual_confirm_color,
+	.get_hdr_visual_confirm_color = dcn10_get_hdr_visual_confirm_color,
+	.set_hdr_multiplier = dcn10_set_hdr_multiplier,
+	.verify_allow_pstate_change_high = dcn10_verify_allow_pstate_change_high,
+	.wait_for_blank_complete = dcn20_wait_for_blank_complete,
+	.dccg_init = dcn20_dccg_init,
+	.set_blend_lut = dcn30_set_blend_lut,
+	.set_shaper_3dlut = dcn20_set_shaper_3dlut,
+};
+
+void dcn30_hw_sequencer_construct(struct dc *dc)
+{
+	dc->hwss = dcn30_funcs;
+	dc->hwseq->funcs = dcn30_private_funcs;
+
+	if (IS_FPGA_MAXIMUS_DC(dc->ctx->dce_environment)) {
+		dc->hwss.init_hw = dcn20_fpga_init_hw;
+		dc->hwseq->funcs.init_pipes = NULL;
+	}
+
+	// TODO: Use generic dcn10_init_hw and dcn10_init_pipes sequence
+	if (!IS_FPGA_MAXIMUS_DC(dc->ctx->dce_environment)) {
+		dc->hwss.init_hw = dcn30_init_hw;
+		dc->hwseq->funcs.init_pipes = NULL;
+	}
+}
diff --git a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_init.h b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_init.h
new file mode 100644
index 000000000000..c280ff90bfa3
--- /dev/null
+++ b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_init.h
@@ -0,0 +1,33 @@
+/*
+ * Copyright 2020 Advanced Micro Devices, Inc.
+ *
+ * Permission is hereby granted, free of charge, to any person obtaining a
+ * copy of this software and associated documentation files (the "Software"),
+ * to deal in the Software without restriction, including without limitation
+ * the rights to use, copy, modify, merge, publish, distribute, sublicense,
+ * and/or sell copies of the Software, and to permit persons to whom the
+ * Software is furnished to do so, subject to the following conditions:
+ *
+ * The above copyright notice and this permission notice shall be included in
+ * all copies or substantial portions of the Software.
+ *
+ * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
+ * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
+ * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL
+ * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM, DAMAGES OR
+ * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
+ * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
+ * OTHER DEALINGS IN THE SOFTWARE.
+ *
+ * Authors: AMD
+ *
+ */
+
+#ifndef __DC_DCN30_INIT_H__
+#define __DC_DCN30_INIT_H__
+
+struct dc;
+
+void dcn30_hw_sequencer_construct(struct dc *dc);
+
+#endif /* __DC_DCN30_INIT_H__ */
-- 
2.25.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
