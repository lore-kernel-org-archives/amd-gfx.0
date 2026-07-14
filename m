Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2262DC44508
	for <amd-gfx@archiver.kernel.org>; Tue, 14 Jul 2026 14:59:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A3D6910E077;
	Tue, 14 Jul 2026 14:59:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=ursulin.net header.i=@ursulin.net header.b="uH9qIomi";
	dkim-atps=neutral
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com
 [209.85.221.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A446C10E077
 for <amd-gfx@lists.freedesktop.org>; Tue, 14 Jul 2026 14:59:11 +0000 (UTC)
Received: by mail-wr1-f48.google.com with SMTP id
 ffacd0b85a97d-47df440fcd5so2470249f8f.3
 for <amd-gfx@lists.freedesktop.org>; Tue, 14 Jul 2026 07:59:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ursulin.net; s=google; t=1784041150; x=1784645950; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=oYZZepljDnQ/yS2lNe55a/6NoFmqdJatcOFQ2VemdI0=;
 b=uH9qIomiu2mtq7LPkYjLxjjCr2kFVELHLTrYw4Pdt9vpPWAdHWideNE3SvMn4L4LpW
 9JnUoX1RD4egCpND889RR7Lkf1EqUqazykRvd6DsA6Wg1NWKC1oInW9Glo+nGITHcY7Z
 p/VEpti+5hlkxn0SaJpwDwIDChA+CEZQOMjDjJyvki9ejkV8FVqE8L/i83mMJnu/JpaE
 u9r2tFCjYfsHBH0HBZdutlhMBCIixhJfsYvwXvFYGMW5o3gOKfpsLJk5nHKa9v+8DmmU
 OK3U6MmWylk8//AIDt4FLacc+Yugt/nhjxzj/8yPkH0XPYABd87WShTvGRRDuRjBuqTW
 QSWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784041150; x=1784645950;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=oYZZepljDnQ/yS2lNe55a/6NoFmqdJatcOFQ2VemdI0=;
 b=dBOhhHuGZneNdvBnyLjns/xXCrgexwsEx8Vex5xBhw2KxK7+WxxUouAIkFxpsVbgnv
 37RqBQQJY+NLILmEZPJ0PbZ+n6pJNT7TakraE6bEoXdN1My987YA1ZhGxRNnzeaRpqo0
 zo0K+tBrr8sVwXld21V4/fq2NEphymFNhi0O8PVh/9672pAB8jtLdZCPuobiMX+OoCUx
 OFTv03K8qjJnJuAN4FgyZ/vKr2F3XgtgPsLFY4aovpxDU1f9jd5MhCVOZeFxjFjbj8VQ
 XATHtf78f4G7751JEGslZBPi7zKdAtgMkfp7uVIydThVXFLqUzWJpxKctpDVJiyIkI8i
 XohQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RrYxUfgpolCzSo1ETS/JSX3Fs9xdC672Wk3tOE4L0Jb+7Kh237jRHzG5r9hunwr/V16v7PyIr67@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzIAOrvJCHXKQNfGJOJyDFpsWx88rnq0faig7xeiH/9lWddQTSD
 qZORM2qT/1AXZlwMq0pGfYaRUBv3wU57PrkFj97W+nNgdrs/rMGzDLon4SPlmE4dDag=
X-Gm-Gg: AfdE7ckqorvCLQMJ2d67tnQdbe96kFhoXNAtz2D35jsgXIA6E1Hjiaf/nncL8tpANdc
 6eodyVTJdSyANK/2DkW3aohAbRmoG+DV4G4hECPRiNNyZvtu3LuOQr3BU08ETkCM+j9JIHH2Jof
 3zkr+QggjMqrho8OoHBj/je3k3N5ydwGojvrCFUJRqugnCC5/v4nd7G4MUndJkLbNqJG2jUDp7M
 pBPW+wZl5NAR0stSPHVXbiwe9NVj6n54p2j98COZGsOUdQR0pTz0T8F1MnWg6GlerG+XVtWSZ6r
 y3r8CdVoQK9va0dlvHAj9QzEzwjdYb79STogqbAx22lfx2jWhuIC5pEJ5XNlf6gOToY6X7PTUDR
 +ruXFOsQZEu0PF2I+1ISrWufBJan9XaWUTmQ15upHo9icPZIR9q8DWcXEvS0lrBCA//074I0byC
 IA7pWwoKG7d/yGilF66KWte0RvXFe2NbRlIQ==
X-Received: by 2002:a05:600c:3143:b0:492:5e22:ef18 with SMTP id
 5b1f17b1804b1-493f87ebbbemr146632555e9.9.1784041149628; 
 Tue, 14 Jul 2026 07:59:09 -0700 (PDT)
Received: from [192.168.0.116] ([90.240.106.137])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4950a322c86sm73623115e9.11.2026.07.14.07.59.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 14 Jul 2026 07:59:09 -0700 (PDT)
Message-ID: <46f1492b-7e48-4a62-8a2b-7a058221f033@ursulin.net>
Date: Tue, 14 Jul 2026 15:59:08 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/9] drm/amdgpu/gfx7: Make amdgpu_gfx_mqd_sw_init() usable
 on GFX7
To: =?UTF-8?Q?Timur_Krist=C3=B3f?= <timur.kristof@gmail.com>,
 amd-gfx@lists.freedesktop.org, Alex Deucher <alexander.deucher@amd.com>,
 christian.koenig@amd.com, pierre-eric.pelloux-prayer@amd.com,
 Natalie Vock <natalie.vock@gmx.de>
References: <20260713125838.30607-1-timur.kristof@gmail.com>
 <20260713125838.30607-2-timur.kristof@gmail.com>
Content-Language: en-GB
From: Tvrtko Ursulin <tursulin@ursulin.net>
In-Reply-To: <20260713125838.30607-2-timur.kristof@gmail.com>
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


On 13/07/2026 13:58, Timur Kristóf wrote:
> We don't use KIQ on GFX7 but otherwise MQD works the
> same way as GFX8 and newer.
> 
> Signed-off-by: Timur Kristóf <timur.kristof@gmail.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
> index 96c9d4f00b27..0f142c156afa 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
> @@ -420,7 +420,7 @@ int amdgpu_gfx_mqd_sw_init(struct amdgpu_device *adev,
>   #endif
>   
>   	/* create MQD for KIQ */
> -	if (!adev->enable_mes_kiq && !ring->mqd_obj) {
> +	if (adev->asic_type >= CHIP_TOPAZ && !adev->enable_mes_kiq && !ring->mqd_obj) {

CHIP_TOPAZ is gfx7? Hm if it is then the branch would already run there. 
So the change is limiting the branch to a subset of platforms, while the 
patch title made me think it is enabling something on gfx7. Perhaps 
somehow indirectly or what am I not understanding?

Regards,

Tvrtko

>   		/* originaly the KIQ MQD is put in GTT domain, but for SRIOV VRAM domain is a must
>   		 * otherwise hypervisor trigger SAVE_VF fail after driver unloaded which mean MQD
>   		 * deallocated and gart_unbind, to strict diverage we decide to use VRAM domain for

