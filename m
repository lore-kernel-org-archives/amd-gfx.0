From: "Zhao, Yong" <Yong.Zhao-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH 2/2] drm/amdkfd: Move pm_create_runlist_ib() out of
 pm_send_runlist()
Date: Fri, 22 Nov 2019 21:50:53 +0000
Message-ID: <DM6PR12MB2778563A27C80EED222CD177F0490@DM6PR12MB2778.namprd12.prod.outlook.com>
References: <20191121212639.4057-1-Yong.Zhao@amd.com>
 <20191121212639.4057-2-Yong.Zhao@amd.com>,
 <529f5ed1-481c-4de3-763b-f70fa1e6080c@amd.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1265983940=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <529f5ed1-481c-4de3-763b-f70fa1e6080c-5C7GfCeVMHo@public.gmane.org>
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
To: "Kuehling, Felix" <Felix.Kuehling-5C7GfCeVMHo@public.gmane.org>, "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

--===============1265983940==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_DM6PR12MB2778563A27C80EED222CD177F0490DM6PR12MB2778namp_"

--_000_DM6PR12MB2778563A27C80EED222CD177F0490DM6PR12MB2778namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only - Internal Distribution Only]

Hi Felix,

There is no big picture unfortunately, just some improvements that I came t=
o when navigating the code.

Regarding your suggestion, I have a concern. With the original code in unma=
p_queues_cpsch(), if amdkfd_fence_wait_timeout() fails, we won't release th=
e runlist ib. I am not sure it is by design or just a small bug. If it is b=
y design (probably for debugging when HWS hang), merging pm_send_unmap_queu=
e and pm_release_ib together will break the design.

If we agree to move in that direction, I agree with the part of the name ch=
anges because the original names are prone to cause confusion.

Regards,
Yong
________________________________
From: Kuehling, Felix <Felix.Kuehling-5C7GfCeVMHo@public.gmane.org>
Sent: Friday, November 22, 2019 4:21 PM
To: Zhao, Yong <Yong.Zhao-5C7GfCeVMHo@public.gmane.org>; amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org <amd-gfx@=
lists.freedesktop.org>
Subject: Re: [PATCH 2/2] drm/amdkfd: Move pm_create_runlist_ib() out of pm_=
send_runlist()

I'm not sure about this one. Looks like the interface is getting
needlessly more complicated. Now the caller has to keep track of the
runlist IB address and size just to pass those to another function. I
could understand this if there was a use case that needs to separate the
allocation of the runlist and sending it to the HW. But I don't see that.

Some background for why I think the interface is the way it is: The
runlist IB is continuously executed by the HWS firmware. If the runlist
is oversubscribed, the HWS firmware will loop through it. So the IB must
remain allocated until pm_send_unmap_queue is called. Currently
pm_send_runlist creates the runlist IB and sends it to the HWS. You're
separating that into creation and sending. Do you see a case where you
need to send the same runlist multiple times? Or do something else
between creating the runlist and sending it to the HWS?

pm_release_ib releases the runlist IB, assuming that he HWS is no longer
using it. Maybe this could be combined with pm_send_unmap_queue. I'm not
100% sure because there are some filter parameters that may leave some
queues mapped. If the two can be combined, I'd suggest the following
name and interface changes to reflect how I think this is being used today:

  * pm_send_runlist -> pm_create_and_send_runlist
  * pm_send_unmap_queue + pm_release_ib -> pm_preempt_and_free_runlist

I see you're doing a lot of cleanup and refactoring in this area of the
code. Is there some bigger picture here, some idea of the end-state
you're trying to get to? Knowing where you're going with this may make
it easier to review the code.

Regards,
   Felix

On 2019-11-21 4:26 p.m., Yong Zhao wrote:
> This is consistent with the calling sequence in unmap_queues_cpsch().
>
> Change-Id: Ieb6714422c812d4f6ebbece34e339871471e4b5e
> Signed-off-by: Yong Zhao <Yong.Zhao-5C7GfCeVMHo@public.gmane.org>
> ---
>   .../drm/amd/amdkfd/kfd_device_queue_manager.c | 18 +++++++++++++++--
>   .../gpu/drm/amd/amdkfd/kfd_packet_manager.c   | 20 +++++--------------
>   drivers/gpu/drm/amd/amdkfd/kfd_priv.h         |  7 ++++++-
>   3 files changed, 27 insertions(+), 18 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c b/driv=
ers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
> index 510f2d1bb8bb..fd7d90136b94 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
> @@ -1302,6 +1302,8 @@ static int unmap_sdma_queues(struct device_queue_ma=
nager *dqm)
>   static int map_queues_cpsch(struct device_queue_manager *dqm)
>   {
>        int retval;
> +     uint64_t rl_ib_gpu_addr;
> +     size_t rl_ib_size;
>
>        if (!dqm->sched_running)
>                return 0;
> @@ -1310,15 +1312,27 @@ static int map_queues_cpsch(struct device_queue_m=
anager *dqm)
>        if (dqm->active_runlist)
>                return 0;
>
> -     retval =3D pm_send_runlist(&dqm->packets, &dqm->queues);
> +     retval =3D pm_create_runlist_ib(&dqm->packets, &dqm->queues,
> +                             &rl_ib_gpu_addr, &rl_ib_size);
> +     if (retval)
> +             goto fail_create_runlist_ib;
> +
> +     pr_debug("runlist IB address: 0x%llX\n", rl_ib_gpu_addr);
> +
> +     retval =3D pm_send_runlist(&dqm->packets, &dqm->queues,
> +                     rl_ib_gpu_addr, rl_ib_size);
>        pr_debug("%s sent runlist\n", __func__);
>        if (retval) {
>                pr_err("failed to execute runlist\n");
> -             return retval;
> +             goto fail_create_runlist_ib;
>        }
>        dqm->active_runlist =3D true;
>
>        return retval;
> +
> +fail_create_runlist_ib:
> +     pm_destroy_runlist_ib(&dqm->packets);
> +     return retval;
>   }
>
>   /* dqm->lock mutex has to be locked before calling this function */
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager.c b/drivers/gp=
u/drm/amd/amdkfd/kfd_packet_manager.c
> index 4a9433257428..6ec54e9f9392 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager.c
> @@ -116,7 +116,7 @@ static int pm_allocate_runlist_ib(struct packet_manag=
er *pm,
>        return retval;
>   }
>
> -static int pm_create_runlist_ib(struct packet_manager *pm,
> +int pm_create_runlist_ib(struct packet_manager *pm,
>                                struct list_head *queues,
>                                uint64_t *rl_gpu_addr,
>                                size_t *rl_size_bytes)
> @@ -149,7 +149,6 @@ static int pm_create_runlist_ib(struct packet_manager=
 *pm,
>                /* build map process packet */
>                if (proccesses_mapped >=3D pm->dqm->processes_count) {
>                        pr_debug("Not enough space left in runlist IB\n");
> -                     pm_destroy_runlist_ib(pm);
>                        return -ENOMEM;
>                }
>
> @@ -299,20 +298,13 @@ int pm_send_set_resources(struct packet_manager *pm=
,
>        return retval;
>   }
>
> -int pm_send_runlist(struct packet_manager *pm, struct list_head *dqm_que=
ues)
> +int pm_send_runlist(struct packet_manager *pm, struct list_head *dqm_que=
ues,
> +                     uint64_t rl_ib_gpu_addr, size_t rl_ib_size)
>   {
> -     uint64_t rl_gpu_ib_addr;
>        uint32_t *rl_buffer;
> -     size_t rl_ib_size, packet_size_dwords;
> +     size_t packet_size_dwords;
>        int retval;
>
> -     retval =3D pm_create_runlist_ib(pm, dqm_queues, &rl_gpu_ib_addr,
> -                                     &rl_ib_size);
> -     if (retval)
> -             goto fail_create_runlist_ib;
> -
> -     pr_debug("runlist IB address: 0x%llX\n", rl_gpu_ib_addr);
> -
>        packet_size_dwords =3D pm->pmf->runlist_size / sizeof(uint32_t);
>        mutex_lock(&pm->lock);
>
> @@ -321,7 +313,7 @@ int pm_send_runlist(struct packet_manager *pm, struct=
 list_head *dqm_queues)
>        if (retval)
>                goto fail_acquire_packet_buffer;
>
> -     retval =3D pm->pmf->runlist(pm, rl_buffer, rl_gpu_ib_addr,
> +     retval =3D pm->pmf->runlist(pm, rl_buffer, rl_ib_gpu_addr,
>                                        rl_ib_size / sizeof(uint32_t), fal=
se);
>        if (retval)
>                goto fail_create_runlist;
> @@ -336,8 +328,6 @@ int pm_send_runlist(struct packet_manager *pm, struct=
 list_head *dqm_queues)
>        kq_rollback_packet(pm->priv_queue);
>   fail_acquire_packet_buffer:
>        mutex_unlock(&pm->lock);
> -fail_create_runlist_ib:
> -     pm_destroy_runlist_ib(pm);
>        return retval;
>   }
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h b/drivers/gpu/drm/amd/=
amdkfd/kfd_priv.h
> index 389cda7c8f1a..6accb605b9f0 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
> @@ -980,7 +980,8 @@ int pm_init(struct packet_manager *pm, struct device_=
queue_manager *dqm);
>   void pm_uninit(struct packet_manager *pm);
>   int pm_send_set_resources(struct packet_manager *pm,
>                                struct scheduling_resources *res);
> -int pm_send_runlist(struct packet_manager *pm, struct list_head *dqm_que=
ues);
> +int pm_send_runlist(struct packet_manager *pm, struct list_head *dqm_que=
ues,
> +             uint64_t rl_ib_gpu_addr, size_t rl_ib_size);
>   int pm_send_query_status(struct packet_manager *pm, uint64_t fence_addr=
ess,
>                                uint32_t fence_value);
>
> @@ -989,6 +990,10 @@ int pm_send_unmap_queue(struct packet_manager *pm, e=
num kfd_queue_type type,
>                        uint32_t filter_param, bool reset,
>                        unsigned int sdma_engine);
>
> +int pm_create_runlist_ib(struct packet_manager *pm,
> +                             struct list_head *queues,
> +                             uint64_t *rl_gpu_addr,
> +                             size_t *rl_size_bytes);
>   void pm_destroy_runlist_ib(struct packet_manager *pm);
>
>   /* Following PM funcs can be shared among VI and AI */

--_000_DM6PR12MB2778563A27C80EED222CD177F0490DM6PR12MB2778namp_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
<style type=3D"text/css" style=3D"display:none;"> P {margin-top:0;margin-bo=
ttom:0;} </style>
</head>
<body dir=3D"ltr">
<p style=3D"font-family:Arial;font-size:10pt;color:#0078D7;margin:15pt;" al=
ign=3D"Left">
[AMD Official Use Only - Internal Distribution Only]<br>
</p>
<br>
<div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
Hi Felix,</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
There is no big picture unfortunately, just some improvements that I came t=
o when navigating the code.&nbsp;</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
Regarding your suggestion, I have a concern. With the original code in unma=
p_queues_cpsch(), if amdkfd_fence_wait_timeout() fails, we won't release th=
e runlist ib. I am not sure it is by design or just a small bug. If it is b=
y design (probably for debugging
 when HWS hang), merging&nbsp;pm_send_unmap_queue and pm_release_ib togethe=
r will break the design.&nbsp;</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
If we agree to move in that direction, I agree with the part of the name ch=
anges because the original names are prone to cause confusion.</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
Regards,</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
Yong</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Kuehling, Felix &lt;F=
elix.Kuehling-5C7GfCeVMHo@public.gmane.org&gt;<br>
<b>Sent:</b> Friday, November 22, 2019 4:21 PM<br>
<b>To:</b> Zhao, Yong &lt;Yong.Zhao-5C7GfCeVMHo@public.gmane.org&gt;; amd-gfx-PD4FTy7X32lNgt0PjOBp9/rsn8yoX9R0@public.gmane.org=
org &lt;amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org&gt;<br>
<b>Subject:</b> Re: [PATCH 2/2] drm/amdkfd: Move pm_create_runlist_ib() out=
 of pm_send_runlist()</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">I'm not sure about this one. Looks like the interf=
ace is getting
<br>
needlessly more complicated. Now the caller has to keep track of the <br>
runlist IB address and size just to pass those to another function. I <br>
could understand this if there was a use case that needs to separate the <b=
r>
allocation of the runlist and sending it to the HW. But I don't see that.<b=
r>
<br>
Some background for why I think the interface is the way it is: The <br>
runlist IB is continuously executed by the HWS firmware. If the runlist <br=
>
is oversubscribed, the HWS firmware will loop through it. So the IB must <b=
r>
remain allocated until pm_send_unmap_queue is called. Currently <br>
pm_send_runlist creates the runlist IB and sends it to the HWS. You're <br>
separating that into creation and sending. Do you see a case where you <br>
need to send the same runlist multiple times? Or do something else <br>
between creating the runlist and sending it to the HWS?<br>
<br>
pm_release_ib releases the runlist IB, assuming that he HWS is no longer <b=
r>
using it. Maybe this could be combined with pm_send_unmap_queue. I'm not <b=
r>
100% sure because there are some filter parameters that may leave some <br>
queues mapped. If the two can be combined, I'd suggest the following <br>
name and interface changes to reflect how I think this is being used today:=
<br>
<br>
&nbsp; * pm_send_runlist -&gt; pm_create_and_send_runlist<br>
&nbsp; * pm_send_unmap_queue &#43; pm_release_ib -&gt; pm_preempt_and_free_=
runlist<br>
<br>
I see you're doing a lot of cleanup and refactoring in this area of the <br=
>
code. Is there some bigger picture here, some idea of the end-state <br>
you're trying to get to? Knowing where you're going with this may make <br>
it easier to review the code.<br>
<br>
Regards,<br>
&nbsp;&nbsp; Felix<br>
<br>
On 2019-11-21 4:26 p.m., Yong Zhao wrote:<br>
&gt; This is consistent with the calling sequence in unmap_queues_cpsch().<=
br>
&gt;<br>
&gt; Change-Id: Ieb6714422c812d4f6ebbece34e339871471e4b5e<br>
&gt; Signed-off-by: Yong Zhao &lt;Yong.Zhao-5C7GfCeVMHo@public.gmane.org&gt;<br>
&gt; ---<br>
&gt;&nbsp;&nbsp; .../drm/amd/amdkfd/kfd_device_queue_manager.c | 18 &#43;&#=
43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;--<br>
&gt;&nbsp;&nbsp; .../gpu/drm/amd/amdkfd/kfd_packet_manager.c&nbsp;&nbsp; | =
20 &#43;&#43;&#43;&#43;&#43;--------------<br>
&gt;&nbsp;&nbsp; drivers/gpu/drm/amd/amdkfd/kfd_priv.h&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp; 7 &#43;&#43;&#43;&#43;&#43;&#43;-<br>
&gt;&nbsp;&nbsp; 3 files changed, 27 insertions(&#43;), 18 deletions(-)<br>
&gt;<br>
&gt; diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c b/d=
rivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c<br>
&gt; index 510f2d1bb8bb..fd7d90136b94 100644<br>
&gt; --- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c<br>
&gt; &#43;&#43;&#43; b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.=
c<br>
&gt; @@ -1302,6 &#43;1302,8 @@ static int unmap_sdma_queues(struct device_q=
ueue_manager *dqm)<br>
&gt;&nbsp;&nbsp; static int map_queues_cpsch(struct device_queue_manager *d=
qm)<br>
&gt;&nbsp;&nbsp; {<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int retval;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; uint64_t rl_ib_gpu_addr;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; size_t rl_ib_size;<br>
&gt;&nbsp;&nbsp; <br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!dqm-&gt;sched_running)<=
br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; return 0;<br>
&gt; @@ -1310,15 &#43;1312,27 @@ static int map_queues_cpsch(struct device_=
queue_manager *dqm)<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (dqm-&gt;active_runlist)<=
br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; return 0;<br>
&gt;&nbsp;&nbsp; <br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; retval =3D pm_send_runlist(&amp;dqm-&gt;pack=
ets, &amp;dqm-&gt;queues);<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; retval =3D pm_create_runlist_ib(&amp;dqm=
-&gt;packets, &amp;dqm-&gt;queues,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp; &amp;rl_ib_gpu_addr, &amp;rl_ib_size);<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; if (retval)<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; goto fail_create_runlist_ib;<br>
&gt; &#43;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; pr_debug(&quot;runlist IB address: 0x%ll=
X\n&quot;, rl_ib_gpu_addr);<br>
&gt; &#43;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; retval =3D pm_send_runlist(&amp;dqm-&gt;=
packets, &amp;dqm-&gt;queues,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; rl_ib_gpu_addr, rl_=
ib_size);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pr_debug(&quot;%s sent runli=
st\n&quot;, __func__);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (retval) {<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; pr_err(&quot;failed to execute runlist\n&quot;);<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; return retval;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; goto fail_create_runlist_ib;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dqm-&gt;active_runlist =3D t=
rue;<br>
&gt;&nbsp;&nbsp; <br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return retval;<br>
&gt; &#43;<br>
&gt; &#43;fail_create_runlist_ib:<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; pm_destroy_runlist_ib(&amp;dqm-&gt;packe=
ts);<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; return retval;<br>
&gt;&nbsp;&nbsp; }<br>
&gt;&nbsp;&nbsp; <br>
&gt;&nbsp;&nbsp; /* dqm-&gt;lock mutex has to be locked before calling this=
 function */<br>
&gt; diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager.c b/drivers=
/gpu/drm/amd/amdkfd/kfd_packet_manager.c<br>
&gt; index 4a9433257428..6ec54e9f9392 100644<br>
&gt; --- a/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager.c<br>
&gt; &#43;&#43;&#43; b/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager.c<br>
&gt; @@ -116,7 &#43;116,7 @@ static int pm_allocate_runlist_ib(struct packe=
t_manager *pm,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return retval;<br>
&gt;&nbsp;&nbsp; }<br>
&gt;&nbsp;&nbsp; <br>
&gt; -static int pm_create_runlist_ib(struct packet_manager *pm,<br>
&gt; &#43;int pm_create_runlist_ib(struct packet_manager *pm,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct list_head *queues,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint64_t *rl_gpu_addr,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; size_t *rl_size_bytes)<br>
&gt; @@ -149,7 &#43;149,6 @@ static int pm_create_runlist_ib(struct packet_=
manager *pm,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; /* build map process packet */<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; if (proccesses_mapped &gt;=3D pm-&gt;dqm-&gt;processes_=
count) {<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pr_debu=
g(&quot;Not enough space left in runlist IB\n&quot;);<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pm_destroy_runlist_ib(p=
m);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return =
-ENOMEM;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; }<br>
&gt;&nbsp;&nbsp; <br>
&gt; @@ -299,20 &#43;298,13 @@ int pm_send_set_resources(struct packet_mana=
ger *pm,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return retval;<br>
&gt;&nbsp;&nbsp; }<br>
&gt;&nbsp;&nbsp; <br>
&gt; -int pm_send_runlist(struct packet_manager *pm, struct list_head *dqm_=
queues)<br>
&gt; &#43;int pm_send_runlist(struct packet_manager *pm, struct list_head *=
dqm_queues,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint64_t rl_ib_gpu_=
addr, size_t rl_ib_size)<br>
&gt;&nbsp;&nbsp; {<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; uint64_t rl_gpu_ib_addr;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t *rl_buffer;<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; size_t rl_ib_size, packet_size_dwords;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; size_t packet_size_dwords;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int retval;<br>
&gt;&nbsp;&nbsp; <br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; retval =3D pm_create_runlist_ib(pm, dqm_queu=
es, &amp;rl_gpu_ib_addr,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &a=
mp;rl_ib_size);<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; if (retval)<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; goto fail_create_runlist_ib;<br>
&gt; -<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; pr_debug(&quot;runlist IB address: 0x%llX\n&=
quot;, rl_gpu_ib_addr);<br>
&gt; -<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; packet_size_dwords =3D pm-&g=
t;pmf-&gt;runlist_size / sizeof(uint32_t);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mutex_lock(&amp;pm-&gt;lock)=
;<br>
&gt;&nbsp;&nbsp; <br>
&gt; @@ -321,7 &#43;313,7 @@ int pm_send_runlist(struct packet_manager *pm,=
 struct list_head *dqm_queues)<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (retval)<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; goto fail_acquire_packet_buffer;<br>
&gt;&nbsp;&nbsp; <br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; retval =3D pm-&gt;pmf-&gt;runlist(pm, rl_buf=
fer, rl_gpu_ib_addr,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; retval =3D pm-&gt;pmf-&gt;runlist(pm, rl=
_buffer, rl_ib_gpu_addr,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; rl_ib_size / sizeof(uint32_t), false);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (retval)<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; goto fail_create_runlist;<br>
&gt; @@ -336,8 &#43;328,6 @@ int pm_send_runlist(struct packet_manager *pm,=
 struct list_head *dqm_queues)<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; kq_rollback_packet(pm-&gt;pr=
iv_queue);<br>
&gt;&nbsp;&nbsp; fail_acquire_packet_buffer:<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mutex_unlock(&amp;pm-&gt;loc=
k);<br>
&gt; -fail_create_runlist_ib:<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; pm_destroy_runlist_ib(pm);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return retval;<br>
&gt;&nbsp;&nbsp; }<br>
&gt;&nbsp;&nbsp; <br>
&gt; diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h b/drivers/gpu/drm/a=
md/amdkfd/kfd_priv.h<br>
&gt; index 389cda7c8f1a..6accb605b9f0 100644<br>
&gt; --- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h<br>
&gt; &#43;&#43;&#43; b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h<br>
&gt; @@ -980,7 &#43;980,8 @@ int pm_init(struct packet_manager *pm, struct =
device_queue_manager *dqm);<br>
&gt;&nbsp;&nbsp; void pm_uninit(struct packet_manager *pm);<br>
&gt;&nbsp;&nbsp; int pm_send_set_resources(struct packet_manager *pm,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct scheduling_resources *res);=
<br>
&gt; -int pm_send_runlist(struct packet_manager *pm, struct list_head *dqm_=
queues);<br>
&gt; &#43;int pm_send_runlist(struct packet_manager *pm, struct list_head *=
dqm_queues,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; uint64_t rl_ib_gpu_addr, size_t rl_ib_size);<br>
&gt;&nbsp;&nbsp; int pm_send_query_status(struct packet_manager *pm, uint64=
_t fence_address,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t fence_value);<br>
&gt;&nbsp;&nbsp; <br>
&gt; @@ -989,6 &#43;990,10 @@ int pm_send_unmap_queue(struct packet_manager=
 *pm, enum kfd_queue_type type,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_=
t filter_param, bool reset,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; unsigne=
d int sdma_engine);<br>
&gt;&nbsp;&nbsp; <br>
&gt; &#43;int pm_create_runlist_ib(struct packet_manager *pm,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp; struct list_head *queues,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp; uint64_t *rl_gpu_addr,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp; size_t *rl_size_bytes);<br>
&gt;&nbsp;&nbsp; void pm_destroy_runlist_ib(struct packet_manager *pm);<br>
&gt;&nbsp;&nbsp; <br>
&gt;&nbsp;&nbsp; /* Following PM funcs can be shared among VI and AI */<br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_DM6PR12MB2778563A27C80EED222CD177F0490DM6PR12MB2778namp_--

--===============1265983940==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4

--===============1265983940==--
