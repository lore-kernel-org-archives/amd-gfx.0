Return-Path: <SRS0=WaPU=7J=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAB84C433DF
	for <amd-gfx@archiver.kernel.org>; Wed, 27 May 2020 07:16:07 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7B7BA208B8
	for <amd-gfx@archiver.kernel.org>; Wed, 27 May 2020 07:16:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="GAmK3J9Y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7B7BA208B8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 148EB6E291;
	Wed, 27 May 2020 07:15:49 +0000 (UTC)
Received: from hqnvemgate24.nvidia.com (hqnvemgate24.nvidia.com
 [216.228.121.143])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B9F7E6E290;
 Tue, 26 May 2020 22:57:46 +0000 (UTC)
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by
 hqnvemgate24.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
 id <B5ecd9e910000>; Tue, 26 May 2020 15:56:17 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
 by hqpgpgate101.nvidia.com (PGP Universal service);
 Tue, 26 May 2020 15:57:46 -0700
X-PGP-Universal: processed;
 by hqpgpgate101.nvidia.com on Tue, 26 May 2020 15:57:46 -0700
Received: from [10.2.50.17] (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 26 May
 2020 22:57:45 +0000
Subject: Re: [PATCH] drm/radeon: Convert get_user_pages() --> pin_user_pages()
To: Souptick Joarder <jrdr.linux@gmail.com>, <alexander.deucher@amd.com>,
 <christian.koenig@amd.com>, <David1.Zhou@amd.com>, <daniel@ffwll.ch>
References: <1590526802-3008-1-git-send-email-jrdr.linux@gmail.com>
X-Nvconfidentiality: public
From: John Hubbard <jhubbard@nvidia.com>
Message-ID: <69a033cf-63b2-7da6-6a5e-a5bbc94b8afb@nvidia.com>
Date: Tue, 26 May 2020 15:57:45 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.1
MIME-Version: 1.0
In-Reply-To: <1590526802-3008-1-git-send-email-jrdr.linux@gmail.com>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL101.nvidia.com (172.20.187.10) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Language: en-US
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
 t=1590533777; bh=+/fm5fCUttIpqWTs0jSX13YUVmAx0K1Rl+iVpdhLRU4=;
 h=X-PGP-Universal:Subject:To:CC:References:X-Nvconfidentiality:From:
 Message-ID:Date:User-Agent:MIME-Version:In-Reply-To:
 X-Originating-IP:X-ClientProxiedBy:Content-Type:Content-Language:
 Content-Transfer-Encoding;
 b=GAmK3J9YLRYobQGF3pU5h7D1OHgDb3X9cRCMTdfTrpn9a6Ug+ktStJkaSedHNhev7
 Fo0vLXo87hVswKPIZrVmA4Qad4UngVJEtHMrQH6kwS9m4O6rMu72TLsc0S0AgpXtp0
 6YrG8FclCWX5vGNFF0Z9qZftM0wEKd9HoofGhsVFt/HwaXv+MgZhVZTAdTs1Xfnfbv
 kVSbGn0HLF8g3M/GXt6hCipT4+nlfZjlc+fjVw48lSwCraUg53VW+Jbc/m5oQrP4h+
 /0B7f5m2/ezoX/4zBj0oJOW8iGBUcdUjgFfggXIl8HMpaNNy0dCV3q1BwLksAfrQ/w
 3HQlFGHaa5r1w==
X-Mailman-Approved-At: Wed, 27 May 2020 07:15:48 +0000
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
Cc: dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On 2020-05-26 14:00, Souptick Joarder wrote:
> This code was using get_user_pages(), in a "Case 2" scenario
> (DMA/RDMA), using the categorization from [1]. That means that it's
> time to convert the get_user_pages() + release_pages() calls to
> pin_user_pages() + unpin_user_pages() calls.
> 
> There is some helpful background in [2]: basically, this is a small
> part of fixing a long-standing disconnect between pinning pages, and
> file systems' use of those pages.
> 
> [1] Documentation/core-api/pin_user_pages.rst
> 
> [2] "Explicit pinning of user-space pages":
>      https://lwn.net/Articles/807108/
> 
> Signed-off-by: Souptick Joarder <jrdr.linux@gmail.com>
> Cc: John Hubbard <jhubbard@nvidia.com>
> 
> Hi,
> 
> I'm compile tested this, but unable to run-time test, so any testing
> help is much appriciated.
> ---
>   drivers/gpu/drm/radeon/radeon_ttm.c | 6 +++---
>   1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/gpu/drm/radeon/radeon_ttm.c b/drivers/gpu/drm/radeon/radeon_ttm.c
> index 5d50c9e..e927de2 100644
> --- a/drivers/gpu/drm/radeon/radeon_ttm.c
> +++ b/drivers/gpu/drm/radeon/radeon_ttm.c
> @@ -506,7 +506,7 @@ static int radeon_ttm_tt_pin_userptr(struct ttm_tt *ttm)
>   		uint64_t userptr = gtt->userptr + pinned * PAGE_SIZE;
>   		struct page **pages = ttm->pages + pinned;
>   
> -		r = get_user_pages(userptr, num_pages, write ? FOLL_WRITE : 0,
> +		r = pin_user_pages(userptr, num_pages, write ? FOLL_WRITE : 0,
>   				   pages, NULL);
>   		if (r < 0)
>   			goto release_pages;
> @@ -535,7 +535,7 @@ static int radeon_ttm_tt_pin_userptr(struct ttm_tt *ttm)
>   	kfree(ttm->sg);
>   
>   release_pages:
> -	release_pages(ttm->pages, pinned);
> +	unpin_user_pages(ttm->pages, pinned);
>   	return r;
>   }
>   
> @@ -562,7 +562,7 @@ static void radeon_ttm_tt_unpin_userptr(struct ttm_tt *ttm)
>   			set_page_dirty(page);


Maybe we also need a preceding patch, to fix the above? It should be
set_page_dirty_lock(), rather than set_page_dirty(), unless I'm overlooking
something (which is very possible!).

Either way, from a tunnel vision perspective of changing gup to pup, this
looks good to me, so

     Acked-by: John Hubbard <jhubbard@nvidia.com>


thanks,
-- 
John Hubbard
NVIDIA

>   
>   		mark_page_accessed(page);
> -		put_page(page);
> +		unpin_user_page(page);
>   	}
>   
>   	sg_free_table(ttm->sg);
> 

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
