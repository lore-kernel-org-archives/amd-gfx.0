From: Evan Quan <evan.quan-5C7GfCeVMHo@public.gmane.org>
Subject: [PATCH 4/4] drm/amdgpu: enable Vega20 page queue support
Date: Wed, 12 Dec 2018 14:54:02 +0800
Message-ID: <20181212065402.12021-4-evan.quan@amd.com>
References: <20181212065402.12021-1-evan.quan@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <20181212065402.12021-1-evan.quan-5C7GfCeVMHo@public.gmane.org>
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
Cc: Evan Quan <evan.quan-5C7GfCeVMHo@public.gmane.org>

UGFnZSBxdWV1ZSBpcyBzdXBwb3J0ZWQgb24gVmVnYTIwIHdpdGggU0RNQSBmaXJtd2FyZQoxMjIg
b253YXJkcy4KCkNoYW5nZS1JZDogSTc4ZDJjNGE3YWQ5ZDIwMGQ4OTE3N2ZhZTJhZDYwNzM5NTVl
NmJkOGIKU2lnbmVkLW9mZi1ieTogRXZhbiBRdWFuIDxldmFuLnF1YW5AYW1kLmNvbT4KLS0tCiBk
cml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9zZG1hX3Y0XzAuYyB8IDMgKy0tCiAxIGZpbGUgY2hh
bmdlZCwgMSBpbnNlcnRpb24oKyksIDIgZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvZHJpdmVy
cy9ncHUvZHJtL2FtZC9hbWRncHUvc2RtYV92NF8wLmMgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2Ft
ZGdwdS9zZG1hX3Y0XzAuYwppbmRleCBkNTlhZGRiNDcwMjUuLjU2YzU4M2U4YTRjMiAxMDA2NDQK
LS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvc2RtYV92NF8wLmMKKysrIGIvZHJpdmVy
cy9ncHUvZHJtL2FtZC9hbWRncHUvc2RtYV92NF8wLmMKQEAgLTE0NTgsOCArMTQ1OCw3IEBAIHN0
YXRpYyBib29sIHNkbWFfdjRfMF9md19zdXBwb3J0X3BhZ2luZ19xdWV1ZShzdHJ1Y3QgYW1kZ3B1
X2RldmljZSAqYWRldikKIAkJLypyZXR1cm4gZndfdmVyc2lvbiA+PSAzMTsqLwogCQlyZXR1cm4g
ZmFsc2U7CiAJY2FzZSBDSElQX1ZFR0EyMDoKLQkJLypyZXR1cm4gZndfdmVyc2lvbiA+PSAxMTU7
Ki8KLQkJcmV0dXJuIGZhbHNlOworCQlyZXR1cm4gZndfdmVyc2lvbiA+PSAxMjI7CiAJZGVmYXVs
dDoKIAkJcmV0dXJuIGZhbHNlOwogCX0KLS0gCjIuMTkuMgoKX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBs
aXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1h
bi9saXN0aW5mby9hbWQtZ2Z4Cg==
