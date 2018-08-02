From: Nayan Deshmukh <nayan26deshmukh@gmail.com>
Subject: Re: [PATCH] drm/scheduler: fix setting the priorty for entities
Date: Thu, 2 Aug 2018 13:34:41 +0530
Message-ID: <CAFd4ddzhX6BhdzTwWxhqw1NaPaUczMozMEt6FEYAJ0iFt2hbEA@mail.gmail.com>
References: <20180801142739.50825-1-christian.koenig@amd.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0829674871=="
Return-path: <dri-devel-bounces@lists.freedesktop.org>
In-Reply-To: <20180801142739.50825-1-christian.koenig@amd.com>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
To: ckoenig.leichtzumerken@gmail.com
Cc: amd-gfx@lists.freedesktop.org, Maling list - DRI developers <dri-devel@lists.freedesktop.org>
List-Id: amd-gfx.lists.freedesktop.org

--===============0829674871==
Content-Type: multipart/alternative; boundary="000000000000293fe905726f4660"

--000000000000293fe905726f4660
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 1, 2018 at 7:58 PM Christian K=C3=B6nig <
ckoenig.leichtzumerken@gmail.com> wrote:

> Since we now deal with multiple rq we need to update all of them, not
> just the current one.
>
> Signed-off-by: Christian K=C3=B6nig <christian.koenig@amd.com>
>
Acked-by: Nayan Deshmukh <nayan26deshmukh@gmail.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c   |  3 +--
>  drivers/gpu/drm/scheduler/gpu_scheduler.c | 36
> ++++++++++++++++++++-----------
>  include/drm/gpu_scheduler.h               |  5 ++---
>  3 files changed, 26 insertions(+), 18 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
> index df6965761046..9fcc14e2dfcf 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
> @@ -407,12 +407,11 @@ void amdgpu_ctx_priority_override(struct amdgpu_ctx
> *ctx,
>         for (i =3D 0; i < adev->num_rings; i++) {
>                 ring =3D adev->rings[i];
>                 entity =3D &ctx->rings[i].entity;
> -               rq =3D &ring->sched.sched_rq[ctx_prio];
>
>                 if (ring->funcs->type =3D=3D AMDGPU_RING_TYPE_KIQ)
>                         continue;
>
> -               drm_sched_entity_set_rq(entity, rq);
> +               drm_sched_entity_set_priority(entity, ctx_prio);
>         }
>  }
>
> diff --git a/drivers/gpu/drm/scheduler/gpu_scheduler.c
> b/drivers/gpu/drm/scheduler/gpu_scheduler.c
> index 05dc6ecd4003..85908c7f913e 100644
> --- a/drivers/gpu/drm/scheduler/gpu_scheduler.c
> +++ b/drivers/gpu/drm/scheduler/gpu_scheduler.c
> @@ -419,29 +419,39 @@ static void drm_sched_entity_clear_dep(struct
> dma_fence *f, struct dma_fence_cb
>  }
>
>  /**
> - * drm_sched_entity_set_rq - Sets the run queue for an entity
> + * drm_sched_entity_set_rq_priority - helper for
> drm_sched_entity_set_priority
> + */
> +static void drm_sched_entity_set_rq_priority(struct drm_sched_rq **rq,
> +                                            enum drm_sched_priority
> priority)
> +{
> +       *rq =3D &(*rq)->sched->sched_rq[priority];
> +}
> +
> +/**
> + * drm_sched_entity_set_priority - Sets priority of the entity
>   *
>   * @entity: scheduler entity
> - * @rq: scheduler run queue
> + * @priority: scheduler priority
>   *
> - * Sets the run queue for an entity and removes the entity from the
> previous
> - * run queue in which was present.
> + * Update the priority of runqueus used for the entity.
>   */
> -void drm_sched_entity_set_rq(struct drm_sched_entity *entity,
> -                            struct drm_sched_rq *rq)
> +void drm_sched_entity_set_priority(struct drm_sched_entity *entity,
> +                                  enum drm_sched_priority priority)
>  {
> -       if (entity->rq =3D=3D rq)
> -               return;
> -
> -       BUG_ON(!rq);
> +       unsigned int i;
>
>         spin_lock(&entity->rq_lock);
> +
> +       for (i =3D 0; i < entity->num_rq_list; ++i)
> +               drm_sched_entity_set_rq_priority(&entity->rq_list[i],
> priority);
> +
>         drm_sched_rq_remove_entity(entity->rq, entity);
> -       entity->rq =3D rq;
> -       drm_sched_rq_add_entity(rq, entity);
> +       drm_sched_entity_set_rq_priority(&entity->rq, priority);
> +       drm_sched_rq_add_entity(entity->rq, entity);
> +
>         spin_unlock(&entity->rq_lock);
>  }
> -EXPORT_SYMBOL(drm_sched_entity_set_rq);
> +EXPORT_SYMBOL(drm_sched_entity_set_priority);
>
>  /**
>   * drm_sched_dependency_optimized
> diff --git a/include/drm/gpu_scheduler.h b/include/drm/gpu_scheduler.h
> index 0c4cfe689d4c..22c0f88f7d8f 100644
> --- a/include/drm/gpu_scheduler.h
> +++ b/include/drm/gpu_scheduler.h
> @@ -298,9 +298,8 @@ void drm_sched_entity_fini(struct drm_sched_entity
> *entity);
>  void drm_sched_entity_destroy(struct drm_sched_entity *entity);
>  void drm_sched_entity_push_job(struct drm_sched_job *sched_job,
>                                struct drm_sched_entity *entity);
> -void drm_sched_entity_set_rq(struct drm_sched_entity *entity,
> -                            struct drm_sched_rq *rq);
> -
> +void drm_sched_entity_set_priority(struct drm_sched_entity *entity,
> +                                  enum drm_sched_priority priority);
>  struct drm_sched_fence *drm_sched_fence_create(
>         struct drm_sched_entity *s_entity, void *owner);
>  void drm_sched_fence_scheduled(struct drm_sched_fence *fence);
> --
> 2.14.1
>
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
>

--000000000000293fe905726f4660
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><br><br><div class=3D"gmail_quote"><div dir=3D"ltr">On Wed=
, Aug 1, 2018 at 7:58 PM Christian K=C3=B6nig &lt;<a href=3D"mailto:ckoenig=
.leichtzumerken@gmail.com">ckoenig.leichtzumerken@gmail.com</a>&gt; wrote:<=
br></div><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;borde=
r-left:1px #ccc solid;padding-left:1ex">Since we now deal with multiple rq =
we need to update all of them, not<br>
just the current one.<br>
<br>
Signed-off-by: Christian K=C3=B6nig &lt;<a href=3D"mailto:christian.koenig@=
amd.com" target=3D"_blank">christian.koenig@amd.com</a>&gt;<br></blockquote=
><div>Acked-by: Nayan Deshmukh &lt;<a href=3D"mailto:nayan26deshmukh@gmail.=
com">nayan26deshmukh@gmail.com</a>&gt; <br></div><blockquote class=3D"gmail=
_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:=
1ex">
---<br>
=C2=A0drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c=C2=A0 =C2=A0|=C2=A0 3 +--<br>
=C2=A0drivers/gpu/drm/scheduler/gpu_scheduler.c | 36 ++++++++++++++++++++--=
---------<br>
=C2=A0include/drm/gpu_scheduler.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0|=C2=A0 5 ++---<br>
=C2=A03 files changed, 26 insertions(+), 18 deletions(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_ctx.c<br>
index df6965761046..9fcc14e2dfcf 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c<br>
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c<br>
@@ -407,12 +407,11 @@ void amdgpu_ctx_priority_override(struct amdgpu_ctx *=
ctx,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 for (i =3D 0; i &lt; adev-&gt;num_rings; i++) {=
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ring =3D adev-&gt;r=
ings[i];<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 entity =3D &amp;ctx=
-&gt;rings[i].entity;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0rq =3D &amp;ring-&g=
t;sched.sched_rq[ctx_prio];<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (ring-&gt;funcs-=
&gt;type =3D=3D AMDGPU_RING_TYPE_KIQ)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 continue;<br>
<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0drm_sched_entity_se=
t_rq(entity, rq);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0drm_sched_entity_se=
t_priority(entity, ctx_prio);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
=C2=A0}<br>
<br>
diff --git a/drivers/gpu/drm/scheduler/gpu_scheduler.c b/drivers/gpu/drm/sc=
heduler/gpu_scheduler.c<br>
index 05dc6ecd4003..85908c7f913e 100644<br>
--- a/drivers/gpu/drm/scheduler/gpu_scheduler.c<br>
+++ b/drivers/gpu/drm/scheduler/gpu_scheduler.c<br>
@@ -419,29 +419,39 @@ static void drm_sched_entity_clear_dep(struct dma_fen=
ce *f, struct dma_fence_cb<br>
=C2=A0}<br>
<br>
=C2=A0/**<br>
- * drm_sched_entity_set_rq - Sets the run queue for an entity<br>
+ * drm_sched_entity_set_rq_priority - helper for drm_sched_entity_set_prio=
rity<br>
+ */<br>
+static void drm_sched_entity_set_rq_priority(struct drm_sched_rq **rq,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 enum drm_sched_priority priority)<br>
+{<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0*rq =3D &amp;(*rq)-&gt;sched-&gt;sched_rq[prior=
ity];<br>
+}<br>
+<br>
+/**<br>
+ * drm_sched_entity_set_priority - Sets priority of the entity<br>
=C2=A0 *<br>
=C2=A0 * @entity: scheduler entity<br>
- * @rq: scheduler run queue<br>
+ * @priority: scheduler priority<br>
=C2=A0 *<br>
- * Sets the run queue for an entity and removes the entity from the previo=
us<br>
- * run queue in which was present.<br>
+ * Update the priority of runqueus used for the entity.<br>
=C2=A0 */<br>
-void drm_sched_entity_set_rq(struct drm_sched_entity *entity,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 struct drm_sched_rq *rq)<br>
+void drm_sched_entity_set_priority(struct drm_sched_entity *entity,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 enum drm_sched_priority prior=
ity)<br>
=C2=A0{<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0if (entity-&gt;rq =3D=3D rq)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return;<br>
-<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0BUG_ON(!rq);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0unsigned int i;<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 spin_lock(&amp;entity-&gt;rq_lock);<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0for (i =3D 0; i &lt; entity-&gt;num_rq_list; ++=
i)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0drm_sched_entity_se=
t_rq_priority(&amp;entity-&gt;rq_list[i], priority);<br>
+<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 drm_sched_rq_remove_entity(entity-&gt;rq, entit=
y);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0entity-&gt;rq =3D rq;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0drm_sched_rq_add_entity(rq, entity);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0drm_sched_entity_set_rq_priority(&amp;entity-&g=
t;rq, priority);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0drm_sched_rq_add_entity(entity-&gt;rq, entity);=
<br>
+<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 spin_unlock(&amp;entity-&gt;rq_lock);<br>
=C2=A0}<br>
-EXPORT_SYMBOL(drm_sched_entity_set_rq);<br>
+EXPORT_SYMBOL(drm_sched_entity_set_priority);<br>
<br>
=C2=A0/**<br>
=C2=A0 * drm_sched_dependency_optimized<br>
diff --git a/include/drm/gpu_scheduler.h b/include/drm/gpu_scheduler.h<br>
index 0c4cfe689d4c..22c0f88f7d8f 100644<br>
--- a/include/drm/gpu_scheduler.h<br>
+++ b/include/drm/gpu_scheduler.h<br>
@@ -298,9 +298,8 @@ void drm_sched_entity_fini(struct drm_sched_entity *ent=
ity);<br>
=C2=A0void drm_sched_entity_destroy(struct drm_sched_entity *entity);<br>
=C2=A0void drm_sched_entity_push_job(struct drm_sched_job *sched_job,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0struct drm_sched_entity *entity);<br>
-void drm_sched_entity_set_rq(struct drm_sched_entity *entity,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 struct drm_sched_rq *rq);<br>
-<br>
+void drm_sched_entity_set_priority(struct drm_sched_entity *entity,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 enum drm_sched_priority prior=
ity);<br>
=C2=A0struct drm_sched_fence *drm_sched_fence_create(<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 struct drm_sched_entity *s_entity, void *owner)=
;<br>
=C2=A0void drm_sched_fence_scheduled(struct drm_sched_fence *fence);<br>
-- <br>
2.14.1<br>
<br>
_______________________________________________<br>
dri-devel mailing list<br>
<a href=3D"mailto:dri-devel@lists.freedesktop.org" target=3D"_blank">dri-de=
vel@lists.freedesktop.org</a><br>
<a href=3D"https://lists.freedesktop.org/mailman/listinfo/dri-devel" rel=3D=
"noreferrer" target=3D"_blank">https://lists.freedesktop.org/mailman/listin=
fo/dri-devel</a><br>
</blockquote></div></div>

--000000000000293fe905726f4660--

--===============0829674871==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KZHJpLWRldmVs
IG1haWxpbmcgbGlzdApkcmktZGV2ZWxAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlz
dHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vZHJpLWRldmVsCg==

--===============0829674871==--
