From: Alex Deucher <alexdeucher@gmail.com>
Subject: Re: [PATCH] drm/amd/powerplay: Change id parameter type in pp_atomfwctrl_get_clk_information_by_clkid
Date: Mon, 24 Sep 2018 18:54:14 -0400
Message-ID: <CADnq5_OwR8WAztaKgktHc57XtwJtCHcpBbjk9R3ErM1a7Xakdg@mail.gmail.com>
References: <20180921210106.24310-1-natechancellor@gmail.com> <CAKwvOdkVqQN5M05X4_1YxOSi4LAzw=PXuLqVq0z7SXYWoCG2sA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAKwvOdkVqQN5M05X4_1YxOSi4LAzw=PXuLqVq0z7SXYWoCG2sA@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Nick Desaulniers <ndesaulniers@google.com>
Cc: Nathan Chancellor <natechancellor@gmail.com>, Chunming Zhou <David1.Zhou@amd.com>, LKML <linux-kernel@vger.kernel.org>, amd-gfx list <amd-gfx@lists.freedesktop.org>, Maling list - DRI developers <dri-devel@lists.freedesktop.org>, "Deucher, Alexander" <alexander.deucher@amd.com>, "Quan, Evan" <evan.quan@amd.com>, Rex Zhu <rex.zhu@amd.com>, Christian Koenig <christian.koenig@amd.com>
List-Id: amd-gfx.lists.freedesktop.org

On Mon, Sep 24, 2018 at 6:07 PM Nick Desaulniers
<ndesaulniers@google.com> wrote:
>
> On Fri, Sep 21, 2018 at 2:01 PM Nathan Chancellor
> <natechancellor@gmail.com> wrote:
> >
> > Clang generates warnings when one enumerated type is implicitly
> > converted to another.
> >
> > drivers/gpu/drm/amd/amdgpu/../powerplay/hwmgr/ppatomfwctrl.c:532:57:
> > warning: implicit conversion from enumeration type 'enum
> > atom_smu11_syspll0_clock_id' to different enumeration type 'BIOS_CLKID'
> >       (aka 'enum atom_smu9_syspll0_clock_id') [-Wenum-conversion]
> >         if (!pp_atomfwctrl_get_clk_information_by_clkid(hwmgr,
> > SMU11_SYSPLL0_SOCCLK_ID, &frequency))
>
> Grepping the call sites, via:
> $ grep -r pp_atomfwctrl_get_clk_information_by_clkid
>
> shows that sometimes this function is called with instances of:
>
> enum atom_smu9_syspll0_clock_id
> enum atom_smu11_syspll0_clock_id
>
> before your patch, the function defined to take a BIOS_CLKID, which is
> typedef'd to the *9* enum:
>
> typedef enum atom_smu9_syspll0_clock_id BIOS_CLKID;
>
> While the current values are < 256, the enums are not packed, so you
> should use either int or a union of the two types.
> Do the maintainers have a preference, before sending a v2?

I think the patch is probably fine as is.  For reference, what this
function does it look up a value in the vbios based on the id.  So all
we really need is the numeric value of the id.  The ids are different
between asic families but the vbios interface is the same.

Alex

>
> >
> > In this case, that is expected behavior. To make that clear to Clang
> > without explicitly casting these values, change id's type to uint8_t
> > in pp_atomfwctrl_get_clk_information_by_clkid so no conversion happens.
> >
> > Reported-by: Nick Desaulniers <ndesaulniers@google.com>
> > Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
> > ---
> >  drivers/gpu/drm/amd/powerplay/hwmgr/ppatomfwctrl.c | 3 ++-
> >  drivers/gpu/drm/amd/powerplay/hwmgr/ppatomfwctrl.h | 2 +-
> >  2 files changed, 3 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/amd/powerplay/hwmgr/ppatomfwctrl.c b/drivers/gpu/drm/amd/powerplay/hwmgr/ppatomfwctrl.c
> > index d27c1c9df286..4588bddf8b33 100644
> > --- a/drivers/gpu/drm/amd/powerplay/hwmgr/ppatomfwctrl.c
> > +++ b/drivers/gpu/drm/amd/powerplay/hwmgr/ppatomfwctrl.c
> > @@ -488,7 +488,8 @@ int pp_atomfwctrl_get_gpio_information(struct pp_hwmgr *hwmgr,
> >         return 0;
> >  }
> >
> > -int pp_atomfwctrl_get_clk_information_by_clkid(struct pp_hwmgr *hwmgr, BIOS_CLKID id, uint32_t *frequency)
> > +int pp_atomfwctrl_get_clk_information_by_clkid(struct pp_hwmgr *hwmgr,
> > +                                              uint8_t id, uint32_t *frequency)
> >  {
> >         struct amdgpu_device *adev = hwmgr->adev;
> >         struct atom_get_smu_clock_info_parameters_v3_1   parameters;
> > diff --git a/drivers/gpu/drm/amd/powerplay/hwmgr/ppatomfwctrl.h b/drivers/gpu/drm/amd/powerplay/hwmgr/ppatomfwctrl.h
> > index 22e21668c93a..fe9e8ceef50e 100644
> > --- a/drivers/gpu/drm/amd/powerplay/hwmgr/ppatomfwctrl.h
> > +++ b/drivers/gpu/drm/amd/powerplay/hwmgr/ppatomfwctrl.h
> > @@ -236,7 +236,7 @@ int pp_atomfwctrl_get_vbios_bootup_values(struct pp_hwmgr *hwmgr,
> >  int pp_atomfwctrl_get_smc_dpm_information(struct pp_hwmgr *hwmgr,
> >                         struct pp_atomfwctrl_smc_dpm_parameters *param);
> >  int pp_atomfwctrl_get_clk_information_by_clkid(struct pp_hwmgr *hwmgr,
> > -                                       BIOS_CLKID id, uint32_t *frequency);
> > +                                       uint8_t id, uint32_t *frequency);
> >
> >  #endif
> >
> > --
> > 2.19.0
> >
>
>
> --
> Thanks,
> ~Nick Desaulniers
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
