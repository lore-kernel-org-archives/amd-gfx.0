From: Thomas Zimmermann <tzimmermann-l3A5Bk7waGM@public.gmane.org>
Subject: Re: [PATCH 1/5] drm/ttm: use a static ttm_mem_global instance
Date: Tue, 23 Oct 2018 08:22:52 +0200
Message-ID: <c037580b-924c-e932-e0ea-6e1682b53053@suse.de>
References: <20181019164138.32993-1-christian.koenig@amd.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0555421932=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <20181019164138.32993-1-christian.koenig-5C7GfCeVMHo@public.gmane.org>
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
To: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--===============0555421932==
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="7Tr2uLv72HP5OBr75UTYenkS5dngpWD6K"

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--7Tr2uLv72HP5OBr75UTYenkS5dngpWD6K
Content-Type: multipart/mixed; boundary="4ONVUrhqGzwTg7LK1vAaw9pdvrJUKYeBB";
 protected-headers="v1"
From: Thomas Zimmermann <tzimmermann-l3A5Bk7waGM@public.gmane.org>
To: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
 dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Message-ID: <c037580b-924c-e932-e0ea-6e1682b53053-l3A5Bk7waGM@public.gmane.org>
Subject: Re: [PATCH 1/5] drm/ttm: use a static ttm_mem_global instance
References: <20181019164138.32993-1-christian.koenig-5C7GfCeVMHo@public.gmane.org>
In-Reply-To: <20181019164138.32993-1-christian.koenig-5C7GfCeVMHo@public.gmane.org>

--4ONVUrhqGzwTg7LK1vAaw9pdvrJUKYeBB
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

Hi Christian

Am 19.10.18 um 18:41 schrieb Christian K=C3=B6nig:
> As the name says we only need one global instance of ttm_mem_global.
>=20
> Drop all the driver initialization and just use a single exported
> instance which is initialized during BO global initialization.
>=20
> Signed-off-by: Christian K=C3=B6nig <christian.koenig-5C7GfCeVMHo@public.gmane.org>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c         | 44 -----------------=
--------
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h         |  1 -
>  drivers/gpu/drm/ast/ast_drv.h                   |  1 -
>  drivers/gpu/drm/ast/ast_ttm.c                   | 32 ++---------------=
-
>  drivers/gpu/drm/bochs/bochs.h                   |  1 -
>  drivers/gpu/drm/bochs/bochs_mm.c                | 30 ++---------------=

>  drivers/gpu/drm/cirrus/cirrus_drv.h             |  1 -
>  drivers/gpu/drm/cirrus/cirrus_ttm.c             | 32 ++---------------=
-
>  drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.h |  1 -
>  drivers/gpu/drm/hisilicon/hibmc/hibmc_ttm.c     | 31 +++--------------=

>  drivers/gpu/drm/mgag200/mgag200_drv.h           |  1 -
>  drivers/gpu/drm/mgag200/mgag200_ttm.c           | 32 ++---------------=
-
>  drivers/gpu/drm/nouveau/nouveau_drv.h           |  1 -
>  drivers/gpu/drm/nouveau/nouveau_ttm.c           | 34 ++---------------=
--
>  drivers/gpu/drm/qxl/qxl_drv.h                   |  1 -
>  drivers/gpu/drm/qxl/qxl_ttm.c                   | 28 ----------------
>  drivers/gpu/drm/radeon/radeon.h                 |  1 -
>  drivers/gpu/drm/radeon/radeon_ttm.c             | 26 ---------------
>  drivers/gpu/drm/ttm/ttm_bo.c                    | 10 ++++--
>  drivers/gpu/drm/ttm/ttm_memory.c                |  5 +--
>  drivers/gpu/drm/virtio/virtgpu_drv.h            |  1 -
>  drivers/gpu/drm/virtio/virtgpu_ttm.c            | 27 ---------------
>  drivers/gpu/drm/vmwgfx/vmwgfx_drv.c             |  4 +--
>  drivers/gpu/drm/vmwgfx/vmwgfx_drv.h             |  3 +-
>  drivers/gpu/drm/vmwgfx/vmwgfx_ttm_glue.c        | 27 ---------------
>  drivers/staging/vboxvideo/vbox_drv.h            |  1 -
>  drivers/staging/vboxvideo/vbox_ttm.c            | 24 --------------
>  include/drm/ttm/ttm_bo_driver.h                 |  8 ++---
>  include/drm/ttm/ttm_memory.h                    |  4 +--
>  29 files changed, 32 insertions(+), 380 deletions(-)

Great that you removed all the global TTM state from all the drivers.
This removes a lot of duplication and simplifies driver development a bit=
=2E


> diff --git a/drivers/gpu/drm/ttm/ttm_bo.c b/drivers/gpu/drm/ttm/ttm_bo.=
c
> index 9edece6510d3..3006050b1720 100644
> --- a/drivers/gpu/drm/ttm/ttm_bo.c
> +++ b/drivers/gpu/drm/ttm/ttm_bo.c
> @@ -1526,18 +1526,22 @@ void ttm_bo_global_release(struct ttm_bo_global=
 *glob)
>  {
>  	kobject_del(&glob->kobj);
>  	kobject_put(&glob->kobj);
> +	ttm_mem_global_release(&ttm_mem_glob);
>  }
>  EXPORT_SYMBOL(ttm_bo_global_release);
> =20
> -int ttm_bo_global_init(struct ttm_bo_global *glob,
> -		       struct ttm_mem_global *mem_glob)
> +int ttm_bo_global_init(struct ttm_bo_global *glob)
>  {
>  	int ret;
>  	unsigned i;
> =20
> +	ret =3D ttm_mem_global_init(&ttm_mem_glob);
> +	if (ret)
> +		return ret;
> +

What I really dislike about this patch set is that it mixes state and
implementation into that same functions. The original code had a fairly
good separation of both. Now the mechanisms and policies are located in
the same places.[^1]

This looks like a simplification, but from my experience, such code is a
setup for long-term maintenance problems. For example, I can imagine
that someone at some point wants multiple global buffers (e.g., on a
NUMA-like architecture).

I understand that I'm new here, have no say, and probably don't get the
big picture, but from my point of view, this is not a forward-thinking
change.

Best regards
Thomas

[^1] More philosophically speaking, program state can be global, but
data structures can only be share-able. ttm_mem_global and ttm_bo_global
should be renamed to something like ttm_shared_mem, rsp. ttm_shared_bo.


>  	mutex_init(&glob->device_list_mutex);
>  	spin_lock_init(&glob->lru_lock);
> -	glob->mem_glob =3D mem_glob;
> +	glob->mem_glob =3D &ttm_mem_glob;
>  	glob->mem_glob->bo_glob =3D glob;
>  	glob->dummy_read_page =3D alloc_page(__GFP_ZERO | GFP_DMA32);
> =20
> diff --git a/drivers/gpu/drm/ttm/ttm_memory.c b/drivers/gpu/drm/ttm/ttm=
_memory.c
> index 450387c92b63..7704e17c402f 100644
> --- a/drivers/gpu/drm/ttm/ttm_memory.c
> +++ b/drivers/gpu/drm/ttm/ttm_memory.c
> @@ -41,6 +41,9 @@
> =20
>  #define TTM_MEMORY_ALLOC_RETRIES 4
> =20
> +struct ttm_mem_global ttm_mem_glob;
> +EXPORT_SYMBOL(ttm_mem_glob);
> +
>  struct ttm_mem_zone {
>  	struct kobject kobj;
>  	struct ttm_mem_global *glob;
> @@ -464,7 +467,6 @@ int ttm_mem_global_init(struct ttm_mem_global *glob=
)
>  	ttm_mem_global_release(glob);
>  	return ret;
>  }
> -EXPORT_SYMBOL(ttm_mem_global_init);
> =20
>  void ttm_mem_global_release(struct ttm_mem_global *glob)
>  {
> @@ -486,7 +488,6 @@ void ttm_mem_global_release(struct ttm_mem_global *=
glob)
>  	kobject_del(&glob->kobj);
>  	kobject_put(&glob->kobj);
>  }
> -EXPORT_SYMBOL(ttm_mem_global_release);
> =20
>  static void ttm_check_swapping(struct ttm_mem_global *glob)
>  {
> diff --git a/drivers/gpu/drm/virtio/virtgpu_drv.h b/drivers/gpu/drm/vir=
tio/virtgpu_drv.h
> index 65605e207bbe..dec42d421e00 100644
> --- a/drivers/gpu/drm/virtio/virtgpu_drv.h
> +++ b/drivers/gpu/drm/virtio/virtgpu_drv.h
> @@ -133,7 +133,6 @@ struct virtio_gpu_framebuffer {
> =20
>  struct virtio_gpu_mman {
>  	struct ttm_bo_global_ref        bo_global_ref;
> -	struct drm_global_reference	mem_global_ref;
>  	bool				mem_global_referenced;
>  	struct ttm_bo_device		bdev;
>  };
> diff --git a/drivers/gpu/drm/virtio/virtgpu_ttm.c b/drivers/gpu/drm/vir=
tio/virtgpu_ttm.c
> index 0ec46b47b423..b99ecc6d97d3 100644
> --- a/drivers/gpu/drm/virtio/virtgpu_ttm.c
> +++ b/drivers/gpu/drm/virtio/virtgpu_ttm.c
> @@ -50,37 +50,12 @@ virtio_gpu_device *virtio_gpu_get_vgdev(struct ttm_=
bo_device *bdev)
>  	return vgdev;
>  }
> =20
> -static int virtio_gpu_ttm_mem_global_init(struct drm_global_reference =
*ref)
> -{
> -	return ttm_mem_global_init(ref->object);
> -}
> -
> -static void virtio_gpu_ttm_mem_global_release(struct drm_global_refere=
nce *ref)
> -{
> -	ttm_mem_global_release(ref->object);
> -}
> -
>  static int virtio_gpu_ttm_global_init(struct virtio_gpu_device *vgdev)=

>  {
>  	struct drm_global_reference *global_ref;
>  	int r;
> =20
>  	vgdev->mman.mem_global_referenced =3D false;
> -	global_ref =3D &vgdev->mman.mem_global_ref;
> -	global_ref->global_type =3D DRM_GLOBAL_TTM_MEM;
> -	global_ref->size =3D sizeof(struct ttm_mem_global);
> -	global_ref->init =3D &virtio_gpu_ttm_mem_global_init;
> -	global_ref->release =3D &virtio_gpu_ttm_mem_global_release;
> -
> -	r =3D drm_global_item_ref(global_ref);
> -	if (r !=3D 0) {
> -		DRM_ERROR("Failed setting up TTM memory accounting "
> -			  "subsystem.\n");
> -		return r;
> -	}
> -
> -	vgdev->mman.bo_global_ref.mem_glob =3D
> -		vgdev->mman.mem_global_ref.object;
>  	global_ref =3D &vgdev->mman.bo_global_ref.ref;
>  	global_ref->global_type =3D DRM_GLOBAL_TTM_BO;
>  	global_ref->size =3D sizeof(struct ttm_bo_global);
> @@ -89,7 +64,6 @@ static int virtio_gpu_ttm_global_init(struct virtio_g=
pu_device *vgdev)
>  	r =3D drm_global_item_ref(global_ref);
>  	if (r !=3D 0) {
>  		DRM_ERROR("Failed setting up TTM BO subsystem.\n");
> -		drm_global_item_unref(&vgdev->mman.mem_global_ref);
>  		return r;
>  	}
> =20
> @@ -101,7 +75,6 @@ static void virtio_gpu_ttm_global_fini(struct virtio=
_gpu_device *vgdev)
>  {
>  	if (vgdev->mman.mem_global_referenced) {
>  		drm_global_item_unref(&vgdev->mman.bo_global_ref.ref);
> -		drm_global_item_unref(&vgdev->mman.mem_global_ref);
>  		vgdev->mman.mem_global_referenced =3D false;
>  	}
>  }
> diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_drv.c b/drivers/gpu/drm/vmwg=
fx/vmwgfx_drv.c
> index bb6dbbe18835..57df776d987c 100644
> --- a/drivers/gpu/drm/vmwgfx/vmwgfx_drv.c
> +++ b/drivers/gpu/drm/vmwgfx/vmwgfx_drv.c
> @@ -828,8 +828,8 @@ static int vmw_driver_load(struct drm_device *dev, =
unsigned long chipset)
>  		goto out_err4;
>  	}
> =20
> -	dev_priv->tdev =3D ttm_object_device_init
> -		(dev_priv->mem_global_ref.object, 12, &vmw_prime_dmabuf_ops);
> +	dev_priv->tdev =3D ttm_object_device_init(&ttm_mem_glob, 12,
> +						&vmw_prime_dmabuf_ops);
> =20
>  	if (unlikely(dev_priv->tdev =3D=3D NULL)) {
>  		DRM_ERROR("Unable to initialize TTM object management.\n");
> diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_drv.h b/drivers/gpu/drm/vmwg=
fx/vmwgfx_drv.h
> index 1abe21758b0d..df15a745efc3 100644
> --- a/drivers/gpu/drm/vmwgfx/vmwgfx_drv.h
> +++ b/drivers/gpu/drm/vmwgfx/vmwgfx_drv.h
> @@ -366,7 +366,6 @@ enum {
>  struct vmw_private {
>  	struct ttm_bo_device bdev;
>  	struct ttm_bo_global_ref bo_global_ref;
> -	struct drm_global_reference mem_global_ref;
> =20
>  	struct vmw_fifo_state fifo;
> =20
> @@ -1288,7 +1287,7 @@ vmw_bo_reference(struct vmw_buffer_object *buf)
> =20
>  static inline struct ttm_mem_global *vmw_mem_glob(struct vmw_private *=
dev_priv)
>  {
> -	return (struct ttm_mem_global *) dev_priv->mem_global_ref.object;
> +	return &ttm_mem_glob;
>  }
> =20
>  static inline void vmw_fifo_resource_inc(struct vmw_private *dev_priv)=

> diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_ttm_glue.c b/drivers/gpu/drm=
/vmwgfx/vmwgfx_ttm_glue.c
> index f3ce43c41978..0ac473cd5136 100644
> --- a/drivers/gpu/drm/vmwgfx/vmwgfx_ttm_glue.c
> +++ b/drivers/gpu/drm/vmwgfx/vmwgfx_ttm_glue.c
> @@ -43,36 +43,11 @@ int vmw_mmap(struct file *filp, struct vm_area_stru=
ct *vma)
>  	return ttm_bo_mmap(filp, vma, &dev_priv->bdev);
>  }
> =20
> -static int vmw_ttm_mem_global_init(struct drm_global_reference *ref)
> -{
> -	DRM_INFO("global init.\n");
> -	return ttm_mem_global_init(ref->object);
> -}
> -
> -static void vmw_ttm_mem_global_release(struct drm_global_reference *re=
f)
> -{
> -	ttm_mem_global_release(ref->object);
> -}
> -
>  int vmw_ttm_global_init(struct vmw_private *dev_priv)
>  {
>  	struct drm_global_reference *global_ref;
>  	int ret;
> =20
> -	global_ref =3D &dev_priv->mem_global_ref;
> -	global_ref->global_type =3D DRM_GLOBAL_TTM_MEM;
> -	global_ref->size =3D sizeof(struct ttm_mem_global);
> -	global_ref->init =3D &vmw_ttm_mem_global_init;
> -	global_ref->release =3D &vmw_ttm_mem_global_release;
> -
> -	ret =3D drm_global_item_ref(global_ref);
> -	if (unlikely(ret !=3D 0)) {
> -		DRM_ERROR("Failed setting up TTM memory accounting.\n");
> -		return ret;
> -	}
> -
> -	dev_priv->bo_global_ref.mem_glob =3D
> -		dev_priv->mem_global_ref.object;
>  	global_ref =3D &dev_priv->bo_global_ref.ref;
>  	global_ref->global_type =3D DRM_GLOBAL_TTM_BO;
>  	global_ref->size =3D sizeof(struct ttm_bo_global);
> @@ -87,12 +62,10 @@ int vmw_ttm_global_init(struct vmw_private *dev_pri=
v)
> =20
>  	return 0;
>  out_no_bo:
> -	drm_global_item_unref(&dev_priv->mem_global_ref);
>  	return ret;
>  }
> =20
>  void vmw_ttm_global_release(struct vmw_private *dev_priv)
>  {
>  	drm_global_item_unref(&dev_priv->bo_global_ref.ref);
> -	drm_global_item_unref(&dev_priv->mem_global_ref);
>  }
> diff --git a/drivers/staging/vboxvideo/vbox_drv.h b/drivers/staging/vbo=
xvideo/vbox_drv.h
> index 594f84272957..41f760b77704 100644
> --- a/drivers/staging/vboxvideo/vbox_drv.h
> +++ b/drivers/staging/vboxvideo/vbox_drv.h
> @@ -95,7 +95,6 @@ struct vbox_private {
>  	int fb_mtrr;
> =20
>  	struct {
> -		struct drm_global_reference mem_global_ref;
>  		struct ttm_bo_global_ref bo_global_ref;
>  		struct ttm_bo_device bdev;
>  	} ttm;
> diff --git a/drivers/staging/vboxvideo/vbox_ttm.c b/drivers/staging/vbo=
xvideo/vbox_ttm.c
> index 2329a55d4636..88cdacf2b0f0 100644
> --- a/drivers/staging/vboxvideo/vbox_ttm.c
> +++ b/drivers/staging/vboxvideo/vbox_ttm.c
> @@ -35,16 +35,6 @@ static inline struct vbox_private *vbox_bdev(struct =
ttm_bo_device *bd)
>  	return container_of(bd, struct vbox_private, ttm.bdev);
>  }
> =20
> -static int vbox_ttm_mem_global_init(struct drm_global_reference *ref)
> -{
> -	return ttm_mem_global_init(ref->object);
> -}
> -
> -static void vbox_ttm_mem_global_release(struct drm_global_reference *r=
ef)
> -{
> -	ttm_mem_global_release(ref->object);
> -}
> -
>  /**
>   * Adds the vbox memory manager object/structures to the global memory=
 manager.
>   */
> @@ -53,18 +43,6 @@ static int vbox_ttm_global_init(struct vbox_private =
*vbox)
>  	struct drm_global_reference *global_ref;
>  	int ret;
> =20
> -	global_ref =3D &vbox->ttm.mem_global_ref;
> -	global_ref->global_type =3D DRM_GLOBAL_TTM_MEM;
> -	global_ref->size =3D sizeof(struct ttm_mem_global);
> -	global_ref->init =3D &vbox_ttm_mem_global_init;
> -	global_ref->release =3D &vbox_ttm_mem_global_release;
> -	ret =3D drm_global_item_ref(global_ref);
> -	if (ret) {
> -		DRM_ERROR("Failed setting up TTM memory subsystem.\n");
> -		return ret;
> -	}
> -
> -	vbox->ttm.bo_global_ref.mem_glob =3D vbox->ttm.mem_global_ref.object;=

>  	global_ref =3D &vbox->ttm.bo_global_ref.ref;
>  	global_ref->global_type =3D DRM_GLOBAL_TTM_BO;
>  	global_ref->size =3D sizeof(struct ttm_bo_global);
> @@ -74,7 +52,6 @@ static int vbox_ttm_global_init(struct vbox_private *=
vbox)
>  	ret =3D drm_global_item_ref(global_ref);
>  	if (ret) {
>  		DRM_ERROR("Failed setting up TTM BO subsystem.\n");
> -		drm_global_item_unref(&vbox->ttm.mem_global_ref);
>  		return ret;
>  	}
> =20
> @@ -87,7 +64,6 @@ static int vbox_ttm_global_init(struct vbox_private *=
vbox)
>  static void vbox_ttm_global_release(struct vbox_private *vbox)
>  {
>  	drm_global_item_unref(&vbox->ttm.bo_global_ref.ref);
> -	drm_global_item_unref(&vbox->ttm.mem_global_ref);
>  }
> =20
>  static void vbox_bo_ttm_destroy(struct ttm_buffer_object *tbo)
> diff --git a/include/drm/ttm/ttm_bo_driver.h b/include/drm/ttm/ttm_bo_d=
river.h
> index c6ee07d10281..4ae6fc33f761 100644
> --- a/include/drm/ttm/ttm_bo_driver.h
> +++ b/include/drm/ttm/ttm_bo_driver.h
> @@ -570,8 +570,7 @@ void ttm_bo_mem_put_locked(struct ttm_buffer_object=
 *bo,
>  			   struct ttm_mem_reg *mem);
> =20
>  void ttm_bo_global_release(struct ttm_bo_global *glob);
> -int ttm_bo_global_init(struct ttm_bo_global *glob,
> -		       struct ttm_mem_global *mem_glob);
> +int ttm_bo_global_init(struct ttm_bo_global *glob);
> =20
>  int ttm_bo_device_release(struct ttm_bo_device *bdev);
> =20
> @@ -895,7 +894,6 @@ extern const struct ttm_mem_type_manager_func ttm_b=
o_manager_func;
> =20
>  struct ttm_bo_global_ref {
>  	struct drm_global_reference ref;
> -	struct ttm_mem_global *mem_glob;
>  };
> =20
>  /**
> @@ -909,9 +907,7 @@ struct ttm_bo_global_ref {
>   */
>  static inline int ttm_bo_global_ref_init(struct drm_global_reference *=
ref)
>  {
> -	struct ttm_bo_global_ref *bo_ref =3D
> -		container_of(ref, struct ttm_bo_global_ref, ref);
> -	return ttm_bo_global_init(ref->object, bo_ref->mem_glob);
> +	return ttm_bo_global_init(ref->object);
>  }
> =20
>  /**
> diff --git a/include/drm/ttm/ttm_memory.h b/include/drm/ttm/ttm_memory.=
h
> index 737b5fed8003..3ff48a0a2d7b 100644
> --- a/include/drm/ttm/ttm_memory.h
> +++ b/include/drm/ttm/ttm_memory.h
> @@ -63,7 +63,7 @@
> =20
>  #define TTM_MEM_MAX_ZONES 2
>  struct ttm_mem_zone;
> -struct ttm_mem_global {
> +extern struct ttm_mem_global {
>  	struct kobject kobj;
>  	struct ttm_bo_global *bo_glob;
>  	struct workqueue_struct *swap_queue;
> @@ -78,7 +78,7 @@ struct ttm_mem_global {
>  #else
>  	struct ttm_mem_zone *zone_dma32;
>  #endif
> -};
> +} ttm_mem_glob;
> =20
>  extern int ttm_mem_global_init(struct ttm_mem_global *glob);
>  extern void ttm_mem_global_release(struct ttm_mem_global *glob);
>=20

--=20
Thomas Zimmermann
Graphics Driver Developer
SUSE Linux GmbH, Maxfeldstr. 5, D-90409 N=C3=BCrnberg
Tel: +49-911-74053-0; Fax: +49-911-7417755;  https://www.suse.com/
SUSE Linux GmbH, GF: Felix Imend=C3=B6rffer, Jane Smithard,
Graham Norton, HRB 21284 (AG N=C3=BCrnberg)


--4ONVUrhqGzwTg7LK1vAaw9pdvrJUKYeBB--

--7Tr2uLv72HP5OBr75UTYenkS5dngpWD6K
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEchf7rIzpz2NEoWjlaA3BHVMLeiMFAlvOvkAACgkQaA3BHVML
eiMSmQf9GvS1SpbTD1ohMGM9AB/tOkGROFSepy4yghZ5nc1yg7srw84dlpiPcJ2t
fCZvKLn3GxEkIekT30TNObmGu0UexQg6XzH4qyttEMTFWJg81AqOy87G6Ii+Wmn9
rUuIenlmvs3tkuQHfBjzDvLRl7KM0eTZ+yInUGSWnQme1PaH6z6O7K8g8NPQ+bE5
rw158ZgHveNfDRyo5BHn3oUjsYHABkAgsH6CMROz/J0+VCLxm6tDLfWzYTW8a0MH
/Bet0MHFGNmd/xX+zoXVmbePtAYK0niKBHpoSi+czBPUNmg0F8sJlYhETe6lpYBR
UqpO8ijVhpJrmo2P+QjkyT1Pgiw2TQ==
=Ks1e
-----END PGP SIGNATURE-----

--7Tr2uLv72HP5OBr75UTYenkS5dngpWD6K--

--===============0555421932==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============0555421932==--
