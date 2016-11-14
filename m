From: =?UTF-8?Q?Michel_D=c3=a4nzer?= <michel-otUistvHUpPR7s880joybQ@public.gmane.org>
Subject: Re: Bug#839381: xserver-xorg-video-amdgpu: very long Xorg
 initilization time in recent kernels
Date: Mon, 14 Nov 2016 10:53:33 +0900
Message-ID: <e2e7bdcf-173f-a94f-eeda-b511fa5552d8@daenzer.net>
References: <147531420383.5700.12068166754566664671.reportbug@debian>
 <e6f090e9-2876-9cc1-131a-bc3ebda7deba@daenzer.net>
 <9e5dee7b-4768-af18-407e-1c1e581a6b03@fs.tum.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1376218939=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <9e5dee7b-4768-af18-407e-1c1e581a6b03-cg1h10c7RbKzQB+pC5nmwQ@public.gmane.org>
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
To: Michael Strobel <strobel-cg1h10c7RbKzQB+pC5nmwQ@public.gmane.org>
Cc: "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, "839381-61a8vm9lEZVf4u+23C9RwQ@public.gmane.org" <839381-61a8vm9lEZVf4u+23C9RwQ@public.gmane.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--===============1376218939==
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="AMbO2ttLNAd76FG5M9WQF2qKKpdoVuR9b"

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--AMbO2ttLNAd76FG5M9WQF2qKKpdoVuR9b
Content-Type: multipart/mixed; boundary="MlLDnI7Bcp19aPFBTe631dU7qrS9aH8e5";
 protected-headers="v1"
From: =?UTF-8?Q?Michel_D=c3=a4nzer?= <michel-otUistvHUpPR7s880joybQ@public.gmane.org>
To: Michael Strobel <strobel-cg1h10c7RbKzQB+pC5nmwQ@public.gmane.org>
Cc: "839381-61a8vm9lEZVf4u+23C9RwQ@public.gmane.org" <839381-61a8vm9lEZVf4u+23C9RwQ@public.gmane.org>,
 "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
Message-ID: <e2e7bdcf-173f-a94f-eeda-b511fa5552d8-otUistvHUpPR7s880joybQ@public.gmane.org>
Subject: Re: Bug#839381: xserver-xorg-video-amdgpu: very long Xorg
 initilization time in recent kernels
References: <147531420383.5700.12068166754566664671.reportbug@debian>
 <e6f090e9-2876-9cc1-131a-bc3ebda7deba-otUistvHUpPR7s880joybQ@public.gmane.org>
 <9e5dee7b-4768-af18-407e-1c1e581a6b03-cg1h10c7RbKzQB+pC5nmwQ@public.gmane.org>
In-Reply-To: <9e5dee7b-4768-af18-407e-1c1e581a6b03-cg1h10c7RbKzQB+pC5nmwQ@public.gmane.org>

--MlLDnI7Bcp19aPFBTe631dU7qrS9aH8e5
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 13/11/16 09:09 PM, Michael Strobel wrote:
> Hi,
>=20
> i think i found the problem: it's powerplay. The bisection showed that
> 3466904d38ff1e63f0a19cb31166db67f2d05c61 is the commit which introduced=

> the problem:
>=20
> while the code before checked if amdgpu_powerplay > 0 now it checks
> equality. The default value is -1 so pp is enabled. I booted with
> amdgpu.powerplay=3D0 and the problem is gone for the testing kernel 4.7=
=2E
>=20
> I tried a more recent kernel (4.9-rc5) and it seemed that it's not
> checked anymore if amdgpu.powerplay equals 0. I'm adding a patch which
> re enables the boot parameter.
>=20
> Furthermore i'm not sure what causes the problem with my GPU in the
> first place. If there is anything i can do please let me know.

Adding the amd-gfx mailing list to Cc.

This bug report should be reassigned to the kernel package.


> On 10/03/2016 04:45 AM, Michel D=C3=A4nzer wrote:
>> On 01/10/16 06:30 PM, Michael Strobel wrote:
>>> Package: xserver-xorg-video-amdgpu
>>> Version: 1.1.2-1
>>> Severity: normal
>>>
>>> Dear Maintainer,
>>>
>>> i'm running debian testing and for quite a while i have problems with=
 my
>>> xserver on newer kernels. While linux-image-4.2.0-1-amd64 works fine =
linux-image-4.6.0-1-amd64 and linux-image-4.7.0-1-amd64 my xserver spends=
 very long time (several minutes) on initialization.=20
>>> The only problem i can spot is a lot of=20
>>>
>>> Failed to send Previous Message.
>>> Failed to send Message.
>>>
>>> messages in dmesg. I'm not complete sure if the problem is even xserv=
er
>>
>> Yeah, unless this doesn't happen with an older version of
>> xserver-xorg-video-amdgpu (and possibly related packages), it sounds
>> like an amdgpu kernel driver regression. Any chance you can bisect or =
at
>> least narrow down which kernel version introduced the problem?
>>
>>
>=20


--=20
Earthling Michel D=C3=A4nzer               |               http://www.amd=
=2Ecom
Libre software enthusiast             |             Mesa and X developer


--MlLDnI7Bcp19aPFBTe631dU7qrS9aH8e5--

--AMbO2ttLNAd76FG5M9WQF2qKKpdoVuR9b
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iFoEARECABoFAlgpGSITHG1pY2hlbEBkYWVuemVyLm5ldAAKCRBaga+OatuyAN1F
AJ9zZdHhefGHDZD+2Gl8L1JfsPt3kwCfVG/s2aRp51dBKyDXQuGuyqlXWq4=
=07Zt
-----END PGP SIGNATURE-----

--AMbO2ttLNAd76FG5M9WQF2qKKpdoVuR9b--

--===============1376218939==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============1376218939==--
