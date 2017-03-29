From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH 2/2] drm/amdgpu: set vm size as 256TB for Vega10
Date: Wed, 29 Mar 2017 10:47:27 +0200
Message-ID: <0b86e484-9d24-039d-ec26-ed973b0a7f14@amd.com>
References: <1490774912-583-1-git-send-email-Jerry.Zhang@amd.com>
 <1490774912-583-2-git-send-email-Jerry.Zhang@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <1490774912-583-2-git-send-email-Jerry.Zhang-5C7GfCeVMHo@public.gmane.org>
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
To: Junwei Zhang <Jerry.Zhang-5C7GfCeVMHo@public.gmane.org>, amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org

QW0gMjkuMDMuMjAxNyB1bSAxMDowOCBzY2hyaWViIEp1bndlaSBaaGFuZzoKPiBTaWduZWQtb2Zm
LWJ5OiBKdW53ZWkgWmhhbmcgPEplcnJ5LlpoYW5nQGFtZC5jb20+Cj4gLS0tCj4gICBkcml2ZXJz
L2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfZGV2aWNlLmMgfCA1ICsrKysrCj4gICAxIGZpbGUg
Y2hhbmdlZCwgNSBpbnNlcnRpb25zKCspCj4KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJt
L2FtZC9hbWRncHUvYW1kZ3B1X2RldmljZS5jIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUv
YW1kZ3B1X2RldmljZS5jCj4gaW5kZXggMWFkMTExMy4uNGFmNGVhMCAxMDA2NDQKPiAtLS0gYS9k
cml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfZGV2aWNlLmMKPiArKysgYi9kcml2ZXJz
L2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfZGV2aWNlLmMKPiBAQCAtMTA4MCw2ICsxMDgwLDEx
IEBAIHN0YXRpYyB2b2lkIGFtZGdwdV9nZXRfYmxvY2tfc2l6ZShzdHJ1Y3QgYW1kZ3B1X2Rldmlj
ZSAqYWRldikKPiAgIAo+ICAgc3RhdGljIHZvaWQgYW1kZ3B1X2NoZWNrX3ZtX3NpemUoc3RydWN0
IGFtZGdwdV9kZXZpY2UgKmFkZXYpCj4gICB7Cj4gKwlpZiAoYWRldi0+YXNpY190eXBlID49IENI
SVBfVkVHQTEwKSB7Cj4gKwkJYW1kZ3B1X3ZtX3NpemUgPSAxVSA8PCAxODsgLyogMjU2VEIgKi8K
PiArCQlyZXR1cm47Cj4gKwl9Cj4gKwoKTkFLLCB0aGF0IHdvdWxkIGJyZWFrIGluIGEgbWl4ZWQg
ZW52aXJvbm1lbnQgd2l0aCBBUFUrVmVnYTEwLgoKSW5zdGVhZCBqdXN0IGdvIGludG8gZ21jX3Y5
XzBfc3dfaW5pdCgpIGFuZCBzZXQgbWF4X3BmbiA9IDFVTEwgPDwgMzYgYW5kIAphZGQgYSBjb21t
ZW50IHRoZXJlIHdoeSB3ZSBoYXJkY29kZSB0aGlzIHZhbHVlIGZvciBWZWdhMTAgYW5kIGxhdGVy
LgoKQ2hyaXN0aWFuLgoKPiAgIAlpZiAoIWFtZGdwdV9jaGVja19wb3RfYXJndW1lbnQoYW1kZ3B1
X3ZtX3NpemUpKSB7Cj4gICAJCWRldl93YXJuKGFkZXYtPmRldiwgIlZNIHNpemUgKCVkKSBtdXN0
IGJlIGEgcG93ZXIgb2YgMlxuIiwKPiAgIAkJCSBhbWRncHVfdm1fc2l6ZSk7CgoKX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxp
c3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3Rv
cC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==
