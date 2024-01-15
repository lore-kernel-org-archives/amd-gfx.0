Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70177C3DA79
	for <amd-gfx@archiver.kernel.org>; Mon, 15 Jan 2024 14:06:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 08B4A10E0E1;
	Mon, 15 Jan 2024 14:06:44 +0000 (UTC)
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com
 [IPv6:2a00:1450:4864:20::436])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2D09210E0E1
 for <amd-gfx@lists.freedesktop.org>; Mon, 15 Jan 2024 14:06:43 +0000 (UTC)
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-337abfd6151so396263f8f.1
 for <amd-gfx@lists.freedesktop.org>; Mon, 15 Jan 2024 06:06:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=froggi.es; s=google; t=1705327601; x=1705932401; darn=lists.freedesktop.org; 
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Ly5KHGinFqz/s/Sal2E78I/bewUaGCgFnbBwUrUn7Ic=;
 b=ZuYXoN1lUyHLqEFKzLmTATs+8uyW4uklOiE0wnWOZ3xJMh9XBQeg16H8e8cA5byOWa
 O6Eeo2TIlvdqyFst4Kflc8Yo2buOLgT8o77X5x8e00iBOeBlQiBvy5t7ECmyVkcfCoxJ
 SGtwywrBzSe28j3eIXwSN/QZwSD80zNo7mwQrZkVzAFaZGyYNsPtgUcnbbkMLch2pWPg
 X65VVFwSeAlBoENXMK88YjG1gcZ/NW83CYb3k4yaLV0hD7yzvKIG6uLmT4bJ3z47V2D3
 u/ssuMDVfBpmLU6JGDh0TZQcVb+KoCBvTqdzlUBpLCd7CWurJut/LJPelGT8XTwIzyHJ
 gy9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705327601; x=1705932401;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Ly5KHGinFqz/s/Sal2E78I/bewUaGCgFnbBwUrUn7Ic=;
 b=GIHNRxvsAchTMSnsk7dGu1pd14DkMbPjiv7h+mS2yDC/KTNHM7RYSsX0YJN2VnVy8l
 O331Znbgcy0bMrJMZlBgFkq8azbUEE/Rdur+CI0CQlip6KvSNaTCuou4wBsI/4TBTLxS
 BFbIH6RCRvgqUdxzjEx+QCXZoCvv0jnXyd0p/ViXD00Gn3JzsaSDLuP5nnnVK93rMjzv
 IiR/+hJ0lkpmvUDd342sXpLGVwSu4SV45xm/7XG4m/FFFqWIJNUp6cF5/2zsp2UCuwmx
 E8yptPWZKVO+8b7+k1VZ1GMHcVNBXZs3UJhKqwKBJ1MUbXbaGk7sl0USubSVckd9yATe
 GSWA==
X-Gm-Message-State: AOJu0Yw06TOI46d61mseFbreg2ooue+YlzIJv0dgncGpbZogAoxDr56e
 t/+aqueeAVqVC3I4dwFzM0+1grXK6YmhUf6gzxRpUyVSThE=
X-Google-Smtp-Source: AGHT+IFcLLey+G9TKlXDnCVILLG78zPQm+EByzmlJpmV5IUhlzVYF9ZM15/p39d9s2ezA6n8SnpjAw==
X-Received: by 2002:adf:f446:0:b0:337:aeee:4bad with SMTP id
 f6-20020adff446000000b00337aeee4badmr347175wrp.142.1705327600889; 
 Mon, 15 Jan 2024 06:06:40 -0800 (PST)
Received: from [192.168.0.89]
 (darl-09-b2-v4wan-165404-cust288.vm5.cable.virginm.net. [86.17.61.33])
 by smtp.gmail.com with ESMTPSA id
 a18-20020adffad2000000b003373ece28efsm12022041wrs.29.2024.01.15.06.06.40
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 15 Jan 2024 06:06:40 -0800 (PST)
Message-ID: <623e23c4-a31c-4c7f-90a3-a292e95d42ef@froggi.es>
Date: Mon, 15 Jan 2024 14:06:39 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] drm/amdgpu: Mark ctx as guilty in ring_soft_recovery
 path
Content-Language: en-US
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 amd-gfx@lists.freedesktop.org, =?UTF-8?Q?Michel_D=C3=A4nzer?=
 <michel@daenzer.net>
References: <20240113140206.2383133-1-joshua@froggi.es>
 <20240113140206.2383133-2-joshua@froggi.es>
 <c9b839cd-4c42-42a6-8969-9a7b54d4fbe8@amd.com>
 <0e701278-a633-403c-b397-e4f772d66c5a@froggi.es>
 <aca706e6-58bc-4c38-bbfe-19137f38c897@gmail.com>
From: Joshua Ashton <joshua@froggi.es>
In-Reply-To: <aca706e6-58bc-4c38-bbfe-19137f38c897@gmail.com>
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
Cc: Friedrich Vock <friedrich.vock@gmx.de>,
 =?UTF-8?Q?Andr=C3=A9_Almeida?= <andrealmeid@igalia.com>,
 Bas Nieuwenhuizen <bas@basnieuwenhuizen.nl>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>



On 1/15/24 13:17, Christian König wrote:
> Am 15.01.24 um 12:37 schrieb Joshua Ashton:
>> On 1/15/24 09:40, Christian König wrote:
>>> Am 13.01.24 um 15:02 schrieb Joshua Ashton:
>>>> We need to bump the karma of the drm_sched job in order for the context
>>>> that we just recovered to get correct feedback that it is guilty of
>>>> hanging.
>>>
>>> Big NAK to that approach, the karma handling is completely deprecated.
>>>
>>> When you want to signal execution errors please use the fence error 
>>> code.
>>
>> The fence error code does not result in ctx's being marked as guilty, 
>> only the karma path does.
>>
>> See drm_sched_increase_karma.
>>
>> Are you proposing that we instead mark contexts as guilty with the 
>> fence error ourselves here?
> 
> No, I'm proposing to completely abandon the concept of guilty contexts. 
> Basically what we should do is to return an error from the CS IOCTL 
> whenever a previous submission resulted in a fatal error as suggested by 
> Marek.

Oh, I agree that is broken by design, but this is already implemented 
with the current guilt system!

The ioctls already will return -ECANCELLED if you are guilty of a hang:

https://elixir.bootlin.com/linux/latest/source/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c#L64

The query merely exists to give more feedback as to the situation, which 
is fine.

> 
> That we query the context for guilty was just a design decision we 
> copied over from our closed source drivers which turned out to 
> absolutely not solving anything.
> 
> Marek can probably comment as well why the whole idea of querying the 
> kernel if something fatal happens instead of just rejecting submissions 
> is broken by design.
> 
>>>
>>>> Without this feedback, the application may keep pushing through the 
>>>> soft
>>>> recoveries, continually hanging the system with jobs that timeout.
>>>
>>> Well, that is intentional behavior. Marek is voting for making soft 
>>> recovered errors fatal as well while Michel is voting for better 
>>> ignoring them.
>>>
>>> I'm not really sure what to do. If you guys think that soft recovered 
>>> hangs should be fatal as well then we can certainly do this.
>>
>> They have to be!
>>
>> As Marek and I have pointed out, applications that hang or fault will 
>> just hang or fault again, especially when they use things like draw 
>> indirect, buffer device address, descriptor buffers, etc.
> 
> Ok, well then I now have two people (Marek and you) saying that soft 
> recovery should be fatal while Michel is saying that soft recovery being 
> non fatal improves stability for him :)
> 
> Should we somehow make that configurable or depend it on if that's the 
> display server or if it's an user application?

I could probably get every RADV developer, and all of the Proton 
graphics team to come in and preach the same thing also. :P

If a compositor/display server is guilty of a hang, it can just listen 
for DEVICE_LOST from vkQueueSubmit and re-create it's context, re-import 
the dmabufs etc (or restart itself).

FWIU, in the email chain, the thing Daenzer was saying was that Firefox 
was falling back to software rendering even when it was innocent, but 
that seems incredibly broken by design.

- Joshie 🐸✨

> 
> Regards,
> Christian.
> 
>>
>> The majority of apps these days have a lot of side effects and 
>> persistence between frames and submissions.
>>
>> - Joshie 🐸✨
>>
>>>
>>> Regards,
>>> Christian.
>>>
>>>>
>>>> There is an accompanying Mesa/RADV patch here
>>>> https://gitlab.freedesktop.org/mesa/mesa/-/merge_requests/27050
>>>> to properly handle device loss state when VRAM is not lost.
>>>>
>>>> With these, I was able to run Counter-Strike 2 and launch an 
>>>> application
>>>> which can fault the GPU in a variety of ways, and still have Steam +
>>>> Counter-Strike 2 + Gamescope (compositor) stay up and continue
>>>> functioning on Steam Deck.
>>>>
>>>> Signed-off-by: Joshua Ashton <joshua@froggi.es>
>>>>
>>>> Cc: Friedrich Vock <friedrich.vock@gmx.de>
>>>> Cc: Bas Nieuwenhuizen <bas@basnieuwenhuizen.nl>
>>>> Cc: Christian König <christian.koenig@amd.com>
>>>> Cc: André Almeida <andrealmeid@igalia.com>
>>>> Cc: stable@vger.kernel.org
>>>> ---
>>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c | 2 ++
>>>>   1 file changed, 2 insertions(+)
>>>>
>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c 
>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
>>>> index 25209ce54552..e87cafb5b1c3 100644
>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
>>>> @@ -448,6 +448,8 @@ bool amdgpu_ring_soft_recovery(struct 
>>>> amdgpu_ring *ring, struct amdgpu_job *job)
>>>>           dma_fence_set_error(fence, -ENODATA);
>>>>       spin_unlock_irqrestore(fence->lock, flags);
>>>> +    if (job->vm)
>>>> +        drm_sched_increase_karma(&job->base);
>>>>       atomic_inc(&ring->adev->gpu_reset_counter);
>>>>       while (!dma_fence_is_signaled(fence) &&
>>>>              ktime_to_ns(ktime_sub(deadline, ktime_get())) > 0)
>>>
>>
>>
> 
