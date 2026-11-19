Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B8AB606A324
	for <amd-gfx@archiver.kernel.org>; Thu, 19 Nov 2026 14:47:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MkQcAvjn
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7FF3A1124D4;
	Thu, 19 Nov 2026 14:47:11 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5D5EC1124DC
 for <amd-gfx@lists.freedesktop.org>; Thu, 19 Nov 2026 14:47:05 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 5D4DE618FF;
 Thu, 19 Nov 2026 14:47:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4846A1F000C4;
 Thu, 19 Nov 2026 14:47:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795099624;
 bh=t9DtIDmGlHVEdsT1I40Eirez8FFqPh/iYgCSNhPb7mk=;
 h=Date:Subject:To:References:From:In-Reply-To;
 b=MkQcAvjnD7mIz2ISDJ1C4Bn5Vloyk+lopENMCXy9Xf+LzZ2/XIZM9VCbonsTNWqF2
 ISYwYihtxJK06CpNPO3Pfda8wnqlC2mzMHNAbAMf8ebimN0C5OfQvGkT2MS03QYCGF
 C7IwRMf1myfaUb90jhGFn7BtzU7xGks+4LHp/Ye9q2th37iQrAWQlXehCBa54LLQ9H
 Fm9WkG7/dig4bpkrxLYa3umIMsmjsBsKMHa6I5GthuRJxAT35Z25lxWRaMB9CJIJxC
 bSzCL3mnKFjlx16xdTwTuD/tqQCRd4B+wvlnIv/Kl3OwvcGaYYVh57k08FKdk1FU5b
 rlDcmTQHHAqyg==
Message-ID: <2a2d29ce-269e-42df-9ebc-950984dd4589@kernel.org>
Date: Thu, 19 Nov 2026 08:46:55 -0600
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: add helper for determining removable devices
 (USB4, TB)
Content-Language: en-US
To: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
References: <20261119144309.3013871-1-alexander.deucher@amd.com>
From: Mario Limonciello <superm1@kernel.org>
In-Reply-To: <20261119144309.3013871-1-alexander.deucher@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 11/19/26 08:43, Alex Deucher wrote:
> Apparently some Intel TB ports don't set dev_is_removable() on attached
> devices and thus the current check fails.  Add a helper to check both
> dev_is_removable() and TB attached.
> 
> Cc: superm1@kernel.org
> Closes: https://gitlab.freedesktop.org/drm/amd/-/work_items/6163
> Fixes: d9b3a066dfcd ("drm/amd: Exclude dGPUs in eGPU enclosures from DPM quirks")
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>

Reviewed-by: Mario Limonciello (AMD) <superm1@kernel.org>

> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu.h        |  2 ++
>   drivers/gpu/drm/amd/amdgpu/amdgpu_bios.c   |  2 +-
>   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 24 ++++++++++++++--------
>   drivers/gpu/drm/amd/amdgpu/nbio_v2_3.c     |  4 ++--
>   4 files changed, 21 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> index 7e1b9a70fd150..5dfb57e7c0b32 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> @@ -1053,6 +1053,8 @@ int amdgpu_do_asic_reset(struct list_head *device_list_handle,
>   
>   int amdgpu_device_reinit_after_reset(struct amdgpu_reset_context *reset_context);
>   
> +bool amdgpu_device_is_removable(struct amdgpu_device *adev);
> +
>   int emu_soc_asic_init(struct amdgpu_device *adev);
>   
>   /*
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_bios.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_bios.c
> index 6bbca70a4e2eb..4918e891f9781 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_bios.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_bios.c
> @@ -369,7 +369,7 @@ static bool amdgpu_atrm_get_bios(struct amdgpu_device *adev)
>   	bool found = false;
>   
>   	/* ATRM is for on-platform devices only */
> -	if (dev_is_removable(&adev->pdev->dev))
> +	if (amdgpu_device_is_removable(adev))
>   		return false;
>   
>   	while ((pdev = pci_get_base_class(PCI_BASE_CLASS_DISPLAY, pdev))) {
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> index ea960085bfc8c..7179011d1b0a2 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -617,8 +617,7 @@ void amdgpu_device_detect_runtime_pm_mode(struct amdgpu_device *adev)
>   	int bamaco_support;
>   
>   	adev->pm.rpm_mode = AMDGPU_RUNPM_NONE;
> -	if (pci_is_thunderbolt_attached(adev->pdev) ||
> -	    dev_is_removable(&adev->pdev->dev)) {
> +	if (amdgpu_device_is_removable(adev)) {
>   		dev_info(adev->dev,
>   			 "Runtime PM disabled for externally attached device\n");
>   		return;
> @@ -1286,6 +1285,16 @@ bool amdgpu_device_seamless_boot_supported(struct amdgpu_device *adev)
>   	return amdgpu_ip_version(adev, DCE_HWIP, 0) >= IP_VERSION(3, 0, 0);
>   }
>   
> +bool amdgpu_device_is_removable(struct amdgpu_device *adev)
> +{
> +	/* older TB systems don't set dev_is_removable so check both here */
> +	if (dev_is_removable(adev->dev) ||
> +	    pci_is_thunderbolt_attached(adev->pdev))
> +		return true;
> +
> +	return false;
> +}
> +
>   #if IS_ENABLED(CONFIG_X86)
>   static const struct x86_cpu_id amdgpu_pcie_dynamic_switching_quirks[] = {
>   	/*
> @@ -1308,8 +1317,8 @@ static const struct x86_cpu_id amdgpu_pcie_dynamic_switching_quirks[] = {
>   
>   static bool amdgpu_device_pcie_dynamic_switching_supported(struct amdgpu_device *adev)
>   {
> -	/* eGPU change speeds based on USB4 fabric conditions */
> -	if (dev_is_removable(adev->dev))
> +	/* eGPU change speeds based on USB4/TB fabric conditions */
> +	if (amdgpu_device_is_removable(adev))
>   		return true;
>   
>   	/* Hosts have problems with dynamic speed switching */
> @@ -2077,7 +2086,7 @@ static int amdgpu_device_ip_early_init(struct amdgpu_device *adev)
>   	    (amdgpu_is_atpx_hybrid() ||
>   	     amdgpu_has_atpx_dgpu_power_cntl()) &&
>   	    ((adev->flags & AMD_IS_APU) == 0) &&
> -	    !dev_is_removable(&adev->pdev->dev))
> +	    !amdgpu_device_is_removable(adev))
>   		adev->flags |= AMD_IS_PX;
>   
>   	if (!(adev->flags & AMD_IS_APU)) {
> @@ -3820,9 +3829,8 @@ static void amdgpu_device_sys_interface_fini(struct amdgpu_device *adev)
>   static bool
>   amdgpu_device_should_register_switcheroo(struct amdgpu_device *adev, bool px)
>   {
> -	return !pci_is_thunderbolt_attached(adev->pdev) &&
> -	       (px || (!dev_is_removable(&adev->pdev->dev) &&
> -		       apple_gmux_detect(NULL, NULL)));
> +	return !amdgpu_device_is_removable(adev) &&
> +		(px || apple_gmux_detect(NULL, NULL));
>   }
>   
>   /**
> diff --git a/drivers/gpu/drm/amd/amdgpu/nbio_v2_3.c b/drivers/gpu/drm/amd/amdgpu/nbio_v2_3.c
> index 04041b398781b..3da92fb09495d 100644
> --- a/drivers/gpu/drm/amd/amdgpu/nbio_v2_3.c
> +++ b/drivers/gpu/drm/amd/amdgpu/nbio_v2_3.c
> @@ -357,7 +357,7 @@ static void nbio_v2_3_enable_aspm(struct amdgpu_device *adev,
>   
>   		data |= NAVI10_PCIE__LC_L0S_INACTIVITY_DEFAULT << PCIE_LC_CNTL__LC_L0S_INACTIVITY__SHIFT;
>   
> -		if (dev_is_removable(&adev->pdev->dev))
> +		if (amdgpu_device_is_removable(adev))
>   			data |= NAVI10_PCIE__LC_L1_INACTIVITY_TBT_DEFAULT  << PCIE_LC_CNTL__LC_L1_INACTIVITY__SHIFT;
>   		else
>   			data |= NAVI10_PCIE__LC_L1_INACTIVITY_DEFAULT << PCIE_LC_CNTL__LC_L1_INACTIVITY__SHIFT;
> @@ -476,7 +476,7 @@ static void nbio_v2_3_program_aspm(struct amdgpu_device *adev)
>   
>   	def = data = RREG32_PCIE(smnPCIE_LC_CNTL);
>   	data |= NAVI10_PCIE__LC_L0S_INACTIVITY_DEFAULT << PCIE_LC_CNTL__LC_L0S_INACTIVITY__SHIFT;
> -	if (dev_is_removable(&adev->pdev->dev))
> +	if (amdgpu_device_is_removable(adev))
>   		data |= NAVI10_PCIE__LC_L1_INACTIVITY_TBT_DEFAULT  << PCIE_LC_CNTL__LC_L1_INACTIVITY__SHIFT;
>   	else
>   		data |= NAVI10_PCIE__LC_L1_INACTIVITY_DEFAULT << PCIE_LC_CNTL__LC_L1_INACTIVITY__SHIFT;

