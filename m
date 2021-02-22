Return-Path: <SRS0=DoF4=HY=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83E59C433E0
	for <amd-gfx@archiver.kernel.org>; Mon, 22 Feb 2021 08:15:49 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D9B0664DA5
	for <amd-gfx@archiver.kernel.org>; Mon, 22 Feb 2021 08:15:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D9B0664DA5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 618C26E90B;
	Mon, 22 Feb 2021 08:15:48 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2056.outbound.protection.outlook.com [40.107.236.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E67CC6E90B
 for <amd-gfx@lists.freedesktop.org>; Mon, 22 Feb 2021 08:15:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lOKRslnrmoq8wMWELVT5Pq9AzIINbt5J7/hS14zMfEGMe9hcgwwVkEzQYjw9wricMYuA2a45vghMCiD16QGrBm2bh06P3CC2tTuPUnjuxk2BE3Gy9cCHs9QL13LHbLBp+2KyuiXooyPZlJocob/OtwHmgmb3/j7lHEYEN2eCBTJJEMej9BCgOLStDiPzmGYE5Qd+tJVrIfYXe/iJgqOsP4Yg1s2NJEmB53AoNeV8LnprjMtTHyhXAH4ljGLa3eA2t8CceHKRf0DYfV8pw4bIOFjqp60y3mHTNHDjydh5TcsCRXwgooxd7Q+zr3oSMbvuGedDzTXvwrXRnyonry+KJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RcZxArS3tY4A9oHKzZhlhLf3yGMsZ58ZmGAYcjb743w=;
 b=ZkGt6izg+IvxkjpdosrvqiBLU93NXvbCKDBI9kcUfJr/6Bpuch8Qd2gWuKCjwp25N5w/sSYqn09rFPtPzwdcdeWWbQpwHAaYkEOZ6z+qbdjwQ72v4YWynK3zzceriBCP+8jdkQc3NR735UOulavbTPnHHotnvWftrc2TLw14TOTwpkpTK25lcbz6RWqFDFJQiHiPVKMX0P8PRb8K8VwzOVZzvrEvRY1g0/6zMe36YTh1fAHJziHvVQKj11LPWVkqLokN9cDvNDXV/szNRrJCWi2Mq6OG33GKzafo89/77xWc5staMfDblNI+Qcp9/7ND1vgEDoMZynRHleysztNu7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RcZxArS3tY4A9oHKzZhlhLf3yGMsZ58ZmGAYcjb743w=;
 b=eTc1cEM8nGSQWx8STu7DRMUJajezmoa1Y7+GRbwpLBQkMUliESbkVf0UzHFVDcVfWHJfte93wf+dWY4PcODrHrSX8Ud9c7gfUd5lYMVy1cGXbqYrDKZKroXweGW4E8ozJs2/l1SOpv8tklvrfXTqyNbOH+b1pEt8DWwU5wvvjkk=
Received: from CY4PR12MB1287.namprd12.prod.outlook.com (2603:10b6:903:40::8)
 by CY4PR1201MB0037.namprd12.prod.outlook.com (2603:10b6:910:1c::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3868.32; Mon, 22 Feb
 2021 08:15:44 +0000
Received: from CY4PR12MB1287.namprd12.prod.outlook.com
 ([fe80::992b:4e6b:afe3:ff25]) by CY4PR12MB1287.namprd12.prod.outlook.com
 ([fe80::992b:4e6b:afe3:ff25%2]) with mapi id 15.20.3868.032; Mon, 22 Feb 2021
 08:15:44 +0000
From: "Chen, Guchun" <Guchun.Chen@amd.com>
To: "Quan, Evan" <Evan.Quan@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amd/pm: bump Navi1x driver if version and related
 data structures
Thread-Topic: [PATCH] drm/amd/pm: bump Navi1x driver if version and related
 data structures
Thread-Index: AQHXCM7GpiaToKEdQ0uD8cgCv/leXqpj0WFQ
Date: Mon, 22 Feb 2021 08:15:44 +0000
Message-ID: <CY4PR12MB1287D818E9E118CBFF360CEDF1819@CY4PR12MB1287.namprd12.prod.outlook.com>
References: <20210222035625.1280702-1-evan.quan@amd.com>
In-Reply-To: <20210222035625.1280702-1-evan.quan@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Enabled=true;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SetDate=2021-02-22T08:15:42Z; 
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Method=Privileged;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Name=Public_0;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ActionId=1bc3bcfb-54e9-4dc0-9b3d-ec6c73f44c4b;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ContentBits=1
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [180.167.199.189]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 4c1e7692-9222-4c49-963a-08d8d70a0d12
x-ms-traffictypediagnostic: CY4PR1201MB0037:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CY4PR1201MB0037CE9CA7C225D86C75B740F1819@CY4PR1201MB0037.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3044;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: QHd90iyCa3yD6BRBGYd23zjpD1mhcZF5EQrj03ip2m+TcLBvqInL6Z3Ed1GlmPE+WAyWXeyOww55SUfJ3oPQtLRpoQEULJkCWbDtPE4q6X7uYnAUuGUynLpYNGtOMPt0Oo8jiljZyiVskPMjJ4IuY9TaaRDAfGYk/tP8kQiTIRPm17SYQgFQY7HZKKqF9lVaqoFHa45KjH9GNguScPD/HE67t5ZMTHa3CyApVSWGXG7dvaZSoDWNYF3KQ/UTtZk/EW3Sh2AIu38sDoAj2KCGz/r78yVCmSYjTcNc1ldC+2cEBg6kGupIbOoMlz+GQL42Q1NWCB+7EsBaDYkV3Tv0LK+o6g2UKUwlin19ORW1l11kFHHFRvtMd0E5PNRVNk/UORDmILa4EwTVds/tky0wt/N+KyYkjzq2/v0g/qIc/6HuC4PWaQCz7Ru10xDCobZsBgFmmGxg7mgnCbEbOqPAa3CXWM3DZ37TTCN9+fWPxCETXRDWtqR5P/wrSDvnl8Ks942ULzmtcT9yYgfHy6g2rCOL0T84ZDYphCg4OOe0Y35xddYoBKy/H0UIUrq4NzZGdGAY/64xhmrzMxl/U5MWiYAWhzTZoTFWISM1VDVT578=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY4PR12MB1287.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(396003)(346002)(136003)(39860400002)(366004)(186003)(52536014)(71200400001)(2906002)(54906003)(7696005)(33656002)(110136005)(478600001)(316002)(76116006)(86362001)(66556008)(966005)(64756008)(45080400002)(66446008)(5660300002)(53546011)(66946007)(66476007)(83380400001)(26005)(6506007)(8676002)(55016002)(8936002)(9686003)(4326008)(32563001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?MMTA28sX708d9VodVpT627SyeqtJfAP9MiADldfAUDpjS7cXsQ8VYqJvU1CU?=
 =?us-ascii?Q?4UXweh9CRHvLacY0PpAQF/AxiWsHcVITvx+1e1alNUH4pVeopOuyxvEaLTKT?=
 =?us-ascii?Q?MiC0EDkczHX49RHEpfGQwzIPMS6hZGOxz2wOhMAXiblug7uNe2COfnH8Dj49?=
 =?us-ascii?Q?Vl8rtl+09zznDN5+HtsFK4kt+wXRCldX6Zb/R0iSnMMvLj66+2KkUB21zl2U?=
 =?us-ascii?Q?tP4bN8XWAsjEJbgZVjEbjHzy7opB2BE7+coutXErWCKH2lxs3cam13JZ+8ss?=
 =?us-ascii?Q?MkypCeWedZLy2U3RBpaawXXR4LmKG8P2eW9tlVsPCCtltv+dVYs6RBOpF3+4?=
 =?us-ascii?Q?8fFQG474+M2GfUy8+zqSGsBYTYOKADXtVSAW64RxFVtHwmjKYnyzBgQP1HdC?=
 =?us-ascii?Q?RInQ2EfPfdoV4/cumXeb9Onp2iLObXXxpysTmqECPL0SpEcEngfguvMHjpzF?=
 =?us-ascii?Q?I9H2GCeC7PVQ9HLeA5uYmKk2czhkJW7Ou6eFScnshqYB2GvBhY6+LQF+XMgo?=
 =?us-ascii?Q?4tufnoASSkQi1qKCzmebV8Dd/MUoJQVIehAFPoZArQQCOE7Dh7FR1Wdcbifm?=
 =?us-ascii?Q?woE1mZf2H3sTC7JzrqBVFsXqOkTRSgWoYmxsnN7VlZFo8aJnINSp6v2jQ5tb?=
 =?us-ascii?Q?2e0g+gAffAckDX4xKmzoKSjBgLoOOqpQs/7M7NRR0chTBbizwrHHx7/2I26F?=
 =?us-ascii?Q?sFZIy52hQ04LqK64StL3R0113zOI0DeA+L2eLmUEuQrbaTdVJ2iI/MfePYGY?=
 =?us-ascii?Q?lxpEGkxPXRQnO+CuUxyCsK3hWY3+NCxkbYONbVxbDHh7EE9jEQteGr76MFGn?=
 =?us-ascii?Q?6t847Kdibe+54snV/pzsa65hjRP/jlU8zRQpwsACtvoUTSRtAgrF13V6m5/Y?=
 =?us-ascii?Q?qxAqWOyi6pq5Ki6WzaTk6oLqeKYfaUohZZPOGDN1bjJEAU9LXeGcQamAgD7E?=
 =?us-ascii?Q?C3WGCadnRurctBnTipv9fmsGzn1gmlSHR0SUk813A6XeH+74gyhZ/AYcdLJI?=
 =?us-ascii?Q?4vZ0eK1FvCin1FYd/EZVdyZUH6x0pkP3PbSoJWlvyb1vTeUqi+fhT4HPnBKV?=
 =?us-ascii?Q?gi7fqmawstyRGZ/Vvdor/z9zqVasBGCIaMrRQQhs97pRrjPxRzcO6xzyoCV+?=
 =?us-ascii?Q?HcaALtH+ruVOI73TPuERuBAFfckrfcKHhVy704U/Nmf9YPjVQD0IEWQnx7mP?=
 =?us-ascii?Q?IZtz1YswDSs8Ij8+ly3sxN1c1B7kRiHbygDCAbmQlxiPOkSSeavtyZEK2A7K?=
 =?us-ascii?Q?0weV0YYY2peCl+hBHhGCdJzV4syq1w0Nq92B3EsYtyxFkhlq51kg7aobZs7t?=
 =?us-ascii?Q?evgJByCETQJVBFkXQw8G0SVf?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY4PR12MB1287.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4c1e7692-9222-4c49-963a-08d8d70a0d12
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Feb 2021 08:15:44.0852 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jHGT8OSmXkt3iqENpuRD3E9Ix5Pu4aDX2Pi9FO1abaOCmBscWYCATQhP9Zuu/zdwZd+jWoyZpAOCdgY8zx42qQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR1201MB0037
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
 Evan" <Evan.Quan@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Public Use]

New changes were involved for the SmuMetrics strucutre.

One spelling typo, s/strucutre /structure

With this typo fixed, the patch is:
Acked-by: Guchun Chen <guchun.chen@amd.com>

Regards,
Guchun

-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Evan Quan
Sent: Monday, February 22, 2021 11:56 AM
To: amd-gfx@lists.freedesktop.org
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Quan, Evan <Evan.Quan@amd.com>
Subject: [PATCH] drm/amd/pm: bump Navi1x driver if version and related data structures

New changes were involved for the SmuMetrics strucutre.

Change-Id: Ib45443db03977ccd18618bcfdfd3574ac13d50d1
Signed-off-by: Evan Quan <evan.quan@amd.com>
---
 .../drm/amd/pm/inc/smu11_driver_if_navi10.h   | 31 ++++++++----
 drivers/gpu/drm/amd/pm/inc/smu_v11_0.h        |  6 +--
 .../gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c   | 48 +++++++++++++++++--
 3 files changed, 70 insertions(+), 15 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/inc/smu11_driver_if_navi10.h b/drivers/gpu/drm/amd/pm/inc/smu11_driver_if_navi10.h
index 246d3951a78a..84d12da19c90 100644
--- a/drivers/gpu/drm/amd/pm/inc/smu11_driver_if_navi10.h
+++ b/drivers/gpu/drm/amd/pm/inc/smu11_driver_if_navi10.h
@@ -843,19 +843,23 @@ typedef struct {
   uint16_t      FanMaximumRpm;
   uint16_t      FanMinimumPwm;
   uint16_t      FanTargetTemperature; // Degree Celcius 
+  uint16_t      FanMode;
+  uint16_t      FanMaxPwm;
+  uint16_t      FanMinPwm;
+  uint16_t      FanMaxTemp; // Degree Celcius
+  uint16_t      FanMinTemp; // Degree Celcius
   uint16_t      MaxOpTemp;            // Degree Celcius
   uint16_t      FanZeroRpmEnable;
-  uint16_t      Padding;
 
-  uint32_t     MmHubPadding[8]; // SMU internal use  
+  uint32_t     MmHubPadding[6]; // SMU internal use
 
 } OverDriveTable_t; 
 
 typedef struct {
   uint16_t CurrClock[PPCLK_COUNT];
-  uint16_t AverageGfxclkFrequency;
+  uint16_t AverageGfxclkFrequencyPostDs;
   uint16_t AverageSocclkFrequency;
-  uint16_t AverageUclkFrequency  ;
+  uint16_t AverageUclkFrequencyPostDs;
   uint16_t AverageGfxActivity    ;
   uint16_t AverageUclkActivity   ;
   uint8_t  CurrSocVoltageOffset  ;
@@ -880,15 +884,21 @@ typedef struct {
   uint8_t  Padding8_2;
   uint16_t CurrFanSpeed;
 
+  uint16_t AverageGfxclkFrequencyPreDs;  uint16_t 
+ AverageUclkFrequencyPreDs;  uint8_t  PcieRate;  uint8_t  PcieWidth;  
+ uint8_t  Padding8_3[2];
+
   // Padding - ignore
   uint32_t     MmHubPadding[8]; // SMU internal use
 } SmuMetrics_t;
 
 typedef struct {
   uint16_t CurrClock[PPCLK_COUNT];
-  uint16_t AverageGfxclkFrequency;
+  uint16_t AverageGfxclkFrequencyPostDs;
   uint16_t AverageSocclkFrequency;
-  uint16_t AverageUclkFrequency  ;
+  uint16_t AverageUclkFrequencyPostDs;
   uint16_t AverageGfxActivity    ;
   uint16_t AverageUclkActivity   ;
   uint8_t  CurrSocVoltageOffset  ;
@@ -913,11 +923,16 @@ typedef struct {
   uint8_t  Padding8_2;
   uint16_t CurrFanSpeed;
 
-  uint32_t EnergyAccumulator;
   uint16_t AverageVclkFrequency  ;
   uint16_t AverageDclkFrequency  ;
   uint16_t VcnActivityPercentage ;
-  uint16_t padding16_2;
+  uint16_t AverageGfxclkFrequencyPreDs;  uint16_t 
+ AverageUclkFrequencyPreDs;  uint8_t  PcieRate;  uint8_t  PcieWidth;
+
+  uint32_t Padding32_1;
+  uint64_t EnergyAccumulator;
 
   // Padding - ignore
   uint32_t     MmHubPadding[8]; // SMU internal use
diff --git a/drivers/gpu/drm/amd/pm/inc/smu_v11_0.h b/drivers/gpu/drm/amd/pm/inc/smu_v11_0.h
index 281835f23f6d..50dd1529b994 100644
--- a/drivers/gpu/drm/amd/pm/inc/smu_v11_0.h
+++ b/drivers/gpu/drm/amd/pm/inc/smu_v11_0.h
@@ -27,9 +27,9 @@
 
 #define SMU11_DRIVER_IF_VERSION_INV 0xFFFFFFFF  #define SMU11_DRIVER_IF_VERSION_ARCT 0x17 -#define SMU11_DRIVER_IF_VERSION_NV10 0x36 -#define SMU11_DRIVER_IF_VERSION_NV12 0x36 -#define SMU11_DRIVER_IF_VERSION_NV14 0x36
+#define SMU11_DRIVER_IF_VERSION_NV10 0x37 #define 
+SMU11_DRIVER_IF_VERSION_NV12 0x38 #define SMU11_DRIVER_IF_VERSION_NV14 
+0x38
 #define SMU11_DRIVER_IF_VERSION_Sienna_Cichlid 0x3D  #define SMU11_DRIVER_IF_VERSION_Navy_Flounder 0xE  #define SMU11_DRIVER_IF_VERSION_VANGOGH 0x02 diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
index 6ec842811cbc..29e04f33f276 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
@@ -70,6 +70,8 @@
 	FEATURE_MASK(FEATURE_DPM_LINK_BIT)	 | \
 	FEATURE_MASK(FEATURE_DPM_DCEFCLK_BIT))
 
+#define SMU_11_0_GFX_BUSY_THRESHOLD 15
+
 static struct cmn2asic_msg_mapping navi10_message_map[SMU_MSG_MAX_COUNT] = {
 	MSG_MAP(TestMessage,			PPSMC_MSG_TestMessage,			1),
 	MSG_MAP(GetSmuVersion,			PPSMC_MSG_GetSmuVersion,		1),
@@ -515,6 +517,8 @@ static int navi10_get_smu_metrics_data(struct smu_context *smu,
 	 * same offsets for the heading parts(those members used here).
 	 */
 	SmuMetrics_t *metrics = (SmuMetrics_t *)smu_table->metrics_table;
+	struct amdgpu_device *adev = smu->adev;
+	uint32_t smu_version;
 	int ret = 0;
 
 	mutex_lock(&smu->metrics_lock);
@@ -547,13 +551,30 @@ static int navi10_get_smu_metrics_data(struct smu_context *smu,
 		*value = metrics->CurrClock[PPCLK_DCEFCLK];
 		break;
 	case METRICS_AVERAGE_GFXCLK:
-		*value = metrics->AverageGfxclkFrequency;
+		ret = smu_cmn_get_smc_version(smu, NULL, &smu_version);
+		if (ret) {
+			dev_err(adev->dev, "Failed to get smu version!\n");
+			return ret;
+		}
+		/*
+		 * The PreDs is supported by:
+		 *   - Navi10 PMFW 42.60 and onwards
+		 *   - Navi12 PMFW 52.29 and onwards
+		 *   - Navi14 PMFW 53.31 and onwards
+		 */
+		if ((metrics->AverageGfxActivity > SMU_11_0_GFX_BUSY_THRESHOLD) &&
+		     (((adev->asic_type == CHIP_NAVI14) && smu_version > 0x00351F00) ||
+		     ((adev->asic_type == CHIP_NAVI12) && smu_version > 0x00341C00) ||
+		     ((adev->asic_type == CHIP_NAVI10) && smu_version > 0x002A3B00)))
+			*value = metrics->AverageGfxclkFrequencyPreDs;
+		else
+			*value = metrics->AverageGfxclkFrequencyPostDs;
 		break;
 	case METRICS_AVERAGE_SOCCLK:
 		*value = metrics->AverageSocclkFrequency;
 		break;
 	case METRICS_AVERAGE_UCLK:
-		*value = metrics->AverageUclkFrequency;
+		*value = metrics->AverageUclkFrequencyPostDs;
 		break;
 	case METRICS_AVERAGE_GFXACTIVITY:
 		*value = metrics->AverageGfxActivity; @@ -2298,6 +2319,7 @@ static ssize_t navi10_get_gpu_metrics(struct smu_context *smu,
 	struct amdgpu_device *adev = smu->adev;
 	SmuMetrics_NV12_t nv12_metrics = { 0 };
 	SmuMetrics_t metrics;
+	uint32_t smu_version;
 	int ret = 0;
 
 	mutex_lock(&smu->metrics_lock);
@@ -2330,9 +2352,27 @@ static ssize_t navi10_get_gpu_metrics(struct smu_context *smu,
 
 	gpu_metrics->average_socket_power = metrics.AverageSocketPower;
 
-	gpu_metrics->average_gfxclk_frequency = metrics.AverageGfxclkFrequency;
+	ret = smu_cmn_get_smc_version(smu, NULL, &smu_version);
+	if (ret) {
+		dev_err(adev->dev, "Failed to get smu version!\n");
+		return ret;
+	}
+	/*
+	 * The PreDs is supported by:
+	 *   - Navi10 PMFW 42.60 and onwards
+	 *   - Navi12 PMFW 52.29 and onwards
+	 *   - Navi14 PMFW 53.31 and onwards
+	 */
+	if ((metrics.AverageGfxActivity > SMU_11_0_GFX_BUSY_THRESHOLD) &&
+	     (((adev->asic_type == CHIP_NAVI14) && smu_version > 0x00351F00) ||
+	     ((adev->asic_type == CHIP_NAVI12) && smu_version > 0x00341C00) ||
+	     ((adev->asic_type == CHIP_NAVI10) && smu_version > 0x002A3B00)))
+		gpu_metrics->average_gfxclk_frequency = metrics.AverageGfxclkFrequencyPreDs;
+	else
+		gpu_metrics->average_gfxclk_frequency = 
+metrics.AverageGfxclkFrequencyPostDs;
+
 	gpu_metrics->average_socclk_frequency = metrics.AverageSocclkFrequency;
-	gpu_metrics->average_uclk_frequency = metrics.AverageUclkFrequency;
+	gpu_metrics->average_uclk_frequency = 
+metrics.AverageUclkFrequencyPostDs;
 
 	if (adev->asic_type == CHIP_NAVI12) {
 		gpu_metrics->energy_accumulator = nv12_metrics.EnergyAccumulator;
--
2.29.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=04%7C01%7Cguchun.chen%40amd.com%7C904cd32f467d42d0426608d8d6e5e650%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637495630218804695%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=zmHEroFHgzLnVsekg8%2FdKuY2seRJQ01JSuUqurJGM2g%3D&amp;reserved=0
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
