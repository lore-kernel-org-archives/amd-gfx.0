From: <sunpeng.li-5C7GfCeVMHo@public.gmane.org>
Subject: [PATCH 05/16] drm/amd/display: Remove unused panel patch
 "disconnect_delay"
Date: Thu, 29 Nov 2018 10:52:12 -0500
Message-ID: <1543506743-4674-6-git-send-email-sunpeng.li@amd.com>
References: <1543506743-4674-1-git-send-email-sunpeng.li@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <1543506743-4674-1-git-send-email-sunpeng.li-5C7GfCeVMHo@public.gmane.org>
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
Cc: Joshua Aberback <joshua.aberback-5C7GfCeVMHo@public.gmane.org>

RnJvbTogSm9zaHVhIEFiZXJiYWNrIDxqb3NodWEuYWJlcmJhY2tAYW1kLmNvbT4KCltXaHldClRo
aXMgcGF0Y2ggaXMgZm9yIHVzZSBieSBkbSwgbm8gbmVlZCBmb3IgaXQgaW4gZGMuCgpTaWduZWQt
b2ZmLWJ5OiBKb3NodWEgQWJlcmJhY2sgPGpvc2h1YS5hYmVyYmFja0BhbWQuY29tPgpSZXZpZXdl
ZC1ieTogSnVuIExlaSA8SnVuLkxlaUBhbWQuY29tPgpBY2tlZC1ieTogTGVvIExpIDxzdW5wZW5n
LmxpQGFtZC5jb20+Ci0tLQogZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5L2RjL2RjX3R5cGVz
LmggfCAxIC0KIDEgZmlsZSBjaGFuZ2VkLCAxIGRlbGV0aW9uKC0pCgpkaWZmIC0tZ2l0IGEvZHJp
dmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5L2RjL2RjX3R5cGVzLmggYi9kcml2ZXJzL2dwdS9kcm0v
YW1kL2Rpc3BsYXkvZGMvZGNfdHlwZXMuaAppbmRleCA4MzkwYmFlLi4wYjIwYWUyIDEwMDY0NAot
LS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2Rpc3BsYXkvZGMvZGNfdHlwZXMuaAorKysgYi9kcml2
ZXJzL2dwdS9kcm0vYW1kL2Rpc3BsYXkvZGMvZGNfdHlwZXMuaApAQCAtMTk5LDcgKzE5OSw2IEBA
IHVuaW9uIGRpc3BsYXlfY29udGVudF9zdXBwb3J0IHsKIH07CiAKIHN0cnVjdCBkY19wYW5lbF9w
YXRjaCB7Ci0JdW5zaWduZWQgaW50IGRpc2Nvbm5lY3RfZGVsYXk7CiAJdW5zaWduZWQgaW50IGRw
cG93ZXJ1cF9kZWxheTsKIAl1bnNpZ25lZCBpbnQgZXh0cmFfdDEyX21zOwogfTsKLS0gCjIuNy40
CgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4
IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3Rz
LmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZngK
