From: Andres Rodriguez <andresx7-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH] radv: Initial implementation of
 VK_EXT_queue_global_priority
Date: Tue, 3 Jan 2017 22:26:07 -0500
Message-ID: <CAFQ_0eEf=qLF6Kgj38Av8hm_6s9MfCBN3xtg-HZOugw3HnjBTw@mail.gmail.com>
References: <20170104022229.7747-1-andresx7@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1055478061=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <20170104022229.7747-1-andresx7-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
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
To: amd-gfx list <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

--===============1055478061==
Content-Type: multipart/alternative; boundary=94eb2c11ca14755adb05453c58e5

--94eb2c11ca14755adb05453c58e5
Content-Type: text/plain; charset=UTF-8

Hey Guys,

One of my first non-trivial contributions to mesa here. Let me know if I've
messed up anything, bad coding style or some patch validation script I
should've run or any other kind of pitfall a newbie might make.

I tried to follow the guidelines over at:
http://www.mesa3d.org/devinfo.html

Although some of them seen to not apply anymore (radv code was tabs instead
of 3 spaces).

Thanks for taking the time to review :)

Regards,
Andres


On Tue, Jan 3, 2017 at 9:22 PM, Andres Rodriguez <andresx7-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:

> This patch series implements VK_EXT_queue_global_priority, a vulkan
> extension
> that focuses on providing scheduling guarantees.
>
> For further information on the use case refer to:
> https://lists.freedesktop.org/archives/amd-gfx/2016-December/004068.html
>
> For some perf data on this initial implementation:
> https://lists.freedesktop.org/archives/amd-gfx/2016-December/004257.html
>
> Test apps available at:
> https://github.com/lostgoat/Vulkan
>
> Related amdgpu and libdrm_amdgpu patches can be found on the amd-gfx
> mailing list.
>
> Additionaly, results for vk-cts -n *semaphore* on an RX480:
>
> Test run totals:
>   Passed:        1821/4046 (45.0%)
>   Failed:        0/4046 (0.0%)
>   Not supported: 2225/4046 (55.0%)
>   Warnings:      0/4046 (0.0%)
>
>

--94eb2c11ca14755adb05453c58e5
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div><div><div><div>Hey Guys,<br><br></div>One of my first=
 non-trivial contributions to mesa here. Let me know if I&#39;ve messed up =
anything, bad coding style or some patch validation script I should&#39;ve =
run or any other kind of pitfall a newbie might make.<br><br></div>I tried =
to follow the guidelines over at:<br><a href=3D"http://www.mesa3d.org/devin=
fo.html">http://www.mesa3d.org/devinfo.html</a><br><br></div>Although some =
of them seen to not apply anymore (radv code was tabs instead of 3 spaces).=
<br><br></div><div>Thanks for taking the time to review :)<br><br></div><di=
v>Regards,<br></div><div>Andres<br></div><br></div><div class=3D"gmail_extr=
a"><br><div class=3D"gmail_quote">On Tue, Jan 3, 2017 at 9:22 PM, Andres Ro=
driguez <span dir=3D"ltr">&lt;<a href=3D"mailto:andresx7-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org" target=
=3D"_blank">andresx7-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org</a>&gt;</span> wrote:<br><blockquote class=
=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padd=
ing-left:1ex">This patch series implements VK_EXT_queue_global_priority, a =
vulkan extension<br>
that focuses on providing scheduling guarantees.<br>
<br>
For further information on the use case refer to:<br>
<a href=3D"https://lists.freedesktop.org/archives/amd-gfx/2016-December/004=
068.html" rel=3D"noreferrer" target=3D"_blank">https://lists.freedesktop.or=
g/<wbr>archives/amd-gfx/2016-<wbr>December/004068.html</a><br>
<br>
For some perf data on this initial implementation:<br>
<a href=3D"https://lists.freedesktop.org/archives/amd-gfx/2016-December/004=
257.html" rel=3D"noreferrer" target=3D"_blank">https://lists.freedesktop.or=
g/<wbr>archives/amd-gfx/2016-<wbr>December/004257.html</a><br>
<br>
Test apps available at:<br>
<a href=3D"https://github.com/lostgoat/Vulkan" rel=3D"noreferrer" target=3D=
"_blank">https://github.com/lostgoat/<wbr>Vulkan</a><br>
<br>
Related amdgpu and libdrm_amdgpu patches can be found on the amd-gfx mailin=
g list.<br>
<br>
Additionaly, results for vk-cts -n *semaphore* on an RX480:<br>
<br>
Test run totals:<br>
=C2=A0 Passed:=C2=A0 =C2=A0 =C2=A0 =C2=A0 1821/4046 (45.0%)<br>
=C2=A0 Failed:=C2=A0 =C2=A0 =C2=A0 =C2=A0 0/4046 (0.0%)<br>
=C2=A0 Not supported: 2225/4046 (55.0%)<br>
=C2=A0 Warnings:=C2=A0 =C2=A0 =C2=A0 0/4046 (0.0%)<br>
<br>
</blockquote></div><br></div>

--94eb2c11ca14755adb05453c58e5--

--===============1055478061==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============1055478061==--
