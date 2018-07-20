From: Eric Anholt <eric-WhKQ6XTQaPysTnJN9+BGXg@public.gmane.org>
Subject: Re: [PATCH 2/2] drm/scheduler: remove sched field from the entity
Date: Fri, 20 Jul 2018 11:14:38 -0700
Message-ID: <871sbxbwq9.fsf@anholt.net>
References: <20180720122106.10344-1-nayan26deshmukh@gmail.com>
 <20180720122106.10344-2-nayan26deshmukh@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1865949553=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <20180720122106.10344-2-nayan26deshmukh-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
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
To: dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Cc: alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, Nayan Deshmukh <nayan26deshmukh-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, christian.koenig-5C7GfCeVMHo@public.gmane.org, amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, l.stach-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org

--===============1865949553==
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha512; protocol="application/pgp-signature"

--=-=-=
Content-Type: text/plain

Nayan Deshmukh <nayan26deshmukh-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> writes:

> The scheduler of the entity is decided by the run queue on which
> it is queued. This patch avoids us the effort required to maintain
> a sync between rq and sched field when we start shifting entites
> among different rqs.

Reviewed-by: Eric Anholt <eric-WhKQ6XTQaPysTnJN9+BGXg@public.gmane.org>

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE/JuuFDWp9/ZkuCBXtdYpNtH8nugFAltSJo4ACgkQtdYpNtH8
nuhIKA/+PLrr2MNb3zbPrZ1PMUNgjSuz0MEMnwLxrHiCTH9SwOPkQG1dQyVXV8PE
JJAAO0ezJ7OpMJsdufWWE3YMxloWcZuuDc7daQJdpy1XhMOLerpd9+TUnQFcdUTF
W/njzShtuZN/XdLBGh86wj5BSjA4uN2/jPxZFEvIunwDMUvShRnPneFH3mT1Jsw/
pZ56aMSxQtcIlEJ96gHFcxLKBYaH8Hy6Sp9ICfiMXnmjYSL/3flMd3K0pr5OKQp7
f5iTA9bLDd1tmD8p3RJLEo1hNB537IeD7uOSxYRhfxb4xL8GbJI631wqIpBp3FtZ
xfsC6IGRbEr9K+yxy8A4MCdJPZBvEJEgSG8iYrCHdw57JihwQsRKhoYKUOcJDTQQ
BF5SMDPaAQ9J+wczUetuPhsgGiMHTIuwuXenZApB3AEad8RSkxRCo+To5Z8qly4y
nwyQvNef0kKMcsyHMCqhw9voBe4HvijYuVD8UbfQVI/0nLNi2PDY+WktEfFOyON5
mMOhkS+fSLPLj6KS7tahbYzYKytE7qkTqCp/nx96Urr4PYwxSjPJosM+NdlrIxFO
9GIk5BO0tBGvYZkTwNwrMN+3xQGZ4BEESg0UFwIo4CWaxlYPS422i5Lw8xfDjMyD
HtcpQe+R4dRwKb+h5rz3pNemgmJsTSO5/y8RiJ6pmcJnmp+pE00=
=66hZ
-----END PGP SIGNATURE-----
--=-=-=--

--===============1865949553==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============1865949553==--
