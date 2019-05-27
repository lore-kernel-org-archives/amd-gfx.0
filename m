From: <sunpeng.li-5C7GfCeVMHo@public.gmane.org>
Subject: [PATCH 20/26] drm/amd/display: Modified AUX_DPHY_RX_CONTROL0
Date: Mon, 27 May 2019 15:50:59 -0400
Message-ID: <1558986665-12964-21-git-send-email-sunpeng.li@amd.com>
References: <1558986665-12964-1-git-send-email-sunpeng.li@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <1558986665-12964-1-git-send-email-sunpeng.li-5C7GfCeVMHo@public.gmane.org>
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
Cc: Daniel He <daniel.he-5C7GfCeVMHo@public.gmane.org>

RnJvbTogRGFuaWVsIEhlIDxkYW5pZWwuaGVAYW1kLmNvbT4KCltEZXNjcmlwdGlvbl0gVGhpcyBp
cyBjYXVzZSBieSBmYWlsaW5nIHRvIHJlYWQgbGluayBjYXBzIGZyb20gZHJpdmVyLgoKU2lnbmVk
LW9mZi1ieTogRGFuaWVsIEhlIDxkYW5pZWwuaGVAYW1kLmNvbT4KUmV2aWV3ZWQtYnk6IENoYXJs
ZW5lIExpdSA8Q2hhcmxlbmUuTGl1QGFtZC5jb20+CkFja2VkLWJ5OiBMZW8gTGkgPHN1bnBlbmcu
bGlAYW1kLmNvbT4KLS0tCiBkcml2ZXJzL2dwdS9kcm0vYW1kL2Rpc3BsYXkvZGMvZGNuMTAvZGNu
MTBfbGlua19lbmNvZGVyLmMgfCAyICstCiAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKyks
IDEgZGVsZXRpb24oLSkKCmRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2Rpc3BsYXkv
ZGMvZGNuMTAvZGNuMTBfbGlua19lbmNvZGVyLmMgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2Rpc3Bs
YXkvZGMvZGNuMTAvZGNuMTBfbGlua19lbmNvZGVyLmMKaW5kZXggZTI1YWU0My4uMzM5NmU0OSAx
MDA2NDQKLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5L2RjL2RjbjEwL2RjbjEwX2xp
bmtfZW5jb2Rlci5jCisrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxheS9kYy9kY24xMC9k
Y24xMF9saW5rX2VuY29kZXIuYwpAQCAtMTM1OSw1ICsxMzU5LDUgQEAgdm9pZCBkY24xMF9hdXhf
aW5pdGlhbGl6ZShzdHJ1Y3QgZGNuMTBfbGlua19lbmNvZGVyICplbmMxMCkKIAogCS8qIDEvNCB3
aW5kb3cgKHRoZSBtYXhpbXVtIGFsbG93ZWQpICovCiAJQVVYX1JFR19VUERBVEUoQVVYX0RQSFlf
UlhfQ09OVFJPTDAsCi0JCQlBVVhfUlhfUkVDRUlWRV9XSU5ET1csIDEpOworCQkJQVVYX1JYX1JF
Q0VJVkVfV0lORE9XLCAwKTsKIH0KLS0gCjIuNy40CgpfX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3Rz
LmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xp
c3RpbmZvL2FtZC1nZng=
