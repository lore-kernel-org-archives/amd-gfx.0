Return-Path: <SRS0=ouc1=Y7=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D988C43331
	for <amd-gfx@archiver.kernel.org>; Thu,  7 Nov 2019 17:31:24 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3967D2085B
	for <amd-gfx@archiver.kernel.org>; Thu,  7 Nov 2019 17:31:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3967D2085B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0ABC86E4D7;
	Thu,  7 Nov 2019 17:31:24 +0000 (UTC)
Received: from NAM01-SN1-obe.outbound.protection.outlook.com
 (mail-eopbgr820082.outbound.protection.outlook.com [40.107.82.82])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8B0A06E4D7
 for <amd-gfx@lists.freedesktop.org>; Thu,  7 Nov 2019 17:31:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=i5FMBy4ZTWlwumAm+5LqCp6ZeEdQ6KYn5kipceDpkBg8/NkQrTWNSNVZZZnY3epPZKoS4tqTkVdQPbUvZnagmXHu2bblZNhVonoiZndMdirFIinJ9TfDFBgPwc96fcpMWk30STRsIoHcQbFB4PnWEbZfR4Vcl0Joo7v3JoEvkkizl9cSXMFK7VFHHTjSz+NWQcAi1LZ8Sku7XAvhzbsswk7R5Dals7bSwozq7n0aKJycVW6XS4jJN3/Jz0eexF6fpFF6pYTpQK2MxWVWauo1tN3pPyJ6zm0B4hAigEV6B/w4wKJ9z7BbU2oT6iqfPEGwKdrDqNFwzpLXp2iUF5T0kg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PZFB83NpTChJxhNyUfgfdj8zeS4vEqHVk93Qn+l3IYo=;
 b=Y4Ei9jm+Q6160FRZP09O6+522YiDDLEketKodV0SIXcdORNkFwfxBeDduncqZgv8FnmjiNGNVMizzd/KNUz0UIYjE6Ris66Xd2XOXo7+5ow0l3DlkGbaqs639NkABELyrbRrBNsx37GpaEl56S9x4QIJmBM8B5BMzReBzoj+4NFUbIfSClcJfR1Zve2N/pZpE6Xvrf0p6qTfFOj5JI0sKdlf2PORcp5uWn1IQY2KUYjyrINExIqbMq/nOjHEwvgaShMd0QsIcDTnWr2yTgzRdhKgejDPs3lP1aU5LBLPLmWPt2TyQdZyC4WMePixEx1U+ms5WlwLGfcheyAN/40XRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
Received: from DM6PR12MB2778.namprd12.prod.outlook.com (20.176.114.145) by
 DM6PR12MB3067.namprd12.prod.outlook.com (20.178.30.149) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2430.20; Thu, 7 Nov 2019 17:31:22 +0000
Received: from DM6PR12MB2778.namprd12.prod.outlook.com
 ([fe80::304d:db58:2aa:d69e]) by DM6PR12MB2778.namprd12.prod.outlook.com
 ([fe80::304d:db58:2aa:d69e%6]) with mapi id 15.20.2430.020; Thu, 7 Nov 2019
 17:31:22 +0000
From: "Zhao, Yong" <Yong.Zhao@amd.com>
To: "Kuehling, Felix" <Felix.Kuehling@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH] drm/amdkfd: Simplify the mmap offset related bit
 operations
Thread-Topic: [PATCH] drm/amdkfd: Simplify the mmap offset related bit
 operations
Thread-Index: AQHVlC9KsVca0NKFMUCOBwbcLRM7OKd/KaMAgADP88E=
Date: Thu, 7 Nov 2019 17:31:21 +0000
Message-ID:
 <DM6PR12MB277821CD762FCC79DB3B4B6AF0780@DM6PR12MB2778.namprd12.prod.outlook.com>
References: <20191105231759.19850-1-Yong.Zhao@amd.com>,
 <38503488-c676-9e61-3e09-c27b1dd18e26@amd.com>
In-Reply-To: <38503488-c676-9e61-3e09-c27b1dd18e26@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [165.204.54.211]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 11b87fe9-f40b-43e7-9dda-08d763a84e9f
x-ms-traffictypediagnostic: DM6PR12MB3067:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR12MB306777ED67D6D883C6A2761AF0780@DM6PR12MB3067.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-forefront-prvs: 0214EB3F68
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(4636009)(366004)(136003)(396003)(376002)(39860400002)(346002)(189003)(199004)(446003)(6246003)(7736002)(74316002)(76116006)(64756008)(91956017)(66556008)(66476007)(66946007)(486006)(186003)(81156014)(8936002)(476003)(14454004)(33656002)(19627405001)(105004)(81166006)(26005)(8676002)(11346002)(478600001)(52536014)(86362001)(53546011)(6506007)(5660300002)(66066001)(2501003)(71190400001)(2906002)(76176011)(102836004)(71200400001)(6116002)(7696005)(6436002)(66446008)(54896002)(229853002)(55016002)(9686003)(99286004)(25786009)(110136005)(256004)(3846002)(316002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM6PR12MB3067;
 H:DM6PR12MB2778.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: jPkKEs2r7FPw7dB9jUZjNxOzqwV3c4uXwQ9XVRCvEYAsHgWM8IdOHmvEURwX0wwjFO/yBK92l+KfoIAE1051MiQf6Kz49SsE0zKd/G+HV0tlTBBpVTFPYxw4gMRnTliC435X7BKL0Arm4ktq0IsJAxCxpIhbRU+scqUDiGl8umB2sFMUegUA81XsD6r66EgYFFM0nTmUuxnjXAmk25hhqL85ST3X2aN0GDTH96hnkK69OqS3c053Bu4gcVRi2daXVEeJbs10vuNS96WEYdOn5oZ/QgNa886NULUeIsc0YzXiLLDpBrB7vMF+3FHg+JRDDMLe1/2amT4op16XX8B8KvDJS2ggrt0kczXo7aZi12hl7gJuOofEusIUyxBikRwui7FWOIL0QnoVl/tAwrnK/8aubKVGJjqdM+Fldw+b7ptiZYOj8A47A+dWulUe7h+7
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 11b87fe9-f40b-43e7-9dda-08d763a84e9f
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Nov 2019 17:31:21.9344 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pu4lp29P+dwFz1qogSurwczRm1WkYvw/wRm4hdf0G+bYJKWMytiC9P9gQYjL6u/h
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3067
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PZFB83NpTChJxhNyUfgfdj8zeS4vEqHVk93Qn+l3IYo=;
 b=ZCUBpM0eTOnPC3fQIcA5MAo28jRW4oKehG3+1OxAUD4yTafN6hG2Fnn9PPm8GeP6O+Nq5VpsxoZCrs8kyTf22ZwOJouTTtoa1RvsBQycoNHuw0DMngPdXW1Qq+EIrpr7qToyEAkO+3d3T14EX0Pm5zzGRj+MhaS+84MTTFtshLo=
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
Content-Type: multipart/mixed; boundary="===============1587693292=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
Message-ID: <20191107173121.eLNFOD66GH25uz8sQp5OdlZvQZS0ZA180sOWjz0K75c@z>

--===============1587693292==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_DM6PR12MB277821CD762FCC79DB3B4B6AF0780DM6PR12MB2778namp_"

--_000_DM6PR12MB277821CD762FCC79DB3B4B6AF0780DM6PR12MB2778namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

True. Thank you for spotting that. MMAP-related code was added after I init=
itally drafted this change earlier this year.

Regards,
Yong
________________________________
From: Kuehling, Felix <Felix.Kuehling@amd.com>
Sent: Thursday, November 7, 2019 12:05 AM
To: Zhao, Yong <Yong.Zhao@amd.com>; amd-gfx@lists.freedesktop.org <amd-gfx@=
lists.freedesktop.org>
Subject: Re: [PATCH] drm/amdkfd: Simplify the mmap offset related bit opera=
tions

On 2019-11-05 18:18, Zhao, Yong wrote:
> The new code uses straightforward bit shifts and thus has better
> readability.

You're missing the MMAP-related code for mmio remapping. In
kfd_ioctl_alloc_memory_of_gpu:

         /* MMIO is mapped through kfd device
          * Generate a kfd mmap offset
          */
         if (flags & KFD_IOC_ALLOC_MEM_FLAGS_MMIO_REMAP) {
                 args->mmap_offset =3D KFD_MMAP_TYPE_MMIO |
KFD_MMAP_GPU_ID(args->gpu_id);
                 args->mmap_offset <<=3D PAGE_SHIFT;
         }

Regards,
   Felix

>
> Change-Id: I0c1f7cca7e24ddb7b4ffe1cb0fa71943828ae373
> Signed-off-by: Yong Zhao <Yong.Zhao@amd.com>
> ---
> drivers/gpu/drm/amd/amdkfd/kfd_chardev.c | 10 ++++------
> drivers/gpu/drm/amd/amdkfd/kfd_events.c | 1 -
> drivers/gpu/drm/amd/amdkfd/kfd_priv.h | 9 +++------
> drivers/gpu/drm/amd/amdkfd/kfd_process.c | 3 +--
> 4 files changed, 8 insertions(+), 15 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
> b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
> index b91993753b82..34078df36621 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
> @@ -298,7 +298,6 @@ static int kfd_ioctl_create_queue(struct file
> *filep, struct kfd_process *p,
> /* Return gpu_id as doorbell offset for mmap usage */
> args->doorbell_offset =3D KFD_MMAP_TYPE_DOORBELL;
> args->doorbell_offset |=3D KFD_MMAP_GPU_ID(args->gpu_id);
> - args->doorbell_offset <<=3D PAGE_SHIFT;
> if (KFD_IS_SOC15(dev->device_info->asic_family))
> /* On SOC15 ASICs, include the doorbell offset within the
> * process doorbell frame, which could be 1 page or 2 pages.
> @@ -1938,20 +1937,19 @@ static int kfd_mmap(struct file *filp, struct
> vm_area_struct *vma)
> {
> struct kfd_process *process;
> struct kfd_dev *dev =3D NULL;
> - unsigned long vm_pgoff;
> + unsigned long mmap_offset;
> unsigned int gpu_id;
> process =3D kfd_get_process(current);
> if (IS_ERR(process))
> return PTR_ERR(process);
> - vm_pgoff =3D vma->vm_pgoff;
> - vma->vm_pgoff =3D KFD_MMAP_OFFSET_VALUE_GET(vm_pgoff);
> - gpu_id =3D KFD_MMAP_GPU_ID_GET(vm_pgoff);
> + mmap_offset =3D vma->vm_pgoff << PAGE_SHIFT;
> + gpu_id =3D KFD_MMAP_GET_GPU_ID(mmap_offset);
> if (gpu_id)
> dev =3D kfd_device_by_id(gpu_id);
> - switch (vm_pgoff & KFD_MMAP_TYPE_MASK) {
> + switch (mmap_offset & KFD_MMAP_TYPE_MASK) {
> case KFD_MMAP_TYPE_DOORBELL:
> if (!dev)
> return -ENODEV;
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_events.c
> b/drivers/gpu/drm/amd/amdkfd/kfd_events.c
> index 908081c85de1..1f8365575b12 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_events.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_events.c
> @@ -346,7 +346,6 @@ int kfd_event_create(struct file *devkfd, struct
> kfd_process *p,
> ret =3D create_signal_event(devkfd, p, ev);
> if (!ret) {
> *event_page_offset =3D KFD_MMAP_TYPE_EVENTS;
> - *event_page_offset <<=3D PAGE_SHIFT;
> *event_slot_index =3D ev->event_id;
> }
> break;
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
> b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
> index 66bae8f2dad1..8eecd2cd1fd2 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
> @@ -59,24 +59,21 @@
> * NOTE: struct vm_area_struct.vm_pgoff uses offset in pages. Hence, these
> * defines are w.r.t to PAGE_SIZE
> */
> -#define KFD_MMAP_TYPE_SHIFT (62 - PAGE_SHIFT)
> +#define KFD_MMAP_TYPE_SHIFT (62)
> #define KFD_MMAP_TYPE_MASK (0x3ULL << KFD_MMAP_TYPE_SHIFT)
> #define KFD_MMAP_TYPE_DOORBELL (0x3ULL << KFD_MMAP_TYPE_SHIFT)
> #define KFD_MMAP_TYPE_EVENTS (0x2ULL << KFD_MMAP_TYPE_SHIFT)
> #define KFD_MMAP_TYPE_RESERVED_MEM (0x1ULL << KFD_MMAP_TYPE_SHIFT)
> #define KFD_MMAP_TYPE_MMIO (0x0ULL << KFD_MMAP_TYPE_SHIFT)
> -#define KFD_MMAP_GPU_ID_SHIFT (46 - PAGE_SHIFT)
> +#define KFD_MMAP_GPU_ID_SHIFT (46)
> #define KFD_MMAP_GPU_ID_MASK (((1ULL << KFD_GPU_ID_HASH_WIDTH) - 1) \
> << KFD_MMAP_GPU_ID_SHIFT)
> #define KFD_MMAP_GPU_ID(gpu_id) ((((uint64_t)gpu_id) <<
> KFD_MMAP_GPU_ID_SHIFT)\
> & KFD_MMAP_GPU_ID_MASK)
> -#define KFD_MMAP_GPU_ID_GET(offset) ((offset & KFD_MMAP_GPU_ID_MASK) \
> +#define KFD_MMAP_GET_GPU_ID(offset) ((offset & KFD_MMAP_GPU_ID_MASK) \
> >> KFD_MMAP_GPU_ID_SHIFT)
> -#define KFD_MMAP_OFFSET_VALUE_MASK (0x3FFFFFFFFFFFULL >> PAGE_SHIFT)
> -#define KFD_MMAP_OFFSET_VALUE_GET(offset) (offset &
> KFD_MMAP_OFFSET_VALUE_MASK)
> -
> /*
> * When working with cp scheduler we should assign the HIQ manually or via
> * the amdgpu driver to a fixed hqd slot, here are the fixed HIQ hqd slot
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process.c
> b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
> index 6abfb77ae540..39dc49b8fd85 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_process.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
> @@ -554,8 +554,7 @@ static int kfd_process_init_cwsr_apu(struct
> kfd_process *p, struct file *filep)
> if (!dev->cwsr_enabled || qpd->cwsr_kaddr || qpd->cwsr_base)
> continue;
> - offset =3D (KFD_MMAP_TYPE_RESERVED_MEM | KFD_MMAP_GPU_ID(dev->id))
> - << PAGE_SHIFT;
> + offset =3D KFD_MMAP_TYPE_RESERVED_MEM | KFD_MMAP_GPU_ID(dev->id);
> qpd->tba_addr =3D (int64_t)vm_mmap(filep, 0,
> KFD_CWSR_TBA_TMA_SIZE, PROT_READ | PROT_EXEC,
> MAP_SHARED, offset);

--_000_DM6PR12MB277821CD762FCC79DB3B4B6AF0780DM6PR12MB2778namp_
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
True. Thank you for spotting that.&nbsp;<span style=3D"font-family: &quot;S=
egoe UI&quot;, &quot;Segoe UI Web (West European)&quot;, &quot;Segoe UI&quo=
t;, -apple-system, BlinkMacSystemFont, Roboto, &quot;Helvetica Neue&quot;, =
sans-serif; font-size: 14.6667px; background-color: rgb(255, 255, 255); dis=
play: inline !important">MMAP-related
 code was added after I inititally drafted this change earlier this year.</=
span></div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<span style=3D"font-family: &quot;Segoe UI&quot;, &quot;Segoe UI Web (West =
European)&quot;, &quot;Segoe UI&quot;, -apple-system, BlinkMacSystemFont, R=
oboto, &quot;Helvetica Neue&quot;, sans-serif; font-size: 14.6667px; backgr=
ound-color: rgb(255, 255, 255); display: inline !important"><br>
</span></div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<span style=3D"font-family: &quot;Segoe UI&quot;, &quot;Segoe UI Web (West =
European)&quot;, &quot;Segoe UI&quot;, -apple-system, BlinkMacSystemFont, R=
oboto, &quot;Helvetica Neue&quot;, sans-serif; font-size: 14.6667px; backgr=
ound-color: rgb(255, 255, 255); display: inline !important">Regards,</span>=
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<span style=3D"font-family: &quot;Segoe UI&quot;, &quot;Segoe UI Web (West =
European)&quot;, &quot;Segoe UI&quot;, -apple-system, BlinkMacSystemFont, R=
oboto, &quot;Helvetica Neue&quot;, sans-serif; font-size: 14.6667px; backgr=
ound-color: rgb(255, 255, 255); display: inline !important">Yong</span></di=
v>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Kuehling, Felix &lt;F=
elix.Kuehling@amd.com&gt;<br>
<b>Sent:</b> Thursday, November 7, 2019 12:05 AM<br>
<b>To:</b> Zhao, Yong &lt;Yong.Zhao@amd.com&gt;; amd-gfx@lists.freedesktop.=
org &lt;amd-gfx@lists.freedesktop.org&gt;<br>
<b>Subject:</b> Re: [PATCH] drm/amdkfd: Simplify the mmap offset related bi=
t operations</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">On 2019-11-05 18:18, Zhao, Yong wrote:<br>
&gt; The new code uses straightforward bit shifts and thus has better <br>
&gt; readability.<br>
<br>
You're missing the MMAP-related code for mmio remapping. In <br>
kfd_ioctl_alloc_memory_of_gpu:<br>
<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* MMIO is mapped through =
kfd device<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * Generate a kfd mma=
p offset<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; */<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (flags &amp; KFD_IOC_AL=
LOC_MEM_FLAGS_MMIO_REMAP) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; args-&gt;mmap_offset =3D KFD_MMAP_TYPE_MMIO | <br>
KFD_MMAP_GPU_ID(args-&gt;gpu_id);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; args-&gt;mmap_offset &lt;&lt;=3D PAGE_SHIFT;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
<br>
Regards,<br>
&nbsp;&nbsp; Felix<br>
<br>
&gt;<br>
&gt; Change-Id: I0c1f7cca7e24ddb7b4ffe1cb0fa71943828ae373<br>
&gt; Signed-off-by: Yong Zhao &lt;Yong.Zhao@amd.com&gt;<br>
&gt; ---<br>
&gt; drivers/gpu/drm/amd/amdkfd/kfd_chardev.c | 10 &#43;&#43;&#43;&#43;----=
--<br>
&gt; drivers/gpu/drm/amd/amdkfd/kfd_events.c | 1 -<br>
&gt; drivers/gpu/drm/amd/amdkfd/kfd_priv.h | 9 &#43;&#43;&#43;------<br>
&gt; drivers/gpu/drm/amd/amdkfd/kfd_process.c | 3 &#43;--<br>
&gt; 4 files changed, 8 insertions(&#43;), 15 deletions(-)<br>
&gt;<br>
&gt; diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c <br>
&gt; b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c<br>
&gt; index b91993753b82..34078df36621 100644<br>
&gt; --- a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c<br>
&gt; &#43;&#43;&#43; b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c<br>
&gt; @@ -298,7 &#43;298,6 @@ static int kfd_ioctl_create_queue(struct file =
<br>
&gt; *filep, struct kfd_process *p,<br>
&gt; /* Return gpu_id as doorbell offset for mmap usage */<br>
&gt; args-&gt;doorbell_offset =3D KFD_MMAP_TYPE_DOORBELL;<br>
&gt; args-&gt;doorbell_offset |=3D KFD_MMAP_GPU_ID(args-&gt;gpu_id);<br>
&gt; - args-&gt;doorbell_offset &lt;&lt;=3D PAGE_SHIFT;<br>
&gt; if (KFD_IS_SOC15(dev-&gt;device_info-&gt;asic_family))<br>
&gt; /* On SOC15 ASICs, include the doorbell offset within the<br>
&gt; * process doorbell frame, which could be 1 page or 2 pages.<br>
&gt; @@ -1938,20 &#43;1937,19 @@ static int kfd_mmap(struct file *filp, str=
uct <br>
&gt; vm_area_struct *vma)<br>
&gt; {<br>
&gt; struct kfd_process *process;<br>
&gt; struct kfd_dev *dev =3D NULL;<br>
&gt; - unsigned long vm_pgoff;<br>
&gt; &#43; unsigned long mmap_offset;<br>
&gt; unsigned int gpu_id;<br>
&gt; process =3D kfd_get_process(current);<br>
&gt; if (IS_ERR(process))<br>
&gt; return PTR_ERR(process);<br>
&gt; - vm_pgoff =3D vma-&gt;vm_pgoff;<br>
&gt; - vma-&gt;vm_pgoff =3D KFD_MMAP_OFFSET_VALUE_GET(vm_pgoff);<br>
&gt; - gpu_id =3D KFD_MMAP_GPU_ID_GET(vm_pgoff);<br>
&gt; &#43; mmap_offset =3D vma-&gt;vm_pgoff &lt;&lt; PAGE_SHIFT;<br>
&gt; &#43; gpu_id =3D KFD_MMAP_GET_GPU_ID(mmap_offset);<br>
&gt; if (gpu_id)<br>
&gt; dev =3D kfd_device_by_id(gpu_id);<br>
&gt; - switch (vm_pgoff &amp; KFD_MMAP_TYPE_MASK) {<br>
&gt; &#43; switch (mmap_offset &amp; KFD_MMAP_TYPE_MASK) {<br>
&gt; case KFD_MMAP_TYPE_DOORBELL:<br>
&gt; if (!dev)<br>
&gt; return -ENODEV;<br>
&gt; diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_events.c <br>
&gt; b/drivers/gpu/drm/amd/amdkfd/kfd_events.c<br>
&gt; index 908081c85de1..1f8365575b12 100644<br>
&gt; --- a/drivers/gpu/drm/amd/amdkfd/kfd_events.c<br>
&gt; &#43;&#43;&#43; b/drivers/gpu/drm/amd/amdkfd/kfd_events.c<br>
&gt; @@ -346,7 &#43;346,6 @@ int kfd_event_create(struct file *devkfd, stru=
ct <br>
&gt; kfd_process *p,<br>
&gt; ret =3D create_signal_event(devkfd, p, ev);<br>
&gt; if (!ret) {<br>
&gt; *event_page_offset =3D KFD_MMAP_TYPE_EVENTS;<br>
&gt; - *event_page_offset &lt;&lt;=3D PAGE_SHIFT;<br>
&gt; *event_slot_index =3D ev-&gt;event_id;<br>
&gt; }<br>
&gt; break;<br>
&gt; diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h <br>
&gt; b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h<br>
&gt; index 66bae8f2dad1..8eecd2cd1fd2 100644<br>
&gt; --- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h<br>
&gt; &#43;&#43;&#43; b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h<br>
&gt; @@ -59,24 &#43;59,21 @@<br>
&gt; * NOTE: struct vm_area_struct.vm_pgoff uses offset in pages. Hence, th=
ese<br>
&gt; * defines are w.r.t to PAGE_SIZE<br>
&gt; */<br>
&gt; -#define KFD_MMAP_TYPE_SHIFT (62 - PAGE_SHIFT)<br>
&gt; &#43;#define KFD_MMAP_TYPE_SHIFT (62)<br>
&gt; #define KFD_MMAP_TYPE_MASK (0x3ULL &lt;&lt; KFD_MMAP_TYPE_SHIFT)<br>
&gt; #define KFD_MMAP_TYPE_DOORBELL (0x3ULL &lt;&lt; KFD_MMAP_TYPE_SHIFT)<b=
r>
&gt; #define KFD_MMAP_TYPE_EVENTS (0x2ULL &lt;&lt; KFD_MMAP_TYPE_SHIFT)<br>
&gt; #define KFD_MMAP_TYPE_RESERVED_MEM (0x1ULL &lt;&lt; KFD_MMAP_TYPE_SHIF=
T)<br>
&gt; #define KFD_MMAP_TYPE_MMIO (0x0ULL &lt;&lt; KFD_MMAP_TYPE_SHIFT)<br>
&gt; -#define KFD_MMAP_GPU_ID_SHIFT (46 - PAGE_SHIFT)<br>
&gt; &#43;#define KFD_MMAP_GPU_ID_SHIFT (46)<br>
&gt; #define KFD_MMAP_GPU_ID_MASK (((1ULL &lt;&lt; KFD_GPU_ID_HASH_WIDTH) -=
 1) \<br>
&gt; &lt;&lt; KFD_MMAP_GPU_ID_SHIFT)<br>
&gt; #define KFD_MMAP_GPU_ID(gpu_id) ((((uint64_t)gpu_id) &lt;&lt; <br>
&gt; KFD_MMAP_GPU_ID_SHIFT)\<br>
&gt; &amp; KFD_MMAP_GPU_ID_MASK)<br>
&gt; -#define KFD_MMAP_GPU_ID_GET(offset) ((offset &amp; KFD_MMAP_GPU_ID_MA=
SK) \<br>
&gt; &#43;#define KFD_MMAP_GET_GPU_ID(offset) ((offset &amp; KFD_MMAP_GPU_I=
D_MASK) \<br>
&gt; &gt;&gt; KFD_MMAP_GPU_ID_SHIFT)<br>
&gt; -#define KFD_MMAP_OFFSET_VALUE_MASK (0x3FFFFFFFFFFFULL &gt;&gt; PAGE_S=
HIFT)<br>
&gt; -#define KFD_MMAP_OFFSET_VALUE_GET(offset) (offset &amp; <br>
&gt; KFD_MMAP_OFFSET_VALUE_MASK)<br>
&gt; -<br>
&gt; /*<br>
&gt; * When working with cp scheduler we should assign the HIQ manually or =
via<br>
&gt; * the amdgpu driver to a fixed hqd slot, here are the fixed HIQ hqd sl=
ot<br>
&gt; diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process.c <br>
&gt; b/drivers/gpu/drm/amd/amdkfd/kfd_process.c<br>
&gt; index 6abfb77ae540..39dc49b8fd85 100644<br>
&gt; --- a/drivers/gpu/drm/amd/amdkfd/kfd_process.c<br>
&gt; &#43;&#43;&#43; b/drivers/gpu/drm/amd/amdkfd/kfd_process.c<br>
&gt; @@ -554,8 &#43;554,7 @@ static int kfd_process_init_cwsr_apu(struct <b=
r>
&gt; kfd_process *p, struct file *filep)<br>
&gt; if (!dev-&gt;cwsr_enabled || qpd-&gt;cwsr_kaddr || qpd-&gt;cwsr_base)<=
br>
&gt; continue;<br>
&gt; - offset =3D (KFD_MMAP_TYPE_RESERVED_MEM | KFD_MMAP_GPU_ID(dev-&gt;id)=
)<br>
&gt; - &lt;&lt; PAGE_SHIFT;<br>
&gt; &#43; offset =3D KFD_MMAP_TYPE_RESERVED_MEM | KFD_MMAP_GPU_ID(dev-&gt;=
id);<br>
&gt; qpd-&gt;tba_addr =3D (int64_t)vm_mmap(filep, 0,<br>
&gt; KFD_CWSR_TBA_TMA_SIZE, PROT_READ | PROT_EXEC,<br>
&gt; MAP_SHARED, offset);<br>
</div>
</span></font></div>
</body>
</html>

--_000_DM6PR12MB277821CD762FCC79DB3B4B6AF0780DM6PR12MB2778namp_--

--===============1587693292==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4

--===============1587693292==--
