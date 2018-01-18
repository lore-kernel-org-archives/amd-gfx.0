From: Harry Wentland <harry.wentland-5C7GfCeVMHo@public.gmane.org>
Subject: [PATCH 03/24] drm/amd/display: Remove unused param in DML
Date: Thu, 18 Jan 2018 16:03:32 -0500
Message-ID: <20180118210353.18842-4-harry.wentland@amd.com>
References: <20180118210353.18842-1-harry.wentland@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <20180118210353.18842-1-harry.wentland-5C7GfCeVMHo@public.gmane.org>
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
Cc: Ken Chalmers <ken.chalmers-5C7GfCeVMHo@public.gmane.org>

RnJvbTogS2VuIENoYWxtZXJzIDxrZW4uY2hhbG1lcnNAYW1kLmNvbT4KClNpZ25lZC1vZmYtYnk6
IEtlbiBDaGFsbWVycyA8a2VuLmNoYWxtZXJzQGFtZC5jb20+Ci0tLQogZHJpdmVycy9ncHUvZHJt
L2FtZC9kaXNwbGF5L2RjL2RtbC9kaXNwbGF5X21vZGVfc3RydWN0cy5oIHwgMSAtCiAxIGZpbGUg
Y2hhbmdlZCwgMSBkZWxldGlvbigtKQoKZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQv
ZGlzcGxheS9kYy9kbWwvZGlzcGxheV9tb2RlX3N0cnVjdHMuaCBiL2RyaXZlcnMvZ3B1L2RybS9h
bWQvZGlzcGxheS9kYy9kbWwvZGlzcGxheV9tb2RlX3N0cnVjdHMuaAppbmRleCBhZWViZDhiZWU2
MjguLjA5YWZmYTE2Y2M0MyAxMDA2NDQKLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5
L2RjL2RtbC9kaXNwbGF5X21vZGVfc3RydWN0cy5oCisrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQv
ZGlzcGxheS9kYy9kbWwvZGlzcGxheV9tb2RlX3N0cnVjdHMuaApAQCAtMTQwLDcgKzE0MCw2IEBA
IHN0cnVjdAlfdmNzX2RwaV9pcF9wYXJhbXNfc3QJewogCXVuc2lnbmVkIGludAltYXhfaHNjbF90
YXBzOwogCXVuc2lnbmVkIGludAltYXhfdnNjbF90YXBzOwogCXVuc2lnbmVkIGludAl4ZmNfc3Vw
cG9ydGVkOwotCXVuc2lnbmVkIGludAlwdG9pX3N1cHBvcnRlZDsKIAl1bnNpZ25lZCBpbnQJeGZj
X2ZpbGxfY29uc3RhbnRfYnl0ZXM7CiAJZG91YmxlCWRpc3BjbGtfcmFtcF9tYXJnaW5fcGVyY2Vu
dDsKIAlkb3VibGUJeGZjX2ZpbGxfYndfb3ZlcmhlYWRfcGVyY2VudDsKLS0gCjIuMTQuMQoKX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWls
aW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVl
ZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==
