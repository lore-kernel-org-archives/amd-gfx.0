From: Oded Gabbay <oded.gabbay-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 4/6] drm/amdkfd: GFP_NOIO while holding locks taken in MMU
 notifier
Date: Mon, 14 May 2018 20:20:09 +0300
Message-ID: <CAFCwf12NP8obfHWB9M55fKFFvFBXSWXnzt7nnYYt6CvRG7Fibw@mail.gmail.com>
References: <1521833553-31571-1-git-send-email-Felix.Kuehling@amd.com>
 <1521833553-31571-5-git-send-email-Felix.Kuehling@amd.com>
 <CAFCwf13=swLVZ-FeHtsV9wUxpbA0ghZ2enSLvfZG8vA4g_Jc3Q@mail.gmail.com>
 <1f89f053-4d78-3a13-aa28-3826d858182b@amd.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0812370639=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <1f89f053-4d78-3a13-aa28-3826d858182b-5C7GfCeVMHo@public.gmane.org>
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
To: "Kuehling, Felix" <Felix.Kuehling-5C7GfCeVMHo@public.gmane.org>
Cc: amd-gfx list <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

--===============0812370639==
Content-Type: multipart/alternative; boundary="0000000000004d505e056c2db389"

--0000000000004d505e056c2db389
Content-Type: text/plain; charset="UTF-8"

Cool, thanks!

On Mon, 14 May 2018, 19:07 Felix Kuehling <felix.kuehling-5C7GfCeVMHo@public.gmane.org> wrote:

> On 2018-05-11 03:59 AM, Oded Gabbay wrote:
> > On Fri, Mar 23, 2018 at 10:32 PM, Felix Kuehling <Felix.Kuehling-5C7GfCeVMHo@public.gmane.org>
> wrote:
> >> When an MMU notifier runs in memory reclaim context, it can deadlock
> >> trying to take locks that are already held in the thread causing the
> >> memory reclaim. The solution is to avoid memory reclaim while holding
> >> locks that are taken in MMU notifiers by using GFP_NOIO.
> > Which locks are problematic ?
>
> The only lock I need to take in our MMU notifier is the DQM lock.
>
> >
> > The kernel recommendation is to use "memalloc_noio_{save,restore} to
> > mark the whole scope which cannot perform any IO with a short
> > explanation why"
>
> Yeah. Looking at it more, I think the correct one to use is actually
> memalloc_nofs_{save,restore}.
>
> >
> > By using the scope functions, you protect against future allocation
> > code that will be written in the critical path, without worrying about
> > the developer using the correct GFP_NOIO flag.
>
> Yes. Last time I looked into this it was broken and didn't properly
> handle kmalloc allocations. It looks like this was fixed by this commit:
>
>     commit 6d7225f0cc1a1fc32cf5dd01b4ab4b8a34c7cdb4
>     Author: Nikolay Borisov <nborisov-IBi9RG/b67k@public.gmane.org>
>     Date:   Wed May 3 14:53:05 2017 -0700
>
>         lockdep: teach lockdep about memalloc_noio_save
>
>
> Later NOFS was introduced, which is now used by the lockdep checker to
> detect reclaim deadlocks.
>
> Regards,
>   Felix
>
> >
> > Oded
> >
> >> This commit fixes memory allocations done while holding the dqm->lock
> >> which is needed in the MMU notifier (dqm->ops.evict_process_queues).
> >>
> >> Signed-off-by: Felix Kuehling <Felix.Kuehling-5C7GfCeVMHo@public.gmane.org>
> >> ---
> >>  drivers/gpu/drm/amd/amdkfd/kfd_device.c          | 2 +-
> >>  drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_cik.c | 2 +-
> >>  drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_vi.c  | 2 +-
> >>  3 files changed, 3 insertions(+), 3 deletions(-)
> >>
> >> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device.c
> b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
> >> index 334669996..0434f65 100644
> >> --- a/drivers/gpu/drm/amd/amdkfd/kfd_device.c
> >> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
> >> @@ -652,7 +652,7 @@ int kfd_gtt_sa_allocate(struct kfd_dev *kfd,
> unsigned int size,
> >>         if (size > kfd->gtt_sa_num_of_chunks * kfd->gtt_sa_chunk_size)
> >>                 return -ENOMEM;
> >>
> >> -       *mem_obj = kmalloc(sizeof(struct kfd_mem_obj), GFP_KERNEL);
> >> +       *mem_obj = kmalloc(sizeof(struct kfd_mem_obj), GFP_NOIO);
> >>         if ((*mem_obj) == NULL)
> >>                 return -ENOMEM;
> >>
> >> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_cik.c
> b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_cik.c
> >> index c00c325..2bc49c6 100644
> >> --- a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_cik.c
> >> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_cik.c
> >> @@ -412,7 +412,7 @@ struct mqd_manager *mqd_manager_init_cik(enum
> KFD_MQD_TYPE type,
> >>         if (WARN_ON(type >= KFD_MQD_TYPE_MAX))
> >>                 return NULL;
> >>
> >> -       mqd = kzalloc(sizeof(*mqd), GFP_KERNEL);
> >> +       mqd = kzalloc(sizeof(*mqd), GFP_NOIO);
> >>         if (!mqd)
> >>                 return NULL;
> >>
> >> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_vi.c
> b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_vi.c
> >> index 89e4242..481307b 100644
> >> --- a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_vi.c
> >> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_vi.c
> >> @@ -394,7 +394,7 @@ struct mqd_manager *mqd_manager_init_vi(enum
> KFD_MQD_TYPE type,
> >>         if (WARN_ON(type >= KFD_MQD_TYPE_MAX))
> >>                 return NULL;
> >>
> >> -       mqd = kzalloc(sizeof(*mqd), GFP_KERNEL);
> >> +       mqd = kzalloc(sizeof(*mqd), GFP_NOIO);
> >>         if (!mqd)
> >>                 return NULL;
> >>
> >> --
> >> 2.7.4
> >>
>
>

--0000000000004d505e056c2db389
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto">Cool, thanks!=C2=A0</div><br><div class=3D"gmail_quote"><=
div dir=3D"ltr">On Mon, 14 May 2018, 19:07 Felix Kuehling &lt;<a href=3D"ma=
ilto:felix.kuehling-5C7GfCeVMHo@public.gmane.org">felix.kuehling-5C7GfCeVMHo@public.gmane.org</a>&gt; wrote:<br></div=
><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1=
px #ccc solid;padding-left:1ex">On 2018-05-11 03:59 AM, Oded Gabbay wrote:<=
br>
&gt; On Fri, Mar 23, 2018 at 10:32 PM, Felix Kuehling &lt;<a href=3D"mailto=
:Felix.Kuehling-5C7GfCeVMHo@public.gmane.org" target=3D"_blank" rel=3D"noreferrer">Felix.Kuehlin=
g@amd.com</a>&gt; wrote:<br>
&gt;&gt; When an MMU notifier runs in memory reclaim context, it can deadlo=
ck<br>
&gt;&gt; trying to take locks that are already held in the thread causing t=
he<br>
&gt;&gt; memory reclaim. The solution is to avoid memory reclaim while hold=
ing<br>
&gt;&gt; locks that are taken in MMU notifiers by using GFP_NOIO.<br>
&gt; Which locks are problematic ?<br>
<br>
The only lock I need to take in our MMU notifier is the DQM lock.<br>
<br>
&gt;<br>
&gt; The kernel recommendation is to use &quot;memalloc_noio_{save,restore}=
 to<br>
&gt; mark the whole scope which cannot perform any IO with a short<br>
&gt; explanation why&quot;<br>
<br>
Yeah. Looking at it more, I think the correct one to use is actually<br>
memalloc_nofs_{save,restore}.<br>
<br>
&gt;<br>
&gt; By using the scope functions, you protect against future allocation<br=
>
&gt; code that will be written in the critical path, without worrying about=
<br>
&gt; the developer using the correct GFP_NOIO flag.<br>
<br>
Yes. Last time I looked into this it was broken and didn&#39;t properly<br>
handle kmalloc allocations. It looks like this was fixed by this commit:<br=
>
<br>
=C2=A0 =C2=A0 commit 6d7225f0cc1a1fc32cf5dd01b4ab4b8a34c7cdb4<br>
=C2=A0 =C2=A0 Author: Nikolay Borisov &lt;<a href=3D"mailto:nborisov@suse.c=
om" target=3D"_blank" rel=3D"noreferrer">nborisov-IBi9RG/b67k@public.gmane.org</a>&gt;<br>
=C2=A0 =C2=A0 Date:=C2=A0=C2=A0 Wed May 3 14:53:05 2017 -0700<br>
<br>
=C2=A0 =C2=A0 =C2=A0=C2=A0=C2=A0 lockdep: teach lockdep about memalloc_noio=
_save<br>
<br>
<br>
Later NOFS was introduced, which is now used by the lockdep checker to<br>
detect reclaim deadlocks.<br>
<br>
Regards,<br>
=C2=A0 Felix<br>
<br>
&gt;<br>
&gt; Oded<br>
&gt;<br>
&gt;&gt; This commit fixes memory allocations done while holding the dqm-&g=
t;lock<br>
&gt;&gt; which is needed in the MMU notifier (dqm-&gt;ops.evict_process_que=
ues).<br>
&gt;&gt;<br>
&gt;&gt; Signed-off-by: Felix Kuehling &lt;<a href=3D"mailto:Felix.Kuehling=
@amd.com" target=3D"_blank" rel=3D"noreferrer">Felix.Kuehling-5C7GfCeVMHo@public.gmane.org</a>&g=
t;<br>
&gt;&gt; ---<br>
&gt;&gt;=C2=A0 drivers/gpu/drm/amd/amdkfd/kfd_device.c=C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 | 2 +-<br>
&gt;&gt;=C2=A0 drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_cik.c | 2 +-<br>
&gt;&gt;=C2=A0 drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_vi.c=C2=A0 | 2 +-=
<br>
&gt;&gt;=C2=A0 3 files changed, 3 insertions(+), 3 deletions(-)<br>
&gt;&gt;<br>
&gt;&gt; diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device.c b/drivers/gpu=
/drm/amd/amdkfd/kfd_device.c<br>
&gt;&gt; index 334669996..0434f65 100644<br>
&gt;&gt; --- a/drivers/gpu/drm/amd/amdkfd/kfd_device.c<br>
&gt;&gt; +++ b/drivers/gpu/drm/amd/amdkfd/kfd_device.c<br>
&gt;&gt; @@ -652,7 +652,7 @@ int kfd_gtt_sa_allocate(struct kfd_dev *kfd, u=
nsigned int size,<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (size &gt; kfd-&gt;gtt_sa_num_=
of_chunks * kfd-&gt;gtt_sa_chunk_size)<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0retur=
n -ENOMEM;<br>
&gt;&gt;<br>
&gt;&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0*mem_obj =3D kmalloc(sizeof(struct kfd=
_mem_obj), GFP_KERNEL);<br>
&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0*mem_obj =3D kmalloc(sizeof(struct kfd=
_mem_obj), GFP_NOIO);<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if ((*mem_obj) =3D=3D NULL)<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0retur=
n -ENOMEM;<br>
&gt;&gt;<br>
&gt;&gt; diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_cik.c b/dr=
ivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_cik.c<br>
&gt;&gt; index c00c325..2bc49c6 100644<br>
&gt;&gt; --- a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_cik.c<br>
&gt;&gt; +++ b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_cik.c<br>
&gt;&gt; @@ -412,7 +412,7 @@ struct mqd_manager *mqd_manager_init_cik(enum =
KFD_MQD_TYPE type,<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (WARN_ON(type &gt;=3D KFD_MQD_=
TYPE_MAX))<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0retur=
n NULL;<br>
&gt;&gt;<br>
&gt;&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0mqd =3D kzalloc(sizeof(*mqd), GFP_KERN=
EL);<br>
&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0mqd =3D kzalloc(sizeof(*mqd), GFP_NOIO=
);<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (!mqd)<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0retur=
n NULL;<br>
&gt;&gt;<br>
&gt;&gt; diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_vi.c b/dri=
vers/gpu/drm/amd/amdkfd/kfd_mqd_manager_vi.c<br>
&gt;&gt; index 89e4242..481307b 100644<br>
&gt;&gt; --- a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_vi.c<br>
&gt;&gt; +++ b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_vi.c<br>
&gt;&gt; @@ -394,7 +394,7 @@ struct mqd_manager *mqd_manager_init_vi(enum K=
FD_MQD_TYPE type,<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (WARN_ON(type &gt;=3D KFD_MQD_=
TYPE_MAX))<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0retur=
n NULL;<br>
&gt;&gt;<br>
&gt;&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0mqd =3D kzalloc(sizeof(*mqd), GFP_KERN=
EL);<br>
&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0mqd =3D kzalloc(sizeof(*mqd), GFP_NOIO=
);<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (!mqd)<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0retur=
n NULL;<br>
&gt;&gt;<br>
&gt;&gt; --<br>
&gt;&gt; 2.7.4<br>
&gt;&gt;<br>
<br>
</blockquote></div>

--0000000000004d505e056c2db389--

--===============0812370639==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============0812370639==--
