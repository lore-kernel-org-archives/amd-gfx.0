Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27F22C04FFE
	for <amd-gfx@archiver.kernel.org>; Tue, 14 May 2024 15:14:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7DF5710EA81;
	Tue, 14 May 2024 15:14:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=ursulin-net.20230601.gappssmtp.com header.i=@ursulin-net.20230601.gappssmtp.com header.b="S147mEFS";
	dkim-atps=neutral
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com
 [209.85.128.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 511EA10EA2D
 for <amd-gfx@lists.freedesktop.org>; Tue, 14 May 2024 15:14:06 +0000 (UTC)
Received: by mail-wm1-f53.google.com with SMTP id
 5b1f17b1804b1-4200ee78f34so25051505e9.3
 for <amd-gfx@lists.freedesktop.org>; Tue, 14 May 2024 08:14:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ursulin-net.20230601.gappssmtp.com; s=20230601; t=1715699644; x=1716304444;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=KurA896H+ekWTFMewn5Wz7taM6zJz2DxHIh6N72+0ng=;
 b=S147mEFSyAjDN6ZbNG9dZVLVY52HE+ZAHvgL3buamki+GyHcr93FSfwKHwjHoYiOez
 mnCor5ZYGprTy6XL4q3c/+FhOzTqNDdXo0/LwdNdfLKA1DrU8zIzwGR7oyItxYutrLvl
 JD8H4rGez2mwyJ2bm/IzDhinwmrdqJSL6R2XP3PZ9w/Yz2Jgn+vkGxAZJReqUbBh9Fl8
 NL7nrKPYKaKABbBOLiPPpKojoB+bSqso1wzIX/CuUBm3sESPoG/TUEHMTavj/XI3V/fr
 bMqUTWz6rbkQvcXr0CMQ/9IFUCry2I2pHmfmXLdPtnzLFmGF37gzukeD8TV3VxubCtxY
 ThrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715699644; x=1716304444;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=KurA896H+ekWTFMewn5Wz7taM6zJz2DxHIh6N72+0ng=;
 b=Epa/b2Jw6uJlu9vbK47TzBAwtWM26A421OorZSnt3HA69ihdVzpAbaJ61OL6HyRP+f
 GqBlYZC0rux/AVYDXgdw4+tnAq9P2c6d93jsSpDV8Ib5ujCPLOZXFUqOIaBkV7m+4yJ2
 sQoRgMhT9a3FQa4hKpTirUSi8tIjyg6dY5fkVNPDVn141tfsWt7Zc2zFOQo3prq338MU
 W1AGKo6ffBi0cJ/4I9gPtV/oi6Ry8YCkRxHoTxZGM8ZVgHYS3BYzajVkQQaS9xUkpMLs
 L+34bIVmLbAMQm7zy1Z3QvoO8UCaYsaBkUas/FxADGv0Seug56n86WCB9tclQBLs6HRk
 dI+Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCVuZZnZxfgNBQGmz4QGZbWozm0pPn2FjiGw0JHJVrd/sa+GUNk2adPNOFS9GUya5Vo3kLS2Tg9k4MsFYR8lxfeObZUpIZhc9qRYmw+SIg==
X-Gm-Message-State: AOJu0YxTNO1CIZLcIKaQ5BQRdFzVgyA6/VXgYAUn3tfVbwUDN6BHYI/9
 ovmXFFXbt2Sm5CQb+SOA/gxodjCVUYg8/FLdNTd8+ImZQ6gTCS+GPc4SdzAbHHo=
X-Google-Smtp-Source: AGHT+IHtHlQ5sGT+p3F9DNEKJbfHQCTdCDNXNUlBJH+aswx+dRfFypB+mJjd+mEJPDV3qF+ztCjJJA==
X-Received: by 2002:a05:600c:4f93:b0:41c:97e:2100 with SMTP id
 5b1f17b1804b1-41fea93a251mr87848035e9.3.1715699644381; 
 Tue, 14 May 2024 08:14:04 -0700 (PDT)
Received: from [192.168.0.101] ([84.69.19.168])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-41ff6cbe992sm159490095e9.6.2024.05.14.08.14.03
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 14 May 2024 08:14:04 -0700 (PDT)
Message-ID: <d48740a3-ea97-447f-9103-c4bb30194971@ursulin.net>
Date: Tue, 14 May 2024 16:14:02 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC 0/5] Discussion around eviction improvements
Content-Language: en-GB
To: Tvrtko Ursulin <tursulin@igalia.com>, amd-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org
Cc: kernel-dev@igalia.com, Tvrtko Ursulin <tvrtko.ursulin@igalia.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Friedrich Vock <friedrich.vock@gmx.de>
References: <20240508180946.96863-1-tursulin@igalia.com>
 <e39bcdd1-90e7-42f3-94a9-ea1af6b0d278@ursulin.net>
 <6b4bbb02-3f12-4a6a-8e61-c776da636d1d@ursulin.net>
From: Tvrtko Ursulin <tursulin@ursulin.net>
In-Reply-To: <6b4bbb02-3f12-4a6a-8e61-c776da636d1d@ursulin.net>
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


On 13/05/2024 14:49, Tvrtko Ursulin wrote:
> 
> On 09/05/2024 13:40, Tvrtko Ursulin wrote:
>>
>> On 08/05/2024 19:09, Tvrtko Ursulin wrote:
>>> From: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
>>>
>>> Last few days I was looking at the situation with VRAM over 
>>> subscription, what
>>> happens versus what perhaps should happen. Browsing through the 
>>> driver and
>>> running some simple experiments.
>>>
>>> I ended up with this patch series which, as a disclaimer, may be 
>>> completely
>>> wrong but as I found some suspicious things, to me at least, I 
>>> thought it was a
>>> good point to stop and request some comments.
>>>
>>> To perhaps summarise what are the main issues I think I found:
>>>
>>>   * Migration rate limiting does not bother knowing if actual 
>>> migration happened
>>>     and so can over-account and unfairly penalise.
>>>
>>>   * Migration rate limiting does not even work, at least not for the 
>>> common case
>>>     where userspace configures VRAM+GTT. It thinks it can stop 
>>> migration attempts
>>>     by playing with bo->allowed_domains vs bo->preferred domains but, 
>>> both from
>>>     the code, and from empirical experiments, I see that not working 
>>> at all. Both
>>>     masks are identical so fiddling with them achieves nothing.
>>>
>>>   * Idea of the fallback placement only works when VRAM has free 
>>> space. As soon
>>>     as it does not, ttm_resource_compatible is happy to leave the 
>>> buffers in the
>>>     secondary placement forever.
>>>
>>>   * Driver thinks it will be re-validating evicted buffers on the 
>>> next submission
>>>     but it does not for the very common case of VRAM+GTT because it 
>>> only checks
>>>     if current placement is *none* of the preferred placements.
>>>
>>> All those problems are addressed in individual patches.
>>>
>>> End result of this series appears to be driver which will try harder 
>>> to move
>>> buffers back into VRAM, but will be (more) correctly throttled in 
>>> doing so by
>>> the existing rate limiting logic.
>>>
>>> I have run a quick benchmark of Cyberpunk 2077 and cannot say that I 
>>> saw a
>>> change but that could be a good thing too. At least I did not break 
>>> anything,
>>> perhaps.. On one occassion I did see the rate limiting logic get 
>>> confused while
>>> for a period of few minutes it went to a mode where it was constantly 
>>> giving a
>>> high migration budget. But that recovered itself when I switched 
>>> clients and did
>>> not come back so I don't know. If there is something wrong there I 
>>> don't think
>>> it would be caused by any patches in this series.
>>
>> Since yesterday I also briefly tested with Far Cry New Dawn. One run 
>> each so possibly doesn't mean anything apart that there isn't a 
>> regression aka migration throttling is keeping things at bay even with 
>> increased requests to migrate things back to VRAM:
>>
>>               before         after
>> min/avg/max fps        36/44/54        37/45/55
>>
>> Cyberpunk 2077 from yesterday was similarly close:
>>
>>          26.96/29.59/30.40    29.70/30.00/30.32
>>
>> I guess the real story is proper DGPU where misplaced buffers have a 
>> real cost.
> 
> I found one game which regresses spectacularly badly with this series - 
> Assasin's Creed Valhalla. The built-in benchmark at least. The game 
> appears to have a working set much larger than the other games I tested, 
> around 5GiB total during the benchmark. And for some reason migration 
> throttling totally fails to put it in check. I will be investigating 
> this shortly.

I think that the conclusion is everything I attempted to add relating to 
TTM_PL_PREFERRED does not really work as I initially thought it did. 
Therefore please imagine this series as only containing patches 1, 2 and 5.

(And FWIW it was quite annoying to get to the bottom of since for some 
reason the system exibits some sort of a latching behaviour, where on 
some boots and/or some minutes of runtime things were fine, and then it 
would latch onto a mode where the TTM_PL_PREFERRED induced breakage 
would show. And sometimes this breakage would appear straight away. Odd.)

I still need to test though if the subset of patches manage to achieve 
some positive improvement on their own. It is possible, as patch 5 marks 
more buffers for re-validation so once overcommit subsides they would 
get promoted to preferred placement straight away. And 1&2 are 
notionally fixes for migration throttling so at least in broad sense 
should be still valid as discussion points.

Regards,

Tvrtko

>>> Series is probably rough but should be good enough for dicsussion. I 
>>> am curious
>>> to hear if I identified at least something correctly as a real problem.
>>>
>>> It would also be good to hear what are the suggested games to check 
>>> and see
>>> whether there is any improvement.
>>>
>>> Cc: Christian König <christian.koenig@amd.com>
>>> Cc: Friedrich Vock <friedrich.vock@gmx.de>
>>>
>>> Tvrtko Ursulin (5):
>>>    drm/amdgpu: Fix migration rate limiting accounting
>>>    drm/amdgpu: Actually respect buffer migration budget
>>>    drm/ttm: Add preferred placement flag
>>>    drm/amdgpu: Use preferred placement for VRAM+GTT
>>>    drm/amdgpu: Re-validate evicted buffers
>>>
>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c     | 38 +++++++++++++++++-----
>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_object.c |  8 +++--
>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c     | 21 ++++++++++--
>>>   drivers/gpu/drm/ttm/ttm_resource.c         | 13 +++++---
>>>   include/drm/ttm/ttm_placement.h            |  3 ++
>>>   5 files changed, 65 insertions(+), 18 deletions(-)
>>>
