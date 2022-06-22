Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E45A9C43334
	for <amd-gfx@archiver.kernel.org>; Wed, 22 Jun 2022 12:34:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 69A6A11336C;
	Wed, 22 Jun 2022 12:34:51 +0000 (UTC)
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com
 [IPv6:2a00:1450:4864:20::534])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DC15211336C
 for <amd-gfx@lists.freedesktop.org>; Wed, 22 Jun 2022 12:34:50 +0000 (UTC)
Received: by mail-ed1-x534.google.com with SMTP id o9so14457907edt.12
 for <amd-gfx@lists.freedesktop.org>; Wed, 22 Jun 2022 05:34:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=message-id:date:mime-version:user-agent:subject:content-language:to
 :references:from:in-reply-to:content-transfer-encoding;
 bh=Xf1s0zbPflf4vKlG1l9V0/snXMHom6bOBMQzMk8tHhw=;
 b=MCNZ9h/+vUMwgYGOuQKmG+jHUyHIUEAbhG7UGa0S6HNQ8hQAG1MF5Bd1TcWOlHgXnK
 V65mzbbgHrUyCYJCxDGw+9yWMHvMBeYWUABfowrbT3yStm4Ehjdzqr1aE3AoYrvr7Cep
 Vg1xg5ii+bAOM5a5jvn7HNrQTyOWy6GVQod1QU5vugxgx9cNrj4c4iLNu+yv8rGLBlrn
 Px3/ce1XNwCUf0FhPoW+0lEFNg9lB/re2Q4W9nPzx8jHqN+kdiXi0x1Qewocmxe9QVXi
 QogZ7X0qfayTmG4Sg+gSDDHij3JMLu42pcldD73JwnQHKBl6xXZiI4J1TOrSMqey3YCS
 YDmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:references:from:in-reply-to
 :content-transfer-encoding;
 bh=Xf1s0zbPflf4vKlG1l9V0/snXMHom6bOBMQzMk8tHhw=;
 b=iREUvVicikjbRkbPYUUWVnEROXZNwNBs2O60YSf82mquK7prPHfTyaSaTpSN0bK4+u
 kj+PoCXReYvi8BuqmFZmU+qs6nOBpJFnbyvbfvV9NkUA35+Z5ugUa22ghVeT5WNLmtjA
 /zJbQ6B4q89BfkwTsDdmLOTohlea5c/SeBtUZKnIWf7cu8dYtkDkdfMaPXL+14icJzlc
 kDJJaW1koTBJPmlAnnOsi7MY5pS7d3Bac3aGInuf0Fp/SD7av5SOZYhth+t6HoQFVuJ0
 rLsZV7kJ6nNQlQiE7YcGsXDGEiCU/cnUth+fzb4gFUsfnXCPSUIzmNVNOiF5GfhT16io
 rnjQ==
X-Gm-Message-State: AJIora/WMXcaOjfiRRyXRwH/OIXlF526T6R8YD4nTyBihzkflLUjz/WU
 Wfq/iIjNGCdZTCX4EmwAo4mN9AmqN5o=
X-Google-Smtp-Source: AGRyM1uqOWf9lOl+/Jtr0Hn66NigGInF7H0H1U9V79Rgk0Ywz/dNRJFaakOU555r3qUKTmZ8tn9nsA==
X-Received: by 2002:a05:6402:11cd:b0:435:64b5:9a52 with SMTP id
 j13-20020a05640211cd00b0043564b59a52mr3867467edw.157.1655901289303; 
 Wed, 22 Jun 2022 05:34:49 -0700 (PDT)
Received: from ?IPV6:2a02:908:1256:79a0:8f77:c83:6a3d:ee86?
 ([2a02:908:1256:79a0:8f77:c83:6a3d:ee86])
 by smtp.gmail.com with ESMTPSA id
 fd18-20020a056402389200b0043570d96d25sm9978445edb.95.2022.06.22.05.34.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 22 Jun 2022 05:34:48 -0700 (PDT)
Message-ID: <94ba161b-6f37-d8d8-3af8-8f54ae4d300d@gmail.com>
Date: Wed, 22 Jun 2022 14:34:47 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH 1/2] drm/amdgpu: fix amdgpu.vramlimit handling
Content-Language: en-US
To: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>,
 amd-gfx@lists.freedesktop.org
References: <20220622100703.303697-1-pierre-eric.pelloux-prayer@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
In-Reply-To: <20220622100703.303697-1-pierre-eric.pelloux-prayer@amd.com>
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

Am 22.06.22 um 12:07 schrieb Pierre-Eric Pelloux-Prayer:
> Without this change amdgpu_ttm_training_data_block_init tries
> to allocate at the end of the real amount of RAM, which
> then fails like this if amdgpu.vramlimit=XXXX is used:
>
>     [drm:amdgpu_ttm_init [amdgpu]] *ERROR* alloc c2p_bo failed(-12)!
>     [drm:amdgpu_device_init.cold [amdgpu]] *ERROR* sw_init of IP block <gmc_v10_0> failed -12
>     amdgpu: amdgpu_device_ip_init failed
>     amdgpu: Fatal error during GPU init
>
> Signed-off-by: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>

That looks like a real bug fix to me, so I think we should add "CC: 
stable..." tag.

Apart from that Reviewed-by: Christian König <christian.koenig@amd.com>

> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> index be0efaae79a9..952e99e6d07e 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> @@ -1621,9 +1621,9 @@ static void amdgpu_ttm_training_data_block_init(struct amdgpu_device *adev)
>   	memset(ctx, 0, sizeof(*ctx));
>   
>   	ctx->c2p_train_data_offset =
> -		ALIGN((adev->gmc.mc_vram_size - adev->mman.discovery_tmr_size - SZ_1M), SZ_1M);
> +		ALIGN((adev->gmc.real_vram_size - adev->mman.discovery_tmr_size - SZ_1M), SZ_1M);
>   	ctx->p2c_train_data_offset =
> -		(adev->gmc.mc_vram_size - GDDR6_MEM_TRAINING_OFFSET);
> +		(adev->gmc.real_vram_size - GDDR6_MEM_TRAINING_OFFSET);
>   	ctx->train_data_size =
>   		GDDR6_MEM_TRAINING_DATA_SIZE_IN_BYTES;
>   
>
> base-commit: a81bcfc756bcaa9e8bb46262f910504fa5290aab

