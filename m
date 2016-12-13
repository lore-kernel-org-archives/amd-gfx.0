From: Edward O'Callaghan <funfunctor-dczkZgxz+BNUPWh3PAxdjQ@public.gmane.org>
Subject: Re: some minor dal cleanups and example of future patches
Date: Tue, 13 Dec 2016 18:48:21 +1100
Message-ID: <7152048c-e78a-0b57-a432-1fe0867aecb6@folklore1984.net>
References: <20161213064112.20004-1-airlied@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1580907231=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <20161213064112.20004-1-airlied-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
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
To: Dave Airlie <airlied-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--===============1580907231==
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="kgrxCO2q7nm7wQT4fL3Uu4FuOKhvhLVPo"

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--kgrxCO2q7nm7wQT4fL3Uu4FuOKhvhLVPo
Content-Type: multipart/mixed; boundary="Erptr9XrstUtpAVPke1HBp5EW6Q54BvQD";
 protected-headers="v1"
From: Edward O'Callaghan <funfunctor-dczkZgxz+BNUPWh3PAxdjQ@public.gmane.org>
To: Dave Airlie <airlied-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Message-ID: <7152048c-e78a-0b57-a432-1fe0867aecb6-dczkZgxz+BNUPWh3PAxdjQ@public.gmane.org>
Subject: Re: some minor dal cleanups and example of future patches
References: <20161213064112.20004-1-airlied-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
In-Reply-To: <20161213064112.20004-1-airlied-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>

--Erptr9XrstUtpAVPke1HBp5EW6Q54BvQD
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

This series is,
Acked-by: Edward O'Callaghan <funfunctor-dczkZgxz+BNUPWh3PAxdjQ@public.gmane.org>

On 12/13/2016 05:41 PM, Dave Airlie wrote:
> So whenever I look at DAL I find myself trying to figure out what
> all of it does, and this leads me to deleting things, so I'm just
> sending out some stuff that I cleaned today.
>=20
> One thing I noticed in passing is the displayport code seems
> possibly endian unsafe, it casts bytes read from hardware into
> bitfields, this is the best defined behaviour and is generally
> a pattern we try to steer away from.
>=20
> The porting the displayport code to use drm defines is the
> sort of example of a cleanup patch that might cause problems
> for you in code sharing, but is the exact sort of patch that
> has been applied to other drivers in the past.
>=20
> Dave.
>=20
> _______________________________________________
> amd-gfx mailing list
> amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
>=20


--Erptr9XrstUtpAVPke1HBp5EW6Q54BvQD--

--kgrxCO2q7nm7wQT4fL3Uu4FuOKhvhLVPo
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJYT6fFAAoJEP4bvbfZuWjbu/IQAKDmq/ApuZes5YV++RUyPSkC
ZhzNH1F9eckByLbR+QtkLYdxGwyxFzbhUi2b6R0LQgJC/95A5VZ4qs03+QfpP8S8
MPjRnZfgipYPwPWnynykw51DEYyhcTXQFMVhk1cMVRPNNmswZBp+hmT7HKN4bYvS
WSIFpOOzsPzki0Sr29HW3AfH9kwlIG4iO562bjtxS5e85lYVGgzOCK8WxdDu3mH+
kVzD23hKHhkNrNh8aGHuvSdC8a4SIEuanx1/62Jp8LuSldVHKZhggy/jsQR6C7TI
X70u3hQWbVQb9qvyY0Z4JStTynabKRxiECKS81vJgjt97mA86fUMJS5nvEDqqfTm
VN2eGmG+qOAsQ6vbwbGwHMHzaTQTVIwqHM4eZTFFufvdsYU4z11I6ysUluGW+jG8
4sWjqYxEgEP417sK+suo33W+JeJyPvFWewxkmS0J4OBJMdzc6bO7fZiI96NG3MTP
Kc+8/3USasbDBFGTe5orq/ldGJyaScRBvo3B9ZDycja93U7UOwDHTOPOr3UaO8Mg
om9lmi/px8H3ApS4mvMVRekeUZSgHHCVFacESWRC6FFoDS9NYHj+SEyUfRrq+2pN
16X/YpqOgUJfm4rM7/iHZStVfsBck/miGr/otVPImUN9BFnQbK4y8Ez8rL98fiIe
d39cNcYpfzQaQzyOmgLu
=SUj1
-----END PGP SIGNATURE-----

--kgrxCO2q7nm7wQT4fL3Uu4FuOKhvhLVPo--

--===============1580907231==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============1580907231==--
