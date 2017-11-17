From: Jan Vesely <jan.vesely-kgbqMDwikbSVc3sceRu5cw@public.gmane.org>
Subject: Re: [PATCH 1/2] drm/amdgpu:fix virtual dce bug
Date: Fri, 17 Nov 2017 01:00:47 -0500
Message-ID: <1510898447.8297.3.camel@rutgers.edu>
References: <1510802063-20869-1-git-send-email-Monk.Liu@amd.com>
 <1510850414.3218.161.camel@rutgers.edu>
 <BLUPR12MB04498F5AE2FF155F75D61BF3842F0@BLUPR12MB0449.namprd12.prod.outlook.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0753676533=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <BLUPR12MB04498F5AE2FF155F75D61BF3842F0-7LeqcoF/hwpTIQvHjXdJlwdYzm3356FpvxpqHgZTriW3zl9H0oFU5g@public.gmane.org>
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
To: "Liu, Monk" <Monk.Liu-5C7GfCeVMHo@public.gmane.org>, "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>


--===============0753676533==
Content-Type: multipart/signed; micalg="pgp-sha256";
	protocol="application/pgp-signature"; boundary="=-qYkejilF6c8grECzgpCU"


--=-qYkejilF6c8grECzgpCU
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, 2017-11-17 at 04:26 +0000, Liu, Monk wrote:
> I think it's already clear enough=20

nice. what a friendly response. good job!

"fix a bug" is definitely not descriptive of the change, and the commit
message does not even parse as a sentence.


Jan

>=20
> -----Original Message-----
> From: Jan Vesely [mailto:jv356-nChP9VK/LToysehGhLVACCmkPJUwDNjP@public.gmane.org] On Behalf Of Jan =
Vesely
> Sent: 2017=E5=B9=B411=E6=9C=8817=E6=97=A5 0:40
> To: Liu, Monk <Monk.Liu-5C7GfCeVMHo@public.gmane.org>; amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
> Subject: Re: [PATCH 1/2] drm/amdgpu:fix virtual dce bug
>=20
> On Thu, 2017-11-16 at 11:14 +0800, Monk Liu wrote:
> > this fix the issue that access memory after freed after driver=20
> > unloaded.
>=20
> can you please change the patch subject and commit message to something m=
ore descriptive?
>=20
> Jan
>=20
> >=20
> > Change-Id: I64e2488c18f5dc044b57c74567785da21fc028da
> > Signed-off-by: Monk Liu <Monk.Liu-5C7GfCeVMHo@public.gmane.org>
> > ---
> >  drivers/gpu/drm/amd/amdgpu/dce_virtual.c | 4 +++-
> >  1 file changed, 3 insertions(+), 1 deletion(-)
> >=20
> > diff --git a/drivers/gpu/drm/amd/amdgpu/dce_virtual.c=20
> > b/drivers/gpu/drm/amd/amdgpu/dce_virtual.c
> > index a8829af..39460eb 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/dce_virtual.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/dce_virtual.c
> > @@ -437,6 +437,8 @@ static int dce_virtual_sw_fini(void *handle)
> >  	drm_kms_helper_poll_fini(adev->ddev);
> > =20
> >  	drm_mode_config_cleanup(adev->ddev);
> > +	/* clear crtcs pointer to avoid dce irq finish routine access freed d=
ata */
> > +	memset(adev->mode_info.crtcs, 0, sizeof(adev->mode_info.crtcs[0]) *=
=20
> > +AMDGPU_MAX_CRTCS);
> >  	adev->mode_info.mode_config_initialized =3D false;
> >  	return 0;
> >  }
> > @@ -723,7 +725,7 @@ static void dce_virtual_set_crtc_vblank_interrupt_s=
tate(struct amdgpu_device *ad
> >  							int crtc,
> >  							enum amdgpu_interrupt_state state)  {
> > -	if (crtc >=3D adev->mode_info.num_crtc) {
> > +	if (crtc >=3D adev->mode_info.num_crtc ||=20
> > +!adev->mode_info.crtcs[crtc]) {
> >  		DRM_DEBUG("invalid crtc %d\n", crtc);
> >  		return;
> >  	}

--=20
Jan Vesely <jan.vesely-kgbqMDwikbSVc3sceRu5cw@public.gmane.org>
--=-qYkejilF6c8grECzgpCU
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEjGgSoFJq63cCYGKvY+M/tz9IsiAFAloOexEACgkQY+M/tz9I
siConw//ck1d1P9kOPWFV6yFWt++mlbGmUuDePilFfAYrKuLnJuOPKG3faMnvHhW
bjEAYQGe1OEiM+4h4knoKxGsAAep8s/syh0EVOtOAc+PDkO+Eg8+Kinhz/kbQlKH
EqzKyOH/SFzIugLml8tHdBTSZduYPbMJI0y8ZrKyjWdfH5Fhh0uqtph3VgpHfnSa
N48aLCPdeYEoL24QxuPoIURIJl+RpJKXNa2P1HsPMSOczEx1ZKK1WJVY21DCLw8d
em0zFaeobUkU2P21BmFFdxhG7h8cDYyv28bWlSW9IKFFSU1olQL4LFyOcWUnoiO3
8nAfz2a8CJgi9Bn2/iHv6Q8iF49aIB15bdcFKU3ApRTDZ5L85WtOU4I5GhbQzAsu
2h1MYDZQdssSuQTddD8NvNtHuJc2sk4rQk5m+c6LkdfQXHSeU7hfzgeMeJA3l3iz
QVGhRlGwFZb6xjhT4C1UFAfls70S0q5b+p/cXo3vS6kBMtLDGpTnPwuBdh7gz4Dd
DXNHCd6VTCyk9tUyLtVHNwD6Qt5AnDOaYZRqDg2Hw8SgQp3dJHMCEWsf5Sj/VUfK
FhCIBO90hIeoh1EJqmO548beN0gUai5lgue3tX4sIRxbPrCwkDJfBTvgsRG6iRYq
LE41TnuDkkJMvrY0DJKIXN48ta5dV+PHfrxbJZva/RoQPMzJuEw=
=ZsOE
-----END PGP SIGNATURE-----

--=-qYkejilF6c8grECzgpCU--


--===============0753676533==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============0753676533==--
