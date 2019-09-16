From: Alex Deucher <alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH 2/2] drm/amdgpu: fix documentation for
 amdgpu_bo_create_kernel_at
Date: Mon, 16 Sep 2019 13:43:13 -0500
Message-ID: <20190916184313.20567-2-alexander.deucher@amd.com>
References: <20190916184313.20567-1-alexander.deucher@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <20190916184313.20567-1-alexander.deucher-5C7GfCeVMHo@public.gmane.org>
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

VHlwbyBpbiB0aGUgZnVuY3Rpb24gbmFtZS4KCkZpeGVzOiAwZDlhODAyMTM4MjkgKCJkcm0vYW1k
Z3B1OiBjbGVhbnVwIGNyZWF0aW5nIEJPcyBhdCBmaXhlZCBsb2NhdGlvbiIpClNpZ25lZC1vZmYt
Ynk6IEFsZXggRGV1Y2hlciA8YWxleGFuZGVyLmRldWNoZXJAYW1kLmNvbT4KLS0tCiBkcml2ZXJz
L2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfb2JqZWN0LmMgfCAyICstCiAxIGZpbGUgY2hhbmdl
ZCwgMSBpbnNlcnRpb24oKyksIDEgZGVsZXRpb24oLSkKCmRpZmYgLS1naXQgYS9kcml2ZXJzL2dw
dS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfb2JqZWN0LmMgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2Ft
ZGdwdS9hbWRncHVfb2JqZWN0LmMKaW5kZXggNzBkNDVkNDg5MDdhLi5lY2FkODRlMWI0ZTIgMTAw
NjQ0Ci0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9vYmplY3QuYworKysg
Yi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfb2JqZWN0LmMKQEAgLTM0Myw3ICsz
NDMsNyBAQCBpbnQgYW1kZ3B1X2JvX2NyZWF0ZV9rZXJuZWwoc3RydWN0IGFtZGdwdV9kZXZpY2Ug
KmFkZXYsCiB9CiAKIC8qKgotICogYW1kZ3B1X2JvX2NyZWF0ZV9rZXJuZWwgLSBjcmVhdGUgQk8g
Zm9yIGtlcm5lbCB1c2UgYXQgc3BlY2lmaWMgbG9jYXRpb24KKyAqIGFtZGdwdV9ib19jcmVhdGVf
a2VybmVsX2F0IC0gY3JlYXRlIEJPIGZvciBrZXJuZWwgdXNlIGF0IHNwZWNpZmljIGxvY2F0aW9u
CiAgKgogICogQGFkZXY6IGFtZGdwdSBkZXZpY2Ugb2JqZWN0CiAgKiBAb2Zmc2V0OiBvZmZzZXQg
b2YgdGhlIEJPCi0tIAoyLjIwLjEKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0
b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1k
LWdmeA==
