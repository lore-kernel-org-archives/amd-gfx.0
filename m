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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4241BC433EA
	for <amd-gfx@archiver.kernel.org>; Thu, 16 Jul 2020 21:23:23 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 12EFF20787
	for <amd-gfx@archiver.kernel.org>; Thu, 16 Jul 2020 21:23:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YJbV1xTm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 12EFF20787
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B67466ECF5;
	Thu, 16 Jul 2020 21:23:22 +0000 (UTC)
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com
 [IPv6:2a00:1450:4864:20::443])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3E8436ECF3
 for <amd-gfx@lists.freedesktop.org>; Thu, 16 Jul 2020 21:23:21 +0000 (UTC)
Received: by mail-wr1-x443.google.com with SMTP id b6so8601072wrs.11
 for <amd-gfx@lists.freedesktop.org>; Thu, 16 Jul 2020 14:23:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=FTiD57SS6xRugSOcpxHazZ5Y/9DeijISFF/XPP7GgSE=;
 b=YJbV1xTmUF4lh8sOAOt1Dp4v9Eu0oEFke+x640vjl4uDLQmg65vf1q0OvDWDKJIn8M
 rOPPJOxA7glIswdVhlDme8H0P4TXETSGh5d/ATeLS49j7sRA8bL9AlMPtlMaEbrhrQwc
 rrxgjAVI4tb0JF/xWj/xGTzQOuTzee0uAHmqEIu7BN/QJ0sH27sp9U0nXN8dxNnAU06p
 S3uXMhDpz4XgyIMvLBCM//eKmhECd9zrpP+DeQfRYDIJy1pT+R2hYyF32zIlRo4fgrDc
 bhaHIYYxV9umnaJqTS+nzfMrpnsPtmRdDlfTv1Hv+FLpPlktEWxaFa3r2Az9A6K+LVqO
 8gOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=FTiD57SS6xRugSOcpxHazZ5Y/9DeijISFF/XPP7GgSE=;
 b=UmqaRPr/ZwjS0xiEO51RP5nyQ07A90ZfU4OkO/tEIyjOtQ1uFfI2zmN3p5Qpx4EdMh
 7xrNtoRy+o1cZWY23qlAn5THjQZzbH9nF8pFGhkRmtoagcPpqYcaYr4uC8oET9lo2XVk
 kPz1SDtse9R7LPPFdTA4D4D/lyF7kSkgm/kfrLKsn5ovfoHtVCO+1bsn0e0doL8dOVmy
 GyN0I+57CHbekfLW+Jw2p6dJRJ0lc4N3OctO48iy2rin+CbSjzE6j5K7V/tBymHHfRW5
 ks1ebDmo72gV32VcHSEjT0MyPWqzYS1k26iymCne2scn0G4VpD4MScSa3tcyQkL+tHDv
 DcKQ==
X-Gm-Message-State: AOAM53138AFYAFsSpe2/7ReC/jXGnUdgEaI3zhPpqxgKKOZ5EQa8/pCv
 LYqDkRsL7VD5Z7CnY9NUKxBshsKlDE4=
X-Google-Smtp-Source: ABdhPJxh9dyZKUT/xgCF48TGapY0Cy26o1zikw0HIN+6xFJjI5hGdxJWO+6umooTWy68TFMWnKs/oA==
X-Received: by 2002:a05:6000:86:: with SMTP id
 m6mr6736753wrx.173.1594934599445; 
 Thu, 16 Jul 2020 14:23:19 -0700 (PDT)
Received: from utente-Giga.homenet.telecomitalia.it
 (host-79-21-65-179.retail.telecomitalia.it. [79.21.65.179])
 by smtp.googlemail.com with ESMTPSA id c15sm10288696wme.23.2020.07.16.14.23.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 16 Jul 2020 14:23:19 -0700 (PDT)
From: Mauro Rossi <issor.oruam@gmail.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH v3 11/27] drm/amd/display: dce_audio: add DCE6 specific macros,
 functions
Date: Thu, 16 Jul 2020 23:22:35 +0200
Message-Id: <20200716212251.1539094-12-issor.oruam@gmail.com>
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
DCE6 has no DCCG_AUDIO_DTO2_USE_512FBR_DTO mask in DCCG_AUDIO_DTO_SOURCE register

[How]
Add DCE6 specific macros definitions for AUD masks
DCE6 AUD macros will avoid buiding errors when using DCE6 headers
Add dce60_aud_wall_dto_setup() w/o 512*Fs programming
Use dce60_aud_wall_dto_setup() in dce60_funcs
Add DCE specific dce60_audio_create

Signed-off-by: Mauro Rossi <issor.oruam@gmail.com>
---
 .../gpu/drm/amd/display/dc/dce/dce_audio.c    | 131 ++++++++++++++++++
 .../gpu/drm/amd/display/dc/dce/dce_audio.h    |  23 +++
 2 files changed, 154 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/dce/dce_audio.c b/drivers/gpu/drm/amd/display/dc/dce/dce_audio.c
index 408046579712..2a2a0fdb9253 100644
--- a/drivers/gpu/drm/amd/display/dc/dce/dce_audio.c
+++ b/drivers/gpu/drm/amd/display/dc/dce/dce_audio.c
@@ -867,6 +867,98 @@ void dce_aud_wall_dto_setup(
 	}
 }
 
+#if defined(CONFIG_DRM_AMD_DC_SI)
+void dce60_aud_wall_dto_setup(
+	struct audio *audio,
+	enum signal_type signal,
+	const struct audio_crtc_info *crtc_info,
+	const struct audio_pll_info *pll_info)
+{
+	struct dce_audio *aud = DCE_AUD(audio);
+
+	struct azalia_clock_info clock_info = { 0 };
+
+	if (dc_is_hdmi_signal(signal)) {
+		uint32_t src_sel;
+
+		/*DTO0 Programming goal:
+		-generate 24MHz, 128*Fs from 24MHz
+		-use DTO0 when an active HDMI port is connected
+		(optionally a DP is connected) */
+
+		/* calculate DTO settings */
+		get_azalia_clock_info_hdmi(
+			crtc_info->requested_pixel_clock_100Hz,
+			crtc_info->calculated_pixel_clock_100Hz,
+			&clock_info);
+
+		DC_LOG_HW_AUDIO("\n%s:Input::requested_pixel_clock_100Hz = %d"\
+				"calculated_pixel_clock_100Hz =%d\n"\
+				"audio_dto_module = %d audio_dto_phase =%d \n\n", __func__,\
+				crtc_info->requested_pixel_clock_100Hz,\
+				crtc_info->calculated_pixel_clock_100Hz,\
+				clock_info.audio_dto_module,\
+				clock_info.audio_dto_phase);
+
+		/* On TN/SI, Program DTO source select and DTO select before
+		programming DTO modulo and DTO phase. These bits must be
+		programmed first, otherwise there will be no HDMI audio at boot
+		up. This is a HW sequence change (different from old ASICs).
+		Caution when changing this programming sequence.
+
+		HDMI enabled, using DTO0
+		program master CRTC for DTO0 */
+		src_sel = pll_info->dto_source - DTO_SOURCE_ID0;
+		REG_UPDATE_2(DCCG_AUDIO_DTO_SOURCE,
+			DCCG_AUDIO_DTO0_SOURCE_SEL, src_sel,
+			DCCG_AUDIO_DTO_SEL, 0);
+
+		/* module */
+		REG_UPDATE(DCCG_AUDIO_DTO0_MODULE,
+			DCCG_AUDIO_DTO0_MODULE, clock_info.audio_dto_module);
+
+		/* phase */
+		REG_UPDATE(DCCG_AUDIO_DTO0_PHASE,
+			DCCG_AUDIO_DTO0_PHASE, clock_info.audio_dto_phase);
+	} else {
+		/*DTO1 Programming goal:
+		-generate 24MHz, 128*Fs from 24MHz (DCE6 does not support 512*Fs)
+		-default is to used DTO1, and switch to DTO0 when an audio
+		master HDMI port is connected
+		-use as default for DP
+
+		calculate DTO settings */
+		get_azalia_clock_info_dp(
+			crtc_info->requested_pixel_clock_100Hz,
+			pll_info,
+			&clock_info);
+
+		/* Program DTO select before programming DTO modulo and DTO
+		phase. default to use DTO1 */
+
+		REG_UPDATE(DCCG_AUDIO_DTO_SOURCE,
+				DCCG_AUDIO_DTO_SEL, 1);
+
+			/* DCCG_AUDIO_DTO2_USE_512FBR_DTO, 1)
+			 * Cannot select 512fs for DP
+			 *
+			 * DCE6 has no DCCG_AUDIO_DTO2_USE_512FBR_DTO mask
+			*/
+
+		/* module */
+		REG_UPDATE(DCCG_AUDIO_DTO1_MODULE,
+				DCCG_AUDIO_DTO1_MODULE, clock_info.audio_dto_module);
+
+		/* phase */
+		REG_UPDATE(DCCG_AUDIO_DTO1_PHASE,
+				DCCG_AUDIO_DTO1_PHASE, clock_info.audio_dto_phase);
+
+		/* DCE6 has no DCCG_AUDIO_DTO2_USE_512FBR_DTO mask in DCCG_AUDIO_DTO_SOURCE reg */
+
+	}
+}
+#endif
+
 static bool dce_aud_endpoint_valid(struct audio *audio)
 {
 	uint32_t value;
@@ -926,6 +1018,19 @@ static const struct audio_funcs funcs = {
 	.az_configure = dce_aud_az_configure,
 	.destroy = dce_aud_destroy,
 };
+
+#if defined(CONFIG_DRM_AMD_DC_SI)
+static const struct audio_funcs dce60_funcs = {
+	.endpoint_valid = dce_aud_endpoint_valid,
+	.hw_init = dce_aud_hw_init,
+	.wall_dto_setup = dce60_aud_wall_dto_setup,
+	.az_enable = dce_aud_az_enable,
+	.az_disable = dce_aud_az_disable,
+	.az_configure = dce_aud_az_configure,
+	.destroy = dce_aud_destroy,
+};
+#endif
+
 void dce_aud_destroy(struct audio **audio)
 {
 	struct dce_audio *aud = DCE_AUD(*audio);
@@ -959,3 +1064,29 @@ struct audio *dce_audio_create(
 	return &audio->base;
 }
 
+#if defined(CONFIG_DRM_AMD_DC_SI)
+struct audio *dce60_audio_create(
+		struct dc_context *ctx,
+		unsigned int inst,
+		const struct dce_audio_registers *reg,
+		const struct dce_audio_shift *shifts,
+		const struct dce_audio_mask *masks
+		)
+{
+	struct dce_audio *audio = kzalloc(sizeof(*audio), GFP_KERNEL);
+
+	if (audio == NULL) {
+		ASSERT_CRITICAL(audio);
+		return NULL;
+	}
+
+	audio->base.ctx = ctx;
+	audio->base.inst = inst;
+	audio->base.funcs = &dce60_funcs;
+
+	audio->regs = reg;
+	audio->shifts = shifts;
+	audio->masks = masks;
+	return &audio->base;
+}
+#endif
diff --git a/drivers/gpu/drm/amd/display/dc/dce/dce_audio.h b/drivers/gpu/drm/amd/display/dc/dce/dce_audio.h
index 1392fab0860b..5622d5e32d81 100644
--- a/drivers/gpu/drm/amd/display/dc/dce/dce_audio.h
+++ b/drivers/gpu/drm/amd/display/dc/dce/dce_audio.h
@@ -64,6 +64,20 @@
 		SF(AZALIA_F0_CODEC_ENDPOINT_INDEX, AZALIA_ENDPOINT_REG_INDEX, mask_sh),\
 		SF(AZALIA_F0_CODEC_ENDPOINT_DATA, AZALIA_ENDPOINT_REG_DATA, mask_sh)
 
+#if defined(CONFIG_DRM_AMD_DC_SI)
+#define AUD_DCE60_MASK_SH_LIST(mask_sh)\
+		SF(DCCG_AUDIO_DTO_SOURCE, DCCG_AUDIO_DTO0_SOURCE_SEL, mask_sh),\
+		SF(DCCG_AUDIO_DTO_SOURCE, DCCG_AUDIO_DTO_SEL, mask_sh),\
+		SF(DCCG_AUDIO_DTO0_MODULE, DCCG_AUDIO_DTO0_MODULE, mask_sh),\
+		SF(DCCG_AUDIO_DTO0_PHASE, DCCG_AUDIO_DTO0_PHASE, mask_sh),\
+		SF(DCCG_AUDIO_DTO1_MODULE, DCCG_AUDIO_DTO1_MODULE, mask_sh),\
+		SF(DCCG_AUDIO_DTO1_PHASE, DCCG_AUDIO_DTO1_PHASE, mask_sh),\
+		SF(AZALIA_F0_CODEC_FUNCTION_PARAMETER_SUPPORTED_SIZE_RATES, AUDIO_RATE_CAPABILITIES, mask_sh),\
+		SF(AZALIA_F0_CODEC_FUNCTION_PARAMETER_POWER_STATES, CLKSTOP, mask_sh),\
+		SF(AZALIA_F0_CODEC_FUNCTION_PARAMETER_POWER_STATES, EPSS, mask_sh), \
+		SF(AZALIA_F0_CODEC_ENDPOINT_INDEX, AZALIA_ENDPOINT_REG_INDEX, mask_sh),\
+		SF(AZALIA_F0_CODEC_ENDPOINT_DATA, AZALIA_ENDPOINT_REG_DATA, mask_sh)
+#endif
 
 struct dce_audio_registers {
 	uint32_t AZALIA_F0_CODEC_ENDPOINT_INDEX;
@@ -135,6 +149,15 @@ struct audio *dce_audio_create(
 		const struct dce_audio_shift *shifts,
 		const struct dce_audio_mask *masks);
 
+#if defined(CONFIG_DRM_AMD_DC_SI)
+struct audio *dce60_audio_create(
+		struct dc_context *ctx,
+		unsigned int inst,
+		const struct dce_audio_registers *reg,
+		const struct dce_audio_shift *shifts,
+		const struct dce_audio_mask *masks);
+#endif
+
 void dce_aud_destroy(struct audio **audio);
 
 void dce_aud_hw_init(struct audio *audio);
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
