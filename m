From: =?UTF-8?Q?Noralf_Tr=c3=b8nnes?= <noralf@tronnes.org>
Subject: Re: [PATCH 16/21] drm/radeon: Use
 drm_fb_helper_fill_info
Date: Tue, 26 Mar 2019 15:51:40 +0100
Message-ID: <9ed800b2-1681-c3fc-3788-584dfef310b8@tronnes.org>
References: <20190326132008.11781-1-daniel.vetter@ffwll.ch>
 <20190326132008.11781-16-daniel.vetter@ffwll.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <intel-gfx-bounces@lists.freedesktop.org>
In-Reply-To: <20190326132008.11781-16-daniel.vetter@ffwll.ch>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/intel-gfx>,
 <mailto:intel-gfx-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/intel-gfx>
List-Post: <mailto:intel-gfx@lists.freedesktop.org>
List-Help: <mailto:intel-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/intel-gfx>,
 <mailto:intel-gfx-request@lists.freedesktop.org?subject=subscribe>
Errors-To: intel-gfx-bounces@lists.freedesktop.org
Sender: "Intel-gfx" <intel-gfx-bounces@lists.freedesktop.org>
To: Daniel Vetter <daniel.vetter@ffwll.ch>, DRI Development <dri-devel@lists.freedesktop.org>
Cc: Alex Deucher <alexander.deucher@amd.com>, Daniel Vetter <daniel.vetter@intel.com>, Intel Graphics Development <intel-gfx@lists.freedesktop.org>, =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>, amd-gfx@lists.freedesktop.org
List-Id: amd-gfx.lists.freedesktop.org

CgpEZW4gMjYuMDMuMjAxOSAxNC4yMCwgc2tyZXYgRGFuaWVsIFZldHRlcjoKPiBUaGlzIHNob3Vs
ZCBub3QgcmVzdWx0IGluIGFueSBjaGFuZ2VzLgo+IAo+IHYyOiBSZWJhc2UKPiAKPiBTaWduZWQt
b2ZmLWJ5OiBEYW5pZWwgVmV0dGVyIDxkYW5pZWwudmV0dGVyQGludGVsLmNvbT4KPiBDYzogQWxl
eCBEZXVjaGVyIDxhbGV4YW5kZXIuZGV1Y2hlckBhbWQuY29tPgo+IENjOiAiQ2hyaXN0aWFuIEvD
tm5pZyIgPGNocmlzdGlhbi5rb2VuaWdAYW1kLmNvbT4KPiBDYzogIkRhdmlkIChDaHVuTWluZykg
WmhvdSIgPERhdmlkMS5aaG91QGFtZC5jb20+Cj4gQ2M6IGFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0
b3Aub3JnCj4gLS0tCgpBY2tlZC1ieTogTm9yYWxmIFRyw7hubmVzIDxub3JhbGZAdHJvbm5lcy5v
cmc+Cl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCkludGVs
LWdmeCBtYWlsaW5nIGxpc3QKSW50ZWwtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczov
L2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2ludGVsLWdmeA==
