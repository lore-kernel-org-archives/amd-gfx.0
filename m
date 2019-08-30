From: Jean Delvare <jdelvare-l3A5Bk7waGM@public.gmane.org>
Subject: [PATCH 3/3] drm/edid: no CEA extension is not an error
Date: Fri, 30 Aug 2019 18:16:52 +0200
Message-ID: <20190830181652.5b58727b@endymion>
References: <20190830181423.4f31a28f@endymion>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <20190830181423.4f31a28f@endymion>
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
To: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Cc: "David (ChunMing) Zhou" <David1.Zhou-5C7GfCeVMHo@public.gmane.org>, Maxime Ripard <maxime.ripard-LDxbnhwyfcJBDgjK7y7TUQ@public.gmane.org>, David Airlie <airlied-cv59FeDIM0c@public.gmane.org>, Sean Paul <sean-p7yTbzM4H96eqtR555YLDQ@public.gmane.org>, Maarten Lankhorst <maarten.lankhorst-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, Leo Li <sunpeng.li-5C7GfCeVMHo@public.gmane.org>, Daniel Vetter <daniel-/w4YWyX8dFk@public.gmane.org>, Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org>, Harry Wentland <harry.wentland-5C7GfCeVMHo@public.gmane.org>, Christian =?UTF-8?B?S8O2?= =?UTF-8?B?bmln?= <christian.koenig-5C7GfCeVMHo@public.gmane.org>

SXQgaXMgZmluZSBmb3IgZGlzcGxheXMgd2l0aG91dCBhdWRpbyBmdW5jdGlvbmFsaXR5IHRvIG5v
dCBpbXBsZW1lbnQKQ0VBIGV4dGVuc2lvbiBpbiB0aGVpciBFRElELiBEbyBub3QgcmV0dXJuIGFu
IGVycm9yIGluIHRoYXQgY2FzZSwKaW5zdGVhZCByZXR1cm4gMCBhcyBpZiB0aGVyZSB3YXMgYSBD
RUEgZXh0ZW5zaW9uIHdpdGggbm8gYXVkaW8gb3IKc3BlYWtlciBibG9jay4KClRoaXMgZml4ZXMg
aGFsZiBvZiBidWcgZmRvIzEwNzgyNToKaHR0cHM6Ly9idWdzLmZyZWVkZXNrdG9wLm9yZy9zaG93
X2J1Zy5jZ2k/aWQ9MTA3ODI1CgpTaWduZWQtb2ZmLWJ5OiBKZWFuIERlbHZhcmUgPGpkZWx2YXJl
QHN1c2UuZGU+CkNjOiBNYWFydGVuIExhbmtob3JzdCA8bWFhcnRlbi5sYW5raG9yc3RAbGludXgu
aW50ZWwuY29tPgpDYzogTWF4aW1lIFJpcGFyZCA8bWF4aW1lLnJpcGFyZEBib290bGluLmNvbT4K
Q2M6IFNlYW4gUGF1bCA8c2VhbkBwb29ybHkucnVuPgpDYzogRGF2aWQgQWlybGllIDxhaXJsaWVk
QGxpbnV4LmllPgpDYzogRGFuaWVsIFZldHRlciA8ZGFuaWVsQGZmd2xsLmNoPgotLS0KIGRyaXZl
cnMvZ3B1L2RybS9kcm1fZWRpZC5jIHwgICAgNCArKy0tCiAxIGZpbGUgY2hhbmdlZCwgMiBpbnNl
cnRpb25zKCspLCAyIGRlbGV0aW9ucygtKQoKLS0tIGxpbnV4LTUuMi5vcmlnL2RyaXZlcnMvZ3B1
L2RybS9kcm1fZWRpZC5jCTIwMTktMDgtMzAgMTc6NTc6MzguMTk5OTkwOTk1ICswMjAwCisrKyBs
aW51eC01LjIvZHJpdmVycy9ncHUvZHJtL2RybV9lZGlkLmMJMjAxOS0wOC0zMCAxODowNDozNi44
NDAzMzM4MzQgKzAyMDAKQEAgLTQxMzAsNyArNDEzMCw3IEBAIGludCBkcm1fZWRpZF90b19zYWQo
c3RydWN0IGVkaWQgKmVkaWQsIHMKIAljZWEgPSBkcm1fZmluZF9jZWFfZXh0ZW5zaW9uKGVkaWQp
OwogCWlmICghY2VhKSB7CiAJCURSTV9ERUJVR19LTVMoIlNBRDogbm8gQ0VBIEV4dGVuc2lvbiBm
b3VuZFxuIik7Ci0JCXJldHVybiAtRU5PRU5UOworCQlyZXR1cm4gMDsKIAl9CiAKIAlpZiAoY2Vh
X3JldmlzaW9uKGNlYSkgPCAzKSB7CkBAIC00MTkxLDcgKzQxOTEsNyBAQCBpbnQgZHJtX2VkaWRf
dG9fc3BlYWtlcl9hbGxvY2F0aW9uKHN0cnVjCiAJY2VhID0gZHJtX2ZpbmRfY2VhX2V4dGVuc2lv
bihlZGlkKTsKIAlpZiAoIWNlYSkgewogCQlEUk1fREVCVUdfS01TKCJTQUQ6IG5vIENFQSBFeHRl
bnNpb24gZm91bmRcbiIpOwotCQlyZXR1cm4gLUVOT0VOVDsKKwkJcmV0dXJuIDA7CiAJfQogCiAJ
aWYgKGNlYV9yZXZpc2lvbihjZWEpIDwgMykgewoKLS0gCkplYW4gRGVsdmFyZQpTVVNFIEwzIFN1
cHBvcnQKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1k
LWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9s
aXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4
