Return-Path: <SRS0=GnFq=3T=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48C6AC2D0DB
	for <amd-gfx@archiver.kernel.org>; Thu, 30 Jan 2020 22:11:37 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 16DAD20707
	for <amd-gfx@archiver.kernel.org>; Thu, 30 Jan 2020 22:11:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SSyXw41S"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 16DAD20707
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AF13F6E927;
	Thu, 30 Jan 2020 22:11:36 +0000 (UTC)
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com
 [IPv6:2a00:1450:4864:20::32b])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6BAF26FA37
 for <amd-gfx@lists.freedesktop.org>; Thu, 30 Jan 2020 22:11:35 +0000 (UTC)
Received: by mail-wm1-x32b.google.com with SMTP id b17so6283758wmb.0
 for <amd-gfx@lists.freedesktop.org>; Thu, 30 Jan 2020 14:11:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=BPTTzePZXPTpNW5thbjZKHDryc0V3LnWAz/qbVw5+2I=;
 b=SSyXw41SkqxWbOfRhqCAweCF/pNvLJhYW9I3dZVQOpKTLjdSeWVQjGHN7YXneAI/aL
 jGlrlnVMq5udjIVNiEzUyq9sfjhM8GqFU9l3jWD95Sqk1eInt4aXM5h5n2E0HqlH0JdN
 D1bG5rpXsxDlHEHZXf6pstminvzvslAbwIYmellw3Jc1CStSAU7JmVgi540Ft9sglg7b
 9NZuuupufSfRfw4gxuJCUgWWU6gfN7rdYLPiD3OA5UhvRyCCfy3oHceivoGujyj6zcLq
 XI9Ic1J59Iy8XYS0eqMF5jFe1stJ3+9ciQO23QOQ+N4Y/yDIpcaUiUMsB/iB/YqDyyLu
 SXHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=BPTTzePZXPTpNW5thbjZKHDryc0V3LnWAz/qbVw5+2I=;
 b=nNDCFB9fEpHVrfolQOcKsvlRAiwvx/qc/0cjnVbfkUlRikC3GjR7W8yYuGVBq6U39/
 cfs6O8c/CTfTK5Krw1LvRZqoU6pLxfXVYrPEAUdpZh3KSDp/vjMM9r3DIY7BCAxg1bNU
 lKqD+L921o+w9xNAfVpbry7A3xVsnwB1gGrOPvUJmh5R5+dHBgZ7eObkWKLH3twX9Gra
 VMqwXlyCMSXrb3pwhDMBWW/FGF3AgcHa9TiXwV2aze3N/4XZoWvjnFYU6tmjrA7bH14b
 X9BVKb60KHl7HbJ/eUYjEvQJdo+aVFEkQkZqJhoRfm2qKg4e2MfQe6X6U65Bh2vp3j8J
 Olnw==
X-Gm-Message-State: APjAAAVfj2jNjOSjidjVWf3xufbFg6ejXtOqd4+Yk3bHTzqYkE7AdGv8
 GWdUBzBSqnymFDf7wOFChXzfLa7bGncQ/NyKFPLA2ur5
X-Google-Smtp-Source: APXvYqx4m/ji3zMk2f6ELvpygkOzPKYBtFLcXTtGrOa/IA/e/lHJ4/lf2zfEL0G+pUlzABVCbqtz+b3HE0q6op3jDGQ=
X-Received: by 2002:a1c:9a56:: with SMTP id c83mr7892390wme.79.1580422293690; 
 Thu, 30 Jan 2020 14:11:33 -0800 (PST)
MIME-Version: 1.0
References: <20200128012923.25536-1-rajneesh.bhardwaj@amd.com>
 <20200128012923.25536-6-rajneesh.bhardwaj@amd.com>
 <be59d17b-cb49-16e9-db24-c14a8fe4fdee@amd.com>
 <e9ce3377-d0db-4e16-9137-8d12d4d1ad97@amd.com>
 <3b8f588c-87ef-c361-be75-12444fce8e34@amd.com>
In-Reply-To: <3b8f588c-87ef-c361-be75-12444fce8e34@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 30 Jan 2020 17:11:22 -0500
Message-ID: <CADnq5_NwaGDzR-dk+WCdrs6V-b0_dex+vGgEnBX5NV7bfXc43g@mail.gmail.com>
Subject: Re: [Patch v1 5/5] drm/amdkfd: refactor runtime pm for baco
To: Felix Kuehling <felix.kuehling@amd.com>
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Bhardwaj,
 Rajneesh" <rajneesh.bhardwaj@amd.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Thu, Jan 30, 2020 at 4:55 PM Felix Kuehling <felix.kuehling@amd.com> wrote:
>
> On 2020-01-30 14:01, Bhardwaj, Rajneesh wrote:
> > Hello Felix,
> >
> > Thanks for your time to review and for your feedback.
> >
> > On 1/29/2020 5:52 PM, Felix Kuehling wrote:
> >> HI Rajneesh,
> >>
> >> See comments inline ...
> >>
> >> And a general question: Why do you need to set the autosuspend_delay
> >> in so many places? Amdgpu only has a single call to this function
> >> during initialization.
> >
> >
> > We don't. I have called this out in cover letter since i too feel its
> > not the best way to do what we want to do. I have seen weird issues on
> > dual GPUs with KFDTest that sometimes results in system hang and gpu
> > hang etc.
> >
> > Even if i try with running kfdtest on just one node in a multi gpu
> > system, the baco exit seems to wake up all gpus and then one goes to
> > auto suspend again while other performs the desired kfdtest operation.
> > I have never seen any issue with a single gpu card. So in current
> > approch, i am making sure that the GPUs are not quickly auto-suspended
> > while the kfd operations are ongoing but once the kfdtest is finished,
> > the runtime suspend call with ensure to reset the timeout back to 5
> > seconds.
>
> So by setting the timeout to 60s, you can fix applications that run for
> less than 60s without calling into KFD. What about applications that run
> for longer without calling into KFD? This doesn't sound like a solution,
> it's just a hack.
>
>
> >
> >
> > I would like to avoid this and appreciate some pointers where i can
> > put get_sync calls while unbinding. I have tried a number of places
> > but saw some issues. So any help will be highly appreciated, to
> > identify the proper logical inverse of kfd_bind_process_to_device.
>
> kfd_bind_process_to_device is called when KFD starts using a device. It
> only stops using that device when the process is destroyed. Therefore I
> recommended moving the cleanup code into kfd_process_destroy_pdds, which
> iterates over all devices (PDDs) during process termination.
>
> Note that kfd_bind_process_to_device can be called many times for the
> same device. If you need to keep usage counters balanced, you need extra
> checks to make sure you only do runtime-PM stuff the first time it's
> called for a particular device in a particular process.
>
> Also, in kfd_process_destroy_pdds you may need to check whether
> kfd_bind_process_to_device has been called for a particular PDD before
> releasing runtime PM.

runtimepm already has reference counting.  You can use something like
pm_runtime_get_sync() or pm_runtime_get_noresume() depending on
whether you want to make sure the GPU is powered up or not.  That will
increase the usage count on the device for runtime pm.  Then when you
want to decrement and possibly suspend the device, call
pm_runtime_mark_last_busy() and pm_runtime_put_autosuspend().  That is
basically what we do in amdgpu to handle device usage.  We call
pm_runtime_get_noresume() in our fence_emit function which is what
gets called when we submit work to the GPU.  That increments the usage
count for runpm.  Then we call pm_runtime_mark_last_busy() and
pm_runtime_put_autosuspend() in our fence_process function.  That gets
called as each job on the GPU is retired.  For kfd, I think you'll
want to call pm_runtime_get_sync() in at the start of your ioctl to
wake the device, then pm_runtime_mark_last_busy() and
pm_runtime_put_autosuspend() at the end of your ioctl to mark to match
the start.  Then in your actual ioctl work, you'll want to call
pm_runtime_get_noresume() everytime a queue gets created and
pm_runtime_mark_last_busy() and pm_runtime_put_autosuspend() each time
a queue is destroyed.  That should keep the device awake as long as
there are any queues around.  Due to stuff like xgmi, it's probably
best to just do this for all GPUs on the system just in case you have
any p2p stuff going on.

Alex

>
> Regards,
>    Felix
>
>
> >
> >
> >>
> >> On 2020-01-27 20:29, Rajneesh Bhardwaj wrote:
> >>> So far the kfd driver implemented same routines for runtime and system
> >>> wide suspend and resume (s2idle or mem). During system wide suspend the
> >>> kfd aquires an atomic lock that prevents any more user processes to
> >>> create queues and interact with kfd driver and amd gpu. This mechanism
> >>> created problem when amdgpu device is runtime suspended with BACO
> >>> enabled. Any application that relies on kfd driver fails to load
> >>> because
> >>> the driver reports a locked kfd device since gpu is runtime suspended.
> >>>
> >>> However, in an ideal case, when gpu is runtime  suspended the kfd
> >>> driver
> >>> should be able to:
> >>>
> >>>   - auto resume amdgpu driver whenever a client requests compute
> >>> service
> >>>   - prevent runtime suspend for amdgpu  while kfd is in use
> >>>
> >>> This change refactors the amdgpu and amdkfd drivers to support BACO and
> >>> runtime runtime power management.
> >>>
> >>> Signed-off-by: Rajneesh Bhardwaj <rajneesh.bhardwaj@amd.com>
> >>> ---
> >>>   drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c | 12 ++++-----
> >>>   drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h |  8 +++---
> >>>   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c |  4 +--
> >>>   drivers/gpu/drm/amd/amdkfd/kfd_device.c    | 31
> >>> +++++++++++++---------
> >>>   drivers/gpu/drm/amd/amdkfd/kfd_iommu.c     |  5 +++-
> >>>   drivers/gpu/drm/amd/amdkfd/kfd_process.c   | 19 ++++++++++---
> >>>   6 files changed, 51 insertions(+), 28 deletions(-)
> >>>
> >>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
> >>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
> >>> index 8609287620ea..314c4a2a0354 100644
> >>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
> >>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
> >>> @@ -178,18 +178,18 @@ void amdgpu_amdkfd_interrupt(struct
> >>> amdgpu_device *adev,
> >>>           kgd2kfd_interrupt(adev->kfd.dev, ih_ring_entry);
> >>>   }
> >>>   -void amdgpu_amdkfd_suspend(struct amdgpu_device *adev)
> >>> +void amdgpu_amdkfd_suspend(struct amdgpu_device *adev, bool run_pm)
> >>>   {
> >>>       if (adev->kfd.dev)
> >>> -        kgd2kfd_suspend(adev->kfd.dev);
> >>> +        kgd2kfd_suspend(adev->kfd.dev, run_pm);
> >>>   }
> >>>   -int amdgpu_amdkfd_resume(struct amdgpu_device *adev)
> >>> +int amdgpu_amdkfd_resume(struct amdgpu_device *adev, bool run_pm)
> >>>   {
> >>>       int r = 0;
> >>>         if (adev->kfd.dev)
> >>> -        r = kgd2kfd_resume(adev->kfd.dev);
> >>> +        r = kgd2kfd_resume(adev->kfd.dev, run_pm);
> >>>         return r;
> >>>   }
> >>> @@ -713,11 +713,11 @@ void kgd2kfd_exit(void)
> >>>   {
> >>>   }
> >>>   -void kgd2kfd_suspend(struct kfd_dev *kfd)
> >>> +void kgd2kfd_suspend(struct kfd_dev *kfd, bool run_pm)
> >>>   {
> >>>   }
> >>>   -int kgd2kfd_resume(struct kfd_dev *kfd)
> >>> +int kgd2kfd_resume(struct kfd_dev *kfd, bool run_pm)
> >>>   {
> >>>       return 0;
> >>>   }
> >>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
> >>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
> >>> index 0fa898d30207..3dce4a51e522 100644
> >>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
> >>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
> >>> @@ -123,8 +123,8 @@ struct amdkfd_process_info {
> >>>   int amdgpu_amdkfd_init(void);
> >>>   void amdgpu_amdkfd_fini(void);
> >>>   -void amdgpu_amdkfd_suspend(struct amdgpu_device *adev);
> >>> -int amdgpu_amdkfd_resume(struct amdgpu_device *adev);
> >>> +void amdgpu_amdkfd_suspend(struct amdgpu_device *adev, bool run_pm);
> >>> +int amdgpu_amdkfd_resume(struct amdgpu_device *adev, bool run_pm);
> >>>   void amdgpu_amdkfd_interrupt(struct amdgpu_device *adev,
> >>>               const void *ih_ring_entry);
> >>>   void amdgpu_amdkfd_device_probe(struct amdgpu_device *adev);
> >>> @@ -250,8 +250,8 @@ bool kgd2kfd_device_init(struct kfd_dev *kfd,
> >>>                struct drm_device *ddev,
> >>>                const struct kgd2kfd_shared_resources *gpu_resources);
> >>>   void kgd2kfd_device_exit(struct kfd_dev *kfd);
> >>> -void kgd2kfd_suspend(struct kfd_dev *kfd);
> >>> -int kgd2kfd_resume(struct kfd_dev *kfd);
> >>> +void kgd2kfd_suspend(struct kfd_dev *kfd, bool run_pm);
> >>> +int kgd2kfd_resume(struct kfd_dev *kfd, bool run_pm);
> >>>   int kgd2kfd_pre_reset(struct kfd_dev *kfd);
> >>>   int kgd2kfd_post_reset(struct kfd_dev *kfd);
> >>>   void kgd2kfd_interrupt(struct kfd_dev *kfd, const void
> >>> *ih_ring_entry);
> >>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> >>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> >>> index d9e5eac182d3..787d49e9f4de 100644
> >>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> >>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> >>> @@ -3314,7 +3314,7 @@ int amdgpu_device_suspend(struct drm_device
> >>> *dev, bool fbcon)
> >>>           }
> >>>       }
> >>>   -    amdgpu_amdkfd_suspend(adev);
> >>> +    amdgpu_amdkfd_suspend(adev, fbcon);
> >>
> >> The logic seems inverted here. There are four different pmops
> >> callbacks that use different values for this parameter:
> >>
> >> * amdgpu_pmops_suspend: true
> >> * amdgpu_pmops_freeze: true
> >> * amdgpu_pmops_poweroff: true
> >> * amdgpu_pmops_runtime_suspend: false
> >>
> >> It looks like runtime_suspend uses false, so you should pass the
> >> run_pm parameter as !fbcon.
> >
> > Ok. will fix in v2.
> >
> >
> >>
> >>
> >>>         amdgpu_ras_suspend(adev);
> >>>   @@ -3398,7 +3398,7 @@ int amdgpu_device_resume(struct drm_device
> >>> *dev, bool fbcon)
> >>>               }
> >>>           }
> >>>       }
> >>> -    r = amdgpu_amdkfd_resume(adev);
> >>> +    r = amdgpu_amdkfd_resume(adev, fbcon);
> >>>       if (r)
> >>>           return r;
> >>>   diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device.c
> >>> b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
> >>> index 2a9e40131735..e9f00c3a067a 100644
> >>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_device.c
> >>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
> >>> @@ -23,6 +23,7 @@
> >>>   #include <linux/bsearch.h>
> >>>   #include <linux/pci.h>
> >>>   #include <linux/slab.h>
> >>> +#include <linux/pm_runtime.h>
> >>>   #include "kfd_priv.h"
> >>>   #include "kfd_device_queue_manager.h"
> >>>   #include "kfd_pm4_headers_vi.h"
> >>> @@ -710,7 +711,7 @@ bool kgd2kfd_device_init(struct kfd_dev *kfd,
> >>>   void kgd2kfd_device_exit(struct kfd_dev *kfd)
> >>>   {
> >>>       if (kfd->init_complete) {
> >>> -        kgd2kfd_suspend(kfd);
> >>> +        kgd2kfd_suspend(kfd, true);
> >>>           device_queue_manager_uninit(kfd->dqm);
> >>>           kfd_interrupt_exit(kfd);
> >>>           kfd_topology_remove_device(kfd);
> >>> @@ -731,7 +732,7 @@ int kgd2kfd_pre_reset(struct kfd_dev *kfd)
> >>>         kfd->dqm->ops.pre_reset(kfd->dqm);
> >>>   -    kgd2kfd_suspend(kfd);
> >>> +    kgd2kfd_suspend(kfd, true);
> >>
> >> This should use false. This is not runtime PM.
> >>
> >>
> >>>         kfd_signal_reset_event(kfd);
> >>>       return 0;
> >>> @@ -765,21 +766,24 @@ bool kfd_is_locked(void)
> >>>       return  (atomic_read(&kfd_locked) > 0);
> >>>   }
> >>>   -void kgd2kfd_suspend(struct kfd_dev *kfd)
> >>> +void kgd2kfd_suspend(struct kfd_dev *kfd, bool run_pm)
> >>>   {
> >>>       if (!kfd->init_complete)
> >>>           return;
> >>>   -    /* For first KFD device suspend all the KFD processes */
> >>> -    if (atomic_inc_return(&kfd_locked) == 1)
> >>> -        kfd_suspend_all_processes();
> >>> +    /* for runtime suspend, skip locking kfd */
> >>> +    if (run_pm) {
> >>
> >> This should be done for the non-runtime PM case: if (!run_pm).
> >>
> >>
> >>> +        /* For first KFD device suspend all the KFD processes */
> >>> +        if (atomic_inc_return(&kfd_locked) == 1)
> >>> +            kfd_suspend_all_processes();
> >>> +    }
> >>>   +    pm_runtime_set_autosuspend_delay(kfd->ddev->dev, 5000);
> >>>       kfd->dqm->ops.stop(kfd->dqm);
> >>> -
> >>>       kfd_iommu_suspend(kfd);
> >>>   }
> >>>   -int kgd2kfd_resume(struct kfd_dev *kfd)
> >>> +int kgd2kfd_resume(struct kfd_dev *kfd, bool run_pm)
> >>>   {
> >>>       int ret, count;
> >>>   @@ -790,10 +794,13 @@ int kgd2kfd_resume(struct kfd_dev *kfd)
> >>>       if (ret)
> >>>           return ret;
> >>>   -    count = atomic_dec_return(&kfd_locked);
> >>> -    WARN_ONCE(count < 0, "KFD suspend / resume ref. error");
> >>> -    if (count == 0)
> >>> -        ret = kfd_resume_all_processes();
> >>> +    /* for runtime resume, skip unlocking kfd */
> >>> +    if (run_pm) {
> >>
> >> Same as above.
> >>
> >>
> >>> +        count = atomic_dec_return(&kfd_locked);
> >>> +        WARN_ONCE(count < 0, "KFD suspend / resume ref. error");
> >>> +        if (count == 0)
> >>> +            ret = kfd_resume_all_processes();
> >>> +    }
> >>>         return ret;
> >>>   }
> >>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_iommu.c
> >>> b/drivers/gpu/drm/amd/amdkfd/kfd_iommu.c
> >>> index 8d871514671e..6301d77ed3d6 100644
> >>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_iommu.c
> >>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_iommu.c
> >>> @@ -25,6 +25,7 @@
> >>>   #include <linux/slab.h>
> >>>   #include <linux/pci.h>
> >>>   #include <linux/amd-iommu.h>
> >>> +#include <linux/pm_runtime.h>
> >>>   #include "kfd_priv.h"
> >>>   #include "kfd_dbgmgr.h"
> >>>   #include "kfd_topology.h"
> >>> @@ -134,8 +135,10 @@ void kfd_iommu_unbind_process(struct
> >>> kfd_process *p)
> >>>       struct kfd_process_device *pdd;
> >>>         list_for_each_entry(pdd, &p->per_device_data, per_device_list)
> >>> -        if (pdd->bound == PDD_BOUND)
> >>> +        if (pdd->bound == PDD_BOUND) {
> >>>               amd_iommu_unbind_pasid(pdd->dev->pdev, p->pasid);
> >>> + pm_runtime_set_autosuspend_delay(pdd->dev->ddev->dev, 5000);
> >>
> >> I don't think this is the right place. This code should only run on
> >> APUs with IOMMUv2 enabled. Probably missing a check at the start of
> >> the function. On kernels with IOMMU disabled, this source file is not
> >> compiled at all.
> >>
> >> I think this code should go into kfd_process_destroy_pdds.
> >
> >
> > Ok. will fix in v2. So can we consider this as logical inverse of
> > bind_process_to_device?
> >
> >
> >>
> >>
> >>> +        }
> >>>   }
> >>>     /* Callback for process shutdown invoked by the IOMMU driver */
> >>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process.c
> >>> b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
> >>> index 25b90f70aecd..d19d5e97405c 100644
> >>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_process.c
> >>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
> >>> @@ -31,6 +31,7 @@
> >>>   #include <linux/compat.h>
> >>>   #include <linux/mman.h>
> >>>   #include <linux/file.h>
> >>> +#include <linux/pm_runtime.h>
> >>>   #include "amdgpu_amdkfd.h"
> >>>   #include "amdgpu.h"
> >>>   @@ -843,15 +844,27 @@ struct kfd_process_device
> >>> *kfd_bind_process_to_device(struct kfd_dev *dev,
> >>>           return ERR_PTR(-ENOMEM);
> >>>       }
> >>>   +    err = pm_runtime_get_sync(dev->ddev->dev);
> >>> +    pm_runtime_set_autosuspend_delay(dev->ddev->dev, 60000);
> >>
> >> Why are you using a different hard-coded delay (60s?) here?
> >
> >
> > It needs to be fixed. Explained above the reason for such deviation.
> >
> >
> >>
> >> Regards,
> >>   Felix
> >>
> >
> > Thanks
> > Rajneesh
> >
> >
> >>> +    if (err < 0)
> >>> +        return ERR_PTR(err);
> >>> +
> >>>       err = kfd_iommu_bind_process_to_device(pdd);
> >>>       if (err)
> >>> -        return ERR_PTR(err);
> >>> +        goto out;
> >>>         err = kfd_process_device_init_vm(pdd, NULL);
> >>>       if (err)
> >>> -        return ERR_PTR(err);
> >>> +        goto out;
> >>>   -    return pdd;
> >>> +out:
> >>> +    pm_runtime_mark_last_busy(dev->ddev->dev);
> >>> +    pm_runtime_put_autosuspend(dev->ddev->dev);
> >>> +
> >>> +    if (!err)
> >>> +        return pdd;
> >>> +    else
> >>> +        return ERR_PTR(err);
> >>>   }
> >>>     struct kfd_process_device *kfd_get_first_process_device_data(
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
