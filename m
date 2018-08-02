From: Nayan Deshmukh <nayan26deshmukh@gmail.com>
Subject: Re: [PATCH 3/4] drm/scheduler: add new function to get least loaded
 sched v2
Date: Thu, 2 Aug 2018 11:31:56 +0530
Message-ID: <CAFd4ddyf=EhJ7pmzq3sEGa6U1sQ7Ga7fUH+sW+VKeBxJABjnKQ@mail.gmail.com>
References: <20180801082002.20696-1-nayan26deshmukh@gmail.com>
 <20180801082002.20696-3-nayan26deshmukh@gmail.com>
 <dde1b549-df1b-e156-1e96-ddfe4beca446@amd.com>
 <CAFd4ddx8D2iKquRu4YVh1gnRMpLFgWf3CBPdk5SD-nJ8dNXEPQ@mail.gmail.com>
 <BY1PR12MB050215C66BE529F1FB94F373B42C0@BY1PR12MB0502.namprd12.prod.outlook.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0878455635=="
Return-path: <dri-devel-bounces@lists.freedesktop.org>
In-Reply-To: <BY1PR12MB050215C66BE529F1FB94F373B42C0@BY1PR12MB0502.namprd12.prod.outlook.com>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
To: David1.Zhou@amd.com
Cc: Maling list - DRI developers <dri-devel@lists.freedesktop.org>, amd-gfx@lists.freedesktop.org, =?UTF-8?Q?Christian_K=C3=B6nig?= <Christian.Koenig@amd.com>
List-Id: amd-gfx.lists.freedesktop.org

--===============0878455635==
Content-Type: multipart/alternative; boundary="0000000000003d891d05726d8f44"

--0000000000003d891d05726d8f44
Content-Type: text/plain; charset="UTF-8"

Hi David,

On Thu, Aug 2, 2018 at 8:22 AM Zhou, David(ChunMing) <David1.Zhou@amd.com>
wrote:

> Another big question:
>
> I agree the general idea is good to balance scheduler load for same ring
> family.
>
> But, when same entity job run on different scheduler, that means the later
> job could be completed ahead of front, Right?
>
Really good question. To avoid this senario we do not move an entity which
already has a job in the hardware queue. We only move entities whose
last_scheduled fence has been signalled which means that the last submitted
job of this entity has finished executing.

Moving an entity which already has a job in the hardware queue will hinder
the dependency optimization that we are using and hence will not anyway
lead to a better performance. I have talked about the issue in more detail
here [1]. Please let me know if you have any more doubts regarding this.

Cheers,
Nayan

[1]
http://ndesh26.github.io/gsoc/2018/06/14/GSoC-Update-A-Curious-Case-of-Dependency-Handling/

That will break fence design, later fence must be signaled after front
> fence in same fence context.
>
>
>
> Anything I missed?
>
>
>
> Regards,
>
> David Zhou
>
>
>
> *From:* dri-devel <dri-devel-bounces@lists.freedesktop.org> *On Behalf Of
> *Nayan Deshmukh
> *Sent:* Thursday, August 02, 2018 12:07 AM
> *To:* Grodzovsky, Andrey <Andrey.Grodzovsky@amd.com>
> *Cc:* amd-gfx@lists.freedesktop.org; Maling list - DRI developers <
> dri-devel@lists.freedesktop.org>; Koenig, Christian <
> Christian.Koenig@amd.com>
> *Subject:* Re: [PATCH 3/4] drm/scheduler: add new function to get least
> loaded sched v2
>
>
>
> Yes, that is correct.
>
>
>
> Nayan
>
>
>
> On Wed, Aug 1, 2018, 9:05 PM Andrey Grodzovsky <Andrey.Grodzovsky@amd.com>
> wrote:
>
> Clarification question -  if the run queues belong to different
> schedulers they effectively point to different rings,
>
> it means we allow to move (reschedule) a drm_sched_entity from one ring
> to another - i assume that the idea int the first place, that
>
> you have a set of HW rings and you can utilize any of them for your jobs
> (like compute rings). Correct ?
>
> Andrey
>
>
> On 08/01/2018 04:20 AM, Nayan Deshmukh wrote:
> > The function selects the run queue from the rq_list with the
> > least load. The load is decided by the number of jobs in a
> > scheduler.
> >
> > v2: avoid using atomic read twice consecutively, instead store
> >      it locally
> >
> > Signed-off-by: Nayan Deshmukh <nayan26deshmukh@gmail.com>
> > ---
> >   drivers/gpu/drm/scheduler/gpu_scheduler.c | 25
> +++++++++++++++++++++++++
> >   1 file changed, 25 insertions(+)
> >
> > diff --git a/drivers/gpu/drm/scheduler/gpu_scheduler.c
> b/drivers/gpu/drm/scheduler/gpu_scheduler.c
> > index 375f6f7f6a93..fb4e542660b0 100644
> > --- a/drivers/gpu/drm/scheduler/gpu_scheduler.c
> > +++ b/drivers/gpu/drm/scheduler/gpu_scheduler.c
> > @@ -255,6 +255,31 @@ static bool drm_sched_entity_is_ready(struct
> drm_sched_entity *entity)
> >       return true;
> >   }
> >
> > +/**
> > + * drm_sched_entity_get_free_sched - Get the rq from rq_list with least
> load
> > + *
> > + * @entity: scheduler entity
> > + *
> > + * Return the pointer to the rq with least load.
> > + */
> > +static struct drm_sched_rq *
> > +drm_sched_entity_get_free_sched(struct drm_sched_entity *entity)
> > +{
> > +     struct drm_sched_rq *rq = NULL;
> > +     unsigned int min_jobs = UINT_MAX, num_jobs;
> > +     int i;
> > +
> > +     for (i = 0; i < entity->num_rq_list; ++i) {
> > +             num_jobs =
> atomic_read(&entity->rq_list[i]->sched->num_jobs);
> > +             if (num_jobs < min_jobs) {
> > +                     min_jobs = num_jobs;
> > +                     rq = entity->rq_list[i];
> > +             }
> > +     }
> > +
> > +     return rq;
> > +}
> > +
> >   static void drm_sched_entity_kill_jobs_cb(struct dma_fence *f,
> >                                   struct dma_fence_cb *cb)
> >   {
>
>

--0000000000003d891d05726d8f44
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi David,<br><div><br><div class=3D"gmail_quote"><div dir=
=3D"ltr">On Thu, Aug 2, 2018 at 8:22 AM Zhou, David(ChunMing) &lt;<a href=
=3D"mailto:David1.Zhou@amd.com">David1.Zhou@amd.com</a>&gt; wrote:<br></div=
><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border=
-left:1px solid rgb(204,204,204);padding-left:1ex">





<div lang=3D"EN-US">
<div class=3D"gmail-m_963201938271036718WordSection1">
<p class=3D"MsoNormal">Another big question:<u></u><u></u></p>
<p class=3D"MsoNormal">I agree the general idea is good to balance schedule=
r load for same ring family.<u></u><u></u></p>
<p class=3D"MsoNormal">But, when same entity job run on different scheduler=
, that means the later job could be completed ahead of front, Right?<u></u>=
<u></u></p></div></div></blockquote><div>Really good question. To avoid thi=
s senario we do not move an entity which already has a job in the hardware =
queue. We only move entities whose last_scheduled fence has been signalled =
which means that the last submitted job of this entity has finished executi=
ng. <br><br></div><div>Moving an entity which already has a job in the hard=
ware queue will hinder the dependency optimization that we are using and he=
nce will not anyway lead to a better performance. I have talked about the i=
ssue in more detail here [1]. Please let me know if you have any more doubt=
s regarding this.<br><br></div><div>Cheers,<br></div><div>Nayan <br><br>[1]=
 <a href=3D"http://ndesh26.github.io/gsoc/2018/06/14/GSoC-Update-A-Curious-=
Case-of-Dependency-Handling/">http://ndesh26.github.io/gsoc/2018/06/14/GSoC=
-Update-A-Curious-Case-of-Dependency-Handling/</a><br><br></div><blockquote=
 class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px so=
lid rgb(204,204,204);padding-left:1ex"><div lang=3D"EN-US"><div class=3D"gm=
ail-m_963201938271036718WordSection1"><p class=3D"MsoNormal"></p>
<p class=3D"MsoNormal">That will break fence design, later fence must be si=
gnaled after front fence in same fence context.<u></u><u></u></p>
<p class=3D"MsoNormal"><u></u>=C2=A0<u></u></p>
<p class=3D"MsoNormal">Anything I missed?<u></u><u></u></p>
<p class=3D"MsoNormal"><u></u>=C2=A0<u></u></p>
<p class=3D"MsoNormal">Regards,<u></u><u></u></p>
<p class=3D"MsoNormal">David Zhou<u></u><u></u></p>
<p class=3D"MsoNormal"><u></u>=C2=A0<u></u></p>
<p class=3D"MsoNormal"><b>From:</b> dri-devel &lt;<a href=3D"mailto:dri-dev=
el-bounces@lists.freedesktop.org" target=3D"_blank">dri-devel-bounces@lists=
.freedesktop.org</a>&gt;
<b>On Behalf Of </b>Nayan Deshmukh<br>
<b>Sent:</b> Thursday, August 02, 2018 12:07 AM<br>
<b>To:</b> Grodzovsky, Andrey &lt;<a href=3D"mailto:Andrey.Grodzovsky@amd.c=
om" target=3D"_blank">Andrey.Grodzovsky@amd.com</a>&gt;<br>
<b>Cc:</b> <a href=3D"mailto:amd-gfx@lists.freedesktop.org" target=3D"_blan=
k">amd-gfx@lists.freedesktop.org</a>; Maling list - DRI developers &lt;<a h=
ref=3D"mailto:dri-devel@lists.freedesktop.org" target=3D"_blank">dri-devel@=
lists.freedesktop.org</a>&gt;; Koenig, Christian &lt;<a href=3D"mailto:Chri=
stian.Koenig@amd.com" target=3D"_blank">Christian.Koenig@amd.com</a>&gt;<br=
>
<b>Subject:</b> Re: [PATCH 3/4] drm/scheduler: add new function to get leas=
t loaded sched v2<u></u><u></u></p>
<p class=3D"MsoNormal"><u></u>=C2=A0<u></u></p>
<div>
<p class=3D"MsoNormal">Yes, that is correct.=C2=A0<u></u><u></u></p>
<div>
<p class=3D"MsoNormal"><u></u>=C2=A0<u></u></p>
</div>
<div>
<p class=3D"MsoNormal">Nayan<u></u><u></u></p>
</div>
</div>
<p class=3D"MsoNormal"><u></u>=C2=A0<u></u></p>
<div>
<div>
<p class=3D"MsoNormal">On Wed, Aug 1, 2018, 9:05 PM Andrey Grodzovsky &lt;<=
a href=3D"mailto:Andrey.Grodzovsky@amd.com" target=3D"_blank">Andrey.Grodzo=
vsky@amd.com</a>&gt; wrote:<u></u><u></u></p>
</div>
<blockquote style=3D"border-color:currentcolor currentcolor currentcolor rg=
b(204,204,204);border-style:none none none solid;border-width:medium medium=
 medium 1pt;padding:0in 0in 0in 6pt;margin-left:4.8pt;margin-right:0in">
<p class=3D"MsoNormal" style=3D"margin-bottom:12pt">Clarification question =
-=C2=A0 if the run queues belong to different
<br>
schedulers they effectively point to different rings,<br>
<br>
it means we allow to move (reschedule) a drm_sched_entity from one ring <br=
>
to another - i assume that the idea int the first place, that<br>
<br>
you have a set of HW rings and you can utilize any of them for your jobs <b=
r>
(like compute rings). Correct ?<br>
<br>
Andrey<br>
<br>
<br>
On 08/01/2018 04:20 AM, Nayan Deshmukh wrote:<br>
&gt; The function selects the run queue from the rq_list with the<br>
&gt; least load. The load is decided by the number of jobs in a<br>
&gt; scheduler.<br>
&gt;<br>
&gt; v2: avoid using atomic read twice consecutively, instead store<br>
&gt;=C2=A0 =C2=A0 =C2=A0 it locally<br>
&gt;<br>
&gt; Signed-off-by: Nayan Deshmukh &lt;<a href=3D"mailto:nayan26deshmukh@gm=
ail.com" target=3D"_blank">nayan26deshmukh@gmail.com</a>&gt;<br>
&gt; ---<br>
&gt;=C2=A0 =C2=A0drivers/gpu/drm/scheduler/gpu_scheduler.c | 25 +++++++++++=
++++++++++++++<br>
&gt;=C2=A0 =C2=A01 file changed, 25 insertions(+)<br>
&gt;<br>
&gt; diff --git a/drivers/gpu/drm/scheduler/gpu_scheduler.c b/drivers/gpu/d=
rm/scheduler/gpu_scheduler.c<br>
&gt; index 375f6f7f6a93..fb4e542660b0 100644<br>
&gt; --- a/drivers/gpu/drm/scheduler/gpu_scheduler.c<br>
&gt; +++ b/drivers/gpu/drm/scheduler/gpu_scheduler.c<br>
&gt; @@ -255,6 +255,31 @@ static bool drm_sched_entity_is_ready(struct drm_=
sched_entity *entity)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0return true;<br>
&gt;=C2=A0 =C2=A0}<br>
&gt;=C2=A0 =C2=A0<br>
&gt; +/**<br>
&gt; + * drm_sched_entity_get_free_sched - Get the rq from rq_list with lea=
st load<br>
&gt; + *<br>
&gt; + * @entity: scheduler entity<br>
&gt; + *<br>
&gt; + * Return the pointer to the rq with least load.<br>
&gt; + */<br>
&gt; +static struct drm_sched_rq *<br>
&gt; +drm_sched_entity_get_free_sched(struct drm_sched_entity *entity)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 =C2=A0struct drm_sched_rq *rq =3D NULL;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0unsigned int min_jobs =3D UINT_MAX, num_jobs;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0int i;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0for (i =3D 0; i &lt; entity-&gt;num_rq_list; ++i)=
 {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0num_jobs =3D atomic_r=
ead(&amp;entity-&gt;rq_list[i]-&gt;sched-&gt;num_jobs);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (num_jobs &lt; min=
_jobs) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0min_jobs =3D num_jobs;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0rq =3D entity-&gt;rq_list[i];<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
&gt; +=C2=A0 =C2=A0 =C2=A0}<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0return rq;<br>
&gt; +}<br>
&gt; +<br>
&gt;=C2=A0 =C2=A0static void drm_sched_entity_kill_jobs_cb(struct dma_fence=
 *f,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0struct dma_fence_cb =
*cb)<br>
&gt;=C2=A0 =C2=A0{<u></u><u></u></p>
</blockquote>
</div>
</div>
</div>

</blockquote></div></div></div>

--0000000000003d891d05726d8f44--

--===============0878455635==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KZHJpLWRldmVs
IG1haWxpbmcgbGlzdApkcmktZGV2ZWxAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlz
dHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vZHJpLWRldmVsCg==

--===============0878455635==--
