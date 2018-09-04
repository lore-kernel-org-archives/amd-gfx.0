From: Acewind <acewind-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: CentOS 7 as hostos: gim error:(set_new_adapter:617) asic does not
 support SRIOV
Date: Tue, 4 Sep 2018 15:50:54 +0800
Message-ID: <CA+B2R543+JEA7tGk5QAWN8YP=YUJqj3XyEODrqR9CBhx3+M2-A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1617998245=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
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
To: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org

--===============1617998245==
Content-Type: multipart/alternative; boundary="0000000000008a4e38057506eb3c"

--0000000000008a4e38057506eb3c
Content-Type: text/plain; charset="UTF-8"

Hello!

I'm trying to use an AMD FirePro S7150 in a CentOS 7.3 system. Here is some
information regarding the setup:

[root@host001 /]# uname -r
3.10.0-514.el7.x86_64

[root@host001 /]# dmesg | grep gim
[ 10.887502] gim: loading out-of-tree module taints kernel.
[ 10.887809] gim: module verification failed: signature and/or required key
missing - tainting kernel
[ 10.888860] gim info:(gim_init:144) Start AMD open source GIM
initialization
[ 10.888864] gim info:(gim_init:147) GPU IOV MODULE - version 1.0.0-k
[ 10.888866] gim info:(gim_init:149) Copyright (c) 2014-2017 AMD
Corporation.
[ 10.888887] gim info:(init_config:305) INIT CONFIG
[ 10.888908] gim info:(set_new_adapter:614) curr allocated at
ffffffffa0341a40
[ 10.888910] gim error:(set_new_adapter:617) asic does not support SRIOV
[ 10.888912] gim info:(gim_probe:86) AMD GIM probe: pf_count = 0


SRIOV is already enabled in BIOS.

--0000000000008a4e38057506eb3c
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><p style=3D"box-sizing:border-box;margin-bottom:16px;color=
:rgb(36,41,46);font-family:-apple-system,system-ui,&quot;Segoe UI&quot;,Hel=
vetica,Arial,sans-serif,&quot;Apple Color Emoji&quot;,&quot;Segoe UI Emoji&=
quot;,&quot;Segoe UI Symbol&quot;;font-size:14px;margin-top:0px">Hello!</p>=
<p style=3D"box-sizing:border-box;margin-top:0px;margin-bottom:16px;color:r=
gb(36,41,46);font-family:-apple-system,system-ui,&quot;Segoe UI&quot;,Helve=
tica,Arial,sans-serif,&quot;Apple Color Emoji&quot;,&quot;Segoe UI Emoji&qu=
ot;,&quot;Segoe UI Symbol&quot;;font-size:14px">I&#39;m trying to use an AM=
D FirePro S7150 in a CentOS 7.3 system. Here is some information regarding =
the setup:</p><p style=3D"box-sizing:border-box;margin-top:0px;margin-botto=
m:16px;color:rgb(36,41,46);font-family:-apple-system,system-ui,&quot;Segoe =
UI&quot;,Helvetica,Arial,sans-serif,&quot;Apple Color Emoji&quot;,&quot;Seg=
oe UI Emoji&quot;,&quot;Segoe UI Symbol&quot;;font-size:14px">[root@host001=
 /]# uname -r<br style=3D"box-sizing:border-box">3.10.0-514.el7.x86_64</p><=
p style=3D"box-sizing:border-box;margin-top:0px;color:rgb(36,41,46);font-fa=
mily:-apple-system,system-ui,&quot;Segoe UI&quot;,Helvetica,Arial,sans-seri=
f,&quot;Apple Color Emoji&quot;,&quot;Segoe UI Emoji&quot;,&quot;Segoe UI S=
ymbol&quot;;font-size:14px;margin-bottom:0px">[root@host001 /]# dmesg | gre=
p gim<br style=3D"box-sizing:border-box">[ 10.887502] gim: loading out-of-t=
ree module taints kernel.<br style=3D"box-sizing:border-box">[ 10.887809] g=
im: module verification failed: signature and/or required key missing - tai=
nting kernel<br style=3D"box-sizing:border-box">[ 10.888860] gim info:(gim_=
init:144) Start AMD open source GIM initialization<br style=3D"box-sizing:b=
order-box">[ 10.888864] gim info:(gim_init:147) GPU IOV MODULE - version 1.=
0.0-k<br style=3D"box-sizing:border-box">[ 10.888866] gim info:(gim_init:14=
9) Copyright (c) 2014-2017 AMD Corporation.<br style=3D"box-sizing:border-b=
ox">[ 10.888887] gim info:(init_config:305) INIT CONFIG<br style=3D"box-siz=
ing:border-box">[ 10.888908] gim info:(set_new_adapter:614) curr allocated =
at ffffffffa0341a40<br style=3D"box-sizing:border-box">[ 10.888910] gim err=
or:(set_new_adapter:617) asic does not support SRIOV<br style=3D"box-sizing=
:border-box">[ 10.888912] gim info:(gim_probe:86) AMD GIM probe: pf_count =
=3D 0</p><p style=3D"box-sizing:border-box;margin-top:0px;color:rgb(36,41,4=
6);font-family:-apple-system,system-ui,&quot;Segoe UI&quot;,Helvetica,Arial=
,sans-serif,&quot;Apple Color Emoji&quot;,&quot;Segoe UI Emoji&quot;,&quot;=
Segoe UI Symbol&quot;;font-size:14px;margin-bottom:0px"><br></p><p style=3D=
"box-sizing:border-box;margin-top:0px;color:rgb(36,41,46);font-family:-appl=
e-system,system-ui,&quot;Segoe UI&quot;,Helvetica,Arial,sans-serif,&quot;Ap=
ple Color Emoji&quot;,&quot;Segoe UI Emoji&quot;,&quot;Segoe UI Symbol&quot=
;;font-size:14px;margin-bottom:0px">SRIOV is already enabled in BIOS.</p><p=
 style=3D"box-sizing:border-box;margin-top:0px;color:rgb(36,41,46);font-fam=
ily:-apple-system,system-ui,&quot;Segoe UI&quot;,Helvetica,Arial,sans-serif=
,&quot;Apple Color Emoji&quot;,&quot;Segoe UI Emoji&quot;,&quot;Segoe UI Sy=
mbol&quot;;font-size:14px;margin-bottom:0px"><br></p><p style=3D"box-sizing=
:border-box;margin-top:0px;color:rgb(36,41,46);font-family:-apple-system,sy=
stem-ui,&quot;Segoe UI&quot;,Helvetica,Arial,sans-serif,&quot;Apple Color E=
moji&quot;,&quot;Segoe UI Emoji&quot;,&quot;Segoe UI Symbol&quot;;font-size=
:14px;margin-bottom:0px"><br></p></div>

--0000000000008a4e38057506eb3c--

--===============1617998245==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============1617998245==--
