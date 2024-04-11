Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 452ADCD1284
	for <amd-gfx@archiver.kernel.org>; Thu, 11 Apr 2024 09:35:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9002D10EFA4;
	Thu, 11 Apr 2024 09:34:59 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="iwN5BKDB";
	dkim-atps=neutral
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com
 [209.85.128.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 226D110EFA9
 for <amd-gfx@lists.freedesktop.org>; Thu, 11 Apr 2024 09:34:56 +0000 (UTC)
Received: by mail-wm1-f41.google.com with SMTP id
 5b1f17b1804b1-416b5f6813cso24618295e9.0
 for <amd-gfx@lists.freedesktop.org>; Thu, 11 Apr 2024 02:34:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1712828094; x=1713432894; darn=lists.freedesktop.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=qy3MB+Be3yawVvbWnNo1Kgk7RaEJfRYzkLQyXHGcafI=;
 b=iwN5BKDBKmbKR6AQOfHJ+jLyT2oxB338lRMsIPDvv0ZvRb12diFrFdTU0YD2E27qPU
 Tvq2/jlwAM2qlhNFc30F18ubkx+OYTISGnzMjtAb3Jmpk8TWidrultK90m6O3XCLL90x
 s21NhmOHd81As+TIGn4W3Jcxn6c0glXtu8MPIRZ7bJiLUYjRHdwKa86AS43k0EoaU54A
 /JedhGfPU4f0/nuYvnkhvF7sN4jQIdGUdzgrrcWRh5akJG/0iRfFBV+OcSQNzTsCxqAW
 c9CTwzXckjOyPNLtOwjqPkvRtDxGJr+n8Ry8J9KbgpG3ta7ndUzfJA1TaQmANT0LfJYh
 /9+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712828094; x=1713432894;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=qy3MB+Be3yawVvbWnNo1Kgk7RaEJfRYzkLQyXHGcafI=;
 b=PzH9Zn0QVvDEuPUoUqAKnDv69Ra/2MslsByIzNat9g0jMX9ly9hE1eq/AsPeGn5sG2
 l3A4VpRKoKOOK8VJNykC6Y4ygEHlFkJ15cMQrBWfjcd1SV1ct8zAiv3sWkGLP7L7NarQ
 Kg8Omc6TSLcPZun1U8Gu0ck7oCaekAUzRDnEvV8M3f9zJivfSyiHMkaF+IR9EAc5ul8F
 OZqjV3QxPxiHFGZcfcHFJUP4J1TbZNTfaZqwMAq+sff04Eqb01+CZrIEikec8uroNTrL
 jJgvrgY2Yv6YSitIZ+itMl1+rUz87btkmBMHyXi7T12iHuTp1yuEurJcWKDKMTmtvczY
 +XAA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWgVkr98RxJLr3rwMTO5OQTukwmHrvXCOAY9qf7EiWdM1p/aNDAifhtP/whiyGxNLclht5+l4MRahPoAxgdLJyn8d6dFJtvB7C0FwZzRw==
X-Gm-Message-State: AOJu0YwXJxSFlObhHw/dn9Qdx0zniMdNEadfNHTRamuETtES3iXBxnsi
 VB22M54OGMG7knPLc7GlshIa7FMx6AO/k4Qi3t7XQ/EbPJawDMGh
X-Google-Smtp-Source: AGHT+IEwMwJp59luuXIrDxifAFjJmbTS1wPJvveRUlaqsLpYQQG2cQBukCMafaFcrKB1ClBk8RxpcQ==
X-Received: by 2002:a05:600c:3b9c:b0:416:8efd:1645 with SMTP id
 n28-20020a05600c3b9c00b004168efd1645mr5076435wms.7.1712828094104; 
 Thu, 11 Apr 2024 02:34:54 -0700 (PDT)
Received: from [10.254.108.81] (munvpn.amd.com. [165.204.72.6])
 by smtp.gmail.com with ESMTPSA id
 r19-20020a05600c321300b004167b0819aasm6487826wmp.0.2024.04.11.02.34.53
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 11 Apr 2024 02:34:53 -0700 (PDT)
Message-ID: <b62e7fca-cc49-42a3-90e1-e0feef8ca794@gmail.com>
Date: Thu, 11 Apr 2024 11:34:52 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: set vm_update_mode=0 as default for NV32 in
 SRIOV case
To: Danijel Slivka <danijel.slivka@amd.com>, amd-gfx@lists.freedesktop.org,
 "Kuehling, Felix" <Felix.Kuehling@amd.com>, "Lazar, Lijo"
 <Lijo.Lazar@amd.com>
References: <20240327233452.811939-1-danijel.slivka@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>
In-Reply-To: <20240327233452.811939-1-danijel.slivka@amd.com>
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

Am 28.03.24 um 00:34 schrieb Danijel Slivka:
> For asic with VF MMIO access protection avoid using CPU for VM table updates.
> CPU pagetable updates have issues with HDP flush as VF MMIO access protection
> blocks write to BIF_BX_DEV0_EPF0_VF0_HDP_MEM_COHERENCY_FLUSH_CNTL register
> during sriov runtime.

Well big NAK to the reasoning. HDP flush is *mandatory* to work correctly.

This not only includes flushes for CPU based VM updates, but also GART 
updates.

Without reliable HDP flushes the driver is simply not stable.

Regards,
Christian.

>
> Signed-off-by: Danijel Slivka <danijel.slivka@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
> index aed60aaf1a55..a3012c9aa92b 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
> @@ -724,7 +724,8 @@ void amdgpu_detect_virtualization(struct amdgpu_device *adev)
>   			adev->virt.caps |= AMDGPU_PASSTHROUGH_MODE;
>   	}
>   
> -	if (amdgpu_sriov_vf(adev) && adev->asic_type == CHIP_SIENNA_CICHLID)
> +	if ((amdgpu_sriov_vf(adev) && adev->asic_type == CHIP_SIENNA_CICHLID) ||
> +		adev->pdev->device == 0x7461)
>   		/* VF MMIO access (except mailbox range) from CPU
>   		 * will be blocked during sriov runtime
>   		 */

