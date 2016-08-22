From: root <"root@rezhu"@amd.com>
Subject: [PATCH 3/3] drm/amdgpu: add vce bypass mode for tonga.
Date: Mon, 22 Aug 2016 19:41:31 +0800
Message-ID: <1471866091-28963-3-git-send-email-user@rexzhu>
References: <1471866091-28963-1-git-send-email-user@rexzhu>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <1471866091-28963-1-git-send-email-user@rexzhu>
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

RnJvbTogUmV4IFpodSA8UmV4LlpodUBhbWQuY29tPgoKZml4IGlzc3VlIHRoYXQgZW5jb2RlIHRl
c3QgZmFpbGVkIG9uIHRoZSBzZWNvbmQgdGltZSB3aGVuCnZjZSBkcG0gZW5hYmxlZCBvbiB0b25n
YS4KClNpZ25lZC1vZmYtYnk6IFJleCBaaHUgPFJleC5aaHVAYW1kLmNvbT4KCkNoYW5nZS1JZDog
STljNzdiNjMxYjk3N2FiNWNjMTRkYzU1M2I2ZTZiZWI1MDJlNGJkMGUKUmV2aWV3ZWQtYnk6IEFs
ZXggRGV1Y2hlciA8YWxleGFuZGVyLmRldWNoZXJAYW1kLmNvbT4KLS0tCiBkcml2ZXJzL2dwdS9k
cm0vYW1kL2FtZGdwdS92Y2VfdjNfMC5jIHwgMyArKy0KIDEgZmlsZSBjaGFuZ2VkLCAyIGluc2Vy
dGlvbnMoKyksIDEgZGVsZXRpb24oLSkKCmRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1k
L2FtZGdwdS92Y2VfdjNfMC5jIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvdmNlX3YzXzAu
YwppbmRleCBkZjY2YWJlLi4xNjhiMGRiIDEwMDY0NAotLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1k
L2FtZGdwdS92Y2VfdjNfMC5jCisrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L3ZjZV92
M18wLmMKQEAgLTcwNCw3ICs3MDQsOCBAQCBzdGF0aWMgaW50IHZjZV92M18wX3NldF9jbG9ja2dh
dGluZ19zdGF0ZSh2b2lkICpoYW5kbGUsCiAJYm9vbCBlbmFibGUgPSAoc3RhdGUgPT0gQU1EX0NH
X1NUQVRFX0dBVEUpID8gdHJ1ZSA6IGZhbHNlOwogCWludCBpOwogCi0JaWYgKGFkZXYtPmFzaWNf
dHlwZSA9PSBDSElQX1BPTEFSSVMxMCkKKwlpZiAoKGFkZXYtPmFzaWNfdHlwZSA9PSBDSElQX1BP
TEFSSVMxMCkgfHwKKwkgICAgKGFkZXYtPmFzaWNfdHlwZSA9PSBDSElQX1RPTkdBKSkKIAkJdmNl
X3YzXzBfc2V0X2J5cGFzc19tb2RlKGFkZXYsIGVuYWJsZSk7CiAKIAlpZiAoIShhZGV2LT5jZ19m
bGFncyAmIEFNRF9DR19TVVBQT1JUX1ZDRV9NR0NHKSkKLS0gCjEuOS4xCgpfX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAph
bWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9y
Zy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZngK
