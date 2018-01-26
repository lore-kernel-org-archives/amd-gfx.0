From: Tom St Denis <tom.stdenis@amd.com>
Subject: [PATCH 11/12] drm/ttm: Fix 'buf' pointer update in
 ttm_bo_vm_access_kmap()
Date: Fri, 26 Jan 2018 13:29:10 -0500
Message-ID: <20180126182911.20761-12-tom.stdenis@amd.com>
References: <20180126182911.20761-1-tom.stdenis@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <dri-devel-bounces@lists.freedesktop.org>
In-Reply-To: <20180126182911.20761-1-tom.stdenis@amd.com>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
To: amd-gfx@lists.freedesktop.org
Cc: Tom St Denis <tom.stdenis@amd.com>, dri-devel@lists.freedesktop.org
List-Id: amd-gfx.lists.freedesktop.org

U2lnbmVkLW9mZi1ieTogVG9tIFN0IERlbmlzIDx0b20uc3RkZW5pc0BhbWQuY29tPgotLS0KIGRy
aXZlcnMvZ3B1L2RybS90dG0vdHRtX2JvX3ZtLmMgfCAxICsKIDEgZmlsZSBjaGFuZ2VkLCAxIGlu
c2VydGlvbigrKQoKZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS90dG0vdHRtX2JvX3ZtLmMg
Yi9kcml2ZXJzL2dwdS9kcm0vdHRtL3R0bV9ib192bS5jCmluZGV4IDA3YjIyZjA0Yjk2OS4uNjMx
MWY4YTQ4MWVhIDEwMDY0NAotLS0gYS9kcml2ZXJzL2dwdS9kcm0vdHRtL3R0bV9ib192bS5jCisr
KyBiL2RyaXZlcnMvZ3B1L2RybS90dG0vdHRtX2JvX3ZtLmMKQEAgLTM0NSw2ICszNDUsNyBAQCBz
dGF0aWMgaW50IHR0bV9ib192bV9hY2Nlc3Nfa21hcChzdHJ1Y3QgdHRtX2J1ZmZlcl9vYmplY3Qg
KmJvLAogCQlwYWdlKys7CiAJCWJ5dGVzX2xlZnQgLT0gYnl0ZXM7CiAJCW9mZnNldCA9IDA7CisJ
CWJ1ZiArPSBieXRlczsKIAl9IHdoaWxlIChieXRlc19sZWZ0KTsKIAogCXJldHVybiBsZW47Ci0t
IAoyLjE0LjMKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
CmRyaS1kZXZlbCBtYWlsaW5nIGxpc3QKZHJpLWRldmVsQGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpo
dHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2RyaS1kZXZlbAo=
