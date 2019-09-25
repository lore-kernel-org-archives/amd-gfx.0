From: Alex Deucher <alexdeucher@gmail.com>
Subject: Re: [PATCH] drm/amd/display: prevent memory leak
Date: Wed, 25 Sep 2019 12:04:22 -0400
Message-ID: <CADnq5_MuFQgTQn50DikASgNVjLaJxPcQdfMPXesxdSqhME_Dmg@mail.gmail.com>
References: <20190925042407.31383-1-navid.emamdoost@gmail.com> <5cb6dec0-7f88-5d14-82cb-919f1d190b2f@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <5cb6dec0-7f88-5d14-82cb-919f1d190b2f@amd.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Harry Wentland <hwentlan@amd.com>
Cc: Navid Emamdoost <navid.emamdoost@gmail.com>, David Airlie <airlied@linux.ie>, "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Lei, Jun" <Jun.Lei@amd.com>, Sam Ravnborg <sam@ravnborg.org>, Wang Hai <wanghai26@huawei.com>, "Cheng, Tony" <Tony.Cheng@amd.com>, "Francis, David" <David.Francis@amd.com>, "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "emamd001@umn.edu" <emamd001@umn.edu>, "Bernstein, Eric" <Eric.Bernstein@amd.com>, Su Sung Chung <Su.Chung@amd.com>, "smccaman@umn.edu" <smccaman@umn.edu>, "Li, Sun peng (Leo)" <Sunpeng.Li@amd.com>, "kjlu@umn.edu" <kjlu@umn.edu>, Aidan Wood <Aidan.Wood@amd.com>, "Wu, Hersen" <hersenxs.wu@amd.com>, Lakha, Bhawanpreet
List-Id: amd-gfx.lists.freedesktop.org

On Wed, Sep 25, 2019 at 9:54 AM Harry Wentland <hwentlan@amd.com> wrote:
>
>
>
> On 2019-09-25 12:23 a.m., Navid Emamdoost wrote:
> > In dcn*_create_resource_pool the allocated memory should be released if
> > construct pool fails.
> >
> > Signed-off-by: Navid Emamdoost <navid.emamdoost@gmail.com>
>
> Reviewed-by: Harry Wentland <harry.wentland@amd.com>
>

Applied.  thanks!

Alex

> Harry
>
> > ---
> >  drivers/gpu/drm/amd/display/dc/dce100/dce100_resource.c | 1 +
> >  drivers/gpu/drm/amd/display/dc/dce110/dce110_resource.c | 1 +
> >  drivers/gpu/drm/amd/display/dc/dce112/dce112_resource.c | 1 +
> >  drivers/gpu/drm/amd/display/dc/dce120/dce120_resource.c | 1 +
> >  drivers/gpu/drm/amd/display/dc/dcn10/dcn10_resource.c   | 1 +
> >  5 files changed, 5 insertions(+)
> >
> > diff --git a/drivers/gpu/drm/amd/display/dc/dce100/dce100_resource.c b/drivers/gpu/drm/amd/display/dc/dce100/dce100_resource.c
> > index afc61055eca1..1787b9bf800a 100644
> > --- a/drivers/gpu/drm/amd/display/dc/dce100/dce100_resource.c
> > +++ b/drivers/gpu/drm/amd/display/dc/dce100/dce100_resource.c
> > @@ -1091,6 +1091,7 @@ struct resource_pool *dce100_create_resource_pool(
> >       if (construct(num_virtual_links, dc, pool))
> >               return &pool->base;
> >
> > +     kfree(pool);
> >       BREAK_TO_DEBUGGER();
> >       return NULL;
> >  }
> > diff --git a/drivers/gpu/drm/amd/display/dc/dce110/dce110_resource.c b/drivers/gpu/drm/amd/display/dc/dce110/dce110_resource.c
> > index c66fe170e1e8..318e9c2e2ca8 100644
> > --- a/drivers/gpu/drm/amd/display/dc/dce110/dce110_resource.c
> > +++ b/drivers/gpu/drm/amd/display/dc/dce110/dce110_resource.c
> > @@ -1462,6 +1462,7 @@ struct resource_pool *dce110_create_resource_pool(
> >       if (construct(num_virtual_links, dc, pool, asic_id))
> >               return &pool->base;
> >
> > +     kfree(pool);
> >       BREAK_TO_DEBUGGER();
> >       return NULL;
> >  }
> > diff --git a/drivers/gpu/drm/amd/display/dc/dce112/dce112_resource.c b/drivers/gpu/drm/amd/display/dc/dce112/dce112_resource.c
> > index 3ac4c7e73050..3199d493d13b 100644
> > --- a/drivers/gpu/drm/amd/display/dc/dce112/dce112_resource.c
> > +++ b/drivers/gpu/drm/amd/display/dc/dce112/dce112_resource.c
> > @@ -1338,6 +1338,7 @@ struct resource_pool *dce112_create_resource_pool(
> >       if (construct(num_virtual_links, dc, pool))
> >               return &pool->base;
> >
> > +     kfree(pool);
> >       BREAK_TO_DEBUGGER();
> >       return NULL;
> >  }
> > diff --git a/drivers/gpu/drm/amd/display/dc/dce120/dce120_resource.c b/drivers/gpu/drm/amd/display/dc/dce120/dce120_resource.c
> > index 7d08154e9662..bb497f43f6eb 100644
> > --- a/drivers/gpu/drm/amd/display/dc/dce120/dce120_resource.c
> > +++ b/drivers/gpu/drm/amd/display/dc/dce120/dce120_resource.c
> > @@ -1203,6 +1203,7 @@ struct resource_pool *dce120_create_resource_pool(
> >       if (construct(num_virtual_links, dc, pool))
> >               return &pool->base;
> >
> > +     kfree(pool);
> >       BREAK_TO_DEBUGGER();
> >       return NULL;
> >  }
> > diff --git a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_resource.c b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_resource.c
> > index 5a89e462e7cc..59305e411a66 100644
> > --- a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_resource.c
> > +++ b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_resource.c
> > @@ -1570,6 +1570,7 @@ struct resource_pool *dcn10_create_resource_pool(
> >       if (construct(init_data->num_virtual_links, dc, pool))
> >               return &pool->base;
> >
> > +     kfree(pool);
> >       BREAK_TO_DEBUGGER();
> >       return NULL;
> >  }
> >
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
