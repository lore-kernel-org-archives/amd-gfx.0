Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A73FCC25B74
	for <amd-gfx@archiver.kernel.org>; Fri, 24 May 2024 08:04:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2FF8E10E38B;
	Fri, 24 May 2024 08:04:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="b+xbnPLF";
	dkim-atps=neutral
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com
 [209.85.221.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6C22B10E38B
 for <amd-gfx@lists.freedesktop.org>; Fri, 24 May 2024 08:04:49 +0000 (UTC)
Received: by mail-wr1-f51.google.com with SMTP id
 ffacd0b85a97d-354cd8da8b9so2988186f8f.0
 for <amd-gfx@lists.freedesktop.org>; Fri, 24 May 2024 01:04:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1716537887; x=1717142687; darn=lists.freedesktop.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=dsAhLXkWFmFQN7tXWSl1mVL2BRYms7p4QKscqPKpZeA=;
 b=b+xbnPLFIwxBFtE2beeXdLvH3Wsv44Qr1M8g2InNyh4oWdSmsXG4MOmAwqgmD6eW7g
 /wqt6DpcVguQDvGVhc8/qUKOYDnMbYl3SSky43krb+uAan7AG5XKpoyEkYMnmiZpraTj
 6DiXtq4FNdc9fJhD/NDpqSB0ErYSRu9/svurHQb79votdYhs1xTi95VCyTiLvcf3rb5P
 d8eXlzL+52SNxhJFNz1bB3WQR+FfT9lGgfd9UNd1u0Z1W+eQieWeqyhsUZJkxAfDSsl9
 6xcFt7Sx0ZCHCsN9i5hVvLvLVS8VoO0rmYyP4UuRgWhuEKukC1pNMzCP6VHT8O12Krli
 zepQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716537887; x=1717142687;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=dsAhLXkWFmFQN7tXWSl1mVL2BRYms7p4QKscqPKpZeA=;
 b=tSpv/j0adxrGS0dyxmxgbhU36JwZVuvE3s++ONQX5cwyKS4+k9pI21azefSltkxee1
 JTj5hsJG3Q2Gn1T84Uf4yB5a9N5n29RP01yekMn+HZ4es2EhfYIqDc/H7QzD7yYUdhd2
 gU0o2rzjcMyueIlNHkaIN1iTB6R3UxxwP2UDZi7YyWBUr7fDQntn9OXCf4ptnNKCF8VH
 354F/30DuS8tudThRJsQMoCEWbRWXynxbUH6mpL+1sLtXMgF7p1sj2NzuHSy5JO64z3I
 6VpU+awvCkaM9xvkgj6lC63dwsUBpKX1m0yHwrgefwcRSQy3BG+lRDmnFPssDb+vkl8W
 jmvQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVAvvlBez5rZSSeRFS7y+Y02ikPEL8ORQquv7IYo1nS8h5QDhDsSrZXRVMf7HalFHaGfBBxgEL84eL+W+OF0//HAG92DGxSv/xZOr17xw==
X-Gm-Message-State: AOJu0Yz46vOWLzvUJ6saLDFBI8p+rZlaIOscB0MPAM3ap5EtqjHFKEUs
 y0jDGPpRoRXn24LEWAzW5L1VjT26fAQkM3YhwFHBgR64iqeW+Wm4VTC3mwzT
X-Google-Smtp-Source: AGHT+IH40kdf6VxWrEIhRO++L9eBdIFRh0Ta2LEiyA2YSypxT5VnwvUwIT6ELUydRKL/k4c/b7P8RA==
X-Received: by 2002:adf:f38f:0:b0:352:9e0c:f9d3 with SMTP id
 ffacd0b85a97d-3552219d081mr872379f8f.31.1716537887447; 
 Fri, 24 May 2024 01:04:47 -0700 (PDT)
Received: from [10.254.108.81] (munvpn.amd.com. [165.204.72.6])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3557a0908e4sm985595f8f.63.2024.05.24.01.04.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 24 May 2024 01:04:46 -0700 (PDT)
Message-ID: <53db4de8-4fb9-4061-a191-0f5a0451f84e@gmail.com>
Date: Fri, 24 May 2024 10:04:45 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: Adjust logic in
 amdgpu_device_partner_bandwidth()
To: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
References: <20240516150512.2260787-1-alexander.deucher@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>
In-Reply-To: <20240516150512.2260787-1-alexander.deucher@amd.com>
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

Am 16.05.24 um 17:05 schrieb Alex Deucher:
> Use current speed/width on devices which don't support
> dynamic PCIe switching.
>
> Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/3289
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>

Acked-by: Christian König <christian.koenig@amd.com>

> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 19 ++++++++++++-------
>   1 file changed, 12 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> index e72e774d17e6a..f0011dac589d2 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -5946,13 +5946,18 @@ static void amdgpu_device_partner_bandwidth(struct amdgpu_device *adev,
>   	*speed = PCI_SPEED_UNKNOWN;
>   	*width = PCIE_LNK_WIDTH_UNKNOWN;
>   
> -	while ((parent = pci_upstream_bridge(parent))) {
> -		/* skip upstream/downstream switches internal to dGPU*/
> -		if (parent->vendor == PCI_VENDOR_ID_ATI)
> -			continue;
> -		*speed = pcie_get_speed_cap(parent);
> -		*width = pcie_get_width_cap(parent);
> -		break;
> +	if (amdgpu_device_pcie_dynamic_switching_supported(adev)) {
> +		while ((parent = pci_upstream_bridge(parent))) {
> +			/* skip upstream/downstream switches internal to dGPU*/
> +			if (parent->vendor == PCI_VENDOR_ID_ATI)
> +				continue;
> +			*speed = pcie_get_speed_cap(parent);
> +			*width = pcie_get_width_cap(parent);
> +			break;
> +		}
> +	} else {
> +		/* use the current speeds rather than max if switching is not supported */
> +		pcie_bandwidth_available(adev->pdev, NULL, speed, width);
>   	}
>   }
>   

