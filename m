From: Andrey Grodzovsky <andrey.grodzovsky-5C7GfCeVMHo@public.gmane.org>
Subject: [PATCH] drm/amdgpu: Fix GPU reset crash regression.
Date: Fri, 2 Aug 2019 16:53:04 -0400
Message-ID: <1564779184-22641-1-git-send-email-andrey.grodzovsky@amd.com>
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
Cc: Alexander.Deucher-5C7GfCeVMHo@public.gmane.org, Andrey Grodzovsky <andrey.grodzovsky-5C7GfCeVMHo@public.gmane.org>, Monk.Liu-5C7GfCeVMHo@public.gmane.org

YW1kZ3B1X2lwX2Jsb2NrLnN0YXR1cy5odyBmb3IgR01DIHdhc24ndCBzZXQgdG8KZmFsc2Ugb24g
c3VzcGVuZCBkdXJpbmcgR1BVIHJlc2V0IGFuZCBzbyBvbiByZXN1bWUgZ21jX3Y5XzBfcmVzdW1l
Cndhc24ndCBjYWxsZWQuCkNhdXNlZCBieSAnZHJtL2FtZGdwdTogZml4IGRvdWJsZSB1Y29kZSBs
b2FkIGJ5IFBTUCh2MyknCgpTaWduZWQtb2ZmLWJ5OiBBbmRyZXkgR3JvZHpvdnNreSA8YW5kcmV5
Lmdyb2R6b3Zza3lAYW1kLmNvbT4KLS0tCiBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRn
cHVfZGV2aWNlLmMgfCAzICsrLQogMSBmaWxlIGNoYW5nZWQsIDIgaW5zZXJ0aW9ucygrKSwgMSBk
ZWxldGlvbigtKQoKZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdw
dV9kZXZpY2UuYyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9kZXZpY2UuYwpp
bmRleCAzMWFiZDg4Li42N2ExZjU0IDEwMDY0NAotLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2Ft
ZGdwdS9hbWRncHVfZGV2aWNlLmMKKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1k
Z3B1X2RldmljZS5jCkBAIC0yMjcwLDkgKzIyNzAsMTAgQEAgc3RhdGljIGludCBhbWRncHVfZGV2
aWNlX2lwX3N1c3BlbmRfcGhhc2UyKHN0cnVjdCBhbWRncHVfZGV2aWNlICphZGV2KQogCQkJCQkJ
ICBhZGV2LT5tcDFfc3RhdGUsIHIpOwogCQkJCQlyZXR1cm4gcjsKIAkJCQl9Ci0JCQkJYWRldi0+
aXBfYmxvY2tzW2ldLnN0YXR1cy5odyA9IGZhbHNlOwogCQkJfQogCQl9CisKKwkJYWRldi0+aXBf
YmxvY2tzW2ldLnN0YXR1cy5odyA9IGZhbHNlOwogCX0KIAogCXJldHVybiAwOwotLSAKMi43LjQK
Cl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1nZngg
bWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMu
ZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeA==
