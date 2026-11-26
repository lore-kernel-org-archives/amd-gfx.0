Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98E16606A31C
	for <amd-gfx@archiver.kernel.org>; Thu, 26 Nov 2026 10:40:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=IWp8fWjd
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2D9341122CE;
	Thu, 26 Nov 2026 10:40:19 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 889BB1122CE
 for <amd-gfx@lists.freedesktop.org>; Thu, 26 Nov 2026 10:40:13 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id A74156014C;
 Thu, 26 Nov 2026 10:40:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB7861F000CA;
 Thu, 26 Nov 2026 10:40:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795689612;
 bh=tZ2VsbVr9iLLS98vE6b+/1WAxiYHRAt0pmOLIirf6ao=;
 h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
 b=IWp8fWjdELlujA5G3H/RBjHM2712KoNTSKn57s0rESyYRwEeX+lKr22vRScZXM/JD
 W7NX12BvNh4BMh/BIezfkbdugcHp2RWzCCrgclExGkX7qwGAnDuN5+vsjQHEB1mOvS
 We22qXc+3Y/P1DYvSOgKCRX+/+b62lw4nExswXCRj+KF3+V5nTTYvsoxZX9AYlB+xR
 IhS6tsMnGkwDM1K/msu7uftBok1Va0u9aoxoIrxnJK/yICkHCnFjl+uQmbIYbddY6f
 qZxqRbcMkZqqmwpJECoQ0h41xfDfH8Keou1WqdXP//4586jALcFxsbiuvgd7PUt9zk
 FKb4MJYa70GLw==
Message-ID: <sashiko-outbox-235305@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] drm/amdgpu: keep the address of cleared PDEs with
 translate further
To: "Bob Zhou" <bobzhou2@amd.com>, amd-gfx@lists.freedesktop.org
In-Reply-To: <20261126101946.2651048-1-bobzhou2@amd.com>
References: <20261126101946.2651048-1-bobzhou2@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 26 Nov 2026 10:40:11 +0000
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
- [High] drm/amdgpu: cleared PDE addr passed as incr in
  amdgpu_vm_pt_clear()
--

commit d99a4183771402011e83a09490a1a9e68c1c93f4
Author: Bob Zhou <bobzhou2@amd.com>

drm/amdgpu: keep the address of cleared PDEs with translate further

This commit changes amdgpu_vm_pt_clear_flags() to output both the address a=
nd
flags for cleared PDEs/PTEs and passes the address to vm->update_funcs->upd=
ate()
in amdgpu_vm_pt_clear().

> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c b/drivers/gpu/drm/=
amd/amdgpu/amdgpu_vm_pt.c
> index a6d389c08524f..8f1e0bc7d65ae 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c

[ ... ]

> @@ -395,7 +390,7 @@ int amdgpu_vm_pt_clear(struct amdgpu_device *adev, st=
ruct amdgpu_vm *vm,
>  	struct amdgpu_bo *ancestor =3D &vmbo->bo;
>  	struct amdgpu_bo *bo =3D &vmbo->bo;
>  	unsigned int entries;
> -	uint64_t flags;
> +	uint64_t value =3D 0, flags =3D 0;
>  	int r, idx;
> =20
>  	/* Figure out our place in the hierarchy */
> @@ -430,8 +425,9 @@ int amdgpu_vm_pt_clear(struct amdgpu_device *adev, st=
ruct amdgpu_vm *vm,
>  	if (r)
>  		goto exit;
> =20
> -	flags =3D amdgpu_vm_pt_clear_flags(adev, vm, level);
> -	r =3D vm->update_funcs->update(&params, vmbo, 0, 0, entries, 0, flags);
> +	amdgpu_vm_pt_clear_flags(adev, vm, level, &value, &flags);
> +	r =3D vm->update_funcs->update(&params, vmbo, 0, 0, entries, value,
> +				     flags);

[Severity: High]
Does this pass value as the incr argument of vm->update_funcs->update()
instead of the addr argument?

drivers/gpu/drm/amd/amdgpu/amdgpu_vm_internal.h:amdgpu_vm_update_funcs {
    ...
	int (*update)(struct amdgpu_vm_update_params *p,
		      struct amdgpu_bo_vm *bo, uint64_t pe, uint64_t addr,
		      unsigned count, uint32_t incr, uint64_t flags);
    ...
}

When clearing a PDB0 page directory with translate_further enabled on GMC9,
gmc_v9_0_get_vm_pde() sets bit 12 (0x1000) in value and clears
AMDGPU_PDE_PTE from flags.  Passing 0 for addr and value for incr makes
both the CPU and SDMA updaters write (0 + i * 0x1000) | flags to entry i,
so entry 0 still reads as 0 and subsequent entries get incrementing
addresses rather than a constant 0x1000, triggering VM faults on hardware
page table walks.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261126101946.2651=
048-1-bobzhou2@amd.com?part=3D1
