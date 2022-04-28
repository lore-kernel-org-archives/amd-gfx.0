Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 400F0C433EF
	for <amd-gfx@archiver.kernel.org>; Thu, 28 Apr 2022 05:58:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C4F3210ED40;
	Thu, 28 Apr 2022 05:58:07 +0000 (UTC)
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com
 [IPv6:2a00:1450:4864:20::42b])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 381F010ED3F
 for <amd-gfx@lists.freedesktop.org>; Thu, 28 Apr 2022 05:58:06 +0000 (UTC)
Received: by mail-wr1-x42b.google.com with SMTP id t6so5253615wra.4
 for <amd-gfx@lists.freedesktop.org>; Wed, 27 Apr 2022 22:58:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=message-id:date:mime-version:user-agent:subject:content-language:to
 :references:from:in-reply-to:content-transfer-encoding;
 bh=mADmpyddZP+ud2wO13wwOCqdnE9D0ThPotfeZhm32b0=;
 b=KVdqE5jwZKXk77iJz5h4kMfFufWfdMC+EGIp3L0uJgu+7dEaGKsLl3czvRxx4SYwx3
 ZQ8YalVkRSAAQYjJsEMXH5gD5KlJUizx9WVoz2rgXjXKW453kMiMcXBgJP+WuxsEEBQE
 qKRsQuH8GmOnwvi20rMf44L6kbyqRnLYAjyQ32UxdnUf6FJzaoq1M2OtYiU/GxWoYzEm
 wqcdBGUZk7CW6VXbbALH0Q6o72Jap1KsQqDHKYS5ckrFOjify7TDTBjYPI3iHqODbC4N
 otK0q/4aV1mkGOPxbXOYeZvxAWk/alfFb/kl3O0mSBZsGwKa7B9gX19+aqOX0vJJ/TMU
 j9tQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:references:from:in-reply-to
 :content-transfer-encoding;
 bh=mADmpyddZP+ud2wO13wwOCqdnE9D0ThPotfeZhm32b0=;
 b=42Bh3hQHHzCm9tgY9OKbJyBIsVIYv1vczJKpNJdsnoKA+1nmSrFFkau7C/6W+vRfqV
 pm7Qt6nJW8/Pkb+6odQ2unwViCKYbdcN6Hg/4i6FhDHBhAThWu0ayIe1JcB04JJRNLhZ
 HQUVc/Gz3qHi7JtrMIyLAmRRFAG6vuenNsC+xz9N5LJtDhJ8idXJsrKjtb3vVSNt4YoN
 AaWnhCQAfcWGWEzSw29UfB0jEguvfpA7xKIGdgTwOKAmCQqIvfckYEEg9R+g/JQz2nct
 0Vldaa2hO5DlcQszgvvMyTE3Hw45zCKW7/df6Ynvjtsg1D08+O13P5mDNTZ/0C5QC9i0
 Zylg==
X-Gm-Message-State: AOAM532dILy9p5XxYeguCyFqTpq1/SF5pOyrlApkMaTqydnJASGfdtKw
 nNgE72/iWcttqNGgu2umFhk=
X-Google-Smtp-Source: ABdhPJzl6/mIKeZV9uDgxQdExDB+gLJCkDoel15NiNf6+LOY8LcWGr/svzQVX9wbTJ/oVLa5bMYyJA==
X-Received: by 2002:a5d:4a81:0:b0:207:9abe:2908 with SMTP id
 o1-20020a5d4a81000000b002079abe2908mr24625507wrq.341.1651125484692; 
 Wed, 27 Apr 2022 22:58:04 -0700 (PDT)
Received: from [192.168.178.21] (p57b0b9e1.dip0.t-ipconnect.de.
 [87.176.185.225]) by smtp.gmail.com with ESMTPSA id
 f189-20020a1c38c6000000b0038ff83b9792sm3116883wma.43.2022.04.27.22.58.03
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 27 Apr 2022 22:58:04 -0700 (PDT)
Message-ID: <f504e452-ba4e-190c-c605-e3cbae227d0c@gmail.com>
Date: Thu, 28 Apr 2022 07:58:02 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH 1/1] drm/amdgpu: Free user pages if amdgpu_cs_parser_bos
 failed
Content-Language: en-US
To: Philip Yang <Philip.Yang@amd.com>, amd-gfx@lists.freedesktop.org
References: <CAP145piim21dDoS7fsv9WQ-Toc3xr-xG7ayP7_T+F4SeS8AUmQ@mail.gmail.com>
 <20220427230700.11891-1-Philip.Yang@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
In-Reply-To: <20220427230700.11891-1-Philip.Yang@amd.com>
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Am 28.04.22 um 01:07 schrieb Philip Yang:
> Otherwise userspace resubmit the BOs again will trigger kernel WARNING
> and fail the command submission.
>
> Signed-off-by: Philip Yang <Philip.Yang@amd.com>

Thanks for looking into this Philip. Patch is Reviewed-by: Christian 
König <christian.koenig@amd.com>

> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c | 18 +++++++++++++++---
>   1 file changed, 15 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
> index ea28942b0ede..44dcbef80229 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
> @@ -550,7 +550,7 @@ static int amdgpu_cs_parser_bos(struct amdgpu_cs_parser *p,
>   		if (r) {
>   			kvfree(e->user_pages);
>   			e->user_pages = NULL;
> -			return r;
> +			goto out_free_user_pages;
>   		}
>   
>   		for (i = 0; i < bo->tbo.ttm->num_pages; i++) {
> @@ -567,7 +567,7 @@ static int amdgpu_cs_parser_bos(struct amdgpu_cs_parser *p,
>   	if (unlikely(r != 0)) {
>   		if (r != -ERESTARTSYS)
>   			DRM_ERROR("ttm_eu_reserve_buffers failed.\n");
> -		goto out;
> +		goto out_free_user_pages;
>   	}
>   
>   	amdgpu_bo_list_for_each_entry(e, p->bo_list) {
> @@ -649,7 +649,19 @@ static int amdgpu_cs_parser_bos(struct amdgpu_cs_parser *p,
>   		}
>   		ttm_eu_backoff_reservation(&p->ticket, &p->validated);
>   	}
> -out:
> +
> +out_free_user_pages:
> +	if (r) {
> +		amdgpu_bo_list_for_each_userptr_entry(e, p->bo_list) {
> +			struct amdgpu_bo *bo = ttm_to_amdgpu_bo(e->tv.bo);
> +
> +			if (!e->user_pages)
> +				continue;
> +			amdgpu_ttm_tt_get_user_pages_done(bo->tbo.ttm);
> +			kvfree(e->user_pages);
> +			e->user_pages = NULL;
> +		}
> +	}
>   	return r;
>   }
>   

