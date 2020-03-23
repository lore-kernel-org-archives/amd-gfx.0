Return-Path: <SRS0=zf+m=5I=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FFB5C10F26
	for <amd-gfx@archiver.kernel.org>; Mon, 23 Mar 2020 07:23:05 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 26BB920732
	for <amd-gfx@archiver.kernel.org>; Mon, 23 Mar 2020 07:23:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="EnJln5vT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 26BB920732
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D6FBF89E3F;
	Mon, 23 Mar 2020 07:23:04 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2061.outbound.protection.outlook.com [40.107.94.61])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CAC8C89E3F
 for <amd-gfx@lists.freedesktop.org>; Mon, 23 Mar 2020 07:23:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ngFRdZ1sS9KCdmlCtBkUXphMPwhAHIv33PmLUcex7B4qU+whapRZfwdDK1SSzpsqkSY4POYoEDNxCIdR1PdaZtIvwL+Cco0Shkrf5r/+xM6mrg/27dH7j7SEc0B8yFoVtv3ZRHrS0Obf+aCZ7YwHa5T9ammJgf2n5zroL1fsWp4vzV9IErLbPowOGWnPoVRl4p8UoAzJjs+wUbpqCYiO3Vj5FJp6letlg7zie25ticSpIQQs7C2gwcD6KvVU6deB2LrUV6CLWs8z1i9UPxHuT51s5aqcerxiaHog8Qa8UkWUv/zGLgKCl0ScSJQ4cHe3dyotYxlcUwOAqG00pGavcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/GIpUX+U8U9ZZLOBv+iop9Ikmg+5ulati5HUXH5uxc4=;
 b=Jc4AlZh4F3e+1FLGwreERPMKtBCpPU4b5Gr/KJYOUS6VTswppGwmbyciy8e1PK/DmoT4/QawOH/SGXVxZ7eumUhmH+O++1sOMv88faceUGH3It2xdVJ89lE4FAei4sEMOpNL6FYR7Vmzb9rkEBHv/29/RU+WlsrW74U7ZOLxbYaaPefIMwBzyTYPJor2RKitQx3OwAsPcnAhfTG5hPTWQSIjy4+ViBX7kuV7ZMtKh+fk7I2R1c0hLbQ+3ZY/Wug+fftgBQGfZ8RhC8tmgg5ugGcSdYJoqxe0H29wshjqwt+WayMApxnd5DjSxs9JZPQtbo6ewo6pagSO03XHs2Fa7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/GIpUX+U8U9ZZLOBv+iop9Ikmg+5ulati5HUXH5uxc4=;
 b=EnJln5vT6OIRdK7f5sXhMlZaQOyx/aQh68FY/16p7xoWNWP77tEfiP4domu7/RL8b9Vk6T3mhr5pLmmkZB8TSehakF5plV++R/8wZGfALdhxsbIa1FzJ5rT6+QzdnfSamRShEOQfD30PtymLNIFHlN3azmgbGEhD0la0dhbTvDo=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Ray.Huang@amd.com; 
Received: from MN2PR12MB3309.namprd12.prod.outlook.com (2603:10b6:208:106::29)
 by MN2PR12MB3232.namprd12.prod.outlook.com (2603:10b6:208:ab::29)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2835.18; Mon, 23 Mar
 2020 07:23:01 +0000
Received: from MN2PR12MB3309.namprd12.prod.outlook.com
 ([fe80::6417:7247:12ed:1d7b]) by MN2PR12MB3309.namprd12.prod.outlook.com
 ([fe80::6417:7247:12ed:1d7b%5]) with mapi id 15.20.2814.027; Mon, 23 Mar 2020
 07:23:01 +0000
Date: Mon, 23 Mar 2020 15:22:50 +0800
From: Huang Rui <ray.huang@amd.com>
To: Christian =?iso-8859-1?Q?K=F6nig?= <ckoenig.leichtzumerken@gmail.com>
Subject: Re: [PATCH 1/2] drm/amdgpu: cleanup amdgpu_ttm_copy_mem_to_mem and
 amdgpu_map_buffer v2
Message-ID: <20200323072249.GA25240@jenkins-Celadon-RN>
References: <20200322154835.2702-1-christian.koenig@amd.com>
Content-Disposition: inline
In-Reply-To: <20200322154835.2702-1-christian.koenig@amd.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: HK2PR0302CA0013.apcprd03.prod.outlook.com
 (2603:1096:202::23) To MN2PR12MB3309.namprd12.prod.outlook.com
 (2603:10b6:208:106::29)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from jenkins-Celadon-RN (180.167.199.189) by
 HK2PR0302CA0013.apcprd03.prod.outlook.com (2603:1096:202::23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2856.8 via Frontend Transport; Mon, 23 Mar 2020 07:22:57 +0000
X-Originating-IP: [180.167.199.189]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 71b59f98-6503-4cfa-c8e5-08d7cefb0511
X-MS-TrafficTypeDiagnostic: MN2PR12MB3232:|MN2PR12MB3232:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB32325B66ED623B07C284BC98ECF00@MN2PR12MB3232.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2803;
X-Forefront-PRVS: 0351D213B3
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(346002)(366004)(39860400002)(396003)(136003)(376002)(199004)(26005)(956004)(5660300002)(66574012)(1076003)(966005)(30864003)(2906002)(316002)(6916009)(6496006)(478600001)(45080400002)(81156014)(8676002)(81166006)(6666004)(4326008)(8936002)(52116002)(33716001)(33656002)(55016002)(86362001)(9686003)(66476007)(66556008)(66946007)(16526019)(186003);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MN2PR12MB3232;
 H:MN2PR12MB3309.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GP/ZJVS4MdBvEZzFrUVBA/wrf9NK44oQBV1uXdqRmmsn4zHkcXZTSfDjG7Jhr7aA8Ly64qpBafNRNOTG7fTO/UD43v87m1sOFtBy184sjH7iRPWATISqMQC1FjriCXUW/vT651qoAQ2PwyTJ9s+h4upoMxfV05mhgv8ezpkD43GfzYKPAk08kiCo8EEU8E7QBuWJMXZrLY2IfNWAchyr4rxjMdPQDWYvXRCEapBvFHA3WHhL8ORkgAuEHnOeGgM6uNqBewS8sKhGMtCl8yJmU/1rd/kIQszfH2azE97IdBpwaDDG1N5saMMQp6taqXjQgSoDutdhF5/NwcZY7SEFnRpywjGL9GTG27dOg8wZ13GHhZVXw6TisQXbnvlQCPnUtsdHp7LhFLNovVKRcE7vo/vr3w5IK/IvyO9nAjGq7iCIrZlw3EzDx65bCM27FeKzSEKzdfRV0XNEnAKB8Pje08ETpMp+hvpQp5y+Xxm1w9M=
X-MS-Exchange-AntiSpam-MessageData: dODMnRCzZout+K9GwDRqfX+kFYigpiaLx1wdB4elRDcUwxdri44dZXKgpFiMYDX8A4hS6TLnCUGWF6tf5LZ9g1t1FUwHCZDLKlUiNnaIiK1iG5YnnDiBa+KHe3FlgZRbZ/3Jozfd36ymQtcBkfjDxw==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 71b59f98-6503-4cfa-c8e5-08d7cefb0511
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Mar 2020 07:23:01.5957 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CLmWMHEyswoffPz6TyCg2af1SfvoAKq4x0f17GmyWuzITXlDbTsu/PgNni2KVn+vMcMCX0TTf/fFaRlnhfnp0A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3232
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
Cc: Felix.Kuehling@amd.com, amd-gfx@lists.freedesktop.org
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Sun, Mar 22, 2020 at 04:48:34PM +0100, Christian K=F6nig wrote:
> Cleanup amdgpu_ttm_copy_mem_to_mem by using fewer variables
> for the same value.
> =

> Rename amdgpu_map_buffer to amdgpu_ttm_map_buffer, move it
> to avoid the forward decleration, cleanup by moving the map
> decission into the function and add some documentation.
> =

> No functional change.
> =

> v2: add some more cleanup suggested by Felix
> =

> Signed-off-by: Christian K=F6nig <christian.koenig@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c | 269 ++++++++++++++++----------=
------
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h |   4 +-
>  2 files changed, 135 insertions(+), 138 deletions(-)
> =

> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_ttm.c
> index 665db2353a78..53de99dbaead 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> @@ -62,12 +62,6 @@
>  =

>  #define AMDGPU_TTM_VRAM_MAX_DW_READ	(size_t)128
>  =

> -static int amdgpu_map_buffer(struct ttm_buffer_object *bo,
> -			     struct ttm_mem_reg *mem, unsigned num_pages,
> -			     uint64_t offset, unsigned window,
> -			     struct amdgpu_ring *ring, bool tmz,
> -			     uint64_t *addr);
> -
>  static int amdgpu_invalidate_caches(struct ttm_bo_device *bdev, uint32_t=
 flags)
>  {
>  	return 0;
> @@ -282,7 +276,7 @@ static uint64_t amdgpu_mm_node_addr(struct ttm_buffer=
_object *bo,
>   *
>   */
>  static struct drm_mm_node *amdgpu_find_mm_node(struct ttm_mem_reg *mem,
> -					       unsigned long *offset)
> +					       uint64_t *offset)
>  {
>  	struct drm_mm_node *mm_node =3D mem->mm_node;
>  =

> @@ -293,6 +287,94 @@ static struct drm_mm_node *amdgpu_find_mm_node(struc=
t ttm_mem_reg *mem,
>  	return mm_node;
>  }
>  =

> +/**
> + * amdgpu_ttm_map_buffer - Map memory into the GART windows
> + * @bo: buffer object to map
> + * @mem: memory object to map
> + * @mm_node: drm_mm node object to map
> + * @num_pages: number of pages to map
> + * @offset: offset into @mm_node where to start
> + * @window: which GART window to use
> + * @ring: DMA ring to use for the copy
> + * @tmz: if we should setup a TMZ enabled mapping
> + * @addr: resulting address inside the MC address space
> + *
> + * Setup one of the GART windows to access a specific piece of memory or=
 return
> + * the physical address for local memory.
> + */
> +static int amdgpu_ttm_map_buffer(struct ttm_buffer_object *bo,
> +				 struct ttm_mem_reg *mem,
> +				 struct drm_mm_node *mm_node,
> +				 unsigned num_pages, uint64_t offset,
> +				 unsigned window, struct amdgpu_ring *ring,
> +				 bool tmz, uint64_t *addr)
> +{
> +	struct ttm_dma_tt *dma =3D container_of(bo->ttm, struct ttm_dma_tt, ttm=
);
> +	struct amdgpu_device *adev =3D ring->adev;
> +	struct amdgpu_job *job;
> +	unsigned num_dw, num_bytes;
> +	dma_addr_t *dma_address;
> +	struct dma_fence *fence;
> +	uint64_t src_addr, dst_addr;
> +	uint64_t flags;
> +	int r;
> +
> +	BUG_ON(adev->mman.buffer_funcs->copy_max_bytes <
> +	       AMDGPU_GTT_MAX_TRANSFER_SIZE * 8);
> +
> +	/* Map only what can't be accessed directly */
> +	if (mem->start !=3D AMDGPU_BO_INVALID_OFFSET) {
> +		*addr =3D amdgpu_mm_node_addr(bo, mm_node, mem) + offset;
> +		return 0;
> +	}
> +
> +	*addr =3D adev->gmc.gart_start;
> +	*addr +=3D (u64)window * AMDGPU_GTT_MAX_TRANSFER_SIZE *
> +		AMDGPU_GPU_PAGE_SIZE;
> +	*addr +=3D offset & ~PAGE_MASK;
> +
> +	num_dw =3D ALIGN(adev->mman.buffer_funcs->copy_num_dw, 8);
> +	num_bytes =3D num_pages * 8;
> +
> +	r =3D amdgpu_job_alloc_with_ib(adev, num_dw * 4 + num_bytes, &job);
> +	if (r)
> +		return r;
> +
> +	src_addr =3D num_dw * 4;
> +	src_addr +=3D job->ibs[0].gpu_addr;
> +
> +	dst_addr =3D amdgpu_bo_gpu_offset(adev->gart.bo);
> +	dst_addr +=3D window * AMDGPU_GTT_MAX_TRANSFER_SIZE * 8;
> +	amdgpu_emit_copy_buffer(adev, &job->ibs[0], src_addr,
> +				dst_addr, num_bytes, false);
> +
> +	amdgpu_ring_pad_ib(ring, &job->ibs[0]);
> +	WARN_ON(job->ibs[0].length_dw > num_dw);
> +
> +	dma_address =3D &dma->dma_address[offset >> PAGE_SHIFT];
> +	flags =3D amdgpu_ttm_tt_pte_flags(adev, bo->ttm, mem);
> +	if (tmz)
> +		flags |=3D AMDGPU_PTE_TMZ;

Move the flags setting into amdgpu_ttm_tt_pte_flags()?

Others look good for me, Reviewed-by: Huang Rui <ray.huang@amd.com>

> +
> +	r =3D amdgpu_gart_map(adev, 0, num_pages, dma_address, flags,
> +			    &job->ibs[0].ptr[num_dw]);
> +	if (r)
> +		goto error_free;
> +
> +	r =3D amdgpu_job_submit(job, &adev->mman.entity,
> +			      AMDGPU_FENCE_OWNER_UNDEFINED, &fence);
> +	if (r)
> +		goto error_free;
> +
> +	dma_fence_put(fence);
> +
> +	return r;
> +
> +error_free:
> +	amdgpu_job_free(job);
> +	return r;
> +}
> +
>  /**
>   * amdgpu_copy_ttm_mem_to_mem - Helper function for copy
>   * @adev: amdgpu device
> @@ -309,79 +391,62 @@ static struct drm_mm_node *amdgpu_find_mm_node(stru=
ct ttm_mem_reg *mem,
>   *
>   */
>  int amdgpu_ttm_copy_mem_to_mem(struct amdgpu_device *adev,
> -			       struct amdgpu_copy_mem *src,
> -			       struct amdgpu_copy_mem *dst,
> +			       const struct amdgpu_copy_mem *src,
> +			       const struct amdgpu_copy_mem *dst,
>  			       uint64_t size, bool tmz,
>  			       struct dma_resv *resv,
>  			       struct dma_fence **f)
>  {
> +	const uint32_t GTT_MAX_BYTES =3D (AMDGPU_GTT_MAX_TRANSFER_SIZE *
> +					AMDGPU_GPU_PAGE_SIZE);
> +
> +	uint64_t src_node_size, dst_node_size, src_offset, dst_offset;
>  	struct amdgpu_ring *ring =3D adev->mman.buffer_funcs_ring;
>  	struct drm_mm_node *src_mm, *dst_mm;
> -	uint64_t src_node_start, dst_node_start, src_node_size,
> -		 dst_node_size, src_page_offset, dst_page_offset;
>  	struct dma_fence *fence =3D NULL;
>  	int r =3D 0;
> -	const uint64_t GTT_MAX_BYTES =3D (AMDGPU_GTT_MAX_TRANSFER_SIZE *
> -					AMDGPU_GPU_PAGE_SIZE);
>  =

>  	if (!adev->mman.buffer_funcs_enabled) {
>  		DRM_ERROR("Trying to move memory with ring turned off.\n");
>  		return -EINVAL;
>  	}
>  =

> -	src_mm =3D amdgpu_find_mm_node(src->mem, &src->offset);
> -	src_node_start =3D amdgpu_mm_node_addr(src->bo, src_mm, src->mem) +
> -					     src->offset;
> -	src_node_size =3D (src_mm->size << PAGE_SHIFT) - src->offset;
> -	src_page_offset =3D src_node_start & (PAGE_SIZE - 1);
> +	src_offset =3D src->offset;
> +	src_mm =3D amdgpu_find_mm_node(src->mem, &src_offset);
> +	src_node_size =3D (src_mm->size << PAGE_SHIFT) - src_offset;
>  =

> -	dst_mm =3D amdgpu_find_mm_node(dst->mem, &dst->offset);
> -	dst_node_start =3D amdgpu_mm_node_addr(dst->bo, dst_mm, dst->mem) +
> -					     dst->offset;
> -	dst_node_size =3D (dst_mm->size << PAGE_SHIFT) - dst->offset;
> -	dst_page_offset =3D dst_node_start & (PAGE_SIZE - 1);
> +	dst_offset =3D dst->offset;
> +	dst_mm =3D amdgpu_find_mm_node(dst->mem, &dst_offset);
> +	dst_node_size =3D (dst_mm->size << PAGE_SHIFT) - dst_offset;
>  =

>  	mutex_lock(&adev->mman.gtt_window_lock);
>  =

>  	while (size) {
> -		unsigned long cur_size;
> -		uint64_t from =3D src_node_start, to =3D dst_node_start;
> +		uint32_t src_page_offset =3D src_offset & ~PAGE_MASK;
> +		uint32_t dst_page_offset =3D dst_offset & ~PAGE_MASK;
>  		struct dma_fence *next;
> +		uint32_t cur_size;
> +		uint64_t from, to;
>  =

>  		/* Copy size cannot exceed GTT_MAX_BYTES. So if src or dst
>  		 * begins at an offset, then adjust the size accordingly
>  		 */
> -		cur_size =3D min3(min(src_node_size, dst_node_size), size,
> -				GTT_MAX_BYTES);
> -		if (cur_size + src_page_offset > GTT_MAX_BYTES ||
> -		    cur_size + dst_page_offset > GTT_MAX_BYTES)
> -			cur_size -=3D max(src_page_offset, dst_page_offset);
> -
> -		/* Map only what needs to be accessed. Map src to window 0 and
> -		 * dst to window 1
> -		 */
> -		if (src->mem->start =3D=3D AMDGPU_BO_INVALID_OFFSET) {
> -			r =3D amdgpu_map_buffer(src->bo, src->mem,
> -					PFN_UP(cur_size + src_page_offset),
> -					src_node_start, 0, ring, tmz,
> -					&from);
> -			if (r)
> -				goto error;
> -			/* Adjust the offset because amdgpu_map_buffer returns
> -			 * start of mapped page
> -			 */
> -			from +=3D src_page_offset;
> -		}
> +		cur_size =3D min3(src_node_size, dst_node_size, size);
> +		cur_size =3D min(GTT_MAX_BYTES - src_page_offset, cur_size);
> +		cur_size =3D min(GTT_MAX_BYTES - dst_page_offset, cur_size);
> +
> +		/* Map src to window 0 and dst to window 1. */
> +		r =3D amdgpu_ttm_map_buffer(src->bo, src->mem, src_mm,
> +					  PFN_UP(cur_size + src_page_offset),
> +					  src_offset, 0, ring, tmz, &from);
> +		if (r)
> +			goto error;
>  =

> -		if (dst->mem->start =3D=3D AMDGPU_BO_INVALID_OFFSET) {
> -			r =3D amdgpu_map_buffer(dst->bo, dst->mem,
> -					PFN_UP(cur_size + dst_page_offset),
> -					dst_node_start, 1, ring, tmz,
> -					&to);
> -			if (r)
> -				goto error;
> -			to +=3D dst_page_offset;
> -		}
> +		r =3D amdgpu_ttm_map_buffer(dst->bo, dst->mem, dst_mm,
> +					  PFN_UP(cur_size + dst_page_offset),
> +					  dst_offset, 1, ring, tmz, &to);
> +		if (r)
> +			goto error;
>  =

>  		r =3D amdgpu_copy_buffer(ring, from, to, cur_size,
>  				       resv, &next, false, true, tmz);
> @@ -397,23 +462,20 @@ int amdgpu_ttm_copy_mem_to_mem(struct amdgpu_device=
 *adev,
>  =

>  		src_node_size -=3D cur_size;
>  		if (!src_node_size) {
> -			src_node_start =3D amdgpu_mm_node_addr(src->bo, ++src_mm,
> -							     src->mem);
> -			src_node_size =3D (src_mm->size << PAGE_SHIFT);
> -			src_page_offset =3D 0;
> +			++src_mm;
> +			src_node_size =3D src_mm->size << PAGE_SHIFT;
> +			src_offset =3D 0;
>  		} else {
> -			src_node_start +=3D cur_size;
> -			src_page_offset =3D src_node_start & (PAGE_SIZE - 1);
> +			src_offset +=3D cur_size;
>  		}
> +
>  		dst_node_size -=3D cur_size;
>  		if (!dst_node_size) {
> -			dst_node_start =3D amdgpu_mm_node_addr(dst->bo, ++dst_mm,
> -							     dst->mem);
> -			dst_node_size =3D (dst_mm->size << PAGE_SHIFT);
> -			dst_page_offset =3D 0;
> +			++dst_mm;
> +			dst_node_size =3D dst_mm->size << PAGE_SHIFT;
> +			dst_offset =3D 0;
>  		} else {
> -			dst_node_start +=3D cur_size;
> -			dst_page_offset =3D dst_node_start & (PAGE_SIZE - 1);
> +			dst_offset +=3D cur_size;
>  		}
>  	}
>  error:
> @@ -754,8 +816,8 @@ static void amdgpu_ttm_io_mem_free(struct ttm_bo_devi=
ce *bdev, struct ttm_mem_re
>  static unsigned long amdgpu_ttm_io_mem_pfn(struct ttm_buffer_object *bo,
>  					   unsigned long page_offset)
>  {
> +	uint64_t offset =3D (page_offset << PAGE_SHIFT);
>  	struct drm_mm_node *mm;
> -	unsigned long offset =3D (page_offset << PAGE_SHIFT);
>  =

>  	mm =3D amdgpu_find_mm_node(&bo->mem, &offset);
>  	return (bo->mem.bus.base >> PAGE_SHIFT) + mm->start +
> @@ -1606,8 +1668,9 @@ static int amdgpu_ttm_access_memory(struct ttm_buff=
er_object *bo,
>  	if (bo->mem.mem_type !=3D TTM_PL_VRAM)
>  		return -EIO;
>  =

> -	nodes =3D amdgpu_find_mm_node(&abo->tbo.mem, &offset);
> -	pos =3D (nodes->start << PAGE_SHIFT) + offset;
> +	pos =3D offset;
> +	nodes =3D amdgpu_find_mm_node(&abo->tbo.mem, &pos);
> +	pos +=3D (nodes->start << PAGE_SHIFT);
>  =

>  	while (len && pos < adev->gmc.mc_vram_size) {
>  		uint64_t aligned_pos =3D pos & ~(uint64_t)3;
> @@ -2033,72 +2096,6 @@ int amdgpu_mmap(struct file *filp, struct vm_area_=
struct *vma)
>  	return ttm_bo_mmap(filp, vma, &adev->mman.bdev);
>  }
>  =

> -static int amdgpu_map_buffer(struct ttm_buffer_object *bo,
> -			     struct ttm_mem_reg *mem, unsigned num_pages,
> -			     uint64_t offset, unsigned window,
> -			     struct amdgpu_ring *ring, bool tmz,
> -			     uint64_t *addr)
> -{
> -	struct amdgpu_ttm_tt *gtt =3D (void *)bo->ttm;
> -	struct amdgpu_device *adev =3D ring->adev;
> -	struct ttm_tt *ttm =3D bo->ttm;
> -	struct amdgpu_job *job;
> -	unsigned num_dw, num_bytes;
> -	dma_addr_t *dma_address;
> -	struct dma_fence *fence;
> -	uint64_t src_addr, dst_addr;
> -	uint64_t flags;
> -	int r;
> -
> -	BUG_ON(adev->mman.buffer_funcs->copy_max_bytes <
> -	       AMDGPU_GTT_MAX_TRANSFER_SIZE * 8);
> -
> -	*addr =3D adev->gmc.gart_start;
> -	*addr +=3D (u64)window * AMDGPU_GTT_MAX_TRANSFER_SIZE *
> -		AMDGPU_GPU_PAGE_SIZE;
> -
> -	num_dw =3D ALIGN(adev->mman.buffer_funcs->copy_num_dw, 8);
> -	num_bytes =3D num_pages * 8;
> -
> -	r =3D amdgpu_job_alloc_with_ib(adev, num_dw * 4 + num_bytes, &job);
> -	if (r)
> -		return r;
> -
> -	src_addr =3D num_dw * 4;
> -	src_addr +=3D job->ibs[0].gpu_addr;
> -
> -	dst_addr =3D amdgpu_bo_gpu_offset(adev->gart.bo);
> -	dst_addr +=3D window * AMDGPU_GTT_MAX_TRANSFER_SIZE * 8;
> -	amdgpu_emit_copy_buffer(adev, &job->ibs[0], src_addr,
> -				dst_addr, num_bytes, false);
> -
> -	amdgpu_ring_pad_ib(ring, &job->ibs[0]);
> -	WARN_ON(job->ibs[0].length_dw > num_dw);
> -
> -	dma_address =3D &gtt->ttm.dma_address[offset >> PAGE_SHIFT];
> -	flags =3D amdgpu_ttm_tt_pte_flags(adev, ttm, mem);
> -	if (tmz)
> -		flags |=3D AMDGPU_PTE_TMZ;
> -
> -	r =3D amdgpu_gart_map(adev, 0, num_pages, dma_address, flags,
> -			    &job->ibs[0].ptr[num_dw]);
> -	if (r)
> -		goto error_free;
> -
> -	r =3D amdgpu_job_submit(job, &adev->mman.entity,
> -			      AMDGPU_FENCE_OWNER_UNDEFINED, &fence);
> -	if (r)
> -		goto error_free;
> -
> -	dma_fence_put(fence);
> -
> -	return r;
> -
> -error_free:
> -	amdgpu_job_free(job);
> -	return r;
> -}
> -
>  int amdgpu_copy_buffer(struct amdgpu_ring *ring, uint64_t src_offset,
>  		       uint64_t dst_offset, uint32_t byte_count,
>  		       struct dma_resv *resv,
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_ttm.h
> index 21182caade21..11c0e79e7106 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
> @@ -89,8 +89,8 @@ int amdgpu_copy_buffer(struct amdgpu_ring *ring, uint64=
_t src_offset,
>  		       struct dma_fence **fence, bool direct_submit,
>  		       bool vm_needs_flush, bool tmz);
>  int amdgpu_ttm_copy_mem_to_mem(struct amdgpu_device *adev,
> -			       struct amdgpu_copy_mem *src,
> -			       struct amdgpu_copy_mem *dst,
> +			       const struct amdgpu_copy_mem *src,
> +			       const struct amdgpu_copy_mem *dst,
>  			       uint64_t size, bool tmz,
>  			       struct dma_resv *resv,
>  			       struct dma_fence **f);
> -- =

> 2.14.1
> =

> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flists=
.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=3D02%7C01%7Cray.hu=
ang%40amd.com%7C6997dac18dfc4e64aac708d7ce788068%7C3dd8961fe4884e608e11a82d=
994e183d%7C0%7C0%7C637204889261960280&amp;sdata=3DITH%2BUhbQHQH6%2FdxzObUfb=
UIY5rlZiz7TJ4epsohgBMM%3D&amp;reserved=3D0
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
