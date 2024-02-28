Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F8F9C54E41
	for <amd-gfx@archiver.kernel.org>; Wed, 28 Feb 2024 06:38:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8990C10E4EC;
	Wed, 28 Feb 2024 06:38:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="PpA0cp6z";
	dkim-atps=neutral
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com
 [209.85.221.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1C13210E4D4
 for <amd-gfx@lists.freedesktop.org>; Wed, 28 Feb 2024 06:38:14 +0000 (UTC)
Received: by mail-wr1-f44.google.com with SMTP id
 ffacd0b85a97d-33d754746c3so3350862f8f.1
 for <amd-gfx@lists.freedesktop.org>; Tue, 27 Feb 2024 22:38:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1709102292; x=1709707092; darn=lists.freedesktop.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=RSRQAbB39OxdxY7FjRfP29Ag7rT3eb1LK03j5FBcsS8=;
 b=PpA0cp6zsuYNNLnPlqeZbMZvZeVJzAxjYuaQ7ttxT0qK9GiTCqKYOx2Ha8Nc+oJSoj
 w+ejYBTtnopHAp3MHl8meS2mAFiFrDPRPXnJ39WQm02SXJnGD0EJhcWylt0jsEJy0XMT
 isAb69yDX1DMIcfu9zR4QyWcTGiEsJb+xGzMj9qGsbrnfpv/U6FHr7n9LHOEbAN/U4q6
 scprUeG+IqFcHlWu41rcmLjsXyd/kOqgOoM29OE91LLvKrj+Gn8jI1yt57Kr/a2/pNRh
 ck/zTK2mPP6Cvpx0IczhxvxIWsFQDZ6+iNWcwMgbt5vxvFJsIq+AVAF4chvZli/klYm1
 uyTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709102292; x=1709707092;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=RSRQAbB39OxdxY7FjRfP29Ag7rT3eb1LK03j5FBcsS8=;
 b=EYYorklib/c1vNJqaGrKSd79YseVf8NYY6IJOJuNaPlE+56aGW3WYz6WkM3yvwbdUx
 h6CYlRq5ttP7zyVjDnegHqkmEBPVKsBAQqRN0yXE8ieokfoIGQLkzeG19/DcmCgjmXPP
 d7bznMslj9PIRkwLanPGeuOTBAw7RkxmTv+Dkun7w9Hy984PZ2gQS+fQ1gs4eEMAjqdT
 c7HfibIhN65zoVjQ3XiCKk7tg4McSuRik3ZhBPEn1k+a9oE15RvW0Hw9ENB0lmHW39pX
 LXmx9qtZs5KMTjBurpRsco1vNycnnIOt1Fr5NnzDrZ+WwROnTrlb2Gm2/9jp5ZBwsd94
 ha2Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCXnocS6JennfCjdze/9xPJfGEnzQQg4QqLinM1Ki6G9Haw+S5s/VOtQ067clXNG20jGMgvP/TvtQFL0gJXzW6XqbBO9GLv8kShRX9QgkA==
X-Gm-Message-State: AOJu0YwLFO6tIQ5ZtcA3bLVrf10DajEGLMj14LSMqyQ+YYb2hQ/xN8yS
 1mkVfS2kl1VzF6ABvAxbdNH9khZQBsD+HfqISDy+Y5OCRPLneG+d
X-Google-Smtp-Source: AGHT+IEkstqy+8lejVxQt/MqlsCJWq0MPas1HRMaMBV9i4vVZnSXalfDn7vgpM164iphJSGAaU4WTQ==
X-Received: by 2002:a5d:5312:0:b0:33d:4966:fa8f with SMTP id
 e18-20020a5d5312000000b0033d4966fa8fmr8311438wrv.46.1709102291636; 
 Tue, 27 Feb 2024 22:38:11 -0800 (PST)
Received: from [10.254.108.81] (munvpn.amd.com. [165.204.72.6])
 by smtp.gmail.com with ESMTPSA id
 j17-20020a5d6191000000b0033d4cf751b2sm13476416wru.33.2024.02.27.22.38.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 27 Feb 2024 22:38:11 -0800 (PST)
Message-ID: <7e13e8d8-e486-4739-9844-f0b95861d34c@gmail.com>
Date: Wed, 28 Feb 2024 07:38:07 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] Revert "drm/amd: Remove freesync video mode amdgpu
 parameter"
Content-Language: en-US
To: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
References: <20240227184847.3078099-1-alexander.deucher@amd.com>
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>
In-Reply-To: <20240227184847.3078099-1-alexander.deucher@amd.com>
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

Am 27.02.24 um 19:48 schrieb Alex Deucher:
> This reverts commit e94e787e37b99645e7c02d20d0a1ba0f8a18a82a.
>
> This conflicts with how compositors want to handle VRR.  Now
> that compositors actually handle VRR, we probably don't need
> freesync video.
>
> Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/2985

Scratching my head what actually happens here? Doesn't the problem then 
just depend on a module parameter?

Regards,
Christian.

> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu.h     |  1 +
>   drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c | 27 +++++++++++++++++++++++++
>   2 files changed, 28 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> index 0e365cadcc3fc..925026c183f41 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> @@ -194,6 +194,7 @@ extern int amdgpu_emu_mode;
>   extern uint amdgpu_smu_memory_pool_size;
>   extern int amdgpu_smu_pptable_id;
>   extern uint amdgpu_dc_feature_mask;
> +extern uint amdgpu_freesync_vid_mode;
>   extern uint amdgpu_dc_debug_mask;
>   extern uint amdgpu_dc_visual_confirm;
>   extern int amdgpu_dm_abm_level;
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> index 15a8a64fc4e28..82b154b103f43 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> @@ -199,6 +199,7 @@ int amdgpu_mes_kiq;
>   int amdgpu_noretry = -1;
>   int amdgpu_force_asic_type = -1;
>   int amdgpu_tmz = -1; /* auto */
> +uint amdgpu_freesync_vid_mode;
>   int amdgpu_reset_method = -1; /* auto */
>   int amdgpu_num_kcq = -1;
>   int amdgpu_smartshift_bias;
> @@ -883,6 +884,32 @@ module_param_named(damageclips, amdgpu_damage_clips, int, 0444);
>   MODULE_PARM_DESC(tmz, "Enable TMZ feature (-1 = auto (default), 0 = off, 1 = on)");
>   module_param_named(tmz, amdgpu_tmz, int, 0444);
>   
> +/**
> + * DOC: freesync_video (uint)
> + * Enable the optimization to adjust front porch timing to achieve seamless
> + * mode change experience when setting a freesync supported mode for which full
> + * modeset is not needed.
> + *
> + * The Display Core will add a set of modes derived from the base FreeSync
> + * video mode into the corresponding connector's mode list based on commonly
> + * used refresh rates and VRR range of the connected display, when users enable
> + * this feature. From the userspace perspective, they can see a seamless mode
> + * change experience when the change between different refresh rates under the
> + * same resolution. Additionally, userspace applications such as Video playback
> + * can read this modeset list and change the refresh rate based on the video
> + * frame rate. Finally, the userspace can also derive an appropriate mode for a
> + * particular refresh rate based on the FreeSync Mode and add it to the
> + * connector's mode list.
> + *
> + * Note: This is an experimental feature.
> + *
> + * The default value: 0 (off).
> + */
> +MODULE_PARM_DESC(
> +	freesync_video,
> +	"Enable freesync modesetting optimization feature (0 = off (default), 1 = on)");
> +module_param_named(freesync_video, amdgpu_freesync_vid_mode, uint, 0444);
> +
>   /**
>    * DOC: reset_method (int)
>    * GPU reset method (-1 = auto (default), 0 = legacy, 1 = mode0, 2 = mode1, 3 = mode2, 4 = baco)

