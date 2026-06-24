Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE03ECDB481
	for <amd-gfx@archiver.kernel.org>; Wed, 24 Jun 2026 14:54:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 42FB010EF4C;
	Wed, 24 Jun 2026 14:54:10 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=ursulin.net header.i=@ursulin.net header.b="K/cQ4ke+";
	dkim-atps=neutral
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com
 [209.85.128.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C6EA710EF4C
 for <amd-gfx@lists.freedesktop.org>; Wed, 24 Jun 2026 14:54:08 +0000 (UTC)
Received: by mail-wm1-f46.google.com with SMTP id
 5b1f17b1804b1-490ac357c55so10209025e9.1
 for <amd-gfx@lists.freedesktop.org>; Wed, 24 Jun 2026 07:54:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ursulin.net; s=google; t=1782312847; x=1782917647; darn=lists.freedesktop.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=s1UVUm2ne5u6dWmurr81V/8fKN8uZEdnmMCLdcbMNqI=;
 b=K/cQ4ke+i+cdm7AUHfaDpD1zABFCQN236Q1xCxYcu4Sk3m5oN1/1dl4/+DEJCLneEz
 BvPFQTWtEh3fxc7U2rG/ZU7jvbocwcJ8eL3o3WToCdhSxRIzj2Dha5RMORCl+llu0CsB
 9z9O2XwsdEiuU/RNTU3joqpKLX/OYGh6qsNbaGFtKZr8qfFH5Tu4fVYJ90+yMQcX/EqQ
 9ektBFxWssr+YagLqud8OBsPc0cHXPR535eqWqhGK3jVxQFvylngjdgkSfXyN7bb0KOq
 V4iwRRV/qPSkmb+hbsD9+3p2dR57SVszmDe1waprUggMKAbevAjboIn4yGDjWF1lIgAc
 fDzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782312847; x=1782917647;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=s1UVUm2ne5u6dWmurr81V/8fKN8uZEdnmMCLdcbMNqI=;
 b=c28clnMVtsnKsLkeaMG70hlT8vpaQd4fujCCY1wuIfdHeoOMO699599fvNhyVL1YlZ
 wQJp5awDQh74GAdWtu6AA7mICiIhCjNLAQ2GDjED2FRKfNk/CgzeG8ZJAJDvXZ9IL4f9
 IU0HiEKCZ1elO+nVIEkbpt8t5F7ug85Qi55kvJvUIa47cWIAftHXXJMeYHhCRCO7nfYg
 kjRd8znzUxgwgRIGzSXJkkBmNkXbECzHRvj8Md4NXQFq9L9dh2ND5mgwFqnMjpJstq6J
 4K1qNdeNi1vjFh39JvMt7iAprfwprU99XienFQc2XrFQPpYtjBS+JfU2PsxFCzmheEl5
 u8FQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ+7b8G4YNKlEplG/KAIXHi6zmkP8TRPOB2k32I7WQli4WJrXQg7qHYqhoCCyxDSztN1CXRSn7m4@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzrFA9Xp4sD7dMwyUgH6bMkdRgvyufCC45e3/afCecP0j27TnEb
 1y+0JXiCI1IqLjXyDq5rGzJEIhKqYqEaqs3nHhA3hVDNnYD5+6A3bRwSLyP50DhNodo=
X-Gm-Gg: AfdE7ck72mYRrG/FvziSXWKQ9Kd+Lv7+Uyqpv5Fk+GRJQHjc4g84qLwx0oMlR1GY52C
 jvHZEk3koS80XAj/5J1CHXpcy3vCnKkYM8eJemJLLZMCj7tFaao6mVhBjbfZM71ts8Nb9d83PCH
 aPzz6evWyPQ4RfVYyKw+4QTQ2fZx0M1SqSYmS1zGki+aZ/+os2hO5lie41olQ1rBI9gsE/jAnFn
 5E2/c3VgzpmmMlyXv2IDlahFdvSCI7E8NJ4Y+DZdqocaVqfm7tBSNqzxTlCLD9oyff0/dvYmnLx
 lpni4odvTIk5MJl4F/UOaJVxraw48muMOnOdussV46QxGWq9fBxNGX035YXJVhNM+MGbkLdcP6O
 aAo90ZBF6Dag4tMjCf9VVV/jOYD1hQbAxuzWRcsRfwgw9JgsYOGEE+a9qnyqARnRJJWaAYJ9Z8g
 pzq8nGruVWC1X7tvxcMhSHXIhPCrG4QtN/Aw==
X-Received: by 2002:a05:600d:8494:20b0:492:4ca9:a46d with SMTP id
 5b1f17b1804b1-49260840201mr44084315e9.5.1782312846448; 
 Wed, 24 Jun 2026 07:54:06 -0700 (PDT)
Received: from [192.168.0.116] ([90.240.106.137])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4923fd15535sm501036975e9.3.2026.06.24.07.54.05
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 24 Jun 2026 07:54:05 -0700 (PDT)
Message-ID: <3e09e693-5494-49e7-8aaa-2338867991f5@ursulin.net>
Date: Wed, 24 Jun 2026 15:54:04 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/7] drm/amdgpu/gmc12.0: Use AMDGPU_PTE_IS_PTE flag for
 init_pte_flags on GFX12.0
To: =?UTF-8?Q?Timur_Krist=C3=B3f?= <timur.kristof@gmail.com>,
 amd-gfx@lists.freedesktop.org, Alexander.Deucher@amd.com,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Natalie Vock <natalie.vock@gmx.de>, Amir Shetaia <Amir.Shetaia@amd.com>,
 =?UTF-8?B?TWFyZWsgT2zFocOhaw==?= <maraeo@gmail.com>,
 Mario Limonciello <mario.limonciello@amd.com>, Siwei He <siwei.he@amd.com>,
 Philip Yang <philip.yang@amd.com>, Mukul Joshi <mukul.joshi@amd.com>
References: <20260529103059.21470-1-timur.kristof@gmail.com>
 <20260529103059.21470-6-timur.kristof@gmail.com>
Content-Language: en-GB
From: Tvrtko Ursulin <tursulin@ursulin.net>
In-Reply-To: <20260529103059.21470-6-timur.kristof@gmail.com>
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


On 29/05/2026 11:30, Timur Kristóf wrote:
> According to some SVM code this flag is necessary on
> also GFX12.0 not just GFX12.1.
> 
> Signed-off-by: Timur Kristóf <timur.kristof@gmail.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c
> index 586703ec0dfa0..7bbf5f848ce1b 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c
> @@ -641,11 +641,12 @@ static int gmc_v12_0_early_init(struct amdgpu_ip_block *ip_block)
>   		adev->gmc.xgmi.connected_to_cpu =
>   			adev->smuio.funcs->is_host_gpu_xgmi_supported(adev);
>   
> +	adev->gmc.init_pte_flags = AMDGPU_PTE_IS_PTE;
> +
>   	switch (amdgpu_ip_version(adev, GC_HWIP, 0)) {
>   	case IP_VERSION(12, 1, 0):
>   		gmc_v12_1_set_gmc_funcs(adev);
>   		gmc_v12_1_set_irq_funcs(adev);
> -		adev->gmc.init_pte_flags = AMDGPU_PTE_IS_PTE;
>   		break;
>   	default:
>   		gmc_v12_0_set_gmc_funcs(adev);

Code is fine but I don't have the inside knowledge to comment on the 
GFX12.0 vs GFX12.1 situation. Where is this SVM code commit message 
mentions?

Otherwise, maybe people who added this workaround could review? Those 
two are the relevant patches AFAICT:

commit db29ddf6505f3e831e000c95ae013b18a37f70bc
Author: Mukul Joshi <mukul.joshi@amd.com>
Date:   Thu Apr 24 21:51:23 2025 -0400

     drm/amdgpu: Add per-ASIC PTE init flag


commit 9d47b2c36b9a6c6b844c33cab407a5d7ad102234
Author: Siwei He <siwei.he@amd.com>
Date:   Tue Apr 14 14:46:54 2026 -0400

     drm/amdgpu: OR init_pte_flags into invalid leaf PTE update

I took the liberty to add some CCs.

Regards,

Tvrtko

