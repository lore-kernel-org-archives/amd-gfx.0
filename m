From: Alex Deucher <alexdeucher@gmail.com>
Subject: Re: [PATCH] drm/amd/display: Pass app_tf by value rather than by reference
Date: Wed, 27 Feb 2019 21:34:59 -0500
Message-ID: <CADnq5_NC_3zeMN2EE5T-eQy2JY1cAxHxdcGsUiP-vs-Du0Q=Eg@mail.gmail.com>
References: <20181210234201.4850-1-natechancellor@gmail.com> <20190222124845.GA18614@archlinux-ryzen>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190222124845.GA18614@archlinux-ryzen>
Sender: linux-kernel-owner@vger.kernel.org
To: Nathan Chancellor <natechancellor@gmail.com>
Cc: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>, Alex Deucher <alexander.deucher@amd.com>, =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, "David (ChunMing) Zhou" <David1.Zhou@amd.com>, Nick Desaulniers <ndesaulniers@google.com>, Maling list - DRI developers <dri-devel@lists.freedesktop.org>, amd-gfx list <amd-gfx@lists.freedesktop.org>, LKML <linux-kernel@vger.kernel.org>
List-Id: amd-gfx.lists.freedesktop.org

Applied.  Sorry for the delay.

Alex

On Fri, Feb 22, 2019 at 10:36 AM Nathan Chancellor
<natechancellor@gmail.com> wrote:
>
> On Mon, Dec 10, 2018 at 04:42:01PM -0700, Nathan Chancellor wrote:
> > Clang warns when an expression that equals zero is used as a null
> > pointer constant (in lieu of NULL):
> >
> > drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/amdgpu_dm.c:4435:3:
> > warning: expression which evaluates to zero treated as a null pointer
> > constant of type 'const enum color_transfer_func *'
> > [-Wnon-literal-null-conversion]
> >                 TRANSFER_FUNC_UNKNOWN,
> >                 ^~~~~~~~~~~~~~~~~~~~~
> > 1 warning generated.
> >
> > This warning is caused by commit bb47de736661 ("drm/amdgpu: Set FreeSync
> > state using drm VRR properties") and it could be solved by using NULL
> > instead of TRANSFER_FUNC_UNKNOWN or casting TRANSFER_FUNC_UNKNOWN as a
> > pointer. However, after looking into it, there doesn't appear to be a
> > good reason to pass app_tf by reference as it is never mutated along the
> > way. This is the only code path in which app_tf is used:
> >
> > mod_freesync_build_vrr_infopacket ->
> >     build_vrr_infopacket_v2 ->
> >         build_vrr_infopacket_fs2_data
> >
> > Neither mod_freesync_build_vrr_infopacket or build_vrr_infopacket_v2
> > modify app_tf's value and build_vrr_infopacket_fs2_data expects just
> > the value so we can avoid dereferencing anything by just passing in
> > app_tf's value to mod_freesync_build_vrr_infopacket and
> > build_vrr_infopacket_v2.
> >
> > There is no functional change because build_vrr_infopacket_fs2_data
> > doesn't do anything if TRANSFER_FUNC_UNKNOWN is passed to it, the same
> > as not calling build_vrr_infopacket_fs2_data at all like before this
> > change when NULL was used for app_tf.
> >
> > Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
> > ---
> >  drivers/gpu/drm/amd/display/modules/freesync/freesync.c | 7 +++----
> >  drivers/gpu/drm/amd/display/modules/inc/mod_freesync.h  | 2 +-
> >  2 files changed, 4 insertions(+), 5 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/amd/display/modules/freesync/freesync.c b/drivers/gpu/drm/amd/display/modules/freesync/freesync.c
> > index 620a171620ee..520665a9d81a 100644
> > --- a/drivers/gpu/drm/amd/display/modules/freesync/freesync.c
> > +++ b/drivers/gpu/drm/amd/display/modules/freesync/freesync.c
> > @@ -656,7 +656,7 @@ static void build_vrr_infopacket_v1(enum signal_type signal,
> >
> >  static void build_vrr_infopacket_v2(enum signal_type signal,
> >               const struct mod_vrr_params *vrr,
> > -             const enum color_transfer_func *app_tf,
> > +             enum color_transfer_func app_tf,
> >               struct dc_info_packet *infopacket)
> >  {
> >       unsigned int payload_size = 0;
> > @@ -664,8 +664,7 @@ static void build_vrr_infopacket_v2(enum signal_type signal,
> >       build_vrr_infopacket_header_v2(signal, infopacket, &payload_size);
> >       build_vrr_infopacket_data(vrr, infopacket);
> >
> > -     if (app_tf != NULL)
> > -             build_vrr_infopacket_fs2_data(*app_tf, infopacket);
> > +     build_vrr_infopacket_fs2_data(app_tf, infopacket);
> >
> >       build_vrr_infopacket_checksum(&payload_size, infopacket);
> >
> > @@ -676,7 +675,7 @@ void mod_freesync_build_vrr_infopacket(struct mod_freesync *mod_freesync,
> >               const struct dc_stream_state *stream,
> >               const struct mod_vrr_params *vrr,
> >               enum vrr_packet_type packet_type,
> > -             const enum color_transfer_func *app_tf,
> > +             enum color_transfer_func app_tf,
> >               struct dc_info_packet *infopacket)
> >  {
> >       /* SPD info packet for FreeSync */
> > diff --git a/drivers/gpu/drm/amd/display/modules/inc/mod_freesync.h b/drivers/gpu/drm/amd/display/modules/inc/mod_freesync.h
> > index 949a8b62aa98..063af6258fd9 100644
> > --- a/drivers/gpu/drm/amd/display/modules/inc/mod_freesync.h
> > +++ b/drivers/gpu/drm/amd/display/modules/inc/mod_freesync.h
> > @@ -145,7 +145,7 @@ void mod_freesync_build_vrr_infopacket(struct mod_freesync *mod_freesync,
> >               const struct dc_stream_state *stream,
> >               const struct mod_vrr_params *vrr,
> >               enum vrr_packet_type packet_type,
> > -             const enum color_transfer_func *app_tf,
> > +             enum color_transfer_func app_tf,
> >               struct dc_info_packet *infopacket);
> >
> >  void mod_freesync_build_vrr_params(struct mod_freesync *mod_freesync,
> > --
> > 2.20.0
> >
>
> Gentle ping on this patch, it would be nice to get this fixed and into
> 5.1!
>
> Thanks,
> Nathan
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
