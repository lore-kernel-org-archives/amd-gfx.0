Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3BE0CD98CF
	for <amd-gfx@archiver.kernel.org>; Tue, 16 Jun 2026 08:09:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 763FF10E8AD;
	Tue, 16 Jun 2026 08:09:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=ursulin.net header.i=@ursulin.net header.b="K37vSU0I";
	dkim-atps=neutral
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com
 [209.85.218.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2035410E8AD
 for <amd-gfx@lists.freedesktop.org>; Tue, 16 Jun 2026 08:09:56 +0000 (UTC)
Received: by mail-ej1-f45.google.com with SMTP id
 a640c23a62f3a-bed19623d6eso542876566b.1
 for <amd-gfx@lists.freedesktop.org>; Tue, 16 Jun 2026 01:09:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ursulin.net; s=google; t=1781597395; x=1782202195; darn=lists.freedesktop.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Ie4wxqeczrhxVonnpO4AQL/90SDgbJOxJX/VnvasMnQ=;
 b=K37vSU0IxKQ7L6UKH11IdFhv19tpqi4SvLBDKQssy2WaUVamSQ4njAB1OU2Bi3hAAk
 f2vY+NWo/vnO+CIEgyamy7MKHImBAG+9r1vbAsax4cg5MjJ3QNrDUxZWefrZ+p04J8zd
 YThAqM1Ihl7k+ylJrhGjpCLqznTeFB+/0Su1e8FAmZRW/7yHDKuUy50Hyxuap/g7fHQ4
 CW8K3QB7gz/TU70mm59erYA2zyYMVxNWnzj9hfj9XnAhL1Vb0mV7udwMyMM2kzxlA8v7
 PVppnUDSoNB+EyPeTa/H21XaRJklFdxyLrx3rWM7c2lV+xQbE0a+fjkPQI8ixUtTDcM6
 uL/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781597395; x=1782202195;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Ie4wxqeczrhxVonnpO4AQL/90SDgbJOxJX/VnvasMnQ=;
 b=JLu+wezc96sJk1m2ibQexGHpO92f3REuDe1X7kOLQDlagrhVyCfUwJDqXuzzLcCs8D
 dHS+C2ODXYYA7CJUPGJ6iiWwX2CLlMHda3q6p56U8uWbuYWRKckAN6nyPiwek/wESfxk
 V4i0U8MtnW4RtvmbT3qApaaO8CxIAoRdQxVkSjonexIZ9zpTMePMCNN8Uk+k3y2zid15
 utb8mBTsny3mDOUczgzyO/t9TMrjlkWYC8OVotu/iPcZpA44n8NA1vmE2Mrbe9cuT/JF
 JzQVJRDSjtiEBJ3ZuFdBrCPz7p5BScmLwuA9yhin4Uwf1ZBnCrl14UTfeeLtbJiRpUWn
 BHww==
X-Forwarded-Encrypted: i=1;
 AFNElJ8FAqT39eeUQwL69v8188W5q7vM6xWZ2PTxPb1eJfT3JCbwnP0Nv/6EqaXvvYWTujfI7ZQhnag9@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxbFIqUndJ+0MO2JMGq1mx4OAohASPtSMvVY2QaygFsmvH764kG
 x9k8sxRC8QDn9NbcwLZ387IBJy9o7wPWFky60J+Ygi8KaHdi7RerunCOFTYcHujM0cU=
X-Gm-Gg: Acq92OEvoA0GvL+YYyorCO6M2sS0nsC6a9A0+4OaNpZTqCMprw2IlUwJ2b6U+1s4GWS
 DU9Z5bPvTgbULXobyN7LAktS83jxzbWY2NaAGupjuGujHvKUeBxl/7sDbxyMOg5Isi2a6SZw2T2
 ijmwgK/mZnqPsk9I86DsNlSel2Zn059O5qwEm/+MdZg9fUyaHcC89SSwDkzQGE1mfTWGHyNz/QQ
 MBuxj1UDYrkHqeHBi1iJOoxsvETVlRCHSQmb6e+rCGXK3M0czOAQwSICcjK6Ceke/fEFSSiYX+f
 zlg8Y8x3KbyAgEaIyId/acZZOTDCcpkEKqPNIR6GMYPzkGetF4AgH/iaQqiiBqEnkKNSZL/7ADK
 rgTyPoA2ew+6xD2qJR0r8hvXuJ9MXAmKLENdP6zYM2EUDZEiT4O32j7kzbnAllVfPGo5z0cIBpE
 bT3ef7zuSTWg8ve3lb06YXKoktEDoJUMEgaRJ2PvjMW0g9kNXk7qCTbXA=
X-Received: by 2002:a17:907:a28d:b0:bd2:6d40:3f6a with SMTP id
 a640c23a62f3a-bfe2bcb19c4mr786970966b.45.1781597394236; 
 Tue, 16 Jun 2026 01:09:54 -0700 (PDT)
Received: from [192.168.0.116] ([90.240.106.137])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-bfdb7b6d9b7sm598096866b.41.2026.06.16.01.09.53
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 16 Jun 2026 01:09:53 -0700 (PDT)
Message-ID: <25f69c76-8140-4573-8d3e-9aa8071ee715@ursulin.net>
Date: Tue, 16 Jun 2026 09:09:53 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6/7] drm/amdgpu/gfxhub: Respect noretry flag for retry
 faults on GFX12.1
To: =?UTF-8?Q?Timur_Krist=C3=B3f?= <timur.kristof@gmail.com>,
 amd-gfx@lists.freedesktop.org, Alex Deucher <alexander.deucher@amd.com>,
 christian.koenig@amd.com, Natalie Vock <natalie.vock@gmx.de>,
 Mario Limonciello <mario.limonciello@amd.com>,
 Amir Shetaia <Amir.Shetaia@amd.com>, =?UTF-8?B?TWFyZWsgT2zFocOhaw==?=
 <maraeo@gmail.com>
References: <20260525114507.24566-1-timur.kristof@gmail.com>
 <20260525114507.24566-7-timur.kristof@gmail.com>
Content-Language: en-GB
From: Tvrtko Ursulin <tursulin@ursulin.net>
In-Reply-To: <20260525114507.24566-7-timur.kristof@gmail.com>
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


On 25/05/2026 12:45, Timur Kristóf wrote:
> When retry faults are disabled (amdgpu.noretry=1),
> the ENABLE_RETRY_FAULT_INTERRUPT bit should be programmed to 0.
> 
> Note that retry faults are enabled by default on GFX12.1
> so this just fixes the case when they are explicitly disabled.
> 
> Signed-off-by: Timur Kristóf <timur.kristof@gmail.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/gfxhub_v12_1.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfxhub_v12_1.c b/drivers/gpu/drm/amd/amdgpu/gfxhub_v12_1.c
> index 4c2fd1e6616e..d2edfe037da8 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfxhub_v12_1.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfxhub_v12_1.c
> @@ -243,7 +243,7 @@ static void gfxhub_v12_1_xcc_init_system_aperture_regs(struct amdgpu_device *ade
>   		tmp = REG_SET_FIELD(tmp, GCVM_L2_PROTECTION_FAULT_CNTL2,
>   				    ACTIVE_PAGE_MIGRATION_PTE_READ_RETRY, 1);
>   		tmp = REG_SET_FIELD(tmp, GCVM_L2_PROTECTION_FAULT_CNTL2,
> -				    ENABLE_RETRY_FAULT_INTERRUPT, 0x1);
> +				    ENABLE_RETRY_FAULT_INTERRUPT, !adev->gmc.noretry);
>   		WREG32_SOC15(GC, GET_INST(GC, i),
>   			     regGCVM_L2_PROTECTION_FAULT_CNTL2, tmp);
>   	}

If I look at 6f894c92490b ("drm/amdgpu: Enable retry faults for GFX 
12.1") which added this code, it also touched 
gfxhub_v12_1_xcc_setup_vmid_config():

     tmp = REG_SET_FIELD(tmp, GCVM_CONTEXT1_CNTL,
                         RETRY_PERMISSION_OR_INVALID_PAGE_FAULT,
-                       !amdgpu_noretry);
+                       1);

Should that be changed as well?

Regards,

Tvrtko

