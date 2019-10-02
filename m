From: Alex Deucher <alexdeucher@gmail.com>
Subject: Re: [PATCH 4/6] drm/amd/display: fix dcn21 Makefile for clang
Date: Wed, 2 Oct 2019 12:33:27 -0400
Message-ID: <CADnq5_M9H2R_6KnxutJ2F3ZkZ1FxqPufcyTxwcQ1cdWYFDbdLw@mail.gmail.com>
References: <20191002120136.1777161-1-arnd@arndb.de> <20191002120136.1777161-5-arnd@arndb.de>
 <CADnq5_PkTwTBbQY9JatZD2_sWjdU5_hK7V2GLfviEvMh_QB12Q@mail.gmail.com>
 <CAK8P3a0KMT437okhobg=Vzi5LRDgUO7L-x35LczBGXE2jYLg2A@mail.gmail.com>
 <CADnq5_PWWndBomBOXTYgmFqo+U8f8d8+OdJ5Ym3+a2mgO5=E0A@mail.gmail.com> <CAK8P3a05ZSWcw=XUZrLyjMLY7wCHLKhpe+MF9p5P3URWpAcj+A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAK8P3a05ZSWcw=XUZrLyjMLY7wCHLKhpe+MF9p5P3URWpAcj+A@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: Alex Deucher <alexander.deucher@amd.com>, Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>, =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, "David (ChunMing) Zhou" <David1.Zhou@amd.com>, David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>, LKML <linux-kernel@vger.kernel.org>, Maling list - DRI developers <dri-devel@lists.freedesktop.org>, clang-built-linux <clang-built-linux@googlegroups.com>, amd-gfx list <amd-gfx@lists.freedesktop.org>, Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>
List-Id: amd-gfx.lists.freedesktop.org

On Wed, Oct 2, 2019 at 11:39 AM Arnd Bergmann <arnd@arndb.de> wrote:
>
> On Wed, Oct 2, 2019 at 5:12 PM Alex Deucher <alexdeucher@gmail.com> wrote:
> > On Wed, Oct 2, 2019 at 10:51 AM Arnd Bergmann <arnd@arndb.de> wrote:
>
> > >
> > > Nothing should really change with regards to the -msse flag here, only
> > > the stack alignment flag changed. Maybe there was some other change
> > > in your Makefile that conflicts with my my patch?
> >
> > This patch on top of yours seems to fix it and aligns better with the
> > other Makefiles:
> >
> > diff --git a/drivers/gpu/drm/amd/display/dc/dcn21/Makefile
> > b/drivers/gpu/drm/amd/display/dc/dcn21/Makefile
> > index ef673bffc241..e71f3ee76cd1 100644
> > --- a/drivers/gpu/drm/amd/display/dc/dcn21/Makefile
> > +++ b/drivers/gpu/drm/amd/display/dc/dcn21/Makefile
> > @@ -9,10 +9,10 @@ else ifneq ($(call cc-option, -mstack-alignment=16),)
> >         cc_stack_align := -mstack-alignment=16
> >  endif
> >
> > -CFLAGS_$(AMDDALPATH)/dc/dcn21/dcn21_resource.o := -mhard-float -msse
> > $(cc_stack_align)
> > +CFLAGS_dcn21_resource.o := -mhard-float -msse $(cc_stack_align)
> >
> >  ifdef CONFIG_CC_IS_CLANG
> > -CFLAGS_$(AMDDALPATH)/dc/dcn21/dcn21_resource.o += -msse2
> > +CFLAGS_dcn21_resource.o += -msse2
> >  endif
>
> Ok, so there is clearly a global change that went into your tree, or
> is missing from it:
>
> I see that as of linux-5.4-rc1, I have commit 54b8ae66ae1a ("kbuild: change
>  *FLAGS_<basetarget>.o to take the path relative to $(obj)"), which changed
> all these path names to include the AMDDALPATH.
>
> It seems you are either on an older kernel that does not yet have this,
> or you have applied another patch that reverts it.

Ah, I don't have that patch yet in my tree.  That explains it.

Alex
