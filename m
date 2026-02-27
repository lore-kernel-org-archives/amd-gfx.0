Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38B6AFD5323
	for <amd-gfx@archiver.kernel.org>; Fri, 27 Feb 2026 09:57:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CD7B510E00A;
	Fri, 27 Feb 2026 09:56:59 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=ursulin.net header.i=@ursulin.net header.b="yc4TG7JY";
	dkim-atps=neutral
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com
 [209.85.221.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 548CF10E00A
 for <amd-gfx@lists.freedesktop.org>; Fri, 27 Feb 2026 09:56:59 +0000 (UTC)
Received: by mail-wr1-f47.google.com with SMTP id
 ffacd0b85a97d-436356740e6so1924183f8f.2
 for <amd-gfx@lists.freedesktop.org>; Fri, 27 Feb 2026 01:56:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ursulin.net; s=google; t=1772186218; x=1772791018; darn=lists.freedesktop.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=P1owIES4EQmJWqpdxfHXy9N3p2hS/4QC1KWPKhpKzp4=;
 b=yc4TG7JYDbV/5ObeTgrYVGm6w/20gvbN2+vpQnnD0HuzaNmstC9b7Yd+XOQXcYqdfB
 mUDskkKlBJv0KsSkAuHL9H30kppPGELP3gGJLXz1+8Rf8kjvsMiqQDcQ3bAdD7VuOw6f
 yh2wI79DgXR5PM15VR/P1STWESYY04ZbN7X45Du9J0ospxKjvViIT4H7bTUu+DzR9KhS
 Udds4Zz6HMpqABgT/hJu/si3M5gCxhUj5q4RXyKXm+OJOSgl2mJpwcFokebosTA7RgbK
 +Ub4etDK9YYsRcS+hAHe034hAqLmAsttSZnE+jZyN0zLE3AHR1cYFhEqNbgEcdnrwVhD
 WtbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772186218; x=1772791018;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=P1owIES4EQmJWqpdxfHXy9N3p2hS/4QC1KWPKhpKzp4=;
 b=ar6ZS5lx3a6755+gxdAgXXy8SmPHUn4VyCGuReWmArtOylkCXMP63ITkCJzeS5Xfcx
 bMjRqBkBPzK9RCE6r41AtOYE7ret9RzySNqhZ4Vd7nSHiO6wVdTNiinVbJrkPkqGC1AK
 cTzX2kIejuy97DrVX6OkQF47gPx24cKGWg03DT+kg4tkalKq+eVdxQIJjI5i6rFatbzX
 fTHkSgZl28NVD3RcBulWfMRpHIl1IEPyVjm8gcO/s6uXAt8W8z45gtE197O5P+yhe+10
 d04RV+nDrj1SrV3sphj5OL4ife5AjQDguOY/F5nStzPVmdyYVRvoP1FohvtL7s9uXJ/a
 ELww==
X-Forwarded-Encrypted: i=1;
 AJvYcCWW2JJDbDXbtopWmUyMx7QmGh+bL1ICD0i+VuICw3nL46FMiikZSFWJDNsLaQhfOgf15iEA4SS5@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwCVYR+a3l14SZTUpcIZAoeKivj6e5Vwl/cnmYO0+n9BUL9tMAO
 9NjG4bNLG0zT83xqhTtO2y9LqDGRkAmYH/gV25aNlKCwF/nAn7h4qW3rJNmxC+AhYblEXWw+j01
 2EQvKhTQ=
X-Gm-Gg: ATEYQzxC7a+HGaqom+9m0sVmd9BW8oujAucpPxLZx+G355/ENxWWEWidNN+nDrJG9jY
 C0NKXw4osEgcV59JfTzV/BTCRoXDbd2cShk7tYaIhN1LOqNWSUwq6CfMDwDIyrXo+NrsR4MlIWO
 pVzBjmVftTQDcHmEyiRIuIJuPXhN5orzwR//pyySGelQL1IRXtPi2S8mN6ZAB6ZgoYChWXKjyez
 EaFpE6QGjnrAiS5Eia0hY5Ayi8woH6cKqJEkh9M/Zv501RG6LY/EbJasc7fwBZ5zXlRsWI7WWqk
 6Q/LeoxZuWAjSxzjaPzCIf8KcHbQjf4npceYdWe61NO7u2yp1JwxTwUvFLP8UE5NvLSlxaFTTdi
 h6L43GGRtAKNHrKc1wzjt5MKERrEf52XkbudjP1+OMBDoryvUhjhm+be/B8f5/wqgvc0eNgRLRj
 ECGakfsLSi9X7z55XE0wzkkroheZfgcZgtLC/dL7B3cq04
X-Received: by 2002:a05:6000:1447:b0:435:ab34:93bb with SMTP id
 ffacd0b85a97d-4399ddd88c5mr3129523f8f.12.1772186217488; 
 Fri, 27 Feb 2026 01:56:57 -0800 (PST)
Received: from [192.168.0.101] ([90.240.106.137])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4399c60feeesm6051680f8f.1.2026.02.27.01.56.56
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 27 Feb 2026 01:56:57 -0800 (PST)
Message-ID: <f7a8be38-fa15-4d88-a169-3c40bd318d27@ursulin.net>
Date: Fri, 27 Feb 2026 09:56:56 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] drm/amdgpu: Fix null pointer access in
 amdgpu_userq_signal_ioctl
To: "Zhang, Jesse(Jie)" <Jesse.Zhang@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "Koenig, Christian" <Christian.Koenig@amd.com>
References: <20260227085110.2865415-1-Jesse.Zhang@amd.com>
 <711f9a67-0323-47c5-a59a-81705af16d9e@ursulin.net>
 <DM4PR12MB51522BF9B5A7FD1AAE95F423E373A@DM4PR12MB5152.namprd12.prod.outlook.com>
Content-Language: en-GB
From: Tvrtko Ursulin <tursulin@ursulin.net>
In-Reply-To: <DM4PR12MB51522BF9B5A7FD1AAE95F423E373A@DM4PR12MB5152.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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


On 27/02/2026 09:43, Zhang, Jesse(Jie) wrote:
> [AMD Official Use Only - AMD Internal Distribution Only]
> 
>> -----Original Message-----
>> From: Tvrtko Ursulin <tursulin@ursulin.net>
>> Sent: Friday, February 27, 2026 5:05 PM
>> To: Zhang, Jesse(Jie) <Jesse.Zhang@amd.com>; amd-gfx@lists.freedesktop.org
>> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Koenig, Christian
>> <Christian.Koenig@amd.com>
>> Subject: Re: [PATCH v2] drm/amdgpu: Fix null pointer access in
>> amdgpu_userq_signal_ioctl
>>
>>
>> On 27/02/2026 08:50, Jesse.Zhang wrote:
>>> The amdgpu_userq_signal_ioctl function was triggering kernel page
>>> faults due to missing null pointer checks when accessing
>>> gobj_read/gobj_write arrays, and improper handling of memory allocation for these
>> arrays.
>>>
>>> The crash stack showed the failure originated from the ioctl path:
>>> [   64.977695] Call Trace:
>>> [   64.977696]  <TASK>
>>> [   64.977700]  amdgpu_userq_signal_ioctl+0x8e4/0xda0 [amdgpu]
>>> [   64.977830]  ? tty_ldisc_deref+0x1a/0x20
>>> [   64.977834]  ? __pfx_amdgpu_userq_signal_ioctl+0x10/0x10 [amdgpu]
>>> [   64.977934]  drm_ioctl_kernel+0xab/0x110 [drm]
>>> [   64.977955]  ? __pfx_amdgpu_userq_signal_ioctl+0x10/0x10 [amdgpu]
>>> [   64.978071]  drm_ioctl+0x2cb/0x5a0 [drm]
>>> [   64.978088]  ? ttm_bo_vm_fault_reserved+0x1ef/0x410 [ttm]
>>> [   64.978093]  amdgpu_drm_ioctl+0x4f/0x90 [amdgpu]
>>> [   64.978179]  __x64_sys_ioctl+0x9e/0xf0
>>> [   64.978182]  x64_sys_call+0x1274/0x2190
>>> [   64.978185]  do_syscall_64+0x74/0x950
>>> [   64.978189]  ? ___pte_offset_map+0x20/0x170
>>> [   64.978191]  ? __handle_mm_fault+0x986/0xfb0
>>> [   64.978194]  ? count_memcg_events+0xe7/0x1e0
>>> [   64.978197]  ? handle_mm_fault+0x1cc/0x2b0
>>> [   64.978199]  ? do_user_addr_fault+0x394/0x8a0
>>> [   64.978202]  ? irqentry_exit_to_user_mode+0x2a/0x1e0
>>> [   64.978205]  ? irqentry_exit+0x3f/0x50
>>> [   64.978206]  ? exc_page_fault+0x97/0x190
>>> [   64.978208]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
>>> [   64.978210] RIP: 0033:0x7f3c08b24ded
>>>
>>> Fixes: fd4fde1df18b ("drm/amdgpu/userq: Use drm_gem_objects_lookup in
>>> amdgpu_userq_signal_ioctl")
>>
>> It is best practice to Cc the target commit author. ;)
>>
>>>
>>> V2: initialize gobj_write
>>>
>>> Signed-off-by: Jesse Zhang <jesse.zhang@amd.com>
>>> ---
>>>    .../gpu/drm/amd/amdgpu/amdgpu_userq_fence.c   | 22 +++++++++++++------
>>>    1 file changed, 15 insertions(+), 7 deletions(-)
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
>>> index 3c30512a6266..af934374df94 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
>>> @@ -467,7 +467,7 @@ int amdgpu_userq_signal_ioctl(struct drm_device *dev,
>> void *data,
>>>      const unsigned int num_read_bo_handles = args->num_bo_read_handles;
>>>      struct amdgpu_fpriv *fpriv = filp->driver_priv;
>>>      struct amdgpu_userq_mgr *userq_mgr = &fpriv->userq_mgr;
>>> -   struct drm_gem_object **gobj_write, **gobj_read;
>>> +   struct drm_gem_object **gobj_write = NULL, **gobj_read = NULL;
>>>      u32 *syncobj_handles, num_syncobj_handles;
>>>      struct amdgpu_userq_fence *userq_fence;
>>>      struct amdgpu_usermode_queue *queue; @@ -597,13 +597,21 @@ int
>>> amdgpu_userq_signal_ioctl(struct drm_device *dev, void *data,
>>>    exec_fini:
>>>      drm_exec_fini(&exec);
>>>    put_gobj_write:
>>> -   for (i = 0; i < num_write_bo_handles; i++)
>>> -           drm_gem_object_put(gobj_write[i]);
>>> -   kfree(gobj_write);
>>> +   for (i = 0; i < num_write_bo_handles; i++) {
>>> +           if (gobj_write)
>>
>> I don't see a path go get here with gobj_write (or gobj_read) NULL. If number of
>> handles is greater than zero drm_gem_objects_lookup() either fails or returns a
>> valid pointer. What am I missing? What branch hit this? Before fixed
>> drm_gem_objects_lookup() was cherry picked to amd-staging-drm-next?
> [Zhang, Jesse(Jie)]
> 
> 
> The issue can be reproduced with the drm-next branch, and the header commit:
> commit 0c4c8715618b21a86bf238156defaa85ef94b5da (gerritgit/amd-staging-drm-next)
> Author: Yujie Liu <yujie.liu@intel.com>
> Date:   Thu Feb 26 11:00:37 2026 +0800

The upstream drm-next? I do not see 
0c4c8715618b21a86bf238156defaa85ef94b5da there. fd4fde1df18b is also not 
there.

> We should initialize gobj_write and set gobj_read to NULL;
> otherwise,  the pointer will point to a dangling pointer.
> 
> Which fixes do you mean about drm_gem_objects_lookup

This one:

commit 8477a645d27589091e528f31e4a2bba514b2cfe5
Author:     Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
AuthorDate: Fri Feb 6 18:51:41 2026 +0530
Commit:     Sunil Khatri <sunil.khatri@amd.com>
CommitDate: Tue Feb 24 18:58:09 2026 +0530

     drm/gem: Make drm_gem_objects_lookup() self-cleaning on failure v6

Was it in the branch which you tested?

Regards,

Tvrtko

> 
> Thanks
> Jesse
>>
>>> +                   drm_gem_object_put(gobj_write[i]);
>>> +   }
>>> +
>>> +   if (gobj_write)
>>> +           kfree(gobj_write);
>>
>> kfree() definitely handles NULL just fine.
>>
>> Regards,
>>
>> Tvrtko
>>
>>>    put_gobj_read:
>>> -   for (i = 0; i < num_read_bo_handles; i++)
>>> -           drm_gem_object_put(gobj_read[i]);
>>> -   kfree(gobj_read);
>>> +   for (i = 0; i < num_read_bo_handles; i++) {
>>> +           if (gobj_read)
>>> +                   drm_gem_object_put(gobj_read[i]);
>>> +   }
>>> +
>>> +   if (gobj_read)
>>> +           kfree(gobj_read);
>>>    free_syncobj:
>>>      while (entry-- > 0)
>>>              if (syncobj[entry])
> 

