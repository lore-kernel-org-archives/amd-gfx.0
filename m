From: Alex Deucher <alexdeucher@gmail.com>
Subject: Re: [PATCH][drm-next] drm/amd/display: fix a potential null pointer dereference
Date: Thu, 22 Aug 2019 16:55:08 -0400
Message-ID: <CADnq5_M-7LQ1HAiV5-jzYZENRNqzRm939AyvVarDpWJEJZDNqw@mail.gmail.com>
References: <20190816221011.10750-1-colin.king@canonical.com> <5981f677-3347-1450-f787-853e97496bd4@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <5981f677-3347-1450-f787-853e97496bd4@amd.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Harry Wentland <hwentlan@amd.com>
Cc: Colin King <colin.king@canonical.com>, "Wentland, Harry" <Harry.Wentland@amd.com>, "Li, Sun peng (Leo)" <Sunpeng.Li@amd.com>, "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Koenig, Christian" <Christian.Koenig@amd.com>, "Zhou, David(ChunMing)" <David1.Zhou@amd.com>, David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>, "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>, "kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: amd-gfx.lists.freedesktop.org

On Thu, Aug 22, 2019 at 3:21 PM Harry Wentland <hwentlan@amd.com> wrote:
>
> On 2019-08-16 6:10 p.m., Colin King wrote:
> > From: Colin Ian King <colin.king@canonical.com>
> >
> > Currently the pointer init_data is dereferenced on the assignment
> > of fw_info before init_data is sanity checked to see if it is null.
> > Fix te potential null pointer dereference on init_data by only
> > performing dereference after it is null checked.
> >
> > Addresses-Coverity: ("Dereference before null check")
> > Fixes: 9adc8050bf3c ("drm/amd/display: make firmware info only load once during dc_bios create")
> > Signed-off-by: Colin Ian King <colin.king@canonical.com>
>
> Reviewed-by: Harry Wentland <harry.wentland@amd.com>
>

Applied.  Thanks!

Alex

> Harry
>
> > ---
> >  drivers/gpu/drm/amd/display/dc/dce/dce_clock_source.c | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/gpu/drm/amd/display/dc/dce/dce_clock_source.c b/drivers/gpu/drm/amd/display/dc/dce/dce_clock_source.c
> > index bee81bf288be..926954c804a6 100644
> > --- a/drivers/gpu/drm/amd/display/dc/dce/dce_clock_source.c
> > +++ b/drivers/gpu/drm/amd/display/dc/dce/dce_clock_source.c
> > @@ -1235,7 +1235,7 @@ static bool calc_pll_max_vco_construct(
> >                       struct calc_pll_clock_source_init_data *init_data)
> >  {
> >       uint32_t i;
> > -     struct dc_firmware_info *fw_info = &init_data->bp->fw_info;
> > +     struct dc_firmware_info *fw_info;
> >       if (calc_pll_cs == NULL ||
> >                       init_data == NULL ||
> >                       init_data->bp == NULL)
> > @@ -1244,6 +1244,7 @@ static bool calc_pll_max_vco_construct(
> >       if (init_data->bp->fw_info_valid)
> >               return false;
> >
> > +     fw_info = &init_data->bp->fw_info;
> >       calc_pll_cs->ctx = init_data->ctx;
> >       calc_pll_cs->ref_freq_khz = fw_info->pll_info.crystal_frequency;
> >       calc_pll_cs->min_vco_khz =
> >
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
