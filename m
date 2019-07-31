From: Monk Liu <Monk.Liu-5C7GfCeVMHo@public.gmane.org>
Subject: [PATCH 2/3] drm/amdgpu: fix incorrect judge on sos fw version
Date: Wed, 31 Jul 2019 11:53:45 +0800
Message-ID: <1564545226-2633-2-git-send-email-Monk.Liu@amd.com>
References: <1564545226-2633-1-git-send-email-Monk.Liu@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <1564545226-2633-1-git-send-email-Monk.Liu-5C7GfCeVMHo@public.gmane.org>
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
To: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Cc: Monk Liu <Monk.Liu-5C7GfCeVMHo@public.gmane.org>

Zm9yIFNSSU9WIHRoZSBTT1MgZncgb2YgUFNQIGlzIGxvYWRlZCBpbiBoeXBlcnZpc29yIHRodXMK
Z3Vlc3Qgd29uJ3QgdGVsbCB0aGUgdmVyc2lvbiBvZiBpdCwgYW5kIGp1ZGdpbmcgZmVhdHVyZSBi
eQpyZWFkaW5nIHRoZSBzb3MgZncgdmVyc2lvbiBpbiBndWVzdCBzaWRlIGlzIGNvbXBsZXRlbHkg
d3JvbmcKClNpZ25lZC1vZmYtYnk6IE1vbmsgTGl1IDxNb25rLkxpdUBhbWQuY29tPgotLS0KIGRy
aXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L3BzcF92M18xLmMgfCAyICstCiAxIGZpbGUgY2hhbmdl
ZCwgMSBpbnNlcnRpb24oKyksIDEgZGVsZXRpb24oLSkKCmRpZmYgLS1naXQgYS9kcml2ZXJzL2dw
dS9kcm0vYW1kL2FtZGdwdS9wc3BfdjNfMS5jIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUv
cHNwX3YzXzEuYwppbmRleCBlYzNhMDU2Li5iYTMyNzU4IDEwMDY0NAotLS0gYS9kcml2ZXJzL2dw
dS9kcm0vYW1kL2FtZGdwdS9wc3BfdjNfMS5jCisrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1k
Z3B1L3BzcF92M18xLmMKQEAgLTYzNCw3ICs2MzQsNyBAQCBzdGF0aWMgaW50IHBzcF92M18xX21v
ZGUxX3Jlc2V0KHN0cnVjdCBwc3BfY29udGV4dCAqcHNwKQogCiBzdGF0aWMgYm9vbCBwc3BfdjNf
MV9zdXBwb3J0X3Ztcl9yaW5nKHN0cnVjdCBwc3BfY29udGV4dCAqcHNwKQogewotCWlmIChhbWRn
cHVfc3Jpb3ZfdmYocHNwLT5hZGV2KSAmJiBwc3AtPnNvc19md192ZXJzaW9uID49IDB4ODA0NTUp
CisJaWYgKGFtZGdwdV9zcmlvdl92Zihwc3AtPmFkZXYpKQogCQlyZXR1cm4gdHJ1ZTsKIAogCXJl
dHVybiBmYWxzZTsKLS0gCjIuNy40CgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNr
dG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2Ft
ZC1nZng=
