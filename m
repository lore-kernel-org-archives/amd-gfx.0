Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A14D1C76195
	for <amd-gfx@archiver.kernel.org>; Tue, 28 Mar 2023 11:16:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0A5AD10E874;
	Tue, 28 Mar 2023 11:16:14 +0000 (UTC)
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com
 [IPv6:2a00:1450:4864:20::532])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E548C10E875
 for <amd-gfx@lists.freedesktop.org>; Tue, 28 Mar 2023 11:16:11 +0000 (UTC)
Received: by mail-ed1-x532.google.com with SMTP id i5so48303412eda.0
 for <amd-gfx@lists.freedesktop.org>; Tue, 28 Mar 2023 04:16:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20210112; t=1680002170;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=wUNHyVuK8skTqeibViyp8tl/pEsUJuSBbY1+wpi9RcQ=;
 b=Z8XJMoJ8pjr7CFRX7qn2vJniMiOXPPd6RNcJaKWBFUBxKssIMvN2SC7tFv7qJ6RwaR
 jOy2lPwHu/XioEN6Ve1tzmDDy8U98GlqcxcFi+aODiufS7PoDLnohqc0GTj2F026KFv3
 vnNuz9ueea354PXvhJrlinS7f3zgOkn9nG/6CMPgRUnY4XmQVWJTniT1mYb7zoXsyWpY
 lje7fiE1AduOe3LbEzkpnFPG1mk2VKrqdQ5y9fL4ZezJMj9gIThuTeW3h/RySbmEOcBH
 URcXPlDFNUtzzk7XzULRIB04KPYQLeGzPDW5fWX9Bkswv5/wZMdwtKdFJSolYmWJSdgy
 /jdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112; t=1680002170;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=wUNHyVuK8skTqeibViyp8tl/pEsUJuSBbY1+wpi9RcQ=;
 b=wYIll6jm2b1ne01s+BR9hr0lpjzbHtsfkFzsJ7ZL6xBujuNgjL5G6BF4FDQfBeWH9r
 vfwUEAt1juwAll1VqHUVa24bIs8oVFrdA3wKIv+S41eFtomQvn5B9tArWHF4+Y6c35Nx
 v0WNrB5qjGUbfDfBYerK076lVQzOSMPJYqoj3Sqbj+SPJiHDR3fgyNM6Qq12hpiIEqfp
 5ObhRt3XettzO5nX4AeSlv4qCQmnkSmkkNFOjDBwiHIL2U73PDu7vvF9y56McE+5pSaz
 pmhGDKF01N80KOD3x96/fZHg9ZpnF3555sTFC7LgTxdFbWjalkk/X2xX4pYzwtn4O+X6
 Lryw==
X-Gm-Message-State: AAQBX9eQTW6yubyFj+eXcMrWRNgGPNXBtTqC0wRUWwUfqnjm9h4tEKLR
 vWjo0xZRsC9PBBgQM4d2v1+LjWYgalI=
X-Google-Smtp-Source: AKy350bJiuZSEM4tSXJvi48jkUB5y9xk6BydqZil6pxd2e/5txHgSJokSXJaEBJXj64spQuq0EPJPA==
X-Received: by 2002:a17:907:d68f:b0:8c3:3439:24d9 with SMTP id
 wf15-20020a170907d68f00b008c3343924d9mr16469142ejc.24.1680002170324; 
 Tue, 28 Mar 2023 04:16:10 -0700 (PDT)
Received: from [192.168.178.21] (p4fc2092b.dip0.t-ipconnect.de. [79.194.9.43])
 by smtp.gmail.com with ESMTPSA id
 cd11-20020a170906b34b00b0093009bc5825sm15200022ejb.2.2023.03.28.04.16.09
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 28 Mar 2023 04:16:09 -0700 (PDT)
Message-ID: <76206089-39dd-c009-f0a3-415f3c02406a@gmail.com>
Date: Tue, 28 Mar 2023 13:16:08 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH] drm/amdgpu: Fix desktop freezed after gpu-reset
Content-Language: en-US
To: Alan Liu <HaoPing.Liu@amd.com>, amd-gfx@lists.freedesktop.org
References: <20230327152028.2939908-1-HaoPing.Liu@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
In-Reply-To: <20230327152028.2939908-1-HaoPing.Liu@amd.com>
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
Cc: bhawanpreet.lakha@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Am 27.03.23 um 17:20 schrieb Alan Liu:
> [Why]
> After gpu-reset, sometimes the driver would fail to enable vblank irq,
> causing flip_done timed out and the desktop freezed.
>
> During gpu-reset, we will disable and enable vblank irq in dm_suspend()
> and dm_resume(). Later on in amdgpu_irq_gpu_reset_resume_helper(), we
> will check irqs' refcount and decide to enable or disable the irqs again.
>
> However, we have 2 sets of API for controling vblank irq, one is
> dm_vblank_get/put() and another is amdgpu_irq_get/put(). Each API has
> its own refcount and flag to store the state of vblank irq, and they
> are not synchronized.

This is the source of the problem and you should address this instead. 
The change you suggested below would break in some use cases.

>
> In drm we use the first API to control vblank irq but in
> amdgpu_irq_gpu_reset_resume_helper() we use the second set of API.
>
> The failure happens when vblank irq was enabled by dm_vblank_get() before
> gpu-reset, we have vblank->enabled true. However, during gpu-reset, in
> amdgpu_irq_gpu_reset_resume_helper(), vblank irq's state checked from
> amdgpu_irq_update() is DISABLED. So finally it will disable vblank irq
> again. After gpu-reset, if there is a cursor plane commit, the driver
> will try to enable vblank irq by calling drm_vblank_enable(), but the
> vblank->enabled is still true, so it fails to turn on vblank irq and
> causes flip_done can't be completed in vblank irq handler and desktop
> become freezed.
>
> [How]
> Combining the 2 vblank control APIs by letting drm's API finally calls
> amdgpu_irq's API, so the irq's refcount and state of both APIs can be
> synchronized. Also add a check to prevent refcount from being less then
> 0 in amdgpu_irq_put().
>
> Signed-off-by: Alan Liu <HaoPing.Liu@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c            |  3 +++
>   .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c | 14 ++++++++++----
>   2 files changed, 13 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c
> index a6aef488a822..1b66003657e2 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c
> @@ -597,6 +597,9 @@ int amdgpu_irq_put(struct amdgpu_device *adev, struct amdgpu_irq_src *src,
>   	if (!src->enabled_types || !src->funcs->set)
>   		return -EINVAL;
>   
> +	if (!amdgpu_irq_enabled(adev, src, type))
> +		return 0;
> +

That is racy and won't work. The intention of amdgpu_irq_update() is to 
always update the irq state, no matter what the status is.

Regards,
Christian.

>   	if (atomic_dec_and_test(&src->enabled_types[type]))
>   		return amdgpu_irq_update(adev, src, type);
>   
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c
> index dc4f37240beb..e04f846b0b19 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c
> @@ -146,7 +146,7 @@ static void vblank_control_worker(struct work_struct *work)
>   
>   static inline int dm_set_vblank(struct drm_crtc *crtc, bool enable)
>   {
> -	enum dc_irq_source irq_source;
> +	int irq_type;
>   	struct amdgpu_crtc *acrtc = to_amdgpu_crtc(crtc);
>   	struct amdgpu_device *adev = drm_to_adev(crtc->dev);
>   	struct dm_crtc_state *acrtc_state = to_dm_crtc_state(crtc->state);
> @@ -169,10 +169,16 @@ static inline int dm_set_vblank(struct drm_crtc *crtc, bool enable)
>   	if (rc)
>   		return rc;
>   
> -	irq_source = IRQ_TYPE_VBLANK + acrtc->otg_inst;
> +	irq_type = amdgpu_display_crtc_idx_to_irq_type(adev, acrtc->crtc_id);
> +
> +	if (enable)
> +		rc = amdgpu_irq_get(adev, &adev->crtc_irq, irq_type);
> +
> +	else
> +		rc = amdgpu_irq_put(adev, &adev->crtc_irq, irq_type);
>   
> -	if (!dc_interrupt_set(adev->dm.dc, irq_source, enable))
> -		return -EBUSY;
> +	if (rc)
> +		return rc;
>   
>   skip:
>   	if (amdgpu_in_reset(adev))

