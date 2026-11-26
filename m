Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72102606A31C
	for <amd-gfx@archiver.kernel.org>; Thu, 26 Nov 2026 09:57:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OQ0aAN6V
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E292F10E03A;
	Thu, 26 Nov 2026 09:57:45 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1F34610E03A
 for <amd-gfx@lists.freedesktop.org>; Thu, 26 Nov 2026 09:57:40 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 5C55A62409;
 Thu, 26 Nov 2026 09:57:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC6B61F000ED;
 Thu, 26 Nov 2026 09:57:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795687059;
 bh=vhWYDgwofPDm7szcCcMZ4mHW4ofrtUPzQxOXK4cwCgM=;
 h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
 b=OQ0aAN6V/CuMQXaYXLQp614SJJ5CFM75RhXoDEv5zxXuHp6TfpKsGQsQ+81nSoE+b
 7GtZUJDhgkykI3OLjvgwWrPuZ7I56DdPJj6+nJiT0o/paavbIOpGC2lNOlZ+Cm9Plz
 /TQbSQl4GenP+2+xfepSSl5iJ8oFM/wGjnTE8dNZ63a9B3ZaXpb6VgzutdfU9Ox3H0
 wjDzMWnMeeH1wZIAH7Lmc0Ea3wUyGePqr0rjs6rshij3Dux2wFRUsB/foRTUZhwyqw
 f/VAmi2mp8Mz1L6OlOJi5ylMdXiIQC7Qy828gI+5kX83vghvW8r/6Ot3jBef1LrKgF
 /0TcGws8RKArg==
Message-ID: <sashiko-outbox-235201@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 09/15] drm/amdgpu/gfx12: add a gfx engine soft reset
To: "Jesse Zhang" <Jesse.Zhang@amd.com>, amd-gfx@lists.freedesktop.org
In-Reply-To: <20261126093417.192538-9-Jesse.Zhang@amd.com>
References: <20261126093417.192538-1-Jesse.Zhang@amd.com>
 <20261126093417.192538-9-Jesse.Zhang@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 26 Nov 2026 09:57:38 +0000
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
- [High] drm/amdgpu/gfx12: race and UAF on user queues in
  gfx_v12_0_soft_reset_engine()
--

commit 1eb59ae54b68b8bc41a2294b6011763c46222bdb
Author: Jesse Zhang <Jesse.Zhang@amd.com>

drm/amdgpu/gfx12: add a gfx engine soft reset

This commit implements soft_reset_engine() for the GFX12 graphics engine
to reset CPF/CPG, PFP/ME, and the GFX HQDs while saving and restoring
user queues around the reset.

> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c b/drivers/gpu/drm/amd=
/amdgpu/gfx_v12_0.c
> index 8ca8e3f8392d3..69bdae805597c 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
> @@ -3868,6 +3868,137 @@ static int gfx_v12_0_wait_for_idle(struct amdgpu_=
ip_block *ip_block)

[ ... ]

> +static int gfx_v12_0_soft_reset_engine(struct amdgpu_ip_block *ip_block,
> +				       enum amdgpu_ring_type ring_type, u32 inst,
> +				       struct amdgpu_usermode_queue *guilty_queue)
> +{
> +	struct amdgpu_device *adev =3D ip_block->adev;
> +	int i, r;
> +
> +	if (ring_type !=3D AMDGPU_RING_TYPE_GFX || inst)
> +		return -EOPNOTSUPP;
> +
> +	mutex_lock(&adev->gfx.mec.reset_mutex);
> +	amdgpu_gfx_off_ctrl(adev, false);
> +
> +	/* A hung gfx stream can keep MES from suspending: reset anyway. */
> +	amdgpu_mes_suspend(adev, 0);
> +	amdgpu_userq_save_hqds(adev, AMDGPU_HW_IP_GFX);
> +
> +	r =3D gfx_v12_0_soft_reset_gfx_cp(adev);
> +	if (r) {
> +		dev_err(adev->dev, "gfx CP still busy after reset, CP_STAT 0x%08x\n",
> +			RREG32_SOC15(GC, 0, regCP_STAT));
> +		goto fail;
> +	}
> +
> +	/* The reset cleared the HQD of the kernel gfx queue: map it again. */
> +	r =3D amdgpu_gfx_disable_kgq(adev, 0);
> +	if (r)
> +		goto fail;
> +	for (i =3D 0; i < adev->gfx.num_gfx_rings; i++)
> +		amdgpu_gfx_mqd_reset_restore(&adev->gfx.gfx_ring[i]);
> +	r =3D amdgpu_gfx_enable_kgq(adev, 0);
> +	if (!r)
> +		r =3D gfx_v12_0_cp_gfx_start(adev);
> +	if (r)
> +		goto fail;
> +
> +	amdgpu_userq_restore_hqds(adev, AMDGPU_HW_IP_GFX, guilty_queue);
> +	r =3D amdgpu_mes_resume(adev, 0);

[Severity: High]
Can amdgpu_userq_save_hqds() and amdgpu_userq_restore_hqds() race with
concurrent user queue destruction and trigger a use-after-free on queue?

When .soft_reset_engine is set, amdgpu_device_ip_soft_reset() only takes
down_read(&adev->reset_domain->sem) rather than the exclusive write lock,
and gfx_v12_0_soft_reset_engine() only holds adev->gfx.mec.reset_mutex.
Meanwhile, amdgpu_userq_destroy() and amdgpu_userq_detach_doorbell() also
use down_read(&adev->reset_domain->sem) to serialize against resets and
do not take adev->gfx.mec.reset_mutex.  Because xa_for_each() in
amdgpu_userq_save_hqds() and amdgpu_userq_restore_hqds() iterates
adev->userq_doorbell_xa without holding userq_mutex or a queue reference:

CPU0                                  CPU1
amdgpu_device_ip_soft_reset()
  down_read(&reset_domain->sem)
  gfx_v12_0_soft_reset_engine()
    amdgpu_userq_restore_hqds()
      xa_for_each(..., queue)
                                      amdgpu_userq_destroy()
                                        amdgpu_userq_detach_doorbell()
                                          down_read(&reset_domain->sem)
                                          xa_erase_irq(...)
                                          up_read(&reset_domain->sem)
                                        uq_funcs->mqd_destroy(queue)
                                        kfree(queue)
        restore_hqd(...,
          queue->mqd.cpu_ptr, ...)  <-- use-after-free

For the same reason, amdgpu_userq_map_helper() and
amdgpu_userq_unmap_helper() only take down_read(&adev->reset_domain->sem),
so they can run concurrently with gfx_v12_0_soft_reset_engine(), racing
on queue->state and issuing MES map/unmap commands while MES gangs are
suspended.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261126093417.1925=
38-1-Jesse.Zhang@amd.com?part=3D9
