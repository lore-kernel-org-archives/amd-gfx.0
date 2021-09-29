Return-Path: <SRS0=/upn=OT=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDE3AC433EF
	for <amd-gfx@archiver.kernel.org>; Wed, 29 Sep 2021 09:23:13 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B1FAE613A9
	for <amd-gfx@archiver.kernel.org>; Wed, 29 Sep 2021 09:23:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org B1FAE613A9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 29DD16EA17;
	Wed, 29 Sep 2021 09:23:13 +0000 (UTC)
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com
 [IPv6:2a00:1450:4864:20::430])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 47A556EA17
 for <amd-gfx@lists.freedesktop.org>; Wed, 29 Sep 2021 09:23:11 +0000 (UTC)
Received: by mail-wr1-x430.google.com with SMTP id t8so3095919wrq.4
 for <amd-gfx@lists.freedesktop.org>; Wed, 29 Sep 2021 02:23:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=subject:to:references:from:message-id:date:user-agent:mime-version
 :in-reply-to:content-transfer-encoding:content-language;
 bh=+eTR/OCglH0LE/lrTge0pXArogO5pFHGPIL6KrDDks8=;
 b=Tn4ZJ9Y7K7PfHfgw+rhEsHxgqp7/zs4OHljv4hLLHZgZC5CFt8tcB8ycrrvRyLS7VC
 7vA+/6Y0n4ScWrsVn9GNkYACGgqpPBL8dFjsqwL5hTjGsLFdjWg3k42cPzCuoyDOawKl
 Tqnx0zTXOSQRZl2Q6b/HTLDyT+6AifP+J/6n8DiafhOb7WDtN3dkTXb7VvtElOtg9NRx
 jr3Dpr2r5B4KfR/P9q1YU6qHJ11faewK3fCaC++PBaJo0cWuAj9ziJH7uYMsH7j9UB53
 VFvJK6I32qr1SnyWopbKP0K+k5Pikev6OiLP/70+OSqSvHhXY1k+GXc38L7D2hsu3VTW
 cACA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:subject:to:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=+eTR/OCglH0LE/lrTge0pXArogO5pFHGPIL6KrDDks8=;
 b=vuMZvreswcHU4jT4TBs+v/kcHClRcNRpsl2zuBninZT2pZs6Yqr+J0X/wOXCBnCybZ
 Sv+kpqXU40F9JOSInm4NNAoL9KMAOIwrBQo6ewqYO+lPjkEXv0IpvWy3GzGxxrA9Hqb+
 fXLJ+gnBXpu5oPGBW2nd+/AWK8goDHfa3FG2zvxkYXbDp9it8Tbbk1AdHH8FDsUBujTa
 JX5jOxmZClnOkqa0jA0P8ruZDth8eidm2ffoz21UUfMejDlrA1/p5KWC+rZnw9Xw92mf
 u3AADdamn6AtLxx3QbOZUWgo8U/FGCVbFGaDzWXvnUZELzdsDUKJUDmIpI34gWgkKbq4
 IRIw==
X-Gm-Message-State: AOAM5301VoliHZcb6savUG1Gia8SgikbP3rVKrInJDFxGTeBMd9c07OU
 4OZmJxg1ARgCDYKm4zwWwzTE5nnu2sU=
X-Google-Smtp-Source: ABdhPJz9MriUYHZGeA+WNg1/A8cIEOriCH3IGZwnMiV9zeRIHCtaB2I7KLBea1n1yAoMioNm+5V5mw==
X-Received: by 2002:adf:e0cc:: with SMTP id m12mr5637539wri.62.1632907389765; 
 Wed, 29 Sep 2021 02:23:09 -0700 (PDT)
Received: from ?IPv6:2a02:908:1252:fb60:4405:6e4f:ef81:78d1?
 ([2a02:908:1252:fb60:4405:6e4f:ef81:78d1])
 by smtp.gmail.com with ESMTPSA id q7sm1665482wrc.55.2021.09.29.02.23.09
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 29 Sep 2021 02:23:09 -0700 (PDT)
Subject: Re: [PATCH 61/64] drm/amdgpu: add support for SRIOV in IP discovery
 path
To: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
References: <20210928164237.833132-1-alexander.deucher@amd.com>
 <20210928164237.833132-62-alexander.deucher@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
Message-ID: <22b1a4c6-cd0b-4700-3cb3-b0b9f3528982@gmail.com>
Date: Wed, 29 Sep 2021 11:23:08 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20210928164237.833132-62-alexander.deucher@amd.com>
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
> Handle SRIOV requirements when adding IP blocks.
>
> v2: add comment about UVD/VCE support on vega20 SR-IOV
>
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>

Acked-by: Christian König <christian.koenig@amd.com>

> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c | 34 ++++++++++++++-----
>   1 file changed, 25 insertions(+), 9 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
> index d9c2a7210a1b..091ded38545f 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
> @@ -820,7 +820,9 @@ static int amdgpu_discovery_set_mm_ip_blocks(struct amdgpu_device *adev)
>   		switch (adev->ip_versions[UVD_HWIP][0]) {
>   		case IP_VERSION(7, 0, 0):
>   		case IP_VERSION(7, 2, 0):
> -			amdgpu_device_ip_block_add(adev, &uvd_v7_0_ip_block);
> +			/* UVD is not supported on vega20 SR-IOV */
> +			if (!(adev->asic_type == CHIP_VEGA20 && amdgpu_sriov_vf(adev)))
> +				amdgpu_device_ip_block_add(adev, &uvd_v7_0_ip_block);
>   			break;
>   		default:
>   			return -EINVAL;
> @@ -828,7 +830,9 @@ static int amdgpu_discovery_set_mm_ip_blocks(struct amdgpu_device *adev)
>   		switch (adev->ip_versions[VCE_HWIP][0]) {
>   		case IP_VERSION(4, 0, 0):
>   		case IP_VERSION(4, 1, 0):
> -			amdgpu_device_ip_block_add(adev, &vce_v4_0_ip_block);
> +			/* VCE is not supported on vega20 SR-IOV */
> +			if (!(adev->asic_type == CHIP_VEGA20 && amdgpu_sriov_vf(adev)))
> +				amdgpu_device_ip_block_add(adev, &vce_v4_0_ip_block);
>   			break;
>   		default:
>   			return -EINVAL;
> @@ -860,7 +864,8 @@ static int amdgpu_discovery_set_mm_ip_blocks(struct amdgpu_device *adev)
>   		case IP_VERSION(3, 1, 1):
>   		case IP_VERSION(3, 0, 2):
>   			amdgpu_device_ip_block_add(adev, &vcn_v3_0_ip_block);
> -			amdgpu_device_ip_block_add(adev, &jpeg_v3_0_ip_block);
> +			if (!amdgpu_sriov_vf(adev))
> +				amdgpu_device_ip_block_add(adev, &jpeg_v3_0_ip_block);
>   			break;
>   		case IP_VERSION(3, 0, 33):
>   			amdgpu_device_ip_block_add(adev, &vcn_v3_0_ip_block);
> @@ -1202,14 +1207,24 @@ int amdgpu_discovery_set_ip_blocks(struct amdgpu_device *adev)
>   	if (r)
>   		return r;
>   
> -	r = amdgpu_discovery_set_ih_ip_blocks(adev);
> -	if (r)
> -		return r;
> -
> -	if (likely(adev->firmware.load_type == AMDGPU_FW_LOAD_PSP)) {
> +	/* For SR-IOV, PSP needs to be initialized before IH */
> +	if (amdgpu_sriov_vf(adev)) {
>   		r = amdgpu_discovery_set_psp_ip_blocks(adev);
>   		if (r)
>   			return r;
> +		r = amdgpu_discovery_set_ih_ip_blocks(adev);
> +		if (r)
> +			return r;
> +	} else {
> +		r = amdgpu_discovery_set_ih_ip_blocks(adev);
> +		if (r)
> +			return r;
> +
> +		if (likely(adev->firmware.load_type == AMDGPU_FW_LOAD_PSP)) {
> +			r = amdgpu_discovery_set_psp_ip_blocks(adev);
> +			if (r)
> +				return r;
> +		}
>   	}
>   
>   	if (likely(adev->firmware.load_type == AMDGPU_FW_LOAD_PSP)) {
> @@ -1230,7 +1245,8 @@ int amdgpu_discovery_set_ip_blocks(struct amdgpu_device *adev)
>   	if (r)
>   		return r;
>   
> -	if (adev->firmware.load_type == AMDGPU_FW_LOAD_DIRECT) {
> +	if (adev->firmware.load_type == AMDGPU_FW_LOAD_DIRECT &&
> +	    !amdgpu_sriov_vf(adev)) {
>   		r = amdgpu_discovery_set_smu_ip_blocks(adev);
>   		if (r)
>   			return r;

