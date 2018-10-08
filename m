From: Jason Ekstrand <jason@jlekstrand.net>
Subject: Re: [PATCH 3/6] drm: add support of syncobj timeline point wait v2
Date: Mon, 8 Oct 2018 12:53:33 -0500
Message-ID: <CAOFGe95XwffJS-3VOk8V9oJPqYqD0ApKUvjzAs6b0jYCOtwDtw@mail.gmail.com>
References: <20180920110353.16114-1-david1.zhou@amd.com>
 <20180920110353.16114-3-david1.zhou@amd.com>
 <CAOFGe96fXDQ8Q1piYCWhn2Z8ToOmf1JXyu+2YgUWYbMLCX7nzg@mail.gmail.com>
 <ba634e07-0373-5e76-bc65-416dcec6fd1f@gmail.com>
 <BY1PR12MB05028FF8BD23FB7E3C6E5D41B4E60@BY1PR12MB0502.namprd12.prod.outlook.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2123723107=="
Return-path: <dri-devel-bounces@lists.freedesktop.org>
In-Reply-To: <BY1PR12MB05028FF8BD23FB7E3C6E5D41B4E60@BY1PR12MB0502.namprd12.prod.outlook.com>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
To: zhoucm1 <David1.Zhou@amd.com>
Cc: Maling list - DRI developers <dri-devel@lists.freedesktop.org>, =?UTF-8?Q?Christian_K=C3=B6nig?= <Christian.Koenig@amd.com>, amd-gfx mailing list <amd-gfx@lists.freedesktop.org>
List-Id: amd-gfx.lists.freedesktop.org

--===============2123723107==
Content-Type: multipart/alternative; boundary="00000000000081cebf0577bb4d5f"

--00000000000081cebf0577bb4d5f
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 8, 2018 at 12:53 AM Zhou, David(ChunMing) <David1.Zhou@amd.com>
wrote:

> >> Another general comment (no good place to put it) is that I think we
> want two kinds of waits:  Wait for time point to be completed and wait fo=
r
> time point to become available.  The first is the usual CPU wait for
> completion while the second is for use by userspace drivers to wait until
> the first moment where they can submit work which depends on a given time
> point.
>
>
>
> Hi Jason,
>
>
>
> How about adding two new wait flags?
>
> DRM_SYNCOBJ_WAIT_FLAGS_WAIT_COMPLETED
>
> DRM_SYNCOBJ_WAIT_FLAGS_WAIT_AVAILABLE
>

Those seem like fine names to me.  We should require that one of the two
flags be present when the sync object is a timeline.

--Jason


> Thanks,
>
> David
>
>
>
> *From:* Christian K=C3=B6nig <ckoenig.leichtzumerken@gmail.com>
> *Sent:* Tuesday, September 25, 2018 5:50 PM
> *To:* Jason Ekstrand <jason@jlekstrand.net>; Zhou, David(ChunMing) <
> David1.Zhou@amd.com>
> *Cc:* amd-gfx mailing list <amd-gfx@lists.freedesktop.org>; Maling list -
> DRI developers <dri-devel@lists.freedesktop.org>
> *Subject:* Re: [PATCH 3/6] drm: add support of syncobj timeline point
> wait v2
>
>
>
> Am 25.09.2018 um 11:22 schrieb Jason Ekstrand:
>
> On Thu, Sep 20, 2018 at 6:04 AM Chunming Zhou <david1.zhou@amd.com> wrote=
:
>
> points array is one-to-one match with syncobjs array.
> v2:
> add seperate ioctl for timeline point wait, otherwise break uapi.
>
>
>
> I think ioctl structs can be extended as long as fields aren't
> re-ordered.  I'm not sure on the details of this though as I'm not a
> particularly experienced kernel developer.
>
>
> Yeah, that is correct. The problem in this particular case is that we
> don't change the direct IOCTL parameter, but rather the array it points t=
o.
>
> We could do something like keep the existing handles array and add a
> separate optional one for the timeline points. That would also drop the
> need for the padding of the structure.
>
>
> Another general comment (no good place to put it) is that I think we want
> two kinds of waits:  Wait for time point to be completed and wait for tim=
e
> point to become available.  The first is the usual CPU wait for completio=
n
> while the second is for use by userspace drivers to wait until the first
> moment where they can submit work which depends on a given time point.
>
>
> Oh, yeah that is a really good point as ell.
>
> Christian.
>
>
>
>
> Signed-off-by: Chunming Zhou <david1.zhou@amd.com>
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
> @@ -669,6 +669,8 @@ static const struct drm_ioctl_desc drm_ioctls[] =3D {
>                       DRM_UNLOCKED|DRM_RENDER_ALLOW),
>         DRM_IOCTL_DEF(DRM_IOCTL_SYNCOBJ_WAIT, drm_syncobj_wait_ioctl,
>                       DRM_UNLOCKED|DRM_RENDER_ALLOW),
> +       DRM_IOCTL_DEF(DRM_IOCTL_SYNCOBJ_TIMELINE_WAIT,
> drm_syncobj_timeline_wait_ioctl,
> +                     DRM_UNLOCKED|DRM_RENDER_ALLOW),
>         DRM_IOCTL_DEF(DRM_IOCTL_SYNCOBJ_RESET, drm_syncobj_reset_ioctl,
>                       DRM_UNLOCKED|DRM_RENDER_ALLOW),
>         DRM_IOCTL_DEF(DRM_IOCTL_SYNCOBJ_SIGNAL, drm_syncobj_signal_ioctl,
> diff --git a/drivers/gpu/drm/drm_syncobj.c b/drivers/gpu/drm/drm_syncobj.=
c
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
>                                                  struct dma_fence **fence=
,
>                                                  struct drm_syncobj_cb *c=
b,
>                                                  drm_syncobj_func_t func)
>  {
>         int ret;
>
> -       ret =3D drm_syncobj_search_fence(syncobj, 0, 0, fence);
> +       ret =3D drm_syncobj_search_fence(syncobj, point, 0, fence);
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
>         struct syncobj_wait_entry *wait =3D
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
> +                                                 void __user *user_point=
s,
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
> -       entries =3D kcalloc(count, sizeof(*entries), GFP_KERNEL);
> -       if (!entries)
> +       points =3D kmalloc_array(count, sizeof(*points), GFP_KERNEL);
> +       if (points =3D=3D NULL)
>                 return -ENOMEM;
>
> +       if (!user_points) {
> +               memset(points, 0, count * sizeof(uint64_t));
> +       } else if (copy_from_user(points, user_points, sizeof(uint64_t) *
> count)) {
> +               ret =3D -EFAULT;
> +               goto err_free_points;
> +       }
> +
> +
> +       entries =3D kcalloc(count, sizeof(*entries), GFP_KERNEL);
> +       if (!entries) {
> +               ret =3D -ENOMEM;
> +               goto err_free_points;
> +       }
>         /* Walk the list of sync objects and initialize entries.  We do
>          * this up-front so that we can properly return -EINVAL if there =
is
>          * a syncobj with a missing fence and then never have the chance =
of
> @@ -901,7 +920,8 @@ static signed long
> drm_syncobj_array_wait_timeout(struct drm_syncobj **syncobjs,
>         signaled_count =3D 0;
>         for (i =3D 0; i < count; ++i) {
>                 entries[i].task =3D current;
> -               ret =3D drm_syncobj_search_fence(syncobjs[i], 0, 0,
> +               entries[i].point =3D points[i];
> +               ret =3D drm_syncobj_search_fence(syncobjs[i], points[i], =
0,
>                                                &entries[i].fence);
>                 if (!entries[i].fence) {
>                         if (flags &
> DRM_SYNCOBJ_WAIT_FLAGS_WAIT_FOR_SUBMIT) {
> @@ -940,6 +960,7 @@ static signed long
> drm_syncobj_array_wait_timeout(struct drm_syncobj **syncobjs,
>         if (flags & DRM_SYNCOBJ_WAIT_FLAGS_WAIT_FOR_SUBMIT) {
>                 for (i =3D 0; i < count; ++i) {
>                         drm_syncobj_fence_get_or_add_callback(syncobjs[i]=
,
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
> -       signed long timeout =3D
> drm_timeout_abs_to_jiffies(wait->timeout_nsec);
> +       signed long timeout =3D 0;
>         signed long ret =3D 0;
>         uint32_t first =3D ~0;
>
> -       ret =3D drm_syncobj_array_wait_timeout(syncobjs,
> -                                            wait->count_handles,
> -                                            wait->flags,
> -                                            timeout, &first);
> +       if (!timeline) {
> +               timeout =3D drm_timeout_abs_to_jiffies(wait->timeout_nsec=
);
> +               ret =3D drm_syncobj_array_wait_timeout(syncobjs,
> +                                                    NULL,
> +                                                    wait->count_handles,
> +                                                    wait->flags,
> +                                                    timeout, &first);
> +               wait->first_signaled =3D first;
> +       } else {
> +               timeout =3D
> drm_timeout_abs_to_jiffies(timeline_wait->timeout_nsec);
> +               ret =3D drm_syncobj_array_wait_timeout(syncobjs,
> +
> u64_to_user_ptr(timeline_wait->points),
> +
> timeline_wait->count_handles,
> +                                                    timeline_wait->flags=
,
> +                                                    timeout, &first);
> +               timeline_wait->first_signaled =3D first;
> +       }
>         if (ret < 0)
>                 return ret;
>
> -       wait->first_signaled =3D first;
>         if (ret =3D=3D 0)
>                 return -ETIME;
>         return 0;
> @@ -1142,13 +1179,47 @@ drm_syncobj_wait_ioctl(struct drm_device *dev,
> void *data,
>                 return ret;
>
>         ret =3D drm_syncobj_array_wait(dev, file_private,
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
> +       struct drm_syncobj_timeline_wait *args =3D data;
> +       struct drm_syncobj **syncobjs;
> +       int ret =3D 0;
> +
> +       if (!drm_core_check_feature(dev, DRIVER_SYNCOBJ))
> +               return -ENODEV;
> +
> +       if (args->flags & ~(DRM_SYNCOBJ_WAIT_FLAGS_WAIT_ALL |
> +                           DRM_SYNCOBJ_WAIT_FLAGS_WAIT_FOR_SUBMIT))
> +               return -EINVAL;
> +
> +       if (args->count_handles =3D=3D 0)
> +               return -EINVAL;
> +
> +       ret =3D drm_syncobj_array_find(file_private,
> +                                    u64_to_user_ptr(args->handles),
> +                                    args->count_handles,
> +                                    &syncobjs);
> +       if (ret < 0)
> +               return ret;
> +
> +       ret =3D drm_syncobj_array_wait(dev, file_private,
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
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
>
>
>
>
> _______________________________________________
>
> dri-devel mailing list
>
> dri-devel@lists.freedesktop.org
>
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
>
>
>

--00000000000081cebf0577bb4d5f
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_quote"><div dir=3D"ltr">On Mon, Oct 8,=
 2018 at 12:53 AM Zhou, David(ChunMing) &lt;<a href=3D"mailto:David1.Zhou@a=
md.com">David1.Zhou@amd.com</a>&gt; wrote:<br></div><blockquote class=3D"gm=
ail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-le=
ft:1ex">





<div bgcolor=3D"white" link=3D"blue" vlink=3D"purple" lang=3D"EN-US">
<div class=3D"m_-1584312309811383151WordSection1">
<p class=3D"MsoNormal"><span style=3D"color:windowtext">&gt;&gt;</span> Ano=
ther general comment (no good place to put it) is that I think we want two =
kinds of waits:=C2=A0 Wait for time point to be completed and wait for time=
 point to become available.=C2=A0 The first is the usual
 CPU wait for completion while the second is for use by userspace drivers t=
o wait until the first moment where they can submit work which depends on a=
 given time point.<u></u><u></u></p>
<p class=3D"MsoNormal"><span style=3D"color:windowtext"><u></u>=C2=A0<u></u=
></span></p>
<p class=3D"MsoNormal"><span style=3D"color:windowtext">Hi Jason,<u></u><u>=
</u></span></p>
<p class=3D"MsoNormal"><span style=3D"color:windowtext"><u></u>=C2=A0<u></u=
></span></p>
<p class=3D"MsoNormal"><span style=3D"color:windowtext">How about adding tw=
o new wait flags?<u></u><u></u></span></p>
<p class=3D"MsoNormal"><span style=3D"color:windowtext">DRM_SYNCOBJ_WAIT_FL=
AGS_WAIT_COMPLETED<u></u><u></u></span></p>
<p class=3D"MsoNormal"><span style=3D"color:windowtext">DRM_SYNCOBJ_WAIT_FL=
AGS_WAIT_AVAILABLE<u></u><u></u></span></p>
</div></div></blockquote><div><br></div><div>Those seem like fine names to =
me.=C2=A0 We should require that one of the two flags be present when the s=
ync object is a timeline.</div><div><br></div><div>--Jason<br></div><div>=
=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;bo=
rder-left:1px #ccc solid;padding-left:1ex"><div bgcolor=3D"white" link=3D"b=
lue" vlink=3D"purple" lang=3D"EN-US"><div class=3D"m_-1584312309811383151Wo=
rdSection1">
<p class=3D"MsoNormal"><span style=3D"color:windowtext">Thanks,<u></u><u></=
u></span></p>
<p class=3D"MsoNormal"><span style=3D"color:windowtext">David<u></u><u></u>=
</span></p>
<p class=3D"MsoNormal"><span style=3D"color:windowtext"><u></u>=C2=A0<u></u=
></span></p>
<div style=3D"border:none;border-left:solid blue 1.5pt;padding:0in 0in 0in =
4.0pt">
<div>
<div style=3D"border:none;border-top:solid #e1e1e1 1.0pt;padding:3.0pt 0in =
0in 0in">
<p class=3D"MsoNormal"><b><span style=3D"color:windowtext">From:</span></b>=
<span style=3D"color:windowtext"> Christian K=C3=B6nig &lt;<a href=3D"mailt=
o:ckoenig.leichtzumerken@gmail.com" target=3D"_blank">ckoenig.leichtzumerke=
n@gmail.com</a>&gt;
<br>
<b>Sent:</b> Tuesday, September 25, 2018 5:50 PM<br>
<b>To:</b> Jason Ekstrand &lt;<a href=3D"mailto:jason@jlekstrand.net" targe=
t=3D"_blank">jason@jlekstrand.net</a>&gt;; Zhou, David(ChunMing) &lt;<a hre=
f=3D"mailto:David1.Zhou@amd.com" target=3D"_blank">David1.Zhou@amd.com</a>&=
gt;<br>
<b>Cc:</b> amd-gfx mailing list &lt;<a href=3D"mailto:amd-gfx@lists.freedes=
ktop.org" target=3D"_blank">amd-gfx@lists.freedesktop.org</a>&gt;; Maling l=
ist - DRI developers &lt;<a href=3D"mailto:dri-devel@lists.freedesktop.org"=
 target=3D"_blank">dri-devel@lists.freedesktop.org</a>&gt;<br>
<b>Subject:</b> Re: [PATCH 3/6] drm: add support of syncobj timeline point =
wait v2<u></u><u></u></span></p>
</div>
</div>
<p class=3D"MsoNormal"><u></u>=C2=A0<u></u></p>
<div>
<p class=3D"MsoNormal">Am 25.09.2018 um 11:22 schrieb Jason Ekstrand:<u></u=
><u></u></p>
</div>
<blockquote style=3D"margin-top:5.0pt;margin-bottom:5.0pt">
<div>
<div>
<div>
<p class=3D"MsoNormal">On Thu, Sep 20, 2018 at 6:04 AM Chunming Zhou &lt;<a=
 href=3D"mailto:david1.zhou@amd.com" target=3D"_blank">david1.zhou@amd.com<=
/a>&gt; wrote:<u></u><u></u></p>
</div>
<blockquote style=3D"border:none;border-left:solid #cccccc 1.0pt;padding:0i=
n 0in 0in 6.0pt;margin-left:4.8pt;margin-right:0in">
<p class=3D"MsoNormal">points array is one-to-one match with syncobjs array=
.<br>
v2:<br>
add seperate ioctl for timeline point wait, otherwise break uapi.<u></u><u>=
</u></p>
</blockquote>
<div>
<p class=3D"MsoNormal"><u></u>=C2=A0<u></u></p>
</div>
<div>
<p class=3D"MsoNormal">I think ioctl structs can be extended as long as fie=
lds aren&#39;t re-ordered.=C2=A0 I&#39;m not sure on the details of this th=
ough as I&#39;m not a particularly experienced kernel developer.<u></u><u><=
/u></p>
</div>
</div>
</div>
</blockquote>
<p class=3D"MsoNormal"><br>
Yeah, that is correct. The problem in this particular case is that we don&#=
39;t change the direct IOCTL parameter, but rather the array it points to.<=
br>
<br>
We could do something like keep the existing handles array and add a separa=
te optional one for the timeline points. That would also drop the need for =
the padding of the structure.<br>
<br>
<br>
<u></u><u></u></p>
<blockquote style=3D"margin-top:5.0pt;margin-bottom:5.0pt">
<div>
<div>
<div>
<p class=3D"MsoNormal">Another general comment (no good place to put it) is=
 that I think we want two kinds of waits:=C2=A0 Wait for time point to be c=
ompleted and wait for time point to become available.=C2=A0 The first is th=
e usual CPU wait for completion while the second
 is for use by userspace drivers to wait until the first moment where they =
can submit work which depends on a given time point.<u></u><u></u></p>
</div>
</div>
</div>
</blockquote>
<p class=3D"MsoNormal"><br>
Oh, yeah that is a really good point as ell.<br>
<br>
Christian.<br>
<br>
<br>
<u></u><u></u></p>
<blockquote style=3D"margin-top:5.0pt;margin-bottom:5.0pt">
<div>
<div>
<div>
<p class=3D"MsoNormal">=C2=A0<u></u><u></u></p>
</div>
<blockquote style=3D"border:none;border-left:solid #cccccc 1.0pt;padding:0i=
n 0in 0in 6.0pt;margin-left:4.8pt;margin-right:0in">
<p class=3D"MsoNormal">Signed-off-by: Chunming Zhou &lt;<a href=3D"mailto:d=
avid1.zhou@amd.com" target=3D"_blank">david1.zhou@amd.com</a>&gt;<br>
---<br>
=C2=A0drivers/gpu/drm/drm_internal.h |=C2=A0 2 +<br>
=C2=A0drivers/gpu/drm/drm_ioctl.c=C2=A0 =C2=A0 |=C2=A0 2 +<br>
=C2=A0drivers/gpu/drm/drm_syncobj.c=C2=A0 | 99 ++++++++++++++++++++++++++++=
+-----<br>
=C2=A0include/uapi/drm/drm.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| 14 +++++<br=
>
=C2=A04 files changed, 103 insertions(+), 14 deletions(-)<br>
<br>
diff --git a/drivers/gpu/drm/drm_internal.h b/drivers/gpu/drm/drm_internal.=
h<br>
index 0c4eb4a9ab31..566d44e3c782 100644<br>
--- a/drivers/gpu/drm/drm_internal.h<br>
+++ b/drivers/gpu/drm/drm_internal.h<br>
@@ -183,6 +183,8 @@ int drm_syncobj_fd_to_handle_ioctl(struct drm_device *d=
ev, void *data,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0struct drm_file *file_p=
rivate);<br>
=C2=A0int drm_syncobj_wait_ioctl(struct drm_device *dev, void *data,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0struct drm_file *file_private);<br>
+int drm_syncobj_timeline_wait_ioctl(struct drm_device *dev, void *data,<br=
>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0struct drm_file *file_p=
rivate);<br>
=C2=A0int drm_syncobj_reset_ioctl(struct drm_device *dev, void *data,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 struct drm_file *file_private);<br>
=C2=A0int drm_syncobj_signal_ioctl(struct drm_device *dev, void *data,<br>
diff --git a/drivers/gpu/drm/drm_ioctl.c b/drivers/gpu/drm/drm_ioctl.c<br>
index 6b4a633b4240..c0891614f516 100644<br>
--- a/drivers/gpu/drm/drm_ioctl.c<br>
+++ b/drivers/gpu/drm/drm_ioctl.c<br>
@@ -669,6 +669,8 @@ static const struct drm_ioctl_desc drm_ioctls[] =3D {<b=
r>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 DRM_UNLOCKED|DRM_RENDER_ALLOW),<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 DRM_IOCTL_DEF(DRM_IOCTL_SYNCOBJ_WAIT, drm_synco=
bj_wait_ioctl,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 DRM_UNLOCKED|DRM_RENDER_ALLOW),<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0DRM_IOCTL_DEF(DRM_IOCTL_SYNCOBJ_TIMELINE_WAIT, =
drm_syncobj_timeline_wait_ioctl,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0DRM_UNLOCKED|DRM_RENDER_ALLOW),<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 DRM_IOCTL_DEF(DRM_IOCTL_SYNCOBJ_RESET, drm_sync=
obj_reset_ioctl,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 DRM_UNLOCKED|DRM_RENDER_ALLOW),<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 DRM_IOCTL_DEF(DRM_IOCTL_SYNCOBJ_SIGNAL, drm_syn=
cobj_signal_ioctl,<br>
diff --git a/drivers/gpu/drm/drm_syncobj.c b/drivers/gpu/drm/drm_syncobj.c<=
br>
index 67472bd77c83..a43de0e4616c 100644<br>
--- a/drivers/gpu/drm/drm_syncobj.c<br>
+++ b/drivers/gpu/drm/drm_syncobj.c<br>
@@ -126,13 +126,14 @@ static void drm_syncobj_add_callback_locked(struct dr=
m_syncobj *syncobj,<br>
=C2=A0}<br>
<br>
=C2=A0static int drm_syncobj_fence_get_or_add_callback(struct drm_syncobj *=
syncobj,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 u64 point,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0struct dma_fence **fence,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0struct drm_syncobj_cb *cb,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0drm_syncobj_func_t func)<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 int ret;<br>
<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0ret =3D drm_syncobj_search_fence(syncobj, 0, 0,=
 fence);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0ret =3D drm_syncobj_search_fence(syncobj, point=
, 0, fence);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (!ret)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return 1;<br>
<br>
@@ -143,7 +144,7 @@ static int drm_syncobj_fence_get_or_add_callback(struct=
 drm_syncobj *syncobj,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0*/<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (!list_empty(&amp;syncobj-&gt;signal_pt_list=
)) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 spin_unlock(&amp;sy=
ncobj-&gt;lock);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0drm_syncobj_search_=
fence(syncobj, 0, 0, fence);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0drm_syncobj_search_=
fence(syncobj, point, 0, fence);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (*fence)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 return 1;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 spin_lock(&amp;sync=
obj-&gt;lock);<br>
@@ -358,7 +359,9 @@ void drm_syncobj_replace_fence(struct drm_syncobj *sync=
obj,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 spin_lock(&amp;sync=
obj-&gt;lock);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 list_for_each_entry=
_safe(cur, tmp, &amp;syncobj-&gt;cb_list, node) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 list_del_init(&amp;cur-&gt;node);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0spin_unlock(&amp;syncobj-&gt;lock);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 cur-&gt;func(syncobj, cur);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0spin_lock(&amp;syncobj-&gt;lock);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 spin_unlock(&amp;sy=
ncobj-&gt;lock);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
@@ -856,6 +859,7 @@ struct syncobj_wait_entry {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 struct dma_fence *fence;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 struct dma_fence_cb fence_cb;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 struct drm_syncobj_cb syncobj_cb;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0u64=C2=A0 =C2=A0 point;<br>
=C2=A0};<br>
<br>
=C2=A0static void syncobj_wait_fence_func(struct dma_fence *fence,<br>
@@ -873,12 +877,13 @@ static void syncobj_wait_syncobj_func(struct drm_sync=
obj *syncobj,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 struct syncobj_wait_entry *wait =3D<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 container_of(cb, st=
ruct syncobj_wait_entry, syncobj_cb);<br>
<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0drm_syncobj_search_fence(syncobj, 0, 0, &amp;wa=
it-&gt;fence);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0drm_syncobj_search_fence(syncobj, wait-&gt;poin=
t, 0, &amp;wait-&gt;fence);<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 wake_up_process(wait-&gt;task);<br>
=C2=A0}<br>
<br>
=C2=A0static signed long drm_syncobj_array_wait_timeout(struct drm_syncobj =
**syncobjs,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0void __user *user_points,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 uint32_t count,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 uint32_t flags,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 signed long timeout,<br>
@@ -886,13 +891,27 @@ static signed long drm_syncobj_array_wait_timeout(str=
uct drm_syncobj **syncobjs,<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 struct syncobj_wait_entry *entries;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 struct dma_fence *fence;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0uint64_t *points;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 signed long ret;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 uint32_t signaled_count, i;<br>
<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0entries =3D kcalloc(count, sizeof(*entries), GF=
P_KERNEL);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0if (!entries)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0points =3D kmalloc_array(count, sizeof(*points)=
, GFP_KERNEL);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0if (points =3D=3D NULL)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return -ENOMEM;<br>
<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0if (!user_points) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0memset(points, 0, c=
ount * sizeof(uint64_t));<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0} else if (copy_from_user(points, user_points, =
sizeof(uint64_t) * count)) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ret =3D -EFAULT;<br=
>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0goto err_free_point=
s;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
+<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0entries =3D kcalloc(count, sizeof(*entries), GF=
P_KERNEL);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0if (!entries) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ret =3D -ENOMEM;<br=
>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0goto err_free_point=
s;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* Walk the list of sync objects and initialize=
 entries.=C2=A0 We do<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* this up-front so that we can properly r=
eturn -EINVAL if there is<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* a syncobj with a missing fence and then=
 never have the chance of<br>
@@ -901,7 +920,8 @@ static signed long drm_syncobj_array_wait_timeout(struc=
t drm_syncobj **syncobjs,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 signaled_count =3D 0;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 for (i =3D 0; i &lt; count; ++i) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 entries[i].task =3D=
 current;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ret =3D drm_syncobj=
_search_fence(syncobjs[i], 0, 0,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0entries[i].point =
=3D points[i];<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ret =3D drm_syncobj=
_search_fence(syncobjs[i], points[i], 0,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0&amp;entries[i].fence);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (!entries[i].fen=
ce) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 if (flags &amp; DRM_SYNCOBJ_WAIT_FLAGS_WAIT_FOR_SUBMIT) {<br>
@@ -940,6 +960,7 @@ static signed long drm_syncobj_array_wait_timeout(struc=
t drm_syncobj **syncobjs,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (flags &amp; DRM_SYNCOBJ_WAIT_FLAGS_WAIT_FOR=
_SUBMIT) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 for (i =3D 0; i &lt=
; count; ++i) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 drm_syncobj_fence_get_or_add_callback(syncobjs[i],<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0entrie=
s[i].point,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &amp;=
entries[i].fence,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &amp;=
entries[i].syncobj_cb,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 synco=
bj_wait_syncobj_func);<br>
@@ -1003,6 +1024,9 @@ static signed long drm_syncobj_array_wait_timeout(str=
uct drm_syncobj **syncobjs,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 kfree(entries);<br>
<br>
+err_free_points:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0kfree(points);<br>
+<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 return ret;<br>
=C2=A0}<br>
<br>
@@ -1041,20 +1065,33 @@ static signed long drm_timeout_abs_to_jiffies(int64=
_t timeout_nsec)<br>
=C2=A0static int drm_syncobj_array_wait(struct drm_device *dev,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 struct drm_file *file_private=
,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 struct drm_syncobj_wait *wait=
,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0struct drm_syncobj **syncobjs)=
<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0struct drm_syncobj_timeline_wa=
it *timeline_wait,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0struct drm_syncobj **syncobjs,=
 bool timeline)<br>
=C2=A0{<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0signed long timeout =3D drm_timeout_abs_to_jiff=
ies(wait-&gt;timeout_nsec);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0signed long timeout =3D 0;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 signed long ret =3D 0;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 uint32_t first =3D ~0;<br>
<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0ret =3D drm_syncobj_array_wait_timeout(syncobjs=
,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 wait-&gt;count_handles,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 wait-&gt;flags,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 timeout, &amp;first);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0if (!timeline) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0timeout =3D drm_tim=
eout_abs_to_jiffies(wait-&gt;timeout_nsec);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ret =3D drm_syncobj=
_array_wait_timeout(syncobjs,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 NULL,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 wait-&gt;count_handles,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 wait-&gt;flags,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 timeout, &amp;first);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0wait-&gt;first_sign=
aled =3D first;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0} else {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0timeout =3D drm_tim=
eout_abs_to_jiffies(timeline_wait-&gt;timeout_nsec);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ret =3D drm_syncobj=
_array_wait_timeout(syncobjs,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 u64_to_user_ptr(timeline_wait-&gt;points=
),<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 timeline_wait-&gt;count_handles,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 timeline_wait-&gt;flags,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 timeout, &amp;first);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0timeline_wait-&gt;f=
irst_signaled =3D first;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (ret &lt; 0)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return ret;<br>
<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0wait-&gt;first_signaled =3D first;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (ret =3D=3D 0)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return -ETIME;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 return 0;<br>
@@ -1142,13 +1179,47 @@ drm_syncobj_wait_ioctl(struct drm_device *dev, void=
 *data,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return ret;<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 ret =3D drm_syncobj_array_wait(dev, file_privat=
e,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 args, syncobjs);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 args, NULL, syncobjs, =
false);<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 drm_syncobj_array_free(syncobjs, args-&gt;count=
_handles);<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 return ret;<br>
=C2=A0}<br>
<br>
+int<br>
+drm_syncobj_timeline_wait_ioctl(struct drm_device *dev, void *data,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0struct drm_file *file_private)<br>
+{<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0struct drm_syncobj_timeline_wait *args =3D data=
;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0struct drm_syncobj **syncobjs;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0int ret =3D 0;<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0if (!drm_core_check_feature(dev, DRIVER_SYNCOBJ=
))<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return -ENODEV;<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0if (args-&gt;flags &amp; ~(DRM_SYNCOBJ_WAIT_FLA=
GS_WAIT_ALL |<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0DRM_SYNCOBJ_WAIT_FLAGS_WAIT_FOR_SUBMIT))<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return -EINVAL;<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0if (args-&gt;count_handles =3D=3D 0)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return -EINVAL;<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0ret =3D drm_syncobj_array_find(file_private,<br=
>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 u64_to_user_ptr(args-&=
gt;handles),<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 args-&gt;count_handles=
,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &amp;syncobjs);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0if (ret &lt; 0)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return ret;<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0ret =3D drm_syncobj_array_wait(dev, file_privat=
e,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 NULL, args, syncobjs, =
true);<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0drm_syncobj_array_free(syncobjs, args-&gt;count=
_handles);<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0return ret;<br>
+}<br>
+<br>
+<br>
=C2=A0int<br>
=C2=A0drm_syncobj_reset_ioctl(struct drm_device *dev, void *data,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 struct drm_file *file_private)<br>
diff --git a/include/uapi/drm/drm.h b/include/uapi/drm/drm.h<br>
index cebdb2541eb7..501e86d81f47 100644<br>
--- a/include/uapi/drm/drm.h<br>
+++ b/include/uapi/drm/drm.h<br>
@@ -748,6 +748,19 @@ struct drm_syncobj_wait {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 __u32 pad;<br>
=C2=A0};<br>
<br>
+struct drm_syncobj_timeline_wait {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0__u64 handles;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0/* wait on specific timeline point for every ha=
ndles*/<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0__u64 points;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0/* absolute timeout */<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0__s64 timeout_nsec;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0__u32 count_handles;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0__u32 flags;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0__u32 first_signaled; /* only valid when not wa=
iting all */<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0__u32 pad;<br>
+};<br>
+<br>
+<br>
=C2=A0struct drm_syncobj_array {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 __u64 handles;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 __u32 count_handles;<br>
@@ -910,6 +923,7 @@ extern &quot;C&quot; {<br>
=C2=A0#define DRM_IOCTL_MODE_GET_LEASE=C2=A0 =C2=A0 =C2=A0 =C2=A0DRM_IOWR(0=
xC8, struct drm_mode_get_lease)<br>
=C2=A0#define DRM_IOCTL_MODE_REVOKE_LEASE=C2=A0 =C2=A0 DRM_IOWR(0xC9, struc=
t drm_mode_revoke_lease)<br>
<br>
+#define DRM_IOCTL_SYNCOBJ_TIMELINE_WAIT=C2=A0 =C2=A0 =C2=A0 =C2=A0 DRM_IOW=
R(0xCA, struct drm_syncobj_timeline_wait)<br>
=C2=A0/**<br>
=C2=A0 * Device specific ioctls should only be in their respective headers<=
br>
=C2=A0 * The device specific ioctl range is from 0x40 to 0x9f.<br>
-- <br>
2.17.1<br>
<br>
_______________________________________________<br>
dri-devel mailing list<br>
<a href=3D"mailto:dri-devel@lists.freedesktop.org" target=3D"_blank">dri-de=
vel@lists.freedesktop.org</a><br>
<a href=3D"https://lists.freedesktop.org/mailman/listinfo/dri-devel" target=
=3D"_blank">https://lists.freedesktop.org/mailman/listinfo/dri-devel</a><u>=
</u><u></u></p>
</blockquote>
</div>
</div>
<p class=3D"MsoNormal"><br>
<br>
<br>
<u></u><u></u></p>
<pre>_______________________________________________<u></u><u></u></pre>
<pre>dri-devel mailing list<u></u><u></u></pre>
<pre><a href=3D"mailto:dri-devel@lists.freedesktop.org" target=3D"_blank">d=
ri-devel@lists.freedesktop.org</a><u></u><u></u></pre>
<pre><a href=3D"https://lists.freedesktop.org/mailman/listinfo/dri-devel" t=
arget=3D"_blank">https://lists.freedesktop.org/mailman/listinfo/dri-devel</=
a><u></u><u></u></pre>
</blockquote>
<p class=3D"MsoNormal"><u></u>=C2=A0<u></u></p>
</div>
</div>
</div>

</blockquote></div></div>

--00000000000081cebf0577bb4d5f--

--===============2123723107==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KZHJpLWRldmVs
IG1haWxpbmcgbGlzdApkcmktZGV2ZWxAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlz
dHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vZHJpLWRldmVsCg==

--===============2123723107==--
