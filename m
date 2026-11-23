Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57137606A31A
	for <amd-gfx@archiver.kernel.org>; Mon, 23 Nov 2026 03:11:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PxhsPHTC
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E854110E2C8;
	Mon, 23 Nov 2026 03:11:40 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B371510E2C8
 for <amd-gfx@lists.freedesktop.org>; Mon, 23 Nov 2026 03:11:34 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 905B861CD4;
 Mon, 23 Nov 2026 03:11:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17B471F000CA;
 Mon, 23 Nov 2026 03:11:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795403493;
 bh=FX7gOLXiBK1mTSt6dFvKin4sMVqSkaW3GaMjWSiAwvM=;
 h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
 b=PxhsPHTCieJf5BuBo+HhafCrOapPzcufOUS9mzf/upYEjKj+QcA0zWOfLVHLZkSXT
 F9pJrKklF+Umvjr9YQCGGW71j8sP4btu58ZGFfvxPjCPFeS4xDs3IHA+zF2+xH7WRJ
 FqNmc+EBvKJ50OJz7SGL4FOCGPD2Zbj/UV8XQ4LZI3sA2f+rE6zg7MOt6FsSdYvhDi
 5xgndoq6x73HgW88tOQgj/H+wVVEOW2xK8Id9IS92OiWu7kLV8OkQGLVb3msq8Vm+k
 QazsBBFDTTFmgJSLVhNsayPKs7y7OCHNftf2F+d8bSIXuvgBktWqDQ7X6dgSlBr5Od
 SthuYRGUjwmfw==
Message-ID: <sashiko-outbox-228581@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 3/3] drm/amdkfd: don't keep the debugger pointer when
 DBG_TRAP_ENABLE fails
To: "Jesse Zhang" <Jesse.Zhang@amd.com>, amd-gfx@lists.freedesktop.org
In-Reply-To: <20261123024737.1475714-3-Jesse.Zhang@amd.com>
References: <20261123024737.1475714-1-Jesse.Zhang@amd.com>
 <20261123024737.1475714-3-Jesse.Zhang@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 23 Nov 2026 03:11:32 +0000
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
- [Medium] drm/amdkfd: premature debugger_process store in
  kfd_dbg_trap_enable()
--

commit aae136214c876252feb4eb6f8aa225bc102db225
Author: Jesse Zhang <Jesse.Zhang@amd.com>

drm/amdkfd: don't keep the debugger pointer when DBG_TRAP_ENABLE fails

This commit moves the assignment of target->debugger_process into
kfd_dbg_trap_enable() and clears it if copy_to_user() fails, preventing a
failed KFD_IOC_DBG_TRAP_ENABLE call from leaving target->debugger_process
set.

> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_debug.c b/drivers/gpu/drm/amd=
/amdkfd/kfd_debug.c
> index a025c3189753b..cf62aaffc2600 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_debug.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_debug.c
> @@ -793,8 +793,8 @@ int kfd_dbg_trap_activate(struct kfd_process *target)
>  	return r;
>  }
> =20
> -int kfd_dbg_trap_enable(struct kfd_process *target, uint32_t fd,
> -			void __user *runtime_info, uint32_t *runtime_size)
> +int kfd_dbg_trap_enable(struct kfd_process *target, struct kfd_process *=
debugger,
> +			uint32_t fd, void __user *runtime_info, uint32_t *runtime_size)
>  {
>  	struct file *f;
>  	uint32_t copy_size;
> @@ -835,6 +835,8 @@ int kfd_dbg_trap_enable(struct kfd_process *target, u=
int32_t fd,
>  	kref_get(&target->ref);
>  	target->debug_trap_enabled =3D true;
> =20
> +	if (target !=3D debugger)
> +		target->debugger_process =3D debugger;
>  	if (target->debugger_process)
>  		atomic_inc(&target->debugger_process->debugged_process_count);
> =20
> @@ -844,6 +846,7 @@ int kfd_dbg_trap_enable(struct kfd_process *target, u=
int32_t fd,
>  		target->dbg_ev_file =3D NULL;
>  		if (target->debugger_process)
>  			atomic_dec(&target->debugger_process->debugged_process_count);
> +		target->debugger_process =3D NULL;
>  		target->debug_trap_enabled =3D false;
>  		kfd_unref_process(target);
>  		r =3D -EFAULT;

[Severity: Medium]
Can setting target->debugger_process before copy_to_user() still allow the
caller to bypass the ptrace check in kfd_ioctl_set_debug_trap()?

kfd_ioctl_set_debug_trap() checks target->debugger_process before taking
target->mutex:

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

If copy_to_user() sleeps (for example via userfaultfd) and then fails with
-EFAULT, a second thread in the debugger process can pass the unlocked
permission check after ptrace is detached and wait on target->mutex:

CPU0                              CPU1
kfd_ioctl_set_debug_trap()
  mutex_lock(&target->mutex)
  kfd_dbg_trap_enable()
    target->debugger_process =3D p
    copy_to_user() [sleeps]
                                  [ptrace detached]
                                  kfd_ioctl_set_debug_trap()
                                    target->debugger_process =3D=3D p
                                    mutex_lock(&target->mutex)
    /* copy_to_user() fails */
    target->debugger_process =3D NULL
    target->debug_trap_enabled =3D false
  mutex_unlock(&target->mutex)
                                    kfd_dbg_trap_enable()  <-- succeeds wit=
hout ptrace

Could copy_to_user() be called before setting target->debugger_process and
activating the debug session?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261123024737.1475=
714-1-Jesse.Zhang@amd.com?part=3D3
