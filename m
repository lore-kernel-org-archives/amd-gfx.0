From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH] [v3] drm: amd: dc: don't use FP math when Kcov is enabled
Date: Tue, 14 Aug 2018 11:15:38 +0200
Message-ID: <CAK8P3a3fDOeNWsmtXRHOF5cAMit7AMt7fS_54m7NXN0AjZYbPw@mail.gmail.com>
References: <20180811155554.3382650-1-arnd@arndb.de>
 <593dd8e1-fa23-3216-3550-274401d88bcb@gmail.com>
 <CADnq5_PCyKb72-BjFG3B4p_+bctNKoswAibw8C687_fpystSJA@mail.gmail.com>
 <CAK8P3a1AGC4fFYSSDQn2snkvf5htZVffCwRLV1NBm5YeZgw+CA@mail.gmail.com>
 <632dceb6-27e5-869b-46a9-6b11944204fc@daenzer.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <dri-devel-bounces@lists.freedesktop.org>
In-Reply-To: <632dceb6-27e5-869b-46a9-6b11944204fc@daenzer.net>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
To: michel@daenzer.net
Cc: David Airlie <airlied@linux.ie>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, amd-gfx@lists.freedesktop.org, Shirish S <shirish.s@amd.com>, Alex Deucher <alexander.deucher@amd.com>, Jerry.Zuo@amd.com, dri-devel <dri-devel@lists.freedesktop.org>, =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
List-Id: amd-gfx.lists.freedesktop.org

T24gVHVlLCBBdWcgMTQsIDIwMTggYXQgMTA6NTQgQU0gTWljaGVsIETDpG56ZXIgPG1pY2hlbEBk
YWVuemVyLm5ldD4gd3JvdGU6Cj4KPiBPbiAyMDE4LTA4LTEzIDA1OjIzIFBNLCBBcm5kIEJlcmdt
YW5uIHdyb3RlOgo+ID4gT24gTW9uLCBBdWcgMTMsIDIwMTggYXQgNDo0OSBQTSBBbGV4IERldWNo
ZXIgPGFsZXhkZXVjaGVyQGdtYWlsLmNvbT4gd3JvdGU6Cj4gPj4KPiA+PiBPbiBTdW4sIEF1ZyAx
MiwgMjAxOCBhdCAzOjU1IEFNIENocmlzdGlhbiBLw7ZuaWcKPiA+PiA8Y2tvZW5pZy5sZWljaHR6
dW1lcmtlbkBnbWFpbC5jb20+IHdyb3RlOgo+ID4+PiBBZGRpbmcgSGFycnkgYXMgd2VsbC4KPiA+
Pj4gQW0gMTEuMDguMjAxOCB1bSAxNzo1NCBzY2hyaWViIEFybmQgQmVyZ21hbm46Cj4gPj4+Pgo+
ID4+Pj4gRml4ZXM6IGJmMmUyZTJlMGVhOSAoImRybS9hbWQvZGlzcGxheTogTGltaXQgRENOIHRv
IHg4NiBhcmNoIikKPiA+Pj4+IEZpeGVzOiA0ODQxMjAzMTAyYTMgKCJkcm0vYW1kZ3B1L2Rpc3Bs
YXk6IFJlcGxhY2UgQ09ORklHX0RSTV9BTURfRENfRENOMV8wIHdpdGggQ09ORklHX1g4NiIpCj4g
Pj4KPiA+PiBNYXliZSBpdCB3b3VsZCBiZSBiZXR0ZXIgdG8gcmV2ZXJ0IDQ4NDEyMDMxMDJhMyBz
byB3ZSBjYW4gbGltaXQgdGhlCj4gPj4gc2NvcGUgb2YgdGhpcyB0byBEQ04gc3VwcG9ydC4KPiA+
Cj4gPiBUaGF0IHdvdWxkIGhlbHAsIGJ1dCB3ZSB3b3VsZCBzdGlsbCByZXF1aXJlIHRoZSBwYXRj
aCBhdAo+ID4gaHR0cHM6Ly9wYXRjaHdvcmsua2VybmVsLm9yZy9wYXRjaC8xMDA5MDIyNy8gb3Ig
c29tZXRoaW5nIGVsc2UgdG8gYXZvaWQKPiA+IGJyb2tlbiByYW5kY29uZmlnIGJ1aWxkcy4KPgo+
IEZXSVcsIHBsZWFzZSBkb24ndCByZXZlcnQgNDg0MTIwMzEwMmEzIGluIGEgd2F5IHdoaWNoIGFs
bG93cwo+IENPTkZJR19EUk1fQU1EX0RDX0RDTjFfMCB0byBiZSBhY2NpZGVudGFsbHkgZGlzYWJs
ZWQgb24gWDg2IGFnYWluLiBJZiBpdAo+IGlzIHJlaW5zdGF0ZWQsIGl0IHNob3VsZCBiZSBzdHJp
Y3RseSBkZXJpdmVkIGZyb20gb3RoZXIgb3B0aW9ucywgbm90Cj4gY2hhbmdlYWJsZSBieSB0aGUg
dXNlci4KCkhvdyBhYm91dCBtYWtpbmcgYWxsIG9mIEFNREdQVSBkZXBlbmQgb24KIiAhKEtDT1Zf
SU5TVFJVTUVOVF9BTEwgJiYgS0NPVl9FTkFCTEVfQ09NUEFSSVNPTlMpIHx8IEJST0tFTiIKdGhl
bj8KCiAgICAgQXJuZApfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fXwpkcmktZGV2ZWwgbWFpbGluZyBsaXN0CmRyaS1kZXZlbEBsaXN0cy5mcmVlZGVza3RvcC5v
cmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9kcmktZGV2
ZWwK
