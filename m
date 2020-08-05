Return-Path: <SRS0=KaZi=BP=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20CCCC433DF
	for <amd-gfx@archiver.kernel.org>; Wed,  5 Aug 2020 07:32:19 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E77462073E
	for <amd-gfx@archiver.kernel.org>; Wed,  5 Aug 2020 07:32:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="Biit01CS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E77462073E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7CA736E523;
	Wed,  5 Aug 2020 07:32:15 +0000 (UTC)
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com
 [IPv6:2a00:1450:4864:20::441])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2C7D26E505
 for <amd-gfx@lists.freedesktop.org>; Wed,  5 Aug 2020 07:32:14 +0000 (UTC)
Received: by mail-wr1-x441.google.com with SMTP id r4so36690804wrx.9
 for <amd-gfx@lists.freedesktop.org>; Wed, 05 Aug 2020 00:32:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ffwll.ch; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=xwMic073FMWmuttdd7at6Kwp82JS83n+8OnqVKa3oZk=;
 b=Biit01CSZVwiHpjnhfeyyc95s1ZchseMmz5XbZNa2tiW0p99ojlSl0F4pyOwGWp9S4
 kQkrbNtzSydhokAz69TunhJ2WotEXn8cm27a89yOmcDb2GYb/koHjE5CikW2Y1qJNMEr
 BHBE2slH2tGqTRki+WhcIO4PbKwXGP0fEk6k0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=xwMic073FMWmuttdd7at6Kwp82JS83n+8OnqVKa3oZk=;
 b=Qjfd+kHJSvEMgBJSbBAelurE2LEatd39+h95WtzMoxs3KV6xDxwHFAMFADKwySqkUA
 3CYHNyNxS2q+94NYW670rQv7shY5JoDFsakN2WN15AvXdrN8pZg09m1Fxw1TFbp5ttNY
 9ecwIgO2Np4FeDfYqe2D9cX2etOOhI7MUCOOwqkFsY+f8M5+xc16Ya+rj+P9ZUqxWuMC
 02W/M5TB5hgdGUzjLU/kDeMwKdIiCvLtsJMrufeaDUhXsMfUUszp8PWpmLKz7+F6kcw0
 p5gqEJGCrxLM+3acoh0SzVEDGFz7wuJByqWDyazgLVi+9OT2xIst5kWM5Y3V6KsFXv0l
 cMpg==
X-Gm-Message-State: AOAM5326ZQz4jRd2TbxdtcHGZ9UEyRi9h+gBjybRoMvf9tv3SmDvqzlx
 XQ0eHH05VFpwblTqxwQueHQrlw==
X-Google-Smtp-Source: ABdhPJyTx0SMyrEEYJ9vjvdxX1FEmubepewCgPnwPKhxhYhcBJ36DmX6OlZUT8PfShomY1KC2uyxEQ==
X-Received: by 2002:adf:e845:: with SMTP id d5mr1558964wrn.228.1596612732759; 
 Wed, 05 Aug 2020 00:32:12 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
 by smtp.gmail.com with ESMTPSA id d14sm1519773wre.44.2020.08.05.00.32.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 05 Aug 2020 00:32:12 -0700 (PDT)
Date: Wed, 5 Aug 2020 09:32:10 +0200
From: daniel@ffwll.ch
To: 
Subject: Re: [PATCH 6/8] drm/amd/display: Set DC options from modifiers.
Message-ID: <20200805073210.GU6419@phenom.ffwll.local>
References: <20200804213119.25091-1-bas@basnieuwenhuizen.nl>
 <20200804213119.25091-7-bas@basnieuwenhuizen.nl>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200804213119.25091-7-bas@basnieuwenhuizen.nl>
X-Operating-System: Linux phenom 5.7.0-1-amd64 
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
Cc: amd-gfx@lists.freedesktop.org, maraeo@gmail.com, daniel@fooishbar.org,
 dri-devel@lists.freedesktop.org, daniel@ffwll.ch, harry.wentland@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Tue, Aug 04, 2020 at 11:31:17PM +0200, Bas Nieuwenhuizen wrote:
> This sets the DC tiling options from the modifier, if modifiers
> are used for the FB. This patch by itself does not expose the
> support yet though.
> 
> There is not much validation yet to limit the scope of this
> patch, but the current validation is at the same level as
> the BO metadata path.
> 
> Signed-off-by: Bas Nieuwenhuizen <bas@basnieuwenhuizen.nl>
> ---
>  .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 109 +++++++++++++++++-
>  1 file changed, 103 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> index 6ef7f2f8acab..ac913b8f10ef 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> @@ -3754,6 +3754,93 @@ fill_gfx9_plane_attributes_from_flags(struct amdgpu_device *adev,
>  	return 0;
>  }
>  
> +static bool
> +modifier_has_dcc(uint64_t modifier)
> +{
> +	return IS_AMD_FMT_MOD(modifier) && AMD_FMT_MOD_GET(DCC, modifier);
> +}
> +
> +static unsigned
> +modifier_gfx9_swizzle_mode(uint64_t modifier)
> +{
> +	if (modifier == DRM_FORMAT_MOD_LINEAR)
> +		return 0;
> +
> +	return AMD_FMT_MOD_GET(TILE, modifier);
> +}
> +
> +static void
> +fill_gfx9_tiling_info_from_modifier(const struct amdgpu_device *adev,
> +				  union dc_tiling_info *tiling_info,
> +				  uint64_t modifier)
> +{
> +	unsigned int mod_bank_xor_bits = AMD_FMT_MOD_GET(BANK_XOR_BITS, modifier);
> +	unsigned int mod_pipe_xor_bits = AMD_FMT_MOD_GET(PIPE_XOR_BITS, modifier);
> +	unsigned int pkrs_log2 = AMD_FMT_MOD_GET(PACKERS, modifier);
> +	unsigned int pipes_log2 = min(4u, mod_pipe_xor_bits);
> +
> +	fill_gfx9_tiling_info_from_device(adev, tiling_info);
> +
> +	if (!IS_AMD_FMT_MOD(modifier))
> +		return;
> +
> +	tiling_info->gfx9.num_pipes = 1u << pipes_log2;
> +	tiling_info->gfx9.num_shader_engines = 1u << (mod_pipe_xor_bits - pipes_log2);
> +
> +	if (adev->family >= AMDGPU_FAMILY_NV) {
> +		tiling_info->gfx9.num_pkrs = 1u << pkrs_log2;
> +	} else {
> +		tiling_info->gfx9.num_banks = 1u << mod_bank_xor_bits;
> +
> +		/* for DCC we know it isn't rb aligned, so rb_per_se doesn't matter. */
> +	}
> +}
> +
> +static void
> +block_alignment(unsigned int blocksize_log2, unsigned int *width, unsigned int *height)
> +{
> +	unsigned int height_log2 = blocksize_log2 / 2;
> +	unsigned int width_log2 = blocksize_log2 - height_log2;
> +
> +	*width = 1u << width_log2;
> +	*height = 1u << height_log2;
> +}
> +
> +static int
> +fill_gfx9_plane_attributes_from_modifiers(struct amdgpu_device *adev,
> +				      const struct amdgpu_framebuffer *afb,
> +				      const enum surface_pixel_format format,
> +				      const enum dc_rotation_angle rotation,
> +				      const struct plane_size *plane_size,
> +				      union dc_tiling_info *tiling_info,
> +				      struct dc_plane_dcc_param *dcc,
> +				      struct dc_plane_address *address,
> +				      const bool force_disable_dcc)
> +{
> +	const uint64_t modifier = afb->base.modifier;
> +	int ret;
> +
> +	fill_gfx9_tiling_info_from_modifier(adev, tiling_info, modifier);
> +	tiling_info->gfx9.swizzle = modifier_gfx9_swizzle_mode(modifier);
> +
> +	if (modifier_has_dcc(modifier) && !force_disable_dcc) {
> +		uint64_t dcc_address = afb->address + afb->base.offsets[1];
> +
> +		dcc->enable = 1;
> +		dcc->meta_pitch = afb->base.pitches[1];
> +		dcc->independent_64b_blks = AMD_FMT_MOD_GET(DCC_INDEPENDENT_64B, modifier);
> +
> +		address->grph.meta_addr.low_part = lower_32_bits(dcc_address);
> +		address->grph.meta_addr.high_part = upper_32_bits(dcc_address);
> +	}
> +
> +	ret = validate_dcc(adev, format, rotation, tiling_info, dcc, address, plane_size);
> +	if (ret)
> +		return ret;
> +
> +	return 0;
> +}
> +
>  static int
>  fill_plane_buffer_attributes(struct amdgpu_device *adev,
>  			     const struct amdgpu_framebuffer *afb,
> @@ -3823,12 +3910,22 @@ fill_plane_buffer_attributes(struct amdgpu_device *adev,
>  
>  
>  	if (adev->family >= AMDGPU_FAMILY_AI) {
> -		ret = fill_gfx9_plane_attributes_from_flags(adev, afb, format, rotation,
> -							    plane_size, tiling_info, dcc,
> -							    address, tiling_flags,
> -							    force_disable_dcc);
> -		if (ret)
> -			return ret;
> +		if (afb->base.flags & DRM_MODE_FB_MODIFIERS) {
> +			ret = fill_gfx9_plane_attributes_from_modifiers(adev, afb, format,
> +								      rotation, plane_size,
> +								      tiling_info, dcc,
> +								      address,
> +								      force_disable_dcc);
> +			if (ret)
> +				return ret;
> +		} else {
> +			ret = fill_gfx9_plane_attributes_from_flags(adev, afb, format, rotation,
> +								  plane_size, tiling_info, dcc,
> +								  address, tiling_flags,
> +								  force_disable_dcc);
> +			if (ret)
> +				return ret;

So what we've done in i915, but might be too cumbersome with the amdgpu
modifiers, is to map legacy tiling information into modifiers once, at the
beginning of addfb. So in amdgpu_display_user_framebuffer_create(). And
once modifiers are filled in, you ofc set the DRM_MODE_FB_MODIFIERS flag
too in the fb.

Then all the display code only works with modifiers, instead of having a
mix and possible confusion, with breakage when people only test the legacy
path. Which I kinda expect to happen, since amd probably runs with their
own ddx in their CI rig only.

This also avoids a bunch of layering and locking unprettiness, since
display code doesn't need to dig around in gem_bo side of things. On that,
there's another amdgpu_bo_get_tiling_flags in amdgpu_dm_commit_planes
which probably shouldn't be there, and should use computed stuff from
plane state or fb (I changed it to a lockless version to just hack around
locking issues, but still there).

This hopefully/eventually should allow us to entirely phase out the legacy
magic tiling blob attached to bo (we've pulled the trigger on that for
intel now, would have needed to extend the uapi to keep it working was a
good excuse).

Cheers, Daniel

> +		}
>  	} else {
>  		fill_gfx8_tiling_info_from_flags(tiling_info, tiling_flags);
>  	}
> -- 
> 2.28.0
> 

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
