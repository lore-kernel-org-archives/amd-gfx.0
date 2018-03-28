From: =?UTF-8?Q?Br=C3=A1ulio_Bhavamitra?= <brauliobo-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: Raven Ridge Ryzen 2500U hang reproduced
Date: Wed, 28 Mar 2018 12:10:10 +0000
Message-ID: <CAJri6_uMm082CKap-qiWAcR_sYm5CmhXjeKDm-xKk4CSLOVz=g@mail.gmail.com>
References: <CAJri6_tTnk6Q0VCFRR-4GFw+3QVo9iyXpFtQS6uLLcXgPNEeGw@mail.gmail.com>
 <CAHbf0-GyHStsECye3yJnGjTZCYcupEyXdeuRY0Vfcs+iEgRYPA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1844165293=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <CAHbf0-GyHStsECye3yJnGjTZCYcupEyXdeuRY0Vfcs+iEgRYPA-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
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
To: Mike Lothian <mike-4+n8WJKc9ve9FHfhHBbuYA@public.gmane.org>
Cc: amd-gfx list <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

--===============1844165293==
Content-Type: multipart/alternative; boundary="0000000000002c622b056877e4f4"

--0000000000002c622b056877e4f4
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 28, 2018 at 8:46 AM Mike Lothian <mike-4+n8WJKc9ve9FHfhHBbuYA@public.gmane.org> wrote:

> On Tue, 27 Mar 2018, 00:30 Br=C3=A1ulio Bhavamitra, <brauliobo-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> wrote:
>
>> Hi all,
>>
>> Following the random crashes happenning with many users (e.g.
>> https://www.phoronix.com/scan.php?page=3Dnews_item&px=3DRaven-Ridge-Marc=
h-Update),
>> not only on Linux but also Windows, I've been struggling to reproduce an=
d
>> generate any error log.
>>
>> After discovering that the error only happenned with KDE and games (at
>> least for me, see https://bugs.kde.org/show_bug.cgi?id=3D392378), I coul=
d
>> reproduce after a failing suspend.
>>
>> The crash most of the times allows the mouse to keep moving, but anythin=
g
>> else works. Except for this time the keyboard worked so I could switch t=
he
>> tty and save the dmesg messages. After this I had to force reboot as it =
got
>> stuck trying to kill the lightdm service (gpu hanged?).
>>
>> The errors are, see attached the full dmesg:
>> [ 2899.525650] amdgpu 0000:03:00.0: couldn't schedule ib on ring <sdma0>
>> [ 2899.525769] [drm:amdgpu_job_run [amdgpu]] *ERROR* Error scheduling IB=
s
>> (-22)
>> [ 2909.125047] [drm:amdgpu_job_timedout [amdgpu]] *ERROR* ring gfx
>> timeout, last signaled seq=3D174624, last emitted seq=3D174627
>> [ 2909.125060] [drm] IP block:psp is hung!
>> [ 2909.125063] [drm] GPU recovery disabled.
>> [ 2914.756931] [drm:amdgpu_cs_ioctl [amdgpu]] *ERROR*
>> amdgpu_cs_list_validate(validated) failed.
>> [ 2914.756997] [drm:amdgpu_cs_ioctl [amdgpu]] *ERROR* Failed to process
>> the buffer list -16!
>> [ 2914.997372] amdgpu 0000:03:00.0: couldn't schedule ib on ring <sdma0>
>> [ 2914.997498] [drm:amdgpu_job_run [amdgpu]] *ERROR* Error scheduling IB=
s
>> (-22)
>> [ 2930.117275] [drm:amdgpu_cs_ioctl [amdgpu]] *ERROR*
>> amdgpu_cs_list_validate(validated) failed.
>> [ 2930.117405] [drm:amdgpu_cs_ioctl [amdgpu]] *ERROR* Failed to process
>> the buffer list -16!
>> [ 2930.152015] [drm:amdgpu_fill_buffer [amdgpu]] *ERROR* Trying to clear
>> memory with ring turned off.
>> [ 2930.157940] [drm:amdgpu_fill_buffer [amdgpu]] *ERROR* Trying to clear
>> memory with ring turned off.
>> [ 2930.180535] [drm:amdgpu_fill_buffer [amdgpu]] *ERROR* Trying to clear
>> memory with ring turned off.
>> [ 2933.781692] IPv6: ADDRCONF(NETDEV_CHANGE): wlp2s0: link becomes ready
>> [ 2945.477205] [drm:amdgpu_cs_ioctl [amdgpu]] *ERROR*
>> amdgpu_cs_list_validate(validated) failed.
>> [ 2945.477348] [drm:amdgpu_cs_ioctl [amdgpu]] *ERROR* Failed to process
>> the buffer list -16!
>>
>> System details:
>> HP Envy x360 Ryzen 2500U
>> ArchLinux, kernel 4.16rc6 and 4.15.12
>>
>> Cheers,
>> br=C3=A1ulio
>>
> _______________________________________________
>> amd-gfx mailing list
>> amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
>> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
>
>
> Hi
>
> I think I've seen that issue in KDE too, where the mouse moves but nothin=
g
> else works. I found that switching VT's and back again fixes things for m=
e
>
> The weird thing is I'm seeing this on i965 (amdgpu is used for games only
> with PRIME)
>
> What version of X, Qt, KDE Frameworks and Plasma are you using?
>
The stable latest, from archlinux:
https://www.archlinux.org/packages/?sort=3D&q=3Dkde&maintainer=3D&flagged=
=3D

I could reproduce the freeze on XFCE, so it is definetely not KDE specific,

Cheers,
Br=C3=A1ulio


> Cheers
>
> Mike
>

--0000000000002c622b056877e4f4
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><br><br><div class=3D"gmail_quote"><div dir=3D"ltr">On Wed=
, Mar 28, 2018 at 8:46 AM Mike Lothian &lt;<a href=3D"mailto:mike@fireburn.=
co.uk">mike-4+n8WJKc9ve9FHfhHBbuYA@public.gmane.org</a>&gt; wrote:<br></div><blockquote class=3D"gma=
il_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-lef=
t:1ex"><div dir=3D"ltr"><div class=3D"gmail_quote"><div dir=3D"ltr">On Tue,=
 27 Mar 2018, 00:30 Br=C3=A1ulio Bhavamitra, &lt;<a href=3D"mailto:brauliob=
o@gmail.com" target=3D"_blank">brauliobo-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org</a>&gt; wrote:<br></div>=
</div></div><div dir=3D"ltr"><div class=3D"gmail_quote"><blockquote class=
=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padd=
ing-left:1ex"><div dir=3D"ltr">Hi all,<div><br></div><div>Following the ran=
dom crashes happenning with many users (e.g.=C2=A0<a href=3D"https://www.ph=
oronix.com/scan.php?page=3Dnews_item&amp;px=3DRaven-Ridge-March-Update" tar=
get=3D"_blank">https://www.phoronix.com/scan.php?page=3Dnews_item&amp;px=3D=
Raven-Ridge-March-Update</a>), not only on Linux but also Windows, I&#39;ve=
 been struggling to reproduce and generate any error log.</div><div><br></d=
iv><div>After discovering that the error only happenned with KDE and games =
(at least for me, see=C2=A0<a href=3D"https://bugs.kde.org/show_bug.cgi?id=
=3D392378" target=3D"_blank">https://bugs.kde.org/show_bug.cgi?id=3D392378<=
/a>), I could reproduce after a failing suspend.</div><div><br></div><div>T=
he crash most of the times allows the mouse to keep moving, but anything el=
se works. Except for this time the keyboard worked so I could switch the tt=
y and save the dmesg messages. After this I had to force reboot as it got s=
tuck trying to kill the lightdm service (gpu hanged?).</div><div><br></div>=
<div>The errors are, see attached the full dmesg:</div><div><div>[ 2899.525=
650] amdgpu 0000:03:00.0: couldn&#39;t schedule ib on ring &lt;sdma0&gt;</d=
iv><div>[ 2899.525769] [drm:amdgpu_job_run [amdgpu]] *ERROR* Error scheduli=
ng IBs (-22)</div><div>[ 2909.125047] [drm:amdgpu_job_timedout [amdgpu]] *E=
RROR* ring gfx timeout, last signaled seq=3D174624, last emitted seq=3D1746=
27</div><div>[ 2909.125060] [drm] IP block:psp is hung!</div><div>[ 2909.12=
5063] [drm] GPU recovery disabled.</div><div>[ 2914.756931] [drm:amdgpu_cs_=
ioctl [amdgpu]] *ERROR* amdgpu_cs_list_validate(validated) failed.</div><di=
v>[ 2914.756997] [drm:amdgpu_cs_ioctl [amdgpu]] *ERROR* Failed to process t=
he buffer list -16!</div><div>[ 2914.997372] amdgpu 0000:03:00.0: couldn&#3=
9;t schedule ib on ring &lt;sdma0&gt;</div><div>[ 2914.997498] [drm:amdgpu_=
job_run [amdgpu]] *ERROR* Error scheduling IBs (-22)</div><div>[ 2930.11727=
5] [drm:amdgpu_cs_ioctl [amdgpu]] *ERROR* amdgpu_cs_list_validate(validated=
) failed.</div><div>[ 2930.117405] [drm:amdgpu_cs_ioctl [amdgpu]] *ERROR* F=
ailed to process the buffer list -16!</div><div>[ 2930.152015] [drm:amdgpu_=
fill_buffer [amdgpu]] *ERROR* Trying to clear memory with ring turned off.<=
/div><div>[ 2930.157940] [drm:amdgpu_fill_buffer [amdgpu]] *ERROR* Trying t=
o clear memory with ring turned off.</div><div>[ 2930.180535] [drm:amdgpu_f=
ill_buffer [amdgpu]] *ERROR* Trying to clear memory with ring turned off.</=
div><div>[ 2933.781692] IPv6: ADDRCONF(NETDEV_CHANGE): wlp2s0: link becomes=
 ready</div><div>[ 2945.477205] [drm:amdgpu_cs_ioctl [amdgpu]] *ERROR* amdg=
pu_cs_list_validate(validated) failed.</div><div>[ 2945.477348] [drm:amdgpu=
_cs_ioctl [amdgpu]] *ERROR* Failed to process the buffer list -16!</div></d=
iv><div><br></div><div>System details:</div><div>HP Envy x360 Ryzen 2500U</=
div><div>ArchLinux, kernel 4.16rc6 and 4.15.12</div><div><br></div><div>Che=
ers,</div><div>br=C3=A1ulio</div></div></blockquote></div></div><div dir=3D=
"ltr"><div class=3D"gmail_quote"><blockquote class=3D"gmail_quote" style=3D=
"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">
_______________________________________________<br>
amd-gfx mailing list<br>
<a href=3D"mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" target=3D"_blank">amd-gfx@=
lists.freedesktop.org</a><br>
<a href=3D"https://lists.freedesktop.org/mailman/listinfo/amd-gfx" rel=3D"n=
oreferrer" target=3D"_blank">https://lists.freedesktop.org/mailman/listinfo=
/amd-gfx</a></blockquote></div><div class=3D"gmail_quote"><div><br></div><d=
iv>Hi</div><div><br></div><div>I think I&#39;ve seen that issue in KDE too,=
 where the mouse moves but nothing else works. I found that switching VT&#3=
9;s and back again fixes things for me</div><div><br></div><div>The weird t=
hing is I&#39;m seeing this on i965 (amdgpu is used for games only with PRI=
ME)</div><div><br></div><div>What version of X, Qt, KDE Frameworks and Plas=
ma are you using?</div></div></div></blockquote><div>The stable latest, fro=
m archlinux:=C2=A0<a href=3D"https://www.archlinux.org/packages/?sort=3D&am=
p;q=3Dkde&amp;maintainer=3D&amp;flagged=3D">https://www.archlinux.org/packa=
ges/?sort=3D&amp;q=3Dkde&amp;maintainer=3D&amp;flagged=3D</a></div><div><br=
></div><div>I could reproduce the freeze on XFCE, so it is definetely not K=
DE specific,</div><div><br></div><div>Cheers,</div><div>Br=C3=A1ulio</div><=
div>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8e=
x;border-left:1px #ccc solid;padding-left:1ex"><div dir=3D"ltr"><div class=
=3D"gmail_quote"><div></div><div>Cheers</div></div></div><div dir=3D"ltr"><=
div class=3D"gmail_quote"><div><br></div><div>Mike=C2=A0<br></div></div></d=
iv></blockquote></div></div>

--0000000000002c622b056877e4f4--

--===============1844165293==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============1844165293==--
