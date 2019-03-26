From: "Quan, Evan" <Evan.Quan-5C7GfCeVMHo@public.gmane.org>
Subject: RE: [PATCH 1/3] drm/amdgpu: Stop returning EINVAL during profile
 switch
Date: Tue, 26 Mar 2019 09:09:37 +0000
Message-ID: <MN2PR12MB334481F582B040EB2CE30AB2E45F0@MN2PR12MB3344.namprd12.prod.outlook.com>
References: <20190325124120.7793-1-kent.russell@amd.com>,
 <MN2PR12MB3344372CF30753A2F0556109E45E0@MN2PR12MB3344.namprd12.prod.outlook.com>
 <BN6PR12MB1618F581D7E429F48154C804855E0@BN6PR12MB1618.namprd12.prod.outlook.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1109892075=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <BN6PR12MB1618F581D7E429F48154C804855E0-/b2+HYfkarRqaFUXYJa4HgdYzm3356FpvxpqHgZTriW3zl9H0oFU5g@public.gmane.org>
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
To: "Russell, Kent" <Kent.Russell-5C7GfCeVMHo@public.gmane.org>, "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

--===============1109892075==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_MN2PR12MB334481F582B040EB2CE30AB2E45F0MN2PR12MB3344namp_"

--_000_MN2PR12MB334481F582B040EB2CE30AB2E45F0MN2PR12MB3344namp_
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64

VGhhdCBzZWVtcyBhIGJ1Zy4gSSB3aWxsIGZpeCB0aGF0Lg0KSXShr3MgT0sgdG8gc3RvcmUgcHJl
dmlvdXMgQ1VTVE9NIHByb2ZpbGUgc2V0dGluZ3MgaW4gZHJpdmVyIGFuZCBzd2l0Y2ggYmFjayB0
byB0aGF0IHdpdGggbm8gbmVlZCB0byBwYXNzIGluIHNldHRpbmdzIGFnYWluLiBUaGF0IG1ha2Vz
IHNlbnNlLg0KQnV0IHlvdSBtYXkgbmVlZCB0byB1cGRhdGUgdGhlIHBhdGNoKHRvIGNoZWNrIHdo
ZXRoZXIgdGhlcmUgaXMgcHJldmlvdXMgY3VzdG9tIHByb2ZpbGUgc2V0dGluZ3MpLg0KDQpSZWdh
cmRzLA0KRXZhbg0KRnJvbTogYW1kLWdmeCA8YW1kLWdmeC1ib3VuY2VzQGxpc3RzLmZyZWVkZXNr
dG9wLm9yZz4gT24gQmVoYWxmIE9mIFJ1c3NlbGwsIEtlbnQNClNlbnQ6IDIwMTnE6jPUwjI2yNUg
MDowMA0KVG86IFF1YW4sIEV2YW4gPEV2YW4uUXVhbkBhbWQuY29tPjsgYW1kLWdmeEBsaXN0cy5m
cmVlZGVza3RvcC5vcmcNClN1YmplY3Q6IFJlOiBbUEFUQ0ggMS8zXSBkcm0vYW1kZ3B1OiBTdG9w
IHJldHVybmluZyBFSU5WQUwgZHVyaW5nIHByb2ZpbGUgc3dpdGNoDQoNCkkgc2V0IENVU1RPTSB0
byBhIHdlaXJkIHZhbHVlIGxpa2UgIjEgMiAzIDQgNSA2IiAsIHRoZW4gc3dpdGNoZWQgdG8gVlIg
cHJvZmlsZSwgdGhlbiBzd2l0Y2hlZCBiYWNrIHRvIENVU1RPTSAoanVzdCB3aXRoICJlY2hvIDYg
PiBwcm9maWxlKSwgYW5kIGl0IGtlcHQgbXkgY3VzdG9tIHZhbHVlcy4gQmVmb3JlIHRoaXMgcGF0
Y2gsIGl0IHRocm93cyBFSU5WQUwgYnV0IHN0aWxsIHN3aXRjaGVzIGl0IHRvIENVU1RPTSB3aXRo
IHRoZSBzYXZlZCB2YWx1ZXMsIG9uIGJvdGggdmVnYTEwIGFuZCB2ZWdhMjAuDQoNCktlbnQNCg0K
S0VOVCBSVVNTRUxMDQpTci4gU29mdHdhcmUgRW5naW5lZXIgfCBMaW51eCBDb21wdXRlIEtlcm5l
bA0KMSBDb21tZXJjZSBWYWxsZXkgRHJpdmUgRWFzdA0KTWFya2hhbSwgT04gTDNUIDdYNg0KTyAr
KDEpIDI4OS02OTUtMjEyMiB8IEV4dCA3MjEyMg0KX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX18NCkZyb206IFF1YW4sIEV2YW4NClNlbnQ6IE1vbmRheSwgTWFyY2ggMjUsIDIwMTkgMTA6
MTQ6MDMgQU0NClRvOiBSdXNzZWxsLCBLZW50OyBhbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9y
ZzxtYWlsdG86YW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmc+DQpDYzogUnVzc2VsbCwgS2Vu
dA0KU3ViamVjdDogUkU6IFtQQVRDSCAxLzNdIGRybS9hbWRncHU6IFN0b3AgcmV0dXJuaW5nIEVJ
TlZBTCBkdXJpbmcgcHJvZmlsZSBzd2l0Y2gNCg0KSG93IGNhbiB5b3UgdGVsbCB3aGV0aGVyIGl0
IHdhcyBhbHJlYWR5IGFwcGxpZWQgYmVmb3JlIG9yIDFzdCB0aW1lIHRvIHN3aXRjaCB0byBjb21w
dXRlIG1vZGU/DQpGb3IgdGhlIGxhdHRlciBjYXNlLCBvdGhlciBzZXR0aW5ncy9wYXJhbWV0ZXJz
IGRvIG5lZWQuDQoNClJlZ2FyZHMsDQpFdmFuDQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0t
DQo+IEZyb206IGFtZC1nZnggPGFtZC1nZngtYm91bmNlc0BsaXN0cy5mcmVlZGVza3RvcC5vcmc8
bWFpbHRvOmFtZC1nZngtYm91bmNlc0BsaXN0cy5mcmVlZGVza3RvcC5vcmc+PiBPbiBCZWhhbGYg
T2YNCj4gUnVzc2VsbCwgS2VudA0KPiBTZW50OiAyMDE5xOoz1MIyNcjVIDIwOjQyDQo+IFRvOiBh
bWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZzxtYWlsdG86YW1kLWdmeEBsaXN0cy5mcmVlZGVz
a3RvcC5vcmc+DQo+IENjOiBSdXNzZWxsLCBLZW50IDxLZW50LlJ1c3NlbGxAYW1kLmNvbTxtYWls
dG86S2VudC5SdXNzZWxsQGFtZC5jb20+Pg0KPiBTdWJqZWN0OiBbUEFUQ0ggMS8zXSBkcm0vYW1k
Z3B1OiBTdG9wIHJldHVybmluZyBFSU5WQUwgZHVyaW5nIHByb2ZpbGUNCj4gc3dpdGNoDQo+DQo+
IERvbid0IHJldHVybiBhbiBlcnJvciBhZnRlciBzd2l0Y2hpbmcgdG8gdGhlIENVU1RPTSBwcm9m
aWxlLCBpZiB0aGVyZSBhcmVuJ3QNCj4gYW55IENVU1RPTSB2YWx1ZXMgcGFzc2VkIGluLiBUaGUg
Q1VTVE9NIHByb2ZpbGUgaXMgYWxyZWFkeSBhcHBsaWVkLCBzbyBpZg0KPiBubyBvdGhlciBhcmd1
bWVudHMgYXJlIHBhc3NlZCwganVzdCByZXR1cm4gaW5zdGVhZCBvZiB0aHJvd2luZyAtRUlOVkFM
DQo+IHdoZW4gc3VjY2Vzc2Z1bA0KPg0KPiBDaGFuZ2UtSWQ6IEkxMTRjYzk3ODMyMjZlZTllYmIx
NDY4NjM4OTdlOTUxNTI3YTg1ZTIwDQo+IFNpZ25lZC1vZmYtYnk6IEtlbnQgUnVzc2VsbCA8a2Vu
dC5ydXNzZWxsQGFtZC5jb208bWFpbHRvOmtlbnQucnVzc2VsbEBhbWQuY29tPj4NCj4gLS0tDQo+
ICBkcml2ZXJzL2dwdS9kcm0vYW1kL3Bvd2VycGxheS9od21nci92ZWdhMTBfaHdtZ3IuYyB8IDYg
KysrKystDQo+IGRyaXZlcnMvZ3B1L2RybS9hbWQvcG93ZXJwbGF5L2h3bWdyL3ZlZ2EyMF9od21n
ci5jIHwgNSArKysrLQ0KPiAgMiBmaWxlcyBjaGFuZ2VkLCA5IGluc2VydGlvbnMoKyksIDIgZGVs
ZXRpb25zKC0pDQo+DQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL3Bvd2VycGxh
eS9od21nci92ZWdhMTBfaHdtZ3IuYw0KPiBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvcG93ZXJwbGF5
L2h3bWdyL3ZlZ2ExMF9od21nci5jDQo+IGluZGV4IGVkNmM2Mzg3MDBmNS4uYTk4YjkyNzI4MmFj
IDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL3Bvd2VycGxheS9od21nci92ZWdh
MTBfaHdtZ3IuYw0KPiArKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL3Bvd2VycGxheS9od21nci92
ZWdhMTBfaHdtZ3IuYw0KPiBAQCAtNDkxMSw3ICs0OTExLDExIEBAIHN0YXRpYyBpbnQgdmVnYTEw
X3NldF9wb3dlcl9wcm9maWxlX21vZGUoc3RydWN0DQo+IHBwX2h3bWdyICpod21nciwgbG9uZyAq
aW5wdXQsIHVpDQo+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgMTw8aHdtZ3ItDQo+ID5wb3dlcl9wcm9maWxlX21vZGUpOw0KPg0KPiAgICAgICAgaWYgKGh3
bWdyLT5wb3dlcl9wcm9maWxlX21vZGUgPT0NCj4gUFBfU01DX1BPV0VSX1BST0ZJTEVfQ1VTVE9N
KSB7DQo+IC0gICAgICAgICAgICAgaWYgKHNpemUgPT0gMCB8fCBzaXplID4gNCkNCj4gKyAgICAg
ICAgICAgICAvKiBJZiBzaXplID0gMCwgdGhlbiBqdXN0IHJldHVybiwgaXQgd2FzIGFwcGxpZWQg
YWJvdmUgKi8NCj4gKyAgICAgICAgICAgICBpZiAoc2l6ZSA9PSAwKQ0KPiArICAgICAgICAgICAg
ICAgICAgICAgcmV0dXJuIDA7DQo+ICsNCj4gKyAgICAgICAgICAgICBpZiAoc2l6ZSAhPSA0KQ0K
PiAgICAgICAgICAgICAgICAgICAgICAgIHJldHVybiAtRUlOVkFMOw0KPg0KPiAgICAgICAgICAg
ICAgICBkYXRhLT5jdXN0b21fcHJvZmlsZV9tb2RlWzBdID0gYnVzeV9zZXRfcG9pbnQgPSBpbnB1
dFswXTsNCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvcG93ZXJwbGF5L2h3bWdy
L3ZlZ2EyMF9od21nci5jDQo+IGIvZHJpdmVycy9ncHUvZHJtL2FtZC9wb3dlcnBsYXkvaHdtZ3Iv
dmVnYTIwX2h3bWdyLmMNCj4gaW5kZXggNjY0NTQ0ZTdmY2RjLi4yMjViMjEwMmM4MmMgMTAwNjQ0
DQo+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvcG93ZXJwbGF5L2h3bWdyL3ZlZ2EyMF9od21n
ci5jDQo+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvcG93ZXJwbGF5L2h3bWdyL3ZlZ2EyMF9o
d21nci5jDQo+IEBAIC0zODI4LDggKzM4MjgsMTEgQEAgc3RhdGljIGludCB2ZWdhMjBfc2V0X3Bv
d2VyX3Byb2ZpbGVfbW9kZShzdHJ1Y3QNCj4gcHBfaHdtZ3IgKmh3bWdyLCBsb25nICppbnB1dCwg
dWkNCj4gICAgICAgIH0NCj4NCj4gICAgICAgIGlmIChod21nci0+cG93ZXJfcHJvZmlsZV9tb2Rl
ID09DQo+IFBQX1NNQ19QT1dFUl9QUk9GSUxFX0NVU1RPTSkgew0KPiAtICAgICAgICAgICAgIGlm
IChzaXplIDwgMTApDQo+ICsgICAgICAgICAgICAgaWYgKHNpemUgPCAxMCAmJiBzaXplICE9IDAp
DQo+ICAgICAgICAgICAgICAgICAgICAgICAgcmV0dXJuIC1FSU5WQUw7DQo+ICsgICAgICAgICAg
ICAgLyogSWYgc2l6ZSA9IDAsIHRoZW4ganVzdCByZXR1cm4sIGl0IHdhcyBhcHBsaWVkIGFib3Zl
ICovDQo+ICsgICAgICAgICAgICAgaWYgKHNpemUgPT0gMCkNCj4gKyAgICAgICAgICAgICAgICAg
ICAgIHJldHVybiAwOw0KPg0KPiAgICAgICAgICAgICAgICByZXN1bHQgPSB2ZWdhMjBfZ2V0X2Fj
dGl2aXR5X21vbml0b3JfY29lZmYoaHdtZ3IsDQo+ICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAodWludDhfdCAqKSgmYWN0aXZpdHlfbW9uaXRvciksDQo+IC0tDQo+IDIuMTcuMQ0KPg0K
PiBfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXw0KPiBhbWQt
Z2Z4IG1haWxpbmcgbGlzdA0KPiBhbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZzxtYWlsdG86
YW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmc+DQo+IGh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0
b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeA0K

--_000_MN2PR12MB334481F582B040EB2CE30AB2E45F0MN2PR12MB3344namp_
Content-Type: text/html; charset="gb2312"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dgb2312">
<meta name=3D"Generator" content=3D"Microsoft Word 15 (filtered medium)">
<!--[if !mso]><style>v\:* {behavior:url(#default#VML);}
o\:* {behavior:url(#default#VML);}
w\:* {behavior:url(#default#VML);}
.shape {behavior:url(#default#VML);}
</style><![endif]--><style><!--
/* Font Definitions */
@font-face
	{font-family:"Cambria Math";
	panose-1:2 4 5 3 5 4 6 3 2 4;}
@font-face
	{font-family:DengXian;
	panose-1:2 1 6 0 3 1 1 1 1 1;}
@font-face
	{font-family:Calibri;
	panose-1:2 15 5 2 2 2 4 3 2 4;}
@font-face
	{font-family:DengXian;
	panose-1:2 1 6 0 3 1 1 1 1 1;}
@font-face
	{font-family:"MS PGothic";
	panose-1:2 11 6 0 7 2 5 8 2 4;}
@font-face
	{font-family:"\@MS PGothic";}
/* Style Definitions */
p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0cm;
	margin-bottom:.0001pt;
	font-size:12.0pt;
	font-family:"MS PGothic",sans-serif;
	mso-fareast-language:JA;}
a:link, span.MsoHyperlink
	{mso-style-priority:99;
	color:blue;
	text-decoration:underline;}
a:visited, span.MsoHyperlinkFollowed
	{mso-style-priority:99;
	color:purple;
	text-decoration:underline;}
p.msonormal0, li.msonormal0, div.msonormal0
	{mso-style-name:msonormal;
	mso-margin-top-alt:auto;
	margin-right:0cm;
	mso-margin-bottom-alt:auto;
	margin-left:0cm;
	font-size:12.0pt;
	font-family:"MS PGothic",sans-serif;
	mso-fareast-language:JA;}
span.EmailStyle19
	{mso-style-type:personal-reply;
	font-family:"Calibri",sans-serif;
	color:windowtext;}
.MsoChpDefault
	{mso-style-type:export-only;
	font-size:10.0pt;}
@page WordSection1
	{size:612.0pt 792.0pt;
	margin:72.0pt 90.0pt 72.0pt 90.0pt;}
div.WordSection1
	{page:WordSection1;}
--></style><!--[if gte mso 9]><xml>
<o:shapedefaults v:ext=3D"edit" spidmax=3D"1026" />
</xml><![endif]--><!--[if gte mso 9]><xml>
<o:shapelayout v:ext=3D"edit">
<o:idmap v:ext=3D"edit" data=3D"1" />
</o:shapelayout></xml><![endif]-->
</head>
<body lang=3D"EN-US" link=3D"blue" vlink=3D"purple">
<div class=3D"WordSection1">
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ca=
libri&quot;,sans-serif;mso-fareast-language:ZH-CN">That seems a bug. I will=
 fix that.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ca=
libri&quot;,sans-serif;mso-fareast-language:ZH-CN">It=A1=AFs OK to store pr=
evious CUSTOM profile settings in driver and switch back to that with no ne=
ed to pass in settings again. That makes sense.
<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ca=
libri&quot;,sans-serif;mso-fareast-language:ZH-CN">But you may need to upda=
te the patch(to check whether there is previous custom profile settings).<o=
:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ca=
libri&quot;,sans-serif;mso-fareast-language:ZH-CN"><o:p>&nbsp;</o:p></span>=
</p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ca=
libri&quot;,sans-serif;mso-fareast-language:ZH-CN">Regards,<o:p></o:p></spa=
n></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ca=
libri&quot;,sans-serif;mso-fareast-language:ZH-CN">Evan<o:p></o:p></span></=
p>
<div style=3D"border:none;border-left:solid blue 1.5pt;padding:0cm 0cm 0cm =
4.0pt">
<div>
<div style=3D"border:none;border-top:solid #E1E1E1 1.0pt;padding:3.0pt 0cm =
0cm 0cm">
<p class=3D"MsoNormal"><b><span style=3D"font-size:11.0pt;font-family:&quot=
;Calibri&quot;,sans-serif">From:</span></b><span style=3D"font-size:11.0pt;=
font-family:&quot;Calibri&quot;,sans-serif"> amd-gfx &lt;amd-gfx-bounces@li=
sts.freedesktop.org&gt;
<b>On Behalf Of </b>Russell, Kent<br>
<b>Sent:</b> 2019</span><span lang=3D"JA" style=3D"font-size:11.0pt">=C4=EA=
</span><span style=3D"font-size:11.0pt;font-family:&quot;Calibri&quot;,sans=
-serif">3</span><span lang=3D"JA" style=3D"font-size:11.0pt">=D4=C2</span><=
span style=3D"font-size:11.0pt;font-family:&quot;Calibri&quot;,sans-serif">=
26</span><span lang=3D"JA" style=3D"font-size:11.0pt">=C8=D5</span><span st=
yle=3D"font-size:11.0pt;font-family:&quot;Calibri&quot;,sans-serif">
 0:00<br>
<b>To:</b> Quan, Evan &lt;Evan.Quan-5C7GfCeVMHo@public.gmane.org&gt;; amd-gfx-PD4FTy7X32lNgt0PjOBp9/rsn8yoX9R0@public.gmane.org=
org<br>
<b>Subject:</b> Re: [PATCH 1/3] drm/amdgpu: Stop returning EINVAL during pr=
ofile switch<o:p></o:p></span></p>
</div>
</div>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">I set CUSTOM to a weird value like &quot;1 2 3 4 5 6=
&quot; , then switched to VR profile, then switched back to CUSTOM (just wi=
th &quot;echo 6 &gt; profile), and it kept my custom values. Before this pa=
tch, it throws EINVAL but still switches it to CUSTOM
 with the saved values, on both vega10 and vega20.<br>
<br>
Kent<br>
<br>
KENT RUSSELL<br>
Sr. Software Engineer | Linux Compute Kernel<br>
1 Commerce Valley Drive East<br>
Markham, ON L3T 7X6<br>
O &#43;(1) 289-695-2122 | Ext 72122<o:p></o:p></p>
<div class=3D"MsoNormal" align=3D"center" style=3D"text-align:center">
<hr size=3D"2" width=3D"98%" align=3D"center">
</div>
<div id=3D"divRplyFwdMsg">
<p class=3D"MsoNormal"><b><span style=3D"font-size:11.0pt;font-family:&quot=
;Calibri&quot;,sans-serif;color:black">From:</span></b><span style=3D"font-=
size:11.0pt;font-family:&quot;Calibri&quot;,sans-serif;color:black"> Quan, =
Evan<br>
<b>Sent:</b> Monday, March 25, 2019 10:14:03 AM<br>
<b>To:</b> Russell, Kent; <a href=3D"mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org">=
amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org</a><br>
<b>Cc:</b> Russell, Kent<br>
<b>Subject:</b> RE: [PATCH 1/3] drm/amdgpu: Stop returning EINVAL during pr=
ofile switch</span>
<o:p></o:p></p>
<div>
<p class=3D"MsoNormal">&nbsp;<o:p></o:p></p>
</div>
</div>
<div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">How can you tell wh=
ether it was already applied before or 1st time to switch to compute mode?<=
br>
For the latter case, other settings/parameters do need.<br>
<br>
Regards,<br>
Evan<br>
&gt; -----Original Message-----<br>
&gt; From: amd-gfx &lt;<a href=3D"mailto:amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9/rsn8yoX9R0@public.gmane.org=
org">amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org</a>&gt; On Behalf Of<br>
&gt; Russell, Kent<br>
&gt; Sent: 2019<span lang=3D"JA">=C4=EA</span>3<span lang=3D"JA">=D4=C2</sp=
an>25<span lang=3D"JA">=C8=D5</span> 20:42<br>
&gt; To: <a href=3D"mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org">amd-gfx-PD4FTy7X32mzQB+pC5nmwQ@public.gmane.org=
edesktop.org</a><br>
&gt; Cc: Russell, Kent &lt;<a href=3D"mailto:Kent.Russell-5C7GfCeVMHo@public.gmane.org">Kent.Rus=
sell-5C7GfCeVMHo@public.gmane.org</a>&gt;<br>
&gt; Subject: [PATCH 1/3] drm/amdgpu: Stop returning EINVAL during profile<=
br>
&gt; switch<br>
&gt; <br>
&gt; Don't return an error after switching to the CUSTOM profile, if there =
aren't<br>
&gt; any CUSTOM values passed in. The CUSTOM profile is already applied, so=
 if<br>
&gt; no other arguments are passed, just return instead of throwing -EINVAL=
<br>
&gt; when successful<br>
&gt; <br>
&gt; Change-Id: I114cc9783226ee9ebb146863897e951527a85e20<br>
&gt; Signed-off-by: Kent Russell &lt;<a href=3D"mailto:kent.russell-5C7GfCeVMHo@public.gmane.org=
">kent.russell-5C7GfCeVMHo@public.gmane.org</a>&gt;<br>
&gt; ---<br>
&gt;&nbsp; drivers/gpu/drm/amd/powerplay/hwmgr/vega10_hwmgr.c | 6 &#43;&#43=
;&#43;&#43;&#43;-<br>
&gt; drivers/gpu/drm/amd/powerplay/hwmgr/vega20_hwmgr.c | 5 &#43;&#43;&#43;=
&#43;-<br>
&gt;&nbsp; 2 files changed, 9 insertions(&#43;), 2 deletions(-)<br>
&gt; <br>
&gt; diff --git a/drivers/gpu/drm/amd/powerplay/hwmgr/vega10_hwmgr.c<br>
&gt; b/drivers/gpu/drm/amd/powerplay/hwmgr/vega10_hwmgr.c<br>
&gt; index ed6c638700f5..a98b927282ac 100644<br>
&gt; --- a/drivers/gpu/drm/amd/powerplay/hwmgr/vega10_hwmgr.c<br>
&gt; &#43;&#43;&#43; b/drivers/gpu/drm/amd/powerplay/hwmgr/vega10_hwmgr.c<b=
r>
&gt; @@ -4911,7 &#43;4911,11 @@ static int vega10_set_power_profile_mode(st=
ruct<br>
&gt; pp_hwmgr *hwmgr, long *input, ui<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 1&lt;&lt;hwmg=
r-<br>
&gt; &gt;power_profile_mode);<br>
&gt; <br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (hwmgr-&gt;power_profile_=
mode =3D=3D<br>
&gt; PP_SMC_POWER_PROFILE_CUSTOM) {<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; if (size =3D=3D 0 || size &gt; 4)<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; /* If size =3D 0, then just return, it was applied above */<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; if (size =3D=3D 0)<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
&gt; &#43;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; if (size !=3D 4)<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return =
-EINVAL;<br>
&gt; <br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; data-&gt;custom_profile_mode[0] =3D busy_set_point =3D =
input[0];<br>
&gt; diff --git a/drivers/gpu/drm/amd/powerplay/hwmgr/vega20_hwmgr.c<br>
&gt; b/drivers/gpu/drm/amd/powerplay/hwmgr/vega20_hwmgr.c<br>
&gt; index 664544e7fcdc..225b2102c82c 100644<br>
&gt; --- a/drivers/gpu/drm/amd/powerplay/hwmgr/vega20_hwmgr.c<br>
&gt; &#43;&#43;&#43; b/drivers/gpu/drm/amd/powerplay/hwmgr/vega20_hwmgr.c<b=
r>
&gt; @@ -3828,8 &#43;3828,11 @@ static int vega20_set_power_profile_mode(st=
ruct<br>
&gt; pp_hwmgr *hwmgr, long *input, ui<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt; <br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (hwmgr-&gt;power_profile_=
mode =3D=3D<br>
&gt; PP_SMC_POWER_PROFILE_CUSTOM) {<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; if (size &lt; 10)<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; if (size &lt; 10 &amp;&amp; size !=3D 0)<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return =
-EINVAL;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; /* If size =3D 0, then just return, it was applied above */<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; if (size =3D=3D 0)<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
&gt; <br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; result =3D vega20_get_activity_monitor_coeff(hwmgr,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (uint8_t *)(&amp;activity_monitor)=
,<br>
&gt; --<br>
&gt; 2.17.1<br>
&gt; <br>
&gt; _______________________________________________<br>
&gt; amd-gfx mailing list<br>
&gt; <a href=3D"mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org">amd-gfx-PD4FTy7X32mqWrfYKbYh0A@public.gmane.org=
ktop.org</a><br>
&gt; <a href=3D"https://lists.freedesktop.org/mailman/listinfo/amd-gfx">htt=
ps://lists.freedesktop.org/mailman/listinfo/amd-gfx</a><o:p></o:p></span></=
p>
</div>
</div>
</div>
</div>
</body>
</html>

--_000_MN2PR12MB334481F582B040EB2CE30AB2E45F0MN2PR12MB3344namp_--

--===============1109892075==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4

--===============1109892075==--
