Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E8B1C25B06
	for <amd-gfx@archiver.kernel.org>; Sun, 14 Aug 2022 17:28:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 39FB3113973;
	Sun, 14 Aug 2022 17:27:59 +0000 (UTC)
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com
 [IPv6:2a00:1450:4864:20::634])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 139E4113911
 for <amd-gfx@lists.freedesktop.org>; Sun, 14 Aug 2022 17:27:46 +0000 (UTC)
Received: by mail-ej1-x634.google.com with SMTP id uj29so10149322ejc.0
 for <amd-gfx@lists.freedesktop.org>; Sun, 14 Aug 2022 10:27:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc; bh=nWClOwpoY3Ei6zDuINLn7TmV0EfGatrhDBkAGwlazi8=;
 b=E76eMTPu9rl5grBJ4GI1+THhwpfk7ahmgojuROyDBAgoin9ZkhPtN4dtsjVlkIh+WH
 d5mdxaLGC3TNEipHfE0MPDaTXcmipD/uBRsJYgEmoDAMvNSZCwwIyM7OeWi2mmjvO75R
 /yA0nRye0Lqnoz67S+XgKUm33h4bmW1FnSAQ6iTGv1cE1SVSlOEpMilMRrlFAX5Xw8/B
 fyCzxb9TvnK+1+qblMKSHrZ3C9Xc7R/t1f6Z/R3yPD7vPa9jkijkBEdkybKcAKsT5ix1
 fXSOy0M2xaJ2PGDvQfuNuB4zShkWLqwRZajye6JHben0mlylDb9k0+wRv4/soYq8b+kA
 PrZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc;
 bh=nWClOwpoY3Ei6zDuINLn7TmV0EfGatrhDBkAGwlazi8=;
 b=fg3SO6+IbHAlbQDzh6Z2bdcPZ4rTP9R7wKf4EIBkPn5NBdbzvIH0qPoB52Q8TpnZlk
 dF1UkwJoOJabLEGKY5qtCAnKLKUUUDGEauMnObEKraEtmz77kMvVBSJkcy519QiouTGy
 xt0xSxQPbE0R9ggPGBtaYFxzLA2txUAr/Bsag/MSQKzjXaU1Ft6Sd2iwCH/329fcvPAf
 B1SbM7x0Fkg3Lc2Q3fOYIkAMycqTZtqAG5tHjDhhFn+NUqY2hrk2T5WBYtVwIVjZ5ajD
 MGKR/o3UviDAnmqzMzcgUGGLguJWSPO+jV37QbltJjxv/SGO+j2oaaPS3DzMlXsuS9RV
 ADug==
X-Gm-Message-State: ACgBeo2wsLBJph2DEVCp2gsewVaBt0iqtQ1eX7uSXEvO9+a6Lpw2jME7
 rnW0OZZADDJqFBJXovRZX+M=
X-Google-Smtp-Source: AA6agR5dP8KiANm4HjlCPdFfc51WkXWBMNhlGe6c4caWroh2PRzgiLxKlRIlNAv7u5zAr/RVEzTbZQ==
X-Received: by 2002:a17:906:5a5a:b0:730:ba28:292c with SMTP id
 my26-20020a1709065a5a00b00730ba28292cmr8128007ejc.312.1660498064573; 
 Sun, 14 Aug 2022 10:27:44 -0700 (PDT)
Received: from ?IPV6:2a02:908:1256:79a0:fb92:e16e:a0f2:319d?
 ([2a02:908:1256:79a0:fb92:e16e:a0f2:319d])
 by smtp.gmail.com with ESMTPSA id
 23-20020a170906309700b007317f00a6d9sm3109925ejv.208.2022.08.14.10.27.43
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 14 Aug 2022 10:27:44 -0700 (PDT)
Message-ID: <c761f5f9-eb52-c04b-e66f-1c05cfb2c2c1@gmail.com>
Date: Sun, 14 Aug 2022 19:27:42 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH] drm/amdgpu: Fix interrupt handling on ih_soft ring
Content-Language: en-US
To: Mukul Joshi <mukul.joshi@amd.com>, amd-gfx@lists.freedesktop.org
References: <20220812205624.2902630-1-mukul.joshi@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
In-Reply-To: <20220812205624.2902630-1-mukul.joshi@amd.com>
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
Cc: Felix.Kuehling@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Am 12.08.22 um 22:56 schrieb Mukul Joshi:
> There are no backing hardware registers for ih_soft ring.
> As a result, don't try to access hardware registers for read
> and write pointers when processing interrupts on the IH soft
> ring.

Mhm, the original plan was to have different ih function for the rings 
but I think we just forgot to implement this fully.

When you do it this way you need to apply it to a bunch of different hw 
generation as Felix mentioned as well.

Might be easier to clean that up.

Regards,
Christian.

>
> Signed-off-by: Mukul Joshi <mukul.joshi@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/vega20_ih.c | 7 ++++++-
>   1 file changed, 6 insertions(+), 1 deletion(-)
>
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

