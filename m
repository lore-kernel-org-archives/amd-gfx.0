Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 280B9C44501
	for <amd-gfx@archiver.kernel.org>; Wed, 15 Jul 2026 11:20:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BAF4510EFFF;
	Wed, 15 Jul 2026 11:20:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=ursulin.net header.i=@ursulin.net header.b="ereKaZgT";
	dkim-atps=neutral
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com
 [209.85.221.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8500010EFFF
 for <amd-gfx@lists.freedesktop.org>; Wed, 15 Jul 2026 11:20:08 +0000 (UTC)
Received: by mail-wr1-f44.google.com with SMTP id
 ffacd0b85a97d-475881b9a4bso1748208f8f.3
 for <amd-gfx@lists.freedesktop.org>; Wed, 15 Jul 2026 04:20:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ursulin.net; s=google; t=1784114407; x=1784719207; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=p1xLqNggGe5knTrFpye58dQpgRIw/ZbCq3Wy8LtvhUQ=;
 b=ereKaZgTe68Ymw8hTlw1ka4ZpZbq9jr4rnJrmdsUg2SIUEW887yex+vTgfiWGoP0cM
 S15oBFMFWAafhrEZjwcZUhdudpX9Vd7aWbn12ousYQmN+mSDwsdJ/FJmQ4CPlH2pySfm
 AS7g2xUNLN+GVWmqGNec58BsGMJtCMv3JrjU/3MRvVozycm7nfH9TWXAXUZUTzcMXcZS
 llvjzWdGaDv0WcIdhUCXt1cvF5/IJT9BuGlaLA/eI6OQCW8ZqqNcDhHEucx+/dfgm8yo
 vK4uXGPKk3J0aKQTIF0d92YNyaLjcVmPS2vnRxEpJ9LUZPBstSwvKQI3o6d+XHVBvrWr
 tzsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784114407; x=1784719207;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=p1xLqNggGe5knTrFpye58dQpgRIw/ZbCq3Wy8LtvhUQ=;
 b=fNjLjqRFUc1rTUH20R+zpNvL0j8OauLY9MKDpre7WzHJblydqS/S0sM69z2ucDCd2s
 FJoT6TXbrHYZ4EyQPCM50nuel0mmV9jJwApJVqyIesL49WzuC+mzTCXuGxccLYyf67IY
 zlI9GTXiR1G8SFUH7alaD2N4t5TYkuqyp+0Y8vhLRgE8QgnxjHI5RVCXVJeoOpsTWFXO
 Jcv0ncD/P1twcTA+hwVFrgW5fZws18mKsRtNRGB+ndNqFZ+xPspA8Rwuzm8ZOrZUdBPG
 kGIYRyrhgajqdsCde2QDiF1DYNxMEZLWuEJg6KglwvlotTd/MLVBPq7rRAJuPwgQBOqu
 MT/Q==
X-Forwarded-Encrypted: i=1;
 AHgh+Rqt8ZbZBhP7uIIEaTCI4x/ZPTjcow6HnzVx5Ctbl3BU0ae7kVGJh2QBHsuksUUiT5+f+U3FE1VB@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxHPajJDLwUVoXR6opreaKqo1fcT2ZEyU+v84sD0y2yE1L9S0b2
 c5QxzJkF7nnchmE4yEDq+bTATcKikhE++dlwAaWrFX34MIPLuT8Jzd2qVEabR+ww1tI=
X-Gm-Gg: AfdE7cm0t581U1u0G2J6DUHmUz4+ihXgSjzfiKblKR+cMtbN3L2OvvCtxWjYdd2fBwu
 wgPAURFpqNdmJgm2imp1lwYU8MXimMeozMMN8F0GbdJ9RhK5KV0SsJa3QY867GukZOKOn6W8zZF
 ItFVn54MN30J/F8PwLDKH+Co52+oz8ZW5QwB9/sVMjqfywj8pyj1hcsnQKaVr9VrIGDVkDj1DTD
 PErf/eZQHA7PAOEaCYwj1cbhPQaAmtY6PMpEgTvnDi3tPIexWeyuRAdmkSGNhT5TiDr01S0Pgg8
 hzaeQ3ZK+mAPAbSxOdnttOs+MH7E2SsQJUvnzkzMn5+YV8O5NasA05FXR5EvYgPHa30JfQicKOa
 odtUrcbwULYmSLJhXjNu8ZHpu4NgvpqsZ+7XzroS2q/tcWE3WYrFHQsqkcRjWNpn3iojTGEHR1Q
 8pn/M+fzH695NYjo6FZHdP6NpPt/Ji0V3WHLAkRlN5NRTU
X-Received: by 2002:a05:6000:3c6:b0:474:64bf:8fb6 with SMTP id
 ffacd0b85a97d-47f2dd26293mr22841280f8f.39.1784114406695; 
 Wed, 15 Jul 2026 04:20:06 -0700 (PDT)
Received: from [192.168.0.116] ([90.240.106.137])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47f464a973fsm16508487f8f.17.2026.07.15.04.20.06
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 15 Jul 2026 04:20:06 -0700 (PDT)
Message-ID: <7c7058e7-8a0e-40c7-b12a-dc4c3dabf982@ursulin.net>
Date: Wed, 15 Jul 2026 12:20:05 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/9] drm/amdgpu/gfx7: Fixup emitting SWITCH_BUFFER packets
To: =?UTF-8?Q?Timur_Krist=C3=B3f?= <timur.kristof@gmail.com>,
 amd-gfx@lists.freedesktop.org, Alex Deucher <alexander.deucher@amd.com>,
 christian.koenig@amd.com, pierre-eric.pelloux-prayer@amd.com,
 Natalie Vock <natalie.vock@gmx.de>
References: <20260713125838.30607-1-timur.kristof@gmail.com>
 <20260713125838.30607-6-timur.kristof@gmail.com>
 <fb4f5735-2ccb-4a75-8d69-d776b3f3bb84@ursulin.net>
 <7296917.jJDZkT8p0M@timur-max>
Content-Language: en-GB
From: Tvrtko Ursulin <tursulin@ursulin.net>
In-Reply-To: <7296917.jJDZkT8p0M@timur-max>
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


On 15/07/2026 11:36, Timur Kristóf wrote:
> On 2026. július 15., szerda 10:56:38 közép-európai nyári idő Tvrtko Ursulin
> wrote:
>> On 13/07/2026 13:58, Timur Kristóf wrote:
>>> Implement the emit_switch_buffer() function instead of emitting
>>> them duing emit_ib, emit_pipeline_sync and emit_vm_flush.
>>
>> during
>>
>>> Note that it isn't necessary to emit these in both
>>> emit_pipeline_sync() and emit_vm_flush() because
>>> amdgpu_vm_flush() already calls these when calling
>>> either of those functions.
>>
>> The amdgpu_vm_flush indeed does emit two switch buffers:
>>
>> 	/* the double SWITCH_BUFFER here *cannot* be skipped by COND_EXEC
> */
>> 	if (ring->funcs->emit_switch_buffer) {
>> 		amdgpu_ring_emit_switch_buffer(ring);
>> 		amdgpu_ring_emit_switch_buffer(ring);
>> 	}
>>
>> Comments are different though:
>>
>> /* sync CE with ME to prevent CE fetch CEIB before context switch done */
>>
>> Are you confident the two emissions are about the same thing?
> 
> Yes, I'm confident. One of the comments explains why the SWITCH_BUFFER packet
> is emitted, the other one explains why it is emitted outside COND_EXEC.
> 
> This packet is interpreted by the CE (constant engine). The reason why this
> packet is emitted is basically to make sure the CE can't start executing
> packets from the next submission until the current one is finished.
> 
> (Note that CE is not utilized by any maintained userspace driver and is
> discontinued in new GPUs. As far as I remember there were experiments to try
> to use the CE in Mesa but it didn't yield any noteworthy perf improvement so
> we just never used it. The old proprietary driver may have used it. It is now
> also deprecated in the kernel.)

Sounds believable to me.

>>> Signed-off-by: Timur Kristóf <timur.kristof@gmail.com>
>>> ---
>>>
>>>    drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c | 32 +++++++++------------------
>>>    1 file changed, 10 insertions(+), 22 deletions(-)
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c
>>> b/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c index 0ceadb107d26..a93cc02c3400
>>> 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c
>>> @@ -2201,12 +2201,6 @@ static void gfx_v7_0_ring_emit_ib_gfx(struct
>>> amdgpu_ring *ring,>
>>>    	unsigned vmid = AMDGPU_JOB_GET_VMID(job);
>>>    	u32 header, control = 0;
>>>
>>> -	/* insert SWITCH_BUFFER packet before first IB in the ring frame */
>>> -	if (flags & AMDGPU_HAVE_CTX_SWITCH) {
>>> -		amdgpu_ring_write(ring, PACKET3(PACKET3_SWITCH_BUFFER,
> 0));
>>> -		amdgpu_ring_write(ring, 0);
>>> -	}
>>
>> Commit message does not explain why the change of ring buffer command
>> this creates is okay. Current flow is:
>>
>> amdgpu_ib_schedule()
>> {
>> ...
>>     amdgpu_ring_emit_ib
>>       amdgpu_ring_write(ring, PACKET3(PACKET3_SWITCH_BUFFER, 0));
>>
>>
>> New flow is:
>>
>> ...
>>     amdgpu_ring_emit_ib
>> ... other ring commands ...
>>     amdgpu_ring_emit_switch_buffer
>>       amdgpu_ring_write(ring, PACKET3(PACKET3_SWITCH_BUFFER, 0));
> 
> No, that's not what the new flow is. If you check the callers of
> emit_switch_buffer() you can see that it's called from two places:
> 
> - amdgpu_vm_flush() emits it before the first IB when necessary
> - amdgpu_ib_schedule() emits it after the last IB when necessary
> 
>> Is this okay? Specifically due the above comment saying "insert
>> SWITCH_BUFFER packet before first IB in the ring frame" - is the "first"
>> part not important?
> 
> amdgpu_vm_flush() emits it before the first IB.

True, I wrote the above before I got to the vm_flush etc and forgot to 
revisit my earlier thinking.

>> Also, amdgpu_ib_schedule only emits amdgpu_ring_emit_switch_buffer if
>> there is a job. Currently it is always emitted.
> 
> I trust that the GFX8+ implementations are more precise and that it's sufficient
> to emit this packet in the cases where the emit_switch_buffer() function is
> called.

I am not sure about gfx7 vs gfx8 because in my mind it's always possible 
different hw generations may need subtly different handling. I will have 
to defer to AMD experts here.

> When there is "no job" that's a special case that is only used during
> initialization (specifically the IB ring tests). In that case we are not
> executing commands submitted by userspace but rather commands generated by the
> kernel. So we can be sure the CE is not used in those cases.

Sounds believable. I thought for a while whether a kernel submission can 
interleave with userspace, like perhaps ring test post resume, but in 
that case I guess context switch isn't needed since GPU has been 
sufficiently re-initialized?

>> Final interesting part is how amdgpu_ib_schedule clears
>> AMDGPU_HAVE_CTX_SWITCH after having called amdgpu_ring_emit_ib.
>>
>> After this change only gfx6 remains the user of that flag in
>> gfx_v6_0_ring_emit_ib. Everyone else only use it in emit_cntxcntl. If
>> gfx6 was adjusted too (later), amdgpu_ib_schedule could reduce the scope
>> of that flag to just the scope where it calls amdgpu_ring_emit_frame_cntl.
> 
> I also adjusted the same thing for GFX6 in the next series.
> Can clean up the flag later once both series are accepted.

Yep.

Regards,

Tvrtko

> 
> 
>>
>>> -
>>>
>>>    	if (ib->flags & AMDGPU_IB_FLAG_CE)
>>>    	
>>>    		header = PACKET3(PACKET3_INDIRECT_BUFFER_CONST, 2);
>>>    	
>>>    	else
>>>
>>> @@ -2258,6 +2252,12 @@ static void gfx_v7_0_ring_emit_ib_compute(struct
>>> amdgpu_ring *ring,>
>>>    	amdgpu_ring_write(ring, control);
>>>    
>>>    }
>>>
>>> +static void gfx_v7_0_ring_emit_sb(struct amdgpu_ring *ring)
>>> +{
>>> +	amdgpu_ring_write(ring, PACKET3(PACKET3_SWITCH_BUFFER, 0));
>>> +	amdgpu_ring_write(ring, 0);
>>> +}
>>> +
>>>
>>>    static void gfx_v7_ring_emit_cntxcntl(struct amdgpu_ring *ring, uint32_t
>>>    flags) {
>>>    
>>>    	uint32_t dw2 = 0;
>>>
>>> @@ -3111,14 +3111,6 @@ static void gfx_v7_0_ring_emit_pipeline_sync(struct
>>> amdgpu_ring *ring)>
>>>    	amdgpu_ring_write(ring, seq);
>>>    	amdgpu_ring_write(ring, 0xffffffff);
>>>    	amdgpu_ring_write(ring, 4); /* poll interval */
>>>
>>> -
>>> -	if (usepfp) {
>>> -		/* sync CE with ME to prevent CE fetch CEIB before
> context switch done
>>> */ -		amdgpu_ring_write(ring, PACKET3(PACKET3_SWITCH_BUFFER,
> 0));
>>> -		amdgpu_ring_write(ring, 0);
>>> -		amdgpu_ring_write(ring, PACKET3(PACKET3_SWITCH_BUFFER,
> 0));
>>> -		amdgpu_ring_write(ring, 0);
>>> -	}
>>>
>>>    }
>>>    
>>>    /*
>>>
>>> @@ -3160,12 +3152,6 @@ static void gfx_v7_0_ring_emit_vm_flush(struct
>>> amdgpu_ring *ring,>
>>>    		/* sync PFP to ME, otherwise we might get invalid PFP
> reads */
>>>    		amdgpu_ring_write(ring, PACKET3(PACKET3_PFP_SYNC_ME,
> 0));
>>>    		amdgpu_ring_write(ring, 0x0);
>>>
>>> -
>>> -		/* synce CE with ME to prevent CE fetch CEIB before
> context switch done
>>> */ -		amdgpu_ring_write(ring, PACKET3(PACKET3_SWITCH_BUFFER,
> 0));
>>> -		amdgpu_ring_write(ring, 0);
>>> -		amdgpu_ring_write(ring, PACKET3(PACKET3_SWITCH_BUFFER,
> 0));
>>> -		amdgpu_ring_write(ring, 0);
>>>
>>>    	}
>>>    
>>>    }
>>>
>>> @@ -4954,8 +4940,9 @@ static const struct amdgpu_ring_funcs
>>> gfx_v7_0_ring_funcs_gfx = {>
>>>    		7 + /* gfx_v7_0_ring_emit_hdp_flush */
>>>    		5 + /* hdp invalidate */
>>>    		12 + 12 + 12 + /* gfx_v7_0_ring_emit_fence_gfx x3 for
> user fence, vm
>>>    		fence */>
>>> -		7 + 4 + /* gfx_v7_0_ring_emit_pipeline_sync */
>>> -		CIK_FLUSH_GPU_TLB_NUM_WREG * 5 + 7 + 6 + /*
> gfx_v7_0_ring_emit_vm_flush
>>> */ +		7 + /* gfx_v7_0_ring_emit_pipeline_sync */
>>> +		CIK_FLUSH_GPU_TLB_NUM_WREG * 5 + 7 + 2 + /*
> gfx_v7_0_ring_emit_vm_flush
>>> */ +		3 * 2 + /* gfx_v7_0_ring_emit_sb x3 (from
> amdgpu_vm_flush,
>>> amdgpu_ib_schedule) */>
>>>    		3 + 4 + /* gfx_v7_ring_emit_cntxcntl including vgt
> flush*/
>>>    		5, /* SURFACE_SYNC */
>>>    	
>>>    	.emit_ib_size = 4, /* gfx_v7_0_ring_emit_ib_gfx */
>>>
>>> @@ -4969,6 +4956,7 @@ static const struct amdgpu_ring_funcs
>>> gfx_v7_0_ring_funcs_gfx = {>
>>>    	.test_ib = gfx_v7_0_ring_test_ib,
>>>    	.insert_nop = amdgpu_ring_insert_nop,
>>>    	.pad_ib = amdgpu_ring_generic_pad_ib,
>>>
>>> +	.emit_switch_buffer = gfx_v7_0_ring_emit_sb,
>>>
>>>    	.emit_cntxcntl = gfx_v7_ring_emit_cntxcntl,
>>>    	.emit_wreg = gfx_v7_0_ring_emit_wreg,
>>>    	.soft_recovery = gfx_v7_0_ring_soft_recovery,
> 
> 
> 
> 

