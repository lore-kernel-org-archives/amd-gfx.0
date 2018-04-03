From: Daniel Drake <drake-6IF/jdPJHihWk0Htik3J/w@public.gmane.org>
Subject: Re: amdgpu hangs on boot or shutdown on AMD Raven Ridge CPU (Engineer
 Sample)
Date: Tue, 3 Apr 2018 11:31:49 -0600
Message-ID: <CAD8Lp47TjX-aQShCiR-9EdMfYLXrKfDV+DanVEodEm2E-b5wiA@mail.gmail.com>
References: <CAB4CAweUBN=8pd8x4AfMHor3D-C+1HRgAiG=1Vc1ne8M-cV-og@mail.gmail.com>
 <d2de9e60-239c-86a5-16af-bf74fe20a53a@amd.com>
 <CAB4CAwfv6RYRRCbf886+j-omPcwqjbCLC-hxVy=y=Sc1q18-kQ@mail.gmail.com>
 <CAB4CAweBvmuCYat8fjczbUFO-qg8=rEpSi+SbYPwQ=Rqb9fncw@mail.gmail.com>
 <CAD8Lp44hREd-ttStnttbN_gJ1vbYbV8HtEEfAn0f6V7=dHdWwA@mail.gmail.com>
 <CADnq5_MLCJjdiJsa9xCYEf9wB9WN7Y=kPDs-eN9hDdFb+FNS8w@mail.gmail.com>
 <CAD8Lp44vfd59L0UVMUuWRn7JNuib__E=NwWULc-3QPBk8W-GEA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <CAD8Lp44vfd59L0UVMUuWRn7JNuib__E=NwWULc-3QPBk8W-GEA-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
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
To: Alex Deucher <alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Harry Wentland <harry.wentland-5C7GfCeVMHo@public.gmane.org>, Chris Chiu <chiu-6IF/jdPJHihWk0Htik3J/w@public.gmane.org>, dri-devel <dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, amd-gfx list <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, "Deucher,
 Alexander" <alexander.deucher-5C7GfCeVMHo@public.gmane.org>, Linux Upstreaming Team <linux-6IF/jdPJHihWk0Htik3J/w@public.gmane.org>

T24gVGh1LCBNYXIgMjIsIDIwMTggYXQgMzowOSBBTSwgRGFuaWVsIERyYWtlIDxkcmFrZUBlbmRs
ZXNzbS5jb20+IHdyb3RlOgo+IE9uIFR1ZSwgRmViIDIwLCAyMDE4IGF0IDEwOjE4IFBNLCBBbGV4
IERldWNoZXIgPGFsZXhkZXVjaGVyQGdtYWlsLmNvbT4gd3JvdGU6Cj4+PiBJdCBzZWVtcyB0aGF0
IHdlIGFyZSBub3QgYWxvbmUgc2VlaW5nIGFtZGdwdS1pbmR1Y2VkIHN0YWJpbGl0eQo+Pj4gcHJv
YmxlbXMgb24gbXVsdGlwbGUgUmF2ZW4gUmlkZ2UgcGxhdGZvcm1zLgo+Pj4gaHR0cHM6Ly93d3cu
cGhvcm9uaXguY29tL3NjYW4ucGhwP3BhZ2U9bmV3c19pdGVtJnB4PUFNRC1SYXZlbi1SaWRnZS1N
b2JvLUxpbnV4Cj4+Pgo+Pj4gQU1ELCB3aGF0IGNhbiB3ZSBkbyB0byBoZWxwPwo+Pgo+PiBQbGVh
c2UgZmlsZSBidWdzOgo+PiBodHRwczovL2J1Z3MuZnJlZWRlc2t0b3Aub3JnCj4KPiBTb3JyeSBm
b3IgdGhlIGRlbGF5ZWQgcmVzcG9uc2UuIFdlJ3JlIHN0aWxsIHNlZWluZyBzZXJpb3VzIGluc3Rh
YmlsaXR5Cj4gaGVyZSBldmVuIG9uIHRoZSBsYXRlc3Qga2VybmVsLiBGaWxlZAo+IGh0dHBzOi8v
YnVncy5mcmVlZGVza3RvcC5vcmcvc2hvd19idWcuY2dpP2lkPTEwNTY4NAoKTm8gcHJvZ3Jlc3Mg
bWFkZSBvbiB0aGF0IGJ1ZyByZXBvcnQgc28gZmFyLgpXaGF0IGNhbiB3ZSBkbyB0byBoZWxwIHRo
aXMgYWR2YW5jZT8KClRoYW5rcywKRGFuaWVsCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJl
ZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGlu
Zm8vYW1kLWdmeAo=
