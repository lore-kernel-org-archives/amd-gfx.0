Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D28ACC61DE2
	for <amd-gfx@archiver.kernel.org>; Mon, 31 Aug 2026 11:39:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3E85F10E2B3;
	Mon, 31 Aug 2026 11:39:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="pKqj9G1a";
	dkim-atps=neutral
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com
 [209.85.218.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D8DB310E2B3
 for <amd-gfx@lists.freedesktop.org>; Mon, 31 Aug 2026 11:39:43 +0000 (UTC)
Received: by mail-ej1-f43.google.com with SMTP id
 a640c23a62f3a-c1c52d920b8so410329766b.2
 for <amd-gfx@lists.freedesktop.org>; Mon, 31 Aug 2026 04:39:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1788176382; x=1788781182; darn=lists.freedesktop.org;
 h=content-type:content-transfer-encoding:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=GSaKvfCewxq1tw/MPDZ73QfEYniPUyq5xZzUvs3KI9Q=;
 b=pKqj9G1aL03V8wla/gmiaGd9fGK6O6usMVhQ7MOCLgD23/oJLM+KOGU4dC9rtKPT76
 +hoTXnYROFTjA98nVVBLEs1LlPJqa6hhYtBU1+spGiFODA3XSQJPs9lBQa2eZBvKWENv
 PKtS8v4vgKTm6pcAPg+A80sCdl6a0XEm0DCSs/KsR8BfxIJEt3palCo3zXxz/u0hmT7m
 uimG+cjZKYavnH867U53Jqtxe6G5JEeYThzKliJSwfYwClAv4OBUDdo822juKNxsZLcC
 2VEL/nQu0svyavugZnMczN8XPm64M1zA4K81oL1NRBIL+1IQm4qvzaj0kSLwKjxgdi14
 rCuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788176382; x=1788781182;
 h=content-type:content-transfer-encoding:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=GSaKvfCewxq1tw/MPDZ73QfEYniPUyq5xZzUvs3KI9Q=;
 b=lGCNd7lkRfgbCGQtG5NqQCIuo7xFNIkaUYYpxjVL2K+5EJkeqI/O45d8ypaYtXcifu
 9F4pZmwTCPhh9uzRIDwD5P7LDIK0TFy7QhI9NXKTzsNX61PX1uEfrbL7GfmM0l07UV9P
 TYD0USa8baloJo4TgvkkRhZG5wBKI6R345IKcCcgJJqGbFxmGvZC9cHiKwN4K2+6XJ7Q
 xzdB61soYUStD61F//bSoMCmjQm3hnHV23YPEcLXxlTSLYrqqYN7vq+9DAQXV4O8IeWK
 XmKcikRewAqbvy9tp9zK++r+tilbO5fLgT76Cbedmf7LY/MqnSQwmLDrC8qNzXLd6n4x
 sBlw==
X-Forwarded-Encrypted: i=1;
 AHgh+RoyaDdC8kkDpac1l4u+qgKa7DBHJcFcBV1VUnQiuWMmRHVtaNRgfhxCkl3bYklhg0/z4o7pRBmW@lists.freedesktop.org
X-Gm-Message-State: AFuF++mP/qVLlmQhrW8hUGuaSRc5g86yCNbJ87DSbiHaeDpasKC6QWwB
 fGB/1b6zR+SefzQAYHj0Ae7LDgU7sG3JZLRJW7nsLT2vfKSbA1Zlw3c8
X-Gm-Gg: AR+sD11fEq7sJNH834ykYxF0vjMynCfok9ya6oGG1hHfAGXOCs9hPxzAJpbOiwJv67B
 Fqf0yMSNPebkXjbKsq25FTxJJqH94LeW52rcQyykySpzPXSLCN0KBolQmjp3bIryg74ndlMgvn8
 1t/c8LhIcCSOpZ4MAefNx7I4coem3JwCwfB70sJq73jnDqkvShiZElgE4e4pKTkyHl9+EnCVsp2
 tkyZwtp33Gw7S8Y8eEcN3+nYNfPYQj4wvbTOFQn6sL2Kj10K6PPxWWfQSIQegbZt6O+JC9MFh0G
 Nm8eM3rpok0c/rru2DDFYnfprUitY/tQh6jwqPhb6dZf86oiCXIOEHRgKAysCC1Trq9zLH1Iqr3
 MenoQDiP2GLbwtrOCekFMxaZzPDl6bSnvFzeDwJgOceXtCFWNcsjv4FMBAZm3qcY31i/UBHViQM
 3JwvoyhD6hF1+mTqM0h/Mn3GoulpkXrQZfaWfr8no7OGPoyrrUwTZMhpRqLhgMvh3f5YeRPb0qM
 r3jFq0nN0uaMrfhN2Aw2QdqMSJsG+SfmIR4i6IW/8TN8FUx+O4BEiU9JSlqbxe4Y9GABfWi/sRC
X-Received: by 2002:a17:907:9618:b0:c24:457b:86fc with SMTP id
 a640c23a62f3a-c25571d3b0dmr1534052066b.21.1788176382007; 
 Mon, 31 Aug 2026 04:39:42 -0700 (PDT)
Received: from timur-max.localnet
 (20014C4E24D8F2005AA4D4F91F46DAE7.dsl.pool.telekom.hu.
 [2001:4c4e:24d8:f200:5aa4:d4f9:1f46:dae7])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c255ee75a36sm413076466b.28.2026.08.31.04.39.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 31 Aug 2026 04:39:41 -0700 (PDT)
From: Timur =?UTF-8?B?S3Jpc3TDs2Y=?= <timur.kristof@gmail.com>
To: christian.koenig@amd.com, alexander.deucher@amd.com,
 amd-gfx@lists.freedesktop.org
Cc: Arunpravin Paneer Selvam <Arunpravin.PaneerSelvam@amd.com>,
 stable@vger.kernel.org,
 Arunpravin Paneer Selvam <Arunpravin.PaneerSelvam@amd.com>
Subject: Re: [PATCH] drm/amdgpu: skip the VMID 0 flush for VRAM
 clear-on-release
Date: Mon, 31 Aug 2026 13:39:40 +0200
Message-ID: <voa7PnOgTa6oSIPH4Hu9jQ@gmail.com>
In-Reply-To: <20260828044734.135460-1-Arunpravin.PaneerSelvam@amd.com>
References: <20260828044734.135460-1-Arunpravin.PaneerSelvam@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On 2026. augusztus 28., p=C3=A9ntek 6:47:34 k=C3=B6z=C3=A9p-eur=C3=B3pai ny=
=C3=A1ri id=C5=91 Arunpravin=20
Paneer Selvam wrote:
> Clear-on-release only runs on VRAM, which amdgpu_ttm_map_buffer() reaches
> via its direct MC address without programming a GART window, yet the wipe
> still forces a VMID 0 flush.

Makes sense.
We don't need the VM flush when we are not changing the page tables.

I agree with the patch, just would like to ask a few questions to better=20
understand the underlying problem:

> On GFX11 (e.g. Navi33) that spurious SDMA
> flush can wedge the engine

What is happening when the SDMA engine is wedged? Can it be recovered by an=
=20
SDMA queue reset? Is it just a hang, or can it cause other issues such as p=
age=20
faults?

> only flush when a GART window is actually used.

Does that mean that there is still a risk of the wedge when the GART window=
s=20
are used? Can you remind me when/why we need the GART windows exactly?

> Fixes: a68c7eaa7a8f ("drm/amdgpu: Enable clear page functionality")
> Cc: stable@vger.kernel.org
> Cc: Christian K=C3=B6nig <christian.koenig@amd.com>
> Signed-off-by: Arunpravin Paneer Selvam <Arunpravin.PaneerSelvam@amd.com>

Reviewed-by: Timur Krist=C3=B3f <timur.kristof@gmail.com>

Thanks and best regards,
Timur

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c index
> 6c07cee8e8777..2e6c98c2f1efa 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> @@ -2578,6 +2578,7 @@ int amdgpu_ttm_clear_buffer(struct
> amdgpu_ttm_buffer_entity *entity, struct amdgpu_device *adev =3D
> amdgpu_ttm_adev(bo->tbo.bdev);
>  	struct dma_fence *fence =3D NULL;
>  	struct amdgpu_res_cursor dst;
> +	bool vm_needs_flush;
>  	int r;
>=20
>  	if (!entity)
> @@ -2585,6 +2586,8 @@ int amdgpu_ttm_clear_buffer(struct
> amdgpu_ttm_buffer_entity *entity,
>=20
>  	amdgpu_res_first(bo->tbo.resource, 0, amdgpu_bo_size(bo), &dst);
>=20
> +	vm_needs_flush =3D bo->tbo.resource->start =3D=3D=20
AMDGPU_BO_INVALID_OFFSET;
> +
>  	mutex_lock(&entity->lock);
>  	while (dst.remaining) {
>  		struct dma_fence *next;
> @@ -2605,7 +2608,7 @@ int amdgpu_ttm_clear_buffer(struct
> amdgpu_ttm_buffer_entity *entity,
>=20
>  		r =3D amdgpu_ttm_fill_mem(adev, entity,
>  					0, to, cur_size, resv,
> -					&next, true,=20
k_job_id);
> +					&next, vm_needs_flush,=20
k_job_id);
>  		if (r)
>  			goto error;




