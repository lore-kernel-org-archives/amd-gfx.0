Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4DDDBC5CFEB
	for <amd-gfx@archiver.kernel.org>; Thu, 13 Aug 2026 14:01:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AFB1110E4D3;
	Thu, 13 Aug 2026 14:01:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="mfJZrYYe";
	dkim-atps=neutral
Received: from mail-oo1-f41.google.com (mail-oo1-f41.google.com
 [209.85.161.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 51FDD10E4D3
 for <amd-gfx@lists.freedesktop.org>; Thu, 13 Aug 2026 14:01:13 +0000 (UTC)
Received: by mail-oo1-f41.google.com with SMTP id
 006d021491bc7-6acae92f940so59640eaf.0
 for <amd-gfx@lists.freedesktop.org>; Thu, 13 Aug 2026 07:01:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786629672; cv=none;
 d=google.com; s=arc-20260327;
 b=bDdGUyQ5CFP8PU1K5n5ZW868t3zVnWlHdgl+v1JZF0OqdfSeEYasf1NatOxEOgH4dp
 qVagNV5b0Y+t4eGeGbcFEh+LuOyepS1Y11D2bMPr5HXjF+J4UsNQAidBSuQ4PLA95Cwy
 tCaP/jJQ5W9E1ESDgsexyH8d0tIOA8GDzDG4qyLju/+Jfjq2RiSm4CYuTXoYrN2bHNYf
 Ub3Zf/mSsN5CQzZeb6wnjsPjlQgkmXuvdSeOBCVjb/DNOUll87E4vdMiK3n2PzHjpNHK
 Jcp33AqBMwGxhHebT6XFh2F4qcVWDA7wn5nZnipATTDmmQ4QmwfxHkdbMlfNsp/UY3Fc
 ZzRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=M2VE8PESAommvqtLRY4cgUysXKRZIJVzLMt3xVI0now=;
 fh=1aTepEqKTeUWw+k33+ElvUm1SgmSulqdv8cWFPxx2o0=;
 b=h0kDzrgwP1JzR6sy6yckkLZV7/9bIin98ffV+OwSMxMGUZi5Nbz7Ow4u6yAwNyOVIn
 uGBNF7/+FJtQ4mIV7E16hvFymLVd7HoRb0x555lkyIV/z5mSaXBvX6TK0BXomouECaum
 Rw3pPcFiMSqoHy5IRWGYMpOWrCL7goKwJ7TF6AKpY/Q8jC+PEAf0mXP4N3QbQJ4FbFdj
 peVHJR+/PYSSYgc6oDAREYMKn4P5qw2G6KD/dci1KA/ni9YzOeudMpwat6XxogYSbgA5
 EY/Xplbr6O6sfpdLx1DuMCh/TZtLbR6sVExGxqeoLQZQM+fFdoN76x0NZCQnljXNs//y
 2A/A==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1786629672; x=1787234472; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=M2VE8PESAommvqtLRY4cgUysXKRZIJVzLMt3xVI0now=;
 b=mfJZrYYeRzaRj+xgkYCpacTtW34OT69K1Q6t5hPQCTNc2ojfVtOm9rWK0zxJtQnTUM
 3gNbmErLVg/GL7JxNRKZzvbwq1ebmu47Fvg/jnSVQ/pjqV3DGUlBid/73IyDxQ02FZBc
 SkogG+auF1hFApW3k/lbt9gDdH1/teGHFFc/VbrI0V1QTr3Wzl76c7sJFa1q4azEUsI8
 H9+uu/aebPpYUEf3etAah4q2by39WW94SWwrAN5QBzAx8KPE6xpsptiVosSL2ij4kKII
 4/czy36VUxa2C5+lWEAISd+tsD83n7jvn4g/OaiIe/6GgHSJZkvqyjWJCsEiR+rfT/xE
 7nEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786629672; x=1787234472;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=M2VE8PESAommvqtLRY4cgUysXKRZIJVzLMt3xVI0now=;
 b=bkZCXdEX+wj6UKgc5HOMiLjEbYs9O+2HUGUYKNsZf/ILbgZmH1f27tCI9AINNoveiG
 kxEkfh3rVFuJBsNasropfvSOgn1polDpIU6UpxIs1dbrqFStFAfou8FsSd0cXc8uIASP
 IQCQrmsts3DKy/Qw4dzB7SvqOO+hUk1etFfMPtGJks48584/HOMXDDc2BBUsfYs9B+1k
 fIuuoKaeyVRhyaTmiVp23/eNIZiG3XCAWibi+a/3vwJUCFpgVAlynI+/g0KymZoGsRk2
 QOJUKvwbJVC6UL3RQ3Rq6PlwDtNPowhpAWX/1ALcX1His8P2IsxP/RBanEfaFgss2aVM
 UXUA==
X-Forwarded-Encrypted: i=1;
 AHgh+RqWwD3ZrWXJiEkJjZPPFbq+PJ02FRlhbaGCoKNt3hiO2aeJxxlCgND0J7/xxHJ+niWauuD6I9YE@lists.freedesktop.org
X-Gm-Message-State: AOJu0YysGhNXUVQgjF/6nBYb1I/U1TN9Y/PXR+nIj+KEfBw8aH08vFTt
 F/OtSQ5gO4DUhwOVZk+qOnueYaWZa0i9BYHAWo/ZWld07Be0xeGAEbJkjz11BJsD8/nwS0WqWu1
 trt4FpI95y8kcGQ5KRsi45jixYrfJpKY=
X-Gm-Gg: AR+sD111WAS9DYEIM4ZaWw7p/5JIl+sSyEWWgfFGEO7evA73G+AxQ3WKnLPHORvYu4s
 i2eTme+NWPSblSy24HDxBfmnjM/O8ExZAoo80JhvoYT7VazH8frCIOHOsL1rOMUElwvf2Vlu4Yk
 aQVN0KUVYVVoAIT7E+zI3/qL71TwlRom5zaG8xipL0RgGT1nKQTq5Ty/yXE3NZhWiCSfIzfPPT1
 3rVGVRTu27OvnDTX51OV7NAy2n4r3zckcy9xLOIYT1tNlFlv8fOGCPUOT9V0bWnvtzWCBhEf/Zb
 WUrwpxWahiCOm7Vxfk0Ev/FDzwS1Cq/Wbxzc63gtMCygp1BWN3ZDXhwNUXxvoXyGm1i6Iscyv0A
 S4RO8S/0nugJiiqc5u7WS+jpOBvgAL/8=
X-Received: by 2002:a4a:e614:0:b0:6aa:d9c5:a4ad with SMTP id
 006d021491bc7-6b0c6a63287mr934630eaf.3.1786629672102; Thu, 13 Aug 2026
 07:01:12 -0700 (PDT)
MIME-Version: 1.0
References: <20260713182414.630372-1-alexander.deucher@amd.com>
 <20260713182414.630372-3-alexander.deucher@amd.com>
 <1d9cbc80-c227-4b5b-8305-d2038875b559@amd.com>
In-Reply-To: <1d9cbc80-c227-4b5b-8305-d2038875b559@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 13 Aug 2026 10:00:59 -0400
X-Gm-Features: AUfX_mwY8ndS5EHRQtowmSsSTnK8bqy6CKifiJLg7_F75Rx8umuFYC7F5CprpDc
Message-ID: <CADnq5_MsUhkbNBtqZAyoamALBy+M=MCRcJ8zGMM7yEaiGy+q5g@mail.gmail.com>
Subject: Re: [PATCH 3/3] drm/amdgpu: handle GDS and SPM without a VM fence
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
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

On Thu, Aug 13, 2026 at 9:40=E2=80=AFAM Christian K=C3=B6nig
<christian.koenig@amd.com> wrote:
>
> On 7/13/26 20:24, Alex Deucher wrote:
> > If we end up emitting a VM fence keep GDS and SPM
> > associated with that fence.  If not, emit them as
> > part of the IB fence.
>
> I've just stumbled over that this was pushed into amd-staging-drm-next.
>
> As far as I can see the patch doesn't make any sense at all. Why should w=
e do that?

For per queue resets.  The reemit state is tied to the fence.  If we
don't emit the vm fence, and the queue gets reset, we don't reemit the
stuff done in amdgpu_vm_flush() since there is no fence to tie it to.
If there is no vm fence, then we move that state to the ib fence so it
gets properly reemitted.  Patch 1 in this series always emits the vm
fence, but you said that could have performance impacts so this patch
restores that behavior where we can emit the vm_flush state without a
vm fence.

Alex

>
> Regards,
> Christian.
>
> >
> > Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> > ---
> >  drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c | 14 +++++++-
> >  drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c | 47 ++++++++++++++++++--------
> >  drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h |  4 ++-
> >  3 files changed, 48 insertions(+), 17 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_ib.c
> > index f1ed4a436f5b4..d439c68eed9de 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
> > @@ -131,6 +131,8 @@ int amdgpu_ib_schedule(struct amdgpu_ring *ring, un=
signed int num_ibs,
> >       struct amdgpu_fence *af;
> >       struct amdgpu_fence *vm_af;
> >       bool need_ctx_switch;
> > +     bool emit_spm_needed =3D false;
> > +     bool emit_gds_needed =3D false;
> >       struct amdgpu_vm *vm;
> >       uint64_t fence_ctx;
> >       uint32_t status =3D 0, alloc_size;
> > @@ -220,7 +222,8 @@ int amdgpu_ib_schedule(struct amdgpu_ring *ring, un=
signed int num_ibs,
> >               vm_af =3D job->hw_vm_fence;
> >               /* VM sequence */
> >               vm_af->ib_wptr =3D ring->wptr;
> > -             amdgpu_vm_flush(ring, job, need_pipe_sync);
> > +             amdgpu_vm_flush(ring, job, need_pipe_sync, &emit_spm_need=
ed,
> > +                             &emit_gds_needed);
> >               vm_af->ib_dw_size =3D
> >                       amdgpu_ring_get_dw_distance(ring, vm_af->ib_wptr,=
 ring->wptr);
> >       }
> > @@ -232,6 +235,15 @@ int amdgpu_ib_schedule(struct amdgpu_ring *ring, u=
nsigned int num_ibs,
> >       if (ring->funcs->insert_start)
> >               ring->funcs->insert_start(ring);
> >
> > +     if (emit_spm_needed)
> > +             adev->gfx.rlc.funcs->update_spm_vmid(adev, ring->xcc_id, =
ring, job->vmid);
> > +
> > +     if (emit_gds_needed)
> > +             amdgpu_ring_emit_gds_switch(ring, job->vmid, job->gds_bas=
e,
> > +                                         job->gds_size, job->gws_base,
> > +                                         job->gws_size, job->oa_base,
> > +                                         job->oa_size);
> > +
> >       if ((ib->flags & AMDGPU_IB_FLAG_EMIT_MEM_SYNC) && ring->funcs->em=
it_mem_sync)
> >               ring->funcs->emit_mem_sync(ring);
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_vm.c
> > index aec8468634535..756810c606d80 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> > @@ -766,18 +766,22 @@ bool amdgpu_vm_need_pipeline_sync(struct amdgpu_r=
ing *ring,
> >   * @ring: ring to use for flush
> >   * @job:  related job
> >   * @need_pipe_sync: is pipe sync needed
> > + * @emit_spm_needed: does the caller need to emit spm
> > + * @emit_gds_needed: does the caller need to emit gds
> >   *
> >   * Emit a VM flush when it is necessary.
> >   */
> >  void amdgpu_vm_flush(struct amdgpu_ring *ring, struct amdgpu_job *job,
> > -                  bool need_pipe_sync)
> > +                  bool need_pipe_sync, bool *emit_spm_needed,
> > +                  bool *emit_gds_needed)
> >  {
> >       struct amdgpu_device *adev =3D ring->adev;
> >       struct amdgpu_isolation *isolation =3D &adev->isolation[ring->xcp=
_id];
> >       unsigned vmhub =3D ring->vm_hub;
> >       struct amdgpu_vmid_mgr *id_mgr =3D &adev->vm_manager.id_mgr[vmhub=
];
> >       struct amdgpu_vmid *id =3D &id_mgr->ids[job->vmid];
> > -     bool spm_update_needed =3D job->spm_update_needed;
> > +     bool spm_update_needed =3D adev->gfx.rlc.funcs->update_spm_vmid &=
&
> > +             job->spm_update_needed;
> >       bool gds_switch_needed =3D ring->funcs->emit_gds_switch &&
> >               job->gds_switch_needed;
> >       bool vm_flush_needed =3D job->vm_needs_flush;
> > @@ -785,6 +789,7 @@ void amdgpu_vm_flush(struct amdgpu_ring *ring, stru=
ct amdgpu_job *job,
> >       bool pasid_mapping_needed =3D false;
> >       struct dma_fence *fence =3D NULL;
> >       unsigned int patch =3D 0;
> > +     bool emit_fence;
> >
> >       if (amdgpu_vmid_had_gpu_reset(adev, id)) {
> >               gds_switch_needed =3D true;
> > @@ -800,6 +805,7 @@ void amdgpu_vm_flush(struct amdgpu_ring *ring, stru=
ct amdgpu_job *job,
> >       mutex_unlock(&id_mgr->lock);
> >
> >       gds_switch_needed &=3D !!ring->funcs->emit_gds_switch;
> > +     spm_update_needed &=3D !!adev->gfx.rlc.funcs->update_spm_vmid;
> >       vm_flush_needed &=3D !!ring->funcs->emit_vm_flush  &&
> >                       job->vm_pd_addr !=3D AMDGPU_BO_INVALID_OFFSET;
> >       pasid_mapping_needed &=3D adev->gmc.gmc_funcs->emit_pasid_mapping=
 &&
> > @@ -810,6 +816,17 @@ void amdgpu_vm_flush(struct amdgpu_ring *ring, str=
uct amdgpu_job *job,
> >               ring->funcs->emit_cleaner_shader && job->base.s_fence &&
> >               &job->base.s_fence->scheduled =3D=3D isolation->spearhead=
;
> >
> > +     emit_fence =3D !!(vm_flush_needed || pasid_mapping_needed ||
> > +                     cleaner_shader_needed);
> > +
> > +     *emit_spm_needed =3D spm_update_needed;
> > +     if (spm_update_needed && emit_fence)
> > +             *emit_spm_needed =3D false;
> > +
> > +     *emit_gds_needed =3D gds_switch_needed;
> > +     if (gds_switch_needed && emit_fence)
> > +             *emit_gds_needed =3D false;
> > +
> >       if (!vm_flush_needed && !gds_switch_needed && !need_pipe_sync &&
> >           !cleaner_shader_needed && !spm_update_needed)
> >               return;
> > @@ -844,21 +861,21 @@ void amdgpu_vm_flush(struct amdgpu_ring *ring, st=
ruct amdgpu_job *job,
> >       if (pasid_mapping_needed)
> >               amdgpu_gmc_emit_pasid_mapping(ring, job->vmid, job->pasid=
);
> >
> > -     if (spm_update_needed && adev->gfx.rlc.funcs->update_spm_vmid)
> > -             adev->gfx.rlc.funcs->update_spm_vmid(adev, ring->xcc_id, =
ring, job->vmid);
> > +     if (emit_fence) {
> > +             if (spm_update_needed)
> > +                     adev->gfx.rlc.funcs->update_spm_vmid(adev, ring->=
xcc_id, ring, job->vmid);
> >
> > -     if (ring->funcs->emit_gds_switch &&
> > -         gds_switch_needed) {
> > -             amdgpu_ring_emit_gds_switch(ring, job->vmid, job->gds_bas=
e,
> > -                                         job->gds_size, job->gws_base,
> > -                                         job->gws_size, job->oa_base,
> > -                                         job->oa_size);
> > -     }
> > +             if (gds_switch_needed)
> > +                     amdgpu_ring_emit_gds_switch(ring, job->vmid, job-=
>gds_base,
> > +                                                 job->gds_size, job->g=
ws_base,
> > +                                                 job->gws_size, job->o=
a_base,
> > +                                                 job->oa_size);
> >
> > -     amdgpu_fence_emit(ring, job->hw_vm_fence, 0);
> > -     fence =3D &job->hw_vm_fence->base;
> > -     /* get a ref for the job */
> > -     dma_fence_get(fence);
> > +             amdgpu_fence_emit(ring, job->hw_vm_fence, 0);
> > +             fence =3D &job->hw_vm_fence->base;
> > +             /* get a ref for the job */
> > +             dma_fence_get(fence);
> > +     }
> >
> >       if (vm_flush_needed) {
> >               mutex_lock(&id_mgr->lock);
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_vm.h
> > index 939f639cd8bfd..f82572b71c5ad 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
> > @@ -515,7 +515,9 @@ int amdgpu_vm_validate(struct amdgpu_device *adev, =
struct amdgpu_vm *vm,
> >                      struct ww_acquire_ctx *ticket,
> >                      int (*callback)(void *p, struct amdgpu_bo *bo),
> >                      void *param);
> > -void amdgpu_vm_flush(struct amdgpu_ring *ring, struct amdgpu_job *job,=
 bool need_pipe_sync);
> > +void amdgpu_vm_flush(struct amdgpu_ring *ring, struct amdgpu_job *job,
> > +                  bool need_pipe_sync, bool *emit_spm_needed,
> > +                  bool *emit_gds_needed);
> >  int amdgpu_vm_update_pdes(struct amdgpu_device *adev,
> >                         struct amdgpu_vm *vm, bool immediate);
> >  int amdgpu_vm_clear_freed(struct amdgpu_device *adev,
>
