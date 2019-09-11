From: "Huang, Ray" <Ray.Huang-5C7GfCeVMHo@public.gmane.org>
Subject: [PATCH 01/14] drm/amdgpu: add UAPI for creating encrypted buffers
Date: Wed, 11 Sep 2019 11:50:05 +0000
Message-ID: <1568202584-14471-2-git-send-email-ray.huang@amd.com>
References: <1568202584-14471-1-git-send-email-ray.huang@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <1568202584-14471-1-git-send-email-ray.huang-5C7GfCeVMHo@public.gmane.org>
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
To: "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, "dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, "Deucher, Alexander" <Alexander.Deucher-5C7GfCeVMHo@public.gmane.org>
Cc: "Tuikov, Luben" <Luben.Tuikov-5C7GfCeVMHo@public.gmane.org>, "Koenig,
 Christian" <Christian.Koenig-5C7GfCeVMHo@public.gmane.org>, "Liu, Aaron" <Aaron.Liu-5C7GfCeVMHo@public.gmane.org>

RnJvbTogQWxleCBEZXVjaGVyIDxhbGV4YW5kZXIuZGV1Y2hlckBhbWQuY29tPgoKQWRkIGEgZmxh
ZyB0byB0aGUgR0VNX0NSRUFURSBpb2N0bCB0byBjcmVhdGUgZW5jcnlwdGVkIGJ1ZmZlcnMuCkJ1
ZmZlcnMgd2l0aCB0aGlzIGZsYWcgc2V0IHdpbGwgYmUgY3JlYXRlZCB3aXRoIHRoZSBUTVogYml0
IHNldAppbiB0aGUgUFRFcyBvciBlbmdpbmVzIGFjY2Vzc2luZyB0aGVtLiAgVGhpcyBpcyByZXF1
aXJlZCBpbiBvcmRlcgp0byBwcm9wZXJseSBhY2Nlc3MgdGhlIGRhdGEgZnJvbSB0aGUgZW5naW5l
cy4KClNpZ25lZC1vZmYtYnk6IEFsZXggRGV1Y2hlciA8YWxleGFuZGVyLmRldWNoZXJAYW1kLmNv
bT4KUmV2aWV3ZWQtYnk6IEh1YW5nIFJ1aSA8cmF5Lmh1YW5nQGFtZC5jb20+Ci0tLQogaW5jbHVk
ZS91YXBpL2RybS9hbWRncHVfZHJtLmggfCA1ICsrKysrCiAxIGZpbGUgY2hhbmdlZCwgNSBpbnNl
cnRpb25zKCspCgpkaWZmIC0tZ2l0IGEvaW5jbHVkZS91YXBpL2RybS9hbWRncHVfZHJtLmggYi9p
bmNsdWRlL3VhcGkvZHJtL2FtZGdwdV9kcm0uaAppbmRleCBmM2FkNDI5Li5mOTBiNDUzIDEwMDY0
NAotLS0gYS9pbmNsdWRlL3VhcGkvZHJtL2FtZGdwdV9kcm0uaAorKysgYi9pbmNsdWRlL3VhcGkv
ZHJtL2FtZGdwdV9kcm0uaApAQCAtMTM1LDYgKzEzNSwxMSBAQCBleHRlcm4gIkMiIHsKICAqIHJl
bGVhc2luZyB0aGUgbWVtb3J5CiAgKi8KICNkZWZpbmUgQU1ER1BVX0dFTV9DUkVBVEVfVlJBTV9X
SVBFX09OX1JFTEVBU0UJKDEgPDwgOSkKKy8qIEZsYWcgdGhhdCBCTyB3aWxsIGJlIGVuY3J5cHRl
ZCBhbmQgdGhhdCB0aGUgVE1aIGJpdCBzaG91bGQgYmUKKyAqIHNldCBpbiB0aGUgUFRFcyB3aGVu
IG1hcHBpbmcgdGhpcyBidWZmZXIgdmlhIEdQVVZNIG9yCisgKiBhY2Nlc3NpbmcgaXQgd2l0aCB2
YXJpb3VzIGh3IGJsb2NrcworICovCisjZGVmaW5lIEFNREdQVV9HRU1fQ1JFQVRFX0VOQ1JZUFRF
RAkJKDEgPDwgMTApCiAKIHN0cnVjdCBkcm1fYW1kZ3B1X2dlbV9jcmVhdGVfaW4gIHsKIAkvKiog
dGhlIHJlcXVlc3RlZCBtZW1vcnkgc2l6ZSAqLwotLSAKMi43LjQKCl9fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1n
ZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21h
aWxtYW4vbGlzdGluZm8vYW1kLWdmeA==
