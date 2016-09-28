From: Edward O'Callaghan <funfunctor-dczkZgxz+BNUPWh3PAxdjQ@public.gmane.org>
Subject: Re: [PATCH 9/9] drm/amdgpu:properly fix some JumpTable issues
Date: Wed, 28 Sep 2016 23:38:25 +1000
Message-ID: <b8241b1a-c7a5-f288-5ca4-52e60bf2349b@folklore1984.net>
References: <1475051780-21634-1-git-send-email-Monk.Liu@amd.com>
 <1475051780-21634-9-git-send-email-Monk.Liu@amd.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0475114204=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <1475051780-21634-9-git-send-email-Monk.Liu-5C7GfCeVMHo@public.gmane.org>
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
To: Monk Liu <Monk.Liu-5C7GfCeVMHo@public.gmane.org>, amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Cc: Frank Min <Frank.Min-5C7GfCeVMHo@public.gmane.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--===============0475114204==
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="0pOChMuxd5RDc26uwMxULX1fvj5N2ENIR"

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--0pOChMuxd5RDc26uwMxULX1fvj5N2ENIR
Content-Type: multipart/mixed; boundary="aOI4da5jaVRBJR92lEnaiJKX7KR0mIls6";
 protected-headers="v1"
From: Edward O'Callaghan <funfunctor-dczkZgxz+BNUPWh3PAxdjQ@public.gmane.org>
To: Monk Liu <Monk.Liu-5C7GfCeVMHo@public.gmane.org>, amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Cc: Frank Min <Frank.Min-5C7GfCeVMHo@public.gmane.org>
Message-ID: <b8241b1a-c7a5-f288-5ca4-52e60bf2349b-dczkZgxz+BNUPWh3PAxdjQ@public.gmane.org>
Subject: Re: [PATCH 9/9] drm/amdgpu:properly fix some JumpTable issues
References: <1475051780-21634-1-git-send-email-Monk.Liu-5C7GfCeVMHo@public.gmane.org>
 <1475051780-21634-9-git-send-email-Monk.Liu-5C7GfCeVMHo@public.gmane.org>
In-Reply-To: <1475051780-21634-9-git-send-email-Monk.Liu-5C7GfCeVMHo@public.gmane.org>

--aOI4da5jaVRBJR92lEnaiJKX7KR0mIls6
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable



On 09/28/2016 06:36 PM, Monk Liu wrote:
> we found some MEC ucode leads to IB test fail or even
> ring test fail if Jump Table of it is not start in
> FW bo with page aligned address, fixed by always make
> JT address page aligned.
>=20
> we don't need to patch JT2 for MEC2, because for VI,
> MEC2 is a copy of MEC1, thus when converting fw_type
> for MEC_JT2 we just return MEC1,hw can use the same
> JT for both MEC1 & MEC2.
>=20
> above two change fixed some ring/ib test failure issue
> for some version of MEC ucode.
>=20
> Change-Id: Ie3b3c4c5722fdf68f64547cdfbf9c0d3274a2a15
> Signed-off-by: Frank Min <Frank.Min-5C7GfCeVMHo@public.gmane.org>
> Signed-off-by: Monk Liu <Monk.Liu-5C7GfCeVMHo@public.gmane.org>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_cgs.c   | 21 ++++++++++++++------
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c | 32 +++++++++++++++++++++++=
++++++++
>  2 files changed, 47 insertions(+), 6 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_cgs.c b/drivers/gpu/drm/=
amd/amdgpu/amdgpu_cgs.c
> index cb1ade1..7278898 100755
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cgs.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cgs.c
> @@ -685,11 +685,14 @@ static uint32_t fw_type_convert(struct cgs_device=
 *cgs_device, uint32_t fw_type)
>  		result =3D AMDGPU_UCODE_ID_CP_MEC1;
>  		break;
>  	case CGS_UCODE_ID_CP_MEC_JT2:
> -		if (adev->asic_type =3D=3D CHIP_TONGA || adev->asic_type =3D=3D CHIP=
_POLARIS11
> -		  || adev->asic_type =3D=3D CHIP_POLARIS10)
> -			result =3D AMDGPU_UCODE_ID_CP_MEC2;
> -		else
> +		/* for VI. JT2 should be the same as JT1, because:
> +			1, MEC2 and MEC1 use exactly same FW.
> +			2, JT2 is not pached but JT1 is.
> +		*/
> +		if (adev->asic_type >=3D CHIP_TOPAZ)
>  			result =3D AMDGPU_UCODE_ID_CP_MEC1;
> +		else
> +			result =3D AMDGPU_UCODE_ID_CP_MEC2;
>  		break;
>  	case CGS_UCODE_ID_RLC_G:
>  		result =3D AMDGPU_UCODE_ID_RLC_G;
> @@ -779,12 +782,18 @@ static int amdgpu_cgs_get_firmware_info(struct cg=
s_device *cgs_device,
> =20
>  		if ((type =3D=3D CGS_UCODE_ID_CP_MEC_JT1) ||
>  		    (type =3D=3D CGS_UCODE_ID_CP_MEC_JT2)) {
> -			gpu_addr +=3D le32_to_cpu(header->jt_offset) << 2;
> +			gpu_addr +=3D ALIGN(le32_to_cpu(header->header.ucode_size_bytes), P=
AGE_SIZE);
>  			data_size =3D le32_to_cpu(header->jt_size) << 2;
>  		}
> -		info->mc_addr =3D gpu_addr;
> +
> +		info->kptr =3D ucode->kaddr;
>  		info->image_size =3D data_size;
> +		info->mc_addr =3D gpu_addr;
>  		info->version =3D (uint16_t)le32_to_cpu(header->header.ucode_version=
);
> +
> +		if (CGS_UCODE_ID_CP_MEC =3D=3D type)
> +			info->image_size =3D (header->jt_offset) << 2;
> +
>  		info->fw_version =3D amdgpu_get_firmware_version(cgs_device, type);
>  		info->feature_version =3D (uint16_t)le32_to_cpu(header->ucode_featur=
e_version);
>  	} else {
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c b/drivers/gpu/dr=
m/amd/amdgpu/amdgpu_ucode.c
> index 06baac9..e2ea2c9 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c
> @@ -239,6 +239,31 @@ static int amdgpu_ucode_init_single_fw(struct amdg=
pu_firmware_info *ucode,
>  	return 0;
>  }
> =20
> +static int amdgpu_ucode_patch_jt(struct amdgpu_firmware_info *ucode,
> +				uint64_t mc_addr, void *kptr)
> +{
> +	const struct gfx_firmware_header_v1_0 *header =3D NULL;
> +	const struct common_firmware_header *comm_hdr =3D NULL;
> +	uint8_t* src_addr =3D NULL;
> +	uint8_t* dst_addr =3D NULL;
> +
> +	if (NULL =3D=3D ucode->fw)
Can be simplified to just:
+	if (!ucode->fw)

> +		return 0;
Do you really want to return 0 here? In fact, at the moment the return
value isn't used nor is it currently useful. Maybe just drop it.

> +
> +	comm_hdr =3D (const struct common_firmware_header *)ucode->fw->data;
> +	header =3D (const struct gfx_firmware_header_v1_0 *)ucode->fw->data;
> +	dst_addr =3D ucode->kaddr +
> +			   ALIGN(le32_to_cpu(comm_hdr->ucode_size_bytes),
> +			   PAGE_SIZE);
> +	src_addr =3D (uint8_t *)ucode->fw->data +
> +			   le32_to_cpu(comm_hdr->ucode_array_offset_bytes) +
> +			   (le32_to_cpu(header->jt_offset) * 4);
> +	memcpy(dst_addr, src_addr, le32_to_cpu(header->jt_size) * 4);
> +
> +	return 0;
> +}
> +
> +
>  int amdgpu_ucode_init_bo(struct amdgpu_device *adev)
>  {
>  	struct amdgpu_bo **bo =3D &adev->firmware.fw_buf;
> @@ -285,6 +310,13 @@ int amdgpu_ucode_init_bo(struct amdgpu_device *ade=
v)
>  			header =3D (const struct common_firmware_header *)ucode->fw->data;
>  			amdgpu_ucode_init_single_fw(ucode, fw_mc_addr + fw_offset,
>  						    fw_buf_ptr + fw_offset);
> +			if (i =3D=3D AMDGPU_UCODE_ID_CP_MEC1) {
> +				const struct gfx_firmware_header_v1_0 *cp_hdr;
> +				cp_hdr =3D (const struct gfx_firmware_header_v1_0 *)ucode->fw->dat=
a;
> +				amdgpu_ucode_patch_jt(ucode, fw_mc_addr + fw_offset,
> +						    fw_buf_ptr + fw_offset);
> +				fw_offset +=3D ALIGN(le32_to_cpu(cp_hdr->jt_size) << 2, PAGE_SIZE)=
;
> +			}
>  			fw_offset +=3D ALIGN(le32_to_cpu(header->ucode_size_bytes), PAGE_SI=
ZE);
>  		}
>  	}
>=20


--aOI4da5jaVRBJR92lEnaiJKX7KR0mIls6--

--0pOChMuxd5RDc26uwMxULX1fvj5N2ENIR
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJX68fRAAoJEP4bvbfZuWjbPngQAIoQSPiA1hz3en3PWRr+WB+Q
8WoRmhZNHTad/vGOGfip5gBoFxq9s1nnxevcfnRE1c72UeRhpNo57Yc+L4YuWBn5
SOxCyqGq99BxlUJtvzthNFK2zSiw2Z0jhDk9sXl9dAFlilTI2U5ufe6PXiwExYSt
XD6YOpD3qnOBwrHiPlt9uR3hJOrTQR0SvqcoSLXEop59kE1Fp8aJWLOWCWlgDpHY
blm/IFBprq/n2bUffRcpAziyR2tBR8EXNUhUm51MMSoD+tXXqm47odXk3zkNU1IF
E1lXJ0DCOg9X6qZh86D/ia9yI51V6QycknyxUqW74kLhWR4uDukEC5ZQvrryv+b2
W/krFysAhtjygFUEieg43GctxvCJKDmqEsHtqZ7k6N4yGTV4e05okECyXKu9/4GZ
8B+HAIjvblhWNgaX6LnMUOCPihWjx2hG7DxPQxB3POwK3XvcgR9pcMN/N+oOVqE3
Bnk1EBhzFHaQv8OEfx/0Xl3rWEv16Kfs5TkCbAPvgU3exul68n1aHC+Ov9IhFzFo
PAdQ8Hy89wpArTM3tTKFGWIuHIkXHc5/GitIm6jun3YxJAGxHdi/NbWbFrB0uiWF
xXdp8buKQWAxs2FsE4KSKfcVgPb2AFEf1jkIvivFHcvEV8w2E1zIvda0TbT8k62W
8yuBnmYNmdsAPs9B/5TU
=bddt
-----END PGP SIGNATURE-----

--0pOChMuxd5RDc26uwMxULX1fvj5N2ENIR--

--===============0475114204==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============0475114204==--
