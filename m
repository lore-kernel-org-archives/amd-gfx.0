From: Alex Deucher <alexdeucher@gmail.com>
Subject: Re: [PATCH] drm/amd/display: fix compilation error
Date: Thu, 13 Jun 2019 14:52:34 -0400
Message-ID: <CADnq5_OSjJad7QGOCrWQL+LcjtCHQsCefpJ=K0mYUayFe9bUAA@mail.gmail.com>
References: <20190613023208.GA29690@hari-Inspiron-1545> <CADnq5_PU_jvOskC-=+oRQdvYXZvu_n26ogoWTxLRxnW+ke4wDw@mail.gmail.com>
 <20190613184217.GA2385@ravnborg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190613184217.GA2385@ravnborg.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Sam Ravnborg <sam@ravnborg.org>
Cc: Hariprasad Kelam <hariprasad.kelam@gmail.com>, LKML <linux-kernel@vger.kernel.org>, Yongqiang Sun <yongqiang.sun@amd.com>, Charlene Liu <charlene.liu@amd.com>, Leo Li <sunpeng.li@amd.com>, Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>, Gloria Li <geling.li@amd.com>, amd-gfx list <amd-gfx@lists.freedesktop.org>, Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>, David Airlie <airlied@linux.ie>, Dmytro Laktyushkin <Dmytro.Laktyushkin@amd.com>, Tony Cheng <tony.cheng@amd.com>, Maling list - DRI developers <dri-devel@lists.freedesktop.org>, Alex Deucher <alexander.deucher@amd.com>, =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, Anthony Koo <Anthony.Koo@amd.com>
List-Id: amd-gfx.lists.freedesktop.org

On Thu, Jun 13, 2019 at 2:42 PM Sam Ravnborg <sam@ravnborg.org> wrote:
>
> Hi Alex.
>
> On Wed, Jun 12, 2019 at 10:35:26PM -0400, Alex Deucher wrote:
> > On Wed, Jun 12, 2019 at 10:34 PM Hariprasad Kelam
> > <hariprasad.kelam@gmail.com> wrote:
> > >
> > > this patch fixes below compilation error
> > >
> > > drivers/gpu/drm/amd/amdgpu/../display/dc/dcn10/dcn10_hw_sequencer.c: =
In
> > > function =E2=80=98dcn10_apply_ctx_for_surface=E2=80=99:
> > > drivers/gpu/drm/amd/amdgpu/../display/dc/dcn10/dcn10_hw_sequencer.c:2=
378:3:
> > > error: implicit declaration of function =E2=80=98udelay=E2=80=99
> > > [-Werror=3Dimplicit-function-declaration]
> > >    udelay(underflow_check_delay_us);
> > >
> > > Signed-off-by: Hariprasad Kelam <hariprasad.kelam@gmail.com>
>
> Am I right in assuming you took this patch?
>
> I expect that new code using udelay was added to the amd tree,
> and when merged with drm-misc-next it failed, because drm-misc-next no
> longer had drmP.h included so no implicit include of delay.h
>
> The root cause was that my original patchset should have been based
> on the amd tree, and applied there :-(

No worries.  I've picked it up.

Alex
