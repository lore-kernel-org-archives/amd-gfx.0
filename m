From: "Xie, AlexBin" <AlexBin.Xie-5C7GfCeVMHo@public.gmane.org>
Subject: More specific libdrm error message
Date: Wed, 11 Jan 2017 21:14:55 +0000
Message-ID: <CY4PR12MB16409A6D631EA457A365ECF0F2660@CY4PR12MB1640.namprd12.prod.outlook.com>
References: <CY4PR12MB1640D019595EC5A1C6D1F670F2660@CY4PR12MB1640.namprd12.prod.outlook.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="_004_CY4PR12MB16409A6D631EA457A365ECF0F2660CY4PR12MB1640namp_"
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <CY4PR12MB1640D019595EC5A1C6D1F670F2660-rpdhrqHFk06q//3LJcutlgdYzm3356FpvxpqHgZTriW3zl9H0oFU5g@public.gmane.org>
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

--_004_CY4PR12MB16409A6D631EA457A365ECF0F2660CY4PR12MB1640namp_
Content-Type: multipart/alternative;
	boundary="_000_CY4PR12MB16409A6D631EA457A365ECF0F2660CY4PR12MB1640namp_"

--_000_CY4PR12MB16409A6D631EA457A365ECF0F2660CY4PR12MB1640namp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

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

--_000_CY4PR12MB16409A6D631EA457A365ECF0F2660CY4PR12MB1640namp_
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
Hi,<br>
<div style=3D"color: rgb(0, 0, 0);">
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
</body>
</html>

--_000_CY4PR12MB16409A6D631EA457A365ECF0F2660CY4PR12MB1640namp_--

--_004_CY4PR12MB16409A6D631EA457A365ECF0F2660CY4PR12MB1640namp_
Content-Type: text/x-patch;
	name="0001-amdgpu-Provide-more-specific-error-message-if-non-pr.patch"
Content-Description: 0001-amdgpu-Provide-more-specific-error-message-if-non-pr.patch
Content-Disposition: attachment;
	filename="0001-amdgpu-Provide-more-specific-error-message-if-non-pr.patch";
	size=2904; creation-date="Wed, 11 Jan 2017 21:14:43 GMT";
	modification-date="Wed, 11 Jan 2017 21:14:43 GMT"
Content-Transfer-Encoding: base64

RnJvbSAzY2I0NGRlM2M0YmFhM2RiNTE0ZGJjYjE4MGM0ZmRhZTEyOGQ0ODY0IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBBbGV4IFhpZSA8QWxleEJpbi5YaWVAYW1kLmNvbT4KRGF0ZTog
V2VkLCAxMSBKYW4gMjAxNyAxNjowMDo0NyAtMDUwMApTdWJqZWN0OiBbUEFUQ0ggbGliZHJtXSBh
bWRncHU6IFByb3ZpZGUgbW9yZSBzcGVjaWZpYyBlcnJvciBtZXNzYWdlIGlmCiBub24tcHJpdmls
ZWdlZCB1c2VyIHJ1bnMgYW1kZ3B1X3Rlc3QKCkJlZm9yZSB0aGlzIGNoYW5nZSwgdGhlIGVycm9y
IG1lc3NhZ2UgaXM6IiBXQVJOSU5HIC0gU3VpdGUgaW5pdGlhbGl6YXRpb24gZmFpbGVkLi4uIiBQ
ZW9wbGUgbWlnaHQgdGhpbmsgdGhpcyBpcyBhIGRyaXZlciBwcm9ibGVtLgoKQ2hhbmdlLUlkOiBJ
Yjg5MWM0MGVjODEyMDUzZjQ5Y2U1YTk5OTA5NDU1YWMzMTM3ZTMyYwpTaWduZWQtb2ZmLWJ5OiBB
bGV4IFhpZSA8QWxleEJpbi5YaWVAYW1kLmNvbT4KLS0tCiB0ZXN0cy9hbWRncHUvYmFzaWNfdGVz
dHMuYyB8IDUgKysrKy0KIHRlc3RzL2FtZGdwdS9ib190ZXN0cy5jICAgIHwgNiArKysrKy0KIHRl
c3RzL2FtZGdwdS9jc190ZXN0cy5jICAgIHwgNiArKysrKy0KIHRlc3RzL2FtZGdwdS92Y2VfdGVz
dHMuYyAgIHwgNiArKysrKy0KIDQgZmlsZXMgY2hhbmdlZCwgMTkgaW5zZXJ0aW9ucygrKSwgNCBk
ZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS90ZXN0cy9hbWRncHUvYmFzaWNfdGVzdHMuYyBiL3Rl
c3RzL2FtZGdwdS9iYXNpY190ZXN0cy5jCmluZGV4IDExZjZhNjMuLmI5NWYzZjQgMTAwNjQ0Ci0t
LSBhL3Rlc3RzL2FtZGdwdS9iYXNpY190ZXN0cy5jCisrKyBiL3Rlc3RzL2FtZGdwdS9iYXNpY190
ZXN0cy5jCkBAIC0yMDYsOCArMjA2LDExIEBAIGludCBzdWl0ZV9iYXNpY190ZXN0c19pbml0KHZv
aWQpCiAKIAlpZiAociA9PSAwKQogCQlyZXR1cm4gQ1VFX1NVQ0NFU1M7Ci0JZWxzZQorCWVsc2Ug
eworCQlpZiAoKHIgPT0gLUVBQ0NFUykgJiYgKGVycm5vID09IEVBQ0NFUykpCisJCQlwcmludGYg
KCJcblxuRXJyb3I6JW0uIEhpbnQ6IFRyeSB0byBydW4gdGhpcyB0ZXN0IHByb2dyYW0gYXMgcm9v
dC4iKTsKIAkJcmV0dXJuIENVRV9TSU5JVF9GQUlMRUQ7CisJfQogfQogCiBpbnQgc3VpdGVfYmFz
aWNfdGVzdHNfY2xlYW4odm9pZCkKZGlmZiAtLWdpdCBhL3Rlc3RzL2FtZGdwdS9ib190ZXN0cy5j
IGIvdGVzdHMvYW1kZ3B1L2JvX3Rlc3RzLmMKaW5kZXggOTkzODk1ZC4uN2Y0NTUwZCAxMDA2NDQK
LS0tIGEvdGVzdHMvYW1kZ3B1L2JvX3Rlc3RzLmMKKysrIGIvdGVzdHMvYW1kZ3B1L2JvX3Rlc3Rz
LmMKQEAgLTY1LDggKzY1LDEyIEBAIGludCBzdWl0ZV9ib190ZXN0c19pbml0KHZvaWQpCiAKIAly
ID0gYW1kZ3B1X2RldmljZV9pbml0aWFsaXplKGRybV9hbWRncHVbMF0sICZtYWpvcl92ZXJzaW9u
LAogCQkJCSAgJm1pbm9yX3ZlcnNpb24sICZkZXZpY2VfaGFuZGxlKTsKLQlpZiAocikKKwlpZiAo
cikgeworCQlpZiAoKHIgPT0gLUVBQ0NFUykgJiYgKGVycm5vID09IEVBQ0NFUykpCisJCQlwcmlu
dGYgKCJcblxuRXJyb3I6JW0uIEhpbnQ6IFRyeSB0byBydW4gdGhpcyB0ZXN0IHByb2dyYW0gYXMg
cm9vdC4iKTsKKwogCQlyZXR1cm4gQ1VFX1NJTklUX0ZBSUxFRDsKKwl9CiAKIAlyZXEuYWxsb2Nf
c2l6ZSA9IEJVRkZFUl9TSVpFOwogCXJlcS5waHlzX2FsaWdubWVudCA9IEJVRkZFUl9BTElHTjsK
ZGlmZiAtLWdpdCBhL3Rlc3RzL2FtZGdwdS9jc190ZXN0cy5jIGIvdGVzdHMvYW1kZ3B1L2NzX3Rl
c3RzLmMKaW5kZXggYTAxZWU0OC4uMDQzMjMzMiAxMDA2NDQKLS0tIGEvdGVzdHMvYW1kZ3B1L2Nz
X3Rlc3RzLmMKKysrIGIvdGVzdHMvYW1kZ3B1L2NzX3Rlc3RzLmMKQEAgLTc2LDggKzc2LDEyIEBA
IGludCBzdWl0ZV9jc190ZXN0c19pbml0KHZvaWQpCiAKIAlyID0gYW1kZ3B1X2RldmljZV9pbml0
aWFsaXplKGRybV9hbWRncHVbMF0sICZtYWpvcl92ZXJzaW9uLAogCQkJCSAgICAgJm1pbm9yX3Zl
cnNpb24sICZkZXZpY2VfaGFuZGxlKTsKLQlpZiAocikKKwlpZiAocikgeworCQlpZiAoKHIgPT0g
LUVBQ0NFUykgJiYgKGVycm5vID09IEVBQ0NFUykpCisJCQlwcmludGYgKCJcblxuRXJyb3I6JW0u
IEhpbnQ6IFRyeSB0byBydW4gdGhpcyB0ZXN0IHByb2dyYW0gYXMgcm9vdC4iKTsKKwogCQlyZXR1
cm4gQ1VFX1NJTklUX0ZBSUxFRDsKKwl9CiAKIAlmYW1pbHlfaWQgPSBkZXZpY2VfaGFuZGxlLT5p
bmZvLmZhbWlseV9pZDsKIAkvKiBWSSBhc2ljIFBPTEFSSVMxMC8xMSBoYXZlIHNwZWNpZmljIGV4
dGVybmFsX3Jldl9pZCAqLwpkaWZmIC0tZ2l0IGEvdGVzdHMvYW1kZ3B1L3ZjZV90ZXN0cy5jIGIv
dGVzdHMvYW1kZ3B1L3ZjZV90ZXN0cy5jCmluZGV4IDQ5MTUxNzAuLjhjN2M4YzYgMTAwNjQ0Ci0t
LSBhL3Rlc3RzL2FtZGdwdS92Y2VfdGVzdHMuYworKysgYi90ZXN0cy9hbWRncHUvdmNlX3Rlc3Rz
LmMKQEAgLTk0LDggKzk0LDEyIEBAIGludCBzdWl0ZV92Y2VfdGVzdHNfaW5pdCh2b2lkKQogCiAJ
ciA9IGFtZGdwdV9kZXZpY2VfaW5pdGlhbGl6ZShkcm1fYW1kZ3B1WzBdLCAmbWFqb3JfdmVyc2lv
biwKIAkJCQkgICAgICZtaW5vcl92ZXJzaW9uLCAmZGV2aWNlX2hhbmRsZSk7Ci0JaWYgKHIpCisJ
aWYgKHIpIHsKKwkJaWYgKChyID09IC1FQUNDRVMpICYmIChlcnJubyA9PSBFQUNDRVMpKQorCQkJ
cHJpbnRmICgiXG5cbkVycm9yOiVtLiBIaW50OiBUcnkgdG8gcnVuIHRoaXMgdGVzdCBwcm9ncmFt
IGFzIHJvb3QuIik7CisKIAkJcmV0dXJuIENVRV9TSU5JVF9GQUlMRUQ7CisJfQogCiAJZmFtaWx5
X2lkID0gZGV2aWNlX2hhbmRsZS0+aW5mby5mYW1pbHlfaWQ7CiAJdmNlX2hhcnZlc3RfY29uZmln
ID0gZGV2aWNlX2hhbmRsZS0+aW5mby52Y2VfaGFydmVzdF9jb25maWc7Ci0tIAoyLjcuNAoK

--_004_CY4PR12MB16409A6D631EA457A365ECF0F2660CY4PR12MB1640namp_
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--_004_CY4PR12MB16409A6D631EA457A365ECF0F2660CY4PR12MB1640namp_--
