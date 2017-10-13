From: "Liu, Monk" <Monk.Liu-5C7GfCeVMHo@public.gmane.org>
Subject: regression with d6c650c0a8f6f671e49553725e1db541376d95f2
Date: Fri, 13 Oct 2017 07:24:35 +0000
Message-ID: <BLUPR12MB044941343D6D1A35996C7B4284480@BLUPR12MB0449.namprd12.prod.outlook.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1214100558=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
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
To: =?iso-8859-1?Q?Nicolai_H=E4hnle?= <nhaehnle-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
Cc: "Koenig, Christian" <Christian.Koenig-5C7GfCeVMHo@public.gmane.org>

--===============1214100558==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_BLUPR12MB044941343D6D1A35996C7B4284480BLUPR12MB0449namp_"

--_000_BLUPR12MB044941343D6D1A35996C7B4284480BLUPR12MB0449namp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

commit d6c650c0a8f6f671e49553725e1db541376d95f2
Author: Nicolai H=E4hnle <nicolai.haehnle-5C7GfCeVMHo@public.gmane.org>
@@ -611,6 +611,10 @@ static int amd_sched_main(void *param)

                fence =3D sched->ops->run_job(sched_job);
                amd_sched_fence_scheduled(s_fence);
+
+               /* amd_sched_process_job drops the job's reference of the f=
ence. */
+               sched_job->s_fence =3D NULL;
+
                if (fence) {
                        s_fence->parent =3D dma_fence_get(fence);
                        r =3D dma_fence_add_callback(fence, &s_fence->cb,


Hi Nicolai


with this patch, you will break "amdgpu_sched_hw_job_reset()"routine:

void amd_sched_hw_job_reset(struct amd_gpu_scheduler *sched)
{
    struct amd_sched_job *s_job;

    spin_lock(&sched->job_list_lock);
    list_for_each_entry_reverse(s_job, &sched->ring_mirror_list, node) {
        if (s_job->s_fence->parent &&
         fence_remove_callback(s_job->s_fence->parent,
                     &s_job->s_fence->cb)) {
            fence_put(s_job->s_fence->parent);
            s_job->s_fence->parent =3D NULL;
            atomic_dec(&sched->hw_rq_count);
        }
    }
    spin_unlock(&sched->job_list_lock);
}


see that without sched_job->s_fence, you cannot remove the callback from it=
s hw fence,


any idea??


BR Monk



--_000_BLUPR12MB044941343D6D1A35996C7B4284480BLUPR12MB0449namp_
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
<p></p>
<div>commit d6c650c0a8f6f671e49553725e1db541376d95f2<br>
Author: Nicolai H=E4hnle &lt;nicolai.haehnle-5C7GfCeVMHo@public.gmane.org&gt;<br>
@@ -611,6 &#43;611,10 @@ static int amd_sched_main(void *param)<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; fence =3D sched-&gt;ops-&gt;run_job(sched_job);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; amd_sched_fence_scheduled(s_fence);<br>
&#43;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; /* amd_sched_process_job drops the job's reference of the fe=
nce. */<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; sched_job-&gt;s_fence =3D NULL;<br>
&#43;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; if (fence) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; s_fence-&gt=
;parent =3D dma_fence_get(fence);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; r =3D dma_f=
ence_add_callback(fence, &amp;s_fence-&gt;cb,<br>
<br>
</div>
<p></p>
<p>Hi Nicolai</p>
<p><br>
</p>
<p>with this patch, you will break &quot;amdgpu_sched_hw_job_reset()&quot;r=
outine:</p>
<p></p>
<div style=3D"color: #d4d4d4;background-color: #1e1e1e;font-family: 'Droid =
Sans Mono', 'Courier New', monospace, 'Droid Sans Fallback';font-weight: no=
rmal;font-size: 14px;line-height: 19px;white-space: pre;">
<div><span style=3D"color: #569cd6;">void</span><span style=3D"color: #d4d4=
d4;"> </span>
<span style=3D"color: #dcdcaa;">amd_sched_hw_job_reset</span><span style=3D=
"color: #d4d4d4;">(</span><span style=3D"color: #569cd6;">struct</span><spa=
n style=3D"color: #d4d4d4;"> amd_gpu_scheduler
</span><span style=3D"color: #d4d4d4;">*</span><span style=3D"color: #d4d4d=
4;">sched)</span></div>
<div><span style=3D"color: #d4d4d4;">{</span></div>
<div><span style=3D"color: #d4d4d4;">&nbsp;&nbsp;&nbsp;&nbsp;</span><span s=
tyle=3D"color: #569cd6;">struct</span><span style=3D"color: #d4d4d4;"> amd_=
sched_job
</span><span style=3D"color: #d4d4d4;">*</span><span style=3D"color: #d4d4d=
4;">s_job;</span></div>
<br>
<div><span style=3D"color: #d4d4d4;">&nbsp;&nbsp;&nbsp;&nbsp;</span><span s=
tyle=3D"color: #dcdcaa;">spin_lock</span><span style=3D"color: #d4d4d4;">(<=
/span><span style=3D"color: #d4d4d4;">&amp;</span><span style=3D"color: #d4=
d4d4;">sched-&gt;</span><span style=3D"color: #9cdcfe;">job_list_lock</span=
><span style=3D"color: #d4d4d4;">);</span></div>
<div><span style=3D"color: #d4d4d4;">&nbsp;&nbsp;&nbsp;&nbsp;</span><span s=
tyle=3D"color: #dcdcaa;">list_for_each_entry_reverse</span><span style=3D"c=
olor: #d4d4d4;">(s_job,
</span><span style=3D"color: #d4d4d4;">&amp;</span><span style=3D"color: #d=
4d4d4;">sched-&gt;</span><span style=3D"color: #9cdcfe;">ring_mirror_list</=
span><span style=3D"color: #d4d4d4;">, node) {</span></div>
<div><span style=3D"color: #d4d4d4;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;</span><span style=3D"color: #c586c0;">if</span><span style=3D"co=
lor: #d4d4d4;"> (s_job-&gt;</span><span style=3D"color: #9cdcfe;">s_fence</=
span><span style=3D"color: #d4d4d4;">-&gt;</span><span style=3D"color: #9cd=
cfe;">parent</span><span style=3D"color: #d4d4d4;">
</span><span style=3D"color: #d4d4d4;">&amp;&amp;</span></div>
<div><span style=3D"color: #d4d4d4;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; </span><span style=3D"color: #dcdcaa;">fence_remove_callback</sp=
an><span style=3D"color: #d4d4d4;">(s_job-&gt;</span><span style=3D"color: =
#9cdcfe;">s_fence</span><span style=3D"color: #d4d4d4;">-&gt;</span><span s=
tyle=3D"color: #9cdcfe;">parent</span><span style=3D"color: #d4d4d4;">,</sp=
an></div>
<div><span style=3D"color: #d4d4d4;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; </span><span style=3D"color: #d4d4d4;">&amp;</span><span style=3D"c=
olor: #d4d4d4;">s_job-&gt;</span><span style=3D"color: #9cdcfe;">s_fence</s=
pan><span style=3D"color: #d4d4d4;">-&gt;</span><span style=3D"color: #9cdc=
fe;">cb</span><span style=3D"color: #d4d4d4;">))
 {</span></div>
<div><span style=3D"color: #d4d4d4;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span><span style=3D"color: #dcdcaa;">fe=
nce_put</span><span style=3D"color: #d4d4d4;">(s_job-&gt;</span><span style=
=3D"color: #9cdcfe;">s_fence</span><span style=3D"color: #d4d4d4;">-&gt;</s=
pan><span style=3D"color: #9cdcfe;">parent</span><span style=3D"color: #d4d=
4d4;">);</span></div>
<div><span style=3D"color: #d4d4d4;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;s_job-&gt;</span><span style=3D"color: #9=
cdcfe;">s_fence</span><span style=3D"color: #d4d4d4;">-&gt;</span><span sty=
le=3D"color: #9cdcfe;">parent</span><span style=3D"color: #d4d4d4;">
</span><span style=3D"color: #d4d4d4;">=3D</span><span style=3D"color: #d4d=
4d4;"> </span>
<span style=3D"color: #569cd6;">NULL</span><span style=3D"color: #d4d4d4;">=
;</span></div>
<div><span style=3D"color: #d4d4d4;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span><span style=3D"color: #dcdcaa;">at=
omic_dec</span><span style=3D"color: #d4d4d4;">(</span><span style=3D"color=
: #d4d4d4;">&amp;</span><span style=3D"color: #d4d4d4;">sched-&gt;</span><s=
pan style=3D"color: #9cdcfe;">hw_rq_count</span><span style=3D"color: #d4d4=
d4;">);</span></div>
<div><span style=3D"color: #d4d4d4;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;}</span></div>
<div><span style=3D"color: #d4d4d4;">&nbsp;&nbsp;&nbsp;&nbsp;}</span></div>
<div><span style=3D"color: #d4d4d4;">&nbsp;&nbsp;&nbsp;&nbsp;</span><span s=
tyle=3D"color: #dcdcaa;">spin_unlock</span><span style=3D"color: #d4d4d4;">=
(</span><span style=3D"color: #d4d4d4;">&amp;</span><span style=3D"color: #=
d4d4d4;">sched-&gt;</span><span style=3D"color: #9cdcfe;">job_list_lock</sp=
an><span style=3D"color: #d4d4d4;">);</span></div>
<div><span style=3D"color: #d4d4d4;">}</span></div>
</div>
<p></p>
<p><br>
</p>
<p>see that without sched_job-&gt;s_fence, you cannot remove the callback f=
rom its hw fence,</p>
<p><br>
</p>
<p>any idea??</p>
<p><br>
</p>
<p>BR Monk<br>
</p>
<p><br>
</p>
<p><br>
</p>
</div>
</body>
</html>

--_000_BLUPR12MB044941343D6D1A35996C7B4284480BLUPR12MB0449namp_--

--===============1214100558==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============1214100558==--
