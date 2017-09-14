From: Emil Velikov <emil.l.velikov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 1/3] drm/syncobj: extract two helpers from
 drm_syncobj_create
Date: Thu, 14 Sep 2017 09:01:09 +0100
Message-ID: <CACvgo51-pfQJgas_VhVv3gyp7DDAQfAtpb6pxNN7c54xDc46wQ@mail.gmail.com>
References: <1505248934-1819-1-git-send-email-maraeo@gmail.com>
 <CACvgo50uprnZZ_+wXLH59Knq2SUCZwoFsyYH6ydcNJQ9Eiaw3A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <CACvgo50uprnZZ_+wXLH59Knq2SUCZwoFsyYH6ydcNJQ9Eiaw3A-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
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
Cc: amd-gfx mailing list <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, ML dri-devel <dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

T24gMTQgU2VwdGVtYmVyIDIwMTcgYXQgMDg6NTYsIEVtaWwgVmVsaWtvdiA8ZW1pbC5sLnZlbGlr
b3ZAZ21haWwuY29tPiB3cm90ZToKPiBIaSBNYXJlaywKPgo+IE9uIDEyIFNlcHRlbWJlciAyMDE3
IGF0IDIxOjQyLCBNYXJlayBPbMWhw6FrIDxtYXJhZW9AZ21haWwuY29tPiB3cm90ZToKPgo+PiAg
aW5jbHVkZS9kcm0vZHJtX3N5bmNvYmouaCAgICAgfCAgNCArKysrCj4gUGxlYXNlIHN5bmMgdGhl
IGhlYWRlciBhcyBkZXNjcmliZWQgaW4KPiBodHRwczovL2NnaXQuZnJlZWRlc2t0b3Aub3JnL21l
c2EvZHJtL3RyZWUvaW5jbHVkZS9kcm0vUkVBRE1FI243Mgo+Cj4gVGw7RFI6IGNkIC4uLi9saW51
eDsgbWFrZSBoZWFkZXJzX2luc3RhbGw7IGNwIC4uLiAuLi4vZHJtL2luY2x1ZGUvZHJtOwo+IGNk
IC4uLi9kcm07IGdpdCBjb21taXQgLXNtICIuLi4uICRicmFuY2ggJHNoYTEuLi4iCj4KU2VlbXMg
bGlrZSBJJ3ZlIHJlcGxpZWQgdG8gdGhlIHdyb25nIHBhdGNoIC0gc2lsbHkgbWUuClRoaXMgd2Fz
IG1lYW50IGZvciB0aGUgbGliZHJtIG9uZXMgLSBzdWdnZXN0aW9uIHN0aWxsIGFwcGxpZXMgdGhv
dWdoLgoKLUVtaWwKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0
cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==
