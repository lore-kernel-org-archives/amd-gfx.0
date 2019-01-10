From: Lyude Paul <lyude@redhat.com>
Subject: [PATCH v6 04/20] drm/dp_mst: Fix some formatting in
 drm_dp_mst_deallocate_vcpi()
Date: Thu, 10 Jan 2019 14:57:38 -0500
Message-ID: <20190110195753.6234-5-lyude@redhat.com>
References: <20190110195753.6234-1-lyude@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <intel-gfx-bounces@lists.freedesktop.org>
In-Reply-To: <20190110195753.6234-1-lyude@redhat.com>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/intel-gfx>,
 <mailto:intel-gfx-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/intel-gfx>
List-Post: <mailto:intel-gfx@lists.freedesktop.org>
List-Help: <mailto:intel-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/intel-gfx>,
 <mailto:intel-gfx-request@lists.freedesktop.org?subject=subscribe>
Errors-To: intel-gfx-bounces@lists.freedesktop.org
Sender: "Intel-gfx" <intel-gfx-bounces@lists.freedesktop.org>
To: dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org, nouveau@lists.freedesktop.org, intel-gfx@lists.freedesktop.org
Cc: Jerry Zuo <Jerry.Zuo@amd.com>, David Airlie <airlied@redhat.com>, Harry Wentland <harry.wentland@amd.com>
List-Id: amd-gfx.lists.freedesktop.org

U3BsaXQgc29tZSBzdHVmZiBhY3Jvc3MgbXVsdGlwbGUgbGluZXMKClNpZ25lZC1vZmYtYnk6IEx5
dWRlIFBhdWwgPGx5dWRlQHJlZGhhdC5jb20+ClJldmlld2VkLWJ5OiBIYXJyeSBXZW50bGFuZCA8
aGFycnkud2VudGxhbmRAYW1kLmNvbT4KUmV2aWV3ZWQtYnk6IERhbmllbCBWZXR0ZXIgPGRhbmll
bEBmZndsbC5jaD4KQ2M6IERhdmlkIEFpcmxpZSA8YWlybGllZEByZWRoYXQuY29tPgpDYzogSmVy
cnkgWnVvIDxKZXJyeS5adW9AYW1kLmNvbT4KQ2M6IEp1c3RvbiBMaSA8anVzdG9uLmxpQGludGVs
LmNvbT4KLS0tCiBkcml2ZXJzL2dwdS9kcm0vZHJtX2RwX21zdF90b3BvbG9neS5jIHwgMyArKy0K
IDEgZmlsZSBjaGFuZ2VkLCAyIGluc2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkKCmRpZmYgLS1n
aXQgYS9kcml2ZXJzL2dwdS9kcm0vZHJtX2RwX21zdF90b3BvbG9neS5jIGIvZHJpdmVycy9ncHUv
ZHJtL2RybV9kcF9tc3RfdG9wb2xvZ3kuYwppbmRleCBhNjNhNGQzMjk2MmEuLjc1Y2NhNmE4NDNm
YiAxMDA2NDQKLS0tIGEvZHJpdmVycy9ncHUvZHJtL2RybV9kcF9tc3RfdG9wb2xvZ3kuYworKysg
Yi9kcml2ZXJzL2dwdS9kcm0vZHJtX2RwX21zdF90b3BvbG9neS5jCkBAIC0yNzkwLDcgKzI3OTAs
OCBAQCBFWFBPUlRfU1lNQk9MKGRybV9kcF9tc3RfcmVzZXRfdmNwaV9zbG90cyk7CiAgKiBAbWdy
OiBtYW5hZ2VyIGZvciB0aGlzIHBvcnQKICAqIEBwb3J0OiB1bnZlcmlmaWVkIHBvcnQgdG8gZGVh
bGxvY2F0ZSB2Y3BpIGZvcgogICovCi12b2lkIGRybV9kcF9tc3RfZGVhbGxvY2F0ZV92Y3BpKHN0
cnVjdCBkcm1fZHBfbXN0X3RvcG9sb2d5X21nciAqbWdyLCBzdHJ1Y3QgZHJtX2RwX21zdF9wb3J0
ICpwb3J0KQordm9pZCBkcm1fZHBfbXN0X2RlYWxsb2NhdGVfdmNwaShzdHJ1Y3QgZHJtX2RwX21z
dF90b3BvbG9neV9tZ3IgKm1nciwKKwkJCQlzdHJ1Y3QgZHJtX2RwX21zdF9wb3J0ICpwb3J0KQog
ewogCXBvcnQgPSBkcm1fZHBfZ2V0X3ZhbGlkYXRlZF9wb3J0X3JlZihtZ3IsIHBvcnQpOwogCWlm
ICghcG9ydCkKLS0gCjIuMjAuMQoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX18KSW50ZWwtZ2Z4IG1haWxpbmcgbGlzdApJbnRlbC1nZnhAbGlzdHMuZnJlZWRl
c2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8v
aW50ZWwtZ2Z4Cg==
