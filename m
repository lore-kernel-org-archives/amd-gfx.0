Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C524E606A31C
	for <amd-gfx@archiver.kernel.org>; Thu, 26 Nov 2026 08:47:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gONgl4L/
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4CC1110E94D;
	Thu, 26 Nov 2026 08:46:58 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1921A10E8CD
 for <amd-gfx@lists.freedesktop.org>; Thu, 26 Nov 2026 08:46:52 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id B11D44630A;
 Thu, 26 Nov 2026 08:46:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75B701F000D4;
 Thu, 26 Nov 2026 08:46:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795682811;
 bh=wmbEtp9Jtge0osoFiaQh7cQsL3hsIKdhAQEopGLa57c=;
 h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
 b=gONgl4L/t+uaOyv0hHSPxkJhyTEySC/vUFCbs/74XLzxowO5FuQWJWH7RnkYkoNNR
 G3xJZAT2C5yXFYvkBNEBA3+QPmENPOzfuxoKQ1pr+/Rg9j0RaIp3UqkxdvSv9Ez97/
 0zvrBCEi1Nh57UjfP2l/qbFWIexe7Qiofw9P9YocA+gCd/zriaIA6BiDOazmXpF9Vv
 APh3QMDZxdkCHP48+d8gQo28OhaUTtYjJoAzLlxHaDLjZsk3vHOwqU3hzbjgwZwJpH
 ZR/0OtcyEsDL5HUozVrtHSBO6avhD0dMAxVYr/hDDNU8NKeDs56jFa/DKsODxRKqB/
 LPyfs74c6XjxQ==
Message-ID: <sashiko-outbox-235053@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 3/9] drm/amdkfd: track whether MES knows each queue
To: "Armas Spann" <zappel@simple-co.de>, amd-gfx@lists.freedesktop.org
In-Reply-To: <20261125141933.154222-4-zappel@simple-co.de>
References: <20261125141933.154222-1-zappel@simple-co.de>
 <20261125141933.154222-4-zappel@simple-co.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 26 Nov 2026 08:46:51 +0000
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
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Archived-By: <archiver.kernel.org>

Thank you for your contribution! Sashiko AI review found 7 potential
issues to consider:
- [High] drm/amdkfd: timeout misclassified in
  remove_queue_mes_on_reset_option()
- [High] drm/amdkfd: duplicate REMOVE_QUEUE after reset in
  reset_queues_mes()
- [High] drm/amdkfd: unhandled reset_queues_mes() error on bad-queue
  interrupt
- [High] drm/amdkfd: clobbered fence and lost timeout in
  reset_queues_mes() recovery
- [Medium] drm/amdkfd: unlocked MES state access in
  kfd_reset_queue_mes()
- [Medium] drm/amdkfd: unhalt and restore skip queues left in
  KFD_MES_QUEUE_MAPPED
- [Low] drm/amdkfd: enum kfd_mes_queue_state detaches struct queue
  kernel-doc
--

commit 137dde38b7013d2a238e16d0644e2b934e97ed33
Author: Armas Spann <zappel@simple-co.de>

drm/amdkfd: track whether MES knows each queue

This commit tracks per-queue MES mapping state, firmware generation, and
pending removal tickets in KFD so queue add, remove, and reset paths can
check whether MES still references a queue and fence off MES after an
unanswered command.

> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c b/driv=
ers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
> index bd3dc4e9c9c77..646bc0ce05be8 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
[ ... ]
> @@ -324,19 +491,91 @@ static int remove_queue_mes_on_reset_option(struct =
device_queue_manager *dqm, st
[ ... ]
> +static int remove_queue_mes_on_reset_option(struct device_queue_manager =
*dqm, struct queue *q,
> +					    struct qcm_process_device *qpd,
> +					    bool is_for_reset,
> +					    bool flush_mes_queue)
> +{
> +	struct amdgpu_device *adev =3D (struct amdgpu_device *)dqm->dev->adev;
> +	int r;
> +
> +	/* MES does not know the queue, or not any more: nothing to send */
> +	if (kfd_mes_queue_retired(dqm, q))
> +		return 0;
> +
> +	/*
> +	 * Nothing can be sent while the scheduler is stopped or halted, and
> +	 * MES still has the queue. Say so rather than report success: the
> +	 * caller then keeps the storage of the queue and leaves its MQD
> +	 * alone, and the removal is sent once the scheduler runs again.
> +	 */
> +	if (!dqm->sched_running || dqm->sched_halt)
> +		return -EIO;

[Severity: Medium]
Does an evicted queue whose removal fails with -EIO ever get removed or
re-added when the scheduler runs again?

When remove_queue_mes_on_reset_option() or __remove_queue_mes() returns
-EIO during evict_process_queues_cpsch() (for example while halted, fenced,
or when down_read_trylock(&adev->reset_domain->sem) fails during a soft
reset), q->properties.is_active is cleared while q->mes_state remains
KFD_MES_QUEUE_MAPPED.  On unhalt, add_all_kfd_queues_mes() skips inactive
queues instead of removing ones where !kfd_mes_queue_retired(dqm, q),
leaving the evicted queue mapped in MES.  When
restore_process_queues_cpsch() later updates qpd->page_table_base and calls
add_queue_mes(), add_queue_mes() sees q->mes_state =3D=3D KFD_MES_QUEUE_MAP=
PED
and returns 0 without re-adding the queue with the new page table base.

> +
> +	r =3D __remove_queue_mes(dqm, q, flush_mes_queue);
> +	if (!r)
> +		return 0;
> +
> +	if (r =3D=3D -ETIMEDOUT) {
> +		/* Not answered yet. The command is still queued and may complete. */
> +		if (kfd_mes_wait_retired(dqm, q, KFD_MES_REMOVE_GRACE_MS)) {
> +			dev_warn(adev->dev,
> +				 "MES confirmed REMOVE_QUEUE late, doorbell=3D0x%x\n",
> +				 q->properties.doorbell_off);
> +			return 0;
> +		}
> +
> +		/*
> +		 * Still no answer. MES is not working its ring, and the
> +		 * recovery below would only queue three more commands behind
> +		 * the unanswered one, each to time out under the dqm lock.
> +		 * Stop talking to MES and leave it to the GPU reset.
> +		 */
> +		if (kfd_mes_ticket_pending(dqm, q))
> +			goto hang;
> +
> +		/* Answered after all, with a failure: a hung queue */
> +		r =3D AMDGPU_MES_CMD_REJECTED;
> +	}

[Severity: High]
Can this overwrite -ETIMEDOUT with AMDGPU_MES_CMD_REJECTED when the MES
ring is full or when the ticket completes between checks?

__remove_queue_mes() calls amdgpu_mes_ticket_release(adev, &q->mes_ticket)
before adev->mes.funcs->remove_hw_queue().  If the MES ring is full,
mes_v11_0_submit_pkt_ticket(), mes_v12_0_submit_pkt_ticket(), and
mes_v12_1_submit_pkt_ticket() time out waiting for ring space and jump to
error_undo without setting ticket->valid =3D true:

drivers/gpu/drm/amd/amdgpu/mes_v12_1.c:mes_v12_1_submit_pkt_ticket() {
    ...
	r =3D amdgpu_fence_wait_polling(ring,
				      seq - ring->fence_drv.num_fences_mask,
				      timeout);
	if (r < 1) {
		r =3D -ETIMEDOUT;
		goto error_undo;
	}
    ...
}

Because q->mes_ticket.valid is false, kfd_mes_wait_retired() and
kfd_mes_ticket_pending() both return false, so r is overwritten with
AMDGPU_MES_CMD_REJECTED.  When is_for_reset is true, reset_queue_mes() sees
AMDGPU_MES_CMD_REJECTED instead of -ETIMEDOUT and returns 0 without fencing
MES or escalating to a GPU reset; when is_for_reset is false, it enters
reset_queues_mes() and queues three more commands into the full ring under
dqm_lock.

The same fallthrough happens if q->mes_ticket transitions to
AMDGPU_MES_TICKET_DONE in the window between kfd_mes_queue_retired() and
kfd_mes_ticket_pending(), treating a completed removal as
AMDGPU_MES_CMD_REJECTED and releasing the completed ticket in
reset_queues_mes() or __remove_queue_mes() without marking the queue
retired.

> +
> +	/*
> +	 * -EIO: nothing was sent, a GPU reset is under way or MES is fenced
> +	 * off. is_for_reset: the cleanup after a per-queue reset, the caller
> +	 * decides what its failure means.
> +	 */
> +	if (is_for_reset || r =3D=3D -EIO)
> +		return r;
> +
> +	/* remove_hw_queue failure indicates a queue hang. reset the queue */
> +	r =3D reset_queues_mes(dqm, q);
> +	if (!r)
> +		return 0;
> +
> +	/* MES let go of the queue in the meantime, whatever else failed */
> +	if (kfd_mes_queue_retired(dqm, q))
> +		return 0;
> +
> +hang:
> +	if (r =3D=3D -ETIMEDOUT || kfd_mes_ticket_pending(dqm, q))
> +		kfd_mes_fence(dqm, q);

[Severity: High]
What happens here when reset_queues_mes(dqm, q) fails with -ETIMEDOUT while
resetting a different hung queue q2?

During amdgpu_gfx_reset_mes_compute(), the loop over num_hung calls
reset_queue_mes() -> remove_queue_mes_on_reset_option(dqm, q2, ..., true,
true) for each hung queue.  If q2's remove-after-reset times out, that
inner call runs kfd_mes_fence(dqm, q2) and returns -ETIMEDOUT without
calling kfd_hws_hang(dqm).

If @q was already reset and retired in an earlier iteration of the
num_hung loop before q2 timed out, kfd_mes_queue_retired(dqm, q) is true in
the outer remove_queue_mes_on_reset_option() and it returns 0 before
reaching hang:, silently dropping q2's timeout and leaving dqm->mes_fenced
set with no GPU reset scheduled.  If @q was not retired, the outer call
reaches hang: with r =3D=3D -ETIMEDOUT and calls kfd_mes_fence(dqm, q); bec=
ause
@q's ticket was released at the start of reset_queues_mes(),
kfd_mes_fence(dqm, q) sets dqm->mes_fence_has_seq =3D false and wipes out
q2's recorded fence ticket.

[ ... ]
> @@ -435,9 +675,22 @@ static int reset_queue_mes(struct device_queue_manag=
er *dqm, struct queue *q,
>  						ffs(dqm->dev->xcc_mask) - 1);
>  	if (r)
>  		return r;
> -	/* Proceed remove_queue with reset=3Dtrue */
> -	remove_queue_mes_on_reset_option(dqm, q, &pdd->qpd, true, true);
> +	/*
> +	 * Proceed remove_queue with reset=3Dtrue. Its result matters: a
> +	 * REMOVE_QUEUE that MES did not answer fails this reset, so that the
> +	 * caller escalates to a GPU reset instead of sending more commands
> +	 * behind it. A rejected cleanup does not fail it, MES answers and
> +	 * the queue itself has been reset; the queue stays UNKNOWN and keeps
> +	 * its storage until MES is restarted.
> +	 */
> +	r =3D remove_queue_mes_on_reset_option(dqm, q, &pdd->qpd, true, true);
>  	set_queue_as_reset(dqm, q, &pdd->qpd, true);
> +	if (r =3D=3D -ETIMEDOUT)
> +		return r;
> +	if (r)
> +		dev_warn(adev->dev,
> +			 "MES did not remove reset queue doorbell=3D0x%x (%d), keeping its st=
orage\n",
> +			 q->properties.doorbell_off, r);
>  	return 0;
>  }

[Severity: Medium]
Can reset_queue_mes() access q->mes_state, q->mes_ticket, and
dqm->mes_fenced without holding dqm_lock(dqm)?

When amdgpu_gfx_reset_mes_compute() is called from gfx_v11_0_reset_kcq(),
gfx_v12_0_reset_kcq(), or amdgpu_userq_reset_work() and MES detects a hung
KFD queue, it calls amdgpu_amdkfd_reset_mes_queue() ->
kfd_reset_queue_mes() -> reset_queue_mes() holding only
adev->gfx.mec.reset_mutex:

CPU0                                    CPU1
gfx_v11_0_reset_kcq()                   destroy_queue_cpsch()
  amdgpu_gfx_reset_mes_compute()          dqm_lock(dqm)
    ...                                   remove_queue_mes(dqm, q, qpd)
      kfd_reset_queue_mes()                 __remove_queue_mes()
        reset_queue_mes()                     amdgpu_mes_ticket_release()
          remove_queue_mes_on_reset_option()
            __remove_queue_mes()
              amdgpu_mes_ticket_release()  <-- data race on q->mes_ticket

Concurrent KFD queue operations under dqm_lock(dqm) can race on
q->mes_ticket (corrupting or double-freeing the writeback slot in
adev->wb), q->mes_state, and dqm->mes_fenced.

> @@ -476,16 +729,50 @@ static int reset_queues_mes(struct device_queue_man=
ager *dqm, struct queue *q)
[ ... ]
>  	/* pass the known bad queue info to the reset function */
>  	r =3D amdgpu_gfx_reset_mes_compute(adev, dqm->dev->xcp, NULL, NULL, NUL=
L, &num_hung, &queue_input);
> -	if (r)
> +	if (r) {
> +		/* The REMOVE_QUEUE for @q may have been sent and lost */
> +		if (q->mes_state =3D=3D KFD_MES_QUEUE_MAPPED)
> +			q->mes_state =3D KFD_MES_QUEUE_UNKNOWN;
>  		goto fail;
> +	}

[Severity: High]
When kfd_dqm_suspend_bad_queue_mes() calls reset_queues_mes(), how does a
timeout in reset_queues_mes() fence MES or escalate to a GPU reset?

drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c:kfd_dqm_suspend_bad_q=
ueue_mes() {
    ...
			if (q->doorbell_id =3D=3D doorbell_id && q->properties.is_active) {
				reset_queues_mes(dqm, q);
				q->properties.is_evicted =3D true;
				q->properties.is_active =3D false;
				decrement_queue_count(dqm, qpd, q);
				break;
			}
    ...
}

kfd_dqm_suspend_bad_queue_mes() ignores the return value of
reset_queues_mes().  If a per-queue remove-after-reset inside
amdgpu_gfx_reset_mes_compute() times out,
remove_queue_mes_on_reset_option(..., is_for_reset =3D true) sets
dqm->mes_fenced =3D true and returns -ETIMEDOUT without calling
kfd_hws_hang(dqm) (and amdgpu_gfx_reset_mes_compute() still sends
amdgpu_mes_resume() at out: before returning).  Because
kfd_dqm_suspend_bad_queue_mes() drops the error, kfd_hws_hang(dqm) is never
called, and every subsequent add_queue_mes() or remove_queue_mes() sees
kfd_mes_fenced(dqm) and returns -EIO without triggering a GPU reset,
leaving the node permanently wedged.  Timeouts in the other MES calls inside
reset_queues_mes() (such as remove_hw_queue() when !num_hung or
__remove_queue_mes() when num_hung > 0) also return without waiting the
grace period, fencing MES, or calling kfd_hws_hang(dqm) on this path.

[ ... ]
> @@ -508,6 +795,17 @@ static int reset_queues_mes(struct device_queue_mana=
ger *dqm, struct queue *q)
>  	}
>  	amdgpu_vm_put_task_info(ti);
> =20
> +	/*
> +	 * MES reported other queues as hung, reset those and resumed the
> +	 * rest, @q among them: amdgpu_gfx_reset_mes_compute() removes the
> +	 * queue it was given only when nothing was reported hung. Both
> +	 * callers want @q out of MES, so remove it now that the scheduler
> +	 * answers again. If @q itself was among the hung queues, the
> +	 * per-queue reset has removed it already and it is retired.
> +	 */
> +	if (num_hung && !kfd_mes_queue_retired(dqm, q))
> +		r =3D __remove_queue_mes(dqm, q, false);

[Severity: High]
What if @q was among the hung queues and MES rejected its
remove-after-reset in reset_queue_mes()?

In that case reset_queue_mes() warns, sets q->properties.is_reset =3D true,
leaves q->mes_state as KFD_MES_QUEUE_UNKNOWN, and returns 0 so the
per-queue reset succeeds without escalating to a GPU reset.  Because
kfd_mes_queue_retired(dqm, q) is still false, reset_queues_mes() then sends
a second __remove_queue_mes(dqm, q, false) with remove_queue_after_reset =3D
false; when that also fails, reset_queues_mes() returns the error to
remove_queue_mes_on_reset_option(), which calls kfd_hws_hang(dqm) and
triggers a full GPU reset.  Likewise, because the q->properties.is_reset
check was removed from remove_queue_mes_on_reset_option(),
remove_all_kfd_queues_mes() on halt or stop will also call
remove_queue_mes() on any reset queue whose remove-after-reset was
rejected.

> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h b/drivers/gpu/drm/amd/=
amdkfd/kfd_priv.h
> index a725fde9f11bd..8a506501a5349 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
> @@ -616,6 +616,13 @@ struct mqd_update_info {
>   *
>   */
> =20
> +/* What MES knows about a queue, see kfd_mes_queue_retired() */
> +enum kfd_mes_queue_state {
> +	KFD_MES_QUEUE_UNMAPPED =3D 0,	/* never added, or removal confirmed */
> +	KFD_MES_QUEUE_MAPPED,		/* ADD_QUEUE confirmed */
> +	KFD_MES_QUEUE_UNKNOWN,		/* ADD or REMOVE sent, not confirmed */
> +};
> +
>  struct queue {

[Severity: Low]
Placing enum kfd_mes_queue_state between the struct queue kernel-doc
comment and struct queue detaches the comment from the struct and triggers
a scripts/kernel-doc warning.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261125141933.1542=
22-1-zappel@simple-co.de?part=3D3
