Return-Path: <SRS0=UsYE=JJ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75988C433B4
	for <amd-gfx@archiver.kernel.org>; Mon, 12 Apr 2021 06:51:15 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3FB936120B
	for <amd-gfx@archiver.kernel.org>; Mon, 12 Apr 2021 06:51:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3FB936120B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EBE7A6E13A;
	Mon, 12 Apr 2021 06:51:14 +0000 (UTC)
Received: from NAM02-BL2-obe.outbound.protection.outlook.com
 (mail-eopbgr750054.outbound.protection.outlook.com [40.107.75.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CB93C6E13A
 for <amd-gfx@lists.freedesktop.org>; Mon, 12 Apr 2021 06:51:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MKBp8HOcw2kPhjQcV2jBUV83opRNzyivWdj4zY0d0ZfMHCllpePUJbly/zreS+bPQFufVIIfUb5DM/sjuKNSdNyhF8aJWdyFZuMs1+HQN/NtzmPmQegsqyDhZtuV+AT4IBsDbEfMhsrHcf+7ktCNctmcx8A/SVIzmOThU62OC3BMSkGdVhsDt2DVtztFjcK2GqK5GCQDTt1ly0cJ+5QRiymKBP8fiV9EEq69MhTrFYwpbID7Rf+9tB8/44uY1GI1hih48fxubKyzbJgZJYR3+IBUFUZeW6PK1Qm4bKP7/f5Jzm58U5iJmJUTGPEnHcNS1p7YJEl4gai6MUhi+nur1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4lSbRgHn0Q+eJ5yPJ1QSGpr2QNdlPFWRyc8WeMcvMJg=;
 b=Ac0geta5w2Tdnm+8bNHEyGKbvIp9UVUQbH/3CsKxr2sMkLDR6myAK9mo/CaRN6jgy3s8JTb1qSoxAolQzjxIbnsFhZPEUcdnChgdlDvKgIzPI1HAaMxQhaq2X2ALgFyhZE7LQje1y8IbKcQFeFaQPhGkpOEAjwe69KsBh+LGTR+oTwOjZwcdopIG+cpuwerD3xVzTrcbUMgqZv+FwP4FYCkYSfp1wdFXkGfHTh08EJokTDOnO2QoyZSckFMr9g1LEK1IFBQbZPCKMpOX3aBJ+3u0s05eTL73POcmIA5dz70loyZOBOL+mLIsLMs1m1a9QedYomhUd+LqQLMlGAjifw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4lSbRgHn0Q+eJ5yPJ1QSGpr2QNdlPFWRyc8WeMcvMJg=;
 b=qUU2/c1uBqVZofiyTTKrOoRUPXy4pHQTt1F026rpy2piTH8AvvQqqiDnv6Cp0w826LBNeedU2nwjHkOvpM2gUHKFDViHIY4TJcJJ9GWRnERt8rZcOG0r4UeveYzUUB1XfVeu/vgsPbnVTXRQTFv6l77S83PNo7rdMYhvPJ9dsoA=
Received: from DM6PR12MB4075.namprd12.prod.outlook.com (2603:10b6:5:21d::8) by
 DM5PR12MB1707.namprd12.prod.outlook.com (2603:10b6:3:108::21) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4020.17; Mon, 12 Apr 2021 06:51:11 +0000
Received: from DM6PR12MB4075.namprd12.prod.outlook.com
 ([fe80::c950:d447:1fd0:2686]) by DM6PR12MB4075.namprd12.prod.outlook.com
 ([fe80::c950:d447:1fd0:2686%5]) with mapi id 15.20.4020.022; Mon, 12 Apr 2021
 06:51:11 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Lazar, Lijo" <Lijo.Lazar@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amd/pm: Use VBIOS PPTable for aldebaran
Thread-Topic: [PATCH] drm/amd/pm: Use VBIOS PPTable for aldebaran
Thread-Index: AdcvYcvnGouKBqz9SOC8GbANB1m7RgABjz5Q
Date: Mon, 12 Apr 2021 06:51:11 +0000
Message-ID: <DM6PR12MB40755F966B69B6B9BABEB4BBFC709@DM6PR12MB4075.namprd12.prod.outlook.com>
References: <MN2PR12MB4549536629A4C68E418BA83097709@MN2PR12MB4549.namprd12.prod.outlook.com>
In-Reply-To: <MN2PR12MB4549536629A4C68E418BA83097709@MN2PR12MB4549.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Enabled=true;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SetDate=2021-04-12T06:51:08Z; 
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Method=Privileged;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Name=Public_0;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ActionId=80f1b83c-a987-4700-8978-1b715d52c242;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ContentBits=1
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [180.167.199.189]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e0f15e25-ef72-4ed5-ddce-08d8fd7f5bcf
x-ms-traffictypediagnostic: DM5PR12MB1707:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM5PR12MB1707EF10ABF9B46BA777EE13FC709@DM5PR12MB1707.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5516;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 4ZFGWsNOxQC3pWbdgV3BdG7EsRoIv79VMSLEH8GKeWw6tFW2csl9o9ojQGD3YsL1yVQ6ajBwissE/gUj1+2bYq4D7FRbu5NkzmoLIzBrKIigTs7DQbeWmQQcYaFehkIiAFMO05NQdWpOxXxGktYO037W+gVE6UXWe3MjYqTPoRQEsP6OhsTB/3H/Kp3CUrN1F7BkR6WrX1/oMed5tbY3ovteh/uuplDOd38Np3m4jTFF/y4AZTrGMLQJSY5ob++oiW/VA17R59iUhRa64/14p1K9k0+zd8zENUaS4LESqpKWhrcRGGaqOEleEq1LTkhQcHHI4aLt9DbNvFCvc3RiID+Y9kj+U5bfKzjne9xXD6LT0a8DM8iCnfQzRFnbBDz3PITgovPGoJhHTz1PHcBs03h2u7QOj0mOfB6gXxNM6Bx6WpUm2sQvKQVWqhIFPBARhVEQohH9ChtWGGApUD+89/rlv6VwyRXmLTK1Y0bMsu1vh2SLdtRQ4/VcivG5KTsv6S0cq12CLUv8KhlY3ctourZKXo97p0RnRIkpu+n0Im9rT40bF+p3L8vIUK8xYBiMxTY9+uM+tleifP0jW8X9J57iu7YAHRpmnWXGUxcvLAs=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB4075.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(39860400002)(396003)(346002)(136003)(366004)(7696005)(53546011)(55016002)(83380400001)(86362001)(110136005)(66446008)(6506007)(52536014)(71200400001)(2906002)(33656002)(316002)(186003)(9686003)(76116006)(66476007)(64756008)(66556008)(38100700002)(54906003)(66946007)(8676002)(4326008)(478600001)(5660300002)(26005)(8936002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?E1oVPqM4+dS75k99ZlzNljiEcUa9vpzxbwvlvJMPDU0N+bMnzXSdGPSdbhwz?=
 =?us-ascii?Q?1HO0/I509IA7xa7ToS4DW05sPkKFsSkocLy3UZX/ZhPHvq/rq5CfCycV8qKX?=
 =?us-ascii?Q?uCtgpJwT9gcQwZqLWqk8M0tu30X3VxBqLDVb0KyH8t0hBJrpzCOIXgGyyBGO?=
 =?us-ascii?Q?Ce+wmGZE9CXMCbiBHKMcIi+OG0vCfB4IzufRFWM9PyPSrCXoJqka4yow1fqP?=
 =?us-ascii?Q?1DKMF4XVqLoDUXSzsx+kGYh3keWxtM5tyj+DmDy/G+/1Xe+drKBBpMjmaWu9?=
 =?us-ascii?Q?1LPbQsJs5I6Cnov84jMlM+QpvRHa86TE4O+NLCf7+4SXx5nWbAMVRfUKYERs?=
 =?us-ascii?Q?xKXkRHJHcEGNsMkWHwtqn8ExrWpkb2W5JIGz3xZTENhmfzoOH0aGQM6eG3de?=
 =?us-ascii?Q?e3MYLRSn9EPbNDTnT0/zExJ9hvobGb4FMuT7ryxtFS2tiqSGld7N9Tzznc33?=
 =?us-ascii?Q?2f3O+aWa84mD7Ly+bxwZeI7dv8d3SBhk3/WCc6ei3Fi0HNghqywxcGqpIDLh?=
 =?us-ascii?Q?ITB70DOngNJ9d//w2D7D6p2QocSEFdFTnTOAdQNuatxMUndKa7ToFPyo2V19?=
 =?us-ascii?Q?pOccDuaM06GGaNnYbpte49fDJQ+EaLHHuxPxPgV6Vq2+sSfCtTH7IY5N+AlB?=
 =?us-ascii?Q?mgu8VG9WDSW7w83uoCRyxxWZguomu27xjtJcjaHIS1lM7i1/16W6Op52s3rR?=
 =?us-ascii?Q?6nj6ERvMw3cThcn+vLPLy21Z4w7gtjTxsawT8ZxFEdnrl4o5lcXFGvQmQxAG?=
 =?us-ascii?Q?gpDyBDdqs9bg5IaZe/3C0vrpInJB/EuYwojH4oHZLLbyDXmTnBku201lSqfh?=
 =?us-ascii?Q?XfWZK/KI7Xu7AAnZM1f0MhRMFMr8+/mVE5iRdQn8vZuXeOjyfilStH7h7xtA?=
 =?us-ascii?Q?OCTM7KpCF2pA+ZPQDMEK38UXzbqiu/P48730G8MlrCmFPzX7NSnLFuPcoyTP?=
 =?us-ascii?Q?3iV5DuofBAyN6o2eI2rKiv7W1wnZJ094ZZdBKKYM8TjnxuNVniksOUWdxazB?=
 =?us-ascii?Q?ZrzSuaP0noOoqzuD1NUTXAZOgAKYAD4VDGPIapuQBupwuA3CoIyU2VYLM0H3?=
 =?us-ascii?Q?9NxWIhZAmlfByKOGRp4YmnMH1hwhMuHzVh3pVcu3OVdhmhePEoTdbZJr3Kdc?=
 =?us-ascii?Q?omyKkcYSb5jwC8xq8sXC21IvAS2pH3SCVh3BwNTJa9XUCOgq08a/Hkr4Kq3R?=
 =?us-ascii?Q?s1zcm74ACP0ZX5WLmc9VqYufUnJroYVMXBlFKac4xNV+zrW5a2DHcyq+Q+Y5?=
 =?us-ascii?Q?j6VYF8aveG1687b3E14AQQrTGj3zPXXjvlvDY+rSrwVzUYUVMVGlzAAkYAvG?=
 =?us-ascii?Q?vjiXqfTBJWSLmL8cnV9WUVJx?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4075.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e0f15e25-ef72-4ed5-ddce-08d8fd7f5bcf
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Apr 2021 06:51:11.4554 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9sibaXbfjp2YlFJx6+4NnJkp4LKxJ45V7NnSKif6gENpqrQmDW8lmnNLf6L91PsyRBns2gNmO+Ukl0+ThWl15g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1707
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
 Kevin\(Yang\)" <Kevin1.Wang@amd.com>
Content-Type: multipart/mixed; boundary="===============0917665238=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============0917665238==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_DM6PR12MB40755F966B69B6B9BABEB4BBFC709DM6PR12MB4075namp_"

--_000_DM6PR12MB40755F966B69B6B9BABEB4BBFC709DM6PR12MB4075namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[AMD Public Use]

Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>

Regards,
Hawking
From: Lazar, Lijo <Lijo.Lazar@amd.com>
Sent: Monday, April 12, 2021 14:06
To: amd-gfx@lists.freedesktop.org
Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Xu, Feifei <Feifei.Xu@amd.com>;=
 Wang, Kevin(Yang) <Kevin1.Wang@amd.com>
Subject: [PATCH] drm/amd/pm: Use VBIOS PPTable for aldebaran


[AMD Public Use]

Keep the logic to force-use VBIOS PPTable in aldebaran rather
than in generic SMU13.

Signed-off-by: Lijo Lazar lijo.lazar@amd.com<mailto:lijo.lazar@amd.com>
---
drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c | 3 +++
drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c     | 2 --
2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c b/drivers/g=
pu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
index abe80226a0ee..af6e0ce9b6a7 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
@@ -407,6 +407,9 @@ static int aldebaran_setup_pptable(struct smu_context *=
smu)
{
               int ret =3D 0;

+             /* VBIOS pptable is the first choice */
+             smu->smu_table.boot_values.pp_table_id =3D 0;
+
               ret =3D smu_v13_0_setup_pptable(smu);
               if (ret)
                               return ret;
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c b/drivers/gpu/d=
rm/amd/pm/swsmu/smu13/smu_v13_0.c
index 30c9ac635105..0864083e7435 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
@@ -276,8 +276,6 @@ int smu_v13_0_setup_pptable(struct smu_context *smu)
               void *table;
               uint16_t version_major, version_minor;

-              /* temporarily hardcode to use vbios pptable */
-              smu->smu_table.boot_values.pp_table_id =3D 0;

                if (amdgpu_smu_pptable_id >=3D 0) {
                               smu->smu_table.boot_values.pp_table_id =3D a=
mdgpu_smu_pptable_id;
--
2.17.1

--_000_DM6PR12MB40755F966B69B6B9BABEB4BBFC709DM6PR12MB4075namp_
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
span.EmailStyle19
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
<p class=3D"msipheader251902e5" style=3D"margin:0in"><span style=3D"font-si=
ze:10.0pt;font-family:&quot;Arial&quot;,sans-serif;color:#317100">[AMD Publ=
ic Use]</span><o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Reviewed-by: Hawking Zhang &lt;Hawking.Zhang@amd.com=
&gt;<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Regards,<br>
Hawking<o:p></o:p></p>
<div>
<div style=3D"border:none;border-top:solid #E1E1E1 1.0pt;padding:3.0pt 0in =
0in 0in">
<p class=3D"MsoNormal"><b>From:</b> Lazar, Lijo &lt;Lijo.Lazar@amd.com&gt; =
<br>
<b>Sent:</b> Monday, April 12, 2021 14:06<br>
<b>To:</b> amd-gfx@lists.freedesktop.org<br>
<b>Cc:</b> Zhang, Hawking &lt;Hawking.Zhang@amd.com&gt;; Xu, Feifei &lt;Fei=
fei.Xu@amd.com&gt;; Wang, Kevin(Yang) &lt;Kevin1.Wang@amd.com&gt;<br>
<b>Subject:</b> [PATCH] drm/amd/pm: Use VBIOS PPTable for aldebaran<o:p></o=
:p></p>
</div>
</div>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"msipheader251902e5" style=3D"margin:0in"><span style=3D"font-si=
ze:10.0pt;font-family:&quot;Arial&quot;,sans-serif;color:#317100">[AMD Publ=
ic Use]</span><o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Keep the logic to force-use VBIOS PPTable in aldebar=
an rather<o:p></o:p></p>
<p class=3D"MsoNormal">than in generic SMU13.<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Signed-off-by: Lijo Lazar <a href=3D"mailto:lijo.laz=
ar@amd.com">
lijo.lazar@amd.com</a><o:p></o:p></p>
<p class=3D"MsoNormal">---<o:p></o:p></p>
<p class=3D"MsoNormal">drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c |=
 3 +++<o:p></o:p></p>
<p class=3D"MsoNormal">drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c&nbsp;=
&nbsp;&nbsp;&nbsp; | 2 --<o:p></o:p></p>
<p class=3D"MsoNormal">2 files changed, 3 insertions(+), 2 deletions(-)<o:p=
></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/alde=
baran_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c<o:p></o:p>=
</p>
<p class=3D"MsoNormal">index abe80226a0ee..af6e0ce9b6a7 100644<o:p></o:p></=
p>
<p class=3D"MsoNormal">--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_p=
pt.c<o:p></o:p></p>
<p class=3D"MsoNormal">+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_p=
pt.c<o:p></o:p></p>
<p class=3D"MsoNormal">@@ -407,6 +407,9 @@ static int aldebaran_setup_pptab=
le(struct smu_context *smu)<o:p></o:p></p>
<p class=3D"MsoNormal">{<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int ret =3D 0;<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; /* VBIOS pptable is the first choice */<o:p></o:p></p=
>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; smu-&gt;smu_table.boot_values.pp_table_id =3D 0;<o:p>=
</o:p></p>
<p class=3D"MsoNormal">+<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D smu_v13_0_setup_pptable(smu);<o:p>=
</o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (ret)<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return ret;<o:p></o:p=
></p>
<p class=3D"MsoNormal">diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_=
v13_0.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c<o:p></o:p></p>
<p class=3D"MsoNormal">index 30c9ac635105..0864083e7435 100644<o:p></o:p></=
p>
<p class=3D"MsoNormal">--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c=
<o:p></o:p></p>
<p class=3D"MsoNormal">+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c=
<o:p></o:p></p>
<p class=3D"MsoNormal">@@ -276,8 +276,6 @@ int smu_v13_0_setup_pptable(stru=
ct smu_context *smu)<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; void *table;<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint16_t version_major, version_minor;<o:p=
></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp; /* temporarily hardcode to use vbios pptable */=
<o:p></o:p></p>
<p class=3D"MsoNormal">-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp; smu-&gt;smu_table.boot_values.pp_table_id =3D 0=
;<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (amdgpu_smu_pptable_id &gt;=3D 0)=
 {<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; smu-&gt;smu_table.boo=
t_values.pp_table_id =3D amdgpu_smu_pptable_id;<o:p></o:p></p>
<p class=3D"MsoNormal">-- <o:p></o:p></p>
<p class=3D"MsoNormal">2.17.1<o:p></o:p></p>
</div>
</body>
</html>

--_000_DM6PR12MB40755F966B69B6B9BABEB4BBFC709DM6PR12MB4075namp_--

--===============0917665238==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============0917665238==--
