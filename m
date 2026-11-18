Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B57D606A331
	for <amd-gfx@archiver.kernel.org>; Wed, 18 Nov 2026 06:07:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=d2MUH6f/
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A524C10E133;
	Wed, 18 Nov 2026 06:07:11 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C79D110E133
 for <amd-gfx@lists.freedesktop.org>; Wed, 18 Nov 2026 06:07:04 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 4C68161B30;
 Wed, 18 Nov 2026 06:07:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D940A1F000C5;
 Wed, 18 Nov 2026 06:07:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794982024;
 bh=beIPHoR64kSzCpVD9phkqOAxFAcY3oTIzH6xj/S1ytQ=;
 h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
 b=d2MUH6f/b/RcexGxIUsSBCWc2CfYKAAhe1Jqqm7D/EZ22etrCNl41XYmOqhtO93V0
 43MYuiX8jvU8MHC43bNJgmqhhiaNYTaAyuVOQ3MhmzHdt6m6xtzKAeOcXLn665RMuj
 DK7bG+48peLiXD2rkYV0Gol5z1e8AeW3tW0N4hBBCcUP+k5KbUOsZiq8HK0p9s8st1
 mkb3ZOYDxeXsxmgHAaCDtrKdDQWv2eKAf6P6QdUpNkQ+cGAmENUiwTxtgMC1bov4g2
 86a5ePFqmE83G4Nq8395UTGWe46019NWGuNnz+SdpREtKXOtj1Ce7eonqTlMTK3YIn
 NyhrbttM+l+vQ==
Message-ID: <sashiko-outbox-220206@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 3/3] drm/amdkfd: don't keep the debugger pointer when
 DBG_TRAP_ENABLE fails
To: "Jesse Zhang" <Jesse.Zhang@amd.com>, amd-gfx@lists.freedesktop.org
In-Reply-To: <20261118055009.3005630-3-Jesse.Zhang@amd.com>
References: <20261118055009.3005630-1-Jesse.Zhang@amd.com>
 <20261118055009.3005630-3-Jesse.Zhang@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 18 Nov 2026 06:07:03 +0000
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
- [Medium] drm/amdkfd: TOCTOU race on debugger_process in
  kfd_ioctl_set_debug_trap()
--

commit 7ecd0279fcac9bb56764baeea1894a732f3b3ff3
Author: Jesse Zhang <Jesse.Zhang@amd.com>

drm/amdkfd: don't keep the debugger pointer when DBG_TRAP_ENABLE fails

This commit restores target->debugger_process when kfd_dbg_trap_enable()
fails and returns -EALREADY before modifying target->debugger_process if
debugging is already enabled.

> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c b/drivers/gpu/drm/a=
md/amdkfd/kfd_chardev.c
> index 5a7f4f0cd0ce7..9969d48ca6c7f 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
> @@ -3226,7 +3226,19 @@ static int kfd_ioctl_set_debug_trap(struct file *f=
ilep, struct kfd_process *p, v
>  	}
> =20
>  	switch (args->op) {
> -	case KFD_IOC_DBG_TRAP_ENABLE:
> +	case KFD_IOC_DBG_TRAP_ENABLE: {
> +		struct kfd_process *old_debugger =3D target->debugger_process;
> +
> +		/*
> +		 * Don't touch the debugger of a session that is already enabled,
> +		 * not even temporarily: its exit cleanup looks the pointer up
> +		 * without target->mutex.
> +		 */
> +		if (target->debug_trap_enabled) {
> +			r =3D -EALREADY;
> +			break;
> +		}
> +
>  		if (target !=3D p)
>  			target->debugger_process =3D p;
> =20
> @@ -3236,8 +3248,12 @@ static int kfd_ioctl_set_debug_trap(struct file *f=
ilep, struct kfd_process *p, v
>  					&args->enable.rinfo_size);
>  		if (!r)
>  			target->exception_enable_mask =3D args->enable.exception_mask;
> +		else
> +			/* the debugger check above trusts this pointer */
> +			target->debugger_process =3D old_debugger;
> =20
>  		break;
> +	}
>  	case KFD_IOC_DBG_TRAP_DISABLE:
>  		r =3D kfd_dbg_trap_disable(target, true);
>  		break;

[Severity: Medium]
Can a second thread in the debugger process still bypass the ptrace check
by reading target->debugger_process before kfd_dbg_trap_enable() rolls it
back?

kfd_ioctl_set_debug_trap() checks target->debugger_process before
acquiring target->mutex and does not re-check it after locking:

drivers/gpu/drm/amd/amdkfd/kfd_chardev.c:kfd_ioctl_set_debug_trap() {
	...
	rcu_read_lock();
	if (target !=3D p && ptrace_parent(target->lead_thread) !=3D current
			&& target->debugger_process !=3D p) {
		pr_err("PID %i is not PTRACED and cannot be debugged\n", args->pid);
		r =3D -EPERM;
	}
	rcu_read_unlock();

	if (r)
		goto out;

	mutex_lock(&target->mutex);
	...
}

Because target->debugger_process is set to p while kfd_dbg_trap_enable()
sleeps in copy_to_user(), another thread in p can pass the unlocked
permission check and wait on target->mutex:

CPU0 (ptrace thread in p)         CPU1 (other thread in p)
kfd_ioctl_set_debug_trap(ENABLE)
  mutex_lock(&target->mutex)
  target->debugger_process =3D p
  kfd_dbg_trap_enable()
    copy_to_user(...)
                                  kfd_ioctl_set_debug_trap(ENABLE)
                                    /* sees target->debugger_process =3D=3D=
 p */
                                    mutex_lock(&target->mutex)
    /* fails with -EFAULT */
  target->debugger_process =3D NULL
  mutex_unlock(&target->mutex)
/* detaches ptrace */
                                    target->debugger_process =3D p
                                    kfd_dbg_trap_enable()  <-- succeeds wit=
hout ptrace

The same window exists during KFD_IOC_DBG_TRAP_DISABLE while
kfd_dbg_trap_disable() sleeps in cancel_work_sync() under target->mutex
before clearing target->debugger_process.  Performing the permission check
inside target->mutex and only setting target->debugger_process after
kfd_dbg_trap_enable() succeeds (passing p into kfd_dbg_trap_enable() or
updating debugged_process_count afterwards) would close this race.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261118055009.3005=
630-1-Jesse.Zhang@amd.com?part=3D3
