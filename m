Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7BC50CE79CE
	for <amd-gfx@archiver.kernel.org>; Wed, 20 Sep 2023 13:55:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F05A910E4B8;
	Wed, 20 Sep 2023 13:55:23 +0000 (UTC)
Received: from mail-oo1-xc2d.google.com (mail-oo1-xc2d.google.com
 [IPv6:2607:f8b0:4864:20::c2d])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1236610E4B8
 for <amd-gfx@lists.freedesktop.org>; Wed, 20 Sep 2023 13:55:22 +0000 (UTC)
Received: by mail-oo1-xc2d.google.com with SMTP id
 006d021491bc7-57128297bd7so4303214eaf.0
 for <amd-gfx@lists.freedesktop.org>; Wed, 20 Sep 2023 06:55:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1695218121; x=1695822921; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0jOQVzbz1ytFj595zzqYW7MN/IdkkAzKdvmVrAhjQG4=;
 b=Dx4G1wUDVJW+C3UonDmIC4MOq9j++3msjJIAVTDbSu2KsIGU9nHv1lr6IrCbSVKkPl
 cqmTUokCF8jX2ADxRnWfxRBgLBRrINPbw/2PUgmqtQO2apoP6YQJaUXNUKzAQ2US0ExA
 f2Cwj3gtlXDoA7Shv/ZwWr1WymcQJvOKurCuCmbUqFU++4b3VdrNnBEWcfiUFbybY8OG
 CqgcWmDgCKEVFZSOMyw29ZihkUKosRAQppOtNxpqJNR7D1qBtfV5YqdmWJdUXLVd9f7i
 6vNV4ZGVYMWA2Jc/XCIihIMtnOHMq7fiShXf7b0MoiL2Oam9CeH1WiLn/G8gNi5S8E+a
 NuZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695218121; x=1695822921;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=0jOQVzbz1ytFj595zzqYW7MN/IdkkAzKdvmVrAhjQG4=;
 b=Bai4hDbwiC/VVEatp0VYPzSog+SispC1UNOSjzZNy2zHvaBn1kbf1nJdDU46D0EeSV
 azm0o/lwOM3Doghg9KP5BoRHv4T8AKluwJjAVMPwLF5Ppe2Z225h1gFcvW64xwx3pv4/
 BkI/c7OKKTij0JJrKgXTmLWBeX07XHOAfCCusTqMuFD0QuaBH5v8CSiGLuiJipBwcUBW
 A+jJvsJJBugvWCo0RlSO9hNPC5qCRmZbqmHkplKfWPHlMHkU6PQ5ISKGV78i5b8nAlls
 qGA74iRUqNxxLvLryK8uYM+Li4503JcdSxNLaGZZVizQ0eQUxFKKOb+kWuemPjbsSbLy
 7Hxg==
X-Gm-Message-State: AOJu0YxZF+XKwDITzoTp1tj/CThdDxxWM4XRKeh2V4BOUvqE5pIZJsob
 i6holRzucJXO0HXEI7d/VG9Q4l6IpTxgvJuuiRc=
X-Google-Smtp-Source: AGHT+IFgbuMzwOgk1Ynpm/nXx7KA06AJh7YHISGWg6rniMzTiO4IRZOCS+X6lZZEKUMj8m5UcK2Zjj2Uo6Qxab3ztc0=
X-Received: by 2002:a05:6870:65a3:b0:1d5:5d57:bde5 with SMTP id
 fp35-20020a05687065a300b001d55d57bde5mr2562351oab.56.1695218121160; Wed, 20
 Sep 2023 06:55:21 -0700 (PDT)
MIME-Version: 1.0
References: <20230912102224.4826-1-michel@daenzer.net>
In-Reply-To: <20230912102224.4826-1-michel@daenzer.net>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 20 Sep 2023 09:55:10 -0400
Message-ID: <CADnq5_PNCDFQPa7nFeRyOpeYvm5CBTvjw61iM5qgwO0CyVhdNQ@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/display: Check all enabled planes in
 dm_check_crtc_cursor
To: =?UTF-8?Q?Michel_D=C3=A4nzer?= <michel@daenzer.net>
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
Cc: Leo Li <sunpeng.li@amd.com>, Simon Ser <contact@emersion.fr>,
 Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>, amd-gfx@lists.freedesktop.org,
 Alex Deucher <alexander.deucher@amd.com>,
 Harry Wentland <harry.wentland@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Tue, Sep 12, 2023 at 6:22=E2=80=AFAM Michel D=C3=A4nzer <michel@daenzer.=
net> wrote:
>
> From: Michel D=C3=A4nzer <mdaenzer@redhat.com>
>
> It was only checking planes which had any state changes in the same
> commit. However, it also needs to check other enabled planes.
>
> Not doing this meant that a commit might spuriously "succeed", resulting
> in the cursor plane displaying with incorrect scaling. See
> https://gitlab.gnome.org/GNOME/mutter/-/merge_requests/3177#note_1824263
> for an example.

This looks correct to me, but someone more familiar with this code
should probably double check me.
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

>
> Fixes: d1bfbe8a3202 ("amd/display: check cursor plane matches underlying =
plane")
> Signed-off-by: Michel D=C3=A4nzer <mdaenzer@redhat.com>
> ---
>  drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 14 ++++++++++++--
>  1 file changed, 12 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/=
gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> index 88ba8b66de1f..81c9d39567db 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> @@ -9836,14 +9836,24 @@ static int dm_check_crtc_cursor(struct drm_atomic=
_state *state,
>          * blending properties match the underlying planes'.
>          */
>
> -       new_cursor_state =3D drm_atomic_get_new_plane_state(state, cursor=
);
> -       if (!new_cursor_state || !new_cursor_state->fb)
> +       new_cursor_state =3D drm_atomic_get_plane_state(state, cursor);
> +       if (IS_ERR(new_cursor_state))
> +               return PTR_ERR(new_cursor_state);
> +
> +       if (!new_cursor_state->fb)
>                 return 0;
>
>         dm_get_oriented_plane_size(new_cursor_state, &cursor_src_w, &curs=
or_src_h);
>         cursor_scale_w =3D new_cursor_state->crtc_w * 1000 / cursor_src_w=
;
>         cursor_scale_h =3D new_cursor_state->crtc_h * 1000 / cursor_src_h=
;
>
> +       /* Need to check all enabled planes, even if this commit doesn't =
change
> +        * their state
> +        */
> +       i =3D drm_atomic_add_affected_planes(state, crtc);
> +       if (i)
> +               return i;
> +
>         for_each_new_plane_in_state_reverse(state, underlying, new_underl=
ying_state, i) {
>                 /* Narrow down to non-cursor planes on the same CRTC as t=
he cursor */
>                 if (new_underlying_state->crtc !=3D crtc || underlying =
=3D=3D crtc->cursor)
> --
> 2.40.1
>
