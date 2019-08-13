From: "Zhao, Yong" <Yong.Zhao-5C7GfCeVMHo@public.gmane.org>
Subject: [PATCH] drm/amdkfd: Fill amdgpu_task_info for KFD VMs
Date: Tue, 13 Aug 2019 19:20:19 +0000
Message-ID: <20190813192007.15881-1-Yong.Zhao@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
Content-Language: en-US
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
To: "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
Cc: "Zhao, Yong" <Yong.Zhao-5C7GfCeVMHo@public.gmane.org>

VGhlIGFtZGdwdV90YXNrX2luZm8gd2lsbCBiZSB1c2VkIHdoZW4gcHJpbnRpbmcgVk0gcGFnZSBm
YXVsdCBmb3IgS0ZECnByb2Nlc3Nlcy4KCkNoYW5nZS1JZDogSWZkOTgzZGI1ZGNlYjFkNDc3ZTcy
ODdlNDg5M2Y4MDU2NWE3YTZiMDYKU2lnbmVkLW9mZi1ieTogWW9uZyBaaGFvIDxZb25nLlpoYW9A
YW1kLmNvbT4KLS0tCiBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGtmZC9rZmRfcHJvY2Vzcy5jIHwg
MiArKwogMSBmaWxlIGNoYW5nZWQsIDIgaW5zZXJ0aW9ucygrKQoKZGlmZiAtLWdpdCBhL2RyaXZl
cnMvZ3B1L2RybS9hbWQvYW1ka2ZkL2tmZF9wcm9jZXNzLmMgYi9kcml2ZXJzL2dwdS9kcm0vYW1k
L2FtZGtmZC9rZmRfcHJvY2Vzcy5jCmluZGV4IDhmMTA3NmMwYzg4YS4uMmVjNDI3NDlmOTcxIDEw
MDY0NAotLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGtmZC9rZmRfcHJvY2Vzcy5jCisrKyBi
L2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1ka2ZkL2tmZF9wcm9jZXNzLmMKQEAgLTgwMSw2ICs4MDEs
OCBAQCBpbnQga2ZkX3Byb2Nlc3NfZGV2aWNlX2luaXRfdm0oc3RydWN0IGtmZF9wcm9jZXNzX2Rl
dmljZSAqcGRkLAogCQlyZXR1cm4gcmV0OwogCX0KIAorCWFtZGdwdV92bV9zZXRfdGFza19pbmZv
KHBkZC0+dm0pOworCiAJcmV0ID0ga2ZkX3Byb2Nlc3NfZGV2aWNlX3Jlc2VydmVfaWJfbWVtKHBk
ZCk7CiAJaWYgKHJldCkKIAkJZ290byBlcnJfcmVzZXJ2ZV9pYl9tZW07Ci0tIAoyLjE3LjEKCl9f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFp
bGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJl
ZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeA==
