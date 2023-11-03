Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40871C4167B
	for <amd-gfx@archiver.kernel.org>; Fri,  3 Nov 2023 20:17:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ADFF810E199;
	Fri,  3 Nov 2023 20:17:34 +0000 (UTC)
Received: from mail-ot1-x32c.google.com (mail-ot1-x32c.google.com
 [IPv6:2607:f8b0:4864:20::32c])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AADD310E199
 for <amd-gfx@lists.freedesktop.org>; Fri,  3 Nov 2023 20:17:33 +0000 (UTC)
Received: by mail-ot1-x32c.google.com with SMTP id
 46e09a7af769-6ce322b62aeso1372456a34.3
 for <amd-gfx@lists.freedesktop.org>; Fri, 03 Nov 2023 13:17:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1699042653; x=1699647453; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0oXRT1wuRrWYmF5KOJaGaAY4znDtA2eu0u2bh9yYpFo=;
 b=hZrlXn4nVvJuCf3O1z3nkGUM3Syu7/C1aRPD2QwcD5+4guMi1DEDc+54tVZqR61AWm
 90VeJOQwAn6s5zODzQ7zOuPH1HvEoPnQXdhD/5MavyeAwivW9RMAlrh7Hifp2dIWhitm
 bzkOC8pkQx/mV891SwYVI7kvnuQ+tczNaVnfcH+VzdBd2GwfHydLdgy8WhYDnPCctdNG
 MGd4e6vAG+XQf+/3hEzasVDpa6vXsqUhv3s0/Iaus81bFD3VwiLfUUexVzpmvU3C2e/q
 xvhPUu1MsbP7XGAqwvz4mPMKIe4qL2vN/bjeFLiFnt+RjIEpRaoTjx/xcIHqGKMzP4Ns
 rd6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699042653; x=1699647453;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=0oXRT1wuRrWYmF5KOJaGaAY4znDtA2eu0u2bh9yYpFo=;
 b=OuyQf3vnHHPwFw1I+/VYP4YYXOb0HMY+VQGsXPNL2XWjskRwjfj7YTuXhTQYVPGB4I
 +73vaIN74Hq3/sKvXnbnmCNKTjRfrFO2SOkSLnBA8/bEU5l6srcrBYCzAHFPW9jXHdGy
 FTdeIXR/BtdY/LJjnqWa5d80/YNU6IUkYt5ts6rz/OHZhJFPTi3pYrfrKoLfZ75Xcb4A
 jtvb3l2oVW9CY51wWIggOTkrREXHmfH+ek6sBYgtiU1N84poAYEjQFFu3aWLawnAZVx6
 Ul/pwLJNxPBeTmpsArtTiZtTEfLnWcozzAz5ZlV7b8GqB4jK9pVugLjwTaIhwu/QMtc5
 8yOQ==
X-Gm-Message-State: AOJu0Yyk/eKIJAeVal5Er5FPQbI5wh1RyL+YurgDlHmNRqc4klA8fxFg
 gthXFy6Uz8VESXCBBZ9bNxBYm8jyyicmoIQpVd9/uZt5dRw=
X-Google-Smtp-Source: AGHT+IEb1+C8sWRDin4HXR94g4AEuWqlez1ZGEsbeTQ32zTh55LBEkY+Sqs1M7jwOJLhERCETROAZOOjwkXuhjH3fas=
X-Received: by 2002:a05:6871:5a91:b0:1ea:2c8b:e18e with SMTP id
 oo17-20020a0568715a9100b001ea2c8be18emr28909676oac.8.1699042652682; Fri, 03
 Nov 2023 13:17:32 -0700 (PDT)
MIME-Version: 1.0
References: <20231025171928.3318505-1-alexander.deucher@amd.com>
 <96db9e3d-4636-4da4-b4d1-ca3f5fd8d887@gmail.com>
 <CADnq5_ORyv9MDfUd3NPDw+APUunDjkTW4Bx4z0FoCiK+s_i+uw@mail.gmail.com>
 <04db543c-7aec-4550-878f-a9753142130e@gmail.com>
 <a8a0eb47-3aca-4c87-b5f7-dc54e5667944@gmail.com>
In-Reply-To: <a8a0eb47-3aca-4c87-b5f7-dc54e5667944@gmail.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Fri, 3 Nov 2023 16:17:21 -0400
Message-ID: <CADnq5_PS64jYS_Y3kGW27m-kuWP+FQFiaVcOaZiB=JLSgPnXBQ@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: move buffer funcs setting up a level
To: Luben Tuikov <ltuikov89@gmail.com>
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
 =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>,
 Luben Tuikov <luben.tuikov@amd.com>, amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Thu, Oct 26, 2023 at 4:17=E2=80=AFPM Luben Tuikov <ltuikov89@gmail.com> =
wrote:
>
> Pushed to drm-misc-next.

BTW, I'm seeing the following on older GPUs with VCE and UVD even with
this patch:
[   11.886024] amdgpu 0000:0a:00.0: [drm] *ERROR* drm_sched_job_init:
entity has no rq!
[   11.886028] amdgpu 0000:0a:00.0: [drm:amdgpu_ib_ring_tests
[amdgpu]] *ERROR* IB test failed on uvd (-2).
[   11.889927] amdgpu 0000:0a:00.0: [drm] *ERROR* drm_sched_job_init:
entity has no rq!
[   11.889930] amdgpu 0000:0a:00.0: [drm:amdgpu_ib_ring_tests
[amdgpu]] *ERROR* IB test failed on vce0 (-2).
[   11.890172] [drm:process_one_work] *ERROR* ib ring test failed (-2).
Seems to be specific to UVD and VCE, I don't see anything similar with
VCN, but the flows for both are pretty similar.  Not sure why we are
not seeing it for VCN.  Just a heads up if you have any ideas.  Will
take a closer look next week.

Alex

>
> Regards,
> Luben
>
> On 2023-10-26 15:52, Luben Tuikov wrote:
> > On 2023-10-26 15:32, Alex Deucher wrote:
> >> On Thu, Oct 26, 2023 at 2:22=E2=80=AFAM Christian K=C3=B6nig
> >> <ckoenig.leichtzumerken@gmail.com> wrote:
> >>>
> >>> Am 25.10.23 um 19:19 schrieb Alex Deucher:
> >>>> Rather than doing this in the IP code for the SDMA paging
> >>>> engine, move it up to the core device level init level.
> >>>> This should fix the scheduler init ordering.
> >>>>
> >>>> v2: drop extra parens
> >>>> v3: drop SDMA helpers
> >>>>
> >>>> Tested-by: Luben Tuikov <luben.tuikov@amd.com>
> >>>> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> >>>
> >>> I don't know of hand if the high level function really cover everythi=
ng,
> >>> so only Acked-by: Christian K=C3=B6nig <christian.koenig@amd.com> for=
 now.
> >>>
> >>
> >> Luben,
> >>
> >> Was this needed for some of the scheduler stuff that is pending?  If
> >> you would rather take it via drm-misc to align with the scheduler
> >> changes, that works for me, otherwise I can take it via the amdgpu
> >> tree.
> >
> > Hi Alex,
> >
> > Yes, it does.
> >
> > I can take it via drm-misc-next as that where the scheduler changes lan=
ded.
> >
> > I'll add Christian's Acked-by.
> >
> > I'll add a Fixes tag because ideally it should've gone before the dynam=
ic
> > sched_rq commit.
> >
> > Thanks for the heads-up!
> >
> > Regards,
> > Luben
> >
> >
> >
> >>
> >> Thanks,
> >>
> >> Alex
> >>
> >>
> >>> Christian.
> >>>
> >>>> ---
> >>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 15 +++++++++++++++
> >>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c   | 21 ------------------=
---
> >>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h   |  1 -
> >>>>   drivers/gpu/drm/amd/amdgpu/cik_sdma.c      |  5 -----
> >>>>   drivers/gpu/drm/amd/amdgpu/sdma_v2_4.c     |  5 -----
> >>>>   drivers/gpu/drm/amd/amdgpu/sdma_v3_0.c     |  5 -----
> >>>>   drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c     | 16 +---------------
> >>>>   drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c     | 10 +---------
> >>>>   drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c     | 10 +---------
> >>>>   drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c     | 10 +---------
> >>>>   drivers/gpu/drm/amd/amdgpu/si_dma.c        |  5 -----
> >>>>   11 files changed, 19 insertions(+), 84 deletions(-)
> >>>>
> >>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gp=
u/drm/amd/amdgpu/amdgpu_device.c
> >>>> index 2031a467b721..5c90080e93ba 100644
> >>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> >>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> >>>> @@ -2662,6 +2662,9 @@ static int amdgpu_device_ip_init(struct amdgpu=
_device *adev)
> >>>>       if (r)
> >>>>               goto init_failed;
> >>>>
> >>>> +     if (adev->mman.buffer_funcs_ring->sched.ready)
> >>>> +             amdgpu_ttm_set_buffer_funcs_status(adev, true);
> >>>> +
> >>>>       /* Don't init kfd if whole hive need to be reset during init *=
/
> >>>>       if (!adev->gmc.xgmi.pending_reset) {
> >>>>               kgd2kfd_init_zone_device(adev);
> >>>> @@ -3260,6 +3263,8 @@ int amdgpu_device_ip_suspend(struct amdgpu_dev=
ice *adev)
> >>>>               amdgpu_virt_request_full_gpu(adev, false);
> >>>>       }
> >>>>
> >>>> +     amdgpu_ttm_set_buffer_funcs_status(adev, false);
> >>>> +
> >>>>       r =3D amdgpu_device_ip_suspend_phase1(adev);
> >>>>       if (r)
> >>>>               return r;
> >>>> @@ -3449,6 +3454,9 @@ static int amdgpu_device_ip_resume(struct amdg=
pu_device *adev)
> >>>>
> >>>>       r =3D amdgpu_device_ip_resume_phase2(adev);
> >>>>
> >>>> +     if (adev->mman.buffer_funcs_ring->sched.ready)
> >>>> +             amdgpu_ttm_set_buffer_funcs_status(adev, true);
> >>>> +
> >>>>       return r;
> >>>>   }
> >>>>
> >>>> @@ -4236,6 +4244,8 @@ void amdgpu_device_fini_hw(struct amdgpu_devic=
e *adev)
> >>>>       /* disable ras feature must before hw fini */
> >>>>       amdgpu_ras_pre_fini(adev);
> >>>>
> >>>> +     amdgpu_ttm_set_buffer_funcs_status(adev, false);
> >>>> +
> >>>>       amdgpu_device_ip_fini_early(adev);
> >>>>
> >>>>       amdgpu_irq_fini_hw(adev);
> >>>> @@ -4407,6 +4417,8 @@ int amdgpu_device_suspend(struct drm_device *d=
ev, bool fbcon)
> >>>>
> >>>>       amdgpu_ras_suspend(adev);
> >>>>
> >>>> +     amdgpu_ttm_set_buffer_funcs_status(adev, false);
> >>>> +
> >>>>       amdgpu_device_ip_suspend_phase1(adev);
> >>>>
> >>>>       if (!adev->in_s0ix)
> >>>> @@ -5178,6 +5190,9 @@ int amdgpu_do_asic_reset(struct list_head *dev=
ice_list_handle,
> >>>>                               if (r)
> >>>>                                       goto out;
> >>>>
> >>>> +                             if (tmp_adev->mman.buffer_funcs_ring->=
sched.ready)
> >>>> +                                     amdgpu_ttm_set_buffer_funcs_st=
atus(tmp_adev, true);
> >>>> +
> >>>>                               if (vram_lost)
> >>>>                                       amdgpu_device_fill_reset_magic=
(tmp_adev);
> >>>>
> >>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c b/drivers/gpu/=
drm/amd/amdgpu/amdgpu_sdma.c
> >>>> index e8cbc4142d80..1d9d187de6ee 100644
> >>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c
> >>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c
> >>>> @@ -292,27 +292,6 @@ int amdgpu_sdma_init_microcode(struct amdgpu_de=
vice *adev,
> >>>>       return err;
> >>>>   }
> >>>>
> >>>> -void amdgpu_sdma_unset_buffer_funcs_helper(struct amdgpu_device *ad=
ev)
> >>>> -{
> >>>> -     struct amdgpu_ring *sdma;
> >>>> -     int i;
> >>>> -
> >>>> -     for (i =3D 0; i < adev->sdma.num_instances; i++) {
> >>>> -             if (adev->sdma.has_page_queue) {
> >>>> -                     sdma =3D &adev->sdma.instance[i].page;
> >>>> -                     if (adev->mman.buffer_funcs_ring =3D=3D sdma) =
{
> >>>> -                             amdgpu_ttm_set_buffer_funcs_status(ade=
v, false);
> >>>> -                             break;
> >>>> -                     }
> >>>> -             }
> >>>> -             sdma =3D &adev->sdma.instance[i].ring;
> >>>> -             if (adev->mman.buffer_funcs_ring =3D=3D sdma) {
> >>>> -                     amdgpu_ttm_set_buffer_funcs_status(adev, false=
);
> >>>> -                     break;
> >>>> -             }
> >>>> -     }
> >>>> -}
> >>>> -
> >>>>   int amdgpu_sdma_ras_sw_init(struct amdgpu_device *adev)
> >>>>   {
> >>>>       int err =3D 0;
> >>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h b/drivers/gpu/=
drm/amd/amdgpu/amdgpu_sdma.h
> >>>> index 513ac22120c1..173a2a308078 100644
> >>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h
> >>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h
> >>>> @@ -169,7 +169,6 @@ int amdgpu_sdma_init_microcode(struct amdgpu_dev=
ice *adev, u32 instance,
> >>>>                              bool duplicate);
> >>>>   void amdgpu_sdma_destroy_inst_ctx(struct amdgpu_device *adev,
> >>>>           bool duplicate);
> >>>> -void amdgpu_sdma_unset_buffer_funcs_helper(struct amdgpu_device *ad=
ev);
> >>>>   int amdgpu_sdma_ras_sw_init(struct amdgpu_device *adev);
> >>>>
> >>>>   #endif
> >>>> diff --git a/drivers/gpu/drm/amd/amdgpu/cik_sdma.c b/drivers/gpu/drm=
/amd/amdgpu/cik_sdma.c
> >>>> index ee5dce6f6043..a3fccc4c1f43 100644
> >>>> --- a/drivers/gpu/drm/amd/amdgpu/cik_sdma.c
> >>>> +++ b/drivers/gpu/drm/amd/amdgpu/cik_sdma.c
> >>>> @@ -308,8 +308,6 @@ static void cik_sdma_gfx_stop(struct amdgpu_devi=
ce *adev)
> >>>>       u32 rb_cntl;
> >>>>       int i;
> >>>>
> >>>> -     amdgpu_sdma_unset_buffer_funcs_helper(adev);
> >>>> -
> >>>>       for (i =3D 0; i < adev->sdma.num_instances; i++) {
> >>>>               rb_cntl =3D RREG32(mmSDMA0_GFX_RB_CNTL + sdma_offsets[=
i]);
> >>>>               rb_cntl &=3D ~SDMA0_GFX_RB_CNTL__RB_ENABLE_MASK;
> >>>> @@ -498,9 +496,6 @@ static int cik_sdma_gfx_resume(struct amdgpu_dev=
ice *adev)
> >>>>               r =3D amdgpu_ring_test_helper(ring);
> >>>>               if (r)
> >>>>                       return r;
> >>>> -
> >>>> -             if (adev->mman.buffer_funcs_ring =3D=3D ring)
> >>>> -                     amdgpu_ttm_set_buffer_funcs_status(adev, true)=
;
> >>>>       }
> >>>>
> >>>>       return 0;
> >>>> diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v2_4.c b/drivers/gpu/dr=
m/amd/amdgpu/sdma_v2_4.c
> >>>> index b58a13bd75db..45377a175250 100644
> >>>> --- a/drivers/gpu/drm/amd/amdgpu/sdma_v2_4.c
> >>>> +++ b/drivers/gpu/drm/amd/amdgpu/sdma_v2_4.c
> >>>> @@ -339,8 +339,6 @@ static void sdma_v2_4_gfx_stop(struct amdgpu_dev=
ice *adev)
> >>>>       u32 rb_cntl, ib_cntl;
> >>>>       int i;
> >>>>
> >>>> -     amdgpu_sdma_unset_buffer_funcs_helper(adev);
> >>>> -
> >>>>       for (i =3D 0; i < adev->sdma.num_instances; i++) {
> >>>>               rb_cntl =3D RREG32(mmSDMA0_GFX_RB_CNTL + sdma_offsets[=
i]);
> >>>>               rb_cntl =3D REG_SET_FIELD(rb_cntl, SDMA0_GFX_RB_CNTL, =
RB_ENABLE, 0);
> >>>> @@ -474,9 +472,6 @@ static int sdma_v2_4_gfx_resume(struct amdgpu_de=
vice *adev)
> >>>>               r =3D amdgpu_ring_test_helper(ring);
> >>>>               if (r)
> >>>>                       return r;
> >>>> -
> >>>> -             if (adev->mman.buffer_funcs_ring =3D=3D ring)
> >>>> -                     amdgpu_ttm_set_buffer_funcs_status(adev, true)=
;
> >>>>       }
> >>>>
> >>>>       return 0;
> >>>> diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v3_0.c b/drivers/gpu/dr=
m/amd/amdgpu/sdma_v3_0.c
> >>>> index c5ea32687eb5..2ad615be4bb3 100644
> >>>> --- a/drivers/gpu/drm/amd/amdgpu/sdma_v3_0.c
> >>>> +++ b/drivers/gpu/drm/amd/amdgpu/sdma_v3_0.c
> >>>> @@ -513,8 +513,6 @@ static void sdma_v3_0_gfx_stop(struct amdgpu_dev=
ice *adev)
> >>>>       u32 rb_cntl, ib_cntl;
> >>>>       int i;
> >>>>
> >>>> -     amdgpu_sdma_unset_buffer_funcs_helper(adev);
> >>>> -
> >>>>       for (i =3D 0; i < adev->sdma.num_instances; i++) {
> >>>>               rb_cntl =3D RREG32(mmSDMA0_GFX_RB_CNTL + sdma_offsets[=
i]);
> >>>>               rb_cntl =3D REG_SET_FIELD(rb_cntl, SDMA0_GFX_RB_CNTL, =
RB_ENABLE, 0);
> >>>> @@ -746,9 +744,6 @@ static int sdma_v3_0_gfx_resume(struct amdgpu_de=
vice *adev)
> >>>>               r =3D amdgpu_ring_test_helper(ring);
> >>>>               if (r)
> >>>>                       return r;
> >>>> -
> >>>> -             if (adev->mman.buffer_funcs_ring =3D=3D ring)
> >>>> -                     amdgpu_ttm_set_buffer_funcs_status(adev, true)=
;
> >>>>       }
> >>>>
> >>>>       return 0;
> >>>> diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c b/drivers/gpu/dr=
m/amd/amdgpu/sdma_v4_0.c
> >>>> index 683d51ae4bf1..3d68dd5523c6 100644
> >>>> --- a/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
> >>>> +++ b/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
> >>>> @@ -877,8 +877,6 @@ static void sdma_v4_0_gfx_enable(struct amdgpu_d=
evice *adev, bool enable)
> >>>>       u32 rb_cntl, ib_cntl;
> >>>>       int i;
> >>>>
> >>>> -     amdgpu_sdma_unset_buffer_funcs_helper(adev);
> >>>> -
> >>>>       for (i =3D 0; i < adev->sdma.num_instances; i++) {
> >>>>               rb_cntl =3D RREG32_SDMA(i, mmSDMA0_GFX_RB_CNTL);
> >>>>               rb_cntl =3D REG_SET_FIELD(rb_cntl, SDMA0_GFX_RB_CNTL, =
RB_ENABLE, enable ? 1 : 0);
> >>>> @@ -913,8 +911,6 @@ static void sdma_v4_0_page_stop(struct amdgpu_de=
vice *adev)
> >>>>       u32 rb_cntl, ib_cntl;
> >>>>       int i;
> >>>>
> >>>> -     amdgpu_sdma_unset_buffer_funcs_helper(adev);
> >>>> -
> >>>>       for (i =3D 0; i < adev->sdma.num_instances; i++) {
> >>>>               rb_cntl =3D RREG32_SDMA(i, mmSDMA0_PAGE_RB_CNTL);
> >>>>               rb_cntl =3D REG_SET_FIELD(rb_cntl, SDMA0_PAGE_RB_CNTL,
> >>>> @@ -1402,13 +1398,7 @@ static int sdma_v4_0_start(struct amdgpu_devi=
ce *adev)
> >>>>                       r =3D amdgpu_ring_test_helper(page);
> >>>>                       if (r)
> >>>>                               return r;
> >>>> -
> >>>> -                     if (adev->mman.buffer_funcs_ring =3D=3D page)
> >>>> -                             amdgpu_ttm_set_buffer_funcs_status(ade=
v, true);
> >>>>               }
> >>>> -
> >>>> -             if (adev->mman.buffer_funcs_ring =3D=3D ring)
> >>>> -                     amdgpu_ttm_set_buffer_funcs_status(adev, true)=
;
> >>>>       }
> >>>>
> >>>>       return r;
> >>>> @@ -1921,11 +1911,8 @@ static int sdma_v4_0_hw_fini(void *handle)
> >>>>       struct amdgpu_device *adev =3D (struct amdgpu_device *)handle;
> >>>>       int i;
> >>>>
> >>>> -     if (amdgpu_sriov_vf(adev)) {
> >>>> -             /* disable the scheduler for SDMA */
> >>>> -             amdgpu_sdma_unset_buffer_funcs_helper(adev);
> >>>> +     if (amdgpu_sriov_vf(adev))
> >>>>               return 0;
> >>>> -     }
> >>>>
> >>>>       if (amdgpu_ras_is_supported(adev, AMDGPU_RAS_BLOCK__SDMA)) {
> >>>>               for (i =3D 0; i < adev->sdma.num_instances; i++) {
> >>>> @@ -1964,7 +1951,6 @@ static int sdma_v4_0_resume(void *handle)
> >>>>       if (adev->in_s0ix) {
> >>>>               sdma_v4_0_enable(adev, true);
> >>>>               sdma_v4_0_gfx_enable(adev, true);
> >>>> -             amdgpu_ttm_set_buffer_funcs_status(adev, true);
> >>>>               return 0;
> >>>>       }
> >>>>
> >>>> diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c b/drivers/gpu/dr=
m/amd/amdgpu/sdma_v5_0.c
> >>>> index be5d099c9898..c78027ebdcb9 100644
> >>>> --- a/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c
> >>>> +++ b/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c
> >>>> @@ -559,8 +559,6 @@ static void sdma_v5_0_gfx_stop(struct amdgpu_dev=
ice *adev)
> >>>>       u32 rb_cntl, ib_cntl;
> >>>>       int i;
> >>>>
> >>>> -     amdgpu_sdma_unset_buffer_funcs_helper(adev);
> >>>> -
> >>>>       for (i =3D 0; i < adev->sdma.num_instances; i++) {
> >>>>               rb_cntl =3D RREG32_SOC15_IP(GC, sdma_v5_0_get_reg_offs=
et(adev, i, mmSDMA0_GFX_RB_CNTL));
> >>>>               rb_cntl =3D REG_SET_FIELD(rb_cntl, SDMA0_GFX_RB_CNTL, =
RB_ENABLE, 0);
> >>>> @@ -825,9 +823,6 @@ static int sdma_v5_0_gfx_resume(struct amdgpu_de=
vice *adev)
> >>>>               r =3D amdgpu_ring_test_helper(ring);
> >>>>               if (r)
> >>>>                       return r;
> >>>> -
> >>>> -             if (adev->mman.buffer_funcs_ring =3D=3D ring)
> >>>> -                     amdgpu_ttm_set_buffer_funcs_status(adev, true)=
;
> >>>>       }
> >>>>
> >>>>       return 0;
> >>>> @@ -1426,11 +1421,8 @@ static int sdma_v5_0_hw_fini(void *handle)
> >>>>   {
> >>>>       struct amdgpu_device *adev =3D (struct amdgpu_device *)handle;
> >>>>
> >>>> -     if (amdgpu_sriov_vf(adev)) {
> >>>> -             /* disable the scheduler for SDMA */
> >>>> -             amdgpu_sdma_unset_buffer_funcs_helper(adev);
> >>>> +     if (amdgpu_sriov_vf(adev))
> >>>>               return 0;
> >>>> -     }
> >>>>
> >>>>       sdma_v5_0_ctx_switch_enable(adev, false);
> >>>>       sdma_v5_0_enable(adev, false);
> >>>> diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c b/drivers/gpu/dr=
m/amd/amdgpu/sdma_v5_2.c
> >>>> index a3e8b10c071c..2e35f3571774 100644
> >>>> --- a/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
> >>>> +++ b/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
> >>>> @@ -364,8 +364,6 @@ static void sdma_v5_2_gfx_stop(struct amdgpu_dev=
ice *adev)
> >>>>       u32 rb_cntl, ib_cntl;
> >>>>       int i;
> >>>>
> >>>> -     amdgpu_sdma_unset_buffer_funcs_helper(adev);
> >>>> -
> >>>>       for (i =3D 0; i < adev->sdma.num_instances; i++) {
> >>>>               rb_cntl =3D RREG32_SOC15_IP(GC, sdma_v5_2_get_reg_offs=
et(adev, i, mmSDMA0_GFX_RB_CNTL));
> >>>>               rb_cntl =3D REG_SET_FIELD(rb_cntl, SDMA0_GFX_RB_CNTL, =
RB_ENABLE, 0);
> >>>> @@ -625,9 +623,6 @@ static int sdma_v5_2_gfx_resume(struct amdgpu_de=
vice *adev)
> >>>>               r =3D amdgpu_ring_test_helper(ring);
> >>>>               if (r)
> >>>>                       return r;
> >>>> -
> >>>> -             if (adev->mman.buffer_funcs_ring =3D=3D ring)
> >>>> -                     amdgpu_ttm_set_buffer_funcs_status(adev, true)=
;
> >>>>       }
> >>>>
> >>>>       return 0;
> >>>> @@ -1284,11 +1279,8 @@ static int sdma_v5_2_hw_fini(void *handle)
> >>>>   {
> >>>>       struct amdgpu_device *adev =3D (struct amdgpu_device *)handle;
> >>>>
> >>>> -     if (amdgpu_sriov_vf(adev)) {
> >>>> -             /* disable the scheduler for SDMA */
> >>>> -             amdgpu_sdma_unset_buffer_funcs_helper(adev);
> >>>> +     if (amdgpu_sriov_vf(adev))
> >>>>               return 0;
> >>>> -     }
> >>>>
> >>>>       sdma_v5_2_ctx_switch_enable(adev, false);
> >>>>       sdma_v5_2_enable(adev, false);
> >>>> diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c b/drivers/gpu/dr=
m/amd/amdgpu/sdma_v6_0.c
> >>>> index 445a34549d2c..1c6ff511f501 100644
> >>>> --- a/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c
> >>>> +++ b/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c
> >>>> @@ -348,8 +348,6 @@ static void sdma_v6_0_gfx_stop(struct amdgpu_dev=
ice *adev)
> >>>>       u32 rb_cntl, ib_cntl;
> >>>>       int i;
> >>>>
> >>>> -     amdgpu_sdma_unset_buffer_funcs_helper(adev);
> >>>> -
> >>>>       for (i =3D 0; i < adev->sdma.num_instances; i++) {
> >>>>               rb_cntl =3D RREG32_SOC15_IP(GC, sdma_v6_0_get_reg_offs=
et(adev, i, regSDMA0_QUEUE0_RB_CNTL));
> >>>>               rb_cntl =3D REG_SET_FIELD(rb_cntl, SDMA0_QUEUE0_RB_CNT=
L, RB_ENABLE, 0);
> >>>> @@ -561,9 +559,6 @@ static int sdma_v6_0_gfx_resume(struct amdgpu_de=
vice *adev)
> >>>>               r =3D amdgpu_ring_test_helper(ring);
> >>>>               if (r)
> >>>>                       return r;
> >>>> -
> >>>> -             if (adev->mman.buffer_funcs_ring =3D=3D ring)
> >>>> -                     amdgpu_ttm_set_buffer_funcs_status(adev, true)=
;
> >>>>       }
> >>>>
> >>>>       return 0;
> >>>> @@ -1308,11 +1303,8 @@ static int sdma_v6_0_hw_fini(void *handle)
> >>>>   {
> >>>>       struct amdgpu_device *adev =3D (struct amdgpu_device *)handle;
> >>>>
> >>>> -     if (amdgpu_sriov_vf(adev)) {
> >>>> -             /* disable the scheduler for SDMA */
> >>>> -             amdgpu_sdma_unset_buffer_funcs_helper(adev);
> >>>> +     if (amdgpu_sriov_vf(adev))
> >>>>               return 0;
> >>>> -     }
> >>>>
> >>>>       sdma_v6_0_ctxempty_int_enable(adev, false);
> >>>>       sdma_v6_0_enable(adev, false);
> >>>> diff --git a/drivers/gpu/drm/amd/amdgpu/si_dma.c b/drivers/gpu/drm/a=
md/amdgpu/si_dma.c
> >>>> index 42c4547f32ec..9aa0e11ee673 100644
> >>>> --- a/drivers/gpu/drm/amd/amdgpu/si_dma.c
> >>>> +++ b/drivers/gpu/drm/amd/amdgpu/si_dma.c
> >>>> @@ -115,8 +115,6 @@ static void si_dma_stop(struct amdgpu_device *ad=
ev)
> >>>>       u32 rb_cntl;
> >>>>       unsigned i;
> >>>>
> >>>> -     amdgpu_sdma_unset_buffer_funcs_helper(adev);
> >>>> -
> >>>>       for (i =3D 0; i < adev->sdma.num_instances; i++) {
> >>>>               /* dma0 */
> >>>>               rb_cntl =3D RREG32(DMA_RB_CNTL + sdma_offsets[i]);
> >>>> @@ -177,9 +175,6 @@ static int si_dma_start(struct amdgpu_device *ad=
ev)
> >>>>               r =3D amdgpu_ring_test_helper(ring);
> >>>>               if (r)
> >>>>                       return r;
> >>>> -
> >>>> -             if (adev->mman.buffer_funcs_ring =3D=3D ring)
> >>>> -                     amdgpu_ttm_set_buffer_funcs_status(adev, true)=
;
> >>>>       }
> >>>>
> >>>>       return 0;
> >>>
