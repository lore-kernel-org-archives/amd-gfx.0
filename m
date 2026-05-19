Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92658CD5BA4
	for <amd-gfx@archiver.kernel.org>; Tue, 19 May 2026 10:21:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0D43D10EC03;
	Tue, 19 May 2026 10:21:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="ldK6yBab";
	dkim-atps=neutral
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com
 [209.85.221.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1B63710EBFB
 for <amd-gfx@lists.freedesktop.org>; Tue, 19 May 2026 10:21:30 +0000 (UTC)
Received: by mail-wr1-f51.google.com with SMTP id
 ffacd0b85a97d-44a5174670eso1872053f8f.1
 for <amd-gfx@lists.freedesktop.org>; Tue, 19 May 2026 03:21:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1779186089; x=1779790889; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XBtkZ2gf/Jj5M+m4sGia3yHihFthLzwruBg7fP1JRdQ=;
 b=ldK6yBabjLWyyyPShC6qVxjkkr+pzdDUKZclXdzwR9m0pUg7WctCbDEASmidsfI2/9
 WQj7SxjHLochbrrpquheWKrtObjessRKJjSRZm5Q5PQXpOZUYgPXg2xs3Re2lyzQV4ZJ
 FqeN0gt07xI7aSnoIr3dx/Amv0R5o0xpOZlNZF9fbGvX/6BmuBng6bT9H6gtb2zZIbDX
 awDJaso3lNKciKybNTsNZvMLDFTWnNkomFP5PBordrRK1HvAjIVai8s5iVFo6oqYODpN
 9dpEv9XKhVbNGZ/SVtYHGKooUI9IBnzAEKndaEmMfcMHnsagFEaw+hHxsuK3EWOmVQ8+
 4DNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779186089; x=1779790889;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=XBtkZ2gf/Jj5M+m4sGia3yHihFthLzwruBg7fP1JRdQ=;
 b=esdHiTUJzaKFx8/dgHy9CAUuJySdv1S6q5ygBD1+6ERT3ZsIDZtsd3L/wJTTpxNezz
 tXBqOXrhsCMZi+ZQ/8p2rIE1dllICjifx8s4KS3gVeQnpuToRQJgKRN01gcPMUVU9Brl
 CW3ccbR6p7ntr8hYXZ7hfDwUuYT7+x4Wqp0WAAl5VoEtv3/Iozfv/L2ohuE7SCShb78h
 u96YCAzGwVzZTuJiOxwd7KDKqXOWV9XdcsiFPZU8f1+4/V+vA3ZGUfW6rOlBNdgbeh2u
 rriLjmE0LSqgdHt/hcM6E4s3wN054qfG0TmxSKvmydDN3qSJD+XA36ElkeJQYD/PSRWi
 h18g==
X-Gm-Message-State: AOJu0Yxr0gdlT0aihHUfoSnEesNrma/Ggm1lTBaq/c4oaUsdztOsyOFm
 8MddtApUz9P0cOHezHMQVbY2SDLw9OubFEVECkBNAlJNZ2Zd7mz8rW98Bnl4xnfo
X-Gm-Gg: Acq92OGRR7g6MdkRg2MWN/imqysUuMIvloTbGasL8PBStHC6vqdV2oPQ57AuffD+jGW
 tGpKVpOcGAPjkDt0vg4rQI6AyBJCjCDSMKaea6GQXFvAio+S7uO6f4aPbp7qXT5ovdCHXSnOYMG
 I2aMGCoVu9UhBZ+OfrmyN6JpF5vPP/ZuRTet+cGT4G8J5n9RDzOUn/a2GWU8jCTA0rbeu3MoMSR
 KrAsInxbhs3OiC8+Ah8rRMxlD7arPvRJMGR3NskKk4esInWNrCYp4H5SJCwDUTXpPOnPZCcq1fA
 kiB3e2dis9URmbmLmzLxc+GGA4WiIIRIBvtgBb1xZ+bFop47oq8VzGCjdf3ZD7kEwfTZdbHpXTi
 wDCv1dD1QzdBUJ14B2x/SqHvtcXR6EuuKinVMOE2teGSR11tFCVBjQWdzw5bXcLA41caVqwHwbP
 kgDKbsMqY71VIhbj3E65zg7HSwobxhPkUrrtZX8Dlc6RjTwnXAX51ZiFcDQ/MrZ6MTyfDVD7j9x
 w8=
X-Received: by 2002:a05:6000:2405:b0:43d:e31:68d1 with SMTP id
 ffacd0b85a97d-45e5c5cf18bmr30129076f8f.21.1779186088597; 
 Tue, 19 May 2026 03:21:28 -0700 (PDT)
Received: from Timur-Hyperion.home (54001290.dsl.pool.telekom.hu.
 [84.0.18.144]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-45da0fe0fecsm41028224f8f.26.2026.05.19.03.21.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 May 2026 03:21:28 -0700 (PDT)
From: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
To: amd-gfx@lists.freedesktop.org, Alex Deucher <alexander.deucher@amd.com>,
 christian.koenig@amd.com, Natalie Vock <natalie.vock@gmx.de>,
 Melissa Wen <mwen@igalia.com>, Harry Wentland <Harry.Wentland@amd.com>,
 Alex Hung <alex.hung@amd.com>, Roman Li <Roman.Li@amd.com>,
 Leo Li <sunpeng.li@amd.com>, Mario Limonciello <mario.limonciello@amd.com>
Cc: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
Subject: [PATCH 07/14] drm/amd/display: Delete disp_clk_voltage from
 integrated info (v2)
Date: Tue, 19 May 2026 12:21:11 +0200
Message-ID: <20260519102118.246466-8-timur.kristof@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260519102118.246466-1-timur.kristof@gmail.com>
References: <20260519102118.246466-1-timur.kristof@gmail.com>
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

v2:
- Also delete some code wrapped in #if 0

Signed-off-by: Timur Kristóf <timur.kristof@gmail.com>
Reviewed-by: Melissa Wen <mwen@igalia.com>
---
 .../gpu/drm/amd/display/dc/bios/bios_parser.c | 36 -------------------
 .../drm/amd/display/dc/bios/bios_parser2.c    | 18 ----------
 .../display/include/grph_object_ctrl_defs.h   |  9 -----
 3 files changed, 63 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/bios/bios_parser.c b/drivers/gpu/drm/amd/display/dc/bios/bios_parser.c
index 05f299ec5463..2c7cca697f5f 100644
--- a/drivers/gpu/drm/amd/display/dc/bios/bios_parser.c
+++ b/drivers/gpu/drm/amd/display/dc/bios/bios_parser.c
@@ -2419,15 +2419,6 @@ static enum bp_result get_integrated_info_v8(
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
@@ -2570,14 +2561,6 @@ static enum bp_result get_integrated_info_v9(
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
@@ -2719,25 +2702,6 @@ static enum bp_result construct_integrated_info(
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
index 39668db6d472..d19ae67ebfac 100644
--- a/drivers/gpu/drm/amd/display/dc/bios/bios_parser2.c
+++ b/drivers/gpu/drm/amd/display/dc/bios/bios_parser2.c
@@ -2671,15 +2671,6 @@ static enum bp_result get_integrated_info_v11(
 	info->dentist_vco_freq = le32_to_cpu(info_v11->ulDentistVCOFreq) * 10;
 	info->boot_up_uma_clock = le32_to_cpu(info_v8->ulBootUpUMAClock) * 10;
 
-	for (i = 0; i < NUMBER_OF_DISP_CLK_VOLTAGE; ++i) {
-		/* Convert [10KHz] into [KHz] */
-		info->disp_clk_voltage[i].max_supported_clk =
-		le32_to_cpu(info_v11->sDISPCLK_Voltage[i].
-			ulMaximumSupportedCLK) * 10;
-		info->disp_clk_voltage[i].voltage_index =
-		le32_to_cpu(info_v11->sDISPCLK_Voltage[i].ulVoltageIndex);
-	}
-
 	info->boot_up_req_display_vector =
 			le32_to_cpu(info_v11->ulBootUpReqDisplayVector);
 	info->boot_up_nb_voltage =
@@ -3032,7 +3023,6 @@ static enum bp_result construct_integrated_info(
 	struct atom_data_revision revision;
 
 	int32_t i;
-	int32_t j;
 
 	if (!info)
 		return result;
@@ -3134,14 +3124,6 @@ static enum bp_result construct_integrated_info(
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
index a0f03fb67605..3e4e8d55dd0f 100644
--- a/drivers/gpu/drm/amd/display/include/grph_object_ctrl_defs.h
+++ b/drivers/gpu/drm/amd/display/include/grph_object_ctrl_defs.h
@@ -273,7 +273,6 @@ struct transmitter_configuration {
 #define NUMBER_OF_UCHAR_FOR_GUID 16
 #define MAX_NUMBER_OF_EXT_DISPLAY_PATH 7
 #define NUMBER_OF_CSR_M3_ARB 10
-#define NUMBER_OF_DISP_CLK_VOLTAGE 4
 #define NUMBER_OF_AVAILABLE_SCLK 5
 
 struct i2c_reg_info {
@@ -302,14 +301,6 @@ struct edp_info {
 
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
2.54.0

