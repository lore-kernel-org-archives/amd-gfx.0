Return-Path: <SRS0=ouc1=Y7=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84B40C43331
	for <amd-gfx@archiver.kernel.org>; Thu,  7 Nov 2019 17:15:51 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5F407206BA
	for <amd-gfx@archiver.kernel.org>; Thu,  7 Nov 2019 17:15:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5F407206BA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 251F96E121;
	Thu,  7 Nov 2019 17:15:51 +0000 (UTC)
Received: from NAM05-CO1-obe.outbound.protection.outlook.com
 (mail-eopbgr720045.outbound.protection.outlook.com [40.107.72.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 22B5B6E121
 for <amd-gfx@lists.freedesktop.org>; Thu,  7 Nov 2019 17:15:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LKqcMhtUiZq9WY0BY2w9RKvpofOgK/AjihUDRa/CvI1qEh14gnU0pt2WwVZzCC5Gb212P4PKO+pj0XuDnNGalpnlxaMR1bbTuNny6dWcSz5z7N+lTWmcxXGCNrvITtRegDKgGESw5HgqCkBPwxtpiMq4mGpCTMG56vMF8ZZOeT9C7b/ECGAs/s2TwTS31Pzn9NDkm3vqfZSF5xj6tR3VVvJtO6PueTkffSst1akPBLf+oNl/3jwlaYa2NcVLp8ycQ5/PPp539+7mcb8zdz5ev6xfVPKC4LHVs9tWtyPy1p/r6JJdduFGVjHkfnF8IbuZkY5c9FxfaSATDM32wYhviA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0KportUAODuP9cvChH2oSWnrb5dVfeF6dOzz0XhBzbs=;
 b=B30qth7ObaYZflLSPyXcJq0FbmQkd2dUK6kvCwcEHeDnyQfQPMk24AEImmgxlkoB/vdKMSZIw5BD7z2a+c3D/+S65uu+HU3V+KOzx24xdzXCvowZFeLk40UbfZiwBZdYpBLu46SPGKNGUqGMMGclJPQDIpDb8LK6tRPWmyMpcuVwKTR0mJqPjKFn13/AX0HhwzFhP34uJbb3zQkuPgDT/rskC6nF9Hx90aok59Pozv5LkBuJMOq7AB6+5D17a3O/uGJchD/B6wmNJTrn2hPPBIMr6HR72a3T+2s8CVWyQBWv9xFm/CwHVt7hoccIXdRXjUluwureofTLznxiMZ9Yrw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
Received: from DM6PR12MB2778.namprd12.prod.outlook.com (20.176.114.145) by
 DM6PR12MB3228.namprd12.prod.outlook.com (20.179.105.96) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2430.23; Thu, 7 Nov 2019 17:15:48 +0000
Received: from DM6PR12MB2778.namprd12.prod.outlook.com
 ([fe80::304d:db58:2aa:d69e]) by DM6PR12MB2778.namprd12.prod.outlook.com
 ([fe80::304d:db58:2aa:d69e%6]) with mapi id 15.20.2430.020; Thu, 7 Nov 2019
 17:15:48 +0000
From: "Zhao, Yong" <Yong.Zhao@amd.com>
To: Alex Deucher <alexdeucher@gmail.com>, "Zeng, Oak" <Oak.Zeng@amd.com>
Subject: Re: [PATCH] drm/amdgpu: Add comments to gmc structure
Thread-Topic: [PATCH] drm/amdgpu: Add comments to gmc structure
Thread-Index: AQHVlMdj9LKXevQ1Yk2iPklewez+uqd/vo0AgAA1ThQ=
Date: Thu, 7 Nov 2019 17:15:48 +0000
Message-ID:
 <DM6PR12MB2778E5EB97BBDE1FBFB3DA12F0780@DM6PR12MB2778.namprd12.prod.outlook.com>
References: <1573061209-13148-1-git-send-email-Oak.Zeng@amd.com>,
 <CADnq5_OinRnn+39TiX2SQkoBwwMPRO2vt0nTSLkwSBq-Mw2vBQ@mail.gmail.com>
In-Reply-To: <CADnq5_OinRnn+39TiX2SQkoBwwMPRO2vt0nTSLkwSBq-Mw2vBQ@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [165.204.54.211]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 365980d6-08da-4fce-1b31-08d763a62203
x-ms-traffictypediagnostic: DM6PR12MB3228:
x-ms-exchange-purlcount: 1
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR12MB32283585A099230D18206072F0780@DM6PR12MB3228.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5797;
x-forefront-prvs: 0214EB3F68
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(4636009)(346002)(136003)(376002)(366004)(396003)(39860400002)(199004)(189003)(14454004)(478600001)(25786009)(966005)(606006)(74316002)(6636002)(7736002)(8936002)(54896002)(6436002)(9686003)(236005)(6306002)(229853002)(2906002)(86362001)(81156014)(4326008)(6246003)(81166006)(8676002)(6506007)(316002)(66946007)(76116006)(91956017)(99286004)(33656002)(54906003)(55016002)(5660300002)(110136005)(256004)(14444005)(66066001)(7696005)(76176011)(486006)(476003)(66476007)(446003)(11346002)(3846002)(6116002)(19627405001)(71200400001)(66446008)(64756008)(66556008)(105004)(102836004)(71190400001)(26005)(186003)(53546011)(52536014);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM6PR12MB3228;
 H:DM6PR12MB2778.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: liYNCk4mHClKPgSy5hzeaVC5Qs2HfAXh1Hz6uJTKqypAigF2GLY3DBMT2ZejpcY5HGzRUqTldIbxZ5G+WMLLhQbJcItFqidj+kKVARK/tPsWATWQxAneXPjiH03IEMUkdZVvgKORb2qAcYcG5NmxsC+pGQZIHEX5u+CKL3rRappiDXV3Rp/YTl7PTgb75pH8zpIXjYzIMT0ZqskOJONcOX0bIYX8K+EDW2Mae1LV5T7llicORYRC1Ka/phEGph7N0xqL+UHaQUm3Jxz7YK+fNiGuZg4PSumVbgT5Okeo2mpckmltpTWE5QI9N6uVlICaoOzDDOCvSIWmBULAMeJct6i7CagvFdqOpUu856zl9GnGbl4k81/ssZ0gWmh/9HRCrQFjYMXrXKeNSW/Eg0KBUh/oqxa9NIwMQXTgfpU0V+S+3p1RdKaY9LiLanTS5Y1t6lHrDxQI3xttUw8y4GdNWvq7OLNZgl8BnzBvqfayRgo=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 365980d6-08da-4fce-1b31-08d763a62203
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Nov 2019 17:15:48.1814 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Yf1JTi02IH2SHCqlfrP99OHo1G+cYlmwN8lGUhv/4UuYePG9ssjCgG+WKOpI5qB4
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3228
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0KportUAODuP9cvChH2oSWnrb5dVfeF6dOzz0XhBzbs=;
 b=OeqBJotBRO/V0fIWt2rpKYyeHifiPnHYbAEnTLJzSBUDlg2XRFT/hOnzHz2gDRAaW1TVNoOtFISbOczJWrcsfAVa+ZmtXhFdU8NJdH/EzGQ2h+kK5Uz737ICc5VhQTh3BufMEEzn5K9l0EdVYMCurOoyuqwFTDa7Z5Lzhas+LGk=
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
Cc: "Kuehling, Felix" <Felix.Kuehling@amd.com>, "Koenig,
 Christian" <Christian.Koenig@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Content-Type: multipart/mixed; boundary="===============2117133194=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
Message-ID: <20191107171548.vrGUC1NYMkrvPxcUbzSeq4rqxMtcjLSqyKpyEeWmuxc@z>

--===============2117133194==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_DM6PR12MB2778E5EB97BBDE1FBFB3DA12F0780DM6PR12MB2778namp_"

--_000_DM6PR12MB2778E5EB97BBDE1FBFB3DA12F0780DM6PR12MB2778namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

If this is not submitted, I would like to see some comments regarding the e=
xplanation of MC address and logical address, which I prefer to mention as =
GPU physical/virtual address.

Regards,
Yong


________________________________
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> on behalf of Alex Deu=
cher <alexdeucher@gmail.com>
Sent: Thursday, November 7, 2019 9:02 AM
To: Zeng, Oak <Oak.Zeng@amd.com>
Cc: Kuehling, Felix <Felix.Kuehling@amd.com>; Koenig, Christian <Christian.=
Koenig@amd.com>; amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.o=
rg>
Subject: Re: [PATCH] drm/amdgpu: Add comments to gmc structure

On Wed, Nov 6, 2019 at 12:27 PM Zeng, Oak <Oak.Zeng@amd.com> wrote:
>
> Explain fields like aper_base, agp_start etc. The definition
> of those fields are confusing as they are from different view
> (CPU or GPU). Add comments for easier understand.
>
> Change-Id: I02c2a27cd0dbc205498eb86aafa722f2e0c25fe6
> Signed-off-by: Oak Zeng <Oak.Zeng@amd.com>

Same comments as the previous version.  With those addressed,
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h | 26 ++++++++++++++++++++++++++
>  1 file changed, 26 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_gmc.h
> index 555d8e5..1356ff9 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
> @@ -127,18 +127,44 @@ struct amdgpu_xgmi {
>  };
>
>  struct amdgpu_gmc {
> +       /* FB's physical address in MMIO space (for CPU to
> +        * map FB). This is different compared to the apg/
> +        * gart/vram_start/end field as the later is from
> +        * GPU's view and aper_base is from CPU's view.
> +        */
>         resource_size_t         aper_size;
>         resource_size_t         aper_base;
>         /* for some chips with <=3D 32MB we need to lie
>          * about vram size near mc fb location */
>         u64                     mc_vram_size;
>         u64                     visible_vram_size;
> +       /* APG aperture start and end in MC address space
> +        * Driver find a hole in the MC address space
> +        * to place AGP by setting MC_VM_AGP_BOT/TOP registers
> +        * Under VMID0, logical address =3D=3D MC address
> +        * AGP aperture is used to simulate FB in ZFB case
> +        */
>         u64                     agp_size;
>         u64                     agp_start;
>         u64                     agp_end;
> +       /* GART aperture start and end in MC address space
> +        * Driver find a hole in the MC address space
> +        * to place GART by setting VM_CONTEXT0_PAGE_TABLE_START/END_ADDR
> +        * registers
> +        * Under VMID0, logical address inside GART aperture will
> +        * be translated through gpuvm gart page table to access
> +        * paged system memory
> +        */
>         u64                     gart_size;
>         u64                     gart_start;
>         u64                     gart_end;
> +       /* Frame buffer aperture of this GPU device. Different from
> +        * fb_start (see below), this only covers the local GPU device.
> +        * Driver get fb_start from MC_VM_FB_LOCATION_BASE (set by vbios)
> +        * and calculate vram_start of this local device by adding an
> +        * offset inside the XGMI hive.
> +        * Under VMID0, logical address =3D=3D MC address
> +        */
>         u64                     vram_start;
>         u64                     vram_end;
>         /* FB region , it's same as local vram region in single GPU, in X=
GMI
> --
> 2.7.4
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--_000_DM6PR12MB2778E5EB97BBDE1FBFB3DA12F0780DM6PR12MB2778namp_
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
If this is not submitted, I would like to see some comments regarding the e=
xplanation of MC address and logical address, which I prefer to mention as =
GPU physical/virtual address.</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
Regards,</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
Yong</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> amd-gfx &lt;amd-gfx-b=
ounces@lists.freedesktop.org&gt; on behalf of Alex Deucher &lt;alexdeucher@=
gmail.com&gt;<br>
<b>Sent:</b> Thursday, November 7, 2019 9:02 AM<br>
<b>To:</b> Zeng, Oak &lt;Oak.Zeng@amd.com&gt;<br>
<b>Cc:</b> Kuehling, Felix &lt;Felix.Kuehling@amd.com&gt;; Koenig, Christia=
n &lt;Christian.Koenig@amd.com&gt;; amd-gfx@lists.freedesktop.org &lt;amd-g=
fx@lists.freedesktop.org&gt;<br>
<b>Subject:</b> Re: [PATCH] drm/amdgpu: Add comments to gmc structure</font=
>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">On Wed, Nov 6, 2019 at 12:27 PM Zeng, Oak &lt;Oak.=
Zeng@amd.com&gt; wrote:<br>
&gt;<br>
&gt; Explain fields like aper_base, agp_start etc. The definition<br>
&gt; of those fields are confusing as they are from different view<br>
&gt; (CPU or GPU). Add comments for easier understand.<br>
&gt;<br>
&gt; Change-Id: I02c2a27cd0dbc205498eb86aafa722f2e0c25fe6<br>
&gt; Signed-off-by: Oak Zeng &lt;Oak.Zeng@amd.com&gt;<br>
<br>
Same comments as the previous version.&nbsp; With those addressed,<br>
Reviewed-by: Alex Deucher &lt;alexander.deucher@amd.com&gt;<br>
<br>
&gt; ---<br>
&gt;&nbsp; drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h | 26 &#43;&#43;&#43;&#43=
;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43=
;&#43;&#43;&#43;&#43;&#43;&#43;&#43;<br>
&gt;&nbsp; 1 file changed, 26 insertions(&#43;)<br>
&gt;<br>
&gt; diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h b/drivers/gpu/drm=
/amd/amdgpu/amdgpu_gmc.h<br>
&gt; index 555d8e5..1356ff9 100644<br>
&gt; --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h<br>
&gt; &#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h<br>
&gt; @@ -127,18 &#43;127,44 @@ struct amdgpu_xgmi {<br>
&gt;&nbsp; };<br>
&gt;<br>
&gt;&nbsp; struct amdgpu_gmc {<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* FB's physical address in =
MMIO space (for CPU to<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * map FB). This is dif=
ferent compared to the apg/<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * gart/vram_start/end =
field as the later is from<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * GPU's view and aper_=
base is from CPU's view.<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; */<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; resource_size_t&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; aper_size;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; resource_size_t&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; aper_base;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* for some chips with=
 &lt;=3D 32MB we need to lie<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * about vram siz=
e near mc fb location */<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; u64&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp; mc_vram_size;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; u64&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp; visible_vram_size;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* APG aperture start and en=
d in MC address space<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * Driver find a hole i=
n the MC address space<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * to place AGP by sett=
ing MC_VM_AGP_BOT/TOP registers<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * Under VMID0, logical=
 address =3D=3D MC address<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * AGP aperture is used=
 to simulate FB in ZFB case<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; */<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; u64&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp; agp_size;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; u64&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp; agp_start;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; u64&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp; agp_end;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* GART aperture start and e=
nd in MC address space<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * Driver find a hole i=
n the MC address space<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * to place GART by set=
ting VM_CONTEXT0_PAGE_TABLE_START/END_ADDR<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * registers<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * Under VMID0, logical=
 address inside GART aperture will<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * be translated throug=
h gpuvm gart page table to access<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * paged system memory<=
br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; */<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; u64&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp; gart_size;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; u64&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp; gart_start;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; u64&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp; gart_end;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Frame buffer aperture of =
this GPU device. Different from<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * fb_start (see below)=
, this only covers the local GPU device.<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * Driver get fb_start =
from MC_VM_FB_LOCATION_BASE (set by vbios)<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * and calculate vram_s=
tart of this local device by adding an<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * offset inside the XG=
MI hive.<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * Under VMID0, logical=
 address =3D=3D MC address<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; */<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; u64&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp; vram_start;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; u64&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp; vram_end;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* FB region , it's sa=
me as local vram region in single GPU, in XGMI<br>
&gt; --<br>
&gt; 2.7.4<br>
&gt;<br>
&gt; _______________________________________________<br>
&gt; amd-gfx mailing list<br>
&gt; amd-gfx@lists.freedesktop.org<br>
&gt; <a href=3D"https://lists.freedesktop.org/mailman/listinfo/amd-gfx">htt=
ps://lists.freedesktop.org/mailman/listinfo/amd-gfx</a><br>
_______________________________________________<br>
amd-gfx mailing list<br>
amd-gfx@lists.freedesktop.org<br>
<a href=3D"https://lists.freedesktop.org/mailman/listinfo/amd-gfx">https://=
lists.freedesktop.org/mailman/listinfo/amd-gfx</a></div>
</span></font></div>
</body>
</html>

--_000_DM6PR12MB2778E5EB97BBDE1FBFB3DA12F0780DM6PR12MB2778namp_--

--===============2117133194==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4

--===============2117133194==--
