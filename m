From: Hawking Zhang <Hawking.Zhang-5C7GfCeVMHo@public.gmane.org>
Subject: [PATCH 6/6] drm/amd/powerplay: set powerplay support cap on raven
Date: Wed, 24 May 2017 19:13:47 +0800
Message-ID: <1495624427-11450-6-git-send-email-Hawking.Zhang@amd.com>
References: <1495624427-11450-1-git-send-email-Hawking.Zhang@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <1495624427-11450-1-git-send-email-Hawking.Zhang-5C7GfCeVMHo@public.gmane.org>
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
Cc: Hawking Zhang <Hawking.Zhang-5C7GfCeVMHo@public.gmane.org>

Q2hhbmdlLUlkOiBJOWFhNWU3OGMxY2YxOWI5MDY5ZDM3MjE1YmZkMjUxNzk4MGJkZjJhNgpTaWdu
ZWQtb2ZmLWJ5OiBIYXdraW5nIFpoYW5nIDxIYXdraW5nLlpoYW5nQGFtZC5jb20+Ci0tLQogZHJp
dmVycy9ncHUvZHJtL2FtZC9wb3dlcnBsYXkvaHdtZ3IvcnZfaHdtZ3IuYyB8IDMgKysrCiAxIGZp
bGUgY2hhbmdlZCwgMyBpbnNlcnRpb25zKCspCgpkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJt
L2FtZC9wb3dlcnBsYXkvaHdtZ3IvcnZfaHdtZ3IuYyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvcG93
ZXJwbGF5L2h3bWdyL3J2X2h3bWdyLmMKaW5kZXggMDE0MTNjYTEuLjViMTMwZWYgMTAwNjQ0Ci0t
LSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvcG93ZXJwbGF5L2h3bWdyL3J2X2h3bWdyLmMKKysrIGIv
ZHJpdmVycy9ncHUvZHJtL2FtZC9wb3dlcnBsYXkvaHdtZ3IvcnZfaHdtZ3IuYwpAQCAtNTE1LDYg
KzUxNSw5IEBAIHN0YXRpYyBpbnQgcnZfaHdtZ3JfYmFja2VuZF9pbml0KHN0cnVjdCBwcF9od21n
ciAqaHdtZ3IpCiAJCXJldHVybiByZXN1bHQ7CiAJfQogCisJcGhtX2NhcF9zZXQoaHdtZ3ItPnBs
YXRmb3JtX2Rlc2NyaXB0b3IucGxhdGZvcm1DYXBzLAorICAgICAgICAgICAgICAgIFBITV9QbGF0
Zm9ybUNhcHNfUG93ZXJQbGF5U3VwcG9ydCk7CisKIAlydl9wb3B1bGF0ZV9jbG9ja190YWJsZSho
d21ncik7CiAKIAlyZXN1bHQgPSBydl9nZXRfc3lzdGVtX2luZm9fZGF0YShod21ncik7Ci0tIAoy
LjcuNAoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1k
LWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9s
aXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==
