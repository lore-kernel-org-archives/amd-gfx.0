From: Hristo Venev <hristo-dptOiocmjbVBDLzU/O5InQ@public.gmane.org>
Subject: drm/amdgpu/display: Multiple fixed-point implementations
Date: Sat, 10 Dec 2016 12:29:04 +0200
Message-ID: <1481365744.3081.2.camel@venev.name>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2047136213=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
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
To: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org


--===============2047136213==
Content-Type: multipart/signed; micalg="pgp-sha512";
	protocol="application/pgp-signature"; boundary="=-WZHsE8YvIy4+gmeZbscs"


--=-WZHsE8YvIy4+gmeZbscs
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

There are at least three implementations of fixed-point arithmetic in
drm/amdgpu/display: fixed31_32 (signed 32-32), fixed32_32 (unsigned 32-
32) and bw_fixed (signed 40-24). I don't think fixed-point arithmetic
implementations belong in drivers.

There already are two implementations of fixed-point in drm: fixed20_12
(unsigned 20-12) and drm_fixp (signed 32-32). The latter could be used
instead of fixed31_32.

Maybe we could use a standard fixed-point interface and share the
source code between most (or all) of the implementations. This is one
of the things that can be done before merging DC and is not too driver-
specific. What do you guys think?
--=-WZHsE8YvIy4+gmeZbscs
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABCgAGBQJYS9jwAAoJEM8F6NBNwym6KoAQALQUGmkC45NLjPEaoWGnvGiT
1vqlwCmhyYVX5+6Qu3q3SYuc7jxnqMDQ1+oZbHfjNhfA5O/bavQfMkSaVDOJmwXP
g9x3cExfM2QXv/6KxxgEg+q10QVOY1LtHkpPWL2YtpTX+5moF2i7LLXmKHZzJXFY
YJtDplMF+VxtspKKJrMEFP81qZXR6V8fkk3x0Bui3mlcu1DljBD+ocufeR1QHsMN
Ewloo1wK4/Cz2ZeyxXO3enIdvQEv9dwpV47ipxFUz9cGnkRCZPOci8fIG7olBywy
ZcMc6IAs4XZ9XuQ9HTRJFqTFH5DxHiHvKMo/S70yRO5mFmIZSW8dz/HDHSYq5mjs
8V3Hs+yiIg+ijIZG6KsoRFkDAMLXw5KQOf2sCckcwv42W6ZQpv2n9eZbqZ6oe7vp
ZSMtC0Chnz+oIySRTmVURub75jxeD4qpSWgqg17IXH5ndGz87s46pQYJr9sL0i6y
dOIPOqsHZufmaPX40BY1uPuAl11jcoQLX65PtuHbpo7pm/QVdhqKiWMfldyLZ7PD
xZkxOdyxr6cAYww5eRjbcrFn/UbWVnngzJAqc7U4Hx1CIHZfaFZzFA7ipRw1akwo
L0658H6vKy7ES5Y6byX1vUn+alDn0Of9XzWgaXP6wEmD/ktS8rHerQyn5a7/ZfL/
VscHAvg+YGJU0DOdjaQN
=P8Ic
-----END PGP SIGNATURE-----

--=-WZHsE8YvIy4+gmeZbscs--


--===============2047136213==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============2047136213==--
