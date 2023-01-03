Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AFB42C3DA7D
	for <amd-gfx@archiver.kernel.org>; Tue,  3 Jan 2023 10:02:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 418F610E3C7;
	Tue,  3 Jan 2023 10:02:19 +0000 (UTC)
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com
 [IPv6:2a00:1450:4864:20::32c])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4C27610E3C7
 for <amd-gfx@lists.freedesktop.org>; Tue,  3 Jan 2023 10:02:17 +0000 (UTC)
Received: by mail-wm1-x32c.google.com with SMTP id
 ay2-20020a05600c1e0200b003d22e3e796dso22707956wmb.0
 for <amd-gfx@lists.freedesktop.org>; Tue, 03 Jan 2023 02:02:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=9FfAl/1QzQYNvMK9RN/w4nEUpVJRa7b4z2IQpVDZAlY=;
 b=F+6uaCyk2AKD9gutj26InMYT8QUe2J3VFW0pQRSiScy2brQVK+RBt0JlRJaOt71PJy
 d5ShaB6inRXeFJz/EBGg8QonsP+LU2Ech6rhfzVHGeE6By6W3iJlipc8UF5YSSb1DD4a
 lpY9JVPxtjh55EBJXcvJnuq5ZSYAU5SLieFj6Xy1Epc21stXGA9aqDQeMvN5TFTs8bgh
 KXqDt4F1y5Jj9mPzAWf8mRsnFSQz28hWnzO4I/NFphWeQNwr5wPo8zZTuG1UWFwDkLLm
 PRQ05uv8L1pgfCW9LyRgGxyhzNousy7j8q2ZIHbBPVJxh5gwNcGFBcF7NZmDTbnADTjv
 PrMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=9FfAl/1QzQYNvMK9RN/w4nEUpVJRa7b4z2IQpVDZAlY=;
 b=RRhMG/z7DCNHY2VyaKH35LZ/VZLHTJSBRQcaqRMX2qdqpsrpU+vJeQVagwCSfcos0s
 Sbc3evOKwWGGRd+lVL5np8+sucw3mnakPbzlHRQ1zxLxqXCu4cSUnKMyKSL3ZvIuCluI
 xK5mg86N61nh0NMqAMg3ZTPqlgaoYZyGyT8/uFde7sy2J+1ajR3GrOpyL7coCXkfpwol
 2sDdQ/AnbY+Aaje79olny5Ck5tKAIkMnNATk/Qf5MHIbSRHt+/hD5LPRvWG8AoVI+XVc
 Zi3Uw6LYz4Kpp9I7a1ZfRrXS5p5QMF2pX2t7JKx+5dcLfsR6fovd44QzeCNgNUR1H4Nn
 hKRg==
X-Gm-Message-State: AFqh2kqftmqlrfNU4ksvS6ZBO7HiFdeyN4OhcZ5A7q9i/Z4uRtpY4KSy
 e7V4ddVXJiEhjLjfp1aKMGc=
X-Google-Smtp-Source: AMrXdXsOcZLHY346LTqQgxZrRsygnZjvlpWk/3i0nSIo7cCHql+a4wZEfeXJ/m6ioYg9J7v85qyXKQ==
X-Received: by 2002:a05:600c:1c85:b0:3d3:4b18:27c6 with SMTP id
 k5-20020a05600c1c8500b003d34b1827c6mr30222748wms.11.1672740135866; 
 Tue, 03 Jan 2023 02:02:15 -0800 (PST)
Received: from ?IPV6:2a02:908:1256:79a0:91f2:4ffb:eef9:7882?
 ([2a02:908:1256:79a0:91f2:4ffb:eef9:7882])
 by smtp.gmail.com with ESMTPSA id
 l13-20020a05600c2ccd00b003c70191f267sm49291649wmc.39.2023.01.03.02.02.14
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 03 Jan 2023 02:02:15 -0800 (PST)
Message-ID: <04ff49dc-a059-10d3-abd5-de11298047ae@gmail.com>
Date: Tue, 3 Jan 2023 11:02:14 +0100
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
 <7f0343c1-ac6a-4966-89e6-95d3bc3d8056@gmail.com>
 <fdaeef41-cdab-e364-5d99-4366d05ead43@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
In-Reply-To: <fdaeef41-cdab-e364-5d99-4366d05ead43@amd.com>
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

Am 03.01.23 um 11:00 schrieb Shashank Sharma:
>
> On 03/01/2023 10:47, Christian König wrote:
>> Am 03.01.23 um 10:43 schrieb Shashank Sharma:
>>>
>>> On 29/12/2022 19:02, Alex Deucher wrote:
>>>> On Fri, Dec 23, 2022 at 2:37 PM Shashank Sharma 
>>>> <shashank.sharma@amd.com> wrote:
>>>>> This is a RFC series to implement usermode graphics queues for AMDGPU
>>>>> driver (Navi 3X and above). The idea of usermode graphics queue is to
>>>>> allow direct workload submission from a userspace graphics process 
>>>>> who
>>>>> has amdgpu graphics context.
>>>>>
>>>>> Once we have some initial feedback on the design, we will publish a
>>>>> follow up V1 series with a libdrm consumer test.
>>>> I think this should look more like the following:
>>>> 1. Convert doorbells to full fledged GEM objects just like vram.  Then
>>>> update the GEM IOCTL to allow allocation of doorbell BOs.
>>>> 2. Store MQD data per amdgpu_ctx.
>>>
>>> If my understanding of the comments is correct, we are having 
>>> conflicting opinions here on where to save the MQD data. @Christian ?
>>
>> You need something like an amdgpu_userq object which holds the BO 
>> with the MQD the hardware is using as well as anything else necessary 
>> for the queue.
>
> And we will be storing it into fpriv->amdgpu driver_private area 
> (probably by using something like amdgpu_useq_mgr or similar), similar 
> to amdgpu_ctx_mgr.

Exactly that, yes. The amdgpu_userq_mgr keeps the idr/mutex and 
everything necessary per client while the amdgpu_userq object represents 
the queue itself.

Christian.

>
> - Shashank
>
>>
>> Regards,
>> Christian.
>>
>>>
>>>> 3. Create secure semaphore pool and map RO into each GPUVM.
>>>> 4. Add callbacks to each IP type that supports user mode queues.
>>>> These callbacks should handle the IP specific MQD initialization and
>>>> mapping/unmapping details including allocation of BOs for the MQD
>>>> itself and any relevant metadata.  The USERQ IOCTL handler will look
>>>> up the callback based on the IP type specified in the IOCTL.
>>>
>>> Noted.
>>>
>>> Shashank
>>>
>>>>
>>>> Alex
>>>>
>>>>> Cc: Alex Deucher <alexander.deucher@amd.com>
>>>>> Cc: Christian Koenig <christian.koenig@amd.com>
>>>>>
>>>>> Alex Deucher (1):
>>>>>    drm/amdgpu: UAPI for user queue management
>>>>>
>>>>> Arunpravin Paneer Selvam (1):
>>>>>    drm/amdgpu: Secure semaphore for usermode queue
>>>>>
>>>>> Arvind Yadav (1):
>>>>>    drm/amdgpu: Create MQD for userspace queue
>>>>>
>>>>> Shashank Sharma (4):
>>>>>    drm/amdgpu: Add usermode queue for gfx work
>>>>>    drm/amdgpu: Allocate doorbell slot for user queue
>>>>>    drm/amdgpu: Create context for usermode queue
>>>>>    drm/amdgpu: Map userqueue into HW
>>>>>
>>>>>   drivers/gpu/drm/amd/amdgpu/Makefile           |   3 +
>>>>>   drivers/gpu/drm/amd/amdgpu/amdgpu.h           |  14 +
>>>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.h       |   1 +
>>>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c | 486 
>>>>> ++++++++++++++++
>>>>>   .../amd/amdgpu/amdgpu_userqueue_secure_sem.c  | 245 ++++++++
>>>>>   .../drm/amd/include/amdgpu_usermode_queue.h   |  68 +++
>>>>>   .../amd/include/amdgpu_usermode_queue_mqd.h   | 544 
>>>>> ++++++++++++++++++
>>>>>   include/uapi/drm/amdgpu_drm.h                 |  52 ++
>>>>>   8 files changed, 1413 insertions(+)
>>>>>   create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
>>>>>   create mode 100644 
>>>>> drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue_secure_sem.c
>>>>>   create mode 100644 
>>>>> drivers/gpu/drm/amd/include/amdgpu_usermode_queue.h
>>>>>   create mode 100644 
>>>>> drivers/gpu/drm/amd/include/amdgpu_usermode_queue_mqd.h
>>>>>
>>>>> -- 
>>>>> 2.34.1
>>>>>
>>

