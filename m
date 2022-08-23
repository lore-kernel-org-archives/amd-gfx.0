Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CEA3CC04AA5
	for <amd-gfx@archiver.kernel.org>; Wed, 24 Aug 2022 20:20:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 02DBCC6FA0;
	Wed, 24 Aug 2022 20:20:43 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2081.outbound.protection.outlook.com [40.107.220.81])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 12F96A95CC
 for <amd-gfx@lists.freedesktop.org>; Tue, 23 Aug 2022 01:55:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MALMVkyck2rpMogLOrdLsy95TKk8yjQSh2Q73XAGRyn/vhJHB3JUj9usBpQvzgZ1zeAFM2xroqDcvIFa+ybKaKR2y4FgseDkKHdm54ggzbhyjYS188undCDZMYnBa+i8amofM4wY6n/yNgcc6J4ihVRjavSGhCrV4AHTxEZNpczTC2530Gab1GipfhJWS5hwNE7BLHO5CH5Aq1LCNQ8iPnY8Mnh5NlUURskdPwHjswJdp+DqTHbY0OUWl8IxDmRtvn148B5im5BFylFgfkQTFyWaQMpl0iNa0zb8idME8d/h8NqQkuDF1Ku6MJdSQWFLU5TXQvPOccDnQ8KqPGR2ag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4tksTnL2jJLQLOkEs2VJ1qH6V3MS9FQH9wJJ5L8LZbw=;
 b=dG6QqZBNG/f3FHQg8z5RmTpEsOJKm22XP5Bz93dTtTWHPBmS5oM5OPBnNKbmykEPtkYO5yPdew548oSxznoDu2oHImuxIEr4UXMptYij+XaH+QQ82M2XE1sYo+zHsQNmc3CiQAhFdgmNlVy3VzlZ1vMXiDKDSBN+D9wsri2dS4ReHjOXmWWhFX7BnhfwbiCTFy6fyeO+f4OiznSHLG9XD+RAvupfhYtX2YuBLmtyhNcto8FyzL1F5prhcMVTiWGR1Zqc8cncd9wrQonIu0E6fp5SwhT6HK0Od0HQR+9EFlycMsFBmTTVMkUYlA5J6HMkmyHI+8lZQ322Hqbkl+rw0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4tksTnL2jJLQLOkEs2VJ1qH6V3MS9FQH9wJJ5L8LZbw=;
 b=cuyysQ+xLtF5fPG46JdUS/M5qvqzyYiqyktWiDwCGQXDwKJIBejQMyIuoVW9pETOVrDz9y6td+TUvbefZZrarfOsNh4S+ILBDMWgNcvkcFEEL8Yxdrd1b487TRSqeJG5xERzCQBE9/4ca9mM4x1vYdKfi+oqPAvIxtwrBEWUv6Y=
Received: from CH2PR12MB4152.namprd12.prod.outlook.com (2603:10b6:610:a7::8)
 by CH2PR12MB4246.namprd12.prod.outlook.com (2603:10b6:610:a9::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5546.21; Tue, 23 Aug
 2022 01:54:57 +0000
Received: from CH2PR12MB4152.namprd12.prod.outlook.com
 ([fe80::c9df:9f8:142f:6d92]) by CH2PR12MB4152.namprd12.prod.outlook.com
 ([fe80::c9df:9f8:142f:6d92%5]) with mapi id 15.20.5546.023; Tue, 23 Aug 2022
 01:54:57 +0000
From: "Xu, Feifei" <Feifei.Xu@amd.com>
To: "Quan, Evan" <Evan.Quan@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amd/pm: update SMU 13.0.0 driver_if header
Thread-Topic: [PATCH] drm/amd/pm: update SMU 13.0.0 driver_if header
Thread-Index: AQHYto715julv1JB7kSYh1PaZH0PqK27uYbg
Date: Tue, 23 Aug 2022 01:54:57 +0000
Message-ID: <CH2PR12MB4152D972A9D35B9A9B67EE46FE709@CH2PR12MB4152.namprd12.prod.outlook.com>
References: <20220823012231.1923038-1-evan.quan@amd.com>
In-Reply-To: <20220823012231.1923038-1-evan.quan@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2022-08-23T01:54:46Z; 
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=4edb511d-fa3f-4de1-9cdf-f6e438c4151d;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=1
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_enabled: true
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_setdate: 2022-08-23T01:54:53Z
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_method: Standard
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_name: General
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_actionid: f8c81e02-f1a0-4979-89f9-fd1ba909c88d
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ef1eea76-661a-432f-9c1c-08da84aa7b6b
x-ms-traffictypediagnostic: CH2PR12MB4246:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 5rsXDv0L1+MrrEYaGVuP2U0FOkmPgW4nXyXBr+reIwQMWQAHp5hs5zSB9c0BmcLZ42fnDcH4jCIyAhwxXlgyb/dR+L2WcCBujvOpfTM61htMftH+8hSOzsGyJoMBna1/E/xKAAnMLBB8o8PYRwWqcmo8G19soJx6Qx4qaZa/z5ywCcHrF/779oGBm3VCrJ8Lj3vpKWn8GMnbCp6IO3b4j+/Tw38rnit1P8MjrUzrF89oBijZqN+iYYA8gKSyKcLzVRbZ7At0gXm4ZxpDmiYOqQ8b9Kans58UiiZ1SO3csjfCmjo9cbS+Tbi34MvvIdV3Lb/v9txdpOiH/bXN+5ZK+d8LoC+9kg8bHxsYNOq2RHBdPgYfrKEsIAhoZXH82QJL16lfH0eX5PggAbi4xVDn7NUtERgZg8vR7T7UMyYDKxBgwD4n+8pHxAW8cGu+WMoXi9KjfiCqlNyi7ftU2Sny8vCe0451rW63SkWry31kZDOHLohWX2/tJbbr4TOhVSWxC9gO+GGCTuueJQZ/38fEIaELR19gDD9cXQ9iKMOLE2M+CZ5elQMlavnS7z8Q6s0R6j5gxjbQnLNjFLfsTC7amq1YhjZAXzQvMUJ1TwLVgQCcSY6TLkiUenSzuPdkwSeaPbzbSmWd+Rb5vx114zq/bc78RN44Jt+UunvBBDCzyz5r6QEU7zhTOM60XerldkfHN0CAbSZvURNRlQLah84tBF/Ch2VYjmSTc0lnL5q7jb2CSGybsDTJW5fvb1C2IL9pxjFsy8XU73tIAXrNHj9iKg==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR12MB4152.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230016)(4636009)(39860400002)(366004)(346002)(396003)(136003)(376002)(53546011)(9686003)(83380400001)(6506007)(26005)(2906002)(186003)(33656002)(7696005)(38070700005)(86362001)(55016003)(38100700002)(64756008)(122000001)(66476007)(66556008)(66946007)(76116006)(41300700001)(5660300002)(316002)(8676002)(54906003)(66446008)(478600001)(110136005)(52536014)(19627235002)(71200400001)(4326008)(15650500001)(8936002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?i/QhxfScINjiCqO70Y/NVth8dAV6QML43E0i5aX/1yUYeXacLLifBHUmwO2U?=
 =?us-ascii?Q?U1UZOfb42u8oOh0/HklqthXlWYgZDU+oDA0MrpwBMymDiQ2Wlma2oGDOsutF?=
 =?us-ascii?Q?sTaeytFhbnM/3c45xz6EEK6az9wgXJfMm1z0FNuWwzlvLd91rJIvHKwVafd6?=
 =?us-ascii?Q?z2AuoNrmYjaheONDEBuH9Jst393IPpWROxRmC2f6DXxko0dNXAS3YpZATrnj?=
 =?us-ascii?Q?FwWIAWgWc62WMoeSujRTvOrK8+vGuMt4U4BYa+9UYJtdinCcL0aTVKm+1alR?=
 =?us-ascii?Q?L/mFckrF83MmEoxAqhEKggX7QY7zkzxqJk+cUe0c9oi1ka0SzGr4/OpOaVH6?=
 =?us-ascii?Q?RqWKWYfnAS1O3abnUS1B0g2i4dk09gDaU+hDq2k8Q4q1utaeToSS0InVrP+7?=
 =?us-ascii?Q?GPkaTK1Gp1LMrJtKCtNeLCM5xUNSgoM8FZZwI3C7n8uwlWTQR86n5ffBcAA4?=
 =?us-ascii?Q?dgR+fvkRhuiDUdqOi3XrvaWq7CNGEZl4zVeK5Eo2UERk4b5uYsxG4wMhctVF?=
 =?us-ascii?Q?5eIByC+/tsWTGJSsg4lMeSD2vsDE6w5T//7OUWQBJazTuDnGYAHIFFh4bNl4?=
 =?us-ascii?Q?pWWFYAzhLviVXlBa+TWGUnnfKF56W2uZaBwRFxtJIlR9m2VeEXmFVIJENO7d?=
 =?us-ascii?Q?vWtnwWFz0qOL/beA2I36IvBWdUGt1LJaGprjxl+qw59QxFYwePGmrmJ1rtFx?=
 =?us-ascii?Q?RFCjUg4Cp+gRxvqAxNvqkre8RkNWG+Y0vAzGgyF7hpucc8sfddXR0Hbqm9Nl?=
 =?us-ascii?Q?t8W1G8UUVqmocrRnIifI+f0isPB6m0ip0faNoEGep+NbzfVafbAw5jfnuE5g?=
 =?us-ascii?Q?pAC7cRMAtyLvLZ3haeudysPTicvsTaab+/1D8mhe3iC2RVpAMUOOeYHHwMnl?=
 =?us-ascii?Q?xFh/VjaoLR4Ozn5AuZCdMKppbWatgUo/3apQ4IqXKgEj2NDf2RC5WxSKa7vb?=
 =?us-ascii?Q?p5+HD5HTziow0QSc7Kwn6sU61NtoFwVJ51Ul9V3ABDmXpGuC3sN2ZbDlX3Dd?=
 =?us-ascii?Q?o5D4EpIGmkfk/JcChJo7hNV4xLJpmZnpUZmInBQJ5P2ALPZ71azRCNXUlLAf?=
 =?us-ascii?Q?YFJo8148MpqkrMpBQlgoRAS5AaO6nUFnYtvLa7NSNGVsrSKJo0io2t7AZd2q?=
 =?us-ascii?Q?cH0OgVtyauFubpAMU+5d9G/sUm+Hl7D4dUmuaivZHwprj6hk1hgTbjY+S1tg?=
 =?us-ascii?Q?ksIHrmtKZdD1Hu4KLo+1qp24PiLvsLyGtUTSH156mUYyq/PMLK7QvzomH/uy?=
 =?us-ascii?Q?fsARs4GimR0Tv/U7abHXbdEQO9EA89p40B1ic2EtrOiwOcMHAVp0rj8k1Rzt?=
 =?us-ascii?Q?gahZb3mMgrFThnrG0KpG8GSOFktzJFT8LhBBwf1f1oKvrrCtln9Zp3NIiui9?=
 =?us-ascii?Q?Z+8mkdJyCWEzEK9YoOR6oU3ZQAcXFagATUOjIo9O7MVomuFEDJdmNT14M6wx?=
 =?us-ascii?Q?ehouJSHZLA4gEAmzrbrxBcWrdV8yG2dfNGdtFn6KAszW5dtYcn2xbA6f8/Wb?=
 =?us-ascii?Q?nDnfMcAl2uctSESLKV9OmP/aqNDUujneLLHhrFXtub2bnnu9ZAWBxEmtWw0o?=
 =?us-ascii?Q?7OEX7ewlOFgTy7dePEg=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB4152.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ef1eea76-661a-432f-9c1c-08da84aa7b6b
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Aug 2022 01:54:57.5678 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yKXc7z9hJ+QC60G1yQq5//UWRnLZ7J4IHKVLOdkD5KSQiNfG4+9mK+qA0MMfMWNX
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4246
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Quan,
 Evan" <Evan.Quan@amd.com>, "Zhang, Hawking" <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - General]



Reviewed-by: Feifei Xu <Feifei.Xu@amd.com>



-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Evan Qua=
n
Sent: Tuesday, August 23, 2022 9:23 AM
To: amd-gfx@lists.freedesktop.org
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Quan, Evan <Evan.Quan@a=
md.com>; Zhang, Hawking <Hawking.Zhang@amd.com>
Subject: [PATCH] drm/amd/pm: update SMU 13.0.0 driver_if header

To fit the latest 78.53 PMFW.

Signed-off-by: Evan Quan <evan.quan@amd.com>
Change-Id: I16b36a3c209c82fc2d48325f7e6ef5a702678782
---
 .../inc/pmfw_if/smu13_driver_if_v13_0_0.h     | 31 +++++++++++--------
 drivers/gpu/drm/amd/pm/swsmu/inc/smu_v13_0.h  |  2 +-
 2 files changed, 19 insertions(+), 14 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu13_driver_if_v13_0=
_0.h b/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu13_driver_if_v13_0_0.h
index 78620b0bd279..f745cd8f1ab7 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu13_driver_if_v13_0_0.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu13_driver_if_v13_0_0.h
@@ -24,12 +24,8 @@
 #ifndef SMU13_DRIVER_IF_V13_0_0_H
 #define SMU13_DRIVER_IF_V13_0_0_H
=20
-// *** IMPORTANT ***
-// PMFW TEAM: Always increment the interface version on any change to this=
 file -#define SMU13_DRIVER_IF_VERSION  0x23
-
 //Increment this version if SkuTable_t or BoardTable_t change -#define PPT=
ABLE_VERSION 0x1D
+#define PPTABLE_VERSION 0x22
=20
 #define NUM_GFXCLK_DPM_LEVELS    16
 #define NUM_SOCCLK_DPM_LEVELS    8
@@ -1193,8 +1189,17 @@ typedef struct {
   // SECTION: Advanced Options
   uint32_t          DebugOverrides;
=20
+  // Section: Total Board Power idle vs active coefficients
+  uint8_t     TotalBoardPowerSupport;
+  uint8_t     TotalBoardPowerPadding[3];
+
+  int16_t     TotalIdleBoardPowerM;
+  int16_t     TotalIdleBoardPowerB;
+  int16_t     TotalBoardPowerM;
+  int16_t     TotalBoardPowerB;
+
   // SECTION: Sku Reserved
-  uint32_t         Spare[64];
+  uint32_t         Spare[61];
=20
   // Padding for MMHUB - do not modify this
   uint32_t     MmHubPadding[8];
@@ -1259,7 +1264,8 @@ typedef struct {
   // SECTION: Clock Spread Spectrum
=20
   // UCLK Spread Spectrum
-  uint16_t     UclkSpreadPadding;
+  uint8_t      UclkTrainingModeSpreadPercent;
+  uint8_t      UclkSpreadPadding;
   uint16_t     UclkSpreadFreq;      // kHz
=20
   // UCLK Spread Spectrum
@@ -1272,11 +1278,7 @@ typedef struct {
=20
   // Section: Memory Config
   uint8_t      DramWidth; // Width of interface to the channel for each DR=
AM module. See DRAM_BIT_WIDTH_TYPE_e
-  uint8_t      PaddingMem1[3];
-
-  // Section: Total Board Power
-  uint16_t     TotalBoardPower;     //Only needed for TCP Estimated case, =
where TCP =3D TGP+Total Board Power
-  uint16_t     BoardPowerPadding;
+  uint8_t      PaddingMem1[7];
=20
   // SECTION: UMC feature flags
   uint8_t      HsrEnabled;
@@ -1375,8 +1377,11 @@ typedef struct {
   uint16_t Vcn1ActivityPercentage  ;
=20
   uint32_t EnergyAccumulator;
-  uint16_t AverageSocketPower    ;
+  uint16_t AverageSocketPower;
+  uint16_t AverageTotalBoardPower;
+
   uint16_t AvgTemperature[TEMP_COUNT];
+  uint16_t TempPadding;
=20
   uint8_t  PcieRate               ;
   uint8_t  PcieWidth              ;
diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v13_0.h b/drivers/gpu/drm=
/amd/pm/swsmu/inc/smu_v13_0.h
index 6fe2fe92ebd7..ac308e72241a 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v13_0.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v13_0.h
@@ -30,7 +30,7 @@
 #define SMU13_DRIVER_IF_VERSION_ALDE 0x08  #define SMU13_DRIVER_IF_VERSION=
_SMU_V13_0_4 0x05  #define SMU13_DRIVER_IF_VERSION_SMU_V13_0_5 0x04 -#defin=
e SMU13_DRIVER_IF_VERSION_SMU_V13_0_0 0x2C
+#define SMU13_DRIVER_IF_VERSION_SMU_V13_0_0 0x2E
 #define SMU13_DRIVER_IF_VERSION_SMU_V13_0_7 0x2C
=20
 #define SMU13_MODE1_RESET_WAIT_TIME_IN_MS 500  //500ms
--
2.29.0
