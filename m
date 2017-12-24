From: =?UTF-8?Q?Felix_K=c3=bchling?= <felix.kuehling-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: PCIe3 atomics requirement for amdkfd
Date: Sun, 24 Dec 2017 11:07:27 +0100
Message-ID: <b48cd8b5-5e0c-84fe-bbe8-541fe5657ae3@gmail.com>
References: <c2c34443-9ba1-661b-476d-b657a7ddfe85@redhat.com>
 <3f7e6fed-8668-b469-8813-e6677cb980ca@gmail.com>
 <CAHVSqQe1Tj+PnCR1h+HiHC=fXC81sUG4MXC7jWwmY+TomuU=9w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0656107514=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <CAHVSqQe1Tj+PnCR1h+HiHC=fXC81sUG4MXC7jWwmY+TomuU=9w-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
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
To: Alexander Kjeldaas <alexander.kjeldaas-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Felix Kuehling <felix.kuehling-5C7GfCeVMHo@public.gmane.org>, amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, tstellar-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--===============0656107514==
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="gqh4GOktTMoahDecehV4Ud4lrf1u1a7uf"

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--gqh4GOktTMoahDecehV4Ud4lrf1u1a7uf
Content-Type: multipart/mixed; boundary="qfAjN5osmoaLe9rn2dE4pwG8fUoI485Vo";
 protected-headers="v1"
From: =?UTF-8?Q?Felix_K=c3=bchling?= <felix.kuehling-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
To: Alexander Kjeldaas <alexander.kjeldaas-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: tstellar-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org,
 Felix Kuehling <felix.kuehling-5C7GfCeVMHo@public.gmane.org>
Message-ID: <b48cd8b5-5e0c-84fe-bbe8-541fe5657ae3-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: PCIe3 atomics requirement for amdkfd
References: <c2c34443-9ba1-661b-476d-b657a7ddfe85-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
 <3f7e6fed-8668-b469-8813-e6677cb980ca-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
 <CAHVSqQe1Tj+PnCR1h+HiHC=fXC81sUG4MXC7jWwmY+TomuU=9w-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
In-Reply-To: <CAHVSqQe1Tj+PnCR1h+HiHC=fXC81sUG4MXC7jWwmY+TomuU=9w-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>

--qfAjN5osmoaLe9rn2dE4pwG8fUoI485Vo
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Language: en-GB

Am 23.12.2017 um 17:26 schrieb Alexander Kjeldaas:
> =C2=A0Can the atomic ops work on the modified risers used for mining?

If the PCI bridge on the riser supports PCIe 3 atomic routing, then yes.

Regards,
=C2=A0 Felix

>
> On Dec 23, 2017 16:41, "Felix K=C3=BChling" <felix.kuehling-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
> <mailto:felix.kuehling-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>> wrote:
>
>     As I understand it, it would require changes in the ROCr Runtime
>     and in
>     the firmware (MEC microcode). It also changes the programming
>     model, so
>     it may affect certain applications or higher level language runtime=
s
>     that rely on atomic operations.
>
>     Regards,
>     =C2=A0 Felix
>
>
>     Am 19.12.2017 um 16:04 schrieb Tom Stellard:
>     > Hi,
>     >
>     > How hard of a requirement is PCIe3 atomics for dGPUs with the amd=
kfd
>     > kernel driver?=C2=A0 Is it possible to make modifications to the
>     runtime/kernel
>     > driver to drop this requirement?
>     >
>     > -Tom
>     > _______________________________________________
>     > amd-gfx mailing list
>     > amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org <mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp93rCq3LdnpKM@public.gmane.org=
rg>
>     > https://lists.freedesktop.org/mailman/listinfo/amd-gfx
>     <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>
>
>
>
>     _______________________________________________
>     amd-gfx mailing list
>     amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org <mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org=
>
>     https://lists.freedesktop.org/mailman/listinfo/amd-gfx
>     <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>
>



--qfAjN5osmoaLe9rn2dE4pwG8fUoI485Vo--

--gqh4GOktTMoahDecehV4Ud4lrf1u1a7uf
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF4EAREIAAYFAlo/fG0ACgkQ1hkrDAUMk3YNbgD/QrOLLppJpWp22zs0RenBwO14
H6sRy92jYvKJHDft3ywA/3+QRov8sKN9eglOmDSx5KbxhvB7KLQpkhl8495vpkkf
=lZrY
-----END PGP SIGNATURE-----

--gqh4GOktTMoahDecehV4Ud4lrf1u1a7uf--

--===============0656107514==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============0656107514==--
