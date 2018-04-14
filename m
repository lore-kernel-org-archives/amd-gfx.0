From: =?UTF-8?Q?Br=C3=A1ulio_Bhavamitra?= <brauliobo-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Which branch to test latest support for Raven Ridge?
Date: Sat, 14 Apr 2018 01:05:58 +0000
Message-ID: <CAJri6_vg10W2vnz4Ge0NDNe+8xBUWh2c3MFoHQbpZfzmX4PWuA@mail.gmail.com>
References: <CAJri6_tTnk6Q0VCFRR-4GFw+3QVo9iyXpFtQS6uLLcXgPNEeGw@mail.gmail.com>
 <CAJri6_tvPciPBs9JOJ70habzc-RMsnA4Sms3LpsZwR7p=HThvA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1571423400=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <CAJri6_tvPciPBs9JOJ70habzc-RMsnA4Sms3LpsZwR7p=HThvA-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
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

--===============1571423400==
Content-Type: multipart/alternative; boundary="000000000000168bf80569c49821"

--000000000000168bf80569c49821
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi all,

I've been testing and mitigating the Raven Ridge crashes. I've just
compiled the kernel https://cgit.freedesktop.org/~agd5f/linux/ at branch
drm-next-4.18-wip to see if it would have the necessary fix for video
hangs/freezes. Unfortunetely, it still crashes in the same situations.

Which branch should I compile for the latest Raven Ridge support?

Cheers,
Br=C3=A1ulio

---------- Forwarded message ---------
From: Br=C3=A1ulio Bhavamitra <brauliobo-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Date: Fri, Apr 13, 2018 at 7:24 PM
Subject: Re: Raven Ridge Ryzen 2500U hang reproduced
To: <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>


It ALWAYS crashes on shader15 of
http://www.graphicsfuzz.com/benchmark/android-v1.html.

Also reported at https://bugzilla.redhat.com/show_bug.cgi?id=3D1562530

Using kernel 4.16 with options rcu_nocb=3D0-15 and amdgpu.dpm=3D0

Cheers,
Br=C3=A1ulio


On Mon, Mar 26, 2018 at 8:30 PM Br=C3=A1ulio Bhavamitra <brauliobo-Re5JQEeQqe8@public.gmane.org=
m>
wrote:

> Hi all,
>
> Following the random crashes happenning with many users (e.g.
> https://www.phoronix.com/scan.php?page=3Dnews_item&px=3DRaven-Ridge-March=
-Update),
> not only on Linux but also Windows, I've been struggling to reproduce and
> generate any error log.
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
>

--000000000000168bf80569c49821
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi all,<div><br></div><div>I&#39;ve been testing and mitig=
ating the Raven Ridge crashes. I&#39;ve just compiled the kernel=C2=A0<a hr=
ef=3D"https://cgit.freedesktop.org/~agd5f/linux/">https://cgit.freedesktop.=
org/~agd5f/linux/</a>=C2=A0at=C2=A0branch drm-next-4.18-wip to see if it wo=
uld have the necessary fix for video hangs/freezes. Unfortunetely, it still=
 crashes in the same situations.</div><div><br></div><div>Which branch shou=
ld I compile for the latest Raven Ridge support?<br><br>Cheers,</div><div>B=
r=C3=A1ulio</div><div><br><div class=3D"gmail_quote"><div dir=3D"ltr">-----=
----- Forwarded message ---------<br>From: Br=C3=A1ulio Bhavamitra &lt;<a h=
ref=3D"mailto:brauliobo-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org">brauliobo-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org</a>&gt;<br>Date: Fri=
, Apr 13, 2018 at 7:24 PM<br>Subject: Re: Raven Ridge Ryzen 2500U hang repr=
oduced<br>To:  &lt;<a href=3D"mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org">amd-gfx=
@lists.freedesktop.org</a>&gt;<br></div><br><br><div dir=3D"ltr">It ALWAYS =
crashes on shader15 of <a href=3D"http://www.graphicsfuzz.com/benchmark/and=
roid-v1.html" target=3D"_blank">http://www.graphicsfuzz.com/benchmark/andro=
id-v1.html</a>.<div><br></div><div>Also reported at=C2=A0<a href=3D"https:/=
/bugzilla.redhat.com/show_bug.cgi?id=3D1562530" target=3D"_blank">https://b=
ugzilla.redhat.com/show_bug.cgi?id=3D1562530</a></div><div><br></div><div>U=
sing kernel 4.16 with options rcu_nocb=3D0-15 and amdgpu.dpm=3D0</div><div>=
<br></div><div>Cheers,</div><div>Br=C3=A1ulio</div></div><div dir=3D"ltr"><=
div><br><br><div class=3D"gmail_quote"><div dir=3D"ltr">On Mon, Mar 26, 201=
8 at 8:30 PM Br=C3=A1ulio Bhavamitra &lt;<a href=3D"mailto:brauliobo@gmail.=
com" target=3D"_blank">brauliobo-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org</a>&gt; wrote:<br></div><blockqu=
ote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc s=
olid;padding-left:1ex"><div dir=3D"ltr">Hi all,<div><br></div><div>Followin=
g the random crashes happenning with many users (e.g.=C2=A0<a href=3D"https=
://www.phoronix.com/scan.php?page=3Dnews_item&amp;px=3DRaven-Ridge-March-Up=
date" target=3D"_blank">https://www.phoronix.com/scan.php?page=3Dnews_item&=
amp;px=3DRaven-Ridge-March-Update</a>), not only on Linux but also Windows,=
 I&#39;ve been struggling to reproduce and generate any error log.</div><di=
v><br></div><div>After discovering that the error only happenned with KDE a=
nd games (at least for me, see=C2=A0<a href=3D"https://bugs.kde.org/show_bu=
g.cgi?id=3D392378" target=3D"_blank">https://bugs.kde.org/show_bug.cgi?id=
=3D392378</a>), I could reproduce after a failing suspend.</div><div><br></=
div><div>The crash most of the times allows the mouse to keep moving, but a=
nything else works. Except for this time the keyboard worked so I could swi=
tch the tty and save the dmesg messages. After this I had to force reboot a=
s it got stuck trying to kill the lightdm service (gpu hanged?).</div><div>=
<br></div><div>The errors are, see attached the full dmesg:</div><div><div>=
[ 2899.525650] amdgpu 0000:03:00.0: couldn&#39;t schedule ib on ring &lt;sd=
ma0&gt;</div><div>[ 2899.525769] [drm:amdgpu_job_run [amdgpu]] *ERROR* Erro=
r scheduling IBs (-22)</div><div>[ 2909.125047] [drm:amdgpu_job_timedout [a=
mdgpu]] *ERROR* ring gfx timeout, last signaled seq=3D174624, last emitted =
seq=3D174627</div><div>[ 2909.125060] [drm] IP block:psp is hung!</div><div=
>[ 2909.125063] [drm] GPU recovery disabled.</div><div>[ 2914.756931] [drm:=
amdgpu_cs_ioctl [amdgpu]] *ERROR* amdgpu_cs_list_validate(validated) failed=
.</div><div>[ 2914.756997] [drm:amdgpu_cs_ioctl [amdgpu]] *ERROR* Failed to=
 process the buffer list -16!</div><div>[ 2914.997372] amdgpu 0000:03:00.0:=
 couldn&#39;t schedule ib on ring &lt;sdma0&gt;</div><div>[ 2914.997498] [d=
rm:amdgpu_job_run [amdgpu]] *ERROR* Error scheduling IBs (-22)</div><div>[ =
2930.117275] [drm:amdgpu_cs_ioctl [amdgpu]] *ERROR* amdgpu_cs_list_validate=
(validated) failed.</div><div>[ 2930.117405] [drm:amdgpu_cs_ioctl [amdgpu]]=
 *ERROR* Failed to process the buffer list -16!</div><div>[ 2930.152015] [d=
rm:amdgpu_fill_buffer [amdgpu]] *ERROR* Trying to clear memory with ring tu=
rned off.</div><div>[ 2930.157940] [drm:amdgpu_fill_buffer [amdgpu]] *ERROR=
* Trying to clear memory with ring turned off.</div><div>[ 2930.180535] [dr=
m:amdgpu_fill_buffer [amdgpu]] *ERROR* Trying to clear memory with ring tur=
ned off.</div><div>[ 2933.781692] IPv6: ADDRCONF(NETDEV_CHANGE): wlp2s0: li=
nk becomes ready</div><div>[ 2945.477205] [drm:amdgpu_cs_ioctl [amdgpu]] *E=
RROR* amdgpu_cs_list_validate(validated) failed.</div><div>[ 2945.477348] [=
drm:amdgpu_cs_ioctl [amdgpu]] *ERROR* Failed to process the buffer list -16=
!</div></div><div><br></div><div>System details:</div><div>HP Envy x360 Ryz=
en 2500U</div><div>ArchLinux, kernel 4.16rc6 and 4.15.12</div><div><br></di=
v><div>Cheers,</div><div>br=C3=A1ulio</div></div></blockquote></div></div><=
/div></div></div></div>

--000000000000168bf80569c49821--

--===============1571423400==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============1571423400==--
