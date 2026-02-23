Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D905CEA4FB8
	for <amd-gfx@archiver.kernel.org>; Mon, 23 Feb 2026 12:43:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 79FA710E394;
	Mon, 23 Feb 2026 12:43:11 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=ursulin.net header.i=@ursulin.net header.b="nVQwlixA";
	dkim-atps=neutral
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com
 [209.85.128.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3881D10E394
 for <amd-gfx@lists.freedesktop.org>; Mon, 23 Feb 2026 12:43:10 +0000 (UTC)
Received: by mail-wm1-f42.google.com with SMTP id
 5b1f17b1804b1-48334ee0aeaso31359055e9.1
 for <amd-gfx@lists.freedesktop.org>; Mon, 23 Feb 2026 04:43:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ursulin.net; s=google; t=1771850589; x=1772455389; darn=lists.freedesktop.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=wSZ2emFEDth/ck+X6y3tAISHxFvQl33GEIxQtOSISJ4=;
 b=nVQwlixAPfxcUBc90pi8rHbgHSYmGkswjWhw8583+ysRmewr/5IFEN38wTFYETmw+e
 mEAWjEgH1L14zo7FyHrRizR5pf5CN9PhPBgVS1eingOhwjmClSWV+Acu5WDplpPS1Q2i
 OPZcira0DGGqt0eI80LMayEr/HZxpUMRimfEyym6k6/MROoM77Hgy5gUKizhLVlXtN2J
 ZmPodKELiNMbBN51abYcepw0u/fXpJPWhUe5+6T8a1g38m/3YMqNPcTliQh8vthw1yLc
 zYX+bSUChXepEQFrljURtW2WETYVNG6EvkcUgSvCma8gtV8Cjk+IK2QTDZZRFY3JHLB7
 Ca1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771850589; x=1772455389;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=wSZ2emFEDth/ck+X6y3tAISHxFvQl33GEIxQtOSISJ4=;
 b=fSy3tj+FUwe+gvFMS2OmJ2WugdNMk+M8y43OkJH4DAbDJTs2+NycUSOkxtJu1Yz36f
 MjHGmrgKXGjoqnGeyc7fDAvZlKHOuC5TaoKZYSNX+81PVZZGqEIpY51stCx20bq3pSat
 KztKx1s3UAg+8C8woFM6YM4WBJ53eXzhRRErm+bVnlcvOm7USzYNxeLwR24EZZpi3any
 W3jcmxntAa+7ejrVezCKPREM5yOstPO8DABkNsc80TBvBjn9a9J1LBUBS0MBcqUgkqTb
 gcJsayKrLJ9mV85S+o3xlml01q2N/RHSE+kvlA0dFN3Cemc+LhmBf2cVmO4Mjdp+fyxy
 x3tg==
X-Gm-Message-State: AOJu0YwGRbXN3XedbmFrZ4U+5KhOq8daPSG8KLOUwdEhgQdv7jsiUw/m
 5JJ12WHndJ06gY4gmpzKedjgr3GgK/H77eNmle+dpgOzP4ibynJKL0wQLhQizdcWfqc=
X-Gm-Gg: AZuq6aI0QsirbxIyZcjTg0jrkwoITs+05p8ztRfhUbVp7Om8PbmXT7ZuNBF1oX8U/Ai
 8Gp9nED02R7uN5suJHnsNT0ebTLzMdbWpuQ4OSiM5cBDS1+1CJwATeWtrxL6Xl9P3Yn043DbIl1
 vNP1otncpI7hePwi80CDGp5tkFRdVnZkC9hwC4USCXaYUGHeJcqxuEq5g39M+FS/28y4YSnauYd
 piX01ZN+AFKYwOSFKj2jB0IWEHoenN5+qYd5caSUJAy1VrYBXs4TCLM0k421q6ACF8d07avr62G
 rnc6wo02fNdCjo9/+tBOzgl3fErPkOJEbKfCWR/XgUKamB9o26nWOoTi3WhhYZnsJ8oetII+Xex
 72kKDpLCRfiEbrCBxwWE67uoAPzXfP2WWfaVXIBkUuSdg/SmhTh8o9d8kFFm/8FoEZlccpG9Sbv
 24b2ontwLh3/ipdQ4f/gaUh1YIfQYMD/BfJb1hhBwZ55R2
X-Received: by 2002:a05:600c:8b02:b0:477:7ab8:aba with SMTP id
 5b1f17b1804b1-483a95aa31dmr135430355e9.1.1771850588390; 
 Mon, 23 Feb 2026 04:43:08 -0800 (PST)
Received: from [192.168.0.101] ([90.240.106.137])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-483a9b75b4dsm302896075e9.4.2026.02.23.04.43.07
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 23 Feb 2026 04:43:08 -0800 (PST)
Message-ID: <1efa1b99-3a9d-4469-8723-9b064a5de393@ursulin.net>
Date: Mon, 23 Feb 2026 12:43:07 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/2] drm/amdgpu: update memdup_user with
 memdup_array_user
To: "Khatri, Sunil" <sukhatri@amd.com>, Sunil Khatri <sunil.khatri@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Cc: amd-gfx@lists.freedesktop.org
References: <20260220082840.2192325-1-sunil.khatri@amd.com>
 <3c7f24f3-d1f7-4724-bf2e-8540fa2e2648@ursulin.net>
 <4a824f5e-5279-4cb7-b6a9-fb4c6f87cd91@amd.com>
 <3c4c8c6c-5bcd-426a-bd39-fb24db8fc5f5@amd.com>
 <b05a405a-c9a3-4276-85df-daf223fd2a7b@ursulin.net>
 <a55ecb91-8aa2-41c5-bd76-b3ffa7d6c23c@amd.com>
 <cf512004-18ae-44e1-bc4f-63bb279a40dc@ursulin.net>
 <9ac4a721-64df-44c3-af17-77dd88988bd6@amd.com>
Content-Language: en-GB
From: Tvrtko Ursulin <tursulin@ursulin.net>
In-Reply-To: <9ac4a721-64df-44c3-af17-77dd88988bd6@amd.com>
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


On 23/02/2026 10:36, Khatri, Sunil wrote:
> 
> On 23-02-2026 03:26 pm, Tvrtko Ursulin wrote:
>>
>> On 23/02/2026 08:21, Khatri, Sunil wrote:
>>>
>>> On 23-02-2026 01:41 pm, Tvrtko Ursulin wrote:
>>>>
>>>>
>>>> On 23/02/2026 04:31, Khatri, Sunil wrote:
>>>>> Applied the changes @Tvrtko Ursulin <tursulin@ursulin.net>
>>>>
>>>> Thank you! I am glad they still applied!
>>>>
>>>> Also, you were suggesting in your last week's reply to "Please make 
>>>> sure the changes are made for all memdup_user". There are also 
>>>> patches in that series which convert to drm_gem_objects_lookup() 
>>>> which remove some more, but, for those I think I need to check if 
>>>> they need tweaking after
>>>> dbce431756f8 ("drm/gem: Make drm_gem_objects_lookup() self-cleaning 
>>>> on failure v6"). Maybe it just works though. I will wait until the 
>>>> ones you merge appear in some branch and check.
>>>
>>> I am in process to merge only two changes patch no 6 and 7 in the 
>>> series. There were conflicts but i fixed those but still there are 
>>> some more memdup_user which i will fix with a patch which are left 
>>> after these 2 patches gets merged.
>>
>> The before mentioned object lookup and syncpoint lookup. For the 
>> latter I also had cleanup back in December but did not send it:
>>
>> commit ddb4985391907155a9cf5ef6f5262c1cc8f334c6
>> Author: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
>> Date:   Thu Dec 4 13:56:56 2025 +0000
>>
>>     use syncobj lookup helper in amdgpu_userq_signal_ioctl
>>
>>     Signed-off-by: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
>>
>> commit b21686063a5858833a09bb8f84cfbae2376f0c18
>> Author: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
>> Date:   Thu Dec 4 13:36:15 2025 +0000
>>
>>     export sync obj lookup helper
>>
>>     Signed-off-by: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
>>
>> Those two I was planning to send together with some more syncobj patches:
>>
>> 27cf1f1dabfc drm/syncobj: Add a fast path to drm_syncobj_array_find
>> e7efbf50342b drm/syncobj: Add a fast path to 
>> drm_syncobj_array_wait_timeout
>> 363279cd8eb4 drm/syncobj: Use vmemdup_array_user in 
>> drm_syncobj_array_find
>>
>> Which are interesting for graphics since four stack fast path slots 
>> avoid 99% of temporary allocations. Not sure for user queues how many 
>> sync points are typical.
>>
>>> Also if you want to take that up its ok with me. Let me know.
>>
>> ¯\_(ツ)_/¯
>>
>> Not sure if you want to re-do it because what I sent has a flaw 
>> somewhere or something else?
> i do not want to redo it for sure :) , could you send the patches for 
> review if you havent yet and add me in CC. Also i am here focusing on 
> fixing the the left over place for the same function.
> 
> Example below, these changes are still left even after your two changes 
> that i pushed. So i am assuming the patches you mentioned have these 
> changes accomodated this way or some other. Please send them for review.

Got it, thanks! I've sent the rebased series. You can pick and choose 
from it but please also test the userq part since I only tested the 
standard submission path.

Regards,

Tvrtko

> 
> 
> +       bo_handles_read = memdup_array_user(u64_to_user_ptr(args- 
>  >bo_read_handles),
> +                                           num_read_bo_handles, 
> sizeof(u32));
>          if (IS_ERR(bo_handles_read)) {
>                  r = PTR_ERR(bo_handles_read);
>                  goto free_syncobj;
> @@ -524,8 +524,8 @@ int amdgpu_userq_signal_ioctl(struct drm_device 
> *dev, void *data,
>          }
> 
>          num_write_bo_handles = args->num_bo_write_handles;
> -       bo_handles_write = memdup_user(u64_to_user_ptr(args- 
>  >bo_write_handles),
> -                                      sizeof(u32) * num_write_bo_handles);
> +       bo_handles_write = memdup_array_user(u64_to_user_ptr(args- 
>  >bo_write_handles),
> +                                            num_write_bo_handles, 
> sizeof(u32));
>          if (IS_ERR(bo_handles_write)) {
>                  r = PTR_ERR(bo_handles_write);
>                  goto put_gobj_read;
> @@ -666,14 +666,15 @@ int amdgpu_userq_wait_ioctl(struct drm_device 
> *dev, void *data,
>                  return -ENOTSUPP;
> 
>          num_read_bo_handles = wait_info->num_bo_read_handles;
> -       bo_handles_read = memdup_user(u64_to_user_ptr(wait_info- 
>  >bo_read_handles),
> -                                     size_mul(sizeof(u32), 
> num_read_bo_handles));
> +       bo_handles_read = memdup_array_user(u64_to_user_ptr(wait_info- 
>  >bo_read_handles),
> +                                           num_read_bo_handles, 
> sizeof(u32));
> +
>          if (IS_ERR(bo_handles_read))
>                  return PTR_ERR(bo_handles_read);
> 
>          num_write_bo_handles = wait_info->num_bo_write_handles;
> -       bo_handles_write = memdup_user(u64_to_user_ptr(wait_info- 
>  >bo_write_handles),
> -                                      size_mul(sizeof(u32), 
> num_write_bo_handles));
> +       bo_handles_write = memdup_array_user(u64_to_user_ptr(wait_info- 
>  >bo_write_handles),
> +                                            num_write_bo_handles, 
> sizeof(u32));
> 
> 
> Regards
> Sunil khatri
> 
>>
>> Regards,
>>
>> Tvrtko
>>
>>>>> On 20-02-2026 06:49 pm, Khatri, Sunil wrote:
>>>>>>
>>>>>> On 20-02-2026 04:54 pm, Tvrtko Ursulin wrote:
>>>>>>>
>>>>>>> On 20/02/2026 08:28, Sunil Khatri wrote:
>>>>>>>> memdup_user could return invalid memory allocation if
>>>>>>>> there is an integer overflow. Using memdup_array_user
>>>>>>>> make sure we validate the size requirements upfront
>>>>>>>> and return with an error.
>>>>>>>
>>>>>>> FYI:
>>>>>>>
>>>>>>> https://lore.kernel.org/amd-gfx/20251205134035.91551-1- 
>>>>>>> tvrtko.ursulin@igalia.com/
>>>>>> Are you awaiting for anything to merge the changes Tvrtko or they 
>>>>>> are merged in drm upstream already? Since issue is reported now so 
>>>>>> we need to fix this.
>>>>>>
>>>>>>>
>>>>>>> And later:
>>>>>>>
>>>>>>> https://lore.kernel.org/amd-gfx/20260202125149.2067-7- 
>>>>>>> christian.koenig@amd.com/.
>>>>>> Yeah i am aware of these Christian changes and we decided we will 
>>>>>> fix the issues first and reorganize the code later as needed along 
>>>>>> with Christian changes. So we are going to push the changes
>>>>>>
>>>>>> on the existing code base first.
>>>>>>
>>>>>> regards
>>>>>> Sunil khatri
>>>>>>
>>>>>>>
>>>>>>> Regards,
>>>>>>>
>>>>>>> Tvrtko
>>>>>>>
>>>>>>>>
>>>>>>>> Signed-off-by: Sunil Khatri <sunil.khatri@amd.com>
>>>>>>>> ---
>>>>>>>>   .../gpu/drm/amd/amdgpu/amdgpu_userq_fence.c   | 32 ++++++++ 
>>>>>>>> +----------
>>>>>>>>   1 file changed, 16 insertions(+), 16 deletions(-)
>>>>>>>>
>>>>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c b/ 
>>>>>>>> drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
>>>>>>>> index 212056d4ddf0..a6eb703b62c4 100644
>>>>>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
>>>>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
>>>>>>>> @@ -480,8 +480,8 @@ int amdgpu_userq_signal_ioctl(struct 
>>>>>>>> drm_device *dev, void *data,
>>>>>>>>           return -ENOTSUPP;
>>>>>>>>         num_syncobj_handles = args->num_syncobj_handles;
>>>>>>>> -    syncobj_handles = memdup_user(u64_to_user_ptr(args- 
>>>>>>>> >syncobj_handles),
>>>>>>>> -                      size_mul(sizeof(u32), num_syncobj_handles));
>>>>>>>> +    syncobj_handles = memdup_array_user(u64_to_user_ptr(args- 
>>>>>>>> >syncobj_handles),
>>>>>>>> +                        num_syncobj_handles, sizeof(u32));
>>>>>>>>       if (IS_ERR(syncobj_handles))
>>>>>>>>           return PTR_ERR(syncobj_handles);
>>>>>>>>   @@ -501,8 +501,8 @@ int amdgpu_userq_signal_ioctl(struct 
>>>>>>>> drm_device *dev, void *data,
>>>>>>>>       }
>>>>>>>>         num_read_bo_handles = args->num_bo_read_handles;
>>>>>>>> -    bo_handles_read = memdup_user(u64_to_user_ptr(args- 
>>>>>>>> >bo_read_handles),
>>>>>>>> -                      sizeof(u32) * num_read_bo_handles);
>>>>>>>> +    bo_handles_read = memdup_array_user(u64_to_user_ptr(args- 
>>>>>>>> >bo_read_handles),
>>>>>>>> +                        num_read_bo_handles, sizeof(u32));
>>>>>>>>       if (IS_ERR(bo_handles_read)) {
>>>>>>>>           r = PTR_ERR(bo_handles_read);
>>>>>>>>           goto free_syncobj;
>>>>>>>> @@ -524,8 +524,8 @@ int amdgpu_userq_signal_ioctl(struct 
>>>>>>>> drm_device *dev, void *data,
>>>>>>>>       }
>>>>>>>>         num_write_bo_handles = args->num_bo_write_handles;
>>>>>>>> -    bo_handles_write = memdup_user(u64_to_user_ptr(args- 
>>>>>>>> >bo_write_handles),
>>>>>>>> -                       sizeof(u32) * num_write_bo_handles);
>>>>>>>> +    bo_handles_write = memdup_array_user(u64_to_user_ptr(args- 
>>>>>>>> >bo_write_handles),
>>>>>>>> +                         num_write_bo_handles, sizeof(u32));
>>>>>>>>       if (IS_ERR(bo_handles_write)) {
>>>>>>>>           r = PTR_ERR(bo_handles_write);
>>>>>>>>           goto put_gobj_read;
>>>>>>>> @@ -666,37 +666,37 @@ int amdgpu_userq_wait_ioctl(struct 
>>>>>>>> drm_device *dev, void *data,
>>>>>>>>           return -ENOTSUPP;
>>>>>>>>         num_read_bo_handles = wait_info->num_bo_read_handles;
>>>>>>>> -    bo_handles_read = memdup_user(u64_to_user_ptr(wait_info- 
>>>>>>>> >bo_read_handles),
>>>>>>>> -                      size_mul(sizeof(u32), num_read_bo_handles));
>>>>>>>> +    bo_handles_read = 
>>>>>>>> memdup_array_user(u64_to_user_ptr(wait_info- >bo_read_handles),
>>>>>>>> +                        num_read_bo_handles, sizeof(u32));
>>>>>>>>       if (IS_ERR(bo_handles_read))
>>>>>>>>           return PTR_ERR(bo_handles_read);
>>>>>>>>         num_write_bo_handles = wait_info->num_bo_write_handles;
>>>>>>>> -    bo_handles_write = memdup_user(u64_to_user_ptr(wait_info- 
>>>>>>>> >bo_write_handles),
>>>>>>>> -                       size_mul(sizeof(u32), 
>>>>>>>> num_write_bo_handles));
>>>>>>>> +    bo_handles_write = 
>>>>>>>> memdup_array_user(u64_to_user_ptr(wait_info- >bo_write_handles),
>>>>>>>> +                         num_write_bo_handles, sizeof(u32));
>>>>>>>>       if (IS_ERR(bo_handles_write)) {
>>>>>>>>           r = PTR_ERR(bo_handles_write);
>>>>>>>>           goto free_bo_handles_read;
>>>>>>>>       }
>>>>>>>>         num_syncobj = wait_info->num_syncobj_handles;
>>>>>>>> -    syncobj_handles = memdup_user(u64_to_user_ptr(wait_info- 
>>>>>>>> >syncobj_handles),
>>>>>>>> -                      size_mul(sizeof(u32), num_syncobj));
>>>>>>>> +    syncobj_handles = 
>>>>>>>> memdup_array_user(u64_to_user_ptr(wait_info- >syncobj_handles),
>>>>>>>> +                        num_syncobj, sizeof(u32));
>>>>>>>>       if (IS_ERR(syncobj_handles)) {
>>>>>>>>           r = PTR_ERR(syncobj_handles);
>>>>>>>>           goto free_bo_handles_write;
>>>>>>>>       }
>>>>>>>>         num_points = wait_info->num_syncobj_timeline_handles;
>>>>>>>> -    timeline_handles = memdup_user(u64_to_user_ptr(wait_info- 
>>>>>>>> >syncobj_timeline_handles),
>>>>>>>> -                       sizeof(u32) * num_points);
>>>>>>>> +    timeline_handles = 
>>>>>>>> memdup_array_user(u64_to_user_ptr(wait_info- 
>>>>>>>> >syncobj_timeline_handles),
>>>>>>>> +                         num_points, sizeof(u32));
>>>>>>>>       if (IS_ERR(timeline_handles)) {
>>>>>>>>           r = PTR_ERR(timeline_handles);
>>>>>>>>           goto free_syncobj_handles;
>>>>>>>>       }
>>>>>>>>   -    timeline_points = memdup_user(u64_to_user_ptr(wait_info- 
>>>>>>>> >syncobj_timeline_points),
>>>>>>>> -                      sizeof(u32) * num_points);
>>>>>>>> +    timeline_points = 
>>>>>>>> memdup_array_user(u64_to_user_ptr(wait_info- 
>>>>>>>> >syncobj_timeline_points),
>>>>>>>> +                        num_points, sizeof(u32));
>>>>>>>>       if (IS_ERR(timeline_points)) {
>>>>>>>>           r = PTR_ERR(timeline_points);
>>>>>>>>           goto free_timeline_handles;
>>>>>>>
>>>>
>>

