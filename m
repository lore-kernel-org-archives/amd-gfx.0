Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60001C05027
	for <amd-gfx@archiver.kernel.org>; Mon,  6 Feb 2023 08:57:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CF88F89CAD;
	Mon,  6 Feb 2023 08:57:34 +0000 (UTC)
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com
 [IPv6:2a00:1450:4864:20::32e])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9861F89CAD
 for <amd-gfx@lists.freedesktop.org>; Mon,  6 Feb 2023 08:57:33 +0000 (UTC)
Received: by mail-wm1-x32e.google.com with SMTP id u10so5048660wmj.3
 for <amd-gfx@lists.freedesktop.org>; Mon, 06 Feb 2023 00:57:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=OyVIHARcS184vhj8TzqQuyzSqnnlT9stS047kP3ZHlI=;
 b=CMZvj2yTv7wZ8OnefbP5t2Y3Q2zbrME4IhiZZe/rUslbV2IEGF6dhYXK0SaS/1WqJx
 FrgWMv5wmeNy4Ky5ivB9ydC+lk/27zFRyy6uf030AUIoCMcbw9XyVQQRxNSJoDqNt1kl
 hSReD5A+2nOiCpithhUjSCpK9dwrYCbA0RJ0Ex9kQp7IVjrurkDUh5jjO5GxLNVY2nMU
 JrAf2UaWJQ/SoUFAvBM2v4UugU41/DdvMwxbHK//w8bI4mldoE0/76Ysll7v/G967jRR
 B59YDM2MvgdZzH5paFryIlo+RBDjc+90JyVux4hE1raiG6++Ze9in4zLX6uFPhXBETtq
 glKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=OyVIHARcS184vhj8TzqQuyzSqnnlT9stS047kP3ZHlI=;
 b=Swtt1yJ/CTTfTDOQ/4mpvNeMG1cLZbhI+i5iLNFiAngp2S9VdZn73Z9RcwDOp+bWDT
 MOwvlhZ8QTiJIYtA0nY/1IGmpnFmL1KMIPymG/vRCmbY5nyEXZuzUnoAE+qSlVZUL5Gv
 VrNSGq0/9Ac5C/lxknN32SaDKY38Afu+Z1ENzFZfgaHiaSCi5ihDuRwzxFPx/FRmBklP
 reuO3yT2lRluOfKszOKcnNUKtJmLw6zHRFzdaOnVjZVrR4590sl3qsRMttmgmG7cXxdC
 g8zZHmE8nAhChR2QsQ8XutHL0HA+Lay3Iuv1UDLr4+m3E4NtleUtFRMuIntgZf0hjZRR
 auRQ==
X-Gm-Message-State: AO0yUKWPnwkDr3x1DVjwaDcSZ7rdyz80BtiZCg6rMpHSn8e3eWn991yH
 JPLg/7ru9DcEJJiqdpJEOuM=
X-Google-Smtp-Source: AK7set/f3JTUMFZSYtv7Sq0uJFsu1qEJf4SNUgDl2/BiAxxOiFIrBapGJzBpAzI1lKSsMQegP93tXA==
X-Received: by 2002:a05:600c:2e06:b0:3dc:51f6:8f58 with SMTP id
 o6-20020a05600c2e0600b003dc51f68f58mr18514624wmf.6.1675673851815; 
 Mon, 06 Feb 2023 00:57:31 -0800 (PST)
Received: from [192.168.178.21] (p5b0ea2e7.dip0.t-ipconnect.de.
 [91.14.162.231]) by smtp.gmail.com with ESMTPSA id
 w5-20020a5d6085000000b0029100e8dedasm8231760wrt.28.2023.02.06.00.57.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 06 Feb 2023 00:57:31 -0800 (PST)
Message-ID: <109edfda-3fd9-6bfb-97ec-752b583572cf@gmail.com>
Date: Mon, 6 Feb 2023 09:57:29 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH 0/8] AMDGPU usermode queues
Content-Language: en-US
To: Dave Airlie <airlied@gmail.com>, Shashank Sharma <shashank.sharma@amd.com>
References: <20230203215409.2021-1-shashank.sharma@amd.com>
 <CAPM=9tzTKj3M_tKiwvSyN+jKsYFbE2yRvjgMkZGmGdUWabnwiA@mail.gmail.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
In-Reply-To: <CAPM=9tzTKj3M_tKiwvSyN+jKsYFbE2yRvjgMkZGmGdUWabnwiA@mail.gmail.com>
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
Cc: alexander.deucher@amd.com,
 Shashank Sharma <contactshashanksharma@gmail.com>, christian.koenig@amd.com,
 amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Am 06.02.23 um 01:52 schrieb Dave Airlie:
> On Sat, 4 Feb 2023 at 07:54, Shashank Sharma <shashank.sharma@amd.com> wrote:
>> From: Shashank Sharma <contactshashanksharma@gmail.com>
>>
>> This patch series introduces AMDGPU usermode graphics queues.
>> User queues is a method of GPU workload submission into the graphics
>> hardware without any interaction with kernel/DRM schedulers. In this
>> method, a userspace graphics application can create its own workqueue
>> and submit it directly in the GPU HW.
>>
>> The general idea of how this is supposed to work:
>> - The application creates the following GPU objetcs:
>>    - A queue object to hold the workload packets.
>>    - A read pointer object.
>>    - A write pointer object.
>>    - A doorbell page.
>> - Kernel picks any 32-bit offset in the doorbell page for this queue.
>> - The application uses the usermode_queue_create IOCTL introduced in
>>    this patch, by passing the the GPU addresses of these objects (read
>>    ptr, write ptr, queue base address and doorbell address)
>> - The kernel creates the queue and maps it in the HW.
>> - The application can start submitting the data in the queue as soon as
>>    the kernel IOCTL returns.
>> - Once the data is filled in the queue, the app must write the number of
>>    dwords in the doorbell offset, and the GPU will start fetching the data.
> So I just have one question about forward progress here, let's call it
> the 51% of VRAM problem.
>
> You have two apps they both have working sets that allocate > 51% of VRAM.

Marek and I have been working on this quite extensively.

> Application (a) has the VRAM and mapping for the user queues and is
> submitting work
> Application (b) wants to submit work, it has no queue mapping as it
> was previously evicted, does (b) have to call an ioctl to get it's
> mapping back?

Long story short: No, but that's a bit more complicated to explain.

> When (b) calls the ioctl (a) loses it mapping. Control returns to (b),
> but before it submits any work on the ring mapping it has, (a) gets
> control and notices it has no queues, so calls the ioctl, and (b)
> loses it mapping, and around and around they go never making forward
> progress.
>
> What's the exit strategy for something like that, fall back to kernel
> submit so you can get a memory objects validated and submit some work?

First of all the fw makes sure that processes can only be evicted after 
they used up their time slice. So when you have two processes fighting 
over a shared resource (can be memory, locks or whatever) they will 
always get until the end of their time slice before they are pushed away 
from the hw.

Then when a process is evicted we take a look at what the process has 
already scheduled as work on the hw. If the process isn't idle we start 
a delayed work item to get it going again (similar to what the KFD is 
doing at the moment). When the process is idle we unmap the doorbell 
page(s) from the CPU and wait for the page fault which signals that the 
process wants to submit something again.

And the last component is a static resource management which distributes 
the available resources equally between the different active processes 
fighting over them. Activity of a process is determined by the periodic 
interrupts send by the hw for running processes.

I call the memory management algorithm based on this Robin Hood 
(https://drive.google.com/file/d/1vIrX37c3B2IgWFtZ2UpeKxh0-YMlV6NU/view) 
and simulated that a bit in some spread sheets, but it isn't fully 
implemented yet. I'm working on this for a couple of years now and 
slowly pushing DRM/TTM into the direction we need for this to work.

Christian.

>
> Dave.

