Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ADEA3EE14D0
	for <amd-gfx@archiver.kernel.org>; Thu,  7 Sep 2023 07:00:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 303E910E76A;
	Thu,  7 Sep 2023 07:00:29 +0000 (UTC)
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com
 [IPv6:2a00:1450:4864:20::52a])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3694F10E775
 for <amd-gfx@lists.freedesktop.org>; Thu,  7 Sep 2023 07:00:27 +0000 (UTC)
Received: by mail-ed1-x52a.google.com with SMTP id
 4fb4d7f45d1cf-52a1ce52ef4so688528a12.2
 for <amd-gfx@lists.freedesktop.org>; Thu, 07 Sep 2023 00:00:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1694070025; x=1694674825; darn=lists.freedesktop.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=jmnxSzDkvKGR2hPLH152vBO0XkyIL4M9mrlshXEQ6t4=;
 b=GvGyalxRa9aYqVUYI3DNOQ5ROpx50mPkoxtq6aIdUH3UuZ3lkI6pqi31uIDzfMv/vH
 RYqoIXvdte2To6czuSjI1oUkHMr7/pX8FrU+qVolEeXbPdQdnZCWLlPtKbJ+DW265tKq
 IvW+fNXdthvb3qSQ6dlOW7wcDbPfLST0+sm20E7AnuB+8fIisybRN8Uf8MalQ6+STiyF
 XOqbBufnBiznqeP7LwYZKvx11eo+8Lsu5QzHsrC/+YHGfHwZl3pEAS15BN9eTdqi+3/P
 uJp5TjfkRIJPjkjc6OGBlqCh7Tnvjp5fufDbc8DlY8iSPQ+7m5VvoXGJ8X8Oz5JH0fuX
 jPRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1694070025; x=1694674825;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=jmnxSzDkvKGR2hPLH152vBO0XkyIL4M9mrlshXEQ6t4=;
 b=kTWQjegOTdwCPrxij6xckQvTColMy4zi9JR56ENCo6Yn+8waVq3fd3CxGlUxHxp3kY
 Xq+jsC6WmBbtTGyoOyGYoenskY8Lw+ql/DSZ44mc1nAsr+suhoAqSnur0IgMyDtHRzA5
 /oP1b1U43ewEP2WWG/Xyko1nAKHmmBg8IbDk3nArIbH/onMxyMwzUuNDRJf6x+7p87/R
 Iz84gHl+3SPeqXhUzb4sz1hUbA6mZZ4y6RjTV1DHvdkIF+hqg0+maqUv231M5oO3KXsS
 5mG3HXQkCC4qkyCUX31eUkD5h/zVvwZTRRodrq1FGIgWCMHmzwwoXvbbmMFPp0Z31oGa
 EXwg==
X-Gm-Message-State: AOJu0YyFYbLLgdOVqxse3tQ3iXPQD1lz7vlFH66Z/yx8ifTaVPfHShy8
 3lGSyM7m4xgB/AorebyyJH8=
X-Google-Smtp-Source: AGHT+IGgHTT/F91XCJgmYaF+Fgu19Xc90BMafwZVazOwkQDWreRu42n9CpNh1lSCWE+uF6vWt1XOzw==
X-Received: by 2002:a17:906:8a74:b0:9a5:bcea:a53a with SMTP id
 hy20-20020a1709068a7400b009a5bceaa53amr3735770ejc.33.1694070025362; 
 Thu, 07 Sep 2023 00:00:25 -0700 (PDT)
Received: from [192.168.178.25] ([134.19.111.81])
 by smtp.gmail.com with ESMTPSA id
 g2-20020a1709064e4200b00997cce73cc7sm10005457ejw.29.2023.09.07.00.00.11
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 07 Sep 2023 00:00:19 -0700 (PDT)
Message-ID: <f1ee0f19-0d8b-23e1-6cc6-c3e778a68e2a@gmail.com>
Date: Thu, 7 Sep 2023 09:00:08 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH] drm/amdgpu/soc21: don't remap HDP registers for SR-IOV
Content-Language: en-US
To: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
References: <20230906153623.507284-1-alexander.deucher@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
In-Reply-To: <20230906153623.507284-1-alexander.deucher@amd.com>
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

Am 06.09.23 um 17:36 schrieb Alex Deucher:
> This matches the behavior for soc15 and nv.
>
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>

Acked-by: Christian König <christian.koenig@amd.com>

> ---
>   drivers/gpu/drm/amd/amdgpu/soc21.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/soc21.c b/drivers/gpu/drm/amd/amdgpu/soc21.c
> index ef297b41623b..2ecc8c9a078b 100644
> --- a/drivers/gpu/drm/amd/amdgpu/soc21.c
> +++ b/drivers/gpu/drm/amd/amdgpu/soc21.c
> @@ -778,7 +778,7 @@ static int soc21_common_hw_init(void *handle)
>   	 * for the purpose of expose those registers
>   	 * to process space
>   	 */
> -	if (adev->nbio.funcs->remap_hdp_registers)
> +	if (adev->nbio.funcs->remap_hdp_registers && !amdgpu_sriov_vf(adev))
>   		adev->nbio.funcs->remap_hdp_registers(adev);
>   	/* enable the doorbell aperture */
>   	adev->nbio.funcs->enable_doorbell_aperture(adev, true);

