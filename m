Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BEE3AC47258
	for <amd-gfx@archiver.kernel.org>; Tue, 16 Jan 2024 20:12:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 686D010E54A;
	Tue, 16 Jan 2024 20:12:29 +0000 (UTC)
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com
 [209.85.128.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 576E410E54A
 for <amd-gfx@lists.freedesktop.org>; Tue, 16 Jan 2024 20:12:28 +0000 (UTC)
Received: by mail-wm1-f52.google.com with SMTP id
 5b1f17b1804b1-40e86a9fc4bso7314905e9.2
 for <amd-gfx@lists.freedesktop.org>; Tue, 16 Jan 2024 12:12:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=froggi.es; s=google; t=1705435887; x=1706040687; darn=lists.freedesktop.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=UImNBof7XTi5Qd4STuKGkwbZ+eeo+gQenDgC0NINrRo=;
 b=RbBuTb6R8ekQGlh8Cp+pJTP0hs4uwWKrPa4mHT4UwDHHnAZzwz2iOI0J1KLk9FTvQe
 O9ww4P8pjopDbzflFskH+jHIEUuvzsklmbP429FgSc9HyQOj+aZH9lErJd8mijwQxjxO
 ZF5EAZppYvL1/fUDcDujQJ+MaCGlhlbrH7kVhU3X2vw+T68Kg5SAszmRMjW9YcPlgFk3
 AMFAUER27yHcH/8mtQS18Oiu5Y8vtKq4sgrKuyzdx8nTzLs82GbDJ3exnkqPnxHXbH8T
 p96mYZ3tLDH4t8MWSwUOIpA1z78D6ZGRLJA3ABjaVA7hdA99RcmeYJI2sMURDkGJrFLK
 dWdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705435887; x=1706040687;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=UImNBof7XTi5Qd4STuKGkwbZ+eeo+gQenDgC0NINrRo=;
 b=ZyE/MlVlHvwLwuvJPJX6g/2ja7T+hLW02rWs8LjAop7/Qbax07ejnbqfPoMHctq+//
 nm3oSD9yfcUOTyN++7h4zpVCD93sDXNCcC7bR28vFcNu6sbSeZC3wp8W4qp+V4psvW3s
 s91DrYraCApiC2d79oJdCjuOhE3+AZ92vKDSMToop9TMh+CSknotfKvMGufG0Z8TLYQa
 JxdXH9UXOpsEIieBtoHPuOkzqAIqJ98uLy/G4Is5FaPrKDh+4LaJ5ETdHPjU/nPOKHjF
 J8D9/9njq+w17ICKgDfrkS0y1Z0camy/8TBktNuzmBvM7fFNr5vCjpGnCeHImEbbVGn6
 smHg==
X-Gm-Message-State: AOJu0YxrQ+rqER59cM83VXFEpMtjZ+aJbgwnbKjd0sWBYBI/9ApFx/3Y
 vzLq7BKII+m7tEMmWxLIYhUhQ/J5JxhkkJ5JeZllNAl/XW8=
X-Google-Smtp-Source: AGHT+IF/2kT4v+xoJcMUkFkF66A29pQU5XQcPughObkIn5B0QYVWdPNMMoBHZLfNJd9PyTg6OFNtvQ==
X-Received: by 2002:a05:600c:420c:b0:40e:4d77:dbfb with SMTP id
 x12-20020a05600c420c00b0040e4d77dbfbmr3795125wmh.83.1705435886653; 
 Tue, 16 Jan 2024 12:11:26 -0800 (PST)
Received: from [192.168.0.89]
 (darl-09-b2-v4wan-165404-cust288.vm5.cable.virginm.net. [86.17.61.33])
 by smtp.gmail.com with ESMTPSA id
 x18-20020adfffd2000000b003377680c55bsm15319886wrs.16.2024.01.16.12.11.25
 for <amd-gfx@lists.freedesktop.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 16 Jan 2024 12:11:25 -0800 (PST)
Message-ID: <40005162-b086-40ca-9531-eb6aa84b5017@froggi.es>
Date: Tue, 16 Jan 2024 20:11:23 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] drm/atomic: Allow drivers to write their own plane
 check for async
To: amd-gfx@lists.freedesktop.org
References: <20240116045159.1015510-1-andrealmeid@igalia.com>
 <20240116114522.5b83d8b6@eldfell>
 <a6099681-1ae9-48ef-99bc-d3c919007413@igalia.com>
 <20240116151414.10b831e6@eldfell>
 <47c6866a-34d6-48b1-a977-d21c48d991dc@igalia.com>
Content-Language: en-US
From: Joshua Ashton <joshua@froggi.es>
In-Reply-To: <47c6866a-34d6-48b1-a977-d21c48d991dc@igalia.com>
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



On 1/16/24 13:35, André Almeida wrote:
> + Joshua
> 
> Em 16/01/2024 10:14, Pekka Paalanen escreveu:
>> On Tue, 16 Jan 2024 08:50:59 -0300
>> André Almeida <andrealmeid@igalia.com> wrote:
>>
>>> Hi Pekka,
>>>
>>> Em 16/01/2024 06:45, Pekka Paalanen escreveu:
>>>> On Tue, 16 Jan 2024 01:51:57 -0300
>>>> André Almeida <andrealmeid@igalia.com> wrote:
>>>>> Hi,
>>>>>
>>>>> AMD hardware can do more on the async flip path than just the 
>>>>> primary plane, so
>>>>> to lift up the current restrictions, this patchset allows drivers 
>>>>> to write their
>>>>> own check for planes for async flips.
>>>>
>>>> Hi,
>>>>
>>>> what's the userspace story for this, how could userspace know it 
>>>> could do more?
>>>> What kind of userspace would take advantage of this and in what 
>>>> situations?
>>>>
>>>> Or is this not meant for generic userspace?
>>>
>>> Sorry, I forgot to document this. So the idea is that userspace will
>>> query what they can do here with DRM_MODE_ATOMIC_TEST_ONLY calls,
>>> instead of having capabilities for each prop.
>>
>> That's the theory, but do you have a practical example?
>>
>> What other planes and props would one want change in some specific use
>> case?
>>
>> Is it just "all or nothing", or would there be room to choose and pick
>> which props you change and which you don't based on what the driver
>> supports? If the latter, then relying on TEST_ONLY might be yet another
>> combinatorial explosion to iterate through.
>>
> 
> That's a good question, maybe Simon, Xaver or Joshua can share how they 
> were planning to use this on Gamescope or Kwin.

Gamescope would just like to do async updates for overlay planes eg. the 
perf overlay etc.

That way we can avoid having to do sync commits when we have the perf 
overlay up.

It'd also be nice to do always do some form of async updates for VRR for 
the overlay planes.

- Joshie 🐸✨

> 
>>
>> Thanks,
>> pq
>>
>>>>> I'm not sure if adding something new to drm_plane_funcs is the 
>>>>> right way to do,
>>>>> because if we want to expand the other object types (crtc, 
>>>>> connector) we would
>>>>> need to add their own drm_XXX_funcs, so feedbacks are welcome!
>>>>>
>>>>>     André
>>>>>
>>>>> André Almeida (2):
>>>>>     drm/atomic: Allow drivers to write their own plane check for async
>>>>>       flips
>>>>>     drm/amdgpu: Implement check_async_props for planes
>>>>>
>>>>>    .../amd/display/amdgpu_dm/amdgpu_dm_plane.c   | 30 +++++++++
>>>>>    drivers/gpu/drm/drm_atomic_uapi.c             | 62 
>>>>> ++++++++++++++-----
>>>>>    include/drm/drm_atomic_uapi.h                 | 12 ++++
>>>>>    include/drm/drm_plane.h                       |  5 ++
>>>>>    4 files changed, 92 insertions(+), 17 deletions(-)
>>
