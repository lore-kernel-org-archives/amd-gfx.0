From: Alex Deucher <alexdeucher@gmail.com>
Subject: Re: [PATCH 1/6] drm/amdgpu/dm/mst: Don't create MST topology managers
 for eDP ports
Date: Fri, 27 Sep 2019 14:18:59 -0400
Message-ID: <CADnq5_PF_aAcCADP1g3+4UFmWM7TVPmSsnaw1GaFqVzBodVE3A@mail.gmail.com>
References: <20190926225122.31455-1-lyude@redhat.com> <20190926225122.31455-2-lyude@redhat.com>
 <2a1d5221-b801-44f9-c966-1163b8d67b3f@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <2a1d5221-b801-44f9-c966-1163b8d67b3f@amd.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Harry Wentland <hwentlan@amd.com>
Cc: Lyude Paul <lyude@redhat.com>, "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "Zhou, David(ChunMing)" <David1.Zhou@amd.com>, Thomas Lim <Thomas.Lim@amd.com>, "Li, Sun peng (Leo)" <Sunpeng.Li@amd.com>, "Francis, David" <David.Francis@amd.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>, David Airlie <airlied@linux.ie>, "Zuo, Jerry" <Jerry.Zuo@amd.com>, Daniel Vetter <daniel@ffwll.ch>, "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Wentland, Harry" <Harry.Wentland@amd.com>, "Koenig, Christian" <Christian.Koenig@amd.com>
List-Id: amd-gfx.lists.freedesktop.org

On Fri, Sep 27, 2019 at 1:48 PM Harry Wentland <hwentlan@amd.com> wrote:
>
> On 2019-09-26 6:51 p.m., Lyude Paul wrote:
> > Signed-off-by: Lyude Paul <lyude@redhat.com>
>
> Reviewed-by: Harry Wentland <harry.wentland@amd.com>
>

Applied.  Thanks!

Alex

> Harry
>
> > ---
> >  drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c | 4 ++++
> >  1 file changed, 4 insertions(+)
> >
> > diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
> > index 5ec14efd4d8c..185bf0e2bda2 100644
> > --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
> > +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
> > @@ -417,6 +417,10 @@ void amdgpu_dm_initialize_dp_connector(struct amdgpu_display_manager *dm,
> >       drm_dp_aux_register(&aconnector->dm_dp_aux.aux);
> >       drm_dp_cec_register_connector(&aconnector->dm_dp_aux.aux,
> >                                     &aconnector->base);
> > +
> > +     if (aconnector->base.connector_type == DRM_MODE_CONNECTOR_eDP)
> > +             return;
> > +
> >       aconnector->mst_mgr.cbs = &dm_mst_cbs;
> >       drm_dp_mst_topology_mgr_init(
> >               &aconnector->mst_mgr,
> >
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
