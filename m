From: Mike Lothian <mike-4+n8WJKc9ve9FHfhHBbuYA@public.gmane.org>
Subject: Re: LLVM 7.0 + Wayland = broken mouse control
Date: Tue, 30 Jan 2018 16:52:34 +0000
Message-ID: <CAHbf0-ECicce-r8GbaPGWXxGB2RQr4HwSFkX1hFNjzST4Qf_jw@mail.gmail.com>
References: <CABXGCsMKWxAxDas=s2UxwydOYQ8TyEOCfR=0Mz0zGfgXxsnxcw@mail.gmail.com>
 <188aeb48-741c-0658-32f5-b12d6389b10c@amd.com>
 <BN4PR12MB08811DCADDC96DEDCAF61659F9E20@BN4PR12MB0881.namprd12.prod.outlook.com>
 <1517255915.3374.5.camel@gmail.com>
 <fa66db2b-0f75-e139-2fd9-ae42881d82df@daenzer.net>
 <1517329672.17945.4.camel@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1611916019=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <1517329672.17945.4.camel-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
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
To: mikhail <mikhail.v.gavrilov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: =?UTF-8?Q?Michel_D=C3=A4nzer?= <michel-otUistvHUpPR7s880joybQ@public.gmane.org>, "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

--===============1611916019==
Content-Type: multipart/alternative; boundary="001a1147e9a820b21d056401312c"

--001a1147e9a820b21d056401312c
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

I think you can set it by:

echo "allow_rgb10_configs=3Dfalse" >> /etc/environment

On Tue, 30 Jan 2018 at 16:38 mikhail <mikhail.v.gavrilov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:

> On Tue, 2018-01-30 at 11:55 +0100, Michel D=C3=A4nzer wrote:
> >
> > No, it just means there's an error in the way you're trying to set
> > the
> > workaround. Maybe it needs to be "export allow_rgb10_configs=3Dfalse"?
> >
> > You can also try the method I described in
> > https://bugs.freedesktop.org/show_bug.cgi?id=3D104808#c2 , I verified
> > that
> > to work.
> >
>
> You right, my mistake I forgot add export.
> Of cource right variant:
> echo "export allow_rgb10_configs=3Dfalse" > /etc/profile.d/gnome-
> workaround.sh
>
> Mouse click now works again with latest llvm and mesa.
> It is unfortunate I don't know how apply this variable to the login
> screen (gdm).
>
> Anyway, thanks.
> _______________________________________________
> amd-gfx mailing list
> amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
>

--001a1147e9a820b21d056401312c
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">I think you can set it by:<div><br></div><div>echo &quot;<=
span style=3D"color:rgb(117,117,117)">allow_rgb10_configs=3Dfalse&quot; &gt=
;&gt;=C2=A0</span><font color=3D"#757575">/etc/environment</font></div></di=
v><br><div class=3D"gmail_quote"><div dir=3D"ltr">On Tue, 30 Jan 2018 at 16=
:38 mikhail &lt;<a href=3D"mailto:mikhail.v.gavrilov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org">mikhail.v.g=
avrilov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote"=
 style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">On=
 Tue, 2018-01-30 at 11:55 +0100, Michel D=C3=A4nzer wrote:<br>
&gt;<br>
&gt; No, it just means there&#39;s an error in the way you&#39;re trying to=
 set<br>
&gt; the<br>
&gt; workaround. Maybe it needs to be &quot;export allow_rgb10_configs=3Dfa=
lse&quot;?<br>
&gt;<br>
&gt; You can also try the method I described in<br>
&gt; <a href=3D"https://bugs.freedesktop.org/show_bug.cgi?id=3D104808#c2" r=
el=3D"noreferrer" target=3D"_blank">https://bugs.freedesktop.org/show_bug.c=
gi?id=3D104808#c2</a> , I verified<br>
&gt; that<br>
&gt; to work.<br>
&gt;<br>
<br>
You right, my mistake I forgot add export.<br>
Of cource right variant:<br>
echo &quot;export allow_rgb10_configs=3Dfalse&quot; &gt; /etc/profile.d/gno=
me-<br>
workaround.sh<br>
<br>
Mouse click now works again with latest llvm and mesa.<br>
It is unfortunate I don&#39;t know how apply this variable to the login<br>
screen (gdm).<br>
<br>
Anyway, thanks.<br>
_______________________________________________<br>
amd-gfx mailing list<br>
<a href=3D"mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" target=3D"_blank">amd-gfx@=
lists.freedesktop.org</a><br>
<a href=3D"https://lists.freedesktop.org/mailman/listinfo/amd-gfx" rel=3D"n=
oreferrer" target=3D"_blank">https://lists.freedesktop.org/mailman/listinfo=
/amd-gfx</a><br>
</blockquote></div>

--001a1147e9a820b21d056401312c--

--===============1611916019==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============1611916019==--
