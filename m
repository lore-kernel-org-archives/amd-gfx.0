From: Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH] drm/amd/display: add -msse2 to prevent Clang from
 emitting libcalls to undefined SW FP routines
Date: Tue, 29 Jan 2019 10:56:01 -0800
Message-ID: <20190129185601.GA17525@roeck-us.net>
References: <20190125005304.183322-1-ndesaulniers@google.com>
 <04bc6844-2a3b-2de8-60a7-a027149709fd@amd.com>
 <CADnq5_OuSD7Bmeg3CP0Y6JTo9Xso2FTZ3tKk-u1C+-B32eUGmQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <stable-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CADnq5_OuSD7Bmeg3CP0Y6JTo9Xso2FTZ3tKk-u1C+-B32eUGmQ@mail.gmail.com>
Sender: stable-owner@vger.kernel.org
To: Alex Deucher <alexdeucher@gmail.com>
Cc: "Wentland, Harry" <Harry.Wentland@amd.com>, "ndesaulniers@google.com" <ndesaulniers@google.com>, "airlied@linux.ie" <airlied@linux.ie>, "daniel@ffwll.ch" <daniel@ffwll.ch>, "S@google.com" <S@google.com>, "Laktyushkin, Dmytro" <Dmytro.Laktyushkin@amd.com>, "Zhou, David(ChunMing)" <David1.Zhou@amd.com>, "Li, Sun peng (Leo)" <Sunpeng.Li@amd.com>, "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>, "Daenzer, Michel" <Michel.Daenzer@amd.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "stable@vger.kernel.org" <stable@vger.kernel.org>, "S, Shirish" <Shirish.S@amd.com>, Matthias Kaehlcke <mka@google.com>, Matthias Kaehlcke <mka@chromium.org>, "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, James Y Knight <jyknight@googl>
List-Id: amd-gfx.lists.freedesktop.org

On Tue, Jan 29, 2019 at 10:30:31AM -0500, Alex Deucher wrote:
> On Fri, Jan 25, 2019 at 10:29 AM Wentland, Harry <Harry.Wentland@amd.com> wrote:
> >
> > On 2019-01-24 7:52 p.m., ndesaulniers@google.com wrote:
> > > arch/x86/Makefile disables SSE and SSE2 for the whole kernel.  The
> > > AMDGPU drivers modified in this patch re-enable SSE but not SSE2.  Turn
> > > on SSE2 to support emitting double precision floating point instructions
> > > rather than calls to non-existent (usually available from gcc_s or
> > > compiler_rt) floating point helper routines.
> > >
> > > Link: https://gcc.gnu.org/onlinedocs/gccint/Soft-float-library-routines.html
> > > Link: https://github.com/ClangBuiltLinux/linux/issues/327
> > > Cc: stable@vger.kernel.org # 4.19
> > > Reported-by: S, Shirish <Shirish.S@amd.com>
> > > Reported-by: Matthias Kaehlcke <mka@google.com>
> > > Suggested-by: James Y Knight <jyknight@google.com>
> > > Suggested-by: Nathan Chancellor <natechancellor@gmail.com>
> > > Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>
> > > Tested-by: Guenter Roeck <linux@roeck-us.net>
> >
> > Reviewed-by: Harry Wentland <harry.wentland@amd.com>
> >
> > and applied.
> >
> 
> This patch causes a segfault:
> https://bugs.freedesktop.org/show_bug.cgi?id=109487
> 
> Any ideas?
> 

Set -msse2 only for clang ? I suspect, though, that this might only
solve the compile problem. If I understand correctly, the first
warning in the log is due to BREAK_TO_DEBUGGER(), suggesting that
something is seriously wrong. Maybe enabling sse2 results in different
results from floating point operations.

Unfortunately I don't have a system with the affected GPU,
so I can't run any tests on real hardware. Unless someone can test
with real hardware, I think we have no choice but to revert the
patch.

Guenter

> Alex
> 
> > Harry
> >
> > > ---
> > >  drivers/gpu/drm/amd/display/dc/calcs/Makefile | 2 +-
> > >  drivers/gpu/drm/amd/display/dc/dml/Makefile   | 2 +-
> > >  2 files changed, 2 insertions(+), 2 deletions(-)
> > >
> > > diff --git a/drivers/gpu/drm/amd/display/dc/calcs/Makefile b/drivers/gpu/drm/amd/display/dc/calcs/Makefile
> > > index 95f332ee3e7e..dc85a3c088af 100644
> > > --- a/drivers/gpu/drm/amd/display/dc/calcs/Makefile
> > > +++ b/drivers/gpu/drm/amd/display/dc/calcs/Makefile
> > > @@ -30,7 +30,7 @@ else ifneq ($(call cc-option, -mstack-alignment=16),)
> > >       cc_stack_align := -mstack-alignment=16
> > >  endif
> > >
> > > -calcs_ccflags := -mhard-float -msse $(cc_stack_align)
> > > +calcs_ccflags := -mhard-float -msse -msse2 $(cc_stack_align)
> > >
> > >  CFLAGS_dcn_calcs.o := $(calcs_ccflags)
> > >  CFLAGS_dcn_calc_auto.o := $(calcs_ccflags)
> > > diff --git a/drivers/gpu/drm/amd/display/dc/dml/Makefile b/drivers/gpu/drm/amd/display/dc/dml/Makefile
> > > index d97ca6528f9d..33c7d7588712 100644
> > > --- a/drivers/gpu/drm/amd/display/dc/dml/Makefile
> > > +++ b/drivers/gpu/drm/amd/display/dc/dml/Makefile
> > > @@ -30,7 +30,7 @@ else ifneq ($(call cc-option, -mstack-alignment=16),)
> > >       cc_stack_align := -mstack-alignment=16
> > >  endif
> > >
> > > -dml_ccflags := -mhard-float -msse $(cc_stack_align)
> > > +dml_ccflags := -mhard-float -msse -msse2 $(cc_stack_align)
> > >
> > >  CFLAGS_display_mode_lib.o := $(dml_ccflags)
> > >  CFLAGS_display_pipe_clocks.o := $(dml_ccflags)
> > >
> > _______________________________________________
> > amd-gfx mailing list
> > amd-gfx@lists.freedesktop.org
> > https://lists.freedesktop.org/mailman/listinfo/amd-gfx
