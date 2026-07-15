Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4919C44507
	for <amd-gfx@archiver.kernel.org>; Wed, 15 Jul 2026 08:56:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 66E6710E146;
	Wed, 15 Jul 2026 08:56:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=ursulin.net header.i=@ursulin.net header.b="AsOLcwfz";
	dkim-atps=neutral
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com
 [209.85.128.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4299710E146
 for <amd-gfx@lists.freedesktop.org>; Wed, 15 Jul 2026 08:56:41 +0000 (UTC)
Received: by mail-wm1-f54.google.com with SMTP id
 5b1f17b1804b1-493d92b7db3so14557345e9.2
 for <amd-gfx@lists.freedesktop.org>; Wed, 15 Jul 2026 01:56:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ursulin.net; s=google; t=1784105799; x=1784710599; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=UTcYMu0p/JVWWzsQX+6Gpv/lesQ/m9EuRt8ds1JnNZA=;
 b=AsOLcwfzUeS0B3rpslNeKPF9zlPJ0RV9fzoOuNprXpFSWcB0vApv+6D1fwpyqo0kNP
 zRM/vEC0nhWy7l2lDW3j+/TaJO4UPWqS8A5+ULC4AIwoiHN4aHhKlYkJ3mL6Mwy/8G+1
 o/77xn6hmifyYzKA6RvRcZ1+ct0HWCQ+qRN4/v6ntppecqEZeXWwCMZDfPN7PF5s2OCW
 iAEesSfB80HoytIG1F9YiQoWvpDqBwqaQX7wvCLiPL9x2G4I4O1RBNRQintT+Ws89dW8
 mwNWmx7Y2McK4skMLw7tGcnv4r0G7J9LLzfxx/imJ+aErHaNBxBfD1t+q6BDLAwXhJKz
 +JvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784105799; x=1784710599;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=UTcYMu0p/JVWWzsQX+6Gpv/lesQ/m9EuRt8ds1JnNZA=;
 b=BpXJM0HYM72e8RfChdRRjmLrCsQ6HV8ThFmXTvAKtRhchGDwAxX1eNw03gc2MDg1O6
 HsBQxhLvX88Kl5pI85aG+v1xAjOMjuTPoakoHx0WwOItL9Q1OT445v+9JoEScCOmMq3R
 3TeTuGE3X7aX765bFer/XDby6ig36i8JSbqco+drh1izYHL9olX8+yQnq3K24JvR8XYg
 z/4xXAjwqGESMlNeRWxsw9Un63A5UH8JsZAXqEHztuJxbbEmOE//gH/ZwOrKTpkdwz0S
 4G6Vv23cbjWFrLxJaKP6eJbBNODDEUFEobk4Qi2F+qJMCRBBOF1Hmy9MkMAgn41Xfm6S
 W/1w==
X-Forwarded-Encrypted: i=1;
 AHgh+Rq4LoAGv6lnl13iMwu89bKasUS/zyQtzGHYycTjsjzMNdw+ipYdLCKKvcJOHTXkoLBRsJRkyy1y@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwjR3j7oDd3Cx2OmlEddcS5lAlDrQntz+mETHbyDt7v81JHfzRc
 5wAFq4lSVefUL9alz73bp3PQWwqYZAFeTg/JlToRrYtzxwisI+MRJHztnHdZAKHU7Is=
X-Gm-Gg: AfdE7cnWwrrxc3vML8KkvQ3n1NOiXw/H17wpkkHi0ppKhiUyDv42skROPX4InlEffQ9
 pdyog3tdjp/fCUh/aoQG0ElWDQqdOSqmazB80sfouoIf3imHNvLDhkwxxTWoI7dLtx1APvV39Xl
 FH6BiePpYtcGXoZz8FYLRj8hyZ4xPwC6YBU0FqJvL9SuVWSOVy2SLADMlQlTIw5oG5GZVB3w40/
 JRztKz7CfHWj7WtG0HtGk+Ee+dd9QLHwgLEKGdQh0qbDdVVyf+BIBnJqQj0TFpdzt7y0VViJvgl
 DsQvLgQ5TCX0+iIGl51TUTkbs7aRYpID8P/ayax6qo5KwGF2iFYr6WPd/KrZ3q4oJM8EBk1E9/v
 YljeKvljMpezm0Jf7PF756A6dRb6UK9eV9E2ngh8KOA0mhgjiILS9nx/JuhEmIjHZzRi6yfyv1W
 UIZ/LUTHmkgpuN/uK1Q3wNI/XP8ctkIaWrdQ==
X-Received: by 2002:a05:600d:8444:10b0:493:f5bf:4da4 with SMTP id
 5b1f17b1804b1-493f8826c64mr136399515e9.28.1784105799302; 
 Wed, 15 Jul 2026 01:56:39 -0700 (PDT)
Received: from [192.168.0.116] ([90.240.106.137])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4953f643acdsm4023975e9.3.2026.07.15.01.56.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 15 Jul 2026 01:56:38 -0700 (PDT)
Message-ID: <fb4f5735-2ccb-4a75-8d69-d776b3f3bb84@ursulin.net>
Date: Wed, 15 Jul 2026 09:56:38 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/9] drm/amdgpu/gfx7: Fixup emitting SWITCH_BUFFER packets
To: =?UTF-8?Q?Timur_Krist=C3=B3f?= <timur.kristof@gmail.com>,
 amd-gfx@lists.freedesktop.org, Alex Deucher <alexander.deucher@amd.com>,
 christian.koenig@amd.com, pierre-eric.pelloux-prayer@amd.com,
 Natalie Vock <natalie.vock@gmx.de>
References: <20260713125838.30607-1-timur.kristof@gmail.com>
 <20260713125838.30607-6-timur.kristof@gmail.com>
Content-Language: en-GB
From: Tvrtko Ursulin <tursulin@ursulin.net>
In-Reply-To: <20260713125838.30607-6-timur.kristof@gmail.com>
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


On 13/07/2026 13:58, Timur Kristóf wrote:
> Implement the emit_switch_buffer() function instead of emitting
> them duing emit_ib, emit_pipeline_sync and emit_vm_flush.

during

> 
> Note that it isn't necessary to emit these in both
> emit_pipeline_sync() and emit_vm_flush() because
> amdgpu_vm_flush() already calls these when calling
> either of those functions.

The amdgpu_vm_flush indeed does emit two switch buffers:

	/* the double SWITCH_BUFFER here *cannot* be skipped by COND_EXEC */
	if (ring->funcs->emit_switch_buffer) {
		amdgpu_ring_emit_switch_buffer(ring);
		amdgpu_ring_emit_switch_buffer(ring);
	}

Comments are different though:

/* sync CE with ME to prevent CE fetch CEIB before context switch done */

Are you confident the two emissions are about the same thing?

> 
> Signed-off-by: Timur Kristóf <timur.kristof@gmail.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c | 32 +++++++++------------------
>   1 file changed, 10 insertions(+), 22 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c
> index 0ceadb107d26..a93cc02c3400 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c
> @@ -2201,12 +2201,6 @@ static void gfx_v7_0_ring_emit_ib_gfx(struct amdgpu_ring *ring,
>   	unsigned vmid = AMDGPU_JOB_GET_VMID(job);
>   	u32 header, control = 0;
>   
> -	/* insert SWITCH_BUFFER packet before first IB in the ring frame */
> -	if (flags & AMDGPU_HAVE_CTX_SWITCH) {
> -		amdgpu_ring_write(ring, PACKET3(PACKET3_SWITCH_BUFFER, 0));
> -		amdgpu_ring_write(ring, 0);
> -	}

Commit message does not explain why the change of ring buffer command 
this creates is okay. Current flow is:

amdgpu_ib_schedule()
{
...
   amdgpu_ring_emit_ib
     amdgpu_ring_write(ring, PACKET3(PACKET3_SWITCH_BUFFER, 0));


New flow is:

...
   amdgpu_ring_emit_ib
... other ring commands ...
   amdgpu_ring_emit_switch_buffer
     amdgpu_ring_write(ring, PACKET3(PACKET3_SWITCH_BUFFER, 0));

Is this okay? Specifically due the above comment saying "insert 
SWITCH_BUFFER packet before first IB in the ring frame" - is the "first" 
part not important?

Also, amdgpu_ib_schedule only emits amdgpu_ring_emit_switch_buffer if 
there is a job. Currently it is always emitted.

Final interesting part is how amdgpu_ib_schedule clears 
AMDGPU_HAVE_CTX_SWITCH after having called amdgpu_ring_emit_ib.

After this change only gfx6 remains the user of that flag in 
gfx_v6_0_ring_emit_ib. Everyone else only use it in emit_cntxcntl. If 
gfx6 was adjusted too (later), amdgpu_ib_schedule could reduce the scope 
of that flag to just the scope where it calls amdgpu_ring_emit_frame_cntl.

Regards,

Tvrtko
> -
>   	if (ib->flags & AMDGPU_IB_FLAG_CE)
>   		header = PACKET3(PACKET3_INDIRECT_BUFFER_CONST, 2);
>   	else
> @@ -2258,6 +2252,12 @@ static void gfx_v7_0_ring_emit_ib_compute(struct amdgpu_ring *ring,
>   	amdgpu_ring_write(ring, control);
>   }
>   
> +static void gfx_v7_0_ring_emit_sb(struct amdgpu_ring *ring)
> +{
> +	amdgpu_ring_write(ring, PACKET3(PACKET3_SWITCH_BUFFER, 0));
> +	amdgpu_ring_write(ring, 0);
> +}
> +
>   static void gfx_v7_ring_emit_cntxcntl(struct amdgpu_ring *ring, uint32_t flags)
>   {
>   	uint32_t dw2 = 0;
> @@ -3111,14 +3111,6 @@ static void gfx_v7_0_ring_emit_pipeline_sync(struct amdgpu_ring *ring)
>   	amdgpu_ring_write(ring, seq);
>   	amdgpu_ring_write(ring, 0xffffffff);
>   	amdgpu_ring_write(ring, 4); /* poll interval */
> -
> -	if (usepfp) {
> -		/* sync CE with ME to prevent CE fetch CEIB before context switch done */
> -		amdgpu_ring_write(ring, PACKET3(PACKET3_SWITCH_BUFFER, 0));
> -		amdgpu_ring_write(ring, 0);
> -		amdgpu_ring_write(ring, PACKET3(PACKET3_SWITCH_BUFFER, 0));
> -		amdgpu_ring_write(ring, 0);
> -	}
>   }
>   
>   /*
> @@ -3160,12 +3152,6 @@ static void gfx_v7_0_ring_emit_vm_flush(struct amdgpu_ring *ring,
>   		/* sync PFP to ME, otherwise we might get invalid PFP reads */
>   		amdgpu_ring_write(ring, PACKET3(PACKET3_PFP_SYNC_ME, 0));
>   		amdgpu_ring_write(ring, 0x0);
> -
> -		/* synce CE with ME to prevent CE fetch CEIB before context switch done */
> -		amdgpu_ring_write(ring, PACKET3(PACKET3_SWITCH_BUFFER, 0));
> -		amdgpu_ring_write(ring, 0);
> -		amdgpu_ring_write(ring, PACKET3(PACKET3_SWITCH_BUFFER, 0));
> -		amdgpu_ring_write(ring, 0);
>   	}
>   }
>   
> @@ -4954,8 +4940,9 @@ static const struct amdgpu_ring_funcs gfx_v7_0_ring_funcs_gfx = {
>   		7 + /* gfx_v7_0_ring_emit_hdp_flush */
>   		5 + /* hdp invalidate */
>   		12 + 12 + 12 + /* gfx_v7_0_ring_emit_fence_gfx x3 for user fence, vm fence */
> -		7 + 4 + /* gfx_v7_0_ring_emit_pipeline_sync */
> -		CIK_FLUSH_GPU_TLB_NUM_WREG * 5 + 7 + 6 + /* gfx_v7_0_ring_emit_vm_flush */
> +		7 + /* gfx_v7_0_ring_emit_pipeline_sync */
> +		CIK_FLUSH_GPU_TLB_NUM_WREG * 5 + 7 + 2 + /* gfx_v7_0_ring_emit_vm_flush */
> +		3 * 2 + /* gfx_v7_0_ring_emit_sb x3 (from amdgpu_vm_flush, amdgpu_ib_schedule) */
>   		3 + 4 + /* gfx_v7_ring_emit_cntxcntl including vgt flush*/
>   		5, /* SURFACE_SYNC */
>   	.emit_ib_size = 4, /* gfx_v7_0_ring_emit_ib_gfx */
> @@ -4969,6 +4956,7 @@ static const struct amdgpu_ring_funcs gfx_v7_0_ring_funcs_gfx = {
>   	.test_ib = gfx_v7_0_ring_test_ib,
>   	.insert_nop = amdgpu_ring_insert_nop,
>   	.pad_ib = amdgpu_ring_generic_pad_ib,
> +	.emit_switch_buffer = gfx_v7_0_ring_emit_sb,
>   	.emit_cntxcntl = gfx_v7_ring_emit_cntxcntl,
>   	.emit_wreg = gfx_v7_0_ring_emit_wreg,
>   	.soft_recovery = gfx_v7_0_ring_soft_recovery,

