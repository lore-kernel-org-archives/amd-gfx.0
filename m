From: "=?UTF-8?q?Christian=20K=C3=B6nig?=" <ckoenig.leichtzumerken-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH 1/2] drm/amdgpu: allow for more flexible priority handling
Date: Mon, 16 Jul 2018 15:24:47 +0200
Message-ID: <20180716132448.21767-1-christian.koenig@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
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

QWxsb3cgdG8gY2FsbCBhbWRncHVfcmluZ19wcmlvcml0eV9nZXQoKSBhZnRlciBwdXNoaW5nIHRo
ZSByaW5nIHRvIHRoZQpzY2hlZHVsZXIuCgpTaWduZWQtb2ZmLWJ5OiBDaHJpc3RpYW4gS8O2bmln
IDxjaHJpc3RpYW4ua29lbmlnQGFtZC5jb20+Ci0tLQogZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRn
cHUvYW1kZ3B1X3JpbmcuYyB8IDMgKystCiAxIGZpbGUgY2hhbmdlZCwgMiBpbnNlcnRpb25zKCsp
LCAxIGRlbGV0aW9uKC0pCgpkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUv
YW1kZ3B1X3JpbmcuYyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9yaW5nLmMK
aW5kZXggMTllNDVhMzk1M2UwLi45Mzc5NGE4NWY4M2QgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvZ3B1
L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9yaW5nLmMKKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9h
bWRncHUvYW1kZ3B1X3JpbmcuYwpAQCAtMjExLDcgKzIxMSw4IEBAIHZvaWQgYW1kZ3B1X3Jpbmdf
cHJpb3JpdHlfZ2V0KHN0cnVjdCBhbWRncHVfcmluZyAqcmluZywKIAlpZiAoIXJpbmctPmZ1bmNz
LT5zZXRfcHJpb3JpdHkpCiAJCXJldHVybjsKIAotCWF0b21pY19pbmMoJnJpbmctPm51bV9qb2Jz
W3ByaW9yaXR5XSk7CisJaWYgKGF0b21pY19pbmNfcmV0dXJuKCZyaW5nLT5udW1fam9ic1twcmlv
cml0eV0pIDw9IDApCisJCXJldHVybjsKIAogCW11dGV4X2xvY2soJnJpbmctPnByaW9yaXR5X211
dGV4KTsKIAlpZiAocHJpb3JpdHkgPD0gcmluZy0+cHJpb3JpdHkpCi0tIAoyLjE0LjEKCl9fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGlu
ZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRl
c2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=
