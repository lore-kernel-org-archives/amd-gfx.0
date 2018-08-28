From: Lyude Paul <lyude@redhat.com>
Subject: [PATCH 0/4] drm/dp_mst: Add DP MST debugfs nodes for
 all drivers
Date: Mon, 27 Aug 2018 20:36:23 -0400
Message-ID: <20180828003635.8200-1-lyude@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <intel-gfx-bounces@lists.freedesktop.org>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/intel-gfx>,
 <mailto:intel-gfx-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/intel-gfx>
List-Post: <mailto:intel-gfx@lists.freedesktop.org>
List-Help: <mailto:intel-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/intel-gfx>,
 <mailto:intel-gfx-request@lists.freedesktop.org?subject=subscribe>
Errors-To: intel-gfx-bounces@lists.freedesktop.org
Sender: "Intel-gfx" <intel-gfx-bounces@lists.freedesktop.org>
To: dri-devel@lists.freedesktop.org
Cc: David Airlie <airlied@linux.ie>, Roman Li <roman.li@amd.com>, amd-gfx@lists.freedesktop.org, "David (ChunMing) Zhou" <david1.zhou@amd.com>, "Jerry (Fangzhi) Zuo" <jerry.zuo@amd.com>, Ben Skeggs <bskeggs@redhat.com>, Daniel Vetter <daniel.vetter@ffwll.ch>, Thierry Reding <treding@nvidia.com>, Harry Wentland <harry.wentland@amd.com>, Andrey Grodzovsky <andrey.grodzovsky@amd.com>, Leo Li <sunpeng.li@amd.com>, intel-gfx@lists.freedesktop.org, Sean Paul <seanpaul@chromium.org>, Rodrigo Vivi <rodrigo.vivi@intel.com>, nouveau@lists.freedesktop.org, Tony Cheng <tony.cheng@amd.com>, linux-kernel@vger.kernel.org, Shirish S <shirish.s@amd.com>, Alex Deucher <alexander.deucher@amd.com>, =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
List-Id: amd-gfx.lists.freedesktop.org

VGhpcyBpcyB0aGUgbmV4dCB2ZXJzaW9uIG9mIG15IHBhdGNoIHNlcmllcyBmb3IgdGVhY2hpbmcg
RFJNIGhvdyB0bwphdXRvbWF0aWNhbGx5IGNyZWF0ZSBkZWJ1Z2ZzIG5vZGVzIGZvciBkcml2ZXJz
IHdpdGggTVNUIHRvcG9sb2dpZXMuIFRoaXMKd2FzIG9yaWdpbmFsbHkgaW50ZW5kZWQganVzdCBm
b3Igbm91dmVhdSwgYnV0IGhhcyBzaW5jZSBiZWVuIGV4cGFuZGVkIHRvCmFsbCBEUk0gZHJpdmVy
cy4KCkNjOiBNYWFydGVuIExhbmtob3JzdCA8bWFhcnRlbi5sYW5raG9yc3RAbGludXguaW50ZWwu
Y29tPgpDYzogRGFuaWVsIFN0b25lIDxkYW5pZWxAZm9vaXNoYmFyLm9yZz4KCkx5dWRlIFBhdWwg
KDQpOgogIGRybS9kZWJ1Z2ZzOiBBZGQgc3VwcG9ydCBmb3IgZHluYW1pYyBkZWJ1Z2ZzIGluaXRp
YWxpemF0aW9uCiAgZHJtL2RwX21zdDogUGFzcyBlbnRpcmUgY29ubmVjdG9yIHRvIGRybV9kcF9t
c3RfdG9wb2xvZ3lfbWdyX2luaXQoKQogIGRybS9kcF9tc3Q6IEFkZCBkcF9tc3Rfc3RhdHVzIGRl
YnVnZnMgbm9kZSBmb3IgYWxsIGRyaXZlcnMKICBkcm0vaTkxNTogUmVtb3ZlIGk5MTVfZHJtX2Rw
X21zdF9zdGF0dXMKCiAuLi4vZGlzcGxheS9hbWRncHVfZG0vYW1kZ3B1X2RtX21zdF90eXBlcy5j
ICAgfCAgIDIgKy0KIGRyaXZlcnMvZ3B1L2RybS9kcm1fZGVidWdmcy5jICAgICAgICAgICAgICAg
ICB8IDE3MyArKysrKysrKysrKysrKysrKy0KIGRyaXZlcnMvZ3B1L2RybS9kcm1fZHBfbXN0X3Rv
cG9sb2d5LmMgICAgICAgICB8IDExNCArKysrKysrKysrKy0KIGRyaXZlcnMvZ3B1L2RybS9kcm1f
ZHJ2LmMgICAgICAgICAgICAgICAgICAgICB8ICAgMyArCiBkcml2ZXJzL2dwdS9kcm0vZHJtX2lu
dGVybmFsLmggICAgICAgICAgICAgICAgfCAgIDUgKwogZHJpdmVycy9ncHUvZHJtL2k5MTUvaTkx
NV9kZWJ1Z2ZzLmMgICAgICAgICAgIHwgIDMyIC0tLS0KIGRyaXZlcnMvZ3B1L2RybS9pOTE1L2lu
dGVsX2RwLmMgICAgICAgICAgICAgICB8ICAgMiArLQogZHJpdmVycy9ncHUvZHJtL2k5MTUvaW50
ZWxfZHBfbXN0LmMgICAgICAgICAgIHwgICA2ICstCiBkcml2ZXJzL2dwdS9kcm0vaTkxNS9pbnRl
bF9kcnYuaCAgICAgICAgICAgICAgfCAgIDMgKy0KIGRyaXZlcnMvZ3B1L2RybS9ub3V2ZWF1L2Rp
c3BudjUwL2Rpc3AuYyAgICAgICB8ICAgNiArLQogZHJpdmVycy9ncHUvZHJtL3JhZGVvbi9yYWRl
b25fZHBfbXN0LmMgICAgICAgIHwgICAyICstCiBpbmNsdWRlL2RybS9kcm1fZGVidWdmcy5oICAg
ICAgICAgICAgICAgICAgICAgfCAgMjcgKysrCiBpbmNsdWRlL2RybS9kcm1fZHBfbXN0X2hlbHBl
ci5oICAgICAgICAgICAgICAgfCAgMTcgKy0KIGluY2x1ZGUvZHJtL2RybV9maWxlLmggICAgICAg
ICAgICAgICAgICAgICAgICB8ICAgNCArCiAxNCBmaWxlcyBjaGFuZ2VkLCAzNDIgaW5zZXJ0aW9u
cygrKSwgNTQgZGVsZXRpb25zKC0pCgotLSAKMi4xNy4xCgpfX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fXwpJbnRlbC1nZnggbWFpbGluZyBsaXN0CkludGVsLWdm
eEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFp
bG1hbi9saXN0aW5mby9pbnRlbC1nZngK
