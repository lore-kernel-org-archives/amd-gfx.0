From: Chunming Zhou <David1.Zhou-5C7GfCeVMHo@public.gmane.org>
Subject: [PATCH 03/11] drm/amd: add recover run queue for scheduler
Date: Tue, 2 Aug 2016 15:51:34 +0800
Message-ID: <1470124302-23615-4-git-send-email-David1.Zhou@amd.com>
References: <1470124302-23615-1-git-send-email-David1.Zhou@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <1470124302-23615-1-git-send-email-David1.Zhou-5C7GfCeVMHo@public.gmane.org>
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
Cc: Chunming Zhou <David1.Zhou-5C7GfCeVMHo@public.gmane.org>

Q2hhbmdlLUlkOiBJNzE3MWQxZTM4ODRhYWJlMTI2M2Q4ZjdiZTE4Y2FkZjJlOTgyMTZhNApTaWdu
ZWQtb2ZmLWJ5OiBDaHVubWluZyBaaG91IDxEYXZpZDEuWmhvdUBhbWQuY29tPgpSZXZpZXdlZC1i
eTogRWR3YXJkIE8nQ2FsbGFnaGFuIDxmdW5mdW5jdG9yQGZvbGtsb3JlMTk4NC5uZXQ+Ci0tLQog
ZHJpdmVycy9ncHUvZHJtL2FtZC9zY2hlZHVsZXIvZ3B1X3NjaGVkdWxlci5oIHwgMyArKy0KIDEg
ZmlsZSBjaGFuZ2VkLCAyIGluc2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkKCmRpZmYgLS1naXQg
YS9kcml2ZXJzL2dwdS9kcm0vYW1kL3NjaGVkdWxlci9ncHVfc2NoZWR1bGVyLmggYi9kcml2ZXJz
L2dwdS9kcm0vYW1kL3NjaGVkdWxlci9ncHVfc2NoZWR1bGVyLmgKaW5kZXggYTFjMDA3My4uY2Q4
N2JjNyAxMDA2NDQKLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9zY2hlZHVsZXIvZ3B1X3NjaGVk
dWxlci5oCisrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvc2NoZWR1bGVyL2dwdV9zY2hlZHVsZXIu
aApAQCAtMTEyLDcgKzExMiw4IEBAIHN0cnVjdCBhbWRfc2NoZWRfYmFja2VuZF9vcHMgewogfTsK
IAogZW51bSBhbWRfc2NoZWRfcHJpb3JpdHkgewotCUFNRF9TQ0hFRF9QUklPUklUWV9LRVJORUwg
PSAwLAorCUFNRF9TQ0hFRF9QUklPUklUWV9SRUNPVkVSID0gMCwKKwlBTURfU0NIRURfUFJJT1JJ
VFlfS0VSTkVMLAogCUFNRF9TQ0hFRF9QUklPUklUWV9OT1JNQUwsCiAJQU1EX1NDSEVEX01BWF9Q
UklPUklUWQogfTsKLS0gCjEuOS4xCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNr
dG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2Ft
ZC1nZngK
