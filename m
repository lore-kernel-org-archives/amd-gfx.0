From: Alex Deucher <alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH 030/102] drm/amdgpu: skip pasid mapping for second mmhub on
 Arcturus
Date: Mon, 15 Jul 2019 16:23:25 -0500
Message-ID: <20190715212437.31793-28-alexander.deucher@amd.com>
References: <20190715212437.31793-1-alexander.deucher@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <20190715212437.31793-1-alexander.deucher-5C7GfCeVMHo@public.gmane.org>
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
Cc: Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org>, Le Ma <le.ma-5C7GfCeVMHo@public.gmane.org>, Feifei Xu <Feifei.Xu-5C7GfCeVMHo@public.gmane.org>

RnJvbTogTGUgTWEgPGxlLm1hQGFtZC5jb20+CgpUaGVyZSdzIG5vIExVVCByZWdpc3RlciBmb3Ig
c2Vjb25kIG1taHViIHRvIGNvbnZlcnQgcGFzaWQgc2luY2UgaXQgaGFzIG5vIEFUQy4KClNpZ25l
ZC1vZmYtYnk6IExlIE1hIDxsZS5tYUBhbWQuY29tPgpSZXZpZXdlZC1ieTogRmVpZmVpIFh1IDxG
ZWlmZWkuWHVAYW1kLmNvbT4KU2lnbmVkLW9mZi1ieTogQWxleCBEZXVjaGVyIDxhbGV4YW5kZXIu
ZGV1Y2hlckBhbWQuY29tPgotLS0KIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2dtY192OV8w
LmMgfCA0ICsrKysKIDEgZmlsZSBjaGFuZ2VkLCA0IGluc2VydGlvbnMoKykKCmRpZmYgLS1naXQg
YS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9nbWNfdjlfMC5jIGIvZHJpdmVycy9ncHUvZHJt
L2FtZC9hbWRncHUvZ21jX3Y5XzAuYwppbmRleCBkNmFhMjkwZDU2N2MuLjExOTY4ZmJlMGQ2MCAx
MDA2NDQKLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvZ21jX3Y5XzAuYworKysgYi9k
cml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9nbWNfdjlfMC5jCkBAIC00ODgsNiArNDg4LDEwIEBA
IHN0YXRpYyB2b2lkIGdtY192OV8wX2VtaXRfcGFzaWRfbWFwcGluZyhzdHJ1Y3QgYW1kZ3B1X3Jp
bmcgKnJpbmcsIHVuc2lnbmVkIHZtaWQsCiAJc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYgPSBy
aW5nLT5hZGV2OwogCXVpbnQzMl90IHJlZzsKIAorCS8qIERvIG5vdGhpbmcgYmVjYXVzZSB0aGVy
ZSdzIG5vIGx1dCByZWdpc3RlciBmb3IgbW1odWIxLiAqLworCWlmIChyaW5nLT5mdW5jcy0+dm1o
dWIgPT0gQU1ER1BVX01NSFVCXzEpCisJCXJldHVybjsKKwogCWlmIChyaW5nLT5mdW5jcy0+dm1o
dWIgPT0gQU1ER1BVX0dGWEhVQl8wKQogCQlyZWcgPSBTT0MxNV9SRUdfT0ZGU0VUKE9TU1NZUywg
MCwgbW1JSF9WTUlEXzBfTFVUKSArIHZtaWQ7CiAJZWxzZQotLSAKMi4yMC4xCgpfX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlz
dAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9w
Lm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZng=
