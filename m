From: Chunming Zhou <David1.Zhou-5C7GfCeVMHo@public.gmane.org>
Subject: [PATCH 13/15] drm/amdgpu: adapt vm size for multi vmpt
Date: Mon, 27 Mar 2017 13:53:23 +0800
Message-ID: <1490594005-14553-14-git-send-email-David1.Zhou@amd.com>
References: <1490594005-14553-1-git-send-email-David1.Zhou@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <1490594005-14553-1-git-send-email-David1.Zhou-5C7GfCeVMHo@public.gmane.org>
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
To: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, Christian.Koenig-5C7GfCeVMHo@public.gmane.org, Alexander.Deucher-5C7GfCeVMHo@public.gmane.org
Cc: Chunming Zhou <David1.Zhou-5C7GfCeVMHo@public.gmane.org>

Q2hhbmdlLUlkOiBJMTdiNDBhZWM2ODQwNGU0Njk2MWE5ZmRhMjJkZmFkZDFhZTlkNmYyYwpTaWdu
ZWQtb2ZmLWJ5OiBDaHVubWluZyBaaG91IDxEYXZpZDEuWmhvdUBhbWQuY29tPgotLS0KIGRyaXZl
cnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2dtY192OV8wLmMgfCA2ICsrKysrKwogMSBmaWxlIGNoYW5n
ZWQsIDYgaW5zZXJ0aW9ucygrKQoKZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1k
Z3B1L2dtY192OV8wLmMgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9nbWNfdjlfMC5jCmlu
ZGV4IDY2MjVhMmYuLjYxM2M4ZjYgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1k
Z3B1L2dtY192OV8wLmMKKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvZ21jX3Y5XzAu
YwpAQCAtNTA4LDYgKzUwOCwxMiBAQCBzdGF0aWMgaW50IGdtY192OV8wX3ZtX2luaXQoc3RydWN0
IGFtZGdwdV9kZXZpY2UgKmFkZXYpCiAJICogYW1ka2ZkIHdpbGwgdXNlIFZNSURzIDgtMTUKIAkg
Ki8KIAlhZGV2LT52bV9tYW5hZ2VyLm51bV9pZHMgPSBBTURHUFVfTlVNX09GX1ZNSURTOworCS8q
IEJlY2F1c2Ugb2YgZm91ciBsZXZlbCBWTVBUcywgdm0gc2l6ZSBhdCBsZWFzdCBpcyAyNTZHQi4K
KwkyNTZUQiBpcyBPSyBhcyB3ZWxsICovCisJaWYgKGFtZGdwdV92bV9zaXplIDwgMjU2KSB7CisJ
CURSTV9XQVJOKCJ2bSBzaXplIGF0IGxlYXN0IGlzIDI1NkdCIVxuIik7CisJCWFtZGdwdV92bV9z
aXplID0gMjU2OworCX0KIAlhZGV2LT52bV9tYW5hZ2VyLm51bV9sZXZlbCA9IDE7CiAJYW1kZ3B1
X3ZtX21hbmFnZXJfaW5pdChhZGV2KTsKIAotLSAKMS45LjEKCl9fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhA
bGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxt
YW4vbGlzdGluZm8vYW1kLWdmeAo=
