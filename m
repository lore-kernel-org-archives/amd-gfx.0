From: Edward O'Callaghan <funfunctor-dczkZgxz+BNUPWh3PAxdjQ@public.gmane.org>
Subject: Re: [PATCH 1/3] drm/amd/amdgpu: Add debugfs support for reading GPRs
Date: Tue, 6 Dec 2016 06:59:34 +1100
Message-ID: <9c9c13e7-f02d-73c0-1f3c-09cea022d195@folklore1984.net>
References: <20161205183652.29325-1-tom.stdenis@amd.com>
 <20161205183652.29325-2-tom.stdenis@amd.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1937533988=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <20161205183652.29325-2-tom.stdenis-5C7GfCeVMHo@public.gmane.org>
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
To: Tom St Denis <tstdenis82-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Cc: Tom St Denis <tom.stdenis-5C7GfCeVMHo@public.gmane.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--===============1937533988==
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="uL2LvPuAGuOsqNvH9fPVeipUwgpgrCvTe"

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--uL2LvPuAGuOsqNvH9fPVeipUwgpgrCvTe
Content-Type: multipart/mixed; boundary="e9cBUOrWf68xfuc24H7lBMu0bJthqF73p";
 protected-headers="v1"
From: Edward O'Callaghan <funfunctor-dczkZgxz+BNUPWh3PAxdjQ@public.gmane.org>
To: Tom St Denis <tstdenis82-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Cc: Tom St Denis <tom.stdenis-5C7GfCeVMHo@public.gmane.org>
Message-ID: <9c9c13e7-f02d-73c0-1f3c-09cea022d195-dczkZgxz+BNUPWh3PAxdjQ@public.gmane.org>
Subject: Re: [PATCH 1/3] drm/amd/amdgpu: Add debugfs support for reading GPRs
References: <20161205183652.29325-1-tom.stdenis-5C7GfCeVMHo@public.gmane.org>
 <20161205183652.29325-2-tom.stdenis-5C7GfCeVMHo@public.gmane.org>
In-Reply-To: <20161205183652.29325-2-tom.stdenis-5C7GfCeVMHo@public.gmane.org>

--e9cBUOrWf68xfuc24H7lBMu0bJthqF73p
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi Tom,

On 12/06/2016 05:36 AM, Tom St Denis wrote:
> Implemented for SGPRs for GFX v8 initially.
>=20
> Signed-off-by: Tom St Denis <tom.stdenis-5C7GfCeVMHo@public.gmane.org>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu.h        |  2 +
>  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 72 ++++++++++++++++++++++=
++++++++
>  drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c      | 25 +++++++++++
>  3 files changed, 99 insertions(+)
>=20
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/=
amdgpu/amdgpu.h
> index 4f64bb16a8d3..2834451eef8a 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> @@ -844,6 +844,8 @@ struct amdgpu_gfx_funcs {
>  	uint64_t (*get_gpu_clock_counter)(struct amdgpu_device *adev);
>  	void (*select_se_sh)(struct amdgpu_device *adev, u32 se_num, u32 sh_n=
um, u32 instance);
>  	void (*read_wave_data)(struct amdgpu_device *adev, uint32_t simd, uin=
t32_t wave, uint32_t *dst, int *no_fields);
> +	void (*read_wave_vgprs)(struct amdgpu_device *adev, uint32_t simd, ui=
nt32_t wave, uint32_t thread, uint32_t start, uint32_t size, uint32_t *ds=
t);
> +	void (*read_wave_sgprs)(struct amdgpu_device *adev, uint32_t simd, ui=
nt32_t wave, uint32_t start, uint32_t size, uint32_t *dst);
>  };
> =20
>  struct amdgpu_gfx {
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/d=
rm/amd/amdgpu/amdgpu_device.c
> index 25ad736b5ca5..7f9cb1c85d75 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -3055,6 +3055,71 @@ static ssize_t amdgpu_debugfs_wave_read(struct f=
ile *f, char __user *buf,
>  	return result;
>  }
> =20
> +static ssize_t amdgpu_debugfs_gpr_read(struct file *f, char __user *bu=
f,
> +					size_t size, loff_t *pos)
> +{
> +	struct amdgpu_device *adev =3D f->f_inode->i_private;

Could f potentially be null here?

> +	int r;
> +	ssize_t result=3D0;

result =3D 0

> +	uint32_t offset, se, sh, cu, wave, simd, thread, bank, *data;
> +
> +	if (size & 3 || *pos & 3)
> +		return -EINVAL;
> +
> +	/* decode offset */
> +	offset =3D (*pos & 0xFFF);
> +	se =3D ((*pos >> 12) & 0xFF);
> +	sh =3D ((*pos >> 20) & 0xFF);
> +	cu =3D ((*pos >> 28) & 0xFF);
> +	wave =3D ((*pos >> 36) & 0xFF);
> +	simd =3D ((*pos >> 44) & 0xFF);
> +	thread =3D ((*pos >> 52) & 0xFF);
> +	bank =3D ((*pos >> 60) & 1);
> +
> +	/* sanity check offset/size */
> +	if (offset + size > (adev->gfx.config.max_gprs << 2))
> +		return -EINVAL;
> +
> +	data =3D kmalloc_array(1024, sizeof(*data), GFP_KERNEL);
> +	if (!data)
> +		return -ENOMEM;
> +
> +	/* switch to the specific se/sh/cu */
> +	mutex_lock(&adev->grbm_idx_mutex);
> +	amdgpu_gfx_select_se_sh(adev, se, sh, cu);
> +
> +	if (bank =3D=3D 0) {
> +		if (adev->gfx.funcs->read_wave_vgprs)
> +			adev->gfx.funcs->read_wave_vgprs(adev, simd, wave, thread, offset>>=
2, size>>2, data);
> +	} else {
> +		if (adev->gfx.funcs->read_wave_sgprs)
> +			adev->gfx.funcs->read_wave_sgprs(adev, simd, wave, offset>>2, size>=
>2, data);
> +	}
> +
> +	amdgpu_gfx_select_se_sh(adev, 0xFFFFFFFF, 0xFFFFFFFF, 0xFFFFFFFF);
> +	mutex_unlock(&adev->grbm_idx_mutex);
> +
> +	while (size) {
> +		uint32_t value;
> +
> +		value =3D data[offset >> 2];
> +		r =3D put_user(value, (uint32_t *)buf);
> +		if (r) {
> +			result =3D r;
> +			goto err;
> +		}
> +
> +		result +=3D 4;
> +		buf +=3D 4;
> +		offset +=3D 4;
> +		size -=3D 4;
> +	}
> +
> +err:
> +	kfree(data);
> +	return result;
> +}
> +
>  static const struct file_operations amdgpu_debugfs_regs_fops =3D {
>  	.owner =3D THIS_MODULE,
>  	.read =3D amdgpu_debugfs_regs_read,
> @@ -3097,6 +3162,11 @@ static const struct file_operations amdgpu_debug=
fs_wave_fops =3D {
>  	.read =3D amdgpu_debugfs_wave_read,
>  	.llseek =3D default_llseek
>  };
> +static const struct file_operations amdgpu_debugfs_gpr_fops =3D {
> +	.owner =3D THIS_MODULE,
> +	.read =3D amdgpu_debugfs_gpr_read,
> +	.llseek =3D default_llseek
> +};
> =20
>  static const struct file_operations *debugfs_regs[] =3D {
>  	&amdgpu_debugfs_regs_fops,
> @@ -3106,6 +3176,7 @@ static const struct file_operations *debugfs_regs=
[] =3D {
>  	&amdgpu_debugfs_gca_config_fops,
>  	&amdgpu_debugfs_sensors_fops,
>  	&amdgpu_debugfs_wave_fops,
> +	&amdgpu_debugfs_gpr_fops,
>  };
> =20
>  static const char *debugfs_regs_names[] =3D {
> @@ -3116,6 +3187,7 @@ static const char *debugfs_regs_names[] =3D {
>  	"amdgpu_gca_config",
>  	"amdgpu_sensors",
>  	"amdgpu_wave",
> +	"amdgpu_gpr",
>  };
> =20
>  static int amdgpu_debugfs_regs_init(struct amdgpu_device *adev)
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c b/drivers/gpu/drm/am=
d/amdgpu/gfx_v8_0.c
> index 9b8d3fe67adb..180309f5784c 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
> @@ -5184,6 +5184,21 @@ static uint32_t wave_read_ind(struct amdgpu_devi=
ce *adev, uint32_t simd, uint32_
>  	return RREG32(mmSQ_IND_DATA);
>  }
> =20
> +static void wave_read_regs(struct amdgpu_device *adev, uint32_t simd,
> +			   uint32_t wave, uint32_t thread,
> +			   uint32_t regno, uint32_t num, uint32_t *out)
> +{
> +	WREG32(mmSQ_IND_INDEX,
> +		(wave << SQ_IND_INDEX__WAVE_ID__SHIFT) |
> +		(simd << SQ_IND_INDEX__SIMD_ID__SHIFT) |
> +		(regno << SQ_IND_INDEX__INDEX__SHIFT) |
> +		(thread << SQ_IND_INDEX__THREAD_ID__SHIFT) |
> +		(SQ_IND_INDEX__FORCE_READ_MASK) |
> +		(SQ_IND_INDEX__AUTO_INCR_MASK));
> +	while (num--)
> +		*(out++) =3D RREG32(mmSQ_IND_DATA);
> +}
> +
>  static void gfx_v8_0_read_wave_data(struct amdgpu_device *adev, uint32=
_t simd, uint32_t wave, uint32_t *dst, int *no_fields)
>  {
>  	/* type 0 wave data */
> @@ -5208,11 +5223,21 @@ static void gfx_v8_0_read_wave_data(struct amdg=
pu_device *adev, uint32_t simd, u
>  	dst[(*no_fields)++] =3D wave_read_ind(adev, simd, wave, ixSQ_WAVE_M0)=
;
>  }
> =20
> +static void gfx_v8_0_read_wave_sgprs(struct amdgpu_device *adev, uint3=
2_t simd,
> +				     uint32_t wave, uint32_t start,
> +				     uint32_t size, uint32_t *dst)
> +{
> +	wave_read_regs(
> +		adev, simd, wave, 0,
> +		start + SQIND_WAVE_SGPRS_OFFSET, size, dst);
> +}
> +
> =20
>  static const struct amdgpu_gfx_funcs gfx_v8_0_gfx_funcs =3D {
>  	.get_gpu_clock_counter =3D &gfx_v8_0_get_gpu_clock_counter,
>  	.select_se_sh =3D &gfx_v8_0_select_se_sh,
>  	.read_wave_data =3D &gfx_v8_0_read_wave_data,
> +	.read_wave_sgprs =3D &gfx_v8_0_read_wave_sgprs,

Just fyi, these & are actually redundant when it comes to func ptr's.

>  };
> =20
>  static int gfx_v8_0_early_init(void *handle)
>=20

Kind Regards,
Edward.


--e9cBUOrWf68xfuc24H7lBMu0bJthqF73p--

--uL2LvPuAGuOsqNvH9fPVeipUwgpgrCvTe
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJYRccmAAoJEP4bvbfZuWjbPDAP/RzzbAYsQ6vT5coXY2E38riO
Iut5wYYy/WEoRcxQE7YJkcbwhL6WFTYHSd5oL8J8hNhwZ8wYbeFmGM8O/N+kRT6s
nKkVzpQHXxoOl+llPikbNBag6wJt/36URLWlcg9wPM4hMajYP9f/18pQRUbyHeHJ
gKe84YlYqd/3+dd10B8tpmu6qP1XUxz5McfqGotwnY5iy9AxmHHpSqv2gRohzUT8
3wEAzhriuaP+FRwAWlXGCN9UTVZB5pZN2djcYs+AIinaWeEBbM9G70J+u6Qp4syd
voXOan/Upy4PAmaGIPbR4lL82IHt3HLK2Us28wVp/+3zxinVF20JEPo26GabEXTc
zgb4LGOPxvzNff+Ejie/eKNvH7jrdtRSgybS0GfQHdBe8ICPaR10h0mE0PBoOyyW
AO9lEuCbzbKBHJ1JGvAoUfRgL9w042qyZ1ahNA8lgFGbN1FgbotRqkCxOJHazw60
pf0xYWzjo2114NiVIxrh2AeJm+11ihhIy1sztbjZzb6X90KYmMQ2v0l0yv4tu0cA
mecpKi5AEays9izKm8A3OiiE3L4PrBej3PGsStyRlNj9cNCsgyUopc20NcuBouV7
9oKF/ywhS0GFDmC0ziP+C5cxZA1WM81hd9m0elcpfUu5Frtnr3Dg71GWSO3JYX2N
kz+i5hozF/IWUmgV+BJm
=T9Pw
-----END PGP SIGNATURE-----

--uL2LvPuAGuOsqNvH9fPVeipUwgpgrCvTe--

--===============1937533988==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============1937533988==--
