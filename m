Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8BB4EC77B6E
	for <amd-gfx@archiver.kernel.org>; Thu, 13 Apr 2023 15:54:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2A5C410EB6E;
	Thu, 13 Apr 2023 15:54:18 +0000 (UTC)
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com
 [IPv6:2a00:1450:4864:20::42a])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2850C10EB6E
 for <amd-gfx@lists.freedesktop.org>; Thu, 13 Apr 2023 15:54:17 +0000 (UTC)
Received: by mail-wr1-x42a.google.com with SMTP id e7so4601898wrc.12
 for <amd-gfx@lists.freedesktop.org>; Thu, 13 Apr 2023 08:54:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1681401254; x=1683993254;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=rN8EC6dav/FulVTMFXIGJZIOAstxck9VAFxRk5N2rys=;
 b=CHgQbAT4Sd9QHAn2DfjzN/0P75QFhrKIcegzpR3up7ThDD+Mdg+ZR6lMFpjrtpWBBo
 XMSM1L8/1FJJfMo9hRWrODiH33Jzr23bFG5bxPpkmBgLd8TtnKWSrBb/U7A+UL1f3r4t
 qbS7t2bo6oTapYLGmqNp9ImifInzhgN3ev4OxvblKPQbYoOoXmjSwdnqDsP8DynHfsXw
 BiPnZ6GL+nxiZroP0QfZM1uyHNQn4ggVkHyhOeHjdJDmyDooW8xYv1kuNuwJjlB9ezMQ
 v3ezTP8NYd2jEUrsdQjZYrvdp1MZYISPnBV2DY3J5yjViCPVTAfpfkxtNw5+SVlfOyKC
 OrOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1681401254; x=1683993254;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=rN8EC6dav/FulVTMFXIGJZIOAstxck9VAFxRk5N2rys=;
 b=YHCxYHvTFVvD5iDExP1OOGqo5zJhkSzHI8ocL3KHcIr40rXtWeySlhmDKFcX8g2XGz
 gd3jCl2fpOqmu0Y93iTpZNzjEvk/jg2womtyrpR5YNbYsZ6NhS0iGa2MMMgiNyC5+Z3/
 9M/xMpLtcJgErFeZ0ZeWuWu8Klrn+FoI49rh+uFqo1sOZBPizTeLLtEdQrFhcSCpLOp/
 kDVx6IAdCkd4+8t8KckWsJJivBJXbMDZ46vPHjkgPw6by2INVLlo2pcEmto/1cM9ngpe
 F8nXJqyfAgxbR0vEzE7QhY3QcogMtBHzxi5hFwWkHsO0vCEF5V45I7d2SmKzcI7R4bcC
 Yqjg==
X-Gm-Message-State: AAQBX9e6Lkalpdu2sfQ1GyH7O9cqp4GxLJh0/0IH67mZyiHO4ts70Qou
 nTuVS8O6U7vDmXRhS+dnLy4=
X-Google-Smtp-Source: AKy350Z9FySkBr2Ba10kXArW3EOlx+SXWnBqmmDUapbrceBV7w0g9sJknYInm7l+mDgmf8EGrhQkFw==
X-Received: by 2002:adf:dec6:0:b0:2e5:1c60:5afd with SMTP id
 i6-20020adfdec6000000b002e51c605afdmr2104727wrn.1.1681401254134; 
 Thu, 13 Apr 2023 08:54:14 -0700 (PDT)
Received: from ?IPV6:2a02:908:1256:79a0:440:a9c4:837:e799?
 ([2a02:908:1256:79a0:440:a9c4:837:e799])
 by smtp.gmail.com with ESMTPSA id
 o5-20020adfeac5000000b002f483a1210asm1535310wrn.98.2023.04.13.08.54.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 13 Apr 2023 08:54:13 -0700 (PDT)
Message-ID: <8b2df4e1-ad00-a834-3382-d25f1c667978@gmail.com>
Date: Thu, 13 Apr 2023 17:54:12 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH 03/13] drm/amdgpu/UAPI: add new CS chunk for GFX shadow
 buffers
Content-Language: en-US
To: Alex Deucher <alexdeucher@gmail.com>
References: <20230330191750.1134210-1-alexander.deucher@amd.com>
 <20230330191750.1134210-4-alexander.deucher@amd.com>
 <CAAxE2A7nvmXdUaXESi4g6HVBFxk+dooz7tZYQfjGE8O2fKFi-w@mail.gmail.com>
 <8a98b160-5276-54f5-d166-e12a572892e9@amd.com>
 <CAAxE2A4LzFudfzTNRr290ORZvcF6-xzKiyNM6LZ3uiZDPerf5Q@mail.gmail.com>
 <b1485943-5f0a-1a7e-f0a4-b35771b48a23@gmail.com>
 <CAAxE2A6m346bTD7G=wMa=8OcRmk6OHui9N=Z9B5xHCS4VxxYwQ@mail.gmail.com>
 <2897fa79-f0ef-1ddb-dc38-05ef429fe0d9@gmail.com>
 <CAAxE2A5mf8J_1JJvgPgx-G07zcc3vcHOD6jWUXL8Mhx3g-Zufw@mail.gmail.com>
 <0e2e1902-54e8-0626-c7ca-3f818f8792fb@gmail.com>
 <CADnq5_MrY3QtU_--B=OYD+_+nx6jNyzJfOxBzfoPrmeLJC6h3Q@mail.gmail.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
In-Reply-To: <CADnq5_MrY3QtU_--B=OYD+_+nx6jNyzJfOxBzfoPrmeLJC6h3Q@mail.gmail.com>
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
 amd-gfx mailing list <amd-gfx@lists.freedesktop.org>,
 =?UTF-8?B?TWFyZWsgT2zFocOhaw==?= <maraeo@gmail.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Am 13.04.23 um 14:26 schrieb Alex Deucher:
> On Thu, Apr 13, 2023 at 7:32 AM Christian König
> <ckoenig.leichtzumerken@gmail.com> wrote:
>> Ok, then we have a problem.
>>
>> Alex what do you think?
> If you program it to 0, FW skips the GDS backup I think so UMD's can
> decide whether they want to use it or not, depending on whether they
> use GDS.

Yeah, but when Mesa isn't using it we have a hard way justifying to 
upstream that because it isn't tested at all.

Christian.

>
> Alex
>
>
>> Christian.
>>
>> Am 13.04.23 um 11:21 schrieb Marek Olšák:
>>
>> That's not why it was removed. It was removed because userspace doesn't use GDS memory and gds_va is always going to be 0.
>>
>> Firmware shouldn't use it because using it would increase preemption latency.
>>
>> Marek
>>
>> On Sun, Apr 9, 2023, 11:21 Christian König <ckoenig.leichtzumerken@gmail.com> wrote:
>>> We removed the GDS information because they were unnecessary. The GDS size was already part of the device info before we added the shadow info.
>>>
>>> But as far as I know the firmware needs valid VAs for all three buffers or won't work correctly.
>>>
>>> Christian.
>>>
>>> Am 06.04.23 um 17:01 schrieb Marek Olšák:
>>>
>>> There is no GDS shadowing info in the device info uapi, so userspace can't create any GDS buffer and thus can't have any GDS va. It's a uapi issue, not what firmware wants to do.
>>>
>>> Marek
>>>
>>> On Thu, Apr 6, 2023 at 6:31 AM Christian König <ckoenig.leichtzumerken@gmail.com> wrote:
>>>> That's what I thought as well, but Mitch/Hans insisted on that.
>>>>
>>>> We should probably double check internally.
>>>>
>>>> Christian.
>>>>
>>>> Am 06.04.23 um 11:43 schrieb Marek Olšák:
>>>>
>>>> GDS memory isn't used on gfx11. Only GDS OA is used.
>>>>
>>>> Marek
>>>>
>>>> On Thu, Apr 6, 2023 at 5:09 AM Christian König <christian.koenig@amd.com> wrote:
>>>>> Why that?
>>>>>
>>>>> This is the save buffer for GDS, not the old style GDS BOs.
>>>>>
>>>>> Christian.
>>>>>
>>>>> Am 06.04.23 um 09:36 schrieb Marek Olšák:
>>>>>
>>>>> gds_va is unnecessary.
>>>>>
>>>>> Marek
>>>>>
>>>>> On Thu, Mar 30, 2023 at 3:18 PM Alex Deucher <alexander.deucher@amd.com> wrote:
>>>>>> For GFX11, the UMD needs to allocate some shadow buffers
>>>>>> to be used for preemption.  The UMD allocates the buffers
>>>>>> and passes the GPU virtual address to the kernel since the
>>>>>> kernel will program the packet that specified these
>>>>>> addresses as part of its IB submission frame.
>>>>>>
>>>>>> v2: UMD passes shadow init to tell kernel when to initialize
>>>>>>      the shadow
>>>>>>
>>>>>> Reviewed-by: Christian König <christian.koenig@amd.com>
>>>>>> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
>>>>>> ---
>>>>>>   include/uapi/drm/amdgpu_drm.h | 10 ++++++++++
>>>>>>   1 file changed, 10 insertions(+)
>>>>>>
>>>>>> diff --git a/include/uapi/drm/amdgpu_drm.h b/include/uapi/drm/amdgpu_drm.h
>>>>>> index b6eb90df5d05..3d9474af6566 100644
>>>>>> --- a/include/uapi/drm/amdgpu_drm.h
>>>>>> +++ b/include/uapi/drm/amdgpu_drm.h
>>>>>> @@ -592,6 +592,7 @@ struct drm_amdgpu_gem_va {
>>>>>>   #define AMDGPU_CHUNK_ID_SCHEDULED_DEPENDENCIES 0x07
>>>>>>   #define AMDGPU_CHUNK_ID_SYNCOBJ_TIMELINE_WAIT    0x08
>>>>>>   #define AMDGPU_CHUNK_ID_SYNCOBJ_TIMELINE_SIGNAL  0x09
>>>>>> +#define AMDGPU_CHUNK_ID_CP_GFX_SHADOW   0x0a
>>>>>>
>>>>>>   struct drm_amdgpu_cs_chunk {
>>>>>>          __u32           chunk_id;
>>>>>> @@ -708,6 +709,15 @@ struct drm_amdgpu_cs_chunk_data {
>>>>>>          };
>>>>>>   };
>>>>>>
>>>>>> +#define AMDGPU_CS_CHUNK_CP_GFX_SHADOW_FLAGS_INIT_SHADOW         0x1
>>>>>> +
>>>>>> +struct drm_amdgpu_cs_chunk_cp_gfx_shadow {
>>>>>> +       __u64 shadow_va;
>>>>>> +       __u64 csa_va;
>>>>>> +       __u64 gds_va;
>>>>>> +       __u64 flags;
>>>>>> +};
>>>>>> +
>>>>>>   /*
>>>>>>    *  Query h/w info: Flag that this is integrated (a.h.a. fusion) GPU
>>>>>>    *
>>>>>> --
>>>>>> 2.39.2
>>>>>>

