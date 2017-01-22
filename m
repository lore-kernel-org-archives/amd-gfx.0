From: Emil Velikov <emil.l.velikov@gmail.com>
Subject: [PATCH libdrm 1/3] amdgpu: add missing unlock on drmPrimeFDToHandle()
 failure
Date: Sun, 22 Jan 2017 18:48:11 +0000
Message-ID: <20170122184813.12995-1-emil.l.velikov@gmail.com>
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
To: dri-devel@lists.freedesktop.org
Cc: emil.l.velikov@gmail.com, amd-gfx@lists.freedesktop.org
List-Id: amd-gfx.lists.freedesktop.org

Q2M6IGFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnClNpZ25lZC1vZmYtYnk6IEVtaWwgVmVs
aWtvdiA8ZW1pbC5sLnZlbGlrb3ZAZ21haWwuY29tPgotLS0KIGFtZGdwdS9hbWRncHVfYm8uYyB8
IDEgKwogMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspCgpkaWZmIC0tZ2l0IGEvYW1kZ3B1
L2FtZGdwdV9iby5jIGIvYW1kZ3B1L2FtZGdwdV9iby5jCmluZGV4IGQzMGZkMWU3Li5jOWYzMTU4
NyAxMDA2NDQKLS0tIGEvYW1kZ3B1L2FtZGdwdV9iby5jCisrKyBiL2FtZGdwdS9hbWRncHVfYm8u
YwpAQCAtMzAyLDYgKzMwMiw3IEBAIGludCBhbWRncHVfYm9faW1wb3J0KGFtZGdwdV9kZXZpY2Vf
aGFuZGxlIGRldiwKIAkJLyogR2V0IGEgS01TIGhhbmRsZS4gKi8KIAkJciA9IGRybVByaW1lRkRU
b0hhbmRsZShkZXYtPmZkLCBzaGFyZWRfaGFuZGxlLCAmaGFuZGxlKTsKIAkJaWYgKHIpIHsKKwkJ
CXB0aHJlYWRfbXV0ZXhfdW5sb2NrKCZkZXYtPmJvX3RhYmxlX211dGV4KTsKIAkJCXJldHVybiBy
OwogCQl9CiAKLS0gCjIuMTEuMAoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX18KZHJpLWRldmVsIG1haWxpbmcgbGlzdApkcmktZGV2ZWxAbGlzdHMuZnJlZWRl
c2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8v
ZHJpLWRldmVsCg==
