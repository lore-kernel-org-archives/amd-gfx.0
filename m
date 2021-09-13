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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14133C433F5
	for <amd-gfx@archiver.kernel.org>; Mon, 13 Sep 2021 06:38:01 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D2C7160F92
	for <amd-gfx@archiver.kernel.org>; Mon, 13 Sep 2021 06:38:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org D2C7160F92
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 82F4F6E0ED;
	Mon, 13 Sep 2021 06:38:00 +0000 (UTC)
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com
 [IPv6:2a00:1450:4864:20::436])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6E6576E0ED
 for <amd-gfx@lists.freedesktop.org>; Mon, 13 Sep 2021 06:37:59 +0000 (UTC)
Received: by mail-wr1-x436.google.com with SMTP id m9so12874787wrb.1
 for <amd-gfx@lists.freedesktop.org>; Sun, 12 Sep 2021 23:37:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-transfer-encoding:content-language;
 bh=OiE3hVTk1pjyUHHtJ5P9w2X8u4VYoUZtvzZcaR1zlMY=;
 b=hKZcqRl17uPvxHILYYUesdBVaNTgRr5ZbzvGRsjBrKZnF3KCm3l6Ypj+3YRK5c51me
 fPk3H3MU8tKI4g/lkbWl1VFPCsShHk+CgTFBDuSs8X5d22jQStPI+hiKVH0L2yezI2QN
 YFXxT5mCcFQ9EZnHIUqkmTh61HlHyNdxoaBO6V67wpK7skm3aPV2G3KHVsUM0FJ62NAw
 z7CKN+29rPypBTvtLmy8dnZDbJiy6YrfHHIZoDPwR5rLlP73EvcNzHqzCUTWN4tm/wOZ
 LYzGyU6qXefIlYH08n9XSainOhhNV6elqpVUgGwpuEwkaVnSQgb0wciOnW1CcS00ElAv
 noWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=OiE3hVTk1pjyUHHtJ5P9w2X8u4VYoUZtvzZcaR1zlMY=;
 b=1laggzTkWoGbC00WbMVB7kl3y64DqtHFMsmxQGmb5CSJNuMGB96GDGqlHnYs6VsdeW
 /wWjs8DE7L+ikc3jENWAC5K2s3HUj2ggjWM4ZII2Dyvjd43mD/lVU848I4NxrMHM2WgW
 Ul/DrNK+37F5gruJcZn0nUi010r403R1r/nIcuzUTnopUVy/3oWlNqAGW7L8Iu5hMZqw
 S26BifObf8xABC4y9u5wJbH5QNDouL7pl9kEmcz9Kl7czfpMdsn30ZA9OljSSFbLOEmT
 aWbOR+Ga/4HygT0hQamHNg0oHxUsUI468yq831OqdGyTH0MZf8boi5VSkkwUBSZcsfVq
 eCZQ==
X-Gm-Message-State: AOAM530+1N+n6mbU5OFE4IZBWYljCauEg/zfTXO2m2ZEgSpWBli6QQWR
 6bQtqKsYvBOIat0m8DQuUrrBPu6FPP1uzvsT
X-Google-Smtp-Source: ABdhPJyXkkl8s+51cHIBPXbMKOjJQUG09xvvov5p0HvasQvHZS73f1zzgjumb0ZfLikLDniv/NTUGw==
X-Received: by 2002:a5d:58d0:: with SMTP id o16mr10867584wrf.392.1631515077974; 
 Sun, 12 Sep 2021 23:37:57 -0700 (PDT)
Received: from [192.168.178.21] (p5b0ea1b5.dip0.t-ipconnect.de.
 [91.14.161.181])
 by smtp.gmail.com with ESMTPSA id p13sm6348422wro.8.2021.09.12.23.37.57
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 12 Sep 2021 23:37:57 -0700 (PDT)
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
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
Message-ID: <5417fd27-b121-c73a-08da-1fab2cf65cde@gmail.com>
Date: Mon, 13 Sep 2021 08:37:56 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <c5dd6689-1f76-203d-3d1b-fc3dbfe7056a@amd.com>
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

That's complete nonsense.

The debugfs interface emulates parts of the reset procedure for testing 
and we absolutely need to take the same locks as the reset to avoid 
corruption of the involved objects.

Regards,
Christian.

Am 13.09.21 um 08:25 schrieb Lazar, Lijo:
> This is a debugfs interface and adding another writer contention in 
> debugfs over an actual reset is lazy fix. This shouldn't be executed 
> in the first place and should not take precedence over any reset.
>
> Thanks,
> Lijo
>
>
> On 9/13/2021 11:52 AM, Christian König wrote:
>> NAK, this is not the lazy way to fix it at all.
>>
>> The reset semaphore protects the scheduler and ring objects from 
>> concurrent modification, so taking the write side of it is perfectly 
>> valid here.
>>
>> Christian.
>>
>> Am 13.09.21 um 06:42 schrieb Pan, Xinhui:
>>> [AMD Official Use Only]
>>>
>>> yep, that is a lazy way to fix it.
>>>
>>> I am thinking of adding one amdgpu_ring.direct_access_mutex before 
>>> we issue test_ib on each ring.
>>> ________________________________________
>>> 发件人: Lazar, Lijo <Lijo.Lazar@amd.com>
>>> 发送时间: 2021年9月13日 12:00
>>> 收件人: Pan, Xinhui; amd-gfx@lists.freedesktop.org
>>> 抄送: Deucher, Alexander; Koenig, Christian
>>> 主题: Re: [PATCH v2] drm/amdgpu: Fix a race of IB test
>>>
>>>
>>>
>>> On 9/13/2021 5:18 AM, xinhui pan wrote:
>>>> Direct IB submission should be exclusive. So use write lock.
>>>>
>>>> Signed-off-by: xinhui pan <xinhui.pan@amd.com>
>>>> ---
>>>>    drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c | 4 ++--
>>>>    1 file changed, 2 insertions(+), 2 deletions(-)
>>>>
>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c 
>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
>>>> index 19323b4cce7b..be5d12ed3db1 100644
>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
>>>> @@ -1358,7 +1358,7 @@ static int amdgpu_debugfs_test_ib_show(struct 
>>>> seq_file *m, void *unused)
>>>>        }
>>>>
>>>>        /* Avoid accidently unparking the sched thread during GPU 
>>>> reset */
>>>> -     r = down_read_killable(&adev->reset_sem);
>>>> +     r = down_write_killable(&adev->reset_sem);
>>> There are many ioctls and debugfs calls which takes this lock and as 
>>> you
>>> know the purpose is to avoid them while there is a reset. The 
>>> purpose is
>>> *not to* fix any concurrency issues those calls themselves have
>>> otherwise and fixing those concurrency issues this way is just lazy and
>>> not acceptable.
>>>
>>> This will take away any fairness given to the writer in this rw lock 
>>> and
>>> that is supposed to be the reset thread.
>>>
>>> Thanks,
>>> Lijo
>>>
>>>>        if (r)
>>>>                return r;
>>>>
>>>> @@ -1387,7 +1387,7 @@ static int amdgpu_debugfs_test_ib_show(struct 
>>>> seq_file *m, void *unused)
>>>>                kthread_unpark(ring->sched.thread);
>>>>        }
>>>>
>>>> -     up_read(&adev->reset_sem);
>>>> +     up_write(&adev->reset_sem);
>>>>
>>>>        pm_runtime_mark_last_busy(dev->dev);
>>>>        pm_runtime_put_autosuspend(dev->dev);
>>>>
>>

