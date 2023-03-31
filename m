Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0FA5C6FD18
	for <amd-gfx@archiver.kernel.org>; Fri, 31 Mar 2023 06:17:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E8E4D10E2E7;
	Fri, 31 Mar 2023 06:17:20 +0000 (UTC)
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com
 [IPv6:2a00:1450:4864:20::52c])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9709D10E2E7
 for <amd-gfx@lists.freedesktop.org>; Fri, 31 Mar 2023 06:17:18 +0000 (UTC)
Received: by mail-ed1-x52c.google.com with SMTP id eh3so85485115edb.11
 for <amd-gfx@lists.freedesktop.org>; Thu, 30 Mar 2023 23:17:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20210112; t=1680243437;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=hVHmE+XjgN7Y/glNDVOp/arWpP7IZ21W9nlf3Ghci04=;
 b=OdUFDzB+njw38KGGjIUeJBPcPtNdfHjj4x4yTbzzIY9hCnTL4UuEu2oyjiyUmj6TKM
 KifEV48jWuYB22cd+v9QKEZzOoJI5wGnlvxWk+dUTlSZ6KBFX77duePyvaGWPtZ5EaVe
 AW2n1658ZXf4KDTFba4pGYMul9DIw32DYvxj6VoRpVI5M+eXuBp5koY6V/RpcIzf+X2X
 syllT8UOhnXf1G5Yr207E/RCftVtCRos6OQxYNm71ftR9HMdBdzQKERbclEuA+DjZZJX
 K43tYBSGV9qBPXTDyk4/FdiuJrEEoyyOoAg76S6ZvUqiWlicLU1tkg0xLYzMj6DilAKU
 DygQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112; t=1680243437;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=hVHmE+XjgN7Y/glNDVOp/arWpP7IZ21W9nlf3Ghci04=;
 b=lmQPUFLxtXNjqvfJPL6daYApzmM5N6gh+1bTw3JYBvp21wZpDk9Hv510ycCSbLd0Vk
 sXoI4RKBRD9zKaHjL7Jyu9IHfuklnEVykbeViWn1bD4E+mX/d1FVVAvzbNzMOdATS/cH
 s7fn0j/H+1MDFG2KvaZdT8x3joqUlQzL5XMzgOhoath7LX7Tsei/9Ok645pdZUbTLVTq
 nqDiXk/qahIxAJAQJXcsG+84YhR1jTVJZf5yW+iYlw2SX4pDodIpusExs5ILN6o0G0L1
 jm/NwqBZB77MQa6zQP4TFV7GlvYFbTWqxTgwBriYEG8vqrLapOiRmLM6qXTtkL0SlRO5
 FEjw==
X-Gm-Message-State: AAQBX9fEWovZLqUrSjO5od7GOY172qJp9g5TAbjQ/TtlYcY3CX3HhPvI
 lxEwmhuGFOgXIf6zyjlzUX2LzQaLWFa1Ag==
X-Google-Smtp-Source: AKy350bYfOK1m3yOKj+2qObGCcKfSk6qnkKTq7BQHmN08/9PO4CZCxiJpU3fgyTZiRDbNr72Qnoeqw==
X-Received: by 2002:a17:907:8a08:b0:944:44d:c736 with SMTP id
 sc8-20020a1709078a0800b00944044dc736mr24710774ejc.64.1680243436958; 
 Thu, 30 Mar 2023 23:17:16 -0700 (PDT)
Received: from [192.168.178.21] (p4fc2092b.dip0.t-ipconnect.de. [79.194.9.43])
 by smtp.gmail.com with ESMTPSA id
 u25-20020a170906109900b008e22978b98bsm606020eju.61.2023.03.30.23.17.15
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 30 Mar 2023 23:17:16 -0700 (PDT)
Message-ID: <91105af7-a7ed-bb82-d3ae-96b31ed4c465@gmail.com>
Date: Fri, 31 Mar 2023 08:17:15 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH 7/8] drm/amd: fix compiler error to support older compilers
Content-Language: en-US
To: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
References: <20230330194843.1136162-1-alexander.deucher@amd.com>
 <20230330194843.1136162-7-alexander.deucher@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
In-Reply-To: <20230330194843.1136162-7-alexander.deucher@amd.com>
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
Cc: Mukul Joshi <mukul.joshi@amd.com>,
 Harish Kasiviswanathan <Harish.Kasiviswanathan@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Am 30.03.23 um 21:48 schrieb Alex Deucher:
> From: Harish Kasiviswanathan <Harish.Kasiviswanathan@amd.com>
>
> ‘for’ loop initial declarations are only allowed in C99 or C11 mode

This isn't necessary any more and can be dropped.

Christian.

>
> Signed-off-by: Harish Kasiviswanathan <Harish.Kasiviswanathan@amd.com>
> Reviewed-by: Mukul Joshi <mukul.joshi@amd.com>
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/aqua_vanjaram_reg_init.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/aqua_vanjaram_reg_init.c b/drivers/gpu/drm/amd/amdgpu/aqua_vanjaram_reg_init.c
> index 55a6ebb940ba..fdc728f678d7 100644
> --- a/drivers/gpu/drm/amd/amdgpu/aqua_vanjaram_reg_init.c
> +++ b/drivers/gpu/drm/amd/amdgpu/aqua_vanjaram_reg_init.c
> @@ -360,7 +360,7 @@ static int aqua_vanjaram_xcp_mgr_init(struct amdgpu_device *adev)
>   
>   int aqua_vanjaram_init_soc_config(struct amdgpu_device *adev)
>   {
> -	u32 inst_mask = adev->sdma.sdma_mask;
> +	u32 mask, inst_mask = adev->sdma.sdma_mask;
>   	int ret, i, num_inst;
>   
>   	/* generally 1 AID supports 4 instances */
> @@ -370,7 +370,7 @@ int aqua_vanjaram_init_soc_config(struct amdgpu_device *adev)
>   	adev->aid_mask = i = 1;
>   	inst_mask >>= adev->sdma.num_inst_per_aid;
>   
> -	for (const u32 mask = (1 << adev->sdma.num_inst_per_aid) - 1; inst_mask;
> +	for (mask = (1 << adev->sdma.num_inst_per_aid) - 1; inst_mask;
>   	     inst_mask >>= adev->sdma.num_inst_per_aid, ++i) {
>   		if ((inst_mask & mask) == mask)
>   			adev->aid_mask |= (1 << i);

