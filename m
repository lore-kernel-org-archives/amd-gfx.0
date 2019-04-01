From: Chunming Zhou <david1.zhou-5C7GfCeVMHo@public.gmane.org>
Subject: [PATCH 9/9] drm/amdgpu: update version for timeline syncobj support
 in amdgpu
Date: Mon, 1 Apr 2019 17:51:03 +0800
Message-ID: <20190401095103.9592-10-david1.zhou@amd.com>
References: <20190401095103.9592-1-david1.zhou@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <20190401095103.9592-1-david1.zhou-5C7GfCeVMHo@public.gmane.org>
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
To: dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, lionel.g.landwerlin-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, jason-fQELhIk9awXprZlt/sZkLg@public.gmane.org, Christian.Koenig-5C7GfCeVMHo@public.gmane.org, Tobias.Hector-5C7GfCeVMHo@public.gmane.org
Cc: Chunming Zhou <david1.zhou-5C7GfCeVMHo@public.gmane.org>

U2lnbmVkLW9mZi1ieTogQ2h1bm1pbmcgWmhvdSA8ZGF2aWQxLnpob3VAYW1kLmNvbT4KUmV2aWV3
ZWQtYnk6IExpb25lbCBMYW5kd2VybGluIDxsaW9uZWwuZy5sYW5kd2VybGluQGludGVsLmNvbT4K
LS0tCiBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfZHJ2LmMgfCAzICsrLQogMSBm
aWxlIGNoYW5nZWQsIDIgaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbigtKQoKZGlmZiAtLWdpdCBh
L2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9kcnYuYyBiL2RyaXZlcnMvZ3B1L2Ry
bS9hbWQvYW1kZ3B1L2FtZGdwdV9kcnYuYwppbmRleCA4YTA3MzIwODg2NDAuLjRkOGRiODcwNDhk
MyAxMDA2NDQKLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2Rydi5jCisr
KyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9kcnYuYwpAQCAtNzQsOSArNzQs
MTAgQEAKICAqIC0gMy4yOC4wIC0gQWRkIEFNREdQVV9DSFVOS19JRF9TQ0hFRFVMRURfREVQRU5E
RU5DSUVTCiAgKiAtIDMuMjkuMCAtIEFkZCBBTURHUFVfSUJfRkxBR19SRVNFVF9HRFNfTUFYX1dB
VkVfSUQKICAqIC0gMy4zMC4wIC0gQWRkIEFNREdQVV9TQ0hFRF9PUF9DT05URVhUX1BSSU9SSVRZ
X09WRVJSSURFLgorICogLSAzLjMxLjAgLSBBZGQgc3luY29iaiB0aW1lbGluZSBzdXBwb3J0IHRv
IEFNREdQVV9DUy4KICAqLwogI2RlZmluZSBLTVNfRFJJVkVSX01BSk9SCTMKLSNkZWZpbmUgS01T
X0RSSVZFUl9NSU5PUgkzMAorI2RlZmluZSBLTVNfRFJJVkVSX01JTk9SCTMxCiAjZGVmaW5lIEtN
U19EUklWRVJfUEFUQ0hMRVZFTAkwCiAKIGludCBhbWRncHVfdnJhbV9saW1pdCA9IDA7Ci0tIAoy
LjE3LjEKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFt
ZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8v
bGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeA==
