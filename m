Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A377AC3ABD8
	for <amd-gfx@archiver.kernel.org>; Fri, 16 May 2025 11:53:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 30BFC10E122;
	Fri, 16 May 2025 11:53:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=ursulin-net.20230601.gappssmtp.com header.i=@ursulin-net.20230601.gappssmtp.com header.b="DMmoEwQB";
	dkim-atps=neutral
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com
 [209.85.128.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2AA1210E135
 for <amd-gfx@lists.freedesktop.org>; Fri, 16 May 2025 11:53:23 +0000 (UTC)
Received: by mail-wm1-f51.google.com with SMTP id
 5b1f17b1804b1-442ea95f738so15085995e9.3
 for <amd-gfx@lists.freedesktop.org>; Fri, 16 May 2025 04:53:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ursulin-net.20230601.gappssmtp.com; s=20230601; t=1747396402; x=1748001202;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=ch/Rj/4SdVJXjJR99ndnnvzfGLGPgBeB9n9xS7Ien3E=;
 b=DMmoEwQBEO3HDYDU23xvNv8Jl6wRraU59uPG7gv4Eh6L9SH6Uy/nYFRDl9OiFlSVYM
 zQJRzX/TywMSolUVro0A72YnhUL2pFoB3Hn28tuG8iMmhdv3m6KNs6C96TSf6uAxyAvy
 9BxSKGOP3dzmOMfMfJluvnaXtesQZ/WahBMyA7/JkD/fas9nHIRZzCCjtKO4ZKiy0OcW
 OwCu4sLDAw92zFjhHXN9kSnCycP/RTlvMolNm8p66xC96Gb87hLWPQ0D+lhHK5JNlAqN
 UoBfSkfVSdR9haLCu+dqE966yrlmNixwPunZGeDoET0yAhgc1Sqs7kFKOIDoFRQkRCg/
 ayUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747396402; x=1748001202;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ch/Rj/4SdVJXjJR99ndnnvzfGLGPgBeB9n9xS7Ien3E=;
 b=l+XQjbsxGKY8b2Qb0urU8mNgSJAqZ4OymHqLZRwBwuyLXrwWpCygOoriaOsjvnz/dE
 WswJuR2Uw6y4JOS+vN6l6/EFT1Q255s20H/OlOKF+z+QTn+nZY6xFKlcIb7SX1YGxsTl
 AYgj+X0csoySp9tKdFtdYk/KfQEla++FgEUF9lXzcYDhTyzux1TiU8336EnBHch/i5Vh
 74x8zqLL1aPLhdVP/vkxCiBC9MPv0jsO7SF+XoJDuoXpH0KyPO0mnwcouygVD51/7e4I
 8VH0jrcU43k4xDDI3nBVu2sbXd60vUDcYz7SL7GmVQS0EGvtXqzktj0pJTSh9/Yv2Met
 n3fA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWbxLA4v7qCAcnxaCznTnU1RSepPJ83Hh5IZGi2PMMCZE5iI6JhX2vhrIi4xwtQazw+3YbHlQ8+@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzmbYc9EQwOkNYr+z7KzsnxM+Ft+zbB/5WUUSeUzyMjtqpxSHhU
 BgkA/LY/bEE91+FdcAiy7CIBhYKcOdVjqi+eGiz34V2+s8o9mAZ4wREX1HXta8gId8c=
X-Gm-Gg: ASbGncvaIhZ54G7sr9JtNUMdAQPH6JS/vUGfPVPJdrLqu6shm2KhjLnXAZntOy6IP9J
 Q9xmvffBxt+jZFh4Ugf+k0rjVFGZVwEHzudkZqcgm7AQpNfsXqCIZkWoGhnUrEXidQ91VbyCQ6S
 njdg6ErW4IC/R1soH8QZW9RuxpyNWAQPr54lXZ7VecBdjBxZt9SKrI7ONm/yXHkBwciNDURJzdl
 evJzvTQYxhpIYmkzpvtg02PJgqtG1WWcaEmhoJnyFumBxH8vh7X2TS70f625U4dwechJJOFkZvM
 ue7Snz1O2fN6cikvfXvard6sP9i4DZmM34Nziu53DCdZXByhz9lwAOfc9PUhGc/bzS2sEVvBPuN
 b
X-Google-Smtp-Source: AGHT+IHQsiIPvOFAJlqSMsIWnhuK/gUiucGTkaZKv3CGdN8sUyHAnOxOXDFebOG3iH+aAxlsz6g+fg==
X-Received: by 2002:a05:600c:1e87:b0:43d:585f:ebf5 with SMTP id
 5b1f17b1804b1-442fd60b4c2mr28328285e9.1.1747396401644; 
 Fri, 16 May 2025 04:53:21 -0700 (PDT)
Received: from [192.168.0.101] ([81.79.92.254])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-442ebda7d2csm73546695e9.3.2025.05.16.04.53.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 16 May 2025 04:53:20 -0700 (PDT)
Message-ID: <6e5ab077-77ff-443b-b345-7d99fcd01a73@ursulin.net>
Date: Fri, 16 May 2025 12:53:20 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] drm/sched: add drm_sched_prealloc_dependency_slots v3
To: phasta@kernel.org, =?UTF-8?Q?Christian_K=C3=B6nig?=
 <ckoenig.leichtzumerken@gmail.com>, dri-devel@lists.freedesktop.org,
 dakr@kernel.org, amd-gfx@lists.freedesktop.org
References: <20250515150038.4615-1-christian.koenig@amd.com>
 <20250515150038.4615-2-christian.koenig@amd.com>
 <a5e53b34-c247-4193-b4ab-551693ad089a@ursulin.net>
 <5c93f114a58e84796f239b9e0f4a13e9c223e45b.camel@mailbox.org>
Content-Language: en-GB
From: Tvrtko Ursulin <tursulin@ursulin.net>
In-Reply-To: <5c93f114a58e84796f239b9e0f4a13e9c223e45b.camel@mailbox.org>
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


On 16/05/2025 08:28, Philipp Stanner wrote:
> On Thu, 2025-05-15 at 17:17 +0100, Tvrtko Ursulin wrote:
>>
>> On 15/05/2025 16:00, Christian König wrote:
>>> Sometimes drivers need to be able to submit multiple jobs which
>>> depend on
>>> each other to different schedulers at the same time, but using
>>> drm_sched_job_add_dependency() can't fail any more after the first
>>> job is
>>> initialized.
>>>
>>> This function preallocate memory for dependency slots so that no
>>> ENOMEM
>>> can come later while adding dependencies.
>>>
>>> v2: rework implementation an documentation
>>> v3: rework from scratch, use separate function to add preallocated
>>> deps
> 
> I think we agreed to not put change logs into commit messages anymore
> :)
> 
> They aren't useful for any reader. Who needs the changelog afterwards
> can retreive it through the mail thread link that we add.
> 
>>>
>>> Signed-off-by: Christian König <christian.koenig@amd.com>
>>> ---
>>>    drivers/gpu/drm/scheduler/sched_main.c | 45
>>> ++++++++++++++++++++++++++
>>>    include/drm/gpu_scheduler.h            |  4 +++
>>>    2 files changed, 49 insertions(+)
>>>
>>> diff --git a/drivers/gpu/drm/scheduler/sched_main.c
>>> b/drivers/gpu/drm/scheduler/sched_main.c
>>> index f7118497e47a..b95e7089aa70 100644
>>> --- a/drivers/gpu/drm/scheduler/sched_main.c
>>> +++ b/drivers/gpu/drm/scheduler/sched_main.c
>>> @@ -858,6 +858,51 @@ void drm_sched_job_arm(struct drm_sched_job
>>> *job)
>>>    }
>>>    EXPORT_SYMBOL(drm_sched_job_arm);
>>>    
>>> +/**
>>> + * drm_sched_job_prealloc_dependency_slot - avoid ENOMEM on adding
>>> dependencies
>>> + * @job: scheduler job where dependencies will be added
>>> + * @id: id for the allocated slot
>>> +  *
>>> + * Sometimes drivers need to be able to submit multiple jobs which
>>> depend on
>>> + * each other to different schedulers at the same time, but using
>>> + * drm_sched_job_add_dependency() can't fail any more after the
>>> first job is
>>> + * initialized.
>>> + *
>>> + * This function preallocate memory for a dependency slot so that
>>> no ENOMEM can
>>> + * come later while adding dependencies. The index of the
>>> preallocated slot is
>>> + * returned in @id.
>>> + *
>>> + * Return:
>>> + * 0 on success, or an error on failing to expand the array.
>>> + */
>>> +int drm_sched_job_prealloc_dependency_slot(struct drm_sched_job
>>> *job,
>>> +					   u32 *id)
>>> +{
>>> +	return xa_alloc(&job->dependencies, id, NULL,
>>> xa_limit_32b, GFP_KERNEL);
>>> +}
>>> +EXPORT_SYMBOL(drm_sched_job_prealloc_dependency_slot);
>>> +
>>> +/**
>>> + * drm_sched_job_add_prealloc_dep - add dependency to preallocated
>>> slot
>>> + * @job: scheduler job where dependencies will be added
>>> + * @id: the preallocated slot index
>>> + * @fence: the dependency to add
>>> + *
>>> + * Consumes @fence and adds it to the preallocated slot
>>> dependency.
>>> + */
>>> +void drm_sched_job_add_prealloc_dep(struct drm_sched_job *job, u32
>>> id,
>>> +				    struct dma_fence *fence)
>>> +{
>>> +	fence = xa_store(&job->dependencies, id, fence,
>>> GFP_ATOMIC);
>>
>> Add assert that the passed id exists (was preallocated) and is NULL?
> 
> You

Hm?

>>
>> Also, if someone preallocates and does not consume the slot will that
>> confuse the iteration in drm_sched_job_dependency()?
> 
> drm_sched_job_add_dependency() you mean.

I was actually thinking of drm_sched_job_dependency() because that 
looked it would skip dependencies upon encountering an unconsumed 
preallocated slot, but yes, drm_sched_job_add_dependency() could explode 
even earlier if adding a normal dependency after preallocating a slot.

> Yes, it would. All operations simply give you NULL for those slots. So
> seems to me you have to check for NULL wherever a preallocated slot
> might drop out. That would then be a bug.
> 
> It's kind of tricky, all that. It's a pity that Wilcox didn't answer
> our questions about the idiomatic way to do it.
> 
> Maybe reserving slots with already signaled fences wasn't such a bad
> idea after all?
> 
> If we go for the NULL approach, it's probably the only sane way to then
> check for NULL wherever dependencies are accessed :(
> 
> Opinions?

Well if the xarray API returns the NULL consistently the approach from 
this patch is fine I think.

We just need to add two more checks to the above mentioned functions, 
some more unit tests probably to make sure, and that should be fine for now.

On the bikeshedding front I would perhaps suggest:

  - drm_sched_job_preallocate_dependency()
  - drm_sched_job_replace_dependency()

Reads a little bit more aligned with the rest of the API and a bit 
easier on the eyes, to my eyes at least.

Regards,

Tvrtko

