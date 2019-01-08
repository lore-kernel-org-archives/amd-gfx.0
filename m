From: =?UTF-8?Q?Michel_D=c3=a4nzer?= <michel-otUistvHUpPR7s880joybQ@public.gmane.org>
Subject: Re: Adaptive Sync/VRR not working in multi-head with a non-freesync
 monitor
Date: Tue, 8 Jan 2019 15:43:55 +0100
Message-ID: <55516952-f207-00ef-4883-9306c9ae8485@daenzer.net>
References: <20190108124148.GA28230@lahvuun.homenetwork>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0324635481=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <20190108124148.GA28230-Pj6kw7KLH4mGKsjqgr5lgPuIYKdFZgUn@public.gmane.org>
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
To: Ilya Trukhanov <lahvuun-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--===============0324635481==
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="XYiokKhfMz9jAdpWHmle4QvibBm6q0Tlc"

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--XYiokKhfMz9jAdpWHmle4QvibBm6q0Tlc
Content-Type: multipart/mixed; boundary="6mZ5XmfabvN9p1hHPZ7JEhGnyyjNpnmtc";
 protected-headers="v1"
From: =?UTF-8?Q?Michel_D=c3=a4nzer?= <michel-otUistvHUpPR7s880joybQ@public.gmane.org>
To: Ilya Trukhanov <lahvuun-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Message-ID: <55516952-f207-00ef-4883-9306c9ae8485-otUistvHUpPR7s880joybQ@public.gmane.org>
Subject: Re: Adaptive Sync/VRR not working in multi-head with a non-freesync
 monitor
References: <20190108124148.GA28230-Pj6kw7KLH4mGKsjqgr5lgPuIYKdFZgUn@public.gmane.org>
In-Reply-To: <20190108124148.GA28230-Pj6kw7KLH4mGKsjqgr5lgPuIYKdFZgUn@public.gmane.org>

--6mZ5XmfabvN9p1hHPZ7JEhGnyyjNpnmtc
Content-Type: text/plain; charset=utf-8
Content-Language: en-CA
Content-Transfer-Encoding: quoted-printable

On 2019-01-08 1:41 p.m., Ilya Trukhanov wrote:
> Tried Unigine Valley with bspwm and Plasma, Freesync does not get
> engaged when second monitor (without Freesync support) is in use.
> If I turn it off with e.g.
>=20
> $ xrandr --output HDMI-A-0 --off
>=20
> Freesync immediately starts working. Once I turn the monitor back on,
> Freesync is gone.
>=20
>=20
> Looking through one of the patches at
> https://gitlab.freedesktop.org/xorg/driver/xf86-video-amdgpu/merge_requ=
ests/5
> I found this:
>=20
>> Per-CRTC support is gone for enabling variable refresh.
>> A window must cover the entire X screen in order to flip
>> so every CRTC must be enabled or disabled at the same time.
>=20
> If I understood correctly, in case of multi-head, a window must span
> across all monitors, with all monitors having Freesync support.
> Therefore, my setup won't work in this case. However, it *does* work on=

> Windows (albeit only one monitor has Freesync working, obviously).
>=20
> Am I missing something obvious?
> Or is this some kind of X design limitation?

Yes, it is. Variable refresh rate can only work with page flipping, and
page flipping can only be used in Xorg when the application window spans
the whole virtual desktop.


--=20
Earthling Michel D=C3=A4nzer               |               http://www.amd=
=2Ecom
Libre software enthusiast             |             Mesa and X developer


--6mZ5XmfabvN9p1hHPZ7JEhGnyyjNpnmtc--

--XYiokKhfMz9jAdpWHmle4QvibBm6q0Tlc
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EARECAB0WIQSwn681vpFFIZgJURRaga+OatuyAAUCXDS3PQAKCRBaga+Oatuy
ABGvAJ0Sq9xE1keDyMFF5fhZC7qVqXnayACglaeHzkDU/yQSBC8J5ZcrQBbDRHA=
=IPAm
-----END PGP SIGNATURE-----

--XYiokKhfMz9jAdpWHmle4QvibBm6q0Tlc--

--===============0324635481==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============0324635481==--
