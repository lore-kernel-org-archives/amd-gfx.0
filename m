From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 3/6] drm: add support of syncobj timeline point wait v2
Date: Tue, 25 Sep 2018 11:49:48 +0200
Message-ID: <ba634e07-0373-5e76-bc65-416dcec6fd1f@gmail.com>
References: <20180920110353.16114-1-david1.zhou@amd.com>
 <20180920110353.16114-3-david1.zhou@amd.com>
 <CAOFGe96fXDQ8Q1piYCWhn2Z8ToOmf1JXyu+2YgUWYbMLCX7nzg@mail.gmail.com>
Reply-To: christian.koenig-5C7GfCeVMHo@public.gmane.org
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1205660734=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <CAOFGe96fXDQ8Q1piYCWhn2Z8ToOmf1JXyu+2YgUWYbMLCX7nzg-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Content-Language: en-US
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
To: Jason Ekstrand <jason-fQELhIk9awXprZlt/sZkLg@public.gmane.org>, zhoucm1 <david1.zhou-5C7GfCeVMHo@public.gmane.org>
Cc: Maling list - DRI developers <dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, amd-gfx mailing list <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

This is a multi-part message in MIME format.
--===============1205660734==
Content-Type: multipart/alternative;
 boundary="------------625346D08C5ACBB335A03587"
Content-Language: en-US

This is a multi-part message in MIME format.
--------------625346D08C5ACBB335A03587
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit

Am 25.09.2018 um 11:22 schrieb Jason Ekstrand:
> On Thu, Sep 20, 2018 at 6:04 AM Chunming Zhou <david1.zhou-5C7GfCeVMHo@public.gmane.org 
> <mailto:david1.zhou-5C7GfCeVMHo@public.gmane.org>> wrote:
>
>     points array is one-to-one match with syncobjs array.
>     v2:
>     add seperate ioctl for timeline point wait, otherwise break uapi.
>
>
> I think ioctl structs can be extended as long as fields aren't 
> re-ordered.  I'm not sure on the details of this though as I'm not a 
> particularly experienced kernel developer.

Yeah, that is correct. The problem in this particular case is that we 
don't change the direct IOCTL parameter, but rather the array it points to.

We could do something like keep the existing handles array and add a 
separate optional one for the timeline points. That would also drop the 
need for the padding of the structure.

> Another general comment (no good place to put it) is that I think we 
> want two kinds of waits:  Wait for time point to be completed and wait 
> for time point to become available. The first is the usual CPU wait 
> for completion while the second is for use by userspace drivers to 
> wait until the first moment where they can submit work which depends 
> on a given time point.

Oh, yeah that is a really good point as ell.

Christian.

>     Signed-off-by: Chunming Zhou <david1.zhou-5C7GfCeVMHo@public.gmane.org
>     <mailto:david1.zhou-5C7GfCeVMHo@public.gmane.org>>
>     ---
>      drivers/gpu/drm/drm_internal.h |  2 +
>      drivers/gpu/drm/drm_ioctl.c    |  2 +
>      drivers/gpu/drm/drm_syncobj.c  | 99
>     +++++++++++++++++++++++++++++-----
>      include/uapi/drm/drm.h         | 14 +++++
>      4 files changed, 103 insertions(+), 14 deletions(-)
>
>     diff --git a/drivers/gpu/drm/drm_internal.h
>     b/drivers/gpu/drm/drm_internal.h
>     index 0c4eb4a9ab31..566d44e3c782 100644
>     --- a/drivers/gpu/drm/drm_internal.h
>     +++ b/drivers/gpu/drm/drm_internal.h
>     @@ -183,6 +183,8 @@ int drm_syncobj_fd_to_handle_ioctl(struct
>     drm_device *dev, void *data,
>                                        struct drm_file *file_private);
>      int drm_syncobj_wait_ioctl(struct drm_device *dev, void *data,
>                                struct drm_file *file_private);
>     +int drm_syncobj_timeline_wait_ioctl(struct drm_device *dev, void
>     *data,
>     +                                   struct drm_file *file_private);
>      int drm_syncobj_reset_ioctl(struct drm_device *dev, void *data,
>                                 struct drm_file *file_private);
>      int drm_syncobj_signal_ioctl(struct drm_device *dev, void *data,
>     diff --git a/drivers/gpu/drm/drm_ioctl.c b/drivers/gpu/drm/drm_ioctl.c
>     index 6b4a633b4240..c0891614f516 100644
>     --- a/drivers/gpu/drm/drm_ioctl.c
>     +++ b/drivers/gpu/drm/drm_ioctl.c
>     @@ -669,6 +669,8 @@ static const struct drm_ioctl_desc
>     drm_ioctls[] = {
>                           DRM_UNLOCKED|DRM_RENDER_ALLOW),
>             DRM_IOCTL_DEF(DRM_IOCTL_SYNCOBJ_WAIT, drm_syncobj_wait_ioctl,
>                           DRM_UNLOCKED|DRM_RENDER_ALLOW),
>     +       DRM_IOCTL_DEF(DRM_IOCTL_SYNCOBJ_TIMELINE_WAIT,
>     drm_syncobj_timeline_wait_ioctl,
>     +                     DRM_UNLOCKED|DRM_RENDER_ALLOW),
>             DRM_IOCTL_DEF(DRM_IOCTL_SYNCOBJ_RESET,
>     drm_syncobj_reset_ioctl,
>                           DRM_UNLOCKED|DRM_RENDER_ALLOW),
>             DRM_IOCTL_DEF(DRM_IOCTL_SYNCOBJ_SIGNAL,
>     drm_syncobj_signal_ioctl,
>     diff --git a/drivers/gpu/drm/drm_syncobj.c
>     b/drivers/gpu/drm/drm_syncobj.c
>     index 67472bd77c83..a43de0e4616c 100644
>     --- a/drivers/gpu/drm/drm_syncobj.c
>     +++ b/drivers/gpu/drm/drm_syncobj.c
>     @@ -126,13 +126,14 @@ static void
>     drm_syncobj_add_callback_locked(struct drm_syncobj *syncobj,
>      }
>
>      static int drm_syncobj_fence_get_or_add_callback(struct
>     drm_syncobj *syncobj,
>     +                                                u64 point,
>                                                      struct dma_fence
>     **fence,
>                                                      struct
>     drm_syncobj_cb *cb,
>      drm_syncobj_func_t func)
>      {
>             int ret;
>
>     -       ret = drm_syncobj_search_fence(syncobj, 0, 0, fence);
>     +       ret = drm_syncobj_search_fence(syncobj, point, 0, fence);
>             if (!ret)
>                     return 1;
>
>     @@ -143,7 +144,7 @@ static int
>     drm_syncobj_fence_get_or_add_callback(struct drm_syncobj *syncobj,
>              */
>             if (!list_empty(&syncobj->signal_pt_list)) {
>                     spin_unlock(&syncobj->lock);
>     -               drm_syncobj_search_fence(syncobj, 0, 0, fence);
>     +               drm_syncobj_search_fence(syncobj, point, 0, fence);
>                     if (*fence)
>                             return 1;
>                     spin_lock(&syncobj->lock);
>     @@ -358,7 +359,9 @@ void drm_syncobj_replace_fence(struct
>     drm_syncobj *syncobj,
>                     spin_lock(&syncobj->lock);
>                     list_for_each_entry_safe(cur, tmp,
>     &syncobj->cb_list, node) {
>                             list_del_init(&cur->node);
>     +                       spin_unlock(&syncobj->lock);
>                             cur->func(syncobj, cur);
>     +                       spin_lock(&syncobj->lock);
>                     }
>                     spin_unlock(&syncobj->lock);
>             }
>     @@ -856,6 +859,7 @@ struct syncobj_wait_entry {
>             struct dma_fence *fence;
>             struct dma_fence_cb fence_cb;
>             struct drm_syncobj_cb syncobj_cb;
>     +       u64    point;
>      };
>
>      static void syncobj_wait_fence_func(struct dma_fence *fence,
>     @@ -873,12 +877,13 @@ static void syncobj_wait_syncobj_func(struct
>     drm_syncobj *syncobj,
>             struct syncobj_wait_entry *wait =
>                     container_of(cb, struct syncobj_wait_entry,
>     syncobj_cb);
>
>     -       drm_syncobj_search_fence(syncobj, 0, 0, &wait->fence);
>     +       drm_syncobj_search_fence(syncobj, wait->point, 0,
>     &wait->fence);
>
>             wake_up_process(wait->task);
>      }
>
>      static signed long drm_syncobj_array_wait_timeout(struct
>     drm_syncobj **syncobjs,
>     +                                                 void __user
>     *user_points,
>                                                       uint32_t count,
>                                                       uint32_t flags,
>                                                       signed long timeout,
>     @@ -886,13 +891,27 @@ static signed long
>     drm_syncobj_array_wait_timeout(struct drm_syncobj **syncobjs,
>      {
>             struct syncobj_wait_entry *entries;
>             struct dma_fence *fence;
>     +       uint64_t *points;
>             signed long ret;
>             uint32_t signaled_count, i;
>
>     -       entries = kcalloc(count, sizeof(*entries), GFP_KERNEL);
>     -       if (!entries)
>     +       points = kmalloc_array(count, sizeof(*points), GFP_KERNEL);
>     +       if (points == NULL)
>                     return -ENOMEM;
>
>     +       if (!user_points) {
>     +               memset(points, 0, count * sizeof(uint64_t));
>     +       } else if (copy_from_user(points, user_points,
>     sizeof(uint64_t) * count)) {
>     +               ret = -EFAULT;
>     +               goto err_free_points;
>     +       }
>     +
>     +
>     +       entries = kcalloc(count, sizeof(*entries), GFP_KERNEL);
>     +       if (!entries) {
>     +               ret = -ENOMEM;
>     +               goto err_free_points;
>     +       }
>             /* Walk the list of sync objects and initialize entries. 
>     We do
>              * this up-front so that we can properly return -EINVAL if
>     there is
>              * a syncobj with a missing fence and then never have the
>     chance of
>     @@ -901,7 +920,8 @@ static signed long
>     drm_syncobj_array_wait_timeout(struct drm_syncobj **syncobjs,
>             signaled_count = 0;
>             for (i = 0; i < count; ++i) {
>                     entries[i].task = current;
>     -               ret = drm_syncobj_search_fence(syncobjs[i], 0, 0,
>     +               entries[i].point = points[i];
>     +               ret = drm_syncobj_search_fence(syncobjs[i],
>     points[i], 0,
>      &entries[i].fence);
>                     if (!entries[i].fence) {
>                             if (flags &
>     DRM_SYNCOBJ_WAIT_FLAGS_WAIT_FOR_SUBMIT) {
>     @@ -940,6 +960,7 @@ static signed long
>     drm_syncobj_array_wait_timeout(struct drm_syncobj **syncobjs,
>             if (flags & DRM_SYNCOBJ_WAIT_FLAGS_WAIT_FOR_SUBMIT) {
>                     for (i = 0; i < count; ++i) {
>     drm_syncobj_fence_get_or_add_callback(syncobjs[i],
>     +  entries[i].point,
>       &entries[i].fence,
>       &entries[i].syncobj_cb,
>       syncobj_wait_syncobj_func);
>     @@ -1003,6 +1024,9 @@ static signed long
>     drm_syncobj_array_wait_timeout(struct drm_syncobj **syncobjs,
>             }
>             kfree(entries);
>
>     +err_free_points:
>     +       kfree(points);
>     +
>             return ret;
>      }
>
>     @@ -1041,20 +1065,33 @@ static signed long
>     drm_timeout_abs_to_jiffies(int64_t timeout_nsec)
>      static int drm_syncobj_array_wait(struct drm_device *dev,
>                                       struct drm_file *file_private,
>                                       struct drm_syncobj_wait *wait,
>     -                                 struct drm_syncobj **syncobjs)
>     +                                 struct drm_syncobj_timeline_wait
>     *timeline_wait,
>     +                                 struct drm_syncobj **syncobjs,
>     bool timeline)
>      {
>     -       signed long timeout =
>     drm_timeout_abs_to_jiffies(wait->timeout_nsec);
>     +       signed long timeout = 0;
>             signed long ret = 0;
>             uint32_t first = ~0;
>
>     -       ret = drm_syncobj_array_wait_timeout(syncobjs,
>     - wait->count_handles,
>     -                                            wait->flags,
>     -                                            timeout, &first);
>     +       if (!timeline) {
>     +               timeout =
>     drm_timeout_abs_to_jiffies(wait->timeout_nsec);
>     +               ret = drm_syncobj_array_wait_timeout(syncobjs,
>     +                                                    NULL,
>     + wait->count_handles,
>     + wait->flags,
>     + timeout, &first);
>     +               wait->first_signaled = first;
>     +       } else {
>     +               timeout =
>     drm_timeout_abs_to_jiffies(timeline_wait->timeout_nsec);
>     +               ret = drm_syncobj_array_wait_timeout(syncobjs,
>     + u64_to_user_ptr(timeline_wait->points),
>     + timeline_wait->count_handles,
>     + timeline_wait->flags,
>     + timeout, &first);
>     +               timeline_wait->first_signaled = first;
>     +       }
>             if (ret < 0)
>                     return ret;
>
>     -       wait->first_signaled = first;
>             if (ret == 0)
>                     return -ETIME;
>             return 0;
>     @@ -1142,13 +1179,47 @@ drm_syncobj_wait_ioctl(struct drm_device
>     *dev, void *data,
>                     return ret;
>
>             ret = drm_syncobj_array_wait(dev, file_private,
>     -                                    args, syncobjs);
>     +                                    args, NULL, syncobjs, false);
>
>             drm_syncobj_array_free(syncobjs, args->count_handles);
>
>             return ret;
>      }
>
>     +int
>     +drm_syncobj_timeline_wait_ioctl(struct drm_device *dev, void *data,
>     +                               struct drm_file *file_private)
>     +{
>     +       struct drm_syncobj_timeline_wait *args = data;
>     +       struct drm_syncobj **syncobjs;
>     +       int ret = 0;
>     +
>     +       if (!drm_core_check_feature(dev, DRIVER_SYNCOBJ))
>     +               return -ENODEV;
>     +
>     +       if (args->flags & ~(DRM_SYNCOBJ_WAIT_FLAGS_WAIT_ALL |
>     +  DRM_SYNCOBJ_WAIT_FLAGS_WAIT_FOR_SUBMIT))
>     +               return -EINVAL;
>     +
>     +       if (args->count_handles == 0)
>     +               return -EINVAL;
>     +
>     +       ret = drm_syncobj_array_find(file_private,
>     + u64_to_user_ptr(args->handles),
>     +                                    args->count_handles,
>     +                                    &syncobjs);
>     +       if (ret < 0)
>     +               return ret;
>     +
>     +       ret = drm_syncobj_array_wait(dev, file_private,
>     +                                    NULL, args, syncobjs, true);
>     +
>     +       drm_syncobj_array_free(syncobjs, args->count_handles);
>     +
>     +       return ret;
>     +}
>     +
>     +
>      int
>      drm_syncobj_reset_ioctl(struct drm_device *dev, void *data,
>                             struct drm_file *file_private)
>     diff --git a/include/uapi/drm/drm.h b/include/uapi/drm/drm.h
>     index cebdb2541eb7..501e86d81f47 100644
>     --- a/include/uapi/drm/drm.h
>     +++ b/include/uapi/drm/drm.h
>     @@ -748,6 +748,19 @@ struct drm_syncobj_wait {
>             __u32 pad;
>      };
>
>     +struct drm_syncobj_timeline_wait {
>     +       __u64 handles;
>     +       /* wait on specific timeline point for every handles*/
>     +       __u64 points;
>     +       /* absolute timeout */
>     +       __s64 timeout_nsec;
>     +       __u32 count_handles;
>     +       __u32 flags;
>     +       __u32 first_signaled; /* only valid when not waiting all */
>     +       __u32 pad;
>     +};
>     +
>     +
>      struct drm_syncobj_array {
>             __u64 handles;
>             __u32 count_handles;
>     @@ -910,6 +923,7 @@ extern "C" {
>      #define DRM_IOCTL_MODE_GET_LEASE       DRM_IOWR(0xC8, struct
>     drm_mode_get_lease)
>      #define DRM_IOCTL_MODE_REVOKE_LEASE    DRM_IOWR(0xC9, struct
>     drm_mode_revoke_lease)
>
>     +#define DRM_IOCTL_SYNCOBJ_TIMELINE_WAIT DRM_IOWR(0xCA, struct
>     drm_syncobj_timeline_wait)
>      /**
>       * Device specific ioctls should only be in their respective headers
>       * The device specific ioctl range is from 0x40 to 0x9f.
>     -- 
>     2.17.1
>
>     _______________________________________________
>     dri-devel mailing list
>     dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
>     <mailto:dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
>     https://lists.freedesktop.org/mailman/listinfo/dri-devel
>
>
>
> _______________________________________________
> dri-devel mailing list
> dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel


--------------625346D08C5ACBB335A03587
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: 8bit

<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body text="#000000" bgcolor="#FFFFFF">
    <div class="moz-cite-prefix">Am 25.09.2018 um 11:22 schrieb Jason
      Ekstrand:<br>
    </div>
    <blockquote type="cite"
cite="mid:CAOFGe96fXDQ8Q1piYCWhn2Z8ToOmf1JXyu+2YgUWYbMLCX7nzg-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org">
      <meta http-equiv="content-type" content="text/html; charset=utf-8">
      <div dir="ltr">
        <div class="gmail_quote">
          <div dir="ltr">On Thu, Sep 20, 2018 at 6:04 AM Chunming Zhou
            &lt;<a href="mailto:david1.zhou-5C7GfCeVMHo@public.gmane.org"
              moz-do-not-send="true">david1.zhou-5C7GfCeVMHo@public.gmane.org</a>&gt; wrote:<br>
          </div>
          <blockquote class="gmail_quote" style="margin:0 0 0
            .8ex;border-left:1px #ccc solid;padding-left:1ex">points
            array is one-to-one match with syncobjs array.<br>
            v2:<br>
            add seperate ioctl for timeline point wait, otherwise break
            uapi.<br>
          </blockquote>
          <div><br>
          </div>
          <div>I think ioctl structs can be extended as long as fields
            aren't re-ordered.  I'm not sure on the details of this
            though as I'm not a particularly experienced kernel
            developer.</div>
        </div>
      </div>
    </blockquote>
    <br>
    Yeah, that is correct. The problem in this particular case is that
    we don't change the direct IOCTL parameter, but rather the array it
    points to.<br>
    <br>
    We could do something like keep the existing handles array and add a
    separate optional one for the timeline points. That would also drop
    the need for the padding of the structure.<br>
    <br>
    <blockquote type="cite"
cite="mid:CAOFGe96fXDQ8Q1piYCWhn2Z8ToOmf1JXyu+2YgUWYbMLCX7nzg-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org">
      <div dir="ltr">
        <div class="gmail_quote">
          <div>Another general comment (no good place to put it) is that
            I think we want two kinds of waits:  Wait for time point to
            be completed and wait for time point to become available. 
            The first is the usual CPU wait for completion while the
            second is for use by userspace drivers to wait until the
            first moment where they can submit work which depends on a
            given time point.<br>
          </div>
        </div>
      </div>
    </blockquote>
    <br>
    Oh, yeah that is a really good point as ell.<br>
    <br>
    Christian.<br>
    <br>
    <blockquote type="cite"
cite="mid:CAOFGe96fXDQ8Q1piYCWhn2Z8ToOmf1JXyu+2YgUWYbMLCX7nzg-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org">
      <div dir="ltr">
        <div class="gmail_quote">
          <div> </div>
          <blockquote class="gmail_quote" style="margin:0 0 0
            .8ex;border-left:1px #ccc solid;padding-left:1ex">
            Signed-off-by: Chunming Zhou &lt;<a
              href="mailto:david1.zhou-5C7GfCeVMHo@public.gmane.org" target="_blank"
              moz-do-not-send="true">david1.zhou-5C7GfCeVMHo@public.gmane.org</a>&gt;<br>
            ---<br>
             drivers/gpu/drm/drm_internal.h |  2 +<br>
             drivers/gpu/drm/drm_ioctl.c    |  2 +<br>
             drivers/gpu/drm/drm_syncobj.c  | 99
            +++++++++++++++++++++++++++++-----<br>
             include/uapi/drm/drm.h         | 14 +++++<br>
             4 files changed, 103 insertions(+), 14 deletions(-)<br>
            <br>
            diff --git a/drivers/gpu/drm/drm_internal.h
            b/drivers/gpu/drm/drm_internal.h<br>
            index 0c4eb4a9ab31..566d44e3c782 100644<br>
            --- a/drivers/gpu/drm/drm_internal.h<br>
            +++ b/drivers/gpu/drm/drm_internal.h<br>
            @@ -183,6 +183,8 @@ int
            drm_syncobj_fd_to_handle_ioctl(struct drm_device *dev, void
            *data,<br>
                                               struct drm_file
            *file_private);<br>
             int drm_syncobj_wait_ioctl(struct drm_device *dev, void
            *data,<br>
                                       struct drm_file *file_private);<br>
            +int drm_syncobj_timeline_wait_ioctl(struct drm_device *dev,
            void *data,<br>
            +                                   struct drm_file
            *file_private);<br>
             int drm_syncobj_reset_ioctl(struct drm_device *dev, void
            *data,<br>
                                        struct drm_file *file_private);<br>
             int drm_syncobj_signal_ioctl(struct drm_device *dev, void
            *data,<br>
            diff --git a/drivers/gpu/drm/drm_ioctl.c
            b/drivers/gpu/drm/drm_ioctl.c<br>
            index 6b4a633b4240..c0891614f516 100644<br>
            --- a/drivers/gpu/drm/drm_ioctl.c<br>
            +++ b/drivers/gpu/drm/drm_ioctl.c<br>
            @@ -669,6 +669,8 @@ static const struct drm_ioctl_desc
            drm_ioctls[] = {<br>
                                  DRM_UNLOCKED|DRM_RENDER_ALLOW),<br>
                    DRM_IOCTL_DEF(DRM_IOCTL_SYNCOBJ_WAIT,
            drm_syncobj_wait_ioctl,<br>
                                  DRM_UNLOCKED|DRM_RENDER_ALLOW),<br>
            +       DRM_IOCTL_DEF(DRM_IOCTL_SYNCOBJ_TIMELINE_WAIT,
            drm_syncobj_timeline_wait_ioctl,<br>
            +                     DRM_UNLOCKED|DRM_RENDER_ALLOW),<br>
                    DRM_IOCTL_DEF(DRM_IOCTL_SYNCOBJ_RESET,
            drm_syncobj_reset_ioctl,<br>
                                  DRM_UNLOCKED|DRM_RENDER_ALLOW),<br>
                    DRM_IOCTL_DEF(DRM_IOCTL_SYNCOBJ_SIGNAL,
            drm_syncobj_signal_ioctl,<br>
            diff --git a/drivers/gpu/drm/drm_syncobj.c
            b/drivers/gpu/drm/drm_syncobj.c<br>
            index 67472bd77c83..a43de0e4616c 100644<br>
            --- a/drivers/gpu/drm/drm_syncobj.c<br>
            +++ b/drivers/gpu/drm/drm_syncobj.c<br>
            @@ -126,13 +126,14 @@ static void
            drm_syncobj_add_callback_locked(struct drm_syncobj *syncobj,<br>
             }<br>
            <br>
             static int drm_syncobj_fence_get_or_add_callback(struct
            drm_syncobj *syncobj,<br>
            +                                                u64 point,<br>
                                                             struct
            dma_fence **fence,<br>
                                                             struct
            drm_syncobj_cb *cb,<br>
                                                           
             drm_syncobj_func_t func)<br>
             {<br>
                    int ret;<br>
            <br>
            -       ret = drm_syncobj_search_fence(syncobj, 0, 0,
            fence);<br>
            +       ret = drm_syncobj_search_fence(syncobj, point, 0,
            fence);<br>
                    if (!ret)<br>
                            return 1;<br>
            <br>
            @@ -143,7 +144,7 @@ static int
            drm_syncobj_fence_get_or_add_callback(struct drm_syncobj
            *syncobj,<br>
                     */<br>
                    if (!list_empty(&amp;syncobj-&gt;signal_pt_list)) {<br>
                            spin_unlock(&amp;syncobj-&gt;lock);<br>
            -               drm_syncobj_search_fence(syncobj, 0, 0,
            fence);<br>
            +               drm_syncobj_search_fence(syncobj, point, 0,
            fence);<br>
                            if (*fence)<br>
                                    return 1;<br>
                            spin_lock(&amp;syncobj-&gt;lock);<br>
            @@ -358,7 +359,9 @@ void drm_syncobj_replace_fence(struct
            drm_syncobj *syncobj,<br>
                            spin_lock(&amp;syncobj-&gt;lock);<br>
                            list_for_each_entry_safe(cur, tmp,
            &amp;syncobj-&gt;cb_list, node) {<br>
                                    list_del_init(&amp;cur-&gt;node);<br>
            +                       spin_unlock(&amp;syncobj-&gt;lock);<br>
                                    cur-&gt;func(syncobj, cur);<br>
            +                       spin_lock(&amp;syncobj-&gt;lock);<br>
                            }<br>
                            spin_unlock(&amp;syncobj-&gt;lock);<br>
                    }<br>
            @@ -856,6 +859,7 @@ struct syncobj_wait_entry {<br>
                    struct dma_fence *fence;<br>
                    struct dma_fence_cb fence_cb;<br>
                    struct drm_syncobj_cb syncobj_cb;<br>
            +       u64    point;<br>
             };<br>
            <br>
             static void syncobj_wait_fence_func(struct dma_fence
            *fence,<br>
            @@ -873,12 +877,13 @@ static void
            syncobj_wait_syncobj_func(struct drm_syncobj *syncobj,<br>
                    struct syncobj_wait_entry *wait =<br>
                            container_of(cb, struct syncobj_wait_entry,
            syncobj_cb);<br>
            <br>
            -       drm_syncobj_search_fence(syncobj, 0, 0,
            &amp;wait-&gt;fence);<br>
            +       drm_syncobj_search_fence(syncobj, wait-&gt;point, 0,
            &amp;wait-&gt;fence);<br>
            <br>
                    wake_up_process(wait-&gt;task);<br>
             }<br>
            <br>
             static signed long drm_syncobj_array_wait_timeout(struct
            drm_syncobj **syncobjs,<br>
            +                                                 void
            __user *user_points,<br>
                                                              uint32_t
            count,<br>
                                                              uint32_t
            flags,<br>
                                                              signed
            long timeout,<br>
            @@ -886,13 +891,27 @@ static signed long
            drm_syncobj_array_wait_timeout(struct drm_syncobj
            **syncobjs,<br>
             {<br>
                    struct syncobj_wait_entry *entries;<br>
                    struct dma_fence *fence;<br>
            +       uint64_t *points;<br>
                    signed long ret;<br>
                    uint32_t signaled_count, i;<br>
            <br>
            -       entries = kcalloc(count, sizeof(*entries),
            GFP_KERNEL);<br>
            -       if (!entries)<br>
            +       points = kmalloc_array(count, sizeof(*points),
            GFP_KERNEL);<br>
            +       if (points == NULL)<br>
                            return -ENOMEM;<br>
            <br>
            +       if (!user_points) {<br>
            +               memset(points, 0, count * sizeof(uint64_t));<br>
            +       } else if (copy_from_user(points, user_points,
            sizeof(uint64_t) * count)) {<br>
            +               ret = -EFAULT;<br>
            +               goto err_free_points;<br>
            +       }<br>
            +<br>
            +<br>
            +       entries = kcalloc(count, sizeof(*entries),
            GFP_KERNEL);<br>
            +       if (!entries) {<br>
            +               ret = -ENOMEM;<br>
            +               goto err_free_points;<br>
            +       }<br>
                    /* Walk the list of sync objects and initialize
            entries.  We do<br>
                     * this up-front so that we can properly return
            -EINVAL if there is<br>
                     * a syncobj with a missing fence and then never
            have the chance of<br>
            @@ -901,7 +920,8 @@ static signed long
            drm_syncobj_array_wait_timeout(struct drm_syncobj
            **syncobjs,<br>
                    signaled_count = 0;<br>
                    for (i = 0; i &lt; count; ++i) {<br>
                            entries[i].task = current;<br>
            -               ret = drm_syncobj_search_fence(syncobjs[i],
            0, 0,<br>
            +               entries[i].point = points[i];<br>
            +               ret = drm_syncobj_search_fence(syncobjs[i],
            points[i], 0,<br>
                                                         
             &amp;entries[i].fence);<br>
                            if (!entries[i].fence) {<br>
                                    if (flags &amp;
            DRM_SYNCOBJ_WAIT_FLAGS_WAIT_FOR_SUBMIT) {<br>
            @@ -940,6 +960,7 @@ static signed long
            drm_syncobj_array_wait_timeout(struct drm_syncobj
            **syncobjs,<br>
                    if (flags &amp;
            DRM_SYNCOBJ_WAIT_FLAGS_WAIT_FOR_SUBMIT) {<br>
                            for (i = 0; i &lt; count; ++i) {<br>
                                   
            drm_syncobj_fence_get_or_add_callback(syncobjs[i],<br>
            +                                                           
             entries[i].point,<br>
                                                                       
              &amp;entries[i].fence,<br>
                                                                       
              &amp;entries[i].syncobj_cb,<br>
                                                                       
              syncobj_wait_syncobj_func);<br>
            @@ -1003,6 +1024,9 @@ static signed long
            drm_syncobj_array_wait_timeout(struct drm_syncobj
            **syncobjs,<br>
                    }<br>
                    kfree(entries);<br>
            <br>
            +err_free_points:<br>
            +       kfree(points);<br>
            +<br>
                    return ret;<br>
             }<br>
            <br>
            @@ -1041,20 +1065,33 @@ static signed long
            drm_timeout_abs_to_jiffies(int64_t timeout_nsec)<br>
             static int drm_syncobj_array_wait(struct drm_device *dev,<br>
                                              struct drm_file
            *file_private,<br>
                                              struct drm_syncobj_wait
            *wait,<br>
            -                                 struct drm_syncobj
            **syncobjs)<br>
            +                                 struct
            drm_syncobj_timeline_wait *timeline_wait,<br>
            +                                 struct drm_syncobj
            **syncobjs, bool timeline)<br>
             {<br>
            -       signed long timeout =
            drm_timeout_abs_to_jiffies(wait-&gt;timeout_nsec);<br>
            +       signed long timeout = 0;<br>
                    signed long ret = 0;<br>
                    uint32_t first = ~0;<br>
            <br>
            -       ret = drm_syncobj_array_wait_timeout(syncobjs,<br>
            -                                           
            wait-&gt;count_handles,<br>
            -                                            wait-&gt;flags,<br>
            -                                            timeout,
            &amp;first);<br>
            +       if (!timeline) {<br>
            +               timeout =
            drm_timeout_abs_to_jiffies(wait-&gt;timeout_nsec);<br>
            +               ret =
            drm_syncobj_array_wait_timeout(syncobjs,<br>
            +                                                    NULL,<br>
            +                                                   
            wait-&gt;count_handles,<br>
            +                                                   
            wait-&gt;flags,<br>
            +                                                   
            timeout, &amp;first);<br>
            +               wait-&gt;first_signaled = first;<br>
            +       } else {<br>
            +               timeout =
            drm_timeout_abs_to_jiffies(timeline_wait-&gt;timeout_nsec);<br>
            +               ret =
            drm_syncobj_array_wait_timeout(syncobjs,<br>
            +                                                   
            u64_to_user_ptr(timeline_wait-&gt;points),<br>
            +                                                   
            timeline_wait-&gt;count_handles,<br>
            +                                                   
            timeline_wait-&gt;flags,<br>
            +                                                   
            timeout, &amp;first);<br>
            +               timeline_wait-&gt;first_signaled = first;<br>
            +       }<br>
                    if (ret &lt; 0)<br>
                            return ret;<br>
            <br>
            -       wait-&gt;first_signaled = first;<br>
                    if (ret == 0)<br>
                            return -ETIME;<br>
                    return 0;<br>
            @@ -1142,13 +1179,47 @@ drm_syncobj_wait_ioctl(struct
            drm_device *dev, void *data,<br>
                            return ret;<br>
            <br>
                    ret = drm_syncobj_array_wait(dev, file_private,<br>
            -                                    args, syncobjs);<br>
            +                                    args, NULL, syncobjs,
            false);<br>
            <br>
                    drm_syncobj_array_free(syncobjs,
            args-&gt;count_handles);<br>
            <br>
                    return ret;<br>
             }<br>
            <br>
            +int<br>
            +drm_syncobj_timeline_wait_ioctl(struct drm_device *dev,
            void *data,<br>
            +                               struct drm_file
            *file_private)<br>
            +{<br>
            +       struct drm_syncobj_timeline_wait *args = data;<br>
            +       struct drm_syncobj **syncobjs;<br>
            +       int ret = 0;<br>
            +<br>
            +       if (!drm_core_check_feature(dev, DRIVER_SYNCOBJ))<br>
            +               return -ENODEV;<br>
            +<br>
            +       if (args-&gt;flags &amp;
            ~(DRM_SYNCOBJ_WAIT_FLAGS_WAIT_ALL |<br>
            +                         
             DRM_SYNCOBJ_WAIT_FLAGS_WAIT_FOR_SUBMIT))<br>
            +               return -EINVAL;<br>
            +<br>
            +       if (args-&gt;count_handles == 0)<br>
            +               return -EINVAL;<br>
            +<br>
            +       ret = drm_syncobj_array_find(file_private,<br>
            +                                   
            u64_to_user_ptr(args-&gt;handles),<br>
            +                                    args-&gt;count_handles,<br>
            +                                    &amp;syncobjs);<br>
            +       if (ret &lt; 0)<br>
            +               return ret;<br>
            +<br>
            +       ret = drm_syncobj_array_wait(dev, file_private,<br>
            +                                    NULL, args, syncobjs,
            true);<br>
            +<br>
            +       drm_syncobj_array_free(syncobjs,
            args-&gt;count_handles);<br>
            +<br>
            +       return ret;<br>
            +}<br>
            +<br>
            +<br>
             int<br>
             drm_syncobj_reset_ioctl(struct drm_device *dev, void *data,<br>
                                    struct drm_file *file_private)<br>
            diff --git a/include/uapi/drm/drm.h b/include/uapi/drm/drm.h<br>
            index cebdb2541eb7..501e86d81f47 100644<br>
            --- a/include/uapi/drm/drm.h<br>
            +++ b/include/uapi/drm/drm.h<br>
            @@ -748,6 +748,19 @@ struct drm_syncobj_wait {<br>
                    __u32 pad;<br>
             };<br>
            <br>
            +struct drm_syncobj_timeline_wait {<br>
            +       __u64 handles;<br>
            +       /* wait on specific timeline point for every
            handles*/<br>
            +       __u64 points;<br>
            +       /* absolute timeout */<br>
            +       __s64 timeout_nsec;<br>
            +       __u32 count_handles;<br>
            +       __u32 flags;<br>
            +       __u32 first_signaled; /* only valid when not waiting
            all */<br>
            +       __u32 pad;<br>
            +};<br>
            +<br>
            +<br>
             struct drm_syncobj_array {<br>
                    __u64 handles;<br>
                    __u32 count_handles;<br>
            @@ -910,6 +923,7 @@ extern "C" {<br>
             #define DRM_IOCTL_MODE_GET_LEASE       DRM_IOWR(0xC8,
            struct drm_mode_get_lease)<br>
             #define DRM_IOCTL_MODE_REVOKE_LEASE    DRM_IOWR(0xC9,
            struct drm_mode_revoke_lease)<br>
            <br>
            +#define DRM_IOCTL_SYNCOBJ_TIMELINE_WAIT       
            DRM_IOWR(0xCA, struct drm_syncobj_timeline_wait)<br>
             /**<br>
              * Device specific ioctls should only be in their
            respective headers<br>
              * The device specific ioctl range is from 0x40 to 0x9f.<br>
            -- <br>
            2.17.1<br>
            <br>
            _______________________________________________<br>
            dri-devel mailing list<br>
            <a href="mailto:dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org"
              target="_blank" moz-do-not-send="true">dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org</a><br>
            <a
              href="https://lists.freedesktop.org/mailman/listinfo/dri-devel"
              rel="noreferrer" target="_blank" moz-do-not-send="true">https://lists.freedesktop.org/mailman/listinfo/dri-devel</a><br>
          </blockquote>
        </div>
      </div>
      <br>
      <fieldset class="mimeAttachmentHeader"></fieldset>
      <br>
      <pre wrap="">_______________________________________________
dri-devel mailing list
<a class="moz-txt-link-abbreviated" href="mailto:dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org">dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org</a>
<a class="moz-txt-link-freetext" href="https://lists.freedesktop.org/mailman/listinfo/dri-devel">https://lists.freedesktop.org/mailman/listinfo/dri-devel</a>
</pre>
    </blockquote>
    <br>
  </body>
</html>

--------------625346D08C5ACBB335A03587--

--===============1205660734==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============1205660734==--
