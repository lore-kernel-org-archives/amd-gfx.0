Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D247DC43334
	for <amd-gfx@archiver.kernel.org>; Mon, 11 Jul 2022 10:32:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 545638D7A2;
	Mon, 11 Jul 2022 10:32:25 +0000 (UTC)
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com
 [IPv6:2a00:1450:4864:20::533])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 769FA8D7A5
 for <amd-gfx@lists.freedesktop.org>; Mon, 11 Jul 2022 10:32:23 +0000 (UTC)
Received: by mail-ed1-x533.google.com with SMTP id v12so5651190edc.10
 for <amd-gfx@lists.freedesktop.org>; Mon, 11 Jul 2022 03:32:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=message-id:date:mime-version:user-agent:subject:content-language:to
 :references:from:in-reply-to:content-transfer-encoding;
 bh=T6ES99kTpm89eLiogkoHcC6Qpj3q77N36tsrVxTsiTs=;
 b=mOcV2Zhh0TiBF5eQrtj9NWPfZfHm5kFzgto0UlZ3qE8gVbFfb0YpmpJi5W8ujUTDKn
 1pjas3hAt56YXFKEZsjzIdkfD6HQ0U7wJGG1he/HU/EIVWNa2NMFsox4vqurkDZVVMtr
 AF3S/MtBkEfAbKGO28e8KdGKWK6BE7vRfnV/F0Ion7bAWc1iBEXVlYaL4B88UjwJ1ve7
 RlA39TUfxEqHEvUKQMs0+FZACgPUpAz8YXft8oPgFOoxWLFf2o6Yj4D1w2jO30wTGV7D
 cvbFQU8fI0ctiNzJQbSzm/yNofOydA4yt4+GipDFmhHjqrqg1moWMY1kBUi+sRKtZbH2
 H8zQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:references:from:in-reply-to
 :content-transfer-encoding;
 bh=T6ES99kTpm89eLiogkoHcC6Qpj3q77N36tsrVxTsiTs=;
 b=lwe9fTmmlbpBFZGLXOIXVeXojTpgX1XWCoNzdc+ldiOJJc6wkQQJQ7Av4fToAvt3Y7
 ZPi8qeZnD7sezTPqrCBoh+9gIl4gkFk5EUJnSwK+hAH6DbcO/SRWJNZd+ncLy9HYX6aM
 e4eUHZvjf1anNklJQPqp2ANLy/i/yOps1fOqLmniFfgPKcKBsGh1mIm9J0QgcxeY5UKH
 zapBK39wdUPKT/Gk5MtFKoU2rm3rAmYG0m7m5Gd/4dhUtqH6gUZfMljyZ+NFiBqnJS67
 iHxzhSaOYfaCU+yDWDS+NSbviY1rPkXVZo5VPihwR+DnNoIjchEiXxW+TW5IHlYZmNW0
 R/xg==
X-Gm-Message-State: AJIora+8FjmSVQvXl0QsXG/RFn24jYyxZ/WnTHvyUxeQU4kRlethqexZ
 3aHyd9X0jAwiAQr59FC+Yurj3YJjAR0=
X-Google-Smtp-Source: AGRyM1se7Y18tGkaSiegBZtPMAX/Jui797PhjLiMy3W3tNjBcaVsN5tutSWjjeXtm0wPeR2Gy6O7PQ==
X-Received: by 2002:a05:6402:5193:b0:435:9a5f:50a8 with SMTP id
 q19-20020a056402519300b004359a5f50a8mr23813778edd.212.1657535541999; 
 Mon, 11 Jul 2022 03:32:21 -0700 (PDT)
Received: from [192.168.178.21] (p57b0bd9f.dip0.t-ipconnect.de.
 [87.176.189.159]) by smtp.gmail.com with ESMTPSA id
 q21-20020aa7da95000000b00435651c4a01sm4086800eds.56.2022.07.11.03.32.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 11 Jul 2022 03:32:21 -0700 (PDT)
Message-ID: <5fe781cf-8731-1e1c-3c2c-b8957770276c@gmail.com>
Date: Mon, 11 Jul 2022 12:32:20 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH] drm/amd/pm: Prevent divide by zero
Content-Language: en-US
To: "Mr. B34r" <mr.b34r@kolabnow.com>, amd-gfx@lists.freedesktop.org
References: <20220709023125.75039-1-mr.b34r@kolabnow.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
In-Reply-To: <20220709023125.75039-1-mr.b34r@kolabnow.com>
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

Am 09.07.22 um 04:31 schrieb Mr. B34r:
> From: Vannoonnoo <mr.b34r@kolabnow.com>
>
> divide error: 0000 [#1] SMP PTI
> CPU: 3 PID: 78925 Comm: tee Not tainted 5.15.50-1-lts #1 5c320a339f0e397222fdfc9449eff04c0b12ea83
> Hardware name: MSI MS-7A59/Z270 SLI PLUS (MS-7A59), BIOS 1.90 01/30/2018
> RIP: 0010:smu_v11_0_set_fan_speed_rpm+0x11/0x110 [amdgpu]
>
> Speed is user-configurable through a file. I accidentally set it to zero, and the driver crashed.

Good catch, just some minor style problems. Your Signed-of-by line is 
missing for example.

There is a checkpath.pl script in the Linux kernel source which can 
point out such trivial mistakes.

Please run it on your patch and resend, apart from that looks good to me.

Christian.

>
> ---
>   drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c | 4 ++++
>   1 file changed, 4 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
> index 5f8809f6990d..69cebdb58c04 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
> @@ -1236,6 +1236,10 @@ int smu_v11_0_set_fan_speed_rpm(struct smu_context *smu,
>   	 * - For some Sienna Cichlid SKU, the fan speed cannot be set
>   	 *   lower than 500 RPM.
>   	 */
> +
> +	if (speed == 0)
> +		return -EINVAL;
> +
>   	tach_period = 60 * crystal_clock_freq * 10000 / (8 * speed);
>   	WREG32_SOC15(THM, 0, mmCG_TACH_CTRL,
>   		     REG_SET_FIELD(RREG32_SOC15(THM, 0, mmCG_TACH_CTRL),

