Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42397C433EF
	for <amd-gfx@archiver.kernel.org>; Wed, 13 Jul 2022 09:17:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9BEA29426E;
	Wed, 13 Jul 2022 09:17:13 +0000 (UTC)
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com
 [IPv6:2a00:1450:4864:20::534])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 72E13935F4
 for <amd-gfx@lists.freedesktop.org>; Wed, 13 Jul 2022 09:17:12 +0000 (UTC)
Received: by mail-ed1-x534.google.com with SMTP id m16so13255412edb.11
 for <amd-gfx@lists.freedesktop.org>; Wed, 13 Jul 2022 02:17:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=message-id:date:mime-version:user-agent:subject:content-language:to
 :cc:references:from:in-reply-to:content-transfer-encoding;
 bh=Wb7PzkOMXCSMAgxIP6rNohJQgkANIgJrKwA+83lf4+Q=;
 b=AtzLVNlaZX+URHyTDQ+7Pjzm2kPH3DDo4tUjfgYh9YIGcN2pWL83mfLO5WEuV8eD35
 nHK/oWdHIdu/xl0O5gK8J2fhL5/2RVLnSXxSKJQTCycMd8uHia5AF4GWGaI8T83U4dzH
 5I8/MJ5QMfGedaAUN+30GrHBvRQQQ3mn2bYvjbAN+Gh7B55cqMBtJKbqXWTUNoA2SWXQ
 SjcQi4EtuqKbniNwg4nqnMeChHmyGm6gCfCSfiNP5H6LRphGN/HxcYrAM7pfLZ4dHJ7z
 YYzG6ZEV7tHniBHctHHIaEttspWTEnXoa/8aTYwyHH5FQkVhxdAMWqbRf2ZLcR0fKCBb
 rjJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:cc:references:from:in-reply-to
 :content-transfer-encoding;
 bh=Wb7PzkOMXCSMAgxIP6rNohJQgkANIgJrKwA+83lf4+Q=;
 b=NqdG/+Z1Uj9/+CAhyz2p8xU6Vi4q0F14b0LU7Hn+J8fKP3vIrJYTjibDTXKLLwZAk1
 pUUkDVX1J4vk9z9fkR5MMv6Q+9t2hspXGdzh5PL9dvxCSXstzTINxRsfJGX00JMjFQ3X
 Jynv6untp3eGMQrvBBEbriGwBScS6g3riIP7jhVOGYuvvS3bP1zGkme7cGhCY7boPg46
 g8Qb/DO0EU/BQH5Xi2/b5hDwuE5zHgzs9FjfHUXwySCQt1iEc/OiXwOJ6kZa2KaQ01Cp
 Xy7cpKIAjG8nn5CNyCZgc9dKdDRUnhRaRQvJQJmiVHO292vjfJXQ0WkK0dgAz76Xhrpy
 NwWg==
X-Gm-Message-State: AJIora8vNaL/vUEHEaQNamCxUu9stCpGj8tzYfP83isf5AeHeCFIah1i
 V05F+pcuQUdMiTE2Ni0xWSk=
X-Google-Smtp-Source: AGRyM1sdzYgXxlPFkAAuv42RTS/PcgRgYu1ne3dPb1uBcKXH4RSXLTmVnAlbJl374tDJmtsjtwMXFg==
X-Received: by 2002:a05:6402:1606:b0:43a:2204:8b5e with SMTP id
 f6-20020a056402160600b0043a22048b5emr3349983edv.316.1657703830875; 
 Wed, 13 Jul 2022 02:17:10 -0700 (PDT)
Received: from ?IPV6:2a02:908:1256:79a0:1cad:c487:5caa:b9cb?
 ([2a02:908:1256:79a0:1cad:c487:5caa:b9cb])
 by smtp.gmail.com with ESMTPSA id
 hy10-20020a1709068a6a00b00704757b1debsm4730981ejc.9.2022.07.13.02.17.09
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 13 Jul 2022 02:17:10 -0700 (PDT)
Message-ID: <16232404-cb41-08b5-a087-20f0de251faa@gmail.com>
Date: Wed, 13 Jul 2022 11:17:09 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v2] drm/amdgpu: Check BO's requested pinning domains
 against its preferred_domains
Content-Language: en-US
To: sunpeng.li@amd.com, amd-gfx@lists.freedesktop.org
References: <20220711224443.1157747-1-sunpeng.li@amd.com>
 <20220712163029.43581-1-sunpeng.li@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
In-Reply-To: <20220712163029.43581-1-sunpeng.li@amd.com>
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
Cc: Alexander.Deucher@amd.com, Harry.Wentland@amd.com, Marek.Olsak@amd.com,
 Leo.Liu@amd.com, christian.koenig@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Am 12.07.22 um 18:30 schrieb sunpeng.li@amd.com:
> From: Leo Li <sunpeng.li@amd.com>
>
> When pinning a buffer, we should check to see if there are any
> additional restrictions imposed by bo->preferred_domains. This will
> prevent the BO from being moved to an invalid domain when pinning.
>
> For example, this can happen if the user requests to create a BO in GTT
> domain for display scanout. amdgpu_dm will allow pinning to either VRAM
> or GTT domains, since DCN can scanout from either or. However, in
> amdgpu_bo_pin_restricted(), pinning to VRAM is preferred if there is
> adequate carveout. This can lead to pinning to VRAM despite the user
> requesting GTT placement for the BO.
>
> v2: Allow the kernel to override the domain, which can happen when
>      exporting a BO to a V4L camera (for example).
>
> Signed-off-by: Leo Li <sunpeng.li@amd.com>

Reviewed-by: Christian König <christian.koenig@amd.com>

> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_object.c | 4 ++++
>   1 file changed, 4 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
> index 8a7b0f6162da..bbd3b8b14cfb 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
> @@ -883,6 +883,10 @@ int amdgpu_bo_pin_restricted(struct amdgpu_bo *bo, u32 domain,
>   	if (WARN_ON_ONCE(min_offset > max_offset))
>   		return -EINVAL;
>   
> +	/* Check domain to be pinned to against preferred domains */
> +	if (bo->preferred_domains & domain)
> +		domain = bo->preferred_domains & domain;
> +
>   	/* A shared bo cannot be migrated to VRAM */
>   	if (bo->tbo.base.import_attach) {
>   		if (domain & AMDGPU_GEM_DOMAIN_GTT)

