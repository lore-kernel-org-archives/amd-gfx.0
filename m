Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FDA8606A31C
	for <amd-gfx@archiver.kernel.org>; Tue, 17 Nov 2026 20:02:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QEViu3Eq
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D7B5A10F78B;
	Tue, 17 Nov 2026 20:02:00 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 14F0410F78B
 for <amd-gfx@lists.freedesktop.org>; Tue, 17 Nov 2026 20:01:54 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id ADEAA45CFB;
 Tue, 17 Nov 2026 20:01:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72A1A1F000C5;
 Tue, 17 Nov 2026 20:01:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794945713;
 bh=N7/qP+r8mrIgHyR7ktZaYnYrCwX7Cnr+cpzzIG/XH7I=;
 h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
 b=QEViu3EqUGbzZvr7+y3aQb/jk4XSYcRtjdB6x/gFNNwpsEnpRVLj/8TspaZC+5awE
 zXvAcYI0tHYi23u6Ds9HJiYRyrG8F/Z7Ro4hmmeAaTu1hogpphITpoNlm38avvUkTK
 YpV9G1pJOSx5Rg29mHI1gj8TdI0rXg7nz1M8MLkNruGlN35o1PYlxbtZysdVKMC7vj
 NrMXlU+6RoQmDYlNzFH15UhSyOrXF2XEmGEhqeHJt7LE5S7luHZEPsPHu/vm167frU
 OQRPZ638fDm92D7qc4bbuKvpoyM2HSQlykRKTi55DTybBxKXCAs+j2SOi+uGaza+p9
 qewUq8pXvuOxA==
Message-ID: <sashiko-outbox-219544@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] drm/amdgpu/userq: Add INFO IOCTL query for doorbell ranges
To: "Alex Deucher" <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
In-Reply-To: <20261117192304.809813-1-alexander.deucher@amd.com>
References: <20261117192304.809813-1-alexander.deucher@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 17 Nov 2026 20:01:53 +0000
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

Thank you for your contribution! Sashiko AI review found 2 potential
issues to consider:
- [High] drm/amdgpu: wrong unit multipliers in amdgpu_info_ioctl()
  doorbell range
- [Medium] drm/amdgpu: unsplit GFX and COMPUTE ranges in
  amdgpu_info_ioctl()
--

commit e3f1d2882f95267baaa962bef8149a9b40b07bea
Author: Alex Deucher <alexander.deucher@amd.com>

drm/amdgpu/userq: Add INFO IOCTL query for doorbell ranges

This commit adds the AMDGPU_INFO_UQ_DOORBELL_RANGE query to
amdgpu_info_ioctl() so userspace can query the per-IP doorbell byte offset
and size.

> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_kms.c
> index 8e7e522a89e42..acc4d0a1ca14f 100644
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
> +			db_range.offset_bytes =3D adev->doorbell_index.kiq * 4;
> +			db_range.size_bytes =3D (adev->doorbell_index.sdma_engine[0] -
> +					       adev->doorbell_index.kiq) * 4;

[Severity: Medium]
Should AMDGPU_HW_IP_GFX and AMDGPU_HW_IP_COMPUTE report separate doorbell
ranges instead of the combined [kiq, sdma_engine[0]) range?

On GFX11 and GFX12, gfx_v11_0_cp_set_doorbell_range() and
gfx_v12_0_cp_set_doorbell_range() program separate ranges for graphics and
compute:

drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c:gfx_v11_0_cp_set_doorbell_range() {
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

Reporting [kiq, sdma_engine[0]) for both IPs lets userspace place graphics
userqueue doorbells inside the compute range (starting at kiq rather than
gfx_ring0) and compute doorbells inside the graphics range, which breaks CP
doorbell filtering and firmware workload detection.

> +			return copy_to_user(out, &db_range,
> +					    min((size_t)size, sizeof(db_range))) ? -EFAULT : 0;
> +		case AMDGPU_HW_IP_DMA:
> +			db_range.offset_bytes =3D adev->doorbell_index.sdma_engine[0] * 4;
> +			db_range.size_bytes =3D adev->doorbell_index.sdma_doorbell_range * ad=
ev->sdma.num_instances;

[Severity: High]
Are the unit multipliers for db_range.offset_bytes and db_range.size_bytes
off by a factor of two for the qword indices and missing the dword-to-byte
conversion for sdma_doorbell_range?

In struct amdgpu_doorbell_index (drivers/gpu/drm/amd/amdgpu/amdgpu_doorbell=
.h),
doorbell_index fields such as kiq and sdma_engine[0] are 64-bit qword
indices (8 bytes each) on Vega10 and later, whereas sdma_doorbell_range is
a per-engine size in 32-bit dwords (4 bytes each):

drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c:sdma_v6_0_sw_init() {
    ...
		ring->doorbell_index =3D
			(adev->doorbell_index.sdma_engine[i] << 1); // get DWORD offset
    ...
}

Multiplying kiq and sdma_engine[0] by 4 instead of 8 (or << 3) returns half
the actual byte offset and size, placing AMDGPU_HW_IP_DMA doorbells at byte
offset 1024 inside the CP doorbell aperture instead of 2048 at the NBIO
SDMA aperture.  In addition, adev->doorbell_index.sdma_doorbell_range *
adev->sdma.num_instances is not multiplied by 4, so db_range.size_bytes
is returned in dwords rather than bytes.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261117192304.8098=
13-1-alexander.deucher@amd.com?part=3D1
