From: <jianzh-5C7GfCeVMHo@public.gmane.org>
Subject: [PATCH] drm/amdgpu/SRIOV: SRIOV VF doesn't support BACO
Date: Mon, 28 Oct 2019 10:14:55 +0000
Message-ID: <20191028101432.16464-1-jianzh@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
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
Cc: "Deng, Emily" <Emily.Deng-5C7GfCeVMHo@public.gmane.org>, "Zhao, Jiange" <Jiange.Zhao-5C7GfCeVMHo@public.gmane.org>, "Nieto, David M" <David.Nieto-5C7GfCeVMHo@public.gmane.org>

RnJvbTogSmlhbmdlIFpoYW8gPEppYW5nZS5aaGFvQGFtZC5jb20+CgpTUklPViBWRiBkb2Vzbid0
IHN1cHBvcnQgQkFDTy4KCk9ubHkgUEYgd2l0aCBCQUNPIGNhcGFiaWxpdHkgY2FuIGRvIGl0LgoK
U2lnbmVkLW9mZi1ieTogSmlhbmdlIFpoYW8gPEppYW5nZS5aaGFvQGFtZC5jb20+Ci0tLQogZHJp
dmVycy9ncHUvZHJtL2FtZC9hbWRncHUvbnYuYyB8IDIgKy0KIDEgZmlsZSBjaGFuZ2VkLCAxIGlu
c2VydGlvbigrKSwgMSBkZWxldGlvbigtKQoKZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9h
bWQvYW1kZ3B1L252LmMgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9udi5jCmluZGV4IDIy
YWIxOTU1YjkyMy4uYTU1YTJlODNmYjE5IDEwMDY0NAotLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1k
L2FtZGdwdS9udi5jCisrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L252LmMKQEAgLTI5
OSw3ICsyOTksNyBAQCBudl9hc2ljX3Jlc2V0X21ldGhvZChzdHJ1Y3QgYW1kZ3B1X2RldmljZSAq
YWRldikKIHsKIAlzdHJ1Y3Qgc211X2NvbnRleHQgKnNtdSA9ICZhZGV2LT5zbXU7CiAKLQlpZiAo
c211X2JhY29faXNfc3VwcG9ydChzbXUpKQorCWlmICghYW1kZ3B1X3NyaW92X3ZmKGFkZXYpICYm
IHNtdV9iYWNvX2lzX3N1cHBvcnQoc211KSkKIAkJcmV0dXJuIEFNRF9SRVNFVF9NRVRIT0RfQkFD
TzsKIAllbHNlCiAJCXJldHVybiBBTURfUkVTRVRfTUVUSE9EX01PREUxOwotLSAKMi4yMC4xCgpf
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1h
aWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZy
ZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZng=
