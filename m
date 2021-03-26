Return-Path: <SRS0=Uu1B=IY=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE94CC433DB
	for <amd-gfx@archiver.kernel.org>; Fri, 26 Mar 2021 06:51:27 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6E43F61A18
	for <amd-gfx@archiver.kernel.org>; Fri, 26 Mar 2021 06:51:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6E43F61A18
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C14206EEB3;
	Fri, 26 Mar 2021 06:51:26 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2087.outbound.protection.outlook.com [40.107.220.87])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1C96F6EEB3
 for <amd-gfx@lists.freedesktop.org>; Fri, 26 Mar 2021 06:51:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NvwGA2Y8L+lIOFMfsj+S/eEBEqhaTFKFuVcOOLzkgGK4rn2WQjJyZncUR1phwe1npUQVuCNRsOrqFSI8BnEXcLtH1LzrOaBpIwrTfWF6sADb7Nk+HEPGlRdwYeAfniDXkm5SeAVihxSnzH8tbVTbA7BnB/gzGbknhQ+FpTXP+LSi6RuI6Mu97rYIAFbTM2IT0u+2ZhDHa4XZzjwXa704w/qRiTjevTJI5uEJeICwLSCgoayKWAEAbOGW7sLF6M1MHYVBFVm6XuKD/Bvc2SMZNS6ZhETNGzxcNhF8blgVLMgDTKOPCfbc19J9h7IBcYUzD+gmbXreGak3R7EnEBHUlA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jXHBm0DxwvA7bhAXyTYhV4GhBQGPUmRKRA0ZUZsUALs=;
 b=NTrhnjZTeSELINF4i7Lr04oVoaDz4JDG3QkwEAIi5NhbX+CDKYfENVb3Udj5MxsIyGovdWcMRbf0sWuMJwJAzcZ2A1zlFkVKj9T7uyb24HCWT0Iczf9WyGP5a14joGN4NrDYP0BJnaEpKIITiaeVtmx2Hs5c4ZEghWWYAp0zXjMB4wHym88hn6Y27+onbThTb/hXNWBeJ098qLTr48zUOaDytrtDdKDcdg1kDzijGyyrgcR4ujljuGZzVt0ubOrwWFWS6UiG0Xi1CLRo3lNc1HnSAy/rLVuHvyxRLtAxOfo0UYCslkuimLJXVLbyBQRLv4P/8fRmDbGPmw2WDyxtug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jXHBm0DxwvA7bhAXyTYhV4GhBQGPUmRKRA0ZUZsUALs=;
 b=w1eb76gXUc0sH/3/UEiD59suVitQhsb1bLiywWUkLBKFtHHqZySXGfCPlVIzA/ECAmRUIzlW9qTLKgFU1AbHwthjDyLtl6E1BXi7tVlNkLzseq38fxovMQb8HX7HrJH9VnQsB5tuxEc3cimF+A9m9lxhQiBkH7ViYRqdHKw524c=
Received: from DM6PR12MB4603.namprd12.prod.outlook.com (2603:10b6:5:166::11)
 by DM6PR12MB4297.namprd12.prod.outlook.com (2603:10b6:5:211::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3977.26; Fri, 26 Mar
 2021 06:51:21 +0000
Received: from DM6PR12MB4603.namprd12.prod.outlook.com
 ([fe80::69b7:e163:347a:ba70]) by DM6PR12MB4603.namprd12.prod.outlook.com
 ([fe80::69b7:e163:347a:ba70%6]) with mapi id 15.20.3977.029; Fri, 26 Mar 2021
 06:51:20 +0000
From: "Xu, Feifei" <Feifei.Xu@amd.com>
To: "Lazar, Lijo" <Lijo.Lazar@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amd/pm: Fix DPM level count on aldebaran
Thread-Topic: [PATCH] drm/amd/pm: Fix DPM level count on aldebaran
Thread-Index: AdciBab3KsDuQMVmSd2h29lLgLBNeAABsDtw
Date: Fri, 26 Mar 2021 06:51:20 +0000
Message-ID: <DM6PR12MB4603CD531249422165C70F34FE619@DM6PR12MB4603.namprd12.prod.outlook.com>
References: <MN2PR12MB45496022CDFAACE2E5E2FF8197619@MN2PR12MB4549.namprd12.prod.outlook.com>
In-Reply-To: <MN2PR12MB45496022CDFAACE2E5E2FF8197619@MN2PR12MB4549.namprd12.prod.outlook.com>
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
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [180.167.199.189]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: e8dca0f7-2adc-47f9-0742-08d8f0239065
x-ms-traffictypediagnostic: DM6PR12MB4297:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR12MB429781471F721C8EEA934DCAFE619@DM6PR12MB4297.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2803;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: CtOhXog8y4U74Ai3jhBWM8oUfUHBtPeY4KEj0Wap86tLXxiUn+O27OaNOiP25qfi3R3/V9jhReypjUDaup9xgt2IgIYWkAtmUY5pot7aNgS4cvkM4ig+abfnVosVLBlWzib9kKO8FdFy1phiP0EVA3EKMZVcI8o1ZjplPohu/fpmIhZjPd+vg0bHq4NHFU6KSgM8gtCHJY/G3blS72IJWBGh2Hfgh75cFn6r7XQ/OkOCwwNW1rxImcUKI7N7O28BcPCe9vkkOGLJzp169p9n7x7gho/wvq3OIUxCSAf6ICKx9wlQI6qEE9W9BHzLt94WLtN+rvmG2HnMyFvLBySsa3QbjHCnDedTWnXgkfOBO2eNnJ8JoN+ryhAfB51eXeVpNvOXMXDxdai/H0oOaHE6U+MxIE/7LWcYUFKeKOtuiPQKV0pUTM5b+ojwR1rE2gml24D4vrUAsOKfyoV9iVrIIu7CCDWZ8AKys1ql5PJ9i/vqUntb18c8EfWoHQp2uXeuU5ED2TR5FnCCMrkWxOZMijR/YWAx/d/jrq4yODzRIfjHGLZhk7cZQbbb0KhtzIbjaPGzsTlM+9L3upfjs3vI2EB10bYDBGD6TxlZfD7L5sSLMmBk+OLYAawbbT/dm2vGEhsJGsAeQ9uLO9FJ1nMJfs3amk4WigzKMLiTLkuU4PE=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB4603.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(39860400002)(396003)(376002)(346002)(136003)(76116006)(64756008)(66446008)(66556008)(66476007)(66946007)(5660300002)(8936002)(52536014)(8676002)(2906002)(26005)(9686003)(86362001)(4326008)(186003)(71200400001)(55016002)(33656002)(6506007)(53546011)(83380400001)(478600001)(54906003)(110136005)(316002)(7696005)(38100700001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?8veZug0sjgfJ4Piil6esuT+lTFYBWcyAZSYYIzZZ9LsE9FyH02a7fq+fxuTP?=
 =?us-ascii?Q?gP1tGyw8tqhxu1Z79J4rykgOO+keuekJjbKx/P0/JrwEU6Lo9tBNw3va4t6e?=
 =?us-ascii?Q?nD9ggUW3cmXf91P7bPmGXcLSbu1IoStgoeYTLTgE62LXo7a/P9eoJ8VL50df?=
 =?us-ascii?Q?6XPNn/o9IFBWiRZoeQ4A08JP1Y1Ff1Rkp5BFAkxgXp8tQgph0nUVRqPiAEkY?=
 =?us-ascii?Q?irPsGOsshFpTWhvuf9GmHx/bxD50EPOYy9h3I36BeOIIkdEnTNLbsfwi7Zhx?=
 =?us-ascii?Q?WAioR2MKCERaSzJWuD6HegWKI2KULXFo6n8xd2KfDb9p4wga/Dx8ZPXnN2rF?=
 =?us-ascii?Q?XPZ24lC59u66LU1/2QmOmBFvqlqxwj1icPDSzfYjYJx8Hmzr7IwOyJfI1qIx?=
 =?us-ascii?Q?ImMMbwhZbZYWlYMRPZhjqmhXaKSanUSdTCruMKPWtkCy/Pxx0J5CH+OceCC0?=
 =?us-ascii?Q?ge3PHxBoM91UBFYfidEnguYGaTyYmglj+Yex3T8Q/PiE2pA12hGajzOSCHbP?=
 =?us-ascii?Q?g4e3M0WiBozySiMPDZ80fc5e8vLNujz9XeModAs7hpn8G74ZzBsHlh72u79n?=
 =?us-ascii?Q?cnMXiOgRa+JyQd47klhyyXg/vn6gzZbOnLR+do63gAptz4P5SgtclFGHo87k?=
 =?us-ascii?Q?Gq3F27sBjTFRfhX2VNypiz9RBwm4krO2KzlM19PTyuP1EDQQnA+Serw+wGgI?=
 =?us-ascii?Q?kUTkdGx1socc5qFR0kE7lO5y95L3J+/BkIq9PqKYIRzXaQiXUPz3jUKe7Bca?=
 =?us-ascii?Q?/Zp45m90fQPcNW2Vk0S/pL1f0iDT7OWE7QJ7HdGODvPeT2dkpE/B//XwB8Q6?=
 =?us-ascii?Q?BMvXzJPRgpqa67JzAIBa2kUMjDE3ysDq4Rc9XYvDY7W6LG2ZfeJy1exfOEC1?=
 =?us-ascii?Q?6JqG5lbdIs+DyUbaZizKVbsyafGYCCGvFAupzZlORzvbZ9GeB27osqGgYBxN?=
 =?us-ascii?Q?ecKxUgkHWLPKyjugZqrnTBhpIvUOpob8NQ39hkgmZ0dbzMsK/42iD3xQBU6i?=
 =?us-ascii?Q?lnVjJVzklQtKBTC2mlE35DwNIhQ9Nl+rKT8c3vzlZlE4cSX8pOko0+1ezbXL?=
 =?us-ascii?Q?YjQhy9nTbdBjyL/9Xqn90RAKM7ieWNiNAQIgEaxMb41JWHZlMXf3y83bYIIF?=
 =?us-ascii?Q?ixo2QUNd7BPOcDmpSF3w1ZY7KrRaTOCLMrMBILFBniKby+YA5n2VxljT/Nhn?=
 =?us-ascii?Q?chNKLF7AhSvqvIeiLDTDNYBNXIPLTb8l7K8FO92sLKnt3HlPmuI3C0wB5ogV?=
 =?us-ascii?Q?LJ84KY05z7XFNkGMZw+Z6gjoiNafr5UJaZ9z8JbosgdafGlCtN0e0mJbeQBk?=
 =?us-ascii?Q?bAgeWpinvzTkymdOD+h+h5iz?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4603.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e8dca0f7-2adc-47f9-0742-08d8f0239065
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Mar 2021 06:51:20.8377 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: LU1HHhZCmzNYD93euOm+iZS5GJP1vL+ZNDnKZpY3XY2BnHkfaX277cJfWmgOVWlt
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4297
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
Content-Type: multipart/mixed; boundary="===============0716396924=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============0716396924==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_DM6PR12MB4603CD531249422165C70F34FE619DM6PR12MB4603namp_"

--_000_DM6PR12MB4603CD531249422165C70F34FE619DM6PR12MB4603namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable



Reviewed-by: Feifei Xu <Feifei.Xu@amd.com>

From: Lazar, Lijo <Lijo.Lazar@amd.com>
Sent: Friday, March 26, 2021 2:04 PM
To: amd-gfx@lists.freedesktop.org
Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Xu, Feifei <Feifei.Xu@amd.com>;=
 Feng, Kenneth <Kenneth.Feng@amd.com>; Wang, Kevin(Yang) <Kevin1.Wang@amd.c=
om>
Subject: [PATCH] drm/amd/pm: Fix DPM level count on aldebaran


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


--_000_DM6PR12MB4603CD531249422165C70F34FE619DM6PR12MB4603namp_
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
<b>Sent:</b> Friday, March 26, 2021 2:04 PM<br>
<b>To:</b> amd-gfx@lists.freedesktop.org<br>
<b>Cc:</b> Zhang, Hawking &lt;Hawking.Zhang@amd.com&gt;; Xu, Feifei &lt;Fei=
fei.Xu@amd.com&gt;; Feng, Kenneth &lt;Kenneth.Feng@amd.com&gt;; Wang, Kevin=
(Yang) &lt;Kevin1.Wang@amd.com&gt;<br>
<b>Subject:</b> [PATCH] drm/amd/pm: Fix DPM level count on aldebaran<o:p></=
o:p></p>
</div>
</div>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"msipheader251902e5" style=3D"margin:0in"><span style=3D"font-si=
ze:10.0pt;font-family:&quot;Arial&quot;,sans-serif;color:#317100">[AMD Publ=
ic Use]</span><o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
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
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">&nbsp;int smu_v13_0_set_single_dpm_table(struct smu_=
context *smu,<o:p></o:p></p>
<p class=3D"MsoNormal">-- <o:p></o:p></p>
<p class=3D"MsoNormal">2.17.1<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
</div>
</body>
</html>

--_000_DM6PR12MB4603CD531249422165C70F34FE619DM6PR12MB4603namp_--

--===============0716396924==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============0716396924==--
