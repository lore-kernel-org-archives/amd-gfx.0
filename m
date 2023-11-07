Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D3F8C4167D
	for <amd-gfx@archiver.kernel.org>; Tue,  7 Nov 2023 14:47:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C4BC810E0C3;
	Tue,  7 Nov 2023 14:47:37 +0000 (UTC)
Received: from mail-oa1-x32.google.com (mail-oa1-x32.google.com
 [IPv6:2001:4860:4864:20::32])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 62AE910E0C3
 for <amd-gfx@lists.freedesktop.org>; Tue,  7 Nov 2023 14:47:36 +0000 (UTC)
Received: by mail-oa1-x32.google.com with SMTP id
 586e51a60fabf-1efad296d42so3470262fac.2
 for <amd-gfx@lists.freedesktop.org>; Tue, 07 Nov 2023 06:47:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1699368455; x=1699973255; darn=lists.freedesktop.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=IrJyZnj0RbpOWPpvAAma+krRWsj7cupGUhMzZvz5kjA=;
 b=IF9aS+WVdjTAanrouhGh5Rq4pO5pKu+LQQDHbsG0T97O9hZevinNZYBoynFy3r5/mz
 CK+mc2Z+swslTrFqWOwga6U9x+8V78qBQq64Zm29HW6j4d8s5GhdAKP3vKv5SlFzucvT
 g5F8RwI2gen7L9orTX9lzW9q2HxyrUk9b85N4Y+o6kr1tvtLtY4q/gEYwBWPgqGEEu7/
 26HUdcxPQMR9wYwq1F/QbUkj7Ky8lZEQaX6pDOgs2iomDAEZ3ZzWxBpbh9jHZsStXmTZ
 2JXronqTZu9ErtnncpsjhvV+7fI1Tb2jtn5qtsyeEGhJ3Qn/PjWehBa9RzUm6utxoGSe
 qFxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699368455; x=1699973255;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=IrJyZnj0RbpOWPpvAAma+krRWsj7cupGUhMzZvz5kjA=;
 b=ZYgkmvE1b+9eq2tnNdimvwej4v1ttZa4z59Pc0xH2CwTqckYTOwMseZkGcyV/Cg0c+
 oZ9flR54TGS0b1wtAv19bgNm/keu+bfqLYYTHBDy/I9ccVxOFru3Zx+yaDyVNa6Luti5
 9KzF7PwZodtqsUTF3tLeBNzI7bWm+v7n9MJPVfWreU0wjUaNXXdl9wikd1p5S2GDM1z8
 CgAQf9W8093/kjqutzuNfWXdUnOlkEMlaqTyT5BcBTPWxLZsuDtjZ+OZQuCtoix7McuA
 91ubQEVH1ej7DZfZpmtSLYYYZ10M/rXVolwK38ZRLuDK90Jc4wvu4j4Wt+AidFs9eqU5
 II7A==
X-Gm-Message-State: AOJu0YwhowW5aPmaFTjqcw29bGtsuBNVD9FPyG+RwM6R4Jrhh/euF56D
 HpxRt84chr8qUxBhS4thLqE9lAKnKUfEqsx2n18=
X-Google-Smtp-Source: AGHT+IHD77RLDMP9h6C60JMSPxD+f8f4BtijxRdk2Fkz5bxZ30NkxFf152vR6Xn5ppRh8YVIvXcb7TtB7BDTAcHVIhw=
X-Received: by 2002:a05:6871:5314:b0:1ea:9898:c07f with SMTP id
 hx20-20020a056871531400b001ea9898c07fmr3431949oac.22.1699368455367; Tue, 07
 Nov 2023 06:47:35 -0800 (PST)
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
In-Reply-To: <CADnq5_OB0OvtqJf5nue-XsTZxOcnfN0Sy6pyryW_GF_Y+S6eYg@mail.gmail.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 7 Nov 2023 09:47:24 -0500
Message-ID: <CADnq5_OkTuEJ+i+MpfZprSjkGcG99OVSndwyZYWiYEDMEvatgw@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: move buffer funcs setting up a level
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>
Content-Type: multipart/mixed; boundary="000000000000200a9d0609910dc3"
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

--000000000000200a9d0609910dc3
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 7, 2023 at 9:19=E2=80=AFAM Alex Deucher <alexdeucher@gmail.com>=
 wrote:
>
> On Tue, Nov 7, 2023 at 5:52=E2=80=AFAM Christian K=C3=B6nig
> <ckoenig.leichtzumerken@gmail.com> wrote:
> >
> > Am 03.11.23 um 23:10 schrieb Alex Deucher:
> > > On Fri, Nov 3, 2023 at 4:17=E2=80=AFPM Alex Deucher <alexdeucher@gmai=
l.com> wrote:
> > >> On Thu, Oct 26, 2023 at 4:17=E2=80=AFPM Luben Tuikov <ltuikov89@gmai=
l.com> wrote:
> > >>> Pushed to drm-misc-next.
> > >> BTW, I'm seeing the following on older GPUs with VCE and UVD even wi=
th
> > >> this patch:
> > >> [   11.886024] amdgpu 0000:0a:00.0: [drm] *ERROR* drm_sched_job_init=
:
> > >> entity has no rq!
> > >> [   11.886028] amdgpu 0000:0a:00.0: [drm:amdgpu_ib_ring_tests
> > >> [amdgpu]] *ERROR* IB test failed on uvd (-2).
> > >> [   11.889927] amdgpu 0000:0a:00.0: [drm] *ERROR* drm_sched_job_init=
:
> > >> entity has no rq!
> > >> [   11.889930] amdgpu 0000:0a:00.0: [drm:amdgpu_ib_ring_tests
> > >> [amdgpu]] *ERROR* IB test failed on vce0 (-2).
> > >> [   11.890172] [drm:process_one_work] *ERROR* ib ring test failed (-=
2).
> > >> Seems to be specific to UVD and VCE, I don't see anything similar wi=
th
> > >> VCN, but the flows for both are pretty similar.  Not sure why we are
> > >> not seeing it for VCN.  Just a heads up if you have any ideas.  Will
> > >> take a closer look next week.
> > > + Leo
> > >
> > > I found the problem.  We set up scheduling entities for UVD and VCE
> > > specifically and not for any other engines.  I don't remember why
> > > offhand.  I'm guessing maybe to deal with the session limits on UVD
> > > and VCE?  If so I'm not sure of a clean way to fix this.
> >
> > I haven't looked through all my mails yet so could be that Leo has
> > already answered this.
> >
> > The UVD/VCE entities are used for the older chips where applications
> > have to use create/destroy messages to the firmware.
> >
> > If an application exits without cleaning up their handles the kernel
> > sends the appropriate destroy messages itself. For an example see
> > amdgpu_uvd_free_handles().
> >
> > We used to initialize those entities with separate calls after the
> > scheduler had been brought up, see amdgpu_uvd_entity_init() for an exam=
ple.
> >
> > But this was somehow messed up and we now do the call to
> > amdgpu_uvd_entity_init() at the end of *_sw_init() instead of _late_ini=
t().
> >
> > I suggest to just come up with a function which can be used for the
> > late_init() callback of the UVD/VCE blocks.
>
> I guess the issue is that we only need to initialize the entity once
> so sw_init makes sense.  All of the other functions get called at
> resume time, etc.  I think we could probably put it into
> amdgpu_device_init_schedulers() somehow.

I think something like this might do the trick.

Alex

>
> Alex
>
> >
> > Christian.
> >
> > >
> > > Alex
> > >
> > >> Alex
> > >>
> > >>> Regards,
> > >>> Luben
> > >>>
> > >>> On 2023-10-26 15:52, Luben Tuikov wrote:
> > >>>> On 2023-10-26 15:32, Alex Deucher wrote:
> > >>>>> On Thu, Oct 26, 2023 at 2:22=E2=80=AFAM Christian K=C3=B6nig
> > >>>>> <ckoenig.leichtzumerken@gmail.com> wrote:
> > >>>>>> Am 25.10.23 um 19:19 schrieb Alex Deucher:
> > >>>>>>> Rather than doing this in the IP code for the SDMA paging
> > >>>>>>> engine, move it up to the core device level init level.
> > >>>>>>> This should fix the scheduler init ordering.
> > >>>>>>>
> > >>>>>>> v2: drop extra parens
> > >>>>>>> v3: drop SDMA helpers
> > >>>>>>>
> > >>>>>>> Tested-by: Luben Tuikov <luben.tuikov@amd.com>
> > >>>>>>> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> > >>>>>> I don't know of hand if the high level function really cover eve=
rything,
> > >>>>>> so only Acked-by: Christian K=C3=B6nig <christian.koenig@amd.com=
> for now.
> > >>>>>>
> > >>>>> Luben,
> > >>>>>
> > >>>>> Was this needed for some of the scheduler stuff that is pending? =
 If
> > >>>>> you would rather take it via drm-misc to align with the scheduler
> > >>>>> changes, that works for me, otherwise I can take it via the amdgp=
u
> > >>>>> tree.
> > >>>> Hi Alex,
> > >>>>
> > >>>> Yes, it does.
> > >>>>
> > >>>> I can take it via drm-misc-next as that where the scheduler change=
s landed.
> > >>>>
> > >>>> I'll add Christian's Acked-by.
> > >>>>
> > >>>> I'll add a Fixes tag because ideally it should've gone before the =
dynamic
> > >>>> sched_rq commit.
> > >>>>
> > >>>> Thanks for the heads-up!
> > >>>>
> > >>>> Regards,
> > >>>> Luben
> > >>>>
> > >>>>
> > >>>>
> > >>>>> Thanks,
> > >>>>>
> > >>>>> Alex
> > >>>>>
> > >>>>>
> > >>>>>> Christian.
> > >>>>>>
> > >>>>>>> ---
> > >>>>>>>    drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 15 ++++++++++++=
+++
> > >>>>>>>    drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c   | 21 ------------=
---------
> > >>>>>>>    drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h   |  1 -
> > >>>>>>>    drivers/gpu/drm/amd/amdgpu/cik_sdma.c      |  5 -----
> > >>>>>>>    drivers/gpu/drm/amd/amdgpu/sdma_v2_4.c     |  5 -----
> > >>>>>>>    drivers/gpu/drm/amd/amdgpu/sdma_v3_0.c     |  5 -----
> > >>>>>>>    drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c     | 16 +-----------=
----
> > >>>>>>>    drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c     | 10 +---------
> > >>>>>>>    drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c     | 10 +---------
> > >>>>>>>    drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c     | 10 +---------
> > >>>>>>>    drivers/gpu/drm/amd/amdgpu/si_dma.c        |  5 -----
> > >>>>>>>    11 files changed, 19 insertions(+), 84 deletions(-)
> > >>>>>>>
> > >>>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drive=
rs/gpu/drm/amd/amdgpu/amdgpu_device.c
> > >>>>>>> index 2031a467b721..5c90080e93ba 100644
> > >>>>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> > >>>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> > >>>>>>> @@ -2662,6 +2662,9 @@ static int amdgpu_device_ip_init(struct a=
mdgpu_device *adev)
> > >>>>>>>        if (r)
> > >>>>>>>                goto init_failed;
> > >>>>>>>
> > >>>>>>> +     if (adev->mman.buffer_funcs_ring->sched.ready)
> > >>>>>>> +             amdgpu_ttm_set_buffer_funcs_status(adev, true);
> > >>>>>>> +
> > >>>>>>>        /* Don't init kfd if whole hive need to be reset during =
init */
> > >>>>>>>        if (!adev->gmc.xgmi.pending_reset) {
> > >>>>>>>                kgd2kfd_init_zone_device(adev);
> > >>>>>>> @@ -3260,6 +3263,8 @@ int amdgpu_device_ip_suspend(struct amdgp=
u_device *adev)
> > >>>>>>>                amdgpu_virt_request_full_gpu(adev, false);
> > >>>>>>>        }
> > >>>>>>>
> > >>>>>>> +     amdgpu_ttm_set_buffer_funcs_status(adev, false);
> > >>>>>>> +
> > >>>>>>>        r =3D amdgpu_device_ip_suspend_phase1(adev);
> > >>>>>>>        if (r)
> > >>>>>>>                return r;
> > >>>>>>> @@ -3449,6 +3454,9 @@ static int amdgpu_device_ip_resume(struct=
 amdgpu_device *adev)
> > >>>>>>>
> > >>>>>>>        r =3D amdgpu_device_ip_resume_phase2(adev);
> > >>>>>>>
> > >>>>>>> +     if (adev->mman.buffer_funcs_ring->sched.ready)
> > >>>>>>> +             amdgpu_ttm_set_buffer_funcs_status(adev, true);
> > >>>>>>> +
> > >>>>>>>        return r;
> > >>>>>>>    }
> > >>>>>>>
> > >>>>>>> @@ -4236,6 +4244,8 @@ void amdgpu_device_fini_hw(struct amdgpu_=
device *adev)
> > >>>>>>>        /* disable ras feature must before hw fini */
> > >>>>>>>        amdgpu_ras_pre_fini(adev);
> > >>>>>>>
> > >>>>>>> +     amdgpu_ttm_set_buffer_funcs_status(adev, false);
> > >>>>>>> +
> > >>>>>>>        amdgpu_device_ip_fini_early(adev);
> > >>>>>>>
> > >>>>>>>        amdgpu_irq_fini_hw(adev);
> > >>>>>>> @@ -4407,6 +4417,8 @@ int amdgpu_device_suspend(struct drm_devi=
ce *dev, bool fbcon)
> > >>>>>>>
> > >>>>>>>        amdgpu_ras_suspend(adev);
> > >>>>>>>
> > >>>>>>> +     amdgpu_ttm_set_buffer_funcs_status(adev, false);
> > >>>>>>> +
> > >>>>>>>        amdgpu_device_ip_suspend_phase1(adev);
> > >>>>>>>
> > >>>>>>>        if (!adev->in_s0ix)
> > >>>>>>> @@ -5178,6 +5190,9 @@ int amdgpu_do_asic_reset(struct list_head=
 *device_list_handle,
> > >>>>>>>                                if (r)
> > >>>>>>>                                        goto out;
> > >>>>>>>
> > >>>>>>> +                             if (tmp_adev->mman.buffer_funcs_r=
ing->sched.ready)
> > >>>>>>> +                                     amdgpu_ttm_set_buffer_fun=
cs_status(tmp_adev, true);
> > >>>>>>> +
> > >>>>>>>                                if (vram_lost)
> > >>>>>>>                                        amdgpu_device_fill_reset=
_magic(tmp_adev);
> > >>>>>>>
> > >>>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c b/drivers=
/gpu/drm/amd/amdgpu/amdgpu_sdma.c
> > >>>>>>> index e8cbc4142d80..1d9d187de6ee 100644
> > >>>>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c
> > >>>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c
> > >>>>>>> @@ -292,27 +292,6 @@ int amdgpu_sdma_init_microcode(struct amdg=
pu_device *adev,
> > >>>>>>>        return err;
> > >>>>>>>    }
> > >>>>>>>
> > >>>>>>> -void amdgpu_sdma_unset_buffer_funcs_helper(struct amdgpu_devic=
e *adev)
> > >>>>>>> -{
> > >>>>>>> -     struct amdgpu_ring *sdma;
> > >>>>>>> -     int i;
> > >>>>>>> -
> > >>>>>>> -     for (i =3D 0; i < adev->sdma.num_instances; i++) {
> > >>>>>>> -             if (adev->sdma.has_page_queue) {
> > >>>>>>> -                     sdma =3D &adev->sdma.instance[i].page;
> > >>>>>>> -                     if (adev->mman.buffer_funcs_ring =3D=3D s=
dma) {
> > >>>>>>> -                             amdgpu_ttm_set_buffer_funcs_statu=
s(adev, false);
> > >>>>>>> -                             break;
> > >>>>>>> -                     }
> > >>>>>>> -             }
> > >>>>>>> -             sdma =3D &adev->sdma.instance[i].ring;
> > >>>>>>> -             if (adev->mman.buffer_funcs_ring =3D=3D sdma) {
> > >>>>>>> -                     amdgpu_ttm_set_buffer_funcs_status(adev, =
false);
> > >>>>>>> -                     break;
> > >>>>>>> -             }
> > >>>>>>> -     }
> > >>>>>>> -}
> > >>>>>>> -
> > >>>>>>>    int amdgpu_sdma_ras_sw_init(struct amdgpu_device *adev)
> > >>>>>>>    {
> > >>>>>>>        int err =3D 0;
> > >>>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h b/drivers=
/gpu/drm/amd/amdgpu/amdgpu_sdma.h
> > >>>>>>> index 513ac22120c1..173a2a308078 100644
> > >>>>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h
> > >>>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h
> > >>>>>>> @@ -169,7 +169,6 @@ int amdgpu_sdma_init_microcode(struct amdgp=
u_device *adev, u32 instance,
> > >>>>>>>                               bool duplicate);
> > >>>>>>>    void amdgpu_sdma_destroy_inst_ctx(struct amdgpu_device *adev=
,
> > >>>>>>>            bool duplicate);
> > >>>>>>> -void amdgpu_sdma_unset_buffer_funcs_helper(struct amdgpu_devic=
e *adev);
> > >>>>>>>    int amdgpu_sdma_ras_sw_init(struct amdgpu_device *adev);
> > >>>>>>>
> > >>>>>>>    #endif
> > >>>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/cik_sdma.c b/drivers/gp=
u/drm/amd/amdgpu/cik_sdma.c
> > >>>>>>> index ee5dce6f6043..a3fccc4c1f43 100644
> > >>>>>>> --- a/drivers/gpu/drm/amd/amdgpu/cik_sdma.c
> > >>>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/cik_sdma.c
> > >>>>>>> @@ -308,8 +308,6 @@ static void cik_sdma_gfx_stop(struct amdgpu=
_device *adev)
> > >>>>>>>        u32 rb_cntl;
> > >>>>>>>        int i;
> > >>>>>>>
> > >>>>>>> -     amdgpu_sdma_unset_buffer_funcs_helper(adev);
> > >>>>>>> -
> > >>>>>>>        for (i =3D 0; i < adev->sdma.num_instances; i++) {
> > >>>>>>>                rb_cntl =3D RREG32(mmSDMA0_GFX_RB_CNTL + sdma_of=
fsets[i]);
> > >>>>>>>                rb_cntl &=3D ~SDMA0_GFX_RB_CNTL__RB_ENABLE_MASK;
> > >>>>>>> @@ -498,9 +496,6 @@ static int cik_sdma_gfx_resume(struct amdgp=
u_device *adev)
> > >>>>>>>                r =3D amdgpu_ring_test_helper(ring);
> > >>>>>>>                if (r)
> > >>>>>>>                        return r;
> > >>>>>>> -
> > >>>>>>> -             if (adev->mman.buffer_funcs_ring =3D=3D ring)
> > >>>>>>> -                     amdgpu_ttm_set_buffer_funcs_status(adev, =
true);
> > >>>>>>>        }
> > >>>>>>>
> > >>>>>>>        return 0;
> > >>>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v2_4.c b/drivers/g=
pu/drm/amd/amdgpu/sdma_v2_4.c
> > >>>>>>> index b58a13bd75db..45377a175250 100644
> > >>>>>>> --- a/drivers/gpu/drm/amd/amdgpu/sdma_v2_4.c
> > >>>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/sdma_v2_4.c
> > >>>>>>> @@ -339,8 +339,6 @@ static void sdma_v2_4_gfx_stop(struct amdgp=
u_device *adev)
> > >>>>>>>        u32 rb_cntl, ib_cntl;
> > >>>>>>>        int i;
> > >>>>>>>
> > >>>>>>> -     amdgpu_sdma_unset_buffer_funcs_helper(adev);
> > >>>>>>> -
> > >>>>>>>        for (i =3D 0; i < adev->sdma.num_instances; i++) {
> > >>>>>>>                rb_cntl =3D RREG32(mmSDMA0_GFX_RB_CNTL + sdma_of=
fsets[i]);
> > >>>>>>>                rb_cntl =3D REG_SET_FIELD(rb_cntl, SDMA0_GFX_RB_=
CNTL, RB_ENABLE, 0);
> > >>>>>>> @@ -474,9 +472,6 @@ static int sdma_v2_4_gfx_resume(struct amdg=
pu_device *adev)
> > >>>>>>>                r =3D amdgpu_ring_test_helper(ring);
> > >>>>>>>                if (r)
> > >>>>>>>                        return r;
> > >>>>>>> -
> > >>>>>>> -             if (adev->mman.buffer_funcs_ring =3D=3D ring)
> > >>>>>>> -                     amdgpu_ttm_set_buffer_funcs_status(adev, =
true);
> > >>>>>>>        }
> > >>>>>>>
> > >>>>>>>        return 0;
> > >>>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v3_0.c b/drivers/g=
pu/drm/amd/amdgpu/sdma_v3_0.c
> > >>>>>>> index c5ea32687eb5..2ad615be4bb3 100644
> > >>>>>>> --- a/drivers/gpu/drm/amd/amdgpu/sdma_v3_0.c
> > >>>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/sdma_v3_0.c
> > >>>>>>> @@ -513,8 +513,6 @@ static void sdma_v3_0_gfx_stop(struct amdgp=
u_device *adev)
> > >>>>>>>        u32 rb_cntl, ib_cntl;
> > >>>>>>>        int i;
> > >>>>>>>
> > >>>>>>> -     amdgpu_sdma_unset_buffer_funcs_helper(adev);
> > >>>>>>> -
> > >>>>>>>        for (i =3D 0; i < adev->sdma.num_instances; i++) {
> > >>>>>>>                rb_cntl =3D RREG32(mmSDMA0_GFX_RB_CNTL + sdma_of=
fsets[i]);
> > >>>>>>>                rb_cntl =3D REG_SET_FIELD(rb_cntl, SDMA0_GFX_RB_=
CNTL, RB_ENABLE, 0);
> > >>>>>>> @@ -746,9 +744,6 @@ static int sdma_v3_0_gfx_resume(struct amdg=
pu_device *adev)
> > >>>>>>>                r =3D amdgpu_ring_test_helper(ring);
> > >>>>>>>                if (r)
> > >>>>>>>                        return r;
> > >>>>>>> -
> > >>>>>>> -             if (adev->mman.buffer_funcs_ring =3D=3D ring)
> > >>>>>>> -                     amdgpu_ttm_set_buffer_funcs_status(adev, =
true);
> > >>>>>>>        }
> > >>>>>>>
> > >>>>>>>        return 0;
> > >>>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c b/drivers/g=
pu/drm/amd/amdgpu/sdma_v4_0.c
> > >>>>>>> index 683d51ae4bf1..3d68dd5523c6 100644
> > >>>>>>> --- a/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
> > >>>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
> > >>>>>>> @@ -877,8 +877,6 @@ static void sdma_v4_0_gfx_enable(struct amd=
gpu_device *adev, bool enable)
> > >>>>>>>        u32 rb_cntl, ib_cntl;
> > >>>>>>>        int i;
> > >>>>>>>
> > >>>>>>> -     amdgpu_sdma_unset_buffer_funcs_helper(adev);
> > >>>>>>> -
> > >>>>>>>        for (i =3D 0; i < adev->sdma.num_instances; i++) {
> > >>>>>>>                rb_cntl =3D RREG32_SDMA(i, mmSDMA0_GFX_RB_CNTL);
> > >>>>>>>                rb_cntl =3D REG_SET_FIELD(rb_cntl, SDMA0_GFX_RB_=
CNTL, RB_ENABLE, enable ? 1 : 0);
> > >>>>>>> @@ -913,8 +911,6 @@ static void sdma_v4_0_page_stop(struct amdg=
pu_device *adev)
> > >>>>>>>        u32 rb_cntl, ib_cntl;
> > >>>>>>>        int i;
> > >>>>>>>
> > >>>>>>> -     amdgpu_sdma_unset_buffer_funcs_helper(adev);
> > >>>>>>> -
> > >>>>>>>        for (i =3D 0; i < adev->sdma.num_instances; i++) {
> > >>>>>>>                rb_cntl =3D RREG32_SDMA(i, mmSDMA0_PAGE_RB_CNTL)=
;
> > >>>>>>>                rb_cntl =3D REG_SET_FIELD(rb_cntl, SDMA0_PAGE_RB=
_CNTL,
> > >>>>>>> @@ -1402,13 +1398,7 @@ static int sdma_v4_0_start(struct amdgpu=
_device *adev)
> > >>>>>>>                        r =3D amdgpu_ring_test_helper(page);
> > >>>>>>>                        if (r)
> > >>>>>>>                                return r;
> > >>>>>>> -
> > >>>>>>> -                     if (adev->mman.buffer_funcs_ring =3D=3D p=
age)
> > >>>>>>> -                             amdgpu_ttm_set_buffer_funcs_statu=
s(adev, true);
> > >>>>>>>                }
> > >>>>>>> -
> > >>>>>>> -             if (adev->mman.buffer_funcs_ring =3D=3D ring)
> > >>>>>>> -                     amdgpu_ttm_set_buffer_funcs_status(adev, =
true);
> > >>>>>>>        }
> > >>>>>>>
> > >>>>>>>        return r;
> > >>>>>>> @@ -1921,11 +1911,8 @@ static int sdma_v4_0_hw_fini(void *handl=
e)
> > >>>>>>>        struct amdgpu_device *adev =3D (struct amdgpu_device *)h=
andle;
> > >>>>>>>        int i;
> > >>>>>>>
> > >>>>>>> -     if (amdgpu_sriov_vf(adev)) {
> > >>>>>>> -             /* disable the scheduler for SDMA */
> > >>>>>>> -             amdgpu_sdma_unset_buffer_funcs_helper(adev);
> > >>>>>>> +     if (amdgpu_sriov_vf(adev))
> > >>>>>>>                return 0;
> > >>>>>>> -     }
> > >>>>>>>
> > >>>>>>>        if (amdgpu_ras_is_supported(adev, AMDGPU_RAS_BLOCK__SDMA=
)) {
> > >>>>>>>                for (i =3D 0; i < adev->sdma.num_instances; i++)=
 {
> > >>>>>>> @@ -1964,7 +1951,6 @@ static int sdma_v4_0_resume(void *handle)
> > >>>>>>>        if (adev->in_s0ix) {
> > >>>>>>>                sdma_v4_0_enable(adev, true);
> > >>>>>>>                sdma_v4_0_gfx_enable(adev, true);
> > >>>>>>> -             amdgpu_ttm_set_buffer_funcs_status(adev, true);
> > >>>>>>>                return 0;
> > >>>>>>>        }
> > >>>>>>>
> > >>>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c b/drivers/g=
pu/drm/amd/amdgpu/sdma_v5_0.c
> > >>>>>>> index be5d099c9898..c78027ebdcb9 100644
> > >>>>>>> --- a/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c
> > >>>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c
> > >>>>>>> @@ -559,8 +559,6 @@ static void sdma_v5_0_gfx_stop(struct amdgp=
u_device *adev)
> > >>>>>>>        u32 rb_cntl, ib_cntl;
> > >>>>>>>        int i;
> > >>>>>>>
> > >>>>>>> -     amdgpu_sdma_unset_buffer_funcs_helper(adev);
> > >>>>>>> -
> > >>>>>>>        for (i =3D 0; i < adev->sdma.num_instances; i++) {
> > >>>>>>>                rb_cntl =3D RREG32_SOC15_IP(GC, sdma_v5_0_get_re=
g_offset(adev, i, mmSDMA0_GFX_RB_CNTL));
> > >>>>>>>                rb_cntl =3D REG_SET_FIELD(rb_cntl, SDMA0_GFX_RB_=
CNTL, RB_ENABLE, 0);
> > >>>>>>> @@ -825,9 +823,6 @@ static int sdma_v5_0_gfx_resume(struct amdg=
pu_device *adev)
> > >>>>>>>                r =3D amdgpu_ring_test_helper(ring);
> > >>>>>>>                if (r)
> > >>>>>>>                        return r;
> > >>>>>>> -
> > >>>>>>> -             if (adev->mman.buffer_funcs_ring =3D=3D ring)
> > >>>>>>> -                     amdgpu_ttm_set_buffer_funcs_status(adev, =
true);
> > >>>>>>>        }
> > >>>>>>>
> > >>>>>>>        return 0;
> > >>>>>>> @@ -1426,11 +1421,8 @@ static int sdma_v5_0_hw_fini(void *handl=
e)
> > >>>>>>>    {
> > >>>>>>>        struct amdgpu_device *adev =3D (struct amdgpu_device *)h=
andle;
> > >>>>>>>
> > >>>>>>> -     if (amdgpu_sriov_vf(adev)) {
> > >>>>>>> -             /* disable the scheduler for SDMA */
> > >>>>>>> -             amdgpu_sdma_unset_buffer_funcs_helper(adev);
> > >>>>>>> +     if (amdgpu_sriov_vf(adev))
> > >>>>>>>                return 0;
> > >>>>>>> -     }
> > >>>>>>>
> > >>>>>>>        sdma_v5_0_ctx_switch_enable(adev, false);
> > >>>>>>>        sdma_v5_0_enable(adev, false);
> > >>>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c b/drivers/g=
pu/drm/amd/amdgpu/sdma_v5_2.c
> > >>>>>>> index a3e8b10c071c..2e35f3571774 100644
> > >>>>>>> --- a/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
> > >>>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
> > >>>>>>> @@ -364,8 +364,6 @@ static void sdma_v5_2_gfx_stop(struct amdgp=
u_device *adev)
> > >>>>>>>        u32 rb_cntl, ib_cntl;
> > >>>>>>>        int i;
> > >>>>>>>
> > >>>>>>> -     amdgpu_sdma_unset_buffer_funcs_helper(adev);
> > >>>>>>> -
> > >>>>>>>        for (i =3D 0; i < adev->sdma.num_instances; i++) {
> > >>>>>>>                rb_cntl =3D RREG32_SOC15_IP(GC, sdma_v5_2_get_re=
g_offset(adev, i, mmSDMA0_GFX_RB_CNTL));
> > >>>>>>>                rb_cntl =3D REG_SET_FIELD(rb_cntl, SDMA0_GFX_RB_=
CNTL, RB_ENABLE, 0);
> > >>>>>>> @@ -625,9 +623,6 @@ static int sdma_v5_2_gfx_resume(struct amdg=
pu_device *adev)
> > >>>>>>>                r =3D amdgpu_ring_test_helper(ring);
> > >>>>>>>                if (r)
> > >>>>>>>                        return r;
> > >>>>>>> -
> > >>>>>>> -             if (adev->mman.buffer_funcs_ring =3D=3D ring)
> > >>>>>>> -                     amdgpu_ttm_set_buffer_funcs_status(adev, =
true);
> > >>>>>>>        }
> > >>>>>>>
> > >>>>>>>        return 0;
> > >>>>>>> @@ -1284,11 +1279,8 @@ static int sdma_v5_2_hw_fini(void *handl=
e)
> > >>>>>>>    {
> > >>>>>>>        struct amdgpu_device *adev =3D (struct amdgpu_device *)h=
andle;
> > >>>>>>>
> > >>>>>>> -     if (amdgpu_sriov_vf(adev)) {
> > >>>>>>> -             /* disable the scheduler for SDMA */
> > >>>>>>> -             amdgpu_sdma_unset_buffer_funcs_helper(adev);
> > >>>>>>> +     if (amdgpu_sriov_vf(adev))
> > >>>>>>>                return 0;
> > >>>>>>> -     }
> > >>>>>>>
> > >>>>>>>        sdma_v5_2_ctx_switch_enable(adev, false);
> > >>>>>>>        sdma_v5_2_enable(adev, false);
> > >>>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c b/drivers/g=
pu/drm/amd/amdgpu/sdma_v6_0.c
> > >>>>>>> index 445a34549d2c..1c6ff511f501 100644
> > >>>>>>> --- a/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c
> > >>>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c
> > >>>>>>> @@ -348,8 +348,6 @@ static void sdma_v6_0_gfx_stop(struct amdgp=
u_device *adev)
> > >>>>>>>        u32 rb_cntl, ib_cntl;
> > >>>>>>>        int i;
> > >>>>>>>
> > >>>>>>> -     amdgpu_sdma_unset_buffer_funcs_helper(adev);
> > >>>>>>> -
> > >>>>>>>        for (i =3D 0; i < adev->sdma.num_instances; i++) {
> > >>>>>>>                rb_cntl =3D RREG32_SOC15_IP(GC, sdma_v6_0_get_re=
g_offset(adev, i, regSDMA0_QUEUE0_RB_CNTL));
> > >>>>>>>                rb_cntl =3D REG_SET_FIELD(rb_cntl, SDMA0_QUEUE0_=
RB_CNTL, RB_ENABLE, 0);
> > >>>>>>> @@ -561,9 +559,6 @@ static int sdma_v6_0_gfx_resume(struct amdg=
pu_device *adev)
> > >>>>>>>                r =3D amdgpu_ring_test_helper(ring);
> > >>>>>>>                if (r)
> > >>>>>>>                        return r;
> > >>>>>>> -
> > >>>>>>> -             if (adev->mman.buffer_funcs_ring =3D=3D ring)
> > >>>>>>> -                     amdgpu_ttm_set_buffer_funcs_status(adev, =
true);
> > >>>>>>>        }
> > >>>>>>>
> > >>>>>>>        return 0;
> > >>>>>>> @@ -1308,11 +1303,8 @@ static int sdma_v6_0_hw_fini(void *handl=
e)
> > >>>>>>>    {
> > >>>>>>>        struct amdgpu_device *adev =3D (struct amdgpu_device *)h=
andle;
> > >>>>>>>
> > >>>>>>> -     if (amdgpu_sriov_vf(adev)) {
> > >>>>>>> -             /* disable the scheduler for SDMA */
> > >>>>>>> -             amdgpu_sdma_unset_buffer_funcs_helper(adev);
> > >>>>>>> +     if (amdgpu_sriov_vf(adev))
> > >>>>>>>                return 0;
> > >>>>>>> -     }
> > >>>>>>>
> > >>>>>>>        sdma_v6_0_ctxempty_int_enable(adev, false);
> > >>>>>>>        sdma_v6_0_enable(adev, false);
> > >>>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/si_dma.c b/drivers/gpu/=
drm/amd/amdgpu/si_dma.c
> > >>>>>>> index 42c4547f32ec..9aa0e11ee673 100644
> > >>>>>>> --- a/drivers/gpu/drm/amd/amdgpu/si_dma.c
> > >>>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/si_dma.c
> > >>>>>>> @@ -115,8 +115,6 @@ static void si_dma_stop(struct amdgpu_devic=
e *adev)
> > >>>>>>>        u32 rb_cntl;
> > >>>>>>>        unsigned i;
> > >>>>>>>
> > >>>>>>> -     amdgpu_sdma_unset_buffer_funcs_helper(adev);
> > >>>>>>> -
> > >>>>>>>        for (i =3D 0; i < adev->sdma.num_instances; i++) {
> > >>>>>>>                /* dma0 */
> > >>>>>>>                rb_cntl =3D RREG32(DMA_RB_CNTL + sdma_offsets[i]=
);
> > >>>>>>> @@ -177,9 +175,6 @@ static int si_dma_start(struct amdgpu_devic=
e *adev)
> > >>>>>>>                r =3D amdgpu_ring_test_helper(ring);
> > >>>>>>>                if (r)
> > >>>>>>>                        return r;
> > >>>>>>> -
> > >>>>>>> -             if (adev->mman.buffer_funcs_ring =3D=3D ring)
> > >>>>>>> -                     amdgpu_ttm_set_buffer_funcs_status(adev, =
true);
> > >>>>>>>        }
> > >>>>>>>
> > >>>>>>>        return 0;
> >

--000000000000200a9d0609910dc3
Content-Type: text/x-patch; charset="US-ASCII"; 
	name="0001-drm-amdgpu-move-UVD-and-VCE-sched-entity-init-after-.patch"
Content-Disposition: attachment; 
	filename="0001-drm-amdgpu-move-UVD-and-VCE-sched-entity-init-after-.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_loog37g40>
X-Attachment-Id: f_loog37g40

RnJvbSAyOWNjZTY1MjRjZTU1NmVmYTQ3MTc2MjA1ZmUyOGYwZTRmNjg3ZDY4IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBBbGV4IERldWNoZXIgPGFsZXhhbmRlci5kZXVjaGVyQGFtZC5j
b20+CkRhdGU6IFR1ZSwgNyBOb3YgMjAyMyAwOTo0MzozMyAtMDUwMApTdWJqZWN0OiBbUEFUQ0hd
IGRybS9hbWRncHU6IG1vdmUgVVZEIGFuZCBWQ0Ugc2NoZWQgZW50aXR5IGluaXQgYWZ0ZXIgc2No
ZWQKIGluaXQKCldlIG5lZWQga2VybmVsIHNjaGVkdWxpbmcgZW50aXRpZXMgdG8gZGVhbCB3aXRo
IGhhbmRsZSBjbGVhbiB1cAppZiBhcHBzIGFyZSBub3QgY2xlYW5lZCB1cCBwcm9wZXJseS4gIFdp
dGggY29tbWl0IDU2ZTQ0OTYwM2YwYWM1CigiZHJtL3NjaGVkOiBDb252ZXJ0IHRoZSBHUFUgc2No
ZWR1bGVyIHRvIHZhcmlhYmxlIG51bWJlciBvZiBydW4tcXVldWVzIikKdGhlIHNjaGVkdWxlciBl
bnRpdGllcyBoYXZlIHRvIGJlIGNyZWF0ZWQgYWZ0ZXIgc2NoZWR1bGVyIGluaXQsIHNvCmNoYW5n
ZSB0aGUgb3JkZXJpbmcgdG8gZml4IHRoaXMuCgpGaXhlczogNTZlNDQ5NjAzZjBhYzUgKCJkcm0v
c2NoZWQ6IENvbnZlcnQgdGhlIEdQVSBzY2hlZHVsZXIgdG8gdmFyaWFibGUgbnVtYmVyIG9mIHJ1
bi1xdWV1ZXMiKQpTaWduZWQtb2ZmLWJ5OiBBbGV4IERldWNoZXIgPGFsZXhhbmRlci5kZXVjaGVy
QGFtZC5jb20+Ci0tLQogZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2RldmljZS5j
IHwgMjIgKysrKysrKysrKysrKysrKysrKysKIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2Ft
ZGdwdV91dmQuYyAgICB8IDI0IC0tLS0tLS0tLS0tLS0tLS0tLS0tLS0KIGRyaXZlcnMvZ3B1L2Ry
bS9hbWQvYW1kZ3B1L2FtZGdwdV91dmQuaCAgICB8ICAxIC0KIGRyaXZlcnMvZ3B1L2RybS9hbWQv
YW1kZ3B1L2FtZGdwdV92Y2UuYyAgICB8IDI0IC0tLS0tLS0tLS0tLS0tLS0tLS0tLS0KIGRyaXZl
cnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV92Y2UuaCAgICB8ICAxIC0KIGRyaXZlcnMvZ3B1
L2RybS9hbWQvYW1kZ3B1L3V2ZF92M18xLmMgICAgICB8ICAyIC0tCiBkcml2ZXJzL2dwdS9kcm0v
YW1kL2FtZGdwdS91dmRfdjRfMi5jICAgICAgfCAgMiAtLQogZHJpdmVycy9ncHUvZHJtL2FtZC9h
bWRncHUvdXZkX3Y1XzAuYyAgICAgIHwgIDIgLS0KIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1
L3V2ZF92Nl8wLmMgICAgICB8ICAyIC0tCiBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS91dmRf
djdfMC5jICAgICAgfCAgNCAtLS0tCiBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS92Y2VfdjJf
MC5jICAgICAgfCAgMiAtLQogZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvdmNlX3YzXzAuYyAg
ICAgIHwgIDIgLS0KIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L3ZjZV92NF8wLmMgICAgICB8
ICA1IC0tLS0tCiAxMyBmaWxlcyBjaGFuZ2VkLCAyMiBpbnNlcnRpb25zKCspLCA3MSBkZWxldGlv
bnMoLSkKCmRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfZGV2
aWNlLmMgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfZGV2aWNlLmMKaW5kZXgg
ZTIxOTlkOGZkMzBlLi43YjBkYTQ0NDJhYmIgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvZ3B1L2RybS9h
bWQvYW1kZ3B1L2FtZGdwdV9kZXZpY2UuYworKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdw
dS9hbWRncHVfZGV2aWNlLmMKQEAgLTI0NjMsNiArMjQ2Myw3IEBAIHN0YXRpYyBpbnQgYW1kZ3B1
X2RldmljZV9md19sb2FkaW5nKHN0cnVjdCBhbWRncHVfZGV2aWNlICphZGV2KQogCiBzdGF0aWMg
aW50IGFtZGdwdV9kZXZpY2VfaW5pdF9zY2hlZHVsZXJzKHN0cnVjdCBhbWRncHVfZGV2aWNlICph
ZGV2KQogeworCXN0cnVjdCBkcm1fZ3B1X3NjaGVkdWxlciAqc2NoZWQ7CiAJbG9uZyB0aW1lb3V0
OwogCWludCByLCBpOwogCkBAIC0yNDk4LDYgKzI0OTksMjcgQEAgc3RhdGljIGludCBhbWRncHVf
ZGV2aWNlX2luaXRfc2NoZWR1bGVycyhzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRldikKIAkJCQkg
IHJpbmctPm5hbWUpOwogCQkJcmV0dXJuIHI7CiAJCX0KKwkJLyogc2V0IHVwIHRoZSBVVkQgYW5k
IFZDRSBlbnRpdGllcyB0byBwcm9wZXJseSBkZWFsIHdpdGggaGFuZGxlcyAqLworCQlpZiAocmlu
ZyA9PSAmYWRldi0+dXZkLmluc3RbMF0ucmluZykgeworCQkJc2NoZWQgPSAmcmluZy0+c2NoZWQ7
CisJCQlyID0gZHJtX3NjaGVkX2VudGl0eV9pbml0KCZhZGV2LT51dmQuZW50aXR5LCBEUk1fU0NI
RURfUFJJT1JJVFlfTk9STUFMLAorCQkJCQkJICAmc2NoZWQsIDEsIE5VTEwpOworCQkJaWYgKHIp
IHsKKwkJCQlEUk1fRVJST1IoIkZhaWxlZCB0byBjcmVhdGUgVVZEIHNjaGVkdWxpbmcgZW50aXR5
IG9uIHJpbmcgJXMuXG4iLAorCQkJCQkgIHJpbmctPm5hbWUpOworCQkJCXJldHVybiByOworCQkJ
fQorCQl9CisJCWlmIChyaW5nID09ICZhZGV2LT52Y2UucmluZ1swXSkgeworCQkJc2NoZWQgPSAm
cmluZy0+c2NoZWQ7CisJCQlyID0gZHJtX3NjaGVkX2VudGl0eV9pbml0KCZhZGV2LT52Y2UuZW50
aXR5LCBEUk1fU0NIRURfUFJJT1JJVFlfTk9STUFMLAorCQkJCQkJICAmc2NoZWQsIDEsIE5VTEwp
OworCQkJaWYgKHIpIHsKKwkJCQlEUk1fRVJST1IoIkZhaWxlZCB0byBjcmVhdGUgVkNFIHNjaGVk
dWxpbmcgZW50aXR5IG9uIHJpbmcgJXMuXG4iLAorCQkJCQkgIHJpbmctPm5hbWUpOworCQkJCXJl
dHVybiByOworCQkJfQorCQl9CiAJfQogCiAJYW1kZ3B1X3hjcF91cGRhdGVfcGFydGl0aW9uX3Nj
aGVkX2xpc3QoYWRldik7CmRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9h
bWRncHVfdXZkLmMgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfdXZkLmMKaW5k
ZXggODE1YjdjMzRlZDMzLi40YWJjYjA5YmVmZWIgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvZ3B1L2Ry
bS9hbWQvYW1kZ3B1L2FtZGdwdV91dmQuYworKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdw
dS9hbWRncHVfdXZkLmMKQEAgLTM5NCwzMCArMzk0LDYgQEAgaW50IGFtZGdwdV91dmRfc3dfZmlu
aShzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRldikKIAlyZXR1cm4gMDsKIH0KIAotLyoqCi0gKiBh
bWRncHVfdXZkX2VudGl0eV9pbml0IC0gaW5pdCBlbnRpdHkKLSAqCi0gKiBAYWRldjogYW1kZ3B1
X2RldmljZSBwb2ludGVyCi0gKgotICovCi1pbnQgYW1kZ3B1X3V2ZF9lbnRpdHlfaW5pdChzdHJ1
Y3QgYW1kZ3B1X2RldmljZSAqYWRldikKLXsKLQlzdHJ1Y3QgYW1kZ3B1X3JpbmcgKnJpbmc7Ci0J
c3RydWN0IGRybV9ncHVfc2NoZWR1bGVyICpzY2hlZDsKLQlpbnQgcjsKLQotCXJpbmcgPSAmYWRl
di0+dXZkLmluc3RbMF0ucmluZzsKLQlzY2hlZCA9ICZyaW5nLT5zY2hlZDsKLQlyID0gZHJtX3Nj
aGVkX2VudGl0eV9pbml0KCZhZGV2LT51dmQuZW50aXR5LCBEUk1fU0NIRURfUFJJT1JJVFlfTk9S
TUFMLAotCQkJCSAgJnNjaGVkLCAxLCBOVUxMKTsKLQlpZiAocikgewotCQlEUk1fRVJST1IoIkZh
aWxlZCBzZXR0aW5nIHVwIFVWRCBrZXJuZWwgZW50aXR5LlxuIik7Ci0JCXJldHVybiByOwotCX0K
LQotCXJldHVybiAwOwotfQotCiBpbnQgYW1kZ3B1X3V2ZF9wcmVwYXJlX3N1c3BlbmQoc3RydWN0
IGFtZGdwdV9kZXZpY2UgKmFkZXYpCiB7CiAJdW5zaWduZWQgaW50IHNpemU7CmRpZmYgLS1naXQg
YS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfdXZkLmggYi9kcml2ZXJzL2dwdS9k
cm0vYW1kL2FtZGdwdS9hbWRncHVfdXZkLmgKaW5kZXggYTlmMzQyNTM3YzY4Li43YzhlN2UyYjcz
MWQgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV91dmQuaAor
KysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfdXZkLmgKQEAgLTczLDcgKzcz
LDYgQEAgc3RydWN0IGFtZGdwdV91dmQgewogCiBpbnQgYW1kZ3B1X3V2ZF9zd19pbml0KHN0cnVj
dCBhbWRncHVfZGV2aWNlICphZGV2KTsKIGludCBhbWRncHVfdXZkX3N3X2Zpbmkoc3RydWN0IGFt
ZGdwdV9kZXZpY2UgKmFkZXYpOwotaW50IGFtZGdwdV91dmRfZW50aXR5X2luaXQoc3RydWN0IGFt
ZGdwdV9kZXZpY2UgKmFkZXYpOwogaW50IGFtZGdwdV91dmRfcHJlcGFyZV9zdXNwZW5kKHN0cnVj
dCBhbWRncHVfZGV2aWNlICphZGV2KTsKIGludCBhbWRncHVfdXZkX3N1c3BlbmQoc3RydWN0IGFt
ZGdwdV9kZXZpY2UgKmFkZXYpOwogaW50IGFtZGdwdV91dmRfcmVzdW1lKHN0cnVjdCBhbWRncHVf
ZGV2aWNlICphZGV2KTsKZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2Ft
ZGdwdV92Y2UuYyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV92Y2UuYwppbmRl
eCAxOTA0ZWRmNjg0MDcuLmQ5ZGVkYTkxYzVkMCAxMDA2NDQKLS0tIGEvZHJpdmVycy9ncHUvZHJt
L2FtZC9hbWRncHUvYW1kZ3B1X3ZjZS5jCisrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1
L2FtZGdwdV92Y2UuYwpAQCAtMjI2LDMwICsyMjYsNiBAQCBpbnQgYW1kZ3B1X3ZjZV9zd19maW5p
KHN0cnVjdCBhbWRncHVfZGV2aWNlICphZGV2KQogCXJldHVybiAwOwogfQogCi0vKioKLSAqIGFt
ZGdwdV92Y2VfZW50aXR5X2luaXQgLSBpbml0IGVudGl0eQotICoKLSAqIEBhZGV2OiBhbWRncHVf
ZGV2aWNlIHBvaW50ZXIKLSAqCi0gKi8KLWludCBhbWRncHVfdmNlX2VudGl0eV9pbml0KHN0cnVj
dCBhbWRncHVfZGV2aWNlICphZGV2KQotewotCXN0cnVjdCBhbWRncHVfcmluZyAqcmluZzsKLQlz
dHJ1Y3QgZHJtX2dwdV9zY2hlZHVsZXIgKnNjaGVkOwotCWludCByOwotCi0JcmluZyA9ICZhZGV2
LT52Y2UucmluZ1swXTsKLQlzY2hlZCA9ICZyaW5nLT5zY2hlZDsKLQlyID0gZHJtX3NjaGVkX2Vu
dGl0eV9pbml0KCZhZGV2LT52Y2UuZW50aXR5LCBEUk1fU0NIRURfUFJJT1JJVFlfTk9STUFMLAot
CQkJCSAgJnNjaGVkLCAxLCBOVUxMKTsKLQlpZiAociAhPSAwKSB7Ci0JCURSTV9FUlJPUigiRmFp
bGVkIHNldHRpbmcgdXAgVkNFIHJ1biBxdWV1ZS5cbiIpOwotCQlyZXR1cm4gcjsKLQl9Ci0KLQly
ZXR1cm4gMDsKLX0KLQogLyoqCiAgKiBhbWRncHVfdmNlX3N1c3BlbmQgLSB1bnBpbiBWQ0UgZncg
bWVtb3J5CiAgKgpkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1
X3ZjZS5oIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3ZjZS5oCmluZGV4IGVh
NjgwZmM5YTZjMy4uZWU3NWY2OTFmMjhmIDEwMDY0NAotLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1k
L2FtZGdwdS9hbWRncHVfdmNlLmgKKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1k
Z3B1X3ZjZS5oCkBAIC01NSw3ICs1NSw2IEBAIHN0cnVjdCBhbWRncHVfdmNlIHsKIAogaW50IGFt
ZGdwdV92Y2Vfc3dfaW5pdChzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRldiwgdW5zaWduZWQgbG9u
ZyBzaXplKTsKIGludCBhbWRncHVfdmNlX3N3X2Zpbmkoc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFk
ZXYpOwotaW50IGFtZGdwdV92Y2VfZW50aXR5X2luaXQoc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFk
ZXYpOwogaW50IGFtZGdwdV92Y2Vfc3VzcGVuZChzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRldik7
CiBpbnQgYW1kZ3B1X3ZjZV9yZXN1bWUoc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYpOwogdm9p
ZCBhbWRncHVfdmNlX2ZyZWVfaGFuZGxlcyhzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRldiwgc3Ry
dWN0IGRybV9maWxlICpmaWxwKTsKZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1k
Z3B1L3V2ZF92M18xLmMgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS91dmRfdjNfMS5jCmlu
ZGV4IDU4YThmNzhjMDAzYy4uYTYwMDZmMjMxYzY1IDEwMDY0NAotLS0gYS9kcml2ZXJzL2dwdS9k
cm0vYW1kL2FtZGdwdS91dmRfdjNfMS5jCisrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1
L3V2ZF92M18xLmMKQEAgLTU3Nyw4ICs1NzcsNiBAQCBzdGF0aWMgaW50IHV2ZF92M18xX3N3X2lu
aXQodm9pZCAqaGFuZGxlKQogCXB0ciArPSB1Y29kZV9sZW47CiAJbWVtY3B5KCZhZGV2LT51dmQu
a2V5c2VsZWN0LCBwdHIsIDQpOwogCi0JciA9IGFtZGdwdV91dmRfZW50aXR5X2luaXQoYWRldik7
Ci0KIAlyZXR1cm4gcjsKIH0KIApkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRn
cHUvdXZkX3Y0XzIuYyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L3V2ZF92NF8yLmMKaW5k
ZXggZDNiMWUzMWY1NDUwLi4xYWEwOWFkN2JiZTMgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvZ3B1L2Ry
bS9hbWQvYW1kZ3B1L3V2ZF92NF8yLmMKKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUv
dXZkX3Y0XzIuYwpAQCAtMTI3LDggKzEyNyw2IEBAIHN0YXRpYyBpbnQgdXZkX3Y0XzJfc3dfaW5p
dCh2b2lkICpoYW5kbGUpCiAJaWYgKHIpCiAJCXJldHVybiByOwogCi0JciA9IGFtZGdwdV91dmRf
ZW50aXR5X2luaXQoYWRldik7Ci0KIAlyZXR1cm4gcjsKIH0KIApkaWZmIC0tZ2l0IGEvZHJpdmVy
cy9ncHUvZHJtL2FtZC9hbWRncHUvdXZkX3Y1XzAuYyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1k
Z3B1L3V2ZF92NV8wLmMKaW5kZXggNWE4MTE2NDM3YWJmLi5mOGIyMjliNzU0MzUgMTAwNjQ0Ci0t
LSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L3V2ZF92NV8wLmMKKysrIGIvZHJpdmVycy9n
cHUvZHJtL2FtZC9hbWRncHUvdXZkX3Y1XzAuYwpAQCAtMTI1LDggKzEyNSw2IEBAIHN0YXRpYyBp
bnQgdXZkX3Y1XzBfc3dfaW5pdCh2b2lkICpoYW5kbGUpCiAJaWYgKHIpCiAJCXJldHVybiByOwog
Ci0JciA9IGFtZGdwdV91dmRfZW50aXR5X2luaXQoYWRldik7Ci0KIAlyZXR1cm4gcjsKIH0KIApk
aWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvdXZkX3Y2XzAuYyBiL2RyaXZl
cnMvZ3B1L2RybS9hbWQvYW1kZ3B1L3V2ZF92Nl8wLmMKaW5kZXggNzRjMDkyMzBhZWIzLi5hOWE2
ODgwZjQ0ZTMgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L3V2ZF92Nl8w
LmMKKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvdXZkX3Y2XzAuYwpAQCAtNDMyLDgg
KzQzMiw2IEBAIHN0YXRpYyBpbnQgdXZkX3Y2XzBfc3dfaW5pdCh2b2lkICpoYW5kbGUpCiAJCX0K
IAl9CiAKLQlyID0gYW1kZ3B1X3V2ZF9lbnRpdHlfaW5pdChhZGV2KTsKLQogCXJldHVybiByOwog
fQogCmRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS91dmRfdjdfMC5jIGIv
ZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvdXZkX3Y3XzAuYwppbmRleCAxYzQyY2YxMGNjMjku
LjYwNjhiNzg0ZGM2OSAxMDA2NDQKLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvdXZk
X3Y3XzAuYworKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS91dmRfdjdfMC5jCkBAIC00
ODAsMTAgKzQ4MCw2IEBAIHN0YXRpYyBpbnQgdXZkX3Y3XzBfc3dfaW5pdCh2b2lkICpoYW5kbGUp
CiAJaWYgKHIpCiAJCXJldHVybiByOwogCi0JciA9IGFtZGdwdV91dmRfZW50aXR5X2luaXQoYWRl
dik7Ci0JaWYgKHIpCi0JCXJldHVybiByOwotCiAJciA9IGFtZGdwdV92aXJ0X2FsbG9jX21tX3Rh
YmxlKGFkZXYpOwogCWlmIChyKQogCQlyZXR1cm4gcjsKZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1
L2RybS9hbWQvYW1kZ3B1L3ZjZV92Ml8wLmMgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS92
Y2VfdjJfMC5jCmluZGV4IDY3ZWIwMWZlZjc4OS4uYTA4ZTdhYmNhNDIzIDEwMDY0NAotLS0gYS9k
cml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS92Y2VfdjJfMC5jCisrKyBiL2RyaXZlcnMvZ3B1L2Ry
bS9hbWQvYW1kZ3B1L3ZjZV92Ml8wLmMKQEAgLTQ0MSw4ICs0NDEsNiBAQCBzdGF0aWMgaW50IHZj
ZV92Ml8wX3N3X2luaXQodm9pZCAqaGFuZGxlKQogCQkJcmV0dXJuIHI7CiAJfQogCi0JciA9IGFt
ZGdwdV92Y2VfZW50aXR5X2luaXQoYWRldik7Ci0KIAlyZXR1cm4gcjsKIH0KIApkaWZmIC0tZ2l0
IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvdmNlX3YzXzAuYyBiL2RyaXZlcnMvZ3B1L2Ry
bS9hbWQvYW1kZ3B1L3ZjZV92M18wLmMKaW5kZXggMThmNmU2MmFmMzM5Li5mNDc2MDc0OGQzNDkg
MTAwNjQ0Ci0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L3ZjZV92M18wLmMKKysrIGIv
ZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvdmNlX3YzXzAuYwpAQCAtNDUwLDggKzQ1MCw2IEBA
IHN0YXRpYyBpbnQgdmNlX3YzXzBfc3dfaW5pdCh2b2lkICpoYW5kbGUpCiAJCQlyZXR1cm4gcjsK
IAl9CiAKLQlyID0gYW1kZ3B1X3ZjZV9lbnRpdHlfaW5pdChhZGV2KTsKLQogCXJldHVybiByOwog
fQogCmRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS92Y2VfdjRfMC5jIGIv
ZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvdmNlX3Y0XzAuYwppbmRleCBlMGI3MGNkM2I2OTcu
LjA2ZDc4NzM4NWFkNCAxMDA2NDQKLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvdmNl
X3Y0XzAuYworKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS92Y2VfdjRfMC5jCkBAIC00
ODYsMTEgKzQ4Niw2IEBAIHN0YXRpYyBpbnQgdmNlX3Y0XzBfc3dfaW5pdCh2b2lkICpoYW5kbGUp
CiAJCQlyZXR1cm4gcjsKIAl9CiAKLQotCXIgPSBhbWRncHVfdmNlX2VudGl0eV9pbml0KGFkZXYp
OwotCWlmIChyKQotCQlyZXR1cm4gcjsKLQogCXIgPSBhbWRncHVfdmlydF9hbGxvY19tbV90YWJs
ZShhZGV2KTsKIAlpZiAocikKIAkJcmV0dXJuIHI7Ci0tIAoyLjQxLjAKCg==
--000000000000200a9d0609910dc3--
