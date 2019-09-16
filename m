From: <jianzh-5C7GfCeVMHo@public.gmane.org>
Subject: [PATCH] drm/amdgpu/SRIOV: Navi12 SRIOV VF gets GTT base
Date: Mon, 16 Sep 2019 07:01:36 +0000
Message-ID: <20190916070114.9250-1-jianzh@amd.com>
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
Cc: "Deng, Emily" <Emily.Deng-5C7GfCeVMHo@public.gmane.org>, "Zhao,
 Jiange" <Jiange.Zhao-5C7GfCeVMHo@public.gmane.org>, "Koenig, Christian" <Christian.Koenig-5C7GfCeVMHo@public.gmane.org>, "Nieto, David M" <David.Nieto-5C7GfCeVMHo@public.gmane.org>

RnJvbTogSmlhbmdlIFpoYW8gPEppYW5nZS5aaGFvQGFtZC5jb20+CgpXaXRoIGNoYW5nZXMgaW4g
UFNQIGFuZCBIViwgU1JJT1YgVkYgd2lsbCBoYW5kbGUKCnZyYW0gZ3R0IGxvY2F0aW9uIGp1c3Qg
bGlrZSBiYXJlIG1ldGFsLiBUaGVyZSBpcwoKbm8gbmVlZCB0byBkaWZmZXJlbnRpYXRlIGl0IGFu
eW1vcmUuCgpTaWduZWQtb2ZmLWJ5OiBKaWFuZ2UgWmhhbyA8SmlhbmdlLlpoYW9AYW1kLmNvbT4K
LS0tCiBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9nbWNfdjEwXzAuYyB8IDMgKy0tCiAxIGZp
bGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKyksIDIgZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEv
ZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvZ21jX3YxMF8wLmMgYi9kcml2ZXJzL2dwdS9kcm0v
YW1kL2FtZGdwdS9nbWNfdjEwXzAuYwppbmRleCAxYThkOGY1MjhiMDEuLmVkMWMzYjg4M2Y2YSAx
MDA2NDQKLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvZ21jX3YxMF8wLmMKKysrIGIv
ZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvZ21jX3YxMF8wLmMKQEAgLTUxOSw4ICs1MTksNyBA
QCBzdGF0aWMgdm9pZCBnbWNfdjEwXzBfdnJhbV9ndHRfbG9jYXRpb24oc3RydWN0IGFtZGdwdV9k
ZXZpY2UgKmFkZXYsCiB7CiAJdTY0IGJhc2UgPSAwOwogCi0JaWYgKCFhbWRncHVfc3Jpb3ZfdmYo
YWRldikpCi0JCWJhc2UgPSBnZnhodWJfdjJfMF9nZXRfZmJfbG9jYXRpb24oYWRldik7CisJYmFz
ZSA9IGdmeGh1Yl92Ml8wX2dldF9mYl9sb2NhdGlvbihhZGV2KTsKIAogCWFtZGdwdV9nbWNfdnJh
bV9sb2NhdGlvbihhZGV2LCAmYWRldi0+Z21jLCBiYXNlKTsKIAlhbWRncHVfZ21jX2dhcnRfbG9j
YXRpb24oYWRldiwgbWMpOwotLSAKMi4yMC4xCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZy
ZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3Rp
bmZvL2FtZC1nZng=
