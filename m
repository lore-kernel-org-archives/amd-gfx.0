From: zhoucm1 <david1.zhou-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH] drm/amdgpu: Free resources of bo_list when idr_alloc fails
Date: Thu, 6 Jul 2017 10:52:42 +0800
Message-ID: <595DA5FA.5020609@amd.com>
References: <1499293623-24544-1-git-send-email-AlexBin.Xie@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <1499293623-24544-1-git-send-email-AlexBin.Xie-5C7GfCeVMHo@public.gmane.org>
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
To: Alex Xie <AlexBin.Xie-5C7GfCeVMHo@public.gmane.org>, amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org

UmV2aWV3ZWQtYnk6IENodW5taW5nIFpob3UgPGRhdmlkMS56aG91QGFtZC5jb20+CgpPbiAyMDE3
5bm0MDfmnIgwNuaXpSAwNjoyNywgQWxleCBYaWUgd3JvdGU6Cj4gU2lnbmVkLW9mZi1ieTogQWxl
eCBYaWUgPEFsZXhCaW4uWGllQGFtZC5jb20+Cj4gLS0tCj4gICBkcml2ZXJzL2dwdS9kcm0vYW1k
L2FtZGdwdS9hbWRncHVfYm9fbGlzdC5jIHwgMiArLQo+ICAgMSBmaWxlIGNoYW5nZWQsIDEgaW5z
ZXJ0aW9uKCspLCAxIGRlbGV0aW9uKC0pCj4KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJt
L2FtZC9hbWRncHUvYW1kZ3B1X2JvX2xpc3QuYyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1
L2FtZGdwdV9ib19saXN0LmMKPiBpbmRleCBlZmE2OTAzLi5kYzg3OTYyIDEwMDY0NAo+IC0tLSBh
L2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9ib19saXN0LmMKPiArKysgYi9kcml2
ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfYm9fbGlzdC5jCj4gQEAgLTgzLDcgKzgzLDcg
QEAgc3RhdGljIGludCBhbWRncHVfYm9fbGlzdF9jcmVhdGUoc3RydWN0IGFtZGdwdV9kZXZpY2Ug
KmFkZXYsCj4gICAJciA9IGlkcl9hbGxvYygmZnByaXYtPmJvX2xpc3RfaGFuZGxlcywgbGlzdCwg
MSwgMCwgR0ZQX0tFUk5FTCk7Cj4gICAJbXV0ZXhfdW5sb2NrKCZmcHJpdi0+Ym9fbGlzdF9sb2Nr
KTsKPiAgIAlpZiAociA8IDApIHsKPiAtCQlrZnJlZShsaXN0KTsKPiArCQlhbWRncHVfYm9fbGlz
dF9mcmVlKGxpc3QpOwo+ICAgCQlyZXR1cm4gcjsKPiAgIAl9Cj4gICAJKmlkID0gcjsKCl9fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGlu
ZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRl
c2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=
