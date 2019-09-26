From: Lyude Paul <lyude-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH 3/6] drm/amdgpu/dm/mst: Use ->atomic_best_encoder
Date: Thu, 26 Sep 2019 18:51:05 -0400
Message-ID: <20190926225122.31455-4-lyude@redhat.com>
References: <20190926225122.31455-1-lyude@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <20190926225122.31455-1-lyude-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
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
Cc: "David (ChunMing) Zhou" <David1.Zhou-5C7GfCeVMHo@public.gmane.org>, Thomas Lim <Thomas.Lim-5C7GfCeVMHo@public.gmane.org>, Leo Li <sunpeng.li-5C7GfCeVMHo@public.gmane.org>, David Francis <David.Francis-5C7GfCeVMHo@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, David Airlie <airlied-cv59FeDIM0c@public.gmane.org>, "Jerry (Fangzhi) Zuo" <Jerry.Zuo-5C7GfCeVMHo@public.gmane.org>, Daniel Vetter <daniel-/w4YWyX8dFk@public.gmane.org>, Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org>, Harry Wentland <harry.wentland-5C7GfCeVMHo@public.gmane.org>, =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig-5C7GfCeVMHo@public.gmane.org>

V2UgYXJlIHN1cHBvc2VkIHRvIGJlIGF0b21pYyBhZnRlciBhbGwuIFdlJ2xsIG5lZWQgdGhpcyBp
biBhIG1vbWVudCBmb3IKdGhlIG5leHQgY29tbWl0LgoKU2lnbmVkLW9mZi1ieTogTHl1ZGUgUGF1
bCA8bHl1ZGVAcmVkaGF0LmNvbT4KLS0tCiAuLi4vZHJtL2FtZC9kaXNwbGF5L2FtZGdwdV9kbS9h
bWRncHVfZG1fbXN0X3R5cGVzLmMgICAgfCAxMCArKysrKy0tLS0tCiAxIGZpbGUgY2hhbmdlZCwg
NSBpbnNlcnRpb25zKCspLCA1IGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1
L2RybS9hbWQvZGlzcGxheS9hbWRncHVfZG0vYW1kZ3B1X2RtX21zdF90eXBlcy5jIGIvZHJpdmVy
cy9ncHUvZHJtL2FtZC9kaXNwbGF5L2FtZGdwdV9kbS9hbWRncHVfZG1fbXN0X3R5cGVzLmMKaW5k
ZXggYTM5OGRkZDFmMzA2Li5kOTExM2NlMGJlMDkgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvZ3B1L2Ry
bS9hbWQvZGlzcGxheS9hbWRncHVfZG0vYW1kZ3B1X2RtX21zdF90eXBlcy5jCisrKyBiL2RyaXZl
cnMvZ3B1L2RybS9hbWQvZGlzcGxheS9hbWRncHVfZG0vYW1kZ3B1X2RtX21zdF90eXBlcy5jCkBA
IC0yNDMsMTcgKzI0MywxNyBAQCBzdGF0aWMgaW50IGRtX2RwX21zdF9nZXRfbW9kZXMoc3RydWN0
IGRybV9jb25uZWN0b3IgKmNvbm5lY3RvcikKIAlyZXR1cm4gcmV0OwogfQogCi1zdGF0aWMgc3Ry
dWN0IGRybV9lbmNvZGVyICpkbV9tc3RfYmVzdF9lbmNvZGVyKHN0cnVjdCBkcm1fY29ubmVjdG9y
ICpjb25uZWN0b3IpCitzdGF0aWMgc3RydWN0IGRybV9lbmNvZGVyICoKK2RtX21zdF9hdG9taWNf
YmVzdF9lbmNvZGVyKHN0cnVjdCBkcm1fY29ubmVjdG9yICpjb25uZWN0b3IsCisJCQkgICBzdHJ1
Y3QgZHJtX2Nvbm5lY3Rvcl9zdGF0ZSAqY29ubmVjdG9yX3N0YXRlKQogewotCXN0cnVjdCBhbWRn
cHVfZG1fY29ubmVjdG9yICphbWRncHVfZG1fY29ubmVjdG9yID0gdG9fYW1kZ3B1X2RtX2Nvbm5l
Y3Rvcihjb25uZWN0b3IpOwotCi0JcmV0dXJuICZhbWRncHVfZG1fY29ubmVjdG9yLT5tc3RfZW5j
b2Rlci0+YmFzZTsKKwlyZXR1cm4gJnRvX2FtZGdwdV9kbV9jb25uZWN0b3IoY29ubmVjdG9yKS0+
bXN0X2VuY29kZXItPmJhc2U7CiB9CiAKIHN0YXRpYyBjb25zdCBzdHJ1Y3QgZHJtX2Nvbm5lY3Rv
cl9oZWxwZXJfZnVuY3MgZG1fZHBfbXN0X2Nvbm5lY3Rvcl9oZWxwZXJfZnVuY3MgPSB7CiAJLmdl
dF9tb2RlcyA9IGRtX2RwX21zdF9nZXRfbW9kZXMsCiAJLm1vZGVfdmFsaWQgPSBhbWRncHVfZG1f
Y29ubmVjdG9yX21vZGVfdmFsaWQsCi0JLmJlc3RfZW5jb2RlciA9IGRtX21zdF9iZXN0X2VuY29k
ZXIsCisJLmF0b21pY19iZXN0X2VuY29kZXIgPSBkbV9tc3RfYXRvbWljX2Jlc3RfZW5jb2RlciwK
IH07CiAKIHN0YXRpYyB2b2lkIGFtZGdwdV9kbV9lbmNvZGVyX2Rlc3Ryb3koc3RydWN0IGRybV9l
bmNvZGVyICplbmNvZGVyKQotLSAKMi4yMS4wCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZy
ZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3Rp
bmZvL2FtZC1nZng=
