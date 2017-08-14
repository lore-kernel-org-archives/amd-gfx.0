From: Oded Gabbay <oded.gabbay-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 17/19] drm/amdgpu: Remove hard-coded assumptions about
 compute pipes
Date: Mon, 14 Aug 2017 18:06:01 +0300
Message-ID: <CAFCwf11YNzHcWt_Fy052dcKXwzoQuGkWBHxVkh-pLBGqngBnQQ@mail.gmail.com>
References: <1502488589-30272-1-git-send-email-Felix.Kuehling@amd.com>
 <1502488589-30272-18-git-send-email-Felix.Kuehling@amd.com>
 <CAFCwf108X+f6+jehRvykPy0NPCnYa6uHjoVAXWDvoN+35h-N5A@mail.gmail.com>
 <0eec4793-c9fa-4dfb-c8d7-41995d20e738@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <0eec4793-c9fa-4dfb-c8d7-41995d20e738-5C7GfCeVMHo@public.gmane.org>
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
To: Felix Kuehling <felix.kuehling-5C7GfCeVMHo@public.gmane.org>
Cc: amd-gfx list <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

T24gTW9uLCBBdWcgMTQsIDIwMTcgYXQgNTo1MyBQTSwgRmVsaXggS3VlaGxpbmcgPGZlbGl4Lmt1
ZWhsaW5nQGFtZC5jb20+IHdyb3RlOgo+Cj4gT24gMjAxNy0wOC0xMyAwNDoyOSBBTSwgT2RlZCBH
YWJiYXkgd3JvdGU6Cj4gPiBPbiBTYXQsIEF1ZyAxMiwgMjAxNyBhdCAxMjo1NiBBTSwgRmVsaXgg
S3VlaGxpbmcgPEZlbGl4Lkt1ZWhsaW5nQGFtZC5jb20+IHdyb3RlOgo+ID4+IFJlbW92ZSBoYXJk
LWNvZGVkIGFzc3VtcHRpb24gdGhhdCB0aGUgZmlyc3QgY29tcHV0ZSBwaXBlIGlzCj4gPj4gcmVz
ZXJ2ZWQgZm9yIGFtZGdwdS4gUGlwZSAwIGFjdHVhbGx5IG1lYW5zIHBpcGUgMCBub3cuCj4gPj4K
PiA+IElmIEknbSBsb29raW5nIGF0IGFtZGdwdV9nZnhfY29tcHV0ZV9xdWV1ZV9hY3F1aXJlKCks
IGFtZGdwdSB0YWtlcyB0aGUKPiA+IGZpcnN0IHBpcGUsIHNvIHdvbid0IHRoaXMgY2hhbmdlIGNv
bGxpZGUgd2l0aCB0aGF0IGNvZGUgPwo+Cj4gYW1kZ3B1X2dmeF9jb21wdXRlX3F1ZXVlX2FjcXVp
cmUgbWFya3MgdGhlIHF1ZXVlcyBpdCdzIHVzaW5nIGluCj4gYWRldi0+Z2Z4Lm1lYy5xdWV1ZV9i
aXRtYXAuIGFtZGdwdV9hbWRrZmRfZGV2aWNlX2luaXQgdXNlcyB0aGF0IHRvCj4gaW5pdGlhbGl6
ZSB0aGUgcXVldWVfYml0bWFwIGluIGtnZDJrZmRfc2hhcmVkX3Jlc291cmNlcy4gU28gS0ZEIGlz
IG5vdAo+IGdvaW5nIHRvIHVzZSB0aGUgY29tcHV0ZSBxdWV1ZXMgcmVzZXJ2ZWQgYnkgYW1kZ3B1
Lgo+Cj4gQW5kcmVzIFJvZHJpZ3VleiBoYWQgYSBzZXJpZXMgb2YgY29tbWl0cyBhIGZldyBtb250
aHMgYWdvIHRvIGdlbmVyYWxpemUKPiB0aGUgY29tcHV0ZSBxdWV1ZSBhc3NpZ25tZW50IGJldHdl
ZW4gYW1kZ3B1IGFuZCBhbWRrZmQuIFRoZSBoYXJkIGNvZGVkCj4gYXNzdW1wdGlvbiB0aGF0IHBp
cGUwIGlzIHVzZWQgYnkgYW1kZ3B1IGdvZXMgYmFjayB0byBiZWZvcmUgQW5kcmVzJwo+IHBhdGNo
IHNlcmllcy4gSSB0aGluayBpdCB3YXMgb3Zlcmxvb2tlZCB3aGVuIEFuZHJlcyBtYWRlIGhpcyBj
aGFuZ2VzLgo+Cj4gUmVnYXJkcywKPiAgIEZlbGl4CgpvaywgdGhhbmtzLgoKVGhpcyBwYXRjaCBp
czoKUmV2aWV3ZWQtYnk6IE9kZWQgR2FiYmF5IDxvZGVkLmdhYmJheUBnbWFpbC5jb20+Cl9fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGlu
ZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRl
c2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=
