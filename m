Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C2DEC531DC
	for <amd-gfx@archiver.kernel.org>; Tue, 20 Aug 2024 16:01:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3A4B010E3FF;
	Tue, 20 Aug 2024 16:01:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="dmc0+8NH";
	dkim-atps=neutral
Received: from mail-oo1-f47.google.com (mail-oo1-f47.google.com
 [209.85.161.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 20E8010E3FF
 for <amd-gfx@lists.freedesktop.org>; Tue, 20 Aug 2024 16:01:43 +0000 (UTC)
Received: by mail-oo1-f47.google.com with SMTP id
 006d021491bc7-5da8c4a88fbso171800eaf.1
 for <amd-gfx@lists.freedesktop.org>; Tue, 20 Aug 2024 09:01:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1724169702; x=1724774502; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hUDhtDrKbS1vUh2slRjlKT/9BR3G+AHSPf8s46J6fAo=;
 b=dmc0+8NHTpwaj0afAQce7U6xlEcmeUrAQFJeCAZi5SHnY47v18KlKw5wB8rQmiw313
 hCc8rsLgjwiAk9OsUQpX4YQJAY4A4Li/uZ6XKgpDmH1o/k/Tcnjg1NBFAVwrKcR0xTPS
 yirXfFmiAHS6kaRbaiOm+EaZYugxMbkwjy7tUoLmdRZswPNMOlkmr5v3N9y7qQtmMLu4
 9zWnUJb5x77W8ZYhblwqmzvWrdvXK7oyWgXkeyqO2fJd+Ng1giduMLg6GSqYliELMKJB
 l3Pej8sTh5bCsZht5A/tLTxUIvDYnC/5gQcSLhTT/wio+IJjIe1e8CAPQOESmmjIQZdl
 t+5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724169702; x=1724774502;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=hUDhtDrKbS1vUh2slRjlKT/9BR3G+AHSPf8s46J6fAo=;
 b=vRLDNpyuphLlRa0BWC1UK3y6+89xYEbTeKAy2n9RQ3iiMRs/IQZa0XPqBIaQ12Hb34
 8clE1wM+y6y9mdqww9hKz7cxPX5K/aw95FmC5vYqMOL2cACta9Gqskr8mJ1/p317Cddu
 /lRxVYehFbG45keoXCguqFDN6ELe3V4dAP2C31lyLO0oeJhQJK0E64yT81Q3/+ZNzd6F
 GI7A3Q+KMJ1xuKu+raDJPlfrfvLkyctrrLUurLbQLUQvSrdMWJhfJhlgd8vitG6/EYKH
 liJ840ARxCCzBcWvf96UmjODIZlnAGXMzzG9r8uO6XoG94Y6vc1PEwhhNBZ1mac2Kwno
 8Lxg==
X-Forwarded-Encrypted: i=1;
 AJvYcCX+NQE55EvwCjaXP75jZOJFxIbWBPkOlWhCco3JDdduuB4AR00xg9W9sYCMN7GBzISYhFeD/xXu@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzjNtgDiMVuRVvyAzrS0+yXoO+/Ud7GyCZ5a3lCwTSMZ4/t71E8
 iflVsOHgyS++XQ8VeFbIcIlAcOXkcoZ1ud7r2MM2QGzxMGGTBAsI3D4gpAzQUqbiggnlnR5Sjpc
 tS7B5uRD62UNSyhTSopli2scgVXs=
X-Google-Smtp-Source: AGHT+IEOd7qWfZTPsPthiFYFhcdLoznyyULGqSAaixIM8bN4KONyVogaqBsHU97e4iYSs7oe56GPxML5UOU/YZyz8Ao=
X-Received: by 2002:a05:6218:260f:b0:1ac:2b8b:a185 with SMTP id
 e5c5f4694b2df-1b39611d1ddmr912787155d.2.1724169701660; Tue, 20 Aug 2024
 09:01:41 -0700 (PDT)
MIME-Version: 1.0
References: <20240819095331.460721-1-Trigger.Huang@amd.com>
 <20240819095331.460721-3-Trigger.Huang@amd.com>
 <a0978549-9bd3-e985-76eb-f50115f76bf4@amd.com>
 <SA1PR12MB7442E8D1DB91114A51FC9EB0FE8D2@SA1PR12MB7442.namprd12.prod.outlook.com>
 <cc16efe1-5de5-20bb-8556-143a121de6d0@amd.com>
In-Reply-To: <cc16efe1-5de5-20bb-8556-143a121de6d0@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 20 Aug 2024 12:01:27 -0400
Message-ID: <CADnq5_P4XQ_v_fJP=p8-5dVTBNC5UxUfEU2gYkwkbzQbqte62g@mail.gmail.com>
Subject: Re: [PATCH 2/2] drm/amdgpu: Do core dump immediately when job tmo
To: "Khatri, Sunil" <sunil.khatri@amd.com>
Cc: "Huang, Trigger" <Trigger.Huang@amd.com>, 
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, 
 "Deucher, Alexander" <Alexander.Deucher@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

On Tue, Aug 20, 2024 at 11:31=E2=80=AFAM Khatri, Sunil <sunil.khatri@amd.co=
m> wrote:
>
>
> On 8/20/2024 1:00 PM, Huang, Trigger wrote:
> > [AMD Official Use Only - AMD Internal Distribution Only]
> >
> >> -----Original Message-----
> >> From: Khatri, Sunil <Sunil.Khatri@amd.com>
> >> Sent: Monday, August 19, 2024 6:31 PM
> >> To: Huang, Trigger <Trigger.Huang@amd.com>; amd-gfx@lists.freedesktop.=
org
> >> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>
> >> Subject: Re: [PATCH 2/2] drm/amdgpu: Do core dump immediately when job
> >> tmo
> >>
> >>
> >> On 8/19/2024 3:23 PM, Trigger.Huang@amd.com wrote:
> >>> From: Trigger Huang <Trigger.Huang@amd.com>
> >>>
> >>> Do the coredump immediately after a job timeout to get a closer
> >>> representation of GPU's error status.
> >>>
> >>> V2: This will skip printing vram_lost as the GPU reset is not happene=
d
> >>> yet (Alex)
> >>>
> >>> V3: Unconditionally call the core dump as we care about all the reset
> >>> functions(soft-recovery and queue reset and full adapter reset, Alex)
> >>>
> >>> Signed-off-by: Trigger Huang <Trigger.Huang@amd.com>
> >>> ---
> >>>    drivers/gpu/drm/amd/amdgpu/amdgpu_job.c | 62
> >> +++++++++++++++++++++++++
> >>>    1 file changed, 62 insertions(+)
> >>>
> >>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
> >>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
> >>> index c6a1783fc9ef..ebbb1434073e 100644
> >>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
> >>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
> >>> @@ -30,6 +30,61 @@
> >>>    #include "amdgpu.h"
> >>>    #include "amdgpu_trace.h"
> >>>    #include "amdgpu_reset.h"
> >>> +#include "amdgpu_dev_coredump.h"
> >>> +#include "amdgpu_xgmi.h"
> >>> +
> >>> +static void amdgpu_job_do_core_dump(struct amdgpu_device *adev,
> >>> +                               struct amdgpu_job *job)
> >>> +{
> >>> +   int i;
> >>> +
> >>> +   dev_info(adev->dev, "Dumping IP State\n");
> >>> +   for (i =3D 0; i < adev->num_ip_blocks; i++) {
> >>> +           if (adev->ip_blocks[i].version->funcs->dump_ip_state)
> >>> +                   adev->ip_blocks[i].version->funcs
> >>> +                           ->dump_ip_state((void *)adev);
> >>> +           dev_info(adev->dev, "Dumping IP State Completed\n");
> >>> +   }
> >>> +
> >>> +   amdgpu_coredump(adev, true, false, job); }
> >>> +
> >>> +static void amdgpu_job_core_dump(struct amdgpu_device *adev,
> >>> +                            struct amdgpu_job *job)
> >>> +{
> >>> +   struct list_head device_list, *device_list_handle =3D  NULL;
> >>> +   struct amdgpu_device *tmp_adev =3D NULL;
> >>> +   struct amdgpu_hive_info *hive =3D NULL;
> >>> +
> >>> +   if (!amdgpu_sriov_vf(adev))
> >>> +           hive =3D amdgpu_get_xgmi_hive(adev);
> >>> +   if (hive)
> >>> +           mutex_lock(&hive->hive_lock);
> >>> +   /*
> >>> +    * Reuse the logic in amdgpu_device_gpu_recover() to build list o=
f
> >>> +    * devices for code dump
> >>> +    */
> >>> +   INIT_LIST_HEAD(&device_list);
> >>> +   if (!amdgpu_sriov_vf(adev) && (adev-
> >>> gmc.xgmi.num_physical_nodes > 1) && hive) {
> >>> +           list_for_each_entry(tmp_adev, &hive->device_list,
> >> gmc.xgmi.head)
> >>> +                   list_add_tail(&tmp_adev->reset_list, &device_list=
);
> >>> +           if (!list_is_first(&adev->reset_list, &device_list))
> >>> +                   list_rotate_to_front(&adev->reset_list, &device_l=
ist);
> >>> +           device_list_handle =3D &device_list;
> >>> +   } else {
> >>> +           list_add_tail(&adev->reset_list, &device_list);
> >>> +           device_list_handle =3D &device_list;
> >>> +   }
> >>> +
> >>> +   /* Do the coredump for each device */
> >>> +   list_for_each_entry(tmp_adev, device_list_handle, reset_list)
> >>> +           amdgpu_job_do_core_dump(tmp_adev, job);
> >>> +
> >>> +   if (hive) {
> >>> +           mutex_unlock(&hive->hive_lock);
> >>> +           amdgpu_put_xgmi_hive(hive);
> >>> +   }
> >>> +}
> >>>
> >>>    static enum drm_gpu_sched_stat amdgpu_job_timedout(struct
> >> drm_sched_job *s_job)
> >>>    {
> >>> @@ -48,6 +103,7 @@ static enum drm_gpu_sched_stat
> >> amdgpu_job_timedout(struct drm_sched_job *s_job)
> >>>              return DRM_GPU_SCHED_STAT_ENODEV;
> >>>      }
> >>>
> >>> +   amdgpu_job_core_dump(adev, job);
> >> The philosophy is hang and recovery is to let the HW and software try =
to
> >> recover. Here we try to do a soft recovery first and i think we should=
 wait for
> >> seft recovery and if fails then we do dump and thats exactly we are do=
ing here.
> > Hi Sunil ,
> > thanks for the suggestion, and that's reasonable. But my concern is tha=
t after soft recovery happened, the GPU's status may change(take gfx 9 for =
example, it will try to kill the current hang wave)
> >   Actually, in most cases, a real shader hang cannot be resolved throug=
h soft recovery, and at that moment, we need to get a very close dump/snaps=
hot/representation of GPU's current error status.
> > Just like the scandump, when we trying to do a scandump for a shader ha=
ng, we will disable gpu_recovery, and no soft recovery/per-queue reset/HW r=
eset will happen before the scandump, right?
> > On most products, there are no scandump interfaces, so core dump is eve=
n more important for debugging GPU hang issue.
> >
> > Regards,
> > Trigger
> >
> >> Also we need to make sure that the tasks which are already in queue ar=
e put
> >> on hold and the their sync points are signalled before we dump.
> >> check once what all steps are taken before we dump in the current
> >> implementation.
> > Do you mean sometimes like:
> >          drm_sched_wqueue_stop(&ring->sched);
> >          amdgpu_fence_driver_force_completion(ring); // Since there is =
no GPU reset happened, is it reasonable to call it here?
> >          amdgpu_job_core_dump(adev, job);
> Before hard reset we do all those things. But i guess we may not need
> that in case we capturing before soft reset itself but you need to test
> it, to see the dump values are true or not.
> Also apart from hardware state we dump a lot of other information like
> ring buffers and in case jobs are still submitting we might be not able
> to get the right data as the ring might be in use and being
> consumed/filled up that time and that's why scheduler stop helps. But in
> case soft reset is successful we do not want to do that.
>
> So here is what i think but Alex please suggest if it make sense.
> If recovery is disabled : Capture ip dump before soft reset. (Give close
> register state but ring buffer need to be seen as it is in use as
> scheduler is running)
> if recovery is enabled : capture ip dump (Current implementation make
> sure to disable drm sched and fence time out)

I think Trigger's proposed logic makes sense.  I don't see a reason
not to dump earlier if we can.  I don't really see what it buys us to
have different behavior depending on whether or not recovery is
enabled.  If per queue resets are successful, then we'd miss the dump
in that case.  If we only dump in job_timedout, then we'd miss the
dump when there is a reset due to something the kernel driver or KFD
has done.

I think what we want is for job_timedout or the similar logic on the
KFD side to call the coredump code when we detect a stuck queue.
We'll need to keep the codedump code in gpu_recover to cover the cases
where we need to reset due to something outside of the user submission
paths.

Alex

>
> function ptr print ip state could be called to capture dump when its
> needed in both above cases. Right now print is called when dump is
> actually dumped which is when data file which is generated in
> devcoredump is read.
>
> Regards
> Sunil Khatri
>
>
> > Regards,
> > Trigger
> >
> >> Regards
> >>
> >> Sunil khatri
> >>
> >>>      adev->job_hang =3D true;
> >>>
> >>> @@ -101,6 +157,12 @@ static enum drm_gpu_sched_stat
> >> amdgpu_job_timedout(struct drm_sched_job *s_job)
> >>>              reset_context.src =3D AMDGPU_RESET_SRC_JOB;
> >>>              clear_bit(AMDGPU_NEED_FULL_RESET, &reset_context.flags);
> >>>
> >>> +           /*
> >>> +            * To avoid an unnecessary extra coredump, as we have
> >> already
> >>> +            * got the very close representation of GPU's error statu=
s
> >>> +            */
> >>> +           set_bit(AMDGPU_SKIP_COREDUMP, &reset_context.flags);
> >>> +
> >>>              r =3D amdgpu_device_gpu_recover(ring->adev, job,
> >> &reset_context);
> >>>              if (r)
> >>>                      dev_err(adev->dev, "GPU Recovery Failed: %d\n", =
r);
