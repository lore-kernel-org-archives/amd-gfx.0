Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E141C4345F
	for <amd-gfx@archiver.kernel.org>; Fri, 19 Apr 2024 11:50:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7C88810FE60;
	Fri, 19 Apr 2024 11:50:47 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="GYGtOFR8";
	dkim-atps=neutral
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com
 [209.85.221.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6AE0B10FDE1
 for <amd-gfx@lists.freedesktop.org>; Fri, 19 Apr 2024 11:50:46 +0000 (UTC)
Received: by mail-wr1-f51.google.com with SMTP id
 ffacd0b85a97d-3481bb34e7dso1089014f8f.3
 for <amd-gfx@lists.freedesktop.org>; Fri, 19 Apr 2024 04:50:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1713527445; x=1714132245; darn=lists.freedesktop.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Nq1voOokD+Oot35V3UlI7xSeWJVN7ko+8jRQJ06IWwA=;
 b=GYGtOFR8xiLw6i5czoQzTlKDBipQUwCddAaB9rnuiFiWFQs6cWCkrfcKwBSWIOuKSt
 9Rdgg2VsnOF5yTJ9nhF6yeBDsspmUC2PMu7jYOK3cJsomZtc+UbRuMplynYKbOtdu+A1
 Dr+ukv51kjO7OrrIL0jTHPM4hTQHaRz4aTs8tZ6PqrJaYuWMkv55iQ5OHWxDWPL/XoT+
 aoYCy02x7iOonWQdOd6mrsy8i98eXRJpXLLqkj0qz6VCtuFl5gtzbTBnWce8peupPXZY
 VC9zuvDuaVy67pxV3RtSc7ilNuUq2YFxFgyHuxfL8U+jtAat4hpoKmchO211g04Z5iPJ
 nlBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713527445; x=1714132245;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Nq1voOokD+Oot35V3UlI7xSeWJVN7ko+8jRQJ06IWwA=;
 b=QEbbWSvzz1xm84JUWkv0NHkAAV9IxKQKCMEqZZIaYJB9LVzW/H+Z+umrVUn6X6r2CA
 N2K0mXpIxWptP98KJJZ8xMW1VGqrZigYWLx6l66XVkcuqvhYVF4eLbGRg1AHrA+Qi1nJ
 I9FnIISUBgHm3gupueV//1DB8g+XgUJRiIYkVPzTLHa3jPBXbsPu7MQDOTVH3A+SEAhF
 j3tmdR03WZ/C1z9O0JPVvnARuSLu1WQj4vvfZIojZ8xTHyATGDEJJR1AgTo/qZWWTGEJ
 y7CH6veWxHvUxhd3NHBClzpx4U8BXTj/8rj3S0mC6DvszIRV8vu5bh2ZG2qm3GA0GFHR
 7mpQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVEIyFZIRIkd5OXylXo9EHRc7nVKx6Jl/1OtPb9xv9InTSytEwz+PMENneXRFjI5TFH1ot5NUKUmMjNgTc6YvKF0Uknht0OtVhTkj8nSA==
X-Gm-Message-State: AOJu0Yy62JPI0kAa8JGzLjC9usdaTjHWumfnnp3sEEoqxzAv0Ua/Hb5c
 Y3uoENFdBQ2Rs2rqXWrDrmCBJXKrYZ4ZtX6oK1+kBjBqA9ThCPuT
X-Google-Smtp-Source: AGHT+IEDNPAWEV0esIgkJQ4WyCYreTy++fj4ve1SvbAUK7UFbr9qaTabsWPBNgMG9nCRbVq1+J9T7w==
X-Received: by 2002:a5d:6988:0:b0:349:cbdc:eb6b with SMTP id
 g8-20020a5d6988000000b00349cbdceb6bmr1195633wru.38.1713527444443; 
 Fri, 19 Apr 2024 04:50:44 -0700 (PDT)
Received: from [10.254.108.81] (munvpn.amd.com. [165.204.72.6])
 by smtp.gmail.com with ESMTPSA id
 bl28-20020adfe25c000000b00346bb778e8bsm4305781wrb.5.2024.04.19.04.50.43
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 19 Apr 2024 04:50:43 -0700 (PDT)
Message-ID: <850a9976-ff7e-4ae3-98bf-7394687fe299@gmail.com>
Date: Fri, 19 Apr 2024 13:50:40 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu/vcn: fix unitialized variable warnings
To: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>,
 amd-gfx@lists.freedesktop.org, alexander.deucher@amd.com
References: <20240418180807.240782-1-pierre-eric.pelloux-prayer@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>
In-Reply-To: <20240418180807.240782-1-pierre-eric.pelloux-prayer@amd.com>
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

Am 18.04.24 um 20:07 schrieb Pierre-Eric Pelloux-Prayer:
> Init r to 0 to avoid returning an uninitialized value if we never
> enter the loop. This case should never be hit in practive, but
> returning 0 doesn't hurt.
>
> The same fix is applied to the 4 places using the same pattern.
>
> Signed-off-by: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c   | 2 +-
>   drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c   | 2 +-
>   drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c | 2 +-
>   drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c | 2 +-
>   4 files changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
> index 8f82fb887e9c..724445545563 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
> @@ -298,7 +298,7 @@ static int vcn_v3_0_hw_init(void *handle)
>   {
>   	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
>   	struct amdgpu_ring *ring;
> -	int i, j, r;
> +	int i, j, r = 0;

That is usually considered bad coding style.

Better insert a "return 0;" directly before the done label.

Regards,
Christian.

>   
>   	if (amdgpu_sriov_vf(adev)) {
>   		r = vcn_v3_0_start_sriov(adev);
> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
> index 832d15f7b5f6..9be7ae7af4b1 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
> @@ -253,7 +253,7 @@ static int vcn_v4_0_hw_init(void *handle)
>   {
>   	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
>   	struct amdgpu_ring *ring;
> -	int i, r;
> +	int i, r = 0;
>   
>   	if (amdgpu_sriov_vf(adev)) {
>   		r = vcn_v4_0_start_sriov(adev);
> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c
> index 501e53e69f2a..593c64e4b8ef 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c
> @@ -221,7 +221,7 @@ static int vcn_v4_0_5_hw_init(void *handle)
>   {
>   	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
>   	struct amdgpu_ring *ring;
> -	int i, r;
> +	int i, r = 0;
>   
>   	for (i = 0; i < adev->vcn.num_vcn_inst; ++i) {
>   		if (adev->vcn.harvest_config & (1 << i))
> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c
> index bc60c554eb32..246f967e2e7d 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c
> @@ -187,7 +187,7 @@ static int vcn_v5_0_0_hw_init(void *handle)
>   {
>   	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
>   	struct amdgpu_ring *ring;
> -	int i, r;
> +	int i, r = 0;
>   
>   	for (i = 0; i < adev->vcn.num_vcn_inst; ++i) {
>   		if (adev->vcn.harvest_config & (1 << i))

