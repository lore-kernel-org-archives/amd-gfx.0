From: Andres Rodriguez <andresx7-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH resend] allow DRM_MASTER to change client's priorities v2
Date: Mon, 24 Jul 2017 09:26:28 -0400
Message-ID: <CAFQ_0eH3mnXt_7Q4X9h+7stBmeGV4xbauck-sBaS5mGHU4g0+g@mail.gmail.com>
References: <20170707192610.17369-1-andresx7@gmail.com>
 <5975A0AC.8000102@amd.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0082867236=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <5975A0AC.8000102-5C7GfCeVMHo@public.gmane.org>
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
To: zhoucm1 <david1.zhou-5C7GfCeVMHo@public.gmane.org>
Cc: amd-gfx list <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

--===============0082867236==
Content-Type: multipart/alternative; boundary="94eb2c074a789911bb055510295f"

--94eb2c074a789911bb055510295f
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hey David,

I'm not sure if it's been merged yet (I don't have push permissions).

I just had a little baby girl, so I'm taking a couple of weeks off :)

Regards,
Andres

On Jul 24, 2017 3:25 AM, "zhoucm1" <david1.zhou-5C7GfCeVMHo@public.gmane.org> wrote:

Hi Andres,

How about your this set? Have you pushed?

Regards,
David Zhou


On 2017=E5=B9=B407=E6=9C=8808=E6=97=A5 03:26, Andres Rodriguez wrote:

> Little ping on this series for review.
>
> Also added recent reviews/acks and rebased.
>
> Andres Rodriguez (8):
>    drm/amdgpu: add parameter to allocate high priority contexts v11
>    drm/amdgpu: add framework for HW specific priority settings v9
>    drm/amdgpu: implement ring set_priority for gfx_v8 compute v9
>    drm/amdgpu: make amdgpu_to_sched_priority detect invalid parameters
>    drm/amd/sched: allow clients to edit an entity's rq v2
>    drm/amdgpu: introduce AMDGPU_CTX_PRIORITY_UNSET
>    drm/amdgpu: add plumbing for ctx priority changes v2
>    drm/amdgpu: add interface for editing a foreign process's priority v3
>
>   drivers/gpu/drm/amd/amdgpu/Makefile           |   2 +-
>   drivers/gpu/drm/amd/amdgpu/amdgpu.h           |  10 ++-
>   drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c        |   2 +
>   drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c       |  75 +++++++++++++++++-
>   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c    |   2 +
>   drivers/gpu/drm/amd/amdgpu/amdgpu_job.c       |   4 +
>   drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c       |   2 +
>   drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c      |  76 +++++++++++++++++-
>   drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h      |  15 ++++
>   drivers/gpu/drm/amd/amdgpu/amdgpu_sched.c     | 109
> ++++++++++++++++++++++++++
>   drivers/gpu/drm/amd/amdgpu/amdgpu_sched.h     |  34 ++++++++
>   drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c         | 105
> +++++++++++++++++++++++++
>   drivers/gpu/drm/amd/scheduler/gpu_scheduler.c |  26 +++++-
>   drivers/gpu/drm/amd/scheduler/gpu_scheduler.h |  19 ++++-
>   include/uapi/drm/amdgpu_drm.h                 |  28 ++++++-
>   15 files changed, 496 insertions(+), 13 deletions(-)
>   create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_sched.c
>   create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_sched.h
>
>

--94eb2c074a789911bb055510295f
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto">Hey David,<div dir=3D"auto"><br></div><div dir=3D"auto">I=
&#39;m not sure if it&#39;s been merged yet (I don&#39;t have push permissi=
ons).=C2=A0</div><div dir=3D"auto"><br></div><div dir=3D"auto">I just had a=
 little baby girl, so I&#39;m taking a couple of weeks off :)</div><div dir=
=3D"auto"><br></div><div dir=3D"auto">Regards,</div><div dir=3D"auto">Andre=
s</div></div><div class=3D"gmail_extra"><br><div class=3D"gmail_quote">On J=
ul 24, 2017 3:25 AM, &quot;zhoucm1&quot; &lt;<a href=3D"mailto:david1.zhou@=
amd.com">david1.zhou-5C7GfCeVMHo@public.gmane.org</a>&gt; wrote:<br type=3D"attribution"><blockq=
uote class=3D"quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;=
padding-left:1ex">Hi Andres,<br>
<br>
How about your this set? Have you pushed?<br>
<br>
Regards,<br>
David Zhou<div class=3D"elided-text"><br>
<br>
On 2017=E5=B9=B407=E6=9C=8808=E6=97=A5 03:26, Andres Rodriguez wrote:<br>
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex">
Little ping on this series for review.<br>
<br>
Also added recent reviews/acks and rebased.<br>
<br>
Andres Rodriguez (8):<br>
=C2=A0 =C2=A0drm/amdgpu: add parameter to allocate high priority contexts v=
11<br>
=C2=A0 =C2=A0drm/amdgpu: add framework for HW specific priority settings v9=
<br>
=C2=A0 =C2=A0drm/amdgpu: implement ring set_priority for gfx_v8 compute v9<=
br>
=C2=A0 =C2=A0drm/amdgpu: make amdgpu_to_sched_priority detect invalid param=
eters<br>
=C2=A0 =C2=A0drm/amd/sched: allow clients to edit an entity&#39;s rq v2<br>
=C2=A0 =C2=A0drm/amdgpu: introduce AMDGPU_CTX_PRIORITY_UNSET<br>
=C2=A0 =C2=A0drm/amdgpu: add plumbing for ctx priority changes v2<br>
=C2=A0 =C2=A0drm/amdgpu: add interface for editing a foreign process&#39;s =
priority v3<br>
<br>
=C2=A0 drivers/gpu/drm/amd/amdgpu/Mak<wbr>efile=C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0|=C2=A0 =C2=A02 +-<br>
=C2=A0 drivers/gpu/drm/amd/amdgpu/amd<wbr>gpu.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0|=C2=A0 10 ++-<br>
=C2=A0 drivers/gpu/drm/amd/amdgpu/amd<wbr>gpu_cs.c=C2=A0 =C2=A0 =C2=A0 =C2=
=A0 |=C2=A0 =C2=A02 +<br>
=C2=A0 drivers/gpu/drm/amd/amdgpu/amd<wbr>gpu_ctx.c=C2=A0 =C2=A0 =C2=A0 =C2=
=A0|=C2=A0 75 +++++++++++++++++-<br>
=C2=A0 drivers/gpu/drm/amd/amdgpu/amd<wbr>gpu_device.c=C2=A0 =C2=A0 |=C2=A0=
 =C2=A02 +<br>
=C2=A0 drivers/gpu/drm/amd/amdgpu/amd<wbr>gpu_job.c=C2=A0 =C2=A0 =C2=A0 =C2=
=A0|=C2=A0 =C2=A04 +<br>
=C2=A0 drivers/gpu/drm/amd/amdgpu/amd<wbr>gpu_kms.c=C2=A0 =C2=A0 =C2=A0 =C2=
=A0|=C2=A0 =C2=A02 +<br>
=C2=A0 drivers/gpu/drm/amd/amdgpu/amd<wbr>gpu_ring.c=C2=A0 =C2=A0 =C2=A0 |=
=C2=A0 76 +++++++++++++++++-<br>
=C2=A0 drivers/gpu/drm/amd/amdgpu/amd<wbr>gpu_ring.h=C2=A0 =C2=A0 =C2=A0 |=
=C2=A0 15 ++++<br>
=C2=A0 drivers/gpu/drm/amd/amdgpu/amd<wbr>gpu_sched.c=C2=A0 =C2=A0 =C2=A0| =
109 ++++++++++++++++++++++++++<br>
=C2=A0 drivers/gpu/drm/amd/amdgpu/amd<wbr>gpu_sched.h=C2=A0 =C2=A0 =C2=A0|=
=C2=A0 34 ++++++++<br>
=C2=A0 drivers/gpu/drm/amd/amdgpu/gfx<wbr>_v8_0.c=C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0| 105 +++++++++++++++++++++++++<br>
=C2=A0 drivers/gpu/drm/amd/scheduler/<wbr>gpu_scheduler.c |=C2=A0 26 +++++-=
<br>
=C2=A0 drivers/gpu/drm/amd/scheduler/<wbr>gpu_scheduler.h |=C2=A0 19 ++++-<=
br>
=C2=A0 include/uapi/drm/amdgpu_drm.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 28 ++++++-<br>
=C2=A0 15 files changed, 496 insertions(+), 13 deletions(-)<br>
=C2=A0 create mode 100644 drivers/gpu/drm/amd/amdgpu/amd<wbr>gpu_sched.c<br=
>
=C2=A0 create mode 100644 drivers/gpu/drm/amd/amdgpu/amd<wbr>gpu_sched.h<br=
>
<br>
</blockquote>
<br>
</div></blockquote></div><br></div>

--94eb2c074a789911bb055510295f--

--===============0082867236==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============0082867236==--
