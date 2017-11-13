From: Julien Isorce <julien.isorce-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 0/7] *** GPU recover V3 ***
Date: Mon, 13 Nov 2017 11:26:43 +0000
Message-ID: <CAHWPjbXgf9tzxKk4osWaKVPDYAwQGeEHdpHeSaYc4S5yHnrgMA@mail.gmail.com>
References: <1509336909-11455-1-git-send-email-Monk.Liu@amd.com>
 <CAHWPjbU=47WZzbdWYPbP360v4qa6t=_pCtkYcxO2J4bSwA8jVA@mail.gmail.com>
 <BY1PR12MB0456E48B02CFAE654F1F145484540@BY1PR12MB0456.namprd12.prod.outlook.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2060448133=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <BY1PR12MB0456E48B02CFAE654F1F145484540-PicGAnIBOoZZHrdT0E092gdYzm3356FpvxpqHgZTriW3zl9H0oFU5g@public.gmane.org>
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
To: "Liu, Monk" <Monk.Liu-5C7GfCeVMHo@public.gmane.org>
Cc: "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

--===============2060448133==
Content-Type: multipart/alternative; boundary="001a11413a2c8b3ab4055ddb8b0e"

--001a11413a2c8b3ab4055ddb8b0e
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Monk,

It was more a general question. So you never need to do an electrical
reboot when a gpu reset fails ?

Thx
Julien

On 10 November 2017 at 07:51, Liu, Monk <Monk.Liu-5C7GfCeVMHo@public.gmane.org> wrote:

> Please share the dmesg log, and what=E2=80=99s the chip are you using ?
>
>
>
> *From:* Julien Isorce [mailto:julien.isorce-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org]
> *Sent:* 2017=E5=B9=B411=E6=9C=889=E6=97=A5 17:35
> *To:* Liu, Monk <Monk.Liu-5C7GfCeVMHo@public.gmane.org>
> *Cc:* amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
> *Subject:* Re: [PATCH 0/7] *** GPU recover V3 ***
>
>
>
> Hi Monk.
>
>
>
> I am interested on this. Currently when a "ring X stalled for more than N
> sec" happens it usually goes into the gpu reset routine.
>
> Does it always cause the vram to be lost ? Could you explain what happens
> if the vram remains lost ?
>
>
>
> I am asking this because I experienced some recurrent gpu reset that are
> marked succeeded from the log but fail in the "resume" step.
>
> I would not be interested in this if it would always leave a chance to th=
e
> user to cleanly reboot the machine.
>
>
>
> The issue is that it can require a hard reboot without kernel panic and
> without keeping the keyboard responding to magic keys.
>
> Are those patches trying to address this issue ?
>
>
>
> Note that here "issue" is not referring to the root cause of a ring X
> stalled and it is also not referring to why "resume" step fails.
>
>
>
> Thx a lot
>
> Julien
>
>
>
>
>
> On 30 October 2017 at 04:15, Monk Liu <Monk.Liu-5C7GfCeVMHo@public.gmane.org> wrote:
>
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
>
>

--001a11413a2c8b3ab4055ddb8b0e
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi Monk,<div><br></div><div>It was more a general question=
. So you never need to do an electrical reboot when a gpu reset fails ?</di=
v><div><br></div><div>Thx</div><div>Julien<br><div class=3D"gmail_extra"><b=
r><div class=3D"gmail_quote">On 10 November 2017 at 07:51, Liu, Monk <span =
dir=3D"ltr">&lt;<a href=3D"mailto:Monk.Liu-5C7GfCeVMHo@public.gmane.org" target=3D"_blank">Monk.=
Liu-5C7GfCeVMHo@public.gmane.org</a>&gt;</span> wrote:<br><blockquote class=3D"gmail_quote" styl=
e=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">





<div lang=3D"ZH-CN" link=3D"blue" vlink=3D"purple">
<div class=3D"m_-1683366303938199314WordSection1">
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-size:10.5pt;font-=
family:=E7=AD=89=E7=BA=BF">Please share the dmesg log, and what=E2=80=99s t=
he chip are you using ?<u></u><u></u></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-size:10.5pt;font-=
family:=E7=AD=89=E7=BA=BF"><u></u>=C2=A0<u></u></span></p>
<p class=3D"MsoNormal"><b><span lang=3D"EN-US" style=3D"font-size:11.0pt;fo=
nt-family:&quot;Calibri&quot;,sans-serif">From:</span></b><span lang=3D"EN-=
US" style=3D"font-size:11.0pt;font-family:&quot;Calibri&quot;,sans-serif"> =
Julien Isorce [mailto:<a href=3D"mailto:julien.isorce-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org" target=3D"=
_blank">julien.isorce@gmail.<wbr>com</a>]
<br>
<b>Sent:</b> 2017</span><span style=3D"font-size:11.0pt">=E5=B9=B4</span><s=
pan lang=3D"EN-US" style=3D"font-size:11.0pt;font-family:&quot;Calibri&quot=
;,sans-serif">11</span><span style=3D"font-size:11.0pt">=E6=9C=88</span><sp=
an lang=3D"EN-US" style=3D"font-size:11.0pt;font-family:&quot;Calibri&quot;=
,sans-serif">9</span><span style=3D"font-size:11.0pt">=E6=97=A5</span><span=
 lang=3D"EN-US" style=3D"font-size:11.0pt;font-family:&quot;Calibri&quot;,s=
ans-serif">
 17:35<br>
<b>To:</b> Liu, Monk &lt;<a href=3D"mailto:Monk.Liu-5C7GfCeVMHo@public.gmane.org" target=3D"_bla=
nk">Monk.Liu-5C7GfCeVMHo@public.gmane.org</a>&gt;<br>
<b>Cc:</b> <a href=3D"mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" target=3D"_blan=
k">amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org</a><br>
<b>Subject:</b> Re: [PATCH 0/7] *** GPU recover V3 ***<u></u><u></u></span>=
</p><div><div class=3D"h5">
<p class=3D"MsoNormal"><span lang=3D"EN-US"><u></u>=C2=A0<u></u></span></p>
<div>
<p class=3D"MsoNormal"><span lang=3D"EN-US">Hi Monk.<u></u><u></u></span></=
p>
<div>
<p class=3D"MsoNormal"><span lang=3D"EN-US"><u></u>=C2=A0<u></u></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span lang=3D"EN-US">I am interested on this. Curren=
tly when a &quot;ring X stalled for more than N sec&quot; happens it usuall=
y goes into the gpu reset routine.<u></u><u></u></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span lang=3D"EN-US">Does it always cause the vram t=
o be lost ? Could you explain what happens if the vram remains lost ?<u></u=
><u></u></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span lang=3D"EN-US"><u></u>=C2=A0<u></u></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span lang=3D"EN-US">I am asking this because I expe=
rienced some recurrent gpu reset that are marked succeeded from the log but=
 fail in the &quot;resume&quot; step.<u></u><u></u></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span lang=3D"EN-US">I would not be interested in th=
is if it would always leave a chance to the user to cleanly reboot the mach=
ine.<u></u><u></u></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span lang=3D"EN-US"><u></u>=C2=A0<u></u></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span lang=3D"EN-US">The issue is that it can requir=
e a hard reboot without kernel panic and without keeping the keyboard respo=
nding to magic keys.<u></u><u></u></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span lang=3D"EN-US">Are those patches trying to add=
ress this issue ?<u></u><u></u></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span lang=3D"EN-US"><u></u>=C2=A0<u></u></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span lang=3D"EN-US">Note that here &quot;issue&quot=
; is not referring to the root cause of a ring X stalled and it is also not=
 referring to why &quot;resume&quot; step fails.=C2=A0<u></u><u></u></span>=
</p>
</div>
<div>
<p class=3D"MsoNormal"><span lang=3D"EN-US"><u></u>=C2=A0<u></u></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span lang=3D"EN-US">Thx a lot<u></u><u></u></span><=
/p>
</div>
<div>
<p class=3D"MsoNormal"><span lang=3D"EN-US">Julien<u></u><u></u></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span lang=3D"EN-US"><u></u>=C2=A0<u></u></span></p>
</div>
</div>
<div>
<p class=3D"MsoNormal"><span lang=3D"EN-US"><u></u>=C2=A0<u></u></span></p>
<div>
<p class=3D"MsoNormal"><span lang=3D"EN-US">On 30 October 2017 at 04:15, Mo=
nk Liu &lt;<a href=3D"mailto:Monk.Liu-5C7GfCeVMHo@public.gmane.org" target=3D"_blank">Monk.Liu@a=
md.com</a>&gt; wrote:<u></u><u></u></span></p>
<blockquote style=3D"border:none;border-left:solid #cccccc 1.0pt;padding:0c=
m 0cm 0cm 6.0pt;margin-left:4.8pt;margin-right:0cm">
<p class=3D"MsoNormal"><span lang=3D"EN-US">*** job skipping logic in sched=
uler part is re-implemented=C2=A0 ***<br>
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
=C2=A0drivers/gpu/drm/amd/<wbr>scheduler/gpu_scheduler.c |=C2=A0 39 ++--<br=
>
=C2=A015 files changed, 220 insertions(+), 232 deletions(-)<br>
<span style=3D"color:#888888"><br>
<span class=3D"m_-1683366303938199314hoenzb">--</span><br>
<span class=3D"m_-1683366303938199314hoenzb">2.7.4</span><br>
<br>
<span class=3D"m_-1683366303938199314hoenzb">______________________________=
<wbr>_________________</span><br>
<span class=3D"m_-1683366303938199314hoenzb">amd-gfx mailing list</span><br=
>
<span class=3D"m_-1683366303938199314hoenzb"><a href=3D"mailto:amd-gfx@list=
s.freedesktop.org" target=3D"_blank">amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org</a></spa=
n><br>
<span class=3D"m_-1683366303938199314hoenzb"><a href=3D"https://lists.freed=
esktop.org/mailman/listinfo/amd-gfx" target=3D"_blank">https://lists.freede=
sktop.org/<wbr>mailman/listinfo/amd-gfx</a></span></span><u></u><u></u></sp=
an></p>
</blockquote>
</div>
<p class=3D"MsoNormal"><span lang=3D"EN-US"><u></u>=C2=A0<u></u></span></p>
</div>
</div></div></div>
</div>

</blockquote></div><br></div></div></div>

--001a11413a2c8b3ab4055ddb8b0e--

--===============2060448133==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============2060448133==--
