Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E106606A31E
	for <amd-gfx@archiver.kernel.org>; Thu, 26 Nov 2026 10:15:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Hjptfoi2
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F403210E2A4;
	Thu, 26 Nov 2026 10:15:14 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 39E9910E2A4
 for <amd-gfx@lists.freedesktop.org>; Thu, 26 Nov 2026 10:15:09 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id C3D5C40C41;
 Thu, 26 Nov 2026 10:15:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 936F21F000C0;
 Thu, 26 Nov 2026 10:15:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795688108;
 bh=tFzUtjpL8tACtI2Em7aBlwriQ0dH1eMll1bUHRERc2o=;
 h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
 b=Hjptfoi27wg7kdoP42nDMgOZDkHyfLCVKJc4lyHacGHgd3mCHlygcoRHbnGGwTh3S
 6NQsuaBmCALoalkm+iuTKMg25zxQZkLJZHZuorI7TiniXXw4FuNrxP2w6+TCvBivpL
 K6dttWG2+jaw0yAqRf29mFnrXCuSnbfoUT3fX2wK+bgKNVJh+P+EjQwHdM9/39njNT
 uY3nX+ZUH98H+IxHKbQtFu6WHPDyO9aIHORlpPVjE3yClqs91Il5IKL2ttWoK+g72o
 UOh0s2q+vGP7w6wqeovK1hw1U7Bl0nrnsT44lrBCuwc6DsG0Lp6/UykDLjIIhgSmNy
 fmPcLlBVAymOg==
Message-ID: <sashiko-outbox-235260@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 13/15] drm/amdgpu/userq: reset the gfx engine when a
 gfx user queue reset fails
To: "Jesse Zhang" <Jesse.Zhang@amd.com>, amd-gfx@lists.freedesktop.org
In-Reply-To: <20261126093417.192538-13-Jesse.Zhang@amd.com>
References: <20261126093417.192538-1-Jesse.Zhang@amd.com>
 <20261126093417.192538-13-Jesse.Zhang@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 26 Nov 2026 10:15:08 +0000
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
- [High] drm/amdgpu/userq: mes_userq_reset() fallback overwrites
  ring_backup with NOPs
- [High] drm/amdgpu/userq: UAF and race in mes_userq_reset_gfx_engine()
  under down_read
--

commit bc5fd65f8048fdf05e24850897e014a130300c03
Author: Jesse Zhang <Jesse.Zhang@amd.com>

drm/amdgpu/userq: reset the gfx engine when a gfx user queue reset fails

This commit falls back to a soft reset of the GFX engine via
amdgpu_device_ip_soft_reset() when a GFX user queue or pipe reset fails.

> diff --git a/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c b/drivers/gpu/drm=
/amd/amdgpu/mes_userqueue.c
> index 7abb9d95ef59a..8d0cd45758444 100644
> --- a/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
> +++ b/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
> @@ -235,11 +235,40 @@ int mes_userq_reset_hw(struct amdgpu_usermode_queue=
 *queue,
>  	return 0;
>  }
> =20
> +/* The master XCC of the queue partition */
> +static u32 mes_userq_gfx_inst(struct amdgpu_usermode_queue *queue)
> +{
> +	struct amdgpu_device *adev =3D queue->userq_mgr->adev;
> +	u32 xcc_mask;
> +
> +	if (!adev->xcp_mgr ||
> +	    amdgpu_xcp_get_inst_details(&adev->xcp_mgr->xcp[queue->xcp_id],
> +					AMDGPU_XCP_GFX, &xcc_mask) || !xcc_mask)
> +		return 0;
> +
> +	return ffs(xcc_mask) - 1;
> +}
> +
> +static int mes_userq_reset_gfx_engine(struct amdgpu_usermode_queue *queu=
e)
> +{
> +	return amdgpu_device_ip_soft_reset(queue->userq_mgr->adev,
> +					   AMDGPU_RING_TYPE_GFX,
> +					   mes_userq_gfx_inst(queue), NULL,
> +					   NULL, queue);
> +}

[Severity: High]
Can mes_userq_reset_gfx_engine() race with concurrent user queue teardown or
eviction and cause a use-after-free on collateral queues in
adev->userq_doorbell_xa?

Because GFX v11 and v12 implement soft_reset_engine,
amdgpu_device_ip_soft_reset() takes only down_read(&adev->reset_domain->sem)
instead of the exclusive reset domain write lock.  Inside soft_reset_engine,
amdgpu_userq_save_hqds() and amdgpu_userq_restore_hqds() walk
adev->userq_doorbell_xa with xa_for_each() without taking xa_lock, pinning
queue->refcount, or locking queue->userq_mgr->userq_mutex.  Other user queue
paths such as amdgpu_userq_destroy() and eviction/restore workers also only
take down_read(&adev->reset_domain->sem):

CPU0                                  CPU1
mes_userq_reset_gfx_engine()
  amdgpu_device_ip_soft_reset()
    down_read(&reset_domain->sem)
    ...
      amdgpu_userq_restore_hqds()
        xa_for_each(...)
                                      amdgpu_userq_destroy(queue)
                                        amdgpu_userq_detach_doorbell()
                                          down_read(&reset_domain->sem)
                                          xa_erase(&userq_doorbell_xa, ...)
                                          up_read(&reset_domain->sem)
                                        ...
                                        kfree(queue)
          userq_funcs->unmap(queue)  <-- use-after-free

> +
> +static bool mes_userq_gfx_engine_reset_supported(struct amdgpu_device *a=
dev)
> +{
> +	return adev->gfx.gfx_supported_reset &
> +	       AMDGPU_RESET_TYPE_IP_BLOCK_SOFT_RESET;
> +}
> +
>  int mes_userq_reset(struct amdgpu_usermode_queue *queue)
>  {
>  	struct amdgpu_userq_mgr *uq_mgr =3D queue->userq_mgr;
>  	struct amdgpu_device *adev =3D uq_mgr->adev;
>  	struct mes_reset_queue_input queue_input;
> +	int r;
> =20
>  	/* already reset by an earlier job's hang-detect; just signal and bail =
*/
>  	if (queue->state =3D=3D AMDGPU_USERQ_STATE_HUNG)
> @@ -248,8 +277,10 @@ int mes_userq_reset(struct amdgpu_usermode_queue *qu=
eue)
>  	/* A GFX pipe reset also affects the kernel rings on that pipe. */
>  	if (queue->queue_type =3D=3D AMDGPU_HW_IP_GFX &&
>  	    adev->gfx.funcs->detect_hung_queue &&
> -	    amdgpu_gfx_me_pipe_reset_supported(adev))
> -		return amdgpu_gfx_reset_mes_gfx(adev, NULL, NULL, queue, 0, true);
> +	    amdgpu_gfx_me_pipe_reset_supported(adev)) {
> +		r =3D amdgpu_gfx_reset_mes_gfx(adev, NULL, NULL, queue, 0, true);
> +		goto out;
> +	}
> =20
>  	memset(&queue_input, 0x0, sizeof(struct mes_reset_queue_input));
>  	queue_input.doorbell_offset =3D queue->doorbell_index;
> @@ -277,7 +308,12 @@ int mes_userq_reset(struct amdgpu_usermode_queue *qu=
eue)
>  		}
>  	}
> =20
> -	return mes_userq_reset_hw(queue, &queue_input);
> +	r =3D mes_userq_reset_hw(queue, &queue_input);
> +out:
> +	if (r && queue->queue_type =3D=3D AMDGPU_HW_IP_GFX &&
> +	    mes_userq_gfx_engine_reset_supported(adev))
> +		r =3D mes_userq_reset_gfx_engine(queue);
> +	return r;
>  }

[Severity: High]
When amdgpu_gfx_reset_mes_gfx() fails after clearing a collateral kernel GFX
ring and jumps to out:, does falling back to mes_userq_reset_gfx_engine()
overwrite that ring's ring_backup[] with NOPs?

During amdgpu_gfx_reset_mes_gfx(adev, NULL, NULL, queue, 0, true),
amdgpu_gfx_pipe_reset_prepare() calls amdgpu_ring_reset_helper_begin(cring,
NULL) on collateral kernel GFX rings with pending fences, saving their
unprocessed commands into cring->ring_backup[].  When pipe reset restores
the kernel queue MQD via amdgpu_gfx_mqd_reset_restore(), it resets
cring->wptr to 0 and fills cring->ring[] with NOPs.  If a subsequent step in
amdgpu_gfx_reset_mes_gfx() fails before amdgpu_ring_reset_helper_end()
re-emits cring->ring_backup[] (for example in mes_userq_unmap(),
amdgpu_mes_resume(), or amdgpu_ring_test_ring()), execution jumps to out:
and calls mes_userq_reset_gfx_engine(), which invokes
amdgpu_device_ip_soft_reset() with guilty_ring =3D NULL:

drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c:amdgpu_multi_ring_reset_helper_beg=
in() {
    ...
		if (ring !=3D guilty_ring || ring->guilty_fence !=3D guilty_fence)
			amdgpu_ring_reset_helper_begin(ring, ring_guilty_fence);
    ...
}

Because guilty_ring is NULL, ring !=3D guilty_ring is true for every kernel
GFX ring, so amdgpu_ring_reset_helper_begin() runs a second time on cring
and copies the NOP-filled cring->ring[] over cring->ring_backup[].  When the
engine soft reset finishes, replaying cring->ring_backup[] emits only NOPs
and all pending fences on the kernel GFX ring never signal.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261126093417.1925=
38-1-Jesse.Zhang@amd.com?part=3D13
