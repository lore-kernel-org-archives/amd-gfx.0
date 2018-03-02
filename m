From: Rex Zhu <Rex.Zhu-5C7GfCeVMHo@public.gmane.org>
Subject: [PATCH] drm/amd/pp: Fix incorrect return value in
 smu7_check_clk_voltage_valid
Date: Fri, 2 Mar 2018 18:49:22 +0800
Message-ID: <1519987762-27156-1-git-send-email-Rex.Zhu@amd.com>
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
Cc: Rex Zhu <Rex.Zhu-5C7GfCeVMHo@public.gmane.org>

Q2hhbmdlLUlkOiBJMjQ4OTgyYzVlMDEwMGI3YTk3NWQxYTE5NzgxNzQ5YmFlYWRkNzFmNApTaWdu
ZWQtb2ZmLWJ5OiBSZXggWmh1IDxSZXguWmh1QGFtZC5jb20+Ci0tLQogZHJpdmVycy9ncHUvZHJt
L2FtZC9wb3dlcnBsYXkvaHdtZ3Ivc211N19od21nci5jIHwgMiArLQogMSBmaWxlIGNoYW5nZWQs
IDEgaW5zZXJ0aW9uKCspLCAxIGRlbGV0aW9uKC0pCgpkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUv
ZHJtL2FtZC9wb3dlcnBsYXkvaHdtZ3Ivc211N19od21nci5jIGIvZHJpdmVycy9ncHUvZHJtL2Ft
ZC9wb3dlcnBsYXkvaHdtZ3Ivc211N19od21nci5jCmluZGV4IGRiZmUxMzkuLjEwZmIzZWMgMTAw
NjQ0Ci0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvcG93ZXJwbGF5L2h3bWdyL3NtdTdfaHdtZ3Iu
YworKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL3Bvd2VycGxheS9od21nci9zbXU3X2h3bWdyLmMK
QEAgLTQ2OTIsNyArNDY5Miw3IEBAIHN0YXRpYyBib29sIHNtdTdfY2hlY2tfY2xrX3ZvbHRhZ2Vf
dmFsaWQoc3RydWN0IHBwX2h3bWdyICpod21nciwKIAlzdHJ1Y3QgcGhtX3BwdF92MV9jbG9ja192
b2x0YWdlX2RlcGVuZGVuY3lfdGFibGUgKmRlcF9zY2xrX3RhYmxlOwogCiAJaWYgKHRhYmxlX2lu
Zm8gPT0gTlVMTCkKLQkJcmV0dXJuIC1FSU5WQUw7CisJCXJldHVybiBmYWxzZTsKIAogCWRlcF9z
Y2xrX3RhYmxlID0gdGFibGVfaW5mby0+dmRkX2RlcF9vbl9zY2xrOwogCW1pbl92ZGRjID0gZGVw
X3NjbGtfdGFibGUtPmVudHJpZXNbMF0udmRkYzsKLS0gCjEuOS4xCgpfX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQt
Z2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9t
YWlsbWFuL2xpc3RpbmZvL2FtZC1nZngK
