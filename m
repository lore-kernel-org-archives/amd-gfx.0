From: =?UTF-8?B?TWFyZWsgT2zFocOhaw==?= <maraeo-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 1/3] drm/syncobj: extract two helpers from
 drm_syncobj_create
Date: Fri, 29 Sep 2017 00:06:23 +0200
Message-ID: <CAAxE2A6pcMAti47AL7f3F_2o3PKjATZeGwQekbqqu2Yzk7E8NA@mail.gmail.com>
References: <1505248934-1819-1-git-send-email-maraeo@gmail.com>
 <CACvgo50uprnZZ_+wXLH59Knq2SUCZwoFsyYH6ydcNJQ9Eiaw3A@mail.gmail.com>
 <CACvgo51-pfQJgas_VhVv3gyp7DDAQfAtpb6pxNN7c54xDc46wQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <CACvgo51-pfQJgas_VhVv3gyp7DDAQfAtpb6pxNN7c54xDc46wQ-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
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
Cc: amd-gfx mailing list <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, ML dri-devel <dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

T24gVGh1LCBTZXAgMTQsIDIwMTcgYXQgMTA6MDEgQU0sIEVtaWwgVmVsaWtvdiA8ZW1pbC5sLnZl
bGlrb3ZAZ21haWwuY29tPiB3cm90ZToKPiBPbiAxNCBTZXB0ZW1iZXIgMjAxNyBhdCAwODo1Niwg
RW1pbCBWZWxpa292IDxlbWlsLmwudmVsaWtvdkBnbWFpbC5jb20+IHdyb3RlOgo+PiBIaSBNYXJl
aywKPj4KPj4gT24gMTIgU2VwdGVtYmVyIDIwMTcgYXQgMjE6NDIsIE1hcmVrIE9sxaHDoWsgPG1h
cmFlb0BnbWFpbC5jb20+IHdyb3RlOgo+Pgo+Pj4gIGluY2x1ZGUvZHJtL2RybV9zeW5jb2JqLmgg
ICAgIHwgIDQgKysrKwo+PiBQbGVhc2Ugc3luYyB0aGUgaGVhZGVyIGFzIGRlc2NyaWJlZCBpbgo+
PiBodHRwczovL2NnaXQuZnJlZWRlc2t0b3Aub3JnL21lc2EvZHJtL3RyZWUvaW5jbHVkZS9kcm0v
UkVBRE1FI243Mgo+Pgo+PiBUbDtEUjogY2QgLi4uL2xpbnV4OyBtYWtlIGhlYWRlcnNfaW5zdGFs
bDsgY3AgLi4uIC4uLi9kcm0vaW5jbHVkZS9kcm07Cj4+IGNkIC4uLi9kcm07IGdpdCBjb21taXQg
LXNtICIuLi4uICRicmFuY2ggJHNoYTEuLi4iCj4+Cj4gU2VlbXMgbGlrZSBJJ3ZlIHJlcGxpZWQg
dG8gdGhlIHdyb25nIHBhdGNoIC0gc2lsbHkgbWUuCj4gVGhpcyB3YXMgbWVhbnQgZm9yIHRoZSBs
aWJkcm0gb25lcyAtIHN1Z2dlc3Rpb24gc3RpbGwgYXBwbGllcyB0aG91Z2guCgpJIGFjdHVhbGx5
IGRpZCB0aGF0LCBidXQgSSdtIG9uIGFtZC1zdGFnaW5nLWRybS1uZXh0LgoKTWFyZWsKX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5n
IGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVz
a3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==
