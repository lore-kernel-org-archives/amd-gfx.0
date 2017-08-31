From: Harry Wentland <harry.wentland-5C7GfCeVMHo@public.gmane.org>
Subject: [PATCH 14/77] drm/amd/display: Fix FBC compilation
Date: Thu, 31 Aug 2017 14:08:09 -0400
Message-ID: <20170831180912.5898-15-harry.wentland@amd.com>
References: <20170831180912.5898-1-harry.wentland@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <20170831180912.5898-1-harry.wentland-5C7GfCeVMHo@public.gmane.org>
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
Cc: Roman Li <Roman.Li-5C7GfCeVMHo@public.gmane.org>

RnJvbTogUm9tYW4gTGkgPFJvbWFuLkxpQGFtZC5jb20+CgotIEZpeGluZyBjb21waWxhdGlvbiB3
aXRoIEVOQUJMRV9GQkMgZmxhZwogIHdoaWNoIHdhcyBicm9rZW4gYWZ0ZXIgZmxhdHRlbmluZyBj
b3JlX2RjIHRvIGRjCgpTaWduZWQtb2ZmLWJ5OiBSb21hbiBMaSA8Um9tYW4uTGlAYW1kLmNvbT4K
UmV2aWV3ZWQtYnk6IEplcnJ5IFp1byA8SmVycnkuWnVvQGFtZC5jb20+CkFja2VkLWJ5OiBIYXJy
eSBXZW50bGFuZCA8SGFycnkuV2VudGxhbmRAYW1kLmNvbT4KLS0tCiBkcml2ZXJzL2dwdS9kcm0v
YW1kL2Rpc3BsYXkvZGMvZGMuaCB8IDEgKwogMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCsp
CgpkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5L2RjL2RjLmggYi9kcml2
ZXJzL2dwdS9kcm0vYW1kL2Rpc3BsYXkvZGMvZGMuaAppbmRleCA2ODA1NmQ4ODhkZWYuLjEyMTBm
ZGQ0OGM1NiAxMDA2NDQKLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5L2RjL2RjLmgK
KysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5L2RjL2RjLmgKQEAgLTM1LDYgKzM1LDcg
QEAKICNpbmNsdWRlIDxpbmMvaHcvb3BwLmg+CiAKICNpbmNsdWRlICJpbmMvaHdfc2VxdWVuY2Vy
LmgiCisjaW5jbHVkZSAiaW5jL2NvbXByZXNzb3IuaCIKICNpbmNsdWRlICJkbWwvZGlzcGxheV9t
b2RlX2xpYi5oIgogCiAKLS0gCjIuMTEuMAoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVl
ZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5m
by9hbWQtZ2Z4Cg==
