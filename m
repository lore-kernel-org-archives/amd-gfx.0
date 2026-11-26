Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4D94606A32D
	for <amd-gfx@archiver.kernel.org>; Thu, 26 Nov 2026 09:52:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=S2sMfL0e
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2145010E26C;
	Thu, 26 Nov 2026 09:52:33 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1607610E26C
 for <amd-gfx@lists.freedesktop.org>; Thu, 26 Nov 2026 09:52:27 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id BBDF84462F;
 Thu, 26 Nov 2026 09:52:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23EDB1F000C6;
 Thu, 26 Nov 2026 09:52:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795686746;
 bh=YTj1OgixoW7cRnYdOLvcevqWhu1RNTrvpxOFiOM7/rQ=;
 h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
 b=S2sMfL0eOe43F5P9L6sO0lihdF3Pic+LK+VI2W49vThRKe0sp3pUwWeT4SHDJvryb
 +DvcRnwgJMqGEMFuqaGc9LEElEwonqE90qOrdO4PM5sIKTRNDOYr6mEv3oJdeZtFfo
 4jR+4loxlMsXJbk6p64v/oXuKXhwilhAeh1dUDZgsRnSyz6pBc4CZamcq8lzANMV+b
 iFKyhsJPsgJv2kW3P2f0wbfMV5NEBKz08KjUUzS0eK3vY6HZOdaSr8zSZaYCRoIaE1
 RUvgeh/Ywsw4WS0f0IF7ivpttlDjw06mydVp1+roIIeLJDrM8zHpZ62Al7S2E9NSKX
 y8Ibk4xFSftKw==
Message-ID: <sashiko-outbox-235187@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 02/15] drm/amdgpu/ring: During multi-queue reset,
 only call begin helper if needed
To: "Jesse Zhang" <Jesse.Zhang@amd.com>, amd-gfx@lists.freedesktop.org
In-Reply-To: <20261126093417.192538-2-Jesse.Zhang@amd.com>
References: <20261126093417.192538-1-Jesse.Zhang@amd.com>
 <20261126093417.192538-2-Jesse.Zhang@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 26 Nov 2026 09:52:25 +0000
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
- [High] drm/amdgpu: ring->guilty_fence check in
  amdgpu_multi_ring_reset_helper_begin()
--

commit 142729efa2e6db09ea45e10147ee07f2ee131c88
Author: Timur Krist=C3=B3f <timur.kristof@gmail.com>

drm/amdgpu/ring: During multi-queue reset, only call begin helper if needed

This commit skips calling amdgpu_ring_reset_helper_begin() in
amdgpu_multi_ring_reset_helper_begin() when ring =3D=3D guilty_ring and
ring->guilty_fence =3D=3D guilty_fence, to preserve the ring backup from a
prior failed per-queue reset.

> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_ring.c
> index edae764eb0c42..c71e1c3b6d7bb 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
> @@ -1027,8 +1027,10 @@ void amdgpu_multi_ring_reset_helper_begin(struct a=
mdgpu_device *adev,
>  		 * Backup current contents of the ring.
>  		 * The helper takes care to only reemit unsignalled fences
>  		 * so we don't have to worry about that here.
> +		 * A failed ring reset of the same job already backed it up.
>  		 */
> -		amdgpu_ring_reset_helper_begin(ring, ring_guilty_fence);
> +		if (ring !=3D guilty_ring || ring->guilty_fence !=3D guilty_fence)
> +			amdgpu_ring_reset_helper_begin(ring, ring_guilty_fence);
>  	}
>  }

[Severity: High]
Can checking ring->guilty_fence =3D=3D guilty_fence distinguish an unconsum=
ed
backup from a failed queue reset in the current timeout from a prior reset
of the same fence that already completed?

amdgpu_ring_set_fence_errors_and_reemit() leaves ring->guilty_fence and
ring->ring_backup_entries_to_copy unchanged after re-emitting a ring so
that amdgpu_ring_backup_unprocessed_commands() can detect a second timeout
of the same fence and stop replaying:

drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c:amdgpu_ring_backup_unprocessed_co=
mmands() {
	...
	ring->ring_backup_entries_to_copy =3D 0;

	if (guilty_fence && ring->guilty_fence =3D=3D guilty_fence) {
		ring->guilty_fence =3D NULL;
		return;
	}
	ring->guilty_fence =3D guilty_fence;
	...
}

When a soft reset succeeds and the re-emitted command stream times out
again before guilty_fence signals, ring->guilty_fence is still
guilty_fence. Skipping amdgpu_ring_reset_helper_begin() bypasses that check
and leaves ring->ring_backup_entries_to_copy at its previous non-zero count,
so amdgpu_multi_ring_reset_helper_end() keeps re-emitting the stale backup
in an infinite soft-reset loop. If new jobs were submitted after
drm_sched_wqueue_start() at the end of the first reset, their fences
advance ring->fence_drv.sync_seq without being backed up;
amdgpu_ring_set_fence_errors_and_reemit() then allocates the smaller stale
ring_backup_entries_to_copy DWord count while re-emitting all unsignaled
fences up to sync_seq, underflowing ring->count_dw and re-emitting stale
commands from ring->ring_backup[0..] for the new jobs.

Conversely, if a second timeout runs a per-queue reset first,
amdgpu_ring_backup_unprocessed_commands() sees ring->guilty_fence =3D=3D
guilty_fence and clears ring->guilty_fence to NULL; if that per-queue reset
then fails and falls back to amdgpu_device_ip_soft_reset(), this condition
sees ring->guilty_fence !=3D guilty_fence and backs up the ring again inste=
ad
of terminating the replay loop. Also, if an engine-wide per-ring reset
callback (such as amdgpu_sdma_reset_queue_legacy() or
amdgpu_vcn_ring_reset()) fails after calling
amdgpu_ring_reset_helper_begin() on a collateral ring with a non-NULL
ring_guilty_fence, this condition still calls
amdgpu_ring_reset_helper_begin() for ring !=3D guilty_ring and clears that
collateral ring's backup.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261126093417.1925=
38-1-Jesse.Zhang@amd.com?part=3D2
