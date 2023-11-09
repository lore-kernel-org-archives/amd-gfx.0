Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DBCDAC4332F
	for <amd-gfx@archiver.kernel.org>; Thu,  9 Nov 2023 21:49:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2B58610E925;
	Thu,  9 Nov 2023 21:49:32 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2078.outbound.protection.outlook.com [40.107.93.78])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7F6CB10E925
 for <amd-gfx@lists.freedesktop.org>; Thu,  9 Nov 2023 21:49:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dMgFosF38ga7ce6WuSfqVWv1tQtZKIiM60HCGA5zgrYQ9SMONNhRC9fIneL+8L6Xub4edFzc0mZlnETgsmr/s1bXybaDrymmo6jYfHU+GV7Fji0A+BbNjcA2z0kYHJG0EIZDe5nB14RkLNEBLXdlLQIdmEM8MFV9Lvn6vgXxun0EZ1eyfBePDyK6uLMoUKqsOZB5OfJy+NcqS7PaGj16eDaMqyyX7DIkYDGbOL35WHpjuDBKiGxuqvG72c9u4nz7S1U0KmS8PODO1Hryd2rDReyKlb+KU4GNhJAGdWxy9XksLI4c884UmtbIGy2PFbxretsYLEyluqqPgtH9/nc+qg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jhWp8eWOpu6IdexeIZFySLZv4eDLtYD5FYyPc4aDE5A=;
 b=W7HMwNP2wkeJrnwgoE2W1QXGVy/OCUlx69AbgI1FXG9kI+bfKgnZ5D84hIPkWKo4A1r7e/UMy5MeWrUV2c9SAdYpBWVWDXONwUmSC6qnAo19DbggTVyGJce/pauYVa05+R2hb9m6PRU3H/9n3jAjgWqTHt+b8eMAmjLpJyEDSeeaiCWygMEq4/jN3JUnKfZutp2PnLCkOIhchsHnYoaiaTWBWHsod5MkUdQF2jZAUTaeOktPsi8pjxwpYZJ7sqHtTKaYt1Ah2YiJD4cublZKwwRuNRDhkBd6FlQw1fL3kl4zxt/3uOF3w41/7HERkr1kWOe0uxQ2z7p/L+rwBRPKDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jhWp8eWOpu6IdexeIZFySLZv4eDLtYD5FYyPc4aDE5A=;
 b=hzpeL/mDt8cbsl3mHJ5ysHpUbDIv4W3YILuPj0HMxCM73FNKZzLjF39afvXj/55odUfHgmiqIvr7DFVc+Y052jtqP7ZxG1TN9I0m1F/+LGhb49458M/2l1eY5mQCfzdIt1udPnbHk7WSQ0/26dXeBx8/Wl9RjEWwd4JpMVq2B+Q=
Received: from BL1PR12MB5144.namprd12.prod.outlook.com (2603:10b6:208:316::6)
 by CH0PR12MB5187.namprd12.prod.outlook.com (2603:10b6:610:ba::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.28; Thu, 9 Nov
 2023 21:49:26 +0000
Received: from BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::f081:16c7:9129:c010]) by BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::f081:16c7:9129:c010%3]) with mapi id 15.20.6954.029; Thu, 9 Nov 2023
 21:49:26 +0000
From: "Deucher, Alexander" <Alexander.Deucher@amd.com>
To: "Liang, Prike" <Prike.Liang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 2/2] drm/amdgpu: add amdgpu runpm usage trace for separate
 funcs
Thread-Topic: [PATCH 2/2] drm/amdgpu: add amdgpu runpm usage trace for
 separate funcs
Thread-Index: AQHaEt+Wyixu2wkwrE+TLoU6a76HebByhs2g
Date: Thu, 9 Nov 2023 21:49:25 +0000
Message-ID: <BL1PR12MB514499B78DF69E6AE4371CC3F7AFA@BL1PR12MB5144.namprd12.prod.outlook.com>
References: <20231109073701.1751965-1-Prike.Liang@amd.com>
 <20231109073701.1751965-2-Prike.Liang@amd.com>
In-Reply-To: <20231109073701.1751965-2-Prike.Liang@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ActionId=50d2075b-33e7-444b-a125-5bb4fa4efee0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=true;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public-AIP
 2.0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2023-11-09T21:47:08Z;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR12MB5144:EE_|CH0PR12MB5187:EE_
x-ms-office365-filtering-correlation-id: 4908baa1-0599-4de2-558d-08dbe16dbe19
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: H1CcuR91Qpg/AjTLKZYSxPYWLtfF6QGKrhPSCYd/9nLLEKRfAw14sHHOn9tm9iWhqKPB3/mrRVwykgjLbZuJzwbSGYdIq4ll63muLRp7ZPx3E3rNHzUL+3rZkPlBwUxuc1j2I2HqHPPYoQOXiWwlbNuMroYQRWtYdwFMk4BkDh9dNOFgVYWThHX8+sQ0kdZfAl2mHO4HqKycbtiWzak+YUHAWT/oCWIuAr5E82Vej9DWQ6DzOrwEKQhfn3WviilZ/A0nWbHeVRdR4gBvvZevZ3+TyGpba3ohCV9Z8NOV9Cx7x7qdDUd9Gy6sZ8BztzTAPZCwO9yj9FmiCkBbBQFIS09z51uGh4fI1PzS9fhgHOt60H6LAG16qOozZnIa7l8mI04nLsZwxeLzJzS7xDi3is8UkOS5xn7EomRmYYjlj7PMCq53l2b+OA3098mOq3WxPevkrhSoNuYYbWZXdUF2SH1iKYotl5HJVWcU6vzaNiNBk6nM0iDboM1EDlagz5VW9Z1yQKCXGXmrikrzMAkGDfaBpP1vmDRwjoj90oTBR+l1f0ah0d2TIV2vxQUKQzvY75lzLFOc7f8ncud1iCqzrM6gOeuK+/82bjDRstJUcFy4gTTu8GhWXLc1s2VxrGFa
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5144.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(136003)(39860400002)(396003)(346002)(376002)(366004)(230922051799003)(1800799009)(451199024)(64100799003)(186009)(5660300002)(2906002)(86362001)(76116006)(316002)(66476007)(66446008)(64756008)(8676002)(66946007)(110136005)(52536014)(38070700009)(41300700001)(8936002)(33656002)(66556008)(6506007)(9686003)(26005)(55016003)(83380400001)(71200400001)(122000001)(7696005)(53546011)(38100700002)(478600001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?z1ByE2aAi4QDOZDNKwkFt0yS3VEOVHibD/JoK5j34IeBVdb9XCMcHyzSuP9B?=
 =?us-ascii?Q?kZx6mVvvk5KZSYoEHtCEWXebDCE80sFYOyysFTikJq9RGLe32g0EhyOIDjiw?=
 =?us-ascii?Q?Dmw2+5QG2XjThCPft4yBCJ6tP+gl36JsndTGIw8JDplMmCC8LX2EpL57Qa3r?=
 =?us-ascii?Q?XMVl6AStVLkHMqLiqfe1n+G3DkMzdYLaThy1/1yiyTcbBctf30bGLVeYdFqH?=
 =?us-ascii?Q?0bH1Zmiz8YOoREuQm1cF36LB3GWARfCDt2qk4AKRCkCQev/NuC0sY/O8+Kfd?=
 =?us-ascii?Q?t1MibAAYpL3hqBTcCRYju5M4SiR7guJ8F3/exnonGs46/+32iv6mrVrirWXK?=
 =?us-ascii?Q?5nrfUKMjYmCYwB18Oux1H42cEd85cCtY2YUDLjEKSiffz8rLx7EVRsAS1SK7?=
 =?us-ascii?Q?AyFuYIg/QcQw4rFUip5eG6SEwaVZoLCXEOLRh99I2TjnTaI7AmLmJoNM9TKD?=
 =?us-ascii?Q?nHH0yQ+izq6qI+zMONTXYQR8Rr2CcDV6Pb4n6IAZYpMcVu7SlWYezDqaLVI7?=
 =?us-ascii?Q?xqlpmTsAjD+qIwPKTLpmLY7K8cjKJFeGxZbwbtZLVxztbBZZU+gKs4Ab8Lee?=
 =?us-ascii?Q?4Qrnu3USp9J54dIUBSDthZHMXBDX5MCxILA0a92s1VfL1p4AG83TABTFT/sP?=
 =?us-ascii?Q?lFLIEirnvlbmlAlbZ9uF4o2+gYcmABKSWxuuwqBe/RBbgPJEyMxEZ/1IjS3n?=
 =?us-ascii?Q?6ZIegVyqLaWTSEVITqayxP2zWC7UwyRt88xDGi+4NdBsOxqlxOcyoqP/7dK2?=
 =?us-ascii?Q?9NBm9xCUCfRvTNHciApwjiuRmPeJ8N/9ouE/ypEh3ss9fpywkugHpAQhDOW5?=
 =?us-ascii?Q?gifzb1XBZ1A8kWC2SamAi5u01HZidBiud2h+6Xji9gtkn6AEf5PKzBxUT8iK?=
 =?us-ascii?Q?R8r4vZbQLGininyvwOkPPxVPDSFg2fRor77nRLw5/BjK52gwCEvNoqeYO5wX?=
 =?us-ascii?Q?WiOnrK42G1X/qI13rpWNRheDxgsnttwiuusr/MaujbzjWecdCpwqBzZyzrSE?=
 =?us-ascii?Q?a8PiEWAoIQuRR0hmjYo9zbvStNWdgb3oG/ebXB4BoiqFdgdQZc3gmv+lISap?=
 =?us-ascii?Q?llQDq/XFA91fFd7klejUe1wQTY6/+Or+bWO/qVMQX0K1HlJLePwrvSpKKjY2?=
 =?us-ascii?Q?oyFAcAfmouwRngCKuphenz+9tb5aVF8lz0uJ13LtUCoPbh6jYDRtxqSfeiyk?=
 =?us-ascii?Q?/3AbtYjPVZkmYZ5rAONasIUaOxeMtDHxft06YDB6roJht1Rz48ZTp80j+uGC?=
 =?us-ascii?Q?Gv136/0h4QobQ/QQFfgco6ewFS81R5Iooj7fl2M/U8wQWgEc0nk/ZGuf2uZG?=
 =?us-ascii?Q?DU3v3ukmVxCQ8FSRDP5EyzI+HW03ZE4luWg7uiUYRx6C/f/eYi/rrwFmEgTS?=
 =?us-ascii?Q?4BQPf6m3WkZfTvE82htE7pIUmgKcGFMwfRcSQ7hs8snUVRf5junVdmG33gcS?=
 =?us-ascii?Q?yAPUV06CJZhGswydmv7cdwcM2D4ZpI7Ugcw8UDqxJYhidMzoAhM3eMYnurpB?=
 =?us-ascii?Q?6yYsMq2RJGQQ5RAIMS5Vm/M5WnoKxXj2GLiz5hWMmc0M7sWdCZIKEM2sJWEV?=
 =?us-ascii?Q?q1Ez8Xg0tP6JQbUSmRc=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5144.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4908baa1-0599-4de2-558d-08dbe16dbe19
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Nov 2023 21:49:26.0025 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1/xmTGZkw4NuBqHACfzW0OmhOB5arXR5rYxAzG7xrMIWywCbM2KzR1/CgMz22fD7YjWxUFKW2s1Rtlczvg65Fg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5187
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

[Public]

> -----Original Message-----
> From: Liang, Prike <Prike.Liang@amd.com>
> Sent: Thursday, November 9, 2023 2:37 AM
> To: amd-gfx@lists.freedesktop.org
> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Liang, Prike
> <Prike.Liang@amd.com>
> Subject: [PATCH 2/2] drm/amdgpu: add amdgpu runpm usage trace for
> separate funcs
>
> Add trace for amdgpu runpm separate funcs usage and this will help
> debugging on the case of runpm usage missed to dereference.
> In the normal case the runpm usage count referred by one kind of
> functionality pairwise and usage should be changed from 1 to 0, otherwise
> there will be an issue in the amdgpu runpm usage dereference.
>
> Signed-off-by: Prike Liang <Prike.Liang@amd.com>

Looks good.  Not sure if you want to add tracepoints to the other call site=
s as well.  These are probably the trickiest however.

Acked-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c |  4 ++++
>  drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c   |  7 ++++++-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_trace.h   | 15 +++++++++++++++
>  3 files changed, 25 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c
> index e7e87a3b2601..decbbe3d4f06 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c
> @@ -42,6 +42,7 @@
>  #include <linux/dma-fence-array.h>
>  #include <linux/pci-p2pdma.h>
>  #include <linux/pm_runtime.h>
> +#include "amdgpu_trace.h"
>
>  /**
>   * amdgpu_dma_buf_attach - &dma_buf_ops.attach implementation @@ -
> 63,6 +64,7 @@ static int amdgpu_dma_buf_attach(struct dma_buf *dmabuf,
>               attach->peer2peer =3D false;
>
>       r =3D pm_runtime_get_sync(adev_to_drm(adev)->dev);
> +     trace_amdgpu_runpm_reference_dumps(1, __func__);
>       if (r < 0)
>               goto out;
>
> @@ -70,6 +72,7 @@ static int amdgpu_dma_buf_attach(struct dma_buf
> *dmabuf,
>
>  out:
>       pm_runtime_put_autosuspend(adev_to_drm(adev)->dev);
> +     trace_amdgpu_runpm_reference_dumps(0, __func__);
>       return r;
>  }
>
> @@ -90,6 +93,7 @@ static void amdgpu_dma_buf_detach(struct dma_buf
> *dmabuf,
>
>       pm_runtime_mark_last_busy(adev_to_drm(adev)->dev);
>       pm_runtime_put_autosuspend(adev_to_drm(adev)->dev);
> +     trace_amdgpu_runpm_reference_dumps(0, __func__);
>  }
>
>  /**
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
> index 709a2c1b9d63..1026a9fa0c0f 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
> @@ -183,6 +183,7 @@ int amdgpu_fence_emit(struct amdgpu_ring *ring,
> struct dma_fence **f, struct amd
>       amdgpu_ring_emit_fence(ring, ring->fence_drv.gpu_addr,
>                              seq, flags | AMDGPU_FENCE_FLAG_INT);
>       pm_runtime_get_noresume(adev_to_drm(adev)->dev);
> +     trace_amdgpu_runpm_reference_dumps(1, __func__);
>       ptr =3D &ring->fence_drv.fences[seq & ring-
> >fence_drv.num_fences_mask];
>       if (unlikely(rcu_dereference_protected(*ptr, 1))) {
>               struct dma_fence *old;
> @@ -286,8 +287,11 @@ bool amdgpu_fence_process(struct amdgpu_ring
> *ring)
>           seq !=3D ring->fence_drv.sync_seq)
>               amdgpu_fence_schedule_fallback(ring);
>
> -     if (unlikely(seq =3D=3D last_seq))
> +     if (unlikely(seq =3D=3D last_seq)) {
> +             pm_runtime_put_autosuspend(adev_to_drm(adev)->dev);
> +             trace_amdgpu_runpm_reference_dumps(0, __func__);
>               return false;
> +     }
>
>       last_seq &=3D drv->num_fences_mask;
>       seq &=3D drv->num_fences_mask;
> @@ -310,6 +314,7 @@ bool amdgpu_fence_process(struct amdgpu_ring
> *ring)
>               dma_fence_put(fence);
>               pm_runtime_mark_last_busy(adev_to_drm(adev)->dev);
>               pm_runtime_put_autosuspend(adev_to_drm(adev)->dev);
> +             trace_amdgpu_runpm_reference_dumps(0, __func__);
>       } while (last_seq !=3D seq);
>
>       return true;
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_trace.h
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_trace.h
> index 2fd1bfb35916..5d4792645540 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_trace.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_trace.h
> @@ -554,6 +554,21 @@ TRACE_EVENT(amdgpu_reset_reg_dumps,
>                     __entry->value)
>  );
>
> +TRACE_EVENT(amdgpu_runpm_reference_dumps,
> +         TP_PROTO(uint32_t index, const char *func),
> +         TP_ARGS(index, func),
> +         TP_STRUCT__entry(
> +                          __field(uint32_t, index)
> +                          __string(func, func)
> +                          ),
> +         TP_fast_assign(
> +                        __entry->index =3D index;
> +                        __assign_str(func, func);
> +                        ),
> +         TP_printk("amdgpu runpm reference dump 0x%d: 0x%s\n",
> +                   __entry->index,
> +                   __get_str(func))
> +);
>  #undef AMDGPU_JOB_GET_TIMELINE_NAME
>  #endif
>
> --
> 2.34.1

