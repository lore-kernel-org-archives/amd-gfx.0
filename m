From: Sam Ravnborg <sam@ravnborg.org>
Subject: Re: [PATCH v1 01/10] drm: fix build errors with drm_print.h
Date: Tue, 11 Jun 2019 12:37:12 +0200
Message-ID: <20190611103712.GA31140@ravnborg.org>
References: <20190609220757.10862-1-sam@ravnborg.org>
 <20190609220757.10862-2-sam@ravnborg.org>
 <20190611083911.GT21222@phenom.ffwll.local>
 <20190611091107.GA29656@ravnborg.org>
 <20190611094224.GA21222@phenom.ffwll.local>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <dri-devel-bounces@lists.freedesktop.org>
Content-Disposition: inline
In-Reply-To: <20190611094224.GA21222@phenom.ffwll.local>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
To: Daniel Vetter <daniel@ffwll.ch>
Cc: David Airlie <airlied@linux.ie>, amd-gfx@lists.freedesktop.org, Maxime Ripard <maxime.ripard@bootlin.com>, dri-devel@lists.freedesktop.org, Alex Deucher <alexander.deucher@amd.com>, Sean Paul <sean@poorly.run>, Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>
List-Id: amd-gfx.lists.freedesktop.org

SGkgRGFuaWVsLgoKPiA+IAo+ID4gZHJtX3ByaW50LmggdXNlcyBEUk1fTkFNRSAtIHdoaWNoIGlz
IGRlZmluZWQgb25seSBpbiB1YXBpL2RybS9kcm0uaC4KPiA+IFRoZSBlcnJvciBpcyBzZWVuIHdo
ZW4geW91IGluY2x1ZGUgZHJtX3ByaW50LmggYW5kIG5vdCBtdWNoIG90aGVyIGRybQo+ID4gaGVh
ZGVyIGZpbGVzLgo+ID4gVGlkYXkgd2UgcmVseSBvbiBvdGhlciBkcm0gaGVhZGVyIGZpbGVzIHRv
IHB1bGwgaW4gZHJtLmguCj4gPiAKPiA+IE5vdGljZSAtIHRoZSBlcnJvciBvbmx5IG1hbmlmZXN0
IGl0c2VsZiB3aGVuIHRoZSBtYWNyb3MgYXJlIHVzZWQuCj4gPiBJbmNsdWRpbmcgdGhlIGRybV9w
cmludC5oIHdpbGwgbm90IGRvIGl0Lgo+IAo+IFVoLCBJIHRoaW5rIGxldCdzIGp1c3QgaW5saW5l
IERSTV9OQU1FLCB0aGF0IGFsc28gY2xlYW5zIHVwIHRoZSBjb2RlLiBBbmQKPiBkcm9wIHRoZSB1
YXBpIGluY2x1ZGUgZnJvbSBkcm0gaW50ZXJuYWwgaGVhZGVycywgdGhhdCBmZWVscyBiYWQuIElu
Cj4gZ2VuZXJhbCBJIHRoaW5rIHVhcGkgaGVhZGVycyBzaG91bGQgb25seSBiZSBpbmNsdWRlZCBi
eSB0aGUgLmMgZmlsZXMgdGhhdAo+IGFjdHVhbGx5IGltcGxlbWVudCBpb2N0bHMgYW5kIHN0dWZm
IGxpa2UgdGhhdC4KPiAKPiBDYW4geW91IHBscyBkbyB0aGF0IHBhdGNoIGZvciBkcm1fcHJpbnQu
aD8KClllcCAtIHdpbGwgZG8gaW4gYSBmZXcgZGF5cy4KCglTYW0KX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX18KZHJpLWRldmVsIG1haWxpbmcgbGlzdApkcmkt
ZGV2ZWxAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3Jn
L21haWxtYW4vbGlzdGluZm8vZHJpLWRldmVs
