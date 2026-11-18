Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08E7C606A325
	for <amd-gfx@archiver.kernel.org>; Wed, 18 Nov 2026 23:04:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Yu3kkDaN
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7AE8C10ECBA;
	Wed, 18 Nov 2026 23:04:27 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0ABA110ECBA
 for <amd-gfx@lists.freedesktop.org>; Wed, 18 Nov 2026 23:04:22 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id A3CD14358F;
 Wed, 18 Nov 2026 23:04:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 539831F000C6;
 Wed, 18 Nov 2026 23:04:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795043061;
 bh=a7f+XoRH2NEskUwXpTnQK18DBPWRLTjJvj3vHJvRq2U=;
 h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
 b=Yu3kkDaNIsQBNQZbxCJoRV+MP5Fljjn82mGn9vkhD5/GbbpZPFuiHCyOqa5hXTNas
 nBPj/I9byaTn6euc7EZlDXZaCINxPUGi4zMEYOxlpjRhqcFzVKX6E50ay6TtCb3IJD
 4TS/EaGmLesNICKTxbAsaCy/g4jNm4vDDavbsk/tEU/e1ma+sOZ7hVAcKmy09y5k5U
 bxhN9JNqDfKnneeZoWvp3rdD6xCN4Ar+4e3tfHpsR1AFMoU9kNdg3EL5pVdnRBCgtj
 WKhWsXF1f6URxTaNAkC6se9WcWDOfQMFPc4rUQhy8PSegAN+2FsfFEQvbCmmW/5Mce
 qEqU3qW2oc5NA==
Message-ID: <sashiko-outbox-222141@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 01/11] drm/amdgpu/userq: Add INFO IOCTL query for
 doorbell ranges
To: "Alex Deucher" <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
In-Reply-To: <20261118223712.2518580-1-alexander.deucher@amd.com>
References: <20261118223712.2518580-1-alexander.deucher@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 18 Nov 2026 23:04:20 +0000
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
- [High] drm/amdgpu: amdgpu_info_ioctl() returns combined GFX/compute
  doorbell range
--

commit 81484698f4a74ac4cd4b7b1d2435342b60989454
Author: Alex Deucher <alexander.deucher@amd.com>

drm/amdgpu/userq: Add INFO IOCTL query for doorbell ranges

This commit adds the AMDGPU_INFO_UQ_DOORBELL_RANGE subquery to
amdgpu_info_ioctl() so userspace can query the per-page doorbell byte offset
and size for GFX, compute, and SDMA user queues.

> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_kms.c
> index 8e7e522a89e42..23858589dd15c 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> @@ -1452,6 +1452,26 @@ int amdgpu_info_ioctl(struct drm_device *dev, void=
 *data, struct drm_file *filp)
>  			return -EINVAL;
>  		}
>  	}
> +	case AMDGPU_INFO_UQ_DOORBELL_RANGE: {
> +		struct drm_amdgpu_info_doorbell_range db_range =3D {};
> +
> +		switch (info->query_hw_ip.type) {
> +		case AMDGPU_HW_IP_GFX:
> +		case AMDGPU_HW_IP_COMPUTE:
> +			db_range.offset_bytes =3D adev->doorbell_index.kiq << 3;
> +			db_range.size_bytes =3D (adev->doorbell_index.sdma_engine[0] -
> +					       adev->doorbell_index.kiq) << 3;

[Severity: High]
Should AMDGPU_HW_IP_GFX and AMDGPU_HW_IP_COMPUTE return separate doorbell
sub-ranges instead of the combined [kiq, sdma_engine[0]) range?

On GFX11 and GFX12, the CP doorbell range registers partition each doorbell
page into disjoint ranges for compute (kiq..userqueue_end) and graphics
(gfx_ring0..gfx_userqueue_end):

drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c:gfx_v11_0_cp_set_doorbell_range() {
	...
	/* set graphics engine doorbell range */
	WREG32_SOC15(GC, 0, regCP_RB_DOORBELL_RANGE_LOWER,
		     (adev->doorbell_index.gfx_ring0 * 2) << 2);
	WREG32_SOC15(GC, 0, regCP_RB_DOORBELL_RANGE_UPPER,
		     (adev->doorbell_index.gfx_userqueue_end * 2) << 2);

	/* set compute engine doorbell range */
	WREG32_SOC15(GC, 0, regCP_MEC_DOORBELL_RANGE_LOWER,
		     (adev->doorbell_index.kiq * 2) << 2);
	WREG32_SOC15(GC, 0, regCP_MEC_DOORBELL_RANGE_UPPER,
		     (adev->doorbell_index.userqueue_end * 2) << 2);
}

As noted in fd0ed91ae8a2 ("drm/amdgpu: correct cp doorbell range"), hardware
and firmware rely on these ranges to distinguish GFX and compute doorbell
activity for power-saving states.  Returning the combined range for both IP
types causes userspace to allocate GFX doorbells inside the MEC compute
range and compute doorbells inside the CP_RB graphics range.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261118223712.2518=
580-1-alexander.deucher@amd.com?part=3D1
