From: Jason Ekstrand <jason-fQELhIk9awXprZlt/sZkLg@public.gmane.org>
Subject: Re: [PATCH 2/5] drm/syncobj: add sync obj wait interface. (v3)
Date: Wed, 24 May 2017 10:25:03 -0700
Message-ID: <CAOFGe97H+ZD-ewN3qcc7Tkv_WTN-qEubiQjGcHdqX=AU0Zj_XA@mail.gmail.com>
References: <20170524070615.1634-1-airlied@gmail.com>
 <20170524070615.1634-3-airlied@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1423416899=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <20170524070615.1634-3-airlied-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
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
To: Dave Airlie <airlied-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: amd-gfx mailing list <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, Maling list - DRI developers <dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

--===============1423416899==
Content-Type: multipart/alternative; boundary="94eb2c1b53667c831e0550486255"

--94eb2c1b53667c831e0550486255
Content-Type: text/plain; charset="UTF-8"

On Wed, May 24, 2017 at 12:06 AM, Dave Airlie <airlied-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:

> From: Dave Airlie <airlied-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
>
> This interface will allow sync object to be used to back
> Vulkan fences. This API is pretty much the vulkan fence waiting
> API, and I've ported the code from amdgpu.
>
> v2: accept relative timeout, pass remaining time back
> to userspace.
> v3: return to absolute timeouts.
>
> Signed-off-by: Dave Airlie <airlied-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
> ---
>  drivers/gpu/drm/drm_internal.h |   2 +
>  drivers/gpu/drm/drm_ioctl.c    |   2 +
>  drivers/gpu/drm/drm_syncobj.c  | 164 ++++++++++++++++++++++++++++++
> +++++++++++
>  include/uapi/drm/drm.h         |  14 ++++
>  4 files changed, 182 insertions(+)
>
> diff --git a/drivers/gpu/drm/drm_internal.h b/drivers/gpu/drm/drm_
> internal.h
> index 3fdef2c..53e3f6b 100644
> --- a/drivers/gpu/drm/drm_internal.h
> +++ b/drivers/gpu/drm/drm_internal.h
> @@ -156,3 +156,5 @@ int drm_syncobj_handle_to_fd_ioctl(struct drm_device
> *dev, void *data,
>                                    struct drm_file *file_private);
>  int drm_syncobj_fd_to_handle_ioctl(struct drm_device *dev, void *data,
>                                    struct drm_file *file_private);
> +int drm_syncobj_wait_ioctl(struct drm_device *dev, void *data,
> +                          struct drm_file *file_private);
> diff --git a/drivers/gpu/drm/drm_ioctl.c b/drivers/gpu/drm/drm_ioctl.c
> index f1e5681..385ce74 100644
> --- a/drivers/gpu/drm/drm_ioctl.c
> +++ b/drivers/gpu/drm/drm_ioctl.c
> @@ -657,6 +657,8 @@ static const struct drm_ioctl_desc drm_ioctls[] = {
>                       DRM_UNLOCKED|DRM_RENDER_ALLOW),
>         DRM_IOCTL_DEF(DRM_IOCTL_SYNCOBJ_FD_TO_HANDLE,
> drm_syncobj_fd_to_handle_ioctl,
>                       DRM_UNLOCKED|DRM_RENDER_ALLOW),
> +       DRM_IOCTL_DEF(DRM_IOCTL_SYNCOBJ_WAIT, drm_syncobj_wait_ioctl,
> +                     DRM_UNLOCKED|DRM_RENDER_ALLOW),
>  };
>
>  #define DRM_CORE_IOCTL_COUNT   ARRAY_SIZE( drm_ioctls )
> diff --git a/drivers/gpu/drm/drm_syncobj.c b/drivers/gpu/drm/drm_syncobj.c
> index b611480..8b87594 100644
> --- a/drivers/gpu/drm/drm_syncobj.c
> +++ b/drivers/gpu/drm/drm_syncobj.c
> @@ -1,5 +1,7 @@
>  /*
>   * Copyright 2017 Red Hat
> + * Parts ported from amdgpu (fence wait code).
> + * Copyright 2016 Advanced Micro Devices, Inc.
>   *
>   * Permission is hereby granted, free of charge, to any person obtaining a
>   * copy of this software and associated documentation files (the
> "Software"),
> @@ -31,6 +33,9 @@
>   * that contain an optional fence. The fence can be updated with a new
>   * fence, or be NULL.
>   *
> + * syncobj's can be waited upon, where it will wait for the underlying
> + * fence.
> + *
>   * syncobj's can be export to fd's and back, these fd's are opaque and
>   * have no other use case, except passing the syncobj between processes.
>   *
> @@ -375,3 +380,162 @@ drm_syncobj_fd_to_handle_ioctl(struct drm_device
> *dev, void *data,
>         return drm_syncobj_fd_to_handle(file_private, args->fd,
>                                         &args->handle);
>  }
> +
> +
> +/**
> + * drm_timeout_abs_to_jiffies - calculate jiffies timeout from absolute
> value
> + *
> + * @timeout_ns: timeout in ns
> + *
> + * Calculate the timeout in jiffies from an absolute timeout in ns.
> + */
> +unsigned long drm_timeout_abs_to_jiffies(uint64_t timeout_ns)
> +{
> +       unsigned long timeout_jiffies;
> +       ktime_t timeout;
> +
> +       /* clamp timeout if it's to large */
> +       if (((int64_t)timeout_ns) < 0)
> +               return MAX_SCHEDULE_TIMEOUT;
> +
> +       timeout = ktime_sub(ns_to_ktime(timeout_ns), ktime_get());
> +       if (ktime_to_ns(timeout) < 0)
> +               return 0;
> +
> +       timeout_jiffies = nsecs_to_jiffies(ktime_to_ns(timeout));
> +       /*  clamp timeout to avoid unsigned-> signed overflow */
> +       if (timeout_jiffies > MAX_SCHEDULE_TIMEOUT )
> +               return MAX_SCHEDULE_TIMEOUT - 1;
> +
> +       return timeout_jiffies;
> +}
> +
> +static int drm_syncobj_wait_all_fences(struct drm_device *dev,
> +                                      struct drm_file *file_private,
> +                                      struct drm_syncobj_wait *wait,
> +                                      uint32_t *handles)
> +{
> +       uint32_t i;
> +       int ret;
> +       unsigned long timeout = drm_timeout_abs_to_jiffies(
> wait->timeout_ns);
> +
> +       for (i = 0; i < wait->count_handles; i++) {
> +               struct dma_fence *fence;
> +
> +               ret = drm_syncobj_fence_get(file_private, handles[i],
> +                                           &fence);
> +               if (ret)
> +                       return ret;
> +
> +               if (!fence)
> +                       continue;
> +
> +               ret = dma_fence_wait_timeout(fence, true, timeout);
> +
> +               dma_fence_put(fence);
> +               if (ret < 0)
> +                       return ret;
> +               if (ret == 0)
> +                       break;
> +               timeout = ret;
> +       }
> +
> +       wait->out_timeout_ns = jiffies_to_nsecs(ret);
> +       wait->out_status = (ret > 0);
> +       wait->first_signaled = 0;
> +       return 0;
> +}
> +
> +static int drm_syncobj_wait_any_fence(struct drm_device *dev,
> +                                     struct drm_file *file_private,
> +                                     struct drm_syncobj_wait *wait,
> +                                     uint32_t *handles)
> +{
> +       unsigned long timeout = drm_timeout_abs_to_jiffies(
> wait->timeout_ns);
> +       struct dma_fence **array;
> +       uint32_t i;
> +       int ret;
> +       uint32_t first = ~0;
> +
> +       /* Prepare the fence array */
> +       array = kcalloc(wait->count_handles,
> +                       sizeof(struct dma_fence *), GFP_KERNEL);
> +
> +       if (array == NULL)
> +               return -ENOMEM;
> +
> +       for (i = 0; i < wait->count_handles; i++) {
> +               struct dma_fence *fence;
> +
> +               ret = drm_syncobj_fence_get(file_private, handles[i],
> +                                           &fence);
> +               if (ret)
> +                       goto err_free_fence_array;
> +               else if (fence)
> +                       array[i] = fence;
> +               else { /* NULL, the fence has been already signaled */
> +                       ret = 1;
> +                       goto out;
> +               }
> +       }
> +
> +       ret = dma_fence_wait_any_timeout(array, wait->count_handles,
> true, timeout,
> +                                        &first);
> +       if (ret < 0)
> +               goto err_free_fence_array;
> +out:
> +       wait->out_timeout_ns = jiffies_to_nsecs(ret);
> +       wait->out_status = (ret > 0);
> +       wait->first_signaled = first;
> +       /* set return value 0 to indicate success */
> +       ret = 0;
> +
> +err_free_fence_array:
> +       for (i = 0; i < wait->count_handles; i++)
> +               dma_fence_put(array[i]);
> +       kfree(array);
> +
> +       return ret;
> +}
> +
> +int
> +drm_syncobj_wait_ioctl(struct drm_device *dev, void *data,
> +                      struct drm_file *file_private)
> +{
> +       struct drm_syncobj_wait *args = data;
> +       uint32_t *handles;
> +       int ret = 0;
> +
> +       if (!drm_core_check_feature(dev, DRIVER_SYNCOBJ))
> +               return -ENODEV;
> +
> +       if (args->flags != 0 && args->flags != DRM_SYNCOBJ_WAIT_FLAGS_WAIT_
> ALL)
> +               return -EINVAL;
> +
> +       if (args->count_handles == 0)
> +               return 0;
> +
> +       /* Get the handles from userspace */
> +       handles = kmalloc_array(args->count_handles, sizeof(uint32_t),
> +                               GFP_KERNEL);
> +       if (handles == NULL)
> +               return -ENOMEM;
> +
> +       if (copy_from_user(handles,
> +                          (void __user *)(unsigned long)(args->handles),
> +                          sizeof(uint32_t) * args->count_handles)) {
> +               ret = -EFAULT;
> +               goto err_free_handles;
> +       }
> +
> +       if (args->flags & DRM_SYNCOBJ_WAIT_FLAGS_WAIT_ALL)
> +               ret = drm_syncobj_wait_all_fences(dev, file_private,
> +                                                 args, handles);
> +       else
> +               ret = drm_syncobj_wait_any_fence(dev, file_private,
> +                                                args, handles);
> +err_free_handles:
> +       kfree(handles);
> +
> +       return ret;
> +}
> diff --git a/include/uapi/drm/drm.h b/include/uapi/drm/drm.h
> index 96c5c78..d6e2f62 100644
> --- a/include/uapi/drm/drm.h
> +++ b/include/uapi/drm/drm.h
> @@ -716,6 +716,19 @@ struct drm_syncobj_handle {
>         __u32 pad;
>  };
>
> +#define DRM_SYNCOBJ_WAIT_FLAGS_WAIT_ALL (1 << 0)
> +struct drm_syncobj_wait {
> +       __u64 handles;
> +       /* absolute timeout */
> +       __u64 timeout_ns;
> +       /* remaining timeout */
> +       __u64 out_timeout_ns;
>

Any particular reason why we don't just make timeout_ns an in/out?  I don't
really care and haven't given it much thought; mostly just curious.


> +       __u32 count_handles;
> +       __u32 flags;
> +       __u32 out_status;
> +       __u32 first_signaled; /* on valid when not waiting all */
> +};
> +
>  #if defined(__cplusplus)
>  }
>  #endif
> @@ -838,6 +851,7 @@ extern "C" {
>  #define DRM_IOCTL_SYNCOBJ_DESTROY      DRM_IOWR(0xC0, struct
> drm_syncobj_destroy)
>  #define DRM_IOCTL_SYNCOBJ_HANDLE_TO_FD DRM_IOWR(0xC1, struct
> drm_syncobj_handle)
>  #define DRM_IOCTL_SYNCOBJ_FD_TO_HANDLE DRM_IOWR(0xC2, struct
> drm_syncobj_handle)
> +#define DRM_IOCTL_SYNCOBJ_WAIT         DRM_IOWR(0xC3, struct
> drm_syncobj_wait)
>
>  /**
>   * Device specific ioctls should only be in their respective headers
> --
> 2.9.4
>
> _______________________________________________
> dri-devel mailing list
> dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
>

--94eb2c1b53667c831e0550486255
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_extra"><div class=3D"gmail_quote">On W=
ed, May 24, 2017 at 12:06 AM, Dave Airlie <span dir=3D"ltr">&lt;<a href=3D"=
mailto:airlied-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org" target=3D"_blank">airlied-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org</a>&gt;</span=
> wrote:<br><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;bo=
rder-left:1px #ccc solid;padding-left:1ex">From: Dave Airlie &lt;<a href=3D=
"mailto:airlied-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org">airlied-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org</a>&gt;<br>
<br>
This interface will allow sync object to be used to back<br>
Vulkan fences. This API is pretty much the vulkan fence waiting<br>
API, and I&#39;ve ported the code from amdgpu.<br>
<br>
v2: accept relative timeout, pass remaining time back<br>
to userspace.<br>
v3: return to absolute timeouts.<br>
<br>
Signed-off-by: Dave Airlie &lt;<a href=3D"mailto:airlied-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org">airlie=
d@redhat.com</a>&gt;<br>
---<br>
=C2=A0drivers/gpu/drm/drm_internal.h |=C2=A0 =C2=A02 +<br>
=C2=A0drivers/gpu/drm/drm_ioctl.c=C2=A0 =C2=A0 |=C2=A0 =C2=A02 +<br>
=C2=A0drivers/gpu/drm/drm_syncobj.c=C2=A0 | 164 +++++++++++++++++++++++++++=
+++<wbr>+++++++++++<br>
=C2=A0include/uapi/drm/drm.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 14 ++=
++<br>
=C2=A04 files changed, 182 insertions(+)<br>
<br>
diff --git a/drivers/gpu/drm/drm_<wbr>internal.h b/drivers/gpu/drm/drm_<wbr=
>internal.h<br>
index 3fdef2c..53e3f6b 100644<br>
--- a/drivers/gpu/drm/drm_<wbr>internal.h<br>
+++ b/drivers/gpu/drm/drm_<wbr>internal.h<br>
@@ -156,3 +156,5 @@ int drm_syncobj_handle_to_fd_<wbr>ioctl(struct drm_devi=
ce *dev, void *data,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0struct drm_file *file_p=
rivate);<br>
=C2=A0int drm_syncobj_fd_to_handle_<wbr>ioctl(struct drm_device *dev, void =
*data,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0struct drm_file *file_p=
rivate);<br>
+int drm_syncobj_wait_ioctl(struct drm_device *dev, void *data,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 struct drm_file *file_private);<br>
diff --git a/drivers/gpu/drm/drm_ioctl.c b/drivers/gpu/drm/drm_ioctl.c<br>
index f1e5681..385ce74 100644<br>
--- a/drivers/gpu/drm/drm_ioctl.c<br>
+++ b/drivers/gpu/drm/drm_ioctl.c<br>
@@ -657,6 +657,8 @@ static const struct drm_ioctl_desc drm_ioctls[] =3D {<b=
r>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 DRM_UNLOCKED|DRM_RENDER_ALLOW)<wbr>,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 DRM_IOCTL_DEF(DRM_IOCTL_<wbr>SYNCOBJ_FD_TO_HAND=
LE, drm_syncobj_fd_to_handle_<wbr>ioctl,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 DRM_UNLOCKED|DRM_RENDER_ALLOW)<wbr>,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0DRM_IOCTL_DEF(DRM_IOCTL_<wbr>SYNCOBJ_WAIT, drm_=
syncobj_wait_ioctl,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0DRM_UNLOCKED|DRM_RENDER_ALLOW)<wbr>,<br>
=C2=A0};<br>
<br>
=C2=A0#define DRM_CORE_IOCTL_COUNT=C2=A0 =C2=A0ARRAY_SIZE( drm_ioctls )<br>
diff --git a/drivers/gpu/drm/drm_syncobj.<wbr>c b/drivers/gpu/drm/drm_synco=
bj.<wbr>c<br>
index b611480..8b87594 100644<br>
--- a/drivers/gpu/drm/drm_syncobj.<wbr>c<br>
+++ b/drivers/gpu/drm/drm_syncobj.<wbr>c<br>
@@ -1,5 +1,7 @@<br>
=C2=A0/*<br>
=C2=A0 * Copyright 2017 Red Hat<br>
+ * Parts ported from amdgpu (fence wait code).<br>
+ * Copyright 2016 Advanced Micro Devices, Inc.<br>
=C2=A0 *<br>
=C2=A0 * Permission is hereby granted, free of charge, to any person obtain=
ing a<br>
=C2=A0 * copy of this software and associated documentation files (the &quo=
t;Software&quot;),<br>
@@ -31,6 +33,9 @@<br>
=C2=A0 * that contain an optional fence. The fence can be updated with a ne=
w<br>
=C2=A0 * fence, or be NULL.<br>
=C2=A0 *<br>
+ * syncobj&#39;s can be waited upon, where it will wait for the underlying=
<br>
+ * fence.<br>
+ *<br>
=C2=A0 * syncobj&#39;s can be export to fd&#39;s and back, these fd&#39;s a=
re opaque and<br>
=C2=A0 * have no other use case, except passing the syncobj between process=
es.<br>
=C2=A0 *<br>
@@ -375,3 +380,162 @@ drm_syncobj_fd_to_handle_<wbr>ioctl(struct drm_device=
 *dev, void *data,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 return drm_syncobj_fd_to_handle(file_<wbr>priva=
te, args-&gt;fd,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &amp;arg=
s-&gt;handle);<br>
=C2=A0}<br>
+<br>
+<br>
+/**<br>
+ * drm_timeout_abs_to_jiffies - calculate jiffies timeout from absolute va=
lue<br>
+ *<br>
+ * @timeout_ns: timeout in ns<br>
+ *<br>
+ * Calculate the timeout in jiffies from an absolute timeout in ns.<br>
+ */<br>
+unsigned long drm_timeout_abs_to_jiffies(<wbr>uint64_t timeout_ns)<br>
+{<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0unsigned long timeout_jiffies;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0ktime_t timeout;<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0/* clamp timeout if it&#39;s to large */<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0if (((int64_t)timeout_ns) &lt; 0)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return MAX_SCHEDULE=
_TIMEOUT;<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0timeout =3D ktime_sub(ns_to_ktime(timeout_<wbr>=
ns), ktime_get());<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0if (ktime_to_ns(timeout) &lt; 0)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return 0;<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0timeout_jiffies =3D nsecs_to_jiffies(ktime_to_n=
s(<wbr>timeout));<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0/*=C2=A0 clamp timeout to avoid unsigned-&gt; s=
igned overflow */<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0if (timeout_jiffies &gt; MAX_SCHEDULE_TIMEOUT )=
<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return MAX_SCHEDULE=
_TIMEOUT - 1;<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0return timeout_jiffies;<br>
+}<br>
+<br>
+static int drm_syncobj_wait_all_fences(<wbr>struct drm_device *dev,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 struct drm_file=
 *file_private,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 struct drm_sync=
obj_wait *wait,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 uint32_t *handl=
es)<br>
+{<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0uint32_t i;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0int ret;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0unsigned long timeout =3D drm_timeout_abs_to_ji=
ffies(<wbr>wait-&gt;timeout_ns);<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0for (i =3D 0; i &lt; wait-&gt;count_handles; i+=
+) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0struct dma_fence *f=
ence;<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ret =3D drm_syncobj=
_fence_get(file_<wbr>private, handles[i],<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0&amp;fence);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (ret)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0return ret;<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (!fence)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0continue;<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ret =3D dma_fence_w=
ait_timeout(fence, true, timeout);<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0dma_fence_put(fence=
);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (ret &lt; 0)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0return ret;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (ret =3D=3D 0)<b=
r>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0break;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0timeout =3D ret;<br=
>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0wait-&gt;out_timeout_ns =3D jiffies_to_nsecs(re=
t);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0wait-&gt;out_status =3D (ret &gt; 0);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0wait-&gt;first_signaled =3D 0;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0return 0;<br>
+}<br>
+<br>
+static int drm_syncobj_wait_any_fence(<wbr>struct drm_device *dev,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0struct drm_file =
*file_private,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0struct drm_synco=
bj_wait *wait,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0uint32_t *handle=
s)<br>
+{<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0unsigned long timeout =3D drm_timeout_abs_to_ji=
ffies(<wbr>wait-&gt;timeout_ns);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0struct dma_fence **array;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0uint32_t i;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0int ret;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0uint32_t first =3D ~0;<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0/* Prepare the fence array */<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0array =3D kcalloc(wait-&gt;count_handles,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0sizeof(struct dma_fence *), GFP_KERNEL);<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0if (array =3D=3D NULL)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return -ENOMEM;<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0for (i =3D 0; i &lt; wait-&gt;count_handles; i+=
+) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0struct dma_fence *f=
ence;<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ret =3D drm_syncobj=
_fence_get(file_<wbr>private, handles[i],<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0&amp;fence);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (ret)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0goto err_free_fence_array;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0else if (fence)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0array[i] =3D fence;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0else { /* NULL, the=
 fence has been already signaled */<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0ret =3D 1;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0goto out;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0ret =3D dma_fence_wait_any_timeout(<wbr>array, =
wait-&gt;count_handles, true, timeout,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &amp;fir=
st);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0if (ret &lt; 0)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0goto err_free_fence=
_array;<br>
+out:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0wait-&gt;out_timeout_ns =3D jiffies_to_nsecs(re=
t);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0wait-&gt;out_status =3D (ret &gt; 0);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0wait-&gt;first_signaled =3D first;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0/* set return value 0 to indicate success */<br=
>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0ret =3D 0;<br>
+<br>
+err_free_fence_array:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0for (i =3D 0; i &lt; wait-&gt;count_handles; i+=
+)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0dma_fence_put(array=
[i]);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0kfree(array);<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0return ret;<br>
+}<br>
+<br>
+int<br>
+drm_syncobj_wait_ioctl(struct drm_device *dev, void *data,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 struct drm_file *file_private)<br>
+{<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0struct drm_syncobj_wait *args =3D data;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0uint32_t *handles;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0int ret =3D 0;<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0if (!drm_core_check_feature(dev, DRIVER_SYNCOBJ=
))<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return -ENODEV;<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0if (args-&gt;flags !=3D 0 &amp;&amp; args-&gt;f=
lags !=3D DRM_SYNCOBJ_WAIT_FLAGS_WAIT_<wbr>ALL)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return -EINVAL;<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0if (args-&gt;count_handles =3D=3D 0)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return 0;<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0/* Get the handles from userspace */<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0handles =3D kmalloc_array(args-&gt;count_<wbr>h=
andles, sizeof(uint32_t),<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0GFP_KERNEL);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0if (handles =3D=3D NULL)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return -ENOMEM;<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0if (copy_from_user(handles,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 (void __user *)(unsigned long)(args-&gt;handles),<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 sizeof(uint32_t) * args-&gt;count_handles)) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ret =3D -EFAULT;<br=
>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0goto err_free_handl=
es;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0if (args-&gt;flags &amp; DRM_SYNCOBJ_WAIT_FLAGS=
_WAIT_<wbr>ALL)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ret =3D drm_syncobj=
_wait_all_fences(<wbr>dev, file_private,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0args, handles);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0else<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ret =3D drm_syncobj=
_wait_any_fence(<wbr>dev, file_private,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 args, handles);<br>
+err_free_handles:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0kfree(handles);<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0return ret;<br>
+}<br>
diff --git a/include/uapi/drm/drm.h b/include/uapi/drm/drm.h<br>
index 96c5c78..d6e2f62 100644<br>
--- a/include/uapi/drm/drm.h<br>
+++ b/include/uapi/drm/drm.h<br>
@@ -716,6 +716,19 @@ struct drm_syncobj_handle {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 __u32 pad;<br>
=C2=A0};<br>
<br>
+#define DRM_SYNCOBJ_WAIT_FLAGS_WAIT_<wbr>ALL (1 &lt;&lt; 0)<br>
+struct drm_syncobj_wait {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0__u64 handles;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0/* absolute timeout */<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0__u64 timeout_ns;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0/* remaining timeout */<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0__u64 out_timeout_ns;<br></blockquote><div><br>=
</div><div>Any particular reason why we don&#39;t just make timeout_ns an i=
n/out?=C2=A0 I don&#39;t really care and haven&#39;t given it much thought;=
 mostly just curious.<br></div><div>=C2=A0</div><blockquote class=3D"gmail_=
quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1=
ex">
+=C2=A0 =C2=A0 =C2=A0 =C2=A0__u32 count_handles;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0__u32 flags;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0__u32 out_status;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0__u32 first_signaled; /* on valid when not wait=
ing all */<br>
+};<br>
+<br>
=C2=A0#if defined(__cplusplus)<br>
=C2=A0}<br>
=C2=A0#endif<br>
@@ -838,6 +851,7 @@ extern &quot;C&quot; {<br>
=C2=A0#define DRM_IOCTL_SYNCOBJ_DESTROY=C2=A0 =C2=A0 =C2=A0 DRM_IOWR(0xC0, =
struct drm_syncobj_destroy)<br>
=C2=A0#define DRM_IOCTL_SYNCOBJ_HANDLE_TO_FD DRM_IOWR(0xC1, struct drm_sync=
obj_handle)<br>
=C2=A0#define DRM_IOCTL_SYNCOBJ_FD_TO_HANDLE DRM_IOWR(0xC2, struct drm_sync=
obj_handle)<br>
+#define DRM_IOCTL_SYNCOBJ_WAIT=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0DRM_IOWR(0=
xC3, struct drm_syncobj_wait)<br>
<br>
=C2=A0/**<br>
=C2=A0 * Device specific ioctls should only be in their respective headers<=
br>
<span class=3D"HOEnZb"><font color=3D"#888888">--<br>
2.9.4<br>
<br>
______________________________<wbr>_________________<br>
dri-devel mailing list<br>
<a href=3D"mailto:dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org">dri-devel-PD4FTy7X32lzq7FAFJ/aeQ@public.gmane.org=
top.<wbr>org</a><br>
<a href=3D"https://lists.freedesktop.org/mailman/listinfo/dri-devel" rel=3D=
"noreferrer" target=3D"_blank">https://lists.freedesktop.org/<wbr>mailman/l=
istinfo/dri-devel</a><br>
</font></span></blockquote></div><br></div></div>

--94eb2c1b53667c831e0550486255--

--===============1423416899==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============1423416899==--
