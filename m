Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C448606A321
	for <amd-gfx@archiver.kernel.org>; Tue, 24 Nov 2026 16:31:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Axi8Z3Gk
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8F51B10F7A8;
	Tue, 24 Nov 2026 16:31:07 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 084BD10F7A8
 for <amd-gfx@lists.freedesktop.org>; Tue, 24 Nov 2026 16:31:01 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 45ACE6279B;
 Tue, 24 Nov 2026 16:31:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8E241F000E1;
 Tue, 24 Nov 2026 16:30:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795537859;
 bh=yQWv9fnzHkkitxi3WEUt8lLBqUuyJ0lUoEXwu+Ybv5I=;
 h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
 b=Axi8Z3GkySzt71VcdD5CDafbzm/yI+kRW0wh+ZvdoVGY0hlo91LBMy+Rz40fPivqj
 klwEgufU5AwnCGz3KpdaL8pCtii71hwx07BWb5ECCR8og6hlFbI61Syqh/7aYTGNuP
 xyOd5xGADVWx5tgA3Y7AYMQdf8PmqACxezY9MCNXZHwgj4eJSZMjAOeinBqEFvVPD7
 VHSvCVISnh2WTXrVr4LpprJGbZXCUxXH1YUXT2TdeopNCV8GLhZnrj30d/pnWZ60Y8
 GvSoliYkEAb6eqMh2C/j0TX1F90wcgi+7tuGmq6B055ARz6Az7XTkrU+vJjWK5mO1P
 Tx6nMJYqFhtkA==
Message-ID: <sashiko-outbox-231572@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1 6/9] drm/amdkfd: keep eviction and restore consistent
 when MES fails
To: "Armas Spann" <zappel@simple-co.de>, amd-gfx@lists.freedesktop.org
In-Reply-To: <20261124143433.49736-7-zappel@simple-co.de>
References: <20261124143433.49736-1-zappel@simple-co.de>
 <20261124143433.49736-7-zappel@simple-co.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 24 Nov 2026 16:30:58 +0000
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
- [High] drm/amdkfd: partial failure in restore_process_queues_cpsch()
  breaks eviction
- [High] drm/amdkfd: kfd_process_evict_queues() overwrites -EIO across
  multiple PDDs
- [Medium] drm/amdkfd: restore_process_queues_cpsch() misses GFX11
  oversubscription work
--

commit 96e422e9089ef50f901d8f75facedb9f1a4d5c7f
Author: Armas Spann <zappel@simple-co.de>

drm/amdkfd: keep eviction and restore consistent when MES fails

This commit continues evicting remaining process queues when
remove_queue_mes() fails and returns -EIO, and defers marking queues active
in restore_process_queues_cpsch() until add_queue_mes() succeeds while
skipping already-active queues on retry.

> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c b/driv=
ers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
> index 0d40053b34c88..dbbc6c0794ed3 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
> @@ -1900,11 +1900,24 @@ static int evict_process_queues_cpsch(struct devi=
ce_queue_manager *dqm,
>  		decrement_queue_count(dqm, qpd, q);
> =20
>  		if (dqm->dev->kfd->shared_resources.enable_mes) {
> -			retval =3D remove_queue_mes(dqm, q, qpd);
> -			if (retval) {
> -				dev_err(dev, "Failed to evict queue %d\n",
> -					q->properties.queue_id);
> -				goto out;
> +			int r =3D remove_queue_mes(dqm, q, qpd);
> +
> +			if (r) {
> +				/*
> +				 * -EIO means a GPU reset is under way or MES
> +				 * is fenced off, both reported already.
> +				 */
> +				if (r !=3D -EIO)
> +					dev_err(dev, "Failed to evict queue %d\n",
> +						q->properties.queue_id);
> +				/*
> +				 * Keep going so that every queue ends up in
> +				 * the evicted state. The caller treats -EIO
> +				 * as evicted, not to be added back. MES may
> +				 * still use this MQD, so it stays pinned.
> +				 */
> +				retval =3D -EIO;
> +				continue;
>  			}
>  		}

[Severity: High]
Can kfd_process_evict_queues() lose this -EIO return value when a process
spans multiple PDDs?

In kfd_process_evict_queues(), a single variable r is overwritten on each
PDD iteration:

drivers/gpu/drm/amd/amdkfd/kfd_process.c:kfd_process_evict_queues() {
    ...
	for (i =3D 0; i < p->n_pdds; i++) {
		...
		r =3D pdd->dev->dqm->ops.evict_process_queues(pdd->dev->dqm,
							    &pdd->qpd);
		if (r && r !=3D -EIO) {
			dev_err(dev, "Failed to evict process queues\n");
			goto fail;
		}
		n_evicted++;
	}

	return r;
}

When remove_queue_mes() fails on an earlier PDD and returns -EIO, the loop
continues and a later PDD that succeeds overwrites r with 0.
evict_process_worker() then sees a successful return, signals the eviction
fence while the unremoved queue on the earlier PDD may still be active in
MES, and schedules p->restore_work.

> @@ -2114,13 +2127,15 @@ static int restore_process_queues_cpsch(struct de=
vice_queue_manager *dqm,
>  		if (!QUEUE_IS_ACTIVE(q->properties))
>  			continue;
> =20
> -		q->properties.is_active =3D true;
> -		increment_queue_count(dqm, &pdd->qpd, q);
> +		/* Restored by an earlier attempt that failed further down */
> +		if (q->properties.is_active)
> +			continue;
> =20
>  		retval =3D dqm_repin_mqd_bo(dqm, q);
>  		if (retval) {
>  			dev_err(dev, "Failed to repin MQD for queue %d\n",
>  				q->properties.queue_id);
> +			q->properties.is_evicted =3D true;
>  			goto out;
>  		}
> =20
> @@ -2129,9 +2144,14 @@ static int restore_process_queues_cpsch(struct dev=
ice_queue_manager *dqm,
>  			if (retval) {
>  				dev_err(dev, "Failed to restore queue %d\n",
>  					q->properties.queue_id);
> +				q->properties.is_evicted =3D true;
>  				goto out;
>  			}
>  		}
> +
> +		/* Count the queue as active only once MES has taken it */
> +		q->properties.is_active =3D true;
> +		increment_queue_count(dqm, &pdd->qpd, q);
>  	}
>  	if (!dqm->dev->kfd->shared_resources.enable_mes)
>  		retval =3D execute_queues_cpsch(dqm,

[Severity: High]
If dqm_repin_mqd_bo() or add_queue_mes() fails after earlier queues in
qpd->queues_list have already been restored, does jumping to out with
qpd->evicted still set to 1 prevent those active queues from being evicted?

The queues restored before the failure are now running in MES with
is_active =3D true and is_evicted =3D false.  Because qpd->evicted remains =
1, a
subsequent evict_process_queues_cpsch() hits "if (qpd->evicted++ > 0) goto
out;" and returns 0 without removing the running queues from MES or flushing
the TLB.  With qpd->evicted now bumped to 2, the next
restore_process_queues_cpsch() retry only decrements qpd->evicted back to 1
and exits without restoring the remaining queues.

[Severity: Medium]
Does moving increment_queue_count() after add_queue_mes() skip scheduling
dqm->notify_unmap_work on GFX11 when the restored queue is the one that
crosses the oversubscription threshold?

add_queue_mes() checks dqm->active_cp_queue_count > get_cp_queues_num(dqm)
before returning.  Because increment_queue_count() has not been called yet,
the final restored compute queue that brings active_cp_queue_count to
get_cp_queues_num(dqm) + 1 is not counted during that check, leaving
dqm->notify_unmap_work unscheduled.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261124143433.4973=
6-1-zappel@simple-co.de?part=3D6
