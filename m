From: Huang Rui <ray.huang-5C7GfCeVMHo@public.gmane.org>
Subject: [PATCH 13/14] drm/amdgpu: fix incorrect reading method at
 si_get_current_pcie_speed
Date: Tue, 30 Aug 2016 19:50:10 +0800
Message-ID: <1472557811-8015-14-git-send-email-ray.huang@amd.com>
References: <1472557811-8015-1-git-send-email-ray.huang@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <1472557811-8015-1-git-send-email-ray.huang-5C7GfCeVMHo@public.gmane.org>
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
To: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org>
Cc: Ken Wang <Qingqing.Wang-5C7GfCeVMHo@public.gmane.org>, Hui Yu <Hui.Yu-5C7GfCeVMHo@public.gmane.org>, Huang Rui <ray.huang-5C7GfCeVMHo@public.gmane.org>, Alvin Huan <Alvin.Huan-5C7GfCeVMHo@public.gmane.org>

Q2hhbmdlLUlkOiBJNzM3OWQwNzNjMGU4MTIzNDQ0ZGVlZDlhOTE1NjRkZTE3YjNmYjcyMgpTaWdu
ZWQtb2ZmLWJ5OiBIdWFuZyBSdWkgPHJheS5odWFuZ0BhbWQuY29tPgotLS0KIGRyaXZlcnMvZ3B1
L2RybS9hbWQvYW1kZ3B1L3NpX2RwbS5jIHwgMiArLQogMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0
aW9uKCspLCAxIGRlbGV0aW9uKC0pCgpkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9h
bWRncHUvc2lfZHBtLmMgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9zaV9kcG0uYwppbmRl
eCBjZTU2M2NiLi45YjdkNGJmIDEwMDY0NAotLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdw
dS9zaV9kcG0uYworKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9zaV9kcG0uYwpAQCAt
NjI0Miw3ICs2MjQyLDcgQEAgc3RhdGljIHUxNiBzaV9nZXRfY3VycmVudF9wY2llX3NwZWVkKHN0
cnVjdCBhbWRncHVfZGV2aWNlICphZGV2KQogewogCXUzMiBzcGVlZF9jbnRsOwogCi0Jc3BlZWRf
Y250bCA9IFJSRUczMl9QQ0lFKFBDSUVfTENfU1BFRURfQ05UTCkgJiBMQ19DVVJSRU5UX0RBVEFf
UkFURV9NQVNLOworCXNwZWVkX2NudGwgPSBSUkVHMzJfUENJRV9QT1JUKFBDSUVfTENfU1BFRURf
Q05UTCkgJiBMQ19DVVJSRU5UX0RBVEFfUkFURV9NQVNLOwogCXNwZWVkX2NudGwgPj49IExDX0NV
UlJFTlRfREFUQV9SQVRFX1NISUZUOwogCiAJcmV0dXJuICh1MTYpc3BlZWRfY250bDsKLS0gCjIu
Ny40CgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwphbWQt
Z2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xp
c3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZngK
