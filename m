From: =?UTF-8?B?TWFyZWsgT2zFocOhaw==?= <maraeo-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: Plan: BO move throttling for visible VRAM evictions
Date: Mon, 27 Mar 2017 12:29:17 +0200
Message-ID: <CAAxE2A5OCfgu4k-GzNFhGSkgn21jEJoQysdZ6QbdxZaGwPnrEA@mail.gmail.com>
References: <CAAxE2A4ap8BoOEg1tOF+Ec1vBfZRSANOebikYBaHUfXokY7EwA@mail.gmail.com>
 <ba8058ce-805b-3e52-095a-01806673344f@daenzer.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0082125125=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <ba8058ce-805b-3e52-095a-01806673344f-otUistvHUpPR7s880joybQ@public.gmane.org>
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

--===============0082125125==
Content-Type: multipart/alternative; boundary=94eb2c055d18d70199054bb3d0d1

--94eb2c055d18d70199054bb3d0d1
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Mar 27, 2017 9:35 AM, "Michel D=C3=A4nzer" <michel-otUistvHUpPR7s880joybQ@public.gmane.org> wrote:

On 25/03/17 01:33 AM, Marek Ol=C5=A1=C3=A1k wrote:
> Hi,
>
> I'm sharing this idea here, because it's something that has been
> decreasing our performance a lot recently, for example:
> http://openbenchmarking.org/prospect/1703011-RI-RADEONDIR06/
7b7668cfc109d1c3dc27e871c8aea71ca13f23fa
>
> I think the problem there is that Mesa git started uploading
> descriptors and uniforms to VRAM, which helps when TC L2 has a low
> hit/miss ratio, but the performance can randomly drop by an order of
> magnitude. I've heard rumours that kernel 4.11 has an improved
> allocator that should perform better, but the situation is still far
> from ideal.
>
> AMD CPUs and APUs will hopefully suffer less, because we can resize
> the visible VRAM with the help of our CPU hw specs, but Intel CPUs
> will remain limited to 256 MB. The following plan describes how to do
> throttling for visible VRAM evictions.
>
>
> 1) Theory
>
> Initially, the driver doesn't care about where buffers are in VRAM,
> because VRAM buffers are only moved to visible VRAM on CPU page faults
> (when the CPU touches the buffer memory but the memory is in the
> invisible part of VRAM). When it happens,
> amdgpu_bo_fault_reserve_notify is called, which moves the buffer to
> visible VRAM, and the app continues. amdgpu_bo_fault_reserve_notify
> also marks the buffer as contiguous, which makes memory fragmentation
> worse.
>
> I verified this with DiRT Rally where amdgpu_bo_fault_reserve_notify
> was much higher in a CPU profiler than anything else in the kernel.
>
>
> 2) Monitoring via Gallium HUD
>
> We need to expose 2 kernel counters via the INFO ioctl and display
> those via Gallium HUD:
> - The number of VRAM CPU page faults. (the number of calls to
> amdgpu_bo_fault_reserve_notify).
> - The number of bytes moved by ttm_bo_validate inside
> amdgpu_bo_fault_reserve_notify.
>
> This will help us observe what exactly is happening and fine-tune the
> throttling when it's done.
>
>
> 3) Solution
>
> a) When amdgpu_bo_fault_reserve_notify is called, record the fact.
> (amdgpu_bo::had_cpu_page_fault =3D true)
>
> b) Monitor the MB/s rate at which buffers are moved by
> amdgpu_bo_fault_reserve_notify. If we get above a specific threshold,
> don't move the buffer to visible VRAM. Move it to GTT instead. Note
> that moving to GTT can be cheaper, because moving to visible VRAM is
> likely to evict a lot of buffers there and unmap them from the CPU,

FWIW, this can be avoided by only setting GTT in busy_placement. Then
TTM will only move the BO to visible VRAM if that can be done without
evicting anything from there.


> but moving to GTT shouldn't evict or unmap anything.
>
> c) When we get into the CS ioctl and a buffer has had_cpu_page_fault,
> it can be moved to VRAM if:
> - the GTT->VRAM move rate is low enough to allow it (this is the
> existing throttling mechanism)
> - the visible VRAM move rate is low enough that we will be OK with
> another CPU page fault if it happens.

Some other ideas that might be worth trying:

Evicting BOs to GTT instead of moving them to CPU accessible VRAM in
principle in some cases (e.g. for all BOs except those with
AMDGPU_GEM_CREATE_CPU_ACCESS_REQUIRED) or even always.


I've tried this and it made things even worse.

Marek


Implementing eviction from CPU visible to CPU invisible VRAM, similar to
how it's done in radeon. Note that there's potential for userspace
triggering an infinite loop in the kernel in cases where BOs are moved
back from invisible to visible VRAM on page faults.


--
Earthling Michel D=C3=A4nzer               |               http://www.amd.c=
om
Libre software enthusiast             |             Mesa and X developer

--94eb2c055d18d70199054bb3d0d1
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div><br><div class=3D"gmail_extra"><br><div class=3D"gma=
il_quote">On Mar 27, 2017 9:35 AM, &quot;Michel D=C3=A4nzer&quot; &lt;<a hr=
ef=3D"mailto:michel-otUistvHUpPR7s880joybQ@public.gmane.org">michel-otUistvHUpPR7s880joybQ@public.gmane.org</a>&gt; wrote:<br type=
=3D"attribution"><blockquote class=3D"quote" style=3D"margin:0 0 0 .8ex;bor=
der-left:1px #ccc solid;padding-left:1ex"><div class=3D"elided-text">On 25/=
03/17 01:33 AM, Marek Ol=C5=A1=C3=A1k wrote:<br>
&gt; Hi,<br>
&gt;<br>
&gt; I&#39;m sharing this idea here, because it&#39;s something that has be=
en<br>
&gt; decreasing our performance a lot recently, for example:<br>
&gt; <a href=3D"http://openbenchmarking.org/prospect/1703011-RI-RADEONDIR06=
/7b7668cfc109d1c3dc27e871c8aea71ca13f23fa" rel=3D"noreferrer" target=3D"_bl=
ank">http://openbenchmarking.org/<wbr>prospect/1703011-RI-<wbr>RADEONDIR06/=
<wbr>7b7668cfc109d1c3dc27e871c8aea7<wbr>1ca13f23fa</a><br>
&gt;<br>
&gt; I think the problem there is that Mesa git started uploading<br>
&gt; descriptors and uniforms to VRAM, which helps when TC L2 has a low<br>
&gt; hit/miss ratio, but the performance can randomly drop by an order of<b=
r>
&gt; magnitude. I&#39;ve heard rumours that kernel 4.11 has an improved<br>
&gt; allocator that should perform better, but the situation is still far<b=
r>
&gt; from ideal.<br>
&gt;<br>
&gt; AMD CPUs and APUs will hopefully suffer less, because we can resize<br=
>
&gt; the visible VRAM with the help of our CPU hw specs, but Intel CPUs<br>
&gt; will remain limited to 256 MB. The following plan describes how to do<=
br>
&gt; throttling for visible VRAM evictions.<br>
&gt;<br>
&gt;<br>
&gt; 1) Theory<br>
&gt;<br>
&gt; Initially, the driver doesn&#39;t care about where buffers are in VRAM=
,<br>
&gt; because VRAM buffers are only moved to visible VRAM on CPU page faults=
<br>
&gt; (when the CPU touches the buffer memory but the memory is in the<br>
&gt; invisible part of VRAM). When it happens,<br>
&gt; amdgpu_bo_fault_reserve_notify is called, which moves the buffer to<br=
>
&gt; visible VRAM, and the app continues. amdgpu_bo_fault_reserve_notify<br=
>
&gt; also marks the buffer as contiguous, which makes memory fragmentation<=
br>
&gt; worse.<br>
&gt;<br>
&gt; I verified this with DiRT Rally where amdgpu_bo_fault_reserve_notify<b=
r>
&gt; was much higher in a CPU profiler than anything else in the kernel.<br=
>
&gt;<br>
&gt;<br>
&gt; 2) Monitoring via Gallium HUD<br>
&gt;<br>
&gt; We need to expose 2 kernel counters via the INFO ioctl and display<br>
&gt; those via Gallium HUD:<br>
&gt; - The number of VRAM CPU page faults. (the number of calls to<br>
&gt; amdgpu_bo_fault_reserve_<wbr>notify).<br>
&gt; - The number of bytes moved by ttm_bo_validate inside<br>
&gt; amdgpu_bo_fault_reserve_<wbr>notify.<br>
&gt;<br>
&gt; This will help us observe what exactly is happening and fine-tune the<=
br>
&gt; throttling when it&#39;s done.<br>
&gt;<br>
&gt;<br>
&gt; 3) Solution<br>
&gt;<br>
&gt; a) When amdgpu_bo_fault_reserve_notify is called, record the fact.<br>
&gt; (amdgpu_bo::had_cpu_page_fault =3D true)<br>
&gt;<br>
&gt; b) Monitor the MB/s rate at which buffers are moved by<br>
&gt; amdgpu_bo_fault_reserve_<wbr>notify. If we get above a specific thresh=
old,<br>
&gt; don&#39;t move the buffer to visible VRAM. Move it to GTT instead. Not=
e<br>
&gt; that moving to GTT can be cheaper, because moving to visible VRAM is<b=
r>
&gt; likely to evict a lot of buffers there and unmap them from the CPU,<br=
>
<br>
</div>FWIW, this can be avoided by only setting GTT in busy_placement. Then=
<br>
TTM will only move the BO to visible VRAM if that can be done without<br>
evicting anything from there.<br>
<div class=3D"quoted-text"><br>
<br>
&gt; but moving to GTT shouldn&#39;t evict or unmap anything.<br>
&gt;<br>
&gt; c) When we get into the CS ioctl and a buffer has had_cpu_page_fault,<=
br>
&gt; it can be moved to VRAM if:<br>
&gt; - the GTT-&gt;VRAM move rate is low enough to allow it (this is the<br=
>
&gt; existing throttling mechanism)<br>
&gt; - the visible VRAM move rate is low enough that we will be OK with<br>
&gt; another CPU page fault if it happens.<br>
<br>
</div>Some other ideas that might be worth trying:<br>
<br>
Evicting BOs to GTT instead of moving them to CPU accessible VRAM in<br>
principle in some cases (e.g. for all BOs except those with<br>
AMDGPU_GEM_CREATE_CPU_ACCESS_<wbr>REQUIRED) or even always.<br></blockquote=
></div></div></div><div dir=3D"auto"><br></div><div dir=3D"auto">I&#39;ve t=
ried this and it made things even worse.</div><div dir=3D"auto"><br></div><=
div dir=3D"auto">Marek</div><div dir=3D"auto"><br></div><div dir=3D"auto"><=
div class=3D"gmail_extra"><div class=3D"gmail_quote"><blockquote class=3D"q=
uote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1e=
x">
<br>
Implementing eviction from CPU visible to CPU invisible VRAM, similar to<br=
>
how it&#39;s done in radeon. Note that there&#39;s potential for userspace<=
br>
triggering an infinite loop in the kernel in cases where BOs are moved<br>
back from invisible to visible VRAM on page faults.<br>
<font color=3D"#888888"><br>
<br>
--<br>
Earthling Michel D=C3=A4nzer=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0|=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0<a href=
=3D"http://www.amd.com" rel=3D"noreferrer" target=3D"_blank">http://www.amd=
.com</a><br>
Libre software enthusiast=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0Mesa and X developer<br>
<br>
</font></blockquote></div><br></div></div></div>

--94eb2c055d18d70199054bb3d0d1--

--===============0082125125==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============0082125125==--
