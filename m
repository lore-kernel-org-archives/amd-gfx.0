Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4580C5AD7B
	for <amd-gfx@archiver.kernel.org>; Mon, 10 Aug 2026 15:59:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1367910E923;
	Mon, 10 Aug 2026 15:59:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Mi+QtXrF";
	dkim-atps=neutral
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com
 [209.85.216.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3CB2610E91C
 for <amd-gfx@lists.freedesktop.org>; Mon, 10 Aug 2026 15:59:24 +0000 (UTC)
Received: by mail-pj1-f53.google.com with SMTP id
 98e67ed59e1d1-38f0f3c8da5so436335a91.3
 for <amd-gfx@lists.freedesktop.org>; Mon, 10 Aug 2026 08:59:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786377564; cv=none;
 d=google.com; s=arc-20260327;
 b=MymDpYE9MWrVYL+YCV5Rllg618Lidmb5zzxDjtdo6Arw7+r4ICQjUPPLvw4Iqwm7fn
 lWLi8VMzT2ceO6Uv1aG7PsUYzV/WhcKL36NcYvWQ+DWJJ9aYh9kQ7kIsWeUspiatip/w
 qSGafcuTFdqeiYTPx72iEH47BEQKektM26ivLOIFU6GfgJtjk3kRFu8ZckbwXrGp7aeF
 HYkAm9U/cdHg9rrEN3iopbls7cUZsFcRsBMO67epGkLNt8wag93f3bd8AAYcf7iksJom
 sC3fgYlJi+E0TD/L7BpvsgDDGx05YLXVjmtaQBgJuilXUvsD4bQi8Go0pLY+7XXt7suv
 nOrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=c+HIOKxSi5D6Tl+n74Zq3MZ9Kzz19jLckADcxHuCno8=;
 fh=LR5nYlp4SQ9Y5RoHOFFN8/5sCDfwuxixotjwSflQ0w0=;
 b=Js3ONRNAoAtwoVD4kS9zRHWWGxeqvnvCEhCivOtnscBiUe6qyLz4M3O8GOrVW/p8ev
 R0CoQbPN5EI5XUWRDkTZOyi0heSPu8ze944jJgSr6Wt/ABXaQ2dB81UnlKovhWi3iyyk
 QcG1kwNHAG7oN3btrld/4oGt/u8cuqVG5GXkPbnJKO01wjpyXfQArmetiTYy/vhl4E6k
 LbQkF1PSztBfRpmqE9zioBmM+cLfZnHQiFCE1lTgox5Y3A3UcZc4BvVEMmWQlGy7ETnO
 8nf/VGg5Un6z2ehXwPiRLxum4YG0/lO0a0+vRBgUeYIvVaO211Vh5URR9q3Aq+hViDOP
 b/CA==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1786377564; x=1786982364; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=c+HIOKxSi5D6Tl+n74Zq3MZ9Kzz19jLckADcxHuCno8=;
 b=Mi+QtXrFCDcsxUcOBttOisR/RVi9BDgGyrEpcMApDH5Ft4uQAtpP23SeuHxaz14JcI
 8xm88P8fqAIpUBjjq4lRKZ9Y9ZiTIGj/pYEO/wzSfbMn5jBghJq0JepFGTjLZ2JO8/Ml
 JjJj+u/CwBuqdO8mTAdlFVfvtp2O3b3A881IWr7l0xMwUn+G8eb6ynuknnQEaNKhGivc
 84uYBBImnMr1+u9WJGoTJ+n2677cQBpQMw/ByRIogYFopFZ9twjPmkZRNTivG+QLa9/Q
 5IYJyqae7L78pTCV4QX/JoLtn0DmGZc1CW7fk1SyxthKc2Tj1e0vYAFaEShm9lx79G6s
 3v2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786377564; x=1786982364;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=c+HIOKxSi5D6Tl+n74Zq3MZ9Kzz19jLckADcxHuCno8=;
 b=oCRk/ReryM7HhQEJU1l3S9mz4seWmHnbNTL3Ks3yQzrgxi7NcsfIIWZP9xhwgem5Iz
 0yojMkfIjnu8EAbLgw2WOE1Bl1rdbVY3T9PGTAc7jHc6+4jSLONQjKjk0l+Lz61fyWDT
 SQs2i0OCcBhdgwXcJ9HtCAezAzdufZ+ChEsUxClkODC1YN2eR3oVd1HFnqh9BBIQ2pZr
 AGB2Zi1OAazrwncDWY27Xz802gAglHypMfYouUCEI462UIonteNx+qIPHkQ5LFzf+nqa
 6MvI+RDQ9tKnIlQ7YVr7UE6tQULWPf08v/5IeFMfGcQRhT//hlp9EbDbfq6qlJiKfmP3
 KIxg==
X-Gm-Message-State: AOJu0Yzc+FvBVsdZCxMCxJfwJvrJ9UCRv8guIt0SrqUgD4tccwUMKT5r
 sm2OMe5c9gKYR1FjWWhcRa83fuhHN9fr6M9dsFrkotWFzgggW2VLaSln31F2I0nj+xI80clwHt5
 to3lO50N0Q5peMgeUui/2zI+M2PdCFtCk9g==
X-Gm-Gg: AR+sD11JVfrnR0p4CTLhP7Pv1MnxtNUynygKaHecNf4FDEeb7PAL/1+lD+6ybOXpc9E
 O6nYG23+Qmm4lyVdcxR2lNW1y6BgFkrIjpXjUfWxeKLTxeJkS41NnQg1z8YFeUaJANvdvu+YVuE
 UVDz5NTcHjPVgHP2xXKPbfogbKBXlSxZWNA4IQhuQsshQp8gqbL95+cnsewgJjyola+WUOdrEUH
 VR2qejmKz7AkjsFVINT7lOGwfF5LGzCSmNU50yQCTX9pBgWdQtaxan3/cxKPTlNT+P4/elu1SfN
 DVFy77dQd78R2jOmJAk/f0Lt1v9Yn2LQXj/W50csGxa0SIOp/IEJdSdqrQVhmpiV07dBTvi49O4
 9ytyVo636QkBihUtkryozJQSpoYROS+g=
X-Received: by 2002:a17:90b:3a81:b0:381:2788:a437 with SMTP id
 98e67ed59e1d1-3903c541ec7mr30243175a91.1.1786377563611; Mon, 10 Aug 2026
 08:59:23 -0700 (PDT)
MIME-Version: 1.0
References: <20260713182414.630372-1-alexander.deucher@amd.com>
 <20260713182414.630372-3-alexander.deucher@amd.com>
In-Reply-To: <20260713182414.630372-3-alexander.deucher@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 10 Aug 2026 11:59:09 -0400
X-Gm-Features: AUfX_mytnvh8xuDwZQmCDggpRvcutELk_Fojutyz4ZSdWYlV5XTddAXWfAa7PZA
Message-ID: <CADnq5_Orn3EWG_wGNyDHZa=7xCkQMJpFeK_wDxRXDcsRCSCxhQ@mail.gmail.com>
Subject: Re: [PATCH 3/3] drm/amdgpu: handle GDS and SPM without a VM fence
To: Alex Deucher <alexander.deucher@amd.com>, David Rosca <david.rosca@amd.com>
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

+ David

Ping?

On Mon, Jul 13, 2026 at 2:24=E2=80=AFPM Alex Deucher <alexander.deucher@amd=
.com> wrote:
>
> If we end up emitting a VM fence keep GDS and SPM
> associated with that fence.  If not, emit them as
> part of the IB fence.
>
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c | 14 +++++++-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c | 47 ++++++++++++++++++--------
>  drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h |  4 ++-
>  3 files changed, 48 insertions(+), 17 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c b/drivers/gpu/drm/amd=
/amdgpu/amdgpu_ib.c
> index f1ed4a436f5b4..d439c68eed9de 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
> @@ -131,6 +131,8 @@ int amdgpu_ib_schedule(struct amdgpu_ring *ring, unsi=
gned int num_ibs,
>         struct amdgpu_fence *af;
>         struct amdgpu_fence *vm_af;
>         bool need_ctx_switch;
> +       bool emit_spm_needed =3D false;
> +       bool emit_gds_needed =3D false;
>         struct amdgpu_vm *vm;
>         uint64_t fence_ctx;
>         uint32_t status =3D 0, alloc_size;
> @@ -220,7 +222,8 @@ int amdgpu_ib_schedule(struct amdgpu_ring *ring, unsi=
gned int num_ibs,
>                 vm_af =3D job->hw_vm_fence;
>                 /* VM sequence */
>                 vm_af->ib_wptr =3D ring->wptr;
> -               amdgpu_vm_flush(ring, job, need_pipe_sync);
> +               amdgpu_vm_flush(ring, job, need_pipe_sync, &emit_spm_need=
ed,
> +                               &emit_gds_needed);
>                 vm_af->ib_dw_size =3D
>                         amdgpu_ring_get_dw_distance(ring, vm_af->ib_wptr,=
 ring->wptr);
>         }
> @@ -232,6 +235,15 @@ int amdgpu_ib_schedule(struct amdgpu_ring *ring, uns=
igned int num_ibs,
>         if (ring->funcs->insert_start)
>                 ring->funcs->insert_start(ring);
>
> +       if (emit_spm_needed)
> +               adev->gfx.rlc.funcs->update_spm_vmid(adev, ring->xcc_id, =
ring, job->vmid);
> +
> +       if (emit_gds_needed)
> +               amdgpu_ring_emit_gds_switch(ring, job->vmid, job->gds_bas=
e,
> +                                           job->gds_size, job->gws_base,
> +                                           job->gws_size, job->oa_base,
> +                                           job->oa_size);
> +
>         if ((ib->flags & AMDGPU_IB_FLAG_EMIT_MEM_SYNC) && ring->funcs->em=
it_mem_sync)
>                 ring->funcs->emit_mem_sync(ring);
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd=
/amdgpu/amdgpu_vm.c
> index aec8468634535..756810c606d80 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> @@ -766,18 +766,22 @@ bool amdgpu_vm_need_pipeline_sync(struct amdgpu_rin=
g *ring,
>   * @ring: ring to use for flush
>   * @job:  related job
>   * @need_pipe_sync: is pipe sync needed
> + * @emit_spm_needed: does the caller need to emit spm
> + * @emit_gds_needed: does the caller need to emit gds
>   *
>   * Emit a VM flush when it is necessary.
>   */
>  void amdgpu_vm_flush(struct amdgpu_ring *ring, struct amdgpu_job *job,
> -                    bool need_pipe_sync)
> +                    bool need_pipe_sync, bool *emit_spm_needed,
> +                    bool *emit_gds_needed)
>  {
>         struct amdgpu_device *adev =3D ring->adev;
>         struct amdgpu_isolation *isolation =3D &adev->isolation[ring->xcp=
_id];
>         unsigned vmhub =3D ring->vm_hub;
>         struct amdgpu_vmid_mgr *id_mgr =3D &adev->vm_manager.id_mgr[vmhub=
];
>         struct amdgpu_vmid *id =3D &id_mgr->ids[job->vmid];
> -       bool spm_update_needed =3D job->spm_update_needed;
> +       bool spm_update_needed =3D adev->gfx.rlc.funcs->update_spm_vmid &=
&
> +               job->spm_update_needed;
>         bool gds_switch_needed =3D ring->funcs->emit_gds_switch &&
>                 job->gds_switch_needed;
>         bool vm_flush_needed =3D job->vm_needs_flush;
> @@ -785,6 +789,7 @@ void amdgpu_vm_flush(struct amdgpu_ring *ring, struct=
 amdgpu_job *job,
>         bool pasid_mapping_needed =3D false;
>         struct dma_fence *fence =3D NULL;
>         unsigned int patch =3D 0;
> +       bool emit_fence;
>
>         if (amdgpu_vmid_had_gpu_reset(adev, id)) {
>                 gds_switch_needed =3D true;
> @@ -800,6 +805,7 @@ void amdgpu_vm_flush(struct amdgpu_ring *ring, struct=
 amdgpu_job *job,
>         mutex_unlock(&id_mgr->lock);
>
>         gds_switch_needed &=3D !!ring->funcs->emit_gds_switch;
> +       spm_update_needed &=3D !!adev->gfx.rlc.funcs->update_spm_vmid;
>         vm_flush_needed &=3D !!ring->funcs->emit_vm_flush  &&
>                         job->vm_pd_addr !=3D AMDGPU_BO_INVALID_OFFSET;
>         pasid_mapping_needed &=3D adev->gmc.gmc_funcs->emit_pasid_mapping=
 &&
> @@ -810,6 +816,17 @@ void amdgpu_vm_flush(struct amdgpu_ring *ring, struc=
t amdgpu_job *job,
>                 ring->funcs->emit_cleaner_shader && job->base.s_fence &&
>                 &job->base.s_fence->scheduled =3D=3D isolation->spearhead=
;
>
> +       emit_fence =3D !!(vm_flush_needed || pasid_mapping_needed ||
> +                       cleaner_shader_needed);
> +
> +       *emit_spm_needed =3D spm_update_needed;
> +       if (spm_update_needed && emit_fence)
> +               *emit_spm_needed =3D false;
> +
> +       *emit_gds_needed =3D gds_switch_needed;
> +       if (gds_switch_needed && emit_fence)
> +               *emit_gds_needed =3D false;
> +
>         if (!vm_flush_needed && !gds_switch_needed && !need_pipe_sync &&
>             !cleaner_shader_needed && !spm_update_needed)
>                 return;
> @@ -844,21 +861,21 @@ void amdgpu_vm_flush(struct amdgpu_ring *ring, stru=
ct amdgpu_job *job,
>         if (pasid_mapping_needed)
>                 amdgpu_gmc_emit_pasid_mapping(ring, job->vmid, job->pasid=
);
>
> -       if (spm_update_needed && adev->gfx.rlc.funcs->update_spm_vmid)
> -               adev->gfx.rlc.funcs->update_spm_vmid(adev, ring->xcc_id, =
ring, job->vmid);
> +       if (emit_fence) {
> +               if (spm_update_needed)
> +                       adev->gfx.rlc.funcs->update_spm_vmid(adev, ring->=
xcc_id, ring, job->vmid);
>
> -       if (ring->funcs->emit_gds_switch &&
> -           gds_switch_needed) {
> -               amdgpu_ring_emit_gds_switch(ring, job->vmid, job->gds_bas=
e,
> -                                           job->gds_size, job->gws_base,
> -                                           job->gws_size, job->oa_base,
> -                                           job->oa_size);
> -       }
> +               if (gds_switch_needed)
> +                       amdgpu_ring_emit_gds_switch(ring, job->vmid, job-=
>gds_base,
> +                                                   job->gds_size, job->g=
ws_base,
> +                                                   job->gws_size, job->o=
a_base,
> +                                                   job->oa_size);
>
> -       amdgpu_fence_emit(ring, job->hw_vm_fence, 0);
> -       fence =3D &job->hw_vm_fence->base;
> -       /* get a ref for the job */
> -       dma_fence_get(fence);
> +               amdgpu_fence_emit(ring, job->hw_vm_fence, 0);
> +               fence =3D &job->hw_vm_fence->base;
> +               /* get a ref for the job */
> +               dma_fence_get(fence);
> +       }
>
>         if (vm_flush_needed) {
>                 mutex_lock(&id_mgr->lock);
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h b/drivers/gpu/drm/amd=
/amdgpu/amdgpu_vm.h
> index 939f639cd8bfd..f82572b71c5ad 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
> @@ -515,7 +515,9 @@ int amdgpu_vm_validate(struct amdgpu_device *adev, st=
ruct amdgpu_vm *vm,
>                        struct ww_acquire_ctx *ticket,
>                        int (*callback)(void *p, struct amdgpu_bo *bo),
>                        void *param);
> -void amdgpu_vm_flush(struct amdgpu_ring *ring, struct amdgpu_job *job, b=
ool need_pipe_sync);
> +void amdgpu_vm_flush(struct amdgpu_ring *ring, struct amdgpu_job *job,
> +                    bool need_pipe_sync, bool *emit_spm_needed,
> +                    bool *emit_gds_needed);
>  int amdgpu_vm_update_pdes(struct amdgpu_device *adev,
>                           struct amdgpu_vm *vm, bool immediate);
>  int amdgpu_vm_clear_freed(struct amdgpu_device *adev,
> --
> 2.55.0
>
