Return-Path: <SRS0=FndT=ZH=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7ACEC432C3
	for <amd-gfx@archiver.kernel.org>; Fri, 15 Nov 2019 14:49:50 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A3E0920732
	for <amd-gfx@archiver.kernel.org>; Fri, 15 Nov 2019 14:49:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A3E0920732
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 375F36E612;
	Fri, 15 Nov 2019 14:49:50 +0000 (UTC)
Received: from NAM04-CO1-obe.outbound.protection.outlook.com
 (mail-eopbgr690084.outbound.protection.outlook.com [40.107.69.84])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 77BBF6E612
 for <amd-gfx@lists.freedesktop.org>; Fri, 15 Nov 2019 14:49:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=etVbKUJ96QMdXnMfNATY5ADCwJQLlfvxhb8BOqdDx7mmCDKoSWhFraLnT+VDPdVMLt3h5r111I2RrdaWgv86itP2sUGyMBVI8xIOGg9dhajlO6alE8UQu+ctEi6JnXJoTOgr90Z6rNKNIRLsY+Ey2B+bbbrqgMDIKgnzHVrWpWRn1KTStZ0jDTh33eye3rAfDS6or7mzFsQyDvdklDqZzRZI4XnVTCN8zpUROzluTnWwO6tqc8f/z5wsvgRTu8o99VlIFSw+YWRqNOSTjcuZrtYmjoGoCTOsosBYQurzT6lWx4k00MN/81+R0UCg0WNuutrSq2BH4I3p4e+1kUnIeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uDWgrjraRQ8ADX0u9xj1Kx7e3IDOZyvCzko+T1eHMZM=;
 b=YK2QU7OZo6JRXR/1NXj6G4OX4NVXV1LF/5yX48J5991TG+gwzgE1xndV4AXp/AZs2nSMT0Ll0DdP64dv5wPRUez1qs4rp2lHlE0M20Z/O85RMOs6aTK4xQtOV3L5GyMmLnGXBGcn4NnWd18qfM1kMzO+0OzMf2Tu8pu8o/94IB0Ne/InNIPjsm7U7x6nMlld9XOYjkNrlrfjnW7T/Ys3PfLtcta6GxqWgMHpsYEEczTVptnN/3RLi4eJ8KbxlpvDNbMWtQmeNRE+tktj8MZleLt5HWFHSBht+AxKl0+xgUVAKasdUXxK/1mBTkf25fKj3Qp8UPbUKVWxVdGYmkuYGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
Received: from DM5PR12MB1820.namprd12.prod.outlook.com (10.175.88.143) by
 DM5PR12MB1753.namprd12.prod.outlook.com (10.175.88.144) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2451.28; Fri, 15 Nov 2019 14:49:47 +0000
Received: from DM5PR12MB1820.namprd12.prod.outlook.com
 ([fe80::a0bb:dcbd:9ae:7807]) by DM5PR12MB1820.namprd12.prod.outlook.com
 ([fe80::a0bb:dcbd:9ae:7807%5]) with mapi id 15.20.2451.023; Fri, 15 Nov 2019
 14:49:47 +0000
From: "Deucher, Alexander" <Alexander.Deucher@amd.com>
To: =?iso-8859-1?Q?Christian_K=F6nig?= <ckoenig.leichtzumerken@gmail.com>,
 "Liu, Aaron" <Aaron.Liu@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH 01/12] amdgpu: add UAPI for creating encrypted buffers
Thread-Topic: [PATCH 01/12] amdgpu: add UAPI for creating encrypted buffers
Thread-Index: AQHVm2WxCchiNxUMVkqNr26VA+wSX6eMMV+AgAAfex8=
Date: Fri, 15 Nov 2019 14:49:47 +0000
Message-ID:
 <DM5PR12MB182063DB1ACAD38C768ECAC3F7700@DM5PR12MB1820.namprd12.prod.outlook.com>
References: <1573788895-3936-1-git-send-email-aaron.liu@amd.com>,
 <06a979a0-0795-88cb-f1d9-80255165f0e4@gmail.com>
In-Reply-To: <06a979a0-0795-88cb-f1d9-80255165f0e4@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.58.219.229]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 14ba8678-5ab1-4df4-6b07-08d769db0f60
x-ms-traffictypediagnostic: DM5PR12MB1753:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM5PR12MB17531036018AB32E8ACD0278F7700@DM5PR12MB1753.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-forefront-prvs: 02229A4115
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(4636009)(136003)(39860400002)(376002)(366004)(396003)(346002)(189003)(199004)(7736002)(446003)(6436002)(71190400001)(71200400001)(55016002)(19627405001)(3846002)(6116002)(74316002)(2906002)(26005)(102836004)(186003)(105004)(110136005)(229853002)(99286004)(76176011)(54906003)(256004)(14444005)(53546011)(6506007)(54896002)(9686003)(81156014)(81166006)(478600001)(52536014)(25786009)(8676002)(8936002)(33656002)(5660300002)(64756008)(66556008)(7696005)(66946007)(66446008)(6246003)(2501003)(14454004)(66476007)(66066001)(76116006)(476003)(316002)(11346002)(486006)(4326008)(66574012)(86362001);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM5PR12MB1753;
 H:DM5PR12MB1820.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: GhinaTKxgcW8wIMnc08SfMmYZ296r0H3EXkPc/enozvNgNwP18eyIl5pnjh/jkR0KSwMoz0KAPIQJOMKA1k6ttH3+Sl8Qeuo6/TkBNVf/CH0HzZBgEbfM3yY4PBkDqm1f5E/GfDZUFdIH8Q9QS9/Ta+YKxUzYx+Uef1FAPvJa3VD4XQzWi02thR5DkrDrFnr4QgMJXsJCMglTph5ziSXzAksDYyHOLQDRn/XwbLp9zIFNax8x5Os/W5I3iHWZSXm8sEb5tp7wxk2wTxKd7erDtEvMWpguUiqKuG951A0SAqCBtnJQOqytJ2mb4dJAOz2zZe0EUIWcss1AuP7f7Id6gTRzWk8z7RW1LTn3nVOsNw6/AKyVmoGxat8IxfRE6vt3vK+0MhHmfANMedwb7fDpQIyuWXz32dDU+CX/5MPLt2Po6fks/hWE8v+kRi438Kf
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 14ba8678-5ab1-4df4-6b07-08d769db0f60
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Nov 2019 14:49:47.1236 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 41To/v9fXWODC9ARSv/P4wCb7SznYuRr7LuV5FdtpujNC6oJELHsMXzPyni5has+cEkuV5r2FLDjx0iEIYVCiA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1753
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uDWgrjraRQ8ADX0u9xj1Kx7e3IDOZyvCzko+T1eHMZM=;
 b=rJhKiY7BfdOzy+wCDa0R3FztkTWjFGUOkfjS/wh+vq6Tis7GMTZ8A39/DRD7Vx9x0W/CA5E5PQGPo89ipdQDH7JdsOg40UbdgNveVcdgQ6UW34CXNc4rhCgFKfqutlpWZMnuL4U2Z9+E5u7EEvOq5jFMe0LuaeI/KK1/Cfks2V0=
X-Mailman-Original-Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Deucher@amd.com; 
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
Cc: "Tuikov, Luben" <Luben.Tuikov@amd.com>, "Olsak,
 Marek" <Marek.Olsak@amd.com>, "Huang, Ray" <Ray.Huang@amd.com>, "Liu,
 Leo" <Leo.Liu@amd.com>, "Koenig, Christian" <Christian.Koenig@amd.com>
Content-Type: multipart/mixed; boundary="===============0468583008=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
Message-ID: <20191115144947.3fg_hI2X4RBSlVXXJfyyqKIpTYdLOM9wI8iPQGNgeyE@z>

--===============0468583008==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_DM5PR12MB182063DB1ACAD38C768ECAC3F7700DM5PR12MB1820namp_"

--_000_DM5PR12MB182063DB1ACAD38C768ECAC3F7700DM5PR12MB1820namp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

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


--_000_DM5PR12MB182063DB1ACAD38C768ECAC3F7700DM5PR12MB1820namp_
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
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
We can't land the kernel side until we have real userspace (e.g., Mesa) tha=
t uses the TMZ interfaces.&nbsp; The unit tests are not enough.</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
Alex</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div id=3D"appendonsend"></div>
<div style=3D"font-family:Calibri,Arial,Helvetica,sans-serif; font-size:12p=
t; color:rgb(0,0,0)">
<br>
</div>
<hr tabindex=3D"-1" style=3D"display:inline-block; width:98%">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font style=3D"font-size:11pt" face=
=3D"Calibri, sans-serif" color=3D"#000000"><b>From:</b> Christian K=F6nig &=
lt;ckoenig.leichtzumerken@gmail.com&gt;<br>
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
</body>
</html>

--_000_DM5PR12MB182063DB1ACAD38C768ECAC3F7700DM5PR12MB1820namp_--

--===============0468583008==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4

--===============0468583008==--
