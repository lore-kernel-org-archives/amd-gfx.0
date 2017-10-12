From: Andres Rodriguez <andresx7-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH] drm/amdgpu: introduce AMDGPU_GEM_CREATE_EXPLICIT_SYNC v2
Date: Thu, 12 Oct 2017 14:31:06 -0400
Message-ID: <efb88ab7-8d4e-323f-b0bc-da05880879bf@gmail.com>
References: <20170919125918.4132-1-andresx7@gmail.com>
 <fa69f268-541d-8729-48cf-93ae50d44035@gmail.com>
 <23e71499-cd99-7016-fb8e-a7029dadee51@gmail.com>
 <CAAxE2A4MjBnDweD3kKZuSkxRGY9RZ1Z335Hm3XgZemZy0wz_qw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <CAAxE2A4MjBnDweD3kKZuSkxRGY9RZ1Z335Hm3XgZemZy0wz_qw-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
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
To: =?UTF-8?B?TWFyZWsgT2zFocOhaw==?= <maraeo-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: =?UTF-8?Q?Christian_K=c3=b6nig?= <deathsimple-ANTagKRnAhcb1SvskN2V4Q@public.gmane.org>, =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig-5C7GfCeVMHo@public.gmane.org>, amd-gfx mailing list <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

CgpPbiAyMDE3LTEwLTEyIDAyOjI3IFBNLCBNYXJlayBPbMWhw6FrIHdyb3RlOgo+IE9uIFRodSwg
U2VwIDIxLCAyMDE3IGF0IDQ6MzggUE0sIEFuZHJlcyBSb2RyaWd1ZXogPGFuZHJlc3g3QGdtYWls
LmNvbT4gd3JvdGU6Cj4+IEhpIENocmlzdGlhbiwKPj4KPj4gVGhlIHJlZmVyZW5jZSByYWR2IHBh
dGNoZXMgYXJlIG9uIHRoZSBsaXN0LiBUaGUgYmFzaWMgaWRlYSBpcyB0byBvbmx5IHNldAo+PiB0
aGUgZXhwbGljaXQgc3luYyBmbGFnIGZvciBidWZmZXJzIGFsbG9jYXRlZCBmb3IgZHJpIHVzYWdl
Lgo+IAo+IERpZCB5b3UgbWVhbiAib25seSBzZXQgdGhlIGV4cGxpY2l0IHN5bmMgZmxhZyBmb3Ig
YnVmZmVycyBOT1QKPiBhbGxvY2F0ZWQgZm9yIGRyaSB1c2FnZSI/Cj4gCgpZZXMsIHRoYW5rcyBm
b3IgdGhlIGNvcnJlY3Rpb24uIFRoZSBkcmkgYnVmZmVycyB1c2UgaW1wbGljaXQgc3luYywgdGhl
IApyZXN0IG9mIHRoZSBidWZmZXJzIHVzZSBleHBsaWNpdCBzeW5jLgoKUmVnYXJkcywKQW5kcmVz
CgoKPiBNYXJlawo+IApfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpo
dHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZngK
