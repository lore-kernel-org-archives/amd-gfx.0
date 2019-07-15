From: Alex Deucher <alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH 024/102] drm/amdgpu/dce_virtual: add Arcturus virtual display
 support
Date: Mon, 15 Jul 2019 16:23:19 -0500
Message-ID: <20190715212437.31793-22-alexander.deucher@amd.com>
References: <20190715212437.31793-1-alexander.deucher@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <20190715212437.31793-1-alexander.deucher-5C7GfCeVMHo@public.gmane.org>
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/amd-gfx>,
 <mailto:amd-gfx-request-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
List-Help: <mailto:amd-gfx-request-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org?subject=subscribe>
Errors-To: amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Sender: "amd-gfx" <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
To: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Cc: Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org>, Le Ma <le.ma-5C7GfCeVMHo@public.gmane.org>

RnJvbTogTGUgTWEgPGxlLm1hQGFtZC5jb20+CgpWaXJ0dWFsIGRjZSBpcyBhIHN3IG9ubHkgZGlz
cGxheSBkcml2ZXIgZm9yIGVtdWxhdGlvbiBhbmQKdmlydHVhbGl6YXRpb24gYW5kIGNhc2VzIHdo
ZXJlIHdlIHdhbnQgdG8gdXNlIGEgdmlydHVhbApkaXNwbGF5IHN1YnN5c3RlbS4KClNpZ25lZC1v
ZmYtYnk6IExlIE1hIDxsZS5tYUBhbWQuY29tPgpSZXZpZXdlZC1ieTogQWxleCBEZXVjaGVyIDxh
bGV4YW5kZXIuZGV1Y2hlckBhbWQuY29tPgpTaWduZWQtb2ZmLWJ5OiBBbGV4IERldWNoZXIgPGFs
ZXhhbmRlci5kZXVjaGVyQGFtZC5jb20+Ci0tLQogZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUv
ZGNlX3ZpcnR1YWwuYyB8IDEgKwogMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspCgpkaWZm
IC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvZGNlX3ZpcnR1YWwuYyBiL2RyaXZl
cnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2RjZV92aXJ0dWFsLmMKaW5kZXggNDE5NWIxMTcyYmRkLi45
YjQ1ZjZlMTJjN2MgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2RjZV92
aXJ0dWFsLmMKKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvZGNlX3ZpcnR1YWwuYwpA
QCAtNDU1LDYgKzQ1NSw3IEBAIHN0YXRpYyBpbnQgZGNlX3ZpcnR1YWxfaHdfaW5pdCh2b2lkICpo
YW5kbGUpCiAJY2FzZSBDSElQX1ZFR0ExMDoKIAljYXNlIENISVBfVkVHQTEyOgogCWNhc2UgQ0hJ
UF9WRUdBMjA6CisJY2FzZSBDSElQX0FSQ1RVUlVTOgogCWNhc2UgQ0hJUF9OQVZJMTA6CiAJY2Fz
ZSBDSElQX05BVkkxNDoKIAkJYnJlYWs7Ci0tIAoyLjIwLjEKCl9fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhA
bGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxt
YW4vbGlzdGluZm8vYW1kLWdmeA==
