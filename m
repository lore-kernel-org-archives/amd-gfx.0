Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB962C02181
	for <amd-gfx@archiver.kernel.org>; Mon, 20 Jan 2025 14:03:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9818F10E159;
	Mon, 20 Jan 2025 14:03:58 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="cz4oIh33";
	dkim-atps=neutral
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com
 [209.85.221.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DC85F10E159
 for <amd-gfx@lists.freedesktop.org>; Mon, 20 Jan 2025 14:03:57 +0000 (UTC)
Received: by mail-wr1-f51.google.com with SMTP id
 ffacd0b85a97d-38a8b35e168so3106522f8f.1
 for <amd-gfx@lists.freedesktop.org>; Mon, 20 Jan 2025 06:03:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1737381776; x=1737986576; darn=lists.freedesktop.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=tvGqlTONoLOw01LZ4p2mas+gfXtOBlkN9toA94FalHo=;
 b=cz4oIh33rcHLThNtR7yPSccEpjr0USiKjiVF/zUbaITt5m5nDWuTv34aROpfWL+EHO
 fgbzefCtSe+R++Pa9dfSxEZC1oUoY1JSxwngFiDpMKZfJd9vU6D2mAcY/0NvXUfl07c6
 LpaBGeLixTFqvvwyp6fcTRpnadi4FJpcBE7MbzBmP/YHjkmSNQP3X4rTYgDsFuUoUJD7
 whjvZWW9b77jWwYiRAP/2YWRdc/XiWRABK10sdKbC2K9yaR8zbs0JXoA5spdScG2UT4s
 /PIw1QLEurTy7a+ucFy6b4esPdWWoaM7L+7l/P5mpZn4eDPLkNkuCF/PzwoxALWcUSjG
 eGeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737381776; x=1737986576;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=tvGqlTONoLOw01LZ4p2mas+gfXtOBlkN9toA94FalHo=;
 b=h+8jcCfzNN1osM6BL+R9TG9kNbuOnEY/SUhNPPbnWwPxvT1tyhrRIetB9g40qFNdif
 RqMLA5CCSgdq4+IK/6ECzesc2CR9tGPegDv52yUCAA1JZa9y+lJul9vzzxnFqP8kCg+k
 AiC9QmSa0/JaeqVRMcZoq4pNvC8Kok8G2wDKPs0m8L5/zj6CM2HNl+RuD4QcRxDjbfB8
 tCKciB/EXJwQ3gNcDooAqdPrW8gdAnR+QSHSLmhqBzxvIKjAr8VB8OkEw7g2TDjLrWbq
 Q1WcD6U1hri0wEAY/82V8YpOgMSKWWIJgEIeWcFjY4D1shDsoQ3u3EXa2JSC2u1v27dm
 GUng==
X-Gm-Message-State: AOJu0YygApKG1RGm+kIudQsmYf1UDD66er3va+h/3VQAL/BMZTHxqwJE
 aY2E82Ve1MR00ZyhgSA0GXi3qoMkDfZhyRUDFY7C2NGqAsjj7wMC
X-Gm-Gg: ASbGncvFg4ypsbRotrFY9uTEpmuliMhbQttS1tTlvdUAVhoY7u2c9QInPuh1bZnudMl
 eMfCy1A2fDWAHnMTTu+Up/JGJN7MDHOyHAJx1g2zx2yEWnbFSg+iDQFugbXucGMlWI4O9arfDfO
 1Z8nvHLH5duCvJhvdcWm6FpxNm53evshMLtiYay94nJhGHCgefqdcqQgdWoM8q7q9zt3zteFwe+
 GHONLIG3lyt22u9TcrfAahf2fvurhCZv1gsoA9f+PjYmtNc/jEmLd2vs0Mi40pvbKcFwE0CovLj
 iCFDPV4Ry3D5O4M86CMwwNQ=
X-Google-Smtp-Source: AGHT+IHKpBPdOg6DNnQr5BMl+NhQmj4ywlS1N8yg0CUU4TusguL13ktDb9ZI86u1hp9PSLte2CPnUw==
X-Received: by 2002:a5d:5888:0:b0:38a:888c:a635 with SMTP id
 ffacd0b85a97d-38bf5ae25d2mr11014332f8f.14.1737381775920; 
 Mon, 20 Jan 2025 06:02:55 -0800 (PST)
Received: from [10.254.108.83] (munvpn.amd.com. [165.204.72.6])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38bf322a506sm10388072f8f.41.2025.01.20.06.02.55
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 20 Jan 2025 06:02:55 -0800 (PST)
Message-ID: <59773739-6fde-4c41-9b42-329988108e73@gmail.com>
Date: Mon, 20 Jan 2025 15:02:54 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] drm/amd/amdgpu: Prevent null pointer dereference in
 GPU bandwidth calculation
To: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>
Cc: amd-gfx@lists.freedesktop.org, Dan Carpenter <dan.carpenter@linaro.org>,
 Lijo Lazar <lijo.lazar@amd.com>
References: <20250120133807.235523-1-srinivasan.shanmugam@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>
In-Reply-To: <20250120133807.235523-1-srinivasan.shanmugam@amd.com>
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

Am 20.01.25 um 14:38 schrieb Srinivasan Shanmugam:
> If the parent is NULL, adev->pdev is used to retrieve the PCIe speed and
> width, ensuring that  the function can still determine these
> capabilities from the device itself.
>
> Fixes the below:
> drivers/gpu/drm/amd/amdgpu/amdgpu_device.c:6193 amdgpu_device_gpu_bandwidth()
> 	error: we previously assumed 'parent' could be null (see line 6180)
>
> drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>      6170 static void amdgpu_device_gpu_bandwidth(struct amdgpu_device *adev,
>      6171                                         enum pci_bus_speed *speed,
>      6172                                         enum pcie_link_width *width)
>      6173 {
>      6174         struct pci_dev *parent = adev->pdev;
>      6175
>      6176         if (!speed || !width)
>      6177                 return;
>      6178
>      6179         parent = pci_upstream_bridge(parent);
>      6180         if (parent && parent->vendor == PCI_VENDOR_ID_ATI) {
>                       ^^^^^^
> If parent is NULL
>
>      6181                 /* use the upstream/downstream switches internal to dGPU */
>      6182                 *speed = pcie_get_speed_cap(parent);
>      6183                 *width = pcie_get_width_cap(parent);
>      6184                 while ((parent = pci_upstream_bridge(parent))) {
>      6185                         if (parent->vendor == PCI_VENDOR_ID_ATI) {
>      6186                                 /* use the upstream/downstream switches internal to dGPU */
>      6187                                 *speed = pcie_get_speed_cap(parent);
>      6188                                 *width = pcie_get_width_cap(parent);
>      6189                         }
>      6190                 }
>      6191         } else {
>      6192                 /* use the device itself */
> --> 6193                 *speed = pcie_get_speed_cap(parent);
>                                                       ^^^^^^ Then we are toasted here.
>
>      6194                 *width = pcie_get_width_cap(parent);
>      6195         }
>      6196 }
>
> Fixes: 9e424a5d9087 ("drm/amdgpu: cache gpu pcie link width")
> Cc: Christian König <christian.koenig@amd.com>
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
> Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
> Suggested-by: Lijo Lazar <lijo.lazar@amd.com>

Reviewed-by: Christian König <christian.koenig@amd.com>

> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> index 46af07faf8c8..ae83e23872fa 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -6187,8 +6187,8 @@ static void amdgpu_device_gpu_bandwidth(struct amdgpu_device *adev,
>   		}
>   	} else {
>   		/* use the device itself */
> -		*speed = pcie_get_speed_cap(parent);
> -		*width = pcie_get_width_cap(parent);
> +		*speed = pcie_get_speed_cap(adev->pdev);
> +		*width = pcie_get_width_cap(adev->pdev);
>   	}
>   }
>   

