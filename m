From: Samuel Li <Samuel.Li-5C7GfCeVMHo@public.gmane.org>
Subject: [PATCH 1/1] amdgpu: add scatter gather display flag
Date: Fri,  2 Mar 2018 18:27:09 -0500
Message-ID: <1520033229-30106-1-git-send-email-Samuel.Li@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
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
Cc: Samuel Li <Samuel.Li-5C7GfCeVMHo@public.gmane.org>

LS0tCiBpbmNsdWRlL2RybS9hbWRncHVfZHJtLmggfCAxICsKIDEgZmlsZSBjaGFuZ2VkLCAxIGlu
c2VydGlvbigrKQoKZGlmZiAtLWdpdCBhL2luY2x1ZGUvZHJtL2FtZGdwdV9kcm0uaCBiL2luY2x1
ZGUvZHJtL2FtZGdwdV9kcm0uaAppbmRleCBkOWFhNGEzLi5kYzRkOGJkIDEwMDY0NAotLS0gYS9p
bmNsdWRlL2RybS9hbWRncHVfZHJtLmgKKysrIGIvaW5jbHVkZS9kcm0vYW1kZ3B1X2RybS5oCkBA
IC01MjYsNiArNTI2LDcgQEAgc3RydWN0IGRybV9hbWRncHVfY3NfY2h1bmtfZGF0YSB7CiAgKi8K
ICNkZWZpbmUgQU1ER1BVX0lEU19GTEFHU19GVVNJT04gICAgICAgICAweDEKICNkZWZpbmUgQU1E
R1BVX0lEU19GTEFHU19QUkVFTVBUSU9OICAgICAweDIKKyNkZWZpbmUgQU1ER1BVX0lEU19GTEFH
U19TR0RJU1BMQVkgICAgICAweDQKIAogLyogaW5kaWNhdGUgaWYgYWNjZWxlcmF0aW9uIGNhbiBi
ZSB3b3JraW5nICovCiAjZGVmaW5lIEFNREdQVV9JTkZPX0FDQ0VMX1dPUktJTkcJCTB4MDAKLS0g
CjIuNy40CgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwph
bWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczov
L2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZngK
