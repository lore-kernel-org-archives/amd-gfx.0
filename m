From: Andres Rodriguez <andresx7-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 1/3] headers: Sync {amdgpu,radeon}_drm.h with the kernel
Date: Mon, 9 Jan 2017 12:01:28 -0500
Message-ID: <d5029218-6760-ef97-3dd6-632ad51dc966@gmail.com>
References: <20170105002935.5796-1-andresx7@gmail.com>
 <20170105002935.5796-2-andresx7@gmail.com>
 <CACvgo50x_z1XrM-V2jvYf3e3zp4muy0Wyxpimk_5zM9hof28PQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <CACvgo50x_z1XrM-V2jvYf3e3zp4muy0Wyxpimk_5zM9hof28PQ-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
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
To: Emil Velikov <emil.l.velikov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: amd-gfx mailing list <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

CgpPbiAyMDE3LTAxLTA5IDExOjIzIEFNLCBFbWlsIFZlbGlrb3Ygd3JvdGU6Cj4gVGhhbmsgeW91
IEFuZHJlcy4gVGhlcmUncyBhIHNtYWxsIG5pdCBiZWxvdy4KPgo+IE9uIDUgSmFudWFyeSAyMDE3
IGF0IDAwOjI5LCBBbmRyZXMgUm9kcmlndWV6IDxhbmRyZXN4N0BnbWFpbC5jb20+IHdyb3RlOgo+
PiBHZW5lcmF0ZWQgdXNpbmcgbWFrZSBoZWFkZXJzX2luc3RhbGwgZnJvbToKPj4gYWlybGllZC9k
cm0tbmV4dCAyY2YwMjZhIE1lcmdlIGJyYW5jaCAnbGludXgtNC4xMCcgLi4uCj4+Cj4+IE1hbnVh
bGx5IHJlLWFkZGVkIG1pc3NpbmcgUkFERU9OX1RJTElOR19SNjAwX05PX1NDQU5PVVQgYXMgZG9j
dW1lbnRlZCBvbgo+PiBSRUFETUUKPj4KPiAiVGhvdSBTaGFsdCBOb3QgbWFrZSBhbnkgbWFudWFs
IGNoYW5nZXMgdG8gaW5jbHVkZS9kcm0vKmgiCj4KPiBQbGVhc2UgY2hlY2sgaWYgdGhlcmUncyBy
ZWxlYXNlZCBvcGVuLXNvdXJjZSB1c2Vyc3BhY2Ugd2hpY2ggZGVwZW5kcwo+IG9uIHRoaXMuIElm
IHRoZXJlJ3Mgbm9uZSBqdXN0IGRyb3AgaXQgYWxsIHRvZ2V0aGVyLCBhbHRlcm5hdGl2ZWx5Cj4g
cGxlYXNlIHVwZGF0ZSB0aGUga2VybmVsIGhlYWRlcihzKS4KR2FsbGl1bSBpbiBtZXNhIGRlcGVu
ZHMgb24gdGhpcywgc28gSSdsbCB1cGRhdGUgdGhlIGtlcm5lbCBoZWFkZXJzIAphY2NvcmRpbmds
eS4KClRoYW5rcyBhZ2FpbiBmb3IgcG9pbnRpbmcgbWUgdG8gdGhlIFJFQURNRSwgaXQgd2FzIHBy
ZXR0eSB1c2VmdWwuCgpSZWdhcmRzLApBbmRyZXMKCj4KPiBUaGFua3MKPiBFbWlsCgpfX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcg
bGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNr
dG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZngK
