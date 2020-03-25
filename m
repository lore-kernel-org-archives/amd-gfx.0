Return-Path: <SRS0=Seja=5K=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4ABB3C43331
	for <amd-gfx@archiver.kernel.org>; Wed, 25 Mar 2020 11:13:20 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1ACEE20714
	for <amd-gfx@archiver.kernel.org>; Wed, 25 Mar 2020 11:13:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="aDkqPqFc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1ACEE20714
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BE2066E7FA;
	Wed, 25 Mar 2020 11:13:19 +0000 (UTC)
Received: from NAM02-BL2-obe.outbound.protection.outlook.com
 (mail-eopbgr750042.outbound.protection.outlook.com [40.107.75.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 573B56E7F1
 for <amd-gfx@lists.freedesktop.org>; Wed, 25 Mar 2020 11:13:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VrOGh8kBUQaXweCylxjS1XB3QKW0XsQN8p9UHC4OHUH9P3LwSP5GK9BP+B38W85OOtUcCNdJHdwXT3mGjpe6wZC84yWzuaCSs680FztVShXbYXJbQpFzWJthXFLnOQXVtiJLdu7+vIcn4ZIcijfT6uLLCpYWj2JEoK2De0Vqq1pMp4JKngZEDk7O11akiLZt9RF8ydYHYreDL2clKOhHOFcj+ykgHJd1g+rtcNjvjT/20Snr5xRbk78aODc8mnawF1c8p0arZIFDx1D+eOJy4LfLdGEY7HZuUvsuwoJiXqR9bcNsj5kEKYqrPUEuoauNLYVsHO5+A7GpMOD0IXBXvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Hr3RxbJWaR/3bTWJscP3paOgkqZu0VOY03XbdWBFsyc=;
 b=Y+PBeN6vmflnsn3LwqweLPCdyHBpJ+6WMczONRkqrcMpcJ6uv8x5QXIM95xf4pnXvVNTrXtQTiy6wKR1lWRD1hR0Y97XYVxY55EHYdE5ue3qbmnmi3XPCgyzFqjFCC7Ts+XoP8Ou0Wz69r1UzQVwWrfgIFE71zqCj+tSTtsSWg854ieLt7dp2ruF8kUov1YETh0HWBY0gUGOPd443SCpWcNJyCSSWJ/JbxR5RbHyx8AiqXUreWuL4uM5HVqtLO6cQnPe7ft/qCfPy9ItU024e2W7AAog24FOueG0jSS900eg70WlVR7WPYtt+8JjSmALlhRLXCY4UP3qTzkiolOGpQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Hr3RxbJWaR/3bTWJscP3paOgkqZu0VOY03XbdWBFsyc=;
 b=aDkqPqFcYgKiF2o3jKAIxDxCsyeYP1tnVYxPvCO7emAAF1KxI3c17VZxuaEyP1xeKC16BcPWQpNpDnwRY0KvYQ+pAr5lhn3jxx351IZWpRVu7Jm6qwXQkdsJno1qQhT8CtbuvH8N15+gQ5SxVRgkB3TOux49Rj7w8FRpcC2LaZU=
Received: from DM5PR12MB1578.namprd12.prod.outlook.com (2603:10b6:4:e::7) by
 DM5PR12MB2536.namprd12.prod.outlook.com (2603:10b6:4:b3::36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2835.22; Wed, 25 Mar 2020 11:13:14 +0000
Received: from DM5PR12MB1578.namprd12.prod.outlook.com
 ([fe80::50f0:a148:4f52:701f]) by DM5PR12MB1578.namprd12.prod.outlook.com
 ([fe80::50f0:a148:4f52:701f%11]) with mapi id 15.20.2835.023; Wed, 25 Mar
 2020 11:13:14 +0000
From: "Koenig, Christian" <Christian.Koenig@amd.com>
To: "Das, Nirmoy" <Nirmoy.Das@amd.com>
Subject: Re: [PATCH] drm/amdgpu: Check entity rq
Thread-Topic: [PATCH] drm/amdgpu: Check entity rq
Thread-Index: AQHWApWRIrmoYUjKuUanhsuUe+l6C6hZJ9MA////wkc=
Date: Wed, 25 Mar 2020 11:13:13 +0000
Message-ID: <32e5b144-228c-44d9-8576-3941dc99d8d5@email.android.com>
References: <20200325110702.30919-1-xinhui.pan@amd.com>,
 <8e0e3469-0c41-fbb9-1acf-aff8ff7e783e@amd.com>
In-Reply-To: <8e0e3469-0c41-fbb9-1acf-aff8ff7e783e@amd.com>
Accept-Language: de-DE, en-US
Content-Language: de-DE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Christian.Koenig@amd.com; 
x-originating-ip: [2a02:908:1252:fb60:dc49:624f:5fe9:21c1]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: e8d879c8-d22b-4d8f-2f45-08d7d0ad82e5
x-ms-traffictypediagnostic: DM5PR12MB2536:|DM5PR12MB2536:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM5PR12MB2536E754F1206FC49E92439783CE0@DM5PR12MB2536.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 0353563E2B
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(4636009)(366004)(39860400002)(376002)(396003)(346002)(136003)(53546011)(966005)(31696002)(6862004)(6506007)(478600001)(6636002)(21615005)(71200400001)(5660300002)(66574012)(64756008)(2906002)(4326008)(66556008)(66446008)(66476007)(76116006)(91956017)(81166006)(86362001)(66946007)(81156014)(8936002)(54906003)(6486002)(6512007)(31686004)(9686003)(8676002)(316002)(186003);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM5PR12MB2536;
 H:DM5PR12MB1578.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: TaZ3mFaJ+PGpxkZ+YY7ondD+4c7VowGLo0dT4G/BReGr3DXuEW2Nn+uutfExvHg/oQEU6ve7r7GqmXQ+Xe0YNTTd/T5oTQPEFcwpYwv1M2Pz5BIeNNCd6X+UBcllR8ILRg8brl3PnRDU01Eek3QscWijpa/C7EgRr1up9pZPE7B5YfbLyEG/e7mErm//cqIQiws8tOPIhDxe+SC1G7/8jfzKybQv9EsfLsWFD10lKcIgPdO+4HSE9jakwOU5j9aWw8J70/qD6O+zIR4rVMKoIlcvQc5FT2G6Rtn6MdmtXLr98M6jYmQ7qEME/2BFVd3Sys36DAH3e5NsnJX2+p3Wj/PY1XxHvZjwJaMTjkuu3FUcKohjpEHnje6RnjI5H7nVffwzZsIDHHkOJ82RzA+QlgmIt/7ynFP43cdAPgpdTDq6cYkbn3csVuzCSLfGLPHdUDSxd2NEgA2NK1w0rxtLRN6+5VS0Ne/Ah0WOTokJq4Y=
x-ms-exchange-antispam-messagedata: ay/1fReZe1sa416nhp0M7q518Zt7/Gk/e2yPOXGqJMF9s24g+btf58KJk7O96lxIi2c/RcLkrxYVeOYYtd/bhaIXgazYV+t6ENzVHq4jTvNHFRiK4uSAgTXgM67ImBwJNrhtfebb7t5K0nRxfqflaxYhewtQNDFMPg6egiYUYFzkc6AT/nx0oz6uEom4hpusl0qEKEmrJdkwucDEdVGR+w==
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e8d879c8-d22b-4d8f-2f45-08d7d0ad82e5
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Mar 2020 11:13:13.8572 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: leIEFKvikiFB61jyQiDpiQJluUiRyDPdqw+Q9Sz/AEnmsiLrSogvtFI3V18NaiU+
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB2536
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Kuehling,
 Felix" <Felix.Kuehling@amd.com>, "Pan, Xinhui" <Xinhui.Pan@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Content-Type: multipart/mixed; boundary="===============1909092934=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============1909092934==
Content-Language: de-DE
Content-Type: multipart/alternative;
	boundary="_000_32e5b144228c44d985763941dc99d8d5emailandroidcom_"

--_000_32e5b144228c44d985763941dc99d8d5emailandroidcom_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Hi guys,

thanks for pointing this out Nirmoy.

Yeah, could be that I forgot to commit the patch. Currently I don't know at=
 which end of the chaos I should start to clean up.

Christian.

Am 25.03.2020 12:09 schrieb "Das, Nirmoy" <Nirmoy.Das@amd.com>:
Hi Xinhui,


Can you please check if you can reproduce the crash with
https://lists.freedesktop.org/archives/amd-gfx/2020-February/046414.html

Christian fix it earlier, I think he forgot to push it.


Regards,

Nirmoy

On 3/25/20 12:07 PM, xinhui pan wrote:
> gpu recover will call sdma suspend/resume. In this period, ring will be
> disabled. So the vm_pte_scheds(sdma.instance[X].ring.sched)->ready will
> be false.
>
> If we submit any jobs in this ring-disabled period. We fail to pick up
> a rq for vm entity and entity->rq will set to NULL.
> amdgpu_vm_sdma_commit did not check the entity->rq, so fix it. Otherwise
> hit panic.
>
> Cc: Christian K=F6nig <christian.koenig@amd.com>
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Cc: Felix Kuehling <Felix.Kuehling@amd.com>
> Signed-off-by: xinhui pan <xinhui.pan@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_vm_sdma.c | 2 ++
>   1 file changed, 2 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_sdma.c b/drivers/gpu/dr=
m/amd/amdgpu/amdgpu_vm_sdma.c
> index cf96c335b258..d30d103e48a2 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_sdma.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_sdma.c
> @@ -95,6 +95,8 @@ static int amdgpu_vm_sdma_commit(struct amdgpu_vm_updat=
e_params *p,
>        int r;
>
>        entity =3D p->direct ? &p->vm->direct : &p->vm->delayed;
> +     if (!entity->rq)
> +             return -ENOENT;
>        ring =3D container_of(entity->rq->sched, struct amdgpu_ring, sched=
);
>
>        WARN_ON(ib->length_dw =3D=3D 0);


Am 25.03.2020 12:09 schrieb "Das, Nirmoy" <Nirmoy.Das@amd.com>:
Hi Xinhui,


Can you please check if you can reproduce the crash with
https://lists.freedesktop.org/archives/amd-gfx/2020-February/046414.html

Christian fix it earlier, I think he forgot to push it.


Regards,

Nirmoy

On 3/25/20 12:07 PM, xinhui pan wrote:
> gpu recover will call sdma suspend/resume. In this period, ring will be
> disabled. So the vm_pte_scheds(sdma.instance[X].ring.sched)->ready will
> be false.
>
> If we submit any jobs in this ring-disabled period. We fail to pick up
> a rq for vm entity and entity->rq will set to NULL.
> amdgpu_vm_sdma_commit did not check the entity->rq, so fix it. Otherwise
> hit panic.
>
> Cc: Christian K=F6nig <christian.koenig@amd.com>
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Cc: Felix Kuehling <Felix.Kuehling@amd.com>
> Signed-off-by: xinhui pan <xinhui.pan@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_vm_sdma.c | 2 ++
>   1 file changed, 2 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_sdma.c b/drivers/gpu/dr=
m/amd/amdgpu/amdgpu_vm_sdma.c
> index cf96c335b258..d30d103e48a2 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_sdma.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_sdma.c
> @@ -95,6 +95,8 @@ static int amdgpu_vm_sdma_commit(struct amdgpu_vm_updat=
e_params *p,
>        int r;
>
>        entity =3D p->direct ? &p->vm->direct : &p->vm->delayed;
> +     if (!entity->rq)
> +             return -ENOENT;
>        ring =3D container_of(entity->rq->sched, struct amdgpu_ring, sched=
);
>
>        WARN_ON(ib->length_dw =3D=3D 0);


Am 25.03.2020 12:09 schrieb "Das, Nirmoy" <Nirmoy.Das@amd.com>:
Hi Xinhui,


Can you please check if you can reproduce the crash with
https://lists.freedesktop.org/archives/amd-gfx/2020-February/046414.html

Christian fix it earlier, I think he forgot to push it.


Regards,

Nirmoy

On 3/25/20 12:07 PM, xinhui pan wrote:
> gpu recover will call sdma suspend/resume. In this period, ring will be
> disabled. So the vm_pte_scheds(sdma.instance[X].ring.sched)->ready will
> be false.
>
> If we submit any jobs in this ring-disabled period. We fail to pick up
> a rq for vm entity and entity->rq will set to NULL.
> amdgpu_vm_sdma_commit did not check the entity->rq, so fix it. Otherwise
> hit panic.
>
> Cc: Christian K=F6nig <christian.koenig@amd.com>
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Cc: Felix Kuehling <Felix.Kuehling@amd.com>
> Signed-off-by: xinhui pan <xinhui.pan@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_vm_sdma.c | 2 ++
>   1 file changed, 2 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_sdma.c b/drivers/gpu/dr=
m/amd/amdgpu/amdgpu_vm_sdma.c
> index cf96c335b258..d30d103e48a2 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_sdma.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_sdma.c
> @@ -95,6 +95,8 @@ static int amdgpu_vm_sdma_commit(struct amdgpu_vm_updat=
e_params *p,
>        int r;
>
>        entity =3D p->direct ? &p->vm->direct : &p->vm->delayed;
> +     if (!entity->rq)
> +             return -ENOENT;
>        ring =3D container_of(entity->rq->sched, struct amdgpu_ring, sched=
);
>
>        WARN_ON(ib->length_dw =3D=3D 0);

--_000_32e5b144228c44d985763941dc99d8d5emailandroidcom_
Content-Type: text/html; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Diso-8859-=
1">
<meta name=3D"Generator" content=3D"Microsoft Exchange Server">
<!-- converted from text --><style><!-- .EmailQuote { margin-left: 1pt; pad=
ding-left: 4pt; border-left: #800000 2px solid; } --></style>
</head>
<body>
<div>
<div dir=3D"auto">
<div dir=3D"auto">
<div dir=3D"auto">Hi guys,
<div dir=3D"auto"><br>
</div>
<div dir=3D"auto">thanks for pointing this out Nirmoy.</div>
<div dir=3D"auto"><br>
</div>
<div dir=3D"auto">Yeah, could be that I forgot to commit the patch. Current=
ly I don't know at which end of the chaos I should start to clean up.</div>
<div dir=3D"auto"><br>
</div>
<div dir=3D"auto">Christian.</div>
</div>
<div><br>
<div class=3D"x_elided-text">Am 25.03.2020 12:09 schrieb &quot;Das, Nirmoy&=
quot; &lt;Nirmoy.Das@amd.com&gt;:<br type=3D"attribution">
<blockquote style=3D"margin:0 0 0 0.8ex; border-left:1px #ccc solid; paddin=
g-left:1ex">
<div><font size=3D"2"><span style=3D"font-size:11pt">
<div>Hi Xinhui,<br>
<br>
<br>
Can you please check if you can reproduce the crash with <br>
<a href=3D"https://lists.freedesktop.org/archives/amd-gfx/2020-February/046=
414.html">https://lists.freedesktop.org/archives/amd-gfx/2020-February/0464=
14.html</a><br>
<br>
Christian fix it earlier, I think he forgot to push it.<br>
<br>
<br>
Regards,<br>
<br>
Nirmoy<br>
<br>
On 3/25/20 12:07 PM, xinhui pan wrote:<br>
&gt; gpu recover will call sdma suspend/resume. In this period, ring will b=
e<br>
&gt; disabled. So the vm_pte_scheds(sdma.instance[X].ring.sched)-&gt;ready =
will<br>
&gt; be false.<br>
&gt;<br>
&gt; If we submit any jobs in this ring-disabled period. We fail to pick up=
<br>
&gt; a rq for vm entity and entity-&gt;rq will set to NULL.<br>
&gt; amdgpu_vm_sdma_commit did not check the entity-&gt;rq, so fix it. Othe=
rwise<br>
&gt; hit panic.<br>
&gt;<br>
&gt; Cc: Christian K=F6nig &lt;christian.koenig@amd.com&gt;<br>
&gt; Cc: Alex Deucher &lt;alexander.deucher@amd.com&gt;<br>
&gt; Cc: Felix Kuehling &lt;Felix.Kuehling@amd.com&gt;<br>
&gt; Signed-off-by: xinhui pan &lt;xinhui.pan@amd.com&gt;<br>
&gt; ---<br>
&gt;&nbsp;&nbsp; drivers/gpu/drm/amd/amdgpu/amdgpu_vm_sdma.c | 2 &#43;&#43;=
<br>
&gt;&nbsp;&nbsp; 1 file changed, 2 insertions(&#43;)<br>
&gt;<br>
&gt; diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_sdma.c b/drivers/gpu=
/drm/amd/amdgpu/amdgpu_vm_sdma.c<br>
&gt; index cf96c335b258..d30d103e48a2 100644<br>
&gt; --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_sdma.c<br>
&gt; &#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_sdma.c<br>
&gt; @@ -95,6 &#43;95,8 @@ static int amdgpu_vm_sdma_commit(struct amdgpu_v=
m_update_params *p,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int r;<br>
&gt;&nbsp;&nbsp; <br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; entity =3D p-&gt;direct ? &a=
mp;p-&gt;vm-&gt;direct : &amp;p-&gt;vm-&gt;delayed;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; if (!entity-&gt;rq)<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; return -ENOENT;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ring =3D container_of(entity=
-&gt;rq-&gt;sched, struct amdgpu_ring, sched);<br>
&gt;&nbsp;&nbsp; <br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WARN_ON(ib-&gt;length_dw =3D=
=3D 0);<br>
</div>
</span></font></div>
</blockquote>
</div>
<br>
</div>
</div>
<div><br>
<div class=3D"x_elided-text">Am 25.03.2020 12:09 schrieb &quot;Das, Nirmoy&=
quot; &lt;Nirmoy.Das@amd.com&gt;:<br type=3D"attribution">
<blockquote style=3D"margin:0 0 0 0.8ex; border-left:1px #ccc solid; paddin=
g-left:1ex">
<div><font size=3D"2"><span style=3D"font-size:11pt">
<div>Hi Xinhui,<br>
<br>
<br>
Can you please check if you can reproduce the crash with <br>
<a href=3D"https://lists.freedesktop.org/archives/amd-gfx/2020-February/046=
414.html">https://lists.freedesktop.org/archives/amd-gfx/2020-February/0464=
14.html</a><br>
<br>
Christian fix it earlier, I think he forgot to push it.<br>
<br>
<br>
Regards,<br>
<br>
Nirmoy<br>
<br>
On 3/25/20 12:07 PM, xinhui pan wrote:<br>
&gt; gpu recover will call sdma suspend/resume. In this period, ring will b=
e<br>
&gt; disabled. So the vm_pte_scheds(sdma.instance[X].ring.sched)-&gt;ready =
will<br>
&gt; be false.<br>
&gt;<br>
&gt; If we submit any jobs in this ring-disabled period. We fail to pick up=
<br>
&gt; a rq for vm entity and entity-&gt;rq will set to NULL.<br>
&gt; amdgpu_vm_sdma_commit did not check the entity-&gt;rq, so fix it. Othe=
rwise<br>
&gt; hit panic.<br>
&gt;<br>
&gt; Cc: Christian K=F6nig &lt;christian.koenig@amd.com&gt;<br>
&gt; Cc: Alex Deucher &lt;alexander.deucher@amd.com&gt;<br>
&gt; Cc: Felix Kuehling &lt;Felix.Kuehling@amd.com&gt;<br>
&gt; Signed-off-by: xinhui pan &lt;xinhui.pan@amd.com&gt;<br>
&gt; ---<br>
&gt;&nbsp;&nbsp; drivers/gpu/drm/amd/amdgpu/amdgpu_vm_sdma.c | 2 &#43;&#43;=
<br>
&gt;&nbsp;&nbsp; 1 file changed, 2 insertions(&#43;)<br>
&gt;<br>
&gt; diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_sdma.c b/drivers/gpu=
/drm/amd/amdgpu/amdgpu_vm_sdma.c<br>
&gt; index cf96c335b258..d30d103e48a2 100644<br>
&gt; --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_sdma.c<br>
&gt; &#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_sdma.c<br>
&gt; @@ -95,6 &#43;95,8 @@ static int amdgpu_vm_sdma_commit(struct amdgpu_v=
m_update_params *p,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int r;<br>
&gt;&nbsp;&nbsp; <br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; entity =3D p-&gt;direct ? &a=
mp;p-&gt;vm-&gt;direct : &amp;p-&gt;vm-&gt;delayed;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; if (!entity-&gt;rq)<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; return -ENOENT;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ring =3D container_of(entity=
-&gt;rq-&gt;sched, struct amdgpu_ring, sched);<br>
&gt;&nbsp;&nbsp; <br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WARN_ON(ib-&gt;length_dw =3D=
=3D 0);<br>
</div>
</span></font></div>
</blockquote>
</div>
<br>
</div>
</div>
<div class=3D"x_gmail_extra"><br>
<div class=3D"x_gmail_quote">Am 25.03.2020 12:09 schrieb &quot;Das, Nirmoy&=
quot; &lt;Nirmoy.Das@amd.com&gt;:<br type=3D"attribution">
</div>
</div>
</div>
<font size=3D"2"><span style=3D"font-size:11pt;">
<div class=3D"PlainText">Hi Xinhui,<br>
<br>
<br>
Can you please check if you can reproduce the crash with <br>
<a href=3D"https://lists.freedesktop.org/archives/amd-gfx/2020-February/046=
414.html">https://lists.freedesktop.org/archives/amd-gfx/2020-February/0464=
14.html</a><br>
<br>
Christian fix it earlier, I think he forgot to push it.<br>
<br>
<br>
Regards,<br>
<br>
Nirmoy<br>
<br>
On 3/25/20 12:07 PM, xinhui pan wrote:<br>
&gt; gpu recover will call sdma suspend/resume. In this period, ring will b=
e<br>
&gt; disabled. So the vm_pte_scheds(sdma.instance[X].ring.sched)-&gt;ready =
will<br>
&gt; be false.<br>
&gt;<br>
&gt; If we submit any jobs in this ring-disabled period. We fail to pick up=
<br>
&gt; a rq for vm entity and entity-&gt;rq will set to NULL.<br>
&gt; amdgpu_vm_sdma_commit did not check the entity-&gt;rq, so fix it. Othe=
rwise<br>
&gt; hit panic.<br>
&gt;<br>
&gt; Cc: Christian K=F6nig &lt;christian.koenig@amd.com&gt;<br>
&gt; Cc: Alex Deucher &lt;alexander.deucher@amd.com&gt;<br>
&gt; Cc: Felix Kuehling &lt;Felix.Kuehling@amd.com&gt;<br>
&gt; Signed-off-by: xinhui pan &lt;xinhui.pan@amd.com&gt;<br>
&gt; ---<br>
&gt;&nbsp;&nbsp; drivers/gpu/drm/amd/amdgpu/amdgpu_vm_sdma.c | 2 &#43;&#43;=
<br>
&gt;&nbsp;&nbsp; 1 file changed, 2 insertions(&#43;)<br>
&gt;<br>
&gt; diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_sdma.c b/drivers/gpu=
/drm/amd/amdgpu/amdgpu_vm_sdma.c<br>
&gt; index cf96c335b258..d30d103e48a2 100644<br>
&gt; --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_sdma.c<br>
&gt; &#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_sdma.c<br>
&gt; @@ -95,6 &#43;95,8 @@ static int amdgpu_vm_sdma_commit(struct amdgpu_v=
m_update_params *p,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int r;<br>
&gt;&nbsp;&nbsp; <br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; entity =3D p-&gt;direct ? &a=
mp;p-&gt;vm-&gt;direct : &amp;p-&gt;vm-&gt;delayed;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; if (!entity-&gt;rq)<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; return -ENOENT;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ring =3D container_of(entity=
-&gt;rq-&gt;sched, struct amdgpu_ring, sched);<br>
&gt;&nbsp;&nbsp; <br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WARN_ON(ib-&gt;length_dw =3D=
=3D 0);<br>
</div>
</span></font>
</body>
</html>

--_000_32e5b144228c44d985763941dc99d8d5emailandroidcom_--

--===============1909092934==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============1909092934==--
