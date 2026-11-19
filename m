Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7502606A324
	for <amd-gfx@archiver.kernel.org>; Thu, 19 Nov 2026 11:35:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=XtHxRb/3
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6DDF81122DE;
	Thu, 19 Nov 2026 11:35:10 +0000 (UTC)
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com
 [209.85.221.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 558011122DE
 for <amd-gfx@lists.freedesktop.org>; Thu, 19 Nov 2026 11:35:04 +0000 (UTC)
Received: by mail-wr1-f47.google.com with SMTP id
 ffacd0b85a97d-4a5024b3c28so573498f8f.0
 for <amd-gfx@lists.freedesktop.org>; Thu, 19 Nov 2026 03:35:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795088102; x=1795692902; darn=lists.freedesktop.org;
 h=mime-version:user-agent:content-transfer-encoding:content-type
 :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=CnnZfT9fSJyIaZvUJIjnedebQ/iU9tJwQb7l9SNMHeE=;
 b=XtHxRb/3QbBH6/da9RlbrmcuwhH+YlQ9TqhJv7slzTI+2QpL/xKsMU7xIYkxa5G+N4
 canI7aURB8OU5BMAlzpa6JCDdN7qkWLX9xuGLT+p8TMzraZpLnsVFhq1v368vrW6ClFp
 R5HJTVMK/9Bz9+M6X2OFYW/MSA1UUUZRRLRAQo2h5h8Z2spkF3Rw8qBbNmBU1UYX+6rW
 LwPaXaWhBOhNnoZ8JP6SDcPqVHJd7HMLOoK6WjUIxTQv+9EqqAtaejFYJIg8eOeyoaJ+
 650ctFhWGC68kvBk82T6aI7mXJ6EDswFMR1WMDRCHAwdRF+z4r1H/9n/k1jEptsmaDJV
 G42g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795088102; x=1795692902;
 h=mime-version:user-agent:content-transfer-encoding:content-type
 :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=CnnZfT9fSJyIaZvUJIjnedebQ/iU9tJwQb7l9SNMHeE=;
 b=egrFRI5wN0Z43s3j/J6VN2qcfQ8abvV3g1kVWMdk6Io8lreGKQ3BNvGlxl3/XmyuWA
 9v8WjIFUvnXWVsP+wd5tYIXEneb+mlRpCu5HsCEIewJ5hjNsy5BFM7w0Apjg7Hn0qBvr
 GUyl/bhZuSWlN1Et6raRg9udSGJljEwNNPOZlnhE9vq+JDL2w4ppAbfZlp7CQ/m2pjCM
 Ff172XS5rgyZJG2dqP+bwpFFEc/CLxsX3z899en/1U8fmMVPebVjkD2w2VU2wxl9CqUj
 BvoEIl7GFUVy9WTRojc+F6AR6CwHaJcvGaFiQ+5jZci6D0OjcgC1/jgGFIHJXnuCmyqd
 dX5w==
X-Forwarded-Encrypted: i=1;
 AL+hErE5WougnmnbQw+A1PCeFBgT0dRXgAC6UOKsEOuVTzlHWf8TSfoO7rI7H0SCnquW8UJs6B0tyDW1@lists.freedesktop.org
X-Gm-Message-State: APuU4Z/YqKTeNkhW74EYnLpXq5WgTiI08RVLh85ccJFXGSVVNnuOqYYj
 FfguwcExbXN38OFlL+uCJNVFfs7HCBcin7Q9pA66xxwbUQEwUz1hKM99
X-Gm-Gg: AZFdTZcTjJCsW622r6lsyY7fZLLVqMWicqibfiReqGWwoXuO1EeT1m+es/ZviiFi+co
 xdscVFFOa8zrRQLo+bqs+PJmyz0fh36FpwQK6hOC/LtVeFviAdIMWNHmRQAvSCsbvxMzjTUZyJq
 v0CWbyiMb/9cDFkyBsAuRwrJzh5wNvYOpux/xvbh+7dvx+0swEsutQvJmW7xat+1bnfx7l5lAWP
 ndnD45noQ+Hge3SY2xZQrFexhfMPepWikgrp1S25aKKl5vamqNisYjPXxIXBP+SYvW80wf0NPrG
 EXMp4Y1mrbMW1rJVlMe+7wj1jka8XgXsHJFgXdjaz8I72SvCUS6kefL6RchbsZLyGoMmFmZrMDt
 mFzySZdai6uvmq9A/pxbJJ+2ZB0XSw53CpwG5nzru5dgGSdH7h7d7faBgxQWnxkRSRBWyJUFUNA
 j6bg/5/P/H0tfTMVag7ioCPaZQHd/bRW9OviBcTTJZlFpZuUhZxOqZw7a4IX72Z1jompWVzrHpH
 9R4jhqHzzm7QwIyIuamotzhAIxyuwkb7JEXskGqYF50NvXDlxQw06IOM8sBESA3+X3HcEH3wMlo
 YNB/9089Ec9cch+gH1p9CeuBpoBRAQD+nLv3YXn3rFIQCCKAS3vST7kf3aWXQOR/bDCmajLfpoo
 Rz8n/
X-Received: by 2002:a5d:5d87:0:b0:4a3:2ac:26a4 with SMTP id
 ffacd0b85a97d-4aa58527c76mr2284269f8f.23.1795088102422; 
 Thu, 19 Nov 2026 03:35:02 -0800 (PST)
Received: from [192.168.1.71] (115.red-2-136-224.staticip.rima-tde.net.
 [2.136.224.115]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4a654a8c406sm9916066f8f.14.2026.11.19.03.35.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Nov 2026 03:35:01 -0800 (PST)
Message-ID: <ce4d20f811d0f9484bc2b1a281e05ec970547791.camel@gmail.com>
Subject: Re: [PATCH v4 03/13] drm/amdgpu: add an engine scope to the IP
 block soft reset
From: Timur =?ISO-8859-1?Q?Krist=F3f?= <timur.kristof@gmail.com>
To: Jesse Zhang <Jesse.Zhang@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Alexander.Deucher@amd.com, Christian Koenig <christian.koenig@amd.com>, 
 Lijo.Lazar@amd.com, Mario.Novales@amd.com, Manu.Rastogi@amd.com, 
 Jiongyu.Zhu@amd.com
Date: Thu, 19 Nov 2026 12:35:00 +0100
In-Reply-To: <20261105030612.726542-3-Jesse.Zhang@amd.com>
References: <20261105030612.726542-1-Jesse.Zhang@amd.com>
 <20261105030612.726542-3-Jesse.Zhang@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.2 (3.60.2-3.fc44) 
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FORGED_GMAIL_RCVD,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Thu, 2026-11-05 at 11:05 +0800, Jesse Zhang wrote:
> Some IP blocks have engines the hardware can reset on their own, eg.
> the graphics and compute engines of the GFX IP. Add an optional
> soft_reset_engine() callback, which resets the engine of a ring type
> and
> recovers its user queues. amdgpu_device_ip_soft_reset() uses it
> instead
> of soft_reset(), and then only stops and replays the rings of that
> type,
> holding the reset domain for read: KFD can still add and remove
> queues
> on the other engines.
>=20
> A hung user queue has no kernel ring, so
> amdgpu_device_ip_soft_reset()
> now takes the device and the ring type, and an optional guilty ring
> and
> user queue.
>=20
> v3: New patch, replaces the separate engine reset type and helper
> =C2=A0=C2=A0=C2=A0 (Timur).
> v4: Fold the engine reset into amdgpu_device_ip_soft_reset(), and
> take
> =C2=A0=C2=A0=C2=A0 the ring type instead of a new engine enum (Timur).
>=20
> Suggested-by: Timur Krist=C3=B3f <timur.kristof@gmail.com>
> Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>

Reviewed-by: Timur Krist=C3=B3f <timur.kristof@gmail.com>


> ---
> =C2=A0drivers/gpu/drm/amd/amdgpu/amdgpu_ip.c=C2=A0=C2=A0 | 59 +++++++++++=
+++++------
> --
> =C2=A0drivers/gpu/drm/amd/amdgpu/amdgpu_ip.h=C2=A0=C2=A0 |=C2=A0 7 ++-
> =C2=A0drivers/gpu/drm/amd/amdgpu/amdgpu_job.c=C2=A0 |=C2=A0 3 +-
> =C2=A0drivers/gpu/drm/amd/include/amd_shared.h |=C2=A0 6 +++
> =C2=A04 files changed, 52 insertions(+), 23 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ip.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_ip.c
> index d0b0d3eaffc5..9d75bdb2c14b 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ip.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ip.c
> @@ -421,8 +421,11 @@ static u32 amdgpu_ring_mask_from_ip(const enum
> amd_ip_block_type ip_type)
> =C2=A0/**
> =C2=A0 * amdgpu_device_ip_soft_reset() - Perform a graceful soft reset on
> an IP block.
> =C2=A0 *
> - * @guilty_ring: The ring which is guilty of causing a reset.
> - * @guilty_fence: The fence which didn't signal.
> + * @adev: amdgpu device
> + * @ring_type: The type of the ring or user queue that hung.
> + * @guilty_ring: The ring which is guilty of causing a reset, or
> NULL.
> + * @guilty_fence: The fence which didn't signal on @guilty_ring.
> + * @guilty_queue: The user queue which is guilty of causing a reset,
> or NULL.
> =C2=A0 *
> =C2=A0 * IP block soft reset is used when attempting to recover
> =C2=A0 * from a GPU hang in a situation where a more fine grained
> @@ -430,55 +433,71 @@ static u32 amdgpu_ring_mask_from_ip(const enum
> amd_ip_block_type ip_type)
> =C2=A0 * resets all rings that belong to the same device IP block
> =C2=A0 * and re-initializes the device IP block.
> =C2=A0 *
> + * IP blocks implementing soft_reset_engine() only reset the engine
> of
> + * @ring_type and its rings, and recover its user queues.
> + *
> =C2=A0 * The reset is handled gracefully, meaning that we try to
> =C2=A0 * minimize collateral damage (ie. avoid rejecting non-guilty jobs)
> =C2=A0 * as well as back up and restore the contents of all rings
> =C2=A0 * so that the system can move on from the hang.
> =C2=A0 */
> -int amdgpu_device_ip_soft_reset(struct amdgpu_ring *guilty_ring,
> -				struct amdgpu_fence *guilty_fence)
> +int amdgpu_device_ip_soft_reset(struct amdgpu_device *adev,
> +				enum amdgpu_ring_type ring_type,
> +				struct amdgpu_ring *guilty_ring,
> +				struct amdgpu_fence *guilty_fence,
> +				struct amdgpu_usermode_queue
> *guilty_queue)
> =C2=A0{
> -	struct amdgpu_device *adev =3D guilty_ring->adev;
> +	const struct amd_ip_funcs *funcs;
> =C2=A0	struct amdgpu_ip_block *ip_block;
> =C2=A0	enum amd_ip_block_type ip_type;
> =C2=A0	u32 ring_type_mask;
> +	bool engine;
> =C2=A0	int r;
> =C2=A0
> -	ip_type =3D amdgpu_ip_from_ring(guilty_ring->funcs->type);
> +	ip_type =3D amdgpu_ip_from_ring(ring_type);
> =C2=A0	ip_block =3D amdgpu_device_ip_get_ip_block(adev, ip_type);
> =C2=A0
> =C2=A0	if (unlikely(!ip_block)) {
> -		dev_warn(adev->dev, "IP block not found for ring
> %s\n",
> -			 guilty_ring->name);
> +		dev_warn(adev->dev, "IP block not found for ring
> type %d\n",
> +			 ring_type);
> =C2=A0		return -EOPNOTSUPP;
> =C2=A0	}
> =C2=A0
> -	if (!ip_block->version->funcs->soft_reset) {
> +	funcs =3D ip_block->version->funcs;
> +	engine =3D funcs->soft_reset_engine;
> +	if (!engine && (!funcs->soft_reset || !guilty_ring)) {
> =C2=A0		dev_warn(adev->dev, "IP block soft reset not
> supported on %s\n",
> -			 ip_block->version->funcs->name);
> +			 funcs->name);
> =C2=A0		return -EOPNOTSUPP;
> =C2=A0	}
> =C2=A0
> -	dev_err(adev->dev, "Starting %s IP block soft reset\n",
> -		ip_block->version->funcs->name);
> -
> -	ring_type_mask =3D amdgpu_ring_mask_from_ip(ip_type);
> +	dev_err(adev->dev, "Starting %s IP block soft reset\n",
> funcs->name);
> =C2=A0
> -	amdgpu_device_lock_reset_domain(adev->reset_domain);
> +	/* An engine reset leaves the others running: let KFD
> add/remove queues. */
> +	if (engine) {
> +		ring_type_mask =3D BIT(ring_type);
> +		down_read(&adev->reset_domain->sem);
> +	} else {
> +		ring_type_mask =3D amdgpu_ring_mask_from_ip(ip_type);
> +		amdgpu_device_lock_reset_domain(adev->reset_domain);
> +	}
> =C2=A0	amdgpu_multi_ring_reset_helper_begin(adev, ring_type_mask,
> guilty_ring, guilty_fence);
> =C2=A0
> -	r =3D ip_block->version->funcs->soft_reset(ip_block);
> +	r =3D engine ? funcs->soft_reset_engine(ip_block, ring_type,
> guilty_queue) :
> +		=C2=A0=C2=A0=C2=A0=C2=A0 funcs->soft_reset(ip_block);
> =C2=A0
> =C2=A0	r =3D amdgpu_multi_ring_reset_helper_end(adev, ring_type_mask,
> guilty_ring, r);
> -	amdgpu_device_unlock_reset_domain(adev->reset_domain);
> +	if (engine)
> +		up_read(&adev->reset_domain->sem);
> +	else
> +		amdgpu_device_unlock_reset_domain(adev-
> >reset_domain);
> =C2=A0
> =C2=A0	if (r) {
> =C2=A0		dev_err(adev->dev, "Failed %s IP block soft reset:
> %d\n",
> -			ip_block->version->funcs->name, r);
> +			funcs->name, r);
> =C2=A0		return r;
> =C2=A0	}
> =C2=A0
> -	dev_err(adev->dev, "Successful %s IP block soft reset\n",
> -		ip_block->version->funcs->name);
> +	dev_err(adev->dev, "Successful %s IP block soft reset\n",
> funcs->name);
> =C2=A0	return 0;
> =C2=A0}
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ip.h
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_ip.h
> index 5dd6273982c4..6532c16b1a15 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ip.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ip.h
> @@ -158,7 +158,10 @@ int amdgpu_device_ip_wait_for_idle(struct
> amdgpu_device *adev,
> =C2=A0				=C2=A0=C2=A0 enum amd_ip_block_type
> block_type);
> =C2=A0bool amdgpu_device_ip_is_valid(struct amdgpu_device *adev,
> =C2=A0			=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 enum amd_ip_block_type bloc=
k_type);
> -int amdgpu_device_ip_soft_reset(struct amdgpu_ring *guilty_ring,
> -				struct amdgpu_fence *guilty_fence);
> +int amdgpu_device_ip_soft_reset(struct amdgpu_device *adev,
> +				enum amdgpu_ring_type ring_type,
> +				struct amdgpu_ring *guilty_ring,
> +				struct amdgpu_fence *guilty_fence,
> +				struct amdgpu_usermode_queue
> *guilty_queue);
> =C2=A0
> =C2=A0#endif /* __AMDGPU_IP_H__ */
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
> index 8689a3c933b2..cb72d273bd52 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
> @@ -154,7 +154,8 @@ static enum drm_gpu_sched_stat
> amdgpu_job_timedout(struct drm_sched_job *s_job)
> =C2=A0	/* Attempt an IP block soft reset, if supported. */
> =C2=A0	if (amdgpu_gpu_recovery &&
> =C2=A0	=C2=A0=C2=A0=C2=A0 amdgpu_ring_is_reset_type_supported(ring,
> AMDGPU_RESET_TYPE_IP_BLOCK_SOFT_RESET)) {
> -		r =3D amdgpu_device_ip_soft_reset(ring, job-
> >hw_fence);
> +		r =3D amdgpu_device_ip_soft_reset(adev, ring->funcs-
> >type, ring,
> +						job->hw_fence,
> NULL);
> =C2=A0		if (!r) {
> =C2=A0			atomic_inc(&ring->adev->gpu_reset_counter);
> =C2=A0			drm_dev_wedged_event(adev_to_drm(adev),
> DRM_WEDGE_RECOVERY_NONE, info);
> diff --git a/drivers/gpu/drm/amd/include/amd_shared.h
> b/drivers/gpu/drm/amd/include/amd_shared.h
> index e81ce9d79009..06874a338b27 100644
> --- a/drivers/gpu/drm/amd/include/amd_shared.h
> +++ b/drivers/gpu/drm/amd/include/amd_shared.h
> @@ -29,6 +29,7 @@
> =C2=A0
> =C2=A0#define AMD_MAX_USEC_TIMEOUT		1000000=C2=A0 /* 1000 ms */
> =C2=A0struct amdgpu_ip_block;
> +struct amdgpu_usermode_queue;
> =C2=A0
> =C2=A0
> =C2=A0/*
> @@ -421,6 +422,7 @@ enum DC_DEBUG_MASK {
> =C2=A0};
> =C2=A0
> =C2=A0enum amd_dpm_forced_level;
> +enum amdgpu_ring_type;
> =C2=A0
> =C2=A0/**
> =C2=A0 * struct amd_ip_funcs - general hooks for managing amdgpu IP Block=
s
> @@ -441,6 +443,7 @@ enum amd_dpm_forced_level;
> =C2=A0 * @complete: handles IP specific changes after resume
> =C2=A0 * @wait_for_idle: poll for idle
> =C2=A0 * @soft_reset: soft reset the IP block
> + * @soft_reset_engine: soft reset the engine of a ring type and its
> user queues
> =C2=A0 * @set_clockgating_state: enable/disable cg for the IP block
> =C2=A0 * @set_powergating_state: enable/disable pg for the IP block
> =C2=A0 * @get_clockgating_state: get current clockgating status
> @@ -469,6 +472,9 @@ struct amd_ip_funcs {
> =C2=A0	void (*complete)(struct amdgpu_ip_block *ip_block);
> =C2=A0	int (*wait_for_idle)(struct amdgpu_ip_block *ip_block);
> =C2=A0	int (*soft_reset)(struct amdgpu_ip_block *ip_block);
> +	int (*soft_reset_engine)(struct amdgpu_ip_block *ip_block,
> +				 enum amdgpu_ring_type ring_type,
> +				 struct amdgpu_usermode_queue
> *guilty_queue);
> =C2=A0	int (*set_clockgating_state)(struct amdgpu_ip_block
> *ip_block,
> =C2=A0				=C2=A0=C2=A0=C2=A0=C2=A0 enum amd_clockgating_state
> state);
> =C2=A0	int (*set_powergating_state)(struct amdgpu_ip_block
> *ip_block,
