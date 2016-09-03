From: Edward O'Callaghan <funfunctor-dczkZgxz+BNUPWh3PAxdjQ@public.gmane.org>
Subject: Re: [PATCH 2/4] radeonkfd/amdkfd: Implement get_local_mem_info()
Date: Sat, 3 Sep 2016 14:57:23 +1000
Message-ID: <bbc26c07-7cb8-90a5-0aa6-d2c8688f54e0@folklore1984.net>
References: <1472870947-11300-1-git-send-email-funfunctor@folklore1984.net>
 <1472870947-11300-3-git-send-email-funfunctor@folklore1984.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0267147783=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <1472870947-11300-3-git-send-email-funfunctor-dczkZgxz+BNUPWh3PAxdjQ@public.gmane.org>
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
To: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--===============0267147783==
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="6sJLtBv9gWAVaqkM9wNE3h7P6di7btwuX"

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--6sJLtBv9gWAVaqkM9wNE3h7P6di7btwuX
Content-Type: multipart/mixed; boundary="nHVbVIjOjk426XjLpFSuaFN6guvxQoeir";
 protected-headers="v1"
From: Edward O'Callaghan <funfunctor-dczkZgxz+BNUPWh3PAxdjQ@public.gmane.org>
To: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Message-ID: <bbc26c07-7cb8-90a5-0aa6-d2c8688f54e0-dczkZgxz+BNUPWh3PAxdjQ@public.gmane.org>
Subject: Re: [PATCH 2/4] radeonkfd/amdkfd: Implement get_local_mem_info()
References: <1472870947-11300-1-git-send-email-funfunctor-dczkZgxz+BNUPWh3PAxdjQ@public.gmane.org>
 <1472870947-11300-3-git-send-email-funfunctor-dczkZgxz+BNUPWh3PAxdjQ@public.gmane.org>
In-Reply-To: <1472870947-11300-3-git-send-email-funfunctor-dczkZgxz+BNUPWh3PAxdjQ@public.gmane.org>

--nHVbVIjOjk426XjLpFSuaFN6guvxQoeir
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable



On 09/03/2016 12:49 PM, Edward O'Callaghan wrote:
> Signed-off-by: Edward O'Callaghan <funfunctor-dczkZgxz+BNUPWh3PAxdjQ@public.gmane.org>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c        | 32 +++++++++++++++=
+++++---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h        |  3 ++-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v7.c |  2 +-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v8.c |  2 +-
>  drivers/gpu/drm/amd/amdkfd/kfd_topology.c         |  6 ++++-
>  drivers/gpu/drm/amd/include/kgd_kfd_interface.h   | 13 +++++++--
>  drivers/gpu/drm/radeon/radeon_kfd.c               | 22 +++++++++++++--=
-
>  7 files changed, 66 insertions(+), 14 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c b/drivers/gpu/d=
rm/amd/amdgpu/amdgpu_amdkfd.c
> index d080d08..63a2e84 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
> @@ -226,14 +226,38 @@ void free_gtt_mem(struct kgd_dev *kgd, void *mem_=
obj)
>  	kfree(mem);
>  }
> =20
> -uint64_t get_vmem_size(struct kgd_dev *kgd)
> +void get_local_mem_info(struct kgd_dev *kgd,
> +				struct kfd_local_mem_info *mem_info)
>  {
> -	struct amdgpu_device *rdev =3D
> -		(struct amdgpu_device *)kgd;
> +	struct amdgpu_device *rdev =3D (struct amdgpu_device *)kgd;
> +	uint64_t address_mask;
> +	resource_size_t aper_limit;
> =20
>  	BUG_ON(kgd =3D=3D NULL);
> =20
> -	return rdev->mc.real_vram_size;
> +	memset(mem_info, 0, sizeof(*mem_info));
> +
> +	address_mask =3D ~((1UL << 40) - 1);
> +	aper_limit =3D rdev->mc.aper_base + rdev->mc.aper_size;
> +
> +	if (!(rdev->mc.aper_base & address_mask ||
> +			aper_limit & address_mask)) {
> +		mem_info->local_mem_size_public =3D rdev->mc.visible_vram_size;
> +		mem_info->local_mem_size_private =3D rdev->mc.real_vram_size -
> +				rdev->mc.visible_vram_size;
> +	} else {
> +		mem_info->local_mem_size_public =3D 0;
> +		mem_info->local_mem_size_private =3D rdev->mc.real_vram_size;
> +	}
> +	mem_info->vram_width =3D rdev->mc.vram_width;
> +
> +	if (amdgpu_powerplay || rdev->pm.funcs->get_mclk)
> +		mem_info->mem_clk_max =3D amdgpu_dpm_get_mclk(rdev, false) / 100;
> +
> +	pr_debug("amdgpu: address base: 0x%llx limit 0x%llx public 0x%llx pri=
vate 0x%llx\n",
> +			rdev->mc.aper_base, aper_limit,
> +			mem_info->local_mem_size_public,
> +			mem_info->local_mem_size_private);
>  }
> =20
>  uint64_t get_gpu_clock_counter(struct kgd_dev *kgd)
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h b/drivers/gpu/d=
rm/amd/amdgpu/amdgpu_amdkfd.h
> index de530f68d..31da026 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
> @@ -57,7 +57,8 @@ int alloc_gtt_mem(struct kgd_dev *kgd, size_t size,
>  			void **mem_obj, uint64_t *gpu_addr,
>  			void **cpu_ptr);
>  void free_gtt_mem(struct kgd_dev *kgd, void *mem_obj);
> -uint64_t get_vmem_size(struct kgd_dev *kgd);
> +void get_local_mem_info(struct kgd_dev *kgd,
> +			struct kfd_local_mem_info *mem_info);
>  uint64_t get_gpu_clock_counter(struct kgd_dev *kgd);
> =20
>  uint32_t get_max_engine_clock_in_mhz(struct kgd_dev *kgd);
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v7.c b/driver=
s/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v7.c
> index 362bedc..dc69cf7 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v7.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v7.c
> @@ -131,7 +131,7 @@ static uint16_t get_fw_version(struct kgd_dev *kgd,=
 enum kgd_engine_type type);
>  static const struct kfd2kgd_calls kfd2kgd =3D {
>  	.init_gtt_mem_allocation =3D alloc_gtt_mem,
>  	.free_gtt_mem =3D free_gtt_mem,
> -	.get_vmem_size =3D get_vmem_size,
> +	.get_local_mem_info =3D get_local_mem_info,
>  	.get_gpu_clock_counter =3D get_gpu_clock_counter,
>  	.get_max_engine_clock_in_mhz =3D get_max_engine_clock_in_mhz,
>  	.program_sh_mem_settings =3D kgd_program_sh_mem_settings,
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v8.c b/driver=
s/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v8.c
> index 04b744d..342a037 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v8.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v8.c
> @@ -90,7 +90,7 @@ static uint16_t get_fw_version(struct kgd_dev *kgd, e=
num kgd_engine_type type);
>  static const struct kfd2kgd_calls kfd2kgd =3D {
>  	.init_gtt_mem_allocation =3D alloc_gtt_mem,
>  	.free_gtt_mem =3D free_gtt_mem,
> -	.get_vmem_size =3D get_vmem_size,
> +	.get_local_mem_info =3D get_local_mem_info,
>  	.get_gpu_clock_counter =3D get_gpu_clock_counter,
>  	.get_max_engine_clock_in_mhz =3D get_max_engine_clock_in_mhz,
>  	.program_sh_mem_settings =3D kgd_program_sh_mem_settings,
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c b/drivers/gpu/dr=
m/amd/amdkfd/kfd_topology.c
> index 1e50647..6ea7bd8 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
> @@ -1088,6 +1088,7 @@ static void kfd_debug_print_topology(void)
> =20
>  static uint32_t kfd_generate_gpu_id(struct kfd_dev *gpu)
>  {
> +	struct kfd_local_mem_info local_mem_info;
>  	uint32_t hashout;
>  	uint32_t buf[7];
>  	uint64_t local_mem_size;
> @@ -1096,7 +1097,10 @@ static uint32_t kfd_generate_gpu_id(struct kfd_d=
ev *gpu)
>  	if (!gpu)
>  		return 0;
> =20
> -	local_mem_size =3D gpu->kfd2kgd->get_vmem_size(gpu->kgd);
> +	gpu->kfd2kgd->get_local_mem_info(gpu->kgd, &local_mem_info);
> +
> +	local_mem_size =3D local_mem_info.local_mem_size_private +
> +			 local_mem_info.local_mem_size_public;
> =20
>  	buf[0] =3D gpu->pdev->devfn;
>  	buf[1] =3D gpu->pdev->subsystem_vendor;
> diff --git a/drivers/gpu/drm/amd/include/kgd_kfd_interface.h b/drivers/=
gpu/drm/amd/include/kgd_kfd_interface.h
> index a09d9f3..14ec3e4 100644
> --- a/drivers/gpu/drm/amd/include/kgd_kfd_interface.h
> +++ b/drivers/gpu/drm/amd/include/kgd_kfd_interface.h
> @@ -39,6 +39,14 @@ struct kgd_dev;
> =20
>  struct kgd_mem;
> =20
> +/* For getting GPU local memory information from KGD */
> +struct kfd_local_mem_info {
> +	uint64_t local_mem_size_private;
> +	uint64_t local_mem_size_public;
> +	uint32_t vram_width;
> +	uint32_t mem_clk_max;
> +};
> +
>  enum kgd_memory_pool {
>  	KGD_POOL_SYSTEM_CACHEABLE =3D 1,
>  	KGD_POOL_SYSTEM_WRITECOMBINE =3D 2,
> @@ -85,7 +93,7 @@ struct kgd2kfd_shared_resources {
>   *
>   * @free_gtt_mem: Frees a buffer that was allocated on the gart apertu=
re
>   *
> - * @get_vmem_size: Retrieves (physical) size of VRAM
> + * @get_local_mem_info: Retrieves information about GPU local memory
>   *
>   * @get_gpu_clock_counter: Retrieves GPU clock counter
>   *
> @@ -129,7 +137,8 @@ struct kfd2kgd_calls {
> =20
>  	void (*free_gtt_mem)(struct kgd_dev *kgd, void *mem_obj);
> =20
> -	uint64_t (*get_vmem_size)(struct kgd_dev *kgd);
> +	void(*get_local_mem_info)(struct kgd_dev *kgd,
> +			struct kfd_local_mem_info *mem_info);
>  	uint64_t (*get_gpu_clock_counter)(struct kgd_dev *kgd);
> =20
>  	uint32_t (*get_max_engine_clock_in_mhz)(struct kgd_dev *kgd);
> diff --git a/drivers/gpu/drm/radeon/radeon_kfd.c b/drivers/gpu/drm/rade=
on/radeon_kfd.c
> index 87a9ebb..5495362 100644
> --- a/drivers/gpu/drm/radeon/radeon_kfd.c
> +++ b/drivers/gpu/drm/radeon/radeon_kfd.c
> @@ -54,7 +54,8 @@ static int alloc_gtt_mem(struct kgd_dev *kgd, size_t =
size,
> =20
>  static void free_gtt_mem(struct kgd_dev *kgd, void *mem_obj);
> =20
> -static uint64_t get_vmem_size(struct kgd_dev *kgd);
> +static void get_local_mem_info(struct kgd_dev *kgd,
> +				struct kfd_local_mem_info *mem_info);
>  static uint64_t get_gpu_clock_counter(struct kgd_dev *kgd);
> =20
>  static uint32_t get_max_engine_clock_in_mhz(struct kgd_dev *kgd);
> @@ -107,7 +108,7 @@ static void write_vmid_invalidate_request(struct kg=
d_dev *kgd, uint8_t vmid);
>  static const struct kfd2kgd_calls kfd2kgd =3D {
>  	.init_gtt_mem_allocation =3D alloc_gtt_mem,
>  	.free_gtt_mem =3D free_gtt_mem,
> -	.get_vmem_size =3D get_vmem_size,
> +	.get_local_mem_info =3D get_local_mem_info,
>  	.get_gpu_clock_counter =3D get_gpu_clock_counter,
>  	.get_max_engine_clock_in_mhz =3D get_max_engine_clock_in_mhz,
>  	.program_sh_mem_settings =3D kgd_program_sh_mem_settings,
> @@ -301,13 +302,26 @@ static void free_gtt_mem(struct kgd_dev *kgd, voi=
d *mem_obj)
>  	kfree(mem);
>  }
> =20
> -static uint64_t get_vmem_size(struct kgd_dev *kgd)
> +static void get_local_mem_info(struct kgd_dev *kgd,
> +				struct kfd_local_mem_info *mem_info)
>  {
>  	struct radeon_device *rdev =3D (struct radeon_device *)kgd;
> =20
>  	BUG_ON(kgd =3D=3D NULL);
> =20
> -	return rdev->mc.real_vram_size;
> +	memset(mem_info, 0, sizeof(*mem_info));
> +
> +	mem_info->local_mem_size_public =3D rdev->mc.visible_vram_size;
> +	mem_info->local_mem_size_private =3D rdev->mc.real_vram_size -
> +					   rdev->mc.visible_vram_size;
> +
> +	mem_info->vram_width =3D rdev->mc.vram_width;
> +	mem_info->mem_clk_max =3D radeon_dpm_get_mclk(rdev, false);
> +
> +	pr_debug("radeon: address base: 0x%llx limit 0x%llx public 0x%llx pri=
vate 0x%llx\n",
> +			rdev->mc.aper_base, aper_limit,
> +			mem_info->local_mem_size_public,
> +			mem_info->local_mem_size_private);

woops ! ignore this patch, I have a fixed up version locally. Will
resent once the others are looked at with some additional patches also.

Sorry for the noise.
Kind Regards,
Edward.

>  }
> =20
>  static uint64_t get_gpu_clock_counter(struct kgd_dev *kgd)
>=20


--nHVbVIjOjk426XjLpFSuaFN6guvxQoeir--

--6sJLtBv9gWAVaqkM9wNE3h7P6di7btwuX
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJXylg3AAoJEP4bvbfZuWjbdh8QANwVKP6k17ZQg31FhTO/zEy3
ZBaUohrzHl9Utk9viMrnu5kjMk9Mzc4yl9dX4N92NCais4f4oLZezqZuq4I6uR6q
JcMtW5zca8Zg5ha3an7/xU4TMcfWdMBHHIJGHqbOssILbx7reFDplar9tbaXSCEw
zuHCh/3rf85Ynn99x1GOUI7HDqRTx3vv3BPipPNHUAA8A6p0leLJDAMgWI84lN/V
np9laafoLQFE5rOm1VKqc9dja51Ml4gUI7tt3LIiD6HiICksyBxLEMocLM0z6/nU
96Qn+WYFF1P1n5Floiv79GltECUEvtyXaPVFKHUAfpHGMYoMm5ma7kZ9aexccMOu
AspdLzdcOKfnc/hALKXdODqDZeJ8Q6fda1lm6BS3sxNMm6FlVKAWSLwk0Q8KFyfc
2rl4rbk7R5iUkK9X2SxZBAokXGpShMtd+jR0WJc0o+2XjWkI7IKXXoW74SfUeGz6
943k14FrVu3CGfX/GuyjPK4L1/8S0yaX7yBjEyyQ1kVp+bCWSZN6sEEM9bTFT0lf
OQMq3jOu5p0GsFqTmpe9ETOGmnKTl2PvXS+QDQea5n82hrVx1o0YNIOCDPzM7vdA
ogfcvVyaseu+NlACrJLB9GvQZGAX5QrEK0XL/nztGDYiTlOojeGpf5rx6vKhUE6G
PGJ9FRoWfw4CV4hzaVIN
=YMUN
-----END PGP SIGNATURE-----

--6sJLtBv9gWAVaqkM9wNE3h7P6di7btwuX--

--===============0267147783==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============0267147783==--
