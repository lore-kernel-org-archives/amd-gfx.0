From: Mike Lothian <mike-4+n8WJKc9ve9FHfhHBbuYA@public.gmane.org>
Subject: Re: Raven Ridge Ryzen 2500U hang reproduced
Date: Wed, 28 Mar 2018 12:46:32 +0100
Message-ID: <CAHbf0-GyHStsECye3yJnGjTZCYcupEyXdeuRY0Vfcs+iEgRYPA@mail.gmail.com>
References: <CAJri6_tTnk6Q0VCFRR-4GFw+3QVo9iyXpFtQS6uLLcXgPNEeGw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0705862010=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <CAJri6_tTnk6Q0VCFRR-4GFw+3QVo9iyXpFtQS6uLLcXgPNEeGw-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
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
To: =?UTF-8?Q?Br=C3=A1ulio_Bhavamitra?= <brauliobo-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: amd-gfx list <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

--===============0705862010==
Content-Type: multipart/alternative; boundary="001a11402dd030a83e0568779036"

--001a11402dd030a83e0568779036
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 27 Mar 2018, 00:30 Br=C3=A1ulio Bhavamitra, <brauliobo-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> w=
rote:

> Hi all,
>
> Following the random crashes happenning with many users (e.g.
> https://www.phoronix.com/scan.php?page=3Dnews_item&
> px=3DRaven-Ridge-March-Update), not only on Linux but also Windows, I've
> been struggling to reproduce and generate any error log.
>
> After discovering that the error only happenned with KDE and games (at
> least for me, see https://bugs.kde.org/show_bug.cgi?id=3D392378), I could
> reproduce after a failing suspend.
>
> The crash most of the times allows the mouse to keep moving, but anything
> else works. Except for this time the keyboard worked so I could switch th=
e
> tty and save the dmesg messages. After this I had to force reboot as it g=
ot
> stuck trying to kill the lightdm service (gpu hanged?).
>
> The errors are, see attached the full dmesg:
> [ 2899.525650] amdgpu 0000:03:00.0: couldn't schedule ib on ring <sdma0>
> [ 2899.525769] [drm:amdgpu_job_run [amdgpu]] *ERROR* Error scheduling IBs
> (-22)
> [ 2909.125047] [drm:amdgpu_job_timedout [amdgpu]] *ERROR* ring gfx
> timeout, last signaled seq=3D174624, last emitted seq=3D174627
> [ 2909.125060] [drm] IP block:psp is hung!
> [ 2909.125063] [drm] GPU recovery disabled.
> [ 2914.756931] [drm:amdgpu_cs_ioctl [amdgpu]] *ERROR*
> amdgpu_cs_list_validate(validated) failed.
> [ 2914.756997] [drm:amdgpu_cs_ioctl [amdgpu]] *ERROR* Failed to process
> the buffer list -16!
> [ 2914.997372] amdgpu 0000:03:00.0: couldn't schedule ib on ring <sdma0>
> [ 2914.997498] [drm:amdgpu_job_run [amdgpu]] *ERROR* Error scheduling IBs
> (-22)
> [ 2930.117275] [drm:amdgpu_cs_ioctl [amdgpu]] *ERROR*
> amdgpu_cs_list_validate(validated) failed.
> [ 2930.117405] [drm:amdgpu_cs_ioctl [amdgpu]] *ERROR* Failed to process
> the buffer list -16!
> [ 2930.152015] [drm:amdgpu_fill_buffer [amdgpu]] *ERROR* Trying to clear
> memory with ring turned off.
> [ 2930.157940] [drm:amdgpu_fill_buffer [amdgpu]] *ERROR* Trying to clear
> memory with ring turned off.
> [ 2930.180535] [drm:amdgpu_fill_buffer [amdgpu]] *ERROR* Trying to clear
> memory with ring turned off.
> [ 2933.781692] IPv6: ADDRCONF(NETDEV_CHANGE): wlp2s0: link becomes ready
> [ 2945.477205] [drm:amdgpu_cs_ioctl [amdgpu]] *ERROR*
> amdgpu_cs_list_validate(validated) failed.
> [ 2945.477348] [drm:amdgpu_cs_ioctl [amdgpu]] *ERROR* Failed to process
> the buffer list -16!
>
> System details:
> HP Envy x360 Ryzen 2500U
> ArchLinux, kernel 4.16rc6 and 4.15.12
>
> Cheers,
> br=C3=A1ulio
> _______________________________________________
> amd-gfx mailing list
> amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx


Hi

I think I've seen that issue in KDE too, where the mouse moves but nothing
else works. I found that switching VT's and back again fixes things for me

The weird thing is I'm seeing this on i965 (amdgpu is used for games only
with PRIME)

What version of X, Qt, KDE Frameworks and Plasma are you using?

Cheers

Mike

--001a11402dd030a83e0568779036
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><br><br><div class=3D"gmail_quote"><div dir=3D"ltr">On Tue=
, 27 Mar 2018, 00:30 Br=C3=A1ulio Bhavamitra, &lt;<a href=3D"mailto:braulio=
bo-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org" target=3D"_blank">brauliobo-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org</a>&gt; wrote:<br></div=
><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1=
px #ccc solid;padding-left:1ex"><div dir=3D"ltr">Hi all,<div><br></div><div=
>Following the random crashes happenning with many users (e.g.=C2=A0<a href=
=3D"https://www.phoronix.com/scan.php?page=3Dnews_item&amp;px=3DRaven-Ridge=
-March-Update" target=3D"_blank">https://www.phoronix.<wbr>com/scan.php?pag=
e=3Dnews_item&amp;<wbr>px=3DRaven-Ridge-March-Update</a>), not only on Linu=
x but also Windows, I&#39;ve been struggling to reproduce and generate any =
error log.</div><div><br></div><div>After discovering that the error only h=
appenned with KDE and games (at least for me, see=C2=A0<a href=3D"https://b=
ugs.kde.org/show_bug.cgi?id=3D392378" target=3D"_blank">https://bugs.kde.or=
g/show_<wbr>bug.cgi?id=3D392378</a>), I could reproduce after a failing sus=
pend.</div><div><br></div><div>The crash most of the times allows the mouse=
 to keep moving, but anything else works. Except for this time the keyboard=
 worked so I could switch the tty and save the dmesg messages. After this I=
 had to force reboot as it got stuck trying to kill the lightdm service (gp=
u hanged?).</div><div><br></div><div>The errors are, see attached the full =
dmesg:</div><div><div>[ 2899.525650] amdgpu 0000:03:00.0: couldn&#39;t sche=
dule ib on ring &lt;sdma0&gt;</div><div>[ 2899.525769] [drm:amdgpu_job_run =
[amdgpu]] *ERROR* Error scheduling IBs (-22)</div><div>[ 2909.125047] [drm:=
amdgpu_job_timedout [amdgpu]] *ERROR* ring gfx timeout, last signaled seq=
=3D174624, last emitted seq=3D174627</div><div>[ 2909.125060] [drm] IP bloc=
k:psp is hung!</div><div>[ 2909.125063] [drm] GPU recovery disabled.</div><=
div>[ 2914.756931] [drm:amdgpu_cs_ioctl [amdgpu]] *ERROR* amdgpu_cs_list_va=
lidate(<wbr>validated) failed.</div><div>[ 2914.756997] [drm:amdgpu_cs_ioct=
l [amdgpu]] *ERROR* Failed to process the buffer list -16!</div><div>[ 2914=
.997372] amdgpu 0000:03:00.0: couldn&#39;t schedule ib on ring &lt;sdma0&gt=
;</div><div>[ 2914.997498] [drm:amdgpu_job_run [amdgpu]] *ERROR* Error sche=
duling IBs (-22)</div><div>[ 2930.117275] [drm:amdgpu_cs_ioctl [amdgpu]] *E=
RROR* amdgpu_cs_list_validate(<wbr>validated) failed.</div><div>[ 2930.1174=
05] [drm:amdgpu_cs_ioctl [amdgpu]] *ERROR* Failed to process the buffer lis=
t -16!</div><div>[ 2930.152015] [drm:amdgpu_fill_buffer [amdgpu]] *ERROR* T=
rying to clear memory with ring turned off.</div><div>[ 2930.157940] [drm:a=
mdgpu_fill_buffer [amdgpu]] *ERROR* Trying to clear memory with ring turned=
 off.</div><div>[ 2930.180535] [drm:amdgpu_fill_buffer [amdgpu]] *ERROR* Tr=
ying to clear memory with ring turned off.</div><div>[ 2933.781692] IPv6: A=
DDRCONF(NETDEV_CHANGE): wlp2s0: link becomes ready</div><div>[ 2945.477205]=
 [drm:amdgpu_cs_ioctl [amdgpu]] *ERROR* amdgpu_cs_list_validate(<wbr>valida=
ted) failed.</div><div>[ 2945.477348] [drm:amdgpu_cs_ioctl [amdgpu]] *ERROR=
* Failed to process the buffer list -16!</div></div><div><br></div><div>Sys=
tem details:</div><div>HP Envy x360 Ryzen 2500U</div><div>ArchLinux, kernel=
 4.16rc6 and 4.15.12</div><div><br></div><div>Cheers,</div><div>br=C3=A1uli=
o</div></div>
______________________________<wbr>_________________<br>
amd-gfx mailing list<br>
<a href=3D"mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" target=3D"_blank">amd-gfx@=
lists.freedesktop.org</a><br>
<a href=3D"https://lists.freedesktop.org/mailman/listinfo/amd-gfx" rel=3D"n=
oreferrer" target=3D"_blank">https://lists.freedesktop.org/<wbr>mailman/lis=
tinfo/amd-gfx</a></blockquote></div><div class=3D"gmail_quote"><div><br></d=
iv><div>Hi</div><div><br></div><div>I think I&#39;ve seen that issue in KDE=
 too, where the mouse moves but nothing else works. I found that switching =
VT&#39;s and back again fixes things for me</div><div><br></div><div>The we=
ird thing is I&#39;m seeing this on i965 (amdgpu is used for games only wit=
h PRIME)</div><div><br></div><div>What version of X, Qt, KDE Frameworks and=
 Plasma are you using?</div><div><br></div><div>Cheers</div><div><br></div>=
<div>Mike=C2=A0<br></div></div></div>

--001a11402dd030a83e0568779036--

--===============0705862010==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============0705862010==--
