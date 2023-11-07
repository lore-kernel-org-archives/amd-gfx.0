Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C53D1C4332F
	for <amd-gfx@archiver.kernel.org>; Tue,  7 Nov 2023 19:50:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3568610E67A;
	Tue,  7 Nov 2023 19:50:44 +0000 (UTC)
Received: from mail-oa1-x29.google.com (mail-oa1-x29.google.com
 [IPv6:2001:4860:4864:20::29])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DC60510E67A
 for <amd-gfx@lists.freedesktop.org>; Tue,  7 Nov 2023 19:50:41 +0000 (UTC)
Received: by mail-oa1-x29.google.com with SMTP id
 586e51a60fabf-1f0f160e293so967991fac.0
 for <amd-gfx@lists.freedesktop.org>; Tue, 07 Nov 2023 11:50:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1699386641; x=1699991441; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=049P2y9IDm/EFbjqte2rdyhpA5cfONDjZRIOIq/c0bg=;
 b=O1xhM52W1G3xyd82ST48ELQDB5Pfw+OfcdTDBhQREZm5i5PXdbS3S1VxtxtTV54jla
 fqd0RcvnhoL7StPw0zkaDpWoRuBNyPmB69aDsFSWTwvA0rzdxe0bk8NezkMfRxzE8qr8
 qzhpBT+kIU4pU/lmkMXp618XDyx9w7F/DCWBvG3vWD++Lz4w7sAhjYZKVTGW+8+NqQXF
 1XH6Y56dkVf280iYgs6LKxf3AU33AB4SEJqngI/USnUzqcK7livh17F+e7RgQQ8LTc39
 tKJTBQk+1rprPbZqBMmCgI16H9y3PL1HE2Grpl9SQ5UnDJVCQaAJUk1qPtwcPFrhLoS+
 /eBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699386641; x=1699991441;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=049P2y9IDm/EFbjqte2rdyhpA5cfONDjZRIOIq/c0bg=;
 b=h5Eo8Rdvlyv355nyMJQGUlJ4Opkv3RKzOPQ++wwyXmC1mFO4UwmCtCSKKT2/Rvsnum
 v6mdD3yyKf261kiggMzOYfshP2+DOhNZGf+5lGdJFMrtizTICLHvErxq0v2wUf4qYB+y
 BFwOMqyRzELkIKEjcLHIII5daedvU4ip4WfA74sS4TiNfQ0+CFT7utvcRr9BUs5dRihW
 smSOdso5fGqfJqeb1ibORYnTWT11vmimOh5iGV7XCxHB7lVJSM2S9HutHCYH3a5P8rzZ
 JPqaIH/VzC69jlwDAFItGoVORfANsHGXGfmduzlBUQApNvqHxbM44vbv2Ea1Mgi2MS9w
 s55Q==
X-Gm-Message-State: AOJu0YyT4DNorBGWzOgwER8fYPs4IyiXBczjEZNd0N25l5CpkDYWueU5
 K3dK+rtGy/XsXJgcqPz7jxvzHu2+EqlU0QnKMmzk6t1N
X-Google-Smtp-Source: AGHT+IGLXRAamoqFFhmUvi4+UPkpBLlMz0ZNRUYwIwYXhWiAhJ4WZu8pwujj2/uuk8eelIEOdakXn1ZgxULMLpklKrE=
X-Received: by 2002:a05:6870:cd03:b0:1e9:8780:a0e with SMTP id
 qk3-20020a056870cd0300b001e987800a0emr4100259oab.28.1699386640799; Tue, 07
 Nov 2023 11:50:40 -0800 (PST)
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
 <CADnq5_PAmkoNYL7mJvQ0+b5BB6qNQdKnV+MPiO1F13AcnsfEXg@mail.gmail.com>
In-Reply-To: <CADnq5_PAmkoNYL7mJvQ0+b5BB6qNQdKnV+MPiO1F13AcnsfEXg@mail.gmail.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 7 Nov 2023 14:50:29 -0500
Message-ID: <CADnq5_N5abNgDMN0M5jDuw5nSdx3WKGSPihzRrQyOW3O+8my-w@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: move buffer funcs setting up a level
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>
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
Cc: Alex Deucher <alexander.deucher@amd.com>,
 Luben Tuikov <luben.tuikov@amd.com>, Leo Liu <leo.liu@amd.com>,
 amd-gfx@lists.freedesktop.org, Luben Tuikov <ltuikov89@gmail.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Tue, Nov 7, 2023 at 2:47=E2=80=AFPM Alex Deucher <alexdeucher@gmail.com>=
 wrote:
>
> On Tue, Nov 7, 2023 at 10:14=E2=80=AFAM Alex Deucher <alexdeucher@gmail.c=
om> wrote:
> >
> > On Tue, Nov 7, 2023 at 9:52=E2=80=AFAM Christian K=C3=B6nig
> > <ckoenig.leichtzumerken@gmail.com> wrote:
> > >
> > > This is only needed for certain UVD/VCE hardware/firmware versions.
> >
> > We currently enable it for all UVD and VCE versions.
> >
> > >
> > > Leo needs to decide that, but I would rather like to keep the call to
> > > create the entity in the HW IP specific files.
> >
> > That will complicate things.  The problem is sw_init() is called too
> > early and we don't have any other one time init IP callbacks.  We
> > could move it to late_init, but then we'd need to also track whether
> > or not the entity has been initialized.  I think this is cleaner.
> >
>
> I took a stab at pulling it into the IPs.  It doesn't seem as clean to
> me, but it's not too bad so either solution works for me.  @Leo Liu Do
> you have a preference?

FWIW, I also think the first patch is more defensive since the
scheduler and entities are initialized in the right order in the same
function while the second one could potentially break if we ever make
adjustments to the late_init ordering.

Alex

>
> Alex
>
>
> > Alex
> >
> > >
> > > Regards,
> > > Christian.
> > >
> > > Am 07.11.23 um 15:47 schrieb Alex Deucher:
> > > > On Tue, Nov 7, 2023 at 9:19=E2=80=AFAM Alex Deucher <alexdeucher@gm=
ail.com> wrote:
> > > >> On Tue, Nov 7, 2023 at 5:52=E2=80=AFAM Christian K=C3=B6nig
> > > >> <ckoenig.leichtzumerken@gmail.com> wrote:
> > > >>> Am 03.11.23 um 23:10 schrieb Alex Deucher:
> > > >>>> On Fri, Nov 3, 2023 at 4:17=E2=80=AFPM Alex Deucher <alexdeucher=
@gmail.com> wrote:
> > > >>>>> On Thu, Oct 26, 2023 at 4:17=E2=80=AFPM Luben Tuikov <ltuikov89=
@gmail.com> wrote:
> > > >>>>>> Pushed to drm-misc-next.
> > > >>>>> BTW, I'm seeing the following on older GPUs with VCE and UVD ev=
en with
> > > >>>>> this patch:
> > > >>>>> [   11.886024] amdgpu 0000:0a:00.0: [drm] *ERROR* drm_sched_job=
_init:
> > > >>>>> entity has no rq!
> > > >>>>> [   11.886028] amdgpu 0000:0a:00.0: [drm:amdgpu_ib_ring_tests
> > > >>>>> [amdgpu]] *ERROR* IB test failed on uvd (-2).
> > > >>>>> [   11.889927] amdgpu 0000:0a:00.0: [drm] *ERROR* drm_sched_job=
_init:
> > > >>>>> entity has no rq!
> > > >>>>> [   11.889930] amdgpu 0000:0a:00.0: [drm:amdgpu_ib_ring_tests
> > > >>>>> [amdgpu]] *ERROR* IB test failed on vce0 (-2).
> > > >>>>> [   11.890172] [drm:process_one_work] *ERROR* ib ring test fail=
ed (-2).
> > > >>>>> Seems to be specific to UVD and VCE, I don't see anything simil=
ar with
> > > >>>>> VCN, but the flows for both are pretty similar.  Not sure why w=
e are
> > > >>>>> not seeing it for VCN.  Just a heads up if you have any ideas. =
 Will
> > > >>>>> take a closer look next week.
> > > >>>> + Leo
> > > >>>>
> > > >>>> I found the problem.  We set up scheduling entities for UVD and =
VCE
> > > >>>> specifically and not for any other engines.  I don't remember wh=
y
> > > >>>> offhand.  I'm guessing maybe to deal with the session limits on =
UVD
> > > >>>> and VCE?  If so I'm not sure of a clean way to fix this.
> > > >>> I haven't looked through all my mails yet so could be that Leo ha=
s
> > > >>> already answered this.
> > > >>>
> > > >>> The UVD/VCE entities are used for the older chips where applicati=
ons
> > > >>> have to use create/destroy messages to the firmware.
> > > >>>
> > > >>> If an application exits without cleaning up their handles the ker=
nel
> > > >>> sends the appropriate destroy messages itself. For an example see
> > > >>> amdgpu_uvd_free_handles().
> > > >>>
> > > >>> We used to initialize those entities with separate calls after th=
e
> > > >>> scheduler had been brought up, see amdgpu_uvd_entity_init() for a=
n example.
> > > >>>
> > > >>> But this was somehow messed up and we now do the call to
> > > >>> amdgpu_uvd_entity_init() at the end of *_sw_init() instead of _la=
te_init().
> > > >>>
> > > >>> I suggest to just come up with a function which can be used for t=
he
> > > >>> late_init() callback of the UVD/VCE blocks.
> > > >> I guess the issue is that we only need to initialize the entity on=
ce
> > > >> so sw_init makes sense.  All of the other functions get called at
> > > >> resume time, etc.  I think we could probably put it into
> > > >> amdgpu_device_init_schedulers() somehow.
> > > > I think something like this might do the trick.
> > > >
> > > > Alex
> > > >
> > > >> Alex
> > > >>
> > > >>> Christian.
> > > >>>
> > > >>>> Alex
> > > >>>>
> > > >>>>> Alex
> > > >>>>>
> > > >>>>>> Regards,
> > > >>>>>> Luben
> > > >>>>>>
> > > >>>>>> On 2023-10-26 15:52, Luben Tuikov wrote:
> > > >>>>>>> On 2023-10-26 15:32, Alex Deucher wrote:
> > > >>>>>>>> On Thu, Oct 26, 2023 at 2:22=E2=80=AFAM Christian K=C3=B6nig
> > > >>>>>>>> <ckoenig.leichtzumerken@gmail.com> wrote:
> > > >>>>>>>>> Am 25.10.23 um 19:19 schrieb Alex Deucher:
> > > >>>>>>>>>> Rather than doing this in the IP code for the SDMA paging
> > > >>>>>>>>>> engine, move it up to the core device level init level.
> > > >>>>>>>>>> This should fix the scheduler init ordering.
> > > >>>>>>>>>>
> > > >>>>>>>>>> v2: drop extra parens
> > > >>>>>>>>>> v3: drop SDMA helpers
> > > >>>>>>>>>>
> > > >>>>>>>>>> Tested-by: Luben Tuikov <luben.tuikov@amd.com>
> > > >>>>>>>>>> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> > > >>>>>>>>> I don't know of hand if the high level function really cove=
r everything,
> > > >>>>>>>>> so only Acked-by: Christian K=C3=B6nig <christian.koenig@am=
d.com> for now.
> > > >>>>>>>>>
> > > >>>>>>>> Luben,
> > > >>>>>>>>
> > > >>>>>>>> Was this needed for some of the scheduler stuff that is pend=
ing?  If
> > > >>>>>>>> you would rather take it via drm-misc to align with the sche=
duler
> > > >>>>>>>> changes, that works for me, otherwise I can take it via the =
amdgpu
> > > >>>>>>>> tree.
> > > >>>>>>> Hi Alex,
> > > >>>>>>>
> > > >>>>>>> Yes, it does.
> > > >>>>>>>
> > > >>>>>>> I can take it via drm-misc-next as that where the scheduler c=
hanges landed.
> > > >>>>>>>
> > > >>>>>>> I'll add Christian's Acked-by.
> > > >>>>>>>
> > > >>>>>>> I'll add a Fixes tag because ideally it should've gone before=
 the dynamic
> > > >>>>>>> sched_rq commit.
> > > >>>>>>>
> > > >>>>>>> Thanks for the heads-up!
> > > >>>>>>>
> > > >>>>>>> Regards,
> > > >>>>>>> Luben
> > > >>>>>>>
> > > >>>>>>>
> > > >>>>>>>
> > > >>>>>>>> Thanks,
> > > >>>>>>>>
> > > >>>>>>>> Alex
> > > >>>>>>>>
> > > >>>>>>>>
> > > >>>>>>>>> Christian.
> > > >>>>>>>>>
> > > >>>>>>>>>> ---
> > > >>>>>>>>>>     drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 15 ++++++=
+++++++++
> > > >>>>>>>>>>     drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c   | 21 ------=
---------------
> > > >>>>>>>>>>     drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h   |  1 -
> > > >>>>>>>>>>     drivers/gpu/drm/amd/amdgpu/cik_sdma.c      |  5 -----
> > > >>>>>>>>>>     drivers/gpu/drm/amd/amdgpu/sdma_v2_4.c     |  5 -----
> > > >>>>>>>>>>     drivers/gpu/drm/amd/amdgpu/sdma_v3_0.c     |  5 -----
> > > >>>>>>>>>>     drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c     | 16 +-----=
----------
> > > >>>>>>>>>>     drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c     | 10 +-----=
----
> > > >>>>>>>>>>     drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c     | 10 +-----=
----
> > > >>>>>>>>>>     drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c     | 10 +-----=
----
> > > >>>>>>>>>>     drivers/gpu/drm/amd/amdgpu/si_dma.c        |  5 -----
> > > >>>>>>>>>>     11 files changed, 19 insertions(+), 84 deletions(-)
> > > >>>>>>>>>>
> > > >>>>>>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/=
drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> > > >>>>>>>>>> index 2031a467b721..5c90080e93ba 100644
> > > >>>>>>>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> > > >>>>>>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> > > >>>>>>>>>> @@ -2662,6 +2662,9 @@ static int amdgpu_device_ip_init(str=
uct amdgpu_device *adev)
> > > >>>>>>>>>>         if (r)
> > > >>>>>>>>>>                 goto init_failed;
> > > >>>>>>>>>>
> > > >>>>>>>>>> +     if (adev->mman.buffer_funcs_ring->sched.ready)
> > > >>>>>>>>>> +             amdgpu_ttm_set_buffer_funcs_status(adev, tru=
e);
> > > >>>>>>>>>> +
> > > >>>>>>>>>>         /* Don't init kfd if whole hive need to be reset d=
uring init */
> > > >>>>>>>>>>         if (!adev->gmc.xgmi.pending_reset) {
> > > >>>>>>>>>>                 kgd2kfd_init_zone_device(adev);
> > > >>>>>>>>>> @@ -3260,6 +3263,8 @@ int amdgpu_device_ip_suspend(struct =
amdgpu_device *adev)
> > > >>>>>>>>>>                 amdgpu_virt_request_full_gpu(adev, false);
> > > >>>>>>>>>>         }
> > > >>>>>>>>>>
> > > >>>>>>>>>> +     amdgpu_ttm_set_buffer_funcs_status(adev, false);
> > > >>>>>>>>>> +
> > > >>>>>>>>>>         r =3D amdgpu_device_ip_suspend_phase1(adev);
> > > >>>>>>>>>>         if (r)
> > > >>>>>>>>>>                 return r;
> > > >>>>>>>>>> @@ -3449,6 +3454,9 @@ static int amdgpu_device_ip_resume(s=
truct amdgpu_device *adev)
> > > >>>>>>>>>>
> > > >>>>>>>>>>         r =3D amdgpu_device_ip_resume_phase2(adev);
> > > >>>>>>>>>>
> > > >>>>>>>>>> +     if (adev->mman.buffer_funcs_ring->sched.ready)
> > > >>>>>>>>>> +             amdgpu_ttm_set_buffer_funcs_status(adev, tru=
e);
> > > >>>>>>>>>> +
> > > >>>>>>>>>>         return r;
> > > >>>>>>>>>>     }
> > > >>>>>>>>>>
> > > >>>>>>>>>> @@ -4236,6 +4244,8 @@ void amdgpu_device_fini_hw(struct am=
dgpu_device *adev)
> > > >>>>>>>>>>         /* disable ras feature must before hw fini */
> > > >>>>>>>>>>         amdgpu_ras_pre_fini(adev);
> > > >>>>>>>>>>
> > > >>>>>>>>>> +     amdgpu_ttm_set_buffer_funcs_status(adev, false);
> > > >>>>>>>>>> +
> > > >>>>>>>>>>         amdgpu_device_ip_fini_early(adev);
> > > >>>>>>>>>>
> > > >>>>>>>>>>         amdgpu_irq_fini_hw(adev);
> > > >>>>>>>>>> @@ -4407,6 +4417,8 @@ int amdgpu_device_suspend(struct drm=
_device *dev, bool fbcon)
> > > >>>>>>>>>>
> > > >>>>>>>>>>         amdgpu_ras_suspend(adev);
> > > >>>>>>>>>>
> > > >>>>>>>>>> +     amdgpu_ttm_set_buffer_funcs_status(adev, false);
> > > >>>>>>>>>> +
> > > >>>>>>>>>>         amdgpu_device_ip_suspend_phase1(adev);
> > > >>>>>>>>>>
> > > >>>>>>>>>>         if (!adev->in_s0ix)
> > > >>>>>>>>>> @@ -5178,6 +5190,9 @@ int amdgpu_do_asic_reset(struct list=
_head *device_list_handle,
> > > >>>>>>>>>>                                 if (r)
> > > >>>>>>>>>>                                         goto out;
> > > >>>>>>>>>>
> > > >>>>>>>>>> +                             if (tmp_adev->mman.buffer_fu=
ncs_ring->sched.ready)
> > > >>>>>>>>>> +                                     amdgpu_ttm_set_buffe=
r_funcs_status(tmp_adev, true);
> > > >>>>>>>>>> +
> > > >>>>>>>>>>                                 if (vram_lost)
> > > >>>>>>>>>>                                         amdgpu_device_fill=
_reset_magic(tmp_adev);
> > > >>>>>>>>>>
> > > >>>>>>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c b/dr=
ivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c
> > > >>>>>>>>>> index e8cbc4142d80..1d9d187de6ee 100644
> > > >>>>>>>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c
> > > >>>>>>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c
> > > >>>>>>>>>> @@ -292,27 +292,6 @@ int amdgpu_sdma_init_microcode(struct=
 amdgpu_device *adev,
> > > >>>>>>>>>>         return err;
> > > >>>>>>>>>>     }
> > > >>>>>>>>>>
> > > >>>>>>>>>> -void amdgpu_sdma_unset_buffer_funcs_helper(struct amdgpu_=
device *adev)
> > > >>>>>>>>>> -{
> > > >>>>>>>>>> -     struct amdgpu_ring *sdma;
> > > >>>>>>>>>> -     int i;
> > > >>>>>>>>>> -
> > > >>>>>>>>>> -     for (i =3D 0; i < adev->sdma.num_instances; i++) {
> > > >>>>>>>>>> -             if (adev->sdma.has_page_queue) {
> > > >>>>>>>>>> -                     sdma =3D &adev->sdma.instance[i].pag=
e;
> > > >>>>>>>>>> -                     if (adev->mman.buffer_funcs_ring =3D=
=3D sdma) {
> > > >>>>>>>>>> -                             amdgpu_ttm_set_buffer_funcs_=
status(adev, false);
> > > >>>>>>>>>> -                             break;
> > > >>>>>>>>>> -                     }
> > > >>>>>>>>>> -             }
> > > >>>>>>>>>> -             sdma =3D &adev->sdma.instance[i].ring;
> > > >>>>>>>>>> -             if (adev->mman.buffer_funcs_ring =3D=3D sdma=
) {
> > > >>>>>>>>>> -                     amdgpu_ttm_set_buffer_funcs_status(a=
dev, false);
> > > >>>>>>>>>> -                     break;
> > > >>>>>>>>>> -             }
> > > >>>>>>>>>> -     }
> > > >>>>>>>>>> -}
> > > >>>>>>>>>> -
> > > >>>>>>>>>>     int amdgpu_sdma_ras_sw_init(struct amdgpu_device *adev=
)
> > > >>>>>>>>>>     {
> > > >>>>>>>>>>         int err =3D 0;
> > > >>>>>>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h b/dr=
ivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h
> > > >>>>>>>>>> index 513ac22120c1..173a2a308078 100644
> > > >>>>>>>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h
> > > >>>>>>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h
> > > >>>>>>>>>> @@ -169,7 +169,6 @@ int amdgpu_sdma_init_microcode(struct =
amdgpu_device *adev, u32 instance,
> > > >>>>>>>>>>                                bool duplicate);
> > > >>>>>>>>>>     void amdgpu_sdma_destroy_inst_ctx(struct amdgpu_device=
 *adev,
> > > >>>>>>>>>>             bool duplicate);
> > > >>>>>>>>>> -void amdgpu_sdma_unset_buffer_funcs_helper(struct amdgpu_=
device *adev);
> > > >>>>>>>>>>     int amdgpu_sdma_ras_sw_init(struct amdgpu_device *adev=
);
> > > >>>>>>>>>>
> > > >>>>>>>>>>     #endif
> > > >>>>>>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/cik_sdma.c b/drive=
rs/gpu/drm/amd/amdgpu/cik_sdma.c
> > > >>>>>>>>>> index ee5dce6f6043..a3fccc4c1f43 100644
> > > >>>>>>>>>> --- a/drivers/gpu/drm/amd/amdgpu/cik_sdma.c
> > > >>>>>>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/cik_sdma.c
> > > >>>>>>>>>> @@ -308,8 +308,6 @@ static void cik_sdma_gfx_stop(struct a=
mdgpu_device *adev)
> > > >>>>>>>>>>         u32 rb_cntl;
> > > >>>>>>>>>>         int i;
> > > >>>>>>>>>>
> > > >>>>>>>>>> -     amdgpu_sdma_unset_buffer_funcs_helper(adev);
> > > >>>>>>>>>> -
> > > >>>>>>>>>>         for (i =3D 0; i < adev->sdma.num_instances; i++) {
> > > >>>>>>>>>>                 rb_cntl =3D RREG32(mmSDMA0_GFX_RB_CNTL + s=
dma_offsets[i]);
> > > >>>>>>>>>>                 rb_cntl &=3D ~SDMA0_GFX_RB_CNTL__RB_ENABLE=
_MASK;
> > > >>>>>>>>>> @@ -498,9 +496,6 @@ static int cik_sdma_gfx_resume(struct =
amdgpu_device *adev)
> > > >>>>>>>>>>                 r =3D amdgpu_ring_test_helper(ring);
> > > >>>>>>>>>>                 if (r)
> > > >>>>>>>>>>                         return r;
> > > >>>>>>>>>> -
> > > >>>>>>>>>> -             if (adev->mman.buffer_funcs_ring =3D=3D ring=
)
> > > >>>>>>>>>> -                     amdgpu_ttm_set_buffer_funcs_status(a=
dev, true);
> > > >>>>>>>>>>         }
> > > >>>>>>>>>>
> > > >>>>>>>>>>         return 0;
> > > >>>>>>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v2_4.c b/driv=
ers/gpu/drm/amd/amdgpu/sdma_v2_4.c
> > > >>>>>>>>>> index b58a13bd75db..45377a175250 100644
> > > >>>>>>>>>> --- a/drivers/gpu/drm/amd/amdgpu/sdma_v2_4.c
> > > >>>>>>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/sdma_v2_4.c
> > > >>>>>>>>>> @@ -339,8 +339,6 @@ static void sdma_v2_4_gfx_stop(struct =
amdgpu_device *adev)
> > > >>>>>>>>>>         u32 rb_cntl, ib_cntl;
> > > >>>>>>>>>>         int i;
> > > >>>>>>>>>>
> > > >>>>>>>>>> -     amdgpu_sdma_unset_buffer_funcs_helper(adev);
> > > >>>>>>>>>> -
> > > >>>>>>>>>>         for (i =3D 0; i < adev->sdma.num_instances; i++) {
> > > >>>>>>>>>>                 rb_cntl =3D RREG32(mmSDMA0_GFX_RB_CNTL + s=
dma_offsets[i]);
> > > >>>>>>>>>>                 rb_cntl =3D REG_SET_FIELD(rb_cntl, SDMA0_G=
FX_RB_CNTL, RB_ENABLE, 0);
> > > >>>>>>>>>> @@ -474,9 +472,6 @@ static int sdma_v2_4_gfx_resume(struct=
 amdgpu_device *adev)
> > > >>>>>>>>>>                 r =3D amdgpu_ring_test_helper(ring);
> > > >>>>>>>>>>                 if (r)
> > > >>>>>>>>>>                         return r;
> > > >>>>>>>>>> -
> > > >>>>>>>>>> -             if (adev->mman.buffer_funcs_ring =3D=3D ring=
)
> > > >>>>>>>>>> -                     amdgpu_ttm_set_buffer_funcs_status(a=
dev, true);
> > > >>>>>>>>>>         }
> > > >>>>>>>>>>
> > > >>>>>>>>>>         return 0;
> > > >>>>>>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v3_0.c b/driv=
ers/gpu/drm/amd/amdgpu/sdma_v3_0.c
> > > >>>>>>>>>> index c5ea32687eb5..2ad615be4bb3 100644
> > > >>>>>>>>>> --- a/drivers/gpu/drm/amd/amdgpu/sdma_v3_0.c
> > > >>>>>>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/sdma_v3_0.c
> > > >>>>>>>>>> @@ -513,8 +513,6 @@ static void sdma_v3_0_gfx_stop(struct =
amdgpu_device *adev)
> > > >>>>>>>>>>         u32 rb_cntl, ib_cntl;
> > > >>>>>>>>>>         int i;
> > > >>>>>>>>>>
> > > >>>>>>>>>> -     amdgpu_sdma_unset_buffer_funcs_helper(adev);
> > > >>>>>>>>>> -
> > > >>>>>>>>>>         for (i =3D 0; i < adev->sdma.num_instances; i++) {
> > > >>>>>>>>>>                 rb_cntl =3D RREG32(mmSDMA0_GFX_RB_CNTL + s=
dma_offsets[i]);
> > > >>>>>>>>>>                 rb_cntl =3D REG_SET_FIELD(rb_cntl, SDMA0_G=
FX_RB_CNTL, RB_ENABLE, 0);
> > > >>>>>>>>>> @@ -746,9 +744,6 @@ static int sdma_v3_0_gfx_resume(struct=
 amdgpu_device *adev)
> > > >>>>>>>>>>                 r =3D amdgpu_ring_test_helper(ring);
> > > >>>>>>>>>>                 if (r)
> > > >>>>>>>>>>                         return r;
> > > >>>>>>>>>> -
> > > >>>>>>>>>> -             if (adev->mman.buffer_funcs_ring =3D=3D ring=
)
> > > >>>>>>>>>> -                     amdgpu_ttm_set_buffer_funcs_status(a=
dev, true);
> > > >>>>>>>>>>         }
> > > >>>>>>>>>>
> > > >>>>>>>>>>         return 0;
> > > >>>>>>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c b/driv=
ers/gpu/drm/amd/amdgpu/sdma_v4_0.c
> > > >>>>>>>>>> index 683d51ae4bf1..3d68dd5523c6 100644
> > > >>>>>>>>>> --- a/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
> > > >>>>>>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
> > > >>>>>>>>>> @@ -877,8 +877,6 @@ static void sdma_v4_0_gfx_enable(struc=
t amdgpu_device *adev, bool enable)
> > > >>>>>>>>>>         u32 rb_cntl, ib_cntl;
> > > >>>>>>>>>>         int i;
> > > >>>>>>>>>>
> > > >>>>>>>>>> -     amdgpu_sdma_unset_buffer_funcs_helper(adev);
> > > >>>>>>>>>> -
> > > >>>>>>>>>>         for (i =3D 0; i < adev->sdma.num_instances; i++) {
> > > >>>>>>>>>>                 rb_cntl =3D RREG32_SDMA(i, mmSDMA0_GFX_RB_=
CNTL);
> > > >>>>>>>>>>                 rb_cntl =3D REG_SET_FIELD(rb_cntl, SDMA0_G=
FX_RB_CNTL, RB_ENABLE, enable ? 1 : 0);
> > > >>>>>>>>>> @@ -913,8 +911,6 @@ static void sdma_v4_0_page_stop(struct=
 amdgpu_device *adev)
> > > >>>>>>>>>>         u32 rb_cntl, ib_cntl;
> > > >>>>>>>>>>         int i;
> > > >>>>>>>>>>
> > > >>>>>>>>>> -     amdgpu_sdma_unset_buffer_funcs_helper(adev);
> > > >>>>>>>>>> -
> > > >>>>>>>>>>         for (i =3D 0; i < adev->sdma.num_instances; i++) {
> > > >>>>>>>>>>                 rb_cntl =3D RREG32_SDMA(i, mmSDMA0_PAGE_RB=
_CNTL);
> > > >>>>>>>>>>                 rb_cntl =3D REG_SET_FIELD(rb_cntl, SDMA0_P=
AGE_RB_CNTL,
> > > >>>>>>>>>> @@ -1402,13 +1398,7 @@ static int sdma_v4_0_start(struct a=
mdgpu_device *adev)
> > > >>>>>>>>>>                         r =3D amdgpu_ring_test_helper(page=
);
> > > >>>>>>>>>>                         if (r)
> > > >>>>>>>>>>                                 return r;
> > > >>>>>>>>>> -
> > > >>>>>>>>>> -                     if (adev->mman.buffer_funcs_ring =3D=
=3D page)
> > > >>>>>>>>>> -                             amdgpu_ttm_set_buffer_funcs_=
status(adev, true);
> > > >>>>>>>>>>                 }
> > > >>>>>>>>>> -
> > > >>>>>>>>>> -             if (adev->mman.buffer_funcs_ring =3D=3D ring=
)
> > > >>>>>>>>>> -                     amdgpu_ttm_set_buffer_funcs_status(a=
dev, true);
> > > >>>>>>>>>>         }
> > > >>>>>>>>>>
> > > >>>>>>>>>>         return r;
> > > >>>>>>>>>> @@ -1921,11 +1911,8 @@ static int sdma_v4_0_hw_fini(void *=
handle)
> > > >>>>>>>>>>         struct amdgpu_device *adev =3D (struct amdgpu_devi=
ce *)handle;
> > > >>>>>>>>>>         int i;
> > > >>>>>>>>>>
> > > >>>>>>>>>> -     if (amdgpu_sriov_vf(adev)) {
> > > >>>>>>>>>> -             /* disable the scheduler for SDMA */
> > > >>>>>>>>>> -             amdgpu_sdma_unset_buffer_funcs_helper(adev);
> > > >>>>>>>>>> +     if (amdgpu_sriov_vf(adev))
> > > >>>>>>>>>>                 return 0;
> > > >>>>>>>>>> -     }
> > > >>>>>>>>>>
> > > >>>>>>>>>>         if (amdgpu_ras_is_supported(adev, AMDGPU_RAS_BLOCK=
__SDMA)) {
> > > >>>>>>>>>>                 for (i =3D 0; i < adev->sdma.num_instances=
; i++) {
> > > >>>>>>>>>> @@ -1964,7 +1951,6 @@ static int sdma_v4_0_resume(void *ha=
ndle)
> > > >>>>>>>>>>         if (adev->in_s0ix) {
> > > >>>>>>>>>>                 sdma_v4_0_enable(adev, true);
> > > >>>>>>>>>>                 sdma_v4_0_gfx_enable(adev, true);
> > > >>>>>>>>>> -             amdgpu_ttm_set_buffer_funcs_status(adev, tru=
e);
> > > >>>>>>>>>>                 return 0;
> > > >>>>>>>>>>         }
> > > >>>>>>>>>>
> > > >>>>>>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c b/driv=
ers/gpu/drm/amd/amdgpu/sdma_v5_0.c
> > > >>>>>>>>>> index be5d099c9898..c78027ebdcb9 100644
> > > >>>>>>>>>> --- a/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c
> > > >>>>>>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c
> > > >>>>>>>>>> @@ -559,8 +559,6 @@ static void sdma_v5_0_gfx_stop(struct =
amdgpu_device *adev)
> > > >>>>>>>>>>         u32 rb_cntl, ib_cntl;
> > > >>>>>>>>>>         int i;
> > > >>>>>>>>>>
> > > >>>>>>>>>> -     amdgpu_sdma_unset_buffer_funcs_helper(adev);
> > > >>>>>>>>>> -
> > > >>>>>>>>>>         for (i =3D 0; i < adev->sdma.num_instances; i++) {
> > > >>>>>>>>>>                 rb_cntl =3D RREG32_SOC15_IP(GC, sdma_v5_0_=
get_reg_offset(adev, i, mmSDMA0_GFX_RB_CNTL));
> > > >>>>>>>>>>                 rb_cntl =3D REG_SET_FIELD(rb_cntl, SDMA0_G=
FX_RB_CNTL, RB_ENABLE, 0);
> > > >>>>>>>>>> @@ -825,9 +823,6 @@ static int sdma_v5_0_gfx_resume(struct=
 amdgpu_device *adev)
> > > >>>>>>>>>>                 r =3D amdgpu_ring_test_helper(ring);
> > > >>>>>>>>>>                 if (r)
> > > >>>>>>>>>>                         return r;
> > > >>>>>>>>>> -
> > > >>>>>>>>>> -             if (adev->mman.buffer_funcs_ring =3D=3D ring=
)
> > > >>>>>>>>>> -                     amdgpu_ttm_set_buffer_funcs_status(a=
dev, true);
> > > >>>>>>>>>>         }
> > > >>>>>>>>>>
> > > >>>>>>>>>>         return 0;
> > > >>>>>>>>>> @@ -1426,11 +1421,8 @@ static int sdma_v5_0_hw_fini(void *=
handle)
> > > >>>>>>>>>>     {
> > > >>>>>>>>>>         struct amdgpu_device *adev =3D (struct amdgpu_devi=
ce *)handle;
> > > >>>>>>>>>>
> > > >>>>>>>>>> -     if (amdgpu_sriov_vf(adev)) {
> > > >>>>>>>>>> -             /* disable the scheduler for SDMA */
> > > >>>>>>>>>> -             amdgpu_sdma_unset_buffer_funcs_helper(adev);
> > > >>>>>>>>>> +     if (amdgpu_sriov_vf(adev))
> > > >>>>>>>>>>                 return 0;
> > > >>>>>>>>>> -     }
> > > >>>>>>>>>>
> > > >>>>>>>>>>         sdma_v5_0_ctx_switch_enable(adev, false);
> > > >>>>>>>>>>         sdma_v5_0_enable(adev, false);
> > > >>>>>>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c b/driv=
ers/gpu/drm/amd/amdgpu/sdma_v5_2.c
> > > >>>>>>>>>> index a3e8b10c071c..2e35f3571774 100644
> > > >>>>>>>>>> --- a/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
> > > >>>>>>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
> > > >>>>>>>>>> @@ -364,8 +364,6 @@ static void sdma_v5_2_gfx_stop(struct =
amdgpu_device *adev)
> > > >>>>>>>>>>         u32 rb_cntl, ib_cntl;
> > > >>>>>>>>>>         int i;
> > > >>>>>>>>>>
> > > >>>>>>>>>> -     amdgpu_sdma_unset_buffer_funcs_helper(adev);
> > > >>>>>>>>>> -
> > > >>>>>>>>>>         for (i =3D 0; i < adev->sdma.num_instances; i++) {
> > > >>>>>>>>>>                 rb_cntl =3D RREG32_SOC15_IP(GC, sdma_v5_2_=
get_reg_offset(adev, i, mmSDMA0_GFX_RB_CNTL));
> > > >>>>>>>>>>                 rb_cntl =3D REG_SET_FIELD(rb_cntl, SDMA0_G=
FX_RB_CNTL, RB_ENABLE, 0);
> > > >>>>>>>>>> @@ -625,9 +623,6 @@ static int sdma_v5_2_gfx_resume(struct=
 amdgpu_device *adev)
> > > >>>>>>>>>>                 r =3D amdgpu_ring_test_helper(ring);
> > > >>>>>>>>>>                 if (r)
> > > >>>>>>>>>>                         return r;
> > > >>>>>>>>>> -
> > > >>>>>>>>>> -             if (adev->mman.buffer_funcs_ring =3D=3D ring=
)
> > > >>>>>>>>>> -                     amdgpu_ttm_set_buffer_funcs_status(a=
dev, true);
> > > >>>>>>>>>>         }
> > > >>>>>>>>>>
> > > >>>>>>>>>>         return 0;
> > > >>>>>>>>>> @@ -1284,11 +1279,8 @@ static int sdma_v5_2_hw_fini(void *=
handle)
> > > >>>>>>>>>>     {
> > > >>>>>>>>>>         struct amdgpu_device *adev =3D (struct amdgpu_devi=
ce *)handle;
> > > >>>>>>>>>>
> > > >>>>>>>>>> -     if (amdgpu_sriov_vf(adev)) {
> > > >>>>>>>>>> -             /* disable the scheduler for SDMA */
> > > >>>>>>>>>> -             amdgpu_sdma_unset_buffer_funcs_helper(adev);
> > > >>>>>>>>>> +     if (amdgpu_sriov_vf(adev))
> > > >>>>>>>>>>                 return 0;
> > > >>>>>>>>>> -     }
> > > >>>>>>>>>>
> > > >>>>>>>>>>         sdma_v5_2_ctx_switch_enable(adev, false);
> > > >>>>>>>>>>         sdma_v5_2_enable(adev, false);
> > > >>>>>>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c b/driv=
ers/gpu/drm/amd/amdgpu/sdma_v6_0.c
> > > >>>>>>>>>> index 445a34549d2c..1c6ff511f501 100644
> > > >>>>>>>>>> --- a/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c
> > > >>>>>>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c
> > > >>>>>>>>>> @@ -348,8 +348,6 @@ static void sdma_v6_0_gfx_stop(struct =
amdgpu_device *adev)
> > > >>>>>>>>>>         u32 rb_cntl, ib_cntl;
> > > >>>>>>>>>>         int i;
> > > >>>>>>>>>>
> > > >>>>>>>>>> -     amdgpu_sdma_unset_buffer_funcs_helper(adev);
> > > >>>>>>>>>> -
> > > >>>>>>>>>>         for (i =3D 0; i < adev->sdma.num_instances; i++) {
> > > >>>>>>>>>>                 rb_cntl =3D RREG32_SOC15_IP(GC, sdma_v6_0_=
get_reg_offset(adev, i, regSDMA0_QUEUE0_RB_CNTL));
> > > >>>>>>>>>>                 rb_cntl =3D REG_SET_FIELD(rb_cntl, SDMA0_Q=
UEUE0_RB_CNTL, RB_ENABLE, 0);
> > > >>>>>>>>>> @@ -561,9 +559,6 @@ static int sdma_v6_0_gfx_resume(struct=
 amdgpu_device *adev)
> > > >>>>>>>>>>                 r =3D amdgpu_ring_test_helper(ring);
> > > >>>>>>>>>>                 if (r)
> > > >>>>>>>>>>                         return r;
> > > >>>>>>>>>> -
> > > >>>>>>>>>> -             if (adev->mman.buffer_funcs_ring =3D=3D ring=
)
> > > >>>>>>>>>> -                     amdgpu_ttm_set_buffer_funcs_status(a=
dev, true);
> > > >>>>>>>>>>         }
> > > >>>>>>>>>>
> > > >>>>>>>>>>         return 0;
> > > >>>>>>>>>> @@ -1308,11 +1303,8 @@ static int sdma_v6_0_hw_fini(void *=
handle)
> > > >>>>>>>>>>     {
> > > >>>>>>>>>>         struct amdgpu_device *adev =3D (struct amdgpu_devi=
ce *)handle;
> > > >>>>>>>>>>
> > > >>>>>>>>>> -     if (amdgpu_sriov_vf(adev)) {
> > > >>>>>>>>>> -             /* disable the scheduler for SDMA */
> > > >>>>>>>>>> -             amdgpu_sdma_unset_buffer_funcs_helper(adev);
> > > >>>>>>>>>> +     if (amdgpu_sriov_vf(adev))
> > > >>>>>>>>>>                 return 0;
> > > >>>>>>>>>> -     }
> > > >>>>>>>>>>
> > > >>>>>>>>>>         sdma_v6_0_ctxempty_int_enable(adev, false);
> > > >>>>>>>>>>         sdma_v6_0_enable(adev, false);
> > > >>>>>>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/si_dma.c b/drivers=
/gpu/drm/amd/amdgpu/si_dma.c
> > > >>>>>>>>>> index 42c4547f32ec..9aa0e11ee673 100644
> > > >>>>>>>>>> --- a/drivers/gpu/drm/amd/amdgpu/si_dma.c
> > > >>>>>>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/si_dma.c
> > > >>>>>>>>>> @@ -115,8 +115,6 @@ static void si_dma_stop(struct amdgpu_=
device *adev)
> > > >>>>>>>>>>         u32 rb_cntl;
> > > >>>>>>>>>>         unsigned i;
> > > >>>>>>>>>>
> > > >>>>>>>>>> -     amdgpu_sdma_unset_buffer_funcs_helper(adev);
> > > >>>>>>>>>> -
> > > >>>>>>>>>>         for (i =3D 0; i < adev->sdma.num_instances; i++) {
> > > >>>>>>>>>>                 /* dma0 */
> > > >>>>>>>>>>                 rb_cntl =3D RREG32(DMA_RB_CNTL + sdma_offs=
ets[i]);
> > > >>>>>>>>>> @@ -177,9 +175,6 @@ static int si_dma_start(struct amdgpu_=
device *adev)
> > > >>>>>>>>>>                 r =3D amdgpu_ring_test_helper(ring);
> > > >>>>>>>>>>                 if (r)
> > > >>>>>>>>>>                         return r;
> > > >>>>>>>>>> -
> > > >>>>>>>>>> -             if (adev->mman.buffer_funcs_ring =3D=3D ring=
)
> > > >>>>>>>>>> -                     amdgpu_ttm_set_buffer_funcs_status(a=
dev, true);
> > > >>>>>>>>>>         }
> > > >>>>>>>>>>
> > > >>>>>>>>>>         return 0;
> > >
