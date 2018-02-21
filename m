From: Bas Vermeulen <bas-MbI5SpmOCPBHdOctNixuYw@public.gmane.org>
Subject: Re: AMD E8860 on PowerPC with u-boot (T2080)
Date: Wed, 21 Feb 2018 10:56:57 +0100
Message-ID: <CAGtoiRjak-2BG6Z_T5TgoA8r3trf+v0i+vSxbiUp-4O9biZWJw@mail.gmail.com>
References: <CAGtoiRjxS7mgQKG_yib9-5tVkD9_yAkp3P8PxYvipy3bFnV9Rg@mail.gmail.com>
 <a6b1d334-cf01-993a-a298-4ab63e9189a7@daenzer.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1541782033=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <a6b1d334-cf01-993a-a298-4ab63e9189a7-otUistvHUpPR7s880joybQ@public.gmane.org>
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
To: =?UTF-8?Q?Michel_D=C3=A4nzer?= <michel-otUistvHUpPR7s880joybQ@public.gmane.org>
Cc: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org

--===============1541782033==
Content-Type: multipart/alternative; boundary="001a1147c9e6a598990565b5f236"

--001a1147c9e6a598990565b5f236
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 21, 2018 at 10:36 AM, Michel D=C3=A4nzer <michel-otUistvHUpPR7s880joybQ@public.gmane.org> w=
rote:

> On 2018-02-21 09:49 AM, Bas Vermeulen wrote:
> > Hi,
> >
> > I am unsure if this is the right place to ask, but it seems relevant.
> >
> > I am trying to use an AMD E8860 (SI) board connected to an E6500 PowerP=
C
> > board (T2080RDB from NXP).
>
> BTW, looks like the CPU runs in big endian mode
> (CONFIG_CPU_BIG_ENDIAN=3Dy), doesn't it? If so, be warned that this is
> just the tip of the iceberg. The Mesa radeonsi driver doesn't work on
> big endian hosts yet, fixing that would involve a lot of work and pain.
> And without that, you won't be able to actually use any hardware
> acceleration.
>

Understood. At the moment I want to understand what I am doing wrong in
regards to the kernel part,
I'll cross the userspace bridge when I get there. The end-goal is a
completely different (real-time) OS,
and understanding how things work will help in any case.

Bas Vermeulen

--001a1147c9e6a598990565b5f236
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_extra"><div class=3D"gmail_quote">On W=
ed, Feb 21, 2018 at 10:36 AM, Michel D=C3=A4nzer <span dir=3D"ltr">&lt;<a h=
ref=3D"mailto:michel-otUistvHUpPR7s880joybQ@public.gmane.org" target=3D"_blank">michel-otUistvHUpPR7s880joybQ@public.gmane.org</a>&=
gt;</span> wrote:<br><blockquote class=3D"gmail_quote" style=3D"margin:0 0 =
0 .8ex;border-left:1px #ccc solid;padding-left:1ex"><span class=3D"">On 201=
8-02-21 09:49 AM, Bas Vermeulen wrote:<br>
</span><span class=3D"">&gt; Hi,<br>
&gt;<br>
&gt; I am unsure if this is the right place to ask, but it seems relevant.<=
br>
&gt;<br>
&gt; I am trying to use an AMD E8860 (SI) board connected to an E6500 Power=
PC<br>
&gt; board (T2080RDB from NXP).<br>
<br>
</span>BTW, looks like the CPU runs in big endian mode<br>
(CONFIG_CPU_BIG_ENDIAN=3Dy), doesn&#39;t it? If so, be warned that this is<=
br>
just the tip of the iceberg. The Mesa radeonsi driver doesn&#39;t work on<b=
r>
big endian hosts yet, fixing that would involve a lot of work and pain.<br>
And without that, you won&#39;t be able to actually use any hardware<br>
acceleration.<br></blockquote><div><br></div><div>Understood. At the moment=
 I want to understand what I am doing wrong in regards to the kernel part,<=
/div><div>I&#39;ll cross the userspace bridge when I get there. The end-goa=
l is a completely different (real-time) OS,</div><div>and understanding how=
 things work will help in any case.</div><div><br></div><div>Bas Vermeulen<=
/div><div><br></div></div></div></div>

--001a1147c9e6a598990565b5f236--

--===============1541782033==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============1541782033==--
