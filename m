From: Dave Airlie <airlied@gmail.com>
Subject: Re: The issue with page allocation 5.3 rc1-rc2 (seems drm culprit
 here)
Date: Mon, 5 Aug 2019 11:03:34 +1000
Message-ID: <CAPM=9tw5By7txR8UVriLxyveX0kff3aNNiMWCTjbVyk33wp5XQ@mail.gmail.com>
References: <CABXGCsNDYzcpDCM5P0fVWF30N+TMD62CXjv902z39mrCWULsjA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <dri-devel-bounces@lists.freedesktop.org>
In-Reply-To: <CABXGCsNDYzcpDCM5P0fVWF30N+TMD62CXjv902z39mrCWULsjA@mail.gmail.com>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
To: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>, "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Koenig,
 Christian" <Christian.Koenig@amd.com>, Harry Wentland <harry.wentland@amd.com>
Cc: Linux Memory Management List <linux-mm@kvack.org>, dri-devel <dri-devel@lists.freedesktop.org>, Linux List Kernel Mailing <linux-kernel@vger.kernel.org>, amd-gfx list <amd-gfx@lists.freedesktop.org>
List-Id: amd-gfx.lists.freedesktop.org

T24gTW9uLCA1IEF1ZyAyMDE5IGF0IDA4OjIzLCBNaWtoYWlsIEdhdnJpbG92CjxtaWtoYWlsLnYu
Z2F2cmlsb3ZAZ21haWwuY29tPiB3cm90ZToKPgo+IEhpIGZvbGtzLAo+IFR3byB3ZWVrcyBhZ28g
d2hlbiBjb21taXQgMjIwNTFkOWM0YTU3IGNvbWluZyB0byBteSBzeXN0ZW0uCj4gU3RhcnRlZCBo
YXBwZW4gcmFuZG9tbHkgZXJyb3JzOgo+ICJnbm9tZS1zaGVsbDogcGFnZSBhbGxvY2F0aW9uIGZh
aWx1cmU6IG9yZGVyOjQsCj4gbW9kZToweDQwY2MwKEdGUF9LRVJORUx8X19HRlBfQ09NUCksCj4g
bm9kZW1hc2s9KG51bGwpLGNwdXNldD0vLG1lbXNfYWxsb3dlZD0wIgo+IFN5bXB0b21zOgo+IFRo
ZSBzY3JlZW4gZ29lcyBvdXQgYXMgaW4gZW5lcmd5IHNhdmluZy4KPiBBbmQgaXQgaXMgaW1wb3Nz
aWJsZSB0byB3YWtlIHRoZSBjb21wdXRlciBpbiBhIGZldyBtaW51dGVzLgo+Cj4gSSBhbSBtYWtp
bmcgYmlzZWN0IGFuZCBsb29rcyBsaWtlIHRoZSBmaXJzdCBiYWQgY29tbWl0IGlzIDQ3NmU5NTVk
ZDY3OS4KPiBIZXJlIGZ1bGwgYmlzZWN0IGxvZ3M6IGh0dHBzOi8vbWVnYS5uei8jRiFrZ1lGeEFJ
YiF2MXRjSEFOUHkybnMxbGg0TFFMZUlnCj4KPiBJIHdyb3RlIGFib3V0IG15IGZpbmQgdG8gdGhl
IGFtZC1nZnggbWFpbGluZyBsaXN0LCBidXQgbm8gb25lIGFuc3dlciBtZS4KPiBVbnRpbCB5ZXN0
ZXJkYXksIEkgdGhvdWdodCBpdCB3YXMgYSBidWcgaW4gdGhlIGFtZGdwdSBkcml2ZXIuCj4gQnV0
IHllc3RlcmRheSwgYWZ0ZXIgdGhlIG5leHQgb2NjdXJyZW5jZSBvZiBhbiBlcnJvciwgdGhlIHN5
c3RlbSBoYW5ncwo+IGNvbXBsZXRlbHkgYWxyZWFkeSB3aXRoIGFub3RoZXIgZXJyb3IuCgpEb2Vz
IGl0IGhhcHBlbiBpZiB5b3UgZGlzYWJsZSBDT05GSUdfRFJNX0FNRF9EQ19EQ04yXzAsIEknbSBh
c3N1bWluZwp5b3UgZG9uJ3QgaGF2ZSBhIG5hdmkgZ3B1LgoKSSB0aGluayBzb21lIHN0cnVjdCBn
cmV3IHRvbyBsYXJnZSBpbiB0aGUgbmF2aSBtZXJnZSwgaG9wZWZ1bGx5IGFtZApjYXJlLCBlbHNl
IHdlIGhhdmUgdG8gZGlzYWJsZSBuYXZpIGJlZm9yZSByZWxlYXNlLgoKSSd2ZSBkaXJlY3RlZCB0
aGlzIGF0IHRoZSBtYWluIEFNRCBkZXZzIHdobyBtaWdodCBiZSBoZWxwZnVsLgoKRGF2ZS4KX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KZHJpLWRldmVsIG1h
aWxpbmcgbGlzdApkcmktZGV2ZWxAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMu
ZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vZHJpLWRldmVs
