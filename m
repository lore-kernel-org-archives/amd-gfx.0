Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CAADFC678D5
	for <amd-gfx@archiver.kernel.org>; Thu,  9 Mar 2023 01:58:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2C46910E77D;
	Thu,  9 Mar 2023 01:58:22 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B2DD010E77B
 for <amd-gfx@lists.freedesktop.org>; Thu,  9 Mar 2023 01:58:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1678327098;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=LS0dXBK9Zbb2hQec34Ik/8nJw+u9HcTwAhw9UOKPG+A=;
 b=OaLZbwhwuz0VAh431JkQW5O4O3xsFCcGWZ9nIBUVYDr5VsNGa1dY40tNCTZHqwd9cqRss4
 AzeD1TQCP5A1Md+TNoSjnXLAPhHDoV7pbNmobPUEiojfruqiGnckqKU9UbIie+Bytp2/KR
 BAULTlBJPTnVRY3DysR0QXJSNwo573E=
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com
 [209.85.208.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-399-p20SFi4jNiOhpzAclNIVCg-1; Wed, 08 Mar 2023 20:58:17 -0500
X-MC-Unique: p20SFi4jNiOhpzAclNIVCg-1
Received: by mail-lj1-f197.google.com with SMTP id
 a2-20020a2e8602000000b00295cb325fd5so116528lji.3
 for <amd-gfx@lists.freedesktop.org>; Wed, 08 Mar 2023 17:58:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112; t=1678327096;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=LS0dXBK9Zbb2hQec34Ik/8nJw+u9HcTwAhw9UOKPG+A=;
 b=BMkaQqK4PY/329jxKyH8+pBXury5GP9hwB8Ha1gvim7KkNJqskU67JAQsVKVpl4yEO
 xaMG6dqK4s10z+MF10pOC7WacXMGH7p/pC3ZJY3Pw/Co1mtBMOjxBy8nVWssdrsth4Lz
 TYSynbQulMUa+LWm+ZkMRqvONjMdaOfKkFBHhu40GSsc15Ia3JQZ4sKU+l8B3+/7n4KX
 Ad397WFJDNnaTYaIoz/an07vR0RYJbbsFCS22omWkYn803jIuV4qSt3K8FYSev78gncq
 3JAn+NJcV4J9dTGzqTgmEnfkHA2SN9Ig86aVuw4yynVtlaC23szVSdHWcDePGhI81lIK
 MLlA==
X-Gm-Message-State: AO0yUKW/tcwSlCvzWJaNLf3fF9/tgX4o0QHJMmD0QitB0UJd/jVnNSZf
 9FmzMytZK/00yxm4Ku8TQQ60I3aw2uIAzE+cirDKJSIawIYjKCZbiEGAoY4SYbU5NW7DjHYKWhg
 UgOOVjIrM+BewdROmi53+Y4GxdCx6SRSw2ZEjoa4FBA==
X-Received: by 2002:ac2:43d0:0:b0:4db:f0a:d574 with SMTP id
 u16-20020ac243d0000000b004db0f0ad574mr6089281lfl.7.1678327095888; 
 Wed, 08 Mar 2023 17:58:15 -0800 (PST)
X-Google-Smtp-Source: AK7set9pOU7/I4xAbU7re8C4MUYJ7vWR5MT2zMm0EkNmr3D1ljqirlp9ke/VDVipndOCK22+AIoCinyDqy66/4CJ/5E=
X-Received: by 2002:ac2:43d0:0:b0:4db:f0a:d574 with SMTP id
 u16-20020ac243d0000000b004db0f0ad574mr6089277lfl.7.1678327095611; Wed, 08 Mar
 2023 17:58:15 -0800 (PST)
MIME-Version: 1.0
References: <20230307151107.49649-1-harry.wentland@amd.com>
 <20230307151107.49649-12-harry.wentland@amd.com>
In-Reply-To: <20230307151107.49649-12-harry.wentland@amd.com>
From: Sebastian Wick <sebastian.wick@redhat.com>
Date: Thu, 9 Mar 2023 02:58:04 +0100
Message-ID: <CA+hFU4w=iManNEPtKhuM7jTQtDK9HnpMcRfD1QME8x=Rug2Q-g@mail.gmail.com>
Subject: Re: [PATCH v3 11/17] drm/amd/display: Send correct DP colorspace
 infopacket
To: Harry Wentland <harry.wentland@amd.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
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
Cc: Joshua Ashton <joshua@froggi.es>, Pekka Paalanen <ppaalanen@gmail.com>,
 dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
 Vitaly.Prosyak@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Tue, Mar 7, 2023 at 4:12=E2=80=AFPM Harry Wentland <harry.wentland@amd.c=
om> wrote:
>
> Look at connector->colorimetry to determine output colorspace.
>
> We don't want to impact current SDR behavior, so
> DRM_MODE_COLORIMETRY_DEFAULT preserves current behavior.
>
> Signed-off-by: Harry Wentland <harry.wentland@amd.com>
> Cc: Pekka Paalanen <ppaalanen@gmail.com>
> Cc: Sebastian Wick <sebastian.wick@redhat.com>
> Cc: Vitaly.Prosyak@amd.com
> Cc: Joshua Ashton <joshua@froggi.es>
> Cc: dri-devel@lists.freedesktop.org
> Cc: amd-gfx@lists.freedesktop.org
> Reviewed-By: Joshua Ashton <joshua@froggi.es>
> ---
>  .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 38 +++++++++++--------
>  1 file changed, 22 insertions(+), 16 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/=
gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> index 58fc719bec8d..cdfd09d50ee6 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> @@ -5302,21 +5302,21 @@ get_aspect_ratio(const struct drm_display_mode *m=
ode_in)
>  }
>
>  static enum dc_color_space
> -get_output_color_space(const struct dc_crtc_timing *dc_crtc_timing)
> +get_output_color_space(const struct dc_crtc_timing *dc_crtc_timing,
> +                      const struct drm_connector_state *connector_state)
>  {
>         enum dc_color_space color_space =3D COLOR_SPACE_SRGB;
>
> -       switch (dc_crtc_timing->pixel_encoding) {
> -       case PIXEL_ENCODING_YCBCR422:
> -       case PIXEL_ENCODING_YCBCR444:
> -       case PIXEL_ENCODING_YCBCR420:
> -       {
> +       switch (connector_state->colorspace) {
> +       case DRM_MODE_COLORIMETRY_DEFAULT: // ITU601

So, I do get random behavior with DRM_MODE_COLORIMETRY_DEFAULT instead
of the colorimetry that the EDID specifies? That doesn't sound good at
all.

> +               if (dc_crtc_timing->pixel_encoding =3D=3D PIXEL_ENCODING_=
RGB) {
> +                       color_space =3D COLOR_SPACE_SRGB;
>                 /*
>                  * 27030khz is the separation point between HDTV and SDTV
>                  * according to HDMI spec, we use YCbCr709 and YCbCr601
>                  * respectively
>                  */
> -               if (dc_crtc_timing->pix_clk_100hz > 270300) {
> +               } else if (dc_crtc_timing->pix_clk_100hz > 270300) {
>                         if (dc_crtc_timing->flags.Y_ONLY)
>                                 color_space =3D
>                                         COLOR_SPACE_YCBCR709_LIMITED;
> @@ -5329,15 +5329,21 @@ get_output_color_space(const struct dc_crtc_timin=
g *dc_crtc_timing)
>                         else
>                                 color_space =3D COLOR_SPACE_YCBCR601;
>                 }
> -
> -       }
> -       break;
> -       case PIXEL_ENCODING_RGB:
> -               color_space =3D COLOR_SPACE_SRGB;
>                 break;
> -
> -       default:
> -               WARN_ON(1);
> +       case DRM_MODE_COLORIMETRY_BT709_YCC:
> +               if (dc_crtc_timing->flags.Y_ONLY)
> +                       color_space =3D COLOR_SPACE_YCBCR709_LIMITED;
> +               else
> +                       color_space =3D COLOR_SPACE_YCBCR709;
> +               break;
> +       case DRM_MODE_COLORIMETRY_OPRGB:
> +               color_space =3D COLOR_SPACE_ADOBERGB;
> +               break;
> +       case DRM_MODE_COLORIMETRY_BT2020:
> +               color_space =3D COLOR_SPACE_2020_RGB_FULLRANGE;
> +               break;
> +       case DRM_MODE_COLORIMETRY_BT2020_DEPRECATED:
> +               color_space =3D COLOR_SPACE_2020_YCBCR;
>                 break;
>         }
>
> @@ -5476,7 +5482,7 @@ static void fill_stream_properties_from_drm_display=
_mode(
>                 }
>         }
>
> -       stream->output_color_space =3D get_output_color_space(timing_out)=
;
> +       stream->output_color_space =3D get_output_color_space(timing_out,=
 connector_state);
>  }
>
>  static void fill_audio_info(struct audio_info *audio_info,
> --
> 2.39.2
>

