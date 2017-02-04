From: Monk Liu <Monk.Liu-5C7GfCeVMHo@public.gmane.org>
Subject: [PATCH 07/21] drm/amdgpu:fix gart table vram pin
Date: Sat, 4 Feb 2017 18:34:59 +0800
Message-ID: <1486204499-4344-3-git-send-email-Monk.Liu@amd.com>
References: <1486204499-4344-1-git-send-email-Monk.Liu@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <1486204499-4344-1-git-send-email-Monk.Liu-5C7GfCeVMHo@public.gmane.org>
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
Cc: Monk Liu <Monk.Liu-5C7GfCeVMHo@public.gmane.org>

aWYgdGhpcyBjYWxsIGlzIGZyb20gcmVzdW1lLCBzaG91bGRuJ3QgZW50ZXIgcGluIGxvZ2ljIGF0
IGFsbAoKQ2hhbmdlLUlkOiBJNDBhNWNkYzJhNzE2YzRjMjBkMjgxMmZkNzRlY2U0ZWEyODRiNjc2
NQpTaWduZWQtb2ZmLWJ5OiBNb25rIExpdSA8TW9uay5MaXVAYW1kLmNvbT4KLS0tCiBkcml2ZXJz
L2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfZ2FydC5jIHwgNSArKysrKwogMSBmaWxlIGNoYW5n
ZWQsIDUgaW5zZXJ0aW9ucygrKQoKZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1k
Z3B1L2FtZGdwdV9nYXJ0LmMgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfZ2Fy
dC5jCmluZGV4IDk2NGQyYTkuLjVlOTA3ZjcgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvZ3B1L2RybS9h
bWQvYW1kZ3B1L2FtZGdwdV9nYXJ0LmMKKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUv
YW1kZ3B1X2dhcnQuYwpAQCAtMTUxLDYgKzE1MSwxMSBAQCBpbnQgYW1kZ3B1X2dhcnRfdGFibGVf
dnJhbV9waW4oc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYpCiAJdWludDY0X3QgZ3B1X2FkZHI7
CiAJaW50IHI7CiAKKwlpZiAoYWRldi0+Z2FydC50YWJsZV9hZGRyKSB7CisJCS8qIGl0J3MgYSBy
ZXN1bWUgY2FsbCwgZ2FydCBhbHJlYWR5IHBpbiAqLworCQlyZXR1cm4gMDsKKwl9CisKIAlyID0g
YW1kZ3B1X2JvX3Jlc2VydmUoYWRldi0+Z2FydC5yb2JqLCBmYWxzZSk7CiAJaWYgKHVubGlrZWx5
KHIgIT0gMCkpCiAJCXJldHVybiByOwotLSAKMi43LjQKCl9fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlz
dHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4v
bGlzdGluZm8vYW1kLWdmeAo=
