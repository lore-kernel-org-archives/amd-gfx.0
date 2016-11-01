From: Trigger Huang <trigger.huang-5C7GfCeVMHo@public.gmane.org>
Subject: [PATCH] drm/amdgpu: Add a ring type KIQ definition
Date: Tue, 1 Nov 2016 03:20:22 -0400
Message-ID: <1477984822-10195-1-git-send-email-trigger.huang@amd.com>
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
Cc: Xiangliang.Yu-5C7GfCeVMHo@public.gmane.org, monk.liu-5C7GfCeVMHo@public.gmane.org, Trigger Huang <trigger.huang-5C7GfCeVMHo@public.gmane.org>

QWRkIGEgbmV3IHJpbmcgdHlwZSBkZWZpbml0aW9uIGZvciBLSVEuIEtJUSBpcyB1c2VkIGZvciBp
bnRlcmFjdGlvbgpiZXR3ZWVuIGRyaXZlciBhbmQgQ1AuCgpTaWduZWQtb2ZmLWJ5OiBYaWFuZ2xp
YW5nIFl1IDxYaWFuZ2xpYW5nLll1QGFtZC5jb20+ClNpZ25lZC1vZmYtYnk6IFRyaWdnZXIgSHVh
bmcgPHRyaWdnZXIuaHVhbmdAYW1kLmNvbT4KLS0tCiBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdw
dS9hbWRncHVfcmluZy5oIHwgMyArKy0KIDEgZmlsZSBjaGFuZ2VkLCAyIGluc2VydGlvbnMoKyks
IDEgZGVsZXRpb24oLSkKCmRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9h
bWRncHVfcmluZy5oIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3JpbmcuaApp
bmRleCAxZWUxYjY1Li45MmJjODliIDEwMDY0NAotLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2Ft
ZGdwdS9hbWRncHVfcmluZy5oCisrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdw
dV9yaW5nLmgKQEAgLTQ0LDcgKzQ0LDggQEAgZW51bSBhbWRncHVfcmluZ190eXBlIHsKIAlBTURH
UFVfUklOR19UWVBFX0NPTVBVVEUsCiAJQU1ER1BVX1JJTkdfVFlQRV9TRE1BLAogCUFNREdQVV9S
SU5HX1RZUEVfVVZELAotCUFNREdQVV9SSU5HX1RZUEVfVkNFCisJQU1ER1BVX1JJTkdfVFlQRV9W
Q0UsCisJQU1ER1BVX1JJTkdfVFlQRV9LSVEKIH07CiAKIHN0cnVjdCBhbWRncHVfZGV2aWNlOwot
LSAKMi43LjQKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
CmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBz
Oi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=
