From: Thomas Zimmermann <tzimmermann@suse.de>
Subject: Re: [PATCH 2/5] drm/ttm: Define a single DRM_FILE_PAGE_OFFSET constant
Date: Thu, 7 Feb 2019 10:49:21 +0100
Message-ID: <2aff6676-c8aa-9fed-9a76-28b8e07d18f6@suse.de>
References: <20190207085931.29569-1-tzimmermann@suse.de>
 <20190207085931.29569-3-tzimmermann@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1459668597=="
Return-path: <dri-devel-bounces@lists.freedesktop.org>
In-Reply-To: <20190207085931.29569-3-tzimmermann@suse.de>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
To: alexander.deucher@amd.com, christian.koenig@amd.com, David1.Zhou@amd.com, airlied@redhat.com, kraxel@redhat.com, z.liuxinliang@hisilicon.com, zourongrong@gmail.com, kong.kongxinwei@hisilicon.com, puck.chen@hisilicon.com, bskeggs@redhat.com, thellstrom@vmware.com, linux-graphics-maintainer@vmware.com, daniel@ffwll.ch, hdegoede@redhat.com, arnd@arndb.de, gregkh@linuxfoundation.org, ray.huang@amd.com, Jerry.Zhang@amd.com
Cc: spice-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, virtualization@lists.linux-foundation.org
List-Id: amd-gfx.lists.freedesktop.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--===============1459668597==
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="WRy2CCyR0ZJ3NDjDzcg4ziVmLtqgbGWlw"

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--WRy2CCyR0ZJ3NDjDzcg4ziVmLtqgbGWlw
Content-Type: multipart/mixed; boundary="6xaGRjBYpy157oY1Sv7sRAk5K5Vvu1yGp";
 protected-headers="v1"
From: Thomas Zimmermann <tzimmermann@suse.de>
To: alexander.deucher@amd.com, christian.koenig@amd.com, David1.Zhou@amd.com,
 airlied@redhat.com, kraxel@redhat.com, z.liuxinliang@hisilicon.com,
 zourongrong@gmail.com, kong.kongxinwei@hisilicon.com,
 puck.chen@hisilicon.com, bskeggs@redhat.com, thellstrom@vmware.com,
 linux-graphics-maintainer@vmware.com, daniel@ffwll.ch, hdegoede@redhat.com,
 arnd@arndb.de, gregkh@linuxfoundation.org, ray.huang@amd.com,
 Jerry.Zhang@amd.com
Cc: dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
 virtualization@lists.linux-foundation.org, spice-devel@lists.freedesktop.org
Message-ID: <2aff6676-c8aa-9fed-9a76-28b8e07d18f6@suse.de>
Subject: Re: [PATCH 2/5] drm/ttm: Define a single DRM_FILE_PAGE_OFFSET
 constant
References: <20190207085931.29569-1-tzimmermann@suse.de>
 <20190207085931.29569-3-tzimmermann@suse.de>
In-Reply-To: <20190207085931.29569-3-tzimmermann@suse.de>

--6xaGRjBYpy157oY1Sv7sRAk5K5Vvu1yGp
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

Hi

Am 07.02.19 um 09:59 schrieb Thomas Zimmermann:
> Most TTM drivers define the constant DRM_FILE_PAGE_OFFSET of the same
> value. The only exception is vboxvideo, which is being converted to the=

> new offset by this patch. Unifying the constants in a single place
> simplifies the driver code.

Just a quick note: I just realized that the description is slightly
incorrect. vboxvideo got fixed in patch [01]. If it matters, remove the
second sentence before merging. (Or ping me to provide an updated patch.)=


Best regards
Thomas

>=20
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c     | 2 --
>  drivers/gpu/drm/ast/ast_drv.h               | 2 --
>  drivers/gpu/drm/bochs/bochs.h               | 2 --
>  drivers/gpu/drm/cirrus/cirrus_drv.h         | 1 -
>  drivers/gpu/drm/hisilicon/hibmc/hibmc_ttm.c | 2 --
>  drivers/gpu/drm/mgag200/mgag200_drv.h       | 1 -
>  drivers/gpu/drm/nouveau/nouveau_drv.h       | 2 --
>  drivers/gpu/drm/qxl/qxl_drv.h               | 3 ---
>  drivers/gpu/drm/radeon/radeon_ttm.c         | 2 --
>  drivers/gpu/drm/virtio/virtgpu_ttm.c        | 2 --
>  drivers/gpu/drm/vmwgfx/vmwgfx_drv.c         | 2 +-
>  drivers/gpu/drm/vmwgfx/vmwgfx_drv.h         | 1 -
>  drivers/gpu/drm/vmwgfx/vmwgfx_ttm_glue.c    | 2 +-
>  drivers/staging/vboxvideo/vbox_drv.h        | 2 --
>  include/drm/ttm/ttm_bo_driver.h             | 2 ++
>  15 files changed, 4 insertions(+), 24 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/=
amd/amdgpu/amdgpu_ttm.c
> index b852abb9db0f..447960b3334a 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> @@ -50,8 +50,6 @@
>  #include "amdgpu_sdma.h"
>  #include "bif/bif_4_1_d.h"
> =20
> -#define DRM_FILE_PAGE_OFFSET (0x100000000ULL >> PAGE_SHIFT)
> -
>  static int amdgpu_map_buffer(struct ttm_buffer_object *bo,
>  			     struct ttm_mem_reg *mem, unsigned num_pages,
>  			     uint64_t offset, unsigned window,
> diff --git a/drivers/gpu/drm/ast/ast_drv.h b/drivers/gpu/drm/ast/ast_dr=
v.h
> index bfc65040dfcb..c43b927f73af 100644
> --- a/drivers/gpu/drm/ast/ast_drv.h
> +++ b/drivers/gpu/drm/ast/ast_drv.h
> @@ -353,8 +353,6 @@ extern int ast_dumb_mmap_offset(struct drm_file *fi=
le,
>  				uint32_t handle,
>  				uint64_t *offset);
> =20
> -#define DRM_FILE_PAGE_OFFSET (0x100000000ULL >> PAGE_SHIFT)
> -
>  int ast_mm_init(struct ast_private *ast);
>  void ast_mm_fini(struct ast_private *ast);
> =20
> diff --git a/drivers/gpu/drm/bochs/bochs.h b/drivers/gpu/drm/bochs/boch=
s.h
> index 03711394f1ed..7425d083b944 100644
> --- a/drivers/gpu/drm/bochs/bochs.h
> +++ b/drivers/gpu/drm/bochs/bochs.h
> @@ -101,8 +101,6 @@ static inline struct bochs_bo *gem_to_bochs_bo(stru=
ct drm_gem_object *gem)
>  	return container_of(gem, struct bochs_bo, gem);
>  }
> =20
> -#define DRM_FILE_PAGE_OFFSET (0x100000000ULL >> PAGE_SHIFT)
> -
>  static inline u64 bochs_bo_mmap_offset(struct bochs_bo *bo)
>  {
>  	return drm_vma_node_offset_addr(&bo->bo.vma_node);
> diff --git a/drivers/gpu/drm/cirrus/cirrus_drv.h b/drivers/gpu/drm/cirr=
us/cirrus_drv.h
> index f2b2e0d169fa..ba77507e9bad 100644
> --- a/drivers/gpu/drm/cirrus/cirrus_drv.h
> +++ b/drivers/gpu/drm/cirrus/cirrus_drv.h
> @@ -169,7 +169,6 @@ cirrus_bo(struct ttm_buffer_object *bo)
> =20
> =20
>  #define to_cirrus_obj(x) container_of(x, struct cirrus_gem_object, bas=
e)
> -#define DRM_FILE_PAGE_OFFSET (0x100000000ULL >> PAGE_SHIFT)
> =20
>  				/* cirrus_main.c */
>  int cirrus_device_init(struct cirrus_device *cdev,
> diff --git a/drivers/gpu/drm/hisilicon/hibmc/hibmc_ttm.c b/drivers/gpu/=
drm/hisilicon/hibmc/hibmc_ttm.c
> index dd383267884c..a06725c2bbfa 100644
> --- a/drivers/gpu/drm/hisilicon/hibmc/hibmc_ttm.c
> +++ b/drivers/gpu/drm/hisilicon/hibmc/hibmc_ttm.c
> @@ -21,8 +21,6 @@
> =20
>  #include "hibmc_drm_drv.h"
> =20
> -#define DRM_FILE_PAGE_OFFSET (0x100000000ULL >> PAGE_SHIFT)
> -
>  static inline struct hibmc_drm_private *
>  hibmc_bdev(struct ttm_bo_device *bd)
>  {
> diff --git a/drivers/gpu/drm/mgag200/mgag200_drv.h b/drivers/gpu/drm/mg=
ag200/mgag200_drv.h
> index 0aaedc554879..706c902aad2d 100644
> --- a/drivers/gpu/drm/mgag200/mgag200_drv.h
> +++ b/drivers/gpu/drm/mgag200/mgag200_drv.h
> @@ -269,7 +269,6 @@ mgag200_dumb_mmap_offset(struct drm_file *file,
>  struct mga_i2c_chan *mgag200_i2c_create(struct drm_device *dev);
>  void mgag200_i2c_destroy(struct mga_i2c_chan *i2c);
> =20
> -#define DRM_FILE_PAGE_OFFSET (0x100000000ULL >> PAGE_SHIFT)
>  void mgag200_ttm_placement(struct mgag200_bo *bo, int domain);
> =20
>  static inline int mgag200_bo_reserve(struct mgag200_bo *bo, bool no_wa=
it)
> diff --git a/drivers/gpu/drm/nouveau/nouveau_drv.h b/drivers/gpu/drm/no=
uveau/nouveau_drv.h
> index d20b9ba4b1c1..c144bc79e872 100644
> --- a/drivers/gpu/drm/nouveau/nouveau_drv.h
> +++ b/drivers/gpu/drm/nouveau/nouveau_drv.h
> @@ -60,8 +60,6 @@
>  struct nouveau_channel;
>  struct platform_device;
> =20
> -#define DRM_FILE_PAGE_OFFSET (0x100000000ULL >> PAGE_SHIFT)
> -
>  #include "nouveau_fence.h"
>  #include "nouveau_bios.h"
>  #include "nouveau_vmm.h"
> diff --git a/drivers/gpu/drm/qxl/qxl_drv.h b/drivers/gpu/drm/qxl/qxl_dr=
v.h
> index 4a0331b3ff7d..2896bb6fdbf4 100644
> --- a/drivers/gpu/drm/qxl/qxl_drv.h
> +++ b/drivers/gpu/drm/qxl/qxl_drv.h
> @@ -65,9 +65,6 @@
>  extern int qxl_num_crtc;
>  extern int qxl_max_ioctls;
> =20
> -#define DRM_FILE_OFFSET 0x100000000ULL
> -#define DRM_FILE_PAGE_OFFSET (DRM_FILE_OFFSET >> PAGE_SHIFT)
> -
>  #define QXL_INTERRUPT_MASK (\
>  	QXL_INTERRUPT_DISPLAY |\
>  	QXL_INTERRUPT_CURSOR |\
> diff --git a/drivers/gpu/drm/radeon/radeon_ttm.c b/drivers/gpu/drm/rade=
on/radeon_ttm.c
> index 9920a6fc11bf..071a872e5b02 100644
> --- a/drivers/gpu/drm/radeon/radeon_ttm.c
> +++ b/drivers/gpu/drm/radeon/radeon_ttm.c
> @@ -45,8 +45,6 @@
>  #include "radeon_reg.h"
>  #include "radeon.h"
> =20
> -#define DRM_FILE_PAGE_OFFSET (0x100000000ULL >> PAGE_SHIFT)
> -
>  static int radeon_ttm_debugfs_init(struct radeon_device *rdev);
>  static void radeon_ttm_debugfs_fini(struct radeon_device *rdev);
> =20
> diff --git a/drivers/gpu/drm/virtio/virtgpu_ttm.c b/drivers/gpu/drm/vir=
tio/virtgpu_ttm.c
> index 4bfbf25fabff..64f5b8dec3e9 100644
> --- a/drivers/gpu/drm/virtio/virtgpu_ttm.c
> +++ b/drivers/gpu/drm/virtio/virtgpu_ttm.c
> @@ -37,8 +37,6 @@
> =20
>  #include <linux/delay.h>
> =20
> -#define DRM_FILE_PAGE_OFFSET (0x100000000ULL >> PAGE_SHIFT)
> -
>  static struct
>  virtio_gpu_device *virtio_gpu_get_vgdev(struct ttm_bo_device *bdev)
>  {
> diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_drv.c b/drivers/gpu/drm/vmwg=
fx/vmwgfx_drv.c
> index 4638f6791cda..e72edc68255d 100644
> --- a/drivers/gpu/drm/vmwgfx/vmwgfx_drv.c
> +++ b/drivers/gpu/drm/vmwgfx/vmwgfx_drv.c
> @@ -868,7 +868,7 @@ static int vmw_driver_load(struct drm_device *dev, =
unsigned long chipset)
>  	ret =3D ttm_bo_device_init(&dev_priv->bdev,
>  				 &vmw_bo_driver,
>  				 dev->anon_inode->i_mapping,
> -				 VMWGFX_FILE_PAGE_OFFSET,
> +				 DRM_FILE_PAGE_OFFSET,
>  				 false);
>  	if (unlikely(ret !=3D 0)) {
>  		DRM_ERROR("Failed initializing TTM buffer object driver.\n");
> diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_drv.h b/drivers/gpu/drm/vmwg=
fx/vmwgfx_drv.h
> index accb2fafe2f1..6302c12c2298 100644
> --- a/drivers/gpu/drm/vmwgfx/vmwgfx_drv.h
> +++ b/drivers/gpu/drm/vmwgfx/vmwgfx_drv.h
> @@ -48,7 +48,6 @@
>  #define VMWGFX_DRIVER_MAJOR 2
>  #define VMWGFX_DRIVER_MINOR 15
>  #define VMWGFX_DRIVER_PATCHLEVEL 0
> -#define VMWGFX_FILE_PAGE_OFFSET 0x00100000
>  #define VMWGFX_FIFO_STATIC_SIZE (1024*1024)
>  #define VMWGFX_MAX_RELOCATIONS 2048
>  #define VMWGFX_MAX_VALIDATIONS 2048
> diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_ttm_glue.c b/drivers/gpu/drm=
/vmwgfx/vmwgfx_ttm_glue.c
> index e6d75e377dd8..ec5b4b237f2c 100644
> --- a/drivers/gpu/drm/vmwgfx/vmwgfx_ttm_glue.c
> +++ b/drivers/gpu/drm/vmwgfx/vmwgfx_ttm_glue.c
> @@ -33,7 +33,7 @@ int vmw_mmap(struct file *filp, struct vm_area_struct=
 *vma)
>  	struct drm_file *file_priv;
>  	struct vmw_private *dev_priv;
> =20
> -	if (unlikely(vma->vm_pgoff < VMWGFX_FILE_PAGE_OFFSET)) {
> +	if (unlikely(vma->vm_pgoff < DRM_FILE_PAGE_OFFSET)) {
>  		DRM_ERROR("Illegal attempt to mmap old fifo space.\n");
>  		return -EINVAL;
>  	}
> diff --git a/drivers/staging/vboxvideo/vbox_drv.h b/drivers/staging/vbo=
xvideo/vbox_drv.h
> index eba5a8bc9cea..77f2a4e9000e 100644
> --- a/drivers/staging/vboxvideo/vbox_drv.h
> +++ b/drivers/staging/vboxvideo/vbox_drv.h
> @@ -209,8 +209,6 @@ int vbox_dumb_mmap_offset(struct drm_file *file,
>  			  struct drm_device *dev,
>  			  u32 handle, u64 *offset);
> =20
> -#define DRM_FILE_PAGE_OFFSET (0x100000000ULL >> PAGE_SHIFT)
> -
>  int vbox_mm_init(struct vbox_private *vbox);
>  void vbox_mm_fini(struct vbox_private *vbox);
> =20
> diff --git a/include/drm/ttm/ttm_bo_driver.h b/include/drm/ttm/ttm_bo_d=
river.h
> index cbf3180cb612..c0bed72492f3 100644
> --- a/include/drm/ttm/ttm_bo_driver.h
> +++ b/include/drm/ttm/ttm_bo_driver.h
> @@ -49,6 +49,8 @@
>  #define TTM_MEMTYPE_FLAG_MAPPABLE      (1 << 1)	/* Memory mappable */
>  #define TTM_MEMTYPE_FLAG_CMA           (1 << 3)	/* Can't map aperture =
*/
> =20
> +#define DRM_FILE_PAGE_OFFSET (0x100000000ULL >> PAGE_SHIFT)
> +
>  struct ttm_mem_type_manager;
> =20
>  struct ttm_mem_type_manager_func {
>=20

--=20
Thomas Zimmermann
Graphics Driver Developer
SUSE Linux GmbH, Maxfeldstr. 5, D-90409 N=C3=BCrnberg
Tel: +49-911-74053-0; Fax: +49-911-7417755;  https://www.suse.com/
SUSE Linux GmbH, GF: Felix Imend=C3=B6rffer, Jane Smithard,
Graham Norton, HRB 21284 (AG N=C3=BCrnberg)


--6xaGRjBYpy157oY1Sv7sRAk5K5Vvu1yGp--

--WRy2CCyR0ZJ3NDjDzcg4ziVmLtqgbGWlw
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEchf7rIzpz2NEoWjlaA3BHVMLeiMFAlxb/yEACgkQaA3BHVML
eiMZTAf/WVjtdxHGw5GfJPuKC20oBTLBFHj/Ev3cs0U6y7L/JS9D3mA5octmzX2E
Foxij//a/cJDSOlHSLCI/NHWIRxctOYdiXUWKcuKd3A/gErMLiTTy3RZ7j/n7GVd
4WYyhY1gvVHQWvWWnphoAjxbjzdDBbNk0tQzpMrarO76KItI2BwJ89NztOfTVU1s
WFhVb2AbtExeQI7vaFdTNN8mOu/VykfEZqPlIJGHyMG6w6yuqUlmxlOiLOpWgedF
AF9wjXccunQeUz87PS3wk/U7uiCcBiqsh4IAFBcWaycYbB4MeyvhpHLIjgd9M4c7
HfnMulDfwHpnz/iJqVd8yqHLExSzPA==
=U5bX
-----END PGP SIGNATURE-----

--WRy2CCyR0ZJ3NDjDzcg4ziVmLtqgbGWlw--

--===============1459668597==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KZHJpLWRldmVs
IG1haWxpbmcgbGlzdApkcmktZGV2ZWxAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlz
dHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vZHJpLWRldmVsCg==

--===============1459668597==--
