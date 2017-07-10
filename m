From: Jason Ekstrand <jason-fQELhIk9awXprZlt/sZkLg@public.gmane.org>
Subject: Re: [PATCH] drm/syncobj: add sync obj wait interface. (v6)
Date: Mon, 10 Jul 2017 08:28:15 -0700
Message-ID: <CAOFGe94mA9i7+-XTJQn65N-vK_GbQwvjru2b=6ucXejpWWmx4g@mail.gmail.com>
References: <20170706010409.9373-1-airlied@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0150522573=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <20170706010409.9373-1-airlied-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
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

--===============0150522573==
Content-Type: multipart/alternative; boundary="001a11497fe25a67ae0553f83bfd"

--001a11497fe25a67ae0553f83bfd
Content-Type: text/plain; charset="UTF-8"

On Wed, Jul 5, 2017 at 6:04 PM, Dave Airlie <airlied-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:

> From: Dave Airlie <airlied-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
>
> This interface will allow sync object to be used to back
> Vulkan fences. This API is pretty much the vulkan fence waiting
> API, and I've ported the code from amdgpu.
>
> v2: accept relative timeout, pass remaining time back
> to userspace.
> v3: return to absolute timeouts.
> v4: absolute zero = poll,
>     rewrite any/all code to have same operation for arrays
>     return -EINVAL for 0 fences.
> v4.1: fixup fences allocation check, use u64_to_user_ptr
> v5: move to sec/nsec, and use timespec64 for calcs.
> v6: use -ETIME and drop the out status flag. (-ETIME
> is suggested by ickle, I can feel a shed painting)
>
> Signed-off-by: Dave Airlie <airlied-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
> ---
>  drivers/gpu/drm/drm_internal.h |   2 +
>  drivers/gpu/drm/drm_ioctl.c    |   2 +
>  drivers/gpu/drm/drm_syncobj.c  | 142 ++++++++++++++++++++++++++++++
> +++++++++++
>  include/uapi/drm/drm.h         |  13 ++++
>  4 files changed, 159 insertions(+)
>
> diff --git a/drivers/gpu/drm/drm_internal.h b/drivers/gpu/drm/drm_
> internal.h
> index 5cecc97..d71b50d 100644
> --- a/drivers/gpu/drm/drm_internal.h
> +++ b/drivers/gpu/drm/drm_internal.h
> @@ -157,3 +157,5 @@ int drm_syncobj_handle_to_fd_ioctl(struct drm_device
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
> index 89441bc..2d5a7a1 100644
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
> @@ -451,3 +456,140 @@ drm_syncobj_fd_to_handle_ioctl(struct drm_device
> *dev, void *data,
>         return drm_syncobj_fd_to_handle(file_private, args->fd,
>                                         &args->handle);
>  }
> +
> +/**
> + * drm_timeout_abs_to_jiffies - calculate jiffies timeout from absolute
> value
> + *
> + * @timeout_sec: timeout sec component, 0 for poll
> + * @timeout_nsec: timeout nsec component in ns, 0 for poll
> + * both must be 0 for poll.
> + *
> + * Calculate the timeout in jiffies from an absolute time in sec/nsec.
> + */
> +static unsigned long drm_timeout_abs_to_jiffies(int64_t timeout_sec,
> uint64_t timeout_nsec)
> +{
> +       struct timespec64 abs_timeout, timeout, max_jiffy_timespec;
> +       unsigned long timeout_jiffies;
> +
> +       /* make 0 timeout means poll - absolute 0 doesn't seem valid */
> +       if (timeout_sec == 0 && timeout_nsec == 0)
> +               return 0;
> +
> +       abs_timeout.tv_sec = timeout_sec;
> +       abs_timeout.tv_nsec = timeout_nsec;
> +
> +       /* clamp timeout if it's to large */
> +       if (!timespec64_valid_strict(&abs_timeout))
> +               return MAX_SCHEDULE_TIMEOUT - 1;
> +
> +       timeout = timespec64_sub(abs_timeout,
> ktime_to_timespec64(ktime_get()));
> +       if (!timespec64_valid(&timeout))
> +               return 0;
> +
> +       jiffies_to_timespec64(MAX_JIFFY_OFFSET, &max_jiffy_timespec);
> +       if (timespec64_compare(&timeout, &max_jiffy_timespec) >= 0)
> +               return MAX_SCHEDULE_TIMEOUT - 1;
> +
> +       timeout_jiffies = timespec64_to_jiffies(&timeout);
> +       /*  clamp timeout to avoid infinite timeout */
> +       if (timeout_jiffies >= MAX_SCHEDULE_TIMEOUT)
> +               return MAX_SCHEDULE_TIMEOUT - 1;
> +
> +       return timeout_jiffies + 1;
> +}
> +
> +static int drm_syncobj_wait_fences(struct drm_device *dev,
> +                                  struct drm_file *file_private,
> +                                  struct drm_syncobj_wait *wait,
> +                                  struct dma_fence **fences)
> +{
> +       unsigned long timeout = drm_timeout_abs_to_jiffies(wait->timeout_sec,
> wait->timeout_nsec);
> +       int ret = 0;
> +       uint32_t first = ~0;
> +
> +       if (wait->flags & DRM_SYNCOBJ_WAIT_FLAGS_WAIT_ALL) {
> +               int i;
> +               for (i = 0; i < wait->count_handles; i++) {
> +                       ret = dma_fence_wait_timeout(fences[i], true,
> timeout);
> +
> +                       if (ret < 0)
> +                               return ret;
> +                       if (ret == 0)
> +                               break;
> +                       timeout = ret;
> +               }
> +               first = 0;
> +       } else {
> +               ret = dma_fence_wait_any_timeout(fences,
> +                                                wait->count_handles,
> +                                                true, timeout,
> +                                                &first);
> +       }
> +
> +       if (ret < 0)
> +               return ret;
> +
> +       wait->first_signaled = first;
> +       if (ret == 0)
> +               return -ETIME;
> +       return 0;
> +}
> +
> +int
> +drm_syncobj_wait_ioctl(struct drm_device *dev, void *data,
> +                      struct drm_file *file_private)
> +{
> +       struct drm_syncobj_wait *args = data;
> +       uint32_t *handles;
> +       struct dma_fence **fences;
> +       int ret = 0;
> +       int i;
> +
> +       if (!drm_core_check_feature(dev, DRIVER_SYNCOBJ))
> +               return -ENODEV;
> +
> +       if (args->flags != 0 && args->flags != DRM_SYNCOBJ_WAIT_FLAGS_WAIT_
> ALL)
> +               return -EINVAL;
> +
> +       if (args->count_handles == 0)
> +               return -EINVAL;
> +
> +       /* Get the handles from userspace */
> +       handles = kmalloc_array(args->count_handles, sizeof(uint32_t),
> +                               GFP_KERNEL);
> +       if (handles == NULL)
> +               return -ENOMEM;
> +
> +       if (copy_from_user(handles,
> +                          u64_to_user_ptr(args->handles),
> +                          sizeof(uint32_t) * args->count_handles)) {
> +               ret = -EFAULT;
> +               goto err_free_handles;
> +       }
> +
> +       fences = kcalloc(args->count_handles,
> +                        sizeof(struct dma_fence *), GFP_KERNEL);
> +       if (!fences) {
> +               ret = -ENOMEM;
> +               goto err_free_handles;
> +       }
> +
> +       for (i = 0; i < args->count_handles; i++) {
> +               ret = drm_syncobj_fence_get(file_private, handles[i],
> +                                           &fences[i]);
> +               if (ret)
> +                       goto err_free_fence_array;
> +       }
> +
> +       ret = drm_syncobj_wait_fences(dev, file_private,
> +                                     args, fences);
>

So, reading some CTS tests again, and I think we have a problem here.  The
Vulkan spec allows you to wait on a fence that is in the unsignaled state.
In theory, you could have thread A start waiting on a fence before thread B
submits the work which triggers that fence.  This means that the dma_fence
may not exist yet when vkWaitForFences gets called.  If we really want to
support the full Vulkan usage, we need to somehow support missing
dma_fences by waiting for the dma_fence to show up.  Unfortunately, I don't
know enough about the internal kernel APIs to know what that would look
like.


> +
> +err_free_fence_array:
> +       for (i = 0; i < args->count_handles; i++)
> +               dma_fence_put(fences[i]);
> +       kfree(fences);
> +err_free_handles:
> +       kfree(handles);
> +
> +       return ret;
> +}
> diff --git a/include/uapi/drm/drm.h b/include/uapi/drm/drm.h
> index 101593a..91746a7 100644
> --- a/include/uapi/drm/drm.h
> +++ b/include/uapi/drm/drm.h
> @@ -718,6 +718,18 @@ struct drm_syncobj_handle {
>         __u32 pad;
>  };
>
> +#define DRM_SYNCOBJ_WAIT_FLAGS_WAIT_ALL (1 << 0)
> +struct drm_syncobj_wait {
> +       __u64 handles;
> +       /* absolute timeout */
> +       __s64 timeout_sec;
> +       __s64 timeout_nsec;
> +       __u32 count_handles;
> +       __u32 flags;
> +       __u32 first_signaled; /* only valid when not waiting all */
> +       __u32 pad;
> +};
> +
>  #if defined(__cplusplus)
>  }
>  #endif
> @@ -840,6 +852,7 @@ extern "C" {
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

--001a11497fe25a67ae0553f83bfd
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_extra"><div class=3D"gmail_quote">On W=
ed, Jul 5, 2017 at 6:04 PM, Dave Airlie <span dir=3D"ltr">&lt;<a href=3D"ma=
ilto:airlied-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org" target=3D"_blank">airlied-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org</a>&gt;</span> =
wrote:<br><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;bord=
er-left:1px #ccc solid;padding-left:1ex">From: Dave Airlie &lt;<a href=3D"m=
ailto:airlied-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org">airlied-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org</a>&gt;<br>
<br>
This interface will allow sync object to be used to back<br>
Vulkan fences. This API is pretty much the vulkan fence waiting<br>
API, and I&#39;ve ported the code from amdgpu.<br>
<br>
v2: accept relative timeout, pass remaining time back<br>
to userspace.<br>
v3: return to absolute timeouts.<br>
v4: absolute zero =3D poll,<br>
=C2=A0 =C2=A0 rewrite any/all code to have same operation for arrays<br>
=C2=A0 =C2=A0 return -EINVAL for 0 fences.<br>
v4.1: fixup fences allocation check, use u64_to_user_ptr<br>
v5: move to sec/nsec, and use timespec64 for calcs.<br>
v6: use -ETIME and drop the out status flag. (-ETIME<br>
is suggested by ickle, I can feel a shed painting)<br>
<br>
Signed-off-by: Dave Airlie &lt;<a href=3D"mailto:airlied-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org">airlie=
d@redhat.com</a>&gt;<br>
---<br>
=C2=A0drivers/gpu/drm/drm_internal.h |=C2=A0 =C2=A02 +<br>
=C2=A0drivers/gpu/drm/drm_ioctl.c=C2=A0 =C2=A0 |=C2=A0 =C2=A02 +<br>
=C2=A0drivers/gpu/drm/drm_syncobj.c=C2=A0 | 142 +++++++++++++++++++++++++++=
+++<wbr>+++++++++++<br>
=C2=A0include/uapi/drm/drm.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 13 ++=
++<br>
=C2=A04 files changed, 159 insertions(+)<br>
<br>
diff --git a/drivers/gpu/drm/drm_<wbr>internal.h b/drivers/gpu/drm/drm_<wbr=
>internal.h<br>
index 5cecc97..d71b50d 100644<br>
--- a/drivers/gpu/drm/drm_<wbr>internal.h<br>
+++ b/drivers/gpu/drm/drm_<wbr>internal.h<br>
@@ -157,3 +157,5 @@ int drm_syncobj_handle_to_fd_<wbr>ioctl(struct drm_devi=
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
index 89441bc..2d5a7a1 100644<br>
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
@@ -451,3 +456,140 @@ drm_syncobj_fd_to_handle_<wbr>ioctl(struct drm_device=
 *dev, void *data,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 return drm_syncobj_fd_to_handle(file_<wbr>priva=
te, args-&gt;fd,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &amp;arg=
s-&gt;handle);<br>
=C2=A0}<br>
+<br>
+/**<br>
+ * drm_timeout_abs_to_jiffies - calculate jiffies timeout from absolute va=
lue<br>
+ *<br>
+ * @timeout_sec: timeout sec component, 0 for poll<br>
+ * @timeout_nsec: timeout nsec component in ns, 0 for poll<br>
+ * both must be 0 for poll.<br>
+ *<br>
+ * Calculate the timeout in jiffies from an absolute time in sec/nsec.<br>
+ */<br>
+static unsigned long drm_timeout_abs_to_jiffies(<wbr>int64_t timeout_sec, =
uint64_t timeout_nsec)<br>
+{<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0struct timespec64 abs_timeout, timeout, max_jif=
fy_timespec;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0unsigned long timeout_jiffies;<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0/* make 0 timeout means poll - absolute 0 doesn=
&#39;t seem valid */<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0if (timeout_sec =3D=3D 0 &amp;&amp; timeout_nse=
c =3D=3D 0)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return 0;<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0abs_timeout.tv_sec =3D timeout_sec;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0abs_timeout.tv_nsec =3D timeout_nsec;<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0/* clamp timeout if it&#39;s to large */<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0if (!timespec64_valid_strict(&amp;<wbr>abs_time=
out))<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return MAX_SCHEDULE=
_TIMEOUT - 1;<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0timeout =3D timespec64_sub(abs_timeout, ktime_t=
o_timespec64(ktime_get(<wbr>)));<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0if (!timespec64_valid(&amp;timeout))<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return 0;<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0jiffies_to_timespec64(MAX_<wbr>JIFFY_OFFSET, &a=
mp;max_jiffy_timespec);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0if (timespec64_compare(&amp;timeout, &amp;max_j=
iffy_timespec) &gt;=3D 0)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return MAX_SCHEDULE=
_TIMEOUT - 1;<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0timeout_jiffies =3D timespec64_to_jiffies(&amp;=
<wbr>timeout);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0/*=C2=A0 clamp timeout to avoid infinite timeou=
t */<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0if (timeout_jiffies &gt;=3D MAX_SCHEDULE_TIMEOU=
T)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return MAX_SCHEDULE=
_TIMEOUT - 1;<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0return timeout_jiffies + 1;<br>
+}<br>
+<br>
+static int drm_syncobj_wait_fences(struct drm_device *dev,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 struct drm_file *file_private=
,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 struct drm_syncobj_wait *wait=
,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 struct dma_fence **fences)<br=
>
+{<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0unsigned long timeout =3D drm_timeout_abs_to_ji=
ffies(<wbr>wait-&gt;timeout_sec, wait-&gt;timeout_nsec);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0int ret =3D 0;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0uint32_t first =3D ~0;<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0if (wait-&gt;flags &amp; DRM_SYNCOBJ_WAIT_FLAGS=
_WAIT_<wbr>ALL) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0int i;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0for (i =3D 0; i &lt=
; wait-&gt;count_handles; i++) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0ret =3D dma_fence_wait_timeout(fences[<wbr>i], true, timeout);<br=
>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0if (ret &lt; 0)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return ret;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0if (ret =3D=3D 0)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0break;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0timeout =3D ret;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0first =3D 0;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0} else {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ret =3D dma_fence_w=
ait_any_timeout(<wbr>fences,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 wait-&gt;count_handles,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 true, timeout,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 &amp;first);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0if (ret &lt; 0)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return ret;<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0wait-&gt;first_signaled =3D first;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0if (ret =3D=3D 0)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return -ETIME;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0return 0;<br>
+}<br>
+<br>
+int<br>
+drm_syncobj_wait_ioctl(struct drm_device *dev, void *data,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 struct drm_file *file_private)<br>
+{<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0struct drm_syncobj_wait *args =3D data;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0uint32_t *handles;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0struct dma_fence **fences;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0int ret =3D 0;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0int i;<br>
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
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return -EINVAL;<br>
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
=A0 =C2=A0 =C2=A0 u64_to_user_ptr(args-&gt;handles)<wbr>,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 sizeof(uint32_t) * args-&gt;count_handles)) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ret =3D -EFAULT;<br=
>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0goto err_free_handl=
es;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0fences =3D kcalloc(args-&gt;count_handles,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 sizeof(struct dma_fence *), GFP_KERNEL);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0if (!fences) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ret =3D -ENOMEM;<br=
>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0goto err_free_handl=
es;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0for (i =3D 0; i &lt; args-&gt;count_handles; i+=
+) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ret =3D drm_syncobj=
_fence_get(file_<wbr>private, handles[i],<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0&amp;fences[i]);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (ret)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0goto err_free_fence_array;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0ret =3D drm_syncobj_wait_fences(dev, file_priva=
te,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0args, fences);<b=
r></blockquote><div><br></div><div>So, reading some CTS tests again, and I =
think we have a problem here.=C2=A0 The Vulkan spec allows you to wait on a=
 fence that is in the unsignaled state.=C2=A0 In theory, you could have thr=
ead A start waiting on a fence before thread B submits the work which trigg=
ers that fence.=C2=A0 This means that the dma_fence may not exist yet when =
vkWaitForFences gets called.=C2=A0 If we really want to support the full Vu=
lkan usage, we need to somehow support missing dma_fences by waiting for th=
e dma_fence to show up.=C2=A0 Unfortunately, I don&#39;t know enough about =
the internal kernel APIs to know what that would look like.<br></div><div>=
=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;bo=
rder-left:1px #ccc solid;padding-left:1ex">
+<br>
+err_free_fence_array:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0for (i =3D 0; i &lt; args-&gt;count_handles; i+=
+)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0dma_fence_put(fence=
s[i]);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0kfree(fences);<br>
+err_free_handles:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0kfree(handles);<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0return ret;<br>
+}<br>
diff --git a/include/uapi/drm/drm.h b/include/uapi/drm/drm.h<br>
index 101593a..91746a7 100644<br>
--- a/include/uapi/drm/drm.h<br>
+++ b/include/uapi/drm/drm.h<br>
@@ -718,6 +718,18 @@ struct drm_syncobj_handle {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 __u32 pad;<br>
=C2=A0};<br>
<br>
+#define DRM_SYNCOBJ_WAIT_FLAGS_WAIT_<wbr>ALL (1 &lt;&lt; 0)<br>
+struct drm_syncobj_wait {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0__u64 handles;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0/* absolute timeout */<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0__s64 timeout_sec;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0__s64 timeout_nsec;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0__u32 count_handles;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0__u32 flags;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0__u32 first_signaled; /* only valid when not wa=
iting all */<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0__u32 pad;<br>
+};<br>
+<br>
=C2=A0#if defined(__cplusplus)<br>
=C2=A0}<br>
=C2=A0#endif<br>
@@ -840,6 +852,7 @@ extern &quot;C&quot; {<br>
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

--001a11497fe25a67ae0553f83bfd--

--===============0150522573==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============0150522573==--
