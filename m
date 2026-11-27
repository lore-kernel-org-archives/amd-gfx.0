Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9BA1606A31C
	for <amd-gfx@archiver.kernel.org>; Fri, 27 Nov 2026 08:44:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hIWY75se
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3B6AD112897;
	Fri, 27 Nov 2026 08:44:03 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DB49C112897
 for <amd-gfx@lists.freedesktop.org>; Fri, 27 Nov 2026 08:43:54 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id A62DE43580;
 Fri, 27 Nov 2026 08:43:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32E8D1F00899;
 Fri, 27 Nov 2026 08:43:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795769034;
 bh=5Uux/rlUaj3QWOxbz6yx/SQVogNNrZCCTE5qLAXO8LM=;
 h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
 b=hIWY75sefxQqUz5V6izkjq/jKFc858kitGiNtJakrNxOjFkdRfa2nU0Fbwe2da4Tv
 0rsd6pWOLfQJW4bQVwghfii/Ri/0pJIzTkRJ5Y1neEDdprzkzteCtLBowPgjWhbESG
 PupKdHJuKkPz2yqn51x2/Q3pb78HENZtEjFJvMno+oXqsup23q65TsjeLM1ylvKPX5
 gQO4JGkLNNLBIJ9oO9uNmnV2DrbLss1dv1Up7nmfi3whgIVdVu4xRt/cZy3S89EIVs
 b28XFrKwxPuuLbPtTuEoPwioRBGSQvFFkfW6U5iLFnvlf8XQ4OUAtA6WxziJjJ2jMh
 rK6tpDLtdAWQw==
Message-ID: <sashiko-outbox-236901@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/2] drm/amdkfd: bound the APU GTT pool size by KFD's
 system memory limit
To: "Priya Hosur" <Priya.Hosur@amd.com>, amd-gfx@lists.freedesktop.org
In-Reply-To: <20261127082854.112025-3-Priya.Hosur@amd.com>
References: <20261127082854.112025-1-Priya.Hosur@amd.com>
 <20261127082854.112025-3-Priya.Hosur@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 27 Nov 2026 08:43:53 +0000
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
- [Low] drm/amdkfd: unaligned GTT pool size in
  amdgpu_amdkfd_gtt_pool_size()
--

commit 17502322da1ca7a12d9a6715a32b9c3d4e96b211
Author: Priya Hosur <Priya.Hosur@amd.com>

drm/amdkfd: bound the APU GTT pool size by KFD's system memory limit

This commit caps the reported APU GTT pool size in
amdgpu_amdkfd_get_local_mem_info() and amdgpu_amdkfd_xcp_memory_size() by
the smaller of TTM's page limit and KFD's system memory limit.

> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c b/drivers/gpu/drm=
/amd/amdgpu/amdgpu_amdkfd.c
> index 0dab267eb3828..17c12edca4371 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
> @@ -521,6 +521,17 @@ uint32_t amdgpu_amdkfd_get_fw_version(struct amdgpu_=
device *adev,
>  	return 0;
>  }
> =20
> +/*
> + * Size of the GTT-backed pool reported on APUs. TTM may be configured a=
bove
> + * physical RAM, but KFD will not allocate beyond its system memory limi=
t, so
> + * don't report more than that.
> + */
> +static u64 amdgpu_amdkfd_gtt_pool_size(void)
> +{
> +	return min((u64)ttm_tt_pages_limit() << PAGE_SHIFT,
> +		   amdgpu_amdkfd_system_mem_limit());
> +}

[Severity: Low]
Can amdgpu_amdkfd_gtt_pool_size() return a byte count that is not aligned
to PAGE_SIZE?

In amdgpu_amdkfd_gpuvm_init_mem_limits(), max_system_mem_limit is derived
from mem - (mem >> 6), which is only 64-byte aligned whenever
si.totalram - si.totalhigh is not a multiple of 64 pages.  Since
amdgpu_amdkfd_gpuvm_alloc_memory_of_gpu() rounds every allocation up with
PAGE_ALIGN(size) before checking max_system_mem_limit, any sub-page
remainder advertised in local_mem_size_public and
amdgpu_amdkfd_xcp_memory_size() cannot be allocated.  Rounding the result
down with ALIGN_DOWN(..., PAGE_SIZE) would match the partition branch in
amdgpu_amdkfd_xcp_memory_size().

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261127082854.1120=
25-1-Priya.Hosur@amd.com?part=3D2
