Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32A9B606EE98
	for <amd-gfx@archiver.kernel.org>; Tue,  3 Nov 2026 20:37:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=XDcvkTtD
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BEC6A10F82D;
	Tue,  3 Nov 2026 20:37:47 +0000 (UTC)
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com
 [209.85.221.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0272F10F825
 for <amd-gfx@lists.freedesktop.org>; Tue,  3 Nov 2026 20:37:41 +0000 (UTC)
Received: by mail-wr1-f42.google.com with SMTP id
 ffacd0b85a97d-48b042c0728so1832f8f.1
 for <amd-gfx@lists.freedesktop.org>; Tue, 03 Nov 2026 12:37:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793738260; x=1794343060; darn=lists.freedesktop.org;
 h=mime-version:user-agent:content-transfer-encoding:content-type
 :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=i2wVP+UfPvp6WiBhLPo/XrAjuc9P7Sjh+wPdjhJSh6Q=;
 b=XDcvkTtDP/Kk20bixQF/zp6OCvKfDrIEzvLgpZcdLMl3QjGstRZxmPJSBs0ZAc+ija
 GO5aAVTkYVdGC9921tlc5DHDV5iTK/HzofvQwlijp/pOZ/ChI+WxzK8IYyTwGXjQfYat
 JV+EB8Km74OayLqUivDx2tKZywyV0yuxC9XdMgQ39xZ+EfEt1KsBgVb/+IGwAOA6xQzt
 ANYF8GC2Nk3gfwkFXIRfJlaPKijWptr5KoMIG+WmsY+4b6NgSi9kRe3y+UwkZsKD/SLf
 +NKchlN9RT7QC77PEjmVmTua4DsMuUOykejeyKfUklRY17lXwTLZ2wVDG0p5uixUKcEb
 RlMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793738260; x=1794343060;
 h=mime-version:user-agent:content-transfer-encoding:content-type
 :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=i2wVP+UfPvp6WiBhLPo/XrAjuc9P7Sjh+wPdjhJSh6Q=;
 b=zhNloYBu16tszF6P/cuztnQQA0QsCi0jNLHmAKmh2clHhr/x9c4j26BxKsZE6cmh3Q
 MSRdVgAFkYkuBLvMGzy4NUSlBbY8Krt9YKXB3RDSkwE9WlKWQ/TEDXfD1jmnl/uE+6WA
 t6+0TBY15R5/ni855eTZ0rkbtAt29aiFFdbSZ2TRQBTmps/aP9rOFCi/uF/OzPXnuzO/
 ims20Tm5lf+0/Ac1uAT0fGR8Uwin4jSdNcaXb3pyZsSqNoIMUYIZ/YZLxXN8MbaKaQiL
 UKi6MatA38D9n54LB72ewzkjJORQUwE3S6aXy+vP8n6C6YIV2H0xeWlOdhKwzpOXZgg0
 DYYw==
X-Forwarded-Encrypted: i=1;
 AKwUvBypSeH5iu9NKJoNMUsv6YnsHlIcTtTLiYgB+OoekZfVqVXfFuhzdW52ztIyiPc3fjRlHZNi91d4@lists.freedesktop.org
X-Gm-Message-State: APuU4Z9d0uv7b5YIJil5P8bXL2vMOoc+k1Of14ArRvuQIiEiJh43fDt0
 3hAjCLjS4KLBKW3DYbkCHdx2ZddW5Q1ZLu+6Tq2YdUVLKIlruPaQTC6O
X-Gm-Gg: AYBFou0bHHApStLuQxGQ6w2gSnVrWOAkHSRUqZ7hylTKPw16Jx85zZcKPB03Wx4nuIv
 VPUHxeIA22sFZbNNIup6qNZQVP9+IH8kvKseUHOJUBxmL7UKTgZCwb/0JuIwOUXWHYR5UovWRS1
 f8/Ie6S87kWjQerrpfDYdhb4Cf+wR7lIiptax7azW0p6lgNxeVPR95y0waIJSWE5Vl2zGcQBThM
 a/jtFF4Dnm4nqVxPZpotES2eMqVnSor/EDemv2wGrZpA6HqHXe/28+f4ZAZj/0jhqMombKaivCV
 +52fPMZlMONLH46qXiXh0aItOkrbxRhlucHuSMPNQD6Ok+xP1D0C0tRyQ8I4mN+1K2c83+dNhOy
 +ax8dWE9sh8min4QA/x8Y4+YCwjJu166VhxnV5viz/dELPCYbd/RG56ZVCNjuFP3VS2Jn/ep6s/
 b19xcgS89fKGtPRundsNsXkYM6Xo82SvCZkKIAgzHT+azepANK582VV7pkkXLHSEbHBqrspro11
 Dpd1V0TYSevOUQKS97awRX9vDR8mu/6YnMwBBnk1dWzWlY0CZhYo7ZSma3H9N3nW+CsyWuztvx4
 mey3KTWUfD48RPLrYTowzjxbc9/aaCglaBqIG1cKMtuPQQs27biziFefO72YvkV+xvePIHVPQ83
 Q/tjjpv5i
X-Received: by 2002:a05:6000:4210:b0:48d:f984:4a7f with SMTP id
 ffacd0b85a97d-48e6e2f7356mr34426772f8f.24.1793738260296; 
 Tue, 03 Nov 2026 12:37:40 -0800 (PST)
Received: from [192.168.1.86] (240.red-79-154-229.dynamicip.rima-tde.net.
 [79.154.229.240]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48fcca7cfedsm491845f8f.38.2026.11.03.12.37.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Nov 2026 12:37:39 -0800 (PST)
Message-ID: <47c1a6eca2bd374f0ac354453630fef1a46a9826.camel@gmail.com>
Subject: Re: [PATCH v3 11/15] drm/amdgpu/userq: add helpers to keep the user
 queues of one engine across a reset
From: Timur =?ISO-8859-1?Q?Krist=F3f?= <timur.kristof@gmail.com>
To: Jesse Zhang <Jesse.Zhang@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Alexander.Deucher@amd.com, Christian Koenig <christian.koenig@amd.com>, 
 Lijo.Lazar@amd.com, Mario.Novales@amd.com, Manu.Rastogi@amd.com, 
 Jiongyu.Zhu@amd.com
Date: Tue, 03 Nov 2026 21:37:39 +0100
In-Reply-To: <20261028085736.3808569-11-Jesse.Zhang@amd.com>
References: <20261028085736.3808569-1-Jesse.Zhang@amd.com>
 <20261028085736.3808569-11-Jesse.Zhang@amd.com>
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
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Wed, 2026-10-28 at 16:56 +0800, Jesse Zhang wrote:
> An engine reset, eg. of the gfx engine, only resets the queues of one
> engine of the GFX IP; the queues of the other engines aren't reset.
> amdgpu_userq_pre_reset() and amdgpu_userq_post_reset() handle all the
> user queues for a full reset. Add separate helpers for the queues of
> one
> engine, which keep them in the state they had:
>=20
> - amdgpu_userq_pre_engine_reset(), called after the MES suspend,
> saves
> =C2=A0 the ring state of the mapped queues still on a HQD: the reset
> clears
> =C2=A0 their HQD, and MES couldn't preempt them into their MQD. The queue=
s
> =C2=A0 MES preempted have their state in their MQD already.
> - amdgpu_userq_post_engine_reset(), called after the reset but before
> =C2=A0 MES resumes, unmaps those queues, puts the saved ring state in
> their
> =C2=A0 MQD and maps them again: MES doesn't map a queue whose HQD the
> reset
> =C2=A0 cleared again on its own. The queues keep their state and their
> work,
> =C2=A0 except the one the pipe executed: its work in flight depends on
> pipe
> =C2=A0 state the reset cleared, it is dropped and its fences signaled. Th=
e
> =C2=A0 queue that hung, if any, is unmapped and hung.
> - amdgpu_userq_cancel_engine_reset() drops the saved ring state for
> the
> =C2=A0 full reset that follows a failed engine reset.
>=20
> The helpers walk the queues and unmap and map them as
> amdgpu_userq_pre_reset() and amdgpu_userq_post_reset() do. The saved
> ring state is kept in the gfx IP, per HQD, and matched to a queue by
> its
> doorbell and MQD address.
>=20
> v2: Drop the user queue reset lock and the walk over the queues of
> one
> =C2=A0=C2=A0=C2=A0 type (Christian).
>=20
> Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
> ---
> =C2=A0drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h=C2=A0=C2=A0 |=C2=A0=C2=A0 3=
 +
> =C2=A0drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c | 108
> ++++++++++++++++++++++
> =C2=A0drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h |=C2=A0=C2=A0 5 +
> =C2=A03 files changed, 116 insertions(+)
>=20
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
> index f750b11f4ad4..6bbf53359a49 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
> @@ -518,6 +518,9 @@ struct amdgpu_gfx {
> =C2=A0
> =C2=A0	/* reset mask */
> =C2=A0	uint32_t=C2=A0			gfx_supported_reset;
> +	/* ring state of the gfx user queues on a HQD, saved by an
> engine reset */
> +	struct
> amdgpu_gfx_hqd_ptrs	engine_reset_hqds[AMDGPU_MAX_GFX_QUEUES];
> +	u32				num_engine_reset_hqds;

Instead of "engine_reset_hqds", I suggest: "saved_gfx_hqds",
assuming GFX is different enough from a compute HQD that we won't be
able to reuse this for compute.

> =C2=A0	uint32_t=C2=A0			compute_supported_reset;
> =C2=A0
> =C2=A0	/* gfx off */
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> index 1a2aa85c504e..353c5f7cfcdd 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> @@ -1597,3 +1597,111 @@ int amdgpu_userq_post_reset(struct
> amdgpu_device *adev, bool vram_lost)
> =C2=A0
> =C2=A0	return ret;
> =C2=A0}
> +
> +/**
> + * amdgpu_userq_pre_engine_reset - save the ring state of the user
> queues
> + * @adev: amdgpu device
> + * @queue_type: AMDGPU_HW_IP_* type of the queues on the reset
> engine
> + */
> +void amdgpu_userq_pre_engine_reset(struct amdgpu_device *adev, u32
> queue_type)

I suggest to rename this to: amdgpu_userq_save_hqds()

> +{
> +	struct amdgpu_gfx_hqd_ptrs ptrs;
> +	struct amdgpu_usermode_queue *queue;
> +	unsigned long queue_id;
> +
> +	adev->gfx.num_engine_reset_hqds =3D 0;
> +	if (!adev->gfx.funcs->read_gfx_hqd_ptrs)
> +		return;
> +
> +	xa_for_each(&adev->userq_doorbell_xa, queue_id, queue) {
> +		if (adev->gfx.num_engine_reset_hqds >=3D
> AMDGPU_MAX_GFX_QUEUES)
> +			break;
> +		if (queue->queue_type !=3D queue_type ||
> +		=C2=A0=C2=A0=C2=A0 queue->state !=3D AMDGPU_USERQ_STATE_MAPPED)
> +			continue;
> +		if (adev->gfx.funcs->read_gfx_hqd_ptrs(adev, queue-
> >doorbell_index,
> +						=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 &ptrs) &&
> ptrs.on_hqd)
> +			adev->gfx.engine_reset_hqds[adev-
> >gfx.num_engine_reset_hqds++] =3D ptrs;
> +	}
> +}
> +
> +static struct amdgpu_gfx_hqd_ptrs *
> +amdgpu_userq_engine_reset_hqd(struct amdgpu_device *adev,
> +			=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct amdgpu_usermode_queue *queue)

This function seems to not reset anything, but just searches in the
array of saved HQDs. I suggest to rename to:
"amdgpu_userq_find_saved_hqd"

> +{
> +	struct amdgpu_gfx_hqd_ptrs *ptrs;
> +	u32 i;
> +
> +	for (i =3D 0; i < adev->gfx.num_engine_reset_hqds; i++) {
> +		ptrs =3D &adev->gfx.engine_reset_hqds[i];
> +		/* Check the MQD too: a new queue may reuse the
> doorbell. */
> +		if (ptrs->doorbell_index =3D=3D queue->doorbell_index &&
> +		=C2=A0=C2=A0=C2=A0 ptrs->mqd_addr =3D=3D queue->mqd.gpu_addr)
> +			return ptrs;
> +	}
> +	return NULL;
> +}
> +
> +/**
> + * amdgpu_userq_post_engine_reset - restore the user queues after an
> engine reset
> + * @adev: amdgpu device
> + * @queue_type: AMDGPU_HW_IP_* type of the queues on the reset
> engine
> + * @guilty: the queue that hung, or NULL
> + *
> + * MES doesn't map a queue whose HQD the reset cleared again on its
> own: unmap
> + * it from MES, restore its MQD, and map it again.
> + */
> +void amdgpu_userq_post_engine_reset(struct amdgpu_device *adev, u32
> queue_type,
> +				=C2=A0=C2=A0=C2=A0 struct amdgpu_usermode_queue
> *guilty)

I suggest to rename this to: amdgpu_userq_restore_hqds() to better
describe what this is doing.

> +{
> +	const struct amdgpu_userq_funcs *userq_funcs =3D adev-
> >userq_funcs[queue_type];
> +	struct amdgpu_usermode_queue *queue;
> +	struct amdgpu_gfx_hqd_ptrs *ptrs;
> +	unsigned long queue_id;
> +	int r;
> +
> +	xa_for_each(&adev->userq_doorbell_xa, queue_id, queue) {
> +		if (queue->queue_type !=3D queue_type ||
> +		=C2=A0=C2=A0=C2=A0 queue->state !=3D AMDGPU_USERQ_STATE_MAPPED)
> +			continue;
> +
> +		if (queue =3D=3D guilty) {
> +			userq_funcs->unmap(queue);
> +			amdgpu_userq_fence_driver_force_completion(q
> ueue);
> +			trace_amdgpu_userq_state_changed(queue,
> AMDGPU_USERQ_STATE_HUNG);
> +			queue->state =3D AMDGPU_USERQ_STATE_HUNG;
> +			continue;
> +		}
> +
> +		ptrs =3D amdgpu_userq_engine_reset_hqd(adev, queue);
> +		if (!ptrs)
> +			continue;
> +
> +		userq_funcs->unmap(queue);
> +		if (adev->gfx.funcs->restore_gfx_mqd_ring(adev,
> queue->mqd.cpu_ptr,
> +							=C2=A0 queue-
> >userq_prop->queue_size,
> +							=C2=A0 ptrs))
> +			amdgpu_userq_fence_driver_force_completion_w
> ith_seqno(queue,
> +							=09
> 	=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ptrs->wptr);
> +		r =3D userq_funcs->map(queue);
> +		if (r) {
> +			dev_err(adev->dev, "Failed to remap user
> queue %llu: %d\n",
> +				queue->doorbell_index, r);
> +			amdgpu_userq_fence_driver_force_completion(q
> ueue);
> +			trace_amdgpu_userq_state_changed(queue,
> AMDGPU_USERQ_STATE_HUNG);
> +			queue->state =3D AMDGPU_USERQ_STATE_HUNG;
> +		}
> +	}
> +	adev->gfx.num_engine_reset_hqds =3D 0;
> +}
> +
> +/**
> + * amdgpu_userq_cancel_engine_reset - give up an engine reset
> + * @adev: amdgpu device
> + * @queue_type: AMDGPU_HW_IP_* type of the queues on the reset
> engine
> + */
> +void amdgpu_userq_cancel_engine_reset(struct amdgpu_device *adev,
> +				=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 u32 queue_type)

amdgpu_userq_clear_hqds

> +{
> +	adev->gfx.num_engine_reset_hqds =3D 0;
> +}
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
> index 488dc21d7c81..e07c71cd5af5 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
> @@ -181,6 +181,11 @@ int
> amdgpu_userq_start_sched_for_enforce_isolation(struct amdgpu_device
> *adev,
> =C2=A0void amdgpu_userq_reset_work(struct work_struct *work);
> =C2=A0void amdgpu_userq_pre_reset(struct amdgpu_device *adev);
> =C2=A0int amdgpu_userq_post_reset(struct amdgpu_device *adev, bool
> vram_lost);
> +void amdgpu_userq_pre_engine_reset(struct amdgpu_device *adev, u32
> queue_type);
> +void amdgpu_userq_post_engine_reset(struct amdgpu_device *adev, u32
> queue_type,
> +				=C2=A0=C2=A0=C2=A0 struct amdgpu_usermode_queue
> *guilty);
> +void amdgpu_userq_cancel_engine_reset(struct amdgpu_device *adev,
> +				=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 u32 queue_type);
> =C2=A0void amdgpu_userq_start_hang_detect_work(struct
> amdgpu_usermode_queue *queue);
> =C2=A0void amdgpu_userq_process_fence_irq(struct amdgpu_device *adev, u32
> doorbell);
> =C2=A0
