Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 591ABC43334
	for <amd-gfx@archiver.kernel.org>; Mon, 18 Jul 2022 18:58:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 058FF10EE4E;
	Mon, 18 Jul 2022 18:58:16 +0000 (UTC)
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com
 [IPv6:2a00:1450:4864:20::629])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 77D1D10EDC6
 for <amd-gfx@lists.freedesktop.org>; Mon, 18 Jul 2022 18:58:14 +0000 (UTC)
Received: by mail-ej1-x629.google.com with SMTP id os14so23033682ejb.4
 for <amd-gfx@lists.freedesktop.org>; Mon, 18 Jul 2022 11:58:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=YJp7ilSb6kT/3WBh9tR0qEa7Yi6wac44X2vJ5o/PvJA=;
 b=BJvyQLG2ET3Kz3DwNbE9PHvH1BwlyNdSGVR6u9DG5vyqZpefBKoEP+GKLU3oTZz/ob
 ggmLrDgD/Yp34B5CtnHAJcVvp6kI+oLyRnufPT/xJC+Aq78sHfhqirBZDiyKn0UXg/fC
 Be6b41LheJqU3tQxXt/XHyBatC1z8+mlVkjLg5RfzoNd4sHf5vRwuX5j1VAIFXYui3oh
 97Mf4lKvTBrqOe2VyeT6ZM330aPMc9lxFG2An9mpFIs6Ux4Yg2behw87gp6yXni2ztBh
 R6nCg+irH9j2LGj7+4k+w/UpdsxjiFFvsKwow1NO5/zWfZC5yIvcxFULTaVexZir8vPj
 EZqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=YJp7ilSb6kT/3WBh9tR0qEa7Yi6wac44X2vJ5o/PvJA=;
 b=0Djs2EpW4XRr3ijjfAOvxLlG9RfiQWd5gphY5rLX/tWrZqPJdapHkAPB5CvhFJ+uhv
 htfHEuq1joRveFPf0j7QVVVuhFwwpnY7HqQpscccMk/Elj8u8GN4vC4Xhl9+9gzNzVdt
 kY+s8zqX+FHrJYNL2/fv1R/gl1Z0ClCfeiAT/Z6NvGkaZlPqguolUOe0ltQLcnyvF3sU
 7TkezS44ALTAlJfaSamCebdQJPVRiks1jTE0j2Ihs0j95ptBl1YdhRqsUaVb65BZNU4e
 u/nHTFZ61284x2QdyTa70Fr6rMKELA65Yt2ivqvuWrp2H1wfmxgGSINZAaGNikTfwu5M
 paAg==
X-Gm-Message-State: AJIora/a4+OWKDoFBkyfRotXT4NXFFwLgBEcadYBtI9xI8qwHm/K1qvV
 Y6hMJ9BQ2VdWI1E/j6vTwzdR3WhfTaT6OdWMFdc=
X-Google-Smtp-Source: AGRyM1tMe/WOUToEyh8jrHhnMWm4mX9DfjEJeuooP+YpMuft7LiHvq6a31gJRHOFpv5bdvkJDOKdlVMwaR+X4lvUDKQ=
X-Received: by 2002:a17:906:4fc5:b0:72b:9943:6f10 with SMTP id
 i5-20020a1709064fc500b0072b99436f10mr27335370ejw.722.1658170693029; Mon, 18
 Jul 2022 11:58:13 -0700 (PDT)
MIME-Version: 1.0
References: <20220714164507.561751-1-mairacanal@riseup.net>
 <20220714164507.561751-7-mairacanal@riseup.net>
In-Reply-To: <20220714164507.561751-7-mairacanal@riseup.net>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 18 Jul 2022 14:58:01 -0400
Message-ID: <CADnq5_NAPXuN0isLCXn800fdSOxSHWUyL7k-3BJRiL6zV_dGNg@mail.gmail.com>
Subject: Re: [PATCH 07/12] drm/amd/display: Remove unused value0 variable
To: =?UTF-8?B?TWHDrXJhIENhbmFs?= <mairacanal@riseup.net>, 
 "Wentland, Harry" <Harry.Wentland@amd.com>
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
 Christian Koenig <christian.koenig@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Thu, Jul 14, 2022 at 12:46 PM Ma=C3=ADra Canal <mairacanal@riseup.net> w=
rote:
>
> Remove the variable value0 from the function
> dcn10_link_encoder_update_mst_stream_allocation_table.
>
> This was pointed by clang with the following warning:
>
> drivers/gpu/drm/amd/amdgpu/../display/dc/dcn10/dcn10_link_encoder.c:1223:=
11:
> warning: variable 'value0' set but not used [-Wunused-but-set-variable]
>         uint32_t value0 =3D 0;
>                  ^
> 1 warning generated.
>
> Signed-off-by: Ma=C3=ADra Canal <mairacanal@riseup.net>
> ---
>  drivers/gpu/drm/amd/display/dc/dcn10/dcn10_link_encoder.c | 3 ---
>  1 file changed, 3 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_link_encoder.c b/=
drivers/gpu/drm/amd/display/dc/dcn10/dcn10_link_encoder.c
> index fbccb7263ad2..ea7d89bc293f 100644
> --- a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_link_encoder.c
> +++ b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_link_encoder.c
> @@ -1220,7 +1220,6 @@ void dcn10_link_encoder_update_mst_stream_allocatio=
n_table(
>         const struct link_mst_stream_allocation_table *table)
>  {
>         struct dcn10_link_encoder *enc10 =3D TO_DCN10_LINK_ENC(enc);
> -       uint32_t value0 =3D 0;
>         uint32_t value1 =3D 0;
>         uint32_t value2 =3D 0;
>         uint32_t slots =3D 0;
> @@ -1322,8 +1321,6 @@ void dcn10_link_encoder_update_mst_stream_allocatio=
n_table(
>         do {
>                 udelay(10);
>
> -               value0 =3D REG_READ(DP_MSE_SAT_UPDATE);
> -

There may be a reason to actually read the register here.  @Wentland, Harry=
?

>                 REG_GET(DP_MSE_SAT_UPDATE,
>                                 DP_MSE_SAT_UPDATE, &value1);
>
> --
> 2.36.1
>
