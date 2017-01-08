From: Andy Furniss <adf.lists-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 4/4] drm/amd/powerplay: add profiling mode in dpm level
Date: Sun, 8 Jan 2017 20:18:24 +0000
Message-ID: <58729E90.3090506@gmail.com>
References: <1482482752-31020-1-git-send-email-Rex.Zhu@amd.com>
 <1482482752-31020-4-git-send-email-Rex.Zhu@amd.com>
 <CADnq5_P2GiXmoWnUiHipKQj-2VYT0sD72LoOScmmRua+_kQCXA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <CADnq5_P2GiXmoWnUiHipKQj-2VYT0sD72LoOScmmRua+_kQCXA-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
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
To: Alex Deucher <alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Rex Zhu <Rex.Zhu-5C7GfCeVMHo@public.gmane.org>
Cc: amd-gfx list <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

QWxleCBEZXVjaGVyIHdyb3RlOgo+IE9uIEZyaSwgRGVjIDIzLCAyMDE2IGF0IDM6NDUgQU0sIFJl
eCBaaHUgPFJleC5aaHVAYW1kLmNvbT4gd3JvdGU6Cj4+IENoYW5nZS1JZDogSTRhNDY0NDA4ODJj
ZDk0ZmU1ZTc3ZTNmMzUxYWFjY2MyMThhMmVjZTUKPgo+IFBhdGNoZXMgMS0zOgo+IFJldmlld2Vk
LWJ5OiBBbGV4IERldWNoZXIgPGFsZXhhbmRlci5kZXVjaGVyQGFtZC5jb20+Cj4KPiBwYXRjaCA0
Ogo+IFBsZWFzZSBhZGQgYSBiZXR0ZXIgcGF0Y2ggZGVzY3JpcHRpb24gYW5kIGV4cGxhaW4gd2hh
dCBwcm9maWxpbmcgbW9kZQo+IGlzIGdvb2QgZm9yLCBldGMuCgpUaGlzIG9uIGRybS1uZXh0LTQu
MTAtd2lwIHJlZ3Jlc3NlcyBzZXR0aW5nIHByb2ZpbGUgYSBiaXQgb24gUjkyODUuCgpJdCB3b3Jr
cyBlZy4gaWYgaW4gYXV0byB0aGVuIGRvaW5nCgplY2hvIGhpZ2ggPiAvc3lzL2NsYXNzL2RybS9j
YXJkMC9kZXZpY2UvcG93ZXJfZHBtX2ZvcmNlX3BlcmZvcm1hbmNlX2xldmVsCgppcyBPSyBhbmQg
ZWNobyBhdXRvICA+IC4uLiBpcyBhbHNvIE9LLgoKVGhlIGlzc3VlIGlmIEkgYW0gaW4gYXV0byBh
bmQgZWNobyBhdXRvID4gLi4uLiB0aGVuIEkgZG9uJ3QgZ2V0IG15CnByb21wdCBiYWNrLgoKZWNo
byBoaWdoIGZyb20gZWxzZXdoZXJlIHdpbGwgbWFrZSBpdCByZXR1cm4gLSBidXQgaXQgZG9lc24n
dCBzZXQgaGlnaC4KCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0
dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=
