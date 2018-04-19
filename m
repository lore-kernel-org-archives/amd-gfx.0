From: drake <drake@endlessm.com>
Subject: Re: amdgpu hangs on boot or shutdown on AMD Raven Ridge CPU (Engineer
 Sample)
Date: Thu, 19 Apr 2018 16:08:14 -0600
Message-ID: <CAD8Lp46bb1t6yBv0Xo133Ow1KJ5KhR7mhDRu7Sp744PD+KKMNg@mail.gmail.com>
References: <CAB4CAweUBN=8pd8x4AfMHor3D-C+1HRgAiG=1Vc1ne8M-cV-og@mail.gmail.com>
 <d2de9e60-239c-86a5-16af-bf74fe20a53a@amd.com>
 <CAB4CAwfv6RYRRCbf886+j-omPcwqjbCLC-hxVy=y=Sc1q18-kQ@mail.gmail.com>
 <CAB4CAweBvmuCYat8fjczbUFO-qg8=rEpSi+SbYPwQ=Rqb9fncw@mail.gmail.com>
 <CAD8Lp44hREd-ttStnttbN_gJ1vbYbV8HtEEfAn0f6V7=dHdWwA@mail.gmail.com>
 <CADnq5_MLCJjdiJsa9xCYEf9wB9WN7Y=kPDs-eN9hDdFb+FNS8w@mail.gmail.com>
 <CAD8Lp44vfd59L0UVMUuWRn7JNuib__E=NwWULc-3QPBk8W-GEA@mail.gmail.com>
 <CAD8Lp47TjX-aQShCiR-9EdMfYLXrKfDV+DanVEodEm2E-b5wiA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <dri-devel-bounces@lists.freedesktop.org>
In-Reply-To: <CAD8Lp47TjX-aQShCiR-9EdMfYLXrKfDV+DanVEodEm2E-b5wiA@mail.gmail.com>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
To: Alex Deucher <alexdeucher@gmail.com>
Cc: Chris Chiu <chiu@endlessm.com>, dri-devel <dri-devel@lists.freedesktop.org>, amd-gfx list <amd-gfx@lists.freedesktop.org>, "Deucher,
 Alexander" <alexander.deucher@amd.com>, Linux Upstreaming Team <linux@endlessm.com>
List-Id: amd-gfx.lists.freedesktop.org

T24gVHVlLCBBcHIgMywgMjAxOCBhdCAxMTozMSBBTSwgRGFuaWVsIERyYWtlIDxkcmFrZUBlbmRs
ZXNzbS5jb20+IHdyb3RlOgo+IE9uIFRodSwgTWFyIDIyLCAyMDE4IGF0IDM6MDkgQU0sIERhbmll
bCBEcmFrZSA8ZHJha2VAZW5kbGVzc20uY29tPiB3cm90ZToKPj4gT24gVHVlLCBGZWIgMjAsIDIw
MTggYXQgMTA6MTggUE0sIEFsZXggRGV1Y2hlciA8YWxleGRldWNoZXJAZ21haWwuY29tPiB3cm90
ZToKPj4+PiBJdCBzZWVtcyB0aGF0IHdlIGFyZSBub3QgYWxvbmUgc2VlaW5nIGFtZGdwdS1pbmR1
Y2VkIHN0YWJpbGl0eQo+Pj4+IHByb2JsZW1zIG9uIG11bHRpcGxlIFJhdmVuIFJpZGdlIHBsYXRm
b3Jtcy4KPj4+PiBodHRwczovL3d3dy5waG9yb25peC5jb20vc2Nhbi5waHA/cGFnZT1uZXdzX2l0
ZW0mcHg9QU1ELVJhdmVuLVJpZGdlLU1vYm8tTGludXgKPj4+Pgo+Pj4+IEFNRCwgd2hhdCBjYW4g
d2UgZG8gdG8gaGVscD8KPj4+Cj4+PiBQbGVhc2UgZmlsZSBidWdzOgo+Pj4gaHR0cHM6Ly9idWdz
LmZyZWVkZXNrdG9wLm9yZwo+Pgo+PiBTb3JyeSBmb3IgdGhlIGRlbGF5ZWQgcmVzcG9uc2UuIFdl
J3JlIHN0aWxsIHNlZWluZyBzZXJpb3VzIGluc3RhYmlsaXR5Cj4+IGhlcmUgZXZlbiBvbiB0aGUg
bGF0ZXN0IGtlcm5lbC4gRmlsZWQKPj4gaHR0cHM6Ly9idWdzLmZyZWVkZXNrdG9wLm9yZy9zaG93
X2J1Zy5jZ2k/aWQ9MTA1Njg0Cj4KPiBObyBwcm9ncmVzcyBtYWRlIG9uIHRoYXQgYnVnIHJlcG9y
dCBzbyBmYXIuCj4gV2hhdCBjYW4gd2UgZG8gdG8gaGVscCB0aGlzIGFkdmFuY2U/CgpQaW5nLCBh
bnkgbmV3cyBoZXJlPyBIb3cgY2FuIHdlIGhlbHAgYWR2YW5jZSBvbiB0aGlzIGJ1Zz8KClRoYW5r
cwpEYW5pZWwKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18K
ZHJpLWRldmVsIG1haWxpbmcgbGlzdApkcmktZGV2ZWxAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0
dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vZHJpLWRldmVsCg==
