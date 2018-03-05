From: "Keith Packard" <keithp-aN4HjG94KOLQT0dZR+AlfA@public.gmane.org>
Subject: Re:
Date: Mon, 05 Mar 2018 08:41:26 -0800
Message-ID: <877eqqlbk9.fsf@keithp.com>
References: <20180303044931.6902-1-keithp@keithp.com>
 <82fc592b-f680-c663-1a0f-7b522ca932d2@daenzer.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0567587605=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <82fc592b-f680-c663-1a0f-7b522ca932d2-otUistvHUpPR7s880joybQ@public.gmane.org>
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
To: Michel =?utf-8?Q?D=C3=A4nzer?= <michel-otUistvHUpPR7s880joybQ@public.gmane.org>
Cc: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org

--===============0567587605==
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha256; protocol="application/pgp-signature"

--=-=-=
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Michel D=C3=A4nzer <michel-otUistvHUpPR7s880joybQ@public.gmane.org> writes:

> On 2018-03-03 05:49 AM, Keith Packard wrote:
>> Here are the patches to the modesetting driver amended for the amdgpu
>> driver.
>
> Thanks for the patches. Unfortunately, since this driver still has to
> compile and work with xserver >=3D 1.13, at least patches 1 & 3 cannot be
> applied as is.
>
> I was going to port these and take care of that anyway, though I might
> not get around to it before April. If it can't wait that long, I can
> give you details about what needs to be done.

I'm good with that -- I needed this to test amdgpu vs modesetting for
some applications, and just having the patches with support is good
enough for me.

=2D-=20
=2Dkeith

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEw4O3eCVWE9/bQJ2R2yIaaQAAABEFAlqdczYACgkQ2yIaaQAA
ABEEnRAAmTRNkHzIEt79exerXekbISXQRHYXpEaXun1jJeQyPRGhIUbrCgvEShvE
0nMpZ41s0PMuF95LuaWermosS5b1kNfBwNZ6/TSchLmD7akxASzsYzCV+5sz1RJ3
nFF1SnLQpdMw1eCZ9jL2YpV0HdZ1HWbbldK0E6F0DmXXvsT2zwJT3KS9z6+KUTiE
RqjoAPa3OypObpPuXSBXlTfelUr5HtOXoaxFKYCa5nXZxXzx//B8q3jZ4FbyPZyR
BBqNpvdFX8GxVxoOTXIik3G2dMYf3d1rvJcZx9h51KeFkCQC9CLm11ErQmmTScmN
w9Q/J4YBxf+ctJgkMrhGajVPGAG7hNSJraQFmVkl8BpE+ojSyGVqvl45pM/Bn23d
mxKBeXJljKwGCTrQvoRMo0lSXPPq9ltCm6HTk3GIL/WmGGsBWJOc7wlHZa1enkB0
/fnHwohcgWAougzeEJx2Yl6cLvbgJKrENUZ17F5Wz23Hl6avKgYM93h3/QMjZOzo
8tl7IcP/u0Kx2hnCX5o4kNDsSC9jtvcjb5mBGlijRzYfdHjUJju41PCYmeV5d7yu
xHwhp3cHrsP5Fb5o2nf45s/fNaQjqsNMHg0GBXj8OKJJXfcpCFvwV8uJLna+1j+x
i4kcBqIWUM/GC0ONn1oGC+TwChtD76pkyFhWJZY03HSfKxdkfLc=
=ivsV
-----END PGP SIGNATURE-----
--=-=-=--

--===============0567587605==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============0567587605==--
