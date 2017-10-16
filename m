From: =?UTF-8?Q?Kai_Wasserb=c3=a4ch?= <kai-1ZKVMVCtJ2dx9oSEVPI0kiST3g8Odh+X@public.gmane.org>
Subject: Re: amdgpu: DRI3 with EGL?
Date: Mon, 16 Oct 2017 18:21:13 +0200
Message-ID: <d48e9c96-83fd-de4c-0d70-ade8e6b1bd4f@dev.carbon-project.org>
References: <c3bc7d1d-37d0-c194-5bf7-535949ef194b@dev.carbon-project.org>
 <e5ffcce1-4e8f-e00d-82ee-5b95cab2282c@daenzer.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0107100307=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <e5ffcce1-4e8f-e00d-82ee-5b95cab2282c-otUistvHUpPR7s880joybQ@public.gmane.org>
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
To: =?UTF-8?Q?Michel_D=c3=a4nzer?= <michel-otUistvHUpPR7s880joybQ@public.gmane.org>
Cc: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--===============0107100307==
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="WRax4m8l5bhAOa0O1UCJ3e3JGdFChb5bJ"

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--WRax4m8l5bhAOa0O1UCJ3e3JGdFChb5bJ
Content-Type: multipart/mixed; boundary="msP4r1Mhhxe1bWS1Qwd9CFMwUhtrvOW79";
 protected-headers="v1"
From: =?UTF-8?Q?Kai_Wasserb=c3=a4ch?= <kai-1ZKVMVCtJ2dx9oSEVPI0kiST3g8Odh+X@public.gmane.org>
To: =?UTF-8?Q?Michel_D=c3=a4nzer?= <michel-otUistvHUpPR7s880joybQ@public.gmane.org>
Cc: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Message-ID: <d48e9c96-83fd-de4c-0d70-ade8e6b1bd4f-1ZKVMVCtJ2dx9oSEVPI0kiST3g8Odh+X@public.gmane.org>
Subject: Re: amdgpu: DRI3 with EGL?
References: <c3bc7d1d-37d0-c194-5bf7-535949ef194b-1ZKVMVCtJ2dx9oSEVPI0kiST3g8Odh+X@public.gmane.org>
 <e5ffcce1-4e8f-e00d-82ee-5b95cab2282c-otUistvHUpPR7s880joybQ@public.gmane.org>
In-Reply-To: <e5ffcce1-4e8f-e00d-82ee-5b95cab2282c-otUistvHUpPR7s880joybQ@public.gmane.org>

--msP4r1Mhhxe1bWS1Qwd9CFMwUhtrvOW79
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: quoted-printable

Hey Michel,
Michel D=C3=A4nzer wrote on 16.10.2017 18:05:
> On 16/10/17 05:53 PM, Kai Wasserb=C3=A4ch wrote:
>> [Please CC me on all replies, I'm not subscribed to amd-gfx.]
>>
>> Hey,
>> I'm not sure whether this is a bug or if I'm just missing something. I=
've got
>> the following stack (Debian testing as a base):
>> GPU: Hawaii PRO [Radeon R9 290] (ChipID =3D 0x67b1)
>> Mesa: Git:master/c7a81dcea9
>> libdrm: 2.4.84-2
>> LLVM: SVN:trunk/r315850 (6.0 devel)
>> X.Org: 2:1.19.3-2
>> Linux: 4.13.7
>> Firmware (firmware-amd-graphics): 20170823-1
>> libclc: Git:master/df9db2adca
>> DDX (xserver-xorg-video-amdgpu): 1.4.0-1
>>
>> In my xorg.conf I have (and if I read the manpage correctly, the =C2=BB=
Option "DRI"
>> "3"=C2=AB line shouldn't even be necessary anymore):
>>> Section "Device"
>>>         Identifier      "Forced to amdgpu with DRI3"
>>>         Driver          "amdgpu"
>>>         Option          "DRI"                   "3"
>>> EndSection
>>
>> But when I look at my Xorg.0.log or the output of eglinfo, I see the f=
ollowing
>> lines:
>> - Xorg.0.log:	[    15.305] (II) glamor: EGL version 1.5 (DRI2):
>> - eglinfo:	EGL version string: 1.5 (DRI2)
>>
>> My understanding was, that amdgpu supports DRI3 for quite some time no=
w and
>> therefore would expect to see something like "EGL version string: 1.5 =
(DRI3)".
>>
>> What am I missing?
>=20
> Only that those messages are about a different "DRI2" than the
> alternative to DRI3.

ah, I was not aware of that. What =E2=80=9EDRI=E2=80=9C is meant here the=
n?

> Setting LIBGL_DEBUG=3Dverbose when running a client prints on stderr
> whether it's using DRI3 or DRI2.

Ok, glxgears prints with LIBGL_DEBUG=3Dverbose:
  libGL: Using DRI3 for screen 0

So everything seems fine and I was just confused by the different types o=
f "DRI".

Cheers,
Kai


--msP4r1Mhhxe1bWS1Qwd9CFMwUhtrvOW79--

--WRax4m8l5bhAOa0O1UCJ3e3JGdFChb5bJ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAEBCgAdFiEEBgCWzvPI5zPlthWHownXbOHeWdIFAlnk3HkACgkQownXbOHe
WdLjHAv/aqd2W/gAM3yy7tB+51bKxENDGpgyijIvjJzQ/+kDxNGqDIEsHjqXsQxJ
+b3B7ShiujiHOWAVuIbaVHXTWGLf94ZPx+iuTq7ioG+5PtVmBvXsyF6NptBY7lbE
vjfC46wy0AeogPHhglh/8LctEYEbsDCihOIwplL6yFJhrmHkwGD51OpOASdR+rw+
eff+eyoScdzXWNm7EoQroktPjxOV+jqiZqGHQec4CKbhhA1ES8w+v5c+FQkP5wGD
g7fnGn143lcoKyLYBjWed8Oq8IMU1WzadlHjgEZA+72bCT3VmaDk3dC8Omh2Gx5q
MTzVGEY+Al0EbHE1skf/ZX2Vpape2tIOaaXGwb78Spx1sDOa6O/8PDznIgIdghgc
+1iUVqOj0plXpD2GCuBWs/lQczEXSv3IYAbpCM5gd/LYsywH2AS7jL+P6HKCR5tR
o40ozUUkpDhidN5TMmviNt+TxdqF3SI0/ZRKL/eCWERjC8jPkrQlRkigY7dI8qzC
f1VtBmSL
=tOjL
-----END PGP SIGNATURE-----

--WRax4m8l5bhAOa0O1UCJ3e3JGdFChb5bJ--

--===============0107100307==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============0107100307==--
