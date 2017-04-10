From: Pekka Paalanen <ppaalanen@gmail.com>
Subject: Re: [RfC PATCH] drm: fourcc byteorder: brings header file comments
 in line with reality.
Date: Mon, 10 Apr 2017 18:09:41 +0300
Message-ID: <20170410180941.43922e25@eldfell>
References: <20170410101202.19229-1-kraxel@redhat.com>
 <20170410161214.305f5daf@eldfell>
 <1491833847.30990.77.camel@redhat.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0821860127=="
Return-path: <dri-devel-bounces@lists.freedesktop.org>
In-Reply-To: <1491833847.30990.77.camel@redhat.com>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: Daniel Vetter <daniel.vetter@intel.com>, amd-gfx@lists.freedesktop.org, open list <linux-kernel@vger.kernel.org>, dri-devel@lists.freedesktop.org
List-Id: amd-gfx.lists.freedesktop.org

--===============0821860127==
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/bjYfGNPG_KAQNF17zErGaKm"; protocol="application/pgp-signature"

--Sig_/bjYfGNPG_KAQNF17zErGaKm
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Mon, 10 Apr 2017 16:17:27 +0200
Gerd Hoffmann <kraxel@redhat.com> wrote:

>   Hi,
>=20
> > which software have you used as representative of "reality"? =20
>=20
> ppc64 (big endian) virtual machine, running with qemu stdvga & bochs-drm
> driver.  Xorg with modesetting driver uses DRM_FORMAT_XRGB8888 (one and
> only format supported by bochs-drm), and we have to interpret that in
> bigendian byte order on the host side to get a correct display.

I wonder if that is just an oversight from trying to match OpenGL
formats to DRM formats. It's full of gotcha's.

Did you try with GLAMOR? Do you see a difference with and without
GLAMOR? Hmm, but you have no GPU support, so GLAMOR would be through a
Mesa software renderer? I think I heard someone say something about
Mesa software on BE...

But even if this actually is a valid example of software we must keep
working as is, well, ouch. But if I cannot show that your fix breaks
anything, then I suppose you win. Your proposal would certainly solve
the dilemma we have with wl_shm formats in Wayland.

I also wonder if a real BE machine could have different results than
the virtual machine.


Thanks,
pq

> Didn't try wayland.  Can do, but will take a while.  Don't have a
> wayland-capable guest install at hand, and installing one takes a while
> because I don't have a physical pseries and emulation is slooooww.
>=20
> > To solve that problem, we would like to know if anything existing would
> > break for each possible solution, but no developers using BE have really
> > turned up. =20
>=20
> That is part of the problem.
> And even ppc is moving to little endian these days ...
>=20
> cheers,
>   Gerd
>=20


--Sig_/bjYfGNPG_KAQNF17zErGaKm
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEJQjwWQChkWOYOIONI1/ltBGqqqcFAljroDUACgkQI1/ltBGq
qqcj5RAAgaKuoCK1RxpVHnnpY86K0remWR86i3ujYpQz03MJdgm9muLqPexyrM3v
e5VnbhvgNTy/OaRofrwfUfKd91d3/ZQ1yZUDkuxaYUq0mpCCm9QiRFbalZSIcRlu
YyozO2nJOV4vQNYbxwN0YC84QRAOHw2zR0p3RWNKLVirGZUi950FxX6aCPQY7hGv
4kca+wBc4TRuKs4sJ3E3Lnf+/VXarxVTVQEIpQCWUxpyQN+aqrZh+1dYLVsaA/u3
YLsodADC3Yxrjt5fUHRn1AmVk794oqb1iRYei4HGAp3/mb8CLFuJdaUD5AIKkRb9
pELmO0F18P5gw541f9KMybJVdYJkoG5EX62VxaMq+nAu1hRk3FmQXtAODY0PQb6D
fdz8GZxl+oEioI5ENBv1j7OepYu+4pg70lW8uRa7NqEBAxgl1unQR9hya3BBtAFZ
Lm8NYCZx4hURIsuyWHIHu+Rp9obpVMWqPxig0x3thE9CuA7qpvnvrBjVDgRI3/+a
/EqNCR94mfcjVUdQloGdAc+wKt4oLhhZ1KKPpyA9ceFxPlhwsjQh17bWmbXx3AQ0
GOf4aEq6MGaSVZU4uLp+oSXWiMaoYq68Dr8Xv09cy5Iyvy3fROdba96ldwP4lOK2
DqcwexLx6W4UXVAdR4Cjh0g1g2I58WcWuKJnvoNvLd2/RMEDTCA=
=ATb3
-----END PGP SIGNATURE-----

--Sig_/bjYfGNPG_KAQNF17zErGaKm--

--===============0821860127==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KZHJpLWRldmVs
IG1haWxpbmcgbGlzdApkcmktZGV2ZWxAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlz
dHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vZHJpLWRldmVsCg==

--===============0821860127==--
