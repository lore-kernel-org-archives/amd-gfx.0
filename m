From: "Deucher, Alexander" <Alexander.Deucher-5C7GfCeVMHo@public.gmane.org>
Subject: Re: regression on RV1
Date: Wed, 17 Oct 2018 16:40:37 +0000
Message-ID: <BN6PR12MB1809568E93126A0C8B259F81F7FF0@BN6PR12MB1809.namprd12.prod.outlook.com>
References: <fa0c1c22-5dce-e97f-3e17-59f08bd96f4f@amd.com>,
 <BN6PR12MB180952142479156B7C607F3FF7FF0@BN6PR12MB1809.namprd12.prod.outlook.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="_004_BN6PR12MB1809568E93126A0C8B259F81F7FF0BN6PR12MB1809namp_"
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <BN6PR12MB180952142479156B7C607F3FF7FF0-/b2+HYfkarSEx6ez0IUAagdYzm3356FpvxpqHgZTriW3zl9H0oFU5g@public.gmane.org>
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
To: "StDenis, Tom" <Tom.StDenis-5C7GfCeVMHo@public.gmane.org>, "Koenig, Christian" <Christian.Koenig-5C7GfCeVMHo@public.gmane.org>, amd-gfx mailing list <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
Cc: "Huang, Ray" <Ray.Huang-5C7GfCeVMHo@public.gmane.org>

--_004_BN6PR12MB1809568E93126A0C8B259F81F7FF0BN6PR12MB1809namp_
Content-Type: multipart/alternative;
	boundary="_000_BN6PR12MB1809568E93126A0C8B259F81F7FF0BN6PR12MB1809namp_"

--_000_BN6PR12MB1809568E93126A0C8B259F81F7FF0BN6PR12MB1809namp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

I think something like this should fix it.


Alex

________________________________
From: amd-gfx <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org> on behalf of Deucher,=
 Alexander <Alexander.Deucher-5C7GfCeVMHo@public.gmane.org>
Sent: Wednesday, October 17, 2018 12:15:21 PM
To: StDenis, Tom; Koenig, Christian; amd-gfx mailing list
Cc: Huang, Ray
Subject: Re: regression on RV1


IIRC, APUs do not have a paging queue.  Only dGPUs have it.


Alex

________________________________
From: amd-gfx <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org> on behalf of StDenis,=
 Tom <Tom.StDenis-5C7GfCeVMHo@public.gmane.org>
Sent: Wednesday, October 17, 2018 11:54:33 AM
To: Koenig, Christian; amd-gfx mailing list
Cc: Huang, Ray
Subject: regression on RV1

This commit:

commit 6cbd074831a423e0d30b386fc056d6c2c3559147 (HEAD, refs/bisect/bad)
Author: Christian K=F6nig <christian.koenig-5C7GfCeVMHo@public.gmane.org>
Date:   Mon Oct 8 14:38:22 2018 +0200

     drm/amdgpu: activate paging queue on SDMA v4

     Implement all the necessary stuff to get those extra rings working.

     Signed-off-by: Christian K=F6nig <christian.koenig-5C7GfCeVMHo@public.gmane.org>
     Reviewed-by: Huang Rui <ray.huang-5C7GfCeVMHo@public.gmane.org>

Breaks my RV1 init.

Tom

--_000_BN6PR12MB1809568E93126A0C8B259F81F7FF0BN6PR12MB1809namp_
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
<p style=3D"margin-top:0;margin-bottom:0">I think something like this shoul=
d fix it.</p>
<p style=3D"margin-top:0;margin-bottom:0"><br>
</p>
<p style=3D"margin-top:0;margin-bottom:0">Alex<br>
</p>
</div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> amd-gfx &lt;amd-gfx-b=
ounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org&gt; on behalf of Deucher, Alexander &lt;Alexan=
der.Deucher-5C7GfCeVMHo@public.gmane.org&gt;<br>
<b>Sent:</b> Wednesday, October 17, 2018 12:15:21 PM<br>
<b>To:</b> StDenis, Tom; Koenig, Christian; amd-gfx mailing list<br>
<b>Cc:</b> Huang, Ray<br>
<b>Subject:</b> Re: regression on RV1</font>
<div>&nbsp;</div>
</div>
<meta content=3D"text/html; charset=3Diso-8859-1">
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
<p style=3D"margin-top:0; margin-bottom:0">IIRC, APUs do not have a paging =
queue.&nbsp; Only dGPUs have it.</p>
<p style=3D"margin-top:0; margin-bottom:0"><br>
</p>
<p style=3D"margin-top:0; margin-bottom:0">Alex<br>
</p>
</div>
<hr tabindex=3D"-1" style=3D"display:inline-block; width:98%">
<div id=3D"x_divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" =
color=3D"#000000" style=3D"font-size:11pt"><b>From:</b> amd-gfx &lt;amd-gfx=
-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org&gt; on behalf of StDenis, Tom &lt;Tom.StDeni=
s@amd.com&gt;<br>
<b>Sent:</b> Wednesday, October 17, 2018 11:54:33 AM<br>
<b>To:</b> Koenig, Christian; amd-gfx mailing list<br>
<b>Cc:</b> Huang, Ray<br>
<b>Subject:</b> regression on RV1</font>
<div>&nbsp;</div>
</div>
<div class=3D"x_BodyFragment"><font size=3D"2"><span style=3D"font-size:11p=
t">
<div class=3D"x_PlainText">This commit:<br>
<br>
commit 6cbd074831a423e0d30b386fc056d6c2c3559147 (HEAD, refs/bisect/bad)<br>
Author: Christian K=F6nig &lt;christian.koenig-5C7GfCeVMHo@public.gmane.org&gt;<br>
Date:&nbsp;&nbsp; Mon Oct 8 14:38:22 2018 &#43;0200<br>
<br>
&nbsp;&nbsp;&nbsp;&nbsp; drm/amdgpu: activate paging queue on SDMA v4<br>
<br>
&nbsp;&nbsp;&nbsp;&nbsp; Implement all the necessary stuff to get those ext=
ra rings working.<br>
<br>
&nbsp;&nbsp;&nbsp;&nbsp; Signed-off-by: Christian K=F6nig &lt;christian.koe=
nig-5C7GfCeVMHo@public.gmane.org&gt;<br>
&nbsp;&nbsp;&nbsp;&nbsp; Reviewed-by: Huang Rui &lt;ray.huang-5C7GfCeVMHo@public.gmane.org&gt;<b=
r>
<br>
Breaks my RV1 init.<br>
<br>
Tom<br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_BN6PR12MB1809568E93126A0C8B259F81F7FF0BN6PR12MB1809namp_--

--_004_BN6PR12MB1809568E93126A0C8B259F81F7FF0BN6PR12MB1809namp_
Content-Type: text/x-patch;
	name="0001-drm-amdgpu-sdma4-APUs-do-not-have-a-page-queue.patch"
Content-Description: 0001-drm-amdgpu-sdma4-APUs-do-not-have-a-page-queue.patch
Content-Disposition: attachment;
	filename="0001-drm-amdgpu-sdma4-APUs-do-not-have-a-page-queue.patch";
	size=4439; creation-date="Wed, 17 Oct 2018 16:40:35 GMT";
	modification-date="Wed, 17 Oct 2018 16:40:35 GMT"
Content-Transfer-Encoding: base64

RnJvbSA3M2QwYjUxYzEyNzdkY2UzYjczNjUxY2MxODlkY2EwNzRjOWQzNjc4IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBBbGV4IERldWNoZXIgPGFsZXhhbmRlci5kZXVjaGVyQGFtZC5j
b20+CkRhdGU6IFdlZCwgMTcgT2N0IDIwMTggMTE6Mzk6MjcgLTA1MDAKU3ViamVjdDogW1BBVENI
XSBkcm0vYW1kZ3B1L3NkbWE0OiBBUFVzIGRvIG5vdCBoYXZlIGEgcGFnZSBxdWV1ZQoKRG9uJ3Qg
dXNlIHRoZSBwYWdpbmcgcXVldWUgb24gQVBVcy4KClNpZ25lZC1vZmYtYnk6IEFsZXggRGV1Y2hl
ciA8YWxleGFuZGVyLmRldWNoZXJAYW1kLmNvbT4KLS0tCiBkcml2ZXJzL2dwdS9kcm0vYW1kL2Ft
ZGdwdS9hbWRncHVfc2RtYS5oIHwgIDEgKwogZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvc2Rt
YV92NF8wLmMgICB8IDUzICsrKysrKysrKysrKysrKysrKysrLS0tLS0tLS0tLS0tCiAyIGZpbGVz
IGNoYW5nZWQsIDM0IGluc2VydGlvbnMoKyksIDIwIGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBh
L2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9zZG1hLmggYi9kcml2ZXJzL2dwdS9k
cm0vYW1kL2FtZGdwdS9hbWRncHVfc2RtYS5oCmluZGV4IDU1NmRiNDJlZGFlZC4uNDc5YTI0NTll
NTU4IDEwMDY0NAotLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfc2RtYS5o
CisrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9zZG1hLmgKQEAgLTUxLDYg
KzUxLDcgQEAgc3RydWN0IGFtZGdwdV9zZG1hIHsKIAlzdHJ1Y3QgYW1kZ3B1X2lycV9zcmMJaWxs
ZWdhbF9pbnN0X2lycTsKIAlpbnQJCQludW1faW5zdGFuY2VzOwogCXVpbnQzMl90ICAgICAgICAg
ICAgICAgICAgICBzcmJtX3NvZnRfcmVzZXQ7CisJYm9vbAkJCWhhc19wYWdlX3F1ZXVlOwogfTsK
IAogLyoKZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L3NkbWFfdjRfMC5j
IGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvc2RtYV92NF8wLmMKaW5kZXggYTBhNWIyMTYx
ZDc4Li42YWQ0ZmRhMDEwZjIgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1
L3NkbWFfdjRfMC5jCisrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L3NkbWFfdjRfMC5j
CkBAIC03NDYsNyArNzQ2LDggQEAgc3RhdGljIHZvaWQgc2RtYV92NF8wX2VuYWJsZShzdHJ1Y3Qg
YW1kZ3B1X2RldmljZSAqYWRldiwgYm9vbCBlbmFibGUpCiAJaWYgKGVuYWJsZSA9PSBmYWxzZSkg
ewogCQlzZG1hX3Y0XzBfZ2Z4X3N0b3AoYWRldik7CiAJCXNkbWFfdjRfMF9ybGNfc3RvcChhZGV2
KTsKLQkJc2RtYV92NF8wX3BhZ2Vfc3RvcChhZGV2KTsKKwkJaWYgKGFkZXYtPnNkbWEuaGFzX3Bh
Z2VfcXVldWUpCisJCQlzZG1hX3Y0XzBfcGFnZV9zdG9wKGFkZXYpOwogCX0KIAogCWZvciAoaSA9
IDA7IGkgPCBhZGV2LT5zZG1hLm51bV9pbnN0YW5jZXM7IGkrKykgewpAQCAtMTExNSw3ICsxMTE2
LDggQEAgc3RhdGljIGludCBzZG1hX3Y0XzBfc3RhcnQoc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFk
ZXYpCiAKIAkJV1JFRzMyX1NETUEoaSwgbW1TRE1BMF9TRU1fV0FJVF9GQUlMX1RJTUVSX0NOVEws
IDApOwogCQlzZG1hX3Y0XzBfZ2Z4X3Jlc3VtZShhZGV2LCBpKTsKLQkJc2RtYV92NF8wX3BhZ2Vf
cmVzdW1lKGFkZXYsIGkpOworCQlpZiAoYWRldi0+c2RtYS5oYXNfcGFnZV9xdWV1ZSkKKwkJCXNk
bWFfdjRfMF9wYWdlX3Jlc3VtZShhZGV2LCBpKTsKIAogCQkvKiBzZXQgdXRjIGwxIGVuYWJsZSBm
bGFnIGFsd2F5cyB0byAxICovCiAJCXRlbXAgPSBSUkVHMzJfU0RNQShpLCBtbVNETUEwX0NOVEwp
OwpAQCAtMTQ1NywxMCArMTQ1OSwxMyBAQCBzdGF0aWMgaW50IHNkbWFfdjRfMF9lYXJseV9pbml0
KHZvaWQgKmhhbmRsZSkKIHsKIAlzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRldiA9IChzdHJ1Y3Qg
YW1kZ3B1X2RldmljZSAqKWhhbmRsZTsKIAotCWlmIChhZGV2LT5hc2ljX3R5cGUgPT0gQ0hJUF9S
QVZFTikKKwlpZiAoYWRldi0+YXNpY190eXBlID09IENISVBfUkFWRU4pIHsKIAkJYWRldi0+c2Rt
YS5udW1faW5zdGFuY2VzID0gMTsKLQllbHNlCisJCWFkZXYtPnNkbWEuaGFzX3BhZ2VfcXVldWUg
PSBmYWxzZTsKKwl9IGVsc2UgewogCQlhZGV2LT5zZG1hLm51bV9pbnN0YW5jZXMgPSAyOworCQlh
ZGV2LT5zZG1hLmhhc19wYWdlX3F1ZXVlID0gdHJ1ZTsKKwl9CiAKIAlzZG1hX3Y0XzBfc2V0X3Jp
bmdfZnVuY3MoYWRldik7CiAJc2RtYV92NF8wX3NldF9idWZmZXJfZnVuY3MoYWRldik7CkBAIC0x
NTIyLDE4ICsxNTI3LDIwIEBAIHN0YXRpYyBpbnQgc2RtYV92NF8wX3N3X2luaXQodm9pZCAqaGFu
ZGxlKQogCQlpZiAocikKIAkJCXJldHVybiByOwogCi0JCXJpbmcgPSAmYWRldi0+c2RtYS5pbnN0
YW5jZVtpXS5wYWdlOwotCQlyaW5nLT5yaW5nX29iaiA9IE5VTEw7Ci0JCXJpbmctPnVzZV9kb29y
YmVsbCA9IGZhbHNlOwotCi0JCXNwcmludGYocmluZy0+bmFtZSwgInBhZ2UlZCIsIGkpOwotCQly
ID0gYW1kZ3B1X3JpbmdfaW5pdChhZGV2LCByaW5nLCAxMDI0LAotCQkJCSAgICAgJmFkZXYtPnNk
bWEudHJhcF9pcnEsCi0JCQkJICAgICAoaSA9PSAwKSA/Ci0JCQkJICAgICBBTURHUFVfU0RNQV9J
UlFfVFJBUDAgOgotCQkJCSAgICAgQU1ER1BVX1NETUFfSVJRX1RSQVAxKTsKLQkJaWYgKHIpCi0J
CQlyZXR1cm4gcjsKKwkJaWYgKGFkZXYtPnNkbWEuaGFzX3BhZ2VfcXVldWUpIHsKKwkJCXJpbmcg
PSAmYWRldi0+c2RtYS5pbnN0YW5jZVtpXS5wYWdlOworCQkJcmluZy0+cmluZ19vYmogPSBOVUxM
OworCQkJcmluZy0+dXNlX2Rvb3JiZWxsID0gZmFsc2U7CisKKwkJCXNwcmludGYocmluZy0+bmFt
ZSwgInBhZ2UlZCIsIGkpOworCQkJciA9IGFtZGdwdV9yaW5nX2luaXQoYWRldiwgcmluZywgMTAy
NCwKKwkJCQkJICAgICAmYWRldi0+c2RtYS50cmFwX2lycSwKKwkJCQkJICAgICAoaSA9PSAwKSA/
CisJCQkJCSAgICAgQU1ER1BVX1NETUFfSVJRX1RSQVAwIDoKKwkJCQkJICAgICBBTURHUFVfU0RN
QV9JUlFfVFJBUDEpOworCQkJaWYgKHIpCisJCQkJcmV0dXJuIHI7CisJCX0KIAl9CiAKIAlyZXR1
cm4gcjsKQEAgLTE1NDYsNyArMTU1Myw4IEBAIHN0YXRpYyBpbnQgc2RtYV92NF8wX3N3X2Zpbmko
dm9pZCAqaGFuZGxlKQogCiAJZm9yIChpID0gMDsgaSA8IGFkZXYtPnNkbWEubnVtX2luc3RhbmNl
czsgaSsrKSB7CiAJCWFtZGdwdV9yaW5nX2ZpbmkoJmFkZXYtPnNkbWEuaW5zdGFuY2VbaV0ucmlu
Zyk7Ci0JCWFtZGdwdV9yaW5nX2ZpbmkoJmFkZXYtPnNkbWEuaW5zdGFuY2VbaV0ucGFnZSk7CisJ
CWlmIChhZGV2LT5zZG1hLmhhc19wYWdlX3F1ZXVlKQorCQkJYW1kZ3B1X3JpbmdfZmluaSgmYWRl
di0+c2RtYS5pbnN0YW5jZVtpXS5wYWdlKTsKIAl9CiAKIAlmb3IgKGkgPSAwOyBpIDwgYWRldi0+
c2RtYS5udW1faW5zdGFuY2VzOyBpKyspIHsKQEAgLTE5NzAsOCArMTk3OCwxMCBAQCBzdGF0aWMg
dm9pZCBzZG1hX3Y0XzBfc2V0X3JpbmdfZnVuY3Moc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYp
CiAJZm9yIChpID0gMDsgaSA8IGFkZXYtPnNkbWEubnVtX2luc3RhbmNlczsgaSsrKSB7CiAJCWFk
ZXYtPnNkbWEuaW5zdGFuY2VbaV0ucmluZy5mdW5jcyA9ICZzZG1hX3Y0XzBfcmluZ19mdW5jczsK
IAkJYWRldi0+c2RtYS5pbnN0YW5jZVtpXS5yaW5nLm1lID0gaTsKLQkJYWRldi0+c2RtYS5pbnN0
YW5jZVtpXS5wYWdlLmZ1bmNzID0gJnNkbWFfdjRfMF9wYWdlX3JpbmdfZnVuY3M7Ci0JCWFkZXYt
PnNkbWEuaW5zdGFuY2VbaV0ucGFnZS5tZSA9IGk7CisJCWlmIChhZGV2LT5zZG1hLmhhc19wYWdl
X3F1ZXVlKSB7CisJCQlhZGV2LT5zZG1hLmluc3RhbmNlW2ldLnBhZ2UuZnVuY3MgPSAmc2RtYV92
NF8wX3BhZ2VfcmluZ19mdW5jczsKKwkJCWFkZXYtPnNkbWEuaW5zdGFuY2VbaV0ucGFnZS5tZSA9
IGk7CisJCX0KIAl9CiB9CiAKQEAgLTIwNzEsNyArMjA4MSwxMCBAQCBzdGF0aWMgdm9pZCBzZG1h
X3Y0XzBfc2V0X3ZtX3B0ZV9mdW5jcyhzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRldikKIAogCWFk
ZXYtPnZtX21hbmFnZXIudm1fcHRlX2Z1bmNzID0gJnNkbWFfdjRfMF92bV9wdGVfZnVuY3M7CiAJ
Zm9yIChpID0gMDsgaSA8IGFkZXYtPnNkbWEubnVtX2luc3RhbmNlczsgaSsrKSB7Ci0JCXNjaGVk
ID0gJmFkZXYtPnNkbWEuaW5zdGFuY2VbaV0ucGFnZS5zY2hlZDsKKwkJaWYgKGFkZXYtPnNkbWEu
aGFzX3BhZ2VfcXVldWUpCisJCQlzY2hlZCA9ICZhZGV2LT5zZG1hLmluc3RhbmNlW2ldLnBhZ2Uu
c2NoZWQ7CisJCWVsc2UKKwkJCXNjaGVkID0gJmFkZXYtPnNkbWEuaW5zdGFuY2VbaV0ucmluZy5z
Y2hlZDsKIAkJYWRldi0+dm1fbWFuYWdlci52bV9wdGVfcnFzW2ldID0KIAkJCSZzY2hlZC0+c2No
ZWRfcnFbRFJNX1NDSEVEX1BSSU9SSVRZX0tFUk5FTF07CiAJfQotLSAKMi4xMy42Cgo=

--_004_BN6PR12MB1809568E93126A0C8B259F81F7FF0BN6PR12MB1809namp_
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--_004_BN6PR12MB1809568E93126A0C8B259F81F7FF0BN6PR12MB1809namp_--
