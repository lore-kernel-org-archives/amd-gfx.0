Return-Path: <SRS0=UpsA=OS=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D6C1C433EF
	for <amd-gfx@archiver.kernel.org>; Tue, 28 Sep 2021 06:29:19 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F28C361153
	for <amd-gfx@archiver.kernel.org>; Tue, 28 Sep 2021 06:29:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org F28C361153
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0BBBC89F38;
	Tue, 28 Sep 2021 06:29:18 +0000 (UTC)
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com
 [IPv6:2a00:1450:4864:20::42d])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0C63589F38
 for <amd-gfx@lists.freedesktop.org>; Tue, 28 Sep 2021 06:29:16 +0000 (UTC)
Received: by mail-wr1-x42d.google.com with SMTP id v17so12586369wrv.9
 for <amd-gfx@lists.freedesktop.org>; Mon, 27 Sep 2021 23:29:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-transfer-encoding:content-language;
 bh=dMC5sczHaGYzi5J9He9T8K1OGjMRvuSlvMbS4UO00mM=;
 b=WbZre7jzopO50Tvwu4zzE8aqOQoxAMQF5OnT8lQgKrIOuaB0xQCjJKOdm8HvGSH3pI
 egCS70smVNqr1m+/zS7knIeBGUIA48f8apIqtmuxaKzAehfFln4OQY1KhwCUXSxsYp1X
 UF1g2pADUGaSHU8qFvyy30iclWHIDXKs5M8vMu1VgVhsfmv/M7lmTIa92L2RcI6OdrAK
 kjc8G9XDgkCtOZW+ddOXeKADQnP7tsSB7o/fao0YpwMUX5mFn1NPlcYu8dLo9lkUmKY1
 42VYdQOcU9Wfs7XXqgF58RfKElohKoXOUMhMU5waFz/pbyW1jmWgwbGkhqvsgzAfrT8U
 OKhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=dMC5sczHaGYzi5J9He9T8K1OGjMRvuSlvMbS4UO00mM=;
 b=E/TVK3V88KhkXjGbt10bdNQIErsT0eQSDw3rXVQZ8kVA4P27ReMfHXp0DaXFLN7jZx
 olBQ7DU+M3Lh19hYkWL/bnCbLgxHWT2Y4LEBCvzKfxksld5yq2yPQsbDDBUBFXryagaN
 O/gNnVqF0m9l8W0C9xkDSoMY+vF2bPEey6xQ3ocpDln1jsTsjLROF/AhGloH3XZefmMW
 Zi6JFQuPRuzr4Ljd4/tTAedr4GCg4Y+Z+3jARqQukITtd4b/nMgkYjBFcTRKTfSXuvwb
 bh3MnFpj3JgfAEUIU17z+nlOSOdBPVeMaZXmKmL+u+Yx8QKs07zWRw3brVpaqyTgg4SD
 CBqg==
X-Gm-Message-State: AOAM530NRzrvuF2FAvCZsOIYnbn/zm9GpNxS8zYTBq/IktkSxJeIu4pB
 qihutqMrbwkgeOby3BJIg8PcghxMyqQ=
X-Google-Smtp-Source: ABdhPJzyjc4OfAzpmCg2mT1Kt7UNMh65vhhCbhYdYSsFsMrfK5tGgXf0ZvLg0nb4YPj5XJoDoNVPxA==
X-Received: by 2002:adf:f08e:: with SMTP id n14mr326511wro.259.1632810555515; 
 Mon, 27 Sep 2021 23:29:15 -0700 (PDT)
Received: from [192.168.178.21] (p5b0ea1b5.dip0.t-ipconnect.de.
 [91.14.161.181])
 by smtp.gmail.com with ESMTPSA id 61sm18683896wrl.94.2021.09.27.23.29.14
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 27 Sep 2021 23:29:15 -0700 (PDT)
Subject: Re: [PATCH] drm/amd/pm: Fix that RPM cannot be obtained for specific
 GPU
To: huangyizhi <huangyizhi@hnu.edu.cn>, evan.quan@amd.com,
 alexander.deucher@amd.com, christian.koenig@amd.com, Xinhui.Pan@amd.com,
 airlied@linux.ie, daniel@ffwll.ch, lee.jones@linaro.org, lijo.lazar@amd.com
Cc: amd-gfx@lists.freedesktop.org
References: <20210928004941.6978-1-huangyizhi@hnu.edu.cn>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
Message-ID: <5e4e8b4e-a8be-300c-8c9c-96a65e0a467f@gmail.com>
Date: Tue, 28 Sep 2021 08:29:13 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20210928004941.6978-1-huangyizhi@hnu.edu.cn>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
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

Am 28.09.21 um 02:49 schrieb huangyizhi:
> The current mechanism for obtaining RPM is to read tach_period from
> the register, and then calculate the RPM together with the frequency.
> But we found that on specific GPUs, such as RX 550 and RX 560D,
> tach_period always reads as 0 and smu7_fan_ctrl_get_fan_speed_rpm
> will returns -EINVAL.
>
> To solve this problem, when reading tach_period as 0, we try
> to estimate the current RPM using the percentage of current pwm, the
> maximum and minimum RPM.

Well that is most likely a bad idea.

When the fan speed is not available faking some value is certainly not 
the right solution, especially when you don't know the topology of the 
DC conversion driven by the PWM.

Christian.

>
> Signed-off-by: huangyizhi <huangyizhi@hnu.edu.cn>
> ---
>   .../drm/amd/pm/powerplay/hwmgr/smu7_thermal.c | 28 ++++++++++++++++---
>   1 file changed, 24 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_thermal.c b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_thermal.c
> index a6c3610db23e..307dd87d6882 100644
> --- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_thermal.c
> +++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_thermal.c
> @@ -81,6 +81,11 @@ int smu7_fan_ctrl_get_fan_speed_rpm(struct pp_hwmgr *hwmgr, uint32_t *speed)
>   {
>   	uint32_t tach_period;
>   	uint32_t crystal_clock_freq;
> +	uint32_t duty100;
> +	uint32_t duty;
> +	uint32_t speed_percent;
> +	uint64_t tmp64;
> +
>   
>   	if (hwmgr->thermal_controller.fanInfo.bNoFan ||
>   	    !hwmgr->thermal_controller.fanInfo.ucTachometerPulsesPerRevolution)
> @@ -89,13 +94,28 @@ int smu7_fan_ctrl_get_fan_speed_rpm(struct pp_hwmgr *hwmgr, uint32_t *speed)
>   	tach_period = PHM_READ_VFPF_INDIRECT_FIELD(hwmgr->device, CGS_IND_REG__SMC,
>   			CG_TACH_STATUS, TACH_PERIOD);
>   
> -	if (tach_period == 0)
> -		return -EINVAL;
> +	if (tach_period == 0) {
>   
> -	crystal_clock_freq = amdgpu_asic_get_xclk((struct amdgpu_device *)hwmgr->adev);
> +		duty100 = PHM_READ_VFPF_INDIRECT_FIELD(hwmgr->device, CGS_IND_REG__SMC,
> +				CG_FDO_CTRL1, FMAX_DUTY100);
> +		duty = PHM_READ_VFPF_INDIRECT_FIELD(hwmgr->device, CGS_IND_REG__SMC,
> +				CG_THERMAL_STATUS, FDO_PWM_DUTY);
>   
> -	*speed = 60 * crystal_clock_freq * 10000 / tach_period;
> +		if (duty100 == 0)
> +			return -EINVAL;
>   
> +		tmp64 = (uint64_t)duty * 100;
> +		do_div(tmp64, duty100);
> +		speed_percent = MIN((uint32_t)tmp64, 100);
> +
> +		*speed = speed_percent * (hwmgr->thermal_controller.fanInfo.ulMaxRPM
> +			- hwmgr->thermal_controller.fanInfo.ulMinRPM) / 100;
> +	} else {
> +
> +		crystal_clock_freq = amdgpu_asic_get_xclk((struct amdgpu_device *)hwmgr->adev);
> +
> +		*speed = 60 * crystal_clock_freq * 10000 / tach_period;
> +	}
>   	return 0;
>   }
>   

