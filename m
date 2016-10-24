From: zhoucm1 <david1.zhou-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH] drm/amdgpu: fix a vm_flush fence leak
Date: Mon, 24 Oct 2016 10:32:42 +0800
Message-ID: <580D72CA.6040802@amd.com>
References: <1477247507-11378-3-git-send-email-notasas@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <1477247507-11378-3-git-send-email-notasas-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
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
To: Grazvydas Ignotas <notasas-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org

CgpPbiAyMDE25bm0MTDmnIgyNOaXpSAwMjozMSwgR3JhenZ5ZGFzIElnbm90YXMgd3JvdGU6Cj4g
TG9va3MgbGlrZSAubGFzdF9mbHVzaCByZWZlcmVuY2UgaXMgbGVmdCBhdCB0ZWFyZG93bi4KPiBM
ZWFrIHJlcG9ydGVkIGJ5IENPTkZJR19TTFVCX0RFQlVHLgo+Cj4gRml4ZXM6IDQxZDllYjJjNWEy
YSAoImRybS9hbWRncHU6IGFkZCBhIGZlbmNlIGFmdGVyIHRoZSBWTSBmbHVzaCIpCj4gU2lnbmVk
LW9mZi1ieTogR3JhenZ5ZGFzIElnbm90YXMgPG5vdGFzYXNAZ21haWwuY29tPgpSZXZpZXdlZC1i
eTogQ2h1bm1pbmcgWmhvdSA8ZGF2aWQxLnpob3VAYW1kLmNvbT4KPiAtLS0KPiAgIGRyaXZlcnMv
Z3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV92bS5jIHwgMSArCj4gICAxIGZpbGUgY2hhbmdlZCwg
MSBpbnNlcnRpb24oKykKPgo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdw
dS9hbWRncHVfdm0uYyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV92bS5jCj4g
aW5kZXggZGVkNTdkZC4uZDZjMjgzOSAxMDA2NDQKPiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1k
L2FtZGdwdS9hbWRncHVfdm0uYwo+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2Ft
ZGdwdV92bS5jCj4gQEAgLTE3NzQsNSArMTc3NCw2IEBAIHZvaWQgYW1kZ3B1X3ZtX21hbmFnZXJf
ZmluaShzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRldikKPiAgIAkJZmVuY2VfcHV0KGFkZXYtPnZt
X21hbmFnZXIuaWRzW2ldLmZpcnN0KTsKPiAgIAkJYW1kZ3B1X3N5bmNfZnJlZSgmYWRldi0+dm1f
bWFuYWdlci5pZHNbaV0uYWN0aXZlKTsKPiAgIAkJZmVuY2VfcHV0KGlkLT5mbHVzaGVkX3VwZGF0
ZXMpOwo+ICsJCWZlbmNlX3B1dChpZC0+bGFzdF9mbHVzaCk7Cj4gICAJfQo+ICAgfQoKX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5n
IGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVz
a3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==
