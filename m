From: "Zhou, David(ChunMing)" <David1.Zhou-5C7GfCeVMHo@public.gmane.org>
Subject: Re:[PATCH] drm/amdgpu: enable bo priority setting from user space
Date: Thu, 7 Mar 2019 13:09:14 +0000
Message-ID: <-o8xodt-v7ma50s620vm-x3ufrzt16m3ru4l9qc4l8rct-ppumfj-lgzfos2xnj696p97zq-q88klx-1xor439yr648-3s2lfc-pglvz8-9du7dn8goc66-3zd1sv-cy6o2qkurchc-gpwxlg-c9iov0a657ue.1551963984191@email.android.com>
References: <20190307091528.22788-1-david1.zhou@amd.com>,
 <a1efec4e-0cb9-f92f-2688-ecfd4ed7ad12@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1177121068=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <a1efec4e-0cb9-f92f-2688-ecfd4ed7ad12-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
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
To: "Koenig, Christian" <Christian.Koenig-5C7GfCeVMHo@public.gmane.org>, "Zhou, David(ChunMing)" <David1.Zhou-5C7GfCeVMHo@public.gmane.org>, "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

--===============1177121068==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_o8xodtv7ma50s620vmx3ufrzt16m3ru4l9qc4l8rctppumfjlgzfos2_"

--_000_o8xodtv7ma50s620vmx3ufrzt16m3ru4l9qc4l8rctppumfjlgzfos2_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Yes, you are right, thanks to point it out. Will see if there is other way.

-David

send from my phone

-------- Original Message --------
Subject: Re: [PATCH] drm/amdgpu: enable bo priority setting from user space
From: Christian K=F6nig
To: "Zhou, David(ChunMing)" ,amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
CC:

Am 07.03.19 um 10:15 schrieb Chunming Zhou:
> Signed-off-by: Chunming Zhou <david1.zhou-5C7GfCeVMHo@public.gmane.org>

Well NAK to the whole approach.

The TTM priority is a global priority, but processes are only allowed to
specific the priority inside their own allocations. So this approach
will never fly upstream.

What you can do is to add a priority for per vm BOs to affect their sort
order on the LRU, but I doubt that this will have much of an effect.

Regards,
Christian.

> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_fb.c     |  1 +
>   drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c    | 13 +++++++++++++
>   drivers/gpu/drm/amd/amdgpu/amdgpu_gem.h    |  2 +-
>   drivers/gpu/drm/amd/amdgpu/amdgpu_object.c |  3 ++-
>   drivers/gpu/drm/amd/amdgpu/amdgpu_object.h |  1 +
>   include/drm/ttm/ttm_bo_driver.h            |  9 ++++++++-
>   include/uapi/drm/amdgpu_drm.h              |  3 +++
>   7 files changed, 29 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_fb.c b/drivers/gpu/drm/amd=
/amdgpu/amdgpu_fb.c
> index 5cbde74b97dd..70a6baf20c22 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_fb.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_fb.c
> @@ -144,6 +144,7 @@ static int amdgpufb_create_pinned_object(struct amdgp=
u_fbdev *rfbdev,
>        size =3D mode_cmd->pitches[0] * height;
>        aligned_size =3D ALIGN(size, PAGE_SIZE);
>        ret =3D amdgpu_gem_object_create(adev, aligned_size, 0, domain,
> +                                    TTM_BO_PRIORITY_NORMAL,
>                                       AMDGPU_GEM_CREATE_CPU_ACCESS_REQUIR=
ED |
>                                       AMDGPU_GEM_CREATE_VRAM_CONTIGUOUS |
>                                       AMDGPU_GEM_CREATE_VRAM_CLEARED,
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_gem.c
> index d21dd2f369da..7c1c2362c67e 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
> @@ -44,6 +44,7 @@ void amdgpu_gem_object_free(struct drm_gem_object *gobj=
)
>
>   int amdgpu_gem_object_create(struct amdgpu_device *adev, unsigned long =
size,
>                             int alignment, u32 initial_domain,
> +                          enum ttm_bo_priority priority,
>                             u64 flags, enum ttm_bo_type type,
>                             struct reservation_object *resv,
>                             struct drm_gem_object **obj)
> @@ -60,6 +61,7 @@ int amdgpu_gem_object_create(struct amdgpu_device *adev=
, unsigned long size,
>        bp.type =3D type;
>        bp.resv =3D resv;
>        bp.preferred_domain =3D initial_domain;
> +     bp.priority =3D priority;
>   retry:
>        bp.flags =3D flags;
>        bp.domain =3D initial_domain;
> @@ -229,6 +231,14 @@ int amdgpu_gem_create_ioctl(struct drm_device *dev, =
void *data,
>        if (args->in.domains & ~AMDGPU_GEM_DOMAIN_MASK)
>                return -EINVAL;
>
> +     /* check priority */
> +     if (args->in.priority =3D=3D 0) {
> +             /* default is normal */
> +             args->in.priority =3D TTM_BO_PRIORITY_NORMAL;
> +     } else if (args->in.priority > TTM_MAX_BO_PRIORITY) {
> +             args->in.priority =3D TTM_MAX_BO_PRIORITY;
> +             DRM_ERROR("priority specified from user space is over MAX p=
riority\n");
> +     }
>        /* create a gem object to contain this object in */
>        if (args->in.domains & (AMDGPU_GEM_DOMAIN_GDS |
>            AMDGPU_GEM_DOMAIN_GWS | AMDGPU_GEM_DOMAIN_OA)) {
> @@ -252,6 +262,7 @@ int amdgpu_gem_create_ioctl(struct drm_device *dev, v=
oid *data,
>
>        r =3D amdgpu_gem_object_create(adev, size, args->in.alignment,
>                                     (u32)(0xffffffff & args->in.domains),
> +                                  args->in.priority - 1,
>                                     flags, ttm_bo_type_device, resv, &gob=
j);
>        if (flags & AMDGPU_GEM_CREATE_VM_ALWAYS_VALID) {
>                if (!r) {
> @@ -304,6 +315,7 @@ int amdgpu_gem_userptr_ioctl(struct drm_device *dev, =
void *data,
>
>        /* create a gem object to contain this object in */
>        r =3D amdgpu_gem_object_create(adev, args->size, 0, AMDGPU_GEM_DOM=
AIN_CPU,
> +                                  TTM_BO_PRIORITY_NORMAL,
>                                     0, ttm_bo_type_device, NULL, &gobj);
>        if (r)
>                return r;
> @@ -755,6 +767,7 @@ int amdgpu_mode_dumb_create(struct drm_file *file_pri=
v,
>        domain =3D amdgpu_bo_get_preferred_pin_domain(adev,
>                                amdgpu_display_supported_domains(adev));
>        r =3D amdgpu_gem_object_create(adev, args->size, 0, domain,
> +                                  TTM_BO_PRIORITY_NORMAL,
>                                     AMDGPU_GEM_CREATE_CPU_ACCESS_REQUIRED=
,
>                                     ttm_bo_type_device, NULL, &gobj);
>        if (r)
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.h b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_gem.h
> index f1ddfc50bcc7..47b0a8190948 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.h
> @@ -61,7 +61,7 @@ extern const struct dma_buf_ops amdgpu_dmabuf_ops;
>    */
>   void amdgpu_gem_force_release(struct amdgpu_device *adev);
>   int amdgpu_gem_object_create(struct amdgpu_device *adev, unsigned long =
size,
> -                          int alignment, u32 initial_domain,
> +                          int alignment, u32 initial_domain, u32 priorit=
y,
>                             u64 flags, enum ttm_bo_type type,
>                             struct reservation_object *resv,
>                             struct drm_gem_object **obj);
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c b/drivers/gpu/drm=
/amd/amdgpu/amdgpu_object.c
> index fd9c4beeaaa4..c85304e03021 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
> @@ -494,8 +494,9 @@ static int amdgpu_bo_do_create(struct amdgpu_device *=
adev,
>
>        bo->tbo.bdev =3D &adev->mman.bdev;
>        amdgpu_bo_placement_from_domain(bo, bp->domain);
> +     bo->tbo.priority =3D bp->priority;
>        if (bp->type =3D=3D ttm_bo_type_kernel)
> -             bo->tbo.priority =3D 1;
> +             bo->tbo.priority =3D TTM_BO_PRIORITY_VERYHIGH;
>
>        r =3D ttm_bo_init_reserved(&adev->mman.bdev, &bo->tbo, size, bp->t=
ype,
>                                 &bo->placement, page_align, &ctx, acc_siz=
e,
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h b/drivers/gpu/drm=
/amd/amdgpu/amdgpu_object.h
> index 9291c2f837e9..091a7884a821 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h
> @@ -39,6 +39,7 @@ struct amdgpu_bo_param {
>        int                             byte_align;
>        u32                             domain;
>        u32                             preferred_domain;
> +     u32                             priority;
>        u64                             flags;
>        enum ttm_bo_type                type;
>        struct reservation_object       *resv;
> diff --git a/include/drm/ttm/ttm_bo_driver.h b/include/drm/ttm/ttm_bo_dri=
ver.h
> index cbf3180cb612..53f39ed540d7 100644
> --- a/include/drm/ttm/ttm_bo_driver.h
> +++ b/include/drm/ttm/ttm_bo_driver.h
> @@ -43,7 +43,14 @@
>   #include "ttm_placement.h"
>   #include "ttm_tt.h"
>
> -#define TTM_MAX_BO_PRIORITY  4U
> +enum ttm_bo_priority {
> +     TTM_BO_PRIORITY_VERYLOW =3D 0,
> +     TTM_BO_PRIORITY_LOW,
> +     TTM_BO_PRIORITY_NORMAL,
> +     TTM_BO_PRIORITY_HIGH,
> +     TTM_BO_PRIORITY_VERYHIGH,
> +     TTM_MAX_BO_PRIORITY
> +};
>
>   #define TTM_MEMTYPE_FLAG_FIXED         (1 << 0)     /* Fixed (on-card) =
PCI memory */
>   #define TTM_MEMTYPE_FLAG_MAPPABLE      (1 << 1)     /* Memory mappable =
*/
> diff --git a/include/uapi/drm/amdgpu_drm.h b/include/uapi/drm/amdgpu_drm.=
h
> index b7718bfdf8ad..b74a7583d7f3 100644
> --- a/include/uapi/drm/amdgpu_drm.h
> +++ b/include/uapi/drm/amdgpu_drm.h
> @@ -138,6 +138,9 @@ struct drm_amdgpu_gem_create_in  {
>        __u64 domains;
>        /** allocation flags */
>        __u64 domain_flags;
> +     /** priority */
> +     __u32 priority;
> +     __u32 pad;
>   };
>
>   struct drm_amdgpu_gem_create_out  {


--_000_o8xodtv7ma50s620vmx3ufrzt16m3ru4l9qc4l8rctppumfjlgzfos2_
Content-Type: text/html; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Diso-8859-=
1">
<meta name=3D"Generator" content=3D"Microsoft Exchange Server">
<!-- converted from text --><style><!-- .EmailQuote { margin-left: 1pt; pad=
ding-left: 4pt; border-left: #800000 2px solid; } --></style>
</head>
<body>
<div>Yes, you are right, thanks to point it out. Will see if there is other=
 way.<br>
<br>
-David<br>
<br>
send from my phone<br>
<br>
-------- Original Message --------<br>
Subject: Re: [PATCH] drm/amdgpu: enable bo priority setting from user space=
<br>
From: Christian K=F6nig <br>
To: &quot;Zhou, David(ChunMing)&quot; ,amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<br>
CC: <br>
<br>
</div>
<font size=3D"2"><span style=3D"font-size:11pt;">
<div class=3D"PlainText">Am 07.03.19 um 10:15 schrieb Chunming Zhou:<br>
&gt; Signed-off-by: Chunming Zhou &lt;david1.zhou-5C7GfCeVMHo@public.gmane.org&gt;<br>
<br>
Well NAK to the whole approach.<br>
<br>
The TTM priority is a global priority, but processes are only allowed to <b=
r>
specific the priority inside their own allocations. So this approach <br>
will never fly upstream.<br>
<br>
What you can do is to add a priority for per vm BOs to affect their sort <b=
r>
order on the LRU, but I doubt that this will have much of an effect.<br>
<br>
Regards,<br>
Christian.<br>
<br>
&gt; ---<br>
&gt;&nbsp;&nbsp; drivers/gpu/drm/amd/amdgpu/amdgpu_fb.c&nbsp;&nbsp;&nbsp;&n=
bsp; |&nbsp; 1 &#43;<br>
&gt;&nbsp;&nbsp; drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c&nbsp;&nbsp;&nbsp; =
| 13 &#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;<br>
&gt;&nbsp;&nbsp; drivers/gpu/drm/amd/amdgpu/amdgpu_gem.h&nbsp;&nbsp;&nbsp; =
|&nbsp; 2 &#43;-<br>
&gt;&nbsp;&nbsp; drivers/gpu/drm/amd/amdgpu/amdgpu_object.c |&nbsp; 3 &#43;=
&#43;-<br>
&gt;&nbsp;&nbsp; drivers/gpu/drm/amd/amdgpu/amdgpu_object.h |&nbsp; 1 &#43;=
<br>
&gt;&nbsp;&nbsp; include/drm/ttm/ttm_bo_driver.h&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp; 9 &#43;&#43;&#43;&#43;&#43;=
&#43;&#43;&#43;-<br>
&gt;&nbsp;&nbsp; include/uapi/drm/amdgpu_drm.h&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp; 3 &#43;&#43;&#43;=
<br>
&gt;&nbsp;&nbsp; 7 files changed, 29 insertions(&#43;), 3 deletions(-)<br>
&gt;<br>
&gt; diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_fb.c b/drivers/gpu/drm/=
amd/amdgpu/amdgpu_fb.c<br>
&gt; index 5cbde74b97dd..70a6baf20c22 100644<br>
&gt; --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_fb.c<br>
&gt; &#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/amdgpu_fb.c<br>
&gt; @@ -144,6 &#43;144,7 @@ static int amdgpufb_create_pinned_object(struc=
t amdgpu_fbdev *rfbdev,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; size =3D mode_cmd-&gt;pitche=
s[0] * height;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; aligned_size =3D ALIGN(size,=
 PAGE_SIZE);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D amdgpu_gem_object_cr=
eate(adev, aligned_size, 0, domain,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; TTM_=
BO_PRIORITY_NORMAL,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; AMDGPU_GEM_CREATE_CPU_ACCESS_REQUIRED |<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; AMDGPU_GEM_CREATE_VRAM_CONTIGUOUS |<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; AMDGPU_GEM_CREATE_VRAM_CLEARED,<br>
&gt; diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c b/drivers/gpu/drm=
/amd/amdgpu/amdgpu_gem.c<br>
&gt; index d21dd2f369da..7c1c2362c67e 100644<br>
&gt; --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c<br>
&gt; &#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c<br>
&gt; @@ -44,6 &#43;44,7 @@ void amdgpu_gem_object_free(struct drm_gem_objec=
t *gobj)<br>
&gt;&nbsp;&nbsp; <br>
&gt;&nbsp;&nbsp; int amdgpu_gem_object_create(struct amdgpu_device *adev, u=
nsigned long size,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp; int alignment, u32 initial_domain,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; enum ttm_bo_priority priority,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp; u64 flags, enum ttm_bo_type type,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp; struct reservation_object *resv,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp; struct drm_gem_object **obj)<br>
&gt; @@ -60,6 &#43;61,7 @@ int amdgpu_gem_object_create(struct amdgpu_devic=
e *adev, unsigned long size,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bp.type =3D type;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bp.resv =3D resv;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bp.preferred_domain =3D init=
ial_domain;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; bp.priority =3D priority;<br>
&gt;&nbsp;&nbsp; retry:<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bp.flags =3D flags;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bp.domain =3D initial_domain=
;<br>
&gt; @@ -229,6 &#43;231,14 @@ int amdgpu_gem_create_ioctl(struct drm_device=
 *dev, void *data,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (args-&gt;in.domains &amp=
; ~AMDGPU_GEM_DOMAIN_MASK)<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; return -EINVAL;<br>
&gt;&nbsp;&nbsp; <br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; /* check priority */<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; if (args-&gt;in.priority =3D=3D 0) {<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; /* default is normal */<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; args-&gt;in.priority =3D TTM_BO_PRIORITY_NORMAL;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; } else if (args-&gt;in.priority &gt; TTM=
_MAX_BO_PRIORITY) {<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; args-&gt;in.priority =3D TTM_MAX_BO_PRIORITY;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; DRM_ERROR(&quot;priority specified from user space is over MAX prio=
rity\n&quot;);<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* create a gem object to co=
ntain this object in */<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (args-&gt;in.domains &amp=
; (AMDGPU_GEM_DOMAIN_GDS |<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; AMDG=
PU_GEM_DOMAIN_GWS | AMDGPU_GEM_DOMAIN_OA)) {<br>
&gt; @@ -252,6 &#43;262,7 @@ int amdgpu_gem_create_ioctl(struct drm_device =
*dev, void *data,<br>
&gt;&nbsp;&nbsp; <br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; r =3D amdgpu_gem_object_crea=
te(adev, size, args-&gt;in.alignment,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (u32=
)(0xffffffff &amp; args-&gt;in.domains),<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; args-&gt;in.prio=
rity - 1,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; flag=
s, ttm_bo_type_device, resv, &amp;gobj);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (flags &amp; AMDGPU_GEM_C=
REATE_VM_ALWAYS_VALID) {<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; if (!r) {<br>
&gt; @@ -304,6 &#43;315,7 @@ int amdgpu_gem_userptr_ioctl(struct drm_device=
 *dev, void *data,<br>
&gt;&nbsp;&nbsp; <br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* create a gem object to co=
ntain this object in */<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; r =3D amdgpu_gem_object_crea=
te(adev, args-&gt;size, 0, AMDGPU_GEM_DOMAIN_CPU,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; TTM_BO_PRIORITY_=
NORMAL,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0, t=
tm_bo_type_device, NULL, &amp;gobj);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (r)<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; return r;<br>
&gt; @@ -755,6 &#43;767,7 @@ int amdgpu_mode_dumb_create(struct drm_file *f=
ile_priv,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; domain =3D amdgpu_bo_get_pre=
ferred_pin_domain(adev,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_display_supported_domains(a=
dev));<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; r =3D amdgpu_gem_object_crea=
te(adev, args-&gt;size, 0, domain,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; TTM_BO_PRIORITY_=
NORMAL,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; AMDG=
PU_GEM_CREATE_CPU_ACCESS_REQUIRED,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ttm_=
bo_type_device, NULL, &amp;gobj);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (r)<br>
&gt; diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.h b/drivers/gpu/drm=
/amd/amdgpu/amdgpu_gem.h<br>
&gt; index f1ddfc50bcc7..47b0a8190948 100644<br>
&gt; --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.h<br>
&gt; &#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.h<br>
&gt; @@ -61,7 &#43;61,7 @@ extern const struct dma_buf_ops amdgpu_dmabuf_op=
s;<br>
&gt;&nbsp;&nbsp;&nbsp; */<br>
&gt;&nbsp;&nbsp; void amdgpu_gem_force_release(struct amdgpu_device *adev);=
<br>
&gt;&nbsp;&nbsp; int amdgpu_gem_object_create(struct amdgpu_device *adev, u=
nsigned long size,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; int alignment, u32 initial_domain,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; int alignment, u32 initial_domain, u32 priority,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp; u64 flags, enum ttm_bo_type type,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp; struct reservation_object *resv,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp; struct drm_gem_object **obj);<br>
&gt; diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c b/drivers/gpu/=
drm/amd/amdgpu/amdgpu_object.c<br>
&gt; index fd9c4beeaaa4..c85304e03021 100644<br>
&gt; --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c<br>
&gt; &#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c<br>
&gt; @@ -494,8 &#43;494,9 @@ static int amdgpu_bo_do_create(struct amdgpu_d=
evice *adev,<br>
&gt;&nbsp;&nbsp; <br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bo-&gt;tbo.bdev =3D &amp;ade=
v-&gt;mman.bdev;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_bo_placement_from_dom=
ain(bo, bp-&gt;domain);<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; bo-&gt;tbo.priority =3D bp-&gt;priority;=
<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (bp-&gt;type =3D=3D ttm_b=
o_type_kernel)<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; bo-&gt;tbo.priority =3D 1;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; bo-&gt;tbo.priority =3D TTM_BO_PRIORITY_VERYHIGH;<br>
&gt;&nbsp;&nbsp; <br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; r =3D ttm_bo_init_reserved(&=
amp;adev-&gt;mman.bdev, &amp;bo-&gt;tbo, size, bp-&gt;type,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &amp;bo-&gt;placement, page_=
align, &amp;ctx, acc_size,<br>
&gt; diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h b/drivers/gpu/=
drm/amd/amdgpu/amdgpu_object.h<br>
&gt; index 9291c2f837e9..091a7884a821 100644<br>
&gt; --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h<br>
&gt; &#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h<br>
&gt; @@ -39,6 &#43;39,7 @@ struct amdgpu_bo_param {<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; byte_a=
lign;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; u32&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; domain=
;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; u32&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; prefer=
red_domain;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; u32&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; priority;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; u64&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; flags;=
<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; enum ttm_bo_type&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; type;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct reservation_object&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *resv;<br>
&gt; diff --git a/include/drm/ttm/ttm_bo_driver.h b/include/drm/ttm/ttm_bo_=
driver.h<br>
&gt; index cbf3180cb612..53f39ed540d7 100644<br>
&gt; --- a/include/drm/ttm/ttm_bo_driver.h<br>
&gt; &#43;&#43;&#43; b/include/drm/ttm/ttm_bo_driver.h<br>
&gt; @@ -43,7 &#43;43,14 @@<br>
&gt;&nbsp;&nbsp; #include &quot;ttm_placement.h&quot;<br>
&gt;&nbsp;&nbsp; #include &quot;ttm_tt.h&quot;<br>
&gt;&nbsp;&nbsp; <br>
&gt; -#define TTM_MAX_BO_PRIORITY&nbsp; 4U<br>
&gt; &#43;enum ttm_bo_priority {<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; TTM_BO_PRIORITY_VERYLOW =3D 0,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; TTM_BO_PRIORITY_LOW,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; TTM_BO_PRIORITY_NORMAL,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; TTM_BO_PRIORITY_HIGH,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; TTM_BO_PRIORITY_VERYHIGH,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; TTM_MAX_BO_PRIORITY<br>
&gt; &#43;};<br>
&gt;&nbsp;&nbsp; <br>
&gt;&nbsp;&nbsp; #define TTM_MEMTYPE_FLAG_FIXED&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp; (1 &lt;&lt; 0)&nbsp;&nbsp;&nbsp;&nbsp; /* Fixed (on-ca=
rd) PCI memory */<br>
&gt;&nbsp;&nbsp; #define TTM_MEMTYPE_FLAG_MAPPABLE&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp; (1 &lt;&lt; 1)&nbsp;&nbsp;&nbsp;&nbsp; /* Memory mappable */<br>
&gt; diff --git a/include/uapi/drm/amdgpu_drm.h b/include/uapi/drm/amdgpu_d=
rm.h<br>
&gt; index b7718bfdf8ad..b74a7583d7f3 100644<br>
&gt; --- a/include/uapi/drm/amdgpu_drm.h<br>
&gt; &#43;&#43;&#43; b/include/uapi/drm/amdgpu_drm.h<br>
&gt; @@ -138,6 &#43;138,9 @@ struct drm_amdgpu_gem_create_in&nbsp; {<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; __u64 domains;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /** allocation flags */<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; __u64 domain_flags;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; /** priority */<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; __u32 priority;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; __u32 pad;<br>
&gt;&nbsp;&nbsp; };<br>
&gt;&nbsp;&nbsp; <br>
&gt;&nbsp;&nbsp; struct drm_amdgpu_gem_create_out&nbsp; {<br>
<br>
</div>
</span></font>
</body>
</html>

--_000_o8xodtv7ma50s620vmx3ufrzt16m3ru4l9qc4l8rctppumfjlgzfos2_--

--===============1177121068==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4

--===============1177121068==--
