Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC9DBCA5FA1
	for <amd-gfx@archiver.kernel.org>; Mon, 28 Sep 2026 16:20:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 325B710E0CB;
	Mon, 28 Sep 2026 16:20:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="ZfbYphDc";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3347C10E0CB
 for <amd-gfx@lists.freedesktop.org>; Mon, 28 Sep 2026 16:20:33 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id CADA9439C5;
 Mon, 28 Sep 2026 16:20:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 604A51F000FF;
 Mon, 28 Sep 2026 16:20:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1790612432;
 bh=haVC3ZDhXr6G1yi+CDxc5cTZbbKe7dXa5fxgrthI4M8=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To;
 b=ZfbYphDc4N8oyYT3UVWCZD4hD6E7hcOuSw3XarZ8mX4CojDkLq1o40ZTrvuLBjK4p
 OoPc8r3pfJM1E9IOHegWfJPlhY8dwNa9gwunb3HtKqM596tgfJdf5WEMXfeN4uOaQi
 cBkrCXMyHOIVrd1lsRIJ7NAfkX2x1N0DKhdUX4QVvCZ01mDgT+Hq/QoM42HmpYf0Wk
 Nn6jfdy7UEuAXiZEaiSPl7fpnEEFi0kkt+Ja4U1m5nE1oWXP7eEsLuK7ZL4MnWCQQX
 NrR+hTIqJkbsbfcAB7Xt8mvuLzvaVM9xlFrgvuZsbW8q4ifMxx3glkgbzglFqR287E
 CzvUI1KCOkLfw==
Message-ID: <2d9c87e5-8ead-4f46-a2ef-be7188d209af@kernel.org>
Date: Mon, 28 Sep 2026 11:20:31 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amd/amdgpu: Add newlines in drm_dbg format strings
Content-Language: en-US
To: Ed Maste <emaste@FreeBSD.org>, Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Cc: amd-gfx@lists.freedesktop.org
References: <20260928133030.69982-1-emaste@FreeBSD.org>
From: Mario Limonciello <superm1@kernel.org>
In-Reply-To: <20260928133030.69982-1-emaste@FreeBSD.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On 9/28/26 08:30, Ed Maste wrote:
> From: Ed Maste <emaste@FreeBSD.org>
> 
> Signed-off-by: Ed Maste <emaste@FreeBSD.org>

Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>

Applied to amd-staging-drm-next, thanks.

> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_atomfirmware.c | 2 +-
>   drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c    | 4 ++--
>   drivers/gpu/drm/amd/amdgpu/amdgpu_display.c      | 2 +-
>   drivers/gpu/drm/amd/amdgpu/isp_v4_1_1.c          | 2 +-
>   4 files changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_atomfirmware.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_atomfirmware.c
> index 1e21e3444802..c283087bb560 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_atomfirmware.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_atomfirmware.c
> @@ -311,7 +311,7 @@ static int amdgpu_atomfirmware_get_uma_carveout_info_v2_3(struct amdgpu_device *
>   
>   	if (nr_uma_options > MAX_UMA_OPTION_ENTRIES) {
>   		drm_dbg(adev_to_drm(adev),
> -			"Number of UMA options exceeds max table size. Options will not be parsed");
> +			"Number of UMA options exceeds max table size. Options will not be parsed\n");
>   		return -EINVAL;
>   	}
>   
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
> index 62f5c5cbd7f9..d23de711d8cf 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
> @@ -720,13 +720,13 @@ static int amdgpu_discovery_init(struct amdgpu_device *adev)
>   	/* Read from file if it is the preferred option */
>   	fw_name = amdgpu_discovery_get_fw_name(adev);
>   	if (fw_name != NULL) {
> -		drm_dbg(&adev->ddev, "use ip discovery information from file");
> +		drm_dbg(&adev->ddev, "use ip discovery information from file\n");
>   		r = amdgpu_discovery_read_binary_from_file(adev, discovery_bin,
>   							   fw_name);
>   		if (r)
>   			goto out;
>   	} else {
> -		drm_dbg(&adev->ddev, "use ip discovery information from memory");
> +		drm_dbg(&adev->ddev, "use ip discovery information from memory\n");
>   		r = amdgpu_discovery_read_binary_from_mem(adev, discovery_bin,
>   							  is_tmr_in_sysmem);
>   		if (r)
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c
> index 59ea338b554c..0a8dd7241750 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c
> @@ -1428,7 +1428,7 @@ static int amdgpu_display_framebuffer_init(struct drm_device *dev,
>   			ret = convert_tiling_flags_to_modifier_gfx6(rfb);
>   
>   		if (ret) {
> -			drm_dbg_kms(dev, "Failed to convert tiling flags 0x%llX to a modifier",
> +			drm_dbg_kms(dev, "Failed to convert tiling flags 0x%llX to a modifier\n",
>   				    rfb->tiling_flags);
>   			return ret;
>   		}
> diff --git a/drivers/gpu/drm/amd/amdgpu/isp_v4_1_1.c b/drivers/gpu/drm/amd/amdgpu/isp_v4_1_1.c
> index 485ecdec9618..363266f3e0a3 100644
> --- a/drivers/gpu/drm/amd/amdgpu/isp_v4_1_1.c
> +++ b/drivers/gpu/drm/amd/amdgpu/isp_v4_1_1.c
> @@ -235,7 +235,7 @@ static int isp_v4_1_1_hw_init(struct amdgpu_isp *isp)
>   
>   	r = amdgpu_acpi_get_isp4_dev(&acpi_dev);
>   	if (r) {
> -		drm_dbg(&adev->ddev, "Invalid isp platform detected (%d)", r);
> +		drm_dbg(&adev->ddev, "Invalid isp platform detected (%d)\n", r);
>   		/* allow GPU init to progress */
>   		return 0;
>   	}

