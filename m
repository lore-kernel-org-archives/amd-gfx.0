From: =?UTF-8?B?TWFyZWsgT2zFocOhaw==?= <maraeo-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH libdrm 2/7] amdgpu: update amdgpu_drm.h for Vega10
Date: Wed, 22 Mar 2017 11:13:31 +0100
Message-ID: <CAAxE2A6C5_tmhxmYOOULOFecrZqXkWH725T3Mc4GcuSt=FRaEw@mail.gmail.com>
References: <1490126185-4482-1-git-send-email-maraeo@gmail.com>
 <1490126185-4482-3-git-send-email-maraeo@gmail.com>
 <539620eb-cb35-2760-ef61-91d0efbfe781@gmail.com>
 <CAAxE2A7Z44x5S1xuuoWBa981gWAzNACyVN8bSq2v0WOE1CMd3w@mail.gmail.com>
 <e7e5dca1-2e4d-4166-9660-1a6121e85722@daenzer.net>
 <CAAxE2A6y-Y3MXxNB-PaYLB0953A7EeqbQ5dfZHz3_UROGLqcbg@mail.gmail.com>
 <CAAxE2A4XJPUthuqfr9QonWpY3N11sWw5OjbZ0BLhKuBBC-bLhg@mail.gmail.com>
 <CAAxE2A55sK5TfQQJ-M+P18DmWkWDAMM+THqD7r66Lm63JxrAow@mail.gmail.com>
 <CAAxE2A7SHqXuYqCE2x4FnadKnFg6DKvQefSbfyA=zaR8GasQXQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1648103046=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <CAAxE2A7SHqXuYqCE2x4FnadKnFg6DKvQefSbfyA=zaR8GasQXQ-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
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
Cc: Nicolai Haehnle <nhaehnle-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, amd-gfx mailing list <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

--===============1648103046==
Content-Type: multipart/alternative; boundary=94eb2c055d18342e13054b4f032b

--94eb2c055d18342e13054b4f032b
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Mar 22, 2017 2:44 AM, "Michel D=C3=A4nzer" <michel-otUistvHUpPR7s880joybQ@public.gmane.org> wrote:

On 22/03/17 06:46 AM, Marek Ol=C5=A1=C3=A1k wrote:
> On Tue, Mar 21, 2017 at 10:27 PM, Nicolai H=C3=A4hnle <nhaehnle-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org=
>
wrote:
>> In the past, I was told off for patches that update this file without
>> following the procedure described in include/drm/README. Tbh, that
procedure
>> causes some annoyances.
>>
>> Anyway, it's definitely useful to have the patch out on the mailing list
in
>> any case.
>
> Yeah, I know the correct process and I plan to ignore it this time if
> I don't get too much backlash, because the alternative
> (#ifdef/#define/#endif) is probably even worse.

FWIW, only AMDGPU_TILING_SET/GET need #undef,
AMDGPU_TILING_SWIZZLE_MODE_SHIFT/MASK and AMDGPU_FAMILY_AI can just be
#defined directly, that way the preprocessor will warn if the
definitions in libdrm and Mesa end up being inconsistent for some reason.


The alternative is rushing out a libdrm release and making Mesa require
that, right? That doesn't seem obviously better than a handful of
temporary redundant defines in Mesa, hardly justification for bypassing
the normal process.


I need a libdrm release because of the 3rd patch. I can't allow Mesa to run
without that.

Marek



--
Earthling Michel D=C3=A4nzer               |               http://www.amd.c=
om
Libre software enthusiast             |             Mesa and X developer

--94eb2c055d18342e13054b4f032b
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div><br><div class=3D"gmail_extra"><br><div class=3D"gma=
il_quote">On Mar 22, 2017 2:44 AM, &quot;Michel D=C3=A4nzer&quot; &lt;<a hr=
ef=3D"mailto:michel-otUistvHUpPR7s880joybQ@public.gmane.org">michel-otUistvHUpPR7s880joybQ@public.gmane.org</a>&gt; wrote:<br type=
=3D"attribution"><blockquote class=3D"quote" style=3D"margin:0 0 0 .8ex;bor=
der-left:1px #ccc solid;padding-left:1ex"><div class=3D"elided-text">On 22/=
03/17 06:46 AM, Marek Ol=C5=A1=C3=A1k wrote:<br>
&gt; On Tue, Mar 21, 2017 at 10:27 PM, Nicolai H=C3=A4hnle &lt;<a href=3D"m=
ailto:nhaehnle-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org">nhaehnle-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org</a>&gt; wrote:<br>
&gt;&gt; In the past, I was told off for patches that update this file with=
out<br>
&gt;&gt; following the procedure described in include/drm/README. Tbh, that=
 procedure<br>
&gt;&gt; causes some annoyances.<br>
&gt;&gt;<br>
&gt;&gt; Anyway, it&#39;s definitely useful to have the patch out on the ma=
iling list in<br>
&gt;&gt; any case.<br>
&gt;<br>
&gt; Yeah, I know the correct process and I plan to ignore it this time if<=
br>
&gt; I don&#39;t get too much backlash, because the alternative<br>
&gt; (#ifdef/#define/#endif) is probably even worse.<br>
<br>
</div>FWIW, only AMDGPU_TILING_SET/GET need #undef,<br>
AMDGPU_TILING_SWIZZLE_MODE_<wbr>SHIFT/MASK and AMDGPU_FAMILY_AI can just be=
<br>
#defined directly, that way the preprocessor will warn if the<br>
definitions in libdrm and Mesa end up being inconsistent for some reason.<b=
r>
<br>
<br>
The alternative is rushing out a libdrm release and making Mesa require<br>
that, right? That doesn&#39;t seem obviously better than a handful of<br>
temporary redundant defines in Mesa, hardly justification for bypassing<br>
the normal process.<br></blockquote></div></div></div><div dir=3D"auto"><br=
></div><div dir=3D"auto">I need a libdrm release because of the 3rd patch. =
I can&#39;t allow Mesa to run without that.</div><div dir=3D"auto"><br></di=
v><div dir=3D"auto">Marek</div><div dir=3D"auto"><br></div><div dir=3D"auto=
"><div class=3D"gmail_extra"><div class=3D"gmail_quote"><blockquote class=
=3D"quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-le=
ft:1ex">
<font color=3D"#888888"><br>
<br>
--<br>
Earthling Michel D=C3=A4nzer=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0|=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0<a href=
=3D"http://www.amd.com" rel=3D"noreferrer" target=3D"_blank">http://www.amd=
.com</a><br>
Libre software enthusiast=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0Mesa and X developer<br>
</font></blockquote></div><br></div></div></div>

--94eb2c055d18342e13054b4f032b--

--===============1648103046==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============1648103046==--
