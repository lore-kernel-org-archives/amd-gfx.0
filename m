Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E07FC4332F
	for <amd-gfx@archiver.kernel.org>; Wed, 13 Dec 2023 19:44:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B4B9610E7EE;
	Wed, 13 Dec 2023 19:44:56 +0000 (UTC)
Received: from mail-oa1-x2c.google.com (mail-oa1-x2c.google.com
 [IPv6:2001:4860:4864:20::2c])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4BFB110E7EE
 for <amd-gfx@lists.freedesktop.org>; Wed, 13 Dec 2023 19:44:55 +0000 (UTC)
Received: by mail-oa1-x2c.google.com with SMTP id
 586e51a60fabf-203198c9aa5so1039377fac.2
 for <amd-gfx@lists.freedesktop.org>; Wed, 13 Dec 2023 11:44:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1702496694; x=1703101494; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Jxz50Q9h5N8BuDMjDAXa/uil5mwnNC0OLP+UwU3EH78=;
 b=BZ5WOZT6t9fXxsTkzcL5Nd5e4dzrpuyZbz3DkfTsQ/mduAhguHRG1fKe+0NhYvVXTb
 40usV2KzPLQT60lSImosAfz3p4kNeMR8EdIz3TQd3lt6bITlod7cyQwxBu9+w4bzRa41
 MVkc3tlb3GdqbLpPYPl0mcQaaVRFclOU3BKyXlfNe4Kx+iEn9tJH//eC9JvW0cq6/CQ/
 T0aVoNUJTxJLJvb29RN43gKLtrRMdxmDLpKE55fAhLtq92O/fDJVNViBxBEJd02NH+Ng
 wardALFVGuKGfm+dto3FTu3a1vHnQjSaXqiOXntCqAdJe6k+e4y4JpORONuh4+PGBuiW
 +v8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702496694; x=1703101494;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Jxz50Q9h5N8BuDMjDAXa/uil5mwnNC0OLP+UwU3EH78=;
 b=f1Q0A6ns98LUzwAMLVkfh+lijOWXOStP93YIZXJAuFSMqCpSez+JWikQvZWJ4FJLfF
 bUZnGSFB5lMsC4QoZjv+gHqM+p0aUCP79j5G2+BGM2Y8iNPF2gMrHMX2/V6eUPuzuH1Z
 9G5DXcX2oMA8SeSdbTEteIm+3xoscAltMAtugZTW/llO+nuCz/dRJqle4tfBLFslG0BE
 F/FWGrvBwrVJsiJL4ftND1D3e89rK0gFvkXs12f/MgaIu6NRaPbVbAKlRCy8CDjqGa3c
 qTrTR9XG4IIfcx8E612puhUdw9sIFSfgskyFVzNljNm+iGF+D4wuOp1qXWNkcrAe53hs
 M1xw==
X-Gm-Message-State: AOJu0YwhsVBZLonHIed6gKBecswRWeKoWS4+oB4Hk08xfmjVTfP6TeN0
 OohaniUrlwQz5MTE7rnsorIp4Sq1Pm2A4ZJNNhE=
X-Google-Smtp-Source: AGHT+IFQ/IvfYvlggwT+lZ+IVE+tsFV5zNzne40K9JXV+ZmVEN1cRMMvqmS7G66NGtrnf5xewXXT/qDGfpcGFBy1hdg=
X-Received: by 2002:a05:6871:146:b0:1fb:1373:c889 with SMTP id
 z6-20020a056871014600b001fb1373c889mr10223753oab.102.1702496694160; Wed, 13
 Dec 2023 11:44:54 -0800 (PST)
MIME-Version: 1.0
References: <20231213170454.5962-1-mario.limonciello@amd.com>
 <CADnq5_O=Kp+TkSEHXxSPEtWEYknFL_e_D7m5nXN=y8CJrR950g@mail.gmail.com>
 <38da4566-d936-42d9-9879-eee993270da0@amd.com>
 <13694238-418a-4fcb-8921-f9ab31e08120@amd.com>
In-Reply-To: <13694238-418a-4fcb-8921-f9ab31e08120@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 13 Dec 2023 14:44:42 -0500
Message-ID: <CADnq5_MkkWqLyC3VYbTXSX7JL2Q5aaeJ6sFT9ROXjqdVfsXgjw@mail.gmail.com>
Subject: Re: [PATCH] drm/amd: Add a workaround for GFX11 systems that fail to
 flush TLB
To: Mario Limonciello <mario.limonciello@amd.com>
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
Cc: Tim Huang <Tim.Huang@amd.com>, stable@vger.kernel.org,
 Christian Koenig <christian.koenig@amd.com>, amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Wed, Dec 13, 2023 at 2:32=E2=80=AFPM Mario Limonciello
<mario.limonciello@amd.com> wrote:
>
> On 12/13/2023 13:12, Mario Limonciello wrote:
> > On 12/13/2023 13:07, Alex Deucher wrote:
> >> On Wed, Dec 13, 2023 at 1:00=E2=80=AFPM Mario Limonciello
> >> <mario.limonciello@amd.com> wrote:
> >>>
> >>> Some systems with MP1 13.0.4 or 13.0.11 have a firmware bug that
> >>> causes the first MES packet after resume to fail. This packet is
> >>> used to flush the TLB when GART is enabled.
> >>>
> >>> This issue is fixed in newer firmware, but as OEMs may not roll this
> >>> out to the field, introduce a workaround that will retry the flush
> >>> when detecting running on an older firmware and decrease relevant
> >>> error messages to debug while workaround is in use.
> >>>
> >>> Cc: stable@vger.kernel.org # 6.1+
> >>> Cc: Tim Huang <Tim.Huang@amd.com>
> >>> Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/3045
> >>> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> >>> ---
> >>>   drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c | 10 ++++++++--
> >>>   drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h |  2 ++
> >>>   drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c  | 17 ++++++++++++++++-
> >>>   drivers/gpu/drm/amd/amdgpu/mes_v11_0.c  |  8 ++++++--
> >>>   4 files changed, 32 insertions(+), 5 deletions(-)
> >>>
> >>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
> >>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
> >>> index 9ddbf1494326..6ce3f6e6b6de 100644
> >>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
> >>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
> >>> @@ -836,8 +836,14 @@ int amdgpu_mes_reg_write_reg_wait(struct
> >>> amdgpu_device *adev,
> >>>          }
> >>>
> >>>          r =3D adev->mes.funcs->misc_op(&adev->mes, &op_input);
> >>> -       if (r)
> >>> -               DRM_ERROR("failed to reg_write_reg_wait\n");
> >>> +       if (r) {
> >>> +               const char *msg =3D "failed to reg_write_reg_wait\n";
> >>> +
> >>> +               if (adev->mes.suspend_workaround)
> >>> +                       DRM_DEBUG(msg);
> >>> +               else
> >>> +                       DRM_ERROR(msg);
> >>> +       }
> >>>
> >>>   error:
> >>>          return r;
> >>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
> >>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
> >>> index a27b424ffe00..90f2bba3b12b 100644
> >>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
> >>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
> >>> @@ -135,6 +135,8 @@ struct amdgpu_mes {
> >>>
> >>>          /* ip specific functions */
> >>>          const struct amdgpu_mes_funcs   *funcs;
> >>> +
> >>> +       bool                            suspend_workaround;
> >>>   };
> >>>
> >>>   struct amdgpu_mes_process {
> >>> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
> >>> b/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
> >>> index 23d7b548d13f..e810c7bb3156 100644
> >>> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
> >>> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
> >>> @@ -889,7 +889,11 @@ static int gmc_v11_0_gart_enable(struct
> >>> amdgpu_device *adev)
> >>>                  false : true;
> >>>
> >>>          adev->mmhub.funcs->set_fault_enable_default(adev, value);
> >>> -       gmc_v11_0_flush_gpu_tlb(adev, 0, AMDGPU_MMHUB0(0), 0);
> >>> +
> >>> +       do {
> >>> +               gmc_v11_0_flush_gpu_tlb(adev, 0, AMDGPU_MMHUB0(0), 0)=
;
> >>> +               adev->mes.suspend_workaround =3D false;
> >>> +       } while (adev->mes.suspend_workaround);
> >>
> >> Shouldn't this be something like:
> >>
> >>> +       do {
> >>> +               gmc_v11_0_flush_gpu_tlb(adev, 0, AMDGPU_MMHUB0(0), 0)=
;
> >>> +               adev->mes.suspend_workaround =3D false;
> >>> +               gmc_v11_0_flush_gpu_tlb(adev, 0, AMDGPU_MMHUB0(0), 0)=
;
> >>> +       } while (adev->mes.suspend_workaround);
> >>
> >> If we actually need the flush.  Maybe a better approach would be to
> >> check if we are in s0ix in
> >
> > Ah you're right; I had shifted this around to keep less stateful
> > variables and push them up the stack from when I first made it and that
> > logic is wrong now.
> >
> > I don't think the one you suggested is right either; it's going to appl=
y
> > twice on ASICs that only need it once.
> >
> > I guess pending on what Christian comments on below I'll respin to logi=
c
> > that only calls twice on resume for these ASICs.
>
> One more comment.  Tim and I both did an experiment for this (skipping
> the flush) separately.  The problem isn't the flush itself, rather it's
> the first MES packet after exiting GFXOFF.
>
> So it seems that it pushes off the issue to the next thing which is a
> ring buffer test:
>
> [drm:amdgpu_ib_ring_tests [amdgpu]] *ERROR* IB test failed on comp_1.0.0
> (-110).
> [drm:process_one_work] *ERROR* ib ring test failed (-110).
>
> So maybe a better workaround is a "dummy" command that is only sent for
> the broken firmware that we don't care about the outcome and discard erro=
rs.
>
> Then the workaround doesn't need to get as entangled with correct flow.

Yeah. Something like that seems cleaner.  Just a question of where to
put it since we skip GC and MES for s0ix.  Probably somewhere in
gmc_v11_0_resume() before gmc_v11_0_gart_enable().  Maybe add a new
mes callback.

Alex

>
> >
> >>
> >> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
> >> b/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c in gmc_v11_0_flush_gpu_tlb():
> >> index 23d7b548d13f..bd6d9953a80e 100644
> >> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
> >> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
> >> @@ -227,7 +227,8 @@ static void gmc_v11_0_flush_gpu_tlb(struct
> >> amdgpu_device *adev, uint32_t vmid,
> >>           * Directly use kiq to do the vm invalidation instead
> >>           */
> >>          if ((adev->gfx.kiq[0].ring.sched.ready ||
> >> adev->mes.ring.sched.ready) &&
> >> -           (amdgpu_sriov_runtime(adev) || !amdgpu_sriov_vf(adev))) {
> >> +           (amdgpu_sriov_runtime(adev) || !amdgpu_sriov_vf(adev)) ||
> >> +           !adev->in_s0ix) {
> >>                  amdgpu_virt_kiq_reg_write_reg_wait(adev, req, ack,
> >> inv_req,
> >>                                  1 << vmid, GET_INST(GC, 0));
> >>                  return;
> >>
> >> @Christian Koenig is this logic correct?
> >>
> >>          /* For SRIOV run time, driver shouldn't access the register
> >> through MMIO
> >>           * Directly use kiq to do the vm invalidation instead
> >>           */
> >>          if ((adev->gfx.kiq[0].ring.sched.ready ||
> >> adev->mes.ring.sched.ready) &&
> >>              (amdgpu_sriov_runtime(adev) || !amdgpu_sriov_vf(adev))) {
> >>                  amdgpu_virt_kiq_reg_write_reg_wait(adev, req, ack,
> >> inv_req,
> >>                                  1 << vmid, GET_INST(GC, 0));
> >>                  return;
> >>          }
> >>
> >> We basically always use the MES with that logic.  If that is the case,
> >> we should just drop the rest of that function.  Shouldn't we only use
> >> KIQ or MES for SR-IOV?  gmc v10 has similar logic which also seems
> >> wrong.
> >>
> >> Alex
> >>
> >>
> >>>
> >>>          DRM_INFO("PCIE GART of %uM enabled (table at 0x%016llX).\n",
> >>>                   (unsigned int)(adev->gmc.gart_size >> 20),
> >>> @@ -960,6 +964,17 @@ static int gmc_v11_0_resume(void *handle)
> >>>          int r;
> >>>          struct amdgpu_device *adev =3D (struct amdgpu_device *)handl=
e;
> >>>
> >>> +       switch (amdgpu_ip_version(adev, MP1_HWIP, 0)) {
> >>> +       case IP_VERSION(13, 0, 4):
> >>> +       case IP_VERSION(13, 0, 11):
> >>> +               /* avoid problems with first TLB flush after resume *=
/
> >>> +               if ((adev->pm.fw_version & 0x00FFFFFF) < 0x004c4900)
> >>> +                       adev->mes.suspend_workaround =3D adev->in_s0i=
x;
> >>> +               break;
> >>> +       default:
> >>> +               break;
> >>> +       }
> >>> +
> >>>          r =3D gmc_v11_0_hw_init(adev);
> >>>          if (r)
> >>>                  return r;
> >>> diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
> >>> b/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
> >>> index 4dfec56e1b7f..84ab8c611e5e 100644
> >>> --- a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
> >>> +++ b/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
> >>> @@ -137,8 +137,12 @@ static int
> >>> mes_v11_0_submit_pkt_and_poll_completion(struct amdgpu_mes *mes,
> >>>          r =3D amdgpu_fence_wait_polling(ring, ring->fence_drv.sync_s=
eq,
> >>>                        timeout);
> >>>          if (r < 1) {
> >>> -               DRM_ERROR("MES failed to response msg=3D%d\n",
> >>> -                         x_pkt->header.opcode);
> >>> +               if (mes->suspend_workaround)
> >>> +                       DRM_DEBUG("MES failed to response msg=3D%d\n"=
,
> >>> +                                 x_pkt->header.opcode);
> >>> +               else
> >>> +                       DRM_ERROR("MES failed to response msg=3D%d\n"=
,
> >>> +                                 x_pkt->header.opcode);
> >>>
> >>>                  while (halt_if_hws_hang)
> >>>                          schedule();
> >>> --
> >>> 2.34.1
> >>>
> >
>
