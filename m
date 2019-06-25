From: Harry Wentland <harry.wentland@amd.com>
Subject: [PATCH] drm/amd/display: Use msleep instead of udelay for 8ms wait
Date: Tue, 25 Jun 2019 10:00:46 -0400
Message-ID: <20190625140046.31682-1-harry.wentland@amd.com>
References: <CAPM=9txaQ43GwOzXSE3prTRLbMt+ip=s_ssmFzWsfsTYdLssaw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <dri-devel-bounces@lists.freedesktop.org>
In-Reply-To: <CAPM=9txaQ43GwOzXSE3prTRLbMt+ip=s_ssmFzWsfsTYdLssaw@mail.gmail.com>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
To: airlied@gmail.com, natechancellor@gmail.com
Cc: sunpeng.li@amd.com, Anthony.Koo@amd.com, linux-kernel@vger.kernel.org, amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, alexander.deucher@amd.com, Jun.Lei@amd.com, Bhawanpreet.Lakha@amd.com, christian.koenig@amd.com
List-Id: amd-gfx.lists.freedesktop.org

YXJtMzIncyB1ZGVsYXkgb25seSBhbGxvd3MgdmFsdWVzIHVwIHRvIDIwMDAgbWljcm9zZWNvbmRz
LiBtc2xlZXAKZG9lcyB0aGUgdHJpY2sgZm9yIHVzIGhlcmUgYXMgdGhlcmUgaXMgbm8gcHJvYmxl
bSBpZiB0aGlzIGlzbid0Cm1pY3Jvc2Vjb25kIGFjY3VyYXRlIGFuZCB0YWtlcyBhIHRhZCBsb25n
ZXIuCgpTaWduZWQtb2ZmLWJ5OiBIYXJyeSBXZW50bGFuZCA8aGFycnkud2VudGxhbmRAYW1kLmNv
bT4KLS0tCiBkcml2ZXJzL2dwdS9kcm0vYW1kL2Rpc3BsYXkvZGMvY29yZS9kY19saW5rLmMgfCAy
ICstCiAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKyksIDEgZGVsZXRpb24oLSkKCmRpZmYg
LS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2Rpc3BsYXkvZGMvY29yZS9kY19saW5rLmMgYi9k
cml2ZXJzL2dwdS9kcm0vYW1kL2Rpc3BsYXkvZGMvY29yZS9kY19saW5rLmMKaW5kZXggNGMzMTkz
MGYxY2RmLi5mNWQwMmY4OWIzZjkgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvZGlz
cGxheS9kYy9jb3JlL2RjX2xpbmsuYworKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2Rpc3BsYXkv
ZGMvY29yZS9kY19saW5rLmMKQEAgLTU0OCw3ICs1NDgsNyBAQCBzdGF0aWMgdm9pZCByZWFkX2Vk
cF9jdXJyZW50X2xpbmtfc2V0dGluZ3Nfb25fZGV0ZWN0KHN0cnVjdCBkY19saW5rICpsaW5rKQog
CQkJYnJlYWs7CiAJCX0KIAotCQl1ZGVsYXkoODAwMCk7CisJCW1zbGVlcCg4KTsKIAl9CiAKIAlB
U1NFUlQoc3RhdHVzID09IERDX09LKTsKLS0gCjIuMjIuMAoKX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX18KZHJpLWRldmVsIG1haWxpbmcgbGlzdApkcmktZGV2
ZWxAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21h
aWxtYW4vbGlzdGluZm8vZHJpLWRldmVs
