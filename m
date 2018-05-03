From: <sunpeng.li-5C7GfCeVMHo@public.gmane.org>
Subject: [PATCH xf86-video-amdgpu 08/13] Set driver-private CRTC's dpms mode
 on disable
Date: Thu, 3 May 2018 14:31:50 -0400
Message-ID: <1525372315-28462-9-git-send-email-sunpeng.li@amd.com>
References: <1525372315-28462-1-git-send-email-sunpeng.li@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <1525372315-28462-1-git-send-email-sunpeng.li-5C7GfCeVMHo@public.gmane.org>
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
Cc: "Leo (Sunpeng) Li" <sunpeng.li-5C7GfCeVMHo@public.gmane.org>, michel-otUistvHUpPR7s880joybQ@public.gmane.org, harry.wentland-5C7GfCeVMHo@public.gmane.org

RnJvbTogIkxlbyAoU3VucGVuZykgTGkiIDxzdW5wZW5nLmxpQGFtZC5jb20+CgpUaGUgZHBtc19t
b2RlIGZsYWcgb24gdGhlIGRyaXZlci1wcml2YXRlIENSVEMgd2FzIG5vdCBiZWluZyBzZXQgd2hl
bgppdCdzIERQTVMgc3RhdGUgaXMgc2V0IHRvIG9mZi4gVGhpcyBjYXVzZXMgc29tZSBwcm9ibGVt
cyB3aGVuIHRvZ2dsaW5nCml0IGJhY2sgb24sIGFzIHNvbWUgY29uZGl0aW9uYWxzIGNoZWNrIHRo
aXMgZmxhZy4KClNpZ25lZC1vZmYtYnk6IExlbyAoU3VucGVuZykgTGkgPHN1bnBlbmcubGlAYW1k
LmNvbT4KLS0tCiBzcmMvZHJtbW9kZV9kaXNwbGF5LmMgfCAxICsKIDEgZmlsZSBjaGFuZ2VkLCAx
IGluc2VydGlvbigrKQoKZGlmZiAtLWdpdCBhL3NyYy9kcm1tb2RlX2Rpc3BsYXkuYyBiL3NyYy9k
cm1tb2RlX2Rpc3BsYXkuYwppbmRleCAyYjM4YTcxLi5mODZmOTlhIDEwMDY0NAotLS0gYS9zcmMv
ZHJtbW9kZV9kaXNwbGF5LmMKKysrIGIvc3JjL2RybW1vZGVfZGlzcGxheS5jCkBAIC0zNDcsNiAr
MzQ3LDcgQEAgZHJtbW9kZV9jcnRjX2RwbXMoeGY4NkNydGNQdHIgY3J0YywgaW50IG1vZGUpCiAJ
CWRybU1vZGVTZXRDcnRjKHBBTURHUFVFbnQtPmZkLCBkcm1tb2RlX2NydGMtPm1vZGVfY3J0Yy0+
Y3J0Y19pZCwKIAkJCSAgICAgICAwLCAwLCAwLCBOVUxMLCAwLCBOVUxMKTsKIAkJZHJtbW9kZV9m
Yl9yZWZlcmVuY2UocEFNREdQVUVudC0+ZmQsICZkcm1tb2RlX2NydGMtPmZiLCBOVUxMKTsKKwkJ
ZHJtbW9kZV9jcnRjLT5kcG1zX21vZGUgPSBtb2RlOwogCX0gZWxzZSBpZiAoZHJtbW9kZV9jcnRj
LT5kcG1zX21vZGUgIT0gRFBNU01vZGVPbikKIAkJY3J0Yy0+ZnVuY3MtPnNldF9tb2RlX21ham9y
KGNydGMsICZjcnRjLT5tb2RlLCBjcnRjLT5yb3RhdGlvbiwKIAkJCQkJICAgIGNydGMtPngsIGNy
dGMtPnkpOwotLSAKMi43LjQKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Au
b3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdm
eAo=
