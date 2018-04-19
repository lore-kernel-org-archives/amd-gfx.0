From: Rex Zhu <Rex.Zhu-5C7GfCeVMHo@public.gmane.org>
Subject: [PATCH] drm/amd/pp: Fix NULL point check error in
 smu_set_watermarks_for_clocks_ranges
Date: Thu, 19 Apr 2018 12:43:26 +0800
Message-ID: <1524113006-23510-1-git-send-email-Rex.Zhu@amd.com>
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

U2lnbmVkLW9mZi1ieTogUmV4IFpodSA8UmV4LlpodUBhbWQuY29tPgotLS0KIGRyaXZlcnMvZ3B1
L2RybS9hbWQvcG93ZXJwbGF5L2h3bWdyL3NtdV9oZWxwZXIuYyB8IDIgKy0KIDEgZmlsZSBjaGFu
Z2VkLCAxIGluc2VydGlvbigrKSwgMSBkZWxldGlvbigtKQoKZGlmZiAtLWdpdCBhL2RyaXZlcnMv
Z3B1L2RybS9hbWQvcG93ZXJwbGF5L2h3bWdyL3NtdV9oZWxwZXIuYyBiL2RyaXZlcnMvZ3B1L2Ry
bS9hbWQvcG93ZXJwbGF5L2h3bWdyL3NtdV9oZWxwZXIuYwppbmRleCA3YzIzNzQxLi45M2EzZDAy
IDEwMDY0NAotLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL3Bvd2VycGxheS9od21nci9zbXVfaGVs
cGVyLmMKKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9wb3dlcnBsYXkvaHdtZ3Ivc211X2hlbHBl
ci5jCkBAIC02NTcsNyArNjU3LDcgQEAgaW50IHNtdV9zZXRfd2F0ZXJtYXJrc19mb3JfY2xvY2tz
X3Jhbmdlcyh2b2lkICp3dF90YWJsZSwKIAl1aW50MzJfdCBpOwogCXN0cnVjdCB3YXRlcm1hcmtz
ICp0YWJsZSA9IHd0X3RhYmxlOwogCi0JaWYgKCF0YWJsZSB8fCB3bV93aXRoX2Nsb2NrX3Jhbmdl
cykKKwlpZiAoIXRhYmxlIHx8ICF3bV93aXRoX2Nsb2NrX3JhbmdlcykKIAkJcmV0dXJuIC1FSU5W
QUw7CiAKIAlpZiAod21fd2l0aF9jbG9ja19yYW5nZXMtPm51bV93bV9zZXRzX2RtaWYgPiA0IHx8
IHdtX3dpdGhfY2xvY2tfcmFuZ2VzLT5udW1fd21fc2V0c19tY2lmID4gNCkKLS0gCjEuOS4xCgpf
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1h
aWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZy
ZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZngK
