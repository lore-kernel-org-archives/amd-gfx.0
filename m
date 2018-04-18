From: =?UTF-8?Q?Br=C3=A1ulio_Bhavamitra?= <brauliobo-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: Raven Ridge Ryzen 2500U hang reproduced
Date: Wed, 18 Apr 2018 20:37:24 +0000
Message-ID: <CAJri6_uy+aXe7+X5qJd2GUEYmivLuQ9q+rV5oqd1G4XGciGnrQ@mail.gmail.com>
References: <CAJri6_tTnk6Q0VCFRR-4GFw+3QVo9iyXpFtQS6uLLcXgPNEeGw@mail.gmail.com>
 <CAJri6_tvPciPBs9JOJ70habzc-RMsnA4Sms3LpsZwR7p=HThvA@mail.gmail.com>
 <bb90a01d-79ec-cbb7-532a-491c0ea13086@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1604899581=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <bb90a01d-79ec-cbb7-532a-491c0ea13086-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
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
To: =?UTF-8?Q?Nicolai_H=C3=A4hnle?= <nhaehnle-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org

--===============1604899581==
Content-Type: multipart/alternative; boundary="000000000000cd9bb1056a256c45"

--000000000000cd9bb1056a256c45
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Nicolai,

It makes sense.

The easiest way to reproduce the real freeze is to:
- Run vblank_mode=3D0 glxgears
- Open https://hangouts.google.com/start
- Activate KDE compositing

It will freeze within a few minutes.

Cheers,
Br=C3=A1ulio

On Mon, Apr 16, 2018 at 4:44 AM Nicolai H=C3=A4hnle <nhaehnle-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wr=
ote:

> On 14.04.2018 00:24, Br=C3=A1ulio Bhavamitra wrote:
> > It ALWAYS crashes on shader15 of
> > http://www.graphicsfuzz.com/benchmark/android-v1.html.
>
> This is very likely an unrelated issue to any kind of desktop hang
> you're seeing. The graphics fuzz shaders are the result of fuzzing to
> intentionally generate unusual control flow structures which are likely
> to trigger shader compiler bugs. Typical desktop workloads don't have
> such shaders, so any generic desktop hang you're seeing is almost
> certainly unrelated.
>
> Cheers,
> Nicolai
>
>
> >
> > Also reported at https://bugzilla.redhat.com/show_bug.cgi?id=3D1562530
> >
> > Using kernel 4.16 with options rcu_nocb=3D0-15 and amdgpu.dpm=3D0
> >
> > Cheers,
> > Br=C3=A1ulio
> >
> > On Mon, Mar 26, 2018 at 8:30 PM Br=C3=A1ulio Bhavamitra <brauliobo@gmai=
l.com
> > <mailto:brauliobo-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>> wrote:
> >
> >     Hi all,
> >
> >     Following the random crashes happenning with many users (e.g.
> >
> https://www.phoronix.com/scan.php?page=3Dnews_item&px=3DRaven-Ridge-March=
-Update
> ),
> >     not only on Linux but also Windows, I've been struggling to
> >     reproduce and generate any error log.
> >
> >     After discovering that the error only happenned with KDE and games
> >     (at least for me, see https://bugs.kde.org/show_bug.cgi?id=3D392378=
),
> >     I could reproduce after a failing suspend.
> >
> >     The crash most of the times allows the mouse to keep moving, but
> >     anything else works. Except for this time the keyboard worked so I
> >     could switch the tty and save the dmesg messages. After this I had
> >     to force reboot as it got stuck trying to kill the lightdm service
> >     (gpu hanged?).
> >
> >     The errors are, see attached the full dmesg:
> >     [ 2899.525650] amdgpu 0000:03:00.0: couldn't schedule ib on ring
> <sdma0>
> >     [ 2899.525769] [drm:amdgpu_job_run [amdgpu]] *ERROR* Error
> >     scheduling IBs (-22)
> >     [ 2909.125047] [drm:amdgpu_job_timedout [amdgpu]] *ERROR* ring gfx
> >     timeout, last signaled seq=3D174624, last emitted seq=3D174627
> >     [ 2909.125060] [drm] IP block:psp is hung!
> >     [ 2909.125063] [drm] GPU recovery disabled.
> >     [ 2914.756931] [drm:amdgpu_cs_ioctl [amdgpu]] *ERROR*
> >     amdgpu_cs_list_validate(validated) failed.
> >     [ 2914.756997] [drm:amdgpu_cs_ioctl [amdgpu]] *ERROR* Failed to
> >     process the buffer list -16!
> >     [ 2914.997372] amdgpu 0000:03:00.0: couldn't schedule ib on ring
> <sdma0>
> >     [ 2914.997498] [drm:amdgpu_job_run [amdgpu]] *ERROR* Error
> >     scheduling IBs (-22)
> >     [ 2930.117275] [drm:amdgpu_cs_ioctl [amdgpu]] *ERROR*
> >     amdgpu_cs_list_validate(validated) failed.
> >     [ 2930.117405] [drm:amdgpu_cs_ioctl [amdgpu]] *ERROR* Failed to
> >     process the buffer list -16!
> >     [ 2930.152015] [drm:amdgpu_fill_buffer [amdgpu]] *ERROR* Trying to
> >     clear memory with ring turned off.
> >     [ 2930.157940] [drm:amdgpu_fill_buffer [amdgpu]] *ERROR* Trying to
> >     clear memory with ring turned off.
> >     [ 2930.180535] [drm:amdgpu_fill_buffer [amdgpu]] *ERROR* Trying to
> >     clear memory with ring turned off.
> >     [ 2933.781692] IPv6: ADDRCONF(NETDEV_CHANGE): wlp2s0: link becomes
> ready
> >     [ 2945.477205] [drm:amdgpu_cs_ioctl [amdgpu]] *ERROR*
> >     amdgpu_cs_list_validate(validated) failed.
> >     [ 2945.477348] [drm:amdgpu_cs_ioctl [amdgpu]] *ERROR* Failed to
> >     process the buffer list -16!
> >
> >     System details:
> >     HP Envy x360 Ryzen 2500U
> >     ArchLinux, kernel 4.16rc6 and 4.15.12
> >
> >     Cheers,
> >     br=C3=A1ulio
> >
> >
> >
> > _______________________________________________
> > amd-gfx mailing list
> > amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
> > https://lists.freedesktop.org/mailman/listinfo/amd-gfx
> >
>
>
> --
> Lerne, wie die Welt wirklich ist,
> Aber vergiss niemals, wie sie sein sollte.
> _______________________________________________
> amd-gfx mailing list
> amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
>

--000000000000cd9bb1056a256c45
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi Nicolai,<div><br></div><div>It makes sense.</div><div><=
br></div><div>The easiest way to reproduce the real freeze is to:<br>- Run =
vblank_mode=3D0 glxgears<br>- Open <a href=3D"https://hangouts.google.com/s=
tart">https://hangouts.google.com/start</a><br>- Activate KDE compositing<b=
r><div><br></div><div>It will freeze within a few minutes.</div></div><div>=
<br></div><div>Cheers,</div><div>Br=C3=A1ulio</div></div><br><div class=3D"=
gmail_quote"><div dir=3D"ltr">On Mon, Apr 16, 2018 at 4:44 AM Nicolai H=C3=
=A4hnle &lt;<a href=3D"mailto:nhaehnle-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org">nhaehnle-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org</a>&gt=
; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .=
8ex;border-left:1px #ccc solid;padding-left:1ex">On 14.04.2018 00:24, Br=C3=
=A1ulio Bhavamitra wrote:<br>
&gt; It ALWAYS crashes on shader15 of <br>
&gt; <a href=3D"http://www.graphicsfuzz.com/benchmark/android-v1.html" rel=
=3D"noreferrer" target=3D"_blank">http://www.graphicsfuzz.com/benchmark/and=
roid-v1.html</a>.<br>
<br>
This is very likely an unrelated issue to any kind of desktop hang <br>
you&#39;re seeing. The graphics fuzz shaders are the result of fuzzing to <=
br>
intentionally generate unusual control flow structures which are likely <br=
>
to trigger shader compiler bugs. Typical desktop workloads don&#39;t have <=
br>
such shaders, so any generic desktop hang you&#39;re seeing is almost <br>
certainly unrelated.<br>
<br>
Cheers,<br>
Nicolai<br>
<br>
<br>
&gt; <br>
&gt; Also reported at <a href=3D"https://bugzilla.redhat.com/show_bug.cgi?i=
d=3D1562530" rel=3D"noreferrer" target=3D"_blank">https://bugzilla.redhat.c=
om/show_bug.cgi?id=3D1562530</a><br>
&gt; <br>
&gt; Using kernel 4.16 with options rcu_nocb=3D0-15 and amdgpu.dpm=3D0<br>
&gt; <br>
&gt; Cheers,<br>
&gt; Br=C3=A1ulio<br>
&gt; <br>
&gt; On Mon, Mar 26, 2018 at 8:30 PM Br=C3=A1ulio Bhavamitra &lt;<a href=3D=
"mailto:brauliobo-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org" target=3D"_blank">brauliobo-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org</a> <br>
&gt; &lt;mailto:<a href=3D"mailto:brauliobo-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org" target=3D"_blank">br=
auliobo-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org</a>&gt;&gt; wrote:<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0Hi all,<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0Following the random crashes happenning with many u=
sers (e.g.<br>
&gt;=C2=A0 =C2=A0 =C2=A0<a href=3D"https://www.phoronix.com/scan.php?page=
=3Dnews_item&amp;px=3DRaven-Ridge-March-Update" rel=3D"noreferrer" target=
=3D"_blank">https://www.phoronix.com/scan.php?page=3Dnews_item&amp;px=3DRav=
en-Ridge-March-Update</a>),<br>
&gt;=C2=A0 =C2=A0 =C2=A0not only on Linux but also Windows, I&#39;ve been s=
truggling to<br>
&gt;=C2=A0 =C2=A0 =C2=A0reproduce and generate any error log.<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0After discovering that the error only happenned wit=
h KDE and games<br>
&gt;=C2=A0 =C2=A0 =C2=A0(at least for me, see <a href=3D"https://bugs.kde.o=
rg/show_bug.cgi?id=3D392378" rel=3D"noreferrer" target=3D"_blank">https://b=
ugs.kde.org/show_bug.cgi?id=3D392378</a>),<br>
&gt;=C2=A0 =C2=A0 =C2=A0I could reproduce after a failing suspend.<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0The crash most of the times allows the mouse to kee=
p moving, but<br>
&gt;=C2=A0 =C2=A0 =C2=A0anything else works. Except for this time the keybo=
ard worked so I<br>
&gt;=C2=A0 =C2=A0 =C2=A0could switch the tty and save the dmesg messages. A=
fter this I had<br>
&gt;=C2=A0 =C2=A0 =C2=A0to force reboot as it got stuck trying to kill the =
lightdm service<br>
&gt;=C2=A0 =C2=A0 =C2=A0(gpu hanged?).<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0The errors are, see attached the full dmesg:<br>
&gt;=C2=A0 =C2=A0 =C2=A0[ 2899.525650] amdgpu 0000:03:00.0: couldn&#39;t sc=
hedule ib on ring &lt;sdma0&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0[ 2899.525769] [drm:amdgpu_job_run [amdgpu]] *ERROR=
* Error<br>
&gt;=C2=A0 =C2=A0 =C2=A0scheduling IBs (-22)<br>
&gt;=C2=A0 =C2=A0 =C2=A0[ 2909.125047] [drm:amdgpu_job_timedout [amdgpu]] *=
ERROR* ring gfx<br>
&gt;=C2=A0 =C2=A0 =C2=A0timeout, last signaled seq=3D174624, last emitted s=
eq=3D174627<br>
&gt;=C2=A0 =C2=A0 =C2=A0[ 2909.125060] [drm] IP block:psp is hung!<br>
&gt;=C2=A0 =C2=A0 =C2=A0[ 2909.125063] [drm] GPU recovery disabled.<br>
&gt;=C2=A0 =C2=A0 =C2=A0[ 2914.756931] [drm:amdgpu_cs_ioctl [amdgpu]] *ERRO=
R*<br>
&gt;=C2=A0 =C2=A0 =C2=A0amdgpu_cs_list_validate(validated) failed.<br>
&gt;=C2=A0 =C2=A0 =C2=A0[ 2914.756997] [drm:amdgpu_cs_ioctl [amdgpu]] *ERRO=
R* Failed to<br>
&gt;=C2=A0 =C2=A0 =C2=A0process the buffer list -16!<br>
&gt;=C2=A0 =C2=A0 =C2=A0[ 2914.997372] amdgpu 0000:03:00.0: couldn&#39;t sc=
hedule ib on ring &lt;sdma0&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0[ 2914.997498] [drm:amdgpu_job_run [amdgpu]] *ERROR=
* Error<br>
&gt;=C2=A0 =C2=A0 =C2=A0scheduling IBs (-22)<br>
&gt;=C2=A0 =C2=A0 =C2=A0[ 2930.117275] [drm:amdgpu_cs_ioctl [amdgpu]] *ERRO=
R*<br>
&gt;=C2=A0 =C2=A0 =C2=A0amdgpu_cs_list_validate(validated) failed.<br>
&gt;=C2=A0 =C2=A0 =C2=A0[ 2930.117405] [drm:amdgpu_cs_ioctl [amdgpu]] *ERRO=
R* Failed to<br>
&gt;=C2=A0 =C2=A0 =C2=A0process the buffer list -16!<br>
&gt;=C2=A0 =C2=A0 =C2=A0[ 2930.152015] [drm:amdgpu_fill_buffer [amdgpu]] *E=
RROR* Trying to<br>
&gt;=C2=A0 =C2=A0 =C2=A0clear memory with ring turned off.<br>
&gt;=C2=A0 =C2=A0 =C2=A0[ 2930.157940] [drm:amdgpu_fill_buffer [amdgpu]] *E=
RROR* Trying to<br>
&gt;=C2=A0 =C2=A0 =C2=A0clear memory with ring turned off.<br>
&gt;=C2=A0 =C2=A0 =C2=A0[ 2930.180535] [drm:amdgpu_fill_buffer [amdgpu]] *E=
RROR* Trying to<br>
&gt;=C2=A0 =C2=A0 =C2=A0clear memory with ring turned off.<br>
&gt;=C2=A0 =C2=A0 =C2=A0[ 2933.781692] IPv6: ADDRCONF(NETDEV_CHANGE): wlp2s=
0: link becomes ready<br>
&gt;=C2=A0 =C2=A0 =C2=A0[ 2945.477205] [drm:amdgpu_cs_ioctl [amdgpu]] *ERRO=
R*<br>
&gt;=C2=A0 =C2=A0 =C2=A0amdgpu_cs_list_validate(validated) failed.<br>
&gt;=C2=A0 =C2=A0 =C2=A0[ 2945.477348] [drm:amdgpu_cs_ioctl [amdgpu]] *ERRO=
R* Failed to<br>
&gt;=C2=A0 =C2=A0 =C2=A0process the buffer list -16!<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0System details:<br>
&gt;=C2=A0 =C2=A0 =C2=A0HP Envy x360 Ryzen 2500U<br>
&gt;=C2=A0 =C2=A0 =C2=A0ArchLinux, kernel 4.16rc6 and 4.15.12<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0Cheers,<br>
&gt;=C2=A0 =C2=A0 =C2=A0br=C3=A1ulio<br>
&gt; <br>
&gt; <br>
&gt; <br>
&gt; _______________________________________________<br>
&gt; amd-gfx mailing list<br>
&gt; <a href=3D"mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" target=3D"_blank">amd=
-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org</a><br>
&gt; <a href=3D"https://lists.freedesktop.org/mailman/listinfo/amd-gfx" rel=
=3D"noreferrer" target=3D"_blank">https://lists.freedesktop.org/mailman/lis=
tinfo/amd-gfx</a><br>
&gt; <br>
<br>
<br>
-- <br>
Lerne, wie die Welt wirklich ist,<br>
Aber vergiss niemals, wie sie sein sollte.<br>
_______________________________________________<br>
amd-gfx mailing list<br>
<a href=3D"mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" target=3D"_blank">amd-gfx@=
lists.freedesktop.org</a><br>
<a href=3D"https://lists.freedesktop.org/mailman/listinfo/amd-gfx" rel=3D"n=
oreferrer" target=3D"_blank">https://lists.freedesktop.org/mailman/listinfo=
/amd-gfx</a><br>
</blockquote></div>

--000000000000cd9bb1056a256c45--

--===============1604899581==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============1604899581==--
