From: Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 5.3 19/71] drm/amdgpu: Fix KFD-related kernel oops on
 Hawaii
Date: Tue,  1 Oct 2019 12:38:29 -0400
Message-ID: <20191001163922.14735-19-sashal@kernel.org>
References: <20191001163922.14735-1-sashal@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <dri-devel-bounces@lists.freedesktop.org>
In-Reply-To: <20191001163922.14735-1-sashal@kernel.org>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>, Felix Kuehling <Felix.Kuehling@amd.com>, dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org, Alex Deucher <alexander.deucher@amd.com>, =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
List-Id: amd-gfx.lists.freedesktop.org

RnJvbTogRmVsaXggS3VlaGxpbmcgPEZlbGl4Lkt1ZWhsaW5nQGFtZC5jb20+CgpbIFVwc3RyZWFt
IGNvbW1pdCBkY2FmYmQ1MGYyZTRkNWNjOTY0YWFlNDA5ZmI1NjkxYjc0M2ZiYTIzIF0KCkhhd2Fp
aSBuZWVkcyB0byBmbHVzaCBjYWNoZXMgZXhwbGljaXRseSwgc3VibWl0dGluZyBhbiBJQiBpbiBh
IHVzZXIKVk1JRCBmcm9tIGtlcm5lbCBtb2RlLiBUaGVyZSBpcyBubyBzX2ZlbmNlIGluIHRoaXMg
Y2FzZS4KCkZpeGVzOiBlYjM5NjFhNTc0MjQgKCJkcm0vYW1kZ3B1OiByZW1vdmUgZmVuY2UgY29u
dGV4dCBmcm9tIHRoZSBqb2IiKQpTaWduZWQtb2ZmLWJ5OiBGZWxpeCBLdWVobGluZyA8RmVsaXgu
S3VlaGxpbmdAYW1kLmNvbT4KUmV2aWV3ZWQtYnk6IENocmlzdGlhbiBLw7ZuaWcgPGNocmlzdGlh
bi5rb2VuaWdAYW1kLmNvbT4KU2lnbmVkLW9mZi1ieTogQWxleCBEZXVjaGVyIDxhbGV4YW5kZXIu
ZGV1Y2hlckBhbWQuY29tPgpTaWduZWQtb2ZmLWJ5OiBTYXNoYSBMZXZpbiA8c2FzaGFsQGtlcm5l
bC5vcmc+Ci0tLQogZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2liLmMgfCAzICsr
LQogMSBmaWxlIGNoYW5nZWQsIDIgaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbigtKQoKZGlmZiAt
LWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9pYi5jIGIvZHJpdmVycy9n
cHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2liLmMKaW5kZXggNzg1MDA4NGEwNWUzYS4uNjA2NTU4
MzRkNjQ5OCAxMDA2NDQKLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2li
LmMKKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2liLmMKQEAgLTE0Myw3
ICsxNDMsOCBAQCBpbnQgYW1kZ3B1X2liX3NjaGVkdWxlKHN0cnVjdCBhbWRncHVfcmluZyAqcmlu
ZywgdW5zaWduZWQgbnVtX2licywKIAkvKiByaW5nIHRlc3RzIGRvbid0IHVzZSBhIGpvYiAqLwog
CWlmIChqb2IpIHsKIAkJdm0gPSBqb2ItPnZtOwotCQlmZW5jZV9jdHggPSBqb2ItPmJhc2Uuc19m
ZW5jZS0+c2NoZWR1bGVkLmNvbnRleHQ7CisJCWZlbmNlX2N0eCA9IGpvYi0+YmFzZS5zX2ZlbmNl
ID8KKwkJCWpvYi0+YmFzZS5zX2ZlbmNlLT5zY2hlZHVsZWQuY29udGV4dCA6IDA7CiAJfSBlbHNl
IHsKIAkJdm0gPSBOVUxMOwogCQlmZW5jZV9jdHggPSAwOwotLSAKMi4yMC4xCgpfX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpkcmktZGV2ZWwgbWFpbGluZyBs
aXN0CmRyaS1kZXZlbEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVz
a3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9kcmktZGV2ZWw=
