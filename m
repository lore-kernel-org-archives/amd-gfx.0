From: Andrey Grodzovsky <andrey.grodzovsky@amd.com>
Subject: [PATCH 2/2] drm/amdgpu: If amdgpu_ib_schedule fails return back the
 error.
Date: Thu, 24 Oct 2019 15:57:30 -0400
Message-ID: <1571947050-26276-2-git-send-email-andrey.grodzovsky@amd.com>
References: <1571947050-26276-1-git-send-email-andrey.grodzovsky@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <dri-devel-bounces@lists.freedesktop.org>
In-Reply-To: <1571947050-26276-1-git-send-email-andrey.grodzovsky@amd.com>
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
Cc: ckoenig.leichtzumerken@gmail.com, Shirish.S@amd.com
List-Id: amd-gfx.lists.freedesktop.org

VXNlIEVSUl9QVFIgdG8gcmV0dXJuIGJhY2sgdGhlIGVycm9yIGhhcHBlbmVkIGR1cmluZyBhbWRn
cHVfaWJfc2NoZWR1bGUuCgpTaWduZWQtb2ZmLWJ5OiBBbmRyZXkgR3JvZHpvdnNreSA8YW5kcmV5
Lmdyb2R6b3Zza3lAYW1kLmNvbT4KLS0tCiBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRn
cHVfam9iLmMgfCAyICsrCiAxIGZpbGUgY2hhbmdlZCwgMiBpbnNlcnRpb25zKCspCgpkaWZmIC0t
Z2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2pvYi5jIGIvZHJpdmVycy9n
cHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2pvYi5jCmluZGV4IGUxYmFkOTkuLjk3NjliYjUgMTAw
NjQ0Ci0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9qb2IuYworKysgYi9k
cml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfam9iLmMKQEAgLTI0Myw2ICsyNDMsOCBA
QCBzdGF0aWMgc3RydWN0IGRtYV9mZW5jZSAqYW1kZ3B1X2pvYl9ydW4oc3RydWN0IGRybV9zY2hl
ZF9qb2IgKnNjaGVkX2pvYikKIAlqb2ItPmZlbmNlID0gZG1hX2ZlbmNlX2dldChmZW5jZSk7CiAK
IAlhbWRncHVfam9iX2ZyZWVfcmVzb3VyY2VzKGpvYik7CisKKwlmZW5jZSA9IHIgPyBFUlJfUFRS
KHIpIDogZmVuY2U7CiAJcmV0dXJuIGZlbmNlOwogfQogCi0tIAoyLjcuNAoKX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KZHJpLWRldmVsIG1haWxpbmcgbGlz
dApkcmktZGV2ZWxAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0
b3Aub3JnL21haWxtYW4vbGlzdGluZm8vZHJpLWRldmVs
