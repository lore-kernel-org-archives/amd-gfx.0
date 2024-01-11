Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0D79C47077
	for <amd-gfx@archiver.kernel.org>; Thu, 11 Jan 2024 15:12:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4833710E946;
	Thu, 11 Jan 2024 15:12:25 +0000 (UTC)
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com
 [IPv6:2a00:1450:4864:20::62f])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 22B9510E925
 for <amd-gfx@lists.freedesktop.org>; Thu, 11 Jan 2024 15:05:59 +0000 (UTC)
Received: by mail-ej1-x62f.google.com with SMTP id
 a640c23a62f3a-a2c67be31edso75468366b.0
 for <amd-gfx@lists.freedesktop.org>; Thu, 11 Jan 2024 07:05:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1704985557; x=1705590357; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fxBo6FpVHaBvdTbRHo36SY8P73Ahoys1+0mZQOu9WDg=;
 b=PGAvLJ0y5rKd/OTj9ykuYXlheo+sa5y2lX9WitR0qTpqPbYmxTms+b+6yVybHQsTqH
 QuX1tY1qVokkA1BSfsaLiDubDc3fi7m2AipFLivXhsQSV6F7lXGj5D4212jCTNh/tdEv
 uE+Gwg34g4fIUh8fgXsR8FNlGKqH9n7q0CMOeXtFeBTFvSStmptebU/YzXr9Xm/y8mvg
 qlZHsBbxhlmK+D5VEm/FCCgV2RS0V24NcDmtzVjLFxqNZ4iFvcyrygqLjEvBziG3eikt
 LBzk8sAEGW1DG52uA8sYzntLxWihTP5/ffhqHq5kYiiw3AdRAv1IGPwAT+Mm1t+lIA+g
 bB5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704985557; x=1705590357;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=fxBo6FpVHaBvdTbRHo36SY8P73Ahoys1+0mZQOu9WDg=;
 b=WQxbKTpYzVttufeppJsmrXUz68CbdZGmCRTAzMrmZLXHVPfLh9MhSpi1loa1S3TaRa
 QxLRVUzJWVP/4TIA5OrRtPwFPZ5vB3Eg7G43dVuRr16dCafV0VDXtnfpX/BqWaquJpce
 Luz2IQCaWiTYwTOBIP3c9ghXBxtdzgUNzGFDJiU9F5yPQ9RJnnnRkk9ZtSTbslChX7EB
 S+Xk+NCf1K805B/cv/uvukB02Tpl/vBvP1IRy6Ak3i5NvVk1Ftu3bd6RZfgs3nYUOK6w
 /YGs9+bCguy/UjwFoqTmiAb5ZeTWIFKsu2P7trGlGVUpNre7eku9Y6AKRZewCFNznA2A
 3f1w==
X-Gm-Message-State: AOJu0YyVwFCD1hXSXGr6Ldidp4dWbD1At/c/zZ15T+dV5kzvgHqPfY7/
 tLGjSpxCVJZZDconn8gqqHaWvE7tubg=
X-Google-Smtp-Source: AGHT+IEkvpSmZrHSR8JgSDfCH9gEXRmqT/mEvJ6ZX4kGzLXqeqx0340LGDypE0sfP/6PF1SDhz89LQ==
X-Received: by 2002:a17:906:4c47:b0:a29:8da2:24e9 with SMTP id
 d7-20020a1709064c4700b00a298da224e9mr330344ejw.296.1704985557275; 
 Thu, 11 Jan 2024 07:05:57 -0800 (PST)
Received: from alex-computer.home (91-114-185-105.adsl.highway.telekom.at.
 [91.114.185.105]) by smtp.googlemail.com with ESMTPSA id
 d15-20020a170906c20f00b00a2ae7fb3fc6sm686116ejz.93.2024.01.11.07.05.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 11 Jan 2024 07:05:56 -0800 (PST)
From: Alexander <electrodeyt@gmail.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 2/2] drm/radeon: check PS, WS index
Date: Thu, 11 Jan 2024 16:04:49 +0100
Message-ID: <20240111150516.743276-3-electrodeyt@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240111150516.743276-1-electrodeyt@gmail.com>
References: <20240111150516.743276-1-electrodeyt@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Thu, 11 Jan 2024 15:12:24 +0000
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
Cc: Alexander Richards <electrodeyt@gmail.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Alexander Richards <electrodeyt@gmail.com>

Theoretically, it would be possible for a buggy or malicious VBIOS to
overwrite past the bounds of the passed parameters (or its own
workspace); add bounds checking to prevent this from happening.

Signed-off-by: Alexander Richards <electrodeyt@gmail.com>
---
 drivers/gpu/drm/radeon/atom.c              | 47 +++++++++++++++-------
 drivers/gpu/drm/radeon/atom.h              |  4 +-
 drivers/gpu/drm/radeon/atombios_crtc.c     | 28 ++++++-------
 drivers/gpu/drm/radeon/atombios_dp.c       |  4 +-
 drivers/gpu/drm/radeon/atombios_encoders.c | 38 ++++++++---------
 drivers/gpu/drm/radeon/atombios_i2c.c      |  2 +-
 drivers/gpu/drm/radeon/radeon_atombios.c   | 44 ++++++++++----------
 7 files changed, 93 insertions(+), 74 deletions(-)

diff --git a/drivers/gpu/drm/radeon/atom.c b/drivers/gpu/drm/radeon/atom.c
index ceb6d772e..005c2135a 100644
--- a/drivers/gpu/drm/radeon/atom.c
+++ b/drivers/gpu/drm/radeon/atom.c
@@ -60,6 +60,7 @@
 typedef struct {
 	struct atom_context *ctx;
 	uint32_t *ps, *ws;
+	int ps_size, ws_size;
 	int ps_shift;
 	uint16_t start;
 	unsigned last_jump;
@@ -68,8 +69,8 @@ typedef struct {
 } atom_exec_context;
 
 int atom_debug = 0;
-static int atom_execute_table_locked(struct atom_context *ctx, int index, uint32_t *params);
-int atom_execute_table(struct atom_context *ctx, int index, uint32_t *params);
+static int atom_execute_table_locked(struct atom_context *ctx, int index, uint32_t *params, int params_size);
+int atom_execute_table(struct atom_context *ctx, int index, uint32_t *params, int params_size);
 
 static uint32_t atom_arg_mask[8] = {
 	0xFFFFFFFF, 0x0000FFFF, 0x00FFFF00, 0xFFFF0000,
@@ -221,7 +222,10 @@ static uint32_t atom_get_src_int(atom_exec_context *ctx, uint8_t attr,
 		(*ptr)++;
 		/* get_unaligned_le32 avoids unaligned accesses from atombios
 		 * tables, noticed on a DEC Alpha. */
-		val = get_unaligned_le32((u32 *)&ctx->ps[idx]);
+		if (idx < ctx->ps_size)
+			val = get_unaligned_le32((u32 *)&ctx->ps[idx]);
+		else
+			pr_info("PS index out of range: %i > %i\n", idx, ctx->ps_size);
 		if (print)
 			DEBUG("PS[0x%02X,0x%04X]", idx, val);
 		break;
@@ -259,7 +263,10 @@ static uint32_t atom_get_src_int(atom_exec_context *ctx, uint8_t attr,
 			val = gctx->reg_block;
 			break;
 		default:
-			val = ctx->ws[idx];
+			if (idx < ctx->ws_size)
+				val = ctx->ws[idx];
+			else
+				pr_info("WS index out of range: %i > %i\n", idx, ctx->ws_size);
 		}
 		break;
 	case ATOM_ARG_ID:
@@ -494,6 +501,10 @@ static void atom_put_dst(atom_exec_context *ctx, int arg, uint8_t attr,
 		idx = U8(*ptr);
 		(*ptr)++;
 		DEBUG("PS[0x%02X]", idx);
+		if (idx >= ctx->ps_size) {
+			pr_info("PS index out of range: %i > %i\n", idx, ctx->ps_size);
+			return;
+		}
 		ctx->ps[idx] = cpu_to_le32(val);
 		break;
 	case ATOM_ARG_WS:
@@ -526,6 +537,10 @@ static void atom_put_dst(atom_exec_context *ctx, int arg, uint8_t attr,
 			gctx->reg_block = val;
 			break;
 		default:
+			if (idx >= ctx->ws_size) {
+				pr_info("WS index out of range: %i > %i\n", idx, ctx->ws_size);
+				return;
+			}
 			ctx->ws[idx] = val;
 		}
 		break;
@@ -623,7 +638,7 @@ static void atom_op_calltable(atom_exec_context *ctx, int *ptr, int arg)
 	else
 		SDEBUG("   table: %d\n", idx);
 	if (U16(ctx->ctx->cmd_table + 4 + 2 * idx))
-		r = atom_execute_table_locked(ctx->ctx, idx, ctx->ps + ctx->ps_shift);
+		r = atom_execute_table_locked(ctx->ctx, idx, ctx->ps + ctx->ps_shift, ctx->ps_size - ctx->ps_shift);
 	if (r) {
 		ctx->abort = true;
 	}
@@ -1152,7 +1167,7 @@ static struct {
 	atom_op_shr, ATOM_ARG_MC}, {
 atom_op_debug, 0},};
 
-static int atom_execute_table_locked(struct atom_context *ctx, int index, uint32_t *params)
+static int atom_execute_table_locked(struct atom_context *ctx, int index, uint32_t *params, int params_size)
 {
 	int base = CU16(ctx->cmd_table + 4 + 2 * index);
 	int len, ws, ps, ptr;
@@ -1174,12 +1189,16 @@ static int atom_execute_table_locked(struct atom_context *ctx, int index, uint32
 	ectx.ps_shift = ps / 4;
 	ectx.start = base;
 	ectx.ps = params;
+	ectx.ps_size = params_size;
 	ectx.abort = false;
 	ectx.last_jump = 0;
-	if (ws)
+	if (ws) {
 		ectx.ws = kcalloc(4, ws, GFP_KERNEL);
-	else
+		ectx.ws_size = ws;
+	} else {
 		ectx.ws = NULL;
+		ectx.ws_size = 0;
+	}
 
 	debug_depth++;
 	while (1) {
@@ -1212,7 +1231,7 @@ static int atom_execute_table_locked(struct atom_context *ctx, int index, uint32
 	return ret;
 }
 
-int atom_execute_table_scratch_unlocked(struct atom_context *ctx, int index, uint32_t *params)
+int atom_execute_table_scratch_unlocked(struct atom_context *ctx, int index, uint32_t *params, int params_size)
 {
 	int r;
 
@@ -1228,16 +1247,16 @@ int atom_execute_table_scratch_unlocked(struct atom_context *ctx, int index, uin
 	/* reset divmul */
 	ctx->divmul[0] = 0;
 	ctx->divmul[1] = 0;
-	r = atom_execute_table_locked(ctx, index, params);
+	r = atom_execute_table_locked(ctx, index, params, params_size);
 	mutex_unlock(&ctx->mutex);
 	return r;
 }
 
-int atom_execute_table(struct atom_context *ctx, int index, uint32_t *params)
+int atom_execute_table(struct atom_context *ctx, int index, uint32_t *params, int params_size)
 {
 	int r;
 	mutex_lock(&ctx->scratch_mutex);
-	r = atom_execute_table_scratch_unlocked(ctx, index, params);
+	r = atom_execute_table_scratch_unlocked(ctx, index, params, params_size);
 	mutex_unlock(&ctx->scratch_mutex);
 	return r;
 }
@@ -1335,7 +1354,7 @@ int atom_asic_init(struct atom_context *ctx)
 
 	if (!CU16(ctx->cmd_table + 4 + 2 * ATOM_CMD_INIT))
 		return 1;
-	ret = atom_execute_table(ctx, ATOM_CMD_INIT, ps);
+	ret = atom_execute_table(ctx, ATOM_CMD_INIT, ps, 16);
 	if (ret)
 		return ret;
 
@@ -1343,7 +1362,7 @@ int atom_asic_init(struct atom_context *ctx)
 
 	if (rdev->family < CHIP_R600) {
 		if (CU16(ctx->cmd_table + 4 + 2 * ATOM_CMD_SPDFANCNTL))
-			atom_execute_table(ctx, ATOM_CMD_SPDFANCNTL, ps);
+			atom_execute_table(ctx, ATOM_CMD_SPDFANCNTL, ps, 16);
 	}
 	return ret;
 }
diff --git a/drivers/gpu/drm/radeon/atom.h b/drivers/gpu/drm/radeon/atom.h
index 5de0563b6..5bf06c0bd 100644
--- a/drivers/gpu/drm/radeon/atom.h
+++ b/drivers/gpu/drm/radeon/atom.h
@@ -145,8 +145,8 @@ struct atom_context {
 extern int atom_debug;
 
 struct atom_context *atom_parse(struct card_info *, void *);
-int atom_execute_table(struct atom_context *, int, uint32_t *);
-int atom_execute_table_scratch_unlocked(struct atom_context *, int, uint32_t *);
+int atom_execute_table(struct atom_context *, int, uint32_t *, int);
+int atom_execute_table_scratch_unlocked(struct atom_context *, int, uint32_t *, int);
 int atom_asic_init(struct atom_context *);
 void atom_destroy(struct atom_context *);
 bool atom_parse_data_header(struct atom_context *ctx, int index, uint16_t *size,
diff --git a/drivers/gpu/drm/radeon/atombios_crtc.c b/drivers/gpu/drm/radeon/atombios_crtc.c
index ade131739..9b3a3a9d6 100644
--- a/drivers/gpu/drm/radeon/atombios_crtc.c
+++ b/drivers/gpu/drm/radeon/atombios_crtc.c
@@ -77,7 +77,7 @@ static void atombios_overscan_setup(struct drm_crtc *crtc,
 		args.usOverscanTop = cpu_to_le16(radeon_crtc->v_border);
 		break;
 	}
-	atom_execute_table(rdev->mode_info.atom_context, index, (uint32_t *)&args);
+	atom_execute_table(rdev->mode_info.atom_context, index, (uint32_t *)&args, sizeof(args));
 }
 
 static void atombios_scaler_setup(struct drm_crtc *crtc)
@@ -157,7 +157,7 @@ static void atombios_scaler_setup(struct drm_crtc *crtc)
 			break;
 		}
 	}
-	atom_execute_table(rdev->mode_info.atom_context, index, (uint32_t *)&args);
+	atom_execute_table(rdev->mode_info.atom_context, index, (uint32_t *)&args, sizeof(args));
 	if ((is_tv || is_cv)
 	    && rdev->family >= CHIP_RV515 && rdev->family <= CHIP_R580) {
 		atom_rv515_force_tv_scaler(rdev, radeon_crtc);
@@ -178,7 +178,7 @@ static void atombios_lock_crtc(struct drm_crtc *crtc, int lock)
 	args.ucCRTC = radeon_crtc->crtc_id;
 	args.ucEnable = lock;
 
-	atom_execute_table(rdev->mode_info.atom_context, index, (uint32_t *)&args);
+	atom_execute_table(rdev->mode_info.atom_context, index, (uint32_t *)&args, sizeof(args));
 }
 
 static void atombios_enable_crtc(struct drm_crtc *crtc, int state)
@@ -194,7 +194,7 @@ static void atombios_enable_crtc(struct drm_crtc *crtc, int state)
 	args.ucCRTC = radeon_crtc->crtc_id;
 	args.ucEnable = state;
 
-	atom_execute_table(rdev->mode_info.atom_context, index, (uint32_t *)&args);
+	atom_execute_table(rdev->mode_info.atom_context, index, (uint32_t *)&args, sizeof(args));
 }
 
 static void atombios_enable_crtc_memreq(struct drm_crtc *crtc, int state)
@@ -210,7 +210,7 @@ static void atombios_enable_crtc_memreq(struct drm_crtc *crtc, int state)
 	args.ucCRTC = radeon_crtc->crtc_id;
 	args.ucEnable = state;
 
-	atom_execute_table(rdev->mode_info.atom_context, index, (uint32_t *)&args);
+	atom_execute_table(rdev->mode_info.atom_context, index, (uint32_t *)&args, sizeof(args));
 }
 
 static const u32 vga_control_regs[6] =
@@ -242,7 +242,7 @@ static void atombios_blank_crtc(struct drm_crtc *crtc, int state)
 	args.ucCRTC = radeon_crtc->crtc_id;
 	args.ucBlanking = state;
 
-	atom_execute_table(rdev->mode_info.atom_context, index, (uint32_t *)&args);
+	atom_execute_table(rdev->mode_info.atom_context, index, (uint32_t *)&args, sizeof(args));
 
 	if (ASIC_IS_DCE8(rdev))
 		WREG32(vga_control_regs[radeon_crtc->crtc_id], vga_control);
@@ -261,7 +261,7 @@ static void atombios_powergate_crtc(struct drm_crtc *crtc, int state)
 	args.ucDispPipeId = radeon_crtc->crtc_id;
 	args.ucEnable = state;
 
-	atom_execute_table(rdev->mode_info.atom_context, index, (uint32_t *)&args);
+	atom_execute_table(rdev->mode_info.atom_context, index, (uint32_t *)&args, sizeof(args));
 }
 
 void atombios_crtc_dpms(struct drm_crtc *crtc, int mode)
@@ -343,7 +343,7 @@ atombios_set_crtc_dtd_timing(struct drm_crtc *crtc,
 	args.susModeMiscInfo.usAccess = cpu_to_le16(misc);
 	args.ucCRTC = radeon_crtc->crtc_id;
 
-	atom_execute_table(rdev->mode_info.atom_context, index, (uint32_t *)&args);
+	atom_execute_table(rdev->mode_info.atom_context, index, (uint32_t *)&args, sizeof(args));
 }
 
 static void atombios_crtc_set_timing(struct drm_crtc *crtc,
@@ -389,7 +389,7 @@ static void atombios_crtc_set_timing(struct drm_crtc *crtc,
 	args.susModeMiscInfo.usAccess = cpu_to_le16(misc);
 	args.ucCRTC = radeon_crtc->crtc_id;
 
-	atom_execute_table(rdev->mode_info.atom_context, index, (uint32_t *)&args);
+	atom_execute_table(rdev->mode_info.atom_context, index, (uint32_t *)&args, sizeof(args));
 }
 
 static void atombios_disable_ss(struct radeon_device *rdev, int pll_id)
@@ -546,7 +546,7 @@ static void atombios_crtc_program_ss(struct radeon_device *rdev,
 		args.lvds_ss.ucSpreadSpectrumStepSize_Delay |= (ss->delay & 7) << 4;
 		args.lvds_ss.ucEnable = enable;
 	}
-	atom_execute_table(rdev->mode_info.atom_context, index, (uint32_t *)&args);
+	atom_execute_table(rdev->mode_info.atom_context, index, (uint32_t *)&args, sizeof(args));
 }
 
 union adjust_pixel_clock {
@@ -692,7 +692,7 @@ static u32 atombios_adjust_pll(struct drm_crtc *crtc,
 						ADJUST_DISPLAY_CONFIG_SS_ENABLE;
 
 				atom_execute_table(rdev->mode_info.atom_context,
-						   index, (uint32_t *)&args);
+						   index, (uint32_t *)&args, sizeof(args));
 				adjusted_clock = le16_to_cpu(args.v1.usPixelClock) * 10;
 				break;
 			case 3:
@@ -725,7 +725,7 @@ static u32 atombios_adjust_pll(struct drm_crtc *crtc,
 					args.v3.sInput.ucExtTransmitterID = 0;
 
 				atom_execute_table(rdev->mode_info.atom_context,
-						   index, (uint32_t *)&args);
+						   index, (uint32_t *)&args, sizeof(args));
 				adjusted_clock = le32_to_cpu(args.v3.sOutput.ulDispPllFreq) * 10;
 				if (args.v3.sOutput.ucRefDiv) {
 					radeon_crtc->pll_flags |= RADEON_PLL_USE_FRAC_FB_DIV;
@@ -809,7 +809,7 @@ static void atombios_crtc_set_disp_eng_pll(struct radeon_device *rdev,
 		DRM_ERROR("Unknown table version %d %d\n", frev, crev);
 		return;
 	}
-	atom_execute_table(rdev->mode_info.atom_context, index, (uint32_t *)&args);
+	atom_execute_table(rdev->mode_info.atom_context, index, (uint32_t *)&args, sizeof(args));
 }
 
 static void atombios_crtc_program_pll(struct drm_crtc *crtc,
@@ -949,7 +949,7 @@ static void atombios_crtc_program_pll(struct drm_crtc *crtc,
 		return;
 	}
 
-	atom_execute_table(rdev->mode_info.atom_context, index, (uint32_t *)&args);
+	atom_execute_table(rdev->mode_info.atom_context, index, (uint32_t *)&args, sizeof(args));
 }
 
 static bool atombios_crtc_prepare_pll(struct drm_crtc *crtc, struct drm_display_mode *mode)
diff --git a/drivers/gpu/drm/radeon/atombios_dp.c b/drivers/gpu/drm/radeon/atombios_dp.c
index 009333645..fca8b0853 100644
--- a/drivers/gpu/drm/radeon/atombios_dp.c
+++ b/drivers/gpu/drm/radeon/atombios_dp.c
@@ -112,7 +112,7 @@ static int radeon_process_aux_ch(struct radeon_i2c_chan *chan,
 	if (ASIC_IS_DCE4(rdev))
 		args.v2.ucHPD_ID = chan->rec.hpd;
 
-	atom_execute_table_scratch_unlocked(rdev->mode_info.atom_context, index, (uint32_t *)&args);
+	atom_execute_table_scratch_unlocked(rdev->mode_info.atom_context, index, (uint32_t *)&args, sizeof(args));
 
 	*ack = args.v1.ucReplyStatus;
 
@@ -354,7 +354,7 @@ static u8 radeon_dp_encoder_service(struct radeon_device *rdev,
 	args.ucLaneNum = lane_num;
 	args.ucStatus = 0;
 
-	atom_execute_table(rdev->mode_info.atom_context, index, (uint32_t *)&args);
+	atom_execute_table(rdev->mode_info.atom_context, index, (uint32_t *)&args, sizeof(args));
 	return args.ucStatus;
 }
 
diff --git a/drivers/gpu/drm/radeon/atombios_encoders.c b/drivers/gpu/drm/radeon/atombios_encoders.c
index 4aca09cab..cb5f099a1 100644
--- a/drivers/gpu/drm/radeon/atombios_encoders.c
+++ b/drivers/gpu/drm/radeon/atombios_encoders.c
@@ -118,12 +118,12 @@ atombios_set_backlight_level(struct radeon_encoder *radeon_encoder, u8 level)
 			index = GetIndexIntoMasterTable(COMMAND, LCD1OutputControl);
 			if (dig->backlight_level == 0) {
 				args.ucAction = ATOM_LCD_BLOFF;
-				atom_execute_table(rdev->mode_info.atom_context, index, (uint32_t *)&args);
+				atom_execute_table(rdev->mode_info.atom_context, index, (uint32_t *)&args, sizeof(args));
 			} else {
 				args.ucAction = ATOM_LCD_BL_BRIGHTNESS_CONTROL;
-				atom_execute_table(rdev->mode_info.atom_context, index, (uint32_t *)&args);
+				atom_execute_table(rdev->mode_info.atom_context, index, (uint32_t *)&args, sizeof(args));
 				args.ucAction = ATOM_LCD_BLON;
-				atom_execute_table(rdev->mode_info.atom_context, index, (uint32_t *)&args);
+				atom_execute_table(rdev->mode_info.atom_context, index, (uint32_t *)&args, sizeof(args));
 			}
 			break;
 		case ENCODER_OBJECT_ID_INTERNAL_UNIPHY:
@@ -388,7 +388,7 @@ atombios_dac_setup(struct drm_encoder *encoder, int action)
 	}
 	args.usPixelClock = cpu_to_le16(radeon_encoder->pixel_clock / 10);
 
-	atom_execute_table(rdev->mode_info.atom_context, index, (uint32_t *)&args);
+	atom_execute_table(rdev->mode_info.atom_context, index, (uint32_t *)&args, sizeof(args));
 
 }
 
@@ -444,7 +444,7 @@ atombios_tv_setup(struct drm_encoder *encoder, int action)
 
 	args.sTVEncoder.usPixelClock = cpu_to_le16(radeon_encoder->pixel_clock / 10);
 
-	atom_execute_table(rdev->mode_info.atom_context, index, (uint32_t *)&args);
+	atom_execute_table(rdev->mode_info.atom_context, index, (uint32_t *)&args, sizeof(args));
 
 }
 
@@ -545,7 +545,7 @@ atombios_dvo_setup(struct drm_encoder *encoder, int action)
 		break;
 	}
 
-	atom_execute_table(rdev->mode_info.atom_context, index, (uint32_t *)&args);
+	atom_execute_table(rdev->mode_info.atom_context, index, (uint32_t *)&args, sizeof(args));
 }
 
 union lvds_encoder_control {
@@ -663,7 +663,7 @@ atombios_digital_setup(struct drm_encoder *encoder, int action)
 		break;
 	}
 
-	atom_execute_table(rdev->mode_info.atom_context, index, (uint32_t *)&args);
+	atom_execute_table(rdev->mode_info.atom_context, index, (uint32_t *)&args, sizeof(args));
 }
 
 int
@@ -978,7 +978,7 @@ atombios_dig_encoder_setup2(struct drm_encoder *encoder, int action, int panel_m
 		break;
 	}
 
-	atom_execute_table(rdev->mode_info.atom_context, index, (uint32_t *)&args);
+	atom_execute_table(rdev->mode_info.atom_context, index, (uint32_t *)&args, sizeof(args));
 
 }
 
@@ -1360,7 +1360,7 @@ atombios_dig_transmitter_setup2(struct drm_encoder *encoder, int action, uint8_t
 		break;
 	}
 
-	atom_execute_table(rdev->mode_info.atom_context, index, (uint32_t *)&args);
+	atom_execute_table(rdev->mode_info.atom_context, index, (uint32_t *)&args, sizeof(args));
 }
 
 void
@@ -1396,7 +1396,7 @@ atombios_set_edp_panel_power(struct drm_connector *connector, int action)
 
 	args.v1.ucAction = action;
 
-	atom_execute_table(rdev->mode_info.atom_context, index, (uint32_t *)&args);
+	atom_execute_table(rdev->mode_info.atom_context, index, (uint32_t *)&args, sizeof(args));
 
 	/* wait for the panel to power up */
 	if (action == ATOM_TRANSMITTER_ACTION_POWER_ON) {
@@ -1518,7 +1518,7 @@ atombios_external_encoder_setup(struct drm_encoder *encoder,
 		DRM_ERROR("Unknown table version: %d, %d\n", frev, crev);
 		return;
 	}
-	atom_execute_table(rdev->mode_info.atom_context, index, (uint32_t *)&args);
+	atom_execute_table(rdev->mode_info.atom_context, index, (uint32_t *)&args, sizeof(args));
 }
 
 static void
@@ -1553,7 +1553,7 @@ atombios_yuv_setup(struct drm_encoder *encoder, bool enable)
 		args.ucEnable = ATOM_ENABLE;
 	args.ucCRTC = radeon_crtc->crtc_id;
 
-	atom_execute_table(rdev->mode_info.atom_context, index, (uint32_t *)&args);
+	atom_execute_table(rdev->mode_info.atom_context, index, (uint32_t *)&args, sizeof(args));
 
 	WREG32(reg, temp);
 }
@@ -1617,10 +1617,10 @@ radeon_atom_encoder_dpms_avivo(struct drm_encoder *encoder, int mode)
 		if (radeon_encoder->encoder_id == ENCODER_OBJECT_ID_INTERNAL_DDI) {
 			u32 reg = RREG32(RADEON_BIOS_3_SCRATCH);
 			WREG32(RADEON_BIOS_3_SCRATCH, reg & ~ATOM_S3_DFP2I_ACTIVE);
-			atom_execute_table(rdev->mode_info.atom_context, index, (uint32_t *)&args);
+			atom_execute_table(rdev->mode_info.atom_context, index, (uint32_t *)&args, sizeof(args));
 			WREG32(RADEON_BIOS_3_SCRATCH, reg);
 		} else
-			atom_execute_table(rdev->mode_info.atom_context, index, (uint32_t *)&args);
+			atom_execute_table(rdev->mode_info.atom_context, index, (uint32_t *)&args, sizeof(args));
 		if (radeon_encoder->devices & (ATOM_DEVICE_LCD_SUPPORT)) {
 			if (rdev->mode_info.bl_encoder) {
 				struct radeon_encoder_atom_dig *dig = radeon_encoder->enc_priv;
@@ -1628,7 +1628,7 @@ radeon_atom_encoder_dpms_avivo(struct drm_encoder *encoder, int mode)
 				atombios_set_backlight_level(radeon_encoder, dig->backlight_level);
 			} else {
 				args.ucAction = ATOM_LCD_BLON;
-				atom_execute_table(rdev->mode_info.atom_context, index, (uint32_t *)&args);
+				atom_execute_table(rdev->mode_info.atom_context, index, (uint32_t *)&args, sizeof(args));
 			}
 		}
 		break;
@@ -1636,10 +1636,10 @@ radeon_atom_encoder_dpms_avivo(struct drm_encoder *encoder, int mode)
 	case DRM_MODE_DPMS_SUSPEND:
 	case DRM_MODE_DPMS_OFF:
 		args.ucAction = ATOM_DISABLE;
-		atom_execute_table(rdev->mode_info.atom_context, index, (uint32_t *)&args);
+		atom_execute_table(rdev->mode_info.atom_context, index, (uint32_t *)&args, sizeof(args));
 		if (radeon_encoder->devices & (ATOM_DEVICE_LCD_SUPPORT)) {
 			args.ucAction = ATOM_LCD_BLOFF;
-			atom_execute_table(rdev->mode_info.atom_context, index, (uint32_t *)&args);
+			atom_execute_table(rdev->mode_info.atom_context, index, (uint32_t *)&args, sizeof(args));
 		}
 		break;
 	}
@@ -1982,7 +1982,7 @@ atombios_set_encoder_crtc_source(struct drm_encoder *encoder)
 		return;
 	}
 
-	atom_execute_table(rdev->mode_info.atom_context, index, (uint32_t *)&args);
+	atom_execute_table(rdev->mode_info.atom_context, index, (uint32_t *)&args, sizeof(args));
 
 	/* update scratch regs with new routing */
 	radeon_atombios_encoder_crtc_scratch_regs(encoder, radeon_crtc->crtc_id);
@@ -2310,7 +2310,7 @@ atombios_dac_load_detect(struct drm_encoder *encoder, struct drm_connector *conn
 				args.sDacload.ucMisc = DAC_LOAD_MISC_YPrPb;
 		}
 
-		atom_execute_table(rdev->mode_info.atom_context, index, (uint32_t *)&args);
+		atom_execute_table(rdev->mode_info.atom_context, index, (uint32_t *)&args, sizeof(args));
 
 		return true;
 	} else
diff --git a/drivers/gpu/drm/radeon/atombios_i2c.c b/drivers/gpu/drm/radeon/atombios_i2c.c
index ab4d21072..730f0b253 100644
--- a/drivers/gpu/drm/radeon/atombios_i2c.c
+++ b/drivers/gpu/drm/radeon/atombios_i2c.c
@@ -78,7 +78,7 @@ static int radeon_process_i2c_ch(struct radeon_i2c_chan *chan,
 	args.ucSlaveAddr = slave_addr << 1;
 	args.ucLineNumber = chan->rec.i2c_id;
 
-	atom_execute_table_scratch_unlocked(rdev->mode_info.atom_context, index, (uint32_t *)&args);
+	atom_execute_table_scratch_unlocked(rdev->mode_info.atom_context, index, (uint32_t *)&args, sizeof(args));
 
 	/* error */
 	if (args.ucStatus != HW_ASSISTED_I2C_STATUS_SUCCESS) {
diff --git a/drivers/gpu/drm/radeon/radeon_atombios.c b/drivers/gpu/drm/radeon/radeon_atombios.c
index 85c4bb186..697c104bd 100644
--- a/drivers/gpu/drm/radeon/radeon_atombios.c
+++ b/drivers/gpu/drm/radeon/radeon_atombios.c
@@ -2851,7 +2851,7 @@ int radeon_atom_get_clock_dividers(struct radeon_device *rdev,
 		args.v1.ucAction = clock_type;
 		args.v1.ulClock = cpu_to_le32(clock);	/* 10 khz */
 
-		atom_execute_table(rdev->mode_info.atom_context, index, (uint32_t *)&args);
+		atom_execute_table(rdev->mode_info.atom_context, index, (uint32_t *)&args, sizeof(args));
 
 		dividers->post_div = args.v1.ucPostDiv;
 		dividers->fb_div = args.v1.ucFbDiv;
@@ -2865,7 +2865,7 @@ int radeon_atom_get_clock_dividers(struct radeon_device *rdev,
 			args.v2.ucAction = clock_type;
 			args.v2.ulClock = cpu_to_le32(clock);	/* 10 khz */
 
-			atom_execute_table(rdev->mode_info.atom_context, index, (uint32_t *)&args);
+			atom_execute_table(rdev->mode_info.atom_context, index, (uint32_t *)&args, sizeof(args));
 
 			dividers->post_div = args.v2.ucPostDiv;
 			dividers->fb_div = le16_to_cpu(args.v2.usFbDiv);
@@ -2880,7 +2880,7 @@ int radeon_atom_get_clock_dividers(struct radeon_device *rdev,
 			if (clock_type == COMPUTE_ENGINE_PLL_PARAM) {
 				args.v3.ulClockParams = cpu_to_le32((clock_type << 24) | clock);
 
-				atom_execute_table(rdev->mode_info.atom_context, index, (uint32_t *)&args);
+				atom_execute_table(rdev->mode_info.atom_context, index, (uint32_t *)&args, sizeof(args));
 
 				dividers->post_div = args.v3.ucPostDiv;
 				dividers->enable_post_div = (args.v3.ucCntlFlag &
@@ -2900,7 +2900,7 @@ int radeon_atom_get_clock_dividers(struct radeon_device *rdev,
 				if (strobe_mode)
 					args.v5.ucInputFlag = ATOM_PLL_INPUT_FLAG_PLL_STROBE_MODE_EN;
 
-				atom_execute_table(rdev->mode_info.atom_context, index, (uint32_t *)&args);
+				atom_execute_table(rdev->mode_info.atom_context, index, (uint32_t *)&args, sizeof(args));
 
 				dividers->post_div = args.v5.ucPostDiv;
 				dividers->enable_post_div = (args.v5.ucCntlFlag &
@@ -2919,7 +2919,7 @@ int radeon_atom_get_clock_dividers(struct radeon_device *rdev,
 		/* fusion */
 		args.v4.ulClock = cpu_to_le32(clock);	/* 10 khz */
 
-		atom_execute_table(rdev->mode_info.atom_context, index, (uint32_t *)&args);
+		atom_execute_table(rdev->mode_info.atom_context, index, (uint32_t *)&args, sizeof(args));
 
 		dividers->post_divider = dividers->post_div = args.v4.ucPostDiv;
 		dividers->real_clock = le32_to_cpu(args.v4.ulClock);
@@ -2930,7 +2930,7 @@ int radeon_atom_get_clock_dividers(struct radeon_device *rdev,
 		args.v6_in.ulClock.ulComputeClockFlag = clock_type;
 		args.v6_in.ulClock.ulClockFreq = cpu_to_le32(clock);	/* 10 khz */
 
-		atom_execute_table(rdev->mode_info.atom_context, index, (uint32_t *)&args);
+		atom_execute_table(rdev->mode_info.atom_context, index, (uint32_t *)&args, sizeof(args));
 
 		dividers->whole_fb_div = le16_to_cpu(args.v6_out.ulFbDiv.usFbDiv);
 		dividers->frac_fb_div = le16_to_cpu(args.v6_out.ulFbDiv.usFbDivFrac);
@@ -2971,7 +2971,7 @@ int radeon_atom_get_memory_pll_dividers(struct radeon_device *rdev,
 			if (strobe_mode)
 				args.ucInputFlag |= MPLL_INPUT_FLAG_STROBE_MODE_EN;
 
-			atom_execute_table(rdev->mode_info.atom_context, index, (uint32_t *)&args);
+			atom_execute_table(rdev->mode_info.atom_context, index, (uint32_t *)&args, sizeof(args));
 
 			mpll_param->clkfrac = le16_to_cpu(args.ulFbDiv.usFbDivFrac);
 			mpll_param->clkf = le16_to_cpu(args.ulFbDiv.usFbDiv);
@@ -3004,7 +3004,7 @@ void radeon_atom_set_clock_gating(struct radeon_device *rdev, int enable)
 
 	args.ucEnable = enable;
 
-	atom_execute_table(rdev->mode_info.atom_context, index, (uint32_t *)&args);
+	atom_execute_table(rdev->mode_info.atom_context, index, (uint32_t *)&args, sizeof(args));
 }
 
 uint32_t radeon_atom_get_engine_clock(struct radeon_device *rdev)
@@ -3012,7 +3012,7 @@ uint32_t radeon_atom_get_engine_clock(struct radeon_device *rdev)
 	GET_ENGINE_CLOCK_PS_ALLOCATION args;
 	int index = GetIndexIntoMasterTable(COMMAND, GetEngineClock);
 
-	atom_execute_table(rdev->mode_info.atom_context, index, (uint32_t *)&args);
+	atom_execute_table(rdev->mode_info.atom_context, index, (uint32_t *)&args, sizeof(args));
 	return le32_to_cpu(args.ulReturnEngineClock);
 }
 
@@ -3021,7 +3021,7 @@ uint32_t radeon_atom_get_memory_clock(struct radeon_device *rdev)
 	GET_MEMORY_CLOCK_PS_ALLOCATION args;
 	int index = GetIndexIntoMasterTable(COMMAND, GetMemoryClock);
 
-	atom_execute_table(rdev->mode_info.atom_context, index, (uint32_t *)&args);
+	atom_execute_table(rdev->mode_info.atom_context, index, (uint32_t *)&args, sizeof(args));
 	return le32_to_cpu(args.ulReturnMemoryClock);
 }
 
@@ -3033,7 +3033,7 @@ void radeon_atom_set_engine_clock(struct radeon_device *rdev,
 
 	args.ulTargetEngineClock = cpu_to_le32(eng_clock);	/* 10 khz */
 
-	atom_execute_table(rdev->mode_info.atom_context, index, (uint32_t *)&args);
+	atom_execute_table(rdev->mode_info.atom_context, index, (uint32_t *)&args, sizeof(args));
 }
 
 void radeon_atom_set_memory_clock(struct radeon_device *rdev,
@@ -3047,7 +3047,7 @@ void radeon_atom_set_memory_clock(struct radeon_device *rdev,
 
 	args.ulTargetMemoryClock = cpu_to_le32(mem_clock);	/* 10 khz */
 
-	atom_execute_table(rdev->mode_info.atom_context, index, (uint32_t *)&args);
+	atom_execute_table(rdev->mode_info.atom_context, index, (uint32_t *)&args, sizeof(args));
 }
 
 void radeon_atom_set_engine_dram_timings(struct radeon_device *rdev,
@@ -3066,7 +3066,7 @@ void radeon_atom_set_engine_dram_timings(struct radeon_device *rdev,
 	if (mem_clock)
 		args.sReserved.ulClock = cpu_to_le32(mem_clock & SET_CLOCK_FREQ_MASK);
 
-	atom_execute_table(rdev->mode_info.atom_context, index, (uint32_t *)&args);
+	atom_execute_table(rdev->mode_info.atom_context, index, (uint32_t *)&args, sizeof(args));
 }
 
 void radeon_atom_update_memory_dll(struct radeon_device *rdev,
@@ -3077,7 +3077,7 @@ void radeon_atom_update_memory_dll(struct radeon_device *rdev,
 
 	args = cpu_to_le32(mem_clock);	/* 10 khz */
 
-	atom_execute_table(rdev->mode_info.atom_context, index, (uint32_t *)&args);
+	atom_execute_table(rdev->mode_info.atom_context, index, (uint32_t *)&args, sizeof(args));
 }
 
 void radeon_atom_set_ac_timing(struct radeon_device *rdev,
@@ -3089,7 +3089,7 @@ void radeon_atom_set_ac_timing(struct radeon_device *rdev,
 
 	args.ulTargetMemoryClock = cpu_to_le32(tmp);	/* 10 khz */
 
-	atom_execute_table(rdev->mode_info.atom_context, index, (uint32_t *)&args);
+	atom_execute_table(rdev->mode_info.atom_context, index, (uint32_t *)&args, sizeof(args));
 }
 
 union set_voltage {
@@ -3133,7 +3133,7 @@ void radeon_atom_set_voltage(struct radeon_device *rdev, u16 voltage_level, u8 v
 		return;
 	}
 
-	atom_execute_table(rdev->mode_info.atom_context, index, (uint32_t *)&args);
+	atom_execute_table(rdev->mode_info.atom_context, index, (uint32_t *)&args, sizeof(args));
 }
 
 int radeon_atom_get_max_vddc(struct radeon_device *rdev, u8 voltage_type,
@@ -3154,7 +3154,7 @@ int radeon_atom_get_max_vddc(struct radeon_device *rdev, u8 voltage_type,
 		args.v2.ucVoltageMode = 0;
 		args.v2.usVoltageLevel = 0;
 
-		atom_execute_table(rdev->mode_info.atom_context, index, (uint32_t *)&args);
+		atom_execute_table(rdev->mode_info.atom_context, index, (uint32_t *)&args, sizeof(args));
 
 		*voltage = le16_to_cpu(args.v2.usVoltageLevel);
 		break;
@@ -3163,7 +3163,7 @@ int radeon_atom_get_max_vddc(struct radeon_device *rdev, u8 voltage_type,
 		args.v3.ucVoltageMode = ATOM_GET_VOLTAGE_LEVEL;
 		args.v3.usVoltageLevel = cpu_to_le16(voltage_id);
 
-		atom_execute_table(rdev->mode_info.atom_context, index, (uint32_t *)&args);
+		atom_execute_table(rdev->mode_info.atom_context, index, (uint32_t *)&args, sizeof(args));
 
 		*voltage = le16_to_cpu(args.v3.usVoltageLevel);
 		break;
@@ -3199,7 +3199,7 @@ int radeon_atom_get_leakage_id_from_vbios(struct radeon_device *rdev,
 		args.v3.ucVoltageMode = ATOM_GET_LEAKAGE_ID;
 		args.v3.usVoltageLevel = 0;
 
-		atom_execute_table(rdev->mode_info.atom_context, index, (uint32_t *)&args);
+		atom_execute_table(rdev->mode_info.atom_context, index, (uint32_t *)&args, sizeof(args));
 
 		*leakage_id = le16_to_cpu(args.v3.usVoltageLevel);
 		break;
@@ -3326,7 +3326,7 @@ int radeon_atom_get_voltage_evv(struct radeon_device *rdev,
 	args.in.ulSCLKFreq =
 		cpu_to_le32(rdev->pm.dpm.dyn_state.vddc_dependency_on_sclk.entries[entry_id].clk);
 
-	atom_execute_table(rdev->mode_info.atom_context, index, (uint32_t *)&args);
+	atom_execute_table(rdev->mode_info.atom_context, index, (uint32_t *)&args, sizeof(args));
 
 	*voltage = le16_to_cpu(args.evv_out.usVoltageLevel);
 
@@ -3352,7 +3352,7 @@ int radeon_atom_get_voltage_gpio_settings(struct radeon_device *rdev,
 		args.v2.ucVoltageMode = SET_ASIC_VOLTAGE_MODE_GET_GPIOMASK;
 		args.v2.usVoltageLevel = cpu_to_le16(voltage_level);
 
-		atom_execute_table(rdev->mode_info.atom_context, index, (uint32_t *)&args);
+		atom_execute_table(rdev->mode_info.atom_context, index, (uint32_t *)&args, sizeof(args));
 
 		*gpio_mask = le32_to_cpu(*(u32 *)&args.v2);
 
@@ -3360,7 +3360,7 @@ int radeon_atom_get_voltage_gpio_settings(struct radeon_device *rdev,
 		args.v2.ucVoltageMode = SET_ASIC_VOLTAGE_MODE_GET_GPIOVAL;
 		args.v2.usVoltageLevel = cpu_to_le16(voltage_level);
 
-		atom_execute_table(rdev->mode_info.atom_context, index, (uint32_t *)&args);
+		atom_execute_table(rdev->mode_info.atom_context, index, (uint32_t *)&args, sizeof(args));
 
 		*gpio_value = le32_to_cpu(*(u32 *)&args.v2);
 		break;
-- 
2.43.0

