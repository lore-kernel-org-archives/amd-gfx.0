From: Harry Wentland <harry.wentland-5C7GfCeVMHo@public.gmane.org>
Subject: [PATCH 15/19] drm/amd/display: default spd packet to invalid
Date: Wed, 31 May 2017 11:52:14 -0400
Message-ID: <20170531155218.29934-16-harry.wentland@amd.com>
References: <20170531155218.29934-1-harry.wentland@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <20170531155218.29934-1-harry.wentland-5C7GfCeVMHo@public.gmane.org>
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
Cc: Jeff Smith <whydoubt-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>

RnJvbTogSmVmZiBTbWl0aCA8d2h5ZG91YnRAZ21haWwuY29tPgoKQ2hhbmdlLUlkOiBJN2VjNzRj
MTMxY2FhN2QwODU0MTVkNWZkMTVjNGU0NDJhMzliOTY2YQpTaWduZWQtb2ZmLWJ5OiBKZWZmIFNt
aXRoIDx3aHlkb3VidEBnbWFpbC5jb20+ClJldmlld2VkLWJ5OiBUb255IENoZW5nIDxUb255LkNo
ZW5nQGFtZC5jb20+CkFja2VkLWJ5OiBIYXJyeSBXZW50bGFuZCA8SGFycnkuV2VudGxhbmRAYW1k
LmNvbT4KLS0tCiBkcml2ZXJzL2dwdS9kcm0vYW1kL2Rpc3BsYXkvZGMvY29yZS9kY19yZXNvdXJj
ZS5jIHwgMSArCiAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKykKCmRpZmYgLS1naXQgYS9k
cml2ZXJzL2dwdS9kcm0vYW1kL2Rpc3BsYXkvZGMvY29yZS9kY19yZXNvdXJjZS5jIGIvZHJpdmVy
cy9ncHUvZHJtL2FtZC9kaXNwbGF5L2RjL2NvcmUvZGNfcmVzb3VyY2UuYwppbmRleCBlYzUwNDU3
MzQzNzguLjYyMDJiNGIzZTU5NyAxMDA2NDQKLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNw
bGF5L2RjL2NvcmUvZGNfcmVzb3VyY2UuYworKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2Rpc3Bs
YXkvZGMvY29yZS9kY19yZXNvdXJjZS5jCkBAIC0yMTcyLDYgKzIxNzIsNyBAQCB2b2lkIHJlc291
cmNlX2J1aWxkX2luZm9fZnJhbWUoc3RydWN0IHBpcGVfY3R4ICpwaXBlX2N0eCkKIAlpbmZvLT5h
dmkudmFsaWQgPSBmYWxzZTsKIAlpbmZvLT5nYW11dC52YWxpZCA9IGZhbHNlOwogCWluZm8tPnZl
bmRvci52YWxpZCA9IGZhbHNlOworCWluZm8tPnNwZC52YWxpZCA9IGZhbHNlOwogCWluZm8tPmhk
cnNtZC52YWxpZCA9IGZhbHNlOwogCWluZm8tPnZzYy52YWxpZCA9IGZhbHNlOwogCi0tIAoyLjEx
LjAKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1n
ZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlz
dHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=
