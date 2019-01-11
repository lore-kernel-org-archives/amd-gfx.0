From: Lyude Paul <lyude@redhat.com>
Subject: [PATCH v7 12/20] drm/nouveau: Remove bogus cleanup in
 nv50_mstm_add_connector()
Date: Thu, 10 Jan 2019 19:53:35 -0500
Message-ID: <20190111005343.17443-13-lyude@redhat.com>
References: <20190111005343.17443-1-lyude@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <dri-devel-bounces@lists.freedesktop.org>
In-Reply-To: <20190111005343.17443-1-lyude@redhat.com>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
To: dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org, nouveau@lists.freedesktop.org, intel-gfx@lists.freedesktop.org
Cc: Jerry Zuo <Jerry.Zuo@amd.com>, Ben Skeggs <bskeggs@redhat.com>, David Airlie <airlied@redhat.com>, Juston Li <juston.li@intel.com>
List-Id: amd-gfx.lists.freedesktop.org

VHJ5aW5nIHRvIGRlc3Ryb3kgdGhlIGNvbm5lY3RvciB1c2luZyBtc3RjLT5jb25uZWN0b3IuZnVu
Y3MtPmRlc3Ryb3koKQppZiBjb25uZWN0b3IgaW5pdGlhbGl6YXRpb24gZmFpbHMgaXMgd3Jvbmc6
IHRoZXJlIGlzIG5vIHBvc3NpYmxlCmNvZGVwYXRoIGluIG52NTBfbXN0Y19uZXcgd2hlcmUgbnY1
MF9tc3RtX2FkZF9jb25uZWN0b3IoKSB3b3VsZCByZXR1cm4KPDAgYW5kIG1zdGMgd291bGQgYmUg
bm9uLU5VTEwuCgpTaWduZWQtb2ZmLWJ5OiBMeXVkZSBQYXVsIDxseXVkZUByZWRoYXQuY29tPgpS
ZXZpZXdlZC1CeTogQmVuIFNrZWdncyA8YnNrZWdnc0ByZWRoYXQuY29tPgpDYzogRGFuaWVsIFZl
dHRlciA8ZGFuaWVsQGZmd2xsLmNoPgpDYzogRGF2aWQgQWlybGllIDxhaXJsaWVkQHJlZGhhdC5j
b20+CkNjOiBKZXJyeSBadW8gPEplcnJ5Llp1b0BhbWQuY29tPgpDYzogSGFycnkgV2VudGxhbmQg
PGhhcnJ5LndlbnRsYW5kQGFtZC5jb20+CkNjOiBKdXN0b24gTGkgPGp1c3Rvbi5saUBpbnRlbC5j
b20+Ci0tLQogZHJpdmVycy9ncHUvZHJtL25vdXZlYXUvZGlzcG52NTAvZGlzcC5jIHwgNSArLS0t
LQogMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspLCA0IGRlbGV0aW9ucygtKQoKZGlmZiAt
LWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9ub3V2ZWF1L2Rpc3BudjUwL2Rpc3AuYyBiL2RyaXZlcnMv
Z3B1L2RybS9ub3V2ZWF1L2Rpc3BudjUwL2Rpc3AuYwppbmRleCBiYzA2YWE3OTM2M2YuLjgwMDIx
M2JlNzZlYSAxMDA2NDQKLS0tIGEvZHJpdmVycy9ncHUvZHJtL25vdXZlYXUvZGlzcG52NTAvZGlz
cC5jCisrKyBiL2RyaXZlcnMvZ3B1L2RybS9ub3V2ZWF1L2Rpc3BudjUwL2Rpc3AuYwpAQCAtMTA5
OCwxMSArMTA5OCw4IEBAIG52NTBfbXN0bV9hZGRfY29ubmVjdG9yKHN0cnVjdCBkcm1fZHBfbXN0
X3RvcG9sb2d5X21nciAqbWdyLAogCWludCByZXQ7CiAKIAlyZXQgPSBudjUwX21zdGNfbmV3KG1z
dG0sIHBvcnQsIHBhdGgsICZtc3RjKTsKLQlpZiAocmV0KSB7Ci0JCWlmIChtc3RjKQotCQkJbXN0
Yy0+Y29ubmVjdG9yLmZ1bmNzLT5kZXN0cm95KCZtc3RjLT5jb25uZWN0b3IpOworCWlmIChyZXQp
CiAJCXJldHVybiBOVUxMOwotCX0KIAogCXJldHVybiAmbXN0Yy0+Y29ubmVjdG9yOwogfQotLSAK
Mi4yMC4xCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpk
cmktZGV2ZWwgbWFpbGluZyBsaXN0CmRyaS1kZXZlbEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0
cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9kcmktZGV2ZWwK
