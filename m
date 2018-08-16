From: Hans Verkuil <hverkuil@xs4all.nl>
Subject: [PATCH 3/5] drm_dp_mst_topology: fix broken
 drm_dp_sideband_parse_remote_dpcd_read()
Date: Thu, 16 Aug 2018 12:53:17 +0200
Message-ID: <20180816105319.6411-4-hverkuil@xs4all.nl>
References: <20180816105319.6411-1-hverkuil@xs4all.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <dri-devel-bounces@lists.freedesktop.org>
In-Reply-To: <20180816105319.6411-1-hverkuil@xs4all.nl>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
To: linux-media@vger.kernel.org
Cc: nouveau@lists.freedesktop.org, Hans Verkuil <hans.verkuil@cisco.com>, amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org
List-Id: amd-gfx.lists.freedesktop.org

RnJvbTogSGFucyBWZXJrdWlsIDxoYW5zLnZlcmt1aWxAY2lzY28uY29tPgoKV2hlbiBwYXJzaW5n
IHRoZSByZXBseSBvZiBhIERQX1JFTU9URV9EUENEX1JFQUQgRFBDRCBjb21tYW5kIHRoZQpyZXN1
bHQgaXMgd3JvbmcgZHVlIHRvIGEgbWlzc2luZyBpZHggaW5jcmVtZW50LgoKVGhpcyB3YXMgbmV2
ZXIgbm90aWNlZCBzaW5jZSBEUF9SRU1PVEVfRFBDRF9SRUFEIGlzIGN1cnJlbnRseSBub3QKdXNl
ZCwgYnV0IGlmIHlvdSBlbmFibGUgaXQsIHRoZW4gaXQgaXMgYWxsIHdyb25nLgoKU2lnbmVkLW9m
Zi1ieTogSGFucyBWZXJrdWlsIDxoYW5zLnZlcmt1aWxAY2lzY28uY29tPgotLS0KIGRyaXZlcnMv
Z3B1L2RybS9kcm1fZHBfbXN0X3RvcG9sb2d5LmMgfCAxICsKIDEgZmlsZSBjaGFuZ2VkLCAxIGlu
c2VydGlvbigrKQoKZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9kcm1fZHBfbXN0X3RvcG9s
b2d5LmMgYi9kcml2ZXJzL2dwdS9kcm0vZHJtX2RwX21zdF90b3BvbG9neS5jCmluZGV4IDc3ODA1
NjdhYTY2OS4uNWZmMWQ3OWI4NmM0IDEwMDY0NAotLS0gYS9kcml2ZXJzL2dwdS9kcm0vZHJtX2Rw
X21zdF90b3BvbG9neS5jCisrKyBiL2RyaXZlcnMvZ3B1L2RybS9kcm1fZHBfbXN0X3RvcG9sb2d5
LmMKQEAgLTQzOSw2ICs0MzksNyBAQCBzdGF0aWMgYm9vbCBkcm1fZHBfc2lkZWJhbmRfcGFyc2Vf
cmVtb3RlX2RwY2RfcmVhZChzdHJ1Y3QgZHJtX2RwX3NpZGViYW5kX21zZ19yeAogCWlmIChpZHgg
PiByYXctPmN1cmxlbikKIAkJZ290byBmYWlsX2xlbjsKIAlyZXBtc2ctPnUucmVtb3RlX2RwY2Rf
cmVhZF9hY2subnVtX2J5dGVzID0gcmF3LT5tc2dbaWR4XTsKKwlpZHgrKzsKIAlpZiAoaWR4ID4g
cmF3LT5jdXJsZW4pCiAJCWdvdG8gZmFpbF9sZW47CiAKLS0gCjIuMTguMAoKX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KZHJpLWRldmVsIG1haWxpbmcgbGlz
dApkcmktZGV2ZWxAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0
b3Aub3JnL21haWxtYW4vbGlzdGluZm8vZHJpLWRldmVsCg==
