Return-Path: <SRS0=1gsM=4X=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87CB5C10DCE
	for <amd-gfx@archiver.kernel.org>; Fri,  6 Mar 2020 10:13:54 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4CB58207FD
	for <amd-gfx@archiver.kernel.org>; Fri,  6 Mar 2020 10:13:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="x/ctFas2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4CB58207FD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C84FD6ECC1;
	Fri,  6 Mar 2020 10:13:53 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2055.outbound.protection.outlook.com [40.107.243.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 80FA36ECC1
 for <amd-gfx@lists.freedesktop.org>; Fri,  6 Mar 2020 10:13:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iFWGruVzFognU23zHEyBlQXV4azTmAmPTB2A8W1cNf6vulIFkNjqDkKW19/tOhqPZ6p0elwutqGJC08niLQMCcLejXPFpVEjQuaOfLvA+bYQ+OcqAFFquAaR+HUjr+PGFsFxehI5rRvywROLygcdSgh3y62sPAWiFm61wA3VK1HiqgJjNtLT7/aBljgrD1Rp/gofNFsQvxIBlJPkSTvqNFgQ1+T9qaYITxNeX7x3fo2FGymQJwpdV26KKwkpjxIYpJw8IUYR+30YQTkuso2jOGLgsjDQtyqv2DLeRcG3+yBfdZyQpeN09quEUGOHu5bRhypj+xHJ57aF/CZo9q7JJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y1v7O2LayHcc4wRyGfhnVopoCutty3H8uK9hM3eQuHs=;
 b=YvlBKtUtpo3T5x3H52yenaBl6LUvb5oZFKgr9uF+9MuINzasq4eYsCa0I/M3WsAJzm5/ODAzZzMPEgjSM4aLzm2BFX6j8Mtf2NFabCxRyOLEWkXQejg1c9oZ2RtzA8jZJG6EkXJsskX18DEPoWDsiE1eqySIn5UFQIJAFmN2NS3TUn6hevkEYxcf1e4TfQu7pIb2+IUcYGjtPWrcpgF8KhnkkznyrK/AYDGCrtGKVVf+akvKCNg2hDS2PQV1LO8WhgBVBy8a4nm6Y/ItRKtfYXQY+XzLqq4zQoYWLvu4FvDqh9vVSdO/UTz+asVcVAVwIa1LW5WXrylJnZ7Jxkzz+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y1v7O2LayHcc4wRyGfhnVopoCutty3H8uK9hM3eQuHs=;
 b=x/ctFas2IWUNTCRwZGMcPTR0f1WanF0AIPiAGG/jID356v/+DEA6FZ/jLHWAAaLfP6QFlEvVR0A/ujbkJ9o2zLn4V04BXbUPBydxl/LjYVEOmz9V3hztsArU3EyLmh4Tt09DQka7H0Hl+sEdsGqZA3cZdOY4nyb/57mgv0lEdOU=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Evan.Quan@amd.com; 
Received: from MN2PR12MB3344.namprd12.prod.outlook.com (2603:10b6:208:c5::10)
 by MN2PR12MB4406.namprd12.prod.outlook.com (2603:10b6:208:268::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2772.18; Fri, 6 Mar
 2020 10:13:50 +0000
Received: from MN2PR12MB3344.namprd12.prod.outlook.com
 ([fe80::69c7:b493:690:2173]) by MN2PR12MB3344.namprd12.prod.outlook.com
 ([fe80::69c7:b493:690:2173%3]) with mapi id 15.20.2793.013; Fri, 6 Mar 2020
 10:13:50 +0000
From: Evan Quan <evan.quan@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amd/powerplay: revise the way to retrieve the board
 parameters
Date: Fri,  6 Mar 2020 18:13:30 +0800
Message-Id: <20200306101330.4610-1-evan.quan@amd.com>
X-Mailer: git-send-email 2.25.1
X-ClientProxiedBy: HK2PR06CA0022.apcprd06.prod.outlook.com
 (2603:1096:202:2e::34) To MN2PR12MB3344.namprd12.prod.outlook.com
 (2603:10b6:208:c5::10)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from equan-buildpc.amd.com (180.167.199.189) by
 HK2PR06CA0022.apcprd06.prod.outlook.com (2603:1096:202:2e::34) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2793.16 via Frontend Transport; Fri, 6 Mar 2020 10:13:48 +0000
X-Mailer: git-send-email 2.25.1
X-Originating-IP: [180.167.199.189]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 12aa2187-4bba-4e53-df17-08d7c1b71087
X-MS-TrafficTypeDiagnostic: MN2PR12MB4406:|MN2PR12MB4406:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB4406F4D1368425389E4692EBE4E30@MN2PR12MB4406.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5516;
X-Forefront-PRVS: 0334223192
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(396003)(136003)(376002)(346002)(39860400002)(366004)(199004)(189003)(52116002)(8936002)(6916009)(8676002)(7696005)(5660300002)(6486002)(81156014)(66476007)(1076003)(66946007)(66556008)(81166006)(86362001)(36756003)(956004)(2906002)(26005)(316002)(478600001)(6666004)(2616005)(16526019)(44832011)(186003)(4326008)(43043002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MN2PR12MB4406;
 H:MN2PR12MB3344.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LjYjj6gaVyGJhtGFDZe64akA55RBykB8sUnNSTKXqhkAtF2JpTFqBowQqj+Iekjcz4w7jTHDZXYTDvPxfRk2s+MPr09S7HKsKqqm1jsPOQg5hOLQ+Gny7KZmh95OotWlJ5KRLzlshu5OLxO27nDrcpM36D/oEYA1CWgqOqe4ksFpiVGJbO+7qabIfDHMix1Pd+63/vhEqpDfsp41S2IN7dkf7QDm5d2SQ2qBZsFDPoEzBR8qhFhmq+57RVkb4c9nqMQFVN9EV1OL/WFPcVZXVWGrGmOWtIc5LMjdcERMmjpJLRZQYbUPjwoZ0Ji81r2I2HWgD39mzvJc3cWtA2J3dTXg96NVVwGhqSO+Sb/hsDhapTXkJhnZOHoBAnmasG6TwfI31KHGVvflMbX7ga+aUMU8M6ZhHR5Qbl8JA4KQXA1+LYN/3DEoytae3Y441tvnsMKpHuf6heJzvq5bBWrQplsUuW/+2u8zqXdS/V3qrBmmGL0VTCoLekzsKpuCG8Qq
X-MS-Exchange-AntiSpam-MessageData: 33+9jOm/Q6yAbaqzAUCA+uidfCAnJqknnEcYq2pe1zH5Y1BxH+tnJKSlPsymyTL/PRuV+Q3kmv3PyGvSS5ksGbLuWuZYycHx8qgE+Z9mUo0eNsKxP8qyEhh9RcF9ti5KYwGZV94aTGv9FOf9pwH5yw==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 12aa2187-4bba-4e53-df17-08d7c1b71087
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Mar 2020 10:13:50.0488 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: h7lYoqZCGnVmUTzgIgYeE6/BdmDOhcp5QSRry51+2q3+b3JFWFdD2f/0NHgQO7AF
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4406
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
Cc: Evan Quan <evan.quan@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

It can support different NV1x ASIC better. And this can guard
no member got missing.

Change-Id: Id5e6608f6be1b31ef1c0a5c1d399da295524ff43
Signed-off-by: Evan Quan <evan.quan@amd.com>
---
 drivers/gpu/drm/amd/include/atomfirmware.h | 102 +++++++++++++++++++++
 drivers/gpu/drm/amd/powerplay/navi10_ppt.c |  99 ++++++--------------
 2 files changed, 130 insertions(+), 71 deletions(-)

diff --git a/drivers/gpu/drm/amd/include/atomfirmware.h b/drivers/gpu/drm/amd/include/atomfirmware.h
index 70146518174c..a6f6e6bf5992 100644
--- a/drivers/gpu/drm/amd/include/atomfirmware.h
+++ b/drivers/gpu/drm/amd/include/atomfirmware.h
@@ -1876,6 +1876,108 @@ struct atom_smc_dpm_info_v4_6
   uint32_t   boardreserved[10];
 };
 
+struct atom_smc_dpm_info_v4_7
+{
+  struct   atom_common_table_header  table_header;
+    // SECTION: BOARD PARAMETERS
+    // I2C Control
+  struct smudpm_i2c_controller_config_v2  I2cControllers[8];
+
+  // SVI2 Board Parameters
+  uint16_t     MaxVoltageStepGfx; // In mV(Q2) Max voltage step that SMU will request. Multiple steps are taken if voltage change exceeds this value.
+  uint16_t     MaxVoltageStepSoc; // In mV(Q2) Max voltage step that SMU will request. Multiple steps are taken if voltage change exceeds this value.
+
+  uint8_t      VddGfxVrMapping;   // Use VR_MAPPING* bitfields
+  uint8_t      VddSocVrMapping;   // Use VR_MAPPING* bitfields
+  uint8_t      VddMem0VrMapping;  // Use VR_MAPPING* bitfields
+  uint8_t      VddMem1VrMapping;  // Use VR_MAPPING* bitfields
+
+  uint8_t      GfxUlvPhaseSheddingMask; // set this to 1 to set PSI0/1 to 1 in ULV mode
+  uint8_t      SocUlvPhaseSheddingMask; // set this to 1 to set PSI0/1 to 1 in ULV mode
+  uint8_t      ExternalSensorPresent; // External RDI connected to TMON (aka TEMP IN)
+  uint8_t      Padding8_V;
+
+  // Telemetry Settings
+  uint16_t     GfxMaxCurrent;   // in Amps
+  uint8_t      GfxOffset;       // in Amps
+  uint8_t      Padding_TelemetryGfx;
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
+  // GPIO Settings
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
+  uint8_t      padding8_4;
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
+  // SOCCLK Spread Spectrum
+  uint8_t      SoclkSpreadEnabled;   // on or off
+  uint8_t      SocclkSpreadPercent;   // Q4.4
+  uint16_t     SocclkSpreadFreq;      // kHz
+
+  // Total board power
+  uint16_t     TotalBoardPower;     //Only needed for TCP Estimated case, where TCP = TGP+Total Board Power
+  uint16_t     BoardPadding;
+
+  // Mvdd Svi2 Div Ratio Setting
+  uint32_t     MvddRatio; // This is used for MVDD Vid workaround. It has 16 fractional bits (Q16.16)
+
+  // GPIO pins for I2C communications with 2nd controller for Input Telemetry Sequence
+  uint8_t      GpioI2cScl;          // Serial Clock
+  uint8_t      GpioI2cSda;          // Serial Data
+  uint16_t     GpioPadding;
+
+  // Additional LED Display Settings
+  uint8_t      LedPin3;         // GPIO number for LedPin[3] - PCIE GEN Speed
+  uint8_t      LedPin4;         // GPIO number for LedPin[4] - PMFW Error Status
+  uint16_t     LedEnableMask;
+
+  // Power Limit Scalars
+  uint8_t      PowerLimitScalar[4];    //[PPT_THROTTLER_COUNT]
+
+  uint8_t      MvddUlvPhaseSheddingMask;
+  uint8_t      VddciUlvPhaseSheddingMask;
+  uint8_t      Padding8_Psi1;
+  uint8_t      Padding8_Psi2;
+
+  uint32_t     BoardReserved[5];
+};
+
 /* 
   ***************************************************************************
     Data Table asic_profiling_info  structure
diff --git a/drivers/gpu/drm/amd/powerplay/navi10_ppt.c b/drivers/gpu/drm/amd/powerplay/navi10_ppt.c
index 6e41f3c9ff1b..dd709e253888 100644
--- a/drivers/gpu/drm/amd/powerplay/navi10_ppt.c
+++ b/drivers/gpu/drm/amd/powerplay/navi10_ppt.c
@@ -421,6 +421,7 @@ static int navi10_append_powerplay_table(struct smu_context *smu)
 	struct smu_table_context *table_context = &smu->smu_table;
 	PPTable_t *smc_pptable = table_context->driver_pptable;
 	struct atom_smc_dpm_info_v4_5 *smc_dpm_table;
+	struct atom_smc_dpm_info_v4_7 *smc_dpm_table_v4_7;
 	int index, ret;
 
 	index = get_index_into_master_table(atom_master_list_of_data_tables_v2_1,
@@ -431,77 +432,33 @@ static int navi10_append_powerplay_table(struct smu_context *smu)
 	if (ret)
 		return ret;
 
-	memcpy(smc_pptable->I2cControllers, smc_dpm_table->I2cControllers,
-	       sizeof(I2cControllerConfig_t) * NUM_I2C_CONTROLLERS);
-
-	/* SVI2 Board Parameters */
-	smc_pptable->MaxVoltageStepGfx = smc_dpm_table->MaxVoltageStepGfx;
-	smc_pptable->MaxVoltageStepSoc = smc_dpm_table->MaxVoltageStepSoc;
-	smc_pptable->VddGfxVrMapping = smc_dpm_table->VddGfxVrMapping;
-	smc_pptable->VddSocVrMapping = smc_dpm_table->VddSocVrMapping;
-	smc_pptable->VddMem0VrMapping = smc_dpm_table->VddMem0VrMapping;
-	smc_pptable->VddMem1VrMapping = smc_dpm_table->VddMem1VrMapping;
-	smc_pptable->GfxUlvPhaseSheddingMask = smc_dpm_table->GfxUlvPhaseSheddingMask;
-	smc_pptable->SocUlvPhaseSheddingMask = smc_dpm_table->SocUlvPhaseSheddingMask;
-	smc_pptable->ExternalSensorPresent = smc_dpm_table->ExternalSensorPresent;
-	smc_pptable->Padding8_V = smc_dpm_table->Padding8_V;
-
-	/* Telemetry Settings */
-	smc_pptable->GfxMaxCurrent = smc_dpm_table->GfxMaxCurrent;
-	smc_pptable->GfxOffset = smc_dpm_table->GfxOffset;
-	smc_pptable->Padding_TelemetryGfx = smc_dpm_table->Padding_TelemetryGfx;
-	smc_pptable->SocMaxCurrent = smc_dpm_table->SocMaxCurrent;
-	smc_pptable->SocOffset = smc_dpm_table->SocOffset;
-	smc_pptable->Padding_TelemetrySoc = smc_dpm_table->Padding_TelemetrySoc;
-	smc_pptable->Mem0MaxCurrent = smc_dpm_table->Mem0MaxCurrent;
-	smc_pptable->Mem0Offset = smc_dpm_table->Mem0Offset;
-	smc_pptable->Padding_TelemetryMem0 = smc_dpm_table->Padding_TelemetryMem0;
-	smc_pptable->Mem1MaxCurrent = smc_dpm_table->Mem1MaxCurrent;
-	smc_pptable->Mem1Offset = smc_dpm_table->Mem1Offset;
-	smc_pptable->Padding_TelemetryMem1 = smc_dpm_table->Padding_TelemetryMem1;
-
-	/* GPIO Settings */
-	smc_pptable->AcDcGpio = smc_dpm_table->AcDcGpio;
-	smc_pptable->AcDcPolarity = smc_dpm_table->AcDcPolarity;
-	smc_pptable->VR0HotGpio = smc_dpm_table->VR0HotGpio;
-	smc_pptable->VR0HotPolarity = smc_dpm_table->VR0HotPolarity;
-	smc_pptable->VR1HotGpio = smc_dpm_table->VR1HotGpio;
-	smc_pptable->VR1HotPolarity = smc_dpm_table->VR1HotPolarity;
-	smc_pptable->GthrGpio = smc_dpm_table->GthrGpio;
-	smc_pptable->GthrPolarity = smc_dpm_table->GthrPolarity;
-
-	/* LED Display Settings */
-	smc_pptable->LedPin0 = smc_dpm_table->LedPin0;
-	smc_pptable->LedPin1 = smc_dpm_table->LedPin1;
-	smc_pptable->LedPin2 = smc_dpm_table->LedPin2;
-	smc_pptable->padding8_4 = smc_dpm_table->padding8_4;
-
-	/* GFXCLK PLL Spread Spectrum */
-	smc_pptable->PllGfxclkSpreadEnabled = smc_dpm_table->PllGfxclkSpreadEnabled;
-	smc_pptable->PllGfxclkSpreadPercent = smc_dpm_table->PllGfxclkSpreadPercent;
-	smc_pptable->PllGfxclkSpreadFreq = smc_dpm_table->PllGfxclkSpreadFreq;
-
-	/* GFXCLK DFLL Spread Spectrum */
-	smc_pptable->DfllGfxclkSpreadEnabled = smc_dpm_table->DfllGfxclkSpreadEnabled;
-	smc_pptable->DfllGfxclkSpreadPercent = smc_dpm_table->DfllGfxclkSpreadPercent;
-	smc_pptable->DfllGfxclkSpreadFreq = smc_dpm_table->DfllGfxclkSpreadFreq;
-
-	/* UCLK Spread Spectrum */
-	smc_pptable->UclkSpreadEnabled = smc_dpm_table->UclkSpreadEnabled;
-	smc_pptable->UclkSpreadPercent = smc_dpm_table->UclkSpreadPercent;
-	smc_pptable->UclkSpreadFreq = smc_dpm_table->UclkSpreadFreq;
-
-	/* SOCCLK Spread Spectrum */
-	smc_pptable->SoclkSpreadEnabled = smc_dpm_table->SoclkSpreadEnabled;
-	smc_pptable->SocclkSpreadPercent = smc_dpm_table->SocclkSpreadPercent;
-	smc_pptable->SocclkSpreadFreq = smc_dpm_table->SocclkSpreadFreq;
-
-	/* Total board power */
-	smc_pptable->TotalBoardPower = smc_dpm_table->TotalBoardPower;
-	smc_pptable->BoardPadding = smc_dpm_table->BoardPadding;
-
-	/* Mvdd Svi2 Div Ratio Setting */
-	smc_pptable->MvddRatio = smc_dpm_table->MvddRatio;
+	pr_info("smc_dpm_info table revision(format.content): %d.%d\n",
+			smc_dpm_table->table_header.format_revision,
+			smc_dpm_table->table_header.content_revision);
+
+	if (smc_dpm_table->table_header.format_revision != 4) {
+		pr_err("smc_dpm_info table format revision is not 4!\n");
+		return -EINVAL;
+	}
+
+	switch (smc_dpm_table->table_header.content_revision) {
+	case 5: /* nv10 and nv14 */
+		memcpy(smc_pptable->I2cControllers, smc_dpm_table->I2cControllers,
+			sizeof(*smc_dpm_table) - sizeof(smc_dpm_table->table_header));
+		break;
+	case 7: /* nv12 */
+		ret = smu_get_atom_data_table(smu, index, NULL, NULL, NULL,
+					      (uint8_t **)&smc_dpm_table_v4_7);
+		if (ret)
+			return ret;
+		memcpy(smc_pptable->I2cControllers, smc_dpm_table_v4_7->I2cControllers,
+			sizeof(*smc_dpm_table_v4_7) - sizeof(smc_dpm_table_v4_7->table_header));
+		break;
+	default:
+		pr_err("smc_dpm_info with unsupported content revision %d!\n",
+				smc_dpm_table->table_header.content_revision);
+		return -EINVAL;
+	}
 
 	if (adev->pm.pp_feature & PP_GFXOFF_MASK) {
 		/* TODO: remove it once SMU fw fix it */
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
