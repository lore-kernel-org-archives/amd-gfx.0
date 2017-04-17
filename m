From: Rex Zhu <Rex.Zhu-5C7GfCeVMHo@public.gmane.org>
Subject: [PATCH 1/3] drm/amdgpu: Remove redundant itermediate return val in
 sdma_v4_0.c
Date: Mon, 17 Apr 2017 20:04:36 +0800
Message-ID: <1492430678-21759-1-git-send-email-Rex.Zhu@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
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
Cc: Rex Zhu <Rex.Zhu-5C7GfCeVMHo@public.gmane.org>

Q2hhbmdlLUlkOiBJMjdhY2E0YWQwZjA2ZjAxMzkwYzkyZWQ3YTUyMGU5Yzg5ZTk5YjEzZApTaWdu
ZWQtb2ZmLWJ5OiBSZXggWmh1IDxSZXguWmh1QGFtZC5jb20+Ci0tLQogZHJpdmVycy9ncHUvZHJt
L2FtZC9hbWRncHUvc2RtYV92NF8wLmMgfCA2ICstLS0tLQogMSBmaWxlIGNoYW5nZWQsIDEgaW5z
ZXJ0aW9uKCspLCA1IGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9h
bWQvYW1kZ3B1L3NkbWFfdjRfMC5jIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvc2RtYV92
NF8wLmMKaW5kZXggNjI5OTYyOC4uMzVkZmZiOCAxMDA2NDQKLS0tIGEvZHJpdmVycy9ncHUvZHJt
L2FtZC9hbWRncHUvc2RtYV92NF8wLmMKKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUv
c2RtYV92NF8wLmMKQEAgLTc0NCwxMCArNzQ0LDggQEAgc3RhdGljIGludCBzZG1hX3Y0XzBfc3Rh
cnQoc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYpCiAJaWYgKHIpCiAJCXJldHVybiByOwogCXIg
PSBzZG1hX3Y0XzBfcmxjX3Jlc3VtZShhZGV2KTsKLQlpZiAocikKLQkJcmV0dXJuIHI7CiAKLQly
ZXR1cm4gMDsKKwlyZXR1cm4gcjsKIH0KIAogLyoqCkBAIC0xMTU4LDggKzExNTYsNiBAQCBzdGF0
aWMgaW50IHNkbWFfdjRfMF9od19pbml0KHZvaWQgKmhhbmRsZSkKIAlzZG1hX3Y0XzBfaW5pdF9n
b2xkZW5fcmVnaXN0ZXJzKGFkZXYpOwogCiAJciA9IHNkbWFfdjRfMF9zdGFydChhZGV2KTsKLQlp
ZiAocikKLQkJcmV0dXJuIHI7CiAKIAlyZXR1cm4gcjsKIH0KLS0gCjEuOS4xCgpfX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlz
dAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9w
Lm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZngK
