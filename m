Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1AF0C4167B
	for <amd-gfx@archiver.kernel.org>; Thu, 14 Dec 2023 15:07:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0D44C10E94D;
	Thu, 14 Dec 2023 15:07:03 +0000 (UTC)
Received: from mail-oi1-x236.google.com (mail-oi1-x236.google.com
 [IPv6:2607:f8b0:4864:20::236])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 885E510E082
 for <amd-gfx@lists.freedesktop.org>; Thu, 14 Dec 2023 15:07:00 +0000 (UTC)
Received: by mail-oi1-x236.google.com with SMTP id
 5614622812f47-3ba14203a34so3384493b6e.1
 for <amd-gfx@lists.freedesktop.org>; Thu, 14 Dec 2023 07:07:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1702566420; x=1703171220; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zkadjp+S4jzfVAke2T2Z7YZN6Mf36+pCo1n1lzetNm4=;
 b=L/8X4GfZiAd4t6+nqybMAYWYzmGqV6e2/FJSfnE4++i4nkuymsf7YEit1HhyJVx7nT
 fGVwkodSCl1Q59Baet5j06X+wIakaXn880b703x9aI1oe1fUHf/PN9kVP52yN6k4N4BD
 NFOr/w9aCioZE8P8GTDzv1ldJb87Shb24iegUbB7zIRc/yRyXMDW18DRK1NgAUbNMMiS
 I7rlGQc1csQ5FCS0aPnv0hBbon3zWYtYWxpKXdVt7mruuF7Bk9etQ3lcgLAJqCbdrRoc
 eA2Rf51M2t7k1KpJDdp39ju5m5PZR+27qmV3Pa03fqEpHIUyU9zAT/HtkU4T2uDVVrqq
 X7dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702566420; x=1703171220;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=zkadjp+S4jzfVAke2T2Z7YZN6Mf36+pCo1n1lzetNm4=;
 b=dLpeY0mGURSsU5BoL5vlqxrw+el5fmzq9qbO2sAJfa6LIgZ+kJlvq1nvun1Phr41lr
 52J8r0WNuPOoeGxPapjDqThx+JbPOj3BXDMYrralokqWmgZcHEUKmPIM5wYrgRv5zs/e
 Y2rU4zWBUe3ymkvbUtjDltRT8XmYPZMG3qmUO65ALm3dqsxIF6onaX0yd5eI6CJ6LF6h
 /2FQ20Of9bb293oXw62MvXbLeBykXBFhgBXgjJWvD6kvNf1x7jmhTT9cmaOLFuIOHzH7
 km1LpujrMPKq76BkFVPylwpBV5nlZs1MNU0R3hr7oNEfASOo649Az5D/XHtJbVnYoAnG
 hz9A==
X-Gm-Message-State: AOJu0YxazfLmTi8pc3a9ad5LAdA7CmRep1GVvp+GI5D7R2gPWmz6fMEL
 V8VfEi46P8kGmxxoXq7gByd9cWiFplbdcXhdR7il7XCEOgg=
X-Google-Smtp-Source: AGHT+IH4KeCknNQ9LpfdpQkhQicWWBln2SNqKG2x7aOph2Gr1++DJNnK+19GXw8mjUgMec2GpZiUCGoWQDGyhJpBrSc=
X-Received: by 2002:a05:6871:298:b0:203:e13:32fe with SMTP id
 i24-20020a056871029800b002030e1332femr4759842oae.7.1702566419682; Thu, 14 Dec
 2023 07:06:59 -0800 (PST)
MIME-Version: 1.0
References: <20231213170454.5962-1-mario.limonciello@amd.com>
 <CADnq5_O=Kp+TkSEHXxSPEtWEYknFL_e_D7m5nXN=y8CJrR950g@mail.gmail.com>
 <38da4566-d936-42d9-9879-eee993270da0@amd.com>
 <13694238-418a-4fcb-8921-f9ab31e08120@amd.com>
 <CADnq5_MkkWqLyC3VYbTXSX7JL2Q5aaeJ6sFT9ROXjqdVfsXgjw@mail.gmail.com>
 <aacee34d-a62a-4af6-8fb8-de981e1dfc9c@gmail.com>
 <CH0PR12MB537285E50B5A53BA1048FCD0F48CA@CH0PR12MB5372.namprd12.prod.outlook.com>
In-Reply-To: <CH0PR12MB537285E50B5A53BA1048FCD0F48CA@CH0PR12MB5372.namprd12.prod.outlook.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 14 Dec 2023 10:06:48 -0500
Message-ID: <CADnq5_OW=aAHrhi6Zwc4OGtLthYh3NKw2Gq-CppBtYJUE-ybEA@mail.gmail.com>
Subject: Re: [PATCH] drm/amd: Add a workaround for GFX11 systems that fail to
 flush TLB
To: "Liu, Shaoyun" <Shaoyun.Liu@amd.com>
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
Cc: "Huang, Tim" <Tim.Huang@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>,
 "stable@vger.kernel.org" <stable@vger.kernel.org>, "Limonciello,
 Mario" <Mario.Limonciello@amd.com>, "Koenig,
 Christian" <Christian.Koenig@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Thu, Dec 14, 2023 at 9:24=E2=80=AFAM Liu, Shaoyun <Shaoyun.Liu@amd.com> =
wrote:
>
> [AMD Official Use Only - General]
>
> The gmc flush tlb function is used on both  baremetal and sriov.   But th=
e  function  amdgpu_virt_kiq_reg_write_reg_wait is defined in amdgpu_virt.c=
 with  name  'virt'  make it appear as a SRIOV only function, this sounds c=
onfusion . Will it make more sense to move the function out of amdgpu_virt.=
c file and  rename it as amdgpu_kig_reg_write_reg_wait ?
>
> Another thing I'm not sure is inside amdgpu_virt_kiq_reg_write_reg_wait ,=
 has below logic :
>         if (adev->mes.ring.sched.ready) {
>                 amdgpu_mes_reg_write_reg_wait(adev, reg0, reg1,
>                                               ref, mask);
>                 return;
>         }
> On MES enabled situation , it will always call to mes queue to do the reg=
ister write and  wait .  Shouldn't this OP been directly send to kiq itself=
 ?  The ring for kiq and  mes is different ,  driver should use kiq(adev->g=
fx.kiq[0].ring) for these register read/write or wait operation  and  mes (=
 adev->mes.ring) for add/remove queues  etc.
>

I understand why it is needed for SR-IOV.  Is there a reason to use
the MES or KIQ for TLB invalidation rather than the register method on
bare metal?  It looks like the register method is never used anymore.
 Seems like we should either, make the KIQ/MES method SR-IOV only, or
drop the register method and just always use KIQ/MES.

Alex


> Regards
> Shaoyun.liu
>
> -----Original Message-----
> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Christ=
ian K=C3=B6nig
> Sent: Thursday, December 14, 2023 4:22 AM
> To: Alex Deucher <alexdeucher@gmail.com>; Limonciello, Mario <Mario.Limon=
ciello@amd.com>
> Cc: Huang, Tim <Tim.Huang@amd.com>; amd-gfx@lists.freedesktop.org; Koenig=
, Christian <Christian.Koenig@amd.com>; stable@vger.kernel.org
> Subject: Re: [PATCH] drm/amd: Add a workaround for GFX11 systems that fai=
l to flush TLB
>
> Am 13.12.23 um 20:44 schrieb Alex Deucher:
> > On Wed, Dec 13, 2023 at 2:32=E2=80=AFPM Mario Limonciello
> > <mario.limonciello@amd.com> wrote:
> >> On 12/13/2023 13:12, Mario Limonciello wrote:
> >>> On 12/13/2023 13:07, Alex Deucher wrote:
> >>>> On Wed, Dec 13, 2023 at 1:00=E2=80=AFPM Mario Limonciello
> >>>> <mario.limonciello@amd.com> wrote:
> >>>>> Some systems with MP1 13.0.4 or 13.0.11 have a firmware bug that
> >>>>> causes the first MES packet after resume to fail. This packet is
> >>>>> used to flush the TLB when GART is enabled.
> >>>>>
> >>>>> This issue is fixed in newer firmware, but as OEMs may not roll
> >>>>> this out to the field, introduce a workaround that will retry the
> >>>>> flush when detecting running on an older firmware and decrease
> >>>>> relevant error messages to debug while workaround is in use.
> >>>>>
> >>>>> Cc: stable@vger.kernel.org # 6.1+
> >>>>> Cc: Tim Huang <Tim.Huang@amd.com>
> >>>>> Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/3045
> >>>>> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> >>>>> ---
> >>>>>    drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c | 10 ++++++++--
> >>>>>    drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h |  2 ++
> >>>>>    drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c  | 17 ++++++++++++++++-
> >>>>>    drivers/gpu/drm/amd/amdgpu/mes_v11_0.c  |  8 ++++++--
> >>>>>    4 files changed, 32 insertions(+), 5 deletions(-)
> >>>>>
> >>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
> >>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
> >>>>> index 9ddbf1494326..6ce3f6e6b6de 100644
> >>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
> >>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
> >>>>> @@ -836,8 +836,14 @@ int amdgpu_mes_reg_write_reg_wait(struct
> >>>>> amdgpu_device *adev,
> >>>>>           }
> >>>>>
> >>>>>           r =3D adev->mes.funcs->misc_op(&adev->mes, &op_input);
> >>>>> -       if (r)
> >>>>> -               DRM_ERROR("failed to reg_write_reg_wait\n");
> >>>>> +       if (r) {
> >>>>> +               const char *msg =3D "failed to
> >>>>> + reg_write_reg_wait\n";
> >>>>> +
> >>>>> +               if (adev->mes.suspend_workaround)
> >>>>> +                       DRM_DEBUG(msg);
> >>>>> +               else
> >>>>> +                       DRM_ERROR(msg);
> >>>>> +       }
> >>>>>
> >>>>>    error:
> >>>>>           return r;
> >>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
> >>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
> >>>>> index a27b424ffe00..90f2bba3b12b 100644
> >>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
> >>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
> >>>>> @@ -135,6 +135,8 @@ struct amdgpu_mes {
> >>>>>
> >>>>>           /* ip specific functions */
> >>>>>           const struct amdgpu_mes_funcs   *funcs;
> >>>>> +
> >>>>> +       bool                            suspend_workaround;
> >>>>>    };
> >>>>>
> >>>>>    struct amdgpu_mes_process {
> >>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
> >>>>> b/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
> >>>>> index 23d7b548d13f..e810c7bb3156 100644
> >>>>> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
> >>>>> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
> >>>>> @@ -889,7 +889,11 @@ static int gmc_v11_0_gart_enable(struct
> >>>>> amdgpu_device *adev)
> >>>>>                   false : true;
> >>>>>
> >>>>>           adev->mmhub.funcs->set_fault_enable_default(adev, value);
> >>>>> -       gmc_v11_0_flush_gpu_tlb(adev, 0, AMDGPU_MMHUB0(0), 0);
> >>>>> +
> >>>>> +       do {
> >>>>> +               gmc_v11_0_flush_gpu_tlb(adev, 0, AMDGPU_MMHUB0(0), =
0);
> >>>>> +               adev->mes.suspend_workaround =3D false;
> >>>>> +       } while (adev->mes.suspend_workaround);
> >>>> Shouldn't this be something like:
> >>>>
> >>>>> +       do {
> >>>>> +               gmc_v11_0_flush_gpu_tlb(adev, 0, AMDGPU_MMHUB0(0), =
0);
> >>>>> +               adev->mes.suspend_workaround =3D false;
> >>>>> +               gmc_v11_0_flush_gpu_tlb(adev, 0, AMDGPU_MMHUB0(0), =
0);
> >>>>> +       } while (adev->mes.suspend_workaround);
> >>>> If we actually need the flush.  Maybe a better approach would be to
> >>>> check if we are in s0ix in
> >>> Ah you're right; I had shifted this around to keep less stateful
> >>> variables and push them up the stack from when I first made it and
> >>> that logic is wrong now.
> >>>
> >>> I don't think the one you suggested is right either; it's going to
> >>> apply twice on ASICs that only need it once.
> >>>
> >>> I guess pending on what Christian comments on below I'll respin to
> >>> logic that only calls twice on resume for these ASICs.
> >> One more comment.  Tim and I both did an experiment for this
> >> (skipping the flush) separately.  The problem isn't the flush itself,
> >> rather it's the first MES packet after exiting GFXOFF.
>
> Well that's an ugly one. Can that happen every time GFXOFF kicks in?
>
> >>
> >> So it seems that it pushes off the issue to the next thing which is a
> >> ring buffer test:
> >>
> >> [drm:amdgpu_ib_ring_tests [amdgpu]] *ERROR* IB test failed on
> >> comp_1.0.0 (-110).
> >> [drm:process_one_work] *ERROR* ib ring test failed (-110).
> >>
> >> So maybe a better workaround is a "dummy" command that is only sent
> >> for the broken firmware that we don't care about the outcome and disca=
rd errors.
> >>
> >> Then the workaround doesn't need to get as entangled with correct flow=
.
> > Yeah. Something like that seems cleaner.  Just a question of where to
> > put it since we skip GC and MES for s0ix.  Probably somewhere in
> > gmc_v11_0_resume() before gmc_v11_0_gart_enable().  Maybe add a new
> > mes callback.
>
> Please try to keep it completely outside of the TLB invalidation and VM f=
lush handling.
>
> Regards,
> Christian.
>
> >
> > Alex
> >
> >>>> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
> >>>> b/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c in gmc_v11_0_flush_gpu_tlb(=
):
> >>>> index 23d7b548d13f..bd6d9953a80e 100644
> >>>> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
> >>>> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
> >>>> @@ -227,7 +227,8 @@ static void gmc_v11_0_flush_gpu_tlb(struct
> >>>> amdgpu_device *adev, uint32_t vmid,
> >>>>            * Directly use kiq to do the vm invalidation instead
> >>>>            */
> >>>>           if ((adev->gfx.kiq[0].ring.sched.ready ||
> >>>> adev->mes.ring.sched.ready) &&
> >>>> -           (amdgpu_sriov_runtime(adev) || !amdgpu_sriov_vf(adev))) =
{
> >>>> +           (amdgpu_sriov_runtime(adev) || !amdgpu_sriov_vf(adev)) |=
|
> >>>> +           !adev->in_s0ix) {
> >>>>                   amdgpu_virt_kiq_reg_write_reg_wait(adev, req,
> >>>> ack, inv_req,
> >>>>                                   1 << vmid, GET_INST(GC, 0));
> >>>>                   return;
> >>>>
> >>>> @Christian Koenig is this logic correct?
> >>>>
> >>>>           /* For SRIOV run time, driver shouldn't access the
> >>>> register through MMIO
> >>>>            * Directly use kiq to do the vm invalidation instead
> >>>>            */
> >>>>           if ((adev->gfx.kiq[0].ring.sched.ready ||
> >>>> adev->mes.ring.sched.ready) &&
> >>>>               (amdgpu_sriov_runtime(adev) || !amdgpu_sriov_vf(adev))=
) {
> >>>>                   amdgpu_virt_kiq_reg_write_reg_wait(adev, req,
> >>>> ack, inv_req,
> >>>>                                   1 << vmid, GET_INST(GC, 0));
> >>>>                   return;
> >>>>           }
> >>>>
> >>>> We basically always use the MES with that logic.  If that is the
> >>>> case, we should just drop the rest of that function.  Shouldn't we
> >>>> only use KIQ or MES for SR-IOV?  gmc v10 has similar logic which
> >>>> also seems wrong.
> >>>>
> >>>> Alex
> >>>>
> >>>>
> >>>>>           DRM_INFO("PCIE GART of %uM enabled (table at 0x%016llX).\=
n",
> >>>>>                    (unsigned int)(adev->gmc.gart_size >> 20), @@
> >>>>> -960,6 +964,17 @@ static int gmc_v11_0_resume(void *handle)
> >>>>>           int r;
> >>>>>           struct amdgpu_device *adev =3D (struct amdgpu_device
> >>>>> *)handle;
> >>>>>
> >>>>> +       switch (amdgpu_ip_version(adev, MP1_HWIP, 0)) {
> >>>>> +       case IP_VERSION(13, 0, 4):
> >>>>> +       case IP_VERSION(13, 0, 11):
> >>>>> +               /* avoid problems with first TLB flush after resume=
 */
> >>>>> +               if ((adev->pm.fw_version & 0x00FFFFFF) < 0x004c4900=
)
> >>>>> +                       adev->mes.suspend_workaround =3D adev->in_s=
0ix;
> >>>>> +               break;
> >>>>> +       default:
> >>>>> +               break;
> >>>>> +       }
> >>>>> +
> >>>>>           r =3D gmc_v11_0_hw_init(adev);
> >>>>>           if (r)
> >>>>>                   return r;
> >>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
> >>>>> b/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
> >>>>> index 4dfec56e1b7f..84ab8c611e5e 100644
> >>>>> --- a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
> >>>>> +++ b/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
> >>>>> @@ -137,8 +137,12 @@ static int
> >>>>> mes_v11_0_submit_pkt_and_poll_completion(struct amdgpu_mes *mes,
> >>>>>           r =3D amdgpu_fence_wait_polling(ring, ring->fence_drv.syn=
c_seq,
> >>>>>                         timeout);
> >>>>>           if (r < 1) {
> >>>>> -               DRM_ERROR("MES failed to response msg=3D%d\n",
> >>>>> -                         x_pkt->header.opcode);
> >>>>> +               if (mes->suspend_workaround)
> >>>>> +                       DRM_DEBUG("MES failed to response msg=3D%d\=
n",
> >>>>> +                                 x_pkt->header.opcode);
> >>>>> +               else
> >>>>> +                       DRM_ERROR("MES failed to response msg=3D%d\=
n",
> >>>>> +                                 x_pkt->header.opcode);
> >>>>>
> >>>>>                   while (halt_if_hws_hang)
> >>>>>                           schedule();
> >>>>> --
> >>>>> 2.34.1
> >>>>>
>
