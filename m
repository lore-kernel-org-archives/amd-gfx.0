From: =?UTF-8?B?TWFyZWsgT2zFocOhaw==?= <maraeo-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: Plan: BO move throttling for visible VRAM evictions
Date: Mon, 15 May 2017 12:11:58 +0200
Message-ID: <CAAxE2A4ex4e-5ShqesZ8oXJj1CnmH6Enhvu4fXs9kDKu9NHeiQ@mail.gmail.com>
References: <CAAxE2A4ap8BoOEg1tOF+Ec1vBfZRSANOebikYBaHUfXokY7EwA@mail.gmail.com>
 <9220eda1-5176-36cd-e6b3-801c3e4f759a@daenzer.net>
 <78989271-9812-f891-3a00-0d5b39a06b7c@daenzer.net>
 <CAAxE2A60hubc8jbZkO101sxqVZKR8iub=GsfRovj17+P2zKDKQ@mail.gmail.com>
 <aee1e2b7-dd00-e24b-bcfc-e2299e31908b@daenzer.net>
 <CAAxE2A5g7tJG+94XxPr-mdGXkeL1GPMNMaYgc7ATEk7pxsiXfA@mail.gmail.com>
 <c343b89c-318f-d3af-d02e-4e6843c422f6@daenzer.net>
 <CAAxE2A5_tiOEvLVegNvkuvYrFcsU52H6EfCff3faKBZwPfbuYQ@mail.gmail.com>
 <a5a8428e-444a-34b9-7fa9-60e77582819a@daenzer.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1730181532=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <a5a8428e-444a-34b9-7fa9-60e77582819a-otUistvHUpPR7s880joybQ@public.gmane.org>
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

--===============1730181532==
Content-Type: multipart/alternative; boundary="001a113f7eea26554f054f8d4973"

--001a113f7eea26554f054f8d4973
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On May 15, 2017 4:29 AM, "Michel D=C3=A4nzer" <michel-otUistvHUpPR7s880joybQ@public.gmane.org> wrote:

On 14/05/17 06:31 AM, Marek Ol=C5=A1=C3=A1k wrote:
> On Mon, Apr 17, 2017 at 11:55 AM, Michel D=C3=A4nzer <michel-otUistvHUpPR7s880joybQ@public.gmane.org>
wrote:
>> On 17/04/17 07:58 AM, Marek Ol=C5=A1=C3=A1k wrote:
>>> On Fri, Apr 14, 2017 at 12:14 PM, Michel D=C3=A4nzer <michel-otUistvHUpNNg+MwTxZMZA@public.gmane.org=
t>
wrote:
>>>> On 04/04/17 05:11 AM, Marek Ol=C5=A1=C3=A1k wrote:
>>>>> On Fri, Mar 31, 2017 at 5:24 AM, Michel D=C3=A4nzer <michel@daenzer.n=
et>
wrote:
>>>>>> On 30/03/17 07:03 PM, Michel D=C3=A4nzer wrote:
>>>>>>> On 25/03/17 01:33 AM, Marek Ol=C5=A1=C3=A1k wrote:
>>>>>>>> Hi,
>>>>>>>>
>>>>>>>> I'm sharing this idea here, because it's something that has been
>>>>>>>> decreasing our performance a lot recently, for example:
>>>>>>>> http://openbenchmarking.org/prospect/1703011-RI-RADEONDIR06/
7b7668cfc109d1c3dc27e871c8aea71ca13f23fa
>>>>>>>
>>>>>>> The attached proof-of-concept patch (on top of Christian's "CPU
mapping
>>>>>>> of split VRAM buffers" series, ported from radeon) results in
145.05 fps
>>>>>>> on my Tonga.
>>>>>>
>>>>>> I get the same result without my or Christian's patches though, with
>>>>>> 4.11 based DRM or amd-staging-4.9. So I guess I just can't reproduce
the
>>>>>> problem with this test. Are there any other tests for it?
>>>>>
>>>>> It's random. Sometimes the benchmark runs OK, other times it's slow.
>>>>> You can easily see the difference but observing how smooth it is. The
>>>>> visible VRAM evictions result in constant 100-200ms stalls but not
>>>>> every frame, which feels like the frame rate is much lower than it
>>>>> actually is.
>>>>>
>>>>> Make sure your graphics details are maxed out. The best score I can
>>>>> get with my rig is 70 fps. (Fiji & Core i5 3570)
>>>>
>>>> I'm getting around 53-54 fps at Ultra with Tonga, both with Mesa 13.0.=
6
>>>> and Git.
>>>>
>>>> Have you tried if Christian's patches for CPU access to split VRAM
>>>> buffers help? I can imagine that forcing contiguous VRAM buffers for
CPU
>>>> access could cause lots of other BOs to be unnecessarily evicted from
>>>> VRAM, if at least one of their fragments happens to be in the CPU
>>>> visible part of VRAM.
>>>
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
>>
>> That's great to hear. If you get a chance, it would be interesting if
>> the attached updated patch improves things even more for you. (The patch
>> I attached previously couldn't work as intended, this one at least might
:)
>
> Frogging101 on IRC noticed that we get a ton of TTM BO moves due to
> visible VRAM thrashing and Michel's patch doesn't help. His kernel is
> up to date with amd-staging. It looks like the only option left is my
> original plan: BO move throttling for visible VRAM by redirecting
> mapped buffers to GTT and not allowing them to go back to VRAM if some
> counter is too high.
>
> Opinions?

I think the next step should be to make radeonsi keep track of how much
VRAM it's trying to use that's expected to be accessed by the CPU, and
to use GTT instead when that exceeds a threshold (probably derived from
vram_vis_size).


That's difficult to estimate. There are apps with 600MB of mapped VRAM and
don't experience any performance issues. And some apps with 300MB of mapped
VRAM do. It only depends on the CPU access pattern, not what radeonsi sees.

Marek



--
Earthling Michel D=C3=A4nzer               |               http://www.amd.c=
om
Libre software enthusiast             |             Mesa and X developer

--001a113f7eea26554f054f8d4973
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div><br><div class=3D"gmail_extra"><br><div class=3D"gma=
il_quote">On May 15, 2017 4:29 AM, &quot;Michel D=C3=A4nzer&quot; &lt;<a hr=
ef=3D"mailto:michel-otUistvHUpPR7s880joybQ@public.gmane.org">michel-otUistvHUpPR7s880joybQ@public.gmane.org</a>&gt; wrote:<br type=
=3D"attribution"><blockquote class=3D"quote" style=3D"margin:0 0 0 .8ex;bor=
der-left:1px #ccc solid;padding-left:1ex"><div class=3D"elided-text">On 14/=
05/17 06:31 AM, Marek Ol=C5=A1=C3=A1k wrote:<br>
&gt; On Mon, Apr 17, 2017 at 11:55 AM, Michel D=C3=A4nzer &lt;<a href=3D"ma=
ilto:michel-otUistvHUpPR7s880joybQ@public.gmane.org">michel-otUistvHUpPR7s880joybQ@public.gmane.org</a>&gt; wrote:<br>
&gt;&gt; On 17/04/17 07:58 AM, Marek Ol=C5=A1=C3=A1k wrote:<br>
&gt;&gt;&gt; On Fri, Apr 14, 2017 at 12:14 PM, Michel D=C3=A4nzer &lt;<a hr=
ef=3D"mailto:michel-otUistvHUpPR7s880joybQ@public.gmane.org">michel-otUistvHUpPR7s880joybQ@public.gmane.org</a>&gt; wrote:<br>
&gt;&gt;&gt;&gt; On 04/04/17 05:11 AM, Marek Ol=C5=A1=C3=A1k wrote:<br>
&gt;&gt;&gt;&gt;&gt; On Fri, Mar 31, 2017 at 5:24 AM, Michel D=C3=A4nzer &l=
t;<a href=3D"mailto:michel-otUistvHUpPR7s880joybQ@public.gmane.org">michel-otUistvHUpPR7s880joybQ@public.gmane.org</a>&gt; wrote:<b=
r>
&gt;&gt;&gt;&gt;&gt;&gt; On 30/03/17 07:03 PM, Michel D=C3=A4nzer wrote:<br=
>
&gt;&gt;&gt;&gt;&gt;&gt;&gt; On 25/03/17 01:33 AM, Marek Ol=C5=A1=C3=A1k wr=
ote:<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; Hi,<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; I&#39;m sharing this idea here, because it=
&#39;s something that has been<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; decreasing our performance a lot recently,=
 for example:<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; <a href=3D"http://openbenchmarking.org/pro=
spect/1703011-RI-RADEONDIR06/7b7668cfc109d1c3dc27e871c8aea71ca13f23fa" rel=
=3D"noreferrer" target=3D"_blank">http://openbenchmarking.org/<wbr>prospect=
/1703011-RI-<wbr>RADEONDIR06/<wbr>7b7668cfc109d1c3dc27e871c8aea7<wbr>1ca13f=
23fa</a><br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt; The attached proof-of-concept patch (on top of=
 Christian&#39;s &quot;CPU mapping<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt; of split VRAM buffers&quot; series, ported fro=
m radeon) results in 145.05 fps<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt; on my Tonga.<br>
&gt;&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt;&gt; I get the same result without my or Christian&#39;=
s patches though, with<br>
&gt;&gt;&gt;&gt;&gt;&gt; 4.11 based DRM or amd-staging-4.9. So I guess I ju=
st can&#39;t reproduce the<br>
&gt;&gt;&gt;&gt;&gt;&gt; problem with this test. Are there any other tests =
for it?<br>
&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt; It&#39;s random. Sometimes the benchmark runs OK, othe=
r times it&#39;s slow.<br>
&gt;&gt;&gt;&gt;&gt; You can easily see the difference but observing how sm=
ooth it is. The<br>
&gt;&gt;&gt;&gt;&gt; visible VRAM evictions result in constant 100-200ms st=
alls but not<br>
&gt;&gt;&gt;&gt;&gt; every frame, which feels like the frame rate is much l=
ower than it<br>
&gt;&gt;&gt;&gt;&gt; actually is.<br>
&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt; Make sure your graphics details are maxed out. The bes=
t score I can<br>
&gt;&gt;&gt;&gt;&gt; get with my rig is 70 fps. (Fiji &amp; Core i5 3570)<b=
r>
&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt; I&#39;m getting around 53-54 fps at Ultra with Tonga, both=
 with Mesa 13.0.6<br>
&gt;&gt;&gt;&gt; and Git.<br>
&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt; Have you tried if Christian&#39;s patches for CPU access t=
o split VRAM<br>
&gt;&gt;&gt;&gt; buffers help? I can imagine that forcing contiguous VRAM b=
uffers for CPU<br>
&gt;&gt;&gt;&gt; access could cause lots of other BOs to be unnecessarily e=
victed from<br>
&gt;&gt;&gt;&gt; VRAM, if at least one of their fragments happens to be in =
the CPU<br>
&gt;&gt;&gt;&gt; visible part of VRAM.<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; I&#39;ve finally tested latest amd-staging-4.9 and I&#39;m ver=
y pleased. For<br>
&gt;&gt;&gt; the first time, the Deus Ex benchmark has almost no hiccups. I=
&#39;ve<br>
&gt;&gt;&gt; never seen it so smooth. At one point, the MB/s BO move rate i=
ncrease<br>
&gt;&gt;&gt; to 200MB/s, stayed there for a couple of seconds, and then it =
dropped<br>
&gt;&gt;&gt; to 0 again. The frame rate was OK-ish, so I guess the moves di=
dn&#39;t<br>
&gt;&gt;&gt; happen all at once. I also tested DiRT Rally and I haven&#39;t=
 been able<br>
&gt;&gt;&gt; to reproduce the low FPS with the consistently-high BO move ra=
te that<br>
&gt;&gt;&gt; I saw several months ago.<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; We could do some move throttling there for sure, but it&#39;s =
much better<br>
&gt;&gt;&gt; than it ever was.<br>
&gt;&gt;<br>
&gt;&gt; That&#39;s great to hear. If you get a chance, it would be interes=
ting if<br>
&gt;&gt; the attached updated patch improves things even more for you. (The=
 patch<br>
&gt;&gt; I attached previously couldn&#39;t work as intended, this one at l=
east might :)<br>
&gt;<br>
&gt; Frogging101 on IRC noticed that we get a ton of TTM BO moves due to<br=
>
&gt; visible VRAM thrashing and Michel&#39;s patch doesn&#39;t help. His ke=
rnel is<br>
&gt; up to date with amd-staging. It looks like the only option left is my<=
br>
&gt; original plan: BO move throttling for visible VRAM by redirecting<br>
&gt; mapped buffers to GTT and not allowing them to go back to VRAM if some=
<br>
&gt; counter is too high.<br>
&gt;<br>
&gt; Opinions?<br>
<br>
</div>I think the next step should be to make radeonsi keep track of how mu=
ch<br>
VRAM it&#39;s trying to use that&#39;s expected to be accessed by the CPU, =
and<br>
to use GTT instead when that exceeds a threshold (probably derived from<br>
vram_vis_size).<br></blockquote></div></div></div><div dir=3D"auto"><br></d=
iv><div dir=3D"auto">That&#39;s difficult to estimate. There are apps with =
600MB of mapped VRAM and don&#39;t experience any performance issues. And s=
ome apps with 300MB of mapped VRAM do. It only depends on the CPU access pa=
ttern, not what radeonsi sees.</div><div dir=3D"auto"><br></div><div dir=3D=
"auto">Marek</div><div dir=3D"auto"><br></div><div dir=3D"auto"><div class=
=3D"gmail_extra"><div class=3D"gmail_quote"><blockquote class=3D"quote" sty=
le=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">
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

--001a113f7eea26554f054f8d4973--

--===============1730181532==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============1730181532==--
