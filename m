Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16CAB606A33D
	for <amd-gfx@archiver.kernel.org>; Fri, 13 Nov 2026 10:49:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=I7m8LiID
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A95A110E74D;
	Fri, 13 Nov 2026 10:49:47 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 92C9B1121EB
 for <amd-gfx@lists.freedesktop.org>; Fri, 13 Nov 2026 10:49:41 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 4C6DB43896;
 Fri, 13 Nov 2026 10:49:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0950A1F000C4;
 Fri, 13 Nov 2026 10:49:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794566981;
 bh=aLoIj1oXuuREyMRXh2xU/ViY4EEank0YEnljUR43kG8=;
 h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
 b=I7m8LiIDTzulA1G41U05BIjYuDeIAD+7GYw4Li0NTK6kTrMQtcvHPjeC+AMr2AzXE
 8ADX/nP+hgmNQJcgyr+MTqByjkTZ99RGzhwLHarquuSkfZkaS4dQuzKGgjbZwixxqe
 BRq8TfkxYIhuK53HnyRdQcz35h8WutjR8SCoAJJ2gvbYsCdNN15SzzjSHELRlvHQna
 KKg6GMZbT+i/kyymma8C3Mm1UKUYhNeGBzocKMm9KvUdSOZVqk1KST1C1XKvrAHpLv
 armttj7d6yKgoGCxIbn7ynb2y92RulUgjd55DXTouFCrexh16zmQE52Y6jb2ThK1jb
 IsqMVbqALJlSg==
Message-ID: <sashiko-outbox-212636@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] drm/amdgpu: skip uniras block ECC query in GPU reset path
To: "Ce Sun" <cesun102@amd.com>, amd-gfx@lists.freedesktop.org
In-Reply-To: <20261113095441.1604-1-cesun102@amd.com>
References: <20261113095441.1604-1-cesun102@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 13 Nov 2026 10:49:40 +0000
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
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Archived-By: <archiver.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential
issues to consider:
- [Medium] drm/amdgpu: incomplete reset check in
  amdgpu_persistent_edc_harvesting()
- [Low] drm/amdgpu: missing Fixes trailer for GPU reset ECC query
  regression
--

commit a877bda7a103d3656c06f840d5177c8e2b166cc8
Author: Ce Sun <cesun102@amd.com>

> drm/amdgpu: skip uniras block ECC query in GPU reset path
>
> amdgpu_uniras_query_block_ecc doesn't support being called during GPU res=
et.
>
> Signed-off-by: Ce Sun <cesun102@amd.com>
> Signed-off-by: YiPeng Chai <YiPeng.Chai@amd.com>

[Severity: Low]
This fixes a GPU reset regression introduced when
amdgpu_ras_query_error_status() was wired to amdgpu_uniras_query_block_ecc(=
).
Should this include:

  Fixes: fe2ccc7b7b23 ("drm/amdgpu: query block error count of ras module")

> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_ras.c
> index 312566337ab14..6d8b2e24880f6 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> @@ -3758,6 +3758,10 @@ static int amdgpu_persistent_edc_harvesting(struct=
 amdgpu_device *adev,
>  	if (!amdgpu_persistent_edc_harvesting_supported(adev))
>  		return 0;
> =20
> +	if ((amdgpu_in_reset(adev) || amdgpu_ras_in_recovery(adev)) &&
> +	     amdgpu_uniras_enabled(adev))
> +		return 0;
> +
>  	if (amdgpu_ras_query_error_status(adev, &info) !=3D 0)
>  		drm_warn(adev_to_drm(adev), "RAS init query failure");
> =20

[Severity: Medium]
Should this check skip the query during GPU reset regardless of
amdgpu_uniras_enabled(adev), matching amdgpu_ras_reset_error_count()?

During GPU reset (including amdgpu_xgmi_reset_on_init_work(), where the
RAS IP block has not yet run hw_init so amdgpu_uniras_enabled(adev)
returns false even on uniras devices), the reset thread holds
down_write(&adev->reset_domain->sem).  When amdgpu_uniras_enabled(adev) is
false, execution falls through to amdgpu_ras_query_error_status() ->
amdgpu_ras_query_error_status_with_event(), which fails
down_read_trylock(&adev->reset_domain->sem) with -EIO and logs a false
"RAS init query failure" warning for each RAS block.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261113095441.1604=
-1-cesun102@amd.com?part=3D1
