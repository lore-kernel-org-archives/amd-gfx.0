From: =?UTF-8?q?Michel=20D=C3=A4nzer?= <michel-otUistvHUpPR7s880joybQ@public.gmane.org>
Subject: [PATCH libdrm] amdgpu: Deinitialize vamgr_high{,_32}
Date: Fri, 27 Apr 2018 16:44:45 +0200
Message-ID: <20180427144445.21127-1-michel@daenzer.net>
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

RnJvbTogTWljaGVsIETDpG56ZXIgPG1pY2hlbC5kYWVuemVyQGFtZC5jb20+CgpGaXhlcyBtZW1v
cnkgbGVha3MuCgpTaWduZWQtb2ZmLWJ5OiBNaWNoZWwgRMOkbnplciA8bWljaGVsLmRhZW56ZXJA
YW1kLmNvbT4KLS0tCiBhbWRncHUvYW1kZ3B1X2RldmljZS5jIHwgMiArKwogMSBmaWxlIGNoYW5n
ZWQsIDIgaW5zZXJ0aW9ucygrKQoKZGlmZiAtLWdpdCBhL2FtZGdwdS9hbWRncHVfZGV2aWNlLmMg
Yi9hbWRncHUvYW1kZ3B1X2RldmljZS5jCmluZGV4IGQ4MWVmY2Y4Li45ODNiMTlhYiAxMDA2NDQK
LS0tIGEvYW1kZ3B1L2FtZGdwdV9kZXZpY2UuYworKysgYi9hbWRncHUvYW1kZ3B1X2RldmljZS5j
CkBAIC0xMjgsNiArMTI4LDggQEAgc3RhdGljIHZvaWQgYW1kZ3B1X2RldmljZV9mcmVlX2ludGVy
bmFsKGFtZGdwdV9kZXZpY2VfaGFuZGxlIGRldikKIHsKIAlhbWRncHVfdmFtZ3JfZGVpbml0KCZk
ZXYtPnZhbWdyXzMyKTsKIAlhbWRncHVfdmFtZ3JfZGVpbml0KCZkZXYtPnZhbWdyKTsKKwlhbWRn
cHVfdmFtZ3JfZGVpbml0KCZkZXYtPnZhbWdyX2hpZ2hfMzIpOworCWFtZGdwdV92YW1ncl9kZWlu
aXQoJmRldi0+dmFtZ3JfaGlnaCk7CiAJdXRpbF9oYXNoX3RhYmxlX2Rlc3Ryb3koZGV2LT5ib19m
bGlua19uYW1lcyk7CiAJdXRpbF9oYXNoX3RhYmxlX2Rlc3Ryb3koZGV2LT5ib19oYW5kbGVzKTsK
IAlwdGhyZWFkX211dGV4X2Rlc3Ryb3koJmRldi0+Ym9fdGFibGVfbXV0ZXgpOwotLSAKMi4xNy4w
CgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4
IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3Rz
LmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZngK
