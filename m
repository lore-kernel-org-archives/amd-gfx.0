From: Matthias Kaehlcke <mka@chromium.org>
Subject: [PATCH] amdgpu/dc: Add missing cast in
 dce_clock_set_min_clocks_state()
Date: Fri,  9 Feb 2018 13:28:34 -0800
Message-ID: <20180209212834.72129-1-mka@chromium.org>
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
To: Alex Deucher <alexander.deucher@amd.com>, =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, David Zhou <David1.Zhou@amd.com>, David Airlie <airlied@linux.ie>, Harry Wentland <harry.wentland@amd.com>, Tony Cheng <Tony.Cheng@amd.com>, Dmytro Laktyushkin <Dmytro.Laktyushkin@amd.com>
Cc: Craig Bergstrom <craigb@chromium.org>, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, Justin TerAvest <teravest@chromium.org>, Matthias Kaehlcke <mka@chromium.org>, amd-gfx@lists.freedesktop.org, Guenter Roeck <groeck@chromium.org>
List-Id: amd-gfx.lists.freedesktop.org

ZGNlX2Nsb2NrX3NldF9taW5fY2xvY2tzX3N0YXRlKCkgYXNzaWducyAoaW50ZW50aW9uYWxseSkg
YSB2YWx1ZSBvZiB0eXBlCidlbnVtIGRtX3BwX2Nsb2Nrc19zdGF0ZScgdG8gYSB2YXJpYWJsZSBv
ZiB0eXBlICdlbnVtIGRtX3BwX3Bvd2VyX2xldmVsJwp3aXRob3V0IGFuIGV4cGxpY2l0IGNhc3Qu
IFRoaXMgY2F1c2VzIGNsYW5nIHRvIHJhaXNlIHRoZSBmb2xsb3dpbmcKd2FybmluZzoKCmRyaXZl
cnMvZ3B1L2RybS9hbWQvYW1kZ3B1Ly4uL2Rpc3BsYXkvZGMvZGNlL2RjZV9jbG9ja3MuYzozMDg6
NDogZXJyb3I6CiAgaW1wbGljaXQgY29udmVyc2lvbiBmcm9tIGVudW1lcmF0aW9uIHR5cGUgJ2Vu
dW0gZG1fcHBfY2xvY2tzX3N0YXRlJwogIHRvIGRpZmZlcmVudCBlbnVtZXJhdGlvbiB0eXBlICdl
bnVtIGRtX3BwX3Bvd2VyX2xldmVsJyBbLVdlcnJvciwtV2VudW0tY29udmVyc2lvbl0KICAgIGNs
b2Nrc19zdGF0ZSB9OwoKTWFrZSB0aGUgY2FzdCBleHBsaWNpdC4KClNpZ25lZC1vZmYtYnk6IE1h
dHRoaWFzIEthZWhsY2tlIDxta2FAY2hyb21pdW0ub3JnPgotLS0KIGRyaXZlcnMvZ3B1L2RybS9h
bWQvZGlzcGxheS9kYy9kY2UvZGNlX2Nsb2Nrcy5jIHwgMyArKy0KIDEgZmlsZSBjaGFuZ2VkLCAy
IGluc2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkKCmRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9k
cm0vYW1kL2Rpc3BsYXkvZGMvZGNlL2RjZV9jbG9ja3MuYyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQv
ZGlzcGxheS9kYy9kY2UvZGNlX2Nsb2Nrcy5jCmluZGV4IDllOThhNWYzOWE2ZC4uZGIzY2ViMjgz
MjU1IDEwMDY0NAotLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2Rpc3BsYXkvZGMvZGNlL2RjZV9j
bG9ja3MuYworKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2Rpc3BsYXkvZGMvZGNlL2RjZV9jbG9j
a3MuYwpAQCAtMzA0LDcgKzMwNCw4IEBAIHN0YXRpYyBib29sIGRjZV9jbG9ja19zZXRfbWluX2Ns
b2Nrc19zdGF0ZSgKIAllbnVtIGRtX3BwX2Nsb2Nrc19zdGF0ZSBjbG9ja3Nfc3RhdGUpCiB7CiAJ
c3RydWN0IGRtX3BwX3Bvd2VyX2xldmVsX2NoYW5nZV9yZXF1ZXN0IGxldmVsX2NoYW5nZV9yZXEg
PSB7Ci0JCQljbG9ja3Nfc3RhdGUgfTsKKwkJLnBvd2VyX2xldmVsID0gKGVudW0gZG1fcHBfcG93
ZXJfbGV2ZWwpY2xvY2tzX3N0YXRlCisJfTsKIAogCWlmIChjbG9ja3Nfc3RhdGUgPiBjbGstPm1h
eF9jbGtzX3N0YXRlKSB7CiAJCS8qUmVxdWVzdGVkIHN0YXRlIGV4Y2VlZHMgbWF4IHN1cHBvcnRl
ZCBzdGF0ZS4qLwotLSAKMi4xNi4wLnJjMS4yMzguZzUzMGQ2NDlhNzktZ29vZwoKX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KZHJpLWRldmVsIG1haWxpbmcg
bGlzdApkcmktZGV2ZWxAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRl
c2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vZHJpLWRldmVsCg==
