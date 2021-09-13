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
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFE34C433F5
	for <amd-gfx@archiver.kernel.org>; Mon, 13 Sep 2021 06:51:15 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 558ED60F26
	for <amd-gfx@archiver.kernel.org>; Mon, 13 Sep 2021 06:51:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 558ED60F26
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EF2EA6E0F8;
	Mon, 13 Sep 2021 06:51:14 +0000 (UTC)
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com
 [IPv6:2a00:1450:4864:20::435])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 923A96E0F8
 for <amd-gfx@lists.freedesktop.org>; Mon, 13 Sep 2021 06:51:13 +0000 (UTC)
Received: by mail-wr1-x435.google.com with SMTP id b6so12881644wrh.10
 for <amd-gfx@lists.freedesktop.org>; Sun, 12 Sep 2021 23:51:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-transfer-encoding:content-language;
 bh=A6X09hfp5adSc3y7atbEVf1vWTfHyN0HNLRscVw/RPw=;
 b=X6hIGIzf8we91Du79TyvXqZQKnncNzVIp1jhjtBdL4vjO4PggZXWM06eYo/y81nTb4
 /tnoXs3pge78/vKjtROEK3vB6mUCiiF8s0fwNQBQ051vASRb9IvtlwC1AKLbfw9lfbWi
 SrsLjZ9IoBJRprSJBuTVSSiieXI5i4x69InzdEMfjEPOMdV2XkZOKahwHfTnUP0nTkfI
 2j8TsCCSltNGyMBd3LJYuozVjFfhXta6ZErWPnhHihUjS9ENO666/SgAWvnl/LOhyhJd
 HEsSB2th0Q+KPGKaDXIZoG+cEqYixstT8LyfmiDk3hl8xNes+KAHm5eK47XK9WNvEyC0
 TDmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=A6X09hfp5adSc3y7atbEVf1vWTfHyN0HNLRscVw/RPw=;
 b=318AJP3KSyLKFfohJzZzNBqlNj5b2joX6IcTjDJDl3L7HFlb228asvqRxxTzUgKDts
 xs7sFmaFzvwGneJGHp9hd5GR2xY2QJXeUEHTmtXIeSRsXE7qkMec+fxBpfp0q9Yu+BA4
 bnejxd+XxLXdsB+NzropR/+suPGiwxLt5aONmnaXKeMVdDtQSem6QmWODSQvAnN6QgrO
 BE10Odaso9BvZore3rHB6korhiVW4ZtYRZ1IDlXU/NWCn76UHj8ogNeyB1rtWANNJZCc
 5gs2+aJqHdn5CrmNaBtnw6hwGSD7k9u5/1YJjMCC7CF9E5HbKGXZ/1BX/fmdZFkO5M8B
 fRzQ==
X-Gm-Message-State: AOAM531d8e2C1WAnE3jDl9FtzBt/iGXzpIImmkAwyHHql2oHkXUyZHMS
 Ee72MX5gRCIvGg1fYUirILZPwbmE9mjm7DkZ
X-Google-Smtp-Source: ABdhPJxxN9hfGfZRpK8MCzOlNfoz0zQ3Emwws0Xp7PR4W1fH2x+R7kmVTQ+9LXSoyNPQKcj5cPSK8A==
X-Received: by 2002:adf:b7cd:: with SMTP id t13mr10746623wre.63.1631515872152; 
 Sun, 12 Sep 2021 23:51:12 -0700 (PDT)
Received: from [192.168.178.21] (p5b0ea1b5.dip0.t-ipconnect.de.
 [91.14.161.181])
 by smtp.gmail.com with ESMTPSA id d17sm2899792wrp.57.2021.09.12.23.51.11
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 12 Sep 2021 23:51:11 -0700 (PDT)
Subject: =?UTF-8?B?UmU6IOWbnuWkjTogW1BBVENIIHYyXSBkcm0vYW1kZ3B1OiBGaXggYSBy?=
 =?UTF-8?Q?ace_of_IB_test?=
To: "Lazar, Lijo" <lijo.lazar@amd.com>,
 =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
 "Pan, Xinhui" <Xinhui.Pan@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>
References: <20210912234817.13051-1-xinhui.pan@amd.com>
 <886e89f7-3ba0-fb5c-4a13-d802e0c5b5dc@amd.com>
 <DM4PR12MB5165E20BBBC6E7BF30F3DE9E87D99@DM4PR12MB5165.namprd12.prod.outlook.com>
 <c2ca0459-1884-ee4c-8569-474fb93148d6@amd.com>
 <c5dd6689-1f76-203d-3d1b-fc3dbfe7056a@amd.com>
 <5417fd27-b121-c73a-08da-1fab2cf65cde@gmail.com>
 <042106ac-b55f-351d-cbed-86a08ce60204@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
Message-ID: <beb849ee-0cf6-53a0-a563-56400e6cfacc@gmail.com>
Date: Mon, 13 Sep 2021 08:51:10 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <042106ac-b55f-351d-cbed-86a08ce60204@amd.com>
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

Keep in mind that we don't try to avoid contention here. The goal is 
rather to have as few locks as possible to avoid the extra overhead in 
the hot path.

Contention is completely irrelevant for the debug and device reset since 
that are rarely occurring events and performance doesn't matter for them.

It is perfectly reasonable to take the write side of the reset lock as 
necessary when we need to make sure that we don't have concurrent device 
access.

Regards,
Christian.

Am 13.09.21 um 08:43 schrieb Lazar, Lijo:
> There are other interfaces to emulate the exact reset process, or 
> atleast this is not the one we are using for doing any sort of reset 
> through debugfs.
>
> In any case, the expectation is reset thread takes the write side of 
> the lock and it's already done somewhere else.
>
> Reset semaphore is supposed to protect the device from concurrent 
> access (any sort of resource usage is thus protected by default). Then 
> the same logic can be applied for any other call and that is not a 
> reasonable ask.
>
> Thanks,
> Lijo
>
> On 9/13/2021 12:07 PM, Christian König wrote:
>> That's complete nonsense.
>>
>> The debugfs interface emulates parts of the reset procedure for 
>> testing and we absolutely need to take the same locks as the reset to 
>> avoid corruption of the involved objects.
>>
>> Regards,
>> Christian.
>>
>> Am 13.09.21 um 08:25 schrieb Lazar, Lijo:
>>> This is a debugfs interface and adding another writer contention in 
>>> debugfs over an actual reset is lazy fix. This shouldn't be executed 
>>> in the first place and should not take precedence over any reset.
>>>
>>> Thanks,
>>> Lijo
>>>
>>>
>>> On 9/13/2021 11:52 AM, Christian König wrote:
>>>> NAK, this is not the lazy way to fix it at all.
>>>>
>>>> The reset semaphore protects the scheduler and ring objects from 
>>>> concurrent modification, so taking the write side of it is 
>>>> perfectly valid here.
>>>>
>>>> Christian.
>>>>
>>>> Am 13.09.21 um 06:42 schrieb Pan, Xinhui:
>>>>> [AMD Official Use Only]
>>>>>
>>>>> yep, that is a lazy way to fix it.
>>>>>
>>>>> I am thinking of adding one amdgpu_ring.direct_access_mutex before 
>>>>> we issue test_ib on each ring.
>>>>> ________________________________________
>>>>> 发件人: Lazar, Lijo <Lijo.Lazar@amd.com>
>>>>> 发送时间: 2021年9月13日 12:00
>>>>> 收件人: Pan, Xinhui; amd-gfx@lists.freedesktop.org
>>>>> 抄送: Deucher, Alexander; Koenig, Christian
>>>>> 主题: Re: [PATCH v2] drm/amdgpu: Fix a race of IB test
>>>>>
>>>>>
>>>>>
>>>>> On 9/13/2021 5:18 AM, xinhui pan wrote:
>>>>>> Direct IB submission should be exclusive. So use write lock.
>>>>>>
>>>>>> Signed-off-by: xinhui pan <xinhui.pan@amd.com>
>>>>>> ---
>>>>>>    drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c | 4 ++--
>>>>>>    1 file changed, 2 insertions(+), 2 deletions(-)
>>>>>>
>>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c 
>>>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
>>>>>> index 19323b4cce7b..be5d12ed3db1 100644
>>>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
>>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
>>>>>> @@ -1358,7 +1358,7 @@ static int 
>>>>>> amdgpu_debugfs_test_ib_show(struct seq_file *m, void *unused)
>>>>>>        }
>>>>>>
>>>>>>        /* Avoid accidently unparking the sched thread during GPU 
>>>>>> reset */
>>>>>> -     r = down_read_killable(&adev->reset_sem);
>>>>>> +     r = down_write_killable(&adev->reset_sem);
>>>>> There are many ioctls and debugfs calls which takes this lock and 
>>>>> as you
>>>>> know the purpose is to avoid them while there is a reset. The 
>>>>> purpose is
>>>>> *not to* fix any concurrency issues those calls themselves have
>>>>> otherwise and fixing those concurrency issues this way is just 
>>>>> lazy and
>>>>> not acceptable.
>>>>>
>>>>> This will take away any fairness given to the writer in this rw 
>>>>> lock and
>>>>> that is supposed to be the reset thread.
>>>>>
>>>>> Thanks,
>>>>> Lijo
>>>>>
>>>>>>        if (r)
>>>>>>                return r;
>>>>>>
>>>>>> @@ -1387,7 +1387,7 @@ static int 
>>>>>> amdgpu_debugfs_test_ib_show(struct seq_file *m, void *unused)
>>>>>>                kthread_unpark(ring->sched.thread);
>>>>>>        }
>>>>>>
>>>>>> -     up_read(&adev->reset_sem);
>>>>>> +     up_write(&adev->reset_sem);
>>>>>>
>>>>>>        pm_runtime_mark_last_busy(dev->dev);
>>>>>>        pm_runtime_put_autosuspend(dev->dev);
>>>>>>
>>>>
>>

