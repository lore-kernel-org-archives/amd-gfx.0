From: Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH 2/3] drm/amdgpu/display: remove unused REG_OFFSET macro
Date: Thu,  2 Nov 2017 12:26:42 +0100
Message-ID: <20171102112657.111405-2-arnd@arndb.de>
References: <20171102112657.111405-1-arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <dri-devel-bounces@lists.freedesktop.org>
In-Reply-To: <20171102112657.111405-1-arnd@arndb.de>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
To: Alex Deucher <alexander.deucher@amd.com>, =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Cc: Arnd Bergmann <arnd@arndb.de>, David Airlie <airlied@linux.ie>, linux-kernel@vger.kernel.org, amd-gfx@lists.freedesktop.org, Dmytro Laktyushkin <Dmytro.Laktyushkin@amd.com>, dri-devel@lists.freedesktop.org, Dave Airlie <airlied@redhat.com>, Tony Cheng <tony.cheng@amd.com>
List-Id: amd-gfx.lists.freedesktop.org

VGhlIG5hbWUgY29uZmxpY3RzIHdpdGggYW5vdGhlciBtYWNybyBvZiB0aGUgc2FtZSBuYW1lIG9u
IHRoZSBBUk0gaXhwNHh4CnBsYXRmb3JtLCBsZWFkaW5nIHRvIGJ1aWxkIGVycm9ycy4KTmVpdGhl
ciBvZiB0aGUgdXNlcnMgYWN0dWFsbHkgc2hvdWxkIHVzZSBhIG5hbWUgdGhhdCBnZW5lcmljLCBi
dXQgdGhlCm90aGVyIG9uZSB3YXMgaGVyZSBmaXJzdCBhbmQgdGhlIGRjIGRyaXZlciBkb2Vzbid0
IGFjdHVhbGx5IHVzZSBpdC4KClNpZ25lZC1vZmYtYnk6IEFybmQgQmVyZ21hbm4gPGFybmRAYXJu
ZGIuZGU+Ci0tLQogZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5L2RjL2RtX3NlcnZpY2VzLmgg
fCAzIC0tLQogMSBmaWxlIGNoYW5nZWQsIDMgZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvZHJp
dmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5L2RjL2RtX3NlcnZpY2VzLmggYi9kcml2ZXJzL2dwdS9k
cm0vYW1kL2Rpc3BsYXkvZGMvZG1fc2VydmljZXMuaAppbmRleCBjODE5MGMzOGE2NDQuLmQ0OTE3
MDM3YWM0MiAxMDA2NDQKLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5L2RjL2RtX3Nl
cnZpY2VzLmgKKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5L2RjL2RtX3NlcnZpY2Vz
LmgKQEAgLTE2MCw5ICsxNjAsNiBAQCB1bnNpZ25lZCBpbnQgZ2VuZXJpY19yZWdfd2FpdChjb25z
dCBzdHJ1Y3QgZGNfY29udGV4dCAqY3R4LAogLyogVGhlc2UgbWFjcm9zIG5lZWQgdG8gYmUgdXNl
ZCB3aXRoIHNvYzE1IHJlZ2lzdGVycyBpbiBvcmRlciB0byByZXRyaWV2ZQogICogdGhlIGFjdHVh
bCBvZmZzZXQuCiAgKi8KLSNkZWZpbmUgUkVHX09GRlNFVChyZWcpIChyZWcgKyBEQ0VfQkFTRS5p
bnN0YW5jZVswXS5zZWdtZW50W3JlZyMjX0JBU0VfSURYXSkKLSNkZWZpbmUgUkVHX0JJRl9PRkZT
RVQocmVnKSAocmVnICsgTkJJRl9CQVNFLmluc3RhbmNlWzBdLnNlZ21lbnRbcmVnIyNfQkFTRV9J
RFhdKQotCiAjZGVmaW5lIGRtX3dyaXRlX3JlZ19zb2MxNShjdHgsIHJlZywgaW5zdF9vZmZzZXQs
IHZhbHVlKQlcCiAJCWRtX3dyaXRlX3JlZ19mdW5jKGN0eCwgcmVnICsgRENFX0JBU0UuaW5zdGFu
Y2VbMF0uc2VnbWVudFtyZWcjI19CQVNFX0lEWF0gKyBpbnN0X29mZnNldCwgdmFsdWUsIF9fZnVu
Y19fKQogCi0tIAoyLjkuMAoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX18KZHJpLWRldmVsIG1haWxpbmcgbGlzdApkcmktZGV2ZWxAbGlzdHMuZnJlZWRlc2t0
b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vZHJp
LWRldmVsCg==
