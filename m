Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD27AC433F5
	for <amd-gfx@archiver.kernel.org>; Mon,  7 Feb 2022 19:35:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EAEBE10F916;
	Mon,  7 Feb 2022 19:35:52 +0000 (UTC)
Received: from mail-qv1-xf34.google.com (mail-qv1-xf34.google.com
 [IPv6:2607:f8b0:4864:20::f34])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 732A210F80B
 for <amd-gfx@lists.freedesktop.org>; Mon,  7 Feb 2022 19:35:10 +0000 (UTC)
Received: by mail-qv1-xf34.google.com with SMTP id a19so5470213qvm.4
 for <amd-gfx@lists.freedesktop.org>; Mon, 07 Feb 2022 11:35:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ziepe.ca; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=rboH21WjTo7Zpin6WU8ENnQ0jpp7u5mio4o8y61h1qA=;
 b=VXh06X+F+pn59Qpun2TvClz1m9HjYoHgaKOI4lztMUBuiGjL99BTi+BawyYvV0b0yn
 9cSLWqxROo0MXIKlUdGoc9EE7z86T+5wHR+ArNTi5/pxBOI4IWPMYAGwHGhxndX7GpTZ
 fSLPo9Dt2nuunse7tKeQTFKIcNt0CE4F9KzzI4ti/AgzATLEA1o9kXR4ml55Lqmm3Yhc
 wbAAtoduBxENkPGmrIt8sbv6drZp6l+PHJ57vTSVfC3pA1NN7u0WuhjPEL0YmplkLBQR
 SW4HkKGx0mKB2zSYzcqNdqN99/smutm6o5outMhJEioQPVTN6gdzMAHSMaOhfZa5HAKv
 HEcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=rboH21WjTo7Zpin6WU8ENnQ0jpp7u5mio4o8y61h1qA=;
 b=Owwhr7fZlN5Qwtx04lNPdLwn3XsAC1XzIG7tjbj0eFla+Hg576noKmTWT8UFeeGVlJ
 viLR72kJ2ietvyC6XoEHT6SkWDKLMkxUCSY3N6o5mIX7r4kbdSUkAC/vjbCZed0th3pG
 WD1atySWNPWdxGvxr6ewgipd98c4gwi14+EOE4LY4IdXTTbZLezArUl/l6to0e6SNtvL
 J1uGKN2PCbiAbZXsyeqrFTsKbaNz9AwhA2OjLWyFg03Eo7sd3dV3alUcOmwQ2oE2txRw
 p+f05eOlW+y0gPyB44DRyHo8qeCQr14Si4+R/t7Qdkek8e+ahqw7eZvzGJKHE/DwYpL7
 gVvg==
X-Gm-Message-State: AOAM531BwsZPVWFtbReg+Hi4KG+DQ3e7Ud5DItfrkMKEBX+m+sAOAPL2
 4hrTxRjOlnbMb/DMxUWUFADXfQ==
X-Google-Smtp-Source: ABdhPJwMTfVdQUHipluh+Ohvh/JxuUZnOnGCSsmXZVjjmoMxCtKJINJPPq28Adoz05obvbxhEw7l+Q==
X-Received: by 2002:ad4:5942:: with SMTP id eo2mr803626qvb.7.1644262509546;
 Mon, 07 Feb 2022 11:35:09 -0800 (PST)
Received: from ziepe.ca
 (hlfxns017vw-142-162-113-129.dhcp-dynamic.fibreop.ns.bellaliant.net.
 [142.162.113.129])
 by smtp.gmail.com with ESMTPSA id bj24sm5684465qkb.115.2022.02.07.11.35.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 07 Feb 2022 11:35:09 -0800 (PST)
Received: from jgg by mlx with local (Exim 4.94) (envelope-from <jgg@ziepe.ca>)
 id 1nH9n2-000I62-Fa; Mon, 07 Feb 2022 15:35:08 -0400
Date: Mon, 7 Feb 2022 15:35:08 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 6/8] mm: don't include <linux/memremap.h> in <linux/mm.h>
Message-ID: <20220207193508.GG49147@ziepe.ca>
References: <20220207063249.1833066-1-hch@lst.de>
 <20220207063249.1833066-7-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220207063249.1833066-7-hch@lst.de>
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

On Mon, Feb 07, 2022 at 07:32:47AM +0100, Christoph Hellwig wrote:
> Move the check for the actual pgmap types that need the free at refcount
> one behavior into the out of line helper, and thus avoid the need to
> pull memremap.h into mm.h.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  arch/arm64/mm/mmu.c                    |  1 +
>  drivers/gpu/drm/amd/amdkfd/kfd_priv.h  |  1 +
>  drivers/gpu/drm/drm_cache.c            |  2 +-
>  drivers/gpu/drm/nouveau/nouveau_dmem.c |  1 +
>  drivers/gpu/drm/nouveau/nouveau_svm.c  |  1 +
>  drivers/infiniband/core/rw.c           |  1 +
>  drivers/nvdimm/pmem.h                  |  1 +
>  drivers/nvme/host/pci.c                |  1 +
>  drivers/nvme/target/io-cmd-bdev.c      |  1 +
>  fs/fuse/virtio_fs.c                    |  1 +
>  include/linux/memremap.h               | 18 ++++++++++++++++++
>  include/linux/mm.h                     | 20 --------------------
>  lib/test_hmm.c                         |  1 +
>  mm/memremap.c                          |  6 +++++-
>  14 files changed, 34 insertions(+), 22 deletions(-)

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason
