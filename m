Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49010606A31C
	for <amd-gfx@archiver.kernel.org>; Thu, 26 Nov 2026 08:36:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UDD6mzXt
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BCF2511215F;
	Thu, 26 Nov 2026 08:36:20 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 730C811215E
 for <amd-gfx@lists.freedesktop.org>; Thu, 26 Nov 2026 08:36:13 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id B31CF61F76;
 Thu, 26 Nov 2026 08:36:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 391F41F000D4;
 Thu, 26 Nov 2026 08:36:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795682172;
 bh=50czPSDjtO/aOJc+cLbFvywG1pota9DWrj+hpEfcAg8=;
 h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
 b=UDD6mzXtdAjuK+8bA8kqNZgOKqkoMCnnYSCXwhZ/BQGkmblH71hHpw/ap5fiAaWwb
 c/vnlnFVOyGUwoCDEegVfPXrCoTpgsmN6BrYFk2EG3moREUGXTQTSQEig08uI+/tXO
 ej1Wkp/ZyDZTjFtJTMwfHwQ9s+RIqSXrEYUifAhJ5LDUyHNCIFJmf+d+UDlmQ6F+MR
 nZGB0Y2FxvGnb9RIjLtl3y5qwsknyBNnckKQLQrUsu1WsOl0il4egLt7A3O73Hun3Z
 DLe6wyuAiDOOA3xemxEhVgyEyGjaEa26LQfsOI3Q8OW+n/t5OeD8tLGtxHtdWgxaTF
 ceka68RLhIGgQ==
Message-ID: <sashiko-outbox-235043@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 6/9] drm/amdkfd: keep eviction and restore consistent
 when MES fails
To: "Armas Spann" <zappel@simple-co.de>, amd-gfx@lists.freedesktop.org
In-Reply-To: <20261125141933.154222-7-zappel@simple-co.de>
References: <20261125141933.154222-1-zappel@simple-co.de>
 <20261125141933.154222-7-zappel@simple-co.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 26 Nov 2026 08:36:11 +0000
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

Thank you for your contribution! Sashiko AI review found 2 potential
issues to consider:
- [Medium] drm/amdkfd: evict_process_queues_cpsch() returns 0 with
  unretired MES queues
- [Medium] drm/amdkfd: missing kfd_flush_tlb() in
  restore_process_queues_cpsch() rollback
--

commit 912d1284460b9827cb7b366431ada4596ab37d25
Author: Armas Spann <zappel@simple-co.de>

drm/amdkfd: keep eviction and restore consistent when MES fails

This commit continues evicting remaining queues when MES queue removal
fails, preserves -EIO across devices in kfd_process_evict_queues(), and
rolls back already-added queues when restore_process_queues_cpsch() fails.

> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c b/driv=
ers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
> index eabb9a6953451..f952880a66657 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c

[ ... ]

> @@ -2227,6 +2243,27 @@ static int restore_process_queues_cpsch(struct dev=
ice_queue_manager *dqm,
>  out:
>  	dqm_unlock(dqm);
>  	return retval;
> +
> +rollback:
> +	/*
> +	 * A half restored process is a problem for the next eviction: it
> +	 * finds qpd->evicted set and leaves the queues restored so far
> +	 * running. Take those off the hardware again, so that the process
> +	 * is fully evicted and the retry starts from a known state. A
> +	 * removal that cannot be sent (-EIO) leaves the queue mapped and
> +	 * marked evicted, as evict_process_queues_cpsch() does.
> +	 */
> +	list_for_each_entry(q, &qpd->queues_list, list) {
> +		q->properties.is_evicted =3D true;
> +		if (!q->properties.is_active)
> +			continue;
> +
> +		q->properties.is_active =3D false;
> +		decrement_queue_count(dqm, qpd, q);
> +		if (dqm->dev->kfd->shared_resources.enable_mes)
> +			remove_queue_mes(dqm, q, qpd);

[Severity: Medium]
If remove_queue_mes() fails with -EIO here (or during an earlier call to
evict_process_queues_cpsch()), can a subsequent eviction return 0 while
unretired queues are still mapped in MES?

When a later queue fails add_queue_mes() (for instance with -ETIMEDOUT,
which fences MES, or -EIO when a reset starts), remove_queue_mes() in this
rollback returns -EIO and leaves the earlier queues mapped in MES with
qpd->evicted still set to 1.  Because restore_process_helper() has already
armed a new eviction fence before calling kfd_process_restore_queues(), a
TTM eviction that runs before the restore retry sees qpd->evicted++ > 0 in
evict_process_queues_cpsch() and returns 0 instead of -EIO:

drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c:evict_process_queues_=
cpsch() {
	dqm_lock(dqm);
	if (qpd->evicted++ > 0) /* already evicted, do nothing */
		goto out;
    ...
}

evict_process_worker() then signals the eviction fence and lets TTM move
or unmap BOs while those unretired queues are still on the hardware.

> +	}
> +	goto out;
>  }

[Severity: Medium]
Does this rollback path also need to call kfd_flush_tlb(pdd) after
removing the already-restored queues from MES?

Queues added earlier in the loop may have started executing and issuing
memory accesses before a later queue failed dqm_repin_mqd_bo() or
add_queue_mes().  MES does not perform a heavyweight TLB flush on queue
removal, and because qpd->evicted stays 1, a subsequent call to
evict_process_queues_cpsch() before the restore retry takes the
qpd->evicted++ > 0 early exit and skips kfd_flush_tlb(pdd) as well,
allowing BOs or SVM ranges to be migrated or freed before in-flight memory
accesses complete.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261125141933.1542=
22-1-zappel@simple-co.de?part=3D6
