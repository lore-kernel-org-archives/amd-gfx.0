From: Huang Rui <ray.huang-5C7GfCeVMHo@public.gmane.org>
Subject: [PATCH] drm/amdgpu: set firmware loading type as direct by default
 for raven
Date: Tue, 4 Jul 2017 16:35:14 +0800
Message-ID: <1499157314-28393-1-git-send-email-ray.huang@amd.com>
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
To: Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org>, =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig-5C7GfCeVMHo@public.gmane.org>, amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Cc: Jerry Zhang <Jerry.Zhang-5C7GfCeVMHo@public.gmane.org>, Huang Rui <ray.huang-5C7GfCeVMHo@public.gmane.org>, Hawking Zhang <Hawking.Zhang-5C7GfCeVMHo@public.gmane.org>

SW4gcHJldmlvdXMgY2FzZSwgZHJpdmVyIGNhbid0IGVuYWJsZSBwc3AgdmlhIHRoZSBrZXJuZWwg
cGFyYW1ldGVyIGZvciByYXZlbi4KV2Ugc2hvdWxkIG9wZW4gdGhpcyBwYXRoIGFuZCBzZXQgaXQg
YXMgZGlyZWN0IGJ5IGRlZmF1bHQgdGlsbCBwc3AgZmlybXdhcmUKbG9hZGluZyBpcyB3b3JrYWJs
ZS4KClNpZ25lZC1vZmYtYnk6IEh1YW5nIFJ1aSA8cmF5Lmh1YW5nQGFtZC5jb20+Ci0tLQogZHJp
dmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3Vjb2RlLmMgfCA2ICstLS0tLQogMSBmaWxl
IGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspLCA1IGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL2Ry
aXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV91Y29kZS5jIGIvZHJpdmVycy9ncHUvZHJt
L2FtZC9hbWRncHUvYW1kZ3B1X3Vjb2RlLmMKaW5kZXggMTdhOTM1ZC4uZmNmYjlkNCAxMDA2NDQK
LS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3Vjb2RlLmMKKysrIGIvZHJp
dmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3Vjb2RlLmMKQEAgLTI3NSwxNCArMjc1LDEw
IEBAIGFtZGdwdV91Y29kZV9nZXRfbG9hZF90eXBlKHN0cnVjdCBhbWRncHVfZGV2aWNlICphZGV2
LCBpbnQgbG9hZF90eXBlKQogCQllbHNlCiAJCQlyZXR1cm4gQU1ER1BVX0ZXX0xPQURfUFNQOwog
CWNhc2UgQ0hJUF9SQVZFTjoKLSNpZiAwCi0JCWlmICghbG9hZF90eXBlKQorCQlpZiAobG9hZF90
eXBlICE9IDIpCiAJCQlyZXR1cm4gQU1ER1BVX0ZXX0xPQURfRElSRUNUOwogCQllbHNlCiAJCQly
ZXR1cm4gQU1ER1BVX0ZXX0xPQURfUFNQOwotI2Vsc2UKLQkJcmV0dXJuIEFNREdQVV9GV19MT0FE
X0RJUkVDVDsKLSNlbmRpZgogCWRlZmF1bHQ6CiAJCURSTV9FUlJPUigiVW5rbm93IGZpcm13YXJl
IGxvYWQgdHlwZVxuIik7CiAJfQotLSAKMi43LjQKCl9fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMu
ZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlz
dGluZm8vYW1kLWdmeAo=
