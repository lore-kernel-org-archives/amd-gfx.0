From: "Zhao, Yong" <Yong.Zhao-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH] drm/amdkfd: Delete a useless parameter from create_queue
 function pointer
Date: Fri, 24 Nov 2017 22:17:32 +0000
Message-ID: <MWHPR12MB14386BE4A7A8E1DC1C48E6B5F0260@MWHPR12MB1438.namprd12.prod.outlook.com>
References: <1511557060-3552-1-git-send-email-yong.zhao@amd.com>,
 <bf0d440f-b554-b366-afe2-7d237fdc1833@amd.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1749449702=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <bf0d440f-b554-b366-afe2-7d237fdc1833-5C7GfCeVMHo@public.gmane.org>
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
To: "Kuehling, Felix" <Felix.Kuehling-5C7GfCeVMHo@public.gmane.org>, "oded.gabbay-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org" <oded.gabbay-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

--===============1749449702==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_MWHPR12MB14386BE4A7A8E1DC1C48E6B5F0260MWHPR12MB1438namp_"

--_000_MWHPR12MB14386BE4A7A8E1DC1C48E6B5F0260MWHPR12MB1438namp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

I based it on amd-staging-drm-next. I will pull from amdkfd-next, remove Ch=
ange-Id from and add you in commit message.


Regards,

Yong

________________________________
From: Kuehling, Felix
Sent: Friday, November 24, 2017 4:44:48 PM
To: Zhao, Yong; oded.gabbay-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org; amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Subject: Re: [PATCH] drm/amdkfd: Delete a useless parameter from create_que=
ue function pointer

Hi Oded,

Yong made this patch against our internal KFD branch. I asked him to
send it to upstream as well, since it applies to code I have already
upstreamed. I'm going to do this for more patches in the future as more
KFD code is upstream and more of our internal changes are applicable
upstream directly.

Is this OK with you, or do you prefer getting all patches through me, in
roughly bi-weekly batches as part of my on-going upstreaming effort?

Hi Yong,

Which branch is this patch against? For upstream KFD commits, they
should be applied against amdkfd-next on
git://people.freedesktop.org/~gabbayo/linux. Oded will apply the patch
if he accepts it, so you only need read access to this repository.

Also, please remove the Change-Id from the commit message. It is
meaningless for upstream submissions outside of our Gerrit server.

Other than that, this patch is Reviewed-by: Felix Kuehling <Felix
Kuehling-5C7GfCeVMHo@public.gmane.org>

Regards,
  Felix


On 2017-11-24 03:57 PM, Yong Zhao wrote:
> Change-Id: Ia5c74ad567c30e206ed804b204fdf8a0f8a75a19
> Signed-off-by: Yong Zhao <yong.zhao-5C7GfCeVMHo@public.gmane.org>
> ---
>  drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c  | 14 ++++--------=
--
>  drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.h  |  3 +--
>  drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c |  3 +--
>  3 files changed, 6 insertions(+), 14 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c b/driv=
ers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
> index 53a66e8..1df1123 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
> @@ -144,8 +144,7 @@ static void deallocate_vmid(struct device_queue_manag=
er *dqm,
>
>  static int create_queue_nocpsch(struct device_queue_manager *dqm,
>                                struct queue *q,
> -                             struct qcm_process_device *qpd,
> -                             int *allocated_vmid)
> +                             struct qcm_process_device *qpd)
>  {
>        int retval;
>
> @@ -165,7 +164,6 @@ static int create_queue_nocpsch(struct device_queue_m=
anager *dqm,
>                if (retval)
>                        goto out_unlock;
>        }
> -     *allocated_vmid =3D qpd->vmid;
>        q->properties.vmid =3D qpd->vmid;
>
>        if (q->properties.type =3D=3D KFD_QUEUE_TYPE_COMPUTE)
> @@ -176,10 +174,9 @@ static int create_queue_nocpsch(struct device_queue_=
manager *dqm,
>                retval =3D -EINVAL;
>
>        if (retval) {
> -             if (list_empty(&qpd->queues_list)) {
> +             if (list_empty(&qpd->queues_list))
>                        deallocate_vmid(dqm, qpd, q);
> -                     *allocated_vmid =3D 0;
> -             }
> +
>                goto out_unlock;
>        }
>
> @@ -788,16 +785,13 @@ static void select_sdma_engine_id(struct queue *q)
>  }
>
>  static int create_queue_cpsch(struct device_queue_manager *dqm, struct q=
ueue *q,
> -                     struct qcm_process_device *qpd, int *allocate_vmid)
> +                     struct qcm_process_device *qpd)
>  {
>        int retval;
>        struct mqd_manager *mqd;
>
>        retval =3D 0;
>
> -     if (allocate_vmid)
> -             *allocate_vmid =3D 0;
> -
>        mutex_lock(&dqm->lock);
>
>        if (dqm->total_queue_count >=3D max_num_of_queues_per_device) {
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.h b/driv=
ers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.h
> index faf820a..449407a 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.h
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.h
> @@ -84,8 +84,7 @@ struct device_process_node {
>  struct device_queue_manager_ops {
>        int     (*create_queue)(struct device_queue_manager *dqm,
>                                struct queue *q,
> -                             struct qcm_process_device *qpd,
> -                             int *allocate_vmid);
> +                             struct qcm_process_device *qpd);
>
>        int     (*destroy_queue)(struct device_queue_manager *dqm,
>                                struct qcm_process_device *qpd,
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c b/dri=
vers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
> index 03bec76..1e7bcae 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
> @@ -199,8 +199,7 @@ int pqm_create_queue(struct process_queue_manager *pq=
m,
>                        goto err_create_queue;
>                pqn->q =3D q;
>                pqn->kq =3D NULL;
> -             retval =3D dev->dqm->ops.create_queue(dev->dqm, q, &pdd->qp=
d,
> -                                             &q->properties.vmid);
> +             retval =3D dev->dqm->ops.create_queue(dev->dqm, q, &pdd->qp=
d);
>                pr_debug("DQM returned %d for create_queue\n", retval);
>                print_queue(q);
>                break;


--_000_MWHPR12MB14386BE4A7A8E1DC1C48E6B5F0260MWHPR12MB1438namp_
Content-Type: text/html; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Diso-8859-=
1">
<style type=3D"text/css" style=3D"display:none;"><!-- P {margin-top:0;margi=
n-bottom:0;} --></style>
</head>
<body dir=3D"ltr">
<div id=3D"divtagdefaultwrapper" style=3D"font-size:12pt;color:#000000;font=
-family:Calibri,Helvetica,sans-serif;" dir=3D"ltr">
<div id=3D"divtagdefaultwrapper" style=3D"font-size: 12pt; color: rgb(0, 0,=
 0); font-family: Calibri, Helvetica, sans-serif, EmojiFont, &quot;Apple Co=
lor Emoji&quot;, &quot;Segoe UI Emoji&quot;, NotoColorEmoji, &quot;Segoe UI=
 Symbol&quot;, &quot;Android Emoji&quot;, EmojiSymbols;" dir=3D"ltr">
<p style=3D"margin-top:0;margin-bottom:0">I based it on&nbsp;amd-staging-dr=
m-next. I will pull from amdkfd-next, remove Change-Id from and add you in =
commit message.&nbsp;</p>
<p style=3D"margin-top:0;margin-bottom:0"><br>
</p>
<p style=3D"margin-top:0;margin-bottom:0">Regards,</p>
<p style=3D"margin-top:0;margin-bottom:0">Yong</p>
</div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Kuehling, Felix<br>
<b>Sent:</b> Friday, November 24, 2017 4:44:48 PM<br>
<b>To:</b> Zhao, Yong; oded.gabbay-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org; amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org=
<br>
<b>Subject:</b> Re: [PATCH] drm/amdkfd: Delete a useless parameter from cre=
ate_queue function pointer</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:10pt;=
">
<div class=3D"PlainText">Hi Oded,<br>
<br>
Yong made this patch against our internal KFD branch. I asked him to<br>
send it to upstream as well, since it applies to code I have already<br>
upstreamed. I'm going to do this for more patches in the future as more<br>
KFD code is upstream and more of our internal changes are applicable<br>
upstream directly.<br>
<br>
Is this OK with you, or do you prefer getting all patches through me, in<br=
>
roughly bi-weekly batches as part of my on-going upstreaming effort?<br>
<br>
Hi Yong,<br>
<br>
Which branch is this patch against? For upstream KFD commits, they<br>
should be applied against amdkfd-next on<br>
git://people.freedesktop.org/~gabbayo/linux. Oded will apply the patch<br>
if he accepts it, so you only need read access to this repository.<br>
<br>
Also, please remove the Change-Id from the commit message. It is<br>
meaningless for upstream submissions outside of our Gerrit server.<br>
<br>
Other than that, this patch is Reviewed-by: Felix Kuehling &lt;Felix<br>
Kuehling-5C7GfCeVMHo@public.gmane.org&gt;<br>
<br>
Regards,<br>
&nbsp; Felix<br>
<br>
<br>
On 2017-11-24 03:57 PM, Yong Zhao wrote:<br>
&gt; Change-Id: Ia5c74ad567c30e206ed804b204fdf8a0f8a75a19<br>
&gt; Signed-off-by: Yong Zhao &lt;yong.zhao-5C7GfCeVMHo@public.gmane.org&gt;<br>
&gt; ---<br>
&gt;&nbsp; drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c&nbsp; | 14=
 &#43;&#43;&#43;&#43;----------<br>
&gt;&nbsp; drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.h&nbsp; |&nb=
sp; 3 &#43;--<br>
&gt;&nbsp; drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c |&nbsp; 3=
 &#43;--<br>
&gt;&nbsp; 3 files changed, 6 insertions(&#43;), 14 deletions(-)<br>
&gt;<br>
&gt; diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c b/d=
rivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c<br>
&gt; index 53a66e8..1df1123 100644<br>
&gt; --- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c<br>
&gt; &#43;&#43;&#43; b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.=
c<br>
&gt; @@ -144,8 &#43;144,7 @@ static void deallocate_vmid(struct device_queu=
e_manager *dqm,<br>
&gt;&nbsp; <br>
&gt;&nbsp; static int create_queue_nocpsch(struct device_queue_manager *dqm=
,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct queue *q,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; struct qcm_process_device *qpd,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; int *allocated_vmid)<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp; struct qcm_process_device *qpd)<br>
&gt;&nbsp; {<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int retval;<br>
&gt;&nbsp; <br>
&gt; @@ -165,7 &#43;164,6 @@ static int create_queue_nocpsch(struct device_=
queue_manager *dqm,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; if (retval)<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; goto ou=
t_unlock;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; *allocated_vmid =3D qpd-&gt;vmid;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; q-&gt;properties.vmid =3D qp=
d-&gt;vmid;<br>
&gt;&nbsp; <br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (q-&gt;properties.type =
=3D=3D KFD_QUEUE_TYPE_COMPUTE)<br>
&gt; @@ -176,10 &#43;174,9 @@ static int create_queue_nocpsch(struct device=
_queue_manager *dqm,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; retval =3D -EINVAL;<br>
&gt;&nbsp; <br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (retval) {<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; if (list_empty(&amp;qpd-&gt;queues_list)) {<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; if (list_empty(&amp;qpd-&gt;queues_list))<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dealloc=
ate_vmid(dqm, qpd, q);<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *allocated_vmid =3D 0;<=
br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; }<br>
&gt; &#43;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; goto out_unlock;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt;&nbsp; <br>
&gt; @@ -788,16 &#43;785,13 @@ static void select_sdma_engine_id(struct que=
ue *q)<br>
&gt;&nbsp; }<br>
&gt;&nbsp; <br>
&gt;&nbsp; static int create_queue_cpsch(struct device_queue_manager *dqm, =
struct queue *q,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct qcm_process_devi=
ce *qpd, int *allocate_vmid)<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct qcm_process_=
device *qpd)<br>
&gt;&nbsp; {<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int retval;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct mqd_manager *mqd;<br>
&gt;&nbsp; <br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; retval =3D 0;<br>
&gt;&nbsp; <br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; if (allocate_vmid)<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; *allocate_vmid =3D 0;<br>
&gt; -<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mutex_lock(&amp;dqm-&gt;lock=
);<br>
&gt;&nbsp; <br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (dqm-&gt;total_queue_coun=
t &gt;=3D max_num_of_queues_per_device) {<br>
&gt; diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.h b/d=
rivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.h<br>
&gt; index faf820a..449407a 100644<br>
&gt; --- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.h<br>
&gt; &#43;&#43;&#43; b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.=
h<br>
&gt; @@ -84,8 &#43;84,7 @@ struct device_process_node {<br>
&gt;&nbsp; struct device_queue_manager_ops {<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int&nbsp;&nbsp;&nbsp;&nbsp; =
(*create_queue)(struct device_queue_manager *dqm,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct queue *q,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; struct qcm_process_device *qpd,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; int *allocate_vmid);<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp; struct qcm_process_device *qpd);<br>
&gt;&nbsp; <br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int&nbsp;&nbsp;&nbsp;&nbsp; =
(*destroy_queue)(struct device_queue_manager *dqm,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct qcm_process_device *qpd,<br=
>
&gt; diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c b/=
drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c<br>
&gt; index 03bec76..1e7bcae 100644<br>
&gt; --- a/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c<br>
&gt; &#43;&#43;&#43; b/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager=
.c<br>
&gt; @@ -199,8 &#43;199,7 @@ int pqm_create_queue(struct process_queue_mana=
ger *pqm,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; goto er=
r_create_queue;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; pqn-&gt;q =3D q;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; pqn-&gt;kq =3D NULL;<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; retval =3D dev-&gt;dqm-&gt;ops.create_queue(dev-&gt;dqm, q, &amp;pdd-&g=
t;qpd,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &amp;q-&gt;properties.vmid);<=
br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; retval =3D dev-&gt;dqm-&gt;ops.create_queue(dev-&gt;dqm, q, &amp;pd=
d-&gt;qpd);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; pr_debug(&quot;DQM returned %d for create_queue\n&quot;=
, retval);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; print_queue(q);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; break;<br>
<br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_MWHPR12MB14386BE4A7A8E1DC1C48E6B5F0260MWHPR12MB1438namp_--

--===============1749449702==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============1749449702==--
