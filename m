From: Andres Rodriguez <andresx7-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 09/17] drm/amdgpu: take ownership of per-pipe
 configuration v2
Date: Sun, 16 Apr 2017 10:51:08 -0400
Message-ID: <CAFQ_0eFrYi6fkUCiNpRexZcipftbgvf+g14wX4WYv-3=FtfV=w@mail.gmail.com>
References: <20170413213542.18802-1-andresx7@gmail.com>
 <20170413213542.18802-10-andresx7@gmail.com>
 <CAFCwf12haVgYLxxcqMqTd-GX7KjxtZXD1Stuqj87HAP32TdvXQ@mail.gmail.com>
 <CAFQ_0eED3HxUN8Sz0buefckSmVWvMwBD0mFk_GA1XeLABdsTnw@mail.gmail.com>
 <CAFCwf12mXeEHd9pb9L84wibaKC0zrvO6dHggQ-ePP7odN=oj6A@mail.gmail.com>
 <CAFQ_0eE1O+SS_ucS-8Rjqm3S4aDjZq1r0OfzZhTKE=9Z12xMZQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0310658629=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <CAFQ_0eE1O+SS_ucS-8Rjqm3S4aDjZq1r0OfzZhTKE=9Z12xMZQ-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
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
To: Oded Gabbay <oded.gabbay-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: amd-gfx list <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

--===============0310658629==
Content-Type: multipart/alternative; boundary=001a1141e8d01ee20d054d49ce3c

--001a1141e8d01ee20d054d49ce3c
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Thanks for the info.

I'll test it as well on Monday.

Regards,
Andres

On Apr 16, 2017 1:26 AM, "Oded Gabbay" <oded.gabbay-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:

Hey Andres,

Yes, that patch indeed fixed the black screen on Alex's 4.12-wip, but
it still wouldn't boot with your entire patch-set. It would boot only
with patches 1-8.

I'll try to get a USB-to-serial dongle so I could try dump kernel
messages during boot but it will probably take some time.

Oded

On Sun, Apr 16, 2017 at 3:12 AM, Andres Rodriguez <andresx7-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
wrote:
> Hey Oded,
>
> I've had problems with 4.12-wip on its own. Just wanted to confirm if
> you picked up this fix for a bug in drm-next:
> "drm: Fix get_property logic fumble"
>
> Regards,
> Andres
>
> On Sat, Apr 15, 2017 at 8:37 AM, Oded Gabbay <oded.gabbay-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
wrote:
>> On Fri, Apr 14, 2017 at 12:35 AM, Andres Rodriguez <andresx7-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
wrote:
>>> Make amdgpu the owner of all per-pipe state of the HQDs.
>>>
>>> This change will allow us to split the queues between kfd and amdgpu
>>> with a queue granularity instead of pipe granularity.
>>>
>>> This patch fixes kfd allocating an HDP_EOP region for its 3 pipes which
>>> goes unused.
>>>
>>> v2: support for gfx9
>>>
>>> Reviewed-by: Edward O'Callaghan <funfunctor-dczkZgxz+BNUPWh3PAxdjQ@public.gmane.org>
>>> Reviewed-by: Felix Kuehling <Felix.Kuehling-5C7GfCeVMHo@public.gmane.org>
>>> Acked-by: Christian K=C3=B6nig <christian.koenig-5C7GfCeVMHo@public.gmane.org>
>>> Signed-off-by: Andres Rodriguez <andresx7-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
>>
>> Hi Andres,
>> FYI, with your patchset rebased on alex's drm-next-4.12-wip, my Kaveri
>> machine won't boot the OS (Ubuntu 16.04).
>> I bisected your patch-set and the first bad patch is this one.
>>
>> Unfortunately, I don't have the means to dump kernel crashes before
>> the system boots.
>>
>> Thx,
>> Oded

--001a1141e8d01ee20d054d49ce3c
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto">Thanks for the info.<div dir=3D"auto"><br></div><div dir=
=3D"auto">I&#39;ll test it as well on Monday.</div><div dir=3D"auto"><div d=
ir=3D"auto"><br></div><div dir=3D"auto">Regards,</div><div dir=3D"auto">And=
res</div></div></div><div class=3D"gmail_extra"><br><div class=3D"gmail_quo=
te">On Apr 16, 2017 1:26 AM, &quot;Oded Gabbay&quot; &lt;<a href=3D"mailto:=
oded.gabbay-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org">oded.gabbay-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org</a>&gt; wrote:<br type=3D"attr=
ibution"><blockquote class=3D"quote" style=3D"margin:0 0 0 .8ex;border-left=
:1px #ccc solid;padding-left:1ex">Hey Andres,<br>
<br>
Yes, that patch indeed fixed the black screen on Alex&#39;s 4.12-wip, but<b=
r>
it still wouldn&#39;t boot with your entire patch-set. It would boot only<b=
r>
with patches 1-8.<br>
<br>
I&#39;ll try to get a USB-to-serial dongle so I could try dump kernel<br>
messages during boot but it will probably take some time.<br>
<font color=3D"#888888"><br>
Oded<br>
</font><div class=3D"elided-text"><br>
On Sun, Apr 16, 2017 at 3:12 AM, Andres Rodriguez &lt;<a href=3D"mailto:and=
resx7-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org">andresx7-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org</a>&gt; wrote:<br>
&gt; Hey Oded,<br>
&gt;<br>
&gt; I&#39;ve had problems with 4.12-wip on its own. Just wanted to confirm=
 if<br>
&gt; you picked up this fix for a bug in drm-next:<br>
&gt; &quot;drm: Fix get_property logic fumble&quot;<br>
&gt;<br>
&gt; Regards,<br>
&gt; Andres<br>
&gt;<br>
&gt; On Sat, Apr 15, 2017 at 8:37 AM, Oded Gabbay &lt;<a href=3D"mailto:ode=
d.gabbay-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org">oded.gabbay-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org</a>&gt; wrote:<br>
&gt;&gt; On Fri, Apr 14, 2017 at 12:35 AM, Andres Rodriguez &lt;<a href=3D"=
mailto:andresx7-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org">andresx7-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org</a>&gt; wrote:<br>
&gt;&gt;&gt; Make amdgpu the owner of all per-pipe state of the HQDs.<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; This change will allow us to split the queues between kfd and =
amdgpu<br>
&gt;&gt;&gt; with a queue granularity instead of pipe granularity.<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; This patch fixes kfd allocating an HDP_EOP region for its 3 pi=
pes which<br>
&gt;&gt;&gt; goes unused.<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; v2: support for gfx9<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; Reviewed-by: Edward O&#39;Callaghan &lt;<a href=3D"mailto:funf=
unctor-dczkZgxz+BNUPWh3PAxdjQ@public.gmane.org">funfunctor-dczkZgxz+BNUPWh3PAxdjQ@public.gmane.org</a>&gt;<br>
&gt;&gt;&gt; Reviewed-by: Felix Kuehling &lt;<a href=3D"mailto:Felix.Kuehli=
ng-5C7GfCeVMHo@public.gmane.org">Felix.Kuehling-5C7GfCeVMHo@public.gmane.org</a>&gt;<br>
&gt;&gt;&gt; Acked-by: Christian K=C3=B6nig &lt;<a href=3D"mailto:christian=
.koenig-5C7GfCeVMHo@public.gmane.org">christian.koenig-5C7GfCeVMHo@public.gmane.org</a>&gt;<br>
&gt;&gt;&gt; Signed-off-by: Andres Rodriguez &lt;<a href=3D"mailto:andresx7=
@gmail.com">andresx7-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org</a>&gt;<br>
&gt;&gt;<br>
&gt;&gt; Hi Andres,<br>
&gt;&gt; FYI, with your patchset rebased on alex&#39;s drm-next-4.12-wip, m=
y Kaveri<br>
&gt;&gt; machine won&#39;t boot the OS (Ubuntu 16.04).<br>
&gt;&gt; I bisected your patch-set and the first bad patch is this one.<br>
&gt;&gt;<br>
&gt;&gt; Unfortunately, I don&#39;t have the means to dump kernel crashes b=
efore<br>
&gt;&gt; the system boots.<br>
&gt;&gt;<br>
&gt;&gt; Thx,<br>
&gt;&gt; Oded<br>
</div></blockquote></div><br></div>

--001a1141e8d01ee20d054d49ce3c--

--===============0310658629==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============0310658629==--
