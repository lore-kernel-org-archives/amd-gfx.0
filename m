Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1846EC32771
	for <amd-gfx@archiver.kernel.org>; Mon, 26 Sep 2022 06:31:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 498EC10E534;
	Mon, 26 Sep 2022 06:31:53 +0000 (UTC)
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com
 [IPv6:2a00:1450:4864:20::62c])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7955410E523
 for <amd-gfx@lists.freedesktop.org>; Mon, 26 Sep 2022 06:31:48 +0000 (UTC)
Received: by mail-ej1-x62c.google.com with SMTP id y3so11920280ejc.1
 for <amd-gfx@lists.freedesktop.org>; Sun, 25 Sep 2022 23:31:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date;
 bh=Pker6QghnTzLRDGtX69O9tddF1WLWUB/2Cz5UU35jUw=;
 b=IFXVjOcdT97wu0h/hozrc6QqAbLwhfYr4hCe0a6B3EmHfX8LoMggyFJH80aMZQAg+8
 eX9flMmKqE3qJMDc+UNduToLWDo/eZdTxcLnkkwweH7S+bFPmTbOpLkA5Cef0E2EKhlF
 vE0+0Y3S/02DIVU6XqWP4gUvn4+fo7TrBbpzm05TEO3Cx81QKuXkL93Jz7akLn98kb7M
 3/guTP59HtOLrlCeayUoXJgDjlUZsuT+dPx76piEUnoTlk5FW9gHVOvPZ3d03Sc7YO13
 grSTLozHJ4CF8pzBlBjmqmcxWuUqw8pLAvHflOL0Dml6pTmYxW1M/XrL2WSNCd/bE0DD
 +wzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date;
 bh=Pker6QghnTzLRDGtX69O9tddF1WLWUB/2Cz5UU35jUw=;
 b=OJmnjNAQ8XgI/Z3QJACRWf+6GY/IR5GQT+j4rjn/F9Mntly9VbtZytObKnBjkcG6gA
 Re2VdkzL0W0Uk4BuQsruau1r9rg6tsGa56uMWVzMTEG6OzU+PLE8M3NDcfshs7uHpPpC
 7yO1jlyTB+ETJK9UzJiPq0brTOqUgX5LzghbfBteGpsntZzM93Rxx5DBBjvmf140FRXx
 We6axHuSqzefLWnda71YjjDDYIL4nSX+ZBt0+GNU6OrAzPbFnYQGjyPW+Fb2wQzFJ/OE
 ehX5hoHEgnw1fhxKbUbgs6wPW91L+QgNKZcNq+Ys9WH6IUeGsGAN4BN4cvaYNkEgnpD+
 K4Wg==
X-Gm-Message-State: ACrzQf2m9aAG4MsxDw/BrrEyILwhya9H4sTpyMP60wctKCuYPnOBlxzJ
 yAt8+Laq+Er3AHkIhUidbYCxg7R2Ujw=
X-Google-Smtp-Source: AMsMyM5MCVsYlB6HTe7elF3n9suurIwwvKAOKokk6i70k2kkLndZpsewKifJdD3vIDBsX9xiFgND/Q==
X-Received: by 2002:a17:907:7b9e:b0:783:10cb:2826 with SMTP id
 ne30-20020a1709077b9e00b0078310cb2826mr6946668ejc.208.1664173906944; 
 Sun, 25 Sep 2022 23:31:46 -0700 (PDT)
Received: from ?IPV6:2a02:908:1256:79a0:8c17:40b5:7692:cdfc?
 ([2a02:908:1256:79a0:8c17:40b5:7692:cdfc])
 by smtp.gmail.com with ESMTPSA id
 t29-20020a056402241d00b004545287d464sm10764878eda.14.2022.09.25.23.31.45
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 25 Sep 2022 23:31:46 -0700 (PDT)
Message-ID: <799e07a5-435a-6608-bd54-6b48d6af85fa@gmail.com>
Date: Mon, 26 Sep 2022 08:31:48 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v3] drm/amdgpu: Fix VRAM BO swap issue
Content-Language: en-US
To: Arunpravin Paneer Selvam <Arunpravin.PaneerSelvam@amd.com>,
 amd-gfx@lists.freedesktop.org
References: <20220926052529.2586-1-Arunpravin.PaneerSelvam@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
In-Reply-To: <20220926052529.2586-1-Arunpravin.PaneerSelvam@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
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
Cc: alexander.deucher@amd.com, Jun.Ma2@amd.com, christian.koenig@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Am 26.09.22 um 07:25 schrieb Arunpravin Paneer Selvam:
> DRM buddy manager allocates the contiguous memory requests in
> a single block or multiple blocks. So for the ttm move operation
> (incase of low vram memory) we should consider all the blocks to
> compute the total memory size which compared with the struct
> ttm_resource num_pages in order to verify that the blocks are
> contiguous for the eviction process.
>
> v2: Added a Fixes tag
> v3: Rewrite the code to save a bit of calculations and
>      variables (Christian)
>
> Fixes: c9cad937c0c5 ("drm/amdgpu: add drm buddy support to amdgpu")
> Signed-off-by: Arunpravin Paneer Selvam <Arunpravin.PaneerSelvam@amd.com>

Reviewed-by: Christian König <christian.koenig@amd.com>

> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c | 17 ++++++++++++-----
>   1 file changed, 12 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> index b1c455329023..dc262d2c2925 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> @@ -424,8 +424,9 @@ static int amdgpu_move_blit(struct ttm_buffer_object *bo,
>   static bool amdgpu_mem_visible(struct amdgpu_device *adev,
>   			       struct ttm_resource *mem)
>   {
> -	uint64_t mem_size = (u64)mem->num_pages << PAGE_SHIFT;
> +	u64 mem_size = (u64)mem->num_pages << PAGE_SHIFT;
>   	struct amdgpu_res_cursor cursor;
> +	u64 end;
>   
>   	if (mem->mem_type == TTM_PL_SYSTEM ||
>   	    mem->mem_type == TTM_PL_TT)
> @@ -434,12 +435,18 @@ static bool amdgpu_mem_visible(struct amdgpu_device *adev,
>   		return false;
>   
>   	amdgpu_res_first(mem, 0, mem_size, &cursor);
> +	end = cursor.start + cursor.size;
> +	while (cursor.remaining) {
> +		amdgpu_res_next(&cursor, cursor.size);
>   
> -	/* ttm_resource_ioremap only supports contiguous memory */
> -	if (cursor.size != mem_size)
> -		return false;
> +		/* ttm_resource_ioremap only supports contiguous memory */
> +		if (end != cursor.start)
> +			return false;
> +
> +		end = cursor.start + cursor.size;
> +	}
>   
> -	return cursor.start + cursor.size <= adev->gmc.visible_vram_size;
> +	return end <= adev->gmc.visible_vram_size;
>   }
>   
>   /*

