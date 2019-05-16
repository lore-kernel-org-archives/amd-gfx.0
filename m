From: Daniel Kasak <d.j.kasak.dk-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: Hard lockups with ROCM
Date: Thu, 16 May 2019 21:52:32 +1000
Message-ID: <CAF73Y=TfsjO+-cnvzZ8s7VnuCTcu3KT0ZG3KtzbYGTTYKK-PzA@mail.gmail.com>
References: <CAF73Y=QuYq3ALtP6xiPyqS+jm_TJCQQDyQ+WA5ZJG8EhWSKiTw@mail.gmail.com>
 <CAF73Y=R96zUxCAEKopSvGReqB+sEFWcHhXSKnR98rpetMbKf4Q@mail.gmail.com>
 <CADnq5_OOEP+YsQx12cOBaM3NdjM=eGAbbbudEusqf5rNRz8C2Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0384001323=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <CADnq5_OOEP+YsQx12cOBaM3NdjM=eGAbbbudEusqf5rNRz8C2Q-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
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
To: Alex Deucher <alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: amd-gfx list <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

--===============0384001323==
Content-Type: multipart/alternative; boundary="0000000000007b98f80588ffe9c2"

--0000000000007b98f80588ffe9c2
Content-Type: text/plain; charset="UTF-8"

On Thu, May 16, 2019 at 11:43 AM Alex Deucher <alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:

> On Wed, May 15, 2019 at 8:33 PM Daniel Kasak <d.j.kasak.dk-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> wrote:
> >
> > On Mon, May 13, 2019 at 11:44 AM Daniel Kasak <d.j.kasak.dk-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> wrote:
> >>
> >> Hi all. I had version 2.2.0 of the ROCM stack running on a 5.0.x and
> 5.1.0 kernel. Things were going great with various boinc GPU tasks. But
> there is a setiathome GPU task which reliably gives me a hard lockup within
> about 30 minutes of running. I actually had to do *two* emergency
> re-installs over the past week. Perhaps part of this was my fault ( running
> btrfs with lzo compression on my root partition ... ). But absolutely part
> of this was the hard lockups. I've tested all kinds of other things ( eg
> rebuilding lots of stuff under Gentoo ) ... I don't have a general
> stability issue even under hours of high load. But after restarting boinc
> with that same setiathome task ... <bang>!
> >>
> >> If someone wants me to sacrifice another installation, they can point
> me to instructions for trying to gather more information.
> >>
> >> Anyway ... perhaps more work around detecting and recovering from GPU
> lockups is in order?
> >>
> >> Dan
> >
> >
> > <sigh>
> >
> > That's what I was afraid of :(
>
> Not sure what you were afraid of.  I don't think anyone has looked at
> setiathome on ROCm.  I'd suggest filing a bug
> (https://bugs.freedesktop.org) and attaching your dmesg output and
> xorg log (if using X).  If there is a GPU reset, note that you will
> need to restart your desktop environment because currently neither
> glamor or any compositors support GL robustness extensions to reset
> their contexts after a GPU reset.
>
> Alex
>

Hi Alex. dmesg output is not available ... this is a *hard* lockup. I need
to power-cycle after it happens ( ALT + SysRq + { S , U , B } doesn't even
work ). That's why I asked for instructions to possibly gather more info. I
did check the xorg log after I did an emergency export of my filesystem ...
nothing of interest in there. It seems like I currently don't really have
enough info to make a bug report worthwhile.

Dan

--0000000000007b98f80588ffe9c2
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail=
_attr">On Thu, May 16, 2019 at 11:43 AM Alex Deucher &lt;<a href=3D"mailto:=
alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org">alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org</a>&gt; wrote:<br></div><block=
quote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1=
px solid rgb(204,204,204);padding-left:1ex">On Wed, May 15, 2019 at 8:33 PM=
 Daniel Kasak &lt;<a href=3D"mailto:d.j.kasak.dk-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org" target=3D"_blan=
k">d.j.kasak.dk-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org</a>&gt; wrote:<br>
&gt;<br>
&gt; On Mon, May 13, 2019 at 11:44 AM Daniel Kasak &lt;<a href=3D"mailto:d.=
j.kasak.dk-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org" target=3D"_blank">d.j.kasak.dk-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org</a>&gt; wrot=
e:<br>
&gt;&gt;<br>
&gt;&gt; Hi all. I had version 2.2.0 of the ROCM stack running on a 5.0.x a=
nd 5.1.0 kernel. Things were going great with various boinc GPU tasks. But =
there is a setiathome GPU task which reliably gives me a hard lockup within=
 about 30 minutes of running. I actually had to do *two* emergency re-insta=
lls over the past week. Perhaps part of this was my fault ( running btrfs w=
ith lzo compression on my root partition ... ). But absolutely part of this=
 was the hard lockups. I&#39;ve tested all kinds of other things ( eg rebui=
lding lots of stuff under Gentoo ) ... I don&#39;t have a general stability=
 issue even under hours of high load. But after restarting boinc with that =
same setiathome task ... &lt;bang&gt;!<br>
&gt;&gt;<br>
&gt;&gt; If someone wants me to sacrifice another installation, they can po=
int me to instructions for trying to gather more information.<br>
&gt;&gt;<br>
&gt;&gt; Anyway ... perhaps more work around detecting and recovering from =
GPU lockups is in order?<br>
&gt;&gt;<br>
&gt;&gt; Dan<br>
&gt;<br>
&gt;<br>
&gt; &lt;sigh&gt;<br>
&gt;<br>
&gt; That&#39;s what I was afraid of :(<br>
<br>
Not sure what you were afraid of.=C2=A0 I don&#39;t think anyone has looked=
 at<br>
setiathome on ROCm.=C2=A0 I&#39;d suggest filing a bug<br>
(<a href=3D"https://bugs.freedesktop.org" rel=3D"noreferrer" target=3D"_bla=
nk">https://bugs.freedesktop.org</a>) and attaching your dmesg output and<b=
r>
xorg log (if using X).=C2=A0 If there is a GPU reset, note that you will<br=
>
need to restart your desktop environment because currently neither<br>
glamor or any compositors support GL robustness extensions to reset<br>
their contexts after a GPU reset.<br>
<br>
Alex<br></blockquote><div><br></div><div>Hi Alex. dmesg output is not avail=
able ... this is a *hard* lockup. I need to power-cycle after it happens ( =
ALT=C2=A0<a class=3D"gmail_plusreply" id=3D"plusReplyChip-0">+</a> SysRq=C2=
=A0+ { S , U , B } doesn&#39;t even work ). That&#39;s why I asked for inst=
ructions to possibly gather more info. I did check the xorg log after I did=
 an emergency export of my filesystem ... nothing of interest in there. It =
seems like I currently don&#39;t really have enough info to make a bug repo=
rt worthwhile.</div><div><br></div><div>Dan<br></div></div></div>

--0000000000007b98f80588ffe9c2--

--===============0384001323==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4

--===============0384001323==--
