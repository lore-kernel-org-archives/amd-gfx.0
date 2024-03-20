Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DCF7CCD11DB
	for <amd-gfx@archiver.kernel.org>; Wed, 20 Mar 2024 09:03:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4429310EA1B;
	Wed, 20 Mar 2024 09:03:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="TRGVTEjt";
	dkim-atps=neutral
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com
 [209.85.221.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 027D110F237
 for <amd-gfx@lists.freedesktop.org>; Wed, 20 Mar 2024 09:03:12 +0000 (UTC)
Received: by mail-wr1-f54.google.com with SMTP id
 ffacd0b85a97d-3412f49bac7so2619401f8f.0
 for <amd-gfx@lists.freedesktop.org>; Wed, 20 Mar 2024 02:03:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1710925391; x=1711530191; darn=lists.freedesktop.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=itymKjqC552DwFIPuJD5TVhhpH2UyZKcFVMHp6o/Xus=;
 b=TRGVTEjtQEu+t5nA38qewSfXHzJuhR6bgW03lhbwT4sBiCOx/8PhuLl/hRtv9X2rsP
 dmggn0gMVWFI6Ar5H7g4QKMj4x4XxXednyHOA+uRN+jhjkMUE3PuZ8XCxu+yRDPh09Xz
 fJxB4CkezV3WF1+VQ+lgOIRhCMxEk4rVwqWTjS9K7o3E40uMV6UEAFAMqwH+VwyUroDj
 y/lSm1qgdWlh2dAt61m9zMsYfCZpp7rHrfeg/bNQI6kNlCg36TcyLl8L8XdmJ/55cijx
 vqp6cepaFjtCCyYrgiJwDF5RMSE31jeHN3kdeuPrBM4G5UwvTtV8MN4MvRXLr1DeHdp2
 /Wyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710925391; x=1711530191;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=itymKjqC552DwFIPuJD5TVhhpH2UyZKcFVMHp6o/Xus=;
 b=jhYWgEej3zggn4CODThAj3io1kfDUu6jLjV/CBg4dJaI7l6nJ4kjADgdXPnq8r4Efb
 PoyUZ04dQNwKSj9ci9vVXqeFzfjNiWfTajIseB0ok+umd80CQRRfeaxi8AjUpwWkNm6X
 KdW3DynYgbMgc6t5YMLT8mjlmU7Ev6AdaIqtWkv5M8rrtBLffLT6hOJJOd/ovGIvWau2
 shlCZUb0M+r1YvHgmgF2fskfJnPvjOsREsecSJFwzc9k65OpEhoc4kxuFPe9f+xUGdgl
 91cRk3LVwEvz7H6mWXGnLLs5lFgs3GprNO7qGGZsglxOZqCgSxPkixl69t7GxdRFVdpi
 bk8Q==
X-Gm-Message-State: AOJu0YxkTU2WY8SrSko+3RKB8Lger46nJlqxi7CQ0dlYQkvpkPYIGPK8
 Mga4EFcaewyoCejB0Eewz9h40XydACIwSiwWyvFTYLSbXf/JIuPw
X-Google-Smtp-Source: AGHT+IEy6d4INngFPKxYqhB+NOTgoJH0ziPgRVTKqisyEYOK9UpCSwts/ozgnueV149teHCN5Hjf0g==
X-Received: by 2002:adf:e6c1:0:b0:33d:73de:cd95 with SMTP id
 y1-20020adfe6c1000000b0033d73decd95mr10221053wrm.17.1710925390740; 
 Wed, 20 Mar 2024 02:03:10 -0700 (PDT)
Received: from [10.254.108.81] (munvpn.amd.com. [165.204.72.6])
 by smtp.gmail.com with ESMTPSA id
 q15-20020adff78f000000b0033e192a5852sm14239632wrp.30.2024.03.20.02.03.07
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 20 Mar 2024 02:03:10 -0700 (PDT)
Message-ID: <1e08b845-71cf-4afb-8a49-6eb70d29be74@gmail.com>
Date: Wed, 20 Mar 2024 10:03:04 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: Fix format character cut-off issues in
 amdgpu_vcn_early_init()
Content-Language: en-US
To: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>
Cc: amd-gfx@lists.freedesktop.org, Lijo Lazar <lijo.lazar@amd.com>
References: <20240320084513.3026222-1-srinivasan.shanmugam@amd.com>
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>
In-Reply-To: <20240320084513.3026222-1-srinivasan.shanmugam@amd.com>
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

Am 20.03.24 um 09:45 schrieb Srinivasan Shanmugam:
> The issue was present in the lines where 'fw_name' was being formatted.
> This fix ensures that the output is not truncated
>
> Fixes the below with gcc W=1:
> drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c: In function ‘amdgpu_vcn_early_init’:
> drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c:102:66: warning: ‘snprintf’ output may be truncated before the last format character [-Wformat-truncation=]
>    102 |                 snprintf(fw_name, sizeof(fw_name), "amdgpu/%s.bin", ucode_prefix);
>        |                                                                  ^
> drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c:102:17: note: ‘snprintf’ output between 12 and 41 bytes into a destination of size 40
>    102 |                 snprintf(fw_name, sizeof(fw_name), "amdgpu/%s.bin", ucode_prefix);
>        |                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c:102:66: warning: ‘snprintf’ output may be truncated before the last format character [-Wformat-truncation=]
>    102 |                 snprintf(fw_name, sizeof(fw_name), "amdgpu/%s.bin", ucode_prefix);
>        |                                                                  ^
> drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c:102:17: note: ‘snprintf’ output between 12 and 41 bytes into a destination of size 40
>    102 |                 snprintf(fw_name, sizeof(fw_name), "amdgpu/%s.bin", ucode_prefix);
>        |                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c:105:73: warning: ‘.bin’ directive output may be truncated writing 4 bytes into a region of size between 2 and 31 [-Wformat-truncation=]
>    105 |                         snprintf(fw_name, sizeof(fw_name), "amdgpu/%s_%d.bin", ucode_prefix, i);
>        |                                                                         ^~~~
> drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c:105:25: note: ‘snprintf’ output between 14 and 43 bytes into a destination of size 40
>    105 |                         snprintf(fw_name, sizeof(fw_name), "amdgpu/%s_%d.bin", ucode_prefix, i);
>        |                         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Cc: Christian König <christian.koenig@amd.com>
> Suggested-by: Lijo Lazar <lijo.lazar@amd.com>
> Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>

Acked-by: Christian König <christian.koenig@amd.com>

> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
> index 9c514a606a2f..f994ee6c548d 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
> @@ -94,7 +94,7 @@ static void amdgpu_vcn_idle_work_handler(struct work_struct *work);
>   int amdgpu_vcn_early_init(struct amdgpu_device *adev)
>   {
>   	char ucode_prefix[30];
> -	char fw_name[40];
> +	char fw_name[42];
>   	int r, i;
>   
>   	for (i = 0; i < adev->vcn.num_vcn_inst; i++) {

