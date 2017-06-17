From: Dave Airlie <airlied-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 5/5] amdgpu: use drm sync objects for shared semaphores
 (v5)
Date: Sat, 17 Jun 2017 11:23:32 +1000
Message-ID: <CAPM=9tzGUPuOB_wOBu+DKucMmXqv7XCrdc02BV_hAqrPwZm=Jg@mail.gmail.com>
References: <20170601010643.28616-1-airlied@gmail.com>
 <20170601010643.28616-6-airlied@gmail.com>
 <CAPM=9twtavgA+D+vgZYz7UagnjxX6pGFBBUycCs2ofGjhOcBrw@mail.gmail.com>
 <e8021851-d630-3cbd-40e2-58f83a366a29@vodafone.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <e8021851-d630-3cbd-40e2-58f83a366a29-ANTagKRnAhcb1SvskN2V4Q@public.gmane.org>
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
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <deathsimple-ANTagKRnAhcb1SvskN2V4Q@public.gmane.org>
Cc: amd-gfx mailing list <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, dri-devel <dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

PiB0ZWFtIHdoaWNoIHNlZW0gdG8gbWFrZSBhIGxvdCBvZiBzZW5zZSB0byB1cHN0cmVhbSBhcyB3
ZWxsOgo+Cj4gMS4gQW4gSU9DVEwgdG8gcmVzZXQgYSBzeW5jIG9iamVjdCB0byBpdCdzIGluaXRp
YWwgc3RhdGUuIEUuZy4gcmVzZXQgdGhlCj4gZmVuY2UgdGhlIHN5bmMgb2JqZWN0cyB3cmFwcyBi
YWNrIHRvIE5VTEwuCj4KPiAyLiBUaGUgYWJpbGl0eSB0byBtZXJnZSBtdWx0aXBsZSBzeW5jIG9i
amVjdHMgaW50byBvbmUuIEVzc2VudGlhbGx5IHRoZSBzYW1lCj4gdGhpbmcgd2UgaGF2ZSBmb3Ig
dGhlIHN5bmMgZmlsZSwgYnV0IGhhbmRsZSBiYXNlZCBpbnN0ZWFkIG9mIGZkLgo+Cj4gSSdtIGdv
aW5nIHRvIHdvcmsgb24gdGhhdCBpbiB0aGUgbmV4dCB3ZWVrIG9yIHNvLiBTaG91bGRuJ3QgYmUg
dG8gbXVjaCBvZiBhCj4gcHJvYmxlbSB0byBjb21lIHVwIHdpdGggc29tZSBzYW5lIGNvZGUsIGJ1
dCBwcm9iYWJseSBmaW5kaW5nIHVzZSBjYXNlcyBmb3IKPiB0aGlzIGluIHRoZSBvcGVuIHNvdXJj
ZSB1c2Vyc3BhY2UgbWlnaHQgYmUgY2hhbGxlbmdpbmcuCgpEbyB3ZSBoYXZlIHVzZSBjYXNlcyBm
b3IgdGhlc2UgaW4gdGhlIGNsb3NlZCBzb3VyY2Ugc3RhY2s/IEknbSBzdXJlIGlmIHRoZXkgYXJl
CnVzZWZ1bCBlbm91Z2gsIHJhZHYgY291bGQgdXNlIHRoZW0gZm9yIHNpbWlsaWFyIHRoaW5ncy4K
CkRhdmUuCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFt
ZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8v
bGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=
