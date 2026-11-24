Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00064606A336
	for <amd-gfx@archiver.kernel.org>; Tue, 24 Nov 2026 16:24:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gsC7ausG
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7174F10F7B1;
	Tue, 24 Nov 2026 16:24:06 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 40F6E10E066
 for <amd-gfx@lists.freedesktop.org>; Tue, 24 Nov 2026 16:24:00 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 6957861D82;
 Tue, 24 Nov 2026 16:23:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1FBF1F000E1;
 Tue, 24 Nov 2026 16:23:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795537439;
 bh=Q1rodelk5egNj4vags1p5aUSXvDyQCuyghgIgScqP/I=;
 h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
 b=gsC7ausG3utPAR4UdtsaP8E9AOZ8xwu4hHUIBh94pQtI/jGmS0QrXePAJjx45OvLQ
 gv5Qa6yi9kZAFI8G70q2Z8QRHiAr3vla7SrVUPBgPgGnaPxwOgXRpfatTm7H704tPm
 X565gveG5W7VkaEyc1vtOc1DiKePMMjDsdCLXoO586Zs7bzvEz7GrpEzqI09U6JjyX
 EO8zyGFKgQhJqbNNWTW1FUaiElZVs5Ssg/jptOiApAdLOCXOLHTUqC9PYHx9L4itX4
 kKP1f3P8UzX0HKO5hb90uGtZ3feqDe887ah16+w/TDogyt9+aOnfQrstACtIMdYZKW
 R7HQqessNhvNg==
Message-ID: <sashiko-outbox-231548@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3] drm/amdgpu/userq: keep the restore worker out of
 system sleep
To: "Arisa Snowbell" <arisa.snowbell@gmail.com>, amd-gfx@lists.freedesktop.org
In-Reply-To: <20261124141416.11034-1-arisa.snowbell@gmail.com>
References: <20261124130258.1270242-1-arisa.snowbell@gmail.com>
 <20261124141416.11034-1-arisa.snowbell@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 24 Nov 2026 16:23:58 +0000
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
- [High] drm/amdgpu/userq: system_freezable_wq is not frozen during
  hibernation dpm_prepare()
--

commit f10cd6c65f3801c912d63876fd1a81a692e96c5a
Author: Arisa Snowbell <arisa.snowbell@gmail.com>

drm/amdgpu/userq: keep the restore worker out of system sleep

This commit moves the user queue restore worker (resume_work) to
system_freezable_wq and skips mapping evicted queues in
amdgpu_userq_resume(), queuing the restore worker for them instead.

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
Can uq_mgr->resume_work still run during amdgpu_device_prepare() on the
hibernation (S4) path?

In hibernate(), freeze_processes() passes user_only =3D true to
try_to_freeze_tasks(), which skips freeze_workqueues_begin().
hibernation_snapshot() then calls dpm_prepare(PMSG_FREEZE) before
freeze_kernel_threads() freezes freezable workqueues:

kernel/power/hibernate.c:hibernation_snapshot() {
	...
	error =3D dpm_prepare(PMSG_FREEZE);
	if (error)
		goto Complete;

	/* Preallocate image memory before freezing kernel threads and shutting do=
wn devices. */
	error =3D hibernate_preallocate_memory();
	if (error)
		goto Complete;

	error =3D freeze_kernel_threads();
	...
}

When amdgpu_pmops_prepare() -> amdgpu_device_prepare() ->
amdgpu_device_evict_resources() evicts a user queue BO during hibernation
prepare, system_freezable_wq is not frozen yet, so uq_mgr->resume_work
runs immediately and can still deadlock with ttm_bo_evict_first() on the
BO reservations or move evicted BOs back into VRAM before
freeze_kernel_threads() runs.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261124141416.1103=
4-1-arisa.snowbell@gmail.com?part=3D1
