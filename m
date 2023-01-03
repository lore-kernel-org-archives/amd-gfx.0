Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0BB86C3DA7D
	for <amd-gfx@archiver.kernel.org>; Tue,  3 Jan 2023 09:47:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7669C10E3BA;
	Tue,  3 Jan 2023 09:47:37 +0000 (UTC)
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com
 [IPv6:2a00:1450:4864:20::32d])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C8C5910E3BA
 for <amd-gfx@lists.freedesktop.org>; Tue,  3 Jan 2023 09:47:35 +0000 (UTC)
Received: by mail-wm1-x32d.google.com with SMTP id ay40so22262428wmb.2
 for <amd-gfx@lists.freedesktop.org>; Tue, 03 Jan 2023 01:47:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=vxuh/E1/hZpWLVVbF3pL3viRUrtdWZtf3z7fbYxfai8=;
 b=FdKE8xzvRnbo29zsDfF/GbNvTwbH+kb9g8Q7yN7eO1r/e8xAtMCUbvUWKECtCvr8+r
 affEq5Hz5kmT9r+jwxZwFMMLwrBm3Sq3zeRLQ/hQAkEcQx25/7/mlDpglvklg+PWvs/F
 eR02VXLnYz6D5+dyKFT3dTn8WdJpwlMjxaWFYVWwaxAfB3R+Vj/oJIeAObsOoKRkz+yC
 mcWMWQDZo2NnbElg9aH1fGdxkoCUv7f1PA4t8H1KDTsrnRx/0TOmhkoIG3YY+4zUn1nJ
 y0n3avkG0+onIgtUt3NjzVwS+1e1gHwIuLbg0yG3jRdTfS2+Vlwf+bY/ZTVodEOgVvW9
 sTAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=vxuh/E1/hZpWLVVbF3pL3viRUrtdWZtf3z7fbYxfai8=;
 b=6kX6lYAz6w3IT2oCXr1/zj5Ew5abtuvgp/sSif6EywnoEFf1rIbBW4Jz/nGwc2n+EL
 L6hxgZRiY3eSu4Kod5sbTU7N1Klv24UnYim3Xnr25FwrYLuoPyzz29TWVTM17HvX2kTu
 FB8Jly8QzajVllwP5r/sxBdd5ubV3+7NhT/3oWDfk+sT2uqTx5nxHOw4bd1N+Jzjt3Av
 XDdQaCr/2uNlXsosRWilMhOWZLOpD0m52uJZWdhpZcje2L9/0aTLgJf8akYhdUPOwl2e
 T7RUVPHB/pJo7w3LfmaJz5Hf+4KMyx41hxstt/xbTCymi1mNseA0K9KcBtvM7FLHUmiO
 l+uQ==
X-Gm-Message-State: AFqh2kq30BAWWsZGQ4azGNpPLkmEsIW2HpKTYk7HGFjWhkEEWto2/8CV
 uUpE49OvHB4yIo2ZAOVJLiw=
X-Google-Smtp-Source: AMrXdXsMfVsYv3b6ql1ToHGkipnTshMBiKvPH0cGOGI1ytuaTpumSumjG1xCCmuro3jZ18uZDPix/A==
X-Received: by 2002:a05:600c:4e46:b0:3d2:3761:b717 with SMTP id
 e6-20020a05600c4e4600b003d23761b717mr30687673wmq.37.1672739254291; 
 Tue, 03 Jan 2023 01:47:34 -0800 (PST)
Received: from ?IPV6:2a02:908:1256:79a0:91f2:4ffb:eef9:7882?
 ([2a02:908:1256:79a0:91f2:4ffb:eef9:7882])
 by smtp.gmail.com with ESMTPSA id
 m22-20020a05600c161600b003cfa622a18asm43869624wmn.3.2023.01.03.01.47.33
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 03 Jan 2023 01:47:33 -0800 (PST)
Message-ID: <7f0343c1-ac6a-4966-89e6-95d3bc3d8056@gmail.com>
Date: Tue, 3 Jan 2023 10:47:32 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [RFC 0/7] RFC: Usermode queue for AMDGPU driver
Content-Language: en-US
To: Shashank Sharma <shashank.sharma@amd.com>,
 Alex Deucher <alexdeucher@gmail.com>
References: <20221223193655.1972-1-shashank.sharma@amd.com>
 <CADnq5_MuJdXE3CjuibmiW72bPFfAN1YCr20tUpayf9fnn+DXZQ@mail.gmail.com>
 <9a7aad24-e3f6-cffa-bf3d-e1ade6c9c29c@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
In-Reply-To: <9a7aad24-e3f6-cffa-bf3d-e1ade6c9c29c@amd.com>
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
Cc: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org,
 Christian Koenig <christian.koenig@amd.com>, arvind.yadav@amd.com,
 arunpravin.paneerselvam@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Am 03.01.23 um 10:43 schrieb Shashank Sharma:
>
> On 29/12/2022 19:02, Alex Deucher wrote:
>> On Fri, Dec 23, 2022 at 2:37 PM Shashank Sharma 
>> <shashank.sharma@amd.com> wrote:
>>> This is a RFC series to implement usermode graphics queues for AMDGPU
>>> driver (Navi 3X and above). The idea of usermode graphics queue is to
>>> allow direct workload submission from a userspace graphics process who
>>> has amdgpu graphics context.
>>>
>>> Once we have some initial feedback on the design, we will publish a
>>> follow up V1 series with a libdrm consumer test.
>> I think this should look more like the following:
>> 1. Convert doorbells to full fledged GEM objects just like vram.  Then
>> update the GEM IOCTL to allow allocation of doorbell BOs.
>> 2. Store MQD data per amdgpu_ctx.
>
> If my understanding of the comments is correct, we are having 
> conflicting opinions here on where to save the MQD data. @Christian ?

You need something like an amdgpu_userq object which holds the BO with 
the MQD the hardware is using as well as anything else necessary for the 
queue.

Regards,
Christian.

>
>> 3. Create secure semaphore pool and map RO into each GPUVM.
>> 4. Add callbacks to each IP type that supports user mode queues.
>> These callbacks should handle the IP specific MQD initialization and
>> mapping/unmapping details including allocation of BOs for the MQD
>> itself and any relevant metadata.  The USERQ IOCTL handler will look
>> up the callback based on the IP type specified in the IOCTL.
>
> Noted.
>
> Shashank
>
>>
>> Alex
>>
>>> Cc: Alex Deucher <alexander.deucher@amd.com>
>>> Cc: Christian Koenig <christian.koenig@amd.com>
>>>
>>> Alex Deucher (1):
>>>    drm/amdgpu: UAPI for user queue management
>>>
>>> Arunpravin Paneer Selvam (1):
>>>    drm/amdgpu: Secure semaphore for usermode queue
>>>
>>> Arvind Yadav (1):
>>>    drm/amdgpu: Create MQD for userspace queue
>>>
>>> Shashank Sharma (4):
>>>    drm/amdgpu: Add usermode queue for gfx work
>>>    drm/amdgpu: Allocate doorbell slot for user queue
>>>    drm/amdgpu: Create context for usermode queue
>>>    drm/amdgpu: Map userqueue into HW
>>>
>>>   drivers/gpu/drm/amd/amdgpu/Makefile           |   3 +
>>>   drivers/gpu/drm/amd/amdgpu/amdgpu.h           |  14 +
>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.h       |   1 +
>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c | 486 ++++++++++++++++
>>>   .../amd/amdgpu/amdgpu_userqueue_secure_sem.c  | 245 ++++++++
>>>   .../drm/amd/include/amdgpu_usermode_queue.h   |  68 +++
>>>   .../amd/include/amdgpu_usermode_queue_mqd.h   | 544 
>>> ++++++++++++++++++
>>>   include/uapi/drm/amdgpu_drm.h                 |  52 ++
>>>   8 files changed, 1413 insertions(+)
>>>   create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
>>>   create mode 100644 
>>> drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue_secure_sem.c
>>>   create mode 100644 
>>> drivers/gpu/drm/amd/include/amdgpu_usermode_queue.h
>>>   create mode 100644 
>>> drivers/gpu/drm/amd/include/amdgpu_usermode_queue_mqd.h
>>>
>>> -- 
>>> 2.34.1
>>>

