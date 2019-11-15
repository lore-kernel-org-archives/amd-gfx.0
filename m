Return-Path: <SRS0=FndT=ZH=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC3EFC432C3
	for <amd-gfx@archiver.kernel.org>; Fri, 15 Nov 2019 19:34:28 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A133D206D9
	for <amd-gfx@archiver.kernel.org>; Fri, 15 Nov 2019 19:34:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A133D206D9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4244A6EA35;
	Fri, 15 Nov 2019 19:34:28 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-eopbgr770050.outbound.protection.outlook.com [40.107.77.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E94E06EA35
 for <amd-gfx@lists.freedesktop.org>; Fri, 15 Nov 2019 19:34:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=i7C2v2Y7wQ97ENPXghPNfTgJNMv0nusTz3cNT5YQD836wbsQ4+Ibw3zqWWtZZXsqeDyuXjv7yEITBVpQ1XRKgTDBfFKL4DwESMt8HMggzU+icwFT7IDiGWCxvemphba42Ce+p0knf8gbn3ryBXm2bPU+fhEq+YLeR+g3D6zsV1MUGpXEMZ9byBixkEITBj5sa8IwNce6VsweC7Qgz6abXUXMXaJ3RHkGihfWPqR1g3A/mgLpkztGwF1IQsfvUio591SuIUxtYh8Wctg8YpdKtONxb08dg1Ex1uFLxmneFMtdyTwjHEH0EGYK3mr1hNEmDqMGDwm8aOkDJCqf+W6lWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ap+9gesWmSYFwck8lBL3ElxiXLUA6Oo6WPvh//Pb4h0=;
 b=cJYoXOT4RMcN88Ccf6mx4VHvJzlSXJU6aXTRtQvkkJ4qAyV1VuISzPBeEu7GbikmJqCyFNIUbrUMdAPmUDFfNnEmLMIOB/fPwhPt8prWQhrfEuEOxr8+4BwTKKjS/TaJ1AdhcVq6iwkAFM13Sw78J3obwg8A4nZ+wL+ap2VdIQm+PkeYRwX9rhL2HeVAXWApu4TL+RlXBgbE9w9r08nBfF+RTdz+Sl1QdQ5n3RghvZaG5ePKzabXJyYOP4Kj7QgI1bZYzFF8enQZGhOJp6SGH94w/eioiWG9wVMBW6FUl44yiD63kZbQHD1TyXBlI8ZvlpJOzo4Ba/87MqJWYkbMhg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
Received: from DM6PR12MB3209.namprd12.prod.outlook.com (20.179.105.33) by
 DM6PR12MB2761.namprd12.prod.outlook.com (20.176.118.91) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2451.29; Fri, 15 Nov 2019 19:34:23 +0000
Received: from DM6PR12MB3209.namprd12.prod.outlook.com
 ([fe80::55f2:726e:999c:7e09]) by DM6PR12MB3209.namprd12.prod.outlook.com
 ([fe80::55f2:726e:999c:7e09%5]) with mapi id 15.20.2451.027; Fri, 15 Nov 2019
 19:34:23 +0000
From: "Olsak, Marek" <Marek.Olsak@amd.com>
To: "Koenig, Christian" <Christian.Koenig@amd.com>, "Deucher, Alexander"
 <Alexander.Deucher@amd.com>
Subject: Re: [PATCH 01/12] amdgpu: add UAPI for creating encrypted buffers
Thread-Topic: [PATCH 01/12] amdgpu: add UAPI for creating encrypted buffers
Thread-Index: AQHVm2WxLYEG+ywCwEWIkBwjXJ6Cf6eMMV+AgAAfr4CAAAUYgIAASZqd
Date: Fri, 15 Nov 2019 19:34:22 +0000
Message-ID:
 <DM6PR12MB32097BA0BE4D40FF431A6E11F9700@DM6PR12MB3209.namprd12.prod.outlook.com>
References: <1573788895-3936-1-git-send-email-aaron.liu@amd.com>,
 <06a979a0-0795-88cb-f1d9-80255165f0e4@gmail.com>,
 <DM5PR12MB182063DB1ACAD38C768ECAC3F7700@DM5PR12MB1820.namprd12.prod.outlook.com>,
 <1f6819bc-cf46-4f34-a569-9ba39a9c6559@email.android.com>
In-Reply-To: <1f6819bc-cf46-4f34-a569-9ba39a9c6559@email.android.com>
Accept-Language: en-CA, en-US
Content-Language: en-CA
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [165.204.55.251]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 4fe045fc-27fa-4ee7-5c8d-08d76a02d15d
x-ms-traffictypediagnostic: DM6PR12MB2761:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR12MB2761A0C9A773A6FA3964F887F9700@DM6PR12MB2761.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-forefront-prvs: 02229A4115
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(4636009)(376002)(136003)(39860400002)(396003)(366004)(346002)(189003)(199004)(74316002)(99286004)(486006)(7736002)(6436002)(186003)(14454004)(3846002)(446003)(33656002)(66446008)(64756008)(66556008)(66476007)(52536014)(66946007)(6116002)(105004)(229853002)(91956017)(478600001)(5660300002)(11346002)(19627405001)(2906002)(76116006)(66574012)(86362001)(476003)(66066001)(8676002)(81156014)(81166006)(54896002)(8936002)(4326008)(14444005)(110136005)(25786009)(54906003)(256004)(26005)(6506007)(316002)(7696005)(53546011)(55016002)(6246003)(76176011)(102836004)(71200400001)(71190400001)(6636002)(9686003);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM6PR12MB2761;
 H:DM6PR12MB3209.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: DquFLq3XxzJCDVpAdbH04e3zeqCeRXvNcl3wrc9RURL0DvSluHDLZqnxpLxnkvg+lUXKnExZ1PNbRmt2fzxom2KrCdOC5pceVO5XYo40NVMpS5xa8W0/WmaXWcDezI4ksl/KvlTqjyZYqbdeBp7x0QeEe+dYIlmYpIuob4O1IilE0/BYM1UIW7OnLvHWWbsIHAVYmDcDlSFHVvc4TV9P/L4zI/fSGFw9BxrWYsnCEbwVDdCKW0mm+h5blg0nBXwbbyd1Yw9o7f9pgEeXfRJO0+iJAdn/+NgdcdcA0kSeiHmN/UsTVZa/JYRCDS5wKws0jZh/g+/512NahzjDQKd4ztwxzHPF8vCSHxyKP7s8Jhz3pR5cpHsRPuH7sgUrmNApZ8i76Akw69ieleu4NCzU8Kot8quQWy/cx9tiMnInNXWDmeL6v7ajIM1FS36rsAHn
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4fe045fc-27fa-4ee7-5c8d-08d76a02d15d
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Nov 2019 19:34:22.9980 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dI3fTmcROJPaQvl5FoZHFW4h9Jo2YKwx/5HvZA6iQTuY2Sjc8iN0lADOK2o5DnBi
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2761
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ap+9gesWmSYFwck8lBL3ElxiXLUA6Oo6WPvh//Pb4h0=;
 b=gazr2XcyG/eTkXk01VECPb1/y5hRL+3IBq5rTPct8T6nq62wt+YqxPI5oLlDTtIFOBE0HJ6FWPVXj1TsmpySAzLq7wPUoFwBIyR1Hqe0HC74jJymRnLxzJw5Q2L3V8NGc8JCjvDPZdbmxSWvAMcvb3LcOLjGJJjijLlPxs2WoAE=
X-Mailman-Original-Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Marek.Olsak@amd.com; 
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
 "Huang, Ray" <Ray.Huang@amd.com>, "Liu, Aaron" <Aaron.Liu@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "Tuikov, 
 Luben" <Luben.Tuikov@amd.com>, "Liu, Leo" <Leo.Liu@amd.com>
Content-Type: multipart/mixed; boundary="===============0302910783=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
Message-ID: <20191115193422.aSQby9CbA4OVSk8hTqokZFLXv4zb9cG8KBnXoDIXKVU@z>

--===============0302910783==
Content-Language: en-CA
Content-Type: multipart/alternative;
	boundary="_000_DM6PR12MB32097BA0BE4D40FF431A6E11F9700DM6PR12MB3209namp_"

--_000_DM6PR12MB32097BA0BE4D40FF431A6E11F9700DM6PR12MB3209namp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

In the kernel tree, you need to do "make headers_install". Then copy amdgpu=
_drm.h from ./usr/ to the libdrm tree and discard parts that we can't upstr=
eam (freesync).

Marek
________________________________
From: Koenig, Christian <Christian.Koenig@amd.com>
Sent: November 15, 2019 10:08
To: Deucher, Alexander <Alexander.Deucher@amd.com>
Cc: Christian K=F6nig <ckoenig.leichtzumerken@gmail.com>; Liu, Aaron <Aaron=
.Liu@amd.com>; amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org=
>; Olsak, Marek <Marek.Olsak@amd.com>; Huang, Ray <Ray.Huang@amd.com>; Tuik=
ov, Luben <Luben.Tuikov@amd.com>; Liu, Leo <Leo.Liu@amd.com>
Subject: Re: [PATCH 01/12] amdgpu: add UAPI for creating encrypted buffers

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


--_000_DM6PR12MB32097BA0BE4D40FF431A6E11F9700DM6PR12MB3209namp_
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
In the kernel tree, you need to do &quot;make headers_install&quot;. Then c=
opy amdgpu_drm.h from ./usr/ to the libdrm tree and discard parts that we c=
an't upstream (freesync).</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
Marek<br>
</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Koenig, Christian &lt=
;Christian.Koenig@amd.com&gt;<br>
<b>Sent:</b> November 15, 2019 10:08<br>
<b>To:</b> Deucher, Alexander &lt;Alexander.Deucher@amd.com&gt;<br>
<b>Cc:</b> Christian K=F6nig &lt;ckoenig.leichtzumerken@gmail.com&gt;; Liu,=
 Aaron &lt;Aaron.Liu@amd.com&gt;; amd-gfx@lists.freedesktop.org &lt;amd-gfx=
@lists.freedesktop.org&gt;; Olsak, Marek &lt;Marek.Olsak@amd.com&gt;; Huang=
, Ray &lt;Ray.Huang@amd.com&gt;; Tuikov, Luben &lt;Luben.Tuikov@amd.com&gt;=
;
 Liu, Leo &lt;Leo.Liu@amd.com&gt;<br>
<b>Subject:</b> Re: [PATCH 01/12] amdgpu: add UAPI for creating encrypted b=
uffers</font>
<div>&nbsp;</div>
</div>
<style type=3D"text/css" style=3D"display:none">
<!--
p
	{margin-top:0;
	margin-bottom:0}
-->
</style>
<div dir=3D"ltr">
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
<div class=3D"x_gmail_extra"><br>
<div class=3D"x_gmail_quote">Am 15.11.2019 15:49 schrieb &quot;Deucher, Ale=
xander&quot; &lt;Alexander.Deucher@amd.com&gt;:<br type=3D"attribution">
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
<div id=3D"x_appendonsend"></div>
<div style=3D"font-family:Calibri,Arial,Helvetica,sans-serif; font-size:12p=
t; color:rgb(0,0,0)">
<br>
</div>
<hr tabindex=3D"-1" style=3D"display:inline-block; width:98%">
<div id=3D"x_divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" =
color=3D"#000000" style=3D"font-size:11pt"><b>From:</b> Christian K=F6nig &=
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
<div class=3D"x_BodyFragment"><font size=3D"2"><span style=3D"font-size:11p=
t">
<div class=3D"x_PlainText">Am 15.11.19 um 04:34 schrieb Aaron Liu:<br>
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
</div>
</body>
</html>

--_000_DM6PR12MB32097BA0BE4D40FF431A6E11F9700DM6PR12MB3209namp_--

--===============0302910783==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4

--===============0302910783==--
