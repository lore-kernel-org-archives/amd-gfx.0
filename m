From: Alex Deucher <alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: amdgpu hangs on boot or shutdown on AMD Raven Ridge CPU (Engineer
 Sample)
Date: Thu, 19 Apr 2018 18:13:16 -0400
Message-ID: <CADnq5_N=E+iABYXyYYShkoE5m06SMyJBeF8AaO=gStu=y_GoxA@mail.gmail.com>
References: <CAB4CAweUBN=8pd8x4AfMHor3D-C+1HRgAiG=1Vc1ne8M-cV-og@mail.gmail.com>
 <d2de9e60-239c-86a5-16af-bf74fe20a53a@amd.com>
 <CAB4CAwfv6RYRRCbf886+j-omPcwqjbCLC-hxVy=y=Sc1q18-kQ@mail.gmail.com>
 <CAB4CAweBvmuCYat8fjczbUFO-qg8=rEpSi+SbYPwQ=Rqb9fncw@mail.gmail.com>
 <CAD8Lp44hREd-ttStnttbN_gJ1vbYbV8HtEEfAn0f6V7=dHdWwA@mail.gmail.com>
 <CADnq5_MLCJjdiJsa9xCYEf9wB9WN7Y=kPDs-eN9hDdFb+FNS8w@mail.gmail.com>
 <CAD8Lp44vfd59L0UVMUuWRn7JNuib__E=NwWULc-3QPBk8W-GEA@mail.gmail.com>
 <CAD8Lp47TjX-aQShCiR-9EdMfYLXrKfDV+DanVEodEm2E-b5wiA@mail.gmail.com>
 <CAD8Lp46bb1t6yBv0Xo133Ow1KJ5KhR7mhDRu7Sp744PD+KKMNg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <CAD8Lp46bb1t6yBv0Xo133Ow1KJ5KhR7mhDRu7Sp744PD+KKMNg-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
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
To: drake <drake-6IF/jdPJHihWk0Htik3J/w@public.gmane.org>
Cc: Harry Wentland <harry.wentland-5C7GfCeVMHo@public.gmane.org>, Chris Chiu <chiu-6IF/jdPJHihWk0Htik3J/w@public.gmane.org>, dri-devel <dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, amd-gfx list <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, "Deucher,
 Alexander" <alexander.deucher-5C7GfCeVMHo@public.gmane.org>, Linux Upstreaming Team <linux-6IF/jdPJHihWk0Htik3J/w@public.gmane.org>

T24gVGh1LCBBcHIgMTksIDIwMTggYXQgNjowOCBQTSwgZHJha2UgPGRyYWtlQGVuZGxlc3NtLmNv
bT4gd3JvdGU6Cj4gT24gVHVlLCBBcHIgMywgMjAxOCBhdCAxMTozMSBBTSwgRGFuaWVsIERyYWtl
IDxkcmFrZUBlbmRsZXNzbS5jb20+IHdyb3RlOgo+PiBPbiBUaHUsIE1hciAyMiwgMjAxOCBhdCAz
OjA5IEFNLCBEYW5pZWwgRHJha2UgPGRyYWtlQGVuZGxlc3NtLmNvbT4gd3JvdGU6Cj4+PiBPbiBU
dWUsIEZlYiAyMCwgMjAxOCBhdCAxMDoxOCBQTSwgQWxleCBEZXVjaGVyIDxhbGV4ZGV1Y2hlckBn
bWFpbC5jb20+IHdyb3RlOgo+Pj4+PiBJdCBzZWVtcyB0aGF0IHdlIGFyZSBub3QgYWxvbmUgc2Vl
aW5nIGFtZGdwdS1pbmR1Y2VkIHN0YWJpbGl0eQo+Pj4+PiBwcm9ibGVtcyBvbiBtdWx0aXBsZSBS
YXZlbiBSaWRnZSBwbGF0Zm9ybXMuCj4+Pj4+IGh0dHBzOi8vd3d3LnBob3Jvbml4LmNvbS9zY2Fu
LnBocD9wYWdlPW5ld3NfaXRlbSZweD1BTUQtUmF2ZW4tUmlkZ2UtTW9iby1MaW51eAo+Pj4+Pgo+
Pj4+PiBBTUQsIHdoYXQgY2FuIHdlIGRvIHRvIGhlbHA/Cj4+Pj4KPj4+PiBQbGVhc2UgZmlsZSBi
dWdzOgo+Pj4+IGh0dHBzOi8vYnVncy5mcmVlZGVza3RvcC5vcmcKPj4+Cj4+PiBTb3JyeSBmb3Ig
dGhlIGRlbGF5ZWQgcmVzcG9uc2UuIFdlJ3JlIHN0aWxsIHNlZWluZyBzZXJpb3VzIGluc3RhYmls
aXR5Cj4+PiBoZXJlIGV2ZW4gb24gdGhlIGxhdGVzdCBrZXJuZWwuIEZpbGVkCj4+PiBodHRwczov
L2J1Z3MuZnJlZWRlc2t0b3Aub3JnL3Nob3dfYnVnLmNnaT9pZD0xMDU2ODQKPj4KPj4gTm8gcHJv
Z3Jlc3MgbWFkZSBvbiB0aGF0IGJ1ZyByZXBvcnQgc28gZmFyLgo+PiBXaGF0IGNhbiB3ZSBkbyB0
byBoZWxwIHRoaXMgYWR2YW5jZT8KPgo+IFBpbmcsIGFueSBuZXdzIGhlcmU/IEhvdyBjYW4gd2Ug
aGVscCBhZHZhbmNlIG9uIHRoaXMgYnVnPwoKQ2FuIHlvdSB0cnkgb25lIG9mIHRoZXNlIGJyYW5j
aGVzPwpodHRwczovL2NnaXQuZnJlZWRlc2t0b3Aub3JnL35hZ2Q1Zi9saW51eC9sb2cvP2g9YW1k
LXN0YWdpbmctZHJtLW5leHQKaHR0cHM6Ly9jZ2l0LmZyZWVkZXNrdG9wLm9yZy9+YWdkNWYvbGlu
dXgvbG9nLz9oPWRybS1uZXh0LTQuMTgtd2lwCmRvIHRoZXkgd29yayBhbnkgYmV0dGVyPwoKPgo+
IFRoYW5rcwo+IERhbmllbApfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9y
ZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZngK
