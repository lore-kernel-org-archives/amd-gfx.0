From: Alex Deucher <alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH 13/15] drm/amdgpu/vce2: add ring callbacks for ib and dma
 frame size
Date: Fri, 16 Sep 2016 12:05:50 -0400
Message-ID: <1474041952-2378-13-git-send-email-alexander.deucher@amd.com>
References: <1474041952-2378-1-git-send-email-alexander.deucher@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <1474041952-2378-1-git-send-email-alexander.deucher-5C7GfCeVMHo@public.gmane.org>
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
Cc: Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org>

U2lnbmVkLW9mZi1ieTogQWxleCBEZXVjaGVyIDxhbGV4YW5kZXIuZGV1Y2hlckBhbWQuY29tPgot
LS0KIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L3ZjZV92Ml8wLmMgfCAyICsrCiAxIGZpbGUg
Y2hhbmdlZCwgMiBpbnNlcnRpb25zKCspCgpkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2Ft
ZC9hbWRncHUvdmNlX3YyXzAuYyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L3ZjZV92Ml8w
LmMKaW5kZXggNThhZjBkYS4uNzZlNjRhZCAxMDA2NDQKLS0tIGEvZHJpdmVycy9ncHUvZHJtL2Ft
ZC9hbWRncHUvdmNlX3YyXzAuYworKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS92Y2Vf
djJfMC5jCkBAIC02MjIsNiArNjIyLDggQEAgc3RhdGljIGNvbnN0IHN0cnVjdCBhbWRncHVfcmlu
Z19mdW5jcyB2Y2VfdjJfMF9yaW5nX2Z1bmNzID0gewogCS5wYWRfaWIgPSBhbWRncHVfcmluZ19n
ZW5lcmljX3BhZF9pYiwKIAkuYmVnaW5fdXNlID0gYW1kZ3B1X3ZjZV9yaW5nX2JlZ2luX3VzZSwK
IAkuZW5kX3VzZSA9IGFtZGdwdV92Y2VfcmluZ19lbmRfdXNlLAorCS5nZXRfZW1pdF9pYl9zaXpl
ID0gYW1kZ3B1X3ZjZV9yaW5nX2dldF9lbWl0X2liX3NpemUsCisJLmdldF9kbWFfZnJhbWVfc2l6
ZSA9IGFtZGdwdV92Y2VfcmluZ19nZXRfZG1hX2ZyYW1lX3NpemUsCiB9OwogCiBzdGF0aWMgdm9p
ZCB2Y2VfdjJfMF9zZXRfcmluZ19mdW5jcyhzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRldikKLS0g
CjIuNS41CgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwph
bWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczov
L2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZngK
