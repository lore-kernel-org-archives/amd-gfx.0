From: Alex Deucher <alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH 258/459] drm/amd/powerplay: fix amdgpu_pm_info show gpu load
 error
Date: Mon, 17 Jun 2019 14:30:25 -0500
Message-ID: <20190617193106.18231-59-alexander.deucher@amd.com>
References: <20190617193106.18231-1-alexander.deucher@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <20190617193106.18231-1-alexander.deucher-5C7GfCeVMHo@public.gmane.org>
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
Cc: Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org>, Kevin Wang <kevin1.wang-5C7GfCeVMHo@public.gmane.org>, Kenneth Feng <kenneth.feng-5C7GfCeVMHo@public.gmane.org>

RnJvbTogS2V2aW4gV2FuZyA8a2V2aW4xLndhbmdAYW1kLmNvbT4KCmR1ZSB0byB0aGUgc211IGRt
YS9SVE9TIHJlc3RyaWN0aW9uLCB0aGUgaW50ZXJ2YWwgb2YgY2F0Y2hpbmcgc211Cm1ldHJpYyB0
YWJsZSBzaG91bGQgYmUgbW9yZSB0aGFuIDFtcy4gb3RoZXJ3aXNlIGl0IHdpbGwgY2F1c2UgdGhl
IGdwdQphY3Rpdml0eSBkYXRhIGNvcnJ1cHRpb24uCgpTaWduZWQtb2ZmLWJ5OktldmluIFdhbmcg
PGtldmluMS53YW5nQGFtZC5jb20+ClJldmlld2VkLWJ5OiBLZW5uZXRoIEZlbmcgPGtlbm5ldGgu
ZmVuZ0BhbWQuY29tPgpTaWduZWQtb2ZmLWJ5OiBBbGV4IERldWNoZXIgPGFsZXhhbmRlci5kZXVj
aGVyQGFtZC5jb20+Ci0tLQogZHJpdmVycy9ncHUvZHJtL2FtZC9wb3dlcnBsYXkvbmF2aTEwX3Bw
dC5jIHwgMiArKwogMSBmaWxlIGNoYW5nZWQsIDIgaW5zZXJ0aW9ucygrKQoKZGlmZiAtLWdpdCBh
L2RyaXZlcnMvZ3B1L2RybS9hbWQvcG93ZXJwbGF5L25hdmkxMF9wcHQuYyBiL2RyaXZlcnMvZ3B1
L2RybS9hbWQvcG93ZXJwbGF5L25hdmkxMF9wcHQuYwppbmRleCA0ODUxMjIyYzk5MTkuLjVmNjk3
ZWQzNzk2YiAxMDA2NDQKLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9wb3dlcnBsYXkvbmF2aTEw
X3BwdC5jCisrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvcG93ZXJwbGF5L25hdmkxMF9wcHQuYwpA
QCAtODE2LDYgKzgxNiw4IEBAIHN0YXRpYyBpbnQgbmF2aTEwX2dldF9jdXJyZW50X2FjdGl2aXR5
X3BlcmNlbnQoc3RydWN0IHNtdV9jb250ZXh0ICpzbXUsCiAJaWYgKCF2YWx1ZSkKIAkJcmV0dXJu
IC1FSU5WQUw7CiAKKwltc2xlZXAoMSk7CisKIAlyZXQgPSBzbXVfdXBkYXRlX3RhYmxlKHNtdSwg
U01VX1RBQkxFX1NNVV9NRVRSSUNTLAogCQkJICAgICAgICh2b2lkICopJm1ldHJpY3MsIGZhbHNl
KTsKIAlpZiAocmV0KQotLSAKMi4yMC4xCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVk
ZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZv
L2FtZC1nZng=
