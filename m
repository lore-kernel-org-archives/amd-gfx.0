Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45C55C4332F
	for <amd-gfx@archiver.kernel.org>; Wed, 14 Dec 2022 09:52:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5B7C410E235;
	Wed, 14 Dec 2022 09:52:52 +0000 (UTC)
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com
 [IPv6:2a00:1450:4864:20::631])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C13B510E235
 for <amd-gfx@lists.freedesktop.org>; Wed, 14 Dec 2022 09:52:48 +0000 (UTC)
Received: by mail-ej1-x631.google.com with SMTP id qk9so43220462ejc.3
 for <amd-gfx@lists.freedesktop.org>; Wed, 14 Dec 2022 01:52:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=bhz49V5VKh7QxaV+Gx9CiJ5jMWwZxXyR5eqSIWi0YIk=;
 b=PJ4IPaGJT1faKylXpPaO52hpcrqq1y7OsgidRc2KSvGEHYeqBQkeUhx6xc8ua+a+Zx
 kW5CsSbeUSz5g5IvIMiv58lOz+OulmnNYQ+Pw9H4Uhh3mIpUaYEhsS4qx4VtN54GrTc/
 mJGufYf0MSoTN/IGcaLrYHU3TtoQw2yuDS+qPVTTuihSaol33ukfGgy+qcZxrUFDIQ7n
 /hZhR95OGNQa0s8C70hfED0DwgVEAa1GSYNxVR4neIDsiVhQwxVXLFoQiFR2sZVuOBJa
 np86FBGQjH/azhDFNTh41VVQb/CZFusbsEbdurGIq7wkPAhvaN20tBhR0OAOmfqzFwz3
 6KzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=bhz49V5VKh7QxaV+Gx9CiJ5jMWwZxXyR5eqSIWi0YIk=;
 b=SAlY8LSuNF9wDXUBtasTf3nTIxMR01LEhOARcQAcfdFdxDtUpCsBKNy0cdSK6EtTwD
 7aXdiJtV1I4bEwWprIjovEU5yNzjuqnyCSwMMma0/b+hTr/CQ3spwzt2cTwmoBKixGXR
 /a3HN9gGefUEmSTK2FDwkbnwPtKVuUA+/XftuokAVKdNHpn7VZowAo97IZp3GxCPI5JH
 Ikh2re+sZskVRjW+RPZjf91ym48RBhX5wfc34vBvbH/iTa8KI7eTZFZ+A8t0zxJRloVc
 sy12G0s13dvv5+BrONlHnoW7Icgu2kcCis6iNlX4w3Ka+sAqDsC8E3Du73cJB5ZVGxfD
 q6EQ==
X-Gm-Message-State: ANoB5pm9CJc023/+yPdsudF8XjjhpYHQGTho+UNY2MbFxsAhUQSpZf/n
 zreCM8tpY44rxFMwNHuyXos=
X-Google-Smtp-Source: AA0mqf7wosUcxWP2BJMzx40po8HlAq14ZGITry1EEYR4yLwl3a2yT1Umy4uuJgqOJtiSrSmDMBwcrQ==
X-Received: by 2002:a17:906:2345:b0:7ad:9455:d57d with SMTP id
 m5-20020a170906234500b007ad9455d57dmr19619070eja.74.1671011567066; 
 Wed, 14 Dec 2022 01:52:47 -0800 (PST)
Received: from ?IPV6:2a02:908:1256:79a0:d2fd:6ced:18a1:b5ce?
 ([2a02:908:1256:79a0:d2fd:6ced:18a1:b5ce])
 by smtp.gmail.com with ESMTPSA id
 lb19-20020a170907785300b007c0a90663d5sm5550280ejc.162.2022.12.14.01.52.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 14 Dec 2022 01:52:46 -0800 (PST)
Message-ID: <e1ab3da2-377d-ad5f-d06d-353ce0f05b72@gmail.com>
Date: Wed, 14 Dec 2022 10:52:45 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH v4] drm/amdgpu: Fix size validation for non-exclusive
 domains (v4)
Content-Language: en-US
To: Luben Tuikov <luben.tuikov@amd.com>,
 AMD Graphics <amd-gfx@lists.freedesktop.org>
References: <20221214094124.160353-1-luben.tuikov@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
In-Reply-To: <20221214094124.160353-1-luben.tuikov@amd.com>
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
Cc: Alex Deucher <Alexander.Deucher@amd.com>,
 =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Am 14.12.22 um 10:41 schrieb Luben Tuikov:
> Fix amdgpu_bo_validate_size() to check whether the TTM domain manager for the
> requested memory exists, else we get a kernel oops when dereferencing "man".
>
> v2: Make the patch standalone, i.e. not dependent on local patches.
> v3: Preserve old behaviour and just check that the manager pointer is not
>      NULL.
> v4: Complain if GTT domain requested and it is uninitialized--most likely a
>      bug.
>
> Cc: Alex Deucher <Alexander.Deucher@amd.com>
> Cc: Christian König <christian.koenig@amd.com>
> Cc: AMD Graphics <amd-gfx@lists.freedesktop.org>
> Signed-off-by: Luben Tuikov <luben.tuikov@amd.com>

Reviewed-by: Christian König <christian.koenig@amd.com>

> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_object.c | 20 +++++++++-----------
>   1 file changed, 9 insertions(+), 11 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
> index fd3ab4b5e5bb1f..983a12cac329a7 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
> @@ -448,27 +448,25 @@ static bool amdgpu_bo_validate_size(struct amdgpu_device *adev,
>   
>   	/*
>   	 * If GTT is part of requested domains the check must succeed to
> -	 * allow fall back to GTT
> +	 * allow fall back to GTT.
>   	 */
>   	if (domain & AMDGPU_GEM_DOMAIN_GTT) {
>   		man = ttm_manager_type(&adev->mman.bdev, TTM_PL_TT);
>   
> -		if (size < man->size)
> +		if (man && size < man->size)
>   			return true;
> -		else
> -			goto fail;
> -	}
> -
> -	if (domain & AMDGPU_GEM_DOMAIN_VRAM) {
> +		else if (!man)
> +			pr_err_ratelimited("GTT domain requested but GTT mem manager uninitialized, for size: %lu\n",
> +					   size);
> +		goto fail;
> +	} else if (domain & AMDGPU_GEM_DOMAIN_VRAM) {
>   		man = ttm_manager_type(&adev->mman.bdev, TTM_PL_VRAM);
>   
> -		if (size < man->size)
> +		if (man && size < man->size)
>   			return true;
> -		else
> -			goto fail;
> +		goto fail;
>   	}
>   
> -
>   	/* TODO add more domains checks, such as AMDGPU_GEM_DOMAIN_CPU */
>   	return true;
>   
>
> base-commit: 84abaa3a855571ebd4e57a7249b867a2fa3763da

