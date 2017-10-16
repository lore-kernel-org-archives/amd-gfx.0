From: Harry Wentland <harry.wentland-5C7GfCeVMHo@public.gmane.org>
Subject: [PATCH 16/20] drm/amd/display: dal 3.1.07
Date: Mon, 16 Oct 2017 16:31:50 -0400
Message-ID: <20171016203154.6401-17-harry.wentland@amd.com>
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
Cc: Tony Cheng <tony.cheng-5C7GfCeVMHo@public.gmane.org>

RnJvbTogVG9ueSBDaGVuZyA8dG9ueS5jaGVuZ0BhbWQuY29tPgoKLSByZWdyZXNzaW9uIGZpeGVz
IGluIGRhbCAzLjEuMDYKLSBtb3JlIGxpbnV4IHVwc3RyZWFtIGJhY2twb3J0CgpTaWduZWQtb2Zm
LWJ5OiBUb255IENoZW5nIDx0b255LmNoZW5nQGFtZC5jb20+ClJldmlld2VkLWJ5OiBUb255IENo
ZW5nIDxUb255LkNoZW5nQGFtZC5jb20+CkFja2VkLWJ5OiBIYXJyeSBXZW50bGFuZCA8SGFycnku
V2VudGxhbmRAYW1kLmNvbT4KLS0tCiBkcml2ZXJzL2dwdS9kcm0vYW1kL2Rpc3BsYXkvZGMvZGMu
aCB8IDMgKy0tCiAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKyksIDIgZGVsZXRpb25zKC0p
CgpkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5L2RjL2RjLmggYi9kcml2
ZXJzL2dwdS9kcm0vYW1kL2Rpc3BsYXkvZGMvZGMuaAppbmRleCAzN2E3NzllYWQ0ZmIuLjlkOGY0
YTU1Yzc0ZSAxMDA2NDQKLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5L2RjL2RjLmgK
KysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5L2RjL2RjLmgKQEAgLTM4LDggKzM4LDcg
QEAKICNpbmNsdWRlICJpbmMvY29tcHJlc3Nvci5oIgogI2luY2x1ZGUgImRtbC9kaXNwbGF5X21v
ZGVfbGliLmgiCiAKLSNkZWZpbmUgRENfVkVSICIzLjEuMDYiCi0KKyNkZWZpbmUgRENfVkVSICIz
LjEuMDciCiAKICNkZWZpbmUgTUFYX1NVUkZBQ0VTIDMKICNkZWZpbmUgTUFYX1NUUkVBTVMgNgot
LSAKMi4xNC4xCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
XwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRw
czovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZngK
