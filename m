From: Felix Kuehling <felix.kuehling-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH 4/4] drm/amdkfd: Implement image tiling mode support
Date: Mon, 14 Aug 2017 11:18:33 -0400
Message-ID: <fc37f1a8-9c12-f1da-cdab-f03b50643f19@amd.com>
References: <1502513265-14281-1-git-send-email-Felix.Kuehling@amd.com>
 <1502513265-14281-5-git-send-email-Felix.Kuehling@amd.com>
 <CAFCwf10iQhAvxZdwCYBK6f0fBKdpgD=f0W886awm2fJVCB=hLQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <CAFCwf10iQhAvxZdwCYBK6f0fBKdpgD=f0W886awm2fJVCB=hLQ-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Content-Language: en-CA
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
To: Oded Gabbay <oded.gabbay-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Yong Zhao <yong.zhao-5C7GfCeVMHo@public.gmane.org>, amd-gfx list <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

T24gMjAxNy0wOC0xMyAwNTowOCBBTSwgT2RlZCBHYWJiYXkgd3JvdGU6Cj4gQXMgaW4gdGhlIHBy
ZXZpb3VzIHBhdGNoLCB0aGVyZSBpcyBhIGhvbGUgaGVyZSBpbiB0aGUgSU9DVExzCj4gbnVtYmVy
aW5nLiBJIHN1Z2dlc3QgdGhhdCB3aGVuIHlvdSB1cHN0cmVhbSBuZXcgSU9DVExzLCB5b3Ugd2ls
bCBwdXQKPiB0aGVtIGluIGNvbnNlY3V0aXZlIG51bWJlcnMgcGVyIHRoZSB1cHN0cmVhbSBkcml2
ZXIsIGFuZCB0aGVuIHRha2UKPiB0aGF0IGNoYW5nZSBkb3duc3RyZWFtIGJlY2F1c2UgeW91IGNh
biBlYXNpbHkgY2hhbmdlIGl0IGluIHlvdXIKPiBkcml2ZXIuCgpXZSBjYW4gZWFzaWx5IGNoYW5n
ZSBpdCBkb3duc3RyZWFtLCBidXQgaXQgbWFrZXMgaXQgaGFyZGVyIGZvciBwZW9wbGUgdG8KdGVz
dCB0aGUgbmV3IHVwc3RyZWFtIGtlcm5lbCB3aXRoIGFscmVhZHkgcmVsZWFzZWQgUk9DbSB1c2Vy
IG1vZGUKZHJpdmVycyB0aGF0IGFyZSBlYXN5IHRvIGluc3RhbGwgYW5kIHdpdGhvdXQgaGF2aW5n
IHRvIHdhaXQgYSBmZXcgd2Vla3MKZm9yIHRoZSBuZXh0IHJlbGVhc2UuCgpJZiB0ZXN0YWJpbGl0
eSBpcyBub3QgYSBwcmlvcml0eSwgdGhlbiBJJ2QgcmF0aGVyIHVwc3RyZWFtIHRoZSBuZXcKaW9j
dGxzIGluIHRoZSBvcmRlciBpbiB3aGljaCB3ZSBtYWRlIHRoZW0uIFRoZSBvbmx5IHJlYXNvbiBJ
J20gZ29pbmcKb3V0LW9mLW9yZGVyIGlzIHRvIG1ha2UgdGVzdGluZyBhcyBlYXN5IGFzIHBvc3Np
YmxlLCBhcyBlYXJseSBhcwpwb3NzaWJsZSwgd2l0aCB0aGUgbW9zdCByZWNlbnRseSByZWxlYXNl
ZCB1c2VyIG1vZGUgc3RhY2suCgpJdCdzIHlvdXIgY2FsbCwgdGhvdWdoLgoKUmVnYXJkcywKICBG
ZWxpeAoKPgo+IE9kZWQKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3Jn
Cmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=
