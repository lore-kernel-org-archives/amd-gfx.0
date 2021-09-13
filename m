Return-Path: <SRS0=miQW=OD=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A6E7C433EF
	for <amd-gfx@archiver.kernel.org>; Mon, 13 Sep 2021 06:58:58 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DD8C060F26
	for <amd-gfx@archiver.kernel.org>; Mon, 13 Sep 2021 06:58:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org DD8C060F26
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5A7E56E0FB;
	Mon, 13 Sep 2021 06:58:57 +0000 (UTC)
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com
 [IPv6:2a00:1450:4864:20::32b])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CE91F6E0FB
 for <amd-gfx@lists.freedesktop.org>; Mon, 13 Sep 2021 06:58:55 +0000 (UTC)
Received: by mail-wm1-x32b.google.com with SMTP id
 l7-20020a1c2507000000b002e6be5d86b3so5786342wml.3
 for <amd-gfx@lists.freedesktop.org>; Sun, 12 Sep 2021 23:58:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-transfer-encoding:content-language;
 bh=Wfle4IqK8H7xc4O5kcaVvV3VkRhEz7S73r4nmziwrKk=;
 b=HgvKL5nSUTc1lqhN22RytDrfY6l+GbIJ/jncwJOHyoxizTdgvrrvrbrul0sb0JXGIT
 IBYaKsHNJvFES0HLsB1mE1+DDtOzFMPZs4VPDYvLXg4kg5rBVC2ooqKRxsQBn/00YQo8
 7q+bBNCtKzBsgef+lDOAScZ4p5CGE/HnL0K9C646Ogv9Ap5ypqNphSZTy2ADbzVtI7e1
 vPkYazQqV6z301cdn6FDBK2uhNovS2BJXDmDMt27roDjpXOvXJ8MKntckFirgyG2KSyF
 7+s8/Ii7AcVwj/BAuZCQnjYMCgc+nqGC0UENGNyxjGVfxJ8lmRYxP0drMeaR/7nXQe2m
 3rcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=Wfle4IqK8H7xc4O5kcaVvV3VkRhEz7S73r4nmziwrKk=;
 b=418A4AeccGPGxw40wK70w6LPHH+vAAmvckKbc4Zu6eX7dkYPqKmmrLM1txxoVRiD+3
 ufES/V8SV+cCS1n0Ni5VYCdxagzzjB1+42KET8O4vZGhfEQLjBZk3K6TYOM5/24nB3En
 3pcFCeemntiFaP2OKVlK3v/L7uXmuPsKZIWNQ2iVe9v+MjRYc9FtT0yB/z9IHBHXT/c1
 wx1rqcJu0+DAxSkvJZQS15xeAMrC7HRme/vRzUc1ATkXaaWpIl56Wqv2B14FEyIfXySJ
 kqOm/xfKsspvccYMvXwd9zlVbKvCg2Mt6/1jAYJQILwoC/7yniQp9PZeVDVI55gSR8m6
 cYYQ==
X-Gm-Message-State: AOAM530tjm/eY4d9zdLltjKKvy8ArACvrJoZwu4eP9FONHN0mB8W/cPN
 Wcg5P/tLi5TW8oxY1FgnZJONZQyaOy+SFF83
X-Google-Smtp-Source: ABdhPJzhV6lnxvm6Rbi1FrdqMUbVOIvXsSt+A1PgJBQeEWU6sRtGbtOryXHSmGS32wauw20SRhPhRg==
X-Received: by 2002:a05:600c:19ca:: with SMTP id
 u10mr9489506wmq.178.1631516334544; 
 Sun, 12 Sep 2021 23:58:54 -0700 (PDT)
Received: from [192.168.178.21] (p5b0ea1b5.dip0.t-ipconnect.de.
 [91.14.161.181])
 by smtp.gmail.com with ESMTPSA id z7sm8109816wre.72.2021.09.12.23.58.53
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 12 Sep 2021 23:58:54 -0700 (PDT)
Subject: =?UTF-8?B?UmU6IOWbnuWkjTog5Zue5aSNOiBbUEFUQ0hdIGRybS9hbWRncHU6IEZp?=
 =?UTF-8?Q?x_a_race_of_IB_test?=
To: "Pan, Xinhui" <Xinhui.Pan@amd.com>,
 "Koenig, Christian" <Christian.Koenig@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>
References: <20210911015513.3822-1-xinhui.pan@amd.com>
 <d983949c-6386-cb32-d361-c70efc206e2c@gmail.com>
 <DM4PR12MB5165351AA7C45CCDBD15AAC187D79@DM4PR12MB5165.namprd12.prod.outlook.com>
 <91fd7ad8-b4f0-b30e-9f3e-eab229b7375e@amd.com>
 <DM4PR12MB5165B03844A88C4E5BB3D3A087D99@DM4PR12MB5165.namprd12.prod.outlook.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
Message-ID: <bce9e578-3a99-6ff6-fab9-b22e985a180f@gmail.com>
Date: Mon, 13 Sep 2021 08:58:52 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <DM4PR12MB5165B03844A88C4E5BB3D3A087D99@DM4PR12MB5165.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
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

Yeah, because we avoid need to allocate an entity otherwise.

Ok, all that comes swapped back into my head once more.

As far as I can see that should work, but I would ask Andrey as well 
since he now takes care of GPU reset.

Christian.

Am 13.09.21 um 08:55 schrieb Pan, Xinhui:
> [AMD Official Use Only]
>
> These IB tests are all using direct IB submission including the delayed init work.
> ________________________________________
> 发件人: Koenig, Christian <Christian.Koenig@amd.com>
> 发送时间: 2021年9月13日 14:19
> 收件人: Pan, Xinhui; Christian König; amd-gfx@lists.freedesktop.org
> 抄送: Deucher, Alexander
> 主题: Re: 回复: [PATCH] drm/amdgpu: Fix a race of IB test
>
> Well is the delayed init work using direct submission or submission
> through the scheduler?
>
> If the later we have the down_write of the reset semaphore pulled in
> through the scheduler dependency.
>
> Anyway just having the sync before taking the lock should work.
>
> Christian.
>
> Am 11.09.21 um 12:18 schrieb Pan, Xinhui:
>> [AMD Official Use Only]
>>
>> For the possible deadlock, we can just move flush_delayed_work above down_write. not a big thing.
>> But I am not aware why delayed init work would try to lock reset_sem.
>>
>> delayed init work is enqueued when device resume. It calls amdgpu_ib_ring_tests directly. We need one sync method.
>> But I see device resume itself woud flush it. So there is no race between them as userspace is still freezed.
>>
>> I will drop this flush in V2.
>> ________________________________________
>> 发件人: Christian König <ckoenig.leichtzumerken@gmail.com>
>> 发送时间: 2021年9月11日 15:45
>> 收件人: Pan, Xinhui; amd-gfx@lists.freedesktop.org
>> 抄送: Deucher, Alexander; Koenig, Christian
>> 主题: Re: [PATCH] drm/amdgpu: Fix a race of IB test
>>
>>
>>
>> Am 11.09.21 um 03:55 schrieb xinhui pan:
>>> Direct IB submission should be exclusive. So use write lock.
>>>
>>> Signed-off-by: xinhui pan <xinhui.pan@amd.com>
>>> ---
>>>     drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c | 9 +++++++--
>>>     1 file changed, 7 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
>>> index 19323b4cce7b..acbe02928791 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
>>> @@ -1358,10 +1358,15 @@ static int amdgpu_debugfs_test_ib_show(struct seq_file *m, void *unused)
>>>         }
>>>
>>>         /* Avoid accidently unparking the sched thread during GPU reset */
>>> -     r = down_read_killable(&adev->reset_sem);
>>> +     r = down_write_killable(&adev->reset_sem);
>>>         if (r)
>>>                 return r;
>>>
>>> +     /* Avoid concurrently IB test but not cancel it as I don't know whether we
>>> +      * would add more code in the delayed init work.
>>> +      */
>>> +     flush_delayed_work(&adev->delayed_init_work);
>>> +
>> That won't work. It's at least theoretical possible that the delayed
>> init work waits for the reset_sem which we are holding here.
>>
>> Very unlikely to happen, but lockdep might be able to point that out
>> with a nice backtrace in the logs.
>>
>> On the other hand delayed init work and direct IB test through this
>> interface should work at the same time, so I would just drop it.
>>
>> Christian.
>>
>>>         /* hold on the scheduler */
>>>         for (i = 0; i < AMDGPU_MAX_RINGS; i++) {
>>>                 struct amdgpu_ring *ring = adev->rings[i];
>>> @@ -1387,7 +1392,7 @@ static int amdgpu_debugfs_test_ib_show(struct seq_file *m, void *unused)
>>>                 kthread_unpark(ring->sched.thread);
>>>         }
>>>
>>> -     up_read(&adev->reset_sem);
>>> +     up_write(&adev->reset_sem);
>>>
>>>         pm_runtime_mark_last_busy(dev->dev);
>>>         pm_runtime_put_autosuspend(dev->dev);

