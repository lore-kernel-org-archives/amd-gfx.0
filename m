From: Harry Wentland <harry.wentland-5C7GfCeVMHo@public.gmane.org>
Subject: [PATCH 11/13] drm/amd/display: Disable pipe split.
Date: Mon, 26 Jun 2017 16:55:28 -0400
Message-ID: <20170626205530.25131-12-harry.wentland@amd.com>
References: <20170626205530.25131-1-harry.wentland@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <20170626205530.25131-1-harry.wentland-5C7GfCeVMHo@public.gmane.org>
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
Cc: Yongqiang Sun <yongqiang.sun-5C7GfCeVMHo@public.gmane.org>

RnJvbTogWW9uZ3FpYW5nIFN1biA8eW9uZ3FpYW5nLnN1bkBhbWQuY29tPgoKQ2hhbmdlLUlkOiBJ
N2QzYzg2NzdlMjM2MDAzMzg2ZGRjN2RmZDM1MTFiNmExM2E4OTgyOQpTaWduZWQtb2ZmLWJ5OiBZ
b25ncWlhbmcgU3VuIDx5b25ncWlhbmcuc3VuQGFtZC5jb20+ClJldmlld2VkLWJ5OiBIZXJzZW4g
V3UgPGhlcnNlbnhzLnd1QGFtZC5jb20+CkFja2VkLWJ5OiBIYXJyeSBXZW50bGFuZCA8SGFycnku
V2VudGxhbmRAYW1kLmNvbT4KLS0tCiBkcml2ZXJzL2dwdS9kcm0vYW1kL2Rpc3BsYXkvZGMvZGNu
MTAvZGNuMTBfcmVzb3VyY2UuYyB8IDIgKy0KIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigr
KSwgMSBkZWxldGlvbigtKQoKZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxh
eS9kYy9kY24xMC9kY24xMF9yZXNvdXJjZS5jIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5
L2RjL2RjbjEwL2RjbjEwX3Jlc291cmNlLmMKaW5kZXggYzc4NDBlMGUzYWU1Li5lZWJhZmZjYThl
NzUgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxheS9kYy9kY24xMC9kY24x
MF9yZXNvdXJjZS5jCisrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxheS9kYy9kY24xMC9k
Y24xMF9yZXNvdXJjZS5jCkBAIC00NDMsNyArNDQzLDcgQEAgc3RhdGljIGNvbnN0IHN0cnVjdCBk
Y19kZWJ1ZyBkZWJ1Z19kZWZhdWx0c19kcnYgPSB7CiAJCS5kaXNhYmxlX3BwbGliX3dtX3Jhbmdl
ID0gZmFsc2UsCiAjaWYgZGVmaW5lZChDT05GSUdfRFJNX0FNRF9EQ19EQ04xXzApCiAJCS51c2Vf
ZG1sX3dtID0gZmFsc2UsCi0JCS5kaXNhYmxlX3BpcGVfc3BsaXQgPSBmYWxzZQorCQkuZGlzYWJs
ZV9waXBlX3NwbGl0ID0gdHJ1ZQogI2VuZGlmCiB9OwogCi0tIAoyLjExLjAKCl9fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0
CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Au
b3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=
