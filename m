From: Daniel Vetter <daniel@ffwll.ch>
Subject: Re: [Intel-gfx] [PATCH v2] drm: prefix header search paths with
 $(srctree)/
Date: Fri, 26 Apr 2019 17:05:05 +0200
Message-ID: <20190426150505.GA3271@phenom.ffwll.local>
References: <1553859161-2628-1-git-send-email-yamada.masahiro@socionext.com>
 <CAK7LNAR6bT93kmyPCzJg2ZFvk239nz0nyVX5z23G+8Y0Wiba1Q@mail.gmail.com>
 <CAPM=9txpmjQqh0eLA1sMjcDatQG83vk=juLehiUDi=sBO+c9Tg@mail.gmail.com>
 <8d04d30e86a54b3e9b27b30ac0ab3822@SOC-EX01V.e01.socionext.com>
 <CAPM=9tyRHNp2R_No_0Gx0N59XR2RvD4=1G2GWgLLDxmKNk6JVg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAPM=9tyRHNp2R_No_0Gx0N59XR2RvD4=1G2GWgLLDxmKNk6JVg@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Dave Airlie <airlied@gmail.com>
Cc: Masahiro Yamada <yamada.masahiro@socionext.com>, Dave Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>, dri-devel <dri-devel@lists.freedesktop.org>, nouveau <nouveau@lists.freedesktop.org>, Sam Ravnborg <sam@ravnborg.org>, zhoucm1 <David1.Zhou@amd.com>, amd-gfx mailing list <amd-gfx@lists.freedesktop.org>, "James (Qian) Wang" <james.qian.wang@arm.com>, Ben Skeggs <bskeggs@redhat.com>, linux-arm-msm <linux-arm-msm@vger.kernel.org>, Intel Graphics Development <intel-gfx@lists.freedesktop.org>, intel-gvt-dev@lists.freedesktop.org, LKML <linux-kernel@vger.kernel.org>, "Koenig, Christian" <christian.koenig@amd.com>, "Deucher, Alexander" <alexander.deucher@amd.com>, freedreno@lists.freedesktop.org
List-Id: amd-gfx.lists.freedesktop.org

On Fri, Apr 26, 2019 at 12:56:48PM +1000, Dave Airlie wrote:
> Daniel, drm-misc-next-fixes?

Makes sense. Pushed.

Cheers, Daniel

> 
> Dave.
> 
> On Fri, 26 Apr 2019 at 12:25, <yamada.masahiro@socionext.com> wrote:
> >
> > Hi Dave,
> >
> > > -----Original Message-----
> > > From: Dave Airlie [mailto:airlied@gmail.com]
> > > Sent: Friday, April 26, 2019 11:19 AM
> > > To: Yamada, Masahiro/山田 真弘 <yamada.masahiro@socionext.com>
> > > Cc: David Airlie <airlied@linux.ie>; Daniel Vetter <daniel@ffwll.ch>;
> > > dri-devel <dri-devel@lists.freedesktop.org>; nouveau
> > > <nouveau@lists.freedesktop.org>; Sam Ravnborg <sam@ravnborg.org>; David
> > > (ChunMing) Zhou <David1.Zhou@amd.com>; amd-gfx mailing list
> > > <amd-gfx@lists.freedesktop.org>; James (Qian) Wang
> > > <james.qian.wang@arm.com>; Ben Skeggs <bskeggs@redhat.com>;
> > > linux-arm-msm <linux-arm-msm@vger.kernel.org>; Intel Graphics
> > > Development <intel-gfx@lists.freedesktop.org>;
> > > intel-gvt-dev@lists.freedesktop.org; Linux Kernel Mailing List
> > > <linux-kernel@vger.kernel.org>; Christian König
> > > <christian.koenig@amd.com>; Alex Deucher <alexander.deucher@amd.com>;
> > > freedreno@lists.freedesktop.org
> > > Subject: Re: [Intel-gfx] [PATCH v2] drm: prefix header search paths with
> > > $(srctree)/
> > >
> > > On Fri, 26 Apr 2019 at 11:46, Masahiro Yamada
> > > <yamada.masahiro@socionext.com> wrote:
> > > >
> > > > Hi.
> > > >
> > > >
> > > > On Fri, Mar 29, 2019 at 8:37 PM Masahiro Yamada
> > > > <yamada.masahiro@socionext.com> wrote:
> > > > >
> > > > > Currently, the Kbuild core manipulates header search paths in a crazy
> > > > > way [1].
> > > > >
> > > > > To fix this mess, I want all Makefiles to add explicit $(srctree)/ to
> > > > > the search paths in the srctree. Some Makefiles are already written
> > > in
> > > > > that way, but not all. The goal of this work is to make the notation
> > > > > consistent, and finally get rid of the gross hacks.
> > > > >
> > > > > Having whitespaces after -I does not matter since commit 48f6e3cf5bc6
> > > > > ("kbuild: do not drop -I without parameter").
> > > > >
> > > > > [1]: https://patchwork.kernel.org/patch/9632347/
> > > > >
> > > > > Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> > > > > Reviewed-by: Sam Ravnborg <sam@ravnborg.org>
> > > > > ---
> > > > >
> > > > > I put all gpu/drm changes into a single patch because
> > > > > they are trivial conversion.
> > > > >
> > > > > If you are interested in the big picture of this work,
> > > > > the full patch set is available at the following URL.
> > > > >
> > > > >
> > > git://git.kernel.org/pub/scm/linux/kernel/git/masahiroy/linux-kbuild.g
> > > it build-test
> > > >
> > > >
> > > > Is somebody taking care of this?
> > > >
> > >
> > > Are you expecting this to be merged in the drm tree? if so please
> > > indicate that when posting.
> >
> >
> > Sorry for unclearness.
> >
> > Could you apply this to your drm tree?
> >
> > Thanks.
> >
> >
> >
> >
> > > I'd assumed this would go via kbuild tree.
> > >
> > > If the later,
> > > Acked-by: Dave Airlie <airlied@redhat.com>
> > > Dave.

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
