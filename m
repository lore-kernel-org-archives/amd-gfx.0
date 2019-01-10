From: Przemek Socha <soprwa-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: BISECTED- amd-staging-drm-next,
 xorg-server segfault A6-6310 APU - R4 Mullins.
Date: Thu, 10 Jan 2019 17:06:26 +0100
Message-ID: <91019770.5DcfmtkFX1@eclipse>
References: <3677766.FRf3LM2rx8@eclipse>
 <70fd7291-8d04-f7f9-b31b-b19e9ba36f12@daenzer.net>
Reply-To: soprwa-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0997398222=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <70fd7291-8d04-f7f9-b31b-b19e9ba36f12-otUistvHUpPR7s880joybQ@public.gmane.org>
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
To: Michel =?ISO-8859-1?Q?D=E4nzer?= <michel-otUistvHUpPR7s880joybQ@public.gmane.org>, amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Cc: yuzhao-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org

--===============0997398222==
Content-Type: multipart/signed; boundary="nextPart2276955.uQxvYIE7G1"; micalg="pgp-sha256"; protocol="application/pgp-signature"

--nextPart2276955.uQxvYIE7G1
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"

Dnia czwartek, 10 stycznia 2019 12:25:01 CET piszesz:
> On 2019-01-10 10:44 a.m., Przemek Socha wrote:
> > Hi,
> > after yesterday's fetch of amd-staging-drm-next tree from agd5f git repo
> > my
> > xorg server is segfaulting when starting up.
> >=20
> > I am using gentoo ~amd64, xorg-server 1.20.3, xf86-video-amdgpu-18.1.0.
> > Machine is an old Lenovo g50-45 netbook with A6-6310 APU - R4 Mullins.
> >=20
> > - excerpt from Xorg.log:
> >=20
> > "[    21.878] (II) AMDGPU(0): Setting screen physical size to 700 x 270
> > [    21.880] (EE)
> > [    21.880] (EE) Backtrace:
> > [    21.880] (EE) 0: /usr/bin/X (xorg_backtrace+0x4d) [0x559df051f0bd]
> > [    21.880] (EE) 1: /usr/bin/X (0x559df0376000+0x1acc89) [0x559df0522c=
89]
> > [    21.880] (EE) 2: /lib64/libpthread.so.0 (0x7f6f2edad000+0x14560)
> > [0x7f6f2edc1560]
> > [    21.880] (EE) 3: /usr/lib64/xorg/modules/drivers/amdgpu_drv.so
> > (0x7f6f2f32b000+0x14fce) [0x7f6f2f33ffce]
> > [    21.880] (EE) 4: /usr/lib64/xorg/modules/drivers/amdgpu_drv.so
> > (0x7f6f2f32b000+0xd1c4) [0x7f6f2f3381c4]
> > [    21.880] (EE) 5: /usr/bin/X (0x559df0376000+0xdf024) [0x559df045502=
4]
> > [    21.881] (EE) 6: /usr/bin/X (InitRootWindow+0x11) [0x559df03f8761]
> > [    21.881] (EE) 7: /usr/bin/X (0x559df0376000+0x5b574) [0x559df03d157=
4]
> > [    21.881] (EE) 8: /lib64/libc.so.6 (__libc_start_main+0xee)
> > [0x7f6f2ec054ce]
> > [    21.881] (EE) 9: /usr/bin/X (_start+0x2a) [0x559df03bb00a]
> > [    21.881] (EE)
> > [    21.881] (EE) Segmentation fault at address 0x4
> > [    21.881] (EE)
> > Fatal server error:
> > [    21.881] (EE) Caught signal 11 (Segmentation fault). Server aborting
> > [    21.881] (EE)
> > [    21.881] (EE)
> > Please consult the The X.Org Foundation support
> >=20
> > 	 at http://wiki.x.org
> > =20
> >  for help.
> >=20
> > [    21.881] (EE) Please also check the log file at "/var/log/Xorg.0.lo=
g"
> > for additional information.
> > [    21.881] (EE)
> > [    21.881] (II) AIGLX: Suspending AIGLX clients for VT switch
> > [    21.957] (EE) Server terminated with error (1). Closing log file."
> >=20
> >=20
> > I am not sure if I didn't mess up anything, but git bisect gives the
> > results:
> >=20
> > [...]
> >=20
> > 79c6b898011958fba7722528d567b64e1cdc8dbe is the first bad commit
> > commit 79c6b898011958fba7722528d567b64e1cdc8dbe
> > Author: Yu Zhao <yuzhao-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>
> > Date:   Mon Jan 7 15:51:14 2019 -0700
> >=20
> >     drm/amdgpu: validate user pitch alignment
> >    =20
> >     Userspace may request pitch alignment that is not supported by GPU.
> >     Some requests 32, but GPU ignores it and uses default 64 when cpp is
> >     4. If GEM object is allocated based on the smaller alignment, GPU
> >     DMA will go out of bound.
> >    =20
> >     Cc: stable-u79uwXL29TY76Z2rM5mHXA@public.gmane.org # v4.2+
> >     Reviewed-by: Michel D=C3=A4nzer <michel.daenzer-5C7GfCeVMHo@public.gmane.org>
> >     Signed-off-by: Yu Zhao <yuzhao-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>
> > :
> > :040000 040000 5338964e9975e461ceedb27f6342c2896f54607a
> >=20
> > ed2f04fc9b665b27b1905fd60b7d2a3933d1fdcc M      drivers
>=20
> Thanks for tracking this down. It turns out the check added by this
> change is too strict for linear framebuffers. I've sent a patch
> reverting it for review: https://patchwork.freedesktop.org/patch/276122/
>=20
> Sorry I didn't realize this issue when reviewing this change.

Thanks for the swift response and sorry about the delay on my side.

Unfortunately applying this patch does not help in my case (but could be=20
necessarily after all).=20

To start xorg-server I had to apply your patch, and, on top of this, revers=
e=20
the  "drm/amdgpu: validate user pitch alignment" -=20
79c6b898011958fba7722528d567b64e1cdc8dbe.

Now xorg server starts, but I have doubt about system stability because=20
description of reverted one is saying that "if GEM object is allocated base=
d=20
on the smaller alignment, GPU
DMA will go out of bound".=20
Sorry about being a layman on this.

Thanks,
Przemek.
--nextPart2276955.uQxvYIE7G1
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEE2zcce+zboy/je1pmPMstj1lsVJMFAlw3bYIACgkQPMstj1ls
VJPr6Q//QDOQR8CC3MhW2gvvk73M6csEUMcc7NK07wwrdZZOfA52dSPks8MPAcf1
tkGSIhelynUiKwBRwSFWt3+K3gM3yNhy1rDOkbLmLkarNjAWs6Jn75A2r9AgH4zp
3vtXk+QsqKHFUkJfghTszupf636F6Oe5f9j1bKRdH8a7aRhs3jnW18gaskK+q15A
NNOMhgDFqYGWfWdFBkWo5bUkZRsD5bjQi+MHhOyQJcbrGffAuecKbATcgH49KuMe
DuBxIGnJwTl+ldzsJuURQGaxoqqoKQORioJY9czPSNBmMSOO63uMikqonjhfb8mc
KlAP3WHXatUWYG2MRkKmLu3MvThrkQF9aAgfBjYESy3VSC5waOr7vvMr9R/nLxtA
5jkvIe6Zmt4kHHf2xrtoACJJEGWtEK6CfvQFtx1WPQs7IrHgdz0shOKjMyTOlFN8
ICxfTpvlFUj3g48dG+FrgoLVTDQMH6vE8POEGDXuo7w0usAyfX87QutU6DYItq+5
78isB/36uKeKjTMeCTriSeviYgiO/NwCwZYH62HPNu/3XNVuXRISIUU/VPIx/h1K
cbfrVpRaaHzOoPdYoTg44JqLajWPCKy+0s9MsbWcZ/mtnhPpMTsNZUsWR+r34AQg
gD51SUIEjVEcoaUyd/is/3v8EXeTgj021ZHosnQOLScyH4SRO0M=
=8XCV
-----END PGP SIGNATURE-----

--nextPart2276955.uQxvYIE7G1--




--===============0997398222==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============0997398222==--
