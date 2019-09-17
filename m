From: Kees Cook <keescook@google.com>
Subject: Re: linux-next: Tree for Sep 4 (amd/display/)
Date: Mon, 16 Sep 2019 20:42:27 -0700
Message-ID: <CAGXu5jJ-LzJx1Fr8b2b4xv9i9yG99CPc8SUoT3eF44kO0G7tYg@mail.gmail.com>
References: <20190904233443.3f73c46b@canb.auug.org.au> <6b70fdfd-1f18-1e55-2574-7be5997cfb2a@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <6b70fdfd-1f18-1e55-2574-7be5997cfb2a@infradead.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Randy Dunlap <rdunlap@infradead.org>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, Linux Next Mailing List <linux-next@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, dri-devel <dri-devel@lists.freedesktop.org>, amd-gfx list <amd-gfx@lists.freedesktop.org>, Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>
List-Id: amd-gfx.lists.freedesktop.org

On Wed, Sep 4, 2019 at 1:58 PM Randy Dunlap <rdunlap@infradead.org> wrote:
>
> On 9/4/19 6:34 AM, Stephen Rothwell wrote:
> > Hi all,
> >
> > News: this will be the last linux-next I will release until Sept 30.
> >
> > Changes since 20190903:
> >
>
> on x86_64:
>
> In file included from ../drivers/gpu/drm/amd/amdgpu/../display/dc/dml/dcn=
20/display_rq_dlg_calc_20v2.c:77:0:
> ../drivers/gpu/drm/amd/amdgpu/../display/dc/dml/dcn20/../dml_inline_defs.=
h: In function =E2=80=98dml_min=E2=80=99:
> ../drivers/gpu/drm/amd/amdgpu/../display/dc/dml/dcn20/../dml_inline_defs.=
h:34:1: error: SSE register return with SSE disabled

I'm still tripping over this too. What compilers are people building
with where this is NOT happening for an allmodconfig?

I'm using:
gcc (Ubuntu 7.4.0-1ubuntu1~18.04.1) 7.4.0

But it happens on newer compilers too.

--=20
Kees Cook
