From: Bas Vermeulen <bas-MbI5SpmOCPBHdOctNixuYw@public.gmane.org>
Subject: Re: AMD E8860 on PowerPC with u-boot (T2080)
Date: Wed, 21 Feb 2018 10:23:29 +0100
Message-ID: <CAGtoiRhHVUvg-EH9nESXjA6+T78ezQ4Cebn9rCMt09hudSqDsQ@mail.gmail.com>
References: <CAGtoiRjxS7mgQKG_yib9-5tVkD9_yAkp3P8PxYvipy3bFnV9Rg@mail.gmail.com>
 <62565c2f-a57f-9a2b-8277-ca94937bbe0f@daenzer.net>
 <bca60368-969e-ff29-1342-432a48c23ffb@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1220873708=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <bca60368-969e-ff29-1342-432a48c23ffb-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
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
To: christian.koenig-5C7GfCeVMHo@public.gmane.org
Cc: =?UTF-8?Q?Michel_D=C3=A4nzer?= <michel-otUistvHUpPR7s880joybQ@public.gmane.org>, amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org

--===============1220873708==
Content-Type: multipart/alternative; boundary="089e0827e9fcf55dcd0565b57ab1"

--089e0827e9fcf55dcd0565b57ab1
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 21, 2018 at 10:14 AM, Christian K=C3=B6nig <
ckoenig.leichtzumerken-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:

> Am 21.02.2018 um 10:06 schrieb Michel D=C3=A4nzer:
>
>> On 2018-02-21 09:49 AM, Bas Vermeulen wrote:
>>
>>> Hi,
>>>
>>> I am unsure if this is the right place to ask, but it seems relevant.
>>>
>>
> Well this list is certainly the right place to ask :)


That's what I was hoping for :)


>
> I am trying to use an AMD E8860 (SI) board connected to an E6500 PowerPC
>>> board (T2080RDB from NXP).
>>> The T2080RDB does not use a BIOS, and uses u-boot to bootstrap Linux.
>>>
>>> I have the E8860 connected to a PCIe x4 slot with an adapter. The kerne=
l
>>> is a 4.1, with DRM included in the kernel and the radeon as a module.
>>> The radeon driver detects the card, notices the BIOS hasn't posted and
>>> starts things up.
>>> After that, the ring tests get run, and fails on the ring 0 test,
>>> disabling acceleration. The graphics card is (or seems to be) working
>>> apart from that, the driver starts up and sees the connectors on the
>>> board.
>>>
>>> When I compare dmesg on an x86 machine and the PPC machine, I see that
>>> the x86 machine loads a lot more firmware from the kernel (probably the
>>> acceleration parts?).
>>>
>> FWIW, that's probably just a subsequent symptom due to the ring test
>> failure.
>>
>
> Could be, but IIRC we load all the firmware first then initialize things
> and then do the ring tests when we try to start the rings.
>
> BTW: What driver are you using? radeon or amdgpu?


This is a south-island or sea-island chip, so using radeon.


>
> My question is, what do I need to do to correctly initialize the E8860
>>> board on my powerpc machine?
>>>
>> Start by sharing the dmesg output, and maybe also the kernel build
>> configuration file.
>>
>
> Maybe also open a bug report to attach the dmesg, see bugs.freedesktop.or=
g
> .
>

Sure. What project does the radeon driver fall under? I couldn't find the
right category under Mesa, not sure what
to file it under.

Bas Vermeulen

--089e0827e9fcf55dcd0565b57ab1
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_extra"><div class=3D"gmail_quote">On W=
ed, Feb 21, 2018 at 10:14 AM, Christian K=C3=B6nig <span dir=3D"ltr">&lt;<a=
 href=3D"mailto:ckoenig.leichtzumerken-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org" target=3D"_blank">ckoenig=
.leichtzumerken-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org</a>&gt;</span> wrote:<br><blockquote class=3D"gma=
il_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-lef=
t:1ex"><span class=3D"">Am 21.02.2018 um 10:06 schrieb Michel D=C3=A4nzer:<=
br>
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex">
On 2018-02-21 09:49 AM, Bas Vermeulen wrote:<br>
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex">
Hi,<br>
<br>
I am unsure if this is the right place to ask, but it seems relevant.<br>
</blockquote></blockquote>
<br></span>
Well this list is certainly the right place to ask :)</blockquote><div><br>=
</div><div>That&#39;s what I was hoping for :)</div><div>=C2=A0</div><block=
quote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc=
 solid;padding-left:1ex"><span class=3D"">
<br>
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex"><blockquote class=3D"gmail_quote" style=3D"m=
argin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">
I am trying to use an AMD E8860 (SI) board connected to an E6500 PowerPC<br=
>
board (T2080RDB from NXP).<br>
The T2080RDB does not use a BIOS, and uses u-boot to bootstrap Linux.<br>
<br>
I have the E8860 connected to a PCIe x4 slot with an adapter. The kernel<br=
>
is a 4.1, with DRM included in the kernel and the radeon as a module.<br>
The radeon driver detects the card, notices the BIOS hasn&#39;t posted and<=
br>
starts things up.<br>
After that, the ring tests get run, and fails on the ring 0 test,<br>
disabling acceleration. The graphics card is (or seems to be) working<br>
apart from that, the driver starts up and sees the connectors on the board.=
<br>
<br>
When I compare dmesg on an x86 machine and the PPC machine, I see that<br>
the x86 machine loads a lot more firmware from the kernel (probably the<br>
acceleration parts?).<br>
</blockquote>
FWIW, that&#39;s probably just a subsequent symptom due to the ring test<br=
>
failure.<br>
</blockquote>
<br></span>
Could be, but IIRC we load all the firmware first then initialize things an=
d then do the ring tests when we try to start the rings.<br>
<br>
BTW: What driver are you using? radeon or amdgpu?</blockquote><div><br></di=
v><div>This is a south-island or sea-island chip, so using radeon.</div><di=
v>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;=
border-left:1px #ccc solid;padding-left:1ex"><span class=3D"">
<br>
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex"><blockquote class=3D"gmail_quote" style=3D"m=
argin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">
My question is, what do I need to do to correctly initialize the E8860<br>
board on my powerpc machine?<br>
</blockquote>
Start by sharing the dmesg output, and maybe also the kernel build<br>
configuration file.<br>
</blockquote>
<br></span>
Maybe also open a bug report to attach the dmesg, see <a href=3D"http://bug=
s.freedesktop.org" rel=3D"noreferrer" target=3D"_blank">bugs.freedesktop.or=
g</a>.<br></blockquote><div><br></div><div>Sure. What project does the rade=
on driver fall under? I couldn&#39;t find the right category under Mesa, no=
t sure what</div><div>to file it under.</div><div><br></div><div>Bas Vermeu=
len</div></div></div></div>

--089e0827e9fcf55dcd0565b57ab1--

--===============1220873708==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============1220873708==--
