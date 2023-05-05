Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E119C77B7F
	for <amd-gfx@archiver.kernel.org>; Fri,  5 May 2023 11:13:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1262110E5C6;
	Fri,  5 May 2023 11:13:46 +0000 (UTC)
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com
 [IPv6:2a00:1450:4864:20::531])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 23FE610E5C6
 for <amd-gfx@lists.freedesktop.org>; Fri,  5 May 2023 11:13:44 +0000 (UTC)
Received: by mail-ed1-x531.google.com with SMTP id
 4fb4d7f45d1cf-50bd875398dso2457707a12.1
 for <amd-gfx@lists.freedesktop.org>; Fri, 05 May 2023 04:13:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1683285222; x=1685877222;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=T6aEBCYPpwT1hbvJQduFLplN9h0dX+3JJtvJLI3vE50=;
 b=ehufIdEqw9QY4Kfaj45snhMKicCBQ+FdGh/unZocDdAZ+nWjy2cVHkhkjraEnFsCU5
 AbVWJMIsqT6Jbb9CbJO7frSoQ8fOl3EXRh9F3g/M4KnZAIDfa7o/JlSD2KWyGPnu58vu
 220YVq010POpe65UHyeo3P9oK2JQ4fowtWu6AkKEJhuW5CAmRpEN2z0eB84VAerkeJ4T
 ZlkahiMS4+LGwV2SeFlulSsQFqQaxzp5S+5kSl2FGnbvK1tRxY0FGFNgI+Q01sSWRjDu
 e69+/Wd686+dbhoPRY7RxYg8DvXBaoi6L5ENhrI1+1xmvdVzj+sDcm2N46ATRR4AZhQT
 AhKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1683285222; x=1685877222;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=T6aEBCYPpwT1hbvJQduFLplN9h0dX+3JJtvJLI3vE50=;
 b=W0biNr+GqcspvYyZmkqZSCIuKq1CyWGWY8E5r6HQQ/7omITjW4AEHGBh+zG/JjQFBN
 YS+bAIKNMXAKC0M6eEpUIojGWhVBQt9yiAzQlsYzJpXtV9qXyDSkmgO2PZkndDlVWOeL
 xfzNIRDWV6T6LdgmPIdeTXrIPQDzLKVs5DvqTAa7fCLn+ZPgRjWj92uopTjaUZPNFSyU
 dgz2h7QZH+0V+zmRF3yC3e+6sESTQfbf/xYdd/Qee9cYp0KI7DeMMrlWhQC2xNeOFt4B
 CyTLZsOENQq8A1023WtVeBrYi1wXHSxH6hR76VWLpVbVcs/g6MD9bvzW8Pzc+Kp+UWGT
 tghQ==
X-Gm-Message-State: AC+VfDybU8eGsz11k0SEJuONHO5/GvAj1XjmhfmKiOz/AVTlX3NlINnA
 pYqd2U7iSykF/6JzvBTMGlk=
X-Google-Smtp-Source: ACHHUZ4uyiH7BFKl8k6jSVPQeanQS1VA9/ofGHRjNHLPJcM+2RAsUmd+qoJAaFRiritfUkNWpzluxw==
X-Received: by 2002:a17:906:fe4e:b0:94a:44ef:853d with SMTP id
 wz14-20020a170906fe4e00b0094a44ef853dmr739850ejb.68.1683285221818; 
 Fri, 05 May 2023 04:13:41 -0700 (PDT)
Received: from ?IPV6:2a02:908:1256:79a0:e2f8:820b:7a40:97ca?
 ([2a02:908:1256:79a0:e2f8:820b:7a40:97ca])
 by smtp.gmail.com with ESMTPSA id
 h13-20020a1709070b0d00b0094efdfe60dcsm780541ejl.206.2023.05.05.04.13.40
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 05 May 2023 04:13:41 -0700 (PDT)
Message-ID: <412dddbe-67a1-48c4-1eb5-9cb7d672d79e@gmail.com>
Date: Fri, 5 May 2023 13:13:40 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH] drm/amdgpu: avoid null dereference of fence when using
 cpu to update page tables
Content-Language: en-US
To: Lang Yu <Lang.Yu@amd.com>, amd-gfx@lists.freedesktop.org
References: <20230505091020.1383923-1-Lang.Yu@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
In-Reply-To: <20230505091020.1383923-1-Lang.Yu@amd.com>
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
Cc: Jack Xiao <Jack.Xiao@amd.com>, Christian Koenig <christian.koenig@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Am 05.05.23 um 11:10 schrieb Lang Yu:
> Using cpu to update page tables is sychronous, no need to wait fence
> and it is NULL in such a case.

Good catch, be we usually install the stub into fence pointers when they 
are unused. See dma_fence_get_stub().

Christian.

>
> Signed-off-by: Lang Yu <Lang.Yu@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c | 7 +++++--
>   1 file changed, 5 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
> index f0f00466b59f..197981c4ac7d 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
> @@ -1043,8 +1043,11 @@ int amdgpu_mes_add_ring(struct amdgpu_device *adev, int gang_id,
>   
>   	amdgpu_mes_ring_to_queue_props(adev, ring, &qprops);
>   
> -	dma_fence_wait(gang->process->vm->last_update, false);
> -	dma_fence_wait(ctx_data->meta_data_va->last_pt_update, false);
> +	if (gang->process->vm->last_update)
> +		dma_fence_wait(gang->process->vm->last_update, false);
> +	if (ctx_data->meta_data_va->last_pt_update)
> +		dma_fence_wait(ctx_data->meta_data_va->last_pt_update, false);
> +
>   	amdgpu_mes_unlock(&adev->mes);
>   
>   	r = amdgpu_mes_add_hw_queue(adev, gang_id, &qprops, &queue_id);

