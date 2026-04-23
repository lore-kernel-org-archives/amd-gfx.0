Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D153FDEE47
	for <amd-gfx@archiver.kernel.org>; Thu, 23 Apr 2026 19:15:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2270010F26D;
	Thu, 23 Apr 2026 19:15:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="HyhBoI7f";
	dkim-atps=neutral
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com
 [209.85.221.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5BC2A10F260
 for <amd-gfx@lists.freedesktop.org>; Thu, 23 Apr 2026 19:15:31 +0000 (UTC)
Received: by mail-wr1-f49.google.com with SMTP id
 ffacd0b85a97d-43d7650202fso5413724f8f.2
 for <amd-gfx@lists.freedesktop.org>; Thu, 23 Apr 2026 12:15:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1776971730; x=1777576530; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=U0BPhsDUG64+pc5mO3NKkg/YcXbY8ZREuTr26FTYkjE=;
 b=HyhBoI7fT68NoxUeMqcKBURx4TInOpsMx7b9Kz5OAb0QzunyMrwjl48gPuWJr8hVKR
 tl/gAepA7zwT8QEBynxmI0ScxkldNII2zmNiYtdCOArVYfGll21Bt2lRsggJ0QT2Aul4
 0rYU/n54ywgPM2MChE3Unef7nyCYA4JKoK0l19R7qXHYrh/RJYUGu9CDQ6EOYpBXxvrq
 UkaatgusrOfpAraKIYMtRD7UMqapeSMvUswpqpWzI8Dp718WQCMBHvfd4zNPO1TiRtUQ
 iU3YxezooREg445Rlw9xiug5EP5ZH6FDvxC6wvZrdhhkrVpf3tFawqTS4wYq9/kUMXUx
 4WoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776971730; x=1777576530;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=U0BPhsDUG64+pc5mO3NKkg/YcXbY8ZREuTr26FTYkjE=;
 b=rezu2Wj6mqMfe7bXYdmcvGDpQnTyMLquOH2Xm4yfRAaFOX8TPpnqLmt7fNB+vfQkwa
 6N4YYWWONZrMjYKToxLbPNJDd4vhnVLji58Cwewu5wRqtTPy34gL2gh0We1eQK+zYx1t
 xf8HUPbr2Y2c/L3Y/+1GN/6XuDC0xpHg7VrcfvPNuA1iZ3GuCkmHV8WFOVjuEJd9gEoG
 1k6VHYUp7p/EGhNk5F69BJp5AYyZyyKt4P5tBKWY7ebrc+QH37O6tXJ6g+BPwPJ10F/P
 +XZetWg9tLkMjhQC1GPSOgiMz+ZQ6KF1RvsgrUb09CkymAIYU/zeTPV7sveQ2jP8otvm
 t1uA==
X-Gm-Message-State: AOJu0Yxu90y+//Xbbr6Mk+lIop1t7IHd0SRDTH9rf4N75u051nb+FUZF
 gyYPK1SGxIyFOB7XmK+EVi6yW3+qXs174FwDJNx/6CbSiMW92ucBhomzTtHGPeLC
X-Gm-Gg: AeBDiesOojT9hgUoorZHWU6yHHcg00srL1ifFoEfTvFAlT1upMunbhbO7TKk+44a5Lc
 eTSl7BOn+l2Ehvp9gE3byfTzyT/Nv4u7MIxmfDEfeapXuj862HoT6UDGeyNr1lQqgMfbu95wUKy
 Fee0YoOZarISmDrXFQLAoaeA4vN7d3bmtpI9HPNXnpV2ZvljQCMv+DpOejeQdhkVBMz73nrQnqR
 KdtD5SaU/G3Ruj+kdi4CJgr4l2/hujNzCUDeiwwJVP+0IpcbcdWDJiNz02vQXnYNPEL71KWw4DS
 DJCCFe/KBsEdLtwg/mFCSsD3LzsVQCfUQHlaF96qKgoC2wkmeQ39WRILRpt35x0zHWg6whC177d
 IfOkRgaET8bMCPChWM23MihmXese7abWxLMU9pG5gbfEbwBHaqGg++Lb3M0CZWc8l3GM769/mhO
 Nmbndfw1MpN+/MTtunQLr1t4qcooB+6YB2XcJvZIOXi0zfYccxsycHzz9O9eWfgt5lu5b0ekyL+
 +1bwMdB/AxIXw70
X-Received: by 2002:a05:6000:2282:b0:439:c69f:503a with SMTP id
 ffacd0b85a97d-43fe3e0c652mr41882178f8f.27.1776971729766; 
 Thu, 23 Apr 2026 12:15:29 -0700 (PDT)
Received: from Timur-Hyperion.home (5E1B98A2.dsl.pool.telekom.hu.
 [94.27.152.162]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-44123d23e0bsm15792782f8f.15.2026.04.23.12.15.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 Apr 2026 12:15:29 -0700 (PDT)
From: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
To: amd-gfx@lists.freedesktop.org, alexander.deucher@amd.com,
 Alex Hung <alex.hung@amd.com>, Harry Wentland <Harry.Wentland@amd.com>,
 Roman Li <Roman.Li@amd.com>, Leo Li <sunpeng.li@amd.com>,
 David Airlie <airlied@gmail.com>,
 Mario Limonciello <mario.limonciello@amd.com>,
 Ivan Lipski <ivan.lipski@amd.com>, Melissa Wen <mwen@igalia.com>
Cc: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
Subject: [PATCH 07/14] drm/amd/display: Delete disp_clk_voltage from
 integrated info
Date: Thu, 23 Apr 2026 21:15:12 +0200
Message-ID: <20260423191519.73127-8-timur.kristof@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260423191519.73127-1-timur.kristof@gmail.com>
References: <20260423191519.73127-1-timur.kristof@gmail.com>
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

Only DCE 11.0 relies on this information and even that
didn't use this field, because it queries the information
from the pplib. It also filled the field incorrectly on
that version.

On newer GPUs, the VIOS integrated info no longer contains
display clock voltage dependencies, so we don't need it.

Signed-off-by: Timur Kristóf <timur.kristof@gmail.com>
---
 .../gpu/drm/amd/display/dc/bios/bios_parser.c | 36 -------------------
 .../drm/amd/display/dc/bios/bios_parser2.c    |  9 -----
 .../display/include/grph_object_ctrl_defs.h   |  9 -----
 3 files changed, 54 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/bios/bios_parser.c b/drivers/gpu/drm/amd/display/dc/bios/bios_parser.c
index 25c94962e1415..298a70852c1a8 100644
--- a/drivers/gpu/drm/amd/display/dc/bios/bios_parser.c
+++ b/drivers/gpu/drm/amd/display/dc/bios/bios_parser.c
@@ -2348,15 +2348,6 @@ static enum bp_result get_integrated_info_v8(
 	info->dentist_vco_freq = le32_to_cpu(info_v8->ulDentistVCOFreq) * 10;
 	info->boot_up_uma_clock = le32_to_cpu(info_v8->ulBootUpUMAClock) * 10;
 
-	for (i = 0; i < NUMBER_OF_DISP_CLK_VOLTAGE; ++i) {
-		/* Convert [10KHz] into [KHz] */
-		info->disp_clk_voltage[i].max_supported_clk =
-			le32_to_cpu(info_v8->sDISPCLK_Voltage[i].
-				    ulMaximumSupportedCLK) * 10;
-		info->disp_clk_voltage[i].voltage_index =
-			le32_to_cpu(info_v8->sDISPCLK_Voltage[i].ulVoltageIndex);
-	}
-
 	info->boot_up_req_display_vector =
 		le32_to_cpu(info_v8->ulBootUpReqDisplayVector);
 	info->gpu_cap_info =
@@ -2499,14 +2490,6 @@ static enum bp_result get_integrated_info_v9(
 	info->dentist_vco_freq = le32_to_cpu(info_v9->ulDentistVCOFreq) * 10;
 	info->boot_up_uma_clock = le32_to_cpu(info_v9->ulBootUpUMAClock) * 10;
 
-	for (i = 0; i < NUMBER_OF_DISP_CLK_VOLTAGE; ++i) {
-		/* Convert [10KHz] into [KHz] */
-		info->disp_clk_voltage[i].max_supported_clk =
-			le32_to_cpu(info_v9->sDISPCLK_Voltage[i].ulMaximumSupportedCLK) * 10;
-		info->disp_clk_voltage[i].voltage_index =
-			le32_to_cpu(info_v9->sDISPCLK_Voltage[i].ulVoltageIndex);
-	}
-
 	info->boot_up_req_display_vector =
 		le32_to_cpu(info_v9->ulBootUpReqDisplayVector);
 	info->gpu_cap_info = le32_to_cpu(info_v9->ulGPUCapInfo);
@@ -2648,25 +2631,6 @@ static enum bp_result construct_integrated_info(
 		}
 	}
 
-	/* Sort voltage table from low to high*/
-	if (result == BP_RESULT_OK) {
-		int32_t i;
-		int32_t j;
-
-		for (i = 1; i < NUMBER_OF_DISP_CLK_VOLTAGE; ++i) {
-			for (j = i; j > 0; --j) {
-				if (
-						info->disp_clk_voltage[j].max_supported_clk <
-						info->disp_clk_voltage[j-1].max_supported_clk) {
-					/* swap j and j - 1*/
-					swap(info->disp_clk_voltage[j - 1],
-					     info->disp_clk_voltage[j]);
-				}
-			}
-		}
-
-	}
-
 	return result;
 }
 
diff --git a/drivers/gpu/drm/amd/display/dc/bios/bios_parser2.c b/drivers/gpu/drm/amd/display/dc/bios/bios_parser2.c
index b4dd8219b8f09..0e7250f1d3f73 100644
--- a/drivers/gpu/drm/amd/display/dc/bios/bios_parser2.c
+++ b/drivers/gpu/drm/amd/display/dc/bios/bios_parser2.c
@@ -3023,7 +3023,6 @@ static enum bp_result construct_integrated_info(
 	struct atom_data_revision revision;
 
 	int32_t i;
-	int32_t j;
 
 	if (!info)
 		return result;
@@ -3125,14 +3124,6 @@ static enum bp_result construct_integrated_info(
 			DC_LOG_BIOS("driver forced fixdpvoltageswing = %d\n", info->ext_disp_conn_info.fixdpvoltageswing);
 		}
 	}
-	/* Sort voltage table from low to high*/
-	for (i = 1; i < NUMBER_OF_DISP_CLK_VOLTAGE; ++i) {
-		for (j = i; j > 0; --j) {
-			if (info->disp_clk_voltage[j].max_supported_clk <
-			    info->disp_clk_voltage[j-1].max_supported_clk)
-				swap(info->disp_clk_voltage[j-1], info->disp_clk_voltage[j]);
-		}
-	}
 
 	return result;
 }
diff --git a/drivers/gpu/drm/amd/display/include/grph_object_ctrl_defs.h b/drivers/gpu/drm/amd/display/include/grph_object_ctrl_defs.h
index 38a77fa9b4afd..130d377f4f1d2 100644
--- a/drivers/gpu/drm/amd/display/include/grph_object_ctrl_defs.h
+++ b/drivers/gpu/drm/amd/display/include/grph_object_ctrl_defs.h
@@ -269,7 +269,6 @@ struct transmitter_configuration {
 #define NUMBER_OF_UCHAR_FOR_GUID 16
 #define MAX_NUMBER_OF_EXT_DISPLAY_PATH 7
 #define NUMBER_OF_CSR_M3_ARB 10
-#define NUMBER_OF_DISP_CLK_VOLTAGE 4
 #define NUMBER_OF_AVAILABLE_SCLK 5
 
 struct i2c_reg_info {
@@ -298,14 +297,6 @@ struct edp_info {
 
 /* V6 */
 struct integrated_info {
-	struct clock_voltage_caps {
-		/* The Voltage Index indicated by FUSE, same voltage index
-		shared with SCLK DPM fuse table */
-		uint32_t voltage_index;
-		/* Maximum clock supported with specified voltage index */
-		uint32_t max_supported_clk; /* in KHz */
-	} disp_clk_voltage[NUMBER_OF_DISP_CLK_VOLTAGE];
-
 	struct display_connection_info {
 		struct external_display_path {
 			/* A bit vector to show what devices are supported */
-- 
2.53.0

