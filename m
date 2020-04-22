Return-Path: <SRS0=Hoyj=6G=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3B02C54FCB
	for <amd-gfx@archiver.kernel.org>; Wed, 22 Apr 2020 13:13:37 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 85BF520706
	for <amd-gfx@archiver.kernel.org>; Wed, 22 Apr 2020 13:13:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="hBw8mqtc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 85BF520706
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 756EF6E405;
	Wed, 22 Apr 2020 13:13:35 +0000 (UTC)
Received: from mail-qv1-xf43.google.com (mail-qv1-xf43.google.com
 [IPv6:2607:f8b0:4864:20::f43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B97586E402
 for <amd-gfx@lists.freedesktop.org>; Wed, 22 Apr 2020 12:39:13 +0000 (UTC)
Received: by mail-qv1-xf43.google.com with SMTP id di6so712753qvb.10
 for <amd-gfx@lists.freedesktop.org>; Wed, 22 Apr 2020 05:39:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ziepe.ca; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=iT2l1J0Dw3okJWfIDfIHP+VXyr+NSCzlVVz/2ADc/qE=;
 b=hBw8mqtc970Us/4260DEmO5MG0Tj4jDDe+CnrIkEvmuKjPVcisES4Kj6cv7V/PtYyo
 BQZJBqZNrw6i83kgXfUd2A0y+l3J/16xM0HkrF3HFtBL5L5eFJyMyp8UuKHp/ZnnDVQu
 eDlemguK6yvwN5yYMtqTKPheoXcwmj63LFQk/q7ZKQtKxUrh6epwY1R19VAJvTuEWxrk
 s64aJkzIA3d2LMWYlHLnqlwjwLRen5ZjtVVniFagjFWCRlWf8wj/SWJo8FZQHs42NZ7r
 da3CC+XYYJgdMgLe9zp5sD8kRMzKEy5gsmJ77mCRj7xOaNDoy6bTvhUscJoDUawILgvh
 QmTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=iT2l1J0Dw3okJWfIDfIHP+VXyr+NSCzlVVz/2ADc/qE=;
 b=fH+/r+rJCN5M0Savqi3/APuVWeqWPI35JkRHY7Ko5l3C9KfZfoGzLtdoJM0Bx9Zudn
 1mszHeoDPocP/oIVo0e9NUirzIu0Bdf825Gzj1egfyUzgrA5E3ibjQ1MlVhmIgS9iZ7m
 kixVv3zpQVroneg4OVh+kZ3qiOi9bNM2sdxVEZVtPa9avSR2GTAQjrBqYLvh/5T/1AiN
 d8PWo3ZMn7JOsliFsg70bRXXpS/sWkI9J5pP7EROYkL2e0B247/9oUOM8inOWVP6brK5
 tjqjrR/b0Ydudp9kOaATl19eiZlMfE67PZjoLhjKccBEdabOjtal0RF53L7D1+dwBi7u
 DqTw==
X-Gm-Message-State: AGi0Pub2/D09NTplaFx3q5v74OGDwZ+nntu5VqhZ+mORpOusqibQtaj1
 zzD/yJDIDkGbcfAwTMwO9b7D3Q==
X-Google-Smtp-Source: APiQypIQwpWEBc+W8O45Mbgt1/Nc3xO9DTWMuz03GmoYUsF1958LKHcE8AUKRxmOkkqb+5DrbeZ/zg==
X-Received: by 2002:a0c:da87:: with SMTP id z7mr24708949qvj.141.1587559152840; 
 Wed, 22 Apr 2020 05:39:12 -0700 (PDT)
Received: from ziepe.ca
 (hlfxns017vw-142-68-57-212.dhcp-dynamic.fibreop.ns.bellaliant.net.
 [142.68.57.212])
 by smtp.gmail.com with ESMTPSA id i5sm3692472qki.42.2020.04.22.05.39.11
 (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
 Wed, 22 Apr 2020 05:39:11 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
 (envelope-from <jgg@ziepe.ca>)
 id 1jREel-00064v-7W; Wed, 22 Apr 2020 09:39:11 -0300
Date: Wed, 22 Apr 2020 09:39:11 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH hmm 5/5] mm/hmm: remove the customizable pfn format from
 hmm_range_fault
Message-ID: <20200422123911.GV26002@ziepe.ca>
References: <0-v1-4eb72686de3c+5062-hmm_no_flags_jgg@mellanox.com>
 <5-v1-4eb72686de3c+5062-hmm_no_flags_jgg@mellanox.com>
 <20200422060329.GD22366@lst.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200422060329.GD22366@lst.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Mailman-Approved-At: Wed, 22 Apr 2020 13:13:34 +0000
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
 amd-gfx@lists.freedesktop.org, linux-mm@kvack.org,
 =?utf-8?B?SsOpcsO0bWU=?= Glisse <jglisse@redhat.com>,
 Ben Skeggs <bskeggs@redhat.com>, nouveau@lists.freedesktop.org,
 Alex Deucher <alexander.deucher@amd.com>, "Kuehling,
 Felix" <Felix.Kuehling@amd.com>,
 Niranjana Vishwanathapura <niranjana.vishwanathapura@intel.com>,
 intel-gfx@lists.freedesktop.org,
 Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Wed, Apr 22, 2020 at 08:03:29AM +0200, Christoph Hellwig wrote:
> 
> 
> On Tue, Apr 21, 2020 at 09:21:46PM -0300, Jason Gunthorpe wrote:
> > +void nouveau_hmm_convert_pfn(struct nouveau_drm *drm, struct hmm_range *range,
> > +			     u64 *ioctl_addr)
> >  {
> >  	unsigned long i, npages;
> >  
> > +	/*
> > +	 * The ioctl_addr prepared here is passed through nvif_object_ioctl()
> > +	 * to an eventual DMA map on some call chain like:
> > +	 *    nouveau_svm_fault():
> > +	 *      args.i.m.method = NVIF_VMM_V0_PFNMAP
> > +	 *      nouveau_range_fault()
> > +	 *       nvif_object_ioctl()
> > +	 *        client->driver->ioctl()
> > +	 *           struct nvif_driver nvif_driver_nvkm:
> > +	 *             .ioctl = nvkm_client_ioctl
> > +	 *            nvkm_ioctl()
> > +	 *             nvkm_ioctl_path()
> > +	 *               nvkm_ioctl_v0[type].func(..)
> > +	 *               nvkm_ioctl_mthd()
> > +	 *                nvkm_object_mthd()
> > +	 *                   struct nvkm_object_func nvkm_uvmm:
> > +	 *                     .mthd = nvkm_uvmm_mthd
> > +	 *                    nvkm_uvmm_mthd()
> > +	 *                     nvkm_uvmm_mthd_pfnmap()
> > +	 *                      nvkm_vmm_pfn_map()
> > +	 *                       nvkm_vmm_ptes_get_map()
> > +	 *                        func == gp100_vmm_pgt_pfn
> > +	 *                         struct nvkm_vmm_desc_func gp100_vmm_desc_spt:
> > +	 *                           .pfn = gp100_vmm_pgt_pfn
> > +	 *                          nvkm_vmm_iter()
> > +	 *                           REF_PTES == func == gp100_vmm_pgt_pfn()
> > +	 *			      dma_map_page()
> > +	 *
> > +	 * This is all just encoding the internal hmm reprensetation into a
> > +	 * different nouveau internal representation.
> > +	 */
> 
> Nice callchain from hell..  Unfortunately such "code listings" tend to
> get out of date very quickly, so I'm not sure it is worth keeping in
> the code.  What would be really worthile is consolidating the two
> different sets of defines (NVIF_VMM_PFNMAP_V0_ vs NVKM_VMM_PFN_)
> to make the code a little easier to follow.

I was mainly concerned that this function is using hmm properly,
becuase it sure looks like it is just forming the CPU physical address
into a HW specific data. But it turns out it is just an internal data
for some other code and the dma_map is impossibly far away

It took forever to find, I figured I'd leave a hint for the next poor
soul that has to look at this.. 

Also, I think it shows there is no 'performance' argument here, if
this path needs more performance the above should be cleaned
before we abuse hmm_range_fault.

Put it in the commit message instead?

> >  	npages = (range->end - range->start) >> PAGE_SHIFT;
> >  	for (i = 0; i < npages; ++i) {
> >  		struct page *page;
> >  
> > +		if (!(range->hmm_pfns[i] & HMM_PFN_VALID)) {
> > +			ioctl_addr[i] = 0;
> >  			continue;
> > +		}
> 
> Can't we rely on the caller pre-zeroing the array?

This ends up as args.phys in nouveau_svm_fault - I didn't see a
zeroing?

I think it makes sense that this routine fully sets the output array
and does not assume pre-initialize

> > +		page = hmm_pfn_to_page(range->hmm_pfns[i]);
> > +		if (is_device_private_page(page))
> > +			ioctl_addr[i] = nouveau_dmem_page_addr(page) |
> > +					NVIF_VMM_PFNMAP_V0_V |
> > +					NVIF_VMM_PFNMAP_V0_VRAM;
> > +		else
> > +			ioctl_addr[i] = page_to_phys(page) |
> > +					NVIF_VMM_PFNMAP_V0_V |
> > +					NVIF_VMM_PFNMAP_V0_HOST;
> > +		if (range->hmm_pfns[i] & HMM_PFN_WRITE)
> > +			ioctl_addr[i] |= NVIF_VMM_PFNMAP_V0_W;
> 
> Now that this routine isn't really device memory specific any more, I
> wonder if it should move to nouveau_svm.c.

Yes, if we expose nouveau_dmem_page_addr(), I will try it

Thanks,
Jason
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
