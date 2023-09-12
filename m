Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A54F0CA0EF7
	for <amd-gfx@archiver.kernel.org>; Tue, 12 Sep 2023 17:19:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DCA5110E241;
	Tue, 12 Sep 2023 17:19:42 +0000 (UTC)
Received: from mail-oo1-xc35.google.com (mail-oo1-xc35.google.com
 [IPv6:2607:f8b0:4864:20::c35])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8025D10E241
 for <amd-gfx@lists.freedesktop.org>; Tue, 12 Sep 2023 17:19:40 +0000 (UTC)
Received: by mail-oo1-xc35.google.com with SMTP id
 006d021491bc7-5738cb00eebso3747351eaf.2
 for <amd-gfx@lists.freedesktop.org>; Tue, 12 Sep 2023 10:19:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1694539179; x=1695143979; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mlT6Dp6OXlLU3grhFmpMto8xsuelhpjrQqIEl2v2aIw=;
 b=Hqxc0SrJp1Tnfvsx/InFdZkSMpqe4AP8WrgvfMYYu55SUqNLkRILR04h3JHGZyJCj7
 HXNrqa3qh57Dik1z+96CnEjp3ZwLA7PuXSj261dIBL8jMq6EI/xVsJla1iD6uF97vvW6
 6m3Um4OPCZTWOXvxtFF3Xte1qV2ZcyeN5UXI2qyskX4QTL4rSQWQoAa4720CTjX17lM2
 35dF5/GrORBjh0MD7UatpllkhKFY7/yAGNHaaVWtkgLFFQSbqpxHGpOEvpinr7ymJ1ER
 XKOg6c0F3/CkNbXbj1i2pL6IoshzCuXN//u1K2IZdpr5psVyB/hgUvxmMofydYJLx1rY
 u5Jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694539179; x=1695143979;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=mlT6Dp6OXlLU3grhFmpMto8xsuelhpjrQqIEl2v2aIw=;
 b=u8Zy/VL9PhglPlqSnyFhA+oG1HrlNNDGuJg39BN5A44Ng04SpWNIqhmc4TCA4wcHHY
 LuzaqqC8KvXAJfkHdW0hPEqlYeMP+BSiCpwe9isUcB6ONtulZV8VjjWiDcWsAT3CL9n1
 9rlcVewqVhBbgaXaknsZBLkDNLM16+6eLnM5g0m9tH+lHVWI9AUPBW3Qv1CUu+jpCEcn
 KsEhrZC6b2m4SIht7B7hBgHIx63R3ENbIfbpExcQ2M2FaW8xlzBCRtGuVXUhyGQlF+rH
 uQNMqCr7aeVTN0yC1Fwddi2wBzQTYKo8s0Tdnvb2keksjrmz1biAKuBnQ73/u5mugVKr
 Fo7Q==
X-Gm-Message-State: AOJu0YxqeXN8C89ieR9/N6oMtX7Dr0tplCPEC46iULS2Q3xHLLza+4kh
 ZGnG8++lZ5qVF1zDbmfB5KvnFQHwbfPeeVCpraSH9l7r
X-Google-Smtp-Source: AGHT+IFXLAFrEfBsQjWVzwHiNgRvULKqL7eriYmo9Nfw16VW/N92hR1ka7wJPGSuptEM+5S/BqcgK5zw8qRc4OyFS9w=
X-Received: by 2002:a05:6870:9124:b0:1c3:c43d:838 with SMTP id
 o36-20020a056870912400b001c3c43d0838mr147436oae.39.1694539179639; Tue, 12 Sep
 2023 10:19:39 -0700 (PDT)
MIME-Version: 1.0
References: <20230912160157.107975-1-mwen@igalia.com>
 <20230912160157.107975-2-mwen@igalia.com>
In-Reply-To: <20230912160157.107975-2-mwen@igalia.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 12 Sep 2023 13:19:28 -0400
Message-ID: <CADnq5_PAnv6JVfEhe0OEKhecosshVc-wrHR4pmr-+n0tNsWSwA@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] drm/amd/display: Hook up 'content type' property
 for HDMI
To: Melissa Wen <mwen@igalia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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
Cc: Leo Li <sunpeng.li@amd.com>, Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
 amd-gfx@lists.freedesktop.org, "Guilherme G . Piccoli" <gpiccoli@igalia.com>,
 Hamza Mahfooz <hamza.mahfooz@amd.com>, kernel-dev@igalia.com,
 Alex Deucher <alexander.deucher@amd.com>,
 Harry Wentland <harry.wentland@amd.com>, christian.koenig@amd.com,
 Joshua Ashton <joshua@froggi.es>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Tue, Sep 12, 2023 at 12:02=E2=80=AFPM Melissa Wen <mwen@igalia.com> wrot=
e:
>
> From: Joshua Ashton <joshua@froggi.es>
>
> Implements the 'content type' property for HDMI connectors.
> Verified by checking the avi infoframe on a connected TV.
>
> This also simplifies a lot of the code in that area as well, there were
> a lot of temp variables doing very little and unnecessary logic
> that was quite confusing.
>
> It is not necessary to check for support in the EDID before sending a
> 'content type' value in the avi infoframe also.
>
> v2:
> - rebase to amd-staging-drm-next
> - mark CRTC state for reset if content_type differs
>
> Reviewed-by: Harry Wentland <harry.wentland@amd.com> (v1)
> Signed-off-by: Joshua Ashton <joshua@froggi.es>
> Co-developed-by: Melissa Wen <mwen@igalia.com>
> Signed-off-by: Melissa Wen <mwen@igalia.com>
> ---
>  .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 32 +++++++++
>  .../gpu/drm/amd/display/dc/core/dc_resource.c | 69 ++++++-------------
>  drivers/gpu/drm/amd/display/dc/dc_stream.h    |  1 +
>  3 files changed, 54 insertions(+), 48 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/=
gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> index 5efebc06296b..811e2223f643 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> @@ -5461,6 +5461,24 @@ get_output_color_space(const struct dc_crtc_timing=
 *dc_crtc_timing,
>         return color_space;
>  }
>
> +static enum display_content_type
> +get_output_content_type(const struct drm_connector_state *connector_stat=
e)
> +{
> +       switch (connector_state->content_type) {
> +       default:
> +       case DRM_MODE_CONTENT_TYPE_NO_DATA:
> +               return DISPLAY_CONTENT_TYPE_NO_DATA;
> +       case DRM_MODE_CONTENT_TYPE_GRAPHICS:
> +               return DISPLAY_CONTENT_TYPE_GRAPHICS;
> +       case DRM_MODE_CONTENT_TYPE_PHOTO:
> +               return DISPLAY_CONTENT_TYPE_PHOTO;
> +       case DRM_MODE_CONTENT_TYPE_CINEMA:
> +               return DISPLAY_CONTENT_TYPE_CINEMA;
> +       case DRM_MODE_CONTENT_TYPE_GAME:
> +               return DISPLAY_CONTENT_TYPE_GAME;
> +       }
> +}
> +
>  static bool adjust_colour_depth_from_display_info(
>         struct dc_crtc_timing *timing_out,
>         const struct drm_display_info *info)
> @@ -5595,6 +5613,7 @@ static void fill_stream_properties_from_drm_display=
_mode(
>         }
>
>         stream->output_color_space =3D get_output_color_space(timing_out,=
 connector_state);
> +       stream->content_type =3D get_output_content_type(connector_state)=
;
>  }
>
>  static void fill_audio_info(struct audio_info *audio_info,
> @@ -6795,6 +6814,14 @@ amdgpu_dm_connector_atomic_check(struct drm_connec=
tor *conn,
>                 new_crtc_state->mode_changed =3D true;
>         }
>
> +       if (new_con_state->content_type !=3D old_con_state->content_type)=
 {
> +               new_crtc_state =3D drm_atomic_get_crtc_state(state, crtc)=
;
> +               if (IS_ERR(new_crtc_state))
> +                       return PTR_ERR(new_crtc_state);
> +
> +               new_crtc_state->mode_changed =3D true;
> +       }
> +
>         if (!drm_connector_atomic_hdr_metadata_equal(old_con_state, new_c=
on_state)) {
>                 struct dc_info_packet hdr_infopacket;
>
> @@ -7430,6 +7457,11 @@ void amdgpu_dm_connector_init_helper(struct amdgpu=
_display_manager *dm,
>                                 adev->mode_info.abm_level_property, 0);
>         }
>
> +       if (connector_type =3D=3D DRM_MODE_CONNECTOR_HDMIA) {
> +               /* Content Type is currently only implemented for HDMI. *=
/
> +               drm_connector_attach_content_type_property(&aconnector->b=
ase);
> +       }
> +

This could just be squashed into the clause below.  Either way, looks
fine to me.  The series is:
Acked-by: Alex Deucher <alexander.deucher@amd.com>

Alex


>         if (connector_type =3D=3D DRM_MODE_CONNECTOR_HDMIA) {
>                 if (!drm_mode_create_hdmi_colorspace_property(&aconnector=
->base, supported_colorspaces))
>                         drm_connector_attach_colorspace_property(&aconnec=
tor->base);
> diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c b/drivers/=
gpu/drm/amd/display/dc/core/dc_resource.c
> index 494efbede0b2..5810cf78cf29 100644
> --- a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
> +++ b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
> @@ -3928,14 +3928,9 @@ static void set_avi_info_frame(
>         uint32_t pixel_encoding =3D 0;
>         enum scanning_type scan_type =3D SCANNING_TYPE_NODATA;
>         enum dc_aspect_ratio aspect =3D ASPECT_RATIO_NO_DATA;
> -       bool itc =3D false;
> -       uint8_t itc_value =3D 0;
> -       uint8_t cn0_cn1 =3D 0;
> -       unsigned int cn0_cn1_value =3D 0;
>         uint8_t *check_sum =3D NULL;
>         uint8_t byte_index =3D 0;
>         union hdmi_info_packet hdmi_info;
> -       union display_content_support support =3D {0};
>         unsigned int vic =3D pipe_ctx->stream->timing.vic;
>         unsigned int rid =3D pipe_ctx->stream->timing.rid;
>         unsigned int fr_ind =3D pipe_ctx->stream->timing.fr_index;
> @@ -4045,49 +4040,27 @@ static void set_avi_info_frame(
>         /* Active Format Aspect ratio - same as Picture Aspect Ratio. */
>         hdmi_info.bits.R0_R3 =3D ACTIVE_FORMAT_ASPECT_RATIO_SAME_AS_PICTU=
RE;
>
> -       /* TODO: un-hardcode cn0_cn1 and itc */
> -
> -       cn0_cn1 =3D 0;
> -       cn0_cn1_value =3D 0;
> -
> -       itc =3D true;
> -       itc_value =3D 1;
> -
> -       support =3D stream->content_support;
> -
> -       if (itc) {
> -               if (!support.bits.valid_content_type) {
> -                       cn0_cn1_value =3D 0;
> -               } else {
> -                       if (cn0_cn1 =3D=3D DISPLAY_CONTENT_TYPE_GRAPHICS)=
 {
> -                               if (support.bits.graphics_content =3D=3D =
1) {
> -                                       cn0_cn1_value =3D 0;
> -                               }
> -                       } else if (cn0_cn1 =3D=3D DISPLAY_CONTENT_TYPE_PH=
OTO) {
> -                               if (support.bits.photo_content =3D=3D 1) =
{
> -                                       cn0_cn1_value =3D 1;
> -                               } else {
> -                                       cn0_cn1_value =3D 0;
> -                                       itc_value =3D 0;
> -                               }
> -                       } else if (cn0_cn1 =3D=3D DISPLAY_CONTENT_TYPE_CI=
NEMA) {
> -                               if (support.bits.cinema_content =3D=3D 1)=
 {
> -                                       cn0_cn1_value =3D 2;
> -                               } else {
> -                                       cn0_cn1_value =3D 0;
> -                                       itc_value =3D 0;
> -                               }
> -                       } else if (cn0_cn1 =3D=3D DISPLAY_CONTENT_TYPE_GA=
ME) {
> -                               if (support.bits.game_content =3D=3D 1) {
> -                                       cn0_cn1_value =3D 3;
> -                               } else {
> -                                       cn0_cn1_value =3D 0;
> -                                       itc_value =3D 0;
> -                               }
> -                       }
> -               }
> -               hdmi_info.bits.CN0_CN1 =3D cn0_cn1_value;
> -               hdmi_info.bits.ITC =3D itc_value;
> +       switch (stream->content_type) {
> +       case DISPLAY_CONTENT_TYPE_NO_DATA:
> +               hdmi_info.bits.CN0_CN1 =3D 0;
> +               hdmi_info.bits.ITC =3D 0;
> +               break;
> +       case DISPLAY_CONTENT_TYPE_GRAPHICS:
> +               hdmi_info.bits.CN0_CN1 =3D 0;
> +               hdmi_info.bits.ITC =3D 1;
> +               break;
> +       case DISPLAY_CONTENT_TYPE_PHOTO:
> +               hdmi_info.bits.CN0_CN1 =3D 1;
> +               hdmi_info.bits.ITC =3D 1;
> +               break;
> +       case DISPLAY_CONTENT_TYPE_CINEMA:
> +               hdmi_info.bits.CN0_CN1 =3D 2;
> +               hdmi_info.bits.ITC =3D 1;
> +               break;
> +       case DISPLAY_CONTENT_TYPE_GAME:
> +               hdmi_info.bits.CN0_CN1 =3D 3;
> +               hdmi_info.bits.ITC =3D 1;
> +               break;
>         }
>
>         if (stream->qs_bit =3D=3D 1) {
> diff --git a/drivers/gpu/drm/amd/display/dc/dc_stream.h b/drivers/gpu/drm=
/amd/display/dc/dc_stream.h
> index d5b3e3a32cc6..d4224de13138 100644
> --- a/drivers/gpu/drm/amd/display/dc/dc_stream.h
> +++ b/drivers/gpu/drm/amd/display/dc/dc_stream.h
> @@ -212,6 +212,7 @@ struct dc_stream_state {
>         struct dc_csc_transform csc_color_matrix;
>
>         enum dc_color_space output_color_space;
> +       enum display_content_type content_type;
>         enum dc_dither_option dither_option;
>
>         enum view_3d_format view_format;
> --
> 2.40.1
>
