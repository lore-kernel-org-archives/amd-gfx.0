From: Edward O'Callaghan <funfunctor-dczkZgxz+BNUPWh3PAxdjQ@public.gmane.org>
Subject: Re: [PATCH umr] Add SENSOR for SI/CIK/KV systems.
Date: Sat, 18 Feb 2017 11:30:50 +1100
Message-ID: <7f0acede-6ed3-3d09-29d1-93843738c9a4@folklore1984.net>
References: <20170217192644.4554-1-tom.stdenis@amd.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0335203471=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <20170217192644.4554-1-tom.stdenis-5C7GfCeVMHo@public.gmane.org>
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
--===============0335203471==
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="eqML2cECadEVnRwFRiw1ocDEfb5h0uRp8"

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--eqML2cECadEVnRwFRiw1ocDEfb5h0uRp8
Content-Type: multipart/mixed; boundary="dHBoTLi4XbicoxHaAlwwfDbKXawiwgxmA";
 protected-headers="v1"
From: Edward O'Callaghan <funfunctor-dczkZgxz+BNUPWh3PAxdjQ@public.gmane.org>
To: Tom St Denis <tstdenis82-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Cc: Tom St Denis <tom.stdenis-5C7GfCeVMHo@public.gmane.org>
Message-ID: <7f0acede-6ed3-3d09-29d1-93843738c9a4-dczkZgxz+BNUPWh3PAxdjQ@public.gmane.org>
Subject: Re: [PATCH umr] Add SENSOR for SI/CIK/KV systems.
References: <20170217192644.4554-1-tom.stdenis-5C7GfCeVMHo@public.gmane.org>
In-Reply-To: <20170217192644.4554-1-tom.stdenis-5C7GfCeVMHo@public.gmane.org>

--dHBoTLi4XbicoxHaAlwwfDbKXawiwgxmA
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Reviewed-by: Edward O'Callaghan <funfunctor-dczkZgxz+BNUPWh3PAxdjQ@public.gmane.org>

On 02/18/2017 06:26 AM, Tom St Denis wrote:
> Signed-off-by: Tom St Denis <tom.stdenis-5C7GfCeVMHo@public.gmane.org>
> ---
>  src/app/top.c | 30 ++++++++++++++++++++++++++++++
>  1 file changed, 30 insertions(+)
>=20
> diff --git a/src/app/top.c b/src/app/top.c
> index 92ab8ab854af..c97a0c9d93ab 100644
> --- a/src/app/top.c
> +++ b/src/app/top.c
> @@ -231,6 +231,27 @@ static struct umr_bitfield stat_vi_sensor_bits[] =3D=
 {
>  	{ NULL, 0, 0, NULL },
>  };
> =20
> +static struct umr_bitfield stat_cik_sensor_bits[] =3D {
> +	{ "GFX_SCLK", AMDGPU_PP_SENSOR_GFX_SCLK, SENSOR_D100|(SENSOR_MHZ<<4),=
 &umr_bitfield_default },
> +	{ "GFX_MCLK", AMDGPU_PP_SENSOR_GFX_MCLK, SENSOR_D100|(SENSOR_MHZ<<4),=
 &umr_bitfield_default },
> +	{ "GPU_LOAD", AMDGPU_PP_SENSOR_GPU_LOAD, SENSOR_PERCENT<<4, &umr_bitf=
ield_default },
> +	{ "GPU_TEMP", AMDGPU_PP_SENSOR_GPU_TEMP, SENSOR_D1000|(SENSOR_TEMP<<4=
), &umr_bitfield_default },
> +	{ NULL, 0, 0, NULL },
> +};
> +
> +static struct umr_bitfield stat_kaveri_sensor_bits[] =3D {
> +	{ "GFX_SCLK", AMDGPU_PP_SENSOR_GFX_SCLK, SENSOR_D100|(SENSOR_MHZ<<4),=
 &umr_bitfield_default },
> +	{ "GPU_TEMP", AMDGPU_PP_SENSOR_GPU_TEMP, SENSOR_D1000|(SENSOR_TEMP<<4=
), &umr_bitfield_default },
> +	{ NULL, 0, 0, NULL },
> +};
> +
> +static struct umr_bitfield stat_si_sensor_bits[] =3D {
> +	{ "GFX_SCLK", AMDGPU_PP_SENSOR_GFX_SCLK, SENSOR_D100|(SENSOR_MHZ<<4),=
 &umr_bitfield_default },
> +	{ "GFX_MCLK", AMDGPU_PP_SENSOR_GFX_MCLK, SENSOR_D100|(SENSOR_MHZ<<4),=
 &umr_bitfield_default },
> +	{ "GPU_TEMP", AMDGPU_PP_SENSOR_GPU_TEMP, SENSOR_D1000|(SENSOR_TEMP<<4=
), &umr_bitfield_default },
> +	{ NULL, 0, 0, NULL },
> +};
> +
>  #define AMDGPU_INFO_NUM_BYTES_MOVED		0x0f
>  #define AMDGPU_INFO_VRAM_USAGE			0x10
>  #define AMDGPU_INFO_GTT_USAGE			0x11
> @@ -774,6 +795,15 @@ static void top_build_vi_program(struct umr_asic *=
asic)
>  	} else if (asic->config.gfx.family =3D=3D 130) {
>  		// Volcanic Islands Family
>  		ENTRY_SENSOR(i++, "GFX_SCLK", &stat_vi_sensor_bits[0], &top_options.=
vi.sensors, "Sensors");
> +	} else if (asic->config.gfx.family =3D=3D 125) {
> +		// Fusion
> +		ENTRY_SENSOR(i++, "GFX_SCLK", &stat_kaveri_sensor_bits[0], &top_opti=
ons.vi.sensors, "Sensors");
> +	} else if (asic->config.gfx.family =3D=3D 120) {
> +		// CIK
> +		ENTRY_SENSOR(i++, "GFX_SCLK", &stat_cik_sensor_bits[0], &top_options=
=2Evi.sensors, "Sensors");
> +	} else if (asic->config.gfx.family =3D=3D 110) {
> +		// SI
> +		ENTRY_SENSOR(i++, "GFX_SCLK", &stat_si_sensor_bits[0], &top_options.=
vi.sensors, "Sensors");
>  	}
> =20
>  	// More GFX bits
>=20


--dHBoTLi4XbicoxHaAlwwfDbKXawiwgxmA--

--eqML2cECadEVnRwFRiw1ocDEfb5h0uRp8
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJYp5W6AAoJEP4bvbfZuWjbdD0QAKszUL50PylnnfZB4k3mzgyS
cvv7r3mRYv3J7DISJrJNkqyLoJuZ3rcbZgZCwY+/4EDCGV9nOc8k7/dfgZeEuFUQ
sAWuNTMDV5iEREIYD7C3005QIaM6qm/wcpMzY4lZog9DOdDZP4kbfgK6EHW9VuaH
jUvXR0Pz1Pi0alPdXqhOoKQFVd1W0mD9nwkplvDCcO/lJ2B8im/OU/2FrKcMLG3V
VLDfChloITtt3eTtVT6C3xnZF9ODkFGwPK8ROVMHZKYf3Dlc3HtiJ5w+1sT65ltT
V4egdUu1SF0B97OSMPijTQV+qpfAZYIXnskaHaxextNnb8Zt9e0NYYN3HssjGyVL
J9RBmFn9xyCfd+g+BXNT8xJCZHtOxOa9N8nha7uJaIK7rZcN0qPgYxipIp9TLa4n
DmJjURBxgdy69vvLLaLVH1chIylYlrdYS+Xgq0S6YiQzmQOsmhf87IEYA+9tEPl7
8cIW9KxPFaArLlvTQ8tpbxU6/CWSG701EP+OasNhnwmigbuXaji6Ulhmo56b1M7C
D9WrR/6dAAebCXcxsQ3qguA2uhMVeJRjfPjb7kwFmnfn4Dyl8kM0m/tKtlgVGH4X
CaimuQWRd9ZR8eQ50ureyc+8fcGYZ8HFdVkEwAWIaZ1Sg46744kv6h+cZgvVmklu
Qs5L4LCUVvHziHU3IvF3
=lNGP
-----END PGP SIGNATURE-----

--eqML2cECadEVnRwFRiw1ocDEfb5h0uRp8--

--===============0335203471==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============0335203471==--
