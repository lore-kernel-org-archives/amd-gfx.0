Return-Path: <SRS0=2jl+=GO=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFAD2C433E0
	for <amd-gfx@archiver.kernel.org>; Mon, 11 Jan 2021 20:23:47 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 69E7C22C7B
	for <amd-gfx@archiver.kernel.org>; Mon, 11 Jan 2021 20:23:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 69E7C22C7B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E782A89948;
	Mon, 11 Jan 2021 20:23:46 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2085.outbound.protection.outlook.com [40.107.220.85])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 51DD989948
 for <amd-gfx@lists.freedesktop.org>; Mon, 11 Jan 2021 20:23:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Mfn2CclDrDHy/FGK0TfZTAi060jooAsAxZgxad+BrpzJJ4JRUoo0mmKE5Z94M5iJR6wkl1X7ZddLLV9WqVZmdNZLfzZQEcWN7MRiEmYWF+hSiJWTtG0T7TvjftMZHH4X33eE5+oQQCxBB1JJyksvLniM9l6ftJ6ahiRsJ62VnJGpHmdXtTbZhH5xHdj18XMVpHEfQrXEmo3t9eUxP2zORXePf8uZajKsjkzzq+xMzov2RCZvHFIEJ/aN9AiZ4wwSyHmdlHHWz8f+gfLXQG6qMoma0RCSsHB1YuGEaO2uRxxvKY6vv8BkDWQmj7sXyQmEebZKjh2y7MVeQF2LJVZWMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D5KbWCxftBqpwjWINeLjUCyA8B9pEblPwJahNFRXGGY=;
 b=TbWgGys4Z7blVhnWPGBpj0mtP4XMdyh4z7o/vPNtXybb5QFBiMzK0osqrhVVV4pmdxU79Be7akCKqPNP/IqleAUCMQSzNu5uwe+5vDrYNp0yuPDqmJgNXBwu9V3i8IHS6RI/UiA1yWFA2e/9FlXfZLO4sLmfF0/NYYACi9GJ1jQXAXSeNKxDtw+MfaPg86NBqjdXH5K8DwpbI0opqvQyon22TxITXrQmw5HObH5tGTxUMOzv6UnNv2vF/cpLGyOveARLZifAvRjY2zPchGh69EyVDtKTkwX8iVoRBSfYlIV0wXKLZ5nLSimIGDGcWUGrXlC8uTb0/XtlXEBKr5WN2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D5KbWCxftBqpwjWINeLjUCyA8B9pEblPwJahNFRXGGY=;
 b=QDdthACA+EUFipBakSDA3Szfru2w0KQMbyiylmSdIbzH1wGG1EmkPBV/yYISc3VMuukIvXtUh8hOo2pDOKiW0otW0u9MUq+n9wquX4TwDIsPmH6U+Ouj4KqWVJSA0mngeqCSboinbUqGaJV7Z86gGU8Nc8AObjkbzkvfOUJS/fI=
Received: from MW3PR12MB4554.namprd12.prod.outlook.com (2603:10b6:303:55::21)
 by MWHPR1201MB2508.namprd12.prod.outlook.com (2603:10b6:300:df::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3742.6; Mon, 11 Jan
 2021 20:23:41 +0000
Received: from MW3PR12MB4554.namprd12.prod.outlook.com
 ([fe80::858e:d929:4fab:5ac3]) by MW3PR12MB4554.namprd12.prod.outlook.com
 ([fe80::858e:d929:4fab:5ac3%9]) with mapi id 15.20.3742.012; Mon, 11 Jan 2021
 20:23:41 +0000
From: "Lakha, Bhawanpreet" <Bhawanpreet.Lakha@amd.com>
To: "Kazlauskas, Nicholas" <Nicholas.Kazlauskas@amd.com>, "Chen, Guchun"
 <Guchun.Chen@amd.com>, "Deucher, Alexander" <Alexander.Deucher@amd.com>
Subject: Re: [PATCH] drm/amd/display: Fix deadlock during gpu reset
Thread-Topic: [PATCH] drm/amd/display: Fix deadlock during gpu reset
Thread-Index: AQHW6FPLKabgbf8wHEyn1kYIX0hcUaoi3j+AgAAANzI=
Date: Mon, 11 Jan 2021 20:23:41 +0000
Message-ID: <MW3PR12MB455499B85567AC768C0F8468F9AB0@MW3PR12MB4554.namprd12.prod.outlook.com>
References: <20210111195535.3102394-1-Bhawanpreet.Lakha@amd.com>,
 <8a5eb307-ee57-25c6-fdf3-ca7f3a9802d6@amd.com>
In-Reply-To: <8a5eb307-ee57-25c6-fdf3-ca7f3a9802d6@amd.com>
Accept-Language: en-CA, en-US
Content-Language: en-CA
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=True;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2021-01-11T20:23:40.356Z;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal
 Distribution
 Only; MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=0;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard; 
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [173.33.192.144]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 2bb8226b-7b27-497f-8e6f-08d8b66ec93c
x-ms-traffictypediagnostic: MWHPR1201MB2508:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MWHPR1201MB2508D5C7305722424F995958F9AB0@MWHPR1201MB2508.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Q2ujvKX1JvhbnXp1w/SWfzXNGrRMSE3eMm0XCyM22bY3TEh3ZQoGqqq9oc3dhtaTRo3n35ec6CSp4yrSV4AB+rOmYjS7FJpIPu3mNGZ5V/Vm0NbJYXRNob6ROfvmQ6l7XmfzH1Ed+MXWs9bsKt9afHZ+vgnEw0sjAX+T6RAT8PrcDjnkAcOh9lVhdta3je6nDU4n+iMFOKD2QtG4ce4c20PBuB9a9hjs1kIoORFHfIUy8npvxfE06jYi2SroY7TTA57ao5Y4GblqIwmfAzLXvZ+ljNIk0izue0CWL15xdhXLkDI0oN0S5y4u6aGrGb5MfyEVJY9bESqaFeHJuNK0RMKRafoLgBDsxE4e7KovQQzUVF2RBpgRKEcePcs9ux0A42kDWrwZp/iu2wri/r1zKA==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW3PR12MB4554.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(396003)(366004)(376002)(346002)(136003)(52536014)(110136005)(9686003)(19627405001)(71200400001)(83380400001)(186003)(55016002)(5660300002)(33656002)(8676002)(2906002)(26005)(91956017)(7696005)(478600001)(66446008)(76116006)(66946007)(66556008)(64756008)(4326008)(316002)(6636002)(8936002)(86362001)(53546011)(66476007)(6506007);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?cnt6/TDITDfYA6QJ47P+Aevzp/1G6XfMkuPOUTqMbfhOPvI0syeMW3d7j8E4?=
 =?us-ascii?Q?TNZLZSYMKclzTbaeobzxRfHyhiaQCH+IlhhHamoReg3J+GlTLFNb1j5SQGnl?=
 =?us-ascii?Q?uUIsFK9+IJZJIyoUrnbjFltEXnNETaAp9Zk92xMk8h0+4Z15WuijUJMEt5re?=
 =?us-ascii?Q?2qbYw3KUm5xvhAlKVFm9K3Y7Ajj2jA6CAK2xsiwhpLwCXvcNbdcRGTop049w?=
 =?us-ascii?Q?Gin1N7ng07eohAXTF12Qbp2gKKxjDjRskmVuE6qTJpPkqzZNNGTlNpm10aR7?=
 =?us-ascii?Q?PIG9X2EJRuLe8q92rftWoWZ//9ILWm+BYoGCN9u/pr6UkphX3S8KQi0k8Jgs?=
 =?us-ascii?Q?3nf04laYt8Z9ERsVWkiSe/jYouP1EXy+cH5E/hi++s7DIiSpXTtQQhTF+r/A?=
 =?us-ascii?Q?xRBub1HuE7yO7dlnJQt6If80vS4Z2LINpkmuthPcsKZqxyIgAmdQKCb9hupt?=
 =?us-ascii?Q?k0/3ObyLeDpYTQXHLQMZI5ODL5WGTyA8hviMP8qtAgNI3OmtkvwlLu0T+Qso?=
 =?us-ascii?Q?R/ORs7DGHV5mMP6bJtMfN5ccAjEOWHM6/d5JlS6FMHHgZ32pyv+sqVVdF7e4?=
 =?us-ascii?Q?eIoNIlHVLfHM04b2KtL8ryiEJPuAufXGfAEokN50itlZ3lzFXu3VWuQcSC8j?=
 =?us-ascii?Q?DeEtqjrzkaWyTIEHys6cJjbABTRE4IO3PbSldOgCHjhNr9QXwCVB8Xnds2aV?=
 =?us-ascii?Q?BCGXBhKhs2H+fSQnYg4CyPYVnGAQi2mA2za5kHQRmiqXQri1+5UKlsYtAp0l?=
 =?us-ascii?Q?V6Mh/Jja9Jia+53P0Gsj60xOQSzDRZRQIc8o0ExMXZq+l7PeECYeoWXreYDF?=
 =?us-ascii?Q?iE3aMjj/cnsIexfIc69/doeh7jiyPeglCVJkJs0Z2Y2VAYeqHVUDYb/uB6FZ?=
 =?us-ascii?Q?BIBK3/ujpUwXn8uDNvRKD6ysRxY9z6xKqNFHOuoizP11bsY9oYDyT6zM5l8Z?=
 =?us-ascii?Q?AXtADgtwAYDAl4K54gYmz4k+b7tWY7B1i/jpbR3B9vY=3D?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW3PR12MB4554.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2bb8226b-7b27-497f-8e6f-08d8b66ec93c
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Jan 2021 20:23:41.0119 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: b09TKFB1Y07+8rxWW+rYxQ0xUpzv1152dC//U8LL4Ggi+KwLXGUWAreKBiX1OCMC
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR1201MB2508
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
Cc: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Content-Type: multipart/mixed; boundary="===============0770395066=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============0770395066==
Content-Language: en-CA
Content-Type: multipart/alternative;
	boundary="_000_MW3PR12MB455499B85567AC768C0F8468F9AB0MW3PR12MB4554namp_"

--_000_MW3PR12MB455499B85567AC768C0F8468F9AB0MW3PR12MB4554namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only - Internal Distribution Only]

right, that makes more sense. I will post a v2 shortly
________________________________
From: Kazlauskas, Nicholas <Nicholas.Kazlauskas@amd.com>
Sent: January 11, 2021 3:22 PM
To: Lakha, Bhawanpreet <Bhawanpreet.Lakha@amd.com>; Chen, Guchun <Guchun.Ch=
en@amd.com>; Deucher, Alexander <Alexander.Deucher@amd.com>
Cc: amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH] drm/amd/display: Fix deadlock during gpu reset

On 2021-01-11 2:55 p.m., Bhawanpreet Lakha wrote:
> [Why]
> during idle optimizations we acquire the dc_lock, this lock is also
> acquired during gpu_reset so we end up hanging the system due to a
> deadlock
>
> [How]
> If we are in gpu reset dont acquire the dc lock, as we already have it

Are we sure this is the behavior we want?

I think if we are in GPU reset then we shouldn't be attempting to modify
idle optimization state at all, ie. return early if amdgpu_in_reset.

The calls around the locks are working around bad policy.

Regards,
Nicholas Kazlauskas

>
> Fixes: 06d5652541c3 ("drm/amd/display: enable idle optimizations for linu=
x (MALL stutter)")
> Signed-off-by: Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>
> ---
>   drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 6 ++++--
>   1 file changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/=
gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> index 99c7f9eb44aa..2170e1b2d32c 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> @@ -5556,7 +5556,8 @@ static inline int dm_set_vblank(struct drm_crtc *cr=
tc, bool enable)
>        if (!dc_interrupt_set(adev->dm.dc, irq_source, enable))
>                return -EBUSY;
>
> -     mutex_lock(&dm->dc_lock);
> +     if (!amdgpu_in_reset(adev))
> +             mutex_lock(&dm->dc_lock);
>
>        if (enable)
>                dm->active_vblank_irq_count++;
> @@ -5568,7 +5569,8 @@ static inline int dm_set_vblank(struct drm_crtc *cr=
tc, bool enable)
>
>        DRM_DEBUG_DRIVER("Allow idle optimizations (MALL): %d\n", dm->acti=
ve_vblank_irq_count =3D=3D 0);
>
> -     mutex_unlock(&dm->dc_lock);
> +     if (!amdgpu_in_reset(adev))
> +             mutex_unlock(&dm->dc_lock);
>
>        return 0;
>   }
>


--_000_MW3PR12MB455499B85567AC768C0F8468F9AB0MW3PR12MB4554namp_
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
<p style=3D"font-family:Arial;font-size:11pt;color:#0078D7;margin:5pt;" ali=
gn=3D"Left">
[AMD Official Use Only - Internal Distribution Only]<br>
</p>
<br>
<div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
right, that makes more sense. I will post a v2 shortly&nbsp; <br>
</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Kazlauskas, Nicholas =
&lt;Nicholas.Kazlauskas@amd.com&gt;<br>
<b>Sent:</b> January 11, 2021 3:22 PM<br>
<b>To:</b> Lakha, Bhawanpreet &lt;Bhawanpreet.Lakha@amd.com&gt;; Chen, Guch=
un &lt;Guchun.Chen@amd.com&gt;; Deucher, Alexander &lt;Alexander.Deucher@am=
d.com&gt;<br>
<b>Cc:</b> amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&=
gt;<br>
<b>Subject:</b> Re: [PATCH] drm/amd/display: Fix deadlock during gpu reset<=
/font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">On 2021-01-11 2:55 p.m., Bhawanpreet Lakha wrote:<=
br>
&gt; [Why]<br>
&gt; during idle optimizations we acquire the dc_lock, this lock is also<br=
>
&gt; acquired during gpu_reset so we end up hanging the system due to a<br>
&gt; deadlock<br>
&gt; <br>
&gt; [How]<br>
&gt; If we are in gpu reset dont acquire the dc lock, as we already have it=
<br>
<br>
Are we sure this is the behavior we want?<br>
<br>
I think if we are in GPU reset then we shouldn't be attempting to modify <b=
r>
idle optimization state at all, ie. return early if amdgpu_in_reset.<br>
<br>
The calls around the locks are working around bad policy.<br>
<br>
Regards,<br>
Nicholas Kazlauskas<br>
<br>
&gt; <br>
&gt; Fixes: 06d5652541c3 (&quot;drm/amd/display: enable idle optimizations =
for linux (MALL stutter)&quot;)<br>
&gt; Signed-off-by: Bhawanpreet Lakha &lt;Bhawanpreet.Lakha@amd.com&gt;<br>
&gt; ---<br>
&gt;&nbsp;&nbsp; drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 6 ++++=
--<br>
&gt;&nbsp;&nbsp; 1 file changed, 4 insertions(+), 2 deletions(-)<br>
&gt; <br>
&gt; diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drive=
rs/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c<br>
&gt; index 99c7f9eb44aa..2170e1b2d32c 100644<br>
&gt; --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c<br>
&gt; +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c<br>
&gt; @@ -5556,7 +5556,8 @@ static inline int dm_set_vblank(struct drm_crtc =
*crtc, bool enable)<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!dc_interrupt_set(adev-&=
gt;dm.dc, irq_source, enable))<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; return -EBUSY;<br>
&gt;&nbsp;&nbsp; <br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; mutex_lock(&amp;dm-&gt;dc_lock);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; if (!amdgpu_in_reset(adev))<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; mutex_lock(&amp;dm-&gt;dc_lock);<br>
&gt;&nbsp;&nbsp; <br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (enable)<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; dm-&gt;active_vblank_irq_count++;<br>
&gt; @@ -5568,7 +5569,8 @@ static inline int dm_set_vblank(struct drm_crtc =
*crtc, bool enable)<br>
&gt;&nbsp;&nbsp; <br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; DRM_DEBUG_DRIVER(&quot;Allow=
 idle optimizations (MALL): %d\n&quot;, dm-&gt;active_vblank_irq_count =3D=
=3D 0);<br>
&gt;&nbsp;&nbsp; <br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; mutex_unlock(&amp;dm-&gt;dc_lock);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; if (!amdgpu_in_reset(adev))<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; mutex_unlock(&amp;dm-&gt;dc_lock);<br>
&gt;&nbsp;&nbsp; <br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
&gt;&nbsp;&nbsp; }<br>
&gt; <br>
<br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_MW3PR12MB455499B85567AC768C0F8468F9AB0MW3PR12MB4554namp_--

--===============0770395066==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============0770395066==--
