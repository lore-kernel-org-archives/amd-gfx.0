From: Harry Wentland <harry.wentland-5C7GfCeVMHo@public.gmane.org>
Subject: [PATCH 6/7] drm/amd/display: fix REG_SET_5 macro
Date: Fri, 2 Dec 2016 10:12:33 -0500
Message-ID: <20161202151234.31267-7-harry.wentland@amd.com>
References: <20161202151234.31267-1-harry.wentland@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <20161202151234.31267-1-harry.wentland-5C7GfCeVMHo@public.gmane.org>
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

RnJvbTogUm9tYW4gTGkgPFJvbWFuLkxpQGFtZC5jb20+CgpDaGFuZ2UtSWQ6IEkyMGVjZDdmNjZk
OTdlYzUxYjY1ZWQ5NmQ2MjI3OWY1M2E0YTM3ZTYwClNpZ25lZC1vZmYtYnk6IFJvbWFuIExpIDxS
b21hbi5MaUBhbWQuY29tPgpSZXZpZXdlZC1ieTogVG9ueSBDaGVuZyA8VG9ueS5DaGVuZ0BhbWQu
Y29tPgpSZXZpZXdlZC1ieTogUm9tYW4gTGkgPFJvbWFuLkxpQGFtZC5jb20+CkFja2VkLWJ5OiBI
YXJyeSBXZW50bGFuZCA8SGFycnkuV2VudGxhbmRAYW1kLmNvbT4KLS0tCiBkcml2ZXJzL2dwdS9k
cm0vYW1kL2Rpc3BsYXkvZGMvaW5jL3JlZ19oZWxwZXIuaCB8IDIgKy0KIDEgZmlsZSBjaGFuZ2Vk
LCAxIGluc2VydGlvbigrKSwgMSBkZWxldGlvbigtKQoKZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1
L2RybS9hbWQvZGlzcGxheS9kYy9pbmMvcmVnX2hlbHBlci5oIGIvZHJpdmVycy9ncHUvZHJtL2Ft
ZC9kaXNwbGF5L2RjL2luYy9yZWdfaGVscGVyLmgKaW5kZXggMTU5YjJjNTE5ZjJiLi5kYmM4NDI0
ZjdiNjkgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxheS9kYy9pbmMvcmVn
X2hlbHBlci5oCisrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxheS9kYy9pbmMvcmVnX2hl
bHBlci5oCkBAIC04NCw3ICs4NCw3IEBACiAKICNkZWZpbmUgUkVHX1NFVF81KHJlZywgaW5pdF92
YWx1ZSwgZjEsIHYxLCBmMiwgdjIsIGYzLCB2MywgZjQsIHY0LAlcCiAJCWY1LCB2NSkJXAotCQlS
RUdfU0VUX04ocmVnLCA2LCBpbml0X3ZhbHVlLCBcCisJCVJFR19TRVRfTihyZWcsIDUsIGluaXRf
dmFsdWUsIFwKIAkJCQlGTihyZWcsIGYxKSwgdjEsXAogCQkJCUZOKHJlZywgZjIpLCB2MixcCiAJ
CQkJRk4ocmVnLCBmMyksIHYzLFwKLS0gCjIuOS4zCgpfX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3Rz
LmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xp
c3RpbmZvL2FtZC1nZngK
