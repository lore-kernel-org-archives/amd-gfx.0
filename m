From: "Deucher, Alexander" <Alexander.Deucher-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH v4] drm/scheduler: Avoid accessing freed bad job.
Date: Tue, 26 Nov 2019 15:36:57 +0000
Message-ID: <BN6PR12MB18093E836DB1098A42A3853AF7450@BN6PR12MB1809.namprd12.prod.outlook.com>
References: <1574715089-14875-1-git-send-email-andrey.grodzovsky@amd.com>,
 <MN2PR12MB2975C10E36FF996BD423CEBA8F4A0@MN2PR12MB2975.namprd12.prod.outlook.com>,
 <MWHPR12MB1453C6FC45A83482232CA3EDEA450@MWHPR12MB1453.namprd12.prod.outlook.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1220332163=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <MWHPR12MB1453C6FC45A83482232CA3EDEA450-Gy0DoCVfaSWZBIDmKHdw+wdYzm3356FpvxpqHgZTriW3zl9H0oFU5g@public.gmane.org>
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
To: "Grodzovsky, Andrey" <Andrey.Grodzovsky-5C7GfCeVMHo@public.gmane.org>, "Deng, Emily" <Emily.Deng-5C7GfCeVMHo@public.gmane.org>
Cc: "steven.price-5wv7dgnIgG8@public.gmane.org" <steven.price-5wv7dgnIgG8@public.gmane.org>, "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, "dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, "Koenig,
 Christian" <Christian.Koenig-5C7GfCeVMHo@public.gmane.org>

--===============1220332163==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_BN6PR12MB18093E836DB1098A42A3853AF7450BN6PR12MB1809namp_"

--_000_BN6PR12MB18093E836DB1098A42A3853AF7450BN6PR12MB1809namp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

I recently updated amd-staging-drm-next.  Apply whatever makes sense for no=
w and it'll naturally fall out in the next rebase.

Alex
________________________________
From: Grodzovsky, Andrey <Andrey.Grodzovsky-5C7GfCeVMHo@public.gmane.org>
Sent: Monday, November 25, 2019 7:09 PM
To: Deng, Emily <Emily.Deng-5C7GfCeVMHo@public.gmane.org>
Cc: dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org <dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>; amd-=
gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>; Koenig, Christia=
n <Christian.Koenig-5C7GfCeVMHo@public.gmane.org>; steven.price-5wv7dgnIgG8@public.gmane.org <steven.price-5wv7dgnIgG8@public.gmane.org>; =
Deucher, Alexander <Alexander.Deucher-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH v4] drm/scheduler: Avoid accessing freed bad job.

Christian asked to submit it to drm-misc instead of our drm-next to avoid l=
ater conflicts with Steven's patch which he mentioned in this thread which =
is not in drm-next yet.
Christian, Alex, once this merged to drm-misc I guess we need to pull all l=
atest changes from there to drm-next so the issue Emily reported can be avo=
ided.

Andrey

________________________________________
From: Deng, Emily <Emily.Deng-5C7GfCeVMHo@public.gmane.org>
Sent: 25 November 2019 16:44:36
To: Grodzovsky, Andrey
Cc: dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org; amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org; Koenig,=
 Christian; steven.price-5wv7dgnIgG8@public.gmane.org; Grodzovsky, Andrey
Subject: RE: [PATCH v4] drm/scheduler: Avoid accessing freed bad job.

[AMD Official Use Only - Internal Distribution Only]

Hi Andrey,
    Seems you didn't submit this patch?

Best wishes
Emily Deng



>-----Original Message-----
>From: Andrey Grodzovsky <andrey.grodzovsky-5C7GfCeVMHo@public.gmane.org>
>Sent: Monday, November 25, 2019 12:51 PM
>Cc: dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org; amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org; Koenig=
,
>Christian <Christian.Koenig-5C7GfCeVMHo@public.gmane.org>; Deng, Emily
><Emily.Deng-5C7GfCeVMHo@public.gmane.org>; steven.price-5wv7dgnIgG8@public.gmane.org; Grodzovsky, Andrey
><Andrey.Grodzovsky-5C7GfCeVMHo@public.gmane.org>
>Subject: [PATCH v4] drm/scheduler: Avoid accessing freed bad job.
>
>Problem:
>Due to a race between drm_sched_cleanup_jobs in sched thread and
>drm_sched_job_timedout in timeout work there is a possiblity that bad job
>was already freed while still being accessed from the timeout thread.
>
>Fix:
>Instead of just peeking at the bad job in the mirror list remove it from t=
he list
>under lock and then put it back later when we are garanteed no race with
>main sched thread is possible which is after the thread is parked.
>
>v2: Lock around processing ring_mirror_list in drm_sched_cleanup_jobs.
>
>v3: Rebase on top of drm-misc-next. v2 is not needed anymore as
>drm_sched_get_cleanup_job already has a lock there.
>
>v4: Fix comments to relfect latest code in drm-misc.
>
>Signed-off-by: Andrey Grodzovsky <andrey.grodzovsky-5C7GfCeVMHo@public.gmane.org>
>Reviewed-by: Christian K=F6nig <christian.koenig-5C7GfCeVMHo@public.gmane.org>
>Tested-by: Emily Deng <Emily.Deng-5C7GfCeVMHo@public.gmane.org>
>---
> drivers/gpu/drm/scheduler/sched_main.c | 27
>+++++++++++++++++++++++++++
> 1 file changed, 27 insertions(+)
>
>diff --git a/drivers/gpu/drm/scheduler/sched_main.c
>b/drivers/gpu/drm/scheduler/sched_main.c
>index 6774955..1bf9c40 100644
>--- a/drivers/gpu/drm/scheduler/sched_main.c
>+++ b/drivers/gpu/drm/scheduler/sched_main.c
>@@ -284,10 +284,21 @@ static void drm_sched_job_timedout(struct
>work_struct *work)
>       unsigned long flags;
>
>       sched =3D container_of(work, struct drm_gpu_scheduler,
>work_tdr.work);
>+
>+      /* Protects against concurrent deletion in
>drm_sched_get_cleanup_job */
>+      spin_lock_irqsave(&sched->job_list_lock, flags);
>       job =3D list_first_entry_or_null(&sched->ring_mirror_list,
>                                      struct drm_sched_job, node);
>
>       if (job) {
>+              /*
>+               * Remove the bad job so it cannot be freed by concurrent
>+               * drm_sched_cleanup_jobs. It will be reinserted back after
>sched->thread
>+               * is parked at which point it's safe.
>+               */
>+              list_del_init(&job->node);
>+              spin_unlock_irqrestore(&sched->job_list_lock, flags);
>+
>               job->sched->ops->timedout_job(job);
>
>               /*
>@@ -298,6 +309,8 @@ static void drm_sched_job_timedout(struct
>work_struct *work)
>                       job->sched->ops->free_job(job);
>                       sched->free_guilty =3D false;
>               }
>+      } else {
>+              spin_unlock_irqrestore(&sched->job_list_lock, flags);
>       }
>
>       spin_lock_irqsave(&sched->job_list_lock, flags); @@ -370,6 +383,20
>@@ void drm_sched_stop(struct drm_gpu_scheduler *sched, struct
>drm_sched_job *bad)
>       kthread_park(sched->thread);
>
>       /*
>+       * Reinsert back the bad job here - now it's safe as
>+       * drm_sched_get_cleanup_job cannot race against us and release the
>+       * bad job at this point - we parked (waited for) any in progress
>+       * (earlier) cleanups and drm_sched_get_cleanup_job will not be
>called
>+       * now until the scheduler thread is unparked.
>+       */
>+      if (bad && bad->sched =3D=3D sched)
>+              /*
>+               * Add at the head of the queue to reflect it was the earli=
est
>+               * job extracted.
>+               */
>+              list_add(&bad->node, &sched->ring_mirror_list);
>+
>+      /*
>        * Iterate the job list from later to  earlier one and either deact=
ive
>        * their HW callbacks or remove them from mirror list if they alrea=
dy
>        * signaled.
>--
>2.7.4

--_000_BN6PR12MB18093E836DB1098A42A3853AF7450BN6PR12MB1809namp_
Content-Type: text/html; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Diso-8859-=
1">
<style type=3D"text/css" style=3D"display:none;"> P {margin-top:0;margin-bo=
ttom:0;} </style>
</head>
<body dir=3D"ltr">
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
I recently updated amd-staging-drm-next.&nbsp; Apply whatever makes sense f=
or now and it'll naturally fall out in the next rebase.</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
Alex<br>
</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Grodzovsky, Andrey &l=
t;Andrey.Grodzovsky-5C7GfCeVMHo@public.gmane.org&gt;<br>
<b>Sent:</b> Monday, November 25, 2019 7:09 PM<br>
<b>To:</b> Deng, Emily &lt;Emily.Deng-5C7GfCeVMHo@public.gmane.org&gt;<br>
<b>Cc:</b> dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org &lt;dri-devel-PD4FTy7X32lNgt0PjOBp9/rsn8yoX9R0@public.gmane.org=
org&gt;; amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org &lt;amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org&gt=
;; Koenig, Christian &lt;Christian.Koenig-5C7GfCeVMHo@public.gmane.org&gt;; steven.price-5wv7dgnIgG8@public.gmane.org=
 &lt;steven.price-5wv7dgnIgG8@public.gmane.org&gt;; Deucher, Alexander &lt;Alexander.Deucher@amd=
.com&gt;<br>
<b>Subject:</b> Re: [PATCH v4] drm/scheduler: Avoid accessing freed bad job=
.</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">Christian asked to submit it to drm-misc instead o=
f our drm-next to avoid later conflicts with Steven's patch which he mentio=
ned in this thread which is not in drm-next yet.<br>
Christian, Alex, once this merged to drm-misc I guess we need to pull all l=
atest changes from there to drm-next so the issue Emily reported can be avo=
ided.<br>
<br>
Andrey<br>
<br>
________________________________________<br>
From: Deng, Emily &lt;Emily.Deng-5C7GfCeVMHo@public.gmane.org&gt;<br>
Sent: 25 November 2019 16:44:36<br>
To: Grodzovsky, Andrey<br>
Cc: dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org; amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org; Koenig,=
 Christian; steven.price-5wv7dgnIgG8@public.gmane.org; Grodzovsky, Andrey<br>
Subject: RE: [PATCH v4] drm/scheduler: Avoid accessing freed bad job.<br>
<br>
[AMD Official Use Only - Internal Distribution Only]<br>
<br>
Hi Andrey,<br>
&nbsp;&nbsp;&nbsp; Seems you didn't submit this patch?<br>
<br>
Best wishes<br>
Emily Deng<br>
<br>
<br>
<br>
&gt;-----Original Message-----<br>
&gt;From: Andrey Grodzovsky &lt;andrey.grodzovsky-5C7GfCeVMHo@public.gmane.org&gt;<br>
&gt;Sent: Monday, November 25, 2019 12:51 PM<br>
&gt;Cc: dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org; amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org; Koe=
nig,<br>
&gt;Christian &lt;Christian.Koenig-5C7GfCeVMHo@public.gmane.org&gt;; Deng, Emily<br>
&gt;&lt;Emily.Deng-5C7GfCeVMHo@public.gmane.org&gt;; steven.price-5wv7dgnIgG8@public.gmane.org; Grodzovsky, Andrey<br=
>
&gt;&lt;Andrey.Grodzovsky-5C7GfCeVMHo@public.gmane.org&gt;<br>
&gt;Subject: [PATCH v4] drm/scheduler: Avoid accessing freed bad job.<br>
&gt;<br>
&gt;Problem:<br>
&gt;Due to a race between drm_sched_cleanup_jobs in sched thread and<br>
&gt;drm_sched_job_timedout in timeout work there is a possiblity that bad j=
ob<br>
&gt;was already freed while still being accessed from the timeout thread.<b=
r>
&gt;<br>
&gt;Fix:<br>
&gt;Instead of just peeking at the bad job in the mirror list remove it fro=
m the list<br>
&gt;under lock and then put it back later when we are garanteed no race wit=
h<br>
&gt;main sched thread is possible which is after the thread is parked.<br>
&gt;<br>
&gt;v2: Lock around processing ring_mirror_list in drm_sched_cleanup_jobs.<=
br>
&gt;<br>
&gt;v3: Rebase on top of drm-misc-next. v2 is not needed anymore as<br>
&gt;drm_sched_get_cleanup_job already has a lock there.<br>
&gt;<br>
&gt;v4: Fix comments to relfect latest code in drm-misc.<br>
&gt;<br>
&gt;Signed-off-by: Andrey Grodzovsky &lt;andrey.grodzovsky-5C7GfCeVMHo@public.gmane.org&gt;<br>
&gt;Reviewed-by: Christian K=F6nig &lt;christian.koenig-5C7GfCeVMHo@public.gmane.org&gt;<br>
&gt;Tested-by: Emily Deng &lt;Emily.Deng-5C7GfCeVMHo@public.gmane.org&gt;<br>
&gt;---<br>
&gt; drivers/gpu/drm/scheduler/sched_main.c | 27<br>
&gt;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&=
#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;<br>
&gt; 1 file changed, 27 insertions(&#43;)<br>
&gt;<br>
&gt;diff --git a/drivers/gpu/drm/scheduler/sched_main.c<br>
&gt;b/drivers/gpu/drm/scheduler/sched_main.c<br>
&gt;index 6774955..1bf9c40 100644<br>
&gt;--- a/drivers/gpu/drm/scheduler/sched_main.c<br>
&gt;&#43;&#43;&#43; b/drivers/gpu/drm/scheduler/sched_main.c<br>
&gt;@@ -284,10 &#43;284,21 @@ static void drm_sched_job_timedout(struct<br>
&gt;work_struct *work)<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; unsigned long flags;<br>
&gt;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; sched =3D container_of(work, struc=
t drm_gpu_scheduler,<br>
&gt;work_tdr.work);<br>
&gt;&#43;<br>
&gt;&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Protects against concurrent dele=
tion in<br>
&gt;drm_sched_get_cleanup_job */<br>
&gt;&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; spin_lock_irqsave(&amp;sched-&gt;jo=
b_list_lock, flags);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; job =3D list_first_entry_or_null(&=
amp;sched-&gt;ring_mirror_list,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
; struct drm_sched_job, node);<br>
&gt;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (job) {<br>
&gt;&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp; /*<br>
&gt;&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp; * Remove the bad job so it cannot be freed by concurrent=
<br>
&gt;&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp; * drm_sched_cleanup_jobs. It will be reinserted back aft=
er<br>
&gt;sched-&gt;thread<br>
&gt;&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp; * is parked at which point it's safe.<br>
&gt;&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp; */<br>
&gt;&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp; list_del_init(&amp;job-&gt;node);<br>
&gt;&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp; spin_unlock_irqrestore(&amp;sched-&gt;job_list_lock, flags);<b=
r>
&gt;&#43;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; job-&gt;sched-&gt;ops-&gt;timedout_job(job);<br>
&gt;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; /*<br>
&gt;@@ -298,6 &#43;309,8 @@ static void drm_sched_job_timedout(struct<br>
&gt;work_struct *work)<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; job-&gt;sched=
-&gt;ops-&gt;free_job(job);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; sched-&gt;fre=
e_guilty =3D false;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; }<br>
&gt;&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } else {<br>
&gt;&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp; spin_unlock_irqrestore(&amp;sched-&gt;job_list_lock, flags);<b=
r>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; spin_lock_irqsave(&amp;sched-&gt;j=
ob_list_lock, flags); @@ -370,6 &#43;383,20<br>
&gt;@@ void drm_sched_stop(struct drm_gpu_scheduler *sched, struct<br>
&gt;drm_sched_job *bad)<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; kthread_park(sched-&gt;thread);<br=
>
&gt;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /*<br>
&gt;&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * Reinsert back the bad job h=
ere - now it's safe as<br>
&gt;&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * drm_sched_get_cleanup_job c=
annot race against us and release the<br>
&gt;&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * bad job at this point - we =
parked (waited for) any in progress<br>
&gt;&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * (earlier) cleanups and drm_=
sched_get_cleanup_job will not be<br>
&gt;called<br>
&gt;&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * now until the scheduler thr=
ead is unparked.<br>
&gt;&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; */<br>
&gt;&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (bad &amp;&amp; bad-&gt;sched =
=3D=3D sched)<br>
&gt;&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp; /*<br>
&gt;&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp; * Add at the head of the queue to reflect it was the ear=
liest<br>
&gt;&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp; * job extracted.<br>
&gt;&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp; */<br>
&gt;&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp; list_add(&amp;bad-&gt;node, &amp;sched-&gt;ring_mirror_list);<=
br>
&gt;&#43;<br>
&gt;&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /*<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * Iterate the job list from =
later to&nbsp; earlier one and either deactive<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * their HW callbacks or remo=
ve them from mirror list if they already<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * signaled.<br>
&gt;--<br>
&gt;2.7.4<br>
</div>
</span></font></div>
</body>
</html>

--_000_BN6PR12MB18093E836DB1098A42A3853AF7450BN6PR12MB1809namp_--

--===============1220332163==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4

--===============1220332163==--
