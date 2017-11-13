From: Julien Isorce <julien.isorce-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 0/7] *** GPU recover V3 ***
Date: Mon, 13 Nov 2017 11:24:58 +0000
Message-ID: <CAHWPjbX+gqRLMgr896kzSXPeQnUU8X3_1jPfZtfzLB_VsuEa3A@mail.gmail.com>
References: <1509336909-11455-1-git-send-email-Monk.Liu@amd.com>
 <CAHWPjbU=47WZzbdWYPbP360v4qa6t=_pCtkYcxO2J4bSwA8jVA@mail.gmail.com>
 <CADnq5_Otuz78P8YuoSYZNNx+iy2Pi4bBqLxvt4NrhwYDWXtjLw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1155379798=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <CADnq5_Otuz78P8YuoSYZNNx+iy2Pi4bBqLxvt4NrhwYDWXtjLw-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
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
To: Alex Deucher <alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: amd-gfx list <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, Monk Liu <Monk.Liu-5C7GfCeVMHo@public.gmane.org>

--===============1155379798==
Content-Type: multipart/alternative; boundary="089e082544044cf02c055ddb856f"

--089e082544044cf02c055ddb856f
Content-Type: text/plain; charset="UTF-8"

Hi Alex,

Thx for your reply, but in all of the cases you mentioned, the user would
still
be able to reboot properly ( i.e. typing reboot or a magic keyboard key)
or to have a trace of a kernel panic if it happens, is it correct ?

Thx
Julien

On 9 November 2017 at 18:08, Alex Deucher <alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:

> On Thu, Nov 9, 2017 at 4:35 AM, Julien Isorce <julien.isorce-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> wrote:
> > Hi Monk.
> >
> > I am interested on this. Currently when a "ring X stalled for more than N
> > sec" happens it usually goes into the gpu reset routine.
> > Does it always cause the vram to be lost ? Could you explain what
> happens if
> > the vram remains lost ?
>
> It means the contents of vram are gone or unreliable.  In that case
> applications need to re-initialize all of their buffers before
> submitting any work.  You really need to add GL_robustness support to
> any applications you care about.  Whether vram is lost or not depends
> on the reset method and the asic.  E.g., soft reset of a specific
> engine won't cause a loss of vram, but a full adapter reset or an FLR
> may.
>
> >
> > I am asking this because I experienced some recurrent gpu reset that are
> > marked succeeded from the log but fail in the "resume" step.
> > I would not be interested in this if it would always leave a chance to
> the
> > user to cleanly reboot the machine.
> >
> > The issue is that it can require a hard reboot without kernel panic and
> > without keeping the keyboard responding to magic keys.
> > Are those patches trying to address this issue ?
> >
> > Note that here "issue" is not referring to the root cause of a ring X
> > stalled and it is also not referring to why "resume" step fails.
>
> There were a few issues that caused problems with GPU reset.  The
> biggest was that the GPU scheduler deadlocked in certain cases so if
> you got a GPU hang, the driver locked up.  That should mostly be
> straightened out at this point.  I think there may still be some
> deadlocks in the modesetting code after a reset.  Once that is sorted,
> it will come down to fine tuning the actual reset sequences.  Full
> adapter resets are the easiest to get working reliably (and are
> already implemented in the driver), but also the most destructive.
>
> Alex
>
> >
> > Thx a lot
> > Julien
> >
> >
> > On 30 October 2017 at 04:15, Monk Liu <Monk.Liu-5C7GfCeVMHo@public.gmane.org> wrote:
> >>
> >> *** job skipping logic in scheduler part is re-implemented  ***
> >>
> >> Monk Liu (7):
> >>   amd/scheduler:imple job skip feature(v3)
> >>   drm/amdgpu:implement new GPU recover(v3)
> >>   drm/amdgpu:cleanup in_sriov_reset and lock_reset
> >>   drm/amdgpu:cleanup ucode_init_bo
> >>   drm/amdgpu:block kms open during gpu_reset
> >>   drm/amdgpu/sriov:fix memory leak in psp_load_fw
> >>   drm/amdgpu:fix random missing of FLR NOTIFY
> >>
> >>  drivers/gpu/drm/amd/amdgpu/amdgpu.h           |   9 +-
> >>  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c    | 311
> >> ++++++++++++--------------
> >>  drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c     |  10 +-
> >>  drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c       |   2 +-
> >>  drivers/gpu/drm/amd/amdgpu/amdgpu_job.c       |  18 +-
> >>  drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c       |   3 +
> >>  drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c       |  22 +-
> >>  drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c     |   4 +-
> >>  drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c      |   2 -
> >>  drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h      |   2 -
> >>  drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c         |   6 +-
> >>  drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c         |   6 +-
> >>  drivers/gpu/drm/amd/amdgpu/mxgpu_ai.c         |  16 +-
> >>  drivers/gpu/drm/amd/amdgpu/mxgpu_vi.c         |   2 +-
> >>  drivers/gpu/drm/amd/scheduler/gpu_scheduler.c |  39 ++--
> >>  15 files changed, 220 insertions(+), 232 deletions(-)
> >>
> >> --
> >> 2.7.4
> >>
> >> _______________________________________________
> >> amd-gfx mailing list
> >> amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
> >> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
> >
> >
> >
> > _______________________________________________
> > amd-gfx mailing list
> > amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
> > https://lists.freedesktop.org/mailman/listinfo/amd-gfx
> >
>

--089e082544044cf02c055ddb856f
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi Alex,<div><br></div><div>Thx for your reply, but in all=
 of the cases you mentioned, the user would still</div><div>be able to rebo=
ot properly ( i.e. typing reboot or a magic keyboard key)</div><div>or to h=
ave a trace of a kernel panic if it happens, is it correct ?</div><div><div=
 class=3D"gmail_extra"><br></div><div class=3D"gmail_extra">Thx</div><div c=
lass=3D"gmail_extra">Julien</div><div class=3D"gmail_extra"><br><div class=
=3D"gmail_quote">On 9 November 2017 at 18:08, Alex Deucher <span dir=3D"ltr=
">&lt;<a href=3D"mailto:alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org" target=3D"_blank">alexdeuche=
r@gmail.com</a>&gt;</span> wrote:<br><blockquote class=3D"gmail_quote" styl=
e=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex"><span>O=
n Thu, Nov 9, 2017 at 4:35 AM, Julien Isorce &lt;<a href=3D"mailto:julien.i=
sorce-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org" target=3D"_blank">julien.isorce-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org</a>&gt; wrote:<b=
r>
&gt; Hi Monk.<br>
&gt;<br>
&gt; I am interested on this. Currently when a &quot;ring X stalled for mor=
e than N<br>
&gt; sec&quot; happens it usually goes into the gpu reset routine.<br>
&gt; Does it always cause the vram to be lost ? Could you explain what happ=
ens if<br>
&gt; the vram remains lost ?<br>
<br>
</span>It means the contents of vram are gone or unreliable.=C2=A0 In that =
case<br>
applications need to re-initialize all of their buffers before<br>
submitting any work.=C2=A0 You really need to add GL_robustness support to<=
br>
any applications you care about.=C2=A0 Whether vram is lost or not depends<=
br>
on the reset method and the asic.=C2=A0 E.g., soft reset of a specific<br>
engine won&#39;t cause a loss of vram, but a full adapter reset or an FLR<b=
r>
may.<br>
<span><br>
&gt;<br>
&gt; I am asking this because I experienced some recurrent gpu reset that a=
re<br>
&gt; marked succeeded from the log but fail in the &quot;resume&quot; step.=
<br>
&gt; I would not be interested in this if it would always leave a chance to=
 the<br>
&gt; user to cleanly reboot the machine.<br>
&gt;<br>
&gt; The issue is that it can require a hard reboot without kernel panic an=
d<br>
&gt; without keeping the keyboard responding to magic keys.<br>
&gt; Are those patches trying to address this issue ?<br>
&gt;<br>
&gt; Note that here &quot;issue&quot; is not referring to the root cause of=
 a ring X<br>
&gt; stalled and it is also not referring to why &quot;resume&quot; step fa=
ils.<br>
<br>
</span>There were a few issues that caused problems with GPU reset.=C2=A0 T=
he<br>
biggest was that the GPU scheduler deadlocked in certain cases so if<br>
you got a GPU hang, the driver locked up.=C2=A0 That should mostly be<br>
straightened out at this point.=C2=A0 I think there may still be some<br>
deadlocks in the modesetting code after a reset.=C2=A0 Once that is sorted,=
<br>
it will come down to fine tuning the actual reset sequences.=C2=A0 Full<br>
adapter resets are the easiest to get working reliably (and are<br>
already implemented in the driver), but also the most destructive.<br>
<span class=3D"m_-6113423385651225305HOEnZb"><font color=3D"#888888"><br>
Alex<br>
</font></span><div class=3D"m_-6113423385651225305HOEnZb"><div class=3D"m_-=
6113423385651225305h5"><br>
&gt;<br>
&gt; Thx a lot<br>
&gt; Julien<br>
&gt;<br>
&gt;<br>
&gt; On 30 October 2017 at 04:15, Monk Liu &lt;<a href=3D"mailto:Monk.Liu@a=
md.com" target=3D"_blank">Monk.Liu-5C7GfCeVMHo@public.gmane.org</a>&gt; wrote:<br>
&gt;&gt;<br>
&gt;&gt; *** job skipping logic in scheduler part is re-implemented=C2=A0 *=
**<br>
&gt;&gt;<br>
&gt;&gt; Monk Liu (7):<br>
&gt;&gt;=C2=A0 =C2=A0amd/scheduler:imple job skip feature(v3)<br>
&gt;&gt;=C2=A0 =C2=A0drm/amdgpu:implement new GPU recover(v3)<br>
&gt;&gt;=C2=A0 =C2=A0drm/amdgpu:cleanup in_sriov_reset and lock_reset<br>
&gt;&gt;=C2=A0 =C2=A0drm/amdgpu:cleanup ucode_init_bo<br>
&gt;&gt;=C2=A0 =C2=A0drm/amdgpu:block kms open during gpu_reset<br>
&gt;&gt;=C2=A0 =C2=A0drm/amdgpu/sriov:fix memory leak in psp_load_fw<br>
&gt;&gt;=C2=A0 =C2=A0drm/amdgpu:fix random missing of FLR NOTIFY<br>
&gt;&gt;<br>
&gt;&gt;=C2=A0 drivers/gpu/drm/amd/amdgpu/amd<wbr>gpu.h=C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0|=C2=A0 =C2=A09 +-<br>
&gt;&gt;=C2=A0 drivers/gpu/drm/amd/amdgpu/amd<wbr>gpu_device.c=C2=A0 =C2=A0=
 | 311<br>
&gt;&gt; ++++++++++++--------------<br>
&gt;&gt;=C2=A0 drivers/gpu/drm/amd/amdgpu/amd<wbr>gpu_fence.c=C2=A0 =C2=A0 =
=C2=A0|=C2=A0 10 +-<br>
&gt;&gt;=C2=A0 drivers/gpu/drm/amd/amdgpu/amd<wbr>gpu_irq.c=C2=A0 =C2=A0 =
=C2=A0 =C2=A0|=C2=A0 =C2=A02 +-<br>
&gt;&gt;=C2=A0 drivers/gpu/drm/amd/amdgpu/amd<wbr>gpu_job.c=C2=A0 =C2=A0 =
=C2=A0 =C2=A0|=C2=A0 18 +-<br>
&gt;&gt;=C2=A0 drivers/gpu/drm/amd/amdgpu/amd<wbr>gpu_kms.c=C2=A0 =C2=A0 =
=C2=A0 =C2=A0|=C2=A0 =C2=A03 +<br>
&gt;&gt;=C2=A0 drivers/gpu/drm/amd/amdgpu/amd<wbr>gpu_psp.c=C2=A0 =C2=A0 =
=C2=A0 =C2=A0|=C2=A0 22 +-<br>
&gt;&gt;=C2=A0 drivers/gpu/drm/amd/amdgpu/amd<wbr>gpu_ucode.c=C2=A0 =C2=A0 =
=C2=A0|=C2=A0 =C2=A04 +-<br>
&gt;&gt;=C2=A0 drivers/gpu/drm/amd/amdgpu/amd<wbr>gpu_virt.c=C2=A0 =C2=A0 =
=C2=A0 |=C2=A0 =C2=A02 -<br>
&gt;&gt;=C2=A0 drivers/gpu/drm/amd/amdgpu/amd<wbr>gpu_virt.h=C2=A0 =C2=A0 =
=C2=A0 |=C2=A0 =C2=A02 -<br>
&gt;&gt;=C2=A0 drivers/gpu/drm/amd/amdgpu/gfx<wbr>_v8_0.c=C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0|=C2=A0 =C2=A06 +-<br>
&gt;&gt;=C2=A0 drivers/gpu/drm/amd/amdgpu/gfx<wbr>_v9_0.c=C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0|=C2=A0 =C2=A06 +-<br>
&gt;&gt;=C2=A0 drivers/gpu/drm/amd/amdgpu/mxg<wbr>pu_ai.c=C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0|=C2=A0 16 +-<br>
&gt;&gt;=C2=A0 drivers/gpu/drm/amd/amdgpu/mxg<wbr>pu_vi.c=C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0|=C2=A0 =C2=A02 +-<br>
&gt;&gt;=C2=A0 drivers/gpu/drm/amd/scheduler/<wbr>gpu_scheduler.c |=C2=A0 3=
9 ++--<br>
&gt;&gt;=C2=A0 15 files changed, 220 insertions(+), 232 deletions(-)<br>
&gt;&gt;<br>
&gt;&gt; --<br>
&gt;&gt; 2.7.4<br>
&gt;&gt;<br>
&gt;&gt; ______________________________<wbr>_________________<br>
&gt;&gt; amd-gfx mailing list<br>
&gt;&gt; <a href=3D"mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" target=3D"_blank"=
>amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org</a><br>
&gt;&gt; <a href=3D"https://lists.freedesktop.org/mailman/listinfo/amd-gfx"=
 rel=3D"noreferrer" target=3D"_blank">https://lists.freedesktop.org/<wbr>ma=
ilman/listinfo/amd-gfx</a><br>
&gt;<br>
&gt;<br>
&gt;<br>
&gt; ______________________________<wbr>_________________<br>
&gt; amd-gfx mailing list<br>
&gt; <a href=3D"mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" target=3D"_blank">amd=
-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org</a><br>
&gt; <a href=3D"https://lists.freedesktop.org/mailman/listinfo/amd-gfx" rel=
=3D"noreferrer" target=3D"_blank">https://lists.freedesktop.org/<wbr>mailma=
n/listinfo/amd-gfx</a><br>
&gt;<br>
</div></div></blockquote></div><br></div></div></div>

--089e082544044cf02c055ddb856f--

--===============1155379798==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============1155379798==--
