From: =?UTF-8?Q?Christian_K=c3=b6nig?= <deathsimple-ANTagKRnAhcb1SvskN2V4Q@public.gmane.org>
Subject: Re: [PATCH] drm/syncobj: add sync obj wait interface. (v6)
Date: Mon, 10 Jul 2017 18:13:12 +0200
Message-ID: <60c420a9-eab6-a9e0-0306-893053d82a5d@vodafone.de>
References: <20170706010409.9373-1-airlied@gmail.com>
 <CAOFGe94mA9i7+-XTJQn65N-vK_GbQwvjru2b=6ucXejpWWmx4g@mail.gmail.com>
 <899f9bb3-f7c7-ce86-c22b-bb8d262778bf@vodafone.de>
 <CAOFGe96gaX2OjsXr8bNBUiqwyKAQfMSycH7PXgYAt_BBJ1UHkQ@mail.gmail.com>
 <DM5PR12MB12574F31128759A47DA1C7B7F2A90@DM5PR12MB1257.namprd12.prod.outlook.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1818922051=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <DM5PR12MB12574F31128759A47DA1C7B7F2A90-2J9CzHegvk/NHlLGalgXawdYzm3356FpvxpqHgZTriW3zl9H0oFU5g@public.gmane.org>
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
To: "Xie, AlexBin" <AlexBin.Xie-5C7GfCeVMHo@public.gmane.org>, Jason Ekstrand <jason-fQELhIk9awXprZlt/sZkLg@public.gmane.org>
Cc: Dave Airlie <airlied-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, amd-gfx mailing list <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, Maling list - DRI developers <dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

This is a multi-part message in MIME format.
--===============1818922051==
Content-Type: multipart/alternative;
 boundary="------------7B8BBACCB1EB7D4DBF45CE3D"
Content-Language: en-US

This is a multi-part message in MIME format.
--------------7B8BBACCB1EB7D4DBF45CE3D
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit

Am 10.07.2017 um 17:58 schrieb Xie, AlexBin:
>
> I understand this discussion from closes source driver terminology.
>
> If a process is killed before it sends out the signaling command, will 
> some part of the GPU be in a waiting situation forever?
>

Yes, exactly that's the problem here and the reason why that even 
Microsoft forbids that under windows.

Christian.

> Alex Bin Xie
>
> *From:*amd-gfx [mailto:amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org] *On 
> Behalf Of *Jason Ekstrand
> *Sent:* Monday, July 10, 2017 11:53 AM
> *To:* Christian König <deathsimple-ANTagKRnAhcb1SvskN2V4Q@public.gmane.org>
> *Cc:* Dave Airlie <airlied-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>; Maling list - DRI developers 
> <dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>; amd-gfx mailing list 
> <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
> *Subject:* Re: [PATCH] drm/syncobj: add sync obj wait interface. (v6)
>
> On Mon, Jul 10, 2017 at 8:45 AM, Christian König 
> <deathsimple-ANTagKRnAhcb1SvskN2V4Q@public.gmane.org <mailto:deathsimple-ANTagKRnAhcb1SvskN2V4Q@public.gmane.org>> wrote:
>
>     Am 10.07.2017 um 17:28 schrieb Jason Ekstrand:
>
>         On Wed, Jul 5, 2017 at 6:04 PM, Dave Airlie <airlied-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
>         <mailto:airlied-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>> wrote:
>
>             From: Dave Airlie <airlied-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org
>             <mailto:airlied-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>>
>
>             This interface will allow sync object to be used to back
>             Vulkan fences. This API is pretty much the vulkan fence
>             waiting
>             API, and I've ported the code from amdgpu.
>
>             v2: accept relative timeout, pass remaining time back
>             to userspace.
>             v3: return to absolute timeouts.
>             v4: absolute zero = poll,
>                 rewrite any/all code to have same operation for arrays
>                 return -EINVAL for 0 fences.
>             v4.1: fixup fences allocation check, use u64_to_user_ptr
>             v5: move to sec/nsec, and use timespec64 for calcs.
>             v6: use -ETIME and drop the out status flag. (-ETIME
>             is suggested by ickle, I can feel a shed painting)
>
>             Signed-off-by: Dave Airlie <airlied-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org
>             <mailto:airlied-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>>
>             ---
>              drivers/gpu/drm/drm_internal.h |   2 +
>              drivers/gpu/drm/drm_ioctl.c    |   2 +
>              drivers/gpu/drm/drm_syncobj.c  | 142
>             +++++++++++++++++++++++++++++++++++++++++
>              include/uapi/drm/drm.h         |  13 ++++
>              4 files changed, 159 insertions(+)
>
>             diff --git a/drivers/gpu/drm/drm_internal.h
>             b/drivers/gpu/drm/drm_internal.h
>             index 5cecc97..d71b50d 100644
>             --- a/drivers/gpu/drm/drm_internal.h
>             +++ b/drivers/gpu/drm/drm_internal.h
>             @@ -157,3 +157,5 @@ int
>             drm_syncobj_handle_to_fd_ioctl(struct drm_device *dev,
>             void *data,
>              struct drm_file *file_private);
>              int drm_syncobj_fd_to_handle_ioctl(struct drm_device
>             *dev, void *data,
>              struct drm_file *file_private);
>             +int drm_syncobj_wait_ioctl(struct drm_device *dev, void
>             *data,
>             +                          struct drm_file *file_private);
>             diff --git a/drivers/gpu/drm/drm_ioctl.c
>             b/drivers/gpu/drm/drm_ioctl.c
>             index f1e5681..385ce74 100644
>             --- a/drivers/gpu/drm/drm_ioctl.c
>             +++ b/drivers/gpu/drm/drm_ioctl.c
>             @@ -657,6 +657,8 @@ static const struct drm_ioctl_desc
>             drm_ioctls[] = {
>             DRM_UNLOCKED|DRM_RENDER_ALLOW),
>             DRM_IOCTL_DEF(DRM_IOCTL_SYNCOBJ_FD_TO_HANDLE,
>             drm_syncobj_fd_to_handle_ioctl,
>             DRM_UNLOCKED|DRM_RENDER_ALLOW),
>             +  DRM_IOCTL_DEF(DRM_IOCTL_SYNCOBJ_WAIT,
>             drm_syncobj_wait_ioctl,
>             +  DRM_UNLOCKED|DRM_RENDER_ALLOW),
>              };
>
>              #define DRM_CORE_IOCTL_COUNT  ARRAY_SIZE( drm_ioctls )
>             diff --git a/drivers/gpu/drm/drm_syncobj.c
>             b/drivers/gpu/drm/drm_syncobj.c
>             index 89441bc..2d5a7a1 100644
>             --- a/drivers/gpu/drm/drm_syncobj.c
>             +++ b/drivers/gpu/drm/drm_syncobj.c
>             @@ -1,5 +1,7 @@
>              /*
>               * Copyright 2017 Red Hat
>             + * Parts ported from amdgpu (fence wait code).
>             + * Copyright 2016 Advanced Micro Devices, Inc.
>               *
>               * Permission is hereby granted, free of charge, to any
>             person obtaining a
>               * copy of this software and associated documentation
>             files (the "Software"),
>             @@ -31,6 +33,9 @@
>               * that contain an optional fence. The fence can be
>             updated with a new
>               * fence, or be NULL.
>               *
>             + * syncobj's can be waited upon, where it will wait for
>             the underlying
>             + * fence.
>             + *
>               * syncobj's can be export to fd's and back, these fd's
>             are opaque and
>               * have no other use case, except passing the syncobj
>             between processes.
>               *
>             @@ -451,3 +456,140 @@
>             drm_syncobj_fd_to_handle_ioctl(struct drm_device *dev,
>             void *data,
>                     return drm_syncobj_fd_to_handle(file_private,
>             args->fd,
>               &args->handle);
>              }
>             +
>             +/**
>             + * drm_timeout_abs_to_jiffies - calculate jiffies timeout
>             from absolute value
>             + *
>             + * @timeout_sec: timeout sec component, 0 for poll
>             + * @timeout_nsec: timeout nsec component in ns, 0 for poll
>             + * both must be 0 for poll.
>             + *
>             + * Calculate the timeout in jiffies from an absolute time
>             in sec/nsec.
>             + */
>             +static unsigned long drm_timeout_abs_to_jiffies(int64_t
>             timeout_sec, uint64_t timeout_nsec)
>             +{
>             +       struct timespec64 abs_timeout, timeout,
>             max_jiffy_timespec;
>             +       unsigned long timeout_jiffies;
>             +
>             +       /* make 0 timeout means poll - absolute 0 doesn't
>             seem valid */
>             +       if (timeout_sec == 0 && timeout_nsec == 0)
>             +               return 0;
>             +
>             +       abs_timeout.tv_sec = timeout_sec;
>             +       abs_timeout.tv_nsec = timeout_nsec;
>             +
>             +       /* clamp timeout if it's to large */
>             +       if (!timespec64_valid_strict(&abs_timeout))
>             +               return MAX_SCHEDULE_TIMEOUT - 1;
>             +
>             +       timeout = timespec64_sub(abs_timeout,
>             ktime_to_timespec64(ktime_get()));
>             +       if (!timespec64_valid(&timeout))
>             +               return 0;
>             +
>             +  jiffies_to_timespec64(MAX_JIFFY_OFFSET,
>             &max_jiffy_timespec);
>             +       if (timespec64_compare(&timeout,
>             &max_jiffy_timespec) >= 0)
>             +               return MAX_SCHEDULE_TIMEOUT - 1;
>             +
>             +       timeout_jiffies = timespec64_to_jiffies(&timeout);
>             +       /*  clamp timeout to avoid infinite timeout */
>             +       if (timeout_jiffies >= MAX_SCHEDULE_TIMEOUT)
>             +               return MAX_SCHEDULE_TIMEOUT - 1;
>             +
>             +       return timeout_jiffies + 1;
>             +}
>             +
>             +static int drm_syncobj_wait_fences(struct drm_device *dev,
>             + struct drm_file *file_private,
>             + struct drm_syncobj_wait *wait,
>             + struct dma_fence **fences)
>             +{
>             +       unsigned long timeout =
>             drm_timeout_abs_to_jiffies(wait->timeout_sec,
>             wait->timeout_nsec);
>             +       int ret = 0;
>             +       uint32_t first = ~0;
>             +
>             +       if (wait->flags & DRM_SYNCOBJ_WAIT_FLAGS_WAIT_ALL) {
>             +               int i;
>             +               for (i = 0; i < wait->count_handles; i++) {
>             +                       ret =
>             dma_fence_wait_timeout(fences[i], true, timeout);
>             +
>             +                       if (ret < 0)
>             +                               return ret;
>             +                       if (ret == 0)
>             +                               break;
>             +                       timeout = ret;
>             +               }
>             +               first = 0;
>             +       } else {
>             +               ret = dma_fence_wait_any_timeout(fences,
>             +           wait->count_handles,
>             +           true, timeout,
>             +           &first);
>             +       }
>             +
>             +       if (ret < 0)
>             +               return ret;
>             +
>             +       wait->first_signaled = first;
>             +       if (ret == 0)
>             +               return -ETIME;
>             +       return 0;
>             +}
>             +
>             +int
>             +drm_syncobj_wait_ioctl(struct drm_device *dev, void *data,
>             +                      struct drm_file *file_private)
>             +{
>             +       struct drm_syncobj_wait *args = data;
>             +       uint32_t *handles;
>             +       struct dma_fence **fences;
>             +       int ret = 0;
>             +       int i;
>             +
>             +       if (!drm_core_check_feature(dev, DRIVER_SYNCOBJ))
>             +               return -ENODEV;
>             +
>             +       if (args->flags != 0 && args->flags !=
>             DRM_SYNCOBJ_WAIT_FLAGS_WAIT_ALL)
>             +               return -EINVAL;
>             +
>             +       if (args->count_handles == 0)
>             +               return -EINVAL;
>             +
>             +       /* Get the handles from userspace */
>             +       handles = kmalloc_array(args->count_handles,
>             sizeof(uint32_t),
>             +  GFP_KERNEL);
>             +       if (handles == NULL)
>             +               return -ENOMEM;
>             +
>             +       if (copy_from_user(handles,
>             + u64_to_user_ptr(args->handles),
>             + sizeof(uint32_t) * args->count_handles)) {
>             +               ret = -EFAULT;
>             +               goto err_free_handles;
>             +       }
>             +
>             +       fences = kcalloc(args->count_handles,
>             +                        sizeof(struct dma_fence *),
>             GFP_KERNEL);
>             +       if (!fences) {
>             +               ret = -ENOMEM;
>             +               goto err_free_handles;
>             +       }
>             +
>             +       for (i = 0; i < args->count_handles; i++) {
>             +               ret = drm_syncobj_fence_get(file_private,
>             handles[i],
>             +      &fences[i]);
>             +               if (ret)
>             +                       goto err_free_fence_array;
>             +       }
>             +
>             +       ret = drm_syncobj_wait_fences(dev, file_private,
>             +  args, fences);
>
>         So, reading some CTS tests again, and I think we have a
>         problem here.  The Vulkan spec allows you to wait on a fence
>         that is in the unsignaled state.
>
>     At least on the closed source driver that would be illegal as far
>     as I know.
>
> Then they are doing workarounds in userspace.  There are definitely 
> CTS tests for this:
>
> https://github.com/KhronosGroup/VK-GL-CTS/blob/master/external/vulkancts/modules/vulkan/synchronization/vktSynchronizationBasicFenceTests.cpp#L74
>
>     You can't wait on a semaphore before the signal operation is send
>     down to the kerel.
>
> We (Intel) deal with this today by tracking whether or not the fence 
> has been submitted and using a condition variable in userspace to sort 
> it all out.  If we ever want to share fences across processes (which 
> we do), then this needs to be sorted in the kernel.
>
> --Jason
>
>     Regards,
>     Christian.
>
>
>
>
>           In theory, you could have thread A start waiting on a fence
>         before thread B submits the work which triggers that fence. 
>         This means that the dma_fence may not exist yet when
>         vkWaitForFences gets called.  If we really want to support the
>         full Vulkan usage, we need to somehow support missing
>         dma_fences by waiting for the dma_fence to show up.
>         Unfortunately, I don't know enough about the internal kernel
>         APIs to know what that would look like.
>
>             +
>             +err_free_fence_array:
>             +       for (i = 0; i < args->count_handles; i++)
>             +  dma_fence_put(fences[i]);
>             +       kfree(fences);
>             +err_free_handles:
>             +       kfree(handles);
>             +
>             +       return ret;
>             +}
>             diff --git a/include/uapi/drm/drm.h b/include/uapi/drm/drm.h
>             index 101593a..91746a7 100644
>             --- a/include/uapi/drm/drm.h
>             +++ b/include/uapi/drm/drm.h
>             @@ -718,6 +718,18 @@ struct drm_syncobj_handle {
>                     __u32 pad;
>              };
>
>             +#define DRM_SYNCOBJ_WAIT_FLAGS_WAIT_ALL (1 << 0)
>             +struct drm_syncobj_wait {
>             +       __u64 handles;
>             +       /* absolute timeout */
>             +       __s64 timeout_sec;
>             +       __s64 timeout_nsec;
>             +       __u32 count_handles;
>             +       __u32 flags;
>             +       __u32 first_signaled; /* only valid when not
>             waiting all */
>             +       __u32 pad;
>             +};
>             +
>              #if defined(__cplusplus)
>              }
>              #endif
>             @@ -840,6 +852,7 @@ extern "C" {
>              #define DRM_IOCTL_SYNCOBJ_DESTROY   DRM_IOWR(0xC0, struct
>             drm_syncobj_destroy)
>              #define DRM_IOCTL_SYNCOBJ_HANDLE_TO_FD DRM_IOWR(0xC1,
>             struct drm_syncobj_handle)
>              #define DRM_IOCTL_SYNCOBJ_FD_TO_HANDLE DRM_IOWR(0xC2,
>             struct drm_syncobj_handle)
>             +#define DRM_IOCTL_SYNCOBJ_WAIT  DRM_IOWR(0xC3, struct
>             drm_syncobj_wait)
>
>              /**
>               * Device specific ioctls should only be in their
>             respective headers
>             --
>             2.9.4
>
>             _______________________________________________
>             dri-devel mailing list
>             dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
>             <mailto:dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
>             https://lists.freedesktop.org/mailman/listinfo/dri-devel
>
>         _______________________________________________
>
>         amd-gfx mailing list
>
>         amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
>         <mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
>
>         https://lists.freedesktop.org/mailman/listinfo/amd-gfx
>


--------------7B8BBACCB1EB7D4DBF45CE3D
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: 8bit

<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body text="#000000" bgcolor="#FFFFFF">
    <div class="moz-cite-prefix">Am 10.07.2017 um 17:58 schrieb Xie,
      AlexBin:<br>
    </div>
    <blockquote type="cite"
cite="mid:DM5PR12MB12574F31128759A47DA1C7B7F2A90-2J9CzHegvk/NHlLGalgXawdYzm3356FpvxpqHgZTriW3zl9H0oFU5g@public.gmane.org">
      <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
      <meta name="Generator" content="Microsoft Word 15 (filtered
        medium)">
      <style><!--
/* Font Definitions */
@font-face
	{font-family:SimSun;
	panose-1:2 1 6 0 3 1 1 1 1 1;}
@font-face
	{font-family:"Cambria Math";
	panose-1:2 4 5 3 5 4 6 3 2 4;}
@font-face
	{font-family:Calibri;
	panose-1:2 15 5 2 2 2 4 3 2 4;}
@font-face
	{font-family:Consolas;
	panose-1:2 11 6 9 2 2 4 3 2 4;}
@font-face
	{font-family:"\@SimSun";
	panose-1:2 1 6 0 3 1 1 1 1 1;}
/* Style Definitions */
p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0in;
	margin-bottom:.0001pt;
	font-size:12.0pt;
	font-family:"Times New Roman",serif;}
a:link, span.MsoHyperlink
	{mso-style-priority:99;
	color:blue;
	text-decoration:underline;}
a:visited, span.MsoHyperlinkFollowed
	{mso-style-priority:99;
	color:purple;
	text-decoration:underline;}
p
	{mso-style-priority:99;
	mso-margin-top-alt:auto;
	margin-right:0in;
	mso-margin-bottom-alt:auto;
	margin-left:0in;
	font-size:12.0pt;
	font-family:"Times New Roman",serif;}
pre
	{mso-style-priority:99;
	mso-style-link:"HTML Preformatted Char";
	margin:0in;
	margin-bottom:.0001pt;
	font-size:10.0pt;
	font-family:"Courier New";}
span.gmail-m-226855681158848481hoenzb
	{mso-style-name:gmail-m_-226855681158848481hoenzb;}
span.HTMLPreformattedChar
	{mso-style-name:"HTML Preformatted Char";
	mso-style-priority:99;
	mso-style-link:"HTML Preformatted";
	font-family:Consolas;}
span.EmailStyle21
	{mso-style-type:personal-reply;
	font-family:"Calibri",sans-serif;
	color:#1F497D;}
.MsoChpDefault
	{mso-style-type:export-only;
	font-family:"Calibri",sans-serif;}
@page WordSection1
	{size:8.5in 11.0in;
	margin:1.0in 1.0in 1.0in 1.0in;}
div.WordSection1
	{page:WordSection1;}
--></style><!--[if gte mso 9]><xml>
<o:shapedefaults v:ext="edit" spidmax="1026" />
</xml><![endif]--><!--[if gte mso 9]><xml>
<o:shapelayout v:ext="edit">
<o:idmap v:ext="edit" data="1" />
</o:shapelayout></xml><![endif]-->
      <div class="WordSection1">
        <p class="MsoNormal"><a name="_MailEndCompose"
            moz-do-not-send="true"><span
style="font-size:11.0pt;font-family:&quot;Calibri&quot;,sans-serif;color:#1F497D">I
              understand this discussion from closes source driver
              terminology.<o:p></o:p></span></a></p>
        <p class="MsoNormal"><span
style="font-size:11.0pt;font-family:&quot;Calibri&quot;,sans-serif;color:#1F497D"><o:p> </o:p></span></p>
        <p class="MsoNormal"><span
style="font-size:11.0pt;font-family:&quot;Calibri&quot;,sans-serif;color:#1F497D">If
            a process is killed before it sends out the signaling
            command, will some part of the GPU be in a waiting situation
            forever?</span></p>
      </div>
    </blockquote>
    <br>
    Yes, exactly that's the problem here and the reason why that even
    Microsoft forbids that under windows.<br>
    <br>
    Christian.<br>
    <br>
    <blockquote type="cite"
cite="mid:DM5PR12MB12574F31128759A47DA1C7B7F2A90-2J9CzHegvk/NHlLGalgXawdYzm3356FpvxpqHgZTriW3zl9H0oFU5g@public.gmane.org">
      <div class="WordSection1">
        <p class="MsoNormal"><span
style="font-size:11.0pt;font-family:&quot;Calibri&quot;,sans-serif;color:#1F497D"><o:p></o:p></span></p>
        <p class="MsoNormal"><span
style="font-size:11.0pt;font-family:&quot;Calibri&quot;,sans-serif;color:#1F497D"><o:p> </o:p></span></p>
        <p class="MsoNormal"><span
style="font-size:11.0pt;font-family:&quot;Calibri&quot;,sans-serif;color:#1F497D">Alex
            Bin Xie<o:p></o:p></span></p>
        <p class="MsoNormal"><b><span
              style="font-size:11.0pt;font-family:&quot;Calibri&quot;,sans-serif">From:</span></b><span
style="font-size:11.0pt;font-family:&quot;Calibri&quot;,sans-serif">
            amd-gfx [<a class="moz-txt-link-freetext" href="mailto:amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org">mailto:amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org</a>]
            <b>On Behalf Of </b>Jason Ekstrand<br>
            <b>Sent:</b> Monday, July 10, 2017 11:53 AM<br>
            <b>To:</b> Christian König <a class="moz-txt-link-rfc2396E" href="mailto:deathsimple-ANTagKRnAhcb1SvskN2V4Q@public.gmane.org">&lt;deathsimple-ANTagKRnAhcb1SvskN2V4Q@public.gmane.org&gt;</a><br>
            <b>Cc:</b> Dave Airlie <a class="moz-txt-link-rfc2396E" href="mailto:airlied-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org">&lt;airlied-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org&gt;</a>; Maling
            list - DRI developers
            <a class="moz-txt-link-rfc2396E" href="mailto:dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org">&lt;dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org&gt;</a>; amd-gfx mailing
            list <a class="moz-txt-link-rfc2396E" href="mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org">&lt;amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org&gt;</a><br>
            <b>Subject:</b> Re: [PATCH] drm/syncobj: add sync obj wait
            interface. (v6)<o:p></o:p></span></p>
        <p class="MsoNormal"><o:p> </o:p></p>
        <div>
          <div>
            <div>
              <p class="MsoNormal">On Mon, Jul 10, 2017 at 8:45 AM,
                Christian König &lt;<a
                  href="mailto:deathsimple-ANTagKRnAhcb1SvskN2V4Q@public.gmane.org" target="_blank"
                  moz-do-not-send="true">deathsimple-ANTagKRnAhcb1SvskN2V4Q@public.gmane.org</a>&gt;
                wrote:<o:p></o:p></p>
              <blockquote style="border:none;border-left:solid #CCCCCC
                1.0pt;padding:0in 0in 0in
                6.0pt;margin-left:4.8pt;margin-right:0in">
                <div>
                  <div>
                    <div>
                      <div>
                        <p class="MsoNormal">Am 10.07.2017 um 17:28
                          schrieb Jason Ekstrand:<o:p></o:p></p>
                      </div>
                      <blockquote
                        style="margin-top:5.0pt;margin-bottom:5.0pt">
                        <div>
                          <div>
                            <div>
                              <p class="MsoNormal">On Wed, Jul 5, 2017
                                at 6:04 PM, Dave Airlie &lt;<a
                                  href="mailto:airlied-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org"
                                  target="_blank" moz-do-not-send="true">airlied-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org</a>&gt;
                                wrote:<o:p></o:p></p>
                              <blockquote
                                style="border:none;border-left:solid
                                #CCCCCC 1.0pt;padding:0in 0in 0in
                                6.0pt;margin-left:4.8pt;margin-right:0in">
                                <p class="MsoNormal">From: Dave Airlie
                                  &lt;<a
                                    href="mailto:airlied-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org"
                                    target="_blank"
                                    moz-do-not-send="true">airlied-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org</a>&gt;<br>
                                  <br>
                                  This interface will allow sync object
                                  to be used to back<br>
                                  Vulkan fences. This API is pretty much
                                  the vulkan fence waiting<br>
                                  API, and I've ported the code from
                                  amdgpu.<br>
                                  <br>
                                  v2: accept relative timeout, pass
                                  remaining time back<br>
                                  to userspace.<br>
                                  v3: return to absolute timeouts.<br>
                                  v4: absolute zero = poll,<br>
                                      rewrite any/all code to have same
                                  operation for arrays<br>
                                      return -EINVAL for 0 fences.<br>
                                  v4.1: fixup fences allocation check,
                                  use u64_to_user_ptr<br>
                                  v5: move to sec/nsec, and use
                                  timespec64 for calcs.<br>
                                  v6: use -ETIME and drop the out status
                                  flag. (-ETIME<br>
                                  is suggested by ickle, I can feel a
                                  shed painting)<br>
                                  <br>
                                  Signed-off-by: Dave Airlie &lt;<a
                                    href="mailto:airlied-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org"
                                    target="_blank"
                                    moz-do-not-send="true">airlied-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org</a>&gt;<br>
                                  ---<br>
                                   drivers/gpu/drm/drm_internal.h |   2
                                  +<br>
                                   drivers/gpu/drm/drm_ioctl.c    |   2
                                  +<br>
                                   drivers/gpu/drm/drm_syncobj.c  | 142
+++++++++++++++++++++++++++++++++++++++++<br>
                                   include/uapi/drm/drm.h         |  13
                                  ++++<br>
                                   4 files changed, 159 insertions(+)<br>
                                  <br>
                                  diff --git
                                  a/drivers/gpu/drm/drm_internal.h
                                  b/drivers/gpu/drm/drm_internal.h<br>
                                  index 5cecc97..d71b50d 100644<br>
                                  --- a/drivers/gpu/drm/drm_internal.h<br>
                                  +++ b/drivers/gpu/drm/drm_internal.h<br>
                                  @@ -157,3 +157,5 @@ int
                                  drm_syncobj_handle_to_fd_ioctl(struct
                                  drm_device *dev, void *data,<br>
                                                                   
                                   struct drm_file *file_private);<br>
                                   int
                                  drm_syncobj_fd_to_handle_ioctl(struct
                                  drm_device *dev, void *data,<br>
                                                                   
                                   struct drm_file *file_private);<br>
                                  +int drm_syncobj_wait_ioctl(struct
                                  drm_device *dev, void *data,<br>
                                  +                          struct
                                  drm_file *file_private);<br>
                                  diff --git
                                  a/drivers/gpu/drm/drm_ioctl.c
                                  b/drivers/gpu/drm/drm_ioctl.c<br>
                                  index f1e5681..385ce74 100644<br>
                                  --- a/drivers/gpu/drm/drm_ioctl.c<br>
                                  +++ b/drivers/gpu/drm/drm_ioctl.c<br>
                                  @@ -657,6 +657,8 @@ static const
                                  struct drm_ioctl_desc drm_ioctls[] = {<br>
                                                       
                                  DRM_UNLOCKED|DRM_RENDER_ALLOW),<br>
                                         
                                  DRM_IOCTL_DEF(DRM_IOCTL_SYNCOBJ_FD_TO_HANDLE,
                                  drm_syncobj_fd_to_handle_ioctl,<br>
                                                       
                                  DRM_UNLOCKED|DRM_RENDER_ALLOW),<br>
                                  +     
                                   DRM_IOCTL_DEF(DRM_IOCTL_SYNCOBJ_WAIT,
                                  drm_syncobj_wait_ioctl,<br>
                                  +                   
                                   DRM_UNLOCKED|DRM_RENDER_ALLOW),<br>
                                   };<br>
                                  <br>
                                   #define DRM_CORE_IOCTL_COUNT 
                                   ARRAY_SIZE( drm_ioctls )<br>
                                  diff --git
                                  a/drivers/gpu/drm/drm_syncobj.c
                                  b/drivers/gpu/drm/drm_syncobj.c<br>
                                  index 89441bc..2d5a7a1 100644<br>
                                  --- a/drivers/gpu/drm/drm_syncobj.c<br>
                                  +++ b/drivers/gpu/drm/drm_syncobj.c<br>
                                  @@ -1,5 +1,7 @@<br>
                                   /*<br>
                                    * Copyright 2017 Red Hat<br>
                                  + * Parts ported from amdgpu (fence
                                  wait code).<br>
                                  + * Copyright 2016 Advanced Micro
                                  Devices, Inc.<br>
                                    *<br>
                                    * Permission is hereby granted, free
                                  of charge, to any person obtaining a<br>
                                    * copy of this software and
                                  associated documentation files (the
                                  "Software"),<br>
                                  @@ -31,6 +33,9 @@<br>
                                    * that contain an optional fence.
                                  The fence can be updated with a new<br>
                                    * fence, or be NULL.<br>
                                    *<br>
                                  + * syncobj's can be waited upon,
                                  where it will wait for the underlying<br>
                                  + * fence.<br>
                                  + *<br>
                                    * syncobj's can be export to fd's
                                  and back, these fd's are opaque and<br>
                                    * have no other use case, except
                                  passing the syncobj between processes.<br>
                                    *<br>
                                  @@ -451,3 +456,140 @@
                                  drm_syncobj_fd_to_handle_ioctl(struct
                                  drm_device *dev, void *data,<br>
                                          return
                                  drm_syncobj_fd_to_handle(file_private,
                                  args-&gt;fd,<br>
                                                                       
                                    &amp;args-&gt;handle);<br>
                                   }<br>
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
                                  drm_timeout_abs_to_jiffies(int64_t
                                  timeout_sec, uint64_t timeout_nsec)<br>
                                  +{<br>
                                  +       struct timespec64 abs_timeout,
                                  timeout, max_jiffy_timespec;<br>
                                  +       unsigned long timeout_jiffies;<br>
                                  +<br>
                                  +       /* make 0 timeout means poll -
                                  absolute 0 doesn't seem valid */<br>
                                  +       if (timeout_sec == 0
                                  &amp;&amp; timeout_nsec == 0)<br>
                                  +               return 0;<br>
                                  +<br>
                                  +       abs_timeout.tv_sec =
                                  timeout_sec;<br>
                                  +       abs_timeout.tv_nsec =
                                  timeout_nsec;<br>
                                  +<br>
                                  +       /* clamp timeout if it's to
                                  large */<br>
                                  +       if
                                  (!timespec64_valid_strict(&amp;abs_timeout))<br>
                                  +               return
                                  MAX_SCHEDULE_TIMEOUT - 1;<br>
                                  +<br>
                                  +       timeout =
                                  timespec64_sub(abs_timeout,
                                  ktime_to_timespec64(ktime_get()));<br>
                                  +       if
                                  (!timespec64_valid(&amp;timeout))<br>
                                  +               return 0;<br>
                                  +<br>
                                  +     
                                   jiffies_to_timespec64(MAX_JIFFY_OFFSET,
                                  &amp;max_jiffy_timespec);<br>
                                  +       if
                                  (timespec64_compare(&amp;timeout,
                                  &amp;max_jiffy_timespec) &gt;= 0)<br>
                                  +               return
                                  MAX_SCHEDULE_TIMEOUT - 1;<br>
                                  +<br>
                                  +       timeout_jiffies =
                                  timespec64_to_jiffies(&amp;timeout);<br>
                                  +       /*  clamp timeout to avoid
                                  infinite timeout */<br>
                                  +       if (timeout_jiffies &gt;=
                                  MAX_SCHEDULE_TIMEOUT)<br>
                                  +               return
                                  MAX_SCHEDULE_TIMEOUT - 1;<br>
                                  +<br>
                                  +       return timeout_jiffies + 1;<br>
                                  +}<br>
                                  +<br>
                                  +static int
                                  drm_syncobj_wait_fences(struct
                                  drm_device *dev,<br>
                                  +                                 
                                  struct drm_file *file_private,<br>
                                  +                                 
                                  struct drm_syncobj_wait *wait,<br>
                                  +                                 
                                  struct dma_fence **fences)<br>
                                  +{<br>
                                  +       unsigned long timeout =
                                  drm_timeout_abs_to_jiffies(wait-&gt;timeout_sec,
                                  wait-&gt;timeout_nsec);<br>
                                  +       int ret = 0;<br>
                                  +       uint32_t first = ~0;<br>
                                  +<br>
                                  +       if (wait-&gt;flags &amp;
                                  DRM_SYNCOBJ_WAIT_FLAGS_WAIT_ALL) {<br>
                                  +               int i;<br>
                                  +               for (i = 0; i &lt;
                                  wait-&gt;count_handles; i++) {<br>
                                  +                       ret =
                                  dma_fence_wait_timeout(fences[i],
                                  true, timeout);<br>
                                  +<br>
                                  +                       if (ret &lt;
                                  0)<br>
                                  +                               return
                                  ret;<br>
                                  +                       if (ret == 0)<br>
                                  +                               break;<br>
                                  +                       timeout = ret;<br>
                                  +               }<br>
                                  +               first = 0;<br>
                                  +       } else {<br>
                                  +               ret =
                                  dma_fence_wait_any_timeout(fences,<br>
                                  +                                     
                                            wait-&gt;count_handles,<br>
                                  +                                     
                                            true, timeout,<br>
                                  +                                     
                                            &amp;first);<br>
                                  +       }<br>
                                  +<br>
                                  +       if (ret &lt; 0)<br>
                                  +               return ret;<br>
                                  +<br>
                                  +       wait-&gt;first_signaled =
                                  first;<br>
                                  +       if (ret == 0)<br>
                                  +               return -ETIME;<br>
                                  +       return 0;<br>
                                  +}<br>
                                  +<br>
                                  +int<br>
                                  +drm_syncobj_wait_ioctl(struct
                                  drm_device *dev, void *data,<br>
                                  +                      struct drm_file
                                  *file_private)<br>
                                  +{<br>
                                  +       struct drm_syncobj_wait *args
                                  = data;<br>
                                  +       uint32_t *handles;<br>
                                  +       struct dma_fence **fences;<br>
                                  +       int ret = 0;<br>
                                  +       int i;<br>
                                  +<br>
                                  +       if
                                  (!drm_core_check_feature(dev,
                                  DRIVER_SYNCOBJ))<br>
                                  +               return -ENODEV;<br>
                                  +<br>
                                  +       if (args-&gt;flags != 0
                                  &amp;&amp; args-&gt;flags !=
                                  DRM_SYNCOBJ_WAIT_FLAGS_WAIT_ALL)<br>
                                  +               return -EINVAL;<br>
                                  +<br>
                                  +       if (args-&gt;count_handles ==
                                  0)<br>
                                  +               return -EINVAL;<br>
                                  +<br>
                                  +       /* Get the handles from
                                  userspace */<br>
                                  +       handles =
                                  kmalloc_array(args-&gt;count_handles,
                                  sizeof(uint32_t),<br>
                                  +                             
                                   GFP_KERNEL);<br>
                                  +       if (handles == NULL)<br>
                                  +               return -ENOMEM;<br>
                                  +<br>
                                  +       if (copy_from_user(handles,<br>
                                  +                         
                                  u64_to_user_ptr(args-&gt;handles),<br>
                                  +                         
                                  sizeof(uint32_t) *
                                  args-&gt;count_handles)) {<br>
                                  +               ret = -EFAULT;<br>
                                  +               goto err_free_handles;<br>
                                  +       }<br>
                                  +<br>
                                  +       fences =
                                  kcalloc(args-&gt;count_handles,<br>
                                  +                        sizeof(struct
                                  dma_fence *), GFP_KERNEL);<br>
                                  +       if (!fences) {<br>
                                  +               ret = -ENOMEM;<br>
                                  +               goto err_free_handles;<br>
                                  +       }<br>
                                  +<br>
                                  +       for (i = 0; i &lt;
                                  args-&gt;count_handles; i++) {<br>
                                  +               ret =
                                  drm_syncobj_fence_get(file_private,
                                  handles[i],<br>
                                  +                                     
                                       &amp;fences[i]);<br>
                                  +               if (ret)<br>
                                  +                       goto
                                  err_free_fence_array;<br>
                                  +       }<br>
                                  +<br>
                                  +       ret =
                                  drm_syncobj_wait_fences(dev,
                                  file_private,<br>
                                  +                                   
                                   args, fences);<o:p></o:p></p>
                              </blockquote>
                              <div>
                                <p class="MsoNormal"><o:p> </o:p></p>
                              </div>
                              <div>
                                <p class="MsoNormal">So, reading some
                                  CTS tests again, and I think we have a
                                  problem here.  The Vulkan spec allows
                                  you to wait on a fence that is in the
                                  unsignaled state.<o:p></o:p></p>
                              </div>
                            </div>
                          </div>
                        </div>
                      </blockquote>
                      <p class="MsoNormal"><o:p> </o:p></p>
                    </div>
                  </div>
                  <p class="MsoNormal">At least on the closed source
                    driver that would be illegal as far as I know.<o:p></o:p></p>
                </div>
              </blockquote>
              <div>
                <p class="MsoNormal"><o:p> </o:p></p>
              </div>
              <div>
                <p class="MsoNormal">Then they are doing workarounds in
                  userspace.  There are definitely CTS tests for this:<br>
                  <br>
                  <a
href="https://github.com/KhronosGroup/VK-GL-CTS/blob/master/external/vulkancts/modules/vulkan/synchronization/vktSynchronizationBasicFenceTests.cpp#L74"
                    moz-do-not-send="true">https://github.com/KhronosGroup/VK-GL-CTS/blob/master/external/vulkancts/modules/vulkan/synchronization/vktSynchronizationBasicFenceTests.cpp#L74</a><o:p></o:p></p>
              </div>
              <div>
                <p class="MsoNormal"> <o:p></o:p></p>
              </div>
              <blockquote style="border:none;border-left:solid #CCCCCC
                1.0pt;padding:0in 0in 0in
                6.0pt;margin-left:4.8pt;margin-right:0in">
                <div>
                  <p class="MsoNormal">You can't wait on a semaphore
                    before the signal operation is send down to the
                    kerel.<o:p></o:p></p>
                </div>
              </blockquote>
              <div>
                <p class="MsoNormal"><o:p> </o:p></p>
              </div>
              <div>
                <p class="MsoNormal" style="margin-bottom:12.0pt">We
                  (Intel) deal with this today by tracking whether or
                  not the fence has been submitted and using a condition
                  variable in userspace to sort it all out.  If we ever
                  want to share fences across processes (which we do),
                  then this needs to be sorted in the kernel. <o:p></o:p></p>
              </div>
              <div>
                <p class="MsoNormal">--Jason<o:p></o:p></p>
              </div>
              <div>
                <p class="MsoNormal"><o:p> </o:p></p>
              </div>
              <div>
                <p class="MsoNormal"> <o:p></o:p></p>
              </div>
              <blockquote style="border:none;border-left:solid #CCCCCC
                1.0pt;padding:0in 0in 0in
                6.0pt;margin-left:4.8pt;margin-right:0in">
                <div>
                  <p class="MsoNormal">Regards,<br>
                    Christian.<o:p></o:p></p>
                  <div>
                    <div>
                      <p class="MsoNormal"><br>
                        <br>
                        <br>
                        <o:p></o:p></p>
                      <blockquote
                        style="margin-top:5.0pt;margin-bottom:5.0pt">
                        <div>
                          <div>
                            <div>
                              <div>
                                <p class="MsoNormal">  In theory, you
                                  could have thread A start waiting on a
                                  fence before thread B submits the work
                                  which triggers that fence.  This means
                                  that the dma_fence may not exist yet
                                  when vkWaitForFences gets called.  If
                                  we really want to support the full
                                  Vulkan usage, we need to somehow
                                  support missing dma_fences by waiting
                                  for the dma_fence to show up. 
                                  Unfortunately, I don't know enough
                                  about the internal kernel APIs to know
                                  what that would look like.<o:p></o:p></p>
                              </div>
                            </div>
                          </div>
                        </div>
                      </blockquote>
                    </div>
                  </div>
                  <blockquote
                    style="margin-top:5.0pt;margin-bottom:5.0pt">
                    <div>
                      <div>
                        <div>
                          <div>
                            <div>
                              <div>
                                <p class="MsoNormal"> <o:p></o:p></p>
                              </div>
                              <blockquote
                                style="border:none;border-left:solid
                                #CCCCCC 1.0pt;padding:0in 0in 0in
                                6.0pt;margin-left:4.8pt;margin-right:0in">
                                <p class="MsoNormal">+<br>
                                  +err_free_fence_array:<br>
                                  +       for (i = 0; i &lt;
                                  args-&gt;count_handles; i++)<br>
                                  +             
                                   dma_fence_put(fences[i]);<br>
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
                                  @@ -718,6 +718,18 @@ struct
                                  drm_syncobj_handle {<br>
                                          __u32 pad;<br>
                                   };<br>
                                  <br>
                                  +#define
                                  DRM_SYNCOBJ_WAIT_FLAGS_WAIT_ALL (1
                                  &lt;&lt; 0)<br>
                                  +struct drm_syncobj_wait {<br>
                                  +       __u64 handles;<br>
                                  +       /* absolute timeout */<br>
                                  +       __s64 timeout_sec;<br>
                                  +       __s64 timeout_nsec;<br>
                                  +       __u32 count_handles;<br>
                                  +       __u32 flags;<br>
                                  +       __u32 first_signaled; /* only
                                  valid when not waiting all */<br>
                                  +       __u32 pad;<br>
                                  +};<br>
                                  +<br>
                                   #if defined(__cplusplus)<br>
                                   }<br>
                                   #endif<br>
                                  @@ -840,6 +852,7 @@ extern "C" {<br>
                                   #define DRM_IOCTL_SYNCOBJ_DESTROY   
                                    DRM_IOWR(0xC0, struct
                                  drm_syncobj_destroy)<br>
                                   #define
                                  DRM_IOCTL_SYNCOBJ_HANDLE_TO_FD
                                  DRM_IOWR(0xC1, struct
                                  drm_syncobj_handle)<br>
                                   #define
                                  DRM_IOCTL_SYNCOBJ_FD_TO_HANDLE
                                  DRM_IOWR(0xC2, struct
                                  drm_syncobj_handle)<br>
                                  +#define DRM_IOCTL_SYNCOBJ_WAIT       
                                   DRM_IOWR(0xC3, struct
                                  drm_syncobj_wait)<br>
                                  <br>
                                   /**<br>
                                    * Device specific ioctls should only
                                  be in their respective headers<br>
                                  <span
                                    class="gmail-m-226855681158848481hoenzb"><span
                                      style="color:#888888">--</span></span><span
                                    style="color:#888888"><br>
                                    <span
                                      class="gmail-m-226855681158848481hoenzb">2.9.4</span><br>
                                    <br>
                                    <span
                                      class="gmail-m-226855681158848481hoenzb">_______________________________________________</span><br>
                                    <span
                                      class="gmail-m-226855681158848481hoenzb">dri-devel
                                      mailing list</span><br>
                                    <span
                                      class="gmail-m-226855681158848481hoenzb"><a
href="mailto:dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" target="_blank"
                                        moz-do-not-send="true">dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org</a></span><br>
                                    <span
                                      class="gmail-m-226855681158848481hoenzb"><a
href="https://lists.freedesktop.org/mailman/listinfo/dri-devel"
                                        target="_blank"
                                        moz-do-not-send="true">https://lists.freedesktop.org/mailman/listinfo/dri-devel</a></span></span><o:p></o:p></p>
                              </blockquote>
                            </div>
                            <p class="MsoNormal"><o:p> </o:p></p>
                          </div>
                        </div>
                        <p class="MsoNormal"
                          style="margin-bottom:12.0pt"><o:p> </o:p></p>
                      </div>
                    </div>
                    <pre>_______________________________________________<o:p></o:p></pre>
                    <pre>amd-gfx mailing list<o:p></o:p></pre>
                    <pre><a href="mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" target="_blank" moz-do-not-send="true">amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org</a><o:p></o:p></pre>
                    <pre><a href="https://lists.freedesktop.org/mailman/listinfo/amd-gfx" target="_blank" moz-do-not-send="true">https://lists.freedesktop.org/mailman/listinfo/amd-gfx</a><o:p></o:p></pre>
                  </blockquote>
                  <p><o:p> </o:p></p>
                </div>
              </blockquote>
            </div>
            <p class="MsoNormal"><o:p> </o:p></p>
          </div>
        </div>
      </div>
    </blockquote>
    <p><br>
    </p>
  </body>
</html>

--------------7B8BBACCB1EB7D4DBF45CE3D--

--===============1818922051==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============1818922051==--
