From: Evan Quan <evan.quan-5C7GfCeVMHo@public.gmane.org>
Subject: [PATCH 4/4] drm/amd/powerplay: set pp_num_states as 0 on error
 situation
Date: Fri, 29 Dec 2017 15:44:39 +0800
Message-ID: <1514533479-14038-4-git-send-email-evan.quan@amd.com>
References: <1514533479-14038-1-git-send-email-evan.quan@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <1514533479-14038-1-git-send-email-evan.quan-5C7GfCeVMHo@public.gmane.org>
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
Cc: Evan Quan <evan.quan-5C7GfCeVMHo@public.gmane.org>

Q2hhbmdlLUlkOiBJYTI3YWY4MTI2MzE2NjZkMmM5ZDU0ZGExNTZmZDM0NTFiZDczOGQ0YgpTaWdu
ZWQtb2ZmLWJ5OiBFdmFuIFF1YW4gPGV2YW4ucXVhbkBhbWQuY29tPgotLS0KIGRyaXZlcnMvZ3B1
L2RybS9hbWQvcG93ZXJwbGF5L2FtZF9wb3dlcnBsYXkuYyB8IDIgKysKIDEgZmlsZSBjaGFuZ2Vk
LCAyIGluc2VydGlvbnMoKykKCmRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL3Bvd2Vy
cGxheS9hbWRfcG93ZXJwbGF5LmMgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL3Bvd2VycGxheS9hbWRf
cG93ZXJwbGF5LmMKaW5kZXggZjM4ODhkZC4uNjg0ODI4YSAxMDA2NDQKLS0tIGEvZHJpdmVycy9n
cHUvZHJtL2FtZC9wb3dlcnBsYXkvYW1kX3Bvd2VycGxheS5jCisrKyBiL2RyaXZlcnMvZ3B1L2Ry
bS9hbWQvcG93ZXJwbGF5L2FtZF9wb3dlcnBsYXkuYwpAQCAtNzI2LDYgKzcyNiw4IEBAIHN0YXRp
YyBpbnQgcHBfZHBtX2dldF9wcF9udW1fc3RhdGVzKHZvaWQgKmhhbmRsZSwKIAlzdHJ1Y3QgcHBf
aW5zdGFuY2UgKnBwX2hhbmRsZSA9IChzdHJ1Y3QgcHBfaW5zdGFuY2UgKiloYW5kbGU7CiAJaW50
IHJldCA9IDA7CiAKKwltZW1zZXQoZGF0YSwgMCwgc2l6ZW9mKCpkYXRhKSk7CisKIAlyZXQgPSBw
cF9jaGVjayhwcF9oYW5kbGUpOwogCiAJaWYgKHJldCkKLS0gCjIuNy40CgpfX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAph
bWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9y
Zy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZngK
