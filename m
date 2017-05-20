From: =?UTF-8?B?TWFyZWsgT2zFocOhaw==?= <maraeo-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 0/3] drm/amdgpu: Tweaks for high pressure on CPU visible
 VRAM
Date: Sat, 20 May 2017 11:26:57 +0200
Message-ID: <CAAxE2A67T3Mhw68thNewFtcdua3ufSP-FDX_RN153x-aLKUh1Q@mail.gmail.com>
References: <20170518090809.15916-1-michel@daenzer.net>
 <CAAxE2A65deE+hue7oPMQ+=K5s8TEGZE+bJMNVOdp=LQuq_RnMQ@mail.gmail.com>
 <a574c18a-0c21-bf85-963f-5df06a0b192e@daenzer.net>
 <CAAxE2A6ZiNSswhArstqHpYnm30ieoDZj=j_-aFvZz1_ByXLOGA@mail.gmail.com>
 <CAAxE2A4zdgFRh-GDqyDRrXmEWqjSrkfCo=Z41hfo-UNY0E5FhA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1510632329=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <CAAxE2A4zdgFRh-GDqyDRrXmEWqjSrkfCo=Z41hfo-UNY0E5FhA-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
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
Cc: amd-gfx mailing list <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

--===============1510632329==
Content-Type: multipart/alternative; boundary="001a1143f9a25b0e39054ff13d87"

--001a1143f9a25b0e39054ff13d87
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On May 20, 2017 3:26 AM, "Michel D=C3=A4nzer" <michel-otUistvHUpPR7s880joybQ@public.gmane.org> wrote:

On 20/05/17 01:14 AM, Marek Ol=C5=A1=C3=A1k wrote:
> Hi Michel,
>
> I've applied your series

Thanks for testing it.

> and it doesn't help with low Dirt Rally performance on Fiji. I see TTM
> buffer moves at 800MB/s and many VRAM page faults.

Did you see this:

>> Note that there's only little if any improvement of the average framerat=
e
>> reported, but the minimum framerate as seen on the HUD goes from ~10 fps
>> to ~17.

I.e. it mostly affects the minimum framerate and smoothness for me as well.


Without the series, I get 70 average fps. With the series, I get 30 average
fps. That might just be random bad luck. I don't know. In any case, 30 fps
is really bad, so I don't think the series does what you think it does.

Marek



--
Earthling Michel D=C3=A4nzer               |               http://www.amd.c=
om
Libre software enthusiast             |             Mesa and X developer

--001a1143f9a25b0e39054ff13d87
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div><br><div class=3D"gmail_extra"><br><div class=3D"gma=
il_quote">On May 20, 2017 3:26 AM, &quot;Michel D=C3=A4nzer&quot; &lt;<a hr=
ef=3D"mailto:michel-otUistvHUpPR7s880joybQ@public.gmane.org">michel-otUistvHUpPR7s880joybQ@public.gmane.org</a>&gt; wrote:<br type=
=3D"attribution"><blockquote class=3D"quote" style=3D"margin:0 0 0 .8ex;bor=
der-left:1px #ccc solid;padding-left:1ex"><div class=3D"quoted-text">On 20/=
05/17 01:14 AM, Marek Ol=C5=A1=C3=A1k wrote:<br>
&gt; Hi Michel,<br>
&gt;<br>
&gt; I&#39;ve applied your series<br>
<br>
</div>Thanks for testing it.<br>
<div class=3D"quoted-text"><br>
&gt; and it doesn&#39;t help with low Dirt Rally performance on Fiji. I see=
 TTM<br>
&gt; buffer moves at 800MB/s and many VRAM page faults.<br>
<br>
</div>Did you see this:<br>
<div class=3D"quoted-text"><br>
&gt;&gt; Note that there&#39;s only little if any improvement of the averag=
e framerate<br>
&gt;&gt; reported, but the minimum framerate as seen on the HUD goes from ~=
10 fps<br>
&gt;&gt; to ~17.<br>
<br>
</div>I.e. it mostly affects the minimum framerate and smoothness for me as=
 well.<br></blockquote></div></div></div><div dir=3D"auto"><br></div><div d=
ir=3D"auto">Without the series, I get 70 average fps. With the series, I ge=
t 30 average fps. That might just be random bad luck. I don&#39;t know. In =
any case, 30 fps is really bad, so I don&#39;t think the series does what y=
ou think it does.</div><div dir=3D"auto"><br></div><div dir=3D"auto">Marek<=
/div><div dir=3D"auto"><br></div><div dir=3D"auto"><div class=3D"gmail_extr=
a"><div class=3D"gmail_quote"><blockquote class=3D"quote" style=3D"margin:0=
 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">
<font color=3D"#888888"><br>
<br>
--<br>
Earthling Michel D=C3=A4nzer=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0|=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0<a href=
=3D"http://www.amd.com" rel=3D"noreferrer" target=3D"_blank">http://www.amd=
.com</a><br>
Libre software enthusiast=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0Mesa and X developer<br>
</font></blockquote></div><br></div></div></div>

--001a1143f9a25b0e39054ff13d87--

--===============1510632329==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============1510632329==--
