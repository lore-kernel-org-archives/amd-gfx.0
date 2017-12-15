From: Colin King <colin.king@canonical.com>
Subject: [PATCH] drm/amd/display: remove redundant null check of array 'data'
Date: Fri, 15 Dec 2017 10:53:43 +0000
Message-ID: <20171215105343.11372-1-colin.king@canonical.com>
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
To: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, David Airlie <airlied@linux.ie>, Harry Wentland <harry.wentland@amd.com>, amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: amd-gfx.lists.freedesktop.org

RnJvbTogQ29saW4gSWFuIEtpbmcgPGNvbGluLmtpbmdAY2Fub25pY2FsLmNvbT4KClRoZSBudWxs
IGNoZWNrIG9uIGFjb25uZWN0b3ItPmJhc2UuZWRpZF9ibG9iX3B0ci0+ZGF0YSBpcyByZWR1bmRh
bnQKc2luY2UgZGF0YSBpcyBhbiBhcnJheSBhbmQgY2FuIG5ldmVyIGJlIG51bGwuICBSZW1vdmUg
aXQuCgpEZXRlY3RlZCBieSBDb3Zlcml0eVNjYW4sIENJRCMxNDYwMzY5ICgiQXJyYXkgY29tcGFy
ZWQgYWdhaW5zdCAwIikKClNpZ25lZC1vZmYtYnk6IENvbGluIElhbiBLaW5nIDxjb2xpbi5raW5n
QGNhbm9uaWNhbC5jb20+Ci0tLQogZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5L2FtZGdwdV9k
bS9hbWRncHVfZG0uYyB8IDMgKy0tCiAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKyksIDIg
ZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5L2Ft
ZGdwdV9kbS9hbWRncHVfZG0uYyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxheS9hbWRncHVf
ZG0vYW1kZ3B1X2RtLmMKaW5kZXggY2NiZjEwZTNiYmI2Li5jMzg4Nzc4ZGJiYTMgMTAwNjQ0Ci0t
LSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxheS9hbWRncHVfZG0vYW1kZ3B1X2RtLmMKKysr
IGIvZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5L2FtZGdwdV9kbS9hbWRncHVfZG0uYwpAQCAt
MjcyNSw4ICsyNzI1LDcgQEAgc3RhdGljIHZvaWQgY3JlYXRlX2VtbF9zaW5rKHN0cnVjdCBhbWRn
cHVfZG1fY29ubmVjdG9yICphY29ubmVjdG9yKQogCX07CiAJc3RydWN0IGVkaWQgKmVkaWQ7CiAK
LQlpZiAoIWFjb25uZWN0b3ItPmJhc2UuZWRpZF9ibG9iX3B0ciB8fAotCQkhYWNvbm5lY3Rvci0+
YmFzZS5lZGlkX2Jsb2JfcHRyLT5kYXRhKSB7CisJaWYgKCFhY29ubmVjdG9yLT5iYXNlLmVkaWRf
YmxvYl9wdHIpIHsKIAkJRFJNX0VSUk9SKCJObyBFRElEIGZpcm13YXJlIGZvdW5kIG9uIGNvbm5l
Y3RvcjogJXMgLGZvcmNpbmcgdG8gT0ZGIVxuIiwKIAkJCQlhY29ubmVjdG9yLT5iYXNlLm5hbWUp
OwogCi0tIAoyLjE0LjEKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fCmRyaS1kZXZlbCBtYWlsaW5nIGxpc3QKZHJpLWRldmVsQGxpc3RzLmZyZWVkZXNrdG9w
Lm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2RyaS1k
ZXZlbAo=
