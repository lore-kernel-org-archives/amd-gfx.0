From: "Zhu, Rex" <Rex.Zhu-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH] drm/amd/powerplay: improve OD code robustness
Date: Tue, 4 Dec 2018 09:26:36 +0000
Message-ID: <BYAPR12MB2775AD8435E5E236C66DEB57FBAF0@BYAPR12MB2775.namprd12.prod.outlook.com>
References: <BN6PR12MB16679B841BFD99769E90AF9495AF0@BN6PR12MB1667.namprd12.prod.outlook.com>,
 <BN6PR12MB1667EE1F80003C296C5AE25595AF0@BN6PR12MB1667.namprd12.prod.outlook.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2011913723=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <BN6PR12MB1667EE1F80003C296C5AE25595AF0-/b2+HYfkarQtIQV4+4JiuwdYzm3356FpvxpqHgZTriW3zl9H0oFU5g@public.gmane.org>
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
To: "Yin, Tianci (Rico)" <Tianci.Yin-5C7GfCeVMHo@public.gmane.org>, "Zhang, Jerry" <Jerry.Zhang-5C7GfCeVMHo@public.gmane.org>, "Li, Pauline" <Pauline.Li-5C7GfCeVMHo@public.gmane.org>, "Teng, Rui" <Rui.Teng-5C7GfCeVMHo@public.gmane.org>, "Liang, Prike" <Prike.Liang-5C7GfCeVMHo@public.gmane.org>, "Zhu, Changfeng" <Changfeng.Zhu-5C7GfCeVMHo@public.gmane.org>, "Wang, Kevin(Yang)" <Kevin1.Wang-5C7GfCeVMHo@public.gmane.org>, "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

--===============2011913723==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_BYAPR12MB2775AD8435E5E236C66DEB57FBAF0BYAPR12MB2775namp_"

--_000_BYAPR12MB2775AD8435E5E236C66DEB57FBAF0BYAPR12MB2775namp_
Content-Type: text/plain; charset="big5"
Content-Transfer-Encoding: base64

UGxlYXNlIGFkZCAgU2lnbmVkLW9mZi1ieSBpbiB0aGUgcGF0Y2ggY29tbWl0Lg0KDQoNCkV4Y2Vw
dCB0aGF0LA0KDQoNClBhdGNoIGlzDQoNClJldmlld2VkLWJ5OiBSZXggWmh1IDxSZXguWmh1QGFt
ZC5jb20+DQoNCg0KQmVzdCBSZWdhcmRzDQoNClJleA0KDQpfX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fXw0KRnJvbTogWWluLCBUaWFuY2kgKFJpY28pDQpTZW50OiBUdWVzZGF5LCBEZWNl
bWJlciA0LCAyMDE4IDU6MDEgUE0NClRvOiBaaHUsIFJleDsgWmhhbmcsIEplcnJ5OyBMaSwgUGF1
bGluZTsgVGVuZywgUnVpOyBMaWFuZywgUHJpa2U7IFpodSwgQ2hhbmdmZW5nOyBXYW5nLCBLZXZp
bihZYW5nKTsgYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcNClN1YmplY3Q6ILWqzmA6IFtQ
QVRDSF0gZHJtL2FtZC9wb3dlcnBsYXk6IGltcHJvdmUgT0QgY29kZSByb2J1c3RuZXNzDQoNCg0K
aGkgLA0KDQoNCmEgbG93ZXIgcmVxdWVzdCBzeXN0ZW0gY2xvY2sgbWF5IGNhdXNlIGdwdSBoYW5n
LA0KDQphZGQgcHJvdGVjdGlvbiBjb2RlIHRvIGF2b2lkIHRoaXMga2luZCBvZiBpc3N1ZSwNCg0K
cGxzIGhlbHAgdG8gcmV2aWV3Lg0KDQoNCnRoYW5rcyENCg0KDQpSaWNvDQoNCg0KDQo=

--_000_BYAPR12MB2775AD8435E5E236C66DEB57FBAF0BYAPR12MB2775namp_
Content-Type: text/html; charset="big5"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dbig5">
<style type=3D"text/css" style=3D"display:none;"><!-- P {margin-top:0;margi=
n-bottom:0;} --></style>
</head>
<body dir=3D"ltr">
<div id=3D"divtagdefaultwrapper" style=3D"font-size:12pt;color:#000000;font=
-family:Calibri,Helvetica,sans-serif;" dir=3D"ltr">
<p style=3D"margin-top:0;margin-bottom:0">Please add <span>&nbsp;Signed-off=
-by in the patch commit.</span></p>
<p style=3D"margin-top:0;margin-bottom:0"><span><br>
</span></p>
<p style=3D"margin-top:0;margin-bottom:0"><span>Except that,</span></p>
<p style=3D"margin-top:0;margin-bottom:0"><span><br>
</span></p>
<p style=3D"margin-top:0;margin-bottom:0"><span>Patch is <br>
</span></p>
<p style=3D"margin-top:0;margin-bottom:0"><span></p>
<div>Reviewed-by:&nbsp;Rex Zhu &lt;Rex.Zhu-5C7GfCeVMHo@public.gmane.org&gt;</div>
</span><br>
<p></p>
<p style=3D"margin-top:0;margin-bottom:0">Best Regards</p>
<p style=3D"margin-top:0;margin-bottom:0">Rex<br>
</p>
<br>
<div style=3D"color: rgb(0, 0, 0);">
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font style=3D"font-size:11pt" face=
=3D"Calibri, sans-serif" color=3D"#000000"><b>From:</b> Yin, Tianci (Rico)<=
br>
<b>Sent:</b> Tuesday, December 4, 2018 5:01 PM<br>
<b>To:</b> Zhu, Rex; Zhang, Jerry; Li, Pauline; Teng, Rui; Liang, Prike; Zh=
u, Changfeng; Wang, Kevin(Yang); amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<br>
<b>Subject:</b> =B5=AA=CE`: [PATCH] drm/amd/powerplay: improve OD code robu=
stness </font>
<div>&nbsp;</div>
</div>
<div dir=3D"ltr">
<div id=3D"x_divtagdefaultwrapper" dir=3D"ltr" style=3D"font-size:12pt; col=
or:#000000; font-family:Calibri,Helvetica,sans-serif">
<p style=3D"margin-top:0; margin-bottom:0">hi ,</p>
<p style=3D"margin-top:0; margin-bottom:0"><br>
</p>
<p style=3D"margin-top:0; margin-bottom:0">a lower request system clock may=
 cause gpu hang,</p>
<p style=3D"margin-top:0; margin-bottom:0">add protection code to avoid thi=
s kind of issue,</p>
<p style=3D"margin-top:0; margin-bottom:0">pls help to review.</p>
<p style=3D"margin-top:0; margin-bottom:0"><br>
</p>
<p style=3D"margin-top:0; margin-bottom:0">thanks!</p>
<p style=3D"margin-top:0; margin-bottom:0"><br>
</p>
<p style=3D"margin-top:0; margin-bottom:0">Rico<br>
</p>
<div style=3D"color:rgb(0,0,0)">
<div dir=3D"ltr">
<div id=3D"x_x_divtagdefaultwrapper" dir=3D"ltr" style=3D"font-size:12pt; c=
olor:#000000; font-family:Calibri,Helvetica,sans-serif">
<br>
<div><br>
</div>
<div><br>
</div>
<p></p>
</div>
</div>
</div>
</div>
</div>
</div>
</div>
</body>
</html>

--_000_BYAPR12MB2775AD8435E5E236C66DEB57FBAF0BYAPR12MB2775namp_--

--===============2011913723==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============2011913723==--
