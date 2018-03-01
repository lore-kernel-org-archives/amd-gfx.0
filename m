From: "=?UTF-8?q?Christian=20K=C3=B6nig?=" <ckoenig.leichtzumerken-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH 3/4] drm/amdgpu: ignore changes of buffer function status
 because of GPU resets
Date: Thu,  1 Mar 2018 11:22:43 +0100
Message-ID: <20180301102244.1684-3-christian.koenig@amd.com>
References: <20180301102244.1684-1-christian.koenig@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <20180301102244.1684-1-christian.koenig-5C7GfCeVMHo@public.gmane.org>
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
Cc: Monk.Liu-5C7GfCeVMHo@public.gmane.org

V2hlbiB3ZSByZXNldCB0aGUgR1BVIHdlIGFsc28gZGlzYWJsZS9lbmFibGUgdGhlIFNETUEsIGJ1
dCB3ZSBkb24ndCB3YW50CnRvIGNoYW5nZSBUVE0gaWRlYSBvZiB0aGUgVlJBTSBzaXplIGluIHRo
ZSBtaWRkbGUgb2YgdGhhdC4KClNpZ25lZC1vZmYtYnk6IENocmlzdGlhbiBLw7ZuaWcgPGNocmlz
dGlhbi5rb2VuaWdAYW1kLmNvbT4KLS0tCiBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRn
cHVfdHRtLmMgfCAyICstCiAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKyksIDEgZGVsZXRp
b24oLSkKCmRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfdHRt
LmMgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfdHRtLmMKaW5kZXggNDZkN2E2
OTBhMjg3Li4yYWE2ODIzZWY1MDMgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1k
Z3B1L2FtZGdwdV90dG0uYworKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVf
dHRtLmMKQEAgLTE1NDAsNyArMTU0MCw3IEBAIHZvaWQgYW1kZ3B1X3R0bV9zZXRfYnVmZmVyX2Z1
bmNzX3N0YXR1cyhzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRldiwgYm9vbCBlbmFibGUpCiAJc3Ry
dWN0IHR0bV9tZW1fdHlwZV9tYW5hZ2VyICptYW4gPSAmYWRldi0+bW1hbi5iZGV2Lm1hbltUVE1f
UExfVlJBTV07CiAJdWludDY0X3Qgc2l6ZTsKIAotCWlmICghYWRldi0+bW1hbi5pbml0aWFsaXpl
ZCkKKwlpZiAoIWFkZXYtPm1tYW4uaW5pdGlhbGl6ZWQgfHwgYWRldi0+aW5fZ3B1X3Jlc2V0KQog
CQlyZXR1cm47CiAKIAkvKiB0aGlzIGp1c3QgYWRqdXN0cyBUVE0gc2l6ZSBpZGVhLCB3aGljaCBz
ZXRzIGxwZm4gdG8gdGhlIGNvcnJlY3QgdmFsdWUgKi8KLS0gCjIuMTQuMQoKX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QK
YW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5v
cmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==
