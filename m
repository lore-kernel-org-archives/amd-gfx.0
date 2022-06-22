Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 841A8C433EF
	for <amd-gfx@archiver.kernel.org>; Wed, 22 Jun 2022 12:38:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DCBB311338B;
	Wed, 22 Jun 2022 12:38:28 +0000 (UTC)
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com
 [IPv6:2a00:1450:4864:20::631])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7D2D411338B
 for <amd-gfx@lists.freedesktop.org>; Wed, 22 Jun 2022 12:38:28 +0000 (UTC)
Received: by mail-ej1-x631.google.com with SMTP id h23so33898241ejj.12
 for <amd-gfx@lists.freedesktop.org>; Wed, 22 Jun 2022 05:38:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=message-id:date:mime-version:user-agent:subject:content-language:to
 :references:from:in-reply-to:content-transfer-encoding;
 bh=J5O37Ujpf5jk07PiSnfKz3iXUaCg3vZsATv1D7KndSE=;
 b=NbrQREcJsMsbJ8HNMr5F4jVaT4GFPwYEeKhKL8BpQ4OFzkF2J4qeXSSnH6a0QTYHYq
 DzWxj0i7ZOi53JKjXlypSnCdA6oaqRrBxeLu/wK+nnyOrQZKJyesPbA5cTO6DU9gUVUO
 4wt4BzjSMOfT/FJmO5ABIshZYe18CCPnSspjIc7FEpTDsH++9GwlKGd7gmaxd/DrqvMY
 vy7xOcJEe0KPHhBMlkU0q5oKf7UpQnvhL/dyZa3OFV/7KJCqjXMiyDa/y7/g5iy1txPB
 gZetxxLjNL+nLVjWGt3ztdVTU/K+Pu15O+TEsjx6+SiAy7CuMvDFl8z7dHXPzB21awsn
 96kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:references:from:in-reply-to
 :content-transfer-encoding;
 bh=J5O37Ujpf5jk07PiSnfKz3iXUaCg3vZsATv1D7KndSE=;
 b=PBMkSrzUb2FMrxlnHa0/akX+U+GyHfAJPOxvuKG9Pqto107uFX/PeshiaqEDS70qKq
 pSbqI7AL1IxZ+Bl9MYnLMLQcsrIy5gN7LX3SGzTNgHE+rsfAYRWPbvcs91FH8Vxfjway
 RF+Wx7WXFmRWvXEx/sp26zjdyqGMJA2Ls3R6TuViAamHhyb3Es+erxlcHfQ/be2Z+0a5
 A3K4gbGKA2nyVT8gL01upkgj1S7BouOKQiMPkeyl5wkPwsZKFRxtoN7RR8uudhYXs//2
 XoI2cwV/oqNbALsYyE0aazwgf8farAj8JUHWjKVKuqmoKOJwzDP5Yqxmidaot79sGBnv
 +/Dw==
X-Gm-Message-State: AJIora9b7tx7xFdSOQ/1qaNQIZKbhShfsfxonjeGtaPctxIoREKqMlnV
 rgr5Jk5fjuChZcyaOAz/aoQ=
X-Google-Smtp-Source: AGRyM1vGIQpmCSmN5bYfZKL2BpJ+vjJJKMFTOA4Ajx/AjascFEgGeXpt55VWzta0JrZwuvfl1BGCSw==
X-Received: by 2002:a17:907:6e8f:b0:710:865b:9c90 with SMTP id
 sh15-20020a1709076e8f00b00710865b9c90mr2809578ejc.27.1655901506871; 
 Wed, 22 Jun 2022 05:38:26 -0700 (PDT)
Received: from ?IPV6:2a02:908:1256:79a0:8f77:c83:6a3d:ee86?
 ([2a02:908:1256:79a0:8f77:c83:6a3d:ee86])
 by smtp.gmail.com with ESMTPSA id
 b17-20020a1709063cb100b00722bc0aa9e3sm5154121ejh.162.2022.06.22.05.38.26
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 22 Jun 2022 05:38:26 -0700 (PDT)
Message-ID: <31b16475-f018-b48c-346e-460837914861@gmail.com>
Date: Wed, 22 Jun 2022 14:38:25 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH 2/2] drm/amdgpu: use real_vram_size in ttm_vram_fops
Content-Language: en-US
To: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>,
 amd-gfx@lists.freedesktop.org
References: <20220622100703.303697-1-pierre-eric.pelloux-prayer@amd.com>
 <20220622100703.303697-2-pierre-eric.pelloux-prayer@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
In-Reply-To: <20220622100703.303697-2-pierre-eric.pelloux-prayer@amd.com>
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Am 22.06.22 um 12:07 schrieb Pierre-Eric Pelloux-Prayer:
> If amdgpu.vramlimit=XXXX is used, amdgpu_gmc_vram_location will update
> real_vram_size based on this value.
> mc_vram_size is the real amount of VRAM, initialized in gmc_..._mc_init.

Thinking more about it I came to the conclusion that this patch here is 
not correct.

Even when we restricted the driver to use only a fraction of the VRAM we 
can still read/write all of it through the debugging interfaces.

That could be useful if we try to track down things like random memory 
corruption etc..

Regards,
Christian.

>
> Signed-off-by: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c | 10 +++++-----
>   1 file changed, 5 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> index 952e99e6d07e..8f245e9f8f7c 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> @@ -2252,10 +2252,10 @@ static ssize_t amdgpu_ttm_vram_read(struct file *f, char __user *buf,
>   	if (size & 0x3 || *pos & 0x3)
>   		return -EINVAL;
>   
> -	if (*pos >= adev->gmc.mc_vram_size)
> +	if (*pos >= adev->gmc.real_vram_size)
>   		return -ENXIO;
>   
> -	size = min(size, (size_t)(adev->gmc.mc_vram_size - *pos));
> +	size = min(size, (size_t)(adev->gmc.real_vram_size - *pos));
>   	while (size) {
>   		size_t bytes = min(size, AMDGPU_TTM_VRAM_MAX_DW_READ * 4);
>   		uint32_t value[AMDGPU_TTM_VRAM_MAX_DW_READ];
> @@ -2288,13 +2288,13 @@ static ssize_t amdgpu_ttm_vram_write(struct file *f, const char __user *buf,
>   	if (size & 0x3 || *pos & 0x3)
>   		return -EINVAL;
>   
> -	if (*pos >= adev->gmc.mc_vram_size)
> +	if (*pos >= adev->gmc.real_vram_size)
>   		return -ENXIO;
>   
>   	while (size) {
>   		uint32_t value;
>   
> -		if (*pos >= adev->gmc.mc_vram_size)
> +		if (*pos >= adev->gmc.real_vram_size)
>   			return result;
>   
>   		r = get_user(value, (uint32_t *)buf);
> @@ -2442,7 +2442,7 @@ void amdgpu_ttm_debugfs_init(struct amdgpu_device *adev)
>   	struct dentry *root = minor->debugfs_root;
>   
>   	debugfs_create_file_size("amdgpu_vram", 0444, root, adev,
> -				 &amdgpu_ttm_vram_fops, adev->gmc.mc_vram_size);
> +				 &amdgpu_ttm_vram_fops, adev->gmc.real_vram_size);
>   	debugfs_create_file("amdgpu_iomem", 0444, root, adev,
>   			    &amdgpu_ttm_iomem_fops);
>   	debugfs_create_file("amdgpu_vram_mm", 0444, root, adev,

