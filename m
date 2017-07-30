From: Jean Delvare <jdelvare@suse.de>
Subject: [PATCH] drm/amdgpu: Make amdgpu_atif_handler static
Date: Sun, 30 Jul 2017 13:11:02 +0200
Message-ID: <20170730131102.2dcf2731@endymion>
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
To: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org
Cc: Alex Deucher <alexander.deucher@amd.com>, Christian =?UTF-8?B?S8O2?= =?UTF-8?B?bmln?= <christian.koenig@amd.com>
List-Id: amd-gfx.lists.freedesktop.org

VGhlcmUgYXJlIG5vIGV4dGVybmFsIHVzZXJzIG9mIGZ1bmN0aW9uIGFtZGdwdV9hdGlmX2hhbmRs
ZXIgc28gaXQgY2FuCmJlIHN0YXRpYy4KClNpZ25lZC1vZmYtYnk6IEplYW4gRGVsdmFyZSA8amRl
bHZhcmVAc3VzZS5kZT4KQ2M6IEFsZXggRGV1Y2hlciA8YWxleGFuZGVyLmRldWNoZXJAYW1kLmNv
bT4KQ2M6ICJDaHJpc3RpYW4gS8O2bmlnIiA8Y2hyaXN0aWFuLmtvZW5pZ0BhbWQuY29tPgotLS0K
IGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9hY3BpLmMgfCAgICAyICstCiAxIGZp
bGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKyksIDEgZGVsZXRpb24oLSkKCi0tLSBsaW51eC00LjEy
Lm9yaWcvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2FjcGkuYwkyMDE3LTA3LTMw
IDEzOjA2OjE5Ljk0OTQxODYxOCArMDIwMAorKysgbGludXgtNC4xMi9kcml2ZXJzL2dwdS9kcm0v
YW1kL2FtZGdwdS9hbWRncHVfYWNwaS5jCTIwMTctMDctMzAgMTM6MDc6MTQuOTQ5MTIwNTkxICsw
MjAwCkBAIC0yODksNyArMjg5LDcgQEAgc3RhdGljIGludCBhbWRncHVfYXRpZl9nZXRfc2Jpb3Nf
cmVxdWVzdAogICogaGFuZGxlcyBpdC4KICAqIFJldHVybnMgTk9USUZZIGNvZGUKICAqLwotaW50
IGFtZGdwdV9hdGlmX2hhbmRsZXIoc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYsCitzdGF0aWMg
aW50IGFtZGdwdV9hdGlmX2hhbmRsZXIoc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYsCiAJCQlz
dHJ1Y3QgYWNwaV9idXNfZXZlbnQgKmV2ZW50KQogewogCXN0cnVjdCBhbWRncHVfYXRpZiAqYXRp
ZiA9ICZhZGV2LT5hdGlmOwoKCi0tIApKZWFuIERlbHZhcmUKU1VTRSBMMyBTdXBwb3J0Cl9fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmRyaS1kZXZlbCBtYWls
aW5nIGxpc3QKZHJpLWRldmVsQGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZy
ZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2RyaS1kZXZlbAo=
