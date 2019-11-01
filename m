From: Jason Gunthorpe <jgg-VPRAkNaXOzVWk0Htik3J/w@public.gmane.org>
Subject: Re: [PATCH v2 14/15] drm/amdgpu: Use mmu_range_notifier instead of
 hmm_mirror
Date: Fri, 1 Nov 2019 18:21:06 +0000
Message-ID: <20191101182102.GQ22766@mellanox.com>
References: <20191028201032.6352-1-jgg@ziepe.ca>
 <20191028201032.6352-15-jgg@ziepe.ca>
 <a456ebd0-28cf-997b-31ff-72d9077a9b8e@amd.com>
 <20191029192544.GU22766@mellanox.com>
 <30b2f569-bf7a-5166-c98d-4a4a13d1351f@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <30b2f569-bf7a-5166-c98d-4a4a13d1351f-5C7GfCeVMHo@public.gmane.org>
Content-Language: en-US
Content-ID: <BCECA9D0A65ADC4A904C52D0F1BF1A4A-wNKe6lTLrGecE4WynfumptQqCkab/8FMAL8bYrjMMd8@public.gmane.org>
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
To: "Yang, Philip" <Philip.Yang-5C7GfCeVMHo@public.gmane.org>, Jerome Glisse <jglisse-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: Juergen Gross <jgross-IBi9RG/b67k@public.gmane.org>, "Zhou,
 David(ChunMing)" <David1.Zhou-5C7GfCeVMHo@public.gmane.org>, Ralph Campbell <rcampbell-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, Stefano Stabellini <sstabellini-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Oleksandr Andrushchenko <oleksandr_andrushchenko-uRwfk40T5oI@public.gmane.org>, "linux-rdma-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-rdma-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, John Hubbard <jhubbard-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, "Kuehling, Felix" <Felix.Kuehling-5C7GfCeVMHo@public.gmane.org>, Mike Marciniszyn <mike.marciniszyn-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, "Koenig,
 Christian" <Christian.Koenig-5C7GfCeVMHo@public.gmane.org>, Christoph Hellwig <hch-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, "linux-mm-Bw31MaZKKs3YtjvyW6yDsg@public.gmane.org" <linux-mm-Bw31MaZKKs3YtjvyW6yDsg@public.gmane.org>, "dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, "nouveau-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <nouveau-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, "Deucher,
 Alexander" <Alexander.Deucher-5C7GfCeVMHo@public.gmane.org>, "xen-devel-GuqFBffKawtpuQazS67q72D2FQJk+8+b@public.gmane.org" <xen-devel-GuqFBffKawtpuQazS67q72D2FQJk+8+b@public.gmane.org>, Boris Ostrovsky <boris.o>

T24gRnJpLCBOb3YgMDEsIDIwMTkgYXQgMDI6NDQ6NTFQTSArMDAwMCwgWWFuZywgUGhpbGlwIHdy
b3RlOgo+IEBAIC04NTQsMTIgKzg1MywyMCBAQCBpbnQgYW1kZ3B1X3R0bV90dF9nZXRfdXNlcl9w
YWdlcyhzdHJ1Y3QgYW1kZ3B1X2JvICpibywgc3RydWN0IHBhZ2UgKipwYWdlcykKPiAgCQlyID0g
LUVQRVJNOwo+ICAJCWdvdG8gb3V0X3VubG9jazsKPiAgCX0KPiArCXVwX3JlYWQoJm1tLT5tbWFw
X3NlbSk7Cj4gKwl0aW1lb3V0ID0gamlmZmllcyArIG1zZWNzX3RvX2ppZmZpZXMoSE1NX1JBTkdF
X0RFRkFVTFRfVElNRU9VVCk7Cj4gKwo+ICtyZXRyeToKPiArCXJhbmdlLT5ub3RpZmllcl9zZXEg
PSBtbXVfcmFuZ2VfcmVhZF9iZWdpbigmYm8tPm5vdGlmaWVyKTsKPiAgCj4gKwlkb3duX3JlYWQo
Jm1tLT5tbWFwX3NlbSk7Cj4gIAlyID0gaG1tX3JhbmdlX2ZhdWx0KHJhbmdlLCAwKTsKPiAgCXVw
X3JlYWQoJm1tLT5tbWFwX3NlbSk7Cj4gLQo+IC0JaWYgKHVubGlrZWx5KHIgPCAwKSkKPiArCWlm
ICh1bmxpa2VseShyIDw9IDApKSB7Cj4gKwkJaWYgKChyID09IDAgfHwgciA9PSAtRUJVU1kpICYm
ICF0aW1lX2FmdGVyKGppZmZpZXMsIHRpbWVvdXQpKQo+ICsJCQlnb3RvIHJldHJ5Owo+ICAJCWdv
dG8gb3V0X2ZyZWVfcGZuczsKPiArCX0KCkkgd2FzIHJlZmxlY3Rpbmcgb24gd2h5IHRoaXMgc3Vk
ZGVudGx5IGJlY2FtZSBuZWNlc3NhcnksIGFuZCBJIHRoaW5rCndoYXQgbWlnaHQgYmUgaGFwcGVu
aW5nIGlzIHRoYXQgaG1tX3JhbmdlX2ZhdWx0KCkgaXMgdHJpZ2dpbmcKaW52YWxpZGF0aW9ucyBh
cyBpdCBydW5zIChpZSBpdCBpcyBmYXVsdGluZyBpbiBwYWdlcyBvciBzb21ldGhpbmcpIGFuZAp0
aGF0IGluIHR1cm4gY2F1c2VzIHRoZSBtcm4gdG8gbmVlZCByZXRyeS4KClRoZSBobW0gdmVyc2lv
biBvZiB0aGlzIGhhZCBhIGJ1ZyB3aGVyZSBhIGZ1bGwKaW52YWxpZGF0ZV9yYW5nZV9zdGFydC9l
bmQgcGFpciB3b3VsZCBub3QgdHJpZ2dlciByZXRyeSwgc28gdGhpcyB0aGlzCmRpZG4ndCBoYXBw
ZW4uCgpUaGlzIGlzIHVuZm9ydHVuYXRlIGFzIHRoZSByZXRyeSBpcyB1bm5lY2Vzc2FyeSwgYnV0
IGF0IHRoaXMgdGltZSBJCmNhbid0IHRoaW5rIG9mIGEgZ29vZCB3YXkgdG8gc2VwYXJhdGUgYW4g
aWdub3JhYmxlIHN5bmNocm9ub3VzCmludmFsaWRhdGlvbiBjYXVzZWQgYnkgaG1tX3JhbmdlX2Zh
dWx0IGZyb20gYW4gYXN5bmMgb25lIHRoYXQgY2Fubm90CmJlIGlnbm9yZWQuLgoKQSBiYXNpYyBm
aXggd291bGQgYmUgdG8gbm90IHVwZGF0ZSB0aGUgbXJxIHNlcSBpbiB0aGUgbm90aWZpZXIgaWYK
dGhlIGludmFsaWRhdGUgaXMgdHJpZ2dlcmVkIGJ5IGhtbV9yYW5nZV9mYXVsdCwgYnV0IHRoYXQg
c2VlbXMKZGlmZmljdWx0IHRvIGRldGVybWluZS4uCgpBbnkgdGhvdWdodHMgSmVyb21lPwoKSmFz
b24KX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdm
eCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0
cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4
