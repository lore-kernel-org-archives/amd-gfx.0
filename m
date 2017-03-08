From: Edward O'Callaghan <funfunctor-dczkZgxz+BNUPWh3PAxdjQ@public.gmane.org>
Subject: Re: [PATCH umr] Add ability to read from virtual memory
Date: Thu, 9 Mar 2017 10:36:03 +1100
Message-ID: <cc07972c-1f57-5d87-0734-f4750e2a0159@folklore1984.net>
References: <20170308190645.26317-1-tom.stdenis@amd.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0039852190=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <20170308190645.26317-1-tom.stdenis-5C7GfCeVMHo@public.gmane.org>
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
--===============0039852190==
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="hDWaRStnto731aPlpF92HOsxDtlGRu3Vo"

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--hDWaRStnto731aPlpF92HOsxDtlGRu3Vo
Content-Type: multipart/mixed; boundary="lnNRfDWMuCPVrddc2mpbgV7BeijBOvdEg";
 protected-headers="v1"
From: Edward O'Callaghan <funfunctor-dczkZgxz+BNUPWh3PAxdjQ@public.gmane.org>
To: Tom St Denis <tstdenis82-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Cc: Tom St Denis <tom.stdenis-5C7GfCeVMHo@public.gmane.org>
Message-ID: <cc07972c-1f57-5d87-0734-f4750e2a0159-dczkZgxz+BNUPWh3PAxdjQ@public.gmane.org>
Subject: Re: [PATCH umr] Add ability to read from virtual memory
References: <20170308190645.26317-1-tom.stdenis-5C7GfCeVMHo@public.gmane.org>
In-Reply-To: <20170308190645.26317-1-tom.stdenis-5C7GfCeVMHo@public.gmane.org>

--lnNRfDWMuCPVrddc2mpbgV7BeijBOvdEg
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Reviewed-by: Edward O'Callaghan <funfunctor-dczkZgxz+BNUPWh3PAxdjQ@public.gmane.org>

On 03/09/2017 06:06 AM, Tom St Denis wrote:
> Updates the --vram command to add the ability to read from
> one of the VM domains instead.
>=20
> Signed-off-by: Tom St Denis <tom.stdenis-5C7GfCeVMHo@public.gmane.org>
> ---
>  doc/umr.1      |  7 ++++---
>  src/app/main.c | 16 ++++++++++------
>  2 files changed, 14 insertions(+), 9 deletions(-)
>=20
> diff --git a/doc/umr.1 b/doc/umr.1
> index a12dfb0a00ff..90be2d6316ce 100644
> --- a/doc/umr.1
> +++ b/doc/umr.1
> @@ -85,9 +85,10 @@ invoking it very rapidly.  Unlike the wave count rea=
ding in --top this command
>  will operate regardless of whether GFX PG is enabled or not.  Can use
>  .B bits
>  to decode the wave bitfields.
> -.IP "--vram, -v <address> <size>"
> -Read 'size' bytes (in decimal) from the address specified (in hexadeci=
mal) from VRAM
> -to stdout.  Can use 'use_pci' to directly access VRAM.
> +.IP "--vram, -v [vmid@]<address> <size>"
> +Read 'size' bytes (in hex) from the address specified (in hexadecimal)=
 from VRAM
> +to stdout.  Optionally specify the VMID (in decimal) treating the addr=
ess as a
> +virtual address instead.  Can use 'use_pci' to directly access VRAM.
> =20
>  .IP "--option, -O <string>[,<string>,...]"
>  Specify options to the tool.  Multiple options can be specified as com=
ma
> diff --git a/src/app/main.c b/src/app/main.c
> index 99e014888571..e8f786b39743 100644
> --- a/src/app/main.c
> +++ b/src/app/main.c
> @@ -320,16 +320,19 @@ int main(int argc, char **argv)
>  			if (i + 2 < argc) {
>  				unsigned char buf[256];
>  				uint64_t address;
> -				uint32_t size, n;
> +				uint32_t size, n, vmid;
> =20
>  				if (!asic)
>  					asic =3D get_asic();
> =20
> -				sscanf(argv[i+1], "%"SCNx64, &address);
> -				sscanf(argv[i+2], "%"SCNu32, &size);
> +				if ((n =3D sscanf(argv[i+1], "%"SCNu32"@%"SCNx64, &vmid, &address)=
) !=3D 2) {
> +					sscanf(argv[i+1], "%"SCNx64, &address);
> +					vmid =3D 0xFFFF;
> +				}
> +				sscanf(argv[i+2], "%"SCNx32, &size);
>  				while (size) {
>  					n =3D size > sizeof(buf) ? sizeof(buf) : size;
> -					umr_read_vram(asic, 0xFFFF, address, n, buf);
> +					umr_read_vram(asic, vmid, address, n, buf);
>  					fwrite(buf, 1, n, stdout);
>  					size -=3D n;
>  					address +=3D n;
> @@ -383,8 +386,9 @@ int main(int argc, char **argv)
>  	"\n\t\toptions 'use_colour' to colourize output and 'use_pci' to impr=
ove efficiency.\n"
>  "\n\t--waves, -wa\n\t\tPrint out information about any active CU waves=
=2E  Can use '-O bits'"
>  	"\n\t\tto see decoding of various wave fields.\n"
> -"\n\t--vram, -v <address> <size>"
> -	"\n\t\tRead 'size' bytes (in decimal) from a given address (in hex) t=
o stdout.\n"
> +"\n\t--vram, -v [<vmid>@]<address> <size>"
> +	"\n\t\tRead 'size' bytes (in hex) from a given address (in hex) to st=
dout. Optionally"
> +	"\n\t\tspecify the VMID (in decimal) treating the address as a virtua=
l address instead.\n"
>  "\n\t--option -O <string>[,<string>,...]\n\t\tEnable various flags: ri=
sky, bits, bitsfull, empty_log, follow, named, many,"
>  	"\n\t\tuse_pci, use_colour, read_smc, quiet.\n"
>  "\n\n", UMR_BUILD_VER, UMR_BUILD_REV);
>=20


--lnNRfDWMuCPVrddc2mpbgV7BeijBOvdEg--

--hDWaRStnto731aPlpF92HOsxDtlGRu3Vo
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJYwJVkAAoJEP4bvbfZuWjbqM0QALh9dCLcEMZ9/+DW1raTzdxk
0GD3Zi3ReAy/8IyyTpDQqjcBhUz0jE+J6fh1OVHhIOQJ1vMEAbdJboKJS1b7oOdY
R3to5IJ4Svpn1G4lZ8i38qIwrm1OUwPjJdeqtbuQyB+v/HGtS9ppqbi8Cv8wcA8K
NY/WwDW0ZHWhieqlfQdnVvssqQM0EFCDW8hDspWRuRQdNPuyBOf1cwSQ4fADJYgl
2ycvqL3yKb5hc4p02KyGNmCIB3v3cYFBKi8wnCkapg0Av4h498zl0xajZNOiGfBp
wvfAU1yn1VLhSA+kBM8sRA3qUnOLKeiDfUHeYVyebHZHNT7TyP/hSTRRR6kZ6Fbb
lGDCdv1oEMxHwLlk8+9Z7UwbEdwfHlF1Rqn0WyLdQmtzWl84PNE5COg9bZe9Mix7
LhN9plJmb4+VhfN12le70rYMtKjxmoy1uZlB03IhIStMvj9x18c1qlcuTfwxxo+J
7PtoL5Rg8xVwXvJFnFznb73H+AwgNUfS7BW658JBzqiaQ1CGwT/eySmB3SZYWNnr
7E4TyKIznWGKWWTPTFsXx7DLaCtktXNAAPqxuwNldhVRbWcwHajb6c9BOfpf4WBp
Ah48znOvairjh2s5pnEAD024OPBr+jB22rNC+gh0+DpT1QjemFKVjhIInqfevDWQ
0qu/yyzILpqA1xrK18xT
=HRdw
-----END PGP SIGNATURE-----

--hDWaRStnto731aPlpF92HOsxDtlGRu3Vo--

--===============0039852190==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============0039852190==--
