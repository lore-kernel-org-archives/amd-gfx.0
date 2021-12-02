Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4D15C433EF
	for <amd-gfx@archiver.kernel.org>; Thu,  2 Dec 2021 17:11:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3506E6FC40;
	Thu,  2 Dec 2021 17:11:32 +0000 (UTC)
Received: from mail-ot1-x334.google.com (mail-ot1-x334.google.com
 [IPv6:2607:f8b0:4864:20::334])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 16C7F6FC40
 for <amd-gfx@lists.freedesktop.org>; Thu,  2 Dec 2021 17:11:31 +0000 (UTC)
Received: by mail-ot1-x334.google.com with SMTP id
 n104-20020a9d2071000000b005799790cf0bso518190ota.5
 for <amd-gfx@lists.freedesktop.org>; Thu, 02 Dec 2021 09:11:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=ranTZ0uhVK7+p3eZJIfPpu3Ro8BkOXqsK6/RAboGjPw=;
 b=AgnaWpnZSOuwXCJs/bPmVWYsXYGcN0pTMUNzPLz1+fK5efhni0/jCb4iP+VTDZxRPa
 Ii9LrVg/lWGjmmhUoqY8mTH7UGUhKZJYVu1J2rT7RQArCYSyysVAiq9t/J0ko63d+8+6
 R0iwp2H45iT/OspqQeRaMFDS6Fb2zGdm4+3Uwfri56MxMSda6N9a8BBCUOdX1xJl10A4
 LFbcsevhniqU0IZ2qlX0cQY7w0f4N8ffxfatWVNCBivItyGakAAXHoJ+gJq07RJ69IQm
 D26HeV3nQC+kw2RTrDx+od/mM1l1OVGUiGgoEK7Inf9r82YDmeC7Kh3TCwIz4Al8J9CM
 JFqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=ranTZ0uhVK7+p3eZJIfPpu3Ro8BkOXqsK6/RAboGjPw=;
 b=RXruBMURyPKSv9QHbVdxoFAQFqA5hMrhxfNR07eTt9jrPFl8zIBVX4ICpq58w+VKQY
 +hS9cmwv0WOPIoYz+BY9+a9eQ9U8qhhoftLLuGnhKWO5HspeuEUzU1yDQQttt4CaCoGB
 ypRRFUDuCvM/tPfn3LJ5fVGLz/1oSkXB6edWR+oPF62BZhvVZd8TKaxOPcS7e4C06e+K
 jikhmV7TawqykyY6P1S/WogtCJq+nVq9G4Jm/DJMPyEUoZkF6QOhtXXivSyqY1inJSOl
 4YAVSijWDYOsmIY9qUd1dGpgpwMA491X4rQTGRYjxFbUmNzUURO1jE4JKztL9cKc5sWw
 qIbQ==
X-Gm-Message-State: AOAM53088OILxJVQPyGcdaw6bR28Wk/LcJrU2LK4uxqJasKsXSpxbwuW
 YY1yIFrdECJpF4ihfXEXl4i4l2LVjZhfWSLbbE4=
X-Google-Smtp-Source: ABdhPJz+H0n1u9P4yDfuEO3p7YHJCwotpy1ZVtB1anAZgyg5KtOztkHOtRIdFIF/5Sa/bvOVrhCwH/Jer6+rYUkVpwU=
X-Received: by 2002:a9d:67c1:: with SMTP id c1mr12458949otn.299.1638465090401; 
 Thu, 02 Dec 2021 09:11:30 -0800 (PST)
MIME-Version: 1.0
References: <20211202121650.2265-1-vlad.zahorodnii@kde.org>
 <20211202125215.25307-1-vlad.zahorodnii@kde.org>
 <c2560a82-a4c6-6913-dc67-d11478f46afd@amd.com>
In-Reply-To: <c2560a82-a4c6-6913-dc67-d11478f46afd@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 2 Dec 2021 12:11:19 -0500
Message-ID: <CADnq5_P2NknRtxxboccRVsqvSmY7y3f0Qqjs+xo10ymuRSoc8A@mail.gmail.com>
Subject: Re: [PATCH v2] drm/amd/display: Use oriented source size when
 checking cursor scaling
To: "Kazlauskas, Nicholas" <nicholas.kazlauskas@amd.com>
Content-Type: text/plain; charset="UTF-8"
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
Cc: Vlad Zahorodnii <vlad.zahorodnii@kde.org>, Simon Ser <contact@emersion.fr>,
 "Siqueira, Rodrigo" <Rodrigo.Siqueira@amd.com>, xaver.hugl@gmail.com,
 amd-gfx list <amd-gfx@lists.freedesktop.org>, "Deucher,
 Alexander" <alexander.deucher@amd.com>,
 Christian Koenig <christian.koenig@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Applied.  thanks!

Alex

On Thu, Dec 2, 2021 at 10:09 AM Kazlauskas, Nicholas
<nicholas.kazlauskas@amd.com> wrote:
>
> On 2021-12-02 7:52 a.m., Vlad Zahorodnii wrote:
> > dm_check_crtc_cursor() doesn't take into account plane transforms when
> > calculating plane scaling, this can result in false positives.
> >
> > For example, if there's an output with resolution 3840x2160 and the
> > output is rotated 90 degrees, CRTC_W and CRTC_H will be 3840 and 2160,
> > respectively, but SRC_W and SRC_H will be 2160 and 3840, respectively.
> >
> > Since the cursor plane usually has a square buffer attached to it, the
> > dm_check_crtc_cursor() will think that there's a scale factor mismatch
> > even though there isn't really.
> >
> > This fixes an issue where kwin fails to use hardware plane transforms.
> >
> > Changes since version 1:
> > - s/orientated/oriented/g
> >
> > Signed-off-by: Vlad Zahorodnii <vlad.zahorodnii@kde.org>
>
> This looks correct to me. I guess it's also not modifying the actual
> programming position, just the check to ensure that the cursor is going
> to be unscaled in the correct orientation.
>
> Would be good to have some IGT tests for these scaled cases to verify
> atomic check pass/fail assumptions, but for now:
>
> Reviewed-by: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
>
> Regards,
> Nicholas Kazlauskas
>
> > ---
> >   .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 35 ++++++++++++++-----
> >   1 file changed, 27 insertions(+), 8 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> > index a3c0f2e4f4c1..c009c668fbe2 100644
> > --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> > +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> > @@ -10736,6 +10736,24 @@ static int dm_update_plane_state(struct dc *dc,
> >       return ret;
> >   }
> >
> > +static void dm_get_oriented_plane_size(struct drm_plane_state *plane_state,
> > +                                    int *src_w, int *src_h)
> > +{
> > +     switch (plane_state->rotation & DRM_MODE_ROTATE_MASK) {
> > +     case DRM_MODE_ROTATE_90:
> > +     case DRM_MODE_ROTATE_270:
> > +             *src_w = plane_state->src_h >> 16;
> > +             *src_h = plane_state->src_w >> 16;
> > +             break;
> > +     case DRM_MODE_ROTATE_0:
> > +     case DRM_MODE_ROTATE_180:
> > +     default:
> > +             *src_w = plane_state->src_w >> 16;
> > +             *src_h = plane_state->src_h >> 16;
> > +             break;
> > +     }
> > +}
> > +
> >   static int dm_check_crtc_cursor(struct drm_atomic_state *state,
> >                               struct drm_crtc *crtc,
> >                               struct drm_crtc_state *new_crtc_state)
> > @@ -10744,6 +10762,8 @@ static int dm_check_crtc_cursor(struct drm_atomic_state *state,
> >       struct drm_plane_state *new_cursor_state, *new_underlying_state;
> >       int i;
> >       int cursor_scale_w, cursor_scale_h, underlying_scale_w, underlying_scale_h;
> > +     int cursor_src_w, cursor_src_h;
> > +     int underlying_src_w, underlying_src_h;
> >
> >       /* On DCE and DCN there is no dedicated hardware cursor plane. We get a
> >        * cursor per pipe but it's going to inherit the scaling and
> > @@ -10755,10 +10775,9 @@ static int dm_check_crtc_cursor(struct drm_atomic_state *state,
> >               return 0;
> >       }
> >
> > -     cursor_scale_w = new_cursor_state->crtc_w * 1000 /
> > -                      (new_cursor_state->src_w >> 16);
> > -     cursor_scale_h = new_cursor_state->crtc_h * 1000 /
> > -                      (new_cursor_state->src_h >> 16);
> > +     dm_get_oriented_plane_size(new_cursor_state, &cursor_src_w, &cursor_src_h);
> > +     cursor_scale_w = new_cursor_state->crtc_w * 1000 / cursor_src_w;
> > +     cursor_scale_h = new_cursor_state->crtc_h * 1000 / cursor_src_h;
> >
> >       for_each_new_plane_in_state_reverse(state, underlying, new_underlying_state, i) {
> >               /* Narrow down to non-cursor planes on the same CRTC as the cursor */
> > @@ -10769,10 +10788,10 @@ static int dm_check_crtc_cursor(struct drm_atomic_state *state,
> >               if (!new_underlying_state->fb)
> >                       continue;
> >
> > -             underlying_scale_w = new_underlying_state->crtc_w * 1000 /
> > -                                  (new_underlying_state->src_w >> 16);
> > -             underlying_scale_h = new_underlying_state->crtc_h * 1000 /
> > -                                  (new_underlying_state->src_h >> 16);
> > +             dm_get_oriented_plane_size(new_underlying_state,
> > +                                        &underlying_src_w, &underlying_src_h);
> > +             underlying_scale_w = new_underlying_state->crtc_w * 1000 / underlying_src_w;
> > +             underlying_scale_h = new_underlying_state->crtc_h * 1000 / underlying_src_h;
> >
> >               if (cursor_scale_w != underlying_scale_w ||
> >                   cursor_scale_h != underlying_scale_h) {
> >
>
