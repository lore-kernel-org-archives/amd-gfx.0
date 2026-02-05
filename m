Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87646E9129A
	for <amd-gfx@archiver.kernel.org>; Thu,  5 Feb 2026 15:21:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E25D010E11B;
	Thu,  5 Feb 2026 15:21:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=damsy.net header.i=@damsy.net header.b="R0oAlbVR";
	dkim=permerror (0-bit key) header.d=damsy.net header.i=@damsy.net header.b="9Alq2s/5";
	dkim-atps=neutral
Received: from jeth.damsy.net (jeth.damsy.net [51.159.152.102])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6C11D10E101
 for <amd-gfx@lists.freedesktop.org>; Thu,  5 Feb 2026 15:21:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; s=202408r; d=damsy.net; c=relaxed/relaxed; 
 h=From:To:Subject:Date:Message-ID; t=1770304862;
 bh=WaEsyD+JJXeO/tXP9pd9lVz
 p+tmvyuG0mBtQ2neq6xg=; b=R0oAlbVReHcDnThxaizrc+snK5yxP+TPwz4THMwZMKPL8jPwA3
 +8G6jHDnv+YWEO+YdcK+jyBYg1E2e5TU1QXzrddBOCwGg24QfXB+m0Pxl+lp9O4xt8BXYMH88o4
 wK/XX6yjs+g+BCjvequsG4TBzlaIFCVoBDrisJRGgdLzjvCamt0iKUKU03s0tRO4um8H9MvGiVM
 qmW5eOr/SAOholNWL3dYVyCRv100DhmR3PA0JTE5ODRGbpvy2kMdBVb7FXdXZtNQsB1s4l+uGOG
 Ig0a5NrfWXBfzIKMIOIw8xGdJ+RgjMzmn+FIFJ7uC/F/RpgBXIbLuG20Jw9Q3okMO0g==;
DKIM-Signature: v=1; a=ed25519-sha256; s=202408e; d=damsy.net;
 c=relaxed/relaxed; 
 h=From:To:Subject:Date:Message-ID; t=1770304862; bh=WaEsyD+JJXeO/tXP9pd9lVz
 p+tmvyuG0mBtQ2neq6xg=; b=9Alq2s/55TVvNesQ9lBCvUrH0QIgD1TIJP0zyY04rBBqIzJv0O
 r/MslwIeBlyJnPmD5g/k07WEUPBhEU9rohCA==;
Message-ID: <32a311db-e50c-49cc-a9da-95ae36ab0126@damsy.net>
Date: Thu, 5 Feb 2026 16:21:01 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 05/12] drm/amdgpu: don't call drm_sched_stop/start() in
 asic reset
To: Alex Deucher <alexdeucher@gmail.com>
Cc: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org,
 christian.koenig@amd.com
References: <20260130173042.15008-1-alexander.deucher@amd.com>
 <20260130173042.15008-6-alexander.deucher@amd.com>
 <937673e3-36a0-4ff0-a76d-c63a34885184@damsy.net>
 <CADnq5_OoDPEy2PM5YUmOWU8k8rLk9UBD88oU5rCndh=Hovcu_Q@mail.gmail.com>
Content-Language: en-US
From: Pierre-Eric Pelloux-Prayer <pierre-eric@damsy.net>
In-Reply-To: <CADnq5_OoDPEy2PM5YUmOWU8k8rLk9UBD88oU5rCndh=Hovcu_Q@mail.gmail.com>
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



Le 05/02/2026 à 15:26, Alex Deucher a écrit :
> On Thu, Feb 5, 2026 at 9:22 AM Pierre-Eric Pelloux-Prayer
> <pierre-eric@damsy.net> wrote:
>>
>>
>>
>> Le 30/01/2026 à 18:30, Alex Deucher a écrit :
>>> We only want to stop the work queues, not mess with the
>>> fences, etc.
>>>
>>> v2: add the job back to the pending list.
>>> v3: return the proper job status so scheduler adds the
>>>       job back to the pending list
>>>
>>> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
>>> ---
>>>    drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 4 ++--
>>>    drivers/gpu/drm/amd/amdgpu/amdgpu_job.c    | 6 ++----
>>>    2 files changed, 4 insertions(+), 6 deletions(-)
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>> index e69ab8a923e31..a5b43d57c7b05 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>> @@ -6313,7 +6313,7 @@ static void amdgpu_device_halt_activities(struct amdgpu_device *adev,
>>>                        if (!amdgpu_ring_sched_ready(ring))
>>>                                continue;
>>>
>>> -                     drm_sched_stop(&ring->sched, job ? &job->base : NULL);
>>> +                     drm_sched_wqueue_stop(&ring->sched);
>>>
>>>                        if (need_emergency_restart)
>>>                                amdgpu_job_stop_all_jobs_on_sched(&ring->sched);
>>> @@ -6397,7 +6397,7 @@ static int amdgpu_device_sched_resume(struct list_head *device_list,
>>>                        if (!amdgpu_ring_sched_ready(ring))
>>>                                continue;
>>>
>>> -                     drm_sched_start(&ring->sched, 0);
>>> +                     drm_sched_wqueue_start(&ring->sched);
>>>                }
>>>
>>>                if (!drm_drv_uses_atomic_modeset(adev_to_drm(tmp_adev)) && !job_signaled)
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
>>> index df06a271bdf99..cd0707737a29b 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
>>> @@ -92,7 +92,6 @@ static enum drm_gpu_sched_stat amdgpu_job_timedout(struct drm_sched_job *s_job)
>>>        struct drm_wedge_task_info *info = NULL;
>>>        struct amdgpu_task_info *ti = NULL;
>>>        struct amdgpu_device *adev = ring->adev;
>>> -     enum drm_gpu_sched_stat status = DRM_GPU_SCHED_STAT_RESET;
>>>        int idx, r;
>>>
>>>        if (!drm_dev_enter(adev_to_drm(adev), &idx)) {
>>> @@ -147,8 +146,6 @@ static enum drm_gpu_sched_stat amdgpu_job_timedout(struct drm_sched_job *s_job)
>>>                                ring->sched.name);
>>>                        drm_dev_wedged_event(adev_to_drm(adev),
>>>                                             DRM_WEDGE_RECOVERY_NONE, info);
>>> -                     /* This is needed to add the job back to the pending list */
>>> -                     status = DRM_GPU_SCHED_STAT_NO_HANG;
>>>                        goto exit;
>>>                }
>>>                dev_err(adev->dev, "Ring %s reset failed\n", ring->sched.name);
>>> @@ -184,7 +181,8 @@ static enum drm_gpu_sched_stat amdgpu_job_timedout(struct drm_sched_job *s_job)
>>>    exit:
>>>        amdgpu_vm_put_task_info(ti);
>>>        drm_dev_exit(idx);
>>> -     return status;
>>> +     /* This is needed to add the job back to the pending list */
>>> +     return DRM_GPU_SCHED_STAT_NO_HANG;
>>
>> This part seems unrelated to the patch and is overwriting what was done
>> in patch 1/12.
> 
> Patch 1 fixes the pending list handling for per queue resets.  This
> patch reworks the adapter reset path to match the behavior of the per
> queue reset path.  After this patch they match so we can safely return
> DRM_GPU_SCHED_STAT_NO_HANG in both cases.  Previously the adapter
> reset path called drm_sched_wqueue_stop()/start() which handles
> re-adding the job to the pending list.  Since it no longer does, we
> need to return DRM_GPU_SCHED_STAT_NO_HANG for both cases.

I looked a bit more in the patchset adding DRM_GPU_SCHED_STAT_NO_HANG 
and your changes make sense. This patch is:

Acked-by: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>

