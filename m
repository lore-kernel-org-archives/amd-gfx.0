From: Tom St Denis <tom.stdenis-5C7GfCeVMHo@public.gmane.org>
Subject: [PATCH umr] fix specifying device by ASIC name
Date: Fri,  8 Dec 2017 07:31:11 -0500
Message-ID: <20171208123111.8718-1-tom.stdenis@amd.com>
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
Cc: Tom St Denis <tom.stdenis-5C7GfCeVMHo@public.gmane.org>

U2lnbmVkLW9mZi1ieTogVG9tIFN0IERlbmlzIDx0b20uc3RkZW5pc0BhbWQuY29tPgotLS0KIHNy
Yy9saWIvZGlzY292ZXIuYyB8IDIgKy0KIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKSwg
MSBkZWxldGlvbigtKQoKZGlmZiAtLWdpdCBhL3NyYy9saWIvZGlzY292ZXIuYyBiL3NyYy9saWIv
ZGlzY292ZXIuYwppbmRleCBlMWNjZWExZDIwZTQuLjk0ZDFjNjc2NzE4YSAxMDA2NDQKLS0tIGEv
c3JjL2xpYi9kaXNjb3Zlci5jCisrKyBiL3NyYy9saWIvZGlzY292ZXIuYwpAQCAtMTUyLDcgKzE1
Miw3IEBAIHN0cnVjdCB1bXJfYXNpYyAqdW1yX2Rpc2NvdmVyX2FzaWMoc3RydWN0IHVtcl9vcHRp
b25zICpvcHRpb25zKQogCiAJc25wcmludGYobmFtZSwgc2l6ZW9mKG5hbWUpLTEsICIvc3lzL2tl
cm5lbC9kZWJ1Zy9kcmkvJWQvbmFtZSIsIG9wdGlvbnMtPmluc3RhbmNlKTsKIAlmID0gZm9wZW4o
bmFtZSwgInIiKTsKLQlpZiAoIWYgJiYgIW9wdGlvbnMtPm5vX2tlcm5lbCAmJiAhb3B0aW9ucy0+
dXNlX3BjaSkgeworCWlmICghZiAmJiBvcHRpb25zLT5pbnN0YW5jZSA+PSAwICYmICFvcHRpb25z
LT5ub19rZXJuZWwgJiYgIW9wdGlvbnMtPnVzZV9wY2kpIHsKIAkJaW50IGZvdW5kID0gMDsKIAkJ
aWYgKCFvcHRpb25zLT5xdWlldCkgewogCQkJZiA9IHBvcGVuKCJsc21vZCB8IGdyZXAgXmFtZGdw
dSIsICJyIik7Ci0tIAoyLjEyLjAKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0
b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1k
LWdmeAo=
