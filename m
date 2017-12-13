From: Harry Wentland <harry.wentland-5C7GfCeVMHo@public.gmane.org>
Subject: [PATCH 27/30] drm/amd/display: dal 3.1.27
Date: Wed, 13 Dec 2017 17:34:59 -0500
Message-ID: <20171213223502.25224-28-harry.wentland@amd.com>
References: <20171213223502.25224-1-harry.wentland@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <20171213223502.25224-1-harry.wentland-5C7GfCeVMHo@public.gmane.org>
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

RnJvbTogQW5kcmV3IEppYW5nIDxBbmRyZXcuSmlhbmdAYW1kLmNvbT4KClNpZ25lZC1vZmYtYnk6
IEFuZHJldyBKaWFuZyA8QW5kcmV3LkppYW5nQGFtZC5jb20+ClJldmlld2VkLWJ5OiBUb255IENo
ZW5nIDxUb255LkNoZW5nQGFtZC5jb20+CkFja2VkLWJ5OiBIYXJyeSBXZW50bGFuZCA8aGFycnku
d2VudGxhbmRAYW1kLmNvbT4KLS0tCiBkcml2ZXJzL2dwdS9kcm0vYW1kL2Rpc3BsYXkvZGMvZGMu
aCB8IDIgKy0KIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKSwgMSBkZWxldGlvbigtKQoK
ZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxheS9kYy9kYy5oIGIvZHJpdmVy
cy9ncHUvZHJtL2FtZC9kaXNwbGF5L2RjL2RjLmgKaW5kZXggMWIxYzczMDBkZmMzLi5lMmUzYzlk
Zjc5ZWEgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxheS9kYy9kYy5oCisr
KyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxheS9kYy9kYy5oCkBAIC0zOCw3ICszOCw3IEBA
CiAjaW5jbHVkZSAiaW5jL2NvbXByZXNzb3IuaCIKICNpbmNsdWRlICJkbWwvZGlzcGxheV9tb2Rl
X2xpYi5oIgogCi0jZGVmaW5lIERDX1ZFUiAiMy4xLjI2IgorI2RlZmluZSBEQ19WRVIgIjMuMS4y
NyIKIAogI2RlZmluZSBNQVhfU1VSRkFDRVMgMwogI2RlZmluZSBNQVhfU1RSRUFNUyA2Ci0tIAoy
LjE0LjEKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFt
ZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8v
bGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=
