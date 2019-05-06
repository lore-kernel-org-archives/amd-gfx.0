From: "Deucher, Alexander" <Alexander.Deucher-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH] drm/radeon: prefer lower reference dividers
Date: Mon, 6 May 2019 18:03:01 +0000
Message-ID: <BN6PR12MB1809DC5F6CBF5B4A2FE9E7B6F7300@BN6PR12MB1809.namprd12.prod.outlook.com>
References: <20190506180140.2733-1-christian.koenig@amd.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1920002441=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <20190506180140.2733-1-christian.koenig-5C7GfCeVMHo@public.gmane.org>
Content-Language: en-US
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
To: =?iso-8859-1?Q?Christian_K=F6nig?= <ckoenig.leichtzumerken-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, "dufresnep-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org" <dufresnep-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "werner.lueckel-gM/Ye1E23mwN+BqQ9rBEUg@public.gmane.org" <werner.lueckel-gM/Ye1E23mwN+BqQ9rBEUg@public.gmane.org>

--===============1920002441==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_BN6PR12MB1809DC5F6CBF5B4A2FE9E7B6F7300BN6PR12MB1809namp_"

--_000_BN6PR12MB1809DC5F6CBF5B4A2FE9E7B6F7300BN6PR12MB1809namp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Acked-by: Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org>
________________________________
From: amd-gfx <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org> on behalf of Christia=
n K=F6nig <ckoenig.leichtzumerken-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sent: Monday, May 6, 2019 2:01 PM
To: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org; dufresnep-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org; werner.lueckel@goog=
lemail.com
Subject: [PATCH] drm/radeon: prefer lower reference dividers

[CAUTION: External Email]

Instead of the closest reference divider prefer the lowest,
this fixes flickering issues on HP Compaq nx9420.

Bugs: https://bugs.freedesktop.org/show_bug.cgi?id=3D108514
Suggested-by:  Paul Dufresne <dufresnep-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Signed-off-by: Christian K=F6nig <christian.koenig-5C7GfCeVMHo@public.gmane.org>
---
 drivers/gpu/drm/radeon/radeon_display.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/radeon/radeon_display.c b/drivers/gpu/drm/rade=
on/radeon_display.c
index 9d3ac8b981da..d8e2d7b3b836 100644
--- a/drivers/gpu/drm/radeon/radeon_display.c
+++ b/drivers/gpu/drm/radeon/radeon_display.c
@@ -921,12 +921,12 @@ static void avivo_get_fb_ref_div(unsigned nom, unsign=
ed den, unsigned post_div,
        ref_div_max =3D max(min(100 / post_div, ref_div_max), 1u);

        /* get matching reference and feedback divider */
-       *ref_div =3D min(max(DIV_ROUND_CLOSEST(den, post_div), 1u), ref_div=
_max);
+       *ref_div =3D min(max(den/post_div, 1u), ref_div_max);
        *fb_div =3D DIV_ROUND_CLOSEST(nom * *ref_div * post_div, den);

        /* limit fb divider to its maximum */
        if (*fb_div > fb_div_max) {
-               *ref_div =3D DIV_ROUND_CLOSEST(*ref_div * fb_div_max, *fb_d=
iv);
+               *ref_div =3D (*ref_div * fb_div_max)/(*fb_div);
                *fb_div =3D fb_div_max;
        }
 }
--
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--_000_BN6PR12MB1809DC5F6CBF5B4A2FE9E7B6F7300BN6PR12MB1809namp_
Content-Type: text/html; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Diso-8859-=
1">
<style type=3D"text/css" style=3D"display:none;"> P {margin-top:0;margin-bo=
ttom:0;} </style>
</head>
<body dir=3D"ltr">
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
Acked-by: Alex Deucher &lt;alexander.deucher-5C7GfCeVMHo@public.gmane.org&gt;<br>
</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> amd-gfx &lt;amd-gfx-b=
ounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org&gt; on behalf of Christian K=F6nig &lt;ckoenig=
.leichtzumerken-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org&gt;<br>
<b>Sent:</b> Monday, May 6, 2019 2:01 PM<br>
<b>To:</b> amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org; dufresnep-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org; werner.lueck=
el-gM/Ye1E23mwN+BqQ9rBEUg@public.gmane.org<br>
<b>Subject:</b> [PATCH] drm/radeon: prefer lower reference dividers</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">[CAUTION: External Email]<br>
<br>
Instead of the closest reference divider prefer the lowest,<br>
this fixes flickering issues on HP Compaq nx9420.<br>
<br>
Bugs: <a href=3D"https://bugs.freedesktop.org/show_bug.cgi?id=3D108514">htt=
ps://bugs.freedesktop.org/show_bug.cgi?id=3D108514</a><br>
Suggested-by:&nbsp; Paul Dufresne &lt;dufresnep-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org&gt;<br>
Signed-off-by: Christian K=F6nig &lt;christian.koenig-5C7GfCeVMHo@public.gmane.org&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/radeon/radeon_display.c | 4 &#43;&#43;--<br>
&nbsp;1 file changed, 2 insertions(&#43;), 2 deletions(-)<br>
<br>
diff --git a/drivers/gpu/drm/radeon/radeon_display.c b/drivers/gpu/drm/rade=
on/radeon_display.c<br>
index 9d3ac8b981da..d8e2d7b3b836 100644<br>
--- a/drivers/gpu/drm/radeon/radeon_display.c<br>
&#43;&#43;&#43; b/drivers/gpu/drm/radeon/radeon_display.c<br>
@@ -921,12 &#43;921,12 @@ static void avivo_get_fb_ref_div(unsigned nom, un=
signed den, unsigned post_div,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ref_div_max =3D max(min(100 / po=
st_div, ref_div_max), 1u);<br>
<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* get matching reference and fe=
edback divider */<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *ref_div =3D min(max(DIV_ROUND_CLOSES=
T(den, post_div), 1u), ref_div_max);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *ref_div =3D min(max(den/post_div=
, 1u), ref_div_max);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *fb_div =3D DIV_ROUND_CLOSEST(no=
m * *ref_div * post_div, den);<br>
<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* limit fb divider to its maxim=
um */<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (*fb_div &gt; fb_div_max) {<b=
r>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; *ref_div =3D DIV_ROUND_CLOSEST(*ref_div * fb_div_max, *fb_div);<=
br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; *ref_div =3D (*ref_div * fb_div_max)/(*fb_div);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; *fb_div =3D fb_div_max;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;}<br>
--<br>
2.17.1<br>
<br>
_______________________________________________<br>
amd-gfx mailing list<br>
amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<br>
<a href=3D"https://lists.freedesktop.org/mailman/listinfo/amd-gfx">https://=
lists.freedesktop.org/mailman/listinfo/amd-gfx</a><br>
</div>
</span></font></div>
</body>
</html>

--_000_BN6PR12MB1809DC5F6CBF5B4A2FE9E7B6F7300BN6PR12MB1809namp_--

--===============1920002441==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4

--===============1920002441==--
