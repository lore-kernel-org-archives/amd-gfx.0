From: =?UTF-8?B?TWFyZWsgT2zFocOhaw==?= <maraeo-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH libdrm 1/2] amdgpu: prevent an integer wraparound of
 cpu_map_count
Date: Tue, 30 Oct 2018 11:55:12 -0400
Message-ID: <CAAxE2A7dG6nPq7mN9DNe3568BU=C=+RCn_Ss9Fo2gDC8ozgTiw@mail.gmail.com>
References: <20181023190733.15251-1-maraeo@gmail.com>
 <7690cf4c-5eff-85e4-885c-2ecc9dc01c25@gmail.com>
 <CAAxE2A50X-XGvyx7GcZnnAC4p-bRnXrQpjQZ1D-8pD5ir3QdMQ@mail.gmail.com>
 <e8cf4264-f211-70b3-01ec-34d0eb5e7edb@daenzer.net>
 <CAAxE2A59+J7-jdYobFMMFDhS0oPLS8MgJXzV-Z=N7jhMr9rcdg@mail.gmail.com>
 <CAAxE2A7kA_W3xeK01F7jthfMyEij3TFy_G7=A5_vsduNVrKpbQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0298382138=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <CAAxE2A7kA_W3xeK01F7jthfMyEij3TFy_G7=A5_vsduNVrKpbQ-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
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
Cc: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig-5C7GfCeVMHo@public.gmane.org>, amd-gfx mailing list <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

--===============0298382138==
Content-Type: multipart/alternative; boundary="000000000000ba71ce0579743651"

--000000000000ba71ce0579743651
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 30, 2018, 11:52 AM Marek Ol=C5=A1=C3=A1k <maraeo-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wro=
te:

>
>
> On Tue, Oct 30, 2018, 11:49 AM Marek Ol=C5=A1=C3=A1k <maraeo-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> w=
rote:
>
>>
>>
>> On Tue, Oct 30, 2018, 4:20 AM Michel D=C3=A4nzer <michel-otUistvHUpPR7s880joybQ@public.gmane.org> wr=
ote:
>>
>>> On 2018-10-29 10:15 p.m., Marek Ol=C5=A1=C3=A1k wrote:
>>> > You and I discussed this extensively internally a while ago. It's
>>> expected
>>> > and correct behavior. Mesa doesn't unmap some buffers and never will.
>>>
>>> It doesn't need to keep mapping the same buffer over and over again
>>> though, does it?
>>>
>>
>> It doesnt map it again. It just doesnt unmap. So the next map call just
>> returns the pointer. It's correct to stop the counter wraparound.
>>
>
> Mesa doesn't track whether a buffer is already mapped. Libdrm tracks that=
.
> It's a feature of libdrm to return the same pointer and expect infinite
> number of map calls.
>

Mesa has been having this optimization for 8 years. (since the radeon
winsys). It's surprising that it surprises you now.

Marek



> Marek
>
>
>> Marek
>>
>>
>>>
>>> --
>>> Earthling Michel D=C3=A4nzer               |               http://www.a=
md.com
>>> Libre software enthusiast             |             Mesa and X develope=
r
>>>
>>

--000000000000ba71ce0579743651
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div><br><br><div class=3D"gmail_quote"><div dir=3D"ltr">=
On Tue, Oct 30, 2018, 11:52 AM Marek Ol=C5=A1=C3=A1k &lt;<a href=3D"mailto:=
maraeo-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org">maraeo-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org</a>&gt; wrote:<br></div><blockquote clas=
s=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;pad=
ding-left:1ex"><div dir=3D"auto"><div><br><br><div class=3D"gmail_quote"><d=
iv dir=3D"ltr">On Tue, Oct 30, 2018, 11:49 AM Marek Ol=C5=A1=C3=A1k &lt;<a =
href=3D"mailto:maraeo-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org" target=3D"_blank" rel=3D"noreferrer">marae=
o@gmail.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=
=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex"><div dir=
=3D"auto"><div><br><br><div class=3D"gmail_quote"><div dir=3D"ltr">On Tue, =
Oct 30, 2018, 4:20 AM Michel D=C3=A4nzer &lt;<a href=3D"mailto:michel@daenz=
er.net" rel=3D"noreferrer noreferrer" target=3D"_blank">michel-otUistvHUpPR7s880joybQ@public.gmane.org<=
/a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0=
 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">On 2018-10-29 10:15 =
p.m., Marek Ol=C5=A1=C3=A1k wrote:<br>
&gt; You and I discussed this extensively internally a while ago. It&#39;s =
expected<br>
&gt; and correct behavior. Mesa doesn&#39;t unmap some buffers and never wi=
ll.<br>
<br>
It doesn&#39;t need to keep mapping the same buffer over and over again<br>
though, does it?<br></blockquote></div></div><div dir=3D"auto"><br></div><d=
iv dir=3D"auto">It doesnt map it again. It just doesnt unmap. So the next m=
ap call just returns the pointer. It&#39;s correct to stop the counter wrap=
around.</div></div></blockquote></div></div><div dir=3D"auto"><br></div><di=
v dir=3D"auto">Mesa doesn&#39;t track whether a buffer is already mapped. L=
ibdrm tracks that. It&#39;s a feature of libdrm to return the same pointer =
and expect infinite number of map calls.</div></div></blockquote></div></di=
v><div dir=3D"auto"><br></div><div dir=3D"auto">Mesa has been having this o=
ptimization for 8 years. (since the radeon winsys). It&#39;s surprising tha=
t it surprises you now.</div><div dir=3D"auto"><br></div><div dir=3D"auto">=
Marek</div><div dir=3D"auto"><br></div><div dir=3D"auto"><br></div><div dir=
=3D"auto"><div class=3D"gmail_quote"><blockquote class=3D"gmail_quote" styl=
e=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex"><div di=
r=3D"auto"><div dir=3D"auto"><br></div><div dir=3D"auto">Marek</div><div di=
r=3D"auto"><br></div><div dir=3D"auto"><div class=3D"gmail_quote"><blockquo=
te class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc so=
lid;padding-left:1ex"><div dir=3D"auto"><div dir=3D"auto"><br></div><div di=
r=3D"auto">Marek</div><div dir=3D"auto"><br></div><div dir=3D"auto"><div cl=
ass=3D"gmail_quote"><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0=
 .8ex;border-left:1px #ccc solid;padding-left:1ex">
<br>
<br>
-- <br>
Earthling Michel D=C3=A4nzer=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0|=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0<a href=
=3D"http://www.amd.com" rel=3D"noreferrer noreferrer noreferrer noreferrer"=
 target=3D"_blank">http://www.amd.com</a><br>
Libre software enthusiast=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0Mesa and X developer<br>
</blockquote></div></div></div>
</blockquote></div></div></div>
</blockquote></div></div></div>

--000000000000ba71ce0579743651--

--===============0298382138==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============0298382138==--
