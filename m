Return-Path: <SRS0=8BU1=C7=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1BB8C4727D
	for <amd-gfx@archiver.kernel.org>; Tue, 22 Sep 2020 20:33:24 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 19CC1235FD
	for <amd-gfx@archiver.kernel.org>; Tue, 22 Sep 2020 20:33:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="vBI8MmIT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 19CC1235FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3BC4789452;
	Tue, 22 Sep 2020 20:33:23 +0000 (UTC)
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com
 [IPv6:2a00:1450:4864:20::442])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5AD6089452
 for <amd-gfx@lists.freedesktop.org>; Tue, 22 Sep 2020 20:33:21 +0000 (UTC)
Received: by mail-wr1-x442.google.com with SMTP id c18so18527043wrm.9
 for <amd-gfx@lists.freedesktop.org>; Tue, 22 Sep 2020 13:33:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=iHm9HAdm0cWAiWB82b32K4GmAs9ZI7jO13gNkFpxvZc=;
 b=vBI8MmITSh+yp/banJfqS+4781ogerrUhETpBO76EZajlGp4vxL+SnixmSbI3RQ1gU
 W7RT9UGv6FCBAGSpBFI0FwqI5DklMJ7JYSf4kBNPcA8tHQ0PrgKodZwZVjn8Ez3GYxPn
 tte2d8z4j9y7hc2TYGIC2Ttpu7L2USlptiXhvmDcV3R7nUSPpJAqH9NCTMbQwc/TI/bu
 BhCZ1BXlrmbS5KdtR1YrQ5qPFGJIpfI2yu0IOazewFNv8gwsmeuQ0w53vmZGn50WMqDx
 z2RzP0esVLy3a5CWtWNlQXrA4Qp7rPP+47HeeXA98cNWaDue75YFreKr8HYhCGJTG+uk
 O6Zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=iHm9HAdm0cWAiWB82b32K4GmAs9ZI7jO13gNkFpxvZc=;
 b=M0T2A2Az/8RFIwIR+Ctog9bBn8Mpfr3Y5FPQafe7zUYkh2KB5DIS20fZDjMYYPHDjO
 9lQdUjKf9Vf/2Ozrwp+AqUpdP9nXlzfFJDt/1h4yqqH9jOHzlDGRf426bKvc6c9cEncF
 5qrrsZzOTfCwKSTLNO5sSHEugL+bHBfwkG7U5daUhNoRzT5BRDGeRMN23NIRBi35VNGt
 eTzuev2dcsTVqJqocd24MVL4jl6zge68P2tDhvT2zijJjxvj580vugojc3lu8+1Ik/ig
 TTa8J9NqCsxzgOSEfoRbyknclErTNInBOJKCWA/Hv1EsVLUSqHwG2eWPY15F0DpyeaLl
 rA8A==
X-Gm-Message-State: AOAM5317jJW/ULU2NF1d1SjwjC8+xfDsxUBv/KgrGTNaKVGvtA1zIYJY
 0dnnVTvPDlF0vAtXhQsbIXSolXTkOnuxbdw9nt1Ei/o9
X-Google-Smtp-Source: ABdhPJw70Q6FlhyyO45Rab9WyDcglodWXMoyJdYDo6C7BYEgZPb/8cSENAztUJZ+JLXE0aiSj9NxjWJCEdvY6Laj9R8=
X-Received: by 2002:adf:f290:: with SMTP id k16mr7738086wro.124.1600806799752; 
 Tue, 22 Sep 2020 13:33:19 -0700 (PDT)
MIME-Version: 1.0
References: <7cc7d590-f713-2060-6bac-37bed0df618a@ettle.org.uk>
In-Reply-To: <7cc7d590-f713-2060-6bac-37bed0df618a@ettle.org.uk>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 22 Sep 2020 16:33:08 -0400
Message-ID: <CADnq5_OEzoEP93+MsGN1tspy0OrxVTkujKUhs+6LryVApvERkw@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu/dc: Pixel encoding DRM property and module
 parameter
To: James Ettle <james@ettle.org.uk>
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
Cc: "Siqueira, Rodrigo" <Rodrigo.Siqueira@amd.com>,
 Harry Wentland <hwentlan@amd.com>, "Kazlauskas,
 Nicholas" <nicholas.kazlauskas@amd.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Tue, Sep 22, 2020 at 3:34 PM James Ettle <james@ettle.org.uk> wrote:
>
> Exposes the pixel encoding as the DRM property "pixel encoding"
> and the module parameter pixel_encoding.
>
> The DRM property may take values "auto" (current behaviour
> when a display is plugged in), "rgb" for RGB, or "ycbcr444" for
> YCbCr 4:4:4.
>
> The module parameter may only be set on boot and is of the format
> [connector-name:]encoding[,...] where encoding is one of the
> same values as are valid for the DRM property.
>
> https://gitlab.freedesktop.org/drm/amd/-/issues/476
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_display.c   |  33 +++
>  drivers/gpu/drm/amd/amdgpu/amdgpu_display.h   |   4 +
>  drivers/gpu/drm/amd/amdgpu/amdgpu_mode.h      |   8 +
>  .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 247 ++++++++++++++++--
>  .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h |   1 +
>  drivers/gpu/drm/amd/display/dc/core/dc.c      |  12 +-
>  drivers/gpu/drm/amd/display/dc/dc_stream.h    |   2 +
>  7 files changed, 289 insertions(+), 18 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c
> index d76172965199..37748f35c52b 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c
> @@ -614,6 +614,31 @@ static const struct drm_prop_enum_list amdgpu_dither_enum_list[] =
>         { AMDGPU_FMT_DITHER_ENABLE, "on" },
>  };
>
> +static const struct drm_prop_enum_list amdgpu_user_pixenc_list[] =
> +{      { AMDGPU_USER_PIXENC_AUTO, "auto" },
> +       { AMDGPU_USER_PIXENC_RGB, "rgb" },
> +       { AMDGPU_USER_PIXENC_YCBCR444, "ycbcr444" },
> +};
> +
> +bool amdgpu_user_pixenc_from_name(
> +       enum amdgpu_user_pixenc *user_pixenc,
> +       const char *pixenc_name)
> +{
> +       /* user_pixenc only modified if name found */
> +       bool found = false;
> +       if (pixenc_name && (*pixenc_name != '\0')) {
> +               const int sz = ARRAY_SIZE(amdgpu_user_pixenc_list);
> +               int i;
> +               for (i = 0; !found && i < sz; ++i) {
> +                       if (strcmp(pixenc_name, amdgpu_user_pixenc_list[i].name) == 0) {
> +                               *user_pixenc = amdgpu_user_pixenc_list[i].type;
> +                               found = true;
> +                       }
> +               }
> +       }
> +       return found;
> +}
> +
>  int amdgpu_display_modeset_create_props(struct amdgpu_device *adev)
>  {
>         int sz;
> @@ -666,6 +691,14 @@ int amdgpu_display_modeset_create_props(struct amdgpu_device *adev)
>                                                 "abm level", 0, 4);
>                 if (!adev->mode_info.abm_level_property)
>                         return -ENOMEM;
> +
> +               sz = ARRAY_SIZE(amdgpu_user_pixenc_list);
> +               adev->mode_info.pixel_encoding_property =
> +                       drm_property_create_enum(adev->ddev, 0,
> +                               "pixel encoding",
> +                               amdgpu_user_pixenc_list, sz);
> +               if (!adev->mode_info.pixel_encoding_property)
> +                       return -ENOMEM;
>         }
>
>         return 0;
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_display.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_display.h
> index 3620b24785e1..72f82e3f4e32 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_display.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_display.h
> @@ -45,4 +45,8 @@ amdgpu_display_user_framebuffer_create(struct drm_device *dev,
>                                        struct drm_file *file_priv,
>                                        const struct drm_mode_fb_cmd2 *mode_cmd);
>
> +bool amdgpu_user_pixenc_from_name(
> +       enum amdgpu_user_pixenc *user_pixenc,
> +       const char *pixenc_name);
> +
>  #endif
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mode.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_mode.h
> index 37ba07e2feb5..3c21ecf3d259 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mode.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mode.h
> @@ -123,6 +123,12 @@ enum amdgpu_flip_status {
>         AMDGPU_FLIP_SUBMITTED
>  };
>
> +enum amdgpu_user_pixenc {
> +       AMDGPU_USER_PIXENC_AUTO,
> +       AMDGPU_USER_PIXENC_RGB,
> +       AMDGPU_USER_PIXENC_YCBCR444
> +};
> +
>  #define AMDGPU_MAX_I2C_BUS 16
>
>  /* amdgpu gpio-based i2c
> @@ -333,6 +339,8 @@ struct amdgpu_mode_info {
>         struct drm_property *dither_property;
>         /* Adaptive Backlight Modulation (power feature) */
>         struct drm_property *abm_level_property;
> +       /* User HDMI pixel encoding override */
> +       struct drm_property *pixel_encoding_property;
>         /* hardcoded DFP edid from BIOS */
>         struct edid *bios_hardcoded_edid;
>         int bios_hardcoded_edid_size;
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> index b51c527a3f0d..8901271d1902 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> @@ -158,7 +158,6 @@ static int amdgpu_dm_connector_get_modes(struct drm_connector *connector);
>  static int amdgpu_dm_atomic_commit(struct drm_device *dev,
>                                    struct drm_atomic_state *state,
>                                    bool nonblock);
> -
>  static void amdgpu_dm_atomic_commit_tail(struct drm_atomic_state *state);
>
>  static int amdgpu_dm_atomic_check(struct drm_device *dev,
> @@ -172,6 +171,13 @@ static bool amdgpu_dm_psr_enable(struct dc_stream_state *stream);
>  static bool amdgpu_dm_link_setup_psr(struct dc_stream_state *stream);
>  static bool amdgpu_dm_psr_disable(struct dc_stream_state *stream);
>
> +/**
> + * DOC: pixel_encoding (string)
> + * Specify the initial pixel encoding used by a connector.
> + */
> +static char amdgpu_pixel_encoding[MAX_INPUT];
> +MODULE_PARM_DESC(pixel_encoding, "Override pixel encoding");
> +module_param_string(pixel_encoding, amdgpu_pixel_encoding, sizeof(amdgpu_pixel_encoding), 0444);

You can drop this part.  We don't need a module parameter if we have a
kms property.

Alex


>
>  /*
>   * dm_vblank_get_counter
> @@ -4214,6 +4220,103 @@ static bool adjust_colour_depth_from_display_info(
>         return false;
>  }
>
> +
> +/* convert an amdgpu_user_pixenc to a dc_pixel_encoding */
> +static bool drm_prop_to_dc_pixel_encoding(
> +       enum dc_pixel_encoding *dc_pixenc,
> +       enum amdgpu_user_pixenc user_pixenc)
> +{
> +       bool ret = false;
> +       switch(user_pixenc) {
> +       case AMDGPU_USER_PIXENC_AUTO:
> +               *dc_pixenc = PIXEL_ENCODING_UNDEFINED;
> +               ret = true;
> +               break;
> +       case AMDGPU_USER_PIXENC_RGB:
> +               *dc_pixenc = PIXEL_ENCODING_RGB;
> +               ret = true;
> +               break;
> +       case AMDGPU_USER_PIXENC_YCBCR444:
> +               *dc_pixenc = PIXEL_ENCODING_YCBCR444;
> +               ret = true;
> +               break;
> +       default:
> +               break;
> +       }
> +       return ret;
> +}
> +
> +
> +/* convert an dc_pixel_encoding to a amdgpu_user_pixenc */
> +static enum amdgpu_user_pixenc dc_pixel_encoding_to_drm_prop(
> +       enum dc_pixel_encoding pixel_encoding)
> +{
> +       enum amdgpu_user_pixenc user_pixenc = AMDGPU_USER_PIXENC_AUTO;
> +       switch(pixel_encoding) {
> +       case PIXEL_ENCODING_RGB:
> +               user_pixenc = AMDGPU_USER_PIXENC_RGB;
> +               break;
> +       case PIXEL_ENCODING_YCBCR444:
> +               user_pixenc = AMDGPU_USER_PIXENC_YCBCR444;
> +               break;
> +       default:
> +               break;
> +       }
> +       return user_pixenc;
> +}
> +
> +/*
> + * Tries to read 'pixel_encoding' from the pixel_encoding DRM property on
> + * 'state'. Returns true if a supported, acceptable, non-undefined value is
> + * found; false otherwise. Only modifies 'pixel_encoding' if returning true.
> + */
> +bool get_connector_state_pixel_encoding(
> +       enum dc_pixel_encoding *pixel_encoding,
> +       const struct drm_connector_state *state,
> +       u32 color_formats)
> +{
> +       bool ret = false;
> +       struct dm_connector_state *dm_state;
> +
> +       if (!(dm_state = to_dm_connector_state(state))) {
> +               return false;
> +       }
> +
> +       /* check encoding is supported */
> +       switch (dm_state->pixel_encoding) {
> +       case PIXEL_ENCODING_RGB:
> +               ret = (color_formats & DRM_COLOR_FORMAT_RGB444);
> +               break;
> +       case PIXEL_ENCODING_YCBCR444:
> +               ret = (color_formats & DRM_COLOR_FORMAT_YCRCB444);
> +               break;
> +       default:
> +               break;
> +       }
> +
> +       if(ret)
> +               *pixel_encoding = dm_state->pixel_encoding;
> +
> +       return ret;
> +}
> +
> +/*
> + * Writes 'pixel_encoding' to the pixel_encoding DRM property on 'state', if
> + * the enum value is valid and supported; otherwise writes
> + * PIXEL_ENCODING_UNDEFINED which corresponds to the "auto" property state.
> + */
> +void set_connector_state_pixel_encoding(
> +       const struct drm_connector_state *state,
> +       enum dc_pixel_encoding pixel_encoding)
> +{
> +       struct dm_connector_state *dm_state;
> +
> +       if (!(dm_state = to_dm_connector_state(state)))
> +               return;
> +
> +       dm_state->pixel_encoding = pixel_encoding;
> +}
> +
>  static void fill_stream_properties_from_drm_display_mode(
>         struct dc_stream_state *stream,
>         const struct drm_display_mode *mode_in,
> @@ -4235,18 +4338,20 @@ static void fill_stream_properties_from_drm_display_mode(
>         timing_out->h_border_right = 0;
>         timing_out->v_border_top = 0;
>         timing_out->v_border_bottom = 0;
> -       /* TODO: un-hardcode */
> -       if (drm_mode_is_420_only(info, mode_in)
> -                       && stream->signal == SIGNAL_TYPE_HDMI_TYPE_A)
> -               timing_out->pixel_encoding = PIXEL_ENCODING_YCBCR420;
> -       else if (drm_mode_is_420_also(info, mode_in)
> -                       && aconnector->force_yuv420_output)
> -               timing_out->pixel_encoding = PIXEL_ENCODING_YCBCR420;
> -       else if ((connector->display_info.color_formats & DRM_COLOR_FORMAT_YCRCB444)
> -                       && stream->signal == SIGNAL_TYPE_HDMI_TYPE_A)
> -               timing_out->pixel_encoding = PIXEL_ENCODING_YCBCR444;
> -       else
> -               timing_out->pixel_encoding = PIXEL_ENCODING_RGB;
> +
> +       if (!get_connector_state_pixel_encoding(&timing_out->pixel_encoding,
> +               connector_state, connector->display_info.color_formats)) {
> +               /* auto-select a pixel encoding */
> +               if (drm_mode_is_420_only(info, mode_in) && stream->signal == SIGNAL_TYPE_HDMI_TYPE_A)
> +                       timing_out->pixel_encoding = PIXEL_ENCODING_YCBCR420;
> +               else if (drm_mode_is_420_also(info, mode_in) && aconnector->force_yuv420_output)
> +                       timing_out->pixel_encoding = PIXEL_ENCODING_YCBCR420;
> +               else if ((connector->display_info.color_formats & DRM_COLOR_FORMAT_YCRCB444)
> +                               && stream->signal == SIGNAL_TYPE_HDMI_TYPE_A)
> +                       timing_out->pixel_encoding = PIXEL_ENCODING_YCBCR444;
> +               else
> +                       timing_out->pixel_encoding = PIXEL_ENCODING_RGB;
> +       }
>
>         timing_out->timing_3d_format = TIMING_3D_FORMAT_NONE;
>         timing_out->display_color_depth = convert_color_depth_from_display_info(
> @@ -4294,6 +4399,7 @@ static void fill_stream_properties_from_drm_display_mode(
>
>         stream->out_transfer_func->type = TF_TYPE_PREDEFINED;
>         stream->out_transfer_func->tf = TRANSFER_FUNCTION_SRGB;
> +
>         if (stream->signal == SIGNAL_TYPE_HDMI_TYPE_A) {
>                 if (!adjust_colour_depth_from_display_info(timing_out, info) &&
>                     drm_mode_is_420_also(info, mode_in) &&
> @@ -4302,6 +4408,9 @@ static void fill_stream_properties_from_drm_display_mode(
>                         adjust_colour_depth_from_display_info(timing_out, info);
>                 }
>         }
> +
> +       /* write back final choice of pixel encoding */
> +       set_connector_state_pixel_encoding(connector_state, timing_out->pixel_encoding);
>  }
>
>  static void fill_audio_info(struct audio_info *audio_info,
> @@ -4818,6 +4927,9 @@ int amdgpu_dm_connector_atomic_set_property(struct drm_connector *connector,
>         } else if (property == adev->mode_info.abm_level_property) {
>                 dm_new_state->abm_level = val;
>                 ret = 0;
> +       } else if (property == adev->mode_info.pixel_encoding_property) {
> +               if(drm_prop_to_dc_pixel_encoding(&dm_new_state->pixel_encoding, val))
> +                       ret = 0;
>         }
>
>         return ret;
> @@ -4863,6 +4975,9 @@ int amdgpu_dm_connector_atomic_get_property(struct drm_connector *connector,
>         } else if (property == adev->mode_info.abm_level_property) {
>                 *val = dm_state->abm_level;
>                 ret = 0;
> +       } else if (property == adev->mode_info.pixel_encoding_property) {
> +               *val = dc_pixel_encoding_to_drm_prop(dm_state->pixel_encoding);
> +               ret = 0;
>         }
>
>         return ret;
> @@ -4912,6 +5027,50 @@ static void amdgpu_dm_connector_destroy(struct drm_connector *connector)
>         kfree(connector);
>  }
>
> +
> +/*
> + * Returns the default pixel encoding, depending on the pixel_encoding
> + * module parameter if given.
> + */
> +static enum dc_pixel_encoding pixel_encoding_reset(
> +       const struct drm_connector *connector)
> +{
> +       char *param_str = NULL;
> +       char *param_str_ptr = NULL;
> +       char *param_item = NULL;
> +       char *param_item_sep = NULL;
> +       char *pixenc_mode = NULL;
> +       enum amdgpu_user_pixenc user_pixenc;
> +       enum dc_pixel_encoding pixel_encoding = PIXEL_ENCODING_UNDEFINED;
> +
> +       /* default in absence of module param */
> +       if (*amdgpu_pixel_encoding == '\0')
> +               return PIXEL_ENCODING_UNDEFINED;
> +
> +       /* decode param string */
> +       param_str = kstrdup(amdgpu_pixel_encoding, GFP_KERNEL);
> +       param_str_ptr = param_str;
> +       while ((param_item = strsep(&param_str_ptr, ","))) {
> +               param_item_sep = strchr(param_item, ':');
> +               if (param_item_sep) {
> +                       if (strncmp(connector->name, param_item,
> +                                  param_item_sep - param_item) == 0) {
> +                                  pixenc_mode = param_item_sep + 1;
> +                                  break;
> +                       }
> +               } else
> +                       pixenc_mode = param_item;
> +       }
> +
> +       /* compare mode string and set */
> +       if (amdgpu_user_pixenc_from_name(&user_pixenc, pixenc_mode)) {
> +               drm_prop_to_dc_pixel_encoding(&pixel_encoding, user_pixenc);
> +       }
> +
> +       kfree(param_str);
> +       return pixel_encoding;
> +}
> +
>  void amdgpu_dm_connector_funcs_reset(struct drm_connector *connector)
>  {
>         struct dm_connector_state *state =
> @@ -4934,7 +5093,7 @@ void amdgpu_dm_connector_funcs_reset(struct drm_connector *connector)
>                 state->pbn = 0;
>                 if (connector->connector_type == DRM_MODE_CONNECTOR_eDP)
>                         state->abm_level = amdgpu_dm_abm_level;
> -
> +               state->pixel_encoding = pixel_encoding_reset(connector);
>                 __drm_atomic_helper_connector_reset(connector, &state->base);
>         }
>  }
> @@ -4961,6 +5120,7 @@ amdgpu_dm_connector_atomic_duplicate_state(struct drm_connector *connector)
>         new_state->underscan_vborder = state->underscan_vborder;
>         new_state->vcpi_slots = state->vcpi_slots;
>         new_state->pbn = state->pbn;
> +       new_state->pixel_encoding = state->pixel_encoding;
>         return &new_state->base;
>  }
>
> @@ -6175,6 +6335,7 @@ static int amdgpu_dm_connector_get_modes(struct drm_connector *connector)
>         return amdgpu_dm_connector->num_modes;
>  }
>
> +
>  void amdgpu_dm_connector_init_helper(struct amdgpu_display_manager *dm,
>                                      struct amdgpu_dm_connector *aconnector,
>                                      int connector_type,
> @@ -6263,6 +6424,12 @@ void amdgpu_dm_connector_init_helper(struct amdgpu_display_manager *dm,
>                 if (adev->dm.hdcp_workqueue)
>                         drm_connector_attach_content_protection_property(&aconnector->base, true);
>  #endif
> +
> +               if (adev->mode_info.pixel_encoding_property) {
> +                       drm_object_attach_property(&aconnector->base.base,
> +                               adev->mode_info.pixel_encoding_property, 0);
> +                       DRM_DEBUG_DRIVER("amdgpu: attached pixel encoding drm property");
> +               }
>         }
>  }
>
> @@ -7332,6 +7499,37 @@ static int amdgpu_dm_atomic_commit(struct drm_device *dev,
>         /*TODO Handle EINTR, reenable IRQ*/
>  }
>
> +static void update_stream_for_pixel_encoding(
> +       struct dc_stream_update *stream_update,
> +       struct drm_connector *connector,
> +       struct dm_crtc_state *dm_old_crtc_state,
> +       struct dm_crtc_state *dm_new_crtc_state,
> +       struct dm_connector_state *dm_new_con_state)
> +{
> +       struct amdgpu_dm_connector *aconnector =
> +               to_amdgpu_dm_connector(connector);
> +       struct dc_stream_state *new_stream = NULL;
> +       if (aconnector)
> +               new_stream = create_validate_stream_for_sink(
> +                       aconnector,
> +                       &dm_new_crtc_state->base.mode,
> +                       dm_new_con_state,
> +                       dm_old_crtc_state->stream);
> +       if (new_stream) {
> +               dm_new_crtc_state->stream->timing =
> +                       new_stream->timing;
> +               stream_update->timing_for_pixel_encoding =
> +                       &dm_new_crtc_state->stream->timing;
> +
> +               dm_new_crtc_state->stream->output_color_space =
> +                       new_stream->output_color_space;
> +               stream_update->output_color_space =
> +                       &dm_new_crtc_state->stream->output_color_space;
> +
> +               dc_stream_release(new_stream);
> +       }
> +}
> +
>  /**
>   * amdgpu_dm_atomic_commit_tail() - AMDgpu DM's commit tail implementation.
>   * @state: The atomic state to commit
> @@ -7508,7 +7706,7 @@ static void amdgpu_dm_atomic_commit_tail(struct drm_atomic_state *state)
>                 struct dc_stream_update stream_update;
>                 struct dc_info_packet hdr_packet;
>                 struct dc_stream_status *status = NULL;
> -               bool abm_changed, hdr_changed, scaling_changed;
> +               bool abm_changed, hdr_changed, scaling_changed, pixenc_changed;
>
>                 memset(&dummy_updates, 0, sizeof(dummy_updates));
>                 memset(&stream_update, 0, sizeof(stream_update));
> @@ -7534,7 +7732,10 @@ static void amdgpu_dm_atomic_commit_tail(struct drm_atomic_state *state)
>                 hdr_changed =
>                         is_hdr_metadata_different(old_con_state, new_con_state);
>
> -               if (!scaling_changed && !abm_changed && !hdr_changed)
> +               pixenc_changed = dm_new_con_state->pixel_encoding !=
> +                                dm_old_con_state->pixel_encoding;
> +
> +               if (!scaling_changed && !abm_changed && !hdr_changed && !pixenc_changed)
>                         continue;
>
>                 stream_update.stream = dm_new_crtc_state->stream;
> @@ -7557,6 +7758,13 @@ static void amdgpu_dm_atomic_commit_tail(struct drm_atomic_state *state)
>                         stream_update.hdr_static_metadata = &hdr_packet;
>                 }
>
> +               if (pixenc_changed) {
> +                       update_stream_for_pixel_encoding(&stream_update,
> +                               connector,
> +                               dm_old_crtc_state, dm_new_crtc_state,
> +                               dm_new_con_state);
> +               }
> +
>                 status = dc_stream_get_status(dm_new_crtc_state->stream);
>                 WARN_ON(!status);
>                 WARN_ON(!status->plane_count);
> @@ -7911,7 +8119,6 @@ static int dm_update_crtc_state(struct amdgpu_display_manager *dm,
>                                                              &new_crtc_state->mode,
>                                                              dm_new_conn_state,
>                                                              dm_old_crtc_state->stream);
> -
>                 /*
>                  * we can have no stream on ACTION_SET if a display
>                  * was disconnected during S3, in this case it is not an
> @@ -8578,6 +8785,12 @@ static int amdgpu_dm_atomic_check(struct drm_device *dev,
>                 if (dm_old_con_state->abm_level !=
>                     dm_new_con_state->abm_level)
>                         new_crtc_state->connectors_changed = true;
> +
> +               if (dm_old_con_state->pixel_encoding !=
> +                   dm_new_con_state->pixel_encoding) {
> +                       new_crtc_state->connectors_changed = true;
> +                       new_crtc_state->mode_changed = true;
> +               }
>         }
>
>  #if defined(CONFIG_DRM_AMD_DC_DCN)
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
> index dd1559c743c2..e46bdd279d0f 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
> @@ -450,6 +450,7 @@ struct dm_connector_state {
>         uint8_t abm_level;
>         int vcpi_slots;
>         uint64_t pbn;
> +       enum dc_pixel_encoding pixel_encoding;
>  };
>
>  #define to_dm_connector_state(x)\
> diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd/display/dc/core/dc.c
> index 92eb1ca1634f..24743ee9d9da 100644
> --- a/drivers/gpu/drm/amd/display/dc/core/dc.c
> +++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
> @@ -1881,6 +1881,11 @@ static enum surface_update_type check_update_surfaces_for_stream(
>
>                 if (stream_update->output_csc_transform || stream_update->output_color_space)
>                         su_flags->bits.out_csc = 1;
> +
> +               if (stream_update->timing_for_pixel_encoding) {
> +                       su_flags->bits.pixel_encoding = 1;
> +                       elevate_update_type(&overall_type, UPDATE_TYPE_FULL);
> +               }
>         }
>
>         for (i = 0 ; i < surface_count; i++) {
> @@ -2183,6 +2188,10 @@ static void copy_stream_update_to_stream(struct dc *dc,
>                         update->dsc_config = NULL;
>                 }
>         }
> +
> +       if (update->timing_for_pixel_encoding) {
> +               stream->timing = *update->timing_for_pixel_encoding;
> +       }
>  }
>
>  static void commit_planes_do_stream_update(struct dc *dc,
> @@ -2211,7 +2220,8 @@ static void commit_planes_do_stream_update(struct dc *dc,
>                         if ((stream_update->hdr_static_metadata && !stream->use_dynamic_meta) ||
>                                         stream_update->vrr_infopacket ||
>                                         stream_update->vsc_infopacket ||
> -                                       stream_update->vsp_infopacket) {
> +                                       stream_update->vsp_infopacket ||
> +                                       stream_update->timing_for_pixel_encoding) {
>                                 resource_build_info_frame(pipe_ctx);
>                                 dc->hwss.update_info_frame(pipe_ctx);
>                         }
> diff --git a/drivers/gpu/drm/amd/display/dc/dc_stream.h b/drivers/gpu/drm/amd/display/dc/dc_stream.h
> index d9888f316da6..0e1ef24d8855 100644
> --- a/drivers/gpu/drm/amd/display/dc/dc_stream.h
> +++ b/drivers/gpu/drm/amd/display/dc/dc_stream.h
> @@ -126,6 +126,7 @@ union stream_update_flags {
>                 uint32_t gamut_remap:1;
>                 uint32_t wb_update:1;
>                 uint32_t dsc_changed : 1;
> +               uint32_t pixel_encoding:1;
>         } bits;
>
>         uint32_t raw;
> @@ -262,6 +263,7 @@ struct dc_stream_update {
>
>         struct dc_writeback_update *wb_update;
>         struct dc_dsc_config *dsc_config;
> +       struct dc_crtc_timing *timing_for_pixel_encoding;
>  #if defined(CONFIG_DRM_AMD_DC_DCN3_0)
>         struct dc_transfer_func *func_shaper;
>         struct dc_3dlut *lut3d_func;
> --
> 2.26.2
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
