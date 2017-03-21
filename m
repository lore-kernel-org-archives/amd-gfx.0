From: Alex Deucher <alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH] drm/amdgpu: remove the clearance of vce 4.0 interrupt mask
Date: Tue, 21 Mar 2017 09:51:13 -0400
Message-ID: <1490104273-335-4-git-send-email-alexander.deucher@amd.com>
References: <1490104273-335-1-git-send-email-alexander.deucher@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <1490104273-335-1-git-send-email-alexander.deucher-5C7GfCeVMHo@public.gmane.org>
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
Cc: Leo Liu <leo.liu-5C7GfCeVMHo@public.gmane.org>

RnJvbTogTGVvIExpdSA8bGVvLmxpdUBhbWQuY29tPgoKUmVxdWVzdGVkIGJ5IFNSSU9WLCB0aGUg
Y2xlYXJhbmNlIG9mIHRoZSBiaXQgbW92ZWQgaW50byBmaXJtd2FyZQoKU2lnbmVkLW9mZi1ieTog
TGVvIExpdSA8bGVvLmxpdUBhbWQuY29tPgpBY2tlZC1ieTogQWxleCBEZXVjaGVyIDxhbGV4YW5k
ZXIuZGV1Y2hlckBhbWQuY29tPgotLS0KIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L3ZjZV92
NF8wLmMgfCA0IC0tLS0KIDEgZmlsZSBjaGFuZ2VkLCA0IGRlbGV0aW9ucygtKQoKZGlmZiAtLWdp
dCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L3ZjZV92NF8wLmMgYi9kcml2ZXJzL2dwdS9k
cm0vYW1kL2FtZGdwdS92Y2VfdjRfMC5jCmluZGV4IDE1MzIxNDk1Li5mMTJjNzUzIDEwMDY0NAot
LS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS92Y2VfdjRfMC5jCisrKyBiL2RyaXZlcnMv
Z3B1L2RybS9hbWQvYW1kZ3B1L3ZjZV92NF8wLmMKQEAgLTEwNDYsMTAgKzEwNDYsNiBAQCBzdGF0
aWMgaW50IHZjZV92NF8wX3Byb2Nlc3NfaW50ZXJydXB0KHN0cnVjdCBhbWRncHVfZGV2aWNlICph
ZGV2LAogewogCURSTV9ERUJVRygiSUg6IFZDRVxuIik7CiAKLQlXUkVHMzJfUChTT0MxNV9SRUdf
T0ZGU0VUKFZDRSwgMCwgbW1WQ0VfU1lTX0lOVF9TVEFUVVMpLAotCQkJVkNFX1NZU19JTlRfU1RB
VFVTX19WQ0VfU1lTX0lOVF9UUkFQX0lOVEVSUlVQVF9JTlRfTUFTSywKLQkJCX5WQ0VfU1lTX0lO
VF9TVEFUVVNfX1ZDRV9TWVNfSU5UX1RSQVBfSU5URVJSVVBUX0lOVF9NQVNLKTsKLQogCXN3aXRj
aCAoZW50cnktPnNyY19kYXRhWzBdKSB7CiAJY2FzZSAwOgogCWNhc2UgMToKLS0gCjIuNS41Cgpf
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1h
aWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZy
ZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZngK
