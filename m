From: Pixel Ding <Pixel.Ding-5C7GfCeVMHo@public.gmane.org>
Subject: [PATCH 2/2] drm/amdgpu: increase mailbox timeout to 5000ms
Date: Mon, 6 Feb 2017 14:25:19 +0800
Message-ID: <1486362319-4366-1-git-send-email-Pixel.Ding@amd.com>
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
Cc: Pixel Ding <Pixel.Ding-5C7GfCeVMHo@public.gmane.org>, Ding.Pixel-5C7GfCeVMHo@public.gmane.org

V2hlbiBtdXRpcGxlIFZGcyB0cnkgdG8gZW50ZXIgZXhjbHVzaXZlIG1vZGUgYXQgdGhlIHNhbWUg
dGltZSwgdGhlCmxvb3BpbmcgbWVjaGFuc2ltIGRvZXNuJ3QgaGVscCB0byBlbnN1cmUgZWFjaCBj
YW4gZ2V0IGl0IGJlY2F1c2UgaXQKb25seSBsb29wcyBhY3RpdmUgVkZzLCB0aGVuIHRoZSBsYXN0
IG9uZSBoYXMgdG8gd2FpdCBmb3IgYSBsb25nCmludGVydmFsLgoKU2lnbmVkLW9mZi1ieTogUGl4
ZWwgRGluZyA8UGl4ZWwuRGluZ0BhbWQuY29tPgotLS0KIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1k
Z3B1L214Z3B1X3ZpLmggfCAyICstCiAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKyksIDEg
ZGVsZXRpb24oLSkKCmRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9teGdw
dV92aS5oIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvbXhncHVfdmkuaAppbmRleCBmZDYy
MTZlLi4yZGI3NDExIDEwMDY0NAotLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9teGdw
dV92aS5oCisrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L214Z3B1X3ZpLmgKQEAgLTIz
LDcgKzIzLDcgQEAKICNpZm5kZWYgX19NWEdQVV9WSV9IX18KICNkZWZpbmUgX19NWEdQVV9WSV9I
X18KIAotI2RlZmluZSBWSV9NQUlMQk9YX1RJTUVET1VUCTE1MAorI2RlZmluZSBWSV9NQUlMQk9Y
X1RJTUVET1VUCTUwMDAKICNkZWZpbmUgVklfTUFJTEJPWF9SRVNFVF9USU1FCTEyCiAKIC8qIFZJ
IG1haWxib3ggbWVzc2FnZXMgcmVxdWVzdCAqLwotLSAKMi43LjQKCl9fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1n
ZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21h
aWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=
