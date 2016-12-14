From: Dave Airlie <airlied-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 2/8] dal: remove some unused wrappers
Date: Thu, 15 Dec 2016 07:04:20 +1000
Message-ID: <CAPM=9twTT9HGzonG5Oz9pb+-B_1p7UAOYRbExVk_NmRTyssMkQ@mail.gmail.com>
References: <20161213064112.20004-1-airlied@gmail.com>
 <20161213064112.20004-3-airlied@gmail.com>
 <f30d9730-8d3d-4b9d-ced2-4a1bb93138d2@amd.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1212854423=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <f30d9730-8d3d-4b9d-ced2-4a1bb93138d2-5C7GfCeVMHo@public.gmane.org>
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
To: Harry Wentland <harry.wentland-5C7GfCeVMHo@public.gmane.org>
Cc: amd-gfx mailing list <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

--===============1212854423==
Content-Type: multipart/alternative; boundary=001a1143915847d2f40543a4ae43

--001a1143915847d2f40543a4ae43
Content-Type: text/plain; charset=UTF-8

On 15 Dec. 2016 02:27, "Harry Wentland" <harry.wentland-5C7GfCeVMHo@public.gmane.org> wrote:

They are still used all over the place (e.g. dc/dce110/dce110_resource.c:41
3).

We should at least do an spatch to use kzalloc/krealloc/kfree across the
board if the wrappers are an issue.


Some are used, these 3 defines are not, there is another header defining
them,

But yes it would be good to drop all alloc wrappers

Dave.


NAKed

Harry


On 2016-12-13 01:41 AM, Dave Airlie wrote:

> From: Dave Airlie <airlied-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
>
> Signed-off-by: Dave Airlie <airlied-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
> ---
>  drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_services.c | 4 ----
>  1 file changed, 4 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_services.c
> b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_services.c
> index 9d51259..9c852a3 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_services.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_services.c
> @@ -36,10 +36,6 @@
>  #include "amdgpu_dm_types.h"
>  #include "amdgpu_pm.h"
>
> -#define dm_alloc(size) kzalloc(size, GFP_KERNEL)
> -#define dm_realloc(ptr, size) krealloc(ptr, size, GFP_KERNEL)
> -#define dm_free(ptr) kfree(ptr)
> -
>  /**********************************************************
> ********************
>   * IRQ Interfaces.
>   ************************************************************
> *****************/
>
> _______________________________________________
amd-gfx mailing list
amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--001a1143915847d2f40543a4ae43
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div><br><div class=3D"gmail_extra"><br><div class=3D"gma=
il_quote">On 15 Dec. 2016 02:27, &quot;Harry Wentland&quot; &lt;<a href=3D"=
mailto:harry.wentland-5C7GfCeVMHo@public.gmane.org">harry.wentland-5C7GfCeVMHo@public.gmane.org</a>&gt; wrote:<br typ=
e=3D"attribution"><blockquote class=3D"quote" style=3D"margin:0 0 0 .8ex;bo=
rder-left:1px #ccc solid;padding-left:1ex">They are still used all over the=
 place (e.g. dc/dce110/dce110_resource.c:41<wbr>3).<br>
<br>
We should at least do an spatch to use kzalloc/krealloc/kfree across the bo=
ard if the wrappers are an issue.<br></blockquote></div></div></div><div di=
r=3D"auto"><br></div><div dir=3D"auto">Some are used, these 3 defines are n=
ot, there is another header defining them,</div><div dir=3D"auto"><br></div=
><div dir=3D"auto">But yes it would be good to drop all alloc wrappers=C2=
=A0</div><div dir=3D"auto"><br></div><div dir=3D"auto">Dave.</div><div dir=
=3D"auto"><div class=3D"gmail_extra"><div class=3D"gmail_quote"><blockquote=
 class=3D"quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padd=
ing-left:1ex">
<br>
NAKed<font color=3D"#888888"><br>
<br>
Harry</font><div class=3D"quoted-text"><br>
<br>
On 2016-12-13 01:41 AM, Dave Airlie wrote:<br>
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex">
From: Dave Airlie &lt;<a href=3D"mailto:airlied-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org" target=3D"_blan=
k">airlied-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org</a>&gt;<br>
<br>
Signed-off-by: Dave Airlie &lt;<a href=3D"mailto:airlied-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org" target=
=3D"_blank">airlied-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org</a>&gt;<br>
---<br>
=C2=A0drivers/gpu/drm/amd/display/a<wbr>mdgpu_dm/amdgpu_dm_services.c | 4 -=
---<br>
=C2=A01 file changed, 4 deletions(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/display/<wbr>amdgpu_dm/amdgpu_dm_services.=
c b/drivers/gpu/drm/amd/display/<wbr>amdgpu_dm/amdgpu_dm_services.c<br>
index 9d51259..9c852a3 100644<br>
--- a/drivers/gpu/drm/amd/display/<wbr>amdgpu_dm/amdgpu_dm_services.c<br>
+++ b/drivers/gpu/drm/amd/display/<wbr>amdgpu_dm/amdgpu_dm_services.c<br>
@@ -36,10 +36,6 @@<br>
=C2=A0#include &quot;amdgpu_dm_types.h&quot;<br>
=C2=A0#include &quot;amdgpu_pm.h&quot;<br>
<br>
-#define dm_alloc(size) kzalloc(size, GFP_KERNEL)<br>
-#define dm_realloc(ptr, size) krealloc(ptr, size, GFP_KERNEL)<br>
-#define dm_free(ptr) kfree(ptr)<br>
-<br>
=C2=A0/****************************<wbr>******************************<wbr>=
********************<br>
=C2=A0 * IRQ Interfaces.<br>
=C2=A0 ******************************<wbr>******************************<wb=
r>*****************/<br>
<br>
</blockquote></div><div class=3D"elided-text">
______________________________<wbr>_________________<br>
amd-gfx mailing list<br>
<a href=3D"mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" target=3D"_blank">amd-gfx@=
lists.freedesktop.org</a><br>
<a href=3D"https://lists.freedesktop.org/mailman/listinfo/amd-gfx" rel=3D"n=
oreferrer" target=3D"_blank">https://lists.freedesktop.org/<wbr>mailman/lis=
tinfo/amd-gfx</a><br>
</div></blockquote></div><br></div></div></div>

--001a1143915847d2f40543a4ae43--

--===============1212854423==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============1212854423==--
