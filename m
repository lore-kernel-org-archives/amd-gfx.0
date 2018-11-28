From: Eric Anholt <eric-WhKQ6XTQaPysTnJN9+BGXg@public.gmane.org>
Subject: Re: [PATCH 4/4] drm/edid: Add display_info.rgb_quant_range_selectable
Date: Wed, 28 Nov 2018 09:19:08 -0800
Message-ID: <8736rl6rxv.fsf@anholt.net>
References: <20181120161345.15440-1-ville.syrjala@linux.intel.com>
 <20181120161345.15440-4-ville.syrjala@linux.intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2088122029=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <20181120161345.15440-4-ville.syrjala-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
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
To: Ville Syrjala <ville.syrjala-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Cc: Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org>, "David (ChunMing) Zhou" <David1.Zhou-5C7GfCeVMHo@public.gmane.org>, intel-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, Christian =?utf-8?Q?K=C3=B6nig?= <christian.koenig-5C7GfCeVMHo@public.gmane.org>, amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org

--===============2088122029==
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha512; protocol="application/pgp-signature"

--=-=-=
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Ville Syrjala <ville.syrjala-VuQAYsv1563Yd54FQh9/CA@public.gmane.org> writes:

> From: Ville Syrj=C3=A4l=C3=A4 <ville.syrjala-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
>
> Move the CEA-861 QS bit handling entirely into the edid code. No
> need to bother the drivers with this.
>
> Cc: Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org>
> Cc: "Christian K=C3=B6nig" <christian.koenig-5C7GfCeVMHo@public.gmane.org>
> Cc: "David (ChunMing) Zhou" <David1.Zhou-5C7GfCeVMHo@public.gmane.org>
> Cc: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
> Cc: Eric Anholt <eric-WhKQ6XTQaPysTnJN9+BGXg@public.gmane.org> (supporter:DRM DRIVERS FOR VC4)
> Signed-off-by: Ville Syrj=C3=A4l=C3=A4 <ville.syrjala-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>

For vc4,
Acked-by: Eric Anholt <eric-WhKQ6XTQaPysTnJN9+BGXg@public.gmane.org>

Looks like a nice cleanup!

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE/JuuFDWp9/ZkuCBXtdYpNtH8nugFAlv+zgwACgkQtdYpNtH8
nuiZug//R3TqIZKdJFb0z7mCyv+9CqdsABrfVg5chnU68kpIiQ9e0HkGvB0B42Xq
mIDG8lj2P7Ky6bVxi94g0KNuDXEeiDKBINm88lPALSTo5cxHbXbb9q1yQEl5zwGC
8mGy2TZnu7dTm3m1cf/f9YT5+uWgOwj/5Tey/qQH5I1B7W36M9BUY+YQ1PB9at3/
HysxqaJSB4JGzI2oPCnUpKTkwF3z7/Gvo+yOfKkMbmv1fWuM6OuhUtWn2axXlL3m
DlC1VKx6qA2kh0FeBxRBxhLru0oRvnxQS0L8v+h6FbWLZqBZKiQi8b/vwzuwuHkl
cpEP9WvCDe9U0DhSlF8uCXvI4vN8EHhWAMkAf1tR5eHFDIJU+LfPlWvy8/qWmT/P
Xq6FCuc3inWQrKMZrZk9ZqNRW5tcyQpBTJFFGbqN0hSeZU+uAUu2w4XSpXXLJcjy
nKSETH2mRCWmDMZNSFuoP2pkL2+dbAseecaZk7INvZx2J7+9aUvADx2yRx5E4xey
IOeJ0iRh6WN7HHfceC8p3gKW8e14Ul+HAx/voXv+Fxq+Edwu6i0q2cScWiX97e4x
tz5uSyDMm2HrG+aJIodyWu88iZ5hjwQkmyagk2sGomuyQuMTUTBFPsimcpsGA4JO
jB42Ap+pBz57n1Rg6ybNCdnVXDzIqf4o+nkUfdpNcY9yvB5zufE=
=TPw0
-----END PGP SIGNATURE-----
--=-=-=--

--===============2088122029==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============2088122029==--
