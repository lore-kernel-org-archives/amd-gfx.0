Return-Path: <SRS0=ysjs=55=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68359C2BA19
	for <amd-gfx@archiver.kernel.org>; Mon, 13 Apr 2020 08:54:14 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3227C20692
	for <amd-gfx@archiver.kernel.org>; Mon, 13 Apr 2020 08:54:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="n0fxYES4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3227C20692
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A0AC26E056;
	Mon, 13 Apr 2020 08:54:13 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2049.outbound.protection.outlook.com [40.107.92.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6764B6E056
 for <amd-gfx@lists.freedesktop.org>; Mon, 13 Apr 2020 08:54:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ihPmP0Q1/ggxnox6+NzktyGWM7deiHliRJS3163r+YIV+L/lgFajX2NJwfSn15m1WTc4XoQPVFH4TzLvuF122K4SXwCIL347ffUUMyxvMD+a/rFPp4QV50S+d6frZGtnN7EzMXMtYLh+DBPrEJ4I+XylfxEYPJq2+/OZrVLmGOi86ZFHK4/coBRDvP4acIpVfsrQkpsKd+2+2i2OP1E5h1H4mVfwJILv/H8eVk/8UxzuWlEWtMcp27VJ2w5xwseue7/F0wnn8nH2DyZjrhbLTzLLwcrwFeX2pxwcLAWPvE5C3vhOA8KlHfOP5m+sPI/dWggEJObSdP0psKJC9RUbwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=INe+rPo4/oiO/4sIsLJl28/S4GBek1YIUPr9Jiaq2fM=;
 b=dF43o35or9LRimSZUWjvZu/oKOZMeIxX4pz2HeuMiPJ0fW4kZKvwYBckoEUGRA0THPGq7DOOlyqXy/FWmjvwwUXRZ+VAjkB7/WdmOtTp4a+X+RIsy7bmjfv0YEuM6oC2IwFdN4aag50Bxm27P8J17RPba7yW9h/d7SEW3iN1qFXX8bObHOoox8Lw0x8MDF6uCr0euc+mw43zlgr2aBUhZ3Lbm4JYt1YBSKwYZfpuUJjpsXizXgr3IsKGKcIzTirHu2N0QYFrr/ZsAwkyLGQFL2p51WFarQVRFnXVQ1GjC3rbNT94ygGR6WXP6QqQMo6EbtloV5x/irpEnC/DC31kKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=INe+rPo4/oiO/4sIsLJl28/S4GBek1YIUPr9Jiaq2fM=;
 b=n0fxYES4SCatC1Uxpm0c5Kd6lLJzaaRXwExwXVRAp7NVz6BmW5NG3qfyAclppYLY60kdBlaXozCP4x6cPm3mG5kWkH5H8xckr79zAEGa+pqXXJOgY2YjoOkEMIMh9vSI8yZtbIy3/Hkbnpew5p01iifncrvY1M4RdORe0yAAxAE=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Evan.Quan@amd.com; 
Received: from DM6PR12MB2619.namprd12.prod.outlook.com (2603:10b6:5:45::18) by
 DM6PR12MB3241.namprd12.prod.outlook.com (2603:10b6:5:186::25) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2900.24; Mon, 13 Apr 2020 08:54:10 +0000
Received: from DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::5c27:185c:be20:1fb6]) by DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::5c27:185c:be20:1fb6%5]) with mapi id 15.20.2900.028; Mon, 13 Apr 2020
 08:54:10 +0000
From: Evan Quan <evan.quan@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 1/2] drm/amd/powerplay: revise the way to retrieve the board
 parameters
Date: Mon, 13 Apr 2020 16:53:46 +0800
Message-Id: <20200413085347.590-1-evan.quan@amd.com>
X-Mailer: git-send-email 2.26.0
X-ClientProxiedBy: HK2PR0302CA0015.apcprd03.prod.outlook.com
 (2603:1096:202::25) To DM6PR12MB2619.namprd12.prod.outlook.com
 (2603:10b6:5:45::18)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from equan-buildpc.amd.com (180.167.199.189) by
 HK2PR0302CA0015.apcprd03.prod.outlook.com (2603:1096:202::25) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2921.12 via Frontend Transport; Mon, 13 Apr 2020 08:54:09 +0000
X-Mailer: git-send-email 2.26.0
X-Originating-IP: [180.167.199.189]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: a46bd613-ec2c-42ef-1e26-08d7df883b87
X-MS-TrafficTypeDiagnostic: DM6PR12MB3241:|DM6PR12MB3241:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB3241D1740E61470A07912AC2E4DD0@DM6PR12MB3241.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5516;
X-Forefront-PRVS: 037291602B
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2619.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(10009020)(4636009)(376002)(366004)(346002)(136003)(396003)(39860400002)(66946007)(66476007)(478600001)(16526019)(186003)(1076003)(316002)(5660300002)(2616005)(66556008)(6666004)(52116002)(44832011)(7696005)(6916009)(956004)(86362001)(26005)(8936002)(6486002)(8676002)(36756003)(2906002)(4326008)(81156014)(43043002);
 DIR:OUT; SFP:1101; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: okH8eTuI3QO5I4sYJjkJSiNNO3wex965MpslETwapMgnkT5EMPagDUiIG4C1rHCK23iMrLRkQt45ai9MuRfa0U89kpg+O42a34AZG5oRdVdLDNeyfRUHjqL6vesUX7TGxLYUvtxc34T/Dq4sVjVhUipaafs55gEAjxgzK2QXyEvMl2qI48rpkMY21o80IweYf+vf9D16mxAv6JDaLfzKRSu8RDk41N+Ry1f6bbl81MhgPbaENfvZeLqTNe+khcMiWcaeZrgQEHm1oFzkFNH6pLqpmGAYN9nGTU5fQ3T3gc0js8+dYI4VpIXN9aT4ya8Bidqz5ajniPGKNTtJSZ+mlWoznYdQRHlP7HiH6qtL2sQpbTYKHXRIRcKPadEYJgX0K91h8BSooOzzVlhMaGyCZ//RuFTEOhQWm8fum8WbXj2ZMYjJNNUVrJg/ZTCYWzElBm5UvR4Bl25gcE3jxzHNWcHilO1vEoLcq5h3PQ6rlAmLpx1m4AYUTkcz+EM1fU4Y
X-MS-Exchange-AntiSpam-MessageData: pqUYBHLsr16C5edU8N1LUSPcpyoCyukZFQPDF5R1t4AJl0qtRdfJHD5fxrXcdxJh/W66QZ1ePU1x4Xk9nBQpP8f2E5t2uiemO/leNF7MkAx99xZDrChiQfdlGYFHCgdlvOP5us7EtSkbAH46RDloLQ==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a46bd613-ec2c-42ef-1e26-08d7df883b87
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Apr 2020 08:54:10.5750 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QZqiSAlHqYDUVtBgpytHqoV8LnU6GlTB9sxDsUhEYuv+qLpgWYkbsD18y+UEDVhJ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3241
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
Cc: Alexander.Deucher@amd.com, Evan Quan <evan.quan@amd.com>,
 kenneth.feng@amd.com
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
index 15030284b444..c94270f7c198 100644
--- a/drivers/gpu/drm/amd/powerplay/navi10_ppt.c
+++ b/drivers/gpu/drm/amd/powerplay/navi10_ppt.c
@@ -423,6 +423,7 @@ static int navi10_append_powerplay_table(struct smu_context *smu)
 	struct smu_table_context *table_context = &smu->smu_table;
 	PPTable_t *smc_pptable = table_context->driver_pptable;
 	struct atom_smc_dpm_info_v4_5 *smc_dpm_table;
+	struct atom_smc_dpm_info_v4_7 *smc_dpm_table_v4_7;
 	int index, ret;
 
 	index = get_index_into_master_table(atom_master_list_of_data_tables_v2_1,
@@ -433,77 +434,33 @@ static int navi10_append_powerplay_table(struct smu_context *smu)
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
2.26.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
