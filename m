Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1CD9C43334
	for <amd-gfx@archiver.kernel.org>; Mon, 18 Jul 2022 18:57:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B8AF610ED53;
	Mon, 18 Jul 2022 18:57:08 +0000 (UTC)
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com
 [IPv6:2a00:1450:4864:20::62e])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 20C2210ED53
 for <amd-gfx@lists.freedesktop.org>; Mon, 18 Jul 2022 18:57:06 +0000 (UTC)
Received: by mail-ej1-x62e.google.com with SMTP id l23so23010662ejr.5
 for <amd-gfx@lists.freedesktop.org>; Mon, 18 Jul 2022 11:57:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=WZXpZ/tYpTqlCSH3GDX1rZAVdQ9fECIobFONSn4ByKI=;
 b=g0hWCjPpda6RXQ1d9d/Ow1Oez/us8lwimWdhh3O2HaxgNvR6YKkUidnHyotu+FCVfx
 ojgJDfYXGx5UZEvIkdp15/GigFWPGigsNV1mCaqigoeEDLLCPydWA5dXa8JBVLImKpVq
 YUucsyDPBQ/MJC3E5Z3rPQ7orbszNZSobn5tt6KuG/1RwhFegbcKnzTQVlw2XgFSXxtB
 L8jtiM0m/2FxBVtqPvGVeDq+mZ5kOEtZbpez4AE0kB3p2uIdRI+27KkpFrjelcBvvFwC
 iCBZHkmF6TvX12cTL4oFO91Ttww2y0nH95W4BOgXF9h3SzQbmI95o5T8e6gG3YBh9wB1
 SUVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=WZXpZ/tYpTqlCSH3GDX1rZAVdQ9fECIobFONSn4ByKI=;
 b=F0uU2VKjMcW54nvmQmdYnehRf6nVNyw0dpRT7kanMMbmMM4fueS/MwnD+DzCNFqlh9
 7V3rS4TphzXadzoop/FoB6Xu+rmFwB6SPVcTfPM8zKR9IcV57FA5b2TLKuL5kRcbbVV7
 eniYU5JFTBzCTxFGbuzty6d0qtl+PcoNdrCidFyFhjoeYCIY42qR+0Vn0JP9sOi0PuYm
 Jw8hriJEwugibgfrCjsiPmKdmZtOuw8rvvcGOE5uuD+peIbsLINJLNskn6ACGNWxXVPi
 Sn565ESxYi6TF6vG4RbdpmMBNJr0shNHPFRPEyKU12wseIOwLR5Px6csPSeClFt/xhDb
 Ie+Q==
X-Gm-Message-State: AJIora9/ZtNXvF+LqHfbg/OhWyQBwjAzj0Zk3zy8ZI8Kr2H28ft/aV3P
 Zx7o62qxX2KAVlO72ggs4YvR2jKnBMmoghLeqpU=
X-Google-Smtp-Source: AGRyM1sj4G5z9Hw+W+6M+vPkPDxGGRHId03eqr1q+1C+mwNZUlZ3gCF0zqoU66jf0BAEq7YFfL5jDk/Ma7mk9Vcs1Nk=
X-Received: by 2002:a17:906:9751:b0:72f:1b36:e1de with SMTP id
 o17-20020a170906975100b0072f1b36e1demr10889601ejy.451.1658170624607; Mon, 18
 Jul 2022 11:57:04 -0700 (PDT)
MIME-Version: 1.0
References: <20220714164507.561751-1-mairacanal@riseup.net>
 <20220714164507.561751-6-mairacanal@riseup.net>
In-Reply-To: <20220714164507.561751-6-mairacanal@riseup.net>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 18 Jul 2022 14:56:53 -0400
Message-ID: <CADnq5_N8DLrfcp6xsrXT6Ch8MSfeHcPb+pgKEYYBeaXdvVTctQ@mail.gmail.com>
Subject: Re: [PATCH 06/12] drm/amd/display: Remove unused variables from
 dml_rq_dlg_get_dlg_params
To: =?UTF-8?B?TWHDrXJhIENhbmFs?= <mairacanal@riseup.net>
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
Cc: Magali Lemes <magalilemes00@gmail.com>, Leo Li <sunpeng.li@amd.com>,
 Tales Lelo da Aparecida <tales.aparecida@gmail.com>,
 xinhui pan <Xinhui.Pan@amd.com>, Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
 LKML <linux-kernel@vger.kernel.org>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>,
 Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>,
 Melissa Wen <mwen@igalia.com>, David Airlie <airlied@linux.ie>,
 Dmytro Laktyushkin <Dmytro.Laktyushkin@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Daniel Vetter <daniel@ffwll.ch>,
 Alex Deucher <alexander.deucher@amd.com>,
 Isabella Basso <isabbasso@riseup.net>, andrealmeid@riseup.net,
 Harry Wentland <harry.wentland@amd.com>,
 Christian Koenig <christian.koenig@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Applied.  Thanks!

Alex

On Thu, Jul 14, 2022 at 12:46 PM Ma=C3=ADra Canal <mairacanal@riseup.net> w=
rote:
>
> Remove the variables dispclk_delay_subtotal and dppclk_delay_subtotal fro=
m
> the function dml_rq_dlg_get_dlg_params.
>
> This was pointed by clang with the following warning:
>
> drivers/gpu/drm/amd/amdgpu/../display/dc/dml/dcn31/display_rq_dlg_calc_31=
.c:920:15:
> warning: variable 'dispclk_delay_subtotal' set but not used [-Wunused-but=
-set-variable]
>         unsigned int dispclk_delay_subtotal;
>                      ^
> drivers/gpu/drm/amd/amdgpu/../display/dc/dml/dcn31/display_rq_dlg_calc_31=
.c:919:15:
> warning: variable 'dppclk_delay_subtotal' set but not used [-Wunused-but-=
set-variable]
>         unsigned int dppclk_delay_subtotal;
>                      ^
> 2 warnings generated.
>
> Signed-off-by: Ma=C3=ADra Canal <mairacanal@riseup.net>
> ---
>  .../dc/dml/dcn31/display_rq_dlg_calc_31.c     | 19 -------------------
>  1 file changed, 19 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn31/display_rq_dlg_calc=
_31.c b/drivers/gpu/drm/amd/display/dc/dml/dcn31/display_rq_dlg_calc_31.c
> index c94cf6e01e25..66b82e4f05c6 100644
> --- a/drivers/gpu/drm/amd/display/dc/dml/dcn31/display_rq_dlg_calc_31.c
> +++ b/drivers/gpu/drm/amd/display/dc/dml/dcn31/display_rq_dlg_calc_31.c
> @@ -866,7 +866,6 @@ static void dml_rq_dlg_get_dlg_params(
>  {
>         const display_pipe_source_params_st *src =3D &e2e_pipe_param[pipe=
_idx].pipe.src;
>         const display_pipe_dest_params_st *dst =3D &e2e_pipe_param[pipe_i=
dx].pipe.dest;
> -       const display_output_params_st *dout =3D &e2e_pipe_param[pipe_idx=
].dout;
>         const display_clocks_and_cfg_st *clks =3D &e2e_pipe_param[pipe_id=
x].clks_cfg;
>         const scaler_ratio_depth_st *scl =3D &e2e_pipe_param[pipe_idx].pi=
pe.scale_ratio_depth;
>         const scaler_taps_st *taps =3D &e2e_pipe_param[pipe_idx].pipe.sca=
le_taps;
> @@ -916,9 +915,6 @@ static void dml_rq_dlg_get_dlg_params(
>         unsigned int vupdate_width;
>         unsigned int vready_offset;
>
> -       unsigned int dppclk_delay_subtotal;
> -       unsigned int dispclk_delay_subtotal;
> -
>         unsigned int vstartup_start;
>         unsigned int dst_x_after_scaler;
>         unsigned int dst_y_after_scaler;
> @@ -1037,21 +1033,6 @@ static void dml_rq_dlg_get_dlg_params(
>         vupdate_width =3D dst->vupdate_width;
>         vready_offset =3D dst->vready_offset;
>
> -       dppclk_delay_subtotal =3D mode_lib->ip.dppclk_delay_subtotal;
> -       dispclk_delay_subtotal =3D mode_lib->ip.dispclk_delay_subtotal;
> -
> -       if (scl_enable)
> -               dppclk_delay_subtotal +=3D mode_lib->ip.dppclk_delay_scl;
> -       else
> -               dppclk_delay_subtotal +=3D mode_lib->ip.dppclk_delay_scl_=
lb_only;
> -
> -       dppclk_delay_subtotal +=3D mode_lib->ip.dppclk_delay_cnvc_formatt=
er + src->num_cursors * mode_lib->ip.dppclk_delay_cnvc_cursor;
> -
> -       if (dout->dsc_enable) {
> -               double dsc_delay =3D get_dsc_delay(mode_lib, e2e_pipe_par=
am, num_pipes, pipe_idx); // FROM VBA
> -               dispclk_delay_subtotal +=3D dsc_delay;
> -       }
> -
>         vstartup_start =3D dst->vstartup_start;
>         if (interlaced) {
>                 if (vstartup_start / 2.0 - (double) (vready_offset + vupd=
ate_width + vupdate_offset) / htotal <=3D vblank_end / 2.0)
> --
> 2.36.1
>
