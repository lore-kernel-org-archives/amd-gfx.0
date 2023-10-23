Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52CD8C004C0
	for <amd-gfx@archiver.kernel.org>; Mon, 23 Oct 2023 15:15:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EA38F10E213;
	Mon, 23 Oct 2023 15:15:51 +0000 (UTC)
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com
 [IPv6:2a00:1450:4864:20::335])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D9F4110E213
 for <amd-gfx@lists.freedesktop.org>; Mon, 23 Oct 2023 15:15:49 +0000 (UTC)
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-40891d38e3fso13264325e9.1
 for <amd-gfx@lists.freedesktop.org>; Mon, 23 Oct 2023 08:15:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1698074148; x=1698678948; darn=lists.freedesktop.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ft+P8AFkGoXseAs18Ab1eZm3CekC4jLz8sOhfnru7dA=;
 b=WXmUcRtT/A0cNloCjk3wd6kHasRB36laj95MLtP/E5OWEIFAVe+jz1XA3fVfeftu8b
 B/GQMAgvYRionIL7JR0pkwuwldUv33H+ccD+/AewGOiE0CFMvDNZXr0hGcHQjTnNjUu3
 QDwvbynYkZexI4eRYQv0ZHTGYv17Vjnji9tpo7RTzW/E/Rg9/AkeExlt9QOMBjGuQqSZ
 Esh8JM6zPrpKvaL595898x9rL04pziqi+9ujG1/OKcdzbo8rXBd7v1z8VUzFkwPhEoUV
 nMTrGvqrQ5Lok7Kf9cX+0KWe/K/3oh6fcMTIVndOUTo5vndcsQSUnWbI1QLPuGY6q5Ul
 xlhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698074148; x=1698678948;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ft+P8AFkGoXseAs18Ab1eZm3CekC4jLz8sOhfnru7dA=;
 b=PhB5rPr5oDJs6fzEHQKgzT0+FgD+YjmiRj1EKHbmN6BZlfXPYPK1ugyJ4t9BzDkH0u
 5gpz5cOig1KwHXx67bquoWJEq7B5U04YCd/fG+CVHUh0VrAVGPwJa3mfhx9Tdh8eur0C
 +vN86tVJw77JyQRKyb68FATEqfQ5MncRubZ0EtgnquHxmhY9i7guYbjnaIKz5w93Hk/v
 mkBmen9asOkcvV5Q9XmiqocCny2WLPKyzcOWGDjUCb2djqesHA6zSJhIYPImNEFElsb6
 1fHf0euCkxOInRX/Aj39tKqvxYaIlHRntouPLpytO1YV+rInU4PXLb4zilaKgma8qqWO
 /U8w==
X-Gm-Message-State: AOJu0Ywz9jCDMZz4sGZPolmg4gtFrQLCtwG2A86rwqPcMoQvkGLtgA+W
 fLpKokw6Y96r91oftqwGNM4=
X-Google-Smtp-Source: AGHT+IHcVzrkKd0FUlFvZB/JrGR/GaYjf30aPhe6WWgR3ypA1zNYO8rl32vhlbcXawOu1Dr4sZmxnQ==
X-Received: by 2002:a05:600c:5122:b0:406:5b73:b6f9 with SMTP id
 o34-20020a05600c512200b004065b73b6f9mr7693619wms.35.1698074147835; 
 Mon, 23 Oct 2023 08:15:47 -0700 (PDT)
Received: from [10.254.108.106] (munvpn.amd.com. [165.204.72.6])
 by smtp.gmail.com with ESMTPSA id
 e38-20020a05600c4ba600b004075d5664basm14253196wmp.8.2023.10.23.08.15.45
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 23 Oct 2023 08:15:47 -0700 (PDT)
Message-ID: <38742906-869c-4bc6-9cce-ea3ea98873d4@gmail.com>
Date: Mon, 23 Oct 2023 17:15:43 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Revert "drm/amdgpu: remove vm sanity check from
 amdgpu_vm_make_compute"
To: Daniel Tang <danielzgtg.opensource@gmail.com>,
 amd-gfx@lists.freedesktop.org
References: <5984374.lOV4Wx5bFT@daniel-desktop2>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>
In-Reply-To: <5984374.lOV4Wx5bFT@daniel-desktop2>
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
Cc: Xiaogang Chen <xiaogang.chen@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 Felix Kuehling <Felix.Kuehling@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Am 23.10.23 um 15:06 schrieb Daniel Tang:
> That commit causes the screen to freeze a few moments after running
> clinfo on v6.6-rc7 and ROCm 5.6. Sometimes the rest of the computer
> including ssh also freezes. On v6.5-rc1, it only results in a NULL pointer
> deference message in dmesg and the process to become a zombie whose
> unkillableness prevents shutdown without REISUB. Although llama.cpp and
> hashcat were working in v6.2 and ROCm 5.6, broke, and are not fixed by
> this revert, pytorch-rocm is now working with stability and without
> whole-computer freezes caused by any accidental running of clinfo.
>
> This reverts commit 1d7776cc148b9f2f3ebaf1181662ba695a29f639.

That result doesn't make much sense. Felix please correct me, but AFAIK 
the ATS stuff was completely removed by now.

Are you sure that this is pure v6.6-rc7 and not some other patches 
applied? If yes than we must have missed something.

Regards,
Christian.

>
> Closes: https://github.com/RadeonOpenCompute/ROCm/issues/2596
> Signed-off-by: Daniel Tang <danielzgtg.opensource@gmail.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c | 12 ++++++------
>   1 file changed, 6 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> index 82f25996ff5e..602f311ab766 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> @@ -2243,16 +2243,16 @@ int amdgpu_vm_make_compute(struct amdgpu_device *adev, struct amdgpu_vm *vm)
>   	if (r)
>   		return r;
>   
> +	/* Sanity checks */
> +	if (!amdgpu_vm_pt_is_root_clean(adev, vm)) {
> +		r = -EINVAL;
> +		goto unreserve_bo;
> +	}
> +
>   	/* Check if PD needs to be reinitialized and do it before
>   	 * changing any other state, in case it fails.
>   	 */
>   	if (pte_support_ats != vm->pte_support_ats) {
> -		/* Sanity checks */
> -		if (!amdgpu_vm_pt_is_root_clean(adev, vm)) {
> -			r = -EINVAL;
> -			goto unreserve_bo;
> -		}
> -
>   		vm->pte_support_ats = pte_support_ats;
>   		r = amdgpu_vm_pt_clear(adev, vm, to_amdgpu_bo_vm(vm->root.bo),
>   				       false);
> --
> 2.40.1
>
>
>

