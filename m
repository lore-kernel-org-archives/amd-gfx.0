From: =?UTF-8?Q?Kai_Wasserb=c3=a4ch?= <kai-1ZKVMVCtJ2dx9oSEVPI0kiST3g8Odh+X@public.gmane.org>
Subject: Video memory reported by GLX_MESA_query_renderer differs between
 amdgpu and radeon
Date: Fri, 9 Dec 2016 21:27:24 +0100
Message-ID: <dfe0d8dd-81fb-8703-61c8-e1a17ba7c9c4@dev.carbon-project.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0802965236=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
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
To: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--===============0802965236==
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="8ajlwmlNdScDQV8ANMn2w5Asadd81abT6"

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--8ajlwmlNdScDQV8ANMn2w5Asadd81abT6
Content-Type: multipart/mixed; boundary="nJSO0Q9l65IFGpBGVP26Jkm3Ru7Psn6JL";
 protected-headers="v1"
From: =?UTF-8?Q?Kai_Wasserb=c3=a4ch?= <kai-1ZKVMVCtJ2dx9oSEVPI0kiST3g8Odh+X@public.gmane.org>
To: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Message-ID: <dfe0d8dd-81fb-8703-61c8-e1a17ba7c9c4-1ZKVMVCtJ2dx9oSEVPI0kiST3g8Odh+X@public.gmane.org>
Subject: Video memory reported by GLX_MESA_query_renderer differs between
 amdgpu and radeon

--nJSO0Q9l65IFGpBGVP26Jkm3Ru7Psn6JL
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

[Please CC me on all replies, I'm not subscribed to this list.]

Hey,
I've been noticing that GLX_MESA_query_renderer reports less video memory=
 when I
use amdgpu for my Hawaii PRO GPU, than when I use radeon. Since I'm prett=
y happy
with amdgpu (as I do not use HDMI audio) and it's the code, that gets act=
ive
improvements, I'd like to stay with it, but having 40 MB of video memory
"vanish" is not nice.
With radeon GLX_MESA_query_renderer reports 4096 MB RAM (as expected, the=
 R9 290
was sold/advertised with that), while I'm seeing 4056 MB with amdgpu (las=
t
tested kernel: 4.8.13).

As I'm not sure, whether this is a bug or rather some always reserved mem=
ory
area, which gets subtracted before reporting the available memory, I didn=
't file
a bug report and rather am writing this e-mail. If it's a bug I'm happy t=
o file
the report against amdgpu.

Cheers,
Kai


--nJSO0Q9l65IFGpBGVP26Jkm3Ru7Psn6JL--

--8ajlwmlNdScDQV8ANMn2w5Asadd81abT6
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAEBCgAdFiEEBgCWzvPI5zPlthWHownXbOHeWdIFAlhLE70ACgkQownXbOHe
WdKB3gv9GoFE8SlA/+7cSWCPIkVCAwT9hXnTAoW9MqgR4nPpXbZNlYK785v6xvrs
Uai+dPJjXMbJfzGaWFgPbPl2QTNlMbxjEwiXq/lLCyfvlwudi4s78VZ5eMXbE93Z
hxLLymMbrbeotXgV7H1r8euW2DfI4Hs6QXvMCKa/S8yUKY3ZKaqjPTIL4x41IkQK
irzvBPwVlINfpfuZu4XwWL1x9YycW2BeEb1KLNMZncB//f0eFVrzr7q8RIYi6TSR
zLqo5LBlo+eMHMh3F+qkK7bzin+fbSzNc2Axn9IcTF+1lfQCK6bFbxlsUCzVTjB6
8h3A+QAJj/m9isBd1uJgC5aEl+BWa4yGjPCehNfD85s6yUS0uF8d5zuD0fbvCW2H
tkV7+WdJgH6J4+3Vlw9SdUw+8nR3AWJ49n5MNMupRUN8ncy9jsS9OPy1Ag1baHP/
V9SIW8bZGAOtNw4kUAJ9J3PCXk57dnP3VhRZcsI57GzAkc1s4L1Q/EKiLLpvm67u
XStfkzHZ
=/t8j
-----END PGP SIGNATURE-----

--8ajlwmlNdScDQV8ANMn2w5Asadd81abT6--

--===============0802965236==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============0802965236==--
