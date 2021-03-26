Return-Path: <SRS0=Uu1B=IY=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FB2FC433DB
	for <amd-gfx@archiver.kernel.org>; Fri, 26 Mar 2021 06:03:43 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9F1CF619A3
	for <amd-gfx@archiver.kernel.org>; Fri, 26 Mar 2021 06:03:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9F1CF619A3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 45EF86E195;
	Fri, 26 Mar 2021 06:03:42 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2055.outbound.protection.outlook.com [40.107.93.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C8BBE6E195
 for <amd-gfx@lists.freedesktop.org>; Fri, 26 Mar 2021 06:03:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DxjHrIv3CwCAgOn1E9abPNJjOR8iveHR/BAMQHIkQ+JUrH85ruzselX5VQJRF6MPgA3DOGYvUBuGATMib3KrF3ZV8leXZdfvTD3gHt9/0sF0AgAxfknQZY6fte90acIC2WT0NJgWK79GIa1gg7LQXLoPA51Pn2zaC7s7OsMT/04PkdmYr41JayRi9KddSarNlGQUbiy6scTYur0eCLf7sIaZB9DqQKSpN7i8ni189HW0ywbwbtcSEOjLamfAt3fbwkTHY2duZEMdzKlnZFQwgmDszFt7SwKaYtgxedJx5/SJZO0mKXzwJnZhQ/Hpc+q2ufuhX1ulOzUTPsdnCr6IQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SGQ/fiDIToSqdiBXVY1VgwH6rKpHAck0A9ag72+xJZU=;
 b=PEh2nTGKBErQXr8BWGk4vpqIfpZidwi+2MoyOED7GwP/yXZFMGrGvC74TgbJDuHI4I6aUKLIucG9ebNJGDJiM4BAkziiSi/UVEMEDO/KrvIySwC4vsnHOYQ3jcO+H8zv8L2IBqq4dkl+FrIPlDz6n9YUXqKOwB/LM07TNE75WrKOg22aGSXOv6d3Rpp6QXZ5bQniztfw2mKXWFisXbyy0mh2KE7rU1qEefyKUvNWRZqtFIyKt4I2xyac2eosms0aimKeC2E+puzmZ2LKWA8WsxWO9LVS+5j3kqHO81mQ8dxEAsSbH5qHVBsGGMUWFJkSldXn3P0ZoxC8nCNTCW7A5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SGQ/fiDIToSqdiBXVY1VgwH6rKpHAck0A9ag72+xJZU=;
 b=bX6ngrAqm4walU2b6N4raIDMvM5jJfOo8kzt6d/9b5Db5tRmnHtdWQwYpee3peGQ2uKkr84BarXfPr9KS0L1HHeNreLHxieeNGDs2PgmaHI6wLGAgDVOpGBY5lbY8yi+KRvR020oAdmElMANGHpe7EMKvUSAOmd9RtQziyhHuC4=
Received: from MN2PR12MB4549.namprd12.prod.outlook.com (2603:10b6:208:268::15)
 by BL0PR12MB2546.namprd12.prod.outlook.com (2603:10b6:207:3f::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3977.29; Fri, 26 Mar
 2021 06:03:38 +0000
Received: from MN2PR12MB4549.namprd12.prod.outlook.com
 ([fe80::58d5:c2:7a3c:4408]) by MN2PR12MB4549.namprd12.prod.outlook.com
 ([fe80::58d5:c2:7a3c:4408%5]) with mapi id 15.20.3977.030; Fri, 26 Mar 2021
 06:03:38 +0000
From: "Lazar, Lijo" <Lijo.Lazar@amd.com>
To: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amd/pm: Fix DPM level count on aldebaran
Thread-Topic: [PATCH] drm/amd/pm: Fix DPM level count on aldebaran
Thread-Index: AdciBab3KsDuQMVmSd2h29lLgLBNeA==
Date: Fri, 26 Mar 2021 06:03:38 +0000
Message-ID: <MN2PR12MB45496022CDFAACE2E5E2FF8197619@MN2PR12MB4549.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Enabled=true;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SetDate=2021-03-26T06:03:36Z; 
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Method=Privileged;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Name=Public_0;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ActionId=13a01e9a-70db-4443-b6c4-dc01273b3ff2;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ContentBits=1
authentication-results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
x-originating-ip: [49.207.206.193]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: ed96f026-ff8c-4dc2-eca6-08d8f01ce639
x-ms-traffictypediagnostic: BL0PR12MB2546:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BL0PR12MB25460613FC9E9B9974C03BDF97619@BL0PR12MB2546.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2512;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: qUrgKbw2zwRtuSg+PZTDcDeNFdqCFTxAzNs3aqNC/NYXgAJobWdmY9TGT3djBn3qJHOjUjNXejnxzaw3xXuhsX7uNzzNhua4fMIkVlNY8I/xvP0bmhS57H6nTak7jSjZ/c2VuZJZd3/OZPbveLOBAkxynPq4MescZNCo1DNCs0yflk4QeUr2SV0QCJ3LSESJng+JbSzsJHaNhqu7JDRilZTPZM5ats+hIX3+RTKWXRnBzcJyPmiFqCeVR9xH1SgOJ/fxGX2LnyNEOk0iRLy8ZMlPMqTp7SqyLSbsSBS/jlUxqMdiFrtIF8AeOHDhDmnrTzcY4s3UYtv1yIDv80qAEyOMTdT4s77GPfcCdNxqSfnU6LmULBy7CkDtFLARYfsJvgaXQ6gwq1G/Z9EIdZcBi8omHobBF2O2HyWEWFEWbvOyi+1cQI51gYEsIwyCVvs5e5qYQEpWBjSjW8pfUV3UBxEtYwHJCA+HKwUL41qU/G8r3J4eJAnNvznjdU0ByYrpRKuKhsddjAgnhBISBQmh2r+QgSXvgYYGbheAcEQ9ri1gsZ2ahBHk5yzwssM7jDGMWN2i4R5QpW4WITZfGCK0RQ88RYB9ArpJeEqmgADWjGZXPZofUw00Dw8X3qRK0+Z2npEpjC1r6YJ0VX1xqt7CrkqiT5grz+UfqVpZqZz8M0c=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB4549.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(366004)(396003)(136003)(376002)(346002)(66446008)(64756008)(26005)(8936002)(83380400001)(66476007)(76116006)(54906003)(66946007)(6916009)(4326008)(478600001)(66556008)(7696005)(9686003)(33656002)(52536014)(86362001)(5660300002)(316002)(186003)(38100700001)(55016002)(71200400001)(55236004)(8676002)(2906002)(6506007);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?SyHguvGut79Kt2LFBEtVhQoG7X5FutQ3S2AEkynZAE2ysQQkbkPNSccKRs88?=
 =?us-ascii?Q?wmHBtgj6WSjCvvXLm62Hml2as5AKR+aLBXiNHoy2TgiBC+56rYg/GNe1hwKi?=
 =?us-ascii?Q?ldwVXnMyINWeMvvUVtcKqCy85PIa9Rz9HRCvB71tuuxEGMy//zwmecsb1n5m?=
 =?us-ascii?Q?9VQLHgRVLuaDEdMCRfxHrGoP0YeAN8cf4R/ZvxRFPZ8gPcjx+NguPl7O+UsY?=
 =?us-ascii?Q?dEEfDQYk1fQ0Djd1TxTLs14ALgvAddtyZTnzNbw2KgwuJPQIOyXPf9KqjHYS?=
 =?us-ascii?Q?A1lseuscFk4vy1XLXexrexI/UuIZAOODBxonQEbYzOVY/lLySDI3SJ99Ctj/?=
 =?us-ascii?Q?ae7rMl+6ulU7yDzf1wY+LgD75pGlp85jMxGKlU/sYnKP1C0gvSrWZj+5jz1u?=
 =?us-ascii?Q?JkdLIMqjZAZUFGX0RUyaBQuoZ98uxkLVsIcvP8YFzKIFvWDHdjG6g6aTjnss?=
 =?us-ascii?Q?hjQuSLKpzaPUPztPtrAnFLA4cpeAwTWBfDufu9lGuK1YuDXEClwTUUSXjy4L?=
 =?us-ascii?Q?q39/s0D6EByZIYKvQxGrY1geAD3XVGALG7I6KqCl4eQJs0UuZt1hXr6M9S6X?=
 =?us-ascii?Q?5tojwJZBpKuVDytV3X7u5kNoWgv2Go5LbXoKDg4nkSik6kRKEe7pLkGSuegB?=
 =?us-ascii?Q?m2ttcGNDFmBgb7DE5Hi7yirp9f5+QuVP74LzI47vmsnSbZ+FWvxPDkH+VtZ9?=
 =?us-ascii?Q?UC7ri8SYZnSMjlLxqg9pe6uIKmy/5p05BY3eqcmLVIRaR0lbakv5IaCrSNsc?=
 =?us-ascii?Q?se3H56H6tFk4Ld2B8cOVv4+l45ytiad8uelNefae43HWpHpNwvmP5VTu9oot?=
 =?us-ascii?Q?TwvEHqTasnscxOD4ArnjaNvp5PE1DhohVzYNBXMtB34bU6zzzMaPl2OV0mAf?=
 =?us-ascii?Q?L+AY10k757jMZhuYIFJjTGi8BJUmYQWt+7wj+HiVcPmgRxm6LY98jAimK6Uw?=
 =?us-ascii?Q?b5xM+drHwp1blOq2t7wA+2cijg+WPFnbDPlzud96LBefzwQuHSAVZJaA6tKJ?=
 =?us-ascii?Q?Oz0UUYK/dEIJRlpDTlXFMgRpbxOAmkuajfGYI6nmSFBEThIf/Cd4D8nEk5jb?=
 =?us-ascii?Q?2IZ1emmUpdP6D2GbAZjxyPu/4MWAn4007duwZva5vx77lbajY/Z7bYGvxc1j?=
 =?us-ascii?Q?i9/WOMbpebl3imq3F19jQSmQ4x0BBhFBDtNnVvvc7+Umcsk3E+8X5VUPj8a4?=
 =?us-ascii?Q?crHoDOEjJCYVI3Q1nJsdKlRSDuNpcbGUF8yzvKmpPhh/bHMO0PiQ499aXJuY?=
 =?us-ascii?Q?eKXBAQZXCY/E42vAiogbl0/f6V8uZb9TMhLEGCq1gf69G69HLk0QiDKz0NLm?=
 =?us-ascii?Q?AauNSvx1/IJcIXtCxinNl/Fn?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4549.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ed96f026-ff8c-4dc2-eca6-08d8f01ce639
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Mar 2021 06:03:38.2842 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Phtg01jQtji4URw575tx9ONsSXOI8e6dPd3augrJrEV4geWnMDXvMcK9QOQsyob0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB2546
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
Cc: "Xu, Feifei" <Feifei.Xu@amd.com>, "Wang,
 Kevin\(Yang\)" <Kevin1.Wang@amd.com>, "Feng, Kenneth" <Kenneth.Feng@amd.com>,
 "Zhang, Hawking" <Hawking.Zhang@amd.com>
Content-Type: multipart/mixed; boundary="===============1183479182=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============1183479182==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_MN2PR12MB45496022CDFAACE2E5E2FF8197619MN2PR12MB4549namp_"

--_000_MN2PR12MB45496022CDFAACE2E5E2FF8197619MN2PR12MB4549namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[AMD Public Use]

Firmware returns zero-based max level, increment by one to get
total levels. This fixes the issue of not showing all levels and current
frequency when frequency is at max DPM level.

Signed-off-by: Lijo Lazar lijo.lazar@amd.com<mailto:lijo.lazar@amd.com>
---
drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c | 12 ++++++++----
1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c b/drivers/gpu/d=
rm/amd/pm/swsmu/smu13/smu_v13_0.c
index 1f860969ea1c..30c9ac635105 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
@@ -1710,10 +1710,14 @@ int smu_v13_0_get_dpm_level_count(struct smu_contex=
t *smu,
                                                                 enum smu_c=
lk_type clk_type,
                                                                 uint32_t *=
value)
{
-              return smu_v13_0_get_dpm_freq_by_index(smu,
-                                                                          =
           clk_type,
-                                                                          =
           0xff,
-                                                                          =
           value);
+             int ret;
+
+             ret =3D smu_v13_0_get_dpm_freq_by_index(smu, clk_type, 0xff, =
value);
+             /* FW returns 0 based max level, increment by one */
+             if (!ret && value)
+                             ++(*value);
+
+             return ret;
}
 int smu_v13_0_set_single_dpm_table(struct smu_context *smu,
--
2.17.1


--_000_MN2PR12MB45496022CDFAACE2E5E2FF8197619MN2PR12MB4549namp_
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
	{font-family:Calibri;
	panose-1:2 15 5 2 2 2 4 3 2 4;}
/* Style Definitions */
p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0in;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif;}
a:link, span.MsoHyperlink
	{mso-style-priority:99;
	color:#0563C1;
	text-decoration:underline;}
span.EmailStyle17
	{mso-style-type:personal-compose;
	font-family:"Calibri",sans-serif;
	color:windowtext;}
.MsoChpDefault
	{mso-style-type:export-only;
	font-family:"Calibri",sans-serif;}
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
<p class=3D"msipheader251902e5" align=3D"Left" style=3D"margin:0"><span sty=
le=3D"font-size:10.0pt;font-family:Arial;color:#317100">[AMD Public Use]</s=
pan></p>
<br>
<div class=3D"WordSection1">
<p class=3D"MsoNormal">Firmware returns zero-based max level, increment by =
one to get<o:p></o:p></p>
<p class=3D"MsoNormal">total levels. This fixes the issue of not showing al=
l levels and current<o:p></o:p></p>
<p class=3D"MsoNormal">frequency when frequency is at max DPM level.<o:p></=
o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Signed-off-by: Lijo Lazar <a href=3D"mailto:lijo.laz=
ar@amd.com">
lijo.lazar@amd.com</a><o:p></o:p></p>
<p class=3D"MsoNormal">---<o:p></o:p></p>
<p class=3D"MsoNormal">drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c | 12 =
++++++++----<o:p></o:p></p>
<p class=3D"MsoNormal">1 file changed, 8 insertions(+), 4 deletions(-)<o:p>=
</o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_=
v13_0.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c<o:p></o:p></p>
<p class=3D"MsoNormal">index 1f860969ea1c..30c9ac635105 100644<o:p></o:p></=
p>
<p class=3D"MsoNormal">--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c=
<o:p></o:p></p>
<p class=3D"MsoNormal">+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c=
<o:p></o:p></p>
<p class=3D"MsoNormal">@@ -1710,10 +1710,14 @@ int smu_v13_0_get_dpm_level_=
count(struct smu_context *smu,<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;enum smu_clk_type clk_type,<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;uint32_t *value)<o:p></o:p></p>
<p class=3D"MsoNormal">{<o:p></o:p></p>
<p class=3D"MsoNormal">-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp; return smu_v13_0_get_dpm_freq_by_index(smu,<o:p=
></o:p></p>
<p class=3D"MsoNormal">-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; c=
lk_type,<o:p></o:p></p>
<p class=3D"MsoNormal">-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0=
xff,<o:p></o:p></p>
<p class=3D"MsoNormal">-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; v=
alue);<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; int ret;<o:p></o:p></p>
<p class=3D"MsoNormal">+<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; ret =3D smu_v13_0_get_dpm_freq_by_index(smu, clk_type=
, 0xff, value);<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; /* FW returns 0 based max level, increment by one */<=
o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; if (!ret &amp;&amp; value)<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ++(*value);<o:p></o:p></p>
<p class=3D"MsoNormal">+<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; return ret;<o:p></o:p></p>
<p class=3D"MsoNormal">}<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;int smu_v13_0_set_single_dpm_table(struct smu_=
context *smu,<o:p></o:p></p>
<p class=3D"MsoNormal">-- <o:p></o:p></p>
<p class=3D"MsoNormal">2.17.1<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
</div>
</body>
</html>

--_000_MN2PR12MB45496022CDFAACE2E5E2FF8197619MN2PR12MB4549namp_--

--===============1183479182==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============1183479182==--
