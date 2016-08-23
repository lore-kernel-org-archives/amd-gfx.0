From: Edward O'Callaghan <funfunctor-dczkZgxz+BNUPWh3PAxdjQ@public.gmane.org>
Subject: Re: [PATCH 1/2] drm/amdgpu: wire up a pci shutdown callback
Date: Tue, 23 Aug 2016 11:27:28 +1000
Message-ID: <7f908eb2-7519-2e0e-99bd-ef8ea4b30a60@folklore1984.net>
References: <1471890641-4759-1-git-send-email-alexander.deucher@amd.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1162573726=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <1471890641-4759-1-git-send-email-alexander.deucher-5C7GfCeVMHo@public.gmane.org>
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
To: Alex Deucher <alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Cc: Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--===============1162573726==
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="Rtqdd7FxS8HXab2kh33rq4PslLfsCJII6"

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--Rtqdd7FxS8HXab2kh33rq4PslLfsCJII6
Content-Type: multipart/mixed; boundary="3lNp2iF6MwVqgabewwfrhkRH5fT89GrLJ"
From: Edward O'Callaghan <funfunctor-dczkZgxz+BNUPWh3PAxdjQ@public.gmane.org>
To: Alex Deucher <alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Cc: Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org>
Message-ID: <7f908eb2-7519-2e0e-99bd-ef8ea4b30a60-dczkZgxz+BNUPWh3PAxdjQ@public.gmane.org>
Subject: Re: [PATCH 1/2] drm/amdgpu: wire up a pci shutdown callback
References: <1471890641-4759-1-git-send-email-alexander.deucher-5C7GfCeVMHo@public.gmane.org>
In-Reply-To: <1471890641-4759-1-git-send-email-alexander.deucher-5C7GfCeVMHo@public.gmane.org>

--3lNp2iF6MwVqgabewwfrhkRH5fT89GrLJ
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

This series is,

Reviewed-by: Edward O'Callaghan <funfunctor-dczkZgxz+BNUPWh3PAxdjQ@public.gmane.org>

On 08/23/2016 04:30 AM, Alex Deucher wrote:
> Normally on shutdown or reboot we don't care about necessarily
> making sure the hw is in a good state because the system is about
> to be powered down or reset.  However, after a shutdown or reboot
> in a VM, it's best to tear down the hw properly otherwise there
> can be problems with the next VM use.
>=20
> Signed-off-by: Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
>=20
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/=
amd/amdgpu/amdgpu_drv.c
> index 5c7a77b..0da4336 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> @@ -392,6 +392,19 @@ amdgpu_pci_remove(struct pci_dev *pdev)
>  	drm_put_dev(dev);
>  }
> =20
> +static void
> +amdgpu_pci_shutdown(struct pci_dev *pdev)
> +{
> +	struct drm_device *dev =3D pci_get_drvdata(pdev);
> +	struct amdgpu_device *adev =3D dev->dev_private;
> +
> +	/* if we are running in a VM, make sure the device
> +	 * torn down properly on reboot/shutdown
> +	 */
> +	if (adev->virtualization.is_virtual)
> +		amdgpu_pci_remove(pdev);
> +}
> +
>  static int amdgpu_pmops_suspend(struct device *dev)
>  {
>  	struct pci_dev *pdev =3D to_pci_dev(dev);
> @@ -605,6 +618,7 @@ static struct pci_driver amdgpu_kms_pci_driver =3D =
{
>  	.id_table =3D pciidlist,
>  	.probe =3D amdgpu_pci_probe,
>  	.remove =3D amdgpu_pci_remove,
> +	.shutdown =3D amdgpu_pci_shutdown,
>  	.driver.pm =3D &amdgpu_pm_ops,
>  };
> =20
>=20


--3lNp2iF6MwVqgabewwfrhkRH5fT89GrLJ--

--Rtqdd7FxS8HXab2kh33rq4PslLfsCJII6
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJXu6aAAAoJEP4bvbfZuWjbOjgQAMkgyPPoS2tiE7TwCfDEI6O1
burEJPUZC1Wg9YPyPrysTUGcvfJl4fVinQZMHuzsXgVc/9IO8v/IEoR78PkRPuFZ
ZBCzIh+DsWt+uTkQ3JxH28AJecgMJjHzq72+6E1qs7ZQp1eydNPGpsCls+ROasab
/eOLHDohjJWeCmPSIZ0ajUlinbR6dp9BaH5zwA4+pGsTNPAhOqZIGP38e3GKOi7a
FGo9vjEzlsImnXQKzvvMv9T1TfZ1mRyjSc0AewKHs5HIJviIDHYLCQsVCDeqpO32
3c0RdNdS1d1KyJnWEf2+JVAvstj7noYIM2+MM88AFI4D3Bj5u3INtdJvU1rS3OrD
OS5vgtRzTF3qDtfJJgoI4LjsvR8eCmfvO96wczVwqHNxDEokG15glDrGfyxRo6Rl
pQzdtoTRpBfbyIkynWbJyOJPqJgYrbMcSh6Z67RaYy7IcLe+HtGcaub4lKcybVAs
9goe8XoFSXF38cssKnR5V2Qkm8z1Q0OY8GabJNIsV4PYUkux9aIWz9Y/QS1Hj4R4
SXE8e0jshK0DT+FpwHTJPcHhUcjgAd+HCchHfL3i22ej8tSfVicDPOu5N3vTakqZ
pc0d7t65kyQUY1f6nS5JeX7lYOm6rKNdFuF2NtAgUkcqoE+7/VG9szhV2F6eq1YX
IdJTD4Nu+X40mEe3i35B
=Gp0O
-----END PGP SIGNATURE-----

--Rtqdd7FxS8HXab2kh33rq4PslLfsCJII6--

--===============1162573726==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============1162573726==--
