Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C8D1606A332
	for <amd-gfx@archiver.kernel.org>; Wed, 18 Nov 2026 22:44:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bq90stGe
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9D4D610E3BB;
	Wed, 18 Nov 2026 22:44:43 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id ED48710E3BB
 for <amd-gfx@lists.freedesktop.org>; Wed, 18 Nov 2026 22:44:37 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 7BF1940DB9;
 Wed, 18 Nov 2026 22:44:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 377D51F000C7;
 Wed, 18 Nov 2026 22:44:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795041877;
 bh=O/QkkBTyaA4xi17j5zaQFOhelDy9OSNanovIsQOMqaA=;
 h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
 b=bq90stGeSb4RESm3k0YgGbfZ3Ak3wEaoKaMmrMxVd5t4k/+i9+BulM31Hdlf7zhyr
 8op+9Q4FKuQ7Ji2hZ5UTk3Yi0r1MO45KXRhBYK6NeCw8lwBt1G8yRvahXYJ3KftdrD
 cL7B7Xezjqg/9ZQ0LNrtyE3k7cfJi6p6+XbQILwQDH71jaXbNwxv3cwkE9IHE7EAH/
 UHXovxBS2BYUfEyP/mcmgoyHO4hVzf7VCmnceHdcc9bNlwh8KVC5lAMCAKKXo34LIb
 2iLQxc+qP6QUV53ZRsko4YRqj0k3r/2Fa1skMcCNB/23XTRo7aceDOfkEL7ijFsiec
 rna2f46K0Z4AA==
Message-ID: <sashiko-outbox-222122@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 07/11] drm/amdgpu/userq/mes: implement set gang submit
To: "Alex Deucher" <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
In-Reply-To: <20261118223712.2518580-7-alexander.deucher@amd.com>
References: <20261118223712.2518580-1-alexander.deucher@amd.com>
 <20261118223712.2518580-7-alexander.deucher@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 18 Nov 2026 22:44:36 +0000
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

Thank you for your contribution! Sashiko AI review found no new issues
in this patch, but noticed 1 related pre-existing issue it does not
introduce:
- [High] drm/amdgpu: gang context array index leak in mes_userq_map()
  [1]
--

commit d0ceeae2277f6c5db3f1b3901e53f85f8174b593
Author: Alex Deucher <alexander.deucher@amd.com>

drm/amdgpu/userq/mes: implement set gang submit

This commit implements the .set_gang callback in userq_mes_funcs to support
gang submission for MES usermode queues.

> diff --git a/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c b/drivers/gpu/drm=
/amd/amdgpu/mes_userqueue.c
> index 7abb9d95ef59a..68c10a8adcd20 100644
> --- a/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
> +++ b/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
> @@ -649,6 +649,36 @@ static int mes_userq_restore(struct amdgpu_usermode_=
queue *queue)
>  	return r;
>  }
> =20
> +static int mes_set_gang(struct amdgpu_usermode_queue *primary_queue,
> +			struct amdgpu_usermode_queue *secondary_queue)
> +{
> +	struct amdgpu_userq_obj *primary_ctx =3D &primary_queue->fw_obj;
> +	struct amdgpu_userq_obj *secondary_ctx =3D &secondary_queue->fw_obj;
> +	struct amdgpu_userq_mgr *uq_mgr =3D primary_queue->userq_mgr;
> +	struct amdgpu_device *adev =3D uq_mgr->adev;
> +	struct mes_set_gang_submit_input input;
> +	struct amdgpu_mes *mes =3D &adev->mes;
> +	int r;
> +
> +	memset(&input, 0x0, sizeof(struct mes_set_gang_submit_input));
> +
> +	input.primary_gang_context_addr =3D primary_ctx->gpu_addr;
> +	input.secondary_gang_context_addr =3D secondary_ctx->gpu_addr;
> +	if (mes->use_rs64mem) {
> +		input.primary_gang_context_array_idx =3D
> +			primary_queue->gang_ctx_array_index;
> +		input.secondary_gang_context_array_idx =3D
> +			secondary_queue->gang_ctx_array_index;
> +	}

[Severity: High]
This problem wasn't introduced by this patch, but does mes_userq_map() leak
queue->gang_ctx_array_index [1] when add_hw_queue() fails?

drivers/gpu/drm/amd/amdgpu/mes_userqueue.c:mes_userq_map() {
	...
	if (mes->use_rs64mem) {
		...
		r =3D amdgpu_mes_alloc_gang_ctx_index(mes, &queue->gang_ctx_array_index);
		if (r) {
			DRM_ERROR("Failed to allocate userq gang index err:%d\n", r);
			return r;
		}
		queue_input.process_context_array_index =3D uq_mgr->proc_ctx_array_index;
		queue_input.gang_context_array_index =3D queue->gang_ctx_array_index;
	}

	amdgpu_mes_lock(&adev->mes);
	r =3D adev->mes.funcs->add_hw_queue(&adev->mes, &queue_input);
	amdgpu_mes_unlock(&adev->mes);
	if (r) {
		DRM_ERROR("Failed to map queue in HW, err (%d)\n", r);
		return r;
	}
	...
}

When add_hw_queue() fails during amdgpu_userq_create(), mes_userq_map()
returns without calling amdgpu_mes_free_gang_ctx_index(), and the caller's
error cleanup does not call mes_userq_unmap().  Repeated mapping failures
can exhaust the gang context bitmap and prevent creating new MES user
queues.

[1] https://sashiko.dev/#/bug/linux-70b9dde6-e881-480d-9c56-534a231e5249

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261118223712.2518=
580-1-alexander.deucher@amd.com?part=3D7
