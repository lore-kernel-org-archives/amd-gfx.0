Return-Path: <SRS0=+jgF=7O=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEC8EC433DF
	for <amd-gfx@archiver.kernel.org>; Mon,  1 Jun 2020 18:22:31 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B77892073B
	for <amd-gfx@archiver.kernel.org>; Mon,  1 Jun 2020 18:22:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CtWkl+Z9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B77892073B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 76D226E34C;
	Mon,  1 Jun 2020 18:22:31 +0000 (UTC)
Received: from mail-qt1-x841.google.com (mail-qt1-x841.google.com
 [IPv6:2607:f8b0:4864:20::841])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 274136E354
 for <amd-gfx@lists.freedesktop.org>; Mon,  1 Jun 2020 18:22:30 +0000 (UTC)
Received: by mail-qt1-x841.google.com with SMTP id q14so8224328qtr.9
 for <amd-gfx@lists.freedesktop.org>; Mon, 01 Jun 2020 11:22:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=MImlpwVeM+/MtnqicKQFBCIeDyuVDqBQqOyR6DX82lM=;
 b=CtWkl+Z9LzOQu8r+JzMr5axD7qXSwbsdPl2M+tkPsUs0WMfjEbS/W37NQhU3CZEw6I
 S1xOsHK3phELUjiSAzNEkmcgMluBGedHARpjYVhARpHNyoBn5JjyCUdyXrzp/VvRm1JL
 fGfUI2HjzBeaQ5JITx9FLOUjF3e2Zp5sz4jZXTp3NO9cKs6P8TbQA1DzfUFWi8e0CeZa
 YsGdsDh0hj2K+r2/3BcUQfjNbhEpAMztKZ5923h9tCp6vDdT0kZvr5gZ0p1a8pZ82HC0
 h0wVhoolcfI4CczNayExcxp4JG1T9R4GzVforJpwEU6Tb6uc7xbEgjGNIwukkdJfFy2a
 4k4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=MImlpwVeM+/MtnqicKQFBCIeDyuVDqBQqOyR6DX82lM=;
 b=GmIISIhOJ8TXRSZV/vJoftwNhuw150CSLSZTV5YqFuDau/ipFAejDzbxA9KiNssPxt
 awjy/YIBuW9wpdY6DV7H8S5tbzw0NT9M2LPDyAlNJkXh7RFwdwU6RmJVjqP35qi2n92s
 74Yy3svqfb962r5FVHZ9OSmoX3CbKVKFxCu4ZR/dhBHWXvl5EdUwuLUszjfXtVe476g4
 Gh+8g6it5FOQOcxHAzhSWC5VfSLN8L0wjzEafkkOIenVcAr6cEvnKrjG935hWps2/qIj
 slw+JZu5zXCWN97pNcj/CePyDogQyfwWMj+QZCco2xm1QRy1E0m3PeQK0HvknnIN6jw0
 Mu0w==
X-Gm-Message-State: AOAM532U/ZejVgn1dZrXqDJZpYU4Ber5EgqIkXt6zZc3pvsg9sotsazc
 NDcagzYIE4IID82A59ee3IXsaiQC
X-Google-Smtp-Source: ABdhPJy7R9Sy7c3IbDDojDVwXYtdWF69/enXDh+Vu71RMhz1GmbcAu80Sxiv7aj+li2G4OA0SrGv1g==
X-Received: by 2002:ac8:6683:: with SMTP id d3mr22770965qtp.199.1591035749068; 
 Mon, 01 Jun 2020 11:22:29 -0700 (PDT)
Received: from tr4.amd.com (atlvpn.amd.com. [165.204.84.11])
 by smtp.gmail.com with ESMTPSA id w10sm106849qtc.15.2020.06.01.11.22.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 01 Jun 2020 11:22:28 -0700 (PDT)
From: Alex Deucher <alexdeucher@gmail.com>
X-Google-Original-From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 155/207] drm/amd/powerplay: and smc dpm info struct for
 sienna_cichlid
Date: Mon,  1 Jun 2020 14:20:02 -0400
Message-Id: <20200601182054.1267858-66-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20200601182054.1267858-1-alexander.deucher@amd.com>
References: <20200601182054.1267858-1-alexander.deucher@amd.com>
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Likun Gao <Likun.Gao@amd.com>,
 Kenneth Feng <kenneth.feng@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Likun Gao <Likun.Gao@amd.com>

And atom_smc_dpm_info_v4_9 struct for sienna_cichlid use.

Signed-off-by: Likun Gao <Likun.Gao@amd.com>
Reviewed-by: Kenneth Feng <kenneth.feng@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/include/atomfirmware.h | 123 +++++++++++++++++++++
 1 file changed, 123 insertions(+)

diff --git a/drivers/gpu/drm/amd/include/atomfirmware.h b/drivers/gpu/drm/amd/include/atomfirmware.h
index f7e98855cac7..b852248b2da8 100644
--- a/drivers/gpu/drm/amd/include/atomfirmware.h
+++ b/drivers/gpu/drm/amd/include/atomfirmware.h
@@ -2016,6 +2016,129 @@ struct atom_smc_dpm_info_v4_7
   uint32_t     BoardReserved[5];
 };
 
+struct smudpm_i2c_controller_config_v3
+{
+  uint8_t   Enabled;
+  uint8_t   Speed;
+  uint8_t   SlaveAddress;
+  uint8_t   ControllerPort;
+  uint8_t   ControllerName;
+  uint8_t   ThermalThrotter;
+  uint8_t   I2cProtocol;
+  uint8_t   PaddingConfig;
+};
+
+struct atom_smc_dpm_info_v4_9
+{
+  struct   atom_common_table_header  table_header;
+
+  //SECTION: Gaming Clocks
+  //uint32_t     GamingClk[6];
+
+  // SECTION: I2C Control
+  struct smudpm_i2c_controller_config_v3  I2cControllers[16];     
+
+  uint8_t      GpioScl;  // GPIO Number for SCL Line, used only for CKSVII2C1
+  uint8_t      GpioSda;  // GPIO Number for SDA Line, used only for CKSVII2C1
+  uint8_t      FchUsbPdSlaveAddr; //For requesting USB PD controller S-states via FCH I2C when entering PME turn off
+  uint8_t      I2cSpare;
+
+  // SECTION: SVI2 Board Parameters
+  uint8_t      VddGfxVrMapping;   // Use VR_MAPPING* bitfields
+  uint8_t      VddSocVrMapping;   // Use VR_MAPPING* bitfields
+  uint8_t      VddMem0VrMapping;  // Use VR_MAPPING* bitfields
+  uint8_t      VddMem1VrMapping;  // Use VR_MAPPING* bitfields
+
+  uint8_t      GfxUlvPhaseSheddingMask; // set this to 1 to set PSI0/1 to 1 in ULV mode
+  uint8_t      SocUlvPhaseSheddingMask; // set this to 1 to set PSI0/1 to 1 in ULV mode
+  uint8_t      VddciUlvPhaseSheddingMask; // set this to 1 to set PSI0/1 to 1 in ULV mode
+  uint8_t      MvddUlvPhaseSheddingMask; // set this to 1 to set PSI0/1 to 1 in ULV mode
+
+  // SECTION: Telemetry Settings
+  uint16_t     GfxMaxCurrent;   // in Amps
+  uint8_t      GfxOffset;       // in Amps
+  uint8_t      Padding_TelemetryGfx;
+
+  uint16_t     SocMaxCurrent;   // in Amps
+  uint8_t      SocOffset;       // in Amps
+  uint8_t      Padding_TelemetrySoc;
+
+  uint16_t     Mem0MaxCurrent;   // in Amps
+  uint8_t      Mem0Offset;       // in Amps
+  uint8_t      Padding_TelemetryMem0;
+  
+  uint16_t     Mem1MaxCurrent;   // in Amps
+  uint8_t      Mem1Offset;       // in Amps
+  uint8_t      Padding_TelemetryMem1;
+
+  uint32_t     MvddRatio; // This is used for MVDD  Svi2 Div Ratio workaround. It has 16 fractional bits (Q16.16)
+  
+  // SECTION: GPIO Settings
+  uint8_t      AcDcGpio;        // GPIO pin configured for AC/DC switching
+  uint8_t      AcDcPolarity;    // GPIO polarity for AC/DC switching
+  uint8_t      VR0HotGpio;      // GPIO pin configured for VR0 HOT event
+  uint8_t      VR0HotPolarity;  // GPIO polarity for VR0 HOT event
+
+  uint8_t      VR1HotGpio;      // GPIO pin configured for VR1 HOT event 
+  uint8_t      VR1HotPolarity;  // GPIO polarity for VR1 HOT event 
+  uint8_t      GthrGpio;        // GPIO pin configured for GTHR Event
+  uint8_t      GthrPolarity;    // replace GPIO polarity for GTHR
+
+  // LED Display Settings
+  uint8_t      LedPin0;         // GPIO number for LedPin[0]
+  uint8_t      LedPin1;         // GPIO number for LedPin[1]
+  uint8_t      LedPin2;         // GPIO number for LedPin[2]
+  uint8_t      LedEnableMask;
+
+  uint8_t      LedPcie;        // GPIO number for PCIE results
+  uint8_t      LedError;       // GPIO number for Error Cases
+  uint8_t      LedSpare1[2];
+
+  // SECTION: Clock Spread Spectrum
+  
+  // GFXCLK PLL Spread Spectrum
+  uint8_t      PllGfxclkSpreadEnabled;   // on or off
+  uint8_t      PllGfxclkSpreadPercent;   // Q4.4
+  uint16_t     PllGfxclkSpreadFreq;      // kHz
+
+  // GFXCLK DFLL Spread Spectrum
+  uint8_t      DfllGfxclkSpreadEnabled;   // on or off
+  uint8_t      DfllGfxclkSpreadPercent;   // Q4.4
+  uint16_t     DfllGfxclkSpreadFreq;      // kHz
+  
+  // UCLK Spread Spectrum
+  uint8_t      UclkSpreadEnabled;   // on or off
+  uint8_t      UclkSpreadPercent;   // Q4.4
+  uint16_t     UclkSpreadFreq;      // kHz
+
+  // FCLK Spread Spectrum
+  uint8_t      FclkSpreadEnabled;   // on or off
+  uint8_t      FclkSpreadPercent;   // Q4.4
+  uint16_t     FclkSpreadFreq;      // kHz
+  
+  // Section: Memory Config
+  uint32_t     MemoryChannelEnabled; // For DRAM use only, Max 32 channels enabled bit mask. 
+  
+  uint8_t      DramBitWidth; // For DRAM use only.  See Dram Bit width type defines
+  uint8_t      PaddingMem1[3];
+
+  // Section: Total Board Power
+  uint16_t     TotalBoardPower;     //Only needed for TCP Estimated case, where TCP = TGP+Total Board Power
+  uint16_t     BoardPowerPadding; 
+  
+  // SECTION: XGMI Training
+  uint8_t      XgmiLinkSpeed   [4];
+  uint8_t      XgmiLinkWidth   [4];
+
+  uint16_t     XgmiFclkFreq    [4];
+  uint16_t     XgmiSocVoltage  [4];
+
+  // SECTION: Board Reserved
+
+  uint32_t     BoardReserved[16];
+
+};
+
 /* 
   ***************************************************************************
     Data Table asic_profiling_info  structure
-- 
2.25.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
