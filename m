From: Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: linux-next: Tree for Aug 19 (amdgpu)
Date: Tue, 20 Aug 2019 11:45:54 +1000
Message-ID: <20190820114554.0e522651@canb.auug.org.au>
References: <20190819191832.03f1a579@canb.auug.org.au>
        <ba3cde82-6163-12e5-2e77-36834454113a@infradead.org>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/ST4OoFXdpAP+5=cX8fhr9hW";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <ba3cde82-6163-12e5-2e77-36834454113a@infradead.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Jason Gunthorpe <jgg@mellanox.com>
Cc: Randy Dunlap <rdunlap@infradead.org>, Linux Next Mailing List <linux-next@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, amd-gfx@lists.freedesktop.org, dri-devel <dri-devel@lists.freedesktop.org>
List-Id: amd-gfx.lists.freedesktop.org

--Sig_/ST4OoFXdpAP+5=cX8fhr9hW
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi all,

On Mon, 19 Aug 2019 18:34:41 -0700 Randy Dunlap <rdunlap@infradead.org> wro=
te:
>
> On 8/19/19 2:18 AM, Stephen Rothwell wrote:
> > Hi all,
> >=20
> > Changes since 20190816:
> >  =20
>=20
> on x86_64:
>=20
> ../drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c: In function =E2=80=98amdgpu_e=
xit=E2=80=99:
> ../drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c:1471:2: error: implicit declar=
ation of function =E2=80=98mmu_notifier_synchronize=E2=80=99; did you mean =
=E2=80=98__sync_synchronize=E2=80=99? [-Werror=3Dimplicit-function-declarat=
ion]
>   mmu_notifier_synchronize();
>   ^~~~~~~~~~~~~~~~~~~~~~~~
>   __sync_synchronize
>=20
>=20
> Full randconfig file is attached.

Caused by commit

  6832c9dc8358 ("hmm: use mmu_notifier_get/put for 'struct hmm'")

from the hmm tree.

drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c need to include linux/mmu_notifier.h
--=20
Cheers,
Stephen Rothwell

--Sig_/ST4OoFXdpAP+5=cX8fhr9hW
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAl1bUNIACgkQAVBC80lX
0GxdzAf/dKMAj82tHRTzFb6SoJlnbnbHSbq1KtBSskLed0d9JATgMuYVT21kYmhx
uCbRHbfdCHWJrnNqX8+tjhLpWLoj2csw9XwdUz3mU2t0KHFDJmjuu1uA4QO2+MIi
Lmis+ayt5TNsMd/O40ihMr7k+0fY2EQBIS2VR+KPkPvCSRiAUquEt7OWzAKUSckF
dA5q9F1vO2emerssEYLN3IFlNCVzwj6pPFaoh5S3Mx3dMt9VuWZD0ERVmdfDHpB9
KVsSJ43+zI5lA+MgC0ly3XHz9Iud5TIz6o9Lg4EnpzCbqJKmksUMxN4D0vzW8uB+
9mDrLAJAgyhNcEsfSNG+DcEJspx6cA==
=Xru4
-----END PGP SIGNATURE-----

--Sig_/ST4OoFXdpAP+5=cX8fhr9hW--
