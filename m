From: Edward O'Callaghan <funfunctor-dczkZgxz+BNUPWh3PAxdjQ@public.gmane.org>
Subject: Re: [PATCH 1/2] drm/amd/amdgpu: stored bios_size
Date: Thu, 8 Dec 2016 10:46:56 +1100
Message-ID: <a72df745-760e-21df-6ad9-dc7815e1808c@folklore1984.net>
References: <1481138544-32505-1-git-send-email-alexander.deucher@amd.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1823379678=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <1481138544-32505-1-git-send-email-alexander.deucher-5C7GfCeVMHo@public.gmane.org>
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
Cc: Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org>, Evan Quan <evan.quan-5C7GfCeVMHo@public.gmane.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--===============1823379678==
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="d27l42KlvrTXxOv5FjWQCiGCaMw5uBKxw"

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--d27l42KlvrTXxOv5FjWQCiGCaMw5uBKxw
Content-Type: multipart/mixed; boundary="2xj0xCrUMPKOQUo3fe4NVNWRjL1J1j8J0";
 protected-headers="v1"
From: Edward O'Callaghan <funfunctor-dczkZgxz+BNUPWh3PAxdjQ@public.gmane.org>
To: Alex Deucher <alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Cc: Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org>, Evan Quan <evan.quan-5C7GfCeVMHo@public.gmane.org>
Message-ID: <a72df745-760e-21df-6ad9-dc7815e1808c-dczkZgxz+BNUPWh3PAxdjQ@public.gmane.org>
Subject: Re: [PATCH 1/2] drm/amd/amdgpu: stored bios_size
References: <1481138544-32505-1-git-send-email-alexander.deucher-5C7GfCeVMHo@public.gmane.org>
In-Reply-To: <1481138544-32505-1-git-send-email-alexander.deucher-5C7GfCeVMHo@public.gmane.org>

--2xj0xCrUMPKOQUo3fe4NVNWRjL1J1j8J0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

1&2 are Reviewed-by: Edward O'Callaghan <funfunctor-dczkZgxz+BNUPWh3PAxdjQ@public.gmane.org>

On 12/08/2016 06:22 AM, Alex Deucher wrote:
> From: Evan Quan <evan.quan-5C7GfCeVMHo@public.gmane.org>
>=20
> It's necessary if we want to export vbios image out.
>=20
> Signed-off-by: Evan Quan <evan.quan-5C7GfCeVMHo@public.gmane.org>
> Reviewed-by: Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org>
> Reviewed-by: Christian Koenig <christian.koenig-5C7GfCeVMHo@public.gmane.org>
> Signed-off-by: Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu.h      | 1 +
>  drivers/gpu/drm/amd/amdgpu/amdgpu_bios.c | 6 ++++++
>  2 files changed, 7 insertions(+)
>=20
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/=
amdgpu/amdgpu.h
> index 29d3a91..f31936b 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> @@ -1330,6 +1330,7 @@ struct amdgpu_device {
> =20
>  	/* BIOS */
>  	uint8_t				*bios;
> +	uint32_t			bios_size;
>  	bool				is_atom_bios;
>  	struct amdgpu_bo		*stollen_vga_memory;
>  	uint32_t			bios_scratch[AMDGPU_BIOS_NUM_SCRATCH];
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_bios.c b/drivers/gpu/drm=
/amd/amdgpu/amdgpu_bios.c
> index b7e2762..4f973a9 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_bios.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_bios.c
> @@ -74,6 +74,7 @@ static bool igp_read_bios_from_vram(struct amdgpu_dev=
ice *adev)
>  		iounmap(bios);
>  		return false;
>  	}
> +	adev->bios_size =3D size;
>  	memcpy_fromio(adev->bios, bios, size);
>  	iounmap(bios);
>  	return true;
> @@ -103,6 +104,7 @@ bool amdgpu_read_bios(struct amdgpu_device *adev)
>  		pci_unmap_rom(adev->pdev, bios);
>  		return false;
>  	}
> +	adev->bios_size =3D size;
>  	memcpy_fromio(adev->bios, bios, size);
>  	pci_unmap_rom(adev->pdev, bios);
>  	return true;
> @@ -135,6 +137,7 @@ static bool amdgpu_read_bios_from_rom(struct amdgpu=
_device *adev)
>  		DRM_ERROR("no memory to allocate for BIOS\n");
>  		return false;
>  	}
> +	adev->bios_size =3D len;
> =20
>  	/* read complete BIOS */
>  	return amdgpu_asic_read_bios_from_rom(adev, adev->bios, len);
> @@ -159,6 +162,7 @@ static bool amdgpu_read_platform_bios(struct amdgpu=
_device *adev)
>  	if (adev->bios =3D=3D NULL) {
>  		return false;
>  	}
> +	adev->bios_size =3D size;
> =20
>  	return true;
>  }
> @@ -273,6 +277,7 @@ static bool amdgpu_atrm_get_bios(struct amdgpu_devi=
ce *adev)
>  		kfree(adev->bios);
>  		return false;
>  	}
> +	adev->bios_size =3D size;
>  	return true;
>  }
>  #else
> @@ -334,6 +339,7 @@ static bool amdgpu_acpi_vfct_bios(struct amdgpu_dev=
ice *adev)
>  	}
> =20
>  	adev->bios =3D kmemdup(&vbios->VbiosContent, vhdr->ImageLength, GFP_K=
ERNEL);
> +	adev->bios_size =3D vhdr->ImageLength;
>  	ret =3D !!adev->bios;
> =20
>  out_unmap:
>=20


--2xj0xCrUMPKOQUo3fe4NVNWRjL1J1j8J0--

--d27l42KlvrTXxOv5FjWQCiGCaMw5uBKxw
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJYSJ9wAAoJEP4bvbfZuWjb0dMQAJAFqFnaM+lgTkJptffOuSEO
wIi0lYdBgUOt4kNtYL80s4wVnRKznwIzn1dFYH9UBNMmqM0Or/DJqDLMlIYcDZyO
XukOooPb+z/5RLCpisLBWQbNd6WdNFCiqYuMTW1Zp7FXXqZwEKElRpgC3+oqBwE2
FlGVS6V0HC0SG9bVQgQ9OGFL0oNUDIReRcGJpeyZplgvsvma0p/BQ2xZP7Ve9eBF
9DqCwkpUvkI5W/RAdh1stQmANrV5wl/a8/hUhwjweEjptae2/3H3L1cBAZ3aRXdl
yMfN7M4LV0GV7V9rPc5y28l6suZCIQigNw8sh09m+hVcWudtOMf9H+H+w+nQi2O1
fU/gstjHL54EPeqb1rUzF18Y9TfZ4hfz1iXixF8+7JjJbVPzLGWABE22IlTPIVru
pqe/InEgKVQ5B8amJdiJOMDC1uoN+Erh7z/ZMY6xEAV0O3u+/uEbM4gTTL3ZGqT0
VNToHca5kzjCEvEacGSgDljLgpscDUtXGkBmQYLOEMin35OfBQnPo8mRBBWQ56J7
arCMbKUCD5pui/qHwu3R0A74zUPH9VnjrpckMr3nsdPmoa28B0asrGenoKIrOk1E
aDEa94UGQ3HlbeCg/s/7RUEGkXkj+lLtcX9kdez8t5CwdLCdWu2YUivbcqbVX5NA
iyXjqUUCBgOXvd4rkvS+
=tk7H
-----END PGP SIGNATURE-----

--d27l42KlvrTXxOv5FjWQCiGCaMw5uBKxw--

--===============1823379678==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============1823379678==--
