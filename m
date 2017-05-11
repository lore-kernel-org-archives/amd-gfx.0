From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH] drm: fourcc byteorder: brings header file comments in
 line with reality.
Date: Thu, 11 May 2017 23:23:11 +0200
Message-ID: <20170511212311.GA6780@amd>
References: <20170421075825.6307-1-kraxel@redhat.com>
 <20170421092530.GE30290@intel.com>
 <1492768218.25675.33.camel@redhat.com>
 <20170421110804.GH30290@intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1923910634=="
Return-path: <dri-devel-bounces@lists.freedesktop.org>
In-Reply-To: <20170421110804.GH30290@intel.com>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
To: Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <ville.syrjala@linux.intel.com>
Cc: amd-gfx@lists.freedesktop.org, Michel =?iso-8859-1?Q?D=E4nzer?= <michel@daenzer.net>, open list <linux-kernel@vger.kernel.org>, dri-devel@lists.freedesktop.org, Gerd Hoffmann <kraxel@redhat.com>, Daniel Vetter <daniel.vetter@intel.com>
List-Id: amd-gfx.lists.freedesktop.org


--===============1923910634==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="FL5UXtIhxfXey3p5"
Content-Disposition: inline


--FL5UXtIhxfXey3p5
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri 2017-04-21 14:08:04, Ville Syrj=E4l=E4 wrote:
> On Fri, Apr 21, 2017 at 11:50:18AM +0200, Gerd Hoffmann wrote:
> > On Fr, 2017-04-21 at 12:25 +0300, Ville Syrj=E4l=E4 wrote:
> > > On Fri, Apr 21, 2017 at 09:58:24AM +0200, Gerd Hoffmann wrote:
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
> > > > native endian only.
> > >=20
> > > I'm not a fan of "native". Native to what? "CPU" or "host" is what I'd
> > > call it.
> >=20
> > native =3D=3D whatever the cpu is using.
> >=20
> > I personally find "native" more intuitive, but at the end of the day I
> > don't mind much.  If people prefer "host" over "native" I'll change it.
>=20
> "native" to me feels more like "native to the GPU" since these things
> really are tied to the GPU not the CPU. That's also why I went with the
> explicit endianness originally so that the driver could properly declare
> what the GPU supports.

You can easily have more than one GPU in the system. Plus these are
used by cameras / frame grabbers, too. So anything else than CPU
endianness is badly defined.

(And I agree with the rest of the thread -- we should really be
explicit; fourcc should specify what format the image data are in, and
it should be possible to write fourcc + raw data into file and
transfer it between machines.)


									Pavel

--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--FL5UXtIhxfXey3p5
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlkU1j8ACgkQMOfwapXb+vIh6wCfZjgH6oTBa6xqGIzLdV1h7Jng
Y4IAnRX16sng3cEHUpZGPz7dGWIkH6oE
=9SnD
-----END PGP SIGNATURE-----

--FL5UXtIhxfXey3p5--

--===============1923910634==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KZHJpLWRldmVs
IG1haWxpbmcgbGlzdApkcmktZGV2ZWxAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlz
dHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vZHJpLWRldmVsCg==

--===============1923910634==--
