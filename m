From: Pekka Paalanen <ppaalanen-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH] drm: fourcc byteorder: brings header file comments in
 line with reality.
Date: Fri, 21 Apr 2017 14:40:18 +0300
Message-ID: <20170421144018.411861d6@eldfell>
References: <20170421075825.6307-1-kraxel@redhat.com>
 <20170421092530.GE30290@intel.com>
 <1492768218.25675.33.camel@redhat.com>
 <20170421110804.GH30290@intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1516107517=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <20170421110804.GH30290-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
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
To: Ville =?UTF-8?B?U3lyasOkbMOk?= <ville.syrjala-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Cc: Jani Nikula <jani.nikula-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, David Airlie <airlied-cv59FeDIM0c@public.gmane.org>, Michel =?UTF-8?B?RMOkbnplcg==?= <michel-otUistvHUpPR7s880joybQ@public.gmane.org>, open list <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, Sean Paul <seanpaul-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, Gerd Hoffmann <kraxel-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, Alex Deucher <alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Daniel Vetter <daniel.vetter-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Ilia Mirkin <imirkin-FrUbXkNCsVf2fBVCVOL8/A@public.gmane.org>

--===============1516107517==
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/pKRuCxC2DOn5+RS4kXDdWyp"; protocol="application/pgp-signature"

--Sig_/pKRuCxC2DOn5+RS4kXDdWyp
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Fri, 21 Apr 2017 14:08:04 +0300
Ville Syrj=C3=A4l=C3=A4 <ville.syrjala-VuQAYsv1563Yd54FQh9/CA@public.gmane.org> wrote:

> On Fri, Apr 21, 2017 at 11:50:18AM +0200, Gerd Hoffmann wrote:
> > On Fr, 2017-04-21 at 12:25 +0300, Ville Syrj=C3=A4l=C3=A4 wrote: =20
> > > On Fri, Apr 21, 2017 at 09:58:24AM +0200, Gerd Hoffmann wrote: =20
> > > > While working on graphics support for virtual machines on ppc64 (wh=
ich
> > > > exists in both little and big endian variants) I've figured the com=
ments
> > > > for various drm fourcc formats in the header file don't match reali=
ty.
> > > >=20
> > > > Comments says the RGB formats are little endian, but in practice th=
ey
> > > > are native endian.  Look at the drm_mode_legacy_fb_format() helper.=
  It
> > > > maps -- for example -- bpp/depth 32/24 to DRM_FORMAT_XRGB8888, no m=
atter
> > > > whenever the machine is little endian or big endian.  The users of =
this
> > > > function (fbdev emulation, DRM_IOCTL_MODE_ADDFB) expect the framebu=
ffer
> > > > is native endian, not little endian.  Most userspace also operates =
on
> > > > native endian only. =20
> > >=20
> > > I'm not a fan of "native". Native to what? "CPU" or "host" is what I'd
> > > call it. =20
> >=20
> > native =3D=3D whatever the cpu is using.
> >=20
> > I personally find "native" more intuitive, but at the end of the day I
> > don't mind much.  If people prefer "host" over "native" I'll change it.=
 =20
>=20
> "native" to me feels more like "native to the GPU" since these things
> really are tied to the GPU not the CPU. That's also why I went with the
> explicit endianness originally so that the driver could properly declare
> what the GPU supports.

Hi,

yeah, one should really be explicit on which component's endianess does
"native" refer to. I just can't imagine "GPU native" to ever be an
option, because then userspace needs a way to discover what the
GPU endianess is, and I believe that would only deepen the swamp, not
drain it, because suddenly you need two enums to describe one format.

Ville, wording aside, what do think about changing the endianess
definition? Is it going in the right direction?


Thanks,
pq

--Sig_/pKRuCxC2DOn5+RS4kXDdWyp
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEJQjwWQChkWOYOIONI1/ltBGqqqcFAlj576IACgkQI1/ltBGq
qqcMixAAp+GAXtDVX2suxXwUgbv/Dn4McyOVuMUcfMdK76YSCVDnTk/H4wPYsz3t
gJw7OybXv3+Ybb05Oa+SzMEQ7fzp2K1SGSSHsMWq3yqJTisyrDJ3bx8C+/ti9ylI
MgI6uc1tZG8klwxTP/fYIcjlX6E96IZSRGQ/40HHW1MLicqUUQ8TiysfinE/SZ0u
Ay5TeDIsfuM8iFFxWUoCPLssNF4ber93u51ZOnyajpmhBw7kQfmXrS/0h2/nsqqv
U9quOfCoaYVlGjLA1k2Qf6DC+Zwn0/bYK8OCE6vPGg5BTJKglo5O6zqDJywP7SN9
l6bwgcWDuVL/3b7tBrkLYp8TT6kT6v44ZNVv3L+yppdLeWZoE9mUtMAEzHw3Z5Jk
fObgcKNgx0N/dCJFnT95BJy24vNvaeWokBiAGBqaHD8ydbEwrRAKaw7v4HaqjDFR
0ogCM1mwLJ/9InzmWnP+Pw7Agfv43KPhZAVC6zsHLpNffLlgHhnCIi5iyPvnxjjX
8Cj1NLobaScLivJHxOqi5WbBJNqfBhY5usL1yXTIjaXiqKrW/hTBhtaL4V5xzB1M
0XppxOgm9+70GdGWFJ3Gs8qpmnYHl6ziJeEeWrkxA9sPjjEJCIGJ9E0UPFc+TIQ4
qEoby24Aml30lnmRwgXYS2pUNPhE+rVdgOzaJfiiJdmtlbudC0k=
=yP1M
-----END PGP SIGNATURE-----

--Sig_/pKRuCxC2DOn5+RS4kXDdWyp--

--===============1516107517==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============1516107517==--
