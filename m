From: Ville Syrjala <ville.syrjala@linux.intel.com>
Subject: [PATCH 16/23] drm/amdgpu/dc: Stop updating plane->fb
Date: Thu, 22 Mar 2018 17:23:06 +0200
Message-ID: <20180322152313.6561-17-ville.syrjala@linux.intel.com>
References: <20180322152313.6561-1-ville.syrjala@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <intel-gfx-bounces@lists.freedesktop.org>
In-Reply-To: <20180322152313.6561-1-ville.syrjala@linux.intel.com>
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
aW50ZWwuY29tPgotLS0KIGRyaXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxheS9hbWRncHVfZG0vYW1k
Z3B1X2RtLmMgfCAyIC0tCiAxIGZpbGUgY2hhbmdlZCwgMiBkZWxldGlvbnMoLSkKCmRpZmYgLS1n
aXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2Rpc3BsYXkvYW1kZ3B1X2RtL2FtZGdwdV9kbS5jIGIv
ZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5L2FtZGdwdV9kbS9hbWRncHVfZG0uYwppbmRleCBh
ZTUxMmVjYjY1ZWUuLmE4MTI5ZWNhNmU2ZCAxMDA2NDQKLS0tIGEvZHJpdmVycy9ncHUvZHJtL2Ft
ZC9kaXNwbGF5L2FtZGdwdV9kbS9hbWRncHVfZG0uYworKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1k
L2Rpc3BsYXkvYW1kZ3B1X2RtL2FtZGdwdV9kbS5jCkBAIC0zOTQxLDggKzM5NDEsNiBAQCBzdGF0
aWMgdm9pZCBhbWRncHVfZG1fZG9fZmxpcChzdHJ1Y3QgZHJtX2NydGMgKmNydGMsCiAKIAkvKiBG
bGlwICovCiAJc3Bpbl9sb2NrX2lycXNhdmUoJmNydGMtPmRldi0+ZXZlbnRfbG9jaywgZmxhZ3Mp
OwotCS8qIHVwZGF0ZSBjcnRjIGZiICovCi0JY3J0Yy0+cHJpbWFyeS0+ZmIgPSBmYjsKIAogCVdB
Uk5fT04oYWNydGMtPnBmbGlwX3N0YXR1cyAhPSBBTURHUFVfRkxJUF9OT05FKTsKIAlXQVJOX09O
KCFhY3J0Y19zdGF0ZS0+c3RyZWFtKTsKLS0gCjIuMTYuMQoKX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX18KSW50ZWwtZ2Z4IG1haWxpbmcgbGlzdApJbnRlbC1n
ZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21h
aWxtYW4vbGlzdGluZm8vaW50ZWwtZ2Z4Cg==
