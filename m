Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D22B606A32A
	for <amd-gfx@archiver.kernel.org>; Tue, 24 Nov 2026 16:15:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RuO55Kyt
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0C7DF10F76A;
	Tue, 24 Nov 2026 16:15:08 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B377310F76A
 for <amd-gfx@lists.freedesktop.org>; Tue, 24 Nov 2026 16:15:01 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id DB2386134A;
 Tue, 24 Nov 2026 16:15:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79FEA1F000CA;
 Tue, 24 Nov 2026 16:15:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795536900;
 bh=o/2fxLCDqK7X86JBxbAdXYegNrB2Rq1q7MmwQq73sxU=;
 h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
 b=RuO55KytiQQdrUsVmkssavsoSgLCtwx9WdH8y6iJCiMVaeYdWD+pjDyOwm6dmwz5g
 K13abfjhEFQl7TalwzmwF1A7GnsXLg++cZOoBAfg9NWjAUS1Z8CRy8Fc6V3LBN6f1Z
 z7zfcV6NNf1vDOuCgNXMC8yCKdvSngt7M6EXvHlI04VshL8UvNOLbPq87sP3u8dYdB
 S0zA15RPVp9fiDcfsIq3QQXrLvFiSveA721fAgADXLZgMUI07UaAN7ROTGvu/yj6JL
 CUGcKU+g0Y4ybhTMZSJTnVemsG8EEKwP7KE7UN75O188VML0iiEYKcHeaqf3IHHFQY
 Lr2z/W59Up8xg==
Message-ID: <sashiko-outbox-231538@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2] drm/amdgpu/userq: queue the restore worker on a
 freezable workqueue
To: "Arisa Snowbell" <arisa.snowbell@gmail.com>, amd-gfx@lists.freedesktop.org
In-Reply-To: <20261124130258.1270242-1-arisa.snowbell@gmail.com>
References: <cover.1795482456.git.arisa.snowbell@gmail.com>
 <20261124130258.1270242-1-arisa.snowbell@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 24 Nov 2026 16:14:59 +0000
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

Thank you for your contribution! Sashiko AI review found 1 potential
issue to consider:
- [High] drm/amdgpu/userq: canceled resume_work leaves VM unvalidated in
  amdgpu_userq_resume()
--

commit 5bc8d4302fb0871c6ac59bea95139558edabb658
Author: Arisa Snowbell <arisa.snowbell@gmail.com>

drm/amdgpu/userq: queue the restore worker on a freezable workqueue

This commit moves the userqueue restore worker from system_wq to
system_freezable_wq so it does not run concurrently with VRAM BO eviction
during amdgpu_device_prepare().

> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_eviction_fence.c b/drivers=
/gpu/drm/amd/amdgpu/amdgpu_eviction_fence.c
> index 2924f34da316a..358a6c8ce45f5 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_eviction_fence.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_eviction_fence.c
> @@ -91,7 +91,7 @@ amdgpu_eviction_fence_suspend_worker(struct work_struct=
 *work)
>  	dma_fence_put(ev_fence);
> =20
>  	if (!evf_mgr->shutdown)
> -		schedule_delayed_work(&uq_mgr->resume_work, 0);
> +		queue_delayed_work(system_freezable_wq, &uq_mgr->resume_work, 0);
> =20
>  	mutex_unlock(&uq_mgr->userq_mutex);
>  }

[Severity: High]
Does canceling uq_mgr->resume_work in amdgpu_userq_suspend() leave the
process's VM unvalidated and its eviction fence signaled on resume?

When amdgpu_device_prepare() evicts VRAM BOs,
amdgpu_eviction_fence_suspend_worker() unmaps the user queues, signals
ev_fence, and queues uq_mgr->resume_work on system_freezable_wq.  Because
system_freezable_wq is already frozen, uq_mgr->resume_work stays pending
while the remaining BOs (including vm->root.bo and page tables) are
evicted, and amdgpu_userq_suspend() then cancels it:

drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c:amdgpu_userq_suspend() {
    ...
	xa_for_each(&adev->userq_doorbell_xa, queue_id, queue) {
		uqm =3D queue->userq_mgr;
		cancel_delayed_work_sync(&uqm->resume_work);
    ...
}

On resume, amdgpu_userq_resume() never re-queues uqm->resume_work or
calls amdgpu_userq_vm_validate_and_restore_queue():

drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c:amdgpu_userq_resume() {
    ...
	xa_for_each(&adev->userq_doorbell_xa, queue_id, queue) {
		uqm =3D queue->userq_mgr;
		guard(mutex)(&uqm->userq_mutex);
		if (adev->in_s0ix)
			r =3D amdgpu_userq_restore_helper(queue);
		else
			r =3D amdgpu_userq_map_helper(queue);
    ...
}

For S3 and S4, amdgpu_userq_map_helper() maps the queue in MES while the
VM BOs and page tables are still evicted and ev_fence remains signaled,
causing GPU page faults or MES mapping failures.  In addition, because
amdgpu_userq_map_helper() sets queue->state to AMDGPU_USERQ_STATE_MAPPED,
a later resume_work run that moves vm->root.bo back to VRAM will see
queue->state !=3D AMDGPU_USERQ_STATE_UNMAPPED and skip updating MES with
the new page table base address.  For dGPU S0ix, queue->state was already
set to AMDGPU_USERQ_STATE_UNMAPPED during amdgpu_device_prepare(), so
amdgpu_userq_restore_helper() (which only restores
AMDGPU_USERQ_STATE_PREEMPTED queues) is a no-op and the queue stays
unmapped.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261124130258.1270=
242-1-arisa.snowbell@gmail.com?part=3D1
