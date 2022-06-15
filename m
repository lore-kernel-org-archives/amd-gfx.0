Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E4F0C43334
	for <amd-gfx@archiver.kernel.org>; Wed, 15 Jun 2022 07:25:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 05BE910E323;
	Wed, 15 Jun 2022 07:25:16 +0000 (UTC)
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com
 [IPv6:2a00:1450:4864:20::62d])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E9EAD10F2B9
 for <amd-gfx@lists.freedesktop.org>; Wed, 15 Jun 2022 07:25:13 +0000 (UTC)
Received: by mail-ej1-x62d.google.com with SMTP id kq6so21405590ejb.11
 for <amd-gfx@lists.freedesktop.org>; Wed, 15 Jun 2022 00:25:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=message-id:date:mime-version:user-agent:subject:content-language:to
 :cc:references:from:in-reply-to:content-transfer-encoding;
 bh=zQ82uvgZY6i93ipKV7uEQykoXhrmPEXClKZ9VvqIlIs=;
 b=qaOztP0/dHbfIzCgfqzy9cMMKyNXokZxqe0DObCykG9vLaSPiiqqQV45/EwsiAYMjn
 epvq4rhUPHQBAV1dpzVd2cIeuBtv2+u1kQDp/TQOmnWsbfKDv0f4xgENIdHmYEgrF64R
 0OaBGev9zDz/g5PMz2yB/T66ZfclI++8aJQmMUqNu9GPuAtb3D+AEle+e2E4AG6sjaog
 osXGcWGJWtPu6jeM3uvMIBMQvdyGiqpwCy2Aaxr7rgClo6MFm3pWIWsE2zVwqG/9UNDw
 KmVNR8va3+VFemQA+gAgRNVq5GPWEAV2v6X8yE5fNHFPd3TbgZ0Sk4l/QWIg1w69RhfV
 /4lQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:cc:references:from:in-reply-to
 :content-transfer-encoding;
 bh=zQ82uvgZY6i93ipKV7uEQykoXhrmPEXClKZ9VvqIlIs=;
 b=0r4nq5cLc9R58D7tGJKqGWAQ0/vuIxTzOwOMAA60aBguy120cD0LjAPnaj4FLiQmeC
 bj12KtBef5p68QbU7QgmRXaz6Yabl0zRLL6H+cBP3wluuFaVB91/2/UMZHzGW1DsbHAp
 Xqo/62VdK2kW+ZRTzMXOQk4s/62kTgZk9ceoLFyVE8OoCtS8acrTNddz0hCELNt/PH2B
 0+l8k8F2GVioTz4VtGry+V4H1ocC9tZbJX5g36fPQJ9SAE4hKs4R30iKpCKWp4PgYF1T
 03W4X26UFDjl7G+Jq5xzW6lKVHZqbKNu+m9QsLjNODj15Q6Xf6DNO7eNCeHQSCx9Um7S
 wqwA==
X-Gm-Message-State: AJIora+QXDaX1G/XV8FvFHlihX66Cr6nz472pWWYAXxQqHQk4kEoCl5c
 A7nGAfmSA3bOnyw4pHJcxyE=
X-Google-Smtp-Source: ABdhPJx5oMkLeBWAH0SE2kyxjyYck+aMWs6rLkLjco6bvKjwjXOlPGkaYrtNbcyujX5NsrB96Sspig==
X-Received: by 2002:a17:906:848b:b0:718:c04a:5131 with SMTP id
 m11-20020a170906848b00b00718c04a5131mr7351315ejx.70.1655277912375; 
 Wed, 15 Jun 2022 00:25:12 -0700 (PDT)
Received: from [192.168.178.21] (p5b0ea4d2.dip0.t-ipconnect.de.
 [91.14.164.210]) by smtp.gmail.com with ESMTPSA id
 y15-20020a056402440f00b00435201d96f8sm734526eda.16.2022.06.15.00.25.11
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 15 Jun 2022 00:25:11 -0700 (PDT)
Message-ID: <6433a478-f96b-2fc4-317f-bf34a8b2e8f2@gmail.com>
Date: Wed, 15 Jun 2022 09:25:10 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH] drm/amdgpu: Adjust logic around GTT size (v3)
Content-Language: en-US
To: Alex Deucher <alexdeucher@gmail.com>,
 =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
References: <20220520150912.762831-1-alexander.deucher@amd.com>
 <CADnq5_OZ5e1hfA_6O1q=evs0RbVsH1xf8xybcarTMztZhdvEsg@mail.gmail.com>
 <f27f1a49-7ecd-ef6c-7886-eed078c4e752@amd.com>
 <CADnq5_NkvUwT7-ohb7ZBq-ErptkAokUPnWcvnT7+gxKt77LmqA@mail.gmail.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
In-Reply-To: <CADnq5_NkvUwT7-ohb7ZBq-ErptkAokUPnWcvnT7+gxKt77LmqA@mail.gmail.com>
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
Cc: Alex Deucher <alexander.deucher@amd.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Well the key point is it isn't better. It's just that different people 
will start complaining.

I'm fine with trying to change it once more, just keep in mind that we 
decide between two evils and somebody could start complaining.

Christian.

Am 14.06.22 um 15:43 schrieb Alex Deucher:
> I don't see how this is worse than the current behavior.  We have some
> bug reports where we have games that use a lot of memory and with the
> lower limit the system ends up dying due to swapping and the behavior
> is actually better with the patch.
>
> Alex
>
> On Thu, Jun 2, 2022 at 2:03 PM Christian König <christian.koenig@amd.com> wrote:
>> I totally agree on the reasoning, but I have the strong feeling that
>> this will blow up in our face once more.
>>
>> I've tried to raise this limit twice already and had to revert it both
>> times. And the reasons why I had to revert it haven't changed since them.
>>
>> Christian.
>>
>> Am 02.06.22 um 18:40 schrieb Alex Deucher:
>>> @Christian Koenig
>>> Any objections to this?  I realize that fixing the OOM killer is
>>> ultimately the right approach, but I don't really see how this makes
>>> things worse.  The current scheme is biased towards dGPUs as they have
>>> lots of on board memory so on dGPUs we can end up setting gtt size to
>>> 3/4 of system memory already in a lot of cases since there is often as
>>> much vram as system memory.  Due to the limits in ttm, we can't use
>>> more than half at the moment anway, so this shouldn't make things
>>> worse on dGPUs and would help a lot of APUs.  Once could make the
>>> argument that with more vram there is less need for gtt so less chance
>>> for OOM, but I think it is more of a scale issue.  E.g., on dGPUs
>>> you'll generally be running higher resolutions and texture quality,
>>> etc. so the overall memory footprint is just scaled up.
>>>
>>> Alex
>>>
>>> On Fri, May 20, 2022 at 11:09 AM Alex Deucher <alexander.deucher@amd.com> wrote:
>>>> Certain GL unit tests for large textures can cause problems
>>>> with the OOM killer since there is no way to link this memory
>>>> to a process.  This was originally mitigated (but not necessarily
>>>> eliminated) by limiting the GTT size.  The problem is this limit
>>>> is often too low for many modern games so just make the limit 1/2
>>>> of system memory. The OOM accounting needs to be addressed, but
>>>> we shouldn't prevent common 3D applications from being usable
>>>> just to potentially mitigate that corner case.
>>>>
>>>> Set default GTT size to max(3G, 1/2 of system ram) by default.
>>>>
>>>> v2: drop previous logic and default to 3/4 of ram
>>>> v3: default to half of ram to align with ttm
>>>>
>>>> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
>>>> ---
>>>>    drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c | 20 ++++++++++++++------
>>>>    1 file changed, 14 insertions(+), 6 deletions(-)
>>>>
>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
>>>> index d2b5cccb45c3..7195ed77c85a 100644
>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
>>>> @@ -1798,18 +1798,26 @@ int amdgpu_ttm_init(struct amdgpu_device *adev)
>>>>           DRM_INFO("amdgpu: %uM of VRAM memory ready\n",
>>>>                    (unsigned) (adev->gmc.real_vram_size / (1024 * 1024)));
>>>>
>>>> -       /* Compute GTT size, either bsaed on 3/4th the size of RAM size
>>>> +       /* Compute GTT size, either bsaed on 1/2 the size of RAM size
>>>>            * or whatever the user passed on module init */
>>>>           if (amdgpu_gtt_size == -1) {
>>>>                   struct sysinfo si;
>>>>
>>>>                   si_meminfo(&si);
>>>> -               gtt_size = min(max((AMDGPU_DEFAULT_GTT_SIZE_MB << 20),
>>>> -                              adev->gmc.mc_vram_size),
>>>> -                              ((uint64_t)si.totalram * si.mem_unit * 3/4));
>>>> -       }
>>>> -       else
>>>> +               /* Certain GL unit tests for large textures can cause problems
>>>> +                * with the OOM killer since there is no way to link this memory
>>>> +                * to a process.  This was originally mitigated (but not necessarily
>>>> +                * eliminated) by limiting the GTT size.  The problem is this limit
>>>> +                * is often too low for many modern games so just make the limit 1/2
>>>> +                * of system memory which aligns with TTM. The OOM accounting needs
>>>> +                * to be addressed, but we shouldn't prevent common 3D applications
>>>> +                * from being usable just to potentially mitigate that corner case.
>>>> +                */
>>>> +               gtt_size = max((AMDGPU_DEFAULT_GTT_SIZE_MB << 20),
>>>> +                              (u64)si.totalram * si.mem_unit / 2);
>>>> +       } else {
>>>>                   gtt_size = (uint64_t)amdgpu_gtt_size << 20;
>>>> +       }
>>>>
>>>>           /* Initialize GTT memory pool */
>>>>           r = amdgpu_gtt_mgr_init(adev, gtt_size);
>>>> --
>>>> 2.35.3
>>>>

