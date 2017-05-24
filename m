From: Jason Ekstrand <jason-fQELhIk9awXprZlt/sZkLg@public.gmane.org>
Subject: Re: [PATCH 3/5] drm/syncobj: add sync_file interaction.
Date: Wed, 24 May 2017 10:34:36 -0700
Message-ID: <CAOFGe97Y8Eh-+rHfPodQPRpbgOVw5TtPmxa7u4ET61UgrufwPA@mail.gmail.com>
References: <20170524070615.1634-1-airlied@gmail.com>
 <20170524070615.1634-4-airlied@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0211407049=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <20170524070615.1634-4-airlied-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
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

--===============0211407049==
Content-Type: multipart/alternative; boundary="001a114b3812ac84cd05504884b3"

--001a114b3812ac84cd05504884b3
Content-Type: text/plain; charset="UTF-8"

Yes, I believe this is the proper way for sync_file and syncobj to
interact.  Again, I can't really review for all of the kernel details
(though the seem ok to me) so this mostly applies to the API:

Reviewed-by: Jason Ekstrand <jason-fQELhIk9awXprZlt/sZkLg@public.gmane.org>

On Wed, May 24, 2017 at 12:06 AM, Dave Airlie <airlied-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:

> From: Dave Airlie <airlied-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
>
> This interface allows importing the fence from a sync_file into
> an existing drm sync object, or exporting the fence attached to
> an existing drm sync object into a new sync file object.
>
> This should only be used to interact with sync files where necessary.
>
> Reviewed-by: Sean Paul <seanpaul-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
> Signed-off-by: Dave Airlie <airlied-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
> ---
>  drivers/gpu/drm/drm_syncobj.c | 64 ++++++++++++++++++++++++++++++
> +++++++++++--
>  include/uapi/drm/drm.h        |  2 ++
>  2 files changed, 64 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/drm_syncobj.c b/drivers/gpu/drm/drm_syncobj.c
> index 8b87594..54d751e 100644
> --- a/drivers/gpu/drm/drm_syncobj.c
> +++ b/drivers/gpu/drm/drm_syncobj.c
> @@ -50,6 +50,7 @@
>  #include <linux/file.h>
>  #include <linux/fs.h>
>  #include <linux/anon_inodes.h>
> +#include <linux/sync_file.h>
>
>  #include "drm_internal.h"
>  #include <drm/drm_syncobj.h>
> @@ -276,6 +277,48 @@ static int drm_syncobj_fd_to_handle(struct drm_file
> *file_private,
>         return 0;
>  }
>
> +int drm_syncobj_import_sync_file_fence(struct drm_file *file_private,
> +                                      int fd, int handle)
> +{
> +       struct dma_fence *fence = sync_file_get_fence(fd);
> +       if (!fence)
> +               return -EINVAL;
> +
> +       return drm_syncobj_replace_fence(file_private, handle, fence);
> +}
> +
> +int drm_syncobj_export_sync_file(struct drm_file *file_private,
> +                                int handle, int *p_fd)
> +{
> +       int ret;
> +       struct dma_fence *fence;
> +       struct sync_file *sync_file;
> +       int fd = get_unused_fd_flags(O_CLOEXEC);
> +
> +       if (fd < 0)
> +               return fd;
> +
> +       ret = drm_syncobj_fence_get(file_private, handle, &fence);
> +       if (ret)
> +               goto err_put_fd;
> +
> +       sync_file = sync_file_create(fence);
> +       if (!sync_file) {
> +               ret = -EINVAL;
> +               goto err_fence_put;
> +       }
> +
> +       fd_install(fd, sync_file->file);
> +
> +       dma_fence_put(fence);
> +       *p_fd = fd;
> +       return 0;
> +err_fence_put:
> +       dma_fence_put(fence);
> +err_put_fd:
> +       put_unused_fd(fd);
> +       return ret;
> +}
>  /**
>   * drm_syncobj_open - initalizes syncobj file-private structures at
> devnode open time
>   * @dev: drm_device which is being opened by userspace
> @@ -358,9 +401,17 @@ drm_syncobj_handle_to_fd_ioctl(struct drm_device
> *dev, void *data,
>         if (!drm_core_check_feature(dev, DRIVER_SYNCOBJ))
>                 return -ENODEV;
>
> -       if (args->pad || args->flags)
> +       if (args->pad)
> +               return -EINVAL;
> +
> +       if (args->flags != 0 &&
> +           args->flags != DRM_SYNCOBJ_HANDLE_TO_FD_
> FLAGS_EXPORT_FENCE_SYNC_FILE)
>                 return -EINVAL;
>
> +       if (args->flags & DRM_SYNCOBJ_HANDLE_TO_FD_
> FLAGS_EXPORT_FENCE_SYNC_FILE)
> +               return drm_syncobj_export_sync_file(file_private,
> args->handle,
> +                                                   &args->fd);
> +
>         return drm_syncobj_handle_to_fd(file_private, args->handle,
>                                         &args->fd);
>  }
> @@ -374,9 +425,18 @@ drm_syncobj_fd_to_handle_ioctl(struct drm_device
> *dev, void *data,
>         if (!drm_core_check_feature(dev, DRIVER_SYNCOBJ))
>                 return -ENODEV;
>
> -       if (args->pad || args->flags)
> +       if (args->pad)
>                 return -EINVAL;
>
> +       if (args->flags != 0 &&
> +           args->flags != DRM_SYNCOBJ_FD_TO_HANDLE_
> FLAGS_IMPORT_SYNC_FILE_FENCE)
> +               return -EINVAL;
> +
> +       if (args->flags & DRM_SYNCOBJ_FD_TO_HANDLE_
> FLAGS_IMPORT_SYNC_FILE_FENCE)
> +               return drm_syncobj_import_sync_file_fence(file_private,
> +                                                         args->fd,
> +                                                         args->handle);
> +
>         return drm_syncobj_fd_to_handle(file_private, args->fd,
>                                         &args->handle);
>  }
> diff --git a/include/uapi/drm/drm.h b/include/uapi/drm/drm.h
> index d6e2f62..94c75be 100644
> --- a/include/uapi/drm/drm.h
> +++ b/include/uapi/drm/drm.h
> @@ -708,6 +708,8 @@ struct drm_syncobj_destroy {
>         __u32 pad;
>  };
>
> +#define DRM_SYNCOBJ_FD_TO_HANDLE_FLAGS_IMPORT_SYNC_FILE_FENCE (1 << 0)
> +#define DRM_SYNCOBJ_HANDLE_TO_FD_FLAGS_EXPORT_FENCE_SYNC_FILE (1 << 0)
>  struct drm_syncobj_handle {
>         __u32 handle;
>         __u32 flags;
> --
> 2.9.4
>
> _______________________________________________
> dri-devel mailing list
> dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
>

--001a114b3812ac84cd05504884b3
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Yes, I believe this is the proper way for sync_file and sy=
ncobj to interact.=C2=A0 Again, I can&#39;t really review for all of the ke=
rnel details (though the seem ok to me) so this mostly applies to the API:<=
br><br>Reviewed-by: Jason Ekstrand &lt;<a href=3D"mailto:jason@jlekstrand.n=
et">jason-fQELhIk9awXprZlt/sZkLg@public.gmane.org</a>&gt;<br></div><div class=3D"gmail_extra"><br><d=
iv class=3D"gmail_quote">On Wed, May 24, 2017 at 12:06 AM, Dave Airlie <spa=
n dir=3D"ltr">&lt;<a href=3D"mailto:airlied-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org" target=3D"_blank">ai=
rlied-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org</a>&gt;</span> wrote:<br><blockquote class=3D"gmail_quote" =
style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">Fro=
m: Dave Airlie &lt;<a href=3D"mailto:airlied-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org">airlied-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org=
</a>&gt;<br>
<br>
This interface allows importing the fence from a sync_file into<br>
an existing drm sync object, or exporting the fence attached to<br>
an existing drm sync object into a new sync file object.<br>
<br>
This should only be used to interact with sync files where necessary.<br>
<br>
Reviewed-by: Sean Paul &lt;<a href=3D"mailto:seanpaul-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org">seanpau=
l@chromium.org</a>&gt;<br>
Signed-off-by: Dave Airlie &lt;<a href=3D"mailto:airlied-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org">airlie=
d@redhat.com</a>&gt;<br>
---<br>
=C2=A0drivers/gpu/drm/drm_syncobj.c | 64 ++++++++++++++++++++++++++++++<wbr=
>+++++++++++--<br>
=C2=A0include/uapi/drm/drm.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 2 ++<br>
=C2=A02 files changed, 64 insertions(+), 2 deletions(-)<br>
<br>
diff --git a/drivers/gpu/drm/drm_syncobj.<wbr>c b/drivers/gpu/drm/drm_synco=
bj.<wbr>c<br>
index 8b87594..54d751e 100644<br>
--- a/drivers/gpu/drm/drm_syncobj.<wbr>c<br>
+++ b/drivers/gpu/drm/drm_syncobj.<wbr>c<br>
@@ -50,6 +50,7 @@<br>
=C2=A0#include &lt;linux/file.h&gt;<br>
=C2=A0#include &lt;linux/fs.h&gt;<br>
=C2=A0#include &lt;linux/anon_inodes.h&gt;<br>
+#include &lt;linux/sync_file.h&gt;<br>
<br>
=C2=A0#include &quot;drm_internal.h&quot;<br>
=C2=A0#include &lt;drm/drm_syncobj.h&gt;<br>
@@ -276,6 +277,48 @@ static int drm_syncobj_fd_to_handle(<wbr>struct drm_fi=
le *file_private,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 return 0;<br>
=C2=A0}<br>
<br>
+int drm_syncobj_import_sync_file_<wbr>fence(struct drm_file *file_private,=
<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 int fd, int han=
dle)<br>
+{<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0struct dma_fence *fence =3D sync_file_get_fence=
(fd);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0if (!fence)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return -EINVAL;<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0return drm_syncobj_replace_fence(<wbr>file_priv=
ate, handle, fence);<br>
+}<br>
+<br>
+int drm_syncobj_export_sync_file(<wbr>struct drm_file *file_private,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 int handle, int *p_fd)<br>
+{<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0int ret;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0struct dma_fence *fence;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0struct sync_file *sync_file;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0int fd =3D get_unused_fd_flags(O_CLOEXEC)<wbr>;=
<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0if (fd &lt; 0)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return fd;<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0ret =3D drm_syncobj_fence_get(file_<wbr>private=
, handle, &amp;fence);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0if (ret)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0goto err_put_fd;<br=
>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0sync_file =3D sync_file_create(fence);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0if (!sync_file) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ret =3D -EINVAL;<br=
>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0goto err_fence_put;=
<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0fd_install(fd, sync_file-&gt;file);<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0dma_fence_put(fence);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0*p_fd =3D fd;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0return 0;<br>
+err_fence_put:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0dma_fence_put(fence);<br>
+err_put_fd:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0put_unused_fd(fd);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0return ret;<br>
+}<br>
=C2=A0/**<br>
=C2=A0 * drm_syncobj_open - initalizes syncobj file-private structures at d=
evnode open time<br>
=C2=A0 * @dev: drm_device which is being opened by userspace<br>
@@ -358,9 +401,17 @@ drm_syncobj_handle_to_fd_<wbr>ioctl(struct drm_device =
*dev, void *data,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (!drm_core_check_feature(dev, DRIVER_SYNCOBJ=
))<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return -ENODEV;<br>
<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0if (args-&gt;pad || args-&gt;flags)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0if (args-&gt;pad)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return -EINVAL;<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0if (args-&gt;flags !=3D 0 &amp;&amp;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0args-&gt;flags !=3D DRM_SYNCOBJ_H=
ANDLE_TO_FD_<wbr>FLAGS_EXPORT_FENCE_SYNC_FILE)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return -EINVAL;<br>
<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0if (args-&gt;flags &amp; DRM_SYNCOBJ_HANDLE_TO_=
FD_<wbr>FLAGS_EXPORT_FENCE_SYNC_FILE)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return drm_syncobj_=
export_sync_file(<wbr>file_private, args-&gt;handle,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&amp;args-&gt;fd);<br>
+<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 return drm_syncobj_handle_to_fd(file_<wbr>priva=
te, args-&gt;handle,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &amp;arg=
s-&gt;fd);<br>
=C2=A0}<br>
@@ -374,9 +425,18 @@ drm_syncobj_fd_to_handle_<wbr>ioctl(struct drm_device =
*dev, void *data,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (!drm_core_check_feature(dev, DRIVER_SYNCOBJ=
))<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return -ENODEV;<br>
<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0if (args-&gt;pad || args-&gt;flags)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0if (args-&gt;pad)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return -EINVAL;<br>
<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0if (args-&gt;flags !=3D 0 &amp;&amp;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0args-&gt;flags !=3D DRM_SYNCOBJ_F=
D_TO_HANDLE_<wbr>FLAGS_IMPORT_SYNC_FILE_FENCE)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return -EINVAL;<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0if (args-&gt;flags &amp; DRM_SYNCOBJ_FD_TO_HAND=
LE_<wbr>FLAGS_IMPORT_SYNC_FILE_FENCE)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return drm_syncobj_=
import_sync_file_<wbr>fence(file_private,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0args-&gt;fd,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0args-&gt;handle);<br=
>
+<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 return drm_syncobj_fd_to_handle(file_<wbr>priva=
te, args-&gt;fd,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &amp;arg=
s-&gt;handle);<br>
=C2=A0}<br>
diff --git a/include/uapi/drm/drm.h b/include/uapi/drm/drm.h<br>
index d6e2f62..94c75be 100644<br>
--- a/include/uapi/drm/drm.h<br>
+++ b/include/uapi/drm/drm.h<br>
@@ -708,6 +708,8 @@ struct drm_syncobj_destroy {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 __u32 pad;<br>
=C2=A0};<br>
<br>
+#define DRM_SYNCOBJ_FD_TO_HANDLE_<wbr>FLAGS_IMPORT_SYNC_FILE_FENCE (1 &lt;=
&lt; 0)<br>
+#define DRM_SYNCOBJ_HANDLE_TO_FD_<wbr>FLAGS_EXPORT_FENCE_SYNC_FILE (1 &lt;=
&lt; 0)<br>
=C2=A0struct drm_syncobj_handle {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 __u32 handle;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 __u32 flags;<br>
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
</font></span></blockquote></div><br></div>

--001a114b3812ac84cd05504884b3--

--===============0211407049==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============0211407049==--
