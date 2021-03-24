Return-Path: <SRS0=J6fF=IW=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA874C433DB
	for <amd-gfx@archiver.kernel.org>; Wed, 24 Mar 2021 01:32:10 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 68A47619E3
	for <amd-gfx@archiver.kernel.org>; Wed, 24 Mar 2021 01:32:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 68A47619E3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E88ED6EAE2;
	Wed, 24 Mar 2021 01:32:09 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2085.outbound.protection.outlook.com [40.107.220.85])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7FA8A6EAE2
 for <amd-gfx@lists.freedesktop.org>; Wed, 24 Mar 2021 01:32:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=faqb87Btu0ebyCZkpsSjb13JBcn6QhfR5xoQdRrJXaJkqf6+TuPyoYWMVxenvDnxxa63wcxxXAhSjSxAR5foeocDxa1Mnuzfi1+kVl6ZbUKw1VSvf2pQziBUHDXap8/GsljnXA5LiLZRYoecTSsbc2TSu2/rce86qA+MwK2sUOj6i3XnvFjWANje2kwGyHOmCRRbeld6Az4b0q4gQGeAgDBebSuzxVFTIRic27/qSvkyJEKCZJPJkVsO5RpDepL06ZXLVlUaVwj7kYBWH8bVIc9j0xbdZuvL3YBWEfU2LCfmSq9Pu9V5IP0RtIyDS5hQL4KgfN4sqqLyKfRzOeVIEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VnWKzntG4LVniNYsliMR7Q+LexJksemhJ31kVjOw1d4=;
 b=AzTAPJFHV5NBw/2zIHkCWyp4WzeIKAABbgIv4jsOG10n48/ojv5iMMEOuQuz3oa0clomwiLffHYEgIt6yeW6LBQyWp9vt4mNPYzdBIUmhrslZiztPN1UjKlQXtn6pX6lB7vTmQxQX6XbH/LSzOpRbAO0BOmfuoC7JDosv9ELPhxtQG30Q2UZgKaz3TLMNZ8EvtLX3p5dtB8RhRocaFVGl6XrmyA0KJXFVdAlE1NFWyVwkBT6jdUvK2nf7rlBAPp6L+Guqf71hDiuR4Hm/2n6nvZfdSTyZeWkc8yJ1HUgLSObOYyOS9D3XvZp8mg6vqHUJ9hs3VntVid7KZ7lroZqmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VnWKzntG4LVniNYsliMR7Q+LexJksemhJ31kVjOw1d4=;
 b=Js4yVldpfTzSvpb8vWGp7D9p9RwijLkgvGkxNH0aGJRibv1hDyZf81FQ/KFWew1SCpM9YuzbCrmEnCS9NDbwYj28E4V4A4NjM8ZTvLrz35U6ZS3VdLCA7yNwfir4CQ7Ok6U30whqvjRJp5pud28+5EfI7llGcS/rc50BTc1lFug=
Received: from DM6PR12MB4603.namprd12.prod.outlook.com (2603:10b6:5:166::11)
 by DM6PR12MB3579.namprd12.prod.outlook.com (2603:10b6:5:11f::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3955.24; Wed, 24 Mar
 2021 01:32:05 +0000
Received: from DM6PR12MB4603.namprd12.prod.outlook.com
 ([fe80::69b7:e163:347a:ba70]) by DM6PR12MB4603.namprd12.prod.outlook.com
 ([fe80::69b7:e163:347a:ba70%6]) with mapi id 15.20.3955.027; Wed, 24 Mar 2021
 01:32:05 +0000
From: "Xu, Feifei" <Feifei.Xu@amd.com>
To: "Lazar, Lijo" <Lijo.Lazar@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amd/pm: Update aldebaran pmfw interface
Thread-Topic: [PATCH] drm/amd/pm: Update aldebaran pmfw interface
Thread-Index: Adcf5Uxzzx+eUVs0TECp524n5TX5VQAaCivA
Date: Wed, 24 Mar 2021 01:32:04 +0000
Message-ID: <DM6PR12MB4603AC32C3DD2C5A358D29DBFE639@DM6PR12MB4603.namprd12.prod.outlook.com>
References: <MN2PR12MB4549C3C4388974DA56E79AB197649@MN2PR12MB4549.namprd12.prod.outlook.com>
In-Reply-To: <MN2PR12MB4549C3C4388974DA56E79AB197649@MN2PR12MB4549.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Enabled=true;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SetDate=2021-03-23T13:07:03Z; 
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Method=Privileged;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Name=Public_0;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ActionId=45389dfd-499c-467b-bdbe-cf8162388cd3;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ContentBits=1
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [180.167.199.189]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: ee1e968c-8390-4a25-e0d6-08d8ee64a1b9
x-ms-traffictypediagnostic: DM6PR12MB3579:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR12MB35796E15BA0A9CD972FF055FFE639@DM6PR12MB3579.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1824;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Hge1BvBBNRndo8u3PGMKMDXsDDbPjn09icvlxZRDhizNfNEvpusu4U0AhSRexsM6hrhTCXMxnSPMCa8aEXkBvDJLlzGN/Mq4ivD31f/kodp8cyg7VupYKooQp3iAusLMrI6zJOvFtsPbQpsUh2zzqcXVys7UuyB0wJhh1B8tzHCn6b/mErGLfvIMYI9wGdRj0bdsEX7xyawSyCac61Mak/BfsYNExE2+N1EiJ7VAydaqMRZOctX7bGPjvtsOvfixUJqZE8zOKNaceHVp2cO4YL1rp7YZUmIUzy1pYsRgOiW5OQwvPZQrP5Txrv4QHwXBBsyxSdtbWKx7o8YTukvumhDhSQWjoT2kAe7lJZOHNN+z8zK9sKg/PNgup7cIwP1zrgVjf/HB7edlB78TiB5LGnpwIXyC2ur+zrFaGmpjI7GelAdqXVGpYil4Q1jD9c9CF0zxNVU24z34p4RY27JccP9aRxkHw2IQYkIF5weuWbvF+eRYwZex48FvU521edK/ACqtFqZtVEEqFn5PHstsSsxGWyqWXkqzHH8NePJ+v1R/jH96Pdx866si9c5rmVFHDccGS5vdPBPvCWgjk7IE0PC9xuSd1vHHraYxfOiLK+dNk+Gm0mzaf1Vq3MywIQ7oZ0jrKAPNNTlkVEfrVW1FTPDuhYZP41htPKJYdYmxGTs=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB4603.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(376002)(346002)(366004)(136003)(39860400002)(71200400001)(66556008)(66946007)(64756008)(76116006)(4326008)(66446008)(66476007)(5660300002)(52536014)(83380400001)(38100700001)(9686003)(186003)(55016002)(7696005)(15650500001)(8936002)(478600001)(8676002)(2906002)(316002)(54906003)(53546011)(6506007)(110136005)(26005)(33656002)(86362001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?As/+UT+rSGdRpyBOe0z3X5RwGZYqjnL4JomC3dzF7tvISbVKdoog4ramt7Pu?=
 =?us-ascii?Q?p1206dJhj3vSbWGCvVBeTm2CMSUHlw0mm2x3Kxq1hdeoFMfKiZvpOf4YcBFe?=
 =?us-ascii?Q?omFLNMQsF2mxRCWEk2a5F98s7OzjnjcU1FjEYY3cFFc8cPmFxVuN5IuR36YV?=
 =?us-ascii?Q?RPh60jN6RL2Rz4JsjFXuJsJop9/n4e6sYBd60hGH9GVaT5k0Su0Zfufi6RU+?=
 =?us-ascii?Q?eUEZtmaopTVKxU9drQUPAqFYfBQvdCnupvq7LrJ0Lr1frCANw3ocKhE//irl?=
 =?us-ascii?Q?wAEh/vl4vpEOvovn6KjXGctHp4PtX+P/xPqGL5w6w76bX198fUHW4DRKkhNs?=
 =?us-ascii?Q?mM0BhGMG/G8oSvt2AFUodmf2vAJmIx7JqVJMakPklugSXvMX+3k9KRufXFbr?=
 =?us-ascii?Q?x3WFSqLx1yCbVu0KkmVBUEfWFfBnVonLZojFyf5NJ7ylkVBoaMb3xkMxtf4a?=
 =?us-ascii?Q?SiXKfIKDYLYHS+Nho4s58oxjDzwJI2tl+8WEMffxCLExddslhGb1HqKcCkMs?=
 =?us-ascii?Q?lIC7dQfA4lPiUmI5htAL+SQzYQHuB90GKJSHXA1RBLORGYiB2el6mDZJCdIp?=
 =?us-ascii?Q?s94OKF/zWj+doO4zTRHHJRcyeNkdEfG47+5Ur5QncooAI/tOZ9UsUhARqTmS?=
 =?us-ascii?Q?OJb5m6LqBMWM5a/xdK5vvCf+TLN73kwZah06iK3I7g0w/CvwCZXhS6281/6E?=
 =?us-ascii?Q?G7JCmKtplCDYbMxR7TLpcxYKYVlemYKEIv1iqSSU1WtXq2VXcf7zpM5yNiXa?=
 =?us-ascii?Q?4CuXFMI798pRpGcJygFz37pzunMHQPKGfuX4BbKiwSpE0gmiqz/1T0EeSlOf?=
 =?us-ascii?Q?gLognxmJ3sVfpWXSd4PfxQPu1TmmXHMgL4ZJJhw15AneMw+tBwwoP3fCJckA?=
 =?us-ascii?Q?YncdZK5lo5W7LE+lfP/gzYdKCHvRMJies5xeYnQpB+3vfc4YPF705Ov96ENM?=
 =?us-ascii?Q?PpWFJj7aZJZKkDSyEE2SDkTs952B+ZnYBnLGrqj6+mQ6DvWo3tuskyDc28Fx?=
 =?us-ascii?Q?72go1pDdo2igoqO3RbB62VfjkHZnf2VeAFKPHnzoQNK+11saV+rp1lLBZiqT?=
 =?us-ascii?Q?ihF4CnP4S42hkkAug31w4hCxPzJ8QuEO4kDf3nIPWv1I3O3G0VD0czfdTpms?=
 =?us-ascii?Q?L6zeaiTo5B4gguRtVGRFuy3kOLeVEZQl0S12SQjkbV1Gd727QUzBii/8dJuY?=
 =?us-ascii?Q?qNEkXas/0XiRBFgHAEQ8vsNH944/xyFEJlf6jl2RkxMTWKubjL9C6TZuDnhG?=
 =?us-ascii?Q?wlDkvGhiDiQm1BQNJjthGUKfxpwN/2Mtsf74oKlwJtfjITAJj6TnFbYLeZyo?=
 =?us-ascii?Q?h1wdSPXoUmxW5xF3aj9Nxv9Y?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4603.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ee1e968c-8390-4a25-e0d6-08d8ee64a1b9
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Mar 2021 01:32:04.9099 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: eo9Ak/vZTDhVS6ZoDmKUvH24ZLR7mqODpBtQZ5HLkUHRoBJqW9cOOfK78FXca2f4
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3579
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
Cc: "Wang, Kevin\(Yang\)" <Kevin1.Wang@amd.com>, "Feng,
 Kenneth" <Kenneth.Feng@amd.com>, "Zhang, Hawking" <Hawking.Zhang@amd.com>
Content-Type: multipart/mixed; boundary="===============2040171961=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============2040171961==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_DM6PR12MB4603AC32C3DD2C5A358D29DBFE639DM6PR12MB4603namp_"

--_000_DM6PR12MB4603AC32C3DD2C5A358D29DBFE639DM6PR12MB4603namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable



Reviewed-by: Feifei Xu <Feifei.Xu@amd.com>

From: Lazar, Lijo <Lijo.Lazar@amd.com>
Sent: Tuesday, March 23, 2021 9:07 PM
To: amd-gfx@lists.freedesktop.org
Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Xu, Feifei <Feifei.Xu@amd.com>;=
 Feng, Kenneth <Kenneth.Feng@amd.com>; Wang, Kevin(Yang) <Kevin1.Wang@amd.c=
om>
Subject: [PATCH] drm/amd/pm: Update aldebaran pmfw interface


[AMD Public Use]

Update aldebaran PMFW interfaces to version 0x6

Signed-off-by: Lijo Lazar lijo.lazar@amd.com<mailto:lijo.lazar@amd.com>
---
.../gpu/drm/amd/pm/inc/smu13_driver_if_aldebaran.h    | 11 +++++++++--
drivers/gpu/drm/amd/pm/inc/smu_v13_0.h                |  2 +-
2 files changed, 10 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/inc/smu13_driver_if_aldebaran.h b/drive=
rs/gpu/drm/amd/pm/inc/smu13_driver_if_aldebaran.h
index df2ead254f37..d23533bda002 100644
--- a/drivers/gpu/drm/amd/pm/inc/smu13_driver_if_aldebaran.h
+++ b/drivers/gpu/drm/amd/pm/inc/smu13_driver_if_aldebaran.h
@@ -435,8 +435,12 @@ typedef struct {
   uint8_t  GpioI2cSda; // Serial Data
   uint16_t spare5;

+  uint16_t XgmiMaxCurrent; // in Amps
+  int8_t   XgmiOffset;     // in Amps
+  uint8_t  Padding_TelemetryXgmi;
+
   //reserved
-  uint32_t reserved[16];
+  uint32_t reserved[15];

 } PPTable_t;

@@ -481,7 +485,10 @@ typedef struct {
   uint16_t TemperatureAllHBM[4]  ;
   uint32_t GfxBusyAcc            ;
   uint32_t DramBusyAcc           ;
-  uint32_t Spare[4];
+  uint32_t EnergyAcc64bitLow     ; //15.259uJ resolution
+  uint32_t EnergyAcc64bitHigh    ;
+  uint32_t TimeStampLow          ; //10ns resolution
+  uint32_t TimeStampHigh         ;

   // Padding - ignore
   uint32_t     MmHubPadding[8]; // SMU internal use
diff --git a/drivers/gpu/drm/amd/pm/inc/smu_v13_0.h b/drivers/gpu/drm/amd/p=
m/inc/smu_v13_0.h
index 6db3464c09d6..8145e1cbf181 100644
--- a/drivers/gpu/drm/amd/pm/inc/smu_v13_0.h
+++ b/drivers/gpu/drm/amd/pm/inc/smu_v13_0.h
@@ -26,7 +26,7 @@
#include "amdgpu_smu.h"

 #define SMU13_DRIVER_IF_VERSION_INV 0xFFFFFFFF
-#define SMU13_DRIVER_IF_VERSION_ALDE 0x5
+#define SMU13_DRIVER_IF_VERSION_ALDE 0x6

 /* MP Apertures */
#define MP0_Public                                      0x03800000
--
2.17.1


--_000_DM6PR12MB4603AC32C3DD2C5A358D29DBFE639DM6PR12MB4603namp_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html xmlns:v=3D"urn:schemas-microsoft-com:vml" xmlns:o=3D"urn:schemas-micr=
osoft-com:office:office" xmlns:w=3D"urn:schemas-microsoft-com:office:word" =
xmlns:m=3D"http://schemas.microsoft.com/office/2004/12/omml" xmlns=3D"http:=
//www.w3.org/TR/REC-html40">
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
<meta name=3D"Generator" content=3D"Microsoft Word 15 (filtered medium)">
<style><!--
/* Font Definitions */
@font-face
	{font-family:"Cambria Math";
	panose-1:2 4 5 3 5 4 6 3 2 4;}
@font-face
	{font-family:DengXian;
	panose-1:2 1 6 0 3 1 1 1 1 1;}
@font-face
	{font-family:Calibri;
	panose-1:2 15 5 2 2 2 4 3 2 4;}
@font-face
	{font-family:"\@DengXian";
	panose-1:2 1 6 0 3 1 1 1 1 1;}
/* Style Definitions */
p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0in;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif;}
a:link, span.MsoHyperlink
	{mso-style-priority:99;
	color:#0563C1;
	text-decoration:underline;}
p.msipheader251902e5, li.msipheader251902e5, div.msipheader251902e5
	{mso-style-name:msipheader251902e5;
	mso-margin-top-alt:auto;
	margin-right:0in;
	mso-margin-bottom-alt:auto;
	margin-left:0in;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif;}
span.EmailStyle20
	{mso-style-type:personal-reply;
	font-family:"Calibri",sans-serif;
	color:windowtext;}
.MsoChpDefault
	{mso-style-type:export-only;
	font-size:10.0pt;}
@page WordSection1
	{size:8.5in 11.0in;
	margin:1.0in 1.0in 1.0in 1.0in;}
div.WordSection1
	{page:WordSection1;}
--></style><!--[if gte mso 9]><xml>
<o:shapedefaults v:ext=3D"edit" spidmax=3D"1026" />
</xml><![endif]--><!--[if gte mso 9]><xml>
<o:shapelayout v:ext=3D"edit">
<o:idmap v:ext=3D"edit" data=3D"1" />
</o:shapelayout></xml><![endif]-->
</head>
<body lang=3D"EN-US" link=3D"#0563C1" vlink=3D"#954F72" style=3D"word-wrap:=
break-word">
<div class=3D"WordSection1">
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<div>
<p class=3D"MsoNormal">Reviewed-by: Feifei Xu &lt;Feifei.Xu@amd.com&gt;<o:p=
></o:p></p>
</div>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<div>
<div style=3D"border:none;border-top:solid #E1E1E1 1.0pt;padding:3.0pt 0in =
0in 0in">
<p class=3D"MsoNormal"><b>From:</b> Lazar, Lijo &lt;Lijo.Lazar@amd.com&gt; =
<br>
<b>Sent:</b> Tuesday, March 23, 2021 9:07 PM<br>
<b>To:</b> amd-gfx@lists.freedesktop.org<br>
<b>Cc:</b> Zhang, Hawking &lt;Hawking.Zhang@amd.com&gt;; Xu, Feifei &lt;Fei=
fei.Xu@amd.com&gt;; Feng, Kenneth &lt;Kenneth.Feng@amd.com&gt;; Wang, Kevin=
(Yang) &lt;Kevin1.Wang@amd.com&gt;<br>
<b>Subject:</b> [PATCH] drm/amd/pm: Update aldebaran pmfw interface<o:p></o=
:p></p>
</div>
</div>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"msipheader251902e5" style=3D"margin:0in"><span style=3D"font-si=
ze:10.0pt;font-family:&quot;Arial&quot;,sans-serif;color:#317100">[AMD Publ=
ic Use]</span><o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Update aldebaran PMFW interfaces to version 0x6<o:p>=
</o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Signed-off-by: Lijo Lazar <a href=3D"mailto:lijo.laz=
ar@amd.com">
lijo.lazar@amd.com</a><o:p></o:p></p>
<p class=3D"MsoNormal">---<o:p></o:p></p>
<p class=3D"MsoNormal">.../gpu/drm/amd/pm/inc/smu13_driver_if_aldebaran.h&n=
bsp;&nbsp;&nbsp; | 11 +++++++++--<o:p></o:p></p>
<p class=3D"MsoNormal">drivers/gpu/drm/amd/pm/inc/smu_v13_0.h&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
; |&nbsp; 2 +-<o:p></o:p></p>
<p class=3D"MsoNormal">2 files changed, 10 insertions(+), 3 deletions(-)<o:=
p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">diff --git a/drivers/gpu/drm/amd/pm/inc/smu13_driver=
_if_aldebaran.h b/drivers/gpu/drm/amd/pm/inc/smu13_driver_if_aldebaran.h<o:=
p></o:p></p>
<p class=3D"MsoNormal">index df2ead254f37..d23533bda002 100644<o:p></o:p></=
p>
<p class=3D"MsoNormal">--- a/drivers/gpu/drm/amd/pm/inc/smu13_driver_if_ald=
ebaran.h<o:p></o:p></p>
<p class=3D"MsoNormal">+++ b/drivers/gpu/drm/amd/pm/inc/smu13_driver_if_ald=
ebaran.h<o:p></o:p></p>
<p class=3D"MsoNormal">@@ -435,8 +435,12 @@ typedef struct {<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp; uint8_t&nbsp; GpioI2cSda; // Serial Dat=
a<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp; uint16_t spare5;<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">+&nbsp; uint16_t XgmiMaxCurrent; // in Amps<o:p></o:=
p></p>
<p class=3D"MsoNormal">+&nbsp; int8_t&nbsp;&nbsp; XgmiOffset;&nbsp;&nbsp;&n=
bsp;&nbsp; // in Amps<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp; uint8_t&nbsp; Padding_TelemetryXgmi;<o:p></o=
:p></p>
<p class=3D"MsoNormal">+<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp; //reserved<o:p></o:p></p>
<p class=3D"MsoNormal">-&nbsp; uint32_t reserved[16];<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp; uint32_t reserved[15];<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">&nbsp;} PPTable_t;<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">@@ -481,7 +485,10 @@ typedef struct {<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp; uint16_t TemperatureAllHBM[4]&nbsp; ;<o=
:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp; uint32_t GfxBusyAcc&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ;<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp; uint32_t DramBusyAcc&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ;<o:p></o:p></p>
<p class=3D"MsoNormal">-&nbsp; uint32_t Spare[4];<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp; uint32_t EnergyAcc64bitLow&nbsp;&nbsp;&nbsp;=
&nbsp; ; //15.259uJ resolution<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp; uint32_t EnergyAcc64bitHigh&nbsp;&nbsp;&nbsp=
; ;<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp; uint32_t TimeStampLow&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ; //10ns resolution<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp; uint32_t TimeStampHigh&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; &nbsp;&nbsp;;<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;// Padding - ignore<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp; uint32_t&nbsp;&nbsp;&nbsp;&nbsp; MmHubP=
adding[8]; // SMU internal use<o:p></o:p></p>
<p class=3D"MsoNormal">diff --git a/drivers/gpu/drm/amd/pm/inc/smu_v13_0.h =
b/drivers/gpu/drm/amd/pm/inc/smu_v13_0.h<o:p></o:p></p>
<p class=3D"MsoNormal">index 6db3464c09d6..8145e1cbf181 100644<o:p></o:p></=
p>
<p class=3D"MsoNormal">--- a/drivers/gpu/drm/amd/pm/inc/smu_v13_0.h<o:p></o=
:p></p>
<p class=3D"MsoNormal">+++ b/drivers/gpu/drm/amd/pm/inc/smu_v13_0.h<o:p></o=
:p></p>
<p class=3D"MsoNormal">@@ -26,7 +26,7 @@<o:p></o:p></p>
<p class=3D"MsoNormal">#include &quot;amdgpu_smu.h&quot;<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">&nbsp;#define SMU13_DRIVER_IF_VERSION_INV 0xFFFFFFFF=
<o:p></o:p></p>
<p class=3D"MsoNormal">-#define SMU13_DRIVER_IF_VERSION_ALDE 0x5<o:p></o:p>=
</p>
<p class=3D"MsoNormal">+#define SMU13_DRIVER_IF_VERSION_ALDE 0x6<o:p></o:p>=
</p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">&nbsp;/* MP Apertures */<o:p></o:p></p>
<p class=3D"MsoNormal">#define MP0_Public&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x03800000<o:p></o:p></p>
<p class=3D"MsoNormal">-- <o:p></o:p></p>
<p class=3D"MsoNormal">2.17.1<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
</div>
</body>
</html>

--_000_DM6PR12MB4603AC32C3DD2C5A358D29DBFE639DM6PR12MB4603namp_--

--===============2040171961==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============2040171961==--
