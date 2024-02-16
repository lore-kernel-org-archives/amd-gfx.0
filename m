Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10082C48260
	for <amd-gfx@archiver.kernel.org>; Fri, 16 Feb 2024 12:26:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 70ECB10E8B3;
	Fri, 16 Feb 2024 12:26:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="d9+VYa21";
	dkim-atps=neutral
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com
 [209.85.221.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5CC6E10E8B3
 for <amd-gfx@lists.freedesktop.org>; Fri, 16 Feb 2024 12:26:37 +0000 (UTC)
Received: by mail-wr1-f46.google.com with SMTP id
 ffacd0b85a97d-33adec41b55so1019005f8f.0
 for <amd-gfx@lists.freedesktop.org>; Fri, 16 Feb 2024 04:26:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1708086395; x=1708691195; darn=lists.freedesktop.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=FR+JPckbRRBZtL5r0Zhl3qKYjBT8xHYAuzmszRGk3+I=;
 b=d9+VYa21oqD7r1FuR/v2Rr2Q2J75jUx8iZyBwlszwRskSu+WzO+B2MeCQ7ca1h7qjx
 nx6BM/pXgClsY588vMg/1smtPfXqXIlRI/bUBA8APVlu5s8sbq12yzZcGc+423dWtvW4
 AiRhgYv6t+HBnmsv0PZZmNnIUYcvZzItQZoP4ckCkKJEJryhOp6+JkHxFOVgb2KH3axP
 rOKFZ0/G9RMBJHdaytVvury0+SsTHBvMnSoN8bTww+1cfQLAriaQPApZNk1L8QmLZ5Eu
 O0ycd7Mj7UdcBR6Dqyr4vKW2lNcwtWQcWZhD78WeAl5rlcUbuH2+bb+SS5AyV0DJvG18
 QZlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708086395; x=1708691195;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=FR+JPckbRRBZtL5r0Zhl3qKYjBT8xHYAuzmszRGk3+I=;
 b=h9fJu22t21geTk1L3RfQqfkouLMVvQTdUZVUqE0Azlycp0DtrWDfcgQ/Sl0QnB1o/f
 WPDclGq8fu/AMAGlLN2Bt3iiQZwI2imgU7OxQ7hKifDW1lBhecQYNEywuFfqbM22lrZy
 vwbgeNkBAgS1wmiXonVLph118t0EHpxX6GepaOIhcjhU4E0yrc33cGwTzpiqydvfJAz8
 xhZrueioHwaVBKaqbcjIZ0hKHzQMBcKJh1nk7pXs0uhsJket8LXKeEVQGOFDcNIVtHcx
 8LIxSVLDaO/TgpAWbA4s7AiHOBslTvF3NbkZoQIqLWiS5Xgs9hkUtEOa+9WMBOklFEUc
 CMIQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUL7GMfO0bz06co4yUDtFpHBFHvtE34AMFzbxNB33k9iI5zvMkHnaJpGoyTH8Lni21hqOMpN+c2MXumWYgTUjromsA1QocKDiE+SU4kTg==
X-Gm-Message-State: AOJu0YyuC4zYuFpiNpzT8rBYjzX0M9Vpiof2/jXNMQlM9rEOQR1Cr1at
 w8p1dnbSbD7rNm0sNiU2yKRcgHfLlvzGWs6wcFj1BCgJaWP4YiQ8GFWnGAoa
X-Google-Smtp-Source: AGHT+IHTuBDgLOKQ4eXwxc6IuiHbtALsZQMnpa9v9mKg+x2TtrjYyEoLWOqqraN4YKdkwfrkXreNLA==
X-Received: by 2002:adf:fd4f:0:b0:33d:1ad9:a20c with SMTP id
 h15-20020adffd4f000000b0033d1ad9a20cmr1184228wrs.28.1708086395378; 
 Fri, 16 Feb 2024 04:26:35 -0800 (PST)
Received: from [10.254.108.81] (munvpn.amd.com. [165.204.72.6])
 by smtp.gmail.com with ESMTPSA id
 a7-20020adfeec7000000b0033b483d1abcsm2049864wrp.53.2024.02.16.04.26.34
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 16 Feb 2024 04:26:34 -0800 (PST)
Message-ID: <43426f9e-70fd-4ea5-b3d3-64c34f55ba05@gmail.com>
Date: Fri, 16 Feb 2024 13:26:33 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/9] PSP 14.0 support
Content-Language: en-US
To: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
References: <20240212175849.433812-1-alexander.deucher@amd.com>
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>
In-Reply-To: <20240212175849.433812-1-alexander.deucher@amd.com>
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

Am 12.02.24 um 18:58 schrieb Alex Deucher:
> This set adds support for PSP 14.0.x.  PSP handles firmware
> validation and various low level asic initialization.
>
> The first patch adds register headers and is large so it has
> been omitted.
>
> Hawking Zhang (2):
>    drm/amdgpu: Add mp v14_0_2 ip headers (v5)
>    drm/amdgpu: Add psp v14_0 ip block support
>
> Likun Gao (7):
>    drm/amdgpu: use spirom update wait_for helper for psp v14
>    drm/amdgpu: support psp ip block for psp v14
>    drm/amdgpu/psp: set autoload support by default
>    drm/amdgpu/psp: handle TMR type via flag
>    drm/amdgpu/psp: set boot_time_tmr flag
>    drm/amdgpu: add psp_timeout to limit PSP related operation
>    drm/amdgpu: support psp ip block discovery for psp v14

Acked-by: Christian König <christian.koenig@amd.com> for the series.

>
>   drivers/gpu/drm/amd/amdgpu/Makefile           |   3 +-
>   drivers/gpu/drm/amd/amdgpu/amdgpu.h           |   1 +
>   drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c |   4 +
>   drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c       |  55 +-
>   drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h       |   3 +
>   drivers/gpu/drm/amd/amdgpu/psp_v14_0.c        | 672 +++++++++++++++++
>   drivers/gpu/drm/amd/amdgpu/psp_v14_0.h        |  32 +
>   .../include/asic_reg/mp/mp_14_0_2_offset.h    | 468 ++++++++++++
>   .../include/asic_reg/mp/mp_14_0_2_sh_mask.h   | 692 ++++++++++++++++++
>   9 files changed, 1907 insertions(+), 23 deletions(-)
>   create mode 100644 drivers/gpu/drm/amd/amdgpu/psp_v14_0.c
>   create mode 100644 drivers/gpu/drm/amd/amdgpu/psp_v14_0.h
>   create mode 100644 drivers/gpu/drm/amd/include/asic_reg/mp/mp_14_0_2_offset.h
>   create mode 100644 drivers/gpu/drm/amd/include/asic_reg/mp/mp_14_0_2_sh_mask.h
>

