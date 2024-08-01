Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1DD70C3DA64
	for <amd-gfx@archiver.kernel.org>; Thu,  1 Aug 2024 11:52:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A6E4F10E916;
	Thu,  1 Aug 2024 11:52:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="c6HInv0x";
	dkim-atps=neutral
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com
 [209.85.128.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0F6DC10E916
 for <amd-gfx@lists.freedesktop.org>; Thu,  1 Aug 2024 11:52:01 +0000 (UTC)
Received: by mail-wm1-f51.google.com with SMTP id
 5b1f17b1804b1-428243f928cso23511515e9.3
 for <amd-gfx@lists.freedesktop.org>; Thu, 01 Aug 2024 04:52:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1722513119; x=1723117919; darn=lists.freedesktop.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=a+eCeYakE+bjA/0RwiufcTnt1kCEeuPWytnlcRqyR2E=;
 b=c6HInv0x3IwjxS2hQFmMT8jn32d3CyTcOK/r2Jo5czCWKvcD2te7EgudwxPhgsKPWa
 O4pZcITH31Ty6EYn2ZoWSSf7lsG8dFLmpZpJtDnaq1RvFhAmT7hK3JML5lPogJb1IN8D
 WxDtp4UZkhQMvseJap87XNxAKedMcfFxSc6g729errkuzjFJheShLQPmuYv6WG3AhDam
 f8JdIVMafaaFHF0gTebZYWQyu7iwgU/lgPm0SuSAgcSzchMr3c3rX0SsKQe7btrBwLcn
 8GrdLOwDFRA5tormHbOM+DnxM6Ih2uZgZ6nBxk1SDiS9mJerJH7EfPz7NRrM2J2hL2oU
 lZOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722513119; x=1723117919;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=a+eCeYakE+bjA/0RwiufcTnt1kCEeuPWytnlcRqyR2E=;
 b=t1aCnM8ue05n9ps8FhaAB3eetGLAnhTd71AUxvep9RHf1Z9SkzA+q/Jx8SH3bEJZiD
 HD+EVrVS8qh6kev41D93v87+ioBZCbrabnuCB0/Mwu0S4gZ6RgXIS9j33Ykd1WDoMsJh
 NKFMTj8uVMRevRypMGYh2lTQ97fk0beJIlAXmpbDm4zh+PirYoGeF4Ot5OrtCK4tSIsk
 NfeRZTIU/kSVMSXP4I2Kh3syQmj84OCM41PryiMrDbVKQPGqoI/N2J90SK69q3+5K1CD
 ex30WW06fgWugQWiz7lHPjBIHA63/kP15aSIzTr6i4BNzE8jNCdJv2BhrQ8wCa4c70oW
 L3eg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWvnUgeeXDzTYnUMlzPjqzD42eSfyOKxyR6QEUaAcj0cViMUsRdLMR04U4O82xzQugRzsg8COYG0zjIA/azruI/SaJt6joXVUTyq4IxSw==
X-Gm-Message-State: AOJu0Yz657dOZ681YBt6K5yGawDa/+ie8bYdLVeALvWM6InoeZuWfHfs
 Go19PjrnspuLH7ooS6Q1hp4m2VKr/UjO0zV9L3Q7LhWYFMoz7QSG
X-Google-Smtp-Source: AGHT+IFk1utG9rBzNVmLkGrwIrnKrIdIxvvWzdr0KKso3xdqx3fnlI96MXcFkiSP9AbtQYpPKlp+gQ==
X-Received: by 2002:adf:edd2:0:b0:36b:555a:e966 with SMTP id
 ffacd0b85a97d-36baaddcb80mr1423969f8f.35.1722513118563; 
 Thu, 01 Aug 2024 04:51:58 -0700 (PDT)
Received: from [10.254.108.81] (munvpn.amd.com. [165.204.72.6])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-36b367fd071sm19294691f8f.62.2024.08.01.04.51.57
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 01 Aug 2024 04:51:57 -0700 (PDT)
Message-ID: <556e74ee-df0b-4245-b328-726114356f44@gmail.com>
Date: Thu, 1 Aug 2024 13:51:56 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2 00/53] GC per queue reset
To: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
References: <20240725150055.1991893-1-alexander.deucher@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>
In-Reply-To: <20240725150055.1991893-1-alexander.deucher@amd.com>
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

Patches #1, #2 are Acked-by: Christian König <christian.koenig@amd.com>.

Patches #3, #4 and #5 are Reviewed-by: Christian König 
<christian.koenig@amd.com>.

To review the rest I really need to wrap my head around all the 
userqueue stuff again after my vacation.

Regards,
Christian.

Am 25.07.24 um 17:00 schrieb Alex Deucher:
> This adds preliminary support for GC per queue reset.  In this
> case, only the jobs currently in the queue are lost.  If this
> fails, we fall back to a full adapter reset.
>
> V2: Fix fallbacks to full adapter reset
>      RLC safemode cleanup
>      Preliminary support for older GPUs
>
> Alex Deucher (38):
>    drm/amdgpu/gfx10: handle SDMA in KIQ map/unmap
>    drm/amdgpu/mes11: handle second gfx pipe
>    drm/amdgpu/mes: add API for legacy queue reset
>    drm/amdgpu/mes11: add API for legacy queue reset
>    drm/amdgpu/mes12: add API for legacy queue reset
>    drm/amdgpu/mes: add API for user queue reset
>    drm/amdgpu/mes11: add API for user queue reset
>    drm/amdgpu/mes12: add API for user queue reset
>    drm/amdgpu: add new ring reset callback
>    drm/amdgpu: add per ring reset support (v5)
>    drm/amdgpu/gfx11: add ring reset callbacks
>    drm/amdgpu/gfx11: rename gfx_v11_0_gfx_init_queue()
>    drm/amdgpu/gfx10: add ring reset callbacks
>    drm/amdgpu/gfx10: rework reset sequence
>    drm/amdgpu/gfx9: add ring reset callback
>    drm/amdgpu/gfx9.4.3: add ring reset callback
>    drm/amdgpu/gfx12: add ring reset callbacks
>    drm/amdgpu/gfx12: fallback to driver reset compute queue directly
>    drm/amdgpu/gfx11: enter safe mode before touching CP_INT_CNTL
>    drm/amdgpu/gfx11: add a mutex for the gfx semaphore
>    drm/amdgpu/gfx11: export gfx_v11_0_request_gfx_index_mutex()
>    drm/amdgpu/gfx9: per queue reset only on bare metal
>    drm/amdgpu/gfx10: per queue reset only on bare metal
>    drm/amdgpu/gfx11: per queue reset only on bare metal
>    drm/amdgpu/gfx12: per queue reset only on bare metal
>    drm/amdgpu/gfx9: add ring reset callback for gfx
>    drm/amdgpu/gfx8: add ring reset callback for gfx
>    drm/amdgpu/gfx7: add ring reset callback for gfx
>    drm/amdgpu/gfx9: use proper rlc safe mode helpers
>    drm/amdgpu/gfx9.4.3: use proper rlc safe mode helpers
>    drm/amdgpu/gfx10: use proper rlc safe mode helpers
>    drm/amdgpu/gfx11: use proper rlc safe mode helpers
>    drm/amdgpu/gfx12: use proper rlc safe mode helpers
>    drm/amdgpu/gfx12: use rlc safe mode for soft recovery
>    drm/amdgpu/gfx11: use rlc safe mode for soft recovery
>    drm/amdgpu/gfx10: use rlc safe mode for soft recovery
>    drm/amdgpu/gfx9.4.3: use rlc safe mode for soft recovery
>    drm/amdgpu/gfx9: use rlc safe mode for soft recovery
>
> Jiadong Zhu (13):
>    drm/amdgpu/gfx11: wait for reset done before remap
>    drm/amdgpu/gfx10: remap queue after reset successfully
>    drm/amdgpu/gfx10: wait for reset done before remap
>    drm/amdgpu/gfx9: remap queue after reset successfully
>    drm/amdgpu/gfx9: wait for reset done before remap
>    drm/amdgpu/gfx9.4.3: remap queue after reset successfully
>    drm/amdgpu/gfx_9.4.3: wait for reset done before remap
>    drm/amdgpu/gfx: add a new kiq_pm4_funcs callback for reset_hw_queue
>    drm/amdgpu/gfx9: implement reset_hw_queue for gfx9
>    drm/amdgpu/gfx9.4.3: implement reset_hw_queue for gfx9.4.3
>    drm/amdgpu/mes: modify mes api for mmio queue reset
>    drm/amdgpu/mes: implement amdgpu_mes_reset_hw_queue_mmio
>    drm/amdgpu/mes11: implement mmio queue reset for gfx11
>
> Prike Liang (2):
>    drm/amdgpu: increase the reset counter for the queue reset
>    drm/amdgpu/gfx11: fallback to driver reset compute queue directly (v2)
>
>   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c |   1 +
>   drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h    |   6 +
>   drivers/gpu/drm/amd/amdgpu/amdgpu_job.c    |  20 ++
>   drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c    |  88 ++++++++
>   drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h    |  37 +++
>   drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h   |   2 +
>   drivers/gpu/drm/amd/amdgpu/cikd.h          |   1 +
>   drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c     | 251 +++++++++++++++++++--
>   drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c     | 127 +++++++++--
>   drivers/gpu/drm/amd/amdgpu/gfx_v11_0.h     |   3 +
>   drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c     | 103 ++++++++-
>   drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c      |  76 ++++++-
>   drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c      |  75 +++++-
>   drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c      | 179 ++++++++++++++-
>   drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c    | 132 ++++++++++-
>   drivers/gpu/drm/amd/amdgpu/mes_v11_0.c     | 134 +++++++++++
>   drivers/gpu/drm/amd/amdgpu/mes_v12_0.c     |  54 +++++
>   drivers/gpu/drm/amd/amdgpu/nvd.h           |   2 +
>   drivers/gpu/drm/amd/amdgpu/vid.h           |   1 +
>   19 files changed, 1243 insertions(+), 49 deletions(-)
>

