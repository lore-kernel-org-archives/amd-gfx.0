From: Mike Lothian <mike-4+n8WJKc9ve9FHfhHBbuYA@public.gmane.org>
Subject: Re: [PATCH xf86-video-amdgpu 0/7] Enabling Color Management - Round 3
Date: Thu, 7 Jun 2018 14:26:15 +0100
Message-ID: <CAHbf0-E=KyYDVj-L5fknEPGL6kUeP--bDOuPXUz5oMjciABXYw@mail.gmail.com>
References: <1527869017-9209-1-git-send-email-sunpeng.li@amd.com>
 <e0a71df1-265b-cb62-1c1f-567b26808b71@daenzer.net>
 <CAHbf0-GW9MDmTBDepJjG-WXdqNPhsHWwQMvHo1Sma+JCDy-1dQ@mail.gmail.com>
 <64b1e3fc-d267-b1fc-032a-86aebfe2ff1d@daenzer.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0497260487=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <64b1e3fc-d267-b1fc-032a-86aebfe2ff1d-otUistvHUpPR7s880joybQ@public.gmane.org>
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
Cc: sunpeng.li-5C7GfCeVMHo@public.gmane.org, harry.wentland-5C7GfCeVMHo@public.gmane.org, amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org

--===============0497260487==
Content-Type: multipart/alternative; boundary="000000000000f9f494056e0d3aa7"

--000000000000f9f494056e0d3aa7
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

It seems messy having to create a whole xorg.conf just for one parameter

On Thu, 7 Jun 2018 at 08:31 Michel D=C3=A4nzer <michel-otUistvHUpPR7s880joybQ@public.gmane.org> wrote:

> On 2018-06-07 09:22 AM, Mike Lothian wrote:
> > Hi
> >
> > Is there a way to set depth using a xorg.conf.d snippet rather than
> > creating an xorg.conf?
>
> Sure (the xorg.conf.d snippets are simply concatenated together with
> xorg.conf, so anything can go in either of them), but it's the wrong way
> to do it. :)
>
> The xorg.conf.d mechanism is for shipping snippets required for a driver
> or other Xorg module to work out of the box. xorg.conf is still the
> place for actual configuration.
>
>
> --
> Earthling Michel D=C3=A4nzer               |               http://www.amd=
.com
> Libre software enthusiast             |             Mesa and X developer
>

--000000000000f9f494056e0d3aa7
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">It seems messy having to create a whole xorg.conf just for=
 one parameter=C2=A0<br><br><div class=3D"gmail_quote"><div dir=3D"ltr">On =
Thu, 7 Jun 2018 at 08:31 Michel D=C3=A4nzer &lt;<a href=3D"mailto:michel@da=
enzer.net">michel-otUistvHUpPR7s880joybQ@public.gmane.org</a>&gt; wrote:<br></div><blockquote class=3D"=
gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-=
left:1ex">On 2018-06-07 09:22 AM, Mike Lothian wrote:<br>
&gt; Hi<br>
&gt; <br>
&gt; Is there a way to set depth using a xorg.conf.d snippet rather than<br=
>
&gt; creating an xorg.conf?<br>
<br>
Sure (the xorg.conf.d snippets are simply concatenated together with<br>
xorg.conf, so anything can go in either of them), but it&#39;s the wrong wa=
y<br>
to do it. :)<br>
<br>
The xorg.conf.d mechanism is for shipping snippets required for a driver<br=
>
or other Xorg module to work out of the box. xorg.conf is still the<br>
place for actual configuration.<br>
<br>
<br>
-- <br>
Earthling Michel D=C3=A4nzer=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0|=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0<a href=
=3D"http://www.amd.com" rel=3D"noreferrer" target=3D"_blank">http://www.amd=
.com</a><br>
Libre software enthusiast=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0Mesa and X developer<br>
</blockquote></div></div>

--000000000000f9f494056e0d3aa7--

--===============0497260487==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============0497260487==--
