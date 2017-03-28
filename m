From: =?UTF-8?B?TWFyZWsgT2zFocOhaw==?= <maraeo-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: Plan: BO move throttling for visible VRAM evictions
Date: Tue, 28 Mar 2017 12:51:36 +0200
Message-ID: <CAAxE2A5kSU5pW6-5fg9oh8dVUvqgRQu7e1s3j2ibwPXi4zZTVw@mail.gmail.com>
References: <CAAxE2A4ap8BoOEg1tOF+Ec1vBfZRSANOebikYBaHUfXokY7EwA@mail.gmail.com>
 <ba8058ce-805b-3e52-095a-01806673344f@daenzer.net>
 <CAAxE2A5OCfgu4k-GzNFhGSkgn21jEJoQysdZ6QbdxZaGwPnrEA@mail.gmail.com>
 <03c34461-6918-0875-10c3-488bacbae0e4@daenzer.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0114651531=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <03c34461-6918-0875-10c3-488bacbae0e4-otUistvHUpPR7s880joybQ@public.gmane.org>
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
To: =?UTF-8?Q?Michel_D=C3=A4nzer?= <michel-otUistvHUpPR7s880joybQ@public.gmane.org>
Cc: amd-gfx mailing list <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

--===============0114651531==
Content-Type: multipart/alternative; boundary=001a114074327e7cb6054bc83e58

--001a114074327e7cb6054bc83e58
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Mar 28, 2017 3:07 AM, "Michel D=C3=A4nzer" <michel-otUistvHUpPR7s880joybQ@public.gmane.org> wrote:

On 27/03/17 07:29 PM, Marek Ol=C5=A1=C3=A1k wrote:
> On Mar 27, 2017 9:35 AM, "Michel D=C3=A4nzer" <michel-otUistvHUpPR7s880joybQ@public.gmane.org
> <mailto:michel-otUistvHUpPR7s880joybQ@public.gmane.org>> wrote:
>
>     On 25/03/17 01:33 AM, Marek Ol=C5=A1=C3=A1k wrote:
>     > Hi,
>     >
>     > I'm sharing this idea here, because it's something that has been
>     > decreasing our performance a lot recently, for example:
>     >
>     http://openbenchmarking.org/prospect/1703011-RI-RADEONDIR06/
7b7668cfc109d1c3dc27e871c8aea71ca13f23fa
>     <http://openbenchmarking.org/prospect/1703011-RI-RADEONDIR06/
7b7668cfc109d1c3dc27e871c8aea71ca13f23fa>
>     >
>     > I think the problem there is that Mesa git started uploading
>     > descriptors and uniforms to VRAM, which helps when TC L2 has a low
>     > hit/miss ratio, but the performance can randomly drop by an order o=
f
>     > magnitude. I've heard rumours that kernel 4.11 has an improved
>     > allocator that should perform better, but the situation is still fa=
r
>     > from ideal.
>     >
>     > AMD CPUs and APUs will hopefully suffer less, because we can resize
>     > the visible VRAM with the help of our CPU hw specs, but Intel CPUs
>     > will remain limited to 256 MB. The following plan describes how to
do
>     > throttling for visible VRAM evictions.
>     >
>     >
>     > 1) Theory
>     >
>     > Initially, the driver doesn't care about where buffers are in VRAM,
>     > because VRAM buffers are only moved to visible VRAM on CPU page
faults
>     > (when the CPU touches the buffer memory but the memory is in the
>     > invisible part of VRAM). When it happens,
>     > amdgpu_bo_fault_reserve_notify is called, which moves the buffer to
>     > visible VRAM, and the app continues. amdgpu_bo_fault_reserve_notify
>     > also marks the buffer as contiguous, which makes memory
fragmentation
>     > worse.
>     >
>     > I verified this with DiRT Rally where amdgpu_bo_fault_reserve_notif=
y
>     > was much higher in a CPU profiler than anything else in the kernel.
>     >
>     >
>     > 2) Monitoring via Gallium HUD
>     >
>     > We need to expose 2 kernel counters via the INFO ioctl and display
>     > those via Gallium HUD:
>     > - The number of VRAM CPU page faults. (the number of calls to
>     > amdgpu_bo_fault_reserve_notify).
>     > - The number of bytes moved by ttm_bo_validate inside
>     > amdgpu_bo_fault_reserve_notify.
>     >
>     > This will help us observe what exactly is happening and fine-tune
the
>     > throttling when it's done.
>     >
>     >
>     > 3) Solution
>     >
>     > a) When amdgpu_bo_fault_reserve_notify is called, record the fact.
>     > (amdgpu_bo::had_cpu_page_fault =3D true)
>     >
>     > b) Monitor the MB/s rate at which buffers are moved by
>     > amdgpu_bo_fault_reserve_notify. If we get above a specific
threshold,
>     > don't move the buffer to visible VRAM. Move it to GTT instead. Note
>     > that moving to GTT can be cheaper, because moving to visible VRAM i=
s
>     > likely to evict a lot of buffers there and unmap them from the CPU,
>
>     FWIW, this can be avoided by only setting GTT in busy_placement. Then
>     TTM will only move the BO to visible VRAM if that can be done without
>     evicting anything from there.
>
>
>     > but moving to GTT shouldn't evict or unmap anything.
>     >
>     > c) When we get into the CS ioctl and a buffer has
had_cpu_page_fault,
>     > it can be moved to VRAM if:
>     > - the GTT->VRAM move rate is low enough to allow it (this is the
>     > existing throttling mechanism)
>     > - the visible VRAM move rate is low enough that we will be OK with
>     > another CPU page fault if it happens.
>
>     Some other ideas that might be worth trying:
>
>     Evicting BOs to GTT instead of moving them to CPU accessible VRAM in
>     principle in some cases (e.g. for all BOs except those with
>     AMDGPU_GEM_CREATE_CPU_ACCESS_REQUIRED) or even always.
>
>
> I've tried this and it made things even worse.

What exactly did you try?


I only set the placement to GTT, but I think I kept the contiguous flag.

Marek



--
Earthling Michel D=C3=A4nzer               |               http://www.amd.c=
om
Libre software enthusiast             |             Mesa and X developer

--001a114074327e7cb6054bc83e58
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div><br><div class=3D"gmail_extra"><br><div class=3D"gma=
il_quote">On Mar 28, 2017 3:07 AM, &quot;Michel D=C3=A4nzer&quot; &lt;<a hr=
ef=3D"mailto:michel-otUistvHUpPR7s880joybQ@public.gmane.org">michel-otUistvHUpPR7s880joybQ@public.gmane.org</a>&gt; wrote:<br type=
=3D"attribution"><blockquote class=3D"quote" style=3D"margin:0 0 0 .8ex;bor=
der-left:1px #ccc solid;padding-left:1ex"><div class=3D"quoted-text">On 27/=
03/17 07:29 PM, Marek Ol=C5=A1=C3=A1k wrote:<br>
&gt; On Mar 27, 2017 9:35 AM, &quot;Michel D=C3=A4nzer&quot; &lt;<a href=3D=
"mailto:michel-otUistvHUpPR7s880joybQ@public.gmane.org">michel-otUistvHUpPR7s880joybQ@public.gmane.org</a><br>
</div><div class=3D"elided-text">&gt; &lt;mailto:<a href=3D"mailto:michel@d=
aenzer.net">michel-otUistvHUpPR7s880joybQ@public.gmane.org</a>&gt;&gt; wrote:<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0On 25/03/17 01:33 AM, Marek Ol=C5=A1=C3=A1k wrote:<=
br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; Hi,<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; I&#39;m sharing this idea here, because it&#39=
;s something that has been<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; decreasing our performance a lot recently, for=
 example:<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0<a href=3D"http://openbenchmarking.org/prospect/170=
3011-RI-RADEONDIR06/7b7668cfc109d1c3dc27e871c8aea71ca13f23fa" rel=3D"norefe=
rrer" target=3D"_blank">http://openbenchmarking.org/<wbr>prospect/1703011-R=
I-<wbr>RADEONDIR06/<wbr>7b7668cfc109d1c3dc27e871c8aea7<wbr>1ca13f23fa</a><b=
r>
&gt;=C2=A0 =C2=A0 =C2=A0&lt;<a href=3D"http://openbenchmarking.org/prospect=
/1703011-RI-RADEONDIR06/7b7668cfc109d1c3dc27e871c8aea71ca13f23fa" rel=3D"no=
referrer" target=3D"_blank">http://openbenchmarking.org/<wbr>prospect/17030=
11-RI-<wbr>RADEONDIR06/<wbr>7b7668cfc109d1c3dc27e871c8aea7<wbr>1ca13f23fa</=
a>&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; I think the problem there is that Mesa git sta=
rted uploading<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; descriptors and uniforms to VRAM, which helps =
when TC L2 has a low<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; hit/miss ratio, but the performance can random=
ly drop by an order of<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; magnitude. I&#39;ve heard rumours that kernel =
4.11 has an improved<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; allocator that should perform better, but the =
situation is still far<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; from ideal.<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; AMD CPUs and APUs will hopefully suffer less, =
because we can resize<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; the visible VRAM with the help of our CPU hw s=
pecs, but Intel CPUs<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; will remain limited to 256 MB. The following p=
lan describes how to do<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; throttling for visible VRAM evictions.<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; 1) Theory<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; Initially, the driver doesn&#39;t care about w=
here buffers are in VRAM,<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; because VRAM buffers are only moved to visible=
 VRAM on CPU page faults<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; (when the CPU touches the buffer memory but th=
e memory is in the<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; invisible part of VRAM). When it happens,<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; amdgpu_bo_fault_reserve_notify is called, whic=
h moves the buffer to<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; visible VRAM, and the app continues. amdgpu_bo=
_fault_reserve_notify<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; also marks the buffer as contiguous, which mak=
es memory fragmentation<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; worse.<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; I verified this with DiRT Rally where amdgpu_b=
o_fault_reserve_notify<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; was much higher in a CPU profiler than anythin=
g else in the kernel.<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; 2) Monitoring via Gallium HUD<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; We need to expose 2 kernel counters via the IN=
FO ioctl and display<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; those via Gallium HUD:<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; - The number of VRAM CPU page faults. (the num=
ber of calls to<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; amdgpu_bo_fault_reserve_<wbr>notify).<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; - The number of bytes moved by ttm_bo_validate=
 inside<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; amdgpu_bo_fault_reserve_<wbr>notify.<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; This will help us observe what exactly is happ=
ening and fine-tune the<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; throttling when it&#39;s done.<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; 3) Solution<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; a) When amdgpu_bo_fault_reserve_notify is call=
ed, record the fact.<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; (amdgpu_bo::had_cpu_page_fault =3D true)<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; b) Monitor the MB/s rate at which buffers are =
moved by<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; amdgpu_bo_fault_reserve_<wbr>notify. If we get=
 above a specific threshold,<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; don&#39;t move the buffer to visible VRAM. Mov=
e it to GTT instead. Note<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; that moving to GTT can be cheaper, because mov=
ing to visible VRAM is<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; likely to evict a lot of buffers there and unm=
ap them from the CPU,<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0FWIW, this can be avoided by only setting GTT in bu=
sy_placement. Then<br>
&gt;=C2=A0 =C2=A0 =C2=A0TTM will only move the BO to visible VRAM if that c=
an be done without<br>
&gt;=C2=A0 =C2=A0 =C2=A0evicting anything from there.<br>
&gt;<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; but moving to GTT shouldn&#39;t evict or unmap=
 anything.<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; c) When we get into the CS ioctl and a buffer =
has had_cpu_page_fault,<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; it can be moved to VRAM if:<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; - the GTT-&gt;VRAM move rate is low enough to =
allow it (this is the<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; existing throttling mechanism)<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; - the visible VRAM move rate is low enough tha=
t we will be OK with<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; another CPU page fault if it happens.<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0Some other ideas that might be worth trying:<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0Evicting BOs to GTT instead of moving them to CPU a=
ccessible VRAM in<br>
&gt;=C2=A0 =C2=A0 =C2=A0principle in some cases (e.g. for all BOs except th=
ose with<br>
&gt;=C2=A0 =C2=A0 =C2=A0AMDGPU_GEM_CREATE_CPU_ACCESS_<wbr>REQUIRED) or even=
 always.<br>
&gt;<br>
&gt;<br>
&gt; I&#39;ve tried this and it made things even worse.<br>
<br>
</div>What exactly did you try?<br></blockquote></div></div></div><div dir=
=3D"auto"><br></div><div dir=3D"auto">I only set the placement to GTT, but =
I think I kept the contiguous flag.</div><div dir=3D"auto"><br></div><div d=
ir=3D"auto">Marek</div><div dir=3D"auto"><br></div><div dir=3D"auto"><div c=
lass=3D"gmail_extra"><div class=3D"gmail_quote"><blockquote class=3D"quote"=
 style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">
<div class=3D"elided-text"><br>
<br>
--<br>
Earthling Michel D=C3=A4nzer=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0|=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0<a href=
=3D"http://www.amd.com" rel=3D"noreferrer" target=3D"_blank">http://www.amd=
.com</a><br>
Libre software enthusiast=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0Mesa and X developer<br>
</div></blockquote></div><br></div></div></div>

--001a114074327e7cb6054bc83e58--

--===============0114651531==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============0114651531==--
