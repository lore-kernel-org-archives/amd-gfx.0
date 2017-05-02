From: Emil Velikov <emil.l.velikov@gmail.com>
Subject: Re: [PATCH 1/3] drm: fourcc byteorder: drop DRM_FORMAT_BIG_ENDIAN
Date: Tue, 2 May 2017 14:53:43 +0100
Message-ID: <CACvgo52FeXVixjmRpv3xO=kRFTbmBu5vmyzAs=VF_v+nLAO=ag@mail.gmail.com>
References: <20170502133404.15354-1-kraxel@redhat.com>
 <20170502133404.15354-2-kraxel@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <dri-devel-bounces@lists.freedesktop.org>
In-Reply-To: <20170502133404.15354-2-kraxel@redhat.com>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: ML dri-devel <dri-devel@lists.freedesktop.org>, =?UTF-8?Q?Michel_D=C3=A4nzer?= <michel@daenzer.net>, open list <linux-kernel@vger.kernel.org>, amd-gfx mailing list <amd-gfx@lists.freedesktop.org>, Daniel Vetter <daniel.vetter@intel.com>
List-Id: amd-gfx.lists.freedesktop.org

SGkgR2VyZCwKCkkgZGlkIG5vdCBoYXZlIHRoZSBjaGFuZ2UgdG8gZm9sbG93IHRocm91Z2ggdGhl
IGRpc2N1c3Npb24uClBhcmRvbiBpZiBteSBzdWdnZXN0aW9uIGhhdmUgYWxyZWFkeSBiZWVuIGRp
c2N1c3NlZC4KCk9uIDIgTWF5IDIwMTcgYXQgMTQ6MzQsIEdlcmQgSG9mZm1hbm4gPGtyYXhlbEBy
ZWRoYXQuY29tPiB3cm90ZToKPiBJdCdzIHVudXNlZC4KPgo+IFN1Z2dlc3RlZC1ieTogRGFuaWVs
IFZldHRlciA8ZGFuaWVsLnZldHRlckBpbnRlbC5jb20+Cj4gU2lnbmVkLW9mZi1ieTogR2VyZCBI
b2ZmbWFubiA8a3JheGVsQHJlZGhhdC5jb20+Cj4gLS0tCj4gIGluY2x1ZGUvdWFwaS9kcm0vZHJt
X2ZvdXJjYy5oICAgICB8IDIgLS0KPiAgZHJpdmVycy9ncHUvZHJtL2RybV9mb3VyY2MuYyAgICAg
IHwgMyArLS0KPiAgZHJpdmVycy9ncHUvZHJtL2RybV9mcmFtZWJ1ZmZlci5jIHwgMiArLQo+ICAz
IGZpbGVzIGNoYW5nZWQsIDIgaW5zZXJ0aW9ucygrKSwgNSBkZWxldGlvbnMoLSkKPgo+IGRpZmYg
LS1naXQgYS9pbmNsdWRlL3VhcGkvZHJtL2RybV9mb3VyY2MuaCBiL2luY2x1ZGUvdWFwaS9kcm0v
ZHJtX2ZvdXJjYy5oCj4gaW5kZXggOTk1YzhmOWM2OS4uMzA1YmMzNGJlMCAxMDA2NDQKPiAtLS0g
YS9pbmNsdWRlL3VhcGkvZHJtL2RybV9mb3VyY2MuaAo+ICsrKyBiL2luY2x1ZGUvdWFwaS9kcm0v
ZHJtX2ZvdXJjYy5oCj4gQEAgLTMzLDggKzMzLDYgQEAgZXh0ZXJuICJDIiB7Cj4gICNkZWZpbmUg
Zm91cmNjX2NvZGUoYSwgYiwgYywgZCkgKChfX3UzMikoYSkgfCAoKF9fdTMyKShiKSA8PCA4KSB8
IFwKPiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAoKF9fdTMyKShjKSA8PCAxNikg
fCAoKF9fdTMyKShkKSA8PCAyNCkpCj4KPiAtI2RlZmluZSBEUk1fRk9STUFUX0JJR19FTkRJQU4g
KDE8PDMxKSAvKiBmb3JtYXQgaXMgYmlnIGVuZGlhbiBpbnN0ZWFkIG9mIGxpdHRsZSBlbmRpYW4g
Ki8KPiAtCgpXZXN0b24gcmVmZXJlbmNlcyBEUk1fRk9STUFUX0JJR19FTkRJQU4gdGh1cyB0aGlz
IHBhdGNoIHdpbGwgbGVhZCB0bwpidWlsZCBicmVha2FnZS4KVGhhdCBpcyBuZXZlciBmdW4sIHNv
IHBsZWFzZSBjYXJlZnVsbHkgY29vcmRpbmF0ZSB3aXRoIHRoZSBXZXN0b24gZGV2cwp0byBtaW5p
bWlzZSB0aGUgZmlyZXdvcmtzLgoKUGVyc29uYWxseSBJIHdvdWxkIGxlYXZlIHRoZSBzeW1ib2ws
IHNpbmNlIGl0J3MgVUFQSSBhbmQgZG9jdW1lbnQgdGhhdApzaG91bGQgbm90IGJlIHVzZWQuIE5v
dCBteSBjYWxsLCBzbyBmZWVsIGZyZWUgdG8gaWdub3JlLgoKVGhhbmtzCkVtaWwKX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KZHJpLWRldmVsIG1haWxpbmcg
bGlzdApkcmktZGV2ZWxAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRl
c2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vZHJpLWRldmVsCg==
