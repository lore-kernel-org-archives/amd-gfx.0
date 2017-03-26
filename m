From: Edward O'Callaghan <funfunctor-dczkZgxz+BNUPWh3PAxdjQ@public.gmane.org>
Subject: Re: [PATCH umr] Add family text for family 141
Date: Mon, 27 Mar 2017 10:34:41 +1100
Message-ID: <7f1aeae8-9457-8a50-d075-428880afa9a3@folklore1984.net>
References: <20170324140834.13558-1-tom.stdenis@amd.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1184897102=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <20170324140834.13558-1-tom.stdenis-5C7GfCeVMHo@public.gmane.org>
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
To: Tom St Denis <tstdenis82-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Cc: Tom St Denis <tom.stdenis-5C7GfCeVMHo@public.gmane.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--===============1184897102==
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="IquBGWWSJO9GGxSvojv9dqhbMRKidvreN"

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--IquBGWWSJO9GGxSvojv9dqhbMRKidvreN
Content-Type: multipart/mixed; boundary="rQAohqSLwcKDWresEX73HnqeeLhdHXpBc";
 protected-headers="v1"
From: Edward O'Callaghan <funfunctor-dczkZgxz+BNUPWh3PAxdjQ@public.gmane.org>
To: Tom St Denis <tstdenis82-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Cc: Tom St Denis <tom.stdenis-5C7GfCeVMHo@public.gmane.org>
Message-ID: <7f1aeae8-9457-8a50-d075-428880afa9a3-dczkZgxz+BNUPWh3PAxdjQ@public.gmane.org>
Subject: Re: [PATCH umr] Add family text for family 141
References: <20170324140834.13558-1-tom.stdenis-5C7GfCeVMHo@public.gmane.org>
In-Reply-To: <20170324140834.13558-1-tom.stdenis-5C7GfCeVMHo@public.gmane.org>

--rQAohqSLwcKDWresEX73HnqeeLhdHXpBc
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Reviewed-by: Edward O'Callaghan <funfunctor-dczkZgxz+BNUPWh3PAxdjQ@public.gmane.org>

On 03/25/2017 01:08 AM, Tom St Denis wrote:
> Signed-off-by: Tom St Denis <tom.stdenis-5C7GfCeVMHo@public.gmane.org>
> ---
>  src/app/print_config.c | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/src/app/print_config.c b/src/app/print_config.c
> index 6dbe0d42b8dc..e295302ab7a3 100644
> --- a/src/app/print_config.c
> +++ b/src/app/print_config.c
> @@ -91,6 +91,7 @@ static const struct {
>  	{ "Kaveri", 125 },
>  	{ "Volcanic Islands", 130 },
>  	{ "Carrizo", 135 },
> +	{ "Arctic Islands", 141 },
>  	{ NULL, 0 },
>  };
> =20
>=20


--rQAohqSLwcKDWresEX73HnqeeLhdHXpBc--

--IquBGWWSJO9GGxSvojv9dqhbMRKidvreN
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJY2FARAAoJEP4bvbfZuWjbwDYQALc84nf8vULaZSqq/OduX+Xr
6g7wkD0lTNONsVkLzNHHPKU8EZPbIPz5UHmSCOiBH0IWxRQdPJKvFNNa88yCG0uq
kCQlnU/t36plxfYyjFHzg/24I9QlawKYFkVAr93TI9GYWjFjxO/l7Dsy6QWmUNPP
g8uU9CgsgMDyoyUSSE+suvlMaqdwhnWn446IWMmTHnhCSMilHKK5nbpRxzwta8OK
KQRkD1mBvnpN4C6B3zAXW+PvzGxONdFq7H+NfLqxB+Lj+AFdbv7W0SCX4bVvZMPf
Tk+QZb7IpnUC91cTgpVW3r/9dWy1jfOY6ttS4bDGdWwXT1HhAxQnEREvR8kXolla
wAQV2yCl35GBfvKVZu+z/5fdCcn3WQF54iJeQTOf/4N+oJir8lDGTic6B6g/MK8g
pJLQOuKRaDlAzK7269bMjJfJ/OHqQopx8CnzXSxqLgS4s+L1KZpcb6I8mQFYtuOX
YplGm+PHur20t8Qak7lzU0RJKkKmxvTVS/+IzMp/9Bz2w88XIuHLNHWYxm48sLTN
CG6A4FSAXk2pubeSVJl7B92hzjg39K0+mOd51cNaoaU30NmeVd24qo9YAjF0JGng
1GnU7IDEsaYdBqbp0+hgNafpk8GWmixAcbiLPVoZXBFDAYZbI/Y3Z/lP/LtcAIOG
zrTNs56Y1+iWeAzJSj5Q
=+dn3
-----END PGP SIGNATURE-----

--IquBGWWSJO9GGxSvojv9dqhbMRKidvreN--

--===============1184897102==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============1184897102==--
