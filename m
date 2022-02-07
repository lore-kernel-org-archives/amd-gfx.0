Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25DC1C433EF
	for <amd-gfx@archiver.kernel.org>; Mon,  7 Feb 2022 19:36:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 90FD710F960;
	Mon,  7 Feb 2022 19:35:59 +0000 (UTC)
Received: from mail-qv1-xf35.google.com (mail-qv1-xf35.google.com
 [IPv6:2607:f8b0:4864:20::f35])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8B03B10F80D
 for <amd-gfx@lists.freedesktop.org>; Mon,  7 Feb 2022 19:21:58 +0000 (UTC)
Received: by mail-qv1-xf35.google.com with SMTP id h9so2465910qvm.0
 for <amd-gfx@lists.freedesktop.org>; Mon, 07 Feb 2022 11:21:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ziepe.ca; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=MpROwmI6Qnm2emkziisG5aDXgeJvPxSLNV0Lic7ckQs=;
 b=OaiSuWRoTh89hqFli2OaM/99731kyVjifGW/6GRnhqIbNkn4rqP5cCBkUjKmhiONGA
 DRfaWqoDUSS3IuMSZybn6CxVSz9gReIWR5zHG2jjk1KjqYVDa/9CCxg0tFF3xZ3AN4KM
 IWW23EV/8VVY2qGl9kiFU+8+HFL3FZ5X6K6By2RBakx/Ghc4c95TqRKVwgL78FFsnybj
 gOmsu8PRvUOA7lJpZIzHdbR6U2MiJsL97ZsWs6lb+AZn8w27xJatWjWCvHlr0v+nfzrq
 5FEXre/2zFc0NgKQwTEa1qY6KjXxjGFFZdTM7G5gNDX+6knlEUNvM1LWH4Y4kbABTlQ9
 MW3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=MpROwmI6Qnm2emkziisG5aDXgeJvPxSLNV0Lic7ckQs=;
 b=C6optXmclSGosD9aLVqwJSgmscEZTR78aFWhmt/FntwVPWMu1jvvRW08H5KYjXGkZs
 kKmf/3nrw+O/MU/tL9JfgS8VMI+sCXSwMt8Lq028g8FEzRKYAa1ocurLm0RBl2HiqIdy
 Yg1+1cCb5NAQYTYgHTIT9m1jamuG9uWuqXUOwi2mkj8W0seWgrYAW+kxZ9vikgRXTS0t
 HHoX8txFEVMV0gEOJn2Gd9ze9oJzHWTSlfZkcut1uUHU5Ww18KlZPbb3Mx7medhelvac
 Fp4WFgwvJVl9fpJN5vNYPTlRo6TvJbI+vGrqJUCuRN2pF5NExJxjGoTuDa6mCGYOaQga
 kwog==
X-Gm-Message-State: AOAM5323sYxMHT5bMBpTA9J5Ab6pPYElbIcQF1TFbOIwMck6NXP3sMc7
 LzzjqRNMCZ5P+jCI4847OstXPA==
X-Google-Smtp-Source: ABdhPJxhzWQ+13BW3b7rMAkbC+gsglkVidW/xLtoMpCgPLxkDjpi1/nh8Ncg8X/Gh7aVJ+bLlWGexw==
X-Received: by 2002:a05:6214:248a:: with SMTP id
 gi10mr727781qvb.99.1644261717527; 
 Mon, 07 Feb 2022 11:21:57 -0800 (PST)
Received: from ziepe.ca
 (hlfxns017vw-142-162-113-129.dhcp-dynamic.fibreop.ns.bellaliant.net.
 [142.162.113.129])
 by smtp.gmail.com with ESMTPSA id y20sm5819031qta.9.2022.02.07.11.21.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 07 Feb 2022 11:21:56 -0800 (PST)
Received: from jgg by mlx with local (Exim 4.94) (envelope-from <jgg@ziepe.ca>)
 id 1nH9aF-000Hph-TJ; Mon, 07 Feb 2022 15:21:55 -0400
Date: Mon, 7 Feb 2022 15:21:55 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 7/8] mm: remove the extra ZONE_DEVICE struct page refcount
Message-ID: <20220207192155.GB49147@ziepe.ca>
References: <20220207063249.1833066-1-hch@lst.de>
 <20220207063249.1833066-8-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220207063249.1833066-8-hch@lst.de>
X-Mailman-Approved-At: Mon, 07 Feb 2022 19:35:52 +0000
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
Cc: nvdimm@lists.linux.dev, Ralph Campbell <rcampbell@nvidia.com>,
 Alistair Popple <apopple@nvidia.com>, dri-devel@lists.freedesktop.org,
 Karol Herbst <kherbst@redhat.com>, nouveau@lists.freedesktop.org,
 Felix Kuehling <Felix.Kuehling@amd.com>, "Pan, Xinhui" <Xinhui.Pan@amd.com>,
 linux-kernel@vger.kernel.org, amd-gfx@lists.freedesktop.org,
 Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>, linux-mm@kvack.org,
 Ben Skeggs <bskeggs@redhat.com>, Alex Deucher <alexander.deucher@amd.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Logan Gunthorpe <logang@deltatee.com>, Dan Williams <dan.j.williams@intel.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Mon, Feb 07, 2022 at 07:32:48AM +0100, Christoph Hellwig wrote:
> ZONE_DEVICE struct pages have an extra reference count that complicates
> the code for put_page() and several places in the kernel that need to
> check the reference count to see that a page is not being used (gup,
> compaction, migration, etc.). Clean up the code so the reference count
> doesn't need to be treated specially for ZONE_DEVICE pages.
> 
> Note that this excludes the special idle page wakeup for fsdax pages,
> which still happens at refcount 1.  This is a separate issue and will
> be sorted out later.  Given that only fsdax pages require the
> notifiacation when the refcount hits 1 now, the PAGEMAP_OPS Kconfig
> symbol can go away and be replaced with a FS_DAX check for this hook
> in the put_page fastpath.
> 
> Based on an earlier patch from Ralph Campbell <rcampbell@nvidia.com>.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  arch/powerpc/kvm/book3s_hv_uvmem.c       |  1 -
>  drivers/gpu/drm/amd/amdkfd/kfd_migrate.c |  1 -
>  drivers/gpu/drm/nouveau/nouveau_dmem.c   |  1 -
>  fs/Kconfig                               |  1 -
>  include/linux/memremap.h                 | 12 +++--
>  include/linux/mm.h                       |  6 +--
>  lib/test_hmm.c                           |  1 -
>  mm/Kconfig                               |  4 --
>  mm/internal.h                            |  2 +
>  mm/memcontrol.c                          | 11 ++---
>  mm/memremap.c                            | 57 ++++++++----------------
>  mm/migrate.c                             |  6 ---
>  mm/swap.c                                | 16 ++-----
>  13 files changed, 36 insertions(+), 83 deletions(-)

It looks like a good next step to me

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

>  struct dev_pagemap_ops {
>  	/*
> -	 * Called once the page refcount reaches 1.  (ZONE_DEVICE pages never
> -	 * reach 0 refcount unless there is a refcount bug. This allows the
> -	 * device driver to implement its own memory management.)
> +	 * Called once the page refcount reaches 0.  The reference count will be
> +	 * reset to one by the core code after the method is called to prepare
> +	 * for handing out the page again.

I did prefer Ralph's version of this that kept the refcount at 0 while
the page was on the free-list. I hope we can get there again after
later series :)

Jason
