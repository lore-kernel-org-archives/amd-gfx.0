Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF31BD2B92E
	for <amd-gfx@archiver.kernel.org>; Tue,  5 Nov 2024 13:55:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 957AB10E5A9;
	Tue,  5 Nov 2024 13:55:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=kde.org header.i=@kde.org header.b="HTa8qmD/";
	dkim-atps=neutral
Received: from letterbox.kde.org (letterbox.kde.org [46.43.1.242])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 133A410E44B
 for <amd-gfx@lists.freedesktop.org>; Mon,  4 Nov 2024 14:49:28 +0000 (UTC)
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com
 [209.85.218.41]) (Authenticated sender: zamundaaa)
 by letterbox.kde.org (Postfix) with ESMTPSA id 1123F337E81
 for <amd-gfx@lists.freedesktop.org>; Mon,  4 Nov 2024 14:49:26 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kde.org; s=users;
 t=1730731766; bh=JPviigrm06xflidVHbOIADarJ666p6XPUyAbkAXOQTU=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
 b=HTa8qmD/YrW7QqRN6/hfNwSSANqlwXmg+WopTdDTNNB1CFFes8gjW4omQOGTlZHK9
 +bAX9F8FTK2WdDVARV/9j7zneSUOtZkiRJiPuaQd7ulg6wcq16d6IwjPhcqWsZyI+C
 2uKyHUtzDAEkExxgS10DKDG+wqiJhgDYJk12cAoj9TeApWbKQ0hVWnF4snxkzhisAy
 pSudFcmoRCj1GKpxn8TmjtT1Wa48b6jNoQD5Xj3Gnl+8e34/xAHsNUW996AX4I+h9Y
 lQuUjErSZR49z3KY6E7I51IDurA5jE3IfbubMQ5tVwQWiGtSKG36Hpi9W8jsecrDTW
 /g5XOaeryRYRQ==
Received: by mail-ej1-f41.google.com with SMTP id
 a640c23a62f3a-a9a850270e2so721927266b.0
 for <amd-gfx@lists.freedesktop.org>; Mon, 04 Nov 2024 06:49:26 -0800 (PST)
X-Gm-Message-State: AOJu0YwLW0/AFovdUSobABuLK79PxzEaFxeq73X9lXUxbZ1K+bgoN/iN
 i5IBmnixVz8bJrEO0vZ112GXToSmGX45438MZwIvSL7TYSf4EiGtt75gQZgLPbUMJQneAP23vPL
 QZgem1rV2GqrM6ipApkm08mWsx2g=
X-Google-Smtp-Source: AGHT+IFFtkWTYfhF73s/eZdY4By5Qo+ZDIG73Sexh9WYNOTYnjBYUK3Ej7AOQDFfbBjoKHHgcY0M9IB9LSQ44utDMBc=
X-Received: by 2002:a17:907:8693:b0:a99:5ad9:b672 with SMTP id
 a640c23a62f3a-a9e6553b27amr1196047266b.10.1730731765411; Mon, 04 Nov 2024
 06:49:25 -0800 (PST)
MIME-Version: 1.0
References: <49676545.2155587.1730128258922.ref@mail.yahoo.com>
 <49676545.2155587.1730128258922@mail.yahoo.com>
 <1193254694.2164272.1730128713802@mail.yahoo.com>
In-Reply-To: <1193254694.2164272.1730128713802@mail.yahoo.com>
From: Xaver Hugl <xaver.hugl@kde.org>
Date: Mon, 4 Nov 2024 15:49:14 +0100
X-Gmail-Original-Message-ID: <CAFZQkGzsS=QVycX_vkOa4SSaZ_+VLa_MCm-gtbnXgXwfq0ruDw@mail.gmail.com>
Message-ID: <CAFZQkGzsS=QVycX_vkOa4SSaZ_+VLa_MCm-gtbnXgXwfq0ruDw@mail.gmail.com>
Subject: Re: Fw: [PATCH] drm/amdgpu add "pixel_encoding"
To: "Matias N. Goldberg" <dark_sylinc@yahoo.com.ar>
Cc: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, 
 "harry.wentland@amd.com" <harry.wentland@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Tue, 05 Nov 2024 13:55:02 +0000
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

Am Mo., 28. Okt. 2024 um 16:18 Uhr schrieb Matias N. Goldberg
<dark_sylinc@yahoo.com.ar>:
>
> SENDING AGAIN because it was sent with HTML formatting, which screwed up =
the email.
>
>
> Hi!
>
> This is my first patch ever to DRM/amdgpu (technically I didn't write the=
 patch, I just kept rebasing it over 4 years, and did lots of testing).
>
> I'm following the advise from:
> https://gitlab.freedesktop.org/drm/amd/-/issues/476#note_2628536
>
> Why this patch? Because it fix a practical problem with certain monitors =
that auto-select ycbcr444 when they should be set to "rgb" (this issue also=
 happens on Windows) when plugging an HDMI monitor to a DisplayPort via pas=
sive adapter.
>
>
> IMPORTANT remarks about the public API:
>
> 1. This API adds "pixel encoding" which has options "auto" (Default), "rg=
b", "ycbcr444", and "ycbcr420"
Is ycbcr420 not possible with amdgpu?

> 2. Intel has "RGB Broadcast". Its options are "Full" and "Limited 16:235"=
. There is a lot of overlap here. On Windows AMD Control Panel offers the o=
ption "Pixel Encoding" and its options are:
>  - RGB (full)
>  - RGB (limited)
>  - ycbcr444
>  - ycbcr420
>  - ycbcr422
>
> Which means that it may be worth reserving more keywords for this patch.
You don't need to reserve anything. Additional enum values can be
added at any time and don't need to have unique names vs. other enums.

> I don't know why ycbcr444/ycbcr420 do not offer full/limited variants on =
Windows, but I suspect it's because the driver can automatically tell wheth=
er to use Full vs Limited for ycbcr variants..
>
> 3. amdgpu already has "Colorspace" option. However this is a different (a=
lthough related) option. But there is quite the overlap:
>
> - Full/Limited options are sometimes included as part of the colorspace, =
such is the case of COLOR_SPACE_2020_RGB_FULLRANGE vs COLOR_SPACE_2020_RGB_=
LIMITEDRANGE, but there is no "LIMITED"/"FULL" variants for COLOR_SPACE_202=
0_YCBCR. Yet there are for YCBCR601 and YCBCR709. This may be a spec thing =
(I don=E2=80=99t know).
>
> - AFAIK amdgpu=E2=80=99s Limited/Full variants are not controllable from =
the public user-space API.
>
> - Certain options in "Colorspace" only makes sense in specific pixel enco=
ding. For example the option "opRGB" currently glitches when amdgpu is usin=
g ycbcr encoding (you can tell the monitor is interpreting the RGB signal a=
s YUV, thus white becomes purple and black becomes green).
opRGB is not supported by any screen I've ever looked at, so it
doesn't surprise me that you'd get glitches.

> - The kernel has DRM_MODE_COLORIMETRY_BT2020_RGB and DRM_MODE_COLORIMETRY=
_BT2020_YCC. AMDGPU kernel currently forces COLOR_SPACE_2020_RGB_FULLRANGE =
or COLOR_SPACE_2020_YCBCR based on the current pixel encoding (e.g. if usin=
g RGB encodings and colorspace =3D=3D DRM_MODE_COLORIMETRY_BT2020_YCC, it w=
ill be changed for COLOR_SPACE_2020_RGB_FULLRANGE with currently no choice =
for Limited range).
> - amdgpu seems to be able to automatically distinguish between Full and L=
imited for ycbcr  formats via the presence of flags.Y_ONLY bit. There is no=
 such auto-detection for RGB.
>
>
> The way I see it, there are 3 configurations that can be arranged togethe=
r:
>
> - Pixel Encoding (RGB vs ycbcr444 vs ycbcr420).
> - Colorspace (YCBCR709 vs BT.2020 etc).
> - Full vs Limited.
>
> However not all options are compatible with everything.
That's not a problem, incompatible options can just be rejected in atomic t=
ests.

> I suspect doing the same as what AMD does on Windows (offer RGB/Full + RG=
B/Limited + all the ycbcr variants for "pixel encoding") is the best choice=
 (and leave the "Colorspace" option as is, for very advanced manipulation).
>
> 4. Xaver Hugl expressed his concerns with the current patch that having a=
n option called "auto" with no way of querying what is the current auto-sel=
ected encoding is sub-optimal.
>
>
> Cheers
> Matias
>
>
>
> From 6806baac51f1ac2028c49bcab216c19f26a7e92b Mon Sep 17 00:00:00 2001
> From: "Matias N. Goldberg" <dark_sylinc@yahoo.com.ar>
> Date: Sun, 6 Oct 2024 21:04:11 -0300
> Subject: [PATCH] [amdgpu] Add "pixel_encoding" to switch between RGB & YU=
V
>  color modes
>
> Usage:
> xrandr --output DisplayPort-1 --set "pixel encoding" rgb
>
> Supported options are: "auto" (Default), "rgb", "ycbcr444", and
> "ycbcr420"
>
> This patch allows users to switch between pixel encodings, which is
> specially important when auto gets it wrong (probably because of
> monitor's manufacturer mistake) and needs user intervention.
>
> Original patch by Yassine Imounachen
> Rebased by Matias N. Goldberg <dark_sylinc@yahoo.com.ar>
>
> Full discussion:
> https://gitlab.freedesktop.org/drm/amd/-/issues/476#note_2628536
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_display.c   |  35 +++
>  drivers/gpu/drm/amd/amdgpu/amdgpu_display.h   |   3 +
>  drivers/gpu/drm/amd/amdgpu/amdgpu_mode.h      |   2 +
>  .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 215 +++++++++++++++++-
>  .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h |   1 +
>  drivers/gpu/drm/amd/display/dc/core/dc.c      |   8 +
>  drivers/gpu/drm/amd/display/dc/dc_stream.h    |   2 +
>  drivers/gpu/drm/drm_modes.c                   |  29 +++
>  include/drm/drm_connector.h                   |   7 +
>  9 files changed, 290 insertions(+), 12 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c b/drivers/gpu/dr=
m/amd/amdgpu/amdgpu_display.c
> index b119d27271c1..9d201f368b6e 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c
> @@ -1362,6 +1362,33 @@ static const struct drm_prop_enum_list amdgpu_dith=
er_enum_list[] =3D {
>   { AMDGPU_FMT_DITHER_ENABLE, "on" },
>  };
>
> +static const struct drm_prop_enum_list amdgpu_user_pixenc_list[] =3D {
> + { 0, "auto" },
> + { DRM_COLOR_FORMAT_RGB444, "rgb" },
> + { DRM_COLOR_FORMAT_YCBCR444, "ycbcr444" },
> + { DRM_COLOR_FORMAT_YCBCR420, "ycbcr420" },
> +};
> +
> +bool amdgpu_user_pixenc_from_name(
> + unsigned int *user_pixenc,
> + const char *pixenc_name)
> +{
> + bool found =3D false;
> +
> + if (pixenc_name && (*pixenc_name !=3D '\0')) {
> + const int sz =3D ARRAY_SIZE(amdgpu_user_pixenc_list);
> + int i;
> +
> + for (i =3D 0; !found && i < sz; ++i) {
> + if (strcmp(pixenc_name, amdgpu_user_pixenc_list[i].name) =3D=3D 0) {
> + *user_pixenc =3D amdgpu_user_pixenc_list[i].type;
> + found =3D true;
> + }
> + }
> + }
> + return found;
> +}
> +
>  int amdgpu_display_modeset_create_props(struct amdgpu_device *adev)
>  {
>   int sz;
> @@ -1408,6 +1435,14 @@ int amdgpu_display_modeset_create_props(struct amd=
gpu_device *adev)
>    "dither",
>    amdgpu_dither_enum_list, sz);
>
> + sz =3D ARRAY_SIZE(amdgpu_user_pixenc_list);
> + adev->mode_info.pixel_encoding_property =3D
> + drm_property_create_enum(adev_to_drm(adev), 0,
> + "pixel encoding",
> + amdgpu_user_pixenc_list, sz);
> + if (!adev->mode_info.pixel_encoding_property)
> + return -ENOMEM;
> +
>   return 0;
>  }
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_display.h b/drivers/gpu/dr=
m/amd/amdgpu/amdgpu_display.h
> index 9d19940f73c8..ee1ad49fa123 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_display.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_display.h
> @@ -49,4 +49,7 @@ amdgpu_lookup_format_info(u32 format, uint64_t modifier=
);
>  int amdgpu_display_suspend_helper(struct amdgpu_device *adev);
>  int amdgpu_display_resume_helper(struct amdgpu_device *adev);
>
> +bool amdgpu_user_pixenc_from_name(unsigned int *user_pixenc,
> +   const char *pixenc_name);
> +
>  #endif
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mode.h b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_mode.h
> index 5e3faefc5510..b984e66a5d75 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mode.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mode.h
> @@ -326,6 +326,8 @@ struct amdgpu_mode_info {
>   struct drm_property *audio_property;
>   /* FMT dithering */
>   struct drm_property *dither_property;
> + /* User HDMI pixel encoding override */
> + struct drm_property *pixel_encoding_property;
>   /* hardcoded DFP edid from BIOS */
>   const struct drm_edid *bios_hardcoded_edid;
>
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/=
gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> index bbfc47f6595f..2c03e0733178 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> @@ -6069,6 +6069,115 @@ static bool adjust_colour_depth_from_display_info=
(
>   return false;
>  }
>
> +/* convert an pixel encoding property value to a dc_pixel_encoding */
> +static bool drm_prop_to_dc_pixel_encoding(
> + enum dc_pixel_encoding *dc_pixenc,
> + unsigned int propval)
> +{
> + bool ret =3D false;
> +
> + switch (propval) {
> + case 0:
> + *dc_pixenc =3D PIXEL_ENCODING_UNDEFINED;
> + ret =3D true;
> + break;
> + case DRM_COLOR_FORMAT_RGB444:
> + *dc_pixenc =3D PIXEL_ENCODING_RGB;
> + ret =3D true;
> + break;
> + case DRM_COLOR_FORMAT_YCBCR444:
> + *dc_pixenc =3D PIXEL_ENCODING_YCBCR444;
> + ret =3D true;
> + break;
> + case DRM_COLOR_FORMAT_YCBCR420:
> + *dc_pixenc =3D PIXEL_ENCODING_YCBCR420;
> + ret =3D true;
> + break;
> + default:
> + break;
> + }
> + return ret;
> +}
> +
> +/* convert an dc_pixel_encoding to a pixel encoding property value */
> +static unsigned int dc_pixel_encoding_to_drm_prop(
> + enum dc_pixel_encoding pixel_encoding)
> +{
> + unsigned int propval =3D 0;
> +
> + switch (pixel_encoding) {
> + case PIXEL_ENCODING_RGB:
> + propval =3D DRM_COLOR_FORMAT_RGB444;
> + break;
> + case PIXEL_ENCODING_YCBCR444:
> + propval =3D DRM_COLOR_FORMAT_YCBCR444;
> + break;
> + case PIXEL_ENCODING_YCBCR420:
> + propval =3D DRM_COLOR_FORMAT_YCBCR420;
> + break;
> + default:
> + break;
> + }
> + return propval;
> +}
> +
> +/*
> + * Tries to read 'pixel_encoding' from the pixel_encoding DRM property o=
n
> + * 'state'. Returns true if a supported, acceptable, non-undefined value=
 is
> + * found; false otherwise. Only modifies 'pixel_encoding' if returning t=
rue.
> + */
> +bool get_connector_state_pixel_encoding(
> + enum dc_pixel_encoding *pixel_encoding,
> + const struct drm_connector_state *state,
> + const struct drm_display_info *info,
> + const struct drm_display_mode *mode_in)
> +{
> + bool ret =3D false;
> + struct dm_connector_state *dm_state;
> +
> + dm_state =3D to_dm_connector_state(state);
> + if (!dm_state)
> + return false;
> +
> + /* check encoding is supported */
> + switch (dm_state->pixel_encoding) {
> + case PIXEL_ENCODING_RGB:
> + ret =3D (info->color_formats & DRM_COLOR_FORMAT_RGB444);
> + break;
> + case PIXEL_ENCODING_YCBCR444:
> + ret =3D (info->color_formats & DRM_COLOR_FORMAT_YCBCR444);
> + break;
> + case PIXEL_ENCODING_YCBCR420:
> + ret =3D drm_mode_is_420(info, mode_in);
> + break;
> + default:
> + break;
> + }
> +
> + if (ret)
> + *pixel_encoding =3D dm_state->pixel_encoding;
> +
> + return ret;
> +}
> +
> +/*
> + * Writes 'pixel_encoding' to the pixel_encoding DRM property on 'state'=
, if
> + * the enum value is valid and supported; otherwise writes
> + * PIXEL_ENCODING_UNDEFINED which corresponds to the "auto" property sta=
te.
> + */
> +void set_connector_state_pixel_encoding(
> + const struct drm_connector_state *state,
> + enum dc_pixel_encoding pixel_encoding)
> +{
> + struct dm_connector_state *dm_state;
> +
> + dm_state =3D to_dm_connector_state(state);
> + if (!dm_state)
> + return;
> +
> + dm_state->pixel_encoding =3D pixel_encoding;
> +}
> +
>  static void fill_stream_properties_from_drm_display_mode(
>   struct dc_stream_state *stream,
>   const struct drm_display_mode *mode_in,
> @@ -6093,19 +6202,23 @@ static void fill_stream_properties_from_drm_displ=
ay_mode(
>   timing_out->h_border_right =3D 0;
>   timing_out->v_border_top =3D 0;
>   timing_out->v_border_bottom =3D 0;
> - /* TODO: un-hardcode */
> - if (drm_mode_is_420_only(info, mode_in)
> +
> + if (!get_connector_state_pixel_encoding(&timing_out->pixel_encoding,
> + connector_state, info, mode_in)) {
> + /* auto-select a pixel encoding */
> + if (drm_mode_is_420_only(info, mode_in)
>   && stream->signal =3D=3D SIGNAL_TYPE_HDMI_TYPE_A)
> - timing_out->pixel_encoding =3D PIXEL_ENCODING_YCBCR420;
> - else if (drm_mode_is_420_also(info, mode_in)
> + timing_out->pixel_encoding =3D PIXEL_ENCODING_YCBCR420;
> + else if (drm_mode_is_420_also(info, mode_in)
>   && aconnector
>   && aconnector->force_yuv420_output)
> - timing_out->pixel_encoding =3D PIXEL_ENCODING_YCBCR420;
> - else if ((connector->display_info.color_formats & DRM_COLOR_FORMAT_YCBC=
R444)
> - && stream->signal =3D=3D SIGNAL_TYPE_HDMI_TYPE_A)
> - timing_out->pixel_encoding =3D PIXEL_ENCODING_YCBCR444;
> - else
> - timing_out->pixel_encoding =3D PIXEL_ENCODING_RGB;
> + timing_out->pixel_encoding =3D PIXEL_ENCODING_YCBCR420;
> + else if ((connector->display_info.color_formats & DRM_COLOR_FORMAT_YCBC=
R444)
> + && stream->signal =3D=3D SIGNAL_TYPE_HDMI_TYPE_A)
> + timing_out->pixel_encoding =3D PIXEL_ENCODING_YCBCR444;
> + else
> + timing_out->pixel_encoding =3D PIXEL_ENCODING_RGB;
> + }
>
>   timing_out->timing_3d_format =3D TIMING_3D_FORMAT_NONE;
>   timing_out->display_color_depth =3D convert_color_depth_from_display_in=
fo(
> @@ -6169,6 +6282,9 @@ static void fill_stream_properties_from_drm_display=
_mode(
>   }
>   }
>
> + /* write back final choice of pixel encoding */
> + set_connector_state_pixel_encoding(connector_state, timing_out->pixel_e=
ncoding);
> +
>   stream->output_color_space =3D get_output_color_space(timing_out, conne=
ctor_state);
>   stream->content_type =3D get_output_content_type(connector_state);
>  }
> @@ -6875,6 +6991,9 @@ int amdgpu_dm_connector_atomic_set_property(struct =
drm_connector *connector,
>   } else if (property =3D=3D adev->mode_info.underscan_property) {
>   dm_new_state->underscan_enable =3D val;
>   ret =3D 0;
> + } else if (property =3D=3D adev->mode_info.pixel_encoding_property) {
> + if (drm_prop_to_dc_pixel_encoding(&dm_new_state->pixel_encoding, val))
> + ret =3D 0;
>   }
>
>   return ret;
> @@ -6917,6 +7036,9 @@ int amdgpu_dm_connector_atomic_get_property(struct =
drm_connector *connector,
>   } else if (property =3D=3D adev->mode_info.underscan_property) {
>   *val =3D dm_state->underscan_enable;
>   ret =3D 0;
> + } else if (property =3D=3D adev->mode_info.pixel_encoding_property) {
> + *val =3D dc_pixel_encoding_to_drm_prop(dm_state->pixel_encoding);
> + ret =3D 0;
>   }
>
>   return ret;
> @@ -7088,6 +7210,20 @@ void amdgpu_dm_connector_funcs_reset(struct drm_co=
nnector *connector)
>   state->abm_level =3D amdgpu_dm_abm_level;
>   }
>
> + switch (connector->cmdline_mode.pixel_encoding) {
> + case DRM_COLOR_FORMAT_RGB444:
> + state->pixel_encoding =3D PIXEL_ENCODING_RGB;
> + break;
> + case DRM_COLOR_FORMAT_YCBCR444:
> + state->pixel_encoding =3D PIXEL_ENCODING_YCBCR444;
> + break;
> + case DRM_COLOR_FORMAT_YCBCR420:
> + state->pixel_encoding =3D PIXEL_ENCODING_YCBCR420;
> + break;
> + default:
> + break;
> + }
> +
>   __drm_atomic_helper_connector_reset(connector, &state->base);
>   }
>  }
> @@ -7114,6 +7250,7 @@ amdgpu_dm_connector_atomic_duplicate_state(struct d=
rm_connector *connector)
>   new_state->underscan_vborder =3D state->underscan_vborder;
>   new_state->vcpi_slots =3D state->vcpi_slots;
>   new_state->pbn =3D state->pbn;
> + new_state->pixel_encoding =3D state->pixel_encoding;
>   return &new_state->base;
>  }
>
> @@ -8175,6 +8312,12 @@ void amdgpu_dm_connector_init_helper(struct amdgpu=
_display_manager *dm,
>
>   if (adev->dm.hdcp_workqueue)
>   drm_connector_attach_content_protection_property(&aconnector->base, tru=
e);
> +
> + if (adev->mode_info.pixel_encoding_property) {
> + drm_object_attach_property(&aconnector->base.base,
> + adev->mode_info.pixel_encoding_property, 0);
> + DRM_DEBUG_DRIVER("amdgpu: attached pixel encoding drm property");
> + }
>   }
>  }
>
> @@ -9377,6 +9520,38 @@ static void amdgpu_dm_commit_audio(struct drm_devi=
ce *dev,
>   }
>  }
>
> +static void update_stream_for_pixel_encoding(
> + struct dc_stream_update *stream_update,
> + struct drm_connector *connector,
> + struct dm_crtc_state *dm_old_crtc_state,
> + struct dm_crtc_state *dm_new_crtc_state,
> + struct dm_connector_state *dm_new_con_state)
> +{
> + struct amdgpu_dm_connector *aconnector =3D
> + to_amdgpu_dm_connector(connector);
> + struct dc_stream_state *new_stream =3D NULL;
> +
> + if (aconnector)
> + new_stream =3D create_validate_stream_for_sink(
> + aconnector,
> + &dm_new_crtc_state->base.mode,
> + dm_new_con_state,
> + dm_old_crtc_state->stream);
> + if (new_stream) {
> + dm_new_crtc_state->stream->timing =3D
> + new_stream->timing;
> + stream_update->timing_for_pixel_encoding =3D
> + &dm_new_crtc_state->stream->timing;
> +
> + dm_new_crtc_state->stream->output_color_space =3D
> + new_stream->output_color_space;
> + stream_update->output_color_space =3D
> + &dm_new_crtc_state->stream->output_color_space;
> +
> + dc_stream_release(new_stream);
> + }
> +}
> +
>  /*
>   * amdgpu_dm_crtc_copy_transient_flags - copy mirrored flags from DRM to=
 DC
>   * @crtc_state: the DRM CRTC state
> @@ -9850,7 +10025,7 @@ static void amdgpu_dm_atomic_commit_tail(struct dr=
m_atomic_state *state)
>   struct dc_stream_update stream_update;
>   struct dc_info_packet hdr_packet;
>   struct dc_stream_status *status =3D NULL;
> - bool abm_changed, hdr_changed, scaling_changed;
> + bool abm_changed, hdr_changed, scaling_changed, pixenc_changed;
>
>   memset(&stream_update, 0, sizeof(stream_update));
>
> @@ -9875,7 +10050,10 @@ static void amdgpu_dm_atomic_commit_tail(struct d=
rm_atomic_state *state)
>   hdr_changed =3D
>   !drm_connector_atomic_hdr_metadata_equal(old_con_state, new_con_state);
>
> - if (!scaling_changed && !abm_changed && !hdr_changed)
> + pixenc_changed =3D dm_new_con_state->pixel_encoding !=3D
> +  dm_old_con_state->pixel_encoding;
> +
> + if (!scaling_changed && !abm_changed && !hdr_changed && !pixenc_changed=
)
>   continue;
>
>   stream_update.stream =3D dm_new_crtc_state->stream;
> @@ -9898,6 +10076,13 @@ static void amdgpu_dm_atomic_commit_tail(struct d=
rm_atomic_state *state)
>   stream_update.hdr_static_metadata =3D &hdr_packet;
>   }
>
> + if (pixenc_changed) {
> + update_stream_for_pixel_encoding(&stream_update,
> + connector,
> + dm_old_crtc_state, dm_new_crtc_state,
> + dm_new_con_state);
> + }
> +
>   status =3D dc_stream_get_status(dm_new_crtc_state->stream);
>
>   if (WARN_ON(!status))
> @@ -11403,6 +11588,12 @@ static int amdgpu_dm_atomic_check(struct drm_dev=
ice *dev,
>   if (dm_old_con_state->abm_level !=3D dm_new_con_state->abm_level ||
>       dm_old_con_state->scaling !=3D dm_new_con_state->scaling)
>   new_crtc_state->connectors_changed =3D true;
> +
> + if (dm_old_con_state->pixel_encoding !=3D
> +     dm_new_con_state->pixel_encoding) {
> + new_crtc_state->connectors_changed =3D true;
> + new_crtc_state->mode_changed =3D true;
> + }
>   }
>
>   if (dc_resource_is_dsc_encoding_supported(dc)) {
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h b/drivers/=
gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
> index 25e95775c45c..132944272c18 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
> @@ -918,6 +918,7 @@ struct dm_connector_state {
>   uint8_t abm_level;
>   int vcpi_slots;
>   uint64_t pbn;
> + enum dc_pixel_encoding pixel_encoding;
>  };
>
>  #define to_dm_connector_state(x)\
> diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/a=
md/display/dc/core/dc.c
> index 5a12fc75f97f..4ac004536707 100644
> --- a/drivers/gpu/drm/amd/display/dc/core/dc.c
> +++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
> @@ -2765,6 +2765,11 @@ static enum surface_update_type check_update_surfa=
ces_for_stream(
>   if (stream_update->output_csc_transform || stream_update->output_color_=
space)
>   su_flags->bits.out_csc =3D 1;
>
> + if (stream_update->timing_for_pixel_encoding) {
> + su_flags->bits.pixel_encoding =3D 1;
> + elevate_update_type(&overall_type, UPDATE_TYPE_FULL);
> + }
> +
>   /* Output transfer function changes do not require bandwidth recalculat=
ion,
>    * so don't trigger a full update
>    */
> @@ -3112,6 +3117,8 @@ static void copy_stream_update_to_stream(struct dc =
*dc,
>   stream->scaler_sharpener_update =3D *update->scaler_sharpener_update;
>   if (update->sharpening_required)
>   stream->sharpening_required =3D *update->sharpening_required;
> + if (update->timing_for_pixel_encoding)
> + stream->timing =3D *update->timing_for_pixel_encoding;
>  }
>
>  static void backup_planes_and_stream_state(
> @@ -3361,6 +3368,7 @@ static void commit_planes_do_stream_update(struct d=
c *dc,
>   stream_update->vsc_infopacket ||
>   stream_update->vsp_infopacket ||
>   stream_update->hfvsif_infopacket ||
> + stream_update->timing_for_pixel_encoding ||
>   stream_update->adaptive_sync_infopacket ||
>   stream_update->vtem_infopacket) {
>   resource_build_info_frame(pipe_ctx);
> diff --git a/drivers/gpu/drm/amd/display/dc/dc_stream.h b/drivers/gpu/drm=
/amd/display/dc/dc_stream.h
> index 413970588a26..de7f02f330d8 100644
> --- a/drivers/gpu/drm/amd/display/dc/dc_stream.h
> +++ b/drivers/gpu/drm/amd/display/dc/dc_stream.h
> @@ -144,6 +144,7 @@ union stream_update_flags {
>   uint32_t fams_changed : 1;
>   uint32_t scaler_sharpener : 1;
>   uint32_t sharpening_required : 1;
> + uint32_t pixel_encoding:1;
>   } bits;
>
>   uint32_t raw;
> @@ -350,6 +351,7 @@ struct dc_stream_update {
>   struct dc_mst_stream_bw_update *mst_bw_update;
>   struct dc_transfer_func *func_shaper;
>   struct dc_3dlut *lut3d_func;
> + struct dc_crtc_timing *timing_for_pixel_encoding;
>
>   struct test_pattern *pending_test_pattern;
>   struct dc_crtc_timing_adjust *crtc_timing_adjust;
> diff --git a/drivers/gpu/drm/drm_modes.c b/drivers/gpu/drm/drm_modes.c
> index 1a0890083aee..b5ce8f93b672 100644
> --- a/drivers/gpu/drm/drm_modes.c
> +++ b/drivers/gpu/drm/drm_modes.c
> @@ -2161,6 +2161,32 @@ static int drm_mode_parse_tv_mode(const char *deli=
m,
>   return 0;
>  }
>
> +static int drm_mode_parse_pixel_encoding(const char *delim,
> +  struct drm_cmdline_mode *mode)
> +{
> + const char *value;
> +
> + if (*delim !=3D '=3D')
> + return -EINVAL;
> +
> + value =3D delim + 1;
> + delim =3D strchr(value, ',');
> + if (!delim)
> + delim =3D value + strlen(value);
> +
> + if (!strncmp(value, "auto", delim - value))
> + mode->pixel_encoding =3D 0;
> + else if (!strncmp(value, "rgb", delim - value))
> + mode->pixel_encoding =3D DRM_COLOR_FORMAT_RGB444;
> + else if (!strncmp(value, "ycbcr444", delim - value))
> + mode->pixel_encoding =3D DRM_COLOR_FORMAT_YCBCR444;
> + else if (!strncmp(value, "ycbcr420", delim - value))
> + mode->pixel_encoding =3D DRM_COLOR_FORMAT_YCBCR420;
> + else
> + return -EINVAL;
> +
> + return 0;
> +}
>  static int drm_mode_parse_cmdline_options(const char *str,
>     bool freestanding,
>     const struct drm_connector *connector,
> @@ -2233,6 +2259,9 @@ static int drm_mode_parse_cmdline_options(const cha=
r *str,
>   } else if (!strncmp(option, "tv_mode", delim - option)) {
>   if (drm_mode_parse_tv_mode(delim, mode))
>   return -EINVAL;
> + } else if (!strncmp(option, "pixel_encoding", delim - option)) {
> + if (drm_mode_parse_pixel_encoding(delim, mode))
> + return -EINVAL;
>   } else {
>   return -EINVAL;
>   }
> diff --git a/include/drm/drm_connector.h b/include/drm/drm_connector.h
> index c754651044d4..89c0f42873df 100644
> --- a/include/drm/drm_connector.h
> +++ b/include/drm/drm_connector.h
> @@ -1666,6 +1666,13 @@ struct drm_cmdline_mode {
>    * Did the mode have a preferred TV mode?
>    */
>   bool tv_mode_specified;
> +
> + /**
> +  * @pixel_encoding:
> +  *
> +  * Initial pixel encoding.
> +  */
> + unsigned int pixel_encoding;
>  };
>
>  /*
> --
> 2.43.0
