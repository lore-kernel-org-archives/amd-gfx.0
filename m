From: Junwei Zhang <Jerry.Zhang-5C7GfCeVMHo@public.gmane.org>
Subject: [PATCH libdrm 2/2] [RFC] amdgpu: do not free flink bo for flink_fd
Date: Fri, 10 Aug 2018 12:59:11 +0800
Message-ID: <1533877151-20165-2-git-send-email-Jerry.Zhang@amd.com>
References: <1533877151-20165-1-git-send-email-Jerry.Zhang@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <1533877151-20165-1-git-send-email-Jerry.Zhang-5C7GfCeVMHo@public.gmane.org>
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
Cc: Junwei Zhang <Jerry.Zhang-5C7GfCeVMHo@public.gmane.org>, christian.koenig-5C7GfCeVMHo@public.gmane.org

dGhlIGZsaW5rIGJvIGlzIHVzZWQgdG8gZXhwb3J0CgpTaWduZWQtb2ZmLWJ5OiBKdW53ZWkgWmhh
bmcgPEplcnJ5LlpoYW5nQGFtZC5jb20+Ci0tLQogYW1kZ3B1L2FtZGdwdV9iby5jIHwgNiAtLS0t
LS0KIDEgZmlsZSBjaGFuZ2VkLCA2IGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL2FtZGdwdS9h
bWRncHVfYm8uYyBiL2FtZGdwdS9hbWRncHVfYm8uYwppbmRleCAyOTQ3NzE1Li4wZDBjNzNiIDEw
MDY0NAotLS0gYS9hbWRncHUvYW1kZ3B1X2JvLmMKKysrIGIvYW1kZ3B1L2FtZGdwdV9iby5jCkBA
IC0yMTksMTIgKzIxOSw2IEBAIHN0YXRpYyBpbnQgYW1kZ3B1X2JvX2V4cG9ydF9mbGluayhhbWRn
cHVfYm9faGFuZGxlIGJvKQogCiAJYm8tPmZsaW5rX25hbWUgPSBmbGluay5uYW1lOwogCi0JaWYg
KGJvLT5kZXYtPmZsaW5rX2ZkICE9IGJvLT5kZXYtPmZkKSB7Ci0JCXN0cnVjdCBkcm1fZ2VtX2Ns
b3NlIGFyZ3MgPSB7fTsKLQkJYXJncy5oYW5kbGUgPSBoYW5kbGU7Ci0JCWRybUlvY3RsKGJvLT5k
ZXYtPmZsaW5rX2ZkLCBEUk1fSU9DVExfR0VNX0NMT1NFLCAmYXJncyk7Ci0JfQotCiAJcHRocmVh
ZF9tdXRleF9sb2NrKCZiby0+ZGV2LT5ib190YWJsZV9tdXRleCk7CiAJciA9IGhhbmRsZV90YWJs
ZV9pbnNlcnQoJmJvLT5kZXYtPmJvX2ZsaW5rX25hbWVzLCBiby0+ZmxpbmtfbmFtZSwgYm8pOwog
CXB0aHJlYWRfbXV0ZXhfdW5sb2NrKCZiby0+ZGV2LT5ib190YWJsZV9tdXRleCk7Ci0tIAoxLjku
MQoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdm
eCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0
cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==
