From: Alex Deucher <alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH] drm/amdgpu: replace readq/writeq with atomic64 operations
Date: Wed, 7 Aug 2019 14:00:15 -0400
Message-ID: <CADnq5_M8YvmsA1SDCNygQ2+tcxGjDCbz9ETQ1Fu22OUr03t29g@mail.gmail.com>
References: <20190807025640.682-1-tao.zhou1@amd.com>
 <20190807070834.GA24792@infradead.org>
 <daff9fc7-ead8-40e0-9a16-cb3b90b01722@amd.com>
 <20190807104104.GA18773@infradead.org>
 <18cd9fa5-2d87-2f41-b5fa-927b9790287d@amd.com>
 <20190807130043.GA6023@infradead.org>
 <c613ca25-4443-f275-ea8d-6d55af10ac77@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <c613ca25-4443-f275-ea8d-6d55af10ac77-5C7GfCeVMHo@public.gmane.org>
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
To: "Koenig, Christian" <Christian.Koenig-5C7GfCeVMHo@public.gmane.org>
Cc: "kernel-build-reports-cunTk1MwBs8s++Sfvej+rw@public.gmane.org" <kernel-build-reports-cunTk1MwBs8s++Sfvej+rw@public.gmane.org>, "Zhou1, Tao" <Tao.Zhou1-5C7GfCeVMHo@public.gmane.org>, "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, "Li,
 Dennis" <Dennis.Li-5C7GfCeVMHo@public.gmane.org>, Christoph Hellwig <hch-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, "broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org" <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, "linux-next-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-next-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "Deucher,
 Alexander" <Alexander.Deucher-5C7GfCeVMHo@public.gmane.org>, "akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org" <akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, "Zhang, Hawking" <Hawking.Zhang-5C7GfCeVMHo@public.gmane.org>

T24gV2VkLCBBdWcgNywgMjAxOSBhdCA5OjAzIEFNIEtvZW5pZywgQ2hyaXN0aWFuCjxDaHJpc3Rp
YW4uS29lbmlnQGFtZC5jb20+IHdyb3RlOgo+Cj4gQW0gMDcuMDguMTkgdW0gMTU6MDAgc2Nocmll
YiBDaHJpc3RvcGggSGVsbHdpZzoKPiA+IE9uIFdlZCwgQXVnIDA3LCAyMDE5IGF0IDEwOjU1OjAx
QU0gKzAwMDAsIEtvZW5pZywgQ2hyaXN0aWFuIHdyb3RlOgo+ID4+Pj4gRXNzZW50aWFsbHkgd3Jp
dGVxL3JlYWRxIGRvZXNuJ3Qgc2VlbXMgdG8gYmUgYXZhaWxhYmxlIG9uIGFsbAo+ID4+Pj4gYXJj
aGl0ZWN0dXJlcyBlaXRoZXIuCj4gPj4+IHdyaXRlcS9yZWFkcSBhcmUgcHJvdmlkZWQgd2hlbmV2
ZXIgdGhlIENQVSBhY3R1YWxseSBzdXBwb3J0cyA2NC1iaXQKPiA+Pj4gYXRvbWljIGxvYWRzIGFu
ZCBzdG9yZXMuCj4gPj4gSXMgdGhlcmUgYSBjb25maWcgb3B0aW9uIHdoaWNoIHdlIGNhbiBtYWtl
IHRoZSBkcml2ZXIgZGVwZW5kIG9uPwo+ID4+Cj4gPj4gSSBtZWFuIHRoYXQgQVJNIGRvZXNuJ3Qg
c3VwcG9ydCA2NGJpdCBhdG9taWMgbG9hZHMgYW5kIHN0b3JlcyBvbiBNTUlPIGlzCj4gPj4gcXVp
dGUgYSBib29tZXIgZm9yIHVzLgo+ID4gVGhlIG1vZGVsIGlzIHRvIGNoZWFjayBpZiByZWFkcS93
cml0ZXEgYXJlIGRlZmluZWQsIGFuZCBpZiBub3QgdG8KPiA+IGluY2x1ZGUgdGhlIG9uZSBvZiBp
by02NC1ub25hdG9taWMtaGktbG8uaCBvciBpby02NC1ub25hdG9taWMtbG8taGkuaC4KPiA+IFRo
ZSByZWFzb24gZm9yIHRoYXQgaXMgdGhhdCBoYXJkd2FyZSBpcyBzdXBwb3NlZCB0byBiZSBhYmxl
IHRvIGRlYWwgd2l0aAo+ID4gdHdvIDMyLWJpdCB3cml0ZXMsIGJ1dCBpdCBkZXBlbmRzIG9uIHRo
ZSBoYXJkd2FyZSBpZiB0aGUgbG93ZXIgb3IgdXBwZXIKPiA+IGhhbGYgaXMgd2hhdCBjb21taXRz
IHRoZSB3cml0ZS4KPgo+IFJlYWQsIGJ1dCBhcyBJIHVuZGVyc3Rvb2QgVGFvIGNoYW5nZSB0aGlz
IGlzIG5vdCB0aGUgY2FzZSBoZXJlLgo+IE90aGVyd2lzZSB3ZSB3b3VsZCBqdXN0IHVzZSBvdXIg
V1JFRzMyL1JSRUczMiBtYWNyb3MgaW4gdGhlIGRyaXZlci4KPgo+IFRhbywgcGxlYXNlIGV4cGxh
aW4gd2h5IGV4YWN0bHkgd2UgbmVlZCB0aGUgV1JFRzY0L1JSRUc2NCBjaGFuZ2Ugd2hpY2gKPiBj
YXVzZWQgdGhpcy4KCldlIHVzZSB0aGlzIGZvciBkb29yYmVsbHMgYXMgd2VsbCB3aGljaCBpcyBh
bHNvIE1NSU8uICBCYXNpY2FsbHkgd2UKaGF2ZSB0aGUgcmVxdWlyZW1lbnQgdG8gcmVhZCBvciB3
cml0ZSB0aGUgZnVsbCA2NCBiaXRzIGluIG9uZQpvcGVyYXRpb24uICBFLmcuLCBmb3IgNjQtYml0
IGRvb3JiZWxscywgdGhlIGVudGlyZSByZWdpc3RlciBpcyB0aGUKdHJpZ2dlciBzbyBpZiB3ZSBk
byBpdCBhcyB0d28gd3JpdGVzLCB3ZSdsbCBtaXNzIGhhbGYgdGhlIHVwZGF0ZS4gIEluCnRoZSBj
YXNlIG9mIHNvbWUgZXJyb3IgY291bnRlciByZWdpc3RlcnMsIHJlYWRpbmcgdGhlIHJlZ2lzdGVy
IHdpbGwKY2xlYXIgdGhlIHZhbHVlIHNvIHdlIG5lZWQgdG8gcmVhZCBvdXQgdGhlIGZ1bGwgdmFs
dWUgb3Igd2UgbG9zZSB0aGUKaGFsZiB0aGUgdmFsdWUuICBUaGlzIHdvcmtzIHByb3Blcmx5IG9u
IHg4NiBhbmQgQU1ENjQuCgpBbGV4Cgo+Cj4gQ2hyaXN0aWFuLgo+Cj4gPgo+ID4gVGhlIG9ubHkg
MzItYml0IHBsYXRmb3JtIHRoYXQgY2xhaW1zIHN1cHBvcnQgZm9yIHJlYWRxL3dyaXRlcSBpcyBz
aCwKPiA+IGFuZCBJIGhhdmUgZG91YnRzIGlmIHRoYXQgYWN0dWFsbHkgd29ya3MgYXMgZXhwZWN0
ZWQuCj4KPiBfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwo+
IGFtZC1nZnggbWFpbGluZyBsaXN0Cj4gYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKPiBo
dHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZngKX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWls
aW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVl
ZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4
