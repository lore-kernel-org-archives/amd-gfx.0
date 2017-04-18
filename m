From: Pekka Paalanen <ppaalanen-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [RfC PATCH] drm: fourcc byteorder: brings header file comments
 in line with reality.
Date: Tue, 18 Apr 2017 17:01:34 +0300
Message-ID: <20170418170134.0a60d340@eldfell>
References: <20170410101202.19229-1-kraxel@redhat.com>
 <20170410161214.305f5daf@eldfell>
 <1491833847.30990.77.camel@redhat.com>
 <20170410180941.43922e25@eldfell>
 <1492509617.27392.19.camel@redhat.com>
 <20170418141827.11634103@eldfell>
 <1492522793.27392.55.camel@redhat.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1247657281=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <1492522793.27392.55.camel-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/amd-gfx>,
 <mailto:amd-gfx-request-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
List-Help: <mailto:amd-gfx-request-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org?subject=subscribe>
Errors-To: amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Sender: "amd-gfx" <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
To: Gerd Hoffmann <kraxel-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: Daniel Vetter <daniel.vetter-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, Ilia Mirkin <imirkin-FrUbXkNCsVf2fBVCVOL8/A@public.gmane.org>, open list <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org

--===============1247657281==
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/UaswdG81tB=TtNOlZHYMFWS"; protocol="application/pgp-signature"

--Sig_/UaswdG81tB=TtNOlZHYMFWS
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Tue, 18 Apr 2017 15:39:53 +0200
Gerd Hoffmann <kraxel-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org> wrote:

>   Hi,
>=20
> > > Historical note:  RHEL-6.9 (gnome 2) works fine.  Not of much interest
> > > here, it drives the qemu stdvga with offb, not bochs-drm. =20
> >=20
> > I suppose this proves the virtual machine itself is correct about
> > framebuffer endianess? Except you are running it on a little-endian
> > host machine I presume... =20
>=20
> Yes, little endian host, qemu interprets the framebuffer as
> PIXMAN_b8g8r8x8.  Which should be correct for a xrgb bigendian
> framebuffer as pixman formats are native endian.

Right. Very nice if we can trust the virtual machine at least getting
things right, gives some chance for people to test anything. Except...
that's a question of what kind of hardware the virtual machine
emulates. The display device defines what endianess it uses on
framebuffers, not the CPU, right?

> > > More interesting:  RHEL-7.3 (gnome 3.14) works fine too.  kernel 3.10,
> > > but drm drivers updated to roughly 4.6 level.  Runs bochs-drm.  mesa
> > > 11.2.2.  glamour not used.
> > >=20
> > > Most recent:  Fedora 25 (gnome 3.22) looks mostly ok, but there are
> > > rendering glitches, for example in the gnome activities screen (the o=
ne
> > > you get when you press the windows key).  kernel 4.10, mesa 13.0.4.
> > > glamor not used, but I think gnome-shell uses opengl (via llvmpipe) f=
or
> > > compositing. =20
> >=20
> > I believe glitches are irrelevant for this topic, what we are
> > interested in is if the colors are right or byte-swapped (also mind
> > alpha/blue etc. swaps). =20
>=20
> Well, I mean color glitches.  But it isn't consistent.  As if some
> operations operate with the correct byteorder and some don't.
> alpha/blue being swapped is a problem in some areas.
>=20
> https://www.kraxel.org/tmp/

Ooh, yeah, that's definitely bonkers.

Maybe the 100% blue things are supposed to be a transparent blended
overlays, like highlights.

The icons look somehow... not completely right to me. Somehow washed
out?

Opaque gray shades are hard to tell right from wrong.

gnome-terminal and the wallpaper look right, but those might be the
only things.

Having a compositing manager complicates things.


Thanks,
pq

--Sig_/UaswdG81tB=TtNOlZHYMFWS
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEJQjwWQChkWOYOIONI1/ltBGqqqcFAlj2HD4ACgkQI1/ltBGq
qqeAMQ//QC6YNcMihtNrPooWZqGsAhMeO3AxXC3RXZtAsgwKfvBrxzI2Rx8Y5o3B
CP3gWiCC7P5aOaBL9Xd9QspuYF7iLSlcbIH01FMjm2HmTQOkqf6I9eZ/AGsy4Csn
RrnQ2nPPa8mvAcyejSARUsg/v6b2XbzzBGVLali7JkA3P0eT2crDsg1x0DxusY8g
FNRyuNwqSZyyTUNC3vZO4EXF2Z6Zw33hFeVJClSelfCiSk4sp9sXyLY86tWfGALx
FXI6/3d4rcXcSYUpsjZXua39q2vi41PIWmFsfLQM29TozCF8fpH/1clYlgtvFlnV
uW5SRMqSOZr7zGJXvx6HqwwiJknbtJPFtg1GPX5SbjpvBG9PfKyrhB5TMK8NPuTr
+lKcMNhihCfmHTJ3AmRvT12IMbi2AaF5s93tnoMOhucY6Bj7g9/qWm3azBpQ23Xa
FoVcmFNhPj/CG2zKoVgXikDWQvKnD0DzOmgf+L++YfOJ9odAA7HznI/HyZAqLJAX
3NoX9azD2zb99wfboe8LfrlcK8KkrX0UUD4bcpeFMyo+ax5KGEknx4nonbqTKdl2
oVs2HRwPk7b3kBZxMt6laQhAuaeKssGg094dXJFTOrBDVMi28amX6pXkQ337Env8
4dGHE2e6xug20r4OgY9Tylzl0dXZW5Xj+8JK7sZT9ukkln2V/P8=
=fpfx
-----END PGP SIGNATURE-----

--Sig_/UaswdG81tB=TtNOlZHYMFWS--

--===============1247657281==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============1247657281==--
