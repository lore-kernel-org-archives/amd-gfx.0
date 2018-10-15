From: Mauro Rossi <issor.oruam-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [RFC] drm/amd/display: add SI support to AMD DC
Date: Mon, 15 Oct 2018 07:28:57 +0200
Message-ID: <CAEQFVGbB_ezGSGwPu2Ka-4rY9RjB_rJvPL8ZCEG-_rfXxOEN-A@mail.gmail.com>
References: <20181008022344.10247-1-issor.oruam@gmail.com>
 <20181008120423.GA300@freedom>
 <CAEQFVGahx4U+52uKu20_q0iCPrdzeW8G+viS7p2LJtgF61bf6Q@mail.gmail.com>
 <20181008201706.GA351@freedom> <20181008212236.GA338@freedom>
 <CAEQFVGaErupy3y+sKA+uqQPn7x0oL1T9BKWj6y8EC12Ap2-YDw@mail.gmail.com>
 <20181015012533.GA21702@freedom>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1029791421=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <20181015012533.GA21702@freedom>
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
To: Sylvain Bertrand <sylvain.bertrand-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: alexander.deucher-5C7GfCeVMHo@public.gmane.org, Mike Lothian <mike-4+n8WJKc9ve9FHfhHBbuYA@public.gmane.org>, Harry Wentland <harry.wentland-5C7GfCeVMHo@public.gmane.org>, amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org

--===============1029791421==
Content-Type: multipart/alternative; boundary="0000000000006fbcb805783db7b1"

--0000000000006fbcb805783db7b1
Content-Type: text/plain; charset="UTF-8"

Hi Sylvain,

Il lun 15 ott 2018, 03:25 <sylvain.bertrand-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> ha scritto:

> On Sun, Oct 14, 2018 at 11:47:18PM +0200, Mauro Rossi wrote:
> > DOUBT: I think that it would make sense to set "power level 0" i.e.
> > the "lower state" as safe default,
> > considering that powerplay smu6/hwmgr are not implemented for SI and
> > smu7 CIK functions do not work,
> > the AS-IS dpm is the only available option. (and it seams to be
> > working, looking at the framerates 250-280 in the V1 Vulkan benchmark)
>
> dpm not implemented for SI? Are you sure? Because I recall passing
> "messages"
>

dpm for SI is available, while powerplay for SI is not, but
display/amdgpu_dm uses some powerplay calls, where get_static_clock
functions not available and the *ERROR* DM_PPLIB is due to missing handling
in powerplay

to the smu6 to switch between major power modes. And currently in amdgpu I
> switch back and forth between "high" and "auto". And if I stay on "high"
> my GPU
> fans are going crazy all the time, which forces me to switch back to
> "auto" in
> order to quiet the fans.
> Any major state change for any block would have to go through the dpm block
> (smu), because it has to be accounted by this block for proper operation.
> One
> of the hard thing to code, coze no proper documentation, was to set the
> blocks
> in an initial state from a poweron/hard reset/etc which the dpm will know
> how to start/catch-up its operations from. In a perfect world, the dpm
> block
> would have the knowledge on how to program any block in an initial working
> state from any unknown state (and in case of hard block hang, would know
> how to
> hard reset it and set it in a initial state).
>
> > If freesync is about reducing the framerate rate for power saving,
> > provided that I've seen it be mentioned the first time for GCN 2nd
> generation,
> > I'm not expecting freesync as a mandatory capability for the series.
>
> Well, there are the low FPS games, and the movies. I am a regular gamer,
> and I
> know that sustained 60 fps is the very lower bound for many games on a
> desktop
> computer display.
> It does not apply to mobile size display, and "couch playing" on a TV.  The
> readibilty of the game depends directly on the amplitude of movements in
> physical distance on the display, their speed, the viewing distance, and
> the
> FPS. From my personal comfort point of view and types of games I play, on a
> desktop display (dpi, typical viewing distance, typical size), I would
> target a
> minimum of 80-100 fps (120/144 fps seems to be "perfect" targets).
> Played rise of the tomb raider (vulkan) on my tahiti part, and even with a
> blur
> effect to "smooth" the perceived fps like in movies, sub-60 fps is really
> uncomfortable. I was about to stop playing to this game even though it is a
> rather "slow" video game.
>
> > In amd-staging-drm-next dce_clock_source is generic, SI specifics are
> > not necessary anymore.
>
> If I recall properly, "bandwidths" and "watermarks" calcs had asic
> generations
> specific code paths. bandwidth is important for displayport programming or
> maybe you can presume the maximum all the time (and sacrifice some unkown
> amount of power) and watermarks, I know in my old driver I was giving the
> highest priority the the dce block anyway (something related to a "memory
> aribtrer" and "line buffer").
>
> > Any other testing tools worth a run?
>
> AAA games (vulkan: rize of the tomb raider, GL:bioshock infinite) and AAAA
> games
> (dota2(gl and vulkan), cs:go...)
>
> --
> Sylvain
>

Thanks a  lot
Mauro

>

--0000000000006fbcb805783db7b1
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div>Hi Sylvain,<br><br><div class=3D"gmail_quote"><div d=
ir=3D"ltr">Il lun 15 ott 2018, 03:25  &lt;<a href=3D"mailto:sylvain.bertran=
d@gmail.com">sylvain.bertrand-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org</a>&gt; ha scritto:<br></div><block=
quote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc=
 solid;padding-left:1ex">On Sun, Oct 14, 2018 at 11:47:18PM +0200, Mauro Ro=
ssi wrote:<br>
&gt; DOUBT: I think that it would make sense to set &quot;power level 0&quo=
t; i.e.<br>
&gt; the &quot;lower state&quot; as safe default,<br>
&gt; considering that powerplay smu6/hwmgr are not implemented for SI and<b=
r>
&gt; smu7 CIK functions do not work,<br>
&gt; the AS-IS dpm is the only available option. (and it seams to be<br>
&gt; working, looking at the framerates 250-280 in the V1 Vulkan benchmark)=
<br>
<br>
dpm not implemented for SI? Are you sure? Because I recall passing &quot;me=
ssages&quot;<br></blockquote></div></div><div dir=3D"auto"><br></div><div d=
ir=3D"auto">dpm for SI is available, while powerplay for SI is not, but dis=
play/amdgpu_dm uses some powerplay calls, where get_static_clock functions =
not available and the *ERROR* DM_PPLIB is due to missing handling in powerp=
lay</div><div dir=3D"auto"><br></div><div dir=3D"auto"><div class=3D"gmail_=
quote"><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-=
left:1px #ccc solid;padding-left:1ex">
to the smu6 to switch between major power modes. And currently in amdgpu I<=
br>
switch back and forth between &quot;high&quot; and &quot;auto&quot;. And if=
 I stay on &quot;high&quot; my GPU<br>
fans are going crazy all the time, which forces me to switch back to &quot;=
auto&quot; in<br>
order to quiet the fans.<br>
Any major state change for any block would have to go through the dpm block=
<br>
(smu), because it has to be accounted by this block for proper operation. O=
ne<br>
of the hard thing to code, coze no proper documentation, was to set the blo=
cks<br>
in an initial state from a poweron/hard reset/etc which the dpm will know<b=
r>
how to start/catch-up its operations from. In a perfect world, the dpm bloc=
k<br>
would have the knowledge on how to program any block in an initial working<=
br>
state from any unknown state (and in case of hard block hang, would know ho=
w to<br>
hard reset it and set it in a initial state).<br>
<br>
&gt; If freesync is about reducing the framerate rate for power saving,<br>
&gt; provided that I&#39;ve seen it be mentioned the first time for GCN 2nd=
 generation,<br>
&gt; I&#39;m not expecting freesync as a mandatory capability for the serie=
s.<br>
<br>
Well, there are the low FPS games, and the movies. I am a regular gamer, an=
d I<br>
know that sustained 60 fps is the very lower bound for many games on a desk=
top<br>
computer display.<br>
It does not apply to mobile size display, and &quot;couch playing&quot; on =
a TV.=C2=A0 The<br>
readibilty of the game depends directly on the amplitude of movements in<br=
>
physical distance on the display, their speed, the viewing distance, and th=
e<br>
FPS. From my personal comfort point of view and types of games I play, on a=
<br>
desktop display (dpi, typical viewing distance, typical size), I would targ=
et a<br>
minimum of 80-100 fps (120/144 fps seems to be &quot;perfect&quot; targets)=
.<br>
Played rise of the tomb raider (vulkan) on my tahiti part, and even with a =
blur<br>
effect to &quot;smooth&quot; the perceived fps like in movies, sub-60 fps i=
s really<br>
uncomfortable. I was about to stop playing to this game even though it is a=
<br>
rather &quot;slow&quot; video game.<br>
<br>
&gt; In amd-staging-drm-next dce_clock_source is generic, SI specifics are<=
br>
&gt; not necessary anymore.<br>
<br>
If I recall properly, &quot;bandwidths&quot; and &quot;watermarks&quot; cal=
cs had asic generations<br>
specific code paths. bandwidth is important for displayport programming or<=
br>
maybe you can presume the maximum all the time (and sacrifice some unkown<b=
r>
amount of power) and watermarks, I know in my old driver I was giving the<b=
r>
highest priority the the dce block anyway (something related to a &quot;mem=
ory<br>
aribtrer&quot; and &quot;line buffer&quot;).<br>
<br>
&gt; Any other testing tools worth a run?<br>
<br>
AAA games (vulkan: rize of the tomb raider, GL:bioshock infinite) and AAAA =
games<br>
(dota2(gl and vulkan), cs:go...)<br>
<br>
-- <br>
Sylvain<br></blockquote></div></div><div dir=3D"auto"><br></div><div dir=3D=
"auto">Thanks a=C2=A0 lot</div><div dir=3D"auto">Mauro</div><div dir=3D"aut=
o"><div class=3D"gmail_quote"><blockquote class=3D"gmail_quote" style=3D"ma=
rgin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">
</blockquote></div></div></div>

--0000000000006fbcb805783db7b1--

--===============1029791421==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============1029791421==--
