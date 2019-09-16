From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH] drm/amd/display: build failed for DCN2.1
Date: Mon, 16 Sep 2019 23:12:03 +0100
Message-ID: <20190916221203.GM4352@sirena.co.uk>
References: <1568624607-19067-1-git-send-email-danielliu861@gmail.com>
 <CAKwvOdn8-T3Q=LhiGu6H7dCpwXXrNAjpKJA5z0d+N4qB8bOapQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1411532796=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <CAKwvOdn8-T3Q=LhiGu6H7dCpwXXrNAjpKJA5z0d+N4qB8bOapQ-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
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
To: Nick Desaulniers <ndesaulniers-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>
Cc: "Zhou, David(ChunMing)" <David1.Zhou-5C7GfCeVMHo@public.gmane.org>, "Li,
 Sun peng (Leo)" <sunpeng.li-5C7GfCeVMHo@public.gmane.org>, Bhawanpreet.Lakha-5C7GfCeVMHo@public.gmane.org, David Airlie <airlied-cv59FeDIM0c@public.gmane.org>, Roman.Li-5C7GfCeVMHo@public.gmane.org, amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, Xinpeng Liu <danielliu861-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Jun.Lei-5C7GfCeVMHo@public.gmane.org, Harry Wentland <harry.wentland-5C7GfCeVMHo@public.gmane.org>, "Koenig,
 Christian" <christian.koenig-5C7GfCeVMHo@public.gmane.org>


--===============1411532796==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="+rbkueAQrkWPpfRR"
Content-Disposition: inline


--+rbkueAQrkWPpfRR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Sep 16, 2019 at 01:51:15PM -0700, Nick Desaulniers wrote:

> + Mark
> I think this was a result of the resolved merge conflict.  See the
> -next only commit titled:
>     Merge remote-tracking branch 'drm/drm-next'

Yes, the DRM and the Kbuild people really need to coordinate with each
other here I fear, it's pretty bad that stuff like this has to be done
in a merge at all :/ The fact that make doesn't detect a missing endif
is also concerning.

--+rbkueAQrkWPpfRR
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl2ACLIACgkQJNaLcl1U
h9Az2wf+LDHHfHh7Ip1d37rtRGjZdyhiXy2pgzFsJ7KTWdYq0CsGcHVYMvbuA9CR
Z7XpJHByHefIJTtgy137DurDBW08BMEwBA7PCKhferYu2DWps+kuu6CXeuwIhp93
3+ZrMLXcI82jmbpQEVmxwFOhcNj4Dd0koRG1djzke7E05BvQ31BFQR2iLQMDuyAB
tcJSzTmKmej3h+QZUV1nzpRCNbfkAbh/GK+VtFTCU37uYDpmDThglVc7DN8GLb0Z
IvO/l4LDZyC7KPt+6Zx+t7RWPEngPhtVdYMlPVZopOG8s0PLbzEsl1r7nT+uamxA
4KlVxriZBQzWHMH5S6EKkLzP7ZpXfQ==
=8ps+
-----END PGP SIGNATURE-----

--+rbkueAQrkWPpfRR--

--===============1411532796==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4

--===============1411532796==--
