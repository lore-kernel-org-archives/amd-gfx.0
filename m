From: Huang Rui <ray.huang-5C7GfCeVMHo@public.gmane.org>
Subject: [PATCH v2 09/15] drm/amdgpu: fix the tahiti specific value of
 DEEP_SLEEP_CLK_SEL field
Date: Wed, 31 Aug 2016 13:23:21 +0800
Message-ID: <1472621007-17578-10-git-send-email-ray.huang@amd.com>
References: <1472621007-17578-1-git-send-email-ray.huang@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <1472621007-17578-1-git-send-email-ray.huang-5C7GfCeVMHo@public.gmane.org>
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
To: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org>, =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig-5C7GfCeVMHo@public.gmane.org>
Cc: Ken Wang <Qingqing.Wang-5C7GfCeVMHo@public.gmane.org>, Hui Yu <Hui.Yu-5C7GfCeVMHo@public.gmane.org>, Huang Rui <ray.huang-5C7GfCeVMHo@public.gmane.org>, Alvin Huan <Alvin.Huan-5C7GfCeVMHo@public.gmane.org>

QWNrZWQtYnk6IENocmlzdGlhbiBLw7ZuaWcgPGNocmlzdGlhbi5rb2VuaWdAYW1kLmNvbT4KUmV2
aWV3ZWQtYnk6IEFsZXggRGV1Y2hlciA8YWxleGFuZGVyLmRldWNoZXJAYW1kLmNvbT4KU2lnbmVk
LW9mZi1ieTogSHVhbmcgUnVpIDxyYXkuaHVhbmdAYW1kLmNvbT4KLS0tCiBkcml2ZXJzL2dwdS9k
cm0vYW1kL2FtZGdwdS9zaV9kcG0uYyB8IDggKysrKysrKy0KIDEgZmlsZSBjaGFuZ2VkLCA3IGlu
c2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkKCmRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0v
YW1kL2FtZGdwdS9zaV9kcG0uYyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L3NpX2RwbS5j
CmluZGV4IGM5YjA5ODkuLjUyNjljMzMgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQv
YW1kZ3B1L3NpX2RwbS5jCisrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L3NpX2RwbS5j
CkBAIC00MTczLDcgKzQxNzMsMTMgQEAgc3RhdGljIHZvaWQgc2lfcHJvZ3JhbV9yZXNwb25zZV90
aW1lcyhzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRldikKIHN0YXRpYyB2b2lkIHNpX3Byb2dyYW1f
ZHNfcmVnaXN0ZXJzKHN0cnVjdCBhbWRncHVfZGV2aWNlICphZGV2KQogewogCXN0cnVjdCBldmVy
Z3JlZW5fcG93ZXJfaW5mbyAqZWdfcGkgPSBldmVyZ3JlZW5fZ2V0X3BpKGFkZXYpOwotCXUzMiB0
bXAgPSAxOyAvKiBYWFg6IDB4MTAgb24gdGFoaXRpIEEwICovCisJdTMyIHRtcDsKKworCS8qIERF
RVBfU0xFRVBfQ0xLX1NFTCBmaWVsZCBzaG91bGQgYmUgMHgxMCBvbiB0YWhpdGkgQTAgKi8KKwlp
ZiAoYWRldi0+YXNpY190eXBlID09IENISVBfVEFISVRJICYmIGFkZXYtPnJldl9pZCA9PSAweDAp
CisJCXRtcCA9IDB4MTA7CisJZWxzZQorCQl0bXAgPSAweDE7CiAKIAlpZiAoZWdfcGktPnNjbGtf
ZGVlcF9zbGVlcCkgewogCQlXUkVHMzJfUChNSVNDX0NMS19DTlRMLCBERUVQX1NMRUVQX0NMS19T
RUwodG1wKSwgfkRFRVBfU0xFRVBfQ0xLX1NFTF9NQVNLKTsKLS0gCjIuNy40CgpfX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlz
dAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9w
Lm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZngK
