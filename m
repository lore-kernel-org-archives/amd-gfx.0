Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B42ED49C93
	for <amd-gfx@archiver.kernel.org>; Fri, 30 Jan 2026 10:28:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 124DD10E1A0;
	Fri, 30 Jan 2026 10:28:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=ursulin.net header.i=@ursulin.net header.b="TbxnfnGb";
	dkim-atps=neutral
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com
 [209.85.221.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 13E9F10E1A0
 for <amd-gfx@lists.freedesktop.org>; Fri, 30 Jan 2026 10:28:02 +0000 (UTC)
Received: by mail-wr1-f46.google.com with SMTP id
 ffacd0b85a97d-43284ed32a0so1067407f8f.3
 for <amd-gfx@lists.freedesktop.org>; Fri, 30 Jan 2026 02:28:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ursulin.net; s=google; t=1769768880; x=1770373680; darn=lists.freedesktop.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=V9x8FMGL/wDSvA0OteO5l8PEpVdOVSypeGrHWx+4Lms=;
 b=TbxnfnGbxJd4qWBgJ0QeM8JWAx+E/UwDesxoqs44RYcN9yd6TFzangk6I63nAsD3mm
 zEpyG79Vjo5Mf45LvA3t2KJjX+mcBmnlP0hxcvhynJRlVCilIYkEmQRePHH8Ke+pHZEv
 SxSTrXe3dc9WZkgCxn4c/ffph6QZw8fz7SZkk5DqKlAyusSB39bxBR6zaGmjBP/ia4ER
 XwVpEhBvkKsJn/FeIzkmOdXCZlJ/pZ91HYtW6iahGWOICgRDUSdP8iFXakaMkUyI4rFn
 EB2N8F/dW8Fa9yHepeeLX5IjVQUIbXHxBSShAFEHO6JhkWr1prv6nJ6TcF9xISnofBq1
 Tnyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769768880; x=1770373680;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=V9x8FMGL/wDSvA0OteO5l8PEpVdOVSypeGrHWx+4Lms=;
 b=EWsvljktGAg+/UWKQZ2B3h5up3ktDqRdWQFdpL7LRXes2un5p5JwQrQxbYpQpxJyTE
 pU82oVh2oleH2p9zfZw01ZRPgkozF4elS28YJ8tuDZwh4dtsWbvguzAHKa93omFaqhJv
 4OGAAWf6tTYCFRmIHe7XFxidgePfzNfzYY4xDrXAaI9om9oeibqQGvNc3fKOTWIccXfg
 5xAlOznGqRz0G5XxneKQ/2JHTyvqLVIorm/Ia4AsNSqoOD1YFn7vj1Zo9pnas4iX3oc1
 DXcbASSQvoED53PtC+6M4hFC3ng76kbzXdP3q0sqhoOqNL5kiPhgb5vS5EidtBJR76yd
 jV9g==
X-Forwarded-Encrypted: i=1;
 AJvYcCVsN5ah1kneZ4urYkEqaDCL1cLcRrmGeSeZSvVj9VapmrrhwgcmLJ8RcVytdIC+4G3mDWRdoEdd@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwYZBoNwpHAiqqVpe8r8Ld4q7AucmO+QwVoAYXPbPySZNB0lwKf
 6Xy/PcOFcX+iUyywkig12Y2XjNw2jC5KG9Ac+Gne1dIxd+Dr5vlqVqsqZeCe9lj7xHsYfayRRY+
 67UgQXCg=
X-Gm-Gg: AZuq6aLKEoM3/HgQDlMdchyFKfZt/NyNS57c5vKEu5Zgpwb7+vkYPwrQmL2oPxp5/0i
 97rze4vutk8y0tVFF2TMSRs1QGnbevi1qhGFiGMIGKgMUtHJ6+5AtofgfumCc4N1NOkgp2fH++y
 ML5OCTKNF2JLDU3coy5h81EBrHQYKPYGqofTrCrG916FVytWlBn4QPFelMprj5LAPhryb+Jj54/
 i+wNPQAD+rQVkiBseSvy685NpFUsySYQAwsEW4ETYDLshA7+699zh821HC4qNn7tfjjDXHTOL5S
 VdPw14psQvMZv0SrNaaUqdv/4D25jvP24lOACO153/S6E0gmIZ3ySiBVtQDdpR0/sSe5M9vh6Tl
 pcBdFsqY/wZZ6C1y/0L5xtt/K6yQznPjGg40Pv34u+uJYHY+K70vipdatTK2rxRgaxNrly3waoA
 OtGw3Q5bNafMSOQuW9BZfmXrGKt9mhzjnk
X-Received: by 2002:a05:6000:1acf:b0:435:b068:d3d2 with SMTP id
 ffacd0b85a97d-435f3abb067mr3689809f8f.57.1769768880264; 
 Fri, 30 Jan 2026 02:28:00 -0800 (PST)
Received: from [192.168.0.101] ([90.240.106.137])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-435e131cfd4sm20473777f8f.25.2026.01.30.02.27.59
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 30 Jan 2026 02:27:59 -0800 (PST)
Message-ID: <f9f1f2cc-861f-47e5-b95a-cf48da430fcc@ursulin.net>
Date: Fri, 30 Jan 2026 10:27:59 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] drm/amdgpu/gfx10: fix wptr reset in KGQ init
To: Alex Deucher <alexdeucher@gmail.com>
Cc: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
References: <20260129043446.33377-1-alexander.deucher@amd.com>
 <6fbe8046-cb00-49ca-8bc0-c1f3b747767f@ursulin.net>
 <CADnq5_O-Nq8Y+9enz11gqbFOnJsL9Xmf4F2hxJ3vx4k5OOD1FA@mail.gmail.com>
Content-Language: en-GB
From: Tvrtko Ursulin <tursulin@ursulin.net>
In-Reply-To: <CADnq5_O-Nq8Y+9enz11gqbFOnJsL9Xmf4F2hxJ3vx4k5OOD1FA@mail.gmail.com>
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


On 29/01/2026 16:39, Alex Deucher wrote:
> On Thu, Jan 29, 2026 at 11:27 AM Tvrtko Ursulin <tursulin@ursulin.net> wrote:
>>
>>
>> On 29/01/2026 04:34, Alex Deucher wrote:
>>> wptr is a 64 bit value and we need to update the
>>> full value, not just 32 bits. Align with what we
>>> already do for KCQs.
>>>
>>> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
>>> ---
>>>    drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c | 2 +-
>>>    1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
>>> index e9254ec3b6417..ef7d91a4437ec 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
>>> @@ -6883,7 +6883,7 @@ static int gfx_v10_0_kgq_init_queue(struct amdgpu_ring *ring, bool reset)
>>>                        memcpy_toio(mqd, adev->gfx.me.mqd_backup[mqd_idx], sizeof(*mqd));
>>>                /* reset the ring */
>>>                ring->wptr = 0;
>>> -             *ring->wptr_cpu_addr = 0;
>>> +             atomic64_set((atomic64_t *)ring->wptr_cpu_addr, 0);
>>
>> For my education could I ask if this just about writing the 64-bit value
>> or the atomic part is also important?
> 
> Just the 64 bit value in this case.

Thank you, it was a bit confusing for me. Even in the context of what 
you explained to Timur that pre-gfx9 wptr is 32-bit, becauase when I 
looked into for example the gfx8 code, I saw it doing a mix of 64- and 
32-bit writes.

I guess the layout of the write back info block thingy is fully 
software/driver defined which is why this is not an issue?

Would it be worth getting rid of the atomics to lessen the confusion and 
attempt to somehow make this area more self-documenting?

Regards,

Tvrtko
