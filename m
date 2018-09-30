From: Rex Zhu <Rex.Zhu-5C7GfCeVMHo@public.gmane.org>
Subject: [PATCH 2/5] drm/amdgpu: Add new AMDGPU_PP_SENSOR_MIN/MAX_FAN_RPM
 sensor
Date: Sun, 30 Sep 2018 14:17:56 +0800
Message-ID: <1538288279-11428-2-git-send-email-Rex.Zhu@amd.com>
References: <1538288279-11428-1-git-send-email-Rex.Zhu@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <1538288279-11428-1-git-send-email-Rex.Zhu-5C7GfCeVMHo@public.gmane.org>
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

Rm9yIGdldHRpbmcgdGhlIG1pbi9tYXggZmFuIHNwZWVkIGluIFJQTSB1bml0cy4KClNpZ25lZC1v
ZmYtYnk6IFJleCBaaHUgPFJleC5aaHVAYW1kLmNvbT4KLS0tCiBkcml2ZXJzL2dwdS9kcm0vYW1k
L2luY2x1ZGUva2dkX3BwX2ludGVyZmFjZS5oIHwgMiArKwogMSBmaWxlIGNoYW5nZWQsIDIgaW5z
ZXJ0aW9ucygrKQoKZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvaW5jbHVkZS9rZ2Rf
cHBfaW50ZXJmYWNlLmggYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2luY2x1ZGUva2dkX3BwX2ludGVy
ZmFjZS5oCmluZGV4IDg1OTM4NTAuLjk3MDAxYTYgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvZ3B1L2Ry
bS9hbWQvaW5jbHVkZS9rZ2RfcHBfaW50ZXJmYWNlLmgKKysrIGIvZHJpdmVycy9ncHUvZHJtL2Ft
ZC9pbmNsdWRlL2tnZF9wcF9pbnRlcmZhY2UuaApAQCAtMTE0LDYgKzExNCw4IEBAIGVudW0gYW1k
X3BwX3NlbnNvcnMgewogCUFNREdQVV9QUF9TRU5TT1JfU1RBQkxFX1BTVEFURV9TQ0xLLAogCUFN
REdQVV9QUF9TRU5TT1JfU1RBQkxFX1BTVEFURV9NQ0xLLAogCUFNREdQVV9QUF9TRU5TT1JfRU5B
QkxFRF9TTUNfRkVBVFVSRVNfTUFTSywKKwlBTURHUFVfUFBfU0VOU09SX01JTl9GQU5fUlBNLAor
CUFNREdQVV9QUF9TRU5TT1JfTUFYX0ZBTl9SUE0sCiB9OwogCiBlbnVtIGFtZF9wcF90YXNrIHsK
LS0gCjEuOS4xCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
XwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRw
czovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZngK
