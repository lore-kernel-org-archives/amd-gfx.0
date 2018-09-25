From: Jason Ekstrand <jason-fQELhIk9awXprZlt/sZkLg@public.gmane.org>
Subject: Re: [PATCH 3/6] drm: add support of syncobj timeline point wait v2
Date: Tue, 25 Sep 2018 04:22:06 -0500
Message-ID: <CAOFGe96fXDQ8Q1piYCWhn2Z8ToOmf1JXyu+2YgUWYbMLCX7nzg@mail.gmail.com>
References: <20180920110353.16114-1-david1.zhou@amd.com>
 <20180920110353.16114-3-david1.zhou@amd.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0899764367=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <20180920110353.16114-3-david1.zhou-5C7GfCeVMHo@public.gmane.org>
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
To: zhoucm1 <david1.zhou-5C7GfCeVMHo@public.gmane.org>
Cc: amd-gfx mailing list <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, Maling list - DRI developers <dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

--===============0899764367==
Content-Type: multipart/alternative; boundary="000000000000761e170576aea4ea"

--000000000000761e170576aea4ea
Content-Type: text/plain; charset="UTF-8"

On Thu, Sep 20, 2018 at 6:04 AM Chunming Zhou <david1.zhou-5C7GfCeVMHo@public.gmane.org> wrote:

> points array is one-to-one match with syncobjs array.
> v2:
> add seperate ioctl for timeline point wait, otherwise break uapi.
>

I think ioctl structs can be extended as long as fields aren't re-ordered.
I'm not sure on the details of this though as I'm not a particularly
experienced kernel developer.

Another general comment (no good place to put it) is that I think we want
two kinds of waits:  Wait for time point to be completed and wait for time
point to become available.  The first is the usual CPU wait for completion
while the second is for use by userspace drivers to wait until the first
moment where they can submit work which depends on a given time point.


> Signed-off-by: Chunming Zhou <david1.zhou-5C7GfCeVMHo@public.gmane.org>
> ---
>  drivers/gpu/drm/drm_internal.h |  2 +
>  drivers/gpu/drm/drm_ioctl.c    |  2 +
>  drivers/gpu/drm/drm_syncobj.c  | 99 +++++++++++++++++++++++++++++-----
>  include/uapi/drm/drm.h         | 14 +++++
>  4 files changed, 103 insertions(+), 14 deletions(-)
>
> diff --git a/drivers/gpu/drm/drm_internal.h
> b/drivers/gpu/drm/drm_internal.h
> index 0c4eb4a9ab31..566d44e3c782 100644
> --- a/drivers/gpu/drm/drm_internal.h
> +++ b/drivers/gpu/drm/drm_internal.h
> @@ -183,6 +183,8 @@ int drm_syncobj_fd_to_handle_ioctl(struct drm_device
> *dev, void *data,
>                                    struct drm_file *file_private);
>  int drm_syncobj_wait_ioctl(struct drm_device *dev, void *data,
>                            struct drm_file *file_private);
> +int drm_syncobj_timeline_wait_ioctl(struct drm_device *dev, void *data,
> +                                   struct drm_file *file_private);
>  int drm_syncobj_reset_ioctl(struct drm_device *dev, void *data,
>                             struct drm_file *file_private);
>  int drm_syncobj_signal_ioctl(struct drm_device *dev, void *data,
> diff --git a/drivers/gpu/drm/drm_ioctl.c b/drivers/gpu/drm/drm_ioctl.c
> index 6b4a633b4240..c0891614f516 100644
> --- a/drivers/gpu/drm/drm_ioctl.c
> +++ b/drivers/gpu/drm/drm_ioctl.c
> @@ -669,6 +669,8 @@ static const struct drm_ioctl_desc drm_ioctls[] = {
>                       DRM_UNLOCKED|DRM_RENDER_ALLOW),
>         DRM_IOCTL_DEF(DRM_IOCTL_SYNCOBJ_WAIT, drm_syncobj_wait_ioctl,
>                       DRM_UNLOCKED|DRM_RENDER_ALLOW),
> +       DRM_IOCTL_DEF(DRM_IOCTL_SYNCOBJ_TIMELINE_WAIT,
> drm_syncobj_timeline_wait_ioctl,
> +                     DRM_UNLOCKED|DRM_RENDER_ALLOW),
>         DRM_IOCTL_DEF(DRM_IOCTL_SYNCOBJ_RESET, drm_syncobj_reset_ioctl,
>                       DRM_UNLOCKED|DRM_RENDER_ALLOW),
>         DRM_IOCTL_DEF(DRM_IOCTL_SYNCOBJ_SIGNAL, drm_syncobj_signal_ioctl,
> diff --git a/drivers/gpu/drm/drm_syncobj.c b/drivers/gpu/drm/drm_syncobj.c
> index 67472bd77c83..a43de0e4616c 100644
> --- a/drivers/gpu/drm/drm_syncobj.c
> +++ b/drivers/gpu/drm/drm_syncobj.c
> @@ -126,13 +126,14 @@ static void drm_syncobj_add_callback_locked(struct
> drm_syncobj *syncobj,
>  }
>
>  static int drm_syncobj_fence_get_or_add_callback(struct drm_syncobj
> *syncobj,
> +                                                u64 point,
>                                                  struct dma_fence **fence,
>                                                  struct drm_syncobj_cb *cb,
>                                                  drm_syncobj_func_t func)
>  {
>         int ret;
>
> -       ret = drm_syncobj_search_fence(syncobj, 0, 0, fence);
> +       ret = drm_syncobj_search_fence(syncobj, point, 0, fence);
>         if (!ret)
>                 return 1;
>
> @@ -143,7 +144,7 @@ static int
> drm_syncobj_fence_get_or_add_callback(struct drm_syncobj *syncobj,
>          */
>         if (!list_empty(&syncobj->signal_pt_list)) {
>                 spin_unlock(&syncobj->lock);
> -               drm_syncobj_search_fence(syncobj, 0, 0, fence);
> +               drm_syncobj_search_fence(syncobj, point, 0, fence);
>                 if (*fence)
>                         return 1;
>                 spin_lock(&syncobj->lock);
> @@ -358,7 +359,9 @@ void drm_syncobj_replace_fence(struct drm_syncobj
> *syncobj,
>                 spin_lock(&syncobj->lock);
>                 list_for_each_entry_safe(cur, tmp, &syncobj->cb_list,
> node) {
>                         list_del_init(&cur->node);
> +                       spin_unlock(&syncobj->lock);
>                         cur->func(syncobj, cur);
> +                       spin_lock(&syncobj->lock);
>                 }
>                 spin_unlock(&syncobj->lock);
>         }
> @@ -856,6 +859,7 @@ struct syncobj_wait_entry {
>         struct dma_fence *fence;
>         struct dma_fence_cb fence_cb;
>         struct drm_syncobj_cb syncobj_cb;
> +       u64    point;
>  };
>
>  static void syncobj_wait_fence_func(struct dma_fence *fence,
> @@ -873,12 +877,13 @@ static void syncobj_wait_syncobj_func(struct
> drm_syncobj *syncobj,
>         struct syncobj_wait_entry *wait =
>                 container_of(cb, struct syncobj_wait_entry, syncobj_cb);
>
> -       drm_syncobj_search_fence(syncobj, 0, 0, &wait->fence);
> +       drm_syncobj_search_fence(syncobj, wait->point, 0, &wait->fence);
>
>         wake_up_process(wait->task);
>  }
>
>  static signed long drm_syncobj_array_wait_timeout(struct drm_syncobj
> **syncobjs,
> +                                                 void __user *user_points,
>                                                   uint32_t count,
>                                                   uint32_t flags,
>                                                   signed long timeout,
> @@ -886,13 +891,27 @@ static signed long
> drm_syncobj_array_wait_timeout(struct drm_syncobj **syncobjs,
>  {
>         struct syncobj_wait_entry *entries;
>         struct dma_fence *fence;
> +       uint64_t *points;
>         signed long ret;
>         uint32_t signaled_count, i;
>
> -       entries = kcalloc(count, sizeof(*entries), GFP_KERNEL);
> -       if (!entries)
> +       points = kmalloc_array(count, sizeof(*points), GFP_KERNEL);
> +       if (points == NULL)
>                 return -ENOMEM;
>
> +       if (!user_points) {
> +               memset(points, 0, count * sizeof(uint64_t));
> +       } else if (copy_from_user(points, user_points, sizeof(uint64_t) *
> count)) {
> +               ret = -EFAULT;
> +               goto err_free_points;
> +       }
> +
> +
> +       entries = kcalloc(count, sizeof(*entries), GFP_KERNEL);
> +       if (!entries) {
> +               ret = -ENOMEM;
> +               goto err_free_points;
> +       }
>         /* Walk the list of sync objects and initialize entries.  We do
>          * this up-front so that we can properly return -EINVAL if there is
>          * a syncobj with a missing fence and then never have the chance of
> @@ -901,7 +920,8 @@ static signed long
> drm_syncobj_array_wait_timeout(struct drm_syncobj **syncobjs,
>         signaled_count = 0;
>         for (i = 0; i < count; ++i) {
>                 entries[i].task = current;
> -               ret = drm_syncobj_search_fence(syncobjs[i], 0, 0,
> +               entries[i].point = points[i];
> +               ret = drm_syncobj_search_fence(syncobjs[i], points[i], 0,
>                                                &entries[i].fence);
>                 if (!entries[i].fence) {
>                         if (flags &
> DRM_SYNCOBJ_WAIT_FLAGS_WAIT_FOR_SUBMIT) {
> @@ -940,6 +960,7 @@ static signed long
> drm_syncobj_array_wait_timeout(struct drm_syncobj **syncobjs,
>         if (flags & DRM_SYNCOBJ_WAIT_FLAGS_WAIT_FOR_SUBMIT) {
>                 for (i = 0; i < count; ++i) {
>                         drm_syncobj_fence_get_or_add_callback(syncobjs[i],
> +
>  entries[i].point,
>
> &entries[i].fence,
>
> &entries[i].syncobj_cb,
>
> syncobj_wait_syncobj_func);
> @@ -1003,6 +1024,9 @@ static signed long
> drm_syncobj_array_wait_timeout(struct drm_syncobj **syncobjs,
>         }
>         kfree(entries);
>
> +err_free_points:
> +       kfree(points);
> +
>         return ret;
>  }
>
> @@ -1041,20 +1065,33 @@ static signed long
> drm_timeout_abs_to_jiffies(int64_t timeout_nsec)
>  static int drm_syncobj_array_wait(struct drm_device *dev,
>                                   struct drm_file *file_private,
>                                   struct drm_syncobj_wait *wait,
> -                                 struct drm_syncobj **syncobjs)
> +                                 struct drm_syncobj_timeline_wait
> *timeline_wait,
> +                                 struct drm_syncobj **syncobjs, bool
> timeline)
>  {
> -       signed long timeout =
> drm_timeout_abs_to_jiffies(wait->timeout_nsec);
> +       signed long timeout = 0;
>         signed long ret = 0;
>         uint32_t first = ~0;
>
> -       ret = drm_syncobj_array_wait_timeout(syncobjs,
> -                                            wait->count_handles,
> -                                            wait->flags,
> -                                            timeout, &first);
> +       if (!timeline) {
> +               timeout = drm_timeout_abs_to_jiffies(wait->timeout_nsec);
> +               ret = drm_syncobj_array_wait_timeout(syncobjs,
> +                                                    NULL,
> +                                                    wait->count_handles,
> +                                                    wait->flags,
> +                                                    timeout, &first);
> +               wait->first_signaled = first;
> +       } else {
> +               timeout =
> drm_timeout_abs_to_jiffies(timeline_wait->timeout_nsec);
> +               ret = drm_syncobj_array_wait_timeout(syncobjs,
> +
> u64_to_user_ptr(timeline_wait->points),
> +
> timeline_wait->count_handles,
> +                                                    timeline_wait->flags,
> +                                                    timeout, &first);
> +               timeline_wait->first_signaled = first;
> +       }
>         if (ret < 0)
>                 return ret;
>
> -       wait->first_signaled = first;
>         if (ret == 0)
>                 return -ETIME;
>         return 0;
> @@ -1142,13 +1179,47 @@ drm_syncobj_wait_ioctl(struct drm_device *dev,
> void *data,
>                 return ret;
>
>         ret = drm_syncobj_array_wait(dev, file_private,
> -                                    args, syncobjs);
> +                                    args, NULL, syncobjs, false);
>
>         drm_syncobj_array_free(syncobjs, args->count_handles);
>
>         return ret;
>  }
>
> +int
> +drm_syncobj_timeline_wait_ioctl(struct drm_device *dev, void *data,
> +                               struct drm_file *file_private)
> +{
> +       struct drm_syncobj_timeline_wait *args = data;
> +       struct drm_syncobj **syncobjs;
> +       int ret = 0;
> +
> +       if (!drm_core_check_feature(dev, DRIVER_SYNCOBJ))
> +               return -ENODEV;
> +
> +       if (args->flags & ~(DRM_SYNCOBJ_WAIT_FLAGS_WAIT_ALL |
> +                           DRM_SYNCOBJ_WAIT_FLAGS_WAIT_FOR_SUBMIT))
> +               return -EINVAL;
> +
> +       if (args->count_handles == 0)
> +               return -EINVAL;
> +
> +       ret = drm_syncobj_array_find(file_private,
> +                                    u64_to_user_ptr(args->handles),
> +                                    args->count_handles,
> +                                    &syncobjs);
> +       if (ret < 0)
> +               return ret;
> +
> +       ret = drm_syncobj_array_wait(dev, file_private,
> +                                    NULL, args, syncobjs, true);
> +
> +       drm_syncobj_array_free(syncobjs, args->count_handles);
> +
> +       return ret;
> +}
> +
> +
>  int
>  drm_syncobj_reset_ioctl(struct drm_device *dev, void *data,
>                         struct drm_file *file_private)
> diff --git a/include/uapi/drm/drm.h b/include/uapi/drm/drm.h
> index cebdb2541eb7..501e86d81f47 100644
> --- a/include/uapi/drm/drm.h
> +++ b/include/uapi/drm/drm.h
> @@ -748,6 +748,19 @@ struct drm_syncobj_wait {
>         __u32 pad;
>  };
>
> +struct drm_syncobj_timeline_wait {
> +       __u64 handles;
> +       /* wait on specific timeline point for every handles*/
> +       __u64 points;
> +       /* absolute timeout */
> +       __s64 timeout_nsec;
> +       __u32 count_handles;
> +       __u32 flags;
> +       __u32 first_signaled; /* only valid when not waiting all */
> +       __u32 pad;
> +};
> +
> +
>  struct drm_syncobj_array {
>         __u64 handles;
>         __u32 count_handles;
> @@ -910,6 +923,7 @@ extern "C" {
>  #define DRM_IOCTL_MODE_GET_LEASE       DRM_IOWR(0xC8, struct
> drm_mode_get_lease)
>  #define DRM_IOCTL_MODE_REVOKE_LEASE    DRM_IOWR(0xC9, struct
> drm_mode_revoke_lease)
>
> +#define DRM_IOCTL_SYNCOBJ_TIMELINE_WAIT        DRM_IOWR(0xCA, struct
> drm_syncobj_timeline_wait)
>  /**
>   * Device specific ioctls should only be in their respective headers
>   * The device specific ioctl range is from 0x40 to 0x9f.
> --
> 2.17.1
>
> _______________________________________________
> dri-devel mailing list
> dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
>

--000000000000761e170576aea4ea
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: base64

PGRpdiBkaXI9Imx0ciI+PGRpdiBjbGFzcz0iZ21haWxfcXVvdGUiPjxkaXYgZGlyPSJsdHIiPk9u
IFRodSwgU2VwIDIwLCAyMDE4IGF0IDY6MDQgQU0gQ2h1bm1pbmcgWmhvdSAmbHQ7PGEgaHJlZj0i
bWFpbHRvOmRhdmlkMS56aG91QGFtZC5jb20iPmRhdmlkMS56aG91QGFtZC5jb208L2E+Jmd0OyB3
cm90ZTo8YnI+PC9kaXY+PGJsb2NrcXVvdGUgY2xhc3M9ImdtYWlsX3F1b3RlIiBzdHlsZT0ibWFy
Z2luOjAgMCAwIC44ZXg7Ym9yZGVyLWxlZnQ6MXB4ICNjY2Mgc29saWQ7cGFkZGluZy1sZWZ0OjFl
eCI+cG9pbnRzIGFycmF5IGlzIG9uZS10by1vbmUgbWF0Y2ggd2l0aCBzeW5jb2JqcyBhcnJheS48
YnI+DQp2Mjo8YnI+DQphZGQgc2VwZXJhdGUgaW9jdGwgZm9yIHRpbWVsaW5lIHBvaW50IHdhaXQs
IG90aGVyd2lzZSBicmVhayB1YXBpLjxicj48L2Jsb2NrcXVvdGU+PGRpdj48YnI+PC9kaXY+PGRp
dj5JIHRoaW5rIGlvY3RsIHN0cnVjdHMgY2FuIGJlIGV4dGVuZGVkIGFzIGxvbmcgYXMgZmllbGRz
IGFyZW4mIzM5O3QgcmUtb3JkZXJlZC7CoCBJJiMzOTttIG5vdCBzdXJlIG9uIHRoZSBkZXRhaWxz
IG9mIHRoaXMgdGhvdWdoIGFzIEkmIzM5O20gbm90IGEgcGFydGljdWxhcmx5IGV4cGVyaWVuY2Vk
IGtlcm5lbCBkZXZlbG9wZXIuPC9kaXY+PGRpdj48YnI+PC9kaXY+PGRpdj5Bbm90aGVyIGdlbmVy
YWwgY29tbWVudCAobm8gZ29vZCBwbGFjZSB0byBwdXQgaXQpIGlzIHRoYXQgSSB0aGluayB3ZSB3
YW50IHR3byBraW5kcyBvZiB3YWl0czrCoCBXYWl0IGZvciB0aW1lIHBvaW50IHRvIGJlIGNvbXBs
ZXRlZCBhbmQgd2FpdCBmb3IgdGltZSBwb2ludCB0byBiZWNvbWUgYXZhaWxhYmxlLsKgIFRoZSBm
aXJzdCBpcyB0aGUgdXN1YWwgQ1BVIHdhaXQgZm9yIGNvbXBsZXRpb24gd2hpbGUgdGhlIHNlY29u
ZCBpcyBmb3IgdXNlIGJ5IHVzZXJzcGFjZSBkcml2ZXJzIHRvIHdhaXQgdW50aWwgdGhlIGZpcnN0
IG1vbWVudCB3aGVyZSB0aGV5IGNhbiBzdWJtaXQgd29yayB3aGljaCBkZXBlbmRzIG9uIGEgZ2l2
ZW4gdGltZSBwb2ludC48YnI+PC9kaXY+PGRpdj7CoDwvZGl2PjxibG9ja3F1b3RlIGNsYXNzPSJn
bWFpbF9xdW90ZSIgc3R5bGU9Im1hcmdpbjowIDAgMCAuOGV4O2JvcmRlci1sZWZ0OjFweCAjY2Nj
IHNvbGlkO3BhZGRpbmctbGVmdDoxZXgiPg0KU2lnbmVkLW9mZi1ieTogQ2h1bm1pbmcgWmhvdSAm
bHQ7PGEgaHJlZj0ibWFpbHRvOmRhdmlkMS56aG91QGFtZC5jb20iIHRhcmdldD0iX2JsYW5rIj5k
YXZpZDEuemhvdUBhbWQuY29tPC9hPiZndDs8YnI+DQotLS08YnI+DQrCoGRyaXZlcnMvZ3B1L2Ry
bS9kcm1faW50ZXJuYWwuaCB8wqAgMiArPGJyPg0KwqBkcml2ZXJzL2dwdS9kcm0vZHJtX2lvY3Rs
LmPCoCDCoCB8wqAgMiArPGJyPg0KwqBkcml2ZXJzL2dwdS9kcm0vZHJtX3N5bmNvYmouY8KgIHwg
OTkgKysrKysrKysrKysrKysrKysrKysrKysrKysrKystLS0tLTxicj4NCsKgaW5jbHVkZS91YXBp
L2RybS9kcm0uaMKgIMKgIMKgIMKgIMKgfCAxNCArKysrKzxicj4NCsKgNCBmaWxlcyBjaGFuZ2Vk
LCAxMDMgaW5zZXJ0aW9ucygrKSwgMTQgZGVsZXRpb25zKC0pPGJyPg0KPGJyPg0KZGlmZiAtLWdp
dCBhL2RyaXZlcnMvZ3B1L2RybS9kcm1faW50ZXJuYWwuaCBiL2RyaXZlcnMvZ3B1L2RybS9kcm1f
aW50ZXJuYWwuaDxicj4NCmluZGV4IDBjNGViNGE5YWIzMS4uNTY2ZDQ0ZTNjNzgyIDEwMDY0NDxi
cj4NCi0tLSBhL2RyaXZlcnMvZ3B1L2RybS9kcm1faW50ZXJuYWwuaDxicj4NCisrKyBiL2RyaXZl
cnMvZ3B1L2RybS9kcm1faW50ZXJuYWwuaDxicj4NCkBAIC0xODMsNiArMTgzLDggQEAgaW50IGRy
bV9zeW5jb2JqX2ZkX3RvX2hhbmRsZV9pb2N0bChzdHJ1Y3QgZHJtX2RldmljZSAqZGV2LCB2b2lk
ICpkYXRhLDxicj4NCsKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgc3RydWN0IGRybV9maWxlICpmaWxlX3ByaXZhdGUpOzxicj4NCsKgaW50IGRybV9z
eW5jb2JqX3dhaXRfaW9jdGwoc3RydWN0IGRybV9kZXZpY2UgKmRldiwgdm9pZCAqZGF0YSw8YnI+
DQrCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoHN0cnVjdCBkcm1fZmls
ZSAqZmlsZV9wcml2YXRlKTs8YnI+DQoraW50IGRybV9zeW5jb2JqX3RpbWVsaW5lX3dhaXRfaW9j
dGwoc3RydWN0IGRybV9kZXZpY2UgKmRldiwgdm9pZCAqZGF0YSw8YnI+DQorwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBzdHJ1Y3QgZHJtX2ZpbGUg
KmZpbGVfcHJpdmF0ZSk7PGJyPg0KwqBpbnQgZHJtX3N5bmNvYmpfcmVzZXRfaW9jdGwoc3RydWN0
IGRybV9kZXZpY2UgKmRldiwgdm9pZCAqZGF0YSw8YnI+DQrCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCBzdHJ1Y3QgZHJtX2ZpbGUgKmZpbGVfcHJpdmF0ZSk7PGJyPg0K
wqBpbnQgZHJtX3N5bmNvYmpfc2lnbmFsX2lvY3RsKHN0cnVjdCBkcm1fZGV2aWNlICpkZXYsIHZv
aWQgKmRhdGEsPGJyPg0KZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9kcm1faW9jdGwuYyBi
L2RyaXZlcnMvZ3B1L2RybS9kcm1faW9jdGwuYzxicj4NCmluZGV4IDZiNGE2MzNiNDI0MC4uYzA4
OTE2MTRmNTE2IDEwMDY0NDxicj4NCi0tLSBhL2RyaXZlcnMvZ3B1L2RybS9kcm1faW9jdGwuYzxi
cj4NCisrKyBiL2RyaXZlcnMvZ3B1L2RybS9kcm1faW9jdGwuYzxicj4NCkBAIC02NjksNiArNjY5
LDggQEAgc3RhdGljIGNvbnN0IHN0cnVjdCBkcm1faW9jdGxfZGVzYyBkcm1faW9jdGxzW10gPSB7
PGJyPg0KwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgRFJNX1VOTE9DS0VEfERSTV9S
RU5ERVJfQUxMT1cpLDxicj4NCsKgIMKgIMKgIMKgIERSTV9JT0NUTF9ERUYoRFJNX0lPQ1RMX1NZ
TkNPQkpfV0FJVCwgZHJtX3N5bmNvYmpfd2FpdF9pb2N0bCw8YnI+DQrCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCBEUk1fVU5MT0NLRUR8RFJNX1JFTkRFUl9BTExPVyksPGJyPg0KK8Kg
IMKgIMKgIMKgRFJNX0lPQ1RMX0RFRihEUk1fSU9DVExfU1lOQ09CSl9USU1FTElORV9XQUlULCBk
cm1fc3luY29ial90aW1lbGluZV93YWl0X2lvY3RsLDxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoERSTV9VTkxPQ0tFRHxEUk1fUkVOREVSX0FMTE9XKSw8YnI+DQrCoCDCoCDC
oCDCoCBEUk1fSU9DVExfREVGKERSTV9JT0NUTF9TWU5DT0JKX1JFU0VULCBkcm1fc3luY29ial9y
ZXNldF9pb2N0bCw8YnI+DQrCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCBEUk1fVU5M
T0NLRUR8RFJNX1JFTkRFUl9BTExPVyksPGJyPg0KwqAgwqAgwqAgwqAgRFJNX0lPQ1RMX0RFRihE
Uk1fSU9DVExfU1lOQ09CSl9TSUdOQUwsIGRybV9zeW5jb2JqX3NpZ25hbF9pb2N0bCw8YnI+DQpk
aWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2RybV9zeW5jb2JqLmMgYi9kcml2ZXJzL2dwdS9k
cm0vZHJtX3N5bmNvYmouYzxicj4NCmluZGV4IDY3NDcyYmQ3N2M4My4uYTQzZGUwZTQ2MTZjIDEw
MDY0NDxicj4NCi0tLSBhL2RyaXZlcnMvZ3B1L2RybS9kcm1fc3luY29iai5jPGJyPg0KKysrIGIv
ZHJpdmVycy9ncHUvZHJtL2RybV9zeW5jb2JqLmM8YnI+DQpAQCAtMTI2LDEzICsxMjYsMTQgQEAg
c3RhdGljIHZvaWQgZHJtX3N5bmNvYmpfYWRkX2NhbGxiYWNrX2xvY2tlZChzdHJ1Y3QgZHJtX3N5
bmNvYmogKnN5bmNvYmosPGJyPg0KwqB9PGJyPg0KPGJyPg0KwqBzdGF0aWMgaW50IGRybV9zeW5j
b2JqX2ZlbmNlX2dldF9vcl9hZGRfY2FsbGJhY2soc3RydWN0IGRybV9zeW5jb2JqICpzeW5jb2Jq
LDxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCB1NjQgcG9pbnQsPGJyPg0KwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBz
dHJ1Y3QgZG1hX2ZlbmNlICoqZmVuY2UsPGJyPg0KwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBzdHJ1Y3QgZHJt
X3N5bmNvYmpfY2IgKmNiLDxicj4NCsKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgZHJtX3N5bmNvYmpfZnVuY190
IGZ1bmMpPGJyPg0KwqB7PGJyPg0KwqAgwqAgwqAgwqAgaW50IHJldDs8YnI+DQo8YnI+DQotwqAg
wqAgwqAgwqByZXQgPSBkcm1fc3luY29ial9zZWFyY2hfZmVuY2Uoc3luY29iaiwgMCwgMCwgZmVu
Y2UpOzxicj4NCivCoCDCoCDCoCDCoHJldCA9IGRybV9zeW5jb2JqX3NlYXJjaF9mZW5jZShzeW5j
b2JqLCBwb2ludCwgMCwgZmVuY2UpOzxicj4NCsKgIMKgIMKgIMKgIGlmICghcmV0KTxicj4NCsKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIHJldHVybiAxOzxicj4NCjxicj4NCkBAIC0xNDMsNyArMTQ0
LDcgQEAgc3RhdGljIGludCBkcm1fc3luY29ial9mZW5jZV9nZXRfb3JfYWRkX2NhbGxiYWNrKHN0
cnVjdCBkcm1fc3luY29iaiAqc3luY29iaiw8YnI+DQrCoCDCoCDCoCDCoCDCoCovPGJyPg0KwqAg
wqAgwqAgwqAgaWYgKCFsaXN0X2VtcHR5KCZhbXA7c3luY29iai0mZ3Q7c2lnbmFsX3B0X2xpc3Qp
KSB7PGJyPg0KwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgc3Bpbl91bmxvY2soJmFtcDtzeW5jb2Jq
LSZndDtsb2NrKTs8YnI+DQotwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBkcm1fc3luY29ial9zZWFy
Y2hfZmVuY2Uoc3luY29iaiwgMCwgMCwgZmVuY2UpOzxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoGRybV9zeW5jb2JqX3NlYXJjaF9mZW5jZShzeW5jb2JqLCBwb2ludCwgMCwgZmVuY2UpOzxi
cj4NCsKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIGlmICgqZmVuY2UpPGJyPg0KwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgcmV0dXJuIDE7PGJyPg0KwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgc3Bpbl9sb2NrKCZhbXA7c3luY29iai0mZ3Q7bG9jayk7PGJyPg0KQEAgLTM1OCw3ICsz
NTksOSBAQCB2b2lkIGRybV9zeW5jb2JqX3JlcGxhY2VfZmVuY2Uoc3RydWN0IGRybV9zeW5jb2Jq
ICpzeW5jb2JqLDxicj4NCsKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIHNwaW5fbG9jaygmYW1wO3N5
bmNvYmotJmd0O2xvY2spOzxicj4NCsKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIGxpc3RfZm9yX2Vh
Y2hfZW50cnlfc2FmZShjdXIsIHRtcCwgJmFtcDtzeW5jb2JqLSZndDtjYl9saXN0LCBub2RlKSB7
PGJyPg0KwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgbGlzdF9kZWxfaW5pdCgm
YW1wO2N1ci0mZ3Q7bm9kZSk7PGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgc3Bpbl91bmxvY2soJmFtcDtzeW5jb2JqLSZndDtsb2NrKTs8YnI+DQrCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCBjdXItJmd0O2Z1bmMoc3luY29iaiwgY3VyKTs8YnI+DQor
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBzcGluX2xvY2soJmFtcDtzeW5jb2Jq
LSZndDtsb2NrKTs8YnI+DQrCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCB9PGJyPg0KwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgc3Bpbl91bmxvY2soJmFtcDtzeW5jb2JqLSZndDtsb2NrKTs8YnI+DQrC
oCDCoCDCoCDCoCB9PGJyPg0KQEAgLTg1Niw2ICs4NTksNyBAQCBzdHJ1Y3Qgc3luY29ial93YWl0
X2VudHJ5IHs8YnI+DQrCoCDCoCDCoCDCoCBzdHJ1Y3QgZG1hX2ZlbmNlICpmZW5jZTs8YnI+DQrC
oCDCoCDCoCDCoCBzdHJ1Y3QgZG1hX2ZlbmNlX2NiIGZlbmNlX2NiOzxicj4NCsKgIMKgIMKgIMKg
IHN0cnVjdCBkcm1fc3luY29ial9jYiBzeW5jb2JqX2NiOzxicj4NCivCoCDCoCDCoCDCoHU2NMKg
IMKgIHBvaW50Ozxicj4NCsKgfTs8YnI+DQo8YnI+DQrCoHN0YXRpYyB2b2lkIHN5bmNvYmpfd2Fp
dF9mZW5jZV9mdW5jKHN0cnVjdCBkbWFfZmVuY2UgKmZlbmNlLDxicj4NCkBAIC04NzMsMTIgKzg3
NywxMyBAQCBzdGF0aWMgdm9pZCBzeW5jb2JqX3dhaXRfc3luY29ial9mdW5jKHN0cnVjdCBkcm1f
c3luY29iaiAqc3luY29iaiw8YnI+DQrCoCDCoCDCoCDCoCBzdHJ1Y3Qgc3luY29ial93YWl0X2Vu
dHJ5ICp3YWl0ID08YnI+DQrCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCBjb250YWluZXJfb2YoY2Is
IHN0cnVjdCBzeW5jb2JqX3dhaXRfZW50cnksIHN5bmNvYmpfY2IpOzxicj4NCjxicj4NCi3CoCDC
oCDCoCDCoGRybV9zeW5jb2JqX3NlYXJjaF9mZW5jZShzeW5jb2JqLCAwLCAwLCAmYW1wO3dhaXQt
Jmd0O2ZlbmNlKTs8YnI+DQorwqAgwqAgwqAgwqBkcm1fc3luY29ial9zZWFyY2hfZmVuY2Uoc3lu
Y29iaiwgd2FpdC0mZ3Q7cG9pbnQsIDAsICZhbXA7d2FpdC0mZ3Q7ZmVuY2UpOzxicj4NCjxicj4N
CsKgIMKgIMKgIMKgIHdha2VfdXBfcHJvY2Vzcyh3YWl0LSZndDt0YXNrKTs8YnI+DQrCoH08YnI+
DQo8YnI+DQrCoHN0YXRpYyBzaWduZWQgbG9uZyBkcm1fc3luY29ial9hcnJheV93YWl0X3RpbWVv
dXQoc3RydWN0IGRybV9zeW5jb2JqICoqc3luY29ianMsPGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
dm9pZCBfX3VzZXIgKnVzZXJfcG9pbnRzLDxicj4NCsKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIHVpbnQzMl90
IGNvdW50LDxicj4NCsKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIHVpbnQzMl90IGZsYWdzLDxicj4NCsKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIHNpZ25lZCBsb25nIHRpbWVvdXQsPGJyPg0KQEAgLTg4NiwxMyArODkxLDI3
IEBAIHN0YXRpYyBzaWduZWQgbG9uZyBkcm1fc3luY29ial9hcnJheV93YWl0X3RpbWVvdXQoc3Ry
dWN0IGRybV9zeW5jb2JqICoqc3luY29ianMsPGJyPg0KwqB7PGJyPg0KwqAgwqAgwqAgwqAgc3Ry
dWN0IHN5bmNvYmpfd2FpdF9lbnRyeSAqZW50cmllczs8YnI+DQrCoCDCoCDCoCDCoCBzdHJ1Y3Qg
ZG1hX2ZlbmNlICpmZW5jZTs8YnI+DQorwqAgwqAgwqAgwqB1aW50NjRfdCAqcG9pbnRzOzxicj4N
CsKgIMKgIMKgIMKgIHNpZ25lZCBsb25nIHJldDs8YnI+DQrCoCDCoCDCoCDCoCB1aW50MzJfdCBz
aWduYWxlZF9jb3VudCwgaTs8YnI+DQo8YnI+DQotwqAgwqAgwqAgwqBlbnRyaWVzID0ga2NhbGxv
Yyhjb3VudCwgc2l6ZW9mKCplbnRyaWVzKSwgR0ZQX0tFUk5FTCk7PGJyPg0KLcKgIMKgIMKgIMKg
aWYgKCFlbnRyaWVzKTxicj4NCivCoCDCoCDCoCDCoHBvaW50cyA9IGttYWxsb2NfYXJyYXkoY291
bnQsIHNpemVvZigqcG9pbnRzKSwgR0ZQX0tFUk5FTCk7PGJyPg0KK8KgIMKgIMKgIMKgaWYgKHBv
aW50cyA9PSBOVUxMKTxicj4NCsKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIHJldHVybiAtRU5PTUVN
Ozxicj4NCjxicj4NCivCoCDCoCDCoCDCoGlmICghdXNlcl9wb2ludHMpIHs8YnI+DQorwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqBtZW1zZXQocG9pbnRzLCAwLCBjb3VudCAqIHNpemVvZih1aW50NjRf
dCkpOzxicj4NCivCoCDCoCDCoCDCoH0gZWxzZSBpZiAoY29weV9mcm9tX3VzZXIocG9pbnRzLCB1
c2VyX3BvaW50cywgc2l6ZW9mKHVpbnQ2NF90KSAqIGNvdW50KSkgezxicj4NCivCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoHJldCA9IC1FRkFVTFQ7PGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
Z290byBlcnJfZnJlZV9wb2ludHM7PGJyPg0KK8KgIMKgIMKgIMKgfTxicj4NCis8YnI+DQorPGJy
Pg0KK8KgIMKgIMKgIMKgZW50cmllcyA9IGtjYWxsb2MoY291bnQsIHNpemVvZigqZW50cmllcyks
IEdGUF9LRVJORUwpOzxicj4NCivCoCDCoCDCoCDCoGlmICghZW50cmllcykgezxicj4NCivCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoHJldCA9IC1FTk9NRU07PGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgZ290byBlcnJfZnJlZV9wb2ludHM7PGJyPg0KK8KgIMKgIMKgIMKgfTxicj4NCsKgIMKg
IMKgIMKgIC8qIFdhbGsgdGhlIGxpc3Qgb2Ygc3luYyBvYmplY3RzIGFuZCBpbml0aWFsaXplIGVu
dHJpZXMuwqAgV2UgZG88YnI+DQrCoCDCoCDCoCDCoCDCoCogdGhpcyB1cC1mcm9udCBzbyB0aGF0
IHdlIGNhbiBwcm9wZXJseSByZXR1cm4gLUVJTlZBTCBpZiB0aGVyZSBpczxicj4NCsKgIMKgIMKg
IMKgIMKgKiBhIHN5bmNvYmogd2l0aCBhIG1pc3NpbmcgZmVuY2UgYW5kIHRoZW4gbmV2ZXIgaGF2
ZSB0aGUgY2hhbmNlIG9mPGJyPg0KQEAgLTkwMSw3ICs5MjAsOCBAQCBzdGF0aWMgc2lnbmVkIGxv
bmcgZHJtX3N5bmNvYmpfYXJyYXlfd2FpdF90aW1lb3V0KHN0cnVjdCBkcm1fc3luY29iaiAqKnN5
bmNvYmpzLDxicj4NCsKgIMKgIMKgIMKgIHNpZ25hbGVkX2NvdW50ID0gMDs8YnI+DQrCoCDCoCDC
oCDCoCBmb3IgKGkgPSAwOyBpICZsdDsgY291bnQ7ICsraSkgezxicj4NCsKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIGVudHJpZXNbaV0udGFzayA9IGN1cnJlbnQ7PGJyPg0KLcKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgcmV0ID0gZHJtX3N5bmNvYmpfc2VhcmNoX2ZlbmNlKHN5bmNvYmpzW2ldLCAwLCAw
LDxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoGVudHJpZXNbaV0ucG9pbnQgPSBwb2ludHNb
aV07PGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgcmV0ID0gZHJtX3N5bmNvYmpfc2VhcmNo
X2ZlbmNlKHN5bmNvYmpzW2ldLCBwb2ludHNbaV0sIDAsPGJyPg0KwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAmYW1w
O2VudHJpZXNbaV0uZmVuY2UpOzxicj4NCsKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIGlmICghZW50
cmllc1tpXS5mZW5jZSkgezxicj4NCsKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IGlmIChmbGFncyAmYW1wOyBEUk1fU1lOQ09CSl9XQUlUX0ZMQUdTX1dBSVRfRk9SX1NVQk1JVCkg
ezxicj4NCkBAIC05NDAsNiArOTYwLDcgQEAgc3RhdGljIHNpZ25lZCBsb25nIGRybV9zeW5jb2Jq
X2FycmF5X3dhaXRfdGltZW91dChzdHJ1Y3QgZHJtX3N5bmNvYmogKipzeW5jb2Jqcyw8YnI+DQrC
oCDCoCDCoCDCoCBpZiAoZmxhZ3MgJmFtcDsgRFJNX1NZTkNPQkpfV0FJVF9GTEFHU19XQUlUX0ZP
Ul9TVUJNSVQpIHs8YnI+DQrCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCBmb3IgKGkgPSAwOyBpICZs
dDsgY291bnQ7ICsraSkgezxicj4NCsKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IGRybV9zeW5jb2JqX2ZlbmNlX2dldF9vcl9hZGRfY2FsbGJhY2soc3luY29ianNbaV0sPGJyPg0K
K8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgZW50cmllc1tpXS5wb2ludCw8YnI+
DQrCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCAmYW1wO2VudHJpZXNbaV0uZmVu
Y2UsPGJyPg0KwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgJmFtcDtlbnRyaWVz
W2ldLnN5bmNvYmpfY2IsPGJyPg0KwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
c3luY29ial93YWl0X3N5bmNvYmpfZnVuYyk7PGJyPg0KQEAgLTEwMDMsNiArMTAyNCw5IEBAIHN0
YXRpYyBzaWduZWQgbG9uZyBkcm1fc3luY29ial9hcnJheV93YWl0X3RpbWVvdXQoc3RydWN0IGRy
bV9zeW5jb2JqICoqc3luY29ianMsPGJyPg0KwqAgwqAgwqAgwqAgfTxicj4NCsKgIMKgIMKgIMKg
IGtmcmVlKGVudHJpZXMpOzxicj4NCjxicj4NCitlcnJfZnJlZV9wb2ludHM6PGJyPg0KK8KgIMKg
IMKgIMKga2ZyZWUocG9pbnRzKTs8YnI+DQorPGJyPg0KwqAgwqAgwqAgwqAgcmV0dXJuIHJldDs8
YnI+DQrCoH08YnI+DQo8YnI+DQpAQCAtMTA0MSwyMCArMTA2NSwzMyBAQCBzdGF0aWMgc2lnbmVk
IGxvbmcgZHJtX3RpbWVvdXRfYWJzX3RvX2ppZmZpZXMoaW50NjRfdCB0aW1lb3V0X25zZWMpPGJy
Pg0KwqBzdGF0aWMgaW50IGRybV9zeW5jb2JqX2FycmF5X3dhaXQoc3RydWN0IGRybV9kZXZpY2Ug
KmRldiw8YnI+DQrCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCBzdHJ1Y3QgZHJtX2ZpbGUgKmZpbGVfcHJpdmF0ZSw8YnI+DQrCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCBzdHJ1Y3QgZHJtX3N5bmNvYmpfd2Fp
dCAqd2FpdCw8YnI+DQotwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqBzdHJ1Y3QgZHJtX3N5bmNvYmogKipzeW5jb2Jqcyk8YnI+DQorwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBzdHJ1Y3QgZHJtX3N5bmNvYmpf
dGltZWxpbmVfd2FpdCAqdGltZWxpbmVfd2FpdCw8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBzdHJ1Y3QgZHJtX3N5bmNvYmogKipzeW5jb2Jq
cywgYm9vbCB0aW1lbGluZSk8YnI+DQrCoHs8YnI+DQotwqAgwqAgwqAgwqBzaWduZWQgbG9uZyB0
aW1lb3V0ID0gZHJtX3RpbWVvdXRfYWJzX3RvX2ppZmZpZXMod2FpdC0mZ3Q7dGltZW91dF9uc2Vj
KTs8YnI+DQorwqAgwqAgwqAgwqBzaWduZWQgbG9uZyB0aW1lb3V0ID0gMDs8YnI+DQrCoCDCoCDC
oCDCoCBzaWduZWQgbG9uZyByZXQgPSAwOzxicj4NCsKgIMKgIMKgIMKgIHVpbnQzMl90IGZpcnN0
ID0gfjA7PGJyPg0KPGJyPg0KLcKgIMKgIMKgIMKgcmV0ID0gZHJtX3N5bmNvYmpfYXJyYXlfd2Fp
dF90aW1lb3V0KHN5bmNvYmpzLDxicj4NCi3CoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCB3YWl0LSZndDtjb3VudF9oYW5kbGVz
LDxicj4NCi3CoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCB3YWl0LSZndDtmbGFncyw8YnI+DQotwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgdGltZW91dCwg
JmFtcDtmaXJzdCk7PGJyPg0KK8KgIMKgIMKgIMKgaWYgKCF0aW1lbGluZSkgezxicj4NCivCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoHRpbWVvdXQgPSBkcm1fdGltZW91dF9hYnNfdG9famlmZmllcyh3
YWl0LSZndDt0aW1lb3V0X25zZWMpOzxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoHJldCA9
IGRybV9zeW5jb2JqX2FycmF5X3dhaXRfdGltZW91dChzeW5jb2Jqcyw8YnI+DQorwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgTlVMTCw8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgd2FpdC0mZ3Q7Y291
bnRfaGFuZGxlcyw8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgd2FpdC0mZ3Q7ZmxhZ3MsPGJy
Pg0KK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIHRpbWVvdXQsICZhbXA7Zmlyc3QpOzxicj4NCivCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoHdhaXQtJmd0O2ZpcnN0X3NpZ25hbGVkID0gZmlyc3Q7PGJyPg0K
K8KgIMKgIMKgIMKgfSBlbHNlIHs8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqB0aW1lb3V0
ID0gZHJtX3RpbWVvdXRfYWJzX3RvX2ppZmZpZXModGltZWxpbmVfd2FpdC0mZ3Q7dGltZW91dF9u
c2VjKTs8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqByZXQgPSBkcm1fc3luY29ial9hcnJh
eV93YWl0X3RpbWVvdXQoc3luY29ianMsPGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIHU2NF90
b191c2VyX3B0cih0aW1lbGluZV93YWl0LSZndDtwb2ludHMpLDxicj4NCivCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCB0aW1lbGluZV93YWl0LSZndDtjb3VudF9oYW5kbGVzLDxicj4NCivCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCB0aW1lbGluZV93YWl0LSZndDtmbGFncyw8YnI+DQorwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgdGltZW91dCwgJmFtcDtmaXJzdCk7PGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
dGltZWxpbmVfd2FpdC0mZ3Q7Zmlyc3Rfc2lnbmFsZWQgPSBmaXJzdDs8YnI+DQorwqAgwqAgwqAg
wqB9PGJyPg0KwqAgwqAgwqAgwqAgaWYgKHJldCAmbHQ7IDApPGJyPg0KwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgcmV0dXJuIHJldDs8YnI+DQo8YnI+DQotwqAgwqAgwqAgwqB3YWl0LSZndDtmaXJz
dF9zaWduYWxlZCA9IGZpcnN0Ozxicj4NCsKgIMKgIMKgIMKgIGlmIChyZXQgPT0gMCk8YnI+DQrC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCByZXR1cm4gLUVUSU1FOzxicj4NCsKgIMKgIMKgIMKgIHJl
dHVybiAwOzxicj4NCkBAIC0xMTQyLDEzICsxMTc5LDQ3IEBAIGRybV9zeW5jb2JqX3dhaXRfaW9j
dGwoc3RydWN0IGRybV9kZXZpY2UgKmRldiwgdm9pZCAqZGF0YSw8YnI+DQrCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCByZXR1cm4gcmV0Ozxicj4NCjxicj4NCsKgIMKgIMKgIMKgIHJldCA9IGRybV9z
eW5jb2JqX2FycmF5X3dhaXQoZGV2LCBmaWxlX3ByaXZhdGUsPGJyPg0KLcKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIGFyZ3MsIHN5bmNvYmpzKTs8
YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgYXJncywgTlVMTCwgc3luY29ianMsIGZhbHNlKTs8YnI+DQo8YnI+DQrCoCDCoCDCoCDCoCBk
cm1fc3luY29ial9hcnJheV9mcmVlKHN5bmNvYmpzLCBhcmdzLSZndDtjb3VudF9oYW5kbGVzKTs8
YnI+DQo8YnI+DQrCoCDCoCDCoCDCoCByZXR1cm4gcmV0Ozxicj4NCsKgfTxicj4NCjxicj4NCitp
bnQ8YnI+DQorZHJtX3N5bmNvYmpfdGltZWxpbmVfd2FpdF9pb2N0bChzdHJ1Y3QgZHJtX2Rldmlj
ZSAqZGV2LCB2b2lkICpkYXRhLDxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoHN0cnVjdCBkcm1fZmlsZSAqZmlsZV9wcml2YXRlKTxicj4NCit7PGJy
Pg0KK8KgIMKgIMKgIMKgc3RydWN0IGRybV9zeW5jb2JqX3RpbWVsaW5lX3dhaXQgKmFyZ3MgPSBk
YXRhOzxicj4NCivCoCDCoCDCoCDCoHN0cnVjdCBkcm1fc3luY29iaiAqKnN5bmNvYmpzOzxicj4N
CivCoCDCoCDCoCDCoGludCByZXQgPSAwOzxicj4NCis8YnI+DQorwqAgwqAgwqAgwqBpZiAoIWRy
bV9jb3JlX2NoZWNrX2ZlYXR1cmUoZGV2LCBEUklWRVJfU1lOQ09CSikpPGJyPg0KK8KgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgcmV0dXJuIC1FTk9ERVY7PGJyPg0KKzxicj4NCivCoCDCoCDCoCDCoGlm
IChhcmdzLSZndDtmbGFncyAmYW1wOyB+KERSTV9TWU5DT0JKX1dBSVRfRkxBR1NfV0FJVF9BTEwg
fDxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoERSTV9TWU5D
T0JKX1dBSVRfRkxBR1NfV0FJVF9GT1JfU1VCTUlUKSk8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqByZXR1cm4gLUVJTlZBTDs8YnI+DQorPGJyPg0KK8KgIMKgIMKgIMKgaWYgKGFyZ3MtJmd0
O2NvdW50X2hhbmRsZXMgPT0gMCk8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqByZXR1cm4g
LUVJTlZBTDs8YnI+DQorPGJyPg0KK8KgIMKgIMKgIMKgcmV0ID0gZHJtX3N5bmNvYmpfYXJyYXlf
ZmluZChmaWxlX3ByaXZhdGUsPGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIHU2NF90b191c2VyX3B0cihhcmdzLSZndDtoYW5kbGVzKSw8
YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgYXJncy0mZ3Q7Y291bnRfaGFuZGxlcyw8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgJmFtcDtzeW5jb2Jqcyk7PGJyPg0KK8KgIMKg
IMKgIMKgaWYgKHJldCAmbHQ7IDApPGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgcmV0dXJu
IHJldDs8YnI+DQorPGJyPg0KK8KgIMKgIMKgIMKgcmV0ID0gZHJtX3N5bmNvYmpfYXJyYXlfd2Fp
dChkZXYsIGZpbGVfcHJpdmF0ZSw8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgTlVMTCwgYXJncywgc3luY29ianMsIHRydWUpOzxicj4N
Cis8YnI+DQorwqAgwqAgwqAgwqBkcm1fc3luY29ial9hcnJheV9mcmVlKHN5bmNvYmpzLCBhcmdz
LSZndDtjb3VudF9oYW5kbGVzKTs8YnI+DQorPGJyPg0KK8KgIMKgIMKgIMKgcmV0dXJuIHJldDs8
YnI+DQorfTxicj4NCis8YnI+DQorPGJyPg0KwqBpbnQ8YnI+DQrCoGRybV9zeW5jb2JqX3Jlc2V0
X2lvY3RsKHN0cnVjdCBkcm1fZGV2aWNlICpkZXYsIHZvaWQgKmRhdGEsPGJyPg0KwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgc3RydWN0IGRybV9maWxlICpmaWxlX3ByaXZhdGUp
PGJyPg0KZGlmZiAtLWdpdCBhL2luY2x1ZGUvdWFwaS9kcm0vZHJtLmggYi9pbmNsdWRlL3VhcGkv
ZHJtL2RybS5oPGJyPg0KaW5kZXggY2ViZGIyNTQxZWI3Li41MDFlODZkODFmNDcgMTAwNjQ0PGJy
Pg0KLS0tIGEvaW5jbHVkZS91YXBpL2RybS9kcm0uaDxicj4NCisrKyBiL2luY2x1ZGUvdWFwaS9k
cm0vZHJtLmg8YnI+DQpAQCAtNzQ4LDYgKzc0OCwxOSBAQCBzdHJ1Y3QgZHJtX3N5bmNvYmpfd2Fp
dCB7PGJyPg0KwqAgwqAgwqAgwqAgX191MzIgcGFkOzxicj4NCsKgfTs8YnI+DQo8YnI+DQorc3Ry
dWN0IGRybV9zeW5jb2JqX3RpbWVsaW5lX3dhaXQgezxicj4NCivCoCDCoCDCoCDCoF9fdTY0IGhh
bmRsZXM7PGJyPg0KK8KgIMKgIMKgIMKgLyogd2FpdCBvbiBzcGVjaWZpYyB0aW1lbGluZSBwb2lu
dCBmb3IgZXZlcnkgaGFuZGxlcyovPGJyPg0KK8KgIMKgIMKgIMKgX191NjQgcG9pbnRzOzxicj4N
CivCoCDCoCDCoCDCoC8qIGFic29sdXRlIHRpbWVvdXQgKi88YnI+DQorwqAgwqAgwqAgwqBfX3M2
NCB0aW1lb3V0X25zZWM7PGJyPg0KK8KgIMKgIMKgIMKgX191MzIgY291bnRfaGFuZGxlczs8YnI+
DQorwqAgwqAgwqAgwqBfX3UzMiBmbGFnczs8YnI+DQorwqAgwqAgwqAgwqBfX3UzMiBmaXJzdF9z
aWduYWxlZDsgLyogb25seSB2YWxpZCB3aGVuIG5vdCB3YWl0aW5nIGFsbCAqLzxicj4NCivCoCDC
oCDCoCDCoF9fdTMyIHBhZDs8YnI+DQorfTs8YnI+DQorPGJyPg0KKzxicj4NCsKgc3RydWN0IGRy
bV9zeW5jb2JqX2FycmF5IHs8YnI+DQrCoCDCoCDCoCDCoCBfX3U2NCBoYW5kbGVzOzxicj4NCsKg
IMKgIMKgIMKgIF9fdTMyIGNvdW50X2hhbmRsZXM7PGJyPg0KQEAgLTkxMCw2ICs5MjMsNyBAQCBl
eHRlcm4gJnF1b3Q7QyZxdW90OyB7PGJyPg0KwqAjZGVmaW5lIERSTV9JT0NUTF9NT0RFX0dFVF9M
RUFTRcKgIMKgIMKgIMKgRFJNX0lPV1IoMHhDOCwgc3RydWN0IGRybV9tb2RlX2dldF9sZWFzZSk8
YnI+DQrCoCNkZWZpbmUgRFJNX0lPQ1RMX01PREVfUkVWT0tFX0xFQVNFwqAgwqAgRFJNX0lPV1Io
MHhDOSwgc3RydWN0IGRybV9tb2RlX3Jldm9rZV9sZWFzZSk8YnI+DQo8YnI+DQorI2RlZmluZSBE
Uk1fSU9DVExfU1lOQ09CSl9USU1FTElORV9XQUlUwqAgwqAgwqAgwqAgRFJNX0lPV1IoMHhDQSwg
c3RydWN0IGRybV9zeW5jb2JqX3RpbWVsaW5lX3dhaXQpPGJyPg0KwqAvKio8YnI+DQrCoCAqIERl
dmljZSBzcGVjaWZpYyBpb2N0bHMgc2hvdWxkIG9ubHkgYmUgaW4gdGhlaXIgcmVzcGVjdGl2ZSBo
ZWFkZXJzPGJyPg0KwqAgKiBUaGUgZGV2aWNlIHNwZWNpZmljIGlvY3RsIHJhbmdlIGlzIGZyb20g
MHg0MCB0byAweDlmLjxicj4NCi0tIDxicj4NCjIuMTcuMTxicj4NCjxicj4NCl9fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fPGJyPg0KZHJpLWRldmVsIG1haWxp
bmcgbGlzdDxicj4NCjxhIGhyZWY9Im1haWx0bzpkcmktZGV2ZWxAbGlzdHMuZnJlZWRlc2t0b3Au
b3JnIiB0YXJnZXQ9Il9ibGFuayI+ZHJpLWRldmVsQGxpc3RzLmZyZWVkZXNrdG9wLm9yZzwvYT48
YnI+DQo8YSBocmVmPSJodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3Rp
bmZvL2RyaS1kZXZlbCIgcmVsPSJub3JlZmVycmVyIiB0YXJnZXQ9Il9ibGFuayI+aHR0cHM6Ly9s
aXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9kcmktZGV2ZWw8L2E+PGJyPg0K
PC9ibG9ja3F1b3RlPjwvZGl2PjwvZGl2Pg0K
--000000000000761e170576aea4ea--

--===============0899764367==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============0899764367==--
