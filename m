Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 850BB606A31E
	for <amd-gfx@archiver.kernel.org>; Thu, 26 Nov 2026 10:00:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SInBNpY6
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EC9B9112276;
	Thu, 26 Nov 2026 10:00:13 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0CF91112276
 for <amd-gfx@lists.freedesktop.org>; Thu, 26 Nov 2026 10:00:05 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id DD01F439F7;
 Thu, 26 Nov 2026 10:00:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F1261F000D8;
 Thu, 26 Nov 2026 10:00:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795687204;
 bh=KCRLygIC9G9NoP7JGya5xtuCzlMkZ2DhuZ4U0imu/rc=;
 h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
 b=SInBNpY6zKYnUO50/83gfc+Fm4c3WPzsPJsxRv0kN1FNl2JjhnWY/G/5vO+Gi1R8T
 uNxJtDpd61I+Tsv8E/9rNTIz8LwSVyCmgKiQeDKoDC6yc/RM/b89FPjy9VKiOWgib0
 IJTYJhii/N9AaUrwr7Id1qUaJT8isp49YA8l6a03G/snfjGu3/yGLTUew+zEfsFwKb
 hyHT4iSPTQ3Rq9SqTU+96cTT5ctaooX3E/yocXY52FKOgEsQE2fOv1qgWZJdy3Rys4
 p3p7z7bHhC8XQOQBxf5AcpWdrUv3KXZNULLBjNhPMqClI8AsZugu75AKIY8Yc3Jbwf
 4dgcPC+bH6qrA==
Message-ID: <sashiko-outbox-235216@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 03/15] drm/amdgpu: add an engine scope to the IP
 block soft reset
To: "Jesse Zhang" <Jesse.Zhang@amd.com>, amd-gfx@lists.freedesktop.org
In-Reply-To: <20261126093417.192538-3-Jesse.Zhang@amd.com>
References: <20261126093417.192538-1-Jesse.Zhang@amd.com>
 <20261126093417.192538-3-Jesse.Zhang@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 26 Nov 2026 10:00:03 +0000
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
- [High] drm/amdgpu: race with user queues in
  amdgpu_device_ip_soft_reset()
--

commit 2c34e267b776523348afd4f14e7ef41c33d20c0a
Author: Jesse Zhang <Jesse.Zhang@amd.com>

drm/amdgpu: add an engine scope to the IP block soft reset

This commit adds an optional soft_reset_engine() callback to amd_ip_funcs
and updates amdgpu_device_ip_soft_reset() to reset only the hung engine
and recover its user queues while holding reset_domain->sem for read.

> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ip.c b/drivers/gpu/drm/amd=
/amdgpu/amdgpu_ip.c
> index d0b0d3eaffc56..79bc275e3e0fa 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ip.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ip.c
[ ... ]
> @@ -430,55 +434,71 @@ static u32 amdgpu_ring_mask_from_ip(const enum amd_=
ip_block_type ip_type)
[ ... ]
> -	amdgpu_device_lock_reset_domain(adev->reset_domain);
> +	/* An engine reset leaves the others running: let KFD add/remove queues=
. */
> +	if (engine) {
> +		ring_type_mask =3D BIT(ring_type);
> +		down_read(&adev->reset_domain->sem);
> +	} else {
> +		ring_type_mask =3D amdgpu_ring_mask_from_ip(ip_type);
> +		amdgpu_device_lock_reset_domain(adev->reset_domain);
> +	}
>  	amdgpu_multi_ring_reset_helper_begin(adev, ring_type_mask, guilty_ring,=
 guilty_fence);
> =20
> -	r =3D ip_block->version->funcs->soft_reset(ip_block);
> +	r =3D engine ? funcs->soft_reset_engine(ip_block, ring_type, inst, guil=
ty_queue) :
> +		     funcs->soft_reset(ip_block);

[Severity: High]
Can holding adev->reset_domain->sem only for read during an engine reset
race with concurrent user queue operations and cause a use-after-free on
struct amdgpu_usermode_queue?

The user queue helpers in drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
(amdgpu_userq_unmap_helper(), amdgpu_userq_map_helper(), and
amdgpu_userq_detach_doorbell()) also take adev->reset_domain->sem for read
to serialize against GPU resets:

drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c:amdgpu_userq_detach_doorbell() {
    ...
	down_read(&adev->reset_domain->sem);
	xa_erase_irq(&adev->userq_doorbell_xa, queue->doorbell_index);
	up_read(&adev->reset_domain->sem);
}

Because two readers do not exclude each other, user queue teardown,
eviction, or restore can run concurrently while soft_reset_engine() is
suspending MES and iterating adev->userq_doorbell_xa (via
amdgpu_userq_save_hqds() and amdgpu_userq_restore_hqds() in commit
"drm/amdgpu/userq: add helpers to keep the user queues of one engine
across a reset") without holding uq_mgr->userq_mutex:

CPU0                                    CPU1
amdgpu_device_ip_soft_reset()
  down_read(&adev->reset_domain->sem)
  funcs->soft_reset_engine()
    amdgpu_userq_save_hqds()
      xa_for_each(&adev->userq_doorbell_xa, ..., queue)
                                        amdgpu_userq_destroy()
                                          amdgpu_userq_detach_doorbell()
                                            down_read(&adev->reset_domain->=
sem)
                                            xa_erase_irq(&adev->userq_doorb=
ell_xa, ...)
                                            up_read(&adev->reset_domain->se=
m)
                                          kfree(queue)
        queue->state =3D ...;  <-- use-after-free

Concurrent eviction or restore paths can likewise call into MES while it
is suspended and race on queue->state.  Note that soft_reset_engine()
cannot simply acquire uq_mgr->userq_mutex either, because
amdgpu_lockdep_init() defines userq_mutex as outer to reset_domain->sem.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261126093417.1925=
38-1-Jesse.Zhang@amd.com?part=3D3
