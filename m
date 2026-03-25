Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 838B4FEA80C
	for <amd-gfx@archiver.kernel.org>; Wed, 25 Mar 2026 06:11:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1BF6610E77B;
	Wed, 25 Mar 2026 06:11:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Y9HQQTBu";
	dkim-atps=neutral
Received: from mail-dl1-f42.google.com (mail-dl1-f42.google.com [74.125.82.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D70A910E77B
 for <amd-gfx@lists.freedesktop.org>; Wed, 25 Mar 2026 06:11:49 +0000 (UTC)
Received: by mail-dl1-f42.google.com with SMTP id
 a92af1059eb24-12a71ade78cso2661415c88.0
 for <amd-gfx@lists.freedesktop.org>; Tue, 24 Mar 2026 23:11:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774419109; cv=none;
 d=google.com; s=arc-20240605;
 b=i5cqvPAud18ufFsgD2SVEEHl4/U+ScgC5Ql3Rq2gq35v2TAAAqQzG4KphFb6eXiIHj
 9f0dfqKMZjQV4AcRs+SkrPLpCW4SdnsNa2VZK+mToe/NMBsxNleOGio4ZNhqsnjPhW3I
 CwDwXUVcEQxmUmDREe/7MKsffv91qNfKBf7rFVqI3FaIms+rzA56MdOYq1/CCvum4dlM
 /qZkHA8L5GXZxUfkS/x1d6QGt9pcwZ9+YqTmEe5/q4R590bAQI0GA2VBinWnI/5jIIhK
 IIlZqleDm9AjyKYpEDZsG8X8Ot/NRDBRYY1e/lT1BWHl6oIiWcxsRT/WLEmnikZQVT84
 gCvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=/I1iw0x5zzb/j/G+Vh7lwYVuTVrlTqCWoDSmpzOErZ4=;
 fh=obpz3o2CZAaoZ5cysXWJ3X+aNbXZeGTTRphE9WN2E2s=;
 b=cLrUlyY0Unc4BaOviPw2SHX8T3VmK2ehcyQ1mwkIfLPrlY2k0Bwpjc6quLOuR/xz8J
 DBhey9WGsjXZdW4KsnXh2MGgwLC46m6TnaOyLprfEmcsaugCkhIBiYD+Q45jw8a+KGZ/
 yjRtImHiXQTpFuNxgsGP62OsTsXNRMUP9GbhkiJ8TzNRMEWqMnlshdpiwqJ/ZdSdGCT4
 TbYs9trWgM8/BNfqq+cGigXSmdqERMac6zS1rJlPP/+dlvsW7QTu6MgHv8xdA+Yy6zGo
 qChXVDP95MqtL6YU4M/X0gIMpwt/DaaQIz2poLSL4H0BetMU3gv7g8nt/CuKJOvI8/13
 UNeA==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1774419109; x=1775023909; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/I1iw0x5zzb/j/G+Vh7lwYVuTVrlTqCWoDSmpzOErZ4=;
 b=Y9HQQTBufHBSW5l+KoZBOH7wzDOKxdxw71o4Dwtz8MscRmWc65RKoYq1cYskKFpGtc
 t6VU2jkfOb7NOFAwNzjJTIgGiUWKddt82l67s3+xWURg0xXDEiWQj7iQ3pDbSi6tAExW
 E1ySv6RQmfmN0A4fSUdAM5JSsQTplGh4Vc53Doo+XcluNTrynJBZKR/50hc3PmGo7637
 Nh0b6TkqC1ZgoIGnsJ4sGVdO+06hpMIEWuAuucZS+JKv+Wq34d5TGNnW2g0dz/Dp1XvO
 etKJDntCENYjw6roN2LwwGdJ9fsLMKx9VbN6fbwNLdApZnvd9b4X14cuMTi9E1dH18vF
 3cqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774419109; x=1775023909;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=/I1iw0x5zzb/j/G+Vh7lwYVuTVrlTqCWoDSmpzOErZ4=;
 b=WGV863KimFkuTjur6rzPioyYVo3VokmZyVfcWVlun/LnzKUQ0uIXAescUQ4dJ3DgUW
 1fO2NyBmgbty1z6483n4Bhkg6JPO18ykRpekJaNNZb3T+lRCeOF6JTH3ELWrdnjDNEUe
 Lop6tvsdFV8JS0gK5Bv7B+V+isAZu6i1CAEm55xwguQa+FotiIczdzfjw+oEg2FGxGs1
 sGji0t2ae6ROkN/bVq2iJR/tRUqnhJFFi8svvLfWyS1MKzLUnrIBwgI1sVVTLJxPX2yC
 dhZREl2Y1d3MneH+9YqTgG2CwwOj8VSkzob6l2h1aBAIaVZnoT2XvV+dmKfm7nEvFWo6
 8P5A==
X-Gm-Message-State: AOJu0YxCii+SXU92MEAkTb0Szig8YNxzgbpH9Q03+vlBJm2M5LnaJcRU
 Gt4m0sr6B787UrCfsLwUo/hsndtoT3/M8v94n6lhlxhdgVIDDj5x6IZJftBCbS3VRP+QBK/NcfP
 Ja/uRbwT25yqNdMShWCuJOiErUtybb4E=
X-Gm-Gg: ATEYQzwQWqGVWiU0LxF7R4f98pbc0o+s+tzwhkfZgYOQsBSpMO1lzVud2gtovlgfgJ7
 5DR0QkE1cVSoTdiaRCxeWGrm1ixk34FVNU4+T6wv74ZdsAlfkfGFnkrm5UsT7pQCUE/UuL1fLXN
 HHcsaRPqXT8MoKNKPvvjGjckRMHaN/tpJj51Yuf3gaPdrE+RW10jFZJ//31E9YWat6Kbq179bMX
 Wg6AFx1HAxSkhyUFB/aChCElXyJH2FVjgPGi9W4B95MtBdAuHpz1uuqtLa1BhAaNqw9ZalLadUt
 1WV0uUVOqUuZDQh1k1wo5by7Wpe7kQoFCKKpEoww
X-Received: by 2002:a05:7022:618b:b0:12a:6a64:81d9 with SMTP id
 a92af1059eb24-12a96e5d601mr979349c88.13.1774419108994; Tue, 24 Mar 2026
 23:11:48 -0700 (PDT)
MIME-Version: 1.0
References: <CAEsyxyiCN6KmyDBGZBJYKv+wt6w6j5QdUfTa1zJojAQ20V84xg@mail.gmail.com>
 <20260324210447.541630-2-harry.wentland@amd.com>
In-Reply-To: <20260324210447.541630-2-harry.wentland@amd.com>
From: Mario Kleiner <mario.kleiner.de@gmail.com>
Date: Wed, 25 Mar 2026 07:11:12 +0100
X-Gm-Features: AaiRm514z5g35jkG4fcuHJiHckGOgOEsHrWlkPV22PVK-mmT9QZPCmMbz8-9wv8
Message-ID: <CAEsyxygVih+pbQiq6wcPusiTAHvunc68wo1pg2NU+OgwvUwP1w@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/display: Dither when plane bpc is higher than
 output bpc
To: Harry Wentland <harry.wentland@amd.com>
Cc: amd-gfx@lists.freedesktop.org, 
 "Kovac, Krunoslav" <Krunoslav.Kovac@amd.com>, "Hung, Alex" <Alex.Hung@amd.com>,
 "Deucher, Alexander" <Alexander.Deucher@amd.com>
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

Hi Harry,

Thanks for taking a stab at this!

I agree that your patch would be a good solution. And my review
suggested the code looked correct, but unfortunately in my testing on
my laptop with Polaris11 for the 8 bpc input fb + 8 bpc output on the
eDP panel of my laptop, the machine disagreed. It always gives me
dithering for my XRGB8888 aka 8 bpc input fb to my 8 bpc
COLOR_DEPTH_888 output. I'm visiting my parents atm., and therefore
don't have access to the 10 bpc DP monitor for output 10 bpc testing,
but at least the 8 bpc laptop panel is no success.

Reason is that max_plane_bpp =3D get_max_input_bpc_for_stream(dc,
stream); is reported as 0, so it hits the if (max_plane_bpp =3D=3D 0 ||
...) condition and triggers DITHER_OPTION_SPATIAL8 when it should
choose the else branch with DITHER_OPTION_TRUN8.

Reason for get_max_input_bpc_for_stream() reporting 0 is that for the
only active pipe (with index i =3D=3D 0) in
dc->current_state->res_ctx.pipe_ctx[i], the pipe->stream !=3D stream
condition is true, so the whole maximum finding logic gets skipped.
Added debug statements showed that pipe->stream from res_ctx never
matches the stream pointer passed into
resource_build_bit_depth_reduction_params(). So something is amiss
there.

dc->current_state->res_ctx.pipe_ctx[0]->stream matches what the passed
in stream was during early amdgpu driver init during boot, but during
later bootup, login and session, the passed in stream pointer changes
multiple times but never matches pipe->stream.

Apart from that, style-wise it would probably make sense to rename
max_plane_bpp into max_plane_bpc for consistency?

And ideally we'd add...

Fixes: d5df648ec830 ("drm/amd/display: Change dither policy for 10bpc to ro=
und")
Cc: stable@vger.kernel.org

I hope getting this into drm-fixes for upcoming Linux 7.0 would still
be possible, as that will be the standard distribution kernel for
upcoming Ubuntu 26.04-LTS, Fedora 44 and other spring 2026
distribution updates, which will also ship with enhanced Mesa 26.0 and
GNOME mutter 50, both improved to make good use of 16 bpc framebuffers
on AMD hw.

Thanks
-mario


On Tue, Mar 24, 2026 at 10:06=E2=80=AFPM Harry Wentland <harry.wentland@amd=
.com> wrote:
>
> We don't want to dither when a 10bpc buffer is output on a 10bpc
> connection as we'd get off-by-one errors. But we do want to dither
> if we have planes with a higher bit depth.
>
> In order to solve this, look at all planes, and pick TRUN dither
> when input bit depth doesn't exceed output bit depth, otherwise
> pick SPATIAL.
>
> Cc: Kovac, Krunoslav <Krunoslav.Kovac@amd.com>
> Cc: Hung, Alex <Alex.Hung@amd.com>
> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>
> Reported-by: Mario Kleiner <mario.kleiner.de@gmail.com>
> Signed-off-by: Harry Wentland <harry.wentland@amd.com>
> ---
>
> Mario, Kruno,
>
> this patch looks at planes and picks dither based on the max
> bit depth of all planes on the stream. Would this work for
> both of you?
>
> I've only made sure my Rembrandt system boots with this but
> haven't been able to confirm that the correct dither mode is
> selected.
>
> Harry
>
>  drivers/gpu/drm/amd/display/dc/core/dc.c      |   5 +-
>  .../drm/amd/display/dc/core/dc_hw_sequencer.c |   3 +-
>  .../gpu/drm/amd/display/dc/core/dc_resource.c | 110 +++++++++++++++++-
>  drivers/gpu/drm/amd/display/dc/inc/resource.h |   3 +-
>  .../display/dc/link/accessories/link_dp_cts.c |   3 +-
>  .../dc/resource/dce110/dce110_resource.c      |   3 +-
>  .../dc/resource/dcn10/dcn10_resource.c        |   3 +-
>  .../dc/resource/dcn20/dcn20_resource.c        |   3 +-
>  8 files changed, 122 insertions(+), 11 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/a=
md/display/dc/core/dc.c
> index 8b21816cf7c8..56d6f9d2fcca 100644
> --- a/drivers/gpu/drm/amd/display/dc/core/dc.c
> +++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
> @@ -788,7 +788,7 @@ void dc_stream_set_dither_option(struct dc_stream_sta=
te *stream,
>         stream->dither_option =3D option;
>
>         memset(&params, 0, sizeof(params));
> -       resource_build_bit_depth_reduction_params(stream, &params);
> +       resource_build_bit_depth_reduction_params(stream, &params, stream=
->ctx->dc);
>         stream->bit_depth_params =3D params;
>
>         if (pipes->plane_res.xfm &&
> @@ -3841,7 +3841,8 @@ static void commit_planes_do_stream_update(struct d=
c *dc,
>                         if (stream_update->dither_option) {
>                                 struct pipe_ctx *odm_pipe =3D pipe_ctx->n=
ext_odm_pipe;
>                                 resource_build_bit_depth_reduction_params=
(pipe_ctx->stream,
> -                                                                       &=
pipe_ctx->stream->bit_depth_params);
> +                                                                       &=
pipe_ctx->stream->bit_depth_params,
> +                                                                       p=
ipe_ctx->stream->ctx->dc);
>                                 pipe_ctx->stream_res.opp->funcs->opp_prog=
ram_fmt(pipe_ctx->stream_res.opp,
>                                                 &stream->bit_depth_params=
,
>                                                 &stream->clamping);
> diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_hw_sequencer.c b/driv=
ers/gpu/drm/amd/display/dc/core/dc_hw_sequencer.c
> index 5b3695e72e19..a042b31b57ba 100644
> --- a/drivers/gpu/drm/amd/display/dc/core/dc_hw_sequencer.c
> +++ b/drivers/gpu/drm/amd/display/dc/core/dc_hw_sequencer.c
> @@ -2485,7 +2485,8 @@ void hwss_opp_program_bit_depth_reduction(union blo=
ck_sequence_params *params)
>         if (use_default_params)
>                 memset(&bit_depth_params, 0, sizeof(bit_depth_params));
>         else
> -               resource_build_bit_depth_reduction_params(pipe_ctx->strea=
m, &bit_depth_params);
> +               resource_build_bit_depth_reduction_params(pipe_ctx->strea=
m,
> +                       &bit_depth_params, pipe_ctx->stream->ctx->dc);
>
>         if (opp->funcs->opp_program_bit_depth_reduction)
>                 opp->funcs->opp_program_bit_depth_reduction(opp, &bit_dep=
th_params);
> diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c b/drivers/=
gpu/drm/amd/display/dc/core/dc_resource.c
> index 8271b12c1a66..10b7e14ef66f 100644
> --- a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
> +++ b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
> @@ -5037,25 +5037,129 @@ bool pipe_need_reprogram(
>         return false;
>  }
>
> +/**
> + * get_bit_depth_from_surface_pixel_format - Get effective bit depth fro=
m surface format
> + * @format: Surface pixel format
> + *
> + * Returns the effective bit depth per channel for the given surface for=
mat.
> + * This is used to determine if input precision is higher than output pr=
ecision
> + * for dithering decisions.
> + *
> + * Return: Bits per channel (6, 8, 10, 12, or 16)
> + */
> +static unsigned int get_bit_depth_from_surface_pixel_format(enum surface=
_pixel_format format)
> +{
> +       switch (format) {
> +       case SURFACE_PIXEL_FORMAT_GRPH_PALETA_256_COLORS:
> +               return 8;
> +       case SURFACE_PIXEL_FORMAT_GRPH_ARGB1555:
> +               return 5; /* 5 bits per channel */
> +       case SURFACE_PIXEL_FORMAT_GRPH_RGB565:
> +               return 6;
> +       case SURFACE_PIXEL_FORMAT_GRPH_ARGB8888:
> +       case SURFACE_PIXEL_FORMAT_GRPH_ABGR8888:
> +       case SURFACE_PIXEL_FORMAT_VIDEO_420_YCbCr:
> +       case SURFACE_PIXEL_FORMAT_VIDEO_420_YCrCb:
> +               return 8;
> +       case SURFACE_PIXEL_FORMAT_GRPH_ARGB2101010:
> +       case SURFACE_PIXEL_FORMAT_GRPH_ABGR2101010:
> +       case SURFACE_PIXEL_FORMAT_GRPH_ABGR2101010_XR_BIAS:
> +       case SURFACE_PIXEL_FORMAT_VIDEO_420_10bpc_YCbCr:
> +       case SURFACE_PIXEL_FORMAT_VIDEO_420_10bpc_YCrCb:
> +               return 10;
> +       case SURFACE_PIXEL_FORMAT_GRPH_ARGB16161616:
> +       case SURFACE_PIXEL_FORMAT_GRPH_ABGR16161616:
> +               return 16; /* 16-bit fixed point */
> +       case SURFACE_PIXEL_FORMAT_GRPH_ARGB16161616F:
> +       case SURFACE_PIXEL_FORMAT_GRPH_ABGR16161616F:
> +               return 16; /* FP16 has higher effective precision */
> +       case SURFACE_PIXEL_FORMAT_GRPH_RGBE:
> +       case SURFACE_PIXEL_FORMAT_GRPH_RGBE_ALPHA:
> +               return 8; /* 8-bit mantissa per channel */
> +       default:
> +               return 8;
> +       }
> +}
> +
> +/**
> + * get_max_input_bpc_for_stream - Get maximum input plane bit depth for =
a stream
> + * @dc: DC context
> + * @stream: The stream to check
> + *
> + * Iterate through all pipes in the current DC state to find planes atta=
ched
> + * to this stream, and return the maximum bit depth across all those pla=
nes.
> + * This is used to determine if spatial dithering (for higher precision =
inputs
> + * like FP16/RGBA16) or rounding (for bit-accurate matching precision li=
ke
> + * RGB10->10bpc) should be used.
> + *
> + * Returns: Maximum bits per channel across all planes for this stream,
> + *          or 0 if no planes found or no current state.
> + */
> +static unsigned int get_max_input_bpc_for_stream(const struct dc *dc,
> +                                                struct dc_stream_state *=
stream)
> +{
> +       unsigned int max_bpc =3D 0;
> +       int i;
> +
> +       if (!dc || !dc->current_state || !stream)
> +               return 0;
> +
> +       /* Iterate through all pipes to find planes for this stream */
> +       for (i =3D 0; i < MAX_PIPES; i++) {
> +               struct pipe_ctx *pipe =3D &dc->current_state->res_ctx.pip=
e_ctx[i];
> +               unsigned int plane_bpc;
> +
> +               if (!pipe->plane_state || pipe->stream !=3D stream)
> +                       continue;
> +
> +               plane_bpc =3D get_bit_depth_from_surface_pixel_format(
> +                               pipe->plane_state->format);
> +
> +               if (plane_bpc > max_bpc)
> +                       max_bpc =3D plane_bpc;
> +       }
> +
> +       return max_bpc;
> +}
> +
>  void resource_build_bit_depth_reduction_params(struct dc_stream_state *s=
tream,
> -               struct bit_depth_reduction_params *fmt_bit_depth)
> +               struct bit_depth_reduction_params *fmt_bit_depth,
> +               const struct dc *dc)
>  {
>         enum dc_dither_option option =3D stream->dither_option;
>         enum dc_pixel_encoding pixel_encoding =3D
>                         stream->timing.pixel_encoding;
> +       unsigned int max_plane_bpp;
>
>         memset(fmt_bit_depth, 0, sizeof(*fmt_bit_depth));
>
> +       /* Get max input bpc from planes attached to this stream */
> +       max_plane_bpp =3D get_max_input_bpc_for_stream(dc, stream);
> +
>         if (option =3D=3D DITHER_OPTION_DEFAULT) {
>                 switch (stream->timing.display_color_depth) {
>                 case COLOR_DEPTH_666:
>                         option =3D DITHER_OPTION_SPATIAL6;
>                         break;
>                 case COLOR_DEPTH_888:
> -                       option =3D DITHER_OPTION_SPATIAL8;
> +                       /* Use spatial dithering if we don't know plane b=
pp (0) or
> +                        * if plane precision > output precision, otherwi=
se use
> +                        * rounding/truncation for bit accuracy.
> +                        */
> +                       if (max_plane_bpp =3D=3D 0 || max_plane_bpp > 8)
> +                               option =3D DITHER_OPTION_SPATIAL8;
> +                       else
> +                               option =3D DITHER_OPTION_TRUN8;
>                         break;
>                 case COLOR_DEPTH_101010:
> -                       option =3D DITHER_OPTION_TRUN10;
> +                       /* Use spatial dithering if we don't know plane b=
pp (0) or
> +                        * if plane precision > output precision, otherwi=
se use
> +                        * rounding for bit accuracy.
> +                        */
> +                       if (max_plane_bpp =3D=3D 0 || max_plane_bpp > 10)
> +                               option =3D DITHER_OPTION_SPATIAL10;
> +                       else
> +                               option =3D DITHER_OPTION_TRUN10;
>                         break;
>                 default:
>                         option =3D DITHER_OPTION_DISABLE;
> diff --git a/drivers/gpu/drm/amd/display/dc/inc/resource.h b/drivers/gpu/=
drm/amd/display/dc/inc/resource.h
> index cecd3282a29f..2d040e735521 100644
> --- a/drivers/gpu/drm/amd/display/dc/inc/resource.h
> +++ b/drivers/gpu/drm/amd/display/dc/inc/resource.h
> @@ -591,7 +591,8 @@ bool pipe_need_reprogram(
>                 struct pipe_ctx *pipe_ctx);
>
>  void resource_build_bit_depth_reduction_params(struct dc_stream_state *s=
tream,
> -               struct bit_depth_reduction_params *fmt_bit_depth);
> +               struct bit_depth_reduction_params *fmt_bit_depth,
> +               const struct dc *dc);
>
>  void update_audio_usage(
>                 struct resource_context *res_ctx,
> diff --git a/drivers/gpu/drm/amd/display/dc/link/accessories/link_dp_cts.=
c b/drivers/gpu/drm/amd/display/dc/link/accessories/link_dp_cts.c
> index 693d852b1c40..377e02095867 100644
> --- a/drivers/gpu/drm/amd/display/dc/link/accessories/link_dp_cts.c
> +++ b/drivers/gpu/drm/amd/display/dc/link/accessories/link_dp_cts.c
> @@ -543,7 +543,8 @@ static void set_crtc_test_pattern(struct dc_link *lin=
k,
>         case DP_TEST_PATTERN_VIDEO_MODE:
>         {
>                 /* restore bitdepth reduction */
> -               resource_build_bit_depth_reduction_params(pipe_ctx->strea=
m, &params);
> +               resource_build_bit_depth_reduction_params(pipe_ctx->strea=
m, &params,
> +                       pipe_ctx->stream->ctx->dc);
>                 pipe_ctx->stream->bit_depth_params =3D params;
>                 if (pipe_ctx->stream_res.tg->funcs->set_test_pattern) {
>                         opp->funcs->opp_program_bit_depth_reduction(opp, =
&params);
> diff --git a/drivers/gpu/drm/amd/display/dc/resource/dce110/dce110_resour=
ce.c b/drivers/gpu/drm/amd/display/dc/resource/dce110/dce110_resource.c
> index 7c09825cd9bd..6433f48e9158 100644
> --- a/drivers/gpu/drm/amd/display/dc/resource/dce110/dce110_resource.c
> +++ b/drivers/gpu/drm/amd/display/dc/resource/dce110/dce110_resource.c
> @@ -928,7 +928,8 @@ void dce110_resource_build_pipe_hw_param(struct pipe_=
ctx *pipe_ctx)
>                 &pipe_ctx->stream_res.pix_clk_params,
>                 &pipe_ctx->pll_settings);
>         resource_build_bit_depth_reduction_params(pipe_ctx->stream,
> -                       &pipe_ctx->stream->bit_depth_params);
> +                       &pipe_ctx->stream->bit_depth_params,
> +                       pipe_ctx->stream->ctx->dc);
>         pipe_ctx->stream->clamping.pixel_encoding =3D pipe_ctx->stream->t=
iming.pixel_encoding;
>  }
>
> diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn10/dcn10_resource=
.c b/drivers/gpu/drm/amd/display/dc/resource/dcn10/dcn10_resource.c
> index 9c1a57a1f989..6cd16b64baae 100644
> --- a/drivers/gpu/drm/amd/display/dc/resource/dcn10/dcn10_resource.c
> +++ b/drivers/gpu/drm/amd/display/dc/resource/dcn10/dcn10_resource.c
> @@ -1042,7 +1042,8 @@ static void build_pipe_hw_param(struct pipe_ctx *pi=
pe_ctx)
>         pipe_ctx->stream->clamping.pixel_encoding =3D pipe_ctx->stream->t=
iming.pixel_encoding;
>
>         resource_build_bit_depth_reduction_params(pipe_ctx->stream,
> -                                       &pipe_ctx->stream->bit_depth_para=
ms);
> +                                       &pipe_ctx->stream->bit_depth_para=
ms,
> +                                       pipe_ctx->stream->ctx->dc);
>         build_clamping_params(pipe_ctx->stream);
>  }
>
> diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn20/dcn20_resource=
.c b/drivers/gpu/drm/amd/display/dc/resource/dcn20/dcn20_resource.c
> index b28e877fb99d..f2786bfc87c1 100644
> --- a/drivers/gpu/drm/amd/display/dc/resource/dcn20/dcn20_resource.c
> +++ b/drivers/gpu/drm/amd/display/dc/resource/dcn20/dcn20_resource.c
> @@ -1302,7 +1302,8 @@ static enum dc_status build_pipe_hw_param(struct pi=
pe_ctx *pipe_ctx)
>         pipe_ctx->stream->clamping.pixel_encoding =3D pipe_ctx->stream->t=
iming.pixel_encoding;
>
>         resource_build_bit_depth_reduction_params(pipe_ctx->stream,
> -                                       &pipe_ctx->stream->bit_depth_para=
ms);
> +                                       &pipe_ctx->stream->bit_depth_para=
ms,
> +                                       pipe_ctx->stream->ctx->dc);
>         build_clamping_params(pipe_ctx->stream);
>
>         return DC_OK;
> --
> 2.53.0
>
