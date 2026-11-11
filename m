Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6024A606A326
	for <amd-gfx@archiver.kernel.org>; Wed, 11 Nov 2026 16:33:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WuZ2mHz7
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EBDF310EA6D;
	Wed, 11 Nov 2026 16:33:13 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 48F6E10FC1C
 for <amd-gfx@lists.freedesktop.org>; Wed, 11 Nov 2026 16:33:07 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 1A1D242434;
 Wed, 11 Nov 2026 16:33:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C28991F00A05;
 Wed, 11 Nov 2026 16:33:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794414787;
 bh=mCFpWH8Egprip+nPkF+upU3madeAyNskc/OlHH+A1NA=;
 h=Date:Subject:To:References:From:In-Reply-To;
 b=WuZ2mHz7EIsMiRjO3ZNpE59lX0zX8maGy+mNzefKYCC3BuxotSBEvUJQ1+YmWO6op
 n5F8EYJHtHFbAvI9zdNXDzQzAAi+9uc0j/Jun0LsKT48S8kn1tbYvdCZBNfDaY/nIj
 Gt/kSd4VrwI8D814ak9mVVC4Mg8GkaCxmWTUz6BoF9tejDhur1QnIraPDVjLGq41UW
 MjO0pV5O5N27F10zDyfU0jwf1Hvd8KOI4OELvJE++RJ8sQJJJKtfnpYGSmyjBVdPNU
 1F3YpdO1FQV37rb4NedrfTRwwJHVRS1trj9wZaVm4M36fzregB7F3nJ6h6hvevHyMq
 xAqFuuvhEeCnA==
Message-ID: <5291c76d-1ea8-4614-a517-e69b033f3486@kernel.org>
Date: Wed, 11 Nov 2026 10:33:04 -0600
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: bypass IMU ucode loading for GC 11 APU
Content-Language: en-US
To: Suresh Guttula <suresh.guttula@amd.com>, Alexander.Deucher@amd.com,
 amd-gfx@lists.freedesktop.org
References: <20261111154606.1172642-1-suresh.guttula@amd.com>
From: Mario Limonciello <superm1@kernel.org>
In-Reply-To: <20261111154606.1172642-1-suresh.guttula@amd.com>
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



On 11/11/26 09:46, Suresh Guttula wrote:
> For GC 11,IMU ucode is part of IFWI and ASP would load it by default.
> 
> Signed-off-by: Suresh Guttula <suresh.guttula@amd.com>

Reviewed-by: Mario Limonciello (AMD) <superm1@kernel.org>
Tested-by: Mario Limonciello (AMD) <superm1@kernel.org> # gfx1170, gfx1103

> ---
>   drivers/gpu/drm/amd/amdgpu/imu_v11_0.c | 13 +++++++++++--
>   1 file changed, 11 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/imu_v11_0.c b/drivers/gpu/drm/amd/amdgpu/imu_v11_0.c
> index 09dc01a425d1..e2b3f46bbc64 100644
> --- a/drivers/gpu/drm/amd/amdgpu/imu_v11_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/imu_v11_0.c
> @@ -52,16 +52,25 @@ static int imu_v11_0_init_microcode(struct amdgpu_device *adev)
>   	int err;
>   	const struct imu_firmware_header_v1_0 *imu_hdr;
>   	struct amdgpu_firmware_info *info = NULL;
> +	bool imu_in_ifwi;
> +	enum amdgpu_ucode_required required;
>   
>   	DRM_DEBUG("\n");
>   
> +	/* On GFX 11 APUs, ASP loads the IFWI IMU ucode by default. */
> +	imu_in_ifwi = adev->firmware.load_type == AMDGPU_FW_LOAD_PSP &&
> +		      (adev->flags & AMD_IS_APU);
> +	required = imu_in_ifwi ? AMDGPU_UCODE_OPTIONAL : AMDGPU_UCODE_REQUIRED;
> +
>   	amdgpu_ucode_ip_version_decode(adev, GC_HWIP, ucode_prefix, sizeof(ucode_prefix));
>   	if (amdgpu_is_kicker_fw(adev))
> -		err = amdgpu_ucode_request(adev, &adev->gfx.imu_fw, AMDGPU_UCODE_REQUIRED,
> +		err = amdgpu_ucode_request(adev, &adev->gfx.imu_fw, required,
>   					   "amdgpu/%s_imu_kicker.bin", ucode_prefix);
>   	else
> -		err = amdgpu_ucode_request(adev, &adev->gfx.imu_fw, AMDGPU_UCODE_REQUIRED,
> +		err = amdgpu_ucode_request(adev, &adev->gfx.imu_fw, required,
>   					   "amdgpu/%s_imu.bin", ucode_prefix);
> +	if (err == -ENODEV && imu_in_ifwi)
> +		return 0;
>   	if (err)
>   		goto out;
>   

