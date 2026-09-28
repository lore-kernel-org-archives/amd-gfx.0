Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0897CA5FA2
	for <amd-gfx@archiver.kernel.org>; Mon, 28 Sep 2026 19:08:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4E68C10EB96;
	Mon, 28 Sep 2026 19:08:43 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="hpo4V7Tc";
	dkim-atps=neutral
Received: from mail-ua2-f42.google.com (mail-ua2-f42.google.com
 [74.125.226.234])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6161C10EB96
 for <amd-gfx@lists.freedesktop.org>; Mon, 28 Sep 2026 19:08:42 +0000 (UTC)
Received: by mail-ua2-f42.google.com with SMTP id
 a1e0cc1a2514c-988a071feabso846342241.3
 for <amd-gfx@lists.freedesktop.org>; Mon, 28 Sep 2026 12:08:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790622521; x=1791227321; darn=lists.freedesktop.org;
 h=content-type:content-transfer-encoding:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=0odRC721J+3ldfKco6jRTlKbLCnlbPZW7bw9JpKA3z4=;
 b=hpo4V7TcoYZYD60LKItiLw4YEwSO4QDgL4WyfVRAGo52ygPbXb41jA34Oa8mfQtaoe
 WMqicn4yvxsIfxvm0ybl4sebvwQ+9vE4nsbGwSNJRDIm72Vhj1xn9GYCTXD/RIZD83PY
 VNSrq3yaIykmKg12uwvXA7GXbWeI0PeDt4uFNdK3rBgQG58rqdvaAe1VOZ6VcQqsD54B
 F7DBPFUJy3Tz7r0f00C/XZeQPmjYkVAYlN7JLyNahgm1hKQsz2prhqjXNI80TQirIl+3
 AZF+ONYy5OqbDjMQRpgJ56C+TV3WcrVDCw77XLBACfrdlPZBDKYkzUQ3O7bCEu8xZoVE
 8+uA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790622521; x=1791227321;
 h=content-type:content-transfer-encoding:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=0odRC721J+3ldfKco6jRTlKbLCnlbPZW7bw9JpKA3z4=;
 b=JeF+xGAu4YiRs2eXDkiQdH7k10Y929jHawq9A+FXOqiamychvPuiPGm2wkvcbAUsl3
 n+jmZA9OgZ+mLFOOwLC+biROSxJaoLiniTMOQYF07ZCwdxuYidWk6PmoJbbHz+5dZZZC
 17ZrEFIFr0N1KA57UrMpLB9Q7tZA899U7Uu9nM5iP6lavA4m3q+HceqHpytgYqUOjRWD
 4OJkoMungtxypH44EC9XDo3b2/msHK1mcGAYj4ll0uQaXkjD9nvdnpTkCQF81F4rLQyi
 ZQjq83bKTnRsv9X4TMrdvKM9/iJOkLAjBZaFl4nE9y+ghBZ4RR+DvJhb/bAQly8SlI2l
 FFsw==
X-Gm-Message-State: AFq9FYKgEOzu9W2tftrT/RIy3Xb6K+Awj6PDhSMguBIYEbniji4JdOaW
 9fgtFS7LmsvAPNVX5b088VpAnV8VJ23aXKANsuQ1+burNKo6/aA+vsK+
X-Gm-Gg: AYBFou0cFgjKIzIN2LHyeVHtI+fg4lJmnEEuwbZ8NnzdVOFH0iIOof0AQ6ftenaM7+B
 Rs9m1kAHq5a+jmQLltu918oUphvRh7W+X+yPwA/W5se1Iwmgofv2RccS+Iiw+G4hKsfS802wGsE
 bgmDAjOxCFk0JZqwJClIzcSggQFlW60m6UH6O4zCMPb7OFg9b3/kHK5vu2XuoRXN7VS3FxZ805X
 lwE/T4c7Xyx+yJ8kOpMAnZNuL7sPr42t4shqWCP77tABxf14H1aBTfgQCibDx7vjLlwtWUzxpHc
 1mm4e+6+opTnTUJYejBEaoL0fElxnI1ur2xJ8mFtfrK3tYB7dI8S9a4tt5BSiOvf/yb7IMNwX77
 8qH/TEPLtz/WwMqeElo5w4dG8FxNsBvcMxJ7/F5gx6x641tYNzDZHHKzzEDojgZDOhm3Ah2ZJhE
 14GtJ/aS8jbf/oMifRAAXtjrExpsJ5osSAF1B7dz/VVkrH4/IV8aMJVWAK/6Tx2yJKtMT1GKv2I
 b2hNRTMbfABBPAoOh3qRYKsTGiHDRXEz80Qrp2J23rm1f9W+QPt+LZbH5teMFydaNcPNW+TqsSf
 ZIui/bRhhQ==
X-Received: by 2002:a05:6102:3f0d:b0:7b3:4199:2de2 with SMTP id
 ada2fe7eead31-7b34199441bmr2787816137.35.1790622521064; 
 Mon, 28 Sep 2026 12:08:41 -0700 (PDT)
Received: from timur-max.localnet
 (ipagstaticip-88fc351e-cb28-db3e-3f52-ad13c70f08da.sdsl.bell.ca.
 [142.127.77.63]) by smtp.gmail.com with ESMTPSA id
 a1e0cc1a2514c-988b86d6058sm952145241.0.2026.09.28.12.08.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Sep 2026 12:08:40 -0700 (PDT)
From: Timur =?UTF-8?B?S3Jpc3TDs2Y=?= <timur.kristof@gmail.com>
To: natalie.vock@gmx.de, honghuan@amd.com, Alexander.Deucher@amd.com,
 Felix.Kuehling@amd.com, Philip.Yang@amd.com, cascardo@igalia.com,
 tvrtko.ursulin@igalia.com, christian.koenig@amd.com
Cc: amd-gfx@lists.freedesktop.org
Subject: Re: [PATCH 2/9] drm/amdgpu: fix cleared PDE/PTE flag generation
Date: Mon, 28 Sep 2026 15:08:39 -0400
Message-ID: <P3WG6T-ATwauPO6Yp0bWtQ@gmail.com>
In-Reply-To: <20260928151041.1857-2-christian.koenig@amd.com>
References: <20260928151041.1857-1-christian.koenig@amd.com>
 <20260928151041.1857-2-christian.koenig@amd.com>
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

On 2026. szeptember 28., h=C3=A9tf=C5=91 11:10:34 keleti =C3=A1llamokbeli n=
y=C3=A1ri id=C5=91 Christian=20
K=C3=B6nig wrote:
> That was broken since adding the NPA support.
>=20
> Signed-off-by: Christian K=C3=B6nig <christian.koenig@amd.com>

Reviewed-by: Timur Krist=C3=B3f <timur.kristof@gmail.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c | 64 ++++++++++++-----------
>  1 file changed, 33 insertions(+), 31 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c index
> c03327f1242d3..e8f441e018839 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
> @@ -346,6 +346,33 @@ static void amdgpu_vm_pt_next_dfs(struct amdgpu_devi=
ce
> *adev, amdgpu_vm_pt_continue_dfs((start), (entry));		=09
\
>  	     (entry) =3D (cursor).entry, amdgpu_vm_pt_next_dfs((adev),=20
&(cursor)))
>=20
> +/* Return the flags used for cleared PDEs/PTES */
> +static uint64_t amdgpu_vm_pt_clear_flags(struct amdgpu_device *adev,
> +					struct amdgpu_vm *vm,
> +					unsigned int level)
> +{
> +	uint64_t flags;
> +
> +	if (adev->asic_type < CHIP_VEGA10)
> +		return 0;
> +
> +	if (level !=3D AMDGPU_VM_PTB) {
> +		uint64_t value =3D 0;
> +
> +		flags =3D AMDGPU_PDE_PTE_FLAG(adev);
> +		if (vm->is_npa)
> +			flags |=3D adev->gmc.noretry_flags;
> +		amdgpu_gmc_get_vm_pde(adev, level, &value, &flags);
> +	} else if (vm->is_npa) {
> +		flags =3D adev->gmc.noretry_flags;
> +	} else {
> +		/* Workaround for fault priority problem on GMC9 */
> +		flags =3D AMDGPU_PTE_EXECUTABLE | adev->gmc.init_pte_flags;
> +	}
> +
> +	return flags;
> +}
> +
>  /**
>   * amdgpu_vm_pt_clear - initially clear the PDs/PTs
>   *
> @@ -366,10 +393,9 @@ int amdgpu_vm_pt_clear(struct amdgpu_device *adev,
> struct amdgpu_vm *vm, struct ttm_operation_ctx ctx =3D { true, false };
>  	struct amdgpu_vm_update_params params;
>  	struct amdgpu_bo *ancestor =3D &vmbo->bo;
> -	unsigned int entries;
>  	struct amdgpu_bo *bo =3D &vmbo->bo;
> -	uint64_t value =3D 0, flags =3D 0;
> -	uint64_t addr;
> +	unsigned int entries;
> +	uint64_t flags;
>  	int r, idx;
>=20
>  	/* Figure out our place in the hierarchy */
> @@ -404,26 +430,8 @@ int amdgpu_vm_pt_clear(struct amdgpu_device *adev,
> struct amdgpu_vm *vm, if (r)
>  		goto exit;
>=20
> -	addr =3D 0;
> -
> -	if (adev->asic_type >=3D CHIP_VEGA10) {
> -		if (level !=3D AMDGPU_VM_PTB) {
> -			if (vm->is_npa)
> -				flags =3D adev->gmc.noretry_flags;
> -			/* Handle leaf PDEs as PTEs */
> -			flags |=3D AMDGPU_PDE_PTE_FLAG(adev);
> -			amdgpu_gmc_get_vm_pde(adev, level,
> -					      &value, &flags);
> -		} else if (vm->is_npa) {
> -			flags =3D adev->gmc.noretry_flags;
> -		} else {
> -			/* Workaround for fault priority problem on=20
GMC9 */
> -			flags =3D AMDGPU_PTE_EXECUTABLE | adev-
>gmc.init_pte_flags;
> -		}
> -	}
> -
> -	r =3D vm->update_funcs->update(&params, vmbo, addr, 0, entries,
> -				     value, flags);
> +	flags =3D amdgpu_vm_pt_clear_flags(adev, vm, level);
> +	r =3D vm->update_funcs->update(&params, vmbo, 0, 0, entries, 0,=20
flags);
>  	if (r)
>  		goto exit;
>=20
> @@ -712,15 +720,9 @@ static void amdgpu_vm_pte_update_flags(struct
> amdgpu_vm_update_params *params, flags |=3D
> AMDGPU_PDE_PTE_FLAG(params->adev);
>  		amdgpu_gmc_get_vm_pde(adev, level, &addr, &flags);
>=20
> -	} else if (adev->asic_type >=3D CHIP_VEGA10 &&
> -		   !(flags & AMDGPU_PTE_VALID) &&
> +	} else if (!(flags & AMDGPU_PTE_VALID) &&
>  		   !(flags & AMDGPU_PTE_PRT_FLAG(params->adev))) {
> -
> -		/* Workaround for fault priority problem on GMC9 and=20
GFX12,
> -		 * EXECUTABLE for GMC9 fault priority and init_pte_flags
> -		 * (e.g. AMDGPU_PTE_IS_PTE on GFX12)
> -		 */
> -		flags |=3D AMDGPU_PTE_EXECUTABLE | adev-
>gmc.init_pte_flags;
> +		flags |=3D amdgpu_vm_pt_clear_flags(adev, params->vm,=20
level);
>  	}
>=20
>  	/*




