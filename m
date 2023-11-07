Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15AEEC4332F
	for <amd-gfx@archiver.kernel.org>; Tue,  7 Nov 2023 19:47:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 88DCF10E67C;
	Tue,  7 Nov 2023 19:47:31 +0000 (UTC)
Received: from mail-oa1-x2a.google.com (mail-oa1-x2a.google.com
 [IPv6:2001:4860:4864:20::2a])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5EB7610E67A
 for <amd-gfx@lists.freedesktop.org>; Tue,  7 Nov 2023 19:47:29 +0000 (UTC)
Received: by mail-oa1-x2a.google.com with SMTP id
 586e51a60fabf-1f060e059a3so3457271fac.1
 for <amd-gfx@lists.freedesktop.org>; Tue, 07 Nov 2023 11:47:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1699386448; x=1699991248; darn=lists.freedesktop.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=mHCxTfNoog4/7WQqaKOQQo3fjHxy8Y0BHSYJ8mzyvwg=;
 b=GD1KqOpd75c+F2j4kfzDpE8mGyk/MemvTE7pf8fMW8RWnS5pnLhIHl1Zv0l+1nMF0Y
 v2Cls9kHUY4sw4PwUnK4vXBr/DI134OlH28lQh797/D2WTXl2ePj95IINO8Ul4TJu9on
 TynxpHwqpZBNG8fxZgFABNu9QXu/A4K/6VecKVY43KtpIfrEzgRxGKvhkSolax1tC1Cu
 29Gp2QSipD5rWK8KKJOW/rqmJ2v1P0BP3raPkz/9rHJn7nWwMyQCA3DqHGZfj0aPGd0G
 uYHynSy+7aQb2UaFT24PIgb7MWvKLc2s2VjmGYTTK1dYmxAk66/op7gp9zQ8tB0bW705
 I+3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699386448; x=1699991248;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=mHCxTfNoog4/7WQqaKOQQo3fjHxy8Y0BHSYJ8mzyvwg=;
 b=CkPpQM0PTCaJvnP60D+J+0zyAYkEl2v8loNoIKjusFwpYaAZ+gQ0W+qj8Z5CbfCEHS
 OUSriouIbQAY6et3JdG7WCub7LfxxxtwMo8mQasXDGrzDT5fR4xN00l2s4EKAm3ioTiC
 n/OWBZKklIercv6wwRsERI8RFQTyX3wXG+WMQtRsg49wjMATduvHUri3N7JX+GgL+buk
 yl97YntGr6S7LGQwx8vibswjhBF11mqm0X/iP2VzbKdjbVauw7UPizWn9sVaCjK3ZJoR
 NaG78ZChAN0G2Ie+picw2cBhHACyBV/f/J3ZML0VQhcX1NEJQqXGBEquyQhHUJZ32bcN
 7wug==
X-Gm-Message-State: AOJu0YxIFg0Q8VHy/NXlN7FYYCTd1lAQOL/5EXZRKivqBNHNc2S2A3mA
 EH6cdZ7Ba9pzTbpIeQmtGSZyYTpvyekckDOjdMU=
X-Google-Smtp-Source: AGHT+IGjCfl3Mnwn5UvtDWkhZlbp5R7zKRgoWvKReF+2TbN7SbOwnewFv8cCbEnyhb6Bk/VJLX5KgW51kFAiPTcXYmI=
X-Received: by 2002:a05:6871:e47:b0:1ef:fa20:3812 with SMTP id
 vk7-20020a0568710e4700b001effa203812mr3505968oab.13.1699386448410; Tue, 07
 Nov 2023 11:47:28 -0800 (PST)
MIME-Version: 1.0
References: <20231025171928.3318505-1-alexander.deucher@amd.com>
 <96db9e3d-4636-4da4-b4d1-ca3f5fd8d887@gmail.com>
 <CADnq5_ORyv9MDfUd3NPDw+APUunDjkTW4Bx4z0FoCiK+s_i+uw@mail.gmail.com>
 <04db543c-7aec-4550-878f-a9753142130e@gmail.com>
 <a8a0eb47-3aca-4c87-b5f7-dc54e5667944@gmail.com>
 <CADnq5_PS64jYS_Y3kGW27m-kuWP+FQFiaVcOaZiB=JLSgPnXBQ@mail.gmail.com>
 <CADnq5_MBgNQPzZmvBagzUdi94X=rr-h=aaE334RzVozgOHU64g@mail.gmail.com>
 <bfb3d504-61c9-43e8-b3b3-2d8193e54d81@gmail.com>
 <CADnq5_OB0OvtqJf5nue-XsTZxOcnfN0Sy6pyryW_GF_Y+S6eYg@mail.gmail.com>
 <CADnq5_OkTuEJ+i+MpfZprSjkGcG99OVSndwyZYWiYEDMEvatgw@mail.gmail.com>
 <63770cb6-e042-4acc-8731-35b187551ca7@gmail.com>
 <CADnq5_NC_OOhYw2iyY1uH+BY4tTjfi43PokuFPqFNwPp6Az1vw@mail.gmail.com>
In-Reply-To: <CADnq5_NC_OOhYw2iyY1uH+BY4tTjfi43PokuFPqFNwPp6Az1vw@mail.gmail.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 7 Nov 2023 14:47:17 -0500
Message-ID: <CADnq5_PAmkoNYL7mJvQ0+b5BB6qNQdKnV+MPiO1F13AcnsfEXg@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: move buffer funcs setting up a level
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>
Content-Type: multipart/mixed; boundary="0000000000009811660609953dff"
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
Cc: Alex Deucher <alexander.deucher@amd.com>,
 Luben Tuikov <luben.tuikov@amd.com>, Leo Liu <leo.liu@amd.com>,
 amd-gfx@lists.freedesktop.org, Luben Tuikov <ltuikov89@gmail.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--0000000000009811660609953dff
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 7, 2023 at 10:14=E2=80=AFAM Alex Deucher <alexdeucher@gmail.com=
> wrote:
>
> On Tue, Nov 7, 2023 at 9:52=E2=80=AFAM Christian K=C3=B6nig
> <ckoenig.leichtzumerken@gmail.com> wrote:
> >
> > This is only needed for certain UVD/VCE hardware/firmware versions.
>
> We currently enable it for all UVD and VCE versions.
>
> >
> > Leo needs to decide that, but I would rather like to keep the call to
> > create the entity in the HW IP specific files.
>
> That will complicate things.  The problem is sw_init() is called too
> early and we don't have any other one time init IP callbacks.  We
> could move it to late_init, but then we'd need to also track whether
> or not the entity has been initialized.  I think this is cleaner.
>

I took a stab at pulling it into the IPs.  It doesn't seem as clean to
me, but it's not too bad so either solution works for me.  @Leo Liu Do
you have a preference?

Alex


> Alex
>
> >
> > Regards,
> > Christian.
> >
> > Am 07.11.23 um 15:47 schrieb Alex Deucher:
> > > On Tue, Nov 7, 2023 at 9:19=E2=80=AFAM Alex Deucher <alexdeucher@gmai=
l.com> wrote:
> > >> On Tue, Nov 7, 2023 at 5:52=E2=80=AFAM Christian K=C3=B6nig
> > >> <ckoenig.leichtzumerken@gmail.com> wrote:
> > >>> Am 03.11.23 um 23:10 schrieb Alex Deucher:
> > >>>> On Fri, Nov 3, 2023 at 4:17=E2=80=AFPM Alex Deucher <alexdeucher@g=
mail.com> wrote:
> > >>>>> On Thu, Oct 26, 2023 at 4:17=E2=80=AFPM Luben Tuikov <ltuikov89@g=
mail.com> wrote:
> > >>>>>> Pushed to drm-misc-next.
> > >>>>> BTW, I'm seeing the following on older GPUs with VCE and UVD even=
 with
> > >>>>> this patch:
> > >>>>> [   11.886024] amdgpu 0000:0a:00.0: [drm] *ERROR* drm_sched_job_i=
nit:
> > >>>>> entity has no rq!
> > >>>>> [   11.886028] amdgpu 0000:0a:00.0: [drm:amdgpu_ib_ring_tests
> > >>>>> [amdgpu]] *ERROR* IB test failed on uvd (-2).
> > >>>>> [   11.889927] amdgpu 0000:0a:00.0: [drm] *ERROR* drm_sched_job_i=
nit:
> > >>>>> entity has no rq!
> > >>>>> [   11.889930] amdgpu 0000:0a:00.0: [drm:amdgpu_ib_ring_tests
> > >>>>> [amdgpu]] *ERROR* IB test failed on vce0 (-2).
> > >>>>> [   11.890172] [drm:process_one_work] *ERROR* ib ring test failed=
 (-2).
> > >>>>> Seems to be specific to UVD and VCE, I don't see anything similar=
 with
> > >>>>> VCN, but the flows for both are pretty similar.  Not sure why we =
are
> > >>>>> not seeing it for VCN.  Just a heads up if you have any ideas.  W=
ill
> > >>>>> take a closer look next week.
> > >>>> + Leo
> > >>>>
> > >>>> I found the problem.  We set up scheduling entities for UVD and VC=
E
> > >>>> specifically and not for any other engines.  I don't remember why
> > >>>> offhand.  I'm guessing maybe to deal with the session limits on UV=
D
> > >>>> and VCE?  If so I'm not sure of a clean way to fix this.
> > >>> I haven't looked through all my mails yet so could be that Leo has
> > >>> already answered this.
> > >>>
> > >>> The UVD/VCE entities are used for the older chips where application=
s
> > >>> have to use create/destroy messages to the firmware.
> > >>>
> > >>> If an application exits without cleaning up their handles the kerne=
l
> > >>> sends the appropriate destroy messages itself. For an example see
> > >>> amdgpu_uvd_free_handles().
> > >>>
> > >>> We used to initialize those entities with separate calls after the
> > >>> scheduler had been brought up, see amdgpu_uvd_entity_init() for an =
example.
> > >>>
> > >>> But this was somehow messed up and we now do the call to
> > >>> amdgpu_uvd_entity_init() at the end of *_sw_init() instead of _late=
_init().
> > >>>
> > >>> I suggest to just come up with a function which can be used for the
> > >>> late_init() callback of the UVD/VCE blocks.
> > >> I guess the issue is that we only need to initialize the entity once
> > >> so sw_init makes sense.  All of the other functions get called at
> > >> resume time, etc.  I think we could probably put it into
> > >> amdgpu_device_init_schedulers() somehow.
> > > I think something like this might do the trick.
> > >
> > > Alex
> > >
> > >> Alex
> > >>
> > >>> Christian.
> > >>>
> > >>>> Alex
> > >>>>
> > >>>>> Alex
> > >>>>>
> > >>>>>> Regards,
> > >>>>>> Luben
> > >>>>>>
> > >>>>>> On 2023-10-26 15:52, Luben Tuikov wrote:
> > >>>>>>> On 2023-10-26 15:32, Alex Deucher wrote:
> > >>>>>>>> On Thu, Oct 26, 2023 at 2:22=E2=80=AFAM Christian K=C3=B6nig
> > >>>>>>>> <ckoenig.leichtzumerken@gmail.com> wrote:
> > >>>>>>>>> Am 25.10.23 um 19:19 schrieb Alex Deucher:
> > >>>>>>>>>> Rather than doing this in the IP code for the SDMA paging
> > >>>>>>>>>> engine, move it up to the core device level init level.
> > >>>>>>>>>> This should fix the scheduler init ordering.
> > >>>>>>>>>>
> > >>>>>>>>>> v2: drop extra parens
> > >>>>>>>>>> v3: drop SDMA helpers
> > >>>>>>>>>>
> > >>>>>>>>>> Tested-by: Luben Tuikov <luben.tuikov@amd.com>
> > >>>>>>>>>> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> > >>>>>>>>> I don't know of hand if the high level function really cover =
everything,
> > >>>>>>>>> so only Acked-by: Christian K=C3=B6nig <christian.koenig@amd.=
com> for now.
> > >>>>>>>>>
> > >>>>>>>> Luben,
> > >>>>>>>>
> > >>>>>>>> Was this needed for some of the scheduler stuff that is pendin=
g?  If
> > >>>>>>>> you would rather take it via drm-misc to align with the schedu=
ler
> > >>>>>>>> changes, that works for me, otherwise I can take it via the am=
dgpu
> > >>>>>>>> tree.
> > >>>>>>> Hi Alex,
> > >>>>>>>
> > >>>>>>> Yes, it does.
> > >>>>>>>
> > >>>>>>> I can take it via drm-misc-next as that where the scheduler cha=
nges landed.
> > >>>>>>>
> > >>>>>>> I'll add Christian's Acked-by.
> > >>>>>>>
> > >>>>>>> I'll add a Fixes tag because ideally it should've gone before t=
he dynamic
> > >>>>>>> sched_rq commit.
> > >>>>>>>
> > >>>>>>> Thanks for the heads-up!
> > >>>>>>>
> > >>>>>>> Regards,
> > >>>>>>> Luben
> > >>>>>>>
> > >>>>>>>
> > >>>>>>>
> > >>>>>>>> Thanks,
> > >>>>>>>>
> > >>>>>>>> Alex
> > >>>>>>>>
> > >>>>>>>>
> > >>>>>>>>> Christian.
> > >>>>>>>>>
> > >>>>>>>>>> ---
> > >>>>>>>>>>     drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 15 ++++++++=
+++++++
> > >>>>>>>>>>     drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c   | 21 --------=
-------------
> > >>>>>>>>>>     drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h   |  1 -
> > >>>>>>>>>>     drivers/gpu/drm/amd/amdgpu/cik_sdma.c      |  5 -----
> > >>>>>>>>>>     drivers/gpu/drm/amd/amdgpu/sdma_v2_4.c     |  5 -----
> > >>>>>>>>>>     drivers/gpu/drm/amd/amdgpu/sdma_v3_0.c     |  5 -----
> > >>>>>>>>>>     drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c     | 16 +-------=
--------
> > >>>>>>>>>>     drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c     | 10 +-------=
--
> > >>>>>>>>>>     drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c     | 10 +-------=
--
> > >>>>>>>>>>     drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c     | 10 +-------=
--
> > >>>>>>>>>>     drivers/gpu/drm/amd/amdgpu/si_dma.c        |  5 -----
> > >>>>>>>>>>     11 files changed, 19 insertions(+), 84 deletions(-)
> > >>>>>>>>>>
> > >>>>>>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/dr=
ivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> > >>>>>>>>>> index 2031a467b721..5c90080e93ba 100644
> > >>>>>>>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> > >>>>>>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> > >>>>>>>>>> @@ -2662,6 +2662,9 @@ static int amdgpu_device_ip_init(struc=
t amdgpu_device *adev)
> > >>>>>>>>>>         if (r)
> > >>>>>>>>>>                 goto init_failed;
> > >>>>>>>>>>
> > >>>>>>>>>> +     if (adev->mman.buffer_funcs_ring->sched.ready)
> > >>>>>>>>>> +             amdgpu_ttm_set_buffer_funcs_status(adev, true)=
;
> > >>>>>>>>>> +
> > >>>>>>>>>>         /* Don't init kfd if whole hive need to be reset dur=
ing init */
> > >>>>>>>>>>         if (!adev->gmc.xgmi.pending_reset) {
> > >>>>>>>>>>                 kgd2kfd_init_zone_device(adev);
> > >>>>>>>>>> @@ -3260,6 +3263,8 @@ int amdgpu_device_ip_suspend(struct am=
dgpu_device *adev)
> > >>>>>>>>>>                 amdgpu_virt_request_full_gpu(adev, false);
> > >>>>>>>>>>         }
> > >>>>>>>>>>
> > >>>>>>>>>> +     amdgpu_ttm_set_buffer_funcs_status(adev, false);
> > >>>>>>>>>> +
> > >>>>>>>>>>         r =3D amdgpu_device_ip_suspend_phase1(adev);
> > >>>>>>>>>>         if (r)
> > >>>>>>>>>>                 return r;
> > >>>>>>>>>> @@ -3449,6 +3454,9 @@ static int amdgpu_device_ip_resume(str=
uct amdgpu_device *adev)
> > >>>>>>>>>>
> > >>>>>>>>>>         r =3D amdgpu_device_ip_resume_phase2(adev);
> > >>>>>>>>>>
> > >>>>>>>>>> +     if (adev->mman.buffer_funcs_ring->sched.ready)
> > >>>>>>>>>> +             amdgpu_ttm_set_buffer_funcs_status(adev, true)=
;
> > >>>>>>>>>> +
> > >>>>>>>>>>         return r;
> > >>>>>>>>>>     }
> > >>>>>>>>>>
> > >>>>>>>>>> @@ -4236,6 +4244,8 @@ void amdgpu_device_fini_hw(struct amdg=
pu_device *adev)
> > >>>>>>>>>>         /* disable ras feature must before hw fini */
> > >>>>>>>>>>         amdgpu_ras_pre_fini(adev);
> > >>>>>>>>>>
> > >>>>>>>>>> +     amdgpu_ttm_set_buffer_funcs_status(adev, false);
> > >>>>>>>>>> +
> > >>>>>>>>>>         amdgpu_device_ip_fini_early(adev);
> > >>>>>>>>>>
> > >>>>>>>>>>         amdgpu_irq_fini_hw(adev);
> > >>>>>>>>>> @@ -4407,6 +4417,8 @@ int amdgpu_device_suspend(struct drm_d=
evice *dev, bool fbcon)
> > >>>>>>>>>>
> > >>>>>>>>>>         amdgpu_ras_suspend(adev);
> > >>>>>>>>>>
> > >>>>>>>>>> +     amdgpu_ttm_set_buffer_funcs_status(adev, false);
> > >>>>>>>>>> +
> > >>>>>>>>>>         amdgpu_device_ip_suspend_phase1(adev);
> > >>>>>>>>>>
> > >>>>>>>>>>         if (!adev->in_s0ix)
> > >>>>>>>>>> @@ -5178,6 +5190,9 @@ int amdgpu_do_asic_reset(struct list_h=
ead *device_list_handle,
> > >>>>>>>>>>                                 if (r)
> > >>>>>>>>>>                                         goto out;
> > >>>>>>>>>>
> > >>>>>>>>>> +                             if (tmp_adev->mman.buffer_func=
s_ring->sched.ready)
> > >>>>>>>>>> +                                     amdgpu_ttm_set_buffer_=
funcs_status(tmp_adev, true);
> > >>>>>>>>>> +
> > >>>>>>>>>>                                 if (vram_lost)
> > >>>>>>>>>>                                         amdgpu_device_fill_r=
eset_magic(tmp_adev);
> > >>>>>>>>>>
> > >>>>>>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c b/driv=
ers/gpu/drm/amd/amdgpu/amdgpu_sdma.c
> > >>>>>>>>>> index e8cbc4142d80..1d9d187de6ee 100644
> > >>>>>>>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c
> > >>>>>>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c
> > >>>>>>>>>> @@ -292,27 +292,6 @@ int amdgpu_sdma_init_microcode(struct a=
mdgpu_device *adev,
> > >>>>>>>>>>         return err;
> > >>>>>>>>>>     }
> > >>>>>>>>>>
> > >>>>>>>>>> -void amdgpu_sdma_unset_buffer_funcs_helper(struct amdgpu_de=
vice *adev)
> > >>>>>>>>>> -{
> > >>>>>>>>>> -     struct amdgpu_ring *sdma;
> > >>>>>>>>>> -     int i;
> > >>>>>>>>>> -
> > >>>>>>>>>> -     for (i =3D 0; i < adev->sdma.num_instances; i++) {
> > >>>>>>>>>> -             if (adev->sdma.has_page_queue) {
> > >>>>>>>>>> -                     sdma =3D &adev->sdma.instance[i].page;
> > >>>>>>>>>> -                     if (adev->mman.buffer_funcs_ring =3D=
=3D sdma) {
> > >>>>>>>>>> -                             amdgpu_ttm_set_buffer_funcs_st=
atus(adev, false);
> > >>>>>>>>>> -                             break;
> > >>>>>>>>>> -                     }
> > >>>>>>>>>> -             }
> > >>>>>>>>>> -             sdma =3D &adev->sdma.instance[i].ring;
> > >>>>>>>>>> -             if (adev->mman.buffer_funcs_ring =3D=3D sdma) =
{
> > >>>>>>>>>> -                     amdgpu_ttm_set_buffer_funcs_status(ade=
v, false);
> > >>>>>>>>>> -                     break;
> > >>>>>>>>>> -             }
> > >>>>>>>>>> -     }
> > >>>>>>>>>> -}
> > >>>>>>>>>> -
> > >>>>>>>>>>     int amdgpu_sdma_ras_sw_init(struct amdgpu_device *adev)
> > >>>>>>>>>>     {
> > >>>>>>>>>>         int err =3D 0;
> > >>>>>>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h b/driv=
ers/gpu/drm/amd/amdgpu/amdgpu_sdma.h
> > >>>>>>>>>> index 513ac22120c1..173a2a308078 100644
> > >>>>>>>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h
> > >>>>>>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h
> > >>>>>>>>>> @@ -169,7 +169,6 @@ int amdgpu_sdma_init_microcode(struct am=
dgpu_device *adev, u32 instance,
> > >>>>>>>>>>                                bool duplicate);
> > >>>>>>>>>>     void amdgpu_sdma_destroy_inst_ctx(struct amdgpu_device *=
adev,
> > >>>>>>>>>>             bool duplicate);
> > >>>>>>>>>> -void amdgpu_sdma_unset_buffer_funcs_helper(struct amdgpu_de=
vice *adev);
> > >>>>>>>>>>     int amdgpu_sdma_ras_sw_init(struct amdgpu_device *adev);
> > >>>>>>>>>>
> > >>>>>>>>>>     #endif
> > >>>>>>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/cik_sdma.c b/drivers=
/gpu/drm/amd/amdgpu/cik_sdma.c
> > >>>>>>>>>> index ee5dce6f6043..a3fccc4c1f43 100644
> > >>>>>>>>>> --- a/drivers/gpu/drm/amd/amdgpu/cik_sdma.c
> > >>>>>>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/cik_sdma.c
> > >>>>>>>>>> @@ -308,8 +308,6 @@ static void cik_sdma_gfx_stop(struct amd=
gpu_device *adev)
> > >>>>>>>>>>         u32 rb_cntl;
> > >>>>>>>>>>         int i;
> > >>>>>>>>>>
> > >>>>>>>>>> -     amdgpu_sdma_unset_buffer_funcs_helper(adev);
> > >>>>>>>>>> -
> > >>>>>>>>>>         for (i =3D 0; i < adev->sdma.num_instances; i++) {
> > >>>>>>>>>>                 rb_cntl =3D RREG32(mmSDMA0_GFX_RB_CNTL + sdm=
a_offsets[i]);
> > >>>>>>>>>>                 rb_cntl &=3D ~SDMA0_GFX_RB_CNTL__RB_ENABLE_M=
ASK;
> > >>>>>>>>>> @@ -498,9 +496,6 @@ static int cik_sdma_gfx_resume(struct am=
dgpu_device *adev)
> > >>>>>>>>>>                 r =3D amdgpu_ring_test_helper(ring);
> > >>>>>>>>>>                 if (r)
> > >>>>>>>>>>                         return r;
> > >>>>>>>>>> -
> > >>>>>>>>>> -             if (adev->mman.buffer_funcs_ring =3D=3D ring)
> > >>>>>>>>>> -                     amdgpu_ttm_set_buffer_funcs_status(ade=
v, true);
> > >>>>>>>>>>         }
> > >>>>>>>>>>
> > >>>>>>>>>>         return 0;
> > >>>>>>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v2_4.c b/driver=
s/gpu/drm/amd/amdgpu/sdma_v2_4.c
> > >>>>>>>>>> index b58a13bd75db..45377a175250 100644
> > >>>>>>>>>> --- a/drivers/gpu/drm/amd/amdgpu/sdma_v2_4.c
> > >>>>>>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/sdma_v2_4.c
> > >>>>>>>>>> @@ -339,8 +339,6 @@ static void sdma_v2_4_gfx_stop(struct am=
dgpu_device *adev)
> > >>>>>>>>>>         u32 rb_cntl, ib_cntl;
> > >>>>>>>>>>         int i;
> > >>>>>>>>>>
> > >>>>>>>>>> -     amdgpu_sdma_unset_buffer_funcs_helper(adev);
> > >>>>>>>>>> -
> > >>>>>>>>>>         for (i =3D 0; i < adev->sdma.num_instances; i++) {
> > >>>>>>>>>>                 rb_cntl =3D RREG32(mmSDMA0_GFX_RB_CNTL + sdm=
a_offsets[i]);
> > >>>>>>>>>>                 rb_cntl =3D REG_SET_FIELD(rb_cntl, SDMA0_GFX=
_RB_CNTL, RB_ENABLE, 0);
> > >>>>>>>>>> @@ -474,9 +472,6 @@ static int sdma_v2_4_gfx_resume(struct a=
mdgpu_device *adev)
> > >>>>>>>>>>                 r =3D amdgpu_ring_test_helper(ring);
> > >>>>>>>>>>                 if (r)
> > >>>>>>>>>>                         return r;
> > >>>>>>>>>> -
> > >>>>>>>>>> -             if (adev->mman.buffer_funcs_ring =3D=3D ring)
> > >>>>>>>>>> -                     amdgpu_ttm_set_buffer_funcs_status(ade=
v, true);
> > >>>>>>>>>>         }
> > >>>>>>>>>>
> > >>>>>>>>>>         return 0;
> > >>>>>>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v3_0.c b/driver=
s/gpu/drm/amd/amdgpu/sdma_v3_0.c
> > >>>>>>>>>> index c5ea32687eb5..2ad615be4bb3 100644
> > >>>>>>>>>> --- a/drivers/gpu/drm/amd/amdgpu/sdma_v3_0.c
> > >>>>>>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/sdma_v3_0.c
> > >>>>>>>>>> @@ -513,8 +513,6 @@ static void sdma_v3_0_gfx_stop(struct am=
dgpu_device *adev)
> > >>>>>>>>>>         u32 rb_cntl, ib_cntl;
> > >>>>>>>>>>         int i;
> > >>>>>>>>>>
> > >>>>>>>>>> -     amdgpu_sdma_unset_buffer_funcs_helper(adev);
> > >>>>>>>>>> -
> > >>>>>>>>>>         for (i =3D 0; i < adev->sdma.num_instances; i++) {
> > >>>>>>>>>>                 rb_cntl =3D RREG32(mmSDMA0_GFX_RB_CNTL + sdm=
a_offsets[i]);
> > >>>>>>>>>>                 rb_cntl =3D REG_SET_FIELD(rb_cntl, SDMA0_GFX=
_RB_CNTL, RB_ENABLE, 0);
> > >>>>>>>>>> @@ -746,9 +744,6 @@ static int sdma_v3_0_gfx_resume(struct a=
mdgpu_device *adev)
> > >>>>>>>>>>                 r =3D amdgpu_ring_test_helper(ring);
> > >>>>>>>>>>                 if (r)
> > >>>>>>>>>>                         return r;
> > >>>>>>>>>> -
> > >>>>>>>>>> -             if (adev->mman.buffer_funcs_ring =3D=3D ring)
> > >>>>>>>>>> -                     amdgpu_ttm_set_buffer_funcs_status(ade=
v, true);
> > >>>>>>>>>>         }
> > >>>>>>>>>>
> > >>>>>>>>>>         return 0;
> > >>>>>>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c b/driver=
s/gpu/drm/amd/amdgpu/sdma_v4_0.c
> > >>>>>>>>>> index 683d51ae4bf1..3d68dd5523c6 100644
> > >>>>>>>>>> --- a/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
> > >>>>>>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
> > >>>>>>>>>> @@ -877,8 +877,6 @@ static void sdma_v4_0_gfx_enable(struct =
amdgpu_device *adev, bool enable)
> > >>>>>>>>>>         u32 rb_cntl, ib_cntl;
> > >>>>>>>>>>         int i;
> > >>>>>>>>>>
> > >>>>>>>>>> -     amdgpu_sdma_unset_buffer_funcs_helper(adev);
> > >>>>>>>>>> -
> > >>>>>>>>>>         for (i =3D 0; i < adev->sdma.num_instances; i++) {
> > >>>>>>>>>>                 rb_cntl =3D RREG32_SDMA(i, mmSDMA0_GFX_RB_CN=
TL);
> > >>>>>>>>>>                 rb_cntl =3D REG_SET_FIELD(rb_cntl, SDMA0_GFX=
_RB_CNTL, RB_ENABLE, enable ? 1 : 0);
> > >>>>>>>>>> @@ -913,8 +911,6 @@ static void sdma_v4_0_page_stop(struct a=
mdgpu_device *adev)
> > >>>>>>>>>>         u32 rb_cntl, ib_cntl;
> > >>>>>>>>>>         int i;
> > >>>>>>>>>>
> > >>>>>>>>>> -     amdgpu_sdma_unset_buffer_funcs_helper(adev);
> > >>>>>>>>>> -
> > >>>>>>>>>>         for (i =3D 0; i < adev->sdma.num_instances; i++) {
> > >>>>>>>>>>                 rb_cntl =3D RREG32_SDMA(i, mmSDMA0_PAGE_RB_C=
NTL);
> > >>>>>>>>>>                 rb_cntl =3D REG_SET_FIELD(rb_cntl, SDMA0_PAG=
E_RB_CNTL,
> > >>>>>>>>>> @@ -1402,13 +1398,7 @@ static int sdma_v4_0_start(struct amd=
gpu_device *adev)
> > >>>>>>>>>>                         r =3D amdgpu_ring_test_helper(page);
> > >>>>>>>>>>                         if (r)
> > >>>>>>>>>>                                 return r;
> > >>>>>>>>>> -
> > >>>>>>>>>> -                     if (adev->mman.buffer_funcs_ring =3D=
=3D page)
> > >>>>>>>>>> -                             amdgpu_ttm_set_buffer_funcs_st=
atus(adev, true);
> > >>>>>>>>>>                 }
> > >>>>>>>>>> -
> > >>>>>>>>>> -             if (adev->mman.buffer_funcs_ring =3D=3D ring)
> > >>>>>>>>>> -                     amdgpu_ttm_set_buffer_funcs_status(ade=
v, true);
> > >>>>>>>>>>         }
> > >>>>>>>>>>
> > >>>>>>>>>>         return r;
> > >>>>>>>>>> @@ -1921,11 +1911,8 @@ static int sdma_v4_0_hw_fini(void *ha=
ndle)
> > >>>>>>>>>>         struct amdgpu_device *adev =3D (struct amdgpu_device=
 *)handle;
> > >>>>>>>>>>         int i;
> > >>>>>>>>>>
> > >>>>>>>>>> -     if (amdgpu_sriov_vf(adev)) {
> > >>>>>>>>>> -             /* disable the scheduler for SDMA */
> > >>>>>>>>>> -             amdgpu_sdma_unset_buffer_funcs_helper(adev);
> > >>>>>>>>>> +     if (amdgpu_sriov_vf(adev))
> > >>>>>>>>>>                 return 0;
> > >>>>>>>>>> -     }
> > >>>>>>>>>>
> > >>>>>>>>>>         if (amdgpu_ras_is_supported(adev, AMDGPU_RAS_BLOCK__=
SDMA)) {
> > >>>>>>>>>>                 for (i =3D 0; i < adev->sdma.num_instances; =
i++) {
> > >>>>>>>>>> @@ -1964,7 +1951,6 @@ static int sdma_v4_0_resume(void *hand=
le)
> > >>>>>>>>>>         if (adev->in_s0ix) {
> > >>>>>>>>>>                 sdma_v4_0_enable(adev, true);
> > >>>>>>>>>>                 sdma_v4_0_gfx_enable(adev, true);
> > >>>>>>>>>> -             amdgpu_ttm_set_buffer_funcs_status(adev, true)=
;
> > >>>>>>>>>>                 return 0;
> > >>>>>>>>>>         }
> > >>>>>>>>>>
> > >>>>>>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c b/driver=
s/gpu/drm/amd/amdgpu/sdma_v5_0.c
> > >>>>>>>>>> index be5d099c9898..c78027ebdcb9 100644
> > >>>>>>>>>> --- a/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c
> > >>>>>>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c
> > >>>>>>>>>> @@ -559,8 +559,6 @@ static void sdma_v5_0_gfx_stop(struct am=
dgpu_device *adev)
> > >>>>>>>>>>         u32 rb_cntl, ib_cntl;
> > >>>>>>>>>>         int i;
> > >>>>>>>>>>
> > >>>>>>>>>> -     amdgpu_sdma_unset_buffer_funcs_helper(adev);
> > >>>>>>>>>> -
> > >>>>>>>>>>         for (i =3D 0; i < adev->sdma.num_instances; i++) {
> > >>>>>>>>>>                 rb_cntl =3D RREG32_SOC15_IP(GC, sdma_v5_0_ge=
t_reg_offset(adev, i, mmSDMA0_GFX_RB_CNTL));
> > >>>>>>>>>>                 rb_cntl =3D REG_SET_FIELD(rb_cntl, SDMA0_GFX=
_RB_CNTL, RB_ENABLE, 0);
> > >>>>>>>>>> @@ -825,9 +823,6 @@ static int sdma_v5_0_gfx_resume(struct a=
mdgpu_device *adev)
> > >>>>>>>>>>                 r =3D amdgpu_ring_test_helper(ring);
> > >>>>>>>>>>                 if (r)
> > >>>>>>>>>>                         return r;
> > >>>>>>>>>> -
> > >>>>>>>>>> -             if (adev->mman.buffer_funcs_ring =3D=3D ring)
> > >>>>>>>>>> -                     amdgpu_ttm_set_buffer_funcs_status(ade=
v, true);
> > >>>>>>>>>>         }
> > >>>>>>>>>>
> > >>>>>>>>>>         return 0;
> > >>>>>>>>>> @@ -1426,11 +1421,8 @@ static int sdma_v5_0_hw_fini(void *ha=
ndle)
> > >>>>>>>>>>     {
> > >>>>>>>>>>         struct amdgpu_device *adev =3D (struct amdgpu_device=
 *)handle;
> > >>>>>>>>>>
> > >>>>>>>>>> -     if (amdgpu_sriov_vf(adev)) {
> > >>>>>>>>>> -             /* disable the scheduler for SDMA */
> > >>>>>>>>>> -             amdgpu_sdma_unset_buffer_funcs_helper(adev);
> > >>>>>>>>>> +     if (amdgpu_sriov_vf(adev))
> > >>>>>>>>>>                 return 0;
> > >>>>>>>>>> -     }
> > >>>>>>>>>>
> > >>>>>>>>>>         sdma_v5_0_ctx_switch_enable(adev, false);
> > >>>>>>>>>>         sdma_v5_0_enable(adev, false);
> > >>>>>>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c b/driver=
s/gpu/drm/amd/amdgpu/sdma_v5_2.c
> > >>>>>>>>>> index a3e8b10c071c..2e35f3571774 100644
> > >>>>>>>>>> --- a/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
> > >>>>>>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
> > >>>>>>>>>> @@ -364,8 +364,6 @@ static void sdma_v5_2_gfx_stop(struct am=
dgpu_device *adev)
> > >>>>>>>>>>         u32 rb_cntl, ib_cntl;
> > >>>>>>>>>>         int i;
> > >>>>>>>>>>
> > >>>>>>>>>> -     amdgpu_sdma_unset_buffer_funcs_helper(adev);
> > >>>>>>>>>> -
> > >>>>>>>>>>         for (i =3D 0; i < adev->sdma.num_instances; i++) {
> > >>>>>>>>>>                 rb_cntl =3D RREG32_SOC15_IP(GC, sdma_v5_2_ge=
t_reg_offset(adev, i, mmSDMA0_GFX_RB_CNTL));
> > >>>>>>>>>>                 rb_cntl =3D REG_SET_FIELD(rb_cntl, SDMA0_GFX=
_RB_CNTL, RB_ENABLE, 0);
> > >>>>>>>>>> @@ -625,9 +623,6 @@ static int sdma_v5_2_gfx_resume(struct a=
mdgpu_device *adev)
> > >>>>>>>>>>                 r =3D amdgpu_ring_test_helper(ring);
> > >>>>>>>>>>                 if (r)
> > >>>>>>>>>>                         return r;
> > >>>>>>>>>> -
> > >>>>>>>>>> -             if (adev->mman.buffer_funcs_ring =3D=3D ring)
> > >>>>>>>>>> -                     amdgpu_ttm_set_buffer_funcs_status(ade=
v, true);
> > >>>>>>>>>>         }
> > >>>>>>>>>>
> > >>>>>>>>>>         return 0;
> > >>>>>>>>>> @@ -1284,11 +1279,8 @@ static int sdma_v5_2_hw_fini(void *ha=
ndle)
> > >>>>>>>>>>     {
> > >>>>>>>>>>         struct amdgpu_device *adev =3D (struct amdgpu_device=
 *)handle;
> > >>>>>>>>>>
> > >>>>>>>>>> -     if (amdgpu_sriov_vf(adev)) {
> > >>>>>>>>>> -             /* disable the scheduler for SDMA */
> > >>>>>>>>>> -             amdgpu_sdma_unset_buffer_funcs_helper(adev);
> > >>>>>>>>>> +     if (amdgpu_sriov_vf(adev))
> > >>>>>>>>>>                 return 0;
> > >>>>>>>>>> -     }
> > >>>>>>>>>>
> > >>>>>>>>>>         sdma_v5_2_ctx_switch_enable(adev, false);
> > >>>>>>>>>>         sdma_v5_2_enable(adev, false);
> > >>>>>>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c b/driver=
s/gpu/drm/amd/amdgpu/sdma_v6_0.c
> > >>>>>>>>>> index 445a34549d2c..1c6ff511f501 100644
> > >>>>>>>>>> --- a/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c
> > >>>>>>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c
> > >>>>>>>>>> @@ -348,8 +348,6 @@ static void sdma_v6_0_gfx_stop(struct am=
dgpu_device *adev)
> > >>>>>>>>>>         u32 rb_cntl, ib_cntl;
> > >>>>>>>>>>         int i;
> > >>>>>>>>>>
> > >>>>>>>>>> -     amdgpu_sdma_unset_buffer_funcs_helper(adev);
> > >>>>>>>>>> -
> > >>>>>>>>>>         for (i =3D 0; i < adev->sdma.num_instances; i++) {
> > >>>>>>>>>>                 rb_cntl =3D RREG32_SOC15_IP(GC, sdma_v6_0_ge=
t_reg_offset(adev, i, regSDMA0_QUEUE0_RB_CNTL));
> > >>>>>>>>>>                 rb_cntl =3D REG_SET_FIELD(rb_cntl, SDMA0_QUE=
UE0_RB_CNTL, RB_ENABLE, 0);
> > >>>>>>>>>> @@ -561,9 +559,6 @@ static int sdma_v6_0_gfx_resume(struct a=
mdgpu_device *adev)
> > >>>>>>>>>>                 r =3D amdgpu_ring_test_helper(ring);
> > >>>>>>>>>>                 if (r)
> > >>>>>>>>>>                         return r;
> > >>>>>>>>>> -
> > >>>>>>>>>> -             if (adev->mman.buffer_funcs_ring =3D=3D ring)
> > >>>>>>>>>> -                     amdgpu_ttm_set_buffer_funcs_status(ade=
v, true);
> > >>>>>>>>>>         }
> > >>>>>>>>>>
> > >>>>>>>>>>         return 0;
> > >>>>>>>>>> @@ -1308,11 +1303,8 @@ static int sdma_v6_0_hw_fini(void *ha=
ndle)
> > >>>>>>>>>>     {
> > >>>>>>>>>>         struct amdgpu_device *adev =3D (struct amdgpu_device=
 *)handle;
> > >>>>>>>>>>
> > >>>>>>>>>> -     if (amdgpu_sriov_vf(adev)) {
> > >>>>>>>>>> -             /* disable the scheduler for SDMA */
> > >>>>>>>>>> -             amdgpu_sdma_unset_buffer_funcs_helper(adev);
> > >>>>>>>>>> +     if (amdgpu_sriov_vf(adev))
> > >>>>>>>>>>                 return 0;
> > >>>>>>>>>> -     }
> > >>>>>>>>>>
> > >>>>>>>>>>         sdma_v6_0_ctxempty_int_enable(adev, false);
> > >>>>>>>>>>         sdma_v6_0_enable(adev, false);
> > >>>>>>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/si_dma.c b/drivers/g=
pu/drm/amd/amdgpu/si_dma.c
> > >>>>>>>>>> index 42c4547f32ec..9aa0e11ee673 100644
> > >>>>>>>>>> --- a/drivers/gpu/drm/amd/amdgpu/si_dma.c
> > >>>>>>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/si_dma.c
> > >>>>>>>>>> @@ -115,8 +115,6 @@ static void si_dma_stop(struct amdgpu_de=
vice *adev)
> > >>>>>>>>>>         u32 rb_cntl;
> > >>>>>>>>>>         unsigned i;
> > >>>>>>>>>>
> > >>>>>>>>>> -     amdgpu_sdma_unset_buffer_funcs_helper(adev);
> > >>>>>>>>>> -
> > >>>>>>>>>>         for (i =3D 0; i < adev->sdma.num_instances; i++) {
> > >>>>>>>>>>                 /* dma0 */
> > >>>>>>>>>>                 rb_cntl =3D RREG32(DMA_RB_CNTL + sdma_offset=
s[i]);
> > >>>>>>>>>> @@ -177,9 +175,6 @@ static int si_dma_start(struct amdgpu_de=
vice *adev)
> > >>>>>>>>>>                 r =3D amdgpu_ring_test_helper(ring);
> > >>>>>>>>>>                 if (r)
> > >>>>>>>>>>                         return r;
> > >>>>>>>>>> -
> > >>>>>>>>>> -             if (adev->mman.buffer_funcs_ring =3D=3D ring)
> > >>>>>>>>>> -                     amdgpu_ttm_set_buffer_funcs_status(ade=
v, true);
> > >>>>>>>>>>         }
> > >>>>>>>>>>
> > >>>>>>>>>>         return 0;
> >

--0000000000009811660609953dff
Content-Type: text/x-patch; charset="US-ASCII"; 
	name="0001-drm-amdgpu-move-UVD-and-VCE-sched-entity-init-into-l.patch"
Content-Disposition: attachment; 
	filename="0001-drm-amdgpu-move-UVD-and-VCE-sched-entity-init-into-l.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_looqs0ud0>
X-Attachment-Id: f_looqs0ud0

RnJvbSAzMjcyMmUwMzk1NjM5ZTc1NDY0MTViNzRkMGFiNDEyZWIyNTFmODE1IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBBbGV4IERldWNoZXIgPGFsZXhhbmRlci5kZXVjaGVyQGFtZC5j
b20+CkRhdGU6IFR1ZSwgNyBOb3YgMjAyMyAxNDo0MDowOSAtMDUwMApTdWJqZWN0OiBbUEFUQ0hd
IGRybS9hbWRncHU6IG1vdmUgVVZEIGFuZCBWQ0Ugc2NoZWQgZW50aXR5IGluaXQgaW50byBsYXRl
IGluaXQKCkFkZCBsYXRlX2luaXQgY2FsbGJhY2tzIGZvciBVVkQgYW5kIFZDRSBhbmQgcHV0IHRo
ZSBlbnRpdHkgaW5pdAppbnRvIHRoYXQuCgpXZSBuZWVkIGtlcm5lbCBzY2hlZHVsaW5nIGVudGl0
aWVzIHRvIGRlYWwgd2l0aCBoYW5kbGUgY2xlYW4gdXAKaWYgYXBwcyBhcmUgbm90IGNsZWFuZWQg
dXAgcHJvcGVybHkuICBXaXRoIGNvbW1pdCA1NmU0NDk2MDNmMGFjNQooImRybS9zY2hlZDogQ29u
dmVydCB0aGUgR1BVIHNjaGVkdWxlciB0byB2YXJpYWJsZSBudW1iZXIgb2YgcnVuLXF1ZXVlcyIp
CnRoZSBzY2hlZHVsZXIgZW50aXRpZXMgaGF2ZSB0byBiZSBjcmVhdGVkIGFmdGVyIHNjaGVkdWxl
ciBpbml0LCBzbwpjaGFuZ2UgdGhlIG9yZGVyaW5nIHRvIGZpeCB0aGlzLgoKRml4ZXM6IDU2ZTQ0
OTYwM2YwYWM1ICgiZHJtL3NjaGVkOiBDb252ZXJ0IHRoZSBHUFUgc2NoZWR1bGVyIHRvIHZhcmlh
YmxlIG51bWJlciBvZiBydW4tcXVldWVzIikKU2lnbmVkLW9mZi1ieTogQWxleCBEZXVjaGVyIDxh
bGV4YW5kZXIuZGV1Y2hlckBhbWQuY29tPgotLS0KIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1
L2FtZGdwdV91dmQuYyB8IDE3ICsrKysrKysrKystLS0tLS0tCiBkcml2ZXJzL2dwdS9kcm0vYW1k
L2FtZGdwdS9hbWRncHVfdXZkLmggfCAgMSArCiBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9h
bWRncHVfdmNlLmMgfCAxNyArKysrKysrKysrLS0tLS0tLQogZHJpdmVycy9ncHUvZHJtL2FtZC9h
bWRncHUvYW1kZ3B1X3ZjZS5oIHwgIDEgKwogZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvdXZk
X3YzXzEuYyAgIHwgMTEgKysrKysrKystLS0KIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L3V2
ZF92NF8yLmMgICB8IDExICsrKysrKysrLS0tCiBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS91
dmRfdjVfMC5jICAgfCAxMSArKysrKysrKy0tLQogZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUv
dXZkX3Y2XzAuYyAgIHwgMTEgKysrKysrKystLS0KIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1
L3V2ZF92N18wLmMgICB8IDEzICsrKysrKysrLS0tLS0KIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1k
Z3B1L3ZjZV92Ml8wLmMgICB8IDExICsrKysrKysrLS0tCiBkcml2ZXJzL2dwdS9kcm0vYW1kL2Ft
ZGdwdS92Y2VfdjNfMC5jICAgfCAxMSArKysrKysrKy0tLQogZHJpdmVycy9ncHUvZHJtL2FtZC9h
bWRncHUvdmNlX3Y0XzAuYyAgIHwgMTQgKysrKysrKystLS0tLS0KIDEyIGZpbGVzIGNoYW5nZWQs
IDg2IGluc2VydGlvbnMoKyksIDQzIGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL2RyaXZlcnMv
Z3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV91dmQuYyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1k
Z3B1L2FtZGdwdV91dmQuYwppbmRleCA4MTViN2MzNGVkMzMuLjJkZWRkOWU2ZGRhYiAxMDA2NDQK
LS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3V2ZC5jCisrKyBiL2RyaXZl
cnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV91dmQuYwpAQCAtNDA2LDEzICs0MDYsMTYgQEAg
aW50IGFtZGdwdV91dmRfZW50aXR5X2luaXQoc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYpCiAJ
c3RydWN0IGRybV9ncHVfc2NoZWR1bGVyICpzY2hlZDsKIAlpbnQgcjsKIAotCXJpbmcgPSAmYWRl
di0+dXZkLmluc3RbMF0ucmluZzsKLQlzY2hlZCA9ICZyaW5nLT5zY2hlZDsKLQlyID0gZHJtX3Nj
aGVkX2VudGl0eV9pbml0KCZhZGV2LT51dmQuZW50aXR5LCBEUk1fU0NIRURfUFJJT1JJVFlfTk9S
TUFMLAotCQkJCSAgJnNjaGVkLCAxLCBOVUxMKTsKLQlpZiAocikgewotCQlEUk1fRVJST1IoIkZh
aWxlZCBzZXR0aW5nIHVwIFVWRCBrZXJuZWwgZW50aXR5LlxuIik7Ci0JCXJldHVybiByOworCWlm
ICghYWRldi0+dXZkLmVudGl0eV9pbml0aWFsaXplZCkgeworCQlyaW5nID0gJmFkZXYtPnV2ZC5p
bnN0WzBdLnJpbmc7CisJCXNjaGVkID0gJnJpbmctPnNjaGVkOworCQlyID0gZHJtX3NjaGVkX2Vu
dGl0eV9pbml0KCZhZGV2LT51dmQuZW50aXR5LCBEUk1fU0NIRURfUFJJT1JJVFlfTk9STUFMLAor
CQkJCQkgICZzY2hlZCwgMSwgTlVMTCk7CisJCWlmIChyKSB7CisJCQlEUk1fRVJST1IoIkZhaWxl
ZCBzZXR0aW5nIHVwIFVWRCBrZXJuZWwgZW50aXR5LlxuIik7CisJCQlyZXR1cm4gcjsKKwkJfQor
CQlhZGV2LT51dmQuZW50aXR5X2luaXRpYWxpemVkID0gdHJ1ZTsKIAl9CiAKIAlyZXR1cm4gMDsK
ZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV91dmQuaCBiL2Ry
aXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV91dmQuaAppbmRleCBhOWYzNDI1MzdjNjgu
LmE0N2FlZjEzOTE2YyAxMDA2NDQKLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1k
Z3B1X3V2ZC5oCisrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV91dmQuaApA
QCAtNjksNiArNjksNyBAQCBzdHJ1Y3QgYW1kZ3B1X3V2ZCB7CiAJdW5zaWduZWQJCWRlY29kZV9p
bWFnZV93aWR0aDsKIAl1aW50MzJfdCAgICAgICAgICAgICAgICBrZXlzZWxlY3Q7CiAJc3RydWN0
IGFtZGdwdV9ibwkqaWJfYm87CisJYm9vbCAgICAgICAgICAgICAgICAgICAgZW50aXR5X2luaXRp
YWxpemVkOwogfTsKIAogaW50IGFtZGdwdV91dmRfc3dfaW5pdChzdHJ1Y3QgYW1kZ3B1X2Rldmlj
ZSAqYWRldik7CmRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVf
dmNlLmMgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfdmNlLmMKaW5kZXggMTkw
NGVkZjY4NDA3Li5kYWUyYjQ3OWYxNjUgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQv
YW1kZ3B1L2FtZGdwdV92Y2UuYworKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRn
cHVfdmNlLmMKQEAgLTIzOCwxMyArMjM4LDE2IEBAIGludCBhbWRncHVfdmNlX2VudGl0eV9pbml0
KHN0cnVjdCBhbWRncHVfZGV2aWNlICphZGV2KQogCXN0cnVjdCBkcm1fZ3B1X3NjaGVkdWxlciAq
c2NoZWQ7CiAJaW50IHI7CiAKLQlyaW5nID0gJmFkZXYtPnZjZS5yaW5nWzBdOwotCXNjaGVkID0g
JnJpbmctPnNjaGVkOwotCXIgPSBkcm1fc2NoZWRfZW50aXR5X2luaXQoJmFkZXYtPnZjZS5lbnRp
dHksIERSTV9TQ0hFRF9QUklPUklUWV9OT1JNQUwsCi0JCQkJICAmc2NoZWQsIDEsIE5VTEwpOwot
CWlmIChyICE9IDApIHsKLQkJRFJNX0VSUk9SKCJGYWlsZWQgc2V0dGluZyB1cCBWQ0UgcnVuIHF1
ZXVlLlxuIik7Ci0JCXJldHVybiByOworCWlmICghYWRldi0+dmNlLmVudGl0eV9pbml0aWFsaXpl
ZCkgeworCQlyaW5nID0gJmFkZXYtPnZjZS5yaW5nWzBdOworCQlzY2hlZCA9ICZyaW5nLT5zY2hl
ZDsKKwkJciA9IGRybV9zY2hlZF9lbnRpdHlfaW5pdCgmYWRldi0+dmNlLmVudGl0eSwgRFJNX1ND
SEVEX1BSSU9SSVRZX05PUk1BTCwKKwkJCQkJICAmc2NoZWQsIDEsIE5VTEwpOworCQlpZiAociAh
PSAwKSB7CisJCQlEUk1fRVJST1IoIkZhaWxlZCBzZXR0aW5nIHVwIFZDRSBydW4gcXVldWUuXG4i
KTsKKwkJCXJldHVybiByOworCQl9CisJCWFkZXYtPnZjZS5lbnRpdHlfaW5pdGlhbGl6ZWQgPSB0
cnVlOwogCX0KIAogCXJldHVybiAwOwpkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9h
bWRncHUvYW1kZ3B1X3ZjZS5oIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3Zj
ZS5oCmluZGV4IGVhNjgwZmM5YTZjMy4uMGY2Y2ExMTZkNTM5IDEwMDY0NAotLS0gYS9kcml2ZXJz
L2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfdmNlLmgKKysrIGIvZHJpdmVycy9ncHUvZHJtL2Ft
ZC9hbWRncHUvYW1kZ3B1X3ZjZS5oCkBAIC01MSw2ICs1MSw3IEBAIHN0cnVjdCBhbWRncHVfdmNl
IHsKIAlzdHJ1Y3QgZHJtX3NjaGVkX2VudGl0eQllbnRpdHk7CiAJdWludDMyX3QgICAgICAgICAg
ICAgICAgc3JibV9zb2Z0X3Jlc2V0OwogCXVuc2lnbmVkCQludW1fcmluZ3M7CisJYm9vbCAgICAg
ICAgICAgICAgICAgICAgZW50aXR5X2luaXRpYWxpemVkOwogfTsKIAogaW50IGFtZGdwdV92Y2Vf
c3dfaW5pdChzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRldiwgdW5zaWduZWQgbG9uZyBzaXplKTsK
ZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L3V2ZF92M18xLmMgYi9kcml2
ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS91dmRfdjNfMS5jCmluZGV4IDU4YThmNzhjMDAzYy4uZWU5
MjM3OGQyMjEwIDEwMDY0NAotLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS91dmRfdjNf
MS5jCisrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L3V2ZF92M18xLmMKQEAgLTU3Nyw4
ICs1NzcsNiBAQCBzdGF0aWMgaW50IHV2ZF92M18xX3N3X2luaXQodm9pZCAqaGFuZGxlKQogCXB0
ciArPSB1Y29kZV9sZW47CiAJbWVtY3B5KCZhZGV2LT51dmQua2V5c2VsZWN0LCBwdHIsIDQpOwog
Ci0JciA9IGFtZGdwdV91dmRfZW50aXR5X2luaXQoYWRldik7Ci0KIAlyZXR1cm4gcjsKIH0KIApA
QCAtODA1LDEwICs4MDMsMTcgQEAgc3RhdGljIGludCB1dmRfdjNfMV9zZXRfcG93ZXJnYXRpbmdf
c3RhdGUodm9pZCAqaGFuZGxlLAogCXJldHVybiAwOwogfQogCitzdGF0aWMgaW50IHV2ZF92M18x
X2xhdGVfaW5pdCh2b2lkICpoYW5kbGUpCit7CisJc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYg
PSAoc3RydWN0IGFtZGdwdV9kZXZpY2UgKiloYW5kbGU7CisKKwlyZXR1cm4gYW1kZ3B1X3V2ZF9l
bnRpdHlfaW5pdChhZGV2KTsKK30KKwogc3RhdGljIGNvbnN0IHN0cnVjdCBhbWRfaXBfZnVuY3Mg
dXZkX3YzXzFfaXBfZnVuY3MgPSB7CiAJLm5hbWUgPSAidXZkX3YzXzEiLAogCS5lYXJseV9pbml0
ID0gdXZkX3YzXzFfZWFybHlfaW5pdCwKLQkubGF0ZV9pbml0ID0gTlVMTCwKKwkubGF0ZV9pbml0
ID0gdXZkX3YzXzFfbGF0ZV9pbml0LAogCS5zd19pbml0ID0gdXZkX3YzXzFfc3dfaW5pdCwKIAku
c3dfZmluaSA9IHV2ZF92M18xX3N3X2ZpbmksCiAJLmh3X2luaXQgPSB1dmRfdjNfMV9od19pbml0
LApkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvdXZkX3Y0XzIuYyBiL2Ry
aXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L3V2ZF92NF8yLmMKaW5kZXggZDNiMWUzMWY1NDUwLi5j
OWE3ZmY0MjhkYzQgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L3V2ZF92
NF8yLmMKKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvdXZkX3Y0XzIuYwpAQCAtMTI3
LDggKzEyNyw2IEBAIHN0YXRpYyBpbnQgdXZkX3Y0XzJfc3dfaW5pdCh2b2lkICpoYW5kbGUpCiAJ
aWYgKHIpCiAJCXJldHVybiByOwogCi0JciA9IGFtZGdwdV91dmRfZW50aXR5X2luaXQoYWRldik7
Ci0KIAlyZXR1cm4gcjsKIH0KIApAQCAtNzU1LDEwICs3NTMsMTcgQEAgc3RhdGljIGludCB1dmRf
djRfMl9zZXRfcG93ZXJnYXRpbmdfc3RhdGUodm9pZCAqaGFuZGxlLAogCX0KIH0KIAorc3RhdGlj
IGludCB1dmRfdjRfMl9sYXRlX2luaXQodm9pZCAqaGFuZGxlKQoreworCXN0cnVjdCBhbWRncHVf
ZGV2aWNlICphZGV2ID0gKHN0cnVjdCBhbWRncHVfZGV2aWNlICopaGFuZGxlOworCisJcmV0dXJu
IGFtZGdwdV91dmRfZW50aXR5X2luaXQoYWRldik7Cit9CisKIHN0YXRpYyBjb25zdCBzdHJ1Y3Qg
YW1kX2lwX2Z1bmNzIHV2ZF92NF8yX2lwX2Z1bmNzID0gewogCS5uYW1lID0gInV2ZF92NF8yIiwK
IAkuZWFybHlfaW5pdCA9IHV2ZF92NF8yX2Vhcmx5X2luaXQsCi0JLmxhdGVfaW5pdCA9IE5VTEws
CisJLmxhdGVfaW5pdCA9IHV2ZF92NF8yX2xhdGVfaW5pdCwKIAkuc3dfaW5pdCA9IHV2ZF92NF8y
X3N3X2luaXQsCiAJLnN3X2ZpbmkgPSB1dmRfdjRfMl9zd19maW5pLAogCS5od19pbml0ID0gdXZk
X3Y0XzJfaHdfaW5pdCwKZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L3V2
ZF92NV8wLmMgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS91dmRfdjVfMC5jCmluZGV4IDVh
ODExNjQzN2FiZi4uZWQ3Y2FlY2I1Nzc1IDEwMDY0NAotLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1k
L2FtZGdwdS91dmRfdjVfMC5jCisrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L3V2ZF92
NV8wLmMKQEAgLTEyNSw4ICsxMjUsNiBAQCBzdGF0aWMgaW50IHV2ZF92NV8wX3N3X2luaXQodm9p
ZCAqaGFuZGxlKQogCWlmIChyKQogCQlyZXR1cm4gcjsKIAotCXIgPSBhbWRncHVfdXZkX2VudGl0
eV9pbml0KGFkZXYpOwotCiAJcmV0dXJuIHI7CiB9CiAKQEAgLTg2MiwxMCArODYwLDE3IEBAIHN0
YXRpYyB2b2lkIHV2ZF92NV8wX2dldF9jbG9ja2dhdGluZ19zdGF0ZSh2b2lkICpoYW5kbGUsIHU2
NCAqZmxhZ3MpCiAJbXV0ZXhfdW5sb2NrKCZhZGV2LT5wbS5tdXRleCk7CiB9CiAKK3N0YXRpYyBp
bnQgdXZkX3Y1XzBfbGF0ZV9pbml0KHZvaWQgKmhhbmRsZSkKK3sKKwlzdHJ1Y3QgYW1kZ3B1X2Rl
dmljZSAqYWRldiA9IChzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqKWhhbmRsZTsKKworCXJldHVybiBh
bWRncHVfdXZkX2VudGl0eV9pbml0KGFkZXYpOworfQorCiBzdGF0aWMgY29uc3Qgc3RydWN0IGFt
ZF9pcF9mdW5jcyB1dmRfdjVfMF9pcF9mdW5jcyA9IHsKIAkubmFtZSA9ICJ1dmRfdjVfMCIsCiAJ
LmVhcmx5X2luaXQgPSB1dmRfdjVfMF9lYXJseV9pbml0LAotCS5sYXRlX2luaXQgPSBOVUxMLAor
CS5sYXRlX2luaXQgPSB1dmRfdjVfMF9sYXRlX2luaXQsCiAJLnN3X2luaXQgPSB1dmRfdjVfMF9z
d19pbml0LAogCS5zd19maW5pID0gdXZkX3Y1XzBfc3dfZmluaSwKIAkuaHdfaW5pdCA9IHV2ZF92
NV8wX2h3X2luaXQsCmRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS91dmRf
djZfMC5jIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvdXZkX3Y2XzAuYwppbmRleCA3NGMw
OTIzMGFlYjMuLmQxNDg4ODI3OGJmZSAxMDA2NDQKLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9h
bWRncHUvdXZkX3Y2XzAuYworKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS91dmRfdjZf
MC5jCkBAIC00MzIsOCArNDMyLDYgQEAgc3RhdGljIGludCB1dmRfdjZfMF9zd19pbml0KHZvaWQg
KmhhbmRsZSkKIAkJfQogCX0KIAotCXIgPSBhbWRncHVfdXZkX2VudGl0eV9pbml0KGFkZXYpOwot
CiAJcmV0dXJuIHI7CiB9CiAKQEAgLTE1MjcsMTAgKzE1MjUsMTcgQEAgc3RhdGljIHZvaWQgdXZk
X3Y2XzBfZ2V0X2Nsb2NrZ2F0aW5nX3N0YXRlKHZvaWQgKmhhbmRsZSwgdTY0ICpmbGFncykKIAlt
dXRleF91bmxvY2soJmFkZXYtPnBtLm11dGV4KTsKIH0KIAorc3RhdGljIGludCB1dmRfdjZfMF9s
YXRlX2luaXQodm9pZCAqaGFuZGxlKQoreworCXN0cnVjdCBhbWRncHVfZGV2aWNlICphZGV2ID0g
KHN0cnVjdCBhbWRncHVfZGV2aWNlICopaGFuZGxlOworCisJcmV0dXJuIGFtZGdwdV91dmRfZW50
aXR5X2luaXQoYWRldik7Cit9CisKIHN0YXRpYyBjb25zdCBzdHJ1Y3QgYW1kX2lwX2Z1bmNzIHV2
ZF92Nl8wX2lwX2Z1bmNzID0gewogCS5uYW1lID0gInV2ZF92Nl8wIiwKIAkuZWFybHlfaW5pdCA9
IHV2ZF92Nl8wX2Vhcmx5X2luaXQsCi0JLmxhdGVfaW5pdCA9IE5VTEwsCisJLmxhdGVfaW5pdCA9
IHV2ZF92Nl8wX2xhdGVfaW5pdCwKIAkuc3dfaW5pdCA9IHV2ZF92Nl8wX3N3X2luaXQsCiAJLnN3
X2ZpbmkgPSB1dmRfdjZfMF9zd19maW5pLAogCS5od19pbml0ID0gdXZkX3Y2XzBfaHdfaW5pdCwK
ZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L3V2ZF92N18wLmMgYi9kcml2
ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS91dmRfdjdfMC5jCmluZGV4IDFjNDJjZjEwY2MyOS4uN2Jh
OTNlMDg5NjBmIDEwMDY0NAotLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS91dmRfdjdf
MC5jCisrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L3V2ZF92N18wLmMKQEAgLTQ4MCwx
MCArNDgwLDYgQEAgc3RhdGljIGludCB1dmRfdjdfMF9zd19pbml0KHZvaWQgKmhhbmRsZSkKIAlp
ZiAocikKIAkJcmV0dXJuIHI7CiAKLQlyID0gYW1kZ3B1X3V2ZF9lbnRpdHlfaW5pdChhZGV2KTsK
LQlpZiAocikKLQkJcmV0dXJuIHI7Ci0KIAlyID0gYW1kZ3B1X3ZpcnRfYWxsb2NfbW1fdGFibGUo
YWRldik7CiAJaWYgKHIpCiAJCXJldHVybiByOwpAQCAtMTc4NiwxMCArMTc4MiwxNyBAQCBzdGF0
aWMgaW50IHV2ZF92N18wX3NldF9jbG9ja2dhdGluZ19zdGF0ZSh2b2lkICpoYW5kbGUsCiAJcmV0
dXJuIDA7CiB9CiAKK3N0YXRpYyBpbnQgdXZkX3Y3XzBfbGF0ZV9pbml0KHZvaWQgKmhhbmRsZSkK
K3sKKwlzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRldiA9IChzdHJ1Y3QgYW1kZ3B1X2RldmljZSAq
KWhhbmRsZTsKKworCXJldHVybiBhbWRncHVfdXZkX2VudGl0eV9pbml0KGFkZXYpOworfQorCiBj
b25zdCBzdHJ1Y3QgYW1kX2lwX2Z1bmNzIHV2ZF92N18wX2lwX2Z1bmNzID0gewogCS5uYW1lID0g
InV2ZF92N18wIiwKIAkuZWFybHlfaW5pdCA9IHV2ZF92N18wX2Vhcmx5X2luaXQsCi0JLmxhdGVf
aW5pdCA9IE5VTEwsCisJLmxhdGVfaW5pdCA9IHV2ZF92N18wX2xhdGVfaW5pdCwKIAkuc3dfaW5p
dCA9IHV2ZF92N18wX3N3X2luaXQsCiAJLnN3X2ZpbmkgPSB1dmRfdjdfMF9zd19maW5pLAogCS5o
d19pbml0ID0gdXZkX3Y3XzBfaHdfaW5pdCwKZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9h
bWQvYW1kZ3B1L3ZjZV92Ml8wLmMgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS92Y2VfdjJf
MC5jCmluZGV4IDY3ZWIwMWZlZjc4OS4uZTE3YmE4NmMxZmI2IDEwMDY0NAotLS0gYS9kcml2ZXJz
L2dwdS9kcm0vYW1kL2FtZGdwdS92Y2VfdjJfMC5jCisrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQv
YW1kZ3B1L3ZjZV92Ml8wLmMKQEAgLTQ0MSw4ICs0NDEsNiBAQCBzdGF0aWMgaW50IHZjZV92Ml8w
X3N3X2luaXQodm9pZCAqaGFuZGxlKQogCQkJcmV0dXJuIHI7CiAJfQogCi0JciA9IGFtZGdwdV92
Y2VfZW50aXR5X2luaXQoYWRldik7Ci0KIAlyZXR1cm4gcjsKIH0KIApAQCAtNjEzLDEwICs2MTEs
MTcgQEAgc3RhdGljIGludCB2Y2VfdjJfMF9zZXRfcG93ZXJnYXRpbmdfc3RhdGUodm9pZCAqaGFu
ZGxlLAogCQlyZXR1cm4gdmNlX3YyXzBfc3RhcnQoYWRldik7CiB9CiAKK3N0YXRpYyBpbnQgdmNl
X3YyXzBfbGF0ZV9pbml0KHZvaWQgKmhhbmRsZSkKK3sKKwlzdHJ1Y3QgYW1kZ3B1X2RldmljZSAq
YWRldiA9IChzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqKWhhbmRsZTsKKworCXJldHVybiBhbWRncHVf
dmNlX2VudGl0eV9pbml0KGFkZXYpOworfQorCiBzdGF0aWMgY29uc3Qgc3RydWN0IGFtZF9pcF9m
dW5jcyB2Y2VfdjJfMF9pcF9mdW5jcyA9IHsKIAkubmFtZSA9ICJ2Y2VfdjJfMCIsCiAJLmVhcmx5
X2luaXQgPSB2Y2VfdjJfMF9lYXJseV9pbml0LAotCS5sYXRlX2luaXQgPSBOVUxMLAorCS5sYXRl
X2luaXQgPSB2Y2VfdjJfMF9sYXRlX2luaXQsCiAJLnN3X2luaXQgPSB2Y2VfdjJfMF9zd19pbml0
LAogCS5zd19maW5pID0gdmNlX3YyXzBfc3dfZmluaSwKIAkuaHdfaW5pdCA9IHZjZV92Ml8wX2h3
X2luaXQsCmRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS92Y2VfdjNfMC5j
IGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvdmNlX3YzXzAuYwppbmRleCAxOGY2ZTYyYWYz
MzkuLjM5NmQ4MTEzZDA0MSAxMDA2NDQKLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUv
dmNlX3YzXzAuYworKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS92Y2VfdjNfMC5jCkBA
IC00NTAsOCArNDUwLDYgQEAgc3RhdGljIGludCB2Y2VfdjNfMF9zd19pbml0KHZvaWQgKmhhbmRs
ZSkKIAkJCXJldHVybiByOwogCX0KIAotCXIgPSBhbWRncHVfdmNlX2VudGl0eV9pbml0KGFkZXYp
OwotCiAJcmV0dXJuIHI7CiB9CiAKQEAgLTg5NiwxMCArODk0LDE3IEBAIHN0YXRpYyB2b2lkIHZj
ZV92M18wX2VtaXRfcGlwZWxpbmVfc3luYyhzdHJ1Y3QgYW1kZ3B1X3JpbmcgKnJpbmcpCiAJYW1k
Z3B1X3Jpbmdfd3JpdGUocmluZywgc2VxKTsKIH0KIAorc3RhdGljIGludCB2Y2VfdjNfMF9sYXRl
X2luaXQodm9pZCAqaGFuZGxlKQoreworCXN0cnVjdCBhbWRncHVfZGV2aWNlICphZGV2ID0gKHN0
cnVjdCBhbWRncHVfZGV2aWNlICopaGFuZGxlOworCisJcmV0dXJuIGFtZGdwdV92Y2VfZW50aXR5
X2luaXQoYWRldik7Cit9CisKIHN0YXRpYyBjb25zdCBzdHJ1Y3QgYW1kX2lwX2Z1bmNzIHZjZV92
M18wX2lwX2Z1bmNzID0gewogCS5uYW1lID0gInZjZV92M18wIiwKIAkuZWFybHlfaW5pdCA9IHZj
ZV92M18wX2Vhcmx5X2luaXQsCi0JLmxhdGVfaW5pdCA9IE5VTEwsCisJLmxhdGVfaW5pdCA9IHZj
ZV92M18wX2xhdGVfaW5pdCwKIAkuc3dfaW5pdCA9IHZjZV92M18wX3N3X2luaXQsCiAJLnN3X2Zp
bmkgPSB2Y2VfdjNfMF9zd19maW5pLAogCS5od19pbml0ID0gdmNlX3YzXzBfaHdfaW5pdCwKZGlm
ZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L3ZjZV92NF8wLmMgYi9kcml2ZXJz
L2dwdS9kcm0vYW1kL2FtZGdwdS92Y2VfdjRfMC5jCmluZGV4IGUwYjcwY2QzYjY5Ny4uNzQwZTc1
MjkwNjNjIDEwMDY0NAotLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS92Y2VfdjRfMC5j
CisrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L3ZjZV92NF8wLmMKQEAgLTQ4NiwxMSAr
NDg2LDYgQEAgc3RhdGljIGludCB2Y2VfdjRfMF9zd19pbml0KHZvaWQgKmhhbmRsZSkKIAkJCXJl
dHVybiByOwogCX0KIAotCi0JciA9IGFtZGdwdV92Y2VfZW50aXR5X2luaXQoYWRldik7Ci0JaWYg
KHIpCi0JCXJldHVybiByOwotCiAJciA9IGFtZGdwdV92aXJ0X2FsbG9jX21tX3RhYmxlKGFkZXYp
OwogCWlmIChyKQogCQlyZXR1cm4gcjsKQEAgLTEwNzgsMTAgKzEwNzMsMTcgQEAgc3RhdGljIGlu
dCB2Y2VfdjRfMF9wcm9jZXNzX2ludGVycnVwdChzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRldiwK
IAlyZXR1cm4gMDsKIH0KIAorc3RhdGljIGludCB2Y2VfdjRfMF9sYXRlX2luaXQodm9pZCAqaGFu
ZGxlKQoreworCXN0cnVjdCBhbWRncHVfZGV2aWNlICphZGV2ID0gKHN0cnVjdCBhbWRncHVfZGV2
aWNlICopaGFuZGxlOworCisJcmV0dXJuIGFtZGdwdV92Y2VfZW50aXR5X2luaXQoYWRldik7Cit9
CisKIGNvbnN0IHN0cnVjdCBhbWRfaXBfZnVuY3MgdmNlX3Y0XzBfaXBfZnVuY3MgPSB7CiAJLm5h
bWUgPSAidmNlX3Y0XzAiLAogCS5lYXJseV9pbml0ID0gdmNlX3Y0XzBfZWFybHlfaW5pdCwKLQku
bGF0ZV9pbml0ID0gTlVMTCwKKwkubGF0ZV9pbml0ID0gdmNlX3Y0XzBfbGF0ZV9pbml0LAogCS5z
d19pbml0ID0gdmNlX3Y0XzBfc3dfaW5pdCwKIAkuc3dfZmluaSA9IHZjZV92NF8wX3N3X2Zpbmks
CiAJLmh3X2luaXQgPSB2Y2VfdjRfMF9od19pbml0LAotLSAKMi40MS4wCgo=
--0000000000009811660609953dff--
