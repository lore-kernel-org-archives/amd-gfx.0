From: Alex Deucher <alexdeucher@gmail.com>
Subject: Re: amdgpu hangs on boot or shutdown on AMD Raven Ridge CPU (Engineer
 Sample)
Date: Tue, 20 Feb 2018 09:18:30 -0500
Message-ID: <CADnq5_MLCJjdiJsa9xCYEf9wB9WN7Y=kPDs-eN9hDdFb+FNS8w@mail.gmail.com>
References: <CAB4CAweUBN=8pd8x4AfMHor3D-C+1HRgAiG=1Vc1ne8M-cV-og@mail.gmail.com>
 <d2de9e60-239c-86a5-16af-bf74fe20a53a@amd.com>
 <CAB4CAwfv6RYRRCbf886+j-omPcwqjbCLC-hxVy=y=Sc1q18-kQ@mail.gmail.com>
 <CAB4CAweBvmuCYat8fjczbUFO-qg8=rEpSi+SbYPwQ=Rqb9fncw@mail.gmail.com>
 <CAD8Lp44hREd-ttStnttbN_gJ1vbYbV8HtEEfAn0f6V7=dHdWwA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <dri-devel-bounces@lists.freedesktop.org>
In-Reply-To: <CAD8Lp44hREd-ttStnttbN_gJ1vbYbV8HtEEfAn0f6V7=dHdWwA@mail.gmail.com>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
To: Daniel Drake <drake@endlessm.com>
Cc: Chris Chiu <chiu@endlessm.com>, dri-devel <dri-devel@lists.freedesktop.org>, amd-gfx list <amd-gfx@lists.freedesktop.org>, "Deucher,
 Alexander" <alexander.deucher@amd.com>, Linux Upstreaming Team <linux@endlessm.com>
List-Id: amd-gfx.lists.freedesktop.org

T24gVHVlLCBGZWIgMjAsIDIwMTggYXQgMjoyNiBBTSwgRGFuaWVsIERyYWtlIDxkcmFrZUBlbmRs
ZXNzbS5jb20+IHdyb3RlOgo+IEhpLAo+Cj4+ID4+PiAgICAgV2UgYXJlIHdvcmtpbmcgd2l0aCBu
ZXcgbGFwdG9wcyB0aGF0IGhhdmUgdGhlIEFNRCBSYXZlbmwgUmlkZ2UKPj4gPj4+IGNoaXBzZXQg
d2l0aCB0aGlzIGAvcHJvYy9jcHVpbmZvYAo+PiA+Pj4gaHR0cHM6Ly9naXN0LmdpdGh1Yi5jb20v
bXNjaGl1NzcvYjA2ZGJhNTc0ZTg5YjlhMzBjZjRjNDUwZWFlYzQ5YmMKPj4gPj4+Cj4+ID4+PiAg
ICAgV2l0aCB0aGUgbGF0ZXN0IGtlcm5lbCA0LjE1LCB0aGVyZSdyZSBsb3RzIG9mIGRpZmZlcmVu
dAo+PiA+Pj4gcGFuaWNzL29vcHMgZHVyaW5nIGJvb3Qgc28gbm8gY2hhbmNlIHRvIGdldCBpbnRv
IFguIEl0IGFsc28gaGFwcGVucwo+PiA+Pj4gZHVyaW5nIHNodXRkb3duLiBUaGVuIEkgdHJpZWQg
dG8gYnVpbGQga2VybmVsIGZyb20KPj4gPj4+IGdpdDovL3Blb3BsZS5mcmVlZGVza3RvcC5vcmcv
fmFnZDVmL2xpbnV4IG9uIGJyYW5jaAo+PiA+Pj4gYW1kLXN0YWdpbmctZHJtLW5leHQgd2l0aCBo
ZWFkIG9uIGNvbW1pdCAiZHJtOiBGaXggdHJhaWxpbmcgc2VtaWNvbG9uIgo+PiA+Pj4gYW5kIHVw
ZGF0ZSB0aGUgbGludXgtZmlybXdhcmUuIFRoaW5ncyBzZWVtIHRvIGdldCBiZXR0ZXIsIG9ubHkg
MSBvb3BzCj4+ID4+PiBvYnNlcnZlZC4gSGVyZSdzIHRoZSBvb3BzCj4+ID4+PiBodHRwczovL2dp
c3QuZ2l0aHViLmNvbS9tc2NoaXU3Ny8xYTY4ZjI3MjcyYjI0Nzc1YjIwNDBhY2RiNDc0Y2RkMy4K
Pgo+IEl0IHNlZW1zIHRoYXQgd2UgYXJlIG5vdCBhbG9uZSBzZWVpbmcgYW1kZ3B1LWluZHVjZWQg
c3RhYmlsaXR5Cj4gcHJvYmxlbXMgb24gbXVsdGlwbGUgUmF2ZW4gUmlkZ2UgcGxhdGZvcm1zLgo+
IGh0dHBzOi8vd3d3LnBob3Jvbml4LmNvbS9zY2FuLnBocD9wYWdlPW5ld3NfaXRlbSZweD1BTUQt
UmF2ZW4tUmlkZ2UtTW9iby1MaW51eAo+Cj4gQU1ELCB3aGF0IGNhbiB3ZSBkbyB0byBoZWxwPwoK
UGxlYXNlIGZpbGUgYnVnczoKaHR0cHM6Ly9idWdzLmZyZWVkZXNrdG9wLm9yZwoKVGhhbmtzLAoK
QWxleAoKPgo+IFRoYW5rcyEKPiBEYW5pZWwKPiBfX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fXwo+IGRyaS1kZXZlbCBtYWlsaW5nIGxpc3QKPiBkcmktZGV2ZWxA
bGlzdHMuZnJlZWRlc2t0b3Aub3JnCj4gaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFp
bG1hbi9saXN0aW5mby9kcmktZGV2ZWwKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX18KZHJpLWRldmVsIG1haWxpbmcgbGlzdApkcmktZGV2ZWxAbGlzdHMuZnJl
ZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGlu
Zm8vZHJpLWRldmVsCg==
