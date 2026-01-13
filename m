Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72D4FD2D10A
	for <amd-gfx@archiver.kernel.org>; Tue, 13 Jan 2026 14:37:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 12AF289906;
	Tue, 13 Jan 2026 14:37:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="JL4BBcJO";
	dkim-atps=neutral
Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com
 [209.85.222.172])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CF24589906
 for <amd-gfx@lists.freedesktop.org>; Tue, 13 Jan 2026 14:37:53 +0000 (UTC)
Received: by mail-qk1-f172.google.com with SMTP id
 af79cd13be357-8ba0d6c68a8so885173585a.1
 for <amd-gfx@lists.freedesktop.org>; Tue, 13 Jan 2026 06:37:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1768315073; x=1768919873; darn=lists.freedesktop.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=G0vXoWeic3QPDawv7j1RRdDOpkeTKAZjgTVwu71hLJ0=;
 b=JL4BBcJOWQuc3OjaBFYG0a6i3ZV3j02AkN+VHNwGu9lOIBPxrOGx3OABNOpOOnVH3s
 JyhTDdQOJjlMwVeyjcMjNXoLpYH40jq/HjA5dvEcULy304r6z5Pq3hwQq1WrGnYtmWrJ
 RJh/zlcH3YRKT0dNw4/tDJXlpEbEA/Y4id7DEU7HJG/xQUPr3kqctqG1qp/11Og6Tsjz
 rsJf/zZwc4r8oWzeJzS4lGqwTNah9y8SWovfNkRKRcYClV9vM74PFeKbtInJm28f/QGP
 76B5U0ma9uKz05/ciTIvgLCH0VOwiGt+yNQWBo0ojV7zgnK/5GbjNcYCKxdjGQ2CKWnB
 49Eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768315073; x=1768919873;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=G0vXoWeic3QPDawv7j1RRdDOpkeTKAZjgTVwu71hLJ0=;
 b=AhrOSCUXcbZSDJJx5XJYSDGo8j04zQ7XIzadCpxOO2/yHwUHie6Q4UWgCPPmgn3DzM
 ZHMxp9jQNFuWE1K0++rFixhSHWHis2Szcf+sgIyJX4O3I+SMJY1IN/bRBcOyNDGcXL/h
 OeDtB6rkdgpkS7jZ+5dAElNY2d7GQETVLcQw+KtGCpNGUX1qykI6xrmb2slJDpKNd4yj
 5AzLuD77+dmAPfk20s2oVKKcwd3h2uFPRLzEaUz7VjAUeMTboWCt/05Cg+bfmnD1E1Ki
 gnGDGCgsL4DV2nQFoL72DPKsyopioLsxV94fB+WjAQ87pqAwZFlxDlqSF1Qk3DdC8kO2
 T6SA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUICttGHZpiookdbjAh22GIHMrAPAOwvNWlYPw8jAy4MELSlEols1GWMPWQTerXEk3j07fEICwS@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzA5pg+wEgoH2NxHYQPXX99c5DqdxNIM6aGE3oU68HqhMFVq4J0
 EeopUlMOz+xVYnBcyrV3Q9lh2ctfpsaRK95LsQzT3qyqtlN5YIQw2rfU
X-Gm-Gg: AY/fxX5sMrq0pg/uZGJbx6Y3Cv/GA9ydTXCD0KMGecFeyZuq94AeU3SOD9JpSXqka/a
 0hYU8Y+FAMj3+7mJ2TmhFfYJAKk4TGU/s2ZZ1tAMKnvKhzuAld+YC15Ud+u8ulYuVRLnatNiDhm
 bc3R6ZzrYei+bwt27x5Y4I37RFoLsnIEF08xGWHFFqJJav/ECsglVYGFf8UyhXo/XaMbuNPyTNd
 T3ZcLc1p7qWLPJSRfodpgWeiAU+uFf7GOPVTMzJoI8E1uQ7DqrQ0hNAnANH71GezN3ydskARKTB
 7FSBVVcvMSHpX8t6yld0S1D+ei9t8kD5z3qWGIJGwDNat40WW9bAayIZvaQ+1DhY2Yc3fTQeiqR
 cNAk8Q7l7CAtYhyWyq9Ty7kefsD0JdOtLeTD6tSceUPQFzI3WhBANs3UxPcMxKegomTa8lTKmcz
 c4tz+S1t5PIYEUnwg2sENHOoAeyooyw/it66HWhT0ZenkaHXDJkpgO+Q==
X-Google-Smtp-Source: AGHT+IEZCaRrH+/hPU6vgKE1Z5+g1Vg2ZBNbAyIv1HLaakkfuByzy97H43wwK9nFuV4lqXiUjAeVUw==
X-Received: by 2002:a05:620a:410e:b0:8c0:d16b:b0a7 with SMTP id
 af79cd13be357-8c38938dc0amr2843322585a.2.1768315072620; 
 Tue, 13 Jan 2026 06:37:52 -0800 (PST)
Received: from [10.254.120.192] (mkmvpn.amd.com. [165.204.54.211])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-8c37f4a63acsm1735142185a.6.2026.01.13.06.37.51
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 13 Jan 2026 06:37:52 -0800 (PST)
Message-ID: <bcd6ee8a-b951-4088-94c7-b9d260fe0c48@gmail.com>
Date: Tue, 13 Jan 2026 15:37:50 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 29/42] drm/amdgpu: don't call drm_sched_stop/start() in
 asic reset
To: phasta@kernel.org, Alex Deucher <alexander.deucher@amd.com>,
 amd-gfx@lists.freedesktop.org
References: <20260108144843.493816-1-alexander.deucher@amd.com>
 <20260108144843.493816-30-alexander.deucher@amd.com>
 <08a6057a-7e95-4007-a4ee-ec8f6e3e5540@gmail.com>
 <8a8dbf04b6d13d67541dc2bc1fb91769def373c2.camel@mailbox.org>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>
In-Reply-To: <8a8dbf04b6d13d67541dc2bc1fb91769def373c2.camel@mailbox.org>
Content-Type: text/plain; charset=UTF-8
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

On 1/13/26 14:34, Philipp Stanner wrote:
> On Tue, 2026-01-13 at 14:17 +0100, Christian König wrote:
>> On 1/8/26 15:48, Alex Deucher wrote:
>>> We only want to stop the work queues, not mess with the
>>> pending list so just stop the work queues.
> 
> Ideally amdgpu could stop touching the pending_list altogether forever,
> as discussed at XDC. Is work for that in the pipe? Is that what this
> patch is for?

Yes.

> 
>>
>> Oh, yes please! I can't remember how long we have worked towards that.
>>
>> But we also need to change the return code so that the scheduler now re-inserts the job into the pending list.
> 
> You're referring to false-positive timeouts. Porting users to that
> typically consists of adding that return code and also removing
> whatever the driver used to do to inject the non-timedout job into the
> scheduler again.
> 
> How is that being done here?

Previously drm_sched_stop() would insert the job back into the pending list after stopping the scheduler thread.

But when that is replaced with drm_sched_wqueue_stop() then that won't happen any more. That is a good thing and prevents us from running into problems like UAF because the HW fence signaled.

As far as I can see we should start returning DRM_GPU_SCHED_STAT_NO_HANG from amdgpu even when there was actually a hang (maybe rename the return code).

Regards,
Christian.

> 
> P.
> 
>>
>> Adding Philip on CC to double check what I say above.
>>
>> Regards,
>> Christian.
>>
>>>
>>> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
>>> ---
>>>  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 4 ++--
>>>  1 file changed, 2 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>> index 80572f71ff627..868ab5314c0d1 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>> @@ -6301,7 +6301,7 @@ static void amdgpu_device_halt_activities(struct amdgpu_device *adev,
>>>  			if (!amdgpu_ring_sched_ready(ring))
>>>  				continue;
>>>  
>>> -			drm_sched_stop(&ring->sched, job ? &job->base : NULL);
>>> +			drm_sched_wqueue_stop(&ring->sched);
>>>  
>>>  			if (need_emergency_restart)
>>>  				amdgpu_job_stop_all_jobs_on_sched(&ring->sched);
>>> @@ -6385,7 +6385,7 @@ static int amdgpu_device_sched_resume(struct list_head *device_list,
>>>  			if (!amdgpu_ring_sched_ready(ring))
>>>  				continue;
>>>  
>>> -			drm_sched_start(&ring->sched, 0);
>>> +			drm_sched_wqueue_start(&ring->sched);
>>>  		}
>>>  
>>>  		if (!drm_drv_uses_atomic_modeset(adev_to_drm(tmp_adev)) && !job_signaled)
>>
> 

