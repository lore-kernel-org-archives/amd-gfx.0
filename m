Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D19ED606A324
	for <amd-gfx@archiver.kernel.org>; Thu, 19 Nov 2026 11:36:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=JdwMzp6y
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4725010E84E;
	Thu, 19 Nov 2026 11:36:48 +0000 (UTC)
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com
 [209.85.221.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2575C1122E9
 for <amd-gfx@lists.freedesktop.org>; Thu, 19 Nov 2026 11:36:42 +0000 (UTC)
Received: by mail-wr1-f46.google.com with SMTP id
 ffacd0b85a97d-4a7b8abe209so1177569f8f.0
 for <amd-gfx@lists.freedesktop.org>; Thu, 19 Nov 2026 03:36:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795088200; x=1795693000; darn=lists.freedesktop.org;
 h=mime-version:user-agent:content-transfer-encoding:content-type
 :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=FXoJZiQ66MwnbeGm33G/ayOc4z8bVnLZXid7nHoNNyc=;
 b=JdwMzp6yCKcV10B28N3S0Z3Lt8xXPTnCGFo9EPtqFgNfbIztZI0T5uqdhs926+NzPb
 ni+oD//SB39JWNK+HdLdAuPyegeM6s/qw6anmp/ZH4AwVd7RoP/ncAW3MFsMSLbTB8or
 jfrAIj4rM7e7dj/6senIzYTyhejEYWs3hjd4TbAgeGwnaBsgZwKUFrsgS/37e83ssEmy
 N5Mb8E0rKVXnqNUOU/Chcyu7u7Mz9fp+Y7J7SzOjAdo0hkVeqbmY/gd2xHieBgkE3oNG
 mz/3tRLUt/m7+wiKmD7xNXyLb+QmWj/e/2KfvBz/cronE91Z62rgA5zK2JYE/gshyBbR
 EAGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795088200; x=1795693000;
 h=mime-version:user-agent:content-transfer-encoding:content-type
 :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=FXoJZiQ66MwnbeGm33G/ayOc4z8bVnLZXid7nHoNNyc=;
 b=b5MnB99DfIhOZ3duA293A+Tq4YD8Z+io50DBjt2sfj5Gq1g1ipJE3EJii8umlj4mcE
 fXdQJBITyQfb2MxG98KqbEVLHOFLnGlGprsO0hgrhiDvWGKQtPQpF2rj3rQjjGM6OVg4
 nXHkr9GYRQKJiECsVyUzgLWELRZMrP+wkq0+LSrIAxaIPGIZbeNHfn2baQEm0SDdaDp4
 e6A4qOULP2tgf+F7jnZpwDoh4mBNvwVPOrs5A15sUKyVhsrn7HDhDLeZcKxldlx9T1/T
 Z7hdYv8PKOyH8SDnMiCgsHcxPvaQwGjCPxihqeaVBa98QtovbR4qP7tiJIjDVSzvCxlX
 fYOA==
X-Forwarded-Encrypted: i=1;
 AL+hErFyXjFt6JHazliHpd1iV8RAtwufdhybVOZhYFIV7orJoBKoyMntDtPWqHsHw3NH+qd/R5SdC0Wm@lists.freedesktop.org
X-Gm-Message-State: APuU4Z8Vzczt3UKfOSbvSQK5N8pePkSsjQ9o1SoxxOy8I8RE2JpIOU3T
 DrK1lXJBYuHGRw3RA+8EBVw4JI34wpt8Ob9wSkCpURC0ChBvu5AoKfvM
X-Gm-Gg: AYBFou267DU5GsTeuzWSQhCRP53nj4KXdqazPyrKc2dqZfOpRgAOft+NtGyLWswNXop
 Kwgk+ME7sMBe1o7O57bT1MVOr8FE9IGHMS9FJCeJzqzIwWmlo2iN2De9J7QX9WeQtbzo46aJDCX
 ynfMo3ZEKKYGCKqT8el1MRrBGnNUG5+gt14Gir9dz/5YCcqtvOXI6kzL6XRX/4FQHfJkiNALvfC
 mYLFy4G3tbju1522e7GPtmXScrl2bmSyWSTi3V+y695RSCGoFOAykYywK6/Q9zTc46pFalO9rjE
 M9k0qTE4h8kMOER/dpxFIg7qYPGE4K+/JJTf7MEVi2I7EG7IotqvgLloIXDDiG3tGcWg3K3oLk2
 dUEf46U1UYcVn8u9R3C0j8yrtMjb+Q62e8qUBRGr6ihBYliylbBhpjmYmeI7IH5VpWz2nii0aN1
 ZTEvlKJPpy8zNn3P1OdmCdC2+gnLznLDYQgVdMDkzjtHD2NBC8cubhkm2g9u6TheDrtdCc//fD1
 IP3GBHeI9ttmYUdbHpeg+nsRxhlkA9Ig6mHyl0wXSp9G80aOvzpiRIoSNEiWqY2BtR6kgnpcHrF
 MIfaZOjMHRa6FWcSGyOLHz8Iv7zu0Mtwa7MxbA6HPxrEJlzqqHbJmZev89h3V+FtWjyYK2IMhqb
 cv0SMe9JZQcxEKw6NeKTU2aFa8Q==
X-Received: by 2002:a05:600c:8b63:b0:4a7:8fe8:130c with SMTP id
 5b1f17b1804b1-4bb7da27088mr106631365e9.28.1795088200401; 
 Thu, 19 Nov 2026 03:36:40 -0800 (PST)
Received: from [192.168.1.71] (115.red-2-136-224.staticip.rima-tde.net.
 [2.136.224.115]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4a654a8c406sm9923441f8f.14.2026.11.19.03.36.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Nov 2026 03:36:39 -0800 (PST)
Message-ID: <1ec4c59a581ecb4b9753da5fcf06ca17b63b9f70.camel@gmail.com>
Subject: Re: [PATCH v4 08/13] drm/amdgpu/userq: add helpers to keep the user
 queues of one engine across a reset
From: Timur =?ISO-8859-1?Q?Krist=F3f?= <timur.kristof@gmail.com>
To: Jesse Zhang <Jesse.Zhang@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Alexander.Deucher@amd.com, Christian Koenig <christian.koenig@amd.com>, 
 Lijo.Lazar@amd.com, Mario.Novales@amd.com, Manu.Rastogi@amd.com, 
 Jiongyu.Zhu@amd.com
Date: Thu, 19 Nov 2026 12:36:38 +0100
In-Reply-To: <20261105030612.726542-8-Jesse.Zhang@amd.com>
References: <20261105030612.726542-1-Jesse.Zhang@amd.com>
 <20261105030612.726542-8-Jesse.Zhang@amd.com>
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

On Thu, 2026-11-05 at 11:05 +0800, Jesse Zhang wrote:
> An engine reset, eg. of the gfx engine, only resets the queues of one
> engine of the GFX IP; the queues of the other engines aren't reset.
> amdgpu_userq_pre_reset() and amdgpu_userq_post_reset() handle all the
> user queues for a full reset. Add separate helpers for the queues of
> one
> engine, which keep them in the state they had:
>=20
> - amdgpu_userq_save_hqds(), called after the MES suspend, saves the
> HQD
> =C2=A0 of the mapped queues still on a HQD: the reset clears their HQD,
> and
> =C2=A0 MES couldn't preempt them into their MQD. The queues MES preempted
> =C2=A0 have their state in their MQD already.
> - amdgpu_userq_restore_hqds(), called after the reset but before MES
> =C2=A0 resumes, unmaps those queues, writes the saved HQD into their MQD
> and
> =C2=A0 maps them again: MES doesn't map a queue whose HQD the reset
> cleared
> =C2=A0 again on its own. The queues keep their state and their work,
> except
> =C2=A0 the one the pipe executed: its work in flight depends on pipe stat=
e
> =C2=A0 the reset cleared, it is dropped and its fences signaled. The queu=
e
> =C2=A0 that hung, if any, is unmapped and hung.
> - amdgpu_userq_clear_hqds() drops the saved HQDs for the full reset
> that
> =C2=A0 follows a failed engine reset.
>=20
> The helpers walk the queues and unmap and map them as
> amdgpu_userq_pre_reset() and amdgpu_userq_post_reset() do. The saved
> HQDs are kept in the gfx IP, in saved_gfx_hqds[], and matched to a
> queue
> by its doorbell and MQD address.
>=20
> v2: Drop the user queue reset lock and the walk over the queues of
> one
> =C2=A0=C2=A0=C2=A0 type (Christian).
> v4: Rename the helpers and the saved HQD array (Timur).
>=20
> Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>

Reviewed-by: Timur Krist=C3=B3f <timur.kristof@gmail.com>

> ---
> =C2=A0drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h=C2=A0=C2=A0 |=C2=A0=C2=A0 3=
 +
> =C2=A0drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c | 107
> ++++++++++++++++++++++
> =C2=A0drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h |=C2=A0=C2=A0 4 +
> =C2=A03 files changed, 114 insertions(+)
>=20
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
> index 1c23e97fd04d..79cb6be75329 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
> @@ -515,6 +515,9 @@ struct amdgpu_gfx {
> =C2=A0
> =C2=A0	/* reset mask */
> =C2=A0	uint32_t=C2=A0			gfx_supported_reset;
> +	/* HQDs of the gfx user queues, saved by an engine reset */
> +	struct
> amdgpu_gfx_saved_hqd	saved_gfx_hqds[AMDGPU_MAX_GFX_QUEUES];
> +	u32				num_saved_gfx_hqds;
> =C2=A0	uint32_t=C2=A0			compute_supported_reset;
> =C2=A0
> =C2=A0	/* gfx off */
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> index ccf0ff490ac2..7d0c4e8795b4 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> @@ -1594,3 +1594,110 @@ int amdgpu_userq_post_reset(struct
> amdgpu_device *adev, bool vram_lost)
> =C2=A0
> =C2=A0	return ret;
> =C2=A0}
> +
> +/**
> + * amdgpu_userq_save_hqds - save the HQDs of the user queues before
> an engine reset
> + * @adev: amdgpu device
> + * @queue_type: AMDGPU_HW_IP_* type of the queues on the reset
> engine
> + */
> +void amdgpu_userq_save_hqds(struct amdgpu_device *adev, u32
> queue_type)
> +{
> +	struct amdgpu_gfx_saved_hqd hqd;
> +	struct amdgpu_usermode_queue *queue;
> +	unsigned long queue_id;
> +
> +	adev->gfx.num_saved_gfx_hqds =3D 0;
> +	if (!adev->gfx.funcs->save_hqd)
> +		return;
> +
> +	xa_for_each(&adev->userq_doorbell_xa, queue_id, queue) {
> +		if (adev->gfx.num_saved_gfx_hqds >=3D
> AMDGPU_MAX_GFX_QUEUES)
> +			break;
> +		if (queue->queue_type !=3D queue_type ||
> +		=C2=A0=C2=A0=C2=A0 queue->state !=3D AMDGPU_USERQ_STATE_MAPPED)
> +			continue;
> +		if (adev->gfx.funcs->save_hqd(adev, queue-
> >doorbell_index, &hqd) &&
> +		=C2=A0=C2=A0=C2=A0 hqd.on_hqd)
> +			adev->gfx.saved_gfx_hqds[adev-
> >gfx.num_saved_gfx_hqds++] =3D hqd;
> +	}
> +}
> +
> +static struct amdgpu_gfx_saved_hqd *
> +amdgpu_userq_find_saved_hqd(struct amdgpu_device *adev,
> +			=C2=A0=C2=A0=C2=A0 struct amdgpu_usermode_queue *queue)
> +{
> +	struct amdgpu_gfx_saved_hqd *hqd;
> +	u32 i;
> +
> +	for (i =3D 0; i < adev->gfx.num_saved_gfx_hqds; i++) {
> +		hqd =3D &adev->gfx.saved_gfx_hqds[i];
> +		/* Check the MQD too: a new queue may reuse the
> doorbell. */
> +		if (hqd->doorbell_index =3D=3D queue->doorbell_index &&
> +		=C2=A0=C2=A0=C2=A0 hqd->mqd_addr =3D=3D queue->mqd.gpu_addr)
> +			return hqd;
> +	}
> +	return NULL;
> +}
> +
> +/**
> + * amdgpu_userq_restore_hqds - restore the user queues after an
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
> +void amdgpu_userq_restore_hqds(struct amdgpu_device *adev, u32
> queue_type,
> +			=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct amdgpu_usermode_queue *gu=
ilty)
> +{
> +	const struct amdgpu_userq_funcs *userq_funcs =3D adev-
> >userq_funcs[queue_type];
> +	struct amdgpu_usermode_queue *queue;
> +	struct amdgpu_gfx_saved_hqd *hqd;
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
> +		hqd =3D amdgpu_userq_find_saved_hqd(adev, queue);
> +		if (!hqd)
> +			continue;
> +
> +		userq_funcs->unmap(queue);
> +		if (adev->gfx.funcs->restore_hqd(adev, queue-
> >mqd.cpu_ptr,
> +						 queue->userq_prop-
> >queue_size,
> +						 hqd))
> +			amdgpu_userq_fence_driver_force_completion_w
> ith_seqno(queue,
> +							=09
> 	=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 hqd->wptr);
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
> +	adev->gfx.num_saved_gfx_hqds =3D 0;
> +}
> +
> +/**
> + * amdgpu_userq_clear_hqds - drop the saved HQDs after a failed
> engine reset
> + * @adev: amdgpu device
> + * @queue_type: AMDGPU_HW_IP_* type of the queues on the reset
> engine
> + */
> +void amdgpu_userq_clear_hqds(struct amdgpu_device *adev, u32
> queue_type)
> +{
> +	adev->gfx.num_saved_gfx_hqds =3D 0;
> +}
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
> index 488dc21d7c81..b5195031877d 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
> @@ -181,6 +181,10 @@ int
> amdgpu_userq_start_sched_for_enforce_isolation(struct amdgpu_device
> *adev,
> =C2=A0void amdgpu_userq_reset_work(struct work_struct *work);
> =C2=A0void amdgpu_userq_pre_reset(struct amdgpu_device *adev);
> =C2=A0int amdgpu_userq_post_reset(struct amdgpu_device *adev, bool
> vram_lost);
> +void amdgpu_userq_save_hqds(struct amdgpu_device *adev, u32
> queue_type);
> +void amdgpu_userq_restore_hqds(struct amdgpu_device *adev, u32
> queue_type,
> +			=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct amdgpu_usermode_queue
> *guilty);
> +void amdgpu_userq_clear_hqds(struct amdgpu_device *adev, u32
> queue_type);
> =C2=A0void amdgpu_userq_start_hang_detect_work(struct
> amdgpu_usermode_queue *queue);
> =C2=A0void amdgpu_userq_process_fence_irq(struct amdgpu_device *adev, u32
> doorbell);
> =C2=A0
