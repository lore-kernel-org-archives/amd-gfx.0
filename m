From: Julien Isorce <julien.isorce-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH] Revert "drm/radeon: Try evicting from CPU accessible to
 inaccessible VRAM first"
Date: Thu, 30 Mar 2017 12:03:38 +0100
Message-ID: <CAHWPjbWY4aCLNg92u2XVNmLnhZV9=0sSUS8j0-CG2pFT7CNzew@mail.gmail.com>
References: <1490206797-15653-1-git-send-email-zmichaels@oblong.com>
 <c56f4a6a-a17d-b9b0-311e-7100df8c7cee@daenzer.net>
 <CAOfP2NDoHof0UhQbz53N9WW8jLH3yC_e+ESrTbdd9Ldb6RYg=Q@mail.gmail.com>
 <5f26f8a1-e5bd-ca7a-c7ee-08c8f04f2110@daenzer.net>
 <CAHWPjbUEQCr4Qox5W-C8LYep7-fH=3FV_qhYydpOg2LvqGbZUw@mail.gmail.com>
 <CAHWPjbX8rv2FJniBjfYtqtXo-iCjvC9bNem0kv4bfbp=gbSBAQ@mail.gmail.com>
 <8c7a81e7-40c6-f2c0-b647-576b8dc4e5e0@daenzer.net>
 <CAHWPjbUhw6Bbb6TyQ1EMAid4hbMp8gLx64G6cK7e=-RkDCTB0g@mail.gmail.com>
 <ed374781-4b6d-93ba-2810-39a5943209b7@daenzer.net>
 <b2bbf4bc-0653-fed3-96f5-18ad51a0a4bf@vodafone.de>
 <27573a01-7d01-4b6f-0ba3-8ce1d0c11311@daenzer.net>
 <de189c17-9904-f240-7569-eb1564ff2810@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2104618829=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <de189c17-9904-f240-7569-eb1564ff2810-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
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
To: =?UTF-8?Q?Nicolai_H=C3=A4hnle?= <nhaehnle-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Zachary Michaels <zmichaels-bXq66PvbRDbQT0dZR+AlfA@public.gmane.org>, =?UTF-8?Q?Michel_D=C3=A4nzer?= <michel-otUistvHUpPR7s880joybQ@public.gmane.org>, dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, =?UTF-8?Q?Christian_K=C3=B6nig?= <deathsimple-ANTagKRnAhcb1SvskN2V4Q@public.gmane.org>, amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, Julien Isorce <jisorce-bXq66PvbRDbQT0dZR+AlfA@public.gmane.org>

--===============2104618829==
Content-Type: multipart/alternative; boundary=001a11431b6628f80a054bf0a5fb

--001a11431b6628f80a054bf0a5fb
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Thx for the suggestions.

No, it does not respond to ping.

radeon.dpm=3D0 does not help. But it only tells to use the old power
management right ?
So I tried: low, mid and high for /sys/class/drm/card0/device/prower_profil=
e
 (and setting profile for power_mode)
With radeon.dpm=3D1 I tried all values for power_dpm_state /
power_dpm_force_performance_level. Same results.

I also tried today amd-staging-4.9 branch and same result.

Note that this also happens on W600 (verde), W9000 (tahiti) and W9100
(hawaii), with radeonsi driver.

I have open a bug here: https://bugs.freedesktop.org/show_bug.cgi?id=3D1004=
65
. It contains a test to reproduce the freeze.

Cheers
Julien

On 29 March 2017 at 18:26, Nicolai H=C3=A4hnle <nhaehnle-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:

> On 29.03.2017 11:36, Michel D=C3=A4nzer wrote:
>
>> On 29/03/17 06:07 PM, Christian K=C3=B6nig wrote:
>>
>>> Am 29.03.2017 um 10:59 schrieb Michel D=C3=A4nzer:
>>>
>>>> On 28/03/17 08:00 PM, Julien Isorce wrote:
>>>>
>>>>> On 28 March 2017 at 10:36, Michel D=C3=A4nzer <michel-otUistvHUpPR7s880joybQ@public.gmane.org
>>>>> <mailto:michel-otUistvHUpPR7s880joybQ@public.gmane.org>> wrote:
>>>>>
>>>>>      On 28/03/17 05:24 PM, Julien Isorce wrote:
>>>>>      > Hi Michel,
>>>>>      >
>>>>>      > About the hard lockup, I noticed that I cannot have it with th=
e
>>>>>      > following conditions:
>>>>>      >
>>>>>      > 1. soft lockup fix (the 0->i change which avoids infinite loop=
)
>>>>>      > 2. Your suggestion: (!(rbo->flags & RADEON_GEM_CPU_ACCESS)
>>>>>      > 3. radeon.gartsize=3D512 radeon.vramlimit=3D1024 (any other va=
lues
>>>>> above do
>>>>>      > not help, for example (1024, 1024) or (1024, 2048))
>>>>>      >
>>>>>      > Without 1 and 2, but with 3, our test reproduces the soft
>>>>> lockup (just
>>>>>      > discovered few days ago).
>>>>>      > Without 3 (and with or without 1., 2.), our test reproduces
>>>>> the hard
>>>>>      > lockup which one does not give any info in kern.log (sometimes
>>>>> some NUL
>>>>>      > ^@ characters but not always).
>>>>>
>>>>>      What exactly does "hard lockup" mean? What are the symptoms?
>>>>>
>>>>>
>>>>> Screens are frozen, cannot ssh, no mouse/keyboard, no kernel panic.
>>>>> Requires hard reboot.
>>>>> After reboot, nothing in /var/crash, nothing in /sys/fs/pstore, nothi=
ng
>>>>> in kern.log except sometimes some nul characters ^@.
>>>>>
>>>> Does it still respond to ping when it's hung?
>>>>
>>>>
>>>> Using a serial console did not show additional debug messages. kgdb wa=
s
>>>>> not useful but probably worth another attempt.
>>>>>
>>>> Right.
>>>>
>>>> Anyway, I'm afraid it sounds like it's probably not directly related t=
o
>>>> the issue I was thinking of for my previous test patch or other simila=
r
>>>> ones I was thinking of writing.
>>>>
>>>
>>> Yeah, agree.
>>>
>>> Additional to that a complete crash where you don't even get anything
>>> over serial console is rather unlikely to be cause by something an
>>> application can do directly.
>>>
>>> Possible causes are more likely power management or completely messing
>>> up a bus system. Have you tried disabling dpm as well?
>>>
>>
>> Might also be worth trying the amdgpu kernel driver instead of radeon,
>> not sure how well the former currently works with Cape Verde though.
>>
>
> I've recently used it to experiment with the sparse buffer support. It
> worked well enough for that :)
>
> Cheers,
> Nicolai
> --
> Lerne, wie die Welt wirklich ist,
> Aber vergiss niemals, wie sie sein sollte.
>

--001a11431b6628f80a054bf0a5fb
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Thx for the suggestions.</div><div><br></div>No, it d=
oes not respond to ping.<div><br></div><div>radeon.dpm=3D0 does not help. B=
ut it only tells to use the old power management right ?</div><div>So I tri=
ed: low, mid and high for /sys/class/drm/card0/device/<wbr>prower_profile =
=C2=A0(and setting profile for power_mode)</div><div>With radeon.dpm=3D1 I =
tried all values for power_dpm_state / power_dpm_force_performance_<wbr>lev=
el. Same results.</div><div><br></div><div>I also tried today=C2=A0amd-stag=
ing-4.9 branch and same result.</div><div><br></div><div>Note that this als=
o happens on W600 (verde), W9000 (tahiti) and W9100 (hawaii), with radeonsi=
 driver.</div><div><br></div><div>I have open a bug here:=C2=A0<a href=3D"h=
ttps://bugs.freedesktop.org/show_bug.cgi?id=3D100465">https://bugs.freedesk=
top.org/show_bug.cgi?id=3D100465</a> . It contains a test to reproduce the =
freeze.</div><div><br></div><div>Cheers</div><div>Julien<br><div class=3D"g=
mail_extra"><br><div class=3D"gmail_quote">On 29 March 2017 at 18:26, Nicol=
ai H=C3=A4hnle <span dir=3D"ltr">&lt;<a href=3D"mailto:nhaehnle-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org" =
target=3D"_blank">nhaehnle-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org</a>&gt;</span> wrote:<br><blockquote c=
lass=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px soli=
d rgb(204,204,204);padding-left:1ex"><div class=3D"gmail-m_3361228430822729=
419gmail-HOEnZb"><div class=3D"gmail-m_3361228430822729419gmail-h5">On 29.0=
3.2017 11:36, Michel D=C3=A4nzer wrote:<br>
<blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-=
left:1px solid rgb(204,204,204);padding-left:1ex">
On 29/03/17 06:07 PM, Christian K=C3=B6nig wrote:<br>
<blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-=
left:1px solid rgb(204,204,204);padding-left:1ex">
Am 29.03.2017 um 10:59 schrieb Michel D=C3=A4nzer:<br>
<blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-=
left:1px solid rgb(204,204,204);padding-left:1ex">
On 28/03/17 08:00 PM, Julien Isorce wrote:<br>
<blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-=
left:1px solid rgb(204,204,204);padding-left:1ex">
On 28 March 2017 at 10:36, Michel D=C3=A4nzer &lt;<a href=3D"mailto:michel@=
daenzer.net" target=3D"_blank">michel-otUistvHUpPR7s880joybQ@public.gmane.org</a><br>
&lt;mailto:<a href=3D"mailto:michel-otUistvHUpPR7s880joybQ@public.gmane.org" target=3D"_blank">michel@d=
aenzer.net</a>&gt;&gt; wrote:<br>
<br>
=C2=A0 =C2=A0 =C2=A0On 28/03/17 05:24 PM, Julien Isorce wrote:<br>
=C2=A0 =C2=A0 =C2=A0&gt; Hi Michel,<br>
=C2=A0 =C2=A0 =C2=A0&gt;<br>
=C2=A0 =C2=A0 =C2=A0&gt; About the hard lockup, I noticed that I cannot hav=
e it with the<br>
=C2=A0 =C2=A0 =C2=A0&gt; following conditions:<br>
=C2=A0 =C2=A0 =C2=A0&gt;<br>
=C2=A0 =C2=A0 =C2=A0&gt; 1. soft lockup fix (the 0-&gt;i change which avoid=
s infinite loop)<br>
=C2=A0 =C2=A0 =C2=A0&gt; 2. Your suggestion: (!(rbo-&gt;flags &amp; RADEON_=
GEM_CPU_ACCESS)<br>
=C2=A0 =C2=A0 =C2=A0&gt; 3. radeon.gartsize=3D512 radeon.vramlimit=3D1024 (=
any other values<br>
above do<br>
=C2=A0 =C2=A0 =C2=A0&gt; not help, for example (1024, 1024) or (1024, 2048)=
)<br>
=C2=A0 =C2=A0 =C2=A0&gt;<br>
=C2=A0 =C2=A0 =C2=A0&gt; Without 1 and 2, but with 3, our test reproduces t=
he soft<br>
lockup (just<br>
=C2=A0 =C2=A0 =C2=A0&gt; discovered few days ago).<br>
=C2=A0 =C2=A0 =C2=A0&gt; Without 3 (and with or without 1., 2.), our test r=
eproduces<br>
the hard<br>
=C2=A0 =C2=A0 =C2=A0&gt; lockup which one does not give any info in kern.lo=
g (sometimes<br>
some NUL<br>
=C2=A0 =C2=A0 =C2=A0&gt; ^@ characters but not always).<br>
<br>
=C2=A0 =C2=A0 =C2=A0What exactly does &quot;hard lockup&quot; mean? What ar=
e the symptoms?<br>
<br>
<br>
Screens are frozen, cannot ssh, no mouse/keyboard, no kernel panic.<br>
Requires hard reboot.<br>
After reboot, nothing in /var/crash, nothing in /sys/fs/pstore, nothing<br>
in kern.log except sometimes some nul characters ^@.<br>
</blockquote>
Does it still respond to ping when it&#39;s hung?<br>
<br>
<br>
<blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-=
left:1px solid rgb(204,204,204);padding-left:1ex">
Using a serial console did not show additional debug messages. kgdb was<br>
not useful but probably worth another attempt.<br>
</blockquote>
Right.<br>
<br>
Anyway, I&#39;m afraid it sounds like it&#39;s probably not directly relate=
d to<br>
the issue I was thinking of for my previous test patch or other similar<br>
ones I was thinking of writing.<br>
</blockquote>
<br>
Yeah, agree.<br>
<br>
Additional to that a complete crash where you don&#39;t even get anything<b=
r>
over serial console is rather unlikely to be cause by something an<br>
application can do directly.<br>
<br>
Possible causes are more likely power management or completely messing<br>
up a bus system. Have you tried disabling dpm as well?<br>
</blockquote>
<br>
Might also be worth trying the amdgpu kernel driver instead of radeon,<br>
not sure how well the former currently works with Cape Verde though.<br>
</blockquote>
<br></div></div>
I&#39;ve recently used it to experiment with the sparse buffer support. It =
worked well enough for that :)<br>
<br>
Cheers,<br>
Nicolai<span class=3D"gmail-m_3361228430822729419gmail-HOEnZb"><font color=
=3D"#888888"><br>
-- <br>
Lerne, wie die Welt wirklich ist,<br>
Aber vergiss niemals, wie sie sein sollte.<br>
</font></span></blockquote></div><br></div></div></div>

--001a11431b6628f80a054bf0a5fb--

--===============2104618829==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============2104618829==--
