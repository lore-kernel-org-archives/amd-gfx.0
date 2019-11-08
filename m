From: Alex Deucher <alexdeucher@gmail.com>
Subject: Re: [PATCH][next] drm/amd/display: fix dereference of pointer
 aconnector when it is null
Date: Fri, 8 Nov 2019 11:33:16 -0500
Message-ID: <CADnq5_OgwugkJAkHvcdMsKGvdL_jYxS5g8L-697cWQwh-Wy-mg@mail.gmail.com>
References: <20191108143814.118856-1-colin.king@canonical.com> <7155ecfc-1aff-002d-9cc6-e097525e7cb6@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <7155ecfc-1aff-002d-9cc6-e097525e7cb6@amd.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Mikita Lipski <mlipski@amd.com>
Cc: Colin King <colin.king@canonical.com>, "Wentland, Harry" <Harry.Wentland@amd.com>, "Li, Sun peng (Leo)" <Sunpeng.Li@amd.com>, "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Koenig, Christian" <Christian.Koenig@amd.com>, "Zhou, David(ChunMing)" <David1.Zhou@amd.com>, David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>, Lyude Paul <lyude@redhat.com>, "Kazlauskas, Nicholas" <Nicholas.Kazlauskas@amd.com>, "Lipski, Mikita" <Mikita.Lipski@amd.com>, "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>, "kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: amd-gfx.lists.freedesktop.org

Applied.  thanks!

Alex

On Fri, Nov 8, 2019 at 9:42 AM Mikita Lipski <mlipski@amd.com> wrote:
>
> Thanks!
>
> Reviewed-by: Mikita Lipski <mikita.lipski@amd.com>
>
> On 08.11.2019 9:38, Colin King wrote:
> > From: Colin Ian King <colin.king@canonical.com>
> >
> > Currently pointer aconnector is being dereferenced by the call to
> > to_dm_connector_state before it is being null checked, this could
> > lead to a null pointer dereference.  Fix this by checking that
> > aconnector is null before dereferencing it.
> >
> > Addresses-Coverity: ("Dereference before null check")
> > Fixes: 5133c6241d9c ("drm/amd/display: Add MST atomic routines")
> > Signed-off-by: Colin Ian King <colin.king@canonical.com>
> > ---
> >   drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c | 5 ++---
> >   1 file changed, 2 insertions(+), 3 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c
> > index e3cda6984d28..72e677796a48 100644
> > --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c
> > +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c
> > @@ -193,12 +193,11 @@ bool dm_helpers_dp_mst_write_payload_allocation_table(
> >        * that blocks before commit guaranteeing that the state
> >        * is not gonna be swapped while still in use in commit tail */
> >
> > -     dm_conn_state = to_dm_connector_state(aconnector->base.state);
> > -
> > -
> >       if (!aconnector || !aconnector->mst_port)
> >               return false;
> >
> > +     dm_conn_state = to_dm_connector_state(aconnector->base.state);
> > +
> >       mst_mgr = &aconnector->mst_port->mst_mgr;
> >
> >       if (!mst_mgr->mst_state)
> >
>
> --
> Thanks,
> Mikita Lipski
> mikita.lipski@amd.com
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
