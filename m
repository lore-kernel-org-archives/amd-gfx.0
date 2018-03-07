From: "Liu, Monk" <Monk.Liu-5C7GfCeVMHo@public.gmane.org>
Subject: deprecated register issues
Date: Wed, 7 Mar 2018 12:11:39 +0000
Message-ID: <BLUPR12MB04496DB9A508E4AEE114AF2484D80@BLUPR12MB0449.namprd12.prod.outlook.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2114131019=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
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
To: "Koenig, Christian" <Christian.Koenig-5C7GfCeVMHo@public.gmane.org>, "Deucher, Alexander" <Alexander.Deucher-5C7GfCeVMHo@public.gmane.org>
Cc: "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

--===============2114131019==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_BLUPR12MB04496DB9A508E4AEE114AF2484D80BLUPR12MB0449namp_"

--_000_BLUPR12MB04496DB9A508E4AEE114AF2484D80BLUPR12MB0449namp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Hi Christian


I remember you and AlexD mentioned that a handful registers are deprecated =
for greenland (gfx9)

e.g. CC_RB_BACKEND_DISABLE


do you know why we still have this routine ?

static u32 gfx_v9_0_get_rb_active_bitmap(struct amdgpu_device *adev)
{
    u32 data, mask;

    data =3D RREG32_SOC15(GC, 0, mmCC_RB_BACKEND_DISABLE);
    data |=3D RREG32_SOC15(GC, 0, mmGC_USER_RB_BACKEND_DISABLE);

    data &=3D CC_RB_BACKEND_DISABLE__BACKEND_DISABLE_MASK;
    data >>=3D GC_USER_RB_BACKEND_DISABLE__BACKEND_DISABLE__SHIFT;

    mask =3D amdgpu_gfx_create_bitmask(adev->gfx.config.max_backends_per_se=
 /
                     adev->gfx.config.max_sh_per_se);

    return (~data) & mask;
}


see that it still read CC_RB_BACKEND_DISABLE


thanks


/Monk


--_000_BLUPR12MB04496DB9A508E4AEE114AF2484D80BLUPR12MB0449namp_
Content-Type: text/html; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Diso-8859-=
1">
<style type=3D"text/css" style=3D"display:none;"><!-- P {margin-top:0;margi=
n-bottom:0;} --></style>
</head>
<body dir=3D"ltr">
<div id=3D"divtagdefaultwrapper" style=3D"font-size:12pt;color:#000000;font=
-family:Calibri,Helvetica,sans-serif;" dir=3D"ltr">
<p style=3D"margin-top:0;margin-bottom:0">Hi Christian</p>
<p style=3D"margin-top:0;margin-bottom:0"><br>
</p>
<p style=3D"margin-top:0;margin-bottom:0">I remember you and AlexD mentione=
d that a handful registers are deprecated for greenland (gfx9)</p>
<p style=3D"margin-top:0;margin-bottom:0">e.g. CC_RB_BACKEND_DISABLE</p>
<p style=3D"margin-top:0;margin-bottom:0"><br>
</p>
<p style=3D"margin-top:0;margin-bottom:0">do you know why we still have thi=
s routine ?</p>
<p style=3D"margin-top:0;margin-bottom:0"></p>
<div style=3D"color: rgb(212, 212, 212); background-color: rgb(30, 30, 30);=
 font-family: &quot;Droid Sans Mono&quot;, monospace, monospace, &quot;Droi=
d Sans Fallback&quot;; font-size: 14px; line-height: 19px; white-space: pre=
;">
<div><span style=3D"color: #569cd6;">static</span> u32 <span style=3D"color=
: #dcdcaa;">
gfx_v9_0_get_rb_active_bitmap</span>(<span style=3D"color: #569cd6;">struct=
</span> amdgpu_device *adev)</div>
<div>{</div>
<div>&nbsp;&nbsp;&nbsp;&nbsp;u32 data, mask;</div>
<br>
<div>&nbsp;&nbsp;&nbsp;&nbsp;data =3D <span style=3D"color: #dcdcaa;">RREG3=
2_SOC15</span>(GC, <span style=3D"color: #b5cea8;">
0</span>, mmCC_RB_BACKEND_DISABLE);</div>
<div>&nbsp;&nbsp;&nbsp;&nbsp;data |=3D <span style=3D"color: #dcdcaa;">RREG=
32_SOC15</span>(GC, <span style=3D"color: #b5cea8;">
0</span>, mmGC_USER_RB_BACKEND_DISABLE);</div>
<br>
<div>&nbsp;&nbsp;&nbsp;&nbsp;data &amp;=3D CC_RB_BACKEND_DISABLE__BACKEND_D=
ISABLE_MASK;</div>
<div>&nbsp;&nbsp;&nbsp;&nbsp;data &gt;&gt;=3D GC_USER_RB_BACKEND_DISABLE__B=
ACKEND_DISABLE__SHIFT;</div>
<br>
<div>&nbsp;&nbsp;&nbsp;&nbsp;mask =3D <span style=3D"color: #dcdcaa;">amdgp=
u_gfx_create_bitmask</span>(adev-&gt;<span style=3D"color: #9cdcfe;">gfx</s=
pan>.<span style=3D"color: #9cdcfe;">config</span>.<span style=3D"color: #9=
cdcfe;">max_backends_per_se</span> /</div>
<div>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;<span style=3D"=
color: #9cdcfe;">gfx</span>.<span style=3D"color: #9cdcfe;">config</span>.<=
span style=3D"color: #9cdcfe;">max_sh_per_se</span>);</div>
<br>
<div>&nbsp;&nbsp;&nbsp;&nbsp;<span style=3D"color: #c586c0;">return</span> =
(~data) &amp; mask;</div>
<div>}</div>
</div>
<br>
<p></p>
<p style=3D"margin-top:0;margin-bottom:0">see that it still read&nbsp;<span=
 style=3D"font-family: Calibri, Helvetica, sans-serif, EmojiFont, &quot;App=
le Color Emoji&quot;, &quot;Segoe UI Emoji&quot;, NotoColorEmoji, &quot;Seg=
oe UI Symbol&quot;, &quot;Android Emoji&quot;, EmojiSymbols; font-size: 16p=
x;">CC_RB_BACKEND_DISABLE</span></p>
<p style=3D"margin-top:0;margin-bottom:0"><span style=3D"font-family: Calib=
ri, Helvetica, sans-serif, EmojiFont, &quot;Apple Color Emoji&quot;, &quot;=
Segoe UI Emoji&quot;, NotoColorEmoji, &quot;Segoe UI Symbol&quot;, &quot;An=
droid Emoji&quot;, EmojiSymbols; font-size: 16px;"><br>
</span></p>
<p style=3D"margin-top:0;margin-bottom:0"><span style=3D"font-family: Calib=
ri, Helvetica, sans-serif, EmojiFont, &quot;Apple Color Emoji&quot;, &quot;=
Segoe UI Emoji&quot;, NotoColorEmoji, &quot;Segoe UI Symbol&quot;, &quot;An=
droid Emoji&quot;, EmojiSymbols; font-size: 16px;">thanks</span></p>
<p style=3D"margin-top:0;margin-bottom:0"><span style=3D"font-family: Calib=
ri, Helvetica, sans-serif, EmojiFont, &quot;Apple Color Emoji&quot;, &quot;=
Segoe UI Emoji&quot;, NotoColorEmoji, &quot;Segoe UI Symbol&quot;, &quot;An=
droid Emoji&quot;, EmojiSymbols; font-size: 16px;"><br>
</span></p>
<p style=3D"margin-top:0;margin-bottom:0"><span style=3D"font-family: Calib=
ri, Helvetica, sans-serif, EmojiFont, &quot;Apple Color Emoji&quot;, &quot;=
Segoe UI Emoji&quot;, NotoColorEmoji, &quot;Segoe UI Symbol&quot;, &quot;An=
droid Emoji&quot;, EmojiSymbols; font-size: 16px;">/Monk</span></p>
<p style=3D"margin-top:0;margin-bottom:0"><br>
</p>
</div>
</body>
</html>

--_000_BLUPR12MB04496DB9A508E4AEE114AF2484D80BLUPR12MB0449namp_--

--===============2114131019==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============2114131019==--
