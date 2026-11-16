Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 352BA606A32C
	for <amd-gfx@archiver.kernel.org>; Mon, 16 Nov 2026 08:14:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KxySMazB
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D13F710E989;
	Mon, 16 Nov 2026 08:13:55 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C2BC310E989
 for <amd-gfx@lists.freedesktop.org>; Mon, 16 Nov 2026 08:13:48 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 6963C41656;
 Mon, 16 Nov 2026 08:13:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 235771F000C4;
 Mon, 16 Nov 2026 08:13:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794816828;
 bh=CI7TyWJAZUGf1Mi18tXIJh2emJdAnPICi03QwzJ2Nbk=;
 h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
 b=KxySMazBENhJQlDq5fgxMTS1ne4vBx7BX8ea1Rl20unXLjwNIqeUZ3CGqa716SMio
 YmIvE57j4J9rbEx+iBL3WCtJm01+U2UruT/VSzcAqqsaalVL+tLUlSWLjKlFMmN7Xx
 66JQh/hqsfOEHi9819hj9Gc1yF7h9+BNyO4TLfU8Cj6Ap/1RRF/rDLWUsYQjopAtWE
 FitczxIiOJbvVSLFLomhTZHnDbxhDaQILvHz3Rq5ao9ULTjMJbBspskQvy3TG91Xvw
 HST+eUPX4G4iGuEeyKOOJfVFOq62ZPeq9H1QIb9eNgchmhjf0fbITFt61Hdm+5L+uJ
 eqKCew66K6L4w==
Message-ID: <sashiko-outbox-216517@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2] drm/amdkfd: Move gpu_recovery location
To: "Amber Lin" <amber.lin@amd.com>, amd-gfx@lists.freedesktop.org
In-Reply-To: <20261116075047.35150-1-amber.lin@amd.com>
References: <20261116075047.35150-1-amber.lin@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 16 Nov 2026 08:13:47 +0000
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
- [High] drm/amdgpu: broken !amdgpu_gpu_recovery flow in
  amdgpu_gfx_reset_mes_compute()
--

commit 8a38bbe4db1b13fc0dffaa46e16598a2c6c11936
Author: Amber Lin <amber.lin@amd.com>

drm/amdkfd: Move gpu_recovery location

This commit moves the amdgpu_gpu_recovery check from reset_queues_mes()
into amdgpu_gfx_reset_mes_compute() so bad queue removal still runs when
GPU recovery is disabled.

> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_gfx.c
> index c5a2dcff5058a..c30fecc653b4b 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
> @@ -2594,14 +2594,17 @@ int amdgpu_gfx_reset_mes_compute(struct amdgpu_de=
vice *adev,
>  	 * reset detect will return the array of bad queue doorbells
>  	 */
>  	r =3D amdgpu_mes_suspend(adev, xcc_id);
> +	dev_dbg(adev->dev, "Suspend all returns %d. xcc_id %d\n", r, xcc_id);
> +
> +	if (!amdgpu_gpu_recovery)
> +		goto after_reset;
> +
>  	/* if suspend all success, it should no hang queue */
> -	if (!r) {
> -		dev_dbg(adev->dev, "Suspend all succeeds. xcc_id %d\n", xcc_id);
> +	if (!r)
>  		/* always reset the KCQ/userq since we need to signal the fence
>  		 * and we could be stuck in a loop which is preemptable.
>  		 */
>  		goto fence_reset;
> -	}
>  	r =3D amdgpu_mes_detect_and_reset_hung_queues(adev, AMDGPU_RING_TYPE_CO=
MPUTE,
>  						    true, &num_hung, adev->gfx.mec.mes_hung_db_array, xcc_id);
>  	if (r) {
> @@ -2662,6 +2665,7 @@ int amdgpu_gfx_reset_mes_compute(struct amdgpu_devi=
ce *adev,
>  			goto out;
>  	}
> =20
> +after_reset:
>  	/* MES doesn't detect any hung queue but we have a known bad queue
>  	 * and it is not KCQ
>  	 */

[Severity: High]
Can jumping to after_reset when !amdgpu_gpu_recovery leave all kernel
compute ring DRM schedulers permanently stopped when a queue hangs?

Before calling amdgpu_mes_suspend(), amdgpu_gfx_reset_mes_compute() stops
the compute ring schedulers via amdgpu_gfx_reset_stop_compute_scheds().
When a queue is hung, amdgpu_mes_suspend() fails with a non-zero r, but
if !amdgpu_gpu_recovery is set, this jumps straight to after_reset with
num_hung =3D=3D 0:

drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c:amdgpu_gfx_reset_mes_compute() {
	...
after_reset:
	if (!num_hung && queue_input && !ring) {
		...
		r =3D adev->mes.funcs->remove_hw_queue(&adev->mes, queue_input);
		...
	}

out:
	amdgpu_mes_resume(adev, xcc_id);
	ring_err =3D r;
	...
	if (!ring_err)
		amdgpu_gfx_reset_start_compute_scheds(adev, ring);
	...
}

Because suspend_all failed, the hung queue was not preempted and
remove_hw_queue() fails as well (or if another queue on the XCC caused
suspend_all to fail, remove_hw_queue() can succeed and overwrite the
non-zero suspend error r with 0).  When r is non-zero, ring_err is
non-zero and amdgpu_gfx_reset_start_compute_scheds() is skipped; since no
full GPU reset follows when !amdgpu_gpu_recovery (or when called from
kfd_dqm_suspend_bad_queue_mes()), the compute schedulers are never
restarted.

Also, if amdgpu_gfx_reset_mes_compute() is called for a KCQ or KGD user
queue (where queue_input is NULL) and amdgpu_mes_suspend() succeeds,
jumping to after_reset skips fence_reset and returns 0 without resetting
the ring or user queue.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261116075047.3515=
0-1-amber.lin@amd.com?part=3D1
