Return-Path: <SRS0=0XED=GC=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E604C433E0
	for <amd-gfx@archiver.kernel.org>; Wed, 30 Dec 2020 17:11:39 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B32C322287
	for <amd-gfx@archiver.kernel.org>; Wed, 30 Dec 2020 17:11:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B32C322287
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1786F893DB;
	Wed, 30 Dec 2020 17:11:38 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2060.outbound.protection.outlook.com [40.107.220.60])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3E55B8935B
 for <amd-gfx@lists.freedesktop.org>; Wed, 30 Dec 2020 17:11:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DZM07OUOLBRnObr7YSlwAAPnogheIDqy622Iypr3HXNb48Kod3exUoruAf6pVlokKjCNXXTADw86sfsGbOnxMDpXu3Ab6Cg6qG2LrSR2Ae9p38WwtSMeqvCV1sENnGaghZABXY+mURKMq0qk1mnObP0xhvNTcBBbsMhTDIWTbMfbyuRxklExj6W7c+2Nltu5UizTK6E/W6dm4ZIm1M48RIe0RKQhG5ctfTCkOIizHEEM16XLAruvpkgs2YtMEckK4y8JN8+bgQnkhb319iWgVKMZ8deDVgPYdAB3dDr/TP+qXJQoPlZ5egsg3ouZXj8akHpKCjbc3YsS3E0hlu2VIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h8Vd3AC5evP7CBjXkTZTo/gbu1yi0eVQY7phNhKtfnM=;
 b=LGDsKk3qAi53OpgeKWDyYsaRLGQjCA9MtZ+KbqfyzGuqc0xlXZbxO9tiDxAGjkGiHT55mnSAWBNGT9UtGNglvXxZnVOUYPANhHfuRJxaFCxjPBE7zfSrP2awof1wMBSH1pNPT17yqKtFDCyzByRzV5ATCSyt83cf+La88Sc2867NGRxYl8c7jO6VgrY0caCbuHFAJFKOhTb73iZOjjTh9J4iqqWyoO5BPVc4bWZVewVut3v7HZU6ZgbgP10aUCTOSfPXgcpHsl458htFytSPaUhdwWm7+2W0vKNd06UNCGWqd4RTIsrb/z17zynaxbBqy2Yfvz1j1kEsyhxZAV0anw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h8Vd3AC5evP7CBjXkTZTo/gbu1yi0eVQY7phNhKtfnM=;
 b=iKtmPx1uOEWyuMuYZBW5+qNjcC/EzACldI+TLIvH3qMZzR8+tMJ7ZUASmvsq0Sx+lK9q1D1GKN6FDTHcfgM15cpaz3n3S/5MUenFiTJPTXlDQ74enojRXo5sINQrlxg4CpE7PIKBh6Zxg5fj4xygpKItJphhBngA1kaaL16f9EY=
Received: from DM6PR12MB4156.namprd12.prod.outlook.com (2603:10b6:5:218::17)
 by DM5PR12MB1674.namprd12.prod.outlook.com (2603:10b6:4:11::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3700.27; Wed, 30 Dec
 2020 17:11:35 +0000
Received: from DM6PR12MB4156.namprd12.prod.outlook.com
 ([fe80::b803:7e6e:40ec:4a0d]) by DM6PR12MB4156.namprd12.prod.outlook.com
 ([fe80::b803:7e6e:40ec:4a0d%7]) with mapi id 15.20.3721.020; Wed, 30 Dec 2020
 17:11:35 +0000
From: "Wu, Hersen" <hersenxs.wu@amd.com>
To: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "Deucher, 
 Alexander" <Alexander.Deucher@amd.com>, "Li, Roman" <Roman.Li@amd.com>
Subject: [PATCH] drm/amd/display: disable dcn10 pipe split by default
Thread-Topic: [PATCH] drm/amd/display: disable dcn10 pipe split by default
Thread-Index: AQHW3szJ9p//noNmJkKEV5oLNQFPeg==
Date: Wed, 30 Dec 2020 17:11:35 +0000
Message-ID: <DM6PR12MB415686CF8CCA926086E15F52FDD70@DM6PR12MB4156.namprd12.prod.outlook.com>
Accept-Language: en-CA, en-US
Content-Language: en-CA
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=True;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2020-12-30T17:11:35.043Z;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal
 Distribution
 Only; MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=0;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard; 
authentication-results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
x-originating-ip: [2607:fea8:3c60:9c20:2dec:b5f3:a578:8cd]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: f231177c-4c94-4d96-e7a4-08d8ace5f65f
x-ms-traffictypediagnostic: DM5PR12MB1674:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM5PR12MB16743F62E625BFA10B8FAA0FFDD70@DM5PR12MB1674.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:400;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: cBW+JnUI1Jolf7w++f8ACN0VLQnRh/T7lsivpMEQo4F9rgHX9UEQQsrtIGhdsBBGFGIVCgEpLa+T7w+mbSADpTDZP7UD+4IpU44j67LlqajWsgfQLHuwnQbxKdzMR/i/8E5YOH/+0SGcLJ/biivFZ6sDP0sM5Afj7hqTfKZf2s4EZCgLhQfiNWR3g8yeCkCF5GjJA9ByekRz1i6rAxFMP3zW6E8qkagHnMrZ7vKDhNEKvD+a8ylcNGrtjRdirp9qOjAtJgXdn2/pBBf7EsHvrpYqTjmkFkZvkgteShnFBHAe0IWwhWRGJzKW5tKeCab00RIKS4TnUfWYmNs273dSFIMgyOof29Rv0judMQNrwAbdiwZbm8Oo7QsFmZWVYo/u5cdMPa30NWmQU6XLvQAr5w==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB4156.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(136003)(39860400002)(346002)(366004)(396003)(33656002)(8676002)(83380400001)(9686003)(71200400001)(6636002)(8936002)(86362001)(7696005)(6506007)(186003)(478600001)(66446008)(91956017)(66476007)(110136005)(55016002)(66946007)(76116006)(52536014)(64756008)(66556008)(316002)(5660300002)(2906002)(19627405001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?iso-8859-1?Q?FK32XSAwN8+vZEJ2GErXGhy2E/pGZSQyLwxl27WUr19qmNkCbrnGpQjlaA?=
 =?iso-8859-1?Q?+Yr6Do6p5iMBEsQ7EDudQ5y3hlqGGqsoNidWv6MfXsGF4Nmovsfo5abwfV?=
 =?iso-8859-1?Q?+ps9tY1bfXKzrS60YC8T/HLhO1/YDsC+17jtwRwssYjtL2WMwiMlLMjOZq?=
 =?iso-8859-1?Q?ZXZ2aMqJ+Tqf57M+7jwm9rnnLB7TAx3Y+Yi2UirH0EIX1v6+UQ9pl1eKv7?=
 =?iso-8859-1?Q?ePV4eGaGwuEawKPRDnSqOdfrWxujqC7x+sZQwG3XbKyxS4+I/3pCpQ+XBq?=
 =?iso-8859-1?Q?8c67NO1C8sE2oabiX6OIHoWzo6s2RfNERlk7WOwBChBFuQG/G5VEaHwYeR?=
 =?iso-8859-1?Q?7aAwwSCOsCTRC14nAMWjj+V9+rTWI0T75Tt2Vg7E3ok/oeIH6VDf0R6ZNv?=
 =?iso-8859-1?Q?i1L73uEpUdeh5tctadVpKYlZYLWehGDrYasvFG35Yff1PiCCCXZUJTRsS1?=
 =?iso-8859-1?Q?HdZheFnBHUuDnjP5aeP0LHpNsYnSl5Q5x1VqOy6NwzS8cPueKkvpUN2YDT?=
 =?iso-8859-1?Q?PrVJsjh+IlNKz1apXE/tVWiAKf7GrFK8lZ+WK0UeCOlH/9vkaYyhrZuSl9?=
 =?iso-8859-1?Q?Vr0VFIjiKIWoxg09fiCJWYITvKo5kgusM9FyvwVob9NB3u+p2h+Q+8edPF?=
 =?iso-8859-1?Q?CHcAyPStn52xA5/pUbStRN6m6FSaEbRddDQJ2QJZnF14IZPUdIPepvaY2e?=
 =?iso-8859-1?Q?QnhCBBGoPnCze2KYOSodJWNyExAS1AbqbZA25FJgXF2qEiDkkcn5D2KgQU?=
 =?iso-8859-1?Q?RW3rGdTE0FrMmF3ADCkkCFRmuYjiF77+xZt+Zy0Anrgg9b59gh2zxRCc4T?=
 =?iso-8859-1?Q?P1f7rj4DPwQPyFG+ALbL+rrO3yxZ9/RXqELNQzUTkjo2VjjZ72GGpIKCVV?=
 =?iso-8859-1?Q?n7ivO5Q2KVU8As2Trsz9rve5LPmcdtMhl9hUPJembd5T+sXdyUDiPDk2oY?=
 =?iso-8859-1?Q?i/fUpTx6VNm1/S3Md8uQm6zwIzjtuJwShD2Jd+CG758piigHNBa97bpgpT?=
 =?iso-8859-1?Q?6FDRGYD6dsIqUO1mVhCpbZcF4fehIzDAMrWyESNYGxn4JwXsqjnwPbDpJW?=
 =?iso-8859-1?Q?tUdInUK1Ol5SSEWDLikVazc=3D?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4156.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f231177c-4c94-4d96-e7a4-08d8ace5f65f
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Dec 2020 17:11:35.2549 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9oKED+wFuGvyHI+RXe9ywE0emO1A2rX045ImWEW9qaPbS9AORYvU8sEEJA8gctyJ/jVmeLEKC8z3e9kiSPfemw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1674
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
Content-Type: multipart/mixed; boundary="===============1118094744=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============1118094744==
Content-Language: en-CA
Content-Type: multipart/alternative;
	boundary="_000_DM6PR12MB415686CF8CCA926086E15F52FDD70DM6PR12MB4156namp_"

--_000_DM6PR12MB415686CF8CCA926086E15F52FDD70DM6PR12MB4156namp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only - Internal Distribution Only]

[Why] the initial purpose of dcn10 pipe split is to support
some high bandwidth mode which requires dispclk greater
than max dispclk. By initial bring up power measurement
data, it showed power consumption is less with pipe split
for dcn block. This could be reason for enable pipe split
by default. By battery life measurement of some Chromebooks,
result shows battery life is longer with pipe split disabled.

[How] disable pipe split by default. Pipe split could be
still enabled when required dispclk is greater than max dispclk.

Signed-off-by: hersen wu <hersenxs.wu@amd.com>
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



--_000_DM6PR12MB415686CF8CCA926086E15F52FDD70DM6PR12MB4156namp_
Content-Type: text/html; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Diso-8859-=
1">
<style type=3D"text/css" style=3D"display:none;"> P {margin-top:0;margin-bo=
ttom:0;} </style>
</head>
<body dir=3D"ltr">
<p style=3D"font-family:Arial;font-size:11pt;color:#0078D7;margin:5pt;" ali=
gn=3D"Left">
[AMD Official Use Only - Internal Distribution Only]<br>
</p>
<br>
<div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
[Why] the initial purpose of dcn10 pipe split is to support
<div>some high bandwidth mode which requires dispclk greater</div>
<div>than max dispclk. By initial bring up power measurement</div>
<div>data, it showed power consumption is less with pipe split</div>
<div>for dcn block. This could be reason for enable pipe split</div>
<div>by default. By battery life measurement of some Chromebooks,</div>
<div>result shows battery life is longer with pipe split disabled.</div>
<div><br>
</div>
<div>[How] disable pipe split by default. Pipe split could be</div>
<div>still enabled when required dispclk is greater than max dispclk.</div>
<div><br>
</div>
<div>Signed-off-by: hersen wu &lt;hersenxs.wu@amd.com&gt;</div>
<div>---</div>
<div>&nbsp;drivers/gpu/drm/amd/display/dc/dcn10/dcn10_resource.c | 4 ++--</=
div>
<div>&nbsp;1 file changed, 2 insertions(+), 2 deletions(-)</div>
<div><br>
</div>
<div>diff --git a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_resource.c b/d=
rivers/gpu/drm/amd/display/dc/dcn10/dcn10_resource.c</div>
<div>index bdc37831535e..17eafe209946 100644</div>
<div>--- a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_resource.c</div>
<div>+++ b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_resource.c</div>
<div>@@ -608,8 +608,8 @@ static const struct dc_debug_options debug_default=
s_drv =3D {</div>
<div>&nbsp; .disable_pplib_clock_request =3D false,</div>
<div>&nbsp; .disable_pplib_wm_range =3D false,</div>
<div>&nbsp; .pplib_wm_report_mode =3D WM_REPORT_DEFAULT,</div>
<div>- .pipe_split_policy =3D MPC_SPLIT_DYNAMIC,</div>
<div>- .force_single_disp_pipe_split =3D true,</div>
<div>+ .pipe_split_policy =3D MPC_SPLIT_AVOID,</div>
<div>+ .force_single_disp_pipe_split =3D false,</div>
<div>&nbsp; .disable_dcc =3D DCC_ENABLE,</div>
<div>&nbsp; .voltage_align_fclk =3D true,</div>
<div>&nbsp; .disable_stereo_support =3D true,</div>
<div>-- </div>
<div>2.17.1</div>
<br>
<br>
</div>
</div>
</body>
</html>

--_000_DM6PR12MB415686CF8CCA926086E15F52FDD70DM6PR12MB4156namp_--

--===============1118094744==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============1118094744==--
