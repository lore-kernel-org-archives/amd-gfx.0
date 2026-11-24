Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16FE6606A323
	for <amd-gfx@archiver.kernel.org>; Tue, 24 Nov 2026 16:31:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=EPu2ea22
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8AB4710F771;
	Tue, 24 Nov 2026 16:31:05 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D0AEC10F771
 for <amd-gfx@lists.freedesktop.org>; Tue, 24 Nov 2026 16:30:58 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 7804F40B71;
 Tue, 24 Nov 2026 16:30:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD0291F000CF;
 Tue, 24 Nov 2026 16:30:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795537858;
 bh=i0mz693u0PWyZ7sbi3dsrP5cHQW6Cv2Ca8e3hKqLryE=;
 h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
 b=EPu2ea22JsIxFlOl6Re/bYgQyob+91N4IM7pN7x6oJTS99GbgJJGirKOiG+eejQkp
 YNxxr74vlsH+hu0GMA/H78fAZq4BbI/lJ1ZbOVRQOCd42EbU7IOzHvJO2mjEFaArq1
 59N84tuPClSIba88II08qRTnFAYc3nROjB7/NEvrTA+y4CJ+TIcyqQMuNcbUnQKCIR
 XdlPkjYNV/2JiWVdDr0BA8WhvnA3ZoqHdYbTee8dPSt2wzcE5SjqofAUlaShMQ05Wh
 2W8fYib4YrP7ZZZZv4nHKiRs5D/I6RuNbFdkjgb6qf5zoM78YePzG1FZ+UJSyD5AEP
 8360Si7QppGuA==
Message-ID: <sashiko-outbox-231571@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1 3/9] drm/amdkfd: track whether MES knows each queue
To: "Armas Spann" <zappel@simple-co.de>, amd-gfx@lists.freedesktop.org
In-Reply-To: <20261124143433.49736-4-zappel@simple-co.de>
References: <20261124143433.49736-1-zappel@simple-co.de>
 <20261124143433.49736-4-zappel@simple-co.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 24 Nov 2026 16:30:57 +0000
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

Thank you for your contribution! Sashiko AI review found 8 potential
issues to consider:
- [High] drm/amdkfd: ignored remove-after-reset error and unfenced
  timeout in reset_queue_mes()
- [High] drm/amdkfd: duplicate REMOVE_QUEUE after late completion in
  reset_queues_mes()
- [High] drm/amdkfd: false success in remove_queue_mes_on_reset_option()
  when queue is not retired
- [High] drm/amdkfd: kfd_dqm_suspend_bad_queue_mes() leaves unremoved
  queue in MES
- [Medium] drm/amdkfd: missing kfd_mes_fence() call on command timeout
  in add_queue_mes()
- [Medium] drm/amdkfd: reset_queues_mes() called behind unanswered
  REMOVE_QUEUE before fencing
- [Medium] drm/amdkfd: missing gang_context_array_index and ticket in
  reset_queues_mes()
- [Medium] drm/amdkfd: unlocked MES state access in
  kfd_reset_queue_mes()
It also noticed 1 related pre-existing issue this patch does not
introduce:
- [High] drm/amdkfd: unbalanced queue unmap in update_queue() on reset
  queue [1]
--

commit 646aa63a006f03da9e5f44bcc16133cd8b988d3e
Author: Armas Spann <zappel@simple-co.de>

drm/amdkfd: track whether MES knows each queue

This commit tracks the per-queue MES mapping state, firmware generation,
and pending REMOVE_QUEUE ticket so KFD can tell whether MES still
references a queue and avoid sending further commands behind an unanswered
one.

> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c b/driv=
ers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
> index bd3dc4e9c9c77..684037d333bf1 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c

[ ... ]

> @@ -270,10 +399,18 @@ static int add_queue_mes(struct device_queue_manage=
r *dqm, struct queue *q,
>  	queue_input.vm_cntx_cntl =3D qpd->vm_cntx_cntl;
>  	queue_input.xcc_id =3D ffs(dqm->dev->xcc_mask) - 1;
> =20
> +	/* Cannot change under us, reset_domain->sem is held for reading */
> +	gen =3D kfd_mes_gen(dqm);
> +
>  	amdgpu_mes_lock(&adev->mes);
>  	r =3D adev->mes.funcs->add_hw_queue(&adev->mes, &queue_input);
>  	amdgpu_mes_unlock(&adev->mes);
>  	up_read(&adev->reset_domain->sem);
> +
> +	/* A failed ADD_QUEUE may still be executed, or may have been */
> +	q->mes_fw_gen =3D gen;
> +	q->mes_state =3D r ? KFD_MES_QUEUE_UNKNOWN : KFD_MES_QUEUE_MAPPED;
> +
>  	if (r) {
>  		dev_err(adev->dev, "failed to add hardware queue to MES, doorbell=3D0x=
%x\n",
>  			q->properties.doorbell_off);

[Severity: Medium]
Should add_queue_mes() call kfd_mes_fence(dqm, q) when add_hw_queue() fails
with -ETIMEDOUT?

kfd_hws_hang() only schedules an asynchronous reset work item, so without
fencing MES here, callers that iterate over multiple queues under dqm_lock
(such as kfd_resume_all_processes() or set_perfcount()) keep submitting
commands behind the unanswered ADD_QUEUE and suffer cascading timeouts
while holding reset_domain->sem.

> @@ -299,24 +436,38 @@ static int add_queue_mes(struct device_queue_manage=
r *dqm, struct queue *q,
>  	return r;
>  }
> =20
> -static int remove_queue_mes_on_reset_option(struct device_queue_manager =
*dqm, struct queue *q,
> -					    struct qcm_process_device *qpd,
> -					    bool is_for_reset,
> -					    bool flush_mes_queue)
> +/*
> + * Send one REMOVE_QUEUE and record the outcome in q->mes_state.
> + *
> + * Returns -EIO when nothing was sent because MES is fenced off or a GPU
> + * reset is in progress, and -ETIMEDOUT when MES did not answer (this
> + * command, or an earlier one for the same queue).
> + */
> +static int __remove_queue_mes(struct device_queue_manager *dqm, struct q=
ueue *q,
> +			      bool flush_mes_queue)
>  {
> -	struct amdgpu_device *adev =3D (struct amdgpu_device *)dqm->dev->adev;
> -	int r;
> +	struct amdgpu_device *adev =3D dqm->dev->adev;
>  	struct mes_remove_queue_input queue_input;
> +	int r;
> =20
> -	/* queue was already removed during reset */
> -	if (q->properties.is_reset)
> -		return 0;
> +	if (kfd_mes_fenced(dqm))
> +		return -EIO;
> +
> +	/*
> +	 * An earlier REMOVE_QUEUE for this queue is still in the MES ring.
> +	 * Do not send another one behind it, and keep its status slot.
> +	 */
> +	if (q->mes_ticket.valid &&
> +	    amdgpu_mes_ticket_poll(adev, &q->mes_ticket) =3D=3D
> +	    AMDGPU_MES_TICKET_PENDING)
> +		return -ETIMEDOUT;
> =20
> -	if (!dqm->sched_running || dqm->sched_halt)
> -		return 0;
>  	if (!down_read_trylock(&adev->reset_domain->sem))
>  		return -EIO;
> =20
> +	/* The earlier command, if there was one, has been answered */
> +	amdgpu_mes_ticket_release(adev, &q->mes_ticket);
> +
>  	memset(&queue_input, 0x0, sizeof(struct mes_remove_queue_input));
>  	queue_input.doorbell_offset =3D q->properties.doorbell_off;
>  	queue_input.gang_context_addr =3D q->gang_ctx_gpu_addr;
> @@ -324,23 +475,74 @@ static int remove_queue_mes_on_reset_option(struct =
device_queue_manager *dqm, st
>  	queue_input.remove_queue_after_reset =3D flush_mes_queue;
>  	queue_input.xcc_id =3D ffs(dqm->dev->xcc_mask) - 1;
>  	queue_input.gang_context_array_index =3D q->gang_ctx_array_index;
> +	queue_input.ticket =3D &q->mes_ticket;
> =20
>  	amdgpu_mes_lock(&adev->mes);
>  	r =3D adev->mes.funcs->remove_hw_queue(&adev->mes, &queue_input);
>  	amdgpu_mes_unlock(&adev->mes);
>  	up_read(&adev->reset_domain->sem);
> =20
> +	q->mes_state =3D r ? KFD_MES_QUEUE_UNKNOWN : KFD_MES_QUEUE_UNMAPPED;
> +
> +	return r;
> +}
> +
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
> +	/* queue was already removed during reset */
> +	if (q->properties.is_reset)
> +		return 0;
> +
> +	if (!dqm->sched_running || dqm->sched_halt)
> +		return 0;

[Severity: High]
When kfd_mes_queue_retired() returns false, MES may still have the queue;
doesn't returning 0 on q->properties.is_reset, !dqm->sched_running, or
dqm->sched_halt tell callers that the queue was unmapped while leaving it
in MES?

Any queue that was genuinely removed during halt_cpsch(), stop_cpsch(), or
reset_queue_mes() already returns 0 via kfd_mes_queue_retired().  If
halt_cpsch() fails halfway through remove_all_kfd_queues_mes() and sets
dqm->sched_halt =3D true with remaining active queues still mapped in MES,
update_queue_locked() on one of those active queues gets 0 from
remove_queue_mes() and rewrites its MQD in place while MES still has it
mapped (or evict_process_queues_cpsch() unpins the MQD BO while MES can
still access it).

[Severity: Medium]
Can remove_queue_mes_on_reset_option() also race on q->mes_ticket,
q->mes_state, and dqm->mes_fenced when called from kfd_reset_queue_mes()
without dqm_lock?

When a KCQ or AMDGPU userq reset runs amdgpu_gfx_reset_mes_compute() (from
gfx_v11_0_reset_kcq(), gfx_v12_0_reset_kcq(), or amdgpu_userq_reset_work()),
dqm_lock is not held:

CPU0                                  CPU1
destroy_queue_cpsch()                 gfx_v11_0_reset_kcq()
  dqm_lock(dqm)                         amdgpu_gfx_reset_mes_compute()
  remove_queue_mes()                      ...
    __remove_queue_mes()                    kfd_reset_queue_mes()
      amdgpu_mes_ticket_release()             reset_queue_mes()
      remove_hw_queue(...,                      remove_queue_mes_on_reset_o=
ption()
                      &q->mes_ticket)             kfd_mes_queue_retired()
                                                    amdgpu_mes_ticket_relea=
se()
                                                      <-- data race on q->m=
es_ticket

Concurrent updates to q->mes_ticket and q->mes_state can corrupt the state
tracking or double-free the writeback slot in adev->wb.

> +
> +	r =3D __remove_queue_mes(dqm, q, flush_mes_queue);
> +	if (!r)
> +		return 0;
> +
> +	/* Not answered yet. The command is still queued and may complete. */
> +	if (r =3D=3D -ETIMEDOUT &&
> +	    kfd_mes_wait_retired(dqm, q, KFD_MES_REMOVE_GRACE_MS)) {
> +		dev_warn(adev->dev,
> +			 "MES confirmed REMOVE_QUEUE late, doorbell=3D0x%x\n",
> +			 q->properties.doorbell_off);
> +		return 0;
> +	}
> +
>  	/* If is_for_reset set, it is a mes internal cleanup */
> -	if (!r || is_for_reset)
> +	if (is_for_reset || r =3D=3D -EIO)
>  		return r;

[Severity: High]
Does the is_for_reset path still ignore failures of the remove-after-reset
command and skip kfd_mes_fence() on a timeout?

Returning early on is_for_reset skips kfd_mes_fence(dqm, q) when the
remove-after-reset command times out, and the only caller passing
is_for_reset =3D true ignores the return value:

drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c:reset_queue_mes() {
    ...
	/* Proceed remove_queue with reset=3Dtrue */
	remove_queue_mes_on_reset_option(dqm, q, &pdd->qpd, true, true);
	set_queue_as_reset(dqm, q, &pdd->qpd, true);
	return 0;
}

When the remove-after-reset command fails or times out, reset_queue_mes()
still marks the queue as is_reset =3D true and returns 0 to
amdgpu_gfx_reset_mes_compute(), leaving q->mes_state as
KFD_MES_QUEUE_UNKNOWN, skipping GPU reset recovery, and allowing further
MES commands to be queued behind an unanswered command.

> =20
>  	/* remove_hw_queue failure indicates a queue hang. reset the queue */
>  	r =3D reset_queues_mes(dqm, q);
> -	if (r && amdgpu_gpu_recovery) {
> -		dev_err(adev->dev, "failed to remove queue from MES, doorbell=3D0x%x\n=
",
> -			q->properties.doorbell_off);
> -		dev_err(adev->dev, "MES might be in unrecoverable state, issue a GPU r=
eset\n");
> -		kfd_hws_hang(dqm);
> +
> +	/* The recovery dealt with other queues and left this one in MES */
> +	if (!r && !kfd_mes_queue_retired(dqm, q))
> +		r =3D __remove_queue_mes(dqm, q, false);
> +
> +	if (r) {
> +		if (r =3D=3D -ETIMEDOUT ||
> +		    (q->mes_ticket.valid &&
> +		     amdgpu_mes_ticket_poll(adev, &q->mes_ticket) =3D=3D
> +		     AMDGPU_MES_TICKET_PENDING))
> +			kfd_mes_fence(dqm, q);
> +
> +		if (amdgpu_gpu_recovery) {
> +			dev_err(adev->dev, "failed to remove queue from MES, doorbell=3D0x%x\=
n",
> +				q->properties.doorbell_off);
> +			dev_err(adev->dev, "MES might be in unrecoverable state, issue a GPU =
reset\n");
> +			kfd_hws_hang(dqm);
> +		}
>  	}
> =20
>  	return r;

[Severity: Medium]
When __remove_queue_mes() returns -ETIMEDOUT and kfd_mes_wait_retired()
returns false with q->mes_ticket still AMDGPU_MES_TICKET_PENDING (or
because amdgpu_in_reset() is true), shouldn't this fence MES and skip
reset_queues_mes()?

Calling reset_queues_mes() behind an unanswered REMOVE_QUEUE submits up to
three more MES commands (suspend, detect_and_reset, and resume) to the same
stalled ring before kfd_mes_fence() is reached, adding up to 6.3 seconds of
udelay polling under dqm_lock and blocking amdgpu_amdkfd_pre_reset().

> @@ -484,8 +686,24 @@ static int reset_queues_mes(struct device_queue_mana=
ger *dqm, struct queue *q)
>  	queue_input.xcc_id =3D ffs(dqm->dev->xcc_mask) - 1;
>  	/* pass the known bad queue info to the reset function */
>  	r =3D amdgpu_gfx_reset_mes_compute(adev, dqm->dev->xcp, NULL, NULL, NUL=
L, &num_hung, &queue_input);

[Severity: Medium]
Should queue_input in reset_queues_mes() also populate
gang_context_array_index and ticket like __remove_queue_mes() does?

When num_hung =3D=3D 0, amdgpu_gfx_reset_mes_compute() passes queue_input to
adev->mes.funcs->remove_hw_queue().  Without setting
queue_input.gang_context_array_index =3D q->gang_ctx_array_index and
queue_input.ticket =3D &q->mes_ticket, MES v11 with use_rs64mem receives a
gang context index of 0, and if that removal times out the writeback slot
is freed early while the command is still in flight and q->mes_ticket is
left untracked.

> -	if (r)
> +	if (r) {
> +		/* The REMOVE_QUEUE for @q may have been sent and lost */
> +		if (q->mes_state =3D=3D KFD_MES_QUEUE_MAPPED)
> +			q->mes_state =3D KFD_MES_QUEUE_UNKNOWN;
>  		goto fail;
> +	}
> +
> +	/*
> +	 * With no hung queue reported, amdgpu_gfx_reset_mes_compute() sent
> +	 * the REMOVE_QUEUE for @q itself and MES confirmed it. MES handles
> +	 * its ring in order, so an earlier unanswered REMOVE_QUEUE for @q
> +	 * has been dealt with as well and its status slot can go.
> +	 */
> +	if (!num_hung) {
> +		amdgpu_mes_ticket_release(adev, &q->mes_ticket);
> +		q->mes_state =3D KFD_MES_QUEUE_UNMAPPED;
> +	}

[Severity: High]
What happens if a timed-out REMOVE_QUEUE in the MES ring completes after
kfd_mes_wait_retired() gives up, right before the SUSPEND command sent by
amdgpu_gfx_reset_mes_compute()?

Because MES processes its ring in order, it executes the pending
REMOVE_QUEUE (removing q and marking q->mes_ticket done) and then completes
amdgpu_mes_suspend() with num_hung =3D=3D 0.  amdgpu_gfx_reset_mes_compute()
then unconditionally calls remove_hw_queue() for queue_input a second time:

drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c:amdgpu_gfx_reset_mes_compute() {
    ...
	if (!num_hung && queue_input && !ring) {
		if (!down_read_trylock(&adev->reset_domain->sem)) {
			r =3D -EIO;
			goto out;
		}
		amdgpu_mes_lock(&adev->mes);
		r =3D adev->mes.funcs->remove_hw_queue(&adev->mes, queue_input);
		amdgpu_mes_unlock(&adev->mes);
		up_read(&adev->reset_domain->sem);
	}
    ...
}

MES rejects that duplicate removal with -EREMOTEIO, reset_queues_mes()
takes the error path without checking kfd_mes_queue_retired(), and
remove_queue_mes_on_reset_option() triggers a full GPU reset via
kfd_hws_hang() for a queue removal that actually succeeded.  Similarly, in
__remove_queue_mes(), if an earlier ticket transitioned to
AMDGPU_MES_TICKET_DONE after the caller's kfd_mes_queue_retired() check,
__remove_queue_mes() releases the completed ticket and sends a duplicate
REMOVE_QUEUE instead of retiring the queue.

[Severity: High]
Should the post-recovery removal when num_hung > 0 and !kfd_mes_queue_retir=
ed()
 happen inside reset_queues_mes() (or in kfd_dqm_suspend_bad_queue_mes())
rather than only in remove_queue_mes_on_reset_option()?

When kfd_dqm_suspend_bad_queue_mes() calls reset_queues_mes(dqm, q) and MES
reports other queues as hung (num_hung > 0), amdgpu_gfx_reset_mes_compute()
resumes the non-hung queues without removing q:

drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c:kfd_dqm_suspend_bad_q=
ueue_mes() {
    ...
		list_for_each_entry(q, &qpd->queues_list, list) {
			if (q->doorbell_id =3D=3D doorbell_id && q->properties.is_active) {
				reset_queues_mes(dqm, q);
				q->properties.is_evicted =3D true;
				q->properties.is_active =3D false;
				decrement_queue_count(dqm, qpd, q);
				break;
			}
		}
    ...
}

kfd_dqm_suspend_bad_queue_mes() then clears q->properties.is_active =3D fal=
se
while q remains mapped in MES (q->mes_state =3D=3D KFD_MES_QUEUE_MAPPED), a=
nd
remove_all_kfd_queues_mes() later skips it because it gates
remove_queue_mes() on q->properties.is_active instead of
!kfd_mes_queue_retired(dqm, q).

> @@ -1147,6 +1365,15 @@ static int update_queue_locked(struct device_queue=
_manager *dqm, struct queue *q
>  	/* Save the activity state for queue removal. */
>  	prev_active =3D q->properties.is_active;
> =20
> +	/*
> +	 * The queue is inactive but MES has not confirmed its removal, so
> +	 * MES may still read and write the MQD. Leave it alone.
> +	 */
> +	if (!prev_active && !kfd_mes_queue_retired(dqm, q)) {
> +		retval =3D -EBUSY;
> +		return retval;
> +	}
> +
>  	/* Make sure the queue is unmapped before updating the MQD */
>  	if (dqm->sched_policy !=3D KFD_SCHED_POLICY_NO_HWS) {
>  		if (!dqm->dev->kfd->shared_resources.enable_mes)

[Severity: High]
This problem wasn't introduced by this patch, but in update_queue_locked()
[1], pdd->has_reset_queue is checked only after unmapping dynamic
queues or calling remove_queue_mes():

drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c:update_queue_locked()=
 {
    ...
	if (dqm->sched_policy !=3D KFD_SCHED_POLICY_NO_HWS) {
		if (!dqm->dev->kfd->shared_resources.enable_mes)
			retval =3D unmap_queues_cpsch(dqm,
						    KFD_UNMAP_QUEUES_FILTER_DYNAMIC_QUEUES, 0, USE_DEFAULT_GRACE_PERI=
OD, false);
		else if (prev_active)
			retval =3D remove_queue_mes(dqm, q, &pdd->qpd);

		/* queue is reset so inaccessable  */
		if (pdd->has_reset_queue) {
			return -EACCES;
		}
    ...
}

When pdd->has_reset_queue is set, returning -EACCES before the remapping
step at the bottom of update_queue_locked() leaves all dynamic queues on
the node unmapped on non-MES hardware scheduling, or on MES removes an
unaffected active queue of the same process while leaving
q->properties.is_active and dqm->active_queue_count set.

[1] https://sashiko.dev/#/bug/linux-39086475-ed69-4a54-b2b8-be02a185935b

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261124143433.4973=
6-1-zappel@simple-co.de?part=3D3
