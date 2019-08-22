From: Alex Deucher <alexdeucher@gmail.com>
Subject: Re: [PATCH] drm/amd/display: Fix 32-bit divide error in wait_for_alt_mode
Date: Wed, 21 Aug 2019 22:12:50 -0400
Message-ID: <CADnq5_PH6gA2kMi5+sT4N=AQdfJkEg4ZhoZtYduLTDAyUT7cBA@mail.gmail.com>
References: <20190820235713.3429-1-natechancellor@gmail.com> <f594d746-9eaf-76fe-d380-bb033cce06f8@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <f594d746-9eaf-76fe-d380-bb033cce06f8@amd.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Harry Wentland <hwentlan@amd.com>
Cc: Nathan Chancellor <natechancellor@gmail.com>, "Wentland, Harry" <Harry.Wentland@amd.com>, "Li, Sun peng (Leo)" <Sunpeng.Li@amd.com>, "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Koenig, Christian" <Christian.Koenig@amd.com>, "Zhou, David(ChunMing)" <David1.Zhou@amd.com>, Randy Dunlap <rdunlap@infradead.org>, "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>, "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: amd-gfx.lists.freedesktop.org

Applied.  thanks!

Alex

On Wed, Aug 21, 2019 at 12:40 PM Harry Wentland <hwentlan@amd.com> wrote:
>
> On 2019-08-20 7:57 p.m., Nathan Chancellor wrote:
> > When building arm32 allyesconfig:
> >
> > ld.lld: error: undefined symbol: __aeabi_uldivmod
> >>>> referenced by dc_link.c
> >>>> gpu/drm/amd/display/dc/core/dc_link.o:(wait_for_alt_mode) in archive drivers/built-in.a
> >>>> referenced by dc_link.c
> >>>> gpu/drm/amd/display/dc/core/dc_link.o:(wait_for_alt_mode) in archive drivers/built-in.a
> >
> > time_taken_in_ns is of type unsigned long long so we need to use div_u64
> > to avoid this error.
> >
> > Fixes: b5b1f4554904 ("drm/amd/display: Enable type C hotplug")
> > Reported-by: Randy Dunlap <rdunlap@infradead.org>
> > Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
>
> Reviewed-by: Harry Wentland <harry.wentland@amd.com>
>
> Harry
>
> > ---
> >  drivers/gpu/drm/amd/display/dc/core/dc_link.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link.c b/drivers/gpu/drm/amd/display/dc/core/dc_link.c
> > index f2d78d7b089e..8634923b4444 100644
> > --- a/drivers/gpu/drm/amd/display/dc/core/dc_link.c
> > +++ b/drivers/gpu/drm/amd/display/dc/core/dc_link.c
> > @@ -721,7 +721,7 @@ bool wait_for_alt_mode(struct dc_link *link)
> >                       time_taken_in_ns = dm_get_elapse_time_in_ns(
> >                               link->ctx, finish_timestamp, enter_timestamp);
> >                       DC_LOG_WARNING("Alt mode entered finished after %llu ms\n",
> > -                                    time_taken_in_ns / 1000000);
> > +                                    div_u64(time_taken_in_ns, 1000000));
> >                       return true;
> >               }
> >
> > @@ -730,7 +730,7 @@ bool wait_for_alt_mode(struct dc_link *link)
> >       time_taken_in_ns = dm_get_elapse_time_in_ns(link->ctx, finish_timestamp,
> >                                                   enter_timestamp);
> >       DC_LOG_WARNING("Alt mode has timed out after %llu ms\n",
> > -                     time_taken_in_ns / 1000000);
> > +                     div_u64(time_taken_in_ns, 1000000));
> >       return false;
> >  }
> >
> >
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
