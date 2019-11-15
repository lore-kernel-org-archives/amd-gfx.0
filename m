Return-Path: <SRS0=FndT=ZH=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E53CDC432C3
	for <amd-gfx@archiver.kernel.org>; Fri, 15 Nov 2019 16:43:02 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C292B20723
	for <amd-gfx@archiver.kernel.org>; Fri, 15 Nov 2019 16:43:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C292B20723
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6CE366E098;
	Fri, 15 Nov 2019 16:43:02 +0000 (UTC)
Received: from NAM03-DM3-obe.outbound.protection.outlook.com
 (mail-eopbgr800055.outbound.protection.outlook.com [40.107.80.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BAC636E098
 for <amd-gfx@lists.freedesktop.org>; Fri, 15 Nov 2019 16:43:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BZrRkG8+XFYstyOjgAT0/tEihvK6Sw221mzzDz4PWXNn00U9BNU4H9r2J66xanJfoLoRzWpJY+5nrEUyJw9ByMvgZMo0aEBuAf3QbnMExdYjhTWhKAR/J+waNEOfQT4RL0XLDFfQ+oX3w8BctOW4aJnf4/ZPQnQKiWUBmlNvyGxt/cWB8gpgUkZGcRme/jKpPv7ZH+8nUM0M0ksmcsvZ4Idzp4aPiUFPjBfWSfauSm7ngpj1a02TVPjeW7iE71cAmu1Cy+5KVuipCf63KH2G9C37FVJh+Ac+u1BHf+OaQjGLEPdndiheevZjhbY05G+HmP59zCCYw6yxWG+YX6l6wQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dCEnQWve+nHzm+RHYVMDCULnQ/9m/RKdpIXjRxZes4E=;
 b=OjJgAJPqsyaOmQ2ydinKNVLTMJRwQsoJGV1JBHhPkc0Awo5hEqMaW8zjySwT7469xRL1knuIuSN7XaoU7+Dp1XAlAdAN5k0ZKURd1kmPTIZjf92Iux+kipzYScDclEb1kxD2Ip3Pxl2QRMsI7+ePpEKmkB3cDX+Wq0lNsQDpizekcMKwa6Q/Yi+uX46FZAGm0S5bKDzped/c8d+PpGRpas5Mh0berc84GMMd/UaB8d1P+j43b7lmO0oq4n/xohhXPfxiBMxeHh8eZ/rBbBL9vjH0dSVyGjrMzrAv1SfXgCkS3FksDELIS1f/ybj+hO+GIQtJ70C0aDERKRraqKmL6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
Received: from DM6PR12MB2778.namprd12.prod.outlook.com (20.176.114.145) by
 DM6PR12MB4217.namprd12.prod.outlook.com (10.141.186.88) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2451.23; Fri, 15 Nov 2019 16:43:00 +0000
Received: from DM6PR12MB2778.namprd12.prod.outlook.com
 ([fe80::304d:db58:2aa:d69e]) by DM6PR12MB2778.namprd12.prod.outlook.com
 ([fe80::304d:db58:2aa:d69e%6]) with mapi id 15.20.2430.027; Fri, 15 Nov 2019
 16:43:00 +0000
From: "Zhao, Yong" <Yong.Zhao@amd.com>
To: Alex Deucher <alexdeucher@gmail.com>, amd-gfx list
 <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH] drm/amdgpu/soc15: move struct definition around to align
 with other soc15 asics
Thread-Topic: [PATCH] drm/amdgpu/soc15: move struct definition around to align
 with other soc15 asics
Thread-Index: AQHVmN5WnbqPCoECakCfV6Ud3yCgmaeMbV6AgAAITyc=
Date: Fri, 15 Nov 2019 16:43:00 +0000
Message-ID:
 <DM6PR12MB277836449EE0C8E5F07D02AFF0700@DM6PR12MB2778.namprd12.prod.outlook.com>
References: <20191111222102.876704-1-alexander.deucher@amd.com>,
 <CADnq5_PRwkMfe3iN_6wD_HMZ1qFSb-vru0gYhYyK+6cjNNHQsg@mail.gmail.com>
In-Reply-To: <CADnq5_PRwkMfe3iN_6wD_HMZ1qFSb-vru0gYhYyK+6cjNNHQsg@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [165.204.54.211]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 7f16d4e3-4896-458e-abda-08d769eae03b
x-ms-traffictypediagnostic: DM6PR12MB4217:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR12MB4217C1440C5372EB5D28427CF0700@DM6PR12MB4217.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4303;
x-forefront-prvs: 02229A4115
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(4636009)(376002)(366004)(346002)(136003)(396003)(39860400002)(189003)(199004)(6116002)(53546011)(81156014)(14444005)(486006)(4326008)(76176011)(66066001)(966005)(81166006)(6306002)(6506007)(6436002)(86362001)(25786009)(66556008)(66476007)(9686003)(5660300002)(3846002)(66446008)(66946007)(14454004)(6246003)(236005)(102836004)(7696005)(26005)(11346002)(446003)(8936002)(55016002)(476003)(186003)(54896002)(105004)(256004)(110136005)(33656002)(91956017)(64756008)(2906002)(74316002)(229853002)(316002)(76116006)(52536014)(7736002)(478600001)(8676002)(71200400001)(19627405001)(606006)(71190400001)(99286004);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM6PR12MB4217;
 H:DM6PR12MB2778.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: VM83oXvNIOHBHJH+0V56mI5oYq0WJNuV2hZypA/2Z6FGu3vkc9gYaE9ndpws90faw/d8pIVmG48OoKth68kIhx8uVTTDWQtpo45GHsK4rSlNRpC4jddNz6hV0OMGPVodd8YE+XMWPTuJPuQ3jPE6rUJ6UrCN5puBXdTzHWiKwaVAb9dxuJYZ0d8quptCNkYnjyqN6JqT97gmTgkU6Ge75OxGh8Ve9c/aFCpxQQlDZKCMnQuJBbqU1Pbqh+9A1ADE7PFEzGriV5HAGnnXLw4msoqs4SuhybLSwIf47n/0x/O/c9JT/Ptvu2sz/KoEsM+t/rf6oMaYEJFbZ0XPGEBRurhMgMboWRZBaiC5W9x6WqDhGCarPemuVYytsa0K3LvJMhJhPf51mURjWLENgPpGe+QsxR3WTuTa2wgA3ZNgP35iluXNsykBZOKL41Eyrshk
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f16d4e3-4896-458e-abda-08d769eae03b
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Nov 2019 16:43:00.0355 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: P/P4jFDnOpQjbX8E4Z6uLJ8wNq38TXqW6GQYqR7p6wPf+xYCdAyLnkNQZCnmm7vW
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4217
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dCEnQWve+nHzm+RHYVMDCULnQ/9m/RKdpIXjRxZes4E=;
 b=btLgGkDnewLixJwHck2M3W6W1M2AMdxm94yPBlKkujBnlnYOycye+/ziYftkLqCCjccvxbeDShuI1jtykechNMO/xPMC5GA3ZY5PJVr+fyJb3ed5bBsz7KeKvNVJ5rhHlRhhL6XPmInYPKxuAVq3NxOaL9hwH0NtUtOptG/K7OE=
X-Mailman-Original-Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Yong.Zhao@amd.com; 
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>
Content-Type: multipart/mixed; boundary="===============2063422928=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
Message-ID: <20191115164300.sHRSxcUQoaf0d7cLqJ8VFHm6CO9LqC3m9KbqEKjpaBM@z>

--===============2063422928==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_DM6PR12MB277836449EE0C8E5F07D02AFF0700DM6PR12MB2778namp_"

--_000_DM6PR12MB277836449EE0C8E5F07D02AFF0700DM6PR12MB2778namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Reviewed-by: Yong Zhao <Yong.Zhao@amd.com>
________________________________
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> on behalf of Alex Deu=
cher <alexdeucher@gmail.com>
Sent: Friday, November 15, 2019 11:13 AM
To: amd-gfx list <amd-gfx@lists.freedesktop.org>
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>
Subject: Re: [PATCH] drm/amdgpu/soc15: move struct definition around to ali=
gn with other soc15 asics

Ping?

On Mon, Nov 11, 2019 at 5:21 PM Alex Deucher <alexdeucher@gmail.com> wrote:
>
> Move reset_method next to reset callback to match the struct layout and
> the other definition in this file.
>
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/soc15.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/soc15.c b/drivers/gpu/drm/amd/amd=
gpu/soc15.c
> index 8e1640bc07af..305ad3eec987 100644
> --- a/drivers/gpu/drm/amd/amdgpu/soc15.c
> +++ b/drivers/gpu/drm/amd/amdgpu/soc15.c
> @@ -1007,6 +1007,7 @@ static const struct amdgpu_asic_funcs vega20_asic_f=
uncs =3D
>         .read_bios_from_rom =3D &soc15_read_bios_from_rom,
>         .read_register =3D &soc15_read_register,
>         .reset =3D &soc15_asic_reset,
> +       .reset_method =3D &soc15_asic_reset_method,
>         .set_vga_state =3D &soc15_vga_set_state,
>         .get_xclk =3D &soc15_get_xclk,
>         .set_uvd_clocks =3D &soc15_set_uvd_clocks,
> @@ -1019,7 +1020,6 @@ static const struct amdgpu_asic_funcs vega20_asic_f=
uncs =3D
>         .get_pcie_usage =3D &vega20_get_pcie_usage,
>         .need_reset_on_init =3D &soc15_need_reset_on_init,
>         .get_pcie_replay_count =3D &soc15_get_pcie_replay_count,
> -       .reset_method =3D &soc15_asic_reset_method
>  };
>
>  static int soc15_common_early_init(void *handle)
> --
> 2.23.0
>
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--_000_DM6PR12MB277836449EE0C8E5F07D02AFF0700DM6PR12MB2778namp_
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
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<span style=3D"color: rgb(32, 31, 30); font-family: &quot;Segoe UI&quot;, &=
quot;Segoe UI Web (West European)&quot;, &quot;Segoe UI&quot;, -apple-syste=
m, BlinkMacSystemFont, Roboto, &quot;Helvetica Neue&quot;, sans-serif; font=
-size: 14.6667px; background-color: rgb(255, 255, 255); display: inline !im=
portant">Reviewed-by:
 Yong Zhao &lt;Yong.Zhao@amd.com&gt;</span><br>
</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> amd-gfx &lt;amd-gfx-b=
ounces@lists.freedesktop.org&gt; on behalf of Alex Deucher &lt;alexdeucher@=
gmail.com&gt;<br>
<b>Sent:</b> Friday, November 15, 2019 11:13 AM<br>
<b>To:</b> amd-gfx list &lt;amd-gfx@lists.freedesktop.org&gt;<br>
<b>Cc:</b> Deucher, Alexander &lt;Alexander.Deucher@amd.com&gt;<br>
<b>Subject:</b> Re: [PATCH] drm/amdgpu/soc15: move struct definition around=
 to align with other soc15 asics</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">Ping?<br>
<br>
On Mon, Nov 11, 2019 at 5:21 PM Alex Deucher &lt;alexdeucher@gmail.com&gt; =
wrote:<br>
&gt;<br>
&gt; Move reset_method next to reset callback to match the struct layout an=
d<br>
&gt; the other definition in this file.<br>
&gt;<br>
&gt; Signed-off-by: Alex Deucher &lt;alexander.deucher@amd.com&gt;<br>
&gt; ---<br>
&gt;&nbsp; drivers/gpu/drm/amd/amdgpu/soc15.c | 2 &#43;-<br>
&gt;&nbsp; 1 file changed, 1 insertion(&#43;), 1 deletion(-)<br>
&gt;<br>
&gt; diff --git a/drivers/gpu/drm/amd/amdgpu/soc15.c b/drivers/gpu/drm/amd/=
amdgpu/soc15.c<br>
&gt; index 8e1640bc07af..305ad3eec987 100644<br>
&gt; --- a/drivers/gpu/drm/amd/amdgpu/soc15.c<br>
&gt; &#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/soc15.c<br>
&gt; @@ -1007,6 &#43;1007,7 @@ static const struct amdgpu_asic_funcs vega20=
_asic_funcs =3D<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .read_bios_from_rom =
=3D &amp;soc15_read_bios_from_rom,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .read_register =3D &am=
p;soc15_read_register,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .reset =3D &amp;soc15_=
asic_reset,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .reset_method =3D &amp;soc15=
_asic_reset_method,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .set_vga_state =3D &am=
p;soc15_vga_set_state,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .get_xclk =3D &amp;soc=
15_get_xclk,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .set_uvd_clocks =3D &a=
mp;soc15_set_uvd_clocks,<br>
&gt; @@ -1019,7 &#43;1020,6 @@ static const struct amdgpu_asic_funcs vega20=
_asic_funcs =3D<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .get_pcie_usage =3D &a=
mp;vega20_get_pcie_usage,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .need_reset_on_init =
=3D &amp;soc15_need_reset_on_init,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .get_pcie_replay_count=
 =3D &amp;soc15_get_pcie_replay_count,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .reset_method =3D &amp;soc15_asi=
c_reset_method<br>
&gt;&nbsp; };<br>
&gt;<br>
&gt;&nbsp; static int soc15_common_early_init(void *handle)<br>
&gt; --<br>
&gt; 2.23.0<br>
&gt;<br>
_______________________________________________<br>
amd-gfx mailing list<br>
amd-gfx@lists.freedesktop.org<br>
<a href=3D"https://lists.freedesktop.org/mailman/listinfo/amd-gfx">https://=
lists.freedesktop.org/mailman/listinfo/amd-gfx</a></div>
</span></font></div>
</body>
</html>

--_000_DM6PR12MB277836449EE0C8E5F07D02AFF0700DM6PR12MB2778namp_--

--===============2063422928==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4

--===============2063422928==--
