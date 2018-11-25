From: =?UTF-8?Q?Kai_Wasserb=c3=a4ch?= <kai-1ZKVMVCtJ2dx9oSEVPI0kiST3g8Odh+X@public.gmane.org>
Subject: Re: amdgpu: several powerplay errors during boot of HAWAII PRO GPU
Date: Sun, 25 Nov 2018 11:11:31 +0100
Message-ID: <66336f2f-c095-e0da-928f-0c737ab3a8c0@dev.carbon-project.org>
References: <2e515da4-23b0-06b3-0d6f-2ea4ebb71baa@dev.carbon-project.org>
 <CADnq5_OBjT2HbFh8YgiZPamZR1im1ubXxRQ56cJMUAW8E9g9cg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0216732623=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <CADnq5_OBjT2HbFh8YgiZPamZR1im1ubXxRQ56cJMUAW8E9g9cg-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
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
To: amd-gfx list <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
Cc: Alex Deucher <alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--===============0216732623==
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="BcjSwX7oEeklxSAxaZFs9sfEqYHoQIoLB"

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--BcjSwX7oEeklxSAxaZFs9sfEqYHoQIoLB
Content-Type: multipart/mixed; boundary="aH6LzYf5kZKYCLA59Q7FWJH0tmHiwuQUq";
 protected-headers="v1"
From: =?UTF-8?Q?Kai_Wasserb=c3=a4ch?= <kai-1ZKVMVCtJ2dx9oSEVPI0kiST3g8Odh+X@public.gmane.org>
To: amd-gfx list <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
Cc: Alex Deucher <alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Message-ID: <66336f2f-c095-e0da-928f-0c737ab3a8c0-1ZKVMVCtJ2dx9oSEVPI0kiST3g8Odh+X@public.gmane.org>
Subject: Re: amdgpu: several powerplay errors during boot of HAWAII PRO GPU
References: <2e515da4-23b0-06b3-0d6f-2ea4ebb71baa-1ZKVMVCtJ2dx9oSEVPI0kiST3g8Odh+X@public.gmane.org>
 <CADnq5_OBjT2HbFh8YgiZPamZR1im1ubXxRQ56cJMUAW8E9g9cg-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
In-Reply-To: <CADnq5_OBjT2HbFh8YgiZPamZR1im1ubXxRQ56cJMUAW8E9g9cg-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>

--aH6LzYf5kZKYCLA59Q7FWJH0tmHiwuQUq
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: quoted-printable

[Please CC me on replies, I'm not subscribed to amd-gfx.]

Hey Alex,
Alex Deucher wrote on 23.11.18 21:22:
> On Fri, Nov 23, 2018 at 5:28 AM Kai Wasserb=C3=A4ch <kai-1ZKVMVCtJ2cdGMMoKFmSow@public.gmane.org=
ject.org> wrote:
>> with the recent 4.19.x series of kernels I'm seeing several errors bei=
ng logged
>> during boot for my R9 290 (HAWAII PRO) GPU:
>>> [   50.057264] amdgpu: [powerplay] Failed to retrieve minimum clocks.=

>>> [   50.057266] amdgpu: [powerplay] Error in phm_get_clock_info
>>> [   50.057309] [drm] dce110_link_encoder_construct: Failed to get enc=
oder_cap_info from VBIOS with error code 4!
>>> [   50.057316] [drm] dce110_link_encoder_construct: Failed to get enc=
oder_cap_info from VBIOS with error code 4!
>>> [   50.057324] [drm] dce110_link_encoder_construct: Failed to get enc=
oder_cap_info from VBIOS with error code 4!
>=20
> These are harmless.

ok, thanks. Maybe the error messages could be improved to indicate that t=
hey
aren't serious? Something along the lines of "Failed to retrieve minimum =
clocks,
falling back to $foo."?

>>> [   51.611918] amdgpu: [powerplay]
>>>                 failed to send message 282 ret is 254
>=20
> These may be fixed by this patch if you are using an older pcie gen1/2 =
platform:
> https://patchwork.freedesktop.org/patch/259364/

I've applied that patch on top of 4.19.4 but I'm still seeing:
  [   17.407112] amdgpu: [powerplay]
                  failed to send message 282 ret is 254
And as far as I know, I do have PCIe Gen3:
  [   14.992861] [drm] PCIE gen 3 link speeds already enabled

Cheers,
Kai


--aH6LzYf5kZKYCLA59Q7FWJH0tmHiwuQUq--

--BcjSwX7oEeklxSAxaZFs9sfEqYHoQIoLB
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYKAB0WIQQHGGOoanjvCkOaaid97R0LvoA5AgUCW/p1WgAKCRB97R0LvoA5
Anz6AQDH4dVSEJrV5a6b/dNqBBGcRNoZnuSur40L13d7KP/obQD+Iy/uRElxlX7Y
7PUHQwtqyrmcxtwS60KP4T5e9R/H8gQ=
=9j/d
-----END PGP SIGNATURE-----

--BcjSwX7oEeklxSAxaZFs9sfEqYHoQIoLB--

--===============0216732623==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============0216732623==--
