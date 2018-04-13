From: =?UTF-8?Q?Br=C3=A1ulio_Bhavamitra?= <brauliobo-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: Raven Ridge Ryzen 2500U hang reproduced
Date: Fri, 13 Apr 2018 22:24:23 +0000
Message-ID: <CAJri6_tvPciPBs9JOJ70habzc-RMsnA4Sms3LpsZwR7p=HThvA@mail.gmail.com>
References: <CAJri6_tTnk6Q0VCFRR-4GFw+3QVo9iyXpFtQS6uLLcXgPNEeGw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1379699912=="
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
To: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org

--===============1379699912==
Content-Type: multipart/alternative; boundary="0000000000003e31540569c256a9"

--0000000000003e31540569c256a9
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

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

--0000000000003e31540569c256a9
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">It ALWAYS crashes on shader15 of <a href=3D"http://www.gra=
phicsfuzz.com/benchmark/android-v1.html">http://www.graphicsfuzz.com/benchm=
ark/android-v1.html</a>.<div><br></div><div>Also reported at=C2=A0<a href=
=3D"https://bugzilla.redhat.com/show_bug.cgi?id=3D1562530">https://bugzilla=
.redhat.com/show_bug.cgi?id=3D1562530</a></div><div><br></div><div>Using ke=
rnel 4.16 with options rcu_nocb=3D0-15 and amdgpu.dpm=3D0</div><div><br></d=
iv><div>Cheers,</div><div>Br=C3=A1ulio<br><br><div class=3D"gmail_quote"><d=
iv dir=3D"ltr">On Mon, Mar 26, 2018 at 8:30 PM Br=C3=A1ulio Bhavamitra &lt;=
<a href=3D"mailto:brauliobo-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org">brauliobo-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org</a>&gt; wrote:<b=
r></div><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border=
-left:1px #ccc solid;padding-left:1ex"><div dir=3D"ltr">Hi all,<div><br></d=
iv><div>Following the random crashes happenning with many users (e.g.=C2=A0=
<a href=3D"https://www.phoronix.com/scan.php?page=3Dnews_item&amp;px=3DRave=
n-Ridge-March-Update" target=3D"_blank">https://www.phoronix.com/scan.php?p=
age=3Dnews_item&amp;px=3DRaven-Ridge-March-Update</a>), not only on Linux b=
ut also Windows, I&#39;ve been struggling to reproduce and generate any err=
or log.</div><div><br></div><div>After discovering that the error only happ=
enned with KDE and games (at least for me, see=C2=A0<a href=3D"https://bugs=
.kde.org/show_bug.cgi?id=3D392378" target=3D"_blank">https://bugs.kde.org/s=
how_bug.cgi?id=3D392378</a>), I could reproduce after a failing suspend.</d=
iv><div><br></div><div>The crash most of the times allows the mouse to keep=
 moving, but anything else works. Except for this time the keyboard worked =
so I could switch the tty and save the dmesg messages. After this I had to =
force reboot as it got stuck trying to kill the lightdm service (gpu hanged=
?).</div><div><br></div><div>The errors are, see attached the full dmesg:</=
div><div><div>[ 2899.525650] amdgpu 0000:03:00.0: couldn&#39;t schedule ib =
on ring &lt;sdma0&gt;</div><div>[ 2899.525769] [drm:amdgpu_job_run [amdgpu]=
] *ERROR* Error scheduling IBs (-22)</div><div>[ 2909.125047] [drm:amdgpu_j=
ob_timedout [amdgpu]] *ERROR* ring gfx timeout, last signaled seq=3D174624,=
 last emitted seq=3D174627</div><div>[ 2909.125060] [drm] IP block:psp is h=
ung!</div><div>[ 2909.125063] [drm] GPU recovery disabled.</div><div>[ 2914=
.756931] [drm:amdgpu_cs_ioctl [amdgpu]] *ERROR* amdgpu_cs_list_validate(val=
idated) failed.</div><div>[ 2914.756997] [drm:amdgpu_cs_ioctl [amdgpu]] *ER=
ROR* Failed to process the buffer list -16!</div><div>[ 2914.997372] amdgpu=
 0000:03:00.0: couldn&#39;t schedule ib on ring &lt;sdma0&gt;</div><div>[ 2=
914.997498] [drm:amdgpu_job_run [amdgpu]] *ERROR* Error scheduling IBs (-22=
)</div><div>[ 2930.117275] [drm:amdgpu_cs_ioctl [amdgpu]] *ERROR* amdgpu_cs=
_list_validate(validated) failed.</div><div>[ 2930.117405] [drm:amdgpu_cs_i=
octl [amdgpu]] *ERROR* Failed to process the buffer list -16!</div><div>[ 2=
930.152015] [drm:amdgpu_fill_buffer [amdgpu]] *ERROR* Trying to clear memor=
y with ring turned off.</div><div>[ 2930.157940] [drm:amdgpu_fill_buffer [a=
mdgpu]] *ERROR* Trying to clear memory with ring turned off.</div><div>[ 29=
30.180535] [drm:amdgpu_fill_buffer [amdgpu]] *ERROR* Trying to clear memory=
 with ring turned off.</div><div>[ 2933.781692] IPv6: ADDRCONF(NETDEV_CHANG=
E): wlp2s0: link becomes ready</div><div>[ 2945.477205] [drm:amdgpu_cs_ioct=
l [amdgpu]] *ERROR* amdgpu_cs_list_validate(validated) failed.</div><div>[ =
2945.477348] [drm:amdgpu_cs_ioctl [amdgpu]] *ERROR* Failed to process the b=
uffer list -16!</div></div><div><br></div><div>System details:</div><div>HP=
 Envy x360 Ryzen 2500U</div><div>ArchLinux, kernel 4.16rc6 and 4.15.12</div=
><div><br></div><div>Cheers,</div><div>br=C3=A1ulio</div></div></blockquote=
></div></div></div>

--0000000000003e31540569c256a9--

--===============1379699912==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============1379699912==--
