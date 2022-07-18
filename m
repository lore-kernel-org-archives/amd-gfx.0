Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D59E8C43334
	for <amd-gfx@archiver.kernel.org>; Mon, 18 Jul 2022 18:52:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2E17510E961;
	Mon, 18 Jul 2022 18:52:49 +0000 (UTC)
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com
 [IPv6:2a00:1450:4864:20::62d])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 65E9410E961
 for <amd-gfx@lists.freedesktop.org>; Mon, 18 Jul 2022 18:52:48 +0000 (UTC)
Received: by mail-ej1-x62d.google.com with SMTP id ez10so22931435ejc.13
 for <amd-gfx@lists.freedesktop.org>; Mon, 18 Jul 2022 11:52:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=UXmtdUhrJat96q6rc3xCOJzu4OogdeIRqntsuTRjLRQ=;
 b=XLxe7i6ykG4WCMIYi9HZMI3sAy3BYK0lxLOgbdHHPNt31x99iY8v6kjKu/iNMP2DoN
 y1SCu1/2aLdhrfPU3erTOAcoosGqtpOeV4PpzLdw1qZEyj2phMBaoW1c2X6X/JQ1ltHu
 9hXr/uPoUsTMTxyHiEIzuEBEQlnezltMsh0xvy0IJy002TtPWUBrHa0d/aHOiwcrIjw/
 Mx4dOEMetIVD6LDDNEH5fsxXpL/ycyk7D8jHCubKX/06iYpDYnuYPOj8CrHug90v3aTc
 vqnmAN1aPZhV24t4QfYyMgmG1nGirVSeuMcPAr5rXqv57BDfRij2hwlyhHyIeG46s9eg
 dNuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=UXmtdUhrJat96q6rc3xCOJzu4OogdeIRqntsuTRjLRQ=;
 b=y3XLg52+gY/Ywb1Dg2yPp/zc9XIVtxVygXEM/qli/z3IVgvKLBzB5OGkP5LFMZZg2I
 n44kW531EIuVKwNscLK86i4BL4NZptvSpXJ4y7Zf76+tcy5QAkoBvxnK/lcaHDuTkRaw
 BT+OwADw2nDw8A+K1wz9OstFQKZ0jEyahdsRvlBnGFQjxqSlvN6ugqI7W5J0h7uzPK5R
 ynaS8TcN7BgkRLQzd5u3cIWtlvFKGEGCCS13yvksbVwZpTKaOLbEl0QM7qkprbp47P2p
 tpnk+liYazJExOeXfvchKJF4xPFD3wqgMbrqR+SM0w15TVdbX+Z41ITplX7nX7ujqr9I
 ulJA==
X-Gm-Message-State: AJIora8hMw+VYE2S6JbgBUfJ0ycgl5QtMiKp4Lubp+xpDgqJjR+Qt4Ki
 QI5Bf3sMV/jDFgRhoRGO0pBneucppwR6kVWpj5o=
X-Google-Smtp-Source: AGRyM1spfpipEO03MLUtPx4xNAYzVBWFgnXy1amuY1fxS7wlSg6Kh4maX/RyytZkZmeRURFyr433xVx45qXcMgI20jc=
X-Received: by 2002:a17:906:9751:b0:72f:1b36:e1de with SMTP id
 o17-20020a170906975100b0072f1b36e1demr10874082ejy.451.1658170366855; Mon, 18
 Jul 2022 11:52:46 -0700 (PDT)
MIME-Version: 1.0
References: <20220714164507.561751-1-mairacanal@riseup.net>
 <20220714164507.561751-2-mairacanal@riseup.net>
In-Reply-To: <20220714164507.561751-2-mairacanal@riseup.net>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 18 Jul 2022 14:52:34 -0400
Message-ID: <CADnq5_NU_m=M3QZiKAD3NsCQZExi7ffecpc0TrYz3qSFCky=dw@mail.gmail.com>
Subject: Re: [PATCH 02/12] drm/amd/display: Change get_pipe_idx function scope
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

On Thu, Jul 14, 2022 at 12:45 PM Ma=C3=ADra Canal <mairacanal@riseup.net> w=
rote:
>
> Turn previously global function into a static function as it is not used
> outside the file.
>
> Signed-off-by: Ma=C3=ADra Canal <mairacanal@riseup.net>
> ---
>  drivers/gpu/drm/amd/display/dc/dml/display_mode_vba.c | 2 +-
>  drivers/gpu/drm/amd/display/dc/dml/display_mode_vba.h | 1 -
>  2 files changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/display/dc/dml/display_mode_vba.c b/driv=
ers/gpu/drm/amd/display/dc/dml/display_mode_vba.c
> index 39f93072b5e0..c5a0a3649e9a 100644
> --- a/drivers/gpu/drm/amd/display/dc/dml/display_mode_vba.c
> +++ b/drivers/gpu/drm/amd/display/dc/dml/display_mode_vba.c
> @@ -251,7 +251,7 @@ unsigned int get_total_surface_size_in_mall_bytes(
>         return size;
>  }
>
> -unsigned int get_pipe_idx(struct display_mode_lib *mode_lib, unsigned in=
t plane_idx)
> +static unsigned int get_pipe_idx(struct display_mode_lib *mode_lib, unsi=
gned int plane_idx)
>  {
>         int pipe_idx =3D -1;
>         int i;
> diff --git a/drivers/gpu/drm/amd/display/dc/dml/display_mode_vba.h b/driv=
ers/gpu/drm/amd/display/dc/dml/display_mode_vba.h
> index 47b149d4bfcf..6e61b5382361 100644
> --- a/drivers/gpu/drm/amd/display/dc/dml/display_mode_vba.h
> +++ b/drivers/gpu/drm/amd/display/dc/dml/display_mode_vba.h
> @@ -165,7 +165,6 @@ unsigned int get_total_surface_size_in_mall_bytes(
>                 struct display_mode_lib *mode_lib,
>                 const display_e2e_pipe_params_st *pipes,
>                 unsigned int num_pipes);
> -unsigned int get_pipe_idx(struct display_mode_lib *mode_lib, unsigned in=
t plane_idx);
>
>  bool get_is_phantom_pipe(struct display_mode_lib *mode_lib,
>                 const display_e2e_pipe_params_st *pipes,
> --
> 2.36.1
>
