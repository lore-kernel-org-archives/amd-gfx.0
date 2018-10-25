From: <sunpeng.li-5C7GfCeVMHo@public.gmane.org>
Subject: [PATCH 05/21] drm/amd/display: Add missing pipes registers for VGA
 enable/disable
Date: Thu, 25 Oct 2018 09:18:22 -0400
Message-ID: <1540473518-19717-6-git-send-email-sunpeng.li@amd.com>
References: <1540473518-19717-1-git-send-email-sunpeng.li@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <1540473518-19717-1-git-send-email-sunpeng.li-5C7GfCeVMHo@public.gmane.org>
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
Cc: Nevenko Stupar <Nevenko.Stupar-5C7GfCeVMHo@public.gmane.org>

RnJvbTogTmV2ZW5rbyBTdHVwYXIgPE5ldmVua28uU3R1cGFyQGFtZC5jb20+CgpTaWduZWQtb2Zm
LWJ5OiBOZXZlbmtvIFN0dXBhciA8TmV2ZW5rby5TdHVwYXJAYW1kLmNvbT4KUmV2aWV3ZWQtYnk6
IEFyaWMgQ3lyIDxBcmljLkN5ckBhbWQuY29tPgpBY2tlZC1ieTogTGVvIExpIDxzdW5wZW5nLmxp
QGFtZC5jb20+Ci0tLQogZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5L2RjL2RjZS9kY2VfaHdz
ZXEuaCB8IDIgKysKIDEgZmlsZSBjaGFuZ2VkLCAyIGluc2VydGlvbnMoKykKCmRpZmYgLS1naXQg
YS9kcml2ZXJzL2dwdS9kcm0vYW1kL2Rpc3BsYXkvZGMvZGNlL2RjZV9od3NlcS5oIGIvZHJpdmVy
cy9ncHUvZHJtL2FtZC9kaXNwbGF5L2RjL2RjZS9kY2VfaHdzZXEuaAppbmRleCA3ZDk3Nzg3Li5j
ODNhN2YwIDEwMDY0NAotLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2Rpc3BsYXkvZGMvZGNlL2Rj
ZV9od3NlcS5oCisrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxheS9kYy9kY2UvZGNlX2h3
c2VxLmgKQEAgLTI4Miw2ICsyODIsOCBAQCBzdHJ1Y3QgZGNlX2h3c2VxX3JlZ2lzdGVycyB7CiAJ
dWludDMyX3QgRDJWR0FfQ09OVFJPTDsKIAl1aW50MzJfdCBEM1ZHQV9DT05UUk9MOwogCXVpbnQz
Ml90IEQ0VkdBX0NPTlRST0w7CisJdWludDMyX3QgRDVWR0FfQ09OVFJPTDsKKwl1aW50MzJfdCBE
NlZHQV9DT05UUk9MOwogCXVpbnQzMl90IFZHQV9URVNUX0NPTlRST0w7CiAJLyogTU1IVUIgcmVn
aXN0ZXJzLiByZWFkIG9ubHkuIHRlbXBvcmFyeSBoYWNrICovCiAJdWludDMyX3QgVk1fQ09OVEVY
VDBfUEFHRV9UQUJMRV9CQVNFX0FERFJfSEkzMjsKLS0gCjIuNy40CgpfX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQt
Z2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9t
YWlsbWFuL2xpc3RpbmZvL2FtZC1nZngK
