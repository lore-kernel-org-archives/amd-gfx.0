Return-Path: <SRS0=Hoyj=6G=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5658FC5518B
	for <amd-gfx@archiver.kernel.org>; Wed, 22 Apr 2020 06:55:32 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2B652206D9
	for <amd-gfx@archiver.kernel.org>; Wed, 22 Apr 2020 06:55:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2B652206D9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7962F6E9CC;
	Wed, 22 Apr 2020 06:55:00 +0000 (UTC)
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 337046E4E8;
 Wed, 22 Apr 2020 06:03:33 +0000 (UTC)
Received: by verein.lst.de (Postfix, from userid 2407)
 id F3FEA68C7B; Wed, 22 Apr 2020 08:03:29 +0200 (CEST)
Date: Wed, 22 Apr 2020 08:03:29 +0200
From: Christoph Hellwig <hch@lst.de>
To: Jason Gunthorpe <jgg@ziepe.ca>
Subject: Re: [PATCH hmm 5/5] mm/hmm: remove the customizable pfn format
 from hmm_range_fault
Message-ID: <20200422060329.GD22366@lst.de>
References: <0-v1-4eb72686de3c+5062-hmm_no_flags_jgg@mellanox.com>
 <5-v1-4eb72686de3c+5062-hmm_no_flags_jgg@mellanox.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <5-v1-4eb72686de3c+5062-hmm_no_flags_jgg@mellanox.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Mailman-Approved-At: Wed, 22 Apr 2020 06:54:54 +0000
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
Cc: "David \(ChunMing\) Zhou" <David1.Zhou@amd.com>,
 Ralph Campbell <rcampbell@nvidia.com>, John Hubbard <jhubbard@nvidia.com>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 amd-gfx@lists.freedesktop.org, Christoph Hellwig <hch@lst.de>,
 linux-mm@kvack.org, =?iso-8859-1?B?Suly9G1l?= Glisse <jglisse@redhat.com>,
 Ben Skeggs <bskeggs@redhat.com>, nouveau@lists.freedesktop.org,
 Alex Deucher <alexander.deucher@amd.com>, "Kuehling,
 Felix" <Felix.Kuehling@amd.com>,
 Niranjana Vishwanathapura <niranjana.vishwanathapura@intel.com>,
 intel-gfx@lists.freedesktop.org,
 Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>



On Tue, Apr 21, 2020 at 09:21:46PM -0300, Jason Gunthorpe wrote:
> +void nouveau_hmm_convert_pfn(struct nouveau_drm *drm, struct hmm_range *range,
> +			     u64 *ioctl_addr)
>  {
>  	unsigned long i, npages;
>  
> +	/*
> +	 * The ioctl_addr prepared here is passed through nvif_object_ioctl()
> +	 * to an eventual DMA map on some call chain like:
> +	 *    nouveau_svm_fault():
> +	 *      args.i.m.method = NVIF_VMM_V0_PFNMAP
> +	 *      nouveau_range_fault()
> +	 *       nvif_object_ioctl()
> +	 *        client->driver->ioctl()
> +	 *           struct nvif_driver nvif_driver_nvkm:
> +	 *             .ioctl = nvkm_client_ioctl
> +	 *            nvkm_ioctl()
> +	 *             nvkm_ioctl_path()
> +	 *               nvkm_ioctl_v0[type].func(..)
> +	 *               nvkm_ioctl_mthd()
> +	 *                nvkm_object_mthd()
> +	 *                   struct nvkm_object_func nvkm_uvmm:
> +	 *                     .mthd = nvkm_uvmm_mthd
> +	 *                    nvkm_uvmm_mthd()
> +	 *                     nvkm_uvmm_mthd_pfnmap()
> +	 *                      nvkm_vmm_pfn_map()
> +	 *                       nvkm_vmm_ptes_get_map()
> +	 *                        func == gp100_vmm_pgt_pfn
> +	 *                         struct nvkm_vmm_desc_func gp100_vmm_desc_spt:
> +	 *                           .pfn = gp100_vmm_pgt_pfn
> +	 *                          nvkm_vmm_iter()
> +	 *                           REF_PTES == func == gp100_vmm_pgt_pfn()
> +	 *			      dma_map_page()
> +	 *
> +	 * This is all just encoding the internal hmm reprensetation into a
> +	 * different nouveau internal representation.
> +	 */

Nice callchain from hell..  Unfortunately such "code listings" tend to
get out of date very quickly, so I'm not sure it is worth keeping in
the code.  What would be really worthile is consolidating the two
different sets of defines (NVIF_VMM_PFNMAP_V0_ vs NVKM_VMM_PFN_)
to make the code a little easier to follow.

>  	npages = (range->end - range->start) >> PAGE_SHIFT;
>  	for (i = 0; i < npages; ++i) {
>  		struct page *page;
>  
> +		if (!(range->hmm_pfns[i] & HMM_PFN_VALID)) {
> +			ioctl_addr[i] = 0;
>  			continue;
> +		}

Can't we rely on the caller pre-zeroing the array?

> +		page = hmm_pfn_to_page(range->hmm_pfns[i]);
> +		if (is_device_private_page(page))
> +			ioctl_addr[i] = nouveau_dmem_page_addr(page) |
> +					NVIF_VMM_PFNMAP_V0_V |
> +					NVIF_VMM_PFNMAP_V0_VRAM;
> +		else
> +			ioctl_addr[i] = page_to_phys(page) |
> +					NVIF_VMM_PFNMAP_V0_V |
> +					NVIF_VMM_PFNMAP_V0_HOST;
> +		if (range->hmm_pfns[i] & HMM_PFN_WRITE)
> +			ioctl_addr[i] |= NVIF_VMM_PFNMAP_V0_W;

Now that this routine isn't really device memory specific any more, I
wonder if it should move to nouveau_svm.c.
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
