From: Edward O'Callaghan <funfunctor-dczkZgxz+BNUPWh3PAxdjQ@public.gmane.org>
Subject: Re: [PATCH umr] Add program memory dump to wave status.
Date: Sat, 25 Mar 2017 00:00:01 +1100
Message-ID: <a9059ebe-a562-e30d-e12b-9bfb7d78320c@folklore1984.net>
References: <20170321141122.15451-1-tom.stdenis@amd.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0555460636=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <20170321141122.15451-1-tom.stdenis-5C7GfCeVMHo@public.gmane.org>
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
--===============0555460636==
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="gqG7nOK3HAhOc9pF6Efrdo2JK9Wli8CtE"

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--gqG7nOK3HAhOc9pF6Efrdo2JK9Wli8CtE
Content-Type: multipart/mixed; boundary="1E4EdaNapFNkLBhXaCN1wIQSiop3Xkfn9";
 protected-headers="v1"
From: Edward O'Callaghan <funfunctor-dczkZgxz+BNUPWh3PAxdjQ@public.gmane.org>
To: Tom St Denis <tstdenis82-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Cc: Tom St Denis <tom.stdenis-5C7GfCeVMHo@public.gmane.org>
Message-ID: <a9059ebe-a562-e30d-e12b-9bfb7d78320c-dczkZgxz+BNUPWh3PAxdjQ@public.gmane.org>
Subject: Re: [PATCH umr] Add program memory dump to wave status.
References: <20170321141122.15451-1-tom.stdenis-5C7GfCeVMHo@public.gmane.org>
In-Reply-To: <20170321141122.15451-1-tom.stdenis-5C7GfCeVMHo@public.gmane.org>

--1E4EdaNapFNkLBhXaCN1wIQSiop3Xkfn9
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Reviewed-by: Edward O'Callaghan <funfunctor-dczkZgxz+BNUPWh3PAxdjQ@public.gmane.org>

On 03/22/2017 01:11 AM, Tom St Denis wrote:
> It will display the leading 4 words up to
> the current PC value and then 4 words after.
>=20
> Signed-off-by: Tom St Denis <tom.stdenis-5C7GfCeVMHo@public.gmane.org>
> ---
>  src/app/print_waves.c | 44 +++++++++++++++++++++++++++++++++----------=
-
>  1 file changed, 33 insertions(+), 11 deletions(-)
>=20
> diff --git a/src/app/print_waves.c b/src/app/print_waves.c
> index f0eeeba43a99..e3662983d8d1 100644
> --- a/src/app/print_waves.c
> +++ b/src/app/print_waves.c
> @@ -35,7 +35,8 @@
> =20
>  void umr_print_waves(struct umr_asic *asic)
>  {
> -	uint32_t x, se, sh, cu, simd, wave, sgprs[1024], shift;
> +	uint32_t x, se, sh, cu, simd, wave, sgprs[1024], shift, opcodes[8];
> +	uint64_t pgm_addr;
>  	struct umr_wave_status ws;
>  	int first =3D 1, col =3D 0;
> =20
> @@ -74,17 +75,24 @@ void umr_print_waves(struct umr_asic *asic)
>  (unsigned long)ws.hw_id.value, (unsigned long)ws.gpr_alloc.value, (uns=
igned long)ws.lds_alloc.value, (unsigned long)ws.trapsts.value, (unsigned=
 long)ws.ib_sts.value,
>  (unsigned long)ws.tba_hi, (unsigned long)ws.tba_lo, (unsigned long)ws.=
tma_hi, (unsigned long)ws.tma_lo, (unsigned long)ws.ib_dbg0, (unsigned lo=
ng)ws.m0
>  );
> -					for (x =3D 0; x < ((ws.gpr_alloc.sgpr_size + 1) << shift); x +=3D=
 4)
> -						printf(">SGPRS[%u..%u] =3D { %08lx, %08lx, %08lx, %08lx }\n",
> -							(unsigned)((ws.gpr_alloc.sgpr_base << shift) + x),
> -							(unsigned)((ws.gpr_alloc.sgpr_base << shift) + x + 3),
> -							(unsigned long)sgprs[x],
> -							(unsigned long)sgprs[x+1],
> -							(unsigned long)sgprs[x+2],
> -							(unsigned long)sgprs[x+3]);
> -					}
> +						for (x =3D 0; x < ((ws.gpr_alloc.sgpr_size + 1) << shift); x +=3D=
 4)
> +							printf(">SGPRS[%u..%u] =3D { %08lx, %08lx, %08lx, %08lx }\n",
> +								(unsigned)((ws.gpr_alloc.sgpr_base << shift) + x),
> +								(unsigned)((ws.gpr_alloc.sgpr_base << shift) + x + 3),
> +								(unsigned long)sgprs[x],
> +								(unsigned long)sgprs[x+1],
> +								(unsigned long)sgprs[x+2],
> +								(unsigned long)sgprs[x+3]);
> =20
> -					if (options.bitfields) {
> +						pgm_addr =3D (((uint64_t)ws.pc_hi << 32) | ws.pc_lo) - (sizeof(o=
pcodes)/2);
> +						umr_read_vram(asic, ws.hw_id.vm_id, pgm_addr, sizeof(opcodes), o=
pcodes);
> +						for (x =3D 0; x < sizeof(opcodes)/4; x++) {
> +							printf(">pgm[%lu@%llx] =3D %08lx\n",
> +								(unsigned long)ws.hw_id.vm_id,
> +								(unsigned long long)(pgm_addr + 4 * x),
> +								(unsigned long)opcodes[x]);
> +						}
> +					} else {
>  						first =3D 0;
>  						printf("\n------------------------------------------------------=
\nse%u.sh%u.cu%u.simd%u.wave%u\n",
>  						(unsigned)se, (unsigned)sh, (unsigned)cu, (unsigned)ws.hw_id.sim=
d_id, (unsigned)ws.hw_id.wave_id);
> @@ -156,6 +164,20 @@ void umr_print_waves(struct umr_asic *asic)
>  								(unsigned long)sgprs[x+2],
>  								(unsigned long)sgprs[x+3]);
> =20
> +						printf("\n\nPGM_MEM:\n");
> +						pgm_addr =3D (((uint64_t)ws.pc_hi << 32) | ws.pc_lo) - (sizeof(o=
pcodes)/2);
> +						umr_read_vram(asic, ws.hw_id.vm_id, pgm_addr, sizeof(opcodes), o=
pcodes);
> +						for (x =3D 0; x < sizeof(opcodes)/4; x++) {
> +							if (x =3D=3D (sizeof(opcodes)/8))
> +								printf("*\t");
> +							else
> +								printf("\t");
> +							printf("pgm[%lu@%llx] =3D %08lx\n",
> +								(unsigned long)ws.hw_id.vm_id,
> +								(unsigned long long)(pgm_addr + 4 * x),
> +								(unsigned long)opcodes[x]);
> +						}
> +
>  						Hv("LDS_ALLOC", ws.lds_alloc.value);
>  						PP(lds_alloc, lds_base);
>  						PP(lds_alloc, lds_size);
>=20


--1E4EdaNapFNkLBhXaCN1wIQSiop3Xkfn9--

--gqG7nOK3HAhOc9pF6Efrdo2JK9Wli8CtE
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJY1RhRAAoJEP4bvbfZuWjbvNcQAK2X+/ykuD4BEbcfrn8mctzo
WtWs0FXkrA+G7uNgFP+iwKzuQYw3ZRh8odTuXUZQV9oYYrm6DfnlkB5EFe6RD0fi
PlEyUrAhpNR2w+QXjKi3QJ/Rfc/SaMLDCSElsz0hKQ/Cqk8hwO5+7Jfu9qFrQXjG
hqaC+Vd/s7hEuP/INkIvN9CboJ+cBHV81YJHs6P1f3s/MJvRVyUOpDrm2cil+vCB
sqMY82TzQ0PDXu3nCPYuyxNvyk5TyrmUGLgAW2LNIjMe0p/thdGINCtoVV0pnGHx
k1phvWnh6tDEzZDZ/iHu2koN1xoOvk/unXk9LqxQKDKluKlCNAJIIHuit+WeTf0j
kN9ZQogNecOgbn1uZQml3d543ySGEBGm67ZU6n7XdaiJkOEORxYnRGnich4+J9O5
HiTJsB374oSM3H2nZTY93g6ZvuQeVfDS9wgjZOuXiRfMqvAves5/cIp/+emVFTQp
zQrOmibN1+dSRZcr0ZQLkUUrvECiAFw6YMdbuopqYBPiorUHnrypODuDGDFPr31d
+afu8o8sP+ZpmAp1tpmg8KARnHnKPa6RLaU88pwZV+E3GBWR0kTi913Ar+X/bOiV
97w35MomoS5vlUnHrmJnxhrvJTTkbIYhszaaRWhIIe3jQjVerN+xRKoAcv94Ew+A
M4bZ1JjlGRV/WO7xhYmK
=U5fo
-----END PGP SIGNATURE-----

--gqG7nOK3HAhOc9pF6Efrdo2JK9Wli8CtE--

--===============0555460636==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============0555460636==--
