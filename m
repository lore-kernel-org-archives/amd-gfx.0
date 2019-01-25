From: Nick Desaulniers <ndesaulniers-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>
Subject: Re: [Linux-v4.18-rc6] modpost-errors when compiling with clang-7 and
 CONFIG_DRM_AMDGPU=m
Date: Fri, 25 Jan 2019 10:54:15 -0800
Message-ID: <CAKwvOdmyKkMCwRGo+RFf9PPaOS-jhFGp0cqAZc6o+O1MHw69ww@mail.gmail.com>
References: <CA+icZUVLStTzEM0UN8Z7ddnrfGYh3-VRcHAQ8ijE-PiB=FZrNQ@mail.gmail.com>
 <0e782eaa-f495-61a2-b30e-61057dcfc611@amd.com>
 <CA+icZUUx5PLK5W7o2b8kpNiGKB+cZYxmLP2kxFGHHBPCaRTptQ@mail.gmail.com>
 <CA+icZUWykGWAH1MVLEDh7LsSm0=icC-_pvuUq8NyoQwN50ny1Q@mail.gmail.com>
 <3d044858-9df0-d872-0df1-db3c9573b2a5@amd.com>
 <CA+icZUWu90v048Ps8WkQUtDnGh7vDwKEquGGz86OZ+7VfUf_Ow@mail.gmail.com>
 <54cdfdd5-d889-5714-263f-a663f8649d42@amd.com>
 <4734cf99-629b-31e9-57be-9cd884c47ae3@amd.com>
 <CA+icZUXQAdrKjy=Kug3_e9rN1OdAsgTERC8AA5g7YCK97rbX2g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <CA+icZUXQAdrKjy=Kug3_e9rN1OdAsgTERC8AA5g7YCK97rbX2g-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
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
To: sedat.dilek-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
Cc: "Deucher, Alexander" <Alexander.Deucher-5C7GfCeVMHo@public.gmane.org>, "Zhou,
 David(ChunMing)" <David1.Zhou-5C7GfCeVMHo@public.gmane.org>, "Wentland,
 Harry" <Harry.Wentland-5C7GfCeVMHo@public.gmane.org>, "Koenig,
 Christian" <Christian.Koenig-5C7GfCeVMHo@public.gmane.org>, "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

T24gRnJpLCBKYW4gMjUsIDIwMTkgYXQgODowNSBBTSBTZWRhdCBEaWxlayA8c2VkYXQuZGlsZWtA
Z21haWwuY29tPiB3cm90ZToKPgo+IE9uIEZyaSwgSmFuIDI1LCAyMDE5IGF0IDQ6MTUgUE0gV2Vu
dGxhbmQsIEhhcnJ5IDxIYXJyeS5XZW50bGFuZEBhbWQuY29tPiB3cm90ZToKPiA+Cj4gPiBPbiAy
MDE5LTAxLTI1IDM6MjUgYS5tLiwgS29lbmlnLCBDaHJpc3RpYW4gd3JvdGU6Cj4gPiA+IEFtIDI1
LjAxLjE5IHVtIDA4OjQyIHNjaHJpZWIgU2VkYXQgRGlsZWs6Cj4gPiA+PiBbIENDIE5pY2sgRC4g
XQo+ID4gPj4KPiA+ID4+IEhpIENocmlzdGlhbiwKPiA+ID4+Cj4gPiA+PiBOaWNrIGhhcyBwb3N0
ZWQgYSBmaXggaW4gWzJdLgo+ID4gPj4gSXMgdGhhdCBPSyBmb3IgeW91Pwo+ID4gPgo+ID4gPiBJ
J3ZlIHNlZW4gdGhhdCBhbmQgeWVhaCBJJ20gcGVyZmVjdGx5IGZpbmUgd2l0aCBpdCwgYnV0IEhh
cnJ5IGlzIHRoZSBvbmUKPiA+ID4gd2hvIG5lZWRzIHRvIGRlY2lkZS4KPiA+ID4KPiA+Cj4gPiBM
b29rcyBnb29kIHRvIG1lLgo+ID4KPiA+IFJldmlld2VkLWJ5OiBIYXJyeSBXZW50bGFuZCA8aGFy
cnkud2VudGxhbmRAYW1kLmNvbT4KPiA+Cj4gPiBBbmQgYXBwbGllZC4KPiA+Cj4KPiBUaGFua3Mu
Cj4KPiBDYW4geW91IHBvaW50IG1lIHRvIHRoZSBjb21taXQgYW5kIEdpdCB0cmVlPwoKSSBzdXNw
ZWN0IHRoZSB0cmVlIGl0IHdpbGwgYmUgcHVzaGVkIHRvIGlzOgpodHRwczovL2NnaXQuZnJlZWRl
c2t0b3Aub3JnL35hZ2Q1Zi9saW51eC8KQnV0IEkgc3VzcGVjdCBpdCBoYXMgbm90IGJlZW4gcHVz
aGVkIHlldC4KCi0tIApUaGFua3MsCn5OaWNrIERlc2F1bG5pZXJzCl9fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1n
ZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21h
aWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=
