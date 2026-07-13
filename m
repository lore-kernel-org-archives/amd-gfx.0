Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04DCBC44501
	for <amd-gfx@archiver.kernel.org>; Mon, 13 Jul 2026 10:25:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7744A10E8DF;
	Mon, 13 Jul 2026 10:25:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=ursulin.net header.i=@ursulin.net header.b="I31FBGVp";
	dkim-atps=neutral
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com
 [209.85.128.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 083B510E8DF
 for <amd-gfx@lists.freedesktop.org>; Mon, 13 Jul 2026 10:25:41 +0000 (UTC)
Received: by mail-wm1-f41.google.com with SMTP id
 5b1f17b1804b1-493f6de72faso11559625e9.0
 for <amd-gfx@lists.freedesktop.org>; Mon, 13 Jul 2026 03:25:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ursulin.net; s=google; t=1783938339; x=1784543139; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=0sQQuSBKTvVsJA2hik2ZbcAs38+Yx5y4Z7bUSWS+Io8=;
 b=I31FBGVpjqeWwyxE2Ec9Qm4h6qnukHGVV2Dkh+cwKAV8sjt2i9ob9SpKpO5UXt54/c
 tmOr/DToQh8gf3JxAEtKGJyNawIpoDc8RHesXR3UlX9KLoYNr0JbzX7rxHqrsyLlUXeu
 4bCt+MWbkFheV4ixAc5PN87fAG4n/gPcBfDSXsfFCE0jsv7wvsNAotZynzJBrT6EV62B
 bjSI3qcVhfwHJvi3I6EIztlcYy0B4HPjp8KjXAAQPlDO/D0yMlhPSZTPapT+RLsJDil0
 Z681wbUpXpAaoFK5F9aK0Z/Ed5fG5IqQUcfYgRmrOejxpRhEkth0cf8FfXP9xyVvw2pt
 Pt6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783938339; x=1784543139;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=0sQQuSBKTvVsJA2hik2ZbcAs38+Yx5y4Z7bUSWS+Io8=;
 b=Ib1riXVlc5X/ZW6oKLGPqACnbQwcEZhJkqXWlc81W8F3Imdr3sTah0q4oi/FHdgR2r
 TxcgR70jjdVX95bbFGnAI4WwhD8TDjrBiQCVUXv5eBBcXx/mkfh+dCfUP1UMW8NeqJhp
 gPaWRU5Xx1G9ehidLVYkfzBAY8rWM6joyx+U9B3Ilgl2m+fubNXVKXp5ZhW/Y7BN7tyS
 Uoh7eSA37wSNFcJrBCjIbvM7Mnf4lCfhLG0heqsODj1zYB7NXG+o3CuhGZZHn4f0pKUQ
 rQWgX+lwVrXGVj1F31fo3dh7cJpiEs6itBC+9dvEjKPlxYC65mGalIYvhQerNAc36E1q
 RsIw==
X-Forwarded-Encrypted: i=1;
 AHgh+Rr+4WrWk4yO4qUCHn86MrLptWIYrRmHazixRJ8BMHE7ycZ0hdRPay6xKmnAP0gNN091HEWr3WH0@lists.freedesktop.org
X-Gm-Message-State: AOJu0YytM6/lxs25eXpSSomIXurzJWK3Axp7dBuoY40zF4cW9fgGrL62
 VvJAA7Dko3MUzcPyRBJDFheCLW8XRjqDUVgUWEtSsyy3zyxMwR41TTUvwMCLKX9N8Vk=
X-Gm-Gg: AfdE7clQilwjSn+gFLdZsm+BktblbWtd1Y+wz60T7+5lhStVe/yYYJf9cpogDnsNmA+
 f2qeFUjopxF6vJAJiSHjIxVv+PnKRTTuZfDK99gzecpcxz0cy23P4UscA3HdiJYFoFF9gEIlpq0
 NCYPqwchniXvxG5+ptU/CAR4Um105BxPxzsTCVSnhwJQLLStHMIOSozpQZ1Lknl3+pmnwKkZ+RG
 3fMCQobMpKFnc3hSDwtBi+Lw5GEy5rNfFtQMfhwQnPpaIsFCbLGLnG4gxj4JIYqYx8s4DIq+MuY
 IaJ/dfJisr2cuoB+cykLr9SM2vYT00I2Q1QnCxzM6jukHs+ZweD8IARThbh/4ID1q/pegx0DT5X
 aZcpVgq2OD9sBYkP/iA0ianZ5pXmEzlJBDT7roTbgI6pVoLBHKfzry9JdmaAjlWj9kxk1rhOBgi
 ZV/2dC4YNJVkAsXlQl/40rh/IuNdweh97fiA==
X-Received: by 2002:a05:600c:1391:b0:493:d117:18a8 with SMTP id
 5b1f17b1804b1-493f88bd849mr94219955e9.9.1783938339108; 
 Mon, 13 Jul 2026 03:25:39 -0700 (PDT)
Received: from [192.168.0.116] ([90.240.106.137])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-493eb6ff6casm421958445e9.5.2026.07.13.03.25.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 13 Jul 2026 03:25:38 -0700 (PDT)
Message-ID: <e00d5e54-0713-47e9-9f88-a177a1ffa474@ursulin.net>
Date: Mon, 13 Jul 2026 11:25:38 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] drm/amd/pm/si: Don't schedule thermal work when queue
 isn't initialized
To: =?UTF-8?Q?Timur_Krist=C3=B3f?= <timur.kristof@gmail.com>,
 amd-gfx@lists.freedesktop.org, Alexander.Deucher@amd.com,
 Natalie Vock <natalie.vock@gmx.de>,
 Mario Limonciello <mario.limonciello@amd.com>
References: <20260712173928.259701-1-timur.kristof@gmail.com>
Content-Language: en-GB
From: Tvrtko Ursulin <tursulin@ursulin.net>
In-Reply-To: <20260712173928.259701-1-timur.kristof@gmail.com>
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>


On 12/07/2026 18:39, Timur Kristóf wrote:
> When DPM is turned off with the amdgpu.dpm=0 module parameter,
> the thermal work queue isn't initialized so we shouldn't
> schedule any work on it.
> 
> Signed-off-by: Timur Kristóf <timur.kristof@gmail.com>
> ---
>   drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c b/drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c
> index 832953941266..6a54566d1a68 100644
> --- a/drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c
> +++ b/drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c
> @@ -7692,7 +7692,7 @@ static int si_dpm_process_interrupt(struct amdgpu_device *adev,
>   		break;
>   	}
>   
> -	if (queue_thermal)
> +	if (queue_thermal && amdgpu_dpm)
>   		schedule_work(&adev->pm.dpm.thermal.work);
>   
>   	return 0;

I don't know this code but what is suspicious to me is that there appear 
to be other unguarded entry points to the un-initialized work. Like all 
the flush_work() calls and one cancel_work_sync() as well.

Presumably as long as si_dpm_sw_init() is returning success when 
amdgpu_dpm == 0 those two can get called?

Finding the right Fixes: target might be a good thing too.

Regards,

Tvrtko

