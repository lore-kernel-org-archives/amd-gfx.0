Return-Path: <SRS0=0XED=GC=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EB94C433DB
	for <amd-gfx@archiver.kernel.org>; Wed, 30 Dec 2020 18:03:16 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 06B29206FC
	for <amd-gfx@archiver.kernel.org>; Wed, 30 Dec 2020 18:03:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 06B29206FC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 872D689193;
	Wed, 30 Dec 2020 18:03:15 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2074.outbound.protection.outlook.com [40.107.223.74])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1AB5E89193
 for <amd-gfx@lists.freedesktop.org>; Wed, 30 Dec 2020 18:03:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ADjnOr6iujVTS6zyETAniez+dkOcsRledrD9bYqOlF1zOVmnb0Y6LbsaadZ+doYBormNHdOL50NAX7z1rHatmJq1K5yzTzaWSuFi8LILkZoYnZzkOU3Jq74eX7VXdp4F3HkhpJOM6kUH/wuHPIF1LFyLSlew19MwR7OTh5zOr6pGldA96HHBzZyAS7dUCl4l6u377bcbSMBjXzqvCnGMaFwkLjCvQ0UxSGvwcadV4n2rpw/TDwISm85EvC5t8hYoQsfndDBTIBELtsRG1s5SuGjq595py/zcYosyofmcsaPs2rUzzwWoJNumLn1Z8Yqao0nDuvCDWxGaC13XvLreAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L+pKA7ac9FoGSfp9xFjiGpnN2HvgiGr4m8mT8WyB9bQ=;
 b=oOkN1xem5R3NkzsNUJlfQSApVz0PkNkzohtypvcrWAcLqrg6kB+nGtYzEjkivYBkQtVF+WQCioqXvovPX2/vZmBxuUMeORX1CE6X5o33RDfPBflX3ImbaFFUJoONIZKaTg8g2QDswtSZni6r9sThKdsoZ+f2GlDM+n4R/+LvjGUcAJIjFePg9YsI0QYDeQ0Z4au3VbrZxbiM4Mo7HaqE0YqCGiuYMzc0eiyRVkejS3vhfPaTA82P4AC3Vq8FgFLZlUyqILtMIJCsKF+SnqDJhVuwiq63+EwMaLAqU0Xgx47sitw5cHX3ouTXfQpFd29GqB80RivXdCURdXnoG1atzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L+pKA7ac9FoGSfp9xFjiGpnN2HvgiGr4m8mT8WyB9bQ=;
 b=t+kpfbcIcHZxXWoI8nsuTs3gqEt2tk8TwOjYP1c1Ad36z+0JpQLx7JP6O21ybFvc4sbbh6so/iIPCnRBmtfBQbDRAd0x/nhczPannZWXY4M9VT/CfkM52Op/555cMuUu5vIczd0DP1ADvzXwuXt7b5TecZz6DsOmExLsj07Nv5I=
Received: from MN2PR12MB3198.namprd12.prod.outlook.com (2603:10b6:208:101::12)
 by MN2PR12MB2894.namprd12.prod.outlook.com (2603:10b6:208:10a::27)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3700.31; Wed, 30 Dec
 2020 18:03:02 +0000
Received: from MN2PR12MB3198.namprd12.prod.outlook.com
 ([fe80::217f:e1ff:9766:e78c]) by MN2PR12MB3198.namprd12.prod.outlook.com
 ([fe80::217f:e1ff:9766:e78c%7]) with mapi id 15.20.3700.031; Wed, 30 Dec 2020
 18:03:02 +0000
From: "Li, Roman" <Roman.Li@amd.com>
To: "Wu, Hersen" <hersenxs.wu@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>, "Deucher, Alexander"
 <Alexander.Deucher@amd.com>
Subject: RE: [PATCH] drm/amd/display: disable dcn10 pipe split by default
Thread-Topic: [PATCH] drm/amd/display: disable dcn10 pipe split by default
Thread-Index: AQHW3szJ9p//noNmJkKEV5oLNQFPeqoP7S3w
Date: Wed, 30 Dec 2020 18:03:02 +0000
Message-ID: <MN2PR12MB3198E21B95D39C8B1561D73B89D70@MN2PR12MB3198.namprd12.prod.outlook.com>
References: <DM6PR12MB415686CF8CCA926086E15F52FDD70@DM6PR12MB4156.namprd12.prod.outlook.com>
In-Reply-To: <DM6PR12MB415686CF8CCA926086E15F52FDD70@DM6PR12MB4156.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Enabled=true;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SetDate=2020-12-30T18:00:25Z; 
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Method=Privileged;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Name=Public_0;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ActionId=173aa68b-25cc-438f-a034-7609dc6638a6;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ContentBits=1
dlp-product: dlpe-windows
dlp-version: 11.5.0.60
dlp-reaction: no-action
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [165.204.55.250]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: a822e69e-5866-4b22-ebde-08d8aced26a2
x-ms-traffictypediagnostic: MN2PR12MB2894:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR12MB2894CD0FBD8115E7C058C18589D70@MN2PR12MB2894.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:400;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: IeFl4TsusCW1bfJaUVO6OInJY7qm4rDbryFN/r976Q8aIUlNOYuY7aIHXfRhfzzGtvWJIfN72gEqTBrYdbmpb2n3IZlZlxcF0DbJR8fOqot99dDqv1DZSRQXeqyuFlSWRnQNngL3rxzUU3VmTjvzRgcbuLRZuZGuZbPfFdeQdyZHWiSXsqqD8m0cHjSDGahnHoTsGFAKao6c9x0E5MBqUat3W4OdHwMejflngVXXUTc8tg8myZf1fsBL1oR0FKPp7c7KQRyywRfBIfdBBAzOtSMdxz/hL3V8oiw/DLZhcP4pNFa0ulZw050c4QoVsN/W2d7xcNE880j801xST18bmV0KKv3Oz7KXI5ZqBliiqgpB0UZuz5TV/ErZAXhj581gnCutQ/liVIE4WcDZWrSGoA==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB3198.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(39860400002)(346002)(396003)(136003)(366004)(83380400001)(55016002)(76116006)(33656002)(53546011)(86362001)(6506007)(26005)(71200400001)(110136005)(5660300002)(8936002)(66556008)(186003)(8676002)(316002)(2906002)(7696005)(6636002)(64756008)(52536014)(478600001)(66946007)(9686003)(66476007)(66446008);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?pWZS0JJzk+kUI9VWj94ee1BTctORa7+mmVeXUJDqhmfOGZgVwwpYkBRjcesM?=
 =?us-ascii?Q?uWe2phgkyBZDN3sEMHEJ2o1eDRAmEvPDX9vbLEleq1QPkKz+BB2F0L/nqYss?=
 =?us-ascii?Q?JFQ3/7ukKyYc3DxnJXaZxiaUdfvjYR8pqTWXVXiXS38WkiK1G6bKtPZVNAiu?=
 =?us-ascii?Q?y4WKBtTGlfOEyRPHFv2OlKDjikYL9wwc3uD9Wn6U5rOAH82Gy3QeYp8PFRf+?=
 =?us-ascii?Q?ooieZm5HEzS+ylABINX289+rA2lSnl1cdoccVKrd9UdvAUiUcdvEqvCE2TfC?=
 =?us-ascii?Q?gShFyW2p0FFbgS+wMLM7YdPOSDwySkhKl4Qj+06u6L5sgCvGkt6QPzMiF20a?=
 =?us-ascii?Q?4nS7P6Vmn+v1HHd1CLCNIuVPfDFbpcQU1pligRBsU2jqQUwEDct7kyv7lgAF?=
 =?us-ascii?Q?omQJSIqxaQotrWctmxag7MYQbZjUBb7oQeAKLbod0u39bOZl8FVj/9nzH1wV?=
 =?us-ascii?Q?4yOGRZyPHNr9cAIUMQDbWjC1BiVOllJYfh/cG0ksIuZA/K7bJrAAt1OR3nSj?=
 =?us-ascii?Q?kjWO84HEkhJRS8c6yaibAxsV8szXws/+Tf4B5LX3U09rP5vpwRkpLMIP+Gin?=
 =?us-ascii?Q?aAbqVdvlrRSTwJQpt7ZNjmLuoYnBGmYy8w8jS2NKC9p60ywXZnU9tC8YkSC9?=
 =?us-ascii?Q?SisHz1PoKfYHuceAbboxqgy9oE4JIjy2NhCs0OOUcU6l+QdNO42D9Pn/YS6C?=
 =?us-ascii?Q?93Y9ZzMRMKTWaM7j1kld3M30GuVW8vx3fJOAHXvbsUwLTXsVSFusCKtyb9uT?=
 =?us-ascii?Q?pnuiwPowUWp7Yk9ebNMceKqDgYweG9C0vyNPFTRvxYbC7iYBQkV3vnfvrxeO?=
 =?us-ascii?Q?OztMmlNTTs3yoEVPYZ++O3S1KXKeHP9FMb7i2pXGckVY4lruaE1ScFUqSiEh?=
 =?us-ascii?Q?k4sb3H28IOm22Gk9IYnWUw2Z2XYQ7CV0gBeXCcA2jZHBCRdHSvVjvUlt4Bz2?=
 =?us-ascii?Q?7qMyE/8hUCKUCBrHqK3xrBXEHaJvcAFfvrowlk4bP7o=3D?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3198.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a822e69e-5866-4b22-ebde-08d8aced26a2
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Dec 2020 18:03:02.7193 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Ic1ShbNwJKpXliobnthzkxu7DgF7j/Z4O+iFEKrAUKiydxOZ1O8hzvDXIZmPsY2C
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB2894
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
Content-Type: multipart/mixed; boundary="===============1460549626=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============1460549626==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_MN2PR12MB3198E21B95D39C8B1561D73B89D70MN2PR12MB3198namp_"

--_000_MN2PR12MB3198E21B95D39C8B1561D73B89D70MN2PR12MB3198namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[AMD Public Use]


Reviewed-by: Roman Li <Roman.Li@amd.com<mailto:Roman.Li@amd.com>>

From: Wu, Hersen <hersenxs.wu@amd.com>
Sent: Wednesday, December 30, 2020 12:12 PM
To: amd-gfx@lists.freedesktop.org; Deucher, Alexander <Alexander.Deucher@am=
d.com>; Li, Roman <Roman.Li@amd.com>
Subject: [PATCH] drm/amd/display: disable dcn10 pipe split by default


[Why] the initial purpose of dcn10 pipe split is to support
some high bandwidth mode which requires dispclk greater
than max dispclk. By initial bring up power measurement
data, it showed power consumption is less with pipe split
for dcn block. This could be reason for enable pipe split
by default. By battery life measurement of some Chromebooks,
result shows battery life is longer with pipe split disabled.

[How] disable pipe split by default. Pipe split could be
still enabled when required dispclk is greater than max dispclk.

Signed-off-by: hersen wu <hersenxs.wu@amd.com<mailto:hersenxs.wu@amd.com>>
---
 drivers/gpu/drm/amd/display/dc/dcn10/dcn10_resource.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_resource.c b/driver=
s/gpu/drm/amd/display/dc/dcn10/dcn10_resource.c
index bdc37831535e..17eafe209946 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_resource.c
@@ -608,8 +608,8 @@ static const struct dc_debug_options debug_defaults_drv=
 =3D {
  .disable_pplib_clock_request =3D false,
  .disable_pplib_wm_range =3D false,
  .pplib_wm_report_mode =3D WM_REPORT_DEFAULT,
- .pipe_split_policy =3D MPC_SPLIT_DYNAMIC,
- .force_single_disp_pipe_split =3D true,
+ .pipe_split_policy =3D MPC_SPLIT_AVOID,
+ .force_single_disp_pipe_split =3D false,
  .disable_dcc =3D DCC_ENABLE,
  .voltage_align_fclk =3D true,
  .disable_stereo_support =3D true,
--
2.17.1


--_000_MN2PR12MB3198E21B95D39C8B1561D73B89D70MN2PR12MB3198namp_
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
p.MsoPlainText, li.MsoPlainText, div.MsoPlainText
	{mso-style-priority:99;
	mso-style-link:"Plain Text Char";
	margin:0in;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif;}
span.PlainTextChar
	{mso-style-name:"Plain Text Char";
	mso-style-priority:99;
	mso-style-link:"Plain Text";
	font-family:"Calibri",sans-serif;}
span.EmailStyle20
	{mso-style-type:personal-compose;
	font-family:"Calibri",sans-serif;
	color:windowtext;}
p.msipheader87abd423, li.msipheader87abd423, div.msipheader87abd423
	{mso-style-name:msipheader87abd423;
	mso-margin-top-alt:auto;
	margin-right:0in;
	mso-margin-bottom-alt:auto;
	margin-left:0in;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif;}
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
<p class=3D"msipheader87abd423" style=3D"margin:0in"><span style=3D"font-si=
ze:10.0pt;font-family:&quot;Arial&quot;,sans-serif;color:#317100">[AMD Publ=
ic Use]</span><o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoPlainText">Reviewed-by: Roman Li &lt;<a href=3D"mailto:Roman=
.Li@amd.com">Roman.Li@amd.com</a>&gt;<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<div>
<div style=3D"border:none;border-top:solid #E1E1E1 1.0pt;padding:3.0pt 0in =
0in 0in">
<p class=3D"MsoNormal"><b>From:</b> Wu, Hersen &lt;hersenxs.wu@amd.com&gt; =
<br>
<b>Sent:</b> Wednesday, December 30, 2020 12:12 PM<br>
<b>To:</b> amd-gfx@lists.freedesktop.org; Deucher, Alexander &lt;Alexander.=
Deucher@amd.com&gt;; Li, Roman &lt;Roman.Li@amd.com&gt;<br>
<b>Subject:</b> [PATCH] drm/amd/display: disable dcn10 pipe split by defaul=
t<o:p></o:p></p>
</div>
</div>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:12.0pt;color:black">[Why] t=
he initial purpose of dcn10 pipe split is to support
<o:p></o:p></span></p>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:12.0pt;color:black">some hi=
gh bandwidth mode which requires dispclk greater<o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:12.0pt;color:black">than ma=
x dispclk. By initial bring up power measurement<o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:12.0pt;color:black">data, i=
t showed power consumption is less with pipe split<o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:12.0pt;color:black">for dcn=
 block. This could be reason for enable pipe split<o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:12.0pt;color:black">by defa=
ult. By battery life measurement of some Chromebooks,<o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:12.0pt;color:black">result =
shows battery life is longer with pipe split disabled.<o:p></o:p></span></p=
>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:12.0pt;color:black"><o:p>&n=
bsp;</o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:12.0pt;color:black">[How] d=
isable pipe split by default. Pipe split could be<o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:12.0pt;color:black">still e=
nabled when required dispclk is greater than max dispclk.<o:p></o:p></span>=
</p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:12.0pt;color:black"><o:p>&n=
bsp;</o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:12.0pt;color:black">Signed-=
off-by: hersen wu &lt;<a href=3D"mailto:hersenxs.wu@amd.com">hersenxs.wu@am=
d.com</a>&gt;<o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:12.0pt;color:black">---<o:p=
></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:12.0pt;color:black">&nbsp;d=
rivers/gpu/drm/amd/display/dc/dcn10/dcn10_resource.c | 4 ++--<o:p></o:p></s=
pan></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:12.0pt;color:black">&nbsp;1=
 file changed, 2 insertions(+), 2 deletions(-)<o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:12.0pt;color:black"><o:p>&n=
bsp;</o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:12.0pt;color:black">diff --=
git a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_resource.c b/drivers/gpu/d=
rm/amd/display/dc/dcn10/dcn10_resource.c<o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:12.0pt;color:black">index b=
dc37831535e..17eafe209946 100644<o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:12.0pt;color:black">--- a/d=
rivers/gpu/drm/amd/display/dc/dcn10/dcn10_resource.c<o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:12.0pt;color:black">+++ b/d=
rivers/gpu/drm/amd/display/dc/dcn10/dcn10_resource.c<o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:12.0pt;color:black">@@ -608=
,8 +608,8 @@ static const struct dc_debug_options debug_defaults_drv =3D {<=
o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:12.0pt;color:black">&nbsp; =
.disable_pplib_clock_request =3D false,<o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:12.0pt;color:black">&nbsp; =
.disable_pplib_wm_range =3D false,<o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:12.0pt;color:black">&nbsp; =
.pplib_wm_report_mode =3D WM_REPORT_DEFAULT,<o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:12.0pt;color:black">- .pipe=
_split_policy =3D MPC_SPLIT_DYNAMIC,<o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:12.0pt;color:black">- .forc=
e_single_disp_pipe_split =3D true,<o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:12.0pt;color:black">+ .pipe=
_split_policy =3D MPC_SPLIT_AVOID,<o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:12.0pt;color:black">+ .forc=
e_single_disp_pipe_split =3D false,<o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:12.0pt;color:black">&nbsp; =
.disable_dcc =3D DCC_ENABLE,<o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:12.0pt;color:black">&nbsp; =
.voltage_align_fclk =3D true,<o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:12.0pt;color:black">&nbsp; =
.disable_stereo_support =3D true,<o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:12.0pt;color:black">-- <o:p=
></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:12.0pt;color:black">2.17.1<=
o:p></o:p></span></p>
</div>
<p class=3D"MsoNormal" style=3D"margin-bottom:12.0pt"><span style=3D"font-s=
ize:12.0pt;color:black"><o:p>&nbsp;</o:p></span></p>
</div>
</div>
</div>
</body>
</html>

--_000_MN2PR12MB3198E21B95D39C8B1561D73B89D70MN2PR12MB3198namp_--

--===============1460549626==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============1460549626==--
