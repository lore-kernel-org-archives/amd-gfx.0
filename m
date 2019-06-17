From: Alex Deucher <alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH 187/459] drm/amd/powerplay: do not set dpm_enabled flag before
 VCN/DCN DPM is workable
Date: Mon, 17 Jun 2019 14:26:52 -0500
Message-ID: <20190617192704.18038-88-alexander.deucher@amd.com>
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

RnJvbTogSHVhbmcgUnVpIDxyYXkuaHVhbmdAYW1kLmNvbT4KClRoaXMgZHBtX2VuYWJsZWQgZmxh
ZyB3aWxsIGJlIHJlY29nbml6ZWQgYXMgdGhlIFZDTiBEUE0gZW5hYmxlZCBhcyB3ZWxsLiBJbiBm
YWN0ClZDTi9EQ04gRFBNIG9uIE5hdmkxMCBpcyBub3QgZ29vZCBzbyBmYXIsIHNvIHdlIGNhbm5v
dCBlbmFibGUgaXQgZm9yIG5vdy4KClNpZ25lZC1vZmYtYnk6IEh1YW5nIFJ1aSA8cmF5Lmh1YW5n
QGFtZC5jb20+CkFja2VkLWJ5OiBIYXdraW5nIFpoYW5nIDxIYXdraW5nLlpoYW5nQGFtZC5jb20+
ClNpZ25lZC1vZmYtYnk6IEFsZXggRGV1Y2hlciA8YWxleGFuZGVyLmRldWNoZXJAYW1kLmNvbT4K
LS0tCiBkcml2ZXJzL2dwdS9kcm0vYW1kL3Bvd2VycGxheS9hbWRncHVfc211LmMgfCAzICsrKwog
MSBmaWxlIGNoYW5nZWQsIDMgaW5zZXJ0aW9ucygrKQoKZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1
L2RybS9hbWQvcG93ZXJwbGF5L2FtZGdwdV9zbXUuYyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvcG93
ZXJwbGF5L2FtZGdwdV9zbXUuYwppbmRleCA4NThjZTVkYjY4N2YuLjA2ZjVlNWNlOWRiMSAxMDA2
NDQKLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9wb3dlcnBsYXkvYW1kZ3B1X3NtdS5jCisrKyBi
L2RyaXZlcnMvZ3B1L2RybS9hbWQvcG93ZXJwbGF5L2FtZGdwdV9zbXUuYwpAQCAtODY2LDYgKzg2
Niw5IEBAIHN0YXRpYyBpbnQgc211X2h3X2luaXQodm9pZCAqaGFuZGxlKQogCQlhZGV2LT5wbS5k
cG1fZW5hYmxlZCA9IGZhbHNlOwogCWVsc2UKIAkJYWRldi0+cG0uZHBtX2VuYWJsZWQgPSB0cnVl
OworCS8qIFRPRE86IHdpbGwgc2V0IGRwbV9lbmFibGVkIGZsYWcgd2hpbGUgVkNOIGFuZCBEQUwg
RFBNIGlzIHdvcmthYmxlICovCisJaWYgKGFkZXYtPmFzaWNfdHlwZSAhPSBDSElQX05BVkkxMCkK
KwkJYWRldi0+cG0uZHBtX2VuYWJsZWQgPSB0cnVlOwogCiAJcHJfaW5mbygiU01VIGlzIGluaXRp
YWxpemVkIHN1Y2Nlc3NmdWxseSFcbiIpOwogCi0tIAoyLjIwLjEKCl9fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1n
ZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21h
aWxtYW4vbGlzdGluZm8vYW1kLWdmeA==
