From: =?UTF-8?Q?Michel_D=c3=a4nzer?= <michel-otUistvHUpPR7s880joybQ@public.gmane.org>
Subject: Re: amdgpu: DRI3 with EGL?
Date: Tue, 17 Oct 2017 11:20:14 +0200
Message-ID: <81f4151e-f638-789c-8c7c-a450830a8b79@daenzer.net>
References: <c3bc7d1d-37d0-c194-5bf7-535949ef194b@dev.carbon-project.org>
 <e5ffcce1-4e8f-e00d-82ee-5b95cab2282c@daenzer.net>
 <d48e9c96-83fd-de4c-0d70-ade8e6b1bd4f@dev.carbon-project.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1489603780=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <d48e9c96-83fd-de4c-0d70-ade8e6b1bd4f-1ZKVMVCtJ2dx9oSEVPI0kiST3g8Odh+X@public.gmane.org>
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
To: =?UTF-8?Q?Kai_Wasserb=c3=a4ch?= <kai-1ZKVMVCtJ2dx9oSEVPI0kiST3g8Odh+X@public.gmane.org>
Cc: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--===============1489603780==
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="r5ITs1gb9ogq7cKUgTV0lHnlNHENHUVK6"

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--r5ITs1gb9ogq7cKUgTV0lHnlNHENHUVK6
Content-Type: multipart/mixed; boundary="xFtRshxDoccvNfUcC31te0xgfu4ml4HOb";
 protected-headers="v1"
From: =?UTF-8?Q?Michel_D=c3=a4nzer?= <michel-otUistvHUpPR7s880joybQ@public.gmane.org>
To: =?UTF-8?Q?Kai_Wasserb=c3=a4ch?= <kai-1ZKVMVCtJ2dx9oSEVPI0kiST3g8Odh+X@public.gmane.org>
Cc: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Message-ID: <81f4151e-f638-789c-8c7c-a450830a8b79-otUistvHUpPR7s880joybQ@public.gmane.org>
Subject: Re: amdgpu: DRI3 with EGL?
References: <c3bc7d1d-37d0-c194-5bf7-535949ef194b-1ZKVMVCtJ2dx9oSEVPI0kiST3g8Odh+X@public.gmane.org>
 <e5ffcce1-4e8f-e00d-82ee-5b95cab2282c-otUistvHUpPR7s880joybQ@public.gmane.org>
 <d48e9c96-83fd-de4c-0d70-ade8e6b1bd4f-1ZKVMVCtJ2dx9oSEVPI0kiST3g8Odh+X@public.gmane.org>
In-Reply-To: <d48e9c96-83fd-de4c-0d70-ade8e6b1bd4f-1ZKVMVCtJ2dx9oSEVPI0kiST3g8Odh+X@public.gmane.org>

--xFtRshxDoccvNfUcC31te0xgfu4ml4HOb
Content-Type: text/plain; charset=utf-8
Content-Language: en-CA
Content-Transfer-Encoding: quoted-printable

On 16/10/17 06:21 PM, Kai Wasserb=C3=A4ch wrote:
> Michel D=C3=A4nzer wrote on 16.10.2017 18:05:
>> On 16/10/17 05:53 PM, Kai Wasserb=C3=A4ch wrote:
>>>
>>> Hey,
>>> I'm not sure whether this is a bug or if I'm just missing something. =
I've got
>>> the following stack (Debian testing as a base):
>>> GPU: Hawaii PRO [Radeon R9 290] (ChipID =3D 0x67b1)
>>> Mesa: Git:master/c7a81dcea9
>>> libdrm: 2.4.84-2
>>> LLVM: SVN:trunk/r315850 (6.0 devel)
>>> X.Org: 2:1.19.3-2
>>> Linux: 4.13.7
>>> Firmware (firmware-amd-graphics): 20170823-1
>>> libclc: Git:master/df9db2adca
>>> DDX (xserver-xorg-video-amdgpu): 1.4.0-1
>>>
>>> In my xorg.conf I have (and if I read the manpage correctly, the =C2=BB=
Option "DRI"
>>> "3"=C2=AB line shouldn't even be necessary anymore):
>>>> Section "Device"
>>>>         Identifier      "Forced to amdgpu with DRI3"
>>>>         Driver          "amdgpu"
>>>>         Option          "DRI"                   "3"
>>>> EndSection
>>>
>>> But when I look at my Xorg.0.log or the output of eglinfo, I see the =
following
>>> lines:
>>> - Xorg.0.log:	[    15.305] (II) glamor: EGL version 1.5 (DRI2):
>>> - eglinfo:	EGL version string: 1.5 (DRI2)
>>>
>>> My understanding was, that amdgpu supports DRI3 for quite some time n=
ow and
>>> therefore would expect to see something like "EGL version string: 1.5=
 (DRI3)".
>>>
>>> What am I missing?
>>
>> Only that those messages are about a different "DRI2" than the
>> alternative to DRI3.
>=20
> ah, I was not aware of that. What =E2=80=9EDRI=E2=80=9C is meant here t=
hen?

The API exposed by *_dri.so to the EGL runtime. It's called "DRI2"
because it had to be changed from the original API when DRI2 was
introduced. However, that wasn't necessary for DRI3.


--=20
Earthling Michel D=C3=A4nzer               |               http://www.amd=
=2Ecom
Libre software enthusiast             |             Mesa and X developer


--xFtRshxDoccvNfUcC31te0xgfu4ml4HOb--

--r5ITs1gb9ogq7cKUgTV0lHnlNHENHUVK6
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHEEARECADEWIQSwn681vpFFIZgJURRaga+OatuyAAUCWeXLThMcbWljaGVsQGRh
ZW56ZXIubmV0AAoJEFqBr45q27IAGZIAnA3JJavaIBSu0gSg91BHf5Ro06umAKCH
LLMIthlq3y5Mvm6A7HTY5orjTA==
=FOcG
-----END PGP SIGNATURE-----

--r5ITs1gb9ogq7cKUgTV0lHnlNHENHUVK6--

--===============1489603780==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============1489603780==--
