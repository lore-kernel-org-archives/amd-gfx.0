From: Dawson Dias <thexerothermicsclerodermoid-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: Ryzen 5 2400G Stuttering since 2018-03-07
Date: Fri, 16 Mar 2018 00:17:46 +0530
Message-ID: <CAFuwKQOzsAXk8AJm+CNs3M3mcYoWsW+PxxgBO79ePST3C5kgBQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1513115215=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
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
To: Harry Wentland <harry.wentland-5C7GfCeVMHo@public.gmane.org>, =?UTF-8?Q?Michel_D=C3=A4nzer?= <michel-otUistvHUpPR7s880joybQ@public.gmane.org>
Cc: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org

--===============1513115215==
Content-Type: multipart/alternative; boundary="000000000000ba80ed056777eed1"

--000000000000ba80ed056777eed1
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

I created a ticket: https://bugs.freedesktop.org/show_bug.cgi?id=3D105530
Let me know if there is any additional information I need to add.

Thanks!

-Dawson Dias

On Thu, Mar 15, 2018 at 8:44 PM, Harry Wentland <harry.wentland-5C7GfCeVMHo@public.gmane.org>
wrote:

> On 2018-03-15 11:01 AM, Michel D=C3=A4nzer wrote:
> > On 2018-03-15 03:47 PM, Dawson Dias wrote:
> >> Here we go! The logs are attached. I turned TearFree to `on` from
> >> `auto`, dragged some windows around, and captured them.
> >> AFAIK, I haven't made any changes via xrandr, except for toggling the
> >> TearFree property.
> >
> > Thanks. I don't see any obvious issue in your attachments. I think it's
> > most likely a kernel DC issue. I saw Harry just filed an internal bug
> > report that might be related.
> >
>
> I'm not sure the internal bug is related here, but it could be. I noticed
> problems when Freesync testing but I assume it was a much older regressio=
n.
> I haven't seen flickering on normal desktop but I haven't played with Rav=
en
> recently or tried TearFree recently.
>
> Dawson, mind opening a ticket on https://bugs.freedesktop.org/ to track
> this?
>
> Harry
>
> >
>

--000000000000ba80ed056777eed1
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><font face=3D"arial, helvetica, sans-serif">I created a ti=
cket:=C2=A0<a href=3D"https://bugs.freedesktop.org/show_bug.cgi?id=3D105530=
">https://bugs.freedesktop.org/show_bug.cgi?id=3D105530</a></font><div><fon=
t face=3D"arial, helvetica, sans-serif">Let me know if there is any additio=
nal information I need to add.</font></div><div><font face=3D"arial, helvet=
ica, sans-serif"><br></font></div><div><font face=3D"arial, helvetica, sans=
-serif">Thanks!<br></font><div><div class=3D"gmail_extra"><font face=3D"ari=
al, helvetica, sans-serif"><br clear=3D"all"></font><div><div class=3D"gmai=
l_signature"><div dir=3D"ltr"><div><div dir=3D"ltr"><font face=3D"arial, he=
lvetica, sans-serif">-Dawson Dias</font><br></div></div></div></div></div>
<br><div class=3D"gmail_quote">On Thu, Mar 15, 2018 at 8:44 PM, Harry Wentl=
and <span dir=3D"ltr">&lt;<a href=3D"mailto:harry.wentland-5C7GfCeVMHo@public.gmane.org" target=
=3D"_blank">harry.wentland-5C7GfCeVMHo@public.gmane.org</a>&gt;</span> wrote:<br><blockquote cla=
ss=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid =
rgb(204,204,204);padding-left:1ex"><span class=3D"gmail-">On 2018-03-15 11:=
01 AM, Michel D=C3=A4nzer wrote:<br>
&gt; On 2018-03-15 03:47 PM, Dawson Dias wrote:<br>
&gt;&gt; Here we go! The logs are attached. I turned TearFree to `on` from<=
br>
&gt;&gt; `auto`, dragged some windows around, and captured them.<br>
&gt;&gt; AFAIK, I haven&#39;t made any changes via xrandr, except for toggl=
ing the<br>
&gt;&gt; TearFree property.<br>
&gt;<br>
&gt; Thanks. I don&#39;t see any obvious issue in your attachments. I think=
 it&#39;s<br>
&gt; most likely a kernel DC issue. I saw Harry just filed an internal bug<=
br>
&gt; report that might be related.<br>
&gt;<br>
<br>
</span>I&#39;m not sure the internal bug is related here, but it could be. =
I noticed problems when Freesync testing but I assume it was a much older r=
egression. I haven&#39;t seen flickering on normal desktop but I haven&#39;=
t played with Raven recently or tried TearFree recently.<br>
<br>
Dawson, mind opening a ticket on <a href=3D"https://bugs.freedesktop.org/" =
rel=3D"noreferrer" target=3D"_blank">https://bugs.freedesktop.org/</a> to t=
rack this?<br>
<br>
Harry<br>
<br>
&gt;<br>
</blockquote></div><br></div></div></div></div>

--000000000000ba80ed056777eed1--

--===============1513115215==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============1513115215==--
