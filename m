From: "Koenig, Christian" <Christian.Koenig-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH] drm/amdgpu: fix the ib test hang when gfx is in "idle"
 state
Date: Mon, 23 Apr 2018 13:07:15 +0000
Message-ID: <4bb60ba4-acc6-4c03-a183-cc5ab29c9e53@email.android.com>
References: <1524217255-25968-1-git-send-email-ray.huang@amd.com>
 <aaaffd0c-96be-29b2-9bd4-df6fa6ea7e8a@amd.com>
 <20180423095228.GA23608@hr-amur2>
 <afda993b-2d50-4181-9378-f3440b5d633c@email.android.com>,
 <20180423121341.GA26730@hr-amur2>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1975786471=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <20180423121341.GA26730@hr-amur2>
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

--===============1975786471==
Content-Language: de-DE
Content-Type: multipart/alternative;
	boundary="_000_4bb60ba4acc64c03a183cc5ab29c9e53emailandroidcom_"

--_000_4bb60ba4acc64c03a183cc5ab29c9e53emailandroidcom_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hi Ray,

Am 23.04.2018 14:08 schrieb Huang Rui <ray.huang@amd
On Mon, Apr 23, 2018 at 05:57:06PM +0800, Koenig, Christian wrote:
> Hi Ray,
>
> Am 23.04.2018 11:47 schrieb Huang Rui <ray.huang-5C7GfCeVMHo@public.gmane.org>:
>
>     On Fri, Apr 20, 2018 at 05:59:16PM +0800, Koenig, Christian wrote:
>     > Am 20.04.2018 um 11:40 schrieb Huang Rui:
>     > > "aaabaf4   drm/amdgpu: defer test IBs on the rings at boot (V3)"
>     > > Above patch defers the execution of gfx/compute ib tests. However=
, at
>     that time,
>     > > the gfx may already go into idle state. If "idle" gfx receives co=
mmand
>     > > submission, it will get hang in the system. So we must add is_gfx=
_on
>     checking at
>     > > start of ib tests.
>     >
>     > Do I see that right that you just skip the IB test when the GFX blo=
ck is
>     > already turned of? In this case that would be a clear NAK.
>     >
>     > BTW: How do you detect that we need to turn GFX on again?
>
>     Christian, I know point. But there is a hang issue if we would like t=
ry to
>     disable/enable gfxoff with SMC message at runtime. Actually, I am try=
ing to
>     find a good sequence to fix it. After that, I can even expose an debu=
gfs
>     interface to configure that. So I have to skip the test for the momen=
t when
>     gfx is in "idle".
>
>
> Working around that issue for the moment is ok, but please note that expl=
icitly
> in both the commit message and a code comment.

OK. Will add it at V2.

>
> But don't you run into the same problem when the UMD starts to submit com=
mands?

When UMD starts, RLC firmware will detect the "draw" command, then it will
power up gfx. So it won't have problem at that time. The mainly state
machine doesn't expose to driver side yet.

>
> I mean the idea of the IB test is that you "simulate" an userspace comman=
d
> submission and see if it works.
>

Yes, agree. Any idea to "simulate" the "draw" command? Or please wait for
my fix for enabling/disabling gfxoff at runtime.

Thanks,
Ray

--_000_4bb60ba4acc64c03a183cc5ab29c9e53emailandroidcom_
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
<div class=3D"x_gmail_quote">Am 23.04.2018 14:08 schrieb Huang Rui &lt;ray.=
huang@amd</div>
</div>
</div>
</div>
</div>
<font size=3D"2"><span style=3D"font-size:11pt;">
<div class=3D"PlainText">On Mon, Apr 23, 2018 at 05:57:06PM &#43;0800, Koen=
ig, Christian wrote:<br>
&gt; Hi Ray,<br>
&gt; <br>
&gt; Am 23.04.2018 11:47 schrieb Huang Rui &lt;ray.huang-5C7GfCeVMHo@public.gmane.org&gt;:<br>
&gt; <br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp; On Fri, Apr 20, 2018 at 05:59:16PM &#43;0800, =
Koenig, Christian wrote:<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp; &gt; Am 20.04.2018 um 11:40 schrieb Huang Rui:=
<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp; &gt; &gt; &quot;aaabaf4&nbsp;&nbsp; drm/amdgpu=
: defer test IBs on the rings at boot (V3)&quot;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp; &gt; &gt; Above patch defers the execution of =
gfx/compute ib tests. However, at<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp; that time,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp; &gt; &gt; the gfx may already go into idle sta=
te. If &quot;idle&quot; gfx receives command<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp; &gt; &gt; submission, it will get hang in the =
system. So we must add is_gfx_on<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp; checking at<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp; &gt; &gt; start of ib tests.<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp; &gt;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp; &gt; Do I see that right that you just skip th=
e IB test when the GFX block is<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp; &gt; already turned of? In this case that woul=
d be a clear NAK.<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp; &gt;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp; &gt; BTW: How do you detect that we need to tu=
rn GFX on again?<br>
&gt; <br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp; Christian, I know point. But there is a hang i=
ssue if we would like try to<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp; disable/enable gfxoff with SMC message at runt=
ime. Actually, I am trying to<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp; find a good sequence to fix it. After that, I =
can even expose an debugfs<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp; interface to configure that. So I have to skip=
 the test for the moment when<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp; gfx is in &quot;idle&quot;.<br>
&gt; <br>
&gt; <br>
&gt; Working around that issue for the moment is ok, but please note that e=
xplicitly<br>
&gt; in both the commit message and a code comment.<br>
<br>
OK. Will add it at V2.<br>
<br>
&gt; <br>
&gt; But don't you run into the same problem when the UMD starts to submit =
commands?<br>
<br>
When UMD starts, RLC firmware will detect the &quot;draw&quot; command, the=
n it will<br>
power up gfx. So it won't have problem at that time. The mainly state<br>
machine doesn't expose to driver side yet.<br>
<br>
&gt; <br>
&gt; I mean the idea of the IB test is that you &quot;simulate&quot; an use=
rspace command<br>
&gt; submission and see if it works.<br>
&gt; <br>
<br>
Yes, agree. Any idea to &quot;simulate&quot; the &quot;draw&quot; command? =
Or please wait for<br>
my fix for enabling/disabling gfxoff at runtime.<br>
<br>
Thanks,<br>
Ray<br>
</div>
</span></font>
</body>
</html>

--_000_4bb60ba4acc64c03a183cc5ab29c9e53emailandroidcom_--

--===============1975786471==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============1975786471==--
