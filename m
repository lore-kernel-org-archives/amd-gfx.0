Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58F16CAC5A5
	for <amd-gfx@archiver.kernel.org>; Wed, 24 Sep 2025 17:03:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E468A10E78B;
	Wed, 24 Sep 2025 17:03:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="DpbIwAsd";
	dkim-atps=neutral
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com
 [209.85.214.170])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2F4C010E78B
 for <amd-gfx@lists.freedesktop.org>; Wed, 24 Sep 2025 17:03:47 +0000 (UTC)
Received: by mail-pl1-f170.google.com with SMTP id
 d9443c01a7336-24498e93b8fso28195ad.3
 for <amd-gfx@lists.freedesktop.org>; Wed, 24 Sep 2025 10:03:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1758733427; x=1759338227; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=m7aT1afU/KAnrQc2QEM7GZQg2WhjFidIyaEcTdR9zUM=;
 b=DpbIwAsd56Jq8+MGiJmOq8eCqAAR+BtW2JtW8fKpzW93YT48rX4ZFY48jzPvBEvw75
 We/mF7yK0yx2xrdHS3iibkNWMzGOQ1ggshNxl4kSfbTqvcRvKI89VBrAq8craTibAnol
 HeAb1G19actmEGS/67MWt/mwvQ07Wz4ZML7Qc6zPZ+26HGeMvffh4KGV8Dixo4RWhD+V
 qPsGq0wzp5qhOqhGL8L8CagyplXyPc2d3DZx1OU4TACquk5gq/rOT0K4bzk5EFIuB8Ej
 Y973mxq2c13ZStApaHTcS7L1QbJw6hNUWsUETq06ZYWLpSPQK7AB/+VOvhIjIQ76JvaP
 1RLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758733427; x=1759338227;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=m7aT1afU/KAnrQc2QEM7GZQg2WhjFidIyaEcTdR9zUM=;
 b=C6qlLI3CE/P2IUvojp/LjCdcLBIZQeNomfZMYQTDCPT9c59q+MhfkF46mzKHYhZe0/
 3kGcyI59T1m8IvmuYphjVEGvF4iQDkpOsIxpOdbj8s6i7MzM102YjBIhAtnMaZPFjMbQ
 1LKW/qNsKY9Dij/B8vWI5enSYIIIOTpKDC3OHtJfmgwNCc0pEtG/PpvXwSFUwFH7r6b3
 uu8Y0viiDYR/xXh/fmKodyjNntmed2i4V7GhGi5y0WcgWioKF7ej1qEgR9qKI2MwXK7K
 zGRapNbC5c2pX3Emb1PBzdPNt+YQWUrEHl71bWAilYRtNDGxkFz5RDUUeWsX+oBkjHp5
 l4BQ==
X-Gm-Message-State: AOJu0YxXp16YeRDvbqJQsSqzYZgmNf0CxUpsqPHQ6Q0H2tmw8IZfCGsS
 1A/zG1wUI0q6TpnkwN6X3Y+fcsUgDIy2norPFozTB3eNr56cOVCSVQj68a6hym32lFo46IaplUT
 je2T/mM9beHHUg/DalsjWVhOvocStPj0wVw==
X-Gm-Gg: ASbGncukx/oaHmPCapoyS8tNX37rWSNfz4p0MBriTKmVg5V9CJEdCaxiAg55fWSX24q
 DbH6vgrOjtCBydvlwIOgoMAoZH3oyDfqWiZ8G4QJubNhOrHzEbZa37EGNYZ5KjaYAG2UVYaeddJ
 EtaBID6jrR9F0Ur8iWwrLPiRKI+OjuIBRBhTLbxmbsnpY4UWqQuUtW58q7+YkdRUVid/UpIHcHZ
 rHcEmk=
X-Google-Smtp-Source: AGHT+IGVnI8AtMnJZIPsFeWBf/3diH+RWYk8YViCBAatcNgE7N//bEweavm5aOMBT1W6C0b2PYszta8PjyXnEVqRw1s=
X-Received: by 2002:a17:903:22ca:b0:27a:186f:53ec with SMTP id
 d9443c01a7336-27ed4a4f3d3mr2506545ad.9.1758733426421; Wed, 24 Sep 2025
 10:03:46 -0700 (PDT)
MIME-Version: 1.0
References: <20250924113836.57013-1-timur.kristof@gmail.com>
 <20250924113836.57013-4-timur.kristof@gmail.com>
In-Reply-To: <20250924113836.57013-4-timur.kristof@gmail.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 24 Sep 2025 13:03:33 -0400
X-Gm-Features: AS18NWBAMEBHRZ-UH6dBfSf6kCHMTtclb-HA1vwrcb1zWZkK704nF_uwhWQFNac
Message-ID: <CADnq5_NnTOg7LPOjaZfCNbBzwbtcCqoLGia6CqohVGZz6EeL4A@mail.gmail.com>
Subject: Re: [PATCH 3/3] drm/amd/display: Share dce100_validate_global with
 DCE6-8
To: =?UTF-8?Q?Timur_Krist=C3=B3f?= <timur.kristof@gmail.com>
Cc: amd-gfx@lists.freedesktop.org, alexander.deucher@amd.com, 
 alex.hung@amd.com, harry.wentland@amd.com, siqueira@igalia.com
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Wed, Sep 24, 2025 at 7:49=E2=80=AFAM Timur Krist=C3=B3f <timur.kristof@g=
mail.com> wrote:
>
> The dce100_validate_global function was verbatim exactly the
> same as dce60_validate_global and dce80_validate_global.
>
> Share dce100_validate_global between DCE6-10 to save code size.
>
> Signed-off-by: Timur Krist=C3=B3f <timur.kristof@gmail.com>

Series is:
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  .../dc/resource/dce100/dce100_resource.c      |  2 +-
>  .../dc/resource/dce100/dce100_resource.h      |  4 +++
>  .../dc/resource/dce60/dce60_resource.c        | 32 +------------------
>  .../dc/resource/dce80/dce80_resource.c        | 32 +------------------
>  4 files changed, 7 insertions(+), 63 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/display/dc/resource/dce100/dce100_resour=
ce.c b/drivers/gpu/drm/amd/display/dc/resource/dce100/dce100_resource.c
> index 6421a56ffd23..c4b4dc3ad8c9 100644
> --- a/drivers/gpu/drm/amd/display/dc/resource/dce100/dce100_resource.c
> +++ b/drivers/gpu/drm/amd/display/dc/resource/dce100/dce100_resource.c
> @@ -898,7 +898,7 @@ static bool dce100_validate_surface_sets(
>         return true;
>  }
>
> -static enum dc_status dce100_validate_global(
> +enum dc_status dce100_validate_global(
>                 struct dc  *dc,
>                 struct dc_state *context)
>  {
> diff --git a/drivers/gpu/drm/amd/display/dc/resource/dce100/dce100_resour=
ce.h b/drivers/gpu/drm/amd/display/dc/resource/dce100/dce100_resource.h
> index 08e045601a77..dd150a4b4610 100644
> --- a/drivers/gpu/drm/amd/display/dc/resource/dce100/dce100_resource.h
> +++ b/drivers/gpu/drm/amd/display/dc/resource/dce100/dce100_resource.h
> @@ -41,6 +41,10 @@ struct resource_pool *dce100_create_resource_pool(
>
>  enum dc_status dce100_validate_plane(const struct dc_plane_state *plane_=
state, struct dc_caps *caps);
>
> +enum dc_status dce100_validate_global(
> +               struct dc  *dc,
> +               struct dc_state *context);
> +
>  enum dc_status dce100_validate_bandwidth(
>                 struct dc  *dc,
>                 struct dc_state *context,
> diff --git a/drivers/gpu/drm/amd/display/dc/resource/dce60/dce60_resource=
.c b/drivers/gpu/drm/amd/display/dc/resource/dce60/dce60_resource.c
> index 61ad3703461e..53c67ebe779f 100644
> --- a/drivers/gpu/drm/amd/display/dc/resource/dce60/dce60_resource.c
> +++ b/drivers/gpu/drm/amd/display/dc/resource/dce60/dce60_resource.c
> @@ -864,36 +864,6 @@ static void dce60_resource_destruct(struct dce110_re=
source_pool *pool)
>         }
>  }
>
> -static bool dce60_validate_surface_sets(
> -               struct dc_state *context)
> -{
> -       int i;
> -
> -       for (i =3D 0; i < context->stream_count; i++) {
> -               if (context->stream_status[i].plane_count =3D=3D 0)
> -                       continue;
> -
> -               if (context->stream_status[i].plane_count > 1)
> -                       return false;
> -
> -               if (context->stream_status[i].plane_states[0]->format
> -                               >=3D SURFACE_PIXEL_FORMAT_VIDEO_BEGIN)
> -                       return false;
> -       }
> -
> -       return true;
> -}
> -
> -static enum dc_status dce60_validate_global(
> -               struct dc *dc,
> -               struct dc_state *context)
> -{
> -       if (!dce60_validate_surface_sets(context))
> -               return DC_FAIL_SURFACE_VALIDATE;
> -
> -       return DC_OK;
> -}
> -
>  static void dce60_destroy_resource_pool(struct resource_pool **pool)
>  {
>         struct dce110_resource_pool *dce110_pool =3D TO_DCE110_RES_POOL(*=
pool);
> @@ -910,7 +880,7 @@ static const struct resource_funcs dce60_res_pool_fun=
cs =3D {
>         .validate_bandwidth =3D dce100_validate_bandwidth,
>         .validate_plane =3D dce100_validate_plane,
>         .add_stream_to_ctx =3D dce100_add_stream_to_ctx,
> -       .validate_global =3D dce60_validate_global,
> +       .validate_global =3D dce100_validate_global,
>         .find_first_free_match_stream_enc_for_link =3D dce100_find_first_=
free_match_stream_enc_for_link
>  };
>
> diff --git a/drivers/gpu/drm/amd/display/dc/resource/dce80/dce80_resource=
.c b/drivers/gpu/drm/amd/display/dc/resource/dce80/dce80_resource.c
> index 0c9a39bf7ff4..5b7769745202 100644
> --- a/drivers/gpu/drm/amd/display/dc/resource/dce80/dce80_resource.c
> +++ b/drivers/gpu/drm/amd/display/dc/resource/dce80/dce80_resource.c
> @@ -870,36 +870,6 @@ static void dce80_resource_destruct(struct dce110_re=
source_pool *pool)
>         }
>  }
>
> -static bool dce80_validate_surface_sets(
> -               struct dc_state *context)
> -{
> -       int i;
> -
> -       for (i =3D 0; i < context->stream_count; i++) {
> -               if (context->stream_status[i].plane_count =3D=3D 0)
> -                       continue;
> -
> -               if (context->stream_status[i].plane_count > 1)
> -                       return false;
> -
> -               if (context->stream_status[i].plane_states[0]->format
> -                               >=3D SURFACE_PIXEL_FORMAT_VIDEO_BEGIN)
> -                       return false;
> -       }
> -
> -       return true;
> -}
> -
> -static enum dc_status dce80_validate_global(
> -               struct dc *dc,
> -               struct dc_state *context)
> -{
> -       if (!dce80_validate_surface_sets(context))
> -               return DC_FAIL_SURFACE_VALIDATE;
> -
> -       return DC_OK;
> -}
> -
>  static void dce80_destroy_resource_pool(struct resource_pool **pool)
>  {
>         struct dce110_resource_pool *dce110_pool =3D TO_DCE110_RES_POOL(*=
pool);
> @@ -916,7 +886,7 @@ static const struct resource_funcs dce80_res_pool_fun=
cs =3D {
>         .validate_bandwidth =3D dce100_validate_bandwidth,
>         .validate_plane =3D dce100_validate_plane,
>         .add_stream_to_ctx =3D dce100_add_stream_to_ctx,
> -       .validate_global =3D dce80_validate_global,
> +       .validate_global =3D dce100_validate_global,
>         .find_first_free_match_stream_enc_for_link =3D dce100_find_first_=
free_match_stream_enc_for_link
>  };
>
> --
> 2.51.0
>
