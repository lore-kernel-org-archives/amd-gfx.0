From: Daniel Drake <drake@endlessm.com>
Subject: Re: amdgpu hangs on boot or shutdown on AMD Raven Ridge CPU (Engineer
 Sample)
Date: Tue, 20 Feb 2018 10:26:22 +0300
Message-ID: <CAD8Lp44hREd-ttStnttbN_gJ1vbYbV8HtEEfAn0f6V7=dHdWwA@mail.gmail.com>
References: <CAB4CAweUBN=8pd8x4AfMHor3D-C+1HRgAiG=1Vc1ne8M-cV-og@mail.gmail.com>
 <d2de9e60-239c-86a5-16af-bf74fe20a53a@amd.com>
 <CAB4CAwfv6RYRRCbf886+j-omPcwqjbCLC-hxVy=y=Sc1q18-kQ@mail.gmail.com>
 <CAB4CAweBvmuCYat8fjczbUFO-qg8=rEpSi+SbYPwQ=Rqb9fncw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <dri-devel-bounces@lists.freedesktop.org>
In-Reply-To: <CAB4CAweBvmuCYat8fjczbUFO-qg8=rEpSi+SbYPwQ=Rqb9fncw@mail.gmail.com>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
To: Harry Wentland <harry.wentland@amd.com>, "Deucher, Alexander" <alexander.deucher@amd.com>
Cc: Linux Upstreaming Team <linux@endlessm.com>, Chris Chiu <chiu@endlessm.com>, amd-gfx@lists.freedesktop.org, dri-devel <dri-devel@lists.freedesktop.org>
List-Id: amd-gfx.lists.freedesktop.org

SGksCgo+ID4+PiAgICAgV2UgYXJlIHdvcmtpbmcgd2l0aCBuZXcgbGFwdG9wcyB0aGF0IGhhdmUg
dGhlIEFNRCBSYXZlbmwgUmlkZ2UKPiA+Pj4gY2hpcHNldCB3aXRoIHRoaXMgYC9wcm9jL2NwdWlu
Zm9gCj4gPj4+IGh0dHBzOi8vZ2lzdC5naXRodWIuY29tL21zY2hpdTc3L2IwNmRiYTU3NGU4OWI5
YTMwY2Y0YzQ1MGVhZWM0OWJjCj4gPj4+Cj4gPj4+ICAgICBXaXRoIHRoZSBsYXRlc3Qga2VybmVs
IDQuMTUsIHRoZXJlJ3JlIGxvdHMgb2YgZGlmZmVyZW50Cj4gPj4+IHBhbmljcy9vb3BzIGR1cmlu
ZyBib290IHNvIG5vIGNoYW5jZSB0byBnZXQgaW50byBYLiBJdCBhbHNvIGhhcHBlbnMKPiA+Pj4g
ZHVyaW5nIHNodXRkb3duLiBUaGVuIEkgdHJpZWQgdG8gYnVpbGQga2VybmVsIGZyb20KPiA+Pj4g
Z2l0Oi8vcGVvcGxlLmZyZWVkZXNrdG9wLm9yZy9+YWdkNWYvbGludXggb24gYnJhbmNoCj4gPj4+
IGFtZC1zdGFnaW5nLWRybS1uZXh0IHdpdGggaGVhZCBvbiBjb21taXQgImRybTogRml4IHRyYWls
aW5nIHNlbWljb2xvbiIKPiA+Pj4gYW5kIHVwZGF0ZSB0aGUgbGludXgtZmlybXdhcmUuIFRoaW5n
cyBzZWVtIHRvIGdldCBiZXR0ZXIsIG9ubHkgMSBvb3BzCj4gPj4+IG9ic2VydmVkLiBIZXJlJ3Mg
dGhlIG9vcHMKPiA+Pj4gaHR0cHM6Ly9naXN0LmdpdGh1Yi5jb20vbXNjaGl1NzcvMWE2OGYyNzI3
MmIyNDc3NWIyMDQwYWNkYjQ3NGNkZDMuCgpJdCBzZWVtcyB0aGF0IHdlIGFyZSBub3QgYWxvbmUg
c2VlaW5nIGFtZGdwdS1pbmR1Y2VkIHN0YWJpbGl0eQpwcm9ibGVtcyBvbiBtdWx0aXBsZSBSYXZl
biBSaWRnZSBwbGF0Zm9ybXMuCmh0dHBzOi8vd3d3LnBob3Jvbml4LmNvbS9zY2FuLnBocD9wYWdl
PW5ld3NfaXRlbSZweD1BTUQtUmF2ZW4tUmlkZ2UtTW9iby1MaW51eAoKQU1ELCB3aGF0IGNhbiB3
ZSBkbyB0byBoZWxwPwoKVGhhbmtzIQpEYW5pZWwKX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX18KZHJpLWRldmVsIG1haWxpbmcgbGlzdApkcmktZGV2ZWxAbGlz
dHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4v
bGlzdGluZm8vZHJpLWRldmVsCg==
