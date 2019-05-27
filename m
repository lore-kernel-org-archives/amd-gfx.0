From: <sunpeng.li-5C7GfCeVMHo@public.gmane.org>
Subject: [PATCH 11/26] drm/amd/display: Add min_dcfclk_mhz field to bb
 overrides
Date: Mon, 27 May 2019 15:50:50 -0400
Message-ID: <1558986665-12964-12-git-send-email-sunpeng.li@amd.com>
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
Cc: Jun Lei <Jun.Lei-5C7GfCeVMHo@public.gmane.org>

RnJvbTogSnVuIExlaSA8SnVuLkxlaUBhbWQuY29tPgoKQWRkIG1pbl9kY2ZjbGtfbWh6IHRvIGJv
dW5kaW5nIGJveCBvdmVycmlkZXMuCgpTaWduZWQtb2ZmLWJ5OiBKdW4gTGVpIDxKdW4uTGVpQGFt
ZC5jb20+ClJldmlld2VkLWJ5OiBUb255IENoZW5nIDxUb255LkNoZW5nQGFtZC5jb20+CkFja2Vk
LWJ5OiBMZW8gTGkgPHN1bnBlbmcubGlAYW1kLmNvbT4KLS0tCiBkcml2ZXJzL2dwdS9kcm0vYW1k
L2Rpc3BsYXkvZGMvZGMuaCB8IDEgKwogMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspCgpk
aWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5L2RjL2RjLmggYi9kcml2ZXJz
L2dwdS9kcm0vYW1kL2Rpc3BsYXkvZGMvZGMuaAppbmRleCAyMDk3NWFiLi43YWMwZWE4IDEwMDY0
NAotLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2Rpc3BsYXkvZGMvZGMuaAorKysgYi9kcml2ZXJz
L2dwdS9kcm0vYW1kL2Rpc3BsYXkvZGMvZGMuaApAQCAtMzY3LDYgKzM2Nyw3IEBAIHN0cnVjdCBk
Y19ib3VuZGluZ19ib3hfb3ZlcnJpZGVzIHsKIAlpbnQgdXJnZW50X2xhdGVuY3lfbnM7CiAJaW50
IHBlcmNlbnRfb2ZfaWRlYWxfZHJhbWJ3OwogCWludCBkcmFtX2Nsb2NrX2NoYW5nZV9sYXRlbmN5
X25zOworCWludCBtaW5fZGNmY2xrX21oejsKIH07CiAKIHN0cnVjdCBkY19zdGF0ZTsKLS0gCjIu
Ny40CgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwphbWQt
Z2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xp
c3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZng=
