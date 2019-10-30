From: Alex Deucher <alexdeucher@gmail.com>
Subject: Re: [PATCH -next] drm/amd/display: Add a conversion function for
 transmitter and phy_id enums
Date: Wed, 30 Oct 2019 10:03:59 -0400
Message-ID: <CADnq5_Na9Lyb_9z7DY27o8SWkPQNi6pNbU1qXd0R7W6_Qa9Xtg@mail.gmail.com>
References: <20191030060411.21168-1-natechancellor@gmail.com> <b8a9f49e-b788-82b8-ead3-0ae6fba7e8fa@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <b8a9f49e-b788-82b8-ead3-0ae6fba7e8fa@amd.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Kazlauskas, Nicholas" <Nicholas.Kazlauskas@amd.com>
Cc: Nathan Chancellor <natechancellor@gmail.com>, "Wentland, Harry" <Harry.Wentland@amd.com>, "Li, Sun peng (Leo)" <Sunpeng.Li@amd.com>, "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Koenig, Christian" <Christian.Koenig@amd.com>, "Zhou, David(ChunMing)" <David1.Zhou@amd.com>, "clang-built-linux@googlegroups.com" <clang-built-linux@googlegroups.com>, "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>, "Li, Roman" <Roman.Li@amd.com>, "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: amd-gfx.lists.freedesktop.org

On Wed, Oct 30, 2019 at 8:33 AM Kazlauskas, Nicholas
<Nicholas.Kazlauskas@amd.com> wrote:
>
> On 2019-10-30 2:04 a.m., Nathan Chancellor wrote:
> > Clang warns:
> >
> > ../drivers/gpu/drm/amd/amdgpu/../display/dc/core/dc_link.c:2520:42:
> > error: implicit conversion from enumeration type 'enum transmitter' to
> > different enumeration type 'enum physical_phy_id'
> > [-Werror,-Wenum-conversion]
> >          psr_context->smuPhyId = link->link_enc->transmitter;
> >                                ~ ~~~~~~~~~~~~~~~~^~~~~~~~~~~
> > 1 error generated.
> >
> > As the comment above this assignment states, this is intentional. To
> > match previous warnings of this nature, add a conversion function that
> > explicitly converts between the enums and warns when there is a
> > mismatch.
> >
> > See commit 828cfa29093f ("drm/amdgpu: Fix amdgpu ras to ta enums
> > conversion") and commit d9ec5cfd5a2e ("drm/amd/display: Use switch table
> > for dc_to_smu_clock_type") for previous examples of this.
> >
> > Fixes: e0d08a40a63b ("drm/amd/display: Add debugfs entry for reading psr state")
> > Link: https://github.com/ClangBuiltLinux/linux/issues/758
> > Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
>
> Reviewed-by: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
>
> With the small nitpick that maybe the default case should be
> PHYLD_UNKNOWN, but well get the warning if that happens anyway.
>

Applied with that change.

Thanks!

Alex

> Nicholas Kazlauskas
>
> > ---
> >   drivers/gpu/drm/amd/display/dc/core/dc_link.c | 38 ++++++++++++++++++-
> >   1 file changed, 37 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link.c b/drivers/gpu/drm/amd/display/dc/core/dc_link.c
> > index 7b18087be585..38dfe460e13b 100644
> > --- a/drivers/gpu/drm/amd/display/dc/core/dc_link.c
> > +++ b/drivers/gpu/drm/amd/display/dc/core/dc_link.c
> > @@ -2447,6 +2447,41 @@ bool dc_link_get_psr_state(const struct dc_link *link, uint32_t *psr_state)
> >       return true;
> >   }
> >
> > +static inline enum physical_phy_id
> > +transmitter_to_phy_id(enum transmitter transmitter_value)
> > +{
> > +     switch (transmitter_value) {
> > +     case TRANSMITTER_UNIPHY_A:
> > +             return PHYLD_0;
> > +     case TRANSMITTER_UNIPHY_B:
> > +             return PHYLD_1;
> > +     case TRANSMITTER_UNIPHY_C:
> > +             return PHYLD_2;
> > +     case TRANSMITTER_UNIPHY_D:
> > +             return PHYLD_3;
> > +     case TRANSMITTER_UNIPHY_E:
> > +             return PHYLD_4;
> > +     case TRANSMITTER_UNIPHY_F:
> > +             return PHYLD_5;
> > +     case TRANSMITTER_NUTMEG_CRT:
> > +             return PHYLD_6;
> > +     case TRANSMITTER_TRAVIS_CRT:
> > +             return PHYLD_7;
> > +     case TRANSMITTER_TRAVIS_LCD:
> > +             return PHYLD_8;
> > +     case TRANSMITTER_UNIPHY_G:
> > +             return PHYLD_9;
> > +     case TRANSMITTER_COUNT:
> > +             return PHYLD_COUNT;
> > +     case TRANSMITTER_UNKNOWN:
> > +             return PHYLD_UNKNOWN;
> > +     default:
> > +             WARN_ONCE(1, "Unknown transmitter value %d\n",
> > +                       transmitter_value);
> > +             return PHYLD_0;
> > +     }
> > +}
> > +
> >   bool dc_link_setup_psr(struct dc_link *link,
> >               const struct dc_stream_state *stream, struct psr_config *psr_config,
> >               struct psr_context *psr_context)
> > @@ -2517,7 +2552,8 @@ bool dc_link_setup_psr(struct dc_link *link,
> >       /* Hardcoded for now.  Can be Pcie or Uniphy (or Unknown)*/
> >       psr_context->phyType = PHY_TYPE_UNIPHY;
> >       /*PhyId is associated with the transmitter id*/
> > -     psr_context->smuPhyId = link->link_enc->transmitter;
> > +     psr_context->smuPhyId =
> > +             transmitter_to_phy_id(link->link_enc->transmitter);
> >
> >       psr_context->crtcTimingVerticalTotal = stream->timing.v_total;
> >       psr_context->vsyncRateHz = div64_u64(div64_u64((stream->
> >
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
