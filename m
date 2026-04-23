Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65759FDEE40
	for <amd-gfx@archiver.kernel.org>; Thu, 23 Apr 2026 18:10:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 016FA10E33C;
	Thu, 23 Apr 2026 18:10:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="aH1xFcdX";
	dkim-atps=neutral
Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com
 [209.85.222.182])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E72BB10E33C
 for <amd-gfx@lists.freedesktop.org>; Thu, 23 Apr 2026 18:10:50 +0000 (UTC)
Received: by mail-qk1-f182.google.com with SMTP id
 af79cd13be357-8cb38e86cf2so646437685a.1
 for <amd-gfx@lists.freedesktop.org>; Thu, 23 Apr 2026 11:10:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1776967850; x=1777572650; darn=lists.freedesktop.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=JWrrmiKq2qCtbLPgThdnhoJQtUiUYqGKSiQ5vzYEKbA=;
 b=aH1xFcdXrwieqhpIfqJFJzpV69KpsY3lJ3ZiVEeaGswQpvtVvhrRRaLULMneaB11BX
 Eary5b00Qkpat01Enh9VXpHfocBKi7c247bz/0ITfwvGNgD+8lvnda0wDNjrOM43v+KC
 jLoq2jjMFiIJtETlRQokDuR9N3+mySkKIIg4J6G8jg741znVPKyPGNv/H7fapWEbwPwB
 c7ZSM+oAQZihgJ6TYwgg0yjO0NZfmN0LPEn3EU6zvl7/KUeC1mR3OIxQHR/hBTSrLUvy
 of2IBlai1DZ+eboFjedT5Q4rRfC2hwyNveeFHGRZjmuVGamTf+QEGsnLxC57qqGIfUZ7
 6IjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776967850; x=1777572650;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=JWrrmiKq2qCtbLPgThdnhoJQtUiUYqGKSiQ5vzYEKbA=;
 b=g2Z6qBE2nhDptKZ4b4+bJakpRCaHunAbjGxGBK4oLE6ydwlE9HAH+QBFxP2Kc+ML2N
 zhB+y7/twz3JXW7k4IuY0bkennrEd4lIRe7COTwPdqCKcODLOGFP2Kxgjlj8lZRqyeMT
 M/kBToQZ1F8rthfYLAybuK/yXGQUp6vKSLBDuWQ23JPkkLSClBvfefDnoBZzzmHYnIGH
 7Ri9VyscZQ4rOMPSXCYVemsD4ivuPanzoO0L2uewlCMhSKMaRWJ/gCgwR9GCeDQNaD40
 Gk+r7jY1gmKKWot1xZ6QHyrTtb+34dBLh/gWU3Ibc5OOUFAbCF05TDS0snGPQBJCJSF+
 Z7LQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ/fxOPE1YyDVmJz2vF7C45nBv8SCNww2YQKS5K8Gyp450H0Y3I5ZoDn6lFcDXAV2JvOJjrhqTe+@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yxmm3Ys7XmtJn5MO3FkmCet6NkvdkHCyjzawpv7+5ziVfazNZdj
 kyfR9WyQn12wUcc+OqrKrL4ISghuSXb0x+WI4U1zoskVK8pRFlUad8dR
X-Gm-Gg: AeBDietybCoyBq1/8SdtzFV0fGwVGiNpR7MMeHor+hvN11+rpsTiZNPQIPU5xtz7KcW
 8FWERjhnLQPV++LhIoVW5qmG9kEAj8bRtUdK8A+XFlKWdrG/rieMDQitpPgKeL4VO6HUZTh2Lzj
 Bpt/5X5C/rdZQn5qxEbueCzosVtdwp3xep5JSzuGFhtpZLFmi0aAKk3AimBIYq8iO8p3gxn8OI3
 xg50ejsBcz/k4W58fpAhB8iJ5Go1OjnDx+aDGOJOS8FjHFkHbzTClJx99+IElvNFSr7tP8IHzvJ
 +ItBKbLSpELE+D2APDXKP5ejUVjUlecG/d9FSl9X3nBhvxgVtW0Z91tqgAYebWKIkPFiySqIOiu
 LWvuXFMb8eSmiBbc3Lz90rW8qxRHeqsShRnwwC6LxsXALH4VjzwMU+hPVRxsXPLwsbv5bQc7fGC
 AWciZUbYCauTsAGTQikDUny0QoFDngygClQqzf6nvtaw==
X-Received: by 2002:a05:620a:4612:b0:8d4:aa50:686b with SMTP id
 af79cd13be357-8e7911ce9cdmr3915301485a.31.1776967849676; 
 Thu, 23 Apr 2026 11:10:49 -0700 (PDT)
Received: from [192.168.1.100] ([32.220.111.111])
 by smtp.googlemail.com with ESMTPSA id
 af79cd13be357-8ee585e9fcdsm799891485a.16.2026.04.23.11.10.49
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 23 Apr 2026 11:10:49 -0700 (PDT)
Message-ID: <b61e625b-c665-4f4f-809e-e42bfa44af4e@gmail.com>
Date: Thu, 23 Apr 2026 14:10:48 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 09/11] drm/amdgpu/vce2: Fix VCE 2 firmware size and offsets
To: =?UTF-8?Q?Timur_Krist=C3=B3f?= <timur.kristof@gmail.com>,
 amd-gfx@lists.freedesktop.org, alexander.deucher@amd.com,
 christian.koenig@amd.com
References: <20260423011614.309180-1-timur.kristof@gmail.com>
 <20260423011614.309180-10-timur.kristof@gmail.com>
Content-Language: en-US
From: John Olender <john.olender@gmail.com>
In-Reply-To: <20260423011614.309180-10-timur.kristof@gmail.com>
Content-Type: text/plain; charset=UTF-8
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

On 4/22/26 9:16 PM, Timur Kristóf wrote:
> The VCPU BO contains the actual FW at an offset, but
> it was not calculated into the VCPU BO size.
> Subtract this from the FW size to make sure there is
> no out of bounds access.
> 
> This may fix VM faults when using VCE 2.

I gave this patchset a test on Hawaii and Ellesmere.

I'm still seeing VM faults and card lockup on Hawaii.

Link: https://gitlab.freedesktop.org/drm/amd/-/work_items/4802

Adding additional padding to the VCE VCPU BO (e.g.: rounding up to 1MB)
does seem like an effective workaround, both when the the VCPU BO is
placed in VRAM or in GTT.

I don't see this problem on Ellesmere both with and without this
patchset.

Thanks,
John

> 
> Cc: John Olender <john.olender@gmail.com>
> Closes: https://gitlab.freedesktop.org/drm/amd/-/work_items/4802
> Fixes: e98226221467 ("drm/amdgpu: recalculate VCE firmware BO size")
> Signed-off-by: Timur Kristóf <timur.kristof@gmail.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/vce_v2_0.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/vce_v2_0.c b/drivers/gpu/drm/amd/amdgpu/vce_v2_0.c
> index 00b4037d4bc89..3b493a2e94dd0 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vce_v2_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vce_v2_0.c
> @@ -183,7 +183,7 @@ static void vce_v2_0_mc_resume(struct amdgpu_device *adev)
>  	WREG32(mmVCE_LMI_VCPU_CACHE_40BIT_BAR, (adev->vce.gpu_addr >> 8));
>  
>  	offset = AMDGPU_VCE_FIRMWARE_OFFSET;
> -	size = VCE_V2_0_FW_SIZE;
> +	size = VCE_V2_0_FW_SIZE - AMDGPU_VCE_FIRMWARE_OFFSET;
>  	WREG32(mmVCE_VCPU_CACHE_OFFSET0, offset & 0x7fffffff);
>  	WREG32(mmVCE_VCPU_CACHE_SIZE0, size);
>  

