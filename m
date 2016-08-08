From: Felix Kuehling <felix.kuehling-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH 09/14] drm/amd/amdgpu: Enable carrizo GFX PG
Date: Mon, 8 Aug 2016 13:57:11 -0400
Message-ID: <4d311362-aad3-13c2-1385-5d4a886d1b35@amd.com>
References: <20160728141912.18140-1-tom.stdenis@amd.com>
 <20160728141912.18140-10-tom.stdenis@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <20160728141912.18140-10-tom.stdenis-5C7GfCeVMHo@public.gmane.org>
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
To: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, "StDenis, Tom" <Tom.StDenis-5C7GfCeVMHo@public.gmane.org>

V2UncmUgcmV2ZXJ0aW5nIHRoaXMgY29tbWl0IG9uIHRoZSBLRkQgYnJhbmNoIGJlY2F1c2UgaXQn
cyBjYXVzaW5nIGhhbmdzCm9uIGEgYnVuY2ggb2YgSFNBIGNvbXB1dGUgdGVzdHMgb24gQ1ouCgpS
ZWdhcmRzLAogIEZlbGl4CgoKT24gMTYtMDctMjggMTA6MTkgQU0sIFRvbSBTdCBEZW5pcyB3cm90
ZToKPiBTaWduZWQtb2ZmLWJ5OiBUb20gU3QgRGVuaXMgPHRvbS5zdGRlbmlzQGFtZC5jb20+Cj4g
LS0tCj4gIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L3ZpLmMgfCA2ICsrKysrKwo+ICAxIGZp
bGUgY2hhbmdlZCwgNiBpbnNlcnRpb25zKCspCj4KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUv
ZHJtL2FtZC9hbWRncHUvdmkuYyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L3ZpLmMKPiBp
bmRleCA5YmE2NDk4OWYwOTIuLjRmYTlmZWE1NDFhNSAxMDA2NDQKPiAtLS0gYS9kcml2ZXJzL2dw
dS9kcm0vYW1kL2FtZGdwdS92aS5jCj4gKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUv
dmkuYwo+IEBAIC0xNTc4LDcgKzE1NzgsMTMgQEAgc3RhdGljIGludCB2aV9jb21tb25fZWFybHlf
aW5pdCh2b2lkICpoYW5kbGUpCj4gIAkJCUFNRF9DR19TVVBQT1JUX0hEUF9MUyB8Cj4gIAkJCUFN
RF9DR19TVVBQT1JUX1NETUFfTUdDRyB8Cj4gIAkJCUFNRF9DR19TVVBQT1JUX1NETUFfTFM7Cj4g
KwkJLyogcmV2MCBoYXJkd2FyZSByZXF1aXJlcyB3b3JrYXJvdW5kcyB0byBzdXBwb3J0IFBHICov
Cj4gIAkJYWRldi0+cGdfZmxhZ3MgPSAwOwo+ICsJCWlmIChhZGV2LT5yZXZfaWQgIT0gMHgwMCkg
ewo+ICsJCQlhZGV2LT5wZ19mbGFncyB8PSBBTURfUEdfU1VQUE9SVF9HRlhfUEcgfAo+ICsJCQkJ
QU1EX1BHX1NVUFBPUlRfR0ZYX1NNRyB8Cj4gKwkJCQlBTURfUEdfU1VQUE9SVF9HRlhfUElQRUxJ
TkU7Cj4gKwkJfQo+ICAJCWFkZXYtPmV4dGVybmFsX3Jldl9pZCA9IGFkZXYtPnJldl9pZCArIDB4
MTsKPiAgCQlicmVhazsKPiAgCWNhc2UgQ0hJUF9TVE9ORVk6CgpfX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4
QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWls
bWFuL2xpc3RpbmZvL2FtZC1nZngK
