From: Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH] drm/amd/display: return 'NULL' instead of 'false' from
 dcn20_acquire_idle_pipe_for_layer
Date: Fri, 12 Jul 2019 11:39:52 +0200
Message-ID: <20190712094009.1535662-1-arnd@arndb.de>
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
To: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>, Alex Deucher <alexander.deucher@amd.com>, =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, "David (ChunMing) Zhou" <David1.Zhou@amd.com>, David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>
Cc: Charlene Liu <charlene.liu@amd.com>, Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org, amd-gfx@lists.freedesktop.org, Nikola Cornij <nikola.cornij@amd.com>, clang-built-linux@googlegroups.com, Dmytro Laktyushkin <Dmytro.Laktyushkin@amd.com>, dri-devel@lists.freedesktop.org, Jun Lei <Jun.Lei@amd.com>, Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>
List-Id: amd-gfx.lists.freedesktop.org

Y2xhbmcgY29tcGxhaW5zIHRoYXQgJ2ZhbHNlJyBpcyBhIG5vdCBhIHBvaW50ZXI6Cgpkcml2ZXJz
L2dwdS9kcm0vYW1kL2FtZGdwdS8uLi9kaXNwbGF5L2RjL2RjbjIwL2RjbjIwX3Jlc291cmNlLmM6
MjQyODoxMDogZXJyb3I6IGV4cHJlc3Npb24gd2hpY2ggZXZhbHVhdGVzIHRvIHplcm8gdHJlYXRl
ZCBhcyBhIG51bGwgcG9pbnRlciBjb25zdGFudCBvZiB0eXBlICdzdHJ1Y3QgcGlwZV9jdHggKicg
Wy1XZXJyb3IsLVdub24tbGl0ZXJhbC1udWxsLWNvbnZlcnNpb25dCiAgICAgICAgICAgICAgICBy
ZXR1cm4gZmFsc2U7CgpDaGFuZ2luZyBpdCB0byAnTlVMTCcgbG9va3MgbGlrZSB0aGUgcmlnaHQg
dGhpbmcgdGhhdCB3aWxsIHNodXQgdXAKdGhlIHdhcm5pbmcgYW5kIG1ha2UgaXQgZWFzaWVyIHRv
IHJlYWQsIHdoaWxlIG5vdCBjaGFuZ2luZyBiZWhhdmlvci4KCkZpeGVzOiA3ZWQ0ZTYzNTJjMTYg
KCJkcm0vYW1kL2Rpc3BsYXk6IEFkZCBEQ04yIEhXIFNlcXVlbmNlciBhbmQgUmVzb3VyY2UiKQpT
aWduZWQtb2ZmLWJ5OiBBcm5kIEJlcmdtYW5uIDxhcm5kQGFybmRiLmRlPgotLS0KIGRyaXZlcnMv
Z3B1L2RybS9hbWQvZGlzcGxheS9kYy9kY24yMC9kY24yMF9yZXNvdXJjZS5jIHwgMiArLQogMSBm
aWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspLCAxIGRlbGV0aW9uKC0pCgpkaWZmIC0tZ2l0IGEv
ZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5L2RjL2RjbjIwL2RjbjIwX3Jlc291cmNlLmMgYi9k
cml2ZXJzL2dwdS9kcm0vYW1kL2Rpc3BsYXkvZGMvZGNuMjAvZGNuMjBfcmVzb3VyY2UuYwppbmRl
eCA3MGFjOGE5NWQyZGIuLjY2YWE0MTRhZDM4ZiAxMDA2NDQKLS0tIGEvZHJpdmVycy9ncHUvZHJt
L2FtZC9kaXNwbGF5L2RjL2RjbjIwL2RjbjIwX3Jlc291cmNlLmMKKysrIGIvZHJpdmVycy9ncHUv
ZHJtL2FtZC9kaXNwbGF5L2RjL2RjbjIwL2RjbjIwX3Jlc291cmNlLmMKQEAgLTI0MjUsNyArMjQy
NSw3IEBAIHN0cnVjdCBwaXBlX2N0eCAqZGNuMjBfYWNxdWlyZV9pZGxlX3BpcGVfZm9yX2xheWVy
KAogCQlBU1NFUlQoMCk7CiAKIAlpZiAoIWlkbGVfcGlwZSkKLQkJcmV0dXJuIGZhbHNlOworCQly
ZXR1cm4gTlVMTDsKIAogCWlkbGVfcGlwZS0+c3RyZWFtID0gaGVhZF9waXBlLT5zdHJlYW07CiAJ
aWRsZV9waXBlLT5zdHJlYW1fcmVzLnRnID0gaGVhZF9waXBlLT5zdHJlYW1fcmVzLnRnOwotLSAK
Mi4yMC4wCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpk
cmktZGV2ZWwgbWFpbGluZyBsaXN0CmRyaS1kZXZlbEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0
cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9kcmktZGV2ZWw=
