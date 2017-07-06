From: Alex Deucher <alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH 2/2] drm/amdgpu/soc15: init nbio registers for vega10
Date: Thu,  6 Jul 2017 13:46:07 -0400
Message-ID: <1499363167-28331-2-git-send-email-alexander.deucher@amd.com>
References: <1499363167-28331-1-git-send-email-alexander.deucher@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <1499363167-28331-1-git-send-email-alexander.deucher-5C7GfCeVMHo@public.gmane.org>
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
Cc: Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org>

Q2FsbCBuYmlvIGluaXQgcmVnaXN0ZXJzIG9uIGh3X2luaXQgdG8gc2V0IHVwIGFueQpuYmlvIHJl
Z2lzdGVycyB0aGF0IG5lZWQgaW5pdGlhbGl6YXRpb24gYXQgaHcgaW5pdCB0aW1lLgoKU2lnbmVk
LW9mZi1ieTogQWxleCBEZXVjaGVyIDxhbGV4YW5kZXIuZGV1Y2hlckBhbWQuY29tPgotLS0KIGRy
aXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L3NvYzE1LmMgfCAzICsrKwogMSBmaWxlIGNoYW5nZWQs
IDMgaW5zZXJ0aW9ucygrKQoKZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1
L3NvYzE1LmMgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9zb2MxNS5jCmluZGV4IGY1NjY5
YWYuLjEwY2MwMWUgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L3NvYzE1
LmMKKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvc29jMTUuYwpAQCAtNjkxLDYgKzY5
MSw5IEBAIHN0YXRpYyBpbnQgc29jMTVfY29tbW9uX2h3X2luaXQodm9pZCAqaGFuZGxlKQogCXNv
YzE1X3BjaWVfZ2VuM19lbmFibGUoYWRldik7CiAJLyogZW5hYmxlIGFzcG0gKi8KIAlzb2MxNV9w
cm9ncmFtX2FzcG0oYWRldik7CisJLyogc2V0dXAgbmJpbyByZWdpc3RlcnMgKi8KKwlpZiAoIShh
ZGV2LT5mbGFncyAmIEFNRF9JU19BUFUpKQorCQluYmlvX3Y2XzFfaW5pdF9yZWdpc3RlcnMoYWRl
dik7CiAJLyogZW5hYmxlIHRoZSBkb29yYmVsbCBhcGVydHVyZSAqLwogCXNvYzE1X2VuYWJsZV9k
b29yYmVsbF9hcGVydHVyZShhZGV2LCB0cnVlKTsKIAotLSAKMi41LjUKCl9fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFt
ZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3Jn
L21haWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=
