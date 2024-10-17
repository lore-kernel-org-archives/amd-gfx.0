Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D93FAD2A53A
	for <amd-gfx@archiver.kernel.org>; Thu, 17 Oct 2024 11:52:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7415A10E7FF;
	Thu, 17 Oct 2024 11:52:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="YjJLrs94";
	dkim-atps=neutral
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com
 [209.85.221.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7BFA210E813
 for <amd-gfx@lists.freedesktop.org>; Thu, 17 Oct 2024 11:52:44 +0000 (UTC)
Received: by mail-wr1-f54.google.com with SMTP id
 ffacd0b85a97d-37d6ff1cbe1so647450f8f.3
 for <amd-gfx@lists.freedesktop.org>; Thu, 17 Oct 2024 04:52:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1729165963; x=1729770763; darn=lists.freedesktop.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=vZAQScTx2lR1ul3UqKh2BpU9BJLOiKFrfDXa/0mkqo0=;
 b=YjJLrs94z9puii1+IaHchlmX4NcKgBal6RNZ9u4FyLpMEPlaa0XCR4m18UoHrsnASI
 fU2iF0P8+mOGct79qT3X8ERDmA1vz+dzG71dZSqCSV7Ds/8OUWLXr/CUdbX1MmK14q4B
 ZlxqoZTAm7XTsgZO0bbFEUk2zaOrIFmTbSIKaxCWhGvxTh6GitX+QiRW0FCUHjirWGDe
 FwnOmW7wgUaYoMpSkpV1tH0DqZJ8m9ue2KwWPu/0TLhzQCzYGWcUiHgs4HQPe+qF1wKM
 KYiXfqbuMUdD0cYpgyFSD9Ru8UcHMInVAQiJel9iveSFnAYBKCADjRBW2d4VAoTuN9Eq
 f18A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729165963; x=1729770763;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=vZAQScTx2lR1ul3UqKh2BpU9BJLOiKFrfDXa/0mkqo0=;
 b=tSS6O/7fihiqFiIeU/ToQ0YUqOTPCpSwc4zsra+72FSuYQX/WeUDrGRwhFo5u8a6Iv
 kcwLFV2svrZEiRPlkED1wJrNKsUx5qnWRyHjHuTbreSX/ndvsa6y9uxQ6svZyJxbgh6y
 49u9t68D76p3QoSTV+GxJCAJuvrDrINXAPm6g48VrrirNXallis6Jbb7UM7F3R6XB8Pe
 DqUVrmXBqseMsS8SSdMbr2cHV6vIC2Xo70hGr8Oc89LoKfeuaMwyr3VIoJWF2o2j3l0x
 x6FrTb45yszu1ksKrsq7Y+CwpgB6HT0sDAHoEW+Up0llpmUnZaMPJk79b7DH9Ez5siP5
 OGcg==
X-Gm-Message-State: AOJu0YyVHxxrghpRCVSmVZVVzBvhPVbqO7/XAYiZnzNc61nMTsaoIKcd
 KRccntrEwdnTBmK7TBCvrF31qPwNb/5yo2I3tYH4FvvKD+JLt9sV
X-Google-Smtp-Source: AGHT+IEqmv9lmtVeIpqZU41T68PNDkk3gGpNPgocHFkyok0q6eBnsgoVr7lKxs04+neplldrDa0FWQ==
X-Received: by 2002:adf:b351:0:b0:37d:354e:946a with SMTP id
 ffacd0b85a97d-37d552d8d62mr13754317f8f.50.1729165962430; 
 Thu, 17 Oct 2024 04:52:42 -0700 (PDT)
Received: from [10.254.108.81] (munvpn.amd.com. [165.204.72.6])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-37d7fa87d48sm7002370f8f.32.2024.10.17.04.52.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 17 Oct 2024 04:52:41 -0700 (PDT)
Message-ID: <b44b172b-675c-465a-8329-1d93f2abc04e@gmail.com>
Date: Thu, 17 Oct 2024 13:52:38 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 05/15] drm/amdgpu: validate hw_fini before function call
To: Sunil Khatri <sunil.khatri@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Cc: amd-gfx@lists.freedesktop.org
References: <20241017100615.1492144-1-sunil.khatri@amd.com>
 <20241017100615.1492144-6-sunil.khatri@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>
In-Reply-To: <20241017100615.1492144-6-sunil.khatri@amd.com>
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
> Before making a function call to hw_fini, validate
> the function pointer like we do in sw_init.
>
> Signed-off-by: Sunil Khatri <sunil.khatri@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 33 ++++++++++++++--------
>   1 file changed, 22 insertions(+), 11 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> index cf84b50f2355..96cecd4a636b 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -3287,11 +3287,17 @@ static void amdgpu_device_smu_fini_early(struct amdgpu_device *adev)
>   		if (!adev->ip_blocks[i].status.hw)
>   			continue;
>   		if (adev->ip_blocks[i].version->type == AMD_IP_BLOCK_TYPE_SMC) {
> -			r = adev->ip_blocks[i].version->funcs->hw_fini(&adev->ip_blocks[i]);
> -			/* XXX handle errors */
> -			if (r) {
> -				DRM_DEBUG("hw_fini of IP block <%s> failed %d\n",
> -					  adev->ip_blocks[i].version->funcs->name, r);
> +			if (!adev->ip_blocks[i].version->funcs->hw_fini) {
> +				DRM_ERROR("hw_fini of IP block <%s> not defined\n",
> +						adev->ip_blocks[i].version->funcs->name);
> +			} else {
> +				r = adev->ip_blocks[i].version->funcs->hw_fini(
> +					&adev->ip_blocks[i]);
> +				/* XXX handle errors */
> +				if (r) {
> +					DRM_DEBUG("hw_fini of IP block <%s> failed %d\n",
> +						adev->ip_blocks[i].version->funcs->name, r);
> +				}
>   			}
>   			adev->ip_blocks[i].status.hw = false;
>   			break;
> @@ -3325,12 +3331,17 @@ static int amdgpu_device_ip_fini_early(struct amdgpu_device *adev)
>   	for (i = adev->num_ip_blocks - 1; i >= 0; i--) {
>   		if (!adev->ip_blocks[i].status.hw)
>   			continue;
> -
> -		r = adev->ip_blocks[i].version->funcs->hw_fini(&adev->ip_blocks[i]);
> -		/* XXX handle errors */
> -		if (r) {
> -			DRM_DEBUG("hw_fini of IP block <%s> failed %d\n",
> -				  adev->ip_blocks[i].version->funcs->name, r);
> +		if (!adev->ip_blocks[i].version->funcs->hw_fini) {
> +			DRM_ERROR("hw_fini of IP block <%s> not defined\n",
> +				  adev->ip_blocks[i].version->funcs->name);
> +		} else {
> +			r = adev->ip_blocks[i].version->funcs->hw_fini(
> +				&adev->ip_blocks[i]);
> +			/* XXX handle errors */
> +			if (r) {
> +				DRM_DEBUG("hw_fini of IP block <%s> failed %d\n",
> +					  adev->ip_blocks[i].version->funcs->name, r);
> +			}

I strongly suggest to make this a separate function, e.g. something like 
amdgpu_ip_block_hw_fini() and then call it twice.

Regards,
Christian.

>   		}
>   
>   		adev->ip_blocks[i].status.hw = false;

