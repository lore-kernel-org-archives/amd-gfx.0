From: Alex Deucher <alexdeucher@gmail.com>
Subject: Re: [PATCH v2] drm/amd/powerplay: return errno code to caller when
 error occur
Date: Mon, 18 Nov 2019 15:24:13 -0500
Message-ID: <CADnq5_OYLYxwDsiqmDn0tJqrvdHc119LOGPSLuG=g2ShL4_oFQ@mail.gmail.com>
References: <1573875799-83572-1-git-send-email-chenwandun@huawei.com>
 <1574064214-109525-1-git-send-email-chenwandun@huawei.com> <MN2PR12MB3344BBBA7F72F9625D71329EE44D0@MN2PR12MB3344.namprd12.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <MN2PR12MB3344BBBA7F72F9625D71329EE44D0@MN2PR12MB3344.namprd12.prod.outlook.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Quan, Evan" <Evan.Quan@amd.com>
Cc: Chen Wandun <chenwandun@huawei.com>, "Deucher, Alexander" <Alexander.Deucher@amd.com>, "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>
List-Id: amd-gfx.lists.freedesktop.org

Applied.  Thanks!

Alex

On Mon, Nov 18, 2019 at 3:15 AM Quan, Evan <Evan.Quan@amd.com> wrote:
>
> Reviewed-by: Evan Quan <evan.quan@amd.com>
>
> > -----Original Message-----
> > From: Chen Wandun <chenwandun@huawei.com>
> > Sent: Monday, November 18, 2019 4:04 PM
> > To: Quan, Evan <Evan.Quan@amd.com>; Deucher, Alexander
> > <Alexander.Deucher@amd.com>; amd-gfx@lists.freedesktop.org; linux-
> > kernel@vger.kernel.org; dri-devel@lists.freedesktop.org
> > Cc: chenwandun@huawei.com
> > Subject: [PATCH v2] drm/amd/powerplay: return errno code to caller when
> > error occur
> >
> > return errno code to caller when error occur, and meanwhile remove gcc '-
> > Wunused-but-set-variable' warning.
> >
> > drivers/gpu/drm/amd/amdgpu/../powerplay/smumgr/vegam_smumgr.c: In
> > function vegam_populate_smc_boot_level:
> > drivers/gpu/drm/amd/amdgpu/../powerplay/smumgr/vegam_smumgr.c:1364:
> > 6: warning: variable result set but not used [-Wunused-but-set-variable]
> >
> > Signed-off-by: Chen Wandun <chenwandun@huawei.com>
> > ---
> >  drivers/gpu/drm/amd/powerplay/smumgr/vegam_smumgr.c | 5 +++++
> >  1 file changed, 5 insertions(+)
> >
> > diff --git a/drivers/gpu/drm/amd/powerplay/smumgr/vegam_smumgr.c
> > b/drivers/gpu/drm/amd/powerplay/smumgr/vegam_smumgr.c
> > index 2068eb0..50896e9 100644
> > --- a/drivers/gpu/drm/amd/powerplay/smumgr/vegam_smumgr.c
> > +++ b/drivers/gpu/drm/amd/powerplay/smumgr/vegam_smumgr.c
> > @@ -1371,11 +1371,16 @@ static int vegam_populate_smc_boot_level(struct
> > pp_hwmgr *hwmgr,
> >       result = phm_find_boot_level(&(data->dpm_table.sclk_table),
> >                       data->vbios_boot_state.sclk_bootup_value,
> >                       (uint32_t *)&(table->GraphicsBootLevel));
> > +     if (result)
> > +             return result;
> >
> >       result = phm_find_boot_level(&(data->dpm_table.mclk_table),
> >                       data->vbios_boot_state.mclk_bootup_value,
> >                       (uint32_t *)&(table->MemoryBootLevel));
> >
> > +     if (result)
> > +             return result;
> > +
> >       table->BootVddc  = data->vbios_boot_state.vddc_bootup_value *
> >                       VOLTAGE_SCALE;
> >       table->BootVddci = data->vbios_boot_state.vddci_bootup_value *
> > --
> > 2.7.4
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
