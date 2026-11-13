Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE2F5606A330
	for <amd-gfx@archiver.kernel.org>; Fri, 13 Nov 2026 13:35:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dGrx30MQ
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7A25210E7F2;
	Fri, 13 Nov 2026 13:35:50 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7666B11223C
 for <amd-gfx@lists.freedesktop.org>; Fri, 13 Nov 2026 13:35:44 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 305C1412DC;
 Fri, 13 Nov 2026 13:35:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0C5F1F000C5;
 Fri, 13 Nov 2026 13:35:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794576944;
 bh=tWVWBcvcTUhSxwuGvbc9WbuoNIjjgK05Gy5ELdQMCdI=;
 h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
 b=dGrx30MQR3BpavZLTno6dzldCzIpz7SxM/eFiTWwikrgX8yP1MEVI4pWfJ/uNJuKl
 SlMlGUd29SFjUj+nZVS0ewStEIKEe5YtqGXBOk80jKuBPOGwJ8pi04UJHYSNT/srzU
 5sXCco3G44HpK3BDZQwxxD57xNdTdXRPnVnoRF5BdGD/noWqAGHJLewngkgh3+JKJN
 MJ6fZ7miugKE2GQuMhqBUSBIVPau9XLdDgJB//8EdoCnIAJ0l3zQBH5oATs07IlzXS
 CtGPCGBsl9Hx4y2Gvgy3VK3lgSm+u1W1k5oK7OearEmPYOOU9A1PNPSLeCnKaDhm7x
 rH9AxIMIVXRww==
Message-ID: <sashiko-outbox-212894@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] drm/amdgpu: skip uniras block ECC query in GPU reset path
To: "Ce Sun" <cesun102@amd.com>, amd-gfx@lists.freedesktop.org
In-Reply-To: <20261113131151.1807-1-cesun102@amd.com>
References: <20261113131151.1807-1-cesun102@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 13 Nov 2026 13:35:43 +0000
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

commit 6d9c0ce1b3d7514e06ab9efacbe9d580a60d6b1c
Author: Ce Sun <cesun102@amd.com>

> drm/amdgpu: skip uniras block ECC query in GPU reset path
>
> amdgpu_uniras_query_block_ecc doesn't support being called during GPU res=
et.
>
> Signed-off-by: Ce Sun <cesun102@amd.com>
> Signed-off-by: YiPeng Chai <YiPeng.Chai@amd.com>

[Severity: Low]
This fixes the GPU reset timeout introduced when
amdgpu_ras_query_error_status() was wired to
amdgpu_uniras_query_block_ecc().  Should it carry:

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

[Severity: Medium]
Should this skip GPU reset unconditionally instead of gating on
amdgpu_uniras_enabled(adev), matching amdgpu_ras_reset_error_count()?

During XGMI reset-on-init (amdgpu_xgmi_reset_on_init_work()), the reset
thread holds down_write(&adev->reset_domain->sem), while UniRAS is not
enabled until amdgpu_ras_resume_after_reset() runs after the reset domain
is unlocked.  amdgpu_uniras_enabled(adev) also returns false during reset
on SR-IOV VFs (via amdgpu_virt_ras_remote_uniras_enabled()) and on
non-UniRAS devices.  When amdgpu_uniras_enabled(adev) is false here,
amdgpu_ras_query_error_status() falls through to
amdgpu_ras_query_error_status_with_event(), where
down_read_trylock(&adev->reset_domain->sem) fails against the reset
thread's own write lock and logs a false "RAS init query failure" warning
for every RAS block.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261113131151.1807=
-1-cesun102@amd.com?part=3D1
