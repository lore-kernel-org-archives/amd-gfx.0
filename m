Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A2B1C4332F
	for <amd-gfx@archiver.kernel.org>; Fri, 16 Dec 2022 11:50:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5B5D010E13D;
	Fri, 16 Dec 2022 11:50:01 +0000 (UTC)
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com
 [IPv6:2a00:1450:4864:20::32a])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 73CE210E13D
 for <amd-gfx@lists.freedesktop.org>; Fri, 16 Dec 2022 11:49:57 +0000 (UTC)
Received: by mail-wm1-x32a.google.com with SMTP id
 m5-20020a7bca45000000b003d2fbab35c6so1550100wml.4
 for <amd-gfx@lists.freedesktop.org>; Fri, 16 Dec 2022 03:49:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=dTElsYnq1MbOtsDXikugJCq1LpXkXvTqkVuhsZ2L5Ew=;
 b=XlkbkcnDZcrpRZUcmgtBxKtZYE/Ua0goJQoDc/huPc7P5aMdtVNFZFt5C9Xgi3C48/
 wKs36nDgICeU6auliai+06SPKfMznwcyaLQzNxM+2sRjyUvmSYPaiSFZZUJLDgnyZPeM
 HNJ13gxqt8Fj5H2WkRU9kSZmnXfdcIu3nG0PVLfsh5B9lBDebfS4kwVF63c53Uu/TlHX
 6izGZT0PN3gRT+e9gm1Vun2L2bQl3DmIRk8VQcXN2bdvY0K+tLVc2Dig3uUf6Mlr/f5y
 ZUPhjcMa6hhTc87lGFu2RIbNVZ2eWxire5ADmB7Cv+q7xjUQbatoxgsQaxhqp+291oiT
 KjJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=dTElsYnq1MbOtsDXikugJCq1LpXkXvTqkVuhsZ2L5Ew=;
 b=A/sUw5jyoaLnfUITOzuVgkFVKGq4o43djkrBAJLQCq4ldcp7YAhzc+zYed3xCoklGo
 Ca2jYxrPE2aUekVkvCbe8i7L0Ui/jnZ31q4p6Qpd3Z4KvUCWPw6lygGR1d3ZXyMrX6ot
 4pZgkUPdVLi03BQiRHTAfCWk7z3XJywFfTAiiZNGCE17QhrxhSd1xHd3mv+WhPLbd5uQ
 GbaM4etQrSwsnDyl8AX10lz/zP9akDIxSOiy73FVBQ6Ba4uoP3QsfEn2xvqFaekkPeXs
 beumxpfeSIV4efffrq0zqBE7XrxO/p8WQwRzCpcsG7ecY3ry/HN2igjp7JP5rndlGHOt
 2k2Q==
X-Gm-Message-State: ANoB5pnucaQ5Rw4MGRz8v5UjBBSmvyHKp93sLFlmNcT++BCs9r3vKi6i
 oc1avPGHtmnro9SWJgjuGGI=
X-Google-Smtp-Source: AA0mqf6TtcAcm9OuV8YxW6sRSCYCk1vj/hacWa3oQ3BXqOmMMpG2jpSF8BazXu7XfTl9/VOidz+pLw==
X-Received: by 2002:a1c:7316:0:b0:3c6:e60f:3f66 with SMTP id
 d22-20020a1c7316000000b003c6e60f3f66mr25587568wmb.29.1671191395748; 
 Fri, 16 Dec 2022 03:49:55 -0800 (PST)
Received: from ?IPV6:2a02:908:1256:79a0:bb42:7140:8943:ba6?
 ([2a02:908:1256:79a0:bb42:7140:8943:ba6])
 by smtp.gmail.com with ESMTPSA id
 f24-20020a1c6a18000000b003b95ed78275sm2275551wmc.20.2022.12.16.03.49.54
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 16 Dec 2022 03:49:55 -0800 (PST)
Message-ID: <0e3fc42c-d5d4-db99-ab6a-65b4f87ef201@gmail.com>
Date: Fri, 16 Dec 2022 12:49:54 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH] drm/amd/pm: correct the fan speed retrieving in PWM for
 some SMU13 asics
Content-Language: en-US
To: Evan Quan <evan.quan@amd.com>, amd-gfx@lists.freedesktop.org
References: <20221216103550.2063886-1-evan.quan@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
In-Reply-To: <20221216103550.2063886-1-evan.quan@amd.com>
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
Cc: Alexander.Deucher@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Am 16.12.22 um 11:35 schrieb Evan Quan:
> For SMU 13.0.0 and 13.0.7, the output from PMFW is in percent. Driver
> need to convert that into correct PMW(255) based.
>
> Signed-off-by: Evan Quan <evan.quan@amd.com>
> Change-Id: I7bbeae3c0d81c6cf6e0033aa28ca6d26f5b6d178
> ---
>   .../gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c  | 15 ++++++++++++---
>   .../gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c  | 15 ++++++++++++---
>   2 files changed, 24 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
> index 636cb561fea9..283cf7cf95ab 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
> @@ -1445,12 +1445,21 @@ static void smu_v13_0_0_get_unique_id(struct smu_context *smu)
>   static int smu_v13_0_0_get_fan_speed_pwm(struct smu_context *smu,
>   					 uint32_t *speed)
>   {
> +	int ret = 0;

Please don't initialize local variables when there isn't a need for this.

We often get complains about this from automated scripts.

Regards,
Christian.

> +
>   	if (!speed)
>   		return -EINVAL;
>   
> -	return smu_v13_0_0_get_smu_metrics_data(smu,
> -						METRICS_CURR_FANPWM,
> -						speed);
> +	ret = smu_v13_0_0_get_smu_metrics_data(smu,
> +					       METRICS_CURR_FANPWM,
> +					       speed);
> +	if (ret)
> +		return ret;
> +
> +	/* Convert the PMFW output which is in percent to pwm(255) based */
> +	*speed = MIN(*speed * 255 / 100, 255);
> +
> +	return 0;
>   }
>   
>   static int smu_v13_0_0_get_fan_speed_rpm(struct smu_context *smu,
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
> index 5e937e4efb51..f207f102ed7e 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
> @@ -1365,12 +1365,21 @@ static int smu_v13_0_7_populate_umd_state_clk(struct smu_context *smu)
>   static int smu_v13_0_7_get_fan_speed_pwm(struct smu_context *smu,
>   					 uint32_t *speed)
>   {
> +	int ret = 0;
> +
>   	if (!speed)
>   		return -EINVAL;
>   
> -	return smu_v13_0_7_get_smu_metrics_data(smu,
> -						METRICS_CURR_FANPWM,
> -						speed);
> +	ret = smu_v13_0_7_get_smu_metrics_data(smu,
> +					       METRICS_CURR_FANPWM,
> +					       speed);
> +	if (ret)
> +		return ret;
> +
> +	/* Convert the PMFW output which is in percent to pwm(255) based */
> +	*speed = MIN(*speed * 255 / 100, 255);
> +
> +	return 0;
>   }
>   
>   static int smu_v13_0_7_get_fan_speed_rpm(struct smu_context *smu,

