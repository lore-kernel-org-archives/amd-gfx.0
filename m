Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9BF19C47422
	for <amd-gfx@archiver.kernel.org>; Thu, 11 Jan 2024 15:12:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B8EAC10E92D;
	Thu, 11 Jan 2024 15:12:24 +0000 (UTC)
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com
 [IPv6:2a00:1450:4864:20::633])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E8C4D10E916
 for <amd-gfx@lists.freedesktop.org>; Thu, 11 Jan 2024 15:05:54 +0000 (UTC)
Received: by mail-ej1-x633.google.com with SMTP id
 a640c23a62f3a-a2c375d2430so122646366b.1
 for <amd-gfx@lists.freedesktop.org>; Thu, 11 Jan 2024 07:05:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1704985553; x=1705590353; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=J0bpAOqaEpIPE71BRPUX9H0gFCPA3N/shp9tBJdDbK4=;
 b=OUJvyPm5frMZZKk1q5H9ooEF6SyFkyo1VYRjbBKJTIyHiY4PiI+YtBA9Eno0N38WxP
 Nbrkm1GvqjaDlRQ0LfilConrqX984eiTw0xwj1anDzX7IPwRiVKhHXjMsmhDzw0qED5+
 r58kh1KtBN+DLnuY5ytzcah0EwlE3LXSQZu/EnK+BnY2t510vOBaq7uZXFyCSFL4+1Fx
 GgAGOLzJsYSPHa/7GRjY0IEpjMiddXWkFzVR8pQbtNDZdn9Vug8OLsrb2aZl2Zu0cWaH
 Yu0Y6rtyJX5F1uamVffLsS8Xgwz7TGs20Kj61/VtWVb3O0+cG/f29G+D6qBrJHQ1prEf
 bivg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704985553; x=1705590353;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=J0bpAOqaEpIPE71BRPUX9H0gFCPA3N/shp9tBJdDbK4=;
 b=w+q2UgmH23cuHKNeAiUGYZ5PzKSOsKP2GXICjY+B6XfvMypaoEuYjJg9fSw6gwm5gF
 E9coOP7SOfirluoPLDpGPBjcyP3Ab8mbgfqmSocsYHjjW1C/ddEaXsEXcr+qb4SdN2U6
 XmsHkJunidiSy4lmkJpUxJBftrxQnVlS6nN7SFKj/mbWigkLqWU+MNvR8BlDNHCMZjb3
 Av/aqcjG0SZonSQWWhoXv/NadUVDg2dxnW6EvGXnsDgb4eRjGxuYpIguxjA5Wa2PWHzN
 VhnSZbFBJy06NWpTKlE03QUa3sFu96qugRvbswTfEMb1Cr0rV6d+Rm4mNgJVsWmqPq4J
 +lOg==
X-Gm-Message-State: AOJu0YzHKEZLaZFG9VpFiPMWwvWOTCfwmCgy4XDUstPmozzb3jlZAcFb
 iQQ6SK/ttoE8BFuY1q8MWp5xECC0yn0=
X-Google-Smtp-Source: AGHT+IGqRRm3tG4RTAwD45pgrDCYKDfsmhSG6bxzsBrObV42ZDhFu2pyXAQknIByW0g5xmgAexYlXw==
X-Received: by 2002:a17:906:fa15:b0:a28:c148:d79f with SMTP id
 lo21-20020a170906fa1500b00a28c148d79fmr728523ejb.60.1704985552742; 
 Thu, 11 Jan 2024 07:05:52 -0800 (PST)
Received: from alex-computer.home (91-114-185-105.adsl.highway.telekom.at.
 [91.114.185.105]) by smtp.googlemail.com with ESMTPSA id
 d15-20020a170906c20f00b00a2ae7fb3fc6sm686116ejz.93.2024.01.11.07.05.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 11 Jan 2024 07:05:52 -0800 (PST)
From: Alexander <electrodeyt@gmail.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 1/2] drm/amdgpu: check PS, WS index
Date: Thu, 11 Jan 2024 16:04:48 +0100
Message-ID: <20240111150516.743276-2-electrodeyt@gmail.com>
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
 drivers/gpu/drm/amd/amdgpu/amdgpu_atombios.c  | 24 +++++++----
 .../gpu/drm/amd/amdgpu/amdgpu_atomfirmware.c  |  3 +-
 drivers/gpu/drm/amd/amdgpu/atom.c             | 41 +++++++++++++-----
 drivers/gpu/drm/amd/amdgpu/atom.h             |  2 +-
 drivers/gpu/drm/amd/amdgpu/atombios_crtc.c    | 28 ++++++-------
 drivers/gpu/drm/amd/amdgpu/atombios_dp.c      |  4 +-
 .../gpu/drm/amd/amdgpu/atombios_encoders.c    | 16 +++----
 drivers/gpu/drm/amd/amdgpu/atombios_i2c.c     |  4 +-
 .../drm/amd/display/dc/bios/command_table.c   |  2 +-
 .../drm/amd/display/dc/bios/command_table2.c  |  2 +-
 .../drm/amd/pm/powerplay/hwmgr/ppatomctrl.c   | 42 +++++++++----------
 .../drm/amd/pm/powerplay/hwmgr/ppatomfwctrl.c |  4 +-
 .../gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c    |  2 +-
 .../gpu/drm/amd/pm/swsmu/smu12/smu_v12_0.c    |  2 +-
 14 files changed, 102 insertions(+), 74 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_atombios.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_atombios.c
index dce9e7d5e..52b12c171 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_atombios.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_atombios.c
@@ -1018,7 +1018,8 @@ int amdgpu_atombios_get_clock_dividers(struct amdgpu_device *adev,
 		if (clock_type == COMPUTE_ENGINE_PLL_PARAM) {
 			args.v3.ulClockParams = cpu_to_le32((clock_type << 24) | clock);
 
-			amdgpu_atom_execute_table(adev->mode_info.atom_context, index, (uint32_t *)&args);
+			amdgpu_atom_execute_table(adev->mode_info.atom_context, index, (uint32_t *)&args,
+				sizeof(args));
 
 			dividers->post_div = args.v3.ucPostDiv;
 			dividers->enable_post_div = (args.v3.ucCntlFlag &
@@ -1038,7 +1039,8 @@ int amdgpu_atombios_get_clock_dividers(struct amdgpu_device *adev,
 			if (strobe_mode)
 				args.v5.ucInputFlag = ATOM_PLL_INPUT_FLAG_PLL_STROBE_MODE_EN;
 
-			amdgpu_atom_execute_table(adev->mode_info.atom_context, index, (uint32_t *)&args);
+			amdgpu_atom_execute_table(adev->mode_info.atom_context, index, (uint32_t *)&args,
+				sizeof(args));
 
 			dividers->post_div = args.v5.ucPostDiv;
 			dividers->enable_post_div = (args.v5.ucCntlFlag &
@@ -1056,7 +1058,8 @@ int amdgpu_atombios_get_clock_dividers(struct amdgpu_device *adev,
 		/* fusion */
 		args.v4.ulClock = cpu_to_le32(clock);	/* 10 khz */
 
-		amdgpu_atom_execute_table(adev->mode_info.atom_context, index, (uint32_t *)&args);
+		amdgpu_atom_execute_table(adev->mode_info.atom_context, index, (uint32_t *)&args,
+			sizeof(args));
 
 		dividers->post_divider = dividers->post_div = args.v4.ucPostDiv;
 		dividers->real_clock = le32_to_cpu(args.v4.ulClock);
@@ -1067,7 +1070,8 @@ int amdgpu_atombios_get_clock_dividers(struct amdgpu_device *adev,
 		args.v6_in.ulClock.ulComputeClockFlag = clock_type;
 		args.v6_in.ulClock.ulClockFreq = cpu_to_le32(clock);	/* 10 khz */
 
-		amdgpu_atom_execute_table(adev->mode_info.atom_context, index, (uint32_t *)&args);
+		amdgpu_atom_execute_table(adev->mode_info.atom_context, index, (uint32_t *)&args,
+			sizeof(args));
 
 		dividers->whole_fb_div = le16_to_cpu(args.v6_out.ulFbDiv.usFbDiv);
 		dividers->frac_fb_div = le16_to_cpu(args.v6_out.ulFbDiv.usFbDivFrac);
@@ -1109,7 +1113,8 @@ int amdgpu_atombios_get_memory_pll_dividers(struct amdgpu_device *adev,
 			if (strobe_mode)
 				args.ucInputFlag |= MPLL_INPUT_FLAG_STROBE_MODE_EN;
 
-			amdgpu_atom_execute_table(adev->mode_info.atom_context, index, (uint32_t *)&args);
+			amdgpu_atom_execute_table(adev->mode_info.atom_context, index, (uint32_t *)&args,
+				sizeof(args));
 
 			mpll_param->clkfrac = le16_to_cpu(args.ulFbDiv.usFbDivFrac);
 			mpll_param->clkf = le16_to_cpu(args.ulFbDiv.usFbDiv);
@@ -1151,7 +1156,8 @@ void amdgpu_atombios_set_engine_dram_timings(struct amdgpu_device *adev,
 	if (mem_clock)
 		args.sReserved.ulClock = cpu_to_le32(mem_clock & SET_CLOCK_FREQ_MASK);
 
-	amdgpu_atom_execute_table(adev->mode_info.atom_context, index, (uint32_t *)&args);
+	amdgpu_atom_execute_table(adev->mode_info.atom_context, index, (uint32_t *)&args,
+		sizeof(args));
 }
 
 void amdgpu_atombios_get_default_voltages(struct amdgpu_device *adev,
@@ -1205,7 +1211,8 @@ int amdgpu_atombios_get_max_vddc(struct amdgpu_device *adev, u8 voltage_type,
 		args.v2.ucVoltageMode = 0;
 		args.v2.usVoltageLevel = 0;
 
-		amdgpu_atom_execute_table(adev->mode_info.atom_context, index, (uint32_t *)&args);
+		amdgpu_atom_execute_table(adev->mode_info.atom_context, index, (uint32_t *)&args,
+			sizeof(args));
 
 		*voltage = le16_to_cpu(args.v2.usVoltageLevel);
 		break;
@@ -1214,7 +1221,8 @@ int amdgpu_atombios_get_max_vddc(struct amdgpu_device *adev, u8 voltage_type,
 		args.v3.ucVoltageMode = ATOM_GET_VOLTAGE_LEVEL;
 		args.v3.usVoltageLevel = cpu_to_le16(voltage_id);
 
-		amdgpu_atom_execute_table(adev->mode_info.atom_context, index, (uint32_t *)&args);
+		amdgpu_atom_execute_table(adev->mode_info.atom_context, index, (uint32_t *)&args,
+			sizeof(args));
 
 		*voltage = le16_to_cpu(args.v3.usVoltageLevel);
 		break;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_atomfirmware.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_atomfirmware.c
index fb2681dd6..6857c586d 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_atomfirmware.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_atomfirmware.c
@@ -941,5 +941,6 @@ int amdgpu_atomfirmware_asic_init(struct amdgpu_device *adev, bool fb_reset)
 		return -EINVAL;
 	}
 
-	return amdgpu_atom_execute_table(ctx, ATOM_CMD_INIT, (uint32_t *)&asic_init_ps_v2_1);
+	return amdgpu_atom_execute_table(ctx, ATOM_CMD_INIT, (uint32_t *)&asic_init_ps_v2_1,
+		sizeof(asic_init_ps_v2_1));
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/atom.c b/drivers/gpu/drm/amd/amdgpu/atom.c
index 2c2210007..86324a180 100644
--- a/drivers/gpu/drm/amd/amdgpu/atom.c
+++ b/drivers/gpu/drm/amd/amdgpu/atom.c
@@ -62,6 +62,7 @@
 typedef struct {
 	struct atom_context *ctx;
 	uint32_t *ps, *ws;
+	int ps_size, ws_size;
 	int ps_shift;
 	uint16_t start;
 	unsigned last_jump;
@@ -70,8 +71,8 @@ typedef struct {
 } atom_exec_context;
 
 int amdgpu_atom_debug;
-static int amdgpu_atom_execute_table_locked(struct atom_context *ctx, int index, uint32_t *params);
-int amdgpu_atom_execute_table(struct atom_context *ctx, int index, uint32_t *params);
+static int amdgpu_atom_execute_table_locked(struct atom_context *ctx, int index, uint32_t *params, int params_size);
+int amdgpu_atom_execute_table(struct atom_context *ctx, int index, uint32_t *params, int params_size);
 
 static uint32_t atom_arg_mask[8] =
 	{ 0xFFFFFFFF, 0xFFFF, 0xFFFF00, 0xFFFF0000, 0xFF, 0xFF00, 0xFF0000,
@@ -223,7 +224,10 @@ static uint32_t atom_get_src_int(atom_exec_context *ctx, uint8_t attr,
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
@@ -261,7 +265,10 @@ static uint32_t atom_get_src_int(atom_exec_context *ctx, uint8_t attr,
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
@@ -496,6 +503,10 @@ static void atom_put_dst(atom_exec_context *ctx, int arg, uint8_t attr,
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
@@ -528,6 +539,10 @@ static void atom_put_dst(atom_exec_context *ctx, int arg, uint8_t attr,
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
@@ -625,7 +640,7 @@ static void atom_op_calltable(atom_exec_context *ctx, int *ptr, int arg)
 	else
 		SDEBUG("   table: %d\n", idx);
 	if (U16(ctx->ctx->cmd_table + 4 + 2 * idx))
-		r = amdgpu_atom_execute_table_locked(ctx->ctx, idx, ctx->ps + ctx->ps_shift);
+		r = amdgpu_atom_execute_table_locked(ctx->ctx, idx, ctx->ps + ctx->ps_shift, ctx->ps_size - ctx->ps_shift);
 	if (r) {
 		ctx->abort = true;
 	}
@@ -1204,7 +1219,7 @@ static struct {
 	atom_op_div32, ATOM_ARG_WS},
 };
 
-static int amdgpu_atom_execute_table_locked(struct atom_context *ctx, int index, uint32_t *params)
+static int amdgpu_atom_execute_table_locked(struct atom_context *ctx, int index, uint32_t *params, int params_size)
 {
 	int base = CU16(ctx->cmd_table + 4 + 2 * index);
 	int len, ws, ps, ptr;
@@ -1226,12 +1241,16 @@ static int amdgpu_atom_execute_table_locked(struct atom_context *ctx, int index,
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
@@ -1265,7 +1284,7 @@ static int amdgpu_atom_execute_table_locked(struct atom_context *ctx, int index,
 	return ret;
 }
 
-int amdgpu_atom_execute_table(struct atom_context *ctx, int index, uint32_t *params)
+int amdgpu_atom_execute_table(struct atom_context *ctx, int index, uint32_t *params, int params_size)
 {
 	int r;
 
@@ -1281,7 +1300,7 @@ int amdgpu_atom_execute_table(struct atom_context *ctx, int index, uint32_t *par
 	/* reset divmul */
 	ctx->divmul[0] = 0;
 	ctx->divmul[1] = 0;
-	r = amdgpu_atom_execute_table_locked(ctx, index, params);
+	r = amdgpu_atom_execute_table_locked(ctx, index, params, params_size);
 	mutex_unlock(&ctx->mutex);
 	return r;
 }
@@ -1553,7 +1572,7 @@ int amdgpu_atom_asic_init(struct atom_context *ctx)
 
 	if (!CU16(ctx->cmd_table + 4 + 2 * ATOM_CMD_INIT))
 		return 1;
-	ret = amdgpu_atom_execute_table(ctx, ATOM_CMD_INIT, ps);
+	ret = amdgpu_atom_execute_table(ctx, ATOM_CMD_INIT, ps, 16);
 	if (ret)
 		return ret;
 
diff --git a/drivers/gpu/drm/amd/amdgpu/atom.h b/drivers/gpu/drm/amd/amdgpu/atom.h
index c11cf18a0..b807f6639 100644
--- a/drivers/gpu/drm/amd/amdgpu/atom.h
+++ b/drivers/gpu/drm/amd/amdgpu/atom.h
@@ -156,7 +156,7 @@ struct atom_context {
 extern int amdgpu_atom_debug;
 
 struct atom_context *amdgpu_atom_parse(struct card_info *card, void *bios);
-int amdgpu_atom_execute_table(struct atom_context *ctx, int index, uint32_t *params);
+int amdgpu_atom_execute_table(struct atom_context *ctx, int index, uint32_t *params, int params_size);
 int amdgpu_atom_asic_init(struct atom_context *ctx);
 void amdgpu_atom_destroy(struct atom_context *ctx);
 bool amdgpu_atom_parse_data_header(struct atom_context *ctx, int index, uint16_t *size,
diff --git a/drivers/gpu/drm/amd/amdgpu/atombios_crtc.c b/drivers/gpu/drm/amd/amdgpu/atombios_crtc.c
index 10098fdd3..3dfc28840 100644
--- a/drivers/gpu/drm/amd/amdgpu/atombios_crtc.c
+++ b/drivers/gpu/drm/amd/amdgpu/atombios_crtc.c
@@ -77,7 +77,7 @@ void amdgpu_atombios_crtc_overscan_setup(struct drm_crtc *crtc,
 		args.usOverscanTop = cpu_to_le16(amdgpu_crtc->v_border);
 		break;
 	}
-	amdgpu_atom_execute_table(adev->mode_info.atom_context, index, (uint32_t *)&args);
+	amdgpu_atom_execute_table(adev->mode_info.atom_context, index, (uint32_t *)&args, sizeof(args));
 }
 
 void amdgpu_atombios_crtc_scaler_setup(struct drm_crtc *crtc)
@@ -106,7 +106,7 @@ void amdgpu_atombios_crtc_scaler_setup(struct drm_crtc *crtc)
 		args.ucEnable = ATOM_SCALER_DISABLE;
 		break;
 	}
-	amdgpu_atom_execute_table(adev->mode_info.atom_context, index, (uint32_t *)&args);
+	amdgpu_atom_execute_table(adev->mode_info.atom_context, index, (uint32_t *)&args, sizeof(args));
 }
 
 void amdgpu_atombios_crtc_lock(struct drm_crtc *crtc, int lock)
@@ -123,7 +123,7 @@ void amdgpu_atombios_crtc_lock(struct drm_crtc *crtc, int lock)
 	args.ucCRTC = amdgpu_crtc->crtc_id;
 	args.ucEnable = lock;
 
-	amdgpu_atom_execute_table(adev->mode_info.atom_context, index, (uint32_t *)&args);
+	amdgpu_atom_execute_table(adev->mode_info.atom_context, index, (uint32_t *)&args, sizeof(args));
 }
 
 void amdgpu_atombios_crtc_enable(struct drm_crtc *crtc, int state)
@@ -139,7 +139,7 @@ void amdgpu_atombios_crtc_enable(struct drm_crtc *crtc, int state)
 	args.ucCRTC = amdgpu_crtc->crtc_id;
 	args.ucEnable = state;
 
-	amdgpu_atom_execute_table(adev->mode_info.atom_context, index, (uint32_t *)&args);
+	amdgpu_atom_execute_table(adev->mode_info.atom_context, index, (uint32_t *)&args, sizeof(args));
 }
 
 void amdgpu_atombios_crtc_blank(struct drm_crtc *crtc, int state)
@@ -155,7 +155,7 @@ void amdgpu_atombios_crtc_blank(struct drm_crtc *crtc, int state)
 	args.ucCRTC = amdgpu_crtc->crtc_id;
 	args.ucBlanking = state;
 
-	amdgpu_atom_execute_table(adev->mode_info.atom_context, index, (uint32_t *)&args);
+	amdgpu_atom_execute_table(adev->mode_info.atom_context, index, (uint32_t *)&args, sizeof(args));
 }
 
 void amdgpu_atombios_crtc_powergate(struct drm_crtc *crtc, int state)
@@ -171,7 +171,7 @@ void amdgpu_atombios_crtc_powergate(struct drm_crtc *crtc, int state)
 	args.ucDispPipeId = amdgpu_crtc->crtc_id;
 	args.ucEnable = state;
 
-	amdgpu_atom_execute_table(adev->mode_info.atom_context, index, (uint32_t *)&args);
+	amdgpu_atom_execute_table(adev->mode_info.atom_context, index, (uint32_t *)&args, sizeof(args));
 }
 
 void amdgpu_atombios_crtc_powergate_init(struct amdgpu_device *adev)
@@ -183,7 +183,7 @@ void amdgpu_atombios_crtc_powergate_init(struct amdgpu_device *adev)
 
 	args.ucEnable = ATOM_INIT;
 
-	amdgpu_atom_execute_table(adev->mode_info.atom_context, index, (uint32_t *)&args);
+	amdgpu_atom_execute_table(adev->mode_info.atom_context, index, (uint32_t *)&args, sizeof(args));
 }
 
 void amdgpu_atombios_crtc_set_dtd_timing(struct drm_crtc *crtc,
@@ -228,7 +228,7 @@ void amdgpu_atombios_crtc_set_dtd_timing(struct drm_crtc *crtc,
 	args.susModeMiscInfo.usAccess = cpu_to_le16(misc);
 	args.ucCRTC = amdgpu_crtc->crtc_id;
 
-	amdgpu_atom_execute_table(adev->mode_info.atom_context, index, (uint32_t *)&args);
+	amdgpu_atom_execute_table(adev->mode_info.atom_context, index, (uint32_t *)&args, sizeof(args));
 }
 
 union atom_enable_ss {
@@ -293,7 +293,7 @@ static void amdgpu_atombios_crtc_program_ss(struct amdgpu_device *adev,
 	args.v3.usSpreadSpectrumStep = cpu_to_le16(ss->step);
 	args.v3.ucEnable = enable;
 
-	amdgpu_atom_execute_table(adev->mode_info.atom_context, index, (uint32_t *)&args);
+	amdgpu_atom_execute_table(adev->mode_info.atom_context, index, (uint32_t *)&args, sizeof(args));
 }
 
 union adjust_pixel_clock {
@@ -395,7 +395,7 @@ static u32 amdgpu_atombios_crtc_adjust_pll(struct drm_crtc *crtc,
 					ADJUST_DISPLAY_CONFIG_SS_ENABLE;
 
 			amdgpu_atom_execute_table(adev->mode_info.atom_context,
-					   index, (uint32_t *)&args);
+					   index, (uint32_t *)&args, sizeof(args));
 			adjusted_clock = le16_to_cpu(args.v1.usPixelClock) * 10;
 			break;
 		case 3:
@@ -428,7 +428,7 @@ static u32 amdgpu_atombios_crtc_adjust_pll(struct drm_crtc *crtc,
 				args.v3.sInput.ucExtTransmitterID = 0;
 
 			amdgpu_atom_execute_table(adev->mode_info.atom_context,
-					   index, (uint32_t *)&args);
+					   index, (uint32_t *)&args, sizeof(args));
 			adjusted_clock = le32_to_cpu(args.v3.sOutput.ulDispPllFreq) * 10;
 			if (args.v3.sOutput.ucRefDiv) {
 				amdgpu_crtc->pll_flags |= AMDGPU_PLL_USE_FRAC_FB_DIV;
@@ -514,7 +514,7 @@ void amdgpu_atombios_crtc_set_disp_eng_pll(struct amdgpu_device *adev,
 		DRM_ERROR("Unknown table version %d %d\n", frev, crev);
 		return;
 	}
-	amdgpu_atom_execute_table(adev->mode_info.atom_context, index, (uint32_t *)&args);
+	amdgpu_atom_execute_table(adev->mode_info.atom_context, index, (uint32_t *)&args, sizeof(args));
 }
 
 union set_dce_clock {
@@ -544,7 +544,7 @@ u32 amdgpu_atombios_crtc_set_dce_clock(struct amdgpu_device *adev,
 			args.v2_1.asParam.ulDCEClkFreq = cpu_to_le32(freq); /* 10kHz units */
 			args.v2_1.asParam.ucDCEClkType = clk_type;
 			args.v2_1.asParam.ucDCEClkSrc = clk_src;
-			amdgpu_atom_execute_table(adev->mode_info.atom_context, index, (uint32_t *)&args);
+			amdgpu_atom_execute_table(adev->mode_info.atom_context, index, (uint32_t *)&args, sizeof(args));
 			ret_freq = le32_to_cpu(args.v2_1.asParam.ulDCEClkFreq) * 10;
 			break;
 		default:
@@ -740,7 +740,7 @@ void amdgpu_atombios_crtc_program_pll(struct drm_crtc *crtc,
 		return;
 	}
 
-	amdgpu_atom_execute_table(adev->mode_info.atom_context, index, (uint32_t *)&args);
+	amdgpu_atom_execute_table(adev->mode_info.atom_context, index, (uint32_t *)&args, sizeof(args));
 }
 
 int amdgpu_atombios_crtc_prepare_pll(struct drm_crtc *crtc,
diff --git a/drivers/gpu/drm/amd/amdgpu/atombios_dp.c b/drivers/gpu/drm/amd/amdgpu/atombios_dp.c
index 87c41e0e9..622634c08 100644
--- a/drivers/gpu/drm/amd/amdgpu/atombios_dp.c
+++ b/drivers/gpu/drm/amd/amdgpu/atombios_dp.c
@@ -83,7 +83,7 @@ static int amdgpu_atombios_dp_process_aux_ch(struct amdgpu_i2c_chan *chan,
 	args.v2.ucDelay = delay / 10;
 	args.v2.ucHPD_ID = chan->rec.hpd;
 
-	amdgpu_atom_execute_table(adev->mode_info.atom_context, index, (uint32_t *)&args);
+	amdgpu_atom_execute_table(adev->mode_info.atom_context, index, (uint32_t *)&args, sizeof(args));
 
 	*ack = args.v2.ucReplyStatus;
 
@@ -301,7 +301,7 @@ static u8 amdgpu_atombios_dp_encoder_service(struct amdgpu_device *adev,
 	args.ucLaneNum = lane_num;
 	args.ucStatus = 0;
 
-	amdgpu_atom_execute_table(adev->mode_info.atom_context, index, (uint32_t *)&args);
+	amdgpu_atom_execute_table(adev->mode_info.atom_context, index, (uint32_t *)&args, sizeof(args));
 	return args.ucStatus;
 }
 
diff --git a/drivers/gpu/drm/amd/amdgpu/atombios_encoders.c b/drivers/gpu/drm/amd/amdgpu/atombios_encoders.c
index 3ee219aa2..352eed114 100644
--- a/drivers/gpu/drm/amd/amdgpu/atombios_encoders.c
+++ b/drivers/gpu/drm/amd/amdgpu/atombios_encoders.c
@@ -334,7 +334,7 @@ amdgpu_atombios_encoder_setup_dac(struct drm_encoder *encoder, int action)
 	args.ucDacStandard = ATOM_DAC1_PS2;
 	args.usPixelClock = cpu_to_le16(amdgpu_encoder->pixel_clock / 10);
 
-	amdgpu_atom_execute_table(adev->mode_info.atom_context, index, (uint32_t *)&args);
+	amdgpu_atom_execute_table(adev->mode_info.atom_context, index, (uint32_t *)&args, sizeof(args));
 
 }
 
@@ -431,7 +431,7 @@ amdgpu_atombios_encoder_setup_dvo(struct drm_encoder *encoder, int action)
 		break;
 	}
 
-	amdgpu_atom_execute_table(adev->mode_info.atom_context, index, (uint32_t *)&args);
+	amdgpu_atom_execute_table(adev->mode_info.atom_context, index, (uint32_t *)&args, sizeof(args));
 }
 
 int amdgpu_atombios_encoder_get_encoder_mode(struct drm_encoder *encoder)
@@ -731,7 +731,7 @@ amdgpu_atombios_encoder_setup_dig_encoder(struct drm_encoder *encoder,
 		break;
 	}
 
-	amdgpu_atom_execute_table(adev->mode_info.atom_context, index, (uint32_t *)&args);
+	amdgpu_atom_execute_table(adev->mode_info.atom_context, index, (uint32_t *)&args, sizeof(args));
 
 }
 
@@ -1135,7 +1135,7 @@ amdgpu_atombios_encoder_setup_dig_transmitter(struct drm_encoder *encoder, int a
 		break;
 	}
 
-	amdgpu_atom_execute_table(adev->mode_info.atom_context, index, (uint32_t *)&args);
+	amdgpu_atom_execute_table(adev->mode_info.atom_context, index, (uint32_t *)&args, sizeof(args));
 }
 
 bool
@@ -1163,7 +1163,7 @@ amdgpu_atombios_encoder_set_edp_panel_power(struct drm_connector *connector,
 
 	args.v1.ucAction = action;
 
-	amdgpu_atom_execute_table(adev->mode_info.atom_context, index, (uint32_t *)&args);
+	amdgpu_atom_execute_table(adev->mode_info.atom_context, index, (uint32_t *)&args, sizeof(args));
 
 	/* wait for the panel to power up */
 	if (action == ATOM_TRANSMITTER_ACTION_POWER_ON) {
@@ -1287,7 +1287,7 @@ amdgpu_atombios_encoder_setup_external_encoder(struct drm_encoder *encoder,
 		DRM_ERROR("Unknown table version: %d, %d\n", frev, crev);
 		return;
 	}
-	amdgpu_atom_execute_table(adev->mode_info.atom_context, index, (uint32_t *)&args);
+	amdgpu_atom_execute_table(adev->mode_info.atom_context, index, (uint32_t *)&args, sizeof(args));
 }
 
 static void
@@ -1632,7 +1632,7 @@ amdgpu_atombios_encoder_set_crtc_source(struct drm_encoder *encoder)
 		return;
 	}
 
-	amdgpu_atom_execute_table(adev->mode_info.atom_context, index, (uint32_t *)&args);
+	amdgpu_atom_execute_table(adev->mode_info.atom_context, index, (uint32_t *)&args, sizeof(args));
 }
 
 /* This only needs to be called once at startup */
@@ -1705,7 +1705,7 @@ amdgpu_atombios_encoder_dac_load_detect(struct drm_encoder *encoder,
 				args.sDacload.ucMisc = DAC_LOAD_MISC_YPrPb;
 		}
 
-		amdgpu_atom_execute_table(adev->mode_info.atom_context, index, (uint32_t *)&args);
+		amdgpu_atom_execute_table(adev->mode_info.atom_context, index, (uint32_t *)&args, sizeof(args));
 
 		return true;
 	} else
diff --git a/drivers/gpu/drm/amd/amdgpu/atombios_i2c.c b/drivers/gpu/drm/amd/amdgpu/atombios_i2c.c
index af0335535..a65011143 100644
--- a/drivers/gpu/drm/amd/amdgpu/atombios_i2c.c
+++ b/drivers/gpu/drm/amd/amdgpu/atombios_i2c.c
@@ -86,7 +86,7 @@ static int amdgpu_atombios_i2c_process_i2c_ch(struct amdgpu_i2c_chan *chan,
 	args.ucSlaveAddr = slave_addr << 1;
 	args.ucLineNumber = chan->rec.i2c_id;
 
-	amdgpu_atom_execute_table(adev->mode_info.atom_context, index, (uint32_t *)&args);
+	amdgpu_atom_execute_table(adev->mode_info.atom_context, index, (uint32_t *)&args, sizeof(args));
 
 	/* error */
 	if (args.ucStatus != HW_ASSISTED_I2C_STATUS_SUCCESS) {
@@ -172,5 +172,5 @@ void amdgpu_atombios_i2c_channel_trans(struct amdgpu_device *adev, u8 slave_addr
 	args.ucSlaveAddr = slave_addr;
 	args.ucLineNumber = line_number;
 
-	amdgpu_atom_execute_table(adev->mode_info.atom_context, index, (uint32_t *)&args);
+	amdgpu_atom_execute_table(adev->mode_info.atom_context, index, (uint32_t *)&args, sizeof(args));
 }
diff --git a/drivers/gpu/drm/amd/display/dc/bios/command_table.c b/drivers/gpu/drm/amd/display/dc/bios/command_table.c
index 818a529ca..86f9198e7 100644
--- a/drivers/gpu/drm/amd/display/dc/bios/command_table.c
+++ b/drivers/gpu/drm/amd/display/dc/bios/command_table.c
@@ -37,7 +37,7 @@
 #define EXEC_BIOS_CMD_TABLE(command, params)\
 	(amdgpu_atom_execute_table(((struct amdgpu_device *)bp->base.ctx->driver_context)->mode_info.atom_context, \
 		GetIndexIntoMasterTable(COMMAND, command), \
-		(uint32_t *)&params) == 0)
+		(uint32_t *)&params, sizeof(params)) == 0)
 
 #define BIOS_CMD_TABLE_REVISION(command, frev, crev)\
 	amdgpu_atom_parse_cmd_header(((struct amdgpu_device *)bp->base.ctx->driver_context)->mode_info.atom_context, \
diff --git a/drivers/gpu/drm/amd/display/dc/bios/command_table2.c b/drivers/gpu/drm/amd/display/dc/bios/command_table2.c
index 90a02d7bd..2bf407b9b 100644
--- a/drivers/gpu/drm/amd/display/dc/bios/command_table2.c
+++ b/drivers/gpu/drm/amd/display/dc/bios/command_table2.c
@@ -49,7 +49,7 @@
 #define EXEC_BIOS_CMD_TABLE(fname, params)\
 	(amdgpu_atom_execute_table(((struct amdgpu_device *)bp->base.ctx->driver_context)->mode_info.atom_context, \
 		GET_INDEX_INTO_MASTER_TABLE(command, fname), \
-		(uint32_t *)&params) == 0)
+		(uint32_t *)&params, sizeof(params)) == 0)
 
 #define BIOS_CMD_TABLE_REVISION(fname, frev, crev)\
 	amdgpu_atom_parse_cmd_header(((struct amdgpu_device *)bp->base.ctx->driver_context)->mode_info.atom_context, \
diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/ppatomctrl.c b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/ppatomctrl.c
index f503e61fa..8f5895473 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/ppatomctrl.c
+++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/ppatomctrl.c
@@ -226,7 +226,7 @@ int atomctrl_set_engine_dram_timings_rv770(
 
 	return amdgpu_atom_execute_table(adev->mode_info.atom_context,
 			GetIndexIntoMasterTable(COMMAND, DynamicMemorySettings),
-			(uint32_t *)&engine_clock_parameters);
+			(uint32_t *)&engine_clock_parameters, sizeof(engine_clock_parameters));
 }
 
 /*
@@ -297,7 +297,7 @@ int atomctrl_get_memory_pll_dividers_si(
 
 	result = amdgpu_atom_execute_table(adev->mode_info.atom_context,
 		 GetIndexIntoMasterTable(COMMAND, ComputeMemoryClockParam),
-		(uint32_t *)&mpll_parameters);
+		(uint32_t *)&mpll_parameters, sizeof(mpll_parameters));
 
 	if (0 == result) {
 		mpll_param->mpll_fb_divider.clk_frac =
@@ -345,7 +345,7 @@ int atomctrl_get_memory_pll_dividers_vi(struct pp_hwmgr *hwmgr,
 
 	result = amdgpu_atom_execute_table(adev->mode_info.atom_context,
 			GetIndexIntoMasterTable(COMMAND, ComputeMemoryClockParam),
-			(uint32_t *)&mpll_parameters);
+			(uint32_t *)&mpll_parameters, sizeof(mpll_parameters));
 
 	if (!result)
 		mpll_param->mpll_post_divider =
@@ -366,7 +366,7 @@ int atomctrl_get_memory_pll_dividers_ai(struct pp_hwmgr *hwmgr,
 
 	result = amdgpu_atom_execute_table(adev->mode_info.atom_context,
 			GetIndexIntoMasterTable(COMMAND, ComputeMemoryClockParam),
-			(uint32_t *)&mpll_parameters);
+			(uint32_t *)&mpll_parameters, sizeof(mpll_parameters));
 
 	/* VEGAM's mpll takes sometime to finish computing */
 	udelay(10);
@@ -396,7 +396,7 @@ int atomctrl_get_engine_pll_dividers_kong(struct pp_hwmgr *hwmgr,
 
 	result = amdgpu_atom_execute_table(adev->mode_info.atom_context,
 		 GetIndexIntoMasterTable(COMMAND, ComputeMemoryEnginePLL),
-		(uint32_t *)&pll_parameters);
+		(uint32_t *)&pll_parameters, sizeof(pll_parameters));
 
 	if (0 == result) {
 		dividers->pll_post_divider = pll_parameters.ucPostDiv;
@@ -420,7 +420,7 @@ int atomctrl_get_engine_pll_dividers_vi(
 
 	result = amdgpu_atom_execute_table(adev->mode_info.atom_context,
 		 GetIndexIntoMasterTable(COMMAND, ComputeMemoryEnginePLL),
-		(uint32_t *)&pll_patameters);
+		(uint32_t *)&pll_patameters, sizeof(pll_patameters));
 
 	if (0 == result) {
 		dividers->pll_post_divider =
@@ -457,7 +457,7 @@ int atomctrl_get_engine_pll_dividers_ai(struct pp_hwmgr *hwmgr,
 
 	result = amdgpu_atom_execute_table(adev->mode_info.atom_context,
 		 GetIndexIntoMasterTable(COMMAND, ComputeMemoryEnginePLL),
-		(uint32_t *)&pll_patameters);
+		(uint32_t *)&pll_patameters, sizeof(pll_patameters));
 
 	if (0 == result) {
 		dividers->usSclk_fcw_frac     = le16_to_cpu(pll_patameters.usSclk_fcw_frac);
@@ -490,7 +490,7 @@ int atomctrl_get_dfs_pll_dividers_vi(
 
 	result = amdgpu_atom_execute_table(adev->mode_info.atom_context,
 		 GetIndexIntoMasterTable(COMMAND, ComputeMemoryEnginePLL),
-		(uint32_t *)&pll_patameters);
+		(uint32_t *)&pll_patameters, sizeof(pll_patameters));
 
 	if (0 == result) {
 		dividers->pll_post_divider =
@@ -773,7 +773,7 @@ int atomctrl_calculate_voltage_evv_on_sclk(
 
 	result = amdgpu_atom_execute_table(adev->mode_info.atom_context,
 			GetIndexIntoMasterTable(COMMAND, ReadEfuseValue),
-			(uint32_t *)&sOutput_FuseValues);
+			(uint32_t *)&sOutput_FuseValues, sizeof(sOutput_FuseValues));
 
 	if (result)
 		return result;
@@ -794,7 +794,7 @@ int atomctrl_calculate_voltage_evv_on_sclk(
 
 	result = amdgpu_atom_execute_table(adev->mode_info.atom_context,
 			GetIndexIntoMasterTable(COMMAND, ReadEfuseValue),
-			(uint32_t *)&sOutput_FuseValues);
+			(uint32_t *)&sOutput_FuseValues, sizeof(sOutput_FuseValues));
 
 	if (result)
 		return result;
@@ -814,7 +814,7 @@ int atomctrl_calculate_voltage_evv_on_sclk(
 
 	result = amdgpu_atom_execute_table(adev->mode_info.atom_context,
 			GetIndexIntoMasterTable(COMMAND, ReadEfuseValue),
-			(uint32_t *)&sOutput_FuseValues);
+			(uint32_t *)&sOutput_FuseValues, sizeof(sOutput_FuseValues));
 
 	if (result)
 		return result;
@@ -835,7 +835,7 @@ int atomctrl_calculate_voltage_evv_on_sclk(
 
 	result = amdgpu_atom_execute_table(adev->mode_info.atom_context,
 			GetIndexIntoMasterTable(COMMAND, ReadEfuseValue),
-			(uint32_t *)&sOutput_FuseValues);
+			(uint32_t *)&sOutput_FuseValues, sizeof(sOutput_FuseValues));
 
 	if (result)
 		return result;
@@ -857,7 +857,7 @@ int atomctrl_calculate_voltage_evv_on_sclk(
 
 	result = amdgpu_atom_execute_table(adev->mode_info.atom_context,
 			GetIndexIntoMasterTable(COMMAND, ReadEfuseValue),
-			(uint32_t *)&sOutput_FuseValues);
+			(uint32_t *)&sOutput_FuseValues, sizeof(sOutput_FuseValues));
 	if (result)
 		return result;
 
@@ -878,7 +878,7 @@ int atomctrl_calculate_voltage_evv_on_sclk(
 
 	result = amdgpu_atom_execute_table(adev->mode_info.atom_context,
 			GetIndexIntoMasterTable(COMMAND, ReadEfuseValue),
-			(uint32_t *)&sOutput_FuseValues);
+			(uint32_t *)&sOutput_FuseValues, sizeof(sOutput_FuseValues));
 
 	if (result)
 		return result;
@@ -909,7 +909,7 @@ int atomctrl_calculate_voltage_evv_on_sclk(
 
 	result = amdgpu_atom_execute_table(adev->mode_info.atom_context,
 			GetIndexIntoMasterTable(COMMAND, ReadEfuseValue),
-			(uint32_t *)&sOutput_FuseValues);
+			(uint32_t *)&sOutput_FuseValues, sizeof(sOutput_FuseValues));
 
 	if (result)
 		return result;
@@ -1134,7 +1134,7 @@ int atomctrl_get_voltage_evv_on_sclk(
 
 	result = amdgpu_atom_execute_table(adev->mode_info.atom_context,
 			GetIndexIntoMasterTable(COMMAND, GetVoltageInfo),
-			(uint32_t *)&get_voltage_info_param_space);
+			(uint32_t *)&get_voltage_info_param_space, sizeof(get_voltage_info_param_space));
 
 	*voltage = result ? 0 :
 			le16_to_cpu(((GET_EVV_VOLTAGE_INFO_OUTPUT_PARAMETER_V1_2 *)
@@ -1179,7 +1179,7 @@ int atomctrl_get_voltage_evv(struct pp_hwmgr *hwmgr,
 
 	result = amdgpu_atom_execute_table(adev->mode_info.atom_context,
 			GetIndexIntoMasterTable(COMMAND, GetVoltageInfo),
-			(uint32_t *)&get_voltage_info_param_space);
+			(uint32_t *)&get_voltage_info_param_space, sizeof(get_voltage_info_param_space));
 
 	if (0 != result)
 		return result;
@@ -1359,7 +1359,7 @@ int atomctrl_read_efuse(struct pp_hwmgr *hwmgr, uint16_t start_index,
 
 	result = amdgpu_atom_execute_table(adev->mode_info.atom_context,
 			GetIndexIntoMasterTable(COMMAND, ReadEfuseValue),
-			(uint32_t *)&efuse_param);
+			(uint32_t *)&efuse_param, sizeof(efuse_param));
 	*efuse = result ? 0 : le32_to_cpu(efuse_param.ulEfuseValue) & mask;
 
 	return result;
@@ -1380,7 +1380,7 @@ int atomctrl_set_ac_timing_ai(struct pp_hwmgr *hwmgr, uint32_t memory_clock,
 
 	result = amdgpu_atom_execute_table(adev->mode_info.atom_context,
 		 GetIndexIntoMasterTable(COMMAND, DynamicMemorySettings),
-		(uint32_t *)&memory_clock_parameters);
+		(uint32_t *)&memory_clock_parameters, sizeof(memory_clock_parameters));
 
 	return result;
 }
@@ -1399,7 +1399,7 @@ int atomctrl_get_voltage_evv_on_sclk_ai(struct pp_hwmgr *hwmgr, uint8_t voltage_
 
 	result = amdgpu_atom_execute_table(adev->mode_info.atom_context,
 			GetIndexIntoMasterTable(COMMAND, GetVoltageInfo),
-			(uint32_t *)&get_voltage_info_param_space);
+			(uint32_t *)&get_voltage_info_param_space, sizeof(get_voltage_info_param_space));
 
 	*voltage = result ? 0 :
 		le32_to_cpu(((GET_EVV_VOLTAGE_INFO_OUTPUT_PARAMETER_V1_3 *)(&get_voltage_info_param_space))->ulVoltageLevel);
@@ -1526,7 +1526,7 @@ int atomctrl_get_leakage_id_from_efuse(struct pp_hwmgr *hwmgr, uint16_t *virtual
 
 	result = amdgpu_atom_execute_table(adev->mode_info.atom_context,
 			GetIndexIntoMasterTable(COMMAND, SetVoltage),
-			(uint32_t *)voltage_parameters);
+			(uint32_t *)voltage_parameters, sizeof(voltage_parameters));
 
 	*virtual_voltage_id = voltage_parameters->usVoltageLevel;
 
diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/ppatomfwctrl.c b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/ppatomfwctrl.c
index a47a47238..82d540334 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/ppatomfwctrl.c
+++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/ppatomfwctrl.c
@@ -258,7 +258,7 @@ int pp_atomfwctrl_get_gpu_pll_dividers_vega10(struct pp_hwmgr *hwmgr,
 	idx = GetIndexIntoMasterCmdTable(computegpuclockparam);
 
 	if (amdgpu_atom_execute_table(
-		adev->mode_info.atom_context, idx, (uint32_t *)&pll_parameters))
+		adev->mode_info.atom_context, idx, (uint32_t *)&pll_parameters, sizeof(pll_parameters)))
 		return -EINVAL;
 
 	pll_output = (struct compute_gpu_clock_output_parameter_v1_8 *)
@@ -505,7 +505,7 @@ int pp_atomfwctrl_get_clk_information_by_clkid(struct pp_hwmgr *hwmgr,
 	ix = GetIndexIntoMasterCmdTable(getsmuclockinfo);
 
 	if (amdgpu_atom_execute_table(
-		adev->mode_info.atom_context, ix, (uint32_t *)&parameters))
+		adev->mode_info.atom_context, ix, (uint32_t *)&parameters, sizeof(parameters)))
 		return -EINVAL;
 
 	output = (struct atom_get_smu_clock_info_output_parameters_v3_1 *)&parameters;
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
index 5a314d031..2e7f8d5cf 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
@@ -514,7 +514,7 @@ static int smu_v11_0_atom_get_smu_clockinfo(struct amdgpu_device *adev,
 					    getsmuclockinfo);
 
 	ret = amdgpu_atom_execute_table(adev->mode_info.atom_context, index,
-					(uint32_t *)&input);
+					(uint32_t *)&input, sizeof(input));
 	if (ret)
 		return -EINVAL;
 
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu12/smu_v12_0.c b/drivers/gpu/drm/amd/pm/swsmu/smu12/smu_v12_0.c
index 5e408a195..ed15f5a0f 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu12/smu_v12_0.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu12/smu_v12_0.c
@@ -301,7 +301,7 @@ static int smu_v12_0_atom_get_smu_clockinfo(struct amdgpu_device *adev,
 					    getsmuclockinfo);
 
 	ret = amdgpu_atom_execute_table(adev->mode_info.atom_context, index,
-					(uint32_t *)&input);
+					(uint32_t *)&input, sizeof(input));
 	if (ret)
 		return -EINVAL;
 
-- 
2.43.0

