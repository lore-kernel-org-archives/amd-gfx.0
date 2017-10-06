From: "Zhu, Rex" <Rex.Zhu-5C7GfCeVMHo@public.gmane.org>
Subject: Re: tonga mclk regression
Date: Fri, 6 Oct 2017 05:55:17 +0000
Message-ID: <MWHPR12MB16943F3E423EB961514BE05AFB710@MWHPR12MB1694.namprd12.prod.outlook.com>
References: <2139aeb7-2b11-dcee-f2f9-54e8bdc22828@amd.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="_004_MWHPR12MB16943F3E423EB961514BE05AFB710MWHPR12MB1694namp_"
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <2139aeb7-2b11-dcee-f2f9-54e8bdc22828-5C7GfCeVMHo@public.gmane.org>
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
To: "StDenis, Tom" <Tom.StDenis-5C7GfCeVMHo@public.gmane.org>, amd-gfx mailing list <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
Cc: "Deucher, Alexander" <Alexander.Deucher-5C7GfCeVMHo@public.gmane.org>

--_004_MWHPR12MB16943F3E423EB961514BE05AFB710MWHPR12MB1694namp_
Content-Type: multipart/alternative;
	boundary="_000_MWHPR12MB16943F3E423EB961514BE05AFB710MWHPR12MB1694namp_"

--_000_MWHPR12MB16943F3E423EB961514BE05AFB710MWHPR12MB1694namp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable


Thanks Tom.


The attached patch can fix this bug.



Best Regards

Rex




________________________________
From: StDenis, Tom
Sent: Thursday, October 5, 2017 9:42 PM
To: amd-gfx mailing list
Cc: Zhu, Rex; Deucher, Alexander
Subject: tonga mclk regression

I've bisected it to this commit

[root@fx6 linux2]# git bisect bad
df1e63942063a0638a5813e5904988d834db2665 is the first bad commit
commit df1e63942063a0638a5813e5904988d834db2665
Author: Rex Zhu <Rex.Zhu-5C7GfCeVMHo@public.gmane.org>
Date:   Fri Sep 1 13:46:20 2017 +0800

     drm/amd/powerplay: delete eventmgr layer in poweprlay

     Reviewed-by: Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org>
     Signed-off-by: Rex Zhu <Rex.Zhu-5C7GfCeVMHo@public.gmane.org>
     Signed-off-by: Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org>

:040000 040000 5b955ab18919974b351c81565044f3280253fe03
35f848a30a0b57d7fdee53133ae5d8e066406d8f M      drivers

The commit before this has a properly throttling mclk with
glmark2/xonotic-glx and this commit does not (locks at 300MHz).  Should
point that the commit ahead of this locks at 150MHz (lowest setting).

I haven't actually looked at this commit for a fix yet.

Cheers,
Tom

--_000_MWHPR12MB16943F3E423EB961514BE05AFB710MWHPR12MB1694namp_
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
<p><br>
</p>
<p>Thanks Tom.</p>
<p><br>
</p>
<p>The attached patch can fix&nbsp;this bug.</p>
<p><br>
</p>
<p><br>
</p>
<p>Best Regards</p>
<p>Rex<br>
</p>
<p><br>
</p>
<p><br>
</p>
<p><br>
</p>
<br>
<div style=3D"color: rgb(0, 0, 0);">
<div>
<hr tabindex=3D"-1" style=3D"display:inline-block; width:98%">
<div id=3D"x_divRplyFwdMsg" dir=3D"ltr"><font style=3D"font-size:11pt" colo=
r=3D"#000000" face=3D"Calibri, sans-serif"><b>From:</b> StDenis, Tom<br>
<b>Sent:</b> Thursday, October 5, 2017 9:42 PM<br>
<b>To:</b> amd-gfx mailing list<br>
<b>Cc:</b> Zhu, Rex; Deucher, Alexander<br>
<b>Subject:</b> tonga mclk regression</font>
<div>&nbsp;</div>
</div>
</div>
<font size=3D"2"><span style=3D"font-size:10pt;">
<div class=3D"PlainText">I've bisected it to this commit<br>
<br>
[root@fx6 linux2]# git bisect bad<br>
df1e63942063a0638a5813e5904988d834db2665 is the first bad commit<br>
commit df1e63942063a0638a5813e5904988d834db2665<br>
Author: Rex Zhu &lt;Rex.Zhu-5C7GfCeVMHo@public.gmane.org&gt;<br>
Date:&nbsp;&nbsp; Fri Sep 1 13:46:20 2017 &#43;0800<br>
<br>
&nbsp;&nbsp;&nbsp;&nbsp; drm/amd/powerplay: delete eventmgr layer in powepr=
lay<br>
<br>
&nbsp;&nbsp;&nbsp;&nbsp; Reviewed-by: Alex Deucher &lt;alexander.deucher@am=
d.com&gt;<br>
&nbsp;&nbsp;&nbsp;&nbsp; Signed-off-by: Rex Zhu &lt;Rex.Zhu-5C7GfCeVMHo@public.gmane.org&gt;<br>
&nbsp;&nbsp;&nbsp;&nbsp; Signed-off-by: Alex Deucher &lt;alexander.deucher@=
amd.com&gt;<br>
<br>
:040000 040000 5b955ab18919974b351c81565044f3280253fe03 <br>
35f848a30a0b57d7fdee53133ae5d8e066406d8f M&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dr=
ivers<br>
<br>
The commit before this has a properly throttling mclk with <br>
glmark2/xonotic-glx and this commit does not (locks at 300MHz).&nbsp; Shoul=
d <br>
point that the commit ahead of this locks at 150MHz (lowest setting).<br>
<br>
I haven't actually looked at this commit for a fix yet.<br>
<br>
Cheers,<br>
Tom<br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_MWHPR12MB16943F3E423EB961514BE05AFB710MWHPR12MB1694namp_--

--_004_MWHPR12MB16943F3E423EB961514BE05AFB710MWHPR12MB1694namp_
Content-Type: text/x-patch;
	name="0002-drm-amd-powerplay-fix-mclk-can-t-switch-on-Tonga.patch"
Content-Description: 0002-drm-amd-powerplay-fix-mclk-can-t-switch-on-Tonga.patch
Content-Disposition: attachment;
	filename="0002-drm-amd-powerplay-fix-mclk-can-t-switch-on-Tonga.patch";
	size=2257; creation-date="Fri, 06 Oct 2017 05:53:42 GMT";
	modification-date="Fri, 06 Oct 2017 05:53:42 GMT"
Content-Transfer-Encoding: base64

RnJvbSA2ZWZiZjY5ZmYyYzdhYmMyMTQzZjUwZWUyOGZhODI0YzkxZGI0ODVhIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBSZXggWmh1IDxSZXguWmh1QGFtZC5jb20+CkRhdGU6IEZyaSwg
NiBPY3QgMjAxNyAxMjoxNzoxNiArMDgwMApTdWJqZWN0OiBbUEFUQ0ggMi8yXSBkcm0vYW1kL3Bv
d2VycGxheTogZml4IG1jbGsgY2FuJ3Qgc3dpdGNoIG9uIFRvbmdhCgpyZWdyZXNzdGlvbiBpc3N1
ZSBjYXVzZWQgYnkKY29tbWl0IDQ3MDQ3MjYzYzUyNzc5ZjFmMzM5M2MzMmUzZTUzNjYxYjUzYTM3
MmUKKCJkcm0vYW1kL3Bvd2VycGxheTogZGVsZXRlIGV2ZW50bWdyIHJlbGF0ZWQgZmlsZXMuIikK
CkNoYW5nZS1JZDogSWEyZGRmODM0NDNhNjY2ZmQxZTk3ZGRmNDE0MmFjY2UxNDdiZTAwZGMKU2ln
bmVkLW9mZi1ieTogUmV4IFpodSA8UmV4LlpodUBhbWQuY29tPgotLS0KIGRyaXZlcnMvZ3B1L2Ry
bS9hbWQvcG93ZXJwbGF5L2h3bWdyL2h3bWdyLmMgIHwgMSAtCiBkcml2ZXJzL2dwdS9kcm0vYW1k
L3Bvd2VycGxheS9od21nci9wcF9wc20uYyB8IDYgKysrKystCiAyIGZpbGVzIGNoYW5nZWQsIDUg
aW5zZXJ0aW9ucygrKSwgMiBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9k
cm0vYW1kL3Bvd2VycGxheS9od21nci9od21nci5jIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9wb3dl
cnBsYXkvaHdtZ3IvaHdtZ3IuYwppbmRleCAzNWU4MGM5Li5jZTU5ZTBlIDEwMDY0NAotLS0gYS9k
cml2ZXJzL2dwdS9kcm0vYW1kL3Bvd2VycGxheS9od21nci9od21nci5jCisrKyBiL2RyaXZlcnMv
Z3B1L2RybS9hbWQvcG93ZXJwbGF5L2h3bWdyL2h3bWdyLmMKQEAgLTI5Miw3ICsyOTIsNiBAQCBp
bnQgaHdtZ3JfaHdfZmluaShzdHJ1Y3QgcHBfaW5zdGFuY2UgKmhhbmRsZSkKIAogCXBobV9zdG9w
X3RoZXJtYWxfY29udHJvbGxlcihod21ncik7CiAJcHNtX3NldF9ib290X3N0YXRlcyhod21ncik7
Ci0JcGhtX2Rpc3BsYXlfY29uZmlndXJhdGlvbl9jaGFuZ2VkKGh3bWdyKTsKIAlwc21fYWRqdXN0
X3Bvd2VyX3N0YXRlX2R5bmFtaWMoaHdtZ3IsIGZhbHNlLCBOVUxMKTsKIAlwaG1fZGlzYWJsZV9k
eW5hbWljX3N0YXRlX21hbmFnZW1lbnQoaHdtZ3IpOwogCXBobV9kaXNhYmxlX2Nsb2NrX3Bvd2Vy
X2dhdGluZ3MoaHdtZ3IpOwpkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9wb3dlcnBs
YXkvaHdtZ3IvcHBfcHNtLmMgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL3Bvd2VycGxheS9od21nci9w
cF9wc20uYwppbmRleCAxNjdjZGMzLi5mZmE0NGJiIDEwMDY0NAotLS0gYS9kcml2ZXJzL2dwdS9k
cm0vYW1kL3Bvd2VycGxheS9od21nci9wcF9wc20uYworKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1k
L3Bvd2VycGxheS9od21nci9wcF9wc20uYwpAQCAtMjI0LDYgKzIyNCw4IEBAIGludCBwc21fYWRq
dXN0X3Bvd2VyX3N0YXRlX2R5bmFtaWMoc3RydWN0IHBwX2h3bWdyICpod21nciwgYm9vbCBza2lw
LAogCWlmIChza2lwKQogCQlyZXR1cm4gMDsKIAorCXBobV9kaXNwbGF5X2NvbmZpZ3VyYXRpb25f
Y2hhbmdlZChod21ncik7CisKIAlpZiAobmV3X3BzICE9IE5VTEwpCiAJCXJlcXVlc3RlZCA9IG5l
d19wczsKIAllbHNlCkBAIC0yMzIsNyArMjM0LDYgQEAgaW50IHBzbV9hZGp1c3RfcG93ZXJfc3Rh
dGVfZHluYW1pYyhzdHJ1Y3QgcHBfaHdtZ3IgKmh3bWdyLCBib29sIHNraXAsCiAJcGN1cnJlbnQg
PSBod21nci0+Y3VycmVudF9wczsKIAogCXBobV9hcHBseV9zdGF0ZV9hZGp1c3RfcnVsZXMoaHdt
Z3IsIHJlcXVlc3RlZCwgcGN1cnJlbnQpOwotCiAJaWYgKHBjdXJyZW50ID09IE5VTEwgfHwgKDAg
IT0gcGhtX2NoZWNrX3N0YXRlc19lcXVhbChod21nciwKIAkJCSZwY3VycmVudC0+aGFyZHdhcmUs
ICZyZXF1ZXN0ZWQtPmhhcmR3YXJlLCAmZXF1YWwpKSkKIAkJZXF1YWwgPSBmYWxzZTsKQEAgLTI0
MSw2ICsyNDIsOSBAQCBpbnQgcHNtX2FkanVzdF9wb3dlcl9zdGF0ZV9keW5hbWljKHN0cnVjdCBw
cF9od21nciAqaHdtZ3IsIGJvb2wgc2tpcCwKIAkJcGhtX3NldF9wb3dlcl9zdGF0ZShod21nciwg
JnBjdXJyZW50LT5oYXJkd2FyZSwgJnJlcXVlc3RlZC0+aGFyZHdhcmUpOwogCQltZW1jcHkoaHdt
Z3ItPmN1cnJlbnRfcHMsIGh3bWdyLT5yZXF1ZXN0X3BzLCBod21nci0+cHNfc2l6ZSk7CiAJfQor
CisJcGhtX25vdGlmeV9zbWNfZGlzcGxheV9jb25maWdfYWZ0ZXJfcHNfYWRqdXN0bWVudChod21n
cik7CisKIAlyZXR1cm4gMDsKIH0KIAotLSAKMS45LjEKCg==

--_004_MWHPR12MB16943F3E423EB961514BE05AFB710MWHPR12MB1694namp_
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--_004_MWHPR12MB16943F3E423EB961514BE05AFB710MWHPR12MB1694namp_--
