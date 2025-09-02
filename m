Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02CDDCA0FFE
	for <amd-gfx@archiver.kernel.org>; Tue,  2 Sep 2025 11:39:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9E54D10E673;
	Tue,  2 Sep 2025 11:39:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=ursulin-net.20230601.gappssmtp.com header.i=@ursulin-net.20230601.gappssmtp.com header.b="m9ihMO7R";
	dkim-atps=neutral
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com
 [209.85.128.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 702AC10E673
 for <amd-gfx@lists.freedesktop.org>; Tue,  2 Sep 2025 11:39:53 +0000 (UTC)
Received: by mail-wm1-f47.google.com with SMTP id
 5b1f17b1804b1-45b9853e630so5815635e9.0
 for <amd-gfx@lists.freedesktop.org>; Tue, 02 Sep 2025 04:39:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ursulin-net.20230601.gappssmtp.com; s=20230601; t=1756813192; x=1757417992;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=mlfet44fkJh4lSrtSB0vWZATPsFclwg3JEG3lempfCo=;
 b=m9ihMO7R0zv9Q0CEaQFWJQpRGRHnNcasbH6NVqCS2fXG9fxdfqTniFpgYLJ2o95XKF
 TqqanGE7K8XA9tPLwO4eHhOgrF1dyzXdxqOK6sTsv2D8bP2qJEc3cjXWhRGxhfnSuTVS
 0mXCO/foAE4eWmP09pNKencvsYe2/ERF3+G/dumdQb+9L90wGiHasNKm+U6NWIj4b4QN
 z2BubPOAv1gewSGeMJ+nEMq4EEVf5dW7LSiKHV79lYJDWDlXjvGFoYHWwtbtXqPp224V
 UtK93Ttqs/HwMv6/Y9AJrre2TNSWZcmhXv9mzQcxY6+MfLxykv1NhOmAKmwj7FtEvosx
 AegA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756813192; x=1757417992;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=mlfet44fkJh4lSrtSB0vWZATPsFclwg3JEG3lempfCo=;
 b=W0pvKD1/yvZJTznYy56VFYIVuc7yAywIQxvOBYcRM0OMoYRGn8iYMkSfhKJe+s7Hoc
 urSyZRmioL1ZxNHYsQACQWrUMipjtxLjZA8ebn7/QrqvhTxiI5WZE2ikuvSV520bE/fv
 9Q0ZAqlxxt8fGHFkNZETWtltuxoJHqe/QWoFZ3s6EzbRKdOZ5wtPiznTNE6TeKF9dPZT
 4KmQCYrPjlDAyg6JHi4Gloia/5R/UCynmYzHYqwVIyB7zdQj68M/bIutyZvEFkx6h2kG
 OBFnRZIpWSJhaqkXl+OLiCGiq5aboMmL9GkaqIDMIjT2bkU+/oYt33zhlIhZboD/7RXF
 t2oA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWF4C5B60oDgFAWBfpdidTNl9WQo+hgcXzaUsJbBJB0BhoV50mgRI0UWLxD29qC+nqG1nZKAprw@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxNk2s2Deppw1MfRy5YhfGqGCbtugQ1q0PbcxDexrn1KA+Qtj1k
 +UUl7qShaI5Py5OPh4byJKa+tsmmnoBZnq6tvu6jc4mBWcb7iDGsvU9/WP/Ipg22Ir2Kget7Xuj
 0cM2/5jU=
X-Gm-Gg: ASbGnctvFoXwv/jytho2T1DLwJMdcovPVduGTcGSV39USnbogoxqjHtxngoBvmtZ97A
 eqlxWgFpJzoOQIQRkBHUh826xAcpMl5Zy4tqIn6ms4pnNmlHaPg/ygCdREZ1ebB6tUfH9po7h4W
 qbLFcaTl1Wp5TH43wRbMYeyMe0HdpK3z7o7OEGxeO3HW+LID/wGqUh2mYX6EHwRyAsQ6lfs3WfV
 XeQVGnLa8KBfA7Zz9gHx+SgS3UFVU4zj3Bqm/K3zJ3cMENG52ZoxmYPHJKY0kzMg1p3ISiopOMS
 5HJT2BLSy0bBqqw7KYXOB13ZSn2Rcs5BBmn1LFgY2UZh1wOUvxqhfimhVOpRI5lUFbnnxc7q9tT
 erBBVj50UXa63E5LZyZp0fUOkzNOG9kAD3Z3yzWC3M2hkHA==
X-Google-Smtp-Source: AGHT+IEKaE1jPtrxm3J3EVtjGqM8MXIx154dS+hIiynhUs+epSPEFFMZhfJFiwpDqnrH8SIV2JWMKw==
X-Received: by 2002:a05:600c:46c8:b0:43d:fa59:af97 with SMTP id
 5b1f17b1804b1-45b855bf801mr83190325e9.32.1756813191683; 
 Tue, 02 Sep 2025 04:39:51 -0700 (PDT)
Received: from [192.168.0.101] ([84.66.36.92])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3cf34491a65sm19057288f8f.56.2025.09.02.04.39.50
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 02 Sep 2025 04:39:51 -0700 (PDT)
Message-ID: <75193f5e-2f95-41e5-aba7-dafcd86f900b@ursulin.net>
Date: Tue, 2 Sep 2025 12:39:50 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/4] drm/amdgpu: Fill extra dwords with NOPs
To: =?UTF-8?Q?Timur_Krist=C3=B3f?= <timur.kristof@gmail.com>,
 amd-gfx@lists.freedesktop.org
Cc: alexander.deucher@amd.com, christian.koenig@amd.com
References: <20250901100012.439155-1-timur.kristof@gmail.com>
 <20250901100012.439155-3-timur.kristof@gmail.com>
 <9d3566f4-9ede-4d4c-8849-2ccac3fa65a6@ursulin.net>
 <1aef6170994c05c98f215690665f837529da5950.camel@gmail.com>
Content-Language: en-GB
From: Tvrtko Ursulin <tursulin@ursulin.net>
In-Reply-To: <1aef6170994c05c98f215690665f837529da5950.camel@gmail.com>
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


On 02/09/2025 12:30, Timur Kristóf wrote:
> On Mon, 2025-09-01 at 11:13 +0100, Tvrtko Ursulin wrote:
>>
>> Hi,
>>
>> On 01/09/2025 11:00, Timur Kristóf wrote:
>>> Technically not necessary, but clear the extra dwords too,
>>> so that the command processors don't read uninitialized memory.
>>>
>>> Fixes: c8c1a1d2ef04 ("drm/amdgpu: define and add extra dword for
>>> jpeg ring")
>>> Signed-off-by: Timur Kristóf <timur.kristof@gmail.com>
>>> ---
>>>    drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h | 5 +++++
>>>    1 file changed, 5 insertions(+)
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
>>> index 7670f5d82b9e..6a55a85744a9 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
>>> @@ -474,6 +474,11 @@ static inline void
>>> amdgpu_ring_clear_ring(struct amdgpu_ring *ring)
>>>    	while (i <= ring->buf_mask)
>>>    		ring->ring[i++] = ring->funcs->nop;
>>>    
>>> +	/* Technically not necessary, but clear the extra dwords
>>> too,
>>> +	 * so that the command processors don't read uninitialized
>>> memory.
>>> +	 */
>>> +	for (i = 0; i < ring->funcs->extra_dw; i++)
>>> +		ring->ring[ring->ring_size / 4 + i] = ring->funcs-
>>>> nop;
>>
>> Should I resend this maybe?
> 
> 
> Hi Tvrtko,
> 
> The patch you commented on is going to be dropped.
> 
> However, your patch makes good sense, so I can include it in the next
> version of this series if that's OK.

Yes, (more than) fine by me. Thanks!

Tvrtko

> 
> @Christian - does that sound alright to you?
> 
> 
>>
>> commit 11b0b5d942fe46bfb01f021cdb0616c8385d5ea8
>> Author: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
>> Date:   Thu Dec 26 16:12:37 2024 +0000
>>
>>       drm/amdgpu: Use memset32 for ring clearing
>>
>>       Use memset32 instead of open coding it, just because it is
>>       a tiny bit nicer.
>>
>>       Signed-off-by: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
>>       Cc: Christian König <christian.koenig@amd.com>
>>       Cc: Sunil Khatri <sunil.khatri@amd.com>
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
>> index dee5a1b4e572..96bfc0c23413 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
>> @@ -369,10 +369,7 @@ static inline void
>> amdgpu_ring_set_preempt_cond_exec(struct amdgpu_ring *ring,
>>
>>    static inline void amdgpu_ring_clear_ring(struct amdgpu_ring *ring)
>>    {
>> -       int i = 0;
>> -       while (i <= ring->buf_mask)
>> -               ring->ring[i++] = ring->funcs->nop;
>> -
>> +       memset32(ring->ring, ring->funcs->nop, ring->buf_mask + 1);
>>    }
>>
>>    static inline void amdgpu_ring_write(struct amdgpu_ring *ring,
>> uint32_t v)
>>
>> Looks like with two loops it would made even more sense to
>> consolidate.
>>
>> Regards,
>>
>> Tvrtko
>>
>>>    }
>>>    
>>>    static inline void amdgpu_ring_write(struct amdgpu_ring *ring,
>>> uint32_t v)
>>

