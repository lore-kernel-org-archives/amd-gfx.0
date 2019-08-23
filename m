From: "Kuehling, Felix" <Felix.Kuehling-5C7GfCeVMHo@public.gmane.org>
Subject: [PATCH 3/4] drm/amdgpu: Support snooped PTE flag
Date: Fri, 23 Aug 2019 21:33:47 +0000
Message-ID: <20190823213249.10749-4-Felix.Kuehling@amd.com>
References: <20190823213249.10749-1-Felix.Kuehling@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <20190823213249.10749-1-Felix.Kuehling-5C7GfCeVMHo@public.gmane.org>
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
To: "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
Cc: "Zeng, Oak" <Oak.Zeng-5C7GfCeVMHo@public.gmane.org>, "Koenig,
 Christian" <Christian.Koenig-5C7GfCeVMHo@public.gmane.org>

RnJvbTogT2FrIFplbmcgPE9hay5aZW5nQGFtZC5jb20+CgpTZXQgc25vb3BlZCBQVEUgZmxhZyBh
Y2NvcmRpbmcgdG8gbWFwcGluZyBmbGFnLiBXcml0ZSByZXF1ZXN0IHRvIGEKcGFnZSB3aXRoIHNu
b29wZWQgYml0IHNldCwgd2lsbCBzZW5kIG91dCBpbnZhbGlkYXRlIHByb2JlIHJlcXVlc3QKdG8g
VENDIG9mIHRoZSByZW1vdGUgR1BVIHdoZXJlIHRoZSB2cmFtIHBhZ2UgcmVzaWRlcy4KCkNoYW5n
ZS1JZDogSTc5OWY2OGVjN2E1YTFhYmYzMjA3NWY1ZWYzMTA1MTY0MWEwYjM3MzYKU2lnbmVkLW9m
Zi1ieTogT2FrIFplbmcgPE9hay5aZW5nQGFtZC5jb20+Ci0tLQogZHJpdmVycy9ncHUvZHJtL2Ft
ZC9hbWRncHUvZ21jX3Y5XzAuYyB8IDMgKysrCiAxIGZpbGUgY2hhbmdlZCwgMyBpbnNlcnRpb25z
KCspCgpkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvZ21jX3Y5XzAuYyBi
L2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2dtY192OV8wLmMKaW5kZXggOWFhZmNkYTZjNDg4
Li44YTdjNGVjNjlhZTggMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2dt
Y192OV8wLmMKKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvZ21jX3Y5XzAuYwpAQCAt
NjA0LDYgKzYwNCw5IEBAIHN0YXRpYyB1aW50NjRfdCBnbWNfdjlfMF9nZXRfdm1fcHRlX2ZsYWdz
KHN0cnVjdCBhbWRncHVfZGV2aWNlICphZGV2LAogCWlmIChmbGFncyAmIEFNREdQVV9WTV9QQUdF
X1BSVCkKIAkJcHRlX2ZsYWcgfD0gQU1ER1BVX1BURV9QUlQ7CiAKKwlpZiAoZmxhZ3MgJiBBTURH
UFVfVk1fUEFHRV9JTlZBTElEQVRFX1BST0JFKQorCQlwdGVfZmxhZyB8PSBBTURHUFVfUFRFX1NO
T09QRUQ7CisKIAlyZXR1cm4gcHRlX2ZsYWc7CiB9CiAKLS0gCjIuMTcuMQoKX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QK
YW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5v
cmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4
