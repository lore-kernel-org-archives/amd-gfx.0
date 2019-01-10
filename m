From: =?UTF-8?Q?Michel_D=c3=a4nzer?= <michel-otUistvHUpPR7s880joybQ@public.gmane.org>
Subject: Re: BISECTED- amd-staging-drm-next, xorg-server segfault A6-6310 APU
 - R4 Mullins.
Date: Thu, 10 Jan 2019 12:25:01 +0100
Message-ID: <70fd7291-8d04-f7f9-b31b-b19e9ba36f12@daenzer.net>
References: <3677766.FRf3LM2rx8@eclipse>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0351798709=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <3677766.FRf3LM2rx8@eclipse>
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
To: soprwa-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Cc: yuzhao-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--===============0351798709==
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="qbwOsB71ORQyhE8s730CvAmZLeHptWKRz"

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--qbwOsB71ORQyhE8s730CvAmZLeHptWKRz
Content-Type: multipart/mixed; boundary="2l7gocMmgZKrly3FX5hdbv4rcfjWmevuN";
 protected-headers="v1"
From: =?UTF-8?Q?Michel_D=c3=a4nzer?= <michel-otUistvHUpPR7s880joybQ@public.gmane.org>
To: soprwa-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Cc: yuzhao-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org
Message-ID: <70fd7291-8d04-f7f9-b31b-b19e9ba36f12-otUistvHUpPR7s880joybQ@public.gmane.org>
Subject: Re: BISECTED- amd-staging-drm-next, xorg-server segfault A6-6310 APU
 - R4 Mullins.
References: <3677766.FRf3LM2rx8@eclipse>
In-Reply-To: <3677766.FRf3LM2rx8@eclipse>

--2l7gocMmgZKrly3FX5hdbv4rcfjWmevuN
Content-Type: text/plain; charset=utf-8
Content-Language: en-CA
Content-Transfer-Encoding: quoted-printable

On 2019-01-10 10:44 a.m., Przemek Socha wrote:
> Hi,
> after yesterday's fetch of amd-staging-drm-next tree from agd5f git rep=
o my=20
> xorg server is segfaulting when starting up.
>=20
> I am using gentoo ~amd64, xorg-server 1.20.3, xf86-video-amdgpu-18.1.0.=
=20
> Machine is an old Lenovo g50-45 netbook with A6-6310 APU - R4 Mullins.
>=20
> - excerpt from Xorg.log:
>=20
> "[    21.878] (II) AMDGPU(0): Setting screen physical size to 700 x 270=

> [    21.880] (EE)=20
> [    21.880] (EE) Backtrace:
> [    21.880] (EE) 0: /usr/bin/X (xorg_backtrace+0x4d) [0x559df051f0bd]
> [    21.880] (EE) 1: /usr/bin/X (0x559df0376000+0x1acc89) [0x559df0522c=
89]
> [    21.880] (EE) 2: /lib64/libpthread.so.0 (0x7f6f2edad000+0x14560)=20
> [0x7f6f2edc1560]
> [    21.880] (EE) 3: /usr/lib64/xorg/modules/drivers/amdgpu_drv.so=20
> (0x7f6f2f32b000+0x14fce) [0x7f6f2f33ffce]
> [    21.880] (EE) 4: /usr/lib64/xorg/modules/drivers/amdgpu_drv.so=20
> (0x7f6f2f32b000+0xd1c4) [0x7f6f2f3381c4]
> [    21.880] (EE) 5: /usr/bin/X (0x559df0376000+0xdf024) [0x559df045502=
4]
> [    21.881] (EE) 6: /usr/bin/X (InitRootWindow+0x11) [0x559df03f8761]
> [    21.881] (EE) 7: /usr/bin/X (0x559df0376000+0x5b574) [0x559df03d157=
4]
> [    21.881] (EE) 8: /lib64/libc.so.6 (__libc_start_main+0xee)=20
> [0x7f6f2ec054ce]
> [    21.881] (EE) 9: /usr/bin/X (_start+0x2a) [0x559df03bb00a]
> [    21.881] (EE)=20
> [    21.881] (EE) Segmentation fault at address 0x4
> [    21.881] (EE)=20
> Fatal server error:
> [    21.881] (EE) Caught signal 11 (Segmentation fault). Server abortin=
g
> [    21.881] (EE)=20
> [    21.881] (EE)=20
> Please consult the The X.Org Foundation support=20
> 	 at http://wiki.x.org
>  for help.=20
> [    21.881] (EE) Please also check the log file at "/var/log/Xorg.0.lo=
g" for=20
> additional information.
> [    21.881] (EE)=20
> [    21.881] (II) AIGLX: Suspending AIGLX clients for VT switch
> [    21.957] (EE) Server terminated with error (1). Closing log file."
>=20
>=20
> I am not sure if I didn't mess up anything, but git bisect gives the re=
sults:
>=20
> [...]
>=20
> 79c6b898011958fba7722528d567b64e1cdc8dbe is the first bad commit
> commit 79c6b898011958fba7722528d567b64e1cdc8dbe
> Author: Yu Zhao <yuzhao-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>
> Date:   Mon Jan 7 15:51:14 2019 -0700
>=20
>     drm/amdgpu: validate user pitch alignment
>    =20
>     Userspace may request pitch alignment that is not supported by GPU.=

>     Some requests 32, but GPU ignores it and uses default 64 when cpp i=
s
>     4. If GEM object is allocated based on the smaller alignment, GPU
>     DMA will go out of bound.
>    =20
>     Cc: stable-u79uwXL29TY76Z2rM5mHXA@public.gmane.org # v4.2+
>     Reviewed-by: Michel D=C3=A4nzer <michel.daenzer-5C7GfCeVMHo@public.gmane.org>
>     Signed-off-by: Yu Zhao <yuzhao-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>
>=20
> :040000 040000 5338964e9975e461ceedb27f6342c2896f54607a=20
> ed2f04fc9b665b27b1905fd60b7d2a3933d1fdcc M      drivers

Thanks for tracking this down. It turns out the check added by this
change is too strict for linear framebuffers. I've sent a patch
reverting it for review: https://patchwork.freedesktop.org/patch/276122/

Sorry I didn't realize this issue when reviewing this change.


--=20
Earthling Michel D=C3=A4nzer               |               http://www.amd=
=2Ecom
Libre software enthusiast             |             Mesa and X developer


--2l7gocMmgZKrly3FX5hdbv4rcfjWmevuN--

--qbwOsB71ORQyhE8s730CvAmZLeHptWKRz
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EARECAB0WIQSwn681vpFFIZgJURRaga+OatuyAAUCXDcrjgAKCRBaga+Oatuy
AJS6AJ0YBqMXirYmIMuJO7xeLX7eVf9uFwCfTfprJro+g4nIRF5Komfn8h+QoUQ=
=VIB1
-----END PGP SIGNATURE-----

--qbwOsB71ORQyhE8s730CvAmZLeHptWKRz--

--===============0351798709==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============0351798709==--
