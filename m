Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27E85606A33A
	for <amd-gfx@archiver.kernel.org>; Mon, 16 Nov 2026 21:13:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=f7lXQhcv
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AFFF910EC54;
	Mon, 16 Nov 2026 21:13:50 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 086C410EC54
 for <amd-gfx@lists.freedesktop.org>; Mon, 16 Nov 2026 21:13:44 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id A93DD41230;
 Mon, 16 Nov 2026 21:13:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65E491F000C4;
 Mon, 16 Nov 2026 21:13:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794863623;
 bh=9B2oPoSZREurFBQ/jIwbDFTIbqS7cYQ6bLMK4IlZFXE=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=f7lXQhcvYAm6/i5pUa4vIaV00IiN8DFObLP9xcSmNKgVudvR3rH0yeLr29iUxnEpP
 IRHE6w7+K5A8UDkvo3YekahhpEGgii9KpMgfeNRnexZdboY+KULi9mvO+tL2vfLhBt
 h3iFFNlYVrLjOY4MiOoNMhg38liQZCcnU2dhH7iZ16uqC5mkB/TNPoFHol7HPpducx
 5hX9tgaMhDu6zvxw1651yimEPj7740TYkaKha2KfoEkf+VVXQbLbY93kgrBMC56go4
 X/dCr/I10QsrHEoHgDT/XswQW0vQrgpACkSXjkKkPLAaBdYurasUUDaOmfDviMfNw7
 uF+rKj5KF8F+g==
Message-ID: <sashiko-outbox-217693@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] drm/amdgpu: drain queued scheduler jobs before suspend
To: "Mario Limonciello" <mario.limonciello@amd.com>
Cc: amd-gfx@lists.freedesktop.org
In-Reply-To: <20261116-superm1-drain-submissions-v1-1-e3ffee977a28@amd.com>
References: <20261116-superm1-drain-submissions-v1-1-e3ffee977a28@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 16 Nov 2026 21:13:42 +0000
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
- [High] drm/amdgpu: deadlock in amdgpu_device_flush_file_entities() on
  suspend
- [Medium] drm/amdgpu: race in amdgpu_device_flush_file_entities()
  before run_job()
--

commit 2d3632cb05b8d04352d9590da3fabb5b096f1b19
Author: Mario Limonciello <mario.limonciello@amd.com>

drm/amdgpu: drain queued scheduler jobs before suspend

This commit adds amdgpu_device_flush_file_entities() to flush the context
and VM scheduler entities of all open DRM files during
amdgpu_device_suspend() before evicting resources.

> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm=
/amd/amdgpu/amdgpu_device.c
> index 19a566187dfb5..d18348116d3f1 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -4538,6 +4538,30 @@ void amdgpu_device_complete(struct drm_device *dev)
>  	}
>  }
> =20
> +/**
> + * amdgpu_device_flush_file_entities - drain scheduler entities of open =
files
> + * @adev: amdgpu device object
> + *
> + * Wait for the scheduler entities owned by all open files (the context
> + * entities used for command submission and the VM entities used for page
> + * table updates) to run out of queued jobs, so that nothing can slip in=
to
> + * the rings after the hardware fences were waited on at suspend time.
> + */
> +static void amdgpu_device_flush_file_entities(struct amdgpu_device *adev)
> +{
> +	struct drm_device *ddev =3D adev_to_drm(adev);
> +	struct drm_file *file;
> +
> +	guard(mutex)(&ddev->filelist_mutex);
> +	list_for_each_entry(file, &ddev->filelist, lhead) {
> +		struct amdgpu_fpriv *fpriv =3D file->driver_priv;
> +
> +		amdgpu_ctx_mgr_entity_flush(&fpriv->ctx_mgr,
> +					    MAX_SCHEDULE_TIMEOUT);
> +		amdgpu_vm_wait_idle(&fpriv->vm, MAX_SCHEDULE_TIMEOUT);
> +	}
> +}

[Severity: Medium]
Can drm_sched_entity_flush() return while the scheduler worker is still in
the middle of popping a job and before sched->ops->run_job() has emitted its
hardware fence?

CPU0 (submit_wq)                  CPU1 (suspend)
drm_sched_run_job_work()
  drm_sched_entity_pop_job()
    spsc_queue_pop(&entity->job_queue)
    drm_sched_rq_pop_entity(entity)
                                  amdgpu_device_suspend()
                                    amdgpu_device_flush_file_entities()
                                      ...
                                        drm_sched_entity_flush()
                                          drm_sched_entity_is_idle() =3D=3D=
 true
                                    amdgpu_device_evict_resources()
                                    amdgpu_fence_driver_hw_fini()
                                      amdgpu_fence_wait_empty()
  sched->ops->run_job(sched_job)
    amdgpu_job_run()
      amdgpu_ib_schedule()
        amdgpu_fence_emit()
        amdgpu_ring_commit()  <-- ring written after fence wait
  complete_all(&entity->entity_idle)

drm_sched_entity_is_idle() reports the entity idle as soon as
spsc_queue_pop() empties entity->job_queue, before drm_sched_run_job_work()
calls sched->ops->run_job() and complete_all(&entity->entity_idle).  On APUs
such as Picasso where amdgpu_device_evict_resources() returns immediately
during S3 suspend, amdgpu_fence_driver_hw_fini() can finish waiting on the
ring before the popped job emits its fence and commits the ring write
pointer, leaving the ring hang on resume window open.

> +
>  /**
>   * amdgpu_device_suspend - initiate device suspend
>   *
> @@ -4587,6 +4611,8 @@ int amdgpu_device_suspend(struct drm_device *dev, b=
ool notify_clients)
>  	if (r)
>  		goto unwind_ip_phase1;
> =20
> +	amdgpu_device_flush_file_entities(adev);

[Severity: High]
Can calling amdgpu_device_flush_file_entities() here deadlock runtime or
system suspend when an entity has a job waiting on an unsignaled dependency?

drivers/gpu/drm/scheduler/sched_entity.c:drm_sched_entity_flush() {
	...
	if (current->flags & PF_EXITING) {
		if (timeout)
			ret =3D wait_event_timeout(
					sched->job_scheduled,
					drm_sched_entity_is_idle(entity),
					timeout);
	} else {
		wait_event_killable(sched->job_scheduled,
				    drm_sched_entity_is_idle(entity));
	}
	...
}

Because the suspend task or runtime PM worker does not have PF_EXITING set,
drm_sched_entity_flush() ignores the timeout and sleeps indefinitely in
wait_event_killable() while holding ddev->filelist_mutex.

In amdgpu_cs_ioctl(), a runtime PM reference is only held during the ioctl
itself, and per-job runtime PM references are only taken in
amdgpu_fence_emit() when a job reaches run_job().  If a client submits a job
with an unsignaled syncobj dependency, runtime autosuspend can enter
amdgpu_pmops_runtime_suspend() -> amdgpu_device_suspend() and block in
amdgpu_device_flush_file_entities() while the device status is
RPM_SUSPENDING.  When another thread or process then calls amdgpu_cs_ioctl()
to submit the work that would signal that syncobj, its runtime PM resume
waits for RPM_SUSPENDING to complete, deadlocking both tasks.

Killing the process owning the blocked entity does not break the wait
either: amdgpu_flush() times out after 2 seconds and calls
drm_sched_entity_kill(), which drains the entity without waking
sched->job_scheduled, and the exiting task then blocks on
ddev->filelist_mutex in drm_close_helper().  During system suspend,
amdgpu_userq_suspend() also runs right before
amdgpu_device_flush_file_entities() and unmaps usermode queues while
userspace is already frozen, so any entity job waiting on a usermode queue
or userspace fence can never make progress.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261116-superm1-dr=
ain-submissions-v1-1-e3ffee977a28@amd.com?part=3D1
