Return-Path: <SRS0=MAwf=YZ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21335CA9ECF
	for <amd-gfx@archiver.kernel.org>; Fri,  1 Nov 2019 22:20:37 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D74E020659
	for <amd-gfx@archiver.kernel.org>; Fri,  1 Nov 2019 22:20:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D74E020659
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 731EF6E25D;
	Fri,  1 Nov 2019 22:20:36 +0000 (UTC)
Received: from NAM05-DM3-obe.outbound.protection.outlook.com
 (mail-eopbgr730062.outbound.protection.outlook.com [40.107.73.62])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B879E6E25D
 for <amd-gfx@lists.freedesktop.org>; Fri,  1 Nov 2019 22:20:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eUKOfDek3xjev00hgiBkDk2OX++ZDslEDtm9/qvpzpaZZYmmde1ZBCHMOMDybnm/+cE5y6/rJEWsqfxhksuV50OwCLIAAU7uIpsqYWhX81bV5+nCsU1Jkyu+BEB2XUAD/Y9Mx+TDITnPNT7r7ds4xSqwj+UF8Cuvw2j8HyTvmumQOvk8nOFU2jr3J3w0dGsMmxLqOiijdfqiqwsF62TIBOLbnIRLtkd50tOe4KqsJ14qwBmeTPsAktbayeI/RaUKt4kgIp1SlXFfIt0SRV856NTr0lAwmJom2mdHbQc76yNj+kZlo+238yIT8hFmnZIVoDMzzZLIE4Zd+hKLwQ6FKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UpeSOEA7VKCLArkwhH544iYEeO9DZ41OLTEu7Y9EYjo=;
 b=BP47J+6b6c6roVr0L+4rcslVcRsUNrz7zZlURq/MjTYOVRBNLDkor75lcFf+kNPovtDtIfakgP8OD208AJjY2spqRPP3C1vpBTECK3YaLLGloY6l5DiIgEAt95hQIULn6UpAxmgEVG6wKEGsfwJ2lfFPxcX6uFAzce+PsBU4SVsV32c8TNAa21lnK4GOngzMG0dT4XkYF3WZ8ue8AQ9eDY4eKbAiOGvScbyNV+a3qLaubuYfP1lPLSR7HDywyoKSxFu7Www7gmrFFwMJwFEgnWMdWV1y+3B+O06QuKGqB4UaN/Qts0iKZJR6RWQJV9TkGqgjrK7eBxMFcP6H/uwnmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
Received: from DM6PR12MB2778.namprd12.prod.outlook.com (20.176.114.145) by
 DM6PR12MB3388.namprd12.prod.outlook.com (20.178.198.83) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2387.24; Fri, 1 Nov 2019 22:20:32 +0000
Received: from DM6PR12MB2778.namprd12.prod.outlook.com
 ([fe80::b411:7d2c:8848:1f6e]) by DM6PR12MB2778.namprd12.prod.outlook.com
 ([fe80::b411:7d2c:8848:1f6e%7]) with mapi id 15.20.2387.028; Fri, 1 Nov 2019
 22:20:32 +0000
From: "Zhao, Yong" <Yong.Zhao@amd.com>
To: "Kuehling, Felix" <Felix.Kuehling@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH] drm/amdkfd: Simplify the mmap offset related bit
 operations
Thread-Topic: [PATCH] drm/amdkfd: Simplify the mmap offset related bit
 operations
Thread-Index: AQHVkPW3xyVHQwVd5kGLa7uEKtffqqd20G6AgAARgC8=
Date: Fri, 1 Nov 2019 22:20:32 +0000
Message-ID:
 <DM6PR12MB2778C939A102478FF10F39ADF0620@DM6PR12MB2778.namprd12.prod.outlook.com>
References: <20191101204818.8125-1-Yong.Zhao@amd.com>,
 <c237f5bf-6638-2d90-3f94-e1eca2c22780@amd.com>
In-Reply-To: <c237f5bf-6638-2d90-3f94-e1eca2c22780@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [2607:fea8:209f:ebca:3c32:f60f:1ad3:cb3]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 2382cf68-d998-4b76-b05e-08d75f19b5fa
x-ms-traffictypediagnostic: DM6PR12MB3388:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR12MB3388DE8B031294C60CD14C10F0620@DM6PR12MB3388.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 020877E0CB
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(4636009)(396003)(136003)(376002)(39860400002)(366004)(346002)(189003)(199004)(81156014)(76176011)(25786009)(52536014)(7736002)(186003)(478600001)(105004)(102836004)(66946007)(76116006)(7696005)(55016002)(446003)(54896002)(2501003)(33656002)(19627405001)(9686003)(486006)(53546011)(46003)(6246003)(229853002)(66476007)(6436002)(66556008)(6506007)(99286004)(64756008)(66446008)(14454004)(110136005)(11346002)(316002)(74316002)(476003)(86362001)(8676002)(256004)(6116002)(71190400001)(71200400001)(81166006)(8936002)(2906002)(5660300002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM6PR12MB3388;
 H:DM6PR12MB2778.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: NN5SdznwXqjOHX2zrh1f7KYphiuW3dUl8y9GgrE6iW242GJJW/tNdFSHzaa7mNbwG1dM5RX1kW5JR64yjJP7vx/Nqy+W1rL4998LS78BX6+KZC7ILLrxQFHcJNJ1gLt9bUZqSE72pGB62ZIZ1fIeJ2lL+CHECNbv0cNyIHz7+9nM8qqQjRNDQ/91x9FC86W6yucudOCV5jg3DL4VWeRqqrkgIi0+rjn84iIOBvBeUT1UFtr9dFjaSte5ElYQlmlbiebZQcXAGZ2eIS5g9Pl7KB0bAoh3FsjG4kNr3QIVkMtM490jSEA1B5Tv+y8JAPXsyV80ZE76PI2fAZ76Hp1DeIyh5OPsTALgB4fpmD5xaDXFt/pm0dLIu4w/gKS0y/eT2+qlusoocm39fMMsDbcNKllPvQ2SiDsCyLbt19wx/0jwwufXhJsohgi5Q+91Kpnw
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2382cf68-d998-4b76-b05e-08d75f19b5fa
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Nov 2019 22:20:32.6841 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: n5GSwWQOfPq2NA1tTxnVz+W4yk3G6UHjdmxqOvNGw4THlMVSAjl/e07JWB36b5jE
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3388
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UpeSOEA7VKCLArkwhH544iYEeO9DZ41OLTEu7Y9EYjo=;
 b=YxsjTCCltJdl5/Jq1MffsygKunFLLLf6v53KL2zjAr0wHc44SjXCQaVzAl/rzJW0Cf2ST3v/6bgv5vEhHcHLoQieUbqXhzWftTGEc8Lwn1tJKC3jhu5n7asZ06YtgiiGzuzl3McHxUXocPbL+BBGtHsYkQiQekDKEakx4vvQQ1U=
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
Content-Type: multipart/mixed; boundary="===============0915769850=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
Message-ID: <20191101222032.PnxY7M3Oy-36wFiUoC-gKykx0AVUGvlMBMXO38g57z4@z>

--===============0915769850==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_DM6PR12MB2778C939A102478FF10F39ADF0620DM6PR12MB2778namp_"

--_000_DM6PR12MB2778C939A102478FF10F39ADF0620DM6PR12MB2778namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hi Felix,

The PAGE_SHIFT was not deleted but merged into the KFD_*_SHIFT in kfd_priv.=
h. Because of that, this change is actually transparent to the thunk, and i=
t only straightens up the bit shift operations in most cases.

Regards,
Yong
________________________________
From: Kuehling, Felix <Felix.Kuehling@amd.com>
Sent: Friday, November 1, 2019 5:13 PM
To: amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>; Zhao, Yo=
ng <Yong.Zhao@amd.com>
Subject: Re: [PATCH] drm/amdkfd: Simplify the mmap offset related bit opera=
tions

NAK. This won't work for several reasons.

The mmap_offset is used as offset parameter in the mmap system call. If
you check the man page of mmap, you'll see that "offset must be a
multiple of the page size". Therefore the PAGE_SHIFT is necessary.

In the case of doorbell offsets, the offset is parsed and processed by
the Thunk in user mode. On GFX9 GPUs the lower bits are used for the
offset of the doorbell within the doorbell page. On GFX8 the queue ID
was used, but on GFX9 we had to decoupled the doorbell ID from the queue
ID. If you remove the PAGE_SHIFT, you'll need to put those bits
somewhere else. But that change in the encoding would break the ABI with
the Thunk.

Regards,
   Felix

On 2019-11-01 4:48 p.m., Zhao, Yong wrote:
> The new code is much cleaner and results in better readability.
>
> Change-Id: I0c1f7cca7e24ddb7b4ffe1cb0fa71943828ae373
> Signed-off-by: Yong Zhao <Yong.Zhao@amd.com>
> ---
>   drivers/gpu/drm/amd/amdkfd/kfd_chardev.c | 13 +++++++------
>   drivers/gpu/drm/amd/amdkfd/kfd_events.c  |  1 -
>   drivers/gpu/drm/amd/amdkfd/kfd_priv.h    |  9 +++------
>   drivers/gpu/drm/amd/amdkfd/kfd_process.c |  3 +--
>   4 files changed, 11 insertions(+), 15 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c b/drivers/gpu/drm/a=
md/amdkfd/kfd_chardev.c
> index b91993753b82..590138727ca9 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
> @@ -298,7 +298,6 @@ static int kfd_ioctl_create_queue(struct file *filep,=
 struct kfd_process *p,
>        /* Return gpu_id as doorbell offset for mmap usage */
>        args->doorbell_offset =3D KFD_MMAP_TYPE_DOORBELL;
>        args->doorbell_offset |=3D KFD_MMAP_GPU_ID(args->gpu_id);
> -     args->doorbell_offset <<=3D PAGE_SHIFT;
>        if (KFD_IS_SOC15(dev->device_info->asic_family))
>                /* On SOC15 ASICs, include the doorbell offset within the
>                 * process doorbell frame, which could be 1 page or 2 page=
s.
> @@ -1938,20 +1937,22 @@ static int kfd_mmap(struct file *filp, struct vm_=
area_struct *vma)
>   {
>        struct kfd_process *process;
>        struct kfd_dev *dev =3D NULL;
> -     unsigned long vm_pgoff;
> +     unsigned long mmap_offset;
>        unsigned int gpu_id;
>
>        process =3D kfd_get_process(current);
>        if (IS_ERR(process))
>                return PTR_ERR(process);
>
> -     vm_pgoff =3D vma->vm_pgoff;
> -     vma->vm_pgoff =3D KFD_MMAP_OFFSET_VALUE_GET(vm_pgoff);
> -     gpu_id =3D KFD_MMAP_GPU_ID_GET(vm_pgoff);
> +     mmap_offset =3D vma->vm_pgoff << PAGE_SHIFT;
> +     gpu_id =3D KFD_MMAP_GET_GPU_ID(mmap_offset);
>        if (gpu_id)
>                dev =3D kfd_device_by_id(gpu_id);
>
> -     switch (vm_pgoff & KFD_MMAP_TYPE_MASK) {
> +     /* only leave the offset segment */
> +     vma->vm_pgoff &=3D (1ULL << (KFD_MMAP_GPU_ID_SHIFT - PAGE_SHIFT)) -=
 1;
> +
> +     switch (mmap_offset & KFD_MMAP_TYPE_MASK) {
>        case KFD_MMAP_TYPE_DOORBELL:
>                if (!dev)
>                        return -ENODEV;
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_events.c b/drivers/gpu/drm/am=
d/amdkfd/kfd_events.c
> index 908081c85de1..1f8365575b12 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_events.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_events.c
> @@ -346,7 +346,6 @@ int kfd_event_create(struct file *devkfd, struct kfd_=
process *p,
>                ret =3D create_signal_event(devkfd, p, ev);
>                if (!ret) {
>                        *event_page_offset =3D KFD_MMAP_TYPE_EVENTS;
> -                     *event_page_offset <<=3D PAGE_SHIFT;
>                        *event_slot_index =3D ev->event_id;
>                }
>                break;
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h b/drivers/gpu/drm/amd/=
amdkfd/kfd_priv.h
> index 66bae8f2dad1..8eecd2cd1fd2 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
> @@ -59,24 +59,21 @@
>    * NOTE: struct vm_area_struct.vm_pgoff uses offset in pages. Hence, th=
ese
>    *  defines are w.r.t to PAGE_SIZE
>    */
> -#define KFD_MMAP_TYPE_SHIFT  (62 - PAGE_SHIFT)
> +#define KFD_MMAP_TYPE_SHIFT  (62)
>   #define KFD_MMAP_TYPE_MASK  (0x3ULL << KFD_MMAP_TYPE_SHIFT)
>   #define KFD_MMAP_TYPE_DOORBELL      (0x3ULL << KFD_MMAP_TYPE_SHIFT)
>   #define KFD_MMAP_TYPE_EVENTS        (0x2ULL << KFD_MMAP_TYPE_SHIFT)
>   #define KFD_MMAP_TYPE_RESERVED_MEM  (0x1ULL << KFD_MMAP_TYPE_SHIFT)
>   #define KFD_MMAP_TYPE_MMIO  (0x0ULL << KFD_MMAP_TYPE_SHIFT)
>
> -#define KFD_MMAP_GPU_ID_SHIFT (46 - PAGE_SHIFT)
> +#define KFD_MMAP_GPU_ID_SHIFT (46)
>   #define KFD_MMAP_GPU_ID_MASK (((1ULL << KFD_GPU_ID_HASH_WIDTH) - 1) \
>                                << KFD_MMAP_GPU_ID_SHIFT)
>   #define KFD_MMAP_GPU_ID(gpu_id) ((((uint64_t)gpu_id) << KFD_MMAP_GPU_ID=
_SHIFT)\
>                                & KFD_MMAP_GPU_ID_MASK)
> -#define KFD_MMAP_GPU_ID_GET(offset)    ((offset & KFD_MMAP_GPU_ID_MASK) =
\
> +#define KFD_MMAP_GET_GPU_ID(offset)    ((offset & KFD_MMAP_GPU_ID_MASK) =
\
>                                >> KFD_MMAP_GPU_ID_SHIFT)
>
> -#define KFD_MMAP_OFFSET_VALUE_MASK   (0x3FFFFFFFFFFFULL >> PAGE_SHIFT)
> -#define KFD_MMAP_OFFSET_VALUE_GET(offset) (offset & KFD_MMAP_OFFSET_VALU=
E_MASK)
> -
>   /*
>    * When working with cp scheduler we should assign the HIQ manually or =
via
>    * the amdgpu driver to a fixed hqd slot, here are the fixed HIQ hqd sl=
ot
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process.c b/drivers/gpu/drm/a=
md/amdkfd/kfd_process.c
> index 6abfb77ae540..39dc49b8fd85 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_process.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
> @@ -554,8 +554,7 @@ static int kfd_process_init_cwsr_apu(struct kfd_proce=
ss *p, struct file *filep)
>                if (!dev->cwsr_enabled || qpd->cwsr_kaddr || qpd->cwsr_bas=
e)
>                        continue;
>
> -             offset =3D (KFD_MMAP_TYPE_RESERVED_MEM | KFD_MMAP_GPU_ID(de=
v->id))
> -                     << PAGE_SHIFT;
> +             offset =3D KFD_MMAP_TYPE_RESERVED_MEM | KFD_MMAP_GPU_ID(dev=
->id);
>                qpd->tba_addr =3D (int64_t)vm_mmap(filep, 0,
>                        KFD_CWSR_TBA_TMA_SIZE, PROT_READ | PROT_EXEC,
>                        MAP_SHARED, offset);

--_000_DM6PR12MB2778C939A102478FF10F39ADF0620DM6PR12MB2778namp_
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
Hi Felix,</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
The&nbsp;<span style=3D"color: rgb(32, 31, 30); font-family: &quot;Segoe UI=
&quot;, &quot;Segoe UI Web (West European)&quot;, &quot;Segoe UI&quot;, -ap=
ple-system, BlinkMacSystemFont, Roboto, &quot;Helvetica Neue&quot;, sans-se=
rif; font-size: 14.6667px; background-color: rgb(255, 255, 255); display: i=
nline !important">PAGE_SHIFT
 was not deleted but merged into the&nbsp;<span style=3D"font-family: &quot=
;Segoe UI&quot;, &quot;Segoe UI Web (West European)&quot;, &quot;Segoe UI&q=
uot;, -apple-system, BlinkMacSystemFont, Roboto, &quot;Helvetica Neue&quot;=
, sans-serif; background-color: rgb(255, 255, 255); display: inline !import=
ant">KFD_*_SHIFT
 in kfd_priv.h. Because of that, this change is actually transparent to the=
 thunk, and it only straightens up the bit shift operations in most cases.<=
/span></span></div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<span style=3D"color: rgb(32, 31, 30); font-family: &quot;Segoe UI&quot;, &=
quot;Segoe UI Web (West European)&quot;, &quot;Segoe UI&quot;, -apple-syste=
m, BlinkMacSystemFont, Roboto, &quot;Helvetica Neue&quot;, sans-serif; font=
-size: 14.6667px; background-color: rgb(255, 255, 255); display: inline !im=
portant"><span style=3D"font-family: &quot;Segoe UI&quot;, &quot;Segoe UI W=
eb (West European)&quot;, &quot;Segoe UI&quot;, -apple-system, BlinkMacSyst=
emFont, Roboto, &quot;Helvetica Neue&quot;, sans-serif; background-color: r=
gb(255, 255, 255); display: inline !important"><br>
</span></span></div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<span style=3D"color: rgb(32, 31, 30); font-family: &quot;Segoe UI&quot;, &=
quot;Segoe UI Web (West European)&quot;, &quot;Segoe UI&quot;, -apple-syste=
m, BlinkMacSystemFont, Roboto, &quot;Helvetica Neue&quot;, sans-serif; font=
-size: 14.6667px; background-color: rgb(255, 255, 255); display: inline !im=
portant"><span style=3D"font-family: &quot;Segoe UI&quot;, &quot;Segoe UI W=
eb (West European)&quot;, &quot;Segoe UI&quot;, -apple-system, BlinkMacSyst=
emFont, Roboto, &quot;Helvetica Neue&quot;, sans-serif; background-color: r=
gb(255, 255, 255); display: inline !important">Regards,</span></span></div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<span style=3D"color: rgb(32, 31, 30); font-family: &quot;Segoe UI&quot;, &=
quot;Segoe UI Web (West European)&quot;, &quot;Segoe UI&quot;, -apple-syste=
m, BlinkMacSystemFont, Roboto, &quot;Helvetica Neue&quot;, sans-serif; font=
-size: 14.6667px; background-color: rgb(255, 255, 255); display: inline !im=
portant"><span style=3D"font-family: &quot;Segoe UI&quot;, &quot;Segoe UI W=
eb (West European)&quot;, &quot;Segoe UI&quot;, -apple-system, BlinkMacSyst=
emFont, Roboto, &quot;Helvetica Neue&quot;, sans-serif; background-color: r=
gb(255, 255, 255); display: inline !important">Yong</span></span></div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Kuehling, Felix &lt;F=
elix.Kuehling@amd.com&gt;<br>
<b>Sent:</b> Friday, November 1, 2019 5:13 PM<br>
<b>To:</b> amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&=
gt;; Zhao, Yong &lt;Yong.Zhao@amd.com&gt;<br>
<b>Subject:</b> Re: [PATCH] drm/amdkfd: Simplify the mmap offset related bi=
t operations</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">NAK. This won't work for several reasons.<br>
<br>
The mmap_offset is used as offset parameter in the mmap system call. If <br=
>
you check the man page of mmap, you'll see that &quot;offset must be a <br>
multiple of the page size&quot;. Therefore the PAGE_SHIFT is necessary.<br>
<br>
In the case of doorbell offsets, the offset is parsed and processed by <br>
the Thunk in user mode. On GFX9 GPUs the lower bits are used for the <br>
offset of the doorbell within the doorbell page. On GFX8 the queue ID <br>
was used, but on GFX9 we had to decoupled the doorbell ID from the queue <b=
r>
ID. If you remove the PAGE_SHIFT, you'll need to put those bits <br>
somewhere else. But that change in the encoding would break the ABI with <b=
r>
the Thunk.<br>
<br>
Regards,<br>
&nbsp;&nbsp; Felix<br>
<br>
On 2019-11-01 4:48 p.m., Zhao, Yong wrote:<br>
&gt; The new code is much cleaner and results in better readability.<br>
&gt;<br>
&gt; Change-Id: I0c1f7cca7e24ddb7b4ffe1cb0fa71943828ae373<br>
&gt; Signed-off-by: Yong Zhao &lt;Yong.Zhao@amd.com&gt;<br>
&gt; ---<br>
&gt;&nbsp;&nbsp; drivers/gpu/drm/amd/amdkfd/kfd_chardev.c | 13 &#43;&#43;&#=
43;&#43;&#43;&#43;&#43;------<br>
&gt;&nbsp;&nbsp; drivers/gpu/drm/amd/amdkfd/kfd_events.c&nbsp; |&nbsp; 1 -<=
br>
&gt;&nbsp;&nbsp; drivers/gpu/drm/amd/amdkfd/kfd_priv.h&nbsp;&nbsp;&nbsp; |&=
nbsp; 9 &#43;&#43;&#43;------<br>
&gt;&nbsp;&nbsp; drivers/gpu/drm/amd/amdkfd/kfd_process.c |&nbsp; 3 &#43;--=
<br>
&gt;&nbsp;&nbsp; 4 files changed, 11 insertions(&#43;), 15 deletions(-)<br>
&gt;<br>
&gt; diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c b/drivers/gpu/dr=
m/amd/amdkfd/kfd_chardev.c<br>
&gt; index b91993753b82..590138727ca9 100644<br>
&gt; --- a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c<br>
&gt; &#43;&#43;&#43; b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c<br>
&gt; @@ -298,7 &#43;298,6 @@ static int kfd_ioctl_create_queue(struct file =
*filep, struct kfd_process *p,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Return gpu_id as doorbell=
 offset for mmap usage */<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; args-&gt;doorbell_offset =3D=
 KFD_MMAP_TYPE_DOORBELL;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; args-&gt;doorbell_offset |=
=3D KFD_MMAP_GPU_ID(args-&gt;gpu_id);<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; args-&gt;doorbell_offset &lt;&lt;=3D PAGE_SH=
IFT;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (KFD_IS_SOC15(dev-&gt;dev=
ice_info-&gt;asic_family))<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; /* On SOC15 ASICs, include the doorbell offset within t=
he<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; * process doorbell frame, which could be 1 page o=
r 2 pages.<br>
&gt; @@ -1938,20 &#43;1937,22 @@ static int kfd_mmap(struct file *filp, str=
uct vm_area_struct *vma)<br>
&gt;&nbsp;&nbsp; {<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct kfd_process *process;=
<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct kfd_dev *dev =3D NULL=
;<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; unsigned long vm_pgoff;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; unsigned long mmap_offset;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; unsigned int gpu_id;<br>
&gt;&nbsp;&nbsp; <br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; process =3D kfd_get_process(=
current);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (IS_ERR(process))<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; return PTR_ERR(process);<br>
&gt;&nbsp;&nbsp; <br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; vm_pgoff =3D vma-&gt;vm_pgoff;<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; vma-&gt;vm_pgoff =3D KFD_MMAP_OFFSET_VALUE_G=
ET(vm_pgoff);<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; gpu_id =3D KFD_MMAP_GPU_ID_GET(vm_pgoff);<br=
>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; mmap_offset =3D vma-&gt;vm_pgoff &lt;&lt=
; PAGE_SHIFT;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; gpu_id =3D KFD_MMAP_GET_GPU_ID(mmap_offs=
et);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (gpu_id)<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; dev =3D kfd_device_by_id(gpu_id);<br>
&gt;&nbsp;&nbsp; <br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; switch (vm_pgoff &amp; KFD_MMAP_TYPE_MASK) {=
<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; /* only leave the offset segment */<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; vma-&gt;vm_pgoff &amp;=3D (1ULL &lt;&lt;=
 (KFD_MMAP_GPU_ID_SHIFT - PAGE_SHIFT)) - 1;<br>
&gt; &#43;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; switch (mmap_offset &amp; KFD_MMAP_TYPE_=
MASK) {<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case KFD_MMAP_TYPE_DOORBELL:=
<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; if (!dev)<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return =
-ENODEV;<br>
&gt; diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_events.c b/drivers/gpu/drm=
/amd/amdkfd/kfd_events.c<br>
&gt; index 908081c85de1..1f8365575b12 100644<br>
&gt; --- a/drivers/gpu/drm/amd/amdkfd/kfd_events.c<br>
&gt; &#43;&#43;&#43; b/drivers/gpu/drm/amd/amdkfd/kfd_events.c<br>
&gt; @@ -346,7 &#43;346,6 @@ int kfd_event_create(struct file *devkfd, stru=
ct kfd_process *p,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; ret =3D create_signal_event(devkfd, p, ev);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; if (!ret) {<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *event_=
page_offset =3D KFD_MMAP_TYPE_EVENTS;<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *event_page_offset &lt;=
&lt;=3D PAGE_SHIFT;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *event_=
slot_index =3D ev-&gt;event_id;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; }<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; break;<br>
&gt; diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h b/drivers/gpu/drm/a=
md/amdkfd/kfd_priv.h<br>
&gt; index 66bae8f2dad1..8eecd2cd1fd2 100644<br>
&gt; --- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h<br>
&gt; &#43;&#43;&#43; b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h<br>
&gt; @@ -59,24 &#43;59,21 @@<br>
&gt;&nbsp;&nbsp;&nbsp; * NOTE: struct vm_area_struct.vm_pgoff uses offset i=
n pages. Hence, these<br>
&gt;&nbsp;&nbsp;&nbsp; *&nbsp; defines are w.r.t to PAGE_SIZE<br>
&gt;&nbsp;&nbsp;&nbsp; */<br>
&gt; -#define KFD_MMAP_TYPE_SHIFT&nbsp; (62 - PAGE_SHIFT)<br>
&gt; &#43;#define KFD_MMAP_TYPE_SHIFT&nbsp; (62)<br>
&gt;&nbsp;&nbsp; #define KFD_MMAP_TYPE_MASK&nbsp; (0x3ULL &lt;&lt; KFD_MMAP=
_TYPE_SHIFT)<br>
&gt;&nbsp;&nbsp; #define KFD_MMAP_TYPE_DOORBELL&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p; (0x3ULL &lt;&lt; KFD_MMAP_TYPE_SHIFT)<br>
&gt;&nbsp;&nbsp; #define KFD_MMAP_TYPE_EVENTS&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp; (0x2ULL &lt;&lt; KFD_MMAP_TYPE_SHIFT)<br>
&gt;&nbsp;&nbsp; #define KFD_MMAP_TYPE_RESERVED_MEM&nbsp; (0x1ULL &lt;&lt; =
KFD_MMAP_TYPE_SHIFT)<br>
&gt;&nbsp;&nbsp; #define KFD_MMAP_TYPE_MMIO&nbsp; (0x0ULL &lt;&lt; KFD_MMAP=
_TYPE_SHIFT)<br>
&gt;&nbsp;&nbsp; <br>
&gt; -#define KFD_MMAP_GPU_ID_SHIFT (46 - PAGE_SHIFT)<br>
&gt; &#43;#define KFD_MMAP_GPU_ID_SHIFT (46)<br>
&gt;&nbsp;&nbsp; #define KFD_MMAP_GPU_ID_MASK (((1ULL &lt;&lt; KFD_GPU_ID_H=
ASH_WIDTH) - 1) \<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &lt;&lt; KFD_MMAP_GPU_ID_SHIFT)<br=
>
&gt;&nbsp;&nbsp; #define KFD_MMAP_GPU_ID(gpu_id) ((((uint64_t)gpu_id) &lt;&=
lt; KFD_MMAP_GPU_ID_SHIFT)\<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &amp; KFD_MMAP_GPU_ID_MASK)<br>
&gt; -#define KFD_MMAP_GPU_ID_GET(offset)&nbsp;&nbsp;&nbsp; ((offset &amp; =
KFD_MMAP_GPU_ID_MASK) \<br>
&gt; &#43;#define KFD_MMAP_GET_GPU_ID(offset)&nbsp;&nbsp;&nbsp; ((offset &a=
mp; KFD_MMAP_GPU_ID_MASK) \<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &gt;&gt; KFD_MMAP_GPU_ID_SHIFT)<br=
>
&gt;&nbsp;&nbsp; <br>
&gt; -#define KFD_MMAP_OFFSET_VALUE_MASK&nbsp;&nbsp; (0x3FFFFFFFFFFFULL &gt=
;&gt; PAGE_SHIFT)<br>
&gt; -#define KFD_MMAP_OFFSET_VALUE_GET(offset) (offset &amp; KFD_MMAP_OFFS=
ET_VALUE_MASK)<br>
&gt; -<br>
&gt;&nbsp;&nbsp; /*<br>
&gt;&nbsp;&nbsp;&nbsp; * When working with cp scheduler we should assign th=
e HIQ manually or via<br>
&gt;&nbsp;&nbsp;&nbsp; * the amdgpu driver to a fixed hqd slot, here are th=
e fixed HIQ hqd slot<br>
&gt; diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process.c b/drivers/gpu/dr=
m/amd/amdkfd/kfd_process.c<br>
&gt; index 6abfb77ae540..39dc49b8fd85 100644<br>
&gt; --- a/drivers/gpu/drm/amd/amdkfd/kfd_process.c<br>
&gt; &#43;&#43;&#43; b/drivers/gpu/drm/amd/amdkfd/kfd_process.c<br>
&gt; @@ -554,8 &#43;554,7 @@ static int kfd_process_init_cwsr_apu(struct kf=
d_process *p, struct file *filep)<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; if (!dev-&gt;cwsr_enabled || qpd-&gt;cwsr_kaddr || qpd-=
&gt;cwsr_base)<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; continu=
e;<br>
&gt;&nbsp;&nbsp; <br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; offset =3D (KFD_MMAP_TYPE_RESERVED_MEM | KFD_MMAP_GPU_ID(dev-&gt;id))<b=
r>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &lt;&lt; PAGE_SHIFT;<br=
>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; offset =3D KFD_MMAP_TYPE_RESERVED_MEM | KFD_MMAP_GPU_ID(dev-&gt;id)=
;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; qpd-&gt;tba_addr =3D (int64_t)vm_mmap(filep, 0,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; KFD_CWS=
R_TBA_TMA_SIZE, PROT_READ | PROT_EXEC,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; MAP_SHA=
RED, offset);<br>
</div>
</span></font></div>
</body>
</html>

--_000_DM6PR12MB2778C939A102478FF10F39ADF0620DM6PR12MB2778namp_--

--===============0915769850==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4

--===============0915769850==--
