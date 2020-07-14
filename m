Return-Path: <SRS0=Dt/2=AZ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8597C433E1
	for <amd-gfx@archiver.kernel.org>; Tue, 14 Jul 2020 13:48:05 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AC5C722365
	for <amd-gfx@archiver.kernel.org>; Tue, 14 Jul 2020 13:48:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="2cHj/l3w"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AC5C722365
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5DE4C6E149;
	Tue, 14 Jul 2020 13:48:05 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2042.outbound.protection.outlook.com [40.107.93.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6108A6E149
 for <amd-gfx@lists.freedesktop.org>; Tue, 14 Jul 2020 13:48:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Vtzx1l1okU3IYMSmicpK86kADIwXKia7ou/W5lZxYJePA9/PURsM36Jq55UfoWh/7Zqu9TrZ2duPgZWQFg5GFUnvFqsU9d9kHB5MzlHp2JUl9YhyrNQrFT3TuynJq2c8nmUfS3tnvVFAWw5Tq8mS1/DwlpMPeqDuIBbZLkiKbW4AL1Odg0FD6qrQhiGPeBlBy9kPCGTxM2CemsZhBnsp9qiMcVg4adIiCmjYqUOEFoanEC3rN9/xg76nLehBBuX3mE8yau2JMgRmGWMhbSvGLL/qvHRADKYUp0lgB2+pCA0QzuUF5Mp44Q0G7xiP3dA7MQqves6+5K2+vUVufMCAqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xu9HEciMNr5rrBd7WP6mJ8xH4MckPY5B61gaZuEDYNs=;
 b=OWkbxQ/HNkbVHf6ewHfhYP5uR+hRmdztMHBCZBumn/HGrspepwEGZItUrludTlU2C6vzaZd3faxpvc/riySjPkVfn+ZVuy1pAs+1L6qOdr/lW+UK8vdD1I+TVvrAUg/xWh1z3Nl9WFHaA1i+d4iFqiNWYBmk41VK+frPyC1PYcoLqkJI8PiUJau64Lva3w+4opXTiaxTj69fmWROPA02feONqkJTilGB6ALsQWUudGP3eaRMi9DvUtMgCKtScoSMveGik6y+Zo1iftLsXk8cLzuREwcTrMO3zF0VDtDnLwWoNvOjJlVXqdu8mVyLSjOfVIx0xliw8xxidAR9iJOeyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xu9HEciMNr5rrBd7WP6mJ8xH4MckPY5B61gaZuEDYNs=;
 b=2cHj/l3w9l3QE2yDvJ10Ewplw/gBQK3OGPN/m8FukXVyy8/vK/Bz9/X2LMMmspuUFV1H7xYFEXfA+1JZwnWWpJFFdAwuBgIM635KMUcNW8CdVQgl1hChl9ryeu4KnLXw4YI8qTgra6rX/lkYHK+54hbovL1gHcQ1Drj1IzO3FSA=
Received: from MN2PR12MB4488.namprd12.prod.outlook.com (2603:10b6:208:24e::19)
 by MN2PR12MB4013.namprd12.prod.outlook.com (2603:10b6:208:163::27)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3174.22; Tue, 14 Jul
 2020 13:48:03 +0000
Received: from MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::c8b3:24f3:c561:97d9]) by MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::c8b3:24f3:c561:97d9%6]) with mapi id 15.20.3174.025; Tue, 14 Jul 2020
 13:48:03 +0000
From: "Deucher, Alexander" <Alexander.Deucher@amd.com>
To: "Quan, Evan" <Evan.Quan@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH 13/16] drm/amd/powerplay: apply gfxoff
 disablement/enablement for all SMU11 ASICs
Thread-Topic: [PATCH 13/16] drm/amd/powerplay: apply gfxoff
 disablement/enablement for all SMU11 ASICs
Thread-Index: AQHWVnVdkfRXUFuriUqgxKOzC5Yrq6kE4uqAgAHHmICAAHNCbA==
Date: Tue, 14 Jul 2020 13:48:02 +0000
Message-ID: <MN2PR12MB448899694348DD943510024AF7610@MN2PR12MB4488.namprd12.prod.outlook.com>
References: <20200710044746.23538-1-evan.quan@amd.com>
 <20200710044746.23538-13-evan.quan@amd.com>
 <DM6PR12MB2619A21F1F0177201E615D10E4600@DM6PR12MB2619.namprd12.prod.outlook.com>,
 <DM6PR12MB26198351D67CF41C088FF4FCE4610@DM6PR12MB2619.namprd12.prod.outlook.com>
In-Reply-To: <DM6PR12MB26198351D67CF41C088FF4FCE4610@DM6PR12MB2619.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Enabled=True;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SetDate=2020-07-14T13:48:02.320Z;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Name=AMD
 Public; MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ContentBits=0;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Method=Privileged; 
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [71.219.66.138]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 815d558f-44f6-4ac3-8e06-08d827fc8770
x-ms-traffictypediagnostic: MN2PR12MB4013:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR12MB40138DEFEA81F645DD19D815F7610@MN2PR12MB4013.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:549;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: M1wylaNGjS7CvHTSshvxsPsbFHOnRTevlNNFY9NAhKHOmC7X8BpoB6+o81etxtw04oOC6AGE84X39D4KFfwYNir9PAO25Pv2+Frcwj823stoJqXl+REAWndp5NaHu8SQEbifRatGsx0k4Sbb/Ie/Eatn75BrP+VgE1k35BE4POldit1kv1Kgpx8oT10vbrcyxoTbtahk4MAxLEGYNi2Pw1KwBKlPpm4AodapA1IOvt8sMIqHSXqILxyWYEPOYp+E0CnLjkxSMA/akVJBSZ95nzivYV+7Tqw6z6+owB9KaZAtCsk3MSUvP1cvwQUv9Xv6OJW0fzdW8dhJCUeGKGbBXQ==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB4488.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(396003)(366004)(346002)(376002)(136003)(39860400002)(26005)(55016002)(8676002)(71200400001)(33656002)(478600001)(19627405001)(9686003)(2906002)(76116006)(86362001)(53546011)(6506007)(52536014)(7696005)(66476007)(8936002)(64756008)(66446008)(66556008)(316002)(186003)(110136005)(83380400001)(5660300002)(66946007);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: yDQ1AEJ+Qd5qo7TLq76PW8GfR2SwMIwNxCV/XDDA2Bk39KmLn5koKkxyYWCW7+/Rp7799b/8OSvU9n3W4F0Z4YXLumaDfSF5gnYU/BDfrv+/N/MGL9IpBzTbf6PYoNmDbcWxkrTq0py9Z9EXxRGHztID+J88F1QQWuTeOSrXMAubf5hU6YvIIL7gmPdS3BzN5bTUrnldlr/SyHPajvQu7CMC9MHPBOSKCww8L+wj8EVThTxph8bNdeMJKqlr0CaYde6g6cU90VhmDWXFXirBDzcL6P/RbXtGai6HvF9eDCSZNSQXM+NEIy0O+Szz/V4mPjdLfRtfjezS0Q3+L1SgUWRpMkCdUYI5VaHxf8Ki96UQUdS0V/uGd3BiMh5avzOl7ZKJdoT0YKkzR9pR/YDEyRvsL6xhAQuMMf/blCNOCy+6dCbUS1DoR0WoqVuL25J42X2dOpY/fF+XhSieGODwanVTeSghRtz+VCBo3ZeNGIJcKeRKDmHp+wnorOSKXlJ9
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4488.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 815d558f-44f6-4ac3-8e06-08d827fc8770
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Jul 2020 13:48:02.9302 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: OdtSECsft2KBsd4bdjRQPG4JKFpkpfjyOdJ21m9boSzfvTaqBeSVZbhhu/XyfpwP2ygoFavZWJdYexzeEggFsw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4013
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
Content-Type: multipart/mixed; boundary="===============0727424879=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============0727424879==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_MN2PR12MB448899694348DD943510024AF7610MN2PR12MB4488namp_"

--_000_MN2PR12MB448899694348DD943510024AF7610MN2PR12MB4488namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[AMD Public Use]

Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
________________________________
From: Quan, Evan <Evan.Quan@amd.com>
Sent: Tuesday, July 14, 2020 2:55 AM
To: amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>
Subject: RE: [PATCH 13/16] drm/amd/powerplay: apply gfxoff disablement/enab=
lement for all SMU11 ASICs

[AMD Official Use Only - Internal Distribution Only]

Hi Alex,

Can I have a RB for this patch also?

BR
Evan
-----Original Message-----
From: Quan, Evan
Sent: Monday, July 13, 2020 11:45 AM
To: amd-gfx@lists.freedesktop.org
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>
Subject: RE: [PATCH 13/16] drm/amd/powerplay: apply gfxoff disablement/enab=
lement for all SMU11 ASICs

Ping for this one and patch12, patch2 and patch3

BR
Evan
-----Original Message-----
From: Quan, Evan <Evan.Quan@amd.com>
Sent: Friday, July 10, 2020 12:48 PM
To: amd-gfx@lists.freedesktop.org
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Quan, Evan <Evan.Quan@a=
md.com>
Subject: [PATCH 13/16] drm/amd/powerplay: apply gfxoff disablement/enableme=
nt for all SMU11 ASICs

Before and after setting gfx clock soft max/min frequency.

Change-Id: I6f828da8de096ebc0ae27eaa89f988def2d547ec
Signed-off-by: Evan Quan <evan.quan@amd.com>
---
 drivers/gpu/drm/amd/powerplay/smu_v11_0.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/powerplay/smu_v11_0.c b/drivers/gpu/drm/am=
d/powerplay/smu_v11_0.c
index c2779d0b51f6..33e0718f2635 100644
--- a/drivers/gpu/drm/amd/powerplay/smu_v11_0.c
+++ b/drivers/gpu/drm/amd/powerplay/smu_v11_0.c
@@ -1758,8 +1758,7 @@ int smu_v11_0_set_soft_freq_limited_range(struct smu_=
context *smu,
 if (clk_id < 0)
 return clk_id;

-if (clk_type =3D=3D SMU_GFXCLK &&
-    adev->asic_type =3D=3D CHIP_SIENNA_CICHLID)
+if (clk_type =3D=3D SMU_GFXCLK)
 amdgpu_gfx_off_ctrl(adev, false);

 if (max > 0) {
@@ -1779,8 +1778,7 @@ int smu_v11_0_set_soft_freq_limited_range(struct smu_=
context *smu,
 }

 out:
-if (clk_type =3D=3D SMU_GFXCLK &&
-    adev->asic_type =3D=3D CHIP_SIENNA_CICHLID)
+if (clk_type =3D=3D SMU_GFXCLK)
 amdgpu_gfx_off_ctrl(adev, true);

 return ret;
--
2.27.0


--_000_MN2PR12MB448899694348DD943510024AF7610MN2PR12MB4488namp_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
<style type=3D"text/css" style=3D"display:none;"> P {margin-top:0;margin-bo=
ttom:0;} </style>
</head>
<body dir=3D"ltr">
<p style=3D"font-family:Arial;font-size:10pt;color:#317100;margin:15pt;" al=
ign=3D"Left">
[AMD Public Use]<br>
</p>
<br>
<div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
Reviewed-by: Alex Deucher &lt;alexander.deucher@amd.com&gt;<br>
</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Quan, Evan &lt;Evan.Q=
uan@amd.com&gt;<br>
<b>Sent:</b> Tuesday, July 14, 2020 2:55 AM<br>
<b>To:</b> amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&=
gt;<br>
<b>Cc:</b> Deucher, Alexander &lt;Alexander.Deucher@amd.com&gt;<br>
<b>Subject:</b> RE: [PATCH 13/16] drm/amd/powerplay: apply gfxoff disableme=
nt/enablement for all SMU11 ASICs</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font face=3D"Times New Roman" size=3D"3"><span=
 style=3D"font-size:12pt;"><a name=3D"BM_BEGIN"></a>
<div><font size=3D"2"><span style=3D"font-size:11pt;">[AMD Official Use Onl=
y - Internal Distribution Only]<br>
<br>
Hi Alex,<br>
<br>
Can I have a RB for this patch also?<br>
<br>
BR<br>
Evan<br>
-----Original Message-----<br>
From: Quan, Evan<br>
Sent: Monday, July 13, 2020 11:45 AM<br>
To: amd-gfx@lists.freedesktop.org<br>
Cc: Deucher, Alexander &lt;Alexander.Deucher@amd.com&gt;<br>
Subject: RE: [PATCH 13/16] drm/amd/powerplay: apply gfxoff disablement/enab=
lement for all SMU11 ASICs<br>
<br>
Ping for this one and patch12, patch2 and patch3<br>
<br>
BR<br>
Evan<br>
-----Original Message-----<br>
From: Quan, Evan &lt;Evan.Quan@amd.com&gt;<br>
Sent: Friday, July 10, 2020 12:48 PM<br>
To: amd-gfx@lists.freedesktop.org<br>
Cc: Deucher, Alexander &lt;Alexander.Deucher@amd.com&gt;; Quan, Evan &lt;Ev=
an.Quan@amd.com&gt;<br>
Subject: [PATCH 13/16] drm/amd/powerplay: apply gfxoff disablement/enableme=
nt for all SMU11 ASICs<br>
<br>
Before and after setting gfx clock soft max/min frequency.<br>
<br>
Change-Id: I6f828da8de096ebc0ae27eaa89f988def2d547ec<br>
Signed-off-by: Evan Quan &lt;evan.quan@amd.com&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/powerplay/smu_v11_0.c | 6 &#43;&#43;----<br>
&nbsp;1 file changed, 2 insertions(&#43;), 4 deletions(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/powerplay/smu_v11_0.c b/drivers/gpu/drm/am=
d/powerplay/smu_v11_0.c<br>
index c2779d0b51f6..33e0718f2635 100644<br>
--- a/drivers/gpu/drm/amd/powerplay/smu_v11_0.c<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/powerplay/smu_v11_0.c<br>
@@ -1758,8 &#43;1758,7 @@ int smu_v11_0_set_soft_freq_limited_range(struct =
smu_context *smu,<br>
&nbsp;if (clk_id &lt; 0)<br>
&nbsp;return clk_id;<br>
<br>
-if (clk_type =3D=3D SMU_GFXCLK &amp;&amp;<br>
-&nbsp;&nbsp;&nbsp; adev-&gt;asic_type =3D=3D CHIP_SIENNA_CICHLID)<br>
&#43;if (clk_type =3D=3D SMU_GFXCLK)<br>
&nbsp;amdgpu_gfx_off_ctrl(adev, false);<br>
<br>
&nbsp;if (max &gt; 0) {<br>
@@ -1779,8 &#43;1778,7 @@ int smu_v11_0_set_soft_freq_limited_range(struct =
smu_context *smu,<br>
&nbsp;}<br>
<br>
&nbsp;out:<br>
-if (clk_type =3D=3D SMU_GFXCLK &amp;&amp;<br>
-&nbsp;&nbsp;&nbsp; adev-&gt;asic_type =3D=3D CHIP_SIENNA_CICHLID)<br>
&#43;if (clk_type =3D=3D SMU_GFXCLK)<br>
&nbsp;amdgpu_gfx_off_ctrl(adev, true);<br>
<br>
&nbsp;return ret;<br>
--<br>
2.27.0<br>
<br>
</span></font></div>
</span></font></div>
</div>
</body>
</html>

--_000_MN2PR12MB448899694348DD943510024AF7610MN2PR12MB4488namp_--

--===============0727424879==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============0727424879==--
