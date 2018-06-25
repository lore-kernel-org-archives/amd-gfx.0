From: "Deucher, Alexander" <Alexander.Deucher-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH] Increase AMDGPU_MAX_UVD_INSTANCES to 3
Date: Mon, 25 Jun 2018 17:29:34 +0000
Message-ID: <BN6PR12MB1809E207A784F6EE6D79239AF74A0@BN6PR12MB1809.namprd12.prod.outlook.com>
References: <1050162536.2570273.1529798571780.JavaMail.zimbra@raptorengineeringinc.com>
 <03467f4e-bcab-165c-028b-fea16441446a@amd.com>,
 <5B310FE8.4060900@raptorengineering.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="_004_BN6PR12MB1809E207A784F6EE6D79239AF74A0BN6PR12MB1809namp_"
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <5B310FE8.4060900-z0qzliK6Om0mgXJStvpl+vpXobYPEAuW@public.gmane.org>
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
To: Timothy Pearson <tpearson-z0qzliK6Om0mgXJStvpl+vpXobYPEAuW@public.gmane.org>, "Zhu, James" <James.Zhu-5C7GfCeVMHo@public.gmane.org>
Cc: "Zhou, David(ChunMing)" <David1.Zhou-5C7GfCeVMHo@public.gmane.org>, "Koenig,
 Christian" <Christian.Koenig-5C7GfCeVMHo@public.gmane.org>, "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

--_004_BN6PR12MB1809E207A784F6EE6D79239AF74A0BN6PR12MB1809namp_
Content-Type: multipart/alternative;
	boundary="_000_BN6PR12MB1809E207A784F6EE6D79239AF74A0BN6PR12MB1809namp_"

--_000_BN6PR12MB1809E207A784F6EE6D79239AF74A0BN6PR12MB1809namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Odd. The structure should be 0 initialized.  Does this patch help?


Alex

________________________________
From: Timothy Pearson <tpearson-z0qzliK6Om0mgXJStvpl+vpXobYPEAuW@public.gmane.org>
Sent: Monday, June 25, 2018 11:53:12 AM
To: Zhu, James
Cc: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org; Deucher, Alexander; Zhou, David(ChunMing=
); Koenig, Christian
Subject: Re: [PATCH] Increase AMDGPU_MAX_UVD_INSTANCES to 3

n 06/25/2018 09:46 AM, James Zhu wrote:
>
>
> On 2018-06-23 08:02 PM, Timothy Pearson wrote:
>> amdgpu_fence_driver_start_ring() attempts to access
>> UVD instance 2 during setup, while the existing UVD
>> instance count only allows instances 0 and 1.
>>
>> Increase AMDGPU_MAX_UVD_INSTANCES by one to avoid the
>> invalid array access.
>>
>> Caught by UBSAN.
> Hi Timothy,
>
> From design of view, it is not right to just change
> AMDGPU_MAX_UVD_INSTANCES to 3.
>
> Could you tell me some detail of UBSAN test and attach the dmesg also?

Definitely, was looking for some feedback from anyone knowing more about
the internals of the UVD system.

What's happening is that "ring->me" in amdgpu_fence_driver_start_ring()
(drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c:379) is set to a value of
"2".  The overall dmesg is otherwise uninteresting, but I can try to
grab the UBSAN output if needed.

--
Timothy Pearson
Raptor Engineering
+1 (415) 727-8645 (direct line)
+1 (512) 690-0200 (switchboard)
https://www.raptorengineering.com

--_000_BN6PR12MB1809E207A784F6EE6D79239AF74A0BN6PR12MB1809namp_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
<style type=3D"text/css" style=3D"display:none;"><!-- P {margin-top:0;margi=
n-bottom:0;} --></style>
</head>
<body dir=3D"ltr">
<div id=3D"divtagdefaultwrapper" style=3D"font-size:12pt;color:#000000;font=
-family:Calibri,Helvetica,sans-serif;" dir=3D"ltr">
<p style=3D"margin-top:0;margin-bottom:0">Odd. The structure should be 0 in=
itialized.&nbsp; Does this patch help?</p>
<p style=3D"margin-top:0;margin-bottom:0"><br>
</p>
<p style=3D"margin-top:0;margin-bottom:0">Alex<br>
</p>
</div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Timothy Pearson &lt;t=
pearson-z0qzliK6Om0mgXJStvpl+vpXobYPEAuW@public.gmane.org&gt;<br>
<b>Sent:</b> Monday, June 25, 2018 11:53:12 AM<br>
<b>To:</b> Zhu, James<br>
<b>Cc:</b> amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org; Deucher, Alexander; Zhou, David(C=
hunMing); Koenig, Christian<br>
<b>Subject:</b> Re: [PATCH] Increase AMDGPU_MAX_UVD_INSTANCES to 3</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">n 06/25/2018 09:46 AM, James Zhu wrote:<br>
&gt; <br>
&gt; <br>
&gt; On 2018-06-23 08:02 PM, Timothy Pearson wrote:<br>
&gt;&gt; amdgpu_fence_driver_start_ring() attempts to access<br>
&gt;&gt; UVD instance 2 during setup, while the existing UVD<br>
&gt;&gt; instance count only allows instances 0 and 1.<br>
&gt;&gt;<br>
&gt;&gt; Increase AMDGPU_MAX_UVD_INSTANCES by one to avoid the<br>
&gt;&gt; invalid array access.<br>
&gt;&gt;<br>
&gt;&gt; Caught by UBSAN.<br>
&gt; Hi Timothy,<br>
&gt; <br>
&gt; From design of view, it is not right to just change<br>
&gt; AMDGPU_MAX_UVD_INSTANCES to 3.<br>
&gt; <br>
&gt; Could you tell me some detail of UBSAN test and attach the dmesg also?=
<br>
<br>
Definitely, was looking for some feedback from anyone knowing more about<br=
>
the internals of the UVD system.<br>
<br>
What's happening is that &quot;ring-&gt;me&quot; in amdgpu_fence_driver_sta=
rt_ring()<br>
(drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c:379) is set to a value of<br>
&quot;2&quot;.&nbsp; The overall dmesg is otherwise uninteresting, but I ca=
n try to<br>
grab the UBSAN output if needed.<br>
<br>
-- <br>
Timothy Pearson<br>
Raptor Engineering<br>
&#43;1 (415) 727-8645 (direct line)<br>
&#43;1 (512) 690-0200 (switchboard)<br>
<a href=3D"https://www.raptorengineering.com">https://www.raptorengineering=
.com</a><br>
</div>
</span></font></div>
</body>
</html>

--_000_BN6PR12MB1809E207A784F6EE6D79239AF74A0BN6PR12MB1809namp_--

--_004_BN6PR12MB1809E207A784F6EE6D79239AF74A0BN6PR12MB1809namp_
Content-Type: text/x-patch;
	name="0001-drm-amdgpu-uvd-explicitly-set-ring-me-for-UVD-instan.patch"
Content-Description: 0001-drm-amdgpu-uvd-explicitly-set-ring-me-for-UVD-instan.patch
Content-Disposition: attachment;
	filename="0001-drm-amdgpu-uvd-explicitly-set-ring-me-for-UVD-instan.patch";
	size=2111; creation-date="Mon, 25 Jun 2018 17:29:10 GMT";
	modification-date="Mon, 25 Jun 2018 17:29:10 GMT"
Content-Transfer-Encoding: base64

RnJvbSA2MDY5Njg5MTI2ODVhZjljMTI4ODFlYjkwOTk5NDEzYzUwMTQyMTdjIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBBbGV4IERldWNoZXIgPGFsZXhhbmRlci5kZXVjaGVyQGFtZC5j
b20+CkRhdGU6IE1vbiwgMjUgSnVuIDIwMTggMTI6MTE6MDggLTA1MDAKU3ViamVjdDogW1BBVENI
XSBkcm0vYW1kZ3B1L3V2ZDogZXhwbGljaXRseSBzZXQgcmluZy0+bWUgZm9yIFVWRCBpbnN0YW5j
ZXMKClNob3VsZG4ndCBiZSBuZWNlc3Nhcnkgc2luY2UgdGhlIHN0cnVjdHVyZSBpcyAwIGluaXRp
YWxpemVkLgoKU2lnbmVkLW9mZi1ieTogQWxleCBEZXVjaGVyIDxhbGV4YW5kZXIuZGV1Y2hlckBh
bWQuY29tPgotLS0KIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L3V2ZF92NF8yLmMgfCAxICsK
IGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L3V2ZF92NV8wLmMgfCAxICsKIGRyaXZlcnMvZ3B1
L2RybS9hbWQvYW1kZ3B1L3V2ZF92Nl8wLmMgfCAxICsKIDMgZmlsZXMgY2hhbmdlZCwgMyBpbnNl
cnRpb25zKCspCgpkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvdXZkX3Y0
XzIuYyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L3V2ZF92NF8yLmMKaW5kZXggNmZlZDNk
Nzc5N2E4Li5hNjBlMzZlZTQzYzIgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1k
Z3B1L3V2ZF92NF8yLmMKKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvdXZkX3Y0XzIu
YwpAQCAtNzY2LDYgKzc2Niw3IEBAIHN0YXRpYyBjb25zdCBzdHJ1Y3QgYW1kZ3B1X3JpbmdfZnVu
Y3MgdXZkX3Y0XzJfcmluZ19mdW5jcyA9IHsKIHN0YXRpYyB2b2lkIHV2ZF92NF8yX3NldF9yaW5n
X2Z1bmNzKHN0cnVjdCBhbWRncHVfZGV2aWNlICphZGV2KQogewogCWFkZXYtPnV2ZC5pbnN0LT5y
aW5nLmZ1bmNzID0gJnV2ZF92NF8yX3JpbmdfZnVuY3M7CisJYWRldi0+dXZkLmluc3RbMF0ucmlu
Zy5tZSA9IDA7CiB9CiAKIHN0YXRpYyBjb25zdCBzdHJ1Y3QgYW1kZ3B1X2lycV9zcmNfZnVuY3Mg
dXZkX3Y0XzJfaXJxX2Z1bmNzID0gewpkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9h
bWRncHUvdXZkX3Y1XzAuYyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L3V2ZF92NV8wLmMK
aW5kZXggMzQxZWU2ZDU1Y2U4Li5jOWZjYThmMzZiMjUgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvZ3B1
L2RybS9hbWQvYW1kZ3B1L3V2ZF92NV8wLmMKKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRn
cHUvdXZkX3Y1XzAuYwpAQCAtODc0LDYgKzg3NCw3IEBAIHN0YXRpYyBjb25zdCBzdHJ1Y3QgYW1k
Z3B1X3JpbmdfZnVuY3MgdXZkX3Y1XzBfcmluZ19mdW5jcyA9IHsKIHN0YXRpYyB2b2lkIHV2ZF92
NV8wX3NldF9yaW5nX2Z1bmNzKHN0cnVjdCBhbWRncHVfZGV2aWNlICphZGV2KQogewogCWFkZXYt
PnV2ZC5pbnN0LT5yaW5nLmZ1bmNzID0gJnV2ZF92NV8wX3JpbmdfZnVuY3M7CisJYWRldi0+dXZk
Lmluc3RbMF0ucmluZy5tZSA9IDA7CiB9CiAKIHN0YXRpYyBjb25zdCBzdHJ1Y3QgYW1kZ3B1X2ly
cV9zcmNfZnVuY3MgdXZkX3Y1XzBfaXJxX2Z1bmNzID0gewpkaWZmIC0tZ2l0IGEvZHJpdmVycy9n
cHUvZHJtL2FtZC9hbWRncHUvdXZkX3Y2XzAuYyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1
L3V2ZF92Nl8wLmMKaW5kZXggYmZkZGY5N2RkMTNlLi4zYmRkZjBiYzEyNjggMTAwNjQ0Ci0tLSBh
L2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L3V2ZF92Nl8wLmMKKysrIGIvZHJpdmVycy9ncHUv
ZHJtL2FtZC9hbWRncHUvdXZkX3Y2XzAuYwpAQCAtMTYzMCw2ICsxNjMwLDcgQEAgc3RhdGljIHZv
aWQgdXZkX3Y2XzBfc2V0X3JpbmdfZnVuY3Moc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYpCiAJ
CWFkZXYtPnV2ZC5pbnN0LT5yaW5nLmZ1bmNzID0gJnV2ZF92Nl8wX3JpbmdfcGh5c19mdW5jczsK
IAkJRFJNX0lORk8oIlVWRCBpcyBlbmFibGVkIGluIHBoeXNpY2FsIG1vZGVcbiIpOwogCX0KKwlh
ZGV2LT51dmQuaW5zdFswXS5yaW5nLm1lID0gMDsKIH0KIAogc3RhdGljIHZvaWQgdXZkX3Y2XzBf
c2V0X2VuY19yaW5nX2Z1bmNzKHN0cnVjdCBhbWRncHVfZGV2aWNlICphZGV2KQotLSAKMi4xMy42
Cgo=

--_004_BN6PR12MB1809E207A784F6EE6D79239AF74A0BN6PR12MB1809namp_
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--_004_BN6PR12MB1809E207A784F6EE6D79239AF74A0BN6PR12MB1809namp_--
