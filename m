Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8635CDB47E
	for <amd-gfx@archiver.kernel.org>; Fri, 20 Oct 2023 07:29:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 717E310E58C;
	Fri, 20 Oct 2023 07:29:11 +0000 (UTC)
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com
 [IPv6:2a00:1450:4864:20::32b])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 16E9410E58C
 for <amd-gfx@lists.freedesktop.org>; Fri, 20 Oct 2023 07:29:10 +0000 (UTC)
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-4083ac51d8aso4168435e9.2
 for <amd-gfx@lists.freedesktop.org>; Fri, 20 Oct 2023 00:29:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1697786948; x=1698391748; darn=lists.freedesktop.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Afmkt2gZByVpfOEp03m8P91XLjqJAucNSPUIBXYEnRg=;
 b=UjBStWJcTCLC/CTAPNiPcKYjNJOQ0FaS7JxnYgapWlhPBTTu5Yl6edb5ilUj5itPQb
 zH6Q8Vod8ApO8ZkA/6aCJ6/ZtPV4/a3YsQ/qeAKoKjV4iAhWZBQu5JVlcb/zAwaN/fz3
 rWTYmW1m5Rfa69C2UaMfxmBcp0XrFThXNJR1XS57j5cJPVK6J6lWIcuzycCJvzJxHTpG
 klE0ZZbZ9m7IZ6sg12HMYri7vv33OUip3XqbNXYb8tG1f+C4AGkbA6gBo3Vk8hFJ3QUG
 cNAIb8qRMb2/aNxYA/jm75Zbt7vpUiGmI29apJe4Ow3Uuv9aBQBiyAyGCB8cHFtAAbF/
 WWgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697786948; x=1698391748;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Afmkt2gZByVpfOEp03m8P91XLjqJAucNSPUIBXYEnRg=;
 b=V7qHptuTxe/8C2ngcfmiZjMSuNTI2i9a84nugSRF37OS7tmxQGvPcIfZ5VqUgkvg1P
 RdcGZFhrBfMDOmbo071ifkfmhOakM+9Uam9jTuhfabTx6a7T7+trOAtAx8GuesSq9pzV
 VAKbQaEazDvo2TIgpyR4+r1+iZXzSz13psynnDxHVI+iLP2L6Y9jcpTFa5z51mSMxyaS
 hdf4IgmI61rTLzKnGY2UEm7rFCBc/lNpCbEJ3q5FB+CJI+9l/FIFxKzVFdU3E2AIVoqg
 kSIAbHnzgiS3AHyysg3f3Cw5s3wyyk3esFgZ5RFXS14/jHb6LboK3RclhRUWZrEIIBGQ
 YTew==
X-Gm-Message-State: AOJu0YzQuNMQO08GTKTWtscBHShWVV9PDru5UOMHYojc+ulE246Z2jrr
 +K4amq2QTidsI5gWO2Rhlp8=
X-Google-Smtp-Source: AGHT+IGn0ktR5lp16H+kuJZOuq+B+tYs0uvdLPELKkrnyGVDaAw//2EJhHhzl+qAPTvmObSwSCa3cQ==
X-Received: by 2002:a05:600c:3502:b0:407:8e85:899f with SMTP id
 h2-20020a05600c350200b004078e85899fmr748203wmq.16.1697786948066; 
 Fri, 20 Oct 2023 00:29:08 -0700 (PDT)
Received: from [10.254.108.106] (munvpn.amd.com. [165.204.72.6])
 by smtp.gmail.com with ESMTPSA id
 g16-20020a05600c311000b0040651505684sm1462880wmo.29.2023.10.20.00.29.07
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 20 Oct 2023 00:29:07 -0700 (PDT)
Message-ID: <fbf6e76a-547d-423d-987b-9d1260437322@gmail.com>
Date: Fri, 20 Oct 2023 09:29:06 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] drm/amdgpu: Add timeout for sync wait
Content-Language: en-US
To: Emily Deng <Emily.Deng@amd.com>, amd-gfx@lists.freedesktop.org
References: <20231020061307.588900-1-Emily.Deng@amd.com>
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>
In-Reply-To: <20231020061307.588900-1-Emily.Deng@amd.com>
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

Am 20.10.23 um 08:13 schrieb Emily Deng:
> Issue: Dead heappen during gpu recover, the call sequence as below:
>
> amdgpu_device_gpu_recover->amdgpu_amdkfd_pre_reset->flush_delayed_work->
> amdgpu_amdkfd_gpuvm_restore_process_bos->amdgpu_sync_wait
>
> It is because the amdgpu_sync_wait is waiting for the bad job's fence, and
> never return, so the recover couldn't continue.
>
>
> Signed-off-by: Emily Deng <Emily.Deng@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_sync.c | 11 +++++++++--
>   1 file changed, 9 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_sync.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_sync.c
> index dcd8c066bc1f..6253d6aab7f8 100644
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

That handling doesn't make much sense. If you need a timeout then you 
need a timeout for the whole function.

Additional to that timeouts often just hide real problems which needs 
fixing.

So this here needs a much better justification otherwise it's a pretty 
clear NAK.

Regards,
Christian.

> +
> +		if (s_fence)
> +			timeout = s_fence->sched->timeout;
> +
> +		if (r == 0)
> +			r = -ETIMEDOUT;
> +		if (r < 0)
>   			return r;
>   
>   		amdgpu_sync_entry_free(e);

