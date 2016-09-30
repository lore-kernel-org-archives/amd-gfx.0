From: Tom St Denis <tstdenis82-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH 2/2] drm/amd/amdgpu: Enable UVD PG on Tonga
Date: Fri, 30 Sep 2016 11:01:42 -0400
Message-ID: <20160930150142.12415-3-tom.stdenis@amd.com>
References: <20160930150142.12415-1-tom.stdenis@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <20160930150142.12415-1-tom.stdenis-5C7GfCeVMHo@public.gmane.org>
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
Cc: Tom St Denis <tom.stdenis-5C7GfCeVMHo@public.gmane.org>

VGVzdGVkIGJ5IHJlYWRpbmcgdGlsZS9jbGsgYml0cyBkdXJpbmcgbG9hZC9pZGxlLgoKU2lnbmVk
LW9mZi1ieTogVG9tIFN0IERlbmlzIDx0b20uc3RkZW5pc0BhbWQuY29tPgotLS0KIGRyaXZlcnMv
Z3B1L2RybS9hbWQvYW1kZ3B1L3ZpLmMgfCAyICstCiAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRp
b24oKyksIDEgZGVsZXRpb24oLSkKCmRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2Ft
ZGdwdS92aS5jIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvdmkuYwppbmRleCBjNmJjM2Rm
MzYxMTguLmM0Mzk0YTZiODJlOSAxMDA2NDQKLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRn
cHUvdmkuYworKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS92aS5jCkBAIC0xOTI0LDcg
KzE5MjQsNyBAQCBzdGF0aWMgaW50IHZpX2NvbW1vbl9lYXJseV9pbml0KHZvaWQgKmhhbmRsZSkK
IAkJYnJlYWs7CiAJY2FzZSBDSElQX1RPTkdBOgogCQlhZGV2LT5jZ19mbGFncyA9IEFNRF9DR19T
VVBQT1JUX1VWRF9NR0NHOwotCQlhZGV2LT5wZ19mbGFncyA9IDA7CisJCWFkZXYtPnBnX2ZsYWdz
ID0gQU1EX1BHX1NVUFBPUlRfVVZEOwogCQlhZGV2LT5leHRlcm5hbF9yZXZfaWQgPSBhZGV2LT5y
ZXZfaWQgKyAweDE0OwogCQlicmVhazsKIAljYXNlIENISVBfUE9MQVJJUzExOgotLSAKMi4xMC4w
CgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4
IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3Rz
LmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZngK
