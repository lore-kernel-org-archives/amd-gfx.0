From: Sumit Semwal <sumit.semwal-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 1/2] dma-buf: keep only not signaled fence in
 reservation_object_add_shared_replace v2
Date: Thu, 2 Nov 2017 17:56:33 +0530
Message-ID: <CAO_48GGvgwZtAe9drHcG1CVXW51t5JKnD6ygzMgeznGkZhWcsQ@mail.gmail.com>
References: <20171030145904.18584-1-deathsimple@vodafone.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <20171030145904.18584-1-deathsimple-ANTagKRnAhcb1SvskN2V4Q@public.gmane.org>
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
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: amd-gfx list <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, DRI mailing list <dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

SGkgQ2hyaXN0aWFuLAoKT24gMzAgT2N0b2JlciAyMDE3IGF0IDIwOjI5LCBDaHJpc3RpYW4gS8O2
bmlnCjxja29lbmlnLmxlaWNodHp1bWVya2VuQGdtYWlsLmNvbT4gd3JvdGU6Cj4gRnJvbTogQ2hy
aXN0aWFuIEvDtm5pZyA8Y2hyaXN0aWFuLmtvZW5pZ0BhbWQuY29tPgo+Cj4gVGhlIGFtZGdwdSBp
c3N1ZSB0byBhbHNvIG5lZWQgc2lnbmFsZWQgZmVuY2VzIGluIHRoZSByZXNlcnZhdGlvbiBvYmpl
Y3RzCj4gc2hvdWxkIGJlIGZpeGVkIGJ5IG5vdy4KPgo+IE9wdGltaXplIHRoZSBsaXN0IGJ5IGtl
ZXBpbmcgb25seSB0aGUgbm90IHNpZ25hbGVkIHlldCBmZW5jZXMgYXJvdW5kLgoKSSB0aGluayB0
aGlzIHdhcnJhbnRzIHNvbWUgbW9yZSBjb250ZXh0IGluIHRoZSBjb21taXQgbG9nLiBDb3VsZCB5
b3UKcGxlYXNlIGRvIHRoZSBzYW1lIGZvciB0aGUgb3RoZXIgcGF0Y2ggYXMgd2VsbD8KPgo+IHYy
OiB0ZW1wb3JhcnkgcHV0IHRoZSBzaWduYWxlZCBmZW5jZXMgYXQgdGhlIGVuZCBvZiB0aGUgbmV3
IGNvbnRhaW5lcgo+Cj4gU2lnbmVkLW9mZi1ieTogQ2hyaXN0aWFuIEvDtm5pZyA8Y2hyaXN0aWFu
LmtvZW5pZ0BhbWQuY29tPgo+IC0tLQo+ICBkcml2ZXJzL2RtYS1idWYvcmVzZXJ2YXRpb24uYyB8
IDM2ICsrKysrKysrKysrKysrKysrKysrKysrKysrLS0tLS0tLS0tLQo+ICAxIGZpbGUgY2hhbmdl
ZCwgMjYgaW5zZXJ0aW9ucygrKSwgMTAgZGVsZXRpb25zKC0pCj4KCkJlc3QsClN1bWl0LgpfX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxp
bmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVk
ZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZngK
