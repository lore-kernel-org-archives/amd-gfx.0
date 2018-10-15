From: Chunming Zhou <david1.zhou-5C7GfCeVMHo@public.gmane.org>
Subject: [PATCH 7/7] drm/amdgpu: update version for timeline syncobj support
 in amdgpu
Date: Mon, 15 Oct 2018 16:55:53 +0800
Message-ID: <20181015085553.30656-7-david1.zhou@amd.com>
References: <20181015085553.30656-1-david1.zhou@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <20181015085553.30656-1-david1.zhou-5C7GfCeVMHo@public.gmane.org>
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
To: dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Cc: Chunming Zhou <david1.zhou-5C7GfCeVMHo@public.gmane.org>, amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org

U2lnbmVkLW9mZi1ieTogQ2h1bm1pbmcgWmhvdSA8ZGF2aWQxLnpob3VAYW1kLmNvbT4KLS0tCiBk
cml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfZHJ2LmMgfCAzICsrLQogMSBmaWxlIGNo
YW5nZWQsIDIgaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbigtKQoKZGlmZiAtLWdpdCBhL2RyaXZl
cnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9kcnYuYyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQv
YW1kZ3B1L2FtZGdwdV9kcnYuYwppbmRleCA2ODcwOTA5ZGE5MjYuLjU4Y2JhNDkyYmE1NSAxMDA2
NDQKLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2Rydi5jCisrKyBiL2Ry
aXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9kcnYuYwpAQCAtNzAsOSArNzAsMTAgQEAK
ICAqIC0gMy4yNS4wIC0gQWRkIHN1cHBvcnQgZm9yIHNlbnNvciBxdWVyeSBpbmZvIChzdGFibGUg
cHN0YXRlIHNjbGsvbWNsaykuCiAgKiAtIDMuMjYuMCAtIEdGWDk6IFByb2Nlc3MgQU1ER1BVX0lC
X0ZMQUdfVENfV0JfTk9UX0lOVkFMSURBVEUuCiAgKiAtIDMuMjcuMCAtIEFkZCBuZXcgY2h1bmsg
dG8gdG8gQU1ER1BVX0NTIHRvIGVuYWJsZSBCT19MSVNUIGNyZWF0aW9uLgorICogLSAzLjI4LjAg
LSBBZGQgc3luY29iaiB0aW1lbGluZSBzdXBwb3J0IHRvIEFNREdQVV9DUy4KICAqLwogI2RlZmlu
ZSBLTVNfRFJJVkVSX01BSk9SCTMKLSNkZWZpbmUgS01TX0RSSVZFUl9NSU5PUgkyNworI2RlZmlu
ZSBLTVNfRFJJVkVSX01JTk9SCTI4CiAjZGVmaW5lIEtNU19EUklWRVJfUEFUQ0hMRVZFTAkwCiAK
IGludCBhbWRncHVfdnJhbV9saW1pdCA9IDA7Ci0tIAoyLjE3LjEKCl9fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1n
ZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21h
aWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=
