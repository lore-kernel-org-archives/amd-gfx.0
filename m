From: Alex Deucher <alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH 09/32] drm/amdgpu: add VEGAM GMC golden settings
Date: Wed, 25 Apr 2018 21:18:14 -0500
Message-ID: <20180426021837.17758-9-alexander.deucher@amd.com>
References: <20180426021837.17758-1-alexander.deucher@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <20180426021837.17758-1-alexander.deucher-5C7GfCeVMHo@public.gmane.org>
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
Cc: Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org>, Leo Liu <leo.liu-5C7GfCeVMHo@public.gmane.org>

RnJvbTogTGVvIExpdSA8bGVvLmxpdUBhbWQuY29tPgoKU2lnbmVkLW9mZi1ieTogTGVvIExpdSA8
bGVvLmxpdUBhbWQuY29tPgpSZXZpZXdlZC1ieTogQWxleCBEZXVjaGVyIDxhbGV4YW5kZXIuZGV1
Y2hlckBhbWQuY29tPgpTaWduZWQtb2ZmLWJ5OiBBbGV4IERldWNoZXIgPGFsZXhhbmRlci5kZXVj
aGVyQGFtZC5jb20+Ci0tLQogZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvZ21jX3Y4XzAuYyB8
IDEgKwogMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspCgpkaWZmIC0tZ2l0IGEvZHJpdmVy
cy9ncHUvZHJtL2FtZC9hbWRncHUvZ21jX3Y4XzAuYyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1k
Z3B1L2dtY192OF8wLmMKaW5kZXggOTdmY2NhODA1ZDQ4Li42NzIxYjA0Yjc3OTYgMTAwNjQ0Ci0t
LSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2dtY192OF8wLmMKKysrIGIvZHJpdmVycy9n
cHUvZHJtL2FtZC9hbWRncHUvZ21jX3Y4XzAuYwpAQCAtMTM4LDYgKzEzOCw3IEBAIHN0YXRpYyB2
b2lkIGdtY192OF8wX2luaXRfZ29sZGVuX3JlZ2lzdGVycyhzdHJ1Y3QgYW1kZ3B1X2RldmljZSAq
YWRldikKIAkJYnJlYWs7CiAJY2FzZSBDSElQX1BPTEFSSVMxMToKIAljYXNlIENISVBfUE9MQVJJ
UzEyOgorCWNhc2UgQ0hJUF9WRUdBTToKIAkJYW1kZ3B1X2RldmljZV9wcm9ncmFtX3JlZ2lzdGVy
X3NlcXVlbmNlKGFkZXYsCiAJCQkJCQkJZ29sZGVuX3NldHRpbmdzX3BvbGFyaXMxMV9hMTEsCiAJ
CQkJCQkJQVJSQVlfU0laRShnb2xkZW5fc2V0dGluZ3NfcG9sYXJpczExX2ExMSkpOwotLSAKMi4x
My42CgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwphbWQt
Z2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xp
c3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZngK
