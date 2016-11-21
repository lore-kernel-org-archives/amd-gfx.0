From: Harry Wentland <harry.wentland-5C7GfCeVMHo@public.gmane.org>
Subject: [PATCH 20/76] drm/amd/dal: rotation and mirror support
Date: Mon, 21 Nov 2016 18:00:40 -0500
Message-ID: <20161121230136.5208-21-harry.wentland@amd.com>
References: <20161121230136.5208-1-harry.wentland@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <20161121230136.5208-1-harry.wentland-5C7GfCeVMHo@public.gmane.org>
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
Cc: Vitaly Prosyak <vitaly.prosyak-5C7GfCeVMHo@public.gmane.org>

RnJvbTogVml0YWx5IFByb3N5YWsgPHZpdGFseS5wcm9zeWFrQGFtZC5jb20+CgpGaXggcm90YXRp
b24gOTAgYW5kIDI3MC4KClNpZ25lZC1vZmYtYnk6IFZpdGFseSBQcm9zeWFrIDx2aXRhbHkucHJv
c3lha0BhbWQuY29tPgpBY2tlZC1ieTogSGFycnkgV2VudGxhbmQgPGhhcnJ5LndlbnRsYW5kQGFt
ZC5jb20+Ci0tLQogZHJpdmVycy9ncHUvZHJtL2FtZC9kYWwvZGMvY29yZS9kY19yZXNvdXJjZS5j
IHwgNSAtLS0tLQogMSBmaWxlIGNoYW5nZWQsIDUgZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEv
ZHJpdmVycy9ncHUvZHJtL2FtZC9kYWwvZGMvY29yZS9kY19yZXNvdXJjZS5jIGIvZHJpdmVycy9n
cHUvZHJtL2FtZC9kYWwvZGMvY29yZS9kY19yZXNvdXJjZS5jCmluZGV4IDI3NjgzMzg0N2M0ZC4u
MGMwMjg5NGNlZjI2IDEwMDY0NAotLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2RhbC9kYy9jb3Jl
L2RjX3Jlc291cmNlLmMKKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9kYWwvZGMvY29yZS9kY19y
ZXNvdXJjZS5jCkBAIC00NDQsMTEgKzQ0NCw2IEBAIHN0YXRpYyB2b2lkIGNhbGN1bGF0ZV9yZWNv
dXQoCiAJc3RydWN0IGNvcmVfc3RyZWFtICpzdHJlYW0gPSBwaXBlX2N0eC0+c3RyZWFtOwogCXN0
cnVjdCByZWN0IGNsaXAgPSBzdXJmYWNlLT5jbGlwX3JlY3Q7CiAKLQlpZiAoc3VyZmFjZS0+cm90
YXRpb24gPT0gUk9UQVRJT05fQU5HTEVfOTAgfHwKLQkJCXN1cmZhY2UtPnJvdGF0aW9uID09IFJP
VEFUSU9OX0FOR0xFXzI3MCl7Ci0JCXJlY3Rfc3dhcF9oZWxwZXIoJmNsaXApOwotCX0KLQogCXBp
cGVfY3R4LT5zY2xfZGF0YS5yZWNvdXQueCA9IHN0cmVhbS0+cHVibGljLmRzdC54OwogCWlmIChz
dHJlYW0tPnB1YmxpYy5zcmMueCA8IGNsaXAueCkKIAkJcGlwZV9jdHgtPnNjbF9kYXRhLnJlY291
dC54ICs9IChjbGlwLngKLS0gCjIuMTAuMQoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVl
ZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5m
by9hbWQtZ2Z4Cg==
