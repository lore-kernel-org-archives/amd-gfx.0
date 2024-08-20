Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20DF8C3DA4A
	for <amd-gfx@archiver.kernel.org>; Tue, 20 Aug 2024 14:06:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C345610E12F;
	Tue, 20 Aug 2024 14:06:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="dYk5e1dV";
	dkim-atps=neutral
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com
 [209.85.216.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 131F810E12F
 for <amd-gfx@lists.freedesktop.org>; Tue, 20 Aug 2024 14:06:52 +0000 (UTC)
Received: by mail-pj1-f41.google.com with SMTP id
 98e67ed59e1d1-2d3ed48c748so822065a91.3
 for <amd-gfx@lists.freedesktop.org>; Tue, 20 Aug 2024 07:06:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1724162811; x=1724767611; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=S+0gAvJfhLTxg9QrIx+l9onPxAT/VrUqatjQDd8oEDw=;
 b=dYk5e1dVZCC6d7PDE0lJaexMuuWtBK7C1P+2Zb5O4QE5+XTNiQgWgljL6CNjpkUizF
 l7WuWFyEuykffWhAeSg1uVryYdBMfSYZuw95vt3yKTQw+HZlLe5GbiEb4ckSZkEZetsX
 eWwc2upSuJSAxHLtLHkkh2gmUjFqGM60zKO/bf2Xj2j9xoemgFiFuTrU9QkIGWSF0BU4
 QrnMSU3mrDeM4+V1Uknl7m5ZD3wrBDp38f+bufM8wCrmleILr+iskiM/LceC5mx/otsC
 tI7jLcYpKIhmKc5NM+Xs5/ctW9aZ17ED5pqUFxyPrfL1wttjoYc2Q8uyR1U5hZGMKLiy
 y4nA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724162811; x=1724767611;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=S+0gAvJfhLTxg9QrIx+l9onPxAT/VrUqatjQDd8oEDw=;
 b=Rr9r69g+cW3k+AlYWv7ytkuJFXTDcECFAc34LJ69imjBysoEQIw155ca4H5p2QcZWv
 pt154etThRSxZ1MXph1tP8hMPkDnvB+fTItBOHU9Y+DcAdZ2VSWSMiUMSA3fk7CwHxOQ
 04bZVSqpvfyM+yD6tLH3qUcK5Ki5QsheaNPgM6sJTTl9VFZDJJISyDEh5V+E5bMVhDv5
 OL/CZeeCSdnND9BN37pfAbUNKwCtODy5FoRD5TgN3VTfSpnePap8y8rjYMLpOBbzdYxa
 jNNRvly68Jq36HOvZk4NWKIVSLqzflw0p1VEOt5IL/CNpm85oE5rn9m+EJmD52j7OgJq
 eg2A==
X-Forwarded-Encrypted: i=1;
 AJvYcCWBhiXFsHvS8+tm1M88l92olXFjvScS1N2EeL6uKIe7LxFjoAE0EychsiE0Jyv4TkC1EjZaXRdA@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxcYR94jZwcvKD+4xiQAD0wfuCtfoDq43uNu/HmPBTcRa+YLc9v
 DVyoEvCyMnBRGp5jDeID0hfMoIPIZG9h81PlSJ54KUM226MXxzjOG4nfiyyEiqDfclA0KUroCop
 tTlwVguQqxyQTszUXqNESrufKNIf6Cg==
X-Google-Smtp-Source: AGHT+IHO7eIjgIZ5UAc/h1BZmH9SD5gjQ89tFNQr1i3q6NIeOF2XefmU5xxhorJcX2J1ilJxpOqJC1j/CgRihIZoUU8=
X-Received: by 2002:a17:90a:ea0f:b0:2d3:cbf8:ec5f with SMTP id
 98e67ed59e1d1-2d3e086a899mr8926767a91.6.1724162811151; Tue, 20 Aug 2024
 07:06:51 -0700 (PDT)
MIME-Version: 1.0
References: <20240819095331.460721-1-Trigger.Huang@amd.com>
 <20240819095331.460721-3-Trigger.Huang@amd.com>
 <a0978549-9bd3-e985-76eb-f50115f76bf4@amd.com>
 <SA1PR12MB7442E8D1DB91114A51FC9EB0FE8D2@SA1PR12MB7442.namprd12.prod.outlook.com>
In-Reply-To: <SA1PR12MB7442E8D1DB91114A51FC9EB0FE8D2@SA1PR12MB7442.namprd12.prod.outlook.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 20 Aug 2024 10:06:38 -0400
Message-ID: <CADnq5_MqZqWnd1ZL-O4vrKNCVuz6+fgp66BYNVw5y7iMbY-hyQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] drm/amdgpu: Do core dump immediately when job tmo
To: "Huang, Trigger" <Trigger.Huang@amd.com>
Cc: "Khatri, Sunil" <Sunil.Khatri@amd.com>, 
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

On Tue, Aug 20, 2024 at 3:30=E2=80=AFAM Huang, Trigger <Trigger.Huang@amd.c=
om> wrote:
>
> [AMD Official Use Only - AMD Internal Distribution Only]
>
> > -----Original Message-----
> > From: Khatri, Sunil <Sunil.Khatri@amd.com>
> > Sent: Monday, August 19, 2024 6:31 PM
> > To: Huang, Trigger <Trigger.Huang@amd.com>; amd-gfx@lists.freedesktop.o=
rg
> > Cc: Deucher, Alexander <Alexander.Deucher@amd.com>
> > Subject: Re: [PATCH 2/2] drm/amdgpu: Do core dump immediately when job
> > tmo
> >
> >
> > On 8/19/2024 3:23 PM, Trigger.Huang@amd.com wrote:
> > > From: Trigger Huang <Trigger.Huang@amd.com>
> > >
> > > Do the coredump immediately after a job timeout to get a closer
> > > representation of GPU's error status.
> > >
> > > V2: This will skip printing vram_lost as the GPU reset is not happene=
d
> > > yet (Alex)
> > >
> > > V3: Unconditionally call the core dump as we care about all the reset
> > > functions(soft-recovery and queue reset and full adapter reset, Alex)
> > >
> > > Signed-off-by: Trigger Huang <Trigger.Huang@amd.com>
> > > ---
> > >   drivers/gpu/drm/amd/amdgpu/amdgpu_job.c | 62
> > +++++++++++++++++++++++++
> > >   1 file changed, 62 insertions(+)
> > >
> > > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
> > > b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
> > > index c6a1783fc9ef..ebbb1434073e 100644
> > > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
> > > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
> > > @@ -30,6 +30,61 @@
> > >   #include "amdgpu.h"
> > >   #include "amdgpu_trace.h"
> > >   #include "amdgpu_reset.h"
> > > +#include "amdgpu_dev_coredump.h"
> > > +#include "amdgpu_xgmi.h"
> > > +
> > > +static void amdgpu_job_do_core_dump(struct amdgpu_device *adev,
> > > +                               struct amdgpu_job *job)
> > > +{
> > > +   int i;
> > > +
> > > +   dev_info(adev->dev, "Dumping IP State\n");
> > > +   for (i =3D 0; i < adev->num_ip_blocks; i++) {
> > > +           if (adev->ip_blocks[i].version->funcs->dump_ip_state)
> > > +                   adev->ip_blocks[i].version->funcs
> > > +                           ->dump_ip_state((void *)adev);
> > > +           dev_info(adev->dev, "Dumping IP State Completed\n");
> > > +   }
> > > +
> > > +   amdgpu_coredump(adev, true, false, job); }
> > > +
> > > +static void amdgpu_job_core_dump(struct amdgpu_device *adev,
> > > +                            struct amdgpu_job *job)
> > > +{
> > > +   struct list_head device_list, *device_list_handle =3D  NULL;
> > > +   struct amdgpu_device *tmp_adev =3D NULL;
> > > +   struct amdgpu_hive_info *hive =3D NULL;
> > > +
> > > +   if (!amdgpu_sriov_vf(adev))
> > > +           hive =3D amdgpu_get_xgmi_hive(adev);
> > > +   if (hive)
> > > +           mutex_lock(&hive->hive_lock);
> > > +   /*
> > > +    * Reuse the logic in amdgpu_device_gpu_recover() to build list o=
f
> > > +    * devices for code dump
> > > +    */
> > > +   INIT_LIST_HEAD(&device_list);
> > > +   if (!amdgpu_sriov_vf(adev) && (adev-
> > >gmc.xgmi.num_physical_nodes > 1) && hive) {
> > > +           list_for_each_entry(tmp_adev, &hive->device_list,
> > gmc.xgmi.head)
> > > +                   list_add_tail(&tmp_adev->reset_list, &device_list=
);
> > > +           if (!list_is_first(&adev->reset_list, &device_list))
> > > +                   list_rotate_to_front(&adev->reset_list, &device_l=
ist);
> > > +           device_list_handle =3D &device_list;
> > > +   } else {
> > > +           list_add_tail(&adev->reset_list, &device_list);
> > > +           device_list_handle =3D &device_list;
> > > +   }
> > > +
> > > +   /* Do the coredump for each device */
> > > +   list_for_each_entry(tmp_adev, device_list_handle, reset_list)
> > > +           amdgpu_job_do_core_dump(tmp_adev, job);
> > > +
> > > +   if (hive) {
> > > +           mutex_unlock(&hive->hive_lock);
> > > +           amdgpu_put_xgmi_hive(hive);
> > > +   }
> > > +}
> > >
> > >   static enum drm_gpu_sched_stat amdgpu_job_timedout(struct
> > drm_sched_job *s_job)
> > >   {
> > > @@ -48,6 +103,7 @@ static enum drm_gpu_sched_stat
> > amdgpu_job_timedout(struct drm_sched_job *s_job)
> > >             return DRM_GPU_SCHED_STAT_ENODEV;
> > >     }
> > >
> > > +   amdgpu_job_core_dump(adev, job);
> > The philosophy is hang and recovery is to let the HW and software try t=
o
> > recover. Here we try to do a soft recovery first and i think we should =
wait for
> > seft recovery and if fails then we do dump and thats exactly we are doi=
ng here.
>
> Hi Sunil ,
> thanks for the suggestion, and that's reasonable. But my concern is that =
after soft recovery happened, the GPU's status may change(take gfx 9 for ex=
ample, it will try to kill the current hang wave)
>  Actually, in most cases, a real shader hang cannot be resolved through s=
oft recovery, and at that moment, we need to get a very close dump/snapshot=
/representation of GPU's current error status.
> Just like the scandump, when we trying to do a scandump for a shader hang=
, we will disable gpu_recovery, and no soft recovery/per-queue reset/HW res=
et will happen before the scandump, right?
> On most products, there are no scandump interfaces, so core dump is even =
more important for debugging GPU hang issue.

I agree that it makes sense to take the dump as early as possible.  It
makes sense to move it up now that we are starting to have finer
grained resets.  We may want to wire devcoredump into the KFD side as
well at some point.

Alex

>
> Regards,
> Trigger
>
> >
> > Also we need to make sure that the tasks which are already in queue are=
 put
> > on hold and the their sync points are signalled before we dump.
> > check once what all steps are taken before we dump in the current
> > implementation.
>
> Do you mean sometimes like:
>         drm_sched_wqueue_stop(&ring->sched);
>         amdgpu_fence_driver_force_completion(ring); // Since there is no =
GPU reset happened, is it reasonable to call it here?
>         amdgpu_job_core_dump(adev, job);
>
>
> Regards,
> Trigger
>
> >
> > Regards
> >
> > Sunil khatri
> >
> > >
> > >     adev->job_hang =3D true;
> > >
> > > @@ -101,6 +157,12 @@ static enum drm_gpu_sched_stat
> > amdgpu_job_timedout(struct drm_sched_job *s_job)
> > >             reset_context.src =3D AMDGPU_RESET_SRC_JOB;
> > >             clear_bit(AMDGPU_NEED_FULL_RESET, &reset_context.flags);
> > >
> > > +           /*
> > > +            * To avoid an unnecessary extra coredump, as we have
> > already
> > > +            * got the very close representation of GPU's error statu=
s
> > > +            */
> > > +           set_bit(AMDGPU_SKIP_COREDUMP, &reset_context.flags);
> > > +
> > >             r =3D amdgpu_device_gpu_recover(ring->adev, job,
> > &reset_context);
> > >             if (r)
> > >                     dev_err(adev->dev, "GPU Recovery Failed: %d\n", r=
);
