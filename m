From: =?UTF-8?Q?Christian_K=c3=b6nig?= <deathsimple-ANTagKRnAhcb1SvskN2V4Q@public.gmane.org>
Subject: Re: [PATCH] LRU map compute/SDMA user ring ids to kernel ring ids v2
Date: Mon, 24 Apr 2017 09:40:54 +0200
Message-ID: <f7bf1964-c548-2cf5-3a46-b53cc7c80816@vodafone.de>
References: <20170421234836.18620-1-andresx7@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <20170421234836.18620-1-andresx7-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
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
To: Andres Rodriguez <andresx7-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org

SSB3YW50ZWQgdG8gcHVzaCB0aGF0IHRvIG91ciBpbnRlcm5hbCBicmFuY2gsIGJ1dCBmb3VuZCB0
aGF0IGl0IGRvZXNuJ3QgCmFwcGx5IGNsZWFubHkuIFNvIHBsZWFzZSByZWJhc2Ugb24gYWxleCBh
bWQtc3RhZ2luZy00LjkgYnJhbmNoLgoKQWRkaXRpb25hbCB0byB0aGF0IHlvdSBmb3Jnb3QgbXkg
cmIgb24gcGF0Y2ggIzQuCgpSZWdhcmRzLApDaHJpc3RpYW4uCgpBbSAyMi4wNC4yMDE3IHVtIDAx
OjQ4IHNjaHJpZWIgQW5kcmVzIFJvZHJpZ3VlejoKPiBWMiB1cGRhdGVzOgo+ICAgKiBSZWJhc2Vk
Cj4gICAqIEFsbCBwYXRjaGVzIG5vdyBoYXZlIHItYgo+Cj4gU2Vjb25kIHBhcnQgb2YgdGhlIHNw
bGl0IG9mIHRoZSBzZXJpZXM6Cj4gQWRkIHN1cHBvcnQgZm9yIGhpZ2ggcHJpb3JpdHkgc2NoZWR1
bGluZyBpbiBhbWRncHUgdjgKPgo+IFRoZXNlIHBhdGNoZXMgc2hvdWxkIGJlIGNsb3NlIHRvIGJl
aW5nIGdvb2QgZW5vdWdoIHRvIGxhbmQuCj4KPiBUaGUgZmlyc3QgdHdvIHBhdGNoZXMgYXJlIHNp
bXBsZSBmaXhlcyBJJ3ZlIHBvcnRlZCBmcm9tIHRoZSBST0NtIGJyYW5jaC4gVGhlc2UKPiBzdGls
bCBuZWVkIHJldmlldy4KPgo+IEkndmUgZml4ZWQgYWxsIG9mIENocmlzdGlhbidzIGNvbW1lbnRz
IGZvciBwYXRjaCAwNDoKPiBkcm0vYW1kZ3B1OiBpbXBsZW1lbnQgbHJ1IGFtZGdwdV9xdWV1ZV9t
Z3IgcG9saWN5IGZvciBjb21wdXRlIHY0Cj4KPiBfX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fXwo+IGFtZC1nZnggbWFpbGluZyBsaXN0Cj4gYW1kLWdmeEBsaXN0
cy5mcmVlZGVza3RvcC5vcmcKPiBodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFu
L2xpc3RpbmZvL2FtZC1nZngKCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9w
Lm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1n
ZngK
