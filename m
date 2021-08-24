Return-Path: <SRS0=c7t5=NP=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8828FC4338F
	for <amd-gfx@archiver.kernel.org>; Tue, 24 Aug 2021 13:19:03 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 48AC0610D0
	for <amd-gfx@archiver.kernel.org>; Tue, 24 Aug 2021 13:19:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 48AC0610D0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C57A089AA6;
	Tue, 24 Aug 2021 13:19:02 +0000 (UTC)
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com
 [IPv6:2a00:1450:4864:20::332])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1DF2C89AB7
 for <amd-gfx@lists.freedesktop.org>; Tue, 24 Aug 2021 13:19:01 +0000 (UTC)
Received: by mail-wm1-x332.google.com with SMTP id i3so1993252wmq.3
 for <amd-gfx@lists.freedesktop.org>; Tue, 24 Aug 2021 06:19:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-transfer-encoding:content-language;
 bh=i0+s1J0YCMNiXPjOz5204jCoybUc18+3U+anbdhVegs=;
 b=A7TOp/OE3ZkHtMKP2QfRDrQU6o2lAw6rRV+diSlFlMQPhuiTSMDL+YbpVLSOH9vs/H
 RpaXuSIl9lFr79s43de57qWP2c3KaFlsc/6KFhYOkNiAw2VQsC4V+r46BRjd71Od0RE9
 m+yAJERtox8KyBNapNonhOxwfBiCSIMyBdk7Douqswo1yIzRpjOPRTTt3spFxSGjo4OP
 B9YvNRO0btlvXbcl6HNh1k2SLNHmWro0O3EaZs7n9bVOPD9ZJ7Mm7GhqKIjCkQHyEMXo
 NPgTPsG55+HaLOkR9ACZE5+HKKrHIeR+awnYnjFl+OMF35rrxsr/Vncv3fnf013pi/2/
 dE5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=i0+s1J0YCMNiXPjOz5204jCoybUc18+3U+anbdhVegs=;
 b=VHE7H9TlMhxtIyueUCrkB3RhsMO5bKCkVoDqcp7oLFYwMmrK9dBCsccoshw1BO1Q++
 0C0SZD8smkP0kXtrrCuoq23Tm1d/8ys2azsbUdrTGk5i0aZ98jq1q7jcWYheavSFvfGa
 fcmXqPGKe6siYuwxFmXhSf1Y/G4PkyoM/pRBQeBQNezKCW9pqDnZIs7DNSZNBhV1t0Ny
 AWfBmY0z/4UZySMerNstwo8+ygz9EKF39tUDlFHB2cIjK275oIQt5FW8+UYRj6yFn43q
 iiNZlQ52tMucn6LJ4toDKJSTe4632GCHcRjgD8nPmRPeRU3t1dEHxANC/wGwnvTfwGWP
 lz7w==
X-Gm-Message-State: AOAM532cW+9xVhsyBJamSlDMS/Z0qbPTlQQEtbBa0zppzbI6IrTOcdN2
 GH03T58fvjwtGog200ovV+4=
X-Google-Smtp-Source: ABdhPJzmOBakx3iYbfiBZQLwtEwEviWQlQQkqB8dH/MrdL3IDYRaFCSTyZvuhkK8r65DBZfaWrsz0A==
X-Received: by 2002:a7b:cc85:: with SMTP id p5mr4177249wma.42.1629811139720;
 Tue, 24 Aug 2021 06:18:59 -0700 (PDT)
Received: from [192.168.178.21] (p5b0ea1b5.dip0.t-ipconnect.de.
 [91.14.161.181])
 by smtp.gmail.com with ESMTPSA id 17sm2286991wmj.20.2021.08.24.06.18.58
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 24 Aug 2021 06:18:59 -0700 (PDT)
Subject: Re: [PATCH 1/5] drm/sched:add new priority level
To: "Das, Nirmoy" <nirmoy.das@amd.com>,
 =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
 Satyajit Sahu <satyajit.sahu@amd.com>, amd-gfx@lists.freedesktop.org
Cc: leo.liu@amd.com, Alexander.Deucher@amd.com, shashank.sharma@amd.com
References: <20210824055510.1189185-1-satyajit.sahu@amd.com>
 <66607af7-5310-629f-1851-df4b74cebf7d@amd.com>
 <4e2337a6-8d76-49ba-c0b3-e89f4c04b4a0@amd.com>
 <49509444-2e27-86e6-abe5-8a44dedc0f10@amd.com>
 <89f6e6e7-662d-995f-a281-7e5712fff772@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
Message-ID: <6223bf14-653c-12c5-d871-483d43aca98f@gmail.com>
Date: Tue, 24 Aug 2021 15:18:57 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <89f6e6e7-662d-995f-a281-7e5712fff772@amd.com>
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

Am 24.08.21 um 14:39 schrieb Das, Nirmoy:
>
> On 8/24/2021 2:07 PM, Christian König wrote:
>> Am 24.08.21 um 13:57 schrieb Das, Nirmoy:
>>> Hi Christian,
>>>
>>> On 8/24/2021 8:10 AM, Christian König wrote:
>>>> I haven't followed the previous discussion, but that looks like 
>>>> this change is based on a misunderstanding.
>>>
>>>
>>> In previous discussion I sort of suggested to have new DRM prio as I 
>>> didn't see any other way to map priority provided by the userspace 
>>> to this new 3rd hw priority.
>>>
>>> Do you think we should use other information from userspace like 
>>> queue id to determine hardware priority ?
>>
>> If I'm not completely mistaken we have dropped the concept of 
>> exposing multiple queues/instances completely.
>
>
> Yes, that is my understanding too.
>
>>
>> What we should probably do is to use the (cleaned up) UAPI enum for 
>> init_priority and override_priority instead of the drm scheduler enums.
>
>
> I went through the drm code, now I see what you mean. So what we are 
> now doing is:  mapping  AMDGPU_CTX_PRIORITY_*  to 
> DRM_SCHED_PRIORITY_*  and then to hw priority which is not nice.
>
> We should rather map AMDGPU_CTX_PRIORITY_* to hw priority directly.

Exactly that's my idea, yes.

If you want feel free to put this on your TODO for a potential cleanup.

Christian.

>
>
> Regards,
>
> Nirmoy
>
>
>>
>> Regards,
>> Christian.
>>
>>>
>>>
>>> Regards,
>>>
>>> Nirmoy
>>>
>>>>
>>>> Those here are the software priorities used in the scheduler, but 
>>>> what you are working on are the hardware priorities.
>>>>
>>>> That are two completely different things which we shouldn't mix up.
>>>>
>>>> Regards,
>>>> Christian.
>>>>
>>>> Am 24.08.21 um 07:55 schrieb Satyajit Sahu:
>>>>> Adding a new priority level DRM_SCHED_PRIORITY_VERY_HIGH
>>>>>
>>>>> Signed-off-by: Satyajit Sahu <satyajit.sahu@amd.com>
>>>>> ---
>>>>>   include/drm/gpu_scheduler.h | 1 +
>>>>>   1 file changed, 1 insertion(+)
>>>>>
>>>>> diff --git a/include/drm/gpu_scheduler.h 
>>>>> b/include/drm/gpu_scheduler.h
>>>>> index d18af49fd009..d0e5e234da5f 100644
>>>>> --- a/include/drm/gpu_scheduler.h
>>>>> +++ b/include/drm/gpu_scheduler.h
>>>>> @@ -40,6 +40,7 @@ enum drm_sched_priority {
>>>>>       DRM_SCHED_PRIORITY_MIN,
>>>>>       DRM_SCHED_PRIORITY_NORMAL,
>>>>>       DRM_SCHED_PRIORITY_HIGH,
>>>>> +    DRM_SCHED_PRIORITY_VERY_HIGH,
>>>>>       DRM_SCHED_PRIORITY_KERNEL,
>>>>>         DRM_SCHED_PRIORITY_COUNT,
>>>>
>>

