Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90A8EC36018
	for <amd-gfx@archiver.kernel.org>; Thu, 27 Mar 2025 20:39:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5AEF710E94D;
	Thu, 27 Mar 2025 20:39:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="K5iUzXuD";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D6E5510E169
 for <amd-gfx@lists.freedesktop.org>; Thu, 27 Mar 2025 20:39:17 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id 94DE561142;
 Thu, 27 Mar 2025 20:39:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43E6BC4CEDD;
 Thu, 27 Mar 2025 20:39:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1743107951;
 bh=GR5xSIRungOcJhaBNUO8tML8fTVYEk1037QBZPsVLQw=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=K5iUzXuD3WMCHdMENJSatwjqVFRwxnzV+b9CmAKLEnl6jlS3tajWL/uKfIOjrftgj
 WT/q1yoSiLBBYXI+xRjJRYeCm44tXoRzu3PGCM3//r5VRAOeDvFSzFJ9iSwEnFnw8l
 VgCYoeQ6FCid06s/BsUx/1BUyHhLEabfNC2CvFQH+H5S58YbxcEWh3LIHWh3tDdEYn
 /MxkiyaORrzK4MqIxzo+KOCbSLgD+KeEGSqECKYT+GK84vIoc2J05u7UeZGgQSE0Uh
 YfFjiTEJkcCEGPhK+y2cefMskVW7y+jwbuMQ7rpoDQB8KxyHz1Dd5HhaNJaTulQOE2
 L3t2fthgfm3lw==
From: Mario Limonciello <superm1@kernel.org>
To: amd-gfx@lists.freedesktop.org
Cc: Mario Limonciello <mario.limonciello@amd.com>
Subject: [PATCH 05/14] drm/amd: Adjust atombios parser messages from DRM_*()
 to drm_*()
Date: Thu, 27 Mar 2025 15:38:49 -0500
Message-ID: <20250327203858.3796086-6-superm1@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250327203858.3796086-1-superm1@kernel.org>
References: <20250327203858.3796086-1-superm1@kernel.org>
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

From: Mario Limonciello <mario.limonciello@amd.com>

Messages emitted from atombios parser are currently with legacy DRM
macros. These don't show which device they are using. To make messages
clearer in multi-GPU systems adjust to drm_*() macros.

Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/atom.c             | 62 +++++++++++--------
 drivers/gpu/drm/amd/amdgpu/atombios_crtc.c    | 16 ++---
 drivers/gpu/drm/amd/amdgpu/atombios_dp.c      | 18 +++---
 .../gpu/drm/amd/amdgpu/atombios_encoders.c    | 30 ++++-----
 drivers/gpu/drm/amd/amdgpu/atombios_i2c.c     |  5 +-
 5 files changed, 71 insertions(+), 60 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/atom.c b/drivers/gpu/drm/amd/amdgpu/atom.c
index 81d195d366ceb..643f457e6753b 100644
--- a/drivers/gpu/drm/amd/amdgpu/atom.c
+++ b/drivers/gpu/drm/amd/amdgpu/atom.c
@@ -174,7 +174,7 @@ static uint32_t atom_iio_execute(struct atom_context *ctx, int base,
 		case ATOM_IIO_END:
 			return temp;
 		default:
-			pr_info("Unknown IIO opcode\n");
+			drm_warn(ctx->card->dev, "Unknown IIO opcode\n");
 			return 0;
 		}
 }
@@ -198,18 +198,18 @@ static uint32_t atom_get_src_int(atom_exec_context *ctx, uint8_t attr,
 			val = gctx->card->reg_read(gctx->card, idx);
 			break;
 		case ATOM_IO_PCI:
-			pr_info("PCI registers are not implemented\n");
+			drm_err(ctx->ctx->card->dev, "PCI registers are not implemented\n");
 			return 0;
 		case ATOM_IO_SYSIO:
-			pr_info("SYSIO registers are not implemented\n");
+			drm_err(ctx->ctx->card->dev, "SYSIO registers are not implemented\n");
 			return 0;
 		default:
 			if (!(gctx->io_mode & 0x80)) {
-				pr_info("Bad IO mode\n");
+				drm_err(ctx->ctx->card->dev, "Bad IO mode\n");
 				return 0;
 			}
 			if (!gctx->iio[gctx->io_mode & 0x7F]) {
-				pr_info("Undefined indirect IO read method %d\n",
+				drm_err(ctx->ctx->card->dev, "Undefined indirect IO read method %d\n",
 					gctx->io_mode & 0x7F);
 				return 0;
 			}
@@ -227,7 +227,8 @@ static uint32_t atom_get_src_int(atom_exec_context *ctx, uint8_t attr,
 		if (idx < ctx->ps_size)
 			val = get_unaligned_le32((u32 *)&ctx->ps[idx]);
 		else
-			pr_info("PS index out of range: %i > %i\n", idx, ctx->ps_size);
+			drm_err(ctx->ctx->card->dev,
+				"PS index out of range: %i > %i\n", idx, ctx->ps_size);
 		if (print)
 			DEBUG("PS[0x%02X,0x%04X]", idx, val);
 		break;
@@ -268,7 +269,9 @@ static uint32_t atom_get_src_int(atom_exec_context *ctx, uint8_t attr,
 			if (idx < ctx->ws_size)
 				val = ctx->ws[idx];
 			else
-				pr_info("WS index out of range: %i > %i\n", idx, ctx->ws_size);
+				drm_err(ctx->ctx->card->dev,
+					"WS index out of range: %i > %i\n",
+					idx, ctx->ws_size);
 		}
 		break;
 	case ATOM_ARG_ID:
@@ -286,7 +289,7 @@ static uint32_t atom_get_src_int(atom_exec_context *ctx, uint8_t attr,
 		idx = U8(*ptr);
 		(*ptr)++;
 		if ((gctx->fb_base + (idx * 4)) > gctx->scratch_size_bytes) {
-			DRM_ERROR("ATOM: fb read beyond scratch region: %d vs. %d\n",
+			drm_err(ctx->ctx->card->dev, "ATOM: fb read beyond scratch region: %d vs. %d\n",
 				  gctx->fb_base + (idx * 4), gctx->scratch_size_bytes);
 			val = 0;
 		} else
@@ -479,18 +482,21 @@ static void atom_put_dst(atom_exec_context *ctx, int arg, uint8_t attr,
 				gctx->card->reg_write(gctx->card, idx, val);
 			break;
 		case ATOM_IO_PCI:
-			pr_info("PCI registers are not implemented\n");
+			drm_err(ctx->ctx->card->dev,
+				"PCI registers are not implemented\n");
 			return;
 		case ATOM_IO_SYSIO:
-			pr_info("SYSIO registers are not implemented\n");
+			drm_err(ctx->ctx->card->dev,
+				"SYSIO registers are not implemented\n");
 			return;
 		default:
 			if (!(gctx->io_mode & 0x80)) {
-				pr_info("Bad IO mode\n");
+				drm_err(ctx->ctx->card->dev, "Bad IO mode\n");
 				return;
 			}
 			if (!gctx->iio[gctx->io_mode & 0xFF]) {
-				pr_info("Undefined indirect IO write method %d\n",
+				drm_err(ctx->ctx->card->dev,
+					"Undefined indirect IO write method %d\n",
 					gctx->io_mode & 0x7F);
 				return;
 			}
@@ -503,7 +509,9 @@ static void atom_put_dst(atom_exec_context *ctx, int arg, uint8_t attr,
 		(*ptr)++;
 		DEBUG("PS[0x%02X]", idx);
 		if (idx >= ctx->ps_size) {
-			pr_info("PS index out of range: %i > %i\n", idx, ctx->ps_size);
+			drm_err(ctx->ctx->card->dev,
+				"PS index out of range: %i > %i\n",
+				idx, ctx->ps_size);
 			return;
 		}
 		ctx->ps[idx] = cpu_to_le32(val);
@@ -539,7 +547,9 @@ static void atom_put_dst(atom_exec_context *ctx, int arg, uint8_t attr,
 			break;
 		default:
 			if (idx >= ctx->ws_size) {
-				pr_info("WS index out of range: %i > %i\n", idx, ctx->ws_size);
+				drm_err(ctx->ctx->card->dev,
+					"WS index out of range: %i > %i\n",
+					idx, ctx->ws_size);
 				return;
 			}
 			ctx->ws[idx] = val;
@@ -549,7 +559,7 @@ static void atom_put_dst(atom_exec_context *ctx, int arg, uint8_t attr,
 		idx = U8(*ptr);
 		(*ptr)++;
 		if ((gctx->fb_base + (idx * 4)) > gctx->scratch_size_bytes) {
-			DRM_ERROR("ATOM: fb write beyond scratch region: %d vs. %d\n",
+			drm_err(ctx->ctx->card->dev, "ATOM: fb write beyond scratch region: %d vs. %d\n",
 				  gctx->fb_base + (idx * 4), gctx->scratch_size_bytes);
 		} else
 			gctx->scratch[(gctx->fb_base / 4) + idx] = val;
@@ -626,7 +636,7 @@ static void atom_op_and(atom_exec_context *ctx, int *ptr, int arg)
 
 static void atom_op_beep(atom_exec_context *ctx, int *ptr, int arg)
 {
-	printk("ATOM BIOS beeped!\n");
+	drm_info(ctx->ctx->card->dev, "ATOM BIOS beeped!\n");
 }
 
 static void atom_op_calltable(atom_exec_context *ctx, int *ptr, int arg)
@@ -764,7 +774,7 @@ static void atom_op_jump(atom_exec_context *ctx, int *ptr, int arg)
 			if (time_after(cjiffies, ctx->last_jump_jiffies)) {
 				cjiffies -= ctx->last_jump_jiffies;
 				if ((jiffies_to_msecs(cjiffies) > ATOM_CMD_TIMEOUT_SEC*1000)) {
-					DRM_ERROR("atombios stuck in loop for more than %dsecs aborting\n",
+					drm_err(ctx->ctx->card->dev, "atombios stuck in loop for more than %dsecs aborting\n",
 						  ATOM_CMD_TIMEOUT_SEC);
 					ctx->abort = true;
 				}
@@ -866,17 +876,17 @@ static void atom_op_postcard(atom_exec_context *ctx, int *ptr, int arg)
 
 static void atom_op_repeat(atom_exec_context *ctx, int *ptr, int arg)
 {
-	pr_info("unimplemented!\n");
+	drm_warn(ctx->ctx->card->dev, "unimplemented!\n");
 }
 
 static void atom_op_restorereg(atom_exec_context *ctx, int *ptr, int arg)
 {
-	pr_info("unimplemented!\n");
+	drm_warn(ctx->ctx->card->dev, "unimplemented!\n");
 }
 
 static void atom_op_savereg(atom_exec_context *ctx, int *ptr, int arg)
 {
-	pr_info("unimplemented!\n");
+	drm_warn(ctx->ctx->card->dev, "unimplemented!\n");
 }
 
 static void atom_op_setdatablock(atom_exec_context *ctx, int *ptr, int arg)
@@ -1039,7 +1049,7 @@ static void atom_op_switch(atom_exec_context *ctx, int *ptr, int arg)
 			}
 			(*ptr) += 2;
 		} else {
-			pr_info("Bad case\n");
+			drm_err(ctx->ctx->card->dev, "Bad case\n");
 			return;
 		}
 	(*ptr) += 2;
@@ -1260,7 +1270,7 @@ static int amdgpu_atom_execute_table_locked(struct atom_context *ctx, int index,
 		else
 			SDEBUG("[%d] @ 0x%04X\n", op, ptr - 1);
 		if (ectx.abort) {
-			DRM_ERROR("atombios stuck executing %04X (len %d, WS %d, PS %d) @ 0x%04X\n",
+			drm_err(ctx->card->dev, "atombios stuck executing %04X (len %d, WS %d, PS %d) @ 0x%04X\n",
 				base, len, ws, ps, ptr - 1);
 			ret = -EINVAL;
 			goto free;
@@ -1458,7 +1468,7 @@ static void atom_get_vbios_pn(struct atom_context *ctx)
 		ctx->vbios_pn[count] = 0;
 	}
 
-	pr_info("ATOM BIOS: %s\n", ctx->vbios_pn);
+	drm_info(ctx->card->dev, "ATOM BIOS: %s\n", ctx->vbios_pn);
 }
 
 static void atom_get_vbios_version(struct atom_context *ctx)
@@ -1509,14 +1519,14 @@ struct atom_context *amdgpu_atom_parse(struct card_info *card, void *bios)
 	ctx->bios = bios;
 
 	if (CU16(0) != ATOM_BIOS_MAGIC) {
-		pr_info("Invalid BIOS magic\n");
+		drm_err(card->dev, "Invalid BIOS magic\n");
 		kfree(ctx);
 		return NULL;
 	}
 	if (strncmp
 	    (CSTR(ATOM_ATI_MAGIC_PTR), ATOM_ATI_MAGIC,
 	     strlen(ATOM_ATI_MAGIC))) {
-		pr_info("Invalid ATI magic\n");
+		drm_err(card->dev, "Invalid ATI magic\n");
 		kfree(ctx);
 		return NULL;
 	}
@@ -1525,7 +1535,7 @@ struct atom_context *amdgpu_atom_parse(struct card_info *card, void *bios)
 	if (strncmp
 	    (CSTR(base + ATOM_ROM_MAGIC_PTR), ATOM_ROM_MAGIC,
 	     strlen(ATOM_ROM_MAGIC))) {
-		pr_info("Invalid ATOM magic\n");
+		drm_err(card->dev, "Invalid ATOM magic\n");
 		kfree(ctx);
 		return NULL;
 	}
diff --git a/drivers/gpu/drm/amd/amdgpu/atombios_crtc.c b/drivers/gpu/drm/amd/amdgpu/atombios_crtc.c
index 3dfc28840a7d3..658f702dc3322 100644
--- a/drivers/gpu/drm/amd/amdgpu/atombios_crtc.c
+++ b/drivers/gpu/drm/amd/amdgpu/atombios_crtc.c
@@ -442,12 +442,12 @@ static u32 amdgpu_atombios_crtc_adjust_pll(struct drm_crtc *crtc,
 			}
 			break;
 		default:
-			DRM_ERROR("Unknown table version %d %d\n", frev, crev);
+			drm_err(adev_to_drm(adev), "Unknown table version %d %d\n", frev, crev);
 			return adjusted_clock;
 		}
 		break;
 	default:
-		DRM_ERROR("Unknown table version %d %d\n", frev, crev);
+		drm_err(adev_to_drm(adev), "Unknown table version %d %d\n", frev, crev);
 		return adjusted_clock;
 	}
 
@@ -506,12 +506,12 @@ void amdgpu_atombios_crtc_set_disp_eng_pll(struct amdgpu_device *adev,
 				args.v6.ucPpll = ATOM_EXT_PLL1;
 			break;
 		default:
-			DRM_ERROR("Unknown table version %d %d\n", frev, crev);
+			drm_err(adev_to_drm(adev), "Unknown table version %d %d\n", frev, crev);
 			return;
 		}
 		break;
 	default:
-		DRM_ERROR("Unknown table version %d %d\n", frev, crev);
+		drm_err(adev_to_drm(adev), "Unknown table version %d %d\n", frev, crev);
 		return;
 	}
 	amdgpu_atom_execute_table(adev->mode_info.atom_context, index, (uint32_t *)&args, sizeof(args));
@@ -548,12 +548,12 @@ u32 amdgpu_atombios_crtc_set_dce_clock(struct amdgpu_device *adev,
 			ret_freq = le32_to_cpu(args.v2_1.asParam.ulDCEClkFreq) * 10;
 			break;
 		default:
-			DRM_ERROR("Unknown table version %d %d\n", frev, crev);
+			drm_err(adev_to_drm(adev), "Unknown table version %d %d\n", frev, crev);
 			return 0;
 		}
 		break;
 	default:
-		DRM_ERROR("Unknown table version %d %d\n", frev, crev);
+		drm_err(adev_to_drm(adev), "Unknown table version %d %d\n", frev, crev);
 		return 0;
 	}
 
@@ -731,12 +731,12 @@ void amdgpu_atombios_crtc_program_pll(struct drm_crtc *crtc,
 			args.v7.ucPpll = pll_id;
 			break;
 		default:
-			DRM_ERROR("Unknown table version %d %d\n", frev, crev);
+			drm_err(adev_to_drm(adev), "Unknown table version %d %d\n", frev, crev);
 			return;
 		}
 		break;
 	default:
-		DRM_ERROR("Unknown table version %d %d\n", frev, crev);
+		drm_err(adev_to_drm(adev), "Unknown table version %d %d\n", frev, crev);
 		return;
 	}
 
diff --git a/drivers/gpu/drm/amd/amdgpu/atombios_dp.c b/drivers/gpu/drm/amd/amdgpu/atombios_dp.c
index 622634c08c7b5..37f23b6222432 100644
--- a/drivers/gpu/drm/amd/amdgpu/atombios_dp.c
+++ b/drivers/gpu/drm/amd/amdgpu/atombios_dp.c
@@ -617,7 +617,7 @@ amdgpu_atombios_dp_link_train_cr(struct amdgpu_atombios_dp_link_train_info *dp_i
 
 		if (drm_dp_dpcd_read_link_status(dp_info->aux,
 						 dp_info->link_status) <= 0) {
-			DRM_ERROR("displayport link status failed\n");
+			drm_err(adev_to_drm(dp_info->adev), "displayport link status failed\n");
 			break;
 		}
 
@@ -631,14 +631,14 @@ amdgpu_atombios_dp_link_train_cr(struct amdgpu_atombios_dp_link_train_info *dp_i
 				break;
 		}
 		if (i == dp_info->dp_lane_count) {
-			DRM_ERROR("clock recovery reached max voltage\n");
+			drm_err(adev_to_drm(dp_info->adev), "clock recovery reached max voltage\n");
 			break;
 		}
 
 		if ((dp_info->train_set[0] & DP_TRAIN_VOLTAGE_SWING_MASK) == voltage) {
 			++dp_info->tries;
 			if (dp_info->tries == 5) {
-				DRM_ERROR("clock recovery tried 5 times\n");
+				drm_err(adev_to_drm(dp_info->adev), "clock recovery tried 5 times\n");
 				break;
 			}
 		} else
@@ -653,10 +653,10 @@ amdgpu_atombios_dp_link_train_cr(struct amdgpu_atombios_dp_link_train_info *dp_i
 		amdgpu_atombios_dp_update_vs_emph(dp_info);
 	}
 	if (!clock_recovery) {
-		DRM_ERROR("clock recovery failed\n");
+		drm_err(adev_to_drm(dp_info->adev), "clock recovery failed\n");
 		return -1;
 	} else {
-		DRM_DEBUG_KMS("clock recovery at voltage %d pre-emphasis %d\n",
+		drm_dbg(dp_info->adev, "clock recovery at voltage %d pre-emphasis %d\n",
 			  dp_info->train_set[0] & DP_TRAIN_VOLTAGE_SWING_MASK,
 			  (dp_info->train_set[0] & DP_TRAIN_PRE_EMPHASIS_MASK) >>
 			  DP_TRAIN_PRE_EMPHASIS_SHIFT);
@@ -682,7 +682,7 @@ amdgpu_atombios_dp_link_train_ce(struct amdgpu_atombios_dp_link_train_info *dp_i
 
 		if (drm_dp_dpcd_read_link_status(dp_info->aux,
 						 dp_info->link_status) <= 0) {
-			DRM_ERROR("displayport link status failed\n");
+			drm_err(adev_to_drm(dp_info->adev), "displayport link status failed\n");
 			break;
 		}
 
@@ -693,7 +693,7 @@ amdgpu_atombios_dp_link_train_ce(struct amdgpu_atombios_dp_link_train_info *dp_i
 
 		/* Try 5 times */
 		if (dp_info->tries > 5) {
-			DRM_ERROR("channel eq failed: 5 tries\n");
+			drm_err(adev_to_drm(dp_info->adev), "channel eq failed: 5 tries\n");
 			break;
 		}
 
@@ -706,10 +706,10 @@ amdgpu_atombios_dp_link_train_ce(struct amdgpu_atombios_dp_link_train_info *dp_i
 	}
 
 	if (!channel_eq) {
-		DRM_ERROR("channel eq failed\n");
+		drm_err(adev_to_drm(dp_info->adev), "channel eq failed\n");
 		return -1;
 	} else {
-		DRM_DEBUG_KMS("channel eq at voltage %d pre-emphasis %d\n",
+		drm_dbg(dp_info->adev, "channel eq at voltage %d pre-emphasis %d\n",
 			  dp_info->train_set[0] & DP_TRAIN_VOLTAGE_SWING_MASK,
 			  (dp_info->train_set[0] & DP_TRAIN_PRE_EMPHASIS_MASK)
 			  >> DP_TRAIN_PRE_EMPHASIS_SHIFT);
diff --git a/drivers/gpu/drm/amd/amdgpu/atombios_encoders.c b/drivers/gpu/drm/amd/amdgpu/atombios_encoders.c
index a51f3414b65dd..d6e33e9d79693 100644
--- a/drivers/gpu/drm/amd/amdgpu/atombios_encoders.c
+++ b/drivers/gpu/drm/amd/amdgpu/atombios_encoders.c
@@ -193,7 +193,7 @@ void amdgpu_atombios_encoder_init_backlight(struct amdgpu_encoder *amdgpu_encode
 
 	pdata = kmalloc(sizeof(struct amdgpu_backlight_privdata), GFP_KERNEL);
 	if (!pdata) {
-		DRM_ERROR("Memory allocation failed\n");
+		drm_err(dev, "Memory allocation failed\n");
 		goto error;
 	}
 
@@ -205,7 +205,7 @@ void amdgpu_atombios_encoder_init_backlight(struct amdgpu_encoder *amdgpu_encode
 	bd = backlight_device_register(bl_name, drm_connector->kdev,
 				       pdata, &amdgpu_atombios_encoder_backlight_ops, &props);
 	if (IS_ERR(bd)) {
-		DRM_ERROR("Backlight registration failed\n");
+		drm_err(dev, "Backlight registration failed\n");
 		goto error;
 	}
 
@@ -218,7 +218,7 @@ void amdgpu_atombios_encoder_init_backlight(struct amdgpu_encoder *amdgpu_encode
 	bd->props.power = BACKLIGHT_POWER_ON;
 	backlight_update_status(bd);
 
-	DRM_INFO("amdgpu atom DIG backlight initialized\n");
+	drm_info(dev, "amdgpu atom DIG backlight initialized\n");
 
 	return;
 
@@ -256,7 +256,7 @@ amdgpu_atombios_encoder_fini_backlight(struct amdgpu_encoder *amdgpu_encoder)
 		backlight_device_unregister(bd);
 		kfree(pdata);
 
-		DRM_INFO("amdgpu atom LVDS backlight unloaded\n");
+		drm_info(adev_to_drm(adev), "amdgpu atom LVDS backlight unloaded\n");
 	}
 }
 
@@ -423,12 +423,12 @@ amdgpu_atombios_encoder_setup_dvo(struct drm_encoder *encoder, int action)
 			args.dvo_v4.ucBitPerColor = amdgpu_atombios_encoder_get_bpc(encoder);
 			break;
 		default:
-			DRM_ERROR("Unknown table version %d, %d\n", frev, crev);
+			drm_err(adev_to_drm(adev), "Unknown table version %d, %d\n", frev, crev);
 			break;
 		}
 		break;
 	default:
-		DRM_ERROR("Unknown table version %d, %d\n", frev, crev);
+		drm_err(adev_to_drm(adev), "Unknown table version %d, %d\n", frev, crev);
 		break;
 	}
 
@@ -718,17 +718,17 @@ amdgpu_atombios_encoder_setup_dig_encoder(struct drm_encoder *encoder,
 				args.v5.asCmdParam.ucDigId = dig->dig_encoder;
 				break;
 			default:
-				DRM_ERROR("Unsupported action 0x%x\n", action);
+				drm_err(adev_to_drm(adev), "Unsupported action 0x%x\n", action);
 				break;
 			}
 			break;
 		default:
-			DRM_ERROR("Unknown table version %d, %d\n", frev, crev);
+			drm_err(adev_to_drm(adev), "Unknown table version %d, %d\n", frev, crev);
 			break;
 		}
 		break;
 	default:
-		DRM_ERROR("Unknown table version %d, %d\n", frev, crev);
+		drm_err(adev_to_drm(adev), "Unknown table version %d, %d\n", frev, crev);
 		break;
 	}
 
@@ -1127,12 +1127,12 @@ amdgpu_atombios_encoder_setup_dig_transmitter(struct drm_encoder *encoder, int a
 			args.v6.ucDigEncoderSel = 1 << dig_encoder;
 			break;
 		default:
-			DRM_ERROR("Unknown table version %d, %d\n", frev, crev);
+			drm_err(adev_to_drm(adev), "Unknown table version %d, %d\n", frev, crev);
 			break;
 		}
 		break;
 	default:
-		DRM_ERROR("Unknown table version %d, %d\n", frev, crev);
+		drm_err(adev_to_drm(adev), "Unknown table version %d, %d\n", frev, crev);
 		break;
 	}
 
@@ -1280,12 +1280,12 @@ amdgpu_atombios_encoder_setup_external_encoder(struct drm_encoder *encoder,
 			args.v3.sExtEncoder.ucBitPerColor = amdgpu_atombios_encoder_get_bpc(encoder);
 			break;
 		default:
-			DRM_ERROR("Unknown table version: %d, %d\n", frev, crev);
+			drm_err(adev_to_drm(adev), "Unknown table version: %d, %d\n", frev, crev);
 			return;
 		}
 		break;
 	default:
-		DRM_ERROR("Unknown table version: %d, %d\n", frev, crev);
+		drm_err(adev_to_drm(adev), "Unknown table version: %d, %d\n", frev, crev);
 		return;
 	}
 	amdgpu_atom_execute_table(adev->mode_info.atom_context, index, (uint32_t *)&args, sizeof(args));
@@ -1629,7 +1629,7 @@ amdgpu_atombios_encoder_set_crtc_source(struct drm_encoder *encoder)
 		}
 		break;
 	default:
-		DRM_ERROR("Unknown table version: %d, %d\n", frev, crev);
+		drm_err(adev_to_drm(adev), "Unknown table version: %d, %d\n", frev, crev);
 		return;
 	}
 
@@ -2091,7 +2091,7 @@ amdgpu_atombios_encoder_get_lcd_info(struct amdgpu_encoder *encoder)
 					record += sizeof(ATOM_PANEL_RESOLUTION_PATCH_RECORD);
 					break;
 				default:
-					DRM_ERROR("Bad LCD record %d\n", *record);
+					drm_err(adev_to_drm(adev), "Bad LCD record %d\n", *record);
 					bad_record = true;
 					break;
 				}
diff --git a/drivers/gpu/drm/amd/amdgpu/atombios_i2c.c b/drivers/gpu/drm/amd/amdgpu/atombios_i2c.c
index a6501114322fd..af438ddd7a698 100644
--- a/drivers/gpu/drm/amd/amdgpu/atombios_i2c.c
+++ b/drivers/gpu/drm/amd/amdgpu/atombios_i2c.c
@@ -55,7 +55,8 @@ static int amdgpu_atombios_i2c_process_i2c_ch(struct amdgpu_i2c_chan *chan,
 
 	if (flags & HW_I2C_WRITE) {
 		if (num > ATOM_MAX_HW_I2C_WRITE) {
-			DRM_ERROR("hw i2c: tried to write too many bytes (%d vs 3)\n", num);
+			drm_err(adev_to_drm(adev),
+				"hw i2c: tried to write too many bytes (%d vs 3)\n", num);
 			r = -EINVAL;
 			goto done;
 		}
@@ -69,7 +70,7 @@ static int amdgpu_atombios_i2c_process_i2c_ch(struct amdgpu_i2c_chan *chan,
 			if (buf) {
 				memcpy(&out, &buf[1], num);
 			} else {
-				DRM_ERROR("hw i2c: missing buf with num > 1\n");
+				drm_err(adev_to_drm(adev), "hw i2c: missing buf with num > 1\n");
 				r = -EINVAL;
 				goto done;
 			}
-- 
2.43.0

