From: "Deucher, Alexander" <Alexander.Deucher-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH] drm/amdgpu: set correct vram_width for vega10 under sriov
Date: Fri, 17 May 2019 17:07:09 +0000
Message-ID: <BN6PR12MB180947BE593ECB3FC8A660A7F70B0@BN6PR12MB1809.namprd12.prod.outlook.com>
References: <1558008150-20674-1-git-send-email-yttao@amd.com>
 <MN2PR12MB3039BD8CF5208A1667D34B29E50B0@MN2PR12MB3039.namprd12.prod.outlook.com>,
 <CADnq5_O00Ts0RA+ntfC8Sqfb3WGCi+xE6SwReOXUfJzJji7nTw@mail.gmail.com>,
 <MN2PR12MB3039CE4D284123D037FEDAF9E50B0@MN2PR12MB3039.namprd12.prod.outlook.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0897330162=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <MN2PR12MB3039CE4D284123D037FEDAF9E50B0-rweVpJHSKTr/fpeVZQY9RQdYzm3356FpvxpqHgZTriW3zl9H0oFU5g@public.gmane.org>
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
To: "Tao, Yintian" <Yintian.Tao-5C7GfCeVMHo@public.gmane.org>, Alex Deucher <alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: "Koenig, Christian" <Christian.Koenig-5C7GfCeVMHo@public.gmane.org>, "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, "Huang,
 Trigger" <Trigger.Huang-5C7GfCeVMHo@public.gmane.org>

--===============0897330162==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_BN6PR12MB180947BE593ECB3FC8A660A7F70B0BN6PR12MB1809namp_"

--_000_BN6PR12MB180947BE593ECB3FC8A660A7F70B0BN6PR12MB1809namp_
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64

RGlkIHlvdSBzZWUgdGhlIHBhdGNoIEkgYXR0YWNoZWQ/DQoNCkFsZXgNCl9fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fDQpGcm9tOiBUYW8sIFlpbnRpYW4NClNlbnQ6IEZyaWRheSwgTWF5
IDE3LCAyMDE5IDEwOjUxIEFNDQpUbzogQWxleCBEZXVjaGVyDQpDYzogYW1kLWdmeEBsaXN0cy5m
cmVlZGVza3RvcC5vcmc7IEtvZW5pZywgQ2hyaXN0aWFuOyBEZXVjaGVyLCBBbGV4YW5kZXI7IEh1
YW5nLCBUcmlnZ2VyDQpTdWJqZWN0OiC08Li0OiBbUEFUQ0hdIGRybS9hbWRncHU6IHNldCBjb3Jy
ZWN0IHZyYW1fd2lkdGggZm9yIHZlZ2ExMCB1bmRlciBzcmlvdg0KDQoNCkhpIEFsZXgNCg0KDQoN
Ck1hbnkgdGhhbmtzIGZvciB5b3VyIHJldmlldy4gSSB3aWxsIG1lcmdlIHRoZXNlIHR3byBwYXRj
aGVzIGludG8gb25lIGFuZCBzdWJtaXQgYWdhaW4uDQoNCg0KDQpCZXN0IFJlZ2FyZHMNCg0KWWlu
dGlhbiBUYW8NCg0KX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18NCreivP7IyzogQWxl
eCBEZXVjaGVyIDxhbGV4ZGV1Y2hlckBnbWFpbC5jb20+DQq3osvNyrG85DogMjAxOcTqNdTCMTfI
1SAyMjozNDozMA0KytW8/sjLOiBUYW8sIFlpbnRpYW4NCrOty806IGFtZC1nZnhAbGlzdHMuZnJl
ZWRlc2t0b3Aub3JnOyBLb2VuaWcsIENocmlzdGlhbjsgRGV1Y2hlciwgQWxleGFuZGVyOyBIdWFu
ZywgVHJpZ2dlcg0K1vfM4jogUmU6IFtQQVRDSF0gZHJtL2FtZGdwdTogc2V0IGNvcnJlY3QgdnJh
bV93aWR0aCBmb3IgdmVnYTEwIHVuZGVyIHNyaW92DQoNCltDQVVUSU9OOiBFeHRlcm5hbCBFbWFp
bF0NCg0KSG93IGFib3V0IGNvbWJpbmluZyB0aGVzZSB0d28gcGF0Y2hlcyBpbnRvIG9uZT8gIFRo
aXMgc2VlbXMgY2xlYW5lci4NCg0KQWxleA0KDQpPbiBUaHUsIE1heSAxNiwgMjAxOSBhdCAxMDoz
OSBQTSBUYW8sIFlpbnRpYW4gPFlpbnRpYW4uVGFvQGFtZC5jb20+IHdyb3RlOg0KPg0KPiBQaW5n
Li4uDQo+DQo+IEhpIENocmlzdGlhbiBhbmQgQWxleA0KPg0KPg0KPiBDYW4geW91IGhlbHAgcmV2
aWV3IHRoaXM/IFRoYW5rcyBpbiBhZHZhbmNlLg0KPg0KPg0KPiBCZXN0IFJlZ2FyZHMNCj4gWWlu
dGlhbiBUYW8NCj4NCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogWWludGlh
biBUYW8gPHl0dGFvQGFtZC5jb20+DQo+IFNlbnQ6IFRodXJzZGF5LCBNYXkgMTYsIDIwMTkgODow
MyBQTQ0KPiBUbzogYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcNCj4gQ2M6IFRhbywgWWlu
dGlhbiA8WWludGlhbi5UYW9AYW1kLmNvbT47IEh1YW5nLCBUcmlnZ2VyIDxUcmlnZ2VyLkh1YW5n
QGFtZC5jb20+DQo+IFN1YmplY3Q6IFtQQVRDSF0gZHJtL2FtZGdwdTogc2V0IGNvcnJlY3QgdnJh
bV93aWR0aCBmb3IgdmVnYTEwIHVuZGVyIHNyaW92DQo+DQo+IEZvciBWZWdhMTAgU1ItSU9WLCB2
cmFtX3dpZHRoIGNhbid0IGJlIHJlYWQgZnJvbSBBVE9NIGFzIFJBVkVOLCBhbmQgREYgcmVsYXRl
ZCByZWdpc3RlcnMgaXMgbm90IHJlYWRhYmxlLCBzZWVtcyBoYXJkY29yZCBpcyB0aGUgb25seSB3
YXkgdG8gc2V0IHRoZSBjb3JyZWN0IHZyYW1fd2lkdGgNCj4NCj4gU2lnbmVkLW9mZi1ieTogVHJp
Z2dlciBIdWFuZyA8VHJpZ2dlci5IdWFuZ0BhbWQuY29tPg0KPiBTaWduZWQtb2ZmLWJ5OiBZaW50
aWFuIFRhbyA8eXR0YW9AYW1kLmNvbT4NCj4gLS0tDQo+ICBkcml2ZXJzL2dwdS9kcm0vYW1kL2Ft
ZGdwdS9nbWNfdjlfMC5jIHwgNyArKysrKysrDQo+ICAxIGZpbGUgY2hhbmdlZCwgNyBpbnNlcnRp
b25zKCspDQo+DQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9nbWNf
djlfMC5jIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvZ21jX3Y5XzAuYw0KPiBpbmRleCBj
MjIxNTcwLi5hNDE3NzYzIDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdw
dS9nbWNfdjlfMC5jDQo+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2dtY192OV8w
LmMNCj4gQEAgLTg0OCw2ICs4NDgsMTMgQEAgc3RhdGljIGludCBnbWNfdjlfMF9tY19pbml0KHN0
cnVjdCBhbWRncHVfZGV2aWNlICphZGV2KQ0KPiAgICAgICAgICAgICAgICAgYWRldi0+Z21jLnZy
YW1fd2lkdGggPSBudW1jaGFuICogY2hhbnNpemU7DQo+ICAgICAgICAgfQ0KPg0KPiArICAgICAg
IC8qIEZvciBWZWdhMTAgU1ItSU9WLCB2cmFtX3dpZHRoIGNhbid0IGJlIHJlYWQgZnJvbSBBVE9N
IGFzIFJBVkVOLA0KPiArICAgICAgICAqIGFuZCBERiByZWxhdGVkIHJlZ2lzdGVycyBpcyBub3Qg
cmVhZGFibGUsIHNlZW1zIGhhcmRjb3JkIGlzIHRoZQ0KPiArICAgICAgICAqIG9ubHkgd2F5IHRv
IHNldCB0aGUgY29ycmVjdCB2cmFtX3dpZHRoICovDQo+ICsgICAgICAgaWYgKGFtZGdwdV9zcmlv
dl92ZihhZGV2KSAmJiAoYWRldi0+YXNpY190eXBlID09IENISVBfVkVHQTEwKSkgew0KPiArICAg
ICAgICAgICAgICAgYWRldi0+Z21jLnZyYW1fd2lkdGggPSAyMDQ4Ow0KPiArICAgICAgIH0NCj4g
Kw0KPiAgICAgICAgIC8qIHNpemUgaW4gTUIgb24gc2kgKi8NCj4gICAgICAgICBhZGV2LT5nbWMu
bWNfdnJhbV9zaXplID0NCj4gICAgICAgICAgICAgICAgIGFkZXYtPm5iaW9fZnVuY3MtPmdldF9t
ZW1zaXplKGFkZXYpICogMTAyNFVMTCAqIDEwMjRVTEw7DQo+IC0tDQo+IDIuNy40DQo+DQo+IF9f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fDQo+IGFtZC1nZngg
bWFpbGluZyBsaXN0DQo+IGFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnDQo+IGh0dHBzOi8v
bGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeA0K

--_000_BN6PR12MB180947BE593ECB3FC8A660A7F70B0BN6PR12MB1809namp_
Content-Type: text/html; charset="gb2312"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dgb2312">
<style type=3D"text/css" style=3D"display:none;"> P {margin-top:0;margin-bo=
ttom:0;} </style>
</head>
<body dir=3D"ltr">
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
Did you see the patch I attached?</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
Alex<br>
</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Tao, Yintian<br>
<b>Sent:</b> Friday, May 17, 2019 10:51 AM<br>
<b>To:</b> Alex Deucher<br>
<b>Cc:</b> amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org; Koenig, Christian; Deucher, Alexa=
nder; Huang, Trigger<br>
<b>Subject:</b> =B4=F0=B8=B4: [PATCH] drm/amdgpu: set correct vram_width fo=
r vega10 under sriov</font>
<div>&nbsp;</div>
</div>
<style type=3D"text/css" style=3D"display:none">
<!--
p
	{margin-top:0;
	margin-bottom:0}
-->
</style>
<div dir=3D"ltr">
<div id=3D"x_divtagdefaultwrapper" dir=3D"ltr" style=3D"font-size:12pt; col=
or:#000000; font-family:Calibri,Helvetica,sans-serif">
<p style=3D"margin-top:0; margin-bottom:0">Hi Alex</p>
<p style=3D"margin-top:0; margin-bottom:0"><br>
</p>
<p style=3D"margin-top:0; margin-bottom:0"><br>
</p>
<p style=3D"margin-top:0; margin-bottom:0">Many thanks for your review. I w=
ill merge these two patches into one and submit again.</p>
<p style=3D"margin-top:0; margin-bottom:0"><br>
</p>
<p style=3D"margin-top:0; margin-bottom:0"><br>
</p>
<p style=3D"margin-top:0; margin-bottom:0">Best Regards</p>
<p style=3D"margin-top:0; margin-bottom:0">Yintian Tao</p>
</div>
<hr tabindex=3D"-1" style=3D"display:inline-block; width:98%">
<div id=3D"x_divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" =
color=3D"#000000" style=3D"font-size:11pt"><b>=B7=A2=BC=FE=C8=CB:</b> Alex =
Deucher &lt;alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org&gt;<br>
<b>=B7=A2=CB=CD=CA=B1=BC=E4:</b> 2019=C4=EA5=D4=C217=C8=D5 22:34:30<br>
<b>=CA=D5=BC=FE=C8=CB:</b> Tao, Yintian<br>
<b>=B3=AD=CB=CD:</b> amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org; Koenig, Christian; Deuc=
her, Alexander; Huang, Trigger<br>
<b>=D6=F7=CC=E2:</b> Re: [PATCH] drm/amdgpu: set correct vram_width for veg=
a10 under sriov</font>
<div>&nbsp;</div>
</div>
<div class=3D"x_BodyFragment"><font size=3D"2"><span style=3D"font-size:11p=
t">
<div class=3D"x_PlainText">[CAUTION: External Email]<br>
<br>
How about combining these two patches into one?&nbsp; This seems cleaner.<b=
r>
<br>
Alex<br>
<br>
On Thu, May 16, 2019 at 10:39 PM Tao, Yintian &lt;Yintian.Tao-5C7GfCeVMHo@public.gmane.org&gt; w=
rote:<br>
&gt;<br>
&gt; Ping...<br>
&gt;<br>
&gt; Hi Christian and Alex<br>
&gt;<br>
&gt;<br>
&gt; Can you help review this? Thanks in advance.<br>
&gt;<br>
&gt;<br>
&gt; Best Regards<br>
&gt; Yintian Tao<br>
&gt;<br>
&gt; -----Original Message-----<br>
&gt; From: Yintian Tao &lt;yttao-5C7GfCeVMHo@public.gmane.org&gt;<br>
&gt; Sent: Thursday, May 16, 2019 8:03 PM<br>
&gt; To: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<br>
&gt; Cc: Tao, Yintian &lt;Yintian.Tao-5C7GfCeVMHo@public.gmane.org&gt;; Huang, Trigger &lt;Trigg=
er.Huang-5C7GfCeVMHo@public.gmane.org&gt;<br>
&gt; Subject: [PATCH] drm/amdgpu: set correct vram_width for vega10 under s=
riov<br>
&gt;<br>
&gt; For Vega10 SR-IOV, vram_width can't be read from ATOM as RAVEN, and DF=
 related registers is not readable, seems hardcord is the only way to set t=
he correct vram_width<br>
&gt;<br>
&gt; Signed-off-by: Trigger Huang &lt;Trigger.Huang-5C7GfCeVMHo@public.gmane.org&gt;<br>
&gt; Signed-off-by: Yintian Tao &lt;yttao-5C7GfCeVMHo@public.gmane.org&gt;<br>
&gt; ---<br>
&gt;&nbsp; drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c | 7 &#43;&#43;&#43;&#43;&#=
43;&#43;&#43;<br>
&gt;&nbsp; 1 file changed, 7 insertions(&#43;)<br>
&gt;<br>
&gt; diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c b/drivers/gpu/drm/a=
md/amdgpu/gmc_v9_0.c<br>
&gt; index c221570..a417763 100644<br>
&gt; --- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c<br>
&gt; &#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c<br>
&gt; @@ -848,6 &#43;848,13 @@ static int gmc_v9_0_mc_init(struct amdgpu_dev=
ice *adev)<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;gmc.vram_width =3D numchan * chansize;<b=
r>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* For Vega10 SR-IOV, vram_w=
idth can't be read from ATOM as RAVEN,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * and DF related regis=
ters is not readable, seems hardcord is the<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * only way to set the =
correct vram_width */<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (amdgpu_sriov_vf(adev) &a=
mp;&amp; (adev-&gt;asic_type =3D=3D CHIP_VEGA10)) {<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; adev-&gt;gmc.vram_width =3D 2048;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt; &#43;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* size in MB on si */=
<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;gmc.mc_vram_s=
ize =3D<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;nbio_funcs-&gt;get_memsize(adev) * 1024U=
LL * 1024ULL;<br>
&gt; --<br>
&gt; 2.7.4<br>
&gt;<br>
&gt; _______________________________________________<br>
&gt; amd-gfx mailing list<br>
&gt; amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<br>
&gt; <a href=3D"https://lists.freedesktop.org/mailman/listinfo/amd-gfx">htt=
ps://lists.freedesktop.org/mailman/listinfo/amd-gfx</a><br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_BN6PR12MB180947BE593ECB3FC8A660A7F70B0BN6PR12MB1809namp_--

--===============0897330162==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4

--===============0897330162==--
