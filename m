From: Julien Isorce <julien.isorce@gmail.com>
Subject: Re: [PATCH] Revert "drm/radeon: Try evicting from CPU accessible to
 inaccessible VRAM first"
Date: Fri, 24 Mar 2017 18:59:03 +0000
Message-ID: <CAHWPjbXf1Js+gVWUKSKsereimmi3nduKsn3qEVC3YC=4dqNCzw@mail.gmail.com>
References: <1490206797-15653-1-git-send-email-zmichaels@oblong.com>
 <c56f4a6a-a17d-b9b0-311e-7100df8c7cee@daenzer.net>
 <CAGCDoEGuMVnv6rA-y5XDbc6hiNWiTg6nt4e4u2dZObeY8roKXA@mail.gmail.com>
 <8020e778-c9c8-e67b-428a-436f2f1c0d7b@daenzer.net>
 <CAHWPjbXbAo8CVSJDK1GzN=M4pMobMw9XVQVfVeGVM4H=n36vuQ@mail.gmail.com>
 <219c6e11-09d9-d2aa-a04d-20074b4a409b@daenzer.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1067479865=="
Return-path: <dri-devel-bounces@lists.freedesktop.org>
In-Reply-To: <219c6e11-09d9-d2aa-a04d-20074b4a409b@daenzer.net>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
To: =?UTF-8?Q?Michel_D=C3=A4nzer?= <michel@daenzer.net>
Cc: dri-devel@lists.freedesktop.org, Zachary Michaels <zmichaels@oblong.com>, Julien Isorce <jisorce@oblong.com>, amd-gfx@lists.freedesktop.org
List-Id: amd-gfx.lists.freedesktop.org

--===============1067479865==
Content-Type: multipart/alternative; boundary=001a11c01bca626368054b7e96d3

--001a11c01bca626368054b7e96d3
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi Michel,

I double checked and you are right, the change 0 -> i works.

Cheers
Julien

On 24 March 2017 at 09:59, Michel D=C3=A4nzer <michel@daenzer.net> wrote:

> On 24/03/17 06:50 PM, Julien Isorce wrote:
> > Hi Michel,
> >
> > (Just for other readers my reply has been delayed on the mailing lists
> > and should have been on second position)
>
> It is on https://patchwork.freedesktop.org/patch/145731/ , did you mean
> something else?
>
> The delay was because you weren't subscribed to the amd-gfx mailing list
> yet, so your post went through the moderation queue.
>
>
> > I will have a go with that change and let you know. I do not remember i=
f
> > I tried it for this soft lockup. But for sure it does not solve the har=
d
> > lockup that Zach also mentioned at the end of his reply.
>
> I'll follow up to his post about that.
>
>
> > But in general, isn't "radeon_lockup_timeout" supposed to detect this
> > situation ?
>
> No, it's for detecting GPU hangs, whereas this is a CPU "hang" (infinite
> loop).
>
>
> --
> Earthling Michel D=C3=A4nzer               |               http://www.amd=
.com
> Libre software enthusiast             |             Mesa and X developer
>

--001a11c01bca626368054b7e96d3
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi Michel,<div><br></div><div>I double checked and you are=
 right, the change 0 -&gt; i works.=C2=A0</div><div><br></div><div>Cheers</=
div><div>Julien</div></div><div class=3D"gmail_extra"><br><div class=3D"gma=
il_quote">On 24 March 2017 at 09:59, Michel D=C3=A4nzer <span dir=3D"ltr">&=
lt;<a href=3D"mailto:michel@daenzer.net" target=3D"_blank">michel@daenzer.n=
et</a>&gt;</span> wrote:<br><blockquote class=3D"gmail_quote" style=3D"marg=
in:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex"><span class=3D""=
>On 24/03/17 06:50 PM, Julien Isorce wrote:<br>
&gt; Hi Michel,<br>
&gt;<br>
</span><span class=3D"">&gt; (Just for other readers my reply has been dela=
yed on the mailing lists<br>
&gt; and should have been on second position)<br>
<br>
</span>It is on <a href=3D"https://patchwork.freedesktop.org/patch/145731/"=
 rel=3D"noreferrer" target=3D"_blank">https://patchwork.freedesktop.<wbr>or=
g/patch/145731/</a> , did you mean<br>
something else?<br>
<br>
The delay was because you weren&#39;t subscribed to the amd-gfx mailing lis=
t<br>
yet, so your post went through the moderation queue.<br>
<span class=3D""><br>
<br>
&gt; I will have a go with that change and let you know. I do not remember =
if<br>
&gt; I tried it for this soft lockup. But for sure it does not solve the ha=
rd<br>
&gt; lockup that Zach also mentioned at the end of his reply.<br>
<br>
</span>I&#39;ll follow up to his post about that.<br>
<span class=3D""><br>
<br>
&gt; But in general, isn&#39;t &quot;radeon_lockup_timeout&quot; supposed t=
o detect this<br>
&gt; situation ?<br>
<br>
</span>No, it&#39;s for detecting GPU hangs, whereas this is a CPU &quot;ha=
ng&quot; (infinite<br>
loop).<br>
<div class=3D"HOEnZb"><div class=3D"h5"><br>
<br>
--<br>
Earthling Michel D=C3=A4nzer=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0|=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0<a href=
=3D"http://www.amd.com" rel=3D"noreferrer" target=3D"_blank">http://www.amd=
.com</a><br>
Libre software enthusiast=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0Mesa and X developer<br>
</div></div></blockquote></div><br></div>

--001a11c01bca626368054b7e96d3--

--===============1067479865==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KZHJpLWRldmVs
IG1haWxpbmcgbGlzdApkcmktZGV2ZWxAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlz
dHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vZHJpLWRldmVsCg==

--===============1067479865==--
