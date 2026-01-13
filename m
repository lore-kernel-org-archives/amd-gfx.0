Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02864D2D0F9
	for <amd-gfx@archiver.kernel.org>; Tue, 13 Jan 2026 13:13:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 976E210E4D0;
	Tue, 13 Jan 2026 13:13:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="EMwWHh6p";
	dkim-atps=neutral
Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com
 [209.85.219.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F3F8310E4D0
 for <amd-gfx@lists.freedesktop.org>; Tue, 13 Jan 2026 13:13:00 +0000 (UTC)
Received: by mail-qv1-f48.google.com with SMTP id
 6a1803df08f44-88a35a00506so108400956d6.2
 for <amd-gfx@lists.freedesktop.org>; Tue, 13 Jan 2026 05:13:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1768309980; x=1768914780; darn=lists.freedesktop.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=n7e9eLVPEJw5WTVoSjsOPENgHwRipeDaJA1mlmGwp6g=;
 b=EMwWHh6pk1EfR/anfrT/VoR2Fo9Ng/mNLkrhSS0SaJfWCpdh8wPUxPqKaCYaxBGDK3
 SQacEb0wRfSIwh9FBhG1YkrzjIWHcnG82jdp7ZeMuaDWT12YqilK6v5V21MlCRiS4sZ5
 lPjCgzFN5Kjgk7Y0hHf27Ise8ho/S9dn5kU3/CkDHtisZUzbstvsIjTJaPQ/ViVBYqSA
 5oWy2B3aIwGBPEAzfwI60JDnEXwQNgsaZ9rl/giHWe5M4017V3FJE6jBi2KerBktbzws
 kjYQuApBrTvOjTX1a0v6MDI2ZpNtMP6JTScnBDhS3GjlgppSJFUuu7hCs6fUfT1xfst7
 WBbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768309980; x=1768914780;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=n7e9eLVPEJw5WTVoSjsOPENgHwRipeDaJA1mlmGwp6g=;
 b=HXZ1SbeUk1/+gWIuWubscrdgM0qNC43AQhhTcroJS0tcsUhx7BRZxDqhuSF58WX+51
 WHbETXRiTEwnrVYolsoyQlcj0CVYCPI/XyPhH8oGj9THYJLhe5shgR/8wiScZEH1/uTO
 UpmIC/aqFdLkchnmIvxYyLUGRHUycFH1aorjt3AHAtk1DWDS+L6ES4AQRs1QVAzhFEQ5
 Lo21KtfFUfcpUZmfGbvMp/52qwznFHAar+zsWLrgJQbQ76fRyXrCKXGOPokRZZ/ac3qX
 dTv/L4RpvP02tIDnQBehBPSuDdZt5YCi+aFkp2s/m6I3hCq5htZk21G/kodLZ9o0lGxm
 1zuQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVQO5HY4hEDyTZMpFEuNBluRW1ycl9eQVV8gWlWL1FRGDXMT1fE+fjv3bXG0cJBS3LrYEhF7Cvt@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyARti66kie9qWzCf71UQiK6h221AbH66lEUoq21LFU13Y4oRqd
 TWKr1ATKdR0AMD3sOHclVWXTXaGBe26s0wSWkgUFdMChdfdvMGksLxBA
X-Gm-Gg: AY/fxX5ZCd8OVrjwkj+X1/rcXf1/nzhvRYCIOPXR4NsHuNF0hZTo1kPTeWdhBfpQg5l
 7yot5xreKSqX7lax5kSLI+NVNwsezLD6nQUKc3lg3jHY3OgrDfzts1ebdjJPRcLZJe8rPMgeCrl
 nt+RBERjcqFWRLRlV9sFw6/3aJkNBLybtQxRjnkGSeqCnJZb6c82pcoZALtK/ZFvxvd6niDpYtP
 XqaDaDTA7gWN+54iazYwZ621VwR5L2jXPcybfkp/hsZvVuVWa12iZCKN+V38IInbuv8PGwLkQq2
 DwDvdIrz29rgFE4NdYxxZ6RpjYfchFSgu05lQEUqTlW4AhU4LxrDpAgGu7idnmY9EdYciPhPxx5
 FKaPQY3cHZ4MXza+AUsPnzQsvTLKQcTEZATBQE23ES3Eo5GRinuyWdZl4zcGfi3Fq0Q7xUgHAAc
 0TjQU9qVk6VGh6byBR32z35ifmO4ptSDH2+Xvn+kZEXeI=
X-Google-Smtp-Source: AGHT+IG3a0n8mUGoBsn7oxnsd4floF+Z04SMWmIApIqvZBqAnZopTBqAa+rZs1nQCgJWxK0BaT36xw==
X-Received: by 2002:a05:6214:4a89:b0:721:a9d7:297a with SMTP id
 6a1803df08f44-8908417a44amr287187896d6.7.1768309979729; 
 Tue, 13 Jan 2026 05:12:59 -0800 (PST)
Received: from [10.254.120.192] (mkmvpn.amd.com. [165.204.54.211])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-50145d7c610sm1452181cf.22.2026.01.13.05.12.58
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 13 Jan 2026 05:12:59 -0800 (PST)
Message-ID: <73176491-e648-4a8b-bcaf-d40394dad0c7@gmail.com>
Date: Tue, 13 Jan 2026 14:12:58 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 27/42] drm/amdgpu: mark fences with errors before ring
 reset
To: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
References: <20260108144843.493816-1-alexander.deucher@amd.com>
 <20260108144843.493816-28-alexander.deucher@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>
In-Reply-To: <20260108144843.493816-28-alexander.deucher@amd.com>
Content-Type: text/plain; charset=UTF-8
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

On 1/8/26 15:48, Alex Deucher wrote:
> Mark fences with errors before we reset the rings as
> we may end up signalling fences as part of the reset
> sequence.  The error needs to be set before the fence
> is signalled.

Setting the error is a good idea, but signaling the fence before the reset is clearly a NAK.

Fence signaling can only happen after we are sure that the DMA operation has been canceled.

Regards,
Christian.

> 
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
> index 600e6bb98af7a..5defdebd7091e 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
> @@ -872,6 +872,10 @@ void amdgpu_ring_reset_helper_begin(struct amdgpu_ring *ring,
>  	drm_sched_wqueue_stop(&ring->sched);
>  	/* back up the non-guilty commands */
>  	amdgpu_ring_backup_unprocessed_commands(ring, guilty_fence);
> +	/* signal the guilty fence and set an error on all fences from the context */
> +	if (guilty_fence)
> +		amdgpu_fence_driver_guilty_force_completion(guilty_fence);
> +
>  }
>  
>  int amdgpu_ring_reset_helper_end(struct amdgpu_ring *ring,
> @@ -885,9 +889,6 @@ int amdgpu_ring_reset_helper_end(struct amdgpu_ring *ring,
>  	if (r)
>  		return r;
>  
> -	/* signal the guilty fence and set an error on all fences from the context */
> -	if (guilty_fence)
> -		amdgpu_fence_driver_guilty_force_completion(guilty_fence);
>  	/* Re-emit the non-guilty commands */
>  	if (ring->ring_backup_entries_to_copy) {
>  		amdgpu_ring_alloc_reemit(ring, ring->ring_backup_entries_to_copy);

