Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EC4E606A31E
	for <amd-gfx@archiver.kernel.org>; Wed, 25 Nov 2026 03:10:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YatxfzV8
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7E94110E9CF;
	Wed, 25 Nov 2026 03:10:03 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EF39810E9CF
 for <amd-gfx@lists.freedesktop.org>; Wed, 25 Nov 2026 03:09:56 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id C5EC241499;
 Wed, 25 Nov 2026 03:09:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3804A1F000C4;
 Wed, 25 Nov 2026 03:09:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795576196;
 bh=x44bbgzFB6aQnz5rKalkcjmcS+rvCTjemLTC7nlu7FE=;
 h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
 b=YatxfzV8vCjERXcoOcd6+q4QkkPygT5Ku86KGYKiRyjxp+KJ6bttnfS8Lsx3gNOp7
 pkRwgjEqhDwBiaPjHXUqb5HFinSOZKew6kVV/ee+oVRx0OS3tT50i325nNknvecCo9
 UPq5cQBsdBKOLjOKpLtFGt6L6NKOu/q+JjYctPQAxsLeLUUUU4wTJMlVzt6tp2AuOg
 aRXOtXae7od9qAtZtYaCTYEbivm622xIfUsVEzwacZI7AzADbYZoBgweOqMD9REy8q
 Txgk/+eDHnGPpeQE05hLFL/3T57o1JBnL+/m+KvL+3rSUrXGPtjFH+HkLMgFoS8xEh
 qeqBorx9NbPLg==
Message-ID: <sashiko-outbox-232453@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] drm/amdgpu: only save VKMS modeset state if VKMS is
 initialized
To: "Prike Liang" <Prike.Liang@amd.com>, amd-gfx@lists.freedesktop.org
In-Reply-To: <20261125030255.767185-1-Prike.Liang@amd.com>
References: <20261125030255.767185-1-Prike.Liang@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 25 Nov 2026 03:09:55 +0000
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

Thank you for your contribution! Sashiko AI review found no new issues
in this patch, but noticed 1 related pre-existing issue it does not
introduce:
- [High] drm/amdgpu/userq: race allowing resume_work after
  amdgpu_userq_suspend() [1]
--

commit a80bb08812a1d7a481e2390eeabf02bdbae59d10
Author: Prike Liang <Prike.Liang@amd.com>

drm/amdgpu: only save VKMS modeset state if VKMS is initialized

This commit introduces amdgpu_device_has_vkms() to verify that both
enable_virtual_display and mode_config_initialized are set before saving
and restoring VKMS modeset state during device suspend and resume.

> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm=
/amd/amdgpu/amdgpu_device.c
> index 7cf3a4cbac27c..9b0ef3ab5f53a 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c

[ ... ]

> @@ -4605,7 +4615,7 @@ int amdgpu_device_suspend(struct drm_device *dev, b=
ool notify_clients)
>  	amdgpu_ras_suspend(adev);
> =20
>  	/* VKMS modeset state is saved here, never from the reset path */
> -	if (adev->enable_virtual_display) {
> +	if (amdgpu_device_has_vkms(adev)) {
>  		r =3D drm_mode_config_helper_suspend(dev);
>  		if (r)
>  			goto unwind_smartshift;

[Severity: High]
This problem wasn't introduced by this patch, but can amdgpu_device_suspend=
()
leave uqm->resume_work scheduled after amdgpu_userq_suspend() returns
[1]?

During system suspend, amdgpu_userq_suspend() can race with
amdgpu_eviction_fence_suspend_worker():

kworker                                   CPU0
amdgpu_eviction_fence_suspend_worker()
  mutex_lock(&uq_mgr->userq_mutex)
  ...
  dma_fence_signal(ev_fence)
                                          amdgpu_device_prepare()
                                          amdgpu_device_suspend()
                                            amdgpu_userq_suspend()
                                              cancel_delayed_work_sync(
                                                &uqm->resume_work)
  schedule_delayed_work(
    &uq_mgr->resume_work, 0)
  mutex_unlock(&uq_mgr->userq_mutex)
                                              guard(mutex)(&uqm->userq_mute=
x)
                                              amdgpu_userq_unmap_helper()
                                            ...
amdgpu_userq_restore_worker()  <-- runs on suspended GPU

amdgpu_eviction_fence_suspend_worker() signals ev_fence before queuing
resume_work and releasing userq_mutex, while amdgpu_userq_suspend() calls
cancel_delayed_work_sync(&uqm->resume_work) before taking userq_mutex and
without flushing evf_mgr->suspend_work.

In addition, amdgpu_device_suspend() calls amdgpu_userq_suspend() before
amdgpu_device_evict_resources():

drivers/gpu/drm/amd/amdgpu/amdgpu_device.c:amdgpu_device_suspend() {
	...
	r =3D amdgpu_userq_suspend(adev);
	if (r)
		goto unwind_ip_phase1;

	r =3D amdgpu_device_evict_resources(adev);
	if (r)
		goto unwind_userq;
	...
}

If ev_fence is still unsignaled at that point, evicting resources triggers
evf_mgr->suspend_work, which schedules uqm->resume_work after
amdgpu_userq_suspend() has already finished.

In either case, amdgpu_userq_restore_worker() can run after TTM buffer
functions, fence drivers and GPU IP blocks are suspended, causing failed
page table updates, MES command timeouts or hardware access to a suspended
device.

[1] https://sashiko.dev/#/bug/linux-f4cce3e7-09c5-44f6-b753-c17f5780e3fb

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261125030255.7671=
85-1-Prike.Liang@amd.com?part=3D1
