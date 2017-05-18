From: =?UTF-8?B?TWFyZWsgT2zFocOhaw==?= <maraeo-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: Plan: BO move throttling for visible VRAM evictions
Date: Thu, 18 May 2017 12:22:06 +0200
Message-ID: <CAAxE2A5L3vRth0dL=niTUR=M5i7_VmP4FEUPBeaEjtY8cveOmw@mail.gmail.com>
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
 <CAAxE2A7mh7pmbbszk1qnChPxZtVMzRBWY2GkB1DEcrEZ0t5m3w@mail.gmail.com>
 <4548bad6-2dc9-29be-b62e-33c181db77af@daenzer.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1102978416=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <4548bad6-2dc9-29be-b62e-33c181db77af-otUistvHUpPR7s880joybQ@public.gmane.org>
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

--===============1102978416==
Content-Type: multipart/alternative; boundary="001a11402d3adcd825054fc9c684"

--001a11402d3adcd825054fc9c684
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On May 18, 2017 10:17 AM, "Michel D=C3=A4nzer" <michel-otUistvHUpPR7s880joybQ@public.gmane.org> wrote:

On 17/05/17 09:35 PM, Marek Ol=C5=A1=C3=A1k wrote:
> On May 16, 2017 3:57 AM, "Michel D=C3=A4nzer" <michel-otUistvHUpPR7s880joybQ@public.gmane.org
> <mailto:michel-otUistvHUpPR7s880joybQ@public.gmane.org>> wrote:
>     On 15/05/17 07:11 PM, Marek Ol=C5=A1=C3=A1k wrote:
>     > On May 15, 2017 4:29 AM, "Michel D=C3=A4nzer" <michel-otUistvHUpPR7s880joybQ@public.gmane.org
>     <mailto:michel-otUistvHUpPR7s880joybQ@public.gmane.org>
>     > <mailto:michel-otUistvHUpPR7s880joybQ@public.gmane.org <mailto:michel-otUistvHUpPR7s880joybQ@public.gmane.org>>> wrote:
>     >
>     >     I think the next step should be to make radeonsi keep track of
>     how much
>     >     VRAM it's trying to use that's expected to be accessed by the
>     CPU, and
>     >     to use GTT instead when that exceeds a threshold (probably
>     derived from
>     >     vram_vis_size).
>     >
>     > That's difficult to estimate. There are apps with 600MB of mapped
VRAM
>     > and don't experience any performance issues. And some apps with
>     300MB of
>     > mapped VRAM do. It only depends on the CPU access pattern, not what
>     > radeonsi sees.
>
>     What I mean is keeping track of the total size of resources which hav=
e
>     RADEON_DOMAIN_VRAM and RADEON_FLAG_CPU_ACCESS set, and if it exceeds =
a
>     threshold, create new ones having those flags in GTT instead. Even
>     though this might not be strictly necessary with amdgpu in the long
run,
>     it probably is for radeon anyway, and in the short term it might help
>     even with amdgpu.
>
>
> That might hurt us more than it can help.

You may be right, but I think I'll play with that idea a little anyway
to see how it goes. :)

> All mappable buffers have the CPU access flag set, but many of them are
> immutable.

You mean they're only written to once by the CPU? We shouldn't set the
RADEON_FLAG_CPU_ACCESS flag for BOs where we expect that, because it
will currently prevent them from being in the CPU invisible part of VRAM.


The only thing I can do is set the CPU access flag for persistently mapped
buffers only. We certainly want buffers to go to the invisible part of VRAM
if there is no CPU access for a certain timeframe. So maybe we shouldn't
set the flag at all. What do you thing?

The truth is we have no way to know what apps intend to do with any buffers=
.



> The only place where this can be handled=E2=80=8B is the kernel.

Ideally, the placement of a BO should be determined based on how it's
actually being used by the GPU vs CPU. But I'm not sure how to determine
that in a useful way.


CPU page faults are the only way to determine that CPU access is happening.


> Even if it's as simple as: if (bo->numcpufaults > 10) domain =3D GTT_WC;

I'm skeptical about the number of CPU page faults per se being a useful
metric. It doesn't tell us much about how the BO is used even by the
CPU, let alone the GPU. But let's see where this leads you.


It tells us more than what Mesa can ever know, which is nothing.

Marek



One thing that might help would be if we could swap individual memory
nodes between visible and invisible VRAM for CPU page faults, instead of
moving/evicting whole BOs. Christian, do you think something like that
would be possible?


Another idea (to avoid issues such as the recent one with Rocket League)
was to make VRAM CPU mappings write-only, and move the BO to GTT if
there's a read fault. But not sure if this is possible at all, or how
much effort it would be.


--
Earthling Michel D=C3=A4nzer               |               http://www.amd.c=
om
Libre software enthusiast             |             Mesa and X developer

--001a11402d3adcd825054fc9c684
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div><br><div class=3D"gmail_extra"><br><div class=3D"gma=
il_quote">On May 18, 2017 10:17 AM, &quot;Michel D=C3=A4nzer&quot; &lt;<a h=
ref=3D"mailto:michel-otUistvHUpPR7s880joybQ@public.gmane.org">michel-otUistvHUpPR7s880joybQ@public.gmane.org</a>&gt; wrote:<br type=
=3D"attribution"><blockquote class=3D"quote" style=3D"margin:0 0 0 .8ex;bor=
der-left:1px #ccc solid;padding-left:1ex"><div class=3D"quoted-text">On 17/=
05/17 09:35 PM, Marek Ol=C5=A1=C3=A1k wrote:<br>
&gt; On May 16, 2017 3:57 AM, &quot;Michel D=C3=A4nzer&quot; &lt;<a href=3D=
"mailto:michel-otUistvHUpPR7s880joybQ@public.gmane.org">michel-otUistvHUpPR7s880joybQ@public.gmane.org</a><br>
</div><div class=3D"quoted-text">&gt; &lt;mailto:<a href=3D"mailto:michel@d=
aenzer.net">michel-otUistvHUpPR7s880joybQ@public.gmane.org</a>&gt;&gt; wrote:<br>
&gt;=C2=A0 =C2=A0 =C2=A0On 15/05/17 07:11 PM, Marek Ol=C5=A1=C3=A1k wrote:<=
br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; On May 15, 2017 4:29 AM, &quot;Michel D=C3=A4n=
zer&quot; &lt;<a href=3D"mailto:michel-otUistvHUpPR7s880joybQ@public.gmane.org">michel-otUistvHUpPR7s880joybQ@public.gmane.org</a><=
br>
&gt;=C2=A0 =C2=A0 =C2=A0&lt;mailto:<a href=3D"mailto:michel-otUistvHUpPR7s880joybQ@public.gmane.org">mi=
chel-otUistvHUpPR7s880joybQ@public.gmane.org</a>&gt;<br>
</div><div class=3D"quoted-text">&gt;=C2=A0 =C2=A0 =C2=A0&gt; &lt;mailto:<a=
 href=3D"mailto:michel-otUistvHUpPR7s880joybQ@public.gmane.org">michel-otUistvHUpPR7s880joybQ@public.gmane.org</a> &lt;mailto:<a hr=
ef=3D"mailto:michel-otUistvHUpPR7s880joybQ@public.gmane.org">michel-otUistvHUpPR7s880joybQ@public.gmane.org</a>&gt;&gt;&gt; wrote:<=
br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0I think the next step shoul=
d be to make radeonsi keep track of<br>
&gt;=C2=A0 =C2=A0 =C2=A0how much<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0VRAM it&#39;s trying to use=
 that&#39;s expected to be accessed by the<br>
&gt;=C2=A0 =C2=A0 =C2=A0CPU, and<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0to use GTT instead when tha=
t exceeds a threshold (probably<br>
&gt;=C2=A0 =C2=A0 =C2=A0derived from<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0vram_vis_size).<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; That&#39;s difficult to estimate. There are ap=
ps with 600MB of mapped VRAM<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; and don&#39;t experience any performance issue=
s. And some apps with<br>
&gt;=C2=A0 =C2=A0 =C2=A0300MB of<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; mapped VRAM do. It only depends on the CPU acc=
ess pattern, not what<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; radeonsi sees.<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0What I mean is keeping track of the total size of r=
esources which have<br>
&gt;=C2=A0 =C2=A0 =C2=A0RADEON_DOMAIN_VRAM and RADEON_FLAG_CPU_ACCESS set, =
and if it exceeds a<br>
&gt;=C2=A0 =C2=A0 =C2=A0threshold, create new ones having those flags in GT=
T instead. Even<br>
&gt;=C2=A0 =C2=A0 =C2=A0though this might not be strictly necessary with am=
dgpu in the long run,<br>
&gt;=C2=A0 =C2=A0 =C2=A0it probably is for radeon anyway, and in the short =
term it might help<br>
&gt;=C2=A0 =C2=A0 =C2=A0even with amdgpu.<br>
&gt;<br>
&gt;<br>
&gt; That might hurt us more than it can help.<br>
<br>
</div>You may be right, but I think I&#39;ll play with that idea a little a=
nyway<br>
to see how it goes. :)<br>
<div class=3D"quoted-text"><br>
&gt; All mappable buffers have the CPU access flag set, but many of them ar=
e<br>
&gt; immutable.<br>
<br>
</div>You mean they&#39;re only written to once by the CPU? We shouldn&#39;=
t set the<br>
RADEON_FLAG_CPU_ACCESS flag for BOs where we expect that, because it<br>
will currently prevent them from being in the CPU invisible part of VRAM.<b=
r></blockquote></div></div></div><div dir=3D"auto"><br></div><div dir=3D"au=
to">The only thing I can do is set the CPU access flag for persistently map=
ped buffers only. We certainly want buffers to go to the invisible part of =
VRAM if there is no CPU access for a certain timeframe. So maybe we shouldn=
&#39;t set the flag at all. What do you thing?</div><div dir=3D"auto"><br><=
/div><div dir=3D"auto">The truth is we have no way to know what apps intend=
 to do with any buffers.</div><div dir=3D"auto"><br></div><div dir=3D"auto"=
><div class=3D"gmail_extra"><div class=3D"gmail_quote"><blockquote class=3D=
"quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:=
1ex">
<div class=3D"quoted-text"><br>
<br>
&gt; The only place where this can be handled=E2=80=8B is the kernel.<br>
<br>
</div>Ideally, the placement of a BO should be determined based on how it&#=
39;s<br>
actually being used by the GPU vs CPU. But I&#39;m not sure how to determin=
e<br>
that in a useful way.<br></blockquote></div></div></div><div dir=3D"auto"><=
br></div><div dir=3D"auto">CPU page faults are the only way to determine th=
at CPU access is happening.</div><div dir=3D"auto"><br></div><div dir=3D"au=
to"><div class=3D"gmail_extra"><div class=3D"gmail_quote"><blockquote class=
=3D"quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-le=
ft:1ex">
<div class=3D"quoted-text"><br>
&gt; Even if it&#39;s as simple as: if (bo-&gt;numcpufaults &gt; 10) domain=
 =3D GTT_WC;<br>
<br>
</div>I&#39;m skeptical about the number of CPU page faults per se being a =
useful<br>
metric. It doesn&#39;t tell us much about how the BO is used even by the<br=
>
CPU, let alone the GPU. But let&#39;s see where this leads you.<br></blockq=
uote></div></div></div><div dir=3D"auto"><br></div><div dir=3D"auto">It tel=
ls us more than what Mesa can ever know, which is nothing.</div><div dir=3D=
"auto"><br></div><div dir=3D"auto">Marek</div><div dir=3D"auto"><br></div><=
div dir=3D"auto"><div class=3D"gmail_extra"><div class=3D"gmail_quote"><blo=
ckquote class=3D"quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc sol=
id;padding-left:1ex">
<br>
<br>
One thing that might help would be if we could swap individual memory<br>
nodes between visible and invisible VRAM for CPU page faults, instead of<br=
>
moving/evicting whole BOs. Christian, do you think something like that<br>
would be possible?<br>
<br>
<br>
Another idea (to avoid issues such as the recent one with Rocket League)<br=
>
was to make VRAM CPU mappings write-only, and move the BO to GTT if<br>
there&#39;s a read fault. But not sure if this is possible at all, or how<b=
r>
much effort it would be.<br>
<div class=3D"elided-text"><br>
<br>
--<br>
Earthling Michel D=C3=A4nzer=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0|=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0<a href=
=3D"http://www.amd.com" rel=3D"noreferrer" target=3D"_blank">http://www.amd=
.com</a><br>
Libre software enthusiast=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0Mesa and X developer<br>
<br>
</div></blockquote></div><br></div></div></div>

--001a11402d3adcd825054fc9c684--

--===============1102978416==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============1102978416==--
