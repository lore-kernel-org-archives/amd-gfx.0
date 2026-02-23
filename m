Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34183E98E03
	for <amd-gfx@archiver.kernel.org>; Mon, 23 Feb 2026 08:11:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CAEBF10E262;
	Mon, 23 Feb 2026 08:11:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=ursulin.net header.i=@ursulin.net header.b="a/0T60Ye";
	dkim-atps=neutral
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com
 [209.85.128.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BB49010E262
 for <amd-gfx@lists.freedesktop.org>; Mon, 23 Feb 2026 08:11:49 +0000 (UTC)
Received: by mail-wm1-f44.google.com with SMTP id
 5b1f17b1804b1-4836f363ad2so44816565e9.1
 for <amd-gfx@lists.freedesktop.org>; Mon, 23 Feb 2026 00:11:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ursulin.net; s=google; t=1771834308; x=1772439108; darn=lists.freedesktop.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=hMEzxkF1ttE6VLnaWAMdGUcep4RAmxvkhlWIw2DCQTU=;
 b=a/0T60YeKoUBn9mqGs4Z3xs6ha2QyZsNk/VD714ITRt2BPOgXzT6DU0mJ3SE+t7rWE
 e1L3Lxu3/zoWYE0fhv4raC+UuV5rC7SKRuniOMaFdv1D8iec3H6F3sx7b8hPviyBvItY
 Y4LeyYZrukPmNFw6gVJuYlCL4KWNsaDeBsoDhH9ZnkGbgW6F5KgHWI7l1AuvTERYXk1W
 r4hmW+2vcitSmCNLc4l6mKBaYRdQL9TVy7IdQxJJX10dIeQ8p92u2xp2UuTX6XKpWnaX
 qR7s+2DHO92PqC0vhAjMA2FR+efevPLQzB5LnVdbXODGNllnjsAwzJqpXZFHeiQzHnvn
 6vdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771834308; x=1772439108;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=hMEzxkF1ttE6VLnaWAMdGUcep4RAmxvkhlWIw2DCQTU=;
 b=ahkkOPCj2o8O/4FnWy06Lsn7U0st5JgKeJ0tCsK0uwKYLp5ld33e31qH3UGzWU+YLf
 AnPgnqfwrrusykHCYc8NKZqRXRT1zqaLI+o1IF/EZxeI7aWVHcIeK6VVQuECfryEsUz6
 Eu3CYbfMDNeWEG4cHyZbvyB6EPTovFJ554mT0bEuu0Sh4/V6VRu+uky1AB/CNLEN16g3
 Gas3/twCvybgrbO7Fv0CsMUzSisY3x52Lq4iZItwdmExDZVj8dsEtIhViuMk+mfv6dm8
 zMPJ2uTXC30gXRgeX47wz/lBotEMIrtXVaVez7pQD9ace4iUjDUsscBROVI62uWlvbHf
 3kHw==
X-Gm-Message-State: AOJu0YyYwL5I8aGEpCoZK7cCq51x6hQktWlDZj7EQDEST6iS4fg1Qy+b
 5NHJiVYxG3isorCPZ8pT+hHV64bLNmp2w3P9X59PIn6saIu4hPnko1LvwAEcb9uGawY=
X-Gm-Gg: AZuq6aJ+tbPCX2FpS22qOLbmQDEN1WmLq84b7hsDe13TmlBn9eh1PuvIqPwlMbnAVkP
 CWgg/TMu/L8Y3hQledIgDQsYyKqrEXDnenHFEmmOzKjDFCUkyhZ3Jgqn6YHTu2LAygL4fFjMWzQ
 XGBcc1PUXIGWeg6BkbC10BGHqtTNsEK+KwbzoawCI2x4jAnvQSuqqlQlpoG5QR56ff8rjvK8mOj
 30J9gYJHNJprmq+QwniwP26DtgMK/iIF3JE88mVTKVhWwzpohxZNv+PA8pG7nPrlweJNu+1r5we
 7fvNRIoguWNkfSek8MaB+mSbs+yW0SpfpBPKm/9g9WUIuNfiuFa/c716+7mDWaxKPKIkXJ6jPne
 P/6KXp8cgehMZ76VXN8NsjakWgaC0Fn8qNrp5RCkW77nyeui17f/E30NqLgoY4u1vGGISwYotAd
 w//7UYgIsQLJTT3DVGL1CaAlwWAi6lYeuhCIPDR6TnsQRg
X-Received: by 2002:a05:600c:4f8a:b0:480:1d0b:2d32 with SMTP id
 5b1f17b1804b1-483a95beb5bmr136171015e9.12.1771834307556; 
 Mon, 23 Feb 2026 00:11:47 -0800 (PST)
Received: from [192.168.0.101] ([90.240.106.137])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-483a31f0370sm433111165e9.11.2026.02.23.00.11.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 23 Feb 2026 00:11:47 -0800 (PST)
Message-ID: <b05a405a-c9a3-4276-85df-daf223fd2a7b@ursulin.net>
Date: Mon, 23 Feb 2026 08:11:46 +0000
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
Content-Language: en-GB
From: Tvrtko Ursulin <tursulin@ursulin.net>
In-Reply-To: <3c4c8c6c-5bcd-426a-bd39-fb24db8fc5f5@amd.com>
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



On 23/02/2026 04:31, Khatri, Sunil wrote:
> Applied the changes @Tvrtko Ursulin <tursulin@ursulin.net>

Thank you! I am glad they still applied!

Also, you were suggesting in your last week's reply to "Please make sure 
the changes are made for all memdup_user". There are also patches in 
that series which convert to drm_gem_objects_lookup() which remove some 
more, but, for those I think I need to check if they need tweaking after
dbce431756f8 ("drm/gem: Make drm_gem_objects_lookup() self-cleaning on 
failure v6"). Maybe it just works though. I will wait until the ones you 
merge appear in some branch and check.

Regards,

Tvrtko

> On 20-02-2026 06:49 pm, Khatri, Sunil wrote:
>>
>> On 20-02-2026 04:54 pm, Tvrtko Ursulin wrote:
>>>
>>> On 20/02/2026 08:28, Sunil Khatri wrote:
>>>> memdup_user could return invalid memory allocation if
>>>> there is an integer overflow. Using memdup_array_user
>>>> make sure we validate the size requirements upfront
>>>> and return with an error.
>>>
>>> FYI:
>>>
>>> https://lore.kernel.org/amd-gfx/20251205134035.91551-1- 
>>> tvrtko.ursulin@igalia.com/
>> Are you awaiting for anything to merge the changes Tvrtko or they are 
>> merged in drm upstream already? Since issue is reported now so we need 
>> to fix this.
>>
>>>
>>> And later:
>>>
>>> https://lore.kernel.org/amd-gfx/20260202125149.2067-7- 
>>> christian.koenig@amd.com/.
>> Yeah i am aware of these Christian changes and we decided we will fix 
>> the issues first and reorganize the code later as needed along with 
>> Christian changes. So we are going to push the changes
>>
>> on the existing code base first.
>>
>> regards
>> Sunil khatri
>>
>>>
>>> Regards,
>>>
>>> Tvrtko
>>>
>>>>
>>>> Signed-off-by: Sunil Khatri <sunil.khatri@amd.com>
>>>> ---
>>>>   .../gpu/drm/amd/amdgpu/amdgpu_userq_fence.c   | 32 ++++++++ 
>>>> +----------
>>>>   1 file changed, 16 insertions(+), 16 deletions(-)
>>>>
>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c b/ 
>>>> drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
>>>> index 212056d4ddf0..a6eb703b62c4 100644
>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
>>>> @@ -480,8 +480,8 @@ int amdgpu_userq_signal_ioctl(struct drm_device 
>>>> *dev, void *data,
>>>>           return -ENOTSUPP;
>>>>         num_syncobj_handles = args->num_syncobj_handles;
>>>> -    syncobj_handles = memdup_user(u64_to_user_ptr(args- 
>>>> >syncobj_handles),
>>>> -                      size_mul(sizeof(u32), num_syncobj_handles));
>>>> +    syncobj_handles = memdup_array_user(u64_to_user_ptr(args- 
>>>> >syncobj_handles),
>>>> +                        num_syncobj_handles, sizeof(u32));
>>>>       if (IS_ERR(syncobj_handles))
>>>>           return PTR_ERR(syncobj_handles);
>>>>   @@ -501,8 +501,8 @@ int amdgpu_userq_signal_ioctl(struct 
>>>> drm_device *dev, void *data,
>>>>       }
>>>>         num_read_bo_handles = args->num_bo_read_handles;
>>>> -    bo_handles_read = memdup_user(u64_to_user_ptr(args- 
>>>> >bo_read_handles),
>>>> -                      sizeof(u32) * num_read_bo_handles);
>>>> +    bo_handles_read = memdup_array_user(u64_to_user_ptr(args- 
>>>> >bo_read_handles),
>>>> +                        num_read_bo_handles, sizeof(u32));
>>>>       if (IS_ERR(bo_handles_read)) {
>>>>           r = PTR_ERR(bo_handles_read);
>>>>           goto free_syncobj;
>>>> @@ -524,8 +524,8 @@ int amdgpu_userq_signal_ioctl(struct drm_device 
>>>> *dev, void *data,
>>>>       }
>>>>         num_write_bo_handles = args->num_bo_write_handles;
>>>> -    bo_handles_write = memdup_user(u64_to_user_ptr(args- 
>>>> >bo_write_handles),
>>>> -                       sizeof(u32) * num_write_bo_handles);
>>>> +    bo_handles_write = memdup_array_user(u64_to_user_ptr(args- 
>>>> >bo_write_handles),
>>>> +                         num_write_bo_handles, sizeof(u32));
>>>>       if (IS_ERR(bo_handles_write)) {
>>>>           r = PTR_ERR(bo_handles_write);
>>>>           goto put_gobj_read;
>>>> @@ -666,37 +666,37 @@ int amdgpu_userq_wait_ioctl(struct drm_device 
>>>> *dev, void *data,
>>>>           return -ENOTSUPP;
>>>>         num_read_bo_handles = wait_info->num_bo_read_handles;
>>>> -    bo_handles_read = memdup_user(u64_to_user_ptr(wait_info- 
>>>> >bo_read_handles),
>>>> -                      size_mul(sizeof(u32), num_read_bo_handles));
>>>> +    bo_handles_read = memdup_array_user(u64_to_user_ptr(wait_info- 
>>>> >bo_read_handles),
>>>> +                        num_read_bo_handles, sizeof(u32));
>>>>       if (IS_ERR(bo_handles_read))
>>>>           return PTR_ERR(bo_handles_read);
>>>>         num_write_bo_handles = wait_info->num_bo_write_handles;
>>>> -    bo_handles_write = memdup_user(u64_to_user_ptr(wait_info- 
>>>> >bo_write_handles),
>>>> -                       size_mul(sizeof(u32), num_write_bo_handles));
>>>> +    bo_handles_write = memdup_array_user(u64_to_user_ptr(wait_info- 
>>>> >bo_write_handles),
>>>> +                         num_write_bo_handles, sizeof(u32));
>>>>       if (IS_ERR(bo_handles_write)) {
>>>>           r = PTR_ERR(bo_handles_write);
>>>>           goto free_bo_handles_read;
>>>>       }
>>>>         num_syncobj = wait_info->num_syncobj_handles;
>>>> -    syncobj_handles = memdup_user(u64_to_user_ptr(wait_info- 
>>>> >syncobj_handles),
>>>> -                      size_mul(sizeof(u32), num_syncobj));
>>>> +    syncobj_handles = memdup_array_user(u64_to_user_ptr(wait_info- 
>>>> >syncobj_handles),
>>>> +                        num_syncobj, sizeof(u32));
>>>>       if (IS_ERR(syncobj_handles)) {
>>>>           r = PTR_ERR(syncobj_handles);
>>>>           goto free_bo_handles_write;
>>>>       }
>>>>         num_points = wait_info->num_syncobj_timeline_handles;
>>>> -    timeline_handles = memdup_user(u64_to_user_ptr(wait_info- 
>>>> >syncobj_timeline_handles),
>>>> -                       sizeof(u32) * num_points);
>>>> +    timeline_handles = memdup_array_user(u64_to_user_ptr(wait_info- 
>>>> >syncobj_timeline_handles),
>>>> +                         num_points, sizeof(u32));
>>>>       if (IS_ERR(timeline_handles)) {
>>>>           r = PTR_ERR(timeline_handles);
>>>>           goto free_syncobj_handles;
>>>>       }
>>>>   -    timeline_points = memdup_user(u64_to_user_ptr(wait_info- 
>>>> >syncobj_timeline_points),
>>>> -                      sizeof(u32) * num_points);
>>>> +    timeline_points = memdup_array_user(u64_to_user_ptr(wait_info- 
>>>> >syncobj_timeline_points),
>>>> +                        num_points, sizeof(u32));
>>>>       if (IS_ERR(timeline_points)) {
>>>>           r = PTR_ERR(timeline_points);
>>>>           goto free_timeline_handles;
>>>

