Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A39CC76196
	for <amd-gfx@archiver.kernel.org>; Thu,  6 Apr 2023 10:06:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6ECE010EB4B;
	Thu,  6 Apr 2023 10:06:37 +0000 (UTC)
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com
 [IPv6:2a00:1450:4864:20::436])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5B02D10EB4B
 for <amd-gfx@lists.freedesktop.org>; Thu,  6 Apr 2023 10:06:36 +0000 (UTC)
Received: by mail-wr1-x436.google.com with SMTP id l12so38923545wrm.10
 for <amd-gfx@lists.freedesktop.org>; Thu, 06 Apr 2023 03:06:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20210112; t=1680775594; x=1683367594;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=nyO9HvxlIGTX5rt3vSSDM5k5j1CZpY8TFYR++BvoFLE=;
 b=C5dRhV4Oz7vqgLpR23ER02ZvkeEtkE9JAliMkWGlqTr+ZNWRGw6qnqrl1X+7V3yOUr
 zieXRXrys3tS/3+PrITwRHuJlV0o3jEr1xD6U94xnsZIUbks7RO1LLJEpDPGjia2sXop
 u1xRYUsmIsQ7KWv2q7/mowSNlByg21gVcnPX+WGjz+UFveSWZX1NOuygn0nbxNElkM2m
 xxXXtaf7SBWcdoUX9JGfVKurihLotHNJ4yJmsyCMAyXo8+7ulKJ3BvMW+0AHZZUebWTf
 7fy7tQBiTS1Us/k6p5pFmAHlX9/Q3cD1tVG3YOrzHZMsqVuzCKaPOZeQsq3+MKoZsogP
 Uf3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112; t=1680775594; x=1683367594;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=nyO9HvxlIGTX5rt3vSSDM5k5j1CZpY8TFYR++BvoFLE=;
 b=tagP0BBdSVD8vyUvtXJMSbc0o5wVfTG4QHjl9arEXAJ15sEnbVRlwEpYpCiDOJb3PH
 Mggh3/tZzZ0GsSd+9TgVuY1naVHpcPxBrmJifHsgGU7GatAWxi0ZD7NhdKmfcA5oKghr
 s6zfEyVwElGL+/sT5vqdm7U0w9LDHq6F1KCjO7A21w2ff1QMArR8mNkSijVVWzdYBDuN
 +kcdSYCCl0dAJUWCp3jq5FOA1S2zMWqGohocbav3k/0ghsnC+E+QFxyjpiiYSwSyJ7+k
 Zhwk2Q+qm7S+vG3IpBdyeH2v6BtoZRZ0m2cDv0OR2wxFzrt8GG4F++kTO6cBJmwAx/ZG
 Yhdg==
X-Gm-Message-State: AAQBX9c/J4p2A06AOmi9Dhzmf6QXanu8RTdhxypmKm74k9Za1szEEUkW
 XiTUEhzlfPSxSL0DpNr1CLQ=
X-Google-Smtp-Source: AKy350bK9Y042FvmmqHQHXBIGU5xEecND5S9rIPWRRGxqJZIcEUQ1Gs7JTa+wbMQOtgdyUSMbA8PsA==
X-Received: by 2002:adf:f0c4:0:b0:2ce:aa2f:55ff with SMTP id
 x4-20020adff0c4000000b002ceaa2f55ffmr5892206wro.1.1680775594323; 
 Thu, 06 Apr 2023 03:06:34 -0700 (PDT)
Received: from [192.168.178.21] (p4fc2092b.dip0.t-ipconnect.de. [79.194.9.43])
 by smtp.gmail.com with ESMTPSA id
 z16-20020a5d4c90000000b002cf1c435afcsm1350238wrs.11.2023.04.06.03.06.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 06 Apr 2023 03:06:33 -0700 (PDT)
Message-ID: <5f78c379-c7cc-1b1b-d273-175f8e57e1c5@gmail.com>
Date: Thu, 6 Apr 2023 12:06:32 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH v3] drm/amd/amdgpu: Drop the hang limit parameter
Content-Language: en-US
To: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>,
 =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 Mario Limonciello <mario.limonciello@amd.com>,
 Kent Russell <kent.russell@amd.com>
References: <20230405152352.457978-1-srinivasan.shanmugam@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
In-Reply-To: <20230405152352.457978-1-srinivasan.shanmugam@amd.com>
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
Cc: amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Am 05.04.23 um 17:23 schrieb Srinivasan Shanmugam:
> The driver doesn't resubmit jobs on hangs any more, hence drop
> the hang limit parameter - amdgpu_job_hang_limit, wherever it is used.
>
> Suggested-by: Christian König <christian.koenig@amd.com>
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Cc: Mario Limonciello <mario.limonciello@amd.com>
> Cc: Kent Russell <kent.russell@amd.com>
> Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>

Reviewed-by: Christian König <christian.koenig@amd.com>

> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu.h        | 1 -
>   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 2 +-
>   drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c    | 8 --------
>   3 files changed, 1 insertion(+), 10 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> index bbac4239ceb3..35a0474ccdb0 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> @@ -186,7 +186,6 @@ extern char *amdgpu_disable_cu;
>   extern char *amdgpu_virtual_display;
>   extern uint amdgpu_pp_feature_mask;
>   extern uint amdgpu_force_long_training;
> -extern int amdgpu_job_hang_limit;
>   extern int amdgpu_lbpw;
>   extern int amdgpu_compute_multipipe;
>   extern int amdgpu_gpu_recovery;
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> index 3b6b85d9e0be..051b9e231cf4 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -2364,7 +2364,7 @@ static int amdgpu_device_init_schedulers(struct amdgpu_device *adev)
>   		}
>   
>   		r = drm_sched_init(&ring->sched, &amdgpu_sched_ops,
> -				   ring->num_hw_submission, amdgpu_job_hang_limit,
> +				   ring->num_hw_submission, 0,
>   				   timeout, adev->reset_domain->wq,
>   				   ring->sched_score, ring->name,
>   				   adev->dev);
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> index e652ffb2c68e..03e928123d71 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> @@ -158,7 +158,6 @@ char *amdgpu_virtual_display;
>    */
>   uint amdgpu_pp_feature_mask = 0xfff7bfff;
>   uint amdgpu_force_long_training;
> -int amdgpu_job_hang_limit;
>   int amdgpu_lbpw = -1;
>   int amdgpu_compute_multipipe = -1;
>   int amdgpu_gpu_recovery = -1; /* auto */
> @@ -521,13 +520,6 @@ MODULE_PARM_DESC(virtual_display,
>   		 "Enable virtual display feature (the virtual_display will be set like xxxx:xx:xx.x,x;xxxx:xx:xx.x,x)");
>   module_param_named(virtual_display, amdgpu_virtual_display, charp, 0444);
>   
> -/**
> - * DOC: job_hang_limit (int)
> - * Set how much time allow a job hang and not drop it. The default is 0.
> - */
> -MODULE_PARM_DESC(job_hang_limit, "how much time allow a job hang and not drop it (default 0)");
> -module_param_named(job_hang_limit, amdgpu_job_hang_limit, int ,0444);
> -
>   /**
>    * DOC: lbpw (int)
>    * Override Load Balancing Per Watt (LBPW) support (1 = enable, 0 = disable). The default is -1 (auto, enabled).

