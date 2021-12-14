Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE57AC433EF
	for <amd-gfx@archiver.kernel.org>; Tue, 14 Dec 2021 13:02:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8BB1310E460;
	Tue, 14 Dec 2021 13:02:50 +0000 (UTC)
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com
 [IPv6:2a00:1450:4864:20::336])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0B5ED10E460
 for <amd-gfx@lists.freedesktop.org>; Tue, 14 Dec 2021 13:02:48 +0000 (UTC)
Received: by mail-wm1-x336.google.com with SMTP id p18so14161411wmq.5
 for <amd-gfx@lists.freedesktop.org>; Tue, 14 Dec 2021 05:02:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-transfer-encoding:content-language;
 bh=P4qaOjJ2KyN1/UuxjmnfNBcO258N4jfydSGy3dL1fQo=;
 b=P28VUFKgZ8nhY7Zm+FLwIDjHs5+wLhUujmq46ERi6oAXstnXERXOUWr0EDdhcVxgly
 NeRWpbkMlGcXqPNsOKWMJ6ADCu9eWpM9LOJopUXc9PSoS+ZBCj7lA4IrJ6T5505Df2gP
 k1O7G4yjPklMciH/ngt2F4xROzhaKNdFjAbOn1HLv/+SILTFyPSvHtBPuc6KouiFGf2Z
 TwxJ6Z1Z2qX9wN3QaP+tQjyr8y1+gNKVHC1QA/w+Dg9K0yohTvAwKZQLL4xRGphAnbtj
 59Bxdzy4LLKMuAMYsa8SMbwKspryBmstqzEpW4FTs0Ld4NuZDS+mMyL5G7MPHBLTftFn
 HTNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=P4qaOjJ2KyN1/UuxjmnfNBcO258N4jfydSGy3dL1fQo=;
 b=K3MUTqqd3zHBUTg8/vjbMWFfbaRxSAHC0UGExT4C1G8Wk23a5Wt/t1CNznL55r4h6d
 cfihNPW8+CRLqIdgPyiLuCdCWb+0yaoqbsy+Odgcm2JLSTVc8XQeMt++p/zG21VfmcnR
 5K5fHFeWrw07KnE0z7WLprurOLJnZS5jqO2KKtdhAqCv45RB0jwFj+fKAdIM4NqMnIKh
 uWu1fy2hRXF3s5AdqBrBVupvMYEaQooH6GnpNlt3F3NppD4wCv/SlAKDVEIpzv8pomBo
 BcpG0BFtpVJfbYA3SQ8QC52jUNOQ9SMndfUzcixmy02TfuhxkOb6Shbt9vzOyEeTr7de
 Ef6Q==
X-Gm-Message-State: AOAM5313y6r8W6zEVLZg01G2MiNqL7q5jwXfKkO5v9V8hc/muLn6lkEO
 wJgIlS+A2DEdfm3Ebyppk34=
X-Google-Smtp-Source: ABdhPJyp2C2uSSyLJGW+GMV4zeLqtQqpnbHg83xPmLPu2sH3KyJtRqUIRcPfN9+PviKLC8s8Xkb+mQ==
X-Received: by 2002:a05:600c:17c3:: with SMTP id
 y3mr44685985wmo.136.1639486967495; 
 Tue, 14 Dec 2021 05:02:47 -0800 (PST)
Received: from ?IPv6:2a02:908:1252:fb60:65ee:6e65:8955:bfe8?
 ([2a02:908:1252:fb60:65ee:6e65:8955:bfe8])
 by smtp.gmail.com with ESMTPSA id h15sm2427250wmq.32.2021.12.14.05.02.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 14 Dec 2021 05:02:46 -0800 (PST)
Subject: Re: [PATCH v2 2/2] drm/amd/amdgpu: fix gmc bo pin count leak in SRIOV
To: Jingwen Chen <Jingwen.Chen2@amd.com>, amd-gfx@lists.freedesktop.org
References: <20211214041751.23647-1-Jingwen.Chen2@amd.com>
 <20211214041751.23647-2-Jingwen.Chen2@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
Message-ID: <924094d9-247c-4b8e-f073-e81ce0c3a7f3@gmail.com>
Date: Tue, 14 Dec 2021 14:02:45 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20211214041751.23647-2-Jingwen.Chen2@amd.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
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
Cc: horace.chen@amd.com, monk.liu@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Am 14.12.21 um 05:17 schrieb Jingwen Chen:
> [Why]
> gmc bo will be pinned during loading amdgpu and reset in SRIOV while
> only unpinned in unload amdgpu
>
> [How]
> add amdgpu_in_reset and sriov judgement to skip pin bo
>
> v2: fix wrong judgement
>
> Signed-off-by: Jingwen Chen <Jingwen.Chen2@amd.com>

Nirmoy already had a different patch set to stop unpin/pin on 
suspend/resume removing those code paths altogether.

He's just on parental leave right now, but I think those patches where 
ready and just needed testing.

Regards,
Christian.

> ---
>   drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c | 4 ++++
>   drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c  | 4 ++++
>   2 files changed, 8 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
> index d696c4754bea..ae46eb35b3d7 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
> @@ -992,10 +992,14 @@ static int gmc_v10_0_gart_enable(struct amdgpu_device *adev)
>   		return -EINVAL;
>   	}
>   
> +	if (amdgpu_sriov_vf(adev) && amdgpu_in_reset(adev))
> +		goto skip_pin_bo;
> +
>   	r = amdgpu_gart_table_vram_pin(adev);
>   	if (r)
>   		return r;
>   
> +skip_pin_bo:
>   	r = adev->gfxhub.funcs->gart_enable(adev);
>   	if (r)
>   		return r;
> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
> index db2ec84f7237..d91eb7eb0ebe 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
> @@ -1717,10 +1717,14 @@ static int gmc_v9_0_gart_enable(struct amdgpu_device *adev)
>   		return -EINVAL;
>   	}
>   
> +	if (amdgpu_sriov_vf(adev) && amdgpu_in_reset(adev))
> +		goto skip_pin_bo;
> +
>   	r = amdgpu_gart_table_vram_pin(adev);
>   	if (r)
>   		return r;
>   
> +skip_pin_bo:
>   	r = adev->gfxhub.funcs->gart_enable(adev);
>   	if (r)
>   		return r;

