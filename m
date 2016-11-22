From: Alex Deucher <alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH 07/11] drm/amd/dal/dc: fix warning in dce110_resource.c
Date: Tue, 22 Nov 2016 11:57:24 -0500
Message-ID: <1479833848-14275-7-git-send-email-alexander.deucher@amd.com>
References: <1479833848-14275-1-git-send-email-alexander.deucher@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <1479833848-14275-1-git-send-email-alexander.deucher-5C7GfCeVMHo@public.gmane.org>
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

UmV2aWV3ZWQtYnk6IEhhcnJ5IFdlbnRsYW5kIDxoYXJyeS53ZW50bGFuZEBhbWQuY29tPgpTaWdu
ZWQtb2ZmLWJ5OiBBbGV4IERldWNoZXIgPGFsZXhhbmRlci5kZXVjaGVyQGFtZC5jb20+Ci0tLQog
ZHJpdmVycy9ncHUvZHJtL2FtZC9kYWwvZGMvZGNlMTEwL2RjZTExMF9yZXNvdXJjZS5jIHwgMSAt
CiAxIGZpbGUgY2hhbmdlZCwgMSBkZWxldGlvbigtKQoKZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1
L2RybS9hbWQvZGFsL2RjL2RjZTExMC9kY2UxMTBfcmVzb3VyY2UuYyBiL2RyaXZlcnMvZ3B1L2Ry
bS9hbWQvZGFsL2RjL2RjZTExMC9kY2UxMTBfcmVzb3VyY2UuYwppbmRleCBmOWNlYmM5Li40ZGI4
YzRkIDEwMDY0NAotLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2RhbC9kYy9kY2UxMTAvZGNlMTEw
X3Jlc291cmNlLmMKKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9kYWwvZGMvZGNlMTEwL2RjZTEx
MF9yZXNvdXJjZS5jCkBAIC0xMjM4LDcgKzEyMzgsNiBAQCBzdGF0aWMgYm9vbCBjb25zdHJ1Y3Qo
CiAJc3RydWN0IGZpcm13YXJlX2luZm8gaW5mbzsKIAlzdHJ1Y3QgZGNfYmlvcyAqYnA7CiAJc3Ry
dWN0IGRtX3BwX3N0YXRpY19jbG9ja19pbmZvIHN0YXRpY19jbGtfaW5mbyA9IHswfTsKLQlzdHJ1
Y3QgcmVzb3VyY2Vfc3RyYXBzIHN0cmFwcyA9IHswfTsKIAogCWN0eC0+ZGNfYmlvcy0+cmVncyA9
ICZiaW9zX3JlZ3M7CiAKLS0gCjIuNS41CgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVk
ZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZv
L2FtZC1nZngK
