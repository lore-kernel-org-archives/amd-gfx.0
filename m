From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH] drm/amd/display: Fix compile error due to 'endif' missing
Date: Mon, 16 Sep 2019 19:08:16 +0100
Message-ID: <20190916180815.GK4352@sirena.co.uk>
References: <20190916044651.GA72121@LGEARND20B15>
 <CAK7LNARZMr5ZKGufi63GZrZ45k60faAiXr4mBB_mU9h_QifjxQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1939559157=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <CAK7LNARZMr5ZKGufi63GZrZ45k60faAiXr4mBB_mU9h_QifjxQ-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
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
To: Masahiro Yamada <yamada.masahiro-uWyLwvC0a2jby3iVrkZq2A@public.gmane.org>
Cc: Stephen Rothwell <sfr-3FnU+UHB4dNDw9hX6IcOSA@public.gmane.org>, David Airlie <airlied-cv59FeDIM0c@public.gmane.org>, Austin Kim <austindh.kim-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Roman.Li-5C7GfCeVMHo@public.gmane.org, amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, Linux Kernel Mailing List <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, dri-devel <dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, Daniel Vetter <daniel-/w4YWyX8dFk@public.gmane.org>


--===============1939559157==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="IKC1RK7+nRZ8SZaO"
Content-Disposition: inline


--IKC1RK7+nRZ8SZaO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 17, 2019 at 02:46:48AM +0900, Masahiro Yamada wrote:
> (+CC Stephen Rothwell, Mark Brown)
>=20
> On Mon, Sep 16, 2019 at 1:46 PM Austin Kim <austindh.kim-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:
> >
> > gcc throws compile error with below message:
>=20
> GNU Make throws ...
>=20
>=20

I don't have the original patch so I don't know what the issue being
reported is :/  Whatever it is it wasn't caught by any of the builds
done during the process of building -next and nothing is jumping out at
me on KernelCI.

> This is probably a merge mistake in linux-next.

> If so, this should be directly fixed in the linux-next.

> If it is not fixed in time,
> please inform Linus to *not* follow the linux-next.

It's probably worth coordinating this merge with DRM, it's not *super*
complex but clearly there's some potential for error here and it was
definitely annoyingly fiddly.

--IKC1RK7+nRZ8SZaO
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl1/z48ACgkQJNaLcl1U
h9BEtAf8Cg6gsw4Wr7G6vas1AyCCbY8RUAsjUmUecWcXXaUrxAlhZINRy+3tV8pB
1+uxPZZbpbrAtrb7GATiJZAEmCbazZP5PlHWivEgTfqSUQiHSDoX/5gvtaGdfQoq
fEosO5kiJ1Z7uEjKLgqfdIotR0oGxYYBRAhMPs5Q+KDheHdNDVVkWjKkqfLGBMvc
QxAbEbCfF3mk0MziIFmI4rmsREpvVE3YqWZFcp/u0dUbg/+hAf9/MKH2W1EK7qi4
L45PCcnI9vR5hivC8iNYZnvFtg1IugOgX7kM/6Wp8g4jxvTPeZGqYG4LFfdRU2lx
wMBC2pjSApPd0pdO0uUyA7Cjn9Tg/A==
=cbJO
-----END PGP SIGNATURE-----

--IKC1RK7+nRZ8SZaO--

--===============1939559157==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4

--===============1939559157==--
