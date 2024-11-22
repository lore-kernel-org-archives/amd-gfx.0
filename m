Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52E5AE65D3F
	for <amd-gfx@archiver.kernel.org>; Fri, 22 Nov 2024 10:03:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0A50410EB31;
	Fri, 22 Nov 2024 10:03:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="L9Ea64SX";
	dkim-atps=neutral
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com
 [209.85.128.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 10B1410EB39
 for <amd-gfx@lists.freedesktop.org>; Fri, 22 Nov 2024 10:03:51 +0000 (UTC)
Received: by mail-wm1-f42.google.com with SMTP id
 5b1f17b1804b1-4315e9e9642so16658495e9.0
 for <amd-gfx@lists.freedesktop.org>; Fri, 22 Nov 2024 02:03:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1732269829; x=1732874629; darn=lists.freedesktop.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=ki5weQUi6RmRZoShAl6Gl33rIP1+7UfSamIHpnMLfcs=;
 b=L9Ea64SXW6P/2bVtxTdh/OyFydfOYFjkL13+DL4/UBhHGApxkP+rQRoG/fNYzihTxA
 KHzko5SYy4qIOFxhMnAefVd0LBWTRtauiFzRNz/tKHKFqpye5kxXtRYHPpcomkhL56CK
 txbBKXxOZwB1fqE0im9I03TAhxdhNEzHNCmbNN5B40jCS8gcltnNnzx8nfLvJFwE8M4G
 Q5GiBnoHoABr4Ztiv4uZENZnePdU1y8SjseMKyTAy50D5Unm0CPCPwe5VpWEpnQX7dHg
 KSbD5rg3yk84LLTc5BP3qhuqURA8VJocu47VQl11VV+cgpRAjjsXEEozaMwkELrJM7Xb
 qs+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732269829; x=1732874629;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ki5weQUi6RmRZoShAl6Gl33rIP1+7UfSamIHpnMLfcs=;
 b=DYXSzhnJuo4/ZRf0vkr1gg+LzICzXroWzb88eNW9lYF083C6aDEQ4BR/PQrkIY0Myt
 omTdGjap6BZV6U/qhnOmc8HUqf/V5z+iuZuYBcuHxQP/UYBpsV96nMaQGBysZ+SLHqQa
 UlPgPgUbXuK0WLYbhLoirqUSaWEjxAZYRyiVs8v0x7c/zPqfYT6Xi+ErculZ7OXHYeQF
 r5ucnDSQJaVBDoaF15pSbc01WUeFFEa5Ru4z2gO1sNkiAW8Zsh5j1W7EnVTkhHXzImRa
 VTf8XGfI7Jtqwa2HlgUk37X3ACqupW1nxHnQfw1/AbgUpqezMfRUx5lpvXzKOl1IGhm1
 5rww==
X-Forwarded-Encrypted: i=1;
 AJvYcCWcSKcfT1AW+q+Hxk7FcFXn9w08nJtj9MGQSZSIgityp1Zv4EafDj0sil8rWUObJgc/f7n4rEWB@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yy1pKiV4cfb+P8q40joVvhiPFvcByf9P71wQDe69c2mw1T/jzyE
 sQuUnTqQJTHPAbB+3IkdXgRctuHn9qmuB9KWqGNE6D6ELsVvGXHp
X-Gm-Gg: ASbGncuP//96Er3kHDMNZqN19UajwbOQiOZU559c3RlPAy5l3KNTlMz5Rvi+EZ/qg1v
 QaYgy2SV15AOfQKKXXnHGnScV8AAkA8hCsGjKnFoMqcXOwZfsRnaAMUJs2V2kSu1TQspaRtpq/w
 4/+iYcYihSh1pGlRg3MZfwnuTldYOHO2wvghRqJTsfEmpXcgqxe/cj352HE2m/SMAqGDs9lV5cQ
 0G0kdG+rV8oqRFWWFytWZOZPK/lIRd9wsB+oXXngZlFRRUM3lDVCClLbyUJpa6IIm9QYLJvEO+6
 SkI=
X-Google-Smtp-Source: AGHT+IFZLqor4dHwVaTLwmFOLGRoPML8arv2r7Lq45bPkQhuyVX5Uh3Oe6OTpFozwBMCAf+11+/Fkg==
X-Received: by 2002:a5d:5f4f:0:b0:382:4bc1:8f03 with SMTP id
 ffacd0b85a97d-38260be3c72mr1737479f8f.49.1732269828676; 
 Fri, 22 Nov 2024 02:03:48 -0800 (PST)
Received: from [10.254.108.83] (munvpn.amd.com. [165.204.72.6])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3825fb25d74sm1980450f8f.47.2024.11.22.02.03.47
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 22 Nov 2024 02:03:48 -0800 (PST)
Message-ID: <27b016a8-57e6-4ab2-ab5f-fafe1086e437@gmail.com>
Date: Fri, 22 Nov 2024 11:03:44 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amd: Add Suspend/Hibernate notification callback
 support
To: Mario Limonciello <mario.limonciello@amd.com>,
 amd-gfx@lists.freedesktop.org, Alex Deucher <Alexander.Deucher@amd.com>
References: <20241118200323.16541-1-mario.limonciello@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>
In-Reply-To: <20241118200323.16541-1-mario.limonciello@amd.com>
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

Am 18.11.24 um 21:03 schrieb Mario Limonciello:
> As part of the suspend sequence VRAM needs to be evicted on dGPUs.
> In order to make suspend/resume more reliable we moved this into
> the pmops prepare() callback so that the suspend sequence would fail
> but the system could remain operational under high memory usage suspend.
>
> Another class of issues exist though where due to memory fragementation
> there isn't a large enough contiguous space and swap isn't accessible.
>
> Add support for a suspend/hibernate notification callback that could
> evict VRAM before tasks are frozen. This should allow paging out to swap
> if necessary.
>
> Link: https://github.com/ROCm/ROCK-Kernel-Driver/issues/174
> Link: https://gitlab.freedesktop.org/drm/amd/-/issues/3476
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>

I'm absolutely not an expert on that stuff but it looks rather 
reasonable to me.

Alex what do you think?

Regards,
Christian.

> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu.h        |  1 +
>   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 36 ++++++++++++++++++++++
>   2 files changed, 37 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> index a37e687acbbc5..e70ca85151046 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> @@ -885,6 +885,7 @@ struct amdgpu_device {
>   	bool				need_swiotlb;
>   	bool				accel_working;
>   	struct notifier_block		acpi_nb;
> +	struct notifier_block		pm_nb;
>   	struct amdgpu_i2c_chan		*i2c_bus[AMDGPU_MAX_I2C_BUS];
>   	struct debugfs_blob_wrapper     debugfs_vbios_blob;
>   	struct debugfs_blob_wrapper     debugfs_discovery_blob;
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> index b3ca911e55d61..5a4e9c7daf895 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -190,6 +190,8 @@ void amdgpu_set_init_level(struct amdgpu_device *adev,
>   }
>   
>   static inline void amdgpu_device_stop_pending_resets(struct amdgpu_device *adev);
> +static int amdgpu_device_pm_notifier(struct notifier_block *nb, unsigned long mode,
> +				     void *data);
>   
>   /**
>    * DOC: pcie_replay_count
> @@ -4582,6 +4584,11 @@ int amdgpu_device_init(struct amdgpu_device *adev,
>   
>   	amdgpu_device_check_iommu_direct_map(adev);
>   
> +	adev->pm_nb.notifier_call = amdgpu_device_pm_notifier;
> +	r = register_pm_notifier(&adev->pm_nb);
> +	if (r)
> +		goto failed;
> +
>   	return 0;
>   
>   release_ras_con:
> @@ -4646,6 +4653,8 @@ void amdgpu_device_fini_hw(struct amdgpu_device *adev)
>   		drain_workqueue(adev->mman.bdev.wq);
>   	adev->shutdown = true;
>   
> +	unregister_pm_notifier(&adev->pm_nb);
> +
>   	/* make sure IB test finished before entering exclusive mode
>   	 * to avoid preemption on IB test
>   	 */
> @@ -4777,6 +4786,33 @@ static int amdgpu_device_evict_resources(struct amdgpu_device *adev)
>   /*
>    * Suspend & resume.
>    */
> +/**
> + * amdgpu_device_pm_notifier - Notification block for Suspend/Hibernate events
> + * @nb: notifier block
> + * @mode: suspend mode
> + * @data: data
> + *
> + * This function is called when the system is about to suspend or hibernate.
> + * It is used to evict resources from the device before the system goes to
> + * sleep while there is still access to swap.
> + *
> + */
> +static int amdgpu_device_pm_notifier(struct notifier_block *nb, unsigned long mode,
> +				     void *data)
> +{
> +	struct amdgpu_device *adev = container_of(nb, struct amdgpu_device, pm_nb);
> +
> +	switch (mode) {
> +	case PM_HIBERNATION_PREPARE:
> +	case PM_SUSPEND_PREPARE:
> +		if (amdgpu_device_evict_resources(adev))
> +			return NOTIFY_BAD;
> +		break;
> +	}
> +
> +	return NOTIFY_DONE;
> +}
> +
>   /**
>    * amdgpu_device_prepare - prepare for device suspend
>    *

