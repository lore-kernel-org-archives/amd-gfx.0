Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D131C982ED
	for <amd-gfx@archiver.kernel.org>; Mon, 21 Sep 2026 11:37:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AB1C010E301;
	Mon, 21 Sep 2026 11:37:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="iA7e/cbo";
	dkim-atps=neutral
Received: from mail-ej2-f15.google.com (mail-ej2-f15.google.com
 [74.125.228.143])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 35CA410E301
 for <amd-gfx@lists.freedesktop.org>; Mon, 21 Sep 2026 11:37:25 +0000 (UTC)
Received: by mail-ej2-f15.google.com with SMTP id
 a640c23a62f3a-c254f9f7dbfso303504166b.2
 for <amd-gfx@lists.freedesktop.org>; Mon, 21 Sep 2026 04:37:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1789990643; x=1790595443; darn=lists.freedesktop.org;
 h=content-type:content-transfer-encoding:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=YcL2t+O9duhN2CuBleVY8LV4eR78jeVOkn9te3pjFBQ=;
 b=iA7e/cboPNkBn0XUGhZAm3Jpd+OGDVck1GZ3SnKuipbMjCt3jlHr4m7fXQYDm3Yibt
 jTkl9lmD1JlZEvuKdJQ07k4wEsWVdUl8Vxedtr1m+4XTLZn8xh4XwomTvvmeohv5GeHX
 fK1UktBPCfqLWYfKMqpY9tSyFKeHnHiu0v81KoQJa1oIEBPJXtuGXQtno9D4njFUPyTq
 J/PCl7aMN2xIxSfIcC589duxjirbmXJdIVVeofCNqgM1yFNQVpzXlcX4r1ifYRqjhump
 pGDuYfy1q3ZO8ddx7Q97dOPD78DeH53v3dbiT1iliJiym8SltqwScDV+3bMNq4ZkQkuH
 rkKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789990643; x=1790595443;
 h=content-type:content-transfer-encoding:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=YcL2t+O9duhN2CuBleVY8LV4eR78jeVOkn9te3pjFBQ=;
 b=jmGYOHA6kmjnUKLdmHc95kKM0BoYZoVV7QNWeFvHWmGNOyVURyMKU9x0nHIKLUKL9O
 K4IrXGgxknBefF1ic8AHhlthnhHq9Hygiku9WRR7J4esQnzd85DimCu4r1RuWvGqfyXm
 f25Us2TaDI+3gHL/tey8ugij9F4GATaD/zDtCYPn7B/2kg+cUiNlvpbipUv/Z3UKt9nA
 Q6Ol77eO7o0GHzEUaJfpRpAF/IgmoxXfDCZglvrVtsMaFwTG1Jcyl1CQdA1BHLH2ddS5
 zR3Ogn8VZhgnQrCHiZ5KsknXAifL/XM+djvMvvDaHqmuL1edDzDViokOFbNkYqv8oLsM
 8bnA==
X-Forwarded-Encrypted: i=1;
 AKwUvBzkw7wMZue4uEpFZyw+ryeSmdbz+tws9IVYCj2Ek9IgJX8XSYbxYfp7TCbkMgcjVB6nMOhG5TIJ@lists.freedesktop.org
X-Gm-Message-State: AFuF++lVrg1+KBPhrcxP3E9dEt4tNsTJ/ccXUoAs3eIf7L8u2WLj0y5X
 GrBmiyWGhKFQ4JAW1yRC/aJaliK0exNCnJnpN+caw1JZz1gzTEHfEi3z
X-Gm-Gg: AYBFou3mCPwoqAr9iYUzTpKzBzhn/+PcW15gjEvKoKn3irGQfaq1mM6nRQxUSmybUVy
 DHIow8smwIcBTSapG7jIw2ucxcYbPv6F1ht9RPGnLqHJQbH9tGkHiwcHHZDQZOPcWZfC3RcuT9H
 NJTQB32kUiVt+x/KLeE96RDTIG3wg6OUaKQb66TUEnxOUm0QB+alQptLxvm+TClCwi7rtvnbBbT
 UFKZDITqG4f5bW6K5oQfutW5SaQ6KFu8+J2jQz/gtoYCchuF1ZQWH14NupX1gu+RAstWHD/jzwA
 4t+J/nOoNJBFLOaAWY7Y+JR/T0tHPJeiA1vDyGXkLQmfcOamLn4Flz4LQI72tlfeTCSBj1gljbS
 thiOUG81XHEZIz5awxkU6VplZjJsUlAkUYnIgV2pCwccZubC6SV0eUKjPf96Gqa7r8XrmugQ9YV
 +iDwpb9+aij7Aj6fFFCTf91oWbIdctehTQVN3zpsmRiFyqZcrNaTtqf0e1Syx7RQA4bpvuXvQ1V
 pILvUxBavNQwIsqv42419bbLxY+nHlkEz4SkJkgN3Xfyrg=
X-Received: by 2002:a17:907:6d06:b0:c29:3a1b:ec8e with SMTP id
 a640c23a62f3a-c2a1569b034mr952551066b.3.1789990643450; 
 Mon, 21 Sep 2026 04:37:23 -0700 (PDT)
Received: from timur-hyperion.localnet (5401D96A.dsl.pool.telekom.hu.
 [84.1.217.106]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c2a3573ce12sm291502066b.35.2026.09.21.04.37.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 21 Sep 2026 04:37:23 -0700 (PDT)
From: Timur =?UTF-8?B?S3Jpc3TDs2Y=?= <timur.kristof@gmail.com>
To: Christian =?UTF-8?B?S8O2bmln?= <ckoenig.leichtzumerken@gmail.com>,
 Huang Yu <yhuang13@amd.com>
Cc: Yu Huang <Yu.Huang@amd.com>, Honglei Huang <honghuan@amd.com>,
 Ray Huang <ray.huang@amd.com>, Shen Junhua <junhshen@amd.com>,
 Lingshan Zhu <lingszhu@amd.com>, Natalie Vock <natalie.vock@gmx.de>,
 AMD-GFX <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH 02/13] drm/amdgpu: remove unecessary parameters from
 trace_amdgpu_vm_update_ptes
Date: Mon, 21 Sep 2026 13:37:22 +0200
Message-ID: <bwgzFsejRxCUtPds6WwEnw@gmail.com>
In-Reply-To: <20260917110158.296198-3-yhuang13@amd.com>
References: <20260917110158.296198-1-yhuang13@amd.com>
 <20260917110158.296198-3-yhuang13@amd.com>
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

On Thursday, September 17, 2026 1:01:47=E2=80=AFPM Central European Summer =
Time Huang=20
Yu wrote:
> From: Christian K=C3=B6nig <ckoenig.leichtzumerken@gmail.com>
>=20
> Those can be determined by the parameter structure as well.
>=20
> Signed-off-by: Christian K=C3=B6nig <christian.koenig@amd.com>

Nice cleanup!
Reviewed-by: Timur Krist=C3=B3f <timur.kristof@gmail.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_trace.h | 10 +++++-----
>  drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c |  5 +----
>  2 files changed, 6 insertions(+), 9 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_trace.h
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_trace.h index
> 784adf975b04..599c1d0e512b 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_trace.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_trace.h
> @@ -331,9 +331,8 @@ TRACE_EVENT(amdgpu_vm_update_ptes,
>  	    TP_PROTO(struct amdgpu_vm_update_params *p,
>  		     uint64_t start, uint64_t end,
>  		     unsigned int nptes, uint64_t dst,
> -		     uint64_t incr, uint64_t flags,
> -		     pid_t pid, uint64_t vm_ctx),
> -	TP_ARGS(p, start, end, nptes, dst, incr, flags, pid, vm_ctx),
> +		     uint64_t incr, uint64_t flags),
> +	TP_ARGS(p, start, end, nptes, dst, incr, flags),
>  	TP_STRUCT__entry(
>  			 __field(u64, start)
>  			 __field(u64, end)
> @@ -353,8 +352,9 @@ TRACE_EVENT(amdgpu_vm_update_ptes,
>  			__entry->flags =3D flags;
>  			__entry->incr =3D incr;
>  			__entry->nptes =3D nptes;
> -			__entry->pid =3D pid;
> -			__entry->vm_ctx =3D vm_ctx;
> +			__entry->pid =3D p->vm->task_info ?
> +				p->vm->task_info->tgid : 0;
> +			__entry->vm_ctx =3D p->vm-
>immediate.fence_context;
>  			for (i =3D 0; i < nptes; ++i) {
>  				u64 addr =3D p->pages_addr ?=20
amdgpu_vm_map_gart(
>  					p->pages_addr, dst) :=20
dst;
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c index
> 0d7fe32d0c7d..b85b70a1a428 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
> @@ -882,7 +882,6 @@ int amdgpu_vm_ptes_update(struct amdgpu_vm_update_par=
ams
> *params, entry_end =3D min(entry_end, end);
>=20
>  		do {
> -			struct amdgpu_vm *vm =3D params->vm;
>  			uint64_t upd_end =3D min(entry_end, frag_end);
>  			unsigned int nptes =3D (upd_end - frag_start)=20
>> shift;
>  			uint64_t upd_flags =3D flags |=20
AMDGPU_PTE_FRAG(frag);
> @@ -894,9 +893,7 @@ int amdgpu_vm_ptes_update(struct amdgpu_vm_update_par=
ams
> *params,
>=20
>  			trace_amdgpu_vm_update_ptes(params,=20
frag_start, upd_end,
>  						   =20
min(nptes, 32u), dst, incr,
> -						   =20
upd_flags,
> -						    vm-
>task_info ? vm->task_info->tgid : 0,
> -						    vm-
>immediate.fence_context);
> +						   =20
upd_flags);
>  			amdgpu_vm_pte_update_flags(params,=20
to_amdgpu_bo_vm(pt),
>  						  =20
cursor.level, pe_start, dst,
>  						   nptes,=20
incr, upd_flags);




