From: "Koenig, Christian" <Christian.Koenig-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH] drm/amdgpu: fix the ib test hang when gfx is in "idle"
 state
Date: Mon, 23 Apr 2018 09:57:06 +0000
Message-ID: <afda993b-2d50-4181-9378-f3440b5d633c@email.android.com>
References: <1524217255-25968-1-git-send-email-ray.huang@amd.com>
 <aaaffd0c-96be-29b2-9bd4-df6fa6ea7e8a@amd.com>,
 <20180423095228.GA23608@hr-amur2>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0490214358=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <20180423095228.GA23608@hr-amur2>
Content-Language: de-DE
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
To: "Huang, Ray" <Ray.Huang-5C7GfCeVMHo@public.gmane.org>
Cc: "Deucher, Alexander" <Alexander.Deucher-5C7GfCeVMHo@public.gmane.org>, "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, "S,
 Shirish" <Shirish.S-5C7GfCeVMHo@public.gmane.org>

--===============0490214358==
Content-Language: de-DE
Content-Type: multipart/alternative;
	boundary="_000_afda993b2d5041819378f3440b5d633cemailandroidcom_"

--_000_afda993b2d5041819378f3440b5d633cemailandroidcom_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hi Ray,

Am 23.04.2018 11:47 schrieb Huang Rui <ray.huang-5C7GfCeVMHo@public.gmane.org>:
On Fri, Apr 20, 2018 at 05:59:16PM +0800, Koenig, Christian wrote:
> Am 20.04.2018 um 11:40 schrieb Huang Rui:
> > "aaabaf4   drm/amdgpu: defer test IBs on the rings at boot (V3)"
> > Above patch defers the execution of gfx/compute ib tests. However, at t=
hat time,
> > the gfx may already go into idle state. If "idle" gfx receives command
> > submission, it will get hang in the system. So we must add is_gfx_on ch=
ecking at
> > start of ib tests.
>
> Do I see that right that you just skip the IB test when the GFX block is
> already turned of? In this case that would be a clear NAK.
>
> BTW: How do you detect that we need to turn GFX on again?

Christian, I know point. But there is a hang issue if we would like try to
disable/enable gfxoff with SMC message at runtime. Actually, I am trying to
find a good sequence to fix it. After that, I can even expose an debugfs
interface to configure that. So I have to skip the test for the moment when
gfx is in "idle".

Working around that issue for the moment is ok, but please note that explic=
itly in both the commit message and a code comment.

But don't you run into the same problem when the UMD starts to submit comma=
nds?

I mean the idea of the IB test is that you "simulate" an userspace command =
submission and see if it works.

Regards,
Christian.


Thanks,
Ray

On Fri, Apr 20, 2018 at 05:59:16PM +0800, Koenig, Christian wrote:
> Am 20.04.2018 um 11:40 schrieb Huang Rui:
> > "aaabaf4   drm/amdgpu: defer test IBs on the rings at boot (V3)"
> > Above patch defers the execution of gfx/compute ib tests. However, at t=
hat time,
> > the gfx may already go into idle state. If "idle" gfx receives command
> > submission, it will get hang in the system. So we must add is_gfx_on ch=
ecking at
> > start of ib tests.
>
> Do I see that right that you just skip the IB test when the GFX block is
> already turned of? In this case that would be a clear NAK.
>
> BTW: How do you detect that we need to turn GFX on again?

Christian, I know point. But there is a hang issue if we would like try to
disable/enable gfxoff with SMC message at runtime. Actually, I am trying to
find a good sequence to fix it. After that, I can even expose an debugfs
interface to configure that. So I have to skip the test for the moment when
gfx is in "idle".

Thanks,
Ray

--_000_afda993b2d5041819378f3440b5d633cemailandroidcom_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
<meta name=3D"Generator" content=3D"Microsoft Exchange Server">
<!-- converted from text --><style><!-- .EmailQuote { margin-left: 1pt; pad=
ding-left: 4pt; border-left: #800000 2px solid; } --></style>
</head>
<body>
<div>
<div dir=3D"auto">
<div>Hi Ray,<br>
<div class=3D"x_gmail_extra"><br>
<div class=3D"x_gmail_quote">Am 23.04.2018 11:47 schrieb Huang Rui &lt;ray.=
huang-5C7GfCeVMHo@public.gmane.org&gt;:<br type=3D"attribution">
<blockquote class=3D"x_quote" style=3D"margin:0 0 0 .8ex; border-left:1px #=
ccc solid; padding-left:1ex">
<div><font size=3D"2"><span style=3D"font-size:11pt">
<div>On Fri, Apr 20, 2018 at 05:59:16PM &#43;0800, Koenig, Christian wrote:=
<br>
&gt; Am 20.04.2018 um 11:40 schrieb Huang Rui:<br>
&gt; &gt; &quot;aaabaf4&nbsp;&nbsp; drm/amdgpu: defer test IBs on the rings=
 at boot (V3)&quot;<br>
&gt; &gt; Above patch defers the execution of gfx/compute ib tests. However=
, at that time,<br>
&gt; &gt; the gfx may already go into idle state. If &quot;idle&quot; gfx r=
eceives command<br>
&gt; &gt; submission, it will get hang in the system. So we must add is_gfx=
_on checking at<br>
&gt; &gt; start of ib tests.<br>
&gt; <br>
&gt; Do I see that right that you just skip the IB test when the GFX block =
is <br>
&gt; already turned of? In this case that would be a clear NAK.<br>
&gt; <br>
&gt; BTW: How do you detect that we need to turn GFX on again?<br>
<br>
Christian, I know point. But there is a hang issue if we would like try to<=
br>
disable/enable gfxoff with SMC message at runtime. Actually, I am trying to=
<br>
find a good sequence to fix it. After that, I can even expose an debugfs<br=
>
interface to configure that. So I have to skip the test for the moment when=
<br>
gfx is in &quot;idle&quot;.<br>
</div>
</span></font></div>
</blockquote>
</div>
</div>
</div>
<div dir=3D"auto"><br>
</div>
<div dir=3D"auto">Working around that issue for the moment is ok, but pleas=
e note that explicitly in both the commit message and a code comment.</div>
<div dir=3D"auto"><br>
</div>
<div dir=3D"auto">But don't you run into the same problem when the UMD star=
ts to submit commands?</div>
<div dir=3D"auto"><br>
</div>
<div dir=3D"auto">I mean the idea of the IB test is that you &quot;simulate=
&quot; an userspace command submission and see if it works.</div>
<div dir=3D"auto"><br>
</div>
<div dir=3D"auto">Regards,</div>
<div dir=3D"auto">Christian.</div>
<div dir=3D"auto"><br>
</div>
<div dir=3D"auto">
<div class=3D"x_gmail_extra">
<div class=3D"x_gmail_quote">
<blockquote class=3D"x_quote" style=3D"margin:0 0 0 .8ex; border-left:1px #=
ccc solid; padding-left:1ex">
<div><font size=3D"2"><span style=3D"font-size:11pt">
<div><br>
Thanks,<br>
Ray<br>
</div>
</span></font></div>
</blockquote>
</div>
<br>
</div>
</div>
</div>
</div>
<font size=3D"2"><span style=3D"font-size:11pt;">
<div class=3D"PlainText">On Fri, Apr 20, 2018 at 05:59:16PM &#43;0800, Koen=
ig, Christian wrote:<br>
&gt; Am 20.04.2018 um 11:40 schrieb Huang Rui:<br>
&gt; &gt; &quot;aaabaf4&nbsp;&nbsp; drm/amdgpu: defer test IBs on the rings=
 at boot (V3)&quot;<br>
&gt; &gt; Above patch defers the execution of gfx/compute ib tests. However=
, at that time,<br>
&gt; &gt; the gfx may already go into idle state. If &quot;idle&quot; gfx r=
eceives command<br>
&gt; &gt; submission, it will get hang in the system. So we must add is_gfx=
_on checking at<br>
&gt; &gt; start of ib tests.<br>
&gt; <br>
&gt; Do I see that right that you just skip the IB test when the GFX block =
is <br>
&gt; already turned of? In this case that would be a clear NAK.<br>
&gt; <br>
&gt; BTW: How do you detect that we need to turn GFX on again?<br>
<br>
Christian, I know point. But there is a hang issue if we would like try to<=
br>
disable/enable gfxoff with SMC message at runtime. Actually, I am trying to=
<br>
find a good sequence to fix it. After that, I can even expose an debugfs<br=
>
interface to configure that. So I have to skip the test for the moment when=
<br>
gfx is in &quot;idle&quot;.<br>
<br>
Thanks,<br>
Ray<br>
</div>
</span></font>
</body>
</html>

--_000_afda993b2d5041819378f3440b5d633cemailandroidcom_--

--===============0490214358==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============0490214358==--
