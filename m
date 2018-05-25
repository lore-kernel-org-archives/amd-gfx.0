From: Ville Syrjala <ville.syrjala@linux.intel.com>
Subject: [PATCH v2 07/13] drm/amdgpu/dc: Stop updating plane->fb
Date: Fri, 25 May 2018 21:50:39 +0300
Message-ID: <20180525185045.29689-8-ville.syrjala@linux.intel.com>
References: <20180525185045.29689-1-ville.syrjala@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <intel-gfx-bounces@lists.freedesktop.org>
In-Reply-To: <20180525185045.29689-1-ville.syrjala@linux.intel.com>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/intel-gfx>,
 <mailto:intel-gfx-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/intel-gfx>
List-Post: <mailto:intel-gfx@lists.freedesktop.org>
List-Help: <mailto:intel-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/intel-gfx>,
 <mailto:intel-gfx-request@lists.freedesktop.org?subject=subscribe>
Errors-To: intel-gfx-bounces@lists.freedesktop.org
Sender: "Intel-gfx" <intel-gfx-bounces@lists.freedesktop.org>
To: dri-devel@lists.freedesktop.org
Cc: "David (ChunMing) Zhou" <David1.Zhou@amd.com>, intel-gfx@lists.freedesktop.org, amd-gfx@lists.freedesktop.org, Alex Deucher <alexander.deucher@amd.com>, Harry Wentland <harry.wentland@amd.com>, =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
List-Id: amd-gfx.lists.freedesktop.org

RnJvbTogVmlsbGUgU3lyasOkbMOkIDx2aWxsZS5zeXJqYWxhQGxpbnV4LmludGVsLmNvbT4KCldl
IHdhbnQgdG8gZ2V0IHJpZCBvZiBwbGFuZS0+ZmIgb24gYXRvbWljIGRyaXZlcnMuIFN0b3Agc2V0
dGluZyBpdC4KCkNjOiBBbGV4IERldWNoZXIgPGFsZXhhbmRlci5kZXVjaGVyQGFtZC5jb20+CkNj
OiAiQ2hyaXN0aWFuIEvDtm5pZyIgPGNocmlzdGlhbi5rb2VuaWdAYW1kLmNvbT4KQ2M6ICJEYXZp
ZCAoQ2h1bk1pbmcpIFpob3UiIDxEYXZpZDEuWmhvdUBhbWQuY29tPgpDYzogSGFycnkgV2VudGxh
bmQgPGhhcnJ5LndlbnRsYW5kQGFtZC5jb20+CkNjOiBhbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9w
Lm9yZwpTaWduZWQtb2ZmLWJ5OiBWaWxsZSBTeXJqw6Rsw6QgPHZpbGxlLnN5cmphbGFAbGludXgu
aW50ZWwuY29tPgpSZXZpZXdlZC1ieTogTWFhcnRlbiBMYW5raG9yc3QgPG1hYXJ0ZW4ubGFua2hv
cnN0QGxpbnV4LmludGVsLmNvbT4KUmV2aWV3ZWQtYnk6IEhhcnJ5IFdlbnRsYW5kIDxoYXJyeS53
ZW50bGFuZEBhbWQuY29tPgpSZXZpZXdlZC1ieTogRGFuaWVsIFZldHRlciA8ZGFuaWVsLnZldHRl
ckBmZndsbC5jaD4KLS0tCiBkcml2ZXJzL2dwdS9kcm0vYW1kL2Rpc3BsYXkvYW1kZ3B1X2RtL2Ft
ZGdwdV9kbS5jIHwgMiAtLQogMSBmaWxlIGNoYW5nZWQsIDIgZGVsZXRpb25zKC0pCgpkaWZmIC0t
Z2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5L2FtZGdwdV9kbS9hbWRncHVfZG0uYyBi
L2RyaXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxheS9hbWRncHVfZG0vYW1kZ3B1X2RtLmMKaW5kZXgg
MWNlMTBiYzJkMzdiLi44MmJhYzAyZmZmZDcgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvZ3B1L2RybS9h
bWQvZGlzcGxheS9hbWRncHVfZG0vYW1kZ3B1X2RtLmMKKysrIGIvZHJpdmVycy9ncHUvZHJtL2Ft
ZC9kaXNwbGF5L2FtZGdwdV9kbS9hbWRncHVfZG0uYwpAQCAtMzkyNyw4ICszOTI3LDYgQEAgc3Rh
dGljIHZvaWQgYW1kZ3B1X2RtX2RvX2ZsaXAoc3RydWN0IGRybV9jcnRjICpjcnRjLAogCiAJLyog
RmxpcCAqLwogCXNwaW5fbG9ja19pcnFzYXZlKCZjcnRjLT5kZXYtPmV2ZW50X2xvY2ssIGZsYWdz
KTsKLQkvKiB1cGRhdGUgY3J0YyBmYiAqLwotCWNydGMtPnByaW1hcnktPmZiID0gZmI7CiAKIAlX
QVJOX09OKGFjcnRjLT5wZmxpcF9zdGF0dXMgIT0gQU1ER1BVX0ZMSVBfTk9ORSk7CiAJV0FSTl9P
TighYWNydGNfc3RhdGUtPnN0cmVhbSk7Ci0tIAoyLjE2LjEKCl9fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fCkludGVsLWdmeCBtYWlsaW5nIGxpc3QKSW50ZWwt
Z2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9t
YWlsbWFuL2xpc3RpbmZvL2ludGVsLWdmeAo=
