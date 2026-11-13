Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49007606A327
	for <amd-gfx@archiver.kernel.org>; Fri, 13 Nov 2026 15:21:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OJHVEbh8
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CE627112621;
	Fri, 13 Nov 2026 15:20:54 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 59CCE112621
 for <amd-gfx@lists.freedesktop.org>; Fri, 13 Nov 2026 15:20:48 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 2997743A4D;
 Fri, 13 Nov 2026 15:20:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8BD31F000C4;
 Fri, 13 Nov 2026 15:20:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794583248;
 bh=t/KJkm14ws7tMz/FJT5nOVHG366A6eGJ/fUdzg5vbgk=;
 h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
 b=OJHVEbh8RWMovFIRV9g0f6Pv0SewCvsNHGj2rT42e9n/M0jnk29FFBnVHu9sFSrrz
 p0zFlE59C7HG3srgu1uEdLr/Y9Tt6qdeFKZgAN2+5tIKGGJGcQqx2XHthADkNF09kn
 +I7gP6S58siokw86fABLB8pldX4eYyZVsiVGw4kGtNiuKXeQeUgqzk04ODXpdChLaE
 SzfIwwXThLqU0eNd7tZaQ88JOydOHWo9WdeAJPyXpmxDv+i4cfeL1btbXi2pf/Mbu/
 eZobSaEUvmWacKjeTzsrxHYRwwzTZ1oz82aSZ4SnuGRy3HSDMAWQ/ieslJbxtKlquK
 uCsMuwB0jeRaQ==
Message-ID: <sashiko-outbox-213075@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 3/7] Revert "drm/amdgpu: take the A+A VF GMC aperture
 from SRAT"
To: "Zhigang Luo" <Zhigang.Luo@amd.com>, amd-gfx@lists.freedesktop.org
In-Reply-To: <20261113145702.323968-3-Zhigang.Luo@amd.com>
References: <20261113145702.323968-1-Zhigang.Luo@amd.com>
 <20261113145702.323968-3-Zhigang.Luo@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 13 Nov 2026 15:20:47 +0000
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
- [High] drm/amdgpu: undefined guard in
  amdgpu_acpi_find_gpu_memory_in_srat() [1]
--

commit d687d56267f159cb114f4a53091a5e9a32dc7973
Author: Zhigang Luo <Zhigang.Luo@amd.com>

Revert "drm/amdgpu: take the A+A VF GMC aperture from SRAT"

This commit reverts the direct SRAT aperture lookup in gmc_v12_0_early_init=
()
and the SPM overrides in gmc_v12_0_vram_gtt_location(), gmc_v12_0_mc_init(),
and mmhub_v4_2_0_get_xgmi_info() so that the GMC aperture is derived from t=
he
FB offset and XGMI node segment size instead.

> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c b/drivers/gpu/drm/amd=
/amdgpu/gmc_v12_0.c
> index cd276a138e101..7e0b83b1015fc 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c
> @@ -639,7 +639,6 @@ static void gmc_v12_0_set_gfxhub_funcs(struct amdgpu_=
device *adev)
>  static int gmc_v12_0_early_init(struct amdgpu_ip_block *ip_block)
>  {
>  	struct amdgpu_device *adev =3D ip_block->adev;
> -	int r;
> =20
>  	if (adev->smuio.funcs &&
>  	    adev->smuio.funcs->is_host_gpu_xgmi_supported)
> @@ -662,18 +661,6 @@ static int gmc_v12_0_early_init(struct amdgpu_ip_blo=
ck *ip_block)
>  	gmc_v12_0_set_mmhub_funcs(adev);
>  	gmc_v12_0_set_umc_funcs(adev);
> =20
> -	if (amdgpu_virt_vram_is_spm(adev)) {
> -		u64 aper_base, aper_size;
> -
> -		r =3D amdgpu_acpi_find_gpu_memory_in_srat(adev, &aper_base,
> -							&aper_size);
> -		if (r)
> -			return r;
> -
> -		adev->gmc.aper_base =3D aper_base;
> -		adev->gmc.aper_size =3D aper_size;
> -	}

[Severity: High]
This problem wasn't introduced by this patch, but does
amdgpu_acpi_find_gpu_memory_in_srat() [1] always return -ENOENT?

In drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c, the SRAT lookup implementation
is guarded by #ifdef HAVE_ACPI_SRAT_GENERIC_AFFINITY, an out-of-tree autoco=
nf
macro that is never defined in the kernel tree even though struct
acpi_srat_generic_affinity is unconditionally defined in
include/acpi/actbl3.h.  Only the #else fallback stub is compiled, causing
SRAT lookups for SPM-backed VRAM to fail with -ENOENT during device probe.

[1] https://sashiko.dev/#/bug/linux-e20f9f1a-d616-45e0-9734-058df15f4c59

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261113145702.3239=
68-1-Zhigang.Luo@amd.com?part=3D3
