From: "Koenig, Christian" <Christian.Koenig-5C7GfCeVMHo@public.gmane.org>
Subject: Re: regression in ttm
Date: Tue, 4 Dec 2018 17:35:00 +0000
Message-ID: <2808395a-058b-4f85-b235-eead75cd3e20@email.android.com>
References: <f3dd49e5-5573-8344-6224-f3c24d1eefe6@amd.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1135170678=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <f3dd49e5-5573-8344-6224-f3c24d1eefe6-5C7GfCeVMHo@public.gmane.org>
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
To: "StDenis, Tom" <Tom.StDenis-5C7GfCeVMHo@public.gmane.org>
Cc: "Zhang, Jerry" <Jerry.Zhang-5C7GfCeVMHo@public.gmane.org>, "Huang, Ray" <Ray.Huang-5C7GfCeVMHo@public.gmane.org>, "Daenzer, Michel" <Michel.Daenzer-5C7GfCeVMHo@public.gmane.org>, amd-gfx mailing list <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

--===============1135170678==
Content-Language: de-DE
Content-Type: multipart/alternative;
	boundary="_000_2808395a058b4f85b235eead75cd3e20emailandroidcom_"

--_000_2808395a058b4f85b235eead75cd3e20emailandroidcom_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Thanks, going to take a look tomorrow.

Christian.

Am 04.12.2018 18:28 schrieb "StDenis, Tom" <Tom.StDenis-5C7GfCeVMHo@public.gmane.org>:
This commit causes a regression on my Carrizo running piglit (dmesg
attached)

commit 5786b66c9e3b7b18f3c24566e70cae450969cb14
Refs: v4.20-rc3-498-g5786b66c9e3b
Author:     Christian K=F6nig <christian.koenig-5C7GfCeVMHo@public.gmane.org>
AuthorDate: Mon Sep 24 13:35:53 2018 +0200
Commit:     Christian K=F6nig <christian.koenig-5C7GfCeVMHo@public.gmane.org>
CommitDate: Tue Dec 4 10:22:22 2018 +0100

     drm/ttm: drop the extra reservation for pipelined BO moves

     The driver is now responsible to allocate enough shared slots.

     Signed-off-by: Christian K=F6nig <christian.koenig-5C7GfCeVMHo@public.gmane.org>
     Reviewed-by: Michel D=E4nzer <michel.daenzer-5C7GfCeVMHo@public.gmane.org>
     Reviewed-by: Junwei Zhang <Jerry.Zhang-5C7GfCeVMHo@public.gmane.org>
     Reviewed-by: Huang Rui <ray.huang-5C7GfCeVMHo@public.gmane.org>

Tom.

--_000_2808395a058b4f85b235eead75cd3e20emailandroidcom_
Content-Type: text/html; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Diso-8859-=
1">
<meta name=3D"Generator" content=3D"Microsoft Exchange Server">
<!-- converted from text --><style><!-- .EmailQuote { margin-left: 1pt; pad=
ding-left: 4pt; border-left: #800000 2px solid; } --></style>
</head>
<body>
<div>
<div dir=3D"auto">Thanks, going to take a look tomorrow.
<div dir=3D"auto"><br>
</div>
<div dir=3D"auto">Christian.</div>
</div>
<div class=3D"x_gmail_extra"><br>
<div class=3D"x_gmail_quote">Am 04.12.2018 18:28 schrieb &quot;StDenis, Tom=
&quot; &lt;Tom.StDenis-5C7GfCeVMHo@public.gmane.org&gt;:<br type=3D"attribution">
</div>
</div>
</div>
<font size=3D"2"><span style=3D"font-size:11pt;">
<div class=3D"PlainText">This commit causes a regression on my Carrizo runn=
ing piglit (dmesg
<br>
attached)<br>
<br>
commit 5786b66c9e3b7b18f3c24566e70cae450969cb14<br>
Refs: v4.20-rc3-498-g5786b66c9e3b<br>
Author:&nbsp;&nbsp;&nbsp;&nbsp; Christian K=F6nig &lt;christian.koenig@amd.=
com&gt;<br>
AuthorDate: Mon Sep 24 13:35:53 2018 &#43;0200<br>
Commit:&nbsp;&nbsp;&nbsp;&nbsp; Christian K=F6nig &lt;christian.koenig@amd.=
com&gt;<br>
CommitDate: Tue Dec 4 10:22:22 2018 &#43;0100<br>
<br>
&nbsp;&nbsp;&nbsp;&nbsp; drm/ttm: drop the extra reservation for pipelined =
BO moves<br>
<br>
&nbsp;&nbsp;&nbsp;&nbsp; The driver is now responsible to allocate enough s=
hared slots.<br>
<br>
&nbsp;&nbsp;&nbsp;&nbsp; Signed-off-by: Christian K=F6nig &lt;christian.koe=
nig-5C7GfCeVMHo@public.gmane.org&gt;<br>
&nbsp;&nbsp;&nbsp;&nbsp; Reviewed-by: Michel D=E4nzer &lt;michel.daenzer@am=
d.com&gt;<br>
&nbsp;&nbsp;&nbsp;&nbsp; Reviewed-by: Junwei Zhang &lt;Jerry.Zhang-5C7GfCeVMHo@public.gmane.org&=
gt;<br>
&nbsp;&nbsp;&nbsp;&nbsp; Reviewed-by: Huang Rui &lt;ray.huang-5C7GfCeVMHo@public.gmane.org&gt;<b=
r>
<br>
Tom.<br>
</div>
</span></font>
</body>
</html>

--_000_2808395a058b4f85b235eead75cd3e20emailandroidcom_--

--===============1135170678==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============1135170678==--
