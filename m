From: Alex Deucher <alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH 2/6] drm/amdgpu/mn: fix documentation for amdgpu_mn_read_lock
Date: Thu, 19 Sep 2019 16:45:23 -0500
Message-ID: <20190919214527.10803-2-alexander.deucher@amd.com>
References: <20190919214527.10803-1-alexander.deucher@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <20190919214527.10803-1-alexander.deucher-5C7GfCeVMHo@public.gmane.org>
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

RG9jdW1lbnQgdGhlIG5ldyBwYXJhbWV0ZXIuCgpGaXhlczogOTMwNjVhYzc1M2U0ICgibW0sIG9v
bTogZGlzdGluZ3Vpc2ggYmxvY2thYmxlIG1vZGUgZm9yIG1tdSBub3RpZmllcnMiKQpTaWduZWQt
b2ZmLWJ5OiBBbGV4IERldWNoZXIgPGFsZXhhbmRlci5kZXVjaGVyQGFtZC5jb20+Ci0tLQogZHJp
dmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X21uLmMgfCAxICsKIDEgZmlsZSBjaGFuZ2Vk
LCAxIGluc2VydGlvbigrKQoKZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1
L2FtZGdwdV9tbi5jIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X21uLmMKaW5k
ZXggZjFmOGNkZDY5NWQzLi5hZTIzMzEyODBlNDUgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvZ3B1L2Ry
bS9hbWQvYW1kZ3B1L2FtZGdwdV9tbi5jCisrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1
L2FtZGdwdV9tbi5jCkBAIC0xMzYsNiArMTM2LDcgQEAgdm9pZCBhbWRncHVfbW5fdW5sb2NrKHN0
cnVjdCBhbWRncHVfbW4gKm1uKQogICogYW1kZ3B1X21uX3JlYWRfbG9jayAtIHRha2UgdGhlIHJl
YWQgc2lkZSBsb2NrIGZvciB0aGlzIG5vdGlmaWVyCiAgKgogICogQGFtbjogb3VyIG5vdGlmaWVy
CisgKiBAYmxvY2thYmxlOiBpcyB0aGUgbm90aWZpZXIgYmxvY2thYmxlCiAgKi8KIHN0YXRpYyBp
bnQgYW1kZ3B1X21uX3JlYWRfbG9jayhzdHJ1Y3QgYW1kZ3B1X21uICphbW4sIGJvb2wgYmxvY2th
YmxlKQogewotLSAKMi4yMC4xCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9w
Lm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1n
Zng=
