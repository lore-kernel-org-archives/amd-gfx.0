Return-Path: <SRS0=/upn=OT=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C288CC433F5
	for <amd-gfx@archiver.kernel.org>; Wed, 29 Sep 2021 09:18:51 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8A613613A9
	for <amd-gfx@archiver.kernel.org>; Wed, 29 Sep 2021 09:18:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 8A613613A9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1F2C66EA15;
	Wed, 29 Sep 2021 09:18:51 +0000 (UTC)
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com
 [IPv6:2a00:1450:4864:20::330])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7FB5B6EA15
 for <amd-gfx@lists.freedesktop.org>; Wed, 29 Sep 2021 09:18:50 +0000 (UTC)
Received: by mail-wm1-x330.google.com with SMTP id
 l18-20020a05600c4f1200b002f8cf606262so4647879wmq.1
 for <amd-gfx@lists.freedesktop.org>; Wed, 29 Sep 2021 02:18:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=subject:to:references:from:message-id:date:user-agent:mime-version
 :in-reply-to:content-transfer-encoding:content-language;
 bh=BUBj9ykhw028wa2ermedbaUrHPJ6b7wyasyqR4N4ENo=;
 b=V3Txsm4HqYUE2uGxIL3RGIPICGgCdMydcYchYc6zsgYehYeok4O4sGnwg1MPglE2P4
 ORhxn/40ivu1wSUWJwNBQH08aYUATWmXxEtwZJCc+sufgnsTyffm1YjhVsiTGW/ECFVB
 ww1qDsoDbj43AyLt74mFyFaymZStZtFQXyG0zVIfJFSk+mlgpnFGl8c4rVQfIWjAGGUb
 60hbb9uxxv89I+745PcyJrWaV+WmuBD+nbb2geVc16DH8HHlJiGXjXvw1hbSR9dFa6I9
 m7XrR2ECQwMbr8eDEbkzKFVwGKIfW94EkvoNmFEkuzLO/bGgw2451F7dP2aZ4k/bQOWN
 KbNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:subject:to:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=BUBj9ykhw028wa2ermedbaUrHPJ6b7wyasyqR4N4ENo=;
 b=PN3YNY9JLFdylZEry04eETLMRBqfIBXY/EuTZiR83aej7lug0WPNNIAk10WKwM11bL
 uIALL8nBmbRjTQ9rQJy0/MX4I0rLJd5Fgzn15AjrXL0IqvRt0loUVfbmiGyrBkL0ApxF
 9JtBs9SNLKxrx5xTjPGzbeIh8Ed3Q/H8yysGKXYh+50PusutkSkThr/L/S5ek43gMhhr
 upX1qwd4hXJNPYI7Ukll27WyWInlkNOImw69SHtWfjTxSYt/hnFaphV4veGTz9yHwMb1
 KP3c4pE4khljp9Uwf5EW1TY+F2urFhW+C2zHbzN3kNztqheE74T7bPDGocppzi80jEih
 Ejmg==
X-Gm-Message-State: AOAM531+NIWCMJX4JM6P/yTnwT81OEUB/KqMNK3SVKKgFzEYpVXklWE5
 gzzKV13bLYBnO8qOfOrNhulUv71+8nk=
X-Google-Smtp-Source: ABdhPJw/8CegBWR8RFgs2hvGq2Q8hvQIzqBxgBcKgINteHisFGKqVTlkbypzInLJHigl9qG/wDiUqw==
X-Received: by 2002:a1c:7f52:: with SMTP id a79mr9209328wmd.34.1632907129082; 
 Wed, 29 Sep 2021 02:18:49 -0700 (PDT)
Received: from ?IPv6:2a02:908:1252:fb60:4405:6e4f:ef81:78d1?
 ([2a02:908:1252:fb60:4405:6e4f:ef81:78d1])
 by smtp.gmail.com with ESMTPSA id v18sm903304wml.44.2021.09.29.02.18.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 29 Sep 2021 02:18:48 -0700 (PDT)
Subject: Re: [PATCH 52/64] drm/amdgpu: get VCN and SDMA instances from IP
 discovery table
To: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
References: <20210928164237.833132-1-alexander.deucher@amd.com>
 <20210928164237.833132-53-alexander.deucher@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
Message-ID: <ade696b4-925f-2949-b03f-a2192fadd198@gmail.com>
Date: Wed, 29 Sep 2021 11:18:47 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20210928164237.833132-53-alexander.deucher@amd.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
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

Am 28.09.21 um 18:42 schrieb Alex Deucher:
> Rather than hardcoding it.  We already have the number of VCN
> instances from a previous patch, so just update the VCN
> instances for chips with static tables.
>
> v2: squash in checks for SDMA3,4 (Guchun)
> v3: clarify VCN changes
>
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>

Reviewed-by: Christian König <christian.koenig@amd.com>

> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c | 14 ++++++++++++++
>   1 file changed, 14 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
> index d3069841ff79..13cd814f2626 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
> @@ -363,6 +363,11 @@ int amdgpu_discovery_reg_base_init(struct amdgpu_device *adev)
>   
>   			if (le16_to_cpu(ip->hw_id) == VCN_HWID)
>   				adev->vcn.num_vcn_inst++;
> +			if (le16_to_cpu(ip->hw_id) == SDMA0_HWID ||
> +			    le16_to_cpu(ip->hw_id) == SDMA1_HWID ||
> +			    le16_to_cpu(ip->hw_id) == SDMA2_HWID ||
> +			    le16_to_cpu(ip->hw_id) == SDMA3_HWID)
> +				adev->sdma.num_instances++;
>   
>   			for (k = 0; k < num_base_address; k++) {
>   				/*
> @@ -529,6 +534,7 @@ int amdgpu_discovery_set_ip_blocks(struct amdgpu_device *adev)
>   	switch (adev->asic_type) {
>   	case CHIP_VEGA10:
>   		vega10_reg_base_init(adev);
> +		adev->sdma.num_instances = 2;
>   		adev->ip_versions[MMHUB_HWIP] = IP_VERSION(9, 0, 0);
>   		adev->ip_versions[ATHUB_HWIP] = IP_VERSION(9, 0, 0);
>   		adev->ip_versions[OSSSYS_HWIP] = IP_VERSION(4, 0, 0);
> @@ -548,6 +554,7 @@ int amdgpu_discovery_set_ip_blocks(struct amdgpu_device *adev)
>   		break;
>   	case CHIP_VEGA12:
>   		vega10_reg_base_init(adev);
> +		adev->sdma.num_instances = 2;
>   		adev->ip_versions[MMHUB_HWIP] = IP_VERSION(9, 3, 0);
>   		adev->ip_versions[ATHUB_HWIP] = IP_VERSION(9, 3, 0);
>   		adev->ip_versions[OSSSYS_HWIP] = IP_VERSION(4, 0, 1);
> @@ -567,6 +574,8 @@ int amdgpu_discovery_set_ip_blocks(struct amdgpu_device *adev)
>   		break;
>   	case CHIP_RAVEN:
>   		vega10_reg_base_init(adev);
> +		adev->sdma.num_instances = 1;
> +		adev->vcn.num_vcn_inst = 1;
>   		if (adev->apu_flags & AMD_APU_IS_RAVEN2) {
>   			adev->ip_versions[MMHUB_HWIP] = IP_VERSION(9, 2, 0);
>   			adev->ip_versions[ATHUB_HWIP] = IP_VERSION(9, 2, 0);
> @@ -603,6 +612,7 @@ int amdgpu_discovery_set_ip_blocks(struct amdgpu_device *adev)
>   		break;
>   	case CHIP_VEGA20:
>   		vega20_reg_base_init(adev);
> +		adev->sdma.num_instances = 2;
>   		adev->ip_versions[MMHUB_HWIP] = IP_VERSION(9, 4, 0);
>   		adev->ip_versions[ATHUB_HWIP] = IP_VERSION(9, 4, 0);
>   		adev->ip_versions[OSSSYS_HWIP] = IP_VERSION(4, 2, 0);
> @@ -622,6 +632,8 @@ int amdgpu_discovery_set_ip_blocks(struct amdgpu_device *adev)
>   		break;
>   	case CHIP_ARCTURUS:
>   		arct_reg_base_init(adev);
> +		adev->sdma.num_instances = 8;
> +		adev->vcn.num_vcn_inst = 2;
>   		adev->ip_versions[MMHUB_HWIP] = IP_VERSION(9, 4, 1);
>   		adev->ip_versions[ATHUB_HWIP] = IP_VERSION(9, 4, 1);
>   		adev->ip_versions[OSSSYS_HWIP] = IP_VERSION(4, 2, 1);
> @@ -639,6 +651,8 @@ int amdgpu_discovery_set_ip_blocks(struct amdgpu_device *adev)
>   		break;
>   	case CHIP_ALDEBARAN:
>   		aldebaran_reg_base_init(adev);
> +		adev->sdma.num_instances = 5;
> +		adev->vcn.num_vcn_inst = 2;
>   		adev->ip_versions[MMHUB_HWIP] = IP_VERSION(9, 4, 2);
>   		adev->ip_versions[ATHUB_HWIP] = IP_VERSION(9, 4, 2);
>   		adev->ip_versions[OSSSYS_HWIP] = IP_VERSION(4, 4, 0);

