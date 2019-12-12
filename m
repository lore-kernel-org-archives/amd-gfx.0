Return-Path: <SRS0=4UhO=2C=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE5DAC43603
	for <amd-gfx@archiver.kernel.org>; Thu, 12 Dec 2019 08:18:40 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BFB592173E
	for <amd-gfx@archiver.kernel.org>; Thu, 12 Dec 2019 08:18:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mdSUEC3I"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BFB592173E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8B8BF6EC7C;
	Thu, 12 Dec 2019 08:18:40 +0000 (UTC)
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com
 [IPv6:2a00:1450:4864:20::343])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E44776EC7C
 for <amd-gfx@lists.freedesktop.org>; Thu, 12 Dec 2019 08:18:38 +0000 (UTC)
Received: by mail-wm1-x343.google.com with SMTP id t14so1405725wmi.5
 for <amd-gfx@lists.freedesktop.org>; Thu, 12 Dec 2019 00:18:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=reply-to:subject:to:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-transfer-encoding:content-language;
 bh=H2rt+pgEtX9xO6PsEhrdSWbvK6TPtxxYPmf44I9SnUY=;
 b=mdSUEC3IoVrTaZdBg+ApszMzswP86RCox1YJFwQVeS4ckxxerRgLGpbejlUEkjCLw+
 NA2at/+5ZqYUzfIjWMorlYle6+wgVc6ZKZIWh4D8eLpvu0fbmU8QoMPbOZFqOcmDcMbW
 xFD6zKSAd8Xfsz5SVf61pyI1ek4jYDx7YHEJVcCEfcpzNCG0J3IwMjDQonHcio6/k4AW
 iN5LPOgjUKEs5YoZZGaVMYctIHd9H+JzMVPIy9VOIWg2bZ0QrWSEOTwLB47LrxGPxFE0
 GCkRI0zpCojPM2oq5WgMpHLG8nmcr+5JoCLFaBUf8ZXJ9c3Bqk5qOc0K6b/RaXOTsYzT
 P1AQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:reply-to:subject:to:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=H2rt+pgEtX9xO6PsEhrdSWbvK6TPtxxYPmf44I9SnUY=;
 b=O3gdizq7hbdPHD6ZXcpiQcZRfc2+fUzl7jEnPIvUNWURM/6FNwb/WjixIkeU7T6VGe
 DWvVjmUj1d6ty9yJtZkaqCWpZ2a905G5k2e8fVGKRjRqmoGHGBatjMt54hFzaVwPLnTg
 wU+bv18k2QKP5L5ymY1iPfNoyZ53E2ItZ8cIWLRowZH5cyBlC3UpNQI6O0zQG04lkt3C
 nN2kQmKF3GrWKtZAspygJVwUU/OYs4H6OpMZ89uk7uffaMHfvXzhpnwrLVuo5QBWprTn
 JqE5HyYkAHQXIm4+jszudsvFZTuk44bxExPM90i5T68Jdg39ViJDSntbN8ihJP5NwIIo
 A0rA==
X-Gm-Message-State: APjAAAUU/4ytZZrcnX+sGon6+TmH9INUngfP86B72mQIpGRS0hdIMk4X
 VKYACxcOEibBEc0fYY/DlM8ZmtdV
X-Google-Smtp-Source: APXvYqxiUhIYP6MDSaMooSv9+NzcF4TyjBaZM+QZYCieBBmc8HiWgIAHF6Q1weaeiX+j1AHOtL1lLQ==
X-Received: by 2002:a7b:c936:: with SMTP id h22mr4750789wml.115.1576138717244; 
 Thu, 12 Dec 2019 00:18:37 -0800 (PST)
Received: from ?IPv6:2a02:908:1252:fb60:be8a:bd56:1f94:86e7?
 ([2a02:908:1252:fb60:be8a:bd56:1f94:86e7])
 by smtp.gmail.com with ESMTPSA id u8sm5254610wmm.15.2019.12.12.00.18.31
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 12 Dec 2019 00:18:36 -0800 (PST)
Subject: Re: [PATCH] drm/amdgpu: add JPEG check to VCN idle handler and begin
 use
To: Leo Liu <leo.liu@amd.com>, amd-gfx@lists.freedesktop.org
References: <20191211194824.11146-1-leo.liu@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
Message-ID: <05c7579c-d373-1367-35cc-e1f5f69dc7a4@gmail.com>
Date: Thu, 12 Dec 2019 09:18:30 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191211194824.11146-1-leo.liu@amd.com>
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
Reply-To: christian.koenig@amd.com
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Am 11.12.19 um 20:48 schrieb Leo Liu:
> Since it's only needed with VCN1.0 when HW has no its
> own JPEG HW IP block

Wouldn't it be simpler/cleaner to just define a 
vcn_v1_0_ring_begin_use() and vcn_v1_0_idle_work_handler() instead?

Regards,
Christian.

>
> Signed-off-by: Leo Liu <leo.liu@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c | 29 +++++++++++++++----------
>   drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h |  2 ++
>   2 files changed, 20 insertions(+), 11 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
> index 428cfd58b37d..95ac721f2de0 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
> @@ -186,6 +186,9 @@ int amdgpu_vcn_sw_init(struct amdgpu_device *adev)
>   		}
>   	}
>   
> +	adev->vcn.has_jpeg_block = (amdgpu_device_ip_get_ip_block(adev, AMD_IP_BLOCK_TYPE_JPEG)) ?
> +		true : false;
> +
>   	return 0;
>   }
>   
> @@ -306,15 +309,17 @@ static void amdgpu_vcn_idle_work_handler(struct work_struct *work)
>   			else
>   				new_state.fw_based = VCN_DPG_STATE__UNPAUSE;
>   
> -			if (amdgpu_fence_count_emitted(&adev->jpeg.inst[j].ring_dec))
> -				new_state.jpeg = VCN_DPG_STATE__PAUSE;
> -			else
> -				new_state.jpeg = VCN_DPG_STATE__UNPAUSE;
> -
> +			if (!adev->vcn.has_jpeg_block) {
> +				if (amdgpu_fence_count_emitted(&adev->jpeg.inst[j].ring_dec))
> +					new_state.jpeg = VCN_DPG_STATE__PAUSE;
> +				else
> +					new_state.jpeg = VCN_DPG_STATE__UNPAUSE;
> +			}
>   			adev->vcn.pause_dpg_mode(adev, &new_state);
>   		}
>   
> -		fence[j] += amdgpu_fence_count_emitted(&adev->jpeg.inst[j].ring_dec);
> +		if (!adev->vcn.has_jpeg_block)
> +			fence[j] += amdgpu_fence_count_emitted(&adev->jpeg.inst[j].ring_dec);
>   		fence[j] += amdgpu_fence_count_emitted(&adev->vcn.inst[j].ring_dec);
>   		fences += fence[j];
>   	}
> @@ -358,14 +363,16 @@ void amdgpu_vcn_ring_begin_use(struct amdgpu_ring *ring)
>   		else
>   			new_state.fw_based = VCN_DPG_STATE__UNPAUSE;
>   
> -		if (amdgpu_fence_count_emitted(&adev->jpeg.inst[ring->me].ring_dec))
> -			new_state.jpeg = VCN_DPG_STATE__PAUSE;
> -		else
> -			new_state.jpeg = VCN_DPG_STATE__UNPAUSE;
> +		if (!adev->vcn.has_jpeg_block) {
> +			if (amdgpu_fence_count_emitted(&adev->jpeg.inst[ring->me].ring_dec))
> +				new_state.jpeg = VCN_DPG_STATE__PAUSE;
> +			else
> +				new_state.jpeg = VCN_DPG_STATE__UNPAUSE;
> +		}
>   
>   		if (ring->funcs->type == AMDGPU_RING_TYPE_VCN_ENC)
>   			new_state.fw_based = VCN_DPG_STATE__PAUSE;
> -		else if (ring->funcs->type == AMDGPU_RING_TYPE_VCN_JPEG)
> +		else if (!adev->vcn.has_jpeg_block && ring->funcs->type == AMDGPU_RING_TYPE_VCN_JPEG)
>   			new_state.jpeg = VCN_DPG_STATE__PAUSE;
>   
>   		adev->vcn.pause_dpg_mode(adev, &new_state);
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
> index 402a5046b985..9a2381d006c6 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
> @@ -192,6 +192,8 @@ struct amdgpu_vcn {
>   	unsigned	harvest_config;
>   	int (*pause_dpg_mode)(struct amdgpu_device *adev,
>   		struct dpg_pause_state *new_state);
> +
> +	bool has_jpeg_block;
>   };
>   
>   int amdgpu_vcn_sw_init(struct amdgpu_device *adev);

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
