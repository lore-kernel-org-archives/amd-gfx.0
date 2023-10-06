Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1665CE92FFA
	for <amd-gfx@archiver.kernel.org>; Fri,  6 Oct 2023 09:10:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 80E4C10E1E8;
	Fri,  6 Oct 2023 09:10:00 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3859C10E1E8
 for <amd-gfx@lists.freedesktop.org>; Fri,  6 Oct 2023 09:09:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1696583398;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=cr92X8RrcZBDuxHPt3OLE6tLbx3yBjB901o1qrpUbkA=;
 b=arSuZG4PvR4/zkYYdzPy6RYBwp166PLAmeC+yESQ9Ehv/jfiLM9MOPQYsOrQAR6tN4+IK7
 E4LfVTQs/5GQ6Tb+CYB9vzbM8YARYsDkiyTat6m/dBywQRPTPflO4jjvKkCAIlt8+k2MBG
 F+eDrULxn4rr3chDfGksX0ZiUZkeQ6k=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-145-0VVIA3ckMEq7BNq4_UXocA-1; Fri, 06 Oct 2023 05:09:52 -0400
X-MC-Unique: 0VVIA3ckMEq7BNq4_UXocA-1
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-3f5df65f9f4so12456345e9.2
 for <amd-gfx@lists.freedesktop.org>; Fri, 06 Oct 2023 02:09:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696583391; x=1697188191;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cr92X8RrcZBDuxHPt3OLE6tLbx3yBjB901o1qrpUbkA=;
 b=UOWaWO6EFx3tneDd5srD82idDbWWdxb2KfOg86SDCOCNwP9x/QsNhqOybpm16U2tVn
 NrN2UbDyvSZaMi+nQjOyLyPhQk0KObAY2ib2WC9WdNQMKJdqYoL6yfG0uEdkSYOWu1mx
 tp9lEB8VM94u8/S5QauwpDS5aSvdrxZ1gH0KgBDoPE4aIX28egzUAHUa/Lh7ChVkbFDo
 OL9xFBycILi0Iwt5PD+hh6qDekyJO0ZE7/GC7n9sAMcubatExjfqcDhT4Rbtvdh4QgK+
 UVVEjMSQZ19ZJwFVHoFJTFbI6puyy1QmdythbISR78YdekDbF2U4BW8w+fbzJNWykevU
 2TMw==
X-Gm-Message-State: AOJu0YybN9NDJ6sdoiox72iFejp+1ZC+tYy26E84tpochmtZ7OmGuhZW
 SlZ+PTvb5W+34f8Wp13HDGbVZHB/8FnKDQ+YJqgGnIuNWCfF60gFR/StVkPrFepQsCt2pj2SOJo
 sxzV0C+6EFF3D9VWqJuNpqgK8oA==
X-Received: by 2002:a05:600c:22cf:b0:401:4542:5edd with SMTP id
 15-20020a05600c22cf00b0040145425eddmr7115128wmg.34.1696583391276; 
 Fri, 06 Oct 2023 02:09:51 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHXLY3L3IdQjrjCNjOXebkXEZrmULAEKmDz3vgFG+mYypBOht2L1/CFKwQyIKCOgyjukMYJiQ==
X-Received: by 2002:a05:600c:22cf:b0:401:4542:5edd with SMTP id
 15-20020a05600c22cf00b0040145425eddmr7115092wmg.34.1696583390821; 
 Fri, 06 Oct 2023 02:09:50 -0700 (PDT)
Received: from toolbox ([2001:9e8:89bc:cf00:7c0e:f203:f32:6eaf])
 by smtp.gmail.com with ESMTPSA id
 l25-20020a1c7919000000b00405c7591b09sm3270792wme.35.2023.10.06.02.09.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Oct 2023 02:09:50 -0700 (PDT)
Date: Fri, 6 Oct 2023 11:09:48 +0200
From: Sebastian Wick <sebastian.wick@redhat.com>
To: Melissa Wen <mwen@igalia.com>
Subject: Re: [PATCH v4 09/32] drm/amd/display: add plane 3D LUT
 driver-specific properties
Message-ID: <20231006090948.GA400742@toolbox>
References: <20231005171527.203657-1-mwen@igalia.com>
 <20231005171527.203657-10-mwen@igalia.com>
MIME-Version: 1.0
In-Reply-To: <20231005171527.203657-10-mwen@igalia.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
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
Cc: Pekka Paalanen <pekka.paalanen@collabora.com>, kernel-dev@igalia.com,
 Shashank Sharma <Shashank.Sharma@amd.com>, sunpeng.li@amd.com,
 airlied@gmail.com, Xinhui.Pan@amd.com,
 Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>, Xaver Hugl <xaver.hugl@gmail.com>,
 dri-devel@lists.freedesktop.org,
 Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>,
 Alex Hung <alex.hung@amd.com>, amd-gfx@lists.freedesktop.org, daniel@ffwll.ch,
 Simon Ser <contact@emersion.fr>, Alex Deucher <alexander.deucher@amd.com>,
 Harry Wentland <harry.wentland@amd.com>, christian.koenig@amd.com,
 Joshua Ashton <joshua@froggi.es>, sungjoon.kim@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Thu, Oct 05, 2023 at 04:15:04PM -0100, Melissa Wen wrote:
> Add 3D LUT property for plane color transformations using a 3D lookup
> table. 3D LUT allows for highly accurate and complex color
> transformations and is suitable to adjust the balance between color
> channels. It's also more complex to manage and require more
> computational resources.
> 
> Since a 3D LUT has a limited number of entries in each dimension we want
> to use them in an optimal fashion. This means using the 3D LUT in a
> colorspace that is optimized for human vision, such as sRGB, PQ, or
> another non-linear space. Therefore, userpace may need one 1D LUT
> (shaper) before it to delinearize content and another 1D LUT after 3D
> LUT (blend) to linearize content again for blending. The next patches
> add these 1D LUTs to the plane color mgmt pipeline.
> 
> v3:
> - improve commit message about 3D LUT
> - describe the 3D LUT entries and size (Harry)
> 
> v4:
> - advertise 3D LUT max size as the size of a single-dimension
> 
> Signed-off-by: Melissa Wen <mwen@igalia.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_mode.h      | 18 +++++++++++++++
>  .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h |  9 ++++++++
>  .../amd/display/amdgpu_dm/amdgpu_dm_color.c   | 14 +++++++++++
>  .../amd/display/amdgpu_dm/amdgpu_dm_plane.c   | 23 +++++++++++++++++++
>  4 files changed, 64 insertions(+)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mode.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_mode.h
> index 62044d41da75..f7adaa52c23f 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mode.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mode.h
> @@ -363,6 +363,24 @@ struct amdgpu_mode_info {
>  	 * @plane_hdr_mult_property:
>  	 */
>  	struct drm_property *plane_hdr_mult_property;
> +	/**
> +	 * @plane_lut3d_property: Plane property for color transformation using
> +	 * a 3D LUT (pre-blending), a three-dimensional array where each
> +	 * element is an RGB triplet. Each dimension has a size of the cubed
> +	 * root of lut3d_size. The array contains samples from the approximated

This should be "Each dimension has a size of lut3d_size" now.

> +	 * function. On AMD, values between samples are estimated by
> +	 * tetrahedral interpolation. The array is accessed with three indices,
> +	 * one for each input dimension (color channel), blue being the
> +	 * outermost dimension, red the innermost.
> +	 */
> +	struct drm_property *plane_lut3d_property;
> +	/**
> +	 * @plane_degamma_lut_size_property: Plane property to define the max
> +	 * size of 3D LUT as supported by the driver (read-only). The max size
> +	 * is the max size of one dimension and, therefore, the max number of
> +	 * entries for 3D LUT array is the 3D LUT size cubed;
> +	 */
> +	struct drm_property *plane_lut3d_size_property;
>  };
>  
>  #define AMDGPU_MAX_BL_LEVEL 0xFF
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
> index bb2ce843369d..7a2350c62cf1 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
> @@ -784,6 +784,11 @@ struct dm_plane_state {
>  	 * TF is needed for any subsequent linear-to-non-linear transforms.
>  	 */
>  	__u64 hdr_mult;
> +	/**
> +	 * @lut3d: 3D lookup table blob. The blob (if not NULL) is an array of
> +	 * &struct drm_color_lut.
> +	 */
> +	struct drm_property_blob *lut3d;
>  };
>  
>  struct dm_crtc_state {
> @@ -869,6 +874,10 @@ void amdgpu_dm_update_freesync_caps(struct drm_connector *connector,
>  
>  void amdgpu_dm_trigger_timing_sync(struct drm_device *dev);
>  
> +/* 3D LUT max size is 17x17x17 (4913 entries) */
> +#define MAX_COLOR_3DLUT_SIZE 17
> +#define MAX_COLOR_3DLUT_BITDEPTH 12
> +/* 1D LUT size */
>  #define MAX_COLOR_LUT_ENTRIES 4096
>  /* Legacy gamm LUT users such as X doesn't like large LUT sizes */
>  #define MAX_COLOR_LEGACY_LUT_ENTRIES 256
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_color.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_color.c
> index caf49a044ab4..011f2f9ec890 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_color.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_color.c
> @@ -230,6 +230,20 @@ amdgpu_dm_create_color_properties(struct amdgpu_device *adev)
>  		return -ENOMEM;
>  	adev->mode_info.plane_hdr_mult_property = prop;
>  
> +	prop = drm_property_create(adev_to_drm(adev),
> +				   DRM_MODE_PROP_BLOB,
> +				   "AMD_PLANE_LUT3D", 0);
> +	if (!prop)
> +		return -ENOMEM;
> +	adev->mode_info.plane_lut3d_property = prop;
> +
> +	prop = drm_property_create_range(adev_to_drm(adev),
> +					 DRM_MODE_PROP_IMMUTABLE,
> +					 "AMD_PLANE_LUT3D_SIZE", 0, UINT_MAX);
> +	if (!prop)
> +		return -ENOMEM;
> +	adev->mode_info.plane_lut3d_size_property = prop;
> +
>  	return 0;
>  }
>  #endif
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c
> index ae64d4b73360..068798ffdd56 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c
> @@ -1359,6 +1359,8 @@ dm_drm_plane_duplicate_state(struct drm_plane *plane)
>  
>  	if (dm_plane_state->degamma_lut)
>  		drm_property_blob_get(dm_plane_state->degamma_lut);
> +	if (dm_plane_state->lut3d)
> +		drm_property_blob_get(dm_plane_state->lut3d);
>  
>  	dm_plane_state->degamma_tf = old_dm_plane_state->degamma_tf;
>  	dm_plane_state->hdr_mult = old_dm_plane_state->hdr_mult;
> @@ -1432,6 +1434,8 @@ static void dm_drm_plane_destroy_state(struct drm_plane *plane,
>  
>  	if (dm_plane_state->degamma_lut)
>  		drm_property_blob_put(dm_plane_state->degamma_lut);
> +	if (dm_plane_state->lut3d)
> +		drm_property_blob_put(dm_plane_state->lut3d);
>  
>  	if (dm_plane_state->dc_state)
>  		dc_plane_state_release(dm_plane_state->dc_state);
> @@ -1462,6 +1466,14 @@ dm_atomic_plane_attach_color_mgmt_properties(struct amdgpu_display_manager *dm,
>  	drm_object_attach_property(&plane->base,
>  				   dm->adev->mode_info.plane_hdr_mult_property,
>  				   AMDGPU_HDR_MULT_DEFAULT);
> +
> +	if (dpp_color_caps.hw_3d_lut) {
> +		drm_object_attach_property(&plane->base,
> +					   mode_info.plane_lut3d_property, 0);
> +		drm_object_attach_property(&plane->base,
> +					   mode_info.plane_lut3d_size_property,
> +					   MAX_COLOR_3DLUT_SIZE);
> +	}
>  }
>  
>  static int
> @@ -1493,6 +1505,14 @@ dm_atomic_plane_set_property(struct drm_plane *plane,
>  			dm_plane_state->hdr_mult = val;
>  			dm_plane_state->base.color_mgmt_changed = 1;
>  		}
> +	} else if (property == adev->mode_info.plane_lut3d_property) {
> +		ret = drm_property_replace_blob_from_id(plane->dev,
> +							&dm_plane_state->lut3d,
> +							val, -1,
> +							sizeof(struct drm_color_lut),
> +							&replaced);
> +		dm_plane_state->base.color_mgmt_changed |= replaced;
> +		return ret;
>  	} else {
>  		drm_dbg_atomic(plane->dev,
>  			       "[PLANE:%d:%s] unknown property [PROP:%d:%s]]\n",
> @@ -1520,6 +1540,9 @@ dm_atomic_plane_get_property(struct drm_plane *plane,
>  		*val = dm_plane_state->degamma_tf;
>  	} else if (property == adev->mode_info.plane_hdr_mult_property) {
>  		*val = dm_plane_state->hdr_mult;
> +	} else 	if (property == adev->mode_info.plane_lut3d_property) {
> +		*val = (dm_plane_state->lut3d) ?
> +			dm_plane_state->lut3d->base.id : 0;
>  	} else {
>  		return -EINVAL;
>  	}
> -- 
> 2.40.1
> 

