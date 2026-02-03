Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42149E7C712
	for <amd-gfx@archiver.kernel.org>; Tue,  3 Feb 2026 02:04:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8F04B10E4A7;
	Tue,  3 Feb 2026 02:04:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="A4HLdSOU";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 907D110E2F7;
 Tue,  3 Feb 2026 02:04:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:References:
 Cc:To:From:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=xXySNBRq2X0toQ75IUwlKTn1DlOUVBe2wMK7L5VhHro=; b=A4HLdSOUCUqj9VkDRdbJWxs96b
 Pp+fm3xcpYGyWnWnCD7FAbjMGHwjwztnjkSiKOYqLduyee4cqcjEu5iMgLPIPHqW2V/ci7gZZvICQ
 aF5tHekN/OcI9z3JuDmq5g6nF55H3CvRd9ZCH5TYcfcrl81lO2lrNlspdpRHdC39bFDSTvgXX5NRW
 husme9WXLfWKZLYqgtXzCOnmWiJjYruaUelBdfmD5PN/CKKFwit+OTJ1XIPaa6XmtvTqW0QfNJ1ql
 imslahcUvSbtbm+m3DXY4uzTG4HlXmiz44F+XVygjQq3KVRzAd0bLWJZTsRVPFSdUbfuXmQF4y/+H
 b+pS8i+w==;
Received: from [186.208.68.91] (helo=[192.168.18.14])
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
 id 1vn5li-00D1PC-5L; Tue, 03 Feb 2026 03:03:54 +0100
Message-ID: <003737a0-7777-45f3-af55-4cee7a73ab9d@igalia.com>
Date: Mon, 2 Feb 2026 23:03:49 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amd/display: expose plane blend LUT in HW with MCM
From: Melissa Wen <mwen@igalia.com>
To: harry.wentland@amd.com, sunpeng.li@amd.com, siqueira@igalia.com,
 alexander.deucher@amd.com, christian.koenig@amd.com, airlied@gmail.com,
 simona@ffwll.ch
Cc: Matthew Schwartz <matthew.schwartz@linux.dev>,
 amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 kernel-dev@igalia.com, Alex Hung <alex.hung@amd.com>
References: <20251209151032.91738-1-mwen@igalia.com>
Content-Language: en-US
In-Reply-To: <20251209151032.91738-1-mwen@igalia.com>
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


On 09/12/2025 12:09, Melissa Wen wrote:
> Since commit 39923050615cd ("drm/amd/display: Clear DPP 3DLUT Cap")
> there is a flag in the mpc_color_caps that indicates the pre-blend usage
> of MPC color caps. Do the same as commit a0c3e8bfbab6 ("drm/amd/display:
> Use mpc.preblend flag to indicate preblend") and use the mpc.preblend
> flag to expose plane blend LUT/TF properties on AMD display driver.

A gentle ping here.

Melissa

>
> CC: Matthew Schwartz <matthew.schwartz@linux.dev>
> Signed-off-by: Melissa Wen <mwen@igalia.com>
> ---
>   drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c
> index 56cb866ac6f8..b15f0cf86008 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c
> @@ -1649,7 +1649,7 @@ dm_atomic_plane_attach_color_mgmt_properties(struct amdgpu_display_manager *dm,
>   					   MAX_COLOR_3DLUT_SIZE);
>   	}
>   
> -	if (dpp_color_caps.ogam_ram) {
> +	if (dpp_color_caps.ogam_ram || dm->dc->caps.color.mpc.preblend) {
>   		drm_object_attach_property(&plane->base,
>   					   mode_info.plane_blend_lut_property, 0);
>   		drm_object_attach_property(&plane->base,

