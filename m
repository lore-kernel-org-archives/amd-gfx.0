From: Mike Lothian <mike-4+n8WJKc9ve9FHfhHBbuYA@public.gmane.org>
Subject: Re: [PATCH] drm/amdgpu: Attach exclusive fence to prime exported
 bo's. (v5)
Date: Sun, 13 Nov 2016 15:30:31 +0000
Message-ID: <CAHbf0-G_nwEXO=nGDg1EmzGBXVKF7_syFGuC_QQJ3UMbww8sHg@mail.gmail.com>
References: <1478654715-22334-1-git-send-email-mario.kleiner.de@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0185586754=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <1478654715-22334-1-git-send-email-mario.kleiner.de-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
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
To: Mario Kleiner <mario.kleiner.de-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Cc: =?UTF-8?Q?Michel_D=C3=A4nzer?= <michel.daenzer-5C7GfCeVMHo@public.gmane.org>, =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig-5C7GfCeVMHo@public.gmane.org>, amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org

--===============0185586754==
Content-Type: multipart/alternative; boundary=001a114425d6fdac990541306786

--001a114425d6fdac990541306786
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi

I've tested this version now - works great

Thanks

Mike

On Wed, 9 Nov 2016 at 01:26 Mario Kleiner <mario.kleiner.de-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
wrote:

> External clients which import our bo's wait only
> for exclusive dmabuf-fences, not on shared ones,
> ditto for bo's which we import from external
> providers and write to.
>
> Therefore attach exclusive fences on prime shared buffers
> if our exported buffer gets imported by an external
> client, or if we import a buffer from an external
> exporter.
>
> See discussion in thread:
> https://lists.freedesktop.org/archives/dri-devel/2016-October/122370.html
>
> Prime export tested on Intel iGPU + AMD Tonga dGPU as
> DRI3/Present Prime render offload, and with the Tonga
> standalone as primary gpu.
>
> v2: Add a wait for all shared fences before prime export,
>     as suggested by Christian Koenig.
>
> v3: - Mark buffer prime_exported in amdgpu_gem_prime_pin,
>     so we only use the exclusive fence when exporting a
>     bo to external clients like a separate iGPU, but not
>     when exporting/importing from/to ourselves as part of
>     regular DRI3 fd passing.
>
>     - Propagate failure of reservation_object_wait_rcu back
>     to caller.
>
> v4: - Switch to a prime_shared_count counter instead of a
>       flag, which gets in/decremented on prime_pin/unpin, so
>       we can switch back to shared fences if all clients
>       detach from our exported bo.
>
>     - Also switch to exclusive fence for prime imported bo's.
>
> v5: - Drop lret, instead use int ret -> long ret, as proposed
>       by Christian.
>
> Bugzilla: https://bugs.freedesktop.org/show_bug.cgi?id=3D95472
> Tested-by: Mike Lothian <mike-4+n8WJKc9ve9FHfhHBbuYA@public.gmane.org> (v1)
> Signed-off-by: Mario Kleiner <mario.kleiner.de-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> Reviewed-by: Christian K=C3=B6nig <christian.koenig-5C7GfCeVMHo@public.gmane.org>.
> Cc: Christian K=C3=B6nig <christian.koenig-5C7GfCeVMHo@public.gmane.org>
> Cc: Michel D=C3=A4nzer <michel.daenzer-5C7GfCeVMHo@public.gmane.org>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu.h         |  1 +
>  drivers/gpu/drm/amd/amdgpu/amdgpu_bo_list.c |  2 +-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_prime.c   | 20 +++++++++++++++++++-
>  3 files changed, 21 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> index 039b57e..496f72b 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> @@ -459,6 +459,7 @@ struct amdgpu_bo {
>         u64                             metadata_flags;
>         void                            *metadata;
>         u32                             metadata_size;
> +       unsigned                        prime_shared_count;
>         /* list of all virtual address to which this bo
>          * is associated to
>          */
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_bo_list.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_bo_list.c
> index 651115d..c02db01f6 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_bo_list.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_bo_list.c
> @@ -132,7 +132,7 @@ static int amdgpu_bo_list_set(struct amdgpu_device
> *adev,
>                 entry->priority =3D min(info[i].bo_priority,
>                                       AMDGPU_BO_LIST_MAX_PRIORITY);
>                 entry->tv.bo =3D &entry->robj->tbo;
> -               entry->tv.shared =3D true;
> +               entry->tv.shared =3D !entry->robj->prime_shared_count;
>
>                 if (entry->robj->prefered_domains =3D=3D AMDGPU_GEM_DOMAI=
N_GDS)
>                         gds_obj =3D entry->robj;
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_prime.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_prime.c
> index 7700dc2..3826d5a 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_prime.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_prime.c
> @@ -74,20 +74,36 @@ amdgpu_gem_prime_import_sg_table(struct drm_device
> *dev,
>         if (ret)
>                 return ERR_PTR(ret);
>
> +       bo->prime_shared_count =3D 1;
>         return &bo->gem_base;
>  }
>
>  int amdgpu_gem_prime_pin(struct drm_gem_object *obj)
>  {
>         struct amdgpu_bo *bo =3D gem_to_amdgpu_bo(obj);
> -       int ret =3D 0;
> +       long ret =3D 0;
>
>         ret =3D amdgpu_bo_reserve(bo, false);
>         if (unlikely(ret !=3D 0))
>                 return ret;
>
> +       /*
> +        * Wait for all shared fences to complete before we switch to
> future
> +        * use of exclusive fence on this prime shared bo.
> +        */
> +       ret =3D reservation_object_wait_timeout_rcu(bo->tbo.resv, true,
> false,
> +                                                 MAX_SCHEDULE_TIMEOUT);
> +       if (unlikely(ret < 0)) {
> +               DRM_DEBUG_PRIME("Fence wait failed: %li\n", ret);
> +               amdgpu_bo_unreserve(bo);
> +               return ret;
> +       }
> +
>         /* pin buffer into GTT */
>         ret =3D amdgpu_bo_pin(bo, AMDGPU_GEM_DOMAIN_GTT, NULL);
> +       if (likely(ret =3D=3D 0))
> +               bo->prime_shared_count++;
> +
>         amdgpu_bo_unreserve(bo);
>         return ret;
>  }
> @@ -102,6 +118,8 @@ void amdgpu_gem_prime_unpin(struct drm_gem_object *ob=
j)
>                 return;
>
>         amdgpu_bo_unpin(bo);
> +       if (bo->prime_shared_count)
> +               bo->prime_shared_count--;
>         amdgpu_bo_unreserve(bo);
>  }
>
> --
> 2.7.0
>
> _______________________________________________
> dri-devel mailing list
> dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
>

--001a114425d6fdac990541306786
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi<div><br></div><div>I&#39;ve tested this version now - w=
orks great</div><div><br></div><div>Thanks</div><div><br></div><div>Mike<br=
><br><div class=3D"gmail_quote"><div dir=3D"ltr">On Wed, 9 Nov 2016 at 01:2=
6 Mario Kleiner &lt;<a href=3D"mailto:mario.kleiner.de-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org">mario.kle=
iner.de-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote"=
 style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">Ex=
ternal clients which import our bo&#39;s wait only<br class=3D"gmail_msg">
for exclusive dmabuf-fences, not on shared ones,<br class=3D"gmail_msg">
ditto for bo&#39;s which we import from external<br class=3D"gmail_msg">
providers and write to.<br class=3D"gmail_msg">
<br class=3D"gmail_msg">
Therefore attach exclusive fences on prime shared buffers<br class=3D"gmail=
_msg">
if our exported buffer gets imported by an external<br class=3D"gmail_msg">
client, or if we import a buffer from an external<br class=3D"gmail_msg">
exporter.<br class=3D"gmail_msg">
<br class=3D"gmail_msg">
See discussion in thread:<br class=3D"gmail_msg">
<a href=3D"https://lists.freedesktop.org/archives/dri-devel/2016-October/12=
2370.html" rel=3D"noreferrer" class=3D"gmail_msg" target=3D"_blank">https:/=
/lists.freedesktop.org/archives/dri-devel/2016-October/122370.html</a><br c=
lass=3D"gmail_msg">
<br class=3D"gmail_msg">
Prime export tested on Intel iGPU + AMD Tonga dGPU as<br class=3D"gmail_msg=
">
DRI3/Present Prime render offload, and with the Tonga<br class=3D"gmail_msg=
">
standalone as primary gpu.<br class=3D"gmail_msg">
<br class=3D"gmail_msg">
v2: Add a wait for all shared fences before prime export,<br class=3D"gmail=
_msg">
=C2=A0 =C2=A0 as suggested by Christian Koenig.<br class=3D"gmail_msg">
<br class=3D"gmail_msg">
v3: - Mark buffer prime_exported in amdgpu_gem_prime_pin,<br class=3D"gmail=
_msg">
=C2=A0 =C2=A0 so we only use the exclusive fence when exporting a<br class=
=3D"gmail_msg">
=C2=A0 =C2=A0 bo to external clients like a separate iGPU, but not<br class=
=3D"gmail_msg">
=C2=A0 =C2=A0 when exporting/importing from/to ourselves as part of<br clas=
s=3D"gmail_msg">
=C2=A0 =C2=A0 regular DRI3 fd passing.<br class=3D"gmail_msg">
<br class=3D"gmail_msg">
=C2=A0 =C2=A0 - Propagate failure of reservation_object_wait_rcu back<br cl=
ass=3D"gmail_msg">
=C2=A0 =C2=A0 to caller.<br class=3D"gmail_msg">
<br class=3D"gmail_msg">
v4: - Switch to a prime_shared_count counter instead of a<br class=3D"gmail=
_msg">
=C2=A0 =C2=A0 =C2=A0 flag, which gets in/decremented on prime_pin/unpin, so=
<br class=3D"gmail_msg">
=C2=A0 =C2=A0 =C2=A0 we can switch back to shared fences if all clients<br =
class=3D"gmail_msg">
=C2=A0 =C2=A0 =C2=A0 detach from our exported bo.<br class=3D"gmail_msg">
<br class=3D"gmail_msg">
=C2=A0 =C2=A0 - Also switch to exclusive fence for prime imported bo&#39;s.=
<br class=3D"gmail_msg">
<br class=3D"gmail_msg">
v5: - Drop lret, instead use int ret -&gt; long ret, as proposed<br class=
=3D"gmail_msg">
=C2=A0 =C2=A0 =C2=A0 by Christian.<br class=3D"gmail_msg">
<br class=3D"gmail_msg">
Bugzilla: <a href=3D"https://bugs.freedesktop.org/show_bug.cgi?id=3D95472" =
rel=3D"noreferrer" class=3D"gmail_msg" target=3D"_blank">https://bugs.freed=
esktop.org/show_bug.cgi?id=3D95472</a><br class=3D"gmail_msg">
Tested-by: Mike Lothian &lt;<a href=3D"mailto:mike-4+n8WJKc9ve9FHfhHBbuYA@public.gmane.org" class=3D=
"gmail_msg" target=3D"_blank">mike-4+n8WJKc9ve9FHfhHBbuYA@public.gmane.org</a>&gt; (v1)<br class=3D"=
gmail_msg">
Signed-off-by: Mario Kleiner &lt;<a href=3D"mailto:mario.kleiner.de@gmail.c=
om" class=3D"gmail_msg" target=3D"_blank">mario.kleiner.de-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org</a>&gt=
;<br class=3D"gmail_msg">
Reviewed-by: Christian K=C3=B6nig &lt;<a href=3D"mailto:christian.koenig@am=
d.com" class=3D"gmail_msg" target=3D"_blank">christian.koenig-5C7GfCeVMHo@public.gmane.org</a>&g=
t;.<br class=3D"gmail_msg">
Cc: Christian K=C3=B6nig &lt;<a href=3D"mailto:christian.koenig-5C7GfCeVMHo@public.gmane.org" cl=
ass=3D"gmail_msg" target=3D"_blank">christian.koenig-5C7GfCeVMHo@public.gmane.org</a>&gt;<br cla=
ss=3D"gmail_msg">
Cc: Michel D=C3=A4nzer &lt;<a href=3D"mailto:michel.daenzer-5C7GfCeVMHo@public.gmane.org" class=
=3D"gmail_msg" target=3D"_blank">michel.daenzer-5C7GfCeVMHo@public.gmane.org</a>&gt;<br class=3D=
"gmail_msg">
---<br class=3D"gmail_msg">
=C2=A0drivers/gpu/drm/amd/amdgpu/amdgpu.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
|=C2=A0 1 +<br class=3D"gmail_msg">
=C2=A0drivers/gpu/drm/amd/amdgpu/amdgpu_bo_list.c |=C2=A0 2 +-<br class=3D"=
gmail_msg">
=C2=A0drivers/gpu/drm/amd/amdgpu/amdgpu_prime.c=C2=A0 =C2=A0| 20 ++++++++++=
+++++++++-<br class=3D"gmail_msg">
=C2=A03 files changed, 21 insertions(+), 2 deletions(-)<br class=3D"gmail_m=
sg">
<br class=3D"gmail_msg">
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdg=
pu/amdgpu.h<br class=3D"gmail_msg">
index 039b57e..496f72b 100644<br class=3D"gmail_msg">
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h<br class=3D"gmail_msg">
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h<br class=3D"gmail_msg">
@@ -459,6 +459,7 @@ struct amdgpu_bo {<br class=3D"gmail_msg">
=C2=A0 =C2=A0 =C2=A0 =C2=A0 u64=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0metadata_flag=
s;<br class=3D"gmail_msg">
=C2=A0 =C2=A0 =C2=A0 =C2=A0 void=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 *metadata;<br class=
=3D"gmail_msg">
=C2=A0 =C2=A0 =C2=A0 =C2=A0 u32=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0metadata_size=
;<br class=3D"gmail_msg">
+=C2=A0 =C2=A0 =C2=A0 =C2=A0unsigned=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 prime_shared_count;<br class=
=3D"gmail_msg">
=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* list of all virtual address to which this bo=
<br class=3D"gmail_msg">
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* is associated to<br class=3D"gmail_msg"=
>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0*/<br class=3D"gmail_msg">
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_bo_list.c b/drivers/gpu/drm/=
amd/amdgpu/amdgpu_bo_list.c<br class=3D"gmail_msg">
index 651115d..c02db01f6 100644<br class=3D"gmail_msg">
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_bo_list.c<br class=3D"gmail_msg">
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_bo_list.c<br class=3D"gmail_msg">
@@ -132,7 +132,7 @@ static int amdgpu_bo_list_set(struct amdgpu_device *ade=
v,<br class=3D"gmail_msg">
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 entry-&gt;priority =
=3D min(info[i].bo_priority,<br class=3D"gmail_msg">
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 AMDGPU_BO_LIST_=
MAX_PRIORITY);<br class=3D"gmail_msg">
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 entry-&gt;<a href=
=3D"http://tv.bo" rel=3D"noreferrer" class=3D"gmail_msg" target=3D"_blank">=
tv.bo</a> =3D &amp;entry-&gt;robj-&gt;tbo;<br class=3D"gmail_msg">
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0entry-&gt;tv.shared=
 =3D true;<br class=3D"gmail_msg">
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0entry-&gt;tv.shared=
 =3D !entry-&gt;robj-&gt;prime_shared_count;<br class=3D"gmail_msg">
<br class=3D"gmail_msg">
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (entry-&gt;robj-=
&gt;prefered_domains =3D=3D AMDGPU_GEM_DOMAIN_GDS)<br class=3D"gmail_msg">
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 gds_obj =3D entry-&gt;robj;<br class=3D"gmail_msg">
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_prime.c b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_prime.c<br class=3D"gmail_msg">
index 7700dc2..3826d5a 100644<br class=3D"gmail_msg">
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_prime.c<br class=3D"gmail_msg">
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_prime.c<br class=3D"gmail_msg">
@@ -74,20 +74,36 @@ amdgpu_gem_prime_import_sg_table(struct drm_device *dev=
,<br class=3D"gmail_msg">
=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (ret)<br class=3D"gmail_msg">
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return ERR_PTR(ret)=
;<br class=3D"gmail_msg">
<br class=3D"gmail_msg">
+=C2=A0 =C2=A0 =C2=A0 =C2=A0bo-&gt;prime_shared_count =3D 1;<br class=3D"gm=
ail_msg">
=C2=A0 =C2=A0 =C2=A0 =C2=A0 return &amp;bo-&gt;gem_base;<br class=3D"gmail_=
msg">
=C2=A0}<br class=3D"gmail_msg">
<br class=3D"gmail_msg">
=C2=A0int amdgpu_gem_prime_pin(struct drm_gem_object *obj)<br class=3D"gmai=
l_msg">
=C2=A0{<br class=3D"gmail_msg">
=C2=A0 =C2=A0 =C2=A0 =C2=A0 struct amdgpu_bo *bo =3D gem_to_amdgpu_bo(obj);=
<br class=3D"gmail_msg">
-=C2=A0 =C2=A0 =C2=A0 =C2=A0int ret =3D 0;<br class=3D"gmail_msg">
+=C2=A0 =C2=A0 =C2=A0 =C2=A0long ret =3D 0;<br class=3D"gmail_msg">
<br class=3D"gmail_msg">
=C2=A0 =C2=A0 =C2=A0 =C2=A0 ret =3D amdgpu_bo_reserve(bo, false);<br class=
=3D"gmail_msg">
=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (unlikely(ret !=3D 0))<br class=3D"gmail_msg=
">
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return ret;<br clas=
s=3D"gmail_msg">
<br class=3D"gmail_msg">
+=C2=A0 =C2=A0 =C2=A0 =C2=A0/*<br class=3D"gmail_msg">
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 * Wait for all shared fences to complete befor=
e we switch to future<br class=3D"gmail_msg">
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 * use of exclusive fence on this prime shared =
bo.<br class=3D"gmail_msg">
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 */<br class=3D"gmail_msg">
+=C2=A0 =C2=A0 =C2=A0 =C2=A0ret =3D reservation_object_wait_timeout_rcu(bo-=
&gt;tbo.resv, true, false,<br class=3D"gmail_msg">
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0MAX_SCHEDULE_TIMEOUT);<br class=3D"gmail_msg">
+=C2=A0 =C2=A0 =C2=A0 =C2=A0if (unlikely(ret &lt; 0)) {<br class=3D"gmail_m=
sg">
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0DRM_DEBUG_PRIME(&qu=
ot;Fence wait failed: %li\n&quot;, ret);<br class=3D"gmail_msg">
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0amdgpu_bo_unreserve=
(bo);<br class=3D"gmail_msg">
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return ret;<br clas=
s=3D"gmail_msg">
+=C2=A0 =C2=A0 =C2=A0 =C2=A0}<br class=3D"gmail_msg">
+<br class=3D"gmail_msg">
=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* pin buffer into GTT */<br class=3D"gmail_msg=
">
=C2=A0 =C2=A0 =C2=A0 =C2=A0 ret =3D amdgpu_bo_pin(bo, AMDGPU_GEM_DOMAIN_GTT=
, NULL);<br class=3D"gmail_msg">
+=C2=A0 =C2=A0 =C2=A0 =C2=A0if (likely(ret =3D=3D 0))<br class=3D"gmail_msg=
">
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0bo-&gt;prime_shared=
_count++;<br class=3D"gmail_msg">
+<br class=3D"gmail_msg">
=C2=A0 =C2=A0 =C2=A0 =C2=A0 amdgpu_bo_unreserve(bo);<br class=3D"gmail_msg"=
>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 return ret;<br class=3D"gmail_msg">
=C2=A0}<br class=3D"gmail_msg">
@@ -102,6 +118,8 @@ void amdgpu_gem_prime_unpin(struct drm_gem_object *obj)=
<br class=3D"gmail_msg">
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return;<br class=3D=
"gmail_msg">
<br class=3D"gmail_msg">
=C2=A0 =C2=A0 =C2=A0 =C2=A0 amdgpu_bo_unpin(bo);<br class=3D"gmail_msg">
+=C2=A0 =C2=A0 =C2=A0 =C2=A0if (bo-&gt;prime_shared_count)<br class=3D"gmai=
l_msg">
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0bo-&gt;prime_shared=
_count--;<br class=3D"gmail_msg">
=C2=A0 =C2=A0 =C2=A0 =C2=A0 amdgpu_bo_unreserve(bo);<br class=3D"gmail_msg"=
>
=C2=A0}<br class=3D"gmail_msg">
<br class=3D"gmail_msg">
--<br class=3D"gmail_msg">
2.7.0<br class=3D"gmail_msg">
<br class=3D"gmail_msg">
_______________________________________________<br class=3D"gmail_msg">
dri-devel mailing list<br class=3D"gmail_msg">
<a href=3D"mailto:dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" class=3D"gmail_msg" targ=
et=3D"_blank">dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org</a><br class=3D"gmail_msg">
<a href=3D"https://lists.freedesktop.org/mailman/listinfo/dri-devel" rel=3D=
"noreferrer" class=3D"gmail_msg" target=3D"_blank">https://lists.freedeskto=
p.org/mailman/listinfo/dri-devel</a><br class=3D"gmail_msg">
</blockquote></div></div></div>

--001a114425d6fdac990541306786--

--===============0185586754==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============0185586754==--
