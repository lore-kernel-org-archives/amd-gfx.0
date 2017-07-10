From: Jason Ekstrand <jason@jlekstrand.net>
Subject: Re: [PATCH] drm/syncobj: add sync obj wait interface. (v6)
Date: Mon, 10 Jul 2017 08:52:46 -0700
Message-ID: <CAOFGe96gaX2OjsXr8bNBUiqwyKAQfMSycH7PXgYAt_BBJ1UHkQ@mail.gmail.com>
References: <20170706010409.9373-1-airlied@gmail.com>
 <CAOFGe94mA9i7+-XTJQn65N-vK_GbQwvjru2b=6ucXejpWWmx4g@mail.gmail.com>
 <899f9bb3-f7c7-ce86-c22b-bb8d262778bf@vodafone.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1346467712=="
Return-path: <dri-devel-bounces@lists.freedesktop.org>
In-Reply-To: <899f9bb3-f7c7-ce86-c22b-bb8d262778bf@vodafone.de>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <deathsimple@vodafone.de>
Cc: Maling list - DRI developers <dri-devel@lists.freedesktop.org>, amd-gfx mailing list <amd-gfx@lists.freedesktop.org>
List-Id: amd-gfx.lists.freedesktop.org

--===============1346467712==
Content-Type: multipart/alternative; boundary="94eb2c0df1800ca98e0553f89348"

--94eb2c0df1800ca98e0553f89348
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 10, 2017 at 8:45 AM, Christian K=C3=B6nig <deathsimple@vodafone=
.de>
wrote:

> Am 10.07.2017 um 17:28 schrieb Jason Ekstrand:
>
> On Wed, Jul 5, 2017 at 6:04 PM, Dave Airlie <airlied@gmail.com> wrote:
>
>> From: Dave Airlie <airlied@redhat.com>
>>
>> This interface will allow sync object to be used to back
>> Vulkan fences. This API is pretty much the vulkan fence waiting
>> API, and I've ported the code from amdgpu.
>>
>> v2: accept relative timeout, pass remaining time back
>> to userspace.
>> v3: return to absolute timeouts.
>> v4: absolute zero =3D poll,
>>     rewrite any/all code to have same operation for arrays
>>     return -EINVAL for 0 fences.
>> v4.1: fixup fences allocation check, use u64_to_user_ptr
>> v5: move to sec/nsec, and use timespec64 for calcs.
>> v6: use -ETIME and drop the out status flag. (-ETIME
>> is suggested by ickle, I can feel a shed painting)
>>
>> Signed-off-by: Dave Airlie <airlied@redhat.com>
>> ---
>>  drivers/gpu/drm/drm_internal.h |   2 +
>>  drivers/gpu/drm/drm_ioctl.c    |   2 +
>>  drivers/gpu/drm/drm_syncobj.c  | 142 ++++++++++++++++++++++++++++++
>> +++++++++++
>>  include/uapi/drm/drm.h         |  13 ++++
>>  4 files changed, 159 insertions(+)
>>
>> diff --git a/drivers/gpu/drm/drm_internal.h
>> b/drivers/gpu/drm/drm_internal.h
>> index 5cecc97..d71b50d 100644
>> --- a/drivers/gpu/drm/drm_internal.h
>> +++ b/drivers/gpu/drm/drm_internal.h
>> @@ -157,3 +157,5 @@ int drm_syncobj_handle_to_fd_ioctl(struct drm_device
>> *dev, void *data,
>>                                    struct drm_file *file_private);
>>  int drm_syncobj_fd_to_handle_ioctl(struct drm_device *dev, void *data,
>>                                    struct drm_file *file_private);
>> +int drm_syncobj_wait_ioctl(struct drm_device *dev, void *data,
>> +                          struct drm_file *file_private);
>> diff --git a/drivers/gpu/drm/drm_ioctl.c b/drivers/gpu/drm/drm_ioctl.c
>> index f1e5681..385ce74 100644
>> --- a/drivers/gpu/drm/drm_ioctl.c
>> +++ b/drivers/gpu/drm/drm_ioctl.c
>> @@ -657,6 +657,8 @@ static const struct drm_ioctl_desc drm_ioctls[] =3D =
{
>>                       DRM_UNLOCKED|DRM_RENDER_ALLOW),
>>         DRM_IOCTL_DEF(DRM_IOCTL_SYNCOBJ_FD_TO_HANDLE,
>> drm_syncobj_fd_to_handle_ioctl,
>>                       DRM_UNLOCKED|DRM_RENDER_ALLOW),
>> +       DRM_IOCTL_DEF(DRM_IOCTL_SYNCOBJ_WAIT, drm_syncobj_wait_ioctl,
>> +                     DRM_UNLOCKED|DRM_RENDER_ALLOW),
>>  };
>>
>>  #define DRM_CORE_IOCTL_COUNT   ARRAY_SIZE( drm_ioctls )
>> diff --git a/drivers/gpu/drm/drm_syncobj.c b/drivers/gpu/drm/drm_syncobj=
.
>> c
>> index 89441bc..2d5a7a1 100644
>> --- a/drivers/gpu/drm/drm_syncobj.c
>> +++ b/drivers/gpu/drm/drm_syncobj.c
>> @@ -1,5 +1,7 @@
>>  /*
>>   * Copyright 2017 Red Hat
>> + * Parts ported from amdgpu (fence wait code).
>> + * Copyright 2016 Advanced Micro Devices, Inc.
>>   *
>>   * Permission is hereby granted, free of charge, to any person obtainin=
g
>> a
>>   * copy of this software and associated documentation files (the
>> "Software"),
>> @@ -31,6 +33,9 @@
>>   * that contain an optional fence. The fence can be updated with a new
>>   * fence, or be NULL.
>>   *
>> + * syncobj's can be waited upon, where it will wait for the underlying
>> + * fence.
>> + *
>>   * syncobj's can be export to fd's and back, these fd's are opaque and
>>   * have no other use case, except passing the syncobj between processes=
.
>>   *
>> @@ -451,3 +456,140 @@ drm_syncobj_fd_to_handle_ioctl(struct drm_device
>> *dev, void *data,
>>         return drm_syncobj_fd_to_handle(file_private, args->fd,
>>                                         &args->handle);
>>  }
>> +
>> +/**
>> + * drm_timeout_abs_to_jiffies - calculate jiffies timeout from absolute
>> value
>> + *
>> + * @timeout_sec: timeout sec component, 0 for poll
>> + * @timeout_nsec: timeout nsec component in ns, 0 for poll
>> + * both must be 0 for poll.
>> + *
>> + * Calculate the timeout in jiffies from an absolute time in sec/nsec.
>> + */
>> +static unsigned long drm_timeout_abs_to_jiffies(int64_t timeout_sec,
>> uint64_t timeout_nsec)
>> +{
>> +       struct timespec64 abs_timeout, timeout, max_jiffy_timespec;
>> +       unsigned long timeout_jiffies;
>> +
>> +       /* make 0 timeout means poll - absolute 0 doesn't seem valid */
>> +       if (timeout_sec =3D=3D 0 && timeout_nsec =3D=3D 0)
>> +               return 0;
>> +
>> +       abs_timeout.tv_sec =3D timeout_sec;
>> +       abs_timeout.tv_nsec =3D timeout_nsec;
>> +
>> +       /* clamp timeout if it's to large */
>> +       if (!timespec64_valid_strict(&abs_timeout))
>> +               return MAX_SCHEDULE_TIMEOUT - 1;
>> +
>> +       timeout =3D timespec64_sub(abs_timeout,
>> ktime_to_timespec64(ktime_get()));
>> +       if (!timespec64_valid(&timeout))
>> +               return 0;
>> +
>> +       jiffies_to_timespec64(MAX_JIFFY_OFFSET, &max_jiffy_timespec);
>> +       if (timespec64_compare(&timeout, &max_jiffy_timespec) >=3D 0)
>> +               return MAX_SCHEDULE_TIMEOUT - 1;
>> +
>> +       timeout_jiffies =3D timespec64_to_jiffies(&timeout);
>> +       /*  clamp timeout to avoid infinite timeout */
>> +       if (timeout_jiffies >=3D MAX_SCHEDULE_TIMEOUT)
>> +               return MAX_SCHEDULE_TIMEOUT - 1;
>> +
>> +       return timeout_jiffies + 1;
>> +}
>> +
>> +static int drm_syncobj_wait_fences(struct drm_device *dev,
>> +                                  struct drm_file *file_private,
>> +                                  struct drm_syncobj_wait *wait,
>> +                                  struct dma_fence **fences)
>> +{
>> +       unsigned long timeout =3D drm_timeout_abs_to_jiffies(wait->timeo=
ut_sec,
>> wait->timeout_nsec);
>> +       int ret =3D 0;
>> +       uint32_t first =3D ~0;
>> +
>> +       if (wait->flags & DRM_SYNCOBJ_WAIT_FLAGS_WAIT_ALL) {
>> +               int i;
>> +               for (i =3D 0; i < wait->count_handles; i++) {
>> +                       ret =3D dma_fence_wait_timeout(fences[i], true,
>> timeout);
>> +
>> +                       if (ret < 0)
>> +                               return ret;
>> +                       if (ret =3D=3D 0)
>> +                               break;
>> +                       timeout =3D ret;
>> +               }
>> +               first =3D 0;
>> +       } else {
>> +               ret =3D dma_fence_wait_any_timeout(fences,
>> +                                                wait->count_handles,
>> +                                                true, timeout,
>> +                                                &first);
>> +       }
>> +
>> +       if (ret < 0)
>> +               return ret;
>> +
>> +       wait->first_signaled =3D first;
>> +       if (ret =3D=3D 0)
>> +               return -ETIME;
>> +       return 0;
>> +}
>> +
>> +int
>> +drm_syncobj_wait_ioctl(struct drm_device *dev, void *data,
>> +                      struct drm_file *file_private)
>> +{
>> +       struct drm_syncobj_wait *args =3D data;
>> +       uint32_t *handles;
>> +       struct dma_fence **fences;
>> +       int ret =3D 0;
>> +       int i;
>> +
>> +       if (!drm_core_check_feature(dev, DRIVER_SYNCOBJ))
>> +               return -ENODEV;
>> +
>> +       if (args->flags !=3D 0 && args->flags !=3D
>> DRM_SYNCOBJ_WAIT_FLAGS_WAIT_ALL)
>> +               return -EINVAL;
>> +
>> +       if (args->count_handles =3D=3D 0)
>> +               return -EINVAL;
>> +
>> +       /* Get the handles from userspace */
>> +       handles =3D kmalloc_array(args->count_handles, sizeof(uint32_t),
>> +                               GFP_KERNEL);
>> +       if (handles =3D=3D NULL)
>> +               return -ENOMEM;
>> +
>> +       if (copy_from_user(handles,
>> +                          u64_to_user_ptr(args->handles),
>> +                          sizeof(uint32_t) * args->count_handles)) {
>> +               ret =3D -EFAULT;
>> +               goto err_free_handles;
>> +       }
>> +
>> +       fences =3D kcalloc(args->count_handles,
>> +                        sizeof(struct dma_fence *), GFP_KERNEL);
>> +       if (!fences) {
>> +               ret =3D -ENOMEM;
>> +               goto err_free_handles;
>> +       }
>> +
>> +       for (i =3D 0; i < args->count_handles; i++) {
>> +               ret =3D drm_syncobj_fence_get(file_private, handles[i],
>> +                                           &fences[i]);
>> +               if (ret)
>> +                       goto err_free_fence_array;
>> +       }
>> +
>> +       ret =3D drm_syncobj_wait_fences(dev, file_private,
>> +                                     args, fences);
>>
>
> So, reading some CTS tests again, and I think we have a problem here.  Th=
e
> Vulkan spec allows you to wait on a fence that is in the unsignaled state=
.
>
>
> At least on the closed source driver that would be illegal as far as I
> know.
>

Then they are doing workarounds in userspace.  There are definitely CTS
tests for this:

https://github.com/KhronosGroup/VK-GL-CTS/blob/master/external/vulkancts/mo=
dules/vulkan/synchronization/vktSynchronizationBasicFenceTests.cpp#L74


> You can't wait on a semaphore before the signal operation is send down to
> the kerel.
>

We (Intel) deal with this today by tracking whether or not the fence has
been submitted and using a condition variable in userspace to sort it all
out.  If we ever want to share fences across processes (which we do), then
this needs to be sorted in the kernel.

--Jason



> Regards,
> Christian.
>
>
>   In theory, you could have thread A start waiting on a fence before
> thread B submits the work which triggers that fence.  This means that the
> dma_fence may not exist yet when vkWaitForFences gets called.  If we real=
ly
> want to support the full Vulkan usage, we need to somehow support missing
> dma_fences by waiting for the dma_fence to show up.  Unfortunately, I don=
't
> know enough about the internal kernel APIs to know what that would look
> like.
>
>
>
>> +
>> +err_free_fence_array:
>> +       for (i =3D 0; i < args->count_handles; i++)
>> +               dma_fence_put(fences[i]);
>> +       kfree(fences);
>> +err_free_handles:
>> +       kfree(handles);
>> +
>> +       return ret;
>> +}
>> diff --git a/include/uapi/drm/drm.h b/include/uapi/drm/drm.h
>> index 101593a..91746a7 100644
>> --- a/include/uapi/drm/drm.h
>> +++ b/include/uapi/drm/drm.h
>> @@ -718,6 +718,18 @@ struct drm_syncobj_handle {
>>         __u32 pad;
>>  };
>>
>> +#define DRM_SYNCOBJ_WAIT_FLAGS_WAIT_ALL (1 << 0)
>> +struct drm_syncobj_wait {
>> +       __u64 handles;
>> +       /* absolute timeout */
>> +       __s64 timeout_sec;
>> +       __s64 timeout_nsec;
>> +       __u32 count_handles;
>> +       __u32 flags;
>> +       __u32 first_signaled; /* only valid when not waiting all */
>> +       __u32 pad;
>> +};
>> +
>>  #if defined(__cplusplus)
>>  }
>>  #endif
>> @@ -840,6 +852,7 @@ extern "C" {
>>  #define DRM_IOCTL_SYNCOBJ_DESTROY      DRM_IOWR(0xC0, struct
>> drm_syncobj_destroy)
>>  #define DRM_IOCTL_SYNCOBJ_HANDLE_TO_FD DRM_IOWR(0xC1, struct
>> drm_syncobj_handle)
>>  #define DRM_IOCTL_SYNCOBJ_FD_TO_HANDLE DRM_IOWR(0xC2, struct
>> drm_syncobj_handle)
>> +#define DRM_IOCTL_SYNCOBJ_WAIT         DRM_IOWR(0xC3, struct
>> drm_syncobj_wait)
>>
>>  /**
>>   * Device specific ioctls should only be in their respective headers
>> --
>> 2.9.4
>>
>> _______________________________________________
>> dri-devel mailing list
>> dri-devel@lists.freedesktop.org
>> https://lists.freedesktop.org/mailman/listinfo/dri-devel
>>
>
>
>
> _______________________________________________
> amd-gfx mailing listamd-gfx@lists.freedesktop.orghttps://lists.freedeskto=
p.org/mailman/listinfo/amd-gfx
>
>
>

--94eb2c0df1800ca98e0553f89348
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_extra"><div class=3D"gmail_quote">On M=
on, Jul 10, 2017 at 8:45 AM, Christian K=C3=B6nig <span dir=3D"ltr">&lt;<a =
href=3D"mailto:deathsimple@vodafone.de" target=3D"_blank">deathsimple@vodaf=
one.de</a>&gt;</span> wrote:<br><blockquote class=3D"gmail_quote" style=3D"=
margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-lef=
t:1ex">
 =20
   =20
 =20
  <div bgcolor=3D"#FFFFFF"><div><div class=3D"gmail-h5">
    <div class=3D"gmail-m_-226855681158848481moz-cite-prefix">Am 10.07.2017=
 um 17:28 schrieb Jason
      Ekstrand:<br>
    </div>
    <blockquote type=3D"cite">
      <div dir=3D"ltr">
        <div class=3D"gmail_extra">
          <div class=3D"gmail_quote">On Wed, Jul 5, 2017 at 6:04 PM, Dave
            Airlie <span dir=3D"ltr">&lt;<a href=3D"mailto:airlied@gmail.co=
m" target=3D"_blank">airlied@gmail.com</a>&gt;</span>
            wrote:<br>
            <blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0=
.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">From:
              Dave Airlie &lt;<a href=3D"mailto:airlied@redhat.com" target=
=3D"_blank">airlied@redhat.com</a>&gt;<br>
              <br>
              This interface will allow sync object to be used to back<br>
              Vulkan fences. This API is pretty much the vulkan fence
              waiting<br>
              API, and I&#39;ve ported the code from amdgpu.<br>
              <br>
              v2: accept relative timeout, pass remaining time back<br>
              to userspace.<br>
              v3: return to absolute timeouts.<br>
              v4: absolute zero =3D poll,<br>
              =C2=A0 =C2=A0 rewrite any/all code to have same operation for=
 arrays<br>
              =C2=A0 =C2=A0 return -EINVAL for 0 fences.<br>
              v4.1: fixup fences allocation check, use u64_to_user_ptr<br>
              v5: move to sec/nsec, and use timespec64 for calcs.<br>
              v6: use -ETIME and drop the out status flag. (-ETIME<br>
              is suggested by ickle, I can feel a shed painting)<br>
              <br>
              Signed-off-by: Dave Airlie &lt;<a href=3D"mailto:airlied@redh=
at.com" target=3D"_blank">airlied@redhat.com</a>&gt;<br>
              ---<br>
              =C2=A0drivers/gpu/drm/drm_internal.<wbr>h |=C2=A0 =C2=A02 +<b=
r>
              =C2=A0drivers/gpu/drm/drm_ioctl.c=C2=A0 =C2=A0 |=C2=A0 =C2=A0=
2 +<br>
              =C2=A0drivers/gpu/drm/drm_syncobj.<wbr>c=C2=A0 | 142
              ++++++++++++++++++++++++++++++<wbr>+++++++++++<br>
              =C2=A0include/uapi/drm/drm.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0|=C2=A0 13 ++++<br>
              =C2=A04 files changed, 159 insertions(+)<br>
              <br>
              diff --git a/drivers/gpu/drm/drm_internal<wbr>.h
              b/drivers/gpu/drm/drm_internal<wbr>.h<br>
              index 5cecc97..d71b50d 100644<br>
              --- a/drivers/gpu/drm/drm_internal<wbr>.h<br>
              +++ b/drivers/gpu/drm/drm_internal<wbr>.h<br>
              @@ -157,3 +157,5 @@ int drm_syncobj_handle_to_fd_ioctl<wbr>(s=
truct
              drm_device *dev, void *data,<br>
              =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0struct dr=
m_file
              *file_private);<br>
              =C2=A0int drm_syncobj_fd_to_handle_ioctl<wbr>(struct drm_devi=
ce
              *dev, void *data,<br>
              =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0struct dr=
m_file
              *file_private);<br>
              +int drm_syncobj_wait_ioctl(struct drm_device *dev, void
              *data,<br>
              +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 struct drm_file *file_private);<br>
              diff --git a/drivers/gpu/drm/drm_ioctl.c
              b/drivers/gpu/drm/drm_ioctl.c<br>
              index f1e5681..385ce74 100644<br>
              --- a/drivers/gpu/drm/drm_ioctl.c<br>
              +++ b/drivers/gpu/drm/drm_ioctl.c<br>
              @@ -657,6 +657,8 @@ static const struct drm_ioctl_desc
              drm_ioctls[] =3D {<br>
              =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 DRM_UNLOCKED|DRM_RENDER_ALLOW)<wbr>,<br>
              =C2=A0 =C2=A0 =C2=A0 =C2=A0 DRM_IOCTL_DEF(DRM_IOCTL_SYNCOB<wb=
r>J_FD_TO_HANDLE,
              drm_syncobj_fd_to_handle_ioctl<wbr>,<br>
              =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 DRM_UNLOCKED|DRM_RENDER_ALLOW)<wbr>,<br>
              +=C2=A0 =C2=A0 =C2=A0 =C2=A0DRM_IOCTL_DEF(DRM_IOCTL_SYNCO<wbr=
>BJ_WAIT,
              drm_syncobj_wait_ioctl,<br>
              +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0DRM_UNLOCKED|DRM_RENDER_<wbr>ALLOW),<br>
              =C2=A0};<br>
              <br>
              =C2=A0#define DRM_CORE_IOCTL_COUNT=C2=A0 =C2=A0ARRAY_SIZE( dr=
m_ioctls )<br>
              diff --git a/drivers/gpu/drm/drm_syncobj.<wbr>c
              b/drivers/gpu/drm/drm_syncobj.<wbr>c<br>
              index 89441bc..2d5a7a1 100644<br>
              --- a/drivers/gpu/drm/drm_syncobj.<wbr>c<br>
              +++ b/drivers/gpu/drm/drm_syncobj.<wbr>c<br>
              @@ -1,5 +1,7 @@<br>
              =C2=A0/*<br>
              =C2=A0 * Copyright 2017 Red Hat<br>
              + * Parts ported from amdgpu (fence wait code).<br>
              + * Copyright 2016 Advanced Micro Devices, Inc.<br>
              =C2=A0 *<br>
              =C2=A0 * Permission is hereby granted, free of charge, to any
              person obtaining a<br>
              =C2=A0 * copy of this software and associated documentation
              files (the &quot;Software&quot;),<br>
              @@ -31,6 +33,9 @@<br>
              =C2=A0 * that contain an optional fence. The fence can be
              updated with a new<br>
              =C2=A0 * fence, or be NULL.<br>
              =C2=A0 *<br>
              + * syncobj&#39;s can be waited upon, where it will wait for
              the underlying<br>
              + * fence.<br>
              + *<br>
              =C2=A0 * syncobj&#39;s can be export to fd&#39;s and back, th=
ese fd&#39;s
              are opaque and<br>
              =C2=A0 * have no other use case, except passing the syncobj
              between processes.<br>
              =C2=A0 *<br>
              @@ -451,3 +456,140 @@ drm_syncobj_fd_to_handle_ioctl<wbr>(str=
uct
              drm_device *dev, void *data,<br>
              =C2=A0 =C2=A0 =C2=A0 =C2=A0 return drm_syncobj_fd_to_handle(f=
ile_<wbr>private,
              args-&gt;fd,<br>
              =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0
              &amp;args-&gt;handle);<br>
              =C2=A0}<br>
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
              +static unsigned long drm_timeout_abs_to_jiffies(int<wbr>64_t
              timeout_sec, uint64_t timeout_nsec)<br>
              +{<br>
              +=C2=A0 =C2=A0 =C2=A0 =C2=A0struct timespec64 abs_timeout, ti=
meout,
              max_jiffy_timespec;<br>
              +=C2=A0 =C2=A0 =C2=A0 =C2=A0unsigned long timeout_jiffies;<br=
>
              +<br>
              +=C2=A0 =C2=A0 =C2=A0 =C2=A0/* make 0 timeout means poll - ab=
solute 0 doesn&#39;t
              seem valid */<br>
              +=C2=A0 =C2=A0 =C2=A0 =C2=A0if (timeout_sec =3D=3D 0 &amp;&am=
p; timeout_nsec =3D=3D 0)<br>
              +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0retur=
n 0;<br>
              +<br>
              +=C2=A0 =C2=A0 =C2=A0 =C2=A0abs_timeout.tv_sec =3D timeout_se=
c;<br>
              +=C2=A0 =C2=A0 =C2=A0 =C2=A0abs_timeout.tv_nsec =3D timeout_n=
sec;<br>
              +<br>
              +=C2=A0 =C2=A0 =C2=A0 =C2=A0/* clamp timeout if it&#39;s to l=
arge */<br>
              +=C2=A0 =C2=A0 =C2=A0 =C2=A0if (!timespec64_valid_strict(&amp=
;abs<wbr>_timeout))<br>
              +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0retur=
n MAX_SCHEDULE_TIMEOUT - 1;<br>
              +<br>
              +=C2=A0 =C2=A0 =C2=A0 =C2=A0timeout =3D timespec64_sub(abs_ti=
meout,
              ktime_to_timespec64(ktime_get(<wbr>)));<br>
              +=C2=A0 =C2=A0 =C2=A0 =C2=A0if (!timespec64_valid(&amp;timeou=
t))<br>
              +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0retur=
n 0;<br>
              +<br>
              +=C2=A0 =C2=A0 =C2=A0 =C2=A0jiffies_to_timespec64(MAX_JIF<wbr=
>FY_OFFSET,
              &amp;max_jiffy_timespec);<br>
              +=C2=A0 =C2=A0 =C2=A0 =C2=A0if (timespec64_compare(&amp;timeo=
ut,
              &amp;max_jiffy_timespec) &gt;=3D 0)<br>
              +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0retur=
n MAX_SCHEDULE_TIMEOUT - 1;<br>
              +<br>
              +=C2=A0 =C2=A0 =C2=A0 =C2=A0timeout_jiffies =3D timespec64_to=
_jiffies(&amp;timeout<wbr>);<br>
              +=C2=A0 =C2=A0 =C2=A0 =C2=A0/*=C2=A0 clamp timeout to avoid i=
nfinite timeout */<br>
              +=C2=A0 =C2=A0 =C2=A0 =C2=A0if (timeout_jiffies &gt;=3D MAX_S=
CHEDULE_TIMEOUT)<br>
              +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0retur=
n MAX_SCHEDULE_TIMEOUT - 1;<br>
              +<br>
              +=C2=A0 =C2=A0 =C2=A0 =C2=A0return timeout_jiffies + 1;<br>
              +}<br>
              +<br>
              +static int drm_syncobj_wait_fences(struct drm_device
              *dev,<br>
              +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 struct drm_file
              *file_private,<br>
              +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 struct drm_sync=
obj_wait
              *wait,<br>
              +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 struct dma_fenc=
e
              **fences)<br>
              +{<br>
              +=C2=A0 =C2=A0 =C2=A0 =C2=A0unsigned long timeout =3D
              drm_timeout_abs_to_jiffies(wai<wbr>t-&gt;timeout_sec,
              wait-&gt;timeout_nsec);<br>
              +=C2=A0 =C2=A0 =C2=A0 =C2=A0int ret =3D 0;<br>
              +=C2=A0 =C2=A0 =C2=A0 =C2=A0uint32_t first =3D ~0;<br>
              +<br>
              +=C2=A0 =C2=A0 =C2=A0 =C2=A0if (wait-&gt;flags &amp;
              DRM_SYNCOBJ_WAIT_FLAGS_WAIT_AL<wbr>L) {<br>
              +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0int i=
;<br>
              +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0for (=
i =3D 0; i &lt; wait-&gt;count_handles;
              i++) {<br>
              +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0ret =3D
              dma_fence_wait_timeout(fences[<wbr>i], true, timeout);<br>
              +<br>
              +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0if (ret &lt; 0)<br>
              +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return ret;<br>
              +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0if (ret =3D=3D 0)<br>
              +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0break;<br>
              +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0timeout =3D ret;<br>
              +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
              +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0first=
 =3D 0;<br>
              +=C2=A0 =C2=A0 =C2=A0 =C2=A0} else {<br>
              +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ret =
=3D dma_fence_wait_any_timeout(fen<wbr>ces,<br>
              +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0
              wait-&gt;count_handles,<br>
              +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 true,
              timeout,<br>
              +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0
              &amp;first);<br>
              +=C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
              +<br>
              +=C2=A0 =C2=A0 =C2=A0 =C2=A0if (ret &lt; 0)<br>
              +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0retur=
n ret;<br>
              +<br>
              +=C2=A0 =C2=A0 =C2=A0 =C2=A0wait-&gt;first_signaled =3D first=
;<br>
              +=C2=A0 =C2=A0 =C2=A0 =C2=A0if (ret =3D=3D 0)<br>
              +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0retur=
n -ETIME;<br>
              +=C2=A0 =C2=A0 =C2=A0 =C2=A0return 0;<br>
              +}<br>
              +<br>
              +int<br>
              +drm_syncobj_wait_ioctl(struct drm_device *dev, void
              *data,<br>
              +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 struct drm_file *file_private)<br>
              +{<br>
              +=C2=A0 =C2=A0 =C2=A0 =C2=A0struct drm_syncobj_wait *args =3D=
 data;<br>
              +=C2=A0 =C2=A0 =C2=A0 =C2=A0uint32_t *handles;<br>
              +=C2=A0 =C2=A0 =C2=A0 =C2=A0struct dma_fence **fences;<br>
              +=C2=A0 =C2=A0 =C2=A0 =C2=A0int ret =3D 0;<br>
              +=C2=A0 =C2=A0 =C2=A0 =C2=A0int i;<br>
              +<br>
              +=C2=A0 =C2=A0 =C2=A0 =C2=A0if (!drm_core_check_feature(dev, =
DRIVER_SYNCOBJ))<br>
              +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0retur=
n -ENODEV;<br>
              +<br>
              +=C2=A0 =C2=A0 =C2=A0 =C2=A0if (args-&gt;flags !=3D 0 &amp;&a=
mp; args-&gt;flags
              !=3D DRM_SYNCOBJ_WAIT_FLAGS_WAIT_AL<wbr>L)<br>
              +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0retur=
n -EINVAL;<br>
              +<br>
              +=C2=A0 =C2=A0 =C2=A0 =C2=A0if (args-&gt;count_handles =3D=3D=
 0)<br>
              +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0retur=
n -EINVAL;<br>
              +<br>
              +=C2=A0 =C2=A0 =C2=A0 =C2=A0/* Get the handles from userspace=
 */<br>
              +=C2=A0 =C2=A0 =C2=A0 =C2=A0handles =3D kmalloc_array(args-&g=
t;count_hand<wbr>les,
              sizeof(uint32_t),<br>
              +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0GFP_KERNEL);<br>
              +=C2=A0 =C2=A0 =C2=A0 =C2=A0if (handles =3D=3D NULL)<br>
              +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0retur=
n -ENOMEM;<br>
              +<br>
              +=C2=A0 =C2=A0 =C2=A0 =C2=A0if (copy_from_user(handles,<br>
              +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0
              u64_to_user_ptr(args-&gt;handles)<wbr>,<br>
              +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 sizeof(uint32_t) *
              args-&gt;count_handles)) {<br>
              +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ret =
=3D -EFAULT;<br>
              +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0goto =
err_free_handles;<br>
              +=C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
              +<br>
              +=C2=A0 =C2=A0 =C2=A0 =C2=A0fences =3D kcalloc(args-&gt;count=
_handles,<br>
              +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 sizeof(struct dma_fence *),
              GFP_KERNEL);<br>
              +=C2=A0 =C2=A0 =C2=A0 =C2=A0if (!fences) {<br>
              +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ret =
=3D -ENOMEM;<br>
              +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0goto =
err_free_handles;<br>
              +=C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
              +<br>
              +=C2=A0 =C2=A0 =C2=A0 =C2=A0for (i =3D 0; i &lt; args-&gt;cou=
nt_handles; i++) {<br>
              +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ret =
=3D drm_syncobj_fence_get(file_pri<wbr>vate,
              handles[i],<br>
              +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0
              =C2=A0&amp;fences[i]);<br>
              +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (r=
et)<br>
              +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0goto err_free_fence_array;<br>
              +=C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
              +<br>
              +=C2=A0 =C2=A0 =C2=A0 =C2=A0ret =3D drm_syncobj_wait_fences(d=
ev, file_private,<br>
              +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ar=
gs, fences);<br>
            </blockquote>
            <div><br>
            </div>
            <div>So, reading some CTS tests again, and I think we have a
              problem here.=C2=A0 The Vulkan spec allows you to wait on a
              fence that is in the unsignaled state.</div>
          </div>
        </div>
      </div>
    </blockquote>
    <br></div></div>
    At least on the closed source driver that would be illegal as far as
    I know.<br></div></blockquote><div><br></div><div>Then they are doing w=
orkarounds in userspace.=C2=A0 There are definitely CTS tests for this:<br>=
<br><a href=3D"https://github.com/KhronosGroup/VK-GL-CTS/blob/master/extern=
al/vulkancts/modules/vulkan/synchronization/vktSynchronizationBasicFenceTes=
ts.cpp#L74">https://github.com/KhronosGroup/VK-GL-CTS/blob/master/external/=
vulkancts/modules/vulkan/synchronization/vktSynchronizationBasicFenceTests.=
cpp#L74</a><br></div><div>=C2=A0</div><blockquote class=3D"gmail_quote" sty=
le=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);paddi=
ng-left:1ex"><div>
    You can&#39;t wait on a semaphore before the signal operation is send
    down to the kerel.</div></blockquote><div><br></div><div>We (Intel) dea=
l with this today by tracking whether or not the fence has been submitted a=
nd using a condition variable in userspace to sort it all out.=C2=A0 If we =
ever want to share fences across processes (which we do), then this needs t=
o be sorted in the kernel. <br><br></div><div>--Jason<br></div><div><br></d=
iv><div>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0=
px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex"><div =
bgcolor=3D"#FFFFFF">
    Regards,<br>
    Christian.<div><div class=3D"gmail-h5"><br>
    <br>
    <blockquote type=3D"cite">
      <div dir=3D"ltr">
        <div class=3D"gmail_extra">
          <div class=3D"gmail_quote">
            <div>=C2=A0 In theory, you could have thread A start waiting on=
 a
              fence before thread B submits the work which triggers that
              fence.=C2=A0 This means that the dma_fence may not exist yet
              when vkWaitForFences gets called.=C2=A0 If we really want to
              support the full Vulkan usage, we need to somehow support
              missing dma_fences by waiting for the dma_fence to show
              up.=C2=A0 Unfortunately, I don&#39;t know enough about the in=
ternal
              kernel APIs to know what that would look like.<br>
            </div>
          </div>
        </div>
      </div>
    </blockquote>
    </div></div><blockquote type=3D"cite"><div><div class=3D"gmail-h5">
      <div dir=3D"ltr">
        <div class=3D"gmail_extra">
          <div class=3D"gmail_quote">
            <div>=C2=A0</div>
            <blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0=
.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
              +<br>
              +err_free_fence_array:<br>
              +=C2=A0 =C2=A0 =C2=A0 =C2=A0for (i =3D 0; i &lt; args-&gt;cou=
nt_handles; i++)<br>
              +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0dma_f=
ence_put(fences[i]);<br>
              +=C2=A0 =C2=A0 =C2=A0 =C2=A0kfree(fences);<br>
              +err_free_handles:<br>
              +=C2=A0 =C2=A0 =C2=A0 =C2=A0kfree(handles);<br>
              +<br>
              +=C2=A0 =C2=A0 =C2=A0 =C2=A0return ret;<br>
              +}<br>
              diff --git a/include/uapi/drm/drm.h
              b/include/uapi/drm/drm.h<br>
              index 101593a..91746a7 100644<br>
              --- a/include/uapi/drm/drm.h<br>
              +++ b/include/uapi/drm/drm.h<br>
              @@ -718,6 +718,18 @@ struct drm_syncobj_handle {<br>
              =C2=A0 =C2=A0 =C2=A0 =C2=A0 __u32 pad;<br>
              =C2=A0};<br>
              <br>
              +#define DRM_SYNCOBJ_WAIT_FLAGS_WAIT_AL<wbr>L (1 &lt;&lt;
              0)<br>
              +struct drm_syncobj_wait {<br>
              +=C2=A0 =C2=A0 =C2=A0 =C2=A0__u64 handles;<br>
              +=C2=A0 =C2=A0 =C2=A0 =C2=A0/* absolute timeout */<br>
              +=C2=A0 =C2=A0 =C2=A0 =C2=A0__s64 timeout_sec;<br>
              +=C2=A0 =C2=A0 =C2=A0 =C2=A0__s64 timeout_nsec;<br>
              +=C2=A0 =C2=A0 =C2=A0 =C2=A0__u32 count_handles;<br>
              +=C2=A0 =C2=A0 =C2=A0 =C2=A0__u32 flags;<br>
              +=C2=A0 =C2=A0 =C2=A0 =C2=A0__u32 first_signaled; /* only val=
id when not
              waiting all */<br>
              +=C2=A0 =C2=A0 =C2=A0 =C2=A0__u32 pad;<br>
              +};<br>
              +<br>
              =C2=A0#if defined(__cplusplus)<br>
              =C2=A0}<br>
              =C2=A0#endif<br>
              @@ -840,6 +852,7 @@ extern &quot;C&quot; {<br>
              =C2=A0#define DRM_IOCTL_SYNCOBJ_DESTROY=C2=A0 =C2=A0 =C2=A0 D=
RM_IOWR(0xC0,
              struct drm_syncobj_destroy)<br>
              =C2=A0#define DRM_IOCTL_SYNCOBJ_HANDLE_TO_FD DRM_IOWR(0xC1,
              struct drm_syncobj_handle)<br>
              =C2=A0#define DRM_IOCTL_SYNCOBJ_FD_TO_HANDLE DRM_IOWR(0xC2,
              struct drm_syncobj_handle)<br>
              +#define DRM_IOCTL_SYNCOBJ_WAIT=C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0DRM_IOWR(0xC3,
              struct drm_syncobj_wait)<br>
              <br>
              =C2=A0/**<br>
              =C2=A0 * Device specific ioctls should only be in their
              respective headers<br>
              <span class=3D"gmail-m_-226855681158848481HOEnZb"><font color=
=3D"#888888">--<br>
                  2.9.4<br>
                  <br>
                  ______________________________<wbr>_________________<br>
                  dri-devel mailing list<br>
                  <a href=3D"mailto:dri-devel@lists.freedesktop.org" target=
=3D"_blank">dri-devel@lists.freedesktop.or<wbr>g</a><br>
                  <a href=3D"https://lists.freedesktop.org/mailman/listinfo=
/dri-devel" rel=3D"noreferrer" target=3D"_blank">https://lists.freedesktop.=
org/<wbr>mailman/listinfo/dri-devel</a><br>
                </font></span></blockquote>
          </div>
          <br>
        </div>
      </div>
      <br>
      <fieldset class=3D"gmail-m_-226855681158848481mimeAttachmentHeader"><=
/fieldset>
      <br>
      </div></div><pre>______________________________<wbr>_________________
amd-gfx mailing list
<a class=3D"gmail-m_-226855681158848481moz-txt-link-abbreviated" href=3D"ma=
ilto:amd-gfx@lists.freedesktop.org" target=3D"_blank">amd-gfx@lists.freedes=
ktop.org</a>
<a class=3D"gmail-m_-226855681158848481moz-txt-link-freetext" href=3D"https=
://lists.freedesktop.org/mailman/listinfo/amd-gfx" target=3D"_blank">https:=
//lists.freedesktop.org/<wbr>mailman/listinfo/amd-gfx</a>
</pre>
    </blockquote>
    <p><br>
    </p>
  </div>

</blockquote></div><br></div></div>

--94eb2c0df1800ca98e0553f89348--

--===============1346467712==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KZHJpLWRldmVs
IG1haWxpbmcgbGlzdApkcmktZGV2ZWxAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlz
dHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vZHJpLWRldmVsCg==

--===============1346467712==--
