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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 723CAC433E1
	for <amd-gfx@archiver.kernel.org>; Mon,  1 Jun 2020 18:29:54 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 499252074B
	for <amd-gfx@archiver.kernel.org>; Mon,  1 Jun 2020 18:29:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rMNRk/i2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 499252074B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 126AC6E9D8;
	Mon,  1 Jun 2020 18:29:54 +0000 (UTC)
Received: from mail-qt1-x829.google.com (mail-qt1-x829.google.com
 [IPv6:2607:f8b0:4864:20::829])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 743726E9D9
 for <amd-gfx@lists.freedesktop.org>; Mon,  1 Jun 2020 18:29:52 +0000 (UTC)
Received: by mail-qt1-x829.google.com with SMTP id j32so8480745qte.10
 for <amd-gfx@lists.freedesktop.org>; Mon, 01 Jun 2020 11:29:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=UqG7DEtc2Xe/2c3TfcmVJSL36TCepdALAV0KSIAnJLQ=;
 b=rMNRk/i2zjCSCnV7Z2AY4b+iB6+aohYmTjVhOueE2jUXuXyPSfwGtGg4eiUqPiFNbj
 Ctq7Bzdf7AZgIYD2aoaDGEXYvsURhdgS71/8sM9NHq+1FM1rfKUHY9Ql8B8dNgBvIWl/
 jG4XYzm1XwKzbZcGcJ8wu7h1/IL7ncHlyjML8J1t3B0W2OMtd+gzwcUBtocOdSSdKcSz
 vpgj4OE7bDbnn39lq9/GWzyT5pmdzmj3dsmGo5PJIHW780GyXvwbmtkyppgQl42jw5yb
 qg5PJHJKsHcao7TtzId7NCX3TNy6FbQvM4vC6qtkUffhPwdK5om9LWc81NEBDYEXZtBr
 nifw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=UqG7DEtc2Xe/2c3TfcmVJSL36TCepdALAV0KSIAnJLQ=;
 b=Mf+nQcd+PaBeHnfEGhzIDDPj82/IF+3ScEr3tbVEngq9oF3zyBiCYnuVALGiZCKfH7
 x0iXVq/XgSBk1Zo8k7hDAs/OoQZIRFFLnPRx/eMl8vgWw2XeDgq8WuFX1JxtuAeQyNnO
 olmF8NxZoEh7slJGZ/HMQiaFmVVvDXIewGYAdwMVEQH53V/YMcPHdxeFwtVJq1CQHGV3
 ztCWCge8VYl2Gis8QJCCI1/Pe3q4cEIZyoN+07OcZ4G+GA4vu6UsHO39M2JInNJM+Mxf
 TpLWW7difs7/GuzDTqQOwna/8chFyWLvIP2i0GBoTVe7/dCUMuvRzV3MKDdy9vcjCErk
 g5hw==
X-Gm-Message-State: AOAM532cVWo/8xCd9H6k823SmMW1NdmSU0WfR3Qh3rfgTtWCGjLIBOqe
 4NxdantBq4Mxc3bmeMhmTT1c056u
X-Google-Smtp-Source: ABdhPJwTSmcxdwW9shFeqFbYwxnzG+io7caswQME+A2V2xXEohxlMPgIubmh2JmMuPWcRDrEDluUwA==
X-Received: by 2002:ac8:7111:: with SMTP id z17mr23603020qto.187.1591036191066; 
 Mon, 01 Jun 2020 11:29:51 -0700 (PDT)
Received: from tr4.amd.com (atlvpn.amd.com. [165.204.84.11])
 by smtp.gmail.com with ESMTPSA id z194sm8592qkb.73.2020.06.01.11.29.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 01 Jun 2020 11:29:50 -0700 (PDT)
From: Alex Deucher <alexdeucher@gmail.com>
X-Google-Original-From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 187/207] drm/amd/display: Add DCN3 HUBHUB
Date: Mon,  1 Jun 2020 14:29:06 -0400
Message-Id: <20200601182926.1267958-9-alexander.deucher@amd.com>
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

Add support to program the HUBBUB (DCN memory HUB interface)

HW Blocks:

 +--------+
 | HUBBUB |
 +--------+
        |
        v
    +--------+
    |  DPP   |
    +--------+
        |
        v
    +--------+
    |  MPC   |
    +--------+
        |
        v
    +-------+
    |  OPP  |
    +-------+
        |
        v
    +--------+
    |  OPTC  |
    +--------+
        |
        v
    +--------+       +--------+
    |  DIO   |       |  DCCG  |
    +--------+       +--------+

Signed-off-by: Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dc.h           |   9 +
 .../drm/amd/display/dc/dcn20/dcn20_hubbub.c   |   9 +
 .../drm/amd/display/dc/dcn30/dcn30_hubbub.c   | 417 ++++++++++++++++++
 .../drm/amd/display/dc/dcn30/dcn30_hubbub.h   | 119 +++++
 .../gpu/drm/amd/display/dc/inc/hw/dchubbub.h  |   6 +
 5 files changed, 560 insertions(+)
 create mode 100644 drivers/gpu/drm/amd/display/dc/dcn30/dcn30_hubbub.c
 create mode 100644 drivers/gpu/drm/amd/display/dc/dcn30/dcn30_hubbub.h

diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index 262da8a4b518..8bd9f1ca445c 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -186,6 +186,15 @@ struct dc_dcc_setting {
 	unsigned int max_compressed_blk_size;
 	unsigned int max_uncompressed_blk_size;
 	bool independent_64b_blks;
+#if defined(CONFIG_DRM_AMD_DC_DCN3_0)
+	//These bitfields to be used starting with DCN 3.0
+	struct {
+		uint32_t dcc_256_64_64 : 1;//available in ASICs before DCN 3.0 (the worst compression case)
+		uint32_t dcc_128_128_uncontrained : 1;  //available in ASICs before DCN 3.0
+		uint32_t dcc_256_128_128 : 1;		//available starting with DCN 3.0
+		uint32_t dcc_256_256_unconstrained : 1;  //available in ASICs before DCN 3.0 (the best compression case)
+	} dcc_controls;
+#endif
 };
 
 struct dc_surface_dcc_cap {
diff --git a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hubbub.c b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hubbub.c
index c0b21d7450d4..69d49551ab5d 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hubbub.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hubbub.c
@@ -153,6 +153,10 @@ bool hubbub2_dcc_support_pixel_format(
 	case SURFACE_PIXEL_FORMAT_GRPH_BGR101111_FIX:
 	case SURFACE_PIXEL_FORMAT_GRPH_RGB111110_FLOAT:
 	case SURFACE_PIXEL_FORMAT_GRPH_BGR101111_FLOAT:
+#if defined(CONFIG_DRM_AMD_DC_DCN3_0)
+	case SURFACE_PIXEL_FORMAT_GRPH_RGBE:
+	case SURFACE_PIXEL_FORMAT_GRPH_RGBE_ALPHA:
+#endif
 		*bytes_per_element = 4;
 		return true;
 	case SURFACE_PIXEL_FORMAT_GRPH_ARGB16161616:
@@ -339,6 +343,11 @@ static enum dcn_hubbub_page_table_block_size page_table_block_size_to_hw(unsigne
 	case 65536:
 		block_size = DCN_PAGE_TABLE_BLOCK_SIZE_64KB;
 		break;
+#if defined(CONFIG_DRM_AMD_DC_DCN3_0)
+	case 32768:
+		block_size = DCN_PAGE_TABLE_BLOCK_SIZE_32KB;
+		break;
+#endif
 	default:
 		ASSERT(false);
 		block_size = page_table_block_size;
diff --git a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_hubbub.c b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_hubbub.c
new file mode 100644
index 000000000000..982732dec133
--- /dev/null
+++ b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_hubbub.c
@@ -0,0 +1,417 @@
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
+
+#include "dm_services.h"
+#include "reg_helper.h"
+#include "dcn30_hubbub.h"
+
+
+#define CTX \
+	hubbub1->base.ctx
+#define DC_LOGGER \
+	hubbub1->base.ctx->logger
+#define REG(reg)\
+	hubbub1->regs->reg
+
+#undef FN
+#define FN(reg_name, field_name) \
+	hubbub1->shifts->field_name, hubbub1->masks->field_name
+
+#ifdef NUM_VMID
+#undef NUM_VMID
+#endif
+#define NUM_VMID 16
+
+
+static uint32_t convert_and_clamp(
+	uint32_t wm_ns,
+	uint32_t refclk_mhz,
+	uint32_t clamp_value)
+{
+	uint32_t ret_val = 0;
+	ret_val = wm_ns * refclk_mhz;
+	ret_val /= 1000;
+
+	if (ret_val > clamp_value)
+		ret_val = clamp_value;
+
+	return ret_val;
+}
+
+int hubbub3_init_dchub_sys_ctx(struct hubbub *hubbub,
+		struct dcn_hubbub_phys_addr_config *pa_config)
+{
+	struct dcn20_hubbub *hubbub1 = TO_DCN20_HUBBUB(hubbub);
+	struct dcn_vmid_page_table_config phys_config;
+
+	REG_SET(DCN_VM_FB_LOCATION_BASE, 0,
+			FB_BASE, pa_config->system_aperture.fb_base >> 24);
+	REG_SET(DCN_VM_FB_LOCATION_TOP, 0,
+			FB_TOP, pa_config->system_aperture.fb_top >> 24);
+	REG_SET(DCN_VM_FB_OFFSET, 0,
+			FB_OFFSET, pa_config->system_aperture.fb_offset >> 24);
+	REG_SET(DCN_VM_AGP_BOT, 0,
+			AGP_BOT, pa_config->system_aperture.agp_bot >> 24);
+	REG_SET(DCN_VM_AGP_TOP, 0,
+			AGP_TOP, pa_config->system_aperture.agp_top >> 24);
+	REG_SET(DCN_VM_AGP_BASE, 0,
+			AGP_BASE, pa_config->system_aperture.agp_base >> 24);
+
+	if (pa_config->gart_config.page_table_start_addr != pa_config->gart_config.page_table_end_addr) {
+		phys_config.page_table_start_addr = pa_config->gart_config.page_table_start_addr >> 12;
+		phys_config.page_table_end_addr = pa_config->gart_config.page_table_end_addr >> 12;
+		phys_config.page_table_base_addr = pa_config->gart_config.page_table_base_addr;
+		phys_config.depth = 0;
+		phys_config.block_size = 0;
+		// Init VMID 0 based on PA config
+		dcn20_vmid_setup(&hubbub1->vmid[0], &phys_config);
+	}
+
+	return NUM_VMID;
+}
+
+bool hubbub3_program_watermarks(
+		struct hubbub *hubbub,
+		struct dcn_watermark_set *watermarks,
+		unsigned int refclk_mhz,
+		bool safe_to_lower)
+{
+	struct dcn20_hubbub *hubbub1 = TO_DCN20_HUBBUB(hubbub);
+	bool wm_pending = false;
+
+	if (hubbub21_program_urgent_watermarks(hubbub, watermarks, refclk_mhz, safe_to_lower))
+		wm_pending = true;
+
+	if (hubbub21_program_stutter_watermarks(hubbub, watermarks, refclk_mhz, safe_to_lower))
+		wm_pending = true;
+
+	if (hubbub21_program_pstate_watermarks(hubbub, watermarks, refclk_mhz, safe_to_lower))
+		wm_pending = true;
+
+	/*
+	 * The DCHub arbiter has a mechanism to dynamically rate limit the DCHub request stream to the fabric.
+	 * If the memory controller is fully utilized and the DCHub requestors are
+	 * well ahead of their amortized schedule, then it is safe to prevent the next winner
+	 * from being committed and sent to the fabric.
+	 * The utilization of the memory controller is approximated by ensuring that
+	 * the number of outstanding requests is greater than a threshold specified
+	 * by the ARB_MIN_REQ_OUTSTANDING. To determine that the DCHub requestors are well ahead of the amortized schedule,
+	 * the slack of the next winner is compared with the ARB_SAT_LEVEL in DLG RefClk cycles.
+	 *
+	 * TODO: Revisit request limit after figure out right number. request limit for Renoir isn't decided yet, set maximum value (0x1FF)
+	 * to turn off it for now.
+	 */
+	REG_SET(DCHUBBUB_ARB_SAT_LEVEL, 0,
+			DCHUBBUB_ARB_SAT_LEVEL, 60 * refclk_mhz);
+	REG_UPDATE(DCHUBBUB_ARB_DF_REQ_OUTSTAND,
+			DCHUBBUB_ARB_MIN_REQ_OUTSTAND, 0x1FF);
+
+	hubbub1_allow_self_refresh_control(hubbub, !hubbub->ctx->dc->debug.disable_stutter);
+
+	return wm_pending;
+}
+
+bool hubbub3_dcc_support_swizzle(
+		enum swizzle_mode_values swizzle,
+		unsigned int bytes_per_element,
+		enum segment_order *segment_order_horz,
+		enum segment_order *segment_order_vert)
+{
+	bool standard_swizzle = false;
+	bool display_swizzle = false;
+	bool render_swizzle = false;
+
+	switch (swizzle) {
+	case DC_SW_4KB_S:
+	case DC_SW_64KB_S:
+	case DC_SW_VAR_S:
+	case DC_SW_4KB_S_X:
+	case DC_SW_64KB_S_X:
+	case DC_SW_VAR_S_X:
+		standard_swizzle = true;
+		break;
+	case DC_SW_4KB_R:
+	case DC_SW_64KB_R:
+	case DC_SW_VAR_R:
+	case DC_SW_4KB_R_X:
+	case DC_SW_64KB_R_X:
+	case DC_SW_VAR_R_X:
+		render_swizzle = true;
+		break;
+	case DC_SW_4KB_D:
+	case DC_SW_64KB_D:
+	case DC_SW_VAR_D:
+	case DC_SW_4KB_D_X:
+	case DC_SW_64KB_D_X:
+	case DC_SW_VAR_D_X:
+		display_swizzle = true;
+		break;
+	default:
+		break;
+	}
+
+	if (standard_swizzle) {
+		if (bytes_per_element == 1) {
+			*segment_order_horz = segment_order__contiguous;
+			*segment_order_vert = segment_order__na;
+			return true;
+		}
+		if (bytes_per_element == 2) {
+			*segment_order_horz = segment_order__non_contiguous;
+			*segment_order_vert = segment_order__contiguous;
+			return true;
+		}
+		if (bytes_per_element == 4) {
+			*segment_order_horz = segment_order__non_contiguous;
+			*segment_order_vert = segment_order__contiguous;
+			return true;
+		}
+		if (bytes_per_element == 8) {
+			*segment_order_horz = segment_order__na;
+			*segment_order_vert = segment_order__contiguous;
+			return true;
+		}
+	}
+	if (render_swizzle) {
+		if (bytes_per_element == 1) {
+			*segment_order_horz = segment_order__contiguous;
+			*segment_order_vert = segment_order__na;
+			return true;
+		}
+		if (bytes_per_element == 2) {
+			*segment_order_horz = segment_order__non_contiguous;
+			*segment_order_vert = segment_order__contiguous;
+			return true;
+		}
+		if (bytes_per_element == 4) {
+			*segment_order_horz = segment_order__contiguous;
+			*segment_order_vert = segment_order__non_contiguous;
+			return true;
+		}
+		if (bytes_per_element == 8) {
+			*segment_order_horz = segment_order__contiguous;
+			*segment_order_vert = segment_order__non_contiguous;
+			return true;
+		}
+	}
+	if (display_swizzle && bytes_per_element == 8) {
+		*segment_order_horz = segment_order__contiguous;
+		*segment_order_vert = segment_order__non_contiguous;
+		return true;
+	}
+
+	return false;
+}
+
+static void hubbub3_get_blk256_size(unsigned int *blk256_width, unsigned int *blk256_height,
+		unsigned int bytes_per_element)
+{
+	/* copied from DML.  might want to refactor DML to leverage from DML */
+	/* DML : get_blk256_size */
+	if (bytes_per_element == 1) {
+		*blk256_width = 16;
+		*blk256_height = 16;
+	} else if (bytes_per_element == 2) {
+		*blk256_width = 16;
+		*blk256_height = 8;
+	} else if (bytes_per_element == 4) {
+		*blk256_width = 8;
+		*blk256_height = 8;
+	} else if (bytes_per_element == 8) {
+		*blk256_width = 8;
+		*blk256_height = 4;
+	}
+}
+
+static void hubbub3_det_request_size(
+		unsigned int detile_buf_size,
+		unsigned int height,
+		unsigned int width,
+		unsigned int bpe,
+		bool *req128_horz_wc,
+		bool *req128_vert_wc)
+{
+	unsigned int blk256_height = 0;
+	unsigned int blk256_width = 0;
+	unsigned int swath_bytes_horz_wc, swath_bytes_vert_wc;
+
+	hubbub3_get_blk256_size(&blk256_width, &blk256_height, bpe);
+
+	swath_bytes_horz_wc = width * blk256_height * bpe;
+	swath_bytes_vert_wc = height * blk256_width * bpe;
+
+	*req128_horz_wc = (2 * swath_bytes_horz_wc <= detile_buf_size) ?
+			false : /* full 256B request */
+			true; /* half 128b request */
+
+	*req128_vert_wc = (2 * swath_bytes_vert_wc <= detile_buf_size) ?
+			false : /* full 256B request */
+			true; /* half 128b request */
+}
+
+bool hubbub3_get_dcc_compression_cap(struct hubbub *hubbub,
+		const struct dc_dcc_surface_param *input,
+		struct dc_surface_dcc_cap *output)
+{
+	struct dc *dc = hubbub->ctx->dc;
+	/* implement section 1.6.2.1 of DCN1_Programming_Guide.docx */
+	enum dcc_control dcc_control;
+	unsigned int bpe;
+	enum segment_order segment_order_horz, segment_order_vert;
+	bool req128_horz_wc, req128_vert_wc;
+
+	memset(output, 0, sizeof(*output));
+
+	if (dc->debug.disable_dcc == DCC_DISABLE)
+		return false;
+
+	if (!hubbub->funcs->dcc_support_pixel_format(input->format,
+			&bpe))
+		return false;
+
+	if (!hubbub->funcs->dcc_support_swizzle(input->swizzle_mode, bpe,
+			&segment_order_horz, &segment_order_vert))
+		return false;
+
+	hubbub3_det_request_size(TO_DCN20_HUBBUB(hubbub)->detile_buf_size,
+			input->surface_size.height,  input->surface_size.width,
+			bpe, &req128_horz_wc, &req128_vert_wc);
+
+	if (!req128_horz_wc && !req128_vert_wc) {
+		dcc_control = dcc_control__256_256_xxx;
+	} else if (input->scan == SCAN_DIRECTION_HORIZONTAL) {
+		if (!req128_horz_wc)
+			dcc_control = dcc_control__256_256_xxx;
+		else if (segment_order_horz == segment_order__contiguous)
+			dcc_control = dcc_control__128_128_xxx;
+		else
+			dcc_control = dcc_control__256_64_64;
+	} else if (input->scan == SCAN_DIRECTION_VERTICAL) {
+		if (!req128_vert_wc)
+			dcc_control = dcc_control__256_256_xxx;
+		else if (segment_order_vert == segment_order__contiguous)
+			dcc_control = dcc_control__128_128_xxx;
+		else
+			dcc_control = dcc_control__256_64_64;
+	} else {
+		if ((req128_horz_wc &&
+			segment_order_horz == segment_order__non_contiguous) ||
+			(req128_vert_wc &&
+			segment_order_vert == segment_order__non_contiguous))
+			/* access_dir not known, must use most constraining */
+			dcc_control = dcc_control__256_64_64;
+		else
+			/* reg128 is true for either horz and vert
+			 * but segment_order is contiguous
+			 */
+			dcc_control = dcc_control__128_128_xxx;
+	}
+
+	/* Exception for 64KB_R_X */
+	if ((bpe == 2) && (input->swizzle_mode == DC_SW_64KB_R_X))
+		dcc_control = dcc_control__128_128_xxx;
+
+	if (dc->debug.disable_dcc == DCC_HALF_REQ_DISALBE &&
+		dcc_control != dcc_control__256_256_xxx)
+		return false;
+
+	switch (dcc_control) {
+	case dcc_control__256_256_xxx:
+		output->grph.rgb.max_uncompressed_blk_size = 256;
+		output->grph.rgb.max_compressed_blk_size = 256;
+		output->grph.rgb.independent_64b_blks = false;
+		output->grph.rgb.dcc_controls.dcc_256_256_unconstrained = 1;
+		output->grph.rgb.dcc_controls.dcc_256_128_128 = 1;
+		break;
+	case dcc_control__128_128_xxx:
+		output->grph.rgb.max_uncompressed_blk_size = 128;
+		output->grph.rgb.max_compressed_blk_size = 128;
+		output->grph.rgb.independent_64b_blks = false;
+		output->grph.rgb.dcc_controls.dcc_128_128_uncontrained = 1;
+		output->grph.rgb.dcc_controls.dcc_256_128_128 = 1;
+		break;
+	case dcc_control__256_64_64:
+		output->grph.rgb.max_uncompressed_blk_size = 256;
+		output->grph.rgb.max_compressed_blk_size = 64;
+		output->grph.rgb.independent_64b_blks = true;
+		output->grph.rgb.dcc_controls.dcc_256_64_64 = 1;
+		break;
+	case dcc_control__256_128_128:
+		output->grph.rgb.max_uncompressed_blk_size = 256;
+		output->grph.rgb.max_compressed_blk_size = 128;
+		output->grph.rgb.independent_64b_blks = false;
+		output->grph.rgb.dcc_controls.dcc_256_128_128 = 1;
+		break;
+	}
+	output->capable = true;
+	output->const_color_support = true;
+
+	return true;
+}
+
+void hubbub3_force_wm_propagate_to_pipes(struct hubbub *hubbub)
+{
+	struct dcn20_hubbub *hubbub1 = TO_DCN20_HUBBUB(hubbub);
+	uint32_t refclk_mhz = hubbub->ctx->dc->res_pool->ref_clocks.dchub_ref_clock_inKhz / 1000;
+	uint32_t prog_wm_value = convert_and_clamp(hubbub1->watermarks.a.urgent_ns,
+			refclk_mhz, 0x1fffff);
+
+	REG_SET_2(DCHUBBUB_ARB_DATA_URGENCY_WATERMARK_A, 0,
+			DCHUBBUB_ARB_DATA_URGENCY_WATERMARK_A, prog_wm_value,
+			DCHUBBUB_ARB_VM_ROW_URGENCY_WATERMARK_A, prog_wm_value);
+}
+
+static const struct hubbub_funcs hubbub30_funcs = {
+	.update_dchub = hubbub2_update_dchub,
+	.init_dchub_sys_ctx = hubbub3_init_dchub_sys_ctx,
+	.init_vm_ctx = hubbub2_init_vm_ctx,
+	.dcc_support_swizzle = hubbub3_dcc_support_swizzle,
+	.dcc_support_pixel_format = hubbub2_dcc_support_pixel_format,
+	.get_dcc_compression_cap = hubbub3_get_dcc_compression_cap,
+	.wm_read_state = hubbub21_wm_read_state,
+	.get_dchub_ref_freq = hubbub2_get_dchub_ref_freq,
+	.program_watermarks = hubbub3_program_watermarks,
+	.allow_self_refresh_control = hubbub1_allow_self_refresh_control,
+	.is_allow_self_refresh_enabled = hubbub1_is_allow_self_refresh_enabled,
+	.force_wm_propagate_to_pipes = hubbub3_force_wm_propagate_to_pipes,
+};
+
+void hubbub3_construct(struct dcn20_hubbub *hubbub3,
+	struct dc_context *ctx,
+	const struct dcn_hubbub_registers *hubbub_regs,
+	const struct dcn_hubbub_shift *hubbub_shift,
+	const struct dcn_hubbub_mask *hubbub_mask)
+{
+	hubbub3->base.ctx = ctx;
+	hubbub3->base.funcs = &hubbub30_funcs;
+	hubbub3->regs = hubbub_regs;
+	hubbub3->shifts = hubbub_shift;
+	hubbub3->masks = hubbub_mask;
+
+	hubbub3->debug_test_index_pstate = 0xB;
+	hubbub3->detile_buf_size = 184 * 1024; /* 184KB for DCN3 */
+}
+
diff --git a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_hubbub.h b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_hubbub.h
new file mode 100644
index 000000000000..790baa00672b
--- /dev/null
+++ b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_hubbub.h
@@ -0,0 +1,119 @@
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
+#ifndef __DC_HUBBUB_DCN30_H__
+#define __DC_HUBBUB_DCN30_H__
+
+#include "dcn21/dcn21_hubbub.h"
+
+#define HUBBUB_REG_LIST_DCN3AG(id)\
+	HUBBUB_REG_LIST_DCN21()
+
+#define HUBBUB_MASK_SH_LIST_DCN3AG(mask_sh)\
+	HUBBUB_MASK_SH_LIST_DCN21(mask_sh)
+
+#define HUBBUB_REG_LIST_DCN30(id)\
+	HUBBUB_REG_LIST_DCN20_COMMON(), \
+	HUBBUB_SR_WATERMARK_REG_LIST(), \
+	SR(DCHUBBUB_ARB_FRAC_URG_BW_NOM_A),\
+	SR(DCHUBBUB_ARB_FRAC_URG_BW_NOM_B),\
+	SR(DCHUBBUB_ARB_FRAC_URG_BW_NOM_C),\
+	SR(DCHUBBUB_ARB_FRAC_URG_BW_NOM_D),\
+	SR(DCHUBBUB_ARB_FRAC_URG_BW_FLIP_A),\
+	SR(DCHUBBUB_ARB_FRAC_URG_BW_FLIP_B),\
+	SR(DCHUBBUB_ARB_FRAC_URG_BW_FLIP_C),\
+	SR(DCHUBBUB_ARB_FRAC_URG_BW_FLIP_D),\
+	SR(DCHUBBUB_ARB_REFCYC_PER_TRIP_TO_MEMORY_A),\
+	SR(DCHUBBUB_ARB_REFCYC_PER_TRIP_TO_MEMORY_B),\
+	SR(DCHUBBUB_ARB_REFCYC_PER_TRIP_TO_MEMORY_C),\
+	SR(DCHUBBUB_ARB_REFCYC_PER_TRIP_TO_MEMORY_D)
+
+#define HUBBUB_MASK_SH_LIST_DCN30(mask_sh)\
+	HUBBUB_MASK_SH_LIST_DCN_COMMON(mask_sh), \
+	HUBBUB_MASK_SH_LIST_STUTTER(mask_sh), \
+	HUBBUB_SF(DCHUBBUB_GLOBAL_TIMER_CNTL, DCHUBBUB_GLOBAL_TIMER_REFDIV, mask_sh), \
+	HUBBUB_SF(DCN_VM_FB_LOCATION_BASE, FB_BASE, mask_sh), \
+	HUBBUB_SF(DCN_VM_FB_LOCATION_TOP, FB_TOP, mask_sh), \
+	HUBBUB_SF(DCN_VM_FB_OFFSET, FB_OFFSET, mask_sh), \
+	HUBBUB_SF(DCN_VM_AGP_BOT, AGP_BOT, mask_sh), \
+	HUBBUB_SF(DCN_VM_AGP_TOP, AGP_TOP, mask_sh), \
+	HUBBUB_SF(DCN_VM_AGP_BASE, AGP_BASE, mask_sh), \
+	HUBBUB_SF(DCHUBBUB_ARB_FRAC_URG_BW_FLIP_A, DCHUBBUB_ARB_FRAC_URG_BW_FLIP_A, mask_sh), \
+	HUBBUB_SF(DCHUBBUB_ARB_FRAC_URG_BW_FLIP_B, DCHUBBUB_ARB_FRAC_URG_BW_FLIP_B, mask_sh), \
+	HUBBUB_SF(DCHUBBUB_ARB_FRAC_URG_BW_FLIP_C, DCHUBBUB_ARB_FRAC_URG_BW_FLIP_C, mask_sh), \
+	HUBBUB_SF(DCHUBBUB_ARB_FRAC_URG_BW_FLIP_D, DCHUBBUB_ARB_FRAC_URG_BW_FLIP_D, mask_sh), \
+	HUBBUB_SF(DCHUBBUB_ARB_FRAC_URG_BW_NOM_A, DCHUBBUB_ARB_FRAC_URG_BW_NOM_A, mask_sh), \
+	HUBBUB_SF(DCHUBBUB_ARB_FRAC_URG_BW_NOM_B, DCHUBBUB_ARB_FRAC_URG_BW_NOM_B, mask_sh), \
+	HUBBUB_SF(DCHUBBUB_ARB_FRAC_URG_BW_NOM_C, DCHUBBUB_ARB_FRAC_URG_BW_NOM_C, mask_sh), \
+	HUBBUB_SF(DCHUBBUB_ARB_FRAC_URG_BW_NOM_D, DCHUBBUB_ARB_FRAC_URG_BW_NOM_D, mask_sh), \
+	HUBBUB_SF(DCHUBBUB_ARB_REFCYC_PER_TRIP_TO_MEMORY_A, DCHUBBUB_ARB_REFCYC_PER_TRIP_TO_MEMORY_A, mask_sh), \
+	HUBBUB_SF(DCHUBBUB_ARB_REFCYC_PER_TRIP_TO_MEMORY_B, DCHUBBUB_ARB_REFCYC_PER_TRIP_TO_MEMORY_B, mask_sh), \
+	HUBBUB_SF(DCHUBBUB_ARB_REFCYC_PER_TRIP_TO_MEMORY_C, DCHUBBUB_ARB_REFCYC_PER_TRIP_TO_MEMORY_C, mask_sh), \
+	HUBBUB_SF(DCHUBBUB_ARB_REFCYC_PER_TRIP_TO_MEMORY_D, DCHUBBUB_ARB_REFCYC_PER_TRIP_TO_MEMORY_D, mask_sh), \
+	HUBBUB_SF(DCHUBBUB_ARB_DATA_URGENCY_WATERMARK_A, DCHUBBUB_ARB_VM_ROW_URGENCY_WATERMARK_A, mask_sh), \
+	HUBBUB_SF(DCHUBBUB_ARB_DATA_URGENCY_WATERMARK_B, DCHUBBUB_ARB_VM_ROW_URGENCY_WATERMARK_B, mask_sh), \
+	HUBBUB_SF(DCHUBBUB_ARB_DATA_URGENCY_WATERMARK_C, DCHUBBUB_ARB_VM_ROW_URGENCY_WATERMARK_C, mask_sh), \
+	HUBBUB_SF(DCHUBBUB_ARB_DATA_URGENCY_WATERMARK_D, DCHUBBUB_ARB_VM_ROW_URGENCY_WATERMARK_D, mask_sh), \
+	HUBBUB_SF(DCHUBBUB_ARB_ALLOW_SR_ENTER_WATERMARK_A, DCHUBBUB_ARB_VM_ROW_ALLOW_SR_ENTER_WATERMARK_A, mask_sh), \
+	HUBBUB_SF(DCHUBBUB_ARB_ALLOW_SR_ENTER_WATERMARK_B, DCHUBBUB_ARB_VM_ROW_ALLOW_SR_ENTER_WATERMARK_B, mask_sh), \
+	HUBBUB_SF(DCHUBBUB_ARB_ALLOW_SR_ENTER_WATERMARK_C, DCHUBBUB_ARB_VM_ROW_ALLOW_SR_ENTER_WATERMARK_C, mask_sh), \
+	HUBBUB_SF(DCHUBBUB_ARB_ALLOW_SR_ENTER_WATERMARK_D, DCHUBBUB_ARB_VM_ROW_ALLOW_SR_ENTER_WATERMARK_D, mask_sh), \
+	HUBBUB_SF(DCHUBBUB_ARB_ALLOW_SR_EXIT_WATERMARK_A, DCHUBBUB_ARB_VM_ROW_ALLOW_SR_EXIT_WATERMARK_A, mask_sh), \
+	HUBBUB_SF(DCHUBBUB_ARB_ALLOW_SR_EXIT_WATERMARK_B, DCHUBBUB_ARB_VM_ROW_ALLOW_SR_EXIT_WATERMARK_B, mask_sh), \
+	HUBBUB_SF(DCHUBBUB_ARB_ALLOW_SR_EXIT_WATERMARK_C, DCHUBBUB_ARB_VM_ROW_ALLOW_SR_EXIT_WATERMARK_C, mask_sh), \
+	HUBBUB_SF(DCHUBBUB_ARB_ALLOW_SR_EXIT_WATERMARK_D, DCHUBBUB_ARB_VM_ROW_ALLOW_SR_EXIT_WATERMARK_D, mask_sh), \
+	HUBBUB_SF(DCHUBBUB_ARB_ALLOW_DRAM_CLK_CHANGE_WATERMARK_A, DCHUBBUB_ARB_VM_ROW_ALLOW_DRAM_CLK_CHANGE_WATERMARK_A, mask_sh), \
+	HUBBUB_SF(DCHUBBUB_ARB_ALLOW_DRAM_CLK_CHANGE_WATERMARK_B, DCHUBBUB_ARB_VM_ROW_ALLOW_DRAM_CLK_CHANGE_WATERMARK_B, mask_sh), \
+	HUBBUB_SF(DCHUBBUB_ARB_ALLOW_DRAM_CLK_CHANGE_WATERMARK_C, DCHUBBUB_ARB_VM_ROW_ALLOW_DRAM_CLK_CHANGE_WATERMARK_C, mask_sh), \
+	HUBBUB_SF(DCHUBBUB_ARB_ALLOW_DRAM_CLK_CHANGE_WATERMARK_D, DCHUBBUB_ARB_VM_ROW_ALLOW_DRAM_CLK_CHANGE_WATERMARK_D, mask_sh)
+
+void hubbub3_construct(struct dcn20_hubbub *hubbub3,
+	struct dc_context *ctx,
+	const struct dcn_hubbub_registers *hubbub_regs,
+	const struct dcn_hubbub_shift *hubbub_shift,
+	const struct dcn_hubbub_mask *hubbub_mask);
+
+int hubbub3_init_dchub_sys_ctx(struct hubbub *hubbub,
+		struct dcn_hubbub_phys_addr_config *pa_config);
+
+bool hubbub3_dcc_support_swizzle(
+		enum swizzle_mode_values swizzle,
+		unsigned int bytes_per_element,
+		enum segment_order *segment_order_horz,
+		enum segment_order *segment_order_vert);
+
+void hubbub3_force_wm_propagate_to_pipes(struct hubbub *hubbub);
+
+bool hubbub3_get_dcc_compression_cap(struct hubbub *hubbub,
+		const struct dc_dcc_surface_param *input,
+		struct dc_surface_dcc_cap *output);
+
+bool hubbub3_program_watermarks(
+		struct hubbub *hubbub,
+		struct dcn_watermark_set *watermarks,
+		unsigned int refclk_mhz,
+		bool safe_to_lower);
+
+#endif
diff --git a/drivers/gpu/drm/amd/display/dc/inc/hw/dchubbub.h b/drivers/gpu/drm/amd/display/dc/inc/hw/dchubbub.h
index 47a566d82d6e..65f182c8bf14 100644
--- a/drivers/gpu/drm/amd/display/dc/inc/hw/dchubbub.h
+++ b/drivers/gpu/drm/amd/display/dc/inc/hw/dchubbub.h
@@ -31,6 +31,9 @@ enum dcc_control {
 	dcc_control__256_256_xxx,
 	dcc_control__128_128_xxx,
 	dcc_control__256_64_64,
+#if defined(CONFIG_DRM_AMD_DC_DCN3_0)
+	dcc_control__256_128_128,
+#endif
 };
 
 enum segment_order {
@@ -62,6 +65,9 @@ enum dcn_hubbub_page_table_depth {
 enum dcn_hubbub_page_table_block_size {
 	DCN_PAGE_TABLE_BLOCK_SIZE_4KB = 0,
 	DCN_PAGE_TABLE_BLOCK_SIZE_64KB = 4,
+#if defined(CONFIG_DRM_AMD_DC_DCN3_0)
+	DCN_PAGE_TABLE_BLOCK_SIZE_32KB = 3
+#endif
 };
 
 struct dcn_hubbub_phys_addr_config {
-- 
2.25.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
