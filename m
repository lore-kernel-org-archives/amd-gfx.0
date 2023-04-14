Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6D01C77B6E
	for <amd-gfx@archiver.kernel.org>; Fri, 14 Apr 2023 11:28:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5649210E163;
	Fri, 14 Apr 2023 11:28:35 +0000 (UTC)
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com
 [IPv6:2a00:1450:4864:20::434])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 73B3010E163
 for <amd-gfx@lists.freedesktop.org>; Fri, 14 Apr 2023 11:28:33 +0000 (UTC)
Received: by mail-wr1-x434.google.com with SMTP id l18so17081799wrb.9
 for <amd-gfx@lists.freedesktop.org>; Fri, 14 Apr 2023 04:28:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1681471711; x=1684063711;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=1BbWo+tJIhShoe+zMasqt7DjW1F+t8hXJBPunBzu1J8=;
 b=GzIK39jc8M+35oULAk7K4uWRjjdB2OwyAOetogWjpLLIfWx4aoYqoUlCafSMBkLGIB
 +2Lwycuw5MbpKUv685NvlsCVC3v42d4EjA9fLgTnCMqgExAixWYaYNFmWsRhnTwdZ92d
 Ua6xr7mjkg8xA907mFL+bveqtbVCCG9+yAGS9OXHmaIDw9HnMxWxs9ZZmtDKHe1voq2i
 GzIJ0cbzyX1Mhyuecc5TiEFBgyBzYpWLUcFynWoFY/UpHL/oW4f0PDL6Dc0T+YY1b1h0
 K7wL+WNQTMp+N2/fZyXKbDgQfyR5Se4vxL48BhG8ify/LCAfcAZZxPMf/w9gRNOcmzco
 qJ/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1681471711; x=1684063711;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=1BbWo+tJIhShoe+zMasqt7DjW1F+t8hXJBPunBzu1J8=;
 b=Sjok1+MQDJQK62h6com6Yp865pKyU3FrOmj3xpahwFz5BywhKqta1UdHqeabgkw0IF
 wNsT8lSN0ROpZ2eTx6FHXPGeScd05HBdpc0yruWtTl6o4RYnPnPtyupmj1P9QSogUK8e
 +kiJ6qtBItm8SIsvMiJqeABJV0978kGVHMigJHFLgkPU4Z/ScNMBFBjYdzYTxav2gjE3
 NxlvoMitZI9tO6VwIPJebqGcPZmq+0+zmt+zvVSm6bctHvfyL3QIOhGOuPGxknh6LmK4
 8musBl+K+T9t4VpgVK00MTyADGC/4QXk29Vpbw2uZrQyyLdo36isrthmHhrVFxsO2m9m
 N4vg==
X-Gm-Message-State: AAQBX9fkbWTpGqPYh2Etgps4qxzeMDtT80YgmPn7ppyWbOdEecEuuyfP
 hPhDInjHuPY/iOzXjfIHF98=
X-Google-Smtp-Source: AKy350YjUSLRi37TQTPJYvKScJ4Bin7Eoa/t3j8J4n7WVf1Ajo5lFtYByZh5XAUYF7ldZdQorQ60Gg==
X-Received: by 2002:a5d:5290:0:b0:2ce:a7b3:1c71 with SMTP id
 c16-20020a5d5290000000b002cea7b31c71mr3689823wrv.35.1681471710500; 
 Fri, 14 Apr 2023 04:28:30 -0700 (PDT)
Received: from ?IPV6:2a02:908:1256:79a0:5357:4cbc:25bd:5ed5?
 ([2a02:908:1256:79a0:5357:4cbc:25bd:5ed5])
 by smtp.gmail.com with ESMTPSA id
 u6-20020a5d6ac6000000b002f2789d1bcfsm3376693wrw.21.2023.04.14.04.28.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 14 Apr 2023 04:28:29 -0700 (PDT)
Message-ID: <dddc5280-84d1-a9a2-8c21-849bcf4f3250@gmail.com>
Date: Fri, 14 Apr 2023 13:28:28 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH v4 3/3] drm/amdgpu: Add support for querying the max ibs
 in a submission. (v3)
Content-Language: en-US
To: Bas Nieuwenhuizen <bas@basnieuwenhuizen.nl>, amd-gfx@lists.freedesktop.org
References: <20230413142253.414333-1-bas@basnieuwenhuizen.nl>
 <20230413142253.414333-3-bas@basnieuwenhuizen.nl>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
In-Reply-To: <20230413142253.414333-3-bas@basnieuwenhuizen.nl>
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

Am 13.04.23 um 16:22 schrieb Bas Nieuwenhuizen:
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

