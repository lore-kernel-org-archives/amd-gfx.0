Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61443C433FE
	for <amd-gfx@archiver.kernel.org>; Mon,  7 Feb 2022 19:35:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CF28E10F95A;
	Mon,  7 Feb 2022 19:35:56 +0000 (UTC)
Received: from mail-qk1-x72e.google.com (mail-qk1-x72e.google.com
 [IPv6:2607:f8b0:4864:20::72e])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 779FA10F8E7
 for <amd-gfx@lists.freedesktop.org>; Mon,  7 Feb 2022 19:26:49 +0000 (UTC)
Received: by mail-qk1-x72e.google.com with SMTP id bs32so11871092qkb.1
 for <amd-gfx@lists.freedesktop.org>; Mon, 07 Feb 2022 11:26:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ziepe.ca; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=bGzAS0zKkWkFPCiUJqrRhTBAlrJP3SGf1MGlPyahzN4=;
 b=b7ELmtzNyf/nrudljsQzl4Q1Js/C7bJel76vjls1xYAgKYUp0D32NW/dwCQI91vZZP
 cXbYYhEP/g8elhxNJkVvAoFewT4/BqI63tG4dQgRBW68M7alExU2eUsV3nwL+RRGhNfV
 j9OssUbyMS/ts/M6+OwPFFARzPDqKR87URSREqouyR+yUBPPCOc+h8b8yGuU3ej+D/xM
 yigD/3UGPd7ytRh96Y0Q0EKXaGboDozlOgbEE8YSvDdrFF+CXBdAOzxWkzfsUC5OZ96L
 FougQ7rtCxrXPxFtxmHqPYYsSOKmfZn62Sni/waJLdqf1/0D0HpcPN3YMwknPx6e2shw
 Hl0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=bGzAS0zKkWkFPCiUJqrRhTBAlrJP3SGf1MGlPyahzN4=;
 b=vC/EkDAp29DpC4+75p01WBmRZmUkN8JX/zAlx6vlzDXtx4U9+tGi7jnw7XM2nK7Adc
 kHhXuNup7rOxoejsjsA/IalSw03IZGGplDXa0fm1vaaPN6VkwxxJ8LhLgChPy7jdSc5G
 kpJgEiixeaX8x6Z5bQ+lucyeYvLDuqu9gcFkX2H4iSqIHaOlaXI70o3ehDJc/dIqOtff
 EvbPBM02p+FH5lU7fqO5fhYBjJoDgOJs7F8x/6POrExQmxdEEIpghDrUj71A0G7W8Zbk
 mcndvg2AhfEscLelFcxQHnXrwRF74paA0wwELJWbgpGhUeH3YEGBx8knUb3mjFYIqW4p
 /+RA==
X-Gm-Message-State: AOAM5319vK22xpy3438ayNPVeKwwogoeLuBbd5+RsyEWufuubufXuKbb
 oyKyauc35mVr1/kZbovEGqOw8w==
X-Google-Smtp-Source: ABdhPJyr6K2wB/TmouPqeHofF9/cBL8QhnN30S2Z0xEYqLSWtmQW56XluhEWaS6dhmSL4EVhM8SlGg==
X-Received: by 2002:a05:620a:1204:: with SMTP id
 u4mr761415qkj.707.1644262008607; 
 Mon, 07 Feb 2022 11:26:48 -0800 (PST)
Received: from ziepe.ca
 (hlfxns017vw-142-162-113-129.dhcp-dynamic.fibreop.ns.bellaliant.net.
 [142.162.113.129])
 by smtp.gmail.com with ESMTPSA id w8sm5913769qti.21.2022.02.07.11.26.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 07 Feb 2022 11:26:47 -0800 (PST)
Received: from jgg by mlx with local (Exim 4.94) (envelope-from <jgg@ziepe.ca>)
 id 1nH9ex-000HvP-5E; Mon, 07 Feb 2022 15:26:47 -0400
Date: Mon, 7 Feb 2022 15:26:47 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 2/8] mm: remove the __KERNEL__ guard from <linux/mm.h>
Message-ID: <20220207192647.GD49147@ziepe.ca>
References: <20220207063249.1833066-1-hch@lst.de>
 <20220207063249.1833066-3-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220207063249.1833066-3-hch@lst.de>
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

On Mon, Feb 07, 2022 at 07:32:43AM +0100, Christoph Hellwig wrote:
> __KERNEL__ ifdefs don't make sense outside of include/uapi/.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  include/linux/mm.h | 4 ----
>  1 file changed, 4 deletions(-)

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason
