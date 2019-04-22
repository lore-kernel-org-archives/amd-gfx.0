From: Chengming Gui <Jack.Gui-5C7GfCeVMHo@public.gmane.org>
Subject: [PATCH] drm/amd/powerplay: enable UMDPSTATE support on raven2
Date: Mon, 22 Apr 2019 17:04:44 +0800
Message-ID: <1555923884-21322-1-git-send-email-Jack.Gui@amd.com>
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
Cc: Chengming Gui <Jack.Gui-5C7GfCeVMHo@public.gmane.org>

U2lnbmVkLW9mZi1ieTogQ2hlbmdtaW5nIEd1aSA8SmFjay5HdWlAYW1kLmNvbT4KLS0tCiBkcml2
ZXJzL2dwdS9kcm0vYW1kL3Bvd2VycGxheS9od21nci9zbXUxMF9od21nci5jIHwgNSAtLS0tLQog
MSBmaWxlIGNoYW5nZWQsIDUgZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUv
ZHJtL2FtZC9wb3dlcnBsYXkvaHdtZ3Ivc211MTBfaHdtZ3IuYyBiL2RyaXZlcnMvZ3B1L2RybS9h
bWQvcG93ZXJwbGF5L2h3bWdyL3NtdTEwX2h3bWdyLmMKaW5kZXggYjUwOGI3Mi4uYzJmYTZiYyAx
MDA2NDQKLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9wb3dlcnBsYXkvaHdtZ3Ivc211MTBfaHdt
Z3IuYworKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL3Bvd2VycGxheS9od21nci9zbXUxMF9od21n
ci5jCkBAIC01ODIsMTEgKzU4Miw2IEBAIHN0YXRpYyBpbnQgc211MTBfZHBtX2ZvcmNlX2RwbV9s
ZXZlbChzdHJ1Y3QgcHBfaHdtZ3IgKmh3bWdyLAogCQlyZXR1cm4gMDsKIAl9CiAKLQkvKiBEaXNh
YmxlIFVNRFBTVEFURSBzdXBwb3J0IG9uIHJ2MiB0ZW1wb3JhcmlseSAqLwotCWlmICgoYWRldi0+
YXNpY190eXBlID09IENISVBfUkFWRU4pICYmCi0JICAgIChhZGV2LT5yZXZfaWQgPj0gOCkpCi0J
CXJldHVybiAwOwotCiAJaWYgKG1pbl9zY2xrIDwgZGF0YS0+Z2Z4X21pbl9mcmVxX2xpbWl0KQog
CQltaW5fc2NsayA9IGRhdGEtPmdmeF9taW5fZnJlcV9saW1pdDsKIAotLSAKMi43LjQKCl9fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGlu
ZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRl
c2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeA==
