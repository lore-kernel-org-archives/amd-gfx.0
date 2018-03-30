From: Colin King <colin.king@canonical.com>
Subject: [PATCH] drm/amd/display: fix spelling mistake: "Usupported" ->
 "Unsupported"
Date: Fri, 30 Mar 2018 17:00:47 +0100
Message-ID: <20180330160047.7368-1-colin.king@canonical.com>
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
To: Alex Deucher <alexander.deucher@amd.com>, =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, David Zhou <David1.Zhou@amd.com>, David Airlie <airlied@linux.ie>, Harry Wentland <harry.wentland@amd.com>, amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: amd-gfx.lists.freedesktop.org

RnJvbTogQ29saW4gSWFuIEtpbmcgPGNvbGluLmtpbmdAY2Fub25pY2FsLmNvbT4KClRyaXZpYWwg
Zml4IHRvIHNwZWxsaW5nIG1pc3Rha2UgaW4gRFJNX0VSUk9SIGVycm9yIG1lc3NhZ2UgdGV4dAoK
U2lnbmVkLW9mZi1ieTogQ29saW4gSWFuIEtpbmcgPGNvbGluLmtpbmdAY2Fub25pY2FsLmNvbT4K
LS0tCiBkcml2ZXJzL2dwdS9kcm0vYW1kL2Rpc3BsYXkvYW1kZ3B1X2RtL2FtZGdwdV9kbS5jIHwg
NCArKy0tCiAxIGZpbGUgY2hhbmdlZCwgMiBpbnNlcnRpb25zKCspLCAyIGRlbGV0aW9ucygtKQoK
ZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxheS9hbWRncHVfZG0vYW1kZ3B1
X2RtLmMgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2Rpc3BsYXkvYW1kZ3B1X2RtL2FtZGdwdV9kbS5j
CmluZGV4IGU0MmEyOGUzYWRjNS4uMWRmMWM5MWI2YWU1IDEwMDY0NAotLS0gYS9kcml2ZXJzL2dw
dS9kcm0vYW1kL2Rpc3BsYXkvYW1kZ3B1X2RtL2FtZGdwdV9kbS5jCisrKyBiL2RyaXZlcnMvZ3B1
L2RybS9hbWQvZGlzcGxheS9hbWRncHVfZG0vYW1kZ3B1X2RtLmMKQEAgLTE1MjEsNyArMTUyMSw3
IEBAIHN0YXRpYyBpbnQgYW1kZ3B1X2RtX2luaXRpYWxpemVfZHJtX2RldmljZShzdHJ1Y3QgYW1k
Z3B1X2RldmljZSAqYWRldikKIAkJYnJlYWs7CiAjZW5kaWYKIAlkZWZhdWx0OgotCQlEUk1fRVJS
T1IoIlVzdXBwb3J0ZWQgQVNJQyB0eXBlOiAweCVYXG4iLCBhZGV2LT5hc2ljX3R5cGUpOworCQlE
Uk1fRVJST1IoIlVuc3VwcG9ydGVkIEFTSUMgdHlwZTogMHglWFxuIiwgYWRldi0+YXNpY190eXBl
KTsKIAkJZ290byBmYWlsOwogCX0KIApAQCAtMTcxNSw3ICsxNzE1LDcgQEAgc3RhdGljIGludCBk
bV9lYXJseV9pbml0KHZvaWQgKmhhbmRsZSkKIAkJYnJlYWs7CiAjZW5kaWYKIAlkZWZhdWx0Ogot
CQlEUk1fRVJST1IoIlVzdXBwb3J0ZWQgQVNJQyB0eXBlOiAweCVYXG4iLCBhZGV2LT5hc2ljX3R5
cGUpOworCQlEUk1fRVJST1IoIlVuc3VwcG9ydGVkIEFTSUMgdHlwZTogMHglWFxuIiwgYWRldi0+
YXNpY190eXBlKTsKIAkJcmV0dXJuIC1FSU5WQUw7CiAJfQogCi0tIAoyLjE1LjEKCl9fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmRyaS1kZXZlbCBtYWlsaW5n
IGxpc3QKZHJpLWRldmVsQGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVk
ZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2RyaS1kZXZlbAo=
