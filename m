From: Huang Rui <ray.huang-5C7GfCeVMHo@public.gmane.org>
Subject: [PATCH 03/14] drm/amdgpu/si: add SI smc firmware versions for sysfs
 dump
Date: Tue, 30 Aug 2016 19:50:00 +0800
Message-ID: <1472557811-8015-4-git-send-email-ray.huang@amd.com>
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

Q2hhbmdlLUlkOiBJNzk1M2Y4ZTJiMDcyMmQ1ZWQwMjA5YTgxNzE0MThjYTc2NDRkZTJlZQpTaWdu
ZWQtb2ZmLWJ5OiBIdWFuZyBSdWkgPHJheS5odWFuZ0BhbWQuY29tPgotLS0KIGRyaXZlcnMvZ3B1
L2RybS9hbWQvYW1kZ3B1L3NpX3NtYy5jIHwgMSArCiAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRp
b24oKykKCmRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9zaV9zbWMuYyBi
L2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L3NpX3NtYy5jCmluZGV4IDIxNGYzN2MuLmMxYzI1
OTQgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L3NpX3NtYy5jCisrKyBi
L2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L3NpX3NtYy5jCkBAIC0yMjQsNiArMjI0LDcgQEAg
aW50IHNpX2xvYWRfc21jX3Vjb2RlKHN0cnVjdCBhbWRncHVfZGV2aWNlICphZGV2LCB1MzIgbGlt
aXQpCiAKIAlhbWRncHVfdWNvZGVfcHJpbnRfc21jX2hkcigmaGRyLT5oZWFkZXIpOwogCisJYWRl
di0+cG0uZndfdmVyc2lvbiA9IGxlMzJfdG9fY3B1KGhkci0+aGVhZGVyLnVjb2RlX3ZlcnNpb24p
OwogCXVjb2RlX3N0YXJ0X2FkZHJlc3MgPSBsZTMyX3RvX2NwdShoZHItPnVjb2RlX3N0YXJ0X2Fk
ZHIpOwogCXVjb2RlX3NpemUgPSBsZTMyX3RvX2NwdShoZHItPmhlYWRlci51Y29kZV9zaXplX2J5
dGVzKTsKIAlzcmMgPSAoY29uc3QgdTggKikKLS0gCjIuNy40CgpfX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4
QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWls
bWFuL2xpc3RpbmZvL2FtZC1nZngK
