Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3D43C25B75
	for <amd-gfx@archiver.kernel.org>; Mon, 13 May 2024 11:41:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 66B3310E6BE;
	Mon, 13 May 2024 11:41:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="FY5Nl/yr";
	dkim-atps=neutral
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com
 [209.85.128.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E0ED410E6BD
 for <amd-gfx@lists.freedesktop.org>; Mon, 13 May 2024 11:41:10 +0000 (UTC)
Received: by mail-wm1-f45.google.com with SMTP id
 5b1f17b1804b1-4200ee78f33so14841985e9.3
 for <amd-gfx@lists.freedesktop.org>; Mon, 13 May 2024 04:41:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1715600469; x=1716205269; darn=lists.freedesktop.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=m3MUZ6WdVvy1iuCNTosZUy/hPgPwUgxjgJTZ18/9eFQ=;
 b=FY5Nl/yrdh29Tv3jVKyPvPJEYRxhAlzz3qsjxfoTTAvhhQa1JR/xqeaCdQpWmUkSpE
 rKD7Vkq8Pa6vEPzvYjKOwnoQ3nXn5bngdN/1HufC8CrxKwkdnrtZpwfYB5xanSfo1civ
 69WXIBAxg30r2TIXpXQr4jUEK6Knp6FBEwSDIBUoRgKNx369156vjPtgqAMqIYAYQAQY
 ZH64leqABfcoYubsdFeIIG2aAhmXmO3A8WBb8phbOsh6+sCWiVAW/GfkzFkaxZz+zJ07
 WLPn2lC7Tivzyf9ijjiFvz3JyNH5toO9QZqaHY8dCP91LzSMCgDXs00pET9hN5coOUY8
 3y7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715600469; x=1716205269;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=m3MUZ6WdVvy1iuCNTosZUy/hPgPwUgxjgJTZ18/9eFQ=;
 b=eEpSh8DR5/KaKGDVoSGVad8Ka0rDG0a+q/7Er1WojGK6YpQo8Z/PzS5J/CoHVyjkyb
 l+q+ZLZipB/t+r6h3iafxvTj5ypEAYWYvNP0AXCdwy//IrSDxSn/ubSUV8B6aU/DQc2Y
 5PtuzPhsyBmx7t5b8XA+uVbRs9Veq9PAP5wLoyJp8zlXWcCiemKM5k7TcsgYKDGij1iw
 l46lHtntpQgofqzmkCpkGsdCS2a4h6kMU3mu0WZv5GBv4qaDrdhQO3ckWT8AR2XmJ53l
 VrTxwp/j4ZlxSj2FpP3seHj3rlaM63akI8zCMBcAjAwrafpxv5w21BDKNAPDz7b2IwWl
 YgQw==
X-Forwarded-Encrypted: i=1;
 AJvYcCU8nV68hI6UOg2a8u2chn4s3dNsV9lBNXwpxK3DkxsaaLROm2oGQtL3APU31gO3XumAAGr9s3u/kvQ61MjhUxz0flueKe5Gu4bgbZlWfQ==
X-Gm-Message-State: AOJu0Yx1DHIEMUCUsuiIALuNOmqQJGFZeypYS72IBsnEgnFhuakLfwYF
 qyT6BjlWTX3OtvIASXNUGP4GFu/WC/oEAPm0SQ26HjVyRwia9154pkoyiEV7
X-Google-Smtp-Source: AGHT+IEn8Xvb/EvQsX2Vm32RqOWf9mCKA4NmCfu5YH3A7TTY4PBER30kJ4RoUOiEnrPzgRAJpQgGmA==
X-Received: by 2002:a05:600c:314e:b0:418:3eb7:e8c6 with SMTP id
 5b1f17b1804b1-41fea927e69mr82008065e9.5.1715600468704; 
 Mon, 13 May 2024 04:41:08 -0700 (PDT)
Received: from [10.254.108.81] (munvpn.amd.com. [165.204.72.6])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4200e518984sm88259175e9.23.2024.05.13.04.41.07
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 13 May 2024 04:41:08 -0700 (PDT)
Message-ID: <1a0b28c7-0b01-4e8e-ae8b-8eb297da1e05@gmail.com>
Date: Mon, 13 May 2024 13:41:05 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/22] drm/amdgpu: fix dereference after null check
To: Jesse Zhang <jesse.zhang@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Alexander.Deucher@amd.com, Christian Koenig <christian.koenig@amd.com>,
 Tim.Huang@amd.com
References: <20240510025038.3488381-1-jesse.zhang@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>
In-Reply-To: <20240510025038.3488381-1-jesse.zhang@amd.com>
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

Am 10.05.24 um 04:50 schrieb Jesse Zhang:
> check the pointer hive before use.
>
> Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> index 77f6fd50002a..00fe3c2d5431 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -5725,7 +5725,7 @@ int amdgpu_device_gpu_recover(struct amdgpu_device *adev,
>   	 * to put adev in the 1st position.
>   	 */
>   	INIT_LIST_HEAD(&device_list);
> -	if (!amdgpu_sriov_vf(adev) && (adev->gmc.xgmi.num_physical_nodes > 1)) {
> +	if (!amdgpu_sriov_vf(adev) && (adev->gmc.xgmi.num_physical_nodes > 1) && hive) {

That solution looks not optimal to me.

Checking adev->gmc.xgmi.num_physical_nodes > 1 already makes sure that 
hive shouldn't be NULL.

If automated checkers complain about that we should probably drop the 
adev->gmc.xgmi.num_physical_nodes > 1 check and check for hive instead.

Regards,
Christian.

>   		list_for_each_entry(tmp_adev, &hive->device_list, gmc.xgmi.head) {
>   			list_add_tail(&tmp_adev->reset_list, &device_list);
>   			if (adev->shutdown)

