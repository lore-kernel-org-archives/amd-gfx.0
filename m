Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A48AECD1284
	for <amd-gfx@archiver.kernel.org>; Tue,  2 Apr 2024 13:38:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2E5E010F291;
	Tue,  2 Apr 2024 13:38:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="JXsp7KIs";
	dkim-atps=neutral
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com
 [209.85.221.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 58E9710E8EB
 for <amd-gfx@lists.freedesktop.org>; Tue,  2 Apr 2024 13:38:33 +0000 (UTC)
Received: by mail-wr1-f50.google.com with SMTP id
 ffacd0b85a97d-341ccef5058so3783628f8f.2
 for <amd-gfx@lists.freedesktop.org>; Tue, 02 Apr 2024 06:38:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1712065111; x=1712669911; darn=lists.freedesktop.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=KkzvTpv0t9XIJ+Dh7ka/nHeqYLCwGvJjbvTu7QUlrC0=;
 b=JXsp7KIsiZ90Txm03vdvRqiONqkUvvOTR3F6/ICUGKJHqmJRRjwO8Png+SZ1GXersq
 UDV4HaLJ3FuGRTr99JsHaA7eok0SXQBpICrIvQKKDAlFblsuNw9kgKR3FkpTj3eerxb7
 UlbNkX1cBKccDuAacjrciLzKgHOVCUMtYR8A4OZ3plNlU/1Nqy61sOlQqlGrYk0XiKsd
 BCL2WugQmmAdRYTjJqdHiAbyXidabZB44vBmgGtf0pXxSBQXjnICx2F76dZ3qc7d1zjV
 UExVfOYEO8iOdLbV/RBrCjqGHQGT3gJuRS5dVNK5gHV1LUgu4sxhyaytMK0If9YnnszJ
 M6mQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712065111; x=1712669911;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=KkzvTpv0t9XIJ+Dh7ka/nHeqYLCwGvJjbvTu7QUlrC0=;
 b=JFJUeeSnFI//rj0KEpXlPWUcC8dNxaTn8k4MS8BdSWOTm/7AFhvIivmXvovgrlIAuX
 EeinTnI60aiqZNl6DDBvvSJws35KA8u/P7VxZJ78bPJsUGnTqestYBMmCV2P292ZHinJ
 GElxScbg9KSRpRw6wU8c4oWlIcIOQHGNFLFHNFnIyRPDred4zBndPzLOicraBGGi8kQh
 cAlnxPSDoFOswRg2eoyEElnzyV0v3hZpwsCSpzB29pWaK5l+jjpineVSS2eVHJ96n1JO
 tL0BCShtcitJq/ERfKirQ24ktvsFn7fX/My/zIfs/lYtIobKKFX1L4V0OQIlnr7L+9xv
 nvMw==
X-Forwarded-Encrypted: i=1;
 AJvYcCULTVytsbjTcdouy7fw+JsnyKQdZCBrirOUEPACpoevKyn+BLoZVeDdZZbORl4fZk7KlreXdExlhSqwLpmLr/oh5H0i7jPkb3Nb2rMrWA==
X-Gm-Message-State: AOJu0Yx4ZSX+ldCd+Pp/3TGNrDeQLunXkNaUHf9hZb8SmJgpWlxtxEyI
 0Xj1IuWL23Y2be7GEpFPWVlplSieCMmkBdR6ieSMsPU0uMFcTSRS
X-Google-Smtp-Source: AGHT+IEpzLjURBHXQViFYoWRP18sW/7fEFA/sJLkyu0XlWW9IWF7p1OydWTfM+xw8thDyAzwZFYzHQ==
X-Received: by 2002:adf:f986:0:b0:341:d2e2:31d4 with SMTP id
 f6-20020adff986000000b00341d2e231d4mr7152394wrr.57.1712065111069; 
 Tue, 02 Apr 2024 06:38:31 -0700 (PDT)
Received: from [10.254.108.81] (munvpn.amd.com. [165.204.72.6])
 by smtp.gmail.com with ESMTPSA id
 n2-20020a056000170200b0034335e47102sm12312425wrc.113.2024.04.02.06.38.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 02 Apr 2024 06:38:30 -0700 (PDT)
Message-ID: <d3581afc-4bc4-4e42-a4f5-5b4be5f10ed3@gmail.com>
Date: Tue, 2 Apr 2024 15:38:28 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: add post reset IP callback
To: Lang Yu <Lang.Yu@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Alex Deucher <alexander.deucher@amd.com>,
 Christian Koenig <christian.koenig@amd.com>,
 "Sharma, Shashank" <Shashank.Sharma@amd.com>
References: <20240328044014.3278891-1-Lang.Yu@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>
In-Reply-To: <20240328044014.3278891-1-Lang.Yu@amd.com>
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

Am 28.03.24 um 05:40 schrieb Lang Yu:
> There are use cases which need full GPU functionality
> (e.g., VM update, TLB inavildate) when doing a GPU reset.
>
> Especially, the mes/umsch self tests which help validate
> the hw state after hw init like ring/ib tests.

I noted that before but just to repeat it once more: We can't do any MES 
or UMSCH validation while doing a GPU reset!

The ring and IB tests use some pre-allocated memory we put aside for the 
task during driver load and so can execute during GPU reset as well.

But for the MES/UMSCH we need a full blown environment with VM and 
submission infrastructure and setting that up isn't possible here.

Adding Shashank as well, but I think we should probably just completely 
remove those from the kernel.

Regards,
Christian.

>
> Add a post reset IP callback to handle such use cases
> which will be executed after GPU reset succeeds.
>
> Signed-off-by: Lang Yu <Lang.Yu@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 24 ++++++++++++++++++++++
>   drivers/gpu/drm/amd/include/amd_shared.h   |  3 +++
>   2 files changed, 27 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> index 12dc71a6b5db..feeab9397aab 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -5556,6 +5556,27 @@ static int amdgpu_device_health_check(struct list_head *device_list_handle)
>   	return ret;
>   }
>   
> +static int amdgpu_device_ip_post_reset(struct amdgpu_device *adev)
> +{
> +	uint32_t i;
> +	int r;
> +
> +	for (i = 0; i < adev->num_ip_blocks; i++) {
> +		if (!adev->ip_blocks[i].status.valid ||
> +		    !adev->ip_blocks[i].version->funcs->post_reset)
> +			continue;
> +
> +		r = adev->ip_blocks[i].version->funcs->post_reset(adev);
> +		if (r) {
> +			DRM_ERROR("post reset of IP block <%s> failed %d\n",
> +				  adev->ip_blocks[i].version->funcs->name, r);
> +			return r;
> +		}
> +	}
> +
> +	return r;
> +}
> +
>   /**
>    * amdgpu_device_gpu_recover - reset the asic and recover scheduler
>    *
> @@ -5805,6 +5826,9 @@ int amdgpu_device_gpu_recover(struct amdgpu_device *adev,
>   		amdgpu_put_xgmi_hive(hive);
>   	}
>   
> +	if (!r && !job_signaled)
> +		r = amdgpu_device_ip_post_reset(adev);
> +
>   	if (r)
>   		dev_info(adev->dev, "GPU reset end with ret = %d\n", r);
>   
> diff --git a/drivers/gpu/drm/amd/include/amd_shared.h b/drivers/gpu/drm/amd/include/amd_shared.h
> index b0a6256e89f4..33ce30a8e3ab 100644
> --- a/drivers/gpu/drm/amd/include/amd_shared.h
> +++ b/drivers/gpu/drm/amd/include/amd_shared.h
> @@ -287,6 +287,7 @@ enum amd_dpm_forced_level;
>    * @pre_soft_reset: pre soft reset the IP block
>    * @soft_reset: soft reset the IP block
>    * @post_soft_reset: post soft reset the IP block
> + * @post_reset: handles IP specific post reset stuff(e.g., self test)
>    * @set_clockgating_state: enable/disable cg for the IP block
>    * @set_powergating_state: enable/disable pg for the IP block
>    * @get_clockgating_state: get current clockgating status
> @@ -316,11 +317,13 @@ struct amd_ip_funcs {
>   	int (*pre_soft_reset)(void *handle);
>   	int (*soft_reset)(void *handle);
>   	int (*post_soft_reset)(void *handle);
> +	int (*post_reset)(void *handle);
>   	int (*set_clockgating_state)(void *handle,
>   				     enum amd_clockgating_state state);
>   	int (*set_powergating_state)(void *handle,
>   				     enum amd_powergating_state state);
>   	void (*get_clockgating_state)(void *handle, u64 *flags);
> +
>   };
>   
>   

