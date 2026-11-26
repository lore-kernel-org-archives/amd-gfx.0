Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2E79606A31E
	for <amd-gfx@archiver.kernel.org>; Thu, 26 Nov 2026 14:17:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JkMY3yba
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7D1A011245C;
	Thu, 26 Nov 2026 14:17:26 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EEBF811245C
 for <amd-gfx@lists.freedesktop.org>; Thu, 26 Nov 2026 14:17:20 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 19AB561D22;
 Thu, 26 Nov 2026 14:17:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B19D71F000CF;
 Thu, 26 Nov 2026 14:17:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795702639;
 bh=8A7slPigl9U1f/v6bVqE2PY+0pbZ+EMJxXIdKZQweog=;
 h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
 b=JkMY3ybaz1RKiUFyH+GcNYacTmufIYv8rPsnAMopOMlwKnb0sNYyWCx327KV+xqtx
 J14w9VIHUnFlxApLBsEHFjLL5JJRJjf9XaM39XgvAnVJFvM5ieZUKkK3vsNmj3Qpuk
 YUNikrGq5FaApMkfh8kZTc4ANC2FYdP1DFptAB+pq9AcWaobKESEnNA9ngCs4Q7NNp
 5RJCnqNubPrQKwBvZUTEIHDe/011HWg7K3mvj4p9aiycsF7bncHJpK3Nu5SOYCzHbo
 5SEMuHmf0ki0N29ykhvGdWZp+Z476CHR531GO+rvPmkPSb+IkB/3S2rcsN/D/zFTw4
 z+2+SsAsOgbsw==
Message-ID: <sashiko-outbox-235685@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 1/2] drm/amd/display: don't release an MST payload
 that holds no time slots
To: "Bart Verwilst" <bart@verwilst.be>, amd-gfx@lists.freedesktop.org
In-Reply-To: <20261126110042.14612-2-bart@verwilst.be>
References: <20261126110042.14612-1-bart@verwilst.be>
 <20261126110042.14612-2-bart@verwilst.be>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 26 Nov 2026 14:17:19 +0000
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
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Archived-By: <archiver.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential
issues to consider:
- [Medium] drm/amd/display: port malloc ref leak on early return when
  vc_start_slot < 0
- [Low] drm/amd/display: missing Fixes trailer on MST payload
  deallocation fix
--

commit 7f970cf45d3ae6670fde9a6c3493d4e1852b6853
Author: Bart Verwilst <bart@verwilst.be>

> drm/amd/display: don't release an MST payload that holds no time slots
>
> dm_helpers_dp_mst_update_mst_mgr_for_deallocation() calls
> drm_dp_remove_payload_part2() unconditionally. That function decrements
> payload_count and moves next_start_slot back by the payload's time
> slots. If the payload was never added with drm_dp_add_payload_part1(),
> or was already released, both counters underflow. Every payload
> allocated afterwards then starts at a bogus slot and ACT never
> completes.
>
> This can happen when the same stream is disabled twice, e.g. first by
> link_set_all_streams_dpms_off_for_link() during a destructive link
> verification and then again when userspace disables its CRTC, or when
> the stream enable was aborted before its payload was allocated.
>
> drm_dp_add_payload_part1() sets vc_start_slot and
> drm_dp_remove_payload_part2() resets it to -1, so a negative
> vc_start_slot means there is nothing to release. Return early in that
> case.
>
> Signed-off-by: Bart Verwilst <bart@verwilst.be>

[Severity: Low]
Should this bug fix include a Fixes: tag for commit 83a79dd6f4fb
("drm/amd/display: adjust flow for deallocation mst payload")?

> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c b/=
drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c
> index 6192c0f6086db..bc26f65d51ffe 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c
> @@ -524,6 +524,22 @@ void dm_helpers_dp_mst_update_mst_mgr_for_deallocati=
on(
>  	mst_mgr =3D &aconnector->mst_root->mst_mgr;
>  	mst_state =3D to_drm_dp_mst_topology_state(mst_mgr->base.state);
>  	new_payload =3D drm_atomic_get_mst_payload_state(mst_state, aconnector-=
>mst_output_port);
> +	if (!new_payload)
> +		return;
> +
> +	/*
> +	 * Only a payload that went through drm_dp_add_payload_part1() holds
> +	 * time slots in the manager (vc_start_slot >=3D 0). Releasing a payload
> +	 * that was never added, or releasing one twice, would underflow
> +	 * payload_count and next_start_slot.
> +	 */
> +	if (new_payload->vc_start_slot < 0) {
> +		drm_dbg_kms(mst_mgr->dev,
> +			    "MST payload for VCPI %d holds no time slots, nothing to release\=
n",
> +			    new_payload->vcpi);
> +		return;
> +	}

[Severity: Medium]
Does returning early here leak a malloc reference on new_payload->port
when new_payload->delete is set?

When userspace disables the CRTC after
link_set_all_streams_dpms_off_for_link() has already reset vc_start_slot
to -1, drm_dp_mst_duplicate_state() takes a new port malloc reference and
drm_dp_atomic_release_time_slots() sets new_payload->delete =3D true.
Because drm_dp_mst_destroy_state() skips payloads with delete set:

drivers/gpu/drm/display/drm_dp_mst_topology.c:drm_dp_mst_destroy_state() {
	list_for_each_entry_safe(pos, tmp, &mst_state->payloads, next) {
		/* We only keep references to ports with active payloads */
		if (!pos->delete)
			drm_dp_mst_put_port_malloc(pos->port);
		kfree(pos);
	}
}

that reference is normally dropped by drm_dp_remove_payload_part2(),
which also resets new_payload->payload_allocation_status to
DRM_DP_MST_PAYLOAD_ALLOCATION_NONE after drm_dp_remove_payload_part1()
set it to DRM_DP_MST_PAYLOAD_ALLOCATION_LOCAL.  Skipping
drm_dp_remove_payload_part2() without doing both permanently leaks
new_payload->port and leaves payload_allocation_status at
DRM_DP_MST_PAYLOAD_ALLOCATION_LOCAL.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261126110042.1461=
2-1-bart@verwilst.be?part=3D1
