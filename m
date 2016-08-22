From: =?UTF-8?Q?Michel_D=c3=a4nzer?= <michel-otUistvHUpPR7s880joybQ@public.gmane.org>
Subject: Re: [PATCH v2 xserver 0/5] modesetting: add DRI2 page flip support
Date: Mon, 22 Aug 2016 11:03:50 +0900
Message-ID: <3d52c599-1b16-00bd-3cc3-5ce33d03a4d6@daenzer.net>
References: <1471611050-27207-1-git-send-email-Qiang.Yu@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <1471611050-27207-1-git-send-email-Qiang.Yu-5C7GfCeVMHo@public.gmane.org>
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
To: Qiang Yu <Qiang.Yu-5C7GfCeVMHo@public.gmane.org>
Cc: emil.l.velikov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, xorg-devel-go0+a7rfsptAfugRpC6u6w@public.gmane.org, amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org

T24gMTkvMDgvMTYgMDk6NTAgUE0sIFFpYW5nIFl1IHdyb3RlOgo+IEhpIGd1eXMsCj4gCj4gVGhp
cyBwYXRjaCBzZXQgaXMgZm9yIGFkZGluZyBEUkkyIHBhZ2UgZmxpcCBzdXBwb3J0IHRvIG1vZGVz
ZXR0aW5nCj4gZHJpdmVyLiBJIG1haW5seSB0YWtlIHJlZmVyZW5jZSBvZiBhbWRncHUgRERYIGFu
ZCByZXVzZSBwcmVzZW50Cj4gcGFnZSBmbGlwIGNvZGUgaW4gdGhlIG1vZGVzZXR0aW5nIGRyaXZl
ci4KPiAKPiBWMjoKPiAxLiBmaXggRFJJMiBwYWdlIGZsaXAgc3VjY2VzcyBoYW5kbGVyIGV2ZW50
IG1lbW9yeSBsZWFrCj4gMi4gYWRqdXN0IHBhdGNoIHNlcXVlbmNlIHRvIG1ha2UgRFJJMiB1c2Ug
dGhlIGNvbW1vbgo+ICAgIHBhZ2UgZmxpcCBjb2RlIGluIHBhZ2VmbGlwLmMgZnJvbSB0aGUgYmVn
aW5uaW5nCj4gMy4gc29tZSBmaXggb24gZGVidWcgb3V0cHV0IGFuZCBjb21tZW50cwo+IAo+IFJl
Z2FyZHMsCj4gUWlhbmcKPiAKPiBRaWFuZyBZdSAoNSk6Cj4gICBtb2Rlc2V0dGluZzogbWFrZSBt
c19kb19wYWdlZmxpcCBnZW5lcmljIGZvciBzaGFyZSB3aXRoIERSSTIKPiAgIG1vZGVzZXR0aW5n
OiBtb3ZlIG1zX2RvX3BhZ2VmbGlwIHRvIHBhZ2VmbGlwLmMKPiAgIG1vZGVzZXR0aW5nOiBtb3Zl
IGNvbW1vbiBwYWdlIGZsaXAgaGFuZGxlIHRvIHBhZ2VmbGlwLmMKPiAgIG1vZGVzZXR0aW5nOiBh
ZGQgRFJJMiBwYWdlIGZsaXAgc3VwcG9ydAo+ICAgbW9kZXNldHRpbmc6IGV4Y2x1ZGUgRFJJMiBh
bmQgcHJlbnNlbnQgcGFnZSBmbGlwCgpQbGVhc2Ugc3F1YXNoIHBhdGNoIDUgaW50byBwYXRjaCA0
LgoKCi0tIApFYXJ0aGxpbmcgTWljaGVsIETDpG56ZXIgICAgICAgICAgICAgICB8ICAgICAgICAg
ICAgICAgaHR0cDovL3d3dy5hbWQuY29tCkxpYnJlIHNvZnR3YXJlIGVudGh1c2lhc3QgICAgICAg
ICAgICAgfCAgICAgICAgICAgICBNZXNhIGFuZCBYIGRldmVsb3BlcgpfX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQt
Z2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9t
YWlsbWFuL2xpc3RpbmZvL2FtZC1nZngK
