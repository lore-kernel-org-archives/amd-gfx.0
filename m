Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69319C433EF
	for <amd-gfx@archiver.kernel.org>; Thu, 10 Mar 2022 10:00:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1AA0E10E707;
	Thu, 10 Mar 2022 10:00:53 +0000 (UTC)
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com
 [IPv6:2a00:1450:4864:20::634])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9FB2910E707
 for <amd-gfx@lists.freedesktop.org>; Thu, 10 Mar 2022 10:00:51 +0000 (UTC)
Received: by mail-ej1-x634.google.com with SMTP id gb39so10869492ejc.1
 for <amd-gfx@lists.freedesktop.org>; Thu, 10 Mar 2022 02:00:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=message-id:date:mime-version:user-agent:subject:content-language:to
 :cc:references:from:in-reply-to:content-transfer-encoding;
 bh=a6hrbsaGPq8Q7Wt/5S7ewtyUJ9tYF1J4Cu8iOuyeoZw=;
 b=CiysF48iBbfa/rPEW76suapfWfdqBt4W7Z0dlKElG3AOuOGni8jybm0d3utJomDaVR
 2LgjbWt8rXTs++hrMBznR4cWpDVNV09L8NRBIZvIxPL9mMvxA2kaVEpC3/7PvjBI7CqY
 SOri9NEw3Tp7ldw++O5OrXAXWGf0jHXXQF1uIz8VRpttn0B+Ecn10GGHmvPcSBYQA63v
 Ugry+UnT7TrVrssGCSW+txMrfiMC5QarzE2G8+K4GROU5MOmrHviH6J4cOW0Gewgoahe
 sDcPZd5QgVS7XiI++OwpZ+rOL/UNNGmApQhfSH+BOuaO23Ee9tlLDjqQMB0PIYQi4WLk
 RrlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:cc:references:from:in-reply-to
 :content-transfer-encoding;
 bh=a6hrbsaGPq8Q7Wt/5S7ewtyUJ9tYF1J4Cu8iOuyeoZw=;
 b=DM9JwIXp/6QohHCslaulU04bi+bjdOT4kxgqWDW7//RSJ4gOFGO0FXohdSJFbHHhph
 lp2VINzeuu1ed8W1tLCRhVaH5IGoaueNs0A73nqTiAegPN/hnNdm9jiSRSV2hQu5xICi
 5+JBaaAwUDaZTDCG2wj5ghfQbDUVsFqprJA2HvFhw+Lf28+hhyabzsZNW4oVvU+bBlJ/
 9y8JLZpH8DTf1fy1c7E3yX7FFk36GXIBczu6sy2ckLS9TQtMAMi+sYvgJqBMZzWGgyUo
 vMMjqXnWrgbUUEYpeM7Xmov0i02n9buKnmHX+awfx42ODA36NtF3WS3bX8S5lZzsnwLo
 xmIg==
X-Gm-Message-State: AOAM533VIdLPulRf+Jjr4C7dNr2zLwpCHWyH8t7TcvdTjR8T+q2G2KxN
 V0yU1GnwCptZEd/2H8ybEGPf6vIg04A=
X-Google-Smtp-Source: ABdhPJwKBbHEwiWQTgW7KBgz7FErl4F6NJT1TDUftn1jMiKuZeNfwooK/Y81uZfp++ErkieO7Uv0nQ==
X-Received: by 2002:a17:907:9706:b0:6db:566a:4408 with SMTP id
 jg6-20020a170907970600b006db566a4408mr3462459ejc.374.1646906449905; 
 Thu, 10 Mar 2022 02:00:49 -0800 (PST)
Received: from ?IPV6:2a02:908:1252:fb60:87b1:f8fa:c08e:8bd0?
 ([2a02:908:1252:fb60:87b1:f8fa:c08e:8bd0])
 by smtp.gmail.com with ESMTPSA id
 w19-20020a17090633d300b006ce3d425b22sm1632187eja.1.2022.03.10.02.00.49
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 10 Mar 2022 02:00:49 -0800 (PST)
Message-ID: <12dac5ec-45e3-0a2b-471c-f5f19ba9c057@gmail.com>
Date: Thu, 10 Mar 2022 11:00:47 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH 1/4] drm/amdgpu: add param soft_reset_enable
Content-Language: en-US
To: Victor Zhao <Victor.Zhao@amd.com>, amd-gfx@lists.freedesktop.org
References: <20220310061155.39292-1-Victor.Zhao@amd.com>
 <20220310061155.39292-2-Victor.Zhao@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
In-Reply-To: <20220310061155.39292-2-Victor.Zhao@amd.com>
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
Cc: emily.deng@amd.com, "Liu, Monk" <Monk.Liu@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Am 10.03.22 um 07:11 schrieb Victor Zhao:
> add parameter soft_reset_enable to control the enablement of
> soft reset

NAK, proper working soft recovery is something mandatory and shouldn't 
be controlled by the end user.

Marek and I have also decided to completely disable job re-submission on 
bare metal in the near future.

Regards,
Christian.

>
> Signed-off-by: Victor Zhao <Victor.Zhao@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu.h     | 1 +
>   drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c | 9 +++++++++
>   drivers/gpu/drm/amd/amdgpu/nv.c         | 5 ++++-
>   3 files changed, 14 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> index 1f3c4521d348..22b846c359b4 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> @@ -238,6 +238,7 @@ extern int amdgpu_si_support;
>   extern int amdgpu_cik_support;
>   #endif
>   extern int amdgpu_num_kcq;
> +extern int amdgpu_soft_reset_enable;
>   
>   #define AMDGPU_VM_MAX_NUM_CTX			4096
>   #define AMDGPU_SG_THRESHOLD			(256*1024*1024)
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> index b3fc5ae5fe6e..09daff7727b1 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> @@ -201,6 +201,7 @@ struct amdgpu_watchdog_timer amdgpu_watchdog_timer = {
>   	.timeout_fatal_disable = false,
>   	.period = 0x0, /* default to 0x0 (timeout disable) */
>   };
> +int amdgpu_soft_reset_enable = -1;
>   
>   /**
>    * DOC: vramlimit (int)
> @@ -931,6 +932,14 @@ MODULE_PARM_DESC(smu_pptable_id,
>   	"specify pptable id to be used (-1 = auto(default) value, 0 = use pptable from vbios, > 0 = soft pptable id)");
>   module_param_named(smu_pptable_id, amdgpu_smu_pptable_id, int, 0444);
>   
> +/**
> + * DOC: soft_reset (int)
> + * Used to enable grbm soft reset
> + */
> +MODULE_PARM_DESC(soft_reset_enable,
> +	"enable soft reset (-1 = auto(default) value, 0 = disable, > 0 = enable)");
> +module_param_named(soft_reset_enable, amdgpu_soft_reset_enable, int, 0444);
> +
>   /* These devices are not supported by amdgpu.
>    * They are supported by the mach64, r128, radeon drivers
>    */
> diff --git a/drivers/gpu/drm/amd/amdgpu/nv.c b/drivers/gpu/drm/amd/amdgpu/nv.c
> index 59eafa31c626..fe9b9d896dc1 100644
> --- a/drivers/gpu/drm/amd/amdgpu/nv.c
> +++ b/drivers/gpu/drm/amd/amdgpu/nv.c
> @@ -620,7 +620,10 @@ static uint32_t nv_get_rev_id(struct amdgpu_device *adev)
>   
>   static bool nv_need_full_reset(struct amdgpu_device *adev)
>   {
> -	return true;
> +	if (amdgpu_soft_reset_enable <= 0)
> +		return true;
> +	else
> +		return false;
>   }
>   
>   static bool nv_need_reset_on_init(struct amdgpu_device *adev)

