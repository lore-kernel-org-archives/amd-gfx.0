Return-Path: <SRS0=FndT=ZH=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23BF0C432C3
	for <amd-gfx@archiver.kernel.org>; Fri, 15 Nov 2019 15:08:05 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D115A20740
	for <amd-gfx@archiver.kernel.org>; Fri, 15 Nov 2019 15:08:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D115A20740
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7EC156E621;
	Fri, 15 Nov 2019 15:08:04 +0000 (UTC)
Received: from NAM04-BN3-obe.outbound.protection.outlook.com
 (mail-eopbgr680065.outbound.protection.outlook.com [40.107.68.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 23C496E7C0
 for <amd-gfx@lists.freedesktop.org>; Fri, 15 Nov 2019 15:08:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fuhCpU9py+CRPSv4IWLCakwlM4SdrHlZAnRcspyYJFlCPTtX12hFQMcYhEk7n+Umr08jjZn7Kj3sGapjb4SAHMP3SRMD1FvklV8G1MPwtUzjibAZSTuColcA33Zcs212AOPAPnpbWwECAw0Y8SGhsSHPtcGF9LeyW3tTIhTt9YaG1tkxqQE8wUjrob7ST1LBziHF23mA8c5gICFU2LmdW9ZguZ6zUiISiZ4DlAJ3s7LRgkVHSntWkHvmCWtcT8fikRPdmWNnWO1ULR7MKQcnn9iaDTp1wltk3l+OjOFjkULr8dN0WE5pU85vVgcmFVt/UNZN0pqUD/J1TPS81AqIlA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TuqfqMK+d+jBnOcLh0ykD0D+LyI7XzHwJro18ivfGWY=;
 b=PWKCrUTrC9kgQjbtftWfUygK8T99UqGtAe/FlwpaIKjhiJn2lejfYsuAkj+Qp26YfhHoci3ZfU1yMxG9qHUYaHHxjSRVaYa0SJQi4kvQqQElL9CSN20DgOqS4gpFKh1FWGcmU4Dlj0WyItG5ildIXjdvcU7WiokEmCCH4/p8IzpaE0WcWAj2uqbJAbst3oe2EIb4penMM4Pp7XDQtZ6nZpkM/zrv9oBDad6xc/Q4SAkyjfeNjOlzizXxoRDz2tlVkarE1TETSt0bWlvTua8REj+O8V1ZBvfs/9/ov3EMue9D0DmrKoE5Hwr7AFMXe39mhBrxjtsJyPOSb+wGS678IQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
Received: from BN6PR12MB1699.namprd12.prod.outlook.com (10.175.97.148) by
 BN6PR12MB1891.namprd12.prod.outlook.com (10.175.101.151) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2430.22; Fri, 15 Nov 2019 15:08:01 +0000
Received: from BN6PR12MB1699.namprd12.prod.outlook.com
 ([fe80::68e1:ddf5:df4c:b554]) by BN6PR12MB1699.namprd12.prod.outlook.com
 ([fe80::68e1:ddf5:df4c:b554%9]) with mapi id 15.20.2451.027; Fri, 15 Nov 2019
 15:08:01 +0000
From: "Koenig, Christian" <Christian.Koenig@amd.com>
To: "Deucher, Alexander" <Alexander.Deucher@amd.com>
Subject: Re: [PATCH 01/12] amdgpu: add UAPI for creating encrypted buffers
Thread-Topic: [PATCH 01/12] amdgpu: add UAPI for creating encrypted buffers
Thread-Index: AQHVm2Wx3o6hwVDLck+adu9lgZM6PqeMMV+AgAAfr4CAAAUYvQ==
Date: Fri, 15 Nov 2019 15:08:01 +0000
Message-ID: <1f6819bc-cf46-4f34-a569-9ba39a9c6559@email.android.com>
References: <1573788895-3936-1-git-send-email-aaron.liu@amd.com>,
 <06a979a0-0795-88cb-f1d9-80255165f0e4@gmail.com>,
 <DM5PR12MB182063DB1ACAD38C768ECAC3F7700@DM5PR12MB1820.namprd12.prod.outlook.com>
In-Reply-To: <DM5PR12MB182063DB1ACAD38C768ECAC3F7700@DM5PR12MB1820.namprd12.prod.outlook.com>
Accept-Language: de-DE, en-US
Content-Language: de-DE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [2a01:598:b880:6ea6:9f16:e00b:d3f4:efbe]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: d3c0851f-c611-4dff-0a23-08d769dd9b83
x-ms-traffictypediagnostic: BN6PR12MB1891:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BN6PR12MB1891DAB6F06A5AA14560332283700@BN6PR12MB1891.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-forefront-prvs: 02229A4115
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(979002)(4636009)(366004)(136003)(396003)(376002)(39860400002)(346002)(189003)(199004)(6636002)(54906003)(476003)(256004)(31686004)(229853002)(81156014)(66446008)(4326008)(11346002)(7736002)(81166006)(316002)(6486002)(19627405001)(2906002)(6116002)(5660300002)(14454004)(99286004)(25786009)(86362001)(31696002)(446003)(6506007)(76176011)(66574012)(8936002)(478600001)(66556008)(8676002)(66946007)(64756008)(6436002)(91956017)(76116006)(9686003)(6512007)(6246003)(54896002)(186003)(53546011)(14444005)(46003)(102836004)(486006)(6862004)(71190400001)(66476007)(71200400001)(969003)(989001)(999001)(1009001)(1019001);
 DIR:OUT; SFP:1101; SCL:1; SRVR:BN6PR12MB1891;
 H:BN6PR12MB1699.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Zo/bJEiRVFnFZ7JYy7bayD4rMD2TCTa3wRk8pcdiVzF8ou5uJWnR5bc5YcLCpT9Zuzf7C8sIS8hb5cZMiD4XaACE7fBC8dLnJZ3MfCEuswJeAjFCyokTKBERo9zMfTvT+7Gcv6Sdmm2OFh3ntCMwgVu0pB58RvnTstAT/82Au1LF9BZBA3XTejMwCtGs6ItnK0LnrBaY9kKarzBzPZwnUovr0DeKlzEFgejkX4BZCOcvU1Ap9NN9xRQRdDXH//ArIiQtPiCvog0C3AcLqMabIZJaMG2TsWlMwgs75LNqtfADDIMmmquQB9xhXDlbxi/552xYzGx0gQ9ODPz1+H2mI7eLxqOaw3NBakCFp9g2uuuR3aVvt3WChIiLFNpcRozf2cEhXOfhKZ4KQ0TEWIH7XTP45+QAIr1y5JbKjKjvJoJeK+oNV4VRgqkFNgUVMp5Q
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d3c0851f-c611-4dff-0a23-08d769dd9b83
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Nov 2019 15:08:01.2970 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bErzzPi0pxvKdEbpzp64wvbxJegaz2kl5TanbKxymGqB8GTowmwoEAuvnuTUiY2j
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR12MB1891
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TuqfqMK+d+jBnOcLh0ykD0D+LyI7XzHwJro18ivfGWY=;
 b=UkSgv4+Zj+iE8i02eoVmruDqlz6v6AwXBCvBZDBeSOkPmr/QVEy9RNX7xYJLSOBCb2x6yJxCm4ju1JInY05FVQDa802jwfaKQXHYWpWqq0BCcfMn1LNH8yyf0oVxdIj6w4JPoAPb2zkpTGVH30lIFPlzMgEERT1QCueWIsKz+jE=
X-Mailman-Original-Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Christian.Koenig@amd.com; 
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
Cc: =?iso-8859-1?Q?Christian_K=F6nig?= <ckoenig.leichtzumerken@gmail.com>,
 "Olsak, Marek" <Marek.Olsak@amd.com>, "Huang, Ray" <Ray.Huang@amd.com>, "Liu,
 Aaron" <Aaron.Liu@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "Tuikov,
 Luben" <Luben.Tuikov@amd.com>, "Liu, Leo" <Leo.Liu@amd.com>
Content-Type: multipart/mixed; boundary="===============0510719028=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
Message-ID: <20191115150801.2pDEqo4OqX4W4xCIVtvIcPHVEhya5JQ-zfRRZUMF1uI@z>

--===============0510719028==
Content-Language: de-DE
Content-Type: multipart/alternative;
	boundary="_000_1f6819bccf464f34a5699ba39a9c6559emailandroidcom_"

--_000_1f6819bccf464f34a5699ba39a9c6559emailandroidcom_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

I know, that's the usual chicken and egg problem with updating libdrm.

But we should update the file with the kernel version and not pick all chan=
ges line by line.

Christian.

Am 15.11.2019 15:49 schrieb "Deucher, Alexander" <Alexander.Deucher@amd.com=
>:
We can't land the kernel side until we have real userspace (e.g., Mesa) tha=
t uses the TMZ interfaces.  The unit tests are not enough.

Alex


________________________________
From: Christian K=F6nig <ckoenig.leichtzumerken@gmail.com>
Sent: Friday, November 15, 2019 7:56 AM
To: Liu, Aaron <Aaron.Liu@amd.com>; amd-gfx@lists.freedesktop.org <amd-gfx@=
lists.freedesktop.org>
Cc: Olsak, Marek <Marek.Olsak@amd.com>; Huang, Ray <Ray.Huang@amd.com>; Tui=
kov, Luben <Luben.Tuikov@amd.com>; Deucher, Alexander <Alexander.Deucher@am=
d.com>; Liu, Leo <Leo.Liu@amd.com>; Koenig, Christian <Christian.Koenig@amd=
.com>
Subject: Re: [PATCH 01/12] amdgpu: add UAPI for creating encrypted buffers

Am 15.11.19 um 04:34 schrieb Aaron Liu:
> From: Huang Rui <ray.huang@amd.com>
>
> To align the kernel uapi change from Alex:
>
> "Add a flag to the GEM_CREATE ioctl to create encrypted buffers. Buffers =
with
> this flag set will be created with the TMZ bit set in the PTEs or engines
> accessing them. This is required in order to properly access the data fro=
m the
> engines."
>
> We will use GEM_CREATE_ENCRYPTED flag for secure buffer allocation.
>
> Signed-off-by: Huang Rui <ray.huang@amd.com>
> Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

Please read up on how amdpu_drm.h is updated. The change must first land
upstream and then the file is synced up somehow semi-automatic.

Christian.

> ---
>   include/drm/amdgpu_drm.h | 5 +++++
>   1 file changed, 5 insertions(+)
>
> diff --git a/include/drm/amdgpu_drm.h b/include/drm/amdgpu_drm.h
> index 5c28aa7..1a95e37 100644
> --- a/include/drm/amdgpu_drm.h
> +++ b/include/drm/amdgpu_drm.h
> @@ -141,6 +141,11 @@ extern "C" {
>    * releasing the memory
>    */
>   #define AMDGPU_GEM_CREATE_VRAM_WIPE_ON_RELEASE      (1 << 9)
> +/* Flag that BO will be encrypted and that the TMZ bit should be
> + * set in the PTEs when mapping this buffer via GPUVM or
> + * accessing it with various hw blocks
> + */
> +#define AMDGPU_GEM_CREATE_ENCRYPTED          (1 << 10)
>
>   /* Hybrid specific */
>   /* Flag that the memory allocation should be from top of domain */


--_000_1f6819bccf464f34a5699ba39a9c6559emailandroidcom_
Content-Type: text/html; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Diso-8859-=
1">
<meta content=3D"text/html; charset=3Diso-8859-1">
<style type=3D"text/css" style=3D"display:none">
<!--
p
	{margin-top:0;
	margin-bottom:0}
-->
</style>
</head>
<body dir=3D"ltr">
<div dir=3D"auto">I know, that's the usual chicken and egg problem with upd=
ating libdrm.
<div dir=3D"auto"><br>
</div>
<div dir=3D"auto">But we should update the file with the kernel version and=
 not pick all changes line by line.</div>
<div dir=3D"auto"><br>
</div>
<div dir=3D"auto">Christian.</div>
</div>
<div class=3D"gmail_extra"><br>
<div class=3D"gmail_quote">Am 15.11.2019 15:49 schrieb &quot;Deucher, Alexa=
nder&quot; &lt;Alexander.Deucher@amd.com&gt;:<br type=3D"attribution">
</div>
</div>
<div>
<div style=3D"font-family:Calibri,Arial,Helvetica,sans-serif; font-size:12p=
t; color:rgb(0,0,0)">
We can't land the kernel side until we have real userspace (e.g., Mesa) tha=
t uses the TMZ interfaces.&nbsp; The unit tests are not enough.</div>
<div style=3D"font-family:Calibri,Arial,Helvetica,sans-serif; font-size:12p=
t; color:rgb(0,0,0)">
<br>
</div>
<div style=3D"font-family:Calibri,Arial,Helvetica,sans-serif; font-size:12p=
t; color:rgb(0,0,0)">
Alex</div>
<div style=3D"font-family:Calibri,Arial,Helvetica,sans-serif; font-size:12p=
t; color:rgb(0,0,0)">
<br>
</div>
<div id=3D"appendonsend"></div>
<div style=3D"font-family:Calibri,Arial,Helvetica,sans-serif; font-size:12p=
t; color:rgb(0,0,0)">
<br>
</div>
<hr tabindex=3D"-1" style=3D"display:inline-block; width:98%">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" co=
lor=3D"#000000" style=3D"font-size:11pt"><b>From:</b> Christian K=F6nig &lt=
;ckoenig.leichtzumerken@gmail.com&gt;<br>
<b>Sent:</b> Friday, November 15, 2019 7:56 AM<br>
<b>To:</b> Liu, Aaron &lt;Aaron.Liu@amd.com&gt;; amd-gfx@lists.freedesktop.=
org &lt;amd-gfx@lists.freedesktop.org&gt;<br>
<b>Cc:</b> Olsak, Marek &lt;Marek.Olsak@amd.com&gt;; Huang, Ray &lt;Ray.Hua=
ng@amd.com&gt;; Tuikov, Luben &lt;Luben.Tuikov@amd.com&gt;; Deucher, Alexan=
der &lt;Alexander.Deucher@amd.com&gt;; Liu, Leo &lt;Leo.Liu@amd.com&gt;; Ko=
enig, Christian &lt;Christian.Koenig@amd.com&gt;<br>
<b>Subject:</b> Re: [PATCH 01/12] amdgpu: add UAPI for creating encrypted b=
uffers</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt"=
>
<div class=3D"PlainText">Am 15.11.19 um 04:34 schrieb Aaron Liu:<br>
&gt; From: Huang Rui &lt;ray.huang@amd.com&gt;<br>
&gt;<br>
&gt; To align the kernel uapi change from Alex:<br>
&gt;<br>
&gt; &quot;Add a flag to the GEM_CREATE ioctl to create encrypted buffers. =
Buffers with<br>
&gt; this flag set will be created with the TMZ bit set in the PTEs or engi=
nes<br>
&gt; accessing them. This is required in order to properly access the data =
from the<br>
&gt; engines.&quot;<br>
&gt;<br>
&gt; We will use GEM_CREATE_ENCRYPTED flag for secure buffer allocation.<br=
>
&gt;<br>
&gt; Signed-off-by: Huang Rui &lt;ray.huang@amd.com&gt;<br>
&gt; Reviewed-by: Alex Deucher &lt;alexander.deucher@amd.com&gt;<br>
<br>
Please read up on how amdpu_drm.h is updated. The change must first land <b=
r>
upstream and then the file is synced up somehow semi-automatic.<br>
<br>
Christian.<br>
<br>
&gt; ---<br>
&gt;&nbsp;&nbsp; include/drm/amdgpu_drm.h | 5 &#43;&#43;&#43;&#43;&#43;<br>
&gt;&nbsp;&nbsp; 1 file changed, 5 insertions(&#43;)<br>
&gt;<br>
&gt; diff --git a/include/drm/amdgpu_drm.h b/include/drm/amdgpu_drm.h<br>
&gt; index 5c28aa7..1a95e37 100644<br>
&gt; --- a/include/drm/amdgpu_drm.h<br>
&gt; &#43;&#43;&#43; b/include/drm/amdgpu_drm.h<br>
&gt; @@ -141,6 &#43;141,11 @@ extern &quot;C&quot; {<br>
&gt;&nbsp;&nbsp;&nbsp; * releasing the memory<br>
&gt;&nbsp;&nbsp;&nbsp; */<br>
&gt;&nbsp;&nbsp; #define AMDGPU_GEM_CREATE_VRAM_WIPE_ON_RELEASE&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp; (1 &lt;&lt; 9)<br>
&gt; &#43;/* Flag that BO will be encrypted and that the TMZ bit should be<=
br>
&gt; &#43; * set in the PTEs when mapping this buffer via GPUVM or<br>
&gt; &#43; * accessing it with various hw blocks<br>
&gt; &#43; */<br>
&gt; &#43;#define AMDGPU_GEM_CREATE_ENCRYPTED&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; (1 &lt;&lt; 10)<br>
&gt;&nbsp;&nbsp; <br>
&gt;&nbsp;&nbsp; /* Hybrid specific */<br>
&gt;&nbsp;&nbsp; /* Flag that the memory allocation should be from top of d=
omain */<br>
<br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_1f6819bccf464f34a5699ba39a9c6559emailandroidcom_--

--===============0510719028==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4

--===============0510719028==--
