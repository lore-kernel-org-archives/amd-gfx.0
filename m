Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B39BC3DA4B
	for <amd-gfx@archiver.kernel.org>; Mon, 15 Jul 2024 14:58:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DCC4510E3F8;
	Mon, 15 Jul 2024 14:58:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="LaJQCZv9";
	dkim-atps=neutral
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com
 [209.85.208.170])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7F9FB10E3F8
 for <amd-gfx@lists.freedesktop.org>; Mon, 15 Jul 2024 14:58:25 +0000 (UTC)
Received: by mail-lj1-f170.google.com with SMTP id
 38308e7fff4ca-2eedebccfa4so23840741fa.1
 for <amd-gfx@lists.freedesktop.org>; Mon, 15 Jul 2024 07:58:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1721055504; x=1721660304; darn=lists.freedesktop.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=5k6FAhx6WwthCREZgf61NYG/O1ZbuEXPrfu50l58hk8=;
 b=LaJQCZv9zSMG3COkg+nrMeeHP8kjPM6reJeAI+hHBNnARV5Lnzi2Slk7elJf/WybqK
 ykdH0LI6lf/GWKslqKkilm87u1EZYwJ1B01mPgIhW7WLSGz+++VGccG3Qlw72cspJUaL
 6E1AgVUgA0Cj7FOzeZEMH+GVdNir1EvyLACKcTze7JRIbz4vL4FfV14NuCsYS/UU1uwn
 5uV/YmIWyBAaD6+6W08cOc8kECYO1dsFkEsE1mpOgVVb7wtsrzStuemtpdUv5+R4nYVu
 rs1n3yi1fdQRQA1+cYkbtuzs45a/gVPi8Xeqn9HIlc7CLMwfdieXdeeFgDuZ3wfWU/kw
 geaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721055504; x=1721660304;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=5k6FAhx6WwthCREZgf61NYG/O1ZbuEXPrfu50l58hk8=;
 b=nnPb77yBZMzHmCqO6uW/LqtrEJ5lenAyww6+qNzhmnMc+CKKsOHH0u41B+wjxUISab
 rZT8OVPcpY8+grOmdxjnAtwHlHnraZB/5CyhZbFIwaZdn7fMIuttxNZDFx1R2VEU+gTS
 MG073DVlwaibnmR/fXffFvLEz3w1YH0pwLECdTx2zN3OldaNBQeu+7YYzC8wJatW7+c6
 bm0vaSZLcPqBmB8Qy8ZEyi6/3ezGO+dE5cAtppTCDea8bz8kW89GLmVAW5EaNT7Ta7qR
 LDxvLAeonrwnWqPFnO99AgZw8ZgN1V04hKKIMHhr1pfp+WLTQbY0UHYK1NhAr6lmyu/c
 bUbw==
X-Gm-Message-State: AOJu0Yxc1qOk/i/P+QWlIELSCwDYNANFX9HYfUvbf0gtxeGCvZjXb5c2
 dKzrXBDJkuSJ4geS6rNH1a+9A2yCfnd0+49AgtlByadFCtutEEEf
X-Google-Smtp-Source: AGHT+IEDnubw50M9sEGgFb/FY56H3q2QZUzt5dAq3yKCvPmMhoDFZBAI7sByGgVsYOWnKzbgB3AtgQ==
X-Received: by 2002:a2e:9e54:0:b0:2ec:5933:a62c with SMTP id
 38308e7fff4ca-2eef2d78823mr1053781fa.22.1721055503112; 
 Mon, 15 Jul 2024 07:58:23 -0700 (PDT)
Received: from [10.254.108.81] (munvpn.amd.com. [165.204.72.6])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3680dab3d4dsm6654332f8f.23.2024.07.15.07.58.22
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 15 Jul 2024 07:58:22 -0700 (PDT)
Message-ID: <cf9dc5a2-39d1-4973-b06b-6b791f6298b6@gmail.com>
Date: Mon, 15 Jul 2024 16:58:19 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] drm/amdgpu: Add empty HDP flush function to JPEG
 v4.0.3
To: Jane Jian <Jane.Jian@amd.com>, Lijo.Lazar@amd.com, Haijun.Chang@amd.com,
 Victor.Zhao@amd.com
Cc: amd-gfx@lists.freedesktop.org
References: <20240715144748.168556-1-Jane.Jian@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>
In-Reply-To: <20240715144748.168556-1-Jane.Jian@amd.com>
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



Am 15.07.24 um 16:47 schrieb Jane Jian:
> From: Lijo Lazar <lijo.lazar@amd.com>
>
> JPEG v4.0.3 doesn't support HDP flush when RRMT is enabled. Instead,
> mmsch fw will do the flush.
>
> Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
> Signed-off-by: Jane Jian <Jane.Jian@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c | 9 +++++++++
>   1 file changed, 9 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c
> index 04d8966423de..ea601047dab0 100644
> --- a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c
> +++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c
> @@ -621,6 +621,14 @@ static uint64_t jpeg_v4_0_3_dec_ring_get_wptr(struct amdgpu_ring *ring)
>   			ring->pipe ? (0x40 * ring->pipe - 0xc80) : 0);
>   }
>   
> +static void jpeg_v4_0_3_ring_emit_hdp_flush(struct amdgpu_ring *ring)
> +{
> +	/* VCN engine access for HDP flush doesn't work when RRMT is enabled.
> +	 * This is a workaround to avoid any HDP flush through VCN ring. Instead
> +	 * HDP flush will be done by driver while submitting doorbell.

I think that should read "HDP flush will be done by firmware ....".

Or is it really the driver which should do this? In this case the patch 
here would be wrong.

Regards,
Christian.

> +	 */
> +}
> +
>   /**
>    * jpeg_v4_0_3_dec_ring_set_wptr - set write pointer
>    *
> @@ -1072,6 +1080,7 @@ static const struct amdgpu_ring_funcs jpeg_v4_0_3_dec_ring_vm_funcs = {
>   	.emit_ib = jpeg_v4_0_3_dec_ring_emit_ib,
>   	.emit_fence = jpeg_v4_0_3_dec_ring_emit_fence,
>   	.emit_vm_flush = jpeg_v4_0_3_dec_ring_emit_vm_flush,
> +	.emit_hdp_flush = jpeg_v4_0_3_ring_emit_hdp_flush,
>   	.test_ring = amdgpu_jpeg_dec_ring_test_ring,
>   	.test_ib = amdgpu_jpeg_dec_ring_test_ib,
>   	.insert_nop = jpeg_v4_0_3_dec_ring_nop,

