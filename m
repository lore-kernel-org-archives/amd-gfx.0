From: Ian Bashford <ian-/S0389TiWqnk1uMJSBkQmQ@public.gmane.org>
Subject: Re: Tonga Kernel Modesetting Issue
Date: Tue, 03 Apr 2018 08:12:23 +0000
Message-ID: <CAMqxyLNPnM+5xbu3c_CEGqhn18EXuXZSaC-2DBoxjYOxyzPcUA@mail.gmail.com>
References: <CAMqxyLMt=C5xUNuUCTfvXg9Zh_0CTGBPkPw8TNvs0688+7gqKg@mail.gmail.com>
 <CADnq5_PeHqAGVeiQkAcwMyLMse9OUA6tk+RcKNPMiKgvk5ZSmQ@mail.gmail.com>
Reply-To: ian-/S0389TiWqnk1uMJSBkQmQ@public.gmane.org
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0601077049=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <CADnq5_PeHqAGVeiQkAcwMyLMse9OUA6tk+RcKNPMiKgvk5ZSmQ-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
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
To: "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

--===============0601077049==
Content-Type: multipart/alternative; boundary="f403045c18d6c5a27e0568ed44a8"

--f403045c18d6c5a27e0568ed44a8
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Thanks Alex - I=E2=80=99ll try the latest kernels first and see where that =
gets me.
I=E2=80=99ll move on to trying to track down a commit if that fails...

It=E2=80=99s a dell 27=E2=80=9D monitor connected via DVI dual - nothing el=
se along the
path so a fairly straightforward setup.
Ian



On Mon, 2 Apr 2018 at 20:21, Alex Deucher <alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:

> On Mon, Apr 2, 2018 at 10:29 AM, Ian Bashford <ianbashford-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> wrote:
> > Hi,
> > I'm investigating an issue with KMS on my graphics card. I'm hoping thi=
s
> > list might give me some direction/guidance where to look.
> >
> > Sometime in between kernels 4.9 and 4.14, the KMS on my card stopped
> getting
> > set to 2560x1440 and only sets 1920x1080.  Passing video=3D as a kernel
> > parameter just leads to a black screen.
> > I've tried stock kernels on alpine and arch, and also compiled a few as
> > well; I can't see any obvious differences in the compile options that
> might
> > lead to the difference.
> > My next line of enquiry is to see if there's a change in amdgpu that
> might
> > be the cause.
> > Given the size of the codebase and the number of changes, I was hoping
> > someone might be able to help me narrow the possible search.
> >
> > Would you be able to suggest somewhere to begin ?
>
> If you can try a newer kernel (4.16 or 4.17rc), try enabling the new
> dc modeseting code (append amdgpu.dc=3D1 on the kernel command line in
> grub).
>
> What type of display (DVI, DP, etc.) is your monitor and what physical
> connector is it connected to on your board?  Are there any adapters
> between the card and the display?  Probably best to file a bug
> (https://bugs.freedesktop.org) and attach your xorg log and dmesg
> output in both the working and non working cases.
>
> The best way to sort this out would be to use git to bisect what
> commit caused the issue.
>
> Alex
>
> >
> > The card is a Sapphire R9 380X NITRO 4GB  - it identifies as a TONGA.
> >
> > During the boot, I get this message about the mode setting
> > [drm] initializing kernel modesetting (TONGA 0x1002:0x6938 0x174B:0xE30=
8
> > 0xF1)
> >
> > thanks
> > Ian
> >
> > _______________________________________________
> > amd-gfx mailing list
> > amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
> > https://lists.freedesktop.org/mailman/listinfo/amd-gfx
> >
> _______________________________________________
> amd-gfx mailing list
> amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
>
--=20

Cheers

Ian

--f403045c18d6c5a27e0568ed44a8
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div><div dir=3D"auto">Thanks Alex - I=E2=80=99ll try the latest kernels fi=
rst and see where that gets me.=C2=A0</div><div dir=3D"auto">I=E2=80=99ll m=
ove on to trying to track down a commit if that fails...</div><div dir=3D"a=
uto"><br></div><div dir=3D"auto">It=E2=80=99s a dell 27=E2=80=9D monitor co=
nnected via DVI dual - nothing else along the path so a fairly straightforw=
ard setup.=C2=A0</div><div dir=3D"auto">Ian=C2=A0</div><div dir=3D"auto"><b=
r></div><div dir=3D"auto"><br></div><br><div class=3D"gmail_quote"><div>On =
Mon, 2 Apr 2018 at 20:21, Alex Deucher &lt;<a href=3D"mailto:alexdeucher@gm=
ail.com">alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org</a>&gt; wrote:<br></div><blockquote class=3D=
"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding=
-left:1ex">On Mon, Apr 2, 2018 at 10:29 AM, Ian Bashford &lt;<a href=3D"mai=
lto:ianbashford-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org" target=3D"_blank">ianbashford-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org</a>&gt; =
wrote:<br>
&gt; Hi,<br>
&gt; I&#39;m investigating an issue with KMS on my graphics card. I&#39;m h=
oping this<br>
&gt; list might give me some direction/guidance where to look.<br>
&gt;<br>
&gt; Sometime in between kernels 4.9 and 4.14, the KMS on my card stopped g=
etting<br>
&gt; set to 2560x1440 and only sets 1920x1080.=C2=A0 Passing video=3D as a =
kernel<br>
&gt; parameter just leads to a black screen.<br>
&gt; I&#39;ve tried stock kernels on alpine and arch, and also compiled a f=
ew as<br>
&gt; well; I can&#39;t see any obvious differences in the compile options t=
hat might<br>
&gt; lead to the difference.<br>
&gt; My next line of enquiry is to see if there&#39;s a change in amdgpu th=
at might<br>
&gt; be the cause.<br>
&gt; Given the size of the codebase and the number of changes, I was hoping=
<br>
&gt; someone might be able to help me narrow the possible search.<br>
&gt;<br>
&gt; Would you be able to suggest somewhere to begin ?<br>
<br>
If you can try a newer kernel (4.16 or 4.17rc), try enabling the new<br>
dc modeseting code (append amdgpu.dc=3D1 on the kernel command line in<br>
grub).<br>
<br>
What type of display (DVI, DP, etc.) is your monitor and what physical<br>
connector is it connected to on your board?=C2=A0 Are there any adapters<br=
>
between the card and the display?=C2=A0 Probably best to file a bug<br>
(<a href=3D"https://bugs.freedesktop.org" rel=3D"noreferrer" target=3D"_bla=
nk">https://bugs.freedesktop.org</a>) and attach your xorg log and dmesg<br=
>
output in both the working and non working cases.<br>
<br>
The best way to sort this out would be to use git to bisect what<br>
commit caused the issue.<br>
<br>
Alex<br>
<br>
&gt;<br>
&gt; The card is a Sapphire R9 380X NITRO 4GB=C2=A0 - it identifies as a TO=
NGA.<br>
&gt;<br>
&gt; During the boot, I get this message about the mode setting<br>
&gt; [drm] initializing kernel modesetting (TONGA 0x1002:0x6938 0x174B:0xE3=
08<br>
&gt; 0xF1)<br>
&gt;<br>
&gt; thanks<br>
&gt; Ian<br>
&gt;<br>
&gt; _______________________________________________<br>
&gt; amd-gfx mailing list<br>
&gt; <a href=3D"mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" target=3D"_blank">amd=
-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org</a><br>
&gt; <a href=3D"https://lists.freedesktop.org/mailman/listinfo/amd-gfx" rel=
=3D"noreferrer" target=3D"_blank">https://lists.freedesktop.org/mailman/lis=
tinfo/amd-gfx</a><br>
&gt;<br>
_______________________________________________<br>
amd-gfx mailing list<br>
<a href=3D"mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" target=3D"_blank">amd-gfx@=
lists.freedesktop.org</a><br>
<a href=3D"https://lists.freedesktop.org/mailman/listinfo/amd-gfx" rel=3D"n=
oreferrer" target=3D"_blank">https://lists.freedesktop.org/mailman/listinfo=
/amd-gfx</a><br>
</blockquote></div></div>-- <br><div dir=3D"ltr" class=3D"gmail_signature" =
data-smartmail=3D"gmail_signature"><br>Cheers<br><br>Ian</div>

--f403045c18d6c5a27e0568ed44a8--

--===============0601077049==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============0601077049==--
