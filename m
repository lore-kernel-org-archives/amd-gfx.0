From: Harry Wentland <harry.wentland-5C7GfCeVMHo@public.gmane.org>
Subject: [PATCH 01/20] drm/amd/display: Don't set cursor address is 0 logging
 as errors
Date: Mon, 16 Oct 2017 16:31:35 -0400
Message-ID: <20171016203154.6401-2-harry.wentland@amd.com>
References: <20171016203154.6401-1-harry.wentland@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <20171016203154.6401-1-harry.wentland-5C7GfCeVMHo@public.gmane.org>
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
Cc: Andrew Jiang <Andrew.Jiang-5C7GfCeVMHo@public.gmane.org>

RnJvbTogQW5kcmV3IEppYW5nIDxBbmRyZXcuSmlhbmdAYW1kLmNvbT4KClRoaXMgYWN0dWFsbHkg
aGFwcGVucyBxdWl0ZSBhIGJpdCwgYW5kIGhhdmluZyBpdCBhcyBhbiBlcnJvciBjYXVzZXMKZmFs
c2UgcG9zaXRpdmUgbWVzc2FnZXMgd2hlbiBydW5uaW5nIHRlc3RzLgoKU2lnbmVkLW9mZi1ieTog
QW5kcmV3IEppYW5nIDxBbmRyZXcuSmlhbmdAYW1kLmNvbT4KUmV2aWV3ZWQtYnk6IFRvbnkgQ2hl
bmcgPFRvbnkuQ2hlbmdAYW1kLmNvbT4KQWNrZWQtYnk6IEhhcnJ5IFdlbnRsYW5kIDxIYXJyeS5X
ZW50bGFuZEBhbWQuY29tPgotLS0KIGRyaXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxheS9kYy9jb3Jl
L2RjX3N0cmVhbS5jIHwgMiArLQogMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspLCAxIGRl
bGV0aW9uKC0pCgpkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5L2RjL2Nv
cmUvZGNfc3RyZWFtLmMgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2Rpc3BsYXkvZGMvY29yZS9kY19z
dHJlYW0uYwppbmRleCA5N2YwNDBhMjU4MjAuLjVjZjY5YWY5NjkzZCAxMDA2NDQKLS0tIGEvZHJp
dmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5L2RjL2NvcmUvZGNfc3RyZWFtLmMKKysrIGIvZHJpdmVy
cy9ncHUvZHJtL2FtZC9kaXNwbGF5L2RjL2NvcmUvZGNfc3RyZWFtLmMKQEAgLTE5MCw3ICsxOTAs
NyBAQCBib29sIGRjX3N0cmVhbV9zZXRfY3Vyc29yX2F0dHJpYnV0ZXMoCiAJfQogCiAJaWYgKGF0
dHJpYnV0ZXMtPmFkZHJlc3MucXVhZF9wYXJ0ID09IDApIHsKLQkJZG1fZXJyb3IoIkRDOiBDdXJz
b3IgYWRkcmVzcyBpcyAwIVxuIik7CisJCWRtX291dHB1dF90b19jb25zb2xlKCJEQzogQ3Vyc29y
IGFkZHJlc3MgaXMgMCFcbiIpOwogCQlyZXR1cm4gZmFsc2U7CiAJfQogCi0tIAoyLjE0LjEKCl9f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFp
bGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJl
ZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=
