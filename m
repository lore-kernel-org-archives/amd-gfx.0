From: Chunming Zhou <david1.zhou-5C7GfCeVMHo@public.gmane.org>
Subject: [PATCH 9/9] drm/amdgpu: update version for timeline syncobj support
 in amdgpu
Date: Wed, 20 Mar 2019 13:47:24 +0800
Message-ID: <20190320054724.14636-9-david1.zhou@amd.com>
References: <20190320054724.14636-1-david1.zhou@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <20190320054724.14636-1-david1.zhou-5C7GfCeVMHo@public.gmane.org>
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

U2lnbmVkLW9mZi1ieTogQ2h1bm1pbmcgWmhvdSA8ZGF2aWQxLnpob3VAYW1kLmNvbT4KLS0tCiBk
cml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfZHJ2LmMgfCAzICsrLQogMSBmaWxlIGNo
YW5nZWQsIDIgaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbigtKQoKZGlmZiAtLWdpdCBhL2RyaXZl
cnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9kcnYuYyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQv
YW1kZ3B1L2FtZGdwdV9kcnYuYwppbmRleCA4YTA3MzIwODg2NDAuLjRkOGRiODcwNDhkMyAxMDA2
NDQKLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2Rydi5jCisrKyBiL2Ry
aXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9kcnYuYwpAQCAtNzQsOSArNzQsMTAgQEAK
ICAqIC0gMy4yOC4wIC0gQWRkIEFNREdQVV9DSFVOS19JRF9TQ0hFRFVMRURfREVQRU5ERU5DSUVT
CiAgKiAtIDMuMjkuMCAtIEFkZCBBTURHUFVfSUJfRkxBR19SRVNFVF9HRFNfTUFYX1dBVkVfSUQK
ICAqIC0gMy4zMC4wIC0gQWRkIEFNREdQVV9TQ0hFRF9PUF9DT05URVhUX1BSSU9SSVRZX09WRVJS
SURFLgorICogLSAzLjMxLjAgLSBBZGQgc3luY29iaiB0aW1lbGluZSBzdXBwb3J0IHRvIEFNREdQ
VV9DUy4KICAqLwogI2RlZmluZSBLTVNfRFJJVkVSX01BSk9SCTMKLSNkZWZpbmUgS01TX0RSSVZF
Ul9NSU5PUgkzMAorI2RlZmluZSBLTVNfRFJJVkVSX01JTk9SCTMxCiAjZGVmaW5lIEtNU19EUklW
RVJfUEFUQ0hMRVZFTAkwCiAKIGludCBhbWRncHVfdnJhbV9saW1pdCA9IDA7Ci0tIAoyLjE3LjEK
Cl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1nZngg
bWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMu
ZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeA==
