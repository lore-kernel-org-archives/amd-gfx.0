From: =?UTF-8?Q?Kai_Wasserb=c3=a4ch?= <kai-1ZKVMVCtJ2dx9oSEVPI0kiST3g8Odh+X@public.gmane.org>
Subject: amdgpu: DRI3 with EGL?
Date: Mon, 16 Oct 2017 17:53:35 +0200
Message-ID: <c3bc7d1d-37d0-c194-5bf7-535949ef194b@dev.carbon-project.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0181516897=="
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
--===============0181516897==
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="Hg379G9OKK2KrhPh24FLh61ouQgFqHVTF"

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--Hg379G9OKK2KrhPh24FLh61ouQgFqHVTF
Content-Type: multipart/mixed; boundary="aCb5VjsRC3POtvwLiUCaGb4N1IBae1Pb6";
 protected-headers="v1"
From: =?UTF-8?Q?Kai_Wasserb=c3=a4ch?= <kai-1ZKVMVCtJ2dx9oSEVPI0kiST3g8Odh+X@public.gmane.org>
To: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Message-ID: <c3bc7d1d-37d0-c194-5bf7-535949ef194b-1ZKVMVCtJ2dx9oSEVPI0kiST3g8Odh+X@public.gmane.org>
Subject: amdgpu: DRI3 with EGL?

--aCb5VjsRC3POtvwLiUCaGb4N1IBae1Pb6
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: quoted-printable

[Please CC me on all replies, I'm not subscribed to amd-gfx.]

Hey,
I'm not sure whether this is a bug or if I'm just missing something. I've=
 got
the following stack (Debian testing as a base):
GPU: Hawaii PRO [Radeon R9 290] (ChipID =3D 0x67b1)
Mesa: Git:master/c7a81dcea9
libdrm: 2.4.84-2
LLVM: SVN:trunk/r315850 (6.0 devel)
X.Org: 2:1.19.3-2
Linux: 4.13.7
Firmware (firmware-amd-graphics): 20170823-1
libclc: Git:master/df9db2adca
DDX (xserver-xorg-video-amdgpu): 1.4.0-1

In my xorg.conf I have (and if I read the manpage correctly, the =C2=BBOp=
tion "DRI"
"3"=C2=AB line shouldn't even be necessary anymore):
> Section "Device"
>         Identifier      "Forced to amdgpu with DRI3"
>         Driver          "amdgpu"
>         Option          "DRI"                   "3"
> EndSection

But when I look at my Xorg.0.log or the output of eglinfo, I see the foll=
owing
lines:
- Xorg.0.log:	[    15.305] (II) glamor: EGL version 1.5 (DRI2):
- eglinfo:	EGL version string: 1.5 (DRI2)

My understanding was, that amdgpu supports DRI3 for quite some time now a=
nd
therefore would expect to see something like "EGL version string: 1.5 (DR=
I3)".

What am I missing? Is this a configuration I messed up? Is it a bug somew=
here
(I'm happy to report it against the right module, just point me in the ri=
ght
direction)?

Additional notes:
- I checked this occasionally and I never saw DRI3, so I'd say if somethi=
ng is
amiss, it has always been this way
- If you need anything else, let me know.

Thank you in advance for your reply!

Cheers,
Kai


--aCb5VjsRC3POtvwLiUCaGb4N1IBae1Pb6--

--Hg379G9OKK2KrhPh24FLh61ouQgFqHVTF
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAEBCgAdFiEEBgCWzvPI5zPlthWHownXbOHeWdIFAlnk1gsACgkQownXbOHe
WdIRKwv+PdI7lZmwe27s6rOBgUttyLyTB4nMi5f9KOMkSz7J3PppztgEWgIriiNs
0STRbVlkT97XOPSTeuiTiYZVGPlRNGgMPk+s4hVw3/dH63YUPe9PBVF/5RDBIf1L
3g/4u1mg8eLMHV8+cM1VODmc7K+u8NSrgo3KzDayvFuF2sNeyNIIw/xRRFLdK7/U
VyR6zbnxZauFq62ayMECwN30Q45LFUT5hvLF6KsKFhiZZldeHwuumt8gHj1KVn6q
KiHxUgJFqSoiOPL0kAH7WauStzP0/uawFzb91B+Y4jJfodEt3cd3r/4Q63W/aamU
B9Cku+3KxEJILmrr6HF37A2jM7A6RiuVqrw3vlAD0UT/XiXB3NEgq9GfligH6sPz
xgrYkGZmqOS6N9TZpVEiiKUvuW8bDmWdxSZAfXYZq9OezcG/HwooQUHg9+uh64G4
hzj4qKVPo20tPjL9NkP+07bT+CJ+i09dUO0+MSXWR6YkCXsTzGRu8swV2vXC6Zva
lSSa4Sqb
=jMDa
-----END PGP SIGNATURE-----

--Hg379G9OKK2KrhPh24FLh61ouQgFqHVTF--

--===============0181516897==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============0181516897==--
