Return-Path: <SRS0=xwQz=A3=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61295C43457
	for <amd-gfx@archiver.kernel.org>; Thu, 16 Jul 2020 21:23:36 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2EBB120787
	for <amd-gfx@archiver.kernel.org>; Thu, 16 Jul 2020 21:23:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="u8dC4akh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2EBB120787
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E14F06ECFD;
	Thu, 16 Jul 2020 21:23:35 +0000 (UTC)
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com
 [IPv6:2a00:1450:4864:20::342])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D784D6ECFD
 for <amd-gfx@lists.freedesktop.org>; Thu, 16 Jul 2020 21:23:34 +0000 (UTC)
Received: by mail-wm1-x342.google.com with SMTP id q15so11738766wmj.2
 for <amd-gfx@lists.freedesktop.org>; Thu, 16 Jul 2020 14:23:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=FC2oarQHBWzOMrgSp/V63dNNHaRjArJ8mkEgyb4UyCU=;
 b=u8dC4akheW1vrTwTN6rEFB44djUro6Mxlyd6r8SD13/m+lpQuy2urRZ41ePXW/LP8E
 PiragB+sznSdNvHjA2aJG15w1nyRH6TYg58p6kbadi7Bp92M424Bs0ESFHnzs8668PsT
 bv84iYeHwSdbucNUjwH9J7Pq1xw4LfkkaR8YQOuuGYC7R7sqCe9AgSMlse7lDLvzp0j1
 X3xe1w5B6FPvyhcVCBIDiH3x6HBi5Tu1RUqVs5Mbp3VyE77jbpdlIzJHFs6P6lqzNbJW
 i5RYCVRaltaoX8Br8ozqcKNHR0V6rZQ54rkdlgxOu42Q/2M33iu6IilGvZBw4tvkf9Xk
 +e9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=FC2oarQHBWzOMrgSp/V63dNNHaRjArJ8mkEgyb4UyCU=;
 b=mrpoGm17LgaNJXx9nt7FEQZ7RumoqK78+4sg6tcgEc+xiiCX6y59mddFlw2yuTfZc+
 rQk3vj6/aPd7VWNHzVvwUlUD48IfpNbQw4F9lbQO2XAXRUbowwflPaDs6rS7KGaL0Wvj
 sWD1snoeLBRlYlWph6xY9EQMUN7RBC1fm6sWp41OOoh1sWawO13IY3/bpzSfq63K9GXu
 ORPmhBUBjeu8NYj7A8H1WVcofWbwzb0CUyvW2SVJ/doSUjz5vhxbBAzhSMMpHd/AUNnO
 L7ISfsM+aisyjgHcG+X2TUDvumZ2faYb+9nKhIvbbGbIwJo17cZ36QxzZjKQkg1DKFDF
 ZF0A==
X-Gm-Message-State: AOAM5304QmyqpMAH9o6GnEBPRBE4eBjIUKWSBtZ34M8B6vRz0TFQlkLR
 TmTPgH3VI+mwZXUqQbmqlUvZzKEoOXQ=
X-Google-Smtp-Source: ABdhPJyTlGbnAIFd4Al4ChooHQQSqMNGAVDhF7XLYDvsERQnWEUf7qIXQmJxb77EMi5t8AWoXPRvgA==
X-Received: by 2002:a05:600c:2152:: with SMTP id
 v18mr6385042wml.5.1594934612975; 
 Thu, 16 Jul 2020 14:23:32 -0700 (PDT)
Received: from utente-Giga.homenet.telecomitalia.it
 (host-79-21-65-179.retail.telecomitalia.it. [79.21.65.179])
 by smtp.googlemail.com with ESMTPSA id c15sm10288696wme.23.2020.07.16.14.23.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 16 Jul 2020 14:23:32 -0700 (PDT)
From: Mauro Rossi <issor.oruam@gmail.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH v3 24/27] drm/amd/display: dc/dce60: use DCE6 headers (v6)
Date: Thu, 16 Jul 2020 23:22:48 +0200
Message-Id: <20200716212251.1539094-25-issor.oruam@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200716212251.1539094-1-issor.oruam@gmail.com>
References: <20200716212251.1539094-1-issor.oruam@gmail.com>
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
Cc: alexander.deucher@amd.com, Mauro Rossi <issor.oruam@gmail.com>,
 harry.wentland@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[Why]
With all DCE6 specific macros, register, masks in place
dce60_resource.c may use them and become independent from DCE8 headers

[How]
(v1) Changelog:
- use DCE6 headers for registers and masks, remove the DC8 headers
- remove 7th Display Controller/Encoder register instances (DCE6 has only 6)
- use DCE6 specific watermark programming registers (DPG_PIPE_ARBITRATION_CONTROL3)
- use DCE6 specific input pixel processing registers shift/mask
- use DCE6 specific transform registers shift/mask
- use DCE6 specific link encoder registers shift/mask
- use DCE6 specific output pixel processing registers shift/mask
- use DCE6 specific audio registers shift/mask
- use DCE6 specific dmcu registers shift/mask
- use DCE6 specific hwseq registers shift/mask
- use DCE6 specific mem input registers shift/mask

(v2) Changelog:
- use DCE6 ad hoc dce60_mem_input_construct() function
- use DCE6 ad hoc dce60_transform_construct() function

(v3) Changelog:
- use DCE6 ad hoc dce60_ipp_construct() function

(v4) Changelog:
- use DCE6 ad hoc dce60_link_encoder_construct() function

(v5) Changelog:
- use DCE6 ad hoc dce60_opp_construct() function

(v6) Changelog:
- use DCE6 ad hoc dce60_audio_create() function

Signed-off-by: Mauro Rossi <issor.oruam@gmail.com>
---
 .../drm/amd/display/dc/dce60/dce60_resource.c | 89 +++++++++----------
 1 file changed, 42 insertions(+), 47 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dce60/dce60_resource.c b/drivers/gpu/drm/amd/display/dc/dce60/dce60_resource.c
index 179f67ed7dbb..261333afc936 100644
--- a/drivers/gpu/drm/amd/display/dc/dce60/dce60_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dce60/dce60_resource.c
@@ -25,8 +25,8 @@
 
 #include <linux/slab.h>
 
-#include "dce/dce_8_0_d.h"
-#include "dce/dce_8_0_sh_mask.h"
+#include "dce/dce_6_0_d.h"
+#include "dce/dce_6_0_sh_mask.h"
 
 #include "dm_services.h"
 
@@ -73,7 +73,6 @@
 #define mmDP3_DP_DPHY_INTERNAL_CTRL                     0x45DE
 #define mmDP4_DP_DPHY_INTERNAL_CTRL                     0x48DE
 #define mmDP5_DP_DPHY_INTERNAL_CTRL                     0x4BDE
-#define mmDP6_DP_DPHY_INTERNAL_CTRL                     0x4EDE
 #endif
 
 
@@ -91,7 +90,6 @@
 	#define mmDP3_DP_DPHY_FAST_TRAINING                     0x45CE
 	#define mmDP4_DP_DPHY_FAST_TRAINING                     0x48CE
 	#define mmDP5_DP_DPHY_FAST_TRAINING                     0x4BCE
-	#define mmDP6_DP_DPHY_FAST_TRAINING                     0x4ECE
 #endif
 
 
@@ -113,38 +111,38 @@ static const struct dce110_timing_generator_offsets dce60_tg_offsets[] = {
 		{
 			.crtc = (mmCRTC0_CRTC_CONTROL - mmCRTC_CONTROL),
 			.dcp =  (mmGRPH_CONTROL - mmGRPH_CONTROL),
-			.dmif = (mmDMIF_PG0_DPG_WATERMARK_MASK_CONTROL
-					- mmDPG_WATERMARK_MASK_CONTROL),
+			.dmif = (mmDMIF_PG0_DPG_PIPE_ARBITRATION_CONTROL3
+					- mmDPG_PIPE_ARBITRATION_CONTROL3),
 		},
 		{
 			.crtc = (mmCRTC1_CRTC_CONTROL - mmCRTC_CONTROL),
 			.dcp = (mmDCP1_GRPH_CONTROL - mmGRPH_CONTROL),
-			.dmif = (mmDMIF_PG1_DPG_WATERMARK_MASK_CONTROL
-					- mmDPG_WATERMARK_MASK_CONTROL),
+			.dmif = (mmDMIF_PG1_DPG_PIPE_ARBITRATION_CONTROL3
+					- mmDPG_PIPE_ARBITRATION_CONTROL3),
 		},
 		{
 			.crtc = (mmCRTC2_CRTC_CONTROL - mmCRTC_CONTROL),
 			.dcp = (mmDCP2_GRPH_CONTROL - mmGRPH_CONTROL),
-			.dmif = (mmDMIF_PG2_DPG_WATERMARK_MASK_CONTROL
-					- mmDPG_WATERMARK_MASK_CONTROL),
+			.dmif = (mmDMIF_PG2_DPG_PIPE_ARBITRATION_CONTROL3
+					- mmDPG_PIPE_ARBITRATION_CONTROL3),
 		},
 		{
 			.crtc = (mmCRTC3_CRTC_CONTROL - mmCRTC_CONTROL),
 			.dcp = (mmDCP3_GRPH_CONTROL - mmGRPH_CONTROL),
-			.dmif = (mmDMIF_PG3_DPG_WATERMARK_MASK_CONTROL
-					- mmDPG_WATERMARK_MASK_CONTROL),
+			.dmif = (mmDMIF_PG3_DPG_PIPE_ARBITRATION_CONTROL3
+					- mmDPG_PIPE_ARBITRATION_CONTROL3),
 		},
 		{
 			.crtc = (mmCRTC4_CRTC_CONTROL - mmCRTC_CONTROL),
 			.dcp = (mmDCP4_GRPH_CONTROL - mmGRPH_CONTROL),
-			.dmif = (mmDMIF_PG4_DPG_WATERMARK_MASK_CONTROL
-					- mmDPG_WATERMARK_MASK_CONTROL),
+			.dmif = (mmDMIF_PG4_DPG_PIPE_ARBITRATION_CONTROL3
+					- mmDPG_PIPE_ARBITRATION_CONTROL3),
 		},
 		{
 			.crtc = (mmCRTC5_CRTC_CONTROL - mmCRTC_CONTROL),
 			.dcp = (mmDCP5_GRPH_CONTROL - mmGRPH_CONTROL),
-			.dmif = (mmDMIF_PG5_DPG_WATERMARK_MASK_CONTROL
-					- mmDPG_WATERMARK_MASK_CONTROL),
+			.dmif = (mmDMIF_PG5_DPG_PIPE_ARBITRATION_CONTROL3
+					- mmDPG_PIPE_ARBITRATION_CONTROL3),
 		}
 };
 
@@ -171,16 +169,16 @@ static const struct dce_ipp_registers ipp_regs[] = {
 };
 
 static const struct dce_ipp_shift ipp_shift = {
-		IPP_COMMON_MASK_SH_LIST_DCE_COMMON_BASE(__SHIFT)
+		IPP_DCE60_MASK_SH_LIST_DCE_COMMON_BASE(__SHIFT)
 };
 
 static const struct dce_ipp_mask ipp_mask = {
-		IPP_COMMON_MASK_SH_LIST_DCE_COMMON_BASE(_MASK)
+		IPP_DCE60_MASK_SH_LIST_DCE_COMMON_BASE(_MASK)
 };
 
 #define transform_regs(id)\
 [id] = {\
-		XFM_COMMON_REG_LIST_DCE80(id)\
+		XFM_COMMON_REG_LIST_DCE60(id)\
 }
 
 static const struct dce_transform_registers xfm_regs[] = {
@@ -193,11 +191,11 @@ static const struct dce_transform_registers xfm_regs[] = {
 };
 
 static const struct dce_transform_shift xfm_shift = {
-		XFM_COMMON_MASK_SH_LIST_DCE80(__SHIFT)
+		XFM_COMMON_MASK_SH_LIST_DCE60(__SHIFT)
 };
 
 static const struct dce_transform_mask xfm_mask = {
-		XFM_COMMON_MASK_SH_LIST_DCE80(_MASK)
+		XFM_COMMON_MASK_SH_LIST_DCE60(_MASK)
 };
 
 #define aux_regs(id)\
@@ -230,7 +228,7 @@ static const struct dce110_link_enc_hpd_registers link_enc_hpd_regs[] = {
 
 #define link_regs(id)\
 [id] = {\
-	LE_DCE80_REG_LIST(id)\
+	LE_DCE60_REG_LIST(id)\
 }
 
 static const struct dce110_link_enc_registers link_enc_regs[] = {
@@ -239,8 +237,7 @@ static const struct dce110_link_enc_registers link_enc_regs[] = {
 	link_regs(2),
 	link_regs(3),
 	link_regs(4),
-	link_regs(5),
-	link_regs(6),
+	link_regs(5)
 };
 
 #define stream_enc_regs(id)\
@@ -255,8 +252,7 @@ static const struct dce110_stream_enc_registers stream_enc_regs[] = {
 	stream_enc_regs(2),
 	stream_enc_regs(3),
 	stream_enc_regs(4),
-	stream_enc_regs(5),
-	stream_enc_regs(6)
+	stream_enc_regs(5)
 };
 
 static const struct dce_stream_encoder_shift se_shift = {
@@ -281,7 +277,7 @@ static const struct dce_panel_cntl_mask panel_cntl_mask = {
 
 #define opp_regs(id)\
 [id] = {\
-	OPP_DCE_80_REG_LIST(id),\
+	OPP_DCE_60_REG_LIST(id),\
 }
 
 static const struct dce_opp_registers opp_regs[] = {
@@ -294,11 +290,11 @@ static const struct dce_opp_registers opp_regs[] = {
 };
 
 static const struct dce_opp_shift opp_shift = {
-	OPP_COMMON_MASK_SH_LIST_DCE_80(__SHIFT)
+	OPP_COMMON_MASK_SH_LIST_DCE_60(__SHIFT)
 };
 
 static const struct dce_opp_mask opp_mask = {
-	OPP_COMMON_MASK_SH_LIST_DCE_80(_MASK)
+	OPP_COMMON_MASK_SH_LIST_DCE_60(_MASK)
 };
 
 static const struct dce110_aux_registers_shift aux_shift = {
@@ -336,15 +332,14 @@ static const struct dce_audio_registers audio_regs[] = {
 	audio_regs(3),
 	audio_regs(4),
 	audio_regs(5),
-	audio_regs(6),
 };
 
 static const struct dce_audio_shift audio_shift = {
-		AUD_COMMON_MASK_SH_LIST(__SHIFT)
+		AUD_DCE60_MASK_SH_LIST(__SHIFT)
 };
 
 static const struct dce_audio_mask audio_mask = {
-		AUD_COMMON_MASK_SH_LIST(_MASK)
+		AUD_DCE60_MASK_SH_LIST(_MASK)
 };
 
 #define clk_src_regs(id)\
@@ -419,15 +414,15 @@ static const struct dc_plane_cap plane_cap = {
 };
 
 static const struct dce_dmcu_registers dmcu_regs = {
-		DMCU_DCE80_REG_LIST()
+		DMCU_DCE60_REG_LIST()
 };
 
 static const struct dce_dmcu_shift dmcu_shift = {
-		DMCU_MASK_SH_LIST_DCE80(__SHIFT)
+		DMCU_MASK_SH_LIST_DCE60(__SHIFT)
 };
 
 static const struct dce_dmcu_mask dmcu_mask = {
-		DMCU_MASK_SH_LIST_DCE80(_MASK)
+		DMCU_MASK_SH_LIST_DCE60(_MASK)
 };
 static const struct dce_abm_registers abm_regs = {
 		ABM_DCE110_COMMON_REG_LIST()
@@ -497,7 +492,7 @@ static void read_dce_straps(
 static struct audio *create_audio(
 		struct dc_context *ctx, unsigned int inst)
 {
-	return dce_audio_create(ctx, inst,
+	return dce60_audio_create(ctx, inst,
 			&audio_regs[inst], &audio_shift, &audio_mask);
 }
 
@@ -526,7 +521,7 @@ static struct output_pixel_processor *dce60_opp_create(
 	if (!opp)
 		return NULL;
 
-	dce110_opp_construct(opp,
+	dce60_opp_construct(opp,
 			     ctx, inst, &opp_regs[inst], &opp_shift, &opp_mask);
 	return &opp->base;
 }
@@ -618,15 +613,15 @@ static struct stream_encoder *dce60_stream_encoder_create(
 	.reg_name[id] = mm ## block ## id ## _ ## reg_name
 
 static const struct dce_hwseq_registers hwseq_reg = {
-		HWSEQ_DCE8_REG_LIST()
+		HWSEQ_DCE6_REG_LIST()
 };
 
 static const struct dce_hwseq_shift hwseq_shift = {
-		HWSEQ_DCE8_MASK_SH_LIST(__SHIFT)
+		HWSEQ_DCE6_MASK_SH_LIST(__SHIFT)
 };
 
 static const struct dce_hwseq_mask hwseq_mask = {
-		HWSEQ_DCE8_MASK_SH_LIST(_MASK)
+		HWSEQ_DCE6_MASK_SH_LIST(_MASK)
 };
 
 static struct dce_hwseq *dce60_hwseq_create(
@@ -651,7 +646,7 @@ static const struct resource_create_funcs res_create_funcs = {
 };
 
 #define mi_inst_regs(id) { \
-	MI_DCE8_REG_LIST(id), \
+	MI_DCE6_REG_LIST(id), \
 	.MC_HUB_RDREQ_DMIF_LIMIT = mmMC_HUB_RDREQ_DMIF_LIMIT \
 }
 static const struct dce_mem_input_registers mi_regs[] = {
@@ -664,12 +659,12 @@ static const struct dce_mem_input_registers mi_regs[] = {
 };
 
 static const struct dce_mem_input_shift mi_shifts = {
-		MI_DCE8_MASK_SH_LIST(__SHIFT),
+		MI_DCE6_MASK_SH_LIST(__SHIFT),
 		.ENABLE = MC_HUB_RDREQ_DMIF_LIMIT__ENABLE__SHIFT
 };
 
 static const struct dce_mem_input_mask mi_masks = {
-		MI_DCE8_MASK_SH_LIST(_MASK),
+		MI_DCE6_MASK_SH_LIST(_MASK),
 		.ENABLE = MC_HUB_RDREQ_DMIF_LIMIT__ENABLE_MASK
 };
 
@@ -685,7 +680,7 @@ static struct mem_input *dce60_mem_input_create(
 		return NULL;
 	}
 
-	dce_mem_input_construct(dce_mi, ctx, inst, &mi_regs[inst], &mi_shifts, &mi_masks);
+	dce60_mem_input_construct(dce_mi, ctx, inst, &mi_regs[inst], &mi_shifts, &mi_masks);
 	dce_mi->wa.single_head_rdreq_dmif_limit = 2;
 	return &dce_mi->base;
 }
@@ -706,7 +701,7 @@ static struct transform *dce60_transform_create(
 	if (!transform)
 		return NULL;
 
-	dce_transform_construct(transform, ctx, inst,
+	dce60_transform_construct(transform, ctx, inst,
 				&xfm_regs[inst], &xfm_shift, &xfm_mask);
 	transform->prescaler_on = false;
 	return &transform->base;
@@ -732,7 +727,7 @@ struct link_encoder *dce60_link_encoder_create(
 	link_regs_id =
 		map_transmitter_id_to_phy_instance(enc_init_data->transmitter);
 
-	dce110_link_encoder_construct(enc110,
+	dce60_link_encoder_construct(enc110,
 				      enc_init_data,
 				      &link_enc_feature,
 				      &link_enc_regs[link_regs_id],
@@ -798,7 +793,7 @@ static struct input_pixel_processor *dce60_ipp_create(
 		return NULL;
 	}
 
-	dce_ipp_construct(ipp, ctx, inst,
+	dce60_ipp_construct(ipp, ctx, inst,
 			&ipp_regs[inst], &ipp_shift, &ipp_mask);
 	return &ipp->base;
 }
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
