From: =?UTF-8?B?TWFyZWsgT2zFocOhaw==?= <maraeo-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: The problem "ring gfx timeout" are experienced yet another AMD
 GPU Vega 8 user
Date: Wed, 3 Jul 2019 14:56:42 -0400
Message-ID: <CAAxE2A4fy3MAMV0HzX2Rszf=2nZ923xE+r2tVhZKp18V88cmVg@mail.gmail.com>
References: <CABXGCsMas72q52GYvH+5Po-KDPfqu74XO_YznqJKnp+-+1Mnww@mail.gmail.com>
 <e92cffb7-6627-6f52-70de-e09d9bdbbe0a@amd.com>
 <CAAxE2A4tM-OoxcnLw14M8aZJLPLnPm2aN4fpTVQX_aUyJ9OBNw@mail.gmail.com>
 <CABXGCsMJKKu6DxvKvD8U6Ffkmt8KinNS96w4ygZ7xaemvEhocg@mail.gmail.com>
 <CAAxE2A6US6YBpESnwqm-EGsDapOVVfbHXxdrkjG1UddFPO0mOQ@mail.gmail.com>
 <CABXGCsOWGpop=5_a6nrRoqWSWagkMg_sYCPL8ZuSuByvcDDu+w@mail.gmail.com>
 <CAAxE2A4Xdsutk=teU=vi_Gnr2tuwinu6_JSfkoqTGwd1NrSpxQ@mail.gmail.com>
 <CABXGCsNpD93nBCWiL0VV_x+7jjY+HMYMbWsswxvHWWZXJaAhTQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0711319371=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <CABXGCsNpD93nBCWiL0VV_x+7jjY+HMYMbWsswxvHWWZXJaAhTQ-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
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
To: Mikhail Gavrilov <mikhail.v.gavrilov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: "Grodzovsky, Andrey" <Andrey.Grodzovsky-5C7GfCeVMHo@public.gmane.org>, amd-gfx list <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

--===============0711319371==
Content-Type: multipart/alternative; boundary="000000000000340fe4058ccb6ee7"

--000000000000340fe4058ccb6ee7
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

It looks like memory corruption. You can try to disable IOMMU in the BIOS.

Marek

On Tue, Jul 2, 2019 at 12:07 AM Mikhail Gavrilov <
mikhail.v.gavrilov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:

> On Wed, 27 Feb 2019 at 00:57, Marek Ol=C5=A1=C3=A1k <maraeo-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wr=
ote:
> >
> > Sadly, the logs don't contain any clue as to why it hangs.
> >
> > It would be helpful to check if the hang can be reproduced on Vega 56 o=
r
> 64 as well.
> >
> > Marek
> >
>
> Hi, Marek.
>
> I'm sorry to trouble you.
> But today the user of described above Vega 8 graphic sended me fresh logs=
.
>
> Actual versions: kernel 5.1.15 / DRM 3.30.0 / Mesa 19.0. / LLVM 8.0.0
>
> I uploaded all logs to mega cloud storage.
> Can you look this logs please?
>
> https://mega.nz/#F!Mt5mhKiI!8Sv2T5a6yTxBqVknhH1NjA
>
>
> --
> Best Regards,
> Mike Gavrilov.
>

--000000000000340fe4058ccb6ee7
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>It looks like memory corruption. You can try to disab=
le IOMMU in the BIOS.</div><div><br></div><div>Marek<br></div><br><div clas=
s=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">On Tue, Jul 2, 2019=
 at 12:07 AM Mikhail Gavrilov &lt;<a href=3D"mailto:mikhail.v.gavrilov@gmai=
l.com">mikhail.v.gavrilov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org</a>&gt; wrote:<br></div><blockquote cla=
ss=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid =
rgb(204,204,204);padding-left:1ex">On Wed, 27 Feb 2019 at 00:57, Marek Ol=
=C5=A1=C3=A1k &lt;<a href=3D"mailto:maraeo-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org" target=3D"_blank">mar=
aeo-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org</a>&gt; wrote:<br>
&gt;<br>
&gt; Sadly, the logs don&#39;t contain any clue as to why it hangs.<br>
&gt;<br>
&gt; It would be helpful to check if the hang can be reproduced on Vega 56 =
or 64 as well.<br>
&gt;<br>
&gt; Marek<br>
&gt;<br>
<br>
Hi, Marek.<br>
<br>
I&#39;m sorry to trouble you.<br>
But today the user of described above Vega 8 graphic sended me fresh logs.<=
br>
<br>
Actual versions: kernel 5.1.15 / DRM 3.30.0 / Mesa 19.0. / LLVM 8.0.0<br>
<br>
I uploaded all logs to mega cloud storage.<br>
Can you look this logs please?<br>
<br>
<a href=3D"https://mega.nz/#F!Mt5mhKiI!8Sv2T5a6yTxBqVknhH1NjA" rel=3D"noref=
errer" target=3D"_blank">https://mega.nz/#F!Mt5mhKiI!8Sv2T5a6yTxBqVknhH1NjA=
</a><br>
<br>
<br>
--<br>
Best Regards,<br>
Mike Gavrilov.<br>
</blockquote></div></div>

--000000000000340fe4058ccb6ee7--

--===============0711319371==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4

--===============0711319371==--
