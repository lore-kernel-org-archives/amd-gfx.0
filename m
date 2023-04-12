Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2441DC77B6E
	for <amd-gfx@archiver.kernel.org>; Wed, 12 Apr 2023 12:47:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B5DC810E7CF;
	Wed, 12 Apr 2023 12:47:11 +0000 (UTC)
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com
 [IPv6:2a00:1450:4864:20::334])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 661A910E7CF
 for <amd-gfx@lists.freedesktop.org>; Wed, 12 Apr 2023 12:47:10 +0000 (UTC)
Received: by mail-wm1-x334.google.com with SMTP id
 gw11-20020a05600c850b00b003f07d305b32so7209149wmb.4
 for <amd-gfx@lists.freedesktop.org>; Wed, 12 Apr 2023 05:47:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1681303629; x=1683895629;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=6YyIO2mzwWfZiRA9RYtOIj/OuYm9aBepvn8QW7KYdEA=;
 b=Yz/MhwzDgZfJdKFsy2E1X1PB5+jZiib0rgsk8dHrhJ9quvxsqfXay0PDqb+01PH+Hw
 YkxWOkRYhDQ/huE1QvmuY0jLeQs0MMcyNz5w/eieZLFZWVRNWwsnijW/nkM5mJwjYfYu
 PsGxr7pah+tbIj23uaUlLuYDzvG2I9TzL4YIZE0+f28p2grbyISNLwGcRYAvibauCd40
 ZSSBcvoEIpJ8gDxYtN1ihSOHCHVpwniSSu8s8Z6bwaY8fPQNAp+2HpE0Fp5iVo5bSY1H
 1j5SYlmik0/3zNotYxpHw9dCJiyAA7sMDtDddNfC2Gwi6EiYrC8V6UBpaKlRPYZWVBdT
 2piA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112; t=1681303629; x=1683895629;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=6YyIO2mzwWfZiRA9RYtOIj/OuYm9aBepvn8QW7KYdEA=;
 b=Z7ilhm1tXDoScJjpBFRBZd4GQRRjlFdzuRiHA0sbZ4rNzbgs79DmNLoxa5Er/Kpc2i
 CyzdBwtE38EhPx/v4Iv6a8bhMh58J32UpsUVvllm8+9U84oM+B/loi21dYXjSqvkFQ/F
 y58IPS5C6BqDtAkpLS6Cf1fvqKUfDjMS+kW4RW3xvZSB5b2NQTfUMve8GqL5qmzDMSMV
 6Ju8EKjGSODLATNhc6R2KUqtxlTqqBBwzlGc7DIPoGJIqKPcvgvFBJrMAAi78mGUeP+v
 M6E6VcOe9TgdfIk7bWHAIHGW5bTrCAeMY9p030zJS/pJhYvYv7NdsWh6TPSCbFgwdJcs
 SohA==
X-Gm-Message-State: AAQBX9dfkrcyaXe7F7uXL6kJ+IwnyyDvzyK2SP+RJMIEMofNReWlrSPu
 9mzZxoirW3uMl9KlDPsorxM=
X-Google-Smtp-Source: AKy350aTA/8Ds10geoWg39NREIF1haNFZJnD5odwTx0tfzgWKq9B0El6evzMAI4U/Gphj3ZY82JJaw==
X-Received: by 2002:a7b:c406:0:b0:3ee:42fd:7768 with SMTP id
 k6-20020a7bc406000000b003ee42fd7768mr12735047wmi.1.1681303628651; 
 Wed, 12 Apr 2023 05:47:08 -0700 (PDT)
Received: from ?IPV6:2a02:908:1256:79a0:fe02:9bb5:5deb:be0e?
 ([2a02:908:1256:79a0:fe02:9bb5:5deb:be0e])
 by smtp.gmail.com with ESMTPSA id
 t18-20020a7bc3d2000000b003f0373d077csm2237891wmj.47.2023.04.12.05.47.07
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 12 Apr 2023 05:47:08 -0700 (PDT)
Message-ID: <9077c624-53ba-55c4-d530-b6a987f83f20@gmail.com>
Date: Wed, 12 Apr 2023 14:47:07 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH v3 2/2] drm/amdgpu: Add support for querying the max ibs
 in a submission. (v3)
Content-Language: en-US
To: Bas Nieuwenhuizen <bas@basnieuwenhuizen.nl>, amd-gfx@lists.freedesktop.org
References: <20230412121827.1122035-1-bas@basnieuwenhuizen.nl>
 <20230412121827.1122035-2-bas@basnieuwenhuizen.nl>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
In-Reply-To: <20230412121827.1122035-2-bas@basnieuwenhuizen.nl>
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
Cc: alexander.deucher@amd.com, christian.koenig@amd.com, maraeo@gmail.com,
 timur.kristof@gmail.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Am 12.04.23 um 14:18 schrieb Bas Nieuwenhuizen:
> This info would be used by radv to figure out when we need to
> split a submission into multiple submissions. radv currently has
> a limit of 192 which seems to work for most gfx submissions, but
> is way too high for e.g. compute or sdma.
>
> Userspace is available at
> https://gitlab.freedesktop.org/bnieuwenhuizen/mesa/-/commits/ib-rejection-v3
>
> v3: Completely rewrote based on suggestion of making it a separate query.
>
> Link: https://gitlab.freedesktop.org/drm/amd/-/issues/2498
> Signed-off-by: Bas Nieuwenhuizen <bas@basnieuwenhuizen.nl>

Reviewed-by: Christian König <christian.koenig@amd.com>

> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c | 9 +++++++++
>   include/uapi/drm/amdgpu_drm.h           | 2 ++
>   2 files changed, 11 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> index 0efb38539d70..1a2e342af1c0 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> @@ -1140,6 +1140,15 @@ int amdgpu_info_ioctl(struct drm_device *dev, void *data, struct drm_file *filp)
>   		kfree(caps);
>   		return r;
>   	}
> +	case AMDGPU_INFO_MAX_IBS: {
> +		uint32_t max_ibs[AMDGPU_HW_IP_NUM];
> +
> +		for (i = 0; i < AMDGPU_HW_IP_NUM; ++i)
> +			max_ibs[i] = amdgpu_ring_max_ibs(i);
> +
> +		return copy_to_user(out, max_ibs,
> +				    min((size_t)size, sizeof(max_ibs))) ? -EFAULT : 0;
> +	}
>   	default:
>   		DRM_DEBUG_KMS("Invalid request %d\n", info->query);
>   		return -EINVAL;
> diff --git a/include/uapi/drm/amdgpu_drm.h b/include/uapi/drm/amdgpu_drm.h
> index b6eb90df5d05..6981e59a9401 100644
> --- a/include/uapi/drm/amdgpu_drm.h
> +++ b/include/uapi/drm/amdgpu_drm.h
> @@ -876,6 +876,8 @@ struct drm_amdgpu_cs_chunk_data {
>   	#define AMDGPU_INFO_VIDEO_CAPS_DECODE		0
>   	/* Subquery id: Encode */
>   	#define AMDGPU_INFO_VIDEO_CAPS_ENCODE		1
> +/* Query the max number of IBs per gang per submission */
> +#define AMDGPU_INFO_MAX_IBS			0x22
>   
>   #define AMDGPU_INFO_MMR_SE_INDEX_SHIFT	0
>   #define AMDGPU_INFO_MMR_SE_INDEX_MASK	0xff

