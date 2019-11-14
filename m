From: Alex Deucher <alexdeucher@gmail.com>
Subject: Re: [PATCH 0/4] drm/amd/display: remove some set but not used
 variables
Date: Thu, 14 Nov 2019 15:11:23 -0500
Message-ID: <CADnq5_NhHCg80K6FA9nxost=1wqaLDc3dM6u-Q+hd003PMfjdg@mail.gmail.com>
References: <1573734987-119703-1-git-send-email-zhengbin13@huawei.com>
 <e1bfa8cc-1552-9f81-3705-ef6b832461c8@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <dri-devel-bounces@lists.freedesktop.org>
In-Reply-To: <e1bfa8cc-1552-9f81-3705-ef6b832461c8@amd.com>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
To: Harry Wentland <hwentlan@amd.com>
Cc: "Leo (Sunpeng) Li" <sunpeng.li@amd.com>, amd-gfx list <amd-gfx@lists.freedesktop.org>, zhengbin <zhengbin13@huawei.com>, Dave Airlie <airlied@linux.ie>, Maling list - DRI developers <dri-devel@lists.freedesktop.org>, "Deucher,
 Alexander" <alexander.deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>
List-Id: amd-gfx.lists.freedesktop.org

T24gVGh1LCBOb3YgMTQsIDIwMTkgYXQgMTE6NDEgQU0gSGFycnkgV2VudGxhbmQgPGh3ZW50bGFu
QGFtZC5jb20+IHdyb3RlOgo+Cj4gT24gMjAxOS0xMS0xNCA3OjM2IGEubS4sIHpoZW5nYmluIHdy
b3RlOgo+ID4gemhlbmdiaW4gKDQpOgo+ID4gICBkcm0vYW1kL2Rpc3BsYXk6IHJlbW92ZSBzZXQg
YnV0IG5vdCB1c2VkIHZhcmlhYmxlICdvbGRfcGxhbmVfY3J0YycKPiA+ICAgZHJtL2FtZC9kaXNw
bGF5OiByZW1vdmUgc2V0IGJ1dCBub3QgdXNlZCB2YXJpYWJsZSAnYnAnIGluCj4gPiAgICAgYmlv
c19wYXJzZXIyLmMKPiA+ICAgZHJtL2FtZC9kaXNwbGF5OiByZW1vdmUgc2V0IGJ1dCBub3QgdXNl
ZCB2YXJpYWJsZSAnYnAnIGluCj4gPiAgICAgYmlvc19wYXJzZXIuYwo+ID4gICBkcm0vYW1kL2Rp
c3BsYXk6IHJlbW92ZSBzZXQgYnV0IG5vdCB1c2VkIHZhcmlhYmxlICdtaW5fY29udGVudCcKPiA+
Cj4KPiBUaGVzZSB3b3VsZCBiZSBmaW5lIGFzIGEgc2luZ2xlIHBhdGNoIGFzIHdlbGwgYnV0IEkg
ZG9uJ3QgaGF2ZSBhIHN0cm9uZwo+IHByZWZlcmVuY2UgZWl0aGVyIHdheS4KPgo+IFBhdGNoZXMg
YXJlOgo+IFJldmlld2VkLWJ5OiBIYXJyeSBXZW50bGFuZCA8aGFycnkud2VudGxhbmRAYW1kLmNv
bT4KCkFwcGxpZWQuICBUaGFua3MhCgpBbGV4Cgo+Cj4gSGFycnkKPgo+ID4gIGRyaXZlcnMvZ3B1
L2RybS9hbWQvZGlzcGxheS9hbWRncHVfZG0vYW1kZ3B1X2RtLmMgICAgICAgfCAzICstLQo+ID4g
IGRyaXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxheS9kYy9iaW9zL2Jpb3NfcGFyc2VyLmMgICAgICAg
fCAyIC0tCj4gPiAgZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5L2RjL2Jpb3MvYmlvc19wYXJz
ZXIyLmMgICAgICB8IDIgLS0KPiA+ICBkcml2ZXJzL2dwdS9kcm0vYW1kL2Rpc3BsYXkvbW9kdWxl
cy9jb2xvci9jb2xvcl9nYW1tYS5jIHwgMiAtLQo+ID4gIDQgZmlsZXMgY2hhbmdlZCwgMSBpbnNl
cnRpb24oKyksIDggZGVsZXRpb25zKC0pCj4gPgo+ID4gLS0KPiA+IDIuNy40Cj4gPgo+IF9fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCj4gZHJpLWRldmVsIG1h
aWxpbmcgbGlzdAo+IGRyaS1kZXZlbEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKPiBodHRwczovL2xp
c3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2RyaS1kZXZlbApfX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpkcmktZGV2ZWwgbWFpbGluZyBs
aXN0CmRyaS1kZXZlbEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVz
a3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9kcmktZGV2ZWw=
