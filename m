Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E825E83F1F
	for <amd-gfx@archiver.kernel.org>; Thu,  5 Feb 2026 15:06:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8C71510E904;
	Thu,  5 Feb 2026 15:06:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=ursulin.net header.i=@ursulin.net header.b="mCTdWB9e";
	dkim-atps=neutral
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com
 [209.85.218.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2688210E904
 for <amd-gfx@lists.freedesktop.org>; Thu,  5 Feb 2026 15:06:23 +0000 (UTC)
Received: by mail-ej1-f41.google.com with SMTP id
 a640c23a62f3a-b884ad1026cso176278466b.2
 for <amd-gfx@lists.freedesktop.org>; Thu, 05 Feb 2026 07:06:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ursulin.net; s=google; t=1770303981; x=1770908781; darn=lists.freedesktop.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=mULlMx/LJtD97sMRHi+FQe8SLvRqqDvAezpG8k/3VgE=;
 b=mCTdWB9e4ij76HeLhiHqw76gUeZZTaQwwo86uhe5dZZFVjiq1P9p0LZbFSHd6JBwA2
 BDDnviErg+/2yn6k1cj4+VXrnZmJDqec1O0JLXW6+bblEWLJRmgIEbr2728+td+v/NIQ
 mXyaN+4nP3Q9xur9ZRO8r5tgMNgohwHjuoMxr+ed9nUWdcAWmAFzJ3cfVIT9htlYq9Yq
 394tR1u531sov2wb3S7mmBB1nHJxAx795zFN/doPd1rdMXvOWH9PxduN+PstF5pup6ox
 1fZ0xDjJ8E7yMv5tXpsRa1hT06EFNmNTKhrZanyLLobiGR/JnSZJOfjBaSSErv/MMQ8B
 r1/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770303981; x=1770908781;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=mULlMx/LJtD97sMRHi+FQe8SLvRqqDvAezpG8k/3VgE=;
 b=qKM8xLnoZIbLM9op+/8HLvLQpHuQz3KyDbPcRceXbB59bUQDDQHHJTKFrBhhIvyUOe
 kkRKAh9gYMDdXlerPxgeqLd3E8Crq4t6tSqBP3bpKndK+ViAKBUK0MnKLfMXxh5GNkPV
 X4lvgIuJVLHs9FB0rujHhqECHM9oXFLrmC3g7b0O/nz1z4YkfIgeY38CT4tGJEbd3wJ7
 MEepooXtoEj7QZp2/TXGXsTe9xn8BFsKwmTUDGHib/y6013sHdKllr7QXDzP7+RWyOl7
 nfEuCcBryKwnAydoobX70ARFpi39MphExWf2o0ySprXBTDiOrR+xfBKlyAI2qNSuaZV9
 0r3w==
X-Gm-Message-State: AOJu0YxnLK66Sa+UMjMDCD9DCpmZnqpVdqmq4/dqo6OSug8rKfOMmXEg
 OT7hTq/s6YXSfXrEfxNFWt3b/JlQHJtW7jflqGqxuZM+eelMn1FtQwa3+J6+6K8pfUU=
X-Gm-Gg: AZuq6aKig9576i635lYaztUAgmF941/zt+OIBBH1gRMzCudc/fDCzp1Q8MQUhO9sMxY
 oqPQM9DnR0dZFBySrg7LYk+aB7v2XM9cksegJ6VVLv3aVqy/O06/I+3R0tq3U3AT/kg4SfqW2ys
 ZKPzIiUaS4D9ty8WW9Lb3aa2eDruP3dRBJE1XVWXrRn4A/cerwSgU06rR+A768SyaIJlTW/L+ea
 lx2ATfcokrBcyLhApEQ6l09vJi7sEocuzHaHnmfD+Cca2sa5/MzSIbNzZEFbIoMS5yD5eLBxbns
 13cPQY/k5+4JlKvWzDlD7OYbnMCeDbsOy3rBiraZIXi43WkE2o32UwV+YkFEBJ0i+087BStTz7c
 lZ1T0jAtiu1TeZ7IQXgb+JQAyy+05F5B8WqFu9djW5d/2wyX4rT/NKniia4FwRY/J9dyogVWKgX
 sSfwAzon3EMQcnlwO9rG5qyo0ig2tOv9W+
X-Received: by 2002:a17:907:d0c:b0:b87:1fe8:9534 with SMTP id
 a640c23a62f3a-b8e9f2d8f49mr512448166b.48.1770303980706; 
 Thu, 05 Feb 2026 07:06:20 -0800 (PST)
Received: from [192.168.0.101] ([90.240.106.137])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b8e9fd08b42sm231231366b.16.2026.02.05.07.06.19
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 05 Feb 2026 07:06:20 -0800 (PST)
Message-ID: <3f896113-1374-454c-b140-dd6deb3045df@ursulin.net>
Date: Thu, 5 Feb 2026 15:06:19 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] drm/gem: Make drm_gem_objects_lookup() self-cleaning
 on failure
To: "SHANMUGAM, SRINIVASAN" <SRINIVASAN.SHANMUGAM@amd.com>,
 "Koenig, Christian" <Christian.Koenig@amd.com>,
 "Deucher, Alexander" <Alexander.Deucher@amd.com>
Cc: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
References: <20260205121307.285864-1-srinivasan.shanmugam@amd.com>
 <c6744661-1e2b-4e28-9418-6e10acf8e367@ursulin.net>
 <IA0PR12MB82082717FF7C510104C7BAEE9099A@IA0PR12MB8208.namprd12.prod.outlook.com>
Content-Language: en-GB
From: Tvrtko Ursulin <tursulin@ursulin.net>
In-Reply-To: <IA0PR12MB82082717FF7C510104C7BAEE9099A@IA0PR12MB8208.namprd12.prod.outlook.com>
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


On 05/02/2026 14:01, SHANMUGAM, SRINIVASAN wrote:
> [AMD Official Use Only - AMD Internal Distribution Only]
> 
>> -----Original Message-----
>> From: Tvrtko Ursulin <tursulin@ursulin.net>
>> Sent: Thursday, February 5, 2026 6:33 PM
>> To: SHANMUGAM, SRINIVASAN <SRINIVASAN.SHANMUGAM@amd.com>;
>> Koenig, Christian <Christian.Koenig@amd.com>; Deucher, Alexander
>> <Alexander.Deucher@amd.com>
>> Cc: amd-gfx@lists.freedesktop.org
>> Subject: Re: [PATCH v2] drm/gem: Make drm_gem_objects_lookup() self-cleaning
>> on failure
>>
>>
>> On 05/02/2026 12:13, Srinivasan Shanmugam wrote:
>>> drm_gem_objects_lookup() can allocate the output array and take
>>> references on GEM objects before it fails.
>>>
>>> If an error happens part-way through, callers previously had to clean
>>> up partially created results themselves. This relied on subtle and
>>> undocumented behavior and was easy to get wrong.
>>>
>>> Make drm_gem_objects_lookup() clean up on failure. The function now
>>> drops any references it already took, frees the array, and sets
>>> *objs_out to NULL before returning an error.
>>>
>>> On success, behavior is unchanged. Existing callers remain correct and
>>> their error cleanup paths simply do nothing when *objs_out is NULL.
>>>
>>> Cc: Alex Deucher <alexander.deucher@amd.com>
>>> Suggested-by: Christian König <christian.koenig@amd.com>
>>> Suggested-by: Tvrtko Ursulin <tursulin@ursulin.net>
>>> Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
>>> ---
>>>    drivers/gpu/drm/drm_gem.c | 33 ++++++++++++++++++++++-----------
>>>    1 file changed, 22 insertions(+), 11 deletions(-)
>>>
>>> diff --git a/drivers/gpu/drm/drm_gem.c b/drivers/gpu/drm/drm_gem.c
>>> index a1a9c828938b..862c9b2b9c0c 100644
>>> --- a/drivers/gpu/drm/drm_gem.c
>>> +++ b/drivers/gpu/drm/drm_gem.c
>>> @@ -775,19 +775,21 @@ static int objects_lookup(struct drm_file *filp, u32
>> *handle, int count,
>>>     * For a single handle lookup, use drm_gem_object_lookup().
>>>     *
>>>     * Returns:
>>> - * @objs filled in with GEM object pointers. Returned GEM objects
>>> need to be
>>> - * released with drm_gem_object_put(). -ENOENT is returned on a
>>> lookup
>>> - * failure. 0 is returned on success.
>>> + * On success, *@objs_out is set to an allocated array of @count
>>> + pointers
>>> + * containing GEM objects. The caller must drop the references with
>>> + * drm_gem_object_put() and free the array with kvfree().
>>>     *
>>> + * On failure, *@objs_out is set to NULL and no further action is required.
>>>     */
>>>    int drm_gem_objects_lookup(struct drm_file *filp, void __user *bo_handles,
>>>                         int count, struct drm_gem_object ***objs_out)
>>>    {
>>>      struct drm_device *dev = filp->minor->dev;
>>>      struct drm_gem_object **objs;
>>> -   u32 *handles;
>>> -   int ret;
>>> +   u32 *handles = NULL;
>>> +   int ret, i;
>>>
>>> +   *objs_out = NULL;
>>>      if (!count)
>>>              return 0;
>>>
>>> @@ -796,25 +798,34 @@ int drm_gem_objects_lookup(struct drm_file *filp, void
>> __user *bo_handles,
>>>      if (!objs)
>>>              return -ENOMEM;
>>>
>>> -   *objs_out = objs;
>>> -
>>>      handles = kvmalloc_array(count, sizeof(u32), GFP_KERNEL);
>>>      if (!handles) {
>>>              ret = -ENOMEM;
>>> -           goto out;
>>> +           goto err_put_free;
>>>      }
>>>
>>>      if (copy_from_user(handles, bo_handles, count * sizeof(u32))) {
>>>              ret = -EFAULT;
>>>              drm_dbg_core(dev, "Failed to copy in GEM handles\n");
>>
>> I think this patch is possibly against the AMD staging branch?
> 
> Yes.
> 
> You will either need to
>> rebase on top of drm-tip, or AMD staging needs to catch up with 6.19-rc1. Because
>> in there I have replaced the above with vmemdup_array_user().
>>
>> Otherwise I agree with what Christian said, that it would be nice to get rid of the
>> __GFP_ZERO requirement and handle it in objects_lookup().
> 
> I have proposed v3, based on this , will check with Alex or Christian regarding the rebasing part
> 
>>
>> In the meantime I have again went through all the callers and it seems they will all
>> handle not having to do the cleanup just fine.
>>
>> Hm, another interesting question if we maybe want to add a cleanup helper so the
>> callers do not have to know that they have to use kvfree?
>> All of them have their own loops so that would also nicely consolidate.
> 
> 
> To keep this change focused, I suggest we first land the self-cleaning behavior and then take up the helper as a separate follow-up patch. I’m happy to align this with Christian’s preference as well.

Follow up is absolutely fine.

Btw, add dri-devel to the cc for next respin.

Regards,

Tvrtko

