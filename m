From: Daniel Vetter <daniel@ffwll.ch>
Subject: Re: [PATCH 4/7] drm/radeon: Fill out gem_object->resv
Date: Thu, 25 Jul 2019 15:18:32 +0200
Message-ID: <20190725131832.GG15868@phenom.ffwll.local>
References: <20190625204208.5614-1-daniel.vetter@ffwll.ch>
 <20190625204208.5614-5-daniel.vetter@ffwll.ch>
 <20190625205217.GC19279@ravnborg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <dri-devel-bounces@lists.freedesktop.org>
Content-Disposition: inline
In-Reply-To: <20190625205217.GC19279@ravnborg.org>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
To: Sam Ravnborg <sam@ravnborg.org>
Cc: Daniel Vetter <daniel.vetter@ffwll.ch>, amd-gfx@lists.freedesktop.org, DRI Development <dri-devel@lists.freedesktop.org>, Alex Deucher <alexander.deucher@amd.com>, Daniel Vetter <daniel.vetter@intel.com>, Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>, Emil Velikov <emil.velikov@collabora.com>
List-Id: amd-gfx.lists.freedesktop.org

T24gVHVlLCBKdW4gMjUsIDIwMTkgYXQgMTA6NTI6MTdQTSArMDIwMCwgU2FtIFJhdm5ib3JnIHdy
b3RlOgo+IE9uIFR1ZSwgSnVuIDI1LCAyMDE5IGF0IDEwOjQyOjA1UE0gKzAyMDAsIERhbmllbCBW
ZXR0ZXIgd3JvdGU6Cj4gPiBUaGF0IHdheSB3ZSBjYW4gZGl0Y2ggb3VyIGdlbV9wcmltZV9yZXNf
b2JqIGltcGxlbWVudGF0aW9uLiBTaW5jZSB0dG0KPiA+IGFic29sdXRlbHkgbmVlZHMgdGhlIHJp
Z2h0IHJlc2VydmF0aW9uIG9iamVjdCBhbGwgdGhlIGJvaWxlcnBsYXRlIGlzCj4gPiBhbHJlYWR5
IHRoZXJlIGFuZCB3ZSBqdXN0IGhhdmUgdG8gd2lyZSBpdCB1cCBjb3JyZWN0bHkuCj4gPiAKPiA+
IE5vdGUgdGhhdCBnZW0vcHJpbWUgZG9lc24ndCBjYXJlIHdoZW4gd2UgZG8gdGhpcywgYXMgbG9u
ZyBhcyB3ZSBkbyBpdAo+ID4gYmVmb3JlIHRoZSBibyBpcyByZWdpc3RlcmVkIGFuZCBzb21lb25l
IGNhbiBjYWxsIHRoZSBoYW5kbGUyZmQgaW9jdGwKPiA+IG9uIGl0Lgo+ID4gCj4gPiBBc2lkZTog
dHRtX2J1ZmZlcl9vYmplY3QudHRtX3Jlc3YgY291bGQgcHJvYmFibHkgYmUgZGl0Y2hlZCBpbiBm
YXZvdXIKPiA+IG9mIGFsd2F5cyBwYXNzaW5nIGEgbm9uLU5VTEwgcmVzdiB0byB0dG1fYm9faW5p
dCgpLiBBdCBsZWFzdCBmb3IgZ2VtCj4gPiBkcml2ZXJzIHRoYXQgd291bGQgYXZvaWQgaGF2aW5n
IHR3byBvZiB0aGVzZSwgb24gaW4gdHRtX2J1ZmZlcl9vYmplY3QKPiA+IGFuZCB0aGUgb3RoZXIg
aW4gZHJtX2dlbV9vYmplY3QsIG9uZSBqdXN0IHRoZXJlIGZvciBjb25mdXNpb24uCj4gU29tZXRo
aW5nIGZvciB0b2RvLnJzdCAtIHNvIHRoaXMgZG9lcyBub3QgZ2V0IGxvc3QgaW4gYSBjaGFuZ2Vs
b2cKPiBwZW9wbGUgd2lsbCBzb29uIGZvcmdldD8KCkdlcmQgYWxyZWFkeSBoYXMgYSBuaWNlIHBh
dGNoIHNlcmllcyAocmViYXNlZCBvbnRvIHRoaXMgb25lKSwgc28gSSBkb24ndAp0aGluayB3ZSBu
ZWVkIGEgdG9kby5yc3QgZm9yIHRoaXMuCi1EYW5pZWwKLS0gCkRhbmllbCBWZXR0ZXIKU29mdHdh
cmUgRW5naW5lZXIsIEludGVsIENvcnBvcmF0aW9uCmh0dHA6Ly9ibG9nLmZmd2xsLmNoCl9fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmRyaS1kZXZlbCBtYWls
aW5nIGxpc3QKZHJpLWRldmVsQGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZy
ZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2RyaS1kZXZlbA==
