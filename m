Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58616606A31E
	for <amd-gfx@archiver.kernel.org>; Tue, 24 Nov 2026 05:04:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NHvbmHtz
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E051D10E08C;
	Tue, 24 Nov 2026 05:04:31 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1873510E08C
 for <amd-gfx@lists.freedesktop.org>; Tue, 24 Nov 2026 05:04:25 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 9CA8B40C56;
 Tue, 24 Nov 2026 05:04:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 362961F000C0;
 Tue, 24 Nov 2026 05:04:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795496664;
 bh=ARyGmgYqYDpwG9t5Pseq5fq0hlaejE0KpGV7NdEBauw=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=NHvbmHtzkGaVIFx3Qx/etHlKZ8i6oC76/CKT3Fn0cwsAapdKnze2YjqcnB4h/AbZE
 oD9Glgo3mkH7EqO2LtaXxKwCVOuvTFjk0bD3xrsNovqKA0zmDWURspE8YtgCdjmR14
 VKk1b+wCmnB73e8m8ewjeq0LIQ6pxYts6VWhGRrwHeuZKqwjpanDMiVBgKdSOLQZAA
 O5UuNt+oONiDbxQdf+Zw0IYwWs2vPqR+Si/D461LlzUAWz2eGuzL8YnQstG18BgDfi
 HfmB2s5br9nwKFBVTSlQi2hVx0/F52M+5t+ZnbYmvBmoKPdXg/xPaQijNwCbEph9wW
 oRD2FH0iyrVJg==
Message-ID: <sashiko-outbox-230541@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] drm/amdgpu: track finished page table updates with a
 fence chain
To: "chong li" <chongli2@amd.com>
Cc: amd-gfx@lists.freedesktop.org
In-Reply-To: <20261124044544.3561866-1-chongli2@amd.com>
References: <20261124044544.3561866-1-chongli2@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 24 Nov 2026 05:04:23 +0000
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Reply-To: sashiko-reviews@lists.linux.dev
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Archived-By: <archiver.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential
issues to consider:
- [Medium] drm/amdgpu: O(N^2) chain walk in amdgpu_vm_tlb_flush() and
  amdgpu_vm_tlb_seq()
- [Low] drm/amdgpu: missing Fixes trailer for TLB sequence race fix
--

commit bb4d183d85e4f91ff2a4b58dd0ca99081bbe5e40
Author: chong li <chongli2@amd.com>

> drm/amdgpu: track finished page table updates with a fence chain
>=20
> amdgpu_vm_tlb_seq() waits for the tlb_seq callback of a page table update
> by taking the lock of vm->last_seq_flush. But every fence has its own
> lock, and a newer update replaces vm->last_seq_flush without waiting for
> the callbacks of older updates. A job scheduled after an older fence has
> signaled, but before its callback has finished, takes the lock of the
> newer fence, misses the tlb_seq increment and can reuse a VMID without
> flushing the TLB after the page table update it waited for.
>=20
> how to fix:
> Stop incrementing tlb_seq from a fence callback. Put the fences of the
> updates which need a TLB flush into a dma_fence_chain and let
> amdgpu_vm_tlb_seq() add the number of updates which have signaled. A
> dependent job then sees the sequence change together with the signaled
> bit of the fence it waited for. The chain nodes are numbered
> consecutively. The number of the newest node minus the number of
> unsignaled nodes therefore also counts the signaled nodes which were
> already pruned, in any completion order. Nothing references the VM from
> a fence callback any more, so amdgpu_vm_fini() no longer needs to wait
> for vm->last_seq_flush.
>=20
> Signed-off-by: chong li <chongli2@amd.com>

[Severity: Low]
Should this bug fix include a Fixes tag?

  Fixes: 5255e146c99a ("drm/amdgpu: rework TLB flushing")

> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd=
/amdgpu/amdgpu_vm.c
> index 94b1cfe05e3e0..4e5a1286ffcbb 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c

[ ... ]

> @@ -1085,47 +1070,33 @@ int amdgpu_vm_update_pdes(struct amdgpu_device *a=
dev,
>  static void
>  amdgpu_vm_tlb_flush(struct amdgpu_vm_update_params *params,
>  		    struct dma_fence *fence,
> -		    struct amdgpu_vm_tlb_seq_struct *tlb_cb)
> +		    struct dma_fence_chain *chain)
>  {
>  	struct amdgpu_vm *vm =3D params->vm;
> +	struct dma_fence *prev, *iter;
> =20
> -	tlb_cb->vm =3D vm;
> -	if (fence && !dma_fence_add_callback(fence, &tlb_cb->cb,
> -					     amdgpu_vm_tlb_seq_cb)) {
> -		dma_fence_put(vm->last_seq_flush);
> -		vm->last_seq_flush =3D dma_fence_get(fence);
> -	} else {
> -		amdgpu_vm_tlb_seq_cb(NULL, &tlb_cb->cb);
> -	}
> +	/* The reference of vm->last_seq_flush to prev moves into the chain */
> +	prev =3D rcu_dereference_protected(vm->last_seq_flush,
> +					 lockdep_is_held(&vm->eviction_lock));
> +	dma_fence_chain_init(chain, prev,
> +			     fence ? dma_fence_get(fence) : dma_fence_get_stub(),
> +			     prev ? prev->seqno + 1 : 1);
> +	rcu_assign_pointer(vm->last_seq_flush, &chain->base);
> +
> +	/* Prune signaled nodes, not every VM reads the sequence */
> +	dma_fence_chain_for_each(iter, &chain->base);

[ ... ]

> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h b/drivers/gpu/drm/amd=
/amdgpu/amdgpu_vm.h
> index f6285a9d9e989..6142a86a8b802 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h

[ ... ]

> @@ -554,22 +555,24 @@ bool amdgpu_vm_is_bo_always_valid(struct amdgpu_vm =
*vm, struct amdgpu_bo *bo);
>   */
>  static inline uint64_t amdgpu_vm_tlb_seq(struct amdgpu_vm *vm)
>  {
> -	unsigned long flags;
> -	spinlock_t *lock;
> +	u64 seq =3D atomic64_read(&vm->tlb_seq);
> +	struct dma_fence *head, *iter;
> =20
> -	/*
> -	 * Workaround to stop racing between the fence signaling and handling
> -	 * the cb. The lock is static after initially setting it up, just make
> -	 * sure that the dma_fence structure isn't freed up.
> -	 */
>  	rcu_read_lock();
> -	lock =3D dma_fence_spinlock(vm->last_seq_flush);
> +	head =3D dma_fence_get_rcu_safe(&vm->last_seq_flush);
>  	rcu_read_unlock();
> -
> -	spin_lock_irqsave(lock, flags);
> -	spin_unlock_irqrestore(lock, flags);
> -
> -	return atomic64_read(&vm->tlb_seq);
> +	if (!head)
> +		return seq;
> +
> +	/* Add the updates in the chain which have finished, in any order */
> +	seq +=3D head->seqno;
> +	dma_fence_chain_for_each(iter, head) {
> +		if (!dma_fence_is_signaled(dma_fence_chain_contained(iter)))
> +			--seq;
> +	}
> +	dma_fence_put(head);
> +
> +	return seq;
>  }

[Severity: Medium]
Does walking vm->last_seq_flush with dma_fence_chain_for_each() in
amdgpu_vm_tlb_flush() and amdgpu_vm_tlb_seq() turn batches of N in-flight p=
age
table updates into an O(N^2) chain walk?

dma_fence_chain_walk() only unlinks signaled predecessors and visits every
unsignaled node in the chain, acquiring and releasing a reference at each s=
tep.
When N updates requiring a TLB flush are queued while their SDMA fences are
still unsignaled (such as amdgpu_vm_clear_freed() looping over vm->freed wh=
ile
SDMA jobs wait on active VM submissions), each amdgpu_vm_tlb_flush() call w=
alks
all prior unsignaled nodes in vm->last_seq_flush.  In addition,
amdgpu_vmid_grab() calls amdgpu_vm_tlb_seq() up to twice while holding the
per-VMHUB id_mgr->lock mutex, walking all unsignaled chain nodes under the
lock, and amdgpu_vm_tlb_flush() allocates and chains a node even when fence=
 is
NULL or already signaled.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261124044544.3561=
866-1-chongli2@amd.com?part=3D1
