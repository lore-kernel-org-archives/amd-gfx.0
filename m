Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA30DCD1284
	for <amd-gfx@archiver.kernel.org>; Thu,  4 Apr 2024 12:04:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 19AE211B52C;
	Thu,  4 Apr 2024 12:04:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="jVCPnnOL";
	dkim-atps=neutral
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com
 [209.85.128.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 36D6911B52C
 for <amd-gfx@lists.freedesktop.org>; Thu,  4 Apr 2024 12:04:31 +0000 (UTC)
Received: by mail-wm1-f52.google.com with SMTP id
 5b1f17b1804b1-4162c11acf7so1442135e9.2
 for <amd-gfx@lists.freedesktop.org>; Thu, 04 Apr 2024 05:04:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1712232269; x=1712837069; darn=lists.freedesktop.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=namCL66X4oR0xq35PvgczgV0Ic4oQ2SP639TUCJR9VA=;
 b=jVCPnnOLk32zj/iB8Ct28/u7V/UF0LY0AC+aOqoU2wESaGTB/2nHDd3881KZN5Shlm
 E4ShbyaPOi8sVABnb5Q+vcvS7GiGzY4fbhcbAc06TH2U+aZJY10HJyskIXu1a0h1uOl9
 4El61+Ng+bK8T6k1x7VCbtFX1fXRn86Dpjlj/o0/nMZDHW8TUhokbmfWqxuREAGq0f0Q
 h8fIuRQsHckYfVA6ccBJYFKcN1ySMGGsz7Ql4RiTf5L545R6MLYX+pZtPJDJGJ6hGiaf
 jWA7zFz0nN15PaHEBQzmtpiRyCbrSh3+VX6NaqayIwRqP22oY4A+AvA8qstrG9OjyFIk
 b1qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712232269; x=1712837069;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=namCL66X4oR0xq35PvgczgV0Ic4oQ2SP639TUCJR9VA=;
 b=pOGuF5UHZ2swqd+7QTdHA/7GqMemngIaiv5fVzJDB7nChjx4MpWitENKFoIYxDteih
 iKvVRevssDHYGG3uWYbE9NvCnWqJd2tucFpTesSuUHyzwZ2dAFf1jVSsMtRXc3X0ZNQx
 N32l5a5rzhqvnd17H4hhMdjldo4k4hY5EjSVDKqkmX7TtptvBXkP4ddG7gjWVwIX31qc
 iLIG5eJCKu0H90DN6BE9MFLP7lgd68Nn3kkv6KIRCnyOd/E0+YT7qIcwM4QD+08egSaN
 apFUwHtswjhqqHnKaoFd0T5x0VMnXG61stlqdbw2GRmHdX+LezTpFqyUaGP++AXLBWzA
 eH1w==
X-Forwarded-Encrypted: i=1;
 AJvYcCXDR/2eBvRA8om+8ITISJZgiO6jEsdc84j3UUMbtZXlLqOYVivh49pcahvm6lkWrgkmzi+QVNei6bbBarB7ciKWQPQTyghDMrOtk7dSuA==
X-Gm-Message-State: AOJu0YycdGI9Xc0S3CEu8JJDTd11YfzDCBpB3LkULWpHZQ8UPiQpbRH7
 aikCbR017ZojChMmnuVJEBVb3XpNzbpCS3UWNKIAXkerEobgwmcB
X-Google-Smtp-Source: AGHT+IFRbSvJFnLs0mjjozv4GJcO9kAWzeIWWc8yw8ZP9DMsOc+T98XyWurTetv55dYmqQpQyjyfTQ==
X-Received: by 2002:a05:600c:c6:b0:413:f4d1:199e with SMTP id
 u6-20020a05600c00c600b00413f4d1199emr2096435wmm.31.1712232269173; 
 Thu, 04 Apr 2024 05:04:29 -0700 (PDT)
Received: from [10.254.108.81] (munvpn.amd.com. [165.204.72.6])
 by smtp.gmail.com with ESMTPSA id
 e21-20020a05600c4e5500b0041629a68b12sm2318928wmq.25.2024.04.04.05.04.27
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 04 Apr 2024 05:04:28 -0700 (PDT)
Message-ID: <ed22e5f9-6197-4ef2-af25-b5ec81fb35b4@gmail.com>
Date: Thu, 4 Apr 2024 14:04:27 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: Bypass asd if display hw is not available
To: Hawking Zhang <Hawking.Zhang@amd.com>, amd-gfx@lists.freedesktop.org,
 Alex Deucher <alexander.deucher@amd.com>, Kenneth Feng <kenneth.feng@amd.com>
References: <20240329094913.32185-1-Hawking.Zhang@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>
In-Reply-To: <20240329094913.32185-1-Hawking.Zhang@amd.com>
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

Am 29.03.24 um 10:49 schrieb Hawking Zhang:
> ASD is not needed by headless GPU.

Oh, that's actually not correct.

We have some hw workarounds in the ASD firmware which are necessary even 
if the actual functionality of the fw isn't needed.

Only when the fw binary isn't provided at all we should skip this.

Regards,
Christian.

>
> Signed-off-by: Hawking Zhang <Hawking.Zhang@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c | 5 +++++
>   1 file changed, 5 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
> index 94b310fdb719d..063203865bbe2 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
> @@ -1053,6 +1053,11 @@ static int psp_asd_initialize(struct psp_context *psp)
>   	if (amdgpu_sriov_vf(psp->adev) || !psp->asd_context.bin_desc.size_bytes)
>   		return 0;
>   
> +	/* bypass asd if display hardware is not available */
> +	if (!amdgpu_device_has_display_hardware(psp->adev) &&
> +	    amdgpu_ip_version(adev, MP0_HWIP, 0) >= IP_VERSION(13, 0, 10))
> +		return 0;
> +
>   	psp->asd_context.mem_context.shared_mc_addr  = 0;
>   	psp->asd_context.mem_context.shared_mem_size = PSP_ASD_SHARED_MEM_SIZE;
>   	psp->asd_context.ta_load_type                = GFX_CMD_ID_LOAD_ASD;

