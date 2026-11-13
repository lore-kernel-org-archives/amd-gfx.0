Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC871606A327
	for <amd-gfx@archiver.kernel.org>; Fri, 13 Nov 2026 15:29:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lTi4Doa0
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 39AEA10E4BE;
	Fri, 13 Nov 2026 15:29:33 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8FDA010E4BE
 for <amd-gfx@lists.freedesktop.org>; Fri, 13 Nov 2026 15:29:27 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id D21E060DEF;
 Fri, 13 Nov 2026 15:29:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 641131F000C4;
 Fri, 13 Nov 2026 15:29:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794583766;
 bh=NWPdCagNhzDuoUaMyYRLDDHOcGZBiV6SK0ftJff+0A0=;
 h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
 b=lTi4Doa0G4VnXNPIIldJnPkBjZruQwqtFmj1Pwj9kMmCuctu5TLgnbo9/3osyKHz9
 oNO5EhffcBpYyUieCZCfMADX50ErLJVBj6ZShPaz+1qe86avidRNS1FLpLGTd8LVv5
 CNBYmyBIK+oXeihHL1Zb71ID3yDsMX/LKYnP2TFlkHQQkZCahgLN8PelQ9oklDBxAv
 fGkxPmaUDDOL5BUiEKmY2RRdEI/dx0EJ2PoH3YR9iBCKnnjJUPMWXAalgDQnJbVCTU
 vonu+OoTUTfejEG0YTvsZedTnVa/Yhg1ua69ikHQnOXJlCHp/QzKIxCN45RqJxnBgW
 xVH6fwFAFv50w==
Message-ID: <sashiko-outbox-213090@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 7/7] drm/amdgpu: keep the A+A VF VRAM base at the SRAT
 address
To: "Zhigang Luo" <Zhigang.Luo@amd.com>, amd-gfx@lists.freedesktop.org
In-Reply-To: <20261113145702.323968-7-Zhigang.Luo@amd.com>
References: <20261113145702.323968-1-Zhigang.Luo@amd.com>
 <20261113145702.323968-7-Zhigang.Luo@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 13 Nov 2026 15:29:25 +0000
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
- [High] drm/amdgpu: amdgpu_acpi_find_gpu_memory_in_srat() always
  returns -ENOENT
--

commit eababb17e2adcd526ed509506729f9c07f446351
Author: Zhigang Luo <Zhigang.Luo@amd.com>

drm/amdgpu: keep the A+A VF VRAM base at the SRAT address

This commit reads the ACPI SRAT entry in mmhub_v4_2_0_get_xgmi_info() on A+A
SPM VFs to set the framebuffer offset and single-node XGMI segment size from
the SRAT address and length.

> diff --git a/drivers/gpu/drm/amd/amdgpu/mmhub_v4_2_0.c b/drivers/gpu/drm/=
amd/amdgpu/mmhub_v4_2_0.c
> index 4495d52b4b07c..8593453445e38 100644
> --- a/drivers/gpu/drm/amd/amdgpu/mmhub_v4_2_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/mmhub_v4_2_0.c
> @@ -132,6 +132,27 @@ static int mmhub_v4_2_0_get_xgmi_info(struct amdgpu_=
device *adev)
>  	if (!adev->gmc.xgmi.connected_to_cpu)
>  		return 0;
> =20
> +	/* The SRAT entry is the VF's whole VRAM. PF_LFB_REGION describes
> +	 * the physical GPU, not the VF, so report a single node. The
> +	 * length is the segment size; the address is the FB offset.
> +	 * aper_base is filled from those later.
> +	 */
> +	if (amdgpu_virt_vram_is_spm(adev)) {
> +		u64 fb_offset;
> +		int r;
> +
> +		r =3D amdgpu_acpi_find_gpu_memory_in_srat(adev, &fb_offset,
> +							&seg_size);
> +		if (r)
> +			return r;

[Severity: High]
Does calling amdgpu_acpi_find_gpu_memory_in_srat() here cause
mmhub_v4_2_0_get_xgmi_info() to always fail with -ENOENT on mainline builds?
The real implementation of amdgpu_acpi_find_gpu_memory_in_srat() is guarded
by HAVE_ACPI_SRAT_GENERIC_AFFINITY, which is never defined in the kernel
tree:

drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c:
#ifdef HAVE_ACPI_SRAT_GENERIC_AFFINITY
...
int amdgpu_acpi_find_gpu_memory_in_srat(struct amdgpu_device *adev,
					uint64_t *base_addr, uint64_t *length)
{
...
}
#else
int amdgpu_acpi_find_gpu_memory_in_srat(struct amdgpu_device *adev,
					uint64_t *base_addr, uint64_t *length)
{
	if (!base_addr || !length)
		return -EINVAL;

	return -ENOENT;
}
#endif

Because only the #else stub is compiled, mmhub_v4_2_0_get_xgmi_info() retur=
ns
-ENOENT and aborts amdgpu_device_init() on all A+A SPM VFs.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261113145702.3239=
68-1-Zhigang.Luo@amd.com?part=3D7
