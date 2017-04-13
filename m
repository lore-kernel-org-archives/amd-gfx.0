From: Andres Rodriguez <andresx7-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH split] Improve pipe split between amdgpu and amdkfd
Date: Thu, 13 Apr 2017 17:39:58 -0400
Message-ID: <ba3b9070-0a7d-d2a6-fd9c-e39a14be85c9@gmail.com>
References: <20170413213542.18802-1-andresx7@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <20170413213542.18802-1-andresx7-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
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
To: "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

Rm9yZ290IHRvIG1lbnRpb246CiAgICogUmUtb3JkZXJlZCBzb21lIHBhdGNoZXMgYXMgc3VnZ2Vz
dGVkIGJ5IEZlbGl4CiAgICogSW5jbHVkZWQgImRybTogRml4IGdldF9wcm9wZXJ0eSBsb2dpYyBm
dW1ibGUiIGR1cmluZyB0ZXN0aW5nLCAKb3RoZXJ3aXNlIHRoZSBzeXN0ZW0gYm9vdHMgdG8gYSBi
bGFjayBzY3JlZW4uCgpSZWdhcmRzLApBbmRyZXMKCk9uIDIwMTctMDQtMTMgMDU6MzUgUE0sIEFu
ZHJlcyBSb2RyaWd1ZXogd3JvdGU6Cj4gVGhpcyBpcyBhIHNwbGl0IG9mIHBhdGNoZXMgdGhhdCBh
cmUgcmVhZHkgdG8gbGFuZCBmcm9tIHRoZSBzZXJpZXM6Cj4gQWRkIHN1cHBvcnQgZm9yIGhpZ2gg
cHJpb3JpdHkgc2NoZWR1bGluZyBpbiBhbWRncHUgdjgKPgo+IEkndmUgaW5jbHVkZWQgRmVsaXgg
YW5kIEFsZXgncyBmZWVkYmFjayBmcm9tIHRoZSB0aHJlYWQgYWJvdmUuIFRoaXMgaW5jbHVkZXM6
Cj4gICogU2VwYXJhdGUgTUVDX0hQRF9TSVpFIHJlbmFtZSBpbnRvIGEgc2VwYXJhdGUgcGF0Y2gg
KHBhdGNoIDAxKQo+ICAqIEFkZGVkIGEgcGF0Y2ggdG8gZml4IHRoZSBrZ2RfaHFkX2xvYWQgYnVn
IEZlbGl4IHBvaW50ZWQgb3V0IChwYXRjaCAwNikKPiAgKiBGaXhlcyBmb3IgdmFyaW91cyBvZmYt
Ynktb25lIGVycm9ycwo+ICAqIFVzZSBnZnhfdjhfMF9kZWFjdGl2YXRlX2hxZAo+Cj4gT25seSBj
b21tZW50IEkgZGlkbid0IGFkZHJlc3Mgd2FzIGNoYW5naW5nIHRoZSBxdWV1ZSBhbGxvY2F0aW9u
IHBvbGljeSBmb3IKPiBnZng5IChzaW1pbGFyIHRvIGdmeDcvOCkuIFNlZSBpbmxpbmUgcmVwbHkg
aW4gdGhhdCB0aHJlYWQgZm9yIG1vcmUgZGV0YWlscwo+IG9uIHdoeSB0aGlzIHdhcyBza2lwcGVk
Lgo+Cj4KX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1k
LWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9s
aXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==
