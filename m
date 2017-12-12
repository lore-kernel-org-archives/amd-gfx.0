From: Andrey Grodzovsky <andrey.grodzovsky-5C7GfCeVMHo@public.gmane.org>
Subject: [PATCH libdrm] amdgpu: Remove dummy CU_ASSERT_EQUAL.
Date: Tue, 12 Dec 2017 08:36:53 -0500
Message-ID: <1513085813-2836-1-git-send-email-andrey.grodzovsky@amd.com>
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
To: dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Cc: Andrey Grodzovsky <andrey.grodzovsky-5C7GfCeVMHo@public.gmane.org>, Alvin.Huan-5C7GfCeVMHo@public.gmane.org, amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, Anna.Jin-5C7GfCeVMHo@public.gmane.org, Qiang.Yu-5C7GfCeVMHo@public.gmane.org, Le.Ma-5C7GfCeVMHo@public.gmane.org

Rml4ZXMgdGVzdCBmYWlsdXJlIG9uIHJoZWwuCgpTaWduZWQtb2ZmLWJ5OiBBbmRyZXkgR3JvZHpv
dnNreSA8YW5kcmV5Lmdyb2R6b3Zza3lAYW1kLmNvbT4KLS0tCiB0ZXN0cy9hbWRncHUvYmFzaWNf
dGVzdHMuYyB8IDIgLS0KIDEgZmlsZSBjaGFuZ2VkLCAyIGRlbGV0aW9ucygtKQoKZGlmZiAtLWdp
dCBhL3Rlc3RzL2FtZGdwdS9iYXNpY190ZXN0cy5jIGIvdGVzdHMvYW1kZ3B1L2Jhc2ljX3Rlc3Rz
LmMKaW5kZXggYTc4Y2Y1Mi4uNDc0YTY3OSAxMDA2NDQKLS0tIGEvdGVzdHMvYW1kZ3B1L2Jhc2lj
X3Rlc3RzLmMKKysrIGIvdGVzdHMvYW1kZ3B1L2Jhc2ljX3Rlc3RzLmMKQEAgLTE0NTksOCArMTQ1
OSw2IEBAIHN0YXRpYyB2b2lkIGFtZGdwdV9zeW5jX2RlcGVuZGVuY3lfdGVzdCh2b2lkKQogCXN0
YXRpYyB1aW50MzJfdCAqcHRyOwogCXVpbnQ2NF90IHNlcV9ubzsKIAotCUNVX0FTU0VSVF9FUVVB
TChyLCAwKTsKLQogCXIgPSBhbWRncHVfY3NfY3R4X2NyZWF0ZShkZXZpY2VfaGFuZGxlLCAmY29u
dGV4dF9oYW5kbGVbMF0pOwogCUNVX0FTU0VSVF9FUVVBTChyLCAwKTsKIAlyID0gYW1kZ3B1X2Nz
X2N0eF9jcmVhdGUoZGV2aWNlX2hhbmRsZSwgJmNvbnRleHRfaGFuZGxlWzFdKTsKLS0gCjIuNy40
CgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4
IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3Rz
LmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZngK
