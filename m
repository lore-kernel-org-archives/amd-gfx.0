From: Alex Deucher <alexdeucher@gmail.com>
Subject: Re: [PATCH] drm/amd/display: remove duplicated comparison expression
Date: Mon, 11 Nov 2019 12:35:10 -0500
Message-ID: <CADnq5_MKFh3v+qnjO-bmpepTc_XTgEKTomP0PLRJu==_UBTkZA@mail.gmail.com>
References: <20191109154921.223093-1-colin.king@canonical.com> <0700f347-8590-7ab7-411d-0ae08fe9263d@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <0700f347-8590-7ab7-411d-0ae08fe9263d@amd.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Kazlauskas, Nicholas" <nicholas.kazlauskas@amd.com>
Cc: Colin King <colin.king@canonical.com>, Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>, Alex Deucher <alexander.deucher@amd.com>, =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, David Zhou <David1.Zhou@amd.com>, David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>, Charlene Liu <Charlene.Liu@amd.com>, Dmytro Laktyushkin <Dmytro.Laktyushkin@amd.com>, amd-gfx list <amd-gfx@lists.freedesktop.org>, Maling list - DRI developers <dri-devel@lists.freedesktop.org>, kernel-janitors@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
List-Id: amd-gfx.lists.freedesktop.org

Applied.  Thanks!

Alex

On Mon, Nov 11, 2019 at 8:38 AM Kazlauskas, Nicholas
<nicholas.kazlauskas@amd.com> wrote:
>
> On 2019-11-09 10:49 a.m., Colin King wrote:
> > From: Colin Ian King <colin.king@canonical.com>
> >
> > There is comparison expression that is duplicated and hence one
> > of the expressions can be removed.  Remove it.
> >
> > Addresses-Coverity: ("Same on both sides")
> > Fixes: 12e2b2d4c65f ("drm/amd/display: add dcc programming for dual plane")
> > Signed-off-by: Colin Ian King <colin.king@canonical.com>
>
> Reviewed-by: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
>
> Thanks!
>
> Nicholas Kazlauskas
>
> > ---
> >   drivers/gpu/drm/amd/display/dc/core/dc.c | 1 -
> >   1 file changed, 1 deletion(-)
> >
> > diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd/display/dc/core/dc.c
> > index 1fdba13b3d0f..1fa255e077d0 100644
> > --- a/drivers/gpu/drm/amd/display/dc/core/dc.c
> > +++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
> > @@ -1491,7 +1491,6 @@ static enum surface_update_type get_plane_info_update_type(const struct dc_surfa
> >       }
> >
> >       if (u->plane_info->plane_size.surface_pitch != u->surface->plane_size.surface_pitch
> > -                     || u->plane_info->plane_size.surface_pitch != u->surface->plane_size.surface_pitch
> >                       || u->plane_info->plane_size.chroma_pitch != u->surface->plane_size.chroma_pitch) {
> >               update_flags->bits.plane_size_change = 1;
> >               elevate_update_type(&update_type, UPDATE_TYPE_MED);
> >
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
