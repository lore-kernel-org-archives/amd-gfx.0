From: Navid Emamdoost <navid.emamdoost@gmail.com>
Subject: Re: [PATCH v3] drm/amdgpu: fix multiple memory leaks in acp_hw_init
Date: Tue, 1 Oct 2019 22:47:15 -0500
Message-ID: <CAEkB2EQzE2A-9QzqU9nVmj8xZE-6+Gqs-fCtP57KsBKj_5Do-A@mail.gmail.com>
References: <88fc639a-32ed-b6c6-f930-552083d5887d@amd.com> <20190930212644.9372-1-navid.emamdoost@gmail.com>
 <3a00a4c9-af4c-3505-1bef-b119435da5d7@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <3a00a4c9-af4c-3505-1bef-b119435da5d7@amd.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Koenig, Christian" <Christian.Koenig@amd.com>
Cc: "emamd001@umn.edu" <emamd001@umn.edu>, "smccaman@umn.edu" <smccaman@umn.edu>, "kjlu@umn.edu" <kjlu@umn.edu>, "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Zhou, David(ChunMing)" <David1.Zhou@amd.com>, David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>, Sam Ravnborg <sam@ravnborg.org>, Rex Zhu <Rex.Zhu@amd.com>, "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: amd-gfx.lists.freedesktop.org

On Tue, Oct 1, 2019 at 7:19 AM Koenig, Christian
<Christian.Koenig@amd.com> wrote:
>
> Am 30.09.19 um 23:26 schrieb Navid Emamdoost:
> > In acp_hw_init there are some allocations that needs to be released in
> > case of failure:
> >
> > 1- adev->acp.acp_genpd should be released if any allocation attemp for
> > adev->acp.acp_cell, adev->acp.acp_res or i2s_pdata fails.
> > 2- all of those allocations should be released if
> > mfd_add_hotplug_devices or pm_genpd_add_device fail.
> > 3- Release is needed in case of time out values expire.
> >
> > Signed-off-by: Navid Emamdoost <navid.emamdoost@gmail.com>
> > ---
> > Changes in v2:
> >       -- moved the releases under goto
> >
> > Changes in v3:
> >       -- fixed multiple goto issue
> >       -- added goto for 3 other failure cases: one when
> > mfd_add_hotplug_devices fails, and two when time out values expires.
> > ---
> >   drivers/gpu/drm/amd/amdgpu/amdgpu_acp.c | 41 ++++++++++++++++---------
> >   1 file changed, 27 insertions(+), 14 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_acp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_acp.c
> > index eba42c752bca..7809745ec0f1 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_acp.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_acp.c
> > @@ -184,12 +184,12 @@ static struct device *get_mfd_cell_dev(const char *device_name, int r)
> >    */
> >   static int acp_hw_init(void *handle)
> >   {
> > -     int r, i;
> > +     int r, i, ret;
>
> Please don't add another "ret" variable, instead always use "r" here.
>
Done!

> Apart from that looks good to me,
> Christian.
>
> >       uint64_t acp_base;
> >       u32 val = 0;
> >       u32 count = 0;
> >       struct device *dev;
> > -     struct i2s_platform_data *i2s_pdata;
> > +     struct i2s_platform_data *i2s_pdata = NULL;
> >
> >       struct amdgpu_device *adev = (struct amdgpu_device *)handle;
> >
> > @@ -231,20 +231,21 @@ static int acp_hw_init(void *handle)
> >       adev->acp.acp_cell = kcalloc(ACP_DEVS, sizeof(struct mfd_cell),
> >                                                       GFP_KERNEL);
> >
> > -     if (adev->acp.acp_cell == NULL)
> > -             return -ENOMEM;
> > +     if (adev->acp.acp_cell == NULL) {
> > +             ret = -ENOMEM;
> > +             goto failure;
> > +     }
> >
> >       adev->acp.acp_res = kcalloc(5, sizeof(struct resource), GFP_KERNEL);
> >       if (adev->acp.acp_res == NULL) {
> > -             kfree(adev->acp.acp_cell);
> > -             return -ENOMEM;
> > +             ret = -ENOMEM;
> > +             goto failure;
> >       }
> >
> >       i2s_pdata = kcalloc(3, sizeof(struct i2s_platform_data), GFP_KERNEL);
> >       if (i2s_pdata == NULL) {
> > -             kfree(adev->acp.acp_res);
> > -             kfree(adev->acp.acp_cell);
> > -             return -ENOMEM;
> > +             ret = -ENOMEM;
> > +             goto failure;
> >       }
> >
> >       switch (adev->asic_type) {
> > @@ -340,15 +341,18 @@ static int acp_hw_init(void *handle)
> >
> >       r = mfd_add_hotplug_devices(adev->acp.parent, adev->acp.acp_cell,
> >                                                               ACP_DEVS);
> > -     if (r)
> > -             return r;
> > +     if (r) {
> > +             ret = r;
> > +             goto failure;
> > +     }
> >
> >       for (i = 0; i < ACP_DEVS ; i++) {
> >               dev = get_mfd_cell_dev(adev->acp.acp_cell[i].name, i);
> >               r = pm_genpd_add_device(&adev->acp.acp_genpd->gpd, dev);
> >               if (r) {
> >                       dev_err(dev, "Failed to add dev to genpd\n");
> > -                     return r;
> > +                     ret = r;
> > +                     goto failure;
> >               }
> >       }
> >
> > @@ -367,7 +371,8 @@ static int acp_hw_init(void *handle)
> >                       break;
> >               if (--count == 0) {
> >                       dev_err(&adev->pdev->dev, "Failed to reset ACP\n");
> > -                     return -ETIMEDOUT;
> > +                     ret = -ETIMEDOUT;
> > +                     goto failure;
> >               }
> >               udelay(100);
> >       }
> > @@ -384,7 +389,8 @@ static int acp_hw_init(void *handle)
> >                       break;
> >               if (--count == 0) {
> >                       dev_err(&adev->pdev->dev, "Failed to reset ACP\n");
> > -                     return -ETIMEDOUT;
> > +                     ret = -ETIMEDOUT;
> > +                     goto failure;
> >               }
> >               udelay(100);
> >       }
> > @@ -393,6 +399,13 @@ static int acp_hw_init(void *handle)
> >       val &= ~ACP_SOFT_RESET__SoftResetAud_MASK;
> >       cgs_write_register(adev->acp.cgs_device, mmACP_SOFT_RESET, val);
> >       return 0;
> > +
> > +failure:
> > +     kfree(i2s_pdata);
> > +     kfree(adev->acp.acp_res);
> > +     kfree(adev->acp.acp_cell);
> > +     kfree(adev->acp.acp_genpd);
> > +     return ret;
> >   }
> >
> >   /**
>


-- 
Navid.
