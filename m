From: Felix Kuehling <Felix.Kuehling-5C7GfCeVMHo@public.gmane.org>
Subject: [PATCH 1/4] drm/amdkfd: Fix scratch memory with HWS enabled
Date: Fri, 23 Mar 2018 15:30:33 -0400
Message-ID: <1521833436-31511-2-git-send-email-Felix.Kuehling@amd.com>
References: <1521833436-31511-1-git-send-email-Felix.Kuehling@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <1521833436-31511-1-git-send-email-Felix.Kuehling-5C7GfCeVMHo@public.gmane.org>
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
To: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, oded.gabbay-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
Cc: Felix Kuehling <Felix.Kuehling-5C7GfCeVMHo@public.gmane.org>

UHJvZ3JhbSBzaF9oaWRkZW5fcHJpdmF0ZV9iYXNlX3ZtaWQgY29ycmVjdGx5IGluIHRoZSBtYXAt
cHJvY2VzcwpQTTQgcGFja2V0LgoKU2lnbmVkLW9mZi1ieTogRmVsaXggS3VlaGxpbmcgPEZlbGl4
Lkt1ZWhsaW5nQGFtZC5jb20+Ci0tLQogZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRrZmQva2ZkX3Bh
Y2tldF9tYW5hZ2VyLmMgfCAzICstLQogMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspLCAy
IGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1ka2ZkL2tm
ZF9wYWNrZXRfbWFuYWdlci5jIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRrZmQva2ZkX3BhY2tl
dF9tYW5hZ2VyLmMKaW5kZXggNzYxNDM3NS4uODliYTRjNiAxMDA2NDQKLS0tIGEvZHJpdmVycy9n
cHUvZHJtL2FtZC9hbWRrZmQva2ZkX3BhY2tldF9tYW5hZ2VyLmMKKysrIGIvZHJpdmVycy9ncHUv
ZHJtL2FtZC9hbWRrZmQva2ZkX3BhY2tldF9tYW5hZ2VyLmMKQEAgLTE4OCw4ICsxODgsNyBAQCBz
dGF0aWMgaW50IHBtX2NyZWF0ZV9tYXBfcHJvY2VzcyhzdHJ1Y3QgcGFja2V0X21hbmFnZXIgKnBt
LCB1aW50MzJfdCAqYnVmZmVyLAogCXBhY2tldC0+c2hfbWVtX2FwZTFfYmFzZSA9IHFwZC0+c2hf
bWVtX2FwZTFfYmFzZTsKIAlwYWNrZXQtPnNoX21lbV9hcGUxX2xpbWl0ID0gcXBkLT5zaF9tZW1f
YXBlMV9saW1pdDsKIAotCS8qIFRPRE86IHNjcmF0Y2ggc3VwcG9ydCAqLwotCXBhY2tldC0+c2hf
aGlkZGVuX3ByaXZhdGVfYmFzZV92bWlkID0gMDsKKwlwYWNrZXQtPnNoX2hpZGRlbl9wcml2YXRl
X2Jhc2Vfdm1pZCA9IHFwZC0+c2hfaGlkZGVuX3ByaXZhdGVfYmFzZTsKIAogCXBhY2tldC0+Z2Rz
X2FkZHJfbG8gPSBsb3dlcl8zMl9iaXRzKHFwZC0+Z2RzX2NvbnRleHRfYXJlYSk7CiAJcGFja2V0
LT5nZHNfYWRkcl9oaSA9IHVwcGVyXzMyX2JpdHMocXBkLT5nZHNfY29udGV4dF9hcmVhKTsKLS0g
CjIuNy40CgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwph
bWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczov
L2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZngK
