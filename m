From: Jason Ekstrand <jason-fQELhIk9awXprZlt/sZkLg@public.gmane.org>
Subject: Re: [PATCH] drm/syncobj: add sync obj wait interface. (v6)
Date: Mon, 10 Jul 2017 16:15:00 -0700
Message-ID: <CAOFGe97qsu8wNUF8rZRHHdk=6Ptxw56faNDzW9=JvG4OP=xizA@mail.gmail.com>
References: <20170706010409.9373-1-airlied@gmail.com>
 <CAOFGe94mA9i7+-XTJQn65N-vK_GbQwvjru2b=6ucXejpWWmx4g@mail.gmail.com>
 <899f9bb3-f7c7-ce86-c22b-bb8d262778bf@vodafone.de>
 <CAOFGe96gaX2OjsXr8bNBUiqwyKAQfMSycH7PXgYAt_BBJ1UHkQ@mail.gmail.com>
 <DM5PR12MB12574F31128759A47DA1C7B7F2A90@DM5PR12MB1257.namprd12.prod.outlook.com>
 <60c420a9-eab6-a9e0-0306-893053d82a5d@vodafone.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1271204298=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <60c420a9-eab6-a9e0-0306-893053d82a5d-ANTagKRnAhcb1SvskN2V4Q@public.gmane.org>
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
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <deathsimple-ANTagKRnAhcb1SvskN2V4Q@public.gmane.org>
Cc: Dave Airlie <airlied-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, amd-gfx mailing list <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, Maling list - DRI developers <dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, "Xie,
 AlexBin" <AlexBin.Xie-5C7GfCeVMHo@public.gmane.org>

--===============1271204298==
Content-Type: multipart/alternative; boundary="001a114448189349430553fec09e"

--001a114448189349430553fec09e
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 10, 2017 at 9:13 AM, Christian K=C3=B6nig <deathsimple@vodafone=
.de>
wrote:

> Am 10.07.2017 um 17:58 schrieb Xie, AlexBin:
>
> I understand this discussion from closes source driver terminology.
>
>
>
> If a process is killed before it sends out the signaling command, will
> some part of the GPU be in a waiting situation forever?
>
>
> Yes, exactly that's the problem here and the reason why that even
> Microsoft forbids that under windows.
>

To be clear, we are only discussing wait-before-submit for client CPU
waits.  The GPU will not be waiting, only some userspace process.  If that
process is a compositor, it should take measures to avoid getting hung up
by bad clients.  What this will *not* cause is the GPU (or kernel GPU
scheduling) to get hung up on waiting for some unsubmitted thing.


> Christian.
>
>
>
>
> Alex Bin Xie
>
> *From:* amd-gfx [mailto:amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
> <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>] *On Behalf Of *Jason Ekstrand
> *Sent:* Monday, July 10, 2017 11:53 AM
> *To:* Christian K=C3=B6nig <deathsimple-ANTagKRnAhcb1SvskN2V4Q@public.gmane.org> <deathsimple@vodafon=
e.de>
> *Cc:* Dave Airlie <airlied-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> <airlied-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>; Maling list -
> DRI developers <dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
> <dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>; amd-gfx mailing list
> <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org> <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
> *Subject:* Re: [PATCH] drm/syncobj: add sync obj wait interface. (v6)
>
>
>
> On Mon, Jul 10, 2017 at 8:45 AM, Christian K=C3=B6nig <deathsimple@vodafo=
ne.de>
> wrote:
>
> Am 10.07.2017 um 17:28 schrieb Jason Ekstrand:
>
> On Wed, Jul 5, 2017 at 6:04 PM, Dave Airlie <airlied-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:
>
> From: Dave Airlie <airlied-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
>
> This interface will allow sync object to be used to back
> Vulkan fences. This API is pretty much the vulkan fence waiting
> API, and I've ported the code from amdgpu.
>
> v2: accept relative timeout, pass remaining time back
> to userspace.
> v3: return to absolute timeouts.
> v4: absolute zero =3D poll,
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
> @@ -657,6 +657,8 @@ static const struct drm_ioctl_desc drm_ioctls[] =3D {
>                       DRM_UNLOCKED|DRM_RENDER_ALLOW),
>         DRM_IOCTL_DEF(DRM_IOCTL_SYNCOBJ_FD_TO_HANDLE,
> drm_syncobj_fd_to_handle_ioctl,
>                       DRM_UNLOCKED|DRM_RENDER_ALLOW),
> +       DRM_IOCTL_DEF(DRM_IOCTL_SYNCOBJ_WAIT, drm_syncobj_wait_ioctl,
> +                     DRM_UNLOCKED|DRM_RENDER_ALLOW),
>  };
>
>  #define DRM_CORE_IOCTL_COUNT   ARRAY_SIZE( drm_ioctls )
> diff --git a/drivers/gpu/drm/drm_syncobj.c b/drivers/gpu/drm/drm_syncobj.=
c
> index 89441bc..2d5a7a1 100644
> --- a/drivers/gpu/drm/drm_syncobj.c
> +++ b/drivers/gpu/drm/drm_syncobj.c
> @@ -1,5 +1,7 @@
>  /*
>   * Copyright 2017 Red Hat
> + * Parts ported from amdgpu (fence wait code).
> + * Copyright 2016 Advanced Micro Devices, Inc.
>   *
>   * Permission is hereby granted, free of charge, to any person obtaining=
 a
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
> +       if (timeout_sec =3D=3D 0 && timeout_nsec =3D=3D 0)
> +               return 0;
> +
> +       abs_timeout.tv_sec =3D timeout_sec;
> +       abs_timeout.tv_nsec =3D timeout_nsec;
> +
> +       /* clamp timeout if it's to large */
> +       if (!timespec64_valid_strict(&abs_timeout))
> +               return MAX_SCHEDULE_TIMEOUT - 1;
> +
> +       timeout =3D timespec64_sub(abs_timeout,
> ktime_to_timespec64(ktime_get()));
> +       if (!timespec64_valid(&timeout))
> +               return 0;
> +
> +       jiffies_to_timespec64(MAX_JIFFY_OFFSET, &max_jiffy_timespec);
> +       if (timespec64_compare(&timeout, &max_jiffy_timespec) >=3D 0)
> +               return MAX_SCHEDULE_TIMEOUT - 1;
> +
> +       timeout_jiffies =3D timespec64_to_jiffies(&timeout);
> +       /*  clamp timeout to avoid infinite timeout */
> +       if (timeout_jiffies >=3D MAX_SCHEDULE_TIMEOUT)
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
> +       unsigned long timeout =3D drm_timeout_abs_to_jiffies(wait->timeou=
t_sec,
> wait->timeout_nsec);
> +       int ret =3D 0;
> +       uint32_t first =3D ~0;
> +
> +       if (wait->flags & DRM_SYNCOBJ_WAIT_FLAGS_WAIT_ALL) {
> +               int i;
> +               for (i =3D 0; i < wait->count_handles; i++) {
> +                       ret =3D dma_fence_wait_timeout(fences[i], true,
> timeout);
> +
> +                       if (ret < 0)
> +                               return ret;
> +                       if (ret =3D=3D 0)
> +                               break;
> +                       timeout =3D ret;
> +               }
> +               first =3D 0;
> +       } else {
> +               ret =3D dma_fence_wait_any_timeout(fences,
> +                                                wait->count_handles,
> +                                                true, timeout,
> +                                                &first);
> +       }
> +
> +       if (ret < 0)
> +               return ret;
> +
> +       wait->first_signaled =3D first;
> +       if (ret =3D=3D 0)
> +               return -ETIME;
> +       return 0;
> +}
> +
> +int
> +drm_syncobj_wait_ioctl(struct drm_device *dev, void *data,
> +                      struct drm_file *file_private)
> +{
> +       struct drm_syncobj_wait *args =3D data;
> +       uint32_t *handles;
> +       struct dma_fence **fences;
> +       int ret =3D 0;
> +       int i;
> +
> +       if (!drm_core_check_feature(dev, DRIVER_SYNCOBJ))
> +               return -ENODEV;
> +
> +       if (args->flags !=3D 0 && args->flags !=3D DRM_SYNCOBJ_WAIT_FLAGS=
_WAIT_
> ALL)
> +               return -EINVAL;
> +
> +       if (args->count_handles =3D=3D 0)
> +               return -EINVAL;
> +
> +       /* Get the handles from userspace */
> +       handles =3D kmalloc_array(args->count_handles, sizeof(uint32_t),
> +                               GFP_KERNEL);
> +       if (handles =3D=3D NULL)
> +               return -ENOMEM;
> +
> +       if (copy_from_user(handles,
> +                          u64_to_user_ptr(args->handles),
> +                          sizeof(uint32_t) * args->count_handles)) {
> +               ret =3D -EFAULT;
> +               goto err_free_handles;
> +       }
> +
> +       fences =3D kcalloc(args->count_handles,
> +                        sizeof(struct dma_fence *), GFP_KERNEL);
> +       if (!fences) {
> +               ret =3D -ENOMEM;
> +               goto err_free_handles;
> +       }
> +
> +       for (i =3D 0; i < args->count_handles; i++) {
> +               ret =3D drm_syncobj_fence_get(file_private, handles[i],
> +                                           &fences[i]);
> +               if (ret)
> +                       goto err_free_fence_array;
> +       }
> +
> +       ret =3D drm_syncobj_wait_fences(dev, file_private,
> +                                     args, fences);
>
>
>
> So, reading some CTS tests again, and I think we have a problem here.  Th=
e
> Vulkan spec allows you to wait on a fence that is in the unsignaled state=
.
>
>
>
> At least on the closed source driver that would be illegal as far as I
> know.
>
>
>
> Then they are doing workarounds in userspace.  There are definitely CTS
> tests for this:
>
> https://github.com/KhronosGroup/VK-GL-CTS/blob/master/external/vulkancts/
> modules/vulkan/synchronization/vktSynchronizationBasicFenceTests.cpp#L74
>
>
>
> You can't wait on a semaphore before the signal operation is send down to
> the kerel.
>
>
>
> We (Intel) deal with this today by tracking whether or not the fence has
> been submitted and using a condition variable in userspace to sort it all
> out.  If we ever want to share fences across processes (which we do), the=
n
> this needs to be sorted in the kernel.
>
> --Jason
>
>
>
>
>
> Regards,
> Christian.
>
>
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
> +
> +err_free_fence_array:
> +       for (i =3D 0; i < args->count_handles; i++)
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
>
>
>
>
> _______________________________________________
>
> amd-gfx mailing list
>
> amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
>
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
>
>
>
>
>
>
>

--001a114448189349430553fec09e
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_extra"><div class=3D"gmail_quote">On M=
on, Jul 10, 2017 at 9:13 AM, Christian K=C3=B6nig <span dir=3D"ltr">&lt;<a =
href=3D"mailto:deathsimple-ANTagKRnAhcb1SvskN2V4Q@public.gmane.org" target=3D"_blank">deathsimple@vodaf=
one.de</a>&gt;</span> wrote:<br><blockquote class=3D"gmail_quote" style=3D"=
margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">
 =20
   =20
 =20
  <div text=3D"#000000" bgcolor=3D"#FFFFFF"><span class=3D"">
    <div class=3D"m_3510272536457704976moz-cite-prefix">Am 10.07.2017 um 17=
:58 schrieb Xie,
      AlexBin:<br>
    </div>
    <blockquote type=3D"cite">
     =20
     =20
     =20
      <div class=3D"m_3510272536457704976WordSection1">
        <p class=3D"MsoNormal"><a name=3D"m_3510272536457704976__MailEndCom=
pose"><span style=3D"font-size:11.0pt;font-family:&quot;Calibri&quot;,sans-=
serif;color:#1f497d">I
              understand this discussion from closes source driver
              terminology.<u></u><u></u></span></a></p>
        <p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:=
&quot;Calibri&quot;,sans-serif;color:#1f497d"><u></u>=C2=A0<u></u></span></=
p>
        <p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:=
&quot;Calibri&quot;,sans-serif;color:#1f497d">If
            a process is killed before it sends out the signaling
            command, will some part of the GPU be in a waiting situation
            forever?</span></p>
      </div>
    </blockquote>
    <br></span>
    Yes, exactly that&#39;s the problem here and the reason why that even
    Microsoft forbids that under windows.<span class=3D"HOEnZb"><font color=
=3D"#888888"><br></font></span></div></blockquote><div><br></div><div>To be=
 clear, we are only discussing wait-before-submit for client CPU waits.=C2=
=A0 The GPU will not be waiting, only some userspace process.=C2=A0 If that=
 process is a compositor, it should take measures to avoid getting hung up =
by bad clients.=C2=A0 What this will *not* cause is the GPU (or kernel GPU =
scheduling) to get hung up on waiting for some unsubmitted thing.<br></div>=
<div>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8=
ex;border-left:1px #ccc solid;padding-left:1ex"><div text=3D"#000000" bgcol=
or=3D"#FFFFFF"><span class=3D"HOEnZb"><font color=3D"#888888">
    Christian.</font></span><div><div class=3D"h5"><br>
    <br>
    <blockquote type=3D"cite">
      <div class=3D"m_3510272536457704976WordSection1">
        <p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:=
&quot;Calibri&quot;,sans-serif;color:#1f497d"><u></u><u></u></span></p>
        <p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:=
&quot;Calibri&quot;,sans-serif;color:#1f497d"><u></u>=C2=A0<u></u></span></=
p>
        <p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:=
&quot;Calibri&quot;,sans-serif;color:#1f497d">Alex
            Bin Xie<u></u><u></u></span></p>
        <p class=3D"MsoNormal"><b><span style=3D"font-size:11.0pt;font-fami=
ly:&quot;Calibri&quot;,sans-serif">From:</span></b><span style=3D"font-size=
:11.0pt;font-family:&quot;Calibri&quot;,sans-serif">
            amd-gfx [<a class=3D"m_3510272536457704976moz-txt-link-freetext=
" href=3D"mailto:amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" target=3D"_blank">m=
ailto:amd-gfx-bounces@lists.<wbr>freedesktop.org</a>]
            <b>On Behalf Of </b>Jason Ekstrand<br>
            <b>Sent:</b> Monday, July 10, 2017 11:53 AM<br>
            <b>To:</b> Christian K=C3=B6nig <a class=3D"m_35102725364577049=
76moz-txt-link-rfc2396E" href=3D"mailto:deathsimple-ANTagKRnAhcb1SvskN2V4Q@public.gmane.org" target=3D"=
_blank">&lt;deathsimple-ANTagKRnAhcb1SvskN2V4Q@public.gmane.org&gt;</a><br>
            <b>Cc:</b> Dave Airlie <a class=3D"m_3510272536457704976moz-txt=
-link-rfc2396E" href=3D"mailto:airlied-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org" target=3D"_blank">&lt;air=
lied-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org&gt;</a>; Maling
            list - DRI developers
            <a class=3D"m_3510272536457704976moz-txt-link-rfc2396E" href=3D=
"mailto:dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" target=3D"_blank">&lt;dri-devel@li=
sts.freedesktop.<wbr>org&gt;</a>; amd-gfx mailing
            list <a class=3D"m_3510272536457704976moz-txt-link-rfc2396E" hr=
ef=3D"mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" target=3D"_blank">&lt;amd-gfx@l=
ists.freedesktop.<wbr>org&gt;</a><br>
            <b>Subject:</b> Re: [PATCH] drm/syncobj: add sync obj wait
            interface. (v6)<u></u><u></u></span></p>
        <p class=3D"MsoNormal"><u></u>=C2=A0<u></u></p>
        <div>
          <div>
            <div>
              <p class=3D"MsoNormal">On Mon, Jul 10, 2017 at 8:45 AM,
                Christian K=C3=B6nig &lt;<a href=3D"mailto:deathsimple@voda=
fone.de" target=3D"_blank">deathsimple-ANTagKRnAhcb1SvskN2V4Q@public.gmane.org</a>&gt;
                wrote:<u></u><u></u></p>
              <blockquote style=3D"border:none;border-left:solid #cccccc 1.=
0pt;padding:0in 0in 0in 6.0pt;margin-left:4.8pt;margin-right:0in">
                <div>
                  <div>
                    <div>
                      <div>
                        <p class=3D"MsoNormal">Am 10.07.2017 um 17:28
                          schrieb Jason Ekstrand:<u></u><u></u></p>
                      </div>
                      <blockquote style=3D"margin-top:5.0pt;margin-bottom:5=
.0pt">
                        <div>
                          <div>
                            <div>
                              <p class=3D"MsoNormal">On Wed, Jul 5, 2017
                                at 6:04 PM, Dave Airlie &lt;<a href=3D"mail=
to:airlied-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org" target=3D"_blank">airlied-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org</a>&gt;
                                wrote:<u></u><u></u></p>
                              <blockquote style=3D"border:none;border-left:=
solid #cccccc 1.0pt;padding:0in 0in 0in 6.0pt;margin-left:4.8pt;margin-righ=
t:0in">
                                <p class=3D"MsoNormal">From: Dave Airlie
                                  &lt;<a href=3D"mailto:airlied-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org"=
 target=3D"_blank">airlied-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org</a>&gt;<br>
                                  <br>
                                  This interface will allow sync object
                                  to be used to back<br>
                                  Vulkan fences. This API is pretty much
                                  the vulkan fence waiting<br>
                                  API, and I&#39;ve ported the code from
                                  amdgpu.<br>
                                  <br>
                                  v2: accept relative timeout, pass
                                  remaining time back<br>
                                  to userspace.<br>
                                  v3: return to absolute timeouts.<br>
                                  v4: absolute zero =3D poll,<br>
                                  =C2=A0 =C2=A0 rewrite any/all code to hav=
e same
                                  operation for arrays<br>
                                  =C2=A0 =C2=A0 return -EINVAL for 0 fences=
.<br>
                                  v4.1: fixup fences allocation check,
                                  use u64_to_user_ptr<br>
                                  v5: move to sec/nsec, and use
                                  timespec64 for calcs.<br>
                                  v6: use -ETIME and drop the out status
                                  flag. (-ETIME<br>
                                  is suggested by ickle, I can feel a
                                  shed painting)<br>
                                  <br>
                                  Signed-off-by: Dave Airlie &lt;<a href=3D=
"mailto:airlied-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org" target=3D"_blank">airlied-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org</a>&gt;<br=
>
                                  ---<br>
                                  =C2=A0drivers/gpu/drm/drm_internal.<wbr>h=
 |=C2=A0 =C2=A02
                                  +<br>
                                  =C2=A0drivers/gpu/drm/drm_ioctl.c=C2=A0 =
=C2=A0 |=C2=A0 =C2=A02
                                  +<br>
                                  =C2=A0drivers/gpu/drm/drm_syncobj.<wbr>c=
=C2=A0 | 142
++++++++++++++++++++++++++++++<wbr>+++++++++++<br>
                                  =C2=A0include/uapi/drm/drm.h=C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0|=C2=A0 13
                                  ++++<br>
                                  =C2=A04 files changed, 159 insertions(+)<=
br>
                                  <br>
                                  diff --git
                                  a/drivers/gpu/drm/drm_<wbr>internal.h
                                  b/drivers/gpu/drm/drm_<wbr>internal.h<br>
                                  index 5cecc97..d71b50d 100644<br>
                                  --- a/drivers/gpu/drm/drm_<wbr>internal.h=
<br>
                                  +++ b/drivers/gpu/drm/drm_<wbr>internal.h=
<br>
                                  @@ -157,3 +157,5 @@ int
                                  drm_syncobj_handle_to_fd_<wbr>ioctl(struc=
t
                                  drm_device *dev, void *data,<br>
                                  =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0
                                  =C2=A0struct drm_file *file_private);<br>
                                  =C2=A0int
                                  drm_syncobj_fd_to_handle_<wbr>ioctl(struc=
t
                                  drm_device *dev, void *data,<br>
                                  =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0
                                  =C2=A0struct drm_file *file_private);<br>
                                  +int drm_syncobj_wait_ioctl(struct
                                  drm_device *dev, void *data,<br>
                                  +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 struct
                                  drm_file *file_private);<br>
                                  diff --git
                                  a/drivers/gpu/drm/drm_ioctl.c
                                  b/drivers/gpu/drm/drm_ioctl.c<br>
                                  index f1e5681..385ce74 100644<br>
                                  --- a/drivers/gpu/drm/drm_ioctl.c<br>
                                  +++ b/drivers/gpu/drm/drm_ioctl.c<br>
                                  @@ -657,6 +657,8 @@ static const
                                  struct drm_ioctl_desc drm_ioctls[] =3D {<=
br>
                                  =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0
                                  DRM_UNLOCKED|DRM_RENDER_ALLOW)<wbr>,<br>
                                  =C2=A0 =C2=A0 =C2=A0 =C2=A0
                                  DRM_IOCTL_DEF(DRM_IOCTL_<wbr>SYNCOBJ_FD_T=
O_HANDLE,
                                  drm_syncobj_fd_to_handle_<wbr>ioctl,<br>
                                  =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0
                                  DRM_UNLOCKED|DRM_RENDER_ALLOW)<wbr>,<br>
                                  +=C2=A0 =C2=A0 =C2=A0
                                  =C2=A0DRM_IOCTL_DEF(DRM_IOCTL_<wbr>SYNCOB=
J_WAIT,
                                  drm_syncobj_wait_ioctl,<br>
                                  +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0
                                  =C2=A0DRM_UNLOCKED|DRM_RENDER_<wbr>ALLOW)=
,<br>
                                  =C2=A0};<br>
                                  <br>
                                  =C2=A0#define DRM_CORE_IOCTL_COUNT=C2=A0
                                  =C2=A0ARRAY_SIZE( drm_ioctls )<br>
                                  diff --git
                                  a/drivers/gpu/drm/drm_syncobj.<wbr>c
                                  b/drivers/gpu/drm/drm_syncobj.<wbr>c<br>
                                  index 89441bc..2d5a7a1 100644<br>
                                  --- a/drivers/gpu/drm/drm_syncobj.<wbr>c<=
br>
                                  +++ b/drivers/gpu/drm/drm_syncobj.<wbr>c<=
br>
                                  @@ -1,5 +1,7 @@<br>
                                  =C2=A0/*<br>
                                  =C2=A0 * Copyright 2017 Red Hat<br>
                                  + * Parts ported from amdgpu (fence
                                  wait code).<br>
                                  + * Copyright 2016 Advanced Micro
                                  Devices, Inc.<br>
                                  =C2=A0 *<br>
                                  =C2=A0 * Permission is hereby granted, fr=
ee
                                  of charge, to any person obtaining a<br>
                                  =C2=A0 * copy of this software and
                                  associated documentation files (the
                                  &quot;Software&quot;),<br>
                                  @@ -31,6 +33,9 @@<br>
                                  =C2=A0 * that contain an optional fence.
                                  The fence can be updated with a new<br>
                                  =C2=A0 * fence, or be NULL.<br>
                                  =C2=A0 *<br>
                                  + * syncobj&#39;s can be waited upon,
                                  where it will wait for the underlying<br>
                                  + * fence.<br>
                                  + *<br>
                                  =C2=A0 * syncobj&#39;s can be export to f=
d&#39;s
                                  and back, these fd&#39;s are opaque and<b=
r>
                                  =C2=A0 * have no other use case, except
                                  passing the syncobj between processes.<br=
>
                                  =C2=A0 *<br>
                                  @@ -451,3 +456,140 @@
                                  drm_syncobj_fd_to_handle_<wbr>ioctl(struc=
t
                                  drm_device *dev, void *data,<br>
                                  =C2=A0 =C2=A0 =C2=A0 =C2=A0 return
                                  drm_syncobj_fd_to_handle(file_<wbr>privat=
e,
                                  args-&gt;fd,<br>
                                  =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0
                                  =C2=A0 &amp;args-&gt;handle);<br>
                                  =C2=A0}<br>
                                  +<br>
                                  +/**<br>
                                  + * drm_timeout_abs_to_jiffies -
                                  calculate jiffies timeout from
                                  absolute value<br>
                                  + *<br>
                                  + * @timeout_sec: timeout sec
                                  component, 0 for poll<br>
                                  + * @timeout_nsec: timeout nsec
                                  component in ns, 0 for poll<br>
                                  + * both must be 0 for poll.<br>
                                  + *<br>
                                  + * Calculate the timeout in jiffies
                                  from an absolute time in sec/nsec.<br>
                                  + */<br>
                                  +static unsigned long
                                  drm_timeout_abs_to_jiffies(<wbr>int64_t
                                  timeout_sec, uint64_t timeout_nsec)<br>
                                  +{<br>
                                  +=C2=A0 =C2=A0 =C2=A0 =C2=A0struct timesp=
ec64 abs_timeout,
                                  timeout, max_jiffy_timespec;<br>
                                  +=C2=A0 =C2=A0 =C2=A0 =C2=A0unsigned long=
 timeout_jiffies;<br>
                                  +<br>
                                  +=C2=A0 =C2=A0 =C2=A0 =C2=A0/* make 0 tim=
eout means poll -
                                  absolute 0 doesn&#39;t seem valid */<br>
                                  +=C2=A0 =C2=A0 =C2=A0 =C2=A0if (timeout_s=
ec =3D=3D 0
                                  &amp;&amp; timeout_nsec =3D=3D 0)<br>
                                  +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0return 0;<br>
                                  +<br>
                                  +=C2=A0 =C2=A0 =C2=A0 =C2=A0abs_timeout.t=
v_sec =3D
                                  timeout_sec;<br>
                                  +=C2=A0 =C2=A0 =C2=A0 =C2=A0abs_timeout.t=
v_nsec =3D
                                  timeout_nsec;<br>
                                  +<br>
                                  +=C2=A0 =C2=A0 =C2=A0 =C2=A0/* clamp time=
out if it&#39;s to
                                  large */<br>
                                  +=C2=A0 =C2=A0 =C2=A0 =C2=A0if
                                  (!timespec64_valid_strict(&amp;<wbr>abs_t=
imeout))<br>
                                  +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0return
                                  MAX_SCHEDULE_TIMEOUT - 1;<br>
                                  +<br>
                                  +=C2=A0 =C2=A0 =C2=A0 =C2=A0timeout =3D
                                  timespec64_sub(abs_timeout,
                                  ktime_to_timespec64(ktime_get(<wbr>)));<b=
r>
                                  +=C2=A0 =C2=A0 =C2=A0 =C2=A0if
                                  (!timespec64_valid(&amp;timeout))<br>
                                  +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0return 0;<br>
                                  +<br>
                                  +=C2=A0 =C2=A0 =C2=A0
                                  =C2=A0jiffies_to_timespec64(MAX_<wbr>JIFF=
Y_OFFSET,
                                  &amp;max_jiffy_timespec);<br>
                                  +=C2=A0 =C2=A0 =C2=A0 =C2=A0if
                                  (timespec64_compare(&amp;timeout,
                                  &amp;max_jiffy_timespec) &gt;=3D 0)<br>
                                  +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0return
                                  MAX_SCHEDULE_TIMEOUT - 1;<br>
                                  +<br>
                                  +=C2=A0 =C2=A0 =C2=A0 =C2=A0timeout_jiffi=
es =3D
                                  timespec64_to_jiffies(&amp;<wbr>timeout);=
<br>
                                  +=C2=A0 =C2=A0 =C2=A0 =C2=A0/*=C2=A0 clam=
p timeout to avoid
                                  infinite timeout */<br>
                                  +=C2=A0 =C2=A0 =C2=A0 =C2=A0if (timeout_j=
iffies &gt;=3D
                                  MAX_SCHEDULE_TIMEOUT)<br>
                                  +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0return
                                  MAX_SCHEDULE_TIMEOUT - 1;<br>
                                  +<br>
                                  +=C2=A0 =C2=A0 =C2=A0 =C2=A0return timeou=
t_jiffies + 1;<br>
                                  +}<br>
                                  +<br>
                                  +static int
                                  drm_syncobj_wait_fences(struct
                                  drm_device *dev,<br>
                                  +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0
                                  struct drm_file *file_private,<br>
                                  +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0
                                  struct drm_syncobj_wait *wait,<br>
                                  +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0
                                  struct dma_fence **fences)<br>
                                  +{<br>
                                  +=C2=A0 =C2=A0 =C2=A0 =C2=A0unsigned long=
 timeout =3D
                                  drm_timeout_abs_to_jiffies(<wbr>wait-&gt;=
timeout_sec,
                                  wait-&gt;timeout_nsec);<br>
                                  +=C2=A0 =C2=A0 =C2=A0 =C2=A0int ret =3D 0=
;<br>
                                  +=C2=A0 =C2=A0 =C2=A0 =C2=A0uint32_t firs=
t =3D ~0;<br>
                                  +<br>
                                  +=C2=A0 =C2=A0 =C2=A0 =C2=A0if (wait-&gt;=
flags &amp;
                                  DRM_SYNCOBJ_WAIT_FLAGS_WAIT_<wbr>ALL) {<b=
r>
                                  +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0int i;<br>
                                  +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0for (i =3D 0; i &lt;
                                  wait-&gt;count_handles; i++) {<br>
                                  +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ret =3D
                                  dma_fence_wait_timeout(fences[<wbr>i],
                                  true, timeout);<br>
                                  +<br>
                                  +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (ret &lt;
                                  0)<br>
                                  +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0re=
turn
                                  ret;<br>
                                  +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (ret =3D=3D 0)<br>
                                  +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0br=
eak;<br>
                                  +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0timeout =3D ret;<br>
                                  +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0}<br>
                                  +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0first =3D 0;<br>
                                  +=C2=A0 =C2=A0 =C2=A0 =C2=A0} else {<br>
                                  +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0ret =3D
                                  dma_fence_wait_any_timeout(<wbr>fences,<b=
r>
                                  +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0
                                  =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 wait-&=
gt;count_handles,<br>
                                  +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0
                                  =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 true, =
timeout,<br>
                                  +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0
                                  =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &amp;f=
irst);<br>
                                  +=C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
                                  +<br>
                                  +=C2=A0 =C2=A0 =C2=A0 =C2=A0if (ret &lt; =
0)<br>
                                  +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0return ret;<br>
                                  +<br>
                                  +=C2=A0 =C2=A0 =C2=A0 =C2=A0wait-&gt;firs=
t_signaled =3D
                                  first;<br>
                                  +=C2=A0 =C2=A0 =C2=A0 =C2=A0if (ret =3D=
=3D 0)<br>
                                  +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0return -ETIME;<br>
                                  +=C2=A0 =C2=A0 =C2=A0 =C2=A0return 0;<br>
                                  +}<br>
                                  +<br>
                                  +int<br>
                                  +drm_syncobj_wait_ioctl(struct
                                  drm_device *dev, void *data,<br>
                                  +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 struct drm_file
                                  *file_private)<br>
                                  +{<br>
                                  +=C2=A0 =C2=A0 =C2=A0 =C2=A0struct drm_sy=
ncobj_wait *args
                                  =3D data;<br>
                                  +=C2=A0 =C2=A0 =C2=A0 =C2=A0uint32_t *han=
dles;<br>
                                  +=C2=A0 =C2=A0 =C2=A0 =C2=A0struct dma_fe=
nce **fences;<br>
                                  +=C2=A0 =C2=A0 =C2=A0 =C2=A0int ret =3D 0=
;<br>
                                  +=C2=A0 =C2=A0 =C2=A0 =C2=A0int i;<br>
                                  +<br>
                                  +=C2=A0 =C2=A0 =C2=A0 =C2=A0if
                                  (!drm_core_check_feature(dev,
                                  DRIVER_SYNCOBJ))<br>
                                  +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0return -ENODEV;<br>
                                  +<br>
                                  +=C2=A0 =C2=A0 =C2=A0 =C2=A0if (args-&gt;=
flags !=3D 0
                                  &amp;&amp; args-&gt;flags !=3D
                                  DRM_SYNCOBJ_WAIT_FLAGS_WAIT_<wbr>ALL)<br>
                                  +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0return -EINVAL;<br>
                                  +<br>
                                  +=C2=A0 =C2=A0 =C2=A0 =C2=A0if (args-&gt;=
count_handles =3D=3D
                                  0)<br>
                                  +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0return -EINVAL;<br>
                                  +<br>
                                  +=C2=A0 =C2=A0 =C2=A0 =C2=A0/* Get the ha=
ndles from
                                  userspace */<br>
                                  +=C2=A0 =C2=A0 =C2=A0 =C2=A0handles =3D
                                  kmalloc_array(args-&gt;count_<wbr>handles=
,
                                  sizeof(uint32_t),<br>
                                  +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0
                                  =C2=A0GFP_KERNEL);<br>
                                  +=C2=A0 =C2=A0 =C2=A0 =C2=A0if (handles =
=3D=3D NULL)<br>
                                  +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0return -ENOMEM;<br>
                                  +<br>
                                  +=C2=A0 =C2=A0 =C2=A0 =C2=A0if (copy_from=
_user(handles,<br>
                                  +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0
                                  u64_to_user_ptr(args-&gt;handles)<wbr>,<b=
r>
                                  +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0
                                  sizeof(uint32_t) *
                                  args-&gt;count_handles)) {<br>
                                  +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0ret =3D -EFAULT;<br>
                                  +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0goto err_free_handles;<br>
                                  +=C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
                                  +<br>
                                  +=C2=A0 =C2=A0 =C2=A0 =C2=A0fences =3D
                                  kcalloc(args-&gt;count_handles,<br>
                                  +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 sizeof(struct
                                  dma_fence *), GFP_KERNEL);<br>
                                  +=C2=A0 =C2=A0 =C2=A0 =C2=A0if (!fences) =
{<br>
                                  +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0ret =3D -ENOMEM;<br>
                                  +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0goto err_free_handles;<br>
                                  +=C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
                                  +<br>
                                  +=C2=A0 =C2=A0 =C2=A0 =C2=A0for (i =3D 0;=
 i &lt;
                                  args-&gt;count_handles; i++) {<br>
                                  +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0ret =3D
                                  drm_syncobj_fence_get(file_<wbr>private,
                                  handles[i],<br>
                                  +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0
                                  =C2=A0 =C2=A0 =C2=A0&amp;fences[i]);<br>
                                  +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0if (ret)<br>
                                  +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0goto
                                  err_free_fence_array;<br>
                                  +=C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
                                  +<br>
                                  +=C2=A0 =C2=A0 =C2=A0 =C2=A0ret =3D
                                  drm_syncobj_wait_fences(dev,
                                  file_private,<br>
                                  +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0
                                  =C2=A0args, fences);<u></u><u></u></p>
                              </blockquote>
                              <div>
                                <p class=3D"MsoNormal"><u></u>=C2=A0<u></u>=
</p>
                              </div>
                              <div>
                                <p class=3D"MsoNormal">So, reading some
                                  CTS tests again, and I think we have a
                                  problem here.=C2=A0 The Vulkan spec allow=
s
                                  you to wait on a fence that is in the
                                  unsignaled state.<u></u><u></u></p>
                              </div>
                            </div>
                          </div>
                        </div>
                      </blockquote>
                      <p class=3D"MsoNormal"><u></u>=C2=A0<u></u></p>
                    </div>
                  </div>
                  <p class=3D"MsoNormal">At least on the closed source
                    driver that would be illegal as far as I know.<u></u><u=
></u></p>
                </div>
              </blockquote>
              <div>
                <p class=3D"MsoNormal"><u></u>=C2=A0<u></u></p>
              </div>
              <div>
                <p class=3D"MsoNormal">Then they are doing workarounds in
                  userspace.=C2=A0 There are definitely CTS tests for this:=
<br>
                  <br>
                  <a href=3D"https://github.com/KhronosGroup/VK-GL-CTS/blob=
/master/external/vulkancts/modules/vulkan/synchronization/vktSynchronizatio=
nBasicFenceTests.cpp#L74" target=3D"_blank">https://github.com/<wbr>Khronos=
Group/VK-GL-CTS/blob/<wbr>master/external/vulkancts/<wbr>modules/vulkan/<wb=
r>synchronization/<wbr>vktSynchronizationBasicFenceTe<wbr>sts.cpp#L74</a><u=
></u><u></u></p>
              </div>
              <div>
                <p class=3D"MsoNormal">=C2=A0<u></u><u></u></p>
              </div>
              <blockquote style=3D"border:none;border-left:solid #cccccc 1.=
0pt;padding:0in 0in 0in 6.0pt;margin-left:4.8pt;margin-right:0in">
                <div>
                  <p class=3D"MsoNormal">You can&#39;t wait on a semaphore
                    before the signal operation is send down to the
                    kerel.<u></u><u></u></p>
                </div>
              </blockquote>
              <div>
                <p class=3D"MsoNormal"><u></u>=C2=A0<u></u></p>
              </div>
              <div>
                <p class=3D"MsoNormal" style=3D"margin-bottom:12.0pt">We
                  (Intel) deal with this today by tracking whether or
                  not the fence has been submitted and using a condition
                  variable in userspace to sort it all out.=C2=A0 If we eve=
r
                  want to share fences across processes (which we do),
                  then this needs to be sorted in the kernel. <u></u><u></u=
></p>
              </div>
              <div>
                <p class=3D"MsoNormal">--Jason<u></u><u></u></p>
              </div>
              <div>
                <p class=3D"MsoNormal"><u></u>=C2=A0<u></u></p>
              </div>
              <div>
                <p class=3D"MsoNormal">=C2=A0<u></u><u></u></p>
              </div>
              <blockquote style=3D"border:none;border-left:solid #cccccc 1.=
0pt;padding:0in 0in 0in 6.0pt;margin-left:4.8pt;margin-right:0in">
                <div>
                  <p class=3D"MsoNormal">Regards,<br>
                    Christian.<u></u><u></u></p>
                  <div>
                    <div>
                      <p class=3D"MsoNormal"><br>
                        <br>
                        <br>
                        <u></u><u></u></p>
                      <blockquote style=3D"margin-top:5.0pt;margin-bottom:5=
.0pt">
                        <div>
                          <div>
                            <div>
                              <div>
                                <p class=3D"MsoNormal">=C2=A0 In theory, yo=
u
                                  could have thread A start waiting on a
                                  fence before thread B submits the work
                                  which triggers that fence.=C2=A0 This mea=
ns
                                  that the dma_fence may not exist yet
                                  when vkWaitForFences gets called.=C2=A0 I=
f
                                  we really want to support the full
                                  Vulkan usage, we need to somehow
                                  support missing dma_fences by waiting
                                  for the dma_fence to show up.=C2=A0
                                  Unfortunately, I don&#39;t know enough
                                  about the internal kernel APIs to know
                                  what that would look like.<u></u><u></u><=
/p>
                              </div>
                            </div>
                          </div>
                        </div>
                      </blockquote>
                    </div>
                  </div>
                  <blockquote style=3D"margin-top:5.0pt;margin-bottom:5.0pt=
">
                    <div>
                      <div>
                        <div>
                          <div>
                            <div>
                              <div>
                                <p class=3D"MsoNormal">=C2=A0<u></u><u></u>=
</p>
                              </div>
                              <blockquote style=3D"border:none;border-left:=
solid #cccccc 1.0pt;padding:0in 0in 0in 6.0pt;margin-left:4.8pt;margin-righ=
t:0in">
                                <p class=3D"MsoNormal">+<br>
                                  +err_free_fence_array:<br>
                                  +=C2=A0 =C2=A0 =C2=A0 =C2=A0for (i =3D 0;=
 i &lt;
                                  args-&gt;count_handles; i++)<br>
                                  +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0
                                  =C2=A0dma_fence_put(fences[i]);<br>
                                  +=C2=A0 =C2=A0 =C2=A0 =C2=A0kfree(fences)=
;<br>
                                  +err_free_handles:<br>
                                  +=C2=A0 =C2=A0 =C2=A0 =C2=A0kfree(handles=
);<br>
                                  +<br>
                                  +=C2=A0 =C2=A0 =C2=A0 =C2=A0return ret;<b=
r>
                                  +}<br>
                                  diff --git a/include/uapi/drm/drm.h
                                  b/include/uapi/drm/drm.h<br>
                                  index 101593a..91746a7 100644<br>
                                  --- a/include/uapi/drm/drm.h<br>
                                  +++ b/include/uapi/drm/drm.h<br>
                                  @@ -718,6 +718,18 @@ struct
                                  drm_syncobj_handle {<br>
                                  =C2=A0 =C2=A0 =C2=A0 =C2=A0 __u32 pad;<br=
>
                                  =C2=A0};<br>
                                  <br>
                                  +#define
                                  DRM_SYNCOBJ_WAIT_FLAGS_WAIT_<wbr>ALL (1
                                  &lt;&lt; 0)<br>
                                  +struct drm_syncobj_wait {<br>
                                  +=C2=A0 =C2=A0 =C2=A0 =C2=A0__u64 handles=
;<br>
                                  +=C2=A0 =C2=A0 =C2=A0 =C2=A0/* absolute t=
imeout */<br>
                                  +=C2=A0 =C2=A0 =C2=A0 =C2=A0__s64 timeout=
_sec;<br>
                                  +=C2=A0 =C2=A0 =C2=A0 =C2=A0__s64 timeout=
_nsec;<br>
                                  +=C2=A0 =C2=A0 =C2=A0 =C2=A0__u32 count_h=
andles;<br>
                                  +=C2=A0 =C2=A0 =C2=A0 =C2=A0__u32 flags;<=
br>
                                  +=C2=A0 =C2=A0 =C2=A0 =C2=A0__u32 first_s=
ignaled; /* only
                                  valid when not waiting all */<br>
                                  +=C2=A0 =C2=A0 =C2=A0 =C2=A0__u32 pad;<br=
>
                                  +};<br>
                                  +<br>
                                  =C2=A0#if defined(__cplusplus)<br>
                                  =C2=A0}<br>
                                  =C2=A0#endif<br>
                                  @@ -840,6 +852,7 @@ extern &quot;C&quot; =
{<br>
                                  =C2=A0#define DRM_IOCTL_SYNCOBJ_DESTROY=
=C2=A0 =C2=A0
                                  =C2=A0 DRM_IOWR(0xC0, struct
                                  drm_syncobj_destroy)<br>
                                  =C2=A0#define
                                  DRM_IOCTL_SYNCOBJ_HANDLE_TO_FD
                                  DRM_IOWR(0xC1, struct
                                  drm_syncobj_handle)<br>
                                  =C2=A0#define
                                  DRM_IOCTL_SYNCOBJ_FD_TO_HANDLE
                                  DRM_IOWR(0xC2, struct
                                  drm_syncobj_handle)<br>
                                  +#define DRM_IOCTL_SYNCOBJ_WAIT=C2=A0 =C2=
=A0 =C2=A0 =C2=A0
                                  =C2=A0DRM_IOWR(0xC3, struct
                                  drm_syncobj_wait)<br>
                                  <br>
                                  =C2=A0/**<br>
                                  =C2=A0 * Device specific ioctls should on=
ly
                                  be in their respective headers<br>
                                  <span class=3D"m_3510272536457704976gmail=
-m-226855681158848481hoenzb"><span style=3D"color:#888888">--</span></span>=
<span style=3D"color:#888888"><br>
                                    <span class=3D"m_3510272536457704976gma=
il-m-226855681158848481hoenzb">2.9.4</span><br>
                                    <br>
                                    <span class=3D"m_3510272536457704976gma=
il-m-226855681158848481hoenzb">______________________________<wbr>_________=
________</span><br>
                                    <span class=3D"m_3510272536457704976gma=
il-m-226855681158848481hoenzb">dri-devel
                                      mailing list</span><br>
                                    <span class=3D"m_3510272536457704976gma=
il-m-226855681158848481hoenzb"><a href=3D"mailto:dri-devel-PD4FTy7X32lNgt0PjOBp9w@public.gmane.org=
p.org" target=3D"_blank">dri-devel-PD4FTy7X32lNgt0PjOBp9/rsn8yoX9R0@public.gmane.org<wbr>org</a></span><br=
>
                                    <span class=3D"m_3510272536457704976gma=
il-m-226855681158848481hoenzb"><a href=3D"https://lists.freedesktop.org/mai=
lman/listinfo/dri-devel" target=3D"_blank">https://lists.freedesktop.org/<w=
br>mailman/listinfo/dri-devel</a></span></span><u></u><u></u></p>
                              </blockquote>
                            </div>
                            <p class=3D"MsoNormal"><u></u>=C2=A0<u></u></p>
                          </div>
                        </div>
                        <p class=3D"MsoNormal" style=3D"margin-bottom:12.0p=
t"><u></u>=C2=A0<u></u></p>
                      </div>
                    </div>
                    <pre>______________________________<wbr>_______________=
__<u></u><u></u></pre>
                    <pre>amd-gfx mailing list<u></u><u></u></pre>
                    <pre><a href=3D"mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" t=
arget=3D"_blank">amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org</a><u></u><u></u></pre>
                    <pre><a href=3D"https://lists.freedesktop.org/mailman/l=
istinfo/amd-gfx" target=3D"_blank">https://lists.freedesktop.org/<wbr>mailm=
an/listinfo/amd-gfx</a><u></u><u></u></pre>
                  </blockquote>
                  <p><u></u>=C2=A0<u></u></p>
                </div>
              </blockquote>
            </div>
            <p class=3D"MsoNormal"><u></u>=C2=A0<u></u></p>
          </div>
        </div>
      </div>
    </blockquote>
    <p><br>
    </p>
  </div></div></div>

</blockquote></div><br></div></div>

--001a114448189349430553fec09e--

--===============1271204298==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============1271204298==--
