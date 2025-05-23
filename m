Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8983C54ED0
	for <amd-gfx@archiver.kernel.org>; Fri, 23 May 2025 07:31:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 49EBD10E764;
	Fri, 23 May 2025 07:31:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=ursulin-net.20230601.gappssmtp.com header.i=@ursulin-net.20230601.gappssmtp.com header.b="PP8VWoNb";
	dkim-atps=neutral
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com
 [209.85.128.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BB07210E739
 for <amd-gfx@lists.freedesktop.org>; Fri, 23 May 2025 07:31:13 +0000 (UTC)
Received: by mail-wm1-f49.google.com with SMTP id
 5b1f17b1804b1-43cec5cd73bso61141735e9.3
 for <amd-gfx@lists.freedesktop.org>; Fri, 23 May 2025 00:31:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ursulin-net.20230601.gappssmtp.com; s=20230601; t=1747985472; x=1748590272;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=CYhAthGa9gJYx9jvT9hSNnJWsFQv9/mr1QZZijHDPt0=;
 b=PP8VWoNbTgLm8GesFJotTKp7Aw6diQgBpu2RBfaqdv4Prd1qr5wMcYV7niy46Sj7Qw
 RL3E9Co07nkv75A/u8UI50KYgTuJstJ4RUTaJlYbEqXGI7sooXbSCOeo24EYDs97xlsV
 zMAo3PVZOwxfSfkI+L2NHDFIbSm0gTcWmijUEDqKMDJIjZH173Cl2ZUPn8dWBpmte6Se
 KwPYr3J3A5xaJw8H3FgTYsSd21Yl9FhxOdIE95zCW2bqnCYMA2hBzgHNrv1gno7GGN1h
 mTr1vEh86gaqjw67jjgssYcsmkPAIzuyahH4rxvJuzDQIeAvZHmpHUprRU+XEenwLsyo
 Yy9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747985472; x=1748590272;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=CYhAthGa9gJYx9jvT9hSNnJWsFQv9/mr1QZZijHDPt0=;
 b=jWBFRPeHumoxkh44lEq2lCgKfTsoAy2Dif/xfZUrLkLf0r34ovUfC2Rn0tr6qCU6gQ
 sfkQbcbhozn/skDi7aDSx4FsQyEiFa7bpUJ+tgUfJ+iwa40SURCkmGXGmvWs5cxVQF9W
 HXxKQ0ohtx1lYqGFUk2cPwdyKnD5BO/Dpp/m98wHI9gRYk9P80sEcHsMuFcCQMyU8iam
 uPoJKbJZjKtZulAiRZiTNpd1bB3aZSTS2B1lvsTaLqKN3ClGW9YTPeF477StwCVqMIla
 LlzgLae6nnntTX1BX1UgexKY4RUQMZNtY69AqFAyt4b7+hKvXpr/2J1RvkZZohRdwp16
 cI4w==
X-Forwarded-Encrypted: i=1;
 AJvYcCWFUdk23aBvcz1XT8ofFw3YxF8tBo1j9hj8SChd4W6U+oOEpIQGVkGtkiUULxCL0rfRtzaODYHv@lists.freedesktop.org
X-Gm-Message-State: AOJu0Ywkijelr5rrHKrq0p6KXr2qizozs9fZEHvf8MLwrp9EoRgVqhYJ
 LvYZSi+nkfoKJ4p951ojCqC4VJM0Ug62J+/NUchlspjRy8xzHkKB2ifMml9osGPBf+0=
X-Gm-Gg: ASbGncvga2ppFpiTRxQuxUF/LgJYVLKacBvdyawI33v+TwCokSXB2TWqjXON09e15DB
 ndFzSgd4YxSW7id0KRAAVT7Cy6vCRF7/CPM34E3yB3j6L7D0KvZ38L1ket8p7XX84+xNoTVy3Pp
 hgKlDw94Uf0ctwfudX20cTxSeIKwd+2ePRig+6mXC8yIVmmSNbpXxwCoOaXBKsGlsp5Jp9JqEzB
 QyDZqRAgIkWYrOi4vctUixdD1pHDIIRYHy5FdIQDZYT7FRuw4d1+YgsGW51A5TmUSB68rODvJOm
 0FHE2C3edzSUu31cHKLnDhVjo08fhLy+ncfBkAFWswUJi+FsLXu23qsXKNpsSziUm0hVKrCxQ5h
 Q
X-Google-Smtp-Source: AGHT+IEwGvFm0HXVLgk/8IrmbCAODtVutSbSzSkO4RDWoMpqep3Y9odTNjA0FuY8ZUzhQ0x34QlFQQ==
X-Received: by 2002:a05:600c:4fc9:b0:43d:5ec:b2f4 with SMTP id
 5b1f17b1804b1-442fd6271b6mr343621315e9.10.1747985472032; 
 Fri, 23 May 2025 00:31:12 -0700 (PDT)
Received: from [192.168.0.101] ([81.79.92.254])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-447f6b29548sm139469445e9.4.2025.05.23.00.31.11
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 23 May 2025 00:31:11 -0700 (PDT)
Message-ID: <142de347-34b4-40ee-b76c-c9b4ab070888@ursulin.net>
Date: Fri, 23 May 2025 08:31:11 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/4] drm/sched: optimize drm_sched_job_add_dependency a bit
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 dri-devel@lists.freedesktop.org, phasta@mailbox.org, dakr@kernel.org,
 amd-gfx@lists.freedesktop.org
References: <20250522134117.7561-1-christian.koenig@amd.com>
 <20250522134117.7561-2-christian.koenig@amd.com>
 <a96a73ee-32a5-4c38-b277-e76101b94837@ursulin.net>
 <bdf82e27-ae7e-4580-ab77-c05842bc8ec1@amd.com>
Content-Language: en-GB
From: Tvrtko Ursulin <tursulin@ursulin.net>
In-Reply-To: <bdf82e27-ae7e-4580-ab77-c05842bc8ec1@amd.com>
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


On 22/05/2025 17:19, Christian König wrote:
> On 5/22/25 16:27, Tvrtko Ursulin wrote:
>>
>> On 22/05/2025 14:41, Christian König wrote:
>>> Since we already iterated over the xarray we know at which index the new
>>> entry should be stored. So instead of using xa_alloc use xa_store and
>>> write into the index directly.
>>>
>>> Signed-off-by: Christian König <christian.koenig@amd.com>
>>> ---
>>>    drivers/gpu/drm/scheduler/sched_main.c | 12 ++++++------
>>>    1 file changed, 6 insertions(+), 6 deletions(-)
>>>
>>> diff --git a/drivers/gpu/drm/scheduler/sched_main.c b/drivers/gpu/drm/scheduler/sched_main.c
>>> index f7118497e47a..d2d64bf17c96 100644
>>> --- a/drivers/gpu/drm/scheduler/sched_main.c
>>> +++ b/drivers/gpu/drm/scheduler/sched_main.c
>>> @@ -871,10 +871,8 @@ EXPORT_SYMBOL(drm_sched_job_arm);
>>>    int drm_sched_job_add_dependency(struct drm_sched_job *job,
>>>                     struct dma_fence *fence)
>>>    {
>>> +    unsigned long index = -1;
>>>        struct dma_fence *entry;
>>> -    unsigned long index;
>>> -    u32 id = 0;
>>> -    int ret;
>>>          if (!fence)
>>>            return 0;
>>> @@ -896,11 +894,13 @@ int drm_sched_job_add_dependency(struct drm_sched_job *job,
>>>            return 0;
>>>        }
>>>    -    ret = xa_alloc(&job->dependencies, &id, fence, xa_limit_32b, GFP_KERNEL);
>>> -    if (ret != 0)
>>> +    entry = xa_store(&job->dependencies, index + 1, fence, GFP_KERNEL);
>>
>>  From the code it looks index does not "move" for NULL slots?
> 
> Correct, but I just found out that the macro initializes index to zero, so that approach also doesn't work.
> 
> *sigh* going to look into this again tomorrow. It looks like this use case is somehow not well supported at all by xarray.

Back to the stub fence and __dma_fence_is_signaled()? ;)

Regards,

Tvrtko

>> That is, if someone:
>>
>> 1) Preallocates one entry, when trying to populate it index will be -1 after xa_for_each?
>>
>> 2) Add one, preallocate one, then add one more - index will be 0 after xa_for_each?
>>
>> Regards,
>>
>> Tvrtko
>>
>>> +    if (xa_is_err(entry))
>>>            dma_fence_put(fence);
>>> +    else
>>> +        WARN_ON(entry);
>>>    -    return ret;
>>> +    return xa_err(entry);
>>>    }
>>>    EXPORT_SYMBOL(drm_sched_job_add_dependency);
>>>    
>>
> 

