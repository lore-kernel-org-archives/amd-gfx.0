From: Harry Wentland <harry.wentland-5C7GfCeVMHo@public.gmane.org>
Subject: [PATCH 15/20] drm/amd/display: remove format_control from
 set_cursor_attributes
Date: Fri, 1 Dec 2017 09:25:49 -0500
Message-ID: <20171201142554.11672-16-harry.wentland@amd.com>
References: <20171201142554.11672-1-harry.wentland@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <20171201142554.11672-1-harry.wentland-5C7GfCeVMHo@public.gmane.org>
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
Cc: Yue Hin Lau <Yuehin.Lau-5C7GfCeVMHo@public.gmane.org>

RnJvbTogWXVlIEhpbiBMYXUgPFl1ZWhpbi5MYXVAYW1kLmNvbT4KClNpZ25lZC1vZmYtYnk6IFl1
ZSBIaW4gTGF1IDxZdWVoaW4uTGF1QGFtZC5jb20+ClJldmlld2VkLWJ5OiBFcmljIEJlcm5zdGVp
biA8RXJpYy5CZXJuc3RlaW5AYW1kLmNvbT4KQWNrZWQtYnk6IEhhcnJ5IFdlbnRsYW5kIDxoYXJy
eS53ZW50bGFuZEBhbWQuY29tPgotLS0KIGRyaXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxheS9kYy9k
Y24xMC9kY24xMF9kcHAuYyB8IDcgLS0tLS0tLQogMSBmaWxlIGNoYW5nZWQsIDcgZGVsZXRpb25z
KC0pCgpkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5L2RjL2RjbjEwL2Rj
bjEwX2RwcC5jIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5L2RjL2RjbjEwL2RjbjEwX2Rw
cC5jCmluZGV4IDZkYjE4MzlkNzE1NS4uZjJhMDhiMTU2Y2YwIDEwMDY0NAotLS0gYS9kcml2ZXJz
L2dwdS9kcm0vYW1kL2Rpc3BsYXkvZGMvZGNuMTAvZGNuMTBfZHBwLmMKKysrIGIvZHJpdmVycy9n
cHUvZHJtL2FtZC9kaXNwbGF5L2RjL2RjbjEwL2RjbjEwX2RwcC5jCkBAIC00MDAsMTMgKzQwMCw2
IEBAIHZvaWQgZHBwMV9zZXRfY3Vyc29yX2F0dHJpYnV0ZXMoCiAJCVJFR19VUERBVEUoQ1VSU09S
MF9DT0xPUjEsCiAJCQkJQ1VSMF9DT0xPUjEsIDB4RkZGRkZGRkYpOwogCX0KLQotCS8qIFRPRE86
IEZpeGVkIHZzIGZsb2F0ICovCi0KLQlSRUdfVVBEQVRFXzMoRk9STUFUX0NPTlRST0wsCi0JCQkJ
Q05WQ19CWVBBU1MsIDAsCi0JCQkJRk9STUFUX0NPTlRST0xfX0FMUEhBX0VOLCAxLAotCQkJCUZP
Uk1BVF9FWFBBTlNJT05fTU9ERSwgMCk7CiB9CiAKIAotLSAKMi4xNC4xCgpfX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAph
bWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9y
Zy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZngK
