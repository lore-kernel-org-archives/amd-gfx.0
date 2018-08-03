From: Nayan Deshmukh <nayan26deshmukh@gmail.com>
Subject: Re: [PATCH] drm/scheduler: select the least loaded sched during
 entity init
Date: Fri, 3 Aug 2018 17:23:24 +0530
Message-ID: <CAFd4ddyBoT61FuxaVmBuYxF7Q_wPyCuonQQieYKnX8x4qc9bBw@mail.gmail.com>
References: <20180803070628.21471-1-nayan26deshmukh@gmail.com>
 <e1b5839b-9fd2-0af6-5224-6232e2c379c7@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1423490041=="
Return-path: <dri-devel-bounces@lists.freedesktop.org>
In-Reply-To: <e1b5839b-9fd2-0af6-5224-6232e2c379c7@gmail.com>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Cc: amd-gfx@lists.freedesktop.org, Maling list - DRI developers <dri-devel@lists.freedesktop.org>
List-Id: amd-gfx.lists.freedesktop.org

--===============1423490041==
Content-Type: multipart/alternative; boundary="000000000000ec4bed05728693ef"

--000000000000ec4bed05728693ef
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Ah...you are correct. We will reschedule on the first job push. I didn't
take that into account. Let's drop this patch then.

Thanks,
Nayan

On Fri, Aug 3, 2018, 4:12 PM Christian K=C3=B6nig <
ckoenig.leichtzumerken@gmail.com> wrote:

> Am 03.08.2018 um 09:06 schrieb Nayan Deshmukh:
> > Instead of assigning entity to the first scheduler in the list
> > assign it to the least loaded scheduler.
>
> I thought about that as well, but then abandoned the idea.
>
> The reason is that we are going to reassign the rq when the first job is
> pushed to it anyway.
>
> This will only become useful when we take the number of entities a rq
> has into account for the decision as well.
>
> Christian.
>
> >
> > Signed-off-by: Nayan Deshmukh <nayan26deshmukh@gmail.com>
> > ---
> >   drivers/gpu/drm/scheduler/gpu_scheduler.c | 4 +++-
> >   1 file changed, 3 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/gpu/drm/scheduler/gpu_scheduler.c
> b/drivers/gpu/drm/scheduler/gpu_scheduler.c
> > index 21fa0d8a8783..dbd707d24597 100644
> > --- a/drivers/gpu/drm/scheduler/gpu_scheduler.c
> > +++ b/drivers/gpu/drm/scheduler/gpu_scheduler.c
> > @@ -61,6 +61,8 @@
> >   static bool drm_sched_entity_is_ready(struct drm_sched_entity *entity=
);
> >   static void drm_sched_wakeup(struct drm_gpu_scheduler *sched);
> >   static void drm_sched_process_job(struct dma_fence *f, struct
> dma_fence_cb *cb);
> > +static struct drm_sched_rq *
> > +drm_sched_entity_get_free_sched(struct drm_sched_entity *entity);
> >
> >   /**
> >    * drm_sched_rq_init - initialize a given run queue struct
> > @@ -186,13 +188,13 @@ int drm_sched_entity_init(struct drm_sched_entity
> *entity,
> >
> >       memset(entity, 0, sizeof(struct drm_sched_entity));
> >       INIT_LIST_HEAD(&entity->list);
> > -     entity->rq =3D rq_list[0];
> >       entity->guilty =3D guilty;
> >       entity->num_rq_list =3D num_rq_list;
> >       entity->rq_list =3D kcalloc(num_rq_list, sizeof(struct drm_sched_=
rq
> *),
> >                               GFP_KERNEL);
> >       for (i =3D 0; i < num_rq_list; ++i)
> >               entity->rq_list[i] =3D rq_list[i];
> > +     entity->rq =3D drm_sched_entity_get_free_sched(entity);
> >       entity->last_scheduled =3D NULL;
> >
> >       spin_lock_init(&entity->rq_lock);
>
>

--000000000000ec4bed05728693ef
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto">Ah...you are correct. We will reschedule on the first job=
 push. I didn&#39;t take that into account. Let&#39;s drop this patch then.=
<div dir=3D"auto"><br></div><div dir=3D"auto">Thanks,</div><div dir=3D"auto=
">Nayan</div></div><br><div class=3D"gmail_quote"><div dir=3D"ltr">On Fri, =
Aug 3, 2018, 4:12 PM Christian K=C3=B6nig &lt;<a href=3D"mailto:ckoenig.lei=
chtzumerken@gmail.com">ckoenig.leichtzumerken@gmail.com</a>&gt; wrote:<br><=
/div><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-le=
ft:1px #ccc solid;padding-left:1ex">Am 03.08.2018 um 09:06 schrieb Nayan De=
shmukh:<br>
&gt; Instead of assigning entity to the first scheduler in the list<br>
&gt; assign it to the least loaded scheduler.<br>
<br>
I thought about that as well, but then abandoned the idea.<br>
<br>
The reason is that we are going to reassign the rq when the first job is <b=
r>
pushed to it anyway.<br>
<br>
This will only become useful when we take the number of entities a rq <br>
has into account for the decision as well.<br>
<br>
Christian.<br>
<br>
&gt;<br>
&gt; Signed-off-by: Nayan Deshmukh &lt;<a href=3D"mailto:nayan26deshmukh@gm=
ail.com" target=3D"_blank" rel=3D"noreferrer">nayan26deshmukh@gmail.com</a>=
&gt;<br>
&gt; ---<br>
&gt;=C2=A0 =C2=A0drivers/gpu/drm/scheduler/gpu_scheduler.c | 4 +++-<br>
&gt;=C2=A0 =C2=A01 file changed, 3 insertions(+), 1 deletion(-)<br>
&gt;<br>
&gt; diff --git a/drivers/gpu/drm/scheduler/gpu_scheduler.c b/drivers/gpu/d=
rm/scheduler/gpu_scheduler.c<br>
&gt; index 21fa0d8a8783..dbd707d24597 100644<br>
&gt; --- a/drivers/gpu/drm/scheduler/gpu_scheduler.c<br>
&gt; +++ b/drivers/gpu/drm/scheduler/gpu_scheduler.c<br>
&gt; @@ -61,6 +61,8 @@<br>
&gt;=C2=A0 =C2=A0static bool drm_sched_entity_is_ready(struct drm_sched_ent=
ity *entity);<br>
&gt;=C2=A0 =C2=A0static void drm_sched_wakeup(struct drm_gpu_scheduler *sch=
ed);<br>
&gt;=C2=A0 =C2=A0static void drm_sched_process_job(struct dma_fence *f, str=
uct dma_fence_cb *cb);<br>
&gt; +static struct drm_sched_rq *<br>
&gt; +drm_sched_entity_get_free_sched(struct drm_sched_entity *entity);<br>
&gt;=C2=A0 =C2=A0<br>
&gt;=C2=A0 =C2=A0/**<br>
&gt;=C2=A0 =C2=A0 * drm_sched_rq_init - initialize a given run queue struct=
<br>
&gt; @@ -186,13 +188,13 @@ int drm_sched_entity_init(struct drm_sched_entit=
y *entity,<br>
&gt;=C2=A0 =C2=A0<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0memset(entity, 0, sizeof(struct drm_sched_en=
tity));<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0INIT_LIST_HEAD(&amp;entity-&gt;list);<br>
&gt; -=C2=A0 =C2=A0 =C2=A0entity-&gt;rq =3D rq_list[0];<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0entity-&gt;guilty =3D guilty;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0entity-&gt;num_rq_list =3D num_rq_list;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0entity-&gt;rq_list =3D kcalloc(num_rq_list, =
sizeof(struct drm_sched_rq *),<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0GFP_KERNEL);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0for (i =3D 0; i &lt; num_rq_list; ++i)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0entity-&gt;rq_li=
st[i] =3D rq_list[i];<br>
&gt; +=C2=A0 =C2=A0 =C2=A0entity-&gt;rq =3D drm_sched_entity_get_free_sched=
(entity);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0entity-&gt;last_scheduled =3D NULL;<br>
&gt;=C2=A0 =C2=A0<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0spin_lock_init(&amp;entity-&gt;rq_lock);<br>
<br>
</blockquote></div>

--000000000000ec4bed05728693ef--

--===============1423490041==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KZHJpLWRldmVs
IG1haWxpbmcgbGlzdApkcmktZGV2ZWxAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlz
dHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vZHJpLWRldmVsCg==

--===============1423490041==--
