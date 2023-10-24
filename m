Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1677C00A8F
	for <amd-gfx@archiver.kernel.org>; Tue, 24 Oct 2023 06:18:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 52D4C10E011;
	Tue, 24 Oct 2023 06:18:53 +0000 (UTC)
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com
 [IPv6:2a00:1450:4864:20::12f])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 81CAF10E011
 for <amd-gfx@lists.freedesktop.org>; Tue, 24 Oct 2023 06:18:50 +0000 (UTC)
Received: by mail-lf1-x12f.google.com with SMTP id
 2adb3069b0e04-507bd64814fso5985396e87.1
 for <amd-gfx@lists.freedesktop.org>; Mon, 23 Oct 2023 23:18:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1698128328; x=1698733128; darn=lists.freedesktop.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=1mjURlUhdEKvNZq4GMYLO3pIl8zydLg4qPuBtm9U3Wo=;
 b=AD5ByZAhYZwe+Azu5zc1+Pe4T5BGU9k0qv7YMoCAdeirwHKBF/XaRQZ4qT3cm7BbeS
 uPyCi/LNYBcAAtGindk0nvMj2hJGPvFrAMT6obKK+km/3xQBi9Vo1jR/ru9Jt5YzjP5v
 wDhnjxZrmpznZXDEJY5iv+lfU7XQ6gZPPPxfo1pEHH6x5f/Ac/MwcZ5IZwNMvKPoaGKK
 QKjlW6fzRL+47H0LVlK0qjhkuX3+WahU15PbmM7aEbElOKi31H/3BUm2y5L1we0EhZEk
 sJS8MEcl4RLPFlwRvAZHQEZio728TSDxd2dVDn7QbwktH4PjbIofSjAEXN3dXko47e8K
 eOkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698128328; x=1698733128;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=1mjURlUhdEKvNZq4GMYLO3pIl8zydLg4qPuBtm9U3Wo=;
 b=frRstsDbrqxtdHyDUbvvVlWRcffwLIGUw2WBpZYEMoyaMz+a9X/D8IDlMhf8jkMUWs
 1drCAwLgkWpSuKeR+6MrHBOoFwwheznJ8uJlz7/UWUfRHZGNqAC35TWaQTDS5q5KMTY1
 eOsHTLMElcDNGOzF3Nybsw0T35yYrhhd2rYjRDmar/wVFL6DISt0Lu+jby8evIPgSVyd
 vW11FtIKsKHdwwWikZRtxoO0ic9luzIxV/BkTruCYnwkFnJ9KnZe1ezHc+L7KFeFMxs/
 BsXa0gM64IdfiPeIwYFhP82dOT9ITtyiG1Nl9Sl0kYD69QTmOf5mIQUQLRwxHaY0NTyz
 N5Qw==
X-Gm-Message-State: AOJu0Ywc/iR8AqR6VBCiWmQ75wmufPO1ax7jMvSEgv4OrLDTfKgmF5J1
 pcgi/AG1DmDMNRTHrIMZakw=
X-Google-Smtp-Source: AGHT+IFFCV39aN2hK1VD5BqqpIfnsssIUPTNKERQi3tgr0GHAAKg8Yi+XWOizcmVf5a5Bf/RiCw+HQ==
X-Received: by 2002:ac2:59c1:0:b0:505:7276:8a5f with SMTP id
 x1-20020ac259c1000000b0050572768a5fmr6928906lfn.2.1698128328242; 
 Mon, 23 Oct 2023 23:18:48 -0700 (PDT)
Received: from [192.168.178.25] ([134.19.55.171])
 by smtp.gmail.com with ESMTPSA id
 cx28-20020a05640222bc00b0053da777f7d1sm7282961edb.10.2023.10.23.23.18.47
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 23 Oct 2023 23:18:47 -0700 (PDT)
Message-ID: <0528b65e-255d-433a-acfa-ce21b86359f0@gmail.com>
Date: Tue, 24 Oct 2023 08:18:46 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] drm/amdgpu: Add timeout for sync wait
Content-Language: en-US
To: Emily Deng <Emily.Deng@amd.com>, amd-gfx@lists.freedesktop.org,
 "Kuehling, Felix" <Felix.Kuehling@amd.com>
References: <20231020095911.591988-1-Emily.Deng@amd.com>
 <20231020095911.591988-2-Emily.Deng@amd.com>
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>
In-Reply-To: <20231020095911.591988-2-Emily.Deng@amd.com>
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

Am 20.10.23 um 11:59 schrieb Emily Deng:
> Issue: Dead heappen during gpu recover, the call sequence as below:
>
> amdgpu_device_gpu_recover->amdgpu_amdkfd_pre_reset->flush_delayed_work->
> amdgpu_amdkfd_gpuvm_restore_process_bos->amdgpu_sync_wait

Resolving a deadlock with a timeout is illegal in general. So this patch 
here is an obvious no-go.

Additional to this problem Xinhu already investigated that the delayed 
work is causing issues during suspend because because flushing doesn't 
guarantee that a new one isn't started right after doing that.

After talking with Felix about this the correct solution is to stop 
flushing the delayed work and instead submitting it to the freezable 
work queue.

Regards,
Christian.

>
> It is because the amdgpu_sync_wait is waiting for the bad job's fence, and
> never return, so the recover couldn't continue.
>
> Signed-off-by: Emily Deng <Emily.Deng@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_sync.c | 11 +++++++++--
>   1 file changed, 9 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_sync.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_sync.c
> index dcd8c066bc1f..9d4f122a7bf0 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_sync.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_sync.c
> @@ -406,8 +406,15 @@ int amdgpu_sync_wait(struct amdgpu_sync *sync, bool intr)
>   	int i, r;
>   
>   	hash_for_each_safe(sync->fences, i, tmp, e, node) {
> -		r = dma_fence_wait(e->fence, intr);
> -		if (r)
> +		struct drm_sched_fence *s_fence = to_drm_sched_fence(e->fence);
> +		long timeout = msecs_to_jiffies(10000);
> +
> +		if (s_fence)
> +			timeout = s_fence->sched->timeout;
> +		r = dma_fence_wait_timeout(e->fence, intr, timeout);
> +		if (r == 0)
> +			r = -ETIMEDOUT;
> +		if (r < 0)
>   			return r;
>   
>   		amdgpu_sync_entry_free(e);

