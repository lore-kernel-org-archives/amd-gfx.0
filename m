Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D588C36008
	for <amd-gfx@archiver.kernel.org>; Tue, 25 Mar 2025 19:54:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4117C10E5EA;
	Tue, 25 Mar 2025 19:54:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="Ui9JxKBG";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E9CB110E5E9
 for <amd-gfx@lists.freedesktop.org>; Tue, 25 Mar 2025 19:53:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
 Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=DwK9EanAARQneSaUEcamj/8D6LNf72E5Jg023PMwkys=; b=Ui9JxKBGFVc5jDNY12mwrjkKIE
 YOIH0p2lKlHJ4yMcx7rM2rLUCRIUGLfpq3D49eG8wP3exVso3bN6P4LoVQammeBmhKDTQvZSoKBYl
 qp5ZZLWym6eBu1SUgboYmbcKYgXHyKepe3bzO9SMWOYyoyh/LkMxM8QmXTXIyYe+fb+e6SstpcntX
 0AOfzMzmNzDlMfR/haFvLmlQhnc671lo7Gx0a2je0xaa79d7DMl4ysmiP32B5UW1BkqD7d/zPZRmS
 2lVmpdjjLRvCDWqs70rPrnJk3SmpVQLO1jetIZhlOytaqf1aisk9FHtZSmx3pUIDZI/iru5czhE5z
 57aeUDJw==;
Received: from d162-157-58-14.abhsia.telus.net ([162.157.58.14]
 helo=maloca.localdomain) by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1txALV-006IVk-P2; Tue, 25 Mar 2025 20:53:58 +0100
Date: Tue, 25 Mar 2025 13:53:54 -0600
From: Rodrigo Siqueira <siqueira@igalia.com>
To: Alex Deucher <alexander.deucher@amd.com>
Cc: amd-gfx@lists.freedesktop.org
Subject: Re: [PATCH] drm/amdgpu: drop some dead code
Message-ID: <cqm7y72s6xsmtty7wogzii5mp5uabpyi5hbsw4x7dioiz3r5gh@5tbbz3roxzow>
References: <20250325141415.424864-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250325141415.424864-1-alexander.deucher@amd.com>
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

On 03/25, Alex Deucher wrote:
> Drop the cgs smu firmware code for SI, it's not used.
> The smu firmware fetching for SI is done in si_dpm.c.
> 
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_cgs.c | 61 -------------------------
>  1 file changed, 61 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_cgs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_cgs.c
> index 525e53c94f4f5..004a6a9d6b9fa 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cgs.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cgs.c
> @@ -252,67 +252,6 @@ static int amdgpu_cgs_get_firmware_info(struct cgs_device *cgs_device,
>  
>  		if (!adev->pm.fw) {
>  			switch (adev->asic_type) {
> -			case CHIP_TAHITI:
> -				strscpy(fw_name, "radeon/tahiti_smc.bin");
> -				break;
> -			case CHIP_PITCAIRN:
> -				if ((adev->pdev->revision == 0x81) &&
> -				    ((adev->pdev->device == 0x6810) ||
> -				    (adev->pdev->device == 0x6811))) {
> -					info->is_kicker = true;
> -					strscpy(fw_name, "radeon/pitcairn_k_smc.bin");
> -				} else {
> -					strscpy(fw_name, "radeon/pitcairn_smc.bin");
> -				}
> -				break;
> -			case CHIP_VERDE:
> -				if (((adev->pdev->device == 0x6820) &&
> -					((adev->pdev->revision == 0x81) ||
> -					(adev->pdev->revision == 0x83))) ||
> -				    ((adev->pdev->device == 0x6821) &&
> -					((adev->pdev->revision == 0x83) ||
> -					(adev->pdev->revision == 0x87))) ||
> -				    ((adev->pdev->revision == 0x87) &&
> -					((adev->pdev->device == 0x6823) ||
> -					(adev->pdev->device == 0x682b)))) {
> -					info->is_kicker = true;
> -					strscpy(fw_name, "radeon/verde_k_smc.bin");
> -				} else {
> -					strscpy(fw_name, "radeon/verde_smc.bin");
> -				}
> -				break;
> -			case CHIP_OLAND:
> -				if (((adev->pdev->revision == 0x81) &&
> -					((adev->pdev->device == 0x6600) ||
> -					(adev->pdev->device == 0x6604) ||
> -					(adev->pdev->device == 0x6605) ||
> -					(adev->pdev->device == 0x6610))) ||
> -				    ((adev->pdev->revision == 0x83) &&
> -					(adev->pdev->device == 0x6610))) {
> -					info->is_kicker = true;
> -					strscpy(fw_name, "radeon/oland_k_smc.bin");
> -				} else {
> -					strscpy(fw_name, "radeon/oland_smc.bin");
> -				}
> -				break;
> -			case CHIP_HAINAN:
> -				if (((adev->pdev->revision == 0x81) &&
> -					(adev->pdev->device == 0x6660)) ||
> -				    ((adev->pdev->revision == 0x83) &&
> -					((adev->pdev->device == 0x6660) ||
> -					(adev->pdev->device == 0x6663) ||
> -					(adev->pdev->device == 0x6665) ||
> -					 (adev->pdev->device == 0x6667)))) {
> -					info->is_kicker = true;
> -					strscpy(fw_name, "radeon/hainan_k_smc.bin");
> -				} else if ((adev->pdev->revision == 0xc3) &&
> -					 (adev->pdev->device == 0x6665)) {
> -					info->is_kicker = true;
> -					strscpy(fw_name, "radeon/banks_k_2_smc.bin");
> -				} else {
> -					strscpy(fw_name, "radeon/hainan_smc.bin");
> -				}
> -				break;
>  			case CHIP_BONAIRE:

Is there any specific reason why the other ASICs in this switch
(Bonaire, Hawaii, etc) are not using a similar mechanism like si_dpm.c?

Anyway,

Reviewed-by: Rodrigo Siqueira <siqueira@igalia.com>

Thanks

>  				if ((adev->pdev->revision == 0x80) ||
>  					(adev->pdev->revision == 0x81) ||
> -- 
> 2.49.0
> 

-- 
Rodrigo Siqueira
