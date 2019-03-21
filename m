From: Dan Carpenter <dan.carpenter-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH] drm/amd/powerplay: Off by one in vega20_get_smu_msg_index()
Date: Thu, 21 Mar 2019 12:19:57 +0300
Message-ID: <20190321091957.GA2793@kadam>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
Content-Disposition: inline
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
To: Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org>, Kevin Wang <Kevin1.Wang-5C7GfCeVMHo@public.gmane.org>
Cc: "David (ChunMing) Zhou" <David1.Zhou-5C7GfCeVMHo@public.gmane.org>, Chengming Gui <Jack.Gui-5C7GfCeVMHo@public.gmane.org>, David Airlie <airlied-cv59FeDIM0c@public.gmane.org>, kernel-janitors-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, Huang Rui <ray.huang-5C7GfCeVMHo@public.gmane.org>, Daniel Vetter <daniel-/w4YWyX8dFk@public.gmane.org>, Likun Gao <Likun.Gao-5C7GfCeVMHo@public.gmane.org>, Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig-5C7GfCeVMHo@public.gmane.org>

VGhlID4gc2hvdWxkIGJlID49IHNvIHRoYXQgd2UgZG9uJ3QgcmVhZCBvbmUgZWxlbWVudCBiZXlv
bmQgdGhlIGVuZCBvZgp0aGUgdmVnYTIwX21lc3NhZ2VfbWFwW10gYXJyYXkuCgpGaXhlczogM2Vj
M2M5MzE0ODlmICgiZHJtL2FtZC9wb3dlcnBsYXk6IGltcGxlbWVudCBzbXUgdmVnYTIwX21lc3Nh
Z2VfbWFwIGZvciB2ZWdhMjAiKQpTaWduZWQtb2ZmLWJ5OiBEYW4gQ2FycGVudGVyIDxkYW4uY2Fy
cGVudGVyQG9yYWNsZS5jb20+Ci0tLQogZHJpdmVycy9ncHUvZHJtL2FtZC9wb3dlcnBsYXkvdmVn
YTIwX3BwdC5jIHwgMyArKy0KIDEgZmlsZSBjaGFuZ2VkLCAyIGluc2VydGlvbnMoKyksIDEgZGVs
ZXRpb24oLSkKCmRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL3Bvd2VycGxheS92ZWdh
MjBfcHB0LmMgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL3Bvd2VycGxheS92ZWdhMjBfcHB0LmMKaW5k
ZXggN2U5ZThhZDlhMzAwLi4zMWNkN2I5ZDRkYWQgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvZ3B1L2Ry
bS9hbWQvcG93ZXJwbGF5L3ZlZ2EyMF9wcHQuYworKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL3Bv
d2VycGxheS92ZWdhMjBfcHB0LmMKQEAgLTEzMiw3ICsxMzIsOCBAQCBzdGF0aWMgaW50IHZlZ2Ey
MF9tZXNzYWdlX21hcFtTTVVfTVNHX01BWF9DT1VOVF0gPSB7CiBzdGF0aWMgaW50IHZlZ2EyMF9n
ZXRfc211X21zZ19pbmRleChzdHJ1Y3Qgc211X2NvbnRleHQgKnNtYywgdWludDMyX3QgaW5kZXgp
CiB7CiAJaW50IHZhbDsKLQlpZiAoaW5kZXggPiBTTVVfTVNHX01BWF9DT1VOVCkKKworCWlmIChp
bmRleCA+PSBTTVVfTVNHX01BWF9DT1VOVCkKIAkJcmV0dXJuIC1FSU5WQUw7CiAKIAl2YWwgPSB2
ZWdhMjBfbWVzc2FnZV9tYXBbaW5kZXhdOwotLSAKMi4xNy4xCgpfX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4
QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWls
bWFuL2xpc3RpbmZvL2FtZC1nZng=
