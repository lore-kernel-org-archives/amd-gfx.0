Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82C48C2FC0E
	for <amd-gfx@archiver.kernel.org>; Thu, 17 Aug 2023 09:24:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0505A10E417;
	Thu, 17 Aug 2023 09:24:31 +0000 (UTC)
Received: from ms7.webland.ch (ms7.webland.ch [92.43.217.107])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7965010E417
 for <amd-gfx@lists.freedesktop.org>; Thu, 17 Aug 2023 09:24:28 +0000 (UTC)
Received: from [192.168.1.137] ([213.144.156.170])
 by ms7.webland.ch (12.3.0 build 2 x64) with ASMTP (SSL) id
 01202308171124249702; Thu, 17 Aug 2023 11:24:24 +0200
Message-ID: <6bf57265-0572-4923-8a24-e1035c1bf228@daenzer.net>
Date: Thu, 17 Aug 2023 11:24:22 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.1
Content-Language: en-CA
To: Simon Ser <contact@emersion.fr>
References: <20210310145019.2877-6-contact@emersion.fr>
From: =?UTF-8?Q?Michel_D=c3=a4nzer?= <michel@daenzer.net>
Subject: Re: [PATCH v2,5/5] amd/display: re-introduce cursor plane rotation
 prop
In-Reply-To: <20210310145019.2877-6-contact@emersion.fr>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CTCH: RefID="str=0001.0A782F24.64DDE749.0040,ss=1,re=0.000,recu=0.000,reip=0.000,cl=1,cld=1,fgs=0";
 Spam="Unknown"; VOD="Unknown"
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Harry Wentland <hwentlan@amd.com>,
 Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>,
 amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>


Why is this patch marked as rejected in patchwork? Something like this seems required for a Wayland compositor to use the HW cursor with rotated primary/overlay planes.


On 3/10/21 15:50, Simon Ser wrote:
> The commit 1347385fe187 ("drm/amd/display: don't expose rotation
> prop for cursor plane") removed the rotation property for the
> cursor plane, assuming the cursor would always be displayed without
> any rotation. However the rotation is inherited from the underlying
> plane.
> 
> As a result, if the primary plane is rotated, then the cursor plane
> will incorrectly be rotated as well even though it doesn't have a
> rotation property.
> 
> To fix this, re-introduce the cursor rotation property, and check
> that its value matches the underlying plane's.
> 
> Signed-off-by: Simon Ser <contact@emersion.fr>
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Cc: Harry Wentland <hwentlan@amd.com>
> Cc: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
> ---
>  drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> index b4f6e2985b8a..36ee52104007 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> @@ -6897,8 +6897,7 @@ static int amdgpu_dm_plane_init(struct amdgpu_display_manager *dm,
>  		DRM_MODE_ROTATE_0 | DRM_MODE_ROTATE_90 |
>  		DRM_MODE_ROTATE_180 | DRM_MODE_ROTATE_270;
>  
> -	if (dm->adev->asic_type >= CHIP_BONAIRE &&
> -	    plane->type != DRM_PLANE_TYPE_CURSOR)
> +	if (dm->adev->asic_type >= CHIP_BONAIRE)
>  		drm_plane_create_rotation_property(plane, DRM_MODE_ROTATE_0,
>  						   supported_rotations);
>  
> @@ -9494,6 +9493,11 @@ static int dm_check_crtc_cursor(struct drm_atomic_state *state,
>  		return -EINVAL;
>  	}
>  
> +	if (new_underlying_state->rotation != new_cursor_state->rotation) {
> +		drm_dbg_atomic(crtc->dev, "Cursor plane rotation doesn't match underlying plane\n");
> +		return -EINVAL;
> +	}
> +
>  	/* In theory we could probably support YUV cursors when the underlying
>  	 * plane uses a YUV format, but there's no use-case for it yet. */
>  	if (new_underlying_state->fb->format->is_yuv) {


-- 
Earthling Michel Dänzer            |                  https://redhat.com
Libre software enthusiast          |         Mesa and Xwayland developer

