Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9A49C433F5
	for <amd-gfx@archiver.kernel.org>; Mon,  9 May 2022 06:06:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2BE6B10FDDE;
	Mon,  9 May 2022 06:06:39 +0000 (UTC)
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com
 [IPv6:2a00:1450:4864:20::62a])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EFB1010FDDE
 for <amd-gfx@lists.freedesktop.org>; Mon,  9 May 2022 06:06:37 +0000 (UTC)
Received: by mail-ej1-x62a.google.com with SMTP id l18so24674103ejc.7
 for <amd-gfx@lists.freedesktop.org>; Sun, 08 May 2022 23:06:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=message-id:date:mime-version:user-agent:subject:content-language:to
 :cc:references:from:in-reply-to:content-transfer-encoding;
 bh=glIn671BGh4XNUunmJjoUhd/btinao9FYu2Sm10ArpU=;
 b=ZNb0+RbW5TvPYVN5M5TkW5iLGB8zYdkN7Piq7fEI94Mv5PAXPK8EAmXRrSRwbsuB0F
 fzZTW9p9ZcUw58z1KlTo6uMs910l/Lz9OzYXJFlRaPOjxckDiDgasJmziHQjbqKnIbmN
 dLfFMlK6dEaSCUb1zJAAMDv4EOxv8znkLlz7vQVd9uAqv3SFy8FAdo1xxhlysSYdbKUY
 6W/gz+Jqu1Z+iaZwkHehYnzW4f2ZvHyO3ASroNEqzJlGnMJ2s2D4ku8tfyNmdMCUi+q2
 nHrK4KCj1waRtN1vI6mHnxc9wHXAYqlg9H+VZpfVLbeyzBOma0q4YGztrq9KumZlm1TM
 t8bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:cc:references:from:in-reply-to
 :content-transfer-encoding;
 bh=glIn671BGh4XNUunmJjoUhd/btinao9FYu2Sm10ArpU=;
 b=2dP3zvnpLDBDNj7oLY2XXf+xQlO40hkjzErs9Vv/UZZVacDJKuFbJ5i6TF0holQRLe
 uwLL0FmdQAXRmxA8YmIrcbbEuIX2z3DQAvvdvNmxcELomivicKlWDmCL0BB3NffhfElM
 4FMp5XvWJjWZgSUc3N9BoOsvxsqw7mI77lnBW69p3E960R/izbnYEt7tfJZsQnPTkyKZ
 HMNB50jdgYr3YfgaOXupX8XKZ/0XLE+8P1nhBR8m2SoRTqsEupTUksF3AxedBYyG1Nmy
 Ke1lHC+geXMcUAJwWGzYsWKk2HKSjBXp6bHR142Pp/kYIGzhvv1i4MVZEgJf5jZvgJor
 lx/A==
X-Gm-Message-State: AOAM531OVa24OZEY3Q/Z64t4rCgVEXPAPZmZ0iAhbYlTOj08eN2yh7s5
 jdq14Uv1paVQoKBqKiZ+4sTM0uQ2gys=
X-Google-Smtp-Source: ABdhPJyErBa0dyLy6X3Cmb0DP0Kv6mb9sGwSrAfTTy/v+eQhkVsCxF+awrd0E0yAXMSTSzPtggkzbg==
X-Received: by 2002:a17:907:d28:b0:6f4:6375:5245 with SMTP id
 gn40-20020a1709070d2800b006f463755245mr13018502ejc.12.1652076396329; 
 Sun, 08 May 2022 23:06:36 -0700 (PDT)
Received: from [192.168.178.21] (p57b0b3fd.dip0.t-ipconnect.de.
 [87.176.179.253]) by smtp.gmail.com with ESMTPSA id
 j37-20020a05640223a500b0042617ba638bsm5654146eda.21.2022.05.08.23.06.35
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 08 May 2022 23:06:35 -0700 (PDT)
Message-ID: <6030d00c-0f90-612e-aeff-a5b696bc78f4@gmail.com>
Date: Mon, 9 May 2022 08:06:37 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH 3/8] drm/amdgpu: support mem copy for LSDMA
Content-Language: en-US
To: Luben Tuikov <luben.tuikov@amd.com>, Alex Deucher <alexdeucher@gmail.com>
References: <20220505200406.1293467-1-alexander.deucher@amd.com>
 <20220505200406.1293467-3-alexander.deucher@amd.com>
 <ac0c55f7-20ee-9cf4-f52f-1a168cc4e8f8@amd.com>
 <CADnq5_OZE-vum4V7UJMeyZNJDj8gqgcSK1FJiF0LrR2s6dRd1Q@mail.gmail.com>
 <85a04aff-ba3f-4c5e-e5e8-fc37afd10a53@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
In-Reply-To: <85a04aff-ba3f-4c5e-e5e8-fc37afd10a53@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Likun Gao <Likun.Gao@amd.com>,
 =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Am 07.05.22 um 02:03 schrieb Luben Tuikov:
> [SNIP]
> +     expect_val = LSDMA_PIO_STATUS__PIO_IDLE_MASK | LSDMA_PIO_STATUS__PIO_FIFO_EMPTY_MASK;
> +     for (i = 0; i < usec_timeout; i++) {
> +             tmp = RREG32_SOC15(LSDMA, 0, regLSDMA_PIO_STATUS);
> +             if ((tmp & expect_val) == expect_val)
> +                     break;
> +             udelay(1);
> +     }
>>> Does the hardware specify a minimum delay after the write to the LSDMA_PIO_COMMAND,
>>> and before we check the LSDMA_PIO_STATUS?
>> I'm not sure, but it should be pretty minimal.
> My point is that there should be a delay at least as large as the polling delay,
> after writing to the command register and before reading the status register.
> So that should be at least a 1 us.
>
> There should be a udelay(1) after writing the command to the LSDMA_PIO_COMMAND
> register, before the for () loop begins.

I can't count how often I had to reject that approach. This is exactly 
what we should *not* do.

The SRBM (or whatever that's called on newer hardware) is the one who 
inserts the delay here. The driver should not explicitly do that 
additionally.

The background is that a) the read is often used to commit the write 
operations, both for the PCIe as well as internally in the GPU and b) 
the read only comes back when the SRBM has synced up between the bus 
interface and the hardware block in question.

So when the SRBM has synced between the two clock domains the operation 
has usually been completed or at least started. The minimal delay we 
enter between reads is just to avoid hammering on the register bus when 
the hardware block in question is (for example) power gated or otherwise 
not reachable.

Regards,
Christian.

>
> Regards,
> Luben
>
>
>>> At the moment the code above checks the status immediately after writing to
>>> LSDMA_PIO_COMMAND, and the copy wouldn't be completed.
>>>
>>> If the poll timeout is 1 us, as the loop shows us, maybe the command completion
>>> is larger than that (the time after writing to LSDMA_PIO_COMMAND and before
>>> checking LSDMA_PIO_STATUS)?
>> The time it takes for the copy will be dependent on the amount of data
>> there is to copy.  While the command is probably not complete on the
>> first read of the status register, it may be required to make sure the
>> previous write goes through.
>>
>> Alex
>>
>>>> +
>>>> +     if (i >= usec_timeout) {
>>>> +             dev_err(adev->dev, "LSDMA PIO failed to copy memory!\n");
>>>> +             return -ETIMEDOUT;
>>>> +     }
>>>> +
>>>> +     return 0;
>>>> +}
>>>> +
>>>>   const struct amdgpu_lsdma_funcs lsdma_v6_0_funcs = {
>>>> +     .copy_mem = lsdma_v6_0_copy_mem
>>>>   };
>>> Regards,
>>> --
>>> Luben
> Regards,

