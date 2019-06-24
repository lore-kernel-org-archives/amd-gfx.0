From: "Cui, Flora" <Flora.Cui-5C7GfCeVMHo@public.gmane.org>
Subject: [PATCH] drm/amdgpu: fix scheduler timeout calc
Date: Mon, 24 Jun 2019 08:50:29 +0000
Message-ID: <1561366217-13261-1-git-send-email-flora.cui@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
Content-Language: en-US
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
To: "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
Cc: "Cui, Flora" <Flora.Cui-5C7GfCeVMHo@public.gmane.org>

c2NoZWR1bGVyIHRpbWVvdXQgaXMgaW4gamlmZmllcw0KDQpDaGFuZ2UtSWQ6IEkyNjcwOGMxNjNk
Yjk0M2ZmOGQ5MzBkZDgxYmNhYjRiNGI5ZDg0ZWIyDQpTaWduZWQtb2ZmLWJ5OiBGbG9yYSBDdWkg
PGZsb3JhLmN1aUBhbWQuY29tPg0KLS0tDQogZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1k
Z3B1X2ZlbmNlLmMgfCAzICsrKw0KIDEgZmlsZSBjaGFuZ2VkLCAzIGluc2VydGlvbnMoKykNCg0K
ZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9mZW5jZS5jIGIv
ZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2ZlbmNlLmMNCmluZGV4IGNiY2FhN2Mu
LjJlZGFhNmMgMTAwNjQ0DQotLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVf
ZmVuY2UuYw0KKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2ZlbmNlLmMN
CkBAIC00ODEsNiArNDgxLDkgQEAgaW50IGFtZGdwdV9mZW5jZV9kcml2ZXJfaW5pdF9yaW5nKHN0
cnVjdCBhbWRncHVfcmluZyAqcmluZywNCiAJCQlicmVhazsNCiAJCX0NCiANCisJCWlmICh0aW1l
b3V0ICE9IE1BWF9TQ0hFRFVMRV9USU1FT1VUKQ0KKwkJCXRpbWVvdXQgPSBtc2Vjc190b19qaWZm
aWVzKHRpbWVvdXQpOw0KKw0KIAkJciA9IGRybV9zY2hlZF9pbml0KCZyaW5nLT5zY2hlZCwgJmFt
ZGdwdV9zY2hlZF9vcHMsDQogCQkJCSAgIG51bV9od19zdWJtaXNzaW9uLCBhbWRncHVfam9iX2hh
bmdfbGltaXQsDQogCQkJCSAgIHRpbWVvdXQsIHJpbmctPm5hbWUpOw0KLS0gDQoyLjcuNA0KDQpf
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1h
aWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZy
ZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZng=
