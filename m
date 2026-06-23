Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80363CD98F2
	for <amd-gfx@archiver.kernel.org>; Tue, 23 Jun 2026 14:08:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 09DB510E73C;
	Tue, 23 Jun 2026 14:08:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="dhXI4Jk0";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9DED910E73C
 for <amd-gfx@lists.freedesktop.org>; Tue, 23 Jun 2026 14:08:17 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 2628643667;
 Tue, 23 Jun 2026 14:08:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9CFA01F00A3A;
 Tue, 23 Jun 2026 14:08:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1782223697;
 bh=8ssEs1fZzIbQ5y84qIP7mgPuP3e9LyAYeFOzE9KW3vI=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To;
 b=dhXI4Jk0zBsQe5iIIl0h/3BqeQU4u0rltZdT1iMd/Jmm92+8VV3c+YbbR1rhcX6Hg
 SEbFkEstrgaogvY08GdlGZGbxYR/EZn/5TKFY/PTI8bKQAZK3oGSPAGyQDX3h86la4
 0co/PhdJw7NRrtTIWTOgpOizLgdgNGMroOy6rLrJm/ILXzeZPScf5My7eZtaPafj+A
 Ew6TdO4Of73TqwBpw+XpOyTMzmdU2i0gFDDSub8f+/IHl0bHpLM2aoF6wdcnkCdZGd
 mgEp2oEB0UTub5ekcPV1zCg+blWSI3NqMr3oRjcN5OLhgMHM/4PFf0HYWSDZTo5vXe
 4lTqrKHxpy/vg==
Message-ID: <35aa34d8-193f-4011-becf-3de7a3dcbdb2@kernel.org>
Date: Tue, 23 Jun 2026 07:08:14 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amd/display: use kvzalloc to allocate struct dc
To: Honglei Huang <honghuan@amd.com>, harry.wentland@amd.com,
 sunpeng.li@amd.com, siqueira@igalia.com, Christian.Koenig@amd.com,
 amd-gfx@lists.freedesktop.org
Cc: Alexander.Deucher@amd.com, Ray.Huang@amd.com
References: <20260623065635.2525331-1-honghuan@amd.com>
Content-Language: en-US
From: Mario Limonciello <superm1@kernel.org>
In-Reply-To: <20260623065635.2525331-1-honghuan@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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



On 6/22/26 23:56, Honglei Huang wrote:
> struct dc has grown large over time (most of it the two inlined
> dc_scratch_space copies) and now sits close to the page allocator's 4 MiB
> contiguous allocation limit. Its actual size is not fixed by the source
> alone, it also depends on the compiler and the .configk, so it can
> easily cross 4 MiB, e.g. with a newer GCC or a config change, and once it
> does dc_create() fails.
> 
> dc_create() allocates it with kzalloc(). Once struct dc exceeds 4 MiB the
> request is rounded up to order 11 (8 MiB), which is above MAX_PAGE_ORDER,
> so the page allocator warns and returns NULL. dc_create() then fails, DM
> init fails and amdgpu probe aborts with -EINVAL:
> 
>    WARNING: mm/page_alloc.c:5197 at __alloc_frozen_pages_noprof+0x2f9/0x380
>    RSI: ...000b   RBP: ...000b      <- order = 11 (8 MiB)
>     __kmalloc_large_noprof+0x1e/0xc0
>     dc_create+0x38/0x660 [amdgpu]
>     amdgpu_dm_init+0x2d9/0x510 [amdgpu]
>     dm_hw_init+0x1b/0x90 [amdgpu]
>    amdgpu 0000:03:00.0: hw_init of IP block <dm> failed -22
>    amdgpu 0000:03:00.0: probe with driver amdgpu failed with error -22
> 
> struct dc is software only state, never DMAed and only kept as an opaque
> pointer, so it needs no physically contiguous memory. Use kvzalloc()/
> kvfree() so it falls back to vmalloc(), removing the dependency on
> MAX_PAGE_ORDER. The underlying bloat of struct dc should be addressed
> separately.
> 

Cc: stable@vger.kernel.org
Reviewed-by: Mario Limonciello (AMD) <superm1@kernel.org>
Closes: https://gitlab.freedesktop.org/drm/amd/-/work_items/5406

> Signed-off-by: Honglei Huang <honghuan@amd.com>
> ---
>   drivers/gpu/drm/amd/display/dc/core/dc.c | 6 +++---
>   1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd/display/dc/core/dc.c
> index b3530fbf32f..65bd927435e 100644
> --- a/drivers/gpu/drm/amd/display/dc/core/dc.c
> +++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
> @@ -1507,7 +1507,7 @@ static void disable_vbios_mode_if_required(
>   
>   struct dc *dc_create(const struct dc_init_data *init_params)
>   {
> -	struct dc *dc = kzalloc_obj(*dc);
> +	struct dc *dc = kvzalloc_obj(*dc);
>   	unsigned int full_pipe_count;
>   
>   	if (!dc)
> @@ -1555,7 +1555,7 @@ struct dc *dc_create(const struct dc_init_data *init_params)
>   
>   destruct_dc:
>   	dc_destruct(dc);
> -	kfree(dc);
> +	kvfree(dc);
>   	return NULL;
>   }
>   
> @@ -1604,7 +1604,7 @@ void dc_deinit_callbacks(struct dc *dc)
>   void dc_destroy(struct dc **dc)
>   {
>   	dc_destruct(*dc);
> -	kfree(*dc);
> +	kvfree(*dc);
>   	*dc = NULL;
>   }
>   

