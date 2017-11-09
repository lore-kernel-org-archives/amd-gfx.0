From: Julien Isorce <julien.isorce-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 0/7] *** GPU recover V3 ***
Date: Thu, 9 Nov 2017 09:35:16 +0000
Message-ID: <CAHWPjbU=47WZzbdWYPbP360v4qa6t=_pCtkYcxO2J4bSwA8jVA@mail.gmail.com>
References: <1509336909-11455-1-git-send-email-Monk.Liu@amd.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1483989758=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <1509336909-11455-1-git-send-email-Monk.Liu-5C7GfCeVMHo@public.gmane.org>
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
To: Monk Liu <Monk.Liu-5C7GfCeVMHo@public.gmane.org>
Cc: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org

--===============1483989758==
Content-Type: multipart/alternative; boundary="001a113f587095c3a4055d898581"

--001a113f587095c3a4055d898581
Content-Type: text/plain; charset="UTF-8"

Hi Monk.

I am interested on this. Currently when a "ring X stalled for more than N
sec" happens it usually goes into the gpu reset routine.
Does it always cause the vram to be lost ? Could you explain what happens
if the vram remains lost ?

I am asking this because I experienced some recurrent gpu reset that are
marked succeeded from the log but fail in the "resume" step.
I would not be interested in this if it would always leave a chance to the
user to cleanly reboot the machine.

The issue is that it can require a hard reboot without kernel panic and
without keeping the keyboard responding to magic keys.
Are those patches trying to address this issue ?

Note that here "issue" is not referring to the root cause of a ring X
stalled and it is also not referring to why "resume" step fails.

Thx a lot
Julien


On 30 October 2017 at 04:15, Monk Liu <Monk.Liu-5C7GfCeVMHo@public.gmane.org> wrote:

> *** job skipping logic in scheduler part is re-implemented  ***
>
> Monk Liu (7):
>   amd/scheduler:imple job skip feature(v3)
>   drm/amdgpu:implement new GPU recover(v3)
>   drm/amdgpu:cleanup in_sriov_reset and lock_reset
>   drm/amdgpu:cleanup ucode_init_bo
>   drm/amdgpu:block kms open during gpu_reset
>   drm/amdgpu/sriov:fix memory leak in psp_load_fw
>   drm/amdgpu:fix random missing of FLR NOTIFY
>
>  drivers/gpu/drm/amd/amdgpu/amdgpu.h           |   9 +-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c    | 311
> ++++++++++++--------------
>  drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c     |  10 +-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c       |   2 +-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_job.c       |  18 +-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c       |   3 +
>  drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c       |  22 +-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c     |   4 +-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c      |   2 -
>  drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h      |   2 -
>  drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c         |   6 +-
>  drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c         |   6 +-
>  drivers/gpu/drm/amd/amdgpu/mxgpu_ai.c         |  16 +-
>  drivers/gpu/drm/amd/amdgpu/mxgpu_vi.c         |   2 +-
>  drivers/gpu/drm/amd/scheduler/gpu_scheduler.c |  39 ++--
>  15 files changed, 220 insertions(+), 232 deletions(-)
>
> --
> 2.7.4
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
>

--001a113f587095c3a4055d898581
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi Monk.<div><br></div><div>I am interested on this. Curre=
ntly when a &quot;ring X stalled for more than N sec&quot; happens it usual=
ly goes into the gpu reset routine.</div><div>Does it always cause the vram=
 to be lost ? Could you explain what happens if the vram remains lost ?</di=
v><div><br></div><div>I am asking this because I experienced some recurrent=
 gpu reset that are marked succeeded from the log but fail in the &quot;res=
ume&quot; step.</div><div>I would not be interested in this if it would alw=
ays leave a chance to the user to cleanly reboot the machine.</div><div><br=
></div><div>The issue is that it can require a hard reboot without kernel p=
anic and without keeping the keyboard responding to magic keys.</div><div>A=
re those patches trying to address this issue ?<br></div><div><br></div><di=
v>Note that here &quot;issue&quot; is not referring to the root cause of a =
ring X stalled and it is also not referring to why &quot;resume&quot; step =
fails.=C2=A0<br></div><div><br></div><div>Thx a lot</div><div>Julien</div><=
div><br></div></div><div class=3D"gmail_extra"><br><div class=3D"gmail_quot=
e">On 30 October 2017 at 04:15, Monk Liu <span dir=3D"ltr">&lt;<a href=3D"m=
ailto:Monk.Liu-5C7GfCeVMHo@public.gmane.org" target=3D"_blank">Monk.Liu-5C7GfCeVMHo@public.gmane.org</a>&gt;</span> w=
rote:<br><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;borde=
r-left:1px #ccc solid;padding-left:1ex">*** job skipping logic in scheduler=
 part is re-implemented=C2=A0 ***<br>
<br>
Monk Liu (7):<br>
=C2=A0 amd/scheduler:imple job skip feature(v3)<br>
=C2=A0 drm/amdgpu:implement new GPU recover(v3)<br>
=C2=A0 drm/amdgpu:cleanup in_sriov_reset and lock_reset<br>
=C2=A0 drm/amdgpu:cleanup ucode_init_bo<br>
=C2=A0 drm/amdgpu:block kms open during gpu_reset<br>
=C2=A0 drm/amdgpu/sriov:fix memory leak in psp_load_fw<br>
=C2=A0 drm/amdgpu:fix random missing of FLR NOTIFY<br>
<br>
=C2=A0drivers/gpu/drm/amd/amdgpu/<wbr>amdgpu.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0|=C2=A0 =C2=A09 +-<br>
=C2=A0drivers/gpu/drm/amd/amdgpu/<wbr>amdgpu_device.c=C2=A0 =C2=A0 | 311 ++=
++++++++++--------------<br>
=C2=A0drivers/gpu/drm/amd/amdgpu/<wbr>amdgpu_fence.c=C2=A0 =C2=A0 =C2=A0|=
=C2=A0 10 +-<br>
=C2=A0drivers/gpu/drm/amd/amdgpu/<wbr>amdgpu_irq.c=C2=A0 =C2=A0 =C2=A0 =C2=
=A0|=C2=A0 =C2=A02 +-<br>
=C2=A0drivers/gpu/drm/amd/amdgpu/<wbr>amdgpu_job.c=C2=A0 =C2=A0 =C2=A0 =C2=
=A0|=C2=A0 18 +-<br>
=C2=A0drivers/gpu/drm/amd/amdgpu/<wbr>amdgpu_kms.c=C2=A0 =C2=A0 =C2=A0 =C2=
=A0|=C2=A0 =C2=A03 +<br>
=C2=A0drivers/gpu/drm/amd/amdgpu/<wbr>amdgpu_psp.c=C2=A0 =C2=A0 =C2=A0 =C2=
=A0|=C2=A0 22 +-<br>
=C2=A0drivers/gpu/drm/amd/amdgpu/<wbr>amdgpu_ucode.c=C2=A0 =C2=A0 =C2=A0|=
=C2=A0 =C2=A04 +-<br>
=C2=A0drivers/gpu/drm/amd/amdgpu/<wbr>amdgpu_virt.c=C2=A0 =C2=A0 =C2=A0 |=
=C2=A0 =C2=A02 -<br>
=C2=A0drivers/gpu/drm/amd/amdgpu/<wbr>amdgpu_virt.h=C2=A0 =C2=A0 =C2=A0 |=
=C2=A0 =C2=A02 -<br>
=C2=A0drivers/gpu/drm/amd/amdgpu/<wbr>gfx_v8_0.c=C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0|=C2=A0 =C2=A06 +-<br>
=C2=A0drivers/gpu/drm/amd/amdgpu/<wbr>gfx_v9_0.c=C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0|=C2=A0 =C2=A06 +-<br>
=C2=A0drivers/gpu/drm/amd/amdgpu/<wbr>mxgpu_ai.c=C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0|=C2=A0 16 +-<br>
=C2=A0drivers/gpu/drm/amd/amdgpu/<wbr>mxgpu_vi.c=C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0|=C2=A0 =C2=A02 +-<br>
=C2=A0drivers/gpu/drm/amd/scheduler/<wbr>gpu_scheduler.c |=C2=A0 39 ++--<br=
>
=C2=A015 files changed, 220 insertions(+), 232 deletions(-)<br>
<span class=3D"HOEnZb"><font color=3D"#888888"><br>
--<br>
2.7.4<br>
<br>
______________________________<wbr>_________________<br>
amd-gfx mailing list<br>
<a href=3D"mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org">amd-gfx-PD4FTy7X32lNgt0PjOBp9/rsn8yoX9R0@public.gmane.org=
org</a><br>
<a href=3D"https://lists.freedesktop.org/mailman/listinfo/amd-gfx" rel=3D"n=
oreferrer" target=3D"_blank">https://lists.freedesktop.org/<wbr>mailman/lis=
tinfo/amd-gfx</a><br>
</font></span></blockquote></div><br></div>

--001a113f587095c3a4055d898581--

--===============1483989758==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============1483989758==--
