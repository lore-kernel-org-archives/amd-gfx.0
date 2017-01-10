From: Xiangliang Yu <Xiangliang.Yu-5C7GfCeVMHo@public.gmane.org>
Subject: [V2 11/11] drm/amdgpu: do not reset gpu for virtualization
Date: Tue, 10 Jan 2017 18:00:50 +0800
Message-ID: <1484042450-22987-12-git-send-email-Xiangliang.Yu@amd.com>
References: <1484042450-22987-1-git-send-email-Xiangliang.Yu@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <1484042450-22987-1-git-send-email-Xiangliang.Yu-5C7GfCeVMHo@public.gmane.org>
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
Cc: Xiangliang Yu <Xiangliang.Yu-5C7GfCeVMHo@public.gmane.org>, Monk Liu <Monk.Liu-5C7GfCeVMHo@public.gmane.org>

Q3VycmVudCBqb2IgdGltZW91dCBzZXR0aW5nIGlzIG5vdCBmaXQgZm9yIHZpcnR1YWxpemF0aW9u
LCBzbyBpdAp3aWxsIGNhdXNlIGpvYiB0aW1lb3V0IHNvbWV0aW1lcy4gQWRkIHdvcmthcm91bmQg
Zm9yIHRoaXMgd2hlbgp0aW1lb3V0IGhhcHBlbi4KClNpZ25lZC1vZmYtYnk6IE1vbmsgTGl1IDxN
b25rLkxpdUBhbWQuY29tPgpTaWduZWQtb2ZmLWJ5OiBYaWFuZ2xpYW5nIFl1IDxYaWFuZ2xpYW5n
Lll1QGFtZC5jb20+Ci0tLQogZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2Rldmlj
ZS5jIHwgMyArKysKIDEgZmlsZSBjaGFuZ2VkLCAzIGluc2VydGlvbnMoKykKCmRpZmYgLS1naXQg
YS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfZGV2aWNlLmMgYi9kcml2ZXJzL2dw
dS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfZGV2aWNlLmMKaW5kZXggYTZkODI4Yy4uNTcwNWZiZCAx
MDA2NDQKLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2RldmljZS5jCisr
KyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9kZXZpY2UuYwpAQCAtMjMyNCw2
ICsyMzI0LDkgQEAgaW50IGFtZGdwdV9ncHVfcmVzZXQoc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFk
ZXYpCiAJaW50IHJlc2NoZWQ7CiAJYm9vbCBuZWVkX2Z1bGxfcmVzZXQ7CiAKKwlpZiAoYW1kZ3B1
X3NyaW92X3ZmKGFkZXYpKQorCQlyZXR1cm4gMDsKKwogCWlmICghYW1kZ3B1X2NoZWNrX3NvZnRf
cmVzZXQoYWRldikpIHsKIAkJRFJNX0lORk8oIk5vIGhhcmR3YXJlIGhhbmcgZGV0ZWN0ZWQuIERp
ZCBzb21lIGJsb2NrcyBzdGFsbD9cbiIpOwogCQlyZXR1cm4gMDsKLS0gCjIuNy40CgpfX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcg
bGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNr
dG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZngK
