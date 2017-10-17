From: Tom St Denis <tom.stdenis-5C7GfCeVMHo@public.gmane.org>
Subject: [PATCH] drm/amd/display: Trigger bug when allocation fails.
Date: Tue, 17 Oct 2017 13:45:54 -0400
Message-ID: <20171017174554.13930-1-tom.stdenis@amd.com>
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
Cc: Tom St Denis <tom.stdenis-5C7GfCeVMHo@public.gmane.org>

SWYgdGhlIGFsbG9jYXRpb24gZmFpbHMgaW4gYW1kZ3B1X2RtX2Nvbm5lY3Rvcl9mdW5jc19yZXNl
dCgpIHRoZQpBUEkgY2Fubm90IGNvbnRpbnVlIHNvIHRyaWdnZXIgYSBCVUdfT04uCgpTaWduZWQt
b2ZmLWJ5OiBUb20gU3QgRGVuaXMgPHRvbS5zdGRlbmlzQGFtZC5jb20+Ci0tLQogZHJpdmVycy9n
cHUvZHJtL2FtZC9kaXNwbGF5L2FtZGdwdV9kbS9hbWRncHVfZG0uYyB8IDEgKwogMSBmaWxlIGNo
YW5nZWQsIDEgaW5zZXJ0aW9uKCspCgpkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9k
aXNwbGF5L2FtZGdwdV9kbS9hbWRncHVfZG0uYyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxh
eS9hbWRncHVfZG0vYW1kZ3B1X2RtLmMKaW5kZXggNThlMjlhMmE1Y2E2Li5hYzU4YmE0ZjEwY2Yg
MTAwNjQ0Ci0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxheS9hbWRncHVfZG0vYW1kZ3B1
X2RtLmMKKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5L2FtZGdwdV9kbS9hbWRncHVf
ZG0uYwpAQCAtMjcyMiw2ICsyNzIyLDcgQEAgdm9pZCBhbWRncHVfZG1fY29ubmVjdG9yX2Z1bmNz
X3Jlc2V0KHN0cnVjdCBkcm1fY29ubmVjdG9yICpjb25uZWN0b3IpCiAJa2ZyZWUoc3RhdGUpOwog
CiAJc3RhdGUgPSBremFsbG9jKHNpemVvZigqc3RhdGUpLCBHRlBfS0VSTkVMKTsKKwlCVUdfT04o
c3RhdGUgPT0gTlVMTCk7CiAKIAlpZiAoc3RhdGUpIHsKIAkJc3RhdGUtPnNjYWxpbmcgPSBSTVhf
T0ZGOwotLSAKMi4xMi4wCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9y
ZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZngK
