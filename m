Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D612E606A330
	for <amd-gfx@archiver.kernel.org>; Thu, 26 Nov 2026 10:10:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lqRw8yzq
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 536951122BF;
	Thu, 26 Nov 2026 10:10:10 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 95CE21122BF
 for <amd-gfx@lists.freedesktop.org>; Thu, 26 Nov 2026 10:10:04 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 5293745AFD;
 Thu, 26 Nov 2026 10:10:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6F911F000C6;
 Thu, 26 Nov 2026 10:10:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795687803;
 bh=sZ6LZ/TDpebzPb6SpJla/6eoFG5FXyIxvbYWwsz036o=;
 h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
 b=lqRw8yzqYFDGXRY3SkpqGctIrvFKunr3HyfIhogzJ32LUTVVZn95/dYYEcm3+af4s
 yQ8WC0OMkPUxOPq0IZmWQhJjij1rqW7WofcC2GLXjR3yur+/b8ouOYL6U4Vu17iKEy
 b4lvWfrt9wgPsIdkYEucPykrMWXICiEwzsYLtmoWjei0oV4zgiECv4M3a3a1Xt0US+
 L9W7niczBwV+Yrl1B607L2ey6hUiMleKlDK1hK2jvRaq89WZEX95/YYMF92oNDQ5t0
 wvEe6lxZIJf6e2rvbIj+XODrInNo24IVBIrBsW923O6vJ4AKDIus9R+trwumZSb88a
 9xgFOjmHAfAgQ==
Message-ID: <sashiko-outbox-235249@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 15/15] drm/amdgpu/gfx11: enable the gfx engine soft
 reset
To: "Jesse Zhang" <Jesse.Zhang@amd.com>, amd-gfx@lists.freedesktop.org
In-Reply-To: <20261126093417.192538-15-Jesse.Zhang@amd.com>
References: <20261126093417.192538-1-Jesse.Zhang@amd.com>
 <20261126093417.192538-15-Jesse.Zhang@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 26 Nov 2026 10:10:03 +0000
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
- [High] drm/amdgpu: user queue race and UAF during
  gfx_v11_0_soft_reset_engine()
- [Medium] drm/amdgpu/gfx11: missing pre-pulse CP_VMID_RESET clear in
  soft reset
- [Medium] drm/amdgpu/gfx11: kernel gfx queue left mapped when
  disable_kq is true
--

commit 37d8357ec5fb17ab702d211aa8fb7b20ac9e9a2a
Author: Jesse Zhang <Jesse.Zhang@amd.com>

drm/amdgpu/gfx11: enable the gfx engine soft reset

This commit enables AMDGPU_RESET_TYPE_IP_BLOCK_SOFT_RESET for GFX rings on
GC 11.5.1 and 11.5.3 when MES is enabled and SR-IOV VF is not active.

> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd=
/amdgpu/gfx_v11_0.c
> index 824d7914bece9..a878aaee1b74b 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
> @@ -1965,6 +1965,13 @@ static int gfx_v11_0_sw_init(struct amdgpu_ip_bloc=
k *ip_block)
>  		break;
>  	}
> =20
> +	/* Only on the GC versions it was verified on */
> +	if ((amdgpu_ip_version(adev, GC_HWIP, 0) =3D=3D IP_VERSION(11, 5, 1) ||
> +	     amdgpu_ip_version(adev, GC_HWIP, 0) =3D=3D IP_VERSION(11, 5, 3)) &&
> +	    !amdgpu_sriov_vf(adev) && adev->enable_mes &&
> +	    !adev->debug_disable_ip_block_soft_reset)
> +		adev->gfx.gfx_supported_reset |=3D AMDGPU_RESET_TYPE_IP_BLOCK_SOFT_RES=
ET;
> +
>  	if (!adev->enable_mes_kiq) {
>  		r =3D amdgpu_gfx_kiq_init(adev, GFX11_MEC_HPD_SIZE, 0);
>  		if (r) {

[Severity: High]
Can enabling engine soft reset cause a use-after-free on struct
amdgpu_usermode_queue in amdgpu_userq_save_hqds() and
amdgpu_userq_restore_hqds()?

When funcs->soft_reset_engine is set, amdgpu_device_ip_soft_reset() only
takes down_read(&adev->reset_domain->sem) before calling
gfx_v11_0_soft_reset_engine().  Because amdgpu_userq_detach_doorbell(),
amdgpu_userq_unmap_helper(), and amdgpu_userq_map_helper() also only take
down_read(&adev->reset_domain->sem), they are not blocked during an engine
soft reset.

Inside gfx_v11_0_soft_reset_engine(), amdgpu_userq_save_hqds() and
amdgpu_userq_restore_hqds() iterate adev->userq_doorbell_xa with
xa_for_each() without taking a reference on queue or locking
uq_mgr->userq_mutex:

CPU0                                     CPU1
amdgpu_device_ip_soft_reset()
  down_read(&adev->reset_domain->sem)
  gfx_v11_0_soft_reset_engine()
    amdgpu_userq_restore_hqds()
      xa_for_each(..., queue)
                                         amdgpu_userq_destroy()
                                           mutex_lock(&uq_mgr->userq_mutex)
                                           amdgpu_userq_detach_doorbell()
                                             down_read(&reset_domain->sem)
                                             xa_erase(&userq_doorbell_xa, .=
..)
                                           ...
                                           uq_funcs->mqd_destroy(queue)
                                           kfree(queue)
        userq_funcs->unmap(queue)
        ...                              <-- use-after-free

Concurrent eviction and restore workers (amdgpu_userq_evict_all() and
amdgpu_userq_restore_all()) also only take a read lock on
reset_domain->sem, so they can issue MES map/unmap requests and mutate
queue->state while MES is suspended and amdgpu_userq_restore_hqds() is
updating the queues without uq_mgr->userq_mutex.

[Severity: Medium]
Should gfx_v11_0_soft_reset_gfx_cp() clear regCP_VMID_RESET before pulsing
regGRBM_SOFT_RESET, as gfx_v12_0_soft_reset_gfx_cp() does?

drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c:gfx_v11_0_soft_reset_gfx_cp() {
	...
	/* A CP DMA in flight during the reset leaves the ME busy after it. */
	for (i =3D 0; i < adev->usec_timeout; i++) {
		if (!(RREG32_SOC15(GC, 0, regCP_STAT) & GFX11_CP_STAT_MEM_BUSY))
			break;
		udelay(1);\
	}

	/* GFX_ONLY keeps compute and MES out; CPF alone leaves the stream stuck. =
*/
	cntl =3D RREG32_SOC15(GC, 0, regCP_SOFT_RESET_CNTL);
	...
}

When a prior per-queue or per-pipe reset via mes_v11_0_reset_queue_mmio()
times out because PFP or ME is hung, the VMID reset request written to
regCP_VMID_RESET remains pending when fallback reaches
gfx_v11_0_soft_reset_gfx_cp().  gfx_v11_0_soft_reset_gfx_cp() only zeroes
regCP_VMID_RESET after the reset pulse, leaving the VMID reset active
during the CP soft reset and causing the soft reset to fail and escalate to
a full GPU reset.

[Severity: Medium]
Does gfx_v11_0_soft_reset_engine() leave the kernel GFX queue mapped when
adev->gfx.disable_kq is true?

drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c:gfx_v11_0_soft_reset_engine() {
	...
	/* The reset cleared the HQD of the kernel gfx queue: map it again. */
	r =3D amdgpu_gfx_disable_kgq(adev, 0);
	if (r)
		goto fail;
	for (i =3D 0; i < adev->gfx.num_gfx_rings; i++)
		amdgpu_gfx_mqd_reset_restore(&adev->gfx.gfx_ring[i]);
	r =3D amdgpu_gfx_enable_kgq(adev, 0);
	if (!r)
		r =3D gfx_v11_0_cp_gfx_start(adev);
	...
}

On GFX11, adev->gfx.num_gfx_rings is 1 even when adev->gfx.disable_kq is
true so gfx_ring[0] can be used to submit clear-state initialization
packets, after which gfx_v11_0_cp_resume() unmaps it via
amdgpu_gfx_disable_kgq(adev, 0) so MES can use pipe 0 queue 0 for user
queues.  When a hung GFX user queue triggers gfx_v11_0_soft_reset_engine()
with disable_kq set, gfx_ring[0] is mapped with amdgpu_gfx_enable_kgq() and
never unmapped afterward, leaving the legacy kernel queue mapped on pipe 0
queue 0 in conflict with MES user queues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261126093417.1925=
38-1-Jesse.Zhang@amd.com?part=3D15
