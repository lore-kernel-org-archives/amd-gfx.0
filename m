From: Matthias Kaehlcke <mka@chromium.org>
Subject: [PATCH v3 3/4] amdgpu/dc/dml: Support clang option for stack alignment
Date: Thu,  8 Feb 2018 12:53:15 -0800
Message-ID: <20180208205316.93330-3-mka@chromium.org>
References: <20180208205316.93330-1-mka@chromium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <dri-devel-bounces@lists.freedesktop.org>
In-Reply-To: <20180208205316.93330-1-mka@chromium.org>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
To: Alex Deucher <alexander.deucher@amd.com>, =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, David Zhou <David1.Zhou@amd.com>, David Airlie <airlied@linux.ie>, Harry Wentland <harry.wentland@amd.com>, Felix Kuehling <Felix.Kuehling@amd.com>, Dmytro Laktyushkin <Dmytro.Laktyushkin@amd.com>
Cc: Craig Bergstrom <craigb@chromium.org>, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, Justin TerAvest <teravest@chromium.org>, Matthias Kaehlcke <mka@chromium.org>, amd-gfx@lists.freedesktop.org, Guenter Roeck <groeck@chromium.org>
List-Id: amd-gfx.lists.freedesktop.org

RE1MIHVzZXMgdGhlIGNvbXBpbGVyIG9wdGlvbiAtbXByZWZlcnJlZC1zdGFjay1ib3VuZGFyeT00
IHRvIGNvbmZpZ3VyZQphIHN0YWNrIGFsaWdubWVudCBvZiAxNiBieXRlcy4gQ2xhbmcgdXNlcyB0
aGUgb3B0aW9uIC1tc3RhY2stYWxpZ25tZW50Cmluc3RlYWQsIHdoaWNoIGV4cGVjdHMgYXMgcGFy
YW1ldGVyIHRoZSBhbGlnbm1lbnQgaW4gYnl0ZXMsIGFuZCBub3QgYQpwb3dlciBvZiB0d28gbGlr
ZSAtbXByZWZlcnJlZC1zdGFjay1ib3VuZGFyeS4KClByb2JlIGZvciBib3RoIGNvbXBpbGVyIG9w
dGlvbnMgYW5kIHVzZSB0aGUgY29ycmVjdCBvbmUsIHNpbWlsYXIgdG8Kd2hhdCBpcyBkb25lIGlu
IGFyY2gveDg2L01ha2VmaWxlLgoKUmVwb3J0ZWQtYnk6IEd1ZW50ZXIgUm9lY2sgPGdyb2Vja0Bj
aHJvbWl1bS5vcmc+ClNpZ25lZC1vZmYtYnk6IE1hdHRoaWFzIEthZWhsY2tlIDxta2FAY2hyb21p
dW0ub3JnPgotLS0KQ2hhbmdlcyBpbiB2MzoKLSBhZGFwdGVkIHVzZSBvZiB2YXJpYWJsZSBpbnN0
ZWFkIG9mIHN1YmRpci1jY2ZsYWdzLXkKCiBkcml2ZXJzL2dwdS9kcm0vYW1kL2Rpc3BsYXkvZGMv
ZG1sL01ha2VmaWxlIHwgOCArKysrKysrLQogMSBmaWxlIGNoYW5nZWQsIDcgaW5zZXJ0aW9ucygr
KSwgMSBkZWxldGlvbigtKQoKZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxh
eS9kYy9kbWwvTWFrZWZpbGUgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2Rpc3BsYXkvZGMvZG1sL01h
a2VmaWxlCmluZGV4IDk2YjMzN2EwMzE3Mi4uNzgyODg2Y2FjNjFjIDEwMDY0NAotLS0gYS9kcml2
ZXJzL2dwdS9kcm0vYW1kL2Rpc3BsYXkvZGMvZG1sL01ha2VmaWxlCisrKyBiL2RyaXZlcnMvZ3B1
L2RybS9hbWQvZGlzcGxheS9kYy9kbWwvTWFrZWZpbGUKQEAgLTI0LDcgKzI0LDEzIEBACiAjIEl0
IHByb3ZpZGVzIHRoZSBnZW5lcmFsIGJhc2ljIHNlcnZpY2VzIHJlcXVpcmVkIGJ5IG90aGVyIERB
TAogIyBzdWJjb21wb25lbnRzLgogCi1kbWxfY2NmbGFncyA6PSAtbWhhcmQtZmxvYXQgLW1zc2Ug
LW1wcmVmZXJyZWQtc3RhY2stYm91bmRhcnk9NAoraWZuZXEgKCQoY2FsbCBjYy1vcHRpb24sIC1t
cHJlZmVycmVkLXN0YWNrLWJvdW5kYXJ5PTQpLCkKKwljY19zdGFja19hbGlnbiA6PSAtbXByZWZl
cnJlZC1zdGFjay1ib3VuZGFyeT00CitlbHNlIGlmbmVxICgkKGNhbGwgY2Mtb3B0aW9uLCAtbXN0
YWNrLWFsaWdubWVudD0xNiksKQorCWNjX3N0YWNrX2FsaWduIDo9IC1tc3RhY2stYWxpZ25tZW50
PTE2CitlbmRpZgorCitkbWxfY2NmbGFncyA6PSAtbWhhcmQtZmxvYXQgLW1zc2UgJChjY19zdGFj
a19hbGlnbikKIAogQ0ZMQUdTX2Rpc3BsYXlfbW9kZV92YmEubyA6PSAkKGRtbF9jY2ZsYWdzKQog
Q0ZMQUdTX2Rpc3BsYXlfbW9kZV9saWIubyA6PSAkKGRtbF9jY2ZsYWdzKQotLSAKMi4xNi4wLnJj
MS4yMzguZzUzMGQ2NDlhNzktZ29vZwoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX18KZHJpLWRldmVsIG1haWxpbmcgbGlzdApkcmktZGV2ZWxAbGlzdHMuZnJl
ZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGlu
Zm8vZHJpLWRldmVsCg==
