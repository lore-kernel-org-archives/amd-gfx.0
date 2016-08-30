From: Huang Rui <ray.huang-5C7GfCeVMHo@public.gmane.org>
Subject: [PATCH 02/14] drm/amdgpu: add gmc v6 firmware versions for sysfs dump
Date: Tue, 30 Aug 2016 19:49:59 +0800
Message-ID: <1472557811-8015-3-git-send-email-ray.huang@amd.com>
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

Q2hhbmdlLUlkOiBJMzMyNjliZTVmYjZlODc3ZTBiODVlMTY4YWE3ZTEyMmU5ZDE5NzcyMQpTaWdu
ZWQtb2ZmLWJ5OiBIdWFuZyBSdWkgPHJheS5odWFuZ0BhbWQuY29tPgotLS0KIGRyaXZlcnMvZ3B1
L2RybS9hbWQvYW1kZ3B1L2dtY192Nl8wLmMgfCAyICsrCiAxIGZpbGUgY2hhbmdlZCwgMiBpbnNl
cnRpb25zKCspCgpkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvZ21jX3Y2
XzAuYyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2dtY192Nl8wLmMKaW5kZXggYzE4YTRl
Zi4uMWQyOTUyYiAxMDA2NDQKLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvZ21jX3Y2
XzAuYworKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9nbWNfdjZfMC5jCkBAIC0xNDks
NiArMTQ5LDggQEAgc3RhdGljIGludCBnbWNfdjZfMF9tY19sb2FkX21pY3JvY29kZShzdHJ1Y3Qg
YW1kZ3B1X2RldmljZSAqYWRldikKIAloZHIgPSAoY29uc3Qgc3RydWN0IG1jX2Zpcm13YXJlX2hl
YWRlcl92MV8wICopYWRldi0+bWMuZnctPmRhdGE7CiAKIAlhbWRncHVfdWNvZGVfcHJpbnRfbWNf
aGRyKCZoZHItPmhlYWRlcik7CisKKwlhZGV2LT5tYy5md192ZXJzaW9uID0gbGUzMl90b19jcHUo
aGRyLT5oZWFkZXIudWNvZGVfdmVyc2lvbik7CiAJcmVnc19zaXplID0gbGUzMl90b19jcHUoaGRy
LT5pb19kZWJ1Z19zaXplX2J5dGVzKSAvICg0ICogMik7CiAJbmV3X2lvX21jX3JlZ3MgPSAoY29u
c3QgX19sZTMyICopCiAJCShhZGV2LT5tYy5mdy0+ZGF0YSArIGxlMzJfdG9fY3B1KGhkci0+aW9f
ZGVidWdfYXJyYXlfb2Zmc2V0X2J5dGVzKSk7Ci0tIAoyLjcuNAoKX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdm
eEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFp
bG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==
