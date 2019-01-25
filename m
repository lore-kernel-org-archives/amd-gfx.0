From: Huang Rui <ray.huang-5C7GfCeVMHo@public.gmane.org>
Subject: [PATCH 135/138] drm/amd/powerplay: implement sensor of uvd & vce
 power state for smu11
Date: Fri, 25 Jan 2019 18:25:42 +0800
Message-ID: <1548411945-12396-136-git-send-email-ray.huang@amd.com>
References: <1548411945-12396-1-git-send-email-ray.huang@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <1548411945-12396-1-git-send-email-ray.huang-5C7GfCeVMHo@public.gmane.org>
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
Cc: Likun Gao <Likun.Gao-5C7GfCeVMHo@public.gmane.org>, Kevin Wang <kevin1.wang-5C7GfCeVMHo@public.gmane.org>, Chengming Gui <Jack.Gui-5C7GfCeVMHo@public.gmane.org>

RnJvbTogS2V2aW4gV2FuZyA8a2V2aW4xLndhbmdAYW1kLmNvbT4KCmFkZCBmdW5jdGlvbnMgb2Yg
dXZkICYgdmNlIGZvciBod21vbi4KClNpZ25lZC1vZmYtYnk6IEtldmluIFdhbmcgPGtldmluMS53
YW5nQGFtZC5jb20+ClJldmlld2VkLWJ5OiBIdWFuZyBSdWkgPHJheS5odWFuZ0BhbWQuY29tPgot
LS0KIGRyaXZlcnMvZ3B1L2RybS9hbWQvcG93ZXJwbGF5L3NtdV92MTFfMC5jIHwgOCArKysrKysr
KwogMSBmaWxlIGNoYW5nZWQsIDggaW5zZXJ0aW9ucygrKQoKZGlmZiAtLWdpdCBhL2RyaXZlcnMv
Z3B1L2RybS9hbWQvcG93ZXJwbGF5L3NtdV92MTFfMC5jIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9w
b3dlcnBsYXkvc211X3YxMV8wLmMKaW5kZXggMzk1MjVhZC4uYjZiYTdmNSAxMDA2NDQKLS0tIGEv
ZHJpdmVycy9ncHUvZHJtL2FtZC9wb3dlcnBsYXkvc211X3YxMV8wLmMKKysrIGIvZHJpdmVycy9n
cHUvZHJtL2FtZC9wb3dlcnBsYXkvc211X3YxMV8wLmMKQEAgLTExMTYsNiArMTExNiwxNCBAQCBz
dGF0aWMgaW50IHNtdV92MTFfMF9yZWFkX3NlbnNvcihzdHJ1Y3Qgc211X2NvbnRleHQgKnNtdSwK
IAkJcmV0ID0gc211X3YxMV8wX2dldF9nZnhfdmRkKHNtdSwgKHVpbnQzMl90ICopZGF0YSk7CiAJ
CSpzaXplID0gNDsKIAkJYnJlYWs7CisJY2FzZSBBTURHUFVfUFBfU0VOU09SX1VWRF9QT1dFUjoK
KwkJKih1aW50MzJfdCAqKWRhdGEgPSBzbXVfZmVhdHVyZV9pc19lbmFibGVkKHNtdSwgRkVBVFVS
RV9EUE1fVVZEX0JJVCkgPyAxIDogMDsKKwkJKnNpemUgPSA0OworCQlicmVhazsKKwljYXNlIEFN
REdQVV9QUF9TRU5TT1JfVkNFX1BPV0VSOgorCQkqKHVpbnQzMl90ICopZGF0YSA9IHNtdV9mZWF0
dXJlX2lzX2VuYWJsZWQoc211LCBGRUFUVVJFX0RQTV9WQ0VfQklUKSA/IDEgOiAwOworCQkqc2l6
ZSA9IDQ7CisJCWJyZWFrOwogCWRlZmF1bHQ6CiAJCXJldCA9IHNtdV9jb21tb25fcmVhZF9zZW5z
b3Ioc211LCBzZW5zb3IsIGRhdGEsIHNpemUpOwogCQlicmVhazsKLS0gCjIuNy40CgpfX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcg
bGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNr
dG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZngK
