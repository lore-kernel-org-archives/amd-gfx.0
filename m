From: Rex Zhu <Rex.Zhu-5C7GfCeVMHo@public.gmane.org>
Subject: [PATCH 2/2] drm/amdgpu: Add helper function
 amdgpu_ring_set_preempt_cond_exec
Date: Wed, 24 Oct 2018 23:27:52 +0800
Message-ID: <1540394872-31733-2-git-send-email-Rex.Zhu@amd.com>
References: <1540394872-31733-1-git-send-email-Rex.Zhu@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <1540394872-31733-1-git-send-email-Rex.Zhu-5C7GfCeVMHo@public.gmane.org>
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

Y2FuIHByZWVtcHQgdGhlIHJpbmcgYnkgc2V0dGluZyBjb25kX2V4ZWMgdG8gZmFsc2UKClNpZ25l
ZC1vZmYtYnk6IFJleCBaaHUgPFJleC5aaHVAYW1kLmNvbT4KLS0tCiBkcml2ZXJzL2dwdS9kcm0v
YW1kL2FtZGdwdS9hbWRncHVfcmluZy5oIHwgNiArKysrKysKIDEgZmlsZSBjaGFuZ2VkLCA2IGlu
c2VydGlvbnMoKykKCmRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRn
cHVfcmluZy5oIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3JpbmcuaAppbmRl
eCBlZjcyNTJhLi41NGNhOGEzIDEwMDY0NAotLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdw
dS9hbWRncHVfcmluZy5oCisrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9y
aW5nLmgKQEAgLTI2Niw2ICsyNjYsMTIgQEAgdm9pZCBhbWRncHVfcmluZ19lbWl0X3JlZ193cml0
ZV9yZWdfd2FpdF9oZWxwZXIoc3RydWN0IGFtZGdwdV9yaW5nICpyaW5nLAogYm9vbCBhbWRncHVf
cmluZ19zb2Z0X3JlY292ZXJ5KHN0cnVjdCBhbWRncHVfcmluZyAqcmluZywgdW5zaWduZWQgaW50
IHZtaWQsCiAJCQkgICAgICAgc3RydWN0IGRtYV9mZW5jZSAqZmVuY2UpOwogCitzdGF0aWMgaW5s
aW5lIHZvaWQgYW1kZ3B1X3Jpbmdfc2V0X3ByZWVtcHRfY29uZF9leGVjKHN0cnVjdCBhbWRncHVf
cmluZyAqcmluZywKKwkJCQkJCQlib29sIGNvbmRfZXhlYykKK3sKKwkqcmluZy0+Y29uZF9leGVf
Y3B1X2FkZHIgPSBjb25kX2V4ZWM7Cit9CisKIHN0YXRpYyBpbmxpbmUgdm9pZCBhbWRncHVfcmlu
Z19jbGVhcl9yaW5nKHN0cnVjdCBhbWRncHVfcmluZyAqcmluZykKIHsKIAlpbnQgaSA9IDA7Ci0t
IAoxLjkuMQoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18K
YW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6
Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==
