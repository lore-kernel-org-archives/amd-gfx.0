From: zhoucm1 <david1.zhou-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH 1/2] drm/amdgpu: fix re-program vm invalidate eng address
 range for gfxhub on resume
Date: Wed, 17 May 2017 16:11:33 +0800
Message-ID: <591C05B5.4090902@amd.com>
References: <1495006729-17310-1-git-send-email-ray.huang@amd.com>
 <591BFF33.2010303@amd.com> <20170517075557.GA31947@hr-amur2>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <20170517075557.GA31947@hr-amur2>
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
To: Huang Rui <ray.huang-5C7GfCeVMHo@public.gmane.org>
Cc: "Deucher, Alexander" <Alexander.Deucher-5C7GfCeVMHo@public.gmane.org>, "Huan,
 Alvin" <Alvin.Huan-5C7GfCeVMHo@public.gmane.org>, "Wang, Ken" <Ken.Wang-5C7GfCeVMHo@public.gmane.org>, "Koenig,
 Christian" <Christian.Koenig-5C7GfCeVMHo@public.gmane.org>, "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

CgpPbiAyMDE35bm0MDXmnIgxN+aXpSAxNTo1NSwgSHVhbmcgUnVpIHdyb3RlOgo+IE9uIFdlZCwg
TWF5IDE3LCAyMDE3IGF0IDAzOjQzOjQ3UE0gKzA4MDAsIFpob3UsIERhdmlkKENodW5NaW5nKSB3
cm90ZToKPj4gQnkgdGhpcyBjaGFuZ2UsIEkgc3VnZ2VzdCB0byByZW1vdmUgbW1odWIvZ2Z4aHVi
X3YxXzBfaXBfZnVuY3MgYW5kIHRoZWlyCj4+IElQIGJsb2NrLCB1bmlmeSB0aGVtIHRvIGdtYyBp
cCBibG9jaywgdGhpcyB3YXkgd2UgY2Fubm90IGxvc3Qgc2V0dGluZwo+PiB3aGVuIHJlc3VtZSBi
YWNrLgo+Pgo+ICBGcm9tIGh3IHNpZGUsIHdvIHdvbid0IGhhdmUgcmVhbCBnbWMgc2luY2UgdGhp
cyBjaGlwLCBtbWh1YiBhbmQgZ2Z4aHViKGdjKQo+IGluc3RlYWQgb2YgaXQuIE1heWJlIHdlIHdv
dWxkIGJldHRlciB0byBhbGlnbiB3aXRoIGh3IGRlc2dpbi4KSSBkb24ndCBzZWUgYW55IGFkdmFu
Y2UsIGFzIHlvdSBzYWlkLCB3ZSBzdGlsbCBoYXZlIGdtYyBibG9jayBpbiBzb2MxNSwgCndoeSBu
b3QgdW5pZnkgbW1odWIvZ2Z4aHViIGNhbGxzIHRvIGdtYyBibG9jaz8KV2UgY2FuIGtlZXAgbW1o
dWIvZ2Z4aHViX3h4eC5jIGZpbGUsIGJ1dCBpcF9mdW5jaXRvbiBpc24ndCBuZWNlc3NhcnkuCgpS
ZWdhcmRzLApEYXZpZCBaaG91Cj4KPiBUaGFua3MsCj4gUnVpCj4KPj4gUmVnYXJkcywKPj4gRGF2
aWQgWmhvdQo+Pgo+PiBPbiAyMDE35bm0MDXmnIgxN+aXpSAxNTozOCwgSHVhbmcgUnVpIHdyb3Rl
Ogo+Pj4gU2lnbmVkLW9mZi1ieTogSHVhbmcgUnVpIDxyYXkuaHVhbmdAYW1kLmNvbT4KPj4+IC0t
LQo+Pj4gICAgZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvZ2Z4aHViX3YxXzAuYyB8IDIgKy0K
Pj4+ICAgIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKSwgMSBkZWxldGlvbigtKQo+Pj4K
Pj4+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9nZnhodWJfdjFfMC5j
IGIvZHJpdmVycy9ncHUvZHJtL2FtZC8KPj4gYW1kZ3B1L2dmeGh1Yl92MV8wLmMKPj4+IGluZGV4
IDAwNTA3NWYuLjQxMzEzNTE0IDEwMDY0NAo+Pj4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9h
bWRncHUvZ2Z4aHViX3YxXzAuYwo+Pj4gKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUv
Z2Z4aHViX3YxXzAuYwo+Pj4gQEAgLTM2OCw3ICszNjgsNyBAQCBzdGF0aWMgaW50IGdmeGh1Yl92
MV8wX3N1c3BlbmQodm9pZCAqaGFuZGxlKQo+Pj4gICAKPj4+ICAgIHN0YXRpYyBpbnQgZ2Z4aHVi
X3YxXzBfcmVzdW1lKHZvaWQgKmhhbmRsZSkKPj4+ICAgIHsKPj4+IC0gICAgIHJldHVybiAwOwo+
Pj4gKyAgICAgcmV0dXJuIGdmeGh1Yl92MV8wX2h3X2luaXQoaGFuZGxlKTsKPj4+ICAgIH0KPj4+
ICAgCj4+PiAgICBzdGF0aWMgYm9vbCBnZnhodWJfdjFfMF9pc19pZGxlKHZvaWQgKmhhbmRsZSkK
PiBfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwo+IGFtZC1n
ZnggbWFpbGluZyBsaXN0Cj4gYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKPiBodHRwczov
L2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZngKCl9fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBs
aXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0
b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=
