Return-Path: <SRS0=Gn/P=56=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1901C2BA2B
	for <amd-gfx@archiver.kernel.org>; Tue, 14 Apr 2020 03:10:46 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 64F6E2072D
	for <amd-gfx@archiver.kernel.org>; Tue, 14 Apr 2020 03:10:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="Mi4ev/UH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 64F6E2072D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 741696E447;
	Tue, 14 Apr 2020 03:10:45 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2059.outbound.protection.outlook.com [40.107.236.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2AE6C6E445
 for <amd-gfx@lists.freedesktop.org>; Tue, 14 Apr 2020 03:10:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ivcTCeFGVcqAvfLixdIRi8UBoeKbPkJhispSKJMgr1u51pm/uiaMikVGCS2gSu5wY3Nl1e8mHW5nEHSHFbuu8aakNBtEjWYNCRXuJvfs4JNVjqx+yQdSXfgpCYWhMZouForQQChKmdOJSznruTB3yx+HBX8GHuRhBhUmljSG5NLpn+jU6kqLI8J6mox5G+B9SXTTwyS2fyDrH+dDAXjNAfPqp+MGbyI85p19VzGKmhVTfACm+LDyZqqCenutXzrrhXY4UJchYlD3Fw0Mq4wsepqVQZUD+7E6kKEHjDTNdRQBgittR4/SSFXAdsj6GR9Iqy4DKbP995kLII5L5Ajbcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FBdrKuuVwChlFdU8Gilp01l19VfP9x7S7Za1fAsYk7s=;
 b=fiPOaVIhd4Q1zpqSpoSgqM7HZsn/4VJ2kH6cuf/kc9TZ7Lhjx7yOIerE7itq8WBqnBov9O/WsAAgz+9SjikXJa8HecxUo/K6Gufcr+7SfPQPs2wl38gCs6SC+fOg10F78Sk7jasT4aAWoduaeYswqZFN8CXL3wmnuXAbAyuCGmFmqJpYDHoJZn6qaS4VMMhj/x29s0AFUYOWygo9si6bExXlPgCWJz99G2Ox6AHTWI2wXEB7irmy8AGaBvN1IMKEztv6yOS8Vd3hyWESW12Pe2WDZ+RcvIKkm+bKg725HX9XfdUyUCbVRaJchuhPCn3Eg0gzPXemH+p2rxX73Pu0BA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FBdrKuuVwChlFdU8Gilp01l19VfP9x7S7Za1fAsYk7s=;
 b=Mi4ev/UH1KBxlHlqN4vmF0YXcjsZ9h6hVbvpK8AhPGB24cM7p6oUL0ZyN4qOEWE4YWT894wcO4udOr6K9RWUjC/PbsPkYAiPfLVUz8tUBhPm0D6ZAUzU+Z5TcHApYboTlk49/solp2QacZ3WiBsE3JaQOxD4gk+ZXgqLjcnP74Q=
Received: from MN2PR12MB3598.namprd12.prod.outlook.com (2603:10b6:208:d1::20)
 by MN2PR12MB3773.namprd12.prod.outlook.com (2603:10b6:208:164::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2900.26; Tue, 14 Apr
 2020 03:10:41 +0000
Received: from MN2PR12MB3598.namprd12.prod.outlook.com
 ([fe80::5178:7eda:e982:2871]) by MN2PR12MB3598.namprd12.prod.outlook.com
 ([fe80::5178:7eda:e982:2871%5]) with mapi id 15.20.2900.028; Tue, 14 Apr 2020
 03:10:41 +0000
From: "Feng, Kenneth" <Kenneth.Feng@amd.com>
To: "Quan, Evan" <Evan.Quan@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 1/2] drm/amd/powerplay: revise the way to retrieve the
 board parameters
Thread-Topic: [PATCH 1/2] drm/amd/powerplay: revise the way to retrieve the
 board parameters
Thread-Index: AQHWEXEZvBwVLz7PHEyRUlHQ6027r6h38aLA
Date: Tue, 14 Apr 2020 03:10:41 +0000
Message-ID: <MN2PR12MB35983EF57362C069CBED86838EDA0@MN2PR12MB3598.namprd12.prod.outlook.com>
References: <20200413085347.590-1-evan.quan@amd.com>
In-Reply-To: <20200413085347.590-1-evan.quan@amd.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=true;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2020-04-14T03:10:39Z; 
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal Use Only -
 Unrestricted;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ActionId=046b5008-8bc2-47ed-8f0b-00000d1f0219;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=1
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_enabled: true
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_setdate: 2020-04-14T03:10:39Z
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_method: Standard
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_name: Internal Use Only -
 Unrestricted
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_actionid: 7b08351e-937b-4b92-930a-00007c6405e5
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_contentbits: 0
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Kenneth.Feng@amd.com; 
x-originating-ip: [240e:e0:8f58:a400:eca4:7196:e5b9:a351]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: aaba3317-50c7-4de3-aaba-08d7e0216a36
x-ms-traffictypediagnostic: MN2PR12MB3773:|MN2PR12MB3773:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR12MB3773B0A256C34BC8CA291E558EDA0@MN2PR12MB3773.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-forefront-prvs: 0373D94D15
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB3598.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(10009020)(4636009)(366004)(346002)(376002)(39860400002)(136003)(396003)(81156014)(8936002)(186003)(4326008)(86362001)(478600001)(55016002)(9686003)(7696005)(8676002)(2906002)(110136005)(316002)(66556008)(66476007)(66446008)(64756008)(71200400001)(53546011)(33656002)(6506007)(5660300002)(76116006)(66946007)(30864003)(52536014)(43043002);
 DIR:OUT; SFP:1101; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: TAYp9cbBMvxgpGzX0j3DiTaCYx3zTCLSUF2NHsYNTxdhh7GG1BGc/jYy72g1sGw8ZQ1PVSwKkAX1ghAoRPKXROlOTIqDFf5KAxSOwSWsA8qbtmf5Ixw6BmqkvGDLnNiFX8GOeFxfhoNFY10sDrodywXQokCjPXQ9dNImxdyOwaEVgEOno/vcVFZ3P7hoLFnpBQfLatGAPDQLb9eZ7m2J84htJnYq2iaR7gFPzXq+L+wDmkFf7qAEIVjkC5gcP+W/u0Zfn/rOsyIqWVl4Wd48XAf6B5tMIJJQI/11QLHbLhCRcDobobKCkWpcJvVZVyuLASyznNoxvqWx/wTBoBrwkVmzpRdcjqZAncWPyyGulhEeXi9G7pkrD2Sd8kXFJElI368D2b0d2lOZDKu1Z2zoJ1ogrCNCFfZMgSxKglWDY64da3ihYwCc/kWW05GFGL4RAt2F3e5+ksTxORlkJVBliG1HIp2sjA3sQOJ0S1sjMHM21pbODVSvXUia9e/M3bWw
x-ms-exchange-antispam-messagedata: P+X/WZWiHZ1bFyCsBpnyPMWflc2fNMM6WdKsEd5RjvetjQO8dwAJsS1Z3t587o5DQtRBuXL3y6LpDZBfqqmB3PCDXgprotrsCJvXNzgLTuAsUt+6We68WuHp+yEPrENwkP6Ht0KrhJByp8+6u1/BJEb3qVjU9Tx2pFR5KnUOFHHMeCn8fi79w8leh6Si/jf1uVtFrTcZgosPOT58HnB7xg==
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aaba3317-50c7-4de3-aaba-08d7e0216a36
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Apr 2020 03:10:41.5245 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3K5jysDf6fP2D82J25gPf2pcuFa+88TSooEZjOcvMBA53PKUqOTQubYT7K1MejfH
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3773
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - Internal Distribution Only]

Reviewed-by: Kenneth Feng <kenneth.feng@amd.com>


-----Original Message-----
From: Quan, Evan <Evan.Quan@amd.com> 
Sent: Monday, April 13, 2020 4:54 PM
To: amd-gfx@lists.freedesktop.org
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Feng, Kenneth <Kenneth.Feng@amd.com>; Quan, Evan <Evan.Quan@amd.com>
Subject: [PATCH 1/2] drm/amd/powerplay: revise the way to retrieve the board parameters

It can support different NV1x ASIC better. And this can guard no member got missing.

Change-Id: Id5e6608f6be1b31ef1c0a5c1d399da295524ff43
Signed-off-by: Evan Quan <evan.quan@amd.com>
---
 drivers/gpu/drm/amd/include/atomfirmware.h | 102 +++++++++++++++++++++  drivers/gpu/drm/amd/powerplay/navi10_ppt.c |  99 ++++++--------------
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
     Data Table asic_profiling_info  structure diff --git a/drivers/gpu/drm/amd/powerplay/navi10_ppt.c b/drivers/gpu/drm/amd/powerplay/navi10_ppt.c
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
