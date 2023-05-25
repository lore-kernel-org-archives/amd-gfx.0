Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8FDD7C77B7A
	for <amd-gfx@archiver.kernel.org>; Thu, 25 May 2023 14:48:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1523110E16F;
	Thu, 25 May 2023 14:48:13 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by gabe.freedesktop.org (Postfix) with ESMTP id BBF1C10E16F
 for <amd-gfx@lists.freedesktop.org>; Thu, 25 May 2023 14:48:10 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A42371042
 for <amd-gfx@lists.freedesktop.org>; Thu, 25 May 2023 07:48:54 -0700 (PDT)
Received: from e110455-lin.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com
 [10.121.207.14])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 502683F67D
 for <amd-gfx@lists.freedesktop.org>; Thu, 25 May 2023 07:48:09 -0700 (PDT)
Date: Thu, 25 May 2023 15:48:07 +0100
From: Liviu Dudau <liviu.dudau@arm.com>
To: Melissa Wen <mwen@igalia.com>
Subject: Re: [PATCH 02/36] drm/drm_property: make
 replace_property_blob_from_id a DRM helper
Message-ID: <ZG91J-vMgdNcKvNC@e110455-lin.cambridge.arm.com>
References: <20230523221520.3115570-1-mwen@igalia.com>
 <20230523221520.3115570-3-mwen@igalia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230523221520.3115570-3-mwen@igalia.com>
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
Cc: dri-devel@lists.freedesktop.org, airlied@gmail.com,
 Sebastian Wick <sebastian.wick@redhat.com>,
 Shashank Sharma <Shashank.Sharma@amd.com>,
 Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>, amd-gfx@lists.freedesktop.org,
 Alex Hung <alex.hung@amd.com>, Harry Wentland <harry.wentland@amd.com>,
 tzimmermann@suse.de, sunpeng.li@amd.com, maarten.lankhorst@linux.intel.com,
 mripard@kernel.org, daniel@ffwll.ch, sungjoon.kim@amd.com,
 Pekka Paalanen <pekka.paalanen@collabora.com>, Simon Ser <contact@emersion.fr>,
 Xaver Hugl <xaver.hugl@gmail.com>, brian.starkey@arm.com,
 kernel-dev@igalia.com, Alex Deucher <alexander.deucher@amd.com>,
 Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>,
 Joshua Ashton <joshua@froggi.es>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Tue, May 23, 2023 at 09:14:46PM -0100, Melissa Wen wrote:
> Place it in drm_property where drm_property_replace_blob and
> drm_property_lookup_blob live. Then we can use the DRM helper for
> driver-specific KMS properties too.
> 
> Signed-off-by: Melissa Wen <mwen@igalia.com>

I know that I've got Cc-ed because of a comment, but I did have a look at the whole
patch. If it is useful, then you can add

Reviewed-by: Liviu Dudau <liviu.dudau@arm.com>

Best regards,
Liviu

> ---
>  drivers/gpu/drm/arm/malidp_crtc.c |  2 +-
>  drivers/gpu/drm/drm_atomic_uapi.c | 43 ++++-----------------------
>  drivers/gpu/drm/drm_property.c    | 49 +++++++++++++++++++++++++++++++
>  include/drm/drm_property.h        |  6 ++++
>  4 files changed, 61 insertions(+), 39 deletions(-)
> 
> diff --git a/drivers/gpu/drm/arm/malidp_crtc.c b/drivers/gpu/drm/arm/malidp_crtc.c
> index dc01c43f6193..d72c22dcf685 100644
> --- a/drivers/gpu/drm/arm/malidp_crtc.c
> +++ b/drivers/gpu/drm/arm/malidp_crtc.c
> @@ -221,7 +221,7 @@ static int malidp_crtc_atomic_check_ctm(struct drm_crtc *crtc,
>  
>  	/*
>  	 * The size of the ctm is checked in
> -	 * drm_atomic_replace_property_blob_from_id.
> +	 * drm_property_replace_blob_from_id.
>  	 */
>  	ctm = (struct drm_color_ctm *)state->ctm->data;
>  	for (i = 0; i < ARRAY_SIZE(ctm->matrix); ++i) {
> diff --git a/drivers/gpu/drm/drm_atomic_uapi.c b/drivers/gpu/drm/drm_atomic_uapi.c
> index c06d0639d552..b76d50ae244c 100644
> --- a/drivers/gpu/drm/drm_atomic_uapi.c
> +++ b/drivers/gpu/drm/drm_atomic_uapi.c
> @@ -362,39 +362,6 @@ static s32 __user *get_out_fence_for_connector(struct drm_atomic_state *state,
>  	return fence_ptr;
>  }
>  
> -static int
> -drm_atomic_replace_property_blob_from_id(struct drm_device *dev,
> -					 struct drm_property_blob **blob,
> -					 uint64_t blob_id,
> -					 ssize_t expected_size,
> -					 ssize_t expected_elem_size,
> -					 bool *replaced)
> -{
> -	struct drm_property_blob *new_blob = NULL;
> -
> -	if (blob_id != 0) {
> -		new_blob = drm_property_lookup_blob(dev, blob_id);
> -		if (new_blob == NULL)
> -			return -EINVAL;
> -
> -		if (expected_size > 0 &&
> -		    new_blob->length != expected_size) {
> -			drm_property_blob_put(new_blob);
> -			return -EINVAL;
> -		}
> -		if (expected_elem_size > 0 &&
> -		    new_blob->length % expected_elem_size != 0) {
> -			drm_property_blob_put(new_blob);
> -			return -EINVAL;
> -		}
> -	}
> -
> -	*replaced |= drm_property_replace_blob(blob, new_blob);
> -	drm_property_blob_put(new_blob);
> -
> -	return 0;
> -}
> -
>  static int drm_atomic_crtc_set_property(struct drm_crtc *crtc,
>  		struct drm_crtc_state *state, struct drm_property *property,
>  		uint64_t val)
> @@ -415,7 +382,7 @@ static int drm_atomic_crtc_set_property(struct drm_crtc *crtc,
>  	} else if (property == config->prop_vrr_enabled) {
>  		state->vrr_enabled = val;
>  	} else if (property == config->degamma_lut_property) {
> -		ret = drm_atomic_replace_property_blob_from_id(dev,
> +		ret = drm_property_replace_blob_from_id(dev,
>  					&state->degamma_lut,
>  					val,
>  					-1, sizeof(struct drm_color_lut),
> @@ -423,7 +390,7 @@ static int drm_atomic_crtc_set_property(struct drm_crtc *crtc,
>  		state->color_mgmt_changed |= replaced;
>  		return ret;
>  	} else if (property == config->ctm_property) {
> -		ret = drm_atomic_replace_property_blob_from_id(dev,
> +		ret = drm_property_replace_blob_from_id(dev,
>  					&state->ctm,
>  					val,
>  					sizeof(struct drm_color_ctm), -1,
> @@ -431,7 +398,7 @@ static int drm_atomic_crtc_set_property(struct drm_crtc *crtc,
>  		state->color_mgmt_changed |= replaced;
>  		return ret;
>  	} else if (property == config->gamma_lut_property) {
> -		ret = drm_atomic_replace_property_blob_from_id(dev,
> +		ret = drm_property_replace_blob_from_id(dev,
>  					&state->gamma_lut,
>  					val,
>  					-1, sizeof(struct drm_color_lut),
> @@ -563,7 +530,7 @@ static int drm_atomic_plane_set_property(struct drm_plane *plane,
>  	} else if (property == plane->color_range_property) {
>  		state->color_range = val;
>  	} else if (property == config->prop_fb_damage_clips) {
> -		ret = drm_atomic_replace_property_blob_from_id(dev,
> +		ret = drm_property_replace_blob_from_id(dev,
>  					&state->fb_damage_clips,
>  					val,
>  					-1,
> @@ -727,7 +694,7 @@ static int drm_atomic_connector_set_property(struct drm_connector *connector,
>  		if (state->link_status != DRM_LINK_STATUS_GOOD)
>  			state->link_status = val;
>  	} else if (property == config->hdr_output_metadata_property) {
> -		ret = drm_atomic_replace_property_blob_from_id(dev,
> +		ret = drm_property_replace_blob_from_id(dev,
>  				&state->hdr_output_metadata,
>  				val,
>  				sizeof(struct hdr_output_metadata), -1,
> diff --git a/drivers/gpu/drm/drm_property.c b/drivers/gpu/drm/drm_property.c
> index dfec479830e4..f72ef6493340 100644
> --- a/drivers/gpu/drm/drm_property.c
> +++ b/drivers/gpu/drm/drm_property.c
> @@ -751,6 +751,55 @@ bool drm_property_replace_blob(struct drm_property_blob **blob,
>  }
>  EXPORT_SYMBOL(drm_property_replace_blob);
>  
> +/**
> + * drm_property_replace_blob_from_id - replace a blob property taking a reference
> + * @dev: DRM device
> + * @blob: a pointer to the member blob to be replaced
> + * @blob_id: the id of the new blob to replace with
> + * @expected_size: expected size of the blob property
> + * @expected_elem_size: expected size of an element in the blob property
> + * @replaced: if the blob was in fact replaced
> + *
> + * Look up the new blob from id, take its reference, check expected sizes of
> + * the blob and its element and replace the old blob by the new one. Advertise
> + * if the replacement operation was successful.
> + *
> + * Return: true if the blob was in fact replaced. -EINVAL if the new blob was
> + * not found or sizes don't match.
> + */
> +int drm_property_replace_blob_from_id(struct drm_device *dev,
> +					 struct drm_property_blob **blob,
> +					 uint64_t blob_id,
> +					 ssize_t expected_size,
> +					 ssize_t expected_elem_size,
> +					 bool *replaced)
> +{
> +	struct drm_property_blob *new_blob = NULL;
> +
> +	if (blob_id != 0) {
> +		new_blob = drm_property_lookup_blob(dev, blob_id);
> +		if (new_blob == NULL)
> +			return -EINVAL;
> +
> +		if (expected_size > 0 &&
> +		    new_blob->length != expected_size) {
> +			drm_property_blob_put(new_blob);
> +			return -EINVAL;
> +		}
> +		if (expected_elem_size > 0 &&
> +		    new_blob->length % expected_elem_size != 0) {
> +			drm_property_blob_put(new_blob);
> +			return -EINVAL;
> +		}
> +	}
> +
> +	*replaced |= drm_property_replace_blob(blob, new_blob);
> +	drm_property_blob_put(new_blob);
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL(drm_property_replace_blob_from_id);
> +
>  int drm_mode_getblob_ioctl(struct drm_device *dev,
>  			   void *data, struct drm_file *file_priv)
>  {
> diff --git a/include/drm/drm_property.h b/include/drm/drm_property.h
> index 65bc9710a470..082f29156b3e 100644
> --- a/include/drm/drm_property.h
> +++ b/include/drm/drm_property.h
> @@ -279,6 +279,12 @@ struct drm_property_blob *drm_property_create_blob(struct drm_device *dev,
>  						   const void *data);
>  struct drm_property_blob *drm_property_lookup_blob(struct drm_device *dev,
>  						   uint32_t id);
> +int drm_property_replace_blob_from_id(struct drm_device *dev,
> +				      struct drm_property_blob **blob,
> +				      uint64_t blob_id,
> +				      ssize_t expected_size,
> +				      ssize_t expected_elem_size,
> +				      bool *replaced);
>  int drm_property_replace_global_blob(struct drm_device *dev,
>  				     struct drm_property_blob **replace,
>  				     size_t length,
> -- 
> 2.39.2
> 

-- 
====================
| I would like to |
| fix the world,  |
| but they're not |
| giving me the   |
 \ source code!  /
  ---------------
    ¯\_(ツ)_/¯
