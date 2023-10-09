Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AADDBE95A96
	for <amd-gfx@archiver.kernel.org>; Mon,  9 Oct 2023 08:51:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 49FAE10E21F;
	Mon,  9 Oct 2023 08:51:36 +0000 (UTC)
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com
 [IPv6:2a00:1450:4864:20::632])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0930D10E21F
 for <amd-gfx@lists.freedesktop.org>; Mon,  9 Oct 2023 08:51:35 +0000 (UTC)
Received: by mail-ej1-x632.google.com with SMTP id
 a640c23a62f3a-9b974955474so725078466b.1
 for <amd-gfx@lists.freedesktop.org>; Mon, 09 Oct 2023 01:51:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1696841493; x=1697446293; darn=lists.freedesktop.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=I1BZgivYrr2wZ87636Ehe+++s8VYec4YTXZChOuKZng=;
 b=WdrnWRWJvsp+LOBfiItaYv3+5ITKinQTgyaTatsJZMffu0qU1RCo9BvEb+4cqWWhQg
 UC7L0A6bk1ChgxBMOyn4b1kvHqz2/Cg/VW2N9WJYqPNzgktYqzjmbQ93q8GFfGXHUd0S
 7bodsuAnHas+JCLDVcCjb73kYwvrxmuMSMiAtw2Wdcl08YCU2U6qPXiWw+PZjw9OJw3l
 qdJJC6Chk4IZTcDJHdapgbX7q6pjNgccETRjqwmIodPZ5yT4FPHdAYY3smtlmHS+rVU0
 FWkL6PWw2bi8K/+ehoFe3btN73j08NsHsvdRdVE7l8IW+XWbtooXdTO8f44Nsd+iQMxB
 1d2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696841493; x=1697446293;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=I1BZgivYrr2wZ87636Ehe+++s8VYec4YTXZChOuKZng=;
 b=elxQ49CBaTi8VY7OmfJbn+BBc/w/14iapYjSdV389aBzfEGI/E0Ba248DeeoE6Wd1C
 w/p0zVs3Lpaw6Fr9hsH4aSf0LmiaY+x8+YPAq3a0Qi1zpgyJkN+1nJXQmI01xuxSmLOT
 WbR/HK5AHcUEy/HRoUACzXm76Iy/DjvLWudKZL67nwRNlVIMr/GzOIEce3H2Vz2aIuh7
 cXRt5XGN0ioDZ8o6ljfRnslwYbgJJkUWRmFMMrwkSLkDmBQGiraCwBSLMhH8/A4SaRiM
 5au2+eznsyrYHmQA0I7LNgBL2EUyqHV11aN9gawARbe7mFcJHRPsdUg3Q6bQjXRp3GmT
 7GDw==
X-Gm-Message-State: AOJu0YwkBmYS4NLsrd/l+Q4o+zTDOd7b7d2rCezYsGTllrTa440WQRmq
 K/HdVCVQ2LFCkOglIi/dDkU=
X-Google-Smtp-Source: AGHT+IFadjSJunabPoRjBhbdxzhBNAjo1np2azSue5QtpvvKIE2ZDxJQHZsXabTvVJAkfdGlGNeuIQ==
X-Received: by 2002:a17:906:100e:b0:99d:fd27:b38d with SMTP id
 14-20020a170906100e00b0099dfd27b38dmr13136853ejm.70.1696841493190; 
 Mon, 09 Oct 2023 01:51:33 -0700 (PDT)
Received: from [192.168.178.25] ([134.19.31.182])
 by smtp.gmail.com with ESMTPSA id
 q24-20020a1709060e5800b0098884f86e41sm6375274eji.123.2023.10.09.01.51.31
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 09 Oct 2023 01:51:32 -0700 (PDT)
Message-ID: <10a568bd-e514-4ce1-b3d5-3c7534a8f3e7@gmail.com>
Date: Mon, 9 Oct 2023 10:51:31 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu:Check gfx poweron when skip flush_gpu_tlb
Content-Language: en-US
To: "Xu, Feifei" <Feifei.Xu@amd.com>,
 "Wang, Yang(Kevin)" <KevinYang.Wang@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
References: <20231008100642.1915677-1-Feifei.Xu@amd.com>
 <PH7PR12MB59972CEAF0241F48E6B342CE82CFA@PH7PR12MB5997.namprd12.prod.outlook.com>
 <CH2PR12MB4152A458EC29B83672A600FCFECEA@CH2PR12MB4152.namprd12.prod.outlook.com>
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>
In-Reply-To: <CH2PR12MB4152A458EC29B83672A600FCFECEA@CH2PR12MB4152.namprd12.prod.outlook.com>
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
Cc: "Koenig, Christian" <Christian.Koenig@amd.com>, "Zhang,
 Hawking" <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Am 09.10.23 um 03:50 schrieb Xu, Feifei:
> [AMD Official Use Only - General]
>
> Hi,
>
>>> Based on your description, the above code should use "||" instead of "&&",
> && is to add more restriction here.  To avoid skipping necessary TLB flush by return.
> For Asics < GFX11, !adev->gfx.is_poweron is always true (this paremeter is intrudoced from GFX11), only depends on reset_domain->sem;
> For Asics = GFX11, !adev->gfx.is_poweron might be false (which gfx might already poweron in the reset), this will make the if () not ture, return will not be executed, thus flush TLB.

First of all the patch is broken because you only handle the locking, 
but not the unlocking part.

Then a TLB flush shouldn't be necessary on reset. A reset implies that 
the TLB is cleared as well.

We discussed the possibility to avoid that, but this is not supposed to 
be happening at the moment.

Regards,
Christian.

>
>>> And after merging code into one line may result in the lock not being released if the lock can be acquired success.
> If !adev->gfx.is_poweron is true, the reset_domin->sem will not be down_read_trylock, thus could avoid this deadlock.

>
> Thanks,
> Feifei
>
> -----Original Message-----
> From: Wang, Yang(Kevin) <KevinYang.Wang@amd.com>
> Sent: Sunday, October 8, 2023 9:36 PM
> To: Xu, Feifei <Feifei.Xu@amd.com>; amd-gfx@lists.freedesktop.org
> Cc: Xu, Feifei <Feifei.Xu@amd.com>; Xu, Feifei <Feifei.Xu@amd.com>; Koenig, Christian <Christian.Koenig@amd.com>; Zhang, Hawking <Hawking.Zhang@amd.com>
> Subject: RE: [PATCH] drm/amdgpu:Check gfx poweron when skip flush_gpu_tlb
>
>
> -----Original Message-----
> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Feifei Xu
> Sent: Sunday, October 8, 2023 6:07 PM
> To: amd-gfx@lists.freedesktop.org
> Cc: Xu, Feifei <Feifei.Xu@amd.com>; Xu, Feifei <Feifei.Xu@amd.com>; Koenig, Christian <Christian.Koenig@amd.com>; Zhang, Hawking <Hawking.Zhang@amd.com>
> Subject: [PATCH] drm/amdgpu:Check gfx poweron when skip flush_gpu_tlb
>
> To fix the gpu recovery failed on GFX11 with gfxhub pagefault, flush gpu tlb after reset on GFX11.
> Gfxhub tlb flush need check if adev->gfx.is_poweron set.
>
> Fixes: d0c860f33553 ("drm/amdgpu: rework lock handling for flush_tlb v2")
>
> Signed-off-by: Feifei Xu <Feifei.Xu@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
> index 2f9bb86edd71..048d32edee88 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
> @@ -611,8 +611,9 @@ void amdgpu_gmc_flush_gpu_tlb(struct amdgpu_device *adev, uint32_t vmid,
>                  /*
>                   * A GPU reset should flush all TLBs anyway, so no need to do
>                   * this while one is ongoing.
> +                * For GFX11, gfxhub flush check if adev->gfx.is_poweron is set.
>                   */
> -               if (!down_read_trylock(&adev->reset_domain->sem))
> +               if (!down_read_trylock(&adev->reset_domain->sem) &&
> +!adev->gfx.is_poweron)
>                          return;
>
> [Kevin]:
> Based on your description, the above code should use "||" instead of "&&",
> And after merging code into one line may result in the lock not being released if the lock can be acquired success.
>
> Best Regards,
> Kevin
>
>                  if (adev->gmc.flush_tlb_needs_extra_type_2)
> --
> 2.34.1
>

