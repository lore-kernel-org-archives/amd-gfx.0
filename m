From: Daniel Drake <drake-6IF/jdPJHihWk0Htik3J/w@public.gmane.org>
Subject: Re: amdgpu hangs on boot or shutdown on AMD Raven Ridge CPU (Engineer
 Sample)
Date: Tue, 8 May 2018 12:19:52 -0600
Message-ID: <CAD8Lp46geDAW0LCiZ8V_LLJoNH2DsQOL9DJb-NxsSfa4rdBojg@mail.gmail.com>
References: <CAB4CAweUBN=8pd8x4AfMHor3D-C+1HRgAiG=1Vc1ne8M-cV-og@mail.gmail.com>
 <d2de9e60-239c-86a5-16af-bf74fe20a53a@amd.com>
 <CAB4CAwfv6RYRRCbf886+j-omPcwqjbCLC-hxVy=y=Sc1q18-kQ@mail.gmail.com>
 <CAB4CAweBvmuCYat8fjczbUFO-qg8=rEpSi+SbYPwQ=Rqb9fncw@mail.gmail.com>
 <CAD8Lp44hREd-ttStnttbN_gJ1vbYbV8HtEEfAn0f6V7=dHdWwA@mail.gmail.com>
 <CADnq5_MLCJjdiJsa9xCYEf9wB9WN7Y=kPDs-eN9hDdFb+FNS8w@mail.gmail.com>
 <CAD8Lp44vfd59L0UVMUuWRn7JNuib__E=NwWULc-3QPBk8W-GEA@mail.gmail.com>
 <CAD8Lp47TjX-aQShCiR-9EdMfYLXrKfDV+DanVEodEm2E-b5wiA@mail.gmail.com>
 <CAD8Lp46bb1t6yBv0Xo133Ow1KJ5KhR7mhDRu7Sp744PD+KKMNg@mail.gmail.com>
 <CADnq5_N=E+iABYXyYYShkoE5m06SMyJBeF8AaO=gStu=y_GoxA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <CADnq5_N=E+iABYXyYYShkoE5m06SMyJBeF8AaO=gStu=y_GoxA-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
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

V0hpIEFsZXgsCgpPbiBUaHUsIEFwciAxOSwgMjAxOCBhdCA0OjEzIFBNLCBBbGV4IERldWNoZXIg
PGFsZXhkZXVjaGVyQGdtYWlsLmNvbT4gd3JvdGU6Cj4+Pj4gaHR0cHM6Ly9idWdzLmZyZWVkZXNr
dG9wLm9yZy9zaG93X2J1Zy5jZ2k/aWQ9MTA1Njg0Cj4+Pgo+Pj4gTm8gcHJvZ3Jlc3MgbWFkZSBv
biB0aGF0IGJ1ZyByZXBvcnQgc28gZmFyLgo+Pj4gV2hhdCBjYW4gd2UgZG8gdG8gaGVscCB0aGlz
IGFkdmFuY2U/Cj4+Cj4+IFBpbmcsIGFueSBuZXdzIGhlcmU/IEhvdyBjYW4gd2UgaGVscCBhZHZh
bmNlIG9uIHRoaXMgYnVnPwo+Cj4gQ2FuIHlvdSB0cnkgb25lIG9mIHRoZXNlIGJyYW5jaGVzPwo+
IGh0dHBzOi8vY2dpdC5mcmVlZGVza3RvcC5vcmcvfmFnZDVmL2xpbnV4L2xvZy8/aD1hbWQtc3Rh
Z2luZy1kcm0tbmV4dAo+IGh0dHBzOi8vY2dpdC5mcmVlZGVza3RvcC5vcmcvfmFnZDVmL2xpbnV4
L2xvZy8/aD1kcm0tbmV4dC00LjE4LXdpcAo+IGRvIHRoZXkgd29yayBhbnkgYmV0dGVyPwoKSXQn
cyBiZWVuIG92ZXIgMyBtb250aHMgc2luY2Ugd2UgcmVwb3J0ZWQgdGhpcyBidWcgYnkgZW1haWws
IG92ZXIgNgp3ZWVrcyBzaW5jZSB3ZSByZXBvcnRlZCBpdCBvbiBidWd6aWxsYSwgYW5kIHN0aWxs
IHRoZXJlIGhhcyBiZWVuIG5vCm1lYW5pbmdmdWwgZGlhZ25vc3RpY3MgaGVscCBmcm9tIEFNRC4g
VGhpcyBmb2xsb3dzIGEgc2ltaWxhciBwYXR0ZXJuCnRvIHdoYXQgd2UgaGF2ZSBzZWVuIHdpdGgg
b3RoZXIgaXNzdWVzIHByaW9yIHRvIHRoaXMgb25lLgoKV2hhdCBjYW4gd2UgZG8gc28gdGhhdCB0
aGlzIGJ1ZyBnZXRzIHNvbWUgYXR0ZW50aW9uIGZyb20geW91ciB0ZWFtPwoKU2Vjb25kYXJpbHkg
aHR0cHM6Ly9idWdzLmZyZWVkZXNrdG9wLm9yZy9zaG93X2J1Zy5jZ2k/aWQ9MTA2MjI4IGlzCmFu
b3RoZXIgYnVnIHRoYXQgbmVlZHMgYXR0ZW50aW9uLiBXZSBoYXZlIGEgZ3Jvd2luZyBudW1iZXIg
b2YgY29uc3VtZXIKcGxhdGZvcm1zIGFmZmVjdGVkIGJ5IHRoaXMuIFdoZW4gYm9vdGVkLCB0aGUg
YW1kZ3B1IHNjcmVlbiBicmlnaHRuZXNzCnZhbHVlIGlzIGluY29ycmVjdGx5IHJlYWQgYmFjayBh
cyAwLCB3aGljaCBzeXN0ZW1kIHdpbGwgdGhlbiBzdG9yZSBvbgpzaHV0ZG93bi4gT24gbmV4dCBi
b290LCBpdCByZXN0b3JlcyB0aGUgdmVyeSBsb3cgYnJpZ2h0bmVzcyBsZXZlbC4KVGhpcyBjYW4g
cmVwcm9kdWNlIG91dCBvZiB0aGUgYm94IG9uIEZlZG9yYSwgVWJ1bnR1LCBldGMuCgpUaGFua3Ms
CkRhbmllbApfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwph
bWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczov
L2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZngK
