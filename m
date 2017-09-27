From: Harry Wentland <harry.wentland@amd.com>
Subject: [PATCH 2/3] drm/amd/display: Remove alloc/free macros
Date: Wed, 27 Sep 2017 15:46:40 -0400
Message-ID: <20170927194641.29146-3-harry.wentland@amd.com>
References: <20170927194641.29146-1-harry.wentland@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <dri-devel-bounces@lists.freedesktop.org>
In-Reply-To: <20170927194641.29146-1-harry.wentland@amd.com>
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
Cc: alexander.deucher@amd.com, daniel.vetter@ffwll.ch, daniel.vetter@intel.com
List-Id: amd-gfx.lists.freedesktop.org

Tm93IHRoYXQgd2UgZG9uJ3QgYWJzdHJhY3Qga2VybmVsIGFsbG9jIGludGVyZmFjZXMgd2UgZG9u
J3QgbmVlZAp0aG9zZSBhbnltb3JlLgoKU2lnbmVkLW9mZi1ieTogSGFycnkgV2VudGxhbmQgPGhh
cnJ5LndlbnRsYW5kQGFtZC5jb20+Ci0tLQogZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5L2Rj
L2RtX3NlcnZpY2VzLmggfCA0IC0tLS0KIDEgZmlsZSBjaGFuZ2VkLCA0IGRlbGV0aW9ucygtKQoK
ZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxheS9kYy9kbV9zZXJ2aWNlcy5o
IGIvZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5L2RjL2RtX3NlcnZpY2VzLmgKaW5kZXggOGFi
MGFmNmY0YzZiLi43MjYwZTc3MjcyNWQgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQv
ZGlzcGxheS9kYy9kbV9zZXJ2aWNlcy5oCisrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxh
eS9kYy9kbV9zZXJ2aWNlcy5oCkBAIC03OSwxMCArNzksNiBAQAogI2luY2x1ZGUgPGFzbS9mcHUv
YXBpLmg+CiAjZW5kaWYKIAotI2RlZmluZSBkbV9hbGxvYyhzaXplKSBremFsbG9jKHNpemUsIEdG
UF9LRVJORUwpCi0jZGVmaW5lIGRtX3JlYWxsb2MocHRyLCBzaXplKSBrcmVhbGxvYyhwdHIsIHNp
emUsIEdGUF9LRVJORUwpCi0jZGVmaW5lIGRtX2ZyZWUocHRyKSBrZnJlZShwdHIpCi0KIGlycV9o
YW5kbGVyX2lkeCBkbV9yZWdpc3Rlcl9pbnRlcnJ1cHQoCiAJc3RydWN0IGRjX2NvbnRleHQgKmN0
eCwKIAlzdHJ1Y3QgZGNfaW50ZXJydXB0X3BhcmFtcyAqaW50X3BhcmFtcywKLS0gCjIuMTEuMAoK
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KZHJpLWRldmVs
IG1haWxpbmcgbGlzdApkcmktZGV2ZWxAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlz
dHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vZHJpLWRldmVsCg==
