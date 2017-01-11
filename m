From: Edward O'Callaghan <funfunctor-dczkZgxz+BNUPWh3PAxdjQ@public.gmane.org>
Subject: Re: [PATCH 0/2] drm/amd/amdgpu: locking fixes
Date: Wed, 11 Jan 2017 18:54:14 +1100
Message-ID: <35105957-04fb-0afe-ab22-583ca25949f4@folklore1984.net>
References: <1484119865-11390-1-git-send-email-nhaehnle@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1900094238=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <1484119865-11390-1-git-send-email-nhaehnle-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
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
To: =?UTF-8?Q?Nicolai_H=c3=a4hnle?= <nhaehnle-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--===============1900094238==
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="23pq7SCrCC7GjpgeBReG97A3k9LqKOkqN"

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--23pq7SCrCC7GjpgeBReG97A3k9LqKOkqN
Content-Type: multipart/mixed; boundary="0sUddtfraiiSoHUIpQLJRGGJDMowklbKX";
 protected-headers="v1"
From: Edward O'Callaghan <funfunctor-dczkZgxz+BNUPWh3PAxdjQ@public.gmane.org>
To: =?UTF-8?Q?Nicolai_H=c3=a4hnle?= <nhaehnle-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
 amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Message-ID: <35105957-04fb-0afe-ab22-583ca25949f4-dczkZgxz+BNUPWh3PAxdjQ@public.gmane.org>
Subject: Re: [PATCH 0/2] drm/amd/amdgpu: locking fixes
References: <1484119865-11390-1-git-send-email-nhaehnle-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
In-Reply-To: <1484119865-11390-1-git-send-email-nhaehnle-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>

--0sUddtfraiiSoHUIpQLJRGGJDMowklbKX
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

this series is,
Reviewed-by: Edward O'Callaghan <funfunctor-dczkZgxz+BNUPWh3PAxdjQ@public.gmane.org>

On 01/11/2017 06:31 PM, Nicolai H=C3=A4hnle wrote:
> Hi all,
>=20
> two fixes for locking issues that I noticed.
>=20
> The first one is something that I actually encountered live; it probabl=
y
> only matters when lock debugging is enabled, but obviously needs to be =
fixed
> anyway.
>=20
> The second one I only noticed upon reading the code -- I haven't seen i=
t
> fail live yet, at least not with lock debugging enabled (who knows what=
 its
> effects could be without lock debugging).
>=20
> Please review!
>=20
> I noticed two more locking-related problems, but since I'm not sure whe=
ther
> I'll get to those this week, I'm sending out these two patches already.=
 The
> other two problems are (both of them probably mostly benign, but I did
> encounter them in live tests):
>=20
> 1. amdgpu_bo_create_restricted(resv =3D=3D NULL) --> ttm_bo_init will f=
ree a
>    reservation object while it is locked. Fixing this soundly probably
>    requires mild changes to the ttm_bo_init API (perhaps a separate
>    ttm_bo_init_locked?).
>=20
> 2. ttm_bo_pipeline_move will ttm_bo_unref(&ghost_obj) leading to
>    mutex_destroy(&ghost_obj->wu_mutex) while that mutex "looks" locked =
(due
>    to the dumb copy).
>=20
> Thanks,
> Nicolai
>=20
> _______________________________________________
> amd-gfx mailing list
> amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
>=20


--0sUddtfraiiSoHUIpQLJRGGJDMowklbKX--

--23pq7SCrCC7GjpgeBReG97A3k9LqKOkqN
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJYdeSpAAoJEP4bvbfZuWjbacsQALS0ETIQQ5axx5t//p4PG88i
Lzf0D5UJQqi8uKR9Ra/KCY9fyeqJcao/ANuMDGkk5xErB9BeHxy7PUMxfI5ODiR1
Vnzvow0BZDes3jXRdKEKtKd6DrOKk2sfQldl8+TOX1ptNpbckq73wyNOSzpZMLv7
NrtII/MCK3+YOsrRzUjYmVZ5x0nlpuUHDOj3sMCckFsLk7qILFCqquRZJPUsRYCU
TsMI/Y5wWe5n6fvAfMKX8duAOwqBJlvSHMpC3vXMAYNKMYdWmG4IOqvrOhwsKRlj
R96Idlo99XzOBpv0ay+b9xepGcPE6lcpbYkBhbnUbwhEofD0rEkPiYGS27ypJ7sv
Ca9/JypOYGxr/51nCWnyP68Ts/eW4GTVNesEgLsB4LG6FgNjmzuKI/ZqUAw4z9/U
aUVYmZIYLNLOaJOdGlTJX8uIotN8GewhAJaPGOR0E0HFZl4sFgMGBkez8CKxtgVm
V2/PbHlxKIWM8olNkR6M7QcFYujNTJxvv5yNC/CH/F3KMBAfz5CwzWk1scciLKbz
v6J2qS/ZKqvqmoR2LEgsIcmKV3D8RnoFeFea7hfA2sAKP9H/jnBr7T8wezL5i0Dz
/Z+OT8SuvHzapb0QMac+4pKI+ctpcJqIiqe8X29LxV6ogQmNXP5WkJnOZPzuFA8m
f4+cwuDcbexdYjGq7rSo
=XC6d
-----END PGP SIGNATURE-----

--23pq7SCrCC7GjpgeBReG97A3k9LqKOkqN--

--===============1900094238==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============1900094238==--
