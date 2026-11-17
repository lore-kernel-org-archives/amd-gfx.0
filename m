Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AF14606A31C
	for <amd-gfx@archiver.kernel.org>; Tue, 17 Nov 2026 19:46:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=N5EacDli
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C197C10F8F8;
	Tue, 17 Nov 2026 19:46:23 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EF1D410F8F8
 for <amd-gfx@lists.freedesktop.org>; Tue, 17 Nov 2026 19:46:17 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id BA055447C6;
 Tue, 17 Nov 2026 19:46:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 813801F000C6;
 Tue, 17 Nov 2026 19:46:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794944777;
 bh=qtdOvLLdnbz5RCWXmpZCuR6ZDSyD04VdT/ep9qcxjcI=;
 h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
 b=N5EacDliQpumi/swIIBToJEEyWbu9gSNnGz/0w+fHHOyF964WR5DQKWJB8O7plVyp
 cKxa86LGFNq+RLqvqdxDjkiaf9K80T25lqXkVodPA8JXw43XKk9+c5VEXBetnKhaYT
 PBsaSNzmo4L0Nke/+uJ2NKBWO7MnY+R3nvduFM6OnBMX5iBptR+lypft61MjCF71EF
 Qeim1afOK52MUbrsYsF4M3aV5vpiy8QnZ/b+uAHj/fmk+P7ulP0GzvT1+nxbdjfzA1
 0Z8/hxEytADdpgROOfHjs4n7krPDbQvnM6g5J/X+JxjT0zSkNZ2PTpz8doySFRxglr
 7yrTBGtY0DCHg==
Message-ID: <sashiko-outbox-219523@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 7/9] drm/amdgpu/userq: add handling for set_gang
To: "Alex Deucher" <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
In-Reply-To: <20261117192415.810117-7-alexander.deucher@amd.com>
References: <20261117192415.810117-1-alexander.deucher@amd.com>
 <20261117192415.810117-7-alexander.deucher@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 17 Nov 2026 19:46:17 +0000
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

Thank you for your contribution! Sashiko AI review found 4 potential
issues to consider:
- [High] drm/amdgpu/userq: standalone secondary queue ops skip
  set_gang() and VA checks
- [High] drm/amdgpu/userq: out-of-bounds gang context GPU address in
  mes_set_gang()
- [Medium] drm/amdgpu/userq: missing error return in
  amdgpu_userq_restore_helper()
- [Medium] drm/amdgpu/userq: missing set_gang() call in
  amdgpu_userq_post_reset()
--

commit ed0b4bb2f9bf97208327d7b1d43ea3cfbbf1f688
Author: Alex Deucher <alexander.deucher@amd.com>

drm/amdgpu/userq: add handling for set_gang

This commit updates the usermode queue preempt, restore, unmap, and map
helpers to operate on a ganged secondary queue and invoke the set_gang
callback when mapping or restoring a gang.

> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/=
amd/amdgpu/amdgpu_userq.c
> index ed6f3b67e8720..e41f0e10c8a36 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
[ ... ]
> @@ -348,11 +371,27 @@ static int amdgpu_userq_restore_helper(struct amdgp=
u_usermode_queue *queue)
>  		}
>  	}
> =20
> +	if (secondary_queue &&
> +	    secondary_queue->state =3D=3D AMDGPU_USERQ_STATE_PREEMPTED) {
> +		trace_amdgpu_userq_state_start(secondary_queue);
> +
> +		r =3D userq_funcs->restore(secondary_queue);
> +		if (r) {
> +			trace_amdgpu_userq_state_changed(secondary_queue, AMDGPU_USERQ_STATE_=
HUNG);
> +			secondary_queue->state =3D AMDGPU_USERQ_STATE_HUNG;
> +		} else {
> +			trace_amdgpu_userq_state_changed(secondary_queue, AMDGPU_USERQ_STATE_=
MAPPED);
> +			secondary_queue->state =3D AMDGPU_USERQ_STATE_MAPPED;
> +			r =3D userq_funcs->set_gang(queue, secondary_queue);
> +		}
> +	}
> +
>  	return r;
>  }

[Severity: Medium]
Should amdgpu_userq_restore_helper() return immediately when restoring the
primary queue fails, as the other helpers do?

Without an early return in the primary queue error branch, a failed
userq_funcs->restore(queue) sets queue->state to AMDGPU_USERQ_STATE_HUNG
and falls through to the secondary_queue block.  Restoring secondary_queue
then overwrites r, calls userq_funcs->set_gang() with a hung primary queue,
and returns 0 to the caller if set_gang() succeeds.

[ ... ]

> @@ -403,7 +466,23 @@ static int amdgpu_userq_map_helper(struct amdgpu_use=
rmode_queue *queue)
>  		}
>  	}
> =20
> -	return 0;
> +	if (secondary_queue &&
> +	    secondary_queue->state =3D=3D AMDGPU_USERQ_STATE_UNMAPPED) {
> +		trace_amdgpu_userq_state_start(secondary_queue);
> +
> +		r =3D userq_funcs->map(secondary_queue);
> +		if (r) {
> +			trace_amdgpu_userq_state_changed(secondary_queue, AMDGPU_USERQ_STATE_=
HUNG);
> +			secondary_queue->state =3D AMDGPU_USERQ_STATE_HUNG;
> +			return r;
> +		} else {
> +			trace_amdgpu_userq_state_changed(secondary_queue, AMDGPU_USERQ_STATE_=
MAPPED);
> +			secondary_queue->state =3D AMDGPU_USERQ_STATE_MAPPED;
> +			r =3D userq_funcs->set_gang(queue, secondary_queue);
> +		}
> +	}
> +
> +	return r;
>  }

[Severity: High]
Does calling userq_funcs->set_gang() here pass out-of-bounds gang context
GPU addresses to MES?

mes_userq_create_ctx_space() allocates queue->fw_obj with only one page
(AMDGPU_USERQ_GANG_CTX_SZ), and mes_userq_map() registers ctx->gpu_addr at
offset 0 as gang_context_addr.  However, mes_set_gang() adds
AMDGPU_USERQ_PROC_CTX_SZ (PAGE_SIZE) to both GPU addresses:

drivers/gpu/drm/amd/amdgpu/mes_userqueue.c:mes_set_gang() {
    ...
	input.primary_gang_context_addr =3D
		primary_ctx->gpu_addr + AMDGPU_USERQ_PROC_CTX_SZ;
	input.secondary_gang_context_addr =3D
		secondary_ctx->gpu_addr + AMDGPU_USERQ_PROC_CTX_SZ;
    ...
}

This points one page past the end of each 1-page fw_obj BO and does not
match the gang_context_addr registered with MES.

[Severity: Medium]
Should amdgpu_userq_post_reset() also call userq_funcs->set_gang() when
remapping ganged queues after a GPU reset?

When VRAM is not lost, amdgpu_userq_post_reset() remaps hung queues
directly via userq_funcs->map(queue) without using
amdgpu_userq_map_helper() or calling userq_funcs->set_gang(), leaving
ganged queues unlinked in MES after recovery.

> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h b/drivers/gpu/drm/=
amd/amdgpu/amdgpu_userq.h
> index efaa658a26a9a..3dd63d6b9c445 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
> @@ -102,6 +102,9 @@ struct amdgpu_usermode_queue {
>  	} userq_vas;
> =20
>  	uint32_t	gang_ctx_array_index;
> +	bool			in_gang;
> +	bool			gang_primary;
> +	struct amdgpu_usermode_queue *gang_secondary;
>  };

[Severity: High]
What prevents callers iterating uq_mgr->userq_xa or
adev->userq_doorbell_xa from operating on a secondary gang queue directly?

Both queues remain in the XArrays, and neither the helpers nor the
xa_for_each() loops check queue->in_gang && !queue->gang_primary.

If xa_for_each() in amdgpu_userq_restore_all(), amdgpu_userq_resume(), or
amdgpu_userq_start_sched_for_enforce_isolation() visits secondary_queue
before primary_queue, secondary_queue is mapped or restored to
AMDGPU_USERQ_STATE_MAPPED on its own.  When primary_queue is visited next,
secondary_queue->state is no longer UNMAPPED or PREEMPTED, so
userq_funcs->set_gang() is skipped.

Conversely, if primary_queue is visited first in
amdgpu_userq_restore_all(), amdgpu_userq_map_helper(primary_queue) maps
secondary_queue in MES before amdgpu_userq_buffer_vas_mapped() is checked
on secondary_queue:

drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c:amdgpu_userq_restore_all() {
    ...
	xa_for_each(&uq_mgr->userq_xa, queue_id, queue) {
		if (!amdgpu_userq_buffer_vas_mapped(queue)) {
			drm_file_err(uq_mgr->file,
				     "trying restore queue without va mapping\n");
			trace_amdgpu_userq_state_changed(queue, AMDGPU_USERQ_STATE_INVALID_VA);
			queue->state =3D AMDGPU_USERQ_STATE_INVALID_VA;
			continue;
		}

		r =3D amdgpu_userq_map_helper(queue);
    ...
}

If secondary_queue has unmapped VAs, the later loop iteration sets
secondary_queue->state to AMDGPU_USERQ_STATE_INVALID_VA while it remains
mapped in MES, so subsequent unmap and queue destruction skip unmapping it
from hardware before freeing its MQD and context BOs.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261117192415.8101=
17-1-alexander.deucher@amd.com?part=3D7
