Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D932CFDEE2F
	for <amd-gfx@archiver.kernel.org>; Thu, 23 Apr 2026 17:27:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 62C6910F1CC;
	Thu, 23 Apr 2026 17:27:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="GSSbUrG+";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 36C2110F1CC
 for <amd-gfx@lists.freedesktop.org>; Thu, 23 Apr 2026 17:27:21 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id F020A41A9F;
 Thu, 23 Apr 2026 17:27:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97044C2BCAF;
 Thu, 23 Apr 2026 17:27:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1776965240;
 bh=h7ooRu/kSV2ABkIF0C91xE3h257UNxZQxmb9d1XjP/0=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=GSSbUrG+zFNWEmAz1k+FerKiZgtr3UcjewDm6ZvXSnYAlrfZEz7xzJ4cxJ5ajQFXB
 wKuZ/4bDrXy+OXn/7jqpM2G2xiHyZmAkORs+sZB3IRajQf5Fi29noE1X/SLpS7NjWb
 2mfSw/nhg5qEVgYX7dOFon9GhZM2tJyait/WxrAYLe/xTTIdjld3HTbWHV57F4OR4u
 wNAp8JAdL+v1bnQn5flOKgZJQoxY4IWGKOj5shDRabYqVaLB7w9Y55FxXgWDI17mfQ
 +Ghjb0stWixY+goFSO3LyX5LhZsUlwX6B/CYfEnQl8mqwVm7Qe0aEIN2dArhtG2jie
 /x7lLL1ItNoeQ==
Message-ID: <cef1cb19-d3ad-451e-a455-04d8dfc59015@kernel.org>
Date: Thu, 23 Apr 2026 12:27:19 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amd/display: properly handle family setting for early
 GC 11.5.4
Content-Language: en-US
To: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Pratik Vishwakarma <Pratik.Vishwakarma@amd.com>,
 Roman Li <Roman.Li@amd.com>
References: <20260423164225.2345139-1-alexander.deucher@amd.com>
From: Mario Limonciello <superm1@kernel.org>
In-Reply-To: <20260423164225.2345139-1-alexander.deucher@amd.com>
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

On 4/23/26 11:42, Alex Deucher wrote:
> Early variants need an override.
> 
> Fixes: 57d00816c6a9 ("drm/amdgpu: set family for GC 11.5.4")
> Cc: Pratik Vishwakarma <Pratik.Vishwakarma@amd.com>
> Cc: Roman Li <Roman.Li@amd.com>
> Cc: Mario Limonciello <superm1@kernel.org>
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>

Reviewed-by: Mario Limonciello (AMD) <superm1@kernel.org>
Tested-by: Mario Limonciello (AMD) <superm1@kernel.org>

> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c     | 4 +---
>   drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 6 +++++-
>   2 files changed, 6 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
> index 31d85606d31b5..5dbe3d6963b9a 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
> @@ -3091,10 +3091,8 @@ int amdgpu_discovery_set_ip_blocks(struct amdgpu_device *adev)
>   	case IP_VERSION(11, 5, 1):
>   	case IP_VERSION(11, 5, 2):
>   	case IP_VERSION(11, 5, 3):
> -		adev->family = AMDGPU_FAMILY_GC_11_5_0;
> -		break;
>   	case IP_VERSION(11, 5, 4):
> -		adev->family = AMDGPU_FAMILY_GC_11_5_4;
> +		adev->family = AMDGPU_FAMILY_GC_11_5_0;
>   		break;
>   	case IP_VERSION(12, 0, 0):
>   	case IP_VERSION(12, 0, 1):
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> index 3fa4dbda4517c..a8e6bf3e116e4 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> @@ -1967,7 +1967,11 @@ static int amdgpu_dm_init(struct amdgpu_device *adev)
>   		goto error;
>   	}
>   
> -	init_data.asic_id.chip_family = adev->family;
> +	/* special handling for early revisions of GC 11.5.4 */
> +	if (amdgpu_ip_version(adev, GC_HWIP, 0) == IP_VERSION(11, 5, 4))
> +		init_data.asic_id.chip_family = AMDGPU_FAMILY_GC_11_5_4;
> +	else
> +		init_data.asic_id.chip_family = adev->family;
>   
>   	init_data.asic_id.pci_revision_id = adev->pdev->revision;
>   	init_data.asic_id.hw_internal_rev = adev->external_rev_id;

