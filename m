Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 146D9EB64D9
	for <amd-gfx@archiver.kernel.org>; Thu, 15 Jun 2023 07:47:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9CBA110E494;
	Thu, 15 Jun 2023 07:47:40 +0000 (UTC)
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com
 [IPv6:2a00:1450:4864:20::42a])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3B8D110E494
 for <amd-gfx@lists.freedesktop.org>; Thu, 15 Jun 2023 07:47:38 +0000 (UTC)
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-30af159b433so7358633f8f.3
 for <amd-gfx@lists.freedesktop.org>; Thu, 15 Jun 2023 00:47:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1686815256; x=1689407256;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Ky37zPBpr87/7L5kLDyKziyowu4z2hx34BxVwUbNdL4=;
 b=eVexQeFyzcXDqBSdBN8aDLIXaN0BAHMGOnH24VFPposU/ORZI6OG6yC0bnWK27lnGy
 CcgxLkHkO8DF9Wl3e9/rbIpAb0+H7g+QOw8LPCIAcEDvx/4DysjPm0FEBq98L7Evc6x1
 CgjlyOX5U89BGval/78OeFUYH3X/PzNB9Z6popKGfo/1RX+4T1bmpVbIWuiBYcFW/c9h
 leRbdCCpzs78/LB7KolRbywm7wakq8KrC7sj4DoTXpaVHXGn/gw9sSkm4xccNhJ1rZ0S
 37VCII6aiWxaKJ2n/CpI541L4vLJAY7cuaOs0m3KIcZmRYsY5fnFkSWy+fxdN0ndP+Ur
 kyww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686815256; x=1689407256;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Ky37zPBpr87/7L5kLDyKziyowu4z2hx34BxVwUbNdL4=;
 b=DjGxIm6kAyrzPPQkZPM3MKOE4dk7u1mNxuYwqaX4cDa6UasSyNQHk0ozzIFtMFN3SA
 vRPWcBx7QWu8+7/QK28BPrSgKNOXFYOMESTxGcnYY9b5afjmXCec+tUKZy8wEMvN69VT
 /NDKIOal1CP8XQwOqJTxzn68g+gS/bHmoH9ixfDQi74+jXEkpMR/5vGIZ2gbuy1pkV0I
 YYFNYl1J3oGUdPqidHhe7BPbFiSMJEmwMACTViev6GxpxVVSOOIktsQGg6i04AbAXQ7m
 BSpopI0onMtwiQ8X+Fuahx3m5g+ApFRfcHDCHnWxDTGRvULtH87DnCnsP7uJINYYuoDV
 c4Kg==
X-Gm-Message-State: AC+VfDwU8KqqdeAfGbt8F7VPaU1/34MOce8oioFeUk1hzdKSdzIQUEC+
 mc9QzOQ/qSmBovMdcQtjnx6uT80Dpxw=
X-Google-Smtp-Source: ACHHUZ4no8J7SLRh+4QVWG2DwhRzs3K8iuSNWYgUQ+B578YkFjfYjwNaWxl/v1RnUzbd/5l2Iz6kHg==
X-Received: by 2002:a5d:5149:0:b0:30f:cc27:61c0 with SMTP id
 u9-20020a5d5149000000b0030fcc2761c0mr6824066wrt.66.1686815255994; 
 Thu, 15 Jun 2023 00:47:35 -0700 (PDT)
Received: from ?IPV6:2a00:e180:1502:3e00:a4b7:5833:1db2:7e82?
 ([2a00:e180:1502:3e00:a4b7:5833:1db2:7e82])
 by smtp.gmail.com with ESMTPSA id
 cr5-20020a05600004e500b0030c6751a49dsm20195605wrb.115.2023.06.15.00.47.35
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 15 Jun 2023 00:47:35 -0700 (PDT)
Message-ID: <ae3eb473-ba76-1a3a-f063-388a00766164@gmail.com>
Date: Thu, 15 Jun 2023 09:47:34 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: Fw: [PATCH] drm/amdgpu: add amdgpu_timeout_ring_* file to debugfs
Content-Language: en-US
To: =?UTF-8?Q?Nicolai_H=c3=a4hnle?= <nhaehnle@gmail.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>,
 "Haehnle, Nicolai" <Nicolai.Haehnle@amd.com>, Daniel Vetter
 <daniel@ffwll.ch>, Faith Ekstrand <faith.ekstrand@collabora.com>
References: <20230614112758.120429-1-nicolai.haehnle@amd.com>
 <cca52290-bd13-e9e9-297c-e480acaef782@gmail.com>
 <DM4PR12MB596202BE54818219FEC63746FF5AA@DM4PR12MB5962.namprd12.prod.outlook.com>
 <CAO4GU+A4rZWfP5VOnx1ubTbm9Jb8z6z1BkUU+mJKNaNj_f9=aQ@mail.gmail.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
In-Reply-To: <CAO4GU+A4rZWfP5VOnx1ubTbm9Jb8z6z1BkUU+mJKNaNj_f9=aQ@mail.gmail.com>
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

Am 14.06.23 um 21:20 schrieb Nicolai Hähnle:
> Hi Christian,
>
>>> Report the per-ring timeout in milliseconds and allow users to adjust
>>> the timeout dynamically. This can be useful for debugging, e.g. to more
>>> easily test whether a submission genuinely hangs or is just taking very
>>> long, and to temporarily disable GPU recovery so that shader problems
>>> can be examined in detail, including single-stepping through shader
>>> code.
>>>
>>> It feels a bit questionable to access ring->sched.timeout without any
>>> locking -- under a C++ memory model it would technically be undefined
>>> behavior. But it's not like a lot can go wrong here in practice, and
>>> it's not clear to me what locking or atomics, if any, should be used.
>> Uh, that's very dangerous what you do here and wouldn't work in a whole
>> bunch of cases.
> Please elaborate: *what* case doesn't work?

The core memory management can wait at any time for the GPU reset to finish.

If we set the timeout to infinity we risk just deadlocking the kernel.

See here as well: https://lpc.events/event/11/contributions/1115/

>
>
>> First of all GPU recovery is part of normal operation and necessary for
>> system stability. So disabling GPU recovery is actually not a good idea
>> in the first place.
> That's a complete non-argument because the whole point of this is that
> it is a debugging feature. You're using this when the system as a
> whole (most likely a UMD component) is already broken in some way.
> Putting this in debugfs is not an accident.
>
>
>> We already discussed that we probably need to taint the kernel if we do
>> so to indicate in crash logs that the system is not considered stable
>> any more. The problem was only that there wasn't an agreement on how to
>> do this.
> I'd be happy to add kernel tainting if you tell me how.
>
>
>> Since this here now makes it even easier to disable GPU recovery it's
>> probably not the right approach.
> Again, being able to disable GPU recovery is a crucial debugging
> feature. We need to be able to inspect the live state of hung shaders,
> and we need to be able to single-step through shaders. All of that
> requires disabling GPU recovery.

Yeah, I'm perfectly aware of that. The problem is this is just *not* 
supported on Linux for graphics shaders.

What you can do is to run the shader with something like CWSR enabled 
(or an to be invented graphics equivalent). Since we are debugging the 
shader anyway that should be possible I think.

> Forcing people to reboot just to be able to disable GPU recovery for
> debugging is developer hostile.

Well, I think you misunderstood me. The suggestion was even to force 
them to re-compile the kernel driver to disable GPU recovery.

Disabling GPU recovery is *not* something you can do and expect the 
system to be stable.

The only case we can do that is when we attach a JTAG debugger in an AMD 
lab.

Regards,
Christian.

>
> So again, if there really are cases where this "doesn't work" (and
> those cases aren't just that your desktop will freeze -- that part is
> intentional), then let's talk through it and see how to address them.
>
> Thanks,
> Nicolai
>
>
>> Regards,
>> Christian.
>>
>>> Signed-off-by: Nicolai Hähnle <nicolai.haehnle@amd.com>
>>> ---
>>>    drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c | 32 +++++++++++++++++++++++-
>>>    1 file changed, 31 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
>>> index dc474b809604..32d223daa789 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
>>> @@ -471,35 +471,65 @@ static ssize_t amdgpu_debugfs_ring_read(struct file *f, char __user *buf,
>>>
>>>         return result;
>>>    }
>>>
>>>    static const struct file_operations amdgpu_debugfs_ring_fops = {
>>>         .owner = THIS_MODULE,
>>>         .read = amdgpu_debugfs_ring_read,
>>>         .llseek = default_llseek
>>>    };
>>>
>>> +static int amdgpu_debugfs_timeout_ring_get(void *data, u64 *val) {
>>> +     struct amdgpu_ring *ring = data;
>>> +
>>> +     if (ring->sched.timeout == MAX_SCHEDULE_TIMEOUT)
>>> +             *val = 0;
>>> +     else
>>> +             *val = jiffies_to_msecs(ring->sched.timeout);
>>> +
>>> +     return 0;
>>> +}
>>> +
>>> +static int amdgpu_debugfs_timeout_ring_set(void *data, u64 val) {
>>> +     struct amdgpu_ring *ring = data;
>>> +
>>> +     if (val == 0)
>>> +             ring->sched.timeout = MAX_SCHEDULE_TIMEOUT;
>>> +     else
>>> +             ring->sched.timeout = msecs_to_jiffies(val);
>>> +
>>> +     return 0;
>>> +}
>>> +
>>> +DEFINE_DEBUGFS_ATTRIBUTE(amdgpu_debugfs_timeout_ring_fops,
>>> +                      amdgpu_debugfs_timeout_ring_get,
>>> +                      amdgpu_debugfs_timeout_ring_set,
>>> +                      "%llu\n");
>>> +
>>>    #endif
>>>
>>>    void amdgpu_debugfs_ring_init(struct amdgpu_device *adev,
>>>                               struct amdgpu_ring *ring)
>>>    {
>>>    #if defined(CONFIG_DEBUG_FS)
>>>         struct drm_minor *minor = adev_to_drm(adev)->primary;
>>>         struct dentry *root = minor->debugfs_root;
>>> -     char name[32];
>>> +     char name[40];
>>>
>>>         sprintf(name, "amdgpu_ring_%s", ring->name);
>>>         debugfs_create_file_size(name, S_IFREG | S_IRUGO, root, ring,
>>>                                  &amdgpu_debugfs_ring_fops,
>>>                                  ring->ring_size + 12);
>>>
>>> +     sprintf(name, "amdgpu_timeout_ring_%s", ring->name);
>>> +     debugfs_create_file(name, S_IFREG | S_IRUGO | S_IWUSR, root, ring,
>>> +                         &amdgpu_debugfs_timeout_ring_fops);
>>>    #endif
>>>    }
>>>
>>>    /**
>>>     * amdgpu_ring_test_helper - tests ring and set sched readiness status
>>>     *
>>>     * @ring: ring to try the recovery on
>>>     *
>>>     * Tests ring and set sched readiness status
>>>     *
>

