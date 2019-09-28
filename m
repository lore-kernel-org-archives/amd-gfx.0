From: Saurav Girepunje <saurav.girepunje@gmail.com>
Subject: [PATCH] gpu: drm: amd: amdgpu: Remove call to memset after
 dma_alloc_coherent
Date: Sat, 28 Sep 2019 14:37:29 +0530
Message-ID: <20190928090725.GA11659@saurav>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <dri-devel-bounces@lists.freedesktop.org>
Content-Disposition: inline
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
To: alexander.deucher@amd.com, christian.koenig@amd.com, David1.Zhou@amd.com, airlied@linux.ie, daniel@ffwll.ch, saurav.girepunje@gmail.com, sam@ravnborg.org, michel.daenzer@amd.com, amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, gregkh@linuxfoundation.org
Cc: saurav.girepunje@hotmail.com
List-Id: amd-gfx.lists.freedesktop.org

ZG1hX2FsbG9jX2NvaGVyZW50IGhhcyBhbHJlYWR5IHplcm9lZCB0aGUgbWVtb3J5LgpTbyBtZW1z
ZXQgaXMgbm90IG5lZWRlZC4KClNpZ25lZC1vZmYtYnk6IFNhdXJhdiBHaXJlcHVuamUgPHNhdXJh
di5naXJlcHVuamVAZ21haWwuY29tPgotLS0KIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2Ft
ZGdwdV9paC5jIHwgMSAtCiAxIGZpbGUgY2hhbmdlZCwgMSBkZWxldGlvbigtKQoKZGlmZiAtLWdp
dCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9paC5jIGIvZHJpdmVycy9ncHUv
ZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2loLmMKaW5kZXggNmQ4ZjA1NTExYWJhLi4xMTFhMzAxY2U4
NzggMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9paC5jCisr
KyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9paC5jCkBAIC02Niw3ICs2Niw2
IEBAIGludCBhbWRncHVfaWhfcmluZ19pbml0KHN0cnVjdCBhbWRncHVfZGV2aWNlICphZGV2LCBz
dHJ1Y3QgYW1kZ3B1X2loX3JpbmcgKmloLAogCQlpZiAoaWgtPnJpbmcgPT0gTlVMTCkKIAkJCXJl
dHVybiAtRU5PTUVNOwogCi0JCW1lbXNldCgodm9pZCAqKWloLT5yaW5nLCAwLCBpaC0+cmluZ19z
aXplICsgOCk7CiAJCWloLT5ncHVfYWRkciA9IGRtYV9hZGRyOwogCQlpaC0+d3B0cl9hZGRyID0g
ZG1hX2FkZHIgKyBpaC0+cmluZ19zaXplOwogCQlpaC0+d3B0cl9jcHUgPSAmaWgtPnJpbmdbaWgt
PnJpbmdfc2l6ZSAvIDRdOwotLSAKMi4yMC4xCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fXwpkcmktZGV2ZWwgbWFpbGluZyBsaXN0CmRyaS1kZXZlbEBsaXN0
cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9s
aXN0aW5mby9kcmktZGV2ZWw=
