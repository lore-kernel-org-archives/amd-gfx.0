From: Edward O'Callaghan <funfunctor-dczkZgxz+BNUPWh3PAxdjQ@public.gmane.org>
Subject: Re: [PATCH umr] PM4 packets list number of dwords not bytes
Date: Thu, 9 Mar 2017 10:36:19 +1100
Message-ID: <d3dea7a1-9aa7-0bd3-bf07-bd012d8d73fb@folklore1984.net>
References: <20170308200353.28824-1-tom.stdenis@amd.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1688090862=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <20170308200353.28824-1-tom.stdenis-5C7GfCeVMHo@public.gmane.org>
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
--===============1688090862==
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="jmABr7QABdCOOr3J8o4UEKnVQVWvWLbov"

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--jmABr7QABdCOOr3J8o4UEKnVQVWvWLbov
Content-Type: multipart/mixed; boundary="G02hVef7lQhTmSISECEFIN4rsRbjFLb8b";
 protected-headers="v1"
From: Edward O'Callaghan <funfunctor-dczkZgxz+BNUPWh3PAxdjQ@public.gmane.org>
To: Tom St Denis <tstdenis82-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Cc: Tom St Denis <tom.stdenis-5C7GfCeVMHo@public.gmane.org>
Message-ID: <d3dea7a1-9aa7-0bd3-bf07-bd012d8d73fb-dczkZgxz+BNUPWh3PAxdjQ@public.gmane.org>
Subject: Re: [PATCH umr] PM4 packets list number of dwords not bytes
References: <20170308200353.28824-1-tom.stdenis-5C7GfCeVMHo@public.gmane.org>
In-Reply-To: <20170308200353.28824-1-tom.stdenis-5C7GfCeVMHo@public.gmane.org>

--G02hVef7lQhTmSISECEFIN4rsRbjFLb8b
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Reviewed-by: Edward O'Callaghan <funfunctor-dczkZgxz+BNUPWh3PAxdjQ@public.gmane.org>

On 03/09/2017 07:03 AM, Tom St Denis wrote:
> When counting size of IBs count in dwords...
>=20
> Signed-off-by: Tom St Denis <tom.stdenis-5C7GfCeVMHo@public.gmane.org>
> ---
>  src/lib/ring_decode.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/src/lib/ring_decode.c b/src/lib/ring_decode.c
> index 401d6caaa088..a991f5ffa237 100644
> --- a/src/lib/ring_decode.c
> +++ b/src/lib/ring_decode.c
> @@ -334,7 +334,7 @@ static void print_decode_pm4_pkt3(struct umr_asic *=
asic, struct umr_ring_decoder
>  					decoder->pm4.next_ib_state.ib_addr_hi =3D BITS(ib, 0, 16);
>  					break;
>  				case 2: printf("IB_SIZE:%lu, VMID: %lu", BITS(ib, 0, 20), BITS(ib,=
 24, 32));
> -					decoder->pm4.next_ib_state.ib_size =3D BITS(ib, 0, 20);
> +					decoder->pm4.next_ib_state.ib_size =3D BITS(ib, 0, 20) * 4;
>  					decoder->pm4.next_ib_state.ib_vmid =3D BITS(ib, 24, 32);
>  					add_ib(decoder);
>  					break;
>=20


--G02hVef7lQhTmSISECEFIN4rsRbjFLb8b--

--jmABr7QABdCOOr3J8o4UEKnVQVWvWLbov
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJYwJVzAAoJEP4bvbfZuWjb53oP/3G3ekEntXYcZ0mZZAWwVaE7
zMFQD66k9cUBaRq74vHSSLf7Fu9R3zhqAZkG9rjDx4ZwHXPYB5qSaN6+wUxxXQ2D
BerxX/O2mKwLcYcUsKiZnM+34Y5Sz4tfg6cQqWmJIa4/K8vRGOIkwJ+oKeKUj2sA
aazRDUJkaTE/GnbaiE3lGsqNjnBdtO+OnRfmNL1J3bvq2rzjfPi3DwiCc5dhyuqs
MeA3BCi3bvf6fdbbggaZeQjCQYA9HeoTo3VFu4KxQVa7ZRF+UZSXsL/xT++GMrd9
6B4ONGBqb30OUIZ4yYDIOkwFO7OYXSuIV4VjNt506sWsBAhnx5hG1eLNmYGWtBPx
hezYKxQRCFpApNEMlOEZpS2HSVBXo17Y52pXzXj4YYs5wr/zpW1b/YtB7dVgT4Zd
KgYEubcEdfBAxDrlt53dMU/yMY9Yi5AT289273q9MxfuO5m53vUhMfWgwurp3xlJ
5xy0y3VHGJydBcOEZ9DsdIPlxqR3iN33kuvCd3KWl0ChIq5b+y5961phlnw0CJXE
HVP8nrd4048g7IctQ6Qno3GQI9XVhCuKgPuIDXrNXjUIYaVjBYOEy6Ap+Unkgryo
+V9p7fBUmMgjq5wLzjhwUoh00erxdaU7WT+ZmLNuk5Cfo8EKMmB14Rq1O1l5S2My
+h7+e00ywwIqFzgTnXqj
=lX7j
-----END PGP SIGNATURE-----

--jmABr7QABdCOOr3J8o4UEKnVQVWvWLbov--

--===============1688090862==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============1688090862==--
