Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE25BCD3431
	for <amd-gfx@archiver.kernel.org>; Wed,  4 Sep 2024 12:48:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 665AE10E79F;
	Wed,  4 Sep 2024 12:48:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="PrDj8uJe";
	dkim-atps=neutral
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com
 [209.85.221.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8270310E79F
 for <amd-gfx@lists.freedesktop.org>; Wed,  4 Sep 2024 12:48:04 +0000 (UTC)
Received: by mail-wr1-f43.google.com with SMTP id
 ffacd0b85a97d-371ba7e46easo4339610f8f.0
 for <amd-gfx@lists.freedesktop.org>; Wed, 04 Sep 2024 05:48:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1725454083; x=1726058883; darn=lists.freedesktop.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=1XuxBaniMpbgpF5D4a/BY88FdPJOQl9eBJl8qbmkANk=;
 b=PrDj8uJeNwEKx7RgE0iEuAIu79WruCPRA0UIMJpS9VyNk3kpH2KU/OQ9oRxe6HZlWK
 IdZgZFpiCGkZ+zohfJ0HGtbB/FY5RhZ2RBXWzAZ1PKM8Vg+oq82pDaJ0bkGES8fgiET7
 nV5iVjM5x0YbUdK//4nmIC4e/HjRrNoCaW2e4gBQ4ESFpdIlSzp/nk71eohBmUz7DgWc
 Na/wEa2Wlk5a8hENFDcnrFt2ACJbV2+gTCRIajnl55eK/urOEp6eBpsQy1OrvnYGcGoa
 ZN5jlTLwia7Qn5cTmsEesb8d3QUHQ2XmAM3OGDoV7sg1GGVhPYWO3e0XcUqAvMfgrb02
 dAmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725454083; x=1726058883;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=1XuxBaniMpbgpF5D4a/BY88FdPJOQl9eBJl8qbmkANk=;
 b=KAQlNtHyAYSi1b3pwfgCxSUhkZFwh4WcNIj0/sSXNrdO7l9EVI1SEp/BDLFM9zFyi8
 8aOj+V4aNLcOWwZDVT/4so9ZJUVq4KdmpghGoP2sb4dboaFa17q22N4X9nphZkkNG0yr
 A5Hz3yPK7MnoqUfMOYKygrWLkdggQExIXywkN+ILJlrCIvUH7VJfJAnDZ7rPcoaq/dRp
 mIZC81s5Vf8sm45E3k/s+lI04JSxY9l/h1FdusDAVjlilvKyrembRiNgUCi+6ieKR8oX
 VuaY/3rYkF3gGIaAsMa7kUYxT4OSJ2I+ucnOGfdRmeQUoJXkkAnY1kRWBiixfL2xmYRw
 qAMw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWyZf2fhML9zxjSpvHvkizWPXktWoREZjT34L6g9GrBTMTqwMAOUoBsxHRKaNcoRUVUywsyeSSN@lists.freedesktop.org
X-Gm-Message-State: AOJu0Ywu+wvgi1j377FPnGqaLVGBHNvM0auYjsQEBJ1nHYSNvVLCJ2r4
 KXKOPQDHH8Joa0vJdfByTjESHUnVSrbQAB6jU3bMq0g2HaxHyseK
X-Google-Smtp-Source: AGHT+IHIQHRaN0/hTOAyKdjgHmqgLzddXxyrgTTF5M0CbrVryDnaYMEv0whtfFMb0A7l5d1q0Yh/cA==
X-Received: by 2002:adf:978a:0:b0:371:8af5:473d with SMTP id
 ffacd0b85a97d-374bce98c9cmr9223578f8f.12.1725454081878; 
 Wed, 04 Sep 2024 05:48:01 -0700 (PDT)
Received: from [10.254.108.81] (munvpn.amd.com. [165.204.72.6])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3749ee4abbesm16892604f8f.23.2024.09.04.05.48.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 04 Sep 2024 05:48:01 -0700 (PDT)
Message-ID: <5086fe54-5e8d-4869-afd7-1cbc7d69edbc@gmail.com>
Date: Wed, 4 Sep 2024 14:47:59 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/10] Support XGMI reset on init
To: Lijo Lazar <lijo.lazar@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Hawking.Zhang@amd.com, Alexander.Deucher@amd.com, Christian.Koenig@amd.com
References: <20240902073417.2025971-1-lijo.lazar@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>
In-Reply-To: <20240902073417.2025971-1-lijo.lazar@amd.com>
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

Am 02.09.24 um 09:34 schrieb Lijo Lazar:
> There are case where a device needs to be reset first before it is fully
> initialized. An example case is a driver reinstallation with a different version
> of PSP TOS. In such a case, if a device supports reset in which PSP TOS is
> unloaded, then driver needs to reset device first and then load the new firmware
> components.
>
> For devices in an XGMI hive, a reset needs to be sent on all devices in the
> hive. Thus driver should discover first devices that belong to a hive with
> PSP support.
>
> There is an existing delayed reset handler, however it has the below
> limitations-
> 1) It doesn't discover devices in the hive, instead it tries to do XGMI reset
> for all devices registered to mgpu struct. mgpu struct may have other devices
> than the one which belong to a hive. Also, if there is more than one hive, it
> doesn't work.
> 2) It doesn't take a reset lock and since this is a delayed reset, that could
> result in unwanted hardware accesses during a reset.
> 3) It doesn't initialize RAS properly (left as TODO)
>
> This series overcomes the above limitations. Instead of marking a pending reset,
> init levels are defined where the level of initialization may be defined. In
> case of a pending reset, only specific hardware blocks may be initialized.
>
> Further work (not done in this series) may be done to have fine grain controls
> for init levels - say skip enabling features like DPM enablement, or skip
> loading specific set of fimwares as they won't be required during a minimal init
> scenario where device is going to be reset.
>
> The series adds an API interface to check if a PSP TOS reload is required.

At least from the high level that sounds totally sane, but I have no 
idea where to get time from to review the details.

I need to discuss that with Alex and/or Tim. Maybe I can delegate some 
more work.

Christian.

>
>
> Lijo Lazar (10):
>    drm/amdgpu: Add init levels
>    drm/amdgpu: Use init level for pending_reset flag
>    drm/amdgpu: Separate reinitialization after reset
>    drm/amdgpu: Add reset on init handler for XGMI
>    drm/amdgpu: Add helper to initialize badpage info
>    drm/amdgpu: Refactor XGMI reset on init handling
>    drm/amdgpu: Drop delayed reset work handler
>    drm/amdgpu: Support reset-on-init on select SOCs
>    drm/amdgpu: Add interface for TOS reload cases
>    drm/amdgpu: Add PSP reload case to reset-on-init
>
>   drivers/gpu/drm/amd/amdgpu/aldebaran.c        |   1 +
>   drivers/gpu/drm/amd/amdgpu/amdgpu.h           |  21 +-
>   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c    | 245 +++++++++++-------
>   drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c       |  81 ------
>   drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h       |   1 -
>   drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c       |  13 +
>   drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h       |   3 +
>   drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c       |  62 +++--
>   drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h       |   4 +-
>   drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c     | 148 +++++++++++
>   drivers/gpu/drm/amd/amdgpu/amdgpu_reset.h     |   4 +
>   drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c      |  72 ++++-
>   drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.h      |   2 +
>   drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c         |  14 +-
>   drivers/gpu/drm/amd/amdgpu/psp_v13_0.c        |  25 ++
>   drivers/gpu/drm/amd/amdgpu/soc15.c            |   7 +
>   .../gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c    |   3 +-
>   17 files changed, 492 insertions(+), 214 deletions(-)
>

