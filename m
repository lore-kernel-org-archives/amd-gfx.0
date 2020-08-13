Return-Path: <SRS0=ZeSq=BX=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F33F0C433DF
	for <amd-gfx@archiver.kernel.org>; Thu, 13 Aug 2020 19:43:33 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C5ADC20791
	for <amd-gfx@archiver.kernel.org>; Thu, 13 Aug 2020 19:43:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="fzMn1kto"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C5ADC20791
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7EE196E22B;
	Thu, 13 Aug 2020 19:43:33 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2081.outbound.protection.outlook.com [40.107.93.81])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4E2546E22B
 for <amd-gfx@lists.freedesktop.org>; Thu, 13 Aug 2020 19:43:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=f4MQiBs3C/YLJmf2rRGTA0WWo74sMGjQS78QjFpO4hT2tH2KjkSpqMjuYRxxTwTN6zuSmw7Ec2DuNBe1nHaMTG7lpzcWlAvSC0NxFd9vGSEo0eragu38cZTBxXWkRnlJJ2L1TDa8ZXFbM0OZ4yk+d5YeJfrsd7ZhfyGtp7/wjeSn76nDZ80RSzzpsL3zt1hZ1ociI1WITIDZYWetn0VY9TmX5kG5w6u4o+nz6uzQHN6lS0hWNQ1f507X15LMX6Gp9LfVkTqKEKJvh9E/keey80x9cq7LjXmMLVOr4wZj5aYT4ybC2YSWmp7oLhF4z8CNtFbr/rpyxa6Pu+5ZkxE2IA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kxA5KBv518QcyXOC/378KVHrkpEPIY/0FrLUlgFbfWg=;
 b=jA51wLJEVBcAoxw+xvxjMNtw5P6hSbnktx/G6RYKi/RgBQU1T1JzFHSFCcsnHzA03E6nTf0elA+WmY0Hyklop2maKtqqRCq4LNVYOKoduzog2meweMdRpssaHvSSidGL44ZQJisnDmZVnoy7tAAUrv/QdCFeEgrUef2G6FTuYpXQkXGdE4zu+hG1gWJ5RVIA+nGr6DCRHB2ZdSFW6pER9EzS144a4euJbncf6cxcbql9fR0elKoVMBia7J4wOVFVww5Rf8zon5tP6cGRpv3esZgBoYeG4vCH5HmgrVEdp7wj1ZAuJrcdoMW9Kb09sEQ4WYscplYYR+mC6NcyuaJEPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kxA5KBv518QcyXOC/378KVHrkpEPIY/0FrLUlgFbfWg=;
 b=fzMn1ktoP7SMgvl7t6UoVlQUmwsiWkWWSJmfbjy4u+UbFwQbDichbHoxypYaHetFUIe4XYimTGlty++pEza9mGmhrsO4ZUj+w/3JT9JX1rqvNxTFjD+HEaAWnJldZWvblh7P50ghuxPg7O/ZNRrvHMrIxFayIFJzVRxnl6epdUc=
Received: from MN2PR12MB4488.namprd12.prod.outlook.com (2603:10b6:208:24e::19)
 by MN2PR12MB3743.namprd12.prod.outlook.com (2603:10b6:208:168::33)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3261.20; Thu, 13 Aug
 2020 19:43:26 +0000
Received: from MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::889d:3c2f:a794:67fb]) by MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::889d:3c2f:a794:67fb%7]) with mapi id 15.20.3261.024; Thu, 13 Aug 2020
 19:43:26 +0000
From: "Deucher, Alexander" <Alexander.Deucher@amd.com>
To: "Liu, Leo" <Leo.Liu@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH] drm/amdgpu/jpeg: remove redundant check when it returns
Thread-Topic: [PATCH] drm/amdgpu/jpeg: remove redundant check when it returns
Thread-Index: AQHWcam/BASx7s1THkOvywUTV/j6aak2cJzV
Date: Thu, 13 Aug 2020 19:43:26 +0000
Message-ID: <MN2PR12MB4488D928EAC0E5142EC032ECF7430@MN2PR12MB4488.namprd12.prod.outlook.com>
References: <20200813194047.13162-1-leo.liu@amd.com>
In-Reply-To: <20200813194047.13162-1-leo.liu@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Enabled=True;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SetDate=2020-08-13T19:43:26.194Z;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Name=AMD
 Public; MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ContentBits=0;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Method=Privileged; 
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [71.219.66.138]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 6dfb5222-8b06-459f-ab3f-08d83fc125c7
x-ms-traffictypediagnostic: MN2PR12MB3743:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR12MB3743843D99CA72BF3A9C5E1DF7430@MN2PR12MB3743.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3513;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: C/b1kNf0SrUMiObCsOPogfsdn6B7zAvsfQaK6QjgObS7mWlt7HlO0r0X20yoCZ6OmOepFI3y3AT+HtWFEb+0TDAvZdXNBJ0hG2u2tzvLAYLo4WEFWpbdlYjZ9wHfi11zHrHlC+KwF6MXVC9R0Gqh8g1EwhYAFtV6IE4nDCqSf+cghVyQdFWrj/iF+UURtf+7R+yLMeHCyUh6vBEqLLhHUHPbWK2UNia0w4oa+p9tGSvYM7XJrbmlHUTKgyBzVIUCpiaIdSge0mj6kGZc3SXyfQUJxYMEqzhLsq38H/fRa8H6P2+nxo+5A3dzl4gzfW95XQttJSnMVSMVFmh+VSuMBw2SqdVVSIWsfbVh2E5JtEw=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB4488.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(376002)(346002)(136003)(39860400002)(366004)(396003)(316002)(45080400002)(53546011)(8676002)(86362001)(26005)(5660300002)(19627405001)(186003)(110136005)(8936002)(6506007)(966005)(478600001)(33656002)(2906002)(71200400001)(9686003)(166002)(55016002)(83380400001)(66946007)(66446008)(66476007)(76116006)(52536014)(66556008)(64756008)(7696005);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: jqBrcQm26WtXLjKCrei48BUJUrSeMVclsRWrpVji1uiV4kx3XIFNi30A7SMFgLOWhrcD12IHhPrU6nlIcvXU4EMH4ywPbjGCh2Hag/381JoS+t7cj1IdhtCZMBq0oBdZ6YNvrJ1lgqjjrxG2Up0mhi6P8EyOCXZM1k7CBpoBm+4HKQBsUkA161twRNuSp7DKH5CD4cNqliXwttOeJbvCdQeFiMV8/Y03iL/7TQ7rDG3pDmZozCoX5biV/66xHp3r0Jcp2wwbC/Y4p2/FWLT85djAs2P5/Ha5yEVl23ip4A1zSbvT27M+wrQHLxubq97j0smcE2rwVzSCClXmhB+z1Zom4wL/ulBQhrcf5G3rNa4xUrv0N7VvjKx6itbEJjGc5mQDdg/3uMDT0/SRL+2BfQaAQXYV7tcjdgpP1pwR1OgrgWNZmRZqTIvZTjprXXeoy/ZGLvDS+7f9ToIYabYmm9/0BSNS1aUCGedP7gZkLF8StqNnsz6k4aASGODz1U6HmS0t12YHDaMxLV9V8x3mXB7c0KaJ/qoUuRqGzth3+orycBsmUkGoF6j+CDsf0YEkCslrO2XdOMWZwZkwxexS0VhKnqNwS08lm+yvUxmrFuEJK0ce8Zda0l1e6eevS3Qe+8trq7ZqZNJZwnbEpFoznw==
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4488.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6dfb5222-8b06-459f-ab3f-08d83fc125c7
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Aug 2020 19:43:26.6741 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8RgP/Wjod5fp4Walzh6tfyHYeqaNFWNXDnqwXMToth8UUvQ5s9A5D2XipByecxfV/ZddkqJ13o5x5fwEmXnizg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3743
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
Content-Type: multipart/mixed; boundary="===============2027926056=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============2027926056==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_MN2PR12MB4488D928EAC0E5142EC032ECF7430MN2PR12MB4488namp_"

--_000_MN2PR12MB4488D928EAC0E5142EC032ECF7430MN2PR12MB4488namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[AMD Public Use]

Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
________________________________
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> on behalf of Leo Liu =
<leo.liu@amd.com>
Sent: Thursday, August 13, 2020 3:40 PM
To: amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>
Cc: Liu, Leo <Leo.Liu@amd.com>
Subject: [PATCH] drm/amdgpu/jpeg: remove redundant check when it returns

Fix warning from kernel test robot

Signed-off-by: Leo Liu <leo.liu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/jpeg_v3_0.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v3_0.c b/drivers/gpu/drm/amd/a=
mdgpu/jpeg_v3_0.c
index c41e5590a701..f4ba423af051 100644
--- a/drivers/gpu/drm/amd/amdgpu/jpeg_v3_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v3_0.c
@@ -465,8 +465,6 @@ static int jpeg_v3_0_wait_for_idle(void *handle)
         ret =3D SOC15_WAIT_ON_RREG(JPEG, 0, mmUVD_JRBC_STATUS,
                 UVD_JRBC_STATUS__RB_JOB_DONE_MASK,
                 UVD_JRBC_STATUS__RB_JOB_DONE_MASK);
-       if (ret)
-               return ret;

         return ret;
 }
--
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flists.f=
reedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=3D02%7C01%7Calexande=
r.deucher%40amd.com%7C3024a7a58bf24bc3731b08d83fc0df59%7C3dd8961fe4884e608e=
11a82d994e183d%7C0%7C0%7C637329444922074471&amp;sdata=3DVqEE7z0JlPSNE0nH3HF=
ISbRGPF7tC0uNgBB3yJnSSHo%3D&amp;reserved=3D0

--_000_MN2PR12MB4488D928EAC0E5142EC032ECF7430MN2PR12MB4488namp_
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
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> amd-gfx &lt;amd-gfx-b=
ounces@lists.freedesktop.org&gt; on behalf of Leo Liu &lt;leo.liu@amd.com&g=
t;<br>
<b>Sent:</b> Thursday, August 13, 2020 3:40 PM<br>
<b>To:</b> amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&=
gt;<br>
<b>Cc:</b> Liu, Leo &lt;Leo.Liu@amd.com&gt;<br>
<b>Subject:</b> [PATCH] drm/amdgpu/jpeg: remove redundant check when it ret=
urns</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">Fix warning from kernel test robot<br>
<br>
Signed-off-by: Leo Liu &lt;leo.liu@amd.com&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/jpeg_v3_0.c | 2 --<br>
&nbsp;1 file changed, 2 deletions(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v3_0.c b/drivers/gpu/drm/amd/a=
mdgpu/jpeg_v3_0.c<br>
index c41e5590a701..f4ba423af051 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/jpeg_v3_0.c<br>
+++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v3_0.c<br>
@@ -465,8 +465,6 @@ static int jpeg_v3_0_wait_for_idle(void *handle)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D SOC15_WAIT_ON_RREG=
(JPEG, 0, mmUVD_JRBC_STATUS,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; UVD_JRBC_STATUS__RB_JOB_DONE_MASK,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; UVD_JRBC_STATUS__RB_JOB_DONE_MASK);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (ret)<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; return ret;<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return ret;<br>
&nbsp;}<br>
-- <br>
2.25.1<br>
<br>
_______________________________________________<br>
amd-gfx mailing list<br>
amd-gfx@lists.freedesktop.org<br>
<a href=3D"https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2=
F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;amp;data=3D02%=
7C01%7Calexander.deucher%40amd.com%7C3024a7a58bf24bc3731b08d83fc0df59%7C3dd=
8961fe4884e608e11a82d994e183d%7C0%7C0%7C637329444922074471&amp;amp;sdata=3D=
VqEE7z0JlPSNE0nH3HFISbRGPF7tC0uNgBB3yJnSSHo%3D&amp;amp;reserved=3D0">https:=
//nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flists.freedes=
ktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;amp;data=3D02%7C01%7Calexander.=
deucher%40amd.com%7C3024a7a58bf24bc3731b08d83fc0df59%7C3dd8961fe4884e608e11=
a82d994e183d%7C0%7C0%7C637329444922074471&amp;amp;sdata=3DVqEE7z0JlPSNE0nH3=
HFISbRGPF7tC0uNgBB3yJnSSHo%3D&amp;amp;reserved=3D0</a><br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_MN2PR12MB4488D928EAC0E5142EC032ECF7430MN2PR12MB4488namp_--

--===============2027926056==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============2027926056==--
