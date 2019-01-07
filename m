From: Evan Quan <evan.quan-5C7GfCeVMHo@public.gmane.org>
Subject: [PATCH 1/2] drm/amd/powerplay: update OD support flag for SKU with no
 OD capabilities
Date: Mon, 7 Jan 2019 20:05:55 +0800
Message-ID: <20190107120556.11710-1-evan.quan@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
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
Cc: Alexander.Deucher-5C7GfCeVMHo@public.gmane.org, Evan Quan <evan.quan-5C7GfCeVMHo@public.gmane.org>, Chris.Freehill-5C7GfCeVMHo@public.gmane.org

Rm9yIHRob3NlIEFTSUNzIHdpdGggbm8gb3ZlcmRyaXZlIGNhcGFiaWxpdGllcywgdGhlIE9EIHN1
cHBvcnQgZmxhZwp3aWxsIGJlIHJlc2V0LgoKQ2hhbmdlLUlkOiBJOGI3NWFkMjdlYzAwMzViODBk
ZTU1NTg0MGJhNDk2YmMyNzNmZWUwOApTaWduZWQtb2ZmLWJ5OiBFdmFuIFF1YW4gPGV2YW4ucXVh
bkBhbWQuY29tPgotLS0KIGRyaXZlcnMvZ3B1L2RybS9hbWQvcG93ZXJwbGF5L2h3bWdyL3ZlZ2Ey
MF9od21nci5jIHwgMyArKysKIDEgZmlsZSBjaGFuZ2VkLCAzIGluc2VydGlvbnMoKykKCmRpZmYg
LS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL3Bvd2VycGxheS9od21nci92ZWdhMjBfaHdtZ3Iu
YyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvcG93ZXJwbGF5L2h3bWdyL3ZlZ2EyMF9od21nci5jCmlu
ZGV4IDI1Yjg3NDJmNTFjNS4uZWEwOTM5YWQzMzE2IDEwMDY0NAotLS0gYS9kcml2ZXJzL2dwdS9k
cm0vYW1kL3Bvd2VycGxheS9od21nci92ZWdhMjBfaHdtZ3IuYworKysgYi9kcml2ZXJzL2dwdS9k
cm0vYW1kL3Bvd2VycGxheS9od21nci92ZWdhMjBfaHdtZ3IuYwpAQCAtOTgwLDYgKzk4MCw5IEBA
IHN0YXRpYyBpbnQgdmVnYTIwX29kOF9zZXRfZmVhdHVyZV9jYXBhYmlsaXRpZXMoCiAJICAgIHBw
X3RhYmxlLT5GYW5aZXJvUnBtRW5hYmxlKQogCQlvZF9zZXR0aW5ncy0+b3ZlcmRyaXZlOF9jYXBh
YmlsaXRpZXMgfD0gT0Q4X0ZBTl9aRVJPX1JQTV9DT05UUk9MOwogCisJaWYgKCFvZF9zZXR0aW5n
cy0+b3ZlcmRyaXZlOF9jYXBhYmlsaXRpZXMpCisJCWh3bWdyLT5vZF9lbmFibGVkID0gZmFsc2U7
CisKIAlyZXR1cm4gMDsKIH0KIAotLSAKMi4yMC4xCgpfX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3Rz
LmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xp
c3RpbmZvL2FtZC1nZngK
