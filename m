Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8F87C5DF7D
	for <amd-gfx@archiver.kernel.org>; Tue, 18 Aug 2026 17:35:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2E9E710E4D8;
	Tue, 18 Aug 2026 17:35:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="DiXXB7V2";
	dkim-atps=neutral
Received: from mail-ua1-f49.google.com (mail-ua1-f49.google.com
 [209.85.222.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 23D2510E4D8
 for <amd-gfx@lists.freedesktop.org>; Tue, 18 Aug 2026 17:35:08 +0000 (UTC)
Received: by mail-ua1-f49.google.com with SMTP id
 a1e0cc1a2514c-9775d28882fso1228241.3
 for <amd-gfx@lists.freedesktop.org>; Tue, 18 Aug 2026 10:35:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787074507; cv=none;
 d=google.com; s=arc-20260327;
 b=WEKkM2CqqsLwLIPEcG/PDTdRFRYdd4r/wt5i6I/swErtz7BbKMCFnsHw+FCYSIh6JB
 4ZiPBE315rvG++bvFEmk/jfKwqIjYLQzggSR+0JxOLFc+o/eYJXEYiaAbpsPRQonwAda
 Ucel2Z1SUSPMAdv2t9ejS+Jdc2DkVmpAXgYeovTpkewNJXf60NG2ZII6kWnkVV4IsPlB
 YYx+2MZyZo3oAvmkar3A2o3EFYdm5i1jm+k3vsOaC4Nz/tLWxU2HYZkF2CJR0BD5Czy4
 v+mmBDHz1XtV+eiLOBol+Io7wk90sqxYNj4ecZ9zuaBab6NZJjvufT6atjehOzxt7/3M
 rGvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=BpAyR+Upi7Y/iTOM659JXGacw6QKg+/Z6iMnamiB9I8=;
 fh=5wq0zLOHuoyDJ4DNKYu3jQc5d0k3sAyp/mDiq/ph9c4=;
 b=D3oujXHyntcdy9VTcIH9TC+2Arw5A+1sVvXS8jjISIi/hFEYzzFYh9+XK/tyAS2L6/
 BBB2Z5/fI4nW0lUVP7kuLN86tSM9iwb3CdhdJ+3wXQ6H5pG+PhBnd40itdg3zh0rlxDH
 xyowz+gpt7aSCicbK0Ti2u5AuiQH1aX9VZCRMzRytwb00r0SGd1BYPIRUQwA2UVfk+rl
 bKbLUdNVHhzkBZYp8etBAqabeUbfErtFkg5qtbz5UhK8Tk4MhaaqCYcWzVVVDnHaqshU
 mHRWcnPcZ6kSGRxCaVDsHFPhJq0j3gi3r6sRyq71voWaRwkYvXRJGzwimV4n35COAISv
 b7jQ==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787074507; x=1787679307; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=BpAyR+Upi7Y/iTOM659JXGacw6QKg+/Z6iMnamiB9I8=;
 b=DiXXB7V2pb4VD527srJYvj+VD+X151KjTi/Ux9RBWpa0pHaDB9ItQGFXVY3ZCs0QXH
 xumxFAbLJ39RuBvXXuO4qqO/L7pIJSfcwfhaN/mOTzsH+4Uj0HpSo5e3BlUFs7y8z0YQ
 QljehDrdJZGcfY0hlDdSKqK4kgl8mf/WtB8EjCB0D8mNBSffW0YR3txmxB+KXgDnz7ZG
 8IbnPo1UQLoqYhQeCpnjstacj2j1/ahFPNrP7caPfR5SwO9r26AqI8FivMy6nD5ptpbF
 vsGqjpyhBIp7AQovf6oddNXlAAXkls29iABsxbv4IIDhvv46xYIiWmlWA8wLu0swHm6h
 MjOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787074507; x=1787679307;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=BpAyR+Upi7Y/iTOM659JXGacw6QKg+/Z6iMnamiB9I8=;
 b=DlKw0xAXf71by2Li0xbJ+nD6hgGEhub+c/1UgyCImwyfBfmGqUfgXiAyfG3x5y55ic
 Nn9Yr9EwoL7tt68HagMxAn6o3pulwYti1LFlhCtqKm4eEF8PuzDEnpe+U1M+vRZTQ+0M
 FbRx0JT0+M4NGARnTslbl1/QCl0FRXHCIR1yA6CGptRB05qp8xryeBksCZgnrAzg1NN6
 DilL2wK+Nqagmw5o3E4kBE2e3UPJfHdRS4rrEKRhf759NtwSwm/kZXHp3kxBaMyFm8dN
 U0mS3OK1I2fambCbVG8/3yqUanGsuAHekpEW6N07DOBHjMS6EQyAZvJHys32dwzvgguH
 FNxQ==
X-Gm-Message-State: AOJu0Yw0wrMnQOKPIHTdMNjog3d7+MkjpOD8mACMp3k1GxHjkhKxKilJ
 PsVb3W9mXtolbn8WLBJpV1QzblM09WsuDAmcoLsSkF/YSffL8YQxWmzP8v/aTL6sTWOeXcsHVsz
 3/AfmoXphVV5pbqLiiNT4Qg00WBT4r8g=
X-Gm-Gg: AR+sD11R/8g2qfVdvzqGNxnm0K+qDMWFjuNVU2jlQRAwP5HpiHNHZ3rJa+tF8o86nLL
 WEAtPYfUN0EZ+PnmVFp8yZf8AkdezQkSQG0eMW4nRUB8CJYamZqJXDGHtBMvEwxzCNnuAkDZ51v
 C9ZNLj74Gmsm9PhtQ66pFfCyU/l4ArrUYdvXBZoa01haWalLRmRzf0OZRZT9YL3EcSBO2AbmIrJ
 XgzJASefFaHVVM0vnjYPeZTpfhHxFm85Z9g3zSOq7Rs3Ye0bQgtgEUTScmzMhdynR0Brg2kPOs/
 wZh0RqadBhPyV3HMitgD8DlXpIxTheq60kfHwdb5EVy1Eg+cULE529da9skvxRmzdZ1uDGpzh3q
 kJNGDupWzFs35cbndh7O/k+CvvpIqafnwzTqo6/Y+VQ==
X-Received: by 2002:a05:6102:5091:b0:72f:6669:286a with SMTP id
 ada2fe7eead31-76f2c540eb2mr2920748137.2.1787074506520; Tue, 18 Aug 2026
 10:35:06 -0700 (PDT)
MIME-Version: 1.0
References: <20260817194953.97887-1-david.belanger@amd.com>
 <CADnq5_NdV+ZX-gTS-fL8rSRX3AQAc1LRU-mS9nTUG3vPGuu1WQ@mail.gmail.com>
 <58a506b4-291d-4e69-9ddb-931e51ecb4ba@amd.com>
In-Reply-To: <58a506b4-291d-4e69-9ddb-931e51ecb4ba@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 18 Aug 2026 13:34:53 -0400
X-Gm-Features: AcwNN1XYdgFPmN59a5fUvLoBiwi7gfjtby0gx1hLL_YbEFwsqmv4buWNju8hcbU
Message-ID: <CADnq5_O-pUVK4VMHgo6Q9pfac7y2-_qhJ3C1WyBr1zN0Nf=1TQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] drm/kfd: Add CU occupancy support to GFX11
To: "Belanger, David" <david.belanger@amd.com>
Cc: amd-gfx@lists.freedesktop.org
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

On Tue, Aug 18, 2026 at 1:19=E2=80=AFPM Belanger, David <david.belanger@amd=
.com> wrote:
>
>
>
> On 8/17/2026 11:37 PM, Alex Deucher wrote:
> > On Mon, Aug 17, 2026 at 4:45=E2=80=AFPM David Belanger <david.belanger@=
amd.com> wrote:
> >>
> >> Port changes from GFX9 to GFX11 mostly as-is.
> >> Minor changes to register access code.
> >
> > While you are at it, can you port this to gfx10 10 and 10.3 as well?
> >
>
> Yes, I can.  I am working on the changes for GFX10/10.3.
> They will be submitted as a separate patch.

Thanks!

>
>
> >>
> >> Assisted-by: Claude:Sonnet 4.6
> >> Signed-off-by: David Belanger <david.belanger@amd.com>
> >> ---
> >>  .../drm/amd/amdgpu/amdgpu_amdkfd_gfx_v11.c    | 148 +++++++++++++++++=
+
> >>  1 file changed, 148 insertions(+)
> >>
> >> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v11.c b/driv=
ers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v11.c
> >> index 724beb96ed1aa..46042f72741b4 100644
> >> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v11.c
> >> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v11.c
> >> @@ -807,6 +807,153 @@ static uint32_t kgd_gfx_v11_hqd_sdma_get_doorbel=
l(struct amdgpu_device *adev,
> >>         return 0;
> >>  }
> >>
> >> +static void lock_spi_csq_mutexes(struct amdgpu_device *adev)
> >> +{
> >> +       mutex_lock(&adev->srbm_mutex);
> >> +       mutex_lock(&adev->grbm_idx_mutex);
> >> +
> >> +}
> >> +
> >> +static void unlock_spi_csq_mutexes(struct amdgpu_device *adev)
> >> +{
> >> +       mutex_unlock(&adev->grbm_idx_mutex);
> >> +       mutex_unlock(&adev->srbm_mutex);
> >> +}
> >> +
> >> +/**
> >> + * get_wave_count: Read device registers to get number of waves in fl=
ight for
> >> + * a particular queue. The method also returns the doorbell offset as=
sociated
> >> + * with the queue.
> >> + *
> >> + * @adev: Handle of device whose registers are to be read
> >> + * @queue_idx: Index of queue in the queue-map bit-field
> >> + * @queue_cnt: Stores the wave count and doorbell offset for an activ=
e queue
> >> + * @inst: xcc's instance number on a multi-XCC setup
> >> + */
> >> +static void get_wave_count(struct amdgpu_device *adev, int queue_idx,
> >> +               struct kfd_cu_occupancy *queue_cnt, uint32_t inst)
> >> +{
> >> +       int pipe_idx;
> >> +       int queue_slot;
> >> +       unsigned int reg_val;
> >> +       unsigned int wave_cnt;
> >> +       /*
> >> +        * Program GRBM with appropriate MEID, PIPEID, QUEUEID and VMI=
D
> >> +        * parameters to read out waves in flight. Get VMID if there a=
re
> >> +        * non-zero waves in flight.
> >> +        */
> >> +       pipe_idx =3D queue_idx / adev->gfx.mec.num_queue_per_pipe;
> >> +       queue_slot =3D queue_idx % adev->gfx.mec.num_queue_per_pipe;
> >> +       soc21_grbm_select(adev, 1, pipe_idx, queue_slot, 0);
> >> +       reg_val =3D RREG32_SOC15_IP(GC, SOC15_REG_OFFSET(GC, 0,
> >> +                                 regSPI_CSQ_WF_ACTIVE_COUNT_0) + queu=
e_slot);
> >> +       wave_cnt =3D reg_val & SPI_CSQ_WF_ACTIVE_COUNT_0__COUNT_MASK;
> >> +       if (wave_cnt !=3D 0) {
> >> +               queue_cnt->wave_cnt +=3D wave_cnt;
> >> +               queue_cnt->doorbell_off =3D
> >> +                       (RREG32_SOC15(GC, 0, regCP_HQD_PQ_DOORBELL_CON=
TROL) &
> >> +                        CP_HQD_PQ_DOORBELL_CONTROL__DOORBELL_OFFSET_M=
ASK) >>
> >> +                        CP_HQD_PQ_DOORBELL_CONTROL__DOORBELL_OFFSET__=
SHIFT;
> >> +       }
> >> +}
> >> +
> >> +/**
> >> + * kgd_gfx_v11_get_cu_occupancy: Reads relevant registers associated =
with each
> >> + * shader engine and aggregates the number of waves that are in fligh=
t for the
> >> + * process whose pasid is provided as a parameter. The process could =
have ZERO
> >> + * or more queues running and submitting waves to compute units.
> >> + *
> >> + * @adev: Handle of device from which to get number of waves in fligh=
t
> >> + * @cu_occupancy: Array that gets filled with wave_cnt and doorbell o=
ffset
> >> + *               for comparison later.
> >> + * @max_waves_per_cu: Output parameter updated with maximum number of=
 waves
> >> + *                    possible per Compute Unit
> >> + * @inst: xcc's instance number on a multi-XCC setup
> >> + *
> >> + * Note: It's possible that the device has too many queues (oversubsc=
ription)
> >> + * in which case a VMID could be remapped to a different PASID. This =
could lead
> >> + * to an inaccurate wave count. Following is a high-level sequence:
> >> + *    Time T1: vmid =3D getVmid(); vmid is associated with Pasid P1
> >> + *    Time T2: passId =3D getPasId(vmid); vmid is associated with Pas=
id P2
> >> + * In the sequence above wave count obtained from time T1 will be inc=
orrectly
> >> + * lost or added to total wave count.
> >> + *
> >> + * The registers that provide the waves in flight are:
> >> + *
> >> + *  SPI_CSQ_WF_ACTIVE_STATUS - bit-map of queues per pipe. The bit is=
 ON if a
> >> + *  queue is slotted, OFF if there is no queue. A process could have =
ZERO or
> >> + *  more queues slotted and submitting waves to be run on compute uni=
ts. Even
> >> + *  when there is a queue it is possible there could be zero wave fro=
nts, this
> >> + *  can happen when queue is waiting on top-of-pipe events - e.g. wai=
tRegMem
> >> + *  command
> >> + *
> >> + *  For each bit that is ON from above:
> >> + *
> >> + *    Read (SPI_CSQ_WF_ACTIVE_COUNT_0 + queue_idx) register. It provi=
des the
> >> + *    number of waves that are in flight for the queue at specified i=
ndex. The
> >> + *    index ranges from 0 to 7.
> >> + *
> >> + *    If non-zero waves are in flight, store the corresponding doorbe=
ll offset
> >> + *    of the queue, along with the wave count.
> >> + *
> >> + *    Determine if the queue belongs to the process by comparing the =
doorbell
> >> + *    offset against the process's queues. If it matches, aggregate t=
he wave
> >> + *    count for the process.
> >> + *
> >> + *  Reading registers referenced above involves programming GRBM appr=
opriately
> >> + */
> >> +static void kgd_gfx_v11_get_cu_occupancy(struct amdgpu_device *adev,
> >> +                               struct kfd_cu_occupancy *cu_occupancy,
> >> +                               int *max_waves_per_cu, uint32_t inst)
> >> +{
> >> +       int qidx;
> >> +       int se_idx;
> >> +       int se_cnt;
> >> +       int queue_map;
> >> +       int max_queue_cnt;
> >> +       DECLARE_BITMAP(cp_queue_bitmap, AMDGPU_MAX_QUEUES);
> >> +
> >> +       lock_spi_csq_mutexes(adev);
> >> +       soc21_grbm_select(adev, 1, 0, 0, 0);
> >> +
> >> +       /*
> >> +        * Iterate through the shader engines and arrays of the device
> >> +        * to get number of waves in flight
> >> +        */
> >> +       bitmap_complement(cp_queue_bitmap, adev->gfx.mec_bitmap[0].que=
ue_bitmap,
> >> +                         AMDGPU_MAX_QUEUES);
> >> +       max_queue_cnt =3D adev->gfx.mec.num_pipe_per_mec *
> >> +                       adev->gfx.mec.num_queue_per_pipe;
> >> +       se_cnt =3D adev->gfx.config.max_shader_engines;
> >> +       for (se_idx =3D 0; se_idx < se_cnt; se_idx++) {
> >> +               amdgpu_gfx_select_se_sh(adev, se_idx, 0, 0xffffffff, i=
nst);
> >> +               queue_map =3D RREG32_SOC15(GC, 0,
> >> +                                        regSPI_CSQ_WF_ACTIVE_STATUS);
> >> +
> >> +               for (qidx =3D 0; qidx < max_queue_cnt; qidx++) {
> >> +                       /* Skip queues that are not associated with
> >> +                        * compute functions
> >> +                        */
> >> +                       if (!test_bit(qidx, cp_queue_bitmap))
> >> +                               continue;
> >> +
> >> +                       if (!(queue_map & (1 << qidx)))
> >> +                               continue;
> >> +
> >> +                       /* Get number of waves in flight and aggregate=
 them */
> >> +                       get_wave_count(adev, qidx, &cu_occupancy[qidx]=
, inst);
> >> +               }
> >> +       }
> >> +
> >> +       amdgpu_gfx_select_se_sh(adev, 0xffffffff, 0xffffffff, 0xffffff=
ff, inst);
> >> +       soc21_grbm_select(adev, 0, 0, 0, 0);
> >> +       unlock_spi_csq_mutexes(adev);
> >> +
> >
> > I think you need to disallow gfxoff around the MMIO accesses unless
> > that is already handled elsewhere.  Same comment on the gfx12
> > implementation.
>
> I am looking into it further.
>
> AI suggestion is to wrap it in kfd_process.c before calling the hardware =
specific function:
>
> amdgpu_gfx_off_ctrl(dev->adev, false);
> dev->kfd2kgd->get_cu_occupancy(...);
> amdgpu_gfx_off_ctrl(dev->adev, true);
>
> If it makes sense, I could submit that as a separate patch (as common to =
all implementation, including the original gfx9 implemenation).
>

Sounds good.  Would probably be good to double check all of the paths
that call these function pointers which use MMIO.

This series is:
Acked-by: Alex Deucher <alexander.deucher@amd.com>

Thanks,

Alex

> >
> > Alex
> >
> >> +       /* Update the output parameters and return */
> >> +       *max_waves_per_cu =3D adev->gfx.cu_info.simd_per_cu *
> >> +                               adev->gfx.cu_info.max_waves_per_simd;
> >> +}
> >> +
> >>  const struct kfd2kgd_calls gfx_v11_kfd2kgd =3D {
> >>         .program_sh_mem_settings =3D program_sh_mem_settings_v11,
> >>         .set_pasid_vmid_mapping =3D set_pasid_vmid_mapping_v11,
> >> @@ -832,5 +979,6 @@ const struct kfd2kgd_calls gfx_v11_kfd2kgd =3D {
> >>         .clear_address_watch =3D kgd_gfx_v11_clear_address_watch,
> >>         .hqd_get_pq_addr =3D kgd_gfx_v11_hqd_get_pq_addr,
> >>         .hqd_reset =3D kgd_gfx_v11_hqd_reset,
> >> +       .get_cu_occupancy =3D kgd_gfx_v11_get_cu_occupancy,
> >>         .hqd_sdma_get_doorbell =3D kgd_gfx_v11_hqd_sdma_get_doorbell
> >>  };
> >> --
> >> 2.51.1
> >>
>
