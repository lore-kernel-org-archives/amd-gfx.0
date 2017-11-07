From: "Zhou, David(ChunMing)" <David1.Zhou-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH 1/2] drm/amdgpu: use multipipe compute policy on non PL11
 asics
Date: Tue, 7 Nov 2017 03:19:01 +0000
Message-ID: <MWHPR1201MB0206CEC26FF751CB39B529D6B4510@MWHPR1201MB0206.namprd12.prod.outlook.com>
References: <20170926162246.3200-1-andresx7@gmail.com>
 <20170926162246.3200-2-andresx7@gmail.com>
 <b9de7b08-8239-d860-0d6b-19c9f63ecfe7@amd.com>
 <2200a1fa-d1d3-bd92-825d-987ecd355dac@gmail.com>,
 <CAFQ_0eFcs+DLu6sEEEtX1GJU+ccb1B2bHPSkrAdk3OUVfqq3zg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0928272734=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <CAFQ_0eFcs+DLu6sEEEtX1GJU+ccb1B2bHPSkrAdk3OUVfqq3zg-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
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
To: Andres Rodriguez <andresx7-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, amd-gfx list <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
Cc: "Deucher, Alexander" <Alexander.Deucher-5C7GfCeVMHo@public.gmane.org>

--===============0928272734==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_MWHPR1201MB0206CEC26FF751CB39B529D6B4510MWHPR1201MB0206_"

--_000_MWHPR1201MB0206CEC26FF751CB39B529D6B4510MWHPR1201MB0206_
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable

Then snychronization should have no problem, it maybe relate to multipipe h=
w setting issue.


Regards,

David Zhou

________________________________
From: Andres Rodriguez <andresx7-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sent: Tuesday, November 7, 2017 2:00:57 AM
To: Zhou, David(ChunMing); amd-gfx list
Cc: Deucher, Alexander
Subject: Re: [PATCH 1/2] drm/amdgpu: use multipipe compute policy on non PL=
11 asics

Sorry my mail client seems to have blown up. My reply got cut off,
here is the full version:



On 2017-11-06 01:49 AM, Chunming Zhou wrote:
> Hi Andres,
>
Hi David,

> With your this patch, OCLperf hung.
Is this on all ASICs or just a specific one?

>
> Could you explain more?
>
> If I am correctly, the difference of with and without this patch is
> setting first two queue or setting all queues of pipe0 to queue_bitmap.
It is slightly different. With this patch we will also use the first
two queues of all pipes, not just pipe 0;

Pre-patch:

|-Pipe 0-||-Pipe 1-||-Pipe 2-||-Pipe 3-|
 11111111  00000000  00000000  00000000

Post-patch:

|-Pipe 0-||-Pipe 1-||-Pipe 2-||-Pipe 3-|
 11000000  11000000  11000000  11000000

What this means is that we are allowing real multithreading for
compute. Jobs on different pipes allow for parallel execution of work.
Jobs on the same pipe (but different queues) use timeslicing to share
the hardware.


>
> Then UMD can use different number queue to submit command for compute
> selected by amdgpu_queue_mgr_map.
>
> I checked amdgpu_queue_mgr_map implementation,  CS_IOCTL can map user
> ring to different hw ring depending on busy or idle, right?
Yes, when a queue is first used, amdgpu_queue_mgr_map will decide what
the mapping is for a usermode ring to a kernel ring id.

> If yes, I see a bug in it, which will result in our sched_fence not
> work. Our sched fence assumes the job will be executed in order, your
> mapping queue breaks this.

I think here you mean that work will execute out of order because it
will go to different rings?

That should not happen, since the id mapping is permanent on a
per-context basis. Once a mapping is decided, it will be cached for
this context so that we keep execution order guarantees. See the
id-caching code in amdgpu_queue_mgr.c for reference.

As long as the usermode keeps submitting work to the same ring, it
will all be executed in order (all in the same ring). There is no
change in this guarantee compared to pre-patch. Note that even before
this patch amdgpu_queue_mgr_map has been using an LRU policy for a
long time now.

Regards,
Andres

On Mon, Nov 6, 2017 at 12:44 PM, Andres Rodriguez <andresx7-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrot=
e:
>
>
> On 2017-11-06 01:49 AM, Chunming Zhou wrote:
>>
>> Hi Andres,
>>
>
> Hi David,
>
>> With your this patch, OCLperf hung.
>
>
> Is this on all ASICs or just a specific one?
>
>>
>> Could you explain more?
>>
>> If I am correctly, the difference of with and without this patch is
>> setting first two queue or setting all queues of pipe0 to queue_bitmap.
>
>
> It is slightly different. With this patch we will also use the first two
> queues of all pipes, not just pipe 0;
>
> Pre-patch:
>
> |-Pipe 0-||-Pipe 1-||-Pipe 2-||-Pipe 3-|
>  11111111  00000000  00000000  00000000
>
> Post-patch:
>
> |-Pipe 0-||-Pipe 1-||-Pipe 2-||-Pipe 3-|
>  11000000  11000000  11000000  11000000
>
> What this means is that we are allowing real multithreading for compute.
> Jobs on different pipes allow for parallel execution of work. Jobs on the
> same pipe (but different queues) use timeslicing to share the hardware.
>
>
>
>>
>> Then UMD can use different number queue to submit command for compute
>> selected by amdgpu_queue_mgr_map.
>>
>> I checked amdgpu_queue_mgr_map implementation,  CS_IOCTL can map user ri=
ng
>> to different hw ring depending on busy or idle, right?
>>
>> If yes, I see a bug in it, which will result in our sched_fence not work=
.
>> Our sched fence assumes the job will be executed in order, your mapping
>> queue breaks this.
>>
>>
>> Regards,
>>
>> David Zhou
>>
>>
>> On 2017=1B$BG/=1B(B09=1B$B7n=1B(B27=1B$BF|=1B(B 00:22, Andres Rodriguez =
wrote:
>>>
>>> A performance regression for OpenCL tests on Polaris11 had this feature
>>> disabled for all asics.
>>>
>>> Instead, disable it selectively on the affected asics.
>>>
>>> Signed-off-by: Andres Rodriguez <andresx7-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
>>> ---
>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c | 14 ++++++++++++--
>>>   1 file changed, 12 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
>>> index 4f6c68f..3d76e76 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
>>> @@ -109,9 +109,20 @@ void amdgpu_gfx_parse_disable_cu(unsigned *mask,
>>> unsigned max_se, unsigned max_s
>>>       }
>>>   }
>>> +static bool amdgpu_gfx_is_multipipe_capable(struct amdgpu_device *adev=
)
>>> +{
>>> +    /* FIXME: spreading the queues across pipes causes perf regression=
s
>>> +     * on POLARIS11 compute workloads */
>>> +    if (adev->asic_type =3D=3D CHIP_POLARIS11)
>>> +        return false;
>>> +
>>> +    return adev->gfx.mec.num_mec > 1;
>>> +}
>>> +
>>>   void amdgpu_gfx_compute_queue_acquire(struct amdgpu_device *adev)
>>>   {
>>>       int i, queue, pipe, mec;
>>> +    bool multipipe_policy =3D amdgpu_gfx_is_multipipe_capable(adev);
>>>       /* policy for amdgpu compute queue ownership */
>>>       for (i =3D 0; i < AMDGPU_MAX_COMPUTE_QUEUES; ++i) {
>>> @@ -125,8 +136,7 @@ void amdgpu_gfx_compute_queue_acquire(struct
>>> amdgpu_device *adev)
>>>           if (mec >=3D adev->gfx.mec.num_mec)
>>>               break;
>>> -        /* FIXME: spreading the queues across pipes causes perf
>>> regressions */
>>> -        if (0) {
>>> +        if (multipipe_policy) {
>>>               /* policy: amdgpu owns the first two queues of the first
>>> MEC */
>>>               if (mec =3D=3D 0 && queue < 2)
>>>                   set_bit(i, adev->gfx.mec.queue_bitmap);
>>
>>
>

--_000_MWHPR1201MB0206CEC26FF751CB39B529D6B4510MWHPR1201MB0206_
Content-Type: text/html; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Diso-2022-=
jp">
<style type=3D"text/css" style=3D"display:none;"><!-- P {margin-top:0;margi=
n-bottom:0;} --></style>
</head>
<body dir=3D"ltr">
<div id=3D"divtagdefaultwrapper" style=3D"font-size:12pt;color:#000000;font=
-family:Calibri,Helvetica,sans-serif;" dir=3D"ltr">
<p>Then snychronization should have no problem, it maybe relate to multipip=
e hw setting issue.</p>
<p><br>
</p>
<p>Regards,</p>
<p>David Zhou<br>
</p>
</div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Andres Rodriguez &lt;=
andresx7-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org&gt;<br>
<b>Sent:</b> Tuesday, November 7, 2017 2:00:57 AM<br>
<b>To:</b> Zhou, David(ChunMing); amd-gfx list<br>
<b>Cc:</b> Deucher, Alexander<br>
<b>Subject:</b> Re: [PATCH 1/2] drm/amdgpu: use multipipe compute policy on=
 non PL11 asics</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:10pt;=
">
<div class=3D"PlainText">Sorry my mail client seems to have blown up. My re=
ply got cut off,<br>
here is the full version:<br>
<br>
<br>
<br>
On 2017-11-06 01:49 AM, Chunming Zhou wrote:<br>
&gt; Hi Andres,<br>
&gt;<br>
Hi David,<br>
<br>
&gt; With your this patch, OCLperf hung.<br>
Is this on all ASICs or just a specific one?<br>
<br>
&gt;<br>
&gt; Could you explain more?<br>
&gt;<br>
&gt; If I am correctly, the difference of with and without this patch is<br=
>
&gt; setting first two queue or setting all queues of pipe0 to queue_bitmap=
.<br>
It is slightly different. With this patch we will also use the first<br>
two queues of all pipes, not just pipe 0;<br>
<br>
Pre-patch:<br>
<br>
|-Pipe 0-||-Pipe 1-||-Pipe 2-||-Pipe 3-|<br>
&nbsp;11111111&nbsp; 00000000&nbsp; 00000000&nbsp; 00000000<br>
<br>
Post-patch:<br>
<br>
|-Pipe 0-||-Pipe 1-||-Pipe 2-||-Pipe 3-|<br>
&nbsp;11000000&nbsp; 11000000&nbsp; 11000000&nbsp; 11000000<br>
<br>
What this means is that we are allowing real multithreading for<br>
compute. Jobs on different pipes allow for parallel execution of work.<br>
Jobs on the same pipe (but different queues) use timeslicing to share<br>
the hardware.<br>
<br>
<br>
&gt;<br>
&gt; Then UMD can use different number queue to submit command for compute<=
br>
&gt; selected by amdgpu_queue_mgr_map.<br>
&gt;<br>
&gt; I checked amdgpu_queue_mgr_map implementation,&nbsp; CS_IOCTL can map =
user<br>
&gt; ring to different hw ring depending on busy or idle, right?<br>
Yes, when a queue is first used, amdgpu_queue_mgr_map will decide what<br>
the mapping is for a usermode ring to a kernel ring id.<br>
<br>
&gt; If yes, I see a bug in it, which will result in our sched_fence not<br=
>
&gt; work. Our sched fence assumes the job will be executed in order, your<=
br>
&gt; mapping queue breaks this.<br>
<br>
I think here you mean that work will execute out of order because it<br>
will go to different rings?<br>
<br>
That should not happen, since the id mapping is permanent on a<br>
per-context basis. Once a mapping is decided, it will be cached for<br>
this context so that we keep execution order guarantees. See the<br>
id-caching code in amdgpu_queue_mgr.c for reference.<br>
<br>
As long as the usermode keeps submitting work to the same ring, it<br>
will all be executed in order (all in the same ring). There is no<br>
change in this guarantee compared to pre-patch. Note that even before<br>
this patch amdgpu_queue_mgr_map has been using an LRU policy for a<br>
long time now.<br>
<br>
Regards,<br>
Andres<br>
<br>
On Mon, Nov 6, 2017 at 12:44 PM, Andres Rodriguez &lt;andresx7-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org&gt=
; wrote:<br>
&gt;<br>
&gt;<br>
&gt; On 2017-11-06 01:49 AM, Chunming Zhou wrote:<br>
&gt;&gt;<br>
&gt;&gt; Hi Andres,<br>
&gt;&gt;<br>
&gt;<br>
&gt; Hi David,<br>
&gt;<br>
&gt;&gt; With your this patch, OCLperf hung.<br>
&gt;<br>
&gt;<br>
&gt; Is this on all ASICs or just a specific one?<br>
&gt;<br>
&gt;&gt;<br>
&gt;&gt; Could you explain more?<br>
&gt;&gt;<br>
&gt;&gt; If I am correctly, the difference of with and without this patch i=
s<br>
&gt;&gt; setting first two queue or setting all queues of pipe0 to queue_bi=
tmap.<br>
&gt;<br>
&gt;<br>
&gt; It is slightly different. With this patch we will also use the first t=
wo<br>
&gt; queues of all pipes, not just pipe 0;<br>
&gt;<br>
&gt; Pre-patch:<br>
&gt;<br>
&gt; |-Pipe 0-||-Pipe 1-||-Pipe 2-||-Pipe 3-|<br>
&gt;&nbsp; 11111111&nbsp; 00000000&nbsp; 00000000&nbsp; 00000000<br>
&gt;<br>
&gt; Post-patch:<br>
&gt;<br>
&gt; |-Pipe 0-||-Pipe 1-||-Pipe 2-||-Pipe 3-|<br>
&gt;&nbsp; 11000000&nbsp; 11000000&nbsp; 11000000&nbsp; 11000000<br>
&gt;<br>
&gt; What this means is that we are allowing real multithreading for comput=
e.<br>
&gt; Jobs on different pipes allow for parallel execution of work. Jobs on =
the<br>
&gt; same pipe (but different queues) use timeslicing to share the hardware=
.<br>
&gt;<br>
&gt;<br>
&gt;<br>
&gt;&gt;<br>
&gt;&gt; Then UMD can use different number queue to submit command for comp=
ute<br>
&gt;&gt; selected by amdgpu_queue_mgr_map.<br>
&gt;&gt;<br>
&gt;&gt; I checked amdgpu_queue_mgr_map implementation,&nbsp; CS_IOCTL can =
map user ring<br>
&gt;&gt; to different hw ring depending on busy or idle, right?<br>
&gt;&gt;<br>
&gt;&gt; If yes, I see a bug in it, which will result in our sched_fence no=
t work.<br>
&gt;&gt; Our sched fence assumes the job will be executed in order, your ma=
pping<br>
&gt;&gt; queue breaks this.<br>
&gt;&gt;<br>
&gt;&gt;<br>
&gt;&gt; Regards,<br>
&gt;&gt;<br>
&gt;&gt; David Zhou<br>
&gt;&gt;<br>
&gt;&gt;<br>
&gt;&gt; On 2017=1B$BG/=1B(B09=1B$B7n=1B(B27=1B$BF|=1B(B 00:22, Andres Rodr=
iguez wrote:<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; A performance regression for OpenCL tests on Polaris11 had thi=
s feature<br>
&gt;&gt;&gt; disabled for all asics.<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; Instead, disable it selectively on the affected asics.<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; Signed-off-by: Andres Rodriguez &lt;andresx7-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org&gt;<br>
&gt;&gt;&gt; ---<br>
&gt;&gt;&gt;&nbsp;&nbsp; drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c | 14 &#43;=
&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;--<br>
&gt;&gt;&gt;&nbsp;&nbsp; 1 file changed, 12 insertions(&#43;), 2 deletions(=
-)<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c<br>
&gt;&gt;&gt; b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c<br>
&gt;&gt;&gt; index 4f6c68f..3d76e76 100644<br>
&gt;&gt;&gt; --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c<br>
&gt;&gt;&gt; &#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c<br>
&gt;&gt;&gt; @@ -109,9 &#43;109,20 @@ void amdgpu_gfx_parse_disable_cu(unsi=
gned *mask,<br>
&gt;&gt;&gt; unsigned max_se, unsigned max_s<br>
&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt;&gt;&gt;&nbsp;&nbsp; }<br>
&gt;&gt;&gt; &#43;static bool amdgpu_gfx_is_multipipe_capable(struct amdgpu=
_device *adev)<br>
&gt;&gt;&gt; &#43;{<br>
&gt;&gt;&gt; &#43;&nbsp;&nbsp;&nbsp; /* FIXME: spreading the queues across =
pipes causes perf regressions<br>
&gt;&gt;&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; * on POLARIS11 compute workloads=
 */<br>
&gt;&gt;&gt; &#43;&nbsp;&nbsp;&nbsp; if (adev-&gt;asic_type =3D=3D CHIP_POL=
ARIS11)<br>
&gt;&gt;&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return false;<=
br>
&gt;&gt;&gt; &#43;<br>
&gt;&gt;&gt; &#43;&nbsp;&nbsp;&nbsp; return adev-&gt;gfx.mec.num_mec &gt; 1=
;<br>
&gt;&gt;&gt; &#43;}<br>
&gt;&gt;&gt; &#43;<br>
&gt;&gt;&gt;&nbsp;&nbsp; void amdgpu_gfx_compute_queue_acquire(struct amdgp=
u_device *adev)<br>
&gt;&gt;&gt;&nbsp;&nbsp; {<br>
&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int i, queue, pipe, mec;<b=
r>
&gt;&gt;&gt; &#43;&nbsp;&nbsp;&nbsp; bool multipipe_policy =3D amdgpu_gfx_i=
s_multipipe_capable(adev);<br>
&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* policy for amdgpu compu=
te queue ownership */<br>
&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; for (i =3D 0; i &lt; AMDGP=
U_MAX_COMPUTE_QUEUES; &#43;&#43;i) {<br>
&gt;&gt;&gt; @@ -125,8 &#43;136,7 @@ void amdgpu_gfx_compute_queue_acquire(=
struct<br>
&gt;&gt;&gt; amdgpu_device *adev)<br>
&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if=
 (mec &gt;=3D adev-&gt;gfx.mec.num_mec)<br>
&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; break;<br>
&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* FIXME: spreadin=
g the queues across pipes causes perf<br>
&gt;&gt;&gt; regressions */<br>
&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (0) {<br>
&gt;&gt;&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (multipipe_=
policy) {<br>
&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; /* policy: amdgpu owns the first two queues of the fi=
rst<br>
&gt;&gt;&gt; MEC */<br>
&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; if (mec =3D=3D 0 &amp;&amp; queue &lt; 2)<br>
&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; set_bit(i, adev-&gt;gfx.mec.q=
ueue_bitmap);<br>
&gt;&gt;<br>
&gt;&gt;<br>
&gt;<br>
</div>
</span></font></div>
</body>
</html>

--_000_MWHPR1201MB0206CEC26FF751CB39B529D6B4510MWHPR1201MB0206_--

--===============0928272734==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============0928272734==--
