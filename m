From: Jason Ekstrand <jason@jlekstrand.net>
Subject: Re: [PATCH 1/5] drm: introduce sync objects (v3)
Date: Wed, 24 May 2017 10:34:09 -0700
Message-ID: <CAOFGe96LN+Hwyhq-yE4crwOi6N=-9keG=odJ+cQfvwcPUfwmbA@mail.gmail.com>
References: <20170524070615.1634-1-airlied@gmail.com>
 <20170524070615.1634-2-airlied@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0063236864=="
Return-path: <dri-devel-bounces@lists.freedesktop.org>
In-Reply-To: <20170524070615.1634-2-airlied@gmail.com>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
To: Dave Airlie <airlied@gmail.com>
Cc: amd-gfx mailing list <amd-gfx@lists.freedesktop.org>, Maling list - DRI developers <dri-devel@lists.freedesktop.org>
List-Id: amd-gfx.lists.freedesktop.org

--===============0063236864==
Content-Type: multipart/alternative; boundary="94eb2c1b53660e5a62055048830e"

--94eb2c1b53660e5a62055048830e
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

I can't really review for all of the kernel details (though the seem ok to
me) so this mostly applies to the API:

Reviewed-by: Jason Ekstrand <jason@jlekstrand.net>

On Wed, May 24, 2017 at 12:06 AM, Dave Airlie <airlied@gmail.com> wrote:

> From: Dave Airlie <airlied@redhat.com>
>
> Sync objects are new toplevel drm object, that contain a
> pointer to a fence. This fence can be updated via command
> submission ioctls via drivers.
>
> There is also a generic wait obj API modelled on the vulkan
> wait API (with code modelled on some amdgpu code).
>
> These objects can be converted to an opaque fd that can be
> passes between processes.
>
> v2: rename reference/unreference to put/get (Chris)
> fix leaked reference (David Zhou)
> drop mutex in favour of cmpxchg (Chris)
> v3: cleanups from danvet, rebase on drm_fops rename
> check fd_flags is 0 in ioctls.
>
> Reviewed-by: Sean Paul <seanpaul@chromium.org>
> Signed-off-by: Dave Airlie <airlied@redhat.com>
> ---
>  Documentation/gpu/drm-internals.rst |   3 +
>  Documentation/gpu/drm-mm.rst        |  12 ++
>  drivers/gpu/drm/Makefile            |   2 +-
>  drivers/gpu/drm/drm_file.c          |   8 +
>  drivers/gpu/drm/drm_internal.h      |  13 ++
>  drivers/gpu/drm/drm_ioctl.c         |  12 ++
>  drivers/gpu/drm/drm_syncobj.c       | 377 ++++++++++++++++++++++++++++++
> ++++++
>  include/drm/drmP.h                  |   1 -
>  include/drm/drm_drv.h               |   1 +
>  include/drm/drm_file.h              |   5 +
>  include/drm/drm_syncobj.h           |  87 +++++++++
>  include/uapi/drm/drm.h              |  24 +++
>  12 files changed, 543 insertions(+), 2 deletions(-)
>  create mode 100644 drivers/gpu/drm/drm_syncobj.c
>  create mode 100644 include/drm/drm_syncobj.h
>
> diff --git a/Documentation/gpu/drm-internals.rst b/Documentation/gpu/drm-
> internals.rst
> index babfb61..2b23d78 100644
> --- a/Documentation/gpu/drm-internals.rst
> +++ b/Documentation/gpu/drm-internals.rst
> @@ -98,6 +98,9 @@ DRIVER_ATOMIC
>      implement appropriate obj->atomic_get_property() vfuncs for any
>      modeset objects with driver specific properties.
>
> +DRIVER_SYNCOBJ
> +    Driver support drm sync objects.
> +
>  Major, Minor and Patchlevel
>  ~~~~~~~~~~~~~~~~~~~~~~~~~~~
>
> diff --git a/Documentation/gpu/drm-mm.rst b/Documentation/gpu/drm-mm.rst
> index 96b9c34..9412798 100644
> --- a/Documentation/gpu/drm-mm.rst
> +++ b/Documentation/gpu/drm-mm.rst
> @@ -484,3 +484,15 @@ DRM Cache Handling
>
>  .. kernel-doc:: drivers/gpu/drm/drm_cache.c
>     :export:
> +
> +DRM Sync Objects
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D
> +
> +.. kernel-doc:: drivers/gpu/drm/drm_syncobj.c
> +   :doc: Overview
> +
> +.. kernel-doc:: include/drm/drm_syncobj.h
> +   :export:
> +
> +.. kernel-doc:: drivers/gpu/drm/drm_syncobj.c
> +   :export:
> diff --git a/drivers/gpu/drm/Makefile b/drivers/gpu/drm/Makefile
> index 59f0f9b..6f42188 100644
> --- a/drivers/gpu/drm/Makefile
> +++ b/drivers/gpu/drm/Makefile
> @@ -16,7 +16,7 @@ drm-y       :=3D        drm_auth.o drm_bufs.o drm_cache=
.o \
>                 drm_framebuffer.o drm_connector.o drm_blend.o \
>                 drm_encoder.o drm_mode_object.o drm_property.o \
>                 drm_plane.o drm_color_mgmt.o drm_print.o \
> -               drm_dumb_buffers.o drm_mode_config.o
> +               drm_dumb_buffers.o drm_mode_config.o drm_syncobj.o
>
>  drm-$(CONFIG_DRM_LIB_RANDOM) +=3D lib/drm_random.o
>  drm-$(CONFIG_DRM_VM) +=3D drm_vm.o
> diff --git a/drivers/gpu/drm/drm_file.c b/drivers/gpu/drm/drm_file.c
> index 3783b65..a20d6a9 100644
> --- a/drivers/gpu/drm/drm_file.c
> +++ b/drivers/gpu/drm/drm_file.c
> @@ -229,6 +229,9 @@ static int drm_open_helper(struct file *filp, struct
> drm_minor *minor)
>         if (drm_core_check_feature(dev, DRIVER_GEM))
>                 drm_gem_open(dev, priv);
>
> +       if (drm_core_check_feature(dev, DRIVER_SYNCOBJ))
> +               drm_syncobj_open(priv);
> +
>         if (drm_core_check_feature(dev, DRIVER_PRIME))
>                 drm_prime_init_file_private(&priv->prime);
>
> @@ -276,6 +279,8 @@ static int drm_open_helper(struct file *filp, struct
> drm_minor *minor)
>  out_prime_destroy:
>         if (drm_core_check_feature(dev, DRIVER_PRIME))
>                 drm_prime_destroy_file_private(&priv->prime);
> +       if (drm_core_check_feature(dev, DRIVER_SYNCOBJ))
> +               drm_syncobj_release(priv);
>         if (drm_core_check_feature(dev, DRIVER_GEM))
>                 drm_gem_release(dev, priv);
>         put_pid(priv->pid);
> @@ -398,6 +403,9 @@ int drm_release(struct inode *inode, struct file *fil=
p)
>                 drm_property_destroy_user_blobs(dev, file_priv);
>         }
>
> +       if (drm_core_check_feature(dev, DRIVER_SYNCOBJ))
> +               drm_syncobj_release(file_priv);
> +
>         if (drm_core_check_feature(dev, DRIVER_GEM))
>                 drm_gem_release(dev, file_priv);
>
> diff --git a/drivers/gpu/drm/drm_internal.h b/drivers/gpu/drm/drm_
> internal.h
> index 3d8e8f8..3fdef2c 100644
> --- a/drivers/gpu/drm/drm_internal.h
> +++ b/drivers/gpu/drm/drm_internal.h
> @@ -142,4 +142,17 @@ static inline int drm_debugfs_crtc_crc_add(struct
> drm_crtc *crtc)
>  {
>         return 0;
>  }
> +
>  #endif
> +
> +/* drm_syncobj.c */
> +void drm_syncobj_open(struct drm_file *file_private);
> +void drm_syncobj_release(struct drm_file *file_private);
> +int drm_syncobj_create_ioctl(struct drm_device *dev, void *data,
> +                            struct drm_file *file_private);
> +int drm_syncobj_destroy_ioctl(struct drm_device *dev, void *data,
> +                             struct drm_file *file_private);
> +int drm_syncobj_handle_to_fd_ioctl(struct drm_device *dev, void *data,
> +                                  struct drm_file *file_private);
> +int drm_syncobj_fd_to_handle_ioctl(struct drm_device *dev, void *data,
> +                                  struct drm_file *file_private);
> diff --git a/drivers/gpu/drm/drm_ioctl.c b/drivers/gpu/drm/drm_ioctl.c
> index 865e3ee..f1e5681 100644
> --- a/drivers/gpu/drm/drm_ioctl.c
> +++ b/drivers/gpu/drm/drm_ioctl.c
> @@ -241,6 +241,9 @@ static int drm_getcap(struct drm_device *dev, void
> *data, struct drm_file *file_
>                 req->value |=3D dev->driver->prime_fd_to_handle ?
> DRM_PRIME_CAP_IMPORT : 0;
>                 req->value |=3D dev->driver->prime_handle_to_fd ?
> DRM_PRIME_CAP_EXPORT : 0;
>                 return 0;
> +       case DRM_CAP_SYNCOBJ:
> +               req->value =3D drm_core_check_feature(dev, DRIVER_SYNCOBJ=
);
> +               return 0;
>         }
>
>         /* Other caps only work with KMS drivers */
> @@ -645,6 +648,15 @@ static const struct drm_ioctl_desc drm_ioctls[] =3D =
{
>         DRM_IOCTL_DEF(DRM_IOCTL_MODE_ATOMIC, drm_mode_atomic_ioctl,
> DRM_MASTER|DRM_CONTROL_ALLOW|DRM_UNLOCKED),
>         DRM_IOCTL_DEF(DRM_IOCTL_MODE_CREATEPROPBLOB,
> drm_mode_createblob_ioctl, DRM_CONTROL_ALLOW|DRM_UNLOCKED),
>         DRM_IOCTL_DEF(DRM_IOCTL_MODE_DESTROYPROPBLOB,
> drm_mode_destroyblob_ioctl, DRM_CONTROL_ALLOW|DRM_UNLOCKED),
> +
> +       DRM_IOCTL_DEF(DRM_IOCTL_SYNCOBJ_CREATE, drm_syncobj_create_ioctl,
> +                     DRM_UNLOCKED|DRM_RENDER_ALLOW),
> +       DRM_IOCTL_DEF(DRM_IOCTL_SYNCOBJ_DESTROY,
> drm_syncobj_destroy_ioctl,
> +                     DRM_UNLOCKED|DRM_RENDER_ALLOW),
> +       DRM_IOCTL_DEF(DRM_IOCTL_SYNCOBJ_HANDLE_TO_FD,
> drm_syncobj_handle_to_fd_ioctl,
> +                     DRM_UNLOCKED|DRM_RENDER_ALLOW),
> +       DRM_IOCTL_DEF(DRM_IOCTL_SYNCOBJ_FD_TO_HANDLE,
> drm_syncobj_fd_to_handle_ioctl,
> +                     DRM_UNLOCKED|DRM_RENDER_ALLOW),
>  };
>
>  #define DRM_CORE_IOCTL_COUNT   ARRAY_SIZE( drm_ioctls )
> diff --git a/drivers/gpu/drm/drm_syncobj.c b/drivers/gpu/drm/drm_syncobj.=
c
> new file mode 100644
> index 0000000..b611480
> --- /dev/null
> +++ b/drivers/gpu/drm/drm_syncobj.c
> @@ -0,0 +1,377 @@
> +/*
> + * Copyright 2017 Red Hat
> + *
> + * Permission is hereby granted, free of charge, to any person obtaining=
 a
> + * copy of this software and associated documentation files (the
> "Software"),
> + * to deal in the Software without restriction, including without
> limitation
> + * the rights to use, copy, modify, merge, publish, distribute,
> sublicense,
> + * and/or sell copies of the Software, and to permit persons to whom the
> + * Software is furnished to do so, subject to the following conditions:
> + *
> + * The above copyright notice and this permission notice (including the
> next
> + * paragraph) shall be included in all copies or substantial portions of
> the
> + * Software.
> + *
> + * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
> EXPRESS OR
> + * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
> MERCHANTABILITY,
> + * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT
> SHALL
> + * THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR
> OTHER
> + * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISI=
NG
> + * FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER
> DEALINGS
> + * IN THE SOFTWARE.
> + *
> + * Authors:
> + *
> + */
> +
> +/**
> + * DOC: Overview
> + *
> + * DRM synchronisation objects (syncobj) are a persistent objects,
> + * that contain an optional fence. The fence can be updated with a new
> + * fence, or be NULL.
> + *
> + * syncobj's can be export to fd's and back, these fd's are opaque and
> + * have no other use case, except passing the syncobj between processes.
> + *
> + * Their primary use-case is to implement Vulkan fences and semaphores.
> + *
> + * syncobj have a kref reference count, but also have an optional file.
> + * The file is only created once the syncobj is exported.
> + * The file takes a reference on the kref.
> + */
> +
> +#include <drm/drmP.h>
> +#include <linux/file.h>
> +#include <linux/fs.h>
> +#include <linux/anon_inodes.h>
> +
> +#include "drm_internal.h"
> +#include <drm/drm_syncobj.h>
> +
> +static struct drm_syncobj *drm_syncobj_find(struct drm_file *file_privat=
e,
> +                                          u32 handle)
> +{
> +       struct drm_syncobj *syncobj;
> +
> +       spin_lock(&file_private->syncobj_table_lock);
> +
> +       /* Check if we currently have a reference on the object */
> +       syncobj =3D idr_find(&file_private->syncobj_idr, handle);
> +       if (syncobj)
> +               drm_syncobj_get(syncobj);
> +
> +       spin_unlock(&file_private->syncobj_table_lock);
> +
> +       return syncobj;
> +}
> +
> +/**
> + * drm_syncobj_replace_fence - lookup and replace fence in a sync object=
.
> + * @file_private - drm file private pointer.
> + * @handle - syncobj handle to lookup
> + * @fence - fence to install in sync file.
> + * Returns:
> + * 0 on success, or -EINVAL when the handle doesn't point at a valid sem
> file.
> + *
> + * This looks up a sync object and replaces the fence on it, freeing
> + * the old one.
> + */
> +int drm_syncobj_replace_fence(struct drm_file *file_private,
> +                             u32 handle,
> +                             struct dma_fence *fence)
> +{
> +       struct drm_syncobj *syncobj =3D drm_syncobj_find(file_private,
> handle);
> +       struct dma_fence *old_fence =3D NULL;
> +
> +       if (!syncobj)
> +               return -EINVAL;
> +
> +       if (fence)
> +               dma_fence_get(fence);
> +       old_fence =3D xchg(&syncobj->fence, fence);
> +
> +       dma_fence_put(old_fence);
> +       drm_syncobj_put(syncobj);
> +
> +       return 0;
> +}
> +EXPORT_SYMBOL(drm_syncobj_replace_fence);
> +
> +int drm_syncobj_fence_get(struct drm_file *file_private,
> +                         u32 handle,
> +                         struct dma_fence **fence)
> +{
> +       struct drm_syncobj *syncobj =3D drm_syncobj_find(file_private,
> handle);
> +       int ret =3D 0;
> +
> +       if (!syncobj)
> +               return -ENOENT;
> +
> +       *fence =3D dma_fence_get(syncobj->fence);
> +       if (!*fence) {
> +               ret =3D -EINVAL;
> +       }
> +       drm_syncobj_put(syncobj);
> +       return ret;
> +}
> +EXPORT_SYMBOL(drm_syncobj_fence_get);
> +
> +void drm_syncobj_free(struct kref *kref)
> +{
> +       struct drm_syncobj *syncobj =3D container_of(kref,
> +                                                  struct drm_syncobj,
> +                                                  refcount);
> +       dma_fence_put(syncobj->fence);
> +       kfree(syncobj);
> +}
> +
> +static int drm_syncobj_create(struct drm_file *file_private,
> +                             u32 *handle)
> +{
> +       int ret;
> +       struct drm_syncobj *syncobj;
> +
> +       syncobj =3D kzalloc(sizeof(struct drm_syncobj), GFP_KERNEL);
> +       if (!syncobj)
> +               return -ENOMEM;
> +
> +       kref_init(&syncobj->refcount);
> +
> +       idr_preload(GFP_KERNEL);
> +       spin_lock(&file_private->syncobj_table_lock);
> +       ret =3D idr_alloc(&file_private->syncobj_idr, syncobj, 1, 0,
> GFP_NOWAIT);
> +       spin_unlock(&file_private->syncobj_table_lock);
> +
> +       idr_preload_end();
> +
> +       if (ret < 0) {
> +               drm_syncobj_put(syncobj);
> +               return ret;
> +       }
> +
> +       *handle =3D ret;
> +       return 0;
> +}
> +
> +static int drm_syncobj_destroy(struct drm_file *file_private,
> +                              u32 handle)
> +{
> +       struct drm_syncobj *syncobj;
> +
> +       spin_lock(&file_private->syncobj_table_lock);
> +       syncobj =3D idr_remove(&file_private->syncobj_idr, handle);
> +       spin_unlock(&file_private->syncobj_table_lock);
> +
> +       if (!syncobj)
> +               return -EINVAL;
> +
> +       drm_syncobj_put(syncobj);
> +       return 0;
> +}
> +
> +static int drm_syncobj_file_release(struct inode *inode, struct file
> *file)
> +{
> +       struct drm_syncobj *syncobj =3D file->private_data;
> +
> +       drm_syncobj_put(syncobj);
> +       return 0;
> +}
> +
> +static const struct file_operations drm_syncobj_file_fops =3D {
> +       .release =3D drm_syncobj_file_release,
> +};
> +
> +static int drm_syncobj_alloc_file(struct drm_syncobj *syncobj)
> +{
> +       struct file *file =3D anon_inode_getfile("syncobj_file",
> +                                              &drm_syncobj_file_fops,
> +                                              syncobj, 0);
> +       if (IS_ERR(file))
> +               return PTR_ERR(file);
> +
> +       drm_syncobj_get(syncobj);
> +       if (cmpxchg(&syncobj->file, NULL, file)) {
> +               /* lost the race */
> +               fput(file);
> +       }
> +
> +       return 0;
> +}
> +
> +static int drm_syncobj_handle_to_fd(struct drm_file *file_private,
> +                                   u32 handle, int *p_fd)
> +{
> +       struct drm_syncobj *syncobj =3D drm_syncobj_find(file_private,
> handle);
> +       int ret;
> +       int fd;
> +
> +       if (!syncobj)
> +               return -EINVAL;
> +
> +       fd =3D get_unused_fd_flags(O_CLOEXEC);
> +       if (fd < 0) {
> +               drm_syncobj_put(syncobj);
> +               return fd;
> +       }
> +
> +       if (!syncobj->file) {
> +               ret =3D drm_syncobj_alloc_file(syncobj);
> +               if (ret)
> +                       goto out_put_fd;
> +       }
> +       fd_install(fd, syncobj->file);
> +       drm_syncobj_put(syncobj);
> +       *p_fd =3D fd;
> +       return 0;
> +out_put_fd:
> +       put_unused_fd(fd);
> +       drm_syncobj_put(syncobj);
> +       return ret;
> +}
> +
> +static struct drm_syncobj *drm_syncobj_fdget(int fd)
> +{
> +       struct file *file =3D fget(fd);
> +
> +       if (!file)
> +               return NULL;
> +       if (file->f_op !=3D &drm_syncobj_file_fops)
> +               goto err;
> +
> +       return file->private_data;
> +err:
> +       fput(file);
> +       return NULL;
> +};
> +
> +static int drm_syncobj_fd_to_handle(struct drm_file *file_private,
> +                                   int fd, u32 *handle)
> +{
> +       struct drm_syncobj *syncobj =3D drm_syncobj_fdget(fd);
> +       int ret;
> +
> +       if (!syncobj)
> +               return -EINVAL;
> +
> +       /* take a reference to put in the idr */
> +       drm_syncobj_get(syncobj);
> +
> +       idr_preload(GFP_KERNEL);
> +       spin_lock(&file_private->syncobj_table_lock);
> +       ret =3D idr_alloc(&file_private->syncobj_idr, syncobj, 1, 0,
> GFP_NOWAIT);
> +       spin_unlock(&file_private->syncobj_table_lock);
> +       idr_preload_end();
> +
> +       if (ret < 0) {
> +               fput(syncobj->file);
> +               return ret;
> +       }
> +       *handle =3D ret;
> +       return 0;
> +}
> +
> +/**
> + * drm_syncobj_open - initalizes syncobj file-private structures at
> devnode open time
> + * @dev: drm_device which is being opened by userspace
> + * @file_private: drm file-private structure to set up
> + *
> + * Called at device open time, sets up the structure for handling
> refcounting
> + * of sync objects.
> + */
> +void
> +drm_syncobj_open(struct drm_file *file_private)
> +{
> +       idr_init(&file_private->syncobj_idr);
> +       spin_lock_init(&file_private->syncobj_table_lock);
> +}
> +
> +static int
> +drm_syncobj_release_handle(int id, void *ptr, void *data)
> +{
> +       struct drm_syncobj *syncobj =3D ptr;
> +
> +       drm_syncobj_put(syncobj);
> +       return 0;
> +}
> +
> +/**
> + * drm_syncobj_release - release file-private sync object resources
> + * @dev: drm_device which is being closed by userspace
> + * @file_private: drm file-private structure to clean up
> + *
> + * Called at close time when the filp is going away.
> + *
> + * Releases any remaining references on objects by this filp.
> + */
> +void
> +drm_syncobj_release(struct drm_file *file_private)
> +{
> +       idr_for_each(&file_private->syncobj_idr,
> +                    &drm_syncobj_release_handle, file_private);
> +       idr_destroy(&file_private->syncobj_idr);
> +}
> +
> +int
> +drm_syncobj_create_ioctl(struct drm_device *dev, void *data,
> +                        struct drm_file *file_private)
> +{
> +       struct drm_syncobj_create *args =3D data;
> +
> +       if (!drm_core_check_feature(dev, DRIVER_SYNCOBJ))
> +               return -ENODEV;
> +
> +       /* no valid flags yet */
> +       if (args->flags)
> +               return -EINVAL;
> +
> +       return drm_syncobj_create(file_private,
> +                                 &args->handle);
> +}
> +
> +int
> +drm_syncobj_destroy_ioctl(struct drm_device *dev, void *data,
> +                         struct drm_file *file_private)
> +{
> +       struct drm_syncobj_destroy *args =3D data;
> +
> +       if (!drm_core_check_feature(dev, DRIVER_SYNCOBJ))
> +               return -ENODEV;
> +
> +       /* make sure padding is empty */
> +       if (args->pad)
> +               return -EINVAL;
> +       return drm_syncobj_destroy(file_private, args->handle);
> +}
> +
> +int
> +drm_syncobj_handle_to_fd_ioctl(struct drm_device *dev, void *data,
> +                                  struct drm_file *file_private)
> +{
> +       struct drm_syncobj_handle *args =3D data;
> +
> +       if (!drm_core_check_feature(dev, DRIVER_SYNCOBJ))
> +               return -ENODEV;
> +
> +       if (args->pad || args->flags)
> +               return -EINVAL;
> +
> +       return drm_syncobj_handle_to_fd(file_private, args->handle,
> +                                       &args->fd);
> +}
> +
> +int
> +drm_syncobj_fd_to_handle_ioctl(struct drm_device *dev, void *data,
> +                                  struct drm_file *file_private)
> +{
> +       struct drm_syncobj_handle *args =3D data;
> +
> +       if (!drm_core_check_feature(dev, DRIVER_SYNCOBJ))
> +               return -ENODEV;
> +
> +       if (args->pad || args->flags)
> +               return -EINVAL;
> +
> +       return drm_syncobj_fd_to_handle(file_private, args->fd,
> +                                       &args->handle);
> +}
> diff --git a/include/drm/drmP.h b/include/drm/drmP.h
> index e1daa4f..4fad9f2 100644
> --- a/include/drm/drmP.h
> +++ b/include/drm/drmP.h
> @@ -319,7 +319,6 @@ struct pci_controller;
>
>  #define DRM_IF_VERSION(maj, min) (maj << 16 | min)
>
> -
>  /* Flags and return codes for get_vblank_timestamp() driver function. */
>  #define DRM_CALLED_FROM_VBLIRQ 1
>  #define DRM_VBLANKTIME_SCANOUTPOS_METHOD (1 << 0)
> diff --git a/include/drm/drm_drv.h b/include/drm/drm_drv.h
> index 53b9832..1c66c1c 100644
> --- a/include/drm/drm_drv.h
> +++ b/include/drm/drm_drv.h
> @@ -53,6 +53,7 @@ struct drm_mode_create_dumb;
>  #define DRIVER_RENDER                  0x8000
>  #define DRIVER_ATOMIC                  0x10000
>  #define DRIVER_KMS_LEGACY_CONTEXT      0x20000
> +#define DRIVER_SYNCOBJ                  0x40000
>
>  /**
>   * struct drm_driver - DRM driver structure
> diff --git a/include/drm/drm_file.h b/include/drm/drm_file.h
> index 5dd27ae..cea7354 100644
> --- a/include/drm/drm_file.h
> +++ b/include/drm/drm_file.h
> @@ -231,6 +231,11 @@ struct drm_file {
>         /** @table_lock: Protects @object_idr. */
>         spinlock_t table_lock;
>
> +       /** @syncobj_idr: Mapping of sync object handles to object
> pointers. */
> +       struct idr syncobj_idr;
> +       /** @syncobj_table_lock: Protects @syncobj_idr. */
> +       spinlock_t syncobj_table_lock;
> +
>         /** @filp: Pointer to the core file structure. */
>         struct file *filp;
>
> diff --git a/include/drm/drm_syncobj.h b/include/drm/drm_syncobj.h
> new file mode 100644
> index 0000000..372c398
> --- /dev/null
> +++ b/include/drm/drm_syncobj.h
> @@ -0,0 +1,87 @@
> +/*
> + * Copyright =C2=A9 2017 Red Hat
> + *
> + * Permission is hereby granted, free of charge, to any person obtaining=
 a
> + * copy of this software and associated documentation files (the
> "Software"),
> + * to deal in the Software without restriction, including without
> limitation
> + * the rights to use, copy, modify, merge, publish, distribute,
> sublicense,
> + * and/or sell copies of the Software, and to permit persons to whom the
> + * Software is furnished to do so, subject to the following conditions:
> + *
> + * The above copyright notice and this permission notice (including the
> next
> + * paragraph) shall be included in all copies or substantial portions of
> the
> + * Software.
> + *
> + * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
> EXPRESS OR
> + * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
> MERCHANTABILITY,
> + * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT
> SHALL
> + * THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR
> OTHER
> + * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISI=
NG
> + * FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER
> DEALINGS
> + * IN THE SOFTWARE.
> + *
> + * Authors:
> + *
> + */
> +#ifndef __DRM_SYNCOBJ_H__
> +#define __DRM_SYNCOBJ_H__
> +
> +#include "linux/dma-fence.h"
> +
> +/**
> + * struct drm_syncobj - sync object.
> + *
> + * This structure defines a generic sync object which wraps a dma fence.
> + */
> +struct drm_syncobj {
> +       /**
> +        * @refcount:
> +        *
> +        * Reference count of this object.
> +        */
> +       struct kref refcount;
> +       /**
> +        * @fence:
> +        * NULL or a pointer to the fence bound to this object.
> +        */
> +       struct dma_fence *fence;
> +       /**
> +        * @file:
> +        * a file backing for this syncobj.
> +        */
> +       struct file *file;
> +};
> +
> +void drm_syncobj_free(struct kref *kref);
> +
> +/**
> + * drm_syncobj_get - acquire a syncobj reference
> + * @obj: sync object
> + *
> + * This acquires additional reference to @obj. It is illegal to call thi=
s
> + * without already holding a reference. No locks required.
> + */
> +static inline void
> +drm_syncobj_get(struct drm_syncobj *obj)
> +{
> +       kref_get(&obj->refcount);
> +}
> +
> +/**
> + * drm_syncobj_put - release a reference to a sync object.
> + * @obj: sync object.
> + */
> +static inline void
> +drm_syncobj_put(struct drm_syncobj *obj)
> +{
> +       kref_put(&obj->refcount, drm_syncobj_free);
> +}
> +
> +int drm_syncobj_fence_get(struct drm_file *file_private,
> +                         u32 handle,
> +                         struct dma_fence **fence);
> +int drm_syncobj_replace_fence(struct drm_file *file_private,
> +                             u32 handle,
> +                             struct dma_fence *fence);
> +
> +#endif
> diff --git a/include/uapi/drm/drm.h b/include/uapi/drm/drm.h
> index 42d9f64..96c5c78 100644
> --- a/include/uapi/drm/drm.h
> +++ b/include/uapi/drm/drm.h
> @@ -648,6 +648,7 @@ struct drm_gem_open {
>  #define DRM_CAP_ADDFB2_MODIFIERS       0x10
>  #define DRM_CAP_PAGE_FLIP_TARGET       0x11
>  #define DRM_CAP_CRTC_IN_VBLANK_EVENT   0x12
> +#define DRM_CAP_SYNCOBJ                0x13
>
>  /** DRM_IOCTL_GET_CAP ioctl argument type */
>  struct drm_get_cap {
> @@ -697,6 +698,24 @@ struct drm_prime_handle {
>         __s32 fd;
>  };
>
> +struct drm_syncobj_create {
> +       __u32 handle;
> +       __u32 flags;
> +};
> +
> +struct drm_syncobj_destroy {
> +       __u32 handle;
> +       __u32 pad;
> +};
> +
> +struct drm_syncobj_handle {
> +       __u32 handle;
> +       __u32 flags;
> +
> +       __s32 fd;
> +       __u32 pad;
> +};
> +
>  #if defined(__cplusplus)
>  }
>  #endif
> @@ -815,6 +834,11 @@ extern "C" {
>  #define DRM_IOCTL_MODE_CREATEPROPBLOB  DRM_IOWR(0xBD, struct
> drm_mode_create_blob)
>  #define DRM_IOCTL_MODE_DESTROYPROPBLOB DRM_IOWR(0xBE, struct
> drm_mode_destroy_blob)
>
> +#define DRM_IOCTL_SYNCOBJ_CREATE       DRM_IOWR(0xBF, struct
> drm_syncobj_create)
> +#define DRM_IOCTL_SYNCOBJ_DESTROY      DRM_IOWR(0xC0, struct
> drm_syncobj_destroy)
> +#define DRM_IOCTL_SYNCOBJ_HANDLE_TO_FD DRM_IOWR(0xC1, struct
> drm_syncobj_handle)
> +#define DRM_IOCTL_SYNCOBJ_FD_TO_HANDLE DRM_IOWR(0xC2, struct
> drm_syncobj_handle)
> +
>  /**
>   * Device specific ioctls should only be in their respective headers
>   * The device specific ioctl range is from 0x40 to 0x9f.
> --
> 2.9.4
>
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
>

--94eb2c1b53660e5a62055048830e
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>I can&#39;t really review for all of the kernel detai=
ls (though the seem ok to me) so this mostly applies to the API:<br><br></d=
iv>Reviewed-by: Jason Ekstrand &lt;<a href=3D"mailto:jason@jlekstrand.net">=
jason@jlekstrand.net</a>&gt;<br></div><div class=3D"gmail_extra"><br><div c=
lass=3D"gmail_quote">On Wed, May 24, 2017 at 12:06 AM, Dave Airlie <span di=
r=3D"ltr">&lt;<a href=3D"mailto:airlied@gmail.com" target=3D"_blank">airlie=
d@gmail.com</a>&gt;</span> wrote:<br><blockquote class=3D"gmail_quote" styl=
e=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">From: D=
ave Airlie &lt;<a href=3D"mailto:airlied@redhat.com">airlied@redhat.com</a>=
&gt;<br>
<br>
Sync objects are new toplevel drm object, that contain a<br>
pointer to a fence. This fence can be updated via command<br>
submission ioctls via drivers.<br>
<br>
There is also a generic wait obj API modelled on the vulkan<br>
wait API (with code modelled on some amdgpu code).<br>
<br>
These objects can be converted to an opaque fd that can be<br>
passes between processes.<br>
<br>
v2: rename reference/unreference to put/get (Chris)<br>
fix leaked reference (David Zhou)<br>
drop mutex in favour of cmpxchg (Chris)<br>
v3: cleanups from danvet, rebase on drm_fops rename<br>
check fd_flags is 0 in ioctls.<br>
<br>
Reviewed-by: Sean Paul &lt;<a href=3D"mailto:seanpaul@chromium.org">seanpau=
l@chromium.org</a>&gt;<br>
Signed-off-by: Dave Airlie &lt;<a href=3D"mailto:airlied@redhat.com">airlie=
d@redhat.com</a>&gt;<br>
---<br>
=C2=A0Documentation/gpu/drm-<wbr>internals.rst |=C2=A0 =C2=A03 +<br>
=C2=A0Documentation/gpu/drm-mm.rst=C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 12 ++=
<br>
=C2=A0drivers/gpu/drm/Makefile=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=
=C2=A0 =C2=A02 +-<br>
=C2=A0drivers/gpu/drm/drm_file.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 =
=C2=A08 +<br>
=C2=A0drivers/gpu/drm/drm_internal.h=C2=A0 =C2=A0 =C2=A0 |=C2=A0 13 ++<br>
=C2=A0drivers/gpu/drm/drm_ioctl.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 =
12 ++<br>
=C2=A0drivers/gpu/drm/drm_syncobj.c=C2=A0 =C2=A0 =C2=A0 =C2=A0| 377 +++++++=
+++++++++++++++++++++++<wbr>++++++<br>
=C2=A0include/drm/drmP.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 |=C2=A0 =C2=A01 -<br>
=C2=A0include/drm/drm_drv.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0|=C2=A0 =C2=A01 +<br>
=C2=A0include/drm/drm_file.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 |=C2=A0 =C2=A05 +<br>
=C2=A0include/drm/drm_syncobj.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=
=C2=A0 87 +++++++++<br>
=C2=A0include/uapi/drm/drm.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 |=C2=A0 24 +++<br>
=C2=A012 files changed, 543 insertions(+), 2 deletions(-)<br>
=C2=A0create mode 100644 drivers/gpu/drm/drm_syncobj.c<br>
=C2=A0create mode 100644 include/drm/drm_syncobj.h<br>
<br>
diff --git a/Documentation/gpu/drm-<wbr>internals.rst b/Documentation/gpu/d=
rm-<wbr>internals.rst<br>
index babfb61..2b23d78 100644<br>
--- a/Documentation/gpu/drm-<wbr>internals.rst<br>
+++ b/Documentation/gpu/drm-<wbr>internals.rst<br>
@@ -98,6 +98,9 @@ DRIVER_ATOMIC<br>
=C2=A0 =C2=A0 =C2=A0implement appropriate obj-&gt;atomic_get_property() vfu=
ncs for any<br>
=C2=A0 =C2=A0 =C2=A0modeset objects with driver specific properties.<br>
<br>
+DRIVER_SYNCOBJ<br>
+=C2=A0 =C2=A0 Driver support drm sync objects.<br>
+<br>
=C2=A0Major, Minor and Patchlevel<br>
=C2=A0~~~~~~~~~~~~~~~~~~~~~~~~~~~<br>
<br>
diff --git a/Documentation/gpu/drm-mm.rst b/Documentation/gpu/drm-mm.rst<br=
>
index 96b9c34..9412798 100644<br>
--- a/Documentation/gpu/drm-mm.rst<br>
+++ b/Documentation/gpu/drm-mm.rst<br>
@@ -484,3 +484,15 @@ DRM Cache Handling<br>
<br>
=C2=A0.. kernel-doc:: drivers/gpu/drm/drm_cache.c<br>
=C2=A0 =C2=A0 :export:<br>
+<br>
+DRM Sync Objects<br>
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D<br>
+<br>
+.. kernel-doc:: drivers/gpu/drm/drm_syncobj.c<br>
+=C2=A0 =C2=A0:doc: Overview<br>
+<br>
+.. kernel-doc:: include/drm/drm_syncobj.h<br>
+=C2=A0 =C2=A0:export:<br>
+<br>
+.. kernel-doc:: drivers/gpu/drm/drm_syncobj.c<br>
+=C2=A0 =C2=A0:export:<br>
diff --git a/drivers/gpu/drm/Makefile b/drivers/gpu/drm/Makefile<br>
index 59f0f9b..6f42188 100644<br>
--- a/drivers/gpu/drm/Makefile<br>
+++ b/drivers/gpu/drm/Makefile<br>
@@ -16,7 +16,7 @@ drm-y=C2=A0 =C2=A0 =C2=A0 =C2=A0:=3D=C2=A0 =C2=A0 =C2=A0 =
=C2=A0 drm_auth.o drm_bufs.o drm_cache.o \<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 drm_framebuffer.o d=
rm_connector.o drm_blend.o \<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 drm_encoder.o drm_m=
ode_object.o drm_property.o \<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 drm_plane.o drm_col=
or_mgmt.o drm_print.o \<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0drm_dumb_buffers.o =
drm_mode_config.o<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0drm_dumb_buffers.o =
drm_mode_config.o drm_syncobj.o<br>
<br>
=C2=A0drm-$(CONFIG_DRM_LIB_RANDOM) +=3D lib/drm_random.o<br>
=C2=A0drm-$(CONFIG_DRM_VM) +=3D drm_vm.o<br>
diff --git a/drivers/gpu/drm/drm_file.c b/drivers/gpu/drm/drm_file.c<br>
index 3783b65..a20d6a9 100644<br>
--- a/drivers/gpu/drm/drm_file.c<br>
+++ b/drivers/gpu/drm/drm_file.c<br>
@@ -229,6 +229,9 @@ static int drm_open_helper(struct file *filp, struct dr=
m_minor *minor)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (drm_core_check_feature(dev, DRIVER_GEM))<br=
>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 drm_gem_open(dev, p=
riv);<br>
<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0if (drm_core_check_feature(dev, DRIVER_SYNCOBJ)=
)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0drm_syncobj_open(pr=
iv);<br>
+<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (drm_core_check_feature(dev, DRIVER_PRIME))<=
br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 drm_prime_init_file=
_private(&amp;<wbr>priv-&gt;prime);<br>
<br>
@@ -276,6 +279,8 @@ static int drm_open_helper(struct file *filp, struct dr=
m_minor *minor)<br>
=C2=A0out_prime_destroy:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (drm_core_check_feature(dev, DRIVER_PRIME))<=
br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 drm_prime_destroy_f=
ile_<wbr>private(&amp;priv-&gt;prime);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0if (drm_core_check_feature(dev, DRIVER_SYNCOBJ)=
)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0drm_syncobj_release=
(priv);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (drm_core_check_feature(dev, DRIVER_GEM))<br=
>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 drm_gem_release(dev=
, priv);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 put_pid(priv-&gt;pid);<br>
@@ -398,6 +403,9 @@ int drm_release(struct inode *inode, struct file *filp)=
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 drm_property_destro=
y_user_<wbr>blobs(dev, file_priv);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0if (drm_core_check_feature(dev, DRIVER_SYNCOBJ)=
)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0drm_syncobj_release=
(file_priv)<wbr>;<br>
+<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (drm_core_check_feature(dev, DRIVER_GEM))<br=
>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 drm_gem_release(dev=
, file_priv);<br>
<br>
diff --git a/drivers/gpu/drm/drm_<wbr>internal.h b/drivers/gpu/drm/drm_<wbr=
>internal.h<br>
index 3d8e8f8..3fdef2c 100644<br>
--- a/drivers/gpu/drm/drm_<wbr>internal.h<br>
+++ b/drivers/gpu/drm/drm_<wbr>internal.h<br>
@@ -142,4 +142,17 @@ static inline int drm_debugfs_crtc_crc_add(<wbr>struct=
 drm_crtc *crtc)<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 return 0;<br>
=C2=A0}<br>
+<br>
=C2=A0#endif<br>
+<br>
+/* drm_syncobj.c */<br>
+void drm_syncobj_open(struct drm_file *file_private);<br>
+void drm_syncobj_release(struct drm_file *file_private);<br>
+int drm_syncobj_create_ioctl(<wbr>struct drm_device *dev, void *data,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 struct drm_file *file_private);<br>
+int drm_syncobj_destroy_ioctl(<wbr>struct drm_device *dev, void *data,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0struct drm_file *file_private);<br>
+int drm_syncobj_handle_to_fd_<wbr>ioctl(struct drm_device *dev, void *data=
,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 struct drm_file *file_private=
);<br>
+int drm_syncobj_fd_to_handle_<wbr>ioctl(struct drm_device *dev, void *data=
,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 struct drm_file *file_private=
);<br>
diff --git a/drivers/gpu/drm/drm_ioctl.c b/drivers/gpu/drm/drm_ioctl.c<br>
index 865e3ee..f1e5681 100644<br>
--- a/drivers/gpu/drm/drm_ioctl.c<br>
+++ b/drivers/gpu/drm/drm_ioctl.c<br>
@@ -241,6 +241,9 @@ static int drm_getcap(struct drm_device *dev, void *dat=
a, struct drm_file *file_<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 req-&gt;value |=3D =
dev-&gt;driver-&gt;prime_fd_to_<wbr>handle ? DRM_PRIME_CAP_IMPORT : 0;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 req-&gt;value |=3D =
dev-&gt;driver-&gt;prime_handle_to_<wbr>fd ? DRM_PRIME_CAP_EXPORT : 0;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return 0;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0case DRM_CAP_SYNCOBJ:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0req-&gt;value =3D d=
rm_core_check_feature(dev, DRIVER_SYNCOBJ);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return 0;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* Other caps only work with KMS drivers */<br>
@@ -645,6 +648,15 @@ static const struct drm_ioctl_desc drm_ioctls[] =3D {<=
br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 DRM_IOCTL_DEF(DRM_IOCTL_MODE_<wbr>ATOMIC, drm_m=
ode_atomic_ioctl, DRM_MASTER|DRM_CONTROL_ALLOW|<wbr>DRM_UNLOCKED),<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 DRM_IOCTL_DEF(DRM_IOCTL_MODE_<wbr>CREATEPROPBLO=
B, drm_mode_createblob_ioctl, DRM_CONTROL_ALLOW|DRM_<wbr>UNLOCKED),<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 DRM_IOCTL_DEF(DRM_IOCTL_MODE_<wbr>DESTROYPROPBL=
OB, drm_mode_destroyblob_ioctl, DRM_CONTROL_ALLOW|DRM_<wbr>UNLOCKED),<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0DRM_IOCTL_DEF(DRM_IOCTL_<wbr>SYNCOBJ_CREATE, dr=
m_syncobj_create_ioctl,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0DRM_UNLOCKED|DRM_RENDER_ALLOW)<wbr>,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0DRM_IOCTL_DEF(DRM_IOCTL_<wbr>SYNCOBJ_DESTROY, d=
rm_syncobj_destroy_ioctl,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0DRM_UNLOCKED|DRM_RENDER_ALLOW)<wbr>,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0DRM_IOCTL_DEF(DRM_IOCTL_<wbr>SYNCOBJ_HANDLE_TO_=
FD, drm_syncobj_handle_to_fd_<wbr>ioctl,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0DRM_UNLOCKED|DRM_RENDER_ALLOW)<wbr>,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0DRM_IOCTL_DEF(DRM_IOCTL_<wbr>SYNCOBJ_FD_TO_HAND=
LE, drm_syncobj_fd_to_handle_<wbr>ioctl,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0DRM_UNLOCKED|DRM_RENDER_ALLOW)<wbr>,<br>
=C2=A0};<br>
<br>
=C2=A0#define DRM_CORE_IOCTL_COUNT=C2=A0 =C2=A0ARRAY_SIZE( drm_ioctls )<br>
diff --git a/drivers/gpu/drm/drm_syncobj.<wbr>c b/drivers/gpu/drm/drm_synco=
bj.<wbr>c<br>
new file mode 100644<br>
index 0000000..b611480<br>
--- /dev/null<br>
+++ b/drivers/gpu/drm/drm_syncobj.<wbr>c<br>
@@ -0,0 +1,377 @@<br>
+/*<br>
+ * Copyright 2017 Red Hat<br>
+ *<br>
+ * Permission is hereby granted, free of charge, to any person obtaining a=
<br>
+ * copy of this software and associated documentation files (the &quot;Sof=
tware&quot;),<br>
+ * to deal in the Software without restriction, including without limitati=
on<br>
+ * the rights to use, copy, modify, merge, publish, distribute, sublicense=
,<br>
+ * and/or sell copies of the Software, and to permit persons to whom the<b=
r>
+ * Software is furnished to do so, subject to the following conditions:<br=
>
+ *<br>
+ * The above copyright notice and this permission notice (including the ne=
xt<br>
+ * paragraph) shall be included in all copies or substantial portions of t=
he<br>
+ * Software.<br>
+ *<br>
+ * THE SOFTWARE IS PROVIDED &quot;AS IS&quot;, WITHOUT WARRANTY OF ANY KIN=
D, EXPRESS OR<br>
+ * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY=
,<br>
+ * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.=C2=A0 IN NO EVENT=
 SHALL<br>
+ * THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OT=
HER<br>
+ * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING=
<br>
+ * FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEA=
LINGS<br>
+ * IN THE SOFTWARE.<br>
+ *<br>
+ * Authors:<br>
+ *<br>
+ */<br>
+<br>
+/**<br>
+ * DOC: Overview<br>
+ *<br>
+ * DRM synchronisation objects (syncobj) are a persistent objects,<br>
+ * that contain an optional fence. The fence can be updated with a new<br>
+ * fence, or be NULL.<br>
+ *<br>
+ * syncobj&#39;s can be export to fd&#39;s and back, these fd&#39;s are op=
aque and<br>
+ * have no other use case, except passing the syncobj between processes.<b=
r>
+ *<br>
+ * Their primary use-case is to implement Vulkan fences and semaphores.<br=
>
+ *<br>
+ * syncobj have a kref reference count, but also have an optional file.<br=
>
+ * The file is only created once the syncobj is exported.<br>
+ * The file takes a reference on the kref.<br>
+ */<br>
+<br>
+#include &lt;drm/drmP.h&gt;<br>
+#include &lt;linux/file.h&gt;<br>
+#include &lt;linux/fs.h&gt;<br>
+#include &lt;linux/anon_inodes.h&gt;<br>
+<br>
+#include &quot;drm_internal.h&quot;<br>
+#include &lt;drm/drm_syncobj.h&gt;<br>
+<br>
+static struct drm_syncobj *drm_syncobj_find(struct drm_file *file_private,=
<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 u=
32 handle)<br>
+{<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0struct drm_syncobj *syncobj;<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0spin_lock(&amp;file_private-&gt;<wbr>syncobj_ta=
ble_lock);<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0/* Check if we currently have a reference on th=
e object */<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0syncobj =3D idr_find(&amp;file_private-&gt;<wbr=
>syncobj_idr, handle);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0if (syncobj)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0drm_syncobj_get(syn=
cobj);<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0spin_unlock(&amp;file_private-&gt;<wbr>syncobj_=
table_lock);<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0return syncobj;<br>
+}<br>
+<br>
+/**<br>
+ * drm_syncobj_replace_fence - lookup and replace fence in a sync object.<=
br>
+ * @file_private - drm file private pointer.<br>
+ * @handle - syncobj handle to lookup<br>
+ * @fence - fence to install in sync file.<br>
+ * Returns:<br>
+ * 0 on success, or -EINVAL when the handle doesn&#39;t point at a valid s=
em file.<br>
+ *<br>
+ * This looks up a sync object and replaces the fence on it, freeing<br>
+ * the old one.<br>
+ */<br>
+int drm_syncobj_replace_fence(<wbr>struct drm_file *file_private,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0u32 handle,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0struct dma_fence *fence)<br>
+{<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0struct drm_syncobj *syncobj =3D drm_syncobj_fin=
d(file_private, handle);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0struct dma_fence *old_fence =3D NULL;<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0if (!syncobj)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return -EINVAL;<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0if (fence)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0dma_fence_get(fence=
);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0old_fence =3D xchg(&amp;syncobj-&gt;fence, fenc=
e);<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0dma_fence_put(old_fence);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0drm_syncobj_put(syncobj);<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0return 0;<br>
+}<br>
+EXPORT_SYMBOL(drm_syncobj_<wbr>replace_fence);<br>
+<br>
+int drm_syncobj_fence_get(struct drm_file *file_private,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0u32 handle,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0struct dma_fence **fence)<br>
+{<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0struct drm_syncobj *syncobj =3D drm_syncobj_fin=
d(file_private, handle);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0int ret =3D 0;<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0if (!syncobj)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return -ENOENT;<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0*fence =3D dma_fence_get(syncobj-&gt;fence);<br=
>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0if (!*fence) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ret =3D -EINVAL;<br=
>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0drm_syncobj_put(syncobj);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0return ret;<br>
+}<br>
+EXPORT_SYMBOL(drm_syncobj_<wbr>fence_get);<br>
+<br>
+void drm_syncobj_free(struct kref *kref)<br>
+{<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0struct drm_syncobj *syncobj =3D container_of(kr=
ef,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 struct drm_syncobj,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 refcount);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0dma_fence_put(syncobj-&gt;fence);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0kfree(syncobj);<br>
+}<br>
+<br>
+static int drm_syncobj_create(struct drm_file *file_private,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0u32 *handle)<br>
+{<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0int ret;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0struct drm_syncobj *syncobj;<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0syncobj =3D kzalloc(sizeof(struct drm_syncobj),=
 GFP_KERNEL);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0if (!syncobj)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return -ENOMEM;<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0kref_init(&amp;syncobj-&gt;refcount);<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0idr_preload(GFP_KERNEL);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0spin_lock(&amp;file_private-&gt;<wbr>syncobj_ta=
ble_lock);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0ret =3D idr_alloc(&amp;file_private-&gt;<wbr>sy=
ncobj_idr, syncobj, 1, 0, GFP_NOWAIT);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0spin_unlock(&amp;file_private-&gt;<wbr>syncobj_=
table_lock);<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0idr_preload_end();<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0if (ret &lt; 0) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0drm_syncobj_put(syn=
cobj);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return ret;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0*handle =3D ret;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0return 0;<br>
+}<br>
+<br>
+static int drm_syncobj_destroy(struct drm_file *file_private,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 u32 handle)<br>
+{<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0struct drm_syncobj *syncobj;<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0spin_lock(&amp;file_private-&gt;<wbr>syncobj_ta=
ble_lock);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0syncobj =3D idr_remove(&amp;file_private-&gt;<w=
br>syncobj_idr, handle);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0spin_unlock(&amp;file_private-&gt;<wbr>syncobj_=
table_lock);<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0if (!syncobj)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return -EINVAL;<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0drm_syncobj_put(syncobj);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0return 0;<br>
+}<br>
+<br>
+static int drm_syncobj_file_release(<wbr>struct inode *inode, struct file =
*file)<br>
+{<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0struct drm_syncobj *syncobj =3D file-&gt;privat=
e_data;<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0drm_syncobj_put(syncobj);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0return 0;<br>
+}<br>
+<br>
+static const struct file_operations drm_syncobj_file_fops =3D {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0.release =3D drm_syncobj_file_release,<br>
+};<br>
+<br>
+static int drm_syncobj_alloc_file(struct drm_syncobj *syncobj)<br>
+{<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0struct file *file =3D anon_inode_getfile(&quot;=
syncobj_<wbr>file&quot;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 &amp;drm_syncobj_file_fops,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 syncobj, 0);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0if (IS_ERR(file))<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return PTR_ERR(file=
);<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0drm_syncobj_get(syncobj);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0if (cmpxchg(&amp;syncobj-&gt;file, NULL, file))=
 {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/* lost the race */=
<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0fput(file);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0return 0;<br>
+}<br>
+<br>
+static int drm_syncobj_handle_to_fd(<wbr>struct drm_file *file_private,<br=
>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0u32 handle, int *p_fd)<=
br>
+{<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0struct drm_syncobj *syncobj =3D drm_syncobj_fin=
d(file_private, handle);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0int ret;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0int fd;<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0if (!syncobj)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return -EINVAL;<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0fd =3D get_unused_fd_flags(O_CLOEXEC)<wbr>;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0if (fd &lt; 0) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0drm_syncobj_put(syn=
cobj);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return fd;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0if (!syncobj-&gt;file) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ret =3D drm_syncobj=
_alloc_file(<wbr>syncobj);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (ret)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0goto out_put_fd;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0fd_install(fd, syncobj-&gt;file);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0drm_syncobj_put(syncobj);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0*p_fd =3D fd;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0return 0;<br>
+out_put_fd:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0put_unused_fd(fd);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0drm_syncobj_put(syncobj);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0return ret;<br>
+}<br>
+<br>
+static struct drm_syncobj *drm_syncobj_fdget(int fd)<br>
+{<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0struct file *file =3D fget(fd);<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0if (!file)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return NULL;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0if (file-&gt;f_op !=3D &amp;drm_syncobj_file_fo=
ps)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0goto err;<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0return file-&gt;private_data;<br>
+err:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0fput(file);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0return NULL;<br>
+};<br>
+<br>
+static int drm_syncobj_fd_to_handle(<wbr>struct drm_file *file_private,<br=
>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0int fd, u32 *handle)<br=
>
+{<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0struct drm_syncobj *syncobj =3D drm_syncobj_fdg=
et(fd);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0int ret;<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0if (!syncobj)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return -EINVAL;<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0/* take a reference to put in the idr */<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0drm_syncobj_get(syncobj);<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0idr_preload(GFP_KERNEL);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0spin_lock(&amp;file_private-&gt;<wbr>syncobj_ta=
ble_lock);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0ret =3D idr_alloc(&amp;file_private-&gt;<wbr>sy=
ncobj_idr, syncobj, 1, 0, GFP_NOWAIT);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0spin_unlock(&amp;file_private-&gt;<wbr>syncobj_=
table_lock);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0idr_preload_end();<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0if (ret &lt; 0) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0fput(syncobj-&gt;fi=
le);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return ret;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0*handle =3D ret;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0return 0;<br>
+}<br>
+<br>
+/**<br>
+ * drm_syncobj_open - initalizes syncobj file-private structures at devnod=
e open time<br>
+ * @dev: drm_device which is being opened by userspace<br>
+ * @file_private: drm file-private structure to set up<br>
+ *<br>
+ * Called at device open time, sets up the structure for handling refcount=
ing<br>
+ * of sync objects.<br>
+ */<br>
+void<br>
+drm_syncobj_open(struct drm_file *file_private)<br>
+{<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0idr_init(&amp;file_private-&gt;<wbr>syncobj_idr=
);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0spin_lock_init(&amp;file_private-&gt;<wbr>synco=
bj_table_lock);<br>
+}<br>
+<br>
+static int<br>
+drm_syncobj_release_handle(<wbr>int id, void *ptr, void *data)<br>
+{<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0struct drm_syncobj *syncobj =3D ptr;<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0drm_syncobj_put(syncobj);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0return 0;<br>
+}<br>
+<br>
+/**<br>
+ * drm_syncobj_release - release file-private sync object resources<br>
+ * @dev: drm_device which is being closed by userspace<br>
+ * @file_private: drm file-private structure to clean up<br>
+ *<br>
+ * Called at close time when the filp is going away.<br>
+ *<br>
+ * Releases any remaining references on objects by this filp.<br>
+ */<br>
+void<br>
+drm_syncobj_release(struct drm_file *file_private)<br>
+{<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0idr_for_each(&amp;file_private-&gt;<wbr>syncobj=
_idr,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &amp=
;drm_syncobj_release_handle, file_private);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0idr_destroy(&amp;file_private-&gt;<wbr>syncobj_=
idr);<br>
+}<br>
+<br>
+int<br>
+drm_syncobj_create_ioctl(<wbr>struct drm_device *dev, void *data,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 struct drm_file *file_private)<br>
+{<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0struct drm_syncobj_create *args =3D data;<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0if (!drm_core_check_feature(dev, DRIVER_SYNCOBJ=
))<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return -ENODEV;<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0/* no valid flags yet */<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0if (args-&gt;flags)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return -EINVAL;<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0return drm_syncobj_create(file_<wbr>private,<br=
>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&amp;args-&gt;handle);<br>
+}<br>
+<br>
+int<br>
+drm_syncobj_destroy_ioctl(<wbr>struct drm_device *dev, void *data,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0struct drm_file *file_private)<br>
+{<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0struct drm_syncobj_destroy *args =3D data;<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0if (!drm_core_check_feature(dev, DRIVER_SYNCOBJ=
))<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return -ENODEV;<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0/* make sure padding is empty */<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0if (args-&gt;pad)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return -EINVAL;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0return drm_syncobj_destroy(file_<wbr>private, a=
rgs-&gt;handle);<br>
+}<br>
+<br>
+int<br>
+drm_syncobj_handle_to_fd_<wbr>ioctl(struct drm_device *dev, void *data,<br=
>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 struct drm_file *file_private=
)<br>
+{<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0struct drm_syncobj_handle *args =3D data;<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0if (!drm_core_check_feature(dev, DRIVER_SYNCOBJ=
))<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return -ENODEV;<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0if (args-&gt;pad || args-&gt;flags)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return -EINVAL;<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0return drm_syncobj_handle_to_fd(file_<wbr>priva=
te, args-&gt;handle,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&amp;args=
-&gt;fd);<br>
+}<br>
+<br>
+int<br>
+drm_syncobj_fd_to_handle_<wbr>ioctl(struct drm_device *dev, void *data,<br=
>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 struct drm_file *file_private=
)<br>
+{<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0struct drm_syncobj_handle *args =3D data;<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0if (!drm_core_check_feature(dev, DRIVER_SYNCOBJ=
))<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return -ENODEV;<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0if (args-&gt;pad || args-&gt;flags)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return -EINVAL;<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0return drm_syncobj_fd_to_handle(file_<wbr>priva=
te, args-&gt;fd,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&amp;args=
-&gt;handle);<br>
+}<br>
diff --git a/include/drm/drmP.h b/include/drm/drmP.h<br>
index e1daa4f..4fad9f2 100644<br>
--- a/include/drm/drmP.h<br>
+++ b/include/drm/drmP.h<br>
@@ -319,7 +319,6 @@ struct pci_controller;<br>
<br>
=C2=A0#define DRM_IF_VERSION(maj, min) (maj &lt;&lt; 16 | min)<br>
<br>
-<br>
=C2=A0/* Flags and return codes for get_vblank_timestamp() driver function.=
 */<br>
=C2=A0#define DRM_CALLED_FROM_VBLIRQ 1<br>
=C2=A0#define DRM_VBLANKTIME_SCANOUTPOS_<wbr>METHOD (1 &lt;&lt; 0)<br>
diff --git a/include/drm/drm_drv.h b/include/drm/drm_drv.h<br>
index 53b9832..1c66c1c 100644<br>
--- a/include/drm/drm_drv.h<br>
+++ b/include/drm/drm_drv.h<br>
@@ -53,6 +53,7 @@ struct drm_mode_create_dumb;<br>
=C2=A0#define DRIVER_RENDER=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 0x8000<br>
=C2=A0#define DRIVER_ATOMIC=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 0x10000<br>
=C2=A0#define DRIVER_KMS_LEGACY_CONTEXT=C2=A0 =C2=A0 =C2=A0 0x20000<br>
+#define DRIVER_SYNCOBJ=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 0x40000<br>
<br>
=C2=A0/**<br>
=C2=A0 * struct drm_driver - DRM driver structure<br>
diff --git a/include/drm/drm_file.h b/include/drm/drm_file.h<br>
index 5dd27ae..cea7354 100644<br>
--- a/include/drm/drm_file.h<br>
+++ b/include/drm/drm_file.h<br>
@@ -231,6 +231,11 @@ struct drm_file {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 /** @table_lock: Protects @object_idr. */<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 spinlock_t table_lock;<br>
<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0/** @syncobj_idr: Mapping of sync object handle=
s to object pointers. */<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0struct idr syncobj_idr;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0/** @syncobj_table_lock: Protects @syncobj_idr.=
 */<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0spinlock_t syncobj_table_lock;<br>
+<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 /** @filp: Pointer to the core file structure. =
*/<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 struct file *filp;<br>
<br>
diff --git a/include/drm/drm_syncobj.h b/include/drm/drm_syncobj.h<br>
new file mode 100644<br>
index 0000000..372c398<br>
--- /dev/null<br>
+++ b/include/drm/drm_syncobj.h<br>
@@ -0,0 +1,87 @@<br>
+/*<br>
+ * Copyright =C2=A9 2017 Red Hat<br>
+ *<br>
+ * Permission is hereby granted, free of charge, to any person obtaining a=
<br>
+ * copy of this software and associated documentation files (the &quot;Sof=
tware&quot;),<br>
+ * to deal in the Software without restriction, including without limitati=
on<br>
+ * the rights to use, copy, modify, merge, publish, distribute, sublicense=
,<br>
+ * and/or sell copies of the Software, and to permit persons to whom the<b=
r>
+ * Software is furnished to do so, subject to the following conditions:<br=
>
+ *<br>
+ * The above copyright notice and this permission notice (including the ne=
xt<br>
+ * paragraph) shall be included in all copies or substantial portions of t=
he<br>
+ * Software.<br>
+ *<br>
+ * THE SOFTWARE IS PROVIDED &quot;AS IS&quot;, WITHOUT WARRANTY OF ANY KIN=
D, EXPRESS OR<br>
+ * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY=
,<br>
+ * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.=C2=A0 IN NO EVENT=
 SHALL<br>
+ * THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OT=
HER<br>
+ * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING=
<br>
+ * FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEA=
LINGS<br>
+ * IN THE SOFTWARE.<br>
+ *<br>
+ * Authors:<br>
+ *<br>
+ */<br>
+#ifndef __DRM_SYNCOBJ_H__<br>
+#define __DRM_SYNCOBJ_H__<br>
+<br>
+#include &quot;linux/dma-fence.h&quot;<br>
+<br>
+/**<br>
+ * struct drm_syncobj - sync object.<br>
+ *<br>
+ * This structure defines a generic sync object which wraps a dma fence.<b=
r>
+ */<br>
+struct drm_syncobj {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0/**<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 * @refcount:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 *<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 * Reference count of this object.<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 */<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0struct kref refcount;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0/**<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 * @fence:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 * NULL or a pointer to the fence bound to this=
 object.<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 */<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0struct dma_fence *fence;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0/**<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 * @file:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 * a file backing for this syncobj.<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 */<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0struct file *file;<br>
+};<br>
+<br>
+void drm_syncobj_free(struct kref *kref);<br>
+<br>
+/**<br>
+ * drm_syncobj_get - acquire a syncobj reference<br>
+ * @obj: sync object<br>
+ *<br>
+ * This acquires additional reference to @obj. It is illegal to call this<=
br>
+ * without already holding a reference. No locks required.<br>
+ */<br>
+static inline void<br>
+drm_syncobj_get(struct drm_syncobj *obj)<br>
+{<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0kref_get(&amp;obj-&gt;refcount);<br>
+}<br>
+<br>
+/**<br>
+ * drm_syncobj_put - release a reference to a sync object.<br>
+ * @obj: sync object.<br>
+ */<br>
+static inline void<br>
+drm_syncobj_put(struct drm_syncobj *obj)<br>
+{<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0kref_put(&amp;obj-&gt;refcount, drm_syncobj_fre=
e);<br>
+}<br>
+<br>
+int drm_syncobj_fence_get(struct drm_file *file_private,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0u32 handle,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0struct dma_fence **fence);<br>
+int drm_syncobj_replace_fence(<wbr>struct drm_file *file_private,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0u32 handle,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0struct dma_fence *fence);<br>
+<br>
+#endif<br>
diff --git a/include/uapi/drm/drm.h b/include/uapi/drm/drm.h<br>
index 42d9f64..96c5c78 100644<br>
--- a/include/uapi/drm/drm.h<br>
+++ b/include/uapi/drm/drm.h<br>
@@ -648,6 +648,7 @@ struct drm_gem_open {<br>
=C2=A0#define DRM_CAP_ADDFB2_MODIFIERS=C2=A0 =C2=A0 =C2=A0 =C2=A00x10<br>
=C2=A0#define DRM_CAP_PAGE_FLIP_TARGET=C2=A0 =C2=A0 =C2=A0 =C2=A00x11<br>
=C2=A0#define DRM_CAP_CRTC_IN_VBLANK_EVENT=C2=A0 =C2=A00x12<br>
+#define DRM_CAP_SYNCOBJ=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 0x13<br>
<br>
=C2=A0/** DRM_IOCTL_GET_CAP ioctl argument type */<br>
=C2=A0struct drm_get_cap {<br>
@@ -697,6 +698,24 @@ struct drm_prime_handle {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 __s32 fd;<br>
=C2=A0};<br>
<br>
+struct drm_syncobj_create {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0__u32 handle;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0__u32 flags;<br>
+};<br>
+<br>
+struct drm_syncobj_destroy {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0__u32 handle;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0__u32 pad;<br>
+};<br>
+<br>
+struct drm_syncobj_handle {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0__u32 handle;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0__u32 flags;<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0__s32 fd;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0__u32 pad;<br>
+};<br>
+<br>
=C2=A0#if defined(__cplusplus)<br>
=C2=A0}<br>
=C2=A0#endif<br>
@@ -815,6 +834,11 @@ extern &quot;C&quot; {<br>
=C2=A0#define DRM_IOCTL_MODE_CREATEPROPBLOB=C2=A0 DRM_IOWR(0xBD, struct drm=
_mode_create_blob)<br>
=C2=A0#define DRM_IOCTL_MODE_DESTROYPROPBLOB DRM_IOWR(0xBE, struct drm_mode=
_destroy_blob)<br>
<br>
+#define DRM_IOCTL_SYNCOBJ_CREATE=C2=A0 =C2=A0 =C2=A0 =C2=A0DRM_IOWR(0xBF, =
struct drm_syncobj_create)<br>
+#define DRM_IOCTL_SYNCOBJ_DESTROY=C2=A0 =C2=A0 =C2=A0 DRM_IOWR(0xC0, struc=
t drm_syncobj_destroy)<br>
+#define DRM_IOCTL_SYNCOBJ_HANDLE_TO_FD DRM_IOWR(0xC1, struct drm_syncobj_h=
andle)<br>
+#define DRM_IOCTL_SYNCOBJ_FD_TO_HANDLE DRM_IOWR(0xC2, struct drm_syncobj_h=
andle)<br>
+<br>
=C2=A0/**<br>
=C2=A0 * Device specific ioctls should only be in their respective headers<=
br>
=C2=A0 * The device specific ioctl range is from 0x40 to 0x9f.<br>
<span class=3D"HOEnZb"><font color=3D"#888888">--<br>
2.9.4<br>
<br>
______________________________<wbr>_________________<br>
dri-devel mailing list<br>
<a href=3D"mailto:dri-devel@lists.freedesktop.org">dri-devel@lists.freedesk=
top.<wbr>org</a><br>
<a href=3D"https://lists.freedesktop.org/mailman/listinfo/dri-devel" rel=3D=
"noreferrer" target=3D"_blank">https://lists.freedesktop.org/<wbr>mailman/l=
istinfo/dri-devel</a><br>
</font></span></blockquote></div><br></div>

--94eb2c1b53660e5a62055048830e--

--===============0063236864==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KZHJpLWRldmVs
IG1haWxpbmcgbGlzdApkcmktZGV2ZWxAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlz
dHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vZHJpLWRldmVsCg==

--===============0063236864==--
