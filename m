From: Alex Deucher <alexdeucher@gmail.com>
Subject: Re: [PATCH] drm/amd/display: return 'NULL' instead of 'false' from
 dcn20_acquire_idle_pipe_for_layer
Date: Fri, 12 Jul 2019 13:56:39 -0400
Message-ID: <CADnq5_O-LJHnHg_yw0jVxy9yT8ZqNq4s-U_surFXTcL=fPA21Q@mail.gmail.com>
References: <20190712094009.1535662-1-arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <dri-devel-bounces@lists.freedesktop.org>
In-Reply-To: <20190712094009.1535662-1-arnd@arndb.de>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Charlene Liu <charlene.liu@amd.com>, Leo Li <sunpeng.li@amd.com>, Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>, Maling list - DRI developers <dri-devel@lists.freedesktop.org>, LKML <linux-kernel@vger.kernel.org>, amd-gfx list <amd-gfx@lists.freedesktop.org>, Nikola Cornij <nikola.cornij@amd.com>, David Airlie <airlied@linux.ie>, Dmytro Laktyushkin <Dmytro.Laktyushkin@amd.com>, clang-built-linux@googlegroups.com, Alex Deucher <alexander.deucher@amd.com>, Jun Lei <Jun.Lei@amd.com>, =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
List-Id: amd-gfx.lists.freedesktop.org

T24gRnJpLCBKdWwgMTIsIDIwMTkgYXQgNTo0MCBBTSBBcm5kIEJlcmdtYW5uIDxhcm5kQGFybmRi
LmRlPiB3cm90ZToKPgo+IGNsYW5nIGNvbXBsYWlucyB0aGF0ICdmYWxzZScgaXMgYSBub3QgYSBw
b2ludGVyOgo+Cj4gZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvLi4vZGlzcGxheS9kYy9kY24y
MC9kY24yMF9yZXNvdXJjZS5jOjI0Mjg6MTA6IGVycm9yOiBleHByZXNzaW9uIHdoaWNoIGV2YWx1
YXRlcyB0byB6ZXJvIHRyZWF0ZWQgYXMgYSBudWxsIHBvaW50ZXIgY29uc3RhbnQgb2YgdHlwZSAn
c3RydWN0IHBpcGVfY3R4IConIFstV2Vycm9yLC1Xbm9uLWxpdGVyYWwtbnVsbC1jb252ZXJzaW9u
XQo+ICAgICAgICAgICAgICAgICByZXR1cm4gZmFsc2U7Cj4KPiBDaGFuZ2luZyBpdCB0byAnTlVM
TCcgbG9va3MgbGlrZSB0aGUgcmlnaHQgdGhpbmcgdGhhdCB3aWxsIHNodXQgdXAKPiB0aGUgd2Fy
bmluZyBhbmQgbWFrZSBpdCBlYXNpZXIgdG8gcmVhZCwgd2hpbGUgbm90IGNoYW5naW5nIGJlaGF2
aW9yLgo+Cj4gRml4ZXM6IDdlZDRlNjM1MmMxNiAoImRybS9hbWQvZGlzcGxheTogQWRkIERDTjIg
SFcgU2VxdWVuY2VyIGFuZCBSZXNvdXJjZSIpCj4gU2lnbmVkLW9mZi1ieTogQXJuZCBCZXJnbWFu
biA8YXJuZEBhcm5kYi5kZT4KCkFwcGxpZWQuICBUaGFua3MhCgpBbGV4Cgo+IC0tLQo+ICBkcml2
ZXJzL2dwdS9kcm0vYW1kL2Rpc3BsYXkvZGMvZGNuMjAvZGNuMjBfcmVzb3VyY2UuYyB8IDIgKy0K
PiAgMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspLCAxIGRlbGV0aW9uKC0pCj4KPiBkaWZm
IC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5L2RjL2RjbjIwL2RjbjIwX3Jlc291
cmNlLmMgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2Rpc3BsYXkvZGMvZGNuMjAvZGNuMjBfcmVzb3Vy
Y2UuYwo+IGluZGV4IDcwYWM4YTk1ZDJkYi4uNjZhYTQxNGFkMzhmIDEwMDY0NAo+IC0tLSBhL2Ry
aXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxheS9kYy9kY24yMC9kY24yMF9yZXNvdXJjZS5jCj4gKysr
IGIvZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5L2RjL2RjbjIwL2RjbjIwX3Jlc291cmNlLmMK
PiBAQCAtMjQyNSw3ICsyNDI1LDcgQEAgc3RydWN0IHBpcGVfY3R4ICpkY24yMF9hY3F1aXJlX2lk
bGVfcGlwZV9mb3JfbGF5ZXIoCj4gICAgICAgICAgICAgICAgIEFTU0VSVCgwKTsKPgo+ICAgICAg
ICAgaWYgKCFpZGxlX3BpcGUpCj4gLSAgICAgICAgICAgICAgIHJldHVybiBmYWxzZTsKPiArICAg
ICAgICAgICAgICAgcmV0dXJuIE5VTEw7Cj4KPiAgICAgICAgIGlkbGVfcGlwZS0+c3RyZWFtID0g
aGVhZF9waXBlLT5zdHJlYW07Cj4gICAgICAgICBpZGxlX3BpcGUtPnN0cmVhbV9yZXMudGcgPSBo
ZWFkX3BpcGUtPnN0cmVhbV9yZXMudGc7Cj4gLS0KPiAyLjIwLjAKPgo+IF9fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCj4gZHJpLWRldmVsIG1haWxpbmcgbGlz
dAo+IGRyaS1kZXZlbEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKPiBodHRwczovL2xpc3RzLmZyZWVk
ZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2RyaS1kZXZlbApfX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fXwpkcmktZGV2ZWwgbWFpbGluZyBsaXN0CmRyaS1k
ZXZlbEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcv
bWFpbG1hbi9saXN0aW5mby9kcmktZGV2ZWw=
