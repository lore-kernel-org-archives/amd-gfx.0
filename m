Return-Path: <SRS0=B05q=DC=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29386C4727F
	for <amd-gfx@archiver.kernel.org>; Fri, 25 Sep 2020 20:11:37 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C071F2399A
	for <amd-gfx@archiver.kernel.org>; Fri, 25 Sep 2020 20:11:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Civm4Z38"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C071F2399A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 50C4B6ED76;
	Fri, 25 Sep 2020 20:11:36 +0000 (UTC)
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com
 [IPv6:2607:f8b0:4864:20::742])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6CA126ED72
 for <amd-gfx@lists.freedesktop.org>; Fri, 25 Sep 2020 20:11:35 +0000 (UTC)
Received: by mail-qk1-x742.google.com with SMTP id o5so4064641qke.12
 for <amd-gfx@lists.freedesktop.org>; Fri, 25 Sep 2020 13:11:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=c4py/szkh03WpCpcxEVNBCfyDeH6L9yQY4grE9AHRsU=;
 b=Civm4Z382RAMbnaeiwp4wTvhZGs1HSvNj+lpu2OMrhX3PW7iDzcciZ7YUetDeMJupS
 3VfU8bSHtfiVylcVwZR4x5aG4uP9X54ML1GEl+5lC4wlPnvWRskGsxT5FCUkhurp02NY
 vvYk7YcCwSakZTSGzJ6VVbtOmtOmmGkGIZ12WgBKTUw/jRKUegTMaTpoV3HJfTIuuq6H
 7LTdZUDQtdUTBt54LA7COyKcn47BNItfEM4zD/FyHndTdRKTak/hrrxRb2yxcu6LvBfR
 10JidmjLVCqgHgdy0wgY7/OsPh8NTPtzk5e4Mtt/x4HfKoAUE69lG5kA8KF3FDMWJ7Vt
 doXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=c4py/szkh03WpCpcxEVNBCfyDeH6L9yQY4grE9AHRsU=;
 b=PCdEZI+/i9xfnBdIOgbK95+31+yCSU0YyqNLT0K/T1qhDeZkzQJhvXSZIro+iRtyY+
 GUB2fvn+bZm8nHNhnqLeVtg2ANHMtHA3bRpP6Jhms7XSQktaDc/gkj3bjhrzPiBn4wfb
 b1lcxwbDa5brhFFO+eOQvfxMIlEQlnxLRWwHzpKIY3mYj8aBUsJJ9vqVVdlnLf/bbEG2
 9KbMIE1sKWPta1yE351y6YRkCCnMjspOzO8wJUwhecjxbtvRVb00yGRVIXgAquvx6r9k
 A26tovMw9bnjHncM/dPTDvKbHq/oyKUkTNxFcKuTQyIaalxtXJ2LUSh9z/ZCRvV16PVT
 jYnA==
X-Gm-Message-State: AOAM5334PY08lTTO2ElmiKWqi63vHHG5JKcnXk7hBY7Fc0E1/r4CWL+a
 0UtsU68++wVbyjChSusmeR519UK4GeI=
X-Google-Smtp-Source: ABdhPJy3iL/yRfz0HbAD8fDiM0rQeJJZnMVhaSbmCihvpwVJ6lUcceam2AhbUK2mqrjtfKP4NGt97w==
X-Received: by 2002:a37:af02:: with SMTP id y2mr1739849qke.346.1601064692164; 
 Fri, 25 Sep 2020 13:11:32 -0700 (PDT)
Received: from tr4.amd.com (atlvpn.amd.com. [165.204.84.11])
 by smtp.gmail.com with ESMTPSA id m67sm2301237qkf.98.2020.09.25.13.11.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 25 Sep 2020 13:11:31 -0700 (PDT)
From: Alex Deucher <alexdeucher@gmail.com>
X-Google-Original-From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 27/45] drm/admgpu/powerplay: add smu v11.5 driver interface
 header for vangogh
Date: Fri, 25 Sep 2020 16:10:11 -0400
Message-Id: <20200925201029.1738724-27-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20200925201029.1738724-1-alexander.deucher@amd.com>
References: <20200925201029.1738724-1-alexander.deucher@amd.com>
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Kevin Wang <kevin1.wang@amd.com>,
 Huang Rui <ray.huang@amd.com>, Xiaojian Du <xiaojian.du@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Xiaojian Du <xiaojian.du@amd.com>

This patch is to add smu v11.5 driver interface header for vangogh.

Signed-off-by: Xiaojian Du <xiaojian.du@amd.com>
Reviewed-by: Kevin Wang <kevin1.wang@amd.com>
Reviewed-by: Huang Rui <ray.huang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 .../drm/amd/pm/inc/smu11_driver_if_vangogh.h  | 239 ++++++++++++++++++
 1 file changed, 239 insertions(+)
 create mode 100644 drivers/gpu/drm/amd/pm/inc/smu11_driver_if_vangogh.h

diff --git a/drivers/gpu/drm/amd/pm/inc/smu11_driver_if_vangogh.h b/drivers/gpu/drm/amd/pm/inc/smu11_driver_if_vangogh.h
new file mode 100644
index 000000000000..20f8c6f460b8
--- /dev/null
+++ b/drivers/gpu/drm/amd/pm/inc/smu11_driver_if_vangogh.h
@@ -0,0 +1,239 @@
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
+ */
+#ifndef __SMU11_DRIVER_IF_VANGOGH_H__
+#define __SMU11_DRIVER_IF_VANGOGH_H__
+
+// *** IMPORTANT ***
+// SMU TEAM: Always increment the interface version if
+// any structure is changed in this file
+#define SMU13_DRIVER_IF_VERSION 2
+
+typedef struct {
+  int32_t value;
+  uint32_t numFractionalBits;
+} FloatInIntFormat_t;
+
+typedef enum {
+  DSPCLK_DCFCLK = 0,
+  DSPCLK_DISPCLK,
+  DSPCLK_PIXCLK,
+  DSPCLK_PHYCLK,
+  DSPCLK_COUNT,
+} DSPCLK_e;
+
+typedef struct {
+  uint16_t Freq; // in MHz
+  uint16_t Vid;  // min voltage in SVI2 VID
+} DisplayClockTable_t;
+
+typedef struct {
+  uint16_t MinClock; // This is either DCFCLK or SOCCLK (in MHz)
+  uint16_t MaxClock; // This is either DCFCLK or SOCCLK (in MHz)
+  uint16_t MinMclk;
+  uint16_t MaxMclk;
+
+  uint8_t  WmSetting;
+  uint8_t  WmType;  // Used for normal pstate change or memory retraining
+  uint8_t  Padding[2];
+} WatermarkRowGeneric_t;
+
+#define NUM_WM_RANGES 4
+#define WM_PSTATE_CHG 0
+#define WM_RETRAINING 1
+
+typedef enum {
+  WM_SOCCLK = 0,
+  WM_DCFCLK,
+  WM_COUNT,
+} WM_CLOCK_e;
+
+typedef struct {
+  // Watermarks
+  WatermarkRowGeneric_t WatermarkRow[WM_COUNT][NUM_WM_RANGES];
+
+  uint32_t     MmHubPadding[7]; // SMU internal use
+} Watermarks_t;
+
+typedef enum {
+  CUSTOM_DPM_SETTING_GFXCLK,
+  CUSTOM_DPM_SETTING_CCLK,
+  CUSTOM_DPM_SETTING_FCLK_CCX,
+  CUSTOM_DPM_SETTING_FCLK_GFX,
+  CUSTOM_DPM_SETTING_FCLK_STALLS,
+  CUSTOM_DPM_SETTING_LCLK,
+  CUSTOM_DPM_SETTING_COUNT,
+} CUSTOM_DPM_SETTING_e;
+
+typedef struct {
+  uint8_t             ActiveHystLimit;
+  uint8_t             IdleHystLimit;
+  uint8_t             FPS;
+  uint8_t             MinActiveFreqType;
+  FloatInIntFormat_t  MinActiveFreq;
+  FloatInIntFormat_t  PD_Data_limit;
+  FloatInIntFormat_t  PD_Data_time_constant;
+  FloatInIntFormat_t  PD_Data_error_coeff;
+  FloatInIntFormat_t  PD_Data_error_rate_coeff;
+} DpmActivityMonitorCoeffExt_t;
+
+typedef struct {
+  DpmActivityMonitorCoeffExt_t DpmActivityMonitorCoeff[CUSTOM_DPM_SETTING_COUNT];
+} CustomDpmSettings_t;
+
+#define NUM_DCFCLK_DPM_LEVELS 6
+#define NUM_DISPCLK_DPM_LEVELS 6
+#define NUM_DPPCLK_DPM_LEVELS 6
+#define NUM_SOCCLK_DPM_LEVELS 8
+#define NUM_ISPICLK_DPM_LEVELS 6
+#define NUM_ISPXCLK_DPM_LEVELS 6
+#define NUM_VCN_DPM_LEVELS 8
+#define NUM_FCLK_DPM_LEVELS 4
+#define NUM_SOC_VOLTAGE_LEVELS 8
+
+typedef struct {
+  uint32_t fclk;
+  uint32_t memclk;
+  uint32_t voltage;
+} df_pstate_t;
+
+typedef struct {
+  uint32_t vclk;
+  uint32_t dclk;
+} vcn_clk_t;
+
+//Freq in MHz
+//Voltage in milli volts with 2 fractional bits
+
+typedef struct {
+  uint32_t DcfClocks[NUM_DCFCLK_DPM_LEVELS];
+  uint32_t DispClocks[NUM_DISPCLK_DPM_LEVELS];
+  uint32_t DppClocks[NUM_DPPCLK_DPM_LEVELS];
+  uint32_t SocClocks[NUM_SOCCLK_DPM_LEVELS];
+  uint32_t IspiClocks[NUM_ISPICLK_DPM_LEVELS];
+  uint32_t IspxClocks[NUM_ISPXCLK_DPM_LEVELS];
+  vcn_clk_t VcnClocks[NUM_VCN_DPM_LEVELS];
+
+  uint32_t SocVoltage[NUM_SOC_VOLTAGE_LEVELS];
+
+  df_pstate_t DfPstateTable[NUM_FCLK_DPM_LEVELS];
+
+  uint32_t MinGfxClk;
+  uint32_t MaxGfxClk;
+
+  uint8_t NumDfPstatesEnabled;
+  uint8_t NumDpmLevelsEnabled;
+  uint8_t spare[2];
+} DpmClocks_t;
+
+
+// Throttler Status Bitmask
+#define THROTTLER_STATUS_BIT_SPL 0
+#define THROTTLER_STATUS_BIT_FPPT 1
+#define THROTTLER_STATUS_BIT_SPPT 2
+#define THROTTLER_STATUS_BIT_SPPT_APU 3
+#define THROTTLER_STATUS_BIT_THM_CORE 4
+#define THROTTLER_STATUS_BIT_THM_GFX 5
+#define THROTTLER_STATUS_BIT_THM_SOC 6
+#define THROTTLER_STATUS_BIT_TDC_VDD 7
+#define THROTTLER_STATUS_BIT_TDC_SOC 8
+#define THROTTLER_STATUS_BIT_TDC_GFX 9
+#define THROTTLER_STATUS_BIT_TDC_CVIP 10
+
+typedef struct {
+  uint16_t AverageGfxclkFrequency; //[MHz]
+  uint16_t AverageSocclkFrequency; //[MHz]
+  uint16_t AverageVclkFrequency;   //[MHz]
+  uint16_t AverageDclkFrequency;   //[MHz]
+  uint16_t AverageMemclkFrequency; //[MHz]
+  uint16_t spare;
+
+  uint16_t AverageGfxActivity; //[centi]
+  uint16_t AverageUvdActivity; //[centi]
+
+  uint16_t Voltage[3];         //[mV] indices: VDDCR_VDD, VDDCR_SOC, VDDCR_GFX
+  uint16_t Current[3];         //[mA] indices: VDDCR_VDD, VDDCR_SOC, VDDCR_GFX
+  uint16_t Power[3];           //[mW] indices: VDDCR_VDD, VDDCR_SOC, VDDCR_GFX
+  uint16_t CurrentSocketPower; //[mW]
+
+  //3rd party tools in Windows need this info in the case of APUs
+  uint16_t CoreFrequency[8];   //[MHz]
+  uint16_t CorePower[8];       //[mW]
+  uint16_t CoreTemperature[8]; //[centi-Celsius]
+  uint16_t L3Frequency[2];     //[MHz]
+  uint16_t L3Temperature[2];   //[centi-Celsius]
+
+  uint16_t GfxTemperature; //[centi-Celsius]
+  uint16_t SocTemperature; //[centi-Celsius]
+  uint16_t EdgeTemperature;
+  uint16_t ThrottlerStatus;
+} SmuMetrics_t;
+
+
+// Workload bits
+#define WORKLOAD_PPLIB_FULL_SCREEN_3D_BIT 0
+#define WORKLOAD_PPLIB_VIDEO_BIT 2
+#define WORKLOAD_PPLIB_VR_BIT 3
+#define WORKLOAD_PPLIB_COMPUTE_BIT 4
+#define WORKLOAD_PPLIB_CUSTOM_BIT 5
+#define WORKLOAD_PPLIB_COUNT 6
+
+#define TABLE_BIOS_IF 0    // Called by BIOS
+#define TABLE_WATERMARKS 1 // Called by DAL through VBIOS
+#define TABLE_CUSTOM_DPM 2 // Called by Driver
+#define TABLE_SPARE1 3
+#define TABLE_DPMCLOCKS 4    // Called by Driver
+#define TABLE_MOMENTARY_PM 5 // Called by Tools
+#define TABLE_MODERN_STDBY 6 // Called by Tools for Modern Standby Log
+#define TABLE_SMU_METRICS 7  // Called by Driver
+#define TABLE_COUNT 8
+
+//ISP tile definitions
+typedef enum {
+  TILE_ISPX = 0, // ISPX
+  TILE_ISPM,     // ISPM
+  TILE_ISPC,  // ISPCORE
+  TILE_ISPPRE,   // ISPPRE
+  TILE_ISPPOST,  // ISPPOST
+  TILE_MAX
+} TILE_NUM_e;
+
+// Tile Selection (Based on arguments)
+#define TILE_SEL_ISPX       (1<<(TILE_ISPX))
+#define TILE_SEL_ISPM       (1<<(TILE_ISPM))
+#define TILE_SEL_ISPC       (1<<(TILE_ISPC))
+#define TILE_SEL_ISPPRE     (1<<(TILE_ISPPRE))
+#define TILE_SEL_ISPPOST    (1<<(TILE_ISPPOST))
+
+// Mask for ISP tiles in PGFSM PWR Status Registers
+//Bit[1:0] maps to ISPX, (ISPX)
+//Bit[3:2] maps to ISPM, (ISPM)
+//Bit[5:4] maps to ISPCORE, (ISPCORE)
+//Bit[7:6] maps to ISPPRE, (ISPPRE)
+//Bit[9:8] maps to POST, (ISPPOST
+#define TILE_ISPX_MASK      ((1<<0) | (1<<1))
+#define TILE_ISPM_MASK      ((1<<2) | (1<<3))
+#define TILE_ISPC_MASK      ((1<<4) | (1<<5))
+#define TILE_ISPPRE_MASK    ((1<<6) | (1<<7))
+#define TILE_ISPPOST_MASK   ((1<<8) | (1<<9))
+
+#endif
-- 
2.25.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
