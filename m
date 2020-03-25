Return-Path: <SRS0=Seja=5K=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA818C43331
	for <amd-gfx@archiver.kernel.org>; Wed, 25 Mar 2020 11:34:18 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8E28A20722
	for <amd-gfx@archiver.kernel.org>; Wed, 25 Mar 2020 11:34:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="wqrmzHim"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8E28A20722
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4363E6E81B;
	Wed, 25 Mar 2020 11:34:18 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2070.outbound.protection.outlook.com [40.107.220.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8CF966E81B
 for <amd-gfx@lists.freedesktop.org>; Wed, 25 Mar 2020 11:34:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hiAgRhyFoHX2YNlG3OwV8o4lfVRd1+yzj3a3Adlwjz80i6b+b4FBC1tHPyQuwtSPJE8EAS9Hj+3BmCNguxKZWcu9yuo26Gtf2zwurswibk5cpBYitSY2I5VVV9e0Wx3M/XdVQr+CCFiPLvJ22h+N4Yv64TD9MC7skNSIgyfg16OOxE1VgDfZ34x0qTbXQybi3nANQPvbM+KAhF9tHm9woB/kOUaoZXSW1EtFJ1+B8AxnGQvf1f6jYW6hZwxf9hOwcCJv6pJL5zoULNtpgl4aKxgFIEIa/lKB8oE7ads3lKdoLModAhcq5ba/4O8SqWZm9Sg2l87Xks2AY+QxXaofFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uoccVNJlgp8F1lTWjm2pEvV9asVXsCE+4+77WAHHPkM=;
 b=oOW7YLBAl+50I9mlyGJTko6KCxokRvdlk1xLVQMHOwSC4PMEoNpdp+x7ocMRqIMIOFtxqna5GZXXf8Q+yRuIxLETCr53s7s+3mPFa9Afs3qNuiqXlwJS56YKEj+s5E/yXQvVGnFpyJqJr2dekwNXo6gfzAnwjb8D1NKTKrzzluSbawpYBXZ4mi+sV9wWn1vpLGjQLIXDp6wr6xOg9bPdnnEiPQPQoIDy1ye1ku9r+VJVP++9q/p2rNgM0K6WGmP6Cb9B3jWGJ/Y0R6og+C4K9aFVB1e7Mt2D3m5wpGPEkN4dtlVKLUWEaMI2p3TCNm32cFDoyNqGxftTqV9Gib1mbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uoccVNJlgp8F1lTWjm2pEvV9asVXsCE+4+77WAHHPkM=;
 b=wqrmzHimAcsiivFal6EQ+/cxTQBgjcftDEF0sA02c0wmAm72H4TC2NoK7qF+gpDKh+C8lZjgRwWwGiWnE5I2dH1tGvHvtAuF+lvjUWfsSTh0apxdt005oxyjGuoGJUr12R5EAlX9OwxOYqezjA2pI7bO80rxrwyEtYc9Om+pBoU=
Received: from SN6PR12MB2800.namprd12.prod.outlook.com (2603:10b6:805:6c::10)
 by SN6PR12MB2669.namprd12.prod.outlook.com (2603:10b6:805:70::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2856.18; Wed, 25 Mar
 2020 11:34:14 +0000
Received: from SN6PR12MB2800.namprd12.prod.outlook.com
 ([fe80::f458:67f4:2379:b6da]) by SN6PR12MB2800.namprd12.prod.outlook.com
 ([fe80::f458:67f4:2379:b6da%5]) with mapi id 15.20.2835.023; Wed, 25 Mar 2020
 11:34:14 +0000
From: "Pan, Xinhui" <Xinhui.Pan@amd.com>
To: "Das, Nirmoy" <Nirmoy.Das@amd.com>, "Koenig, Christian"
 <Christian.Koenig@amd.com>
Subject: Re: [PATCH] drm/amdgpu: Check entity rq
Thread-Topic: [PATCH] drm/amdgpu: Check entity rq
Thread-Index: AQHWApWRs9uxaN7sNUSrN4jqN1VHvqhZJ9MA////wYCAAANPfA==
Date: Wed, 25 Mar 2020 11:34:14 +0000
Message-ID: <SN6PR12MB28006E73D3C036405B6BDDB187CE0@SN6PR12MB2800.namprd12.prod.outlook.com>
References: <20200325110702.30919-1-xinhui.pan@amd.com>,
 <8e0e3469-0c41-fbb9-1acf-aff8ff7e783e@amd.com>,
 <32e5b144-228c-44d9-8576-3941dc99d8d5@email.android.com>
In-Reply-To: <32e5b144-228c-44d9-8576-3941dc99d8d5@email.android.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=True;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2020-03-25T11:25:03.0168124Z;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=0;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Privileged
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Xinhui.Pan@amd.com; 
x-originating-ip: [101.88.212.119]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 3dda1e36-8a52-4d34-d753-08d7d0b0725c
x-ms-traffictypediagnostic: SN6PR12MB2669:|SN6PR12MB2669:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SN6PR12MB26695821CAB237CD39746E8C87CE0@SN6PR12MB2669.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 0353563E2B
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(4636009)(39860400002)(376002)(346002)(366004)(136003)(396003)(478600001)(966005)(55016002)(33656002)(9686003)(8936002)(81156014)(81166006)(8676002)(6506007)(66574012)(53546011)(2906002)(7696005)(6636002)(66476007)(26005)(76116006)(91956017)(71200400001)(66946007)(52536014)(21615005)(66446008)(4326008)(64756008)(5660300002)(66556008)(54906003)(110136005)(186003)(316002)(86362001);
 DIR:OUT; SFP:1101; SCL:1; SRVR:SN6PR12MB2669;
 H:SN6PR12MB2800.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: zAVi3QcmnGw6ApEzcWr/q8zbE0u5nLA76uoHPkXH5SK/Cwill7UFhcr+hLQt1yGMNX0k1hQl+7n9bM03q0qYv5cbVI4EgTfd1ySr+VzpCAIadfxF+kfwi6JBahOajTxtpxfRmw7tLIw783vu4Abufd9hUTK22O43844IJ5MjkMp068gnTwSFhlq8bZqqxqccnJjKpsR0mD2oUFaCXG4qPnnKjK9mohM5KSIav63pG2f/dH5yCgZGrMtyVJ/i1hRmin7ZiPxk3jagK2Q87Q9cOGyndunU2t6sZANCAym2Q8UJykTWdXX+odoBPAZyDtk6wBwuD15HsC3FWsSzgCTx8YhDGQERvd37JRcaFUeCHok6NGOYWwVbT96u8HxejhBg0njqRQqmG9bcSbfaxwdZy2U3jrqQnb3Cnq7pQKjuBDBbOtklq3Of0NDBk8DDanrE5BVPTFxxwFq5sXsVABpDi31RUbjxI7dGqaZ/BwvMncg=
x-ms-exchange-antispam-messagedata: RvQZP1rR/TKRhEsMYOvHEvci03uaCF6fLhCwTUS1ZaGi3E2qU8o/BCCdrn+fxcQqTJ9F88AEdQWsyKYz4xXUPLugCG2Xkrpcnp/G4S11l4poqCCYK8qd06EEIQe8FlRx/c9m6/w0kz5AFiPqdK1fUg==
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3dda1e36-8a52-4d34-d753-08d7d0b0725c
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Mar 2020 11:34:14.4335 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: FlaBhnAmtRSNrQtCbIHYYuo54T0OdmMZjtgt3tcJl/9wb4pTo3021kIKeyHYemuZ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR12MB2669
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
 Felix" <Felix.Kuehling@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Content-Type: multipart/mixed; boundary="===============2121688081=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============2121688081==
Content-Language: zh-CN
Content-Type: multipart/alternative;
	boundary="_000_SN6PR12MB28006E73D3C036405B6BDDB187CE0SN6PR12MB2800namp_"

--_000_SN6PR12MB28006E73D3C036405B6BDDB187CE0SN6PR12MB2800namp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only - Internal Distribution Only]

well, submit job with HW disabled shluld be no harm.

The only concern is that we might use up IBs if we park scheduler during re=
covery. I have saw recovery stuck in sa new functuon.

ring test alloc IBs to test if recovery succeed or not. But if there is no =
enough IBs it will wait fences to signal. However we have parked the schedu=
ler thread,  the job will never run and no fences will be signaled.

see, deadlock indeed. Now we are allowing job submission here. it is more l=
ikely that IBs might be used up.

________________________________
From: Koenig, Christian <Christian.Koenig@amd.com>
Sent: Wednesday, March 25, 2020 7:13:13 PM
To: Das, Nirmoy <Nirmoy.Das@amd.com>
Cc: Pan, Xinhui <Xinhui.Pan@amd.com>; amd-gfx@lists.freedesktop.org <amd-gf=
x@lists.freedesktop.org>; Deucher, Alexander <Alexander.Deucher@amd.com>; K=
uehling, Felix <Felix.Kuehling@amd.com>
Subject: Re: [PATCH] drm/amdgpu: Check entity rq

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

--_000_SN6PR12MB28006E73D3C036405B6BDDB187CE0SN6PR12MB2800namp_
Content-Type: text/html; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Diso-8859-=
1">
</head>
<body>
<p style=3D"font-family:Arial;font-size:10pt;color:#0078D7;margin:15pt;" al=
ign=3D"Left">
[AMD Official Use Only - Internal Distribution Only]<br>
</p>
<br>
<div>
<div dir=3D"auto" style=3D"direction: ltr; margin: 0; padding: 0; font-fami=
ly: sans-serif; font-size: 11pt; color: black; ">
well, submit job with HW disabled shluld be no harm.<br>
</div>
<div dir=3D"auto" style=3D"direction: ltr; margin: 0; padding: 0; font-fami=
ly: sans-serif; font-size: 11pt; color: black; ">
<br>
</div>
<div dir=3D"auto" style=3D"direction: ltr; margin: 0; padding: 0; font-fami=
ly: sans-serif; font-size: 11pt; color: black; ">
</div>
<div dir=3D"auto" style=3D"direction: ltr; margin: 0; padding: 0; font-fami=
ly: sans-serif; font-size: 11pt; color: black; ">
The only concern is that we might use up IBs if we park scheduler during re=
covery. I have saw recovery stuck in sa new functuon.&nbsp;</div>
<div dir=3D"auto" style=3D"direction: ltr; margin: 0; padding: 0; font-fami=
ly: sans-serif; font-size: 11pt; color: black; ">
<br>
</div>
<div id=3D"ms-outlook-mobile-signature" dir=3D"auto" style=3D"text-align: l=
eft;">
<div dir=3D"auto" style=3D"text-align: left;">ring test alloc IBs to test i=
f recovery succeed or not. But if there is no enough IBs it will wait fence=
s to signal. However we have parked the scheduler thread,&nbsp; the job wil=
l never run and no fences will be signaled.</div>
<div dir=3D"auto" style=3D"text-align: left;"><br>
</div>
<div dir=3D"auto" style=3D"text-align: left;">see, deadlock indeed. Now we =
are allowing job submission here. it is more likely that IBs might be used =
up.</div>
<div dir=3D"auto" style=3D"text-align: left;"><br>
</div>
</div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Koenig, Christian &lt=
;Christian.Koenig@amd.com&gt;<br>
<b>Sent:</b> Wednesday, March 25, 2020 7:13:13 PM<br>
<b>To:</b> Das, Nirmoy &lt;Nirmoy.Das@amd.com&gt;<br>
<b>Cc:</b> Pan, Xinhui &lt;Xinhui.Pan@amd.com&gt;; amd-gfx@lists.freedeskto=
p.org &lt;amd-gfx@lists.freedesktop.org&gt;; Deucher, Alexander &lt;Alexand=
er.Deucher@amd.com&gt;; Kuehling, Felix &lt;Felix.Kuehling@amd.com&gt;<br>
<b>Subject:</b> Re: [PATCH] drm/amdgpu: Check entity rq</font>
<div>&nbsp;</div>
</div>
<style>
<!--
.x_EmailQuote
	{margin-left:1pt;
	padding-left:4pt;
	border-left:#800000 2px solid}
-->
</style>
<div>
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
<div class=3D"x_x_elided-text">Am 25.03.2020 12:09 schrieb &quot;Das, Nirmo=
y&quot; &lt;Nirmoy.Das@amd.com&gt;:<br type=3D"attribution">
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
<div class=3D"x_x_elided-text">Am 25.03.2020 12:09 schrieb &quot;Das, Nirmo=
y&quot; &lt;Nirmoy.Das@amd.com&gt;:<br type=3D"attribution">
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
<div class=3D"x_x_gmail_extra"><br>
<div class=3D"x_x_gmail_quote">Am 25.03.2020 12:09 schrieb &quot;Das, Nirmo=
y&quot; &lt;Nirmoy.Das@amd.com&gt;:<br type=3D"attribution">
</div>
</div>
</div>
<font size=3D"2"><span style=3D"font-size:11pt">
<div class=3D"x_PlainText">Hi Xinhui,<br>
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
</div>
</body>
</html>

--_000_SN6PR12MB28006E73D3C036405B6BDDB187CE0SN6PR12MB2800namp_--

--===============2121688081==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============2121688081==--
