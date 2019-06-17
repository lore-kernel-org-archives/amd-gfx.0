From: Alex Deucher <alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH 155/459] drm/amd/powerplay: skip od feature on navi10 for the
 moment
Date: Mon, 17 Jun 2019 14:26:20 -0500
Message-ID: <20190617192704.18038-56-alexander.deucher@amd.com>
References: <20190617192704.18038-1-alexander.deucher@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <20190617192704.18038-1-alexander.deucher-5C7GfCeVMHo@public.gmane.org>
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
Cc: Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org>, Huang Rui <ray.huang-5C7GfCeVMHo@public.gmane.org>, Hawking Zhang <Hawking.Zhang-5C7GfCeVMHo@public.gmane.org>

RnJvbTogSHVhbmcgUnVpIDxyYXkuaHVhbmdAYW1kLmNvbT4KCk9EIGZlYXR1cmUgaXNuJ3QgZW5h
YmxlZCBvbiBuYXZpMTAgc28gc2tpcCBpdCBmb3IgdGhlIG1vbWVudC4KClNpZ25lZC1vZmYtYnk6
IEh1YW5nIFJ1aSA8cmF5Lmh1YW5nQGFtZC5jb20+ClJldmlld2VkLWJ5OiBIYXdraW5nIFpoYW5n
IDxIYXdraW5nLlpoYW5nQGFtZC5jb20+ClNpZ25lZC1vZmYtYnk6IEFsZXggRGV1Y2hlciA8YWxl
eGFuZGVyLmRldWNoZXJAYW1kLmNvbT4KLS0tCiBkcml2ZXJzL2dwdS9kcm0vYW1kL3Bvd2VycGxh
eS9zbXVfdjExXzAuYyB8IDcgKysrKysrKwogMSBmaWxlIGNoYW5nZWQsIDcgaW5zZXJ0aW9ucygr
KQoKZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvcG93ZXJwbGF5L3NtdV92MTFfMC5j
IGIvZHJpdmVycy9ncHUvZHJtL2FtZC9wb3dlcnBsYXkvc211X3YxMV8wLmMKaW5kZXggNDMxMWVl
MzhhNzc0Li43YWE2Y2YzYzBkYWMgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvcG93
ZXJwbGF5L3NtdV92MTFfMC5jCisrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvcG93ZXJwbGF5L3Nt
dV92MTFfMC5jCkBAIC0xNjE4LDYgKzE2MTgsMTMgQEAgc3RhdGljIGludCBzbXVfdjExXzBfc2V0
X29kOF9kZWZhdWx0X3NldHRpbmdzKHN0cnVjdCBzbXVfY29udGV4dCAqc211LAogCXN0cnVjdCBz
bXVfdGFibGVfY29udGV4dCAqdGFibGVfY29udGV4dCA9ICZzbXUtPnNtdV90YWJsZTsKIAlpbnQg
cmV0OwogCisJLyoqCisJICogVE9ETzogRW5hYmxlIG92ZXJkcml2ZSBmb3IgbmF2aTEwLCB0aGF0
IHJlcGxpZXMgb24gc21jL3BwdGFibGUKKwkgKiBzdXBwb3J0LgorCSAqLworCWlmIChzbXUtPmFk
ZXYtPmFzaWNfdHlwZSA9PSBDSElQX05BVkkxMCkKKwkJcmV0dXJuIDA7CisKIAlpZiAoaW5pdGlh
bGl6ZSkgewogCQlpZiAodGFibGVfY29udGV4dC0+b3ZlcmRyaXZlX3RhYmxlKQogCQkJcmV0dXJu
IC1FSU5WQUw7Ci0tIAoyLjIwLjEKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0
b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1k
LWdmeA==
