From: "Zhang, Jerry (Junwei)" <Jerry.Zhang-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH 0/3] Fixes for multi-level page tables
Date: Wed, 29 Mar 2017 14:00:19 +0800
Message-ID: <58DB4D73.5000408@amd.com>
References: <1490749231-16157-1-git-send-email-Felix.Kuehling@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <1490749231-16157-1-git-send-email-Felix.Kuehling-5C7GfCeVMHo@public.gmane.org>
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
To: Felix Kuehling <Felix.Kuehling-5C7GfCeVMHo@public.gmane.org>, amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, Christian.Koenig-5C7GfCeVMHo@public.gmane.org, David1.Zhou-5C7GfCeVMHo@public.gmane.org
Cc: Alexander.Deucher-5C7GfCeVMHo@public.gmane.org, Kent.Russell-5C7GfCeVMHo@public.gmane.org

T24gMDMvMjkvMjAxNyAwOTowMCBBTSwgRmVsaXggS3VlaGxpbmcgd3JvdGU6Cj4gSSB3b3JrZWQg
b24gdGhlc2UgZml4ZXMgb24gYW1kLWtmZC1zdGFnaW5nIHdpdGggYSBtZXJnZSBvZiB0aGUgcmVj
ZW50IG11bHRpLQo+IGxldmVsIHBhZ2UgdGFibGUgY2hhbmdlcy4gV2l0aCB0aGVzZSBjaGFuZ2Vz
IEtGRFRlc3QgcGFzc2VzIG9uIFZlZ2ExMCwKPiBpbmNsdWRpbmcgc29tZSB0ZXN0cyB0aGF0IHRl
bmQgdG8gc3RyZXNzIFZNIG1lbW9yeSBtYW5hZ2VtZW50Lgo+Cj4gVGhleSBhcHBsaWVkIGNsZWFu
bHkgdG8gY3VycmVudCBhbWQtc3RhZ2luZy00LjkgYnV0IGFyZSBvbmx5IGNvbXBpbGUtdGVzdGVk
Cj4gb24gdGhhdCBicmFuY2guCgpQYXRjaCAxIGFuZCAzClJldmlld2VkLWJ5OiBKdW53ZWkgWmhh
bmcgPEplcnJ5LlpoYW5nQGFtZC5jb20+CgpTb3JyeSBJIGRpZG4ndCBnb3QgdGhlIHBhdGNoIDIg
aW4gbWFpbGJveC4KQW0gSSBtaXNzaW5nIGFueXRoaW5nPwoKPgo+IEZlbGl4IEt1ZWhsaW5nICgz
KToKPiAgICBkcm0vYW1kZ3B1OiBNYWtlIG1heF9wZm4gNjQtYml0Cj4gICAgZHJtL2FtZGdwdTog
Rml4IFZlZ2ExMCBWTSBpbml0aWFsaXphdGlvbgo+ICAgIGRybS9hbWRncHU6IEZpeCBtdWx0aS1s
ZXZlbCBwYWdlIHRhYmxlIGJ1Z3MgZm9yIGxhcmdlIEJPcwo+Cj4gICBkcml2ZXJzL2dwdS9kcm0v
YW1kL2FtZGdwdS9hbWRncHVfZGV2aWNlLmMgfCAgNiArKystLS0KPiAgIGRyaXZlcnMvZ3B1L2Ry
bS9hbWQvYW1kZ3B1L2FtZGdwdV92bS5jICAgICB8IDE3ICsrKysrKysrKysrKy0tLS0tCj4gICBk
cml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfdm0uaCAgICAgfCAgMiArLQo+ICAgZHJp
dmVycy9ncHUvZHJtL2FtZC9hbWRncHUvZ2Z4aHViX3YxXzAuYyAgIHwgIDUgKysrLS0KPiAgIGRy
aXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2dtY192OV8wLmMgICAgICB8IDE3ICsrKysrKystLS0t
LS0tLS0tCj4gICBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9tbWh1Yl92MV8wLmMgICAgfCAg
NSArKystLQo+ICAgNiBmaWxlcyBjaGFuZ2VkLCAyOSBpbnNlcnRpb25zKCspLCAyMyBkZWxldGlv
bnMoLSkKPgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwph
bWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczov
L2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZngK
