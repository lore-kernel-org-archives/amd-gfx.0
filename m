From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH] drm/amd/display: build failed for DCN2.1
Date: Mon, 16 Sep 2019 23:36:15 +0100
Message-ID: <20190916223615.GP4352@sirena.co.uk>
References: <1568624607-19067-1-git-send-email-danielliu861@gmail.com>
 <CAKwvOdn8-T3Q=LhiGu6H7dCpwXXrNAjpKJA5z0d+N4qB8bOapQ@mail.gmail.com>
 <20190916221203.GM4352@sirena.co.uk>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0720410198=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <20190916221203.GM4352-7j8lgAiuQgnQXOPxS62xeg@public.gmane.org>
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


--===============0720410198==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="JQcP/qOTM3HdZIaJ"
Content-Disposition: inline


--JQcP/qOTM3HdZIaJ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 16, 2019 at 11:12:03PM +0100, Mark Brown wrote:
> On Mon, Sep 16, 2019 at 01:51:15PM -0700, Nick Desaulniers wrote:
>=20
> > + Mark
> > I think this was a result of the resolved merge conflict.  See the
> > -next only commit titled:
> >     Merge remote-tracking branch 'drm/drm-next'

> Yes, the DRM and the Kbuild people really need to coordinate with each
> other here I fear, it's pretty bad that stuff like this has to be done
> in a merge at all :/ The fact that make doesn't detect a missing endif
> is also concerning.

Applied now, thanks Xinpeng.

--JQcP/qOTM3HdZIaJ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl2ADl8ACgkQJNaLcl1U
h9DFWQf9HYsD60H/KqSf9UafvtsbRnYJ/E150z6qfU+4SxcuvgaFc5+LrQMPo6Sg
vYZw0ttOlxi61MpdSan2zsFY/+vuHROKPaGUWpCF5dP3Wx1UeXo8PMd3gtw/xyGz
Izy25kzC2JvP/14mylXA6pMVQ4297JwnkBP5nKltu+uwI/NAHNqYoCw8g2EA46dO
GCquk5qIC+hs089gKwR3NF1Y/FK2+Bjnvd6JNaZaQXKrYAt5x+VvgobxcnLwc61r
GwuhSNvQ4GGy5JUQJl3COfW5xOAGg+whCJuYjEx5ooPnKX4oVeru3udvL6eI6o9S
t2VBe3O32kZ1FR9osKjKigcSBsnJtA==
=CF/Q
-----END PGP SIGNATURE-----

--JQcP/qOTM3HdZIaJ--

--===============0720410198==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4

--===============0720410198==--
