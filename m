Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F912C32796
	for <amd-gfx@archiver.kernel.org>; Wed, 24 Aug 2022 17:47:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DF9FF14AB57;
	Wed, 24 Aug 2022 17:46:36 +0000 (UTC)
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com
 [IPv6:2a00:1450:4864:20::331])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D5E778D7E5
 for <amd-gfx@lists.freedesktop.org>; Tue, 16 Aug 2022 08:15:27 +0000 (UTC)
Received: by mail-wm1-x331.google.com with SMTP id
 s11-20020a1cf20b000000b003a52a0945e8so5003503wmc.1
 for <amd-gfx@lists.freedesktop.org>; Tue, 16 Aug 2022 01:15:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc; bh=Zx6YCldx1HRWfx99BJr0gRf5MR/3jypQHCG2lSsJaCM=;
 b=fTK09Lv04Yf0s6Jbz3izVe0MRv5WWsoV3Ufsa0I4vL3QywTdc76ALjDQbqJZB7hKKT
 cY1PcdpNyuB1eFMr6xeF1p12t775VtxJoBBJyAkF+s41k/KtVF/8uIw284sCPPCfkiPL
 LL8oslo5B3y++ymrbNssxetQ4ZDv8nzqemYSqFv2zCtuIaAxHaqIyo7+ShgQfyKye9fr
 cDIurcOr/ttHtbtPW7JibmcUoT2y/DSgYWtVXrjtzBVperWKAuaG9akiCLT+M/MsUlcB
 aKLxwspzlvoTEV2ZihVtRasz3SdG1KTt8Sx/CQf2SLR8jvr35pzVRV5m9xxVYIiq9ogS
 Jv5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc;
 bh=Zx6YCldx1HRWfx99BJr0gRf5MR/3jypQHCG2lSsJaCM=;
 b=RjlaKGURgorjwTFQQ9SbXk9WA2MqByx+DdBkPt3oNRsYTprTBrT2RG2FbefNPuRxze
 jnRMunreYPiZnFU/hOGrelcqs1HTTeZ/ONxs6HMMeEsFlk/7oI9lGDeIhNLRZJhTBBdO
 GkQz8hjIN7MnbpztAGqwwdp3nnTnr/vlh8tknqPyDgAd6+hPzHbf5eLwwHcYVw0po6L9
 ee/H4fBEnRLgFQiRzeRZiDAbKNIx5GTUtrXDggP8P1BHlu6RZrt83eWIw9kkM6zZE3wv
 kTmsC2v77bAFMpxPtTCWldj8DMDReDbx1HuV8TSWsTkU70jYMwPZOrF82EJsf1M8bLb1
 gDdA==
X-Gm-Message-State: ACgBeo04goaDjK3NiPaBqyviOKruqbJFkijaPfxNTQtKx7t8uSu47gXf
 hnIjkWfJZ0otHk+Yrze5RuQ=
X-Google-Smtp-Source: AA6agR6gmV8mFd1T6xccjhywPmMIEIXxvHP4YeHhH09az7S/mLOnDYP49tI5AqCIIhFx1mMFUgBxdQ==
X-Received: by 2002:a05:600c:210b:b0:3a5:bb92:d22d with SMTP id
 u11-20020a05600c210b00b003a5bb92d22dmr12300084wml.99.1660637724952; 
 Tue, 16 Aug 2022 01:15:24 -0700 (PDT)
Received: from [192.168.178.21] (p57b0bd9f.dip0.t-ipconnect.de.
 [87.176.189.159]) by smtp.gmail.com with ESMTPSA id
 co26-20020a0560000a1a00b0021e2fccea97sm9450739wrb.64.2022.08.16.01.15.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 16 Aug 2022 01:15:24 -0700 (PDT)
Message-ID: <94a17bf5-a4a7-e867-14ce-3a0c314a8535@gmail.com>
Date: Tue, 16 Aug 2022 10:15:24 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCHv2] drm/amdgpu: Fix interrupt handling on ih_soft ring
Content-Language: en-US
To: Mukul Joshi <mukul.joshi@amd.com>, amd-gfx@lists.freedesktop.org
References: <20220815192557.3348828-1-mukul.joshi@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
In-Reply-To: <20220815192557.3348828-1-mukul.joshi@amd.com>
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
Cc: Felix.Kuehling@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Am 15.08.22 um 21:25 schrieb Mukul Joshi:
> There are no backing hardware registers for ih_soft ring.
> As a result, don't try to access hardware registers for read
> and write pointers when processing interrupts on the IH soft
> ring.
>
> Signed-off-by: Mukul Joshi <mukul.joshi@amd.com>

Acked-by: Christian König <christian.koenig@amd.com>

> ---
>   drivers/gpu/drm/amd/amdgpu/navi10_ih.c | 7 ++++++-
>   drivers/gpu/drm/amd/amdgpu/vega10_ih.c | 7 ++++++-
>   drivers/gpu/drm/amd/amdgpu/vega20_ih.c | 7 ++++++-
>   3 files changed, 18 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/navi10_ih.c b/drivers/gpu/drm/amd/amdgpu/navi10_ih.c
> index 4b5396d3e60f..eec13cb5bf75 100644
> --- a/drivers/gpu/drm/amd/amdgpu/navi10_ih.c
> +++ b/drivers/gpu/drm/amd/amdgpu/navi10_ih.c
> @@ -409,9 +409,11 @@ static u32 navi10_ih_get_wptr(struct amdgpu_device *adev,
>   	u32 wptr, tmp;
>   	struct amdgpu_ih_regs *ih_regs;
>   
> -	if (ih == &adev->irq.ih) {
> +	if (ih == &adev->irq.ih || ih == &adev->irq.ih_soft) {
>   		/* Only ring0 supports writeback. On other rings fall back
>   		 * to register-based code with overflow checking below.
> +		 * ih_soft ring doesn't have any backing hardware registers,
> +		 * update wptr and return.
>   		 */
>   		wptr = le32_to_cpu(*ih->wptr_cpu);
>   
> @@ -483,6 +485,9 @@ static void navi10_ih_set_rptr(struct amdgpu_device *adev,
>   {
>   	struct amdgpu_ih_regs *ih_regs;
>   
> +	if (ih == &adev->irq.ih_soft)
> +		return;
> +
>   	if (ih->use_doorbell) {
>   		/* XXX check if swapping is necessary on BE */
>   		*ih->rptr_cpu = ih->rptr;
> diff --git a/drivers/gpu/drm/amd/amdgpu/vega10_ih.c b/drivers/gpu/drm/amd/amdgpu/vega10_ih.c
> index cdd599a08125..03b7066471f9 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vega10_ih.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vega10_ih.c
> @@ -334,9 +334,11 @@ static u32 vega10_ih_get_wptr(struct amdgpu_device *adev,
>   	u32 wptr, tmp;
>   	struct amdgpu_ih_regs *ih_regs;
>   
> -	if (ih == &adev->irq.ih) {
> +	if (ih == &adev->irq.ih || ih == &adev->irq.ih_soft) {
>   		/* Only ring0 supports writeback. On other rings fall back
>   		 * to register-based code with overflow checking below.
> +		 * ih_soft ring doesn't have any backing hardware registers,
> +		 * update wptr and return.
>   		 */
>   		wptr = le32_to_cpu(*ih->wptr_cpu);
>   
> @@ -409,6 +411,9 @@ static void vega10_ih_set_rptr(struct amdgpu_device *adev,
>   {
>   	struct amdgpu_ih_regs *ih_regs;
>   
> +	if (ih == &adev->irq.ih_soft)
> +		return;
> +
>   	if (ih->use_doorbell) {
>   		/* XXX check if swapping is necessary on BE */
>   		*ih->rptr_cpu = ih->rptr;
> diff --git a/drivers/gpu/drm/amd/amdgpu/vega20_ih.c b/drivers/gpu/drm/amd/amdgpu/vega20_ih.c
> index 3b4eb8285943..2022ffbb8dba 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vega20_ih.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vega20_ih.c
> @@ -385,9 +385,11 @@ static u32 vega20_ih_get_wptr(struct amdgpu_device *adev,
>   	u32 wptr, tmp;
>   	struct amdgpu_ih_regs *ih_regs;
>   
> -	if (ih == &adev->irq.ih) {
> +	if (ih == &adev->irq.ih || ih == &adev->irq.ih_soft) {
>   		/* Only ring0 supports writeback. On other rings fall back
>   		 * to register-based code with overflow checking below.
> +		 * ih_soft ring doesn't have any backing hardware registers,
> +		 * update wptr and return.
>   		 */
>   		wptr = le32_to_cpu(*ih->wptr_cpu);
>   
> @@ -461,6 +463,9 @@ static void vega20_ih_set_rptr(struct amdgpu_device *adev,
>   {
>   	struct amdgpu_ih_regs *ih_regs;
>   
> +	if (ih == &adev->irq.ih_soft)
> +		return;
> +
>   	if (ih->use_doorbell) {
>   		/* XXX check if swapping is necessary on BE */
>   		*ih->rptr_cpu = ih->rptr;

