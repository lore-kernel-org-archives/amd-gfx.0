From: =?UTF-8?B?TWFyZWsgT2zFocOhaw==?= <maraeo-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: Plan: BO move throttling for visible VRAM evictions
Date: Wed, 17 May 2017 14:35:58 +0200
Message-ID: <CAAxE2A7mh7pmbbszk1qnChPxZtVMzRBWY2GkB1DEcrEZ0t5m3w@mail.gmail.com>
References: <CAAxE2A4ap8BoOEg1tOF+Ec1vBfZRSANOebikYBaHUfXokY7EwA@mail.gmail.com>
 <9220eda1-5176-36cd-e6b3-801c3e4f759a@daenzer.net>
 <78989271-9812-f891-3a00-0d5b39a06b7c@daenzer.net>
 <CAAxE2A60hubc8jbZkO101sxqVZKR8iub=GsfRovj17+P2zKDKQ@mail.gmail.com>
 <aee1e2b7-dd00-e24b-bcfc-e2299e31908b@daenzer.net>
 <CAAxE2A5g7tJG+94XxPr-mdGXkeL1GPMNMaYgc7ATEk7pxsiXfA@mail.gmail.com>
 <c343b89c-318f-d3af-d02e-4e6843c422f6@daenzer.net>
 <CAAxE2A5_tiOEvLVegNvkuvYrFcsU52H6EfCff3faKBZwPfbuYQ@mail.gmail.com>
 <a5a8428e-444a-34b9-7fa9-60e77582819a@daenzer.net>
 <CAAxE2A4ex4e-5ShqesZ8oXJj1CnmH6Enhvu4fXs9kDKu9NHeiQ@mail.gmail.com>
 <78fe31b2-2a0a-a1af-6af8-954d892e34ba@daenzer.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0749648418=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <78fe31b2-2a0a-a1af-6af8-954d892e34ba-otUistvHUpPR7s880joybQ@public.gmane.org>
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

--===============0749648418==
Content-Type: multipart/alternative; boundary="001a11404faecaa6cc054fb78745"

--001a11404faecaa6cc054fb78745
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On May 16, 2017 3:57 AM, "Michel D=C3=A4nzer" <michel-otUistvHUpPR7s880joybQ@public.gmane.org> wrote:

On 15/05/17 07:11 PM, Marek Ol=C5=A1=C3=A1k wrote:
> On May 15, 2017 4:29 AM, "Michel D=C3=A4nzer" <michel-otUistvHUpPR7s880joybQ@public.gmane.org
> <mailto:michel-otUistvHUpPR7s880joybQ@public.gmane.org>> wrote:
>
>     I think the next step should be to make radeonsi keep track of how
much
>     VRAM it's trying to use that's expected to be accessed by the CPU, an=
d
>     to use GTT instead when that exceeds a threshold (probably derived
from
>     vram_vis_size).
>
> That's difficult to estimate. There are apps with 600MB of mapped VRAM
> and don't experience any performance issues. And some apps with 300MB of
> mapped VRAM do. It only depends on the CPU access pattern, not what
> radeonsi sees.

What I mean is keeping track of the total size of resources which have
RADEON_DOMAIN_VRAM and RADEON_FLAG_CPU_ACCESS set, and if it exceeds a
threshold, create new ones having those flags in GTT instead. Even
though this might not be strictly necessary with amdgpu in the long run,
it probably is for radeon anyway, and in the short term it might help
even with amdgpu.


That might hurt us more than it can help. All mappable buffers have the CPU
access flag set, but many of them are immutable.

The only place where this can be handled=E2=80=8B is the kernel. Even if it=
's as
simple as: if (bo->numcpufaults > 10) domain =3D GTT_WC;

Marek



--
Earthling Michel D=C3=A4nzer               |               http://www.amd.c=
om
Libre software enthusiast             |             Mesa and X developer

--001a11404faecaa6cc054fb78745
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div><br><div class=3D"gmail_extra"><br><div class=3D"gma=
il_quote">On May 16, 2017 3:57 AM, &quot;Michel D=C3=A4nzer&quot; &lt;<a hr=
ef=3D"mailto:michel-otUistvHUpPR7s880joybQ@public.gmane.org">michel-otUistvHUpPR7s880joybQ@public.gmane.org</a>&gt; wrote:<br type=
=3D"attribution"><blockquote class=3D"quote" style=3D"margin:0 0 0 .8ex;bor=
der-left:1px #ccc solid;padding-left:1ex"><div class=3D"quoted-text">On 15/=
05/17 07:11 PM, Marek Ol=C5=A1=C3=A1k wrote:<br>
&gt; On May 15, 2017 4:29 AM, &quot;Michel D=C3=A4nzer&quot; &lt;<a href=3D=
"mailto:michel-otUistvHUpPR7s880joybQ@public.gmane.org">michel-otUistvHUpPR7s880joybQ@public.gmane.org</a><br>
</div><div class=3D"quoted-text">&gt; &lt;mailto:<a href=3D"mailto:michel@d=
aenzer.net">michel-otUistvHUpPR7s880joybQ@public.gmane.org</a>&gt;&gt; wrote:<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0I think the next step should be to make radeonsi ke=
ep track of how much<br>
&gt;=C2=A0 =C2=A0 =C2=A0VRAM it&#39;s trying to use that&#39;s expected to =
be accessed by the CPU, and<br>
&gt;=C2=A0 =C2=A0 =C2=A0to use GTT instead when that exceeds a threshold (p=
robably derived from<br>
&gt;=C2=A0 =C2=A0 =C2=A0vram_vis_size).<br>
&gt;<br>
&gt; That&#39;s difficult to estimate. There are apps with 600MB of mapped =
VRAM<br>
&gt; and don&#39;t experience any performance issues. And some apps with 30=
0MB of<br>
&gt; mapped VRAM do. It only depends on the CPU access pattern, not what<br=
>
&gt; radeonsi sees.<br>
<br>
</div>What I mean is keeping track of the total size of resources which hav=
e<br>
RADEON_DOMAIN_VRAM and RADEON_FLAG_CPU_ACCESS set, and if it exceeds a<br>
threshold, create new ones having those flags in GTT instead. Even<br>
though this might not be strictly necessary with amdgpu in the long run,<br=
>
it probably is for radeon anyway, and in the short term it might help<br>
even with amdgpu.<br></blockquote></div></div></div><div dir=3D"auto"><br><=
/div><div dir=3D"auto">That might hurt us more than it can help. All mappab=
le buffers have the CPU access flag set, but many of them are immutable.</d=
iv><div dir=3D"auto"><br></div><div dir=3D"auto">The only place where this =
can be handled=E2=80=8B is the kernel. Even if it&#39;s as simple as: if (b=
o-&gt;numcpufaults &gt; 10) domain =3D GTT_WC;</div><div dir=3D"auto"><br><=
/div><div dir=3D"auto">Marek</div><div dir=3D"auto"><br></div><div dir=3D"a=
uto"><div class=3D"gmail_extra"><div class=3D"gmail_quote"><blockquote clas=
s=3D"quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-l=
eft:1ex">
<div class=3D"elided-text"><br>
<br>
--<br>
Earthling Michel D=C3=A4nzer=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0|=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0<a href=
=3D"http://www.amd.com" rel=3D"noreferrer" target=3D"_blank">http://www.amd=
.com</a><br>
Libre software enthusiast=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0Mesa and X developer<br>
</div></blockquote></div><br></div></div></div>

--001a11404faecaa6cc054fb78745--

--===============0749648418==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============0749648418==--
