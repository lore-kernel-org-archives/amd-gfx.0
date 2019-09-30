From: Navid Emamdoost <navid.emamdoost@gmail.com>
Subject: Re: [PATCH v2] drm/amdgpu: fix multiple memory leaks
Date: Mon, 30 Sep 2019 16:31:51 -0500
Message-ID: <CAEkB2EREjd9BbOeMmk9VWg+UB4ujieMz13Pj7hoAPpE2PGh3hQ@mail.gmail.com>
References: <7bab24ff-ded7-9f76-ba25-efd07cdd30dd@amd.com> <20190918190529.17298-1-navid.emamdoost@gmail.com>
 <88fc639a-32ed-b6c6-f930-552083d5887d@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <88fc639a-32ed-b6c6-f930-552083d5887d@amd.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Koenig, Christian" <Christian.Koenig@amd.com>
Cc: "emamd001@umn.edu" <emamd001@umn.edu>, "smccaman@umn.edu" <smccaman@umn.edu>, "kjlu@umn.edu" <kjlu@umn.edu>, "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Zhou, David(ChunMing)" <David1.Zhou@amd.com>, David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>, Rex Zhu <Rex.Zhu@amd.com>, Sam Ravnborg <sam@ravnborg.org>, "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: amd-gfx.lists.freedesktop.org

On Thu, Sep 19, 2019 at 3:03 AM Koenig, Christian
<Christian.Koenig@amd.com> wrote:
>
> Am 18.09.19 um 21:05 schrieb Navid Emamdoost:
> > In acp_hw_init there are some allocations that needs to be released in
> > case of failure:
> >
> > 1- adev->acp.acp_genpd should be released if any allocation attemp for
> > adev->acp.acp_cell, adev->acp.acp_res or i2s_pdata fails.
> > 2- all of those allocations should be released if pm_genpd_add_device
> > fails.
> >
> > v2: moved the released into goto error handlings
> >
> > Signed-off-by: Navid Emamdoost <navid.emamdoost@gmail.com>
> > ---
> >   drivers/gpu/drm/amd/amdgpu/amdgpu_acp.c | 30 +++++++++++++++++--------
> >   1 file changed, 21 insertions(+), 9 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_acp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_acp.c
> > index eba42c752bca..c0db75b71859 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_acp.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_acp.c
> > @@ -184,7 +184,7 @@ static struct device *get_mfd_cell_dev(const char *device_name, int r)
> >    */
> >   static int acp_hw_init(void *handle)
> >   {
> > -     int r, i;
> > +     int r, i, ret;
> >       uint64_t acp_base;
> >       u32 val = 0;
> >       u32 count = 0;
> > @@ -231,20 +231,21 @@ static int acp_hw_init(void *handle)
> >       adev->acp.acp_cell = kcalloc(ACP_DEVS, sizeof(struct mfd_cell),
> >                                                       GFP_KERNEL);
> >
> > -     if (adev->acp.acp_cell == NULL)
> > -             return -ENOMEM;
> > +     if (adev->acp.acp_cell == NULL) {
> > +             ret = -ENOMEM;
> > +             goto out1;
> > +     }
> >
> >       adev->acp.acp_res = kcalloc(5, sizeof(struct resource), GFP_KERNEL);
> >       if (adev->acp.acp_res == NULL) {
> > -             kfree(adev->acp.acp_cell);
> > -             return -ENOMEM;
> > +             ret = -ENOMEM;
> > +             goto out2;
> >       }
> >
> >       i2s_pdata = kcalloc(3, sizeof(struct i2s_platform_data), GFP_KERNEL);
> >       if (i2s_pdata == NULL) {
> > -             kfree(adev->acp.acp_res);
> > -             kfree(adev->acp.acp_cell);
> > -             return -ENOMEM;
> > +             ret = -ENOMEM;
> > +             goto out3;
> >       }
> >
> >       switch (adev->asic_type) {
> > @@ -348,7 +349,8 @@ static int acp_hw_init(void *handle)
> >               r = pm_genpd_add_device(&adev->acp.acp_genpd->gpd, dev);
> >               if (r) {
> >                       dev_err(dev, "Failed to add dev to genpd\n");
> > -                     return r;
> > +                     ret = r;
> > +                     goto out4;
> >               }
> >       }
> >
> > @@ -393,6 +395,16 @@ static int acp_hw_init(void *handle)
> >       val &= ~ACP_SOFT_RESET__SoftResetAud_MASK;
> >       cgs_write_register(adev->acp.cgs_device, mmACP_SOFT_RESET, val);
> >       return 0;
> > +
> > +out4:
> > +     kfree(i2s_pdata);
> > +out3:
> > +     kfree(adev->acp.acp_res);
> > +out2:
> > +     kfree(adev->acp.acp_cell);
> > +out1:
> > +     kfree(adev->acp.acp_genpd);
>
> kfree on a NULL pointer is harmless, so a single error label should be
> sufficient.
>
I fixed this by just using failure label.

> Christian.
>
> > +     return ret;
> >   }
> >
> >   /**
>

In addition to previous cases, I covered 3 more error handling cases
that seemed need to goto failure. One where mfd_add_hotplug_devices
fails and the other two cases where time out values expire.


-- 
Navid.
