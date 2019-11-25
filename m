From: =?UTF-8?Q?Yusuf_Alt=C4=B1parmak?= <yusufalti1997-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [Error] amdgpu for powerpc64 on kernel version 4.19.26
Date: Mon, 25 Nov 2019 19:34:08 +0300
Message-ID: <CAGzVRjyJi6HTbjDUGco7a-M=9tL4m+Q_xPuBbK2or9=rdox9Jg@mail.gmail.com>
References: <CAGzVRjyWG8mJKfn04=_KMPxB=YXnaSVC6yUwWy-0E0ndarJs0g@mail.gmail.com>
 <CADnq5_NEDJ18daPK-1sF5jHF8mD45W0RcGMzEDGSCnxH_qXbbQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1882230614=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <CADnq5_NEDJ18daPK-1sF5jHF8mD45W0RcGMzEDGSCnxH_qXbbQ-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
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
Cc: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org

--===============1882230614==
Content-Type: multipart/alternative; boundary="000000000000d5943105982e55dc"

--000000000000d5943105982e55dc
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

25 Kas 2019 Pzt 17:44 tarihinde Alex Deucher <alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> =C5=9F=
unu
yazd=C4=B1:

> On Mon, Nov 25, 2019 at 8:55 AM Yusuf Alt=C4=B1parmak
> <yusufalti1997-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:
> >
> > Hello,
> >
> > I am trying to use AMD E9171 with T1042D4RDB-64B(
> https://www.nxp.com/products/processors-and-microcontrollers/power-archit=
ecture/qoriq-communication-processors/t-series/qoriq-t1042-and-t1022-multic=
ore-communications-processors:T1042
> ).
> > Software documentation is here (
> https://www.nxp.com/docs/en/supporting-information/QORIQ-SDK-2.0-IC-REV0.=
pdf
> ).
> >
> >
> > I tried to compile 'amdgpu' in linux kernel.
> >
> > I successfully compiled linux kernel for powerpc e5500 architecture. I
> enabled amdgpu and its prerequisites in menuconfig. All drivers compiled
> successfully.
> >
> > But when I try to install 'amdgpu.ko' module, it's not initializing gpu
> hardware. Console messages from 'dmesg' and U-boot is below. Hardware is
> connected to board via PCI and connected to monitor via HDMI-DVI converte=
r.
> I am using HDMI port on monitor.
> >
> > Any suggestion/solutions for this situation?
>
> The driver needs access to the PCI BARs for the device to initialize
> it.  It looks like they are not getting allocated.  Maybe your
> platform has limited MMIO space?  You need to fix that first.
>
> Alex
>
>
> >
> > Regards.
>
> > _______________________________________________
> > amd-gfx mailing list
> > amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
> > https://lists.freedesktop.org/mailman/listinfo/amd-gfx


Okay, thank you Alex. I'll see what I can do.
Regards

--000000000000d5943105982e55dc
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"auto"><div><br><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">25 Kas 2019 Pzt 17:44 tarihinde Alex =
Deucher &lt;<a href=3D"mailto:alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org" target=3D"_blank">alex=
deucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org</a>&gt; =C5=9Funu yazd=C4=B1:<br></div><blockquote class=
=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padd=
ing-left:1ex">On Mon, Nov 25, 2019 at 8:55 AM Yusuf Alt=C4=B1parmak<br>
&lt;<a href=3D"mailto:yusufalti1997-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org" rel=3D"noreferrer" target=3D=
"_blank">yusufalti1997-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org</a>&gt; wrote:<br>
&gt;<br>
&gt; Hello,<br>
&gt;<br>
&gt; I am trying to use AMD E9171 with T1042D4RDB-64B(<a href=3D"https://ww=
w.nxp.com/products/processors-and-microcontrollers/power-architecture/qoriq=
-communication-processors/t-series/qoriq-t1042-and-t1022-multicore-communic=
ations-processors:T1042" rel=3D"noreferrer noreferrer" target=3D"_blank">ht=
tps://www.nxp.com/products/processors-and-microcontrollers/power-architectu=
re/qoriq-communication-processors/t-series/qoriq-t1042-and-t1022-multicore-=
communications-processors:T1042</a>).<br>
&gt; Software documentation is here (<a href=3D"https://www.nxp.com/docs/en=
/supporting-information/QORIQ-SDK-2.0-IC-REV0.pdf" rel=3D"noreferrer norefe=
rrer" target=3D"_blank">https://www.nxp.com/docs/en/supporting-information/=
QORIQ-SDK-2.0-IC-REV0.pdf</a>).<br>
&gt;<br>
&gt;<br>
&gt; I tried to compile &#39;amdgpu&#39; in linux kernel.<br>
&gt;<br>
&gt; I successfully compiled linux kernel for powerpc e5500 architecture. I=
 enabled amdgpu and its prerequisites in menuconfig. All drivers compiled s=
uccessfully.<br>
&gt;<br>
&gt; But when I try to install &#39;amdgpu.ko&#39; module, it&#39;s not ini=
tializing gpu hardware. Console messages from &#39;dmesg&#39; and U-boot is=
 below. Hardware is connected to board via PCI and connected to monitor via=
 HDMI-DVI converter. I am using HDMI port on monitor.<br>
&gt;<br>
&gt; Any suggestion/solutions for this situation?<br>
<br>
The driver needs access to the PCI BARs for the device to initialize<br>
it.=C2=A0 It looks like they are not getting allocated.=C2=A0 Maybe your<br=
>
platform has limited MMIO space?=C2=A0 You need to fix that first.<br>
<br>
Alex<br>
<br><br>
&gt;<br>
&gt; Regards.<br><br>
&gt; _______________________________________________<br>
&gt; amd-gfx mailing list<br>
&gt; <a href=3D"mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" rel=3D"noreferrer" ta=
rget=3D"_blank">amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org</a><br>
&gt; <a href=3D"https://lists.freedesktop.org/mailman/listinfo/amd-gfx" rel=
=3D"noreferrer noreferrer" target=3D"_blank">https://lists.freedesktop.org/=
mailman/listinfo/amd-gfx</a></blockquote><div><br></div><div>Okay, thank yo=
u Alex. I&#39;ll see what I can do.=C2=A0</div><div>Regards=C2=A0</div></di=
v></div></div>
</div>

--000000000000d5943105982e55dc--

--===============1882230614==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4

--===============1882230614==--
