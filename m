From: "Zhu, Changfeng" <Changfeng.Zhu-5C7GfCeVMHo@public.gmane.org>
Subject: [PATCH 2/2] drm/amdgpu: add warning for GRBM 1-cycle delay issue in
 gfx9
Date: Tue, 5 Nov 2019 11:42:41 +0000
Message-ID: <20191105114219.4797-1-changfeng.zhu@amd.com>
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
To: "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, "Tuikov,
 Luben" <Luben.Tuikov-5C7GfCeVMHo@public.gmane.org>, "Koenig, Christian" <Christian.Koenig-5C7GfCeVMHo@public.gmane.org>, "Huang, Ray" <Ray.Huang-5C7GfCeVMHo@public.gmane.org>, "Huang,
 Shimmer" <Xinmei.Huang-5C7GfCeVMHo@public.gmane.org>
Cc: "Zhu, Changfeng" <Changfeng.Zhu-5C7GfCeVMHo@public.gmane.org>

RnJvbTogY2hhbmd6aHUgPENoYW5nZmVuZy5aaHVAYW1kLmNvbT4KCkl0IG5lZWRzIHRvIGFkZCB3
YXJuaW5nIHRvIHVwZGF0ZSBmaXJtd2FyZSBpbiBnZng5CmluIGNhc2UgdGhhdCBmaXJtd2FyZSBp
cyB0b28gb2xkIHRvIGhhdmUgZnVuY3Rpb24gdG8KcmVhbGl6ZSBkdW1teSByZWFkIGluIGNwIGZp
cm13YXJlLgoKQ2hhbmdlLUlkOiBJNmFlZjk0ZjA4MjMxMzhmMjQ0ZjFlZWRiNjJmZGU4MzNkZDY5
NzAyMwpTaWduZWQtb2ZmLWJ5OiBjaGFuZ3podSA8Q2hhbmdmZW5nLlpodUBhbWQuY29tPgotLS0K
IGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2dmeF92OV8wLmMgfCA3ICsrKysrKysKIDEgZmls
ZSBjaGFuZ2VkLCA3IGluc2VydGlvbnMoKykKCmRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0v
YW1kL2FtZGdwdS9nZnhfdjlfMC5jIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvZ2Z4X3Y5
XzAuYwppbmRleCA5ZDVmOTAwZTNlMWMuLmYyZGViMjI1YzhhOSAxMDA2NDQKLS0tIGEvZHJpdmVy
cy9ncHUvZHJtL2FtZC9hbWRncHUvZ2Z4X3Y5XzAuYworKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1k
L2FtZGdwdS9nZnhfdjlfMC5jCkBAIC05ODIsNiArOTgyLDEzIEBAIHN0YXRpYyB2b2lkIGdmeF92
OV8wX2NoZWNrX2Z3X3dyaXRlX3dhaXQoc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYpCiAJYWRl
di0+Z2Z4Lm1lX2Z3X3dyaXRlX3dhaXQgPSBmYWxzZTsKIAlhZGV2LT5nZngubWVjX2Z3X3dyaXRl
X3dhaXQgPSBmYWxzZTsKIAorCWlmICgoYWRldi0+Z2Z4Lm1lY19md192ZXJzaW9uIDwgMHgwMDAw
MDFhNSkgfHwKKwkgICAgKGFkZXYtPmdmeC5tZWNfZmVhdHVyZV92ZXJzaW9uIDwgNDYpIHx8CisJ
ICAgIChhZGV2LT5nZngucGZwX2Z3X3ZlcnNpb24gPCAweDAwMDAwMGI3KSB8fAorCSAgICAoYWRl
di0+Z2Z4LnBmcF9mZWF0dXJlX3ZlcnNpb24gPCA0NikpCisJCURSTV9XQVJOX09OQ0UoIldhcm5p
bmc6IGNoZWNrIGNwX2Z3X3ZlcnNpb24gYW5kIHVwZGF0ZSBpdCB0byByZWFsaXplIFwKKwkJCQkJ
CUdSQk0gcmVxdWlyZXMgMS1jeWNsZSBkZWxheSBpbiBjcCBmaXJtd2FyZVxuIik7CisKIAlzd2l0
Y2ggKGFkZXYtPmFzaWNfdHlwZSkgewogCWNhc2UgQ0hJUF9WRUdBMTA6CiAJCWlmICgoYWRldi0+
Z2Z4Lm1lX2Z3X3ZlcnNpb24gPj0gMHgwMDAwMDA5YykgJiYKLS0gCjIuMTcuMQoKX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxp
c3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3Rv
cC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4
