Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B3C2CD98CF
	for <amd-gfx@archiver.kernel.org>; Mon, 15 Jun 2026 14:32:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CC2F210E385;
	Mon, 15 Jun 2026 14:32:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=ursulin.net header.i=@ursulin.net header.b="Aww+vG10";
	dkim-atps=neutral
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com
 [209.85.208.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A6FB210E385
 for <amd-gfx@lists.freedesktop.org>; Mon, 15 Jun 2026 14:32:26 +0000 (UTC)
Received: by mail-ed1-f49.google.com with SMTP id
 4fb4d7f45d1cf-691c5776f35so5471682a12.3
 for <amd-gfx@lists.freedesktop.org>; Mon, 15 Jun 2026 07:32:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ursulin.net; s=google; t=1781533945; x=1782138745; darn=lists.freedesktop.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=1zBy4KBsoDr53mdfpAO79sZEDsEyooVRZmtn+x1iGNo=;
 b=Aww+vG10pbK06dK2OmGvJF+jGiPzYok5cwgoKHKBbs5S6VO1YDl8elQI9k6j4D/oDA
 05Fe8fO2MlFl0+aU7xdDn9Hwzm9iJFq6oBbT7BSm4Nksxlnm8EydJWJ9pvwebh/4n1As
 oo1GmhAm7y9043h2qeGu3aU8NVWWrz9uYRoR1nlNpuEMwnkrwBkna0C5/5t1LMPnJafN
 bQ+db4xQ6vnKy6cXgcyrEc5JuPbDD62miCSoTBQHKJy7zgFO1i8MLoFYdKvKvMw++Rlu
 6T8O9bZl066mOuvry0oYU8dfer2ZKl9M1LoGfyhLWMXILD03wfdIxMDkzfO/BeIjDLsu
 6jpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781533945; x=1782138745;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=1zBy4KBsoDr53mdfpAO79sZEDsEyooVRZmtn+x1iGNo=;
 b=T2/4NizTP2t8X+zQGpIKTpNky38BGvXan6OXlExUqEN95ELK8zawB5jmqBZO7b1Kxy
 X1htCdZ+XdjiUgpgfb/MOsarz73g2P7fDkmSRFTJiigsXiZsS0mlLYE6rusj9OyPK40c
 5VhidZ1YXoDvs9tWN6GLyjakKYbZ11q2ycgxwjIdUTavZkvZII7wuXfyP+QjrSI9UbTN
 6mom7zDSbHU6jhoNKLSC7dsNfaI3SRlXaGfGTL8veOuas4g0hpNhwKK0PtzeYXF6FB9u
 9sJ+1Ehz7gAdpnPkD9/BFW1pzJmVttDbb1oIz+N6PgjDT5reXAsMLFn40a9OazPJk3Xh
 adSw==
X-Forwarded-Encrypted: i=1;
 AFNElJ+HcykdES80eeO+OPCO1V68dfKDtmSieasgAjR2eQRkoYG9/lnMZZi6TDNf/qP6g7Hvmofi1ljz@lists.freedesktop.org
X-Gm-Message-State: AOJu0Ywmje9QgEh4haONdtaGKdsmAQ5mPd+VevxXDiEnttna6884uI1p
 mbNrCWJxKQh4Xmph01AMFtco8J//ASkZRb+XFGVcdhSQx70SfNagmjS4Jz0Kw8EW+yIB3bdFkcq
 poi3pNzU=
X-Gm-Gg: Acq92OH7wUCc987TqCDwgg/1VaT7caexOpZ05nMCFzY9NAl2N9RzgXWSuKNFMInmtLp
 zCsTQ9vAvnwJXGdON0O+YztA5vlkhUg1jC5SUChw83+SIQl6Izs0V12BQaA03QVUvKyH/qGcLxY
 bcYmXw7s0uNxnH97C6nqszCs64X01G/MpAdq2jTqTnjgvIMDAeIlvxRFYk/KPbjq45e1rfmci9/
 M6wE6x5SA+JaziV+/7aLozasqjC4tsuBBoND1z+eO2y4hY22/wIeh65SH5mBuDxmHgT27AKpbIJ
 uVnLf3ozScMQOkJHCpkoSLUZ1XopbWgYAc9zDyMyhCrcWDhsLfUWPDiuEJMwcE27Gv/TaFyDwi1
 E2LKJ46PIJhEoqdpXvG80smyn2QlPjLGwEOYCQ/hGQPVHeq/UQ0fTq07+WmWDIDikS1l9LJKoXn
 mgpn+6ediERL5mO5eEjb6Tw94G+uDeqdNIk15vb89zzX4e
X-Received: by 2002:a05:6402:5201:b0:68d:9272:d0a8 with SMTP id
 4fb4d7f45d1cf-693c6b9fd10mr4204133a12.13.1781533944880; 
 Mon, 15 Jun 2026 07:32:24 -0700 (PDT)
Received: from [192.168.0.116] ([90.240.106.137])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-6937919b4c4sm3561257a12.6.2026.06.15.07.32.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 15 Jun 2026 07:32:24 -0700 (PDT)
Message-ID: <fc23a624-650b-40b3-8de2-07d4a44ff603@ursulin.net>
Date: Mon, 15 Jun 2026 15:32:23 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/7] drm/amdgpu/gmc: Don't compare page fault timestamps
 with other interrupts
To: =?UTF-8?Q?Timur_Krist=C3=B3f?= <timur.kristof@gmail.com>,
 amd-gfx@lists.freedesktop.org, Alex Deucher <alexander.deucher@amd.com>,
 christian.koenig@amd.com, Natalie Vock <natalie.vock@gmx.de>,
 Mario Limonciello <mario.limonciello@amd.com>,
 Amir Shetaia <Amir.Shetaia@amd.com>, =?UTF-8?B?TWFyZWsgT2zFocOhaw==?=
 <maraeo@gmail.com>
References: <20260525114507.24566-1-timur.kristof@gmail.com>
 <20260525114507.24566-4-timur.kristof@gmail.com>
Content-Language: en-GB
From: Tvrtko Ursulin <tursulin@ursulin.net>
In-Reply-To: <20260525114507.24566-4-timur.kristof@gmail.com>
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
> Different interrupts may have different timestamp sources,
> which shouldn't be compared.
> 
> If we compare the timestamps of retry faults to timestamps
> of other interrupts, it may result in all retry fault
> interrupts being filtered out, because of the different
> time stamp source.
> 
> This issue was observed on Strix Halo.
> Solved by storing the timestamp of the last page fault interrupt.

This one may require access to AMD docs to review. For example I am 
immediately curious as to how many different clock sources on a single 
IH there are, how does that relate to the timestamp_src field, and if 
there are indeed multiple clock domains should the patch perhaps be 
generalized to something like 
ih->processed_timestamp[entry->timestamp_src] or something?

Regards,

Tvrtko

> 
> Signed-off-by: Timur Kristóf <timur.kristof@gmail.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c | 5 ++++-
>   drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h | 1 +
>   2 files changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
> index 13bec8461cde..52258f1341c2 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
> @@ -437,9 +437,12 @@ bool amdgpu_gmc_filter_faults(struct amdgpu_device *adev,
>   	uint32_t hash;
>   
>   	/* Stale retry fault if timestamp goes backward */
> -	if (amdgpu_ih_ts_after(timestamp, ih->processed_timestamp))
> +	if (timestamp == adev->gmc.processed_fault_timestamp ||
> +		amdgpu_ih_ts_after(timestamp, adev->gmc.processed_fault_timestamp))
>   		return true;
>   
> +	adev->gmc.processed_fault_timestamp = MAX(timestamp, adev->gmc.processed_fault_timestamp);
> +
>   	/* If we don't have space left in the ring buffer return immediately */
>   	stamp = max(timestamp, AMDGPU_GMC_FAULT_TIMEOUT + 1) -
>   		AMDGPU_GMC_FAULT_TIMEOUT;
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
> index 676e3aaa1f27..77eb15380284 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
> @@ -361,6 +361,7 @@ struct amdgpu_gmc {
>   
>   	u64 noretry_flags;
>   	u64 init_pte_flags;
> +	u64 processed_fault_timestamp;
>   
>   	bool flush_tlb_needs_extra_type_0;
>   	bool flush_tlb_needs_extra_type_2;

