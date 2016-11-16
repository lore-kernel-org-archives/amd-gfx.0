From: Mike Lothian <mike-4+n8WJKc9ve9FHfhHBbuYA@public.gmane.org>
Subject: Re: [AMDGPU][CIK] PRIME with DRI3 + stalls rendering
Date: Wed, 16 Nov 2016 11:45:24 +0000
Message-ID: <CAHbf0-EyOvHUHK1_t_uSy4c-sJQb5yCVnFfBLQ9FqvfQGwcGhg@mail.gmail.com>
References: <8755034.yvhYdOUKRs@segfault>
 <472120da-9ec1-3963-484f-24add93f8eb6@daenzer.net>
 <1502264.CaXMU5SOfp@segfault> <7436783.BjWzAA5TzI@segfault>
 <3eff28a2-e53c-74b9-4e34-6e7e206f0fc5@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0474028364=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <3eff28a2-e53c-74b9-4e34-6e7e206f0fc5-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
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
To: Mario Kleiner <mario.kleiner.de-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Shawn Starr <shawn.starr-bJEeYj9oJeDQT0dZR+AlfA@public.gmane.org>, amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Cc: =?UTF-8?Q?Michel_D=C3=A4nzer?= <michel-otUistvHUpPR7s880joybQ@public.gmane.org>

--===============0474028364==
Content-Type: multipart/alternative; boundary=001a11423f446f00d60541699c51

--001a11423f446f00d60541699c51
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Alternatively you can switch to the modesetting driver - it works well here

On Wed, 16 Nov 2016 at 01:33 Mario Kleiner <mario.kleiner.de-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
wrote:

> On 11/15/2016 09:25 AM, Shawn Starr wrote:
> > On Monday, November 14, 2016 3:40:17 PM EST Shawn Starr wrote:
> >> On Monday, November 14, 2016 10:40:17 AM EST Michel D=C3=A4nzer wrote:
> >>> On 13/11/16 06:59 AM, Shawn Starr wrote:
> >>>> I'm currently trying the new fence patches that prevent tearing in
> PRIME
> >>>> on
> >>>> Bonaire CIK, it works with no tearing with latest patches from Mario=
,
> >>>> but
> >>>> there is significant frame stalls, even though the performance is
> higher
> >>>> than running the AMDGPU as dedicated.
> >>>
> >>> Please elaborate on what "frame stalls" means exactly.
> >>
> >> It looks like vsync issues, even though if I try vblank_mode=3D# it st=
ill
> >> shows stalling.
> >>
> >> I'll have to make a video to show the results and post link here.
> >>
> >> Thanks,
> >> Shawn
> >
> > So, It turns out to be KDE (Kwin) fault, if I start a GNOME session, an=
d
> run
> > Valley, no such stalls. Even though I told KWIN to disable Vsync
> completely
> > and disable composite on full screen windows. Seems it doesn't work
> right.
> >
> > Consider the PRIME patches working for me.
> >
> > Thanks,
> > Shawn
> >
> >
>
> Glad it works for you with GNOME.
>
> Wrt. Kwin, KWin doesn't unredirect fullscreen windows if the display
> iGPU is Intel, apparently because sometime in the past there were bugs
> in the intel ddx related to switching between redirected and
> unredirected mode. That might explain the problem under KDE.
>
> You'd need to disable the compositor manually (SHIFT + ALT + F12 to
> toggle at runtime) while running a fullscreen app/game that way, or the
> application needs to set some NetWM hints on its window to ask for no
> composition, or some KWin rule needs to be set for the app. I tested the
> patches under KDE Plasma 5 (KUbuntu 16.04 LTS) with composition disabled
> this way and at least my tests worked fine then.
>
> -mario
> _______________________________________________
> amd-gfx mailing list
> amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
>

--001a11423f446f00d60541699c51
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Alternatively you can switch to the modesetting driver - i=
t works well here</div><br><div class=3D"gmail_quote"><div dir=3D"ltr">On W=
ed, 16 Nov 2016 at 01:33 Mario Kleiner &lt;<a href=3D"mailto:mario.kleiner.=
de-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org">mario.kleiner.de-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org</a>&gt; wrote:<br></div><blockquot=
e class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc sol=
id;padding-left:1ex">On 11/15/2016 09:25 AM, Shawn Starr wrote:<br class=3D=
"gmail_msg">
&gt; On Monday, November 14, 2016 3:40:17 PM EST Shawn Starr wrote:<br clas=
s=3D"gmail_msg">
&gt;&gt; On Monday, November 14, 2016 10:40:17 AM EST Michel D=C3=A4nzer wr=
ote:<br class=3D"gmail_msg">
&gt;&gt;&gt; On 13/11/16 06:59 AM, Shawn Starr wrote:<br class=3D"gmail_msg=
">
&gt;&gt;&gt;&gt; I&#39;m currently trying the new fence patches that preven=
t tearing in PRIME<br class=3D"gmail_msg">
&gt;&gt;&gt;&gt; on<br class=3D"gmail_msg">
&gt;&gt;&gt;&gt; Bonaire CIK, it works with no tearing with latest patches =
from Mario,<br class=3D"gmail_msg">
&gt;&gt;&gt;&gt; but<br class=3D"gmail_msg">
&gt;&gt;&gt;&gt; there is significant frame stalls, even though the perform=
ance is higher<br class=3D"gmail_msg">
&gt;&gt;&gt;&gt; than running the AMDGPU as dedicated.<br class=3D"gmail_ms=
g">
&gt;&gt;&gt;<br class=3D"gmail_msg">
&gt;&gt;&gt; Please elaborate on what &quot;frame stalls&quot; means exactl=
y.<br class=3D"gmail_msg">
&gt;&gt;<br class=3D"gmail_msg">
&gt;&gt; It looks like vsync issues, even though if I try vblank_mode=3D# i=
t still<br class=3D"gmail_msg">
&gt;&gt; shows stalling.<br class=3D"gmail_msg">
&gt;&gt;<br class=3D"gmail_msg">
&gt;&gt; I&#39;ll have to make a video to show the results and post link he=
re.<br class=3D"gmail_msg">
&gt;&gt;<br class=3D"gmail_msg">
&gt;&gt; Thanks,<br class=3D"gmail_msg">
&gt;&gt; Shawn<br class=3D"gmail_msg">
&gt;<br class=3D"gmail_msg">
&gt; So, It turns out to be KDE (Kwin) fault, if I start a GNOME session, a=
nd run<br class=3D"gmail_msg">
&gt; Valley, no such stalls. Even though I told KWIN to disable Vsync compl=
etely<br class=3D"gmail_msg">
&gt; and disable composite on full screen windows. Seems it doesn&#39;t wor=
k right.<br class=3D"gmail_msg">
&gt;<br class=3D"gmail_msg">
&gt; Consider the PRIME patches working for me.<br class=3D"gmail_msg">
&gt;<br class=3D"gmail_msg">
&gt; Thanks,<br class=3D"gmail_msg">
&gt; Shawn<br class=3D"gmail_msg">
&gt;<br class=3D"gmail_msg">
&gt;<br class=3D"gmail_msg">
<br class=3D"gmail_msg">
Glad it works for you with GNOME.<br class=3D"gmail_msg">
<br class=3D"gmail_msg">
Wrt. Kwin, KWin doesn&#39;t unredirect fullscreen windows if the display<br=
 class=3D"gmail_msg">
iGPU is Intel, apparently because sometime in the past there were bugs<br c=
lass=3D"gmail_msg">
in the intel ddx related to switching between redirected and<br class=3D"gm=
ail_msg">
unredirected mode. That might explain the problem under KDE.<br class=3D"gm=
ail_msg">
<br class=3D"gmail_msg">
You&#39;d need to disable the compositor manually (SHIFT + ALT + F12 to<br =
class=3D"gmail_msg">
toggle at runtime) while running a fullscreen app/game that way, or the<br =
class=3D"gmail_msg">
application needs to set some NetWM hints on its window to ask for no<br cl=
ass=3D"gmail_msg">
composition, or some KWin rule needs to be set for the app. I tested the<br=
 class=3D"gmail_msg">
patches under KDE Plasma 5 (KUbuntu 16.04 LTS) with composition disabled<br=
 class=3D"gmail_msg">
this way and at least my tests worked fine then.<br class=3D"gmail_msg">
<br class=3D"gmail_msg">
-mario<br class=3D"gmail_msg">
_______________________________________________<br class=3D"gmail_msg">
amd-gfx mailing list<br class=3D"gmail_msg">
<a href=3D"mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" class=3D"gmail_msg" target=
=3D"_blank">amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org</a><br class=3D"gmail_msg">
<a href=3D"https://lists.freedesktop.org/mailman/listinfo/amd-gfx" rel=3D"n=
oreferrer" class=3D"gmail_msg" target=3D"_blank">https://lists.freedesktop.=
org/mailman/listinfo/amd-gfx</a><br class=3D"gmail_msg">
</blockquote></div>

--001a11423f446f00d60541699c51--

--===============0474028364==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============0474028364==--
