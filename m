From: Rex Zhu <Rex.Zhu-5C7GfCeVMHo@public.gmane.org>
Subject: [PATCH 10/12] drm/amdgpu: enable vce pg feature on Kv.
Date: Thu, 26 Jan 2017 19:00:36 +0800
Message-ID: <1485428438-13989-11-git-send-email-Rex.Zhu@amd.com>
References: <1485428438-13989-1-git-send-email-Rex.Zhu@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <1485428438-13989-1-git-send-email-Rex.Zhu-5C7GfCeVMHo@public.gmane.org>
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

Q2hhbmdlLUlkOiBJZGFmYjBmYmQ2YmRhZTFkMjlhMmJjNWJiMTQyMTU4NzE0NDA2ZTY4MQpTaWdu
ZWQtb2ZmLWJ5OiBSZXggWmh1IDxSZXguWmh1QGFtZC5jb20+ClJldmlld2VkLWJ5OiBBbGV4IERl
dWNoZXIgPGFsZXhhbmRlci5kZXVjaGVyQGFtZC5jb20+Ci0tLQogZHJpdmVycy9ncHUvZHJtL2Ft
ZC9hbWRncHUvY2lrLmMgfCA0ICsrLS0KIDEgZmlsZSBjaGFuZ2VkLCAyIGluc2VydGlvbnMoKyks
IDIgZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUv
Y2lrLmMgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9jaWsuYwppbmRleCBkYTI1NWU1Li5l
ODg1ZGI0IDEwMDY0NAotLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9jaWsuYworKysg
Yi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9jaWsuYwpAQCAtMTcyMyw4ICsxNzIzLDggQEAg
c3RhdGljIGludCBjaWtfY29tbW9uX2Vhcmx5X2luaXQodm9pZCAqaGFuZGxlKQogCQkJICBBTURf
UEdfU1VQUE9SVF9HRlhfU01HIHwKIAkJCSAgQU1EX1BHX1NVUFBPUlRfR0ZYX0RNRyB8Ki8KIAkJ
CUFNRF9QR19TVVBQT1JUX1VWRCB8Ci0JCQkvKkFNRF9QR19TVVBQT1JUX1ZDRSB8Ci0JCQkgIEFN
RF9QR19TVVBQT1JUX0NQIHwKKwkJCUFNRF9QR19TVVBQT1JUX1ZDRSB8CisJCQkvKiAgQU1EX1BH
X1NVUFBPUlRfQ1AgfAogCQkJICBBTURfUEdfU1VQUE9SVF9HRFMgfAogCQkJICBBTURfUEdfU1VQ
UE9SVF9STENfU01VX0hTIHwKIAkJCSAgQU1EX1BHX1NVUFBPUlRfQUNQIHwKLS0gCjEuOS4xCgpf
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1h
aWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZy
ZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZngK
