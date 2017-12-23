From: =?UTF-8?Q?Felix_K=c3=bchling?= <felix.kuehling-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: PCIe3 atomics requirement for amdkfd
Date: Sat, 23 Dec 2017 16:40:58 +0100
Message-ID: <3f7e6fed-8668-b469-8813-e6677cb980ca@gmail.com>
References: <c2c34443-9ba1-661b-476d-b657a7ddfe85@redhat.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2082981400=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <c2c34443-9ba1-661b-476d-b657a7ddfe85-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
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
To: tstellar-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Cc: Felix Kuehling <felix.kuehling-5C7GfCeVMHo@public.gmane.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--===============2082981400==
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="lNOH6SebaLD93IIaLdjnNhLFvwdrbmFPT"

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--lNOH6SebaLD93IIaLdjnNhLFvwdrbmFPT
Content-Type: multipart/mixed; boundary="wPOjrP3S4pTBAgPXSCrw70uCIxIK3HK8x";
 protected-headers="v1"
From: =?UTF-8?Q?Felix_K=c3=bchling?= <felix.kuehling-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
To: tstellar-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Cc: Felix Kuehling <felix.kuehling-5C7GfCeVMHo@public.gmane.org>
Message-ID: <3f7e6fed-8668-b469-8813-e6677cb980ca-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: PCIe3 atomics requirement for amdkfd
References: <c2c34443-9ba1-661b-476d-b657a7ddfe85-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
In-Reply-To: <c2c34443-9ba1-661b-476d-b657a7ddfe85-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>

--wPOjrP3S4pTBAgPXSCrw70uCIxIK3HK8x
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Language: en-GB

As I understand it, it would require changes in the ROCr Runtime and in
the firmware (MEC microcode). It also changes the programming model, so
it may affect certain applications or higher level language runtimes
that rely on atomic operations.

Regards,
=C2=A0 Felix


Am 19.12.2017 um 16:04 schrieb Tom Stellard:
> Hi,
>
> How hard of a requirement is PCIe3 atomics for dGPUs with the amdkfd
> kernel driver?  Is it possible to make modifications to the runtime/ker=
nel
> driver to drop this requirement?
>
> -Tom
> _______________________________________________
> amd-gfx mailing list
> amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx



--wPOjrP3S4pTBAgPXSCrw70uCIxIK3HK8x--

--lNOH6SebaLD93IIaLdjnNhLFvwdrbmFPT
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF4EAREIAAYFAlo+eREACgkQ1hkrDAUMk3Z1ZQD+I3F1tj1FNwdrBbz9J1x4CgSt
y/kTB5XV98uSoCPDsaYA/jdPkiQqaeNd3cKGtZbkydUqRFlpcKiUU5iv+EzD1Yr9
=8cMN
-----END PGP SIGNATURE-----

--lNOH6SebaLD93IIaLdjnNhLFvwdrbmFPT--

--===============2082981400==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============2082981400==--
