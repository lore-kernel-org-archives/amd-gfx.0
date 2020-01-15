Return-Path: <SRS0=p2a1=3E=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6FD1C33C9E
	for <amd-gfx@archiver.kernel.org>; Wed, 15 Jan 2020 02:02:42 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 87BCE222C3
	for <amd-gfx@archiver.kernel.org>; Wed, 15 Jan 2020 02:02:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="zc3XW34N"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 87BCE222C3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E62276E821;
	Wed, 15 Jan 2020 02:02:41 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2086.outbound.protection.outlook.com [40.107.94.86])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E30776E821
 for <amd-gfx@lists.freedesktop.org>; Wed, 15 Jan 2020 02:02:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=c5Tp+2EiwQQTJpA6mLzPJbAToqXQe7sb2ELE2F52lQ5HZpgkxp0zW+49ozO3t4eS7xdLkuE4zRRpST1it1xIQwES1aDMqPYu7T+i/NU4WkHvFQj1MdHOYjQmHM56YYoNcqNSW//3k3sz0scQNo6Za3t/g4iDTfbJ+MK6QyjRa3Eg+bGP5zjJfPNDfqWjDBehb60FjA5uk0h7rqOfvpUA2NkaVDk3i5CK4vS/8KPcXXL9Vr9M5LS34jwQWKaX1u522Qiz79zqKDSNcWkXc0m3ARuj9Tsab7cruyPvNMBqloB2DBobdziRIpRQaFXOp28kicjpL8qdO+oAQFvoxWMVxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m/PkvU30EicOobLx8YY91nnZMlQUR4BZgfBN8QAqOdY=;
 b=CvL8fDmPa1fZwSAdIiUiUphQni6qrVRUExZ3KeyptQf/WQ1HU4diTAvETN9rrtKbH3DErUV0fwkN5o/tZiFpnQxRJA9+kZEVDwsZnlQAwgRZgtI9WEPfqrShmk4ntBDfphc5/1I0pZ7tweFMxjnP3cYOREs+2qH6Upi8yu3NRUxUthkcBbLgD6GY5Z1lyMBsVCyga4GQ5LCzQ03DjfrW/VWQX2JAI4UU7QqwVjSR07HfGjqbvbWLTs7nCtSDhMZ17NBMr5wYMZpHx4bUfttJi/YnJCoOD/K2um1ho7DnIdfnrLjnO0ec+JMptBbnqJ3V4phaWqp5ImsI8vSZXj1zNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m/PkvU30EicOobLx8YY91nnZMlQUR4BZgfBN8QAqOdY=;
 b=zc3XW34NANl5xOSyfhaWWHivQKRH2rXDQ1szWt6I6JuReoc+xvp0qemPWmq4xP0HGNnBh/xpbv0APjkfbDBRrU22gCV0PZdzEFcbGND2is+q/sD7b+DsItqDUxGu45zcXi9TvICRSCUNrg1CpPQr0wFoCBTE4q9lsQbx/4Rovtk=
Received: from MN2PR12MB2957.namprd12.prod.outlook.com (20.179.82.14) by
 MN2PR12MB3229.namprd12.prod.outlook.com (20.179.82.155) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2623.11; Wed, 15 Jan 2020 02:02:37 +0000
Received: from MN2PR12MB2957.namprd12.prod.outlook.com
 ([fe80::2cbe:ce2:60b5:7756]) by MN2PR12MB2957.namprd12.prod.outlook.com
 ([fe80::2cbe:ce2:60b5:7756%6]) with mapi id 15.20.2623.015; Wed, 15 Jan 2020
 02:02:36 +0000
From: "Yin, Tianci (Rico)" <Tianci.Yin@amd.com>
To: Alex Deucher <alexdeucher@gmail.com>
Subject: Re: [PATCH 2/2] drm/amdgpu/gfx10: update gfx golden settings for
 navi14
Thread-Topic: [PATCH 2/2] drm/amdgpu/gfx10: update gfx golden settings for
 navi14
Thread-Index: AQHVytAMmZmraaiZCU6iMn/xZkiPtKfqbXAAgACMmMc=
Date: Wed, 15 Jan 2020 02:02:36 +0000
Message-ID: <MN2PR12MB2957FD303FE96967B215F96E95370@MN2PR12MB2957.namprd12.prod.outlook.com>
References: <20200114112841.17148-1-tianci.yin@amd.com>
 <20200114112841.17148-2-tianci.yin@amd.com>,
 <CADnq5_PcAGeuzi1wAJvfd_sju3RwmsmQbyg6KMzfijm97QdGeA@mail.gmail.com>
In-Reply-To: <CADnq5_PcAGeuzi1wAJvfd_sju3RwmsmQbyg6KMzfijm97QdGeA@mail.gmail.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=True;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2020-01-15T02:02:36.175Z;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal
 Distribution
 Only; MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=0;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard; 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Tianci.Yin@amd.com; 
x-originating-ip: [180.167.199.189]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: b5e47847-d3c8-452f-de69-08d7995efe5e
x-ms-traffictypediagnostic: MN2PR12MB3229:|MN2PR12MB3229:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR12MB3229A81DCCE2FC3E881555A995370@MN2PR12MB3229.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:785;
x-forefront-prvs: 02830F0362
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(4636009)(39860400002)(136003)(396003)(346002)(376002)(366004)(189003)(199004)(5660300002)(2906002)(52536014)(66946007)(66476007)(53546011)(6506007)(64756008)(66556008)(66446008)(9686003)(45080400002)(478600001)(86362001)(966005)(7696005)(6916009)(4326008)(19627405001)(55016002)(71200400001)(316002)(8676002)(81156014)(81166006)(26005)(8936002)(15650500001)(186003)(91956017)(33656002)(76116006)(54906003);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MN2PR12MB3229;
 H:MN2PR12MB2957.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: whnRYZ2CW7ZflRooy/mn2pnJ4sFGi9zu1PUhjVm9uUVWEggr5dYxZMTfmRHCkGnwt3K57nxBPxcuYU+QajNMpXWr0f+jGrtlqIacNyr1FYqtNAunHrYRRyR7JeHzUH6jcKasLgSrafGxbAZ2+F8mch390KleBK3HApaOQfaOIPSMG6NO4otRv3yokwLP7A23/3gjvVJyMBxTZDL5BwU5A481er0duY0IHZlwZsVALTV/8au6aDW1N9Df3auw2LXmGZIVNDrw9XZQtyT0kztSvaIRfDsA0sb/Zs2VhfNXLKt/9Wr+ewE59nNhHupq/WYIqAvl6W1QuwAnewBYo0d70muPWIuQo3K8ReuyisplXUglEwiGsMCy6U1u1nmJ1M81nlvcqR4xHq86ylLtMS49qVnvDzpCxR1zxXbVI3q8s3ikaOPkukZ71DdUjHOS7lK8gunKy/oCgp4ApT91Ed11dD4ZCrzV6PzwZgA6U2kBf9c=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b5e47847-d3c8-452f-de69-08d7995efe5e
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Jan 2020 02:02:36.7451 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +I9NDHlSshhDCFyERo1uxvIsFt5rGp51T0c+hvgtwolvSWr6PAmiZBlpQ33Go07mPAkeUzexiN1PQEtE+cdfCg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3229
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
Cc: "Xu, Feifei" <Feifei.Xu@amd.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>, "Zhang,
 Hawking" <Hawking.Zhang@amd.com>
Content-Type: multipart/mixed; boundary="===============0253556775=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============0253556775==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_MN2PR12MB2957FD303FE96967B215F96E95370MN2PR12MB2957namp_"

--_000_MN2PR12MB2957FD303FE96967B215F96E95370MN2PR12MB2957namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only - Internal Distribution Only]

Thanks Alex!
________________________________
From: Alex Deucher <alexdeucher@gmail.com>
Sent: Wednesday, January 15, 2020 1:39
To: Yin, Tianci (Rico) <Tianci.Yin@amd.com>
Cc: amd-gfx list <amd-gfx@lists.freedesktop.org>; Xu, Feifei <Feifei.Xu@amd=
.com>; Zhang, Hawking <Hawking.Zhang@amd.com>
Subject: Re: [PATCH 2/2] drm/amdgpu/gfx10: update gfx golden settings for n=
avi14

On Tue, Jan 14, 2020 at 6:42 AM Tianci Yin <tianci.yin@amd.com> wrote:
>
> From: "Tianci.Yin" <tianci.yin@amd.com>
>
> remove registers: mmSPI_CONFIG_CNTL
> add registers: mmSPI_CONFIG_CNTL_1
>
> Change-Id: I0bbaeca184e7dc85463d6c5740151d6ba1b08c06
> Signed-off-by: Tianci.Yin <tianci.yin@amd.com>

Series is:
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd=
/amdgpu/gfx_v10_0.c
> index 4f6ffaf3f9be..3c9082b1eea9 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
> @@ -169,7 +169,7 @@ static const struct soc15_reg_golden golden_settings_=
gc_10_1_1[] =3D
>         SOC15_REG_GOLDEN_VALUE(GC, 0, mmPA_SC_ENHANCE_2, 0x00000800, 0x00=
000820),
>         SOC15_REG_GOLDEN_VALUE(GC, 0, mmPA_SC_LINE_STIPPLE_STATE, 0x0000f=
f0f, 0x00000000),
>         SOC15_REG_GOLDEN_VALUE(GC, 0, mmRMI_SPARE, 0xffffffff, 0xffff3101=
),
> -       SOC15_REG_GOLDEN_VALUE(GC, 0, mmSPI_CONFIG_CNTL, 0x001f0000, 0x00=
070105),
> +       SOC15_REG_GOLDEN_VALUE(GC, 0, mmSPI_CONFIG_CNTL_1, 0x001f0000, 0x=
00070105),
>         SOC15_REG_GOLDEN_VALUE(GC, 0, mmSQ_ALU_CLK_CTRL, 0xffffffff, 0xff=
ffffff),
>         SOC15_REG_GOLDEN_VALUE(GC, 0, mmSQ_ARB_CONFIG, 0x00000133, 0x0000=
0130),
>         SOC15_REG_GOLDEN_VALUE(GC, 0, mmSQ_LDS_CLK_CTRL, 0xffffffff, 0xff=
ffffff),
> --
> 2.17.1
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flists=
.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=3D02%7C01%7Ctianci=
.yin%40amd.com%7Cced760baf9c0451c0e6708d79918b31c%7C3dd8961fe4884e608e11a82=
d994e183d%7C0%7C0%7C637146203676595018&amp;sdata=3DFJMr7sM3nIICn2hPyZCX851E=
4%2BCQxvY4U2pD6Rga6X4%3D&amp;reserved=3D0

--_000_MN2PR12MB2957FD303FE96967B215F96E95370MN2PR12MB2957namp_
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
<p style=3D"font-family:Arial;font-size:10pt;color:#0078D7;margin:15pt;" al=
ign=3D"Left">
[AMD Official Use Only - Internal Distribution Only]<br>
</p>
<br>
<div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
Thanks Alex!<br>
</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Alex Deucher &lt;alex=
deucher@gmail.com&gt;<br>
<b>Sent:</b> Wednesday, January 15, 2020 1:39<br>
<b>To:</b> Yin, Tianci (Rico) &lt;Tianci.Yin@amd.com&gt;<br>
<b>Cc:</b> amd-gfx list &lt;amd-gfx@lists.freedesktop.org&gt;; Xu, Feifei &=
lt;Feifei.Xu@amd.com&gt;; Zhang, Hawking &lt;Hawking.Zhang@amd.com&gt;<br>
<b>Subject:</b> Re: [PATCH 2/2] drm/amdgpu/gfx10: update gfx golden setting=
s for navi14</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">On Tue, Jan 14, 2020 at 6:42 AM Tianci Yin &lt;tia=
nci.yin@amd.com&gt; wrote:<br>
&gt;<br>
&gt; From: &quot;Tianci.Yin&quot; &lt;tianci.yin@amd.com&gt;<br>
&gt;<br>
&gt; remove registers: mmSPI_CONFIG_CNTL<br>
&gt; add registers: mmSPI_CONFIG_CNTL_1<br>
&gt;<br>
&gt; Change-Id: I0bbaeca184e7dc85463d6c5740151d6ba1b08c06<br>
&gt; Signed-off-by: Tianci.Yin &lt;tianci.yin@amd.com&gt;<br>
<br>
Series is:<br>
Reviewed-by: Alex Deucher &lt;alexander.deucher@amd.com&gt;<br>
<br>
&gt; ---<br>
&gt;&nbsp; drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c | 2 &#43;-<br>
&gt;&nbsp; 1 file changed, 1 insertion(&#43;), 1 deletion(-)<br>
&gt;<br>
&gt; diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/=
amd/amdgpu/gfx_v10_0.c<br>
&gt; index 4f6ffaf3f9be..3c9082b1eea9 100644<br>
&gt; --- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c<br>
&gt; &#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c<br>
&gt; @@ -169,7 &#43;169,7 @@ static const struct soc15_reg_golden golden_se=
ttings_gc_10_1_1[] =3D<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; SOC15_REG_GOLDEN_VALUE=
(GC, 0, mmPA_SC_ENHANCE_2, 0x00000800, 0x00000820),<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; SOC15_REG_GOLDEN_VALUE=
(GC, 0, mmPA_SC_LINE_STIPPLE_STATE, 0x0000ff0f, 0x00000000),<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; SOC15_REG_GOLDEN_VALUE=
(GC, 0, mmRMI_SPARE, 0xffffffff, 0xffff3101),<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; SOC15_REG_GOLDEN_VALUE(GC, 0, mm=
SPI_CONFIG_CNTL, 0x001f0000, 0x00070105),<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; SOC15_REG_GOLDEN_VALUE(GC, 0=
, mmSPI_CONFIG_CNTL_1, 0x001f0000, 0x00070105),<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; SOC15_REG_GOLDEN_VALUE=
(GC, 0, mmSQ_ALU_CLK_CTRL, 0xffffffff, 0xffffffff),<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; SOC15_REG_GOLDEN_VALUE=
(GC, 0, mmSQ_ARB_CONFIG, 0x00000133, 0x00000130),<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; SOC15_REG_GOLDEN_VALUE=
(GC, 0, mmSQ_LDS_CLK_CTRL, 0xffffffff, 0xffffffff),<br>
&gt; --<br>
&gt; 2.17.1<br>
&gt;<br>
&gt; _______________________________________________<br>
&gt; amd-gfx mailing list<br>
&gt; amd-gfx@lists.freedesktop.org<br>
&gt; <a href=3D"https://nam11.safelinks.protection.outlook.com/?url=3Dhttps=
%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;amp;data=
=3D02%7C01%7Ctianci.yin%40amd.com%7Cced760baf9c0451c0e6708d79918b31c%7C3dd8=
961fe4884e608e11a82d994e183d%7C0%7C0%7C637146203676595018&amp;amp;sdata=3DF=
JMr7sM3nIICn2hPyZCX851E4%2BCQxvY4U2pD6Rga6X4%3D&amp;amp;reserved=3D0">
https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flists.f=
reedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;amp;data=3D02%7C01%7Ctian=
ci.yin%40amd.com%7Cced760baf9c0451c0e6708d79918b31c%7C3dd8961fe4884e608e11a=
82d994e183d%7C0%7C0%7C637146203676595018&amp;amp;sdata=3DFJMr7sM3nIICn2hPyZ=
CX851E4%2BCQxvY4U2pD6Rga6X4%3D&amp;amp;reserved=3D0</a><br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_MN2PR12MB2957FD303FE96967B215F96E95370MN2PR12MB2957namp_--

--===============0253556775==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============0253556775==--
