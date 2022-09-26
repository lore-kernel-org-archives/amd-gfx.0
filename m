Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E951FC07E9D
	for <amd-gfx@archiver.kernel.org>; Mon, 26 Sep 2022 06:50:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 12E6A10E57B;
	Mon, 26 Sep 2022 06:50:59 +0000 (UTC)
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com
 [IPv6:2a00:1450:4864:20::633])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2FABF10E57B
 for <amd-gfx@lists.freedesktop.org>; Mon, 26 Sep 2022 06:50:56 +0000 (UTC)
Received: by mail-ej1-x633.google.com with SMTP id z13so11949605ejp.6
 for <amd-gfx@lists.freedesktop.org>; Sun, 25 Sep 2022 23:50:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date;
 bh=WnDEcbmiSrdE2EXSSm+IgizWrCqwLg1xK7fJRuqV+x8=;
 b=TaZZ7HANL9ytBHgS2og+59GpNbyGdb72denHYkaEEfMhw4TOQ9VB0LKHqK/YRMRGe0
 hvGwX8Jp//YS8VJ62eCwR7rB91Zuw2qL7MEy2wismiZiwhB2oFy5LtvxNlqLzqGa6Hg1
 1fSRM0WNdm/a6Xtu03kwHGxCMtVhSqMLm2kSr71nVyQWKSnmnPENlriRFkBHy5CqDgjb
 I379rDGvr1Rw7cdzUhjIU5fX4jZZpNB5QWFFXt5WWDCuJnh/mBBgS98XxP7fcBFUiHFT
 LJHpPtvpsOdmUQu3/ozJe2g2v3XnMu8aZS1DpgzQgtrKlicrlqAK7qgsGLeP8K7h/gXQ
 +B3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date;
 bh=WnDEcbmiSrdE2EXSSm+IgizWrCqwLg1xK7fJRuqV+x8=;
 b=J9CKJg/RP31h4AyG/ZA2Iye6mjV54wm/eg8pvbtSCjsjHdf3hsjoGH/rrVlDbrNrl6
 raMR0UhIOPT8eWo27Jljr5e/DTUo09BDcjELP9PaIxzYWgqsBaoFS6dbc98ahHyuhYI0
 LESsAkDCzmWOIq410G8qG5YPQKz9z1dw/Q8cPXjePs7jKqPao3ocR+eqyPSpQqDyOP9C
 IE0kJr8wL93LuTx/h95y9h76OiaWU1QeSBw2ChdIuEWYNGKlfcSuUjtx555kUcNIbDZe
 XyCPPXlcJSdoDjiqLdc8H6q9sBwdfLfZHgHun3uugcZWjMFX20LzaLzIoVIK8uNdUXah
 QZrw==
X-Gm-Message-State: ACrzQf3nAIENun9EuLkJjWccllX3bcIVD+uf+Exy4xx91EwalgbnVYqQ
 isrAQGFWlbTct8uTnlCZTw1Up84Ij7w=
X-Google-Smtp-Source: AMsMyM5ifl7SgXB4dhwTgMvRyfUHQ7oLiD6BNpVSlc2T6K/IJGX5UAMwu17jZGEh8ujkO2wDyp5bfw==
X-Received: by 2002:a17:906:8a53:b0:781:6ee9:db96 with SMTP id
 gx19-20020a1709068a5300b007816ee9db96mr16387231ejc.301.1664175054648; 
 Sun, 25 Sep 2022 23:50:54 -0700 (PDT)
Received: from ?IPV6:2a02:908:1256:79a0:8c17:40b5:7692:cdfc?
 ([2a02:908:1256:79a0:8c17:40b5:7692:cdfc])
 by smtp.gmail.com with ESMTPSA id
 r9-20020a1709061ba900b0078258a26667sm5902747ejg.52.2022.09.25.23.50.53
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 25 Sep 2022 23:50:54 -0700 (PDT)
Message-ID: <3b7980f3-9741-9166-e103-a671b562c915@gmail.com>
Date: Mon, 26 Sep 2022 08:50:53 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH] drm/amdgpu: Remove fence_process in count_emitted
Content-Language: en-US
To: jiadong.zhu@amd.com, amd-gfx@lists.freedesktop.org
References: <20220923132724.1260802-1-jiadong.zhu@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
In-Reply-To: <20220923132724.1260802-1-jiadong.zhu@amd.com>
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

Am 23.09.22 um 15:27 schrieb jiadong.zhu@amd.com:
> From: "Jiadong.Zhu" <Jiadong.Zhu@amd.com>
>
> The function amdgpu_fence_count_emitted used in work_hander should not call
> amdgpu_fence_process which must be used in irq handler.
>
> Signed-off-by: Jiadong.Zhu <Jiadong.Zhu@amd.com>

Reviewed-by: Christian König <christian.koenig@amd.com>

> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c | 1 -
>   1 file changed, 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
> index d16c8c1f72db..790f7bfdc654 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
> @@ -394,7 +394,6 @@ unsigned amdgpu_fence_count_emitted(struct amdgpu_ring *ring)
>   	/* We are not protected by ring lock when reading the last sequence
>   	 * but it's ok to report slightly wrong fence count here.
>   	 */
> -	amdgpu_fence_process(ring);
>   	emitted = 0x100000000ull;
>   	emitted -= atomic_read(&ring->fence_drv.last_seq);
>   	emitted += READ_ONCE(ring->fence_drv.sync_seq);

