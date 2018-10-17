From: Daniel Vetter <daniel@ffwll.ch>
Subject: Re: [PATCH 2/7] drm: add syncobj timeline support v8
Date: Wed, 17 Oct 2018 12:24:22 +0200
Message-ID: <CAKMK7uGxptMKtz-4JzT9us3M2dsLGhTSVuAKduNH+VGCsCSsQw@mail.gmail.com>
References: <20181015085553.30656-1-david1.zhou@amd.com>
 <20181015085553.30656-2-david1.zhou@amd.com>
 <20181017080908.GK31561@phenom.ffwll.local>
 <2066a18d-8002-014b-ef3c-a6f6014bdb55@amd.com>
 <2f99da09-7bf7-d5e7-d7c1-fe2e4cf43b40@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <dri-devel-bounces@lists.freedesktop.org>
In-Reply-To: <2f99da09-7bf7-d5e7-d7c1-fe2e4cf43b40@amd.com>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <Christian.Koenig@amd.com>
Cc: amd-gfx list <amd-gfx@lists.freedesktop.org>, "Rakos,
 Daniel" <Daniel.Rakos@amd.com>, dri-devel <dri-devel@lists.freedesktop.org>, Dave Airlie <airlied@redhat.com>
List-Id: amd-gfx.lists.freedesktop.org

T24gV2VkLCBPY3QgMTcsIDIwMTggYXQgMTE6MjkgQU0gS29lbmlnLCBDaHJpc3RpYW4KPENocmlz
dGlhbi5Lb2VuaWdAYW1kLmNvbT4gd3JvdGU6Cj4KPiBBbSAxNy4xMC4xOCB1bSAxMToxNyBzY2hy
aWViIHpob3VjbTE6Cj4gPiBbU05JUF0KPiA+Pj4gICArc3RydWN0IGRybV9zeW5jb2JqX3NpZ25h
bF9wdCB7Cj4gPj4+ICsgICAgc3RydWN0IGRtYV9mZW5jZV9hcnJheSAqYmFzZTsKPiA+PiBPdXQg
b2YgY3VyaW9zaXR5LCB3aHkgdGhlIHBvaW50ZXIgYW5kIG5vdCBlbWJlZGRpbmc/IGJhc2UgaXMg
a2luZGEKPiA+PiBtaXNsZWFkaW5nIGZvciBhIHBvaW50ZXIuCj4gPiBZZWFoLCBDaHJpc3RpYW4g
ZG9lc24ndCBsaWtlIHNpZ25hbF9wdCBsaWZlY3ljbGUgc2FtZSBhcyBmZW5jZSwgc28KPiA+IGl0
J3MgYSBwb2ludGVyLgo+ID4gSWYgeW91IGRvbid0IGxpa2UgJ2Jhc2UnIG5hbWUsIEkgY2FuIGNo
YW5nZSBpdC4KPgo+IFdlbGwgSSBuZXZlciBzYWlkIHRoYXQgeW91IGNhbid0IGVtYmVkIHRoZSBm
ZW5jZSBhcnJheSBpbnRvIHRoZSBzaWduYWxfcHQuCj4KPiBZb3UganVzdCBuZWVkIHRvIG1ha2Ug
c3VyZSB0aGF0IHdlIGRvbid0IGFmZmVjdCB0aGUgZHJtX3N5bmNvYmoKPiBsaWxlY3ljbGUgYXMg
d2VsbCwgZS5nLiB0aGF0IHdlIGRvbid0IGFsc28gbmVlZCB0byBrZWVwIHRoYXQgYXJvdW5kLgoK
SSBkb24ndCBzZWUgYSBwcm9ibGVtIHdpdGggdGhhdCwgYXMgbG9uZyBhcyBkcm1fc3luY29iaiBr
ZWVwcyBhCnJlZmVyZW5jZSB0byB0aGUgZmVuY2Ugd2hpbGUgaXQncyBvbiB0aGUgdGltZWxpbmUg
bGlzdC4gV2hpY2ggaXQKYWxyZWFkeSBkb2VzLiBBbmQgZW1iZWRkaW5nIHdvdWxkIGF2b2lkIHRo
YXQgMm5kIHNlcGFyYXRlIGFsbG9jYXRpb24sCmFzaWRlIGZyb20gbWFraW5nIGJhc2UgbGVzcyBj
b25mdXNpbmcuCi1EYW5pZWwKLS0gCkRhbmllbCBWZXR0ZXIKU29mdHdhcmUgRW5naW5lZXIsIElu
dGVsIENvcnBvcmF0aW9uCis0MSAoMCkgNzkgMzY1IDU3IDQ4IC0gaHR0cDovL2Jsb2cuZmZ3bGwu
Y2gKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KZHJpLWRl
dmVsIG1haWxpbmcgbGlzdApkcmktZGV2ZWxAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8v
bGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vZHJpLWRldmVsCg==
