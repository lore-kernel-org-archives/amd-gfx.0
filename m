Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F327DD4A5F4
	for <amd-gfx@archiver.kernel.org>; Sun, 18 Jan 2026 17:31:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 348C710E2DA;
	Sun, 18 Jan 2026 17:31:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="gJV401P/";
	dkim-atps=neutral
Received: from mail-ej1-f65.google.com (mail-ej1-f65.google.com
 [209.85.218.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EBA9D10E1C9
 for <amd-gfx@lists.freedesktop.org>; Sun, 18 Jan 2026 17:31:55 +0000 (UTC)
Received: by mail-ej1-f65.google.com with SMTP id
 a640c23a62f3a-b7cf4a975d2so622729466b.2
 for <amd-gfx@lists.freedesktop.org>; Sun, 18 Jan 2026 09:31:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1768757514; x=1769362314; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=yMt3Oj+cLtnuBrPMl3lSq4yrXhSgEOMT6kL2u48RPIo=;
 b=gJV401P/xvEZ1Hlvfd91U7ufuHAmhIdX2tIxNNcEf25h0imxKq8DI9RBMPibnKbxOn
 I3AHB+3uPDtYk0qGhOSHW+zDH2HZGtsVrHxhJwyCZH10rQyRE6AhbY+AIK0kI4G4WaUb
 KM93/f0dP16scQ+dZrXHqWSoQ6rS+jcSt7D0CIpbxgExesf/xm6ovQtaf3me5cg07r/K
 H+GJCEgzdfM569fO51VsybX2ueKAKn5m8BKoQWqmLtexZdjBYQvtRVBUPPE6zNZl2TrU
 Didyjz38AwAxMi9nGIU6di7U6s6AV/3Kgq+r3k8D2ajwbcxwbkecGQJC4AQAJzoU87HV
 LfOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768757514; x=1769362314;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=yMt3Oj+cLtnuBrPMl3lSq4yrXhSgEOMT6kL2u48RPIo=;
 b=Ue9CGopYLa30/DzJyJl+htSNTciehYQT80XLXdocENE7eHXMQjPXGPrAe/lJkEckeK
 bF4QUW4n3iaBbSh4LQr+kwkd9lNP3RdrAy1Us06xzQ7qdMdtR8/SCcNmh8I4qRRNEffE
 dfCIaCUutF7qON9Be/Bp5P9xmpxLHH2EvFaOeJzIm/DwShFgu6rlEAHS/ut7e7n93Wnm
 p4PzyBe0CFURdGEevZGPvvPVlBlv5ryJyqvoKvb2cwsvulzri5bd5+FapMJduqTM+NSY
 i4HFaDi6KzBdw/aO0R/RSNAeDFLUuPk2QmBbaAM3AnLMPRAtlhOIBvE/ld6bR1cfHxW2
 8tMQ==
X-Gm-Message-State: AOJu0YxEpONQKs4rqlEqBWA8NPQMq2tzJBgIcbT/i49iyb0OS/92RIgr
 m+ZjtTS0xf++9UzNI8kBquHYzJkam+lwwuzslQ9zJepVZrWtwPDwf0SW6QTI5gtg
X-Gm-Gg: AY/fxX73jteqnMlwavUQrXQs9YslsV/SL0WSIOLPh2uy8Ta57F+Z1yBkpP/yUhjAqAo
 WdJ3nxdwx17Opeetbbu/JozsoytnuTHEloZZyjuo+tp3l8Dzk3QVcqp1gcGnUtiWBTHO2d3HZsW
 PxFvqcq/dczxpPYC0EnpBVb83j3Iw7P/ZqYQYsTT7twp/7RXxqFz8l36OXWl4EBtTRvuMn9NV7a
 0MHY9xdYGOSjUe0NnVXM+qcDJSV/KQZXdzZvY/1kKqJFX1Ssm4QTe1zuGomKvjJOOLKpRcky0iZ
 H8+00qYJyOP+TjRjJrIvI+jDfsEJFqy+JgVvJBMirC9JncCCl4LoV4vnqTFgPU2Zj64hSZ/t2ap
 ERgDg1vGxI557FjDlKpO1UHnmeZoiksSX0180V4gifCks20XwFCgEHRLJzjxlCMn5FgT77om3kE
 6HbSZq+g02vnSyJ/KYB2ymg6/cbVzLN05n1gF3azRoSqT7ZMdbKVpfRBwJ95XOMAl+zsBsij2Qk
 AB9y/2wVNMt
X-Received: by 2002:a17:906:ef03:b0:b87:c92:25bf with SMTP id
 a640c23a62f3a-b8792fc4194mr788325666b.33.1768757514100; 
 Sun, 18 Jan 2026 09:31:54 -0800 (PST)
Received: from Timur-Hyperion
 (20014C4E24E47400AD77F2CC91C9A6FE.dsl.pool.telekom.hu.
 [2001:4c4e:24e4:7400:ad77:f2cc:91c9:a6fe])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b879513e735sm876868466b.13.2026.01.18.09.31.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 18 Jan 2026 09:31:53 -0800 (PST)
From: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
To: amd-gfx@lists.freedesktop.org, Alexander.Deucher@amd.com,
 Mario Limonciello <mario.limonciello@amd.com>,
 Ivan Lipski <ivan.lipski@amd.com>, harry.wentland@amd.com,
 Leo Li <sunpeng.li@amd.com>, Alex Hung <alex.hung@amd.com>
Cc: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
Subject: [PATCH 1/5] drm/amd/display: Use dce_audio_create for DCE 6
Date: Sun, 18 Jan 2026 18:31:46 +0100
Message-ID: <20260118173150.19790-2-timur.kristof@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260118173150.19790-1-timur.kristof@gmail.com>
References: <20260118173150.19790-1-timur.kristof@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

The only difference between DCE 6 and other DCE versions is
that DCE 6 doesn't support DCCG_AUDIO_DTO2_USE_512FBR_DTO.
Recently a check was added to dce_aud_wall_dto_setup() to
check that. So now DCE 6 can just use dce_aud_wall_dto_setup()
just like other DCE versions.

Clean up DCE 6 specific audio functions which were otherwise
identical to the rest.

Signed-off-by: Timur Kristóf <timur.kristof@gmail.com>
---
 .../gpu/drm/amd/display/dc/dce/dce_audio.c    | 131 ------------------
 .../gpu/drm/amd/display/dc/dce/dce_audio.h    |   9 --
 .../dc/resource/dce60/dce60_resource.c        |   2 +-
 3 files changed, 1 insertion(+), 141 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dce/dce_audio.c b/drivers/gpu/drm/amd/display/dc/dce/dce_audio.c
index fcad61c618a1..1276f19164b3 100644
--- a/drivers/gpu/drm/amd/display/dc/dce/dce_audio.c
+++ b/drivers/gpu/drm/amd/display/dc/dce/dce_audio.c
@@ -1150,98 +1150,6 @@ void dce_aud_wall_dto_setup(
 	}
 }
 
-#if defined(CONFIG_DRM_AMD_DC_SI)
-static void dce60_aud_wall_dto_setup(
-	struct audio *audio,
-	enum signal_type signal,
-	const struct audio_crtc_info *crtc_info,
-	const struct audio_pll_info *pll_info)
-{
-	struct dce_audio *aud = DCE_AUD(audio);
-
-	struct azalia_clock_info clock_info = { 0 };
-
-	if (dc_is_hdmi_signal(signal)) {
-		uint32_t src_sel;
-
-		/*DTO0 Programming goal:
-		-generate 24MHz, 128*Fs from 24MHz
-		-use DTO0 when an active HDMI port is connected
-		(optionally a DP is connected) */
-
-		/* calculate DTO settings */
-		get_azalia_clock_info_hdmi(
-			crtc_info->requested_pixel_clock_100Hz,
-			crtc_info->calculated_pixel_clock_100Hz,
-			&clock_info);
-
-		DC_LOG_HW_AUDIO("\n%s:Input::requested_pixel_clock_100Hz = %d"\
-				"calculated_pixel_clock_100Hz =%d\n"\
-				"audio_dto_module = %d audio_dto_phase =%d \n\n", __func__,\
-				crtc_info->requested_pixel_clock_100Hz,\
-				crtc_info->calculated_pixel_clock_100Hz,\
-				clock_info.audio_dto_module,\
-				clock_info.audio_dto_phase);
-
-		/* On TN/SI, Program DTO source select and DTO select before
-		programming DTO modulo and DTO phase. These bits must be
-		programmed first, otherwise there will be no HDMI audio at boot
-		up. This is a HW sequence change (different from old ASICs).
-		Caution when changing this programming sequence.
-
-		HDMI enabled, using DTO0
-		program master CRTC for DTO0 */
-		src_sel = pll_info->dto_source - DTO_SOURCE_ID0;
-		REG_UPDATE_2(DCCG_AUDIO_DTO_SOURCE,
-			DCCG_AUDIO_DTO0_SOURCE_SEL, src_sel,
-			DCCG_AUDIO_DTO_SEL, 0);
-
-		/* module */
-		REG_UPDATE(DCCG_AUDIO_DTO0_MODULE,
-			DCCG_AUDIO_DTO0_MODULE, clock_info.audio_dto_module);
-
-		/* phase */
-		REG_UPDATE(DCCG_AUDIO_DTO0_PHASE,
-			DCCG_AUDIO_DTO0_PHASE, clock_info.audio_dto_phase);
-	} else {
-		/*DTO1 Programming goal:
-		-generate 24MHz, 128*Fs from 24MHz (DCE6 does not support 512*Fs)
-		-default is to used DTO1, and switch to DTO0 when an audio
-		master HDMI port is connected
-		-use as default for DP
-
-		calculate DTO settings */
-		get_azalia_clock_info_dp(
-			crtc_info->requested_pixel_clock_100Hz,
-			pll_info,
-			&clock_info);
-
-		/* Program DTO select before programming DTO modulo and DTO
-		phase. default to use DTO1 */
-
-		REG_UPDATE(DCCG_AUDIO_DTO_SOURCE,
-				DCCG_AUDIO_DTO_SEL, 1);
-
-			/* DCCG_AUDIO_DTO2_USE_512FBR_DTO, 1)
-			 * Cannot select 512fs for DP
-			 *
-			 * DCE6 has no DCCG_AUDIO_DTO2_USE_512FBR_DTO mask
-			*/
-
-		/* module */
-		REG_UPDATE(DCCG_AUDIO_DTO1_MODULE,
-				DCCG_AUDIO_DTO1_MODULE, clock_info.audio_dto_module);
-
-		/* phase */
-		REG_UPDATE(DCCG_AUDIO_DTO1_PHASE,
-				DCCG_AUDIO_DTO1_PHASE, clock_info.audio_dto_phase);
-
-		/* DCE6 has no DCCG_AUDIO_DTO2_USE_512FBR_DTO mask in DCCG_AUDIO_DTO_SOURCE reg */
-
-	}
-}
-#endif
-
 static bool dce_aud_endpoint_valid(struct audio *audio)
 {
 	uint32_t value;
@@ -1303,18 +1211,6 @@ static const struct audio_funcs funcs = {
 	.destroy = dce_aud_destroy,
 };
 
-#if defined(CONFIG_DRM_AMD_DC_SI)
-static const struct audio_funcs dce60_funcs = {
-	.endpoint_valid = dce_aud_endpoint_valid,
-	.hw_init = dce_aud_hw_init,
-	.wall_dto_setup = dce60_aud_wall_dto_setup,
-	.az_enable = dce_aud_az_enable,
-	.az_disable = dce_aud_az_disable,
-	.az_configure = dce_aud_az_configure,
-	.destroy = dce_aud_destroy,
-};
-#endif
-
 void dce_aud_destroy(struct audio **audio)
 {
 	struct dce_audio *aud = DCE_AUD(*audio);
@@ -1347,30 +1243,3 @@ struct audio *dce_audio_create(
 	audio->masks = masks;
 	return &audio->base;
 }
-
-#if defined(CONFIG_DRM_AMD_DC_SI)
-struct audio *dce60_audio_create(
-		struct dc_context *ctx,
-		unsigned int inst,
-		const struct dce_audio_registers *reg,
-		const struct dce_audio_shift *shifts,
-		const struct dce_audio_mask *masks
-		)
-{
-	struct dce_audio *audio = kzalloc(sizeof(*audio), GFP_KERNEL);
-
-	if (audio == NULL) {
-		ASSERT_CRITICAL(audio);
-		return NULL;
-	}
-
-	audio->base.ctx = ctx;
-	audio->base.inst = inst;
-	audio->base.funcs = &dce60_funcs;
-
-	audio->regs = reg;
-	audio->shifts = shifts;
-	audio->masks = masks;
-	return &audio->base;
-}
-#endif
diff --git a/drivers/gpu/drm/amd/display/dc/dce/dce_audio.h b/drivers/gpu/drm/amd/display/dc/dce/dce_audio.h
index 1b7b8b079af4..3f1d161a0045 100644
--- a/drivers/gpu/drm/amd/display/dc/dce/dce_audio.h
+++ b/drivers/gpu/drm/amd/display/dc/dce/dce_audio.h
@@ -151,15 +151,6 @@ struct audio *dce_audio_create(
 		const struct dce_audio_shift *shifts,
 		const struct dce_audio_mask *masks);
 
-#if defined(CONFIG_DRM_AMD_DC_SI)
-struct audio *dce60_audio_create(
-		struct dc_context *ctx,
-		unsigned int inst,
-		const struct dce_audio_registers *reg,
-		const struct dce_audio_shift *shifts,
-		const struct dce_audio_mask *masks);
-#endif
-
 void dce_aud_destroy(struct audio **audio);
 
 void dce_aud_hw_init(struct audio *audio);
diff --git a/drivers/gpu/drm/amd/display/dc/resource/dce60/dce60_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dce60/dce60_resource.c
index f0152933bee2..e0fbb08e6985 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dce60/dce60_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dce60/dce60_resource.c
@@ -495,7 +495,7 @@ static void read_dce_straps(
 static struct audio *create_audio(
 		struct dc_context *ctx, unsigned int inst)
 {
-	return dce60_audio_create(ctx, inst,
+	return dce_audio_create(ctx, inst,
 			&audio_regs[inst], &audio_shift, &audio_mask);
 }
 
-- 
2.52.0

