From: Edward O'Callaghan <funfunctor-dczkZgxz+BNUPWh3PAxdjQ@public.gmane.org>
Subject: Re: [PATCH umr] Simplify --scan and --list-regs syntax
Date: Thu, 23 Feb 2017 09:47:14 +1100
Message-ID: <2a6e09b7-e0eb-8a2e-a957-5884e82bbaf2@folklore1984.net>
References: <20170222145528.1331-1-tom.stdenis@amd.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0566251042=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <20170222145528.1331-1-tom.stdenis-5C7GfCeVMHo@public.gmane.org>
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
--===============0566251042==
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="8OchjPGbJ7hmPWQl9lwPs35mjuiG7AT6a"

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--8OchjPGbJ7hmPWQl9lwPs35mjuiG7AT6a
Content-Type: multipart/mixed; boundary="m79lHvE1WdalqFLGcJfUasvKtM9GlbGln";
 protected-headers="v1"
From: Edward O'Callaghan <funfunctor-dczkZgxz+BNUPWh3PAxdjQ@public.gmane.org>
To: Tom St Denis <tstdenis82-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Cc: Tom St Denis <tom.stdenis-5C7GfCeVMHo@public.gmane.org>
Message-ID: <2a6e09b7-e0eb-8a2e-a957-5884e82bbaf2-dczkZgxz+BNUPWh3PAxdjQ@public.gmane.org>
Subject: Re: [PATCH umr] Simplify --scan and --list-regs syntax
References: <20170222145528.1331-1-tom.stdenis-5C7GfCeVMHo@public.gmane.org>
In-Reply-To: <20170222145528.1331-1-tom.stdenis-5C7GfCeVMHo@public.gmane.org>

--m79lHvE1WdalqFLGcJfUasvKtM9GlbGln
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable



On 02/23/2017 01:55 AM, Tom St Denis wrote:
> Now it supports the same syntax as --read/--write, you can specify any
> of:
>=20
>     *.ipname
>     asicname.ipname
>     ipname
>=20
> When using --scan and --list-regs now.  e.g.,
>=20
>     umr --scan carrizo.uvd6
> or
>     umr --scan uvd6
>=20
> Signed-off-by: Tom St Denis <tom.stdenis-5C7GfCeVMHo@public.gmane.org>
> ---
>  src/app/main.c | 39 +++++++++++++++++++++++++++++++++++----
>  1 file changed, 35 insertions(+), 4 deletions(-)
>=20
> diff --git a/src/app/main.c b/src/app/main.c
> index 5b1694654352..a905ff0359cf 100644
> --- a/src/app/main.c
> +++ b/src/app/main.c
> @@ -47,6 +47,31 @@ static struct umr_asic *get_asic(void)
>  	return asic;
>  }
> =20
> +// returns blockname supports
> +// asicname.blockname
> +// *.blockname
> +// blockname
> +static char *get_block_name(struct umr_asic *asic, char *path)
> +{
> +	static char asicname[256], block[256], *dot;
> +
> +	memset(asicname, 0, sizeof asicname);
> +	if ((dot =3D strstr(path, "."))) {
> +		memset(block, 0, sizeof block);
perhaps move this block zero'ing memset outside the branch above.

with that,
Reviewed-by: Edward O'Callaghan <funfunctor-dczkZgxz+BNUPWh3PAxdjQ@public.gmane.org>

> +		memcpy(asicname, path, (int)(dot - path));
> +		strcpy(block, dot + 1);
> +	} else {
> +		strcpy(block, path);
> +	}
> +
> +	if (asicname[0] && asicname[0] !=3D '*' && strcmp(asic->asicname, asi=
cname)) {
> +		printf("[ERROR]: Invalid asicname <%s>\n", asicname);
> +		return NULL;
> +	}
> +	return block;
> +}
> +
> +
>  static void parse_options(char *str)
>  {
>  	char option[64], *p;
> @@ -96,7 +121,7 @@ int main(int argc, char **argv)
>  {
>  	int i, j, k, l;
>  	struct umr_asic *asic;
> -	char *str, *str2, asicname[256], ipname[256], regname[256];
> +	char *blockname, *str, *str2, asicname[256], ipname[256], regname[256=
];
>  	struct timespec req;
> =20
>  	memset(&options, 0, sizeof options);
> @@ -162,8 +187,11 @@ int main(int argc, char **argv)
>  			if (i + 1 < argc) {
>  				if (!asic)
>  					asic =3D get_asic();
> +				blockname =3D get_block_name(asic, argv[i+1]);
> +				if (!blockname)
> +					return EXIT_FAILURE;
>  				for (j =3D 0; j < asic->no_blocks; j++)
> -					if (!strcmp(asic->blocks[j]->ipname, argv[i+1]))
> +					if (!strcmp(asic->blocks[j]->ipname, blockname))
>  						for (k =3D 0; k < asic->blocks[j]->no_regs; k++) {
>  							printf("\t%s.%s.%s =3D> 0x%05lx\n", asic->asicname, asic->block=
s[j]->ipname, asic->blocks[j]->regs[k].regname, (unsigned long)asic->bloc=
ks[j]->regs[k].addr);
>  							if (options.bitfields) {
> @@ -216,8 +244,11 @@ int main(int argc, char **argv)
>  			if (i + 1 < argc) {
>  				if (!asic)
>  					asic =3D get_asic();
> -				if (!umr_scan_asic(asic, "", argv[i+1], ""))
> -					umr_print_asic(asic, argv[i+1]);
> +				blockname =3D get_block_name(asic, argv[i+1]);
> +				if (!blockname)
> +					return EXIT_FAILURE;
> +				if (!umr_scan_asic(asic, "", blockname, ""))
> +					umr_print_asic(asic, blockname);
>  				++i;
>  				options.need_scan =3D 0;
>  			} else {
>=20


--m79lHvE1WdalqFLGcJfUasvKtM9GlbGln--

--8OchjPGbJ7hmPWQl9lwPs35mjuiG7AT6a
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJYrhT2AAoJEP4bvbfZuWjbk2IP/jR1GPMnvRQcK0qncwu8HxoO
yt1RagvTLhG1pzlo+o4lrqgG0iNpHxp5S/vvkjrIfbg2jkwIEvU+MP/8RKFOJTwW
6SMm+jgySVwsu4oWhBf1cOCiY//tNR+5iAbaXWUt7WfWgKINv6acfpGHh3h4r8D1
XG2+l1H7gAR32AGBdLwz/wE/vc8s0gdeLLVVEz/g8UauQfPutkBGKVYTVjXql2dE
OTwh8MqRpAUGs6dkhsrFk1skK23BXnpTXh/VD0jIKNusfNI6xb+Cb7DNNHzyOGuG
uqufogJHZNKtoXGIRc95GXHZl3nrE++/xppKDROrF+pEvd5FzecFVjG+KjjCfnzf
ZWaYRybQBXpcsRezPN1dq+YI/xmj3ugQK9iGYQgri24y7QIOu10Lp4ZOmpzxQnEs
+wz9UBHe0+sfIjewjPLF7wmxG0UHpph+tfwdUwZLUBY5r+6nHCcIBDWxIPB4cNKN
u0ovDrN/4p85agWbs2u99nBBGP46R93ZlQb9mkMYEtqCXR9z5kAa+oIM79lLfEnR
dfjF93MfhtwQIlcGF6bOROJBitVWjJvxSAy1dB0RbJ0XJBn7+APUNKEuNL336hom
HiGO8S0j5iUfDSqyatEQjbM5G5LpvnjNfGHMoXAcxnXL6ztwZL9psGcNImgLxLxU
bF7Xr3GfPbuClpCMHwMI
=BxeA
-----END PGP SIGNATURE-----

--8OchjPGbJ7hmPWQl9lwPs35mjuiG7AT6a--

--===============0566251042==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============0566251042==--
