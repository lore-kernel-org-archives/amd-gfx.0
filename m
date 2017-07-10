From: =?UTF-8?Q?Christian_K=c3=b6nig?= <deathsimple@vodafone.de>
Subject: Re: [PATCH] drm/syncobj: add sync obj wait interface. (v6)
Date: Mon, 10 Jul 2017 17:45:24 +0200
Message-ID: <899f9bb3-f7c7-ce86-c22b-bb8d262778bf@vodafone.de>
References: <20170706010409.9373-1-airlied@gmail.com>
 <CAOFGe94mA9i7+-XTJQn65N-vK_GbQwvjru2b=6ucXejpWWmx4g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0552402068=="
Return-path: <dri-devel-bounces@lists.freedesktop.org>
In-Reply-To: <CAOFGe94mA9i7+-XTJQn65N-vK_GbQwvjru2b=6ucXejpWWmx4g@mail.gmail.com>
Content-Language: en-US
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
To: Jason Ekstrand <jason@jlekstrand.net>, Dave Airlie <airlied@gmail.com>
Cc: Maling list - DRI developers <dri-devel@lists.freedesktop.org>, amd-gfx mailing list <amd-gfx@lists.freedesktop.org>
List-Id: amd-gfx.lists.freedesktop.org

This is a multi-part message in MIME format.
--===============0552402068==
Content-Type: multipart/alternative;
 boundary="------------B644DC3FFFAD698C9AB23E59"
Content-Language: en-US

This is a multi-part message in MIME format.
--------------B644DC3FFFAD698C9AB23E59
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit

Am 10.07.2017 um 17:28 schrieb Jason Ekstrand:
> On Wed, Jul 5, 2017 at 6:04 PM, Dave Airlie <airlied@gmail.com 
> <mailto:airlied@gmail.com>> wrote:
>
>     From: Dave Airlie <airlied@redhat.com <mailto:airlied@redhat.com>>
>
>     This interface will allow sync object to be used to back
>     Vulkan fences. This API is pretty much the vulkan fence waiting
>     API, and I've ported the code from amdgpu.
>
>     v2: accept relative timeout, pass remaining time back
>     to userspace.
>     v3: return to absolute timeouts.
>     v4: absolute zero = poll,
>         rewrite any/all code to have same operation for arrays
>         return -EINVAL for 0 fences.
>     v4.1: fixup fences allocation check, use u64_to_user_ptr
>     v5: move to sec/nsec, and use timespec64 for calcs.
>     v6: use -ETIME and drop the out status flag. (-ETIME
>     is suggested by ickle, I can feel a shed painting)
>
>     Signed-off-by: Dave Airlie <airlied@redhat.com
>     <mailto:airlied@redhat.com>>
>     ---
>      drivers/gpu/drm/drm_internal.h |   2 +
>      drivers/gpu/drm/drm_ioctl.c    |   2 +
>      drivers/gpu/drm/drm_syncobj.c  | 142
>     +++++++++++++++++++++++++++++++++++++++++
>      include/uapi/drm/drm.h         |  13 ++++
>      4 files changed, 159 insertions(+)
>
>     diff --git a/drivers/gpu/drm/drm_internal.h
>     b/drivers/gpu/drm/drm_internal.h
>     index 5cecc97..d71b50d 100644
>     --- a/drivers/gpu/drm/drm_internal.h
>     +++ b/drivers/gpu/drm/drm_internal.h
>     @@ -157,3 +157,5 @@ int drm_syncobj_handle_to_fd_ioctl(struct
>     drm_device *dev, void *data,
>                                        struct drm_file *file_private);
>      int drm_syncobj_fd_to_handle_ioctl(struct drm_device *dev, void
>     *data,
>                                        struct drm_file *file_private);
>     +int drm_syncobj_wait_ioctl(struct drm_device *dev, void *data,
>     +                          struct drm_file *file_private);
>     diff --git a/drivers/gpu/drm/drm_ioctl.c b/drivers/gpu/drm/drm_ioctl.c
>     index f1e5681..385ce74 100644
>     --- a/drivers/gpu/drm/drm_ioctl.c
>     +++ b/drivers/gpu/drm/drm_ioctl.c
>     @@ -657,6 +657,8 @@ static const struct drm_ioctl_desc
>     drm_ioctls[] = {
>                           DRM_UNLOCKED|DRM_RENDER_ALLOW),
>             DRM_IOCTL_DEF(DRM_IOCTL_SYNCOBJ_FD_TO_HANDLE,
>     drm_syncobj_fd_to_handle_ioctl,
>                           DRM_UNLOCKED|DRM_RENDER_ALLOW),
>     +       DRM_IOCTL_DEF(DRM_IOCTL_SYNCOBJ_WAIT, drm_syncobj_wait_ioctl,
>     +                     DRM_UNLOCKED|DRM_RENDER_ALLOW),
>      };
>
>      #define DRM_CORE_IOCTL_COUNT   ARRAY_SIZE( drm_ioctls )
>     diff --git a/drivers/gpu/drm/drm_syncobj.c
>     b/drivers/gpu/drm/drm_syncobj.c
>     index 89441bc..2d5a7a1 100644
>     --- a/drivers/gpu/drm/drm_syncobj.c
>     +++ b/drivers/gpu/drm/drm_syncobj.c
>     @@ -1,5 +1,7 @@
>      /*
>       * Copyright 2017 Red Hat
>     + * Parts ported from amdgpu (fence wait code).
>     + * Copyright 2016 Advanced Micro Devices, Inc.
>       *
>       * Permission is hereby granted, free of charge, to any person
>     obtaining a
>       * copy of this software and associated documentation files (the
>     "Software"),
>     @@ -31,6 +33,9 @@
>       * that contain an optional fence. The fence can be updated with
>     a new
>       * fence, or be NULL.
>       *
>     + * syncobj's can be waited upon, where it will wait for the
>     underlying
>     + * fence.
>     + *
>       * syncobj's can be export to fd's and back, these fd's are
>     opaque and
>       * have no other use case, except passing the syncobj between
>     processes.
>       *
>     @@ -451,3 +456,140 @@ drm_syncobj_fd_to_handle_ioctl(struct
>     drm_device *dev, void *data,
>             return drm_syncobj_fd_to_handle(file_private, args->fd,
>     &args->handle);
>      }
>     +
>     +/**
>     + * drm_timeout_abs_to_jiffies - calculate jiffies timeout from
>     absolute value
>     + *
>     + * @timeout_sec: timeout sec component, 0 for poll
>     + * @timeout_nsec: timeout nsec component in ns, 0 for poll
>     + * both must be 0 for poll.
>     + *
>     + * Calculate the timeout in jiffies from an absolute time in
>     sec/nsec.
>     + */
>     +static unsigned long drm_timeout_abs_to_jiffies(int64_t
>     timeout_sec, uint64_t timeout_nsec)
>     +{
>     +       struct timespec64 abs_timeout, timeout, max_jiffy_timespec;
>     +       unsigned long timeout_jiffies;
>     +
>     +       /* make 0 timeout means poll - absolute 0 doesn't seem
>     valid */
>     +       if (timeout_sec == 0 && timeout_nsec == 0)
>     +               return 0;
>     +
>     +       abs_timeout.tv_sec = timeout_sec;
>     +       abs_timeout.tv_nsec = timeout_nsec;
>     +
>     +       /* clamp timeout if it's to large */
>     +       if (!timespec64_valid_strict(&abs_timeout))
>     +               return MAX_SCHEDULE_TIMEOUT - 1;
>     +
>     +       timeout = timespec64_sub(abs_timeout,
>     ktime_to_timespec64(ktime_get()));
>     +       if (!timespec64_valid(&timeout))
>     +               return 0;
>     +
>     +       jiffies_to_timespec64(MAX_JIFFY_OFFSET, &max_jiffy_timespec);
>     +       if (timespec64_compare(&timeout, &max_jiffy_timespec) >= 0)
>     +               return MAX_SCHEDULE_TIMEOUT - 1;
>     +
>     +       timeout_jiffies = timespec64_to_jiffies(&timeout);
>     +       /*  clamp timeout to avoid infinite timeout */
>     +       if (timeout_jiffies >= MAX_SCHEDULE_TIMEOUT)
>     +               return MAX_SCHEDULE_TIMEOUT - 1;
>     +
>     +       return timeout_jiffies + 1;
>     +}
>     +
>     +static int drm_syncobj_wait_fences(struct drm_device *dev,
>     +                                  struct drm_file *file_private,
>     +                                  struct drm_syncobj_wait *wait,
>     +                                  struct dma_fence **fences)
>     +{
>     +       unsigned long timeout =
>     drm_timeout_abs_to_jiffies(wait->timeout_sec, wait->timeout_nsec);
>     +       int ret = 0;
>     +       uint32_t first = ~0;
>     +
>     +       if (wait->flags & DRM_SYNCOBJ_WAIT_FLAGS_WAIT_ALL) {
>     +               int i;
>     +               for (i = 0; i < wait->count_handles; i++) {
>     +                       ret = dma_fence_wait_timeout(fences[i],
>     true, timeout);
>     +
>     +                       if (ret < 0)
>     +                               return ret;
>     +                       if (ret == 0)
>     +                               break;
>     +                       timeout = ret;
>     +               }
>     +               first = 0;
>     +       } else {
>     +               ret = dma_fence_wait_any_timeout(fences,
>     + wait->count_handles,
>     +                                                true, timeout,
>     + &first);
>     +       }
>     +
>     +       if (ret < 0)
>     +               return ret;
>     +
>     +       wait->first_signaled = first;
>     +       if (ret == 0)
>     +               return -ETIME;
>     +       return 0;
>     +}
>     +
>     +int
>     +drm_syncobj_wait_ioctl(struct drm_device *dev, void *data,
>     +                      struct drm_file *file_private)
>     +{
>     +       struct drm_syncobj_wait *args = data;
>     +       uint32_t *handles;
>     +       struct dma_fence **fences;
>     +       int ret = 0;
>     +       int i;
>     +
>     +       if (!drm_core_check_feature(dev, DRIVER_SYNCOBJ))
>     +               return -ENODEV;
>     +
>     +       if (args->flags != 0 && args->flags !=
>     DRM_SYNCOBJ_WAIT_FLAGS_WAIT_ALL)
>     +               return -EINVAL;
>     +
>     +       if (args->count_handles == 0)
>     +               return -EINVAL;
>     +
>     +       /* Get the handles from userspace */
>     +       handles = kmalloc_array(args->count_handles, sizeof(uint32_t),
>     +                               GFP_KERNEL);
>     +       if (handles == NULL)
>     +               return -ENOMEM;
>     +
>     +       if (copy_from_user(handles,
>     + u64_to_user_ptr(args->handles),
>     +                          sizeof(uint32_t) * args->count_handles)) {
>     +               ret = -EFAULT;
>     +               goto err_free_handles;
>     +       }
>     +
>     +       fences = kcalloc(args->count_handles,
>     +                        sizeof(struct dma_fence *), GFP_KERNEL);
>     +       if (!fences) {
>     +               ret = -ENOMEM;
>     +               goto err_free_handles;
>     +       }
>     +
>     +       for (i = 0; i < args->count_handles; i++) {
>     +               ret = drm_syncobj_fence_get(file_private, handles[i],
>     +  &fences[i]);
>     +               if (ret)
>     +                       goto err_free_fence_array;
>     +       }
>     +
>     +       ret = drm_syncobj_wait_fences(dev, file_private,
>     +                                     args, fences);
>
>
> So, reading some CTS tests again, and I think we have a problem here.  
> The Vulkan spec allows you to wait on a fence that is in the 
> unsignaled state.

At least on the closed source driver that would be illegal as far as I know.

You can't wait on a semaphore before the signal operation is send down 
to the kernel.

Regards,
Christian.

>   In theory, you could have thread A start waiting on a fence before 
> thread B submits the work which triggers that fence.  This means that 
> the dma_fence may not exist yet when vkWaitForFences gets called.  If 
> we really want to support the full Vulkan usage, we need to somehow 
> support missing dma_fences by waiting for the dma_fence to show up.  
> Unfortunately, I don't know enough about the internal kernel APIs to 
> know what that would look like.
>
>     +
>     +err_free_fence_array:
>     +       for (i = 0; i < args->count_handles; i++)
>     +               dma_fence_put(fences[i]);
>     +       kfree(fences);
>     +err_free_handles:
>     +       kfree(handles);
>     +
>     +       return ret;
>     +}
>     diff --git a/include/uapi/drm/drm.h b/include/uapi/drm/drm.h
>     index 101593a..91746a7 100644
>     --- a/include/uapi/drm/drm.h
>     +++ b/include/uapi/drm/drm.h
>     @@ -718,6 +718,18 @@ struct drm_syncobj_handle {
>             __u32 pad;
>      };
>
>     +#define DRM_SYNCOBJ_WAIT_FLAGS_WAIT_ALL (1 << 0)
>     +struct drm_syncobj_wait {
>     +       __u64 handles;
>     +       /* absolute timeout */
>     +       __s64 timeout_sec;
>     +       __s64 timeout_nsec;
>     +       __u32 count_handles;
>     +       __u32 flags;
>     +       __u32 first_signaled; /* only valid when not waiting all */
>     +       __u32 pad;
>     +};
>     +
>      #if defined(__cplusplus)
>      }
>      #endif
>     @@ -840,6 +852,7 @@ extern "C" {
>      #define DRM_IOCTL_SYNCOBJ_DESTROY      DRM_IOWR(0xC0, struct
>     drm_syncobj_destroy)
>      #define DRM_IOCTL_SYNCOBJ_HANDLE_TO_FD DRM_IOWR(0xC1, struct
>     drm_syncobj_handle)
>      #define DRM_IOCTL_SYNCOBJ_FD_TO_HANDLE DRM_IOWR(0xC2, struct
>     drm_syncobj_handle)
>     +#define DRM_IOCTL_SYNCOBJ_WAIT         DRM_IOWR(0xC3, struct
>     drm_syncobj_wait)
>
>      /**
>       * Device specific ioctls should only be in their respective headers
>     --
>     2.9.4
>
>     _______________________________________________
>     dri-devel mailing list
>     dri-devel@lists.freedesktop.org
>     <mailto:dri-devel@lists.freedesktop.org>
>     https://lists.freedesktop.org/mailman/listinfo/dri-devel
>     <https://lists.freedesktop.org/mailman/listinfo/dri-devel>
>
>
>
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx



--------------B644DC3FFFAD698C9AB23E59
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: 8bit

<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body text="#000000" bgcolor="#FFFFFF">
    <div class="moz-cite-prefix">Am 10.07.2017 um 17:28 schrieb Jason
      Ekstrand:<br>
    </div>
    <blockquote type="cite"
cite="mid:CAOFGe94mA9i7+-XTJQn65N-vK_GbQwvjru2b=6ucXejpWWmx4g@mail.gmail.com">
      <div dir="ltr">
        <div class="gmail_extra">
          <div class="gmail_quote">On Wed, Jul 5, 2017 at 6:04 PM, Dave
            Airlie <span dir="ltr">&lt;<a
                href="mailto:airlied@gmail.com" target="_blank"
                moz-do-not-send="true">airlied@gmail.com</a>&gt;</span>
            wrote:<br>
            <blockquote class="gmail_quote" style="margin:0 0 0
              .8ex;border-left:1px #ccc solid;padding-left:1ex">From:
              Dave Airlie &lt;<a href="mailto:airlied@redhat.com"
                moz-do-not-send="true">airlied@redhat.com</a>&gt;<br>
              <br>
              This interface will allow sync object to be used to back<br>
              Vulkan fences. This API is pretty much the vulkan fence
              waiting<br>
              API, and I've ported the code from amdgpu.<br>
              <br>
              v2: accept relative timeout, pass remaining time back<br>
              to userspace.<br>
              v3: return to absolute timeouts.<br>
              v4: absolute zero = poll,<br>
                  rewrite any/all code to have same operation for arrays<br>
                  return -EINVAL for 0 fences.<br>
              v4.1: fixup fences allocation check, use u64_to_user_ptr<br>
              v5: move to sec/nsec, and use timespec64 for calcs.<br>
              v6: use -ETIME and drop the out status flag. (-ETIME<br>
              is suggested by ickle, I can feel a shed painting)<br>
              <br>
              Signed-off-by: Dave Airlie &lt;<a
                href="mailto:airlied@redhat.com" moz-do-not-send="true">airlied@redhat.com</a>&gt;<br>
              ---<br>
               drivers/gpu/drm/drm_internal.h |   2 +<br>
               drivers/gpu/drm/drm_ioctl.c    |   2 +<br>
               drivers/gpu/drm/drm_syncobj.c  | 142
              ++++++++++++++++++++++++++++++<wbr>+++++++++++<br>
               include/uapi/drm/drm.h         |  13 ++++<br>
               4 files changed, 159 insertions(+)<br>
              <br>
              diff --git a/drivers/gpu/drm/drm_<wbr>internal.h
              b/drivers/gpu/drm/drm_<wbr>internal.h<br>
              index 5cecc97..d71b50d 100644<br>
              --- a/drivers/gpu/drm/drm_<wbr>internal.h<br>
              +++ b/drivers/gpu/drm/drm_<wbr>internal.h<br>
              @@ -157,3 +157,5 @@ int drm_syncobj_handle_to_fd_<wbr>ioctl(struct
              drm_device *dev, void *data,<br>
                                                 struct drm_file
              *file_private);<br>
               int drm_syncobj_fd_to_handle_<wbr>ioctl(struct drm_device
              *dev, void *data,<br>
                                                 struct drm_file
              *file_private);<br>
              +int drm_syncobj_wait_ioctl(struct drm_device *dev, void
              *data,<br>
              +                          struct drm_file *file_private);<br>
              diff --git a/drivers/gpu/drm/drm_ioctl.c
              b/drivers/gpu/drm/drm_ioctl.c<br>
              index f1e5681..385ce74 100644<br>
              --- a/drivers/gpu/drm/drm_ioctl.c<br>
              +++ b/drivers/gpu/drm/drm_ioctl.c<br>
              @@ -657,6 +657,8 @@ static const struct drm_ioctl_desc
              drm_ioctls[] = {<br>
                                    DRM_UNLOCKED|DRM_RENDER_ALLOW)<wbr>,<br>
                      DRM_IOCTL_DEF(DRM_IOCTL_<wbr>SYNCOBJ_FD_TO_HANDLE,
              drm_syncobj_fd_to_handle_<wbr>ioctl,<br>
                                    DRM_UNLOCKED|DRM_RENDER_ALLOW)<wbr>,<br>
              +       DRM_IOCTL_DEF(DRM_IOCTL_<wbr>SYNCOBJ_WAIT,
              drm_syncobj_wait_ioctl,<br>
              +                     DRM_UNLOCKED|DRM_RENDER_ALLOW)<wbr>,<br>
               };<br>
              <br>
               #define DRM_CORE_IOCTL_COUNT   ARRAY_SIZE( drm_ioctls )<br>
              diff --git a/drivers/gpu/drm/drm_syncobj.<wbr>c
              b/drivers/gpu/drm/drm_syncobj.<wbr>c<br>
              index 89441bc..2d5a7a1 100644<br>
              --- a/drivers/gpu/drm/drm_syncobj.<wbr>c<br>
              +++ b/drivers/gpu/drm/drm_syncobj.<wbr>c<br>
              @@ -1,5 +1,7 @@<br>
               /*<br>
                * Copyright 2017 Red Hat<br>
              + * Parts ported from amdgpu (fence wait code).<br>
              + * Copyright 2016 Advanced Micro Devices, Inc.<br>
                *<br>
                * Permission is hereby granted, free of charge, to any
              person obtaining a<br>
                * copy of this software and associated documentation
              files (the "Software"),<br>
              @@ -31,6 +33,9 @@<br>
                * that contain an optional fence. The fence can be
              updated with a new<br>
                * fence, or be NULL.<br>
                *<br>
              + * syncobj's can be waited upon, where it will wait for
              the underlying<br>
              + * fence.<br>
              + *<br>
                * syncobj's can be export to fd's and back, these fd's
              are opaque and<br>
                * have no other use case, except passing the syncobj
              between processes.<br>
                *<br>
              @@ -451,3 +456,140 @@ drm_syncobj_fd_to_handle_<wbr>ioctl(struct
              drm_device *dev, void *data,<br>
                      return drm_syncobj_fd_to_handle(file_<wbr>private,
              args-&gt;fd,<br>
                                                     
              &amp;args-&gt;handle);<br>
               }<br>
              +<br>
              +/**<br>
              + * drm_timeout_abs_to_jiffies - calculate jiffies timeout
              from absolute value<br>
              + *<br>
              + * @timeout_sec: timeout sec component, 0 for poll<br>
              + * @timeout_nsec: timeout nsec component in ns, 0 for
              poll<br>
              + * both must be 0 for poll.<br>
              + *<br>
              + * Calculate the timeout in jiffies from an absolute time
              in sec/nsec.<br>
              + */<br>
              +static unsigned long drm_timeout_abs_to_jiffies(<wbr>int64_t
              timeout_sec, uint64_t timeout_nsec)<br>
              +{<br>
              +       struct timespec64 abs_timeout, timeout,
              max_jiffy_timespec;<br>
              +       unsigned long timeout_jiffies;<br>
              +<br>
              +       /* make 0 timeout means poll - absolute 0 doesn't
              seem valid */<br>
              +       if (timeout_sec == 0 &amp;&amp; timeout_nsec == 0)<br>
              +               return 0;<br>
              +<br>
              +       abs_timeout.tv_sec = timeout_sec;<br>
              +       abs_timeout.tv_nsec = timeout_nsec;<br>
              +<br>
              +       /* clamp timeout if it's to large */<br>
              +       if (!timespec64_valid_strict(&amp;<wbr>abs_timeout))<br>
              +               return MAX_SCHEDULE_TIMEOUT - 1;<br>
              +<br>
              +       timeout = timespec64_sub(abs_timeout,
              ktime_to_timespec64(ktime_get(<wbr>)));<br>
              +       if (!timespec64_valid(&amp;timeout))<br>
              +               return 0;<br>
              +<br>
              +       jiffies_to_timespec64(MAX_<wbr>JIFFY_OFFSET,
              &amp;max_jiffy_timespec);<br>
              +       if (timespec64_compare(&amp;timeout,
              &amp;max_jiffy_timespec) &gt;= 0)<br>
              +               return MAX_SCHEDULE_TIMEOUT - 1;<br>
              +<br>
              +       timeout_jiffies = timespec64_to_jiffies(&amp;<wbr>timeout);<br>
              +       /*  clamp timeout to avoid infinite timeout */<br>
              +       if (timeout_jiffies &gt;= MAX_SCHEDULE_TIMEOUT)<br>
              +               return MAX_SCHEDULE_TIMEOUT - 1;<br>
              +<br>
              +       return timeout_jiffies + 1;<br>
              +}<br>
              +<br>
              +static int drm_syncobj_wait_fences(struct drm_device
              *dev,<br>
              +                                  struct drm_file
              *file_private,<br>
              +                                  struct drm_syncobj_wait
              *wait,<br>
              +                                  struct dma_fence
              **fences)<br>
              +{<br>
              +       unsigned long timeout =
              drm_timeout_abs_to_jiffies(<wbr>wait-&gt;timeout_sec,
              wait-&gt;timeout_nsec);<br>
              +       int ret = 0;<br>
              +       uint32_t first = ~0;<br>
              +<br>
              +       if (wait-&gt;flags &amp;
              DRM_SYNCOBJ_WAIT_FLAGS_WAIT_<wbr>ALL) {<br>
              +               int i;<br>
              +               for (i = 0; i &lt; wait-&gt;count_handles;
              i++) {<br>
              +                       ret =
              dma_fence_wait_timeout(fences[<wbr>i], true, timeout);<br>
              +<br>
              +                       if (ret &lt; 0)<br>
              +                               return ret;<br>
              +                       if (ret == 0)<br>
              +                               break;<br>
              +                       timeout = ret;<br>
              +               }<br>
              +               first = 0;<br>
              +       } else {<br>
              +               ret = dma_fence_wait_any_timeout(<wbr>fences,<br>
              +                                               
              wait-&gt;count_handles,<br>
              +                                                true,
              timeout,<br>
              +                                               
              &amp;first);<br>
              +       }<br>
              +<br>
              +       if (ret &lt; 0)<br>
              +               return ret;<br>
              +<br>
              +       wait-&gt;first_signaled = first;<br>
              +       if (ret == 0)<br>
              +               return -ETIME;<br>
              +       return 0;<br>
              +}<br>
              +<br>
              +int<br>
              +drm_syncobj_wait_ioctl(struct drm_device *dev, void
              *data,<br>
              +                      struct drm_file *file_private)<br>
              +{<br>
              +       struct drm_syncobj_wait *args = data;<br>
              +       uint32_t *handles;<br>
              +       struct dma_fence **fences;<br>
              +       int ret = 0;<br>
              +       int i;<br>
              +<br>
              +       if (!drm_core_check_feature(dev, DRIVER_SYNCOBJ))<br>
              +               return -ENODEV;<br>
              +<br>
              +       if (args-&gt;flags != 0 &amp;&amp; args-&gt;flags
              != DRM_SYNCOBJ_WAIT_FLAGS_WAIT_<wbr>ALL)<br>
              +               return -EINVAL;<br>
              +<br>
              +       if (args-&gt;count_handles == 0)<br>
              +               return -EINVAL;<br>
              +<br>
              +       /* Get the handles from userspace */<br>
              +       handles = kmalloc_array(args-&gt;count_<wbr>handles,
              sizeof(uint32_t),<br>
              +                               GFP_KERNEL);<br>
              +       if (handles == NULL)<br>
              +               return -ENOMEM;<br>
              +<br>
              +       if (copy_from_user(handles,<br>
              +                         
              u64_to_user_ptr(args-&gt;handles)<wbr>,<br>
              +                          sizeof(uint32_t) *
              args-&gt;count_handles)) {<br>
              +               ret = -EFAULT;<br>
              +               goto err_free_handles;<br>
              +       }<br>
              +<br>
              +       fences = kcalloc(args-&gt;count_handles,<br>
              +                        sizeof(struct dma_fence *),
              GFP_KERNEL);<br>
              +       if (!fences) {<br>
              +               ret = -ENOMEM;<br>
              +               goto err_free_handles;<br>
              +       }<br>
              +<br>
              +       for (i = 0; i &lt; args-&gt;count_handles; i++) {<br>
              +               ret = drm_syncobj_fence_get(file_<wbr>private,
              handles[i],<br>
              +                                         
               &amp;fences[i]);<br>
              +               if (ret)<br>
              +                       goto err_free_fence_array;<br>
              +       }<br>
              +<br>
              +       ret = drm_syncobj_wait_fences(dev, file_private,<br>
              +                                     args, fences);<br>
            </blockquote>
            <div><br>
            </div>
            <div>So, reading some CTS tests again, and I think we have a
              problem here.  The Vulkan spec allows you to wait on a
              fence that is in the unsignaled state.</div>
          </div>
        </div>
      </div>
    </blockquote>
    <br>
    At least on the closed source driver that would be illegal as far as
    I know.<br>
    <br>
    You can't wait on a semaphore before the signal operation is send
    down to the kernel.<br>
    <br>
    Regards,<br>
    Christian.<br>
    <br>
    <blockquote type="cite"
cite="mid:CAOFGe94mA9i7+-XTJQn65N-vK_GbQwvjru2b=6ucXejpWWmx4g@mail.gmail.com">
      <div dir="ltr">
        <div class="gmail_extra">
          <div class="gmail_quote">
            <div>  In theory, you could have thread A start waiting on a
              fence before thread B submits the work which triggers that
              fence.  This means that the dma_fence may not exist yet
              when vkWaitForFences gets called.  If we really want to
              support the full Vulkan usage, we need to somehow support
              missing dma_fences by waiting for the dma_fence to show
              up.  Unfortunately, I don't know enough about the internal
              kernel APIs to know what that would look like.<br>
            </div>
          </div>
        </div>
      </div>
    </blockquote>
    <blockquote type="cite"
cite="mid:CAOFGe94mA9i7+-XTJQn65N-vK_GbQwvjru2b=6ucXejpWWmx4g@mail.gmail.com">
      <div dir="ltr">
        <div class="gmail_extra">
          <div class="gmail_quote">
            <div> </div>
            <blockquote class="gmail_quote" style="margin:0 0 0
              .8ex;border-left:1px #ccc solid;padding-left:1ex">
              +<br>
              +err_free_fence_array:<br>
              +       for (i = 0; i &lt; args-&gt;count_handles; i++)<br>
              +               dma_fence_put(fences[i]);<br>
              +       kfree(fences);<br>
              +err_free_handles:<br>
              +       kfree(handles);<br>
              +<br>
              +       return ret;<br>
              +}<br>
              diff --git a/include/uapi/drm/drm.h
              b/include/uapi/drm/drm.h<br>
              index 101593a..91746a7 100644<br>
              --- a/include/uapi/drm/drm.h<br>
              +++ b/include/uapi/drm/drm.h<br>
              @@ -718,6 +718,18 @@ struct drm_syncobj_handle {<br>
                      __u32 pad;<br>
               };<br>
              <br>
              +#define DRM_SYNCOBJ_WAIT_FLAGS_WAIT_<wbr>ALL (1 &lt;&lt;
              0)<br>
              +struct drm_syncobj_wait {<br>
              +       __u64 handles;<br>
              +       /* absolute timeout */<br>
              +       __s64 timeout_sec;<br>
              +       __s64 timeout_nsec;<br>
              +       __u32 count_handles;<br>
              +       __u32 flags;<br>
              +       __u32 first_signaled; /* only valid when not
              waiting all */<br>
              +       __u32 pad;<br>
              +};<br>
              +<br>
               #if defined(__cplusplus)<br>
               }<br>
               #endif<br>
              @@ -840,6 +852,7 @@ extern "C" {<br>
               #define DRM_IOCTL_SYNCOBJ_DESTROY      DRM_IOWR(0xC0,
              struct drm_syncobj_destroy)<br>
               #define DRM_IOCTL_SYNCOBJ_HANDLE_TO_FD DRM_IOWR(0xC1,
              struct drm_syncobj_handle)<br>
               #define DRM_IOCTL_SYNCOBJ_FD_TO_HANDLE DRM_IOWR(0xC2,
              struct drm_syncobj_handle)<br>
              +#define DRM_IOCTL_SYNCOBJ_WAIT         DRM_IOWR(0xC3,
              struct drm_syncobj_wait)<br>
              <br>
               /**<br>
                * Device specific ioctls should only be in their
              respective headers<br>
              <span class="HOEnZb"><font color="#888888">--<br>
                  2.9.4<br>
                  <br>
                  ______________________________<wbr>_________________<br>
                  dri-devel mailing list<br>
                  <a href="mailto:dri-devel@lists.freedesktop.org"
                    moz-do-not-send="true">dri-devel@lists.freedesktop.<wbr>org</a><br>
                  <a
                    href="https://lists.freedesktop.org/mailman/listinfo/dri-devel"
                    rel="noreferrer" target="_blank"
                    moz-do-not-send="true">https://lists.freedesktop.org/<wbr>mailman/listinfo/dri-devel</a><br>
                </font></span></blockquote>
          </div>
          <br>
        </div>
      </div>
      <br>
      <fieldset class="mimeAttachmentHeader"></fieldset>
      <br>
      <pre wrap="">_______________________________________________
amd-gfx mailing list
<a class="moz-txt-link-abbreviated" href="mailto:amd-gfx@lists.freedesktop.org">amd-gfx@lists.freedesktop.org</a>
<a class="moz-txt-link-freetext" href="https://lists.freedesktop.org/mailman/listinfo/amd-gfx">https://lists.freedesktop.org/mailman/listinfo/amd-gfx</a>
</pre>
    </blockquote>
    <p><br>
    </p>
  </body>
</html>

--------------B644DC3FFFAD698C9AB23E59--

--===============0552402068==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KZHJpLWRldmVs
IG1haWxpbmcgbGlzdApkcmktZGV2ZWxAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlz
dHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vZHJpLWRldmVsCg==

--===============0552402068==--
