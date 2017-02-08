From: Monk Liu <Monk.Liu-5C7GfCeVMHo@public.gmane.org>
Subject: [PATCH 09/11] drm/amdgpu:imple ring clear
Date: Wed, 8 Feb 2017 17:26:57 +0800
Message-ID: <1486546019-31045-9-git-send-email-Monk.Liu@amd.com>
References: <1486546019-31045-1-git-send-email-Monk.Liu@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <1486546019-31045-1-git-send-email-Monk.Liu-5C7GfCeVMHo@public.gmane.org>
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

d2UgY2FuIHVzZSBpdCBjbGVhciByaW5nIGJ1ZmZlciBpbnN0ZWFkIG9mIGZ1bGxmaWxsCjAsIHdo
aWNoIGlzIG5vdCBjb3JyZWN0IGZvciBlbmdpbmUKCkNoYW5nZS1JZDogSTg5ZGNkN2I2YzRkZTU1
OGY5YjI4NjAyMDlhMjczOWM3ZDRhZjI2MmQKU2lnbmVkLW9mZi1ieTogTW9uayBMaXUgPE1vbmsu
TGl1QGFtZC5jb20+Ci0tLQogZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3Jpbmcu
aCB8IDcgKysrKysrKwogMSBmaWxlIGNoYW5nZWQsIDcgaW5zZXJ0aW9ucygrKQoKZGlmZiAtLWdp
dCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9yaW5nLmggYi9kcml2ZXJzL2dw
dS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfcmluZy5oCmluZGV4IDBlNTdiMDQuLjNmZDRjZTggMTAw
NjQ0Ci0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9yaW5nLmgKKysrIGIv
ZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3JpbmcuaApAQCAtMTg2LDUgKzE4Niwx
MiBAQCBpbnQgYW1kZ3B1X3JpbmdfaW5pdChzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRldiwgc3Ry
dWN0IGFtZGdwdV9yaW5nICpyaW5nLAogCQkgICAgIHVuc2lnbmVkIHJpbmdfc2l6ZSwgc3RydWN0
IGFtZGdwdV9pcnFfc3JjICppcnFfc3JjLAogCQkgICAgIHVuc2lnbmVkIGlycV90eXBlKTsKIHZv
aWQgYW1kZ3B1X3JpbmdfZmluaShzdHJ1Y3QgYW1kZ3B1X3JpbmcgKnJpbmcpOworc3RhdGljIGlu
bGluZSB2b2lkIGFtZGdwdV9yaW5nX2NsZWFyX3Jpbmcoc3RydWN0IGFtZGdwdV9yaW5nICpyaW5n
KQoreworCWludCBpID0gMDsKKwl3aGlsZSAoaSA8PSByaW5nLT5wdHJfbWFzaykKKwkJcmluZy0+
cmluZ1tpKytdID0gcmluZy0+ZnVuY3MtPm5vcDsKKworfQogCiAjZW5kaWYKLS0gCjIuNy40Cgpf
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1h
aWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZy
ZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZngK
