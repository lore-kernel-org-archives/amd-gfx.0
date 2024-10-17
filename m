Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C386ED2F7CE
	for <amd-gfx@archiver.kernel.org>; Thu, 17 Oct 2024 11:54:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6862B10E7F7;
	Thu, 17 Oct 2024 11:54:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="KVgcPfcy";
	dkim-atps=neutral
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com
 [209.85.128.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6F38C10E7F7
 for <amd-gfx@lists.freedesktop.org>; Thu, 17 Oct 2024 11:54:42 +0000 (UTC)
Received: by mail-wm1-f49.google.com with SMTP id
 5b1f17b1804b1-43124843b04so8588075e9.2
 for <amd-gfx@lists.freedesktop.org>; Thu, 17 Oct 2024 04:54:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1729166081; x=1729770881; darn=lists.freedesktop.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=n7oPBcUEqtG1L8gBvbQSLnga1vOkYz5pf44FmRuFNkk=;
 b=KVgcPfcyStVPGef0X8RiYxBO+cKnmM7tFnbVv7U0mgYOz4SwZv69AY1O03k7XSPjmG
 p7fXuV7xSyt6Fr6ptcUAqH8XokVtrI0hzS/sXq2vaZBR2o8SlG0F3GYHT5fw/3AWLOXt
 4JRmTq0HkPdRYiOFDx4WHFReHLFgjf61cv0AY7aylhAZ8CL0qAed1nuzS1vKNoPDemJ9
 LVVM1NlmdVlmktREpHKTM3QLFbHNXd09Oh9m1a1f6SBMBrFXZe6mMB2qpgd4e4Q6ccUe
 xulKayictzBc9aMkHV1c0CxkHdHpc976x2hYw2SZE5ln6HmE6ei0pYtyn1w4ePhMc7Q3
 JbQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729166081; x=1729770881;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=n7oPBcUEqtG1L8gBvbQSLnga1vOkYz5pf44FmRuFNkk=;
 b=VPWJXtQlLkLwXZz4dpC7fmA2VmQxds+rLTfqVsOe+tvwuhqOEZPFHEf6O7Ik2S64wC
 MZl6JjkHmfKgiLwYMygLBmD+U/nzKgMGa1VHSBDqI5ERFEcc3WjFxQQfSDqyeKGtsWTN
 AO5EOd6M39axa9sXHgYV59/4KRyqMWQzQqzx6ZvR2eayORnpBn8b7U/At9+rA1B6IYWJ
 mzLAmU2AGtwIDVN7vaBII07q/noea5IoOAiTgN+DNoUb6JJ0v351xhqwIy7MUba5aWx5
 wl2cwRl443DEg/KPW1L/o/p0N59MqSZGMCAYREyqySa1arhDwOWmCGgK5aO/usZXCT52
 Nd/g==
X-Gm-Message-State: AOJu0YwIIIJSN/oRuofhJRPFUpxXqAGv+k6SxKgigBInuaD1xl64fNIQ
 vDLXGjqv6D6OAWIPmrIYNFSKCGMwdONrJVrUMmgNpOqdxBt48uyT
X-Google-Smtp-Source: AGHT+IHiIRDeqYrvCfklek9N/xHiS90n2LdVtPoW3IPaUXToOqlm6LA4CHosCwFMxiWybcoR6H0iwQ==
X-Received: by 2002:a5d:460f:0:b0:37c:d23a:1e4 with SMTP id
 ffacd0b85a97d-37d551e0644mr14576717f8f.30.1729166080334; 
 Thu, 17 Oct 2024 04:54:40 -0700 (PDT)
Received: from [10.254.108.81] (munvpn.amd.com. [165.204.72.6])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-37d7fc40f94sm6970718f8f.106.2024.10.17.04.54.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 17 Oct 2024 04:54:39 -0700 (PDT)
Message-ID: <a63b46ad-3c81-425b-a24f-6da7ded8bf45@gmail.com>
Date: Thu, 17 Oct 2024 13:54:36 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 06/15] drm/amdgpu: validate suspend before function call
To: Sunil Khatri <sunil.khatri@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Cc: amd-gfx@lists.freedesktop.org
References: <20241017100615.1492144-1-sunil.khatri@amd.com>
 <20241017100615.1492144-7-sunil.khatri@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>
In-Reply-To: <20241017100615.1492144-7-sunil.khatri@amd.com>
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
> Before making a function call to suspend, validate
> the function pointer like we do in sw_init.

Same comment as on patch #5, please add an amdgpu_ip_block_suspend() 
function and just call it multiple times.

Regards,
Christian.

>
> Signed-off-by: Sunil Khatri <sunil.khatri@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/aldebaran.c      | 15 ++++++------
>   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c  | 26 ++++++++++++---------
>   drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c   | 12 ++++++----
>   drivers/gpu/drm/amd/amdgpu/sienna_cichlid.c | 15 ++++++------
>   drivers/gpu/drm/amd/amdgpu/smu_v13_0_10.c   | 15 ++++++------
>   5 files changed, 46 insertions(+), 37 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/aldebaran.c b/drivers/gpu/drm/amd/amdgpu/aldebaran.c
> index c1ff24335a0c..e55d680d95ce 100644
> --- a/drivers/gpu/drm/amd/amdgpu/aldebaran.c
> +++ b/drivers/gpu/drm/amd/amdgpu/aldebaran.c
> @@ -85,13 +85,14 @@ static int aldebaran_mode2_suspend_ip(struct amdgpu_device *adev)
>   			      AMD_IP_BLOCK_TYPE_SDMA))
>   			continue;
>   
> -		r = adev->ip_blocks[i].version->funcs->suspend(&adev->ip_blocks[i]);
> -
> -		if (r) {
> -			dev_err(adev->dev,
> -				"suspend of IP block <%s> failed %d\n",
> -				adev->ip_blocks[i].version->funcs->name, r);
> -			return r;
> +		if (adev->ip_blocks[i].version->funcs->suspend) {
> +			r = adev->ip_blocks[i].version->funcs->suspend(&adev->ip_blocks[i]);
> +			if (r) {
> +				dev_err(adev->dev,
> +					"suspend of IP block <%s> failed %d\n",
> +					adev->ip_blocks[i].version->funcs->name, r);
> +				return r;
> +			}
>   		}
>   
>   		adev->ip_blocks[i].status.hw = false;
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> index 96cecd4a636b..fda89aeb4d1b 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -3478,12 +3478,14 @@ static int amdgpu_device_ip_suspend_phase1(struct amdgpu_device *adev)
>   			continue;
>   
>   		/* XXX handle errors */
> -		r = adev->ip_blocks[i].version->funcs->suspend(&adev->ip_blocks[i]);
> -		/* XXX handle errors */
> -		if (r) {
> -			DRM_ERROR("suspend of IP block <%s> failed %d\n",
> -				  adev->ip_blocks[i].version->funcs->name, r);
> -			return r;
> +		if (adev->ip_blocks[i].version->funcs->suspend) {
> +			r = adev->ip_blocks[i].version->funcs->suspend(&adev->ip_blocks[i]);
> +			/* XXX handle errors */
> +			if (r) {
> +				DRM_ERROR("suspend of IP block <%s> failed %d\n",
> +					adev->ip_blocks[i].version->funcs->name, r);
> +				return r;
> +			}
>   		}
>   
>   		adev->ip_blocks[i].status.hw = false;
> @@ -3560,11 +3562,13 @@ static int amdgpu_device_ip_suspend_phase2(struct amdgpu_device *adev)
>   			continue;
>   
>   		/* XXX handle errors */
> -		r = adev->ip_blocks[i].version->funcs->suspend(&adev->ip_blocks[i]);
> -		/* XXX handle errors */
> -		if (r) {
> -			DRM_ERROR("suspend of IP block <%s> failed %d\n",
> -				  adev->ip_blocks[i].version->funcs->name, r);
> +		if (adev->ip_blocks[i].version->funcs->suspend) {
> +			r = adev->ip_blocks[i].version->funcs->suspend(&adev->ip_blocks[i]);
> +			/* XXX handle errors */
> +			if (r) {
> +				DRM_ERROR("suspend of IP block <%s> failed %d\n",
> +					adev->ip_blocks[i].version->funcs->name, r);
> +			}
>   		}
>   		adev->ip_blocks[i].status.hw = false;
>   		/* handle putting the SMC in the appropriate state */
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c
> index 3e2724590dbf..6bc75aa1c3b1 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c
> @@ -40,11 +40,13 @@ static int amdgpu_reset_xgmi_reset_on_init_suspend(struct amdgpu_device *adev)
>   			continue;
>   
>   		/* XXX handle errors */
> -		r = adev->ip_blocks[i].version->funcs->suspend(&adev->ip_blocks[i]);
> -		/* XXX handle errors */
> -		if (r) {
> -			dev_err(adev->dev, "suspend of IP block <%s> failed %d",
> -				adev->ip_blocks[i].version->funcs->name, r);
> +		if (adev->ip_blocks[i].version->funcs->suspend) {
> +			r = adev->ip_blocks[i].version->funcs->suspend(&adev->ip_blocks[i]);
> +			/* XXX handle errors */
> +			if (r) {
> +				dev_err(adev->dev, "suspend of IP block <%s> failed %d",
> +					adev->ip_blocks[i].version->funcs->name, r);
> +			}
>   		}
>   		adev->ip_blocks[i].status.hw = false;
>   	}
> diff --git a/drivers/gpu/drm/amd/amdgpu/sienna_cichlid.c b/drivers/gpu/drm/amd/amdgpu/sienna_cichlid.c
> index 475b7df3a908..10dece12509f 100644
> --- a/drivers/gpu/drm/amd/amdgpu/sienna_cichlid.c
> +++ b/drivers/gpu/drm/amd/amdgpu/sienna_cichlid.c
> @@ -81,13 +81,14 @@ static int sienna_cichlid_mode2_suspend_ip(struct amdgpu_device *adev)
>   			      AMD_IP_BLOCK_TYPE_SDMA))
>   			continue;
>   
> -		r = adev->ip_blocks[i].version->funcs->suspend(&adev->ip_blocks[i]);
> -
> -		if (r) {
> -			dev_err(adev->dev,
> -				"suspend of IP block <%s> failed %d\n",
> -				adev->ip_blocks[i].version->funcs->name, r);
> -			return r;
> +		if (adev->ip_blocks[i].version->funcs->suspend) {
> +			r = adev->ip_blocks[i].version->funcs->suspend(&adev->ip_blocks[i]);
> +			if (r) {
> +				dev_err(adev->dev,
> +					"suspend of IP block <%s> failed %d\n",
> +					adev->ip_blocks[i].version->funcs->name, r);
> +				return r;
> +			}
>   		}
>   		adev->ip_blocks[i].status.hw = false;
>   	}
> diff --git a/drivers/gpu/drm/amd/amdgpu/smu_v13_0_10.c b/drivers/gpu/drm/amd/amdgpu/smu_v13_0_10.c
> index 5ea9090b5040..ab049f0b4d39 100644
> --- a/drivers/gpu/drm/amd/amdgpu/smu_v13_0_10.c
> +++ b/drivers/gpu/drm/amd/amdgpu/smu_v13_0_10.c
> @@ -80,13 +80,14 @@ static int smu_v13_0_10_mode2_suspend_ip(struct amdgpu_device *adev)
>   			      AMD_IP_BLOCK_TYPE_MES))
>   			continue;
>   
> -		r = adev->ip_blocks[i].version->funcs->suspend(&adev->ip_blocks[i]);
> -
> -		if (r) {
> -			dev_err(adev->dev,
> -				"suspend of IP block <%s> failed %d\n",
> -				adev->ip_blocks[i].version->funcs->name, r);
> -			return r;
> +		if (adev->ip_blocks[i].version->funcs->suspend) {
> +			r = adev->ip_blocks[i].version->funcs->suspend(&adev->ip_blocks[i]);
> +			if (r) {
> +				dev_err(adev->dev,
> +					"suspend of IP block <%s> failed %d\n",
> +					adev->ip_blocks[i].version->funcs->name, r);
> +				return r;
> +			}
>   		}
>   		adev->ip_blocks[i].status.hw = false;
>   	}

