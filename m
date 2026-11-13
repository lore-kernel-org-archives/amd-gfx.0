Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF0DC606A32D
	for <amd-gfx@archiver.kernel.org>; Fri, 13 Nov 2026 14:57:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FIiqRfrm
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6439810E02D;
	Fri, 13 Nov 2026 14:57:01 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D85F410E02D
 for <amd-gfx@lists.freedesktop.org>; Fri, 13 Nov 2026 14:56:55 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id A9BBA4508A;
 Fri, 13 Nov 2026 14:56:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 658EB1F000C5;
 Fri, 13 Nov 2026 14:56:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794581815;
 bh=GWwx8yoMpS5BRJyIQ2alBWIumJWmrZvSvp/KS2wtSIY=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=FIiqRfrmIx/0ujsk/oMszJYASmApIuq0FnhTyeXeS0PeGIqkjn36HOn9UuVROXkaf
 YVT1au2/wJ2SI0DMJGlAgkN07uz553L7eX80zuxr5vpl8MWp3i54MiMHov94REWmd9
 Ezfc1atX26v4eYJjJlS/aoS6BJFRSynB5Jkh8Y662Boeg0KxZ1rpg9iEd66+VnqUbW
 8TRF927URT7yhd9hYtoYNWFmz1C7Ab8cFpPRPw7HV+8uzKu6HBaUz7JehKsQlJk5MP
 5EKK/TT2T70O35qo8o5tDABpHtj/zJzkxmcsgeQyF4Kdv0jxYGnVwhrr0km8k/Yq+/
 JkfX7C56syOow==
Message-ID: <sashiko-outbox-213039@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/3] drm/amdgpu: unwind bo_init on GMC sw_init failure
To: "Mario Limonciello" <mario.limonciello@amd.com>
Cc: amd-gfx@lists.freedesktop.org
In-Reply-To: <20261113-superm1-amdgpu-memory-leak-v1-2-4a495cfc2c92@amd.com>
References: <20261113-superm1-amdgpu-memory-leak-v1-0-4a495cfc2c92@amd.com>
 <20261113-superm1-amdgpu-memory-leak-v1-2-4a495cfc2c92@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 13 Nov 2026 14:56:54 +0000
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
- [Medium] drm/amdgpu: gmc_v*_sw_init() calls amdgpu_bo_fini() with
  GART/PDB0 BOs pinned
--

commit 4e2abeed7577cfdf2a67e81d9af414ebfbc361c6
Author: Mario Limonciello <mario.limonciello@amd.com>

drm/amdgpu: unwind bo_init on GMC sw_init failure

This commit unwinds amdgpu_bo_init() and amdgpu_vm_manager_init() when
gmc_v*_sw_init() fails after initializing the memory manager across GMC v6
through v12.

> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c b/drivers/gpu/drm/amd=
/amdgpu/gmc_v10_0.c
> index 49f593fe2a876..e59fee3955af0 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
> @@ -861,7 +861,7 @@ static int gmc_v10_0_sw_init(struct amdgpu_ip_block *=
ip_block)
> =20
>  	r =3D gmc_v10_0_gart_init(adev);
>  	if (r)
> -		return r;
> +		goto err_bo_fini;
> =20
>  	/*
>  	 * number of VMs
> @@ -880,9 +880,15 @@ static int gmc_v10_0_sw_init(struct amdgpu_ip_block =
*ip_block)
> =20
>  	r =3D amdgpu_gmc_ras_sw_init(adev);
>  	if (r)
> -		return r;
> +		goto err_vm_fini;
> =20
>  	return 0;
> +
> +err_vm_fini:
> +	amdgpu_vm_manager_fini(adev);
> +err_bo_fini:
> +	amdgpu_bo_fini(adev);
> +	return r;
>  }

[Severity: Medium]
Does jumping to err_vm_fini tear down TTM while adev->gart.bo is still
pinned?

gmc_v10_0_gart_init() allocates and pins adev->gart.bo in VRAM.  If
amdgpu_gmc_ras_sw_init() fails, err_vm_fini calls amdgpu_bo_fini() without
first freeing the GART table as gmc_v10_0_sw_fini() does.  Because pinned
BOs cannot be evicted during amdgpu_ttm_fini(), gpu_buddy_fini() and
drm_mm_takedown() hit warnings and leak the pinned BOs and their backing
allocations.

The same missing GART cleanup affects the err_vm_fini paths in GMC v7, v8,
v9, v11, and v12.  On GMC v9 and v12, gmc_v*_gart_init() also allocates
and pins adev->gmc.pdb0_bo when amdgpu_gmc_is_pdb0_enabled() is true, so
both err_vm_fini and a failure in amdgpu_gmc_pdb0_alloc() within
gmc_v*_gart_init() reach amdgpu_bo_fini() with pinned BOs still allocated.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261113-superm1-am=
dgpu-memory-leak-v1-0-4a495cfc2c92@amd.com?part=3D2
