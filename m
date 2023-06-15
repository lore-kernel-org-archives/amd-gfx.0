Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17992EB64DB
	for <amd-gfx@archiver.kernel.org>; Thu, 15 Jun 2023 09:14:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5143F10E496;
	Thu, 15 Jun 2023 09:14:34 +0000 (UTC)
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com
 [IPv6:2a00:1450:4864:20::335])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4085810E496
 for <amd-gfx@lists.freedesktop.org>; Thu, 15 Jun 2023 09:14:32 +0000 (UTC)
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-3f8c9cb3144so14448035e9.0
 for <amd-gfx@lists.freedesktop.org>; Thu, 15 Jun 2023 02:14:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1686820470; x=1689412470;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=OVsExRDOwLfcPdWZA3wAX1nYrZSdenP74frjZicq7Iw=;
 b=D8wAR10gaFsYCLvfTBWx35vMUItkCsdOu1KWdZXQjt/5Cw25HsMguoxJI45Knk3DoI
 Gwq7i5PyJYysrSFvgKfFmtAU/HOSKVW0u6aAdezo1ZiX9Tz4PjX6v5S/I6t0eTlEVe9L
 B2XvCGkuqiXCltG3eSTTUKb3M5T92kQCjzxmumP4VwyxcW3vcAkzv9aT5Xc97OA44gf9
 ROFoI+GFagSxISNEjcnJWz/ye74YiHxpStEcZeWB6u5t+G66TU5HeYNlTamMNX3imD0m
 wfa/XjrgcSvSutUnixgsFyTFcaTJIcKZnxOmm8pCJeZnlU/Jvx9WwqJfc6Ix1lmVRRrm
 5RHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686820470; x=1689412470;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=OVsExRDOwLfcPdWZA3wAX1nYrZSdenP74frjZicq7Iw=;
 b=DAxoKztYImyI0fJKlAprRfsvPPoxmTMBqWp6/zgifyBKldGPIX1WnwTGQq0UXuJZa4
 FDlWRfxKIfQ4nStNb2EDDNPyvyZtPW0lkmIacJXSExyZ4cAtDZn8ROY2vBcneia6OB9z
 1fdUpoY+hLI473w+vD5lWYlIY92vilmj5kT7Sl90/XQzQYuass7wD4NjpIfMvBlZhiT3
 2VRs5waAwn5R7eVzyCd5XW+egihVDxsw/Iq6JMW331ZwsVCALAAXEHVO944KBlkxswDf
 OpQZ1tsMRPeAfNdBGx2csbl7rGw79V4BNUXdOhNVdL+dIRiIvbgZJ0wUEZqaDbFPTROI
 HoNg==
X-Gm-Message-State: AC+VfDwiEe3k6ww+ZWp6F6FikaPgLIpwKU3votKDkiVi7L0lWEIn/Qgb
 7eCCym5emTcVgh7V84joCTk=
X-Google-Smtp-Source: ACHHUZ512lefA2wN3Xz/CX+DFEEc5mmUAfjx/Tj8L1ngY1z4nUz1ZGob5waw3a3Cc2BLZfWuZFg7hA==
X-Received: by 2002:a1c:f70a:0:b0:3f8:342:d67f with SMTP id
 v10-20020a1cf70a000000b003f80342d67fmr11758364wmh.0.1686820470366; 
 Thu, 15 Jun 2023 02:14:30 -0700 (PDT)
Received: from ?IPV6:2a00:e180:1502:3e00:a4b7:5833:1db2:7e82?
 ([2a00:e180:1502:3e00:a4b7:5833:1db2:7e82])
 by smtp.gmail.com with ESMTPSA id
 y19-20020a05600c365300b003f7f60203ffsm19846586wmq.25.2023.06.15.02.14.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 15 Jun 2023 02:14:29 -0700 (PDT)
Message-ID: <9c24612a-d9e7-4319-ce9f-df51fb74a6fe@gmail.com>
Date: Thu, 15 Jun 2023 11:14:28 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: Fw: [PATCH] drm/amdgpu: add amdgpu_timeout_ring_* file to debugfs
Content-Language: en-US
To: =?UTF-8?Q?Nicolai_H=c3=a4hnle?= <nhaehnle@gmail.com>
References: <20230614112758.120429-1-nicolai.haehnle@amd.com>
 <cca52290-bd13-e9e9-297c-e480acaef782@gmail.com>
 <DM4PR12MB596202BE54818219FEC63746FF5AA@DM4PR12MB5962.namprd12.prod.outlook.com>
 <CAO4GU+A4rZWfP5VOnx1ubTbm9Jb8z6z1BkUU+mJKNaNj_f9=aQ@mail.gmail.com>
 <ae3eb473-ba76-1a3a-f063-388a00766164@gmail.com>
 <CAO4GU+D1SDsRk+Oe0KfGSh3Rivvnb6RTaGO59bByeD3M5Q2qGQ@mail.gmail.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
In-Reply-To: <CAO4GU+D1SDsRk+Oe0KfGSh3Rivvnb6RTaGO59bByeD3M5Q2qGQ@mail.gmail.com>
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
Cc: Daniel Vetter <daniel@ffwll.ch>,
 Faith Ekstrand <faith.ekstrand@collabora.com>, "Haehnle,
 Nicolai" <Nicolai.Haehnle@amd.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Am 15.06.23 um 10:55 schrieb Nicolai Hähnle:
> On Thu, Jun 15, 2023 at 9:47 AM Christian König
> <ckoenig.leichtzumerken@gmail.com> wrote:
>>>> Uh, that's very dangerous what you do here and wouldn't work in a whole
>>>> bunch of cases.
>>> Please elaborate: *what* case doesn't work?
>> The core memory management can wait at any time for the GPU reset to finish.
>>
>> If we set the timeout to infinity we risk just deadlocking the kernel.
> Okay, thanks. I may have seen some aspect of this before in cases
> where GPU reset failed and left processes in an unkillable state.
>
> I'll be honest, I've seen my fair share of exotic GPU hangs and to put
> it mildly I'm not impressed by the kernel's handling of them.

Yeah, and I completely agree with you. The whole situation around that 
is just horrible.

> Obviously you know much more about the intricacies of kernel memory
> management than I do, but the fact that processes can end up in an
> unkillable state for *any* GPU-related reason feels to me like the
> result of a bad design decision somewhere.
>
> But anyway, I'm not even asking you to fix those problems. All I'm
> asking you is to let me do *my* job, part of which is to help prevent
> GPU hangs from happening in the first place. For that, I need useful
> debugging facilities -- and so do others.
>
>
>>> Again, being able to disable GPU recovery is a crucial debugging
>>> feature. We need to be able to inspect the live state of hung shaders,
>>> and we need to be able to single-step through shaders. All of that
>>> requires disabling GPU recovery.
>> Yeah, I'm perfectly aware of that. The problem is this is just *not*
>> supported on Linux for graphics shaders.
>>
>> What you can do is to run the shader with something like CWSR enabled
>> (or an to be invented graphics equivalent). Since we are debugging the
>> shader anyway that should be possible I think.
>>
>>> Forcing people to reboot just to be able to disable GPU recovery for
>>> debugging is developer hostile.
>> Well, I think you misunderstood me. The suggestion was even to force
>> them to re-compile the kernel driver to disable GPU recovery.
>>
>> Disabling GPU recovery is *not* something you can do and expect the
>> system to be stable.
>>
>> The only case we can do that is when we attach a JTAG debugger in an AMD
>> lab.
> You're being *completely* unreasonable here. Even Windows(!) allows
> disabling GPU recovery at runtime from software, and Windows is
> usually far more developer hostile than Linux in these things.
> Seriously, this level of hostility against developers coming from you
> is not okay.

Well, I'm not hostile against developers, but just realistic that this 
will lead to even more problems.

And I rather avoid problems with end-users than with developers because 
the later are usually the more skilled people.

As far as I can see that Windows allowed to disable GPU recovery was 
actually the source of the problem and is absolutely no argument to 
repeat the same mistake on Linux again.

> Yes, it's a tool that has sharp edges. That is perfectly well
> understood. If we need to add warning labels then so be it. And if the
> details of *how* to change the timeout or disable GPU recovery at
> runtime should be changed, that too is fine. But it's an important
> tool. Can we please just move forward on this in a pragmatic fashion?

Yes and because of this I'm just rejecting this approach here.

Rebooting to disable GPU reset is perfectly fine and reasonable to do 
for a developer.

As I said the requirement I have for the other extreme is to make it a 
compile time only option and I'm trying to avoid that as well.

Regards,
Christian.

>
> Thanks,
> Nicolai
>
>
>> Regards,
>> Christian.
>>
>>> So again, if there really are cases where this "doesn't work" (and
>>> those cases aren't just that your desktop will freeze -- that part is
>>> intentional), then let's talk through it and see how to address them.
>>>
>>> Thanks,
>>> Nicolai
>>>
>>>
>>>> Regards,
>>>> Christian.
>>>>
>>>>> Signed-off-by: Nicolai Hähnle <nicolai.haehnle@amd.com>
>>>>> ---
>>>>>     drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c | 32 +++++++++++++++++++++++-
>>>>>     1 file changed, 31 insertions(+), 1 deletion(-)
>>>>>
>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
>>>>> index dc474b809604..32d223daa789 100644
>>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
>>>>> @@ -471,35 +471,65 @@ static ssize_t amdgpu_debugfs_ring_read(struct file *f, char __user *buf,
>>>>>
>>>>>          return result;
>>>>>     }
>>>>>
>>>>>     static const struct file_operations amdgpu_debugfs_ring_fops = {
>>>>>          .owner = THIS_MODULE,
>>>>>          .read = amdgpu_debugfs_ring_read,
>>>>>          .llseek = default_llseek
>>>>>     };
>>>>>
>>>>> +static int amdgpu_debugfs_timeout_ring_get(void *data, u64 *val) {
>>>>> +     struct amdgpu_ring *ring = data;
>>>>> +
>>>>> +     if (ring->sched.timeout == MAX_SCHEDULE_TIMEOUT)
>>>>> +             *val = 0;
>>>>> +     else
>>>>> +             *val = jiffies_to_msecs(ring->sched.timeout);
>>>>> +
>>>>> +     return 0;
>>>>> +}
>>>>> +
>>>>> +static int amdgpu_debugfs_timeout_ring_set(void *data, u64 val) {
>>>>> +     struct amdgpu_ring *ring = data;
>>>>> +
>>>>> +     if (val == 0)
>>>>> +             ring->sched.timeout = MAX_SCHEDULE_TIMEOUT;
>>>>> +     else
>>>>> +             ring->sched.timeout = msecs_to_jiffies(val);
>>>>> +
>>>>> +     return 0;
>>>>> +}
>>>>> +
>>>>> +DEFINE_DEBUGFS_ATTRIBUTE(amdgpu_debugfs_timeout_ring_fops,
>>>>> +                      amdgpu_debugfs_timeout_ring_get,
>>>>> +                      amdgpu_debugfs_timeout_ring_set,
>>>>> +                      "%llu\n");
>>>>> +
>>>>>     #endif
>>>>>
>>>>>     void amdgpu_debugfs_ring_init(struct amdgpu_device *adev,
>>>>>                                struct amdgpu_ring *ring)
>>>>>     {
>>>>>     #if defined(CONFIG_DEBUG_FS)
>>>>>          struct drm_minor *minor = adev_to_drm(adev)->primary;
>>>>>          struct dentry *root = minor->debugfs_root;
>>>>> -     char name[32];
>>>>> +     char name[40];
>>>>>
>>>>>          sprintf(name, "amdgpu_ring_%s", ring->name);
>>>>>          debugfs_create_file_size(name, S_IFREG | S_IRUGO, root, ring,
>>>>>                                   &amdgpu_debugfs_ring_fops,
>>>>>                                   ring->ring_size + 12);
>>>>>
>>>>> +     sprintf(name, "amdgpu_timeout_ring_%s", ring->name);
>>>>> +     debugfs_create_file(name, S_IFREG | S_IRUGO | S_IWUSR, root, ring,
>>>>> +                         &amdgpu_debugfs_timeout_ring_fops);
>>>>>     #endif
>>>>>     }
>>>>>
>>>>>     /**
>>>>>      * amdgpu_ring_test_helper - tests ring and set sched readiness status
>>>>>      *
>>>>>      * @ring: ring to try the recovery on
>>>>>      *
>>>>>      * Tests ring and set sched readiness status
>>>>>      *
>

