From: Xiangliang Yu <Xiangliang.Yu-5C7GfCeVMHo@public.gmane.org>
Subject: [PATCH 3/6] drm/amdgpu: don't clean the framebuffer for VF
Date: Thu, 4 May 2017 14:34:25 +0800
Message-ID: <1493879668-26947-3-git-send-email-Xiangliang.Yu@amd.com>
References: <1493879668-26947-1-git-send-email-Xiangliang.Yu@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <1493879668-26947-1-git-send-email-Xiangliang.Yu-5C7GfCeVMHo@public.gmane.org>
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
Cc: Pixel Ding <Pixel.Ding-5C7GfCeVMHo@public.gmane.org>, Xiangliang Yu <Xiangliang.Yu-5C7GfCeVMHo@public.gmane.org>

RnJvbTogUGl4ZWwgRGluZyA8UGl4ZWwuRGluZ0BhbWQuY29tPgoKVGhlIFNSSU9WIGhvc3QgZHJp
dmVyIGNsZWFucyBmcmFtZWJ1ZmZlciBmb3IgZWFjaCBWRiwgZ3Vlc3QgZHJpdmVyCm5lZWRuJ3Qg
dGhpcyBhY3Rpb24gd2hpY2ggY29zdHMgbXVjaCB0aW1lIG9uIHNvbWUgdmlydHVhbGl6YXRpb24K
cGxhdGZvcm0sIG90aGVyd2lzZSBpdCBtaWdodCBnZXQgdGltZW91dCB0byBpbml0aWFsaXplLgoK
U2lnbmVkLW9mZi1ieTogUGl4ZWwgRGluZyA8UGl4ZWwuRGluZ0BhbWQuY29tPgpTaWduZWQtb2Zm
LWJ5OiBYaWFuZ2xpYW5nIFl1IDxYaWFuZ2xpYW5nLll1QGFtZC5jb20+Ci0tLQogZHJpdmVycy9n
cHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2ZiLmMgfCAzICsrKwogMSBmaWxlIGNoYW5nZWQsIDMg
aW5zZXJ0aW9ucygrKQoKZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2Ft
ZGdwdV9mYi5jIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2ZiLmMKaW5kZXgg
ZTg2OWU2MC4uNmY1ZDk5NCAxMDA2NDQKLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUv
YW1kZ3B1X2ZiLmMKKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2ZiLmMK
QEAgLTI0Miw2ICsyNDIsOSBAQCBzdGF0aWMgaW50IGFtZGdwdWZiX2NyZWF0ZShzdHJ1Y3QgZHJt
X2ZiX2hlbHBlciAqaGVscGVyLAogCS8qIHNldHVwIGhlbHBlciAqLwogCXJmYmRldi0+aGVscGVy
LmZiID0gZmI7CiAKKwlpZiAoIWFtZGdwdV9zcmlvdl92ZihhZGV2KSkKKwkJbWVtc2V0X2lvKGFi
by0+a3B0ciwgMHgwLCBhbWRncHVfYm9fc2l6ZShhYm8pKTsKKwogCXN0cmNweShpbmZvLT5maXgu
aWQsICJhbWRncHVkcm1mYiIpOwogCiAJZHJtX2ZiX2hlbHBlcl9maWxsX2ZpeChpbmZvLCBmYi0+
cGl0Y2hlc1swXSwgZmItPmRlcHRoKTsKLS0gCjIuNy40CgpfX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxp
c3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFu
L2xpc3RpbmZvL2FtZC1nZngK
