From: Matthias Kaehlcke <mka@chromium.org>
Subject: [PATCH 2/2] amdgpu/dc/dml: Support clang option for stack alignment
Date: Wed,  7 Feb 2018 17:21:56 -0800
Message-ID: <20180208012156.165934-2-mka@chromium.org>
References: <20180208012156.165934-1-mka@chromium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <dri-devel-bounces@lists.freedesktop.org>
In-Reply-To: <20180208012156.165934-1-mka@chromium.org>
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
dW0ub3JnPgotLS0KIGRyaXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxheS9kYy9kbWwvTWFrZWZpbGUg
fCA4ICsrKysrKystCiAxIGZpbGUgY2hhbmdlZCwgNyBpbnNlcnRpb25zKCspLCAxIGRlbGV0aW9u
KC0pCgpkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5L2RjL2RtbC9NYWtl
ZmlsZSBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxheS9kYy9kbWwvTWFrZWZpbGUKaW5kZXgg
YjhjYWRmODMzZTcxLi43NDA5NzU5MzFkMjEgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvZ3B1L2RybS9h
bWQvZGlzcGxheS9kYy9kbWwvTWFrZWZpbGUKKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNw
bGF5L2RjL2RtbC9NYWtlZmlsZQpAQCAtMjQsNyArMjQsMTMgQEAKICMgSXQgcHJvdmlkZXMgdGhl
IGdlbmVyYWwgYmFzaWMgc2VydmljZXMgcmVxdWlyZWQgYnkgb3RoZXIgREFMCiAjIHN1YmNvbXBv
bmVudHMuCiAKLXN1YmRpci1jY2ZsYWdzLXkgKz0gLW1oYXJkLWZsb2F0IC1tc3NlIC1tcHJlZmVy
cmVkLXN0YWNrLWJvdW5kYXJ5PTQKK2lmbmVxICgkKGNhbGwgY2Mtb3B0aW9uLCAtbXByZWZlcnJl
ZC1zdGFjay1ib3VuZGFyeT00KSwpCisJY2Nfc3RhY2tfYWxpZ249LW1wcmVmZXJyZWQtc3RhY2st
Ym91bmRhcnk9NAorZWxzZSBpZm5lcSAoJChjYWxsIGNjLW9wdGlvbiwgLW1zdGFjay1hbGlnbm1l
bnQ9MTYpLCkKKwljY19zdGFja19hbGlnbiA6PSAtbXN0YWNrLWFsaWdubWVudD0xNgorZW5kaWYK
Kworc3ViZGlyLWNjZmxhZ3MteSArPSAtbWhhcmQtZmxvYXQgLW1zc2UgJChjY19zdGFja19hbGln
bikKIAogRE1MID0gZGlzcGxheV9tb2RlX2xpYi5vIGRpc3BsYXlfcnFfZGxnX2NhbGMubyBcCiAJ
ICBkaXNwbGF5X3JxX2RsZ19oZWxwZXJzLm8gZG1sMV9kaXNwbGF5X3JxX2RsZ19jYWxjLm8gXAot
LSAKMi4xNi4wLnJjMS4yMzguZzUzMGQ2NDlhNzktZ29vZwoKX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX18KZHJpLWRldmVsIG1haWxpbmcgbGlzdApkcmktZGV2
ZWxAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21h
aWxtYW4vbGlzdGluZm8vZHJpLWRldmVsCg==
