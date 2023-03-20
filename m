Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C018FC6FD1D
	for <amd-gfx@archiver.kernel.org>; Mon, 20 Mar 2023 07:05:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4AF5210E1EA;
	Mon, 20 Mar 2023 07:05:30 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2062.outbound.protection.outlook.com [40.107.237.62])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E79B010E1EA
 for <amd-gfx@lists.freedesktop.org>; Mon, 20 Mar 2023 07:05:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=I48wD2FpkMQog1ybFtg5Jn5es8liV3XF41Bn/s5gT30ZZYOdOQ5PpzvVcEIFFmu4G9125gINPaPkgBXi4J+u3MGOCyRS67VJlSYOQJePy8Jc0pPHj4kHQoLjtd8OekoC4ebaukifj85Wg069NgsN8ozO7WeKGSbxdtHt5WAiYbuDWfOdK26fgJsHPagABFlnjg5MpKLCbka8mSN+IuXPSvVeYmUfu2ulM+98CfHzwJ6df/aihVFAMRKql6NQnFnZv3uS90FIQvniMbY8KN2wp3H2FKJ1YAexRJ/1s+QbN+Q5bLoIYS0Q42EqPXOsskvoWUxuyyXESce64mIjr1tn7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1gxs66DqoZkPKEmJRDCOjJ3IEktb8THuI9z0EuTKY6U=;
 b=ndf6CnwyOvfGwaWq3miuTiO2CvP7FwcXLhQLTcBMnaEbSFqLZx+PkugGrCW7j6xYhNGAWHtyByd2uKdDej4xM5keCRxxWQeql/6IPetupTcuuyWc/WF+ywXdCVCKj3bcCEfGaEcHmr61tdc8biBD81w7DQ2HhKyv359wqw5TecxqTBg6R1Stw9hKTrD9m2aHHtflw+IuA924N2Z34jE1rN5IwAMierYCBiGbYaRNjFxdIEciu4aY20d7lSw8KJ5o9K2O2TI/5/KPJ0+8O9h8FPAhrZhTEV2Bh5b4Nw6BYn/A5K2dIhD0XLS4efGLlHbosi1m63r0i3YWSlPsb0eXmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1gxs66DqoZkPKEmJRDCOjJ3IEktb8THuI9z0EuTKY6U=;
 b=1nb+LzCQrfoR/ATg2qLYwRMQeVXpnpYqfkTbElSjJllpkGekOROyf6AkuWpkARj+O8oOSyTfa11X3fJK3NchnAqpGlqc6NeoOqtYW3fVbS9D4G6UzB4GfW8ZzyObRTayxmajMp3hZBBzWC+9K2mlX/qtoaV+fKyHeeGyc/70rTw=
Received: from DM6PR12MB2619.namprd12.prod.outlook.com (2603:10b6:5:45::18) by
 IA1PR12MB6284.namprd12.prod.outlook.com (2603:10b6:208:3e4::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.37; Mon, 20 Mar
 2023 07:05:24 +0000
Received: from DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::3334:46b8:da25:16ad]) by DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::3334:46b8:da25:16ad%7]) with mapi id 15.20.6178.037; Mon, 20 Mar 2023
 07:05:24 +0000
From: "Quan, Evan" <Evan.Quan@amd.com>
To: "Kim, Jonathan" <Jonathan.Kim@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: improve debug VRAM access performance using
 sdma
Thread-Topic: [PATCH] drm/amdgpu: improve debug VRAM access performance using
 sdma
Thread-Index: AQHYAZ8Gwqcv7lI6eEKGIty17FouWq8F7sng
Date: Mon, 20 Mar 2023 07:05:23 +0000
Message-ID: <DM6PR12MB26197A9101DD2B16D580D12AE4809@DM6PR12MB2619.namprd12.prod.outlook.com>
References: <20220104191211.1707514-1-jonathan.kim@amd.com>
In-Reply-To: <20220104191211.1707514-1-jonathan.kim@amd.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2023-03-20T07:05:10Z; 
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=10018fb2-71fa-4a21-8430-696902f0dc03;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR12MB2619:EE_|IA1PR12MB6284:EE_
x-ms-office365-filtering-correlation-id: 5110b4c1-1e8a-435d-94e3-08db291179e1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: BTt6ZwNb5GjR+djkE83hMZFCI1V+BIQTN1mXIp7+S3sfvic9Dp5ldwVYE4eSkcVE2/QaXXJU7/N48lP0ItSP81lH4l5G+Q4SQ8Z7eWHBJpVtRY6qKL5Z+Bv7Msd9KVDux9JnkcThq+SzntsGYEmkFatgl+3qmg5unJQEgOnlHR3TF4du3HO/Xaak0c9mZTcXp+d9E0BwpvvF7FYOinxzjCFqVGEvBFxRETlOzSnbInlIn6zKo165DNAVpMJkAOFMOfkS4euAnsTLEaf+m3YT+nb+mnjIkBid7gDVbN28hEJIg3VNftQPqxOTMVLKgcrZb/OZA9+z0fjvqe2mrWJIR9y3NTZ/afVdI61JwhiVIwZgQSguWdzDk3dzIHB/qusxPDF8427HxZvekofrgeDWszONI6Po7XzqmC1VVPVVbGDnQBt+ZTAlYfE0ax0NnMGebXPeupnKlkCn92uPbYw+n/qM429vn7mpobzo2574Ra/gnLcwGvmN4FiX0O9cYpBRvQt3bqME/UbexS+nO4KqOMKe1LxiSBEW64At+OJdCh/YdBUVM1kgh7UsLJiC0ReMwtPkLs2/Gjvipq4Qc5MeQ3i/LY8f/Six35pyZ3gn1HwNAxVloA1SIWrYv0pf8EPN9cKgX5s2bV5WprAYUHhVay54RBMW8dtekdAUPthU+csWdqVp7HIcHyL+EHmTbCa4pnhQ3QJ9nQZTh7xoSkaFGg==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2619.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230025)(4636009)(376002)(366004)(136003)(39860400002)(396003)(346002)(451199018)(86362001)(6506007)(9686003)(33656002)(26005)(38070700005)(53546011)(38100700002)(71200400001)(2906002)(122000001)(5660300002)(7696005)(52536014)(8936002)(41300700001)(55016003)(83380400001)(478600001)(110136005)(186003)(54906003)(8676002)(76116006)(64756008)(66476007)(66446008)(316002)(66946007)(66556008)(4326008);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?GbWeQnyHs/8gMXBoVvLH8YfxIXeM+gEyTeoXjKMX/M8HtVC+JYU1PCnk7JSK?=
 =?us-ascii?Q?j4VIXvxnBlq6Eb42KPeX3kK13ygq8LGqz/XuOedVk7BM2PLbtdbHtdAyRQIQ?=
 =?us-ascii?Q?gKWOn/mjRdcLrEnxXA8x+4zO5gcMA98mxu12QU2dNRF4j7XmD0aPR1rOIBsO?=
 =?us-ascii?Q?bJD0JGFUoeds6Yc2l/bVzhvwoRNcuiwjKIxmxYEuvaCj/buQ4SLO5xFNqR15?=
 =?us-ascii?Q?cFsXlg4/yKbSpjnwtzxf2HJyQZpm8QmPB1W7x4VRT8TtgmNEmvCnqz5dbIb1?=
 =?us-ascii?Q?+XJ6upMSoxZOi7QtHG+NKtiGXmZI8uYivG2+vm8qjhFzVIKZ7u9CaPmcUvk9?=
 =?us-ascii?Q?HWLd19u59Q2+Ub8v08mAkE1slcON3sc2s8wXrtvDBW0zt9kyTlaJ3Rnnpt8r?=
 =?us-ascii?Q?Bu5Jh9ur5ft7YsO06S7WpMMj75fl7Ot7ZPWkHBJ2w5VkuPRVlD80QOFsFpif?=
 =?us-ascii?Q?yndxkmJeqfdI7yVSuJvJirWyS4I+YZBIaC0GTBiTLGlVKbtPlu142iV9CPxA?=
 =?us-ascii?Q?F8izXXukwc2PcCQ8GGzCioBRGwX6km57rdzJ4VFET5bF8o4YbHrP2TpBDUz3?=
 =?us-ascii?Q?k4OAW66OTgJsaWd4/4+WRxUB8e93IOBE//OgyaGbzVeywtHGP12sxIFIt2+Q?=
 =?us-ascii?Q?X+fsgRl7NW2vwrm3MzTMJPMi2ZBSdcd6VpuUbwBNmiNNgqY1GbJ7nY72UfFe?=
 =?us-ascii?Q?jL9xcAB//1RSnpsHAXtUyKnNj52T/Z3p4rSzxePYx6nooHvoW1+Tdl7zTenq?=
 =?us-ascii?Q?R9nNmh/vSV2HaszmWWBIwLVZjc2YwgzJEXFZERJXGjO1W2p+Y3j5Jr66FLBz?=
 =?us-ascii?Q?/YA4Gmp//JJCUJzs+brag93RYgHTm33k7oNoPPEvO0Jy2ZiiWmviqtPc5jDc?=
 =?us-ascii?Q?f/FfDKJixDbVeyYmSWuGNlcGlJmNtmor7WkAZthqEhSeZcVC9M0eyNthBsCg?=
 =?us-ascii?Q?Qtl3LU8AUInzKttPY2Alsr1vbWsUp6Q6c2MHCQK+DzEykcpMdg8zCnbNDDac?=
 =?us-ascii?Q?5i8CsmgFFMLP4jhBPjyO9i+tob+T8dGtGt6OkGZWV35OjgAZLl9oBAPSZqQ7?=
 =?us-ascii?Q?U97UV6JaUaMdpqTNXtS3puokKX7xoObeiQ67/IDryjoni27F+C+S1gbrgnbN?=
 =?us-ascii?Q?U0/ClJ3XylhFsqH0XVo1AXqqQJvXi+I8jcUTITVPI8Cl3KyOczOMfw+ybaDt?=
 =?us-ascii?Q?U/9BNBX7grbi5b+r5yF6hHRhzu+pCYIErq0nCA9CL6ktqJUtnVjWgaoe7q6T?=
 =?us-ascii?Q?iBUuwr46IWjQoO/Wqec0Ty25T8m77ojBY5DMXTnxOBUjYaSZugu7oRv58wCa?=
 =?us-ascii?Q?KnMbS7dePjfA2K9wduo9EgZh/bP2pUsxrCIC9+39VPxEtoMm6050+yzjBuzK?=
 =?us-ascii?Q?vTMsGXPfbQaZ5lgxcr4kG8F4gs4w6AytimgpqJOQMVO20JPGWgbCZLhsvSCS?=
 =?us-ascii?Q?biqI1MIojONFXFfrLwiB8TzPo6gkRNUvBHMsTnGz7WT8s0MxUIQNyT5cCIE1?=
 =?us-ascii?Q?uA1L01p6KBhLEpjFp9CyaabTN2KkIqbzrSSQWU1AOKtAZZJLdbtopyvLk/88?=
 =?us-ascii?Q?cdT30AQKia0TWJTaBog=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2619.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5110b4c1-1e8a-435d-94e3-08db291179e1
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Mar 2023 07:05:23.8754 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: WzFKpWk6usCtXgEPQp7A/up0xCQ4jlwmK1vbrUJ9f61lsFtVxlGVNmKK53QeHvqL
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6284
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
Cc: "Kuehling, Felix" <Felix.Kuehling@amd.com>, "Kim,
 Jonathan" <Jonathan.Kim@amd.com>, "Koenig,
 Christian" <Christian.Koenig@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - General]

I happened to find the sdma_access_bo allocation from GTT seems performing =
before gart is ready.
That makes the "amdgpu_gart_map" is skipped since adev->gart.ptr is still N=
ULL.
Is that done intentionally ?

Evan
> -----Original Message-----
> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of
> Jonathan Kim
> Sent: Wednesday, January 5, 2022 3:12 AM
> To: amd-gfx@lists.freedesktop.org
> Cc: Kuehling, Felix <Felix.Kuehling@amd.com>; Kim, Jonathan
> <Jonathan.Kim@amd.com>; Koenig, Christian <Christian.Koenig@amd.com>
> Subject: [PATCH] drm/amdgpu: improve debug VRAM access performance
> using sdma
>=20
> For better performance during VRAM access for debugged processes, do
> read/write copies over SDMA.
>=20
> In order to fulfill post mortem debugging on a broken device, fallback to
> stable MMIO access when gpu recovery is disabled or when job submission
> time outs are set to max.  Failed SDMA access should automatically fall
> back to MMIO access.
>=20
> Use a pre-allocated GTT bounce buffer pre-mapped into GART to avoid
> page-table updates and TLB flushes on access.
>=20
> Signed-off-by: Jonathan Kim <jonathan.kim@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c | 78
> +++++++++++++++++++++++++
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h |  5 +-
>  2 files changed, 82 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> index 367abed1d6e6..512df4c09772 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> @@ -48,6 +48,7 @@
>  #include <drm/ttm/ttm_range_manager.h>
>=20
>  #include <drm/amdgpu_drm.h>
> +#include <drm/drm_drv.h>
>=20
>  #include "amdgpu.h"
>  #include "amdgpu_object.h"
> @@ -1429,6 +1430,70 @@ static void amdgpu_ttm_vram_mm_access(struct
> amdgpu_device *adev, loff_t pos,
>  	}
>  }
>=20
> +static int amdgpu_ttm_access_memory_sdma(struct ttm_buffer_object
> *bo,
> +					unsigned long offset, void *buf, int
> len, int write)
> +{
> +	struct amdgpu_bo *abo =3D ttm_to_amdgpu_bo(bo);
> +	struct amdgpu_device *adev =3D amdgpu_ttm_adev(abo->tbo.bdev);
> +	struct amdgpu_job *job;
> +	struct dma_fence *fence;
> +	uint64_t src_addr, dst_addr;
> +	unsigned int num_dw;
> +	int r, idx;
> +
> +	if (len !=3D PAGE_SIZE)
> +		return -EINVAL;
> +
> +	if (!adev->mman.sdma_access_ptr)
> +		return -EACCES;
> +
> +	r =3D drm_dev_enter(adev_to_drm(adev), &idx);
> +	if (r)
> +		return r;
> +
> +	if (write)
> +		memcpy(adev->mman.sdma_access_ptr, buf, len);
> +
> +	num_dw =3D ALIGN(adev->mman.buffer_funcs->copy_num_dw, 8);
> +	r =3D amdgpu_job_alloc_with_ib(adev, num_dw * 4,
> AMDGPU_IB_POOL_DELAYED, &job);
> +	if (r)
> +		goto out;
> +
> +	src_addr =3D write ? amdgpu_bo_gpu_offset(adev-
> >mman.sdma_access_bo) :
> +			amdgpu_bo_gpu_offset(abo);
> +	dst_addr =3D write ? amdgpu_bo_gpu_offset(abo) :
> +			amdgpu_bo_gpu_offset(adev-
> >mman.sdma_access_bo);
> +	amdgpu_emit_copy_buffer(adev, &job->ibs[0], src_addr, dst_addr,
> PAGE_SIZE, false);
> +
> +	amdgpu_ring_pad_ib(adev->mman.buffer_funcs_ring, &job->ibs[0]);
> +	WARN_ON(job->ibs[0].length_dw > num_dw);
> +
> +	r =3D amdgpu_job_submit(job, &adev->mman.entity,
> AMDGPU_FENCE_OWNER_UNDEFINED, &fence);
> +	if (r) {
> +		amdgpu_job_free(job);
> +		goto out;
> +	}
> +
> +	if (!dma_fence_wait_timeout(fence, false, adev->sdma_timeout))
> +		r =3D -ETIMEDOUT;
> +	dma_fence_put(fence);
> +
> +	if (!(r || write))
> +		memcpy(buf, adev->mman.sdma_access_ptr, len);
> +out:
> +	drm_dev_exit(idx);
> +	return r;
> +}
> +
> +static inline bool amdgpu_ttm_allow_post_mortem_debug(struct
> amdgpu_device *adev)
> +{
> +	return amdgpu_gpu_recovery =3D=3D 0 ||
> +		adev->gfx_timeout =3D=3D MAX_SCHEDULE_TIMEOUT ||
> +		adev->compute_timeout =3D=3D MAX_SCHEDULE_TIMEOUT ||
> +		adev->sdma_timeout =3D=3D MAX_SCHEDULE_TIMEOUT ||
> +		adev->video_timeout =3D=3D MAX_SCHEDULE_TIMEOUT;
> +}
> +
>  /**
>   * amdgpu_ttm_access_memory - Read or Write memory that backs a
> buffer object.
>   *
> @@ -1453,6 +1518,10 @@ static int amdgpu_ttm_access_memory(struct
> ttm_buffer_object *bo,
>  	if (bo->resource->mem_type !=3D TTM_PL_VRAM)
>  		return -EIO;
>=20
> +	if (!amdgpu_ttm_allow_post_mortem_debug(adev) &&
> +			!amdgpu_ttm_access_memory_sdma(bo, offset, buf,
> len, write))
> +		return len;
> +
>  	amdgpu_res_first(bo->resource, offset, len, &cursor);
>  	while (cursor.remaining) {
>  		size_t count, size =3D cursor.size;
> @@ -1793,6 +1862,12 @@ int amdgpu_ttm_init(struct amdgpu_device *adev)
>  		return r;
>  	}
>=20
> +	if (amdgpu_bo_create_kernel(adev, PAGE_SIZE, PAGE_SIZE,
> +				AMDGPU_GEM_DOMAIN_GTT,
> +				&adev->mman.sdma_access_bo, NULL,
> +				adev->mman.sdma_access_ptr))
> +		DRM_WARN("Debug VRAM access will use slowpath MM
> access\n");
> +
>  	return 0;
>  }
>=20
> @@ -1823,6 +1898,9 @@ void amdgpu_ttm_fini(struct amdgpu_device
> *adev)
>  	ttm_range_man_fini(&adev->mman.bdev, AMDGPU_PL_OA);
>  	ttm_device_fini(&adev->mman.bdev);
>  	adev->mman.initialized =3D false;
> +	if (adev->mman.sdma_access_ptr)
> +		amdgpu_bo_free_kernel(&adev->mman.sdma_access_bo,
> NULL,
> +					&adev->mman.sdma_access_ptr);
>  	DRM_INFO("amdgpu: ttm finalized\n");
>  }
>=20
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
> index 91a087f9dc7c..b0116c4a768f 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
> @@ -98,6 +98,10 @@ struct amdgpu_mman {
>  	u64		fw_vram_usage_size;
>  	struct amdgpu_bo	*fw_vram_usage_reserved_bo;
>  	void		*fw_vram_usage_va;
> +
> +	/* PAGE_SIZE'd BO for process memory r/w over SDMA. */
> +	struct amdgpu_bo	*sdma_access_bo;
> +	void			*sdma_access_ptr;
>  };
>=20
>  struct amdgpu_copy_mem {
> @@ -193,5 +197,4 @@ uint64_t amdgpu_ttm_tt_pte_flags(struct
> amdgpu_device *adev, struct ttm_tt *ttm,
>  int amdgpu_ttm_evict_resources(struct amdgpu_device *adev, int
> mem_type);
>=20
>  void amdgpu_ttm_debugfs_init(struct amdgpu_device *adev);
> -
>  #endif
> --
> 2.25.1
