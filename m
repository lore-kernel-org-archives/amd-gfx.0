From: =?UTF-8?Q?Michel_D=c3=a4nzer?= <michel@daenzer.net>
Subject: Re: [PATCH] [v3] drm: amd: dc: don't use FP math when Kcov is enabled
Date: Tue, 14 Aug 2018 10:54:54 +0200
Message-ID: <632dceb6-27e5-869b-46a9-6b11944204fc@daenzer.net>
References: <20180811155554.3382650-1-arnd@arndb.de>
 <593dd8e1-fa23-3216-3550-274401d88bcb@gmail.com>
 <CADnq5_PCyKb72-BjFG3B4p_+bctNKoswAibw8C687_fpystSJA@mail.gmail.com>
 <CAK8P3a1AGC4fFYSSDQn2snkvf5htZVffCwRLV1NBm5YeZgw+CA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <dri-devel-bounces@lists.freedesktop.org>
In-Reply-To: <CAK8P3a1AGC4fFYSSDQn2snkvf5htZVffCwRLV1NBm5YeZgw+CA@mail.gmail.com>
Content-Language: en-CA
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
To: Arnd Bergmann <arnd@arndb.de>, alexdeucher@gmail.com
Cc: David Airlie <airlied@linux.ie>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, amd-gfx@lists.freedesktop.org, Shirish S <shirish.s@amd.com>, Jerry.Zuo@amd.com, dri-devel <dri-devel@lists.freedesktop.org>, Alex Deucher <alexander.deucher@amd.com>, =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
List-Id: amd-gfx.lists.freedesktop.org

T24gMjAxOC0wOC0xMyAwNToyMyBQTSwgQXJuZCBCZXJnbWFubiB3cm90ZToKPiBPbiBNb24sIEF1
ZyAxMywgMjAxOCBhdCA0OjQ5IFBNIEFsZXggRGV1Y2hlciA8YWxleGRldWNoZXJAZ21haWwuY29t
PiB3cm90ZToKPj4KPj4gT24gU3VuLCBBdWcgMTIsIDIwMTggYXQgMzo1NSBBTSBDaHJpc3RpYW4g
S8O2bmlnCj4+IDxja29lbmlnLmxlaWNodHp1bWVya2VuQGdtYWlsLmNvbT4gd3JvdGU6Cj4+PiBB
ZGRpbmcgSGFycnkgYXMgd2VsbC4KPj4+IEFtIDExLjA4LjIwMTggdW0gMTc6NTQgc2NocmllYiBB
cm5kIEJlcmdtYW5uOgo+Pj4+Cj4+Pj4gRml4ZXM6IGJmMmUyZTJlMGVhOSAoImRybS9hbWQvZGlz
cGxheTogTGltaXQgRENOIHRvIHg4NiBhcmNoIikKPj4+PiBGaXhlczogNDg0MTIwMzEwMmEzICgi
ZHJtL2FtZGdwdS9kaXNwbGF5OiBSZXBsYWNlIENPTkZJR19EUk1fQU1EX0RDX0RDTjFfMCB3aXRo
IENPTkZJR19YODYiKQo+Pgo+PiBNYXliZSBpdCB3b3VsZCBiZSBiZXR0ZXIgdG8gcmV2ZXJ0IDQ4
NDEyMDMxMDJhMyBzbyB3ZSBjYW4gbGltaXQgdGhlCj4+IHNjb3BlIG9mIHRoaXMgdG8gRENOIHN1
cHBvcnQuCj4gCj4gVGhhdCB3b3VsZCBoZWxwLCBidXQgd2Ugd291bGQgc3RpbGwgcmVxdWlyZSB0
aGUgcGF0Y2ggYXQKPiBodHRwczovL3BhdGNod29yay5rZXJuZWwub3JnL3BhdGNoLzEwMDkwMjI3
LyBvciBzb21ldGhpbmcgZWxzZSB0byBhdm9pZAo+IGJyb2tlbiByYW5kY29uZmlnIGJ1aWxkcy4K
CkZXSVcsIHBsZWFzZSBkb24ndCByZXZlcnQgNDg0MTIwMzEwMmEzIGluIGEgd2F5IHdoaWNoIGFs
bG93cwpDT05GSUdfRFJNX0FNRF9EQ19EQ04xXzAgdG8gYmUgYWNjaWRlbnRhbGx5IGRpc2FibGVk
IG9uIFg4NiBhZ2Fpbi4gSWYgaXQKaXMgcmVpbnN0YXRlZCwgaXQgc2hvdWxkIGJlIHN0cmljdGx5
IGRlcml2ZWQgZnJvbSBvdGhlciBvcHRpb25zLCBub3QKY2hhbmdlYWJsZSBieSB0aGUgdXNlci4K
CgotLSAKRWFydGhsaW5nIE1pY2hlbCBEw6RuemVyICAgICAgICAgICAgICAgfCAgICAgICAgICAg
ICAgIGh0dHA6Ly93d3cuYW1kLmNvbQpMaWJyZSBzb2Z0d2FyZSBlbnRodXNpYXN0ICAgICAgICAg
ICAgIHwgICAgICAgICAgICAgTWVzYSBhbmQgWCBkZXZlbG9wZXIKX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX18KZHJpLWRldmVsIG1haWxpbmcgbGlzdApkcmkt
ZGV2ZWxAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3Jn
L21haWxtYW4vbGlzdGluZm8vZHJpLWRldmVsCg==
