From: Lyude Paul <lyude-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH v7 04/20] drm/dp_mst: Fix some formatting in
 drm_dp_mst_deallocate_vcpi()
Date: Thu, 10 Jan 2019 19:53:27 -0500
Message-ID: <20190111005343.17443-5-lyude@redhat.com>
References: <20190111005343.17443-1-lyude@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <20190111005343.17443-1-lyude-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/amd-gfx>,
 <mailto:amd-gfx-request-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
List-Help: <mailto:amd-gfx-request-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org?subject=subscribe>
Errors-To: amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Sender: "amd-gfx" <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
To: dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, nouveau-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, intel-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Cc: Jerry Zuo <Jerry.Zuo-5C7GfCeVMHo@public.gmane.org>, Daniel Vetter <daniel-/w4YWyX8dFk@public.gmane.org>, David Airlie <airlied-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, Harry Wentland <harry.wentland-5C7GfCeVMHo@public.gmane.org>, Juston Li <juston.li-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>

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
X19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3Rv
cC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQt
Z2Z4Cg==
