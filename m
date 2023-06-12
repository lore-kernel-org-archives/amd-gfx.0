Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30904C7EE25
	for <amd-gfx@archiver.kernel.org>; Mon, 12 Jun 2023 06:52:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 39F2810E19E;
	Mon, 12 Jun 2023 06:52:50 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on20608.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7eaa::608])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 768F610E19E
 for <amd-gfx@lists.freedesktop.org>; Mon, 12 Jun 2023 06:52:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lUXfgl2pM7OUFbS74ucESkNM3fqwN5Bf2Od9W3YJNExMeG9FZ4n3tDE+N0cMcbbmf2Ma1GZEQApxuFFdz8YlkS6C/cwQuYvZMIteaEDy5WBQhPJl5xnbJtRegf4NxVww/62iJsh9OpQ4Sleo+AoejT38kRAVN6CY+QrblU03ElG08ZTix36R+H9YPwS73jNGrMWvQJFzHHZzOKxBLyDr3cPF7vRFJi51Ba2tx6f1KOn9LOWgUNEAt5wxHGciEESYxKrhVPYHaygH5wYZQnUfLYduBGkxBUyaBqf8ts7TubBncpA2WsvMmWXYne5sbAfaIe+Y4Te7HkgdxWEm/OzN7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/tOoTsvpGR2quNZe1glZ9NBRr7Xe7rJRN/Q6U+eRXD0=;
 b=mIeNqOvuNWogcwY6aIaSO5xmMZIjt9OedP5SrSFYCyYN0oGiVFCAs0G4c1TabXG8rJnnru8czI+uJtG3hBDn8uncuJ2jqEyX8Xdj0r0TzLVgT+FQHpKRF1f711Y2kGMzT6K7L/xTJBUXR9Me2SF0KTivKAKQ6c3AxKMB2j9i3wX+1XgQ5onE7bEEgi7wp0kFvm211lAACVbvGS88ioiNkrLz0M4v/6seiEE72JCMbH92D9l6vAifhOsf53bnRsqen9I7OJb5IfTEeYjElOifGWP2MI2qktIoevp8iDca+QKpXjt8cW8WHSS0XbMR5HX0BqLwiy9fL0iZMcXScEistA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/tOoTsvpGR2quNZe1glZ9NBRr7Xe7rJRN/Q6U+eRXD0=;
 b=1eNMu+Ty/GnS2UfY3VgwUxT5FuyzzPnqsGVzFx79sadB4KAwYHQYil88r6y2SsmRakFhdWCJ2C60k5uP7WipufMSdbKQ4Gw2Gf/rdXDuwwqkfFZdZYo+OkYWetZQHuUAwWeG4jOjri1HQOK05+HK8KLfwIA0eCzFB3cXWOffZZo=
Received: from DM5PR12MB2469.namprd12.prod.outlook.com (2603:10b6:4:af::38) by
 LV2PR12MB5917.namprd12.prod.outlook.com (2603:10b6:408:175::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6477.29; Mon, 12 Jun
 2023 06:52:45 +0000
Received: from DM5PR12MB2469.namprd12.prod.outlook.com
 ([fe80::6d3a:17b5:6546:e9b4]) by DM5PR12MB2469.namprd12.prod.outlook.com
 ([fe80::6d3a:17b5:6546:e9b4%4]) with mapi id 15.20.6455.043; Mon, 12 Jun 2023
 06:52:45 +0000
From: "Chen, Guchun" <Guchun.Chen@amd.com>
To: "Sharma, Shashank" <Shashank.Sharma@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [RFC] drm/amdgpu: flush gpu tlb using sdma ring
Thread-Topic: [RFC] drm/amdgpu: flush gpu tlb using sdma ring
Thread-Index: AQHZmrmj2SIXVX9kI0W+lclrCHO4jK+GvwnA
Date: Mon, 12 Jun 2023 06:52:44 +0000
Message-ID: <DM5PR12MB2469B9F1325438F0C91F8DCCF154A@DM5PR12MB2469.namprd12.prod.outlook.com>
References: <20230609100257.900-1-shashank.sharma@amd.com>
In-Reply-To: <20230609100257.900-1-shashank.sharma@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ActionId=9e849185-4a91-4016-999e-dd3dd2041675;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=true;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public-AIP
 2.0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2023-06-12T06:51:04Z;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM5PR12MB2469:EE_|LV2PR12MB5917:EE_
x-ms-office365-filtering-correlation-id: 4044f1b5-5ff4-475e-bb01-08db6b11a02f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 7ae25Vg7TcJyeTswRMkHSeJ1Z46pxP7SoiTPsXKH6gJxn8bBXVWX/pznXgjkPP7YoGeV9p/R2DbkuTFwre259InP1PNU+FM3NA0vuTDwdzkBSVvj2Ub0H3CGFoShUcx748YuAKklt3VUG1KFREg0xvMXhQq95lZG0WD3fgcjvLG6UdC+mFQu5lZfbpPLPFwgWVM1o2437eFc+/+sG0+jYQPTtKv/AjXo9viokhZv/MEbE+zXECbsUWk/pxdVAyeqPVsabfvXyQTu06CEnIMPoJdn2ilhYFMMEkQtneCMYghdv8PpxKFsDqPWK5PEua/MdQh+NNIpreEKIfWw75dTySh3Ny18jQ0UnEjM3rfdIsNUa3F7CorS3++TifZp2EvaEMkZYHpwVYXoR61lZFVi9g2JjlcSZAYbeBfURdUWkI9NH13v/crgstKaH0bJ780sW+DNdkWqKH9IUEsg/ZLMGWhlF+Zv9Dg8dM2nPWiD2MgiYn0AD3amxBifeEt0jx+UnyFIS6fFy0K/imvB9Wfk/SJWNXVd7hq683gUC42sXud9N8wmG6z3VyxIT9dmklSiEyIUGLFLNLlkc2JJXNp+2laaxaGmuz2gGIO331Xe+TEzUWzkf12BsOEvnRThbsne
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB2469.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(136003)(346002)(366004)(396003)(39860400002)(376002)(451199021)(316002)(7696005)(41300700001)(83380400001)(86362001)(9686003)(6506007)(53546011)(38070700005)(186003)(26005)(33656002)(2906002)(122000001)(38100700002)(55016003)(5660300002)(52536014)(8936002)(8676002)(64756008)(66946007)(66556008)(76116006)(66446008)(54906003)(110136005)(71200400001)(478600001)(66476007)(4326008);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?ZoTATpjzzR9PcRjDE6xpAo5tcvZ2u3VLayyvb8xwcJNYKwHKcjVQ1llMG9um?=
 =?us-ascii?Q?7eLeM12aS5fsbgy/3Kd3xbx/rS8dAR4H9eXJlC0yeNpkXwgJI8ja4K5xqmAM?=
 =?us-ascii?Q?n2tdp6no+pOUkvo1LRjPUdbXc9T7uIFdtsPvLi1JA2hATVohbpku3au6+NT7?=
 =?us-ascii?Q?6BJAuiUqXkQFTPflxolqtES8XLFCpGKsoJfCu62Y1UX5WZDbokVxUxTQjpFn?=
 =?us-ascii?Q?+RRkHLgWib9MqEfk/e6Z8TbfHeICgo80qNOMuGIrhB6uHFF80L2BUUTcL3+A?=
 =?us-ascii?Q?mmaQgXQnEbeol9cdGqv2ZcSV0ougoewWfgwuUSatzyorm6cgtIDp8mfN9Eku?=
 =?us-ascii?Q?YahFyUeX/+SNippzIzXvbHuA2sA/FdqL9XFKCG0bJKv1tHfPU5eOdLwXoU9D?=
 =?us-ascii?Q?RSdHxDTH27Q2gUNfWNbUcJUMpNLhA2kHCSj5XQU6LmjH41Z/AOXnwrbT+oHl?=
 =?us-ascii?Q?xPrCJkGoYfUoyVD22IYiQt/Mx9XVrq1JDA1/En4oULnmDRFasI9igZJ1k6vA?=
 =?us-ascii?Q?SFlXehIR2c4COZEJBIpyi7Avnl4dXKdYodEGKN676oxUDynU0G4fkYcWKjKC?=
 =?us-ascii?Q?OUGkXH6txwvn/dUwQrqS4AgTkX8o1AF/gc8SqIyFl6a+SmTOxDFwqj6PBtZP?=
 =?us-ascii?Q?sutS3vxKqQlQrlGO/kV3bqsF0isea0PaoTvPlCGfyO8J5AtquuxAOi7qxQOg?=
 =?us-ascii?Q?XpKVNG5f1WHY+ZDFPBIALTJjAKkoyefMpKfyhKuHp3a/DRHxroY/yJK/rGIK?=
 =?us-ascii?Q?n2dDCALbLrvTf/2r470EtCAfXA3tq/lXWoQZkTQ5VXeMj+UpbMtV4RbcQcUL?=
 =?us-ascii?Q?4SSWEqmHl41JjVZi9KMQ6JgF/3RKPtymDH2MP1eHCPnLIV5PeRNNGSa2QT7h?=
 =?us-ascii?Q?5da+x6vby3H5zELLY+Dx4bRebx/vvjUs28Xzty5k/nNgnrnaXVhcQOAXskju?=
 =?us-ascii?Q?2KsBPhFi2Y2Y/bDlsMHnSTruC9LL9SVDVomcsOI9ET443jWXuvvB467ccvA4?=
 =?us-ascii?Q?dv+hlWU47/AbtuAzotvrJQ8OJPfMn6+mwcJe6DX2Bklm9wcxDv2UNkCk7vO+?=
 =?us-ascii?Q?RZdbBUkKUAAG596ZUe7trwTnJh81496+5tn3fHoVkD3jIqdlLcuGLtC20PpV?=
 =?us-ascii?Q?Ju+TZwG5Ixo2hefmwjHM80k5Y46SFMxnHYXSsDTRpIYssUSqq0H+BZd9HRpL?=
 =?us-ascii?Q?strOzdJA24bkZQNz5Ai/VUQOYFOhEs1DoCNsDjwKeuWEtGoS8KIOS6Ds1iwQ?=
 =?us-ascii?Q?Cz4/cVAQO/djuLPxCMiTpwEvLgpJ58JvKwu1vUD55KPRNGo08rh9AUyiTUEs?=
 =?us-ascii?Q?9f6ZPpvyp1NCKN4t5mt+cjKL8b67g4Ez478er6tk0ur2+H59EsNzEvXF00wj?=
 =?us-ascii?Q?W3ctRxcjsqGCPYKMDgrAlplMHxfvTqrKCL9/Zdnr42RiP6SqR46Qfj301TmT?=
 =?us-ascii?Q?ILSnJYJDoQztO2TEFtO9tFfY2+lxmkSjBWREnDeLHSUHozL3OOWzRe7bWajx?=
 =?us-ascii?Q?h3xECmkHxfXkRnKiO8hBUb+ou3j3ssA3L/im/VWtmWuydu6KYJSJPYEqRHOs?=
 =?us-ascii?Q?74SsktvZMK4eHBB1Wbk=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB2469.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4044f1b5-5ff4-475e-bb01-08db6b11a02f
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Jun 2023 06:52:44.8776 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: TJFscdhw+K33O/yxseUHsYuduunJsFb2AHfQyoVX+M/IaimiMTJ4VkV0Hdz0w3jsPAzWJgDsspb1EWP5X6eOMA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5917
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
Cc: "Kuehling, Felix" <Felix.Kuehling@amd.com>, "Somalapuram,
 Amaranath" <Amaranath.Somalapuram@amd.com>, "Koenig,
 Christian" <Christian.Koenig@amd.com>, "Sharma,
 Shashank" <Shashank.Sharma@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[Public]

> -----Original Message-----
> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of
> Shashank Sharma
> Sent: Friday, June 9, 2023 6:03 PM
> To: amd-gfx@lists.freedesktop.org
> Cc: Kuehling, Felix <Felix.Kuehling@amd.com>; Somalapuram, Amaranath
> <Amaranath.Somalapuram@amd.com>; Koenig, Christian
> <Christian.Koenig@amd.com>; Sharma, Shashank
> <Shashank.Sharma@amd.com>
> Subject: [RFC] drm/amdgpu: flush gpu tlb using sdma ring
>
> This RFC patch moves the code to flush TLB using SDMA ring to a different
> place like a separate function. The idea is that KFD/KGD code should be a=
ble
> to flush GPU TLB using SDMA if they want to.
>
> Cc: Christian Koenig <christian.koenig@amd.com>
> Signed-off-by: Shashank Sharma <shashank.sharma@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c | 41
> ++++++++++++++++++++++++
> drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h |  1 +
>  drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c   | 36 +++++----------------
>  3 files changed, 50 insertions(+), 28 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c
> index 231ca06bc9c7..20a5dad32bfc 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c
> @@ -30,6 +30,47 @@
>  /* SDMA CSA reside in the 3rd page of CSA */  #define
> AMDGPU_CSA_SDMA_OFFSET (4096 * 2)
>
> +/**
> + * amdgpu_sdma_flush_tlb - flush gpu TLB using SDMA ring
> + *
> + * @adev: amdgpu device pointer
> + *
> + * return: returns dma fence which must be put by caller
> + *
> + * The SDMA on Navi has a bug which can theoretically result in memory
> + * corruption if an invalidation happens at the same time as an VA
> + * translation. Avoid this by doing the invalidation from the SDMA
> + * itself.
> + */
> +struct dma_fence *amdgpu_sdma_flush_tlb(struct amdgpu_device *adev) {
> +     int r;
> +     struct dma_fence *fence;
> +     struct amdgpu_job *job;
> +     struct amdgpu_ring *ring =3D adev->mman.buffer_funcs_ring;
> +
> +     mutex_lock(&adev->mman.gtt_window_lock);
> +     r =3D amdgpu_job_alloc_with_ib(ring->adev, &adev->mman.entity,

I guess this patch needs to be reworked on top of recent entity rename to h=
igh_pr code.

Regards,
Guchun

> +                                  AMDGPU_FENCE_OWNER_UNDEFINED,
> +                                  16 * 4, AMDGPU_IB_POOL_IMMEDIATE,
> +                                  &job);
> +     if (r)
> +             goto error_alloc;
> +
> +     job->vm_pd_addr =3D amdgpu_gmc_pd_addr(adev->gart.bo);
> +     job->vm_needs_flush =3D true;
> +     job->ibs->ptr[job->ibs->length_dw++] =3D ring->funcs->nop;
> +     amdgpu_ring_pad_ib(ring, &job->ibs[0]);
> +     fence =3D amdgpu_job_submit(job);
> +
> +     mutex_unlock(&adev->mman.gtt_window_lock);
> +     return fence;
> +
> +error_alloc:
> +     mutex_unlock(&adev->mman.gtt_window_lock);
> +     return NULL;
> +}
> +
>  /*
>   * GPU SDMA IP block helpers function.
>   */
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h
> index fc8528812598..c895948f6e82 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h
> @@ -130,5 +130,6 @@ void amdgpu_sdma_destroy_inst_ctx(struct
> amdgpu_device *adev,
>          bool duplicate);
>  void amdgpu_sdma_unset_buffer_funcs_helper(struct amdgpu_device
> *adev);  int amdgpu_sdma_ras_sw_init(struct amdgpu_device *adev);
> +struct dma_fence *amdgpu_sdma_flush_tlb(struct amdgpu_device *adev);
>
>  #endif
> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
> b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
> index ab2556ca984e..0bfaee00a838 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
> @@ -52,6 +52,7 @@
>  #include "athub_v2_1.h"
>
>  #include "amdgpu_reset.h"
> +#include "amdgpu_sdma.h"
>
>  #if 0
>  static const struct soc15_reg_golden golden_settings_navi10_hdp[] =3D @@=
 -
> 333,9 +334,6 @@ static void gmc_v10_0_flush_gpu_tlb(struct
> amdgpu_device *adev, uint32_t vmid,  {
>       struct amdgpu_ring *ring =3D adev->mman.buffer_funcs_ring;
>       struct dma_fence *fence;
> -     struct amdgpu_job *job;
> -
> -     int r;
>
>       /* flush hdp cache */
>       adev->hdp.funcs->flush_hdp(adev, NULL); @@ -378,34 +376,16 @@
> static void gmc_v10_0_flush_gpu_tlb(struct amdgpu_device *adev, uint32_t
> vmid,
>               return;
>       }
>
> -     /* The SDMA on Navi has a bug which can theoretically result in
> memory
> -      * corruption if an invalidation happens at the same time as an VA
> -      * translation. Avoid this by doing the invalidation from the SDMA
> -      * itself.
> -      */
> -     r =3D amdgpu_job_alloc_with_ib(ring->adev, &adev->mman.entity,
> -                                  AMDGPU_FENCE_OWNER_UNDEFINED,
> -                                  16 * 4, AMDGPU_IB_POOL_IMMEDIATE,
> -                                  &job);
> -     if (r)
> -             goto error_alloc;
> -
> -     job->vm_pd_addr =3D amdgpu_gmc_pd_addr(adev->gart.bo);
> -     job->vm_needs_flush =3D true;
> -     job->ibs->ptr[job->ibs->length_dw++] =3D ring->funcs->nop;
> -     amdgpu_ring_pad_ib(ring, &job->ibs[0]);
> -     fence =3D amdgpu_job_submit(job);
> -
>       mutex_unlock(&adev->mman.gtt_window_lock);
>
> -     dma_fence_wait(fence, false);
> -     dma_fence_put(fence);
> -
> -     return;
> +     fence =3D amdgpu_sdma_flush_tlb(adev);
> +     if (fence) {
> +             dma_fence_wait(fence, false);
> +             dma_fence_put(fence);
> +             return;
> +     }
>
> -error_alloc:
> -     mutex_unlock(&adev->mman.gtt_window_lock);
> -     DRM_ERROR("Error flushing GPU TLB using the SDMA (%d)!\n", r);
> +     DRM_ERROR("Error flushing GPU TLB using the SDMA !\n");
>  }
>
>  /**
> --
> 2.40.1

