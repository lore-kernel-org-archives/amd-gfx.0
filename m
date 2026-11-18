Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09B50606A31C
	for <amd-gfx@archiver.kernel.org>; Wed, 18 Nov 2026 22:54:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bZF8sAkP
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9C02A10E1C6;
	Wed, 18 Nov 2026 22:54:13 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C421210E1C6
 for <amd-gfx@lists.freedesktop.org>; Wed, 18 Nov 2026 22:54:07 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 48FF84025A;
 Wed, 18 Nov 2026 22:54:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04F2A1F000C4;
 Wed, 18 Nov 2026 22:54:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795042447;
 bh=9waeMMyKWtBiNM5tX0gvNt3f1+uAfUMKy1jx+f//hto=;
 h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
 b=bZF8sAkPP7qjULWi9IhMaF5E2SK2D/97M2cjEtEcRYPW2PsgC1JafsSWLoIe4d05u
 DEhF7DHbK8fC55rnld1DScSxOoMSIRVNq8fDxLFqBnXz/f6bmzSRQqGufbf7rv1Vf1
 /ju717G+R4iGVSv8o2p9dULVLNWml/xG5VqYw6bM6CqtNFpnwbkklLLYiul0drmv0M
 mxiHQ2PAANtdtF+qBqsohTfviC8NGweLelQZqHFHrir5GF7qDx4lulDhrZkKrVh8zI
 FjC8/dmYVG3KZ39tEGGoxFaEE0/eYUabqo68IUv69xJ2HRDddMR2hShW1k7nKHJjh8
 Xv7eDb3ma/l1Q==
Message-ID: <sashiko-outbox-222131@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 08/11] drm/amdgpu/userq: add handling for set_gang
To: "Alex Deucher" <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
In-Reply-To: <20261118223712.2518580-8-alexander.deucher@amd.com>
References: <20261118223712.2518580-1-alexander.deucher@amd.com>
 <20261118223712.2518580-8-alexander.deucher@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 18 Nov 2026 22:54:06 +0000
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
- [Medium] drm/amdgpu/userq: missing reset_domain lock in
  amdgpu_userq_set_gang_helper()
- [Medium] drm/amdgpu/userq: invalid set_gang call in
  amdgpu_userq_post_reset()
--

commit c119a0781eef4bb00ce5e6c3043c15d765972cac
Author: Alex Deucher <alexander.deucher@amd.com>

drm/amdgpu/userq: add handling for set_gang

This commit adds gang primary/secondary pointers to struct
amdgpu_usermode_queue and introduces amdgpu_userq_set_gang_helper() to
re-establish queue gangs during user queue restore, resume, and post-reset
recovery.

> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/=
amd/amdgpu/amdgpu_userq.c
> index ed6f3b67e8720..3afd17af28548 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> @@ -303,6 +303,27 @@ static bool amdgpu_userq_buffer_vas_mapped(struct am=
dgpu_usermode_queue *queue)
>  	return true;
>  }
> =20
> +static int amdgpu_userq_set_gang_helper(struct amdgpu_usermode_queue *qu=
eue)
> +{
> +	struct amdgpu_usermode_queue *secondary_queue =3D queue->gang_secondary;
> +	struct amdgpu_userq_mgr *uq_mgr =3D queue->userq_mgr;
> +	struct amdgpu_device *adev =3D uq_mgr->adev;
> +	const struct amdgpu_userq_funcs *userq_funcs =3D
> +		adev->userq_funcs[queue->queue_type];
> +	int r;
> +
> +	if (secondary_queue &&
> +	    (queue->state =3D=3D AMDGPU_USERQ_STATE_MAPPED ||
> +	     queue->state =3D=3D AMDGPU_USERQ_STATE_PREEMPTED) &&
> +	    (secondary_queue->state =3D=3D AMDGPU_USERQ_STATE_MAPPED ||
> +	     secondary_queue->state =3D=3D AMDGPU_USERQ_STATE_PREEMPTED)) {
> +		r =3D userq_funcs->set_gang(queue, secondary_queue);
> +		if (r)
> +			return r;
> +	}
> +	return 0;
> +}
> +
>  static int amdgpu_userq_preempt_helper(struct amdgpu_usermode_queue *que=
ue)
>  {
>  	struct amdgpu_userq_mgr *uq_mgr =3D queue->userq_mgr;
> @@ -968,6 +989,11 @@ amdgpu_userq_restore_all(struct amdgpu_userq_mgr *uq=
_mgr)
>  		if (r)
>  			ret =3D r;
>  	}
> +	xa_for_each(&uq_mgr->userq_xa, queue_id, queue) {
> +		r =3D amdgpu_userq_set_gang_helper(queue);
> +		if (r)
> +			ret =3D r;
> +	}
>  	mutex_unlock(&uq_mgr->userq_mutex);
> =20
>  	if (ret)
> @@ -1446,6 +1472,13 @@ int amdgpu_userq_resume(struct amdgpu_device *adev)
>  		if (r)
>  			return r;
>  	}
> +	xa_for_each(&adev->userq_doorbell_xa, queue_id, queue) {
> +		uqm =3D queue->userq_mgr;
> +		guard(mutex)(&uqm->userq_mutex);
> +		r =3D amdgpu_userq_set_gang_helper(queue);
> +		if (r)
> +			return r;
> +	}
> =20
>  	return 0;
>  }

[Severity: Medium]
Should callers on the non-reset paths hold a read lock on
adev->reset_domain->sem across amdgpu_userq_set_gang_helper()?

In amdgpu_userq_restore_all() and amdgpu_userq_resume(), the first loop cal=
ls
amdgpu_userq_map_helper(), which takes and releases adev->reset_domain->sem
per queue:

drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c:amdgpu_userq_map_helper() {
    ...
	/* The reset changes the queue state and the MES is unusable meanwhile */
	guard(rwsem_read)(&adev->reset_domain->sem);
    ...
}

When the second loop calls amdgpu_userq_set_gang_helper(),
adev->reset_domain->sem is no longer held.  If a GPU reset starts between t=
he
two loops, amdgpu_userq_pre_reset() and amdgpu_userq_post_reset() mutate
queue->state, secondary_queue->state, and gang_ctx_array_index under the
write side of adev->reset_domain->sem without taking uq_mgr->userq_mutex:

kworker (uq_mgr->resume_work)     GPU reset thread
amdgpu_userq_restore_all()
  mutex_lock(&uq_mgr->userq_mutex)
  amdgpu_userq_map_helper(queue)
    down_read(&reset_domain->sem)
    ...
    up_read(&reset_domain->sem)
                                  down_write(&reset_domain->sem)
                                  amdgpu_userq_pre_reset()
                                    userq_funcs->unmap(queue)
                                    queue->state =3D AMDGPU_USERQ_STATE_HUNG
  amdgpu_userq_set_gang_helper()
    userq_funcs->set_gang()       <-- submits to MES during reset

Calling userq_funcs->set_gang() without adev->reset_domain->sem held also
triggers lockdep_assert_held(&adev->reset_domain->sem) in
amdgpu_device_skip_hw_access() when ringing the MES doorbell.  Note that
amdgpu_userq_post_reset() also calls amdgpu_userq_set_gang_helper() while
already holding adev->reset_domain->sem for write, so taking the read lock
inside amdgpu_userq_set_gang_helper() itself would deadlock the reset path.

> @@ -1591,6 +1624,13 @@ int amdgpu_userq_post_reset(struct amdgpu_device *=
adev, bool vram_lost)
>  			queue->state =3D AMDGPU_USERQ_STATE_MAPPED;
>  		}
>  	}
> +	xa_for_each(&adev->userq_doorbell_xa, queue_id, queue) {
> +		r =3D amdgpu_userq_set_gang_helper(queue);
> +		if (r) {
> +			dev_err(adev->dev, "Failed to gang queue %ld\n", queue_id);
> +			ret =3D r;
> +		}
> +	}
> =20
>  	return ret;
>  }

[Severity: Medium]
Can amdgpu_userq_post_reset() call userq_funcs->set_gang() on queues that w=
ere
not re-added to MES after the reset?

During a GPU reset, amdgpu_userq_pre_reset() only transitions
AMDGPU_USERQ_STATE_MAPPED queues to AMDGPU_USERQ_STATE_HUNG, leaving any
preempted queues in AMDGPU_USERQ_STATE_PREEMPTED while MES hardware state is
wiped.  In amdgpu_userq_post_reset(), the first loop only remaps queues who=
se
state is AMDGPU_USERQ_STATE_HUNG when !vram_lost.

Because the second loop runs unconditionally (even when vram_lost is true)
and amdgpu_userq_set_gang_helper() accepts queues in
AMDGPU_USERQ_STATE_PREEMPTED, it will issue MES SET_GANG_SUBMIT commands for
preempted queues that have not been mapped in MES after the reset, causing
MES command failures and failing amdgpu_userq_post_reset().

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261118223712.2518=
580-1-alexander.deucher@amd.com?part=3D8
