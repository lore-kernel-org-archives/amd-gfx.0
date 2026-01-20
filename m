Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2813DD2ECFE
	for <amd-gfx@archiver.kernel.org>; Tue, 20 Jan 2026 02:41:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8FE4310E07F;
	Tue, 20 Jan 2026 02:41:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="MGTMmCal";
	dkim-atps=neutral
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com
 [209.85.218.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E1D5E10E07F
 for <amd-gfx@lists.freedesktop.org>; Tue, 20 Jan 2026 02:41:05 +0000 (UTC)
Received: by mail-ej1-f50.google.com with SMTP id
 a640c23a62f3a-b870732cce2so748248966b.3
 for <amd-gfx@lists.freedesktop.org>; Mon, 19 Jan 2026 18:41:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1768876864; x=1769481664; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=22P1KUb5YPjODp7HpEXWgJyl73P6UF4JDLgLVYcYTlo=;
 b=MGTMmCalHxglg0UAq08j5TqWyXPAz3BRo4wwHWpoKjAK+N+8f23oX4newL+yD70Ivb
 /NsWjmWU9Q6rHCQvR8CqJKdJmkEiB8TLMwfS8Q1BpPJiHk9b4DcHD/IJKL09e+O7XpE2
 DTu0BHn87s4D7AAf8OuPnsBRFz7cxTCjhmF6nvDQEbUxOw4WsPeR5G4cdg0eiHE9mKtm
 AQg7rlKimjGKFi3TYwLkW8YyE8KclKA50gmfqcGdN3WhALmuwVahfUqF9KUJIngown4N
 PNbZGomkmUVxuGVMpUQb+MnHc6gCb0DS7FjM7ov5utRJZgrHuKdXdEW8OtVa/b/SQGHO
 U4rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768876864; x=1769481664;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=22P1KUb5YPjODp7HpEXWgJyl73P6UF4JDLgLVYcYTlo=;
 b=mYt6L77NAXYqLW8hcc+p7BcIjkMQ4CCV65sM4VmWa/t7tGZa5TtquXSZbsZkDjCLEk
 dHl5Q4hdjGI416CenDBZh8FUBMCba5Jyj4A2FsPp9IVUEO9vyYeq9LtW0bYoJhhHjTTO
 rlc6rSDKuwi3VC+WWpYYGicS3MMKVMzo+JzdpVEUlCXX9w8gMyaeNlVbKzBfi4IkWLnD
 81cLCTe8FsBmqSUIbzXDGyrb/HHY9lUT7WjnyW16t2nDJYZUNPSfwBnIvF79xOB589pX
 DfJJETUO9qb93jRZW9cPs8TsUNOiHY2XwAxkAHsS9YKTI1b81wkQuDDYyHvI9M4WWbYt
 uMdQ==
X-Gm-Message-State: AOJu0YzM7lVbC3WM8G0CLBKDOcvjwjm4dLUBhOU5uIZ4N2BnjSXVpBY2
 cuhembZZkt2IuEXHJmk3mIIEdPRWwnzS1gzvJ/aw4JILGAQPW0dilOCiizvo5A==
X-Gm-Gg: AY/fxX6DfL4g3iWJr5iNkIvcZFORqazNKnCWMGCjOnjZQ7XBQdrCxGnK6aJchCsJ3UT
 Ci8/l3utl7CMsSvjmpAxQX9yBNE7wQkINu+UIu4cpF5X2caJf0FadA869NSykGpjtGVOfnpaXc1
 wmQyhmvKGdKPAfo+VgkeEyvOni1StbIKwEAH8v3oJPqR5/caiIPmfRoHhyMenj6n9rydIh2NYNN
 QrN5jLsZXOWBnPDvMe7l3wUHQJ+JQr/WF3yfOwjLS28zjG5OmgXh4hluixsp3otq8tSfRin7MnS
 Ti/3d/cgW+JF4AXZQDkOpK2hqLbcVYlYHV0E9ynUI00QPvQDf1JBvnAdUQAPbEgJWgXzGMMLU29
 pLdGE8Tr6xCUzyuJ1AQhhONsmEaPmNwT7JQNpVbYX6khVaYsCLzKle9uVREjHIJaS4sxVsWvWgF
 f1FAGauHqIB3m/G61AGdfpCng//ZZ/5eDGNaiOktZz/IPXtkVAVhADaS4swg3pJMWrHqvShayQs
 p/olvmQ4XfUAIAL6A0+39tedQD2
X-Received: by 2002:a17:907:868f:b0:b76:8164:88b5 with SMTP id
 a640c23a62f3a-b8796b40ddbmr1003259866b.46.1768876863990; 
 Mon, 19 Jan 2026 18:41:03 -0800 (PST)
Received: from timur-max.localnet
 (20014C4E24E4740039031D1B9B995003.dsl.pool.telekom.hu.
 [2001:4c4e:24e4:7400:3903:1d1b:9b99:5003])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b879513e735sm1275584066b.13.2026.01.19.18.41.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 19 Jan 2026 18:41:03 -0800 (PST)
From: Timur =?UTF-8?B?S3Jpc3TDs2Y=?= <timur.kristof@gmail.com>
To: amd-gfx@lists.freedesktop.org
Cc: Alex Deucher <alexander.deucher@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>
Subject: Re: [PATCH 10/10] drm/amdgpu: rework ring reset backup and reemit
Date: Tue, 20 Jan 2026 03:41:02 +0100
Message-ID: <27258781.1r3eYUQgxm@timur-max>
In-Reply-To: <20260116162027.21550-11-alexander.deucher@amd.com>
References: <20260116162027.21550-1-alexander.deucher@amd.com>
 <20260116162027.21550-11-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
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

On 2026. janu=C3=A1r 16., p=C3=A9ntek 17:20:27 k=C3=B6z=C3=A9p-eur=C3=B3pai=
 t=C3=A9li id=C5=91 Alex Deucher=20
wrote:
> Store the start and end wptrs in the IB fence. On queue
> reset, only save the ring contents of the non-guilty contexts.
> Since the VM fence is a sub-fence of the the IB fence, the IB
> fence stores the start and end wptrs for both fences as the IB
> state encapsulates the VM fence state.
>=20
> For reemit, only reemit the state for non-guilty contexts; for
> guilty contexts, just emit the fences.  Split the reemit per
> fence when when we reemit, update the start and end wptrs
> with the new values from reemit.  This allows us to
> reemit jobs repeatedly as the wptrs get properly updated
> each time.  Submitting the fence directly also simplifies
> the logic as we no longer need to store additional wptrs for
> each fence within the IB ring sequence.  If the context is
> guilty, we emit the fence(s) and if not, we reemit the
> whole IB ring sequence for that IB.
>=20

Hi Alex,

I have a few ideas that may help simplify this:

1. We could rework the pipeline sync so that it doesn't depend on the fence=
 of=20
the previous submission, similarly to how you already did for gfx9.=20
=2D Then it becomes unnecessary to re-emit the guilty fence or track where =
the=20
fence was emitted.
=2D This also fixes queue reset for the case when the maximum scheduled=20
submissions are greater than two.
=2D For those engines that do not have something like VS/PS/CS_PARTIAL_FLUS=
H and=20
ACQUIRE_MEM, you can emit a fence + wait_reg inside the pipeline sync.

2. When backing up the ring contents, you could replace submissions that=20
belong to the guilty process with NOPs, and remember the start position of =
the=20
first submission inside the ring buffer. When restoring, you can pad the ri=
ng=20
buffer with NOPs until you get back to the same position.
=2D This way, all the pointers to things inside the ring will remain valid =
and=20
no extra logic is needed when re-emitting the same content repeatedly.

Hope this helps,
Timur

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c | 98 +++++++++--------------
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c    |  9 +--
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c  | 37 +--------
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h  | 20 ++---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c    |  1 +
>  5 files changed, 54 insertions(+), 111 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c index
> d48f61076c06a..541cdbe1e28bf 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
> @@ -89,16 +89,6 @@ static u32 amdgpu_fence_read(struct amdgpu_ring *ring)
>  	return seq;
>  }
>=20
> -static void amdgpu_fence_save_fence_wptr_start(struct amdgpu_fence *af)
> -{
> -	af->fence_wptr_start =3D af->ring->wptr;
> -}
> -
> -static void amdgpu_fence_save_fence_wptr_end(struct amdgpu_fence *af)
> -{
> -	af->fence_wptr_end =3D af->ring->wptr;
> -}
> -
>  /**
>   * amdgpu_fence_emit - emit a fence on the requested ring
>   *
> @@ -126,11 +116,10 @@ int amdgpu_fence_emit(struct amdgpu_ring *ring, str=
uct
> amdgpu_fence *af, &ring->fence_drv.lock,
>  		       adev->fence_context + ring->idx, seq);
>=20
> -	amdgpu_fence_save_fence_wptr_start(af);
> +	af->flags =3D flags | AMDGPU_FENCE_FLAG_INT;
>  	amdgpu_ring_emit_fence(ring, ring->fence_drv.gpu_addr,
> -			       seq, flags | AMDGPU_FENCE_FLAG_INT);
> -	amdgpu_fence_save_fence_wptr_end(af);
> -	amdgpu_fence_save_wptr(af);
> +			       seq, af->flags);
> +
>  	pm_runtime_get_noresume(adev_to_drm(adev)->dev);
>  	ptr =3D &ring->fence_drv.fences[seq & ring-
>fence_drv.num_fences_mask];
>  	if (unlikely(rcu_dereference_protected(*ptr, 1))) {
> @@ -241,7 +230,6 @@ bool amdgpu_fence_process(struct amdgpu_ring *ring)
>=20
>  	do {
>  		struct dma_fence *fence, **ptr;
> -		struct amdgpu_fence *am_fence;
>=20
>  		++last_seq;
>  		last_seq &=3D drv->num_fences_mask;
> @@ -254,12 +242,6 @@ bool amdgpu_fence_process(struct amdgpu_ring *ring)
>  		if (!fence)
>  			continue;
>=20
> -		/* Save the wptr in the fence driver so we know what=20
the last processed
> -		 * wptr was.  This is required for re-emitting the ring=20
state for
> -		 * queues that are reset but are not guilty and thus=20
have no guilty
> fence. -		 */
> -		am_fence =3D container_of(fence, struct amdgpu_fence,=20
base);
> -		drv->signalled_wptr =3D am_fence->wptr;
>  		dma_fence_signal(fence);
>  		dma_fence_put(fence);
>  		pm_runtime_mark_last_busy(adev_to_drm(adev)->dev);
> @@ -727,25 +709,27 @@ void amdgpu_fence_driver_force_completion(struct
> amdgpu_ring *ring, */
>=20
>  /**
> - * amdgpu_fence_driver_update_timedout_fence_state - Update fence state =
and
> set errors + * amdgpu_ring_set_fence_errors_and_reemit - Set dma_fence
> errors and reemit *
> - * @af: fence of the ring to update
> + * @guilty_fence: fence of the ring to update
>   *
>   */
> -void amdgpu_fence_driver_update_timedout_fence_state(struct amdgpu_fence
> *af) +void amdgpu_ring_set_fence_errors_and_reemit(struct amdgpu_ring
> *ring, +					     struct=20
amdgpu_fence *guilty_fence)
>  {
>  	struct dma_fence *unprocessed;
>  	struct dma_fence __rcu **ptr;
>  	struct amdgpu_fence *fence;
> -	struct amdgpu_ring *ring =3D af->ring;
>  	unsigned long flags;
>  	u32 seq, last_seq;
> -	bool reemitted =3D false;
> +	unsigned int i;
>=20
>  	last_seq =3D amdgpu_fence_read(ring) & ring-
>fence_drv.num_fences_mask;
>  	seq =3D ring->fence_drv.sync_seq & ring->fence_drv.num_fences_mask;
>=20
>  	/* mark all fences from the guilty context with an error */
> +	amdgpu_ring_alloc(ring, ring->ring_backup_entries_to_copy +
> +			  20 * ring->guilty_fence_count);
>  	spin_lock_irqsave(&ring->fence_drv.lock, flags);
>  	do {
>  		last_seq++;
> @@ -758,39 +742,41 @@ void
> amdgpu_fence_driver_update_timedout_fence_state(struct amdgpu_fence *af) =
if
> (unprocessed && !dma_fence_is_signaled_locked(unprocessed)) { fence =3D
> container_of(unprocessed, struct amdgpu_fence, base);
>=20
> -			if (fence->reemitted > 1)
> -				reemitted =3D true;
> -			else if (fence =3D=3D af)
> +			if (fence =3D=3D guilty_fence)
>  				dma_fence_set_error(&fence->base,=20
=2DETIME);
> -			else if (fence->context =3D=3D af->context)
> +			else if (fence->context =3D=3D guilty_fence-
>context)
>  				dma_fence_set_error(&fence->base,=20
=2DECANCELED);
> +
> +			if (fence->context =3D=3D guilty_fence->context)=20
{
> +				/* just emit the fence for the=20
guilty context */
> +				amdgpu_ring_emit_fence(ring, ring-
>fence_drv.gpu_addr,
> +						      =20
fence->base.seqno, fence->flags);
> +			} else {
> +				/* reemit the packet stream and=20
update wptrs */
> +				fence->wptr_start =3D ring->wptr;
> +				for (i =3D 0; i < fence-
>backup_size; i++)
> +					amdgpu_ring_write(ring,=20
ring->ring_backup[fence->backup_idx + i]);
> +				fence->wptr_end =3D ring->wptr;
> +			}
>  		}
>  		rcu_read_unlock();
>  	} while (last_seq !=3D seq);
>  	spin_unlock_irqrestore(&ring->fence_drv.lock, flags);
> -
> -	if (reemitted) {
> -		/* if we've already reemitted once then just cancel=20
everything */
> -		amdgpu_fence_driver_force_completion(af->ring, &af-
>base);
> -		af->ring->ring_backup_entries_to_copy =3D 0;
> -	}
> -}
> -
> -void amdgpu_fence_save_wptr(struct amdgpu_fence *af)
> -{
> -	af->wptr =3D af->ring->wptr;
> +	amdgpu_ring_commit(ring);
>  }
>=20
>  static void amdgpu_ring_backup_unprocessed_command(struct amdgpu_ring
> *ring, -						   u64=20
start_wptr, u64 end_wptr)
> +						   struct=20
amdgpu_fence *af)
>  {
> -	unsigned int first_idx =3D start_wptr & ring->buf_mask;
> -	unsigned int last_idx =3D end_wptr & ring->buf_mask;
> +	unsigned int first_idx =3D af->wptr_start & ring->buf_mask;
> +	unsigned int last_idx =3D af->wptr_end & ring->buf_mask;
>  	unsigned int i;
>=20
>  	/* Backup the contents of the ring buffer. */
> +	af->backup_idx =3D ring->ring_backup_entries_to_copy;
>  	for (i =3D first_idx; i !=3D last_idx; ++i, i &=3D ring->buf_mask)
>  		ring->ring_backup[ring->ring_backup_entries_to_copy++]=20
=3D ring->ring[i];
> +	af->backup_size =3D ring->ring_backup_entries_to_copy - af-
>backup_idx;
>  }
>=20
>  void amdgpu_ring_backup_unprocessed_commands(struct amdgpu_ring *ring,
> @@ -799,13 +785,12 @@ void amdgpu_ring_backup_unprocessed_commands(struct
> amdgpu_ring *ring, struct dma_fence *unprocessed;
>  	struct dma_fence __rcu **ptr;
>  	struct amdgpu_fence *fence;
> -	u64 wptr;
>  	u32 seq, last_seq;
>=20
>  	last_seq =3D amdgpu_fence_read(ring) & ring-
>fence_drv.num_fences_mask;
>  	seq =3D ring->fence_drv.sync_seq & ring->fence_drv.num_fences_mask;
> -	wptr =3D ring->fence_drv.signalled_wptr;
>  	ring->ring_backup_entries_to_copy =3D 0;
> +	ring->guilty_fence_count =3D 0;
>=20
>  	do {
>  		last_seq++;
> @@ -818,21 +803,12 @@ void amdgpu_ring_backup_unprocessed_commands(struct
> amdgpu_ring *ring, if (unprocessed && !dma_fence_is_signaled(unprocessed))
> {
>  			fence =3D container_of(unprocessed, struct=20
amdgpu_fence, base);
>=20
> -			/* save everything if the ring is not=20
guilty, otherwise
> -			 * just save the content from other=20
contexts.
> -			 */
> -			if (!fence->reemitted &&
> -			    (!guilty_fence || (fence->context !=3D=20
guilty_fence->context))) {
> -			=09
amdgpu_ring_backup_unprocessed_command(ring, wptr,
> -							=09
       fence->wptr);
> -			} else if (!fence->reemitted) {
> -				/* always save the fence */
> -			=09
amdgpu_ring_backup_unprocessed_command(ring,
> -							=09
       fence->fence_wptr_start,
> -							=09
       fence->fence_wptr_end);
> -			}
> -			wptr =3D fence->wptr;
> -			fence->reemitted++;
> +			/* keep track of the guilty fences for reemit=20
*/
> +			if (fence->context =3D=3D guilty_fence->context)
> +				ring->guilty_fence_count++;
> +			/* Non-vm fence has all the state.  Backup=20
the non-guilty contexts */
> +			if (!fence->is_vm_fence && (fence->context !=3D=20
guilty_fence->context))
> +			=09
amdgpu_ring_backup_unprocessed_command(ring, fence);
>  		}
>  		rcu_read_unlock();
>  	} while (last_seq !=3D seq);
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c index fb58637ed1507..865a803026c=
3b
> 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
> @@ -185,6 +185,7 @@ int amdgpu_ib_schedule(struct amdgpu_ring *ring, stru=
ct
> amdgpu_job *job, dev_err(adev->dev, "scheduling IB failed (%d).\n", r);
>  		return r;
>  	}
> +	af->wptr_start =3D ring->wptr;
>=20
>  	need_ctx_switch =3D ring->current_ctx !=3D fence_ctx;
>  	if (ring->funcs->emit_pipeline_sync && job &&
> @@ -303,13 +304,7 @@ int amdgpu_ib_schedule(struct amdgpu_ring *ring, str=
uct
> amdgpu_job *job, ring->hw_prio =3D=3D AMDGPU_GFX_PIPE_PRIO_HIGH)
>  		ring->funcs->emit_wave_limit(ring, false);
>=20
> -	/* Save the wptr associated with this fence.
> -	 * This must be last for resets to work properly
> -	 * as we need to save the wptr associated with this
> -	 * fence so we know what rings contents to backup
> -	 * after we reset the queue.
> -	 */
> -	amdgpu_fence_save_wptr(af);
> +	af->wptr_end =3D ring->wptr;
>=20
>  	amdgpu_ring_ib_end(ring);
>  	amdgpu_ring_commit(ring);
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c index
> b82357c657237..df37335127979 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
> @@ -104,29 +104,6 @@ int amdgpu_ring_alloc(struct amdgpu_ring *ring,
> unsigned int ndw) return 0;
>  }
>=20
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
int
> ndw) -{
> -	/* Align requested size with padding so unlock_commit can
> -	 * pad safely */
> -	ndw =3D (ndw + ring->funcs->align_mask) & ~ring->funcs->align_mask;
> -
> -	ring->count_dw =3D ndw;
> -	ring->wptr_old =3D ring->wptr;
> -
> -	if (ring->funcs->begin_use)
> -		ring->funcs->begin_use(ring);
> -}
> -
>  /**
>   * amdgpu_ring_insert_nop - insert NOP packets
>   *
> @@ -877,7 +854,6 @@ void amdgpu_ring_reset_helper_begin(struct amdgpu_ring
> *ring, int amdgpu_ring_reset_helper_end(struct amdgpu_ring *ring,
>  				 struct amdgpu_fence=20
*guilty_fence)
>  {
> -	unsigned int i;
>  	int r;
>=20
>  	/* verify that the ring is functional */
> @@ -885,16 +861,9 @@ int amdgpu_ring_reset_helper_end(struct amdgpu_ring
> *ring, if (r)
>  		return r;
>=20
> -	/* set an error on all fences from the context */
> -	if (guilty_fence)
> -	=09
amdgpu_fence_driver_update_timedout_fence_state(guilty_fence);
> -	/* Re-emit the non-guilty commands */
> -	if (ring->ring_backup_entries_to_copy) {
> -		amdgpu_ring_alloc_reemit(ring, ring-
>ring_backup_entries_to_copy);
> -		for (i =3D 0; i < ring->ring_backup_entries_to_copy; i++)
> -			amdgpu_ring_write(ring, ring-
>ring_backup[i]);
> -		amdgpu_ring_commit(ring);
> -	}
> +	/* set an error on all fences from the context and reemit */
> +	amdgpu_ring_set_fence_errors_and_reemit(ring, guilty_fence);
> +
>  	/* Start the scheduler again */
>  	drm_sched_wqueue_start(&ring->sched);
>  	return 0;
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h index
> ce095427611fb..6dca1ccd2fc2e 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
> @@ -121,7 +121,6 @@ struct amdgpu_fence_driver {
>  	/* sync_seq is protected by ring emission lock */
>  	uint32_t			sync_seq;
>  	atomic_t			last_seq;
> -	u64				signalled_wptr;
>  	bool				initialized;
>  	struct amdgpu_irq_src		*irq_src;
>  	unsigned			irq_type;
> @@ -146,15 +145,17 @@ struct amdgpu_fence {
>  	struct amdgpu_ring		*ring;
>  	ktime_t				start_timestamp;
>=20
> +	bool				is_vm_fence;
> +	unsigned int			flags;
>  	/* wptr for the total submission for resets */
> -	u64				wptr;
> +	u64				wptr_start;
> +	u64				wptr_end;
>  	/* fence context for resets */
>  	u64				context;
> -	/* has this fence been reemitted */
> -	unsigned int			reemitted;
> -	/* wptr for the fence for the submission */
> -	u64				fence_wptr_start;
> -	u64				fence_wptr_end;
> +	/* idx into the ring backup */
> +	unsigned int			backup_idx;
> +	unsigned int			backup_size;
> +
>  };
>=20
>  extern const struct drm_sched_backend_ops amdgpu_sched_ops;
> @@ -162,8 +163,8 @@ extern const struct drm_sched_backend_ops
> amdgpu_sched_ops; void amdgpu_fence_driver_set_error(struct amdgpu_ring
> *ring, int error); void amdgpu_fence_driver_force_completion(struct
> amdgpu_ring *ring, struct dma_fence *timedout_fence);
> -void amdgpu_fence_driver_update_timedout_fence_state(struct amdgpu_fence
> *af); -void amdgpu_fence_save_wptr(struct amdgpu_fence *af);
> +void amdgpu_ring_set_fence_errors_and_reemit(struct amdgpu_ring *ring,
> +					     struct=20
amdgpu_fence *guilty_fence);
>=20
>  int amdgpu_fence_driver_init_ring(struct amdgpu_ring *ring);
>  int amdgpu_fence_driver_start_ring(struct amdgpu_ring *ring,
> @@ -314,6 +315,7 @@ struct amdgpu_ring {
>  	/* backups for resets */
>  	uint32_t		*ring_backup;
>  	unsigned int		ring_backup_entries_to_copy;
> +	unsigned int		guilty_fence_count;
>  	unsigned		rptr_offs;
>  	u64			rptr_gpu_addr;
>  	u32			*rptr_cpu_addr;
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c index 6a2ea200d90c8..bd2c01b1ef1=
8f
> 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> @@ -848,6 +848,7 @@ int amdgpu_vm_flush(struct amdgpu_ring *ring, struct
> amdgpu_job *job, r =3D amdgpu_fence_emit(ring, job->hw_vm_fence, 0);
>  		if (r)
>  			return r;
> +		job->hw_vm_fence->is_vm_fence =3D true;
>  		fence =3D &job->hw_vm_fence->base;
>  		/* get a ref for the job */
>  		dma_fence_get(fence);




