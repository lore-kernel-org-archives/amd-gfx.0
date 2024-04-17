Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73F92C4345F
	for <amd-gfx@archiver.kernel.org>; Wed, 17 Apr 2024 12:46:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F1878113493;
	Wed, 17 Apr 2024 12:46:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="WQo+osJ/";
	dkim-atps=neutral
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com
 [209.85.221.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 67A15113493
 for <amd-gfx@lists.freedesktop.org>; Wed, 17 Apr 2024 12:46:07 +0000 (UTC)
Received: by mail-wr1-f41.google.com with SMTP id
 ffacd0b85a97d-346f4266e59so4006823f8f.3
 for <amd-gfx@lists.freedesktop.org>; Wed, 17 Apr 2024 05:46:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1713357966; x=1713962766; darn=lists.freedesktop.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=ddK4w40j5iwZ1lLcMc839WWBnfGs84s72XUNe0C4Wc0=;
 b=WQo+osJ/+ZPhIE13KEaFplppTtto/6Knx7gn2JLPooBsh6e0F4E9WEjeo+tOPodNh4
 WdlW1GkSkn7MFTNOxzhThc6OxSxmh/z9m9O00c6LrnCPcJ9sFmafsG2Hp2QI7NmRw05k
 coPUiA7HtU0citDY7xifY8RJ5vMieOZmXnRPpj3HZjOlJZC/knWwCShMwPYdUVOjcZm7
 l+WVYyc7bLp6w7X8/5ZUThBIrhOx+K7A06K3/VnPCE0MNNVhZUl+5eNe4IOD5O75kIgT
 tZcI3/CucCMvhetyIBSxEW/FdhUeh4wwnjI+x+3j4i5Flclb2jvlWLsENyxJGdFBNAOT
 NNnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713357966; x=1713962766;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ddK4w40j5iwZ1lLcMc839WWBnfGs84s72XUNe0C4Wc0=;
 b=HqV0mHYlCujCh0+yw6Lf7fi2n8nlqpan+KXf0BpjyY728D6NIGwB2ilXuN9ZMPK8UT
 Fe3u8fsc7qXDYJ0lq4yUBmJOK6cYJ868jJriNtnXqhEFmNfszrjGpVlCrZG/Urm8zPX+
 4EnOhCNNz/VeKn9UJU4Jw7WAhvSjXknsTeTEj66b4M3mVCivkoatrp/g4AQ1ogUOH/w9
 l0fH3Fl68tUdel8CZlpnCuLlOsbqV5mxXkRS2SPT/IujessrGuMNOF42suqNKmWen8pg
 vUQ44wASNAATe5/crY2efBDf5qaQOnNXvHMggVjkw3Y5qmVm7t3TNzcx2+Y1gVVUIkHo
 mYnA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUA+ELvaq7jtL3ahBFqUQ2exmIXuoyYzQDGW0db3gLxMxN02zegkCB1x+QD2GwbX3FJ3bQg3PytQFr74mIJSj6yihaw6akMZsJltqJ7pg==
X-Gm-Message-State: AOJu0YxPml1qGqx2oDXYHKK7f0QiyQg6Z9b5whV3GMe4MK19FItGs0Kf
 h01ZFrZPeF1tMfC/BAGG+d7MoqjUeOcYuuzVKyIyd6rE/rNfjY/Y
X-Google-Smtp-Source: AGHT+IH19IxUmgqQzy2qzgw96uqQOLMkpAXViaooFCA4aMkF2O4U4peu2XlI2g+6Z2bYevUaIDQDWA==
X-Received: by 2002:a5d:47a2:0:b0:343:71c2:287e with SMTP id
 2-20020a5d47a2000000b0034371c2287emr12573385wrb.59.1713357965387; 
 Wed, 17 Apr 2024 05:46:05 -0700 (PDT)
Received: from [10.254.108.81] (munvpn.amd.com. [165.204.72.6])
 by smtp.gmail.com with ESMTPSA id
 e29-20020adfa45d000000b00348b46a134bsm4700880wra.1.2024.04.17.05.46.04
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 17 Apr 2024 05:46:05 -0700 (PDT)
Message-ID: <c3ad7cc0-8c1a-4371-8087-9327c0e14c20@gmail.com>
Date: Wed, 17 Apr 2024 14:46:03 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH Review 1/1] drm/amdgpu: Support setting reset_method at
 runtime
To: "Stanley.Yang" <Stanley.Yang@amd.com>, amd-gfx@lists.freedesktop.org
References: <20240412062114.3581242-1-Stanley.Yang@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>
In-Reply-To: <20240412062114.3581242-1-Stanley.Yang@amd.com>
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

Am 12.04.24 um 08:21 schrieb Stanley.Yang:
> Signed-off-by: Stanley.Yang <Stanley.Yang@amd.com>

You are missing a commit message, without it the patch will 
automatically be rejected when you try to push it.

With that added Reviewed-by: Christian König <christian.koenig@amd.com>

> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> index 80b9642f2bc4..5f5bf0c26b1f 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> @@ -915,7 +915,7 @@ module_param_named(freesync_video, amdgpu_freesync_vid_mode, uint, 0444);
>    * GPU reset method (-1 = auto (default), 0 = legacy, 1 = mode0, 2 = mode1, 3 = mode2, 4 = baco)
>    */
>   MODULE_PARM_DESC(reset_method, "GPU reset method (-1 = auto (default), 0 = legacy, 1 = mode0, 2 = mode1, 3 = mode2, 4 = baco/bamaco)");
> -module_param_named(reset_method, amdgpu_reset_method, int, 0444);
> +module_param_named(reset_method, amdgpu_reset_method, int, 0644);
>   
>   /**
>    * DOC: bad_page_threshold (int) Bad page threshold is specifies the

