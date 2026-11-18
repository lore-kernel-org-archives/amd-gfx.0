Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76DA3606A32C
	for <amd-gfx@archiver.kernel.org>; Wed, 18 Nov 2026 16:18:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NIToFUqa
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E2E4010E81F;
	Wed, 18 Nov 2026 16:18:42 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CF63C10E81F
 for <amd-gfx@lists.freedesktop.org>; Wed, 18 Nov 2026 16:18:36 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 728F443C99;
 Wed, 18 Nov 2026 16:18:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29B771F000CC;
 Wed, 18 Nov 2026 16:18:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795018716;
 bh=MgcX4bqoP73kx1FK4XYPE6RqbPIYHbc0hSeJyO1FuKg=;
 h=Date:Subject:To:References:From:In-Reply-To;
 b=NIToFUqakChddwi9lGhvur5BJqdp4qkK44ecmDo6dzqlJpWjzPRBathRF2RE/JaZC
 ySbbJDb+Zk7qv09cg2mq6kEwlXEHHsSkQv2I/KXdK62800adYUKPe+d686eKWJ/wXB
 IaKOw2+5nd+/bF+FEvLfClSuSWHN+Fp5EPnwiWaw3s78xTOpwJxqciHR1h54nwDWeZ
 iFDbvAf6QtJeLxqANrL8ZSYvfqrR5oRAU+iW5gl6HtwbbyUPRF5mQacT3qOzhHO0Z9
 z9LUYO4WARF77CaYiOuoKhYvEu28OwdOPFDzRq+z84UopoxgY/ID0wBAlkAZo7/2vh
 B/UjToAV+siAw==
Message-ID: <102e192f-c8e9-4708-aacd-9bb21a78035a@kernel.org>
Date: Wed, 18 Nov 2026 10:18:33 -0600
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] drm/amd/amdgpu: Enable IMU_I/DRAM FW_LOAD CMD
Content-Language: en-US
To: Suresh Guttula <suresh.guttula@amd.com>, Alexander.Deucher@amd.com,
 amd-gfx@lists.freedesktop.org
References: <20261118151544.42346-1-suresh.guttula@amd.com>
From: Mario Limonciello <superm1@kernel.org>
In-Reply-To: <20261118151544.42346-1-suresh.guttula@amd.com>
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



On 11/18/26 09:15, Suresh Guttula wrote:
> For GC 11, Eventhough IMU ucode load from BIOS/IFWI, PSP exepct Load
> command from GFX to load IMU ucode.
> 
> v2:
> Updated fw_load_skip_check specific to GC11
> 
> Signed-off-by: Suresh Guttula <suresh.guttula@amd.com>

Reviewed-by: Mario Limonciello (AMD) <superm1@kernel.org>
Tested-by: Mario Limonciello (AMD) <superm1@kernel.org>

> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c | 10 ++++++++++
>   drivers/gpu/drm/amd/amdgpu/imu_v11_0.c  | 14 +++++++++++++-
>   2 files changed, 23 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
> index 7a8cc043df5e..e50796f530a9 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
> @@ -4023,6 +4023,16 @@ static int psp_load_smu_fw(struct psp_context *psp)
>   static bool fw_load_skip_check(struct psp_context *psp,
>   			       struct amdgpu_firmware_info *ucode)
>   {
> +	struct amdgpu_device *adev = psp->adev;
> +	/* Keep IMU firmware loading enabled for APUs with GC IP 11.0.0-11.7.1. */
> +	if ((adev->flags & AMD_IS_APU) &&
> +	    (amdgpu_ip_version(adev, GC_HWIP, 0) >= IP_VERSION(11, 0, 0)
> +	    && amdgpu_ip_version(adev, GC_HWIP, 0) <= IP_VERSION(11, 7, 1))) {
> +		if (!ucode->fw && (ucode->ucode_id == AMDGPU_UCODE_ID_IMU_I ||
> +		    ucode->ucode_id == AMDGPU_UCODE_ID_IMU_D))
> +			return false;
> +	}
> +
>   	if (!ucode->fw || !ucode->ucode_size)
>   		return true;
>   
> diff --git a/drivers/gpu/drm/amd/amdgpu/imu_v11_0.c b/drivers/gpu/drm/amd/amdgpu/imu_v11_0.c
> index b6c4ae35ca03..3aef68c9891a 100644
> --- a/drivers/gpu/drm/amd/amdgpu/imu_v11_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/imu_v11_0.c
> @@ -31,6 +31,8 @@
>   #include "gc/gc_11_0_0_offset.h"
>   #include "gc/gc_11_0_0_sh_mask.h"
>   
> +#define IMU_DATA_SIZE_BYTES	66304
> +
>   MODULE_FIRMWARE("amdgpu/gc_11_0_0_imu.bin");
>   MODULE_FIRMWARE("amdgpu/gc_11_0_0_imu_kicker.bin");
>   MODULE_FIRMWARE("amdgpu/gc_11_0_1_imu.bin");
> @@ -73,8 +75,18 @@ static int imu_v11_0_init_microcode(struct amdgpu_device *adev)
>   	else
>   		err = amdgpu_ucode_request(adev, &adev->gfx.imu_fw, required,
>   					   "amdgpu/%s_imu.bin", ucode_prefix);
> -	if (err == -ENODEV && imu_in_ifwi)
> +	if (err == -ENODEV && imu_in_ifwi) {
> +		info = &adev->firmware.ucode[AMDGPU_UCODE_ID_IMU_I];
> +		info->ucode_id = AMDGPU_UCODE_ID_IMU_I;
> +		info->fw = adev->gfx.imu_fw;
> +		info->ucode_size = IMU_DATA_SIZE_BYTES;
> +
> +		info = &adev->firmware.ucode[AMDGPU_UCODE_ID_IMU_D];
> +		info->ucode_id = AMDGPU_UCODE_ID_IMU_D;
> +		info->fw = adev->gfx.imu_fw;
> +		info->ucode_size = IMU_DATA_SIZE_BYTES;
>   		return 0;
> +	}
>   	if (err)
>   		goto out;
>   

