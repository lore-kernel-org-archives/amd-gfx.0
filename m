Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95B56C3DA4A
	for <amd-gfx@archiver.kernel.org>; Tue, 20 Aug 2024 15:29:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 47CA710E205;
	Tue, 20 Aug 2024 15:29:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="ULYzPflU";
	dkim-atps=neutral
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com
 [209.85.216.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5E8C310E205
 for <amd-gfx@lists.freedesktop.org>; Tue, 20 Aug 2024 15:29:29 +0000 (UTC)
Received: by mail-pj1-f51.google.com with SMTP id
 98e67ed59e1d1-2d3d4862712so860795a91.2
 for <amd-gfx@lists.freedesktop.org>; Tue, 20 Aug 2024 08:29:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1724167769; x=1724772569; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9uiekZEF8/7AHl0221glrU478KtiI0G2sNtiIzrrI38=;
 b=ULYzPflUIKBmKGHRhgK/0bK/Q3plRJvZykJssBgJQAfmF4dwMD3N70u+qSRiE2F3BQ
 mFEFCQlrL0FuWWFsu8klnH0uUBSetR/jRA7fkAR4hf+NJEByzcmaEgL/L44x27CsFWVW
 o3r3qPxP2o/3Arg/zdS4gHUHpFFjM/0wQ0xTsQjC1Z/g7ahUj25BwlATNj7d7HCzyGVk
 YmQDsptN0qxVTCoR9qTrRuNQFqj/ERXekhUIAeRPvE4vJUfBggRSqK6mT4tWY8GByN13
 0IVe5cU5aPhUcLYwEr8/szmkduVpCroyLKSUzsqdDnKWj9h5iF/mfO7l4URvY5ZSJCde
 IWOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724167769; x=1724772569;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=9uiekZEF8/7AHl0221glrU478KtiI0G2sNtiIzrrI38=;
 b=qEwmHoKv99SnpSgeRHe/9N1C+KiSWRFCcq4+7n4eyrsEdPlGn2FgDNXRY0ghv0xVsR
 aVhCn2b8YFV5Ud6o6B4aI0VfQH43nNm0KAGeIntn1Aq5xNo/qDeFoAHe/XJPI2g3ttUn
 j/erlTrgCgR809zzNRe76HPf6rizS78HtHmdLicnFDiaCFG4iB8a+Zuq2I6GeHa8A2us
 i929uacBPtTSEm4w92rs5pzX9b/dSiXzP7Az8Kg216CYbYbEczP2MEYOvOKcb/idfFuH
 bOClJGPLV3zBFkLFCKVlzlfEAWozGnaTNXc8Tg+4ukOsQ9KdOUPVGv+1E5cA2MBv41vo
 aXfQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXgQcYh2pPyrtNfXpb4Z60kadquMOX8n+dfuTJlu7tCZO9Nc3sBOGsbfnukVu6DvoxMd2H1Ge4fD4/BQ2hqZ2VWwVINfZCO/Q577irimg==
X-Gm-Message-State: AOJu0YwkbiDy9zZtD9AuD5EP/PgI/Af312P2Ou6ADsWDNIFarV81DGvI
 wLuW807fTgEubjU4pRM/OlwYAMN9i1yMrEiOAzrVAl/ifUpU1ZP/3ghympcntwHiRUcRCulhnT4
 u00CgU6dGsyqf6KpwkjXbQPZ7dhd2qw==
X-Google-Smtp-Source: AGHT+IHOYWVcIowM0NbEoAMt03DwdOcCVf2uiGGld2o5uYOme18B0yt02689TPWfiOcBZyC+HppBUhFkxbiiyMa1pdg=
X-Received: by 2002:a05:6a21:788e:b0:1c4:c007:51b7 with SMTP id
 adf61e73a8af0-1c9a2a456f3mr11799056637.6.1724167768513; Tue, 20 Aug 2024
 08:29:28 -0700 (PDT)
MIME-Version: 1.0
References: <20240819095331.460721-1-Trigger.Huang@amd.com>
 <20240819095331.460721-3-Trigger.Huang@amd.com>
 <a0978549-9bd3-e985-76eb-f50115f76bf4@amd.com>
 <SA1PR12MB7442E8D1DB91114A51FC9EB0FE8D2@SA1PR12MB7442.namprd12.prod.outlook.com>
 <CADnq5_MqZqWnd1ZL-O4vrKNCVuz6+fgp66BYNVw5y7iMbY-hyQ@mail.gmail.com>
 <2c894489-e32a-f143-5d9c-51916ce4f119@amd.com>
In-Reply-To: <2c894489-e32a-f143-5d9c-51916ce4f119@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 20 Aug 2024 11:29:17 -0400
Message-ID: <CADnq5_PU6Eoe+jOzw_C5SweoUHAM67WVER0xpGWFkoW34MwJ+A@mail.gmail.com>
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

On Tue, Aug 20, 2024 at 11:07=E2=80=AFAM Khatri, Sunil <sunil.khatri@amd.co=
m> wrote:
>
>
> On 8/20/2024 7:36 PM, Alex Deucher wrote:
> > On Tue, Aug 20, 2024 at 3:30=E2=80=AFAM Huang, Trigger <Trigger.Huang@a=
md.com> wrote:
> >> [AMD Official Use Only - AMD Internal Distribution Only]
> >>
> >>> -----Original Message-----
> >>> From: Khatri, Sunil <Sunil.Khatri@amd.com>
> >>> Sent: Monday, August 19, 2024 6:31 PM
> >>> To: Huang, Trigger <Trigger.Huang@amd.com>; amd-gfx@lists.freedesktop=
.org
> >>> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>
> >>> Subject: Re: [PATCH 2/2] drm/amdgpu: Do core dump immediately when jo=
b
> >>> tmo
> >>>
> >>>
> >>> On 8/19/2024 3:23 PM, Trigger.Huang@amd.com wrote:
> >>>> From: Trigger Huang <Trigger.Huang@amd.com>
> >>>>
> >>>> Do the coredump immediately after a job timeout to get a closer
> >>>> representation of GPU's error status.
> >>>>
> >>>> V2: This will skip printing vram_lost as the GPU reset is not happen=
ed
> >>>> yet (Alex)
> >>>>
> >>>> V3: Unconditionally call the core dump as we care about all the rese=
t
> >>>> functions(soft-recovery and queue reset and full adapter reset, Alex=
)
> >>>>
> >>>> Signed-off-by: Trigger Huang <Trigger.Huang@amd.com>
> >>>> ---
> >>>>    drivers/gpu/drm/amd/amdgpu/amdgpu_job.c | 62
> >>> +++++++++++++++++++++++++
> >>>>    1 file changed, 62 insertions(+)
> >>>>
> >>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
> >>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
> >>>> index c6a1783fc9ef..ebbb1434073e 100644
> >>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
> >>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
> >>>> @@ -30,6 +30,61 @@
> >>>>    #include "amdgpu.h"
> >>>>    #include "amdgpu_trace.h"
> >>>>    #include "amdgpu_reset.h"
> >>>> +#include "amdgpu_dev_coredump.h"
> >>>> +#include "amdgpu_xgmi.h"
> >>>> +
> >>>> +static void amdgpu_job_do_core_dump(struct amdgpu_device *adev,
> >>>> +                               struct amdgpu_job *job)
> >>>> +{
> >>>> +   int i;
> >>>> +
> >>>> +   dev_info(adev->dev, "Dumping IP State\n");
> >>>> +   for (i =3D 0; i < adev->num_ip_blocks; i++) {
> >>>> +           if (adev->ip_blocks[i].version->funcs->dump_ip_state)
> >>>> +                   adev->ip_blocks[i].version->funcs
> >>>> +                           ->dump_ip_state((void *)adev);
> >>>> +           dev_info(adev->dev, "Dumping IP State Completed\n");
> >>>> +   }
> >>>> +
> >>>> +   amdgpu_coredump(adev, true, false, job); }
> >>>> +
> >>>> +static void amdgpu_job_core_dump(struct amdgpu_device *adev,
> >>>> +                            struct amdgpu_job *job)
> >>>> +{
> >>>> +   struct list_head device_list, *device_list_handle =3D  NULL;
> >>>> +   struct amdgpu_device *tmp_adev =3D NULL;
> >>>> +   struct amdgpu_hive_info *hive =3D NULL;
> >>>> +
> >>>> +   if (!amdgpu_sriov_vf(adev))
> >>>> +           hive =3D amdgpu_get_xgmi_hive(adev);
> >>>> +   if (hive)
> >>>> +           mutex_lock(&hive->hive_lock);
> >>>> +   /*
> >>>> +    * Reuse the logic in amdgpu_device_gpu_recover() to build list =
of
> >>>> +    * devices for code dump
> >>>> +    */
> >>>> +   INIT_LIST_HEAD(&device_list);
> >>>> +   if (!amdgpu_sriov_vf(adev) && (adev-
> >>>> gmc.xgmi.num_physical_nodes > 1) && hive) {
> >>>> +           list_for_each_entry(tmp_adev, &hive->device_list,
> >>> gmc.xgmi.head)
> >>>> +                   list_add_tail(&tmp_adev->reset_list, &device_lis=
t);
> >>>> +           if (!list_is_first(&adev->reset_list, &device_list))
> >>>> +                   list_rotate_to_front(&adev->reset_list, &device_=
list);
> >>>> +           device_list_handle =3D &device_list;
> >>>> +   } else {
> >>>> +           list_add_tail(&adev->reset_list, &device_list);
> >>>> +           device_list_handle =3D &device_list;
> >>>> +   }
> >>>> +
> >>>> +   /* Do the coredump for each device */
> >>>> +   list_for_each_entry(tmp_adev, device_list_handle, reset_list)
> >>>> +           amdgpu_job_do_core_dump(tmp_adev, job);
> >>>> +
> >>>> +   if (hive) {
> >>>> +           mutex_unlock(&hive->hive_lock);
> >>>> +           amdgpu_put_xgmi_hive(hive);
> >>>> +   }
> >>>> +}
> >>>>
> >>>>    static enum drm_gpu_sched_stat amdgpu_job_timedout(struct
> >>> drm_sched_job *s_job)
> >>>>    {
> >>>> @@ -48,6 +103,7 @@ static enum drm_gpu_sched_stat
> >>> amdgpu_job_timedout(struct drm_sched_job *s_job)
> >>>>              return DRM_GPU_SCHED_STAT_ENODEV;
> >>>>      }
> >>>>
> >>>> +   amdgpu_job_core_dump(adev, job);
> >>> The philosophy is hang and recovery is to let the HW and software try=
 to
> >>> recover. Here we try to do a soft recovery first and i think we shoul=
d wait for
> >>> seft recovery and if fails then we do dump and thats exactly we are d=
oing here.
> >> Hi Sunil ,
> >> thanks for the suggestion, and that's reasonable. But my concern is th=
at after soft recovery happened, the GPU's status may change(take gfx 9 for=
 example, it will try to kill the current hang wave)
> >>   Actually, in most cases, a real shader hang cannot be resolved throu=
gh soft recovery, and at that moment, we need to get a very close dump/snap=
shot/representation of GPU's current error status.
> >> Just like the scandump, when we trying to do a scandump for a shader h=
ang, we will disable gpu_recovery, and no soft recovery/per-queue reset/HW =
reset will happen before the scandump, right?
> >> On most products, there are no scandump interfaces, so core dump is ev=
en more important for debugging GPU hang issue.
> > I agree that it makes sense to take the dump as early as possible.  It
> > makes sense to move it up now that we are starting to have finer
> > grained resets.  We may want to wire devcoredump into the KFD side as
> > well at some point.
> In the current implementation we do stop the Scheduler and wait for
> existing fences to complete or signal them. But the new place to dump
> will not have anything like that and even though we have timeout some of
> the threads or waves might be still progressing the IP dump might be
> changing during that time.

Sure, but that is all sw state.  It shouldn't affect the hw state.  Or
if it does, it would be indirect.  E.g., signalling a fence might
unblock a dependent job, but the root issue would still be valid.

>
> But i am not sure if we want to stop the scheduling of new tasks and end
> the existing one.  How about we have multiple level of dumps i.e just
> capture and not dump as first dump is what is captured not last.
> a. Capture after soft reset and let it be overwritten by next level
> b. After soft reset fails capture again before hard reset is triggered.
>
> So eventually we would have the ip dump file generated of what we are
> interested in.

It might make more sense to slice and dice the dumps more finely, but
I think we'll need to see how things work out as is before we worry
about those details.

Alex

>
> Regards
> Sunil K
>
>
>
> >
> > Alex
> >
> >> Regards,
> >> Trigger
> >>
> >>> Also we need to make sure that the tasks which are already in queue a=
re put
> >>> on hold and the their sync points are signalled before we dump.
> >>> check once what all steps are taken before we dump in the current
> >>> implementation.
> >> Do you mean sometimes like:
> >>          drm_sched_wqueue_stop(&ring->sched);
> >>          amdgpu_fence_driver_force_completion(ring); // Since there is=
 no GPU reset happened, is it reasonable to call it here?
> >>          amdgpu_job_core_dump(adev, job);
> >>
> >>
> >> Regards,
> >> Trigger
> >>
> >>> Regards
> >>>
> >>> Sunil khatri
> >>>
> >>>>      adev->job_hang =3D true;
> >>>>
> >>>> @@ -101,6 +157,12 @@ static enum drm_gpu_sched_stat
> >>> amdgpu_job_timedout(struct drm_sched_job *s_job)
> >>>>              reset_context.src =3D AMDGPU_RESET_SRC_JOB;
> >>>>              clear_bit(AMDGPU_NEED_FULL_RESET, &reset_context.flags)=
;
> >>>>
> >>>> +           /*
> >>>> +            * To avoid an unnecessary extra coredump, as we have
> >>> already
> >>>> +            * got the very close representation of GPU's error stat=
us
> >>>> +            */
> >>>> +           set_bit(AMDGPU_SKIP_COREDUMP, &reset_context.flags);
> >>>> +
> >>>>              r =3D amdgpu_device_gpu_recover(ring->adev, job,
> >>> &reset_context);
> >>>>              if (r)
> >>>>                      dev_err(adev->dev, "GPU Recovery Failed: %d\n",=
 r);
