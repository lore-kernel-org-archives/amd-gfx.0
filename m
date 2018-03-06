From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
Subject: Re: [PATCH 1/5] drm/prime: fix potential race in drm_gem_map_detach
Date: Tue, 6 Mar 2018 10:30:56 +0100
Message-ID: <ef1876c3-68e7-fa20-380f-6d9e57394de1@gmail.com>
References: <20180227115000.4105-1-christian.koenig@amd.com>
 <1519811307.6253.5.camel@pengutronix.de>
 <3a4f9020-235d-ef05-a246-1ba920070f09@gmail.com>
 <20180306091541.GK22212@phenom.ffwll.local>
Reply-To: christian.koenig@amd.com
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <dri-devel-bounces@lists.freedesktop.org>
In-Reply-To: <20180306091541.GK22212@phenom.ffwll.local>
Content-Language: en-US
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
To: Daniel Vetter <daniel@ffwll.ch>, christian.koenig@amd.com
Cc: dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org
List-Id: amd-gfx.lists.freedesktop.org

QW0gMDYuMDMuMjAxOCB1bSAxMDoxNSBzY2hyaWViIERhbmllbCBWZXR0ZXI6Cj4gT24gV2VkLCBG
ZWIgMjgsIDIwMTggYXQgMTE6MjU6NTlBTSArMDEwMCwgQ2hyaXN0aWFuIEvDtm5pZyB3cm90ZToK
Pj4gQW0gMjguMDIuMjAxOCB1bSAxMDo0OCBzY2hyaWViIEx1Y2FzIFN0YWNoOgo+Pj4gSGkgQ2hy
aXN0aWFuLAo+Pj4KPj4+IEFtIERpZW5zdGFnLCBkZW4gMjcuMDIuMjAxOCwgMTI6NDkgKzAxMDAg
c2NocmllYiBDaHJpc3RpYW4gS8O2bmlnOgo+Pj4+IFVucGluIHRoZSBHRU0gb2JqZWN0IG9ubHkg
YWZ0ZXIgZnJlZWluZyB0aGUgc2cgdGFibGUuCj4+PiBXaGF0IGlzIHRoZSByYWNlIHRoYXQgaXMg
YmVpbmcgZml4ZWQgaGVyZT8gVGhlIFNHIHRhYmxlIGlzIHByaXZhdGUgdG8KPj4+IHRoZSBpbXBv
cnRlciBhbmQgdGhlIGltcG9ydGVyIHNob3VsZCBob3BlZnVsbHkgb25seSBjYWxsIG1hcF9kZXRh
Y2ggaWYKPj4+IGl0IGlzIGRvbmUgd2l0aCBhbGwgb3BlcmF0aW9ucyB1c2luZyB0aGUgU0cgdGFi
bGUuIFRodXMgaXQgc2hvdWxkbid0Cj4+PiBtYXR0ZXIgdGhhdCB0aGUgU0cgdGFibGUgbWlnaHQg
cG9pbnQgdG8gbW92ZWQgcGFnZXMgZHVyaW5nIGV4ZWN1dGlvbiBvZgo+Pj4gdGhpcyBmdW5jdGlv
bi4KPj4gRXhhY3RseSwgaXQgc2hvdWxkbid0IG1hdHRlci4gVGhpcyBpcyBqdXN0IGEgcHJlY2F1
dGlvbi4KPj4KPj4gV2hlbiB0aGUgZGV2aWNlIGRyaXZlciBpcyBidWdneSBJIHdhbnQgcHJvcGVy
IGVycm9yIG1lc3NhZ2VzIGZyb20gSU9NTVUgYW5kCj4+IG5vdCBhY2Nlc3NpbmcgcGFnZXMgd2hp
Y2ggbWlnaHQgYWxyZWFkeSBiZSByZXVzZWQgZm9yIHNvbWV0aGluZyBlbHNlLgo+IFBsZWFzZSBh
ZGQgdGhpcyB0byB0aGUgY29tbWl0IG1lc3NhZ2UsIHJhdGhlciBjcnVjaWFsIHRvIHVuZGVyc3Rh
bmQgdGhlCj4gbW90aXZhdGlvbi4gV2l0aCB0aGF0IGZpeGVkIHlvdSBjYW4gaGF2ZSBteQo+Cj4g
UmV2aWV3ZWQtYnk6IERhbmllbCBWZXR0ZXIgPGRhbmllbC52ZXR0ZXJAZmZ3bGwuY2g+Cj4KPiBB
bmQgcGxzIHB1c2ggdG8gZHJtLW1pc2MuCgpDYW4gSSB1c2Ugc3RhbmRhcmQgZ2l0IGZvciB0aGF0
IG5vdz8gSSByZWFsbHkgZG9uJ3Qgd2FudCB0byBtZXNzIHdpdGggCmRpbSBpbiBteSBlbnZpcm9u
bWVudC4KCkNocmlzdGlhbi4KX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX18KZHJpLWRldmVsIG1haWxpbmcgbGlzdApkcmktZGV2ZWxAbGlzdHMuZnJlZWRlc2t0
b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vZHJp
LWRldmVsCg==
