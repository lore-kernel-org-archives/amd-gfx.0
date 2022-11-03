Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20A86C433FE
	for <amd-gfx@archiver.kernel.org>; Thu,  3 Nov 2022 07:43:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6258D10E5B3;
	Thu,  3 Nov 2022 07:43:08 +0000 (UTC)
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com
 [IPv6:2a00:1450:4864:20::42d])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 57E9D10E5B3
 for <amd-gfx@lists.freedesktop.org>; Thu,  3 Nov 2022 07:43:04 +0000 (UTC)
Received: by mail-wr1-x42d.google.com with SMTP id a14so1370896wru.5
 for <amd-gfx@lists.freedesktop.org>; Thu, 03 Nov 2022 00:43:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=atimFmz0FAsoyfVYhuq0v+iX3qLfp4HSzH/dzbO8Ht0=;
 b=W6Z9NtW0pzI7MMwHXpt9c6b6NZWenOaB0Nb1FhvcMDKwYvZmpRlK5ghgxIk+oj95dc
 OSj8Rh63V6KvmswZ5plCxMZtYouGbUnYoOgHu9TlMfUB2yxLAH56Y5dwm+U2EcfjbkNh
 ozh40FWfYocn7oh/B313OqXEgSruJDzqmZ1AEe4wETi0rVrrFYvCTcUSmCzXew1IK4Ge
 8EyeshYH4AjlZi11Z3t21wizD7MwRCW0ukcm+PM5U0cvQ2uTJWSpTXariBsq5bAzB0Kl
 +cGFfYwERqV+d+J7nnwk/bstlVPznQamGieNi8hziP9lTvZxsMAikpYX899zqVfUlwqn
 K5rQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=atimFmz0FAsoyfVYhuq0v+iX3qLfp4HSzH/dzbO8Ht0=;
 b=qyn8REiqkyMlwLpTdxp9KrLKtpsouThAP53MZu/4Jv8nj/IKuBJ9TzAd4nIRu7Husn
 HzcXwmAPIs7x6zxKS6pb7zBYn1NDBFoceDvH5X/l18eOZLuM53Z8Ig6tf+Q7QpvGtK3X
 hj/yj09MiHoCSwiIkeOO8VdO4/EcrsssIHuO2TkdBtrloQKsRyMgQ4E/+vKJUVIPvbiv
 k+ge94boSoDViPtuITkFHmcqwCCmUDoB62jSSus8aGLyMOUPZbpOVt/zsQjxLaO03RXW
 6HPaqI1GUmePCCriCxOsVm2rY0IC8kNL0p2k2WV5fdBkBRQEumStTU7TqjKn1XGltTcC
 Df1w==
X-Gm-Message-State: ACrzQf0w9Rn66ZbuF6JBrV4Mt8w1iWdGEL/urEzz8JaM2QUo0O7LVTGQ
 sbLdN7BOpqZl8/pkM2Nil1A=
X-Google-Smtp-Source: AMsMyM5XVrofqktXWnO/d3OT277BQBeZtlhLvRqa9B+nJ1fYh5UDBaOvkhXy8pNb89luLueTAFYBaA==
X-Received: by 2002:a5d:4351:0:b0:236:c820:97b8 with SMTP id
 u17-20020a5d4351000000b00236c82097b8mr13837719wrr.699.1667461382732; 
 Thu, 03 Nov 2022 00:43:02 -0700 (PDT)
Received: from [192.168.178.21] (p5b0ea229.dip0.t-ipconnect.de. [91.14.162.41])
 by smtp.gmail.com with ESMTPSA id
 d12-20020a5d4f8c000000b0022cdeba3f83sm69157wru.84.2022.11.03.00.43.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 03 Nov 2022 00:43:02 -0700 (PDT)
Message-ID: <734d0c20-cbf5-5057-1f07-95efafcc217b@gmail.com>
Date: Thu, 3 Nov 2022 08:43:00 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH] drm/amdgpu: fix for suspend/resume sequence under sriov
Content-Language: en-US
To: Victor Zhao <Victor.Zhao@amd.com>, amd-gfx@lists.freedesktop.org,
 Alexander.Deucher@amd.com
References: <20221103040605.796752-1-Victor.Zhao@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
In-Reply-To: <20221103040605.796752-1-Victor.Zhao@amd.com>
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

Am 03.11.22 um 05:06 schrieb Victor Zhao:
> - clear kiq ring after suspend/resume under sriov to aviod kiq ring
> test failure
> - update irq after resume to fix kiq interrput loss

Good to see that somebody takes a look into this. Is that enough to get 
suspend/resume with SRIOV going?

>
> Signed-off-by: Victor Zhao <Victor.Zhao@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 2 ++
>   drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c     | 2 ++
>   2 files changed, 4 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> index 522820eeaa59..5b9f992e4607 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -4197,6 +4197,8 @@ int amdgpu_device_resume(struct drm_device *dev, bool fbcon)
>   	}
>   
>   	/* Make sure IB tests flushed */
> +	if (amdgpu_sriov_vf(adev))
> +		amdgpu_irq_gpu_reset_resume_helper(adev);

This is a pretty clear NAK because that should happen during resume 
anyway. If this doesn't happen we have a bug somewhere else and that 
here just hides it.

>   	flush_delayed_work(&adev->delayed_init_work);
>   
>   	if (adev->in_s0ix) {
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
> index 7853d3ca58cf..49d34c7bbf20 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
> @@ -6909,6 +6909,8 @@ static int gfx_v10_0_kiq_init_queue(struct amdgpu_ring *ring)
>   		mutex_unlock(&adev->srbm_mutex);
>   	} else {
>   		memset((void *)mqd, 0, sizeof(*mqd));
> +		if (amdgpu_sriov_vf(adev) && adev->in_suspend)
> +			amdgpu_ring_clear_ring(ring);

Is there any good reason to not always clear the KIQ ring here? E.g. 
also on bare metal and during load/reset?

Regards,
Christian.

>   		mutex_lock(&adev->srbm_mutex);
>   		nv_grbm_select(adev, ring->me, ring->pipe, ring->queue, 0);
>   		amdgpu_ring_init_mqd(ring);

