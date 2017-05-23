From: Alex Deucher <alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH 2/4] drm/radeon/ci: disable mclk switching for high refresh
 rates (v2)
Date: Tue, 23 May 2017 17:26:35 -0400
Message-ID: <1495574797-11157-2-git-send-email-alexander.deucher@amd.com>
References: <1495574797-11157-1-git-send-email-alexander.deucher@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <1495574797-11157-1-git-send-email-alexander.deucher-5C7GfCeVMHo@public.gmane.org>
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

RXZlbiBpZiB0aGUgdmJsYW5rIHBlcmlvZCB3b3VsZCBhbGxvdyBpdCwgaXQgc3RpbGwgc2VlbXMg
dG8KYmUgcHJvYmxlbWF0aWMgb24gc29tZSBjYXJkcy4KCnYyOiBmaXggbG9naWMgaW52ZXJzaW9u
IChOaWxzKQoKYnVnOiBodHRwczovL2J1Z3MuZnJlZWRlc2t0b3Aub3JnL3Nob3dfYnVnLmNnaT9p
ZD05Njg2OAoKU2lnbmVkLW9mZi1ieTogQWxleCBEZXVjaGVyIDxhbGV4YW5kZXIuZGV1Y2hlckBh
bWQuY29tPgotLS0KIGRyaXZlcnMvZ3B1L2RybS9yYWRlb24vY2lfZHBtLmMgfCA2ICsrKysrKwog
MSBmaWxlIGNoYW5nZWQsIDYgaW5zZXJ0aW9ucygrKQoKZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1
L2RybS9yYWRlb24vY2lfZHBtLmMgYi9kcml2ZXJzL2dwdS9kcm0vcmFkZW9uL2NpX2RwbS5jCmlu
ZGV4IDdiYTQ1MDguLmVhMzZkYzQgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvZ3B1L2RybS9yYWRlb24v
Y2lfZHBtLmMKKysrIGIvZHJpdmVycy9ncHUvZHJtL3JhZGVvbi9jaV9kcG0uYwpAQCAtNzc2LDYg
Kzc3NiwxMiBAQCBib29sIGNpX2RwbV92YmxhbmtfdG9vX3Nob3J0KHN0cnVjdCByYWRlb25fZGV2
aWNlICpyZGV2KQogCXUzMiB2YmxhbmtfdGltZSA9IHI2MDBfZHBtX2dldF92YmxhbmtfdGltZShy
ZGV2KTsKIAl1MzIgc3dpdGNoX2xpbWl0ID0gcGktPm1lbV9nZGRyNSA/IDQ1MCA6IDMwMDsKIAor
CS8qIGRpc2FibGUgbWNsayBzd2l0Y2hpbmcgaWYgdGhlIHJlZnJlc2ggaXMgPjEyMEh6LCBldmVu
IGlmIHRoZQorICAgICAgICAqIGJsYW5raW5nIHBlcmlvZCB3b3VsZCBhbGxvdyBpdAorICAgICAg
ICAqLworCWlmIChyNjAwX2RwbV9nZXRfdnJlZnJlc2gocmRldikgPiAxMjApCisJCXJldHVybiB0
cnVlOworCiAJaWYgKHZibGFua190aW1lIDwgc3dpdGNoX2xpbWl0KQogCQlyZXR1cm4gdHJ1ZTsK
IAllbHNlCi0tIAoyLjUuNQoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5v
cmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4
Cg==
