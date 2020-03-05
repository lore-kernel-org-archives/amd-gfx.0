Return-Path: <SRS0=Sanp=4W=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MIME_HTML_MOSTLY,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2B40C3F2D1
	for <amd-gfx@archiver.kernel.org>; Thu,  5 Mar 2020 20:55:53 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8A97320705
	for <amd-gfx@archiver.kernel.org>; Thu,  5 Mar 2020 20:55:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="aRf51PfZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8A97320705
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 04AEC6EC12;
	Thu,  5 Mar 2020 20:55:53 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-eopbgr770058.outbound.protection.outlook.com [40.107.77.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 782E26EC12
 for <amd-gfx@lists.freedesktop.org>; Thu,  5 Mar 2020 20:55:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GwepBx6v1ZzZfH2ugXKFLNokmwmoU9Om0linjaFLvDYPhw6gZV/682h4c3fqkbd5CbhCb4eHYubDhcU4ozVWga04D1qstuDZzvVALQ2As0v7C37gkKJurVyjqW+WPXmi92yGmbqBAAg0ovLnZ6FNFf+dYOBbEQ1CR8xObHtIKcNDghAiSd6YPf+a/V9j/1r/OFvrztVUX4lNTj2bOuDhCVN3KLH1jAE4WEjzKF0BbhEOe1Qj8Cs96iDusXh6qjCw25pj2nqXWB7GBKzzw6kXaWKUSkRhRhnkings0sVsuM/EKtT20YbM4kqq98muApaZmLyPx0OSOb1lYDeMmDTxEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xq9CpyZWugOUIh0ijGpR+C+G3L7D6Q/kPio2P9Y5gnw=;
 b=RRxATuCTi5Vqob6Eb/66XQLbSRlkNZa4EbsE7wP8vOH22illMEVqzjPnq7/NaW3+y9ROiBBN9C5AM37UMQ5HW2nAlYuc5ILHsN6kxdqiq5dB15g1mLYNJ2iUOsJ3dpqTfi+w6aDwozQ6Kcfx7Ts9slGwLJ+6q3629pI7WkhOTce/irZuHIMZbvLTbi2BlR8kfFE+CHOrkUGz5dD29NpR52k7ebjV/y+MxO87Ct36qXdExXmuLNQr94QioKdxx3Z7HokDyI4uYZwN0yltlbn/4BWiRhK7WSk1yS0EsXC7FpFHVIcNzHihO7jnKB0aq3HjkQWP+cfjBqqUjckld/wAAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xq9CpyZWugOUIh0ijGpR+C+G3L7D6Q/kPio2P9Y5gnw=;
 b=aRf51PfZuJkmtnSPaBhPL4P3YX7twpX8UYfg+xTEClkqTi1uwsHEVyGKpsT+inhTJZZXBo6R8/MFmrhet4ovcpGazH1pG79HSpmrNc+MwLYVDDWq1fv4suGUMeJXpzsmihKokPtRa59FOBKtSm5SQCFdEiS8Cy3nTEKXY6go6+k=
Received: from CH2PR12MB3926.namprd12.prod.outlook.com (2603:10b6:610:27::30)
 by CH2PR12MB4325.namprd12.prod.outlook.com (2603:10b6:610:a9::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2772.15; Thu, 5 Mar
 2020 20:55:49 +0000
Received: from CH2PR12MB3926.namprd12.prod.outlook.com
 ([fe80::8c06:4379:c755:dfe4]) by CH2PR12MB3926.namprd12.prod.outlook.com
 ([fe80::8c06:4379:c755:dfe4%4]) with mapi id 15.20.2772.019; Thu, 5 Mar 2020
 20:55:49 +0000
From: "Zhao, Yong" <Yong.Zhao@amd.com>
To: "Kuehling, Felix" <Felix.Kuehling@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH] drm/amdkfd: Consolidate duplicated bo alloc flags
Thread-Topic: [PATCH] drm/amdkfd: Consolidate duplicated bo alloc flags
Thread-Index: AQHV8mKNyMTOTpwoHUyzlVgZZhg7U6g6ekOAgAAAS7E=
Date: Thu, 5 Mar 2020 20:55:49 +0000
Message-ID: <CH2PR12MB3926C6062226E00D4626CC43F0E20@CH2PR12MB3926.namprd12.prod.outlook.com>
References: <20200304202145.22021-1-Yong.Zhao@amd.com>,
 <48c5b228-99e3-2041-92c8-efc87de0586f@amd.com>
In-Reply-To: <48c5b228-99e3-2041-92c8-efc87de0586f@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=True;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2020-03-05T20:55:48.037Z;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal
 Distribution
 Only; MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=0;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard; 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Yong.Zhao@amd.com; 
x-originating-ip: [99.252.169.159]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: b3afa003-9be9-4558-f5e2-08d7c14795f9
x-ms-traffictypediagnostic: CH2PR12MB4325:|CH2PR12MB4325:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CH2PR12MB432574AA11F80FA8C1E475D6F0E20@CH2PR12MB4325.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-forefront-prvs: 03333C607F
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(4636009)(376002)(366004)(396003)(346002)(39860400002)(136003)(189003)(199004)(316002)(478600001)(110136005)(66446008)(6506007)(66556008)(66476007)(64756008)(81156014)(186003)(86362001)(81166006)(53546011)(2906002)(8676002)(8936002)(26005)(66946007)(33656002)(7696005)(9686003)(19627405001)(55016002)(76116006)(71200400001)(52536014)(5660300002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:CH2PR12MB4325;
 H:CH2PR12MB3926.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 7G9okZQzyT8onYVMjJvlS6VngiQkQH/ZQgwFPyt8slGQwt7ooTcnyibO8LbGh1+hGa8sulgwaRvCWRsGOIcl+YQkHJrJYWBRQ2enrUdrero/Jibl41PDjVvLzFVPNMhIiu9uc0odMWJ+odzFUmVpJve5FDCdfFoiChseOrvgkZRrymWhWHsbX7af35sgPPlPwIkviQrRME5MKkJEeNFN6XnS1IDdHcMGaewovemv+Dts3PIK2v5ktx2uTuI4IZ8JteFedyJaOqFSpZ7YWiP0ButxqJ0rrjtRA5Gjqz+Ep2Il3Ut7SfN9fr04W+x2HjOsdazcscE8jswot5u2UmIRj6mv8hLNFIVsbzxj1WQN9hUFLZQCyjEzrjJOq7SPpwhqQksSyn6ILGITLS7kNkgXCETQ6Ji9uy75Mq2sRP8faqGAfO4XOls+DcRRWEovlDCQ
x-ms-exchange-antispam-messagedata: Gsa3IKZLuuFljbI0fQrcfKmwEXP7O/n8s1ENQK/mUNrNObJ59ed1dDatj4sujliZU1U5RVIXsakqS1krmCeaVgFYqR5ml3VXq82teJpttd6rePDAVBNqPvaQJfRqShZkEA6l7J+towIA0pcQtHChdA==
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b3afa003-9be9-4558-f5e2-08d7c14795f9
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Mar 2020 20:55:49.7480 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 03Uc35FwE1kVdMfu+3uxgXs27Bud023VdDaTr1NN6AUlOL5I/fkpyuvZCdVFXmlB
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4325
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
Content-Type: multipart/mixed; boundary="===============0937963505=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============0937963505==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_CH2PR12MB3926C6062226E00D4626CC43F0E20CH2PR12MB3926namp_"

--_000_CH2PR12MB3926C6062226E00D4626CC43F0E20CH2PR12MB3926namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only - Internal Distribution Only]

Okay, I will change back to its original format.

Yong

________________________________
From: Kuehling, Felix <Felix.Kuehling@amd.com>
Sent: Thursday, March 5, 2020 3:49 PM
To: amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>; Zhao, Yo=
ng <Yong.Zhao@amd.com>
Subject: Re: [PATCH] drm/amdkfd: Consolidate duplicated bo alloc flags

On 2020-03-04 3:21 p.m., Yong Zhao wrote:
> ALLOC_MEM_FLAGS_* used are the same as the KFD_IOC_ALLOC_MEM_FLAGS_*,
> but they are interweavedly used in kernel driver, resulting in bad
> readability. For example, KFD_IOC_ALLOC_MEM_FLAGS_COHERENT is totally
> not referenced in kernel, and it functions in the kernel through
> ALLOC_MEM_FLAGS_COHERENT, causing unnecessary confusion.
>
> Replace all occurrences of ALLOC_MEM_FLAGS_* by
> KFD_IOC_ALLOC_MEM_FLAGS_* to solve the problem.
>
> Change-Id: Iced6ed3698167296c97b14e7e4569883859d619c
> Signed-off-by: Yong Zhao <Yong.Zhao@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c    |  9 +++--
>   .../gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c  | 38 +++++++++++--------
>   drivers/gpu/drm/amd/amdkfd/kfd_process.c      | 13 ++++---
>   .../gpu/drm/amd/include/kgd_kfd_interface.h   | 21 ----------
>   4 files changed, 36 insertions(+), 45 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c b/drivers/gpu/drm=
/amd/amdgpu/amdgpu_amdkfd.c
> index 726c91ab6761..affaa0d4b636 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
> @@ -29,6 +29,7 @@
>   #include <linux/module.h>
>   #include <linux/dma-buf.h>
>   #include "amdgpu_xgmi.h"
> +#include <uapi/linux/kfd_ioctl.h>
>
>   static const unsigned int compute_vmid_bitmap =3D 0xFF00;
>
> @@ -500,11 +501,13 @@ int amdgpu_amdkfd_get_dmabuf_info(struct kgd_dev *k=
gd, int dma_buf_fd,
>                r =3D amdgpu_bo_get_metadata(bo, metadata_buffer, buffer_s=
ize,
>                                           metadata_size, &metadata_flags)=
;
>        if (flags) {
> -             *flags =3D (bo->preferred_domains & AMDGPU_GEM_DOMAIN_VRAM)=
 ?
> -                     ALLOC_MEM_FLAGS_VRAM : ALLOC_MEM_FLAGS_GTT;
> +             if (bo->preferred_domains & AMDGPU_GEM_DOMAIN_VRAM)
> +                     *flags =3D KFD_IOC_ALLOC_MEM_FLAGS_VRAM;
> +             else
> +                     *flags =3D KFD_IOC_ALLOC_MEM_FLAGS_GTT;

You're sneaking in some personal preference (changing the trinary (cond
? a : b) operator to if-else) with the renaming change. Personally I
find the trinary operator just as readable and more concise.


>
>                if (bo->flags & AMDGPU_GEM_CREATE_CPU_ACCESS_REQUIRED)
> -                     *flags |=3D ALLOC_MEM_FLAGS_PUBLIC;
> +                     *flags |=3D KFD_IOC_ALLOC_MEM_FLAGS_PUBLIC;
>        }
>
>   out_put:
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c b/drivers/g=
pu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> index e4481caed648..c81fe7011e88 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> @@ -29,6 +29,7 @@
>   #include "amdgpu_vm.h"
>   #include "amdgpu_amdkfd.h"
>   #include "amdgpu_dma_buf.h"
> +#include <uapi/linux/kfd_ioctl.h>
>
>   /* BO flag to indicate a KFD userptr BO */
>   #define AMDGPU_AMDKFD_USERPTR_BO (1ULL << 63)
> @@ -400,18 +401,18 @@ static int vm_update_pds(struct amdgpu_vm *vm, stru=
ct amdgpu_sync *sync)
>   static uint64_t get_pte_flags(struct amdgpu_device *adev, struct kgd_me=
m *mem)
>   {
>        struct amdgpu_device *bo_adev =3D amdgpu_ttm_adev(mem->bo->tbo.bde=
v);
> -     bool coherent =3D mem->alloc_flags & ALLOC_MEM_FLAGS_COHERENT;
> +     bool coherent =3D mem->alloc_flags & KFD_IOC_ALLOC_MEM_FLAGS_COHERE=
NT;
>        uint32_t mapping_flags;
>
>        mapping_flags =3D AMDGPU_VM_PAGE_READABLE;
> -     if (mem->alloc_flags & ALLOC_MEM_FLAGS_WRITABLE)
> +     if (mem->alloc_flags & KFD_IOC_ALLOC_MEM_FLAGS_WRITABLE)
>                mapping_flags |=3D AMDGPU_VM_PAGE_WRITEABLE;
> -     if (mem->alloc_flags & ALLOC_MEM_FLAGS_EXECUTABLE)
> +     if (mem->alloc_flags & KFD_IOC_ALLOC_MEM_FLAGS_EXECUTABLE)
>                mapping_flags |=3D AMDGPU_VM_PAGE_EXECUTABLE;
>
>        switch (adev->asic_type) {
>        case CHIP_ARCTURUS:
> -             if (mem->alloc_flags & ALLOC_MEM_FLAGS_VRAM) {
> +             if (mem->alloc_flags & KFD_IOC_ALLOC_MEM_FLAGS_VRAM) {
>                        if (bo_adev =3D=3D adev)
>                                mapping_flags |=3D coherent ?
>                                        AMDGPU_VM_MTYPE_CC : AMDGPU_VM_MTY=
PE_RW;
> @@ -1160,24 +1161,24 @@ int amdgpu_amdkfd_gpuvm_alloc_memory_of_gpu(
>        /*
>         * Check on which domain to allocate BO
>         */
> -     if (flags & ALLOC_MEM_FLAGS_VRAM) {
> +     if (flags & KFD_IOC_ALLOC_MEM_FLAGS_VRAM) {
>                domain =3D alloc_domain =3D AMDGPU_GEM_DOMAIN_VRAM;
>                alloc_flags =3D AMDGPU_GEM_CREATE_VRAM_WIPE_ON_RELEASE;
> -             alloc_flags |=3D (flags & ALLOC_MEM_FLAGS_PUBLIC) ?
> +             alloc_flags |=3D (flags & KFD_IOC_ALLOC_MEM_FLAGS_PUBLIC) ?
>                        AMDGPU_GEM_CREATE_CPU_ACCESS_REQUIRED :
>                        AMDGPU_GEM_CREATE_NO_CPU_ACCESS;
> -     } else if (flags & ALLOC_MEM_FLAGS_GTT) {
> +     } else if (flags & KFD_IOC_ALLOC_MEM_FLAGS_GTT) {
>                domain =3D alloc_domain =3D AMDGPU_GEM_DOMAIN_GTT;
>                alloc_flags =3D 0;
> -     } else if (flags & ALLOC_MEM_FLAGS_USERPTR) {
> +     } else if (flags & KFD_IOC_ALLOC_MEM_FLAGS_USERPTR) {
>                domain =3D AMDGPU_GEM_DOMAIN_GTT;
>                alloc_domain =3D AMDGPU_GEM_DOMAIN_CPU;
>                alloc_flags =3D 0;
>                if (!offset || !*offset)
>                        return -EINVAL;
>                user_addr =3D untagged_addr(*offset);
> -     } else if (flags & (ALLOC_MEM_FLAGS_DOORBELL |
> -                     ALLOC_MEM_FLAGS_MMIO_REMAP)) {
> +     } else if (flags & (KFD_IOC_ALLOC_MEM_FLAGS_DOORBELL |
> +                     KFD_IOC_ALLOC_MEM_FLAGS_MMIO_REMAP)) {
>                domain =3D AMDGPU_GEM_DOMAIN_GTT;
>                alloc_domain =3D AMDGPU_GEM_DOMAIN_CPU;
>                bo_type =3D ttm_bo_type_sg;
> @@ -1198,7 +1199,7 @@ int amdgpu_amdkfd_gpuvm_alloc_memory_of_gpu(
>        }
>        INIT_LIST_HEAD(&(*mem)->bo_va_list);
>        mutex_init(&(*mem)->lock);
> -     (*mem)->aql_queue =3D !!(flags & ALLOC_MEM_FLAGS_AQL_QUEUE_MEM);
> +     (*mem)->aql_queue =3D !!(flags & KFD_IOC_ALLOC_MEM_FLAGS_AQL_QUEUE_=
MEM);
>
>        /* Workaround for AQL queue wraparound bug. Map the same
>         * memory twice. That means we only actually allocate half
> @@ -1652,6 +1653,7 @@ int amdgpu_amdkfd_gpuvm_import_dmabuf(struct kgd_de=
v *kgd,
>        struct drm_gem_object *obj;
>        struct amdgpu_bo *bo;
>        struct amdgpu_vm *avm =3D (struct amdgpu_vm *)vm;
> +     uint32_t flags;
>
>        if (dma_buf->ops !=3D &amdgpu_dmabuf_ops)
>                /* Can't handle non-graphics buffers */
> @@ -1680,10 +1682,16 @@ int amdgpu_amdkfd_gpuvm_import_dmabuf(struct kgd_=
dev *kgd,
>
>        INIT_LIST_HEAD(&(*mem)->bo_va_list);
>        mutex_init(&(*mem)->lock);
> -     (*mem)->alloc_flags =3D
> -             ((bo->preferred_domains & AMDGPU_GEM_DOMAIN_VRAM) ?
> -              ALLOC_MEM_FLAGS_VRAM : ALLOC_MEM_FLAGS_GTT) |
> -             ALLOC_MEM_FLAGS_WRITABLE | ALLOC_MEM_FLAGS_EXECUTABLE;
> +
> +     flags =3D KFD_IOC_ALLOC_MEM_FLAGS_WRITABLE
> +             | KFD_IOC_ALLOC_MEM_FLAGS_EXECUTABLE;
> +
> +     if (bo->preferred_domains & AMDGPU_GEM_DOMAIN_VRAM)
> +             flags |=3D KFD_IOC_ALLOC_MEM_FLAGS_VRAM;
> +     else
> +             flags |=3D KFD_IOC_ALLOC_MEM_FLAGS_GTT;
> +
> +     (*mem)->alloc_flags =3D flags;

Same as above. The original code was only 4 lines and a single
statement. Your code is 8 lines, four statements, plus an extra local
variable. I don't see how this is an improvement.

Regards,
   Felix


>
>        (*mem)->bo =3D amdgpu_bo_ref(bo);
>        (*mem)->va =3D va;
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process.c b/drivers/gpu/drm/a=
md/amdkfd/kfd_process.c
> index 22abdbc6dfd7..1c7bfc842f06 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_process.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
> @@ -327,10 +327,10 @@ static int kfd_process_alloc_gpuvm(struct kfd_proce=
ss_device *pdd,
>   static int kfd_process_device_reserve_ib_mem(struct kfd_process_device =
*pdd)
>   {
>        struct qcm_process_device *qpd =3D &pdd->qpd;
> -     uint32_t flags =3D ALLOC_MEM_FLAGS_GTT |
> -                      ALLOC_MEM_FLAGS_NO_SUBSTITUTE |
> -                      ALLOC_MEM_FLAGS_WRITABLE |
> -                      ALLOC_MEM_FLAGS_EXECUTABLE;
> +     uint32_t flags =3D KFD_IOC_ALLOC_MEM_FLAGS_GTT |
> +                     KFD_IOC_ALLOC_MEM_FLAGS_NO_SUBSTITUTE |
> +                     KFD_IOC_ALLOC_MEM_FLAGS_WRITABLE |
> +                     KFD_IOC_ALLOC_MEM_FLAGS_EXECUTABLE;
>        void *kaddr;
>        int ret;
>
> @@ -692,8 +692,9 @@ static int kfd_process_device_init_cwsr_dgpu(struct k=
fd_process_device *pdd)
>   {
>        struct kfd_dev *dev =3D pdd->dev;
>        struct qcm_process_device *qpd =3D &pdd->qpd;
> -     uint32_t flags =3D ALLOC_MEM_FLAGS_GTT |
> -             ALLOC_MEM_FLAGS_NO_SUBSTITUTE | ALLOC_MEM_FLAGS_EXECUTABLE;
> +     uint32_t flags =3D KFD_IOC_ALLOC_MEM_FLAGS_GTT
> +                     | KFD_IOC_ALLOC_MEM_FLAGS_NO_SUBSTITUTE
> +                     | KFD_IOC_ALLOC_MEM_FLAGS_EXECUTABLE;
>        void *kaddr;
>        int ret;
>
> diff --git a/drivers/gpu/drm/amd/include/kgd_kfd_interface.h b/drivers/gp=
u/drm/amd/include/kgd_kfd_interface.h
> index 0cee79d56075..a3c238c39ef5 100644
> --- a/drivers/gpu/drm/amd/include/kgd_kfd_interface.h
> +++ b/drivers/gpu/drm/amd/include/kgd_kfd_interface.h
> @@ -167,27 +167,6 @@ struct tile_config {
>
>   #define KFD_MAX_NUM_OF_QUEUES_PER_DEVICE_DEFAULT 4096
>
> -/*
> - * Allocation flag domains
> - * NOTE: This must match the corresponding definitions in kfd_ioctl.h.
> - */
> -#define ALLOC_MEM_FLAGS_VRAM         (1 << 0)
> -#define ALLOC_MEM_FLAGS_GTT          (1 << 1)
> -#define ALLOC_MEM_FLAGS_USERPTR              (1 << 2)
> -#define ALLOC_MEM_FLAGS_DOORBELL     (1 << 3)
> -#define ALLOC_MEM_FLAGS_MMIO_REMAP   (1 << 4)
> -
> -/*
> - * Allocation flags attributes/access options.
> - * NOTE: This must match the corresponding definitions in kfd_ioctl.h.
> - */
> -#define ALLOC_MEM_FLAGS_WRITABLE     (1 << 31)
> -#define ALLOC_MEM_FLAGS_EXECUTABLE   (1 << 30)
> -#define ALLOC_MEM_FLAGS_PUBLIC               (1 << 29)
> -#define ALLOC_MEM_FLAGS_NO_SUBSTITUTE        (1 << 28) /* TODO */
> -#define ALLOC_MEM_FLAGS_AQL_QUEUE_MEM        (1 << 27)
> -#define ALLOC_MEM_FLAGS_COHERENT     (1 << 26) /* For GFXv9 or later */
> -
>   /**
>    * struct kfd2kgd_calls
>    *

--_000_CH2PR12MB3926C6062226E00D4626CC43F0E20CH2PR12MB3926namp_
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
<p style=3D"font-family:Arial;font-size:10pt;color:#0078D7;margin:15pt;" al=
ign=3D"Left">
[AMD Official Use Only - Internal Distribution Only]<br>
</p>
<br>
<div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
Okay, I will change back to its original format.&nbsp;</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
Yong</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
&nbsp;</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Kuehling, Felix &lt;F=
elix.Kuehling@amd.com&gt;<br>
<b>Sent:</b> Thursday, March 5, 2020 3:49 PM<br>
<b>To:</b> amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&=
gt;; Zhao, Yong &lt;Yong.Zhao@amd.com&gt;<br>
<b>Subject:</b> Re: [PATCH] drm/amdkfd: Consolidate duplicated bo alloc fla=
gs</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">On 2020-03-04 3:21 p.m., Yong Zhao wrote:<br>
&gt; ALLOC_MEM_FLAGS_* used are the same as the KFD_IOC_ALLOC_MEM_FLAGS_*,<=
br>
&gt; but they are interweavedly used in kernel driver, resulting in bad<br>
&gt; readability. For example, KFD_IOC_ALLOC_MEM_FLAGS_COHERENT is totally<=
br>
&gt; not referenced in kernel, and it functions in the kernel through<br>
&gt; ALLOC_MEM_FLAGS_COHERENT, causing unnecessary confusion.<br>
&gt;<br>
&gt; Replace all occurrences of ALLOC_MEM_FLAGS_* by<br>
&gt; KFD_IOC_ALLOC_MEM_FLAGS_* to solve the problem.<br>
&gt;<br>
&gt; Change-Id: Iced6ed3698167296c97b14e7e4569883859d619c<br>
&gt; Signed-off-by: Yong Zhao &lt;Yong.Zhao@amd.com&gt;<br>
&gt; ---<br>
&gt;&nbsp;&nbsp; drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c&nbsp;&nbsp;&nbs=
p; |&nbsp; 9 &#43;&#43;&#43;--<br>
&gt;&nbsp;&nbsp; .../gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c&nbsp; | 38 &#=
43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;--------<br>
&gt;&nbsp;&nbsp; drivers/gpu/drm/amd/amdkfd/kfd_process.c&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp; | 13 &#43;&#43;&#43;&#43;---<br>
&gt;&nbsp;&nbsp; .../gpu/drm/amd/include/kgd_kfd_interface.h&nbsp;&nbsp; | =
21 ----------<br>
&gt;&nbsp;&nbsp; 4 files changed, 36 insertions(&#43;), 45 deletions(-)<br>
&gt;<br>
&gt; diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c b/drivers/gpu/=
drm/amd/amdgpu/amdgpu_amdkfd.c<br>
&gt; index 726c91ab6761..affaa0d4b636 100644<br>
&gt; --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c<br>
&gt; &#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c<br>
&gt; @@ -29,6 &#43;29,7 @@<br>
&gt;&nbsp;&nbsp; #include &lt;linux/module.h&gt;<br>
&gt;&nbsp;&nbsp; #include &lt;linux/dma-buf.h&gt;<br>
&gt;&nbsp;&nbsp; #include &quot;amdgpu_xgmi.h&quot;<br>
&gt; &#43;#include &lt;uapi/linux/kfd_ioctl.h&gt;<br>
&gt;&nbsp;&nbsp; <br>
&gt;&nbsp;&nbsp; static const unsigned int compute_vmid_bitmap =3D 0xFF00;<=
br>
&gt;&nbsp;&nbsp; <br>
&gt; @@ -500,11 &#43;501,13 @@ int amdgpu_amdkfd_get_dmabuf_info(struct kgd=
_dev *kgd, int dma_buf_fd,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; r =3D amdgpu_bo_get_metadata(bo, metadata_buffer, buffe=
r_size,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; metadata_size, &amp;metadata_flags);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (flags) {<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; *flags =3D (bo-&gt;preferred_domains &amp; AMDGPU_GEM_DOMAIN_VRAM) ?<br=
>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ALLOC_MEM_FLAGS_VRAM : =
ALLOC_MEM_FLAGS_GTT;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; if (bo-&gt;preferred_domains &amp; AMDGPU_GEM_DOMAIN_VRAM)<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *flags =3D KFD_IOC_=
ALLOC_MEM_FLAGS_VRAM;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; else<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *flags =3D KFD_IOC_=
ALLOC_MEM_FLAGS_GTT;<br>
<br>
You're sneaking in some personal preference (changing the trinary (cond <br=
>
? a : b) operator to if-else) with the renaming change. Personally I <br>
find the trinary operator just as readable and more concise.<br>
<br>
<br>
&gt;&nbsp;&nbsp; <br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; if (bo-&gt;flags &amp; AMDGPU_GEM_CREATE_CPU_ACCESS_REQ=
UIRED)<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *flags |=3D ALLOC_MEM_F=
LAGS_PUBLIC;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *flags |=3D KFD_IOC=
_ALLOC_MEM_FLAGS_PUBLIC;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt;&nbsp;&nbsp; <br>
&gt;&nbsp;&nbsp; out_put:<br>
&gt; diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c b/driver=
s/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c<br>
&gt; index e4481caed648..c81fe7011e88 100644<br>
&gt; --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c<br>
&gt; &#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c<br>
&gt; @@ -29,6 &#43;29,7 @@<br>
&gt;&nbsp;&nbsp; #include &quot;amdgpu_vm.h&quot;<br>
&gt;&nbsp;&nbsp; #include &quot;amdgpu_amdkfd.h&quot;<br>
&gt;&nbsp;&nbsp; #include &quot;amdgpu_dma_buf.h&quot;<br>
&gt; &#43;#include &lt;uapi/linux/kfd_ioctl.h&gt;<br>
&gt;&nbsp;&nbsp; <br>
&gt;&nbsp;&nbsp; /* BO flag to indicate a KFD userptr BO */<br>
&gt;&nbsp;&nbsp; #define AMDGPU_AMDKFD_USERPTR_BO (1ULL &lt;&lt; 63)<br>
&gt; @@ -400,18 &#43;401,18 @@ static int vm_update_pds(struct amdgpu_vm *v=
m, struct amdgpu_sync *sync)<br>
&gt;&nbsp;&nbsp; static uint64_t get_pte_flags(struct amdgpu_device *adev, =
struct kgd_mem *mem)<br>
&gt;&nbsp;&nbsp; {<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_device *bo_ade=
v =3D amdgpu_ttm_adev(mem-&gt;bo-&gt;tbo.bdev);<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; bool coherent =3D mem-&gt;alloc_flags &amp; =
ALLOC_MEM_FLAGS_COHERENT;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; bool coherent =3D mem-&gt;alloc_flags &a=
mp; KFD_IOC_ALLOC_MEM_FLAGS_COHERENT;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t mapping_flags;<br>
&gt;&nbsp;&nbsp; <br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mapping_flags =3D AMDGPU_VM_=
PAGE_READABLE;<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; if (mem-&gt;alloc_flags &amp; ALLOC_MEM_FLAG=
S_WRITABLE)<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; if (mem-&gt;alloc_flags &amp; KFD_IOC_AL=
LOC_MEM_FLAGS_WRITABLE)<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; mapping_flags |=3D AMDGPU_VM_PAGE_WRITEABLE;<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; if (mem-&gt;alloc_flags &amp; ALLOC_MEM_FLAG=
S_EXECUTABLE)<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; if (mem-&gt;alloc_flags &amp; KFD_IOC_AL=
LOC_MEM_FLAGS_EXECUTABLE)<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; mapping_flags |=3D AMDGPU_VM_PAGE_EXECUTABLE;<br>
&gt;&nbsp;&nbsp; <br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; switch (adev-&gt;asic_type) =
{<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case CHIP_ARCTURUS:<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; if (mem-&gt;alloc_flags &amp; ALLOC_MEM_FLAGS_VRAM) {<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; if (mem-&gt;alloc_flags &amp; KFD_IOC_ALLOC_MEM_FLAGS_VRAM) {<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (bo_=
adev =3D=3D adev)<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mapping_flags |=3D coherent ?<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; AMDGPU_VM_MTYPE_CC : AMDGPU_VM_MTYPE_RW;<br>
&gt; @@ -1160,24 &#43;1161,24 @@ int amdgpu_amdkfd_gpuvm_alloc_memory_of_gp=
u(<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /*<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * Check on which domai=
n to allocate BO<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; */<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; if (flags &amp; ALLOC_MEM_FLAGS_VRAM) {<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; if (flags &amp; KFD_IOC_ALLOC_MEM_FLAGS_=
VRAM) {<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; domain =3D alloc_domain =3D AMDGPU_GEM_DOMAIN_VRAM;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; alloc_flags =3D AMDGPU_GEM_CREATE_VRAM_WIPE_ON_RELEASE;=
<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; alloc_flags |=3D (flags &amp; ALLOC_MEM_FLAGS_PUBLIC) ?<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; alloc_flags |=3D (flags &amp; KFD_IOC_ALLOC_MEM_FLAGS_PUBLIC) ?<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; AMDGPU_=
GEM_CREATE_CPU_ACCESS_REQUIRED :<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; AMDGPU_=
GEM_CREATE_NO_CPU_ACCESS;<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; } else if (flags &amp; ALLOC_MEM_FLAGS_GTT) =
{<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; } else if (flags &amp; KFD_IOC_ALLOC_MEM=
_FLAGS_GTT) {<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; domain =3D alloc_domain =3D AMDGPU_GEM_DOMAIN_GTT;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; alloc_flags =3D 0;<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; } else if (flags &amp; ALLOC_MEM_FLAGS_USERP=
TR) {<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; } else if (flags &amp; KFD_IOC_ALLOC_MEM=
_FLAGS_USERPTR) {<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; domain =3D AMDGPU_GEM_DOMAIN_GTT;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; alloc_domain =3D AMDGPU_GEM_DOMAIN_CPU;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; alloc_flags =3D 0;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; if (!offset || !*offset)<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return =
-EINVAL;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; user_addr =3D untagged_addr(*offset);<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; } else if (flags &amp; (ALLOC_MEM_FLAGS_DOOR=
BELL |<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ALLOC_MEM_FLAGS_MMIO_RE=
MAP)) {<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; } else if (flags &amp; (KFD_IOC_ALLOC_ME=
M_FLAGS_DOORBELL |<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; KFD_IOC_ALLOC_MEM_F=
LAGS_MMIO_REMAP)) {<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; domain =3D AMDGPU_GEM_DOMAIN_GTT;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; alloc_domain =3D AMDGPU_GEM_DOMAIN_CPU;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; bo_type =3D ttm_bo_type_sg;<br>
&gt; @@ -1198,7 &#43;1199,7 @@ int amdgpu_amdkfd_gpuvm_alloc_memory_of_gpu(=
<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; INIT_LIST_HEAD(&amp;(*mem)-&=
gt;bo_va_list);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mutex_init(&amp;(*mem)-&gt;l=
ock);<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; (*mem)-&gt;aql_queue =3D !!(flags &amp; ALLO=
C_MEM_FLAGS_AQL_QUEUE_MEM);<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; (*mem)-&gt;aql_queue =3D !!(flags &amp; =
KFD_IOC_ALLOC_MEM_FLAGS_AQL_QUEUE_MEM);<br>
&gt;&nbsp;&nbsp; <br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Workaround for AQL queue =
wraparound bug. Map the same<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * memory twice. That m=
eans we only actually allocate half<br>
&gt; @@ -1652,6 &#43;1653,7 @@ int amdgpu_amdkfd_gpuvm_import_dmabuf(struct=
 kgd_dev *kgd,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct drm_gem_object *obj;<=
br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_bo *bo;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_vm *avm =3D (s=
truct amdgpu_vm *)vm;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t flags;<br>
&gt;&nbsp;&nbsp; <br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (dma_buf-&gt;ops !=3D &am=
p;amdgpu_dmabuf_ops)<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; /* Can't handle non-graphics buffers */<br>
&gt; @@ -1680,10 &#43;1682,16 @@ int amdgpu_amdkfd_gpuvm_import_dmabuf(stru=
ct kgd_dev *kgd,<br>
&gt;&nbsp;&nbsp; <br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; INIT_LIST_HEAD(&amp;(*mem)-&=
gt;bo_va_list);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mutex_init(&amp;(*mem)-&gt;l=
ock);<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; (*mem)-&gt;alloc_flags =3D<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; ((bo-&gt;preferred_domains &amp; AMDGPU_GEM_DOMAIN_VRAM) ?<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp; ALLOC_MEM_FLAGS_VRAM : ALLOC_MEM_FLAGS_GTT) |<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; ALLOC_MEM_FLAGS_WRITABLE | ALLOC_MEM_FLAGS_EXECUTABLE;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; <br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; flags =3D KFD_IOC_ALLOC_MEM_FLAGS_WRITAB=
LE<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; | KFD_IOC_ALLOC_MEM_FLAGS_EXECUTABLE;<br>
&gt; &#43;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; if (bo-&gt;preferred_domains &amp; AMDGP=
U_GEM_DOMAIN_VRAM)<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; flags |=3D KFD_IOC_ALLOC_MEM_FLAGS_VRAM;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; else<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; flags |=3D KFD_IOC_ALLOC_MEM_FLAGS_GTT;<br>
&gt; &#43;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; (*mem)-&gt;alloc_flags =3D flags;<br>
<br>
Same as above. The original code was only 4 lines and a single <br>
statement. Your code is 8 lines, four statements, plus an extra local <br>
variable. I don't see how this is an improvement.<br>
<br>
Regards,<br>
&nbsp;&nbsp; Felix<br>
<br>
<br>
&gt;&nbsp;&nbsp; <br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (*mem)-&gt;bo =3D amdgpu_bo_=
ref(bo);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (*mem)-&gt;va =3D va;<br>
&gt; diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process.c b/drivers/gpu/dr=
m/amd/amdkfd/kfd_process.c<br>
&gt; index 22abdbc6dfd7..1c7bfc842f06 100644<br>
&gt; --- a/drivers/gpu/drm/amd/amdkfd/kfd_process.c<br>
&gt; &#43;&#43;&#43; b/drivers/gpu/drm/amd/amdkfd/kfd_process.c<br>
&gt; @@ -327,10 &#43;327,10 @@ static int kfd_process_alloc_gpuvm(struct kf=
d_process_device *pdd,<br>
&gt;&nbsp;&nbsp; static int kfd_process_device_reserve_ib_mem(struct kfd_pr=
ocess_device *pdd)<br>
&gt;&nbsp;&nbsp; {<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct qcm_process_device *q=
pd =3D &amp;pdd-&gt;qpd;<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; uint32_t flags =3D ALLOC_MEM_FLAGS_GTT |<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ALLOC_MEM_FLAGS_N=
O_SUBSTITUTE |<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ALLOC_MEM_FLAGS_W=
RITABLE |<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ALLOC_MEM_FLAGS_E=
XECUTABLE;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t flags =3D KFD_IOC_ALLOC_MEM_FLA=
GS_GTT |<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; KFD_IOC_ALLOC_MEM_F=
LAGS_NO_SUBSTITUTE |<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; KFD_IOC_ALLOC_MEM_F=
LAGS_WRITABLE |<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; KFD_IOC_ALLOC_MEM_F=
LAGS_EXECUTABLE;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; void *kaddr;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int ret;<br>
&gt;&nbsp;&nbsp; <br>
&gt; @@ -692,8 &#43;692,9 @@ static int kfd_process_device_init_cwsr_dgpu(s=
truct kfd_process_device *pdd)<br>
&gt;&nbsp;&nbsp; {<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct kfd_dev *dev =3D pdd-=
&gt;dev;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct qcm_process_device *q=
pd =3D &amp;pdd-&gt;qpd;<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; uint32_t flags =3D ALLOC_MEM_FLAGS_GTT |<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; ALLOC_MEM_FLAGS_NO_SUBSTITUTE | ALLOC_MEM_FLAGS_EXECUTABLE;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t flags =3D KFD_IOC_ALLOC_MEM_FLA=
GS_GTT<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; | KFD_IOC_ALLOC_MEM=
_FLAGS_NO_SUBSTITUTE<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; | KFD_IOC_ALLOC_MEM=
_FLAGS_EXECUTABLE;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; void *kaddr;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int ret;<br>
&gt;&nbsp;&nbsp; <br>
&gt; diff --git a/drivers/gpu/drm/amd/include/kgd_kfd_interface.h b/drivers=
/gpu/drm/amd/include/kgd_kfd_interface.h<br>
&gt; index 0cee79d56075..a3c238c39ef5 100644<br>
&gt; --- a/drivers/gpu/drm/amd/include/kgd_kfd_interface.h<br>
&gt; &#43;&#43;&#43; b/drivers/gpu/drm/amd/include/kgd_kfd_interface.h<br>
&gt; @@ -167,27 &#43;167,6 @@ struct tile_config {<br>
&gt;&nbsp;&nbsp; <br>
&gt;&nbsp;&nbsp; #define KFD_MAX_NUM_OF_QUEUES_PER_DEVICE_DEFAULT 4096<br>
&gt;&nbsp;&nbsp; <br>
&gt; -/*<br>
&gt; - * Allocation flag domains<br>
&gt; - * NOTE: This must match the corresponding definitions in kfd_ioctl.h=
.<br>
&gt; - */<br>
&gt; -#define ALLOC_MEM_FLAGS_VRAM&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; (1 &lt;&lt; 0)<br>
&gt; -#define ALLOC_MEM_FLAGS_GTT&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp; (1 &lt;&lt; 1)<br>
&gt; -#define ALLOC_MEM_FLAGS_USERPTR&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (1 &lt;&lt; 2)<br>
&gt; -#define ALLOC_MEM_FLAGS_DOORBELL&nbsp;&nbsp;&nbsp;&nbsp; (1 &lt;&lt; =
3)<br>
&gt; -#define ALLOC_MEM_FLAGS_MMIO_REMAP&nbsp;&nbsp; (1 &lt;&lt; 4)<br>
&gt; -<br>
&gt; -/*<br>
&gt; - * Allocation flags attributes/access options.<br>
&gt; - * NOTE: This must match the corresponding definitions in kfd_ioctl.h=
.<br>
&gt; - */<br>
&gt; -#define ALLOC_MEM_FLAGS_WRITABLE&nbsp;&nbsp;&nbsp;&nbsp; (1 &lt;&lt; =
31)<br>
&gt; -#define ALLOC_MEM_FLAGS_EXECUTABLE&nbsp;&nbsp; (1 &lt;&lt; 30)<br>
&gt; -#define ALLOC_MEM_FLAGS_PUBLIC&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (1 &lt;&lt; 29)<br>
&gt; -#define ALLOC_MEM_FLAGS_NO_SUBSTITUTE&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; (1 &lt;&lt; 28) /* TODO */<br>
&gt; -#define ALLOC_MEM_FLAGS_AQL_QUEUE_MEM&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; (1 &lt;&lt; 27)<br>
&gt; -#define ALLOC_MEM_FLAGS_COHERENT&nbsp;&nbsp;&nbsp;&nbsp; (1 &lt;&lt; =
26) /* For GFXv9 or later */<br>
&gt; -<br>
&gt;&nbsp;&nbsp; /**<br>
&gt;&nbsp;&nbsp;&nbsp; * struct kfd2kgd_calls<br>
&gt;&nbsp;&nbsp;&nbsp; *<br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_CH2PR12MB3926C6062226E00D4626CC43F0E20CH2PR12MB3926namp_--

--===============0937963505==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============0937963505==--
