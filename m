Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 459AACCFA03
	for <amd-gfx@archiver.kernel.org>; Thu,  6 Nov 2025 09:56:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EA4CF10E030;
	Thu,  6 Nov 2025 09:56:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=ursulin.net header.i=@ursulin.net header.b="NtvfKHtZ";
	dkim-atps=neutral
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com
 [209.85.167.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6090A10E866
 for <amd-gfx@lists.freedesktop.org>; Thu,  6 Nov 2025 09:56:54 +0000 (UTC)
Received: by mail-lf1-f45.google.com with SMTP id
 2adb3069b0e04-592ee9a16adso1056304e87.0
 for <amd-gfx@lists.freedesktop.org>; Thu, 06 Nov 2025 01:56:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ursulin.net; s=google; t=1762423013; x=1763027813; darn=lists.freedesktop.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ah9B3sBKtJMQ90NKotd1CpXpyuKbVPGroKqtGBrjaj0=;
 b=NtvfKHtZ6IlDoD9uR2knoXPAnT3NXubx2ajtnd0QZ5qb2Ul+B+IT5nythgVqCDalqo
 8KttgHApF7bqt1qxsd8IIqW0sGsOhHl2XAm90VQj5Coc4N3/cEGOCNETBlf6Rvu+hFf+
 sdo3pR/x5qDSZmavBvUhdM1yimhK9Nz8aNj/676bNdNl6vnsI4SR/OaMtPa7A7hW12WJ
 bCf8lVQEjld35w+nTvYe5P5htZgo7u2kTB6Ddyim1WfAOpb2rtfeTgLzEB36HX03jLVY
 1ZND/zT/MaDtpoF+51PnZCcge2SHCXU/aZSSqPhVXskccdqbDeE9bqkazMftCceXp9Dd
 Eqpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762423013; x=1763027813;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ah9B3sBKtJMQ90NKotd1CpXpyuKbVPGroKqtGBrjaj0=;
 b=VBFVnJqGKPeid11NWbuNxn9u1RpWMqRMTXJXiVP0AfpkgBdopVjjY5D2a7DvGvnHzW
 osg1FXzCATskFyurMmgaJ7Pw9LNzI/lMfGtHGkGtRXIR7REWwfU+LCvRLMLyg9bbNeiB
 nL7CS65aFjasV1VBPumZq6wSHBt14Y+3wKiH83r+x6Sed9Sk10nt06RxtsUryOX2wPik
 znY8AJHjVRf5jr05aAxT3ZOOmDQthxV6HpOfIqHRyV5NDU7LKiPQSKzggK+xeAMBCukX
 2bQm3QsyFPyXi5m3EXrzU1gaJLtcfX9H17sxDJfxNuD5JYEuijnZA/TrGHXsqoFuQ15y
 MZQg==
X-Gm-Message-State: AOJu0YzC4A2/Kve3uHIInvXuU2ek7mCTUzSyBhJUjf22ow9F5/saA1cj
 PT85/2zeyVVWdMPjwwG+o3tQ2bX8YM9tbxdlxIkKzRBtvtD146QhsdlMyWiwfTW7zNU=
X-Gm-Gg: ASbGncu1MsM3qyWYTQOmCkQNfLjbF04/SC3jnmBxjAD1DRUHagY7Nm/7EvnGL/6M1uN
 kOI3mNnYT7EWEcEz3dOOJGFAV97HADH1h9nqIfZMPgMIpF79Zwb83EYvQsUR+t7tqvZmpEQgGVF
 H1U4pljo9jmpYzTpn4a+2axH97yGce5nfZJRnIO1jSczqV7HroVbaux0bq9y1I0C0fSAe0QZ/QJ
 ZrGIBzERt+bzX4GrPAk5hSPpuOqxsBhlaRsDMDJ8ZuS9B4MLB97uCPbcbMSX2USaKaOJo02/A44
 iv6zt0g1Dcmc/Fl3Ji5mhe8xZsbe6aGg1faCUAOl9abmxGO7vFtjYmjatQF+sqt0Z+WBhDcSAB+
 UIAtR8B7n25wFzoTjacoWZYLQ3bDXskshi5im+96d/kYNayrRpCr2JBBnSVn42yw/XevRLWxx0n
 frG8ySAi1U3ZfFay/h/VYPPNTMQvc=
X-Google-Smtp-Source: AGHT+IH87qGloTPs2IJda89ZYDWYxle19K2T13CnSFSXTtTGmwBkX5fIkNyS4ZGBOcmSluALoZwAiw==
X-Received: by 2002:a05:6512:3988:b0:57d:6fca:f208 with SMTP id
 2adb3069b0e04-5943d7d5ed4mr1507581e87.45.1762423012315; 
 Thu, 06 Nov 2025 01:56:52 -0800 (PST)
Received: from [192.168.0.101] ([90.240.106.137])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5944a019ef3sm594914e87.32.2025.11.06.01.56.51
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 06 Nov 2025 01:56:51 -0800 (PST)
Message-ID: <63ce6781-439d-4425-a3e9-f1d233a5abea@ursulin.net>
Date: Thu, 6 Nov 2025 09:56:50 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/4] drm/amdgpu: jump to the correct label on failure
To: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
References: <20251106093933.18859-1-pierre-eric.pelloux-prayer@amd.com>
 <20251106093933.18859-2-pierre-eric.pelloux-prayer@amd.com>
Content-Language: en-GB
From: Tvrtko Ursulin <tursulin@ursulin.net>
In-Reply-To: <20251106093933.18859-2-pierre-eric.pelloux-prayer@amd.com>
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


On 06/11/2025 09:39, Pierre-Eric Pelloux-Prayer wrote:
> drm_sched_entity_init wasn't called yet, so the only thing to
> do is to release allocated memory.
> This doesn't fix any bug since entity is zero allocated and
> drm_sched_entity_fini does nothing in this case.
> 
> Signed-off-by: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
> index f5d5c45ddc0d..afedea02188d 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
> @@ -236,7 +236,7 @@ static int amdgpu_ctx_init_entity(struct amdgpu_ctx *ctx, u32 hw_ip,
>   		r = amdgpu_xcp_select_scheds(adev, hw_ip, hw_prio, fpriv,
>   						&num_scheds, &scheds);
>   		if (r)
> -			goto cleanup_entity;
> +			goto error_free_entity;
>   	}
>   
>   	/* disable load balance if the hw engine retains context among dependent jobs */

Reviewed-by: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>

Regards,

Tvrtko

