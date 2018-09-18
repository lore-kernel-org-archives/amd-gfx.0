From: Lyude Paul <lyude@redhat.com>
Subject: [PATCH 0/6] Fix legacy DPMS changes with MST
Date: Tue, 18 Sep 2018 19:06:16 -0400
Message-ID: <20180918230637.20700-1-lyude@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <dri-devel-bounces@lists.freedesktop.org>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
To: dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org, intel-gfx@lists.freedesktop.org, amd-gfx@lists.freedesktop.org
Cc: David Airlie <airlied@linux.ie>, Roman Li <roman.li@amd.com>, Sean Paul <sean@poorly.run>, "Jerry (Fangzhi) Zuo" <jerry.zuo@amd.com>, Ben Skeggs <bskeggs@redhat.com>, Daniel Vetter <daniel.vetter@ffwll.ch>, Leo Li <sunpeng.li@amd.com>, Sean Paul <seanpaul@chromium.org>, Rodrigo Vivi <rodrigo.vivi@intel.com>, Tony Cheng <tony.cheng@amd.com>, linux-kernel@vger.kernel.org, Shirish S <shirish.s@amd.com>, Alex Deucher <alexander.deucher@amd.com>, =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
List-Id: amd-gfx.lists.freedesktop.org

VGhlcmUncyB0d28gbWFqb3IgdGhpbmdzIHRoaXMgcGF0Y2hzZXQgZG9lczoKIC0gQWRkIGRybV9k
cF9tc3RfY29ubmVjdG9yX2F0b21pY19jaGVjaygpIHNvIGRyaXZlcnMgZG9uJ3QgbmVlZCB0byB1
c2UKICAgLT5iZXN0X2VuY29kZXIoKSB0byBwcmV2ZW50IG1vZGVzZXRzIG9uIHpvbWJpZSBNU1Qg
Y29ubmVjdG9ycy4gV2UnbGwKICAgdXNlIHRoaXMgbGF0ZXIgZm9yIGltcGxlbWVudGluZyBNU1Qg
ZmFsbGJhY2sgcmV0cmFpbmluZyBhcyB3ZWxsLgogLSBGaXggRFBNUyBvbi0+b2ZmIGNoYW5nZXMg
ZmFpbGluZyB3aXRoIGxlZ2FjeSBtb2Rlc2V0dGluZyB1c2VycyBhZnRlcgogICBhbiBNU1QgY29u
bmVjdG9yJ3MgdG9wb2xvZ3kgaGFzIGRpc2FwcGVhcmVkLCB3aGljaCByZXN1bHRlZCBpbiBDUlRD
cwogICBiZWluZyBsZWZ0IG9uIHdoZW4gdGhleSBzaG91bGRuJ3QgaGF2ZSBiZWVuCgpMeXVkZSBQ
YXVsICg2KToKICBkcm0vZHBfbXN0OiBJbnRyb2R1Y2UgZHJtX2RwX21zdF9jb25uZWN0b3JfYXRv
bWljX2NoZWNrKCkKICBkcm0vbm91dmVhdTogVW5icmVhayBudjUwX21zdGMtPmJlc3RfZW5jb2Rl
cigpCiAgZHJtL2k5MTU6IExlYXZlIGludGVsX2Nvbm4tPm1zdF9wb3J0IHNldCwgdXNlIG1zdF9w
b3J0X2dvbmUgaW5zdGVhZAogIGRybS9pOTE1OiBTa2lwIHZjcGkgYWxsb2NhdGlvbiBmb3IgTVNU
QiBwb3J0cyB0aGF0IGFyZSBnb25lCiAgZHJtL2k5MTU6IEZpeCBpbnRlbF9kcF9tc3RfYmVzdF9l
bmNvZGVyKCkKICBkcm0vYW1kZ3B1L2RtL21zdDogVXNlIGRybV9kcF9tc3RfY29ubmVjdG9yX2F0
b21pY19jaGVjaygpCgogLi4uL2Rpc3BsYXkvYW1kZ3B1X2RtL2FtZGdwdV9kbV9tc3RfdHlwZXMu
YyAgIHwgMTIgKysrCiBkcml2ZXJzL2dwdS9kcm0vZHJtX2RwX21zdF90b3BvbG9neS5jICAgICAg
ICAgfCA3NiArKysrKysrKysrKysrKysrKysrCiBkcml2ZXJzL2dwdS9kcm0vaTkxNS9pbnRlbF9k
cF9tc3QuYyAgICAgICAgICAgfCA0NiArKysrKystLS0tLQogZHJpdmVycy9ncHUvZHJtL2k5MTUv
aW50ZWxfZHJ2LmggICAgICAgICAgICAgIHwgIDEgKwogZHJpdmVycy9ncHUvZHJtL25vdXZlYXUv
ZGlzcG52NTAvZGlzcC5jICAgICAgIHwgMjUgKysrLS0tCiBpbmNsdWRlL2RybS9kcm1fZHBfbXN0
X2hlbHBlci5oICAgICAgICAgICAgICAgfCAgMyArCiA2IGZpbGVzIGNoYW5nZWQsIDEzMiBpbnNl
cnRpb25zKCspLCAzMSBkZWxldGlvbnMoLSkKCi0tIAoyLjE3LjEKCl9fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmRyaS1kZXZlbCBtYWlsaW5nIGxpc3QKZHJp
LWRldmVsQGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9y
Zy9tYWlsbWFuL2xpc3RpbmZvL2RyaS1kZXZlbAo=
