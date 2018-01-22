From: Tom St Denis <tom.stdenis-5C7GfCeVMHo@public.gmane.org>
Subject: Re: lock/unlock mismatch in ttm_bo.c
Date: Mon, 22 Jan 2018 06:29:58 -0500
Message-ID: <4edfd426-6daf-8659-3c2d-b8b8cace7898@amd.com>
References: <1713476e-c17f-9eea-ebd3-6999c760b678@amd.com>
 <81e40cdf-6869-57fa-6858-eb77dbfb45a8@amd.com>
 <57fdd509-5de6-a7d8-9588-cb2c63b8f451@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <57fdd509-5de6-a7d8-9588-cb2c63b8f451-5C7GfCeVMHo@public.gmane.org>
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
To: Chunming Zhou <zhoucm1-5C7GfCeVMHo@public.gmane.org>, amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org

T24gMjIvMDEvMTggMDE6NDIgQU0sIENodW5taW5nIFpob3Ugd3JvdGU6Cj4gCj4gCj4gT24gMjAx
OOW5tDAx5pyIMjDml6UgMDI6MjMsIFRvbSBTdCBEZW5pcyB3cm90ZToKPj4gT24gMTkvMDEvMTgg
MDE6MTQgUE0sIFRvbSBTdCBEZW5pcyB3cm90ZToKPj4+IEhpIGFsbCwKPj4+Cj4+PiBJbiB0aGUg
ZnVuY3Rpb24gdHRtX2JvX2NsZWFudXBfcmVmcygpIGl0IHNlZW1zIHBvc3NpYmxlIHRvIGdldCB0
byAKPj4+IGxpbmUgNTUxIHdpdGhvdXQgZW50ZXJpbmcgdGhlIGJsb2NrIG9uIDUxNiB3aGljaCBt
ZWFucyB5b3UnbGwgYmUgCj4+PiB1bmxvY2tpbmcgYSBtdXRleCB0aGF0IHdhc24ndCBsb2NrZWQu
Cj4+Pgo+Pj4gTm93IGl0IG1pZ2h0IGJlIHRoYXQgaW4gdGhlIGNvdXJzZSBvZiB0aGUgQVBJIHRo
aXMgcGF0dGVybiBjYW5ub3QgYmUgCj4+PiBleHByZXNzZWQgYnV0IGl0J3Mgbm90IGNsZWFyIGZy
b20gdGhlIGZ1bmN0aW9uIGFsb25lIHRoYXQgdGhhdCBpcyB0aGUgCj4+PiBjYXNlLgo+Pgo+Pgo+
PiBMb29raW5nIGZ1cnRoZXIgaXQgc2VlbXMgdGhlIGJlaGF2aW91ciBkZXBlbmRzIG9uIGxvY2tp
bmcgaW4gcGFyZW50IAo+PiBjYWxsZXJzLsKgIFRoYXQncyBraW5kYSBhIG5vLW5vIHJpZ2h0P8Kg
IFNob3VsZG4ndCB0aGUgbG9jayBiZSAKPj4gdGFrZW4vcmVsZWFzZWQgaW4gdGhlIHNhbWUgZnVu
Y3Rpb24gaWRlYWxseT8KPiBTYW1lIGZlZWxpbmdzCgpIaSBEYXZpZCwKCk9rIEknbGwgc2VlIGlm
IEkgY2FuIHNvcnQgdGhpcyBvdXQuCgpDaGVlcnMsClRvbQoKPiAKPiBSZWdhcmRzLAo+IERhdmlk
IFpob3UKPj4KPj4gKGFsc28gdGhlcmUgYXJlIGEgaGFuZGZ1bCBvZiBzdHlsZSBpc3N1ZXMgSSds
bCB3cml0ZSB1cCBzb21lIHBhdGNoZXMgCj4+IGZvciBvbiBNb25kYXkgOi0pKS4KPj4KPj4gQ2hl
ZXJzLAo+PiBUb20KPj4gX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX18KPj4gYW1kLWdmeCBtYWlsaW5nIGxpc3QKPj4gYW1kLWdmeEBsaXN0cy5mcmVlZGVza3Rv
cC5vcmcKPj4gaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9h
bWQtZ2Z4Cj4gCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
XwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRw
czovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZngK
