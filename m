From: =?UTF-8?B?TWFyZWsgT2zFocOhaw==?= <maraeo-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH] drm/amdgpu: remove static GDS, GWS and OA allocation
Date: Fri, 10 May 2019 21:05:55 -0400
Message-ID: <CAAxE2A6VWW=+=sXXSmFgWkrUS+ZosPYhxjxf8h82FQy1vEP9Cg@mail.gmail.com>
References: <20190510175759.78078-1-christian.koenig@amd.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2021758559=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <20190510175759.78078-1-christian.koenig-5C7GfCeVMHo@public.gmane.org>
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
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Oak.Zeng-5C7GfCeVMHo@public.gmane.org, amd-gfx mailing list <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, Felix Kuehling <Felix.Kuehling-5C7GfCeVMHo@public.gmane.org>, Sean.Keely-5C7GfCeVMHo@public.gmane.org

--===============2021758559==
Content-Type: multipart/alternative; boundary="00000000000046bd700588924b68"

--00000000000046bd700588924b68
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Reviewed-by: Marek Ol=C5=A1=C3=A1k <marek.olsak-5C7GfCeVMHo@public.gmane.org>

Marek

On Fri, May 10, 2019 at 1:58 PM Christian K=C3=B6nig <
ckoenig.leichtzumerken-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:

> As far as we know this was never used by userspace and so should be
> removed.
>
> Signed-off-by: Christian K=C3=B6nig <christian.koenig-5C7GfCeVMHo@public.gmane.org>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_bo_list.c |  6 ++--
>  drivers/gpu/drm/amd/amdgpu/amdgpu_gds.h     | 21 ++---------
>  drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c     | 11 +++---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c     | 24 ++-----------
>  drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c       | 32 +++--------------
>  drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c       | 32 +++--------------
>  drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c       | 39 ++++-----------------
>  7 files changed, 28 insertions(+), 137 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_bo_list.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_bo_list.c
> index 5c79da8e1150..d497467b7fc6 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_bo_list.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_bo_list.c
> @@ -81,9 +81,9 @@ int amdgpu_bo_list_create(struct amdgpu_device *adev,
> struct drm_file *filp,
>                 return -ENOMEM;
>
>         kref_init(&list->refcount);
> -       list->gds_obj =3D adev->gds.gds_gfx_bo;
> -       list->gws_obj =3D adev->gds.gws_gfx_bo;
> -       list->oa_obj =3D adev->gds.oa_gfx_bo;
> +       list->gds_obj =3D NULL;
> +       list->gws_obj =3D NULL;
> +       list->oa_obj =3D NULL;
>
>         array =3D amdgpu_bo_list_array_entry(list, 0);
>         memset(array, 0, num_entries * sizeof(struct
> amdgpu_bo_list_entry));
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gds.h
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_gds.h
> index f89f5734d985..dad2186f4ed5 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gds.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gds.h
> @@ -27,26 +27,11 @@
>  struct amdgpu_ring;
>  struct amdgpu_bo;
>
> -struct amdgpu_gds_asic_info {
> -       uint32_t        total_size;
> -       uint32_t        gfx_partition_size;
> -       uint32_t        cs_partition_size;
> -};
> -
>  struct amdgpu_gds {
> -       struct amdgpu_gds_asic_info     mem;
> -       struct amdgpu_gds_asic_info     gws;
> -       struct amdgpu_gds_asic_info     oa;
> +       uint32_t gds_size;
> +       uint32_t gws_size;
> +       uint32_t oa_size;
>         uint32_t                        gds_compute_max_wave_id;
> -
> -       /* At present, GDS, GWS and OA resources for gfx (graphics)
> -        * is always pre-allocated and available for graphics operation.
> -        * Such resource is shared between all gfx clients.
> -        * TODO: move this operation to user space
> -        * */
> -       struct amdgpu_bo*               gds_gfx_bo;
> -       struct amdgpu_bo*               gws_gfx_bo;
> -       struct amdgpu_bo*               oa_gfx_bo;
>  };
>
>  struct amdgpu_gds_reg_offset {
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> index da7b4fe8ade3..87a93874d71e 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> @@ -590,13 +590,10 @@ static int amdgpu_info_ioctl(struct drm_device *dev=
,
> void *data, struct drm_file
>                 struct drm_amdgpu_info_gds gds_info;
>
>                 memset(&gds_info, 0, sizeof(gds_info));
> -               gds_info.gds_gfx_partition_size =3D
> adev->gds.mem.gfx_partition_size;
> -               gds_info.compute_partition_size =3D
> adev->gds.mem.cs_partition_size;
> -               gds_info.gds_total_size =3D adev->gds.mem.total_size;
> -               gds_info.gws_per_gfx_partition =3D
> adev->gds.gws.gfx_partition_size;
> -               gds_info.gws_per_compute_partition =3D
> adev->gds.gws.cs_partition_size;
> -               gds_info.oa_per_gfx_partition =3D
> adev->gds.oa.gfx_partition_size;
> -               gds_info.oa_per_compute_partition =3D
> adev->gds.oa.cs_partition_size;
> +               gds_info.compute_partition_size =3D adev->gds.gds_size;
> +               gds_info.gds_total_size =3D adev->gds.gds_size;
> +               gds_info.gws_per_compute_partition =3D adev->gds.gws_size=
;
> +               gds_info.oa_per_compute_partition =3D adev->gds.oa_size;
>                 return copy_to_user(out, &gds_info,
>                                     min((size_t)size, sizeof(gds_info))) =
?
> -EFAULT : 0;
>         }
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> index c14198737dcd..b25922e3d1ed 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> @@ -1758,44 +1758,26 @@ int amdgpu_ttm_init(struct amdgpu_device *adev)
>
>         /* Initialize various on-chip memory pools */
>         r =3D ttm_bo_init_mm(&adev->mman.bdev, AMDGPU_PL_GDS,
> -                          adev->gds.mem.total_size);
> +                          adev->gds.gds_size);
>         if (r) {
>                 DRM_ERROR("Failed initializing GDS heap.\n");
>                 return r;
>         }
>
> -       r =3D amdgpu_bo_create_kernel(adev, adev->gds.mem.gfx_partition_s=
ize,
> -                                   4, AMDGPU_GEM_DOMAIN_GDS,
> -                                   &adev->gds.gds_gfx_bo, NULL, NULL);
> -       if (r)
> -               return r;
> -
>         r =3D ttm_bo_init_mm(&adev->mman.bdev, AMDGPU_PL_GWS,
> -                          adev->gds.gws.total_size);
> +                          adev->gds.gws_size);
>         if (r) {
>                 DRM_ERROR("Failed initializing gws heap.\n");
>                 return r;
>         }
>
> -       r =3D amdgpu_bo_create_kernel(adev, adev->gds.gws.gfx_partition_s=
ize,
> -                                   1, AMDGPU_GEM_DOMAIN_GWS,
> -                                   &adev->gds.gws_gfx_bo, NULL, NULL);
> -       if (r)
> -               return r;
> -
>         r =3D ttm_bo_init_mm(&adev->mman.bdev, AMDGPU_PL_OA,
> -                          adev->gds.oa.total_size);
> +                          adev->gds.oa_size);
>         if (r) {
>                 DRM_ERROR("Failed initializing oa heap.\n");
>                 return r;
>         }
>
> -       r =3D amdgpu_bo_create_kernel(adev, adev->gds.oa.gfx_partition_si=
ze,
> -                                   1, AMDGPU_GEM_DOMAIN_OA,
> -                                   &adev->gds.oa_gfx_bo, NULL, NULL);
> -       if (r)
> -               return r;
> -
>         /* Register debugfs entries for amdgpu_ttm */
>         r =3D amdgpu_ttm_debugfs_init(adev);
>         if (r) {
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c
> b/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c
> index a59e0fdf5a97..4cd1731d62fd 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c
> @@ -4493,12 +4493,8 @@ static int gfx_v7_0_sw_init(void *handle)
>
>  static int gfx_v7_0_sw_fini(void *handle)
>  {
> -       int i;
>         struct amdgpu_device *adev =3D (struct amdgpu_device *)handle;
> -
> -       amdgpu_bo_free_kernel(&adev->gds.oa_gfx_bo, NULL, NULL);
> -       amdgpu_bo_free_kernel(&adev->gds.gws_gfx_bo, NULL, NULL);
> -       amdgpu_bo_free_kernel(&adev->gds.gds_gfx_bo, NULL, NULL);
> +       int i;
>
>         for (i =3D 0; i < adev->gfx.num_gfx_rings; i++)
>                 amdgpu_ring_fini(&adev->gfx.gfx_ring[i]);
> @@ -5070,30 +5066,10 @@ static void gfx_v7_0_set_irq_funcs(struct
> amdgpu_device *adev)
>  static void gfx_v7_0_set_gds_init(struct amdgpu_device *adev)
>  {
>         /* init asci gds info */
> -       adev->gds.mem.total_size =3D RREG32(mmGDS_VMID0_SIZE);
> -       adev->gds.gws.total_size =3D 64;
> -       adev->gds.oa.total_size =3D 16;
> +       adev->gds.gds_size =3D RREG32(mmGDS_VMID0_SIZE);
> +       adev->gds.gws_size =3D 64;
> +       adev->gds.oa_size =3D 16;
>         adev->gds.gds_compute_max_wave_id =3D
> RREG32(mmGDS_COMPUTE_MAX_WAVE_ID);
> -
> -       if (adev->gds.mem.total_size =3D=3D 64 * 1024) {
> -               adev->gds.mem.gfx_partition_size =3D 4096;
> -               adev->gds.mem.cs_partition_size =3D 4096;
> -
> -               adev->gds.gws.gfx_partition_size =3D 4;
> -               adev->gds.gws.cs_partition_size =3D 4;
> -
> -               adev->gds.oa.gfx_partition_size =3D 4;
> -               adev->gds.oa.cs_partition_size =3D 1;
> -       } else {
> -               adev->gds.mem.gfx_partition_size =3D 1024;
> -               adev->gds.mem.cs_partition_size =3D 1024;
> -
> -               adev->gds.gws.gfx_partition_size =3D 16;
> -               adev->gds.gws.cs_partition_size =3D 16;
> -
> -               adev->gds.oa.gfx_partition_size =3D 4;
> -               adev->gds.oa.cs_partition_size =3D 4;
> -       }
>  }
>
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
> b/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
> index 02955e6e9dd9..25400b708722 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
> @@ -2057,12 +2057,8 @@ static int gfx_v8_0_sw_init(void *handle)
>
>  static int gfx_v8_0_sw_fini(void *handle)
>  {
> -       int i;
>         struct amdgpu_device *adev =3D (struct amdgpu_device *)handle;
> -
> -       amdgpu_bo_free_kernel(&adev->gds.oa_gfx_bo, NULL, NULL);
> -       amdgpu_bo_free_kernel(&adev->gds.gws_gfx_bo, NULL, NULL);
> -       amdgpu_bo_free_kernel(&adev->gds.gds_gfx_bo, NULL, NULL);
> +       int i;
>
>         for (i =3D 0; i < adev->gfx.num_gfx_rings; i++)
>                 amdgpu_ring_fini(&adev->gfx.gfx_ring[i]);
> @@ -7010,30 +7006,10 @@ static void gfx_v8_0_set_rlc_funcs(struct
> amdgpu_device *adev)
>  static void gfx_v8_0_set_gds_init(struct amdgpu_device *adev)
>  {
>         /* init asci gds info */
> -       adev->gds.mem.total_size =3D RREG32(mmGDS_VMID0_SIZE);
> -       adev->gds.gws.total_size =3D 64;
> -       adev->gds.oa.total_size =3D 16;
> +       adev->gds.gds_size =3D RREG32(mmGDS_VMID0_SIZE);
> +       adev->gds.gws_size =3D 64;
> +       adev->gds.oa_size =3D 16;
>         adev->gds.gds_compute_max_wave_id =3D
> RREG32(mmGDS_COMPUTE_MAX_WAVE_ID);
> -
> -       if (adev->gds.mem.total_size =3D=3D 64 * 1024) {
> -               adev->gds.mem.gfx_partition_size =3D 4096;
> -               adev->gds.mem.cs_partition_size =3D 4096;
> -
> -               adev->gds.gws.gfx_partition_size =3D 4;
> -               adev->gds.gws.cs_partition_size =3D 4;
> -
> -               adev->gds.oa.gfx_partition_size =3D 4;
> -               adev->gds.oa.cs_partition_size =3D 1;
> -       } else {
> -               adev->gds.mem.gfx_partition_size =3D 1024;
> -               adev->gds.mem.cs_partition_size =3D 1024;
> -
> -               adev->gds.gws.gfx_partition_size =3D 16;
> -               adev->gds.gws.cs_partition_size =3D 16;
> -
> -               adev->gds.oa.gfx_partition_size =3D 4;
> -               adev->gds.oa.cs_partition_size =3D 4;
> -       }
>  }
>
>  static void gfx_v8_0_set_user_cu_inactive_bitmap(struct amdgpu_device
> *adev,
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> index fc6d8c1fd32b..fac38429685d 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> @@ -1461,8 +1461,7 @@ static int gfx_v9_0_ngg_init(struct amdgpu_device
> *adev)
>
>         /* GDS reserve memory: 64 bytes alignment */
>         adev->gfx.ngg.gds_reserve_size =3D ALIGN(5 * 4, 0x40);
> -       adev->gds.mem.total_size -=3D adev->gfx.ngg.gds_reserve_size;
> -       adev->gds.mem.gfx_partition_size -=3D adev->gfx.ngg.gds_reserve_s=
ize;
> +       adev->gds.gds_size -=3D adev->gfx.ngg.gds_reserve_size;
>         adev->gfx.ngg.gds_reserve_addr =3D RREG32_SOC15(GC, 0,
> mmGDS_VMID0_BASE);
>         adev->gfx.ngg.gds_reserve_addr +=3D RREG32_SOC15(GC, 0,
> mmGDS_VMID0_SIZE);
>
> @@ -1570,7 +1569,7 @@ static int gfx_v9_0_ngg_en(struct amdgpu_device
> *adev)
>
>         gfx_v9_0_write_data_to_reg(ring, 0, false,
>                                    SOC15_REG_OFFSET(GC, 0,
> mmGDS_VMID0_SIZE),
> -                                  (adev->gds.mem.total_size +
> +                                  (adev->gds.gds_size +
>                                     adev->gfx.ngg.gds_reserve_size));
>
>         amdgpu_ring_write(ring, PACKET3(PACKET3_DMA_DATA, 5));
> @@ -1784,10 +1783,6 @@ static int gfx_v9_0_sw_fini(void *handle)
>                 kfree(ras_if);
>         }
>
> -       amdgpu_bo_free_kernel(&adev->gds.oa_gfx_bo, NULL, NULL);
> -       amdgpu_bo_free_kernel(&adev->gds.gws_gfx_bo, NULL, NULL);
> -       amdgpu_bo_free_kernel(&adev->gds.gds_gfx_bo, NULL, NULL);
> -
>         for (i =3D 0; i < adev->gfx.num_gfx_rings; i++)
>                 amdgpu_ring_fini(&adev->gfx.gfx_ring[i]);
>         for (i =3D 0; i < adev->gfx.num_compute_rings; i++)
> @@ -5309,13 +5304,13 @@ static void gfx_v9_0_set_gds_init(struct
> amdgpu_device *adev)
>         case CHIP_VEGA10:
>         case CHIP_VEGA12:
>         case CHIP_VEGA20:
> -               adev->gds.mem.total_size =3D 0x10000;
> +               adev->gds.gds_size =3D 0x10000;
>                 break;
>         case CHIP_RAVEN:
> -               adev->gds.mem.total_size =3D 0x1000;
> +               adev->gds.gds_size =3D 0x1000;
>                 break;
>         default:
> -               adev->gds.mem.total_size =3D 0x10000;
> +               adev->gds.gds_size =3D 0x10000;
>                 break;
>         }
>
> @@ -5339,28 +5334,8 @@ static void gfx_v9_0_set_gds_init(struct
> amdgpu_device *adev)
>                 break;
>         }
>
> -       adev->gds.gws.total_size =3D 64;
> -       adev->gds.oa.total_size =3D 16;
> -
> -       if (adev->gds.mem.total_size =3D=3D 64 * 1024) {
> -               adev->gds.mem.gfx_partition_size =3D 4096;
> -               adev->gds.mem.cs_partition_size =3D 4096;
> -
> -               adev->gds.gws.gfx_partition_size =3D 4;
> -               adev->gds.gws.cs_partition_size =3D 4;
> -
> -               adev->gds.oa.gfx_partition_size =3D 4;
> -               adev->gds.oa.cs_partition_size =3D 1;
> -       } else {
> -               adev->gds.mem.gfx_partition_size =3D 1024;
> -               adev->gds.mem.cs_partition_size =3D 1024;
> -
> -               adev->gds.gws.gfx_partition_size =3D 16;
> -               adev->gds.gws.cs_partition_size =3D 16;
> -
> -               adev->gds.oa.gfx_partition_size =3D 4;
> -               adev->gds.oa.cs_partition_size =3D 4;
> -       }
> +       adev->gds.gws_size =3D 64;
> +       adev->gds.oa_size =3D 16;
>  }
>
>  static void gfx_v9_0_set_user_cu_inactive_bitmap(struct amdgpu_device
> *adev,
> --
> 2.17.1
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--00000000000046bd700588924b68
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Reviewed-by: Marek Ol=C5=A1=C3=A1k &lt;<a href=3D"mai=
lto:marek.olsak-5C7GfCeVMHo@public.gmane.org">marek.olsak-5C7GfCeVMHo@public.gmane.org</a>&gt;</div><div><br></div><d=
iv>Marek<br></div></div><br><div class=3D"gmail_quote"><div dir=3D"ltr" cla=
ss=3D"gmail_attr">On Fri, May 10, 2019 at 1:58 PM Christian K=C3=B6nig &lt;=
<a href=3D"mailto:ckoenig.leichtzumerken-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org">ckoenig.leichtzumerken@=
gmail.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=
=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding=
-left:1ex">As far as we know this was never used by userspace and so should=
 be removed.<br>
<br>
Signed-off-by: Christian K=C3=B6nig &lt;<a href=3D"mailto:christian.koenig@=
amd.com" target=3D"_blank">christian.koenig-5C7GfCeVMHo@public.gmane.org</a>&gt;<br>
---<br>
=C2=A0drivers/gpu/drm/amd/amdgpu/amdgpu_bo_list.c |=C2=A0 6 ++--<br>
=C2=A0drivers/gpu/drm/amd/amdgpu/amdgpu_gds.h=C2=A0 =C2=A0 =C2=A0| 21 ++---=
------<br>
=C2=A0drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c=C2=A0 =C2=A0 =C2=A0| 11 +++--=
-<br>
=C2=A0drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c=C2=A0 =C2=A0 =C2=A0| 24 ++---=
--------<br>
=C2=A0drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c=C2=A0 =C2=A0 =C2=A0 =C2=A0| 32 =
+++--------------<br>
=C2=A0drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c=C2=A0 =C2=A0 =C2=A0 =C2=A0| 32 =
+++--------------<br>
=C2=A0drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c=C2=A0 =C2=A0 =C2=A0 =C2=A0| 39 =
++++-----------------<br>
=C2=A07 files changed, 28 insertions(+), 137 deletions(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_bo_list.c b/drivers/gpu/drm/=
amd/amdgpu/amdgpu_bo_list.c<br>
index 5c79da8e1150..d497467b7fc6 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_bo_list.c<br>
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_bo_list.c<br>
@@ -81,9 +81,9 @@ int amdgpu_bo_list_create(struct amdgpu_device *adev, str=
uct drm_file *filp,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return -ENOMEM;<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 kref_init(&amp;list-&gt;refcount);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0list-&gt;gds_obj =3D adev-&gt;gds.gds_gfx_bo;<b=
r>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0list-&gt;gws_obj =3D adev-&gt;gds.gws_gfx_bo;<b=
r>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0list-&gt;oa_obj =3D adev-&gt;gds.oa_gfx_bo;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0list-&gt;gds_obj =3D NULL;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0list-&gt;gws_obj =3D NULL;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0list-&gt;oa_obj =3D NULL;<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 array =3D amdgpu_bo_list_array_entry(list, 0);<=
br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 memset(array, 0, num_entries * sizeof(struct am=
dgpu_bo_list_entry));<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gds.h b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_gds.h<br>
index f89f5734d985..dad2186f4ed5 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gds.h<br>
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gds.h<br>
@@ -27,26 +27,11 @@<br>
=C2=A0struct amdgpu_ring;<br>
=C2=A0struct amdgpu_bo;<br>
<br>
-struct amdgpu_gds_asic_info {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0uint32_t=C2=A0 =C2=A0 =C2=A0 =C2=A0 total_size;=
<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0uint32_t=C2=A0 =C2=A0 =C2=A0 =C2=A0 gfx_partiti=
on_size;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0uint32_t=C2=A0 =C2=A0 =C2=A0 =C2=A0 cs_partitio=
n_size;<br>
-};<br>
-<br>
=C2=A0struct amdgpu_gds {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0struct amdgpu_gds_asic_info=C2=A0 =C2=A0 =C2=A0=
mem;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0struct amdgpu_gds_asic_info=C2=A0 =C2=A0 =C2=A0=
gws;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0struct amdgpu_gds_asic_info=C2=A0 =C2=A0 =C2=A0=
oa;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0uint32_t gds_size;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0uint32_t gws_size;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0uint32_t oa_size;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 uint32_t=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 gds_compute_max_wave_id;<br>
-<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0/* At present, GDS, GWS and OA resources for gf=
x (graphics)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 * is always pre-allocated and available for gr=
aphics operation.<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 * Such resource is shared between all gfx clie=
nts.<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 * TODO: move this operation to user space<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 * */<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0struct amdgpu_bo*=C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0gds_gfx_bo;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0struct amdgpu_bo*=C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0gws_gfx_bo;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0struct amdgpu_bo*=C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0oa_gfx_bo;<br>
=C2=A0};<br>
<br>
=C2=A0struct amdgpu_gds_reg_offset {<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_kms.c<br>
index da7b4fe8ade3..87a93874d71e 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c<br>
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c<br>
@@ -590,13 +590,10 @@ static int amdgpu_info_ioctl(struct drm_device *dev, =
void *data, struct drm_file<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 struct drm_amdgpu_i=
nfo_gds gds_info;<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 memset(&amp;gds_inf=
o, 0, sizeof(gds_info));<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0gds_info.gds_gfx_pa=
rtition_size =3D adev-&gt;gds.mem.gfx_partition_size;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0gds_info.compute_pa=
rtition_size =3D adev-&gt;gds.mem.cs_partition_size;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0gds_info.gds_total_=
size =3D adev-&gt;gds.mem.total_size;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0gds_info.gws_per_gf=
x_partition =3D adev-&gt;gds.gws.gfx_partition_size;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0gds_info.gws_per_co=
mpute_partition =3D adev-&gt;gds.gws.cs_partition_size;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0gds_info.oa_per_gfx=
_partition =3D adev-&gt;gds.oa.gfx_partition_size;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0gds_info.oa_per_com=
pute_partition =3D adev-&gt;gds.oa.cs_partition_size;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0gds_info.compute_pa=
rtition_size =3D adev-&gt;gds.gds_size;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0gds_info.gds_total_=
size =3D adev-&gt;gds.gds_size;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0gds_info.gws_per_co=
mpute_partition =3D adev-&gt;gds.gws_size;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0gds_info.oa_per_com=
pute_partition =3D adev-&gt;gds.oa_size;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return copy_to_user=
(out, &amp;gds_info,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 min((size_t)size, size=
of(gds_info))) ? -EFAULT : 0;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_ttm.c<br>
index c14198737dcd..b25922e3d1ed 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c<br>
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c<br>
@@ -1758,44 +1758,26 @@ int amdgpu_ttm_init(struct amdgpu_device *adev)<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* Initialize various on-chip memory pools */<b=
r>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 r =3D ttm_bo_init_mm(&amp;adev-&gt;mman.bdev, A=
MDGPU_PL_GDS,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 adev-&gt;gds.mem.total_size);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 adev-&gt;gds.gds_size);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (r) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 DRM_ERROR(&quot;Fai=
led initializing GDS heap.\n&quot;);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return r;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0r =3D amdgpu_bo_create_kernel(adev, adev-&gt;gd=
s.mem.gfx_partition_size,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A04, AMDGPU_GEM_DOMAIN_GD=
S,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&amp;adev-&gt;gds.gds_g=
fx_bo, NULL, NULL);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0if (r)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return r;<br>
-<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 r =3D ttm_bo_init_mm(&amp;adev-&gt;mman.bdev, A=
MDGPU_PL_GWS,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 adev-&gt;gds.gws.total_size);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 adev-&gt;gds.gws_size);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (r) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 DRM_ERROR(&quot;Fai=
led initializing gws heap.\n&quot;);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return r;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0r =3D amdgpu_bo_create_kernel(adev, adev-&gt;gd=
s.gws.gfx_partition_size,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A01, AMDGPU_GEM_DOMAIN_GW=
S,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&amp;adev-&gt;gds.gws_g=
fx_bo, NULL, NULL);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0if (r)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return r;<br>
-<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 r =3D ttm_bo_init_mm(&amp;adev-&gt;mman.bdev, A=
MDGPU_PL_OA,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 adev-&gt;gds.oa.total_size);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 adev-&gt;gds.oa_size);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (r) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 DRM_ERROR(&quot;Fai=
led initializing oa heap.\n&quot;);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return r;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0r =3D amdgpu_bo_create_kernel(adev, adev-&gt;gd=
s.oa.gfx_partition_size,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A01, AMDGPU_GEM_DOMAIN_OA=
,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&amp;adev-&gt;gds.oa_gf=
x_bo, NULL, NULL);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0if (r)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return r;<br>
-<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* Register debugfs entries for amdgpu_ttm */<b=
r>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 r =3D amdgpu_ttm_debugfs_init(adev);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (r) {<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c b/drivers/gpu/drm/amd/am=
dgpu/gfx_v7_0.c<br>
index a59e0fdf5a97..4cd1731d62fd 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c<br>
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c<br>
@@ -4493,12 +4493,8 @@ static int gfx_v7_0_sw_init(void *handle)<br>
<br>
=C2=A0static int gfx_v7_0_sw_fini(void *handle)<br>
=C2=A0{<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0int i;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 struct amdgpu_device *adev =3D (struct amdgpu_d=
evice *)handle;<br>
-<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0amdgpu_bo_free_kernel(&amp;adev-&gt;gds.oa_gfx_=
bo, NULL, NULL);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0amdgpu_bo_free_kernel(&amp;adev-&gt;gds.gws_gfx=
_bo, NULL, NULL);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0amdgpu_bo_free_kernel(&amp;adev-&gt;gds.gds_gfx=
_bo, NULL, NULL);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0int i;<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 for (i =3D 0; i &lt; adev-&gt;gfx.num_gfx_rings=
; i++)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 amdgpu_ring_fini(&a=
mp;adev-&gt;gfx.gfx_ring[i]);<br>
@@ -5070,30 +5066,10 @@ static void gfx_v7_0_set_irq_funcs(struct amdgpu_de=
vice *adev)<br>
=C2=A0static void gfx_v7_0_set_gds_init(struct amdgpu_device *adev)<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* init asci gds info */<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0adev-&gt;gds.mem.total_size =3D RREG32(mmGDS_VM=
ID0_SIZE);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0adev-&gt;gds.gws.total_size =3D 64;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0adev-&gt;gds.oa.total_size =3D 16;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0adev-&gt;gds.gds_size =3D RREG32(mmGDS_VMID0_SI=
ZE);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0adev-&gt;gds.gws_size =3D 64;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0adev-&gt;gds.oa_size =3D 16;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 adev-&gt;gds.gds_compute_max_wave_id =3D RREG32=
(mmGDS_COMPUTE_MAX_WAVE_ID);<br>
-<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0if (adev-&gt;gds.mem.total_size =3D=3D 64 * 102=
4) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0adev-&gt;gds.mem.gf=
x_partition_size =3D 4096;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0adev-&gt;gds.mem.cs=
_partition_size =3D 4096;<br>
-<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0adev-&gt;gds.gws.gf=
x_partition_size =3D 4;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0adev-&gt;gds.gws.cs=
_partition_size =3D 4;<br>
-<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0adev-&gt;gds.oa.gfx=
_partition_size =3D 4;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0adev-&gt;gds.oa.cs_=
partition_size =3D 1;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0} else {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0adev-&gt;gds.mem.gf=
x_partition_size =3D 1024;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0adev-&gt;gds.mem.cs=
_partition_size =3D 1024;<br>
-<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0adev-&gt;gds.gws.gf=
x_partition_size =3D 16;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0adev-&gt;gds.gws.cs=
_partition_size =3D 16;<br>
-<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0adev-&gt;gds.oa.gfx=
_partition_size =3D 4;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0adev-&gt;gds.oa.cs_=
partition_size =3D 4;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0}<br>
<br>
<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c b/drivers/gpu/drm/amd/am=
dgpu/gfx_v8_0.c<br>
index 02955e6e9dd9..25400b708722 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c<br>
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c<br>
@@ -2057,12 +2057,8 @@ static int gfx_v8_0_sw_init(void *handle)<br>
<br>
=C2=A0static int gfx_v8_0_sw_fini(void *handle)<br>
=C2=A0{<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0int i;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 struct amdgpu_device *adev =3D (struct amdgpu_d=
evice *)handle;<br>
-<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0amdgpu_bo_free_kernel(&amp;adev-&gt;gds.oa_gfx_=
bo, NULL, NULL);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0amdgpu_bo_free_kernel(&amp;adev-&gt;gds.gws_gfx=
_bo, NULL, NULL);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0amdgpu_bo_free_kernel(&amp;adev-&gt;gds.gds_gfx=
_bo, NULL, NULL);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0int i;<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 for (i =3D 0; i &lt; adev-&gt;gfx.num_gfx_rings=
; i++)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 amdgpu_ring_fini(&a=
mp;adev-&gt;gfx.gfx_ring[i]);<br>
@@ -7010,30 +7006,10 @@ static void gfx_v8_0_set_rlc_funcs(struct amdgpu_de=
vice *adev)<br>
=C2=A0static void gfx_v8_0_set_gds_init(struct amdgpu_device *adev)<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* init asci gds info */<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0adev-&gt;gds.mem.total_size =3D RREG32(mmGDS_VM=
ID0_SIZE);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0adev-&gt;gds.gws.total_size =3D 64;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0adev-&gt;gds.oa.total_size =3D 16;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0adev-&gt;gds.gds_size =3D RREG32(mmGDS_VMID0_SI=
ZE);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0adev-&gt;gds.gws_size =3D 64;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0adev-&gt;gds.oa_size =3D 16;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 adev-&gt;gds.gds_compute_max_wave_id =3D RREG32=
(mmGDS_COMPUTE_MAX_WAVE_ID);<br>
-<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0if (adev-&gt;gds.mem.total_size =3D=3D 64 * 102=
4) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0adev-&gt;gds.mem.gf=
x_partition_size =3D 4096;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0adev-&gt;gds.mem.cs=
_partition_size =3D 4096;<br>
-<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0adev-&gt;gds.gws.gf=
x_partition_size =3D 4;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0adev-&gt;gds.gws.cs=
_partition_size =3D 4;<br>
-<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0adev-&gt;gds.oa.gfx=
_partition_size =3D 4;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0adev-&gt;gds.oa.cs_=
partition_size =3D 1;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0} else {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0adev-&gt;gds.mem.gf=
x_partition_size =3D 1024;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0adev-&gt;gds.mem.cs=
_partition_size =3D 1024;<br>
-<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0adev-&gt;gds.gws.gf=
x_partition_size =3D 16;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0adev-&gt;gds.gws.cs=
_partition_size =3D 16;<br>
-<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0adev-&gt;gds.oa.gfx=
_partition_size =3D 4;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0adev-&gt;gds.oa.cs_=
partition_size =3D 4;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0}<br>
<br>
=C2=A0static void gfx_v8_0_set_user_cu_inactive_bitmap(struct amdgpu_device=
 *adev,<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/am=
dgpu/gfx_v9_0.c<br>
index fc6d8c1fd32b..fac38429685d 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c<br>
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c<br>
@@ -1461,8 +1461,7 @@ static int gfx_v9_0_ngg_init(struct amdgpu_device *ad=
ev)<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* GDS reserve memory: 64 bytes alignment */<br=
>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 adev-&gt;gfx.ngg.gds_reserve_size =3D ALIGN(5 *=
 4, 0x40);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0adev-&gt;gds.mem.total_size -=3D adev-&gt;gfx.n=
gg.gds_reserve_size;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0adev-&gt;gds.mem.gfx_partition_size -=3D adev-&=
gt;gfx.ngg.gds_reserve_size;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0adev-&gt;gds.gds_size -=3D adev-&gt;gfx.ngg.gds=
_reserve_size;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 adev-&gt;gfx.ngg.gds_reserve_addr =3D RREG32_SO=
C15(GC, 0, mmGDS_VMID0_BASE);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 adev-&gt;gfx.ngg.gds_reserve_addr +=3D RREG32_S=
OC15(GC, 0, mmGDS_VMID0_SIZE);<br>
<br>
@@ -1570,7 +1569,7 @@ static int gfx_v9_0_ngg_en(struct amdgpu_device *adev=
)<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 gfx_v9_0_write_data_to_reg(ring, 0, false,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0SOC15_REG_OFFSET(GC, 0,=
 mmGDS_VMID0_SIZE),<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 (adev-&gt;gds.mem.total_size =
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 (adev-&gt;gds.gds_size +<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 adev-&gt;gfx.ngg.gds_r=
eserve_size));<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 amdgpu_ring_write(ring, PACKET3(PACKET3_DMA_DAT=
A, 5));<br>
@@ -1784,10 +1783,6 @@ static int gfx_v9_0_sw_fini(void *handle)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 kfree(ras_if);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0amdgpu_bo_free_kernel(&amp;adev-&gt;gds.oa_gfx_=
bo, NULL, NULL);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0amdgpu_bo_free_kernel(&amp;adev-&gt;gds.gws_gfx=
_bo, NULL, NULL);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0amdgpu_bo_free_kernel(&amp;adev-&gt;gds.gds_gfx=
_bo, NULL, NULL);<br>
-<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 for (i =3D 0; i &lt; adev-&gt;gfx.num_gfx_rings=
; i++)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 amdgpu_ring_fini(&a=
mp;adev-&gt;gfx.gfx_ring[i]);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 for (i =3D 0; i &lt; adev-&gt;gfx.num_compute_r=
ings; i++)<br>
@@ -5309,13 +5304,13 @@ static void gfx_v9_0_set_gds_init(struct amdgpu_dev=
ice *adev)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 case CHIP_VEGA10:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 case CHIP_VEGA12:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 case CHIP_VEGA20:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0adev-&gt;gds.mem.to=
tal_size =3D 0x10000;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0adev-&gt;gds.gds_si=
ze =3D 0x10000;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 case CHIP_RAVEN:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0adev-&gt;gds.mem.to=
tal_size =3D 0x1000;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0adev-&gt;gds.gds_si=
ze =3D 0x1000;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 default:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0adev-&gt;gds.mem.to=
tal_size =3D 0x10000;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0adev-&gt;gds.gds_si=
ze =3D 0x10000;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
<br>
@@ -5339,28 +5334,8 @@ static void gfx_v9_0_set_gds_init(struct amdgpu_devi=
ce *adev)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0adev-&gt;gds.gws.total_size =3D 64;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0adev-&gt;gds.oa.total_size =3D 16;<br>
-<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0if (adev-&gt;gds.mem.total_size =3D=3D 64 * 102=
4) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0adev-&gt;gds.mem.gf=
x_partition_size =3D 4096;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0adev-&gt;gds.mem.cs=
_partition_size =3D 4096;<br>
-<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0adev-&gt;gds.gws.gf=
x_partition_size =3D 4;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0adev-&gt;gds.gws.cs=
_partition_size =3D 4;<br>
-<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0adev-&gt;gds.oa.gfx=
_partition_size =3D 4;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0adev-&gt;gds.oa.cs_=
partition_size =3D 1;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0} else {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0adev-&gt;gds.mem.gf=
x_partition_size =3D 1024;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0adev-&gt;gds.mem.cs=
_partition_size =3D 1024;<br>
-<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0adev-&gt;gds.gws.gf=
x_partition_size =3D 16;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0adev-&gt;gds.gws.cs=
_partition_size =3D 16;<br>
-<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0adev-&gt;gds.oa.gfx=
_partition_size =3D 4;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0adev-&gt;gds.oa.cs_=
partition_size =3D 4;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0adev-&gt;gds.gws_size =3D 64;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0adev-&gt;gds.oa_size =3D 16;<br>
=C2=A0}<br>
<br>
=C2=A0static void gfx_v9_0_set_user_cu_inactive_bitmap(struct amdgpu_device=
 *adev,<br>
-- <br>
2.17.1<br>
<br>
_______________________________________________<br>
amd-gfx mailing list<br>
<a href=3D"mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" target=3D"_blank">amd-gfx@=
lists.freedesktop.org</a><br>
<a href=3D"https://lists.freedesktop.org/mailman/listinfo/amd-gfx" rel=3D"n=
oreferrer" target=3D"_blank">https://lists.freedesktop.org/mailman/listinfo=
/amd-gfx</a></blockquote></div>

--00000000000046bd700588924b68--

--===============2021758559==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4

--===============2021758559==--
