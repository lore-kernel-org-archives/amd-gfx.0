Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C9B4C761A6
	for <amd-gfx@archiver.kernel.org>; Thu, 30 Mar 2023 11:10:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5DF0510EDAA;
	Thu, 30 Mar 2023 11:10:39 +0000 (UTC)
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com
 [IPv6:2a00:1450:4864:20::52a])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CA1B810EDAA
 for <amd-gfx@lists.freedesktop.org>; Thu, 30 Mar 2023 11:10:35 +0000 (UTC)
Received: by mail-ed1-x52a.google.com with SMTP id r11so74938409edd.5
 for <amd-gfx@lists.freedesktop.org>; Thu, 30 Mar 2023 04:10:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20210112; t=1680174634;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=MDvuTqd7S9DX/7jzCutaeddF7u3wOqL5qCi70LHUmos=;
 b=JtFOI8m8EOr8P2P9LL3wL3RA83T/MymIATi3qo1N99o44Ly7iBsChyP2Z2Sllk28I2
 JbIqIivg3usIFhmL7sEIxLn0T9z5YkeN3LIv6Y+yEg7E5eBQVD4LO2ebQue+LreQQ1Zf
 SwnGpV2ixR0fx9l5oTj2RSAjouQgeGTxEhELiQLykh7i0xVeROKlQT1t57VnNPac3m30
 0KksiKT0W80isDo44d1EUcZK4Xvfu6ePw9cue3bXrIgs3qydXtYZIWMulBxvJBN52owY
 rQBZhJkTv4LAYXMcXpw1CHJEb8SbeRTngla7j/BFofbd643xE1ThjzCjO9lQFKUAs0S/
 grZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112; t=1680174634;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=MDvuTqd7S9DX/7jzCutaeddF7u3wOqL5qCi70LHUmos=;
 b=jsotLTBK4BfDGvxRIoY0esL/i2KuhPCJwwzbWTXdYRlxl72J2NcMo8DBdnRdkbqNXg
 aPRXouUn6G67n3/oLGX+JFwPp0DvuxcwgWxjG+HoM7qD9yxrOaJB6Pxv9/nSmqTeuI4s
 DFthkUl5MKUpCXZg3e7/9Z+vulArLjfvD90O1HXJKk2MVVYEMqXcUuFy5IRN8g6Bv1+G
 UDsRNwvHz+/BqPWJveu7ZV6wi1JqaEhKMC5AvMHyDow0nIlrKjwGnj8qJbF4qc07vFcd
 21RNNdyyzS4RFQEPurfVWYLSg09pfq5LuWeBx8AjlLCpJ83hkTHPrWQQ1QboHZtx4UC+
 9Vnw==
X-Gm-Message-State: AAQBX9enmWqN9aK62lj62uS9f+tUQZq8OvcNWluejfdGnoeKBfrFlhN/
 QppC8xjYzwdeFUhTfS+h670=
X-Google-Smtp-Source: AKy350aNdkq6eYZ7WnokjPwBKbcWZe+RPK3UthKDsRPpZzIdTBefxY/X/gw5ILVIJzkuf4Xn0ltdlQ==
X-Received: by 2002:a17:906:198e:b0:93d:770:25df with SMTP id
 g14-20020a170906198e00b0093d077025dfmr22637466ejd.37.1680174634079; 
 Thu, 30 Mar 2023 04:10:34 -0700 (PDT)
Received: from [192.168.178.21] (p4fc2092b.dip0.t-ipconnect.de. [79.194.9.43])
 by smtp.gmail.com with ESMTPSA id
 tk20-20020a170907c29400b0094770cf8b1fsm355831ejc.5.2023.03.30.04.10.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 30 Mar 2023 04:10:33 -0700 (PDT)
Message-ID: <27617c68-8c5f-fddb-6fe1-14ef5070f48d@gmail.com>
Date: Thu, 30 Mar 2023 13:10:32 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH 04/16] drm/amdgpu: don't modify num_doorbells for mes
Content-Language: en-US
To: Shashank Sharma <shashank.sharma@amd.com>, amd-gfx@lists.freedesktop.org
References: <20230329154753.1261-1-shashank.sharma@amd.com>
 <20230329154753.1261-5-shashank.sharma@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
In-Reply-To: <20230329154753.1261-5-shashank.sharma@amd.com>
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Mukul Joshi <mukul.joshi@amd.com>,
 Felix Kuehling <felix.kuehling@amd.com>,
 Shashank Sharma <contactshashanksharma@gmail.com>,
 Christian Koenig <christian.koenig@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Am 29.03.23 um 17:47 schrieb Shashank Sharma:
> From: Shashank Sharma <contactshashanksharma@gmail.com>
>
> This patch removes the check and change in num_kernel_doorbells
> for MES, which is not being used anywhere by MES code.
>
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Cc: Christian Koenig <christian.koenig@amd.com>
> Signed-off-by: Shashank Sharma <shashank.sharma@amd.com>

Reviewed-by: Christian König <christian.koenig@amd.com>

> ---
>   .../gpu/drm/amd/amdgpu/amdgpu_doorbell_mgr.c  | 34 ++++++++-----------
>   1 file changed, 15 insertions(+), 19 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_doorbell_mgr.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_doorbell_mgr.c
> index 2206926ba289..1aea92363fd3 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_doorbell_mgr.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_doorbell_mgr.c
> @@ -143,25 +143,21 @@ int amdgpu_device_doorbell_init(struct amdgpu_device *adev)
>   	adev->doorbell.base = pci_resource_start(adev->pdev, 2);
>   	adev->doorbell.size = pci_resource_len(adev->pdev, 2);
>   
> -	if (adev->enable_mes) {
> -		adev->doorbell.num_kernel_doorbells =
> -			adev->doorbell.size / sizeof(u32);
> -	} else {
> -		adev->doorbell.num_kernel_doorbells =
> -			min_t(u32, adev->doorbell.size / sizeof(u32),
> -			      adev->doorbell_index.max_assignment+1);
> -		if (adev->doorbell.num_kernel_doorbells == 0)
> -			return -EINVAL;
> -
> -		/* For Vega, reserve and map two pages on doorbell BAR since SDMA
> -		 * paging queue doorbell use the second page. The
> -		 * AMDGPU_DOORBELL64_MAX_ASSIGNMENT definition assumes all the
> -		 * doorbells are in the first page. So with paging queue enabled,
> -		 * the max num_kernel_doorbells should + 1 page (0x400 in dword)
> -		 */
> -		if (adev->asic_type >= CHIP_VEGA10)
> -			adev->doorbell.num_kernel_doorbells += 0x400;
> -	}
> +	adev->doorbell.num_kernel_doorbells =
> +		min_t(u32, adev->doorbell.size / sizeof(u32),
> +				adev->doorbell_index.max_assignment+1);
> +	if (adev->doorbell.num_kernel_doorbells == 0)
> +		return -EINVAL;
> +
> +	/*
> +	 * For Vega, reserve and map two pages on doorbell BAR since SDMA
> +	 * paging queue doorbell use the second page. The
> +	 * AMDGPU_DOORBELL64_MAX_ASSIGNMENT definition assumes all the
> +	 * doorbells are in the first page. So with paging queue enabled,
> +	 * the max num_kernel_doorbells should + 1 page (0x400 in dword)
> +	 */
> +	if (adev->asic_type >= CHIP_VEGA10)
> +		adev->doorbell.num_kernel_doorbells += 0x400;
>   
>   	adev->doorbell.ptr = ioremap(adev->doorbell.base,
>   				     adev->doorbell.num_kernel_doorbells *

