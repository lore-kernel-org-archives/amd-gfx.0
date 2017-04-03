From: =?UTF-8?Q?Kai_Wasserb=c3=a4ch?= <kai-1ZKVMVCtJ2dx9oSEVPI0kiST3g8Odh+X@public.gmane.org>
Subject: Re: [PATCH v2] drm/amdgpu: Read vram width from integrated system
 info table
Date: Mon, 3 Apr 2017 18:29:55 +0200
Message-ID: <7039d294-d6af-76dd-e129-854013ab4947@dev.carbon-project.org>
References: <20170403150107.13253-1-harry.wentland@amd.com>
 <8623a5d4-1e10-fc46-aaa2-0777b500c3a2@dev.carbon-project.org>
 <BN6PR12MB1652CE82ACBFD409F3829D35F7080@BN6PR12MB1652.namprd12.prod.outlook.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0365421981=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <BN6PR12MB1652CE82ACBFD409F3829D35F7080-/b2+HYfkarQqUD6E6FAiowdYzm3356FpvxpqHgZTriW3zl9H0oFU5g@public.gmane.org>
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
To: Alex Deucher <alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Harry Wentland <harry.wentland-5C7GfCeVMHo@public.gmane.org>, amd-gfx list <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--===============0365421981==
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="x0jCxmDQiBNwScoMoq7FpkEnJLrAfudR2"

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--x0jCxmDQiBNwScoMoq7FpkEnJLrAfudR2
Content-Type: multipart/mixed; boundary="jRN3a90PxTJcTOPLUAJPqAFqpKK9DUpNu";
 protected-headers="v1"
From: =?UTF-8?Q?Kai_Wasserb=c3=a4ch?= <kai-1ZKVMVCtJ2dx9oSEVPI0kiST3g8Odh+X@public.gmane.org>
To: Alex Deucher <alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
 Harry Wentland <harry.wentland-5C7GfCeVMHo@public.gmane.org>,
 amd-gfx list <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
Message-ID: <7039d294-d6af-76dd-e129-854013ab4947-1ZKVMVCtJ2dx9oSEVPI0kiST3g8Odh+X@public.gmane.org>
Subject: Re: [PATCH v2] drm/amdgpu: Read vram width from integrated system
 info table
References: <20170403150107.13253-1-harry.wentland-5C7GfCeVMHo@public.gmane.org>
 <8623a5d4-1e10-fc46-aaa2-0777b500c3a2-1ZKVMVCtJ2dx9oSEVPI0kiST3g8Odh+X@public.gmane.org>
 <BN6PR12MB1652CE82ACBFD409F3829D35F7080-/b2+HYfkarQqUD6E6FAiowdYzm3356FpvxpqHgZTriW3zl9H0oFU5g@public.gmane.org>
In-Reply-To: <BN6PR12MB1652CE82ACBFD409F3829D35F7080-/b2+HYfkarQqUD6E6FAiowdYzm3356FpvxpqHgZTriW3zl9H0oFU5g@public.gmane.org>

--jRN3a90PxTJcTOPLUAJPqAFqpKK9DUpNu
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Deucher, Alexander wrote on 03.04.2017 17:43:
>> -----Original Message-----
>> From: amd-gfx [mailto:amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org] On Behalf=

>> Of Kai Wasserb=C3=A4ch
>> Sent: Monday, April 03, 2017 11:20 AM
>> To: Wentland, Harry; amd-gfx list
>> Subject: Re: [PATCH v2] drm/amdgpu: Read vram width from integrated
>> system info table
>>
>> [...]
>>
>> I might miss something subtle here, but after reading this a couple of=
 times,
>> I've convinced myself this is exactly the same switch statement as in
>> gmc_v7_0_mc_init() above, right? If so: why not move that part to comm=
on
>> code as
>> well?
>=20
> The register offsets and bitfields may change across different IP revis=
ions.  The actual switch statement itself could be common I guess (minus =
the registers), but I'm not sure if it's worth the effort.

Thanks to both of you for the explanation. Since everything was named exa=
ctly
the same I assumed the definitions for the registers matched as well. Sti=
ll if
large chunks of code are common helpers might still be nice and reduce th=
e
overall LOCs. Anyway, that's obviously your decision.

Cheers,
Kai


--jRN3a90PxTJcTOPLUAJPqAFqpKK9DUpNu--

--x0jCxmDQiBNwScoMoq7FpkEnJLrAfudR2
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAEBCgAdFiEEBgCWzvPI5zPlthWHownXbOHeWdIFAljieIQACgkQownXbOHe
WdLI3Av/ffCgCZ7qz1hxY7oo5fxkYg6xXR2QBe6eIp+caOjwubLShprOObkcLFLJ
HoLt8N28EQWySvbfMS3wzWiW1W29XARBID625K/KnuLLunOc5UOC5GwrYxpCexGq
0jIInfJBZv9vV1Ua0Dk33oVFUDwDasjmlR59iPmZFUTN6KdGT9Jd+U+6jgdYNZ3H
T/Vb1d0QVSmgkPaF0fY132BEkfOAuVyuVl6ZIM6MZXKUaPJQkzk01NGlTkXIIH7C
Z+VyUlG31iXol0vr4taPhmHmeIXGxWjQexafMifZX06B53KgXacuJty6f6txnOdL
3V37mBlYnYjv+9m5IOLRlwh+Q3iCkhGWqbBy1ZqX98anVAku9ndSevGq54c0YZLy
Inan6G+zAAfKjMoUy5Ua9PxGYLHsMmAyweFBHKhqLk4m8SSVwikpBPv4YiHKtAan
O06VsAB8sSXVYXw96Dykjqp2yNDaTZdp0Gm53d3wTJ0TH2+DCuEsglgeBc38bg00
TwOgUZkO
=x48L
-----END PGP SIGNATURE-----

--x0jCxmDQiBNwScoMoq7FpkEnJLrAfudR2--

--===============0365421981==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============0365421981==--
