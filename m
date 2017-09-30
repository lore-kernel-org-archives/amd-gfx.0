From: Monk Liu <Monk.Liu-5C7GfCeVMHo@public.gmane.org>
Subject: [PATCH 08/12] drm/amdgpu:explicitly call fence_process
Date: Sat, 30 Sep 2017 14:03:48 +0800
Message-ID: <1506751432-21789-9-git-send-email-Monk.Liu@amd.com>
References: <1506751432-21789-1-git-send-email-Monk.Liu@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <1506751432-21789-1-git-send-email-Monk.Liu-5C7GfCeVMHo@public.gmane.org>
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

dGhpcyB3YXkgbm8gbmVlZCB0byB3YWl0IHRpbWVyIHRyaWdnZXJlZCB0byBzYXZlIHRpbWUKCkNo
YW5nZS1JZDogSWU5NmZkMmZjMWY2MDU0ZWJjMWU1OGMzZDcwMzQ3MTYzOTM3MWVlMjIKU2lnbmVk
LW9mZi1ieTogTW9uayBMaXUgPE1vbmsuTGl1QGFtZC5jb20+Ci0tLQogZHJpdmVycy9ncHUvZHJt
L2FtZC9hbWRncHUvYW1kZ3B1X2ZlbmNlLmMgfCA3ICsrKysrKy0KIDEgZmlsZSBjaGFuZ2VkLCA2
IGluc2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkKCmRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9k
cm0vYW1kL2FtZGdwdS9hbWRncHVfZmVuY2UuYyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1
L2FtZGdwdV9mZW5jZS5jCmluZGV4IDMzM2JhZDcuLjEzNzg1ZDggMTAwNjQ0Ci0tLSBhL2RyaXZl
cnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9mZW5jZS5jCisrKyBiL2RyaXZlcnMvZ3B1L2Ry
bS9hbWQvYW1kZ3B1L2FtZGdwdV9mZW5jZS5jCkBAIC01NDMsOCArNTQzLDEzIEBAIHZvaWQgYW1k
Z3B1X2ZlbmNlX2RyaXZlcl9mb3JjZV9jb21wbGV0aW9uKHN0cnVjdCBhbWRncHVfZGV2aWNlICph
ZGV2KQogCiB2b2lkIGFtZGdwdV9mZW5jZV9kcml2ZXJfZm9yY2VfY29tcGxldGlvbl9yaW5nKHN0
cnVjdCBhbWRncHVfcmluZyAqcmluZykKIHsKLQlpZiAocmluZykKKwlpZiAocmluZykgewogCQlh
bWRncHVfZmVuY2Vfd3JpdGUocmluZywgcmluZy0+ZmVuY2VfZHJ2LnN5bmNfc2VxKTsKKwkJLyog
Y2FsbCBmZW5jZSBwcm9jZXNzIG1hbnVhbGx5IGNhbiBnZXQgaXQgZG9uZSBxdWlja2x5CisJCSAq
IGluc3RlYWQgb2Ygd2FpdGluZyBmb3IgdGhlIHRpbWVyIHRyaWdnZXJlZAorCQkgKi8KKwkJYW1k
Z3B1X2ZlbmNlX3Byb2Nlc3MocmluZyk7CisJfQogfQogCiAvKgotLSAKMi43LjQKCl9fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBs
aXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0
b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=
