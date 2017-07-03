From: Rex Zhu <Rex.Zhu-5C7GfCeVMHo@public.gmane.org>
Subject: [PATCH 4/4] drm/amd/powerplay: add avfs check for old asics on Vi.
Date: Mon, 3 Jul 2017 18:13:33 +0800
Message-ID: <1499076813-9833-4-git-send-email-Rex.Zhu@amd.com>
References: <1499076813-9833-1-git-send-email-Rex.Zhu@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <1499076813-9833-1-git-send-email-Rex.Zhu-5C7GfCeVMHo@public.gmane.org>
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
Cc: Rex Zhu <Rex.Zhu-5C7GfCeVMHo@public.gmane.org>

Q2hhbmdlLUlkOiBJMTczN2JhMjdhZTJhOGY1YzU3OWNjYjU0MWNlZDljYjk3OWZmZDFmZgpTaWdu
ZWQtb2ZmLWJ5OiBSZXggWmh1IDxSZXguWmh1QGFtZC5jb20+Ci0tLQogZHJpdmVycy9ncHUvZHJt
L2FtZC9wb3dlcnBsYXkvaHdtZ3Ivc211N19od21nci5jIHwgOSArKysrKysrKysKIDEgZmlsZSBj
aGFuZ2VkLCA5IGluc2VydGlvbnMoKykKCmRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1k
L3Bvd2VycGxheS9od21nci9zbXU3X2h3bWdyLmMgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL3Bvd2Vy
cGxheS9od21nci9zbXU3X2h3bWdyLmMKaW5kZXggZTdlY2JkMS4uOGZlNjJhYSAxMDA2NDQKLS0t
IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9wb3dlcnBsYXkvaHdtZ3Ivc211N19od21nci5jCisrKyBi
L2RyaXZlcnMvZ3B1L2RybS9hbWQvcG93ZXJwbGF5L2h3bWdyL3NtdTdfaHdtZ3IuYwpAQCAtNDY2
MCw2ICs0NjYwLDE1IEBAIHN0YXRpYyBpbnQgc211N19zZXRfcG93ZXJfcHJvZmlsZV9zdGF0ZShz
dHJ1Y3QgcHBfaHdtZ3IgKmh3bWdyLAogCiBzdGF0aWMgaW50IHNtdTdfYXZmc19jb250cm9sKHN0
cnVjdCBwcF9od21nciAqaHdtZ3IsIGJvb2wgZW5hYmxlKQogeworCXN0cnVjdCBwcF9zbXVtZ3Ig
KnNtdW1nciA9IChzdHJ1Y3QgcHBfc211bWdyICopKGh3bWdyLT5zbXVtZ3IpOworCXN0cnVjdCBz
bXU3X3NtdW1nciAqc211X2RhdGEgPSAoc3RydWN0IHNtdTdfc211bWdyICopKHNtdW1nci0+YmFj
a2VuZCk7CisKKwlpZiAoc211X2RhdGEgPT0gTlVMTCkKKwkJcmV0dXJuIC1FSU5WQUw7CisKKwlp
ZiAoc211X2RhdGEtPmF2ZnMuYXZmc19idGNfc3RhdHVzID09IEFWRlNfQlRDX05PVFNVUFBPUlRF
RCkKKwkJcmV0dXJuIDA7CisKIAlpZiAoZW5hYmxlKSB7CiAJCWlmICghUEhNX1JFQURfVkZQRl9J
TkRJUkVDVF9GSUVMRChod21nci0+ZGV2aWNlLAogCQkJCUNHU19JTkRfUkVHX19TTUMsIEZFQVRV
UkVfU1RBVFVTLCBBVlNfT04pKQotLSAKMS45LjEKCl9fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMu
ZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlz
dGluZm8vYW1kLWdmeAo=
