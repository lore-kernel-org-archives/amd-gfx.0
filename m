From: "=?UTF-8?q?Christian=20K=C3=B6nig?=" <ckoenig.leichtzumerken-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH] drm/scheduler: fix build broken by "move last_sched fence
 updating prior to job popping"
Date: Wed, 18 Apr 2018 12:06:27 +0200
Message-ID: <20180418100627.11879-1-christian.koenig@amd.com>
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

V2UgZG9uJ3QgaGF2ZSBzX2ZlbmNlIGFzIGxvY2FsIHZhcmlhYmxlIGhlcmUuCgpTaWduZWQtb2Zm
LWJ5OiBDaHJpc3RpYW4gS8O2bmlnIDxjaHJpc3RpYW4ua29lbmlnQGFtZC5jb20+Ci0tLQogZHJp
dmVycy9ncHUvZHJtL3NjaGVkdWxlci9ncHVfc2NoZWR1bGVyLmMgfCAyICstCiAxIGZpbGUgY2hh
bmdlZCwgMSBpbnNlcnRpb24oKyksIDEgZGVsZXRpb24oLSkKCmRpZmYgLS1naXQgYS9kcml2ZXJz
L2dwdS9kcm0vc2NoZWR1bGVyL2dwdV9zY2hlZHVsZXIuYyBiL2RyaXZlcnMvZ3B1L2RybS9zY2hl
ZHVsZXIvZ3B1X3NjaGVkdWxlci5jCmluZGV4IDVkZTc5YmJiMTJjOC4uZjRiODYyNTAzNzEwIDEw
MDY0NAotLS0gYS9kcml2ZXJzL2dwdS9kcm0vc2NoZWR1bGVyL2dwdV9zY2hlZHVsZXIuYworKysg
Yi9kcml2ZXJzL2dwdS9kcm0vc2NoZWR1bGVyL2dwdV9zY2hlZHVsZXIuYwpAQCAtNDAyLDcgKzQw
Miw3IEBAIGRybV9zY2hlZF9lbnRpdHlfcG9wX2pvYihzdHJ1Y3QgZHJtX3NjaGVkX2VudGl0eSAq
ZW50aXR5KQogCQlkbWFfZmVuY2Vfc2V0X2Vycm9yKCZzY2hlZF9qb2ItPnNfZmVuY2UtPmZpbmlz
aGVkLCAtRUNBTkNFTEVEKTsKIAogCWRtYV9mZW5jZV9wdXQoZW50aXR5LT5sYXN0X3NjaGVkdWxl
ZCk7Ci0JZW50aXR5LT5sYXN0X3NjaGVkdWxlZCA9IGRtYV9mZW5jZV9nZXQoJnNfZmVuY2UtPmZp
bmlzaGVkKTsKKwllbnRpdHktPmxhc3Rfc2NoZWR1bGVkID0gZG1hX2ZlbmNlX2dldCgmc2NoZWRf
am9iLT5zX2ZlbmNlLT5maW5pc2hlZCk7CiAKIAlzcHNjX3F1ZXVlX3BvcCgmZW50aXR5LT5qb2Jf
cXVldWUpOwogCXJldHVybiBzY2hlZF9qb2I7Ci0tIAoyLjE0LjEKCl9fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1n
ZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21h
aWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=
