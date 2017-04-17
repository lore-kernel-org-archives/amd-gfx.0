From: Ilia Mirkin <imirkin@alum.mit.edu>
Subject: Re: [RfC PATCH] drm: fourcc byteorder: brings header file comments in
 line with reality.
Date: Mon, 17 Apr 2017 02:43:44 -0400
Message-ID: <CAKb7UvgVD3Uf79noXMOcBjJYeeF6st21R3JBNvT-VVSNb8EH+Q@mail.gmail.com>
References: <20170410101202.19229-1-kraxel@redhat.com> <20170410161214.305f5daf@eldfell>
 <1491833847.30990.77.camel@redhat.com> <20170410180941.43922e25@eldfell>
 <CAKb7UvhbgSGwx-2EsrQrHmghzYqO9AhRQ10bDWKfdcXHc3fJeQ@mail.gmail.com>
 <20170411103101.0497fe08@eldfell> <CAKb7UviNeLJAHtBQt2NgbEMOSz1sYneiB7i0CUDOBQRt=8OqNw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAKb7UviNeLJAHtBQt2NgbEMOSz1sYneiB7i0CUDOBQRt=8OqNw@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Pekka Paalanen <ppaalanen@gmail.com>
Cc: Gerd Hoffmann <kraxel@redhat.com>, "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>, open list <linux-kernel@vger.kernel.org>, amd-gfx@lists.freedesktop.org, Daniel Vetter <daniel.vetter@intel.com>
List-Id: amd-gfx.lists.freedesktop.org

On Tue, Apr 11, 2017 at 10:18 AM, Ilia Mirkin <imirkin@alum.mit.edu> wrote:
>> However, I totally agree with Alex that someone with a BE machine
>> should review the whole stack before we could be confident with anything=
.
>
> Here's what I'm confident about: xf86-video-nouveau worked just fine
> on top of kernel 4.3 on an AGP GeForce FX 5200 (with AGPGART turned
> off because ... well ... uninorth). fbcon/fbdev accel worked,
> xf86-video-nouveau's 2d accel worked, and simple demos (ala glxgears)
> worked after I fixed up mesa and nv30 driver items in version ... 11.1
> it seems. As I recall it had gotten all broken in 10.0 or so by Adam
> Jackson in the name of making llvmpipe work on BE, declaring all other
> drivers broken, with various fixes by Michel D=C3=A4nzer to get it back t=
o
> working over the years.
>
> Anyone "fixing" the stack has to maintain that level of functioning
> through their various fixing.
>
> I will double-check that the above still works with the latest
> kernel/xorg/xf86-video-nouveau/mesa and report back (hopefully by this
> weekend). If there are any patches you'd like me to test, now's the
> time to ask -- getting the box up and running is the hard part,
> booting up an extra kernel -- easy.

OK, so I revived my PowerMac7,3 G5 setup (PPC64 BE, NV34 GPU). Booted
it with an upstream 4.11-rc7 kernel, loaded up the nouveau kernel
module (which is included in that kernel), updated X to 1.19.2 and
mesa to 17.0.3. Everything works fine. Specifically:

fbcon on top of fbdev provided by nouveau -- colors are fine
glxgears hw-accelerated by mesa on top of xf86-video-nouveau using
DRI2 -- colors are fine
glxgears softpipe-accelerated by mesa on top of xf86-video-nouveau --
colors are fine
glxgears softpipe-accelerated by mesa on top of xf86-video-modesetting
-- colors are fine
xterm on top of xf86-video-nouveau -- colors are fine
xterm on top of xf86-video-modesetting -- colors are fine

I couldn't test anything with GLAMOR since GLAMOR requires GL 2.1 or
higher, whereas nouveau's NV3x acceleration only provides GL 1.5 (due
to lacking NPOT and a handful of other things).

The modetest utility did have trouble with AR24 and I'm pretty sure
the XR24 pattern was off too. However I wouldn't be surprised if the
modetest utility itself had endian issues in the pattern generation
logic. (Seems to be the case, based on a quick glance at the
tests/util/format.c logic and how it's used in pattern.c.)

So in short, I think the current definitions of format are fine.

Cheers,

  -ilia
