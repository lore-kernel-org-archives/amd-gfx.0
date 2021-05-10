Return-Path: <SRS0=4HPi=KF=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A814CC43460
	for <amd-gfx@archiver.kernel.org>; Mon, 10 May 2021 21:47:18 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6DBF261584
	for <amd-gfx@archiver.kernel.org>; Mon, 10 May 2021 21:47:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6DBF261584
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 26A4C6E925;
	Mon, 10 May 2021 21:47:14 +0000 (UTC)
Received: from mail-oi1-x22e.google.com (mail-oi1-x22e.google.com
 [IPv6:2607:f8b0:4864:20::22e])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F16EC6E923;
 Mon, 10 May 2021 21:47:12 +0000 (UTC)
Received: by mail-oi1-x22e.google.com with SMTP id v22so12283027oic.2;
 Mon, 10 May 2021 14:47:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=7Die/telGbdWIP9JgRVkVpz75GT4VbLHvj3keyFcZUw=;
 b=U3VdYNLcYlH95Z/rZdOlq8FiWToQ9zA/vD8iisN3jthb/7WTfB3j6HtEK2K8bkaI6v
 hYtKzP00soOJr+czmV/KfALPhwDTojJzrk540WqCJ08vysRUrAxipsemmipPFt668OLC
 xvQhvBQyysIBor8o8cC+CpKlgx9vdnxM/u0YxtF2RiDgAg50F8tG+36GgK0m1Vta5YHn
 94/9Ou4hkVerG8yU7Hw5QddWxNF5D7KI50seTkq7oL0BwNhWXohaLrH+cQj9P+gOTONN
 MmH9/Lhu7vFaEC3oo4ZSqZzbrOEwYX2a0irZz68DnOv4ucauuJbubSqXCR9FFwVMWNDi
 xMAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=7Die/telGbdWIP9JgRVkVpz75GT4VbLHvj3keyFcZUw=;
 b=a+TYR6licGJuhiD1CgjIAInVhOqwJbuJ2DKJlBRzq8nUlvS/AtbgfWNIQFSdHtbQtB
 fd/huHJ2szqludRroSVJCQ8DiwK0qyt07V7XCZDIN2GKUnwT8Hfhrh2S4QNhAk7bfL+p
 Nvhmvsnk+LIl8uq8TBYyAHpx7vzrs9nEBBy8dLKUh9PTCiuUMLWgUsQKqPzvo7J4kKKT
 pGtsCtK0I0nwzrId1tqrFlI0ratnRpzcuMYis1XjdgC3pj4vcaRnhWY7mrw7lop/6ALB
 pkfcfbDjiGvgznHAMJ96V6S5kxGuOaX4WQRKbTO5Nkn2AmAz9ujM6fPysTaxj7O6R4UA
 DZkw==
X-Gm-Message-State: AOAM532Kd7++G6FPFLRY/Af2sphp5USFCQE6O4A4cLQqI6iIVp9PSUKg
 aAJRTD/tfB8Q4hzAdkE5cuJRFfVJAzF4y4kUdNA=
X-Google-Smtp-Source: ABdhPJzwzhVEg2RVOHSLhEeBlyzl1b7Ggx8YB8Xr3Uy2sGFDmRFfuEGHONwbdG+hfSZHkfFblcVgjtG/0STxBhuQKLc=
X-Received: by 2002:a05:6808:68a:: with SMTP id
 k10mr19379396oig.120.1620683232281; 
 Mon, 10 May 2021 14:47:12 -0700 (PDT)
MIME-Version: 1.0
References: <20210507192718.35314-1-wse@tuxedocomputers.com>
In-Reply-To: <20210507192718.35314-1-wse@tuxedocomputers.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 10 May 2021 17:47:01 -0400
Message-ID: <CADnq5_O7uuSj-nmKXRvGVTb9n1e+Bb-SU3Psi7BVhN4AOYhHsQ@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/display: Expose active display color
 configurations to userspace
To: Werner Sembach <wse@tuxedocomputers.com>
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
Cc: Dave Airlie <airlied@linux.ie>, LKML <linux-kernel@vger.kernel.org>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>,
 "Leo \(Sunpeng\) Li" <sunpeng.li@amd.com>,
 Maling list - DRI developers <dri-devel@lists.freedesktop.org>,
 Daniel Vetter <daniel@ffwll.ch>, "Deucher,
 Alexander" <alexander.deucher@amd.com>, "Wentland,
 Harry" <harry.wentland@amd.com>, Christian Koenig <christian.koenig@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Fri, May 7, 2021 at 3:27 PM Werner Sembach <wse@tuxedocomputers.com> wrote:
>
> xrandr --prop and other userspace info tools have currently no way of
> telling which color configuration is used on HDMI and DP ports.
>
> The ongoing transsition from HDMI 1.4 to 2.0 and the different bandwidth
> requirements of YCbCr 4:2:0 and RGB color format raise different
> incompatibilities. Having these configuration information readily
> available is a useful tool in debuging washed out colors, color artefacts
> on small fonts and missing refreshrate options.

I think we would ideally want these as generic connector properties
rather than AMD specific ones since they are not really AMD specific.
I believe there is already a generic drm property (max_bpc) for the
color depth.  At this point, I think having a generic RGB vs YCbCr
property would make sense.  I'm not sure about the color space.

Alex

>
> Signed-off-by: Werner Sembach <wse@tuxedocomputers.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_display.c   | 58 +++++++++++++++++++
>  drivers/gpu/drm/amd/amdgpu/amdgpu_mode.h      |  4 ++
>  .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 36 ++++++++++++
>  3 files changed, 98 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c
> index f753e04fee99..c0404bcda31b 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c
> @@ -986,6 +986,40 @@ static const struct drm_prop_enum_list amdgpu_dither_enum_list[] =
>         { AMDGPU_FMT_DITHER_ENABLE, "on" },
>  };
>
> +static const struct drm_prop_enum_list amdgpu_active_pixel_encoding_enum_list[] = {
> +       { PIXEL_ENCODING_UNDEFINED, "undefined" },
> +       { PIXEL_ENCODING_RGB, "RGB" },
> +       { PIXEL_ENCODING_YCBCR422, "YCbCr 4:2:2" },
> +       { PIXEL_ENCODING_YCBCR444, "YCbCr 4:4:4" },
> +       { PIXEL_ENCODING_YCBCR420, "YCbCr 4:2:0" },
> +};
> +
> +static const struct drm_prop_enum_list amdgpu_active_display_color_depth_enum_list[] = {
> +       { COLOR_DEPTH_UNDEFINED, "undefined" },
> +       { COLOR_DEPTH_666, "6 bit" },
> +       { COLOR_DEPTH_888, "8 bit" },
> +       { COLOR_DEPTH_101010, "10 bit" },
> +       { COLOR_DEPTH_121212, "12 bit" },
> +       { COLOR_DEPTH_141414, "14 bit" },
> +       { COLOR_DEPTH_161616, "16 bit" },
> +       { COLOR_DEPTH_999, "9 bit" },
> +       { COLOR_DEPTH_111111, "11 bit" },
> +};
> +
> +static const struct drm_prop_enum_list amdgpu_active_output_color_space_enum_list[] = {
> +       { COLOR_SPACE_UNKNOWN, "unknown" },
> +       { COLOR_SPACE_SRGB, "sRGB" },
> +       { COLOR_SPACE_SRGB_LIMITED, "sRGB limited" },
> +       { COLOR_SPACE_YCBCR601, "YCbCr 601" },
> +       { COLOR_SPACE_YCBCR709, "YCbCr 709" },
> +       { COLOR_SPACE_YCBCR601_LIMITED, "YCbCr 601 limited" },
> +       { COLOR_SPACE_YCBCR709_LIMITED, "YCbCr 709 limited" },
> +       { COLOR_SPACE_2020_RGB_FULLRANGE, "RGB 2020" },
> +       { COLOR_SPACE_2020_RGB_LIMITEDRANGE, "RGB 2020 limited" },
> +       { COLOR_SPACE_2020_YCBCR, "YCbCr 2020" },
> +       { COLOR_SPACE_ADOBERGB, "Adobe RGB" },
> +};
> +
>  int amdgpu_display_modeset_create_props(struct amdgpu_device *adev)
>  {
>         int sz;
> @@ -1038,6 +1072,30 @@ int amdgpu_display_modeset_create_props(struct amdgpu_device *adev)
>                                                   "abm level", 0, 4);
>                 if (!adev->mode_info.abm_level_property)
>                         return -ENOMEM;
> +
> +               sz = ARRAY_SIZE(amdgpu_active_pixel_encoding_enum_list);
> +               adev->mode_info.active_pixel_encoding_property =
> +                       drm_property_create_enum(adev_to_drm(adev), 0,
> +                               "active pixel encoding",
> +                               amdgpu_active_pixel_encoding_enum_list, sz);
> +               if (!adev->mode_info.active_pixel_encoding_property)
> +                       return -ENOMEM;
> +
> +               sz = ARRAY_SIZE(amdgpu_active_display_color_depth_enum_list);
> +               adev->mode_info.active_display_color_depth_property =
> +                       drm_property_create_enum(adev_to_drm(adev), 0,
> +                               "active display color depth",
> +                               amdgpu_active_display_color_depth_enum_list, sz);
> +               if (!adev->mode_info.active_display_color_depth_property)
> +                       return -ENOMEM;
> +
> +               sz = ARRAY_SIZE(amdgpu_active_output_color_space_enum_list);
> +               adev->mode_info.active_output_color_space_property =
> +                       drm_property_create_enum(adev_to_drm(adev), 0,
> +                               "active output color space",
> +                               amdgpu_active_output_color_space_enum_list, sz);
> +               if (!adev->mode_info.active_output_color_space_property)
> +                       return -ENOMEM;
>         }
>
>         return 0;
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mode.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_mode.h
> index 319cb19e1b99..ad43af6a878d 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mode.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mode.h
> @@ -337,6 +337,10 @@ struct amdgpu_mode_info {
>         struct drm_property *dither_property;
>         /* Adaptive Backlight Modulation (power feature) */
>         struct drm_property *abm_level_property;
> +       /* Color settings */
> +       struct drm_property *active_pixel_encoding_property;
> +       struct drm_property *active_display_color_depth_property;
> +       struct drm_property *active_output_color_space_property;
>         /* hardcoded DFP edid from BIOS */
>         struct edid *bios_hardcoded_edid;
>         int bios_hardcoded_edid_size;
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> index d699a5cf6c11..89465f74ca59 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> @@ -5592,8 +5592,13 @@ int amdgpu_dm_connector_atomic_get_property(struct drm_connector *connector,
>         struct amdgpu_device *adev = drm_to_adev(dev);
>         struct dm_connector_state *dm_state =
>                 to_dm_connector_state(state);
> +       struct dm_crtc_state *dm_crtc_state = NULL;
>         int ret = -EINVAL;
>
> +       if (state->crtc != NULL && state->crtc->state != NULL) {
> +               dm_crtc_state = to_dm_crtc_state(state->crtc->state);
> +       }
> +
>         if (property == dev->mode_config.scaling_mode_property) {
>                 switch (dm_state->scaling) {
>                 case RMX_CENTER:
> @@ -5623,6 +5628,21 @@ int amdgpu_dm_connector_atomic_get_property(struct drm_connector *connector,
>         } else if (property == adev->mode_info.abm_level_property) {
>                 *val = dm_state->abm_level;
>                 ret = 0;
> +       } else if (property == adev->mode_info.active_pixel_encoding_property) {
> +               *val = PIXEL_ENCODING_UNDEFINED;
> +               if (dm_crtc_state != NULL && dm_crtc_state->stream != NULL)
> +                       *val = dm_crtc_state->stream->timing.pixel_encoding;
> +               ret = 0;
> +       } else if (property == adev->mode_info.active_display_color_depth_property) {
> +               *val = COLOR_DEPTH_UNDEFINED;
> +               if (dm_crtc_state != NULL && dm_crtc_state->stream != NULL)
> +                       *val = dm_crtc_state->stream->timing.display_color_depth;
> +               ret = 0;
> +       } else if (property == adev->mode_info.active_output_color_space_property) {
> +               *val = COLOR_SPACE_UNKNOWN;
> +               if (dm_crtc_state != NULL && dm_crtc_state->stream != NULL)
> +                       *val = dm_crtc_state->stream->output_color_space;
> +               ret = 0;
>         }
>
>         return ret;
> @@ -7083,6 +7103,22 @@ void amdgpu_dm_connector_init_helper(struct amdgpu_display_manager *dm,
>                         drm_connector_attach_content_protection_property(&aconnector->base, true);
>  #endif
>         }
> +
> +       if (adev->mode_info.active_pixel_encoding_property) {
> +               drm_object_attach_property(&aconnector->base.base,
> +                       adev->mode_info.active_pixel_encoding_property, 0);
> +               DRM_DEBUG_DRIVER("amdgpu: attached active pixel encoding drm property");
> +       }
> +       if (adev->mode_info.active_display_color_depth_property) {
> +               drm_object_attach_property(&aconnector->base.base,
> +                       adev->mode_info.active_display_color_depth_property, 0);
> +               DRM_DEBUG_DRIVER("amdgpu: attached active color depth drm property");
> +       }
> +       if (adev->mode_info.active_output_color_space_property) {
> +               drm_object_attach_property(&aconnector->base.base,
> +                       adev->mode_info.active_output_color_space_property, 0);
> +               DRM_DEBUG_DRIVER("amdgpu: attached active output color space drm property");
> +       }
>  }
>
>  static int amdgpu_dm_i2c_xfer(struct i2c_adapter *i2c_adap,
> --
> 2.25.1
>
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
