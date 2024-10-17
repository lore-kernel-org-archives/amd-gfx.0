Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E742D2F7CE
	for <amd-gfx@archiver.kernel.org>; Thu, 17 Oct 2024 11:55:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 09E1C10E7FA;
	Thu, 17 Oct 2024 11:55:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="j2tWycm+";
	dkim-atps=neutral
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com
 [209.85.128.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9732D10E7FA
 for <amd-gfx@lists.freedesktop.org>; Thu, 17 Oct 2024 11:55:52 +0000 (UTC)
Received: by mail-wm1-f52.google.com with SMTP id
 5b1f17b1804b1-431195c3538so7687705e9.3
 for <amd-gfx@lists.freedesktop.org>; Thu, 17 Oct 2024 04:55:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1729166151; x=1729770951; darn=lists.freedesktop.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=xcSzEWlXQqtBxgcNkBN74W4JZj8m660tEqRu4z0oEuU=;
 b=j2tWycm+XK6++uq5kCRHfWIBaY3IYFJqHlwwW3wgyrqt95NxpJZETayEUgq7G3lXsc
 MmSyxqyk11zFfqXdlRfN1ys9YLWNU8YGt7qLhdMA9qpMywgVskoVUtGnqPJGK0TK3D8h
 hu1dhYFtZI00DMiiojB/aKqf9cQY54R7i8IdQ0PPBxY4WxjaEXEkQj/bn9L3ljLMeqHe
 4VGZ9M42YdM81uCa5KyEFi2CRvAtGdkl+KgrPlwEkrAHWg4AcXnee82H8Mk4u1hz+LOs
 SCvS9q2JddsFclYsNXscrRRcSsWSZzF0hHHztgGwao/C6akSSra7de0xgZbUS8MTBM0e
 1Qlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729166151; x=1729770951;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=xcSzEWlXQqtBxgcNkBN74W4JZj8m660tEqRu4z0oEuU=;
 b=UBXO4SXj3pMgRoUXkRG7f5oTGTMwVgf/r04+cSakXrXE7Co8B57yGTdYFKOW7jt8PN
 ha/M9SxjSMssUWkpdnBZ1OLu+dtzSdNmbDaVkoE3uGR04LPfih+/f40NGGzITIos5U19
 i5S3vn/a0lNrgF+EJEFVWKau1In00V+OMl/g6tcd7LA6bdDkI4SLGJIxt6uKnvUpJqTF
 AIvfZluOBapMBFDVPwQtMFzZSQxou5TH0t5Wyx8VwrtW8u8DnzEHDmF/lsibSJae3Pg7
 yyNRIXcAmxXh9tBW8EQNUclgjbmn4mF6eeBRRDqRbNzSsE3anD/J0whLjHdlQVGG6ljw
 Ub3Q==
X-Gm-Message-State: AOJu0YxgxDKjQqVJfqmu54t91udZhUGtyHFUy9UZHMmU/4nHuXTmOuvb
 asUQKN2+JqCOyJC+qt4UBmeR2xjwuWv0HzgEe7N2Cdh1/0XXLsNtIxrUkg==
X-Google-Smtp-Source: AGHT+IFNy9nNS06nyiUaIPNfrDnZZ7wONMC58GgMDFgS6NDJ02cMF/KPEFSkxqqbWRqfbALC/nR1JA==
X-Received: by 2002:a05:600c:3d0c:b0:431:561b:b32a with SMTP id
 5b1f17b1804b1-431561bb485mr22466655e9.19.1729166150603; 
 Thu, 17 Oct 2024 04:55:50 -0700 (PDT)
Received: from [10.254.108.81] (munvpn.amd.com. [165.204.72.6])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43158c55a87sm23716975e9.35.2024.10.17.04.55.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 17 Oct 2024 04:55:50 -0700 (PDT)
Message-ID: <bd5cebef-9423-4cd2-a965-208735bca523@gmail.com>
Date: Thu, 17 Oct 2024 13:55:46 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 07/15] drm/amdgpu: validate resume before function call
To: Sunil Khatri <sunil.khatri@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Cc: amd-gfx@lists.freedesktop.org
References: <20241017100615.1492144-1-sunil.khatri@amd.com>
 <20241017100615.1492144-8-sunil.khatri@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>
In-Reply-To: <20241017100615.1492144-8-sunil.khatri@amd.com>
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

Same comment as patch #5, please add an amdgpu_ip_block_resume() function.

Regards,
Christian.

Am 17.10.24 um 12:06 schrieb Sunil Khatri:
> Before making a function call to resume, validate
> the function pointer like we do in sw_init.
>
> Signed-off-by: Sunil Khatri <sunil.khatri@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/aldebaran.c      | 23 ++++++----
>   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c  | 47 ++++++++++++---------
>   drivers/gpu/drm/amd/amdgpu/sienna_cichlid.c | 28 ++++++------
>   drivers/gpu/drm/amd/amdgpu/smu_v13_0_10.c   | 14 +++---
>   4 files changed, 66 insertions(+), 46 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/aldebaran.c b/drivers/gpu/drm/amd/amdgpu/aldebaran.c
> index e55d680d95ce..4dd9af51210d 100644
> --- a/drivers/gpu/drm/amd/amdgpu/aldebaran.c
> +++ b/drivers/gpu/drm/amd/amdgpu/aldebaran.c
> @@ -247,9 +247,11 @@ static int aldebaran_mode2_restore_ip(struct amdgpu_device *adev)
>   		dev_err(adev->dev, "Failed to get BIF handle\n");
>   		return -EINVAL;
>   	}
> -	r = cmn_block->version->funcs->resume(cmn_block);
> -	if (r)
> -		return r;
> +	if (cmn_block->version->funcs->resume) {
> +		r = cmn_block->version->funcs->resume(cmn_block);
> +		if (r)
> +			return r;
> +	}
>   
>   	/* Reinit GFXHUB */
>   	adev->gfxhub.funcs->init(adev);
> @@ -283,12 +285,15 @@ static int aldebaran_mode2_restore_ip(struct amdgpu_device *adev)
>   		      adev->ip_blocks[i].version->type ==
>   			      AMD_IP_BLOCK_TYPE_SDMA))
>   			continue;
> -		r = adev->ip_blocks[i].version->funcs->resume(&adev->ip_blocks[i]);
> -		if (r) {
> -			dev_err(adev->dev,
> -				"resume of IP block <%s> failed %d\n",
> -				adev->ip_blocks[i].version->funcs->name, r);
> -			return r;
> +
> +		if (adev->ip_blocks[i].version->funcs->resume) {
> +			r = adev->ip_blocks[i].version->funcs->resume(&adev->ip_blocks[i]);
> +			if (r) {
> +				dev_err(adev->dev,
> +					"resume of IP block <%s> failed %d\n",
> +					adev->ip_blocks[i].version->funcs->name, r);
> +				return r;
> +			}
>   		}
>   
>   		adev->ip_blocks[i].status.hw = true;
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> index fda89aeb4d1b..aa7314c14db8 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -2744,11 +2744,15 @@ static int amdgpu_device_fw_loading(struct amdgpu_device *adev)
>   				break;
>   
>   			if (amdgpu_in_reset(adev) || adev->in_suspend) {
> -				r = adev->ip_blocks[i].version->funcs->resume(&adev->ip_blocks[i]);
> -				if (r) {
> -					DRM_ERROR("resume of IP block <%s> failed %d\n",
> -							  adev->ip_blocks[i].version->funcs->name, r);
> -					return r;
> +				if (adev->ip_blocks[i].version->funcs->resume) {
> +					r = adev->ip_blocks[i].version->funcs->resume(
> +						&adev->ip_blocks[i]);
> +					if (r) {
> +						DRM_ERROR("resume of IP block <%s> failed %d\n",
> +							adev->ip_blocks[i].version->funcs
> +							->name, r);
> +						return r;
> +					}
>   				}
>   			} else {
>   				r = adev->ip_blocks[i].version->funcs->hw_init(&adev->ip_blocks[i]);
> @@ -3683,10 +3687,12 @@ static int amdgpu_device_ip_reinit_late_sriov(struct amdgpu_device *adev)
>   				block->status.hw)
>   				continue;
>   
> -			if (block->version->type == AMD_IP_BLOCK_TYPE_SMC)
> -				r = block->version->funcs->resume(&adev->ip_blocks[i]);
> -			else
> +			if (block->version->type == AMD_IP_BLOCK_TYPE_SMC) {
> +				if (adev->ip_blocks[i].version->funcs->resume)
> +					r = block->version->funcs->resume(&adev->ip_blocks[i]);
> +			} else {
>   				r = block->version->funcs->hw_init(&adev->ip_blocks[i]);
> +			}
>   
>   			DRM_INFO("RE-INIT-late: %s %s\n", block->version->funcs->name, r?"failed":"succeeded");
>   			if (r)
> @@ -3721,12 +3727,13 @@ static int amdgpu_device_ip_resume_phase1(struct amdgpu_device *adev)
>   		    adev->ip_blocks[i].version->type == AMD_IP_BLOCK_TYPE_GMC ||
>   		    adev->ip_blocks[i].version->type == AMD_IP_BLOCK_TYPE_IH ||
>   		    (adev->ip_blocks[i].version->type == AMD_IP_BLOCK_TYPE_PSP && amdgpu_sriov_vf(adev))) {
> -
> -			r = adev->ip_blocks[i].version->funcs->resume(&adev->ip_blocks[i]);
> -			if (r) {
> -				DRM_ERROR("resume of IP block <%s> failed %d\n",
> -					  adev->ip_blocks[i].version->funcs->name, r);
> -				return r;
> +			if (adev->ip_blocks[i].version->funcs->resume) {
> +				r = adev->ip_blocks[i].version->funcs->resume(&adev->ip_blocks[i]);
> +				if (r) {
> +					DRM_ERROR("resume of IP block <%s> failed %d\n",
> +						adev->ip_blocks[i].version->funcs->name, r);
> +					return r;
> +				}
>   			}
>   			adev->ip_blocks[i].status.hw = true;
>   		}
> @@ -3760,11 +3767,13 @@ static int amdgpu_device_ip_resume_phase2(struct amdgpu_device *adev)
>   		    adev->ip_blocks[i].version->type == AMD_IP_BLOCK_TYPE_IH ||
>   		    adev->ip_blocks[i].version->type == AMD_IP_BLOCK_TYPE_PSP)
>   			continue;
> -		r = adev->ip_blocks[i].version->funcs->resume(&adev->ip_blocks[i]);
> -		if (r) {
> -			DRM_ERROR("resume of IP block <%s> failed %d\n",
> -				  adev->ip_blocks[i].version->funcs->name, r);
> -			return r;
> +		if (adev->ip_blocks[i].version->funcs->resume) {
> +			r = adev->ip_blocks[i].version->funcs->resume(&adev->ip_blocks[i]);
> +			if (r) {
> +				DRM_ERROR("resume of IP block <%s> failed %d\n",
> +					adev->ip_blocks[i].version->funcs->name, r);
> +				return r;
> +			}
>   		}
>   		adev->ip_blocks[i].status.hw = true;
>   	}
> diff --git a/drivers/gpu/drm/amd/amdgpu/sienna_cichlid.c b/drivers/gpu/drm/amd/amdgpu/sienna_cichlid.c
> index 10dece12509f..082a69babe62 100644
> --- a/drivers/gpu/drm/amd/amdgpu/sienna_cichlid.c
> +++ b/drivers/gpu/drm/amd/amdgpu/sienna_cichlid.c
> @@ -176,12 +176,14 @@ static int sienna_cichlid_mode2_restore_ip(struct amdgpu_device *adev)
>   
>   	for (i = 0; i < adev->num_ip_blocks; i++) {
>   		if (adev->ip_blocks[i].version->type == AMD_IP_BLOCK_TYPE_IH) {
> -			r = adev->ip_blocks[i].version->funcs->resume(&adev->ip_blocks[i]);
> -			if (r) {
> -				dev_err(adev->dev,
> -					"resume of IP block <%s> failed %d\n",
> -					adev->ip_blocks[i].version->funcs->name, r);
> -				return r;
> +			if (adev->ip_blocks[i].version->funcs->resume) {
> +				r = adev->ip_blocks[i].version->funcs->resume(&adev->ip_blocks[i]);
> +				if (r) {
> +					dev_err(adev->dev,
> +						"resume of IP block <%s> failed %d\n",
> +						adev->ip_blocks[i].version->funcs->name, r);
> +					return r;
> +				}
>   			}
>   
>   			adev->ip_blocks[i].status.hw = true;
> @@ -194,12 +196,14 @@ static int sienna_cichlid_mode2_restore_ip(struct amdgpu_device *adev)
>   		      adev->ip_blocks[i].version->type ==
>   			      AMD_IP_BLOCK_TYPE_SDMA))
>   			continue;
> -		r = adev->ip_blocks[i].version->funcs->resume(&adev->ip_blocks[i]);
> -		if (r) {
> -			dev_err(adev->dev,
> -				"resume of IP block <%s> failed %d\n",
> -				adev->ip_blocks[i].version->funcs->name, r);
> -			return r;
> +		if (adev->ip_blocks[i].version->funcs->resume) {
> +			r = adev->ip_blocks[i].version->funcs->resume(&adev->ip_blocks[i]);
> +			if (r) {
> +				dev_err(adev->dev,
> +					"resume of IP block <%s> failed %d\n",
> +					adev->ip_blocks[i].version->funcs->name, r);
> +				return r;
> +			}
>   		}
>   
>   		adev->ip_blocks[i].status.hw = true;
> diff --git a/drivers/gpu/drm/amd/amdgpu/smu_v13_0_10.c b/drivers/gpu/drm/amd/amdgpu/smu_v13_0_10.c
> index ab049f0b4d39..2e041424ef9f 100644
> --- a/drivers/gpu/drm/amd/amdgpu/smu_v13_0_10.c
> +++ b/drivers/gpu/drm/amd/amdgpu/smu_v13_0_10.c
> @@ -187,12 +187,14 @@ static int smu_v13_0_10_mode2_restore_ip(struct amdgpu_device *adev)
>   		      adev->ip_blocks[i].version->type ==
>   			      AMD_IP_BLOCK_TYPE_SDMA))
>   			continue;
> -		r = adev->ip_blocks[i].version->funcs->resume(&adev->ip_blocks[i]);
> -		if (r) {
> -			dev_err(adev->dev,
> -				"resume of IP block <%s> failed %d\n",
> -				adev->ip_blocks[i].version->funcs->name, r);
> -			return r;
> +		if (adev->ip_blocks[i].version->funcs->resume) {
> +			r = adev->ip_blocks[i].version->funcs->resume(&adev->ip_blocks[i]);
> +			if (r) {
> +				dev_err(adev->dev,
> +					"resume of IP block <%s> failed %d\n",
> +					adev->ip_blocks[i].version->funcs->name, r);
> +				return r;
> +			}
>   		}
>   
>   		adev->ip_blocks[i].status.hw = true;

