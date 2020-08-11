Return-Path: <SRS0=t0+e=BV=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 729AEC433E0
	for <amd-gfx@archiver.kernel.org>; Tue, 11 Aug 2020 06:55:42 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 199C320772
	for <amd-gfx@archiver.kernel.org>; Tue, 11 Aug 2020 06:55:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="OyCb8vlo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 199C320772
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 66A8789235;
	Tue, 11 Aug 2020 06:55:41 +0000 (UTC)
Received: from mail-ot1-x344.google.com (mail-ot1-x344.google.com
 [IPv6:2607:f8b0:4864:20::344])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DFE086E0FB
 for <amd-gfx@lists.freedesktop.org>; Tue, 11 Aug 2020 06:55:39 +0000 (UTC)
Received: by mail-ot1-x344.google.com with SMTP id v6so9289231ota.13
 for <amd-gfx@lists.freedesktop.org>; Mon, 10 Aug 2020 23:55:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ffwll.ch; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=i6qIJY2uIxoXHuLbsRWaOwUSjoVG1vlt+gSO0S54W0w=;
 b=OyCb8vlo17S3kXcZ8Boml7Otndx402froYm30gJJOtJBBSKclQG55od/gJHavoSW6q
 Np7foUdlJ/lsNSFahosu+vMqVlpmyYKe0BNStNYGcyYmclep/wfJvTUHVsgCsiCVLKR0
 gBY9KVQgR/UNCVyKxcht3YY3kqV/eA90j2Id0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=i6qIJY2uIxoXHuLbsRWaOwUSjoVG1vlt+gSO0S54W0w=;
 b=dXKEDxprK0DRRpx1n5N4MBPac1ZYh8G5pE/fEo6lARmjcg/bqqHepfw23Ye3vvUVvl
 DF2II0fEC+zuyEXVW8DUiZfYi2R2tHJk7CaxCzW8VwyuzvG/9PqmYoKuENMtzEi49WzG
 d94CJmY9eIh1O//j61yF9D7Db0Po4ZAYKIYXuAwT52sRDA0anEHU8DQ5Fzu0mSDlBrgF
 Z00zAJ4EEc5USUj017VUuN3PXsJdulo+S7A9hTcDsA591iDOKNLaojwtgtEuieiOicsq
 fjFjosWk2hYHAvNCx6IEbCD+xOnhTke1bKKuNpepF3sMcQ1OMHBmlyr1ychatXwLAty7
 ahAg==
X-Gm-Message-State: AOAM532Sk7z7vIGXXuqVG0DpXlvgHsOr6Hy6KkHbZDa/Pe5ypMRkmKIu
 cuM8Nsq4MRDl80gmnIgJVvCrIcIvGxHvwbPpKWzf4w==
X-Google-Smtp-Source: ABdhPJwirbL022SQxMz71q6itSgy4CDe9lu8J8I6SoBwwWIxjEwBV3yB/TniWCyMsBLdEW43NbmTSsXV2wf5fyl2Okk=
X-Received: by 2002:a05:6830:1e71:: with SMTP id
 m17mr4020089otr.188.1597128939021; 
 Mon, 10 Aug 2020 23:55:39 -0700 (PDT)
MIME-Version: 1.0
References: <20200811021224.3688-1-Dennis.Li@amd.com>
In-Reply-To: <20200811021224.3688-1-Dennis.Li@amd.com>
From: Daniel Vetter <daniel@ffwll.ch>
Date: Tue, 11 Aug 2020 08:55:28 +0200
Message-ID: <CAKMK7uFa8HqHN5KiR--4tXQ+2PyRKZNCZ27w_kxsNrj5c3j4=Q@mail.gmail.com>
Subject: Re: [PATCH v3] drm/amdgpu: annotate a false positive recursive locking
To: Dennis Li <Dennis.Li@amd.com>
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
Cc: Alex Deucher <Alexander.Deucher@amd.com>, "Kuehling,
 Felix" <felix.kuehling@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>,
 Hawking Zhang <Hawking.Zhang@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Tue, Aug 11, 2020 at 4:12 AM Dennis Li <Dennis.Li@amd.com> wrote:
>
> [  584.110304] ============================================
> [  584.110590] WARNING: possible recursive locking detected
> [  584.110876] 5.6.0-deli-v5.6-2848-g3f3109b0e75f #1 Tainted: G           OE
> [  584.111164] --------------------------------------------
> [  584.111456] kworker/38:1/553 is trying to acquire lock:
> [  584.111721] ffff9b15ff0a47a0 (&adev->reset_sem){++++}, at: amdgpu_device_gpu_recover+0x262/0x1030 [amdgpu]
> [  584.112112]
>                but task is already holding lock:
> [  584.112673] ffff9b1603d247a0 (&adev->reset_sem){++++}, at: amdgpu_device_gpu_recover+0x262/0x1030 [amdgpu]
> [  584.113068]
>                other info that might help us debug this:
> [  584.113689]  Possible unsafe locking scenario:
>
> [  584.114350]        CPU0
> [  584.114685]        ----
> [  584.115014]   lock(&adev->reset_sem);
> [  584.115349]   lock(&adev->reset_sem);
> [  584.115678]
>                 *** DEADLOCK ***
>
> [  584.116624]  May be due to missing lock nesting notation
>
> [  584.117284] 4 locks held by kworker/38:1/553:
> [  584.117616]  #0: ffff9ad635c1d348 ((wq_completion)events){+.+.}, at: process_one_work+0x21f/0x630
> [  584.117967]  #1: ffffac708e1c3e58 ((work_completion)(&con->recovery_work)){+.+.}, at: process_one_work+0x21f/0x630
> [  584.118358]  #2: ffffffffc1c2a5d0 (&tmp->hive_lock){+.+.}, at: amdgpu_device_gpu_recover+0xae/0x1030 [amdgpu]
> [  584.118786]  #3: ffff9b1603d247a0 (&adev->reset_sem){++++}, at: amdgpu_device_gpu_recover+0x262/0x1030 [amdgpu]
> [  584.119222]
>                stack backtrace:
> [  584.119990] CPU: 38 PID: 553 Comm: kworker/38:1 Kdump: loaded Tainted: G           OE     5.6.0-deli-v5.6-2848-g3f3109b0e75f #1
> [  584.120782] Hardware name: Supermicro SYS-7049GP-TRT/X11DPG-QT, BIOS 3.1 05/23/2019
> [  584.121223] Workqueue: events amdgpu_ras_do_recovery [amdgpu]
> [  584.121638] Call Trace:
> [  584.122050]  dump_stack+0x98/0xd5
> [  584.122499]  __lock_acquire+0x1139/0x16e0
> [  584.122931]  ? trace_hardirqs_on+0x3b/0xf0
> [  584.123358]  ? cancel_delayed_work+0xa6/0xc0
> [  584.123771]  lock_acquire+0xb8/0x1c0
> [  584.124197]  ? amdgpu_device_gpu_recover+0x262/0x1030 [amdgpu]
> [  584.124599]  down_write+0x49/0x120
> [  584.125032]  ? amdgpu_device_gpu_recover+0x262/0x1030 [amdgpu]
> [  584.125472]  amdgpu_device_gpu_recover+0x262/0x1030 [amdgpu]
> [  584.125910]  ? amdgpu_ras_error_query+0x1b8/0x2a0 [amdgpu]
> [  584.126367]  amdgpu_ras_do_recovery+0x159/0x190 [amdgpu]
> [  584.126789]  process_one_work+0x29e/0x630
> [  584.127208]  worker_thread+0x3c/0x3f0
> [  584.127621]  ? __kthread_parkme+0x61/0x90
> [  584.128014]  kthread+0x12f/0x150
> [  584.128402]  ? process_one_work+0x630/0x630
> [  584.128790]  ? kthread_park+0x90/0x90
> [  584.129174]  ret_from_fork+0x3a/0x50
>
> Each adev has owned lock_class_key to avoid false positive
> recursive locking.
>
> v2:
> 1. register adev->lock_key into lockdep, otherwise lockdep will
> report the below warning
>
> [ 1216.705820] BUG: key ffff890183b647d0 has not been registered!
> [ 1216.705924] ------------[ cut here ]------------
> [ 1216.705972] DEBUG_LOCKS_WARN_ON(1)
> [ 1216.705997] WARNING: CPU: 20 PID: 541 at kernel/locking/lockdep.c:3743 lockdep_init_map+0x150/0x210
>
> v3:
> change to use down_write_nest_lock to annotate the false dead-lock
> warning.
>
> Signed-off-by: Dennis Li <Dennis.Li@amd.com>

I'd explain a bit more in writing what the actual deadlock possibility
is, but up to you folks.

Reviewed-by: Daniel Vetter <daniel.vetter@ffwll.ch>

Cheers, Daniel
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> index 62ecac97fbd2..8a55b0bc044a 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -4145,12 +4145,15 @@ static int amdgpu_do_asic_reset(struct amdgpu_hive_info *hive,
>         return r;
>  }
>
> -static bool amdgpu_device_lock_adev(struct amdgpu_device *adev)
> +static bool amdgpu_device_lock_adev(struct amdgpu_device *adev, struct amdgpu_hive_info *hive)
>  {
>         if (atomic_cmpxchg(&adev->in_gpu_reset, 0, 1) != 0)
>                 return false;
>
> -       down_write(&adev->reset_sem);
> +       if (hive) {
> +               down_write_nest_lock(&adev->reset_sem, &hive->hive_lock);
> +       } else
> +               down_write(&adev->reset_sem);
>
>         atomic_inc(&adev->gpu_reset_counter);
>         switch (amdgpu_asic_reset_method(adev)) {
> @@ -4312,7 +4315,7 @@ int amdgpu_device_gpu_recover(struct amdgpu_device *adev,
>
>         /* block all schedulers and reset given job's ring */
>         list_for_each_entry(tmp_adev, device_list_handle, gmc.xgmi.head) {
> -               if (!amdgpu_device_lock_adev(tmp_adev)) {
> +               if (!amdgpu_device_lock_adev(tmp_adev, hive)) {
>                         DRM_INFO("Bailing on TDR for s_job:%llx, as another already in progress",
>                                   job ? job->base.id : -1);
>                         r = 0;
> --
> 2.17.1
>


-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
