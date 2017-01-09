From: Monk Liu <Monk.Liu-5C7GfCeVMHo@public.gmane.org>
Subject: [PATCH 6/7] drm/amdgpu:alloc/dealloc csa accordingly
Date: Mon, 9 Jan 2017 16:03:01 +0800
Message-ID: <1483948982-27056-7-git-send-email-Monk.Liu@amd.com>
References: <1483948982-27056-1-git-send-email-Monk.Liu@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <1483948982-27056-1-git-send-email-Monk.Liu-5C7GfCeVMHo@public.gmane.org>
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
Cc: Monk Liu <Monk.Liu-5C7GfCeVMHo@public.gmane.org>

Q2hhbmdlLUlkOiBJMTEwYWY5M2M0ZjE3YWIxOGQxYmUxOTljNmViZTllZTk2NTQ4M2E2NgpTaWdu
ZWQtb2ZmLWJ5OiBNb25rIExpdSA8TW9uay5MaXVAYW1kLmNvbT4KLS0tCiBkcml2ZXJzL2dwdS9k
cm0vYW1kL2FtZGdwdS9hbWRncHVfZGV2aWNlLmMgfCA3ICsrKysrKysKIDEgZmlsZSBjaGFuZ2Vk
LCA3IGluc2VydGlvbnMoKykKCmRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdw
dS9hbWRncHVfZGV2aWNlLmMgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfZGV2
aWNlLmMKaW5kZXggZjgyOTE5ZC4uNTI1M2FhMiAxMDA2NDQKLS0tIGEvZHJpdmVycy9ncHUvZHJt
L2FtZC9hbWRncHUvYW1kZ3B1X2RldmljZS5jCisrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1k
Z3B1L2FtZGdwdV9kZXZpY2UuYwpAQCAtMTM4NCw2ICsxMzg0LDEwIEBAIHN0YXRpYyBpbnQgYW1k
Z3B1X2luaXQoc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYpCiAJCQkJcmV0dXJuIHI7CiAJCQl9
CiAJCQlhZGV2LT5pcF9ibG9ja3NbaV0uc3RhdHVzLmh3ID0gdHJ1ZTsKKworCQkJLyogcmlnaHQg
YWZ0ZXIgR01DIGh3IGluaXQsIHdlIGNyZWF0ZSBDU0EgKi8KKwkJCWlmIChhbWRncHVfc3Jpb3Zf
dmYoYWRldikpCisJCQkJYWRldi0+dmlydC5hbGxvY2F0ZV9jc2EoYWRldik7CiAJCX0KIAl9CiAK
QEAgLTE1MTcsNiArMTUyMSw5IEBAIHN0YXRpYyBpbnQgYW1kZ3B1X2Zpbmkoc3RydWN0IGFtZGdw
dV9kZXZpY2UgKmFkZXYpCiAJCWFkZXYtPmlwX2Jsb2Nrc1tpXS5zdGF0dXMubGF0ZV9pbml0aWFs
aXplZCA9IGZhbHNlOwogCX0KIAorCWlmIChhbWRncHVfc3Jpb3ZfdmYoYWRldikpCisJCWFkZXYt
PnZpcnQuZGVhbGxvY2F0ZV9jc2EoYWRldik7CisKIAlyZXR1cm4gMDsKIH0KIAotLSAKMi43LjQK
Cl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1nZngg
bWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMu
ZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=
