From: Pekka Paalanen <ppaalanen-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [RfC PATCH] drm: fourcc byteorder: brings header file comments
 in line with reality.
Date: Tue, 18 Apr 2017 14:18:27 +0300
Message-ID: <20170418141827.11634103@eldfell>
References: <20170410101202.19229-1-kraxel@redhat.com>
 <20170410161214.305f5daf@eldfell>
 <1491833847.30990.77.camel@redhat.com>
 <20170410180941.43922e25@eldfell>
 <1492509617.27392.19.camel@redhat.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1113203581=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <1492509617.27392.19.camel-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
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

--===============1113203581==
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/JzYdbC+OYXTZkYx6m1+/x8+"; protocol="application/pgp-signature"

--Sig_/JzYdbC+OYXTZkYx6m1+/x8+
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Tue, 18 Apr 2017 12:00:17 +0200
Gerd Hoffmann <kraxel-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org> wrote:

>   Hi,
>=20
> > > ppc64 (big endian) virtual machine, running with qemu stdvga & bochs-=
drm
> > > driver.  Xorg with modesetting driver uses DRM_FORMAT_XRGB8888 (one a=
nd
> > > only format supported by bochs-drm), and we have to interpret that in
> > > bigendian byte order on the host side to get a correct display. =20
> >=20
> > I wonder if that is just an oversight from trying to match OpenGL
> > formats to DRM formats. It's full of gotcha's.
> >=20
> > Did you try with GLAMOR? Do you see a difference with and without
> > GLAMOR? Hmm, but you have no GPU support, so GLAMOR would be through a
> > Mesa software renderer? I think I heard someone say something about
> > Mesa software on BE... =20
>=20
> So, did some more testing to see where we stand.
>=20
> Historical note:  RHEL-6.9 (gnome 2) works fine.  Not of much interest
> here, it drives the qemu stdvga with offb, not bochs-drm.

I suppose this proves the virtual machine itself is correct about
framebuffer endianess? Except you are running it on a little-endian
host machine I presume...

> More interesting:  RHEL-7.3 (gnome 3.14) works fine too.  kernel 3.10,
> but drm drivers updated to roughly 4.6 level.  Runs bochs-drm.  mesa
> 11.2.2.  glamour not used.
>=20
> Most recent:  Fedora 25 (gnome 3.22) looks mostly ok, but there are
> rendering glitches, for example in the gnome activities screen (the one
> you get when you press the windows key).  kernel 4.10, mesa 13.0.4.
> glamor not used, but I think gnome-shell uses opengl (via llvmpipe) for
> compositing.

I believe glitches are irrelevant for this topic, what we are
interested in is if the colors are right or byte-swapped (also mind
alpha/blue etc. swaps).

> btw: is there some way to start a wayland session from a shell (i.e.
> what startx does for xorg)?

Depends on which display server you want to start I believe. I don't
know about anything else than Weston, which is 'weston' for a
logind-enabled system.


Thanks,
pq

--Sig_/JzYdbC+OYXTZkYx6m1+/x8+
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEJQjwWQChkWOYOIONI1/ltBGqqqcFAlj19gMACgkQI1/ltBGq
qqeUkQ/+LxsGY1AFdaqhYfmRrxJopvHjQrZPqR553ap5vnDM1/ld0ImKPZN0Xt0q
Q13hqu83K6zJ1q7QX/skLwtfCaNRyXk2Yx9HmvvtkujcFG0LPmR15oTqZANGkPbF
NVrno9TJuklyEKBqqy8EPvcQWYx7AvUITI5DHEg0+XlJdEW6k3EaDLsTlK4Gr8Zb
bcOM6myTLvw/oth0YV4d4sgJPvQ6lYsdmpcFd30E3Ss2J3ETGF0TwUWcpKhhG0JB
00ZNcmDNIhrkEDUO/7rVIFhxYVkIwy319ixSrI+eipa/6s+92ZJYE+OyyGBZ4yp0
s3rUlcq8RZB/bpLXW7kHMSfV14TcZeY+TxXSq102mobKHuXP+fjKCmkn0m4A3een
ZONXOLhRGvZYYQ84FcTCU2s5w7kMebaLrib7p/5hjgEVMO6u94TGMAttHINIDSP0
v2dYZMhf75URqQVriWyTLvWkIwW8Ay7Jea3v/jXr5kA+ZPl6znSfCldaTaMDfyYd
E86ku47T19h+kQu1yoF/o2OGfvfNwWJrvQsEfs084kR4qyphibW2iUNa8bewxUb+
V64OocqmTDTth9wLWon9JxS6vf8OM32RVxrT1eMVbHAbS00n9VbMkPnUNX7q/cw0
NyJ+9lqI2cO2BvteCwxWzo7cEhnc03JFGLMt9XF+M2C47lCoQlc=
=1g9y
-----END PGP SIGNATURE-----

--Sig_/JzYdbC+OYXTZkYx6m1+/x8+--

--===============1113203581==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============1113203581==--
