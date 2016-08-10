From: =?UTF-8?Q?Ernst_Sj=C3=B6strand?= <ernstp-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH] Add freesync ioctl interface
Date: Wed, 10 Aug 2016 10:25:25 +0200
Message-ID: <CAD=4a=U+p+Aza+z-hj03HNrOPp9hC1r=nV0Aw1UjzyRBLxm1yg@mail.gmail.com>
References: <1470104760-30612-1-git-send-email-Hawking.Zhang@amd.com>
 <CAPM=9twBgjLJNZ4F5xzoAk6zw-8=7ck7xfTnQOczr1TVNLnMTQ@mail.gmail.com>
 <918642dc-f72c-5403-cf38-eead279d4a97@daenzer.net>
 <618bb6d0-bca5-e709-227c-08c99bd6843e@vodafone.de>
 <a2e669ae-88a3-4734-3e7f-5aceccfc43d7@daenzer.net>
 <1c54f1c3-130f-f858-e08b-14d70d17817d@vodafone.de>
 <7b758b9a-7ee3-7809-4e23-76828ee23a0c@daenzer.net>
 <ad9f2301-1d4c-388e-f3c2-d12872f7940a@vodafone.de>
 <cf663a26-afd2-0878-2822-fe375905fbfc@daenzer.net>
 <7ffe528b-d207-3948-a850-a289bcc76c43@vodafone.de>
 <7bdf1ec7-d257-9855-2f24-21f86efa459f@daenzer.net>
 <0919aff9-cccd-ba2a-2077-3dbd2bea769f@vodafone.de>
 <142d748c-11be-e454-551f-e9098a53a848@daenzer.net>
 <75f1d134-b1f4-c24f-be3f-a886c95e5ced@daenzer.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0275508915=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <75f1d134-b1f4-c24f-be3f-a886c95e5ced-otUistvHUpPR7s880joybQ@public.gmane.org>
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
Cc: =?UTF-8?Q?Christian_K=C3=B6nig?= <deathsimple-ANTagKRnAhcb1SvskN2V4Q@public.gmane.org>, Dave Airlie <airlied-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, amd-gfx mailing list <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, Hawking Zhang <Hawking.Zhang-5C7GfCeVMHo@public.gmane.org>

--===============0275508915==
Content-Type: multipart/alternative; boundary=94eb2c05fc4a28bb620539b3645e

--94eb2c05fc4a28bb620539b3645e
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

I thought I'd add some notes as a someone who also plays games on Windows
with Freesync...

I have a 4K monitor with Freesync, the range is 45 to 60 Hz. It might
sounds narrow but it allows you
to have a smooth experience even at very high resolutions and settings. If
the game can't hit 60 fps
exactly it's still fine, it seems smooth and you don't get tearing.
This is shown in all games as a 60 Hz monitor even though Freesync is
enabled.

In the Windows gaming world there's a couple of different combinations at
play:

1) Vsync disabled.
The game renders frames simply as fast as it can. If the fps is below 45 I
get tearing.
If it's above 60 I get tearing. Not very good solution.

2) Vsync enabled.
Fps stays capped to 60, so no tearing on that end. Also 50 fps is smooth
and uses Freesync fine.
This is AFAIK done behind the scene by the AMD DX11 implementation and not
something the game
is involved in.
If fps goes below 45 it starts locking to 30 fps instead, not so nice.

3) Vsync disabled + AMD Frame Rate Target Control (FRTC).
You set FRTC to 1-2 fps below your max refresh rate. That means that if fps
goes below 45 you get
tearing (at 45 Hz refresh or 60?), but at least it renders frames as fast
as it can in that case still. This is a
solution many people like. However FRTC doesn't work all the time.

Regards
//Ernst

2016-08-10 9:49 GMT+02:00 Michel D=C3=A4nzer <michel-otUistvHUpPR7s880joybQ@public.gmane.org>:

> On 10/08/16 12:19 PM, Michel D=C3=A4nzer wrote:
> > On 09/08/16 07:44 PM, Christian K=C3=B6nig wrote:
> >> Am 09.08.2016 um 12:03 schrieb Michel D=C3=A4nzer:
> >>> On 09/08/16 06:31 PM, Christian K=C3=B6nig wrote:
> >>>>
> >>>> When we add freesync support we just extend vblank_mode with a new
> enum
> >>>> to enable it optionally for existing applications.
> >>> "Just"... this will only be possible after the first 3 steps above.
> >>
> >> Checking the present extension again we already got PresentOptionAsync
> >> in there as well.
> >>
> >> So the whole thing boils down implementing a new vblank_mode enume whi=
ch
> >> sets PresentOptionAsync and then doing the right thing on the X side
> >> with those information.
> >
> > PresentOptionAsync isn't for this. It's for not waiting for the vertica=
l
> > blank period before performing a flip, which may result in tearing. Thi=
s
> > distinction still applies with variable refresh rate, so this option
> > cannot be re-purposed to distinguish between variable and fixed refresh
> > rate.
> >
> >
> > BTW, the only presentation time we can use for the vblank_mode override
> > is "now" / "as soon as possible". So for that case (which is currently
> > the case for basically all games, and will likely continue to be for th=
e
> > vast majority for a long time), the whole exercise doesn't provide any
> > net benefit over using the existing vblank-based presentation
> > infrastructure and just force-enabling variable refresh rate somehow.
> >
> > Note that I'm not questioning the value of time-based presentation for
> > video playback, and thus the need to implement it. I'm only questioning
> > the point of delaying variable refresh rate for games by gating it on
> > the time-based presentation infrastructure.
>
> Also, we still haven't covered how a variable refresh rate mode would
> actually get set in this case, assuming it can't be set all the time
> (because either there is no compositor, or it doesn't use OpenGL, or it
> doesn't work well with variable refresh rate).
>
>
> --
> Earthling Michel D=C3=A4nzer               |               http://www.amd=
.com
> Libre software enthusiast             |             Mesa and X developer
> _______________________________________________
> amd-gfx mailing list
> amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
>

--94eb2c05fc4a28bb620539b3645e
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div><div><div><div><div><div><div><div><div>I thought I&#=
39;d add some notes as a someone who also plays games on Windows with Frees=
ync...<br><br></div><div>I have a 4K monitor with Freesync, the range is 45=
 to 60 Hz. It might sounds narrow but it allows you<br></div><div>to have a=
 smooth experience even at very high resolutions and settings. If the game =
can&#39;t hit 60 fps<br></div><div>exactly it&#39;s still fine, it seems sm=
ooth and you don&#39;t get tearing.<br></div><div>This is shown in all game=
s as a 60 Hz monitor even though Freesync is enabled.<br></div><div><br>In =
the Windows gaming world there&#39;s a couple of different combinations at =
play:<br><br></div>1) Vsync disabled.<br></div>The game renders frames simp=
ly as fast as it can. If the fps is below 45 I get tearing.<br></div>If it&=
#39;s above 60 I get tearing. Not very good solution.<br><br></div>2) Vsync=
 enabled.<br></div>Fps stays capped to 60, so no tearing on that end. Also =
50 fps is smooth and uses Freesync fine.<br>This is AFAIK done behind the s=
cene by the AMD DX11 implementation and not something the game<br></div><di=
v>is involved in.<br></div><div>If fps goes below 45 it starts locking to 3=
0 fps instead, not so nice.<br></div></div><div><br></div>3) Vsync disabled=
 + AMD Frame Rate Target Control (FRTC).<br></div>You set FRTC to 1-2 fps b=
elow your max refresh rate. That means that if fps goes below 45 you get<br=
></div><div>tearing (at 45 Hz refresh or 60?), but at least it renders fram=
es as fast as it can in that case still. This is a<br>solution many people =
like. However FRTC doesn&#39;t work all the time.<br><br></div><div>Regards=
<br></div><div>//Ernst<br></div></div><div class=3D"gmail_extra"><br><div c=
lass=3D"gmail_quote">2016-08-10 9:49 GMT+02:00 Michel D=C3=A4nzer <span dir=
=3D"ltr">&lt;<a href=3D"mailto:michel-otUistvHUpPR7s880joybQ@public.gmane.org" target=3D"_blank">michel=
@daenzer.net</a>&gt;</span>:<br><blockquote class=3D"gmail_quote" style=3D"=
margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex"><span class=
=3D"">On 10/08/16 12:19 PM, Michel D=C3=A4nzer wrote:<br>
&gt; On 09/08/16 07:44 PM, Christian K=C3=B6nig wrote:<br>
&gt;&gt; Am 09.08.2016 um 12:03 schrieb Michel D=C3=A4nzer:<br>
&gt;&gt;&gt; On 09/08/16 06:31 PM, Christian K=C3=B6nig wrote:<br>
&gt;&gt;&gt;&gt;<br>
</span><span class=3D"">&gt;&gt;&gt;&gt; When we add freesync support we ju=
st extend vblank_mode with a new enum<br>
&gt;&gt;&gt;&gt; to enable it optionally for existing applications.<br>
&gt;&gt;&gt; &quot;Just&quot;... this will only be possible after the first=
 3 steps above.<br>
&gt;&gt;<br>
&gt;&gt; Checking the present extension again we already got PresentOptionA=
sync<br>
&gt;&gt; in there as well.<br>
&gt;&gt;<br>
&gt;&gt; So the whole thing boils down implementing a new vblank_mode enume=
 which<br>
&gt;&gt; sets PresentOptionAsync and then doing the right thing on the X si=
de<br>
&gt;&gt; with those information.<br>
&gt;<br>
&gt; PresentOptionAsync isn&#39;t for this. It&#39;s for not waiting for th=
e vertical<br>
&gt; blank period before performing a flip, which may result in tearing. Th=
is<br>
&gt; distinction still applies with variable refresh rate, so this option<b=
r>
&gt; cannot be re-purposed to distinguish between variable and fixed refres=
h<br>
&gt; rate.<br>
&gt;<br>
&gt;<br>
&gt; BTW, the only presentation time we can use for the vblank_mode overrid=
e<br>
&gt; is &quot;now&quot; / &quot;as soon as possible&quot;. So for that case=
 (which is currently<br>
&gt; the case for basically all games, and will likely continue to be for t=
he<br>
&gt; vast majority for a long time), the whole exercise doesn&#39;t provide=
 any<br>
&gt; net benefit over using the existing vblank-based presentation<br>
&gt; infrastructure and just force-enabling variable refresh rate somehow.<=
br>
&gt;<br>
&gt; Note that I&#39;m not questioning the value of time-based presentation=
 for<br>
&gt; video playback, and thus the need to implement it. I&#39;m only questi=
oning<br>
&gt; the point of delaying variable refresh rate for games by gating it on<=
br>
&gt; the time-based presentation infrastructure.<br>
<br>
</span>Also, we still haven&#39;t covered how a variable refresh rate mode =
would<br>
actually get set in this case, assuming it can&#39;t be set all the time<br=
>
(because either there is no compositor, or it doesn&#39;t use OpenGL, or it=
<br>
doesn&#39;t work well with variable refresh rate).<br>
<div class=3D"HOEnZb"><div class=3D"h5"><br>
<br>
--<br>
Earthling Michel D=C3=A4nzer=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0|=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0<a href=
=3D"http://www.amd.com" rel=3D"noreferrer" target=3D"_blank">http://www.amd=
.com</a><br>
Libre software enthusiast=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0Mesa and X developer<br>
______________________________<wbr>_________________<br>
amd-gfx mailing list<br>
<a href=3D"mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org">amd-gfx-PD4FTy7X32lNgt0PjOBp9/rsn8yoX9R0@public.gmane.org=
org</a><br>
<a href=3D"https://lists.freedesktop.org/mailman/listinfo/amd-gfx" rel=3D"n=
oreferrer" target=3D"_blank">https://lists.freedesktop.org/<wbr>mailman/lis=
tinfo/amd-gfx</a><br>
</div></div></blockquote></div><br></div>

--94eb2c05fc4a28bb620539b3645e--

--===============0275508915==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============0275508915==--
