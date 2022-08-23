Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F4D8C32772
	for <amd-gfx@archiver.kernel.org>; Tue, 23 Aug 2022 12:07:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6E13610E2A3;
	Tue, 23 Aug 2022 12:07:08 +0000 (UTC)
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam07on2043.outbound.protection.outlook.com [40.107.212.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E04D210E2A3
 for <amd-gfx@lists.freedesktop.org>; Tue, 23 Aug 2022 12:06:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZeRAn2Z0h2gULJSHFdwnpRteRPUdC19hs7dWV7K5eXF5aI5avoIvsInrY0rvdVuXHkql3TeLdpHlYXKBSycOQ8V8G9u5vcWCkfsUso9ijRztkJw0/Uw0FUnTvFDgXmwgMisPsiNsobPvKPxHRW/DiJhJO+UTgdTgORFhpBduFkn8VdqLx/QS5axmFNXkEnSrl2JDNVHXyF3lEwttTRCj4cIjSjcAoN//8R5MAUJq0pIvK393Z2/l6vtlSVnOEsAFS0+OobO319mXiR8oxeAyg4WtjTbSYrR27lHsfFHv66L+d+TtDlmxbgfnfvUI3AJvKAyIh0s3D1/5MN8UpaNOkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1j/28odrbH63atWSYTxI3T3zRFtaLhO84vDtERptb7I=;
 b=TMACbTzfOlmKzgRuN+HZdwlJzGpE5cyvb9NCD4JoQDM3q4ClBy1ujs9BS48JU9MBaDKnVg5glbmBgkXRwzf31c1SLw5U/Wq1GFgWAeUp4ACJa9bne6yipCcBadXHNGkfEoLA7Sz9Q69zrbvnxlwYwxhXlF7d+bcdxR7RFXuLx4c16I63air1fiKSBhqBrZcWEtWaB/muMwN3Cp/UdhFQ87Lj/JezFY7XrdhojEV0GCNYbjAFLFrzJlE2JEi2CS0MOsAK5Zx3uNQH2ofGf+IDHFFYG7m90l7UFd9DVkHvXmwZEQwRZrw4Ou9IgBPyW0RXG+MKI1MXfJgUKX5MwObP3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1j/28odrbH63atWSYTxI3T3zRFtaLhO84vDtERptb7I=;
 b=GDSwGb1niIKjnNuod7LhhXjzGo/758w9AJYWHNor/Mshc2DHdO0hua2sVDwy+hOFLVhhgu0kXV45mRiMURDCRii/1ZgDCMmggnnXpZKG3qx3t+LHS8xhm3MQq8QMR+i80zBxoHDz1nF60LnF2fY0J5/pwf82b6CDIJaJgVNyXRg=
Received: from DM5PR12MB1308.namprd12.prod.outlook.com (2603:10b6:3:76::7) by
 BN8PR12MB3203.namprd12.prod.outlook.com (2603:10b6:408:98::11) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5546.19; Tue, 23 Aug 2022 12:06:50 +0000
Received: from DM5PR12MB1308.namprd12.prod.outlook.com
 ([fe80::5097:87be:3557:c681]) by DM5PR12MB1308.namprd12.prod.outlook.com
 ([fe80::5097:87be:3557:c681%5]) with mapi id 15.20.5546.023; Tue, 23 Aug 2022
 12:06:47 +0000
From: "Russell, Kent" <Kent.Russell@amd.com>
To: "Kuehling, Felix" <Felix.Kuehling@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH] drm/amdkfd: Allocate doorbells only when needed
Thread-Topic: [PATCH] drm/amdkfd: Allocate doorbells only when needed
Thread-Index: AQHYp2rCo23YZ8/qaUKYa4PjLqPqkq27Eq/AgAFv8ZA=
Date: Tue, 23 Aug 2022 12:06:47 +0000
Message-ID: <DM5PR12MB1308D8067687E6FD42B0D37B85709@DM5PR12MB1308.namprd12.prod.outlook.com>
References: <20220803185543.36786-1-Felix.Kuehling@amd.com>
 <DM5PR12MB13080A78CC402FE1079EDB7285719@DM5PR12MB1308.namprd12.prod.outlook.com>
In-Reply-To: <DM5PR12MB13080A78CC402FE1079EDB7285719@DM5PR12MB1308.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ac405dda-04e3-4c63-6c83-08da84fff469
x-ms-traffictypediagnostic: BN8PR12MB3203:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: pyCEo2jssuHIgQapiF89b4/3g/8O+YgBRzvuhKmaN+sUtBPKA1Iu9Pt+j/VDwrG20CCe0ISj6OfTkMefSROzpxkCk6cgLcIHYsiT2n6tBd3XUoOVDC3WWnZ7X2L6a0AjcCFUZj2pxpV1EL6HRioZy9v8qBWzAxMlES0nGplrVXbKs3xYBZHT0uDNctXtuXEN0yniFyDnSxKSB/bepX7oONsNFWGiCkz9q3GysG8HPuZcYp3P6VmL7y8rzI8WF0iqUWcUH/4WSSc71qS1rGDphwdpcVCPPsUDOGWHtADq7QuJ03mN2I74mnsqQnxUpEsnp4y3UIh345ZF8T1smjhFq54G+cPE+oVXGkbatq8lnmXKL2k/qGBjX+AvONi+nVNMefmhKBxoP++Dqz4mKQowcX7uFhBymZeF+1tR3TbcKcDulXlqaND+TMR8+fr0dHalktZ+K4K2JxMVSe61+4VXPycl6JFTj1vQ2//nswefRocLK5sjoKbEdKV+iYoIptd1Euru50gqTkbbzh/SKv6+aaAl3wlRLQrmoYyPWC8dp80MtjE2ANk6RnHfb4s3rBL6M1JMhnfOcqtJRE+C1cjpMaPa/K3RcU4Nv00lqzLVeVjUgc/dUHNrKYuHsRuc/yXgnPhTZQi4g2uVqmQGTtfUPvFf84HCausMyluuorRN4vTjXLntBtQcQgmwE2k7JBHNwKnsl/8pLf92jSwx8jb/BtfWbk8mJQ/WbhFISeN2OJD5SMbxZB2sanThDcRYg91G8lCZE6zQ+idjAZe+aVoq8Q==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB1308.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230016)(4636009)(346002)(396003)(39860400002)(366004)(376002)(136003)(66946007)(66476007)(66556008)(66446008)(76116006)(8676002)(64756008)(86362001)(110136005)(91956017)(33656002)(38100700002)(122000001)(8936002)(38070700005)(9686003)(83380400001)(6506007)(186003)(71200400001)(7696005)(41300700001)(478600001)(316002)(55016003)(52536014)(2906002)(5660300002)(53546011);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?AozSRzPreq3h8qzBaS2kh1m40BK/RaSp77mYqENBGFzjQIJL4hdArBp/yqsD?=
 =?us-ascii?Q?pgDyvDXx/XBx50qucfAGxFfWKL+v6dSvlnpJUeMZfrfJdVNGbR4Gy4vmvbKE?=
 =?us-ascii?Q?C0glAK2rcAjtjnJCQ8Hd+Ia7ogDm+E+W5Z5m/9lUsHxZ02CrChRFu99aCHVD?=
 =?us-ascii?Q?29nM4WBtRHxi1ACylF9IbddBC9VSTgQ9o5bXfdfhWgWIlyZjDK3hsKCvQwN5?=
 =?us-ascii?Q?bZc5GPGhuESI2gcFPQYLzd7k6mjfsC0rOeJFjCNN9sB2/dxbKCOHJvufewJo?=
 =?us-ascii?Q?QI/JluhVcRXlkUubffHqWRGWAd2QTZXA9Fq9ib5KYq2qS8lCLb16lmqvfhF0?=
 =?us-ascii?Q?EELJhLf63DabhLLA6DvjLopEGvQSnaNHBpjXRveoW0DNemNU0oxhByZCOJLM?=
 =?us-ascii?Q?16JmiyoZRhDjwYVYCiBR95todMEJQdu7mBsc/mUXMbR4Z2TOyJgLd5aFTgQT?=
 =?us-ascii?Q?v6GK8B6E5TN3FyJXGWaHWRZyT4aCInP79loajnz3Q7C3g7u5tZ+1bnavZvtV?=
 =?us-ascii?Q?BGelIkSB2PWtWLnmSvIMrwcrXWETwWRucZOKxg6ASM+O9w4krCUu16tHXBwC?=
 =?us-ascii?Q?213ppaaF2RAF6wrgGyNJv/1XD+UnNhuJxaJ5OmQH+D0tej/Z4ek0LJ98g70E?=
 =?us-ascii?Q?W6XN6voXlQ/Sa+No9TF7rENF+2tPabkYDSQDL7gLoBgVn1/mzpMz20VJdmAo?=
 =?us-ascii?Q?eGk1bFRKWYVacdAWVqlt2zdajJmnclmHS8lxBmifUdYOWp5wRFaLEZLIQVd7?=
 =?us-ascii?Q?MSnZAMwoYJdd43Ohy5Hdc07yBWKEu6aqoclCTUmvZrAw95mXl/6RQSoJ1Uuv?=
 =?us-ascii?Q?mpM9kv+cwz6EitEOu6dw6MOH2RxNW8kkO2jiFwjT26goVWZ02uE6Tlx0IkPK?=
 =?us-ascii?Q?gsg7RcNEYyYNBfDITrEgCB8B2cSbYMinvad7JRXaMii1hE9gDLeoTCif0Ed6?=
 =?us-ascii?Q?PmS/B6XrjbKOJt9mkKI4UtJAdW//PHtnxMIS+QB3L2TtFVkyEkQEk5UHPrvH?=
 =?us-ascii?Q?EqgeKrhhs/eHLY8mrc4kdPlu2a4/tCcLvPbJwWyW1In5xLhdcffF++zxw2ld?=
 =?us-ascii?Q?cAvdjqWFn1D/T+deXw2QOkgQrvM94kRloH3YxvH3u+DfjYL4FDCVRmt8hDjr?=
 =?us-ascii?Q?ndlCwD90dUt30hG4xNrWg5UfvnFIx33cRX3+JXf9o6pk0NO+Iym7RDnQTJRy?=
 =?us-ascii?Q?BX1gGJvnABn+G0oBbUcQXGoWxnoVnPotrb3fPlYrXvu77+WWx9O9riYFBgmM?=
 =?us-ascii?Q?qVljWl35LL8u1gG1ZsAs/+ZRPylqHHY9SOlJgCfytW4KoQhE97bJu1jpJ5Ki?=
 =?us-ascii?Q?RoDQqDb4jqZTwbkffmpaGqGBxTHLqLWwAI9MHPS00AywI+PFaNOVUX0ncNrM?=
 =?us-ascii?Q?7F9XFa/WfuImXNVT2pVFMEaP81/rOCw1GgZFXR7SWSFNEVLDW+C0ifhJTED9?=
 =?us-ascii?Q?m6BOIYz3SePj0aw2aBQknsdaaPFzPrssSs6oxeJhDsXfePsW43XObX6jsoXa?=
 =?us-ascii?Q?fiGTpbP3ZhDrg9z3hcccIW44VtybxTdw6nl6dWXRS9xpD2xc7h1Kauq/voxX?=
 =?us-ascii?Q?hHkk/99hOd0aYwVdfKqXvzc+MSMYyNHgeOs7aH8thhCwdvxFGQPUt1D88BmA?=
 =?us-ascii?Q?+qF9udwO1JC5YKLd3h/Mh1M=3D?=
Content-Type: multipart/alternative;
 boundary="_000_DM5PR12MB1308D8067687E6FD42B0D37B85709DM5PR12MB1308namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB1308.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ac405dda-04e3-4c63-6c83-08da84fff469
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Aug 2022 12:06:47.7954 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: EKv9dvCHhgPMdyQ0sZbH7wxwBTK+HiGwK3ah/d/oiA1FjbzrsqpWFcDhnjcNv5p1CbVLOzK2tHVb59S5jCR62A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR12MB3203
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--_000_DM5PR12MB1308D8067687E6FD42B0D37B85709DM5PR12MB1308namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

No one else seems to have any thoughts on it, so Reviewed-by: Kent Russell =
<kent.Russell@amd.com>

 Kent

________________________________
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> on behalf of Russell,=
 Kent <Kent.Russell@amd.com>
Sent: Monday, August 22, 2022 10:10 AM
To: Kuehling, Felix <Felix.Kuehling@amd.com>; amd-gfx@lists.freedesktop.org=
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdkfd: Allocate doorbells only when needed

[AMD Official Use Only - General]

I can throw an Acked-by: Kent Russell <kent.russell@amd.com> since we don't=
 have an RB yet.

 Kent

> -----Original Message-----
> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Felix
> Kuehling
> Sent: Wednesday, August 3, 2022 2:56 PM
> To: amd-gfx@lists.freedesktop.org
> Subject: [PATCH] drm/amdkfd: Allocate doorbells only when needed
>
> Only allocate doorbells when the first queue is created on a GPU or the
> doorbells need to be mapped into CPU or GPU virtual address space. This
> avoids allocating doorbells unnecessarily and can allow more processes
> to use KFD on multi-GPU systems.
>
> Signed-off-by: Felix Kuehling <Felix.Kuehling@amd.com>
> ---
>  drivers/gpu/drm/amd/amdkfd/kfd_chardev.c  | 13 +++++++++++++
>  drivers/gpu/drm/amd/amdkfd/kfd_doorbell.c |  9 +++++++++
>  drivers/gpu/drm/amd/amdkfd/kfd_process.c  |  5 -----
>  3 files changed, 22 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
> b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
> index 2b3d8bc8f0aa..907f4711abce 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
> @@ -327,6 +327,12 @@ static int kfd_ioctl_create_queue(struct file *filep=
,
> struct kfd_process *p,
>                goto err_bind_process;
>        }
>
> +     if (!pdd->doorbell_index &&
> +         kfd_alloc_process_doorbells(dev, &pdd->doorbell_index) < 0) {
> +             err =3D -ENOMEM;
> +             goto err_alloc_doorbells;
> +     }
> +
>        /* Starting with GFX11, wptr BOs must be mapped to GART for MES to
> determine work
>         * on unmapped queues for usermode queue oversubscription (no
> aggregated doorbell)
>         */
> @@ -404,6 +410,7 @@ static int kfd_ioctl_create_queue(struct file *filep,=
 struct
> kfd_process *p,
>        if (wptr_bo)
>                amdgpu_amdkfd_free_gtt_mem(dev->adev, wptr_bo);
>  err_wptr_map_gart:
> +err_alloc_doorbells:
>  err_bind_process:
>  err_pdd:
>        mutex_unlock(&p->mutex);
> @@ -1092,6 +1099,10 @@ static int kfd_ioctl_alloc_memory_of_gpu(struct fi=
le
> *filep,
>                        goto err_unlock;
>                }
>                offset =3D kfd_get_process_doorbells(pdd);
> +             if (!offset) {
> +                     err =3D -ENOMEM;
> +                     goto err_unlock;
> +             }
>        } else if (flags & KFD_IOC_ALLOC_MEM_FLAGS_MMIO_REMAP) {
>                if (args->size !=3D PAGE_SIZE) {
>                        err =3D -EINVAL;
> @@ -2173,6 +2184,8 @@ static int criu_restore_memory_of_gpu(struct
> kfd_process_device *pdd,
>                        return -EINVAL;
>
>                offset =3D kfd_get_process_doorbells(pdd);
> +             if (!offset)
> +                     return -ENOMEM;
>        } else if (bo_bucket->alloc_flags &
> KFD_IOC_ALLOC_MEM_FLAGS_MMIO_REMAP) {
>                /* MMIO BOs need remapped bus address */
>                if (bo_bucket->size !=3D PAGE_SIZE) {
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_doorbell.c
> b/drivers/gpu/drm/amd/amdkfd/kfd_doorbell.c
> index cb3d2ccc5100..b33798f89ef0 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_doorbell.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_doorbell.c
> @@ -157,6 +157,8 @@ int kfd_doorbell_mmap(struct kfd_dev *dev, struct
> kfd_process *process,
>
>        /* Calculate physical address of doorbell */
>        address =3D kfd_get_process_doorbells(pdd);
> +     if (!address)
> +             return -ENOMEM;
>        vma->vm_flags |=3D VM_IO | VM_DONTCOPY | VM_DONTEXPAND |
> VM_NORESERVE |
>                                VM_DONTDUMP | VM_PFNMAP;
>
> @@ -275,6 +277,13 @@ uint64_t kfd_get_number_elems(struct kfd_dev *kfd)
>
>  phys_addr_t kfd_get_process_doorbells(struct kfd_process_device *pdd)
>  {
> +     if (!pdd->doorbell_index) {
> +             int r =3D kfd_alloc_process_doorbells(pdd->dev,
> +                                                 &pdd->doorbell_index);
> +             if (r)
> +                     return 0;
> +     }
> +
>        return pdd->dev->doorbell_base +
>                pdd->doorbell_index * kfd_doorbell_process_slice(pdd->dev)=
;
>  }
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process.c
> b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
> index 6c83a519b3a1..951b63677248 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_process.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
> @@ -1499,11 +1499,6 @@ struct kfd_process_device
> *kfd_create_process_device_data(struct kfd_dev *dev,
>        if (!pdd)
>                return NULL;
>
> -     if (kfd_alloc_process_doorbells(dev, &pdd->doorbell_index) < 0) {
> -             pr_err("Failed to alloc doorbell for pdd\n");
> -             goto err_free_pdd;
> -     }
> -
>        if (init_doorbell_bitmap(&pdd->qpd, dev)) {
>                pr_err("Failed to init doorbell for process\n");
>                goto err_free_pdd;
> --
> 2.32.0

--_000_DM5PR12MB1308D8067687E6FD42B0D37B85709DM5PR12MB1308namp_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
</head>
<body>
<div>No one else seems to have any thoughts on it, so Reviewed-by: Kent Rus=
sell &lt;kent.Russell@amd.com&gt;</div>
<div><br>
</div>
<div>&nbsp;Kent</div>
<br>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> amd-gfx &lt;amd-gfx-b=
ounces@lists.freedesktop.org&gt; on behalf of Russell, Kent &lt;Kent.Russel=
l@amd.com&gt;<br>
<b>Sent:</b> Monday, August 22, 2022 10:10 AM<br>
<b>To:</b> Kuehling, Felix &lt;Felix.Kuehling@amd.com&gt;; amd-gfx@lists.fr=
eedesktop.org &lt;amd-gfx@lists.freedesktop.org&gt;<br>
<b>Subject:</b> RE: [PATCH] drm/amdkfd: Allocate doorbells only when needed=
</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">[AMD Official Use Only - General]<br>
<br>
I can throw an Acked-by: Kent Russell &lt;kent.russell@amd.com&gt; since we=
 don't have an RB yet.<br>
<br>
&nbsp;Kent<br>
<br>
&gt; -----Original Message-----<br>
&gt; From: amd-gfx &lt;amd-gfx-bounces@lists.freedesktop.org&gt; On Behalf =
Of Felix<br>
&gt; Kuehling<br>
&gt; Sent: Wednesday, August 3, 2022 2:56 PM<br>
&gt; To: amd-gfx@lists.freedesktop.org<br>
&gt; Subject: [PATCH] drm/amdkfd: Allocate doorbells only when needed<br>
&gt; <br>
&gt; Only allocate doorbells when the first queue is created on a GPU or th=
e<br>
&gt; doorbells need to be mapped into CPU or GPU virtual address space. Thi=
s<br>
&gt; avoids allocating doorbells unnecessarily and can allow more processes=
<br>
&gt; to use KFD on multi-GPU systems.<br>
&gt; <br>
&gt; Signed-off-by: Felix Kuehling &lt;Felix.Kuehling@amd.com&gt;<br>
&gt; ---<br>
&gt;&nbsp; drivers/gpu/drm/amd/amdkfd/kfd_chardev.c&nbsp; | 13 ++++++++++++=
+<br>
&gt;&nbsp; drivers/gpu/drm/amd/amdkfd/kfd_doorbell.c |&nbsp; 9 +++++++++<br=
>
&gt;&nbsp; drivers/gpu/drm/amd/amdkfd/kfd_process.c&nbsp; |&nbsp; 5 -----<b=
r>
&gt;&nbsp; 3 files changed, 22 insertions(+), 5 deletions(-)<br>
&gt; <br>
&gt; diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c<br>
&gt; b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c<br>
&gt; index 2b3d8bc8f0aa..907f4711abce 100644<br>
&gt; --- a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c<br>
&gt; +++ b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c<br>
&gt; @@ -327,6 +327,12 @@ static int kfd_ioctl_create_queue(struct file *fi=
lep,<br>
&gt; struct kfd_process *p,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; goto err_bind_process;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt; <br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; if (!pdd-&gt;doorbell_index &amp;&amp;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; kfd_alloc_process_do=
orbells(dev, &amp;pdd-&gt;doorbell_index) &lt; 0) {<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; err =3D -ENOMEM;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; goto err_alloc_doorbells;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt; +<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Starting with GFX11, wptr=
 BOs must be mapped to GART for MES to<br>
&gt; determine work<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * on unmapped queues f=
or usermode queue oversubscription (no<br>
&gt; aggregated doorbell)<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; */<br>
&gt; @@ -404,6 +410,7 @@ static int kfd_ioctl_create_queue(struct file *fil=
ep, struct<br>
&gt; kfd_process *p,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (wptr_bo)<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; amdgpu_amdkfd_free_gtt_mem(dev-&gt;adev, wptr_bo);<br>
&gt;&nbsp; err_wptr_map_gart:<br>
&gt; +err_alloc_doorbells:<br>
&gt;&nbsp; err_bind_process:<br>
&gt;&nbsp; err_pdd:<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mutex_unlock(&amp;p-&gt;mute=
x);<br>
&gt; @@ -1092,6 +1099,10 @@ static int kfd_ioctl_alloc_memory_of_gpu(struct=
 file<br>
&gt; *filep,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; goto er=
r_unlock;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; }<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; offset =3D kfd_get_process_doorbells(pdd);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; if (!offset) {<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; err =3D -ENOMEM;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; goto err_unlock;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; }<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } else if (flags &amp; KFD_I=
OC_ALLOC_MEM_FLAGS_MMIO_REMAP) {<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; if (args-&gt;size !=3D PAGE_SIZE) {<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; err =3D=
 -EINVAL;<br>
&gt; @@ -2173,6 +2184,8 @@ static int criu_restore_memory_of_gpu(struct<br>
&gt; kfd_process_device *pdd,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return =
-EINVAL;<br>
&gt; <br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; offset =3D kfd_get_process_doorbells(pdd);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; if (!offset)<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return -ENOMEM;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } else if (bo_bucket-&gt;all=
oc_flags &amp;<br>
&gt; KFD_IOC_ALLOC_MEM_FLAGS_MMIO_REMAP) {<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; /* MMIO BOs need remapped bus address */<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; if (bo_bucket-&gt;size !=3D PAGE_SIZE) {<br>
&gt; diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_doorbell.c<br>
&gt; b/drivers/gpu/drm/amd/amdkfd/kfd_doorbell.c<br>
&gt; index cb3d2ccc5100..b33798f89ef0 100644<br>
&gt; --- a/drivers/gpu/drm/amd/amdkfd/kfd_doorbell.c<br>
&gt; +++ b/drivers/gpu/drm/amd/amdkfd/kfd_doorbell.c<br>
&gt; @@ -157,6 +157,8 @@ int kfd_doorbell_mmap(struct kfd_dev *dev, struct<=
br>
&gt; kfd_process *process,<br>
&gt; <br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Calculate physical addres=
s of doorbell */<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; address =3D kfd_get_process_=
doorbells(pdd);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; if (!address)<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; return -ENOMEM;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; vma-&gt;vm_flags |=3D VM_IO =
| VM_DONTCOPY | VM_DONTEXPAND |<br>
&gt; VM_NORESERVE |<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; VM_DONTDUMP | VM_PFNMAP;<br>
&gt; <br>
&gt; @@ -275,6 +277,13 @@ uint64_t kfd_get_number_elems(struct kfd_dev *kfd=
)<br>
&gt; <br>
&gt;&nbsp; phys_addr_t kfd_get_process_doorbells(struct kfd_process_device =
*pdd)<br>
&gt;&nbsp; {<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; if (!pdd-&gt;doorbell_index) {<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; int r =3D kfd_alloc_process_doorbells(pdd-&gt;dev,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &amp;=
pdd-&gt;doorbell_index);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; if (r)<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt; +<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return pdd-&gt;dev-&gt;doorb=
ell_base +<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; pdd-&gt;doorbell_index * kfd_doorbell_process_slice(pdd=
-&gt;dev);<br>
&gt;&nbsp; }<br>
&gt; diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process.c<br>
&gt; b/drivers/gpu/drm/amd/amdkfd/kfd_process.c<br>
&gt; index 6c83a519b3a1..951b63677248 100644<br>
&gt; --- a/drivers/gpu/drm/amd/amdkfd/kfd_process.c<br>
&gt; +++ b/drivers/gpu/drm/amd/amdkfd/kfd_process.c<br>
&gt; @@ -1499,11 +1499,6 @@ struct kfd_process_device<br>
&gt; *kfd_create_process_device_data(struct kfd_dev *dev,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!pdd)<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; return NULL;<br>
&gt; <br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; if (kfd_alloc_process_doorbells(dev, &amp;pd=
d-&gt;doorbell_index) &lt; 0) {<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; pr_err(&quot;Failed to alloc doorbell for pdd\n&quot;);<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; goto err_free_pdd;<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt; -<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (init_doorbell_bitmap(&am=
p;pdd-&gt;qpd, dev)) {<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; pr_err(&quot;Failed to init doorbell for process\n&quot=
;);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; goto err_free_pdd;<br>
&gt; --<br>
&gt; 2.32.0<br>
</div>
</span></font></div>
</body>
</html>

--_000_DM5PR12MB1308D8067687E6FD42B0D37B85709DM5PR12MB1308namp_--
