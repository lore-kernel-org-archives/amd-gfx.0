From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: KFD co-maintainership and branch model
Date: Thu, 23 Aug 2018 09:00:36 +0200
Message-ID: <fdddff79-44f5-46ec-7a0b-b7695edd4219@gmail.com>
References: <705cc9da-7ccb-bafd-0dd8-86630b37a8ca@amd.com>
 <CAMwc25pqgoahob6NeJEB5DXr3R05gA05ZRMsgq-dsjWFUusZeg@mail.gmail.com>
 <CAFCwf11FJpeDyFazspQNo26SNN7CA-CVpFMoKn2Q6hcNX6ymDA@mail.gmail.com>
Reply-To: christian.koenig-5C7GfCeVMHo@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <CAFCwf11FJpeDyFazspQNo26SNN7CA-CVpFMoKn2Q6hcNX6ymDA-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
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
To: Oded Gabbay <oded.gabbay-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Dave Airlie <airlied-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: Alex Deucher <Alexander.Deucher-5C7GfCeVMHo@public.gmane.org>, "Kuehling,
 Felix" <felix.kuehling-5C7GfCeVMHo@public.gmane.org>, amd-gfx list <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

QW0gMjMuMDguMjAxOCB1bSAwODo1NCBzY2hyaWViIE9kZWQgR2FiYmF5Ogo+IE9uIFRodSwgQXVn
IDIzLCAyMDE4IGF0IDQ6MzQgQU0gRGF2aWQgQWlybGllIDxhaXJsaWVkQHJlZGhhdC5jb20+IHdy
b3RlOgo+PiBPbiBUaHUsIEF1ZyAyMywgMjAxOCBhdCA4OjI1IEFNLCBGZWxpeCBLdWVobGluZyA8
ZmVsaXgua3VlaGxpbmdAYW1kLmNvbT4gd3JvdGU6Cj4+PiBIaSBhbGwsCj4+Pgo+Pj4gT2RlZCBo
YXMgb2ZmZXJlZCB0byBtYWtlIG1lIGNvLW1haW50YWluZXIgb2YgS0ZELCBhcyBoZSdzIHN1cGVy
IGJ1c3kgYXQKPj4+IHdvcmsgYW5kIGxlc3MgcmVzcG9uc2l2ZSB0aGFuIGhlIHVzZWQgdG8gYmUu
Cj4+Pgo+Pj4gQXQgdGhlIHNhbWUgdGltZSB3ZSdyZSBhYm91dCB0byBzZW5kIG91dCB0aGUgZmly
c3QgcGF0Y2hlcyB0byBtZXJnZSBLRkQKPj4+IGFuZCBBTURHUFUgaW50byBhIHNpbmdsZSBrZXJu
ZWwgbW9kdWxlLgo+Pj4KPj4+IFdpdGggdGhhdCBpbiBtaW5kIEknZCBsaWtlIHRvIHByb3Bvc2Ug
dG8gdXBzdHJlYW0gS0ZEIHRocm91Z2ggQWxleCdzCj4+PiBicmFuY2ggaW4gdGhlIGZ1dHVyZS4g
SXQgd291bGQgYXZvaWQgY29uZmxpY3RzIGluIHNoYXJlZCBjb2RlCj4+PiAoYW1kZ3B1X3ZtLmMg
aXMgbW9zdCBhY3RpdmUgYXQgdGhlIG1vbWVudCkgd2hlbiBtZXJnaW5nIGJyYW5jaGVzLCBhbmQK
Pj4+IG1ha2UgdGhlIGNvZGUgZmxvdyBhbmQgdGVzdGluZyBlYXNpZXIuCj4+Pgo+Pj4gUGxlYXNl
IGxldCBtZSBrbm93IHdoYXQgeW91IHRoaW5rPwo+Pj4KPj4gV29ya3MgZm9yIG1lLgo+Pgo+PiBU
aGFua3MsCj4+IERhdmUuCj4gV29ya3MgZm9yIG1lIGFzIHdlbGwuCgpTb3VuZHMgZ29vZCB0byBt
ZSBhcyB3ZWxsLgoKQ2hyaXN0aWFuLgoKPgo+IE9kZWQKPiBfX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fXwo+IGFtZC1nZnggbWFpbGluZyBsaXN0Cj4gYW1kLWdm
eEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKPiBodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9t
YWlsbWFuL2xpc3RpbmZvL2FtZC1nZngKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRl
c2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8v
YW1kLWdmeAo=
