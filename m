Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE49BF4613B
	for <amd-gfx@archiver.kernel.org>; Mon, 23 Mar 2026 15:44:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7CA5E10E120;
	Mon, 23 Mar 2026 15:44:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="ELrnanuY";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3B74210E120
 for <amd-gfx@lists.freedesktop.org>; Mon, 23 Mar 2026 15:44:03 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 49F2643FFC;
 Mon, 23 Mar 2026 15:44:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E249AC4CEF7;
 Mon, 23 Mar 2026 15:44:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1774280643;
 bh=uY38mLKVP3tl29S7TYQEDCv6g3DlKXfA9Mkl7fnpJaE=;
 h=Date:Subject:To:References:From:In-Reply-To:From;
 b=ELrnanuY3KVnyjDqdH7p2pd8g2BRTgd0ZOq84hzhXfLP/F5fvv+4ENZwD5O5tBUio
 7B1ROQL8AEgiKqGbRNp6gzubN7TIFUQB557jg9NRhn7RMeOzQR4Ef06BPQzGGWenpZ
 KWbwq9h1c+E6Hn/C2jcF2z/Swqi6YxTfATRb1MPqCCRlUtIeL7gqn1khmVCGNem003
 qHTQlVT2ENKZZSkqxxXWX522MAgheEBJKjARW6QgVGPOBmj7UrSjC+ikL8+WgPcl5T
 Z6C2Cku/z2Gpdk70bHZSSJ5eRMB5jf5ku17FHk8ZWiTm0RKHqck2jRCrbNYhk1IjjI
 mrHiUT1O+nd+A==
Message-ID: <cae0746a-0c10-4857-8fd0-c372e149ed92@kernel.org>
Date: Mon, 23 Mar 2026 10:44:02 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] drm/amd/display: check if ext_caps is valid in BL
 setup
To: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
References: <20260323153923.1055788-1-alexander.deucher@amd.com>
Content-Language: en-US
From: "Mario Limonciello (AMD) (kernel.org)" <superm1@kernel.org>
In-Reply-To: <20260323153923.1055788-1-alexander.deucher@amd.com>
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



On 3/23/2026 10:39 AM, Alex Deucher wrote:
> LVDS connectors don't have extended backlight caps so check
> if the pointer is valid before accessing it.
> 
> Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/5012
> Fixes: 1454642960b0 ("drm/amd: Re-introduce property to control adaptive backlight modulation")
> Cc: Mario Limonciello <mario.limonciello@amd.com>
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> ---
>   drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> index 0955c2318ef2f..a347f48e3cd89 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> @@ -5417,7 +5417,7 @@ static void setup_backlight_device(struct amdgpu_display_manager *dm,
>   	caps = &dm->backlight_caps[aconnector->bl_idx];
>   
>   	/* Only offer ABM property when non-OLED and user didn't turn off by module parameter */
> -	if (!caps->ext_caps->bits.oled && amdgpu_dm_abm_level < 0)
> +	if (caps->ext_caps && !caps->ext_caps->bits.oled && amdgpu_dm_abm_level < 0)
>   		drm_object_attach_property(&aconnector->base.base,
>   					   dm->adev->mode_info.abm_level_property,
>   					   ABM_SYSFS_CONTROL);

Cc: stable@vger.kernel.org
Reviewed-by: Mario Limonciello (AMD) <superm1@kernel.org>


