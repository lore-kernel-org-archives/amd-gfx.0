From: Alexander Kjeldaas <alexander.kjeldaas-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: PCIe3 atomics requirement for amdkfd
Date: Sat, 23 Dec 2017 17:26:25 +0100
Message-ID: <CAHVSqQe1Tj+PnCR1h+HiHC=fXC81sUG4MXC7jWwmY+TomuU=9w@mail.gmail.com>
References: <c2c34443-9ba1-661b-476d-b657a7ddfe85@redhat.com>
 <3f7e6fed-8668-b469-8813-e6677cb980ca@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1050152725=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <3f7e6fed-8668-b469-8813-e6677cb980ca-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
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
To: =?UTF-8?Q?Felix_K=C3=BChling?= <felix.kuehling-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Felix Kuehling <felix.kuehling-5C7GfCeVMHo@public.gmane.org>, amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, tstellar-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org

--===============1050152725==
Content-Type: multipart/alternative; boundary="94eb2c14ab060e4b8c0561046599"

--94eb2c14ab060e4b8c0561046599
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

 Can the atomic ops work on the modified risers used for mining?

On Dec 23, 2017 16:41, "Felix K=C3=BChling" <felix.kuehling-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrot=
e:

> As I understand it, it would require changes in the ROCr Runtime and in
> the firmware (MEC microcode). It also changes the programming model, so
> it may affect certain applications or higher level language runtimes
> that rely on atomic operations.
>
> Regards,
>   Felix
>
>
> Am 19.12.2017 um 16:04 schrieb Tom Stellard:
> > Hi,
> >
> > How hard of a requirement is PCIe3 atomics for dGPUs with the amdkfd
> > kernel driver?  Is it possible to make modifications to the
> runtime/kernel
> > driver to drop this requirement?
> >
> > -Tom
> > _______________________________________________
> > amd-gfx mailing list
> > amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
> > https://lists.freedesktop.org/mailman/listinfo/amd-gfx
>
>
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
>
>

--94eb2c14ab060e4b8c0561046599
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto">=C2=A0Can the atomic ops work on the modified risers used=
 for mining?</div><div class=3D"gmail_extra"><br><div class=3D"gmail_quote"=
>On Dec 23, 2017 16:41, &quot;Felix K=C3=BChling&quot; &lt;<a href=3D"mailt=
o:felix.kuehling-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org">felix.kuehling-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org</a>&gt; wrote:<br type=
=3D"attribution"><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8=
ex;border-left:1px #ccc solid;padding-left:1ex">As I understand it, it woul=
d require changes in the ROCr Runtime and in<br>
the firmware (MEC microcode). It also changes the programming model, so<br>
it may affect certain applications or higher level language runtimes<br>
that rely on atomic operations.<br>
<br>
Regards,<br>
=C2=A0 Felix<br>
<br>
<br>
Am 19.12.2017 um 16:04 schrieb Tom Stellard:<br>
&gt; Hi,<br>
&gt;<br>
&gt; How hard of a requirement is PCIe3 atomics for dGPUs with the amdkfd<b=
r>
&gt; kernel driver?=C2=A0 Is it possible to make modifications to the runti=
me/kernel<br>
&gt; driver to drop this requirement?<br>
&gt;<br>
&gt; -Tom<br>
&gt; ______________________________<wbr>_________________<br>
&gt; amd-gfx mailing list<br>
&gt; <a href=3D"mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org">amd-gfx-PD4FTy7X32mqWrfYKbYh0A@public.gmane.org=
ktop.org</a><br>
&gt; <a href=3D"https://lists.freedesktop.org/mailman/listinfo/amd-gfx" rel=
=3D"noreferrer" target=3D"_blank">https://lists.freedesktop.org/<wbr>mailma=
n/listinfo/amd-gfx</a><br>
<br>
<br>
<br>______________________________<wbr>_________________<br>
amd-gfx mailing list<br>
<a href=3D"mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org">amd-gfx-PD4FTy7X32lNgt0PjOBp9/rsn8yoX9R0@public.gmane.org=
org</a><br>
<a href=3D"https://lists.freedesktop.org/mailman/listinfo/amd-gfx" rel=3D"n=
oreferrer" target=3D"_blank">https://lists.freedesktop.org/<wbr>mailman/lis=
tinfo/amd-gfx</a><br>
<br></blockquote></div></div>

--94eb2c14ab060e4b8c0561046599--

--===============1050152725==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============1050152725==--
