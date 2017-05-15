From: =?UTF-8?B?TWFyZWsgT2zFocOhaw==?= <maraeo-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: Plan: BO move throttling for visible VRAM evictions
Date: Mon, 15 May 2017 12:18:36 +0200
Message-ID: <CAAxE2A5Yz8GoRnXwWeeSt5ZxwRbiT9W1RLYPTTUE=vojKukQug@mail.gmail.com>
References: <CAAxE2A4ap8BoOEg1tOF+Ec1vBfZRSANOebikYBaHUfXokY7EwA@mail.gmail.com>
 <9220eda1-5176-36cd-e6b3-801c3e4f759a@daenzer.net>
 <78989271-9812-f891-3a00-0d5b39a06b7c@daenzer.net>
 <CAAxE2A60hubc8jbZkO101sxqVZKR8iub=GsfRovj17+P2zKDKQ@mail.gmail.com>
 <aee1e2b7-dd00-e24b-bcfc-e2299e31908b@daenzer.net>
 <CAAxE2A5g7tJG+94XxPr-mdGXkeL1GPMNMaYgc7ATEk7pxsiXfA@mail.gmail.com>
 <c343b89c-318f-d3af-d02e-4e6843c422f6@daenzer.net>
 <CAAxE2A5_tiOEvLVegNvkuvYrFcsU52H6EfCff3faKBZwPfbuYQ@mail.gmail.com>
 <5919307C.4020704@amd.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1873517137=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <5919307C.4020704-5C7GfCeVMHo@public.gmane.org>
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
To: zhoucm1 <david1.zhou-5C7GfCeVMHo@public.gmane.org>
Cc: =?UTF-8?Q?Michel_D=C3=A4nzer?= <michel-otUistvHUpPR7s880joybQ@public.gmane.org>, amd-gfx mailing list <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

--===============1873517137==
Content-Type: multipart/alternative; boundary="001a1142f376ce97e1054f8d60a6"

--001a1142f376ce97e1054f8d60a6
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On May 15, 2017 6:40 AM, "zhoucm1" <david1.zhou-5C7GfCeVMHo@public.gmane.org> wrote:



On 2017=E5=B9=B405=E6=9C=8814=E6=97=A5 05:31, Marek Ol=C5=A1=C3=A1k wrote:

> On Mon, Apr 17, 2017 at 11:55 AM, Michel D=C3=A4nzer <michel-otUistvHUpPR7s880joybQ@public.gmane.org>
> wrote:
>
>> On 17/04/17 07:58 AM, Marek Ol=C5=A1=C3=A1k wrote:
>>
>>> On Fri, Apr 14, 2017 at 12:14 PM, Michel D=C3=A4nzer <michel-otUistvHUpNNg+MwTxZMZA@public.gmane.org=
t>
>>> wrote:
>>>
>>>> On 04/04/17 05:11 AM, Marek Ol=C5=A1=C3=A1k wrote:
>>>>
>>>>> On Fri, Mar 31, 2017 at 5:24 AM, Michel D=C3=A4nzer <michel@daenzer.n=
et>
>>>>> wrote:
>>>>>
>>>>>> On 30/03/17 07:03 PM, Michel D=C3=A4nzer wrote:
>>>>>>
>>>>>>> On 25/03/17 01:33 AM, Marek Ol=C5=A1=C3=A1k wrote:
>>>>>>>
>>>>>>>> Hi,
>>>>>>>>
>>>>>>>> I'm sharing this idea here, because it's something that has been
>>>>>>>> decreasing our performance a lot recently, for example:
>>>>>>>> http://openbenchmarking.org/prospect/1703011-RI-RADEONDIR06/
>>>>>>>> 7b7668cfc109d1c3dc27e871c8aea71ca13f23fa
>>>>>>>>
>>>>>>> The attached proof-of-concept patch (on top of Christian's "CPU
>>>>>>> mapping
>>>>>>> of split VRAM buffers" series, ported from radeon) results in 145.0=
5
>>>>>>> fps
>>>>>>> on my Tonga.
>>>>>>>
>>>>>> I get the same result without my or Christian's patches though, with
>>>>>> 4.11 based DRM or amd-staging-4.9. So I guess I just can't reproduce
>>>>>> the
>>>>>> problem with this test. Are there any other tests for it?
>>>>>>
>>>>> It's random. Sometimes the benchmark runs OK, other times it's slow.
>>>>> You can easily see the difference but observing how smooth it is. The
>>>>> visible VRAM evictions result in constant 100-200ms stalls but not
>>>>> every frame, which feels like the frame rate is much lower than it
>>>>> actually is.
>>>>>
>>>>> Make sure your graphics details are maxed out. The best score I can
>>>>> get with my rig is 70 fps. (Fiji & Core i5 3570)
>>>>>
>>>> I'm getting around 53-54 fps at Ultra with Tonga, both with Mesa 13.0.=
6
>>>> and Git.
>>>>
>>>> Have you tried if Christian's patches for CPU access to split VRAM
>>>> buffers help? I can imagine that forcing contiguous VRAM buffers for C=
PU
>>>> access could cause lots of other BOs to be unnecessarily evicted from
>>>> VRAM, if at least one of their fragments happens to be in the CPU
>>>> visible part of VRAM.
>>>>
>>> I've finally tested latest amd-staging-4.9 and I'm very pleased. For
>>> the first time, the Deus Ex benchmark has almost no hiccups. I've
>>> never seen it so smooth. At one point, the MB/s BO move rate increase
>>> to 200MB/s, stayed there for a couple of seconds, and then it dropped
>>> to 0 again. The frame rate was OK-ish, so I guess the moves didn't
>>> happen all at once. I also tested DiRT Rally and I haven't been able
>>> to reproduce the low FPS with the consistently-high BO move rate that
>>> I saw several months ago.
>>>
>>> We could do some move throttling there for sure, but it's much better
>>> than it ever was.
>>>
>> That's great to hear. If you get a chance, it would be interesting if
>> the attached updated patch improves things even more for you. (The patch
>> I attached previously couldn't work as intended, this one at least might
>> :)
>>
> Frogging101 on IRC noticed that we get a ton of TTM BO moves due to
> visible VRAM thrashing and Michel's patch doesn't help. His kernel is
> up to date with amd-staging. It looks like the only option left is my
> original plan: BO move throttling for visible VRAM by redirecting
> mapped buffers to GTT and not allowing them to go back to VRAM if some
> counter is too high.
>
I agree on this opinion, from our performance tuning experiment, this case
indeed often happen especially under vram memory pressure. redirecting to
GTT is better than heavy eviction between VRAM and GTT.
But we should get a condition for redirecting (eviction counter?),
otherwise, BO have no change back to prefer domain.


You're talking about something different. VRAM memory pressure is a solved
problem in amdgpu. There is even a kernel parameter that controls the
amount of buffer moves between VRAM and GTT. So you can control the amount
of evictions today.

This discussion is about evictions between visible VRAM and invisible VRAM.

Marek


Regards,
David Zhou

>
> Opinions?
>
> Marek
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
>

--001a1142f376ce97e1054f8d60a6
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div><br><div class=3D"gmail_extra"><br><div class=3D"gma=
il_quote">On May 15, 2017 6:40 AM, &quot;zhoucm1&quot; &lt;<a href=3D"mailt=
o:david1.zhou-5C7GfCeVMHo@public.gmane.org">david1.zhou-5C7GfCeVMHo@public.gmane.org</a>&gt; wrote:<br type=3D"attrib=
ution"><blockquote class=3D"quote" style=3D"margin:0 0 0 .8ex;border-left:1=
px #ccc solid;padding-left:1ex"><div class=3D"elided-text"><br>
<br>
On 2017=E5=B9=B405=E6=9C=8814=E6=97=A5 05:31, Marek Ol=C5=A1=C3=A1k wrote:<=
br>
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex">
On Mon, Apr 17, 2017 at 11:55 AM, Michel D=C3=A4nzer &lt;<a href=3D"mailto:=
michel-otUistvHUpPR7s880joybQ@public.gmane.org" target=3D"_blank">michel-otUistvHUpPR7s880joybQ@public.gmane.org</a>&gt; wrote:<br>
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex">
On 17/04/17 07:58 AM, Marek Ol=C5=A1=C3=A1k wrote:<br>
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex">
On Fri, Apr 14, 2017 at 12:14 PM, Michel D=C3=A4nzer &lt;<a href=3D"mailto:=
michel-otUistvHUpPR7s880joybQ@public.gmane.org" target=3D"_blank">michel-otUistvHUpPR7s880joybQ@public.gmane.org</a>&gt; wrote:<br>
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex">
On 04/04/17 05:11 AM, Marek Ol=C5=A1=C3=A1k wrote:<br>
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex">
On Fri, Mar 31, 2017 at 5:24 AM, Michel D=C3=A4nzer &lt;<a href=3D"mailto:m=
ichel-otUistvHUpPR7s880joybQ@public.gmane.org" target=3D"_blank">michel-otUistvHUpPR7s880joybQ@public.gmane.org</a>&gt; wrote:<br>
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex">
On 30/03/17 07:03 PM, Michel D=C3=A4nzer wrote:<br>
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex">
On 25/03/17 01:33 AM, Marek Ol=C5=A1=C3=A1k wrote:<br>
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex">
Hi,<br>
<br>
I&#39;m sharing this idea here, because it&#39;s something that has been<br=
>
decreasing our performance a lot recently, for example:<br>
<a href=3D"http://openbenchmarking.org/prospect/1703011-RI-RADEONDIR06/7b76=
68cfc109d1c3dc27e871c8aea71ca13f23fa" rel=3D"noreferrer" target=3D"_blank">=
http://openbenchmarking.org/pr<wbr>ospect/1703011-RI-RADEONDIR06/<wbr>7b766=
8cfc109d1c3dc27e871c8aea7<wbr>1ca13f23fa</a><br>
</blockquote>
The attached proof-of-concept patch (on top of Christian&#39;s &quot;CPU ma=
pping<br>
of split VRAM buffers&quot; series, ported from radeon) results in 145.05 f=
ps<br>
on my Tonga.<br>
</blockquote>
I get the same result without my or Christian&#39;s patches though, with<br=
>
4.11 based DRM or amd-staging-4.9. So I guess I just can&#39;t reproduce th=
e<br>
problem with this test. Are there any other tests for it?<br>
</blockquote>
It&#39;s random. Sometimes the benchmark runs OK, other times it&#39;s slow=
.<br>
You can easily see the difference but observing how smooth it is. The<br>
visible VRAM evictions result in constant 100-200ms stalls but not<br>
every frame, which feels like the frame rate is much lower than it<br>
actually is.<br>
<br>
Make sure your graphics details are maxed out. The best score I can<br>
get with my rig is 70 fps. (Fiji &amp; Core i5 3570)<br>
</blockquote>
I&#39;m getting around 53-54 fps at Ultra with Tonga, both with Mesa 13.0.6=
<br>
and Git.<br>
<br>
Have you tried if Christian&#39;s patches for CPU access to split VRAM<br>
buffers help? I can imagine that forcing contiguous VRAM buffers for CPU<br=
>
access could cause lots of other BOs to be unnecessarily evicted from<br>
VRAM, if at least one of their fragments happens to be in the CPU<br>
visible part of VRAM.<br>
</blockquote>
I&#39;ve finally tested latest amd-staging-4.9 and I&#39;m very pleased. Fo=
r<br>
the first time, the Deus Ex benchmark has almost no hiccups. I&#39;ve<br>
never seen it so smooth. At one point, the MB/s BO move rate increase<br>
to 200MB/s, stayed there for a couple of seconds, and then it dropped<br>
to 0 again. The frame rate was OK-ish, so I guess the moves didn&#39;t<br>
happen all at once. I also tested DiRT Rally and I haven&#39;t been able<br=
>
to reproduce the low FPS with the consistently-high BO move rate that<br>
I saw several months ago.<br>
<br>
We could do some move throttling there for sure, but it&#39;s much better<b=
r>
than it ever was.<br>
</blockquote>
That&#39;s great to hear. If you get a chance, it would be interesting if<b=
r>
the attached updated patch improves things even more for you. (The patch<br=
>
I attached previously couldn&#39;t work as intended, this one at least migh=
t :)<br>
</blockquote>
Frogging101 on IRC noticed that we get a ton of TTM BO moves due to<br>
visible VRAM thrashing and Michel&#39;s patch doesn&#39;t help. His kernel =
is<br>
up to date with amd-staging. It looks like the only option left is my<br>
original plan: BO move throttling for visible VRAM by redirecting<br>
mapped buffers to GTT and not allowing them to go back to VRAM if some<br>
counter is too high.<br>
</blockquote></div>
I agree on this opinion, from our performance tuning experiment, this case =
indeed often happen especially under vram memory pressure. redirecting to G=
TT is better than heavy eviction between VRAM and GTT.<br>
But we should get a condition for redirecting (eviction counter?), otherwis=
e, BO have no change back to prefer domain.<br></blockquote></div></div></d=
iv><div dir=3D"auto"><br></div><div dir=3D"auto">You&#39;re talking about s=
omething different. VRAM memory pressure is a solved problem in amdgpu. The=
re is even a kernel parameter that controls the amount of buffer moves betw=
een VRAM and GTT. So you can control the amount of evictions today.</div><d=
iv dir=3D"auto"><br></div><div dir=3D"auto">This discussion is about evicti=
ons between visible VRAM and invisible VRAM.</div><div dir=3D"auto"><br></d=
iv><div dir=3D"auto">Marek</div><div dir=3D"auto"><br></div><div dir=3D"aut=
o"><div class=3D"gmail_extra"><div class=3D"gmail_quote"><blockquote class=
=3D"quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-le=
ft:1ex">
<br>
Regards,<br>
David Zhou<br>
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex">
<br>
Opinions?<br>
<br>
Marek<div class=3D"quoted-text"><br>
______________________________<wbr>_________________<br>
amd-gfx mailing list<br>
<a href=3D"mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" target=3D"_blank">amd-gfx@=
lists.freedesktop.org</a><br>
<a href=3D"https://lists.freedesktop.org/mailman/listinfo/amd-gfx" rel=3D"n=
oreferrer" target=3D"_blank">https://lists.freedesktop.org/<wbr>mailman/lis=
tinfo/amd-gfx</a><br>
</div></blockquote>
<br>
</blockquote></div><br></div></div></div>

--001a1142f376ce97e1054f8d60a6--

--===============1873517137==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============1873517137==--
