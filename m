From: "Xie, AlexBin" <AlexBin.Xie-5C7GfCeVMHo@public.gmane.org>
Subject: Re: More specific libdrm error message
Date: Wed, 11 Jan 2017 21:49:49 +0000
Message-ID: <CY4PR12MB16405027D18941DAF1D35A22F2660@CY4PR12MB1640.namprd12.prod.outlook.com>
References: <CY4PR12MB1640D019595EC5A1C6D1F670F2660@CY4PR12MB1640.namprd12.prod.outlook.com>,
 <CY4PR12MB16409A6D631EA457A365ECF0F2660@CY4PR12MB1640.namprd12.prod.outlook.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="_004_CY4PR12MB16405027D18941DAF1D35A22F2660CY4PR12MB1640namp_"
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <CY4PR12MB16409A6D631EA457A365ECF0F2660-rpdhrqHFk06q//3LJcutlgdYzm3356FpvxpqHgZTriW3zl9H0oFU5g@public.gmane.org>
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
To: "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

--_004_CY4PR12MB16405027D18941DAF1D35A22F2660CY4PR12MB1640namp_
Content-Type: multipart/alternative;
	boundary="_000_CY4PR12MB16405027D18941DAF1D35A22F2660CY4PR12MB1640namp_"

--_000_CY4PR12MB16405027D18941DAF1D35A22F2660CY4PR12MB1640namp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Hi,


v2: Use strerror instead of %m. %m is a GNU C Library extension.

Thanks,

Alex Bin Xie

________________________________
From: Xie, AlexBin
Sent: Wednesday, January 11, 2017 4:14 PM
To: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Subject: More specific libdrm error message

Hi,

Provide more specific error message if non-privileged user runs amdgpu_test

Before this change, the error message is:" WARNING - Suite initialization f=
ailed..." People might think this is a driver problem.


Tested with non-privileged user. Now the error message is like.

...
Error:Permission denied. Hint: Try to run this test program as root.
WARNING - Suite initialization failed for 'Basic Tests'.

...



Tested as root with no regression.



Please review.


Thanks,

Alex Bin Xie

--_000_CY4PR12MB16405027D18941DAF1D35A22F2660CY4PR12MB1640namp_
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
-family:Calibri,Arial,Helvetica,sans-serif;" dir=3D"ltr">
<p></p>
<div>Hi,<br>
<br>
<br>
v2: Use strerror instead of %m. %m is a GNU C Library extension.<br>
<br>
</div>
Thanks,
<p></p>
<p>Alex Bin Xie<br>
</p>
<br>
<div style=3D"color: rgb(0, 0, 0);">
<hr tabindex=3D"-1" style=3D"display:inline-block; width:98%">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font style=3D"font-size:11pt" face=
=3D"Calibri, sans-serif" color=3D"#000000"><b>From:</b> Xie, AlexBin<br>
<b>Sent:</b> Wednesday, January 11, 2017 4:14 PM<br>
<b>To:</b> amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<br>
<b>Subject:</b> More specific libdrm error message</font>
<div>&nbsp;</div>
</div>
<div>
<div id=3D"divtagdefaultwrapper" dir=3D"ltr" style=3D"font-size:12pt; color=
:#000000; font-family:Calibri,Arial,Helvetica,sans-serif">
Hi,<br>
<div style=3D"color:rgb(0,0,0)">
<div>
<div id=3D"divtagdefaultwrapper" dir=3D"ltr" style=3D"font-size:12pt; color=
:#000000; font-family:Calibri,Arial,Helvetica,sans-serif">
<div><br>
Provide more specific error message if non-privileged user runs amdgpu_test=
<br>
<br>
Before this change, the error message is:&quot; WARNING - Suite initializat=
ion failed...&quot; People might think this is a driver problem.</div>
<p></p>
<p><br>
</p>
<p>Tested with <span>non-privileged user. Now the error message is like.</s=
pan></p>
<p><span></span></p>
<div>...<br>
Error:Permission denied. Hint: Try to run this test program as root.<br>
WARNING - Suite initialization failed for 'Basic Tests'.</div>
<p></p>
<p>...<br>
</p>
<p><br>
</p>
<p><br>
</p>
<p>Tested as root with no regression.<br>
</p>
<p><br>
</p>
<p><br>
</p>
<p>Please review.</p>
<p><br>
</p>
<p>Thanks,</p>
<p>Alex Bin Xie<br>
</p>
</div>
</div>
</div>
</div>
</div>
</div>
</div>
</body>
</html>

--_000_CY4PR12MB16405027D18941DAF1D35A22F2660CY4PR12MB1640namp_--

--_004_CY4PR12MB16405027D18941DAF1D35A22F2660CY4PR12MB1640namp_
Content-Type: text/x-patch;
	name="0001-amdgpu-Provide-more-specific-error-message-if-non-pr.patch"
Content-Description: 0001-amdgpu-Provide-more-specific-error-message-if-non-pr.patch
Content-Disposition: attachment;
	filename="0001-amdgpu-Provide-more-specific-error-message-if-non-pr.patch";
	size=3038; creation-date="Wed, 11 Jan 2017 21:48:58 GMT";
	modification-date="Wed, 11 Jan 2017 21:48:58 GMT"
Content-Transfer-Encoding: base64

RnJvbSAwMmZlMmFjYzdhMWFlYzM0YTlmMWFlNjg3ZmI2MjEwYTg0OGIzMDhlIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBBbGV4IFhpZSA8QWxleEJpbi5YaWVAYW1kLmNvbT4KRGF0ZTog
V2VkLCAxMSBKYW4gMjAxNyAxNjo0MzoyMSAtMDUwMApTdWJqZWN0OiBbUEFUQ0ggbGliZHJtXSBh
bWRncHU6IFByb3ZpZGUgbW9yZSBzcGVjaWZpYyBlcnJvciBtZXNzYWdlIGlmCiBub24tcHJpdmls
ZWdlZCB1c2VyIHJ1bnMgYW1kZ3B1X3Rlc3QKCkJlZm9yZSB0aGlzIGNoYW5nZSwgdGhlIGVycm9y
IG1lc3NhZ2UgaXM6IiBXQVJOSU5HIC0gU3VpdGUgaW5pdGlhbGl6YXRpb24gZmFpbGVkLi4uIiBQ
ZW9wbGUgbWlnaHQgdGhpbmsgdGhpcyBpcyBhIGRyaXZlciBwcm9ibGVtLgoKdjI6IFVzZSBzdHJl
cnJvciBpbnN0ZWFkIG9mICVtLiAlbSBpcyBhIEdOVSBDIExpYnJhcnkgZXh0ZW5zaW9uLgoKQ2hh
bmdlLUlkOiBJYjg5MWM0MGVjODEyMDUzZjQ5Y2U1YTk5OTA5NDU1YWMzMTM3ZTMyYwpTaWduZWQt
b2ZmLWJ5OiBBbGV4IFhpZSA8QWxleEJpbi5YaWVAYW1kLmNvbT4KLS0tCiB0ZXN0cy9hbWRncHUv
YmFzaWNfdGVzdHMuYyB8IDUgKysrKy0KIHRlc3RzL2FtZGdwdS9ib190ZXN0cy5jICAgIHwgNiAr
KysrKy0KIHRlc3RzL2FtZGdwdS9jc190ZXN0cy5jICAgIHwgNiArKysrKy0KIHRlc3RzL2FtZGdw
dS92Y2VfdGVzdHMuYyAgIHwgNiArKysrKy0KIDQgZmlsZXMgY2hhbmdlZCwgMTkgaW5zZXJ0aW9u
cygrKSwgNCBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS90ZXN0cy9hbWRncHUvYmFzaWNfdGVz
dHMuYyBiL3Rlc3RzL2FtZGdwdS9iYXNpY190ZXN0cy5jCmluZGV4IDExZjZhNjMuLjdhNDcyNzQg
MTAwNjQ0Ci0tLSBhL3Rlc3RzL2FtZGdwdS9iYXNpY190ZXN0cy5jCisrKyBiL3Rlc3RzL2FtZGdw
dS9iYXNpY190ZXN0cy5jCkBAIC0yMDYsOCArMjA2LDExIEBAIGludCBzdWl0ZV9iYXNpY190ZXN0
c19pbml0KHZvaWQpCiAKIAlpZiAociA9PSAwKQogCQlyZXR1cm4gQ1VFX1NVQ0NFU1M7Ci0JZWxz
ZQorCWVsc2UgeworCQlpZiAoKHIgPT0gLUVBQ0NFUykgJiYgKGVycm5vID09IEVBQ0NFUykpCisJ
CQlwcmludGYgKCJcblxuRXJyb3I6JXMuIEhpbnQ6IFRyeSB0byBydW4gdGhpcyB0ZXN0IHByb2dy
YW0gYXMgcm9vdC4iLCBzdHJlcnJvcihlcnJubykpOwogCQlyZXR1cm4gQ1VFX1NJTklUX0ZBSUxF
RDsKKwl9CiB9CiAKIGludCBzdWl0ZV9iYXNpY190ZXN0c19jbGVhbih2b2lkKQpkaWZmIC0tZ2l0
IGEvdGVzdHMvYW1kZ3B1L2JvX3Rlc3RzLmMgYi90ZXN0cy9hbWRncHUvYm9fdGVzdHMuYwppbmRl
eCA5OTM4OTVkLi4zN2VlNmQxIDEwMDY0NAotLS0gYS90ZXN0cy9hbWRncHUvYm9fdGVzdHMuYwor
KysgYi90ZXN0cy9hbWRncHUvYm9fdGVzdHMuYwpAQCAtNjUsOCArNjUsMTIgQEAgaW50IHN1aXRl
X2JvX3Rlc3RzX2luaXQodm9pZCkKIAogCXIgPSBhbWRncHVfZGV2aWNlX2luaXRpYWxpemUoZHJt
X2FtZGdwdVswXSwgJm1ham9yX3ZlcnNpb24sCiAJCQkJICAmbWlub3JfdmVyc2lvbiwgJmRldmlj
ZV9oYW5kbGUpOwotCWlmIChyKQorCWlmIChyKSB7CisJCWlmICgociA9PSAtRUFDQ0VTKSAmJiAo
ZXJybm8gPT0gRUFDQ0VTKSkKKwkJCXByaW50ZiAoIlxuXG5FcnJvcjolcy4gSGludDogVHJ5IHRv
IHJ1biB0aGlzIHRlc3QgcHJvZ3JhbSBhcyByb290LiIsIHN0cmVycm9yKGVycm5vKSk7CisKIAkJ
cmV0dXJuIENVRV9TSU5JVF9GQUlMRUQ7CisJfQogCiAJcmVxLmFsbG9jX3NpemUgPSBCVUZGRVJf
U0laRTsKIAlyZXEucGh5c19hbGlnbm1lbnQgPSBCVUZGRVJfQUxJR047CmRpZmYgLS1naXQgYS90
ZXN0cy9hbWRncHUvY3NfdGVzdHMuYyBiL3Rlc3RzL2FtZGdwdS9jc190ZXN0cy5jCmluZGV4IGEw
MWVlNDguLmNlNzIzYTkgMTAwNjQ0Ci0tLSBhL3Rlc3RzL2FtZGdwdS9jc190ZXN0cy5jCisrKyBi
L3Rlc3RzL2FtZGdwdS9jc190ZXN0cy5jCkBAIC03Niw4ICs3NiwxMiBAQCBpbnQgc3VpdGVfY3Nf
dGVzdHNfaW5pdCh2b2lkKQogCiAJciA9IGFtZGdwdV9kZXZpY2VfaW5pdGlhbGl6ZShkcm1fYW1k
Z3B1WzBdLCAmbWFqb3JfdmVyc2lvbiwKIAkJCQkgICAgICZtaW5vcl92ZXJzaW9uLCAmZGV2aWNl
X2hhbmRsZSk7Ci0JaWYgKHIpCisJaWYgKHIpIHsKKwkJaWYgKChyID09IC1FQUNDRVMpICYmIChl
cnJubyA9PSBFQUNDRVMpKQorCQkJcHJpbnRmICgiXG5cbkVycm9yOiVzLiBIaW50OiBUcnkgdG8g
cnVuIHRoaXMgdGVzdCBwcm9ncmFtIGFzIHJvb3QuIiwgc3RyZXJyb3IoZXJybm8pKTsKKwogCQly
ZXR1cm4gQ1VFX1NJTklUX0ZBSUxFRDsKKwl9CiAKIAlmYW1pbHlfaWQgPSBkZXZpY2VfaGFuZGxl
LT5pbmZvLmZhbWlseV9pZDsKIAkvKiBWSSBhc2ljIFBPTEFSSVMxMC8xMSBoYXZlIHNwZWNpZmlj
IGV4dGVybmFsX3Jldl9pZCAqLwpkaWZmIC0tZ2l0IGEvdGVzdHMvYW1kZ3B1L3ZjZV90ZXN0cy5j
IGIvdGVzdHMvYW1kZ3B1L3ZjZV90ZXN0cy5jCmluZGV4IDQ5MTUxNzAuLjI5MzZlZjUgMTAwNjQ0
Ci0tLSBhL3Rlc3RzL2FtZGdwdS92Y2VfdGVzdHMuYworKysgYi90ZXN0cy9hbWRncHUvdmNlX3Rl
c3RzLmMKQEAgLTk0LDggKzk0LDEyIEBAIGludCBzdWl0ZV92Y2VfdGVzdHNfaW5pdCh2b2lkKQog
CiAJciA9IGFtZGdwdV9kZXZpY2VfaW5pdGlhbGl6ZShkcm1fYW1kZ3B1WzBdLCAmbWFqb3JfdmVy
c2lvbiwKIAkJCQkgICAgICZtaW5vcl92ZXJzaW9uLCAmZGV2aWNlX2hhbmRsZSk7Ci0JaWYgKHIp
CisJaWYgKHIpIHsKKwkJaWYgKChyID09IC1FQUNDRVMpICYmIChlcnJubyA9PSBFQUNDRVMpKQor
CQkJcHJpbnRmICgiXG5cbkVycm9yOiVzLiBIaW50OiBUcnkgdG8gcnVuIHRoaXMgdGVzdCBwcm9n
cmFtIGFzIHJvb3QuIiwgc3RyZXJyb3IoZXJybm8pKTsKKwogCQlyZXR1cm4gQ1VFX1NJTklUX0ZB
SUxFRDsKKwl9CiAKIAlmYW1pbHlfaWQgPSBkZXZpY2VfaGFuZGxlLT5pbmZvLmZhbWlseV9pZDsK
IAl2Y2VfaGFydmVzdF9jb25maWcgPSBkZXZpY2VfaGFuZGxlLT5pbmZvLnZjZV9oYXJ2ZXN0X2Nv
bmZpZzsKLS0gCjIuNy40Cgo=

--_004_CY4PR12MB16405027D18941DAF1D35A22F2660CY4PR12MB1640namp_
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--_004_CY4PR12MB16405027D18941DAF1D35A22F2660CY4PR12MB1640namp_--
