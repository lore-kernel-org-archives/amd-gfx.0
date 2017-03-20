From: Alex Deucher <alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH 032/100] drm/amdgpu: update IH IV ring entry for soc-15
Date: Mon, 20 Mar 2017 16:29:27 -0400
Message-ID: <1490041835-11255-18-git-send-email-alexander.deucher@amd.com>
References: <1490041835-11255-1-git-send-email-alexander.deucher@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <1490041835-11255-1-git-send-email-alexander.deucher-5C7GfCeVMHo@public.gmane.org>
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
Cc: Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org>

UmVmbGVjdCB0aGUgbmV3IGZvcm1hdCBvbiBzb2MtMTUgYXNpY3MuCgpTaWduZWQtb2ZmLWJ5OiBB
bGV4IERldWNoZXIgPGFsZXhhbmRlci5kZXVjaGVyQGFtZC5jb20+Ci0tLQogZHJpdmVycy9ncHUv
ZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2loLmggfCA1ICsrKystCiAxIGZpbGUgY2hhbmdlZCwgNCBp
bnNlcnRpb25zKCspLCAxIGRlbGV0aW9uKC0pCgpkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJt
L2FtZC9hbWRncHUvYW1kZ3B1X2loLmggYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRn
cHVfaWguaAppbmRleCAwNDM2MjBkLi5hM2RhMWExIDEwMDY0NAotLS0gYS9kcml2ZXJzL2dwdS9k
cm0vYW1kL2FtZGdwdS9hbWRncHVfaWguaAorKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdw
dS9hbWRncHVfaWguaApAQCAtOTMsMTEgKzkzLDE0IEBAIHN0cnVjdCBhbWRncHVfaWhfcmluZyB7
CiBzdHJ1Y3QgYW1kZ3B1X2l2X2VudHJ5IHsKIAl1bnNpZ25lZCBjbGllbnRfaWQ7CiAJdW5zaWdu
ZWQgc3JjX2lkOwotCXVuc2lnbmVkIHNyY19kYXRhW0FNREdQVV9JSF9TUkNfREFUQV9NQVhfU0la
RV9EV107CiAJdW5zaWduZWQgcmluZ19pZDsKIAl1bnNpZ25lZCB2bV9pZDsKIAl1bnNpZ25lZCB2
bV9pZF9zcmM7CisJdWludDY0X3QgdGltZXN0YW1wOworCXVuc2lnbmVkIHRpbWVzdGFtcF9zcmM7
CiAJdW5zaWduZWQgcGFzX2lkOworCXVuc2lnbmVkIHBhc2lkX3NyYzsKKwl1bnNpZ25lZCBzcmNf
ZGF0YVtBTURHUFVfSUhfU1JDX0RBVEFfTUFYX1NJWkVfRFddOwogCWNvbnN0IHVpbnQzMl90ICpp
dl9lbnRyeTsKIH07CiAKLS0gCjIuNS41CgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVk
ZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZv
L2FtZC1nZngK
