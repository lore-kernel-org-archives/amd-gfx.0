Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E549FC7EE24
	for <amd-gfx@archiver.kernel.org>; Mon,  5 Jun 2023 03:57:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ED1DF10E10A;
	Mon,  5 Jun 2023 03:57:31 +0000 (UTC)
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam02on2071.outbound.protection.outlook.com [40.107.212.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 043C810E10A
 for <amd-gfx@lists.freedesktop.org>; Mon,  5 Jun 2023 03:57:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JKV6UW3JKcMCpVX3AHA0ESCf3D8znoXK5TfSDQN6bGO9nP9BySIlF/JDsr02vH0ZtLwxfhBDDJygJipWnTO2QmjcYZzbMhyfS+xyzvLhv94NcXu/vkbV2mt53wV9PES807+mT5mBYwB/PeM1/MEtbGalb2xTCQYu4bbN6CcXgf38gPAcVsG9Q7g5oi5qLfaT6UWRD4U4XkexGZXl7EyxvC0vs5SinXv5O/a5SbHWEniUBmE7wnQEtVcNh+DHt6l5mOmDk/xkRQzojjFAbFTTbo9k4xoX1kqYuR2YQkbrsoAR0H4/9D54bl5hHwNAhKOXlfdYOrputSLHc314C4QWew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Hxiq+TbkKrL5Wxm1IzPy6bLtOO56doGKBfiYmQN8/pQ=;
 b=INQuZx+uJb9EICywfOPfPawv94A5TDQj6Bx/sbSwq9mtpjKl4T8grJBJK6DUV5CzKFyZvKQYOKESlkzL3DTqiYC+XJV4FNUwS3eLTNkDrwdT2YiSVUSTSt2Jm4a4+5AzE3YK67EU12xumTx95M81h6XJ16009MZ6YSjiF8ht6Hinzipiy0r2tJ2Im0Qu5whgBUIIuAzNHE64hiG9upTKdKvmT5rn7Kmvt0XzHOR/94sthOV8GTuvOxWdqUoJZzYMm+SLlJBuy2MdEMuZ+3ZUdtY54nn05+WI3VlMyABPy+PkNlkTz3ZNkc2U/2sHmrxBHguGczz/AXCXFmGRpODK4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Hxiq+TbkKrL5Wxm1IzPy6bLtOO56doGKBfiYmQN8/pQ=;
 b=481QaHQG6GyAGyrmldiDDubac7oJ8kwB/X1Xcn4ZJEU/GXwBZvamhVczWXE75NQLyNKMzdAXPyTE/SxHzSFXjNyulb3npXV4oKe9dxFddz81qq6kQFBiLms6YzyriLupVUszZaBNIJyyfoju2/kGp2kcWslngm+7NG5e217y+As=
Received: from BN9PR12MB5257.namprd12.prod.outlook.com (2603:10b6:408:11e::16)
 by IA0PR12MB7556.namprd12.prod.outlook.com (2603:10b6:208:43c::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.32; Mon, 5 Jun
 2023 03:57:25 +0000
Received: from BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::5241:c0fb:9743:1a27]) by BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::5241:c0fb:9743:1a27%4]) with mapi id 15.20.6455.030; Mon, 5 Jun 2023
 03:57:25 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Feng, Kenneth" <Kenneth.Feng@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amd/pm: update smu-driver if header for smu 13.0.0
 and smu 13.0.10
Thread-Topic: [PATCH] drm/amd/pm: update smu-driver if header for smu 13.0.0
 and smu 13.0.10
Thread-Index: AQHZl1x6TYWv3A3TtkGEQhSaYFhd9q97lNrg
Date: Mon, 5 Jun 2023 03:57:25 +0000
Message-ID: <BN9PR12MB5257C0FA23FB19E1996F6D3BFC4DA@BN9PR12MB5257.namprd12.prod.outlook.com>
References: <20230605031842.3441796-1-kenneth.feng@amd.com>
In-Reply-To: <20230605031842.3441796-1-kenneth.feng@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=bd92f68c-7373-4e60-a8e4-c9604474afe6;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2023-06-05T03:57:03Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR12MB5257:EE_|IA0PR12MB7556:EE_
x-ms-office365-filtering-correlation-id: a25ad95d-117c-49e5-f4ac-08db6578f900
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ValJzGz7eL36etTuuIdeQ0NC3pXMxAcYCkrP4voIQx8WMB1G3USHmxEs4aA+rJ1F7RvaXo2vQFuCJTHKJ9UEWbBOF8MoJ6HSyusy1ZE2qdZExecDHJ8D0TZIxn8tnAOAWXsI4NM+OR9+6/KKu+Usa2h39scgAZaSbEwTlSYG9cf0kjg581ZkpChWLJmPJut8VgOT6ItjxOoPZ6DWhgRWlPAmbTF4f0zvkFDqJpGxC1WOXYdYkdaOGnD7mzPD1HQ9+wbg523fqGbeSEW1n89bG2JYg2tqqrS0FbXekRzvsxzL3ahZGr+A9D0Md1fZdCbacX6R3Sumo6HckxQ4vOFllZslwY29ml7ONrqRCzP0Ts8gmkkAiyT6EUya5oW/4HMKzl2E5ruMvbyHqrtn0WdZ8Uo0mBvvy49tPb/8n21MaSNyu+8+YCFZNp/n7LTE0keXXBQQE4tHvF/cclRCi0wKg3fU/B7g1Gp4ovYGl4LEeVQzfB4z0faqRyig/wtNr0aDa9BPETtD5uLFhrm1ymE1MLacsJDG3UXkTgvKm+Sz0RSeS2+ravdftHCZClZJ1/oGPmL16ne3KsAroVFM/Sv6cXvaJdEE372e2CZ65WZGCFsHVYj5Bu9Xvg2xi4Tw9lR/
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5257.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(396003)(136003)(376002)(39860400002)(366004)(346002)(451199021)(2906002)(38070700005)(86362001)(33656002)(15650500001)(5660300002)(52536014)(55016003)(83380400001)(71200400001)(7696005)(186003)(26005)(9686003)(6506007)(53546011)(478600001)(110136005)(76116006)(66946007)(66556008)(66476007)(64756008)(122000001)(316002)(38100700002)(66446008)(4326008)(41300700001)(8936002)(8676002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?75D92bKUMVc7p3YHzcjWtahmH7DFa+GGJ3EBnlDEjQ/RO+IJUX2jZsUcFk/I?=
 =?us-ascii?Q?LDd/PFfAQZ5PHjs2wWh49kliZHbXX2NRyUQ4BZ6Xo2HMpKtGmkjR8sjV/Zei?=
 =?us-ascii?Q?eR9NYgY9Vu9IhfTawzLLTZoLIGcHBZkjGSj0Jrv2JJDlzmphAxsVlYfLbli5?=
 =?us-ascii?Q?pU4dyyx6Kve0+WgaF0rMPXY8fXQUPrF03sxCw9P5lM9f8F4gvtrquBV/wY5F?=
 =?us-ascii?Q?shen/mzvLdIZDuCXKQk3s334D8z48RJ80uBMXWFN0TU7CPTAteHWtzdUT7pZ?=
 =?us-ascii?Q?FjhO1isp205UWSq5Ic4fxaCE3/XuMk1ZoYi8KH3MvODmBLWSxrBRhZ39C+oY?=
 =?us-ascii?Q?l4cQctXdaUgXyzP5DcX2mnOd+l0/8pqdfrmLFWu3qJ8FG40rUapyeMM3ir2L?=
 =?us-ascii?Q?q6rWAb6CM9nRY+p+jZE4HiU0uecEQQikU/v/cwoJcDNzceJr5GsZKZVNUTB5?=
 =?us-ascii?Q?hut1We4NVtVWF4Sr1e+ltJVOyA9BFZwJfAVrqGVtDxS/hZ0nHDRQiHMcYEbC?=
 =?us-ascii?Q?DLIERUgl5VIoFRbKNXRUIsK4ZTkO42JGgZ+yf9ceI3UplLGi6K5N1c6KeIvw?=
 =?us-ascii?Q?kG6nvonUhrvX1SzWTIlmTfqN8UKZgxzxugHIO5DokaNn761apiNnj8Qza8zU?=
 =?us-ascii?Q?SBbRXdm+nBMm6ksMQz7BDH5PX2VbdPY+WG6fptBHeiocoRXwNbwjy+adzYjX?=
 =?us-ascii?Q?tMeiPzbE/r8MNp+9QcQyYVWmv6aagE8ej3Bws2luPDxtytu/NJoVlqynt17r?=
 =?us-ascii?Q?f1IwVUdhvhDY2dFDaAY4FMjMQPHDD5jI49x5SQKlrG2jd+F0MCnQWeP0Bwt4?=
 =?us-ascii?Q?Or+n4bpfnaB6I+hRZheoqaGxuRNCD7uwZNZqa8nEu4oeWio75UvROKEuU7cJ?=
 =?us-ascii?Q?2kAZTrhcYxrGoqUqgAdi0qMAfhDsVRlSuNlKVSmiL1+AzJqgDN4Gln2nnCb5?=
 =?us-ascii?Q?EbyvAAdGjuA2ltq+7dk49qUKJSqVPQVNIohZ8rzrlCiX3RbKwpzut4FaP/Ea?=
 =?us-ascii?Q?VYo3nWqZp18m61nkbXZysEZpZRXU1RZCSfexu0QdghS5lp8IrhB/vAiN59Si?=
 =?us-ascii?Q?ZsgrK9pR1rz251ZVaw3vqiEpmpJeBun45RDq387vu7r1uJ/Z66v+TObWUPzT?=
 =?us-ascii?Q?NaJv38wMQuyVTSu8arC6WHzZpbWb5PHmVY0DQbefILziVjUbKf+spDY/cv3x?=
 =?us-ascii?Q?Sv6EpFlChqaVSAhPVs81ZcLMl9XVLFUBepB85e/Og9Z3seScdh6LvLmIbQwm?=
 =?us-ascii?Q?RQYEmpiAw5itMkbO9EB45C5uuBI6nOMr3K0pgheNFy8Pq5Oyit3zoJBNfZ2s?=
 =?us-ascii?Q?LoOTsfDYME5YTaDw3JsS7JyHruqaR51TTkL2UZDYkc6DMO44IzeGP6SxBmek?=
 =?us-ascii?Q?jVCAXiZKCe/lQj7/3bSvTezi9nrHp2zahh6fbmL+/7fbMIBaXtedc6aa5v2/?=
 =?us-ascii?Q?wnk5FLIQcp9AOJ4u34meE6khK0/QX25kvoIGYYQYFJzVU1EpC4JzBuJ1YAPA?=
 =?us-ascii?Q?IP4LaT978xQajAFwNKfJaMSKl3EMaRPJ81QcMvvnPSxJMLjqIWOm8i8gShbh?=
 =?us-ascii?Q?ZOOq+EFy0te+jp/3aQA=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5257.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a25ad95d-117c-49e5-f4ac-08db6578f900
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Jun 2023 03:57:25.0888 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: LsroOkF7A+IXTk1wgip2Gk5FfuDwoqFWTp8FmCTsRI70qzLiYX1Nw3kxC6Yssf6vJCpq/TQeyfezaO1HzfwxEA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7556
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
Cc: "Feng, Kenneth" <Kenneth.Feng@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - General]

Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>

Regards,
Hawking
-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Kenneth =
Feng
Sent: Monday, June 5, 2023 11:19
To: amd-gfx@lists.freedesktop.org
Cc: Feng, Kenneth <Kenneth.Feng@amd.com>
Subject: [PATCH] drm/amd/pm: update smu-driver if header for smu 13.0.0 and=
 smu 13.0.10

update smu-driver if header for smu 13.0.0 and smu 13.0.10

Signed-off-by: Kenneth Feng <kenneth.feng@amd.com>
Change-Id: I540aaa99fac2216f2d1a28fd79c68dd77a495f8b
---
 .../inc/pmfw_if/smu13_driver_if_v13_0_0.h     | 33 ++++++++++++++-----
 1 file changed, 25 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu13_driver_if_v13_0=
_0.h b/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu13_driver_if_v13_0_0.h
index fe995651c6f5..ba56bc676310 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu13_driver_if_v13_0_0.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu13_driver_if_v13_0_0.h
@@ -24,10 +24,10 @@
 #ifndef SMU13_DRIVER_IF_V13_0_0_H
 #define SMU13_DRIVER_IF_V13_0_0_H

-#define SMU13_0_0_DRIVER_IF_VERSION 0x32
+#define SMU13_0_0_DRIVER_IF_VERSION 0x3D

 //Increment this version if SkuTable_t or BoardTable_t change -#define PPT=
ABLE_VERSION 0x26
+#define PPTABLE_VERSION 0x2B

 #define NUM_GFXCLK_DPM_LEVELS    16
 #define NUM_SOCCLK_DPM_LEVELS    8
@@ -96,7 +96,7 @@
 #define FEATURE_ATHUB_MMHUB_PG_BIT            48
 #define FEATURE_SOC_PCC_BIT                   49
 #define FEATURE_EDC_PWRBRK_BIT                50
-#define FEATURE_SPARE_51_BIT                  51
+#define FEATURE_BOMXCO_SVI3_PROG_BIT          51
 #define FEATURE_SPARE_52_BIT                  52
 #define FEATURE_SPARE_53_BIT                  53
 #define FEATURE_SPARE_54_BIT                  54
@@ -312,6 +312,7 @@ typedef enum {
        I2C_CONTROLLER_PROTOCOL_VR_IR35217,
        I2C_CONTROLLER_PROTOCOL_TMP_MAX31875,
        I2C_CONTROLLER_PROTOCOL_INA3221,
+       I2C_CONTROLLER_PROTOCOL_TMP_MAX6604,
        I2C_CONTROLLER_PROTOCOL_COUNT,
 } I2cControllerProtocol_e;

@@ -570,6 +571,7 @@ typedef enum {
 } POWER_SOURCE_e;

 typedef enum {
+  MEM_VENDOR_PLACEHOLDER0,
   MEM_VENDOR_SAMSUNG,
   MEM_VENDOR_INFINEON,
   MEM_VENDOR_ELPIDA,
@@ -579,7 +581,6 @@ typedef enum {
   MEM_VENDOR_MOSEL,
   MEM_VENDOR_WINBOND,
   MEM_VENDOR_ESMT,
-  MEM_VENDOR_PLACEHOLDER0,
   MEM_VENDOR_PLACEHOLDER1,
   MEM_VENDOR_PLACEHOLDER2,
   MEM_VENDOR_PLACEHOLDER3,
@@ -808,6 +809,9 @@ typedef enum {

 #define INVALID_BOARD_GPIO 0xFF

+#define MARKETING_BASE_CLOCKS         0
+#define MARKETING_GAME_CLOCKS         1
+#define MARKETING_BOOST_CLOCKS        2

 typedef struct {
   //PLL 0
@@ -1098,10 +1102,15 @@ typedef struct {
   uint16_t        DcsExitHysteresis;    //The min amount of time power cre=
dit accumulator should have a value > 0 before SMU exits the DCS throttling=
 phase.
   uint16_t        DcsTimeout;           //This is the amount of time SMU F=
W waits for RLC to put GFX into GFXOFF before reverting to the fallback mec=
hanism of throttling GFXCLK to Fmin.

+  uint8_t         FoptEnabled;
+  uint8_t         DcsSpare2[3];
+  uint32_t        DcsFoptM;             //Tuning paramters to shift Fopt c=
alculation, used in T19 and Navi32
+  uint32_t        DcsFoptB;             //Tuning paramters to shift Fopt c=
alculation, used in T19 and Navi32

-  uint32_t        DcsSpare[16];
+  uint32_t        DcsSpare[11];

   // UCLK section
+  uint16_t     ShadowFreqTableUclk     [NUM_UCLK_DPM_LEVELS];     // In MH=
z
   uint8_t      UseStrobeModeOptimizations; //Set to indicate that FW shoul=
d use strobe mode optimizations
   uint8_t      PaddingMem[3];

@@ -1247,8 +1256,13 @@ typedef struct {
   QuadraticInt_t qFeffCoeffBaseClock[POWER_SOURCE_COUNT];
   QuadraticInt_t qFeffCoeffBoostClock[POWER_SOURCE_COUNT];

+  uint16_t TemperatureLimit_Hynix; // In degrees Celsius. Memory
+ temperature limit associated with Hynix  uint16_t
+ TemperatureLimit_Micron; // In degrees Celsius. Memory temperature
+ limit associated with Micron  uint16_t TemperatureFwCtfLimit_Hynix;
+ uint16_t TemperatureFwCtfLimit_Micron;
+
   // SECTION: Sku Reserved
-  uint32_t         Spare[43];
+  uint32_t         Spare[41];

   // Padding for MMHUB - do not modify this
   uint32_t     MmHubPadding[8];
@@ -1320,8 +1334,9 @@ typedef struct {
   // UCLK Spread Spectrum
   uint8_t      UclkSpreadPercent[MEM_VENDOR_COUNT];

+  uint8_t      GfxclkSpreadEnable;
+
   // FCLK Spread Spectrum
-  uint8_t      FclkSpreadPadding;
   uint8_t      FclkSpreadPercent;   // Q4.4
   uint16_t     FclkSpreadFreq;      // kHz

@@ -1446,6 +1461,8 @@ typedef struct {


   uint8_t ThrottlingPercentage[THROTTLER_COUNT];
+  uint8_t VmaxThrottlingPercentage;
+  uint8_t Padding1[3];

   //metrics for D3hot entry/exit and driver ARM msgs
   uint32_t D3HotEntryCountPerMode[D3HOT_SEQUENCE_COUNT];
@@ -1465,7 +1482,7 @@ typedef struct {

 typedef struct {
   SmuMetrics_t SmuMetrics;
-  uint32_t Spare[30];
+  uint32_t Spare[29];

   // Padding - ignore
   uint32_t     MmHubPadding[8]; // SMU internal use
--
2.34.1

