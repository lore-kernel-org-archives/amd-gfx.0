Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21308C52D6F
	for <amd-gfx@archiver.kernel.org>; Wed,  7 Aug 2024 08:21:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8B7C210E455;
	Wed,  7 Aug 2024 08:21:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=ursulin-net.20230601.gappssmtp.com header.i=@ursulin-net.20230601.gappssmtp.com header.b="yOKNmXSI";
	dkim-atps=neutral
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com
 [209.85.221.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 040A610E455
 for <amd-gfx@lists.freedesktop.org>; Wed,  7 Aug 2024 08:21:30 +0000 (UTC)
Received: by mail-wr1-f49.google.com with SMTP id
 ffacd0b85a97d-36887ca3da2so856754f8f.2
 for <amd-gfx@lists.freedesktop.org>; Wed, 07 Aug 2024 01:21:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ursulin-net.20230601.gappssmtp.com; s=20230601; t=1723018889; x=1723623689;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=lsoTLOVoNYPgJZAty+thpJIbDyUyBckwR06z6pRSwaw=;
 b=yOKNmXSIMo5gSNW5FarfOIBurzT3egFftEbWw4lYF1ux/N18YnI9fX2JoJXydG5uLl
 Nk+dWckBhwObe1Bj0hlCRhmNI9d1LfHk2MlxNS6+4odIyva9Id+1IpDQaiumb/szclk2
 vfGmJHJEYaVspBLOYQLgxCRNbNQaeyuNU+XDWWQJvzuHrPH5RTaSMPmPwlhiv0bTrAy8
 4yEXmXIdSVcQ4FFLeq1UsGiCyMepmHKeIn+YIVxYoP+GOTCiTQ3Gy3j+9xSFCdB7lsZw
 no5HtRSbVZScZ4d6roRSkZigdF67F+L7bul7LGeic8RAkldqLHbjUjNRExsfWXPZQCXe
 +Y0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723018889; x=1723623689;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=lsoTLOVoNYPgJZAty+thpJIbDyUyBckwR06z6pRSwaw=;
 b=dyTiKEAGDJN8iqhiLLblSgopN3Ye0v+n3lN0MEDeo75dBlV8IuDt1rR7oi68aLfxss
 fKol/3xaIa9wtQoZ6r3qx2JmJw8K+TMiUJFzN4wR9Km92MoJ4nJdpmWWd3f3ukteKu2D
 BeF0TtGPsomlItVq66AxwVzYyZf7tlZM/i7DwA5Z74HkBktJ+z4QlGviloNKbJ2bM/1/
 tX2PCERQu+HtpUGmzahbRRlHIvQxjWSfWoOehYjVXPKUDIUwcda02YlElDbiMkPpLG8P
 Gb6X3xXaPJcge0RKAN4bpmyJo0nabRrqOsAPgzPt7JXiqzxTtAaW9VQDUQZa8xwp8Hpo
 O2wg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWQ5MVXWDHMhFn3vxWkiNPVcTfT2aFOGjFM5BfYne6hjFW5e+wwUJ6oo0nTNXBVCQY54y1aVYH8tviLdv+2GMHE9DColF9nK+0NcAsLkA==
X-Gm-Message-State: AOJu0Yz/JC7FjgC7cu2jen/yWANcF/+UbV1umejlw7mseLGwvx4qC9Oy
 5s3JUYsSxshlYB9CFi0DwhsuDc5qOiKARmSpnz8DP/CD113hn3+MV60aUmecqTI=
X-Google-Smtp-Source: AGHT+IH9af0/BSAzJZjEfbW6PpzLqtrBWS//dkenCHLvtZa/TLjNPClR+1+nnGseiHYcKiBXttcccA==
X-Received: by 2002:a5d:6287:0:b0:368:7f4f:9e95 with SMTP id
 ffacd0b85a97d-36bbc0e5ee5mr9806352f8f.10.1723018888842; 
 Wed, 07 Aug 2024 01:21:28 -0700 (PDT)
Received: from [192.168.0.101] ([84.69.19.168])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-36bbd26fc0bsm15248909f8f.117.2024.08.07.01.21.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 07 Aug 2024 01:21:28 -0700 (PDT)
Message-ID: <104cabc4-69a1-4faa-9837-d5b4dc7a5202@ursulin.net>
Date: Wed, 7 Aug 2024 09:21:27 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: optimize the padding with hw optimization
To: =?UTF-8?B?TWFyZWsgT2zFocOhaw==?= <maraeo@gmail.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Cc: "Khatri, Sunil" <sukhatri@amd.com>, Sunil Khatri <sunil.khatri@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 amd-gfx mailing list <amd-gfx@lists.freedesktop.org>,
 Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>,
 Tvrtko Ursulin <tursulin@igalia.com>, =?UTF-8?B?TWFyZWsgT2zFocOhaw==?=
 <marek.olsak@amd.com>
References: <20240730124332.38030-1-sunil.khatri@amd.com>
 <CAAxE2A5hEezckDEk1jJwFdfddpN1VXJtU+Yp5uXfsM2aiV2Cxg@mail.gmail.com>
 <28927b0d-f97f-451b-af03-943f8c85f92d@amd.com>
 <CAAxE2A7C3fuExvvjTytCR7fYNjoDTDzAqK2JroSihcz6EX7X2A@mail.gmail.com>
 <18c7c805-d2ec-4448-bd25-cdb106aeac7e@amd.com>
 <CAAxE2A7XBQfUnYhSg2RS7TP_i6cv775RW0ocdgAyc-F0dsSqmQ@mail.gmail.com>
 <CAAxE2A5EJGxR8XWnperC2tYjA+x1XwpqEAFC+9LR-Cs+74BpyA@mail.gmail.com>
Content-Language: en-GB
From: Tvrtko Ursulin <tursulin@ursulin.net>
In-Reply-To: <CAAxE2A5EJGxR8XWnperC2tYjA+x1XwpqEAFC+9LR-Cs+74BpyA@mail.gmail.com>
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


On 04/08/2024 19:11, Marek Olšák wrote:
> On Thu, Aug 1, 2024 at 2:55 PM Marek Olšák <maraeo@gmail.com> wrote:
>>
>> On Thu, Aug 1, 2024, 03:37 Christian König <christian.koenig@amd.com> wrote:
>>>
>>> Am 01.08.24 um 08:53 schrieb Marek Olšák:
>>>
>>> On Thu, Aug 1, 2024, 00:28 Khatri, Sunil <sukhatri@amd.com> wrote:
>>>>
>>>>
>>>> On 8/1/2024 8:49 AM, Marek Olšák wrote:
>>>>>> +       /* Header is at index 0, followed by num_nops - 1 NOP packet's */
>>>>>> +       for (i = 1; i < num_nop; i++)
>>>>>> +               amdgpu_ring_write(ring, ring->funcs->nop);
>>>>> This loop should be removed. It's unnecessary CPU overhead and we
>>>>> should never get more than 0x3fff NOPs (maybe use BUG_ON). Leaving the
>>>>> whole packet body uninitialized is the fastest option.
>>>> That was the original intent to just move the WPTR for the no of nops
>>>> and tried too. Based on Christian inputs we should not let the nops packet
>>>>
>>>> as garbage or whatever was there originally as a threat/safety measure.
>>>
>>>
>>> It doesn't help safety. It can only be read by the GPU with kernel-level permissions.
>>>
>>> Initializing the packet body is useless and adds CPU overhead, especially with the 256 NOPs or so that we use for no reason.
>>>
>>>
>>> Not filling the remaining ring buffers with NOPs is a pretty clear NAK from my side. Leaving garbage in the ring buffer is not even remotely defensive.
>>
>>
>> What are you defending against? You know the ring is kernel-owned memory, right?
> 
> This was pushed without any justification why you need to clear
> kernel-allocated memory with some constant number up to 30000 times
> per second that only the kernel can read.

I see that this seems to be controversial, but FWIW, if the loop ends up 
staying, at least we could replace it with memset32 as I have shown in 
https://lore.kernel.org/amd-gfx/20240715104026.6311-1-tursulin@igalia.com/ 
that the inefficient amdgpu_ring_write can show up in the profile.

And also maybe consider other than gfx? Again, I did something in 
https://lore.kernel.org/amd-gfx/20240712152855.45284-4-tursulin@igalia.com/, 
but AMD folks will know if there is a similar (like in this series) 
approach which also improves the GPU side processing and not just CPU side.

Regards,

Tvrtko
