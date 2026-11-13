Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AC78606A321
	for <amd-gfx@archiver.kernel.org>; Fri, 13 Nov 2026 03:12:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mpKN/i09
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ADB6A10E105;
	Fri, 13 Nov 2026 03:12:02 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C1C7010E621
 for <amd-gfx@lists.freedesktop.org>; Fri, 13 Nov 2026 03:11:55 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 0E5F160E13;
 Fri, 13 Nov 2026 03:11:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F8761F000C4;
 Fri, 13 Nov 2026 03:11:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794539514;
 bh=sXdhAV8vL5uFIaKUVAuumW4u3q6Dqgw8gCMSby7VTKI=;
 h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
 b=mpKN/i09lR9xyUM3N7HOTs5dOmQt4BEPL0tEOPvlqaZxs4SG2ruo5AqGtYgqnOCJD
 BcMkxhbiUxJrQyCT/uSDKiJsOKjB6GCUIRJI+Nn/bF3+dbkjGGXTWQWMxMRaIfxvZz
 1p+lToKI0lR8XYgbifUQzjI5m4as2oP7v0W7K/8iMDhNKLbskECiItwXKsGaM7Wujl
 MAfNcsiaWjKiNZffxRcHxKR7dD4pNWbN8QRTLD1EdbiC8PiUqsuLuafFzN8W7IG7tx
 i7pYfj1EFZCoxJw7SBpJnCCUT33ZgLsO9R52lclwNAb8E68o7nlSKpw+X4Evg9cVFz
 xmbX2gU5E6Tpw==
Message-ID: <sashiko-outbox-212127@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] drm/amdkfd: Move gpu_recovery location
To: "Amber Lin" <amber.lin@amd.com>, amd-gfx@lists.freedesktop.org
In-Reply-To: <20261113023337.21214-1-amber.lin@amd.com>
References: <20261113023337.21214-1-amber.lin@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 13 Nov 2026 03:11:54 +0000
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

commit ade3a30c574ad137adf2baa6ab425df87856ed34
Author: Amber Lin <amber.lin@amd.com>

drm/amdkfd: Move gpu_recovery location

This commit moves the amdgpu_gpu_recovery check from reset_queues_mes()
into amdgpu_gfx_reset_mes_compute() so bad queue removal can proceed when
gpu_recovery is disabled.

> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_gfx.c
> index c5a2dcff5058a..f8874c12c94b2 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
> @@ -2602,6 +2602,10 @@ int amdgpu_gfx_reset_mes_compute(struct amdgpu_dev=
ice *adev,
>  		 */
>  		goto fence_reset;
>  	}
> +
> +	if (!amdgpu_gpu_recovery)
> +		goto after_reset;
> +
>  	r =3D amdgpu_mes_detect_and_reset_hung_queues(adev, AMDGPU_RING_TYPE_CO=
MPUTE,
>  						    true, &num_hung, adev->gfx.mec.mes_hung_db_array, xcc_id);
>  	if (r) {
> @@ -2662,6 +2666,7 @@ int amdgpu_gfx_reset_mes_compute(struct amdgpu_devi=
ce *adev,
>  			goto out;
>  	}
> =20
> +after_reset:
>  	/* MES doesn't detect any hung queue but we have a known bad queue
>  	 * and it is not KCQ
>  	 */

[Severity: High]
Does jumping to after_reset when amdgpu_gpu_recovery is 0 leave the kernel
compute ring schedulers permanently stopped after a queue hang?

amdgpu_gfx_reset_mes_compute() stops all kernel compute ring schedulers via
amdgpu_gfx_reset_stop_compute_scheds() before calling amdgpu_mes_suspend().
The new !amdgpu_gpu_recovery check is only reached when amdgpu_mes_suspend()
fails (r !=3D 0), which happens when a queue is hung.

Jumping to after_reset with num_hung =3D=3D 0 enters the (!num_hung &&
queue_input && !ring) block even though suspend_all failed:

drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c:amdgpu_gfx_reset_mes_compute() {
    ...
	if (!num_hung && queue_input && !ring) {
		/* MES suspend_all is successful means this bad queue is
		 * preempted successfuly. Remove it before resume all so it
		 * doesn't get mapped back
		 */
		...
		r =3D adev->mes.funcs->remove_hw_queue(&adev->mes, queue_input);
    ...
out:
	...
	ring_err =3D r;
	...
	if (!ring_err)
		amdgpu_gfx_reset_start_compute_scheds(adev, ring);
}

When queue_input is the hung queue (for example, when called from
remove_queue_mes_on_reset_option() or kfd_dqm_suspend_bad_queue_mes()),
remove_hw_queue() fails on the un-preempted queue and sets r to a non-zero
error.  At out:, amdgpu_gfx_reset_start_compute_scheds() is skipped because
ring_err is non-zero, and because amdgpu_gpu_recovery is 0 (or in
kfd_dqm_suspend_bad_queue_mes(), which only logs dev_dbg() on failure), no
GPU reset follows to restart the stopped compute schedulers.

Conversely, if amdgpu_mes_suspend() failed because a different queue was
hung while queue_input was already preempted, remove_hw_queue() can succeed
and overwrite the non-zero suspend error in r with 0.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261113023337.2121=
4-1-amber.lin@amd.com?part=3D1
