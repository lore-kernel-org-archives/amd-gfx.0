Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85136CDB481
	for <amd-gfx@archiver.kernel.org>; Wed, 24 Jun 2026 14:37:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2370110EDFD;
	Wed, 24 Jun 2026 14:37:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=ursulin.net header.i=@ursulin.net header.b="avz78yyw";
	dkim-atps=neutral
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com
 [209.85.221.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 73AD210EDFD
 for <amd-gfx@lists.freedesktop.org>; Wed, 24 Jun 2026 14:37:14 +0000 (UTC)
Received: by mail-wr1-f48.google.com with SMTP id
 ffacd0b85a97d-46019edc13dso699688f8f.1
 for <amd-gfx@lists.freedesktop.org>; Wed, 24 Jun 2026 07:37:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ursulin.net; s=google; t=1782311833; x=1782916633; darn=lists.freedesktop.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=QrAXaHE3DukTi8OlP88Uh54oA+6j4WB41yVoiEiKTMg=;
 b=avz78yywTyLn5GsPqUfZEhM2qT7r0SqN/wPLQI2EY5epYk+Msj8L8jOGsYXh4HHCQv
 qBk55wCXbTGLkunjk/5fTBRPGJINsmxVVhElTqdUKYTs/7NEM1fXysIao/qo4fJ4ojms
 omHdEiWk66MtDrXVjJUALybfPpr5wo6jWTzYq3n9qqrbKFGQLqeFAPxSSw8ZvkV+60K7
 FPnXikOBcKB1BDTUUQ7gomt1J+1O2dlgk3mWkNqJ8S8PffpELt3JKsYyftYtWJzIcKwh
 wMU3676WWmjtxJoAhDo2/gZH8kLLXXQddiPMm1yrqdNO8EWT7ziibRRcA2BRMZQ/FgWd
 mvBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782311833; x=1782916633;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=QrAXaHE3DukTi8OlP88Uh54oA+6j4WB41yVoiEiKTMg=;
 b=sWxnbNQO3xJUwY5XEPJnaEA56zmDMLCYEaT2axlNIFr2wIZdYNEn68wna8caZ7IpeF
 KFIRTHC5GZ7TKXnQpT90Ai88IFhbjOLp/LjPPpfv61je8z1YMKIlhxV6FUogyVw4RDw5
 8K9jGP7R0xzTHiSIZlhZcJrWv7BbV+7sAsrtyIfKEn7A/5QbG4OxHId4Tc9UjEJAMaV/
 lfJ+0pQYtJr7V4yVSYE0gQ6RnjE/4LlUwczKIYNY+RLWvWasRD5QjkIo0UL+pR0aQdTW
 xaDdEXyiRgIcm0WW+hZvDfx+2uKOnOUaZy7GL4DfJacQ2bsSpOxLO2usY3nAPuFY/qB2
 /l4w==
X-Forwarded-Encrypted: i=1;
 AHgh+RpIlPHliaa3iH5kv+eC33Rr6ZDepMcpE53Kg4NLucSJQSOwa7lI9PJhBatW2gArE8U7Yl6N+9Jo@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yz7jCZHrN3Cm3NFm1+a9Z49Qz7Piq92DQwoV94oIbsrRnb2s+c8
 46J3dVVZ4iPKQ8WR7lqdCk/Di7XYpHW4ursmekQIlnvpyUWfaaDyMg6PmXMW6rvXf5k=
X-Gm-Gg: AfdE7cnUcek6N0OmnVF3DQCKTeN6pxxdkDqYlqAIkCn4Fy8y8nDKvZcF09i5LR6h/bO
 3DIIoLVTrFe2MgojiBZzzZCUYcoez+/q3V+DtJQpIysvsjOOrel5dwl9rhKqGv43KKMk0FTJKPH
 8J3MAjhPgtRoKcIJFNaddauh8Skt91fLmgenFV/xQ67s4VXS3AfLo5unIPorDKN5YwC0/WV/CcD
 4e1yTc1C2xn7bKvtNl9rHIlCFgjubQg6Ilq+t7P0Pmcmd+ktPu46WF4yZRiUqTGVHPRVxGH/8Mc
 tUmhD6OfLsKA6XtssWqoKd7k/r3//hNJBbmcNNNu272nnbt7G7iiRu8Tq1GP7VAEXBs4JVuOTnL
 ZsjvaDg+h33vx7prgv9akPjcfCMO164FFvKhclSXyQvXhoex9Xde7OXKHiCtwyXew0YdxjrXeBp
 7gjmWiPwR4KGc21++jN3OmvKBlFjHHqLLfGA==
X-Received: by 2002:a5d:4a84:0:b0:45e:ec27:b4b0 with SMTP id
 ffacd0b85a97d-46ad96ba3c7mr8504886f8f.18.1782311832645; 
 Wed, 24 Jun 2026 07:37:12 -0700 (PDT)
Received: from [192.168.0.116] ([90.240.106.137])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-46c1e840f34sm7519525f8f.2.2026.06.24.07.37.11
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 24 Jun 2026 07:37:12 -0700 (PDT)
Message-ID: <6297d359-2d4e-4961-a645-a2a241aba823@ursulin.net>
Date: Wed, 24 Jun 2026 15:37:11 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/7] drm/amdgpu/ih7.0: Use IH_SW_RING_SIZE for soft IH
 ring instead of PAGE_SIZE
To: =?UTF-8?Q?Timur_Krist=C3=B3f?= <timur.kristof@gmail.com>,
 amd-gfx@lists.freedesktop.org, Alexander.Deucher@amd.com,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Natalie Vock <natalie.vock@gmx.de>, Amir Shetaia <Amir.Shetaia@amd.com>,
 =?UTF-8?B?TWFyZWsgT2zFocOhaw==?= <maraeo@gmail.com>,
 Mario Limonciello <mario.limonciello@amd.com>
References: <20260529103059.21470-1-timur.kristof@gmail.com>
 <20260529103059.21470-5-timur.kristof@gmail.com>
Content-Language: en-GB
From: Tvrtko Ursulin <tursulin@ursulin.net>
In-Reply-To: <20260529103059.21470-5-timur.kristof@gmail.com>
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


On 29/05/2026 11:30, Timur Kristóf wrote:
> When there are a lot of retry faults happening, the soft IH ring
> can fill up really quickly and possibly overflow. PAGE_SIZE was
> too small, use IH_SW_RING_SIZE to match what other GPU generations
> are doing.
> 
> Signed-off-by: Timur Kristóf <timur.kristof@gmail.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/ih_v7_0.c | 5 +----
>   1 file changed, 1 insertion(+), 4 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/ih_v7_0.c b/drivers/gpu/drm/amd/amdgpu/ih_v7_0.c
> index 4e6d14facf93a..ec0919fa82540 100644
> --- a/drivers/gpu/drm/amd/amdgpu/ih_v7_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/ih_v7_0.c
> @@ -587,7 +587,6 @@ static int ih_v7_0_sw_init(struct amdgpu_ip_block *ip_block)
>   	int r;
>   	struct amdgpu_device *adev = ip_block->adev;
>   	bool use_bus_addr;
> -	unsigned int sw_ring_size;
>   
>   	r = amdgpu_irq_add_id(adev, SOC21_IH_CLIENTID_IH, 0,
>   			      &adev->irq.self_irq);
> @@ -619,9 +618,7 @@ static int ih_v7_0_sw_init(struct amdgpu_ip_block *ip_block)
>   	/* initialize ih control register offset */
>   	ih_v7_0_init_register_offset(adev);
>   
> -	sw_ring_size = (amdgpu_ip_version(adev, OSSSYS_HWIP, 0) == IP_VERSION(7, 1, 0)) ?
> -			IH_SW_RING_SIZE : PAGE_SIZE;
> -	r = amdgpu_ih_ring_init(adev, &adev->irq.ih_soft, sw_ring_size, true);
> +	r = amdgpu_ih_ring_init(adev, &adev->irq.ih_soft, IH_SW_RING_SIZE, true);
>   	if (r)
>   		return r;
>   

Looks plausible to me.

Reviewed-by: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>

The only other which uses PAGE_SIZE for the soft IH ring is ih_v6_1.c so 
maybe that one needs tweaking too?

Regards,

Tvrtko

