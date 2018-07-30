From: Nayan Deshmukh <nayan26deshmukh-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH] drm/scheduler: only kill entity if last user is killed
Date: Mon, 30 Jul 2018 14:18:50 +0530
Message-ID: <CAFd4ddz1XaDA+koMf-ZfhwP0tGTEkG63mQJ=0m4n2uXdA25hOw@mail.gmail.com>
References: <20180726114554.3873-1-christian.koenig@amd.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0638335183=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <20180726114554.3873-1-christian.koenig-5C7GfCeVMHo@public.gmane.org>
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
To: ckoenig.leichtzumerken-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
Cc: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, Maling list - DRI developers <dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

--===============0638335183==
Content-Type: multipart/alternative; boundary="000000000000934ec10572338aac"

--000000000000934ec10572338aac
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 26, 2018 at 5:16 PM Christian K=C3=B6nig <
ckoenig.leichtzumerken-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:

> Note which task is using the entity and only kill it if the last user of
> the entity is killed. This should prevent problems when entities are
> leaked to
> child processes.
>
> Signed-off-by: Christian K=C3=B6nig <christian.koenig-5C7GfCeVMHo@public.gmane.org>
> ---
>  drivers/gpu/drm/scheduler/gpu_scheduler.c | 6 +++++-
>  include/drm/gpu_scheduler.h               | 1 +
>  2 files changed, 6 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/scheduler/gpu_scheduler.c
> b/drivers/gpu/drm/scheduler/gpu_scheduler.c
> index 3f2fc5e8242a..f563e4fbb4b6 100644
> --- a/drivers/gpu/drm/scheduler/gpu_scheduler.c
> +++ b/drivers/gpu/drm/scheduler/gpu_scheduler.c
> @@ -275,6 +275,7 @@ static void drm_sched_entity_kill_jobs_cb(struct
> dma_fence *f,
>  long drm_sched_entity_flush(struct drm_sched_entity *entity, long timeou=
t)
>  {
>         struct drm_gpu_scheduler *sched;
> +       struct task_struct *last_user;
>         long ret =3D timeout;
>
>         sched =3D entity->rq->sched;
> @@ -295,7 +296,9 @@ long drm_sched_entity_flush(struct drm_sched_entity
> *entity, long timeout)
>
>
>         /* For killed process disable any more IBs enqueue right now */
> -       if ((current->flags & PF_EXITING) && (current->exit_code =3D=3D
> SIGKILL))
> +       last_user =3D cmpxchg(&entity->last_user, current->group_leader,
> NULL);
> +       if ((!last_user || last_user =3D=3D current->group_leader) &&
> +           (current->flags & PF_EXITING) && (current->exit_code =3D=3D
> SIGKILL))
>                 drm_sched_entity_set_rq(entity, NULL);
>
>         return ret;
> @@ -541,6 +544,7 @@ void drm_sched_entity_push_job(struct drm_sched_job
> *sched_job,
>
>         trace_drm_sched_job(sched_job, entity);
>
> +       WRITE_ONCE(entity->last_user, current->group_leader);
>         first =3D spsc_queue_push(&entity->job_queue,
> &sched_job->queue_node);
>
>         /* first job wakes up scheduler */
> diff --git a/include/drm/gpu_scheduler.h b/include/drm/gpu_scheduler.h
> index 091b9afcd184..64016446a103 100644
> --- a/include/drm/gpu_scheduler.h
> +++ b/include/drm/gpu_scheduler.h
> @@ -85,6 +85,7 @@ struct drm_sched_entity {
>         struct dma_fence_cb             cb;
>         atomic_t                        *guilty;
>         struct dma_fence                *last_scheduled;
> +       struct task_struct              *last_user;
>
Please add a line regarding this field in the kernel doc comments.

Regards,
Nayan

>  };
>
>  /**
> --
> 2.14.1
>
> _______________________________________________
> dri-devel mailing list
> dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
>

--000000000000934ec10572338aac
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><br><br><div class=3D"gmail_quote"><div dir=3D"ltr">On Thu=
, Jul 26, 2018 at 5:16 PM Christian K=C3=B6nig &lt;<a href=3D"mailto:ckoeni=
g.leichtzumerken-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org">ckoenig.leichtzumerken-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org</a>&gt; wrote:=
<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;bord=
er-left:1px #ccc solid;padding-left:1ex">Note which task is using the entit=
y and only kill it if the last user of<br>
the entity is killed. This should prevent problems when entities are leaked=
 to<br>
child processes.<br>
<br>
Signed-off-by: Christian K=C3=B6nig &lt;<a href=3D"mailto:christian.koenig@=
amd.com" target=3D"_blank">christian.koenig-5C7GfCeVMHo@public.gmane.org</a>&gt;<br>
---<br>
=C2=A0drivers/gpu/drm/scheduler/gpu_scheduler.c | 6 +++++-<br>
=C2=A0include/drm/gpu_scheduler.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0| 1 +<br>
=C2=A02 files changed, 6 insertions(+), 1 deletion(-)<br>
<br>
diff --git a/drivers/gpu/drm/scheduler/gpu_scheduler.c b/drivers/gpu/drm/sc=
heduler/gpu_scheduler.c<br>
index 3f2fc5e8242a..f563e4fbb4b6 100644<br>
--- a/drivers/gpu/drm/scheduler/gpu_scheduler.c<br>
+++ b/drivers/gpu/drm/scheduler/gpu_scheduler.c<br>
@@ -275,6 +275,7 @@ static void drm_sched_entity_kill_jobs_cb(struct dma_fe=
nce *f,<br>
=C2=A0long drm_sched_entity_flush(struct drm_sched_entity *entity, long tim=
eout)<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 struct drm_gpu_scheduler *sched;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0struct task_struct *last_user;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 long ret =3D timeout;<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 sched =3D entity-&gt;rq-&gt;sched;<br>
@@ -295,7 +296,9 @@ long drm_sched_entity_flush(struct drm_sched_entity *en=
tity, long timeout)<br>
<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* For killed process disable any more IBs enqu=
eue right now */<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0if ((current-&gt;flags &amp; PF_EXITING) &amp;&=
amp; (current-&gt;exit_code =3D=3D SIGKILL))<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0last_user =3D cmpxchg(&amp;entity-&gt;last_user=
, current-&gt;group_leader, NULL);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0if ((!last_user || last_user =3D=3D current-&gt=
;group_leader) &amp;&amp;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0(current-&gt;flags &amp; PF_EXITI=
NG) &amp;&amp; (current-&gt;exit_code =3D=3D SIGKILL))<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 drm_sched_entity_se=
t_rq(entity, NULL);<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 return ret;<br>
@@ -541,6 +544,7 @@ void drm_sched_entity_push_job(struct drm_sched_job *sc=
hed_job,<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 trace_drm_sched_job(sched_job, entity);<br>
<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0WRITE_ONCE(entity-&gt;last_user, current-&gt;gr=
oup_leader);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 first =3D spsc_queue_push(&amp;entity-&gt;job_q=
ueue, &amp;sched_job-&gt;queue_node);<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* first job wakes up scheduler */<br>
diff --git a/include/drm/gpu_scheduler.h b/include/drm/gpu_scheduler.h<br>
index 091b9afcd184..64016446a103 100644<br>
--- a/include/drm/gpu_scheduler.h<br>
+++ b/include/drm/gpu_scheduler.h<br>
@@ -85,6 +85,7 @@ struct drm_sched_entity {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 struct dma_fence_cb=C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0cb;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 atomic_t=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 *guilty;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 struct dma_fence=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 *last_scheduled;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0struct task_struct=C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 *last_user;<br></blockquote><div>Please add a line reg=
arding this field in the kernel doc comments.=C2=A0 <br><br></div><div>Rega=
rds,<br></div><div>Nayan<br></div><blockquote class=3D"gmail_quote" style=
=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">
=C2=A0};<br>
<br>
=C2=A0/**<br>
-- <br>
2.14.1<br>
<br>
_______________________________________________<br>
dri-devel mailing list<br>
<a href=3D"mailto:dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" target=3D"_blank">dri-de=
vel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org</a><br>
<a href=3D"https://lists.freedesktop.org/mailman/listinfo/dri-devel" rel=3D=
"noreferrer" target=3D"_blank">https://lists.freedesktop.org/mailman/listin=
fo/dri-devel</a><br>
</blockquote></div></div>

--000000000000934ec10572338aac--

--===============0638335183==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============0638335183==--
