From: "Deucher, Alexander" <Alexander.Deucher-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH 15/24] drm/amd/display: Fix deadlock when flushing irq
Date: Mon, 22 Jan 2018 17:23:20 +0000
Message-ID: <BN6PR12MB16529F8B185DE71E994EC7A9F7EC0@BN6PR12MB1652.namprd12.prod.outlook.com>
References: <20180118210353.18842-1-harry.wentland@amd.com>
 <20180118210353.18842-16-harry.wentland@amd.com>
 <2996fec0-814d-ec58-788b-883df20d2651@amd.com>
 <BN6PR1201MB0100D9415FC07D00CBE859CCE4EF0@BN6PR1201MB0100.namprd12.prod.outlook.com>
 <a5d20d38-760e-a4ef-5f79-8774e70f3a4c@amd.com>
 <fd132165-4c3e-09e4-ec1c-d583263a2917@amd.com>,
 <98d53b0d-855f-1702-3c10-2b11ec416cc3@amd.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1973982383=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <98d53b0d-855f-1702-3c10-2b11ec416cc3-5C7GfCeVMHo@public.gmane.org>
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
To: "Grodzovsky, Andrey" <Andrey.Grodzovsky-5C7GfCeVMHo@public.gmane.org>, "Wentland, Harry" <Harry.Wentland-5C7GfCeVMHo@public.gmane.org>, "Lipski, Mikita" <Mikita.Lipski-5C7GfCeVMHo@public.gmane.org>, "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

--===============1973982383==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_BN6PR12MB16529F8B185DE71E994EC7A9F7EC0BN6PR12MB1652namp_"

--_000_BN6PR12MB16529F8B185DE71E994EC7A9F7EC0BN6PR12MB1652namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Thanks for verifying.  Sent out for review.


Alex

________________________________
From: Grodzovsky, Andrey
Sent: Monday, January 22, 2018 11:01:36 AM
To: Wentland, Harry; Lipski, Mikita; amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org; Deucher=
, Alexander
Subject: Re: [PATCH 15/24] drm/amd/display: Fix deadlock when flushing irq

NP.

Alex just a reminder to push your patch from SWDEV-143068 into the tree.

Thanks,

Andrey



On 01/22/2018 10:53 AM, Harry Wentland wrote:
> On 2018-01-22 09:57 AM, Andrey Grodzovsky wrote:
>> You guys just need to revert it on dal-dev branch and don't promote to a=
md-staging-drm-next.
>>
> K. I'll leave it out of amd-staging-drm-next and we'll revert on our inte=
rnal branch.
>
> Thanks for following up on this and good to hear we found a better soluti=
on.
>
> Harry
>
>> So NAK for the change.
>>
>>
>>
>> Thanks,
>>
>> Andrey
>>
>>
>> On 01/22/2018 09:38 AM, Lipski, Mikita wrote:
>>> Hi Andrey,
>>>
>>>
>>> I've checked to revert this change and use Alex's change on switching i=
rq destruction sequence and it worked no problem.
>>> You can reject this change if Alex's change is pulled in.
>>>
>>>
>>> Thanks,
>>>
>>> Nick
>>>
>>> -----------------------------------------------------------------------=
---------------------------------------------------------------------------=
---------------------------------------------------------------------------=
---------------------------------------------------------------------------=
---------------------------------------------------------------------------=
---------------------------------------------------------------------------=
---------------------------------------------------------------------------=
---------------------------------------------------------------------------=
---------------------------------------------------------------------------=
---------------------------------------------------------------------------=
---------------------------------------------------------------------------=
---------------------------------------------------------------------------=
---------------------------------------------------------------------------=
-------------------
>>> *From:* Grodzovsky, Andrey
>>> *Sent:* Friday, January 19, 2018 1:33:51 PM
>>> *To:* Wentland, Harry; amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
>>> *Cc:* Lipski, Mikita
>>> *Subject:* Re: [PATCH 15/24] drm/amd/display: Fix deadlock when flushin=
g irq
>>>
>>> What this spin lock is protecting here ? Seems to me it's just a read o=
f
>>> an array element which is always there.
>>>
>>> Regarding subsequent remove_timer_handler and timer queue destruction i=
t
>>> seems to me to be obsolete code, I don't think DAL is still using the
>>> timer queue,
>>>
>>> so seems to me everything related to it should be removed.
>>>
>>> Thanks,
>>>
>>> Andrey
>>>
>>>
>>> On 01/18/2018 04:03 PM, Harry Wentland wrote:
>>>> From: Mikita Lipski <mikita.lipski-5C7GfCeVMHo@public.gmane.org>
>>>>
>>>> Lock irq table when reading a work in queue,
>>>> unlock to flush the work, lock again till all tasks
>>>> are cleared
>>>>
>>>> Signed-off-by: Mikita Lipski <mikita.lipski-5C7GfCeVMHo@public.gmane.org>
>>>> Reviewed-by: Harry Wentland <Harry.Wentland-5C7GfCeVMHo@public.gmane.org>
>>>> ---
>>>>     drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_irq.c | 5 +++--
>>>>     1 file changed, 3 insertions(+), 2 deletions(-)
>>>>
>>>> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_irq.c b/d=
rivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_irq.c
>>>> index 1874b6cee6af..fb60c91a1bfe 100644
>>>> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_irq.c
>>>> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_irq.c
>>>> @@ -400,14 +400,15 @@ void amdgpu_dm_irq_fini(struct amdgpu_device *ad=
ev)
>>>>     {
>>>>          int src;
>>>>          struct irq_list_head *lh;
>>>> +     unsigned long irq_table_flags;
>>>>          DRM_DEBUG_KMS("DM_IRQ: releasing resources.\n");
>>>> -
>>>>          for (src =3D 0; src < DAL_IRQ_SOURCES_NUMBER; src++) {
>>>> -
>>>> +             DM_IRQ_TABLE_LOCK(adev, irq_table_flags);
>>>>                  /* The handler was removed from the table,
>>>>                   * it means it is safe to flush all the 'work'
>>>>                   * (because no code can schedule a new one). */
>>>>                  lh =3D &adev->dm.irq_handler_list_low_tab[src];
>>>> +             DM_IRQ_TABLE_UNLOCK(adev, irq_table_flags);
>>>>                  flush_work(&lh->work);
>>>>          }
>>>>



--_000_BN6PR12MB16529F8B185DE71E994EC7A9F7EC0BN6PR12MB1652namp_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
<style type=3D"text/css" style=3D"display:none;"><!-- P {margin-top:0;margi=
n-bottom:0;} --></style>
</head>
<body dir=3D"ltr">
<div id=3D"divtagdefaultwrapper" style=3D"font-size:12pt;color:#000000;font=
-family:Calibri,Helvetica,sans-serif;" dir=3D"ltr">
<p style=3D"margin-top:0;margin-bottom:0">Thanks for verifying.&nbsp; Sent =
out for review.</p>
<p style=3D"margin-top:0;margin-bottom:0"><br>
</p>
<p style=3D"margin-top:0;margin-bottom:0">Alex<br>
</p>
</div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Grodzovsky, Andrey<br=
>
<b>Sent:</b> Monday, January 22, 2018 11:01:36 AM<br>
<b>To:</b> Wentland, Harry; Lipski, Mikita; amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org; =
Deucher, Alexander<br>
<b>Subject:</b> Re: [PATCH 15/24] drm/amd/display: Fix deadlock when flushi=
ng irq</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">NP.<br>
<br>
Alex just a reminder to push your patch from SWDEV-143068 into the tree.<br=
>
<br>
Thanks,<br>
<br>
Andrey<br>
<br>
<br>
<br>
On 01/22/2018 10:53 AM, Harry Wentland wrote:<br>
&gt; On 2018-01-22 09:57 AM, Andrey Grodzovsky wrote:<br>
&gt;&gt; You guys just need to revert it on dal-dev branch and don't promot=
e to amd-staging-drm-next.<br>
&gt;&gt;<br>
&gt; K. I'll leave it out of amd-staging-drm-next and we'll revert on our i=
nternal branch.<br>
&gt;<br>
&gt; Thanks for following up on this and good to hear we found a better sol=
ution.<br>
&gt;<br>
&gt; Harry<br>
&gt;<br>
&gt;&gt; So NAK for the change.<br>
&gt;&gt;<br>
&gt;&gt;<br>
&gt;&gt;<br>
&gt;&gt; Thanks,<br>
&gt;&gt;<br>
&gt;&gt; Andrey<br>
&gt;&gt;<br>
&gt;&gt;<br>
&gt;&gt; On 01/22/2018 09:38 AM, Lipski, Mikita wrote:<br>
&gt;&gt;&gt; Hi Andrey,<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; I've checked to revert this change and use Alex's change on sw=
itching irq destruction sequence and it worked no problem.<br>
&gt;&gt;&gt; You can reject this change if Alex's change is pulled in.<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; Thanks,<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; Nick<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; --------------------------------------------------------------=
---------------------------------------------------------------------------=
---------------------------------------------------------------------------=
---------------------------------------------------------------------------=
---------------------------------------------------------------------------=
---------------------------------------------------------------------------=
---------------------------------------------------------------------------=
---------------------------------------------------------------------------=
---------------------------------------------------------------------------=
---------------------------------------------------------------------------=
---------------------------------------------------------------------------=
---------------------------------------------------------------------------=
---------------------------------------------------------------------------=
----------------------------<br>
&gt;&gt;&gt; *From:* Grodzovsky, Andrey<br>
&gt;&gt;&gt; *Sent:* Friday, January 19, 2018 1:33:51 PM<br>
&gt;&gt;&gt; *To:* Wentland, Harry; amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<br>
&gt;&gt;&gt; *Cc:* Lipski, Mikita<br>
&gt;&gt;&gt; *Subject:* Re: [PATCH 15/24] drm/amd/display: Fix deadlock whe=
n flushing irq<br>
&gt;&gt;&gt;&nbsp;&nbsp; <br>
&gt;&gt;&gt; What this spin lock is protecting here ? Seems to me it's just=
 a read of<br>
&gt;&gt;&gt; an array element which is always there.<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; Regarding subsequent remove_timer_handler and timer queue dest=
ruction it<br>
&gt;&gt;&gt; seems to me to be obsolete code, I don't think DAL is still us=
ing the<br>
&gt;&gt;&gt; timer queue,<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; so seems to me everything related to it should be removed.<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; Thanks,<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; Andrey<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; On 01/18/2018 04:03 PM, Harry Wentland wrote:<br>
&gt;&gt;&gt;&gt; From: Mikita Lipski &lt;mikita.lipski-5C7GfCeVMHo@public.gmane.org&gt;<br>
&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt; Lock irq table when reading a work in queue,<br>
&gt;&gt;&gt;&gt; unlock to flush the work, lock again till all tasks<br>
&gt;&gt;&gt;&gt; are cleared<br>
&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt; Signed-off-by: Mikita Lipski &lt;mikita.lipski-5C7GfCeVMHo@public.gmane.org&gt;=
<br>
&gt;&gt;&gt;&gt; Reviewed-by: Harry Wentland &lt;Harry.Wentland-5C7GfCeVMHo@public.gmane.org&gt;=
<br>
&gt;&gt;&gt;&gt; ---<br>
&gt;&gt;&gt;&gt;&nbsp; &nbsp;&nbsp; drivers/gpu/drm/amd/display/amdgpu_dm/a=
mdgpu_dm_irq.c | 5 &#43;&#43;&#43;--<br>
&gt;&gt;&gt;&gt;&nbsp; &nbsp;&nbsp; 1 file changed, 3 insertions(&#43;), 2 =
deletions(-)<br>
&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt; diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_=
dm_irq.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_irq.c<br>
&gt;&gt;&gt;&gt; index 1874b6cee6af..fb60c91a1bfe 100644<br>
&gt;&gt;&gt;&gt; --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_irq.=
c<br>
&gt;&gt;&gt;&gt; &#43;&#43;&#43; b/drivers/gpu/drm/amd/display/amdgpu_dm/am=
dgpu_dm_irq.c<br>
&gt;&gt;&gt;&gt; @@ -400,14 &#43;400,15 @@ void amdgpu_dm_irq_fini(struct a=
mdgpu_device *adev)<br>
&gt;&gt;&gt;&gt;&nbsp; &nbsp;&nbsp; {<br>
&gt;&gt;&gt;&gt;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int src;<=
br>
&gt;&gt;&gt;&gt;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct ir=
q_list_head *lh;<br>
&gt;&gt;&gt;&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; unsigned long irq_table_flag=
s;<br>
&gt;&gt;&gt;&gt;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; DRM_DEBUG=
_KMS(&quot;DM_IRQ: releasing resources.\n&quot;);<br>
&gt;&gt;&gt;&gt; -<br>
&gt;&gt;&gt;&gt;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; for (src =
=3D 0; src &lt; DAL_IRQ_SOURCES_NUMBER; src&#43;&#43;) {<br>
&gt;&gt;&gt;&gt; -<br>
&gt;&gt;&gt;&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; DM_IRQ_TABLE_LOCK(adev, irq_table_flags);<br>
&gt;&gt;&gt;&gt;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* The handler was removed from the =
table,<br>
&gt;&gt;&gt;&gt;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * it means it is safe to flush=
 all the 'work'<br>
&gt;&gt;&gt;&gt;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * (because no code can schedul=
e a new one). */<br>
&gt;&gt;&gt;&gt;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; lh =3D &amp;adev-&gt;dm.irq_handler_=
list_low_tab[src];<br>
&gt;&gt;&gt;&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; DM_IRQ_TABLE_UNLOCK(adev, irq_table_flags);<br>
&gt;&gt;&gt;&gt;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; flush_work(&amp;lh-&gt;work);<br>
&gt;&gt;&gt;&gt;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp; <br>
<br>
<br>
</div>
</span></font></div>
</body>
</html>

--_000_BN6PR12MB16529F8B185DE71E994EC7A9F7EC0BN6PR12MB1652namp_--

--===============1973982383==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============1973982383==--
