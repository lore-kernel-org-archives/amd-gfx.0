Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8BA0D37482
	for <amd-gfx@archiver.kernel.org>; Thu, 17 Oct 2024 12:20:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5DE1210E7FD;
	Thu, 17 Oct 2024 12:20:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="EF4Wu1Ve";
	dkim-atps=neutral
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com
 [209.85.128.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6315010E7FD
 for <amd-gfx@lists.freedesktop.org>; Thu, 17 Oct 2024 12:20:41 +0000 (UTC)
Received: by mail-wm1-f46.google.com with SMTP id
 5b1f17b1804b1-431548bd1b4so7832955e9.3
 for <amd-gfx@lists.freedesktop.org>; Thu, 17 Oct 2024 05:20:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1729167640; x=1729772440; darn=lists.freedesktop.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=rILOLU3qmEhfli/Mil+4Y+rWXePg0Jg+tdWRJJ73JiI=;
 b=EF4Wu1Ve+a8p9lXKkYEyxAGoEG8OQ8GFq5k7FJYM414/E0rQLEYvOuTGrJ6AI4PPN/
 vvUBpQVh20N6rWsgeA/hh4tsEkooNPRW0tHer9Su9RUGlWmktNHaMsD+ixqnpa7z372v
 AFCqlO6dHd/RhjoR/Oq2+Q9dM7il9j4J/97BCVK9+bMynBq3Gdbz4Y+xMaFEMluSGoSB
 WlPx+6l1oYmFBvTi/L8ftcXkBd9MnTw+AFT2Iq2cVG0HmBZWypQCmFwXfA4m0VnE6ubB
 dYhVPD0paJBz5GNigS8hEkpyCrj/7TqXJSZ8Knmw/8PscazYMhFagRMxgE67r9s3dFxA
 J7gQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729167640; x=1729772440;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=rILOLU3qmEhfli/Mil+4Y+rWXePg0Jg+tdWRJJ73JiI=;
 b=iS3lQEYBC4SNHlynSKw6g2YQARur3B2VRpiBKXhORcC/lbumLfuNoSkYa165yQiV+g
 X60HRVexQXFw4snMy3GD1AH8pvU9x39NLq/Lft0uflKIFb2JP9flaczg/BAQHu6zkHDS
 pQ2bvY6B+Qe7rXI8xInPrMdEhS4VkHc3DtJO3tfgXtagVkMfatoZK9Dztv9Ch/4/X5Dd
 VeA9Ea1JOUnFk/ixWVLtn4xxsjCrH7ZGihTQTNP35YBF+b6B1LoWWDOtGgbpV1tsB+AT
 0EqSdUQU9ju2qVWnGZJ8YIA2om7W/OTRsI8yNZsFgo8YkmaFwx6Ln1q3AMsc0yRR3uIT
 Mhgg==
X-Gm-Message-State: AOJu0Yz/1PSFh0ssQywzcSon0qR2/ub6YCLBpKYDmzNemzPYzE+KQlhB
 5ElBvz5ivi75D5rhLgHDXdn5IcmFOzBtgsqS6iMGnmW1u/S43Z18
X-Google-Smtp-Source: AGHT+IH+prDySS8psyy63gFMLuRp3SSdTK0DZdMBaD+l05mDzoh527fWA0H++4JP1ydyiPvfiNvSWg==
X-Received: by 2002:a05:600c:1d0b:b0:42f:8fcd:486c with SMTP id
 5b1f17b1804b1-4312561a417mr154124125e9.33.1729167639511; 
 Thu, 17 Oct 2024 05:20:39 -0700 (PDT)
Received: from [10.254.108.81] (munvpn.amd.com. [165.204.72.6])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-37d7fa7a231sm7074820f8f.11.2024.10.17.05.20.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 17 Oct 2024 05:20:39 -0700 (PDT)
Message-ID: <1f534179-6ffe-446c-ba20-6b5ab4da8db3@gmail.com>
Date: Thu, 17 Oct 2024 14:20:36 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 15/15] drm/amdgpu: validate get_clockgating_state
 before use
To: Sunil Khatri <sunil.khatri@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Cc: amd-gfx@lists.freedesktop.org
References: <20241017100615.1492144-1-sunil.khatri@amd.com>
 <20241017100615.1492144-16-sunil.khatri@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>
In-Reply-To: <20241017100615.1492144-16-sunil.khatri@amd.com>
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

Am 17.10.24 um 12:06 schrieb Sunil Khatri:
> Validate the function pointer for get_clockgating_state
> before making a function call.

Oh, I'm not sure if that is necessary or not. The NBIO, HDP and SMUIO 
functions are not IP specific.

Christian.

>
> Signed-off-by: Sunil Khatri <sunil.khatri@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/nv.c    | 9 ++++++---
>   drivers/gpu/drm/amd/amdgpu/soc21.c | 6 ++++--
>   drivers/gpu/drm/amd/amdgpu/soc24.c | 6 ++++--
>   3 files changed, 14 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/nv.c b/drivers/gpu/drm/amd/amdgpu/nv.c
> index 6b72169be8f8..40c720b32c59 100644
> --- a/drivers/gpu/drm/amd/amdgpu/nv.c
> +++ b/drivers/gpu/drm/amd/amdgpu/nv.c
> @@ -1084,11 +1084,14 @@ static void nv_common_get_clockgating_state(void *handle, u64 *flags)
>   	if (amdgpu_sriov_vf(adev))
>   		*flags = 0;
>   
> -	adev->nbio.funcs->get_clockgating_state(adev, flags);
> +	if (adev->nbio.funcs && adev->nbio.funcs->get_clockgating_state)
> +		adev->nbio.funcs->get_clockgating_state(adev, flags);
>   
> -	adev->hdp.funcs->get_clock_gating_state(adev, flags);
> +	if (adev->hdp.funcs && adev->hdp.funcs->get_clock_gating_state)
> +		adev->hdp.funcs->get_clock_gating_state(adev, flags);
>   
> -	adev->smuio.funcs->get_clock_gating_state(adev, flags);
> +	if (adev->smuio.funcs && adev->smuio.funcs->get_clock_gating_state)
> +		adev->smuio.funcs->get_clock_gating_state(adev, flags);
>   }
>   
>   static const struct amd_ip_funcs nv_common_ip_funcs = {
> diff --git a/drivers/gpu/drm/amd/amdgpu/soc21.c b/drivers/gpu/drm/amd/amdgpu/soc21.c
> index 1c07ebdc0d1f..196286be35b4 100644
> --- a/drivers/gpu/drm/amd/amdgpu/soc21.c
> +++ b/drivers/gpu/drm/amd/amdgpu/soc21.c
> @@ -975,9 +975,11 @@ static void soc21_common_get_clockgating_state(void *handle, u64 *flags)
>   {
>   	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
>   
> -	adev->nbio.funcs->get_clockgating_state(adev, flags);
> +	if (adev->nbio.funcs && adev->nbio.funcs->get_clockgating_state)
> +		adev->nbio.funcs->get_clockgating_state(adev, flags);
>   
> -	adev->hdp.funcs->get_clock_gating_state(adev, flags);
> +	if (adev->hdp.funcs && adev->hdp.funcs->get_clock_gating_state)
> +		adev->hdp.funcs->get_clock_gating_state(adev, flags);
>   }
>   
>   static const struct amd_ip_funcs soc21_common_ip_funcs = {
> diff --git a/drivers/gpu/drm/amd/amdgpu/soc24.c b/drivers/gpu/drm/amd/amdgpu/soc24.c
> index 3af10ef4b793..f4278a0fa8f7 100644
> --- a/drivers/gpu/drm/amd/amdgpu/soc24.c
> +++ b/drivers/gpu/drm/amd/amdgpu/soc24.c
> @@ -564,9 +564,11 @@ static void soc24_common_get_clockgating_state(void *handle, u64 *flags)
>   {
>   	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
>   
> -	adev->nbio.funcs->get_clockgating_state(adev, flags);
> +	if (adev->nbio.funcs && adev->nbio.funcs->get_clockgating_state)
> +		adev->nbio.funcs->get_clockgating_state(adev, flags);
>   
> -	adev->hdp.funcs->get_clock_gating_state(adev, flags);
> +	if (adev->hdp.funcs && adev->hdp.funcs->get_clock_gating_state)
> +		adev->hdp.funcs->get_clock_gating_state(adev, flags);
>   
>   	return;
>   }

