Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A56F2606A32A
	for <amd-gfx@archiver.kernel.org>; Tue, 17 Nov 2026 19:35:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YnaZz9k1
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1485310F8F9;
	Tue, 17 Nov 2026 19:35:31 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7E6FB10F8F1
 for <amd-gfx@lists.freedesktop.org>; Tue, 17 Nov 2026 19:35:24 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 782B1612D6;
 Tue, 17 Nov 2026 19:35:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06E901F000C4;
 Tue, 17 Nov 2026 19:35:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794944123;
 bh=VRDUbo/t4sgrQgPBjbEAtyrCLwKzqEoiG/BsieLwHYU=;
 h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
 b=YnaZz9k1s7jcPZTGZ91D5lNoUgHqk7QB41qYgY1G198PF8Vlkrq8+uAugz0t4olUf
 JIHVPORVAnWolH5mKCcIiSGy90a41t3/O2SKrfAkbCpoBmybV9XE0W9+Lqw5vU/65s
 hbia1w11os+5dTRIuygpOLLbESHuwTQWgCJfAJbXkHyWqHdoOlYR2j/h4v8szFS+5R
 ZbE9D1b+IITokuZrcerqcMe9b1olX0VQpuzKnutWUJveR3zxjwDUnOJgc/CFpAZI3L
 BeqsdbCJSKckpK4vcm3v366g96aD8byV1cA5hEhoSxeqSyRbg2zvgskk7+qg9KD2Z6
 4gUpJb7PN1u6Q==
Message-ID: <sashiko-outbox-219493@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 6/9] drm/amdgpu/userq/mes: implement set gang submit
To: "Alex Deucher" <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
In-Reply-To: <20261117192415.810117-6-alexander.deucher@amd.com>
References: <20261117192415.810117-1-alexander.deucher@amd.com>
 <20261117192415.810117-6-alexander.deucher@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 17 Nov 2026 19:35:22 +0000
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
- [High] drm/amdgpu: out-of-bounds gang context address in
  mes_set_gang()
--

commit faefcb7998343e4f4e1ec3ab6ccf3f3feccc05e7
Author: Alex Deucher <alexander.deucher@amd.com>

drm/amdgpu/userq/mes: implement set gang submit

This commit adds the mes_set_gang() callback to userq_mes_funcs to
configure MES gang submission between a primary and secondary usermode
queue.

> diff --git a/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c b/drivers/gpu/drm=
/amd/amdgpu/mes_userqueue.c
> index 7abb9d95ef59a..e186ebd08b8d2 100644
> --- a/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
> +++ b/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
> @@ -649,6 +649,31 @@ static int mes_userq_restore(struct amdgpu_usermode_=
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
> +	int r;
> +
> +	memset(&input, 0x0, sizeof(struct mes_set_gang_submit_input));
> +
> +	input.primary_gang_context_addr =3D
> +		primary_ctx->gpu_addr + AMDGPU_USERQ_PROC_CTX_SZ;
> +	input.secondary_gang_context_addr =3D
> +		secondary_ctx->gpu_addr + AMDGPU_USERQ_PROC_CTX_SZ;

[Severity: High]
Should primary_gang_context_addr and secondary_gang_context_addr be set
to primary_ctx->gpu_addr and secondary_ctx->gpu_addr without adding
AMDGPU_USERQ_PROC_CTX_SZ?

Since 97bcaf15ad25 ("drm/amdgpu: implement per-process MES context"),
the process context is allocated separately in uq_mgr->proc_ctx_obj, and
mes_userq_create_ctx_space() allocates queue->fw_obj with size
AMDGPU_USERQ_GANG_CTX_SZ (one page) for the gang context alone:

drivers/gpu/drm/amd/amdgpu/mes_userqueue.c:mes_userq_create_ctx_space() {
	...
	/* The FW expects at least one page space allocated for gang ctx. */
	size =3D AMDGPU_USERQ_GANG_CTX_SZ;
	r =3D amdgpu_bo_create_kernel(uq_mgr->adev, size, 0,
				    AMDGPU_GEM_DOMAIN_GTT,
				    &ctx->obj, &ctx->gpu_addr,
				    &ctx->cpu_ptr);
	...
}

Adding AMDGPU_USERQ_PROC_CTX_SZ points one page past the end of each
queue's fw_obj BO and does not match the gang_context_addr (ctx->gpu_addr)
passed to MES in mes_userq_map().

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261117192415.8101=
17-1-alexander.deucher@amd.com?part=3D6
