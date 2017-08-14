From: Monk Liu <Monk.Liu-5C7GfCeVMHo@public.gmane.org>
Subject: [PATCH] drm/ttm:fix missing inc bo_count
Date: Mon, 14 Aug 2017 11:43:37 +0800
Message-ID: <1502682217-8920-1-git-send-email-Monk.Liu@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
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
Cc: Monk Liu <monk.liu-5C7GfCeVMHo@public.gmane.org>

RnJvbTogTW9uayBMaXUgPG1vbmsubGl1QGFtZC5jb20+CgpDaGFuZ2UtSWQ6IEkzMmVkOTI4ZTU5
ZGI1NDc4ZTQyOTE4OWFjOGIwMTBlMzM2ZTQ1YTk0ClNpZ25lLW9mZi1ieTogSmFjayBYaWFvIDxq
YWNrLnhpYW9AYW1kLmNvbT4KLS0tCiBkcml2ZXJzL2dwdS9kcm0vdHRtL3R0bV9ib191dGlsLmMg
fCAxICsKIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKQoKZGlmZiAtLWdpdCBhL2RyaXZl
cnMvZ3B1L2RybS90dG0vdHRtX2JvX3V0aWwuYyBiL2RyaXZlcnMvZ3B1L2RybS90dG0vdHRtX2Jv
X3V0aWwuYwppbmRleCBkMDQ1OWIzLi5jOTM0YWQ1IDEwMDY0NAotLS0gYS9kcml2ZXJzL2dwdS9k
cm0vdHRtL3R0bV9ib191dGlsLmMKKysrIGIvZHJpdmVycy9ncHUvZHJtL3R0bS90dG1fYm9fdXRp
bC5jCkBAIC00NjksNiArNDY5LDcgQEAgc3RhdGljIGludCB0dG1fYnVmZmVyX29iamVjdF90cmFu
c2ZlcihzdHJ1Y3QgdHRtX2J1ZmZlcl9vYmplY3QgKmJvLAogCSAqIFRPRE86IEV4cGxpY2l0IG1l
bWJlciBjb3B5IHdvdWxkIHByb2JhYmx5IGJlIGJldHRlciBoZXJlLgogCSAqLwogCisJYXRvbWlj
X2luYygmYm8tPmdsb2ItPmJvX2NvdW50KTsKIAlJTklUX0xJU1RfSEVBRCgmZmJvLT5kZGVzdHJv
eSk7CiAJSU5JVF9MSVNUX0hFQUQoJmZiby0+bHJ1KTsKIAlJTklUX0xJU1RfSEVBRCgmZmJvLT5z
d2FwKTsKLS0gCjIuNy40CgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9y
ZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZngK
