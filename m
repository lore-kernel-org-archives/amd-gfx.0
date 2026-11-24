Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82E8B606A33B
	for <amd-gfx@archiver.kernel.org>; Tue, 24 Nov 2026 16:54:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KjS84O5P
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 03E7B10E18F;
	Tue, 24 Nov 2026 16:54:05 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id ECDCA10E18F
 for <amd-gfx@lists.freedesktop.org>; Tue, 24 Nov 2026 16:53:57 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 64826627BD;
 Tue, 24 Nov 2026 16:53:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D79611F0089E;
 Tue, 24 Nov 2026 16:53:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795539237;
 bh=g2j6NfCJqbY0VruMqCij0lYaBGL+ho6+YnrkuYh/5ko=;
 h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
 b=KjS84O5PIyJsL1+W7Nab+CPsKuqYOxrL1LCDdHHV5kHmUlSldRI0MZFHSKBWTfQeY
 wXnWo2iLU/7yItgHcKcRCQDYAWvh6nNS6jwaVBZJYaO2XHi5a5VTbv/ckxqAMd+rSy
 uNG0NbGxGml8zBzIwNHBbOpebb55aHwNp7jsv94jE1XmrMBSRPtDP4WCNoDI+MOG55
 Q6WteFaXdyINLyDJLiUIwHdr6T5MdeMTogT74hnL0J/1VJ6P2EKATtJ+p7MeOq/r/Z
 JS7GSsYFsGEsBNpi9nNx7m++X0ueFqj0IuOUSGSO3QKkfN0BPKKDZ2iRQAnqqPV7Uv
 73pNGPubnS97w==
Message-ID: <sashiko-outbox-231614@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1 8/9] drm/amdkfd: reconcile queue state with MES after
 a restart
To: "Armas Spann" <zappel@simple-co.de>, amd-gfx@lists.freedesktop.org
In-Reply-To: <20261124143433.49736-9-zappel@simple-co.de>
References: <20261124143433.49736-1-zappel@simple-co.de>
 <20261124143433.49736-9-zappel@simple-co.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 24 Nov 2026 16:53:56 +0000
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

Thank you for your contribution! Sashiko AI review found 3 potential
issues to consider:
- [High] drm/amdkfd: set_queue_as_reset() clears is_active before MES
  reconciliation
- [Medium] drm/amdkfd: kfd_dqm_reconcile_mes_queues() skips active
  unmapped queues
- [Medium] drm/amdkfd: incomplete process eviction in
  kfd_dqm_reconcile_mes_queues()
--

commit 57ed11ff8b41067e05295c9b1d33b02e617c5472
Author: Armas Spann <zappel@simple-co.de>

drm/amdkfd: reconcile queue state with MES after a restart

This commit adds kfd_dqm_reconcile_mes_queues() to start_cpsch() to drop
stale MES queue state, release lost command tickets, and mark active queues
and their processes evicted after an MES firmware restart.

> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c b/driv=
ers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
> index 1c348f36cd3c3..f008b05e95993 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
> @@ -2649,6 +2649,74 @@ static int init_dequeue_wait_counts_mes(struct dev=
ice_queue_manager *dqm)
>  	return 0;
>  }
> =20
> +/*
> + * Bring the queue bookkeeping in line with MES when the scheduler start=
s.
> + *
> + * If the MES firmware was set up from scratch since a queue was added (=
GPU
> + * reset, resume), it has no record of that queue. A GPU reset cannot ev=
ict
> + * cleanly: the REMOVE_QUEUE commands fail with -EIO while the reset is
> + * running, and whatever was not marked inactive at that point stays act=
ive
> + * in the driver. The next REMOVE_QUEUE for such a queue, typically when=
 its
> + * process exits, is rejected by the new firmware instance and that fail=
ure
> + * is escalated to another GPU reset.
> + *
> + * So drop the stale MES state here, and deactivate every queue that the
> + * driver still counts as running although MES has lost it. KFD does not
> + * resume processes after a GPU reset. Such a queue is marked evicted, a=
nd
> + * its process with it, which is the state kgd2kfd_pre_reset() leaves all
> + * the queues in that it did manage to evict. After a system resume
> + * kfd_resume_all_processes() maps the queues again from that state.
> + *
> + * dqm lock held.
> + */
> +static void kfd_dqm_reconcile_mes_queues(struct device_queue_manager *dq=
m)
> +{
> +	struct device *dev =3D dqm->dev->adev->dev;
> +	struct device_process_node *cur;
> +	struct qcm_process_device *qpd;
> +	unsigned int stale =3D 0, active =3D 0;
> +	struct queue *q;
> +
> +	if (!dqm->dev->kfd->shared_resources.enable_mes)
> +		return;
> +
> +	/* A command that got no answer died with the old firmware */
> +	kfd_mes_fenced(dqm);
> +
> +	list_for_each_entry(cur, &dqm->queues, list) {
> +		qpd =3D cur->qpd;
> +		list_for_each_entry(q, &qpd->queues_list, list) {
> +			/* Not in MES, or added to the instance now running */
> +			if (q->mes_state =3D=3D KFD_MES_QUEUE_UNMAPPED ||
> +			    q->mes_fw_gen =3D=3D kfd_mes_gen(dqm))
> +				continue;

[Severity: Medium]
Can skipping queues with q->mes_state =3D=3D KFD_MES_QUEUE_UNMAPPED leave an
unmapped queue marked q->properties.is_active =3D=3D true across stop_cpsch=
() and
start_cpsch()?

When stop_cpsch() calls remove_all_kfd_queues_mes(), remove_queue_mes() tra=
nsitions
any still-active queue to KFD_MES_QUEUE_UNMAPPED without clearing
q->properties.is_active (and add_queue_mes() similarly returns 0 without ma=
pping
into MES while !dqm->sched_running).  Because start_cpsch() does not re-add=
 active
queues when MES is enabled and restore_process_queues_cpsch() skips queues =
whose
q->properties.is_active is true, such a queue is never re-added to MES on r=
esume.

> +
> +			/* Also returns the status slot of a lost command */
> +			kfd_mes_queue_retired(dqm, q);
> +			stale++;
> +
> +			if (!q->properties.is_active)
> +				continue;

[Severity: High]
Does set_queue_as_reset() clear q->properties.is_active before
kfd_dqm_reconcile_mes_queues() runs on a GPU reset, preventing queues and
their qpd from being marked evicted here?

In kgd2kfd_post_reset(), kfd_dqm_set_queues_as_reset() runs before
kfd_resume() -> start_cpsch():

drivers/gpu/drm/amd/amdkfd/kfd_device.c:kgd2kfd_post_reset() {
    ...
	for (i =3D 0; i < kfd->num_nodes; i++)
		kfd_dqm_set_queues_as_reset(kfd->nodes[i]->dqm);

	for (i =3D 0; i < kfd->num_nodes; i++) {
		ret =3D kfd_resume(kfd->nodes[i]);
    ...
}

set_queue_as_reset() clears q->properties.is_active to false without setting
q->properties.is_evicted =3D true or qpd->evicted =3D 1.  When
kfd_dqm_reconcile_mes_queues() then runs, it retires q->mes_state to
KFD_MES_QUEUE_UNMAPPED and hits this !q->properties.is_active check, leaving
any queue or process that kgd2kfd_pre_reset() did not evict (for example,
after an earlier partial restore_process_queues_cpsch() failure left
qpd->evicted =3D=3D 1 with active queues) un-evicted and eligible to be re-=
added
to MES.

> +
> +			q->properties.is_active =3D false;
> +			q->properties.is_evicted =3D true;
> +			decrement_queue_count(dqm, qpd, q);
> +			/* The process stays evicted from here on */
> +			if (!qpd->evicted)
> +				qpd->evicted =3D 1;
> +			active++;
> +		}
> +	}

[Severity: Medium]
When this transitions qpd->evicted from 0 to 1, does it leave inactive
sibling queues on qpd->queues_list with q->properties.is_evicted =3D=3D fal=
se
and leave pdd->last_evict_timestamp unset?

If a process has both a stale active queue and an inactive or suspended
queue (whose mes_state is KFD_MES_QUEUE_UNMAPPED or is_active is false),
only the active queue gets q->properties.is_evicted =3D true while
qpd->evicted becomes 1.  Because QUEUE_IS_ACTIVE(q->properties) checks
!q->properties.is_evicted rather than qpd->evicted, a subsequent
update_queue() or resume_single_queue() on the sibling queue will call
add_queue_mes() while the process is evicted, and a later
restore_process_queues_cpsch() will compute eviction duration from a zero or
stale pdd->last_evict_timestamp.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261124143433.4973=
6-1-zappel@simple-co.de?part=3D8
