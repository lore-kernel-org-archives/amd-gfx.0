From: =?UTF-8?B?TWFyZWsgT2zFocOhaw==?= <maraeo-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: Plan: BO move throttling for visible VRAM evictions
Date: Tue, 28 Mar 2017 12:47:35 +0200
Message-ID: <CAAxE2A7h_6irJjsQWiw3goufALF1muj+R541w=-=j0KTT3131A@mail.gmail.com>
References: <CAAxE2A4ap8BoOEg1tOF+Ec1vBfZRSANOebikYBaHUfXokY7EwA@mail.gmail.com>
 <ba8058ce-805b-3e52-095a-01806673344f@daenzer.net>
 <MWHPR1201MB0206FD6ABB9A0029624E4AF6B4330@MWHPR1201MB0206.namprd12.prod.outlook.com>
 <441ea5b9-d37d-140d-e029-26a7c3ae58cb@daenzer.net> <58D9DD8D.4000803@amd.com>
 <10958b11-6d28-228a-5142-2c5edadb70ef@daenzer.net>
 <f7ee08e8-46ca-8146-f3a3-d28080e5267f@vodafone.de>
 <bb6d20b3-06d1-3f7d-f782-ae18d66d4423@daenzer.net>
 <efb4f99c-c0b9-56ab-d73c-a03a7e136d66@vodafone.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2060940931=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <efb4f99c-c0b9-56ab-d73c-a03a7e136d66-ANTagKRnAhcb1SvskN2V4Q@public.gmane.org>
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
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <deathsimple-ANTagKRnAhcb1SvskN2V4Q@public.gmane.org>
Cc: zhoucm1 <david1.zhou-5C7GfCeVMHo@public.gmane.org>, =?UTF-8?Q?Michel_D=C3=A4nzer?= <michel-otUistvHUpPR7s880joybQ@public.gmane.org>, amd-gfx mailing list <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

--===============2060940931==
Content-Type: multipart/alternative; boundary=001a11447c2e232048054bc8303a

--001a11447c2e232048054bc8303a
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Mar 28, 2017 10:41 AM, "Christian K=C3=B6nig" <deathsimple-ANTagKRnAhcb1SvskN2V4Q@public.gmane.org> =
wrote:

Am 28.03.2017 um 10:35 schrieb Michel D=C3=A4nzer:

> On 28/03/17 05:29 PM, Christian K=C3=B6nig wrote:
>
>> Am 28.03.2017 um 08:00 schrieb Michel D=C3=A4nzer:
>>
>>> On 28/03/17 12:50 PM, zhoucm1 wrote:
>>>
>>>> On 2017=E5=B9=B403=E6=9C=8828=E6=97=A5 10:40, Michel D=C3=A4nzer wrote=
:
>>>>
>>>>> On 27/03/17 04:53 PM, Zhou, David(ChunMing) wrote:
>>>>>
>>>>>> For APU special case, can we prevent eviction happening between VRAM
>>>>>> <----> GTT?
>>>>>>
>>>>> We can, if we can close the performance gap between VRAM and GTT. We
>>>>> measured around 30% gap a while ago, though right now I'm only
>>>>> measuring
>>>>> ~5%, but the test system has slower RAM now (still dual channel
>>>>> though).
>>>>>
>>>> My impression VRAM and GTT have no much difference for APU case, if I'=
m
>>>> wrong, pls correct me.
>>>>
>>> The Mesa patch below makes radeonsi use mostly GTT instead of mostly
>>> VRAM, and slows down Unigine Valley by about 5% on my desktop Kaveri.
>>> You can try it for yourself.
>>>
>> Additional to that you still need the stolen VRAM on APUs for page
>> tables and DCE.
>>
>> So we need to keep the eviction from VRAM to GTT enabled, but what we
>> don't do is swapping them back in because Marek added the GTT flags on
>> APUs as extra domain to look into.
>>
> As long as there's a performance gap between VRAM and GTT, this means
> that performance of long-running apps (e.g. Xorg or the compositor) will
> degrade over time, or after e.g. a suspend-resume cycle.
>
> OTOH, if we can close the gap, we can stop trying to put most BOs in
> VRAM in the first place with APUs.
>

Yeah, John and I are already working on this (but mostly for GFX9).

The difference is that VRAM allocations are mostly contiguously, while GTT
allocations are scattered. So you got more TLB pressure with GTT.


Another aspect is that GART has smaller pages, so the translation cache has
to fetch more of the page directory and also the cache is finite, meaning
that it can be thrashed more easily with small pages.

Marek



Christian.

--001a11447c2e232048054bc8303a
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div><br><div class=3D"gmail_extra"><br><div class=3D"gma=
il_quote">On Mar 28, 2017 10:41 AM, &quot;Christian K=C3=B6nig&quot; &lt;<a=
 href=3D"mailto:deathsimple-ANTagKRnAhcb1SvskN2V4Q@public.gmane.org">deathsimple-ANTagKRnAhcb1SvskN2V4Q@public.gmane.org</a>&gt; wr=
ote:<br type=3D"attribution"><blockquote class=3D"quote" style=3D"margin:0 =
0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex"><div class=3D"elided-=
text">Am 28.03.2017 um 10:35 schrieb Michel D=C3=A4nzer:<br>
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex">
On 28/03/17 05:29 PM, Christian K=C3=B6nig wrote:<br>
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex">
Am 28.03.2017 um 08:00 schrieb Michel D=C3=A4nzer:<br>
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex">
On 28/03/17 12:50 PM, zhoucm1 wrote:<br>
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex">
On 2017=E5=B9=B403=E6=9C=8828=E6=97=A5 10:40, Michel D=C3=A4nzer wrote:<br>
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex">
On 27/03/17 04:53 PM, Zhou, David(ChunMing) wrote:<br>
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex">
For APU special case, can we prevent eviction happening between VRAM<br>
&lt;----&gt; GTT?<br>
</blockquote>
We can, if we can close the performance gap between VRAM and GTT. We<br>
measured around 30% gap a while ago, though right now I&#39;m only<br>
measuring<br>
~5%, but the test system has slower RAM now (still dual channel<br>
though).<br>
</blockquote>
My impression VRAM and GTT have no much difference for APU case, if I&#39;m=
<br>
wrong, pls correct me.<br>
</blockquote>
The Mesa patch below makes radeonsi use mostly GTT instead of mostly<br>
VRAM, and slows down Unigine Valley by about 5% on my desktop Kaveri.<br>
You can try it for yourself.<br>
</blockquote>
Additional to that you still need the stolen VRAM on APUs for page<br>
tables and DCE.<br>
<br>
So we need to keep the eviction from VRAM to GTT enabled, but what we<br>
don&#39;t do is swapping them back in because Marek added the GTT flags on<=
br>
APUs as extra domain to look into.<br>
</blockquote>
As long as there&#39;s a performance gap between VRAM and GTT, this means<b=
r>
that performance of long-running apps (e.g. Xorg or the compositor) will<br=
>
degrade over time, or after e.g. a suspend-resume cycle.<br>
<br>
OTOH, if we can close the gap, we can stop trying to put most BOs in<br>
VRAM in the first place with APUs.<br>
</blockquote>
<br></div>
Yeah, John and I are already working on this (but mostly for GFX9).<br>
<br>
The difference is that VRAM allocations are mostly contiguously, while GTT =
allocations are scattered. So you got more TLB pressure with GTT.</blockquo=
te></div></div></div><div dir=3D"auto"><br></div><div dir=3D"auto">Another =
aspect is that GART has smaller pages, so the translation cache has to fetc=
h more of the page directory and also the cache is finite, meaning that it =
can be thrashed more easily with small pages.</div><div dir=3D"auto"><br></=
div><div dir=3D"auto">Marek</div><div dir=3D"auto"><br></div><div dir=3D"au=
to"><div class=3D"gmail_extra"><div class=3D"gmail_quote"><blockquote class=
=3D"quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-le=
ft:1ex"><font color=3D"#888888"><br>
<br>
Christian.<br>
<br>
</font></blockquote></div><br></div></div></div>

--001a11447c2e232048054bc8303a--

--===============2060940931==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============2060940931==--
