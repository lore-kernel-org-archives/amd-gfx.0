Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5EFBDCD1292
	for <amd-gfx@archiver.kernel.org>; Mon,  1 Apr 2024 12:24:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DC82510F0F9;
	Mon,  1 Apr 2024 12:24:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="RocBuGxt";
	dkim-atps=neutral
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com
 [209.85.208.175])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CDDD310F104
 for <amd-gfx@lists.freedesktop.org>; Mon,  1 Apr 2024 12:24:56 +0000 (UTC)
Received: by mail-lj1-f175.google.com with SMTP id
 38308e7fff4ca-2d700beb6beso50595511fa.2
 for <amd-gfx@lists.freedesktop.org>; Mon, 01 Apr 2024 05:24:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1711974294; x=1712579094; darn=lists.freedesktop.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=mH3l7QWgyZ/klOX5n9IdLDuWJwwxqNzfoheqC403k0A=;
 b=RocBuGxt0+2+AOKycAHkvzrciUFxip256XqYywuxSJX314PY2jpaKxKwLRf2Zok/IL
 ArdCewyAAjFOv8WWL9rYBQFOZbiw+kX1dQI13dOeV2UNQr8cxoCTmb5ZOeCYmzrwcAYA
 4Io0UwLDOtGJRHmOGiMGc1Zt6ot5ZaEH/ryVoWUjN5Ir19MhZYVo3tepjd2z9IvLnshv
 8Utyk2atYNg3x3AR5k4JyayHp+a1x4fiyCktrv5wKeg0AP/kbHbU9aCJqMiYCH0eHn4m
 +xDzrZ1UuEJ0NNpOvi0rloEV48IzZMFYSJ2MuLcG90nB+LXIEeY1OHjj0wZ/tqKNqB6r
 jJTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711974294; x=1712579094;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=mH3l7QWgyZ/klOX5n9IdLDuWJwwxqNzfoheqC403k0A=;
 b=pK2oLaDZlNkKiglUEZKvxKebKtVSTf+5vBr1bHU0KMvYp63ae+DXizJe/lpQNjM7rm
 jIl9im82MoQeGYkb8UV9nCbR9XxCYINQUctMJr6h7X/rXcpxONwtprMCetaPFDys0kyq
 95V1NrcYrrV6p8fiqBeMDddHYuKkJfGe3MfT8a4jHewBZ9II5svwuj8J9ERyjvoyVse2
 OwVwS8z88KVhAZfezOuW2BfEEBkVFcrEz1kaTJetkBjUj5wI2WYa8Wlpu8I52pF3LJG3
 23np3BoP2QPD/2JwNDqv5t6/pp5Yo/K/UXDXLoWBm3wo9S6KgLox+HAeEmXJosg3D20O
 VBWQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUoOjC6U0v0bMQ5egsHZtD+vz0Nhvcfz3KZhoI3XhGII3Lc3n9vI0bA/DCes+DJxh8PRK0B8l9ESTxjJI+AlxI9c3mBIKDdQQAOuguD4Q==
X-Gm-Message-State: AOJu0YzcyZYidD0NgoSQcWxkpqpUZFqOzu36jP6FWsuzEimi7Qf4nROu
 5JrvzzAmPu1x6q+QpuHlAw3OOOVejwxTeDYwAY/jncX/sHY3SRKn
X-Google-Smtp-Source: AGHT+IEriD1FXNpN8mbAsdZ0fZmG1iKixobRY46fMb0dur4HQgYIKZRIRTKQZxOUDvi53J6AQtY2GA==
X-Received: by 2002:a2e:b88f:0:b0:2d7:1830:d5f9 with SMTP id
 r15-20020a2eb88f000000b002d71830d5f9mr6938247ljp.31.1711974292212; 
 Mon, 01 Apr 2024 05:24:52 -0700 (PDT)
Received: from [10.254.108.81] (munvpn.amd.com. [165.204.72.6])
 by smtp.gmail.com with ESMTPSA id
 h17-20020a05600c351100b0041468961233sm17817992wmq.35.2024.04.01.05.24.51
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 01 Apr 2024 05:24:51 -0700 (PDT)
Message-ID: <bc206c92-ee28-4438-bc2b-06e33096a28a@gmail.com>
Date: Mon, 1 Apr 2024 14:24:53 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: Fix discovery initialization failure during
 pci rescan
To: Ma Jun <Jun.Ma2@amd.com>, amd-gfx@lists.freedesktop.org,
 christian.koenig@amd.com, Alexander.Deucher@amd.com
References: <20240401101847.3113771-1-Jun.Ma2@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>
In-Reply-To: <20240401101847.3113771-1-Jun.Ma2@amd.com>
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

Am 01.04.24 um 12:18 schrieb Ma Jun:
> Waiting for system ready to fix the discovery initialization
> failure issue. This failure usually occurs when dGPU is
> removed and then rescanned via command line.
> It's caused by following two errors:
> [1] vram size is 0
> [2] wrong binary signature
>
> Signed-off-by: Ma Jun <Jun.Ma2@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c | 15 ++++++++++++---
>   1 file changed, 12 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
> index 07c5fca06178..ac6b2ae6414c 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
> @@ -276,7 +276,12 @@ static int amdgpu_discovery_read_binary_from_mem(struct amdgpu_device *adev,
>   			msleep(1);
>   		}
>   	}
> -	vram_size = (uint64_t)RREG32(mmRCC_CONFIG_MEMSIZE) << 20;
> +	for (i = 0; i < 100; i++) {
> +		vram_size = (uint64_t)RREG32(mmRCC_CONFIG_MEMSIZE) << 20;
> +		if (vram_size)
> +			break;
> +		usleep_range(1000, 1100);
> +	}

Nice that we come closer to a solution for this, but that here is really 
hacky.

Do we have any idea why mmRCC_CONFIG_MEMSIZE is zero when we re-scan? Is 
some initialization not completed yet or something like that.

Regards,
Christian.

>   
>   	if (vram_size) {
>   		uint64_t pos = vram_size - DISCOVERY_TMR_OFFSET;
> @@ -371,6 +376,7 @@ static int amdgpu_discovery_init(struct amdgpu_device *adev)
>   {
>   	struct table_info *info;
>   	struct binary_header *bhdr;
> +	int error_count = 0;
>   	uint16_t offset;
>   	uint16_t size;
>   	uint16_t checksum;
> @@ -380,7 +386,7 @@ static int amdgpu_discovery_init(struct amdgpu_device *adev)
>   	adev->mman.discovery_bin = kzalloc(adev->mman.discovery_tmr_size, GFP_KERNEL);
>   	if (!adev->mman.discovery_bin)
>   		return -ENOMEM;
> -
> +retry:
>   	/* Read from file if it is the preferred option */
>   	if (amdgpu_discovery == 2) {
>   		dev_info(adev->dev, "use ip discovery information from file");
> @@ -401,6 +407,10 @@ static int amdgpu_discovery_init(struct amdgpu_device *adev)
>   
>   	/* check the ip discovery binary signature */
>   	if (!amdgpu_discovery_verify_binary_signature(adev->mman.discovery_bin)) {
> +		if (error_count++ < 1) {
> +			msleep(100);
> +			goto retry;
> +		}
>   		dev_err(adev->dev,
>   			"get invalid ip discovery binary signature\n");
>   		r = -EINVAL;
> @@ -515,7 +525,6 @@ static int amdgpu_discovery_init(struct amdgpu_device *adev)
>   	if (0 && offset) {
>   		struct mall_info_header *mhdr =
>   			(struct mall_info_header *)(adev->mman.discovery_bin + offset);
> -
>   		if (le32_to_cpu(mhdr->table_id) != MALL_INFO_TABLE_ID) {
>   			dev_err(adev->dev, "invalid ip discovery mall table id\n");
>   			r = -EINVAL;

