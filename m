Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1CCC1D778BE
	for <amd-gfx@archiver.kernel.org>; Fri, 23 Jan 2026 22:29:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B922310EBE7;
	Fri, 23 Jan 2026 22:29:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="LwdNlDvr";
	dkim-atps=neutral
Received: from mail-dl1-f42.google.com (mail-dl1-f42.google.com [74.125.82.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 965D610EBE7
 for <amd-gfx@lists.freedesktop.org>; Fri, 23 Jan 2026 22:29:44 +0000 (UTC)
Received: by mail-dl1-f42.google.com with SMTP id
 a92af1059eb24-1233e05c77bso270341c88.1
 for <amd-gfx@lists.freedesktop.org>; Fri, 23 Jan 2026 14:29:44 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769207384; cv=none;
 d=google.com; s=arc-20240605;
 b=CZpV+IHwCD1gpoTtLpBq3w0K+MzSz2xMa/moFbjmKqIOBpDCzgzEOVpmlct7xcJMM8
 z7UdXKst2+F0Tk62Xnyjdfp4lbTvpFHlptaO9lbyA5sFqlpBpzpOXJmneEXgIZ2urmpH
 Kbh2RD2D65IPt8xpCgNEKOGZsNyigq9vK1EwIovv4vOOooY6UkfACOHgedXg+U1wgiFQ
 l7FPmAekJBGoKOiN7ArUPvfgRDnFlruJCNjogAWy1J6/IO2vP4sj6VuCJQGibP40CgbJ
 lP9Mr1yestuCAsG6x4eS3Fs/TATQ58/czoX3hHSXXNuAbH+5u0xLV6CsEGgMFz00rU/K
 KFew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=tudLwpy1QEmfLI0aBfrCTIy2qfTorM7vwCMyLqnrSvE=;
 fh=+AyXzW/xSj3vlpm83/VuAJeeOkrzFbm9l5sgEiAXJes=;
 b=SU+z5Q6y7Ub2IqK/2TU6v/IXknFNTYfdh6RUyw7oX8//MH+i8Atd07Z/BsTUu+Ulph
 w0bUjy4TBL8oSx1j4AQkSDrtulaNFzIiGMR/w60EvQcU1Z4a4CVbCu473y3vRgmc7YVb
 qb/JVzPqbBT+va+Qxz3YLJWQweNax0EQHRi9UCgRugXRTtPd+nLAgxsoWZ4lHmrWR2Xz
 J2yAutKwtG8G5nFbSvrr16jhok7D9EFL7v4zYYCz0Jw4MwHtzqfu/m4dFXPM/R6vrnLM
 v0GlVLRJTjVgIMVRRNu1t5rObqnvHeSYRMiuAf+MqLCKtj+QB/PR6vy0vilWBBR4FW7k
 EpKQ==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1769207384; x=1769812184; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tudLwpy1QEmfLI0aBfrCTIy2qfTorM7vwCMyLqnrSvE=;
 b=LwdNlDvrik5+5/ZpPFSf9xfNWxxQEBBlrAZNvYi5+JwKRZQWA5s9om7ETwSaPwxqpC
 OlhfqKN6moj2q0nOgEDJPoEG89r7EwANjbXZj39J4/As5yMWxpVekDKAPr/5Y+hXDUUO
 D1LH/cOGgRzPBoSlArsPHjUJ5Qjj8y/traDfOc+53G8aZudh1sak6h38roiuO2t7yTtA
 vNfZB4lKeR2+U3sZM+wR+7+ivlZFGGcGZi7C37urmrMCYE4MOpcR7YhxQ134T0oHzade
 3cZXOf+O9JLrLpLFBpOTUATV+jaBnzOiATMSazGi+bqqkQ8acYG2UrnaP3ElSuqNSdO4
 BC0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769207384; x=1769812184;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=tudLwpy1QEmfLI0aBfrCTIy2qfTorM7vwCMyLqnrSvE=;
 b=reFPUEWj0uujkAVuti3Hap2QAKrTJ+Dq6pSAy+Zx2wF0uzI3ums5HOOniL4ORHhadi
 Wotc7VC9V75fVmrdFFt9/A9XE5yGPxuY5fTnL3xg9be1d5XQYbpwSyRA4VRyTbimtpI2
 opfJUS+EFJZGkyzCP5NjhCSp7WQYMqfOOOgQNqhZnCy1btOe0cs1WVNETSrmTJf+vMHC
 WgetluEuW1PXsfIoP5yAd3xTpgSoywkP+Wsrs6+WQRAuUuKRh5Sh0gQpm5hVzwQDNkUC
 IAbx1K9//J1RWsgDDyZCTNfmTb+vHL3o2bpnyEXZB3PLq55xhhMqrMqDAD2q2iuHmEUk
 bZgw==
X-Gm-Message-State: AOJu0YyEdbxY77K7dUbbRvPcm6Mabs6xuya7f/F9nA0r3UB5mJq+zec9
 p9dgUSm2fcv3J9jDSqKL1qX1O4mPpehP+/E4lNcSfTP1fVPQY91N3rvOCS9tkOlkxPtnFLHSJHK
 q5Fcg+fty1/T9I8fX+AQgxM4KybF/0ClZxg==
X-Gm-Gg: AZuq6aKw406pK+y3jWJx+ms6B/vIw49IVVjVQQ5eBIk0xgtFBepPTNKUQMtfXYRa4/z
 5y4dRH7E1EbzPPm3fUNWNUvIisd2A5OUNhs+rktbZrtcVCCkQ2J7Cxpf4g8XU+l7BLPqDU4+UZ3
 IgRIh3Kp0iHmhpo4g5KfIW4FkLfrCveE2/swdG6RB0wXxxd53mokmTzX495faDcIe9VNGr3dvem
 RdtV2srqEQJCKF9EuJAX9ZiJHLqOjVMO4p3n7fsrB9sL5dONSu/DBJRGrX2KA4QHtHA85JyjokB
 S/8at0Y=
X-Received: by 2002:a05:693c:2b10:b0:2af:7427:30b with SMTP id
 5a478bee46e88-2b74e7cf709mr263324eec.1.1769207383533; Fri, 23 Jan 2026
 14:29:43 -0800 (PST)
MIME-Version: 1.0
References: <20260123171938.16814-1-alexander.deucher@amd.com>
 <20260123171938.16814-12-alexander.deucher@amd.com>
In-Reply-To: <20260123171938.16814-12-alexander.deucher@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Fri, 23 Jan 2026 17:29:32 -0500
X-Gm-Features: AZwV_Qhq24t9RsDkWWyXPvoF0pCyglylVMwDGy31Hq1qyQJSsiD5IGl-ZS8qW7Y
Message-ID: <CADnq5_MsX7ZL9BvVjBE_SSfibAvBxuQV-2LD=tmYh4J1LH-fjA@mail.gmail.com>
Subject: Re: [PATCH 11/11] drm/amdgpu: rework ring reset backup and reemit v6
To: Alex Deucher <alexander.deucher@amd.com>
Cc: amd-gfx@lists.freedesktop.org, Jesse Zhang <jesse.zhang@amd.com>
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

On Fri, Jan 23, 2026 at 12:57=E2=80=AFPM Alex Deucher <alexander.deucher@am=
d.com> wrote:
>
> Store the start wptr and ib size in the IB fence. On queue
> reset, save the ring contents of all IBs. Since the VM fence
> is a sub-fence of the the IB fence, the IB fence stores the
> state for both fences as the IB state encapsulates the VM fence
> state.

This last sentence is wrong as of v6 of this patch.  Fixed up locally.

Alex

>
> For reemit, reemit the entire IB state for non-guilty contexts.
> For guilty contexts, replace the IB submission with nops, but reemit
> the rest.  Special handling is required for the vm fence as that
> likely signalled before the job fence even if the job ultimately
> hung.  Skip the vm state if the vm fence signalled.  Split the reemit
> per fence and when we reemit, update the wptr with the new values
> from reemit.  This allows us to reemit jobs repeatedly as the wptrs get
> properly updated each time.
>
> v2: further simplify the logic
> v3: reemit vm state, not just vm fence
> v4: just nop the IB and possibly the VM portion of the submission
> v5: simplify the vm fence check
> v6: split the vm and ib fences
>
> Reviewed-by: Jesse Zhang <jesse.zhang@amd.com>
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c | 98 +++++++++--------------
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c    | 27 ++++---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c  | 46 +++--------
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h  | 20 ++---
>  4 files changed, 73 insertions(+), 118 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c b/drivers/gpu/drm/=
amd/amdgpu/amdgpu_fence.c
> index d48f61076c06a..dcd313e09f379 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
> @@ -89,16 +89,6 @@ static u32 amdgpu_fence_read(struct amdgpu_ring *ring)
>         return seq;
>  }
>
> -static void amdgpu_fence_save_fence_wptr_start(struct amdgpu_fence *af)
> -{
> -       af->fence_wptr_start =3D af->ring->wptr;
> -}
> -
> -static void amdgpu_fence_save_fence_wptr_end(struct amdgpu_fence *af)
> -{
> -       af->fence_wptr_end =3D af->ring->wptr;
> -}
> -
>  /**
>   * amdgpu_fence_emit - emit a fence on the requested ring
>   *
> @@ -126,11 +116,9 @@ int amdgpu_fence_emit(struct amdgpu_ring *ring, stru=
ct amdgpu_fence *af,
>                        &ring->fence_drv.lock,
>                        adev->fence_context + ring->idx, seq);
>
> -       amdgpu_fence_save_fence_wptr_start(af);
>         amdgpu_ring_emit_fence(ring, ring->fence_drv.gpu_addr,
>                                seq, flags | AMDGPU_FENCE_FLAG_INT);
> -       amdgpu_fence_save_fence_wptr_end(af);
> -       amdgpu_fence_save_wptr(af);
> +
>         pm_runtime_get_noresume(adev_to_drm(adev)->dev);
>         ptr =3D &ring->fence_drv.fences[seq & ring->fence_drv.num_fences_=
mask];
>         if (unlikely(rcu_dereference_protected(*ptr, 1))) {
> @@ -241,7 +229,6 @@ bool amdgpu_fence_process(struct amdgpu_ring *ring)
>
>         do {
>                 struct dma_fence *fence, **ptr;
> -               struct amdgpu_fence *am_fence;
>
>                 ++last_seq;
>                 last_seq &=3D drv->num_fences_mask;
> @@ -254,12 +241,6 @@ bool amdgpu_fence_process(struct amdgpu_ring *ring)
>                 if (!fence)
>                         continue;
>
> -               /* Save the wptr in the fence driver so we know what the =
last processed
> -                * wptr was.  This is required for re-emitting the ring s=
tate for
> -                * queues that are reset but are not guilty and thus have=
 no guilty fence.
> -                */
> -               am_fence =3D container_of(fence, struct amdgpu_fence, bas=
e);
> -               drv->signalled_wptr =3D am_fence->wptr;
>                 dma_fence_signal(fence);
>                 dma_fence_put(fence);
>                 pm_runtime_mark_last_busy(adev_to_drm(adev)->dev);
> @@ -727,25 +708,28 @@ void amdgpu_fence_driver_force_completion(struct am=
dgpu_ring *ring,
>   */
>
>  /**
> - * amdgpu_fence_driver_update_timedout_fence_state - Update fence state =
and set errors
> + * amdgpu_ring_set_fence_errors_and_reemit - Set dma_fence errors and re=
emit
>   *
> - * @af: fence of the ring to update
> + * @guilty_fence: fence of the ring to update
>   *
>   */
> -void amdgpu_fence_driver_update_timedout_fence_state(struct amdgpu_fence=
 *af)
> +void amdgpu_ring_set_fence_errors_and_reemit(struct amdgpu_ring *ring,
> +                                            struct amdgpu_fence *guilty_=
fence)
>  {
>         struct dma_fence *unprocessed;
>         struct dma_fence __rcu **ptr;
>         struct amdgpu_fence *fence;
> -       struct amdgpu_ring *ring =3D af->ring;
>         unsigned long flags;
>         u32 seq, last_seq;
> -       bool reemitted =3D false;
> +       unsigned int i;
> +       bool is_guilty_fence;
> +       bool is_guilty_context;
>
>         last_seq =3D amdgpu_fence_read(ring) & ring->fence_drv.num_fences=
_mask;
>         seq =3D ring->fence_drv.sync_seq & ring->fence_drv.num_fences_mas=
k;
>
> -       /* mark all fences from the guilty context with an error */
> +       ring->reemit =3D true;
> +       amdgpu_ring_alloc(ring, ring->ring_backup_entries_to_copy);
>         spin_lock_irqsave(&ring->fence_drv.lock, flags);
>         do {
>                 last_seq++;
> @@ -757,39 +741,45 @@ void amdgpu_fence_driver_update_timedout_fence_stat=
e(struct amdgpu_fence *af)
>
>                 if (unprocessed && !dma_fence_is_signaled_locked(unproces=
sed)) {
>                         fence =3D container_of(unprocessed, struct amdgpu=
_fence, base);
> +                       is_guilty_fence =3D fence =3D=3D guilty_fence;
> +                       is_guilty_context =3D fence->context =3D=3D guilt=
y_fence->context;
>
> -                       if (fence->reemitted > 1)
> -                               reemitted =3D true;
> -                       else if (fence =3D=3D af)
> +                       /* mark all fences from the guilty context with a=
n error */
> +                       if (is_guilty_fence)
>                                 dma_fence_set_error(&fence->base, -ETIME)=
;
> -                       else if (fence->context =3D=3D af->context)
> +                       else if (is_guilty_context)
>                                 dma_fence_set_error(&fence->base, -ECANCE=
LED);
> +
> +                       /* reemit the packet stream and update wptrs */
> +                       fence->ib_wptr =3D ring->wptr;
> +                       for (i =3D 0; i < fence->ib_dw_size; i++) {
> +                               /* Skip the IB(s) for the guilty context.=
 */
> +                               if (is_guilty_context &&
> +                                   i >=3D fence->skip_ib_dw_start_offset=
 &&
> +                                   i < fence->skip_ib_dw_end_offset)
> +                                       amdgpu_ring_write(ring, ring->fun=
cs->nop);
> +                               else
> +                                       amdgpu_ring_write(ring,
> +                                                         ring->ring_back=
up[fence->backup_idx + i]);
> +                       }
>                 }
>                 rcu_read_unlock();
>         } while (last_seq !=3D seq);
>         spin_unlock_irqrestore(&ring->fence_drv.lock, flags);
> -
> -       if (reemitted) {
> -               /* if we've already reemitted once then just cancel every=
thing */
> -               amdgpu_fence_driver_force_completion(af->ring, &af->base)=
;
> -               af->ring->ring_backup_entries_to_copy =3D 0;
> -       }
> -}
> -
> -void amdgpu_fence_save_wptr(struct amdgpu_fence *af)
> -{
> -       af->wptr =3D af->ring->wptr;
> +       amdgpu_ring_commit(ring);
> +       ring->reemit =3D false;
>  }
>
>  static void amdgpu_ring_backup_unprocessed_command(struct amdgpu_ring *r=
ing,
> -                                                  u64 start_wptr, u64 en=
d_wptr)
> +                                                  struct amdgpu_fence *a=
f)
>  {
> -       unsigned int first_idx =3D start_wptr & ring->buf_mask;
> -       unsigned int last_idx =3D end_wptr & ring->buf_mask;
> +       unsigned int first_idx =3D af->ib_wptr & ring->buf_mask;
> +       unsigned int dw_size =3D af->ib_dw_size;
>         unsigned int i;
>
> +       af->backup_idx =3D ring->ring_backup_entries_to_copy;
>         /* Backup the contents of the ring buffer. */
> -       for (i =3D first_idx; i !=3D last_idx; ++i, i &=3D ring->buf_mask=
)
> +       for (i =3D first_idx; dw_size > 0; ++i, i &=3D ring->buf_mask, --=
dw_size)
>                 ring->ring_backup[ring->ring_backup_entries_to_copy++] =
=3D ring->ring[i];
>  }
>
> @@ -799,12 +789,10 @@ void amdgpu_ring_backup_unprocessed_commands(struct=
 amdgpu_ring *ring,
>         struct dma_fence *unprocessed;
>         struct dma_fence __rcu **ptr;
>         struct amdgpu_fence *fence;
> -       u64 wptr;
>         u32 seq, last_seq;
>
>         last_seq =3D amdgpu_fence_read(ring) & ring->fence_drv.num_fences=
_mask;
>         seq =3D ring->fence_drv.sync_seq & ring->fence_drv.num_fences_mas=
k;
> -       wptr =3D ring->fence_drv.signalled_wptr;
>         ring->ring_backup_entries_to_copy =3D 0;
>
>         do {
> @@ -818,21 +806,7 @@ void amdgpu_ring_backup_unprocessed_commands(struct =
amdgpu_ring *ring,
>                 if (unprocessed && !dma_fence_is_signaled(unprocessed)) {
>                         fence =3D container_of(unprocessed, struct amdgpu=
_fence, base);
>
> -                       /* save everything if the ring is not guilty, oth=
erwise
> -                        * just save the content from other contexts.
> -                        */
> -                       if (!fence->reemitted &&
> -                           (!guilty_fence || (fence->context !=3D guilty=
_fence->context))) {
> -                               amdgpu_ring_backup_unprocessed_command(ri=
ng, wptr,
> -                                                                      fe=
nce->wptr);
> -                       } else if (!fence->reemitted) {
> -                               /* always save the fence */
> -                               amdgpu_ring_backup_unprocessed_command(ri=
ng,
> -                                                                      fe=
nce->fence_wptr_start,
> -                                                                      fe=
nce->fence_wptr_end);
> -                       }
> -                       wptr =3D fence->wptr;
> -                       fence->reemitted++;
> +                       amdgpu_ring_backup_unprocessed_command(ring, fenc=
e);
>                 }
>                 rcu_read_unlock();
>         } while (last_seq !=3D seq);
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c b/drivers/gpu/drm/amd=
/amdgpu/amdgpu_ib.c
> index fc02756673860..2ff22a8bd7b07 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
> @@ -126,6 +126,7 @@ int amdgpu_ib_schedule(struct amdgpu_ring *ring, stru=
ct amdgpu_job *job,
>         struct amdgpu_ib *ib;
>         struct dma_fence *tmp =3D NULL;
>         struct amdgpu_fence *af;
> +       struct amdgpu_fence *vm_af;
>         bool need_ctx_switch;
>         uint64_t fence_ctx;
>         uint32_t status =3D 0, alloc_size;
> @@ -135,7 +136,7 @@ int amdgpu_ib_schedule(struct amdgpu_ring *ring, stru=
ct amdgpu_job *job,
>         bool need_pipe_sync =3D false;
>         unsigned int cond_exec;
>         unsigned int i;
> -       int r =3D 0;
> +       int r =3D 0, count_dw;
>
>         if (!job)
>                 return -EINVAL;
> @@ -146,13 +147,14 @@ int amdgpu_ib_schedule(struct amdgpu_ring *ring, st=
ruct amdgpu_job *job,
>         fence_ctx =3D job->base.s_fence ?
>                 job->base.s_fence->finished.context : 0;
>         af =3D job->hw_fence;
> +       vm_af =3D job->hw_vm_fence;
>         /* Save the context of the job for reset handling.
>          * The driver needs this so it can skip the ring
>          * contents for guilty contexts.
>          */
>         af->context =3D fence_ctx;
>         /* the vm fence is also part of the job's context */
> -       job->hw_vm_fence->context =3D fence_ctx;
> +       vm_af->context =3D fence_ctx;
>
>         if (!ring->sched.ready) {
>                 dev_err(adev->dev, "couldn't schedule ib on ring <%s>\n",=
 ring->name);
> @@ -192,11 +194,19 @@ int amdgpu_ib_schedule(struct amdgpu_ring *ring, st=
ruct amdgpu_job *job,
>                 dma_fence_put(tmp);
>         }
>
> +       /* VM sequence */
> +       vm_af->ib_wptr =3D ring->wptr;
> +       count_dw =3D ring->count_dw;
>         r =3D amdgpu_vm_flush(ring, job, need_pipe_sync);
>         if (r) {
>                 amdgpu_ring_undo(ring);
>                 return r;
>         }
> +       vm_af->ib_dw_size =3D count_dw - ring->count_dw;
> +
> +       /* IB sequence */
> +       af->ib_wptr =3D ring->wptr;
> +       count_dw =3D ring->count_dw;
>
>         amdgpu_ring_ib_begin(ring);
>
> @@ -218,6 +228,8 @@ int amdgpu_ib_schedule(struct amdgpu_ring *ring, stru=
ct amdgpu_job *job,
>                 cond_exec =3D amdgpu_ring_init_cond_exec(ring,
>                                                        ring->cond_exe_gpu=
_addr);
>
> +       /* Skip the IB for guilty contexts */
> +       af->skip_ib_dw_start_offset =3D count_dw - ring->count_dw;
>         amdgpu_device_flush_hdp(adev, ring);
>
>         if (need_ctx_switch)
> @@ -256,6 +268,8 @@ int amdgpu_ib_schedule(struct amdgpu_ring *ring, stru=
ct amdgpu_job *job,
>                 amdgpu_ring_emit_frame_cntl(ring, false, secure);
>
>         amdgpu_device_invalidate_hdp(adev, ring);
> +       /* Skip the IB for guilty contexts */
> +       af->skip_ib_dw_end_offset =3D count_dw - ring->count_dw;
>
>         if (ib->flags & AMDGPU_IB_FLAG_TC_WB_NOT_INVALIDATE)
>                 fence_flags |=3D AMDGPU_FENCE_FLAG_TC_WB_ONLY;
> @@ -297,13 +311,8 @@ int amdgpu_ib_schedule(struct amdgpu_ring *ring, str=
uct amdgpu_job *job,
>                 ring->funcs->emit_wave_limit(ring, false);
>
>         amdgpu_ring_ib_end(ring);
> -       /* Save the wptr associated with this fence.
> -        * This must be last for resets to work properly
> -        * as we need to save the wptr associated with this
> -        * fence so we know what rings contents to backup
> -        * after we reset the queue.
> -        */
> -       amdgpu_fence_save_wptr(af);
> +
> +       af->ib_dw_size =3D count_dw - ring->count_dw;
>
>         amdgpu_ring_commit(ring);
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_ring.c
> index 129ad51386535..83750ab4e81b5 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
> @@ -90,10 +90,13 @@ int amdgpu_ring_alloc(struct amdgpu_ring *ring, unsig=
ned int ndw)
>         ndw =3D (ndw + ring->funcs->align_mask) & ~ring->funcs->align_mas=
k;
>
>         /* Make sure we aren't trying to allocate more space
> -        * than the maximum for one submission
> +        * than the maximum for one submission.  Skip for reemit
> +        * since we may be reemitting several submissions.
>          */
> -       if (WARN_ON_ONCE(ndw > ring->max_dw))
> -               return -ENOMEM;
> +       if (!ring->reemit) {
> +               if (WARN_ON_ONCE(ndw > ring->max_dw))
> +                       return -ENOMEM;
> +       }
>
>         ring->count_dw =3D ndw;
>         ring->wptr_old =3D ring->wptr;
> @@ -104,29 +107,6 @@ int amdgpu_ring_alloc(struct amdgpu_ring *ring, unsi=
gned int ndw)
>         return 0;
>  }
>
> -/**
> - * amdgpu_ring_alloc_reemit - allocate space on the ring buffer for reem=
it
> - *
> - * @ring: amdgpu_ring structure holding ring information
> - * @ndw: number of dwords to allocate in the ring buffer
> - *
> - * Allocate @ndw dwords in the ring buffer (all asics).
> - * doesn't check the max_dw limit as we may be reemitting
> - * several submissions.
> - */
> -static void amdgpu_ring_alloc_reemit(struct amdgpu_ring *ring, unsigned =
int ndw)
> -{
> -       /* Align requested size with padding so unlock_commit can
> -        * pad safely */
> -       ndw =3D (ndw + ring->funcs->align_mask) & ~ring->funcs->align_mas=
k;
> -
> -       ring->count_dw =3D ndw;
> -       ring->wptr_old =3D ring->wptr;
> -
> -       if (ring->funcs->begin_use)
> -               ring->funcs->begin_use(ring);
> -}
> -
>  /**
>   * amdgpu_ring_insert_nop - insert NOP packets
>   *
> @@ -875,7 +855,6 @@ void amdgpu_ring_reset_helper_begin(struct amdgpu_rin=
g *ring,
>  int amdgpu_ring_reset_helper_end(struct amdgpu_ring *ring,
>                                  struct amdgpu_fence *guilty_fence)
>  {
> -       unsigned int i;
>         int r;
>
>         /* verify that the ring is functional */
> @@ -883,16 +862,9 @@ int amdgpu_ring_reset_helper_end(struct amdgpu_ring =
*ring,
>         if (r)
>                 return r;
>
> -       /* set an error on all fences from the context */
> -       if (guilty_fence)
> -               amdgpu_fence_driver_update_timedout_fence_state(guilty_fe=
nce);
> -       /* Re-emit the non-guilty commands */
> -       if (ring->ring_backup_entries_to_copy) {
> -               amdgpu_ring_alloc_reemit(ring, ring->ring_backup_entries_=
to_copy);
> -               for (i =3D 0; i < ring->ring_backup_entries_to_copy; i++)
> -                       amdgpu_ring_write(ring, ring->ring_backup[i]);
> -               amdgpu_ring_commit(ring);
> -       }
> +       /* set an error on all fences from the context and reemit */
> +       amdgpu_ring_set_fence_errors_and_reemit(ring, guilty_fence);
> +
>         return 0;
>  }
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_ring.h
> index ce095427611fb..9231896d603d8 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
> @@ -121,7 +121,6 @@ struct amdgpu_fence_driver {
>         /* sync_seq is protected by ring emission lock */
>         uint32_t                        sync_seq;
>         atomic_t                        last_seq;
> -       u64                             signalled_wptr;
>         bool                            initialized;
>         struct amdgpu_irq_src           *irq_src;
>         unsigned                        irq_type;
> @@ -146,15 +145,15 @@ struct amdgpu_fence {
>         struct amdgpu_ring              *ring;
>         ktime_t                         start_timestamp;
>
> -       /* wptr for the total submission for resets */
> -       u64                             wptr;
> +       /* location and size of the IB */
> +       u64                             ib_wptr;
> +       unsigned int                    ib_dw_size;
> +       unsigned int                    skip_ib_dw_start_offset;
> +       unsigned int                    skip_ib_dw_end_offset;
>         /* fence context for resets */
>         u64                             context;
> -       /* has this fence been reemitted */
> -       unsigned int                    reemitted;
> -       /* wptr for the fence for the submission */
> -       u64                             fence_wptr_start;
> -       u64                             fence_wptr_end;
> +       /* idx for ring backups */
> +       unsigned int                    backup_idx;
>  };
>
>  extern const struct drm_sched_backend_ops amdgpu_sched_ops;
> @@ -162,8 +161,8 @@ extern const struct drm_sched_backend_ops amdgpu_sche=
d_ops;
>  void amdgpu_fence_driver_set_error(struct amdgpu_ring *ring, int error);
>  void amdgpu_fence_driver_force_completion(struct amdgpu_ring *ring,
>                                           struct dma_fence *timedout_fenc=
e);
> -void amdgpu_fence_driver_update_timedout_fence_state(struct amdgpu_fence=
 *af);
> -void amdgpu_fence_save_wptr(struct amdgpu_fence *af);
> +void amdgpu_ring_set_fence_errors_and_reemit(struct amdgpu_ring *ring,
> +                                            struct amdgpu_fence *guilty_=
fence);
>
>  int amdgpu_fence_driver_init_ring(struct amdgpu_ring *ring);
>  int amdgpu_fence_driver_start_ring(struct amdgpu_ring *ring,
> @@ -314,6 +313,7 @@ struct amdgpu_ring {
>         /* backups for resets */
>         uint32_t                *ring_backup;
>         unsigned int            ring_backup_entries_to_copy;
> +       bool                    reemit;
>         unsigned                rptr_offs;
>         u64                     rptr_gpu_addr;
>         u32                     *rptr_cpu_addr;
> --
> 2.52.0
>
