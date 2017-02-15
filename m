From: Harry Wentland <harry.wentland-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH] drm/amd/display: Fix 64-bit division, yet again
Date: Wed, 15 Feb 2017 09:47:05 -0500
Message-ID: <2fa226e0-6765-404c-af71-3b0c9d146e90@amd.com>
References: <20170214203648.24212-1-harry.wentland@amd.com>
 <CACvgo50e-sETxPcsHsn6HZu2_oaD2aSE9pFXcJK9wEH5eKS1MA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <CACvgo50e-sETxPcsHsn6HZu2_oaD2aSE9pFXcJK9wEH5eKS1MA-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
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

T24gMjAxNy0wMi0xNSAwNjo0NCBBTSwgRW1pbCBWZWxpa292IHdyb3RlOgo+IE9uIDE0IEZlYnJ1
YXJ5IDIwMTcgYXQgMjA6MzYsIEhhcnJ5IFdlbnRsYW5kIDxoYXJyeS53ZW50bGFuZEBhbWQuY29t
PiB3cm90ZToKPj4gQWxzbyBtYWtlIHRoZSBjb2RlIHNvbWV3aGF0IG1vcmUgcmVhZGFibGUuCj4+
Cj4gSSdkIHN1Z2dlc3QgcmVhY2hpbmcgdG8gdGhlIHRlYW0gdG8gaW50ZWdyYXRlIHNjcmlwdHMv
Y2hlY2twYXRjaC5wbCBpbgo+IHRoZSBwcmUtY29tbWl0IGhvb2suCj4KPiBJdCB3aWxsIGhlbHAg
eW91IGltcHJvdmUgdGhlIGNvZGluZyBzdGFuZGFyZCBhbmQsIGFzIHlvdSBtZW50aW9uZWQsIGl0
Cj4gIm1ha2Vbc10gdGhlIGNvZGUgc29tZXdoYXQgbW9yZSByZWFkYWJsZSIuCj4KClRoYW5rcywg
RW1pbC4gV2UgYWN0dWFsbHkgaGF2ZSB0aGF0IGhvb2tlZCB1cCBhdCBwcmUtc3VibWlzc2lvbiBp
biBvdXIgCmludGVybmFsIHJlcG8gYnV0IGRvbid0IGJsb2NrIHN1Ym1pc3Npb24gb24gd2Fybmlu
Z3MgYW5kIGFsbG93IGEgY291cGxlIApwZW9wbGUgdG8gcHVzaCBhbnl3YXlzIGRlc3BpdGUgZXJy
b3JzIGJlY2F1c2Ugd2Ugc2VlbSB0byBnZXQgc29tZSAKdW5uZWNlc3NhcnkgZXJyb3JzIG9uIGNv
bXBsZXggbWFjcm9zIHRoYXQgY2FuJ3QgcmVhbGx5IGJlIGhhbmRsZWQgCmRpZmZlcmVudGx5LgoK
TmVlZCB0byB0aGluayBvbiBob3cgdG8gaW1wcm92ZSB0aGF0LiBJdCdzIGEgcGFpbiBiZWluZyB0
aGUgYmFkIGd1eSAKY29uc3RhbnRseSBhbmQgcGVvcGxlIGRvbid0IGFsd2F5cyBzZWUgdGhlIGlt
cG9ydGFuY2Ugb2YgZ29vZCBjb2RpbmcgYW5kIApjb21taXQgbXNnIHN0eWxlLgoKSGFycnkKCj4g
LUVtaWwKPgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwph
bWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczov
L2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZngK
